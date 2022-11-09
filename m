Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59C5622748
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKIJkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKIJko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:40:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261D8FACC;
        Wed,  9 Nov 2022 01:40:44 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B14506602905;
        Wed,  9 Nov 2022 09:40:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667986842;
        bh=5+SECJlEo7BQZC8NrHGOWqaaKAjZ2nnSt35XWUVSojo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m8CVH8yhd5O27fE9M+b+hAoSLn0wY/5h5thZ5FV8UPovCxAeZQ+5jtr6gPslB4iwx
         NtS0elb1yU0JrNGd5hdeB6yV/rMkFGDWbTgOcIExtCcrGc8HmUjrAa/KOxtbzC08u5
         z20f+G969MK/0qw7PAzfVnO0lbhUUPtW2LnnGDUPyjGNH5QPspKvYdNkXq5y/qM0yn
         +RSNRIhZDLKxQACTEZbOA5FXlELCewvDPqe0ZcFvccwqyUcPXfpPP0TQdyyf3iSPjM
         F7w91uU1YlabydGsQcuP+NsObKyEJ3UlIbbJEEIeK/v0yVE9YdIbNEi/5mJ1TMbaYP
         tYaJHd8s9hOSA==
Message-ID: <ed298a3e-25dd-af19-437c-f27c160788b3@collabora.com>
Date:   Wed, 9 Nov 2022 10:40:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 2/9] dt-bindings: rtc: mediatek: convert MT6397 rtc
 documentation
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
 <20221005-mt6357-support-v4-2-5d2bb58e6087@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221005-mt6357-support-v4-2-5d2bb58e6087@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/11/22 19:43, Alexandre Mergnat ha scritto:
> - Convert rtc/rtc-mt6397.txt to rtc/mt6397-rtc.yaml
> - Add mediatek,mt6357-rtc compatible.
> - Add maintainer
> - Remove the .txt binding file
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   Documentation/devicetree/bindings/mfd/mt6397.txt   |  2 +-
>   .../bindings/rtc/mediatek,mt6397-rtc.yaml          | 40 ++++++++++++++++++++++
>   .../devicetree/bindings/rtc/rtc-mt6397.txt         | 31 -----------------
>   3 files changed, 41 insertions(+), 32 deletions(-)
> 

Please split the txt->yaml conversion in one commit and the addition of the
new mt6357-rtc compatible in another commit.

Also, isn't the original maintainer of rtc-mt6397 supposed to be...
Tianping Fang <tianping.fang@mediatek.com> ?

You can add yourself to the list of maintainers, though, unless Tianping
explicitly says that he doesn't want to maintain this driver anymore?

Regards,
Angelo

