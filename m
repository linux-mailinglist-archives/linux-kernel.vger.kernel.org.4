Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B676ADCC4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCGLEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCGLDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:03:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A5C746E7;
        Tue,  7 Mar 2023 03:00:37 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EDB346602081;
        Tue,  7 Mar 2023 10:58:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678186731;
        bh=Ck1cmr3V4MIdHWHjn15OPkA+GXk0Ufq03PURMw4YhVU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ev4yYdeFaLYFHUAJbWaGT+Z2UhHzNzWsXbWDGif2MYRnkCc1F+5p5xATTyov62D1Q
         eF4l8k+ZMIu6MSUP6OihpfAinKOD7BkMRAVvKhBTryn6cKxHU7nWcnTz+3YcqgbG1F
         96pA8Ogn7oh82qBRmR6w5ZKiNODdSj0+flTb1Rtvg3wwc+LMB0UE3OSrjEuZ6hVy0l
         QP0Nk0JjLqxrzgTgNHuQbMp5CmtOHCIwwlvizAQs6/jpF/O8E8B154JcwdJ9GbLXSG
         yHbWSXvNRaWEliVnorx6qoU4dw8oT/wy1hFPCKPcqUNdt59388t0+B4pvp45OEdWgW
         xfdKGeN+kvPUQ==
Message-ID: <a8116598-f4ca-5bc3-5c9c-c96d9e1c9836@collabora.com>
Date:   Tue, 7 Mar 2023 11:58:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] dt-bindings: display: mediatek: clean unnecessary item
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230306-ccorr-binding-fix-v4-0-117daea88efb@baylibre.com>
 <25019fb1-87f7-b863-48e8-a164d0e08265@collabora.com>
 <CAFGrd9qV40Re=bJY-kToAcYcv+d3nBje-zxxKcsvwfiE1a9OjQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAFGrd9qV40Re=bJY-kToAcYcv+d3nBje-zxxKcsvwfiE1a9OjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/03/23 11:50, Alexandre Mergnat ha scritto:
> Hi Angelo
> 
> Le mar. 7 mars 2023 à 11:17, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> a écrit :
>>
>> Il 07/03/23 11:07, Alexandre Mergnat ha scritto:
>>> The item which have the mediatek,mt8192-disp-ccorr as const compatible
>>> already exist above. Merge all compatibles which have the same fallback
>>> under the same item.
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>>
>> Alexandre, the Acked-by tag from Krzysztof goes *after* your S-o-b :-)
> 
> This is managed by the B4 tools.
> Also, I know this is an unsolved topic in the community, but I agree
> with people thinking the last trailer must be the guy in charge of the
> commit.

I was told so multiple times, hence my reply.

I personally do not care much where the tags are put, as long as they are
consistently put in a specific order; if I had strong opinions, I wouldn't
have given you a R-b tag preventively... so... whatever! :-)

Angelo
