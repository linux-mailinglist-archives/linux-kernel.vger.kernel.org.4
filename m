Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC1163A31F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiK1Icv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiK1Ict (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:32:49 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478665FC4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:32:48 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c1so16185357lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=983vZmfe7jg3PD5EB3eQ9LeCd23DV+eV1fr/DcjdUm8=;
        b=CjVdRdltMTd1Id79iqrTL6Zur0PPWkP39IltMT39Kf03+T+sPoC+4iWi1M8cdJbUb9
         Qh8nD2yt4fRd0gd9rH/GeAwFUb0P7Q7W83sHjOdHY8zVF3Q2G40GtKcnqCfaaLvTzBsd
         yRYt4immw2ZPDiRAiU26EqQCmoN3h6shyYUoVmIeC5mxNLiU1oSV0NDCiN/nkcQZ6AlW
         bd4a3nTuF7ivIZAFsVZcX/WZgMsPv0yp7GmZ0Sm/yU9nQMWPOy0eWXOXHF/lCF4bYsD4
         DKXhrYglw6DNAm7DkBpeZXHJ9d9OT2C5HxFWqFb573XtMRpKcTvd2SYbhUMp5fZs109j
         DXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=983vZmfe7jg3PD5EB3eQ9LeCd23DV+eV1fr/DcjdUm8=;
        b=VKZnv+Xf8SP6btaqG0tQxxawdzpaFd5zH0HleRshbZMxTFMTrm9Tau0uDRZ8ZFzbzX
         f2k3qTo+oDPMecXg5zPBZmLPqsr5/ELjDPf8144sZXA7eHlinAJKkNVzU5NXroSSuWLQ
         wOIRGHqTs7epOyg3uTiQkLWQTGjEJsoHzzUJiz9Qz+PVHKs3CIqt1ILJPX1yiMdfmgUg
         Bur5Sdu/OhwNtpR1I0naNKdRtRcXLL3MQEBY/ME3GfAk4knU7QJbUH1ClsKraXZtofIw
         IyybmT/DMsqKUgd/6bzFA0a+7CcFvJPj5V/VrCP0OromwK8jMkwwVfZeP21hezwHUCbv
         PRHg==
X-Gm-Message-State: ANoB5plwHN+Oc+LTJWjwn3w4Opu4UIo/PUcmtlVLF0SUIAnhI6eQulsB
        BW816DPqjK8XSOlZZbfQs9l0Ag==
X-Google-Smtp-Source: AA0mqf7AFRRbcu4251GazNH8EBAc/6JlexTcxGgKBsiqYhIA67n+8prqtL2Sq/j3X5x6hAj6biLCgQ==
X-Received: by 2002:ac2:430e:0:b0:4b4:9c0b:f4d3 with SMTP id l14-20020ac2430e000000b004b49c0bf4d3mr16235202lfh.349.1669624366437;
        Mon, 28 Nov 2022 00:32:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bf37-20020a2eaa25000000b002793cf0e9e8sm1162098ljb.122.2022.11.28.00.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:32:46 -0800 (PST)
Message-ID: <093ea507-4c42-1af9-4896-64c1a918432e@linaro.org>
Date:   Mon, 28 Nov 2022 09:32:45 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0ceba170-f844-e733-a49e-e67746f9f836@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
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

On 28/11/2022 01:48, Jianlong Huang wrote:

>>>> +/* aon_iomux doen */
>>>> +#define GPOEN_AON_PTC0_OE_N_4			2
>>>> +#define GPOEN_AON_PTC0_OE_N_5			3
>>>> +#define GPOEN_AON_PTC0_OE_N_6			4
>>>> +#define GPOEN_AON_PTC0_OE_N_7			5
>>>> +
>>>
>>> It looks like you add register constants to the bindings. Why? The
>>> bindings are not the place to represent hardware programming model. Not
>>> mentioning that there is no benefit in this.
>>
>> Also: this entire file should be dropped, but if it stays, you have to
>> name it matching bindings or compatible (vendor,device.h).
> 
> Thanks your comments.
> These macros are used to configure pinctrl in dts, so the file should stay,

Why they should stay? What's the reason? If it is not a constant used by
driver, then register values should not be placed in the bindings, so
drop it.

Best regards,
Krzysztof

