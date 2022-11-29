Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A8663C342
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiK2O6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiK2O6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:58:16 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFBC26105
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:58:15 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id l8so17532999ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rMzROJizPl93HGtOKCLbNrY7oFQ4h6JFqbBwgiPoQw=;
        b=HK7NNJ+m0uo/8YiZigjIrMXrWT37vfCzE7ov3f7OWCf7ekUevZr/VqIA7JEZ2GKayk
         NRRVL9YSxbesfRYHWDaQuOX+C3/nCgmBSaPtE/344PBJuxVwlIrdUXUU++oqaf9G2qN6
         EA8zpZKOLeRklTG1AROPnVm+qvCAS9JQm2XG84OxkYA82ZH5d8ay6/OjOEuYmXuV6/vz
         84cqiQLfQ4fTOoVC4lrGW2dGf5ibfzL4uUZa2bN+ONpzydOi4ONItIRz0XxcdjnC1bAY
         zWgzwbqm9dmm+XOY5N6W4/zjzXOqa8JoaxQgtz3O6T4BmE72V9m4x+j+wawmEgu7P+9j
         WNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rMzROJizPl93HGtOKCLbNrY7oFQ4h6JFqbBwgiPoQw=;
        b=NSkWAGsS9jbXOVyyB6oTlNDpoWrLkiPjpc/AqtNFpI9uf6PHZ8v6EVAmYvtW616pZv
         WUve98s3kDW4+krom8eG80hkaPK26gOafpxubPYtP0U2i6j0reIcUg2ZNZ2Xj2r4NPyA
         R/v48PR62eFqNV5UVL5xntS7gXVDbieQU7Z+bYhDktd6ggdZzcZALzoK5WlyCjJIp1eE
         hKRocsThRdQ7hTOxyj0Qg6lzDtwnFHGTL8GayTZgz9QeVJWYAlphWzBkeaFROloyMGSA
         C8RvUgPQbfTSo5GGz9lXyN4Pqh8kClDGU7qYW/fQoUvnICx3Z2H6yBkW+4vx9mlUNNeg
         rAow==
X-Gm-Message-State: ANoB5plcqFWF10/65Ca97d5cAseU7XvvRw1+ng+WEgYStFH6BdqzqGUX
        GQhp/dkPrdMNqSC9P15OtHFKPg==
X-Google-Smtp-Source: AA0mqf6H7HysSViJIaGj4Ohg+efF0OL6qEvNKbtfijn0aiuYjc56hcFvmqwVVrFHWxq9fJmbcsxrdQ==
X-Received: by 2002:a2e:800e:0:b0:279:8e27:b42f with SMTP id j14-20020a2e800e000000b002798e27b42fmr6914373ljg.106.1669733894163;
        Tue, 29 Nov 2022 06:58:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 13-20020ac2484d000000b004aac23e0dd6sm2232708lfy.29.2022.11.29.06.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:58:13 -0800 (PST)
Message-ID: <f52e31a5-a12a-b95e-b99c-1af8f8b41c3b@linaro.org>
Date:   Tue, 29 Nov 2022 15:58:12 +0100
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
 <339be655-aee7-e1a4-51be-28ea20de6792@linaro.org>
 <3db802d6-114f-097a-6c69-e7b40e4d2764@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3db802d6-114f-097a-6c69-e7b40e4d2764@starfivetech.com>
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

On 29/11/2022 15:46, Jianlong Huang wrote:
> On Tue, 29 Nov 2022 08:49:49 +0100, Krzysztof Kozlowski wrote:
>> On 29/11/2022 02:47, Jianlong Huang wrote:
>>> On Mon, 28 Nov 2022 09:32:45 +0100, Krzysztof Kozlowski wrote:
>>>> On 28/11/2022 01:48, Jianlong Huang wrote:
>>>>
>>>>>>>> +/* aon_iomux doen */
>>>>>>>> +#define GPOEN_AON_PTC0_OE_N_4			2
>>>>>>>> +#define GPOEN_AON_PTC0_OE_N_5			3
>>>>>>>> +#define GPOEN_AON_PTC0_OE_N_6			4
>>>>>>>> +#define GPOEN_AON_PTC0_OE_N_7			5
>>>>>>>> +
>>>>>>>
>>>>>>> It looks like you add register constants to the bindings. Why? The
>>>>>>> bindings are not the place to represent hardware programming model. Not
>>>>>>> mentioning that there is no benefit in this.
>>>>>>
>>>>>> Also: this entire file should be dropped, but if it stays, you have to
>>>>>> name it matching bindings or compatible (vendor,device.h).
>>>>>
>>>>> Thanks your comments.
>>>>> These macros are used to configure pinctrl in dts, so the file should stay,
>>>>
>>>> Why they should stay? What's the reason? If it is not a constant used by
>>>> driver, then register values should not be placed in the bindings, so
>>>> drop it.
>>>>
>>>
>>> Thanks.
>>>
>>> These macros in binding header(example, DOUT, DOEN etc) will be used in DTS,
>>> and driver will parse the DT for pinctrl configuration.
>>>
>>> Example in dts:
>>> uart0_pins: uart0-0 {
>>> 	tx-pins {
>>> 		pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX, GPOEN_ENABLE, GPI_NONE)>;
>>
>> This is usage in DTS and is not an argument to store register
>> addresses/offsets as bindings. What is the usage (of define, not value)
>> in the driver?
>>
> 
> The existing implementation reuse the macros for DTS and driver.

Where in the driver? Grep gives zero results.

> Do you mean we need to separate the macros, one for DTS and one for driver usage?

No, if driver uses them it is fine. The problem is I cannot find it
anywhere.

> Or you have any better suggestion?
> 
> These macros are the value of register, not register addresses/offsets,
> except for with prefix of GPI.

Still, values are not usually part of bindings.

> 
> Drivers rarely reference macros directly, mostly parsing dts and writing them to registers.

So drivers do not use macros? Then there is no reason to store them in
bindings? What do you "bind" if there is no usage (and we do not talk
about DTS...)?

Best regards,
Krzysztof

