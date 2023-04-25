Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3B6EE8C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbjDYUGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjDYUGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:06:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101419A2;
        Tue, 25 Apr 2023 13:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIULEJG4q0g/HOIGObOj9wjJYoGb18EWM5eVBoDKQUnXwIRg7pPbZw1c8thvi9SetDq74JriEryh1rEL8HY15mPUXii4v/+vuLjuXbJ4r7Z+nEhj+95wySYt15MRQJem9uJ2eU4+vJdwyof2YvDiJ8qRMsids85kPSxjX0z6jeau7Y833f6+eOaCoFHrSjZi/BmLL8APyzd/ql9vq8phrlJ/dzf5HOr/CbQ+caXUVWMFnnB7D4FRBL3sMF7VfAjcQI6v5VDstKeN3UlTq9tNbdP3P6MZouhdc8xGnxixJxvfdiWofyMa2A18fcLbunL1X207+fqFI5LJcpqoHTQofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKv1aYo1TDnKjSOQOUMkd3D2kQ9kh1cE9EoXYpX2v5k=;
 b=JGCNzwLdnfk3+3k/4ho8U0CICibdfSPdTa/n1bFx8n9R1hfmpPEz0x6WSjgNaaUjEebMZZcQphxu/6yWnusKLP6UGeEZFtlNgKsQ+UxECUehyjvY9+UmvYuhzLkELxbg1KzHHRMHuc9z1OG1aKpfoozyLEN75D6jRs30XdjqpdrFGfhZcHefvT/eAEZyR6ds6dJsGW1fJo9efpHPeLF/au97pGm8Aa0RiJyzoQZsc6xgFBbSccNO+nh4yS25c+W3D5J3Fr4V0nciJ8MQL38kj32fRp1zc4Sk44dZ8JMEap+XtWyo+Izsitg3cBLPxzXG3wj49LTM+CsXbYDVBxYHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKv1aYo1TDnKjSOQOUMkd3D2kQ9kh1cE9EoXYpX2v5k=;
 b=I+6P58VmCHsl44uEgpn0VeQsz+BiEbfbI/sDft2LAduUI9Jt5iobOsprtWWmwVR2diH4i+xoZeqmfIVCCYfqSrXtDQ2jGazG7RtwF6ZmyOagWP1qivJm8/En/fvYYDSfVUv6sBziyFvUafJg0rKFjKy5Zhh3s5M2reyKyKU/u6M=
Received: from MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::32)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 20:06:08 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::c1) by MW4P220CA0027.outlook.office365.com
 (2603:10b6:303:115::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 20:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 20:06:08 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 25 Apr 2023 15:06:06 -0500
From:   Brad Larson <blarson@amd.com>
To:     <christophe.jaillet@wanadoo.fr>
CC:     <adrian.hunter@intel.com>, <blarson@amd.com>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-cadence: Fix an error handling path in sdhci_cdns_probe()
Date:   Tue, 25 Apr 2023 13:06:00 -0700
Message-ID: <20230425200600.54806-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <f61599a9ef23767c2d66e5af9c975f05ef1cec6b.1682430069.git.christophe.jaillet@wanadoo.fr>
References: <f61599a9ef23767c2d66e5af9c975f05ef1cec6b.1682430069.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|DM4PR12MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: dc03148f-30f8-4cd5-ddbe-08db45c88235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFQ11h5/ON4bsa7ugStYLOLDLvlH6/9UjOsflQ3PSMfjVLnf/qE0V+nUBjL9DwbObjGwnUCL3SuRHVaim6LCMhvbccZBTTS1YclZOLeWwfavcKS4vPpOWex0smS8UcODwgkq93aupX5QBO0F3xCUI4fkoso9ZMRAOex5jRA6Hhd44J0DC8z4iXHaZ6S+Jnu5xAjNb4+66TDX8QflUkt6pf5pvyVCRdd163yIMWkXoRTz6mXWYMM+CG5VQpI8R3EJg+EVPJ4xYl4oNF2pJOLzNB1HM/AVMQ8dfLX0d160PfaF5Mq+LseFPvjAcaFgHDznq/rhlrDjOd+ZMSeESYlSR5JfvikKlIGgza/TqT6A9ML9rf2fdA5c0BbCUQKI0JOD/K8jZqL6pwNLYoNfQfiORq4bHu1rPz2nEFR9+3auDjoUvgcBmWvuaDNJB9hNZ2f3ImM54nxhVqn/9189dgtsXe7g3gwlMUQmwJTUslTTHUZCAN0cVH1TyTCWVc3E7oYQfyDaxhdw/qF7Jnp1rTFGUHgd8JAvY+XT7RoodaKcX15EWvDfVEaK+qIB/QMLUeY8HqRbfToQ0rcrpZ1cGKD+HEAKNUqsAAFjiT9pOuIapXbm89CZZDNJNjh0E1/XC8+0QGo8J2gF0f55jSn/zalW6VP6KnpnixeYWm0VxdF5LFU5yJvXDIoLEJsY9c/HXHuTdTC38gsVY0gpVdBG68MrxsMv+AGdAgqWFU74RJhI55g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(336012)(356005)(426003)(53546011)(82740400003)(81166007)(1076003)(26005)(186003)(16526019)(2616005)(40480700001)(8936002)(83380400001)(47076005)(36860700001)(2906002)(8676002)(5660300002)(36756003)(40460700003)(316002)(6666004)(54906003)(478600001)(4326008)(6916009)(41300700001)(70586007)(70206006)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 20:06:08.1838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc03148f-30f8-4cd5-ddbe-08db45c88235
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/23 16:41, Christophe JAILLET wrote:
> If devm_reset_control_get_optional_exclusive() fails, some resources still
> need to be released. So branch to the error handling path instead of
> returning directly.
> 
> Fixes: aad53d4ee756 ("mmc: sdhci-cadence: Support mmc hardware reset")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Brad Larson <blarson@amd.com>

> ---
>  drivers/mmc/host/sdhci-cadence.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index b24aa27da50c..d2f625054689 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -540,9 +540,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  
>  	if (host->mmc->caps & MMC_CAP_HW_RESET) {
>  		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, NULL);
> -		if (IS_ERR(priv->rst_hw))
> -			return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
> -					     "reset controller error\n");
> +		if (IS_ERR(priv->rst_hw)) {
> +			ret = dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
> +					    "reset controller error\n");
> +			goto free;
> +		}
>  		if (priv->rst_hw)
>  			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
>  	}
