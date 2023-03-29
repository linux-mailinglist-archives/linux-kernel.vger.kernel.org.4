Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EE46CD0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjC2Dnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjC2Dn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:43:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E6726AE;
        Tue, 28 Mar 2023 20:43:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x15so12852322pjk.2;
        Tue, 28 Mar 2023 20:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680061407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soG9eYjjcuk6jHFsZa0MUpEJRHIUPwf3g8BAZmaZsrI=;
        b=g2RVALlqxyQux/zo4fYq3WFduUHbREsD+BOa9gOCxF8wu4O+IVUTTBXRkD7SuSKVEA
         1IDVpNQ+eKEIoMEheL/hQ66BD1p1AHudCM3LxAVc0gMnZerjuLWhATZCFJwpWLEe2QGr
         cv9FBSaC/6G8Rz/aA+yjshk5sB6bxlhgAtDGoYR/DzkndOSlWLkRFwbLOKsvtzwddhbH
         5I85+kZhuwK6Fb5kmzizBlvnCe2498fra4cVDnttt7cXae1MHCo+PYh+xN0+oL2n2Ft0
         y7MJZyUadk1htFGUR81dcwqfHewie0UM/PxBLaE6CWCCH/SnJiHTMVpPDuKfd4MvmzCS
         ttow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680061407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soG9eYjjcuk6jHFsZa0MUpEJRHIUPwf3g8BAZmaZsrI=;
        b=1MBCAtfxhFRZugwcrxpBezSL+8bXDnKk3NYvBcsaRoA+jI7Ebeti3lw9XEew1bKRbj
         osZzUOd9CAgFxL3lY2/qyyK0e1Ik/YFj7CeKpamLgh+tO9iJ37RZQaJMJSs/j8L7FilI
         PcYzj/4TTrGdbfpDwgGS24+xwaodDjZcYvuQIol6wIrwuJ7xqI34YYQL52jYJcqwRhbr
         jL9dpCas+0nxuF70/cxTko+NHCgwSJkVuHQKhmTI+wZXHYd/JrSyTYhxw2HWyCbD8diA
         xUNbbp3bpBB2bXXh8fHU722HBCht5YZFS8RDGL/ueeUYZ+ZdzyNL6LwoWh/4IbK+srqu
         Dwxw==
X-Gm-Message-State: AAQBX9cUta9LW9fQvEJB3gMzPiS/MuOh1EbBJFE0197VscwDHRsDPiqJ
        sQ8tONLKtB2b2/c0y01xqd7GN/Rrns3bWA==
X-Google-Smtp-Source: AKy350YQDXOYq2OazIZgXbDCaAi8Ezr6eYbEvK1XyNQL+gwr1QyasH6DYugsoQUJNQ11QYBmIzSEtw==
X-Received: by 2002:a17:902:f693:b0:19e:6bc5:8769 with SMTP id l19-20020a170902f69300b0019e6bc58769mr18091079plg.69.1680061407022;
        Tue, 28 Mar 2023 20:43:27 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709026b8500b001a1aeb3a7a9sm20543164plk.137.2023.03.28.20.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 20:43:26 -0700 (PDT)
Message-ID: <dd7940fd-bf63-552c-6e2e-05eff5fdb636@gmail.com>
Date:   Wed, 29 Mar 2023 11:43:23 +0800
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
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <1d379f28f54fd025f687bfcb71e4bae5.sboyd@kernel.org>
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


On 2023/3/29 上午 11:25, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-03-28 20:13:11)
>> Dear Stephen,
>>
>>
>> On 2023/3/29 上午 10:46, Stephen Boyd wrote:
>>> Quoting Jacky Huang (2023-03-28 19:39:36)
>>>> On 2023/3/29 上午 10:19, Stephen Boyd wrote:
>>>>> What do you use the syscon for then? The clock driver must want to use
>>>>> the syscon for something, implying that they are the same device.
>>>> The register lock mechanism is applied to protect many critical
>>>> registers from false written.
>>>> The register lock control register is one register in system controller.
>>>> Some registers of the clock controller are lock protected. Not only
>>>> clock controller, but other
>>>> IP such as RTC, PWM, ADC, etc, also have lock protected registers. All
>>>> these IP requires
>>>> syscon to access the lock/unlock control register in the system controller.
>>>> That's why we add a <&sys> to the clock controller.
>>>>
>>>> Should we implement a ma35d1-sysctl driver to protect register_lock()
>>>> and register_unlock()
>>>> and export to those drivers?  If yes, we can remove the <&sys> from
>>>> clock controller.
>>>>
>>> You can implement the lock and unlock in the hwspinlock framework. See
>>> drivers/hwspinlock.
>> I may not explain clearly enough. The lock/unlock register of system
>> controller is more like
>> a kind of write protection for specific registers, rather than
>> preventing hetero-core CPU access.
>> In many different IP of ma35d1 contain write protected registers.
>> In fact, ma35d1 has a "hardware semaphore" IP, and we have implemented
>> the driver in drivers/hwspinlock.
>> Even the control register of "hardware semaphore" is also write protected.
> What's the need to lock and unlock the registers? Is some other
> processor also writing to the registers that we need to synchronize
> against? Or is Linux the only entity reading and writing the registers?
> I'm wondering if we should simply unlock the registers and never lock
> them.
>
>> So, should we implement a system controller driver to provide
>> register_unlock() function?
>> Is it OK to have such a driver in drivers/mfd?
>> Or, just use syscon in device tree for those devices that have write
>> protect registers.
>>
> The hwspinlock framework doesn't require there to be another entity
> accessing some resource. It's there to implement hardware locks. I don't
> see why it can't be used here.

The current usage of register lock/unlock protect is as the following code:

static void ma35d1_unlock_regs(struct ma35d1_clk_pll *pll)
{
     int ret;

     do {
         regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x59);
         regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x16);
         regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x88);
         regmap_read(pll->regmap, REG_SYS_RLKTZNS, &ret);
     } while (ret == 0);
}

static void ma35d1_lock_regs(struct ma35d1_clk_pll *pll)
{
     regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x0);
}

And the following code is to unlock registers for write and then lock again.

     ma35d1_unlock_regs(pll);
     writel_relaxed(reg_ctl[0], pll->ctl0_base);
     writel_relaxed(reg_ctl[1], pll->ctl1_base);
     writel_relaxed(reg_ctl[2], pll->ctl2_base);
     ma35d1_lock_regs(pll);

The above code is from the clk-ma35d1-pll.c from this patchset.

We just employ regmap mechansim for the access to REG_SYS_RLKTZNS register.
Is this implementation OK for you?  Thank you.


Best regards,
Jacky Huang





