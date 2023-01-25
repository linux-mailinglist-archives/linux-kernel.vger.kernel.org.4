Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22BB67BA62
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbjAYTJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbjAYTJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:09:36 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793315CFC4;
        Wed, 25 Jan 2023 11:09:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so2055307wmq.0;
        Wed, 25 Jan 2023 11:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5RAf+FoD3kD3uKp2a9aXTt0ztNoNqQfHHQT67AwEHFY=;
        b=b6H4AGc9EcLzEpPx1uNxpDkYcPOiFlaHxDr1dtMOdeYAPKhbJX0M9HTALOa/5GWWPk
         4KkMruQx7gIRtMa+nf670ZzvrfPJYOHUioW8A8fRWRwY4IPBliEFosyiKOJ1FjOf9Bk1
         siz60TgzggOI4I2fMZl2Hot3etpGe3VykDi23cXOhcuxouCac0nrAcQqxUAJMYEx440P
         vR2KOKNnnIKkgkcfFTGpABIswcbBF3vxsVFNVMmekAwzbmo2of95dYp6sSKNTWYFLQ7w
         DDfKiFfXvHjApYrFYcW7ESGEJkwnIdK9TaNcUmMcUDwv1Uft6+xArMMyIxUSotu41N0Y
         z6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5RAf+FoD3kD3uKp2a9aXTt0ztNoNqQfHHQT67AwEHFY=;
        b=I7vyvZdkq2prjrj1eDHMYmykSqvDDrX+UUzWh8zNlGlroHvOLzO5/jZDAJV4XwTR+o
         nxKZL/+VJWLwOEADJgJ49MeszljJtRlGjDbiIThFIHarcVB7im78Ak00lolxHTnOFM81
         Oz2qym2ShDyy6QCk8htCscWvXhrCduD+i8KRUgP8JA0jbnyp+pWNwlfz1hr9yuvwxYft
         Uvae3kfvM3zPHVLB1UWJ+rfAfsEGxpFgln02iDXxvcYK59yXM5//Sl2BzeV0bagMWJ1n
         r7ltoSK5fiU6kLboj+Cce6o0Ma+/DO5oUoUKnhuqypzjuNscLCJzTuVhoLfzf4g/DE8+
         IYrQ==
X-Gm-Message-State: AFqh2ko/+xi0a336vxnb9K0ianNgxMn41syUh6cqFJffgYSoClT+PEY2
        9nf/b8JqNcDrJ6MRlnJdydI=
X-Google-Smtp-Source: AMrXdXvtMXyMvraIkniFaiTIvZWVgPXmcScLBOxVnQYgvmZhBJMkq+rEi0E9cvgaQW5EFnA9zYXaZQ==
X-Received: by 2002:a7b:cb88:0:b0:3d9:f801:73bf with SMTP id m8-20020a7bcb88000000b003d9f80173bfmr32430098wmi.12.1674673746896;
        Wed, 25 Jan 2023 11:09:06 -0800 (PST)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c150500b003dafb0c8dfbsm2998092wmg.14.2023.01.25.11.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 11:09:06 -0800 (PST)
Message-ID: <243ad9f8-76f6-3e60-91ae-21d04ba6f262@gmail.com>
Date:   Wed, 25 Jan 2023 20:09:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 5/6] arm64/dts/mt8195: Add thermal zones and thermal
 nodes
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-1-bchihi@baylibre.com>
 <20230124131717.128660-6-bchihi@baylibre.com>
 <80ce4ea3-6ebd-c249-45bd-a2f04343690b@collabora.com>
 <CAGuA+opCcdbPbasadEFbKw1nSy-kbK3WzKG=wXn6dtzynjrY1Q@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGuA+opCcdbPbasadEFbKw1nSy-kbK3WzKG=wXn6dtzynjrY1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/01/2023 16:10, Balsam CHIHI wrote:
> On Tue, Jan 24, 2023 at 4:37 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 24/01/23 14:17, bchihi@baylibre.com ha scritto:
>>> From: Balsam CHIHI <bchihi@baylibre.com>
>>>
>>> Add thermal zones and thermal nodes for the mt8195.
>>>
>>> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
>>
>> You should change the commit title to reflect the same syntax that you can find
>> in a `git log --oneline arch/arm64/boot/dts/mediatek/`.
>>
>> arm64: dts: mediatek: mt8195: Add thermal zones and thermal nodes
>>
>> or
>>
>> arm64: dts: mt8195: Add thermal zones and thermal nodes
>>
> 
> Hi Angelo,
> 
> Thank you for the review.
> Should I resend with the fix?
> Or you would fix it when applying it like Matthias did for "[PATCH v11
> 3/6] arm64/dts/mt8195: Add efuse node to mt8195"?
> 

If you need to send a new version for any reason, then please update. Otherwise 
I'll fix it once I can take it.

Regards,
Matthias
