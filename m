Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C818967D04B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjAZPdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAZPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:33:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E193FEC47;
        Thu, 26 Jan 2023 07:33:48 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7C93C66018E4;
        Thu, 26 Jan 2023 15:33:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674747227;
        bh=VnYSm26lDjICpca46d2eb6U+0j18mBaNjiTo5MgOy4o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=atQpLK2zMnpEBIfIlflQpObHLU42AH/Wn7iusq6aqTlmUu6cjjl0IBEV0aHmiN4Ep
         gY5FCtFYMbjCNjQO7zrslGyQO2lROC7eAcVcR3BJWrioq06mkW6g0HTQQPZ6SrzAPB
         KfYOOAMv5T01Ka+CIoHXVv7irJ80exyDOO+fx4Sub/L1DJRzD7/UcdlXLdLZ4jROBj
         SaITmcxYb7AkeqoBcUYewXXq86LcP3HulhJ9C3OjWfDFlWt1Q7a9/U+yy/EAJs3hfx
         kBlrtDH+HxXDZ97dP8m62frujitf9Q4v8Tp5SezPWGD4tPkkgY/i2iqjqNy1xdq7Wd
         XL/kC3G3gthyw==
Message-ID: <07eb3c04-c365-4ab2-7137-5fb37e4505c3@collabora.com>
Date:   Thu, 26 Jan 2023 16:33:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/6] dt-bindings: clock: mediatek,mt8186-fhctl: Support
 MT6795, MT8173/92/95
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230126085321.87267-1-angelogioacchino.delregno@collabora.com>
 <20230126085321.87267-3-angelogioacchino.delregno@collabora.com>
 <4bcf8191-fe6a-7229-9ebe-a79cebdce87e@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4bcf8191-fe6a-7229-9ebe-a79cebdce87e@linaro.org>
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

Il 26/01/23 16:32, Krzysztof Kozlowski ha scritto:
> On 26/01/2023 09:53, AngeloGioacchino Del Regno wrote:
>> MT6795, MT8173, MT8192 and MT8195 support Frequency Hopping: add the
>> compatibles for them.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> 
> ... but you already had here an ack.
> 

Honest thanks for that. I'm sorry for missing it.

Regards,
Angelo

> Best regards,
> Krzysztof
> 
> 

