Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585CA6B1088
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCHSAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCHSA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:00:29 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C73C561B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:00:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so1905917wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 10:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678298426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHQFyw10BVunJxsxfMJNLLH0YrstlFb/O3uzZ6Wfpjg=;
        b=ufyRbw83qMR9Tdb34LRa+lUAFh1PAN8VwgGsw0takIfgH/kTPequORWhdtOk/hz5TD
         uRxobnLYhVlG+PW0wIj1K+cJm0mLhmrmqXvQER3wRGFHdw7ddbyx2E0NGGU0xaDUN9dT
         1jme7DeSFewuaURlDbgMvR3SjknlL/1TH8PLnBVBldHtbqonpBflPeRQ/DiO6gl4jHzw
         3KMmb7RulbUuusz8Q1dpE8PPu7jEni9L+dAPnnDD4Vz3LDHbV5XocVtJT1zor4B8UDWx
         /VZOqy5NR9DrnbUzr2m/2Vg/se5GqLAZDeSKleWyH3pkj2F9BIx3p9dn8YOga/ccjCKo
         g8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678298426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHQFyw10BVunJxsxfMJNLLH0YrstlFb/O3uzZ6Wfpjg=;
        b=sLkXDEzsVrFfZnZtJCV4VRVErR4Gl5dcyLFII0FaUqj3h8SwB35u/CNvM8GUm+6O/9
         uAUPFHbvhNAmLJdEt3Eq4sycNngKUF5PJuk0dipU7GgvKzSG2sR11qpHkU5Oz1Miunhf
         mva9a+cR1aY9PNhIBD6bYitZklmyODzPAh5nWtXW/jHPcXPpebnBZyZr3fycD6qaVUF/
         2UoytCMrERJVSODtirz8NSp3WWWl9yJGjgr1Xn8q2WROmOzcGfTQeDG662rp/gWYi6Du
         SkPj0iF044Mc940pKYMNECzBS9eyDEXn5AEJZfZ71CAC6XcjckQt6JLhKrpmfoeBlea/
         LFTg==
X-Gm-Message-State: AO0yUKX99W2p54138BBONO2Y8MkOUy8UWJTNCDe0EnNyhLj4JW0RsMSr
        hoHp2YZ+yHT6MxEiC+PhzO8xSg==
X-Google-Smtp-Source: AK7set+jvMl0EhuBZoHUFo60bJY0uF8ULFjfyqCjDSi5m2PvUIoskKxq3Mw/V3oU38SLKMDcpmJjBA==
X-Received: by 2002:a05:600c:4509:b0:3eb:29fe:7343 with SMTP id t9-20020a05600c450900b003eb29fe7343mr16964033wmo.33.1678298426297;
        Wed, 08 Mar 2023 10:00:26 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:4213:ad42:5630:43c4? ([2a05:6e02:1041:c10:4213:ad42:5630:43c4])
        by smtp.googlemail.com with ESMTPSA id t1-20020a5d49c1000000b002c563b124basm15585115wrs.103.2023.03.08.10.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 10:00:25 -0800 (PST)
Message-ID: <aefb1a57-6ec4-fefc-b5eb-42c899228255@linaro.org>
Date:   Wed, 8 Mar 2023 19:00:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v9 0/5] thermal: mediatek: Add support for MT8365 SoC
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Michael Kao <michael.kao@mediatek.com>
References: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
 <afa4aacd-bacf-a545-3973-474286fd4b9c@linaro.org>
 <a328c1c5-7cec-4499-8e5f-92d8cc233d38@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a328c1c5-7cec-4499-8e5f-92d8cc233d38@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 11:13, Amjad Ouled-Ameur wrote:
> Hi Daniel,
> 
> On 1/27/23 22:59, Daniel Lezcano wrote:
>> On 27/01/2023 16:44, Amjad Ouled-Ameur wrote:
>>> This patchset adds thermal support for MT8365 SoC.
>>>
>>> MT8365 has 4 thermal sensors, one for CPUs and the rest for debug/dev
>>> purposes. The CPU thermal zone uses passive cooling device with
>>> CPU{0..3}.
>>>
>>> Changes in v9:
>>> - Use delay between bank init and the thermal zone device register.
>>> - Link to v8: 
>>> https://lore.kernel.org/r/20221018-up-i350-thermal-bringup-v8-0-23e8fbb08837@baylibre.com
>>>
>>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>>> ---
>>> Amjad Ouled-Ameur (2):
>>>        thermal: mediatek: add callback for raw to mcelsius conversion
>>>        thermal: mediatek: add delay after thermal banks initialization
>>>
>>> Fabien Parent (2):
>>>        dt-bindings: thermal: mediatek: add binding documentation for 
>>> MT8365 SoC
>>>        thermal: mediatek: add support for MT8365 SoC
>>>
>>> Markus Schneider-Pargmann (1):
>>>        thermal: mediatek: control buffer enablement tweaks
>>>
>>>   .../bindings/thermal/mediatek-thermal.txt          |   1 +
>>>   drivers/thermal/mtk_thermal.c                      | 117 
>>> +++++++++++++++++----
>>>   2 files changed, 96 insertions(+), 22 deletions(-)
>>> ---
>>
>> Applied, with some changes and the subject fixed:
>>
> Any news about this patchset ?

Yep, sorry for that. It will be in bleeding-edge soon.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

