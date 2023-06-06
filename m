Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5108B7239D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbjFFHmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjFFHlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:41:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C801732;
        Tue,  6 Jun 2023 00:41:01 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E8BA96606E97;
        Tue,  6 Jun 2023 08:40:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686037260;
        bh=T6bPfT4kWKXeLuDb4qVwp6rN6eB3ntz2Arg+fo8McNY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AVPap7ZRIELTPbnrDMY6r4kM4eo1m72aDqA0OAzzeGCCWy4aG0N+YMyEE4vm/l71s
         bGUqJjuyXZTpbg19sQNhTjcVt4/2JlxsMXN99ySVv9PsT2zkNhPyKVCZ0fy4EqTr6J
         TUl0/qem9xv5yP6fNK1lnmvqnxdmP6vkjhtOE8m1ZfB8/Fvmy1kHof1iGOa99HP0Gr
         IZ1i+xYcSn/9jPtnOdrLVhU79hzqSf8UYxiEbrUN8c964UOSJAr3/SPtWJvt23azhD
         zPbf7JeEqDOUAUOzilaj3JT/SmMGjpaQEmR8PyzEJ0/EHB45KgzU44c9tfFKcT6qgY
         wJZ4rF0AMsbcA==
Message-ID: <e1c6d01b-2911-eeda-373c-59dd2bb1ca19@collabora.com>
Date:   Tue, 6 Jun 2023 09:40:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 6/6] arm64: dts: mediatek: mt8183: Add decoder
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Yunfei Dong <yunfei.dong@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230605162030.274395-1-nfraprado@collabora.com>
 <20230605162030.274395-7-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230605162030.274395-7-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/06/23 18:20, Nícolas F. R. A. Prado ha scritto:
> From: Yunfei Dong <yunfei.dong@mediatek.com>
> 
> Add node for the hardware decoder present on the MT8183 SoC.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Signed-off-by: Qianqian Yan <qianqian.yan@mediatek.com>
> Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 39 ++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 5169779d01df..8bb10ed67e87 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -2019,6 +2019,45 @@ vdecsys: syscon@16000000 {
>   			#clock-cells = <1>;
>   		};
>   
> +		vcodec_dec: video-codec@16020000 {
> +			compatible = "mediatek,mt8183-vcodec-dec";
> +			reg = <0 0x16020000 0 0x1000>,		/* VDEC_MISC */
> +			      <0 0x16021000 0 0x800>,		/* VDEC_VLD */
> +			      <0 0x16021800 0 0x800>,		/* VDEC_TOP */
> +			      <0 0x16022000 0 0x1000>,		/* VDEC_MC */
> +			      <0 0x16023000 0 0x1000>,		/* VDEC_AVCVLD */
> +			      <0 0x16024000 0 0x1000>,		/* VDEC_AVCMV */
> +			      <0 0x16025000 0 0x1000>,		/* VDEC_PP */
> +			      <0 0x16026800 0 0x800>,		/* VP8_VD */
> +			      <0 0x16027000 0 0x800>,		/* VP6_VD */
> +			      <0 0x16027800 0 0x800>,		/* VP8_VL */
> +			      <0 0x16028400 0 0x400>;		/* VP9_VD */
> +			reg-names = "misc",
> +				    "ld",
> +				    "top",
> +				    "cm",
> +				    "ad",
> +				    "av",
> +				    "pp",
> +				    "hwd",
> +				    "hwq",
> +				    "hwb",
> +				    "hwg";

Do we really need one line for each 2/3 characters reg name? :-P

Regards,
Angelo

