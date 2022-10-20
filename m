Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51405606731
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJTRkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTRkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:40:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1798A112A98
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666287646; x=1697823646;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vXiOdozrRBY07vVs+Myv0lNR4LpwdKmTgfgsu0plDrQ=;
  b=QDObJN5aTq24dkGLuDidbDOvM2pSvmyu0mzLhghUDzdTj1mUdjk0nhIP
   /isOBpg+xBYiwY62GreGkhNnTIgauRzDVPe6K1hdrU/9W45tV1mLSa3/I
   +BNUpOywPcp1Htu7HbrrkvhkL1iRRHk1lq5cefSxlBtUTyoLZklKc4XSV
   5CAIvBtrKL7Wrrfpy8jXOExQHFURIIuAsnewQxEpmvd5mBZSnmt51KvXp
   VwSHNmJGyNEHjxLsg696F5ruSmQvktEGOZMvqJ42d5saQ2TzSZR8Yy7Sn
   6TJamvq1v/lEbNPFyXFfXCaw8c39sRFEr445IEsgHcN/vPd9iA+AXaFzu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="294182252"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="294182252"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 10:40:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="632397407"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="632397407"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 20 Oct 2022 10:40:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 10:40:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 10:40:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 10:40:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPTACRBSkXOI06UCKWisQ7rJMsGy9bM9JEk2wtbsLyMYJjm8WizMTLckKjxrw0MJ6geDx+5YTlZmRXDDiW1jaF1cIGTmu46KK3WLHCiAUFT4aO5ItGo+mSpxGccjv/BHX3eqSP+FJIUb9c+BXycPNAjJWUCUFX4aegystEhBt9cBHCnTnTfzQ4pgLLNKHEJpcx7/uUH8dopQJAs+FpRzxr+Eqd6rB4GhhctA1FuLnCm+Vmf0bssOg/ma4Uine+/1q2hlo+XiHcrq3ldw+K2HLPfm0+gQJH8P+e0AB994hAvPwmatUAJfFGs4tqPlO2Bmu+AlHIQHqrlZZct+A9DLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTwLSVp/263GtGcja1qKPeQQHf4s+CSMPa1wwPUTXnk=;
 b=C7k4DxY5ILhFY2MNqWENXDLxgh4U2e53rFQj7o+EaD/PUN5rGL9GBJVDfo9NChB8d+6KEZFeWW4LicCO4JC2IO8/BJl58NTGMMQfTthbe8OiFDBJaomCIPD4hzl60RnYkd4wiPviANN8/Bp8wfd2vh3W6+5tdfCftSLvly8QMLl/Gqt2q1NCUPZJK9H/9wyBaVk1G5Lq7nsHaW26rOYszEwBWGHKSge2996jhsW5t3tdt6qv2ZFdcqhOQlTFdXyReCkUtaRje84cczqGFBeDW1ctoW9QsmghaaDxcxKPEy1Wvw43xXinEL4QdsGW6rb8sOphDY5KGyyrxLGWPm2dqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) by
 PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.35; Thu, 20 Oct 2022 17:40:35 +0000
Received: from DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::3a1b:7b6b:aded:fbfc]) by DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::3a1b:7b6b:aded:fbfc%5]) with mapi id 15.20.5654.025; Thu, 20 Oct 2022
 17:40:35 +0000
Date:   Fri, 21 Oct 2022 01:39:02 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
CC:     <lkp@lists.01.org>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <feng.tang@intel.com>, <ying.huang@intel.com>
Subject: Re: [lib/cpumask] 6f9c07be9d:
 WARNING:at_include/linux/cpumask.h:#prefill_possible_map
Message-ID: <Y1GHthWAyAq2Q+Yz@yujie-X299>
References: <202210201612.9d7547bf-yujie.liu@intel.com>
 <Y1FzKVLlLPrhb47D@yury-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1FzKVLlLPrhb47D@yury-laptop>
X-ClientProxiedBy: SG2PR02CA0073.apcprd02.prod.outlook.com
 (2603:1096:4:90::13) To DS0PR11MB6397.namprd11.prod.outlook.com
 (2603:10b6:8:ca::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6397:EE_|PH7PR11MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: a44d380b-c01f-4f0e-55d4-08dab2c23184
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4l4w0EszCSuBMfJ/4ofLnJlKVELVoRwespDIEexP8neSycrJRALAoYQ5OiKIHx+OQ+yddwLlN1rnWBDZKysNzDd4zEIxTAqzJSDY66eVRSO6PcM4z3hPc8heQM8Zp46TJDrwUT/JnYcn29JwdVK7EcfsutlS3zfwmD+ZwdEPGN86RqmfRD6xTuEvZ86P0WoeZsTK6KI0QnDB4zltgCkICDaMksSyIcYWSV1tqZopjor3oaQ/4hBPH1m9KgI8ZnK/gBZiU+2G6hkRbYgsJfYwJBznsVaIdgsaEYSbgwJXd9Qmib/m2TTMjkiPszMO2GOncT+N6rp/1aB+eZppC7fCDyWQNySPU3s0lUhm5w1q8HSppEVWplRBKY4JXeAZI/W0jPi3YYbMUm4dCGZXluHfS9U21HCcfWe7Dj6FUfvu76fx+Ap3C5hjTDlAMPbWehQE1LOoIyFrXcpLlB82tX8pb55u/0pjXGMSm+5zy52w9K0hXrRlJ3kPF6zqfCyb3dVrCCWbqNvriW21zNzkbAOFjqtMxgpFh3DARv7ee+eFyZWrbv+LD2mENu3i2EndCSaWsGHE6tVpoesdJNUMMdwO42Ye3wpLI6dS5npKnTFGi5DiyCLKW0c8m4xQYAe//23mrSwj5gsC+tPfP1guB//NMxRoOyW+9/H5UdTozEJKL0bvGr/G0t5eGCtuhbQsikvRBi+DkP111+5X9d8bMtxYR4BKmxQMwsM5PKkZaLxuVzmE14LQxpYXf6UqRGWI8u1Oguw80xLXZWvbet2yxE4M1+lKBMsXosaqP21aqOClH/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6397.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(86362001)(82960400001)(38100700002)(2906002)(83380400001)(44832011)(5660300002)(9686003)(6512007)(186003)(26005)(6666004)(107886003)(6506007)(54906003)(478600001)(33716001)(6486002)(8936002)(966005)(6916009)(66476007)(8676002)(66556008)(41300700001)(66946007)(4326008)(316002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vUBxRl9lu9n9KaVBFNOPtLT6w3ZfxtG+T63yjkDYkw2l/Edmx6ONo39GsusY?=
 =?us-ascii?Q?UiYqP2CAid1N4KwbhYvwuGDkl0NOwz0JqxB4KafnfXpwtl7ztmUqZeaq76g/?=
 =?us-ascii?Q?Fk+ZwOz8t6JbJJMMlLDeVpyyDwsrdc+DCwZYQjovdblw9EkhlLQhCLWypzpz?=
 =?us-ascii?Q?/i7j78m8uUnDS8J7D7g3zxscTTKPWin8SD/Gi5Hvr2qbfiZ/+FO6rERXQVe8?=
 =?us-ascii?Q?22CsUdwKxwLusJrHUJuhWOOfSflseib5Dw1Gwg6Sq4YoQf8bIiJD8Siil97l?=
 =?us-ascii?Q?NlE1dfIIs/jK5kboqxeyA9W23TaakzK54dG6mSSOLOSE1+Sev2n9IR26NFPH?=
 =?us-ascii?Q?YPvQtLX96xx+gzLHz2A/R2MJt9NHUtzQGRON3YjEOnDts+ouLX5pbV4MDZ5Z?=
 =?us-ascii?Q?4qHBDPx4j/2PzKPvg+ZgXGDDlsgZNHlG2mQGsO1Ecohza4GerdA7egLEz4BT?=
 =?us-ascii?Q?0OsZUCbvMDRIpysN4GsQa8dUl5UhLE0CRPkBaFYLq8dw8eFZnYteiiy/s50G?=
 =?us-ascii?Q?zJK8tLBifHK80KpNdr1Rjm+GOFl20ukpzIkscYHqVLmqTONFcZbZKNZp1eJ7?=
 =?us-ascii?Q?1ux4FnUJt9nsZCXveNQtgVaK/BdMPtuaEmtsKcXOQAuQPVC1Kp8pv8F+Iswo?=
 =?us-ascii?Q?Nu5yOpH3U9tx5nvoGTRjqUG3WbkBdZr9O1CwiBG/UZ++JxBYMtk8PiQmre7r?=
 =?us-ascii?Q?A7a+Htgeun16QTfbDtZXboVNZBREY50zG+ihVqvMB4vDwLNl0KI08Q/h+AB/?=
 =?us-ascii?Q?BgwZx7Gj0FK5xp+ho/4jYq5k8X1UHzL9Ybl7niqmWTh819eWuq4PuFQfZ4GQ?=
 =?us-ascii?Q?nnDSkb6z1I9JRFiDBRtMWqrsW2WxLjKaQikWIWYhNZ4XT0pgP85ZZv7FOr8N?=
 =?us-ascii?Q?xUeRTvrgBE5PuxbUpxBHqigXd+ZXR8gGEuIPpqGc4ljnAxddeXdXctrJLkod?=
 =?us-ascii?Q?w1FoNux72gAnX54NMWpeNpAfoZz0c0EapZSAii5b28zqACsqqMpAePT8I8Tr?=
 =?us-ascii?Q?nttyZDRWrzS5V9K1qI9eVu/YaLhmivDSwOEYogz0MrIxrlTRUub/qJIhtvSd?=
 =?us-ascii?Q?V04wiBGUx6cQ8PCuSrB1uB3BuZ+jmGPk52R4EX9jkabNrdMFDPxUCa4icWto?=
 =?us-ascii?Q?EkC+iwJvvZkaHiASwgG7xmefHW1zNOrP4JmOFQXAykVCfc0IuM3WpD2y/bNB?=
 =?us-ascii?Q?fc5HrZcG7ZUqibx6bjM/NYiwIeQEdezdbbM5lIjOOqQROUgyV2kxfP7bfn6U?=
 =?us-ascii?Q?S8Ix4AVTWDC96odTRLo8Duvj4eOKZe+OMp1NJOKIKGAQ2FNoiir+QrthaygS?=
 =?us-ascii?Q?Yp/sd62dtnIvnD6Z3eHITr87hOy6Bwamh3gdDiYkKuCb9IhTrgWuHx/QQrEs?=
 =?us-ascii?Q?ZVKsrKBGR3DfAby1fxs8nHmQCLUDJIkbTWhijsgG+nIMGGjVSn/mmFKgqeER?=
 =?us-ascii?Q?IVWxW7MNpl/nwd6SbQIkcnB2YfPKPI4b0bWahPvnwBbh+/mIXVOoVGAqHDQR?=
 =?us-ascii?Q?qaIywuJFac23wtuf0p0xVXdoXTbRvzvPgbQaMX43E8dQ2qNJgI98AlJa+piN?=
 =?us-ascii?Q?I/spjawuCtHmHM1Mb/l0b4LKcYOfx8pz1kT3DokqMjOoSANG4yF3zRzN8V5r?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a44d380b-c01f-4f0e-55d4-08dab2c23184
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6397.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:40:35.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Uo14XtQ1mOt4yE36mZRMIqKfhG8BEESMCrYSRE6rjhlXNtJtT8q4k+JHl1qQwNpOXoODHYOzK7K6u+OXcFujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5819
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:11:21AM -0700, Yury Norov wrote:
> On Thu, Oct 20, 2022 at 06:05:51PM +0800, kernel test robot wrote:
> > 
> > Hi Yury,
> > 
> > We noticed that below patch adds a FORCE_NR_CPUS config, and it is
> > expected to show a warning when this config is enabled and
> > CONFIG_NR_CPUS doesn't match the actual number of CPUs we have. But we
> > also noticed that it not only shows a warning but could also break boot
> > test in some cases. We are not sure if the break is actually related to
> > this patch or not, so we send this report FYI.
> > 
> > We noticed that a fix patch was posted at:
> > 
> > https://lore.kernel.org/all/20221019225939.1646349-1-yury.norov@gmail.com/
> > 
> > FORCE_NR_CPUS won't be enabled by allmodconfig or allyesconfig after
> > applying the fix, but looks it could still be enabled by randconfig. Not
> > sure if this is an expected behavior, but since our test robot runs many
> > randconfig tests, this warning could still be triggered frequently and
> > go to boot failure at last.
> > 
> > Please kindly help to give some advice on handling this config in our
> > testing. Thanks.
> > 
> > Please check below report for more details:
> > 
> > 
> > Greeting,
> 
> Hi guys,
> 
> Thanks for the report.
> 
> Indeed, if FORCE_NR_CPUS is enabled by randconfig, it may cause at least
> boot warning. I'm either not sure if the following alloc_pages is
> related to the config, but anyways...
> 
> The most logical solution would be disabling FORCE_NR_CPUS in
> randconfig before building the kernel. We can do it in a post-script,
> like:
> 
> make randconfig
> scripts/config -d FORCE_NR_CPUS
> scripts/config -e UNFORCE_NR_CPUS
> make

This seems to need extra work to run config script for each randconfig
build.

> 
> Or we can create a pre-configuration file, so that randconfig would do
> its work based on that. We already have such pre-configs for powerpc
> and risc:
>         arch/riscv/configs/32-bit.config
>         arch/powerpc/configs/32-bit.config
>         arch/powerpc/configs/64-bit.config
>         arch/riscv/configs/64-bit.config
> 
> Maybe it's time to create a generic config of this sort.

It would be nice to have a pre-config file to ensure this config won't
be enabled accidentally by randconfig if users are not aware of. This
would also be consistent with common build flow so no extra steps are
needed.

Best Regards,
Yujie

> 
> Please let me know if that sounds sane to you. I'm not very familiar
> to build system things, but I'll be happy to help implementing this,
> if needed.
> 
> Thanks,
> Yury
>  
