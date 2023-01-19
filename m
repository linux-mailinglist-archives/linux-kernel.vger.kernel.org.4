Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0978C673F04
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjASQi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjASQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:38:26 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1D34E518;
        Thu, 19 Jan 2023 08:38:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r9so2433110wrw.4;
        Thu, 19 Jan 2023 08:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQl7qUGxsdoKFrCBv66aUl3ctKwMQI8qh2LAJ26Qshs=;
        b=XSLEULwtL1hfc0ehGCkOo/d8/WdNcR/Ld/stT0tCp64bOhVWhM2UelHbCVpKCI+Pke
         5ADmmJB+wxQEtBkGa0n9l4yHXw3+POItWwRLe/ctscm15xN3fIczmH5Xm/CWQ6r6Wm+Q
         tbLxMd+Xvwd75WTdxb6mKorM4fVKjA30BrjMPyCl0WM7410KQ6aP6RKAkzRr2n3V2O/Y
         /yOE2+G+Nh1Kc/jYSd3ZUhsuf1oFFTLQ/D/QrpLOIQO20Ig6a3ZqnPz3SmxP2ixaDPTU
         g+gq52AnXwnO7JcGGSLoxj+R4CBc1MOqJ1FWwltb7C0HlR17u4gFcwVNRo4wMDXe/uyf
         YQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQl7qUGxsdoKFrCBv66aUl3ctKwMQI8qh2LAJ26Qshs=;
        b=as1woUysNqmIOelWymsPsbQ67ocCQh5jsFtD0PWcR2jeL5HT6vnU2jbfaRNGwP79qx
         EsQEUoi6meNqawFl2F51SXBi+6ZJId3WH0yzDjO3dZnn52+3//QnzrqBrHFV+CxOCsx1
         zoRc1cLR67DiPxGa5XkIhy21gIehe/LuAoCjCSRAklzUp/PytPJga2+fcOmA/wE/H4pX
         dO5YvO1sCgndFXMGUVjiD1BE9ubvTkS4xEHUaXfR4rcjCOg7xKt5NGpLRZCdIDFbTnJR
         mQyc/vR3nsZRQ5eBvNjHjHjfooO6JZAO0yl6tEe5UMBNZFtkBLw3nqPHxY0ObanKOeoT
         RT4w==
X-Gm-Message-State: AFqh2kqEEOKtYhvJGXhQVZ50/5QDndy+aTxwIWCnAOO0EC9z5ORnscFJ
        ZDJaADwULicSM/bDDY4o+aw=
X-Google-Smtp-Source: AMrXdXt8fakZIEKWCsTm2c2xaq1MMWkP19AbenzPjcXfucpcdAoh9oJ2/Tedi7D7HHxw+dMNzUWA6w==
X-Received: by 2002:a5d:6b42:0:b0:2bc:7e6c:7cd8 with SMTP id x2-20020a5d6b42000000b002bc7e6c7cd8mr10363922wrw.26.1674146303319;
        Thu, 19 Jan 2023 08:38:23 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d64e2000000b002be063f6820sm14948613wri.81.2023.01.19.08.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:38:22 -0800 (PST)
Message-ID: <344b14cf-7b87-34ac-5588-58388399357c@gmail.com>
Date:   Thu, 19 Jan 2023 17:38:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/9] arm64: dts: mediatek: mt8186: Add ADSP mailbox
 nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20230118091829.755-1-allen-kh.cheng@mediatek.com>
 <20230118091829.755-5-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230118091829.755-5-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 10:18, Allen-KH Cheng wrote:
> Add ADSP mailbox node for MT8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index a8ff984f1192..a0b7dacc10cd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -640,6 +640,20 @@
>   			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH 0>;
>   		};
>   
> +		adsp_mailbox0: mailbox@10686000 {
> +			compatible = "mediatek,mt8186-adsp-mbox";
> +			#mbox-cells = <0>;
> +			reg = <0 0x10686100 0 0x1000>;
> +			interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>;
> +		};
> +
> +		adsp_mailbox1: mailbox@10687000 {
> +			compatible = "mediatek,mt8186-adsp-mbox";
> +			#mbox-cells = <0>;
> +			reg = <0 0x10687100 0 0x1000>;
> +			interrupts = <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH 0>;
> +		};
> +
>   		nor_flash: spi@11000000 {
>   			compatible = "mediatek,mt8186-nor";
>   			reg = <0 0x11000000 0 0x1000>;
