Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3277D68CD7A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBGDc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBGDc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:32:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CE115554
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675740775; x=1707276775;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3BSNcg2Ua8TEkP6VqZ29kWr83KdUq2b5csbAKHpr9eA=;
  b=etbc0wTfONCB6V2I/2lYtDNobMxo6SJgUA3DTRFBPi8+PxJO33Xa1Ful
   LkCjL973LF6yTAmT9eQAoc8Ho/3shCt5wewRc5BVUD4995rr+Lq7bcatm
   i3Dyphxg1hNm4lQ7lg6xCktj4XExpd6Rjsw1HojVwxW4rKMU4Nooq9oO2
   eQYuc1vHioafz7/gd9v7Nh6wIX0RYqL55XptjvM0Er55uZh2zZkVnxRsM
   6L25VGp2aocQUTo+M4eijlX1b72JLw0/Nsb1F6edB8s4C5TQkB7lbC7Pn
   q49AWSwcJ+lEi4FnnoQ/rltZmwJvDIKduwlhoQ5Af7LUbmn9vfAeXNTD4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="313045680"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="313045680"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 19:32:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="809367477"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="809367477"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 06 Feb 2023 19:32:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 19:32:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 19:32:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 19:32:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc/zeoHA92oUxHYX0mNOvpHBmVgx/D+XqC4yiqvVjDBGxz+t9y58jekddz2S/niU8MVFZJERdv/xi9jmp5YHE0uPes03QG8LxkprfkDLr4Bk39IOnN8o5aKY7GQ+fe0E8W0hrSkj/ZI4HI1O2MGxvSVOxLPVvFtJwX2EPfzAdMeuWlPgWdL5BlxAhAkMHQ+wn3HEq1/OutASHHUWgiZxo9g1oLPR5yKLb5F6oKZhlqPODGCx7pPg+PTCFOCo+dHpC0pfJDv6KUv0wgfcEQTpXiQHsSHyeVIWx40wl/G62LhV6G3KIJidAAaSS9B7w6sEoZ35Ao0Msu//3RYEYLrDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZsL8DSbXfXgyW74vmLJcxtpEUlKZdZxaRePAJ30f8c=;
 b=YudX67mOI3F7UsOHmWa8Wwq9M+R0oVYSk7im3J31s0A3bzMNKfb8f3HOKsUFUG3/RQG+VIFNxe6M+3Qk9U9xirKJV7WdRow7xNX09n73Y5yhfGmax/7nMvYTFyCo08aR4j1EV4NEnALThX15+50YVGutLfRz+loCoGcSdnaDE1/sqY6AEYcFCV1kSDk4WNQR212nXuDWcK1yCfPM0OPv5o7YaV0iY3yjRXU+dkakIANPpYjW997049qiLUs7zTFGlb7czx7Bpw7O+Y7KjnTpNn+nJJ3Sqg4tTQOeBNdss31kE6DqxGan48eo5tNZi+bpMKabM9xj57zA2C0O/L6sfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA1PR11MB6806.namprd11.prod.outlook.com (2603:10b6:806:24d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 03:32:51 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%9]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 03:32:51 +0000
Date:   Tue, 7 Feb 2023 11:28:11 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <bp@suse.de>, <x86@kernel.org>
Subject: Re: [PATCH 1/3] tools/x86/kcpuid: Fix avx512bw and avx512lvl fields
 in Fn00000007
Message-ID: <Y+HFSwrFmJdOdVsX@feng-clx>
References: <20230206141832.4162264-1-terry.bowman@amd.com>
 <20230206141832.4162264-2-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230206141832.4162264-2-terry.bowman@amd.com>
X-ClientProxiedBy: SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA1PR11MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 92218c60-95be-44ab-0fcb-08db08bbfdd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiB0d70BFR4VTtwRxlYCZJOnMX1l+WMLrXdM0cz4a3JAAaCjdLtxzyRiZKeW1DPvbs+mSOlGNXBmuChfgx6q63WoTBB/vzEQeiRR/qb2KPLfrXBUqytNbvF/gENFm4JNZOxlbM1m6gyEGzZzcotccEoj48+CmIZ+iy0duzfxR7z3mOk0tz2/6SVW377DkuDoawsOP3lnyGx8/Ev9fV7SimWWU2PuDSfm87GgOBsFiQ0I8uGCTHy+VWH2FtvJ4CHzB1SyZjzIhgHUnvEnyT3dsuYW5G3L3ZeFyA4X491mHxmJ/9cB6xuRAvh3ekn3U8lOz0asaaTx8qrUVvo9DvGBxdsHK3jc5CEejMNJ/YnuxQ4wZRDEoN6HKTnCyIdsR+VtqK4q/R2+sl8WK70Bw6szLnOCtTd/xCinQ/1rc/B7MZegur5CuXvMmD+2kgoEAXremE3C3+0LJxSFwJbuYUukPHII+9TopFTWY1NSJ5zHmzZ/juD9HtSDB7nm6yNrq2chF0oT68RLj/i8BtVAU6LAz766H3B9K1k40mNVHj09cAhBk/eF4YLNNX9j3g3pPDtdyxJmEzFmJca0vMI19Ux6/VE4n8yo8l9SYaY7u3dE9/Y+ikj8yI1dAh36WMFKSS+v/a6SF2qhwS47BEmKKqb5DEEAJn7TtVZbF9RCJTFh3ogtMxFr57zLSDO0CHNgTzYu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(86362001)(478600001)(6486002)(44832011)(186003)(6666004)(6512007)(6506007)(26005)(66556008)(5660300002)(66476007)(6916009)(9686003)(41300700001)(8936002)(316002)(8676002)(33716001)(66946007)(4326008)(82960400001)(38100700002)(83380400001)(2906002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0jYw892W7Ucgf2D1t/wtkynvRzr3fzW9Ivk/NCpmaApw5IplEIp+sxgy5w1A?=
 =?us-ascii?Q?Q0R7UlVv+TQ0L2CuSwqaccTDEcXvNjJcLagCz1ku3ytOXDL5tA+VbCdICqGS?=
 =?us-ascii?Q?OMkyDYxtT6VxzUR0OCRLM6hlnWsxDQ4CO4YEgppR4iI+uuagdHPdti3TuK51?=
 =?us-ascii?Q?pkV1g2gXgEVrW+kHHoosk7rR33wpGDKiRy5ynYjAylsm8WSeMfjrrK+nWKEA?=
 =?us-ascii?Q?4k54BQEeiKGm9gbZpdkwh1gjyETnVG4gUwFjc1knPzT2GcyyPCzklF6kjBbR?=
 =?us-ascii?Q?7XFPc+f8JeErwy0IxfmTB3F/6uAH1C6Ex54eDuBstmbl+IWeGjHgOKnLgZp6?=
 =?us-ascii?Q?1CTF8jkg+FVgOIvliWMVJMBtnoerkxlWkeUNabTjdLJ+g5zTcviueoI4CUut?=
 =?us-ascii?Q?FiihwoZKXxSIRLLeOWPZOsEn36GJH8lRVF+P6CLAWy0yQBpUUkoIwwPtOG3H?=
 =?us-ascii?Q?hkShw5VICoXTvkZas5YkkRUimLNWSpxyMFbmAx4lH7gYhM5UEPs3e17ofzDn?=
 =?us-ascii?Q?CNaaOF4hOgu3tzqsZtt0056dCSi24MTEY/pyKktQueE4g9LqPw0ehfu8YgNb?=
 =?us-ascii?Q?IFMoCm22qJut15UQT3Mdd5x9FAlX1i7VLdpw5AQzA+0FDIw5vnhNF31S9J+1?=
 =?us-ascii?Q?51fHJ+UesNXO0bobhg1APMCl9U2THuqWSINO+SMQOx0jYFOsuqD0KXNgbNPT?=
 =?us-ascii?Q?Oo+Oc04SHf1DFjEVYs1iAfoFeA8LiC57RmUzAD1cHgIi/GZI69iRlWJuTCEG?=
 =?us-ascii?Q?tx047qxNurPNpKOyVJoIdOq6iKqbpEw7iirIQUCOvpIaOQahuhjuYtLJDt/W?=
 =?us-ascii?Q?e1yKJbaLWy/Vobvb2RsPWX9Xl/V1ITEwovSfLZNgvWgA4qEykwH6pIrbTxT7?=
 =?us-ascii?Q?JcYBDg3yr6kzhqF90KJ+kKkMDtd29AwFf/qAInBx2jdE8+rSzFy66WBYfP5K?=
 =?us-ascii?Q?isR+8szg5R2h2Ajji8X7l2MeL3yR3J+3C0eSFoB2C3pQec7UzKUCZIfUEQjH?=
 =?us-ascii?Q?011uv+wXZlx6dyi5Orz192qcJrzrorEfGe4+3iTAT4qOJpKe0MgjfAo+1Xdd?=
 =?us-ascii?Q?QeWqhtMFR71ZjeCsoQb4b9eOmfaOb2xN1+uK7tcYOVomEFbvP/TywlOup/b8?=
 =?us-ascii?Q?N7SseYNB0oxb2tCud51oRq5dp9ESJS7HPpOEErLCqDqV2Z9ALLOiDiOI9iRE?=
 =?us-ascii?Q?aLwA37A2u7cFwRis1aLa2dlzSBZ4h2YLOXmkR7gBEiTGp+x6LWgWxcI9K5wC?=
 =?us-ascii?Q?mUozrig3+En3t9ZgBgFeSh5/A42XDiQmp0KWMIlJiTtz5C+LwCIlR/tYepbD?=
 =?us-ascii?Q?gMjvfGDZc/PCTRPX2ygDBxn92mVcBUuqpoixLnSPzLfXFQq2FbpxG9GI46i2?=
 =?us-ascii?Q?noEiPpYfleOoQwlc5CqkefJTVAoxjmEmFgogOtW7nEHYFM2KkU6b6zfqvd+H?=
 =?us-ascii?Q?5EA0zndaqv27W6khCqRKbJ8zr8fCTZGdRqZb6lUm3Zvp8JEV6vY+Gze6VTcJ?=
 =?us-ascii?Q?z8+UjOvSjXFnDl8vUk/eeWb26s0ixK7H4l+sY2k4Rj1LqPJMB475+Q1jLzOl?=
 =?us-ascii?Q?/Z1Rlp6OAfUVHZUZHgLGqMBMQE0i/VOJV3GQbfZH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92218c60-95be-44ab-0fcb-08db08bbfdd2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 03:32:51.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBJoD26Tkv9rkAIdNyNA5mx2UnvgBTcWhr4yhpC3zQHGcCokcQ7xW0ta0oaPx/3NgtvRTH4yPKnoSPSprPJzJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6806
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 08:18:30AM -0600, Terry Bowman wrote:
> Leaf Fn00000007 contains avx512bw at bit26 and avx512vl at bit28. This
> is incorrect per the SDM. Correct avx512bw to be bit30 and avx512lvl to be
> bit31.[1]
> 
> [1] Intel 64 and IA-32 Architectures Software Developer's Manual
>     Combined Volumes: 1, 2A, 2B, 2C, 2D, 3A, 3B, 3C, 3D and 4, December
>     2022, pg 3-220,Vol2A
> 
> Fixes: c6b2f240bf8d ("tools/x86: Add a kcpuid tool to show raw CPU features")

Thanks for the catch!

Reviewed-by: Feng Tang <feng.tang@intel.com>


> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: feng.tang@intel.com <feng.tang@intel.com>
> Cc: x86@kernel.org
> ---
>  tools/arch/x86/kcpuid/cpuid.csv | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
> index 4f1c4b0c29e9..9914bdf4fc9e 100644
> --- a/tools/arch/x86/kcpuid/cpuid.csv
> +++ b/tools/arch/x86/kcpuid/cpuid.csv
> @@ -184,8 +184,8 @@
>  	 7,    0,  EBX,     27, avx512er, AVX512 Exponent Reciproca instr
>  	 7,    0,  EBX,     28, avx512cd, AVX512 Conflict Detection instr
>  	 7,    0,  EBX,     29, sha, Intel Secure Hash Algorithm Extensions instr
> -	 7,    0,  EBX,     26, avx512bw, AVX512 Byte & Word instr
> -	 7,    0,  EBX,     28, avx512vl, AVX512 Vector Length Extentions (VL)
> +	 7,    0,  EBX,     30, avx512bw, AVX512 Byte & Word instr
> +	 7,    0,  EBX,     31, avx512vl, AVX512 Vector Length Extentions (VL)
>  	 7,    0,  ECX,      0, prefetchwt1, X
>  	 7,    0,  ECX,      1, avx512vbmi, AVX512 Vector Byte Manipulation Instructions
>  	 7,    0,  ECX,      2, umip, User-mode Instruction Prevention
> -- 
> 2.34.1
> 
