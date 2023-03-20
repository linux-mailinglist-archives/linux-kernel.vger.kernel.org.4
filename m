Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF386C1657
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjCTPEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjCTPES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:04:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F8F2A144;
        Mon, 20 Mar 2023 08:00:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CF766660212C;
        Mon, 20 Mar 2023 15:00:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679324411;
        bh=69r7ZJ7lFz8tBgGhwZoAQpSTq3WnA5tKdeH7p99cqsg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FXf6S4YEmmMAIySgVsoRQJfX1gpJGGnOTA1pmvDKiMkygZcbGxRYV8B2kkwoGMO1P
         UEoyuLFZYh16TQ0EDqps/0OaHYp0ZPC25L8JrF0/y0HQXSf3JLYigFpLzNqx28Dfy8
         yIYd2oyKoyYNPeCNzEmu4ZzEZjAbpfxHg0Rab2X1yTH2TvbWMUzFQgD4BJ4joSQuBs
         9TWNRYBHurfikKt3tjxT/FRZukfXP8pMD0WxRiYFPtZuUtnbARWzqAyrpoeC7I6KsB
         GQFN+Mwi/45P47Suv4Mh3B/vKsl2M9bneGds8zAFi1CECZTyc0jW4n1ilBcUbbCBIV
         NIgIlTI2irtbw==
Message-ID: <1d0c0e49-4f50-7fc8-d514-b19cf4054066@collabora.com>
Date:   Mon, 20 Mar 2023 16:00:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 20/21] dt-bindings: pinctrl: mediatek: mt7620: split
 binding
Content-Language: en-US
To:     arinc9.unal@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Rob Herring <robh@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
 <20230317213011.13656-21-arinc.unal@arinc9.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230317213011.13656-21-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/03/23 22:30, arinc9.unal@gmail.com ha scritto:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The MT7628 and MT7688 SoCs contain different pin muxing information,
> therefore, should be split. This can be done now that there are compatible
> strings to distinguish them from other SoCs.
> 
> Split the schema out to mediatek,mt76x8-pinctrl.yaml.
> 
> Remove mediatek,mt76x8-pinctrl from mt7620.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../pinctrl/mediatek,mt7620-pinctrl.yaml      | 379 +--------------
>   .../pinctrl/mediatek,mt76x8-pinctrl.yaml      | 450 ++++++++++++++++++

AFAIK, wildcards aren't allowed, so the new file should instead be called
"mediatek,mt7628-pinctrl.yaml", the compatible string "ralink,mt76x8-pinctrl"
should be deprecated (but still present as to not break ABI), and the driver
updated to accept the compatible string "ralink,mt7628-pinctrl".

At that point, you could update the devicetrees as well: for MT7628, you'd
have a node using

compatible = "ralink,mt7628-pinctrl";

while for MT7688, you'd have

compatible = "ralink,mt7688-pinctrl", "ralink,mt7628-pinctrl";

If you don't want to go through those lengths, you could still do the
cleanup that you wanted to perform, but with a filename containing no
wildcards - anyway.

Regards,
Angelo

