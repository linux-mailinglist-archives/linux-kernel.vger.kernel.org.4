Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C91D74B8CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjGGVq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGGVq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:46:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE71FC7;
        Fri,  7 Jul 2023 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688766415; x=1720302415;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iDc1TfJVPxqNIVXiNZffi6vZlOsYgJKRO/Ob8ofSXzQ=;
  b=bJ8SbXhts9V5w4GJwcQG3iujRkEaeRU5WqvbAeRkHercosJ1EAU9zgrM
   QH1+Zzo9DqV+vlkXAvtCO+Jv0aVcMtyBs/mH7sVrIUKrxNS2yUnA81okK
   c7sZhW7cxNAV3kfJx4yv0yhn8BIgIprIOtRE9jbLQINUuyQAjBFZJebfK
   HY2K7Kc3K7q/gdkrHSL/xxhunTDi0eObh9CERlcVaXw+XbpYp7r+dE83x
   I5xzvoiJUtWp+tpnwU7xUr3mxolnn83bGwbtHH+0T8WqJBzfbg/4u9Sow
   nEhJkeBrMQ3CnXUsh6Z2n/lfSVW+In/B6Ig3CHhLOLfrKAYDrLgvWMOHd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="450345638"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="450345638"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 14:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="755331728"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="755331728"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2023 14:46:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 14:46:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 14:46:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 14:46:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG8dzWJPvwRGhRfDFrLgN+Zc7W92aHbFI5VF+0+qUJiOVJTF9qIdq3wnBnvVKOBmxVEyPk4yjgFmp5C0XHBlLmMrp1NeXJvcSi3JpH+BInuZaKtvdUXkx/DS+Vn8tGsq+nhagLRSWoJ9aQpcr0SRlsR76uN7wCuReZkzEIoXF89ucj5Vf5lI/a7w1zskERv6qANuVtqU1G9GoyzbZxfr7jEtOZnl8tVoR0KIicn1MZrqDlBBxIDmM83yz1SKCctPpT5s6oCg9LNBzzZ+5LWkdPfrYXXee6TKofGV5ne/UnDY2EtZuJrxp1+9Eh2mDJxa2BnWf6WWDdRUSmQBex5YBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOsk03wTg29sXmiz7m+13dhCWVRnAFMJa9i+pZaeFA4=;
 b=iZZus7NBJ86JzxUH+/l2/AmOTjjcdJp+1ErQ/7f4oCEj0ahE0/+YhVLmGI2GITzvfcrr49eg6liYduBwrdGwrKqlwz5d3ShOEgelbO2ULimY/xEGsZFtwLaouzkz2nc8YaQdYH+bjEp4EqRzAmIuC0dYLFbFUYkVM0t00lOv/XMAaEY1ObrhatMiMggXpMLS9P7CvhP3hKrR8DpuxPRoQdCmYJHz7LlPvpmcQidqsvAcZJrjvoIB+b+r4ZQ+RmQSgTxmyDsyZswasi1szNZWEIaoEwbVJs1XtPJBlGjS4f63vgRZwd1Dqk0D+wT1w0GX3y3cQgg9jioJWFIjgOeW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN0PR11MB5696.namprd11.prod.outlook.com (2603:10b6:408:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 21:46:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 21:46:45 +0000
Message-ID: <9cb1a07b-0e17-d930-263e-5433952cf241@intel.com>
Date:   Fri, 7 Jul 2023 14:46:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v5 7/8] x86/resctrl: Move default control group creation
 during mount
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564612103.527584.4866621411469438225.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168564612103.527584.4866621411469438225.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:303:8c::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN0PR11MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: 407f81f0-c689-47ca-8491-08db7f33a8eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnva13/rvNGSrEVAHXUtzK48ohbFj39ZuEOB9yfv1faYp367Fu5ObRbUSu1vxiffLnquTv/xJ4NAl0uviDIgqSY788w9+Ulz0JbSyqo/p0IPcIowxpbiy0yvOX9EJ+Hb1o3Jgi50STDDiq9Lv2xLPBtSRXhRYfwEI6FzbAvISlPK2j6DW/t/0PCq8DQqsaZ1x4tafwdnC1uMUblzBAvZckvBm8nPKuv8pUsVLDLBGer7BpOnLsR2CfgdbXXhA7EPLuH6Uj4P4fq6vNmS5IXQMWu2HYoQJ0Vs687DBaWki0J3DLh5KhSB9kbrlnoapm6OsZ1ghNpyRfUnzI4FiuKy5zCEdQqZbpEtXQydYp/zFbr5Cjb45tHnAkqxTB78DeidQDiFj2qq+sRyCBLns/qg6ZT9LjoTM3vnVov9kMF9Pnx10cV043SEOZ1mTJUCC0J9FKPoeTiipJBGyfkoOF0Otttwi/LzlsaHi2HymXNNrHFaPSSVQ2IFlIpVlYypT5g1UpTKE7a6/1u7big4NTLLSsZ4TVVclMemjTbYbqKgUcDZ8aYIi+QLtPXhv1w1eIdaMleG2o1eti24fw7BWpR5h7MW3OpNRucPgWNaAlJAggtfwoptpc+2m5uqB0rLP7+PhHetRWKUt22doAJ5oPpzZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(8936002)(83380400001)(2616005)(2906002)(6666004)(6486002)(4326008)(66476007)(66556008)(66946007)(316002)(478600001)(6512007)(186003)(7406005)(26005)(53546011)(6506007)(44832011)(7416002)(41300700001)(8676002)(5660300002)(38100700002)(36756003)(31696002)(86362001)(31686004)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW5OQW5salgrVmJXTmU0N29GMThEeUg1S2RUMTFQMDcxem9WZlVYRCtlNlY4?=
 =?utf-8?B?aXZzbEFwV2dPOENHOVE4YTloYnNWc0w0MzJWKzJsUU54b1RzQk1DNmZhUSt6?=
 =?utf-8?B?ekxJRENwMFA4Y2w1Y3h5WFdmUDF1VWM4Q0x0OXZKaGxGd0dsdzhLTXZvd0Ey?=
 =?utf-8?B?MHJpZXYwUytlMHJFTk5kQ0NpV0dTUUhMVkZoZ0RKMVF5R3YySW5aRjJoL05L?=
 =?utf-8?B?N0p1YWJkVHlSNEt0VGFnbzFQL3Zyd1BMVHh2RjhCd1l4ZEF3aFBFN2YyTXJi?=
 =?utf-8?B?T1dDdThiVFRmYlhodExMZkQ0SEdDdit6UjNHSXp6MHRaVHpxUk52bVBXZlg2?=
 =?utf-8?B?UHp2NHZBZ0NBcjJpN1N2V0dWYU9sQkNpODEvZ1ZUOWhRekZGZk1nMmVaTE1y?=
 =?utf-8?B?ZWI5V01vT0Rzb3dWZ3UyMjFRRElEaVhUYlZPcmR3M1drbm43UGRlSTdlanBo?=
 =?utf-8?B?NmtaSUhKKzljRzlNWDVKcmNFL1lsTkZBNklCOXFSZ3VXYnh0dFl6TGFHc3N5?=
 =?utf-8?B?SUY1RXlSaXFWQW9Dd1N0OWt0ejNhT0VIVFR1b2ZIVGVWbndaeFJHajEzZGFQ?=
 =?utf-8?B?ZHlqT0dhMlV5VFRWQjZacWpGVWxiV1R6TWFicVBVRVprUW9kakZUdkRFRUF0?=
 =?utf-8?B?djQvZU5pSXJ6V3daRW9TODFQcGc2OWdGeDVLVWZlYWZ2VU9VOGcySENWdFhR?=
 =?utf-8?B?T253eHRYOTRGK2krQ0N6VGVOTFlVaWNzSjVhUmg0VjJYaWsxaVNWanpnT1FD?=
 =?utf-8?B?QnJKeFNRclhMZTNhcTNTdnh0OUlvcGd6YldGdXhZZXY4bzRCSENtUUUraVFu?=
 =?utf-8?B?bFM3SFZxM1RYNXNNTk5rVGZCRDdaUEZQTWZDVCtQbGJHQW9FaGsvWTdWZDNx?=
 =?utf-8?B?R0ZJQ2VOZEw3dDFkekhSSE1EUDdMVDFZZ3BSVUNCcGk2UGZUVlZmOVpMQ1ZG?=
 =?utf-8?B?dlNOa2JpbGVHaW9UL21lZmNyOElCWlM3TVh3eFFjRWNZV1Roa25Kdi96RnRO?=
 =?utf-8?B?Z2V4MUZTb0lOOUNOR1NCaVZXRnEyQ0RxVHFOVWdjTDZhOG03a05oNDRLSUZ0?=
 =?utf-8?B?SzloNFJsYlhDYmdBakpvVzJMV2M5M2dodlFtOWdZYVhWOWRqYnc5L1hYdGd1?=
 =?utf-8?B?ZUVoZlNlL3oybjE1cW9RNFo2M3FwaTZQS1Z4T0lFYkYxeDk0ZW8rSnJXSyt5?=
 =?utf-8?B?cWExSUJIMXp6OEt2OFMwWjBYSDNweW9HV2syY01DckJ4SlhXTGVoelZQdDB6?=
 =?utf-8?B?d2FUL1c5SU9JUWhCZjRkZjZyaC81ckl6aGx6OEJRS1FjL3l6ZWt0NXZSWXB3?=
 =?utf-8?B?bU5CSWhlV21PbU9CU2NvaDE0RnUrdkZaQ2w4S0l0SjdVbm5SMHo0V0JtK2lk?=
 =?utf-8?B?Vk1ic2JUbEwycDFzcWxXbkJ1bGZvNXlmTlpNamxQaUVYZUFpcFZ2YzNwS3RP?=
 =?utf-8?B?cG1GQXU2QlpJVFlzcXozQURBZWhzZEZBL0picHNJRTBmd3MydE9ySGR3ejBj?=
 =?utf-8?B?VG8wU2ZIU1lMVDBBelRoVFBVQnljMGlod085bGdKZEg4T0MzQ0UreWViQVdh?=
 =?utf-8?B?c3pETEJPa1Nkdk51SFcrWXVlYnh5WHRJL0hiTjJyODA2TzduN0pJUSthOTdi?=
 =?utf-8?B?RUNLdHE1ZmtWdTBxN1RkK1VNdjZZQWYydUcxTFlaUnJqeVRQZ3l4MEpqbHZp?=
 =?utf-8?B?a3ZSWEhYM0l1ODJacFVHNTRKcnZtL2krN0FBYVZWQ3NYS1czY0RTR0xiYmdE?=
 =?utf-8?B?aTRWTGVZU0dTYlhUcHFlWGZseDY0a0djTkdiQkVGTUhTK2d2MmJhMkRlTnBI?=
 =?utf-8?B?bTJaMEVwVTVGUHlqUFRNQVNTZnF4VTZ5cy9iL1JCbmh0U0tLNThSdDRHS0k4?=
 =?utf-8?B?aVN2T2J5WloyM2ZYRTlpeER3VWczc3kzVGpjbVFaVDdobHNNK3VrMHhJaUc5?=
 =?utf-8?B?M3V2cFVjTXR1ejE2cU9CLzI5UHlIOGdtTWdwMDVCRTNiNGlLZDgyb1ZSbmI1?=
 =?utf-8?B?dmZLTEhoM0wyb1JMWlF4U0orNEg4SEp5eGQyT0k5cmF1NVFoQzVXV29oSVBm?=
 =?utf-8?B?cWZHMkUxNTZpOTZlRGNnMXRyM1ljSG5ZY1J1akdJek0rOUs3VWo4Nlp0NjFx?=
 =?utf-8?B?TS9vOEZ5RkRLTUVmbjQ3TkR2NEU4QTlvenNDYzFHelF3c3UxRXZ1ZmhhNlpy?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 407f81f0-c689-47ca-8491-08db7f33a8eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 21:46:45.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEr4IzXDn8Ed7RqRDy9kHj2FAHqm07CbGTOYr1OxNUjEQlnIQS4ijr97nOpXpmjI51NbrGf/jvbZm9Ew4zXO0O6e+b0P+rQgQyNCv2SnuPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5696
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 6/1/2023 12:02 PM, Babu Moger wrote:
> Currently, the resctrl default control group is created during kernel
> init time and rest of the files are added during mount. If the new

Please drop the word "Currently"

> files are to be added to the default group during the mount then it
> has to be done separately again.
> 
> This can avoided if all the files are created during the mount and
> destroyed during the umount. Move the default group creation in

"creation in" -> "creation to"?

> rdt_get_tree and removal in rdt_kill_sb.

I think it would be simpler if this patch is moved earlier in series
then patch 8 can more easily be squashed where appropriate.

> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   59 ++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 2f5cdc638607..e03cb01c4742 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -57,6 +57,7 @@ static char last_cmd_status_buf[512];
>  struct dentry *debugfs_resctrl;
>  
>  static bool resctrl_debug;
> +static int rdtgroup_setup_root(void);
>  
>  void rdt_last_cmd_clear(void)
>  {
> @@ -2515,13 +2516,6 @@ static int rdt_get_tree(struct fs_context *fc)
>  
>  	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
> -	/*
> -	 * resctrl file system can only be mounted once.
> -	 */
> -	if (static_branch_unlikely(&rdt_enable_key)) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
>  

This change is unexpected.

>  	ret = rdt_enable_ctx(ctx);
>  	if (ret < 0)
> @@ -2535,9 +2529,15 @@ static int rdt_get_tree(struct fs_context *fc)
>  
>  	closid_init();
>  
> +	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
> +	if (ret)
> +		goto out_schemata_free;
> +
> +	kernfs_activate(rdtgroup_default.kn);
> +
>  	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
>  	if (ret < 0)
> -		goto out_schemata_free;
> +		goto out_default;
>  
>  	if (rdt_mon_capable) {
>  		ret = mongroup_create_dir(rdtgroup_default.kn,
> @@ -2587,6 +2587,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  		kernfs_remove(kn_mongrp);
>  out_info:
>  	kernfs_remove(kn_info);
> +out_default:
> +	kernfs_remove(rdtgroup_default.kn);
>  out_schemata_free:
>  	schemata_list_destroy();
>  out_mba:
> @@ -2664,10 +2666,23 @@ static const struct fs_context_operations rdt_fs_context_ops = {
>  static int rdt_init_fs_context(struct fs_context *fc)
>  {
>  	struct rdt_fs_context *ctx;
> +	int ret;
> +
> +	/*
> +	 * resctrl file system can only be mounted once.
> +	 */
> +	if (static_branch_unlikely(&rdt_enable_key))
> +		return -EBUSY;
> +
> +	ret = rdtgroup_setup_root();
> +	if (ret)
> +		return ret;
>  

Why was it necessary to move this code?

>  	ctx = kzalloc(sizeof(struct rdt_fs_context), GFP_KERNEL);
> -	if (!ctx)
> +	if (!ctx) {
> +		kernfs_destroy_root(rdt_root);
>  		return -ENOMEM;
> +	}
>  
>  	ctx->kfc.root = rdt_root;
>  	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
> @@ -2845,6 +2860,9 @@ static void rdt_kill_sb(struct super_block *sb)
>  	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
>  	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
>  	static_branch_disable_cpuslocked(&rdt_enable_key);
> +	/* Remove the default group and cleanup the root */
> +	list_del(&rdtgroup_default.rdtgroup_list);
> +	kernfs_destroy_root(rdt_root);

Why not just add kernfs_remove(rdtgroup_default.kn) to rmdir_all_sub()?

>  	kernfs_kill_sb(sb);
>  	mutex_unlock(&rdtgroup_mutex);
>  	cpus_read_unlock();
> @@ -3598,10 +3616,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>  	.show_options	= rdtgroup_show_options,
>  };
>  
> -static int __init rdtgroup_setup_root(void)
> +static int rdtgroup_setup_root(void)
>  {
> -	int ret;
> -
>  	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
>  				      KERNFS_ROOT_CREATE_DEACTIVATED |
>  				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
> @@ -3618,19 +3634,11 @@ static int __init rdtgroup_setup_root(void)
>  
>  	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
>  
> -	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
> -	if (ret) {
> -		kernfs_destroy_root(rdt_root);
> -		goto out;
> -	}
> -
>  	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
> -	kernfs_activate(rdtgroup_default.kn);
>  
> -out:
>  	mutex_unlock(&rdtgroup_mutex);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static void domain_destroy_mon_state(struct rdt_domain *d)
> @@ -3752,13 +3760,9 @@ int __init rdtgroup_init(void)
>  	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
>  		     sizeof(last_cmd_status_buf));
>  
> -	ret = rdtgroup_setup_root();
> -	if (ret)
> -		return ret;
> -
>  	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
>  	if (ret)
> -		goto cleanup_root;
> +		return ret;
>  

It is not clear to me why this change is required, could you
please elaborate? It seems that all that is needed is for 
rdtgroup_add_files() to move to rdt_get_tree() (which you have done)
and then an additional call to kernfs_remove() in rmdir_all_sub().
I must be missing something, could you please help me understand?

>  	ret = register_filesystem(&rdt_fs_type);
>  	if (ret)
> @@ -3791,8 +3795,6 @@ int __init rdtgroup_init(void)
>  
>  cleanup_mountpoint:
>  	sysfs_remove_mount_point(fs_kobj, "resctrl");
> -cleanup_root:
> -	kernfs_destroy_root(rdt_root);
>  
>  	return ret;
>  }
> @@ -3802,5 +3804,4 @@ void __exit rdtgroup_exit(void)
>  	debugfs_remove_recursive(debugfs_resctrl);
>  	unregister_filesystem(&rdt_fs_type);
>  	sysfs_remove_mount_point(fs_kobj, "resctrl");
> -	kernfs_destroy_root(rdt_root);
>  }
> 
> 

Reinette
