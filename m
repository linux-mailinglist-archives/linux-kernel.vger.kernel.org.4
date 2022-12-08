Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B964659D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiLHAFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiLHAFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:05:50 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32C95E9E6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 16:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670457947; x=1701993947;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PBIWaIhQM7G21CQzLlYPdy7+zczpJjnyvUNRKc0tODo=;
  b=O9Hc2QhKbkxiYLBV3IM/yO1T7HHKi14aHsdub8XsqHaWvDbBWK54Mi3o
   J1YBhYCSA2RjHC4XnpGO1/oMmEBYpH6+016KNktPuDD4thH3RsNlyD+RA
   O72HclB2ilUtfArWNjCopIfyS2/OLuKM9xgn1ClyQtTofxNuvPY9fBoO8
   RCSYydbYjfGaSdJ075qpjh6HbV1BF0FWcap9e+LNjvTD1wcZ6bagE8WQG
   jrhn7kbjqsttSj1I3WCfvkuiQb8UzPRTpg3CQXf4UgnKahvZNQSnklynt
   ltEKQFyY35A9GlHR0v1g3rH9xiac4vib+vSq97hjiaWO2rjUdhw2KL1Ph
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="314679622"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="314679622"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 16:05:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="975649017"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="975649017"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 07 Dec 2022 16:05:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 16:05:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 16:05:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 16:05:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOXmwBeu0P1HKrHKeef6T+dxPoMsoXEBRwklYsVm5oPoA9RloMXViI+AKVVHIItXXumFsGHKv9mrS9R7uj0VeQOQzwKY+QEr1ctRQTINSCwfSeYtKMPndmSv5WRocZKoeSb5Srizm+xHATUHafSjCOBTjX1aGz40RAykt9iicALQXtcac2G4Q5SihIqy3wZcgbEL7ln8Ie0xUnYT/AmkDvHYfTiMn0vMaJ1egW+PIYyGgwTWNdWlaOGQy68emLF2VhkC0my+ifcAsmk3sZwAB+0haUf3nVaBmZ10ku3Wui/hSYkG4Xvq9WSVX71J2d2ZkB+WQWe517JIMlAecOikkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMPRknrrMKNrN6wcu2YfDaq41BBZMyj5OHQtxi7Ma7M=;
 b=TxM9Bt0tbOqVGLFx5o9E670lGfh76fVjtyyRspuP/sYKj4xVG26FyeXK2ez3zYEEFdz9IutuEICxyNokANEXO11lA8/7FrAFkY+ri5j7c+81NUczByPmd254JGspO9DbaDCN7r0ibzWgr3Byp4eTaHGipN82tAMlYaezei731qPXJwfIrzmAaTcHbzUj8np/H4RybzOlXAw+P0GqlsLGOx5SUB19Sz+gx3nI9/k9/8gwtzn1/IoDPiafGdGxBMqKQW+VpDwKmobPBQdaDjcxetrUhPplnvTJK1jJwjahCEyaPQQFnVmp6xM3ypGOya99Yy6tBJaueCYytOGs918nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM6PR11MB4737.namprd11.prod.outlook.com (2603:10b6:5:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 00:05:24 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 00:05:24 +0000
Date:   Wed, 7 Dec 2022 16:05:19 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch V1 4/7] x86/microcode/core: Take a snapshot before and
 after applying microcode
Message-ID: <Y5EqP4OtmK04g6bQ@a4bf019067fa.jf.intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-5-ashok.raj@intel.com>
 <Y5D20qLOmrj4d2w4@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y5D20qLOmrj4d2w4@zn.tnic>
X-ClientProxiedBy: BY5PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::26) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM6PR11MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f41d1b2-d249-4e6c-91cb-08dad8afe6aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4tyibllpK9zlAUuy0F8vPcBrTOdmnXVulMSE4aQ38wdEI1jpIYMIRFAOKw+Yf9bs3V9sStIFAPfSmxr+6m7RzDML9JDQarYJPmh47OK6LEtRD+4yjvS++le8piHgwFsGf1HD6Rr6v8BagQ8oSQZumcAJjtZ26x4xJWu5B2x7Mza4hmJ/V65chwaQOeqPHSmcroCCrQZny66Zct9IyAXpaBhVYswtlGtff1MLqlofJgzk1ecJ5qr+BogwcQxnZ2sQ8fzHyYZSih6PX3b3i/jnyME9dJWNoow2BnkEZmWvdZefCU7o3PdtjhwHYlA3cpUIywvzla4Cal1qs9NGDKsOu49dDC4eFHATQ6tDWN+KuTXDf5/OFdmqO7siDZ8tDU9IdyuAySaw20bjTInenEgGfpeGwk4aUOfXCIUWu0oQ8adUlICjculKVwXsxamIC99IhpHupfqOIXzcgjd5Wz+1svTKOwcOyblAWSoGSBX4RU5+txGE2DFWoZytiVmWzNwY27hSA+G2jajzZL0FNGAEqWuLxJAXl0oXbu/WyXErTfRqKRH92+UH2U5lZzAXl77WdCOYCaQLllNgBrB1AdD6jp/vCEbhPtqcrkiHjSjk721sGsC23UddfTxwj9dDenllrGmCvXYf93TZljdOjXoXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(66946007)(8936002)(66476007)(66556008)(41300700001)(5660300002)(44832011)(8676002)(4326008)(478600001)(6486002)(6916009)(316002)(54906003)(2906002)(86362001)(107886003)(6512007)(6506007)(6666004)(26005)(186003)(83380400001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pvuIqgW12INIZi1Imq0tBj74yB5BV25TeT5GIH1b4MrA7bAQ/LFVsvEZo+KT?=
 =?us-ascii?Q?oVCJiDzzB+EQvFD9xABwbNWKOp8xUPNK/jdS53syEqnTtAXCMa5NsJjjH1Eo?=
 =?us-ascii?Q?J/ma4Ci9G2ZBC/y0Tsx0rgIouKvO1DWIn6e16o+NT9rhi6ImpDwoJjgfbaX6?=
 =?us-ascii?Q?8wjopHuut7aexdPuYHTbIRIISh3nxDbcRPwcwMnZTMoXsDBWkGkM2jFX1esK?=
 =?us-ascii?Q?5j7RX0eTR+9YYp83Egg0QtdoekvOJpKVwhq7CLB7yZD2k/ptIWKS+nHlR5U7?=
 =?us-ascii?Q?mKj0uDZPDIFGR8sR2BxoitK9WUpvtv775ZY7ZVsxJPWpyNJrZvz246fG0ARS?=
 =?us-ascii?Q?ed2TG28JmPWf1jXpwLT1KF2DP7947+TG3Bf6C597WTvSrZagMP/1dbtVHum8?=
 =?us-ascii?Q?Kk7WaWnXhSU5fd7vg+buDVE1A4Kcs4lGxPyYWQsCguutj/LCeK4CW36S4mp2?=
 =?us-ascii?Q?9bl8F2sim2eHuHx1XVYrwzQ1wuy680HSCCoVPsUhxCemfmCFzf4EhWGGlABh?=
 =?us-ascii?Q?58N5gywXPx+hcRjAMWHWjE17ffwqXiH4yk9Ws8I1XufEQ0SJN8Quzpn5X7Gy?=
 =?us-ascii?Q?C3MIFuVxX+UAyoa3mK/sdp9tWzRB9hIoePF2VNECG48XoPs9YQzxGFXlyrAt?=
 =?us-ascii?Q?Yimxc3O/S+Sq3kYry8EfuJH66jgLroOWSzBQUvNIsO+VzmdY9ZCwYGo+wqu8?=
 =?us-ascii?Q?kNLQlSVVegAQD3nbOT9BPufnXlmdrvxRJ5beVTYopgOVmNZHIaDXsMltxNPd?=
 =?us-ascii?Q?IwbXaoSMD51OCQNtxxAfMUWnX0/6IF4xadyuUvqQ0UdLqvOlVPcITWlEylrz?=
 =?us-ascii?Q?fjflFvrKH/GxPZN92imipm4KoSVioujyursztOIb2qwspo6p6uuHn5m33Eo5?=
 =?us-ascii?Q?hPjlwh3muPf9dNVlV2PADVakL9v1vgYa02vCppsrAQJFgCk4NcXS2aKwNcet?=
 =?us-ascii?Q?lp/RidTqG0QZmGiUMxlvT0U0qRRcqcG9MT50UhhVHnp0WhLL/y8wYQPIF8hT?=
 =?us-ascii?Q?g8X3H0PABlzUGQUp12q9PkE8tmAmEaroVbfyWfECpsni2NHRPXPpHW9AiH0T?=
 =?us-ascii?Q?zE1nlUJLRHjBpnoNuiLO5d8YGPIuYYoTjUIu4iAiBk88OGCYz1PS2W6iyo4P?=
 =?us-ascii?Q?JLXXCGClswdBH3A1ms5lDgv9Jxb46xYLa3D8VSKc/WkBhysrV3UR6dtF06+0?=
 =?us-ascii?Q?0sdfCu04/2Zs0hzYH1M/lqOdTjdnMrQGNt+mtIjLTliXhzlcV86UJ7bhtDcu?=
 =?us-ascii?Q?6xfG9WicPlObluPDsRi4F7uMembj5KWKGSTNDkCsy9Odo0lVqMw2alwwzebN?=
 =?us-ascii?Q?yDlCPW44H3SAoIupSO9dcSOK9zJBVzN696SKgfeWjjwsvpRqTxIWgDCyFUuy?=
 =?us-ascii?Q?siny8Pjv+BvGS/Oq2O2cSIuEi8LA8wee642Fj3M/QHXESMKz/+X5Mwu2xM/+?=
 =?us-ascii?Q?8E0P7/qffL6tN5z3Xd0FE9j50DtjP9fOOJsR16HyxVb5fR55ustmvyFDKny6?=
 =?us-ascii?Q?/mbbD5UzsvZvLWZHpMunIdfOM8guKNGckjjPWel3N1d4Twh5fh9UBvYX5Zub?=
 =?us-ascii?Q?X5WFrLDWdx4IcwnfrKU9NWT9JyP/bjUt62uhJWuo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f41d1b2-d249-4e6c-91cb-08dad8afe6aa
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 00:05:24.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwYRhk8tcwt6+PIYuxDdOfYz29uvopXy02GxBN9Cx7xv/iuKvRa47xD9jBb8yhdgdetfrmEa+z6b7K1ziufB4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4737
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 09:25:54PM +0100, Borislav Petkov wrote:
> On Tue, Nov 29, 2022 at 01:08:29PM -0800, Ashok Raj wrote:
> > The kernel caches features about each CPU's features at boot in an
> > x86_capability[] structure. The microcode update takes one snapshot and
> > compares it with the saved copy at boot.
> > 
> > However, the capabilities in the boot copy can be turned off as a result of
> > certain command line parameters or configuration restrictions. This can
> > cause a mismatch when comparing the values before and after the microcode
> > update.
> 
> Hmm, but if that has happened, the capabilities will be turned off in
> your @orig argument below?
> 
> Or are you saying that this copy_cpu_caps() read before the update will
> overwrite the cleared bits with the their actual values from CPUID so
> that what you really wanna compare here is *hardware* CPUID bits before
> and after and not our potentially modified copy?
> 
> I.e., some bit in CPUID is 1 and we have cleared it in our copy.
> 
> Close?

Correct.

> 
> If so, then this should be specifically called out in the commit
> message.

Sounds good, I can certainly add it when I repost.

> 
> > +static void copy_cpu_caps(struct cpuinfo_x86 *info)
> 
> If anything, that function should be called
> 
> store_cpu_caps()
> 
The names sounds more fitting, I can change it as suggested.

Cheers,
Ashok
