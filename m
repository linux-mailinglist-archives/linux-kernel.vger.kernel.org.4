Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C08679493
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjAXJxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjAXJxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:53:43 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3F21BDE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:53:40 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v13so17635332eda.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1g8H/5EnuQai7vsKQsMU+CVyFb5uB83EziQawtgMDQ=;
        b=HsW4hd0EVtalcgoAB9hWy6LlmDh3lURTTRSpesp5SDsjNGmCbR+cEONIcIpoizPWf/
         FRxM8H1Sgf44koNfbNGoc7ZCEkE1m4kuN2rRO7tgFYY0WRn78enCKCskBxQYfpDZb6du
         nV9cuRLr/grGZgcPi2IEwsknwJ5NbZLkPRYAu/nRbSVmQQlsge192hGtxUk6/Kp/sxq0
         nhbJWUikw/OD+X1PnZqgxQ/rsmurjPmAxXLltDm2gbXtlxdwcH/bV6gTkOfhyWtkcfGx
         rdZQr0oMIOeRZkTcS26l2J+dPFL/kUtdjw/hw/XrsEM3Azn2TBRTQJl48eMWog1hN26I
         lb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1g8H/5EnuQai7vsKQsMU+CVyFb5uB83EziQawtgMDQ=;
        b=Hw/zrZxBPR2UGm1y8uf359dsIpDdUZHKT9yXBI1wSixuiZ3eDV/bJCk8J1tiU8B+aw
         HuL0QefPrhcs8+Yo0sRT9RJfP7dUmDB6CgwEM3QF4OmbYHqLn4MUJZR/mMMSYI4SvwWU
         NT0rYlZU1Ced3tbaAWs6B77k67xhgYQYkLZZzqW9NVTqZzs7qPDaAfovWvc5lKatxj2h
         fuO9nZOfb+ieS4s59chKvULt8l5JwRFKflMJuPl00qMuwBhU1hDYwTTh+u+mrwVGhkzm
         C+VVRN2x6VqLJR67h+K0eD+FaMjgChQmMhjHDRWWy+O4zvlGTsZiIz2g0904fdRCzZjk
         bnDw==
X-Gm-Message-State: AFqh2kp/OKSKjz6wzAU9Mgbv4QvQd/umL5HbiRVsmf86A+OPbknVPI8m
        DhqtSzN7jLBbHtJ53bFYteoE0g==
X-Google-Smtp-Source: AMrXdXszMWKFzeKzx2qqlPjinJPLCfT/0Vnzgr9rLpPiGyJVEZ6b9td/Jy3JQyUhQ1r09CegVatXpA==
X-Received: by 2002:a05:6402:cf:b0:45c:835c:1ecc with SMTP id i15-20020a05640200cf00b0045c835c1eccmr39299686edu.26.1674554019357;
        Tue, 24 Jan 2023 01:53:39 -0800 (PST)
Received: from [192.168.1.101] (abyl109.neoplus.adsl.tpnet.pl. [83.9.31.109])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7de8f000000b0049622a61f8fsm840057edv.30.2023.01.24.01.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 01:53:39 -0800 (PST)
Message-ID: <d73f0eec-6e02-e72f-79d7-2c56245f7651@linaro.org>
Date:   Tue, 24 Jan 2023 10:53:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/7] clk: qcom: Add Global Clock Controller driver for
 IPQ9574
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-3-quic_devipriy@quicinc.com>
 <de346d71-1fe7-e357-d220-d4468e4bb933@linaro.org>
 <afd2e5c8-fa5a-ac1f-4ede-4ab1f91c0d0d@quicinc.com>
 <9bdf757d-1fa0-106f-eb77-7f2a8593213f@linaro.org>
 <2852fc37-284f-6534-f163-45b37b153db1@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2852fc37-284f-6534-f163-45b37b153db1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.01.2023 08:27, Devi Priya wrote:
> 
> 
> On 1/13/2023 7:39 PM, Konrad Dybcio wrote:
>>
>>
>> On 13.01.2023 14:21, Devi Priya wrote:
>>>
>>>
>>> On 1/10/2023 6:07 PM, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 10.01.2023 13:13, devi priya wrote:
>>>>> Add Global Clock Controller (GCC) driver for ipq9574 based devices
>>>>>
>>>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>>>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>>>>> ---
>> [...]
>>
>>>>> +static struct clk_branch gcc_blsp1_qup6_i2c_apps_clk = {
>>>>> +    .halt_reg = 0x07024,
>>>>> +    .clkr = {
>>>>> +        .enable_reg = 0x07024,
>>>>> +        .enable_mask = BIT(0),
>>>>> +        .hw.init = &(struct clk_init_data) {
>>>>> +            .name = "gcc_blsp1_qup6_i2c_apps_clk",
>>>>> +            .parent_hws = (const struct clk_hw *[]) {
>>>>> +                    &blsp1_qup6_i2c_apps_clk_src.clkr.hw },
>>>>> +            .num_parents = 1,
>>>>> +            .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>>> Sounds very much like a hack..
>>> Got it, will remove the clock entry as it is not being used in linux
>> I'm not sure removing it is the best option, somebody might have a
>> funky board where they use this particular QUP for I2C for whatever
>> reason and then the clock would have to be re-added..
> Sure, Understood
> This clock is used by the RPM component to communicate with PMIC and we
> would add the critical flag here
Okay, so this SoC is intended to ship with some RPM PMICs and
*always* with an I2C companion that's required for some basic
functionality, correct?

Otherwise, if it's just for wifi/multimedia/etc (like PM8008ij
on some newer devices), you should not make it critical and
simply rely on Linux keeping it alive like so:

consumer takes a regulator
the regulator does not go to sleep because it's consumed
the PMIC is active because a regulator on it is being used
the I2C bus is active because its child PMIC is used
the I2C clocks are alive because there's an active user

Konrad
> 
>> Thanks for addressing all of the review comments so thoroughly!
>>
>> Konrad
> 
> Best Regards,
> Devi Priya
