Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634FF679DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjAXPhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjAXPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:37:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0124B8A4;
        Tue, 24 Jan 2023 07:37:05 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B14996602E26;
        Tue, 24 Jan 2023 15:37:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674574624;
        bh=Sbagj/2ywhL0xjl99DNt7MthmCjBe7nT34X+hJH8Tyo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CZKyUC4g7T+UGAfyRIlrIyLoXcSqP/fwCYpQtFWz1bg42bPzpM97kUFMSWxcZ0J+E
         9ERXJ3BLsVaz6hZ6LphJQdd4Fk6Ac7Yf9qizO6kQ5XPTYsljS8NIyRPsFuvLzs21zP
         c7ZTDc4tt8BCZV2+Xpvy0MkcFPjb4EbP9jFU3wl/kn8N2BQDyPVGMcUqzzcfINxa/D
         j/flgrEfGM7715+yMSQi5W9QhFTa+mNglSCpeAYd+6wcMvPkQ9wMYEBBSDY2vsf7W+
         w+2nsgFYiRZ2OSShsJvrY7XIk/hs6JpDHcKGyPH0qUNHsZSgqR4qJ4Uq6YOe8b9OtK
         DwntItrcEvNhw==
Message-ID: <80ce4ea3-6ebd-c249-45bd-a2f04343690b@collabora.com>
Date:   Tue, 24 Jan 2023 16:36:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 5/6] arm64/dts/mt8195: Add thermal zones and thermal
 nodes
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-1-bchihi@baylibre.com>
 <20230124131717.128660-6-bchihi@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230124131717.128660-6-bchihi@baylibre.com>
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

Il 24/01/23 14:17, bchihi@baylibre.com ha scritto:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add thermal zones and thermal nodes for the mt8195.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>

You should change the commit title to reflect the same syntax that you can find
in a `git log --oneline arch/arm64/boot/dts/mediatek/`.

arm64: dts: mediatek: mt8195: Add thermal zones and thermal nodes

or

arm64: dts: mt8195: Add thermal zones and thermal nodes


...otherwise:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

