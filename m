Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA6473A13F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjFVMwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjFVMwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:52:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D98519AF;
        Thu, 22 Jun 2023 05:52:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3129c55e1d1so663221f8f.0;
        Thu, 22 Jun 2023 05:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687438358; x=1690030358;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Gd2rN+LYgXaVXhDv5TDP/9OSYFS9BOQ/d4mluuIDQQ=;
        b=W1SASCkJJx2JO4wmg5Y6XkrTiXnrIUmpqlOoiFo3KS15TLJ6H/xk0vQ4Hm0HZkO68F
         GDlJbHZ7dKmp82vgwqfoPTjib2LdB9lTTD/5o8RWM3YvcTatPyqdhuOOhQindOKs5EGr
         K4wZgoIMzmQywDiTJhxSJ4yHq8rCaNFppDdMrqRXs1DsEDzETwMgpd5i1M3rFyjrHch7
         F5jFUvcWPTGXsPdoH7lmjFhSHFNs5cqtfyShsm84McHFcCsMYwCkGCyFboY44d8iO8QB
         OdX8UgmKwO0u3cGc5ulLlNWdMonv+t7d5Eu1ytR7gpP7IOceNDZX69hdNYHkQyCmukPc
         8eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687438358; x=1690030358;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Gd2rN+LYgXaVXhDv5TDP/9OSYFS9BOQ/d4mluuIDQQ=;
        b=FD/O3GEY+CYpxYifcZAXmkYsvdyv2o+gus3txksbxoIExDqhCFdjqd4OmH+8TAaSG5
         2L/syDw+cGx/+sNqFk/oJCp3UzY8MuQghwDefvEFieFVOB7GNFUyrZQAen65ky7HBVQr
         iF78kleS19zY6bfurd0E/gz2fsKOQOsJS6fiDsD2Y5svNESKah6AzVUcBZt5aUZufbcT
         k2K+cicAWKZw4B3cx8Y+QfMzUz1smuV5Vkq293//cVMFyv2M7cdbvgcjjZohCg93sC0X
         u4CLBn/Zp5WsL6sKvLHszWFO9zDu0Vk2Hkxc7Nh+gl1qB+OvI6Z1RVVC2h58wLS6osQx
         mUuQ==
X-Gm-Message-State: AC+VfDybm01i0RB/vcbrqHZqyzhEfjztY1DvOzK5K6tLuuDFwdAYBgKH
        U4LJ3zIbHLA0qJ4R8Yixuio=
X-Google-Smtp-Source: ACHHUZ7ZYlmGLpIp0K2LCIOaOUR7YxW9hjMU9sBUEZ4cRW5uMjQdIBs4ZoVUvmJM6BFMi/rCW1clng==
X-Received: by 2002:a05:6000:1191:b0:30a:b147:69db with SMTP id g17-20020a056000119100b0030ab14769dbmr17036899wrx.24.1687438357849;
        Thu, 22 Jun 2023 05:52:37 -0700 (PDT)
Received: from [192.168.50.244] (83.8.116.77.ipv4.supernova.orange.pl. [83.8.116.77])
        by smtp.gmail.com with ESMTPSA id g3-20020adff3c3000000b0030e52d4c1bcsm7017073wrp.71.2023.06.22.05.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 05:52:37 -0700 (PDT)
Message-ID: <72af054e-e82b-917c-1f9b-fe231dcfa5bf@gmail.com>
Date:   Thu, 22 Jun 2023 14:52:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH v4] ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0 boards
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230604165627.16963-1-aweber.kernel@gmail.com>
 <aae10e8f-b4f2-7417-ab08-41d6ec9ab8fc@linaro.org>
Content-Language: en-US
In-Reply-To: <aae10e8f-b4f2-7417-ab08-41d6ec9ab8fc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2023 21:15, Krzysztof Kozlowski wrote:
> On 04/06/2023 18:56, Artur Weber wrote:
>> +/*
>> + * This device does not use the built-in RTC; instead, the RTC in the
>> + * S5M8786 PMIC is used instead. Remove the unused node to avoid DTB check
>> + * warnings.
>> + */
>> +/delete-node/ &rtc;
> 
> This is not the solution. The S3C RTC is there. Just like all other
> boards we have two RTCs and DTS should be complete. Definitely you
> should not remove something just because there were warnings. Instead
> warnings should be fixed.

The problem is that the built-in RTC does not seem to work on this
device. I attempted to add it, using the same clocks as other devices
in mainline using the S5M8676 PMIC:

&rtc {
	status = "okay";
	clocks = <&clock CLK_RTC>, <&s5m8767_osc S2MPS11_CLK_AP>;
	clock-names = "rtc", "rtc_src";
};

However, it just prints the following on startup:

 s3c-rtc 10070000.rtc: rtc disabled, re-enabling
 s3c-rtc 10070000.rtc: registered as rtc0
 s3c-rtc 10070000.rtc: hctosys: unable to read the hardware clock

Since the internal RTC gets registered as rtc0, it's used as the default
by the OS, whereas the working RTC from the PMIC is registered as rtc1.
Writing to the internal RTC succeeds but the settings are not kept after
a reboot. The PMIC's RTC works fine.

This isn't a mainline-only issue; the internal RTC does not work in the
downstream kernel on this device either.

Not adding the RTC node results in a warning about missing clocks
(exynos4.dtsi only provides 1 clock, whereas bindings require 2):

arch/arm/boot/dts/exynos4212-tab3-3g8.dtb: rtc@10070000: clocks: [[5, 346]] is too short
	From schema: /mnt/linux/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
arch/arm/boot/dts/exynos4212-tab3-3g8.dtb: rtc@10070000: clock-names: ['rtc'] is too short
	From schema: /mnt/linux/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml

...which makes sense, since we don't want to add clocks given that we're
not going to be using this RTC. I suppose deleting the node with
delete-node is a bit too destructive though.

I guess a good solution would be to set up the &rtc node as seen in
the snippet I sent earlier, but keep it disabled + add a note explaining
why it's done.

In your opinion, what would be the best solution?

Best regards
Artur
