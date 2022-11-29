Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B4863BAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiK2HuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiK2Htx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:49:53 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227CA52156
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:49:52 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f13so21195770lfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7AuujM8+aeCGquyh830lAMw8HGWJigyKqEFa19drNo=;
        b=JnFA7pQpspbBCPizM4zXsJ2NveZL9iZ/llMZEhzqu7vCVdKlZ4PTn0pq+bfzFkzg3d
         IS+b2xLwuCS21piN8BlNpd06VA8M0S+7CWR+R03IecplidnP28JkUyt/g5WTgwoVvXgp
         tuvDxCox7+cWHOihucgZ6qTF6VvdamNeBjQMJD+jm7UorwcUWlwzviKR9GAi0QvrceHA
         lHdNl7TIkKuZpiArMc5X4ctiMD+OPvyLTuv99KbfY4YZNda7oAChMjuMqxfcEozTZ2Bi
         8R1MlDP5ueTcz8zha7imXyQ9ssyQcYvwyM90VP75nW1FfeN120UmNvovCs46BNksfKZ7
         DGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7AuujM8+aeCGquyh830lAMw8HGWJigyKqEFa19drNo=;
        b=1oowbId5mQMHncMUDWWmU2DjyHU4+HKSKLWeNyow+rk05bXoS95d9cFaDnXkzhqitL
         5LNq4mDZWmOMmQFRvtnz7Qw6rgtingRvahWAhPcxrO3JTKpJ1B815opu+Z/MYHONsE7K
         /Ta7GoUWHaxg7CHjl0VCLKXPjIALCPlh7/KnEzw3Ej6g0r0/yGcNWUSH5Gowj9q7gK5N
         9CGLEW0e6N+da5sLQhU1WuWJyPiSr93H0f2/m8PQ8DZelGed47ErzWKkz2KumfdEtaHb
         Dsn/qc1Ag83hXp1Dt1+emGUmLsXxPQzWcJzppbRHgfQ2e4RRsOJpGcRJb5O88G0jG9Dq
         oedw==
X-Gm-Message-State: ANoB5pmz6wtz8AJ1yUHNPHaExnFcRs8EKtqx8rowaDKTELoUPaXV4CRg
        EHqtlM2EFKcA5zGQ3BhNLU/q/A==
X-Google-Smtp-Source: AA0mqf64LWlV5ymRt0Y4uGdG28tz9Pfe50jqdaNDybjAyLGTK+WsiZup0t4YfLvpdkzBf8U5SobnWA==
X-Received: by 2002:a19:7708:0:b0:4a2:6b44:d742 with SMTP id s8-20020a197708000000b004a26b44d742mr20417340lfc.191.1669708190485;
        Mon, 28 Nov 2022 23:49:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651234c900b004b4823f02b0sm2084055lfr.152.2022.11.28.23.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 23:49:50 -0800 (PST)
Message-ID: <339be655-aee7-e1a4-51be-28ea20de6792@linaro.org>
Date:   Tue, 29 Nov 2022 08:49:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/5] dt-bindings: pinctrl: Add StarFive JH7110 pinctrl
 definitions
Content-Language: en-US
To:     Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221118011108.70715-1-hal.feng@starfivetech.com>
 <20221118011108.70715-2-hal.feng@starfivetech.com>
 <eb3974a3-f715-f5b0-cac7-551af26bd17b@linaro.org>
 <08db0f3b-5222-9460-26ba-0e6380d16583@linaro.org>
 <0ceba170-f844-e733-a49e-e67746f9f836@starfivetech.com>
 <093ea507-4c42-1af9-4896-64c1a918432e@linaro.org>
 <30c21787-0c48-ff50-1d63-8e69bdcdbe30@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <30c21787-0c48-ff50-1d63-8e69bdcdbe30@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 02:47, Jianlong Huang wrote:
> On Mon, 28 Nov 2022 09:32:45 +0100, Krzysztof Kozlowski wrote:
>> On 28/11/2022 01:48, Jianlong Huang wrote:
>>
>>>>>> +/* aon_iomux doen */
>>>>>> +#define GPOEN_AON_PTC0_OE_N_4			2
>>>>>> +#define GPOEN_AON_PTC0_OE_N_5			3
>>>>>> +#define GPOEN_AON_PTC0_OE_N_6			4
>>>>>> +#define GPOEN_AON_PTC0_OE_N_7			5
>>>>>> +
>>>>>
>>>>> It looks like you add register constants to the bindings. Why? The
>>>>> bindings are not the place to represent hardware programming model. Not
>>>>> mentioning that there is no benefit in this.
>>>>
>>>> Also: this entire file should be dropped, but if it stays, you have to
>>>> name it matching bindings or compatible (vendor,device.h).
>>>
>>> Thanks your comments.
>>> These macros are used to configure pinctrl in dts, so the file should stay,
>>
>> Why they should stay? What's the reason? If it is not a constant used by
>> driver, then register values should not be placed in the bindings, so
>> drop it.
>>
> 
> Thanks.
> 
> These macros in binding header(example, DOUT, DOEN etc) will be used in DTS,
> and driver will parse the DT for pinctrl configuration.
> 
> Example in dts:
> uart0_pins: uart0-0 {
> 	tx-pins {
> 		pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX, GPOEN_ENABLE, GPI_NONE)>;

This is usage in DTS and is not an argument to store register
addresses/offsets as bindings. What is the usage (of define, not value)
in the driver?


Best regards,
Krzysztof

