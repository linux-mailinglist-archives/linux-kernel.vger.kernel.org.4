Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BD6694B16
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjBMP0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBMP0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:26:34 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1598A41;
        Mon, 13 Feb 2023 07:26:33 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-16df32f2ffdso4865349fac.1;
        Mon, 13 Feb 2023 07:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7yELkiR2oF+S0aR1NPW+7CGFtZ20FpkybhZSpxXCee0=;
        b=Qxf5UPKXwHm4PWReB1pZJaVYWkqns9VodIfHhUTIWTvNY7tJ1UxdOqoSijFfZzBa9x
         2QgdqT7b9uz9er+yQSdLBgYmh1h1ot4i1O2dEiEioS+fY0Ffu1gYeAX4jaQAWtTTnq6B
         /zo+EGYvXpHGWN58t/B1kN5kXCbmlgtLo1WLn1YGkbfLgRtngz5mKcNihgAUWaxfOZsb
         aX04qN1ERubx//JTo0jMCUuFaiWIrCogE+g6rl7XDTwv0vxnbNaqrEnH+zeof+l8UPqb
         NMxOC3J3VKe6wP4hbpX/qH1MuG+SEeUgqwsZR1bTyCYyyUD31+RnXGJrFIRV+lSIX4Sx
         K+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yELkiR2oF+S0aR1NPW+7CGFtZ20FpkybhZSpxXCee0=;
        b=c+VWvrZOjyw+acvIIGQipTRvdrWTg1F2al46RAsxiuIJ8qukp4QaUG30bCg6QjD/4B
         cFYBo30xrQg/vefP5fng7IlVLJ45PT8nsUhDSJY6wwNy/HWA4gda5I3C3/dqQWreayRG
         v1RzY07aiCiNBqxoJ3H95VxqSu8EakuVztCgP0RiWDkmtI1IgN33uhQ2gNxau6lwJ31h
         8wtDFwxbq49wq4nRieSF4QmfE7XHVrh5yVXIKctqKCvfVI384v7GeHniS0ZmO8+uvCFo
         i1xfVwKoS95t1HKRieNh3W6FwHaNy/s0rj8Q7q11hPy3xmYdlfZ8TaEBdEtm9dxe7q5V
         oTRQ==
X-Gm-Message-State: AO0yUKVRRVKS5ihjEcjMBl+ZkpGa9WaDIHLsxKK8XuRZDg3xYBXhFWnP
        ExQyzZfDKWlOBJJ2Vle0Pgk=
X-Google-Smtp-Source: AK7set+fs1fzdnl8TAqiYz2Wf25PErDsXjTA024UYWFNgLh96ARchjNIVDJSopFWPy6bg5CO+xOFqg==
X-Received: by 2002:a05:6871:4f15:b0:16b:5b0b:ed08 with SMTP id zu21-20020a0568714f1500b0016b5b0bed08mr4700308oab.27.1676301992620;
        Mon, 13 Feb 2023 07:26:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a19-20020a05683012d300b00686574e98d6sm5285465otq.72.2023.02.13.07.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:26:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <499cfd09-0c16-af51-ad17-55d6425ded8e@roeck-us.net>
Date:   Mon, 13 Feb 2023 07:26:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/3] drivers: watchdog: Add StarFive Watchdog driver
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20221219094233.179153-1-xingyu.wu@starfivetech.com>
 <20221219094233.179153-3-xingyu.wu@starfivetech.com>
 <20230201224619.GA3194283@roeck-us.net>
 <8feda5d9-8510-acbf-1ec2-3a0e67df0adc@starfivetech.com>
 <690da4a4-b4df-f316-e948-38c857237095@roeck-us.net>
 <d5ff24d3-317e-0cb1-24e7-5aac20d81305@starfivetech.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <d5ff24d3-317e-0cb1-24e7-5aac20d81305@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 05:29, Xingyu Wu wrote:
> On 2023/2/10 23:28, Guenter Roeck wrote:
>> On 2/9/23 23:01, Xingyu Wu wrote:
>>> On 2023/2/2 6:46, Guenter Roeck wrote:
>>>> On Mon, Dec 19, 2022 at 05:42:32PM +0800, Xingyu Wu wrote:
>>>>> Add watchdog driver for the StarFive JH7110 SoC.
>>>>>
>>>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>>
>>
>> [...]
>>
>>>>
>>>>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>>>>> +         __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>>>>> +MODULE_PARM_DESC(soft_noboot,
>>>>> +         "Watchdog action, set to 1 to ignore reboots, 0 to reboot (default 0)");
>>>>
>>>> I do not understand what this module parameter is supposed to be used for,
>>>> and what the "soft_' prefix is supposed to mean.
>>>
>>> This 'soft_noboot' means watchdog reset enabled status. If 'soft_noboot' is set to 1,
>>> it means reset is disabled and do not reboot.Or 'reboot_disbled' instead?
>>>
>>
>> That means it does nothing ? Why load the watchdog in the first place then ?
>>
> 
> This feature is used for debugging, so user can check the counter repeatedly
> without rebooting the system.
> 

Debug options are not acceptable as module options. Please make it a define
if you think you need it.

>> [...]
>>>>> +
>>>>> +/* interrupt status whether has been raised from the counter */
>>>>> +static bool starfive_wdt_raise_irq_status(struct starfive_wdt *wdt)
>>>>> +{
>>>>> +    return !!readl(wdt->base + wdt->drv_data->irq_is_raise);
>>>>> +}
>>>>> +
>>>>> +static void starfive_wdt_int_clr(struct starfive_wdt *wdt)
>>>>> +{
>>>>> +    writel(STARFIVE_WDT_INTCLR, wdt->base + wdt->drv_data->int_clr);
>>>>> +}
>>>>
>>>> There is no explanation for this interrupt handling (or, rather,
>>>> non-handling since there is no interrupt handler. What is the purpose
>>>> of even having all this code ?
>>>
>>> Because the watchdog raise an interrupt signal on the hardware when timeout,
>>> although we do not use interrupt handler on the sorfware, but the watchdog
>>> initialization or reload also need to clear the hardware interrupt signal.
>>>
>>
>> That should be documented.
>>
> 
> I will add that in the comments.
> 
>>
>> [...]
>>>>> +
>>>>> +    /*
>>>>> +     * This watchdog takes twice timeouts to reset.
>>>>> +     * In order to reduce time to reset, should set half count value.
>>>>> +     */
>>>>> +    count = timeout * freq / 2;
>>>>> +
>>>>> +    if (count > STARFIVE_WDT_MAXCNT) {
>>>>
>>>> count is an unsigned int, which is pretty much everywhere a 32-bit
>>>> value. STARFIVE_WDT_MAXCNT is 0xffffffff. How is an unsigned integer
>>>> ever supposed to be larger than 0xffffffff ?
>>>>
>>>>> +        dev_warn(wdt->dev, "timeout %d too big,use the MAX-timeout set.\n",
>>>>> +             timeout);
>>>>> +        timeout = starfive_wdt_max_timeout(wdt);
>>>>> +        count = timeout * freq;
>>>>
>>>> This is confusing. First, the timeout range is checked by the calling code,
>>>> which makes sure it is never larger than max_timeout. max_timeout is
>>>> set to the value returned by starfive_wdt_max_timeout().
>>>> Thus, count = timeout * freq / 2 will _never_ be larger than
>>>> STARFIVE_WDT_MAXCNT. Even if it ever was, it doesn't make sense
>>>> to use a count value of timeout * freq in that case, ie a value which
>>>> could be twice as large as the supposed maximum value.
>>>
>>> Change 'count' type to 'u64'. And if 'count' is larger than STARFIVE_WDT_MAXCNT,
>>> 'count' is equal to STARFIVE_WDT_MAXCNT. Does that seem OK?
>>>
>>
>> That would not change anything. This is not about overflows; I would
>> have mentioned that. count can still never be larger than STARFIVE_WDT_MAXCNT.
>> Please do the math.
>>
> 
> I get your point. It has checked the 'count' before the ops of 'set_timeout' so
> I check the 'count' uselessly in this. I will remove this.
> 
>>
>> [...]
>>>>> +
>>>>> +    if (tmr_atboot && started == 0) {
>>>>> +        starfive_wdt_start(&wdt->wdt_device);
>>>>> +    } else if (!tmr_atboot) {
>>>>> +        /*
>>>>> +         *if we're not enabling the watchdog, then ensure it is
>>>>> +         * disabled if it has been left running from the bootloader
>>>>> +         * or other source.
>>>>> +         */
>>>>> +        starfive_wdt_stop(&wdt->wdt_device);
>>>>
>>>> If it _is_ running from the boot loader, the watchdog core is not
>>>> informed about it. If it is started here, it is not informed either.
>>>> This is unusual and will need to be explained.
>>>> Why ?
>>>
>>> Is is okay to remove the 'started'?
>>>
>> Yes, though of course it would be better if the watchdog is kept running
>> in that situation and the watchdog core is informed about it. Also,
>> the watchdog core is still not informed that the watchdog is running
>> (i.e., WDOG_HW_RUNNING is not set) when it is explicitly started.
>>
> 
> Will remove the 'started'.
> 
>>>>
>>>>> +    }
>>>>> +
>>>>> +#ifdef CONFIG_PM
>>>>> +    clk_disable_unprepare(wdt->core_clk);
>>>>> +    clk_disable_unprepare(wdt->apb_clk);
>>>>> +#endif
>>>>
>>>> I do not understand the above code. Why stop the watchdog if CONFIG_PM
>>>> is enabled, even if it is supposed to be running ?
>>>
>>> There misses a check about 'early_enable' and add 'if (!early_enable)'.
>>> There means that disable clock when watchdog sleep and CONFIG_PM is enable.
>>> Then enable clock when watchdog work by 'starfive_wdt_runtime_resume' function.
>>>
>>
>> I am quite sure that you are supposed to use pm functions for that purpose,
>> such as pm_runtime_get_sync(), pm_runtime_put_sync(), and pm_runtime_enable(),
>> similar to the code in omap_wdt.c.
>>
> 
> I will use pm_runtime_get_sync() and pm_runtime_put_sync() to operate clocks.
> 
>> [...]
>>>>> +#ifdef CONFIG_PM_SLEEP
>>>>> +static int starfive_wdt_suspend(struct device *dev)
>>>>> +{
>>>>> +    int ret;
>>>>> +    struct starfive_wdt *wdt = dev_get_drvdata(dev);
>>>>> +
>>>>> +    starfive_wdt_unlock(wdt);
>>>>> +
>>>>> +    /* Save watchdog state, and turn it off. */
>>>>> +    wdt->reload = starfive_wdt_get_count(wdt);
>>>>> +
>>>>> +    starfive_wdt_mask_and_disable_reset(wdt, true);
>>>>> +
>>>>> +    /* Note that WTCNT doesn't need to be saved. */
>>>>> +    starfive_wdt_stop(&wdt->wdt_device);
>>>>> +    pm_runtime_force_suspend(dev);
>>>>> +
>>>>> +    starfive_wdt_lock(wdt);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int starfive_wdt_resume(struct device *dev)
>>>>> +{
>>>>> +    int ret;
>>>>> +    struct starfive_wdt *wdt = dev_get_drvdata(dev);
>>>>> +
>>>>> +    starfive_wdt_unlock(wdt);
>>>>> +
>>>>> +    pm_runtime_force_resume(dev);
>>>>> +
>>>>> +    /* Restore watchdog state. */
>>>>> +    starfive_wdt_set_reload_count(wdt, wdt->reload);
>>>>> +
>>>>> +    starfive_wdt_restart(&wdt->wdt_device, 0, NULL);
>>>>
>>>> I do not understand this call. Per its definition it is a restart handler,
>>>> supposed to restart the hardware. Why would anyone want to restart the
>>>> system on resume ?
>>>
>>> The watchdog start counting from 'count' to 0 on everytime resume like a restart.
>>> So I directly use a restart.
>>>
>>
>> That doesn't answer my question. The "restart" callback resets the hardware.
>> starfive_wdt_restart() is registered as restart handler, and thus expected
>> to reset the hardware. It it doesn't reset the hardware, it should not
>> register itself as restart handler. If it does restart the hardware, calling
>> it on resume would automatically reset the system on each resume.
>> Something is wrong here, and will have to be fixed.
>>
>> I _suspect_ that you think that the restart callback is supposed to reset
>> the watchdog. That would be wrong. It resets (restarts) the hardware,
>> not the watchdog. Please read Documentation/watchdog/watchdog-kernel-api.rst
>> if there are questions about this callback.
>>
> 
> Thanks you for reminding me. I finally understand that the restart callback is supposed
> to reset the hardware not watchdog. This watchdog doesn't reset the hardware, and I will
> remove that. By the way, if I don't need restart callback, would I still use the
> 'watchdog_set_restart_priority' function? Thanks.
> 

No.

Thanks,
Guenter

> Best regards,
> Xingyu Wu

