Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2517B6CD1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjC2GCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjC2GCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:02:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36D2270B;
        Tue, 28 Mar 2023 23:02:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bn14so8605230pgb.11;
        Tue, 28 Mar 2023 23:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680069755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5S66T5xiGRrp+k6yG6pN7f3HcV4Qzyahsw1kWjbn/ms=;
        b=C9nQGHQI89wz7pEsdS8kB5OPnWopFfJvvEH8N69Q2aH/FA/hNsnyLaxmdpub9v+6DV
         wgvRe1PiOXa1ZA7IaCGQ0ZpKSY1CQRXqPcbD098T6KCNcQdJw/AviW5GR/pJolachJOa
         HqLN9AxcPrRYZ0cz7EORhGFyHT3nvCnrAk1gaGdZ7JMqRJKr4qkpO9fPngm+VpGvIQgF
         7AC1NQV3bybkhBJ8VEqHfwnSW6erI/NWa8AscmtG9v/H+2jmAqVjHdT8cX8fQdHxOXx/
         5vODse7MdZwvx2/M+uEVh1zXtZ3AC6Rsxk0E45QLJg1SzIwmYNNnnxrn10DiTzVjtvhL
         CZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680069755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5S66T5xiGRrp+k6yG6pN7f3HcV4Qzyahsw1kWjbn/ms=;
        b=UEosJR5orG/vP1DL+AvA3Vx+kvRP+25j6dWeFlPD4Zgkh5okvbptVAsbJETD4vINuF
         LwbER9IIWJ89twxKa3m9j9X0LrVwVGrkOvASP6VU3JVgo+PJcJN5js7p4wLnNoruBxBP
         FuoT1+Ai794TbZa5E4ajp8/4g3EAjawiLTrABQcioaMBduQqxXMxUkctj9cxPfnvgpvL
         f8BDZsIF7yRzt0ZJpc2GEj60f/VDMLSFDuWixRqru+tKk3zxb2O7zB+33Pu5cKdCeZ/Z
         OEGvR+KSFJIysnuqG/VHiwD0KJJ8YDIf0W/unv5Ol+UlOMg3wXYsucb3yTdpytxM5EEl
         uU4Q==
X-Gm-Message-State: AAQBX9c4MLsWx1iF2Rjv0dNP3GREjw2kzuhYrUuNEO0m2F7ogc6YUHFS
        NggEwKJcvAV6a1QACnA2YEM=
X-Google-Smtp-Source: AKy350YjNy/Q7ECDuqYmvGOKnhXCgoAs8eeoC6LCoZSHHovOU2/n+F3FgUji1bCT2Z+Os2dWGkKRrw==
X-Received: by 2002:a62:648d:0:b0:624:fb23:c4df with SMTP id y135-20020a62648d000000b00624fb23c4dfmr16232240pfb.16.1680069755247;
        Tue, 28 Mar 2023 23:02:35 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id e12-20020a62ee0c000000b005d866d184b5sm21934401pfi.46.2023.03.28.23.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 23:02:34 -0700 (PDT)
Message-ID: <458d454e-64ba-849a-38cb-88bf016f5a2e@gmail.com>
Date:   Wed, 29 Mar 2023 14:02:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 08/12] arm64: dts: nuvoton: Add initial ma35d1 device
 tree
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-9-ychuang570808@gmail.com>
 <ab4e0bc8834b7e618e9a88ea6a1c30cc.sboyd@kernel.org>
 <b7977069-4f82-76a1-10c1-b6400862c2c4@gmail.com>
 <c37e1f3a40c404acd81c2c9d5b28b340.sboyd@kernel.org>
 <129cf4b6-b3b5-2a12-5911-37e70a624812@gmail.com>
 <e5221cd020bc60513df6a1c1859e1acc.sboyd@kernel.org>
 <ad908782-8291-4240-d88e-61dff5a05ef7@gmail.com>
 <1d379f28f54fd025f687bfcb71e4bae5.sboyd@kernel.org>
 <dd7940fd-bf63-552c-6e2e-05eff5fdb636@gmail.com>
 <b816411c301e2b3afe9c3df36728f946.sboyd@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <b816411c301e2b3afe9c3df36728f946.sboyd@kernel.org>
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

Dear Stephen,



On 2023/3/29 上午 11:54, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-03-28 20:43:23)
>> On 2023/3/29 上午 11:25, Stephen Boyd wrote:
>>> Quoting Jacky Huang (2023-03-28 20:13:11)
>>>> I may not explain clearly enough. The lock/unlock register of system
>>>> controller is more like
>>>> a kind of write protection for specific registers, rather than
>>>> preventing hetero-core CPU access.
>>>> In many different IP of ma35d1 contain write protected registers.
>>>> In fact, ma35d1 has a "hardware semaphore" IP, and we have implemented
>>>> the driver in drivers/hwspinlock.
>>>> Even the control register of "hardware semaphore" is also write protected.
>>> What's the need to lock and unlock the registers? Is some other
>>> processor also writing to the registers that we need to synchronize
>>> against? Or is Linux the only entity reading and writing the registers?
>>> I'm wondering if we should simply unlock the registers and never lock
>>> them.
> Can you answer this question?

Sorry, I miss this.
The lock and unlock register mechanism is a hardware design of ma35d1 SoC.
The purpose is to prevent from unexpected write to some registers.
However, I think this is a redundant design if s/w is done properly.
Even though I think it's a redundant design, it's out there and we have 
to deal with it.
And of course we have unlock and lock pair, I just lost to write in the 
above.

>>>> So, should we implement a system controller driver to provide
>>>> register_unlock() function?
>>>> Is it OK to have such a driver in drivers/mfd?
>>>> Or, just use syscon in device tree for those devices that have write
>>>> protect registers.
>>>>
>>> The hwspinlock framework doesn't require there to be another entity
>>> accessing some resource. It's there to implement hardware locks. I don't
>>> see why it can't be used here.
>> The current usage of register lock/unlock protect is as the following code:
>>
>> static void ma35d1_unlock_regs(struct ma35d1_clk_pll *pll)
>> {
>>       int ret;
>>
>>       do {
>>           regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x59);
>>           regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x16);
>>           regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x88);
>>           regmap_read(pll->regmap, REG_SYS_RLKTZNS, &ret);
>>       } while (ret == 0);
>> }
>>
>> static void ma35d1_lock_regs(struct ma35d1_clk_pll *pll)
>> {
>>       regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x0);
>> }
>>
>> And the following code is to unlock registers for write and then lock again.
>>
>>       ma35d1_unlock_regs(pll);
>>       writel_relaxed(reg_ctl[0], pll->ctl0_base);
>>       writel_relaxed(reg_ctl[1], pll->ctl1_base);
>>       writel_relaxed(reg_ctl[2], pll->ctl2_base);
>>       ma35d1_lock_regs(pll);
>>
>> The above code is from the clk-ma35d1-pll.c from this patchset.
> Yeah I understand that you write some registers in the syscon to lock
> the registers.
>
>> We just employ regmap mechansim for the access to REG_SYS_RLKTZNS register.
>> Is this implementation OK for you?  Thank you.
>>
> No. Why can't that be a hwspinlock? Or why can't it be unlocked all the
> time and rely on software spinlocks in the kernel to prevent concurrent
> access to the registers accessed by a driver, like a lock for the clk
> registers and a lock for the reset registers, etc. Or if no two clks or
> resets exist within one 32-bit word then no lock is necessary.

You gave a good suggestion here. Yes, of course we can let it be 
unlocked all the time.
We can unlock the "register lock" before entering Linux.
As a result, the unlonk and lock register related code is not required.
Thus, we can remove syscon from the clock controller node.

If you agree with this, we will modify it in the next version.


Best regards,
Jacky Huang




