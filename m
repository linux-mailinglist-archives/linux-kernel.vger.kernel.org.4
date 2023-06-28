Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9157415D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjF1Pzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjF1Pza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:55:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF0F1FE3;
        Wed, 28 Jun 2023 08:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 218E961380;
        Wed, 28 Jun 2023 15:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590C4C433C8;
        Wed, 28 Jun 2023 15:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687967728;
        bh=na4WB6PAYoPkjYRyV1r+mFtS01CjBzTxyWGexdqB4Ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8F6fRA0S4LmOaa9chBbBD4GaCNERxOQv8FFFEMW7p8+QVL+rjLcqXMkSLemCac3o
         ebs8P6kIH3LEr9DmXT3DWxg+iNHJqJb2cnQNBkotQqsQYxC34sycakwcbIYPPONaYt
         CzK0s9saHd3kSsDMo0TEwrag651JNV/GTDxAD1y6+EtB/e6Gp0zAsk4OqSYPCLr1Ka
         ckponENnhLU/ZjRxor5+H8rLLWN9du4ZE6LkApIv+iE9p7t0jvk7l1b2KzlSErDeLC
         5eQGqgZ/9WImMqSVsjgwCg8j2cyoGHoO0POXRfoEyAmfP3Y85Uk5XTJm05a+z5Mvs0
         XHJn3z7d4sBSQ==
Date:   Wed, 28 Jun 2023 21:25:12 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Message-ID: <20230628155512.GD20477@thinkpad>
References: <1687918770-28416-1-git-send-email-quic_krichai@quicinc.com>
 <1687918770-28416-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1687918770-28416-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 07:49:30AM +0530, Krishna chaitanya chundru wrote:
> Add support to vote for ICC bandwidth based on the link
> speed and width.
> 
> This patch is inspired from pcie-qcom driver to add basic
> interconnect support.
> 
> Reference: commit c4860af88d0c ("PCI: qcom: Add basic interconnect
> support").

I don't think there is any "Reference" tag exist for commit messages. You can
simply mention it as below:

"Add support for voting interconnect (ICC) bandwidth based on the link speed
and width. This commit is inspired from the basic interconnect support added
to pcie-qcom driver in commit c4860af88d0c ("PCI: qcom: Add basic interconnect
support").

The interconnect support is kept optional to be backward compatible with legacy
devicetrees."

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 72 ++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 1435f51..b7d7038 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -13,6 +13,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/interconnect.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/phy/pcie.h>
>  #include <linux/phy/phy.h>
> @@ -28,6 +29,7 @@
>  #define PARF_SYS_CTRL				0x00
>  #define PARF_DB_CTRL				0x10
>  #define PARF_PM_CTRL				0x20
> +#define PARF_PM_STTS				0x24
>  #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>  #define PARF_MHI_BASE_ADDR_LOWER		0x178
>  #define PARF_MHI_BASE_ADDR_UPPER		0x17c
> @@ -133,6 +135,11 @@
>  #define CORE_RESET_TIME_US_MAX			1005
>  #define WAKE_DELAY_US				2000 /* 2 ms */
>  
> +#define PCIE_GEN1_BW_MBPS			250
> +#define PCIE_GEN2_BW_MBPS			500
> +#define PCIE_GEN3_BW_MBPS			985
> +#define PCIE_GEN4_BW_MBPS			1969
> +
>  #define to_pcie_ep(x)				dev_get_drvdata((x)->dev)
>  
>  enum qcom_pcie_ep_link_status {
> @@ -178,6 +185,8 @@ struct qcom_pcie_ep {
>  	struct phy *phy;
>  	struct dentry *debugfs;
>  
> +	struct icc_path *icc_mem;
> +
>  	struct clk_bulk_data *clks;
>  	int num_clks;
>  
> @@ -253,9 +262,50 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
>  	disable_irq(pcie_ep->perst_irq);
>  }
>  
> +static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
> +{
> +	struct dw_pcie *pci = &pcie_ep->pci;
> +	u32 offset, status, bw;
> +	int speed, width;
> +	int ret;
> +
> +	if (!pcie_ep->icc_mem)
> +		return;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> +
> +	switch (speed) {
> +	case 1:
> +		bw = MBps_to_icc(PCIE_GEN1_BW_MBPS);
> +		break;
> +	case 2:
> +		bw = MBps_to_icc(PCIE_GEN2_BW_MBPS);
> +		break;
> +	case 3:
> +		bw = MBps_to_icc(PCIE_GEN3_BW_MBPS);
> +		break;
> +	default:
> +		dev_warn(pci->dev, "using default GEN4 bandwidth\n");
> +		fallthrough;
> +	case 4:
> +		bw = MBps_to_icc(PCIE_GEN4_BW_MBPS);
> +		break;
> +	}
> +
> +	ret = icc_set_bw(pcie_ep->icc_mem, 0, width * bw);
> +	if (ret)
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +}
> +
>  static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>  {
>  	int ret;
> +	struct dw_pcie *pci = &pcie_ep->pci;

Move this variable above "ret" to follow reverse Xmas tree order.

>  
>  	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
>  	if (ret)
> @@ -277,8 +327,23 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>  	if (ret)
>  		goto err_phy_exit;
>  
> -	return 0;
> +	/*
> +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> +	 * to be set before enabling interconnect clocks.
> +	 *
> +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> +	 * for the pcie-mem path.
> +	 */
> +	ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(PCIE_GEN1_BW_MBPS));
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +		goto err_phy_off;
> +	}
>  
> +	return 0;

Newline needed here.

- Mani

> +err_phy_off:
> +	phy_power_off(pcie_ep->phy);
>  err_phy_exit:
>  	phy_exit(pcie_ep->phy);
>  err_disable_clk:
> @@ -550,6 +615,10 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
>  	if (IS_ERR(pcie_ep->phy))
>  		ret = PTR_ERR(pcie_ep->phy);
>  
> +	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
> +	if (IS_ERR(pcie_ep->icc_mem))
> +		ret = PTR_ERR(pcie_ep->icc_mem);
> +
>  	return ret;
>  }
>  
> @@ -573,6 +642,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>  	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
>  		dev_dbg(dev, "Received BME event. Link is enabled!\n");
>  		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
> +		qcom_pcie_ep_icc_update(pcie_ep);
>  		pci_epc_bme_notify(pci->ep.epc);
>  	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
>  		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
