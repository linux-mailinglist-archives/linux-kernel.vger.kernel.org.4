Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412845F636D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiJFJQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiJFJQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:16:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF16915E8;
        Thu,  6 Oct 2022 02:16:00 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73BC66600363;
        Thu,  6 Oct 2022 10:15:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665047759;
        bh=+MGTzjoGVCjDageQ1cssG07Qv4rrwouf3eCHLH75hvw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TbwhJrBY04zdzyFGgVOzYKkabxlLxEsZfx6gMWe8Ds8bOFFnh3RmDehMvz0gwH8Xk
         ctfkzYApi3EBwHUiJyjt9oZxp/38E2mscBiteMQy0CtLCC10Nhpoy8tCnJ/D5cbCvr
         88Jd/p72/pNTL8P+mUUPO6qbKI05Jp7/KhvbOhD2ajRjJaBb3xfzvI4yAjGUlvc3Vl
         3vrex7mIC5G8VBBfs6glbIJ53XYvVfA/C7Kdu1HlubjEnC8NWz4zxJtoBOCrbQZFrB
         VCNx4z8WyriAjEpLY9/mW42ztK0mC2JcAUQUk6sY3xVGM+ohsyyCGiUBoqp1CNE8Zr
         8gZ4KrGaaNIKw==
Message-ID: <619b51a5-bfe8-fe60-f593-a363190068c1@collabora.com>
Date:   Thu, 6 Oct 2022 11:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 03/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Make gpio-ranges optional
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
 <20221005174343.24240-4-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221005174343.24240-4-y.oudjana@protonmail.com>
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
> The pin controller can function without specifying gpio-ranges. Remove
> it from required properties. Remove it for that reason and to prepare
> for adding other pin controllers which currently don't have the
> gpio-ranges property defined where they are used in DTS. This should
> allow dtbs_check to pass on those device trees.
> 

Make sure statements in your commit descriptions: "should" means that
you're not sure of what you've done.

I know that you've tested this stuff before sending and you definitely
know what you're doing here so you have all the rights to write imperative
statements in your commit descriptions.

Regards,
Angelo


