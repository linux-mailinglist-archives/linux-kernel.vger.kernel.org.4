Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145967273EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjFHBDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjFHBDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:03:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163522115;
        Wed,  7 Jun 2023 18:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686186226; x=1717722226;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e2ycazwbHUSIrP7K8NVHSNmlXspV0+nO+uH+SU6CZWo=;
  b=da0P1EW4GX8a6uEn8qLrE8V6cLgfS+vZMTCr/wFNr47v1DVSWrGRpX2X
   RVK1bFx7AiJXisuY8Fb21FMuoBeIiqSYzZlryW2p3erLeaMtIlsx5P7gq
   PNs7p87eyUMW79d+HZ0JDvSzckWK6x5CAXXJluj9j+5LybXaxwmIx8rRP
   rxPxGWzYFkte4NqAhHEBwk7y2/EIIYxh8cH+DDSWzXXv/0nm754SN9mj/
   Yns8EDkXak8UUk5Q6Zpex6KjyLjFcbxujfzBFxZXm03O0YjO0VSYh4W0e
   MIdLbMcyticWPMZPrSXio4ru7kfqAtHQTHrDbkFwK/epHMug89Ci0YNP0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="443523205"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="443523205"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 18:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="854126116"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="854126116"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2023 18:03:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 18:03:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 18:03:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 18:03:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwfaTu3XPMnWhX7p8QF2ecgLm7qIdqrFbeHJmsVUP/g07D8E52RkkLdNbMa6xNkY/75pcZ5fVUMH7jRPZ3BLaRL14k8ooWlOjsAfGdTRmLXNizFyIVLww3uuyRv9QQ+cyxNaCcBkxCYapLi6ZL9a42ID1w+AyTcEcARQ+WktIR6wG/7VhfIrmDagxU4+aLS0vXkZNEXsJwL3KRFOV81hqMd0O8n137emHgp/AsROlIH7i1ikj5DypYkLlqXzZUEzfP4wCAtCsK2w463bkoxXABDlnjC0GMM+gE7rs8+8j+r0k6qoOrOxuupGJPzWPjhumrgbXXIps+PqRgp77HiCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVXsth4yo+Wdg2JcPtsAhzbun2my7EV3sCcTYxq4CEI=;
 b=iw4xnhOG9JMXPQEkHHlddDvk8cQk5kbzdw5VsPMWQa3VQLaPY65nynvjnZ4AnTD7JiHTRUFgA/qFGiIctZFiwptaBTtvifUgSBwwAAsMA6XIViIO10eTYFdyl8VCS0pkdXIOpRwu9+QK9UcN1NUieHg5m5xmhevCoySdDALx621ervBSpF1Tw4ICWM/VUrTfsM2o4fXWVoXlTgO4B3Iq8/gHJUucEeRViANm5gsNtgbix2JN3Cd/m+Ujnz38tOWwiyQkZA38hx3IiQMKlqAG295M1ELNTtbZB0zIVhOUaFn7wrDsLA+r2xxuAUPblG4UAP6aRo2bBAjdUHP4pew/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 01:03:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 01:03:39 +0000
Date:   Wed, 7 Jun 2023 18:03:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 01/26] cxl/acpi: Probe RCRB later during RCH
 downstream port creation
Message-ID: <648128e846a9_142af82947c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-2-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-2-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: ead4d124-6b09-4844-4710-08db67bc31f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: balNv5QBEjDxTIK9kASBHapD7DIWst/3A5njBScmPzRVfO1nBnwGEfgUJc2n8+49Ip1JF72S7ymQK7P43JCbqd8G2DvDQp1A9o6oDGqZC3zV4az0h6YtX8XV9BPnNuhQR2ZZgk0kz/jqVnaOec7hnyImflkSzjtpxXGJGtNZtbeX3It9J8Fqb/5mJIM15wzkQ6U6ZIrwwbq4IdcTWzF71fgeryMZlKhrRidjStYuqdxrgSGoBkfilF4U/apKTCvZm60RSxztkfah7CABQ+xtSgWIS5+uSY4OtLYPndp9qLzV6Yue9Rff1b8JiBkRSGdoPGJdA9PXfgppd7PVA0X8eGX3WGO1VxY06NT9Ym4cFC/imChc9dOWS9PjtZJunytIlQUXiEnE5iwkzTp6rUArK0tP5pxre4lLN+jCicuzuCcZIFenZVc5BpTBX1Y9OhtkgKR25IQpXAA3E8bMdNia4TjC9U79WYn/s4LeZSGCEp+FHsjKz4MCWZl5K3Uwg4bStY9fqnm0q+E7cf7n5jZzpVxQHU41ovGILtGzlEZbs+CQpaYCO4MBa+SCMDcdU+bx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(478600001)(86362001)(5660300002)(83380400001)(8936002)(38100700002)(82960400001)(8676002)(26005)(316002)(186003)(66946007)(4326008)(66556008)(6512007)(6506007)(9686003)(6486002)(30864003)(6666004)(2906002)(66476007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kAs/ngUuiJsJrVRfFKrWc/O+6awd0SLelvPKt4MLnpe6PUM/+KQTnctYIDe+?=
 =?us-ascii?Q?T3ZNF1iIbKfhOSObLeTUatV7PPvDa3R5wxjQCNtVQ29qqZfpyOnGjaHFEMYX?=
 =?us-ascii?Q?q6d43JmzCn3P5u+ellg4BEPdi6ofLHKC2T7xgujRY4OrrNBQY9bJeDJ4U38I?=
 =?us-ascii?Q?mNLwtLpC9gNH236HuMlLD+rwah5h5Eg3ocNvr3q/Gfrhigp8ogvFhKcUNIac?=
 =?us-ascii?Q?Nm10KnX8a4DVNaCBImsGTPKLJ4u89g72S8jKjxqgR/Bna7/GT2pmnMEnFW+P?=
 =?us-ascii?Q?uWCRae/aQM8C4llBTdqwYsEED8j60dzzHaGdDZZGt10VlmFyPI95sKgWhaNT?=
 =?us-ascii?Q?VRR+y2g1y6Xrg11PBjYD571ePG95xXre+CUPhAS10Cxz4F7/lKe6dKdgi7Uf?=
 =?us-ascii?Q?J2mKDQXFrvja7XrvGpKQ9Z8DnYW9NlmxItkQ1CzaoNzxWJw+rdFtYcNeQJ9G?=
 =?us-ascii?Q?tHWbY910TQgpa1XfkKFh/LM2pStja0wINeKuw+IDJLoEKT3+Taa96u97Qd0M?=
 =?us-ascii?Q?T8nwOaauuCqZwa+zmrOLaoKCk6jZK6cAvWSQ7wkVIkgifk2KP0PLoMT9E0GH?=
 =?us-ascii?Q?8QWZlBUgFOBkDCbBkrX8YcURdGmx3tgURAZ2ZJ44bCQs4/+jEqNgxvkU8Yny?=
 =?us-ascii?Q?gp1jACuAV82Om7Z1oqVvt0JbBaXI0GA5Lf9AwWQRsJXrdUaZOTi/7hLUdgGf?=
 =?us-ascii?Q?Xlz+QEZbOwlECH3KjxE2Tpa7hLUKjm6VVHDKMlM6wyY5sYre346jc+JW/1bZ?=
 =?us-ascii?Q?JYj83RdujMRKPHwuxsz5mBvjk2iCemEU65G4nJsnXaY41b4a04uzU4F0fEYs?=
 =?us-ascii?Q?9cWJGlkWd/bzm1emUIEGUtKirjt4oNv6sPfL7o6Cl8LmgZrm/O/EIxVMplkS?=
 =?us-ascii?Q?lGy3L/lqQ9RJXZGFz27vREtdQnIYHe1oCPsuavJmleHYfHw2Wo/D8W5n3Dik?=
 =?us-ascii?Q?uJDu2VYloMZxCKfjxV7a9gmtr9g2Tv8RQ49iypconC+oAaV/CsW0BWmA0OPr?=
 =?us-ascii?Q?Uq1fMHLLw1q9cVmqyRjaaTypAtwZk8u+O4Q5qHo52Z665HmRvqgbm7s4zRrK?=
 =?us-ascii?Q?phMS1LIcxG8BApo3Afne07gEPd/1aZAjENxVhC/G4+iA4pb/i4dJ0cKwAii1?=
 =?us-ascii?Q?DAepeGsmHPtDzN5wnrp+uT6tAt7jJngTj7Pc6Eio8svpmXFgCJOxcbL7pBdn?=
 =?us-ascii?Q?wUSGOqmzOUlBng65xfxlNLS79jh2czrD+Cp9ptF5bCl9lRf7pvz8T8TUT3OK?=
 =?us-ascii?Q?3Ly6kc5BMqtFoO1UWUyp7GQxljMgVPfAV6IdbNKTlKyHONI8gQu4Nxg1bh4U?=
 =?us-ascii?Q?qztUAuErwC2azIJbjfk9OJxn+z1TQ0T7Vum80uPYpyyexklA/RU0b3NYubW0?=
 =?us-ascii?Q?YgZs6/VvuQQMaSrqv09qqlxH/WmLvfA4LNeAC45DhMIqQYnMEb0vhTXlajmR?=
 =?us-ascii?Q?WBFee9UZjGBWgMpDSxhhkkt/V2WL34P1LJomnk8I0gPEnuPB4UNBs1sr9qfE?=
 =?us-ascii?Q?VlJzILEGv/pveW7GfyXjwD0UWWgg7Mss6Da00mwpemKK3u2lAsV+LJQlcgoH?=
 =?us-ascii?Q?Aa27qF4joTrKcN9XxNNSRjm33pPG2E0cWGx6hjyUEsZBnwUReH8s6auG/19H?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ead4d124-6b09-4844-4710-08db67bc31f4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:03:39.6405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMwg/7RLEkDDqQceKy0Gqxk/3x7RJf1imjcPMcv+EUYTZ/Brb40YEE8XL7hgxluauER8pDigDUxaDTgbnxH+l9mt/O+yM9gWGpB4FfVxOfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
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
> From: Robert Richter <rrichter@amd.com>
> 
> The RCRB is extracted already during ACPI CEDT table parsing while the
> data of this is needed not earlier than dport creation. This
> implementation comes with drawbacks: During ACPI table scan there is
> already MMIO access including mapping and unmapping, but only ACPI
> data should be collected here. The collected data must be transferred
> through a couple of interfaces until it is finally consumed when
> creating the dport. This causes complex data structures and function
> interfaces. Additionally, RCRB parsing will be extended to also
> extract AER data, it would be much easier do this at a later point
> during port and dport creation when the data structures are available
> to hold that data.
> 
> To simplify all that, probe the RCRB at a later point during RCH
> downstream port creation. Change ACPI table parser to only extract the
> base address of either the component registers or the RCRB. Parse and
> extract the RCRB in devm_cxl_add_rch_dport().
> 
> This is in preparation to centralize all RCRB scanning.

I really like the approach of this patch, the cleanups just make sense,
the changelog is great...

...just the small matter of massive cxl_test breakages. Given that QEMU
only supports CXL VH topologies I would like to keep cxl_test emulation
of RCH topologies to regression test ongoing core reworks against the
RCH case.

The problem with cxl_test though is that due to how it uses linker
tricks (--wrap=) to inject mock topology data, it cannot support a
symbol that is exported by the core *and* consumed by the core. This
patch moved cxl_rcrb_to_component() from being called by cxl_acpi and
cxl_mem to being called internally by cxl_core and cxl_mem.

The fix path I chose is to add a new cxl_rcd_component_reg_phys() helper
for retrieving the upstream-port register block out of the RCRB, and add
a mock devm_cxl_add_rch_dport() that fakes the discovery of an RCH.

Below is the result for patch1. My plan is to go through the rest of the
series and ensure cxl_test keeps working. Perhaps you can fold in the
cxl_test fixups as I send them to be incorporated in your v6?

To be clear, I feel this is my maintenance burden to bear, I don't fault
you for not using cxl_test, but I am invested in keeping it operational.

-- >8 --
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 39227070da9b..1f4ae1b24cc1 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -372,7 +372,9 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	return 0;
 }
 
+ /* Note, @dev is used by mock_acpi_table_parse_cedt() */
 struct cxl_chbs_context {
+	struct device *dev;
 	unsigned long long uid;
 	resource_size_t base;
 	u32 cxl_version;
@@ -431,6 +433,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	dev_dbg(match, "UID found: %lld\n", uid);
 
 	ctx = (struct cxl_chbs_context) {
+		.dev = match,
 		.uid = uid,
 	};
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs, &ctx);
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 27f0968449de..bd0a5788c696 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -63,6 +63,14 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
+
+enum cxl_rcrb {
+	CXL_RCRB_DOWNSTREAM,
+	CXL_RCRB_UPSTREAM,
+};
+resource_size_t __rcrb_to_component(struct device *dev, resource_size_t rcrb,
+				    enum cxl_rcrb which);
+
 extern struct rw_semaphore cxl_dpa_rwsem;
 
 int cxl_memdev_init(void);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1a3f8729a616..45f5299af7a6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -939,8 +939,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		return ERR_PTR(-ENOMEM);
 
 	if (rcrb != CXL_RESOURCE_NONE) {
-		component_reg_phys = cxl_rcrb_to_component(dport_dev,
-						rcrb, CXL_RCRB_DOWNSTREAM);
+		component_reg_phys = __rcrb_to_component(dport_dev, rcrb,
+							 CXL_RCRB_DOWNSTREAM);
 		if (component_reg_phys == CXL_RESOURCE_NONE) {
 			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
 			return ERR_PTR(-ENXIO);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 1476a0299c9b..564dd430258a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -332,9 +332,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
 
-resource_size_t cxl_rcrb_to_component(struct device *dev,
-				      resource_size_t rcrb,
-				      enum cxl_rcrb which)
+resource_size_t __rcrb_to_component(struct device *dev, resource_size_t rcrb,
+				    enum cxl_rcrb which)
 {
 	resource_size_t component_reg_phys;
 	void __iomem *addr;
@@ -395,4 +394,12 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 
 	return component_reg_phys;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
+
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport)
+{
+	if (!dport->rch)
+		return CXL_RESOURCE_NONE;
+	return __rcrb_to_component(dev, dport->rcrb, CXL_RCRB_UPSTREAM);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a5cd661face2..28888bb0c088 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -262,14 +262,9 @@ int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
 enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
-
-enum cxl_rcrb {
-	CXL_RCRB_DOWNSTREAM,
-	CXL_RCRB_UPSTREAM,
-};
-resource_size_t cxl_rcrb_to_component(struct device *dev,
-				      resource_size_t rcrb,
-				      enum cxl_rcrb which);
+struct cxl_dport;
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 519edd0eb196..45d4c32d78b0 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -72,8 +72,8 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	 * typical register locator mechanism.
 	 */
 	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
-		component_reg_phys = cxl_rcrb_to_component(
-			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
+		component_reg_phys =
+			cxl_rcd_component_reg_phys(&cxlmd->dev, parent_dport);
 	else
 		component_reg_phys = cxlds->component_reg_phys;
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6f9347ade82c..8a87d7d5f7f8 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -12,7 +12,8 @@ ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
 ldflags-y += --wrap=cxl_dvsec_rr_decode
-ldflags-y += --wrap=cxl_rcrb_to_component
+ldflags-y += --wrap=devm_cxl_add_rch_dport
+ldflags-y += --wrap=cxl_rcd_component_reg_phys
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index bf00dc52fe96..f5c04787bcc8 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -971,15 +971,6 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 	return 0;
 }
 
-resource_size_t mock_cxl_rcrb_to_component(struct device *dev,
-					   resource_size_t rcrb,
-					   enum cxl_rcrb which)
-{
-	dev_dbg(dev, "rcrb: %pa which: %d\n", &rcrb, which);
-
-	return (resource_size_t) which + 1;
-}
-
 static struct cxl_mock_ops cxl_mock_ops = {
 	.is_mock_adev = is_mock_adev,
 	.is_mock_bridge = is_mock_bridge,
@@ -988,7 +979,6 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.is_mock_dev = is_mock_dev,
 	.acpi_table_parse_cedt = mock_acpi_table_parse_cedt,
 	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
-	.cxl_rcrb_to_component = mock_cxl_rcrb_to_component,
 	.acpi_pci_find_root = mock_acpi_pci_find_root,
 	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
 	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 284416527644..30119a16ae85 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -259,24 +259,44 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dvsec_rr_decode, CXL);
 
-resource_size_t __wrap_cxl_rcrb_to_component(struct device *dev,
-					     resource_size_t rcrb,
-					     enum cxl_rcrb which)
+struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
+						struct device *dport_dev,
+						int port_id,
+						resource_size_t rcrb)
+{
+	int index;
+	struct cxl_dport *dport;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_port(dport_dev)) {
+		dport = devm_cxl_add_dport(port, dport_dev, port_id,
+					   CXL_RESOURCE_NONE);
+		if (!IS_ERR(dport))
+			dport->rch = true;
+	} else
+		dport = devm_cxl_add_rch_dport(port, dport_dev, port_id, rcrb);
+	put_cxl_mock_ops(index);
+
+	return dport;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, CXL);
+
+resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
+						  struct cxl_dport *dport)
 {
 	int index;
 	resource_size_t component_reg_phys;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (ops && ops->is_mock_port(dev))
-		component_reg_phys =
-			ops->cxl_rcrb_to_component(dev, rcrb, which);
+		component_reg_phys = CXL_RESOURCE_NONE;
 	else
-		component_reg_phys = cxl_rcrb_to_component(dev, rcrb, which);
+		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
 	put_cxl_mock_ops(index);
 
 	return component_reg_phys;
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcrb_to_component, CXL);
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, CXL);
 
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index bef8817b01f2..a94223750346 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -15,9 +15,6 @@ struct cxl_mock_ops {
 					     acpi_string pathname,
 					     struct acpi_object_list *arguments,
 					     unsigned long long *data);
-	resource_size_t (*cxl_rcrb_to_component)(struct device *dev,
-						 resource_size_t rcrb,
-						 enum cxl_rcrb which);
 	struct acpi_pci_root *(*acpi_pci_find_root)(acpi_handle handle);
 	bool (*is_mock_bus)(struct pci_bus *bus);
 	bool (*is_mock_port)(struct device *dev);
