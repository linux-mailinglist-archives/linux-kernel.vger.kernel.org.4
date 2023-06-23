Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A12473B511
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjFWKSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjFWKRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:17:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2912122
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:17:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b45b6adffbso7740631fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687515445; x=1690107445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmnwBRcLxlLaDdo6mB36QgEka2ETrjATB/p74yVLKR4=;
        b=Ls+bHU7JH+ZotuHgx7MMfNQSeV8aoizw+J0UO2hPhtfTlUdcGzDNHCwcNzS1MWVe4X
         Yd3uNLCfwZ2YatnWLHQbYHNq3NNRreR3T+oi56Lh/zZDICXtEJR93GP2GENWfU1gShkO
         XyLRxNG0fd1teSNTSPkezsNGOCNoNXGbeRIdAMg9lfalrHPpIngW2Y0KL+6yb3fBIfyD
         MOY4UQ2usjSAPxPc/8lbi5VQtbKh/3IzRUoEDRkiBeMA58IK2KOBVQ31NjgkT13OWW6F
         P/uGlylgOZohW9I2NNjlKtj1DFRarqJ5B5/WprM5JbbbRSJPLWad4s3BfegWRewSMCk2
         tUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515445; x=1690107445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmnwBRcLxlLaDdo6mB36QgEka2ETrjATB/p74yVLKR4=;
        b=OatR4ebl1HJysH6Tcf32NVq93ZF2B9VgA/MLK6Juf270y+0CpMjz7uO3Lp9r7t9VYf
         cpuBEHyKhTSseRnJBoCIsV/YTOBEQ38+YTRnKiqNWHLcKzF7+goQ/6r8RceCkA4nzbIP
         OIv4iffuIVUe0zdwgj0BEbq0YlAxjvQZwtkVD93YDgYBouccDoDR52YI5j83Jc805scm
         BS1TZGbKY1wKMXrBaSnJJlhu2RyG7YoU3h0Fu8KgVO5UFAbjFLIulmCVskxEgCrxudJE
         YDYQOKs2qSsSXvJEZx0MESaM5lqupEGZlGTz7chyoiogcZThS3A65RvSh5PbRHXic0oI
         nyxQ==
X-Gm-Message-State: AC+VfDwGJslkTFPr4qkF0rBz2oVB7x0J3jsLSvDgytOVU9LWjQ0hQz4c
        +Z/kZ8bIX7LCUxXWOcDawd4Ndg==
X-Google-Smtp-Source: ACHHUZ7FWKxUD50yneBR1nDecy7OGIMWB1V0UiNuub6UxToUjE3EVp4xKbx0k2PURH6LH91Z1CYkaw==
X-Received: by 2002:a2e:7003:0:b0:2b4:70b1:af01 with SMTP id l3-20020a2e7003000000b002b470b1af01mr11471024ljc.20.1687515444831;
        Fri, 23 Jun 2023 03:17:24 -0700 (PDT)
Received: from [192.168.1.101] (abxh63.neoplus.adsl.tpnet.pl. [83.9.1.63])
        by smtp.gmail.com with ESMTPSA id y14-20020a2e95ce000000b002b4771cdc67sm1682352ljh.35.2023.06.23.03.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 03:17:24 -0700 (PDT)
Message-ID: <c85284d9-c4e9-eae4-2551-5295c4462f3b@linaro.org>
Date:   Fri, 23 Jun 2023 12:17:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] PCI: qcom: configure the parf halt window size to 1GB
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
References: <20230623045731.29397-1-quic_devipriy@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230623045731.29397-1-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.2023 06:57, Devi Priya wrote:
> Configure the ADDR_BIT_INDEX of PARF_AXI_MSTR_WR_ADDR_HALT_V2 register with
> 0x1E to increase the halt window size to 1GB so that, when new inbound
> posted write transactions whose address crosses 1G address range, the
> controller would halt all the incoming writes until all the previous AXI
> responses are received.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
Has this been tested on anything except IPQ9574? Does it concern other
SoCs?


>  This patch depends on the below series which adds support for PCIe 
>  controllers in IPQ9574
>  https://lore.kernel.org/linux-arm-msm/20230519090219.15925-1-quic_devipriy@quicinc.com/
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c7579dfa5b1c..26c40e006120 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -116,6 +116,8 @@
>  
>  /* PARF_AXI_MSTR_WR_ADDR_HALT register fields */
>  #define EN					BIT(31)
> +#define ADDR_BIT_INDEX				(BIT(0) | BIT(1) | BIT(2) | \
> +						BIT(3) | BIT(4) | BIT(5))
You surely should have the names of these bitfields, mind defining them?

>  
>  /* PARF_LTSSM register fields */
>  #define LTSSM_EN				BIT(8)
> @@ -154,6 +156,8 @@
>  
>  #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
>  
> +#define PARF_AXI_MSTR_WR_ADDR_HALT_WINDOW_SIZE	0x1e
> +
>  #define QCOM_PCIE_1_0_0_MAX_CLOCKS		4
>  struct qcom_pcie_resources_1_0_0 {
>  	struct clk_bulk_data clks[QCOM_PCIE_1_0_0_MAX_CLOCKS];
> @@ -1126,6 +1130,11 @@ static int qcom_pcie_post_init(struct qcom_pcie *pcie)
>  
>  	writel(0, pcie->parf + PARF_Q2A_FLUSH);
>  
> +	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> +	val &= ~ADDR_BIT_INDEX;
> +	writel(val | PARF_AXI_MSTR_WR_ADDR_HALT_WINDOW_SIZE, pcie->parf +
> +			PARF_AXI_MSTR_WR_ADDR_HALT_V2);
val |= ..
writel(val, pcie..)

would be more readable

Konrad
> +
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>  
