Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6574A54B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjGFUyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjGFUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:54:22 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9D29D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 13:54:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so18344001fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688676858; x=1691268858;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7RSaQ9WlKcAwcelHXRKRPMrm8csU9PL5No77SGAzfpQ=;
        b=JUqQ0v/649BZi/7gvHg9AngNzQdko5dlikegW9BhFCFX8oTYJtR2wgz8NX/Ma9PmFl
         kLtS5wTQVS2xadlnlXmllORS9K9lkcwtcxuy/KRmHEl/UbK2v5vkLpXxmoeZlLCgsvNH
         bAXxQkll+hlPkpd5K2cqXGqFm1spuDbCuMVAfR2YLXP/8Z+Sfu1zIhVMKz/h5WRn7uaY
         y7Lsmke+S+4mbEqGSZFPlUZH+bF+O4Gf35Vca/SiNNqW8YzsXtoCO4LOFaIql/8xHT+r
         Qm49Ff8Et9Pqz6BdYfMHSasbFEdAX4lza2Gr/dx7m/qRwITcEYcM/vAikVoFOvMZOwJV
         2vmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688676858; x=1691268858;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RSaQ9WlKcAwcelHXRKRPMrm8csU9PL5No77SGAzfpQ=;
        b=HWfqkel2V6J4kcGunhlwwk1kU9A8x7QAw1gpG/pI2SbQIVfV/G4TZYL0VfC+Hzv6BE
         tpQbshGwbYZ204Fb5Jt5SoNvSkKc3fLyCTGedDaFdlZ1K2eSvhIE22cNJ5Z896ThT3ta
         KjeHHUXx7S3h85fZEP+hmgNxD/OQL1sOdnXj6riGVgLo17svy/T/Y+dW+mHHnrGhs1WC
         Z+GVpT99PuCpvS6vmDtYYkrKHrcpnjfhY8Kl4gkQ3ESqStqjUqxN28fH+iao+sNblvtf
         X+/kyXOgOH6yfxAL9T0VVxnq/vDjgkAux41xErt/bggDw5z3lVXGcV/SriRt/Prjs0YB
         P4JQ==
X-Gm-Message-State: ABy/qLawumNZlaj4Xm3TidMqZVfNM5sgCcIXwmAyh4PrEQNpG08oQvxa
        1tYEIRwGF3EP9F7GagHOJnkRfA==
X-Google-Smtp-Source: APBJJlEOE7hxfi9AL1aP//s6s/PqKmJrmLwuwd5C2ZlB/pqsJhwHkYt8V/oS5kn34MeHKn3FzqQXlw==
X-Received: by 2002:a2e:9896:0:b0:2b6:9909:79bd with SMTP id b22-20020a2e9896000000b002b6990979bdmr1909986ljj.24.1688676858175;
        Thu, 06 Jul 2023 13:54:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id z22-20020a05651c023600b002b6de6deb5asm483574ljn.2.2023.07.06.13.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 13:54:17 -0700 (PDT)
Message-ID: <b7853d31-0330-591f-2cea-7aa2a7d7c51e@linaro.org>
Date:   Thu, 6 Jul 2023 22:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] clk: qcom: gcc-sc8280xp: Allow PCIe GDSCs to enter
 retention state
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230706140842.18059-1-manivannan.sadhasivam@linaro.org>
 <ZKbM4vLpk_T3cGWC@hovoldconsulting.com>
 <34b300ea-072a-5c70-904f-db85ff963f3a@linaro.org>
Content-Language: en-US
In-Reply-To: <34b300ea-072a-5c70-904f-db85ff963f3a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.07.2023 16:40, Konrad Dybcio wrote:
> On 6.07.2023 16:17, Johan Hovold wrote:
>> On Thu, Jul 06, 2023 at 07:38:42PM +0530, Manivannan Sadhasivam wrote:
>>> With the minimal system suspend support in place for the PCIe driver that
>>> keeps the interconnect path voted, the ALWAYS_ON flag can now be dropped.
>>>
>>> Also, the PWRSTS_RET_ON flag should be used to allow the GDSCs to enter the
>>> retention state when the parent domain get's turned off during system
>>> suspend.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>
>>> Changes in v2:
>>>
>>> * Changed the patch from simple revert to changing the ALWAYS_ON flag to
>>>   PWRSTS_RET_ON.
>>>
>>>  drivers/clk/qcom/gcc-sc8280xp.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
>>> index 04a99dbaa57e..c59b0f91c87d 100644
>>> --- a/drivers/clk/qcom/gcc-sc8280xp.c
>>> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
>>> @@ -6786,7 +6786,7 @@ static struct gdsc pcie_2a_gdsc = {
>>>  		.name = "pcie_2a_gdsc",
>>>  	},
>>>  	.pwrsts = PWRSTS_OFF_ON,
>>> -	.flags = VOTABLE | ALWAYS_ON,
>>> +	.flags = VOTABLE | PWRSTS_RET_ON,
>>>  };
>>
>> This is not correct either. PWRSTS_RET_ON is a pwrsts mask...
> This + please rebase atop that:
> 
> https://lore.kernel.org/linux-arm-msm/20230620-topic-sc8280_gccgdsc-v2-0-562c1428c10d@linaro.org/
Moreover, I tried a similar patch out.

Johan's v6.4 branch + the patchset I linked + removing ALWAYS_ON from gcc
(so keeping PWRSTS_OFF_ON) and PCIe survives a wakeup-s2idle-wakeup cycle.

I am however running with clk_ignore_unused, so I don't know how this
impacts the RPMh system suspend situation.

Konrad

> 
> Konrad
>>
>> Johan
