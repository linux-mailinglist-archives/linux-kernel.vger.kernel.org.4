Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E934C728EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbjFIEZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFIEZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:25:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11082D7C;
        Thu,  8 Jun 2023 21:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686284698; x=1717820698;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c5Wx4RL2SN1644AYdGMMOO+RtVrSsQMeHL86lSCEtlE=;
  b=jz02Z564LZJ3OxaGhomeq6///f+H4Njg9aKtvSf7Q58obp+DS8ExH9qO
   MtpaKhmV9y8RhTKXfAfXjQnOJb/WrEEQgoVL/CxlB9S1J9Q/+JXQoNah2
   q1e7p95/CVlMMouKRAROoLocdPdZ5Wy5gkb/1WYGIa34Ie+uRyhA0Tk4N
   jKbQ7DS5kSnIpX7LDuo68FxTXrr1bjcCaRYwjIFSm7fFbSrNLkuoCF1MR
   Z6LSaa0S51O/+lAB7vUuQXt+nFBrYlU2iQqgJXYx15p+bpd391ZXF1ZI+
   f8DcZqyeUEc9x/duWDKzdEKcE6VQd8QwLNTAS9Q/C/pKZ/dnPfLkCs10f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="355002228"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="355002228"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 21:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713368201"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713368201"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2023 21:24:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 21:24:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 21:24:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 21:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arHPssPAghA+TeTsBm8FRfp8KWBhY2Bbd722loZSDx1Ivdww9nWOPyIdKfw3LV+vpgFSPAUeM5Eu+dIzVDedNyQrYZvhcalinj1U80V2JJ6j+4ZrBoeYhmI5WJGbZgQ98zZR5h+ZPmyf0GTsbhUnPVFx0VxBfd4bajL0wVmatpn8k9en6rl9mqlJt5SrJmG5lUFprezXAjqhlRwwnbH3xzf84k7k1+x2kiyBu54//Hp+yvG73av87H073R/IislgPo/lWm6TUvgaSPTFIuQTOvrvvaLaFda27rHtnMLb1i4rmp9963EuaEAFo466mrDhfQ90nBh8MtybWdfNge+vlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ynm45KsfLj7DW8QkH3V8E0X5lQrSinyFa17dB0hrzf8=;
 b=SOViQ7yWvUjcFrMl/brdpQ0IN1WJ8jQsQ6sx9P/Daf2Zi/cVJD4DX7Tk7Hd8ZTHGL9VZMfhj+pYIFRThALSB2aYvhNgRzuYyS6/IEmNB46M/+IEZwjnMLKT+0E4XbOEpTpFdWPoJcCADxbSzO/ZwVcsVLOu82omCRI1WVnGIn62nf4N9zTxpOHfmXhitDdokrL8BEjuSpCf1Ye3Ltyxv6AE/xZ4651WO9QKc/gnGdavUASApAIJL1U81cnpe7m0wE0YDEy8AftM319q3GXN1xbcO8C4OLCTkx3mavIPOJAfR+H/zUBVUtcg0nSOnJ8ly4E139eLajFb1mUQHdBjTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8038.namprd11.prod.outlook.com (2603:10b6:510:25e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 04:24:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 04:24:49 +0000
Date:   Thu, 8 Jun 2023 21:24:44 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 08/26] cxl/acpi: Directly bind the CEDT detected CHBCR
 to the Host Bridge's port
Message-ID: <6482a98cde722_1433ac29444@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-9-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-9-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: d6378320-1c23-44fa-4026-08db68a176b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VaeTGYBk1zMUvtpHb2LuF4cGxHmY9PMo7K8d85zM2o8nBARlj1z7rOZlgcfUnhK+e1Zof5n2OBCpVGTV5+Ksqz4dDs55R5O6B/w1rh9m5khtqV1pD81a4Grk14ET4PpsgX+XQv2n3p/Kx7xerkd9qch2ddfAyHO60biJ4MOkJBTWs1qsEemQGfyo4/Ez9a1LbN/snfoF9lFaH0MsKv9AZWYYDRhJnzPlgDLF5Y+1Zkaf+JTjoNfHsxSCbq4HafkLvPWmqZOEzl0qa3404/+fBWKT/Zk2N07Ao3/AjBXq1f2HNAD9kEBOE/VA4iRZOomcCbs4ZZxe7tOfJGTzvnfPbyReQ2uPUjYRRokAPaA8shpR+QZ6F4RwyYLBXIBWsbCfXGfJPfr/VDcRt+5c30cPAeAGsFFyjkhFnh5EjPvFr0QVEzv7B8ZPVKJQ4y7C1xdtObCnvrDKMJVkCpKhEqATUPOtdCCsdOuZvrtam9tK0zJYp43OU6dwIrP9G/zRDgJKXW0gfS7i9C4kMgRilT5i+nL9/wKT9rw4TiorXEhmHqgc/LhqhNkhx8h3z3X0RTPd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(6512007)(9686003)(6506007)(41300700001)(38100700002)(186003)(6486002)(6666004)(83380400001)(26005)(478600001)(66556008)(66476007)(66946007)(82960400001)(4326008)(316002)(5660300002)(8676002)(2906002)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oLeUVfEtLLxglpDUauQutrqRlgCZ0v0uMEiJ+KYK/Bnf2wvzHEd13u/67mmV?=
 =?us-ascii?Q?/cRnJCEzt9JsmIBIsv7YQkfKBUs6n2cNs+P2OAcudZ6bjvBDzP3+ggaCSkH6?=
 =?us-ascii?Q?mhxImmkiOOAHLOPHidafYIxNF1luCmcoFhY4xGHYZ6LI3hfK6jpUmLR/uQn2?=
 =?us-ascii?Q?uKUYcpKDU4Soy2qizMRS1Dxe18BE3PAUP2pOYT5XPzY4GR2nkGozR/4s9u3c?=
 =?us-ascii?Q?Z2FaoPZ5PzGHj9TsiA2UiC3WcBAWGw5j4ASp+ReXF3MKdXGZFOdn9zWUgat8?=
 =?us-ascii?Q?aOoWCQtOjLuH3Sfmrnce1UiEE3kO9q20YNQdrkeWGlCydK5abbTHZTOQlhpu?=
 =?us-ascii?Q?xP3elW4tDPAzTsjoDSG452o06ru0xxKMY4tha8M33oIl0VEfATDnHTOr4PBM?=
 =?us-ascii?Q?WkLeNKmK5O8/8WuYYQk/rVgt5Ex0VaWZFdGnHsxLYuLbnETjc8DsF1BkhHrJ?=
 =?us-ascii?Q?+TYi+L/IhTQ9E3rbpaOL23K1Hn+nnsnqRWjdef+Li60ns4l97XFfLOVQ95kS?=
 =?us-ascii?Q?kor4xB+QjQ7P7xt1A8Wx04xfozShvw4DVAxI7WCaEysiyoUWOYQvQ/goz3V9?=
 =?us-ascii?Q?V2eKxLTq0WmAzyjkCZs6gydob18W+2c4L68KhX29MYyl+drFSnk//TmVlczr?=
 =?us-ascii?Q?h32MXJKW5H2FDE0WEglPY07zxk7bjYXplUkZE5lAjz8bF2sw9kDxZc7v3Zm8?=
 =?us-ascii?Q?Dw78+juMg0A6kqp2tA84GR4PKM5agwrnVa5Dt3UnQpxAMFXhoGu6iVoiuF5D?=
 =?us-ascii?Q?9TZYDJyoKo++dgBCY92d/IYP4iFodjSFfHBSN9G4BPUNqxay84e4rtZQInRQ?=
 =?us-ascii?Q?unQBDcvzRs9mAMN+Wz988jOmPRgqRKAvsQ9PkbNkKkuj0HtxwY+6TgrkOkrl?=
 =?us-ascii?Q?PODthTJv6b13ww1jR1dvR7tQJ61ciL/fTlqy2z84Iavnx+jU6Vew6TtKN7qL?=
 =?us-ascii?Q?yTS3Ec5wx4fAsoAshfJ9loS1FvtGhktT038iNtrT37y6e01do4tfaa96hx+A?=
 =?us-ascii?Q?PJnv4aEQSBCAgAWkLGybI+HK+lY9h30TI/PJIOiM+VTT0znod0gcUv8UaAyj?=
 =?us-ascii?Q?X9g4QlqNl1L+X/Az3GSIU2bI1+G3jQCqhOyVpMFwpYFv4PLhpZ5+BBYta4ES?=
 =?us-ascii?Q?TPaumrCYGDpJHxeBGvHDrW9Se0Ds7592uYgXEbcfyJhMBssmxmRMC2DUxxFB?=
 =?us-ascii?Q?OHG5K8oLuzo6mm5/FJaony4kMhrWSbJu1y3Cli7hvfDGlTZBaVOC6Jo+UKah?=
 =?us-ascii?Q?dT56EjoYJ8EEb8eI6zfnZaoLbPHI8/dpETc8UthVnIf8mq5XRGLAMxvY8fG6?=
 =?us-ascii?Q?jcr94UbZx4OzSbmgPtloOzuYSFfz+Ej98Gt0T4rkBfHgwk3Sy1/G8tHnGIdA?=
 =?us-ascii?Q?jKbgk+gT1xuY9tUxiobSWp6w/kJrvapa+jIxO//Z8d1CxChDkkvL/R+42sn1?=
 =?us-ascii?Q?aS09M0mGWkjJof4kjPFpa+t/wsMDGVVomI8q6COMwEBahivhbGCRs7iy7BCI?=
 =?us-ascii?Q?S9SKv7fap6w57nkBBfsp1pH+dqg79RUhzw+TYMzL9mN6+POyki64bXYKY5nr?=
 =?us-ascii?Q?IoFgmsuPtODDiSC5H0tVtgG33JUC69qNUI9KLU7bHjwDvVoBAAb4ZBERHdDM?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6378320-1c23-44fa-4026-08db68a176b1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 04:24:49.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpXZFEKIB+rLJBsr+wgLN58LHCzBZRqBPi3um75PCwMFnigw9Kx/dzTYCzOGQBMUk+0Jxl6grqcbMyPBCJQZvb86SS5N8OGJNUFrCSnALGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8038
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> During a Host Bridge's downstream port enumeration the CHBS entries in
> the CEDT table are parsed, its Component Register base address
> extracted and then stored in struct cxl_dport. The CHBS may contain
> either the RCRB (RCH mode) or the Host Bridge's Component Registers
> (CHBCR, VH mode). The RCRB further contains the CXL downstream port
> register base address, while in VH mode the CXL Downstream Switch
> Ports are visible in the PCI hierarchy and the DP's component regs are
> disovered using the CXL DVSEC register locator capability. The
> Component Registers derived from the CHBS for both modes are different
> and thus also must be treated differently. That is, in RCH mode, the
> component regs base should be bound to the dport, but in VH mode to
> the CXL host bridge's port object.
> 
> The current implementation stores the CHBCR in addition in struct
> cxl_dport and copies it later from there to struct cxl_port. As a
> result, the dport contains the wrong Component Registers base address
> and, e.g. the RAS capability of a CXL Root Port cannot be detected.
> 
> To fix the CHBCR binding, attach it directly to the Host Bridge's
> @cxl_port structure. Do this during port creation of the Host Bridge
> in add_host_bridge_uport(). Factor out CHBS parsing code in
> add_host_bridge_dport() and use it in both functions.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/acpi.c | 65 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 15 deletions(-)

I like where this patch is going. I needed to rebase and fix it up to
get cxl_test working again, and spotted some additional cleanups along
the way. I notice that after this patch dport->component_reg_phys is
totally unused. So I would like to see that removal patch comes next in
the series before going into the port->component_reg_phys reworks.

-- >8 --
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index eb64dc7a3d8d..7df6c6f5e902 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -341,7 +341,7 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 	struct cxl_chbs_context *ctx = arg;
 	struct acpi_cedt_chbs *chbs;
 
-	if (ctx->base)
+	if (ctx->base != CXL_RESOURCE_NONE)
 		return 0;
 
 	chbs = (struct acpi_cedt_chbs *) header;
@@ -350,8 +350,6 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 		return 0;
 
 	ctx->cxl_version = chbs->cxl_version;
-	ctx->base = CXL_RESOURCE_NONE;
-
 	if (!chbs->base)
 		return 0;
 
@@ -364,17 +362,26 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
 	return 0;
 }
 
-static int cxl_get_chbs(struct acpi_device *hb, struct cxl_chbs_context *ctx)
+static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
+			struct cxl_chbs_context *ctx)
 {
 	unsigned long long uid;
 	int rc;
 
 	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
-	if (rc != AE_OK)
+	if (rc != AE_OK) {
+		dev_err(dev, "unable to retrieve _UID\n");
 		return -ENOENT;
+	}
+
+	dev_dbg(dev, "UID found: %lld\n", uid);
+	*ctx = (struct cxl_chbs_context) {
+		.dev = dev,
+		.uid = uid,
+		.base = CXL_RESOURCE_NONE,
+		.cxl_version = UINT_MAX,
+	};
 
-	memset(ctx, 0, sizeof(*ctx));
-	ctx->uid = uid;
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
 
 	return 0;
@@ -384,7 +391,6 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 {
 	acpi_status rc;
 	struct device *bridge;
-	unsigned long long uid;
 	struct cxl_dport *dport;
 	struct cxl_chbs_context ctx;
 	struct acpi_pci_root *pci_root;
@@ -395,24 +401,19 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	if (!hb)
 		return 0;
 
-	rc = cxl_get_chbs(hb, &ctx);
-	if (rc == -ENOENT)
-		dev_err(match, "unable to retrieve _UID\n");
+	rc = cxl_get_chbs(match, hb, &ctx);
 	if (rc)
 		return rc;
 
-	uid = ctx.uid;
-	dev_dbg(match, "UID found: %lld\n", uid);
-
-	if (!ctx.base) {
+	if (ctx.cxl_version == UINT_MAX) {
 		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n",
-			 uid);
+			 ctx.uid);
 		return 0;
 	}
 
 	if (ctx.base == CXL_RESOURCE_NONE) {
 		dev_warn(match, "CHBS invalid for Host Bridge (UID %lld)\n",
-			 uid);
+			 ctx.uid);
 		return 0;
 	}
 
@@ -425,10 +426,12 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	 * object later in add_host_bridge_uport().
 	 */
 	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
-		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.base);
-		dport = devm_cxl_add_rch_dport(root_port, bridge, uid, ctx.base);
+		dev_dbg(match, "RCRB found for UID %lld: %pa\n", ctx.uid,
+			&ctx.base);
+		dport = devm_cxl_add_rch_dport(root_port, bridge, ctx.uid,
+					       ctx.base);
 	} else {
-		dport = devm_cxl_add_dport(root_port, bridge, uid,
+		dport = devm_cxl_add_dport(root_port, bridge, ctx.uid,
 					   CXL_RESOURCE_NONE);
 	}
 
@@ -471,19 +474,17 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return 0;
 	}
 
-	rc = cxl_get_chbs(hb, &ctx);
+	rc = cxl_get_chbs(match, hb, &ctx);
 	if (rc)
 		return rc;
 
-	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11)
-		/* RCH mode, should never happen */
+	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
+		dev_warn(bridge,
+			 "CXL CHBS version mismatch, skip port registration\n");
 		return 0;
+	}
 
-	if (ctx.base)
-		component_reg_phys = ctx.base;
-	else
-		component_reg_phys = CXL_RESOURCE_NONE;
-
+	component_reg_phys = ctx.base;
 	if (component_reg_phys != CXL_RESOURCE_NONE)
 		dev_dbg(match, "CHBCR found for UID %lld: %pa\n",
 			ctx.uid, &component_reg_phys);
