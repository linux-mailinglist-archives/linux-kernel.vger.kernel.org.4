Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CF961D8B8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 09:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiKEIXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 04:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKEIXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 04:23:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404A42FFC1
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 01:23:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so18542445ejb.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 01:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJEsrI2RcYKv+AHnZIZ0qxK2Wi99cECJ6/sDY1O3rSM=;
        b=CDg4uTzKh/zb0eg0iBTPFMVxAgC4UYRUzm6ncJTbOFx5UsNVaPv4a0N4a8DJGEk8uV
         oeyZDc8E3VT5u6SClHcYlHSgTtDVXl54rTOL9m0z99k8AwXG6qwAfAYzyMHviwZ6GfRY
         6ei0ftn45PoVrbbl+h2Sbiz5ntW1fJ17oMkDxf+c++Vj0EunVs1bwubH7hL2LuyKdu53
         bxIGUlezZgVOSeAcMoAgp0nBrmY6AMiKnNOpVaOjrHgJQBkcayHerylmFQZ9aSc3xZjx
         +4f01iDeZmqmrTWtYs+3esW13VkwxvaNUgfCcrZx6QN/XCUGHxTfl4Ddjf6skzU92rTN
         8xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJEsrI2RcYKv+AHnZIZ0qxK2Wi99cECJ6/sDY1O3rSM=;
        b=BGUvbp64arfCIo+pru5K4C0V4crH1Tp6c4tiAivpcKll+GHabm7Mqyxj6WstZPgcEu
         aGsbpxSwtbox8YRBkdPVY/wj12+9lSY5joloMm2ZzAqO/PejgjtRfSo/YHNBkYEWr250
         1sdld7Bh6wTBA/CDNqkuEnGlkWn+2epq3WweCr71LwTsuoWeFtqc0evQnAye06/G9Dh4
         nMPkxT/l8xKU2d5t7Kr/0n4Xw3P+aR0XN2stcNDavW5yV3g8xlcoi/THio2lJ/ifSqQy
         oe367P8gQWaCUI4RAiSlWw9aN7qIK4G+JCk8rWXnQotTPsWrSWhAszYDfMPRePC1mHZF
         aRXw==
X-Gm-Message-State: ACrzQf2ZSLVdz5pB5ITgbVeBHofQt3EeJexh2uAG7ZOIWYmAjlRsAwZu
        dgA3XvnJ04G/21N07JQXknQ=
X-Google-Smtp-Source: AMsMyM4CI/JJU0ucbmjgTp4wgEtYqB0ru9ngS8PUY0eJbUCY49pdyt9HEuMnTRxfqoFipxJ/exgsAQ==
X-Received: by 2002:a17:906:5a49:b0:7ad:d063:901a with SMTP id my9-20020a1709065a4900b007add063901amr30754399ejc.323.1667636622411;
        Sat, 05 Nov 2022 01:23:42 -0700 (PDT)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id k8-20020a1709062a4800b007ad9c826d75sm617311eje.61.2022.11.05.01.23.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Nov 2022 01:23:41 -0700 (PDT)
Subject: Re: [BISECTED] Allwinner A33 tablet does not fully power off
To:     Samuel Holland <samuel@sholland.org>, wens@csie.org
Cc:     mripard@kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
References: <9f8a0fc3-1d9a-b271-3c26-4f7373b8a3e9@gmail.com>
 <214ed3e0-5959-8fa7-8d66-196e33112cb0@sholland.org>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <a68b44f5-fd04-4dbe-0782-1d761c42ce3f@gmail.com>
Date:   Sat, 5 Nov 2022 10:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <214ed3e0-5959-8fa7-8d66-196e33112cb0@sholland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
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

Hi Samuel,

On 5.11.22 г. 4:21 ч., Samuel Holland wrote:
> Hi Ivo,
> 
> On 10/29/22 10:23, Ivaylo Dimitrov wrote:
>> After commit 843107498f91e57d1d4b22cd8787112726fdaeb4 (bus: sunxi-rsb:
>> Implement suspend/resume/shutdown callbacks) Q8 A33 tablet I have here
>> cannot be powered-on after power-off, it needs press-and-hold of the
>> power button for 10 seconds (I guess some HW assisted power down
>> happens) before it can be powered-on again.
>>
>> The following patch makes it behave correctly:
>>
>> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
>> index 60b082fe2ed0..30016d62044c 100644
>> --- a/drivers/bus/sunxi-rsb.c
>> +++ b/drivers/bus/sunxi-rsb.c
>> @@ -818,10 +818,7 @@ static int sunxi_rsb_remove(struct platform_device
>> *pdev)
>>
>>   static void sunxi_rsb_shutdown(struct platform_device *pdev)
>>   {
>> -       struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
>> -
>>          pm_runtime_disable(&pdev->dev);
>> -       sunxi_rsb_hw_exit(rsb);
>>   }
>>
>>   static const struct dev_pm_ops sunxi_rsb_dev_pm_ops = {
>>
>>
>> I guess the issue comes from the fact that by the time 'power off'
>> command to the power management IC has to be send, the bus it lives on
>> is already down, so the device is left in semi-powered down state. Ofc
>> this is a wild guess, however, preventing the bus being turned off on
>> shutdown fixes the issue.
> 
> Your guess is correct. The controller gets shut down in
> 
>    kernel_power_off()
>      kernel_shutdown_prepare()
>        device_shutdown()
> 
> but the PMIC communication needs to happen later in
> 
>    kernel_power_off()
>      machine_power_off()
>        pm_power_off()
> 
>> Please LMK if the above is the correct approach so I will send a proper
>> patch or something else shall be fixed.
> 
> Yes, this is exactly the right approach. The whole sunxi_rsb_shutdown()

Don't we need pm_runtime_disable() on shutdown? As IIUC, the controller 
might be suspended and we have to resume it to put it in state to accept 
commands later on(in pm_power_off()).

Regards,
Ivo

> function should be removed. When you send a patch, please add a Fixes:
> tag referencing the commit that you bisected to.
> 
> Regards,
> Samuel
> 
