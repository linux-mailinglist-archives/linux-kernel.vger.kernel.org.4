Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F66EBF9A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjDWMxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjDWMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:53:03 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5962B10D0;
        Sun, 23 Apr 2023 05:53:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-5058181d58dso5970371a12.1;
        Sun, 23 Apr 2023 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682254381; x=1684846381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iytNL3ionK0y40hikstW/BCZlPf3T/1Wm7ZwrV0sJlw=;
        b=mxFY2HrILM2cerTaYDSv71GR+WQ2TxeE3y9At9pEM0MB96S0zeycHmvj5b2o2Nyfah
         8Hl6doywdvO32gzAWuXTOUT7U2gYPyaTtw08w4VvSPX7Ciu6zck0aaLKatWWicqz0szb
         IRmEldsEp1zTkz495xH/zXysU/vFiKUiGzyvNn7aSQE7K0RkI0v9udqJrqic2TQ2bNwn
         cZcriicgvgEM8HKLukppbCVWxS5Wztoc8HBi9T6Hpy8HogBf7Dg3UEEfv1/j8RSxD1GD
         S2VJGecIOyRBelHB9ALxDbN5CJd5KkrmJEWVjCMVNimtYnhkWEcLruPlcm57ib1JZTC1
         Cjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682254381; x=1684846381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iytNL3ionK0y40hikstW/BCZlPf3T/1Wm7ZwrV0sJlw=;
        b=HwVlsVKpHYSVNm7yqFgG+1kXXHQzQCQsYHt3X13aKd+lvpjVAIE1FGo00XVvLVKKcF
         Cf4GtwMpNteY3p0El13f6u1JdK3nm5P5uBJc9wuxFfkj359cB+5FqHNvzkQvDijIbxrk
         PCHEYFNnxq9uYG3vK5bm+HIBOb/yMfmY8gavF7hizcN4jOez/suFDslH+yMBiWhhBCGz
         pojp5xJMhurlbcTA2iAtLnaqtbUgLGdnaRQ076U6rFcWgzk3B64OXTKLLExKWi1ASWka
         jHgwNQ6YVmaXDmWkUdlOWlAhNm56cMjZXxkUQwtJRMRX+fE/OKLOPkgh5iX85aRAYHfb
         zqUg==
X-Gm-Message-State: AAQBX9frco1oStuokQmgCdyJreA1J/fWUoFKK6W4Yg9jvzSQKgX+Lp9k
        uZFBKGkgkoKynOkuN8sDwSo=
X-Google-Smtp-Source: AKy350bSWYI/SvP558yd57KKjIp5PRfYPqiEM6lRUyYP8OmlVk45UlwzWUqDELXx4SoaZLUxhRnKcA==
X-Received: by 2002:a05:6402:641:b0:504:921b:825 with SMTP id u1-20020a056402064100b00504921b0825mr9276422edx.36.1682254380636;
        Sun, 23 Apr 2023 05:53:00 -0700 (PDT)
Received: from [192.168.50.244] (83.11.224.11.ipv4.supernova.orange.pl. [83.11.224.11])
        by smtp.gmail.com with ESMTPSA id i21-20020a05640200d500b00501d73cfc86sm3847476edu.9.2023.04.23.05.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Apr 2023 05:53:00 -0700 (PDT)
Message-ID: <c717e975-092a-5090-89de-ec08237388a3@gmail.com>
Date:   Sun, 23 Apr 2023 14:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 12/12] ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0
 boards
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
 <20230416133422.1949-13-aweber.kernel@gmail.com> <ZEBN2AciChG03FpM@L14.lan>
From:   Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <ZEBN2AciChG03FpM@L14.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/04/2023 22:23, Henrik Grimler wrote:
>> +	memory@40000000 {
>> +		device_type = "memory";
>> +
>> +		/* Technically 2GB, but last 1GB is flaky, so we ignore it for now */
>> +		reg = <0x40000000 0x3FC00000>;
> 
> Comment says 1GB but you are skipping 1GB+4MB.  Is the entire region
> flaky or perhaps just the 4MB region in the middle?

I copied the memory bank configuration from downstream: according to
boot logs and ATAG data from the stock bootloader, there are two memory
regions: one starting at 0x40000000 (size: 1020M) and one starting at
0x80000000 (size: 1024M). Here, only the first bank is added, since the
second one doesn't work.

I tried changing the size of this first bank to the full 1024M, and it
seems to be booting fine; still, I'd rather leave this at the same size
as claimed by downstream and ATAG.

The second memory bank (anything past 0x80000000) doesn't work, as
downstream has some weird special behavior regarding it: that region
contains "page holes", and there's a check that discards every second
page frame in that region[1][2]. That also means my comment is incorrect
- indeed, 2GB of memory are passed to the kernel, but the second 1GB is
effectively halved, leaving us with 1.5GB. (That's an oversight on my
part - I wasn't aware of this when writing the DTS initially, and only
checked this more in-depth now.)

I'm not sure if there's a way to re-create this behavior in mainline;
the closest thing I can think of is making a separate entry in reg for
each of the working pages, but that would leave us with hundreds of
lines, which is not ideal... so it's much easier to just leave it unused
for now.

Best regards
Artur Weber

[1]
https://github.com/gr8nole/android_kernel_samsung_smdk4x12/blob/786b1473b93aabf40c18a2dca035503cce5ecac7/arch/arm/mm/init.c#L413-L414
[2]
https://github.com/gr8nole/android_kernel_samsung_smdk4x12/blob/786b1473b93aabf40c18a2dca035503cce5ecac7/arch/arm/mach-exynos/include/mach/memory.h#L30-L38
