Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E6863BB57
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiK2IPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiK2IPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:15:04 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A15474A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:15:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id g12so20760021wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+tGnGmsd8SAIBQy5l4bYfSlkJXwSsNSEiUXV0JrZ7G4=;
        b=KTldDQLc2tfmlmwHTPtlzERRJy+/jbYo9EsHIxk7O1mjZbOw9VlAAiNseOhv+Le/EY
         4ZiEDc1QvJwrXaMN6eFvxqerNsnilHxvYyrnTSMXoCXQXWCPxQKf25zugw93LCUDO5aa
         4y3Nd84D1+RvRWa6FCu8bT7RsBUZ1MNfy19ToCyxmF+kg59jjg4efRoZHY6F+te3aCe1
         zs+dBujwbjothGnT2zaJGuKkewhnmrNOePYr5sLSz1BX4weqKuRwLldukQ/T1+wuXGGv
         ADbztyNZqjIHoGHQtVI6FXqyrZZRqhmc6Azgbd+G2sLa3JZh4glG7ZPJpZRRfwAWYI8t
         AN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tGnGmsd8SAIBQy5l4bYfSlkJXwSsNSEiUXV0JrZ7G4=;
        b=MAJoensh/p/i+fSmMXBZ6TnQHq8kCFjuWLIK4vk8SEQ8ambK8TLtjMiq2zP15wCnae
         876Y0CRFGrXLd2TsmN67XapK28do51SjRpKf8JbcCclHch+g0Yd4rijeviiISn27vkjo
         bth/KWzfvUYpiuqTQQVtwHg2sV7KBRrsaRPO2cliazqOotBqjdZP+ntA+KBkj3fyqIQm
         QDbE/Ihop1pJrIOPontf40BYZxJVwl0OPD9qj+nE1lqp7ziUgFhyaQe9uxFLTSVmXCPa
         Fu1cjp81ZoodJu+wKEcbID8ygcCyE+MIQuUR/3IAIlGUsZFNB22xoMwtuxJNqESo4HYC
         sPeA==
X-Gm-Message-State: ANoB5pkSLdfvGV2y5DlQi3sNtfrh4Zg59fTncyCMQ+qY/KjdGlKLBECx
        P9jxwVrt9S18V+PCszq4t48OKA==
X-Google-Smtp-Source: AA0mqf4cGPQC7b3hpyexGmaRKYiejcRHPv4RznEDcAyvSpiAKZOUZqQXpPilrMkBaqhOfPiP9RWS7w==
X-Received: by 2002:a5d:6503:0:b0:22e:35e8:382d with SMTP id x3-20020a5d6503000000b0022e35e8382dmr33962143wru.475.1669709702171;
        Tue, 29 Nov 2022 00:15:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2f85:a28c:5df7:9cd2? ([2a01:e0a:982:cbb0:2f85:a28c:5df7:9cd2])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b003b4c979e6bcsm1242431wms.10.2022.11.29.00.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:15:01 -0800 (PST)
Message-ID: <f6ffd433-1652-fb4f-8657-928e7407ba5f@linaro.org>
Date:   Tue, 29 Nov 2022 09:15:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/4] dt-bindings: pinctrl: qcom,tlmm-common: document
 i2c pull property
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <20221123152001.694546-1-abel.vesa@linaro.org>
 <20221123152001.694546-3-abel.vesa@linaro.org>
 <CACRpkdZtkHCkfUAcezSJvmei=HOezK6oyx+4C5kBrEtU+vAB-g@mail.gmail.com>
 <fecb2dd6-9be2-78dc-4598-cc338fbdc2a2@linaro.org>
 <CACRpkdZJaz9BEorQa7dTNkgTkwZjJNB-MWrpKFxHRgdsf3xJww@mail.gmail.com>
 <8602cacd-f552-e843-5c17-681b099069a3@linaro.org>
 <CACRpkdbqjNJH_QvWyEPceUUxRQ2tOpErNOWA0rg5GNwq7PfUFQ@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CACRpkdbqjNJH_QvWyEPceUUxRQ2tOpErNOWA0rg5GNwq7PfUFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 26/11/2022 22:53, Linus Walleij wrote:
> On Fri, Nov 25, 2022 at 1:40 PM <neil.armstrong@linaro.org> wrote:
> 
>> As I understood, it enables an "I2C resistor" on the pin, removing the need
>> of an external pull-up resistor on the line.
>>
>> I assume the classical pull-up bias is not strong enough to replace an actual
>> resistor on the PCB.
> 
> In that case I think this should be an argument to bias-pull-up like:
> 
> bias-pull-up = <360000>;
> 
> Nominally the pull up is in ohms:
> 
>    bias-pull-up:
>      oneOf:
>        - type: boolean
>        - $ref: /schemas/types.yaml#/definitions/uint32
>      description: pull up the pin. Takes as optional argument on hardware
>        supporting it the pull strength in Ohm.
> 
> Then the driver can choose to shunt in this extra I2C resistance
> from the resistance passed as argument. So no special property
> is needed, provided you can get an idea about the resistance
> provided here.

I like this alternative, I'll try to figure out if we can find a value
to match against.

Thanks,
Neil

> 
> Yours,
> Linus Walleij

