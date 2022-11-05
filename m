Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DF161D9D0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 13:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiKEMHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 08:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 08:07:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC900DFA3;
        Sat,  5 Nov 2022 05:07:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 191BA60B32;
        Sat,  5 Nov 2022 12:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8294BC433C1;
        Sat,  5 Nov 2022 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667650052;
        bh=jHShzstBoSzrCbHHwKVDsQtLuaZrAOHYTh8Dz2LR5DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0cMQYqohB0acF8cNuwu6lmYUXYiCD/iI6JGQB2wcWJr9yVvs/NP2QIHcnGI+cgo1
         rxI5XjfPmNO0Jov1zpe/KRok+pn0U6zSmrX1+fY6Q2QBl5RiUSoCh4NlDAOIX7P1Zk
         ++65hZbW0fF7Z8m6LrPX+gUPyyaReBy20b68PVnKZndmnha7ZEDqx4oCxj8Efc82U6
         yT1Y0vhqCJ8FLTNrZsmsjDThhB+xkH6dPqpEv9UOPJFAV4U+lOKXOHQBUjT0AMnXDp
         KyNtt9kmdOUh+Abx9mUkQex4lFRVacLODkQqLVrDFpK7uV1i7l1QYD8CJ0GgZsZxbn
         hOkV2snR/5VHw==
Date:   Sat, 5 Nov 2022 17:37:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/16] phy: qcom-qmp-pcie: use shorter tables
 identifier
Message-ID: <Y2ZR/83gZuyDO8ZE@matsya>
References: <20221028133603.18470-1-johan+linaro@kernel.org>
 <20221028133603.18470-9-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028133603.18470-9-johan+linaro@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-10-22, 15:35, Johan Hovold wrote:
> In preparation for adding a new helper function that initialises all the
> registers in one place, use a shorter name for the configuration-tables
> pointer so that it becomes easier to see which table is being processed.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 26 ++++++++++++------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index dd7e72424fc0..791ed7ef0eab 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1820,17 +1820,17 @@ static void qmp_pcie_configure(void __iomem *base,
>  	qmp_pcie_configure_lane(base, tbl, num, 0xff);
>  }
>  
> -static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> +static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
>  {
>  	void __iomem *serdes = qmp->serdes;
>  
> -	if (!tables)
> +	if (!tbls)

I am not sure saving 2 chars really helps either with readability or
helps with shorter name, but for now am not going to nit pick this...

>  		return;
>  
> -	qmp_pcie_configure(serdes, tables->serdes, tables->serdes_num);
> +	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
>  }
>  
> -static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> +static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
>  {
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>  	void __iomem *tx = qmp->tx;
> @@ -1838,28 +1838,28 @@ static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_t
>  	void __iomem *tx2 = qmp->tx2;
>  	void __iomem *rx2 = qmp->rx2;
>  
> -	if (!tables)
> +	if (!tbls)
>  		return;
>  
> -	qmp_pcie_configure_lane(tx, tables->tx, tables->tx_num, 1);
> -	qmp_pcie_configure_lane(rx, tables->rx, tables->rx_num, 1);
> +	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
> +	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
>  
>  	if (cfg->lanes >= 2) {
> -		qmp_pcie_configure_lane(tx2, tables->tx, tables->tx_num, 2);
> -		qmp_pcie_configure_lane(rx2, tables->rx, tables->rx_num, 2);
> +		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
> +		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);
>  	}
>  }
>  
> -static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
> +static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
>  {
>  	void __iomem *pcs = qmp->pcs;
>  	void __iomem *pcs_misc = qmp->pcs_misc;
>  
> -	if (!tables)
> +	if (!tbls)
>  		return;
>  
> -	qmp_pcie_configure(pcs, tables->pcs, tables->pcs_num);
> -	qmp_pcie_configure(pcs_misc, tables->pcs_misc, tables->pcs_misc_num);
> +	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
> +	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
>  }
>  
>  static int qmp_pcie_init(struct phy *phy)
> -- 
> 2.37.3

-- 
~Vinod
