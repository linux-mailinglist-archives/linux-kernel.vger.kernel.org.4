Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263E26B8F33
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCNKEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCNKEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:04:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E23125BD;
        Tue, 14 Mar 2023 03:04:44 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA1356603090;
        Tue, 14 Mar 2023 10:04:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678788283;
        bh=MrQ2ho4+U1CGbnQubBJQGWN0CEELi3nQ2ogNYmD/lU4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DLvT6mWizq3XCuPv3EXpL3j79t4hic7fz9G2iONCuJPEmYkwIj2AQYfEsMCVLc3XG
         GqDk1NsiCzwquWSt/FhCn8+52Uc23673cMavtfGd3eZcrVbbwVlyXGZnuwV3Uz+HD2
         o353GbxwYOfQAKpSjrMDt9xItPekEl/wmWXO74jKX7CzUM49QqFnvptcvZokyK2XxL
         iodmv6yHEIfaVuGu4nJT98mWhPgNawpasg3kNuUvF2bKw2mbbg7J1f4Tso/c4F4PFK
         +dVd5LgeW/yQx2IIKbMPizqJVDB+Xs/gVwIeU6RPZ/E3CLTWfe3saBqz/SbOHqS/um
         FZs7725LZDMOA==
Message-ID: <df791ee6-de96-3dfd-ce88-9a5ea7f60a04@collabora.com>
Date:   Tue, 14 Mar 2023 11:04:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 02/11] arm64: dts: mediatek: Update the node name of
 SCP rpmsg subnode
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230303083355.3378-1-tinghan.shen@mediatek.com>
 <20230303083355.3378-3-tinghan.shen@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230303083355.3378-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/03/23 09:33, Tinghan Shen ha scritto:
> Align the node name with the definition in SCP bindings.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi   | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index fbe14b13051a..a259eb043de5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -810,7 +810,7 @@
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&scp_pins>;
>   
> -	cros_ec {
> +	cros-ec-rpmsg {
>   		compatible = "google,cros-ec-rpmsg";
>   		mediatek,rpmsg-name = "cros-ec-rpmsg";
>   	};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> index 9f12257ab4e7..8f14b633c1e1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -1260,7 +1260,7 @@
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&scp_pins>;
>   
> -	cros-ec {
> +	cros-ec-rpmsg {
>   		compatible = "google,cros-ec-rpmsg";
>   		mediatek,rpmsg-name = "cros-ec-rpmsg";
>   	};


