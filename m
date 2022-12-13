Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E699064B42B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiLML0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbiLMLZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:25:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA991D662;
        Tue, 13 Dec 2022 03:25:19 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE3A2660036A;
        Tue, 13 Dec 2022 11:25:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670930718;
        bh=jGEJaC2HHzi3pPy3yaMxUlfwN0oxrlQhb5r/NizcXZo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nO0m+xHZBDmaCWKxPnPPm9BOanyUTdwPiXhZ6stPQ2SjHsiGPoA1YGpY2HMeio5qQ
         119yMkqN0eMSgwqPQu+G7DNPNkzu96nipC/xXUdpoAgpgAHTcXQr2hvRdSe1Eey7qh
         vJbdMjguGdLWlvtpR392ftEErTIRzrGNbsGbroCaEwr56Y/XTMTXvfvLvI4VZN/jn2
         +16ucP6YtMQnjeVZdqb7cToIS7RPrRSj/6aPncm2sflcCdCz6fNlSXRC1hr+NsPSdX
         MAQobd3w1silOk2ka/doS0pLzSDsR+gM8Z02XEXwIjfnD2kuTPuydJDKu9W5Ksa6V/
         S85bU55zdrogA==
Message-ID: <4e73921f-c8c1-7943-72a7-a95b20a68bbf@collabora.com>
Date:   Tue, 13 Dec 2022 12:25:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: mt8192: Fix systimer 13 MHz
 clock description
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
References: <20221201084229.3464449-1-wenst@chromium.org>
 <20221201084229.3464449-3-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221201084229.3464449-3-wenst@chromium.org>
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

Il 01/12/22 09:42, Chen-Yu Tsai ha scritto:
> The systimer block derives its 13 MHz clock by dividing the main 26 MHz
> oscillator clock by 2 internally, not through the TOPCKGEN clock
> controller.
> 
> On the MT8192 this divider is fixed to /2 and is not configurable.
> 
> Making the systimer block take the 26 MHz clock directly requires
> changing the implementations. As an ABI compatible fix, change the
> input clock of the systimer block a fixed factor divide-by-2 clock
> that takes the 26 MHz oscillator as its input.
> 
> Fixes: 48489980e27e ("arm64: dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

