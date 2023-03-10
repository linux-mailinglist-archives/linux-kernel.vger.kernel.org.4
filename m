Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3B6B3CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCJKtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCJKs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:48:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912BF14987
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:48:56 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i34so18711053eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678445335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6St6WVXxigAtxgndqKfLqcctFsJaYXnikD6iTBfDuk=;
        b=n9DgOqFg3SEpvGdhOdZ2FXLGhYdaPpmGn0DAeZIwof1r15TWM8tPIYiyrQIAqJY/1n
         1PRFKjFuPO2OljsPwGyV1AbWN1IrMJJfHaxh5iKrQMSfEaRla54nWs3EyhZuWXLIZJ44
         HT7TeHzmRf1vzsfdWyvZpgsJUetiIhy+OqL9imBMJ3siQpMqcJbNrP/GJuJlhQKwUGNv
         fPxhpPfd20Dx38j3Y0ibLoGx2EuOVUUKaibgQQynq8F7gGTUlCjDLRDskFRNLL9u7JdG
         8ju956a0i2xXTT1UZbi5O2F/7fRimjWaqbi42wELY9n2llhCmrOizT7JBGkokWxyUg1N
         5Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678445335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6St6WVXxigAtxgndqKfLqcctFsJaYXnikD6iTBfDuk=;
        b=KpvsPHjjyAhawlCaUyfsAhA1imgb0i7CkmbtMLKhjmlSgM9T1la6scICXwpyGj8qv9
         7IUg6VP+XPaEMhexJhnVwd7r2g/htL8WgFa1/Cp7mw/ML4Xmilr0uze2RCoBA7oooEm/
         jHFTuz6q9RAg1RqGhrU3M5RRwcE0cNOJkYz3ph7DJIIDk/7nmTnaJSEY4QwXIk0A0Jpf
         MG9g7KEfpw7yeiBvTjb1x5afNbk9ObxK8tP2tavPS5ZrTq2ZTkZWZ+BdrnlkH+aUbHbH
         1VxkHz9VZQ4xYSv+LN/q51d53YyxnpGJJieF3+O6UjCsLsHbeSJUJgsLdFESwhUGtiG1
         +Rkw==
X-Gm-Message-State: AO0yUKUqhaV+apE6bZCDmCZqRxEbQ18qpC364ivEsr35asYxb3mKqul+
        7tA7YRRfhbu4AjVqmQ01H4xh/eX/8En2tlZe8j0=
X-Google-Smtp-Source: AK7set+XiQk87O75bLAib/afcYFxinzj1UZcplYhxcFlF/7jSBc4Tyf4IkGUZLjJHjCl1uvcn6c4ZA==
X-Received: by 2002:a05:6402:31f8:b0:4ac:b602:3fa4 with SMTP id dy24-20020a05640231f800b004acb6023fa4mr22715738edb.17.1678445335134;
        Fri, 10 Mar 2023 02:48:55 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id qt17-20020a170906ecf100b008edf49f10a7sm805951ejb.100.2023.03.10.02.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 02:48:54 -0800 (PST)
Message-ID: <9c22f5b3-d2af-2645-c1d0-5e8bbdaf5031@linaro.org>
Date:   Fri, 10 Mar 2023 11:48:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] leds: Add support for rohm,bd65b60 led driver
Content-Language: en-US
To:     Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.or, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308201451.11629-1-bogdan.ionescu.work@gmail.com>
 <20230308201451.11629-2-bogdan.ionescu.work@gmail.com>
 <c8dc876e-eb9b-292c-213d-b8c3348cf63a@linaro.org>
 <CALfPHoVFVpnLVEjzccbyMvmNR_=3vjJ+Ub8tkriJOvvV0cLzsA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CALfPHoVFVpnLVEjzccbyMvmNR_=3vjJ+Ub8tkriJOvvV0cLzsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 11:44, Bogdan Ionescu wrote:
>>> + /* Check required properties */
>>> + if (!fwnode_property_present(child, "rohm,enable-outputs")) {
>>> + dev_err(dev, "No rohm,enable-outputs property found");
>>> + return -ENOENT;
>>> + }
>>> +
>>> + ret = fwnode_property_read_u32(child, "rohm,enable-outputs",
> &led->enable);
>>> + if (ret || (led->enable & LEDSEL_MASK) != led->enable) {
>>> + dev_err(dev, "Failed to read rohm,enable-outputs property");
>>
>> No need to check for properties twice...
> 
> I understand that you can just check the return value, but what is then
> the point of the fwnode_property_present() function? Where is it otherwise
> supposed to be used?
> 
> I am happy to remove the first check, but I would like to understand the
> reasoning behind it. I found value in separating a value not found error
> from an incorrect value error.

ENOENT is not valid code  -  No such file or directory. Thus you cannot
return different codes. The code should be simple and printing error on
fwnode_property_read_u32() is enough to report it to the developer.



Best regards,
Krzysztof

