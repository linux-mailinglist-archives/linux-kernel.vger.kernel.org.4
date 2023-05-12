Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E2870018C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbjELHeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbjELHeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:34:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3286830F4
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:34:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965cc5170bdso1437955966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683876855; x=1686468855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eilBLb177UVgpGk+F0uFPS6/DUTRyUaIRLjAc8Wl1D0=;
        b=hlrfZhzKl4nMEXFYP3AGGg5wcsVT5HS/5rHm8m6pqpOH/YdU17ClD+11Bu6MNJpUQa
         NKY/37p//cVRjxHOkTW3PGjINPeW6h/vHH8WSxBFt2ftJ3NcG8CV3XkR6PoJRBloCvas
         0EKQQ+RyYBGv7YAPrxz9rR40MzbZYSe0n5UhRxFdkXWuDY5N4c27dZ5uWD0ZZ6+JuxlL
         9KtB44TR6rwFbf3twMYkYA6w+4p208dGHvadpOV0yhoKw46EvNfhRAVlHs5fBGjCxp2O
         fgRT3EuqB5SAXyjaJgbr1H+ajaQawEclbJPbBU0AcE6/Pl8r5I/hgu9lpzOU9FoMHwWO
         TzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683876855; x=1686468855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eilBLb177UVgpGk+F0uFPS6/DUTRyUaIRLjAc8Wl1D0=;
        b=UuxEDQyR48Lo7FTsd+xvl8Z0KK4wSGI43h//GauAIMr0A32F02jgZZW3IiT0NMsf8E
         t5JNpFZfCl/uLWn9Hh+hNa7U/RYgeYNB9czX0R9E/Su2tq5zF3UmBw7yuoRvWPp/0DXX
         hznU7XYmUwPUx3wF5LkBa4WLBn7Onj95xibxn3iOHL7iAVslluWivbNXvsS/tvwOERzA
         XtOdhYhq1oM8nNKE/FtKJD7EDN1Bs7cogtCiqCCND0VO2OxmOA6jVXVOMYYWCDjMte1P
         wH+hugnoDZ2mwo4Zn6/AQ3Pdngy0IdTuQ5ECB2I+hbZZ6ZTR9J1HtO65xJeClZolFSlv
         RFRQ==
X-Gm-Message-State: AC+VfDx2gb1vgh7ZtncyjqILL3NODXK716IUHHfHP5XYHcjaOa2u8L0X
        dwZ4iFUN6I2AJijM0c+vgA3q9Q==
X-Google-Smtp-Source: ACHHUZ4+w2QnVRBUsAsAQavc5TsVbAgzReHgL4m1JE3cKr9nam4C+gXbZPLev77DaI9BrK+LltyTxw==
X-Received: by 2002:a17:907:2687:b0:94e:16d:4bf1 with SMTP id bn7-20020a170907268700b0094e016d4bf1mr19157985ejc.66.1683876855620;
        Fri, 12 May 2023 00:34:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id ig2-20020a1709072e0200b00965f31ff894sm5056588ejc.137.2023.05.12.00.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 00:34:15 -0700 (PDT)
Message-ID: <17bbb2fd-5df5-0f66-9a28-385c50b0d82d@linaro.org>
Date:   Fri, 12 May 2023 09:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 5/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-6-xingyu.wu@starfivetech.com>
 <2fb8c88a-dab5-791b-eefe-c983decad5e8@linaro.org>
 <20230512-brewery-spouse-86350c9664d8@wendy>
 <b0133bcb-9c46-643a-5eda-dfdd816296fa@linaro.org>
 <ebc3a1e9-06cd-7316-8cf3-945bec910a7c@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ebc3a1e9-06cd-7316-8cf3-945bec910a7c@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 09:24, Xingyu Wu wrote:
> On 2023/5/12 14:50, Krzysztof Kozlowski wrote:
>> On 12/05/2023 08:43, Conor Dooley wrote:
>>> On Fri, May 12, 2023 at 08:35:43AM +0200, Krzysztof Kozlowski wrote:
>>>> On 12/05/2023 04:20, Xingyu Wu wrote:
>>>>> From: William Qiu <william.qiu@starfivetech.com>
>>>
>>>>> +  "#power-domain-cells":
>>>>> +    const: 1
>>>>
>>>> Add it to the existing examples.
>>>>
>>>> This part confuses me... why aon appeared here?  Why power-controller
>>>> disappeared? I don't think that Rob or me proposed any of this.
>>>
>>> Rob did actually suggest this, as the power-controller child node had no
>>> properties other than #power-domain-cells.
>>
>> He suggested it for aon, but not for stg or sys... aon is not a child of
>> sys, is it? Then why power-controller disappeared from sys?
>>
> 
> The power-controller is only for aon, but now just use power-domain-cells instead.
> The sys only have the clock-controller child node not power-controller.
> And stg has neither.

OK, I see. Stuffing all of them in one binding suggests that anything
can be anything, but you actually have different devices with different
features/roles.

Best regards,
Krzysztof

