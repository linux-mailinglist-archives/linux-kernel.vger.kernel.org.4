Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472DD5B53BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiILGAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiILGAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:00:02 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20714192B1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFkPXkOgUS2q3YYCHih3C3Wh647OUYE3hZfTBheEoieZq/XiSTtEdQ3GYmIXgj4bIdYbkMVtHWVWRM4Fj2XAGGo09VmHxcmOqvKiOw5EmnNWcvmBT/9VPDEJJjeAI4PEwF4mY727OhwBctjEtdOb2QL5QP8pEvPAs3MeoN5xUyDUewwzjjMfzXyXJLaMK2kn/7aMon0+3gTQu4xlMGaEHoA7If49x3c/4BEb2zCif7Be7VoJId6OL7u0F67DdyDEbwdf+zVTPeYcSnQ0ZMDr7kakRldT15TqZr1az7XOXdsDlx2cJmaF38Sy7/sLrEHPFf9PnzPweMLqNYiLX4PgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38C6VNxkTTGSmoe0636bMwuu66T54BWVtG1IYTzLXVQ=;
 b=XAneYUKy/nxpq6fDJKkoEe5aJxJh+pDZpxffGGlxpSTmVsOn+QStvOqIXqx9CPv+fSiHrTQISsF0yPAfJC2wLb+MRiaFOhsX5fz/Tog8/rm/OTwqEntZX9fVGFH5mLO9cjoPJ1PiD+PfYSHpAmtZ4bf4u1hFPm3ClDnjrabmkThkeLYavsUhT/FAD2JclGkIiGvwn+lpm1Phersg/OP8Cmn5b3xkgmt8cttwFJam24oI9hG8IWIv5J/NZnR26XfPUu6WS2r22JgGl1UQXQmayw5Jiqcakxm9O/uW36LoXpYNYKtYRtDWIr1GODAM5exvbVGZ4Hu3tPxJheTxW8dvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38C6VNxkTTGSmoe0636bMwuu66T54BWVtG1IYTzLXVQ=;
 b=dVigGV4jCZVY2lGL9ItS/39MlYmxjv//qbmcLx1/JHQxk6MIqd8LpSj8vZy5/S1peya6/ESazZ6Vq9s31E0oMaL1vAxo6A5sJhDF8koxqLxSJ/sC9j7OjPKB4XJIVfjnYqOhEhTiWA78ADAXL6eQYtLJKP/4cS17LNiG7mLhAh0=
Received: from BN0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:e8::35)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 05:59:55 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::13) by BN0PR04CA0060.outlook.office365.com
 (2603:10b6:408:e8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Mon, 12 Sep 2022 05:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 05:59:54 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 00:59:47 -0500
Message-ID: <866fa1ad-b570-ff1a-3c65-4bcc28b147a8@amd.com>
Date:   Mon, 12 Sep 2022 07:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] phy: xilinx: phy-zynqmp: dynamic clock support for
 power-save
Content-Language: en-US
To:     Piyush Mehta <piyush.mehta@amd.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <vkoul@kernel.org>, <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>
References: <20220909130442.1337970-1-piyush.mehta@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220909130442.1337970-1-piyush.mehta@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd4ce5b-5452-45df-f2f1-08da94840385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: La3p+4JDrlJS6iU80BYtdnO0c+INUhSnamGaTY6WcqdO2S/C6gRwxKYQUvxu/jxv3b/SmLVOqpfQqI7lamzOH5ofR3S5EFrweiP3tIliiktagb9llYEByHzrIAkKkcqlIGovLjSMqAWeKtV2Se+BtG5DK5KZ/er4bllyHuZ6JNCB6unKR+lUnkDFtyYHKdp9rn0AwPp26ItWYL79snY0pzxPNoVNbOJB3JAO6m21pi4zVW0xd78geKHVjDAytK7kaIHnamAOO4z7JFRAXonMw96LHyrQgAKXe70m2J0v005ec3t9tzptNS8da0c9PFyg+wrcU1dc/CjV24oFBPEYQ0MNeHHixMSZHdS0gOqY7XoT9F/XV81Xfp2F1Tw0XICC/xXIuc1WBqNsYnkZL3thXLbfAZjeZK5xr5xQRzHg4Wp8GMkC18fHoDqAwTg8nkEGcTQaiDp/ux4QVgR4BTPyQoFb6bNCNJrer4cyMa6lBXpEUUBWc0V2i8WrZDAdtAobCjOkgCEC2nNl4aoGuL7lDiIogHWpyJxXbmMgVMisgzOLOAu1xeF1H2xD8dkst/emDDp3EspdOd2+dEVDuILVGJl1NFhLJSKM//U/JT7Aso0sNlCSJtnDsC27+ibOJMxc7uaCp94elP/k/qRaDvd+u0GQrx5LldNEmvrm1H3BlX03FB7EKucsC8oQE+SJVBLPzhr7AEoi/HoyA5jNNl6PAFxw9OmolbLZUjpjTMNwOh9qdukDJkQ/U+oJauZ4CDxh0f4dc2Vor7g3kX+rWTWPQ3HkwEbxJMEE9Qv6+mRUP+ARRyfRC1sZN9DV2O9cLiZV1DisH57TX/XUOq1UOubdRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(40470700004)(36840700001)(46966006)(26005)(82740400003)(40460700003)(16526019)(336012)(5660300002)(31696002)(82310400005)(70586007)(70206006)(8676002)(4326008)(86362001)(426003)(16576012)(47076005)(44832011)(110136005)(8936002)(83380400001)(316002)(53546011)(2616005)(40480700001)(36756003)(36860700001)(54906003)(2906002)(31686004)(186003)(356005)(478600001)(6666004)(81166007)(41300700001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 05:59:54.1425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd4ce5b-5452-45df-f2f1-08da94840385
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/22 15:04, Piyush Mehta wrote:
> Enabling clock for all the lanes, consuming power even PHY is active or
> not.
> 
> To resolve the above issue and power saving,made clock enabled/disabled
> based on active PHYs on call of phy_init/phy_exit.
> 
> By default clock is disabled for all the lanes. Whenever phy_init called
> from USB, SATA, SGMII, or display driver, it enabled the required clock
> for requested lane. On phy_exit cycle, it disabled clock for the active
> PHYs.
> 
> During the suspend/resume cycle, each USB/ SATA/ SGMII/ display driver
> called phy_exit/phy_init individually. it disabled clock on exit, and
> enabled on initialization for the active PHYs.
> 
> Active PHY configuration depends on the peripheral DT node status,
> like USB DT node status 'okay' then driver enabled clock for the USB
> configured lane.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
>   drivers/phy/xilinx/phy-zynqmp.c | 59 ++++++++-------------------------
>   1 file changed, 14 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> index 9be9535ad7ab..912c4defdf8d 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -572,6 +572,10 @@ static int xpsgtr_phy_init(struct phy *phy)
>   
>   	mutex_lock(&gtr_dev->gtr_mutex);
>   
> +	/* Configure and enable the clock when peripheral phy_init call */
> +	if (clk_prepare_enable(gtr_dev->clk[gtr_phy->lane]))
> +		goto out;
> +
>   	/* Skip initialization if not required. */
>   	if (!xpsgtr_phy_init_required(gtr_phy))
>   		goto out;
> @@ -616,9 +620,13 @@ static int xpsgtr_phy_init(struct phy *phy)
>   static int xpsgtr_phy_exit(struct phy *phy)
>   {
>   	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
> +	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
>   
>   	gtr_phy->skip_phy_init = false;
>   
> +	/* Ensure that disable clock only, which configure for lane */
> +	clk_disable_unprepare(gtr_dev->clk[gtr_phy->lane]);
> +
>   	return 0;
>   }
>   
> @@ -824,15 +832,11 @@ static struct phy *xpsgtr_xlate(struct device *dev,
>   static int __maybe_unused xpsgtr_suspend(struct device *dev)
>   {
>   	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
> -	unsigned int i;
>   
>   	/* Save the snapshot ICM_CFG registers. */
>   	gtr_dev->saved_icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
>   	gtr_dev->saved_icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
>   
> -	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> -		clk_disable_unprepare(gtr_dev->clk[i]);
> -
>   	return 0;
>   }
>   
> @@ -842,13 +846,6 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
>   	unsigned int icm_cfg0, icm_cfg1;
>   	unsigned int i;
>   	bool skip_phy_init;
> -	int err;
> -
> -	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++) {
> -		err = clk_prepare_enable(gtr_dev->clk[i]);
> -		if (err)
> -			goto err_clk_put;
> -	}
>   
>   	icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
>   	icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
> @@ -869,12 +866,6 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
>   		gtr_dev->phys[i].skip_phy_init = skip_phy_init;
>   
>   	return 0;
> -
> -err_clk_put:
> -	while (i--)
> -		clk_disable_unprepare(gtr_dev->clk[i]);
> -
> -	return err;
>   }
>   
>   static const struct dev_pm_ops xpsgtr_pm_ops = {
> @@ -888,7 +879,6 @@ static const struct dev_pm_ops xpsgtr_pm_ops = {
>   static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>   {
>   	unsigned int refclk;
> -	int ret;
>   
>   	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++refclk) {
>   		unsigned long rate;
> @@ -899,19 +889,14 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>   		snprintf(name, sizeof(name), "ref%u", refclk);
>   		clk = devm_clk_get_optional(gtr_dev->dev, name);
>   		if (IS_ERR(clk)) {
> -			ret = dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
> -					    "Failed to get reference clock %u\n",
> -					    refclk);
> -			goto err_clk_put;
> +			return dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
> +					     "Failed to get ref clock %u\n",
> +					     refclk);
>   		}
>   
>   		if (!clk)
>   			continue;
>   
> -		ret = clk_prepare_enable(clk);
> -		if (ret)
> -			goto err_clk_put;
> -
>   		gtr_dev->clk[refclk] = clk;
>   
>   		/*
> @@ -931,18 +916,11 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
>   			dev_err(gtr_dev->dev,
>   				"Invalid rate %lu for reference clock %u\n",
>   				rate, refclk);
> -			ret = -EINVAL;
> -			goto err_clk_put;
> +			return -EINVAL;
>   		}
>   	}
>   
>   	return 0;
> -
> -err_clk_put:
> -	while (refclk--)
> -		clk_disable_unprepare(gtr_dev->clk[refclk]);
> -
> -	return ret;
>   }
>   
>   static int xpsgtr_probe(struct platform_device *pdev)
> @@ -951,7 +929,6 @@ static int xpsgtr_probe(struct platform_device *pdev)
>   	struct xpsgtr_dev *gtr_dev;
>   	struct phy_provider *provider;
>   	unsigned int port;
> -	unsigned int i;
>   	int ret;
>   
>   	gtr_dev = devm_kzalloc(&pdev->dev, sizeof(*gtr_dev), GFP_KERNEL);
> @@ -991,8 +968,7 @@ static int xpsgtr_probe(struct platform_device *pdev)
>   		phy = devm_phy_create(&pdev->dev, np, &xpsgtr_phyops);
>   		if (IS_ERR(phy)) {
>   			dev_err(&pdev->dev, "failed to create PHY\n");
> -			ret = PTR_ERR(phy);
> -			goto err_clk_put;
> +			return PTR_ERR(phy);
>   		}
>   
>   		gtr_phy->phy = phy;
> @@ -1003,16 +979,9 @@ static int xpsgtr_probe(struct platform_device *pdev)
>   	provider = devm_of_phy_provider_register(&pdev->dev, xpsgtr_xlate);
>   	if (IS_ERR(provider)) {
>   		dev_err(&pdev->dev, "registering provider failed\n");
> -		ret = PTR_ERR(provider);
> -		goto err_clk_put;
> +		return PTR_ERR(provider);
>   	}
>   	return 0;
> -
> -err_clk_put:
> -	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
> -		clk_disable_unprepare(gtr_dev->clk[i]);
> -
> -	return ret;
>   }
>   
>   static const struct of_device_id xpsgtr_of_match[] = {

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
