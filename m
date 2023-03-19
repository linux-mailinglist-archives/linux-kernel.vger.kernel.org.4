Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4E06C013D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCSMBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCSMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:01:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A111A12F1B;
        Sun, 19 Mar 2023 05:01:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o2so2349613plg.4;
        Sun, 19 Mar 2023 05:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679227270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fk4Dw/7JxcyrMau3xOds6YykNBRlo5bMZX0N77SkCI=;
        b=MT1xY5/WWr6AisdKABITu1sTwONVVVF/UBT7xncfXA5+ynopTVhnpbDq3mlqom09rm
         2OANzuhfMGutOtRiCH1txp2oGbryGQKBmoORUZAk34gG1RAqlCP46BK92P/N8SJSP2/c
         7EpZN+pUOXWgE8dP9LT8klK2NfViS6BCxaQgd0Szk8Vh8D6I+xO4wSb5nfYykUN7yPhz
         3oF59kbOK0Al3kEM4mWZD0PSF3Rm8Vn3fMAMpOGF+tMz2UrO0yXGrogeMSwKnhD0RN4/
         rh98cnzlhx39iApttbgqkRlXCrnNiCyuAXM13OL+eRkolgq9aVpQQpKNmRhb5Z+ov+ie
         nIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679227270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fk4Dw/7JxcyrMau3xOds6YykNBRlo5bMZX0N77SkCI=;
        b=t5LgzZwJHDV/I95e1txhAlSEH1oj7GKi4i4CRmqDxmAyO9NdQKg7HN2dre8v1Fp4Pz
         R1zWns57HvjpHFaf97Q7sM7fDPRwu8JV0h+7rguetrAEnmJSilAEgEP07BMSxBIVZ888
         buudWnAVteTQI3vUhpTVtVnl/fiTuhQhbTkOIUYGK+J1cD7TV/nlMX13wElUcyyxUJAd
         xE5u2wporT2PY3ZtiZspe2ZBoF+McXRJPNSBkEyJ9GjRMcvdi+0rvA4hh4N9v1+QNfSs
         149vc+wvt943VJ/IOl6Igpp9+WFgNylo+wYEuuuTlR016S0sR9sD3yjoN4aulVws1yPz
         csfg==
X-Gm-Message-State: AO0yUKWZAje/Q82wUlCf+2B5Y8/FIjzPRyd24PQSXKeb1eImGRx8nU+g
        rd0OaIeytTKudGiL8RcjLjs=
X-Google-Smtp-Source: AK7set9FsOrkqa5CNM3iqGzyu14xSi6aWGOyr/2wUYueNk7HAE614o8zmP1s5JP4cnLnNfUuUjtIdg==
X-Received: by 2002:a05:6a20:ba93:b0:d9:3e8a:dc48 with SMTP id fb19-20020a056a20ba9300b000d93e8adc48mr1181017pzb.62.1679227269928;
        Sun, 19 Mar 2023 05:01:09 -0700 (PDT)
Received: from [192.168.1.101] (1-160-164-133.dynamic-ip.hinet.net. [1.160.164.133])
        by smtp.gmail.com with ESMTPSA id a23-20020a62bd17000000b005a91d570972sm2298656pff.41.2023.03.19.05.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:01:09 -0700 (PDT)
Message-ID: <652015b6-c2d7-0d97-3a4f-99d26d90f7f7@gmail.com>
Date:   Sun, 19 Mar 2023 20:01:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 15/15] MAINTAINERS: Add entry for NUVOTON MA35
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-16-ychuang570808@gmail.com>
 <d56ec914-c2e4-427d-abc4-a290f3467937@app.fastmail.com>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <d56ec914-c2e4-427d-abc4-a290f3467937@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Arnd,


Thanks for your advice.


On 2023/3/16 下午 10:38, Arnd Bergmann wrote:
> On Wed, Mar 15, 2023, at 08:29, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add entry for Nuvton ma35d1 maintainer and files
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>> +F:	Documentation/devicetree/bindings/*/*nuvoton*
>> +F:	arch/arm64/boot/dts/nuvoton/
> This clashes with the existing entry for NPCM, so
> contributors can easily get confused about where
> to send their dts patches.
>
> I don't have a good solution here, but maybe you can
> discuss this with the npcm maintainers (added to Cc)
> to see how they would like to handle this.
>
> For me, the easiest way would be to have a single
> maintainer send me all the patches for both ma35d1
> and npcm, but that may not be practical for you.


All I can do so far is, once we receive a patch for npcm,

forward it to the maintainers of npcm, and the npcm side

does the same.

And I would like to modify it as

+F:	arch/arm64/boot/dts/nuvoton/*ma35*

>> +F:	drivers/*/*/*ma35d1*
>> +F:	drivers/*/*ma35d1*
>> +F:	include/dt-bindings/*/*ma35d1*
>> +F:	include/linux/mfd/ma35d1-sys.h
> I would replace these with a single line
>
> K:    ma35d1
>
> that should have the same effect.
>
>       Arnd


It's fine. I will use K: instead. Thank you.


Best regards,

Jacky Huang


