Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA15EFD97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiI2TF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiI2TFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:05:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F9A7201
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:05:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g1so3613113lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wi7DKofjueA16E8e073uzmvDRDUJqZe/ZGoID7ylCHY=;
        b=gdS1Hv80h456Tz8KssxXjJqBn/GIYD0ZTanE39MjltmnmvHogFZJZdDnch/7G7tpJO
         jYVSX/xR7xiDfgSFCgvKMfuIZKGSiZPKLQ4vaA6AWS1/HkrG0jAk/EQYPjNFxWzIuVk3
         ztyr/siX+On5Mj1jieGwNyfWQNbuRkKwX9/UT/DR5m8PgtFr3u6JtHjIj2suGcJk8HNT
         HsQHUiRpQWmpMLGl72z40MSWMLoOF1e8HTvf3xVbSCCh9aCV8Zc/dkE7sSPL3QupH9CR
         2DDYAGCB7eWlsgHAYBdKc7ruDJwe+v4LKIgaxgUUgqkQyj8KgdClk0Kuw8puieSw3r/Q
         FMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wi7DKofjueA16E8e073uzmvDRDUJqZe/ZGoID7ylCHY=;
        b=AhrQEAurp8f/Zs74SOwZUCioIHjBauJaf3HOH3qtQZKFYLphxlx/zvFWFAkP7hGDWv
         n6igfpwzetuJhep1gJbUnOgYleFi7M+9UKoylREAfRCRwGWU4TsaZWI8xUaMl2u6tVu2
         P5yeMTv9qA5DcgLp2NcSVcWdtT2b3rr3PCo+2Rvwu+80Hj2iXZKT//vvkOD+B2V8nJrE
         TpkqMnJfSiMRuygGO7jtfb2jPWkAXcj+ClSuUWQ9Oaop5FPW/VcTH2MhsmSeN/lcYToN
         54NId740JR+rEpjWHtOFQcK6QdLI3rnh3EvqqW7bWRx86GX5zED8iEFc6Js1kwsU9TBU
         gJGw==
X-Gm-Message-State: ACrzQf0/cHc9p2jzXYhTq1Amheegem0iy1odao3l1Owww6Sln5RfqdR2
        drOzFOzKt1fAGhz4SciWe/yUag==
X-Google-Smtp-Source: AMsMyM722J1TLcGst0IOdDfyiDEnlFJw4RZaKJUjf0jo/VODR83r0rkj8uF+voj/tSB3DxVPpGoVPA==
X-Received: by 2002:ac2:464b:0:b0:49e:b29c:2b04 with SMTP id s11-20020ac2464b000000b0049eb29c2b04mr1924631lfo.127.1664478321707;
        Thu, 29 Sep 2022 12:05:21 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id n5-20020a0565120ac500b0048af3c090f8sm34684lfu.13.2022.09.29.12.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 12:05:21 -0700 (PDT)
Message-ID: <f57feedb-01ce-4c15-1344-860bff602b10@linaro.org>
Date:   Thu, 29 Sep 2022 22:05:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 05/11] phy: qcom-qmp-pcie: move power-down update
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220929092916.23068-1-johan+linaro@kernel.org>
 <20220929092916.23068-6-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220929092916.23068-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 12:29, Johan Hovold wrote:
> Move the power-down-control register update that powers on the PHY to
> the power-on handler so that it matches the power-off handler.
> 
> Note that the power-on handler is currently always called directly
> after init.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index efffb77e8f45..db78d2d76c03 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1862,7 +1862,6 @@ static int qmp_pcie_init(struct phy *phy)
>   	struct qmp_phy *qphy = phy_get_drvdata(phy);
>   	struct qcom_qmp *qmp = qphy->qmp;
>   	const struct qmp_phy_cfg *cfg = qphy->cfg;
> -	void __iomem *pcs = qphy->pcs;
>   	int ret;
>   
>   	/* turn on regulator supplies */
> @@ -1888,9 +1887,6 @@ static int qmp_pcie_init(struct phy *phy)
>   	if (ret)
>   		goto err_assert_reset;
>   
> -	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> -			cfg->pwrdn_ctrl);
> -
>   	return 0;
>   
>   err_assert_reset:
> @@ -1929,6 +1925,9 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	unsigned int mask, val, ready;
>   	int ret;
>   
> +	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> +			cfg->pwrdn_ctrl);
> +
>   	qmp_pcie_serdes_init(qphy);
>   
>   	ret = clk_prepare_enable(qphy->pipe_clk);

-- 
With best wishes
Dmitry

