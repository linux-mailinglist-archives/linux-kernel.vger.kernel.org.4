Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605C56FBF63
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbjEIGkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjEIGkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:40:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357DED2FA
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:39:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so10319851a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 23:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683614367; x=1686206367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IM7qDwaUjPNbIoAw8I8VIhi3Ml7dO5NG45Isn8YkDVM=;
        b=AiRYDnyX0m9nFDQwL4zMnF1bqOcaDQxUYS0EXBFOlO87+Iw+VIjraazKiJkMEobRJe
         5tMA9nVaEA/IkUujtmC2w6lrPoUwLIDuarKtkbk7uyuD6JPdUPgjpX3nu3a1PVZ29Nk4
         quLETAeDAkZaN5iXWUl6tt5KhqvCBFnviY60PHJnV7WPw4CB3tN5piIb+U5Y2L6h+coC
         YdxdMzyAU4f0AbzeJtJDr913ZocW3FQyw0taX9wgw/6xbHUsPPEGWK1gnSa8m71KuZy7
         HUJcmH/YH1dxLk4McATbkxpFDSyIJ888jF265nvvYBBuqiaVdsKR7fWvOxncWviwcxqJ
         Gj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683614367; x=1686206367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IM7qDwaUjPNbIoAw8I8VIhi3Ml7dO5NG45Isn8YkDVM=;
        b=AGYpreXbcZoh5dHVGMXJHRxPkBoXiydo30USfMUrjChaUhuP96p6jamCRBLvCf1v3M
         WJIN8ZEBknfbkiwu3NSOHtLpIHenL8PGJ+jBcCbuztbK0wFKSZc3U+XzT6ienk9qrxfw
         kkmcoKGQKg4QZpgrKqYcS0QTiuUy3Kk5y6To1V+PJcaU5ZOXxHtkzv3x6tLk19LDS9v4
         QRWX1ugELPECDxT3Zke3r4dPHsMtCcuoPq+/cgoSDw/O1VxJcptrRnM2GqWSCL+bRmap
         AdjrZzmipAtNcUUAaQhKfc+sRCK2sLELKoUkUlb+GtSerWohFDpPewxCpe1aKNzkh8Qm
         XFhA==
X-Gm-Message-State: AC+VfDwzeKs693ph93cCbbu+NysUfAvjU4+Y3Qu2vCUoBfRKld9xiGdS
        Vzd0tfZlHkACPjxlUkqeh+foVyy5i/L0tYD3xBk=
X-Google-Smtp-Source: ACHHUZ4+ExKmensR919j0MWRRZR1+2u+tnVGR58jyL2ETBI7Qybwu+uxPdNcnv5D48uqRi/5FcBM5w==
X-Received: by 2002:a17:907:94d0:b0:965:6603:34fa with SMTP id dn16-20020a17090794d000b00965660334famr12176903ejc.12.1683614366935;
        Mon, 08 May 2023 23:39:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id h10-20020a1709070b0a00b00965ac1510f8sm901598ejl.185.2023.05.08.23.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 23:39:26 -0700 (PDT)
Message-ID: <46b0dbd4-5695-1a2d-8d06-0a60a7c3a151@linaro.org>
Date:   Tue, 9 May 2023 08:39:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: defconfig: enable PCIe controller on TI platforms
Content-Language: en-US
To:     Achal Verma <a-verma1@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "N_colas F . R . A . Prado" <nfraprado@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Rafa_ Mi_ecki <rafal@milecki.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230509063431.1203367-1-a-verma1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509063431.1203367-1-a-verma1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 08:34, Achal Verma wrote:
> Enable PCIe controller and serdes drivers to enable PCIe functionality.
> * Enable Cadence serdes phy and wrapper driver.
> * Enable Cadence PCIe controller driver.

Why? IOW, which boards needs it?
> 
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
>  arch/arm64/configs/defconfig | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a24609e14d50..ff187dd585c2 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -230,9 +230,16 @@ CONFIG_PCIE_HISI_STB=y
>  CONFIG_PCIE_TEGRA194_HOST=m
>  CONFIG_PCIE_VISCONTI_HOST=y
>  CONFIG_PCIE_LAYERSCAPE_GEN4=y
> +CONFIG_PCIE_CADENCE=y

=m

> +CONFIG_PCIE_CADENCE_HOST=y
> +CONFIG_PCIE_CADENCE_EP=y
> +CONFIG_PCI_J721E=y

=m

> +CONFIG_PCI_J721E_HOST=y
> +CONFIG_PCI_J721E_EP=y
>  CONFIG_PCI_ENDPOINT=y
>  CONFIG_PCI_ENDPOINT_CONFIGFS=y
>  CONFIG_PCI_EPF_TEST=m
> +CONFIG_PCI_EPF_NTB=m
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_FW_LOADER_USER_HELPER=y
> @@ -1330,8 +1337,8 @@ CONFIG_RESET_TI_SCI=y
>  CONFIG_PHY_XGENE=y
>  CONFIG_PHY_CAN_TRANSCEIVER=m
>  CONFIG_PHY_SUN4I_USB=y
> -CONFIG_PHY_CADENCE_TORRENT=m
> -CONFIG_PHY_CADENCE_SIERRA=m
> +CONFIG_PHY_CADENCE_TORRENT=y
> +CONFIG_PHY_CADENCE_SIERRA=y

Why? Commit msg does not explain it.

>  CONFIG_PHY_MIXEL_MIPI_DPHY=m
>  CONFIG_PHY_FSL_IMX8M_PCIE=y
>  CONFIG_PHY_HI6220_USB=y
> @@ -1363,8 +1370,8 @@ CONFIG_PHY_SAMSUNG_UFS=y
>  CONFIG_PHY_UNIPHIER_USB2=y
>  CONFIG_PHY_UNIPHIER_USB3=y
>  CONFIG_PHY_TEGRA_XUSB=y
> -CONFIG_PHY_AM654_SERDES=m
> -CONFIG_PHY_J721E_WIZ=m
> +CONFIG_PHY_AM654_SERDES=y
> +CONFIG_PHY_J721E_WIZ=y

Why?

>  CONFIG_ARM_CCI_PMU=m
>  CONFIG_ARM_CCN=m
>  CONFIG_ARM_CMN=m

Best regards,
Krzysztof

