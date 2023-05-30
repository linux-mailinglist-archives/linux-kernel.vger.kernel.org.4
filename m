Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7448E715597
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjE3GiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjE3GiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:38:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC07EC;
        Mon, 29 May 2023 23:38:16 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7541866059A8;
        Tue, 30 May 2023 07:38:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685428695;
        bh=8o4Psj+iWHmd5PzAtr5IbEWMuq+mLFzTJfPSvIhx3Ec=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B8iLBjBQLyjJgL1wG0pBTKld8L1psgnLxwm+Z9Yo0vX3mHfqv0WlvjjJjY6CHHBib
         5NcLWj9U67EAgivudDjYdM/8A894ueTFalfWpcR3l4mW1/DPPW3+jWnHW0BRmWRe5K
         HkBzMpuwsHdfLs1wDwrBRz7kfDn0gmkUcHFHE0yEsWYUg/3YJNEJn9DoRlqaY1iMGo
         NX8RlZ1MaCLzBjeimCPMqZ/CRK1/wmGB4xYw1OkyPZ8ClguLMtKoD26UrVLqVgcQIB
         bKa0EQTigwyewAY3CBx2EmgffALcTSx038nAAIP7tFsFofu5I4s0Sr2yDUrStplcV/
         gNoak5k67ACtQ==
Message-ID: <13a0ad77-539a-9c14-7a57-2893dc703a2e@collabora.com>
Date:   Tue, 30 May 2023 08:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/4] arm64: dts: mt7986: add thermal-zones
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
References: <20230529204258.65238-1-linux@fw-web.de>
 <20230529204258.65238-4-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230529204258.65238-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/05/23 22:42, Frank Wunderlich ha scritto:
> From: Daniel Golle <daniel@makrotopia.org>
> 
> Add thermal-zones to mt7986 devicetree.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


