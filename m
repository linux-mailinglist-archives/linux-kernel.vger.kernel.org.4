Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF105F62D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJFIga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiJFIg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:36:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3368695E6A;
        Thu,  6 Oct 2022 01:36:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6220E660226D;
        Thu,  6 Oct 2022 09:36:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665045380;
        bh=wFoOAN7bFW7ZcEUlEyrquYeMDkaLoO1zFNmCBqZXDyE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=momluOxPJp6aehDMfKrO28U93jCgFg9oTviy7NW67owqYTPG4f0TkFEupHLBgRC88
         k2W81OkStlQz7uoLtA5s6btCHdRqP6S3AX5PV7nC75yx4plhMfRTB0nCCE8l2dpWL0
         TtOKECUYee50s+C/6dGykHim1Ja96+N4BsyOimlx3eUYe+HfJqI3hiPgzHFhD2kCVx
         MD/W25E6ru32yDnbQZez5rUHISK6ab6OjIeslrRu5dMETwe96zK7+30CPfk04DKcz1
         /kaB1AW13g865R7QugWoz5WMb44P0I7d7Br6RPPq6lz5BY0+N1x5qh02OUm9c/QrbK
         BBPmjoMgb8/TA==
Message-ID: <56aadffa-82be-f8ff-03d3-2a880b50ef49@collabora.com>
Date:   Thu, 6 Oct 2022 10:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        wim@linux-watchdog.org
Cc:     linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        allen-kh.cheng@mediatek.com, seiya.wang@mediatek.com,
        tinghan.shen@mediatek.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
 <20221005113517.70628-4-angelogioacchino.delregno@collabora.com>
 <1f3ebf6f-117f-62a7-8e02-3e8a3bcf7e9f@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1f3ebf6f-117f-62a7-8e02-3e8a3bcf7e9f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/10/22 18:33, Krzysztof Kozlowski ha scritto:
> On 05/10/2022 13:35, AngeloGioacchino Del Regno wrote:
>> Convert the MediaTek watchdog bindings to schema.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> There is already work in progress:
> 
> https://lore.kernel.org/all/20220422121017.23920-3-allen-kh.cheng@mediatek.com/
> 
> Best regards,
> Krzysztof
> 

I'm sorry, I forgot about that.

Allen, how do we proceed? Do you want to send a new version of yours, or should
I go on with a v2 for this one?

Regards,
Angelo
