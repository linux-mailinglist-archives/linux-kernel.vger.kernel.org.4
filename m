Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43866BE4E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjCQJGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjCQJGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:06:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85023B1B3E;
        Fri, 17 Mar 2023 02:05:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d13so4473577pjh.0;
        Fri, 17 Mar 2023 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679043904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QX2XZwWz7YJVp28nkiAFRa3YDgRjaTUhSz6LKfDtyiA=;
        b=ltwRrOIwgxe/ygDpCrI+lISFDpB94cBuDvk4QnYhyD0ld8dQZOReapD1MGWD1BYu0u
         0LhKqjvpA1HvFdtw83xS1gd8zGAiyvNujHJDoC7DqJ+ox2/ubmzBztuPgYQ8J4lWsqsV
         cOiFIEt82KAmUNmwbKRdWguhIMH9phiIMPo9VVKh8AjPm8fMVTn2mWyKsc2pQ48A7YE2
         I6wfcnEz4Q6YSRYtfZTlAUQU0UzGf+YU7PMz0zOfazODy7FO9zmDit/8XBLLbgQ5YAuQ
         0ej+iXdBkjmZXZ3KCH6cPQhbFTHuoO1fdUqiMzarXLzWGo7/bYRkyCPdPD3Lw7dMIfKR
         5c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QX2XZwWz7YJVp28nkiAFRa3YDgRjaTUhSz6LKfDtyiA=;
        b=FwMoeTHWlE721ekTOxgFGSfbiK8DiyhoxS4sU/YvtHIwTnW3MGcAXoZmgWdHHWgJQ+
         zmvbFphphUe6uX6Nl+ltfhaaEKbcrCrp9ZzGYCWasw75z+iv985Zu9kRHo/a1DBtIyWZ
         Bxe5VdEa+s3RHsvNnfQx17Sn3uZgZJBjejf9Etx/R8mUOaOKd8hmiFC58ZlwaeJAyywL
         S4csslmZsY9VdLjdC9zFtFrqud3l2YjURCM/cX9gNxRdhcwzH0QffeHoLX0BJ3LVIWwA
         vcXH9kmWYZkiMenmqGjiJ9Yi/fho6JYKuoiVg4I1at5YDmmiMBlMdmweWUmd2QfcwIzn
         QoAg==
X-Gm-Message-State: AO0yUKXk/SZM2FCDJcEN5VxIywXcpADO3HdhBr/p7Vwv6xK9JIMd7dU1
        B07xxEq557lqBwqC2kZAplA=
X-Google-Smtp-Source: AK7set9a65EBPVyz+AO2HaViA43JOsoHIciGp+Ovxbm0iISW7nsDtyTzfHt5j1HBUuUVOn1wz3R8Qg==
X-Received: by 2002:a17:903:1112:b0:19d:f7e:9864 with SMTP id n18-20020a170903111200b0019d0f7e9864mr7502967plh.57.1679043903853;
        Fri, 17 Mar 2023 02:05:03 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c3c300b001a072be70desm1082569plj.41.2023.03.17.02.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:05:03 -0700 (PDT)
Message-ID: <2ae442f2-8f9a-29da-63fa-9b32858e3789@gmail.com>
Date:   Fri, 17 Mar 2023 17:05:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/15] arm64: defconfig: Add Nuvoton MA35 family support
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-3-ychuang570808@gmail.com>
 <44c5fe37-be74-4fb1-802a-8cf8c813ec96@app.fastmail.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <44c5fe37-be74-4fb1-802a-8cf8c813ec96@app.fastmail.com>
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

Hi Anrd,

Thanks for your advice.

On 2023/3/16 下午 10:23, Arnd Bergmann wrote:
> On Wed, Mar 15, 2023, at 08:28, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Enable basic drivers for ma35d1 booting up support: architecture,
>> device tree, clock, reset, and uart.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> The description does not seem to match the actual contents,
> which only enable the platform but none of the drivers.

I would like to rewrite it as:

arm64: defconfig: Add support for Nuvoton MA35 family SoCs

This adds support for the Nuvoton MA35 family SoCs which
are based on the Cortex-A35 Armv8-A 64-bit architecture.


> It's ok generally to enable options in the defconfig file
> before you add the drivers, but if it's all part of a patch
> series, I would probable more this bit to the end.
>
>       Arnd

Best regards,

Jacky Huang

