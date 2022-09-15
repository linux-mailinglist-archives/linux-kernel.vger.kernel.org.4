Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963AD5B98B5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIOKZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiIOKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:25:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF1D4362C;
        Thu, 15 Sep 2022 03:24:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E86936600371;
        Thu, 15 Sep 2022 11:24:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663237495;
        bh=dzvyAv7u5rz3DlDYP4mS/XsMlrYVI4W8bUZSZ8822rI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IogmJYyCu2reXph7llyGnbDKO2WatCn1H95lf84LDss+/omDaeEbVELjcngQZr7mq
         9j14Dd2VhkvL1L9lGzDma2t3eIn0p6ImRd5yval+7QWdUCDn/DTJSDrapMwQoH8/l7
         WS6ydCweXMxbjoMtI5tAU/JjAR3fPVR/qmX9Ak67jhZZd1ig0v62mnYonis8c2ioL2
         kLZbEP7CZLYCAGKyCaG2B/bNg1zOMA/U+1vsAmA48DE622+Z+SeYQn+1LiUgC8/Usz
         U1kCtthnJIB6VdSK+o3P2kzGfimr1t1OlhY0AiLfPTF4yEG9uJvcXS5uvUKT/78xR2
         QLJ8JxVe4JkFQ==
Message-ID: <7498e2dd-1d5e-78ae-54b9-4d5dd9bc7ce1@collabora.com>
Date:   Thu, 15 Sep 2022 12:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/4] arm64: dts: mt8195: Add edptx and dptx nodes
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220915094640.5571-1-rex-bc.chen@mediatek.com>
 <20220915094640.5571-3-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915094640.5571-3-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/22 11:46, Bo-Chen Chen ha scritto:
> In MT8195, we use edptx as the internal display interface and use
> dptx as the external display interface. Therefore, we need to add
> these nodes to support the internal display and the external display.
> 
> - Add dp calibration data in the efuse node.
> - Add edptx and dptx nodes for MT8195.
> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


