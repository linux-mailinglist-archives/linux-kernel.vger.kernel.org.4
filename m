Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA7F6D692D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjDDQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDDQry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:47:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A18610CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:47:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id y14so33536232wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680626872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oaSx5e17w+eQ0F1AcVamtGRazPQo+5R7R3fJynml9qc=;
        b=tXneM2QAmpdWlmTsBeLyjMu9Q84z6jecvcZAoyME6dDKBB2jydUY+P5ujDvC32T7+/
         eJY7OEJd2z+JSRf5f6iO8cSUl1fDdciHwnQrOvzfF3ZgE3nOIhSClDIEFRDEsUMq3aXz
         MuOQ+YXH1xiQk2p7rk2FjgYTJH3QD0Ale7JLzRF+yKdHAp26XgBtpjVFUcQ+yXDhtUBE
         n8rzQXqd1GqJupYRjonljWsrCRXXS/27vGYF0S4NORJ1HqkJCzoqHRtz6936GlCGLsRe
         Zrqkzchqxif7b2GAdPJuNzECRJjMXEUjJWC/TujfdJaZUz4IyFztSmBA/nUjJb8VuhRt
         RJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaSx5e17w+eQ0F1AcVamtGRazPQo+5R7R3fJynml9qc=;
        b=rpsnAGLL8wKS2jlkp1RZzJxQ4lkSqok6UdaZq/SQgvbkbzhOTQVw14MS5B8umm2+Nv
         EaUA0e8nrAkIl1B7Fkow3I1WUg4oKEYPa97EaYLK5EsYqoJevi67YJpMD4Iw6QlBRVtA
         9jRHBmXiO3nFQon3GoVA4RSIP8CGzxp+dx1O+RuxgINAVn48lLx5DKly+klOtNZC/X0O
         1eebvFALiplH66lmn4mUTOArqrNtU5kVYOqLtT9c/W0UaZKxn6cldtmtd8NBJmnZ7snO
         YBy/iGZpf3X5Qi5OsmoMKZBn88OMW4CsAb6p/WWD2G9HQkPiuCHOW5rhQXK/luAou/MP
         YBFA==
X-Gm-Message-State: AAQBX9cNue9hmHsVXL2a2ilYyQSsid2AlKLqaux1tGQW/sEWwCBOFlj1
        kUrb8wpqmOJ85GwK8s+Aaf8UOg==
X-Google-Smtp-Source: AKy350aJ5L9eW/Z1AJZ2Yf0nBavJ/tgFyF3nmBDpng8tle57odq3CevaTl03dHgs+C2a1jOqYBCw4g==
X-Received: by 2002:a5d:67cf:0:b0:2e6:3804:5be with SMTP id n15-20020a5d67cf000000b002e6380405bemr2262083wrw.59.1680626871679;
        Tue, 04 Apr 2023 09:47:51 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5002000000b002cfe0ab1246sm12718073wrt.20.2023.04.04.09.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 09:47:51 -0700 (PDT)
Message-ID: <9f1e06a1-c954-1e20-8649-4f85515f0ece@baylibre.com>
Date:   Tue, 4 Apr 2023 18:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/2] Cleanup Mediatek pinctrl device tree binding
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230327-cleanup-pinctrl-binding-v2-0-f21fbcc3016e@baylibre.com>
 <CACRpkdYndXqTXrTakwv1mbvJBs-tG+pjOpLLCgS9crE0aBj0jA@mail.gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <CACRpkdYndXqTXrTakwv1mbvJBs-tG+pjOpLLCgS9crE0aBj0jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 04/04/2023 15:56, Linus Walleij wrote:
> On Fri, Mar 31, 2023 at 7:39 PM Alexandre Mergnat <amergnat@baylibre.com> wrote:
>
>> Deprecate properties which shall not exist, leaked upstream from downstream
>> kernels, there's no reason to use them. Here the deprecated properties and
>> the generic properties which will replace them:
>>
>> - mediatek,drive-strength-adv => drive-strength-microamp
>> - mediatek,pull-up-adv        => bias-pull-up
>> - mediatek,pull-down-adv      => bias-pull-down
>>
>> Thanks AngeloGioacchino Del Regno to reported it. [1]
>>
>> [1]: https://lore.kernel.org/all/6e08d78f-ef4c-b228-f7d2-d63767ea87b8@collabora.com/
>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>> Changes in v2:
>> - Change the bias-pull enum values to match with other Mediatek SoC.
>>    That allows to use MTK generic define and be compliant with the MTK
>>    common pinctrl driver.
>> - Link to v1: https://lore.kernel.org/r/20230327-cleanup-pinctrl-binding-v1-0-b695e32e4f2e@baylibre.com
> These patches does not apply to my devel branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel
>
> Can you please rebase and resend?
>
> If you have several conflicting patches that need to be applied to the
> pinctrl tree, then collect them all in a series so I can apply them all
> at once. Thanks!

It's done here: 
https://lore.kernel.org/all/20230327-cleanup-pinctrl-binding-v3-0-6f56d5c7a8de@baylibre.com/

I also added the patch which modify the pinctrl from the other serie:
https://lore.kernel.org/all/CACRpkdYSpMD-V0QNGwtiKCA4KAedYfmFpvdCHWhjST9uTricTg@mail.gmail.com/


Regards,
Alex


