Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B5A5BDF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiITIKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiITIJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:09:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B561F66110;
        Tue, 20 Sep 2022 01:06:10 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 721FF6601DE8;
        Tue, 20 Sep 2022 09:06:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663661169;
        bh=E4xgn82nowPPg/tY31Ni/V7rLzv4IGvHVRj9gtDO5gE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U6XrFV4nnDsjHfDBcBiGbEp2VWBpJhrMWvlYcdN4MjW9ZdHwJhV89KoyZuCw11sU2
         j8Jmo5/6YUJ0p7DHxgppLqMIPG1rkn13zSMz78XsW6uchKqgDkzaJC6gtxNa0aB11u
         0UiM4M1rYN1hx3AxyGfC/vHKxjzPXDz4sWFJKdl0VkLFTOz1t2ttgQu4MXWmAoH/4f
         LlM1c63DwXyHjQkW5jIUQJDbNL/M6xJDyovgq/X1GqXvFWfQ4Ds/n33LEmC/t1CQ1t
         aq2ARKq6odfL9zI5pSELMQsl266YfeZsHzj4MntQbH2t1nYo+Y5m9F1izclwibi/iD
         7cByLZ5eyhMOQ==
Message-ID: <4c425cf8-f9ca-969c-f8ed-688410bfb922@collabora.com>
Date:   Tue, 20 Sep 2022 10:06:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: Combine MediaTek MT67xx pinctrl
 binding docs
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220919170115.94873-1-y.oudjana@protonmail.com>
 <20220919170115.94873-2-y.oudjana@protonmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220919170115.94873-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/09/22 19:01, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Documents for MT6779, MT6795 and MT6797 that currently exist share
> most properties, and each one has slightly differently worded
> descriptions for those properties. Combine all three documents into
> one common document for all MT67xx SoC pin controllers, picking a few
> parts from each and accounting for differences such as items in reg
> and reg-names properties. Also document the MT6765 pin controller
> which currently has a driver but no DT binding documentation. It should
> be possible to also include bindings for MT8183 and MT8188, but these
> have some additional properties that might complicate things a bit,
> so they are left alone for now.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 207 ------------------
>   .../pinctrl/mediatek,mt6797-pinctrl.yaml      | 176 ---------------
>   ...6795.yaml => mediatek,mt67xx-pinctrl.yaml} | 181 +++++++++++----

Hello Yassine,
nice cleanup over here!

There's a catch though: as far as I know, wildcards are not permitted... so you
should, at this point, merge all of these in mediatek,mt6779-pinctrl.yaml instead.

Before jumping to that, though... Krzysztof, can you please confirm (or deny)?

Regards,
Angelo

>   MAINTAINERS                                   |   2 +-
>   4 files changed, 135 insertions(+), 431 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
>   delete mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6797-pinctrl.yaml
>   rename Documentation/devicetree/bindings/pinctrl/{mediatek,pinctrl-mt6795.yaml => mediatek,mt67xx-pinctrl.yaml} (65%)
> 

