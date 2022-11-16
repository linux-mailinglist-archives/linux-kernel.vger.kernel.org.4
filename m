Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBDA62B593
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiKPIvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiKPIvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:51:14 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA711A05D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:51:13 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id d3so20947524ljl.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16W+WhRYw2qO31HAZVLt3mv3/qC3AjEWZLnL5iEaKNw=;
        b=E/eIyOzpn4tkTNxnGMFFoQYJH4B0F+2EkASmXoGGnp0TON6UlNT4E62dHdhJcPkyTl
         gTsTfb4lslvmv9HrRS46q0wDd3YlWja541Jv7XiZo2sAm7pvnPWMBFeg/QFv34JOZ0I5
         E3CGyZ4T45NkaNSS3ORtC/aHMfgf7gkreKrbYW0XWmCZxDtQ5js7ZGD3JdqzqvtPIubt
         rxk8wlN52PBtx1bf1tn99wUhlLUw/yGzm56OH3KM7uxH+mBE0caeuoik58wWkIJoq3E/
         CjSp9onVDgRefhG+vY8fgNEsfnBY2N4vYl4zljUul7jM66pHXgNhxzA/spMqzD5fzDV+
         UhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16W+WhRYw2qO31HAZVLt3mv3/qC3AjEWZLnL5iEaKNw=;
        b=7uCFq/jSFmxB/pEGIMWPoGMRD3di5l1BiL2F9Z93H7DcUZpjg/qhpP0Rkm2qRO6AU6
         wjigBs+wUhq+1oiaSU8lKqncBsUBg8gHhcLnrZ9E2ci8Dph0xT1q4jWrDtKoiTaJ8Rbk
         p0lM8IfCvIrE8iWaouPLA1z8IJ06TniDfF9FKN3om0LhVzTvbo9GVhIbDS5pijJhmXgd
         xdNVIz/xL/gs/wEUOvBA5YhnilMBro0Pn00kd9tpoYXhLx7V956XNyxuMnC64yUgguxo
         B0tjV+Js5ZcnLm3HxXLrlLourcF+BobLD+kutj3VYQ4B50EOwwUPtfZfPlVu+Mlnl9B4
         GLnA==
X-Gm-Message-State: ANoB5pnuZ9wGNwwVkkYVjg2VzYe06CBm5BIctVV8hIsTKzd1Ce3PE4lk
        swneq4TdfECBXEThn6gXxewlKdsjYuaJytXd
X-Google-Smtp-Source: AA0mqf4HK9tHUA7GTdHjmreR9R0RVHvQFj1mBQwdl6HN86KkMOofMEERzF1AQ7Y+70Nt//u6fsBn4A==
X-Received: by 2002:a2e:b5b6:0:b0:277:394:34e with SMTP id f22-20020a2eb5b6000000b002770394034emr6798698ljn.18.1668588672098;
        Wed, 16 Nov 2022 00:51:12 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q9-20020a2e84c9000000b0026dced9840dsm2820895ljh.61.2022.11.16.00.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:51:11 -0800 (PST)
Message-ID: <451f71d7-f921-e0ac-75bc-5e42db4bd200@linaro.org>
Date:   Wed, 16 Nov 2022 09:51:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dtbindings: clock: Add bindings for Renesas PhiClock
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alex Helms <alexander.helms.jy@renesas.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        geert+renesas@glider.be
References: <20221115192625.9410-1-alexander.helms.jy@renesas.com>
 <20221115192625.9410-2-alexander.helms.jy@renesas.com>
 <e9fd112f-0fd2-e833-8687-9a256c307842@linaro.org>
 <CAMuHMdX-tziOhCLi-_s_MjPcHr4OW9=xA9xDVgf+fUya1R6TzA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdX-tziOhCLi-_s_MjPcHr4OW9=xA9xDVgf+fUya1R6TzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 09:34, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Wed, Nov 16, 2022 at 9:20 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 15/11/2022 20:26, Alex Helms wrote:
>>> Add dt bindings for the Renesas PhiClock clock generator.
>>>
>>
>> Subject: drop second, redundant "bindings"
>>
>>> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
>>> ---
>>>  .../bindings/clock/renesas,phiclock.yaml      | 81 +++++++++++++++++++
>>>  MAINTAINERS                                   |  5 ++
>>>  2 files changed, 86 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml b/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
>>> new file mode 100644
>>> index 000000000..2b36534d3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
>>
>> Filename based on compatible.
> 
> Looks like there are more of them, so I guess the family name is fine?
>

If you are sure, then yes. Can we add them now? If not, it's also fine.

Best regards,
Krzysztof

