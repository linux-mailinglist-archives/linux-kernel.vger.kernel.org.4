Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984865F6370
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiJFJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiJFJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:16:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B2990829;
        Thu,  6 Oct 2022 02:16:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B83B866022FA;
        Thu,  6 Oct 2022 10:16:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665047762;
        bh=px7/yU36SkCEgbO7M4kVbPVXXkLjAV+Swf+cnf7G0Qs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DA/idNxeJjNp64coH7kwR4/9NnUWjNtCMypvWCcUBi1ZJ4v8yXZJ2QjR5mTkmqhTZ
         Qqo9gysukhLeYa42t41z4VlSoypIXmSG37rO+D2x+yZmYMbzql8HrfJoelRGrINtCU
         BL39ZrzwFjpKiG2nf/QOevvih08doPitbB2w+ZUYJzoJq9p394piyNrL+o8ZTOR2Sh
         MDNzdtApUkGm4bW2teVOw5qlPknMJL8UAaLQ2HmvXmSmaNd6IKK5EHiaX2mCZZ6aVc
         KOsSJZBo5Y6OC8R2PgMofdyCwkK1ljW8x/YJ2IM12QA2BhpNeD5YPLPxsAwducKt97
         vR9sDr74NaBJg==
Message-ID: <cde0b66c-ed3f-c07b-4663-8568e2a5d6f0@collabora.com>
Date:   Thu, 6 Oct 2022 11:15:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 02/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Improve description
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
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
 <20221005174343.24240-3-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221005174343.24240-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/10/22 19:43, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> The current description mentions having to put the pin controller
> node under a syscon node, but this is not the case in the current
> MT6779 device tree. It seems that this is not actually needed, so
> replace the current description with something more generic that
> describes the use of the hardware block.
> 

s/It seems that t/T/g

...besides, you're describing the hardware, not the driver.

P.S.: Yes, I agree with the change.

Cheers,
Angelo

