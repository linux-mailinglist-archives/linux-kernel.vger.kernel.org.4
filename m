Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DDB6F6676
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEDIA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjEDIAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:00:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B437319B7;
        Thu,  4 May 2023 01:00:21 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6436e075166so180534b3a.0;
        Thu, 04 May 2023 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683187221; x=1685779221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72YRHw4QQ93xVIclFiNgNX/J7ndLff1qiZMWos8BlCY=;
        b=gjXOHhEuhIqPasoFoc9u6rL2o5GiqQ6NRd6DMCN0SKe+GQJUZanrwmgAdjysJ8ShSW
         NVlFECf9Tyx4PUrEbs8Ra7ohUVdupwWPugdeMwQWnPXImlbyRmyNc1kQpGe23qBSqONw
         u4kB2oUcDJj/S6QduG9b+4ubcTenOJawSiKaneKq9lAudf3bilJGgBVf6m9zDYtrm3k1
         iBZHQvwdMc1cvVruP628KGUe+L2Xztg3xTQn1c36F1fHtwcPHlCmgqDbefftVJ9n8YDs
         lINKMV786hqOqUtNerm6zW7G7gtWB64bXjNGuX9tixuqqP5ByHlu5fnLUlPg1tDVfXKG
         osVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187221; x=1685779221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72YRHw4QQ93xVIclFiNgNX/J7ndLff1qiZMWos8BlCY=;
        b=bVFzlF0AwcQ+BKK+pLnP7Pkj7myNAkVtfffQvPHkVTxIB6X80ekBlo+K75/8ovyr15
         uCczzUhkHmfs9xHuKd8Wm2azNu3Zjx85xwFL3wHHOkwCzz7bFqFpMrCszyIDlZojQL94
         IphZdjmw5EPn0R9Z2neKaT67BTj+WcUnXp0UpOszA4r/l4eLGTrQZa2UY9jvkiFI055F
         GR1ugNWm3Es+TnILbYGg53rcq/fDJzRAsL8ERTRApxnSFqYPzHfzliNWuPRyswBAy9e1
         ujEk4sqdVkmKseP+J74viqylj8rKiSoiTammSQAjv8/t/cdzmGJ3S5Ho5ecTPwFriTrO
         nHZg==
X-Gm-Message-State: AC+VfDxko1hNJEs2OSTHWAmHgxSdHD93LmnEroSicxyAW2gTBBZUsm4M
        hA85YH6WBwh6aeVal2fi5IKSrg8ziQwrZg==
X-Google-Smtp-Source: ACHHUZ70+7VKyknxDPc0AmBRRAciFB6F8TIqqUAcNwQvfgXbOd5ZKdoDXw1kdNxlhqG87/aH01LYXw==
X-Received: by 2002:a05:6a21:3a95:b0:f2:ad27:f98a with SMTP id zv21-20020a056a213a9500b000f2ad27f98amr1288460pzb.14.1683187220834;
        Thu, 04 May 2023 01:00:20 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id z2-20020a6552c2000000b0051b3d5543c4sm17337924pgp.30.2023.05.04.01.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 01:00:20 -0700 (PDT)
Message-ID: <1f97c5a6-7c28-8582-a820-c33304a1801c@gmail.com>
Date:   Thu, 4 May 2023 16:00:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v9 01/10] arm64: Kconfig.platforms: Add config for Nuvoton
 MA35 platform
To:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230504033726.93-1-ychuang570808@gmail.com>
 <20230504033726.93-2-ychuang570808@gmail.com>
 <8ce93998-84c3-0640-a6e1-76ff17b3953c@linaro.org>
 <c99babb3-532a-4d00-876c-3c316b456325@app.fastmail.com>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <c99babb3-532a-4d00-876c-3c316b456325@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/4 下午 03:49, Arnd Bergmann wrote:
> On Thu, May 4, 2023, at 08:32, Krzysztof Kozlowski wrote:
>> On 04/05/2023 05:37, Jacky Huang wrote:
>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>
>>> Add ARCH_NUVOTON configuration option for Nuvoton MA35 family SoCs.
>>>
>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>> ---
>>>   arch/arm64/Kconfig.platforms | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>> index 89a0b13b058d..c1f277c05569 100644
>>> --- a/arch/arm64/Kconfig.platforms
>>> +++ b/arch/arm64/Kconfig.platforms
>>> @@ -236,6 +236,15 @@ config ARCH_NPCM
>>>   	  General support for NPCM8xx BMC (Arbel).
>>>   	  Nuvoton NPCM8xx BMC based on the Cortex A35.
>>>   
>>> +config ARCH_NUVOTON
>> Either this should be ARCH_MA35 or you should integrate it with NPCM.
>> ARCH_NUVOTON means all Nuvoton platforms.
> I'd go with two separate Kconfig options here (ARCH_MA35 and ARCH_NPCM)
> for arm64, but keep the shared arch/arm64/boot/dts/nuvoton directory,
> I think that fits most closely what we do on other targets, and there
> is apparently very little sharing of IP blocks between npcm and ma35,
> if any.
>
>        Arnd

Dear Arnd and Krzysztof,

Thank you for your suggestion, it really helped me. We are also considering
whether to use ARCH_MA35. As NPCM and MA35 are designed for different
application areas, it is unlikely that they would be used simultaneously.
Therefore, it would be more reasonable to separate them into ARCH_NPCM and
ARCH_MA35. In the next version, v10, we will change all instances of
ARCH_NUVOTON in this patchset to ARCH_MA35 and keep shared directory 
changed.


Best Regards,
Jacky Huang





