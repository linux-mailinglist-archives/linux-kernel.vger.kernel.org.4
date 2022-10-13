Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615DC5FD2A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJMBd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJMBdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:33:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30B134704
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665624801; x=1697160801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=924nIdPlmOGvDQ8x2MRZwA/RiRTuxYh1dItG7pqMsyk=;
  b=I6QyRKdRAP0FKiomWm1dR/QiMOk1XuzDjUx/xvirIfHGuI0Q0aydz6iP
   4E1JqMkCxHPCWMXCdeAmDkMax/sxFSoPV08PMOwycav/pFhY7z+InnYcz
   A/kWxQSbGCOJLqPic9/ABTF/hx4Cnc3M3CCnHuSOLT/XY2+HmaBLGxksA
   K2MROEtR2oTIi+iIOPjVTD5XWgGVi6rAD7VY3AtQAbmAPY1rx0u9L1/mq
   xfV43PtFF46CD7SYQrtxlvglMSSVei0a8aJGTqz/fMK4Z0C9T+RroZ7rv
   3z+CcvhQ0o6oxhAS+FaSvhp+XUYZ7AyWUQTN7AM2bzw8IsJGSH8WTt6Ht
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="288220024"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="288220024"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 18:33:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="769426074"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="769426074"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2022 18:33:14 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 18:33:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 12 Oct 2022 18:33:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 12 Oct 2022 18:33:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM6SrqLJaO0owXeDitVTM7ApA89k6YaIGKxIGfRFboQLg7H+Z8/akF4QQi1Xk4nM19StyhmxscKx9pZ08hgPJsBzJ+aeZdhFuaujBQn9dRAK4GPNDLD2rn3Cmlt1UKu7siBGi2GQbbRi+ap3lLEgp72viOmFtv3otFVuv3guLpN1Z3ovpR4VFZjCifNjKEUk3pd7SLDMas9zGqRG0VgMS4drkJGnro0lmHuYyBDQbY/c7HpnQIVxiXZugGM0Xcn70i7lD8gM8oTTVyATmM+7wgPszR0J6fPKqtmFnH2v6bRJQFsM2xP29c8kya+HRRrpGCnYDW2jSOZ+Lp8idnYU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+20L0fWbJyyqt/dXvsMwwa0zIOR4Mo0B0ErS0SW8SnU=;
 b=D6Co33Me6MjKqT52FvAZFAu4tMG9wyDVeG5MsDvOGovBtCREfdXf2N8NkmJOPOSH1ipCMCZGJpx4mdJ1K5j3/LLljDlmPgVQ4oGLJWRDr2DF6dzRRx2F/5QGZS461ZN6JWrHM8ad3qdY1pn5RwusppP17uxAxUML/sfIsAmXtrBypI1AsmjdIfJQa9XsmqAO3uQyQQHZ6bgRV/FPBLsf0f3VuXlhH/0OE3xUCfBmaMIl4WFw7GMg6CDrzYTeFhfcOoQ38IGX8wxinwgGgxooNnK0nOdmO2MStrnzp04UqKXLNVkvuYzT/Qbr1xMxUIkPPz2b7VsyTUTypEB4XgXqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3717.namprd11.prod.outlook.com (2603:10b6:a03:b0::12)
 by LV2PR11MB6047.namprd11.prod.outlook.com (2603:10b6:408:179::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 01:33:11 +0000
Received: from BYAPR11MB3717.namprd11.prod.outlook.com
 ([fe80::e3a9:2e44:76bf:8c28]) by BYAPR11MB3717.namprd11.prod.outlook.com
 ([fe80::e3a9:2e44:76bf:8c28%7]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 01:33:11 +0000
From:   "Yao, Yuan" <yuan.yao@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Thread-Topic: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Thread-Index: AQHY3cA8G+rUHXTHGkezKzq8f0LSDa4Li1jQ
Date:   Thu, 13 Oct 2022 01:33:11 +0000
Message-ID: <BYAPR11MB3717FC0492B36C16AAB95F2095259@BYAPR11MB3717.namprd11.prod.outlook.com>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
In-Reply-To: <20221011222425.866137-1-dave.hansen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3717:EE_|LV2PR11MB6047:EE_
x-ms-office365-filtering-correlation-id: d710bc3e-f781-4a87-5e29-08daacbae3ba
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zV2pmlVYOk9HKrMmyKm2DAKY1Ki3DkH423gJD+q5IAFkGks/WFV0XCEGBiiRa389NEwfpERkTNRZx2XfzdPqZMVS9hoZerIdp6nLNoF8QIsndY8Nm+sXWmDk7DSK7e9mY+1LFORl9Xq9JJumoGXBFBVtYdVPcrg/uf1xz7IAPyr6CCV2l5IObl4xYJhK4aRL2rxEx3rZhnVrV7oRYhcie61KKxEj5DMUtR4SIgqJnS3rRbE/DmpDRfA3w+4ewXTRpumqe45e70CBctYk5v7UlD4IgcElXd0kbzeRAg1hT48PpAp8Rwu3Fg4p5AVKzfkXJM4yM7W0TCF8LqrkJb1vziJnAtQJy2qIKMv3D53XNGp2eqjmTVy2K2waHsv+/IHl1TewY4jJyvPpku6Vww1tAuvpdhRKx0JTsTrdleFRrk7hwfwP/LYfeZacNNsb5uQ2RJxFWfR5/FnPs7lQSE2/zyNqBEaEl7+Ks6tEFMYTsucSG4HgbHffjKNNWuyAfJcx5PX2iOorsyrupryo7Z1CW11PMz6R7WiOkk3/jE4VVJWz3cb5aaIYDSnpVO+eDymSagUOjbgH+Zle9NenT4Ay7kHnNAllV5mIoxfxZazeLYsTGNvEgO1Qu2iBzgENNXwJLaA99WlJh//GXMXf2BMHFXvuV8pdDHWsHUHmGy0ZmWU1ZaaCrFuOv1o3C7V4NCwELlP7zvA05vhLlkwe8KQG1T+L5g050BY2lPjnkDBKZUl090AIW1Q/8G1tR1IsMTkBORn2oII8+F3+kaLpzn1/+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3717.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(26005)(6506007)(7696005)(122000001)(82960400001)(38100700002)(66556008)(64756008)(4326008)(316002)(55016003)(8676002)(66446008)(66946007)(71200400001)(76116006)(66476007)(38070700005)(86362001)(33656002)(186003)(83380400001)(478600001)(54906003)(2906002)(41300700001)(5660300002)(8936002)(9686003)(110136005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EUt1C6tSvUWM0S/PMoPsDQ8pNzaCNaTOC7gKosm0fApKuuf8/OAtY1XpO3G/?=
 =?us-ascii?Q?UHTYLq/R6rEQITyNGbDY2AF/ZenpY8V5dKM98c0vm761mEvoPEzHNbRNi5t1?=
 =?us-ascii?Q?xwM+FZY3huBjs8585jqc8xJLLZy7sJEhmLoWHJTv2Cw0kY7FLtfF38+HJVYg?=
 =?us-ascii?Q?8/lFNx1qSRV0UNTUj/mH8qE3F8eAKP9sOa8Vug5EvEc230A2kwTIBt3zptWY?=
 =?us-ascii?Q?tZOFKw8QzPjoHMdlM/G9dJPFp6Scsfv0MtaEDl/p8Xaag0ETgWCiXZKEN1JH?=
 =?us-ascii?Q?LN2awLbH/mZDKyxGTUjEo1SFI++ToazaIRUw1TPAiz6kApKCApnAFZQwusH9?=
 =?us-ascii?Q?t3khbMduSbDw4VtlZauryYDED7SiI6j/UisxbEIicVEmbSg/fIhkKrfcEndw?=
 =?us-ascii?Q?FMilM9l2uZ/4/oLKKZ4EJki2Zr5r4QyHhIt8a1XYOVOpZZAoI1yunnIxkCXx?=
 =?us-ascii?Q?7QNMGEB9FR5e7mDnLxIGjHoPlvkOKDmgduajsD2wqBzuumt4WZgBsBlWqPKA?=
 =?us-ascii?Q?q1HMueiuuYQ/XKvVKTkXTuJiGpgyaJkYx7QoVWC9L3KXpGx+ZwQKBNZqwsm8?=
 =?us-ascii?Q?AcMkd5BxZe3iVGH+MqdhtY0yOKN/4x6o74e6XbFpp7JfcJRLPYugwH3qht/p?=
 =?us-ascii?Q?89EAn38SmdDTHCl6UufjWNSxcttwHgPu7k4vy8XGsbB22lPeM+1xqG66FUuL?=
 =?us-ascii?Q?2AvUMoORadEi9fLFt9IgeNAULz23aGTOy6NZchEdu3WzTi16pz0t+CrppS7i?=
 =?us-ascii?Q?3NlneNepeD2VzG02guwyrQguKxoDpW2T0h8nk2m9dLc6/SPQVXIx8okoKOz4?=
 =?us-ascii?Q?ip3kNy31WeiZUBluPZO1Vs+OyEu+snRrY0I9F7y60nrixdAD/YnoDFcSJscu?=
 =?us-ascii?Q?4akolAr09w2x743UcA61iAweM4HcQSvOqYnm/FNEQ9aL3RQTqIfh9QAfDW5p?=
 =?us-ascii?Q?pOaE6RndpTTY99/b86CSQvVW2V9tuWc5GGGrVK3RkBeY4DN7QZmc9P1Z3tHh?=
 =?us-ascii?Q?IK5aCdaoDZVscifFEjzc8kEOnzkxvVKU2UPdH+yZv/JTFql2BpPSke5vjqvN?=
 =?us-ascii?Q?wMGbb4qRVTEvqOUMTVkC725lkqPCcwSLu4+fG+mOb9Vmuo7Fw45NTCfAcInc?=
 =?us-ascii?Q?Fw1JkfbQ+7G9IOepVqBuD1QqlFCRLVS7AT08UCOLWlHcclbjUuyXSH97B53a?=
 =?us-ascii?Q?dRIW3BgS9WfBeYD3iXcYTy+RnULyI+6YjWFISDhlTOzN7SgFLtnOvaGadKpb?=
 =?us-ascii?Q?Lq2ARJCFFNui8F+cl0hCkJITp11d0zVJ5BotStYFGrwvA4utFXSUrK+c8gx8?=
 =?us-ascii?Q?Ko5hUqS5Ne6hzsD8188C/Xmc1QbwWqCHeVsXJYEGmDpk72+WuIVMwX+Uj2lj?=
 =?us-ascii?Q?BzHPnyZZ2BYuBqTBOqPXmprFFF8daSi8YaWxw1bGYSaFdX7AecySZvDZU84/?=
 =?us-ascii?Q?50Ua7fYVYmKbueFsckdCszyytzLiW4ia5LtThxSeAPMcd9UTPF/1AbRUVopr?=
 =?us-ascii?Q?7x9wDCpn73ZeWz7jdlGAOTdXmkXA44WL/UrmookC47ssjBlmgKm3/PxpSvj6?=
 =?us-ascii?Q?AT4VQcgoCD0aAtf6BejBEw2sayVzepy8utczP0Of?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3717.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d710bc3e-f781-4a87-5e29-08daacbae3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 01:33:11.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cwz4UHYsRmzwC+Gsj9IjBYkF/cbddY5qYt+4LJX4BYlkgmIRtanMuyKejPXUz0sDWsrvlXgUNOKY7deEJaM41A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6047
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Dave Hansen <dave.hansen@linux.intel.com>
>Sent: Wednesday, October 12, 2022 06:24
>To: linux-kernel@vger.kernel.org
>Cc: Bae, Chang Seok <chang.seok.bae@intel.com>; x86@kernel.org; Yao, Yuan =
<yuan.yao@intel.com>; Hansen, Dave
><dave.hansen@intel.com>; Thomas Gleixner <tglx@linutronix.de>
>Subject: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for init_f=
pstate
>
>From: Yuan Yao <yuan.yao@intel.com>
>
>This was found a couple of months ago in a big old AMX
>backport.  But, it looks to be a problem in mainline too.
>Please let me know if this looks OK.  I'd also especially
>appreciate some testing from folks that have AMX hardware
>handy.
>
>Builds and survives a quick boot test on non-AMX hardware.
>
>--
>
>=3D=3D Background =3D=3D
>
>'init_fpstate' is a sort of template for all of the fpstates
>that come after it.  It is copied when new processes are
>execve()'d or XRSTOR'd to get fpregs into a known state.
>
>That means that it represents the *starting* state for a
>process's fpstate which includes only the 'default' features.
>Dynamic features can, of course, be acquired later, but
>processes start with only default_features.
>
>During boot the kernel decides whether all fpstates will be
>kept in the compacted or uncompacted format.  This choice is
>communicated to the hardware via the XCOMP_BV field in all
>XSAVE buffers, including 'init_fpstate'.
>
>=3D=3D Problem =3D=3D
>
>But, the existing XCOMP_BV calculation is incorrect.  It uses
>the set of 'max_features', not the default features.
>
>As a result, when XRSTOR operates on buffers derived from
>'init_fpstate', it may attempt to "tickle" dynamic features which
>are at offsets for which there is no space allocated in the
>fpstate.
>
>=3D=3D Scope =3D=3D
>
>This normally results in a relatively harmless out-of-bounds
>memory read.  It's harmless because it never gets consumed.  But,
>if the fpstate is next to some unmapped memory, this "tickle" can
>cause a page fault and an oops.
>
>This only causes issues on systems when dynamic features are
>available and when an XSAVE buffer is next to uninitialized
>memory.  In other words, it only affects recent Intel server
>CPUs, and in relatively few memory locations.
>
>Those two things are why it took relatively long to catch this.
>
>=3D=3D Solution =3D=3D
>
>Use 'default_features' to establish the init_fpstate
>xcomp_bv value.  Reset individual fpstate xcomp_bv values
>when the rest of the fpstate is reset.
>
>[ dhansen: add reset code from tglx, rewrites
>	   commit message and comments ]

Thanks to Dave's help on this! The new comment message is more
clear and easier to understand then before.

>
>Fixes: 1c253ff2287f ("x86/fpu: Move xstate feature masks to fpu_*_cfg")
>Suggested-by: Dave Hansen <dave.hansen@intel.com>
>Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>Signed-off-by: Yuan Yao <yuan.yao@intel.com>
>Cc: stable@vger.kernel.org
>---
> arch/x86/kernel/fpu/core.c   | 3 +++
> arch/x86/kernel/fpu/xstate.c | 7 ++++++-
> 2 files changed, 9 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
>index 3b28c5b25e12..4d64de34da12 100644
>--- a/arch/x86/kernel/fpu/core.c
>+++ b/arch/x86/kernel/fpu/core.c
>@@ -526,6 +526,9 @@ static void __fpstate_reset(struct fpstate *fpstate, u=
64 xfd)
> 	fpstate->xfeatures	=3D fpu_kernel_cfg.default_features;
> 	fpstate->user_xfeatures	=3D fpu_user_cfg.default_features;
> 	fpstate->xfd		=3D xfd;
>+
>+	/* Ensure that xcomp_bv matches ->xfeatures */
>+	xstate_init_xcomp_bv(&fpstate->regs.xsave, fpstate->xfeatures);
> }
>
> void fpstate_reset(struct fpu *fpu)
>diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>index c8340156bfd2..f9f45610c72f 100644
>--- a/arch/x86/kernel/fpu/xstate.c
>+++ b/arch/x86/kernel/fpu/xstate.c
>@@ -360,7 +360,12 @@ static void __init setup_init_fpu_buf(void)
>
> 	print_xstate_features();
>
>-	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, fpu_kernel_cfg.max_featur=
es);
>+	/*
>+	 * 'init_fpstate' is sized for the default feature
>+	 * set without any of the dynamic features.
>+	 */
>+	xstate_init_xcomp_bv(&init_fpstate.regs.xsave,
>+			     fpu_kernel_cfg.default_features);
>
> 	/*
> 	 * Init all the features state with header.xfeatures being 0x0
>--
>2.34.1

