Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B3A6293AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiKOI4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiKOI4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:56:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E465C1CFD8;
        Tue, 15 Nov 2022 00:56:43 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 36C4C6602A38;
        Tue, 15 Nov 2022 08:56:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668502602;
        bh=+VHts16tHrWXts0G4ZMds8P/sCMwx8bIJBwdcBm++xA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LNgB2Qwae7QJq0WFKJaeWQNfPuFf/77mFMT6/91ZrOVzWZ6eqEs7GEJErPWKnAFRm
         +WsA5l+0nZ26LCQVEhowJW3N+1pmFedZTydSRWbXYCsGE2ZBFfT3/7mzyVXwVbcbQK
         2tskvVjC9aHSrCgCaEBplZlCahtfzswHfT4wpb2hUjN9T5mZfqeBDeKOY+3HaEwu5o
         QRSm1MBRrRp8CXhvVqQdC0xqVUiwUmqWCkY42x+frJsXYoq/yr8GaHvGChcdnjipH8
         E2CO3VVrMqL1OBFFiLJFI0PPgHY3W8+UOc0Ujf91OaqLPI5GNUI+pUhR1gk3WwleMv
         nROxWsWtmDbjQ==
Message-ID: <c17fae8e-98a8-44a2-a7df-7f45a6f24baa@collabora.com>
Date:   Tue, 15 Nov 2022 09:56:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 0/2] Convert mtk-timer to YAML
Content-Language: en-US
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220929122901.614315-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220929122901.614315-1-angelogioacchino.delregno@collabora.com>
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

Il 29/09/22 14:28, AngeloGioacchino Del Regno ha scritto:
> This is a conversion of the mediatek,mtk-timer.txt binding to schema.
> 
> While checking the schema validity, I've seen that mt7629.dtsi was
> declaring two timer interrupts while effectively there's only one:
> removing it was also necessary to be compliant with the new schema.
> 
> AngeloGioacchino Del Regno (2):
>    arm: dts: mt7629: Remove extra interrupt from timer node
>    dt-bindings: timer: mediatek: Convert to json-schema
> 
>   .../bindings/timer/mediatek,mtk-timer.txt     | 47 ----------
>   .../bindings/timer/mediatek,timer.yaml        | 86 +++++++++++++++++++
>   arch/arm/boot/dts/mt7629.dtsi                 |  3 +-
>   3 files changed, 87 insertions(+), 49 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>   create mode 100644 Documentation/devicetree/bindings/timer/mediatek,timer.yaml
> 

Gentle ping about this one...

Thanks,
Angelo
