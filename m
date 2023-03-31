Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCBC6D2BA8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjCaXVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCaXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:21:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C871A460
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680304879; x=1711840879;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MzpFq9Ltn2TpG6RfwmCAcgiX7z4S4gPMrnX4tZcjhtU=;
  b=RzRlIscfAX3KteB98il1x6rrV/PJRJjHHf6KykQrP2gq0mla2brauOJ4
   X39/PcIi5XWfRlA9d21cmTaDXFK8qwMeRPXYKgfb2dL7qylrCy6HVLQiN
   3B5F5Pga1z0E1e3yqiezF8YnaYza2asaGrVfqHqshCVCgvNrFeTZE2/Te
   bRIaLUlSMDMn23/nF6yC4yyYYjEOW3RN1y77IPnsAjF2J2A/cFbYSCIKp
   7jqkMnfzZCGurIo6lazjGRL+UcHn3AURGLaCqYPBwJ66r/RBmgsRj+mSK
   mbVhpkjBcGA3MD4ypDXCReJ8u1HXAQt2fBR9L5NusC5EyO98RlGwJ8cgm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="330123841"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="330123841"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="774524479"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="774524479"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Mar 2023 16:21:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:21:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 16:21:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 16:21:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWRhCNbWk5jZLh6RO7QqaIK6qDJZ6pq1zEBfZQZLUegx+KLkaGOHkJ24RtHfWWuiB690/S2pmI/ln9ClRyKqhtzwKev7DQSs1ORludsjjwPD6Tz0dcwxqD15+LP3E1j8rTmWq1MEMcWgnE26ATHvVHbxRHjEl+qQvCaxAGfKx/BjRpvIptq51eaMez2IvNA6ZpUFVzh5PIHdnr93sb/TLvH9R8WacSgeqpQCysl+HdeNga5qi6didgwQ/D3EW9ZokHvjTTH3eXly7bvj+w1LtM89vTNMtKoQosEaWGfygpDsHG4/OR9nVxIaqjjevGFUweI4gORNoU6Srm1o2CXgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUl2pM5gW8EJwFa7ITHjtKFXkxu3N16RBpKoJummRnc=;
 b=TapbrhRAChfpGXdbXBjOPhW6EC9AT+9pohAwQ+CJYNumPVPll8671ly0h8ZBmwZQ7rXZJmV/wM0UHazM1W9NBpTVhrBFdZwwByGl45QF1fYg86DbOAf+xSQIjF2NOoPWwXfXpE/YioKuRHM1aPTYymc3a/NUpxxQ6J9ceCBbWHbJ2Lb8r+/VX1eO6/bwCkZ4vBMFFLzpiUq/DTbYPRI2oEEfENA91RBSe51zSnfCYnvRmxfVJkeV+RerYXZm6HhXj8K5WDX9mntfjYanL1Cs30YUqaBG55VN4Rp9Btd95ZJqa1i9gkblnwW4IA69MwXXwii/94LbjXZI9iWynFFZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 31 Mar
 2023 23:21:16 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6254.024; Fri, 31 Mar
 2023 23:21:15 +0000
Message-ID: <37c2371c-11e6-a2ef-059a-1a0ba08c2f67@intel.com>
Date:   Fri, 31 Mar 2023 16:21:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 06/19] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-7-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230320172620.18254-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::19) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d076ec-272c-4a99-0ea7-08db323e9f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PRflHRQxIn77kr3gqFwIVdsuzDk/aqrWhoZWJptRdRxHxd04fRmZkiH5KuzHsEUacrd5T12AsHMjskdDaXcffOkcQIHLbK36F9cQ2lyPbUWHDibBg+CN528ZiTpK9vJJwZRHEwmtyFPM68wrIobpf6gPLBxs6Dac/eriaOSY+N5TDz0kLtjMCAI0BDsJ617mY3fzp9gaP1Js2oS/hLJ+io7sWI8kR2Hc/VG+raf2Kuvco0UNK9umOyjcEL/sUxNaKBHUOXwq9tLepPI+V7n66WpF5o3JsvzL8a0oH83H5rwWlK9Nn2FmTLXW4S5IEY//9UR4gLTv1nEJhgHbOZxiJan63+KGCFqAMowI5tvehZYdBTGjPCQsonKpwJR2nrrHLzlk1IRPA1ojiVNiVI0OOGNUGuZ3z36LgkEBhcJWfSJ9Gj4w6dJ3T1TJaJIbohryJQ2xT17Xwhn9nIiA/Q/lDe5oAmo9Gv42PIkZW3AXHRrlyDdgDtOp2dS5B4qQCx1RhpRWRXeG3BCf3aSvSbYgPFiSIWIwfiCeRanTwRG5nJib8JBgks4qvUQ0DFR27jgZJtnGivgWPzWTPXhYX9UjbfC/68Ay9w49l2tibzgFXf3Ob00dWQZAW+YYd1zXBxMCiKtOEeqBQjgNqI0IOnKPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(36756003)(66556008)(44832011)(7416002)(8936002)(5660300002)(6666004)(2616005)(478600001)(8676002)(66476007)(6506007)(4326008)(86362001)(316002)(26005)(66946007)(31686004)(31696002)(54906003)(53546011)(38100700002)(6486002)(82960400001)(41300700001)(186003)(6512007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUJKOHBTV3Jtb0x1alVvdWRJOHdVWVNLaDk3eVpUZDRGVmlaYVUxZXBURE5Q?=
 =?utf-8?B?Y21hczRkL2Y2L29aRlNwUVJkVmVYUkdhTmNKaUpYbm42TzZnTmY0dEpNT2xv?=
 =?utf-8?B?d3dXa2RZelU2SjY2ckFaS2VmNnJyazh0SWx6d3R5SEd5azRCVFBRWDdwU2g2?=
 =?utf-8?B?bWJlb2RMOUlpOTV0Qm1zbkVVUEx6dkplN1lMMW5NT05uQk53YTFSbHhCUmJr?=
 =?utf-8?B?dDR5d1A5bUMwNHNxS25xNTZMRU9lMjh4ZXFUbWZFTkZRUlh3Vng5VGM4USt0?=
 =?utf-8?B?YkpmQlFwb0dqTzJibWNWZjFmQmd2azJ2M2Q0Q3M2UEwvUE1aQnNJcVl4STJH?=
 =?utf-8?B?WVlYZkw4bzhHOW9RL0hiUnI0akJoQ1Y0elJjVCtUWDVrNUhiUDJYUXIwRkVx?=
 =?utf-8?B?dk55RlFQWktGcW9ZZllsRW55ZEl4VzNvUnAzRVdDY2FVQ3FQcEYwV1hscXJM?=
 =?utf-8?B?SVZBeldMYXJCeGpsT0tTN0RxcW5STEk1bnc1M3MyU1V2N1NHUXpBZ1Z0YS9k?=
 =?utf-8?B?TWQ1cWljL0szemVadVh2K2tBQk5RSXFnWnNEVjgzT2FtUDY0MFIrYnNwRXJG?=
 =?utf-8?B?SFpjdHU0NUw4eWZjWDZncW8rcTIyQVB0YkVyaVlWZTFkS3pXcWgvYjFOUjhD?=
 =?utf-8?B?SWprZ1g4U2FOWlpjTzhwODVkS0FEWithY1c2S3dMc1pNRkpQb0hZY2ZXUDBC?=
 =?utf-8?B?Zi94RG5LRjJ3UTJyMFc1RCtadzFjUTBKM0NJY1RrWndNVTluTGlTeDVKYXdY?=
 =?utf-8?B?aXhSdTBuTHhQcUQzUithYVZZdy9IMUhPZ0E3aE5IYXFNQ0NQZFg4YzJSQmN4?=
 =?utf-8?B?TS9OZ09ZUTVvLzVybDFPZ3M2NnM1QlZFL1QvREFiTWdZZmdlazJhaFFkMks0?=
 =?utf-8?B?ajhvVDN5eml1M1p3UVcyVjhDb1dXYkFEWDByZ2htTUFsVE01cmVGRDFEbTNl?=
 =?utf-8?B?U0U4bGIzM3NtTmNHRUhBLzBoaEorc1I4bElXcHQ1ZTBIeTRHQTRMQjl1ZGdB?=
 =?utf-8?B?a3R3OEVKNHJOK0Fxb3dWQy9vK1EzWGxVRDhQdktGbXh5czZ5cEpIWDNpTGVU?=
 =?utf-8?B?OWVkZlZyMU1FY2dZckhNT3Z4M2xqSVc5MWxkcHc1QWZqOUY2RTdwQ3Q3SXBs?=
 =?utf-8?B?Wk5PWTJhMGJtUE4rOGFBWVpqcVRSNVRJaTNGOWRhOExVMlRYM2VDZW1GdnBN?=
 =?utf-8?B?TDR1dVVma3AwN0ZoTk1YWnpURWtHWDZDd2pzbCs2OFhiUXJuY1NBMlowYU5y?=
 =?utf-8?B?cHBZOUhuZXNaS3R2MDFDeUxiaHIwS2Y2N0krcWhuZEtVVDZ4VnppVDZ3NFBO?=
 =?utf-8?B?NjlWZ2k0a05ITlBmZ29SMUxPTG1FVUM0ajdBRzJuVkJWT2E3Q1RZbmRlVEtq?=
 =?utf-8?B?U053RmQ3bDNuZkxYMzVNVkxGWXQxU0JldTVKbTgyWWl1ZThTRFRJeUlGNmpD?=
 =?utf-8?B?MkJZVDArNEdvb21RaUE4d1N6VWMzelVmUGtEeU41YjBvRkRybDBTakZrU3Vs?=
 =?utf-8?B?TzdBNHlNcDJDOWwvTndBa2ZldHV3WVNVMFFBMjVER0xWT2NXR3pzVzNtdjdr?=
 =?utf-8?B?bzZqVXZDSmN2YlVka01XWncrMEN5a2MzSTlPZXBpNW1tYldkWVlwaGUzTnVw?=
 =?utf-8?B?c0cxMnFTSlduZ0NQUklEZlZBZ2xUMTRsU3A1UExjOCtFQU0rM3BWRWRLMkE5?=
 =?utf-8?B?TmNXT0owYmQvM3Y1cHE3aFl5WnBQbTJxSHRYZ0pET0V4ZW5VOXFSVnZQT0tY?=
 =?utf-8?B?cHlzcWRsVjYxV0ptNWc0TVFLQWVkNjY1ZTV5cTJqWlVOVERGUGxCdSs2MW03?=
 =?utf-8?B?L0hseWRCWUJMWmc3VFlaUk5hNnhrR1NGRURQM0x1c2dIM0pDYzhZcGFYMWtm?=
 =?utf-8?B?eVVPMTdGSTZKVCtNQ1hSTklxQWQ0V1dLSFpvOU5ENXovcC9tdlJJUTJDS1pn?=
 =?utf-8?B?Rmt5akV5NjdSNXd3ZFZHem5NR2JJUExrTUJnR0p4MXdlbmlxRDFGODNtalIw?=
 =?utf-8?B?WUUxdDMzYmRJektncHR5bjkzdjBJcWpJdWN2Y3ZwUFg0MGx4NTZwZkcyWVB4?=
 =?utf-8?B?MkNBb2YyM0t3RVhBUUlYTUg1R1ppZDlJMHFSZjl0WTQ0ZUE5WTRib3VjMnBF?=
 =?utf-8?B?b0N4WlJxUSsyZzYwV1I4eGxLWHA5MTkyNEdabXdRdzdUblk5ZEJRVjJwODZt?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d076ec-272c-4a99-0ea7-08db323e9f9c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 23:21:15.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2buoBQMKlqlTM0IcfFC1ZZeNbQOL/c41olWBKsFqIxz/O2WWEb2Hcz0vXrgmzEUQpGLsHCqhkueWYWGAGxbAhhjx+38eJc24oennimaUCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/20/2023 10:26 AM, James Morse wrote:

...

> +/**
> + * resctrl_closid_is_dirty - Determine if all RMID associated with this CLOSID
> + *                           are available.
> + * @closid: The CLOSID that is being queried.
> + *
> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
> + * may not be able to allocate clean RMID. To avoid this the allocator will
> + * only return clean CLOSID. This is enough for now as it allows MPAM systems
> + * to use resctrl. This suffers from the problem that there may be no CLOSID
> + * where all the RMID are clean, causing the CLOSID allocation to fail.
> + * This can be improved (once MPAM support is upstream) to return the cleanest
> + * CLOSID where PMG=0 is clean. This would allow the CLOSID allocation to

Why does PMG=0 have to be the clean ID? 

I am wondering about the use cases here. When a new CLOSID needs to be allocated,
would it not be useful to instead have a utility that returns the "cleanest" CLOSID?
Instead of picking an available CLOSID and then always have to check if it is
"dirty or not", why not have a utility that picks the CLOSID with the most
available PMGs?

Reinette
