Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96986CD4C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjC2Ig5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2Igz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:36:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2CBBA;
        Wed, 29 Mar 2023 01:36:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ja10so14241369plb.5;
        Wed, 29 Mar 2023 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680079014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvPiX5ci5jR6Qhqc7feloIWYWq1Fjc5rTBladfN4lhU=;
        b=dyUUzHU4tiokOMdzwerinToRc3tjTR+C2f7uSV/CU3B1iLaLkYNetRFJGKuCklbpcr
         YDJlVng+AupMYmc9dPSDC8MbwP7b1CHVPIpSAZe4Wq79d1re6XcParhQr0122TlpfYsN
         Bos+pOP8Umxkk6HMP1V194HvHBUHBgqoyyQY+6mrd/OReaSfmDvS7mNoYuI/8tOahO+7
         qu6v5NuPPEgImIxkPs55rNu6YF57vS+01omcdGFqFAeqV42gowpQ8pzdtBMnhQ4rLEN1
         jAl1U3E3QbkzWUI51bULWKbd2bC/kUWyL7UxJXIlE6tn7JfurpIPrNaSm/hHSa+deKBc
         xnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680079014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvPiX5ci5jR6Qhqc7feloIWYWq1Fjc5rTBladfN4lhU=;
        b=FUpWm71DbbaLrhedojABm6JN979kzLeFxAARurQC19nyGYV6l9shzYKoiHLbsif3Sf
         USmDsebHK+iP7JjtA2/ZJuSJ3yBdbY+1u9xaj2bJgzpTUMfQgXSsj/tHTwsDMYC8+AKX
         AkzKRGoVosmpN9R2L10i98DONcJXin4p4gAwggiruqOYh4ysaCIOykSpjeT/69tNj3CG
         lRt+vycXsJrQE6fLLVyCrHPLK+WVA67msbxhd/NMH3bgX6wwE/oGwW6fChMxUB5K0Yo1
         Lsuqm3AjPgEwHu01XiQiGqZus/zQ10wAxJFWcEDzxAqs+uHFxJGYCAM5B/IZlsEdQBT1
         /XFw==
X-Gm-Message-State: AAQBX9dccCKNgsRQTvpAmB/CxlA27KMcChEZkfJsSQTFLguIQCt4Ochq
        pz1XE0pz0pdHcTnvW5vXtpM=
X-Google-Smtp-Source: AKy350YSk+R2sNpPl1vdd78/1HInutyjP12GZAdtg9vQ9/lJ/EkymFBWgcDnhrLRzz9RZGoi3crlrQ==
X-Received: by 2002:a17:90b:33c7:b0:23d:4ffc:43e with SMTP id lk7-20020a17090b33c700b0023d4ffc043emr18456574pjb.38.1680079014215;
        Wed, 29 Mar 2023 01:36:54 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b00199023c688esm22480280plb.26.2023.03.29.01.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:36:54 -0700 (PDT)
Message-ID: <c2e430ac-c23d-4268-151c-a3a398252382@gmail.com>
Date:   Wed, 29 Mar 2023 16:36:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 08/12] arm64: dts: nuvoton: Add initial ma35d1 device
 tree
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-9-ychuang570808@gmail.com>
 <36f75c71-cf5b-7cbd-8eac-8a8f628d1201@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <36f75c71-cf5b-7cbd-8eac-8a8f628d1201@linaro.org>
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

Dear Krzysztof,


On 2023/3/29 下午 04:21, Krzysztof Kozlowski wrote:
> On 28/03/2023 04:19, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add initial device tree support for Nuvoton ma35d1 SoC, including
>> cpu, clock, reset, and serial controllers.
>> Add reference boards som-256m and iot-512m.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>
>
>> +	gic: interrupt-controller@50801000 {
>> +		compatible = "arm,gic-400";
>> +		reg =   <0x0 0x50801000 0 0x1000>, /* GICD */
>> +			<0x0 0x50802000 0 0x2000>, /* GICC */
>> +			<0x0 0x50804000 0 0x2000>, /* GICH */
>> +			<0x0 0x50806000 0 0x2000>; /* GICV */
>> +		#interrupt-cells = <3>;
>> +		interrupt-parent = <&gic>;
>> +		interrupt-controller;
>> +		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
>> +			      IRQ_TYPE_LEVEL_HIGH)>;
>> +	};
>> +
>> +	uart0:serial@40700000 {
> There is always space after label:.
>
>
> Best regards,
> Krzysztof
>

I will fix them all.


Best regards,
Jacky Huang

