Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EDF6028C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJRJun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJRJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:50:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9835F1F9CF;
        Tue, 18 Oct 2022 02:50:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB3EF6602338;
        Tue, 18 Oct 2022 10:50:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666086634;
        bh=17Z7x8NyEJQfidNufMuX1DWKMuBHWGn2t5LFggJCdkE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dfeGQIdBHiAwc4rmubqnJsJHdhDu2IKbM1J5vqwC+7wl0qv99FF+W+K+KS/mDlju6
         5I82QwuM1i/L5sPMcq96hBfy/rna78EVC2ynb7LQRYVwUli6BlP+biQdf6SFVZ0lWr
         yijeNysQFjTKKONzBpCaXFzsRn+9fhM68xmKk11s+C8e2hXm9IIIqeTbBVy9yO/1R1
         /KMaiWZpq0dpgY5P14Rw3yjU8rL9k6akijG75JQn9wGr3QJZEXewuNLcb5x2d/6lGz
         NjyDL6oADEaqfdo+mFBFnXAxnMFEtG/nyIby05LiXsHpD8nhR0whLh49cIlZ0+UvI/
         +DMqiOVGI8swg==
Message-ID: <92af9496-b622-9234-d89c-d478b4c77d62@collabora.com>
Date:   Tue, 18 Oct 2022 11:50:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] dt-bingdings: mmc: Mediatek: add ICE clock
Content-Language: en-US
To:     Mengqi Zhang <mengqi.zhang@mediatek.com>,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, wenbin.mei@mediatek.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221017142007.5408-1-mengqi.zhang@mediatek.com>
 <20221017142007.5408-3-mengqi.zhang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221017142007.5408-3-mengqi.zhang@mediatek.com>
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

Il 17/10/22 16:20, Mengqi Zhang ha scritto:
> Document the binding for crypto clock of the Inline Crypto Engine
> of Mediatek SoCs.
> 
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>

Looks good, but please fix the typo in the commit title.

Regards,
Angelo

