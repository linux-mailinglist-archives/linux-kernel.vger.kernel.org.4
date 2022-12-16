Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAAB64EBF2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiLPNNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLPNNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:13:08 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C802DA91;
        Fri, 16 Dec 2022 05:13:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso1722402wmp.3;
        Fri, 16 Dec 2022 05:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=srPGSkjRgSgmuXTtwPpYk9AtNMtiqHmM6C2t7J2QNjs=;
        b=hsmZvLSHOY4Gmce5AuAjDP3CdbZyUN4ZcCWXfe6Hu2zgyTtoHXBJ1/4Rp3W7Fb/WhW
         R9QXsemVceSXujcfo3j5g8hAnuVStoYy2POpEeT3+h+kHPbQ7VP/4EUbz2fTEt4tUSl/
         YPA+15MEQp3XTD70m0uR595fUFu3RZtNlJWzvSsRTENBb4EdSMJcpUQiuGGBMv+4GdeI
         c+NaRIKyDu5xmZbLEC/JEFNyAoW66JQYKKNjyGtMg/l1GylqLmBHdYuim/0IzPoG2CuP
         t2+khJ1TukQ0dPHTUUGkxp1G8hV+KKoLttkOxnKe93y8lFk70e7O9NFYKrXVa3wKgQXg
         9LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srPGSkjRgSgmuXTtwPpYk9AtNMtiqHmM6C2t7J2QNjs=;
        b=w0UCJIZFidBWwWX+N9ijKkQPSIn//m/q2RuZD1BQpWPk4tYIEoIINwPwY3TtGtPZsq
         i0tkIqPSTTIv1yXuDnvWpT7JAxlTjIOOsCZ5Q7aVYCE27JCD49xV30W+KEK0bOjOclfJ
         v6lwWMjzfRz+IkXYS93w30H1EqqM9vIvGt7udAwtxlnzRdjEHoxlR2m3920mqx4nLREy
         KIvPbnsaH770G9nc4xR0daPesF44UTOuV8WyJNneKUnSYWnQAwg7yFG79wPS7ja5Nx28
         fQvmDRrF+2nSchyo3rtOmJxPfHc2UdZlPLKnHo/5AyJxgP/ZouFhxrFydFXTCBWqoKm1
         bEQA==
X-Gm-Message-State: ANoB5pkYpMG88J8Zrt5+LrOFEDEciIBqzf+tqWfBWzLprTQai75Iq7EA
        5raxX33HD4+p0lGfn5tLL80=
X-Google-Smtp-Source: AA0mqf4VYPUaZ8JmceOcI/t0ITzDEnO81loaT+P0eo4prEQVB/kIi7P+5EVL3AGS9kVVZ4ZjwXVKwA==
X-Received: by 2002:a05:600c:2286:b0:3cf:68f8:790b with SMTP id 6-20020a05600c228600b003cf68f8790bmr25238681wmf.11.1671196386532;
        Fri, 16 Dec 2022 05:13:06 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p16-20020a1c5450000000b003d07de1698asm9567660wmi.46.2022.12.16.05.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 05:13:05 -0800 (PST)
Message-ID: <5412b27a-b5a1-351a-495d-3ba7e022302a@gmail.com>
Date:   Fri, 16 Dec 2022 14:13:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 0/5] MT8192 Asurada devicetree - Part 2
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20221102190611.283546-1-nfraprado@collabora.com>
 <CAGXv+5GY5f4UWR982cY0vzUuk7aB4BSa_FcKtku1ELatMr4Dwg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGXv+5GY5f4UWR982cY0vzUuk7aB4BSa_FcKtku1ELatMr4Dwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2022 04:11, Chen-Yu Tsai wrote:
> On Thu, Nov 3, 2022 at 3:06 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
>>
>>
>> This series improves some more the support for MT8192 Asurada-based
>> Chromebooks, by enabling some missing functionality, namely the internal
>> display and audio.
>>
>> In addition to that, aliases are also added for the i2c and mmc nodes,
>> which should've been done while adding the devices in the previous
>> series.
>>
>> Some notable components that are still missing support are:
>> - external display/HDMI audio (waiting for [1])
>> - GPU (waiting for [2])
>>
>> As part of testing the audio, an UCM file was used, which has already
>> been submitted upstream [3].
>>
>> This series depends on some missing dt-binding properties on rt5682,
>> which are added by another series [4].
> 
> Hi Matthias,
> 
> This series has been floating around for some time now, and has been fully
> tested by multiple parties. The rt5682 dt-binding changes have also been
> merged.
> 
> Could you queue it up?
> 

Applied now. Sorry for the delay!

Matthias
