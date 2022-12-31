Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C089565A826
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiLaXS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLaXSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:18:44 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE46E25CA
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 15:18:43 -0800 (PST)
Received: from [192.168.2.144] (adsl-d248.84-47-10.t-com.sk [84.47.10.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 28F703ED5A;
        Sun,  1 Jan 2023 00:18:41 +0100 (CET)
Date:   Sun, 01 Jan 2023 00:18:35 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v5 3/6] phy: qcom-qmp: Add SM6125 UFS PHY support
To:     Lux Aliaga <they@mint.lgbt>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <ZE3SNR.M14JYXQJQTSC1@somainline.org>
In-Reply-To: <20221231222420.75233-4-they@mint.lgbt>
References: <20221231222420.75233-1-they@mint.lgbt>
        <20221231222420.75233-4-they@mint.lgbt>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, Dec 31 2022 at 07:24:17 PM -03:00:00, Lux Aliaga 
<they@mint.lgbt> wrote:
> The SM6125 UFS PHY is compatible with the one from SM6115. Add a
> compatible for it and modify the config from SM6115 to make them
> compatible with the SC8280XP binding
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c 
> b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 318eea35b972..f33c84578940 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -693,6 +693,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg 
> = {
>  static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>  	.lanes			= 1,
> 
> +	.offsets		= &qmp_ufs_offsets_v5,
> +
>  	.serdes_tbl		= sm6115_ufsphy_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_serdes_tbl),
>  	.tx_tbl			= sm6115_ufsphy_tx_tbl,
> @@ -1172,6 +1174,9 @@ static const struct of_device_id 
> qmp_ufs_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,sm6115-qmp-ufs-phy",
>  		.data = &sm6115_ufsphy_cfg,
> +	}, {
> +		.compatible = "qcom,sm6125-qmp-ufs-phy",
> +		.data = &sm6115_ufsphy_cfg,
>  	}, {
>  		.compatible = "qcom,sm6350-qmp-ufs-phy",
>  		.data = &sdm845_ufsphy_cfg,
> --
> 2.38.1
> 
Reviewed-by: Martin Botka <martin.botka@somainline.org>

Happy new year as well :)


