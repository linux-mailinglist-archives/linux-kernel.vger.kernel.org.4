Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D16867B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjBAN5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBAN5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:57:19 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF68B2E0C1;
        Wed,  1 Feb 2023 05:56:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id lu11so14315064ejb.3;
        Wed, 01 Feb 2023 05:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zA00Qz0JPk4MiJn8NwFtqQLVGcoqmJxWG2bf2W8xESw=;
        b=dOiccATA0bf1VpwwjW79XyJkwhl08xOgcaeX84t8kBmVgnjmooFAvxlLfIRddZvBa8
         Fbyat6rjG2fgB/34PNH4i6iiUJXhV7jiZ0+jC0Xpi0rPVTSAQABNxM0r4ohkUIpNsS/k
         PQSfjjRwkvb3nIh+KIcegIcQeqYZAgbum10TwIx6HDQ7waa+CXDknuEoLL7QD5HfiaZ6
         rOOaCeIb15puNHlMqkUdCigXVCHxO7EUSQBAByWXss6rHkTDCInDzDwyhQzAkV2lgC80
         yKdgYE5CC6LS4rhE68ZEfgmYVrCtlViiiZoCwQzO4qlAQ8Jd4eulL7Zo8AYItyfCeb5I
         1IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zA00Qz0JPk4MiJn8NwFtqQLVGcoqmJxWG2bf2W8xESw=;
        b=UpecaXTa7/ONvVGoIuhKze2JwRXTEDyBnVo+G3+dL6WytEWQMPtdYY2cZsN2aeyxhJ
         PFqiWEZC9EH4mSnmfyh5stqptaMikOPaSbLo5zHoDjXrORIBtbErKZeO6dY1ngKWeYFT
         4q+Cem2ck53ycsQtn4laKGOHqkeZDidMj+0uXdRChYV0l6E8G1JrfSfo5SyITJOtG767
         1UtfFQIxNxJtPi3JkKc9y0tJdTQBA53XxC/wJNF+sFg5FiovpERzff33a3Q4jKW1Iqlb
         wpg3cDFaE1rfxIAQtElrdzFKa/6GeCQ6BjkDH7n0QzWeYCmJqXLxYje6Q3Mrsa2wnJbO
         R31g==
X-Gm-Message-State: AO0yUKWQz3kI8I+Stiw03kJQVtPzaLBeyr/3PV+uIFesE2YNML2SnQwG
        aqnE6jDbOR5wjXn1Wze9GZo=
X-Google-Smtp-Source: AK7set9wtZYBiXOAl5E1LAVfq6s+bHA946NV7XKZ5kmjMt3I8p1RpJKvYpLlfWkDOLxurF2oK+63SA==
X-Received: by 2002:a17:906:6b98:b0:878:7833:816a with SMTP id l24-20020a1709066b9800b008787833816amr2336086ejr.43.1675259767429;
        Wed, 01 Feb 2023 05:56:07 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id pv5-20020a170907208500b00888fddc4eb2sm4598051ejb.164.2023.02.01.05.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 05:56:06 -0800 (PST)
Message-ID: <c3ba77ad-cc90-3246-2bcd-ee29029bfd7d@gmail.com>
Date:   Wed, 1 Feb 2023 14:56:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 0/7] MediaTek watchdog: Convert mtk-wdt.txt to
 dt-schema
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     nfraprado@collabora.com, angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
References: <20221108033209.22751-1-allen-kh.cheng@mediatek.com>
 <CAGXv+5EkPWF77ATVRhxygVOyYmxXgdTNPmOefP7jGeOMeZw_MA@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGXv+5EkPWF77ATVRhxygVOyYmxXgdTNPmOefP7jGeOMeZw_MA@mail.gmail.com>
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



On 29/12/2022 11:37, Chen-Yu Tsai wrote:
> On Tue, Nov 8, 2022 at 12:03 PM Allen-KH Cheng
> <allen-kh.cheng@mediatek.com> wrote:
>>
>> Based on git/groeck/linux-staging.git, watchdog-next.
>> We use [1] and [2] as references to send a new series.
>>
>> This series converts mtk-wdt.txt to dt-schema and contains
>> - Fix watchdog compatibles for MT7986, MT8186, MT8188 and MT8195,
>> - Fix the watchdog name of mt8516
>> - Add mt6795 and MT8173 watchdog compatible
>>
>> Changes since v4:
>>   - Drop label for watchdog node in mt8516
>>
>> Changes since v3:
>>   - Drop label for watchdog example in yaml
>>
>> Changes since v2:
>>   - Drop merged patch from series
>>   - Rebase to watchdog-next (for mt8188)
>>
>> Changes since v1:
>>   - Drop "items" for a single enum·
>>
>> Changes since [1]:
>>    - Update the commit message with some details
>>   - Drop "timeout-sec: true" and use unevaluatedProperties
>> [1] https://lore.kernel.org/all/20221005113517.70628-1-angelogioacchino.delregno@collabora.com/
>> [2] https://lore.kernel.org/all/20220422121017.23920-3-allen-kh.cheng@mediatek.com/
>>
>> Allen-KH Cheng (3):
>>    arm64: dts: mediatek: mt7986: Fix watchdog compatible
>>    arm64: dts: mediatek: mt8516: Fix the watchdog node name
>>    dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT8173
>>
>> AngeloGioacchino Del Regno (4):
>>    arm64: dts: mediatek: mt8186: Fix watchdog compatible
>>    arm64: dts: mediatek: mt8195: Fix watchdog compatible
> 
> Looks like the dt-bindings have been merged, but the dts fixes haven't.
> 
> Matthias, could you queue them up?
> 

I just added 1-4 to my tree.

Thanks for the reminder!

Matthias


> 
> Thanks
> ChenYu
> 
>>    dt-bindings: watchdog: mediatek: Convert mtk-wdt to json-schema
>>    dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT6795
>>
>>   .../bindings/watchdog/mediatek,mtk-wdt.yaml   | 80 +++++++++++++++++++
>>   .../devicetree/bindings/watchdog/mtk-wdt.txt  | 43 ----------
>>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |  3 +-
>>   arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  3 +-
>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  3 +-
>>   arch/arm64/boot/dts/mediatek/mt8516.dtsi      |  2 +-
>>   6 files changed, 84 insertions(+), 50 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>>
>> --
>> 2.18.0
>>
>>
