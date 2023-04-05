Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679B46D7D5A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbjDENHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbjDENG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:06:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8E230EB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:06:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d17so36119477wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680700015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WeZ9y9cBWf8D72zPud79w30qw3KXJ+7zJufVpVM/bXA=;
        b=x9C1l3yN6ebb0k9A9ISZ/SNmRbWnaNsCPmvIRmimgXqS+3KfKLMyqL85N9PzN2LhRg
         00Cl1uG6z5LFbekfIcB3R9xZKQ+tTZkd56YT0HFh3dbXygkYOQ7Zqg0iEEIRDEdJ+g1S
         bkfdBm2mafUl3f7rX0ox0fqJpXyzmLE1v43buDEH9OQFDCZbOu7Bz3kPFGjcWCwx3h+G
         s/zEa3IV6p2PBSuEfcSuD8mOlmIp5/ysvJ6KRi8UcpEnenpCdG5xvfUe3vqSiTE/WSXw
         slbj2JpS4kPKDqJ6cJN6GQIiFmCnRLkks/YPsdq06So/4s511HNCUwCwUjravbV4NqMs
         WmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WeZ9y9cBWf8D72zPud79w30qw3KXJ+7zJufVpVM/bXA=;
        b=wo1pXOksQQnNc0g3dHNxp+PZokKYJfRMBq5K6vZ+Ta1vniuNAgbeFJwYa4HZ699rb4
         u/2LgvVZRB05wD+zS/Nfld1eBm1LmI/ffgfFZKLslTzDIBQ6LFa0Zqucy8hxaaePESiV
         Q8TnX8mTc2iydYEQb+Rc5/EgcAbbrtaeQ7XHemtZxR8gth3cDeQ3vD5SFHJaB9FNuCB1
         ErxreIW6r3F/Drio9aX70iSXWubcR3LomrhRnGCbT38SuL1OdTqju5EEVhRLMrg5+LeV
         uVtrZ23v0wK7OFIdB2vNjxmUZWEejBxFOol2ZbndPEP33RbZdBbNgD1l7F+VB1Sl0qyl
         WuXg==
X-Gm-Message-State: AAQBX9fhbg/d14LilF7WuxQ57n3Ro9zNzgHzOQ+U5zNFH4mkW/uyAPfE
        mOZAEQ0BE7FmqHkVrMuk6iUc/g==
X-Google-Smtp-Source: AKy350YMENPnv85x0KK3Edc9qCwxaSQhCwtpw07WNjYCbM151PHxdsUy7oVj1ngPfQ6V4vI31lfjTQ==
X-Received: by 2002:adf:f402:0:b0:2e4:cbbe:cfc2 with SMTP id g2-20020adff402000000b002e4cbbecfc2mr4497441wro.25.1680700015544;
        Wed, 05 Apr 2023 06:06:55 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c205700b003eb5ce1b734sm2161425wmg.7.2023.04.05.06.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 06:06:54 -0700 (PDT)
Message-ID: <fd24877a-5fae-5434-dc56-61ab35ccd820@baylibre.com>
Date:   Wed, 5 Apr 2023 15:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 10/10] memory: mtk-smi: mt8365: Add SMI Support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
 <20230207-iommu-support-v2-10-60d5fa00e4e5@baylibre.com>
 <9847bc48-c96c-3599-e876-bcf9ebf1522e@linaro.org>
 <CAFGrd9pBdaHLGUZHkaz2_XKafyX=dxu9UckQxrphg52EG=A1SQ@mail.gmail.com>
 <8fc3dd22-79df-32cb-c219-896eda8fa986@linaro.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <8fc3dd22-79df-32cb-c219-896eda8fa986@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/04/2023 13:45, Krzysztof Kozlowski wrote:
> On 05/04/2023 11:53, Alexandre Mergnat wrote:
>> Ok, I will move the driver patch before the DTS patches in the next version.
>>
> Or do not send it together at all, which might solve your dependency
> problem. According to your cover letter I cannot take the memory
> controller bits, so I am waiting for dependencies to hit the mainline.
> Alternatively I will need pull request with stable tag.
>
Ok, I prefer send the driver patch in another serie. That will solve the 
dependency with the DTS a least.

Regards,
Alexandre

