Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F394602C58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJRNFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJRNFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:05:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A7FC4D90
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:05:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d6so22357192lfs.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgD9kZURxSV2+Jxzl+l3QUkumq48W2A38D+vEtiJ1Rc=;
        b=BR0V+6uNZn/HO6b3BiLjY69G/W/m65ZgIp+zLnD98J/oBPW87eSoIIilOP6LKeh3lH
         MgH7eZWuPIqhy0v1wJyxx4owSEVLRJaHe/229RwaAbAc6coo8uNwfgjVUcPQzWw6CLL1
         VqLffgVudxbPZFBLVtQI6r7B35UFNBMVox2K+JSSScLQhcf5nLgALa3RfW44hIpJDT+h
         3HU1asjDS9oskPcN+6PQpa5gz8bRlPa6cS6VY6j8yBtgHre8w5ywLmJuT+wZhUVcbZFc
         3q9qfonK2pn2xzFJbCaHTNRBJ942ajnUvZTlsmtZHcfD4kn/Xf0hTx3JJfyptByXh7hi
         +hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgD9kZURxSV2+Jxzl+l3QUkumq48W2A38D+vEtiJ1Rc=;
        b=ote6zHoBlUorxwZUnsVlNtZbQ5DOsgI8pz4BMti8BRpSbmah4GdTNQU/pF1HoCC0DO
         OZEIVM4hxyQCZzSRr/vGo9tCgBDMJG+aDEUem1W3gFqYuwMfn1AdtwXs/nb98OeGMipA
         PTwodoSsLrRd9BejHJ9IOR8jU+9Zzy0zNKzBE7xv3zReI0Wo9P42q6UhPduQ88AUPeQx
         NB71/wshaBxybyTPkd3xOJoexAKchCWh/aiTxd9HSxhNUYW/wEe2uyrC+CIT0HsOZnRy
         LD+P4tnMyDV8L6S2zyUbi1xMz23/RcsD1wjxApEuWz+spvNlz/TlOShodGiK93fmmjRn
         6s3g==
X-Gm-Message-State: ACrzQf0/+3iXJ1CR+yh59ORtUP9Orw9tiWRnRmVEefuufaCzuPJtY2oh
        i+bJOTqcGz3nIzwQIUY7ttip/g==
X-Google-Smtp-Source: AMsMyM6cSxZHtfiUXjJkcPdZwXMrh4R2F6KBhxzZQtIK46bRK4C4DOqqSINnIf8MTi9aV3jj9iFtJQ==
X-Received: by 2002:a19:f80c:0:b0:4a4:5923:5174 with SMTP id a12-20020a19f80c000000b004a459235174mr1016570lff.151.1666098330548;
        Tue, 18 Oct 2022 06:05:30 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v18-20020a2ea452000000b0026ab83298d6sm1976580ljn.77.2022.10.18.06.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:05:30 -0700 (PDT)
Message-ID: <2cf670a0-59bd-31b0-8816-496c1e13165d@linaro.org>
Date:   Tue, 18 Oct 2022 16:05:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 13/15] phy: qcom-qmp-pcie: add support for pipediv2 clock
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-14-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221017145328.22090-14-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 17:53, Johan Hovold wrote:
> Some QMP PHYs have a second fixed-divider pipe clock that needs to be
> enabled along with the pipe clock.
> 
> Add support for an optional "pipediv2" clock.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 42 ++++++++++++++++++++----
>   1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 9c8e009033f1..c1d74c06fad1 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1379,7 +1379,9 @@ struct qmp_pcie {
>   	void __iomem *rx2;
>   
>   	struct clk *pipe_clk;
> +	struct clk *pipediv2_clk;
>   	struct clk_bulk_data *clks;
> +
>   	struct reset_control_bulk_data *resets;
>   	struct regulator_bulk_data *vregs;
>   
> @@ -1902,6 +1904,36 @@ static int qmp_pcie_exit(struct phy *phy)
>   	return 0;
>   }
>   
> +static int pipe_clk_enable(struct qmp_pcie *qmp)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(qmp->pipe_clk);
> +	if (ret) {
> +		dev_err(qmp->dev, "failed to enable pipe clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(qmp->pipediv2_clk);
> +	if (ret) {
> +		dev_err(qmp->dev, "failed to enable pipediv2 clock: %d\n", ret);
> +		goto err_disable_pipe_clk;
> +	}

Do they have to be enabled in sequence? If not, I'd use a bulk clocks 
here for the pipe clocks. While it can look like an overkill, it would 
be a safe net for the possible future changes, which might include 
additional clocks.

> +
> +	return 0;
> +
> +err_disable_pipe_clk:
> +	clk_disable_unprepare(qmp->pipe_clk);
> +
> +	return ret;
> +}
> +
> +static void pipe_clk_disable(struct qmp_pcie *qmp)
> +{
> +	clk_disable_unprepare(qmp->pipediv2_clk);
> +	clk_disable_unprepare(qmp->pipe_clk);
> +}
> +
>   static int qmp_pcie_power_on(struct phy *phy)
>   {
>   	struct qmp_pcie *qmp = phy_get_drvdata(phy);
> @@ -1923,11 +1955,9 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	qmp_pcie_init_registers(qmp, &cfg->tables);
>   	qmp_pcie_init_registers(qmp, mode_tables);
>   
> -	ret = clk_prepare_enable(qmp->pipe_clk);
> -	if (ret) {
> -		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
> +	ret = pipe_clk_enable(qmp);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	/* Pull PHY out of reset state */
>   	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> @@ -1950,7 +1980,7 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	return 0;
>   
>   err_disable_pipe_clk:
> -	clk_disable_unprepare(qmp->pipe_clk);
> +	pipe_clk_disable(qmp);
>   
>   	return ret;
>   }
> @@ -1960,7 +1990,7 @@ static int qmp_pcie_power_off(struct phy *phy)
>   	struct qmp_pcie *qmp = phy_get_drvdata(phy);
>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
>   
> -	clk_disable_unprepare(qmp->pipe_clk);
> +	pipe_clk_disable(qmp);
>   
>   	/* PHY reset */
>   	qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);

-- 
With best wishes
Dmitry

