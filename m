Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E337861EF1D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiKGJdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiKGJdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:33:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AABE2A8;
        Mon,  7 Nov 2022 01:33:21 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 98A66660283A;
        Mon,  7 Nov 2022 09:33:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667813600;
        bh=pjpsnJPpTte2rNUw4NGLZ9QJmz6SwDTTFxwPIuFAewc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ld4CCBMDDxOWCm8wV3UTICUwYhPt5dAdKICpLeRymrc0JNcQJnYkx79v6tK12U3Vh
         q/GCcstsaVj3SMcoube8WaO03bxnfSEaWRbKuTqvFGkscnkUU98BP3Qo7mAKXpb6gd
         BMmm35GqvhKwpWDUr4BX9VjJxyBRzn8t0rZhboDwdb+HIu4dOieM9RQMx3CeReRsvP
         EGa5nXZZwxH6GHg2Wh69oQfj63I4ChfD//t6OIufp+Fz5/DVM7CACB07loAfqk+zwV
         DsivdlK0dYSSZzjxi4LNKx+NU7giYsd7M15tetM1NOT4rj0UxoJbE9CSVf6v0jIwsS
         d/dqJxHVdOPEw==
Message-ID: <e5bf5a74-0578-1f57-e6d3-9a6ad67a9a5b@collabora.com>
Date:   Mon, 7 Nov 2022 10:33:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 5/6] pinctrl: mediatek: extend pinctrl-moore to support
 new bias functions
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20221106080114.7426-1-linux@fw-web.de>
 <20221106080114.7426-6-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221106080114.7426-6-linux@fw-web.de>
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

Il 06/11/22 09:01, Frank Wunderlich ha scritto:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> Commit fb34a9ae383a ("pinctrl: mediatek: support rsel feature")
> introduced SoC specify 'pull_type' attribute to mtk_pinconf_bias_set_combo
> and mtk_pinconf_bias_get_combo, and make the functions able to support
> almost all Mediatek SoCs that use pinctrl-mtk-common-v2.c.
> 
> This patch enables pinctrl_moore to support these functions.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

