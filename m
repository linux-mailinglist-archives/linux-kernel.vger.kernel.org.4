Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D97A6A8107
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCBL2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCBL2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:28:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05151165E;
        Thu,  2 Mar 2023 03:28:45 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c18so10461119wmr.3;
        Thu, 02 Mar 2023 03:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677756524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbefYfUzG5BxKsWRBtbIucuyyqa3BZG4AScEYVrOhxo=;
        b=LrWllxYQ0n8ajJAexBum2zDwvCb3m6Fpwsk6bRWeThtZ54KAbabBoydqP1jWsn8jCF
         ZSlwjJ+cl3RuzIx5imC+4immHm14f+jmT4gUPaGiSm+4EBBDQfQ+jA6Ujv5729Hi6SUc
         jrNgVOENH2CKO7eASSCcSRnbC+oR+5Kmztvt5VMza184SEGd07l71xAd44clTVGDI+8Q
         CZLC+Igsn1SdgtveM2AxhoS2Tu0hRvP/spRCoquTVp5DpvgyIfkrtPcTatwIQLzjXCoC
         ggg2dlbPe2lu7IcVCAgYrklURr0UmQhvA87ORzQrr1slB9bhe8aWksY+gEI9gfl1RCVP
         TC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677756524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbefYfUzG5BxKsWRBtbIucuyyqa3BZG4AScEYVrOhxo=;
        b=wreENHz0KV6CDF8WIImu/KCdpBMColAflLy+rXyCurm3r1xJzvaBspeyDvE/k6vQtQ
         lsPNFn1O/ksNdOaFJfWdjsSZcOG+YDuKNVsXeYLcmAvFUPadT0Mfy92gtYUndY7djsSh
         qt1Tj6CFnl7Vt+Dmtx5EbdY7d9Z/Hpa9di0THLfFcYWEEupZ/dElFe+Euu5pudd8kpuO
         mC20GsQIRkbGH8iFN2qhqABnnxiOvuedoDHwKzKvYG8/7aBGyxBSTwcznkt11cfB0+l6
         8L/S3clTvbCcGtPs/CuF95GnqkrM/9UuKsxyjjtRmTJJj5tmGbleZGhtHxXcSOHDuJH8
         x44A==
X-Gm-Message-State: AO0yUKU9hWwelJTgq9oIDYUydZNmd4Oxsw4mYXXva8bm6yTj+y4X6LgI
        8rHh9G33msO0IN/qGhwoqhI=
X-Google-Smtp-Source: AK7set/gnKHcVpKfeIooNDE59TK9Nw8LRlREd6MeAUDwxtLB4n6A9jRhZdg4gVdwC7woIubSJjpmKw==
X-Received: by 2002:a05:600c:3507:b0:3dc:4fd7:31e9 with SMTP id h7-20020a05600c350700b003dc4fd731e9mr8155628wmq.7.1677756524154;
        Thu, 02 Mar 2023 03:28:44 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc44a000000b003e21dcccf9fsm2519117wmi.16.2023.03.02.03.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 03:28:43 -0800 (PST)
Message-ID: <e5302c3e-f985-b020-5f8c-fba876768eaf@gmail.com>
Date:   Thu, 2 Mar 2023 12:28:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 00/19] Enable GPU with DVFS support on MediaTek SoCs
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
 <b4fc6bd8-e300-0f40-4216-8b99589c21cc@gmail.com>
 <895abaa2-5fd3-9928-4e53-86ce160fbad8@collabora.com>
 <CAGXv+5EPVhH-O+ZdoLeW4OZVcEtS824oracmu3jHTa8k-tEU0A@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGXv+5EPVhH-O+ZdoLeW4OZVcEtS824oracmu3jHTa8k-tEU0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/03/2023 11:11, Chen-Yu Tsai wrote:
> On Thu, Mar 2, 2023 at 6:10 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 02/03/23 10:36, Matthias Brugger ha scritto:
>>> Series looks good but from my understanding has a dependency on:
>>> [PATCH v4 00/12] Panfrost: Improve and add MediaTek SoCs support
>>> (https://lore.kernel.org/linux-mediatek/20230228102610.707605-1-angelogioacchino.delregno@collabora.com/)
>>>
>>> Did I get that right?
>>>
>>
>> Yes you got it right - without the mentioned series, this one will do nothing
>> at all (and will also fail binding checks, as the bindings are introduced in
>> that other series).
> 
> Please also let me test them on MT8183 and MT8186 before merging them.
> 

Of course, I'll wait for your tested-by tags then.
Thanks for testing!

Matthias
