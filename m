Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438E565FE58
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjAFJwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjAFJwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:52:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD77343E6F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672998732; x=1704534732;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gTemhgCFpdMpCb/8esHEwsOJgUZEbxegGRzu9RnFyzg=;
  b=clm5fd2tK/H+ZzesR96t1ojxk6QkXAPTRxSU45xRxDZzDGDuSUmKNj6z
   JTO/2oxGyi1vKCcBq9gcmP88Fqr5XZUbC2XuwwYD3dUyJ1yLoKp0EJWRI
   zEGVtE9IjTfYdveMR3PlUgiR/SDNVOuVFjqpgmZZdoLkgO4knBzsJ0z0M
   o5umcjBWYpi0c+0Bri+FX/yXB6BMGF1E5MVt6lbGkxNzCYx16U/nFd7xX
   HIjb9deife1hqikrmfGTYYN+8zUx41cjE4xdxEjcJNBEY2K1VUHj9Acop
   5ZDYHBibKqepwmdrJXZReJhtkcNR8207zAwwYvxchcJhdKVdZjvhynyzM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="408698525"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="408698525"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 01:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="724398245"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="724398245"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2023 01:52:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 01:52:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 01:52:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 01:52:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS1aeBZNVxPcyZNhCht/ENJ/X/95MFCxl9wZXR1PLuutG8qtHQSWxQ8IzDXElwd6NWWalrg0tVJya7IRxHNsn7hsILuI5KRNUlyiHb1C+67eZCcfitqVnQ9aWp3viCbPb9hnYads0/PWhacu4Udsw+IlEb3x8wy65ahTtyFxO6g4Hm/yxWOrw+yMlat2Q42FLHw5mFx+oRmDOte2YiqeaVZgqApqdMUOOWUvu3Fg+0y7l6cUcrSbN7jdRIwCwuSxgkiSJ+/In2y+yRRXclNynhFjfK9nS2342nA0NyzkAXSHlumrvky/xYtrqHqxEw9D6PJ27D3gwkeRSrKNWarwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVs8gBU4/7ocuAOGV/BQXSwfqgaBBVM0VOT96Tc5aH4=;
 b=NfqdRom76TqWbTQIOypWctA84A5TXMd8ZPSZEuBDiZIIPaO81R8EsOUrSgv9Npnb0QPNKxYfMGhiCseYAm1e4e9MtUBjoOkfG0qN0NLu56UCaKCLfZeUrka/c7ObV7/Knh+p59pjufOaE/yo01GQ652S9UvXQFThAHkWnpHlhBiLSQqBh/x5D3lqAnebLCPAJkQt+7gZ2nrOinUeBOu1XCk1K8hvrap6KERm+bq2+3kCF/nC57iDkjzlAjPd9IglWTACTt5cXvihm9L1t4z72WQ32kLVBkdXjb9owRm3ccjdp9RocgCIrl4XqKMBkc/CPOi5MPhj7Qix7EX8KGcTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 09:52:08 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 09:52:08 +0000
Date:   Fri, 6 Jan 2023 17:51:55 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     =?utf-8?B?5byg5YWD54Ca?= <zyhtheonly@gmail.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <pmladek@suse.com>,
        <zyhtheonly@yeah.net>, <zwp10758@gmail.com>
Subject: Re: [PATCH] sched: print parent comm in sched_show_task()
Message-ID: <Y7fvOz9jZPndTDqp@chenyu5-mobl1>
References: <20221227161400.GA7646@didi-ThinkCentre-M930t-N000>
 <Y60WrwuM43HcNVC7@chenyu5-mobl1>
 <CAEQmJ=gcCx1hMf7HicE5OFeUstipdtr=3JkF1JxLuP-CrG++Pw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEQmJ=gcCx1hMf7HicE5OFeUstipdtr=3JkF1JxLuP-CrG++Pw@mail.gmail.com>
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY8PR11MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: d145a337-c4bd-4337-13cc-08daefcbaceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uH/aM+kDKYWCDnkDVkXuVCUsIZV0bvrSYaf9uhraDgyGemK/WqmnPoZ0j+A98UwVcn493AHJeCt2uMtQmpmj+Iosdn4kxKf3vImgtlXC6Nj8XMVVUeFwZ2cLd89okfkFM15JwIVmZhowmi14G5S+6M62KykraafNEGzTDubG9k4/ipX/Xq8+yJ616sb+EvyTmpNDAGyb6V+IJzpsZJmhdWKJ7T87wQGz4Q3V/SRyGFsQClJwsCf89pTRHe4ZLIH41BH+9vO6V73sDEZOFYTlDFF1G5qFZVAhEpkotzz2n1kCxW+4F3oqMN7npWNxVaYWBnbRJwE99NxqY6Z+WpQiiGTBwETpbR8OC+j4PMk1O2AKBklgm/QDXuUZl3ifBA5Y62BWSfKjxlhmKmFGiBb+AnrG4wDVkF/kioNniyaPugDV3fGzVHRL4pYTtr4E1WwT02uyshSwOWoQThjQA71da3Iwp81zekgu8g75DwkyBz0EEka+4baV2RYf6dpqyb75/aa0DtKIs1RpgOhI/HEGaca1r2a5eFpefu6d26ZpJjzZdj5/pbCr7DaF9P/b22naQ6qPh5085hhOWrPuS/3SD6RrTgUd0im17Rnjb2DybdmupTaiJmsptgWe8dBLIAvBcxwHgaYRwaV35dy1iqU49A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199015)(26005)(6512007)(9686003)(6666004)(6506007)(33716001)(86362001)(186003)(53546011)(82960400001)(38100700002)(316002)(478600001)(4326008)(41300700001)(8676002)(4744005)(2906002)(5660300002)(8936002)(6486002)(66476007)(66556008)(66946007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9iajcvbWRBQjRhNUNvS0MwK2M4VnE1Z2x4bnpBcTJZemV5SldtZTRqUndp?=
 =?utf-8?B?SGh0NW5ObEdNVTZpOGZkc1Q3R216Tlp0Y05OOWlybk5uUXg0ZjFrVENkNXAy?=
 =?utf-8?B?S3dQbng3bVJJdXB3RWFpTzVrU25JYVpscWNrQ2Y3RGJNNGxpaW5MRFBkbFlW?=
 =?utf-8?B?R3BWM2ZuS3QxUkd5VzhLbEJvUGE2VDQxUmE4VXp0WDY4SzBsZ3NNVFgyRW5K?=
 =?utf-8?B?TlY5M0luTnMxdVNnSCtQbnRvaU8wOEw2bTRXQVVnNG5NTWZNUEJWSFZhSWNj?=
 =?utf-8?B?akVPcmxhSDFLZnNmaFA2UEd1K1ZWTG9Ncy9BOE52TjYrNnFZQ1VKMEdTSVI2?=
 =?utf-8?B?VU5tSkRFY1lWTlFqZlVIUEFvb2tFTXdUTEpNaHNHM1ZrYW8zUno3dWVEU3Yr?=
 =?utf-8?B?eEF2Q1ZheHFVcThORnp3cW1ZZ0pueTdnT2N4TldNTkU3M1Y0SllxYjgrNG4r?=
 =?utf-8?B?VDVNbEtsaGxIV09DYmdMUGxEWTdoT2luZmtsMTNtMmZMcm5Qc2ZkT1Jib0xS?=
 =?utf-8?B?REdXemUxM1dtcjFwdnV6NnJ0U1J5S0FxMTV2bUtzMFBEbVM0Vi9wVnBQMG9P?=
 =?utf-8?B?bEZOdjhTUjlxUUFSb1B4ZGhSblRpNlE3aEhIdU9MZXMxeGk3UDV3SHVOWWVk?=
 =?utf-8?B?UUlLZDFyZkxrK0ozTmJUWEg3UDEzQ0pGYnNPNm5JR3BiUWlwZHpFdm9lSUJD?=
 =?utf-8?B?QmNBYm5sNmJmWTdPUWg0a2RuVHI1M2hEWXNMTTBFWm4zNnF2bzZSSGVKY2RD?=
 =?utf-8?B?TTkrRExkZGJhNzBZK1hpTzFDc2FsK0J6ajlFNnkraCtFVnlBTVBJNUdUSjJK?=
 =?utf-8?B?UnN1T1RJcVc2ZU9OQTVRZmY3RHgwd3N2VUJFL3VuWkwrNTRxaklLU0grd0t5?=
 =?utf-8?B?Y0NjK0ZRTThjUHdWaGxtWTB5dkdpanJLSW9OZGJaeTEzZGlVZExtSkNxWXVB?=
 =?utf-8?B?cDR5Q1BBYjhSdW54TDY2bHJxK2p1ZmVydDRjNGlKbkFtaEttMTM4OGtzTksr?=
 =?utf-8?B?eUY4SXpmaXhLUzRCdFNjYVJWU2I4ZXduaWpKNmtLTjNSSWxSUUVNa1FCdlZh?=
 =?utf-8?B?THJKZmhhMG1DbUtnSHBCbVVKaW41a1RnMVFuSk5KbWxwbEU1cHVVMlRwNXZS?=
 =?utf-8?B?ZFNQVGxBL0szZW1jbFkwNmtTYTIwajRRQXpxL2wxUGpCQ1kxbWlCMi8rUnBB?=
 =?utf-8?B?VTRweXB1MkZ0M0cvVGQzTkZVY3l4TmQ3UGVnaE80VEp0cFREN2xDbHhWc3pX?=
 =?utf-8?B?dnp0R1NSbEpydEV5dzRvcjltVjZZMUR5Z3VtTlhKRWdZRWtISVFaUHgwYXo4?=
 =?utf-8?B?M3p2Zi9CR3preGRhejVUbmw3QjYzeit6MzUwd3dId1ZwU3JwdVJ1aGttN1l0?=
 =?utf-8?B?NlB2UVQ5ZHRzU3RNVW5GdXorNDhPVnJ2QlJ1NCtCTFRsNFBOR0h0ODhtc3Fj?=
 =?utf-8?B?NG1tN1l6a0JVVzFlcWRzWHQzUE9tOU5rMU9WOEVJL1lweXdMV1RlaS9DbHBG?=
 =?utf-8?B?RHRpWWhHejNwUXd5Umd0QlJCSGF4aFdTMjhWQlAxU3BxMEg4NE9NTVh0V2Rn?=
 =?utf-8?B?cTFaMlJuOUJuOGd3V1M2dDZPS0JaOEhDeUJ2NkVWcXBvcktTdGdHc0F0VTVF?=
 =?utf-8?B?VUs1SFpUSDRwbjBaYlFDTVVCaGo2YUEyN1ZXcmducXBtelRXQ3NPN1pUNnZ2?=
 =?utf-8?B?bjBIbmZ0UjUrOFhOTGRPK1hmN1AzNW5CVlBZYkJld21qdXA4ZlZscCtwQlVD?=
 =?utf-8?B?U1Z3Rkh3eG5XZ2Y1NjhoOGp3aDlOdVg4eHU2Y1dqelNqOUFnUERybGUvOG9U?=
 =?utf-8?B?OCtoZ0lkR3lGV1RnREtVN1BjdlJsWEt4cHlBaEhMdWsvQUtLWnVpRm14bEw3?=
 =?utf-8?B?dXBHTnR1cVI1U05qaHlmekduYWZXUXdVVnZpMHBKSllyTnUwYUdIUnNNc054?=
 =?utf-8?B?akFqTmVUNXdoVk13M2libFptb3VPS2xOcEtvTGw5RDRMYXM5WUV0aU5haVEy?=
 =?utf-8?B?d1JvVllzSDl5Vllzb2ozeWN5dHdieWRJaVd1Q1RxZHNiallHYWU5aXVLQlJG?=
 =?utf-8?B?OGhaWEtlZXhDWUNuUDg5azRTL0dlWXJaMkc1RklROUdKdXg1eFdDOVFLOE95?=
 =?utf-8?Q?6g38zHJNSywGtERBXesrMI69w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d145a337-c4bd-4337-13cc-08daefcbaceb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 09:52:08.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndToKubQFgqXMYP8fpga0PJBfvYNI4SnbHiYkqipBKyRoMVawfNo5wPfwMMt2XEQgOU0ZJJvKjmwqijuoygFeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tio,
On 2023-01-04 at 01:51:30 +0800, 张元瀚 wrote:
> Hi Chen,
> Thanks for your advice!
> 
> > Maybe struct task_struct *parent = rcu_dereference(p->real_parent);
> > and use parent directly to get its pid and comm?
> 
> Yes! It is good to write this way.
> 
> > Maybe off-topic, what if the parent is a kernel thread/worker? It might
> have extra
> > name information such as kthread->full_name or worker->desc according to
> proc_task_name().
> 
> I'm not quite sure if it is necessary to fetch that extra information since
> our sched_show_task() prints p->comm ourselves.
> But, assuming we get the parent's name in the same way we get
> proc_task_name(), there are some new issues I'd like to discuss.
> For example, if we write like this:
Petr suggested to keep it simple in another thread, so I think we do not
need to let extra information involve in for now.

thanks,
Chenyu
