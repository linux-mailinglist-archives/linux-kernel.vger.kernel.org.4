Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5808E5F6D6B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiJFST0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFSTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:19:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BE9AD9A5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665080363; x=1696616363;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nWOJVhLPVeSni3lUtQh+omJhUA33rDTWtOXPiXuyZiE=;
  b=LqSlSr+d5PQ8NSL7/wBFSHf4W3aOO8SsJj+I9EnETsUL/rD1FdfR0MVk
   S5vEuBXWpMhNaEHBUpKbUKs0Ejc8+gcs6XiSdBh2WIoE2xksfNYOvxP43
   kcmYFx9HPRDF4UD7LoDEA4GB0wjWW8cQFJHmZip5oCZwid/oMlb9sfB+d
   5iVxFGii8roz/KkwvtkAA2XiaFibD7NWISPR8JvJ9wKXx0pA70HCdS77K
   jmiyi2oL3P3f6X1uF6m5phwdW9dioZsUwpuApjmB4j/QWcnW9LbWUFwbY
   I4+MN1aH5+WRWZsTpEaN4HZU1FFdgQ+zDfxqdqa2owQYjA+FYTUzcedo6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="329961013"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="329961013"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 11:19:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="767255252"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="767255252"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2022 11:19:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 11:19:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 6 Oct 2022 11:19:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 6 Oct 2022 11:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1rYE0Z+8vMdQ/e7OmNme+Fne3uMugKPppNnHQPsTr2w3XTR8sZD3sUiBtpwKPh/HCe6w4R6o/sfjIXgp+LOoJWWGnL1l/aaSMZczdFseMRPYdO0CtdwvzMbrndOPAO+QGGWCQRBXo8JpLqXwMKHwyP5MCk1xdcXYKa3y7vqZEvbYEapRg+q6Yj3W5x822Ej4mnZHm4BxX22TLzuV4AUK5ea6NOlDg3+UN2HgOWNZF4A9S/F7vLt+5wuWNf+d2f6TxFCZhnI1tq9yHpseLApXLzsEWo2C31+XfRjXGTHtKor7yzzT41DpolzfsHO5EoOcl4aB3GMH8WigJ5ddxFN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS83bSCHnrbwpxJx3oh7BX8XsdOT6OKxayIf84BYMDc=;
 b=fQ46ISaVBVjQ5WvdCUh2gPAgxfSsSKkpl6I03bBTfoFDxGJARqKqAeZtnmZWejYv00xiXUzeME44nUb58rgmrNSeFHBpDSMvBuPN84tWaFkqCnRzzqv5warGxlmkDHV8NjtgQnM8j0NeMdjuzMG3GcAeQ1RAbVfZBio9IsfnZQKswO3ZmqrZInuygIcHgzV5P1OD6VjZ1j32xlzqlarQvDAYMKv3qrrEWdXiL5whyfCCYyknLiP+MfA4XdswzFpiyFiiKG+XoRBYvRELEm32JBJ7+wGCxjY5JGTiMg0swycXal4zwN+QGyKjDaypt1CDkdDy6SOARNJGsw4H+9NEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6727.namprd11.prod.outlook.com (2603:10b6:806:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 18:19:13 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%6]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 18:19:12 +0000
Date:   Thu, 6 Oct 2022 11:19:07 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
CC:     Phil Chang =?utf-8?B?KOW8teS4luWLsyk=?= <Phil.Chang@mediatek.com>,
        "Jens Wiklander" <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Message-ID: <Yz8cG6OAXvK48vc/@iweiny-desk3>
References: <20221002002326.946620-1-ira.weiny@intel.com>
 <20221002002326.946620-3-ira.weiny@intel.com>
 <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com>
 <TYZPR03MB65279558CC22F5130B710EA8FB5D9@TYZPR03MB6527.apcprd03.prod.outlook.com>
 <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com>
X-ClientProxiedBy: BYAPR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: d1db75b8-f40f-4867-dfab-08daa7c7452c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /B11GOjhdqg+7PBF53bz3oOTPDVpoisjJSV5sbPQo+qmaLVF9+kqRQ4VMh92MT/jZFqbq+aQMq5Yzywb2Zn1J8LIHJggf1i3pxijYMgLK/LOTdFehvzGsNSKLjAyWYkVWVXdVY0z9bgv7/cgzg6diqihXNXVPedaELLMVUStG32GumYBWtQpQ4MQTgOTw2oNX1kSCtAFgk9LbjiRtE1JboPTj/gfaOSHCD9EJtZxtVwWWqWUXAokihyqTFZr/hl/Ecu4YEjxHiif3vnryC7do3LpAlFWXswTi/1OSq5AY7V3Uy8QafSR5uNh1Ojr6mCKzsqSB4UjqZXmr4EOCMDmGbmdE07vWIXrrNdnuL8C9vxLyyC1RKVb8lrJDunfaF8jcnk4i820txVQ/2NTI5B+hKecacS5c3izxTq8f2NPw4qciOcVlP0wJgRcZNLxxjGoNRobsMyQsC7zz3wpprz4xLCmcqceoob9OtXjDQ7g6aicXKD9pQh1zvm6/alldoPV/WyvAmg8LVTvX7FQ9WqWe5lHfcyVF6U8t/7H6aWncIDQ35nQSH6adgMOpeX0zY63mQIrHtNZL7QG++y6+Y1Yd1j32/t50CysX3R6ypvpadPdWs4Z8NNHzuNgh3rzsAWV9LkaVf5FYIWvJK1lS7b8aERRfYP+gLRXPwFqVVOqcn+GBUWsIS2KYO+t44kxlq42shfDZ54ePGXd+dUeQaA6vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199015)(26005)(66899015)(186003)(9686003)(6512007)(83380400001)(6506007)(4744005)(6666004)(33716001)(478600001)(6486002)(8936002)(5660300002)(86362001)(7416002)(44832011)(66946007)(6916009)(66556008)(38100700002)(54906003)(316002)(8676002)(66476007)(2906002)(4326008)(41300700001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjVOaTlCbEhQT0dvU20yMWZIM2RIVGQ4OGRDNGtVcDRJTnI3QlZCTGo5dEpR?=
 =?utf-8?B?Ty9zSWFKT1dncGZ4TWlLcDFxREI1cGQ3RGpKVnBoK0dMcGxrbG84RWVIeEQz?=
 =?utf-8?B?OXJRRkZVcFhUbmRhUERWdUhwLzFsMEo4VG5GNEp2K0ZEbGM4YzJMdzJ4WXRp?=
 =?utf-8?B?bGc0MUVFRmVxZ29pVTVoM05QVFVsRXM3SnJVMXBaUWlkUTJvYjFUU2dldW5M?=
 =?utf-8?B?L3hGaEF6N085b3BuSnBBcHdqK0FRY0FBOUpPNUc5d29uMmlpU2R2THhNUElV?=
 =?utf-8?B?K3lSTWR3dkNpM1Q4SjRKT3R4NktwN1krTVhYa2hoVnhpMHFOakYvb1I1Wjlz?=
 =?utf-8?B?MkNpbTA2Y3VOeFhEbEZUR3BwQ0F3NFZsdkNvVG1XYWJOZzZoRUl4c0VxTjhR?=
 =?utf-8?B?aVBXR1dMOW5FQm9UQTlXL0NuWDJCZmhQalRYbkV3cmFuWjhwUmhHTkw5YnVX?=
 =?utf-8?B?R0tnakZib1FuT0lSeFVIdTNBOWJnd3ZLOHZkRzZFd0FrZ2hJcS9rY1BtRFV5?=
 =?utf-8?B?dkhwZTVJTmZ2Tk5YajFCOXRtckFRQU5uYzUvM25wUTRqUmg5VDEvNE41a3Ew?=
 =?utf-8?B?WFlJZGpIZ3lqU1REcXJ5ODRlMVN6dFVITHRTVGRQMlAxQmVReHhEQk9TZkFl?=
 =?utf-8?B?YWtkT2NTSlRmS1A1ZXI5S0NpTVNTdTJDM1JXYktmSlo3dHFJcy9RN0kwcnlu?=
 =?utf-8?B?MmxtVmxjOFk4UVZwSmJXdWxRLzFBTUF4cnFJNklMYVhXMWRLaU1SZUNXbFIw?=
 =?utf-8?B?T2VaeXBHcVJqNVVCUm5TQU9sVVZ5cDhKRTE4YVBEU0Q2N3E4NWtMY054ZnR6?=
 =?utf-8?B?eXZPUlMxbHdVUVVnN3hDc3l3d1U3QjNQYTQwckFJSElCRjdHV0ttdy8ydDk1?=
 =?utf-8?B?QlRnOHpVMERZVk9pc3pFT1pHSEx2WEFRaVc2R0xUelBnNXIxUTBzNCtmM2kx?=
 =?utf-8?B?cytmdXdjT2YxM1RtVjRma1RBbVJaMk55QWxudFM5V1AzRnNoaUc3UzZob00y?=
 =?utf-8?B?emNRNmtBSnZJZ2xnS1p1SWdWMzhxaU15b3o4V1ovY2pzVHk5WTZjUHJHeHZ3?=
 =?utf-8?B?YWNHWTdFVCtUTTB2STNYWXF5TG1lWUhqbGcrV2lYSHZ4UjRjOVZNVGNpeTd4?=
 =?utf-8?B?K2NSbERZVjQyRFJsQ2JDOUFnUE5vU0lTbHhKMmVhSWoyL3pVZ2xtRWtyY1Jq?=
 =?utf-8?B?eW5XSWZTVTlFWDZvckxQZUlvenZDYk9mWkNJZi8rc2JOVWhCanVVcUs1QXJK?=
 =?utf-8?B?VnBCcjdTNEgwcitObVVVd3VTRGQ5R0tBZUZJVTlNYlJFQ3hucHJzbURqNFRI?=
 =?utf-8?B?U2g4aUY1eEkrdGNWTGlTQktFTWx0QytYeGs2NmczMUxldmdCbVo3bDhOQ2cv?=
 =?utf-8?B?YkpiQ0VqL0FCdkFoeDhHczRjUlpqd1hUSWRMQXV1ZXpsbzNzMmtEWkhFeDh4?=
 =?utf-8?B?RXFSRFN5b3pJckhaVEFPRXBxa2pKU2lna3NNM1JmTytnbDhma2NDS3BGbnVq?=
 =?utf-8?B?WHFQWHk3OFlPcTlxTjBmM3gxdm1oMlpwY09lZ1oxZGdxa0JncG9SRitaS0ha?=
 =?utf-8?B?dE1aZHgycGJXVVBTUlltR2V0RGR6R2JBN1UycVRxQ3VEQU9INlNHUWsxWUEy?=
 =?utf-8?B?MWFHTUJFQWJGbC91QVpUczc4a2tpd1lqVXNPdWkzQmFWY2JPclByT25hUnpq?=
 =?utf-8?B?RWZLcTNuR1o0UThwdlZ4SlM1V0dVOFZjYndJQjAxOG5tSllGZW9BWVR5TjJP?=
 =?utf-8?B?elZhN3lMZmEzR2VjMHhMT0NwaFNUYUZmL3dxQnJwRnRseE52ZlZvWElGYjRn?=
 =?utf-8?B?b2pEQjd1TWNnUjEzblRva3VLRTZrNTM1em40bjhXSHVXQlVGcmdJaE9INk9y?=
 =?utf-8?B?bG5WZGVlWFBSSW9HbzlMRzRGU2xTaWNESnF0K3lvaDhuSEpKSnI0bFRHKzBL?=
 =?utf-8?B?QVJBc1NSNDBKbmNUang3Mk5wSlRUcFNQejloeTZZS0hSQ2dhU0lnKytCZEtY?=
 =?utf-8?B?T3RQelFqbFJGZWZXZnFZMmhvZTlkMTA4am9kNnJNRnNaRXZkWm1BNDQwOUdh?=
 =?utf-8?B?ZDFpbFVLcnRqT3U2SFJ1alN6YkRuL1AwNG84dWxpQUhtYm44T0JTbGFmZC9o?=
 =?utf-8?Q?DT5qrAJnqPvcaRRm7lIe5rifw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1db75b8-f40f-4867-dfab-08daa7c7452c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 18:19:12.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGfp0J8OBhYKtKw79vMZtSkP/YdpY5NT63yQmlV7mNCIUnUGcrEdqdoZdDWhC7W/STYBIMG82owedz3IpMWnyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6727
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 11:53:55AM +0530, Sumit Garg wrote:
> Hi Phil,
> 
> Please don't top-post in the OSS mailing list.
> 
> On Wed, 5 Oct 2022 at 08:59, Phil Chang (張世勳) <Phil.Chang@mediatek.com> wrote:
> >
> > Hi Sumit
> >
> > Thanks for mentioning that, in fact, our product is low memory devices, and continuous pages are extremely valuable.
> > Although our driver is not upstream yet but highly dependent on tee shm vmalloc support,
> 
> Sorry but you need to get your driver mainline in order to support
> vmalloc interface. As otherwise it's a maintenance nightmare to
> support interfaces in the mainline for out-of-tree drivers.

I agree.  It sounds like this driver is not going to be submitted any time
soon.  So I'll respin this series as is.  But I do have a couple of other
things to deal with first.  So if I'm wrong let me know soon.

Thanks,
Ira
