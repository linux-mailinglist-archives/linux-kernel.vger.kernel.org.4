Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308206575EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiL1LfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiL1LfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:35:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D75C65F9;
        Wed, 28 Dec 2022 03:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672227311; x=1703763311;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4zLhmMNgbfRQWxU3HJudDZMX/TItn/S/5Oy2EEzWWsY=;
  b=hPch0IvWeqUhZ+eOe8hd5uiwJTrFntmd7KAcigSkrDiB/MSz3Ie2s8Io
   MdupuSeDFZeeEX0OjWnjRetPxJhPg6jb6X8aPkqqllkYy7dk2L7UCNnKO
   soCXs518N2x6uGO+9JQp0its6AivpiwKhwQClmpKSbYaNfl/8yhDHcfwA
   gMVZTStkEnBlA48VP/1PKUUF4Cyu4XAovyg2edXktW0S8cOOx50bqpIm8
   vUtHRzqkown6zQUKNf48iBjEnHKg1BFH6cX/3pkAet4GEnjZC051gr+S3
   a2loxMPOLtXX0ttEPMPnbOsUNiSsEq9PNZM+8bc1v71Gnt63NYg8hEstT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="322088685"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="322088685"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 03:35:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="827379396"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="827379396"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 28 Dec 2022 03:35:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 28 Dec 2022 03:35:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 28 Dec 2022 03:35:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 28 Dec 2022 03:35:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRstiMVPSOyv+0IH/+y6jf8HRrHbHTF/iTqk2AL4aZz4084HcIOlL8VFmI8AzHz4mAfi7jkyp0nxzpXoxebirJF8+qPQepABeSAHI/wQFF6pC/gTbAhXXHXH3SptbPvw0g8UcJX+DLiPbpJYcdhqhywHjuq6/WbK42cM4pRTXpRrByItMZI2Mu+UhnJQyneMQctx3yauHaH8V0nk9rx9wmcSwAWGIlZx6VjbNogWooIpCh5e27tYycSCBGsDmIOHcOq7W7uzJgFiYs8Gxhneq+z/NxIRYfKT1IBT5vL4UnH6H6qLcO9zFMSyoIMM5e282EESU3MV2623GKT+EFEO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBJg/k3SmYV2MQzkGRmmoJ8HLhRzt9MKNz7WWZZK92M=;
 b=V+gdCyKM6VYKn1004LNpBl1Ha1RRU2FaL1aAbmSPvoLhryUSRhkPsdhHSwH6m1lE0bSe/acQyCOZvRQYi7D8c6eoLeGHp1ADTpL1+xJ4dNwTwUrTby3v8XuxOm+u4B37bhR4nWe/8hMAn9/w04My6ZM63c29kT2xTa0fN7voZwNkI0ZaPiUKqvxGZZHJnig+AGN2umikaLQn4Ca3+T/0hlfMRwmekKnAGtQupvqPhETGP1pqZt1JTm76eswzCNWJcajR6DJYmGeATuOVvzyo2dKZn3g2teqVs2nipFFUmz6KmBUt6+YeeYFTdQKvy7NnBTgHH6c/PGIZ/zeH+slBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by DS0PR11MB7459.namprd11.prod.outlook.com (2603:10b6:8:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 11:35:05 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::499c:efe3:4397:808]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::499c:efe3:4397:808%9]) with mapi id 15.20.5944.013; Wed, 28 Dec 2022
 11:35:05 +0000
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH] x86/rapl: Treat Tigerlake like Icelake
Date:   Wed, 28 Dec 2022 06:34:54 -0500
Message-ID: <20221228113454.1199118-1-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::21) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|DS0PR11MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e722f9e-3514-42e8-b7d4-08dae8c7909f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfP42e3Jug4dYyAkDbpmggvvVrSKm/yZ90XSziekjPdLqbe+Y8P0wnrkSafi0t29kAKBtbpJjPjoqBL3O7gQswl90Sl4deHOcRonURIGoJhitPW1Z1NM+Atm780QgCa4jg3vVvWQEVfWcVBqXOuDt2VLud6X4DCsH0AVH4hUOCNtytiU4nA0KyKi5LFfATxUcHLEQYpvLGNPSzzFCESSQCIelTnCnqphfFizQNM6yOnjqc/vy0b/L3MQZgv6H7ze/3SLl4t882x5MMmu+5PGoimjN+sci7ReZHwlSrqTtkgk/MrxOcAXKWPMlHCS5/cHZNuqFFg9k2F1XSyTVG+YpbKmI8Mm7xsyTgj2fd47W5V9OuRQYGjcXyQgi5pqZJYU44rcr1OELWjWVbcwFtRP6fBCCZC4qa7zgEnyHmLc2iHeLFhh+gdp9ExYEKposFasifFxXc1Elio67prB92fJ2sreieGY+OCg9Asfe2KFpYGUsSOl2Vir+7AyueMnoiubCZ9FaZyP/ilSZ6bRTAOs4ta1OrVwESWM7SSYTR1gUTsXvbjRhTxbqeXz63gn10ifXRwv2PG/wbPwA2Pu3K12j1UUO+axzRp/sfoaQgu5ylx+Yq+0uD5eM3CruRnTcAgujiq0/o1bCWZI0EFGNZpkNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199015)(36756003)(54906003)(86362001)(316002)(107886003)(6486002)(6666004)(478600001)(5660300002)(8936002)(2906002)(44832011)(66476007)(66556008)(66946007)(4326008)(8676002)(41300700001)(38100700002)(82960400001)(2616005)(1076003)(6506007)(186003)(26005)(6512007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PnU412ev8rqlhcJZ6mXY+hgjcB2uqPEhTvNP51AcRnqI2dChVTdBW9hBUAOe?=
 =?us-ascii?Q?HfF7Z2DNo9kOCbPz8rIE3XAR71KxHmGncvjqPK/lgI6sf0t/ftb5Us4Fb0E+?=
 =?us-ascii?Q?ZNIlZYWXm8qK8XHKBbiOAiQCU0KdqTEoANaPh9tbLNaQ1syyaSDyAOu11PYN?=
 =?us-ascii?Q?qWT56CmZRPKgAiM/+WsFP34e2bobF5Ms9kyQW0DMoL10+75u67lUd4+z3CNr?=
 =?us-ascii?Q?bAG/H9sPBM5Y1E+pFEivHdOAOUGXw9qW9szCNe03j1bQElk0iZluNuOC8pay?=
 =?us-ascii?Q?WhAEfX4bNYT9t/l9VbIqMxaeX9CFkQvYlNxG2+OV9e87n1nZYp709Lr52QR+?=
 =?us-ascii?Q?ukL+3AJ35823HLHRBsj1ySkE3P9SyU4mkzw/VqKrroJXgnpIcb2Uy7MHrZIU?=
 =?us-ascii?Q?0t3kMfO4/WZhZhNI+4pNjLIz3OoZkkTY5lEyMkUgGr9JSKEYfNT2Xvdwlypa?=
 =?us-ascii?Q?6+ewVIPcZAG+mBlmNx39bYlypvQgclxXHs1D3rHzpyW4/QlWzSfeUUDVEMU0?=
 =?us-ascii?Q?NKNUCcf0EmCU+S2JYena5GoCP/SbelMkq/81PqNFtEIv88jje3lBxIRc4gnY?=
 =?us-ascii?Q?rmoc3A1ZOIBpIX0Pru0ZvEaAPG1Zbx2rhhKMWPWAoXjo1hOWKd6kpU0H1Gss?=
 =?us-ascii?Q?9+mR9D3ah0P0p1nCJdNdxBBEYZ/Or+gQyOK7JDU6pX9sxe4epygVGee3g9Rt?=
 =?us-ascii?Q?Lo9Rg0+kA8ktekzgNSlWoXd+/nyR9zgVqk/7ByMhTSEpugAi0NPyeDOr4VCA?=
 =?us-ascii?Q?F9ZJ5acECayq4bErW703yAKtgTKYAlu8nUOCj3VzgbAMGRUJzeWtVLkFFLng?=
 =?us-ascii?Q?Hd+x1fA8c89eFZ4DeuCqXXgsttvY5pMyvELLbmLNUJAjojZAhjZ2AlK0uplp?=
 =?us-ascii?Q?aXSHilZozliNlvllSmZI1Eujwb5l6fzL2uZg9II5vktlYu6UYtRpdFSsupS1?=
 =?us-ascii?Q?EsZNmAZPFRJyuZG97qHZcAorL6XpcK3xIIENjtk8Wmt5cafwzaJxzQGe8I+R?=
 =?us-ascii?Q?PYTZBxx0Pl5cvKN2hdcesCCeGYUeQ2OXZeuBRSVYtDRex6rHfnCnV1UE74qP?=
 =?us-ascii?Q?w72Wd8ibDGuLDUKxUC+XzMI/t9L4axwFK4gePmy8KRic47gSYiRW2NSBKPx9?=
 =?us-ascii?Q?mfwJuZAfMujGaN0XcYleDKWD4HlHnU9rfRx18aVH2wqWI0U650DjJpMhPVUB?=
 =?us-ascii?Q?ExvL3yWvK7jY14f3B8Q6yLsPRujAVnBRshFbr8EeiZPHFCo8R/BmB7hWptI1?=
 =?us-ascii?Q?+z9ZAAucZFE5zkdiqN9U9rI9QxhXgxXfaM1zPz/TsL0FUmBIZwsIfyfpA4ur?=
 =?us-ascii?Q?kCUpFq1Xq67esC71Zi5KoORPai28vGhjbYOqNREcP8FTskW6DvPr68PYhAs/?=
 =?us-ascii?Q?i05gtNMteHbGw67U2DuPRuq/kALlR/jZEBlAC3d9QeqTVvU3QJ/3PgqM7Q1e?=
 =?us-ascii?Q?SbLzsUF75910ZtnIU+7K9KxKJ9bTaF8CfEG0yZ9eZHmpBPWOdJ+4q4RT2BAF?=
 =?us-ascii?Q?A6WVSAL5Cusqp5pEk7MIfjW/co3Cz31YgnrfzjhYrFnYZqftK1Q9hTEB88s3?=
 =?us-ascii?Q?/cX47p+0BhQB+o7bQRXUj9uM1gJ4y8sRvWwwR3eUHo+0OP614E1Tp5CEp0ZG?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e722f9e-3514-42e8-b7d4-08dae8c7909f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 11:35:05.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qn+Vo1ngcWbZ3AwIbHE5u6KL7RZlylqGPJlxatj5EWqp4KoDGEPALNd8MmxWx4JY+jkYjnMh4lZH+z0YFED+AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7459
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

Since Tigerlake seems to have inherited its cstates and other rapl power
caps from Icelake, assume it also follows Icelake for its rapl events.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---

Based on the recent additions it looks like Tigerlake was a missed
case in these events/rapl.c and that this old patch from Chris is the
right way to go.

I found this patch on our drm-intel's topic/core-for-CI branch while
rebasing it towards v6.2-rc1.

 arch/x86/events/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a829492bca4c..ae5779ea4417 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -800,6 +800,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&model_skl),
-- 
2.38.1

