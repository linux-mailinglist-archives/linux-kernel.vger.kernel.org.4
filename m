Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485706B257D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCINdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCINcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:32:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5CE497CF;
        Thu,  9 Mar 2023 05:32:36 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B410966003B1;
        Thu,  9 Mar 2023 13:32:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678368754;
        bh=l6DDXlsauhhCbZ03pxW3WllL2mKUtfCwuScLJaPHbmg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CSyCOrq6eVhdVmFXNTdk5rks0+qlq9FmhN7fCP9CEXVXYdA5QZjqfONgQoNBzXXKP
         fdvwDLmthZCB1ziMgoj4lfEWVZ/Cx/IdsO9JKN125Czii2vVjk/XMC0tZC08lp4NO0
         tFhS4I/0uCZ4JzvrGf+3msofJigSGHbN6+NnSEnNmxozzKqYj2PMOLOrHMP04BSwXt
         QelUiu6H+Q+ophgeiataSOaelGWsdsLWErIqBGYzAH6aido3XrmNVJ+CMa3R7jTDyz
         5Wn8GKPgJDtBckS0dA8b5zm/GFQIEpL290gpXkW/E/DI8TWilOMqs4cJ6AeUBza5Rw
         SMX8c0Ijh1a+A==
Message-ID: <0fb37a8f-f284-76f2-e2f3-ff0f23eaa200@collabora.com>
Date:   Thu, 9 Mar 2023 14:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 17/18] arm64: dts: mediatek: fix systimer properties
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mmc@vger.kernel.org, Alexandre Bailon <abailon@baylibre.com>,
        devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
References: <20230203-evk-board-support-v2-0-6ec7cdb10ccf@baylibre.com>
 <20230203-evk-board-support-v2-17-6ec7cdb10ccf@baylibre.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230203-evk-board-support-v2-17-6ec7cdb10ccf@baylibre.com>
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

Il 07/03/23 14:17, Alexandre Mergnat ha scritto:
> From: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> 
> MT8365 has a SYST timer (System Timer), therefore the compatible node
> should be "mediatek,mt6765-timer" instead of "mediatek,mt6795-systimer"
> (which corresponds to ARM/ARM64 System Timer).

So this is not a CPUXGPT, not a GPT, but a SYST?

At this point, this should not be even introduced because commit [1] is
not in linux-next yet.

[1]: https://lore.kernel.org/all/20230125143503.1015424-10-bero@baylibre.com/

Matthias, please take note...

Regards,
Angelo

