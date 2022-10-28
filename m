Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C3610D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiJ1JZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJ1JZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:25:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA2475CC3;
        Fri, 28 Oct 2022 02:25:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F3BCB6602910;
        Fri, 28 Oct 2022 10:25:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666949106;
        bh=f6ptsnReV3a9VJBtHj0GZyQSgb/myI+fsdeM0fiT+jI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Biu+pmWwfqcoNzL/LIPjiksYzL/0MpFKje9T6GXG3CeyHZkmz7oSKFdDhP/b//v+O
         Lf3NxoMopsfcwwx2dVT177p8LEW5rQh5MIsfjzmVcsMUmM/6FkQzsnlVtGndSiOaYJ
         Lkh4J0N8w2OE8xunH8eXl20CI+LCK8YwUobFE8YMDd/Qyv6YWsVnVqxAvuORdCsSqS
         pE6QCiv5zagm8TKOiaBz3lV5WNrjV8WO82KiS6SBJZzlFDR+4BcnlayBlaz+ATAV4E
         u+8Qtg3Q43SDFLRBsbsk4m4yIJG+8+UXdAeo/Wr2EOX2hOxC9cOzVTUmVlx4T9pcBQ
         ds455YPvEUfJw==
Message-ID: <e797d832-a6b7-f153-f01e-6320216375db@collabora.com>
Date:   Fri, 28 Oct 2022 11:25:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 2/6] dt-bindings: mmc: Add support for Mediatek MT7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
References: <20221025132953.81286-1-linux@fw-web.de>
 <20221025132953.81286-3-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221025132953.81286-3-linux@fw-web.de>
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

Il 25/10/22 15:29, Frank Wunderlich ha scritto:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This commit adds dt-binding documentation of mmc for Mediatek MT7986 SoC
> Platform.
> Add SoC specific section for defining clock configuration.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


