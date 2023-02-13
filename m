Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10196949E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjBMPC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjBMPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:02:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C781DBA7;
        Mon, 13 Feb 2023 07:02:21 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EE97266020A2;
        Mon, 13 Feb 2023 15:01:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676300520;
        bh=+w0aem4WAGne/rGW4BjKK8/fKzHBZe5eP0S7UQQNzX8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hbLORnwlQTtd/bxhJhZNFax8lKY9gQXhKl+/fIWw5wGgB9bCvbkZENT8IZgbywbz0
         7U3d9t3GKBzKpM39j5p6Hm4wbuoKIuDN+na16zhF6nlmD9ETiGQimhWElYGOdda9/S
         kLfgf4RfamxXTSh6FiFGex559lD1CmyQaEJ/SlmrCAv4DtiAB0jRTDltIV2229JT8L
         nfomkJ5nFAe+OMY3b0nzvVJSMSzIWKcONbxmkMLzbrN0Ct+JBxwF0n4DX3WL9a4jAj
         KUTlc4+Rbu7VFn74LiR7ilY9TNcLLuo2biUnXzGTz34wnZXYjfqZTUVp6/DvbLFSh4
         Zfv60OCSYye/w==
Message-ID: <6bf297ce-43f0-d8e6-a99c-0b92afe43dd7@collabora.com>
Date:   Mon, 13 Feb 2023 16:01:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v7 3/3] phy: mediatek: add support for phy-mtk-hdmi-mt8195
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mac.shen@mediatek.com, stuart.lee@mediatek.com
References: <20220919-v7-0-b5b58c5ccc07@baylibre.com>
 <20220919-v7-3-b5b58c5ccc07@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220919-v7-3-b5b58c5ccc07@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/02/23 12:33, Guillaume Ranquet ha scritto:
> Add support for the mediatek hdmi phy on MT8195 SoC
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


