Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE4B70B811
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjEVIxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjEVIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:53:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37D8A8
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:53:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so56942165e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684745588; x=1687337588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4JxhaVexhQpy8daiRNDw+XTd4Z91THI1tcDfW2c6HE=;
        b=hGYIQsrsHnFEjQuK41XgS3jgFHGmSkmDmGtZqfqKbMqaw1+roK7luzJGgf6MkEI2zf
         LqSzON1Zmed3SV4ToTWAPBXTyvtUhV9/8BCRoPKLguRVN5e4YBErEdR6/iXkgr3w9zE5
         W4aKjz3F4KTe2c3j6kFwE4TdtneueV0LY7ZEt0yjmGJmTeBgneLZHGLd9Y5ags2ZDhae
         Q0TT+80cDnDkrcVtC6mKi1S3g1p/XIxKWym0HyRrbbgeMEikjwyJ03sHhQcufI7aiV4Q
         NEDGLQcwWgPgAjXuMgjJUDQE1/rby2Z3aJWEmCe4axLQbKwyT3jCR2BgkZU+gClV7wO/
         ACMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684745588; x=1687337588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4JxhaVexhQpy8daiRNDw+XTd4Z91THI1tcDfW2c6HE=;
        b=BA+CyXWeXAEZp/r2TSwl1drxd+1UY3Rai3sDgTtb44WgGOmlxJKJ4ljZvAY9aGAzw8
         Viyhw4PWRZTZLd9AunzzbiIFif3KbzeGH7kOJyZsZYqw5U5k7QnDKCrkZuDaKmyIyShh
         CZ8O7x/bS96mUFcrxPQEJ8ceYIup0QRqt+EDAjbVPmm15Y6NAW3g8+CT5yaTjjxCk3C0
         iD36Mx2x2wudcUvoJA5xdU3KKLNDdX2GOUHI4WRM42FgZNkvDrtIJUpSxB7wjuuBls1q
         HdQZZrYPUopZzT53deqERBVcSeXxQNiUjs1MDcKLseJwcSaGkREkUA7KnWXM8J6d8UgG
         I6bA==
X-Gm-Message-State: AC+VfDx+/bPDJEMDFuAY9GyWvzjBDDesMm+ONFIlO/2HG8FsLgWC3pRc
        Qub4tFNLNIUrACzwrN2ZyobTRQ==
X-Google-Smtp-Source: ACHHUZ6UBR3+LBI+m8V1SPTaOnzgCK0atCcXfHxkCN2098SLTc/lFSwqy+8q2uw7iLTos5PH9rKVCw==
X-Received: by 2002:a7b:c414:0:b0:3f4:2610:5cc7 with SMTP id k20-20020a7bc414000000b003f426105cc7mr6538472wmi.9.1684745588453;
        Mon, 22 May 2023 01:53:08 -0700 (PDT)
Received: from [10.1.4.6] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c358400b003f1738d0d13sm24745899wmq.1.2023.05.22.01.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:53:08 -0700 (PDT)
Message-ID: <116712ae-f18b-3288-ac6d-80073aebd458@baylibre.com>
Date:   Mon, 22 May 2023 10:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 7/7] dt-bindings: Add bidings for mtk,apu-drm
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, airlied@gmail.com,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        jstephan@baylibre.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, khilman@baylibre.com,
        nbelin@baylibre.com, bero@baylibre.com
References: <20230517145237.295461-1-abailon@baylibre.com>
 <20230517145237.295461-8-abailon@baylibre.com>
 <c32f0c3f-b43a-7045-38cc-2c11c7bb571e@collabora.com>
Content-Language: en-US
From:   Alexandre Bailon <abailon@baylibre.com>
In-Reply-To: <c32f0c3f-b43a-7045-38cc-2c11c7bb571e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 17:04, AngeloGioacchino Del Regno wrote:
> Il 17/05/23 16:52, Alexandre Bailon ha scritto:
>> This adds the device tree bindings for the APU DRM driver.
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> Reviewed-by: Julien Stephan <jstephan@baylibre.com>
>> ---
>>   .../devicetree/bindings/gpu/mtk,apu-drm.yaml  | 38 +++++++++++++++++++
> 
> mediatek,mt(model)-apu.yaml
> 
>>   1 file changed, 38 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml 
>> b/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
>> new file mode 100644
>> index 000000000000..6f432d3ea478
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
>> @@ -0,0 +1,38 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gpu/mediatek,apu-drm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: AI Processor Unit DRM
>> +
>> +properties:
>> +  compatible:
>> +    const: mediatek,apu-drm
> 
> const: mediatek,mt8195-apu (or whatever else).
> 
> ...besides, I don't think that this patch even belongs to this series? :-)
> Spoiler alert! :-)
Actually, it does!
I forgot to send the patch that adds the platform driver ^^'

Thanks,
Alexandre
> 
> Cheers,
> Angelo
> 
> 
