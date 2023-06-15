Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F62731648
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343701AbjFOLQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbjFOLQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:16:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED642729;
        Thu, 15 Jun 2023 04:16:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-311167ba376so405683f8f.1;
        Thu, 15 Jun 2023 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686827790; x=1689419790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EfD6orI9tZacMH+Y+bAGm4LXkubDI4YrZBV8+HS7CA=;
        b=avf9pDAktpHHxJcKQ2ir0jkDwnxPjCwfwswv0+4DeowZi4bhUl4KOQJ6LZvLf0jSU8
         Oeh/7dt4Z/CaTxRRbL2TIRFQhsR6olV5Rvm8/DIcDjYWWc7YpeAs0mJ2Xa3Vfjx3ddeh
         qlKAySr1KWlGOfu0clFQT5IKPK/07WXr3fWNQo5nIMYXv7IyJI0FXBU8ttTC2B6oajKz
         cN2E7lc7TTBYrsv8AEDqt9jwlMOoITqsi61NvckmSmVXoLS0yduvpr3FhLdwWqbvhB+p
         qheVvuNmYqm+GKc2qg9kJPAlKwAqJZA7IC228un0OeufiAVtWcZb+GhS1QFgIddnT/lw
         3qQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686827790; x=1689419790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EfD6orI9tZacMH+Y+bAGm4LXkubDI4YrZBV8+HS7CA=;
        b=XpYYAocB84hFcPsB5fdiBfKqQReL04hivr+xMtc/cEIuUnxHpMK7K01D0Se8Srw7PH
         xuylM1qQFD49h/ai5vSv3QC9iQSilJNeWw44c29crk1csR0TaUXqgK1XOD+Fg5Sw/Iga
         LAuys73KNRSRQqTSwcMnXtSzmZBNPKtdm4pzyceA4zwjZhXKR1v0tW8lt1OsTXsBDGZ9
         CTXS+DTp12YtJaWlDB3kk0LYkpjqDJsU7Cf3M0KYwBsWk8fPnd3JaMal5u5+cVTUhHip
         6yOJhWfjF49vTLNrZzLRZzGq6Nm28hIlPCPIUfv5X+X0jTM+lKM16SnCF4ki0IA/Vsgy
         LmDQ==
X-Gm-Message-State: AC+VfDyg3b0pI0lq/CXOVFRUSmzjEYSJ/gWqCQ8EgM0YokBDrCOifPyo
        i0iaPqv+7BaeZJ6si2mfU5g=
X-Google-Smtp-Source: ACHHUZ7Ocn9TprFkQn3UXzhn8Yq5hR3GmWL+S8uaXLt6brEYaoql2zp0U+60tEKRQPqMW5CIbaiJRw==
X-Received: by 2002:a5d:5112:0:b0:30e:52de:9ccf with SMTP id s18-20020a5d5112000000b0030e52de9ccfmr11671451wrt.68.1686827789849;
        Thu, 15 Jun 2023 04:16:29 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m6-20020adfdc46000000b0030e5bd253aasm20822974wrj.39.2023.06.15.04.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 04:16:28 -0700 (PDT)
Message-ID: <519c6d38-bdea-3881-00e3-9bc3dee0f70d@gmail.com>
Date:   Thu, 15 Jun 2023 13:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8192: Make sure MSDCPLL's
 rate is 400MHz
Content-Language: en-US, ca-ES, es-ES
To:     =?UTF-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        =?UTF-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        =?UTF-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?V2VpeWkgTHUgKOWRguWogeWEgCk=?= <Weiyi.Lu@mediatek.com>,
        "ikjn@chromium.org" <ikjn@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230522093002.75137-1-angelogioacchino.delregno@collabora.com>
 <20230522093002.75137-2-angelogioacchino.delregno@collabora.com>
 <45cba46f9fb34acf393ec2743206403bc6a5e137.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <45cba46f9fb34acf393ec2743206403bc6a5e137.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/2023 11:51, TingHan Shen (沈廷翰) wrote:
> Hi AngeloGioacchino,
> 
> On Mon, 2023-05-22 at 11:30 +0200, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until you have verified the sender or the content.
>>
>>
>> Some bootloaders will set MSDCPLL's rate lower than 400MHz: what I have
>> seen is this clock being set at around 384MHz.
>> This is a performance concern (and possibly a stability one, for picky
>> eMMC/SD cards) as the MSDC controller's internal divier will choose a
>> frequency that is lower than expected, in the end causing a difference
>> in the expected mmc/sd device's timings.
>>
>> Make sure that the MSDCPLL frequency is always set to 400MHz to both
>> improve performance and reliability of the sd/mmc storage.
>>
>> Fixes: 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192 clock controllers")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> index 5c30caf74026..6fc14004f6fd 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> @@ -677,6 +677,8 @@ apmixedsys: syscon@1000c000 {
>>                          compatible = "mediatek,mt8192-apmixedsys", "syscon";
>>                          reg = <0 0x1000c000 0 0x1000>;
>>                          #clock-cells = <1>;
>> +                       assigned-clocks = <&apmixedsys CLK_APMIXED_MSDCPLL>;
>> +                       assigned-clock-rates = <400000000>;
>>                  };
>>
>>                  systimer: timer@10017000 {
>> --
>> 2.40.1
>>
> 
> Comment from mtk emmc owner,
> 
> "As we all know, the clock has some jitter, when we set MSDCPLL to 400M,
> but the actual measurement is not exactly 200M.
> For eMMC, the spec stipulates that clock cannot exceed 200M.
> If MSDCPLL is set to 400M, the actual measurement may exceed the spec.
> So we set MSDCPLL to 384M in the bootloader stage to avoid exceeding the spec."
> 

Thanks for the feedback. Given that I'm not aware of any regressions that got 
fixed by this commits I will drop this series for now. We can keep on the 
discussion and if needed add them in a later stage.

Regards,
Matthias
