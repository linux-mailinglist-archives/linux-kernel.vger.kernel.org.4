Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BDC6DD579
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjDKI3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDKI3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:29:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96F09B;
        Tue, 11 Apr 2023 01:29:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0687866003AD;
        Tue, 11 Apr 2023 09:29:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681201772;
        bh=bPE3j4UAbUHCaDfr9qUZkcXD11zOLf1fT0sAoWVI/qY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Obp2BOCGT4IjC0VxutC9LsF+F1BUIk4hjWxDEwIifj+k8UkjL9lBBntJGhKEwQV2Q
         9ZFtUfubR7dr86ocHI6T6TTiTC7wgbFqY2ORJQZhMZqZVSk1RYGl/7zs3sThlb8bNG
         /aGZp4sviidyaMaWrESzyrdN2i9DnJd5XdT9HWXw2TtKV3w/0KCnvNelnzpMhsHIvh
         Uvc5HjUIDiQiqo3ZIOlvEzjMhlCdGTQWwgW76L00vcndYs6JzRWIKFaMgFTVlYyR88
         XW/UfbIk/3/mRV2D6vxV8XgJud6bH1ujCp+Be1wRQPkDOma1k10qV7xKaxLUUSUUDM
         Yv0unvkvqqITQ==
Message-ID: <be19f8d0-2a66-caf9-a505-772aecf3a62b@collabora.com>
Date:   Tue, 11 Apr 2023 10:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/3] dt-bindings: memory-controllers:
 mediatek,smi-common: add mt8365
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20230407-smi-driver-v2-0-8da6683cdb5c@baylibre.com>
 <20230407-smi-driver-v2-2-8da6683cdb5c@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230407-smi-driver-v2-2-8da6683cdb5c@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/04/23 11:13, Alexandre Mergnat ha scritto:
> Add binding description for mediatek,mt8365-smi-common
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...but the bindings commits should come before the driver commits.
