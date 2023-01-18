Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F402671D60
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjARNQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjARNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:16:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9B97A539;
        Wed, 18 Jan 2023 04:40:58 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F277E6602E0C;
        Wed, 18 Jan 2023 12:40:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674045657;
        bh=Q8iWargvHqJPqAQEN22KOji42+H6hFh4x33zjT3bNmk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d1l1KWQgSEfLpj6MFQZn6l+PeBZeFdXyEEUuMzki5yZdaI2Et2hXu37iCSkQ0/c3o
         eS0WPYhQ81SuX2ZZqWgbhxgrKyCVE7EdjGrR/HqVDIStdWh0rd5nvT76SxCjgKXpa1
         N6ckbLnPYcwM7Ml7RLjYorNT5FLm40r4kqOlOSADz9UytaZoyU1UZJ3dJf23ReJD3C
         7uwSYTU88gbE1ph+MVygrbvgH7dxU6L48UZ+4vqjsPMlyq7memqkmRM6sGbBNw7AbO
         986M6e2YT0G9CNc+NZ7dcmucL8iHuoM/Px5TMco2K40Ci03ZxZoy0+VgudEYCG2MXf
         n8EUjlx+ld/pA==
Message-ID: <640ba00d-8c04-0e24-75b4-7a997cb7780a@collabora.com>
Date:   Wed, 18 Jan 2023 13:40:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 4/9] arm64: dts: mediatek: mt8186: Add ADSP mailbox
 nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel@lists.freedesktop.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20230118091829.755-1-allen-kh.cheng@mediatek.com>
 <20230118091829.755-5-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230118091829.755-5-allen-kh.cheng@mediatek.com>
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

Il 18/01/23 10:18, Allen-KH Cheng ha scritto:
> Add ADSP mailbox node for MT8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


