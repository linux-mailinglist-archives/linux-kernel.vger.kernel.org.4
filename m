Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23BB6075F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJULS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJULSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:18:54 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA02C26109D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:18:52 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a25so3336922ljk.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfd+0JzA8Iis6KL3aTCze9WTP9msz3vAzTenCMjoVDE=;
        b=nfZhPlxaSX8v5gKfm1w63BxH5X+z8KD8VcClmTrnYHXjSz/ol8wMzmP7WkxJYj2UcC
         YoZ9ofotfsvv6tVxLl8PfUu67LNcOC3ZFlkK5F8hD1W83BEcMb9eZ1cT2ggHmLA9n9dZ
         AQG/J3JPPywCD5v+wVYVCBuTaUaMBpDniotZi14XK1e9uaTgW6p8C8XcpTfx5ZAf+RMb
         rs1MJJ50fJPXRT0Lqsb7kEbmuYRGuIO6DXl+crweDd7wRw/eDPt0ugGpyTeJnvy9ZVEj
         K91phP+1nPwH8NAGQXhS2StrlgPaRUnWGIMl6MC6xMfjBbWhXajBUxq90ydohxPQVkKd
         XVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfd+0JzA8Iis6KL3aTCze9WTP9msz3vAzTenCMjoVDE=;
        b=SOX7EanXqHWMZu2GaEpmIaAWp30SlTcap0FAFBsdEg/Dov2fQEF+BM6D5iPbnbScXu
         1rZVxRS/UTzJG+HlqNtUeLMvLR3gw/a5YLIZ9OXT0pN/NKJVn2N1RyNObcHbXRsVln83
         iZfuYTm5JSr++0PYFphvZAlazeZsZj5Xh2VLrH1mmkJiUdD48yFkDHLfTBvYms9I+eru
         /NS/hrzs3PeU5nyE+oXzuQKgjA/fuw5Zm5KDlA9gHieq782vGsSvy7ytq1/2kcFCJrQ2
         6PGECy7QdI8RRsw47JFlpS2A2ZzryzEVk9LjLQyaCHjR075Q4lB746L6b1iA3XJQ5Yw6
         fi7g==
X-Gm-Message-State: ACrzQf0uQvbBhU3nltkaCbHBHOrvcNmCTid5RAgA7MPMA9hCiRcIQbsq
        JzXsvLiqOx5aut0eCFemGB+/Mg==
X-Google-Smtp-Source: AMsMyM7oUD764hXlWEUxV6GF6H3mR6bmGNk5lm7ii77aPC6tmzatDUcVjgoO4B7NXptwDHJTlCTz0w==
X-Received: by 2002:a2e:9447:0:b0:261:e71e:e3d with SMTP id o7-20020a2e9447000000b00261e71e0e3dmr6562244ljh.227.1666351130954;
        Fri, 21 Oct 2022 04:18:50 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id o13-20020a05651205cd00b00494643db68fsm3134458lfo.81.2022.10.21.04.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 04:18:50 -0700 (PDT)
Message-ID: <932765e0-ecbc-8c9b-69c5-ce0bb0c8de68@linaro.org>
Date:   Fri, 21 Oct 2022 14:18:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 08/15] phy: qcom-qmp-pcie: add register init helper
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
References: <20221021110947.28103-1-johan+linaro@kernel.org>
 <20221021110947.28103-9-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221021110947.28103-9-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 14:09, Johan Hovold wrote:
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

As seem above, if nothing else, tables -> tbls rename generates 
unnecessary diff.
Other than that LGTM.

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

