Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3C26DD57B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjDKI37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjDKI3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:29:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF8B3C24;
        Tue, 11 Apr 2023 01:29:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 289A366031E2;
        Tue, 11 Apr 2023 09:29:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681201779;
        bh=Ma2v3EyMsGkOmwNVpAiayuKQ7gD6/5OgGM3RlenFbQ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j7Fp0Vl4eeBCo7tuhT5NhwmGW0UPnULoNJPS6wK/5ow8+VVW528ehX3678+8ZSWEw
         WIz18+faOuBxT80h3hi3RHEmPEcHgjbqK5EAXEeMCIGqpZ1BCwxj0kUFcMQfgMsIiK
         D3meYwqQoC7tUlcX+PsM8LqbvTCJGNJ9NnbajrkAmc89EgXU44rI4L7D4Kw7MhqYXv
         bSlZxB+SRXmL0K5uNJZKhqJpCW+9lDrv0tQZmyw7z8x069vmNJ7CLkm9mnMlIKHObk
         fnj3SJA+5D1ylkCGIXUtJYnUd8xqo5K8ssRJUTHgYwBxYMmnbMTQX7PFzcw8INVGGj
         fObUgexo41wNQ==
Message-ID: <da270d1e-5c92-b8a8-7d85-e633c43809e7@collabora.com>
Date:   Tue, 11 Apr 2023 10:29:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 3/3] dt-bindings: memory-controllers:
 mediatek,smi-larb: add mt8365
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20230407-smi-driver-v2-0-8da6683cdb5c@baylibre.com>
 <20230407-smi-driver-v2-3-8da6683cdb5c@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230407-smi-driver-v2-3-8da6683cdb5c@baylibre.com>
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
> Add binding description for mediatek,mt8365-smi-larb
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...but the bindings commits should come before the driver commits.


