Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA09E61EF1B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiKGJdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiKGJdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:33:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1AB167FB;
        Mon,  7 Nov 2022 01:33:20 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 523C066023A6;
        Mon,  7 Nov 2022 09:33:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667813598;
        bh=Ym/ve3dGuUXNciexSXw9euMcwMya4gk/aCexVTu+KNk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NFuasTuN/NSU9Y3uOchBqk0ZQoqmWWoS6Gkn3a3g0LPmfvGjYkDt6TKK7mRdi9MBQ
         oTW5aIXxGhde7ocI/UzsR/vfIp5+NgEfst8tw+iWnxOlolFmaWZNEeJecIJmz/haA8
         NqFUiFHrlibL/C33Gt+JxlC/uQdNLSxMLjVoUKn5ESmECNUlptEyobSXlY29+c3C/y
         tqqdeHr/2zqiONg/7eyaUSi/TKs8tGUxd4eW1XVT0cNN9tDI/cPGCNVgRK5eSa4OrY
         38aYhQ9FnnnAWcXiu9IFmfettzHF3imFLYBjC7OgTTVW3SrztWZYYzCk3kl4viLTWc
         I4TYqHKOWuWdw==
Message-ID: <4b1fb965-60ec-66d6-f511-13c7f71a3a77@collabora.com>
Date:   Mon, 7 Nov 2022 10:33:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 6/6] pinctrl: mediatek: add pull_type attribute for
 mediatek MT7986 SoC
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
 <20221106080114.7426-7-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221106080114.7426-7-linux@fw-web.de>
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
> add SoC specify 'pull_type' attribute for bias configuration.
> 
> This patch add pull_type attribute to pinctrl-mt7986.c, and make
> bias_set_combo and bias_get_combo available to mediatek MT7986 SoC.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



