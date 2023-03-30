Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07836D0175
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjC3Klt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjC3Kls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:41:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA3D30ED;
        Thu, 30 Mar 2023 03:41:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y19so11026166pgk.5;
        Thu, 30 Mar 2023 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680172906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y00m8j6bhaRFNazNn6TR2L80FBRnlau/Qmj0Aw4/co4=;
        b=GfXoIBR3Pol/d3wp6vhpa7txpLy+g1N7m+USlyUHFZXtIrIdNQAyHIiAdCyGt/iqzK
         RrdqxB2tb/3Ri92bxCG6hbJ1nNDZovaBsx2CQJG5cwLLNsWqHzYXseiQ2lQwKegQUh8P
         +JdpsNBoMUY+lxo5KZGhAo0B/SzAlSP+LFBs/r2sBmxnhcorK8VbgLHREnXZobmdGYSM
         vEpU588NTfjtBs8FBl9aDr4MS/b4YIuwTT1JGjsjaMpmMqb5ZvMkUscvOB3z3V7QYdNx
         yhz3Q0yEfiGf4FSwrQl5VUq9aYRfy0/DWoy8yDG54OCMz5tuVs8M5kWXucmG+Ti5OBjW
         MgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y00m8j6bhaRFNazNn6TR2L80FBRnlau/Qmj0Aw4/co4=;
        b=gK7poVm05rWAKM6C4xc2BqrL88iM8JSKTpa7RrRZkyOzqOX+SGBenikltFMtz6yEbE
         PDcar0y61AHhnYKvTdQW3hPnI7t56rmL3YJvCe1mdZaVq9mvlOuDeRU8Cxztsz8HyKD8
         qxSKux5tw5FWggPNjfaOhWPcDBdbmGUkg3wpXKieilVmcn6j47jXzDChNizMDXIpozRQ
         9qMYCSB4e1KWSMfgHp8nYt7O35whVKbvA+ZW0TkiOf+pyd/7vBIDUFLTGOzxfOg37/yY
         5mJLvZs5l21UCfkGdaLrMMdnUEXGmFd+1WXSPHNtDtePyMcY/kRwmA3FFDz1BSvywH7P
         x46g==
X-Gm-Message-State: AAQBX9cZ7zIyQrxJ/MohXqvuwE4yvanHIbmCVyTV9rAE05UZqCcj0x8j
        6g6BmgxlOkB5WMGNodjKE8Y=
X-Google-Smtp-Source: AKy350ZqB7nqahC4v+AdbHD0yZfZ33/IBhAKmRzQFiajLfY/Dk+B4pOJgmsQa/o1hNYtNieE7a4ovg==
X-Received: by 2002:aa7:971c:0:b0:625:7acb:bf0e with SMTP id a28-20020aa7971c000000b006257acbbf0emr21175803pfg.19.1680172906536;
        Thu, 30 Mar 2023 03:41:46 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79188000000b0062622ae3648sm24449070pfa.78.2023.03.30.03.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 03:41:46 -0700 (PDT)
Message-ID: <a497eb9c-8279-d4e9-3b8d-537ffa1f7522@gmail.com>
Date:   Thu, 30 Mar 2023 18:41:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 06/12] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-7-ychuang570808@gmail.com>
 <CAL_JsqKrrWyOKGUAaT-8r-nKvtS5f_gHAhE5=XaXuGtuYC2gCw@mail.gmail.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <CAL_JsqKrrWyOKGUAaT-8r-nKvtS5f_gHAhE5=XaXuGtuYC2gCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rob,


On 2023/3/29 下午 09:07, Rob Herring wrote:
> On Mon, Mar 27, 2023 at 9:19 PM Jacky Huang <ychuang570808@gmail.com> wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Rename the bindings/arm/npcm directory as nuvoton.
>> Add binding for ARMv8 based Nuvotn SoCs and platform boards.
>> Add initial bindings for ma35d1 series development boards.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>>   .../nuvoton,npcm-gcr.yaml}                    |  2 +-
>>   .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>>   3 files changed, 32 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
>>   rename Documentation/devicetree/bindings/arm/{npcm/nuvoton,gcr.yaml => nuvoton/nuvoton,npcm-gcr.yaml} (93%)
> Since you are moving it, this one should be moved to bindings/soc/nuvoton/
>
>>   rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)

OK, I will move "Documentation/devicetree/bindings/arm/npcm" to
"Documentation/devicetree/bindings/soc/nuvoton".


Best regards,
Jacky Huang


