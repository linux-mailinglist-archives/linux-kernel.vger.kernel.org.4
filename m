Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8E680C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbjA3Lir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjA3Lin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:38:43 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9902CC42;
        Mon, 30 Jan 2023 03:38:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q8so7757786wmo.5;
        Mon, 30 Jan 2023 03:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T8FHcl8FQ7LWPsHGvishUG9eXa2hE3G0FJT29OwvLWE=;
        b=dQObpp8mkgw/42GS/NWrS1KwKrtRCNvP2/fPxxIxLSF/hT7TAgV3UJkSyMtA30zsLe
         XoUcFq7r80b4ooaQm1vxsrQNkLPa/vt0gd+g4d1GKY8WL2b9OmKDKDNX9cbExq971M8a
         +ns184Q+LtV4AFmjvgoCTv1tx35k5mLvHzG1nTvScKzLeKxS8jTcRfWVFJ6MeUlwiO1G
         M48j8JmIwT8Mo4l+4RkLwJi/uM8AaOfsh3RZvOzaWnuzt3gHlZNSUDd8NG3xeJpXsWVV
         hF3D7wDuV9Xu2PwTtg3BpqR7oMgEzGYoeaUHdonZ9300YzdgRwL05QjnK0FWu6leMQKd
         vEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8FHcl8FQ7LWPsHGvishUG9eXa2hE3G0FJT29OwvLWE=;
        b=yXjvmQzYnDsejSw5vNxtC+qyKTkgjvJ/UfhM6AOTaqDTlFMxcd1fv2xwSyylSNRYct
         FNZu1VQ3KG1f0HptBUProKMHpx6vAojfqYfAsDYgrFSAo366T6HDMZJ2h0ALonknyof1
         5YNyRpicG3Vk9ioGkAfkKD+7/oa9ImM2H+AePE/MuqV5iaW4VDl8jPJWjLmiT8vcBWjJ
         IKVSv2QbHHi/ci+62pGTjncbx2EfpIewWYEPPTNR1YgcyKMq9vIIem8X5ogRFj20IsWh
         JfS5WcPngO96N9xmI+8iu/Vu0kX7qHa7aT3s1gaXpdsbFm1MriBE96asR8U69cAuBSeZ
         K1kA==
X-Gm-Message-State: AO0yUKW1ePmrjrA4zFNNULRT1wB6/qPHO14nQ6Z2mp+QPVw27BJvx+2l
        xtOUDyDWm/w3yQyhH9FkWCk=
X-Google-Smtp-Source: AK7set9SBbhpGl1UMgZ6IK9FggJEYs30pNmfKdhBsS3neeguVhniJ62uvheSsRHchaEktAYjlQHmBw==
X-Received: by 2002:a7b:c38a:0:b0:3da:2ba4:b97 with SMTP id s10-20020a7bc38a000000b003da2ba40b97mr4480397wmj.19.1675078720531;
        Mon, 30 Jan 2023 03:38:40 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b003cffd3c3d6csm12228110wmo.12.2023.01.30.03.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:38:39 -0800 (PST)
Message-ID: <0dec66ce-424c-e682-3f73-594e5b1edb65@gmail.com>
Date:   Mon, 30 Jan 2023 12:38:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 8/9] dt-bindings: serial: mediatek,uart: add MT8365
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        chunfeng.yun@mediatek.com, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230125143503.1015424-1-bero@baylibre.com>
 <20230125143503.1015424-9-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230125143503.1015424-9-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/01/2023 15:35, Bernhard Rosenkränzer wrote:
> Add binding description for mediatek,mt8365-uart
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Greg will you take 5,6 and 8 from this series through your branch or are you Ok 
if I take them. They are all just adding a new compatible string to the 
following files:
Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
and
Documentation/devicetree/bindings/serial/mediatek,uart.yaml

Best regards,
Matthias

> ---
>   Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> index fe098d98af6ee..303d02ca4e1ba 100644
> --- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> @@ -45,6 +45,7 @@ properties:
>                 - mediatek,mt8188-uart
>                 - mediatek,mt8192-uart
>                 - mediatek,mt8195-uart
> +              - mediatek,mt8365-uart
>                 - mediatek,mt8516-uart
>             - const: mediatek,mt6577-uart
>   
