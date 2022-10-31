Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDFD61372C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiJaM6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJaM6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:58:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E69E0BE;
        Mon, 31 Oct 2022 05:58:46 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9852D6602387;
        Mon, 31 Oct 2022 12:58:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667221125;
        bh=BeO+oKNCameH1zwWU+wvsYFCN/BzRO3hzCcri9HM8Ts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UyCAja/GRKvLpVKSbz7anu0DQ+8wfifs86/5lOQgb/e0PNtobNTqmWJn0yZ2ZpWmb
         Ydy+npxCpco9Vg5RxZBiLe8obCwipmCEN0WF9K0Q04IFCkbSvu7cSl7F7uqpZMQdEE
         eWWr4fbXAAjhkGNIciwGGrXYnRymzMcOzip0zqVxhQWqiB4c/0ivI0Yy8owLatja68
         VZ8ZDGBves4YliS4lJ1RWfKEZikmKZysMoornAAPba44vbL7qxIKSZvRvcwQk8Ueta
         SfoANlKgBQR6102N9tPyTPu7qijUx0UESyby8qSEbdCzDGHbqhfC92JDBJuDvjbC/L
         fB7ysKlhc3rhg==
Message-ID: <270b6269-0d5d-752a-c59f-44a7d28baae7@collabora.com>
Date:   Mon, 31 Oct 2022 13:58:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 1/3] dt-bindings: soc: mediatek: pwrap: add MT8365 SoC
 bindings
Content-Language: en-US
To:     fchiby@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong . Tao" <zhiyong.tao@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221031093401.22916-1-fchiby@baylibre.com>
 <20221031093401.22916-2-fchiby@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221031093401.22916-2-fchiby@baylibre.com>
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

Il 31/10/22 10:33, fchiby@baylibre.com ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add pwrap binding documentation for
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Fadwa CHIBY <fchiby@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


