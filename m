Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C34765B2C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjABNij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjABNig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:38:36 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62149CCC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 05:38:35 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id bp44so19825082qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 05:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:in-reply-to:references:user-agent:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUeJe0drBbTMgiYkIr+hpKI3FSwnBgCuZWCVk8bkpiQ=;
        b=sJKeU3WCdOQHKogctAuHoH1Lb5awwjpVpHefGzuQH49JgYhK41rW3ae5mHbdmBGjsY
         UnNOamQKAW85+d3DJvYxWEY0sQwr8sxKKtQaJB5/ZBhMt7NlGdpExaGUTvd1Ym8DFBJN
         z/E2hVpZRbW12fzg0X2Kj7ZDsGIcLif6Q2AhzKLokR+qFZiuaAbfbrrFr+unYfzjUdTo
         IBWE8DrMPJ7CwXxGloffvAvF0SeiBqq0lV8Vq6+n+EzQHdffJcGYNIxvZMkpsWb/VBo6
         wuXMNTIGHn3SZ4HlhcRTVEyDdo/VUZ2atZFin0VDm7biJW7nnru9XUW+S1aJ2RCzJq8Z
         kYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:in-reply-to:references:user-agent:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUeJe0drBbTMgiYkIr+hpKI3FSwnBgCuZWCVk8bkpiQ=;
        b=RsEwflfRuEjZPP/UNM/5ULf0aD8WaTCUw7Du6OPHW2tqsSkZ2UaB1Ga5gvclSNoW58
         ubM8hy9V5zJ1QGWl/XVDSZ+wVpFQr21tmGdIhVBWp5//7hqPL645TmA5lB2TvhnKs0Lr
         6opmWcy/Td6qrvxMtmbHL0y5VC45x9AqnsUG7QPZQyElCnudwqbS3rS+Jragllgh3+ld
         ZXDcrArpMfh+TH1D3IPMTreZUshiN4eqY7Gu2ZYQOHk4PceL/WtVH8D1tDUGKrzWDYvz
         aOcjkA1PtXSpK9jLXtztc79Peqbam/4WZyxBbxiJsZIq+18KBvHkjz6XaZeZb/VjnjpZ
         x+Mg==
X-Gm-Message-State: AFqh2kp7mWjUi4iDx5uxCyRrJpgAxdlUwTpuc9z9WNBXGlaQu6i4xHNT
        OoKw1ALkrDCV/VMuriHzj0BpwhyD5pZ3qw5OWjRpww==
X-Google-Smtp-Source: AMrXdXsRzYNVZ3d4bkKeYiAZTwzM9YRTxsFtaA7lSB3wLl6IBFcwrL0JOddsqmMqIzrw5hKkoMpSWmO5PrVO7+oREAw=
X-Received: by 2002:ac8:4d50:0:b0:3a8:a6e:1b4 with SMTP id x16-20020ac84d50000000b003a80a6e01b4mr1646554qtv.313.1672666714390;
 Mon, 02 Jan 2023 05:38:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jan 2023 13:38:33 +0000
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v3-0-a803f2660127@baylibre.com> <20220919-v3-2-a803f2660127@baylibre.com>
 <7da1e73a0cca6867a060d5b69d45e8d4dfc89748.camel@mediatek.com>
In-Reply-To: <7da1e73a0cca6867a060d5b69d45e8d4dfc89748.camel@mediatek.com>
MIME-Version: 1.0
Date:   Mon, 2 Jan 2023 13:38:33 +0000
Message-ID: <CABnWg9tf8Sx8S0d8mGowZ80YmZLz6cX2iyxZyKYCGbH_RKMKyA@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] dt-bindings: display: mediatek: add MT8195 hdmi bindings
To:     CK Hu <ck.hu@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        Chunfeng Yun <Chunfeng.Yun@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "rzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "koul@kernel.org" <vkoul@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "inux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Mac Shen <Mac.Shen@mediatek.com>,
        "evicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "rzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        Stuart Lee <Stuart.Lee@mediatek.com>,
        "ri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "inux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2022 06:18, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) <ck.hu@media=
tek.com> wrote:
>Hi, Guillaume:
>
>On Fri, 2022-11-04 at 15:09 +0100, Guillaume Ranquet wrote:
>> Add mt8195 SoC bindings for hdmi and hdmi-ddc
>>
>> On mt8195 the ddc i2c controller is part of the hdmi IP block and
>> thus has no
>> specific register range, power domain or interrupt, making it simpler
>> than its the legacy "mediatek,hdmi-ddc" binding.
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>>
>
>[snip]
>
>> a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-
>> hdmi-ddc.yaml
>> b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-
>> hdmi-ddc.yaml
>> new file mode 100644
>> index 000000000000..2dc273689584
>> --- /dev/null
>> +++
>> b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-
>> hdmi-ddc.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:
>> https://urldefense.com/v3/__http://devicetree.org/schemas/display/mediat=
ek/mediatek,mt8195-hdmi-ddc.yaml*__;Iw!!CTRNKA9wMg0ARbw!wwVQuq5lzW0lvUFUkVX=
PWT8cIu96xdkn4tMams1E55qyxEZmgV1i0WfpOlq57w$
>>
>> +$schema:
>> https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml=
*__;Iw!!CTRNKA9wMg0ARbw!wwVQuq5lzW0lvUFUkVXPWT8cIu96xdkn4tMams1E55qyxEZmgV1=
i0WdSGOSxzw$
>>
>> +
>> +title: Mediatek HDMI DDC for mt8195
>> +
>> +maintainers:
>> +  - CK Hu <ck.hu@mediatek.com>
>> +  - Jitao shi <jitao.shi@mediatek.com>
>> +
>> +description: |
>> +  The HDMI DDC i2c controller is used to interface with the HDMI DDC
>> pins.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt8195-hdmi-ddc
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ddc
>> +
>> +  mediatek,hdmi:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      A phandle to the mt8195 hdmi controller
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    hdmiddc0: i2c {
>> +      compatible =3D "mediatek,mt8195-hdmi-ddc";
>> +      mediatek,hdmi =3D <&hdmi0>;
>> +      clocks =3D <&clk26m>;
>> +      clock-names =3D "ddc";
>> +    };
>
>I think we should not have a virtual device. This ddc is part of
>mt8195-hdmi device, so just keep mt8195-hdmi, and let mt8195-hdmi
>driver to probe the sub driver of ddc driver.
>
>Regards,
>CK

Hi CK,

Thx for your input.
Though I would strongly prefer to keep the ddc as a separate "virtual devic=
e".

It aligns better with the goal of reusing as much code as possible
from the HDMI V1 IP,
which is something you have been advocating since V1 of this patch
quite some time ago
and has shaped this patch.

To me we are in a state that is clean and avoids branching in the hdmi
common code.
Would you reconsider and allow the use of that virtual device?

Thx,
Guillaume.

>
>> +
>> +...
>>
