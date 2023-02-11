Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02AA692D60
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 03:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBKCcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 21:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKCcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 21:32:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D67A38B4A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 18:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676082722; x=1707618722;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PY8J2jvP/dSiFGA9odzPC8L1F6QvfRcCsEH2I5UaZBs=;
  b=QkdeMSQ+/AkDW2YAIxnl7NYwYAYoR6ovhpJ8fqcWBSeqQQHWs/B/63Pz
   BsL8PuFqg+NJTjSeOygslAzzMtQMINVfLPNIhQhv3NFr8qqX3Zen0pZjI
   Y3mqiBCXSgACFsPjItaKcihvz0lCVsa32rA+WSQBIHeP2ymxjRfoOXWYs
   W3sh4Ml1VFXdbwqwNl8BsjaX/826lxh63LT/fT/OdW+MAcXmxxyumlbUl
   +7nYcWQ3o/Vg6H9iP+E7hZm7IV9wbAwYAAea11j1ZaHanJMGFQbPMTVk4
   dR5p+f9/AHQhGHITZfy4AYcPN3247eIoaKXTllxeqcBrOdJb8l6M7XKae
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="314215936"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="314215936"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 18:32:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="618081607"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="618081607"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2023 18:32:01 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 18:32:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 18:32:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 18:32:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSMM11v8LSCs/ncQ8VV36qFU8fUbWdCwM3Xc9SKUPZHqi8VeZkOVwfW7KAg4Two2SxfSfpsAadMS/MEl/zb8LRrSSyCIJdVXMe7a0jlwxT2Et3+XMjDagcHj4i/vvKlbbzDtTrYiNHdgBQEPdcI78kv8tJMmiav7z8DQM1e4R43N4BaijSulUk/8vVkMWAXQpPvMv+CM7NUSNpq457sjYHbCOaCbcg1Cz3u8jsey3wUIbcrnXRxhaD3DvhbHaDMYYt4VARrtz+lcMajmtFWt/EWkswJ1tE5z5qd/lQVXPJmX0qAiEnKagi0xx4sFfgkbgJ/DHeB7EwGXS1Lh3QXgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwoOCja9aX2mpKL0yOnecMb0NkWerXOYcseed+ZpsCw=;
 b=TAWaDMaEJBt4tw9TGOoywJ4bxh+vfBLlJJYIAC+HlYl4maim/ROgfafDz/oSjNS0TJLOxRl/Bwgg5MwjQaOmc8/vKELTt9YJfNiMyqReaNl9+Wj77FLBoZnV9WBIfzjllWQgZqowkau+zS5dHppSRaw6PdKEMmpQUhhOpPldnZKoiN9CRRfBD1j34TtyO/EITVXeoFip9m+BhEmyfRcadBLKSkqEOmVV0UOUYaENRCRlQpsTdQxMnfjigxU8KCVa9uJEVfC3ZYVyB0KN+cS/747HhnRy6u6hXyJFt2nvdDTLz+tMhb22UF0EsoJqNuA7R4jSSz6MyTgD1Qawpu8r2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Sat, 11 Feb
 2023 02:31:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Sat, 11 Feb 2023
 02:31:58 +0000
Date:   Fri, 10 Feb 2023 18:31:55 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] NVDIMM and DAX fixes for 6.2-final
Message-ID: <63e6fe1b27ea3_88e129491@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fef1e8-69e8-459f-eb9c-08db0bd825a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FC0jVuvSDqNkonKRBFCB4CPD4c03arwbHRZCYN7WHIyL1TnJPJR7hzbWAQp95xWSyn4Dyt+wyfW4cvtA6bhAk1ym2HXdbrUG5NRqHpr5m/ahMk+Pk/HgHzhLGcvx57WSi/LLji7W5SvNOrIL+BNXEy9RBbDU6AL5OnvFxsXdSxl0jg7/Dl2vGqyCkf2ZZMEoQPpA3d/tX6is85+FZyTbfDMiXKYhE+wNTIlB/hDkJ3UNMZXF6/+vL2m8WEM4nGrRLqhh2YXhoZMlSQsQFFzMGiUz1SfN42xVgbQmoINyqCZ1G+u/ax43+MEbG0xT6q0uGTssugIj0hULy73r138KLe2fpEWIoy98rHxFKYC1xkyUAr6l1JZ21IoHT0WPfzP/+4KFVTrQkqMIzGiv91YiHO2SoI65I5ray8tFagyOUlbyzYV74oBUGyHQxPa2ykW+Y8eE245f02AylK0DoULMDEZvmRaF3W6QXXRya1hBF0q4vCuMipjvgyTgASb/ASNMAVdwhpkm4Q2bsKgU56DdQHwppHj4FmdxryMKTMxaJotYZ/RRgR2bTArP3EQL2BWIkAmEgCqeM7hY1Qe99OJEX1PzYTusDrQZc4E+mQX+3AT44ZeCa0gcXjPWBGLTypgCE9FUcKPZS2Kaq2q2Mia3WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199018)(6506007)(26005)(186003)(9686003)(66556008)(6512007)(86362001)(8936002)(6666004)(82960400001)(2906002)(66946007)(6916009)(4326008)(66476007)(5660300002)(38100700002)(8676002)(41300700001)(316002)(478600001)(6486002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fGBUGVpSyMQuVEPLm8Ou5wXAQXxCEC18EOOKNx0Q05vs8HIF0bwtpGV9bWMq?=
 =?us-ascii?Q?iZe6cFk1Rle1/s1dgwp89p+Dzkr9HH2/VTGFq0j2fC4O6rP+8nZRv8cNmauF?=
 =?us-ascii?Q?uDOxeS7MaUAftLGePO/yRxxQnDDkZzwcKHOpAwcjiQe0e7JdYu6rsXT1BOl2?=
 =?us-ascii?Q?DUUtZzTT7jf71ywbgqvyIW6OJ5bTYGXYkU1y6wmr/sK3x0N2mnSuAQaikLzx?=
 =?us-ascii?Q?YIPvwtthQ4wmMBAHKuzNfm/6ig9SNwpIUJE3Mls5UABVxUAn7d4nnDBfquTM?=
 =?us-ascii?Q?n3umObCjb0KutZ0YaCyXvVK3/kW8a5vkvCyhcUiQw5h1TBIvNoKis3s+aGid?=
 =?us-ascii?Q?ug6iqpzWSwM+LIRkfSj6hgXqR5IPEHvXQ3/txHnHtxGahyGDrPxGf3EEUuyh?=
 =?us-ascii?Q?lFSvKPbEcyYF6lFs7ztzGEFC4ajYExplGb37gUo/3CLiMOSiTl/JofQ7xNQR?=
 =?us-ascii?Q?rNpzs4FrqvAypAKX0vDwXXYuznFhxpJH36EDXuP7G2vRpVzALxnRmGxjk4nf?=
 =?us-ascii?Q?xmJdZHHACtZR6iCCds1ID4FMptfUPzv/AQ4urnRxKMhjdXHCixfOiweKcMmG?=
 =?us-ascii?Q?Ujggcauaasms2jkphfMclfsBM1WEk8lvvT9OykAdhYoXTE+ddNe4IHnWQZ1r?=
 =?us-ascii?Q?uzHV2Qg0FR06QxQdCq8rv/j/A4DMYYBI+oDZbRF2Rd45IQd0ezJ16nqjAM1Y?=
 =?us-ascii?Q?VIXAqiAqDy1oFAKzfbvN/ifdtyQH58ge7/cPed1mAPu9jIsmjf1vDb9IgfFm?=
 =?us-ascii?Q?Pt7WsVfNA9bA2jp/Cul9UvFaoj2c24F5lVEW0vsdQoU8hAamPApy21bSFax6?=
 =?us-ascii?Q?RwXrta9j47g5UBafIyD+EL2ObwdHIqxhQayw/U/Dy6wK/eTvQGkhb5+SR5T6?=
 =?us-ascii?Q?RX3cd4dEn8uvRLKdasDI0pGiRlnZy4SUb1RPQ+mkix3/7EPBdvS17D/HvNSi?=
 =?us-ascii?Q?zPz+nPATmgvKJrLEEnJuxfuo97ffOzPV60yBlAgJTDTxFbog0voCoRjDtRoq?=
 =?us-ascii?Q?DEy2LWeP6TB09b2oZ/Z/TpK8kw3CFT3OXThYQQcm/B/JRdf1qcL0nPLy4i2X?=
 =?us-ascii?Q?wgxc4N+cKheVwvPPBHJooMETEQBwXJ2lDPkWXEd2c7Bn2rLIIopgabNGaeaE?=
 =?us-ascii?Q?YwFsbvMgBLUWFlhUlazJ1O7FgYWyegKuAE4hVdasb4tynzcDpljtdaGOKKpe?=
 =?us-ascii?Q?Al2pw0ijD8tSl7roPNpj/3TtdGg3iarcHzk1pbEOqOssWYhmCJPjuNYv9FRT?=
 =?us-ascii?Q?1SV2fioUW2ERnsMMXmzJhlh8lgzZ01loaY1SOrBJIEFeO6bCbhxCSIqiUGRT?=
 =?us-ascii?Q?LaA/spCFztwlh9duKRbRmFSGj8SgxB55PZF42mbSztss4tNCXmxWg/nsdEoL?=
 =?us-ascii?Q?GbwLFtkW9Cg8GGNLu4gWKua2RQQh/nzdMWBr9s5Xy14lSaQQxKlNjr7wrexe?=
 =?us-ascii?Q?gcdK03ylKPSD6Zng+pL24nlHm4KOnad5E7sN2AmmjBYXYvrrs290rCYFKL45?=
 =?us-ascii?Q?QicfINUT6KykS6jKIqIqE/XQmCvuY3DmOYjoF/q/tgaE3dP39KmnQv88DXUr?=
 =?us-ascii?Q?smO6xkEvQc6ciiuDHm8cQieOdboKYr9z4JUiBSiXQ01vS/OrIkCXAgCvu9AS?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fef1e8-69e8-459f-eb9c-08db0bd825a8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 02:31:57.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFA+mfPPqeksUi1rBrk9LyKWvangl4zd4geqMI7nCDlOmHvFcPdxEtfePyjIOeAwNzgB20FJ0fTVqJljU9dfFmI1ybNnr+f1i8uh+uTL99M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-6.2

...to receive a fix for an issue that could causes users to
inadvertantly reserve too much capacity when debugging the KMSAN and
persistent memory namespace, a lockdep fix, and a kernel-doc build
warning.

This has all appeared in -next with no reported issues.

---


The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-6.2

for you to fetch changes up to c91d713630848460de8669e6570307b7e559863b:

  nvdimm: Support sizeof(struct page) > MAX_STRUCT_PAGE_SIZE (2023-01-28 15:32:36 -0800)

----------------------------------------------------------------
libnvdimm fixes for 6.2

- Resolve the conflict between KMSAN and NVDIMM with respect to
  reserving pmem namespace / volume capacity for larger
  sizeof(struct page)

- Fix a lockdep warning in the the NFIT code

- Fix a kernel-doc build warning

----------------------------------------------------------------
Dan Williams (1):
      nvdimm: Support sizeof(struct page) > MAX_STRUCT_PAGE_SIZE

Randy Dunlap (1):
      dax: super.c: fix kernel-doc bad line warning

Vishal Verma (1):
      ACPI: NFIT: fix a potential deadlock during NFIT teardown

 drivers/acpi/nfit/core.c  |  2 +-
 drivers/dax/super.c       |  2 +-
 drivers/nvdimm/Kconfig    | 19 +++++++++++++++++++
 drivers/nvdimm/nd.h       |  2 +-
 drivers/nvdimm/pfn_devs.c | 42 +++++++++++++++++++++++++++---------------
 5 files changed, 49 insertions(+), 18 deletions(-)

