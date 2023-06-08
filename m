Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB8672765F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjFHEyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjFHEyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:54:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8710426AC;
        Wed,  7 Jun 2023 21:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686200050; x=1717736050;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WflmALtv+lNLcs937KmKrIBUYbItZinmxMAlFRA+jw4=;
  b=PD0brj4iZdz0L8I8laKjU03BN5fKDfJ8AXMF2DenYDAq6CZD8fkRhcfX
   uyPdDovSR0pP3JX/13NfHS6/GGbmny6bA8VehoOIHiSpJPYTPqRcnUoUR
   srqQZaHNOfGlRfowUeRPCqBT2u+Jq3oBqY7j8ySp8oZqOIzWb0gR08X01
   vowbiRNIYa+ybSgGi4RrM8CWNpCMa1e2AVqVWwGWa7FkqSngYrE17O3Wz
   1q7r9D9AXGu70R8L6PIkgUAEOMHDheTuMy7toLgEE7KRBXxMLPpqJvq8/
   IRtDMi89D8Cc57cRil9pxSlqUOV+qvXvd6xwyefb1Av1zMJycfqnZrDWN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="360536094"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="360536094"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 21:54:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="834017632"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="834017632"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2023 21:54:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 21:54:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 21:54:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 21:54:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW9IHOvzh4Zr8rLBOcT6UdhQ5os+n81c5gwVfp2YEusA/hGWeDEt2Lx3/GPI+LhtWuJmXKGKZYgtk1aSRAH8zVIarCQQlU970H4EtOB8n/6LubGLlsTzC9A46MatRXUPJ1iYW0t+xCUOiSzaEgfZcJWWs+YbJSbr4DrmrTO7D8CHE/uwwEpAgJ13N8jlI+WCMEaKuTFOhdOtGobGLTzpaVGn8zvOYL89vBYSn7nofeOYFwtBSy2AQM4tPE4sLEAH+U+NH2lX2oQXkRRLs6SHeTK4kcToqNkwS2IeyncuSoZY1orPiIZpKK1C4zAPgEMHXsI//eZXdQJto9PmVBNkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fRKpH1EvZWLqMn/08CMFsODPjh85Nm/B00L4ujKqwc=;
 b=NJj8wvmJi5DL626KkAxGfz3nZUjPM55JKkmvC1XqXWw2DT7ABcMVGYCAqCQ1PCflRu0S9UlHByqVKzp4dd5CuSh6DY4SvFqEDymgn+txbjYJteh5AkNxk4rhyfr7ZZACz7374Rh0lrl2hdYzrdBjpmiXa/2DLEB9+5ehiawBI1xj1kJv8mxnWdTjBiD8cCRVu2DvumJCXJ8bJ4qZD+XljZa9KmYfT4SGF/l8i/lWto0obW34orgsDSxhWn20z7eXPxwpHzx5yRlmOR5Y9Y6GZSPUQfrU2oTniT2s6sOIO+HsoK4GZe1e5W+PCenXv42z2UqrYtX8yLCXj+gWSzH0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7052.namprd11.prod.outlook.com (2603:10b6:510:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 04:54:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 04:54:01 +0000
Date:   Wed, 7 Jun 2023 21:53:58 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 02/26] cxl/rch: Prepare for caching the MMIO mapped
 PCIe AER capability
Message-ID: <64815ee6568a_e067a29458@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-3-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:332::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 0877dc3d-6572-4ce4-4846-08db67dc607a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KcFCz26ZtwFBK9UCoAWHFZL3h0QBzc+I2bsXOP210Ai3gWTB983IDJ4xqOZRM5JzSM91vqqsxr9V2bzSSYrNADzLpjCMiN9GZ+6YxvWH0DW7ad+ZAPdSo0u8ghb/dx3bjUgZkyVfwAXkQts1P4lzw0qajT6xUeZCK55pmYBL138kKn2nMpW3Zp2FwDNC/S4vsyIsOy41+A0jvXFjM6V7We7AidrpSGoykSJZuuTMLdJuscnwjeWSBZ3oc8Iy6wK7wWqOwa/DMjUNT0yiUTjz91dyFrDGcIQljsXQ2PJpsF+/2dAiXuWiEGhvK3J51tRTSQ/M25NB92o2Na44ZgWx2caXzFAG9Ohxvz/GRY9sn459LPfjmuMUiDMYoO65yFTOJHrsbi4rMkEIfttkncd9NwnRiannzPexmPBtdzS4HNhF+6Ba7aHdyvcCGmf+PQZSrfP0kpw4eX0VYmiCVeDHYAI9LzwDcx1dfhI+U0r9YLx2ywO7zulM+BTRmUfO87g0X4viN+sEauyMuQvRvxVCYrOZZfG+KwQkRhjdLMu91BTCKCf9N6hxDYZPWtCSbhb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(66946007)(4326008)(66556008)(66476007)(38100700002)(2906002)(41300700001)(82960400001)(86362001)(5660300002)(316002)(8676002)(8936002)(6486002)(6666004)(478600001)(9686003)(6512007)(26005)(6506007)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8/n6kDTf7cHJKyz/nQMXr6+lHEQ+o/S8RY5wc9xpqyi/Vl02XQ77N/GsjkDq?=
 =?us-ascii?Q?0O+bY7ds2FUi//tekX5CucJ56J+pTPIu8g5XbYXx4sNlYwE0vEKQQlnygHE3?=
 =?us-ascii?Q?/w21XZz5NuZOp/m+I58cdFV69FcXc0izG3GV2ByFpv6Rsh+Nt1fJdlY5vDMe?=
 =?us-ascii?Q?PIwBemQv1WpDNhCbnty3fUxn6UtWxRhEkbp1vC8SIhM0Dkr1DH0RH5vgZLVP?=
 =?us-ascii?Q?2eRqc5I6bOmj1DdhO7SE3HJgwYf4qmCD+AzTq58NwavdT0097sBpQ/6C0djY?=
 =?us-ascii?Q?ISFptvmK2Pzdae8Turt461wuizP9ny2h2b9BzM4h5aOpy7sF3DQRQn2xJMB2?=
 =?us-ascii?Q?wWBmpV6LJBDzd6Xkv33E9p+CxIPuh7rVikKLZvAeZO0LD1L5uO0VJiCnq89N?=
 =?us-ascii?Q?R+GgxIs7SF6sHd9Duqe0a3WR/hvVoq8QBBxV4uBTM04UE9ggzuD+qWlhu82b?=
 =?us-ascii?Q?ENLAiD03TlZ2Jbk+CX4/v0q35jfOqHTxOamWDkoxoH/4NB5FKnwncDWRfUCR?=
 =?us-ascii?Q?6AgbuR2RkSxZ0FJomVPu5mHpD6iVa0PQ6PQgrxmmJikGb+d2VOawNqZmqd+N?=
 =?us-ascii?Q?zxETb8MYjVw8xpYKF1iNve6rZlWLwM3BDnogbJld/uTzgIHhFdZABpUx480m?=
 =?us-ascii?Q?5T626fTBbWsaYk4wrx2jsTqR48e5o59WO+K6Ngod8CEquWSI934Rc0bT9MbV?=
 =?us-ascii?Q?le5CdxISH2N0FIys2sEnbEmIaVnmJh53zNT8+8Sf/ziS/uIEi2GI1gSshGwz?=
 =?us-ascii?Q?bT6SEm36awueHP2UNGXd1JY2wcEBFgBoV39EVwrNROWZnKhcMohVUczjI5o+?=
 =?us-ascii?Q?6M+NDh7Qn2lfcizB/S4BxRHynMJiDmSQ1HVXYiVAtVo0JxN2I1Fxq0FJaHG6?=
 =?us-ascii?Q?D16ouRbD/xk/Lo0ImtbAJ5Dz6YuIKc+nz4UvTCSh+TNZsz2toPCvGQ2FPiov?=
 =?us-ascii?Q?xxy391qphCYISEELLavqFG6g1mcbu4HFbptBp2X34ndhbdVNbPJZDHU0pzYA?=
 =?us-ascii?Q?uNTfxn3dMBLmLycXr57OOOa9+E4DkLYJy/uY4o00VXFmU9/XnAqs82qOqux7?=
 =?us-ascii?Q?qiJKZYyxTE4sLKh0MgtEsvwd9zlDJd64ejah33ON+pRDc9HmZyoI58gEj0/B?=
 =?us-ascii?Q?VL29N84joIMW7HXUucCZ2pa5R1fxYk3F/N2Oo7Dboey9xrN03rHWsx9UsOUJ?=
 =?us-ascii?Q?o1jBFQn2DE+4UkLrbkPbZC2yKUuF6tlXuagCV18q7uTZvNZZYlETQowbfQeB?=
 =?us-ascii?Q?iRhzUdZf5y7PZelKAv1SQEx8IH5m9TeVuXWsXAnitI2OJT7iUmAlrNnQ+Hrf?=
 =?us-ascii?Q?T6iBro1IDTX4fG5zY1SaILph4NlJSAaZ+mj7O+TotHPFwSfo+GDhiGB1fmuU?=
 =?us-ascii?Q?+aieFr2x8+AxtNk0cPvA6IhkUH4ZyvUz7U/uAjcEwpAUnx4PY8+npmnifqQr?=
 =?us-ascii?Q?JWEAYw9PGy3PyS1oj5iqOT5vUULCezypPYmOu8FVwRg4TZNvmZjbbcMCO8zR?=
 =?us-ascii?Q?i2duXsbr9pW2WhSovExebUNpFhIJMtdBSdq6n3mgzENdkd3g6UeBOsQCfnlp?=
 =?us-ascii?Q?ps4gROv60jbpaqu7qzO84siR1p6C0ZdeSEnjrc2V/qzSffA+D0Aka6+gPakm?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0877dc3d-6572-4ce4-4846-08db67dc607a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 04:54:01.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTPyiixJo4f/axJ5GruZkHeSLopcNeQgjL98fR6UT2yC8m9TkwIKC/bzXIzKx8zPCqne2KfNBMQ06HiDAUGQcfqooGDcPV2TZIGUrA+pS08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7052
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Prepare cxl_probe_rcrb() for retrieving more than just the component
> register block. The RCH AER handling code wants to get back to the AER
> capability that happens to be MMIO mapped rather then configuration
> cycles.
> 
> Move RCRB specific downstream port data, like the RCRB base and the
> AER capability offset, into its own data structure ('struct
> cxl_rcrb_info') for cxl_probe_rcrb() to fill. Extend 'struct
> cxl_dport' to include a 'struct cxl_rcrb_info' attribute.
> 
> This centralizes all RCRB scanning in one routine.

With the addition of cxl_rcd_component_reg_phys() and
__rcrb_to_component() in the previous patch, this one becomes cleaner to
implement. Given the collisions it needed to be re-written. The
following is passing cxl_test:

-- >8 --
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bd0a5788c696..b001669a5133 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -68,7 +68,9 @@ enum cxl_rcrb {
 	CXL_RCRB_DOWNSTREAM,
 	CXL_RCRB_UPSTREAM,
 };
-resource_size_t __rcrb_to_component(struct device *dev, resource_size_t rcrb,
+struct cxl_rcrb_info;
+resource_size_t __rcrb_to_component(struct device *dev,
+				    struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which);
 
 extern struct rw_semaphore cxl_dpa_rwsem;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 45f5299af7a6..76888c75dae4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -939,7 +939,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		return ERR_PTR(-ENOMEM);
 
 	if (rcrb != CXL_RESOURCE_NONE) {
-		component_reg_phys = __rcrb_to_component(dport_dev, rcrb,
+		dport->rcrb.base = rcrb;
+		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
 							 CXL_RCRB_DOWNSTREAM);
 		if (component_reg_phys == CXL_RESOURCE_NONE) {
 			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
@@ -957,7 +958,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	dport->port_id = port_id;
 	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
-	dport->rcrb = rcrb;
 
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 564dd430258a..6c4b33133918 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -332,10 +332,11 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
 
-resource_size_t __rcrb_to_component(struct device *dev, resource_size_t rcrb,
+resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which)
 {
 	resource_size_t component_reg_phys;
+	resource_size_t rcrb = ri->base;
 	void __iomem *addr;
 	u32 bar0, bar1;
 	u16 cmd;
@@ -400,6 +401,6 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 {
 	if (!dport->rch)
 		return CXL_RESOURCE_NONE;
-	return __rcrb_to_component(dev, dport->rcrb, CXL_RCRB_UPSTREAM);
+	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 28888bb0c088..7c8674079f1a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -582,12 +582,17 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 	return xa_load(&port->dports, (unsigned long)dport_dev);
 }
 
+struct cxl_rcrb_info {
+	resource_size_t base;
+	u16 aer_cap;
+};
+
 /**
  * struct cxl_dport - CXL downstream port
  * @dport: PCI bridge or firmware device representing the downstream link
  * @port_id: unique hardware identifier for dport in decoder target list
  * @component_reg_phys: downstream port component registers
- * @rcrb: base address for the Root Complex Register Block
+ * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
  */
@@ -595,7 +600,7 @@ struct cxl_dport {
 	struct device *dport;
 	int port_id;
 	resource_size_t component_reg_phys;
-	resource_size_t rcrb;
+	struct cxl_rcrb_info rcrb;
 	bool rch;
 	struct cxl_port *port;
 };
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 30119a16ae85..dbeef5c6f606 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -271,8 +271,10 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 	if (ops && ops->is_mock_port(dport_dev)) {
 		dport = devm_cxl_add_dport(port, dport_dev, port_id,
 					   CXL_RESOURCE_NONE);
-		if (!IS_ERR(dport))
+		if (!IS_ERR(dport)) {
+			dport->rcrb.base = rcrb;
 			dport->rch = true;
+		}
 	} else
 		dport = devm_cxl_add_rch_dport(port, dport_dev, port_id, rcrb);
 	put_cxl_mock_ops(index);
