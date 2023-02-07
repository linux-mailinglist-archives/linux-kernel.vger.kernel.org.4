Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1583568CD99
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBGDrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBGDrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:47:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0784173A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675741619; x=1707277619;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TegV52jDbVt9hZRaJTQXBg6WeCb0Iwv8aWAT7EuYEhs=;
  b=Hg0zexQFCgiysQi6YiGxsPAdW5/AmMj/bSosL+N0x+Je8ZFT0TXaH4yk
   j9QIehPcgHJnZK4/PnTjsSfzu1KHxcqyUo0vDRbX5uVd50+zAF+0btDiA
   xmVaVyk3PLsJqo4PEe99T7HgKLPmwgV4tWuoL2NrxC5ORaZiwaaGGt4ns
   7jnKft40+Gex/T37myutUWx+BCOQcTW9cZJZXMcKoRVDWSRtNfXxDsr3C
   0fPmZ6pMVgYr/DONsCfTvFzTmoGs+tnarPoYyV7DYjkdkNyKO1vyJBWlq
   Iqe4WjD7CNrO7+RIMnx9kkqGGla/djoJM4sbqGcu3jZFQ/IsdabBKUweH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="309037942"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="309037942"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 19:46:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616661257"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="616661257"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2023 19:46:59 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 19:46:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 19:46:58 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 19:46:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEV7zeMaUVQDoEgpcgmpDuGx7ufOhLUE2IYXWrztM4UYAQAhNom7xJqMqgsAaReKfaf+Oyb6+PdkYemJA+5JzX6gbQGCsPFrua4lBGl+dGLgANv3c75InZfKl3VD/GjSwOBPRORtlsvUURnR1XbEXBy0GPI6PrEyZoD2rzvz4AWx4bmma2RipKiE/reXyoc/1rM6xC6iO+i61rTJmgHbmzlc3cRIeYbuJLJ+GVNw7JySc6cCyzWew8cfOeN+Bnr73pTDJxHC32IRwYHWXYAgAKF6QTDxNDaIPFvF3ntvmHbbZzxJfTke9PNqcVck5KaiONzz1Fh+Fw/XwEbCw8x2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QSYCyT/+zaLtvueNWc87Ti2jMPzKowTIF7RA5IMNNA=;
 b=d6lUl2PgPkd6oRaESVT4nYm1vkPeUjz47qhySFQoV3/uqDXnQwiwPDtUNqz5FzFBG/B6MYuX4oDnDAK6jVAnHrAUBlZ5dfWKDATHK0M0n7quSAmQ/WwZBuLCgmJVwmMFarSh5xg6ESe/+BQYLAdSE4FwgszmDLdWlE/PXfs/4e+gvaO6uAbqwgvv478oJAqglnjbDgiQ5JEqpGokmhh2Ovi5l5wgVQ+KP/t6qzpvZh1e4+D+XtFsyHb/gyY1xEzO9h5xYAwXm4pYkWInSsmMlQj8Ak18tcMu9dRqr2GnjuNZi4mCezJh7b3V+6f7ur52m8GXJUyZ/fSgaRGWHvlErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Tue, 7 Feb
 2023 03:46:50 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%9]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 03:46:50 +0000
Date:   Tue, 7 Feb 2023 11:42:09 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <bp@suse.de>, <x86@kernel.org>
Subject: Re: [PATCH 3/3] tools/x86/kcpuid: Dump the CPUID function in
 detailed view
Message-ID: <Y+HIkTzNh4SXgVEc@feng-clx>
References: <20230206141832.4162264-1-terry.bowman@amd.com>
 <20230206141832.4162264-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230206141832.4162264-4-terry.bowman@amd.com>
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS0PR11MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 0404457e-33a0-4023-27c8-08db08bdf1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDUQqACn4t02VwrFVzJ0dRG2nqCF1aZkP5lC8kgriqu27m4FhYRnB00bfTX+JBCRvGbsMssOGPjRig4md7XW77gKeDTMAGu13vuR8qs12tk8wjLTE32aPFbR/YiutXRoovWc2xX1TTrdDSTnCZLX1tSlc+UL+Vc+oG/aIrNrqZ0tYMHqZd6HnVL+LlEj5liwPQ7F8ijhgxTv9kirkPDBcRS3qqkTwfIcyYej8p95ueIBlWBJZCsY2VP4bMTVV9OOuTJnmuKjRYZu+kCliH1v+ZYZ7SGfSkyn0595hd4nlanS9HsazW/qJ13cmbTaK0KS9mw/jjjXtpARmNBu3uLdm9q4VIs1z+9enQfH40LGoX1zPAy92GdxThQyfdMNb/wO5vneO25M4p8ZTUCLsNBYJBycIrCAC7CvNSVXfwZ4QTn7Kn6CH6v7Ge/alhZrKaEuRFh5sHFtqvVFcPWl6djUSCh1paEqJqDHvkz5iBJkGKAK3sfGAlp2ksTlHCyZqr6Du7c/HZ0kvMc8APqx27BWGTzXttR5w66sr8XX08syE6laiK4pURKwTve8pIWPJ59QdpkoUWGORyIMGfH5QciZr7HQl6ZzW0xUmfy/EfAFDBuCh5svH0aIzDgHFWwIga2rwrblmQxR4HlHNCxIdJGxwg11uFlCPSaDwbbF7zjUvoA+ao9Hp5zq9mymMjO3hZ6V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(6506007)(44832011)(6512007)(186003)(66476007)(26005)(6666004)(83380400001)(9686003)(33716001)(38100700002)(66946007)(86362001)(6916009)(4326008)(41300700001)(66556008)(8936002)(478600001)(316002)(82960400001)(6486002)(8676002)(2906002)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T3FilHhIMAWFDHM0n8dSEEnr/FsmRcATebjr87pujRz98/3vTFx4lH3V2480?=
 =?us-ascii?Q?nUF6dfRnABMpEL+lxFao4LP1nGeyrkYSuHflnacNoT7QQURMjYIC4Z7KxxsS?=
 =?us-ascii?Q?it5jouOjTqhnk3VQPQyBdjJ3jeFDDh/vUqxECubdhr8oIoQs+BzrgWvxk54P?=
 =?us-ascii?Q?n1rPdqWme43VBdyOdai7uRiK0yZInE8ms/vr53vLe5HxzJ8Fa/emTTrxjtWv?=
 =?us-ascii?Q?zMuNekuZtlF+WffEdLMmsPKG4pyaMB65bQECA6KKgz8+ih9mw6WbpJwBYF2L?=
 =?us-ascii?Q?OfinjE8XLXwDDbTGXwOlCLAi0dK6cLR0CKNZ2LeCK0zJJ+ENHHZ9vjC8fPSW?=
 =?us-ascii?Q?r1QqKfywrQftb6I/pHEW8ds9L3ero+N4bb/GpMGYrG1Xe39uMUC/lLEmTl1U?=
 =?us-ascii?Q?wvFnyfjaN9izjb9K/OQIoyOR7MOtiqwt64VXf3IKXUp7dEx7KADuURbwwWRn?=
 =?us-ascii?Q?EK1kWPfgcGpI6zp4rbGeUhd5C0/B0g8Bmy1oHUdrPWqzGhhgTv0Hm2YtgP41?=
 =?us-ascii?Q?mJhrfOzJZeIP5zpFPYTIQsgEsjumO5dKSTbAxAW+WEe89t4+X5mXDXmRfAzd?=
 =?us-ascii?Q?FKycbqJAgzutfILegQXQ++L28OvFTf0c88X7A6Joq5B9aJHVKEtMWaSr/VRL?=
 =?us-ascii?Q?fIJYtPRpn+Um2YQnSpP6jxbmJyQyQGCCirs+/ClgWZqWKLKQmydmq6S588/W?=
 =?us-ascii?Q?5cYo6bPxwRl2g5UZdM2rxbBp8tNMWT8xMIqv9DGnFP7i6I0oVBJsZORc7YfB?=
 =?us-ascii?Q?kh1rGdBBGgKHK4EHWRYBUieSLPZmZWUPaeUgKIu61aPEp2lKh1US97u5xyyt?=
 =?us-ascii?Q?YjeCLzLRxKdpLRjzp9J5DM+PfIYxkiX9Wf8uGn5lv2l4XjdGjJDSLfV1OagB?=
 =?us-ascii?Q?FGu9p9PruY+GRwuVMYE+ek4xeC/02+rl09V+jWt24paV5cUZ+QcrXUjos+R/?=
 =?us-ascii?Q?hamL6LmcrgAfp5N10MmEGdccm+ySoE/qnj9RkA1gDJ0FSj91OydIKX+YmaB1?=
 =?us-ascii?Q?HZJ93Ueav2qbH01ymnoGbLhTatTrf8rDG6Wm5ZTi40fPFnKc0ChLbLNb4iPE?=
 =?us-ascii?Q?amS2jILdjJqSDBLPILgPeW5DZFjMjcyceaN8LxsJbicueu5Zfu/STohhqAEv?=
 =?us-ascii?Q?YXFFZZfbAGA0ljZnx44xB35q4Xux4xUjA1qq/Vmg+eXAP7yu5l3HjLY0+VCg?=
 =?us-ascii?Q?WXipvbnzTFtFsNzI1yeKilyHjuVh+93xpUv2U6CeGR9boGQzeEMPBoAwtYzo?=
 =?us-ascii?Q?PKSZmfvi6IG/EX0kCJCU5VxKdP3Mw+++T7/g2h0tYwv8CpNeR6xz/ohbqxdv?=
 =?us-ascii?Q?6smo0lxpgpMbeYZM5Ur2XxmsZ/bQKcdRHdYLfPy/FBIxNwCP+QAmkJyn0Bh/?=
 =?us-ascii?Q?XOgGtsF5TyWneOzT16aEMqJLmSEhippnzVcBvriFGlBYfpNgI9iCGkM5rZQs?=
 =?us-ascii?Q?s5o3v0wNkHTVrHZhWE0vACdggQxZFEQt3DcztTN0BdSQLaWEOegltgK5gdYE?=
 =?us-ascii?Q?pfJKooFboNqUEyoImxBkgIYDe1GPXo13iM4RGZkDX2rfm9mOSSxGUAzVuzn5?=
 =?us-ascii?Q?PIeDxugvj4b2kHe9Ce83+lf28SUVpHu3lO1gR574?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0404457e-33a0-4023-27c8-08db08bdf1d2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 03:46:50.3542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmeKBmwnqEqqIRlAWRKsz+P36AO2Byf3OGvDarsQmimtQ2nMpJPeY7Ysy6dcnKdItSVpKK1i99+1uLvdvRy55A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 08:18:32AM -0600, Terry Bowman wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Sometimes it is useful to know which CPUID leaf contains the fields so
> add it to -d output so that it looks like this:
> 
>   CPUID_0x8000001e_ECX[0x0]:
>            extended_apic_id       : 0x8           - Extended APIC ID
>            core_id                : 0x4           - Identifies the logical core ID
>            threads_per_core       : 0x1           - The number of threads per core is threads_per_core + 1
>            node_id                : 0x0           - Node ID
>            nodes_per_processor    : 0x0           - Nodes per processor { 0: 1 node, else reserved }
> 
>   CPUID_0x8000001f_ECX[0x0]:
>            sme                 -  Secure Memory Encryption

The idea looks good to me, as providing clear info.

I gave it a run on my box, and there are some item with no valid bits
definition, like:

"
CPUID_0xd_ECX[0x2]:

CPUID_0xd_ECX[0x5]:

CPUID_0xd_ECX[0x6]:

CPUID_0xd_ECX[0x7]:

CPUID_0xd_ECX[0x8]:
"

Maybe we can check the sum of subleaf->info.nr[EAX/EBX/ECX/EDX],
and only print it out when it is not zero.

Thanks,
Feng

> 
> ...
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  tools/arch/x86/kcpuid/kcpuid.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
> index dae75511fef7..3bab3398cec3 100644
> --- a/tools/arch/x86/kcpuid/kcpuid.c
> +++ b/tools/arch/x86/kcpuid/kcpuid.c
> @@ -468,13 +468,21 @@ static void show_leaf(struct subleaf *leaf)
>  	if (!leaf)
>  		return;
>  
> -	if (show_raw)
> +	if (show_raw) {
>  		leaf_print_raw(leaf);
> +	} else {
> +		if (show_details)
> +			printf("CPUID_0x%x_ECX[0x%x]:\n",
> +				leaf->index, leaf->sub);
> +	}
>  
>  	decode_bits(leaf->eax, &leaf->info[R_EAX]);
>  	decode_bits(leaf->ebx, &leaf->info[R_EBX]);
>  	decode_bits(leaf->ecx, &leaf->info[R_ECX]);
>  	decode_bits(leaf->edx, &leaf->info[R_EDX]);
> +
> +	if (!show_raw && show_details)
> +		printf("\n");
>  }
>  
>  static void show_func(struct cpuid_func *func)
> -- 
> 2.34.1
> 
