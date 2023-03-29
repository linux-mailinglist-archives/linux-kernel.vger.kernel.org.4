Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CF86CDAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjC2NcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjC2NcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:32:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DD7422C;
        Wed, 29 Mar 2023 06:32:01 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E4626602EDC;
        Wed, 29 Mar 2023 14:31:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680096720;
        bh=Pib6qE5F4Lg5qFO9xEESVqnMdlCKI+dvN/qGSBLYOKk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kjYvSga7RY2S3by22nBTNlGCuhkRVhlXXJNedHVKkcqpVDD2ymQdEVy6yUIoMZuQ3
         LkXkrTJPaTEavy37Mnq/RW9Cs8bNRwJiQ6AbvjqWoYg2HfoKxnFcNsDeZi7Nio15s/
         3lgrrL5XACVWK/93tDg2dvtonoxOORzNUQKf2VMHMyhKFzcaDUHQNL9grjQVKTCekV
         X+Hy45SK4ISpIbNLejEAAuFFSUgTDpWg9YjjA04+WEnB0xwDl+Uztjv6ZytxnR5adP
         83/EsfBUKs7oGEjcSRXbkPVQUL/yIL6oQA2Y6NrNBIdhfpxZY8HuA8laD4y2gg561u
         WscoqlSJ+58/w==
Message-ID: <8c1f5991-e220-95b7-c605-03d3c3442c21@collabora.com>
Date:   Wed, 29 Mar 2023 15:31:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 17/17] arm64: dts: mediatek: Add CPU Idle support
Content-Language: en-US
To:     amergnat@baylibre.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-17-0003e80e0095@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230203-evk-board-support-v3-17-0003e80e0095@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/03/23 10:54, amergnat@baylibre.com ha scritto:
> From: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> 
> MT8365 has 3 CPU Idle states:
> - MCDI_CPU. (Multi-Core-Deep-Idle)
> - MCDI_CLUSTER.
> - DPIDLE. (Deep-Idle)
> 
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

