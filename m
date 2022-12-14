Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E2E64C7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbiLNLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiLNLYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:24:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23292DE3;
        Wed, 14 Dec 2022 03:24:10 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6EF2E6602C53;
        Wed, 14 Dec 2022 11:24:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671017049;
        bh=gg6zTQZ+Wi0xiSg51eioScS2xVUBJWKGYfm1RSWHeXs=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=NDlJzGqw2QPGfMIkBrWuuFs/b98sGjVM4nIp79Sjr46FyDxgm7030BSy+pTeymoe0
         xDCPhp01Rfl2YKgBFIiVKctlmVRcMEm8Qgm1W48DZ2sWDx/xNdtYicg5unYsw2G5kW
         g0gEBizaYtTdyCSrrq1sgsQ8aCK4HAdIGWt1a0jcp3/nHFjz4J684xMXLePpQCZTAQ
         IP2afLWLhJoJ9lYYwagB/JgN08bl5WukyeriSZg/JUirsPLMRZyBbhVUapyIj1TatL
         pD0sFYGNFONmu/RZS7lggvsz5Nm7wK7OkcY8cxGAW771aClhi3eV72uimASjgubKTS
         AZ2bPE2FU5ZpQ==
Message-ID: <643621c4-5ec5-a643-d43b-825edd481d7d@collabora.com>
Date:   Wed, 14 Dec 2022 12:24:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 6/7] dt-bindings: usb: mediatek,mtk-xhci: add MT8365
 SoC bindings
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        khilman@baylibre.com
References: <20221213234346.2868828-1-bero@baylibre.com>
 <20221213234346.2868828-7-bero@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221213234346.2868828-7-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/12/22 00:43, Bernhard Rosenkränzer ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


