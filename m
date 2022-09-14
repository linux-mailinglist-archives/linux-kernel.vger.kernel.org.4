Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3BA5B80A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiINFQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiINFP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:15:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EC2696F1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qn5DW4mNVrtF8ZUaqETO+icHeTQtd6MJw4aqgCWcCI3dfFwUpfEJqvkTvTjGM9c5T19Sk825OjGQRAHdyA0VI1kFgoLr+XRKZEgjJnWOrdvDLl1ay/pD1fEMJmWs0hO4oGG2iO+81uFjpxN/moeBSgZkgrTeRvT2HcDnNeztmMctYBJkH7aH8DuKQOFIqDUmLm25z9NG0FM+tk87fxz2mhQh8Cy98nRAmETvzCkgpdftqCzJUct02T7+nuPuiqIPK09VXxpZ3RXC+oG+718qSuCGhgbcRbHtejwuq3dvJbbwbpNkFS3E3XYEr9V9zG8keRxCC4rX8824JUgbyU5rkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjouKLYNPQ/xh1mC8vGzWP0CSnQN76uJ0+N0Y9gnUhc=;
 b=YaU1/B7SJu9bccmHvHPH1wKZS0Kn/njQMwmoJshYsaWlp6loPN4OpOn46kS8OpZsZNtlbW0GJqx57y3uASA4OXgxWTSlShesUEGFOCLA2gAV57kYEPbfi1ENo5kb5ufcxPEHLEFHmo6Dcg6VWv8vhj4zOBEeYChOL7kOHUZ93uLUfqCLacdImkwARX5P2QwUx+RHH50W23m2I8RVZEjRrBzW2nD92wCiLW3rIyqUGwTZmK/+V1LnbP9Ou4NN3Gs5bC2Ygnze0V87csh02t2akGMXhXki+TsPFE6GCp71Q7jNhULssVbD2xhry/VnAd91WXXYIm3eISrwQzBtQmEWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjouKLYNPQ/xh1mC8vGzWP0CSnQN76uJ0+N0Y9gnUhc=;
 b=gggFvkgBAHWMnnyG8lMbWzmRAAhhXGeDA0BdXRoFR6jQn9D7EZom1rPCHPHXNky64CBOUY/a2DxsgmsLfEbHDIUBBUJ8VKiSYANLmxIxhGLcTJUehLesfPSqliGzc1xZbVbzW21uBL/W+2PK5Ckp4rwa1RLdw70Bb3kYHlN8wiGWgFIDOuHRAtU7VMHUXNHRepV74xtFPURoIuw3Qzqgk4K3lbjwv+WYEi+jm36DgERMeGCQJoX0DvZn4wLrexticheqHchD6Rafw3CzBxAIR5/P02GffKCcwCHD9UFXrirCqo1YeNCQJBnn9SHe4kpn3Nfqpl1GQLT1RJpCU5lVRg==
Received: from BN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:ee::18)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.23; Wed, 14 Sep
 2022 05:15:52 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::3d) by BN0PR04CA0013.outlook.office365.com
 (2603:10b6:408:ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 13 Sep
 2022 22:15:29 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 22:15:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 22:15:28 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jean-philippe@linaro.org>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <virtualization@lists.linux-foundation.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 13/13] iommu/virtio: Constrain return value of ->attach_dev()
Date:   Tue, 13 Sep 2022 22:15:28 -0700
Message-ID: <20220914051528.10601-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT035:EE_|DM6PR12MB4498:EE_
X-MS-Office365-Filtering-Correlation-Id: 090ca9b2-c0be-415b-1895-08da9610317b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G745FSWFik7Knewd/fflwba6B5Dz8swBVZKn1FVS5nZlJb7ZlMeuZ8kiQ222HVvtbvo6jvZuRf3AWX21HhDU1hPhsPTlO8JQ4d0P5oNNMm+XyWFJOman+KCRaZfv2HJSEAD/5Zh5pH8dzu6FNIx+nOiE9ZK49wtV9dONxIC5Auphz85CXgD1l1YQXIIX4XKGJBaD8cHsP8FC9fFYDTRjl5S+7S/JD3+7zgxPQeHmZwfjnZ6tW3UjAEcOikNUCaQu9xXqzgT08QBSzbAYH0Ca0VpqTFssY2z21ohHAU/KhyHY/nkZflZsGa9WgbXDfSo56jsGPBSMYEkjQp/5zXHHoyIRlR6mlLDk5b3QrFgOK/yltADi5Iy8sfcyKxEnHpF3GNBaezeiCDn5mOWt2Kqsh89Ng0AFS8FFpqhjAWbBXPdpMA3/6AMHZMuNwccWdT6HxbKQeqOp8XzthLYtdrVZlBYzFkuJ3YGH/vz9p8rFJojBgVCFzPkt+RR/2f6Ui4zv6XO4oyYV3+x2so9q2WRDjVmm53Mf2rdL7nk1McA351qAo+FnjKnp13ZHryu185wje93fCliQ/RjraoNKSsjzdszX9CkZvx8yp7N0d2TyCRbcd7Of2/nrAmfzKRCXCj7EOhR6h0t/IjZ3CFhZ5sMKbnfLDNSH59FvJoDy2atbUCwIPRbKG8Zm2e3LAJH0FBXRkKVIcabnJ4oCdtOpwxCtSO8xO2zlV/jhq1fGTOkr5Q6apMNWzrEoC459eJWfH+1zkpi6+OhwSXtYLZWns2FQNINkRRzeI0V9vDZdtkS3VQY=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(7636003)(5660300002)(8936002)(70586007)(86362001)(41300700001)(40480700001)(70206006)(7696005)(8676002)(4326008)(336012)(1076003)(36756003)(186003)(2616005)(83380400001)(47076005)(426003)(40460700003)(36860700001)(26005)(356005)(2906002)(82310400005)(478600001)(82740400003)(316002)(54906003)(110136005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:51.7953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090ca9b2-c0be-415b-1895-08da9610317b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Ensure attach_dev() callback functions only return errno values expected
from the attach_dev() op. In particular, only return -EINVAL when we are
sure that the device is incompatible with the domain.

Also drop any dev_err next to -EINVAL, following the attach_dev op kdocs.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/virtio-iommu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 80151176ba12..168cd9c1f7e1 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -669,13 +669,13 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 		dev_err(vdev->dev,
 			"granule 0x%lx larger than system page size 0x%lx\n",
 			viommu_page_size, PAGE_SIZE);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
 			      viommu->last_domain, GFP_KERNEL);
 	if (ret < 0)
-		return ret;
+		return -ENOMEM;
 
 	vdomain->id		= (unsigned int)ret;
 
@@ -696,7 +696,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 		if (ret) {
 			ida_free(&viommu->domain_ids, vdomain->id);
 			vdomain->viommu = NULL;
-			return -EOPNOTSUPP;
+			return -ENODEV;
 		}
 	}
 
@@ -733,8 +733,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 */
 		ret = viommu_domain_finalise(vdev, domain);
 	} else if (vdomain->viommu != vdev->viommu) {
-		dev_err(dev, "cannot attach to foreign vIOMMU\n");
-		ret = -EXDEV;
+		ret = -EINVAL;
 	}
 	mutex_unlock(&vdomain->mutex);
 
@@ -769,7 +768,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 		ret = viommu_send_req_sync(vdomain->viommu, &req, sizeof(req));
 		if (ret)
-			return ret;
+			return -ENODEV;
 	}
 
 	if (!vdomain->nr_endpoints) {
@@ -779,7 +778,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 */
 		ret = viommu_replay_mappings(vdomain);
 		if (ret)
-			return ret;
+			return -ENODEV;
 	}
 
 	vdomain->nr_endpoints++;
-- 
2.17.1

