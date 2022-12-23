Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A89654E45
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbiLWJV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiLWJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:21:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F8D36D55;
        Fri, 23 Dec 2022 01:21:52 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 65E826602CE0;
        Fri, 23 Dec 2022 09:21:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671787309;
        bh=Mc0bWw+2ZOlU+dRs3SSvjXiOIF7bw8SFi5D1wdx3WNY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aCNeJ1hxA0hginYoSEGFRhVRO1AfFK2Qdop5YtXtV2+1aKrIt9CqGhsBiFAzQO58J
         ejzeBlWRimbpXnmUcqH/v7OZStCgQRoUL0kerseYQDzakK+fTMGs6TUCTtgGGzbTyP
         fr/BIbAcV/Qd0457Zl1PMdEm7/N2cGXMfk4XU4qewO6ipQKS3RKvCPGzE6d/goU/oi
         t/MuOHoIYAnu5R0k4e08d+oc2p3/cp45t2Cy38SnSQHoBESHJ2kVfKoJZCZ+pHgJmz
         gOFHNykoWMD2WiISo1ZTYmfr9xQ+k9sKh6wq2Ynxq2qHrsDLJakp3i9ll6t1K7XeeX
         Mt7ICtpBGORgg==
Message-ID: <960b0707-f0e5-993b-3706-a7a275e0698f@collabora.com>
Date:   Fri, 23 Dec 2022 10:21:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 08/25] dt-bindings: clock: mt8173: Add dummy clock ID
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20221222114857.120060-1-angelogioacchino.delregno@collabora.com>
 <20221222114857.120060-9-angelogioacchino.delregno@collabora.com>
 <869ae494-d74e-03a0-3622-b3a2b0b10470@linaro.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <869ae494-d74e-03a0-3622-b3a2b0b10470@linaro.org>
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

Il 23/12/22 09:52, Krzysztof Kozlowski ha scritto:
> On 22/12/2022 12:48, AngeloGioacchino Del Regno wrote:
>> Some old MediaTek clock drivers are starting the clock count (so, the
>> clock ID) from one instead of zero and this is logically incorrect,
>> as we should start from 0.
>> During a cleanup an issue emerged due to that and the cleanest and
>> shortest way to keep devicetree backwards compatibility while still
>> performing the well deserved cleanup is to add a dummy clock where
>> needed, with ID 0.
> 
> Unfortunately I do not understand at all why adding dummy (fake) ID
> cleans anything here. Unifying IDs to start from 0 is not an argument on
> DT bindings header IDs.
> 
> Best regards,
> Krzysztof
> 
> 

All clocks are in one or multiple arrays, and if we don't register ID 0,
devicetrees will reference the wrong clock, as the IDs will shift back by
one during registration.

This was done for a commonization of probe() and remove() callbacks for
MediaTek clock drivers... since we have 3 affected SoCs (MT8173, MT2701
and MT6779) out of *19* (soon 20), to me, it didn't make sense to write
commonized code to address this just because of 3 out of 20 SoCs (note
that each SoC has around 4 clock drivers).

Any suggestion to keep this one short, while not touching dt-bindings?

Regards,
Angelo
