Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584F4677721
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjAWJMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjAWJMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:12:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25C11E2AE;
        Mon, 23 Jan 2023 01:12:07 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4234E6600358;
        Mon, 23 Jan 2023 09:12:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674465126;
        bh=8/6ZDQ9b4fX0xEojF/wx773LxZk9VDCnx1/KSD58SV8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BfzX3ZJ6gNIBCXFzE9tnQdQdm46ubsrLxFNmtoGfvbqplMseFjBcl9yCyvJIANxrg
         3DYA9ZD8TW0/7G5BEufZmH5vclcYaQR5m42TS/rkBxbleBoarUdht44x2xHBKUtbHU
         tvhL+ksDzgv11dr/PSjdUWvZ/dCtzDWGUWm7wbc2jJuUX+s41ougSLwHiPFXoIqO9Q
         IU/emSIpyqKe2poS4ij7nRYYfHlFikJWukhLAa+R/lk7GnEU9tQUGKpnYwD528DWEH
         FPAbZKdErP9PeH+CtJqmoeg2H6JBocJGIhdwJFwCWjmoFFef2jnpiDZ/65OzMTbSH4
         wTY9z85sGarBw==
Message-ID: <d19f5c48-f1a8-a235-c6e0-db1e10644159@collabora.com>
Date:   Mon, 23 Jan 2023 10:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 1/3] dt-bindings: clock: Add apmixedsys/topckgen
 compatibles for MT7981
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
References: <cover.1674401764.git.daniel@makrotopia.org>
 <ae9acd210c1566b4bd72b09df4430bcad4a36c9b.1674401764.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ae9acd210c1566b4bd72b09df4430bcad4a36c9b.1674401764.git.daniel@makrotopia.org>
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

Il 22/01/23 16:42, Daniel Golle ha scritto:
> Add compatible string for MT7981 to existing bindings
> at mediatek,apmixedsys.yaml and mediatek,topckgen.yaml.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


