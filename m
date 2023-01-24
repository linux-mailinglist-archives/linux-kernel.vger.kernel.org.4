Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8D679631
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjAXLHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjAXLHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:07:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12514A5D9;
        Tue, 24 Jan 2023 03:07:36 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 602E46602E2B;
        Tue, 24 Jan 2023 11:07:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674558454;
        bh=IZwhsbQ5GD3ihX14tcd6MNd9q9/L2zvjtRnQeYk5Sfc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=JWSPojvr5SjQwXkdAcW3tS95UTK8zskvn3EmLXFFR/Aq2SnTlA+av8pYYz6FNFs7C
         XyO6A4mKt+JE4/4TUH1eHQAuMI3lseWtKceT9V8+cmuBxJXPZ6OlvsFP5N5fsRbvGg
         BwAP0xmqlWqt/sQ3bwtlP5N+qPtgsGVJF9fPUiXefQtefePzGZqsXswDGSKUEWyRJR
         +ViXdNL6MdijVX5kNtEFK/7uL8VDc2jOZ1J8iUsh8QGnozNjvOEkusDLYeqwDwI7UX
         NTQ2mdjo9n4tR3SzpzE0v5jDresIPGmz4JLuZJ1olKilSkxZHY+hyDLfujLScNi9x7
         S3yNn4zQDAy0Q==
Message-ID: <4b959762-f33f-73b0-8b2b-930eabccca22@collabora.com>
Date:   Tue, 24 Jan 2023 12:07:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8183: drop double interrupts
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230123151634.370011-1-krzysztof.kozlowski@linaro.org>
 <20230123151634.370011-2-krzysztof.kozlowski@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230123151634.370011-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/01/23 16:16, Krzysztof Kozlowski ha scritto:
> The DTSI comes with interrupts property, so it must be removed if
> interrupts-extended are used:
> 
>    mt8183-kukui-jacuzzi-cozmo.dtb: serial@11003000: More than one condition true in oneOf schema:
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


