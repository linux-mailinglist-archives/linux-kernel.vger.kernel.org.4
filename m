Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7377B5BB09F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiIPP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:56:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347FA12A8B;
        Fri, 16 Sep 2022 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343793; x=1694879793;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rc+iQeF4Krlr8hbFrCtqg9SWB3n735oCTzLhCJCRC34=;
  b=BXnABXFBuwqo3IhSn6OV1kRPWe81cvcfas7xQJM2OQPCJupSv78E5/2u
   nVOuKVv2YbQnArPXGDPdXtUq5ualpIXoqkm6mGY7u+id3LgcN4cd16qst
   m+abx5poITYubjEUHbal9xBKvdIfnozRJybQN9usxgrpBZVoYBZi/T2AH
   fIsUEqN6Ez6z6GLU6LaKRpt74q1/SRb3vFY9xyjSuzQADZHkGuEwlC2wJ
   uMJM0LIAbO1oah+FVLQRoII4YGVF+Yz3YFxZJTS/zqo9ebahSwfNARqK0
   u10zGetjUdPGHKaVBFBJOQyBD9ppgUeEera4TihNjOmNxFGiGCwNiQrNV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="325295093"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="325295093"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="595292687"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2022 08:56:31 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:56:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 08:56:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 08:56:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYrl2O4X1riU7l5otaaajSVhXWYxFlVrC/vGlDQniIN2FJ7YOYasy3PpbzTGL31lFOVY4LST3+R0Wriigsa9NBqhNtqhbgsqTK8WB1Y8zWsUSEhew5lv+wsSaLc4oGCIAmCVJkAeH2acVMCc+pd7YTw3Cdm+JK9O87TlGmc4JEQjb2BeO30Guv/vV+9/lsesh3HtB8Ajj7TtS33S5NG0Xmn3jK++s5cU4XsfSg7aF62OCovZnVfD5leK2L3zDU2O/rn1ecYpZkZRYkwDfhDiRWs0L+ppTY0PBjKDt62qFBOqeN56A5ji+bzDfD8aZtD4LqIOq3Lex+eyKxJRRmWaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/Na0LSh/03vbhIK38f4EHEwY1nyDsvpnTGIeCgv2KQ=;
 b=jOuFfSfI1nmFXQ3pwtIaLK2EYgy3O/TDAMQVDz6lZJCwfsqXCu5vqjiq0GzBALuj1ftQZ31IDMDFHOpu9GynylYvq62VsppLBopbOMIy2FyIjCuUnJzIjhobjYqMsfU+y9FJ34pheDbJT5JBkYJJkvinW9QlrBW0QRVK1a8JDHFaI6aaMDFzCQ8LR8h4wFsGFa2DNHRDdBFYzawq8ogm7RDfm2gwUhqyscMPftibwpHvbDeaIE1cAdi8ejGUQu60V72T2JA7FI6Ec7O8Jt8PZo0qbLJtjJOdNO7BhQeZ+wV7mZ8lpYpBY29kLaGQ4yKFvpMk0f2VdHF/gzNNNHvIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 15:56:27 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 15:56:27 +0000
Message-ID: <02960d50-6ca3-e64b-8d84-d2234eceded4@intel.com>
Date:   Fri, 16 Sep 2022 08:56:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 08/13] x86/resctrl : Introduce data structure to
 support monitor configuration
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257365519.1043018.5600209070890797172.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166257365519.1043018.5600209070890797172.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::34) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: f208cca0-8d3f-48f3-a39e-08da97fc0330
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmCHnEgAJ/LIKoysr1YFsv3Nb1Jf8Vd7S5e1KdzRf1wcKJiaHF2WZU88RL4TEuBaklncJ8oak+7+R5whFg756IBCwq9RWuQLL4uZTGLk5TuIpD/qNuyIhVNTDHuVTNhUaVo+N501MobvYHhNqcm5XIQeOfFStpdGu5P9GYhZPD8VbaiU/cKXhowrA0ULJwpeq3cRjAT2XUONo3Eyyme3m7krDtUJ64LkVloxuRmcaPhldA1Ps2vkc2/Bpmt5g9JIqzjZeKroNCLFzR+KneyBd0n2ziep2biPnMyJlf2WanyZAIrgW8dP6FrI6amy8/zuvvS7YIGckDXVOdcy357ukzIBS6+ResmWB+s7SKFw98vMkcQDRzo3qhIdJZXtliNtgPwN67B/vaQhrfNz+ASq6roAD7aVur5v56X+oeVv7hcNCrlZura4trD5NUeOXR46MiIZYZB8XVtwHOqTJUu99vlNud6S/WC9SiGeBtY+tTthILxv/qznRzgTK5GRTSut4wTAtn8Vd5CaXqaJBBvbCN38W6sAvB8HajJ2eso8bWqjcFXMHQ2c+4FdENc6Vce0ZcIRaMpeYeiUxFpZRnlEuviifb7Hz7euzBIiJU4KCtN2GmNr+zgGbc9kQX0Evb1oyUAVXx7pnx5AKhFXS1+j+c3C2VBgB0plX+Vdr9mS1w1Bb7nvRLoxb7sJQiGuIjbh5NvaruKzD3Q6FgPx3z1VVgXh0rrwHzXRWtVpgW0fonKfrMFdT3EyFPzD/JRYOwOgFnl0Z1akWl0LRgf9UN27mcg7KtV4r+/EFQgMXYr9aq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(31686004)(2906002)(44832011)(36756003)(82960400001)(38100700002)(7416002)(8676002)(5660300002)(8936002)(316002)(66476007)(4326008)(66946007)(31696002)(86362001)(186003)(26005)(478600001)(2616005)(66556008)(6512007)(83380400001)(6666004)(6486002)(6506007)(41300700001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RTbmVyQm11UWljSFhYSE5BZ0xPblRjZnY0MUY1dkVNY2hkVTIvSlFuMStx?=
 =?utf-8?B?cFlIZi9IQ1d1YS9DSVh5WlFGT1lEcGlDbEIvRWZJZlFBOTdnU0JUYkU2Zzh2?=
 =?utf-8?B?cnVSdTBUVm9KUVZXaE5xN05NRE5FYlFmVzBtbmxKTU5ZcGp3TzR1anlndldW?=
 =?utf-8?B?ZG4yM2NmR1NSUkdFTm9WQzA2TGN5OHg0eXhaSUxFQ0FQMDNYZXJhQlJ4YW1t?=
 =?utf-8?B?SFFCbld1amhBaEhlaC9hTE01RzU4bG5wbWJpMGlUd1ZQTERQeCtTbytGSHVW?=
 =?utf-8?B?MjZ0cGpHQXMzdEFzTDBmNTRYR296M2YyZUp3TXZTeDJVVUE3bVFiUGtiL2d0?=
 =?utf-8?B?S1RVY0Vyam1ZdzdjdU1EWWhJVG9BMHJjaHUyUUo1WlhNR2FRSDRkc3FLOG93?=
 =?utf-8?B?T3M1VU5NYTlDK2xlcHJSb2Rhb0Zrc25XcFdCMTNVYTBFdWtoZXIyTWk0R3RF?=
 =?utf-8?B?VEVzdkY1Mmh3alFkT3orWnU3RzJKRDZMRTlQL0dDYUdMd3ZQellEeC9ScHF2?=
 =?utf-8?B?VCtaeFR4MGw1aEVCb3JlalhIZHNvKzQxM3NjS0NaNFVRcHptZy9OOTNQOGhl?=
 =?utf-8?B?azV1UkJmZzBObWpsdUlSVzI2MFJocVE0N3R2WnlYYmNFRWFmdHBVTTA5SUc4?=
 =?utf-8?B?WjNwcVR6SEwzamNBY3RlTHkrR1M1VzR1SGVRTnZTWjBMdjg4YllvOVRVVmha?=
 =?utf-8?B?SGo0YWMwNUJPM2J2RmtNWVJIaW94Nmp2ZU9xQ3V6OTlFbXIxeHRDQjVSRFpF?=
 =?utf-8?B?SjUxRUV5TUozM2MrNnFWMFJEYTE0dTdjaEVWQmRJWDdwUHYxMVhjVGVWbjVm?=
 =?utf-8?B?ZWNTYzFQMWFLdndDeWdubndZYXNvWDU3WldZYTUzQkE1OUowOE5QOUR3YkQz?=
 =?utf-8?B?RkRRRHBkdE9mZk4rTjdWcjJUSDUwcGdkbXNoeTlXd2kweExwWmo0cTVXODFt?=
 =?utf-8?B?YVN4eDdHdVdKaUVkTTJDblQzUE9aWUk2V1l3L1Q1a0wrUHROOUx1ODVCaldV?=
 =?utf-8?B?b1BJUmpDd2o5ZWFjcGFBeDR3enZ0SVRsZGtuL050Rm1uUWZRMWYzb2daYTlu?=
 =?utf-8?B?QndPQnFFT2JDdE1aQ2JHd2R4aEg1amJ6am5kY2tZbkVQQzZncGlmZ2NuT05Y?=
 =?utf-8?B?blZFdkhPdWFzS0Y0NEJENjdqcE9yVEtwaVBBV0tGWE5XS004ZDI3ZnhSNTY2?=
 =?utf-8?B?OGNDdk54bFVCSDA5bW8ySWNERzkyS0FjUFRxTzJsQVZ4VjZOdTJTNWVJY2VE?=
 =?utf-8?B?SEwzbW9MMDA3eUQ1ZjRIN1BHUUY0TXN4ZnBEQzlFSnFmZy9IdFErRlZxZm9J?=
 =?utf-8?B?N3owRFEzY29jRnJEYmtLY2FXYVBIOUFONDJ5cEc5OGFoTVQ5OGZsUHMwNFpn?=
 =?utf-8?B?bW5RTXpBa0tOejNtUklhRzIxdThuQ2Q3bi9OMUxIcFpoUG5DT3l3cWhPSThr?=
 =?utf-8?B?Mm5lYTFiek9OanBOZ0d6OWgwU0FTRnlMdGs5RDVoSWpjZHNGRVpyTnFockRk?=
 =?utf-8?B?bUs4Y3lqbEVPNWxCTnpONGQ1Z2Z1NXlDZHhOd2pVNVQwbHZITHBUd0laTXdN?=
 =?utf-8?B?blp2Y0lndUkxaW93T3kzMzkvRkpFUGw5V2N5S3B2MW9zWFhMYituUFZ6TnFr?=
 =?utf-8?B?ODIwRXIrMkRtbkRzZWRaM1ljc3dQb1Rvd0J5dDluZEJ3ZHdpYkdWR3d0Qk9C?=
 =?utf-8?B?d3VPVXY0TlRCdGc4YUp5eG9YclpnL0ZvNzkzWElYdU9GSVhoS1orNk1nL01Y?=
 =?utf-8?B?VDNwcGo1Z0xQdVFmM1l4ZE1PTmlzY25nMFY3WjJ6S3lNK2lFNll5ak9mMmRz?=
 =?utf-8?B?NDRDSmZ1TXlmWERvWk95a0tXeFV4eUVkKy9LRjUvdGp0R1JNeStLTDBrbC9T?=
 =?utf-8?B?N3JCczJjdE1IK3pha2NwM21xQ3Y2VWdvMmt4bExweWlIRzN2TzA4RlRGd0Zo?=
 =?utf-8?B?RFZoTEdzdFptSW51YVNBQVh3Y2FDbUU4SnlOdzE5SnYrTkRGWjRHUUdTYytE?=
 =?utf-8?B?OHpqSThDb05kcEk2ZFR6RE91eTF2MVZWZEJTemppcWx6QVdWb2E2M05QYzdX?=
 =?utf-8?B?OFk1bitldmI0Vzk1MFQ0UW5NU1RWTlpTdmxnekFadXQ1a2ZrUXBiclROV2Z1?=
 =?utf-8?B?blh3Q0FGUVc2RlNyZndkeFphampLNG1rMS9tbGFXenhBWE8yUG5uK0FZRVpL?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f208cca0-8d3f-48f3-a39e-08da97fc0330
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:56:27.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0BzqBxdKR6wATHWlaODwiAVOeNOqyRFgMPYsuXYlngJYn6ijCzzO0VN9SHk7GjXiu6PnzhRN2y01YPTRLqTVXdQRefcFhSS5jZfs8bE7GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

(Please watch for the stray space in the subject line before the ":")

On 9/7/2022 11:00 AM, Babu Moger wrote:
> Add couple of fields in mon_evt to support Bandwidth Monitoring Event
> Configuratio (BMEC) and also update the "mon_features".
> 
> The sysfs file "mon_features" will display the monitor configuration if
> supported.
> 
> Before the change.
> 	$cat /sys/fs/resctrl/info/L3_MON/mon_features
> 	llc_occupancy
> 	mbm_total_bytes
> 	mbm_local_bytes
> 
> After the change if BMEC is supported.
> 	$cat /sys/fs/resctrl/info/L3_MON/mon_features
> 	llc_occupancy
> 	mbm_total_bytes
> 	mbm_total_config
> 	mbm_local_bytes
> 	mbm_local_config
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c049a274383c..45923eb4022f 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -72,11 +72,15 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   * struct mon_evt - Entry in the event list of a resource
>   * @evtid:		event id
>   * @name:		name of the event
> + * @configurable:	true if the event is configurable
> + * @config_name:	sysfs file name of the event if configurable
>   * @list:		entry in &rdt_resource->evt_list
>   */
>  struct mon_evt {
>  	u32			evtid;
>  	char			*name;
> +	bool 			configurable;
> +	char			*config_name;
>  	struct list_head	list;
>  };

Please ensure there is no spaces before tabs - this is
a checkpatch failure. Running this series through checkpatch.pl
encounters several formatting issues. Could you please
run this series through "checkpatch.pl --strict --codespell"
before the next submission? The warnings related to code where you
are following the existing style need not be addressed, but the
"spaces before tabs" like above, unnecessary empty lines, 
alignment issues, spelling issues ... please address those.


Reinette
