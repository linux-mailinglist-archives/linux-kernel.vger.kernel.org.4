Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF01714B86
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjE2OFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjE2OFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:05:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282DD11B;
        Mon, 29 May 2023 07:05:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f60e730bf2so34415355e9.1;
        Mon, 29 May 2023 07:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685369122; x=1687961122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IXsQpfygJCaGC5q2YIhqiT7SfrT6glvTqsb9kR3+tg=;
        b=sdpUq6wtbzHzS8CgQpQdkR+hrukqOa0ISmZZ3Wa4z52ZeXjPlFEu2+gBtYJyxRIfXk
         iF+hwNmP4E2q798O+VJ+qnu5RdUL3Usuqf+25mgaOmFQUjw+NrPMwOhbuzTce9yOFYmk
         5oVOjVhSdqxaUI+utRJ1ZBEkYiy4BGUvd7qqfx3be/IBhbeVTynXCun1S40CDXLHBFH2
         e6izo/1qqqx5+qMie+iSMm0zCCCqtww1FXoT76hSDofbssPi0x4a65NBF9S4iUO7kVu1
         ERVfgkpK9LeNqI4EHA0XoK2MwnVEjFUubhoUMSp4p8Zvo83+1NxGu8oAW3nTAdt3+AzQ
         EYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685369122; x=1687961122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IXsQpfygJCaGC5q2YIhqiT7SfrT6glvTqsb9kR3+tg=;
        b=MGgk2RNOM1F4iTZ/HZB9S4a1SiwkQl3x7pz42G1jWp40vHtEfmdIO1aHHecmXlMEB4
         rmgISnUv2VjNzsBB+NzIbbGsqXCKi1K/Yyh8NbvVRl/fvTpiByaNyp7alSrK+7hIV1Jl
         AJ44Jx51Aj9S9Qafv/t+DALYYv9ITnYWeWwWGnW2V9sTZuwDzW5ZiJ0W11jnJSXiE3qr
         6ceEWB2HnfiBCW+oASQFYJmvYRAYxRbc7RRUrEUtaVPO+BWLJaw9qaCnnMsJ4LmqpnXj
         IySLhVKfOrnLtq6hLFEoCImTz5mLprpRp6/LjM+8HKT1jgWe6SqlIbg2rE8mtSUsyXsB
         gAZQ==
X-Gm-Message-State: AC+VfDy/UOEJ0xSUGAmPvZpga1eDODtHz2wZuVF2fZdjiEMjA3CqvO8y
        /p0B1FJXruga+2nhaFxI3Dk=
X-Google-Smtp-Source: ACHHUZ7g9aINh4JUEKppDSWEt//njGKAVDLn3XhohW2qMJr2ADrXZo3WfUHZJbjvujUEDC7TDLkhcw==
X-Received: by 2002:a5d:42c8:0:b0:309:4e37:51ed with SMTP id t8-20020a5d42c8000000b003094e3751edmr10601139wrr.27.1685369122506;
        Mon, 29 May 2023 07:05:22 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d5489000000b0030ae6f2e696sm22893wrv.115.2023.05.29.07.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 07:05:20 -0700 (PDT)
Message-ID: <201842f6-c209-201e-35d7-e9af3ff31080@gmail.com>
Date:   Mon, 29 May 2023 16:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 02/27] dt-bindings: phy: mediatek,dsi-phy: Add compatible
 for MT6795 Helio X10
Content-Language: en-US, ca-ES, es-ES
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-3-angelogioacchino.delregno@collabora.com>
 <223fcf60-25aa-e45d-159e-6290eeeb6a55@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <223fcf60-25aa-e45d-159e-6290eeeb6a55@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/04/2023 10:22, Krzysztof Kozlowski wrote:
> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
>> Add a compatible string for MediaTek Helio X10 MT6795: this SoC uses
>> the same DSI PHY as MT8173.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Applied, thanks!
