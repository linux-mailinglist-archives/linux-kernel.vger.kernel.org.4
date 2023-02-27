Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AEF6A4277
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjB0NTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjB0NT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:19:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B932A5F6;
        Mon, 27 Feb 2023 05:19:13 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 21FCA6602EBB;
        Mon, 27 Feb 2023 13:19:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677503951;
        bh=M84hUc6FSjtfLLuQzMVefdgxCampFeISHt8LSmhyiIM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CDiCRdUU0NNxCM540FhfqUKkpo4mktrjuOYSHLlsZ13oHX2JlAsIydqSIIOir4PeH
         BmEw7i4EV1M0yfhKyziVFK634gam8zXe1GE3igvbIFD5f1ctEoQpDFbCkiF60YiRHn
         7hCyMAz6X7ahzt+xO6wqPYlnACJpPAGOZd41vWDaO9FM1FUyZf5XUAsSHnYwejfvHu
         Z9Yg89+hrrZBPLBwYW+TeM7N0ytvedykIhUPOrP8sRDqdMQDqIU3NzS/Gqj3s8GeBn
         tYkpcIH9Y/Ctre4OM0HYnqh0ed6KDfsy23E99j41mOaZIRfOcI6/y6eZX5dvTtWoE+
         hFB4Ml2GDtKwg==
Message-ID: <caddf39b-fb0d-c6ff-b98e-bbd5aac5f974@collabora.com>
Date:   Mon, 27 Feb 2023 14:19:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 04/11] dt-bindings: gpu: mali-bifrost: Add compatible
 for MT8195 SoC
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com>
 <20230223133440.80941-5-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GJgAz4yvb-zvFwxRD2PGtkpV7gD-Lst9KDAaZDzLyDEg@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5GJgAz4yvb-zvFwxRD2PGtkpV7gD-Lst9KDAaZDzLyDEg@mail.gmail.com>
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

Il 24/02/23 11:08, Chen-Yu Tsai ha scritto:
> On Thu, Feb 23, 2023 at 9:34 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> The MediaTek MT8195 SoC has a Mali G57 MC5 (Valhall-JM) and has the
>> same number of power domains and requirements as MT8192 in terms of
>> bindings.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
>> index 65fe139ceb83..4d9ab4702582 100644
>> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
>> @@ -25,6 +25,11 @@ properties:
>>                 - rockchip,px30-mali
>>                 - rockchip,rk3568-mali
>>             - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt8195-mali
> 
> This could be squashed into "- const: mediatek,mt8195-mali" like the
> following lines?
> 

Could be, but I expect more compatibles on this list, that's why I've modeled
that as enum. I prefer keeping this an enum.

> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
>> +          - const: mediatek,mt8192-mali
>> +          - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision is fully discoverable
>>         - items:
>>             - enum:
>>                 - mediatek,mt8192-mali
>> --
>> 2.39.2
>>

