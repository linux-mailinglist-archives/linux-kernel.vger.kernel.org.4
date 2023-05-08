Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B516FA004
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjEHGjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjEHGjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:39:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B9E4495
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:39:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96598a7c5e0so652732366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683527945; x=1686119945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjLZkRK76k/wkevUoBquP1EnIYn4hn3yK257zuPgKq0=;
        b=i2/mJ9U9EO9CleT8Tfa4ae4iEnPAlMS7Z/yXmuN7WsSKdYcG5+Wr55jaWSsKItJpqb
         ZvJOnFpgEJ/VMel5jGXf0mUPs/e+FX35JchIqfU1WmIqZEh9ILpqB+LIoSQA8BEJkjQo
         YiZBCcPOWc3yoxWcnvsu2l2bOiPF9qimDO/G8dM2C4LOZQfEojGqfx3+v2XaMoWrk0jn
         G7QyrN57Ibi4j6B59AUTgM1AVkEbLtwnFebc1DT4XGYG1g/RH5Ij19/ERokAUxjaBUQB
         lxF/rcQZGDC/ivOkvkboB1mMtx444p117IuUNla+um/oJ94o84dTxHh5aABo4XA/bgSa
         RqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683527945; x=1686119945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjLZkRK76k/wkevUoBquP1EnIYn4hn3yK257zuPgKq0=;
        b=c2hrQe0iQrSM7gDNXcOHkrAX7NOk3YVJR3J74T55R6kXWwYULNgF69j3xSuI8s6+C5
         eNurg7zYK+4tNZSx2VrgOljxEisfXhomzk3hcSBcN0tR2EhhxOF/hDrT3/at/t4O6l5i
         U0Eyc5O8vf3+AIklX6mDFjPllvmd/flr/cyQKphPWXycXhwIjwJwZxFJExJZKP0D1Pcy
         bTOoeDfD999foL2g4slNfngGeit33ugh46mgH6E0WadYASoeGDxWTsWT0mUULQZefLJY
         pVFe8K4Z+9fhQ/clUAQEzj26+20FyVtW8gFE0mCiRXx8ptBmjQGUxVevxWsA+hHk5mEw
         iwQw==
X-Gm-Message-State: AC+VfDyHfLynoEBHqd7YP5H5dhixUBwlPJeW8GUUtZNquBvXoWq4Af/e
        oI19mLAvGtG2+qr3FbximTxLaQ==
X-Google-Smtp-Source: ACHHUZ5ajzFkWG+WzE6FqplmHDuqClJwLSo/36C1lVTLEU8agdoGbPPNutaBFOB5JLcAp9zSM0z/VA==
X-Received: by 2002:a17:907:3f9e:b0:966:54ac:17d7 with SMTP id hr30-20020a1709073f9e00b0096654ac17d7mr2964786ejc.76.1683527945142;
        Sun, 07 May 2023 23:39:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jy1-20020a170907762100b0094e6a9c1d24sm4619148ejc.12.2023.05.07.23.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 23:39:04 -0700 (PDT)
Message-ID: <a2718541-9dd7-e093-0f62-d62e56dcb04d@linaro.org>
Date:   Mon, 8 May 2023 08:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Content-Language: en-US
To:     alison@she-devel.com, johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, achaiken@aurora.tech
References: <20230508011159.263322-1-alison@she-devel.com>
 <20230508011159.263322-3-alison@she-devel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508011159.263322-3-alison@she-devel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 03:11, alison@she-devel.com wrote:
> From: Alison Chaiken <achaiken@aurora.tech>
> 
> Add support for the U-Blox Zed-F9P GNSS device.
> 
> Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
> ---

You miss versioning your paches and changelog here.

Also:

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Missing tag:
Acked-by: Rob Herring <robh@kernel.org>


>  Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 1 +
>  1 file changed, 1 insertion(+)

Best regards,
Krzysztof

