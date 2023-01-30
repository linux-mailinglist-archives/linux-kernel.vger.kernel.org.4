Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF0C6807CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbjA3Isq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjA3Isn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:48:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314AA15C93;
        Mon, 30 Jan 2023 00:48:07 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 23F046602DE5;
        Mon, 30 Jan 2023 08:48:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675068485;
        bh=MAOqAEBgvD2S1zgCqv5KXxmSTBg+M7tmyplC/Cf1sGw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NP7QWvQxoOQkrIo0DZJ7Sg5w18iN59deoI2jBB/vL01Xn5gvIqHvsxacTRznFwI7p
         74eAziL8fL9go2YFlVeRHH4aGgB4WEUVgrG1MixdfKXL9FSna3M/+Mm7kTGrcGKsqJ
         picheY74gSByXoBTbnYRemseiYKHl2ue//HRKBUZ4mZJn9bNezv3pEix1Ynq+X1iEA
         Zc5K1d1h2Msjb+TlKf6JqPn1YAGHJ3UQIXIEGLq3kCvU4+whIoSp4umC/0WCI29ZqM
         Yu0nkBbQWVgqNdop+3gEzuidFoQAb0QTscsKmao4AyTH8SNPJ8aLeZSg8RJGPSocwW
         O5vdsodF0039Q==
Message-ID: <136a6c96-6bff-8860-c2e9-5e484c75867a@collabora.com>
Date:   Mon, 30 Jan 2023 09:48:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 00/23] MediaTek clocks cleanups and improvements
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        devicetree@vger.kernel.org, fparent@baylibre.com,
        ikjn@chromium.org, johnson.wang@mediatek.com,
        jose.exposito89@gmail.com, kernel@collabora.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, msp@baylibre.com, mturquette@baylibre.com,
        nfraprado@collabora.com, pablo.sun@mediatek.com,
        rex-bc.chen@mediatek.com, robh+dt@kernel.org, ryder.lee@kernel.org,
        sam.shih@mediatek.com, sboyd@kernel.org, weiyi.lu@mediatek.com,
        wenst@chromium.org, y.oudjana@protonmail.com,
        yangyingliang@huawei.com, Mingming.Su@mediatek.com
References: <20230113110616.111001-1-angelogioacchino.delregno@collabora.com>
 <20230130065141.2117-1-miles.chen@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230130065141.2117-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/01/23 07:51, Miles Chen ha scritto:
> Mingming has tested this series on mt2712.
> 
> Tested-by: Mingming Su <mingming.su@mediatek.com>
> 

Thanks everyone! :-)

Cheers,
Angelo
