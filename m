Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7709D72FCAA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbjFNLhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244225AbjFNLhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:37:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011472111;
        Wed, 14 Jun 2023 04:37:11 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 20F646606F13;
        Wed, 14 Jun 2023 12:37:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686742630;
        bh=LXwMmgzZtnno9j0XYiWzdlIdHSY+v7M4PCMri8vKoV8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JTZoPgyF2EqrgGRxzx9QgER26AQfmj2aiAMowHZbwiPsM0kzpdrScs1HNMSbzRq1N
         +wYPOzvBRUPLv3QgoTX+WCl0LTTXQCwlFMTs+/MFgQFmGQxfUg3zhAviVL7gO/L+Pc
         IDvm2ns6aL3oXZAv861SBYx7ea5ihkEJ83QHP2pXb1FG/za+uu4q75DzBU0A45REau
         i9JCo98GGkEw+PPlyXJCvTiNnz4AIKJ+ze6FARV7GSKkNOatJZ175I23kSX8XA473z
         5PQumPjPX94fZFDhjkOMmRAc0V2yDZ5DGpwAMUY8CROqERpL7vR5Xjwh1tL9l8Gu/V
         YkR8JXXT/zKag==
Message-ID: <c844c6c3-5f04-d6bb-d801-a8c63244bcab@collabora.com>
Date:   Wed, 14 Jun 2023 13:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 13/15] drm/mediatek: Support MT8188 VDOSYS1 in display
 driver
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-14-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230614073125.17958-14-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/06/23 09:31, Hsiao Chien Sung ha scritto:
> - The mmsys_dev_num in MT8188 VDOSYS0 was set to 1 since
>    VDOSYS1 was not available before. Increase it to support
>    VDOSYS1 in display driver.
> - Add compatible name for MT8188 VDOSYS1
>    (shares the same driver data with MT8195 VDOSYS1)
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reusing data/code. Just great.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


