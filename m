Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57955604708
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiJSN1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiJSN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:26:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637E51793B4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:13:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g1so28003827lfu.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqDvk7+exoNL3wVC4+UCNH0Gcht0+8dPb7k0aCCIA4U=;
        b=l2wqik9MZ7MgeaQq4PYtPyC/ESK8vjtBxpP3yMZwEc2/jwyY2UQpAsKSvnrAe3wT1c
         ajPfNOuKHkroxGyXUbIPSULj5Nj+ZJky1/fvRxnt/k29EykkAxrq7XkQ0J5W+2eE1Oab
         1hv6lY0g2Vb4kkEyI6G1xleX61MJIyVqgtG2ZVZ5gEFol3tKGsT0BPaNcP9hAK6Wa07w
         7S+n5WQIt0xXKNDkj8L+Owp5SlS5DDvSGbMr9nN+9S/9DoG4EbUr7c9m+EVbRovMwvmr
         l9zN3vSidTNMAf60dnHj5FJkdoy/kYQGlWktoNkgGY+u955mnz1W+jFjc0Mo9i6RnOEv
         QlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqDvk7+exoNL3wVC4+UCNH0Gcht0+8dPb7k0aCCIA4U=;
        b=vue7aYhaBSag2VS02SL/nMXBfFPH2RDkg3xZz8SSuBN+hETjub3kuVUV8LOAJFEvGs
         aJg7GZMkL0wE42AD13QdS2CeSYpXLRRRao42Mbv96bATGz0NpX8UkxE7iszGH3ySeHS/
         rPhV7Y3lzywxn8OqENYOeb0B6XPJvfNRqZfoIRqa2UZvxOQ3VqHpf8YH0cpYYAORd/8c
         VnY79SElpYfzhsPNoXxvZNYhGE+jU8d12ozBxIJyAETWxkNwpUxXMUQoMhDfSihaphdt
         22UBJVynYqpamVzEFxKAv7mIzt9rR7mcswx+cznPYl2pzELuCZyj+e4V0a9xj1e2g3w8
         uiNA==
X-Gm-Message-State: ACrzQf2bQQ2QOx8gSQEYu7eC+cMTrqM0B7s0bTmjvtrMaKr1VSt5X/Q9
        GQBEue/y8LiRk1CYfjHFRw7zfg==
X-Google-Smtp-Source: AMsMyM5tGKH8k0FM95AqUc7ouKnl7Osrbk4TyjvB28KHNdYabY8SPKqjwcZD/vcUv8DowyQeSBW4vA==
X-Received: by 2002:a05:6512:3053:b0:4a2:6b9c:a853 with SMTP id b19-20020a056512305300b004a26b9ca853mr2700368lfb.666.1666185123437;
        Wed, 19 Oct 2022 06:12:03 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k14-20020ac2456e000000b004948378080csm2274704lfm.290.2022.10.19.06.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 06:12:03 -0700 (PDT)
Message-ID: <0f1fff20-772f-c4d1-f803-f1824ef23780@linaro.org>
Date:   Wed, 19 Oct 2022 16:12:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 08/15] phy: qcom-qmp-pcie: add register init helper
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
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-9-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221019113552.22353-9-johan+linaro@kernel.org>
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

On 19/10/2022 14:35, Johan Hovold wrote:
> Generalise the serdes initialisation helper so that it can be used to
> initialise all the PHY registers (e.g. serdes, tx, rx, pcs).
> 
> Note that this defers the ungating of the PIPE clock somewhat, which is
> fine as it isn't needed until starting the PHY.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 51 +++++++-----------------
>   1 file changed, 15 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index dd7e72424fc0..f57d10f20277 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1820,46 +1820,32 @@ static void qmp_pcie_configure(void __iomem *base,
>   	qmp_pcie_configure_lane(base, tbl, num, 0xff);
>   }
>   
> -static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> -{
> -	void __iomem *serdes = qmp->serdes;
> -
> -	if (!tables)
> -		return;
> -
> -	qmp_pcie_configure(serdes, tables->serdes, tables->serdes_num);
> -}
> -
> -static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> +static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
>   {
>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	void __iomem *serdes = qmp->serdes;
>   	void __iomem *tx = qmp->tx;
>   	void __iomem *rx = qmp->rx;
>   	void __iomem *tx2 = qmp->tx2;
>   	void __iomem *rx2 = qmp->rx2;
> +	void __iomem *pcs = qmp->pcs;
> +	void __iomem *pcs_misc = qmp->pcs_misc;
>   
> -	if (!tables)
> +	if (!tbls)
>   		return;
>   
> -	qmp_pcie_configure_lane(tx, tables->tx, tables->tx_num, 1);
> -	qmp_pcie_configure_lane(rx, tables->rx, tables->rx_num, 1);
> +	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
> +
> +	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
> +	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
>   
>   	if (cfg->lanes >= 2) {
> -		qmp_pcie_configure_lane(tx2, tables->tx, tables->tx_num, 2);
> -		qmp_pcie_configure_lane(rx2, tables->rx, tables->rx_num, 2);
> +		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
> +		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);
>   	}
> -}
> -
> -static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> -{
> -	void __iomem *pcs = qmp->pcs;
> -	void __iomem *pcs_misc = qmp->pcs_misc;
> -
> -	if (!tables)
> -		return;
>   
> -	qmp_pcie_configure(pcs, tables->pcs, tables->pcs_num);
> -	qmp_pcie_configure(pcs_misc, tables->pcs_misc, tables->pcs_misc_num);
> +	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
> +	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);

Nit: could we please keep it as `tables'?

>   }
>   
>   static int qmp_pcie_init(struct phy *phy)
> @@ -1932,8 +1918,8 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	else
>   		mode_tables = cfg->tables_ep;
>   
> -	qmp_pcie_serdes_init(qmp, &cfg->tables);
> -	qmp_pcie_serdes_init(qmp, mode_tables);
> +	qmp_pcie_init_registers(qmp, &cfg->tables);
> +	qmp_pcie_init_registers(qmp, mode_tables);
>   
>   	ret = clk_prepare_enable(qmp->pipe_clk);
>   	if (ret) {
> @@ -1941,13 +1927,6 @@ static int qmp_pcie_power_on(struct phy *phy)
>   		return ret;
>   	}
>   
> -	/* Tx, Rx, and PCS configurations */
> -	qmp_pcie_lanes_init(qmp, &cfg->tables);
> -	qmp_pcie_lanes_init(qmp, mode_tables);
> -
> -	qmp_pcie_pcs_init(qmp, &cfg->tables);
> -	qmp_pcie_pcs_init(qmp, mode_tables);
> -
>   	/* Pull PHY out of reset state */
>   	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>   

-- 
With best wishes
Dmitry

