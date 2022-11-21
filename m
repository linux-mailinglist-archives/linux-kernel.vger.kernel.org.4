Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903C16323E7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiKUNhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiKUNgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:36:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB01C287F;
        Mon, 21 Nov 2022 05:36:45 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A55B6602A03;
        Mon, 21 Nov 2022 13:36:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669037804;
        bh=jCj7p/2m5lxy7d9NG/YjgHLCUygY93EdQ0KK5hgNvZA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mAX2f8bUlgLnVsyJ4enAhMsz7tlnEUuGxUf25RPImr+HA5ujwyDYZOI70p0AczD7v
         aQezIl/lWk90rKclG/R4aRjhEcNc0kPu2Wtgx18+/u6tFOx+aDch7W69Xol1xgea56
         /yP3bIuRFOUv0CdorDNpMfNQqwbobWV7tP4eno/8yd4+EMgR0j8G3mlQNCrLls6q4s
         yHRJAaNsZ0oEDP7QvZsWUtArgshvknj5cLWDe1JJsl5R9raD+1459ZxJSOxZrO1Kqq
         pb9T38wq2e5WtzWOi3tetUZQmQrAGuUq+QEnPOpk5fR6YwxkBdmt0k3UGFZj2U1mnS
         rKKQcac3aIn/w==
Message-ID: <fa456fcc-5252-27e9-ebb9-afe360edabfb@collabora.com>
Date:   Mon, 21 Nov 2022 14:36:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 2/7] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Improve pinctrl subnode and property descriptions
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221118113028.145348-1-y.oudjana@protonmail.com>
 <20221118113028.145348-3-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221118113028.145348-3-y.oudjana@protonmail.com>
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

Il 18/11/22 12:30, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Change "subnodes" to "subnode" in subnode description for better grammatical
> accuracy, capitalize pinmux description, wrap all descriptions at 80 characters,
> and remove literal style indicators from descriptions that don't need their new
> lines preserved.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


