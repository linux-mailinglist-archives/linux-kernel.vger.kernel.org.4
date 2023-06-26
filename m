Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6787173E0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjFZNep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFZNen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:34:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CBAE64
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:34:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fa99b57a38so7284415e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687786480; x=1690378480;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTy4+4mz1Xv+hO2QkRYCxGcmjBnoyskfZ70PBhrVWPg=;
        b=X9FyjOr+9j9nF8uQ6LF0ueEWWm8rvM0Uxko0LNrCZEAVSngWkps7zOAhDW3QqNlzQK
         tTlB97Xgffkm/MyQaHC3bM06xbeHGPCkfWQ4g5afHa0z7C0zWmD6iavKdq29BrlHROCZ
         gwzrC7UzHVdHoYUeCC1b+7KK4pFllrOx5dh2EIWxgp/h2VtKqy4ItNB0q+6ER+iN8MJR
         e4q9d1wuwCJod7asqts7SiN6CcJ27NPNiVwGEDjlqmmPDOcLh7bWF2VSUiJLpkyfc6Cd
         UfOO4LTaBW1OO7peVsa4Rqc6lsTG+97uLymaa0/pBqhy7K9aDrNdRzGJU+dxCBnR8qht
         9vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687786480; x=1690378480;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XTy4+4mz1Xv+hO2QkRYCxGcmjBnoyskfZ70PBhrVWPg=;
        b=QXX+bER28xFD/83BsV1MVJCQ1JUTXvUO9RyeOcy9OlWkIsFlK/GvQKZxwNsM9Q9lQm
         mDcyNjLHDduie0YVDMaS/Qd6puTTWbrR4dItP8Poteva0/INY7vvP7khHAbbCBcRvbSS
         s6+hlncfn+XqO2Ph+U5suGxvFjVohjtvnR+Xw6EVijPoyrzVLcP1YMfimk0LkQXqUl/6
         PW5MQQI4jcycuTpILcsmkpqMAhusvekQD6U7e2CqpPVk9gbmvLxjWD+fxOljbqS6tUCN
         5lkp5AIRmT0/UVv5IJ1bzpJF2rBf+i70htQea7tz36wsRz1MJzCIegggEfLp489sDV6M
         3e7Q==
X-Gm-Message-State: AC+VfDxawsVHPYId7+lWLWZd1BdY7fDwSPNg0h6snTvuwr4LThLVjXMv
        xZLcjuJUZ6K2vxsWuvir2J/D6A==
X-Google-Smtp-Source: ACHHUZ5xQtzeHOpw0ffYUZA/AnEmNgE4fRcdnyVlDsZmROa6fECRMPsqisOS2KcQnrRsrkW/fVqKig==
X-Received: by 2002:a05:600c:24d:b0:3f9:c77c:a5f with SMTP id 13-20020a05600c024d00b003f9c77c0a5fmr10102981wmj.13.1687786480242;
        Mon, 26 Jun 2023 06:34:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b25a:b26e:71f3:870c? ([2a01:e0a:982:cbb0:b25a:b26e:71f3:870c])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bca55000000b003f4248dcfcbsm10667039wml.30.2023.06.26.06.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:34:39 -0700 (PDT)
Message-ID: <c41d2d9f-7ddd-160d-d455-ba4fece7ff93@linaro.org>
Date:   Mon, 26 Jun 2023 15:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     jbrunet@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        khilman@baylibre.com, conor+dt@kernel.org, kernel@sberdevices.ru,
        sdfw_system_team@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleg Lyovin <ovlevin@sberdevices.ru>
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
 <20230607201641.20982-6-ddrokosov@sberdevices.ru>
 <CAFBinCD-5RD_iszZZRg58XqTHDEHnipJkf2aAex8MdUyh=bVCw@mail.gmail.com>
Organization: Linaro Developer Services
Subject: Re: [PATCH v1 5/6] arm64: dts: meson: a1: introduce UART_AO mux
 definitions
In-Reply-To: <CAFBinCD-5RD_iszZZRg58XqTHDEHnipJkf2aAex8MdUyh=bVCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/06/2023 23:07, Martin Blumenstingl wrote:
> On Wed, Jun 7, 2023 at 10:16 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
>>
>> From: Oleg Lyovin <ovlevin@sberdevices.ru>
>>
>> The Amlogic A1 has a UART_AO port, which can be used, for example, for
>> BT HCI H4 connection.
>>
>> This patch adds mux definitions for it.
> In the past we've only taken the pinctrl definitions if we have a
> board that uses them.
> Neil, do we still have the same policy in place? If so this patch
> should be sent with the series that adds support for your A1 board.

Yes and no, if the work is done I'll take it, but yeah since upstream linux
hates dead code, let's only define what's necessary.

> 
>> Signed-off-by: Oleg Lyovin <ovlevin@sberdevices.ru>
>> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> index 0efd922ca7e1..3eb6aa9c00e0 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> @@ -118,6 +118,22 @@ gpio: bank@400 {
>>                                          gpio-ranges = <&periphs_pinctrl 0 0 62>;
>>                                  };
>>
>> +                               uart_a_pins: uart_a {
> Only our newer .dtsi (e.g. meson-g12-common.dtsi) are following the
> pattern where node names should use dashes instead of underscores.
> So please use: uart_a_pins: uart-a { ...

The new scheme which should be use should be:

uart_a_pins: uart-a-pins-state {

but it wasn't enforced in the pinctrl yaml pushed by heiner, but for sure
no underscores in the node name.

> 
> [...]
>> +                               uart_a_cts_rts_pins: uart_a_cts_rts {
> similar to the comment from above:
> uart_a_cts_rts_pins: uart-a-cts-rts { ...
> 
>> +                                       mux {
>> +                                               groups = "uart_a_cts",
>> +                                                        "uart_a_rts";
>> +                                               function = "uart_a";
>> +                                               bias-pull-down;
> Out of curiosity: is this pull down needed on all boards or just specific ones?
> It seems like all other SoCs use bias-disable for the RTS/CTS pins.
> 
> 
> Best regards,
> Martin

