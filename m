Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E25716C99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjE3SfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjE3Set (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:34:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C73E10C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:34:44 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 02EB266020E9;
        Tue, 30 May 2023 19:34:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685471682;
        bh=Mc4XFuvSXqyxxvNjISIQlJNJFdT5sV7i4Xq+tgbBWFc=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=LkGV3TU4pj1obj3spTh8Sn2Hw3iy6O9lEPbnHhxNnCacHT5LFpNUuQHVrAVeOx+lG
         qx0WXIj1X99Vs4ezsCKhoNr6K1NHcTauVZNiZkP2Exwwk/uD4YCdE92KPEAmgCoqho
         m+k1ya3b9WaAOmBZ7Hy+knUptuCp9tl5b+YsAaFURV8C+nyjAG3Cbm8Gh804gR7yuG
         ce1rryb8dZUUA4wpvC2fw8JIqp6DvAGQRm0YPiSYenWB3q11+ozzQ2dobofIfrmqp0
         0z4o81YzMyZg13SE5UtK23crqIEzq/zaC9UJTJM4KqIUSHMRbE87jfyqmMshWuQJtJ
         FCbwAOqoqwshA==
Message-ID: <05b97262-85e7-e9e6-7a38-84ec88f95e71@collabora.com>
Date:   Tue, 30 May 2023 21:34:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND] arm64: defconfig: Enable Rockchip I2S TDM and
 ES8316 drivers
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230504201916.1121243-1-cristian.ciocaltea@collabora.com>
In-Reply-To: <20230504201916.1121243-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 23:19, Cristian Ciocaltea wrote:
> The Rockchip I2S TDM driver and the Everest Semi ES8316 codec are used
> to provide analog audio support on the RK3588 SoC based Rock 5B board.
> 
> Enable both of them as modules.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 1e7021ead7f5..dff4c4296c08 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -867,6 +867,7 @@ CONFIG_SND_SOC_SM8250=m
>  CONFIG_SND_SOC_SC7180=m
>  CONFIG_SND_SOC_SC7280=m
>  CONFIG_SND_SOC_ROCKCHIP=m
> +CONFIG_SND_SOC_ROCKCHIP_I2S_TDM=m
>  CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
>  CONFIG_SND_SOC_ROCKCHIP_RT5645=m
>  CONFIG_SND_SOC_RK3399_GRU_SOUND=m
> @@ -897,6 +898,7 @@ CONFIG_SND_SOC_AK4613=m
>  CONFIG_SND_SOC_DA7213=m
>  CONFIG_SND_SOC_ES7134=m
>  CONFIG_SND_SOC_ES7241=m
> +CONFIG_SND_SOC_ES8316=m
>  CONFIG_SND_SOC_GTM601=m
>  CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
>  CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m

Could we get this reviewed/merged, please?

Thanks,
Cristian
