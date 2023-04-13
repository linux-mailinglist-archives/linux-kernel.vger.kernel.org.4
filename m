Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8146E091C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDMIlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjDMIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:41:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D605B8A46
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:41:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id si1so5354235ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681375285; x=1683967285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YiS7Xw21QmvVwpdnupwEjvYWlLbUE4ktfUHhlm6JOgE=;
        b=F3mLl0gwsnOMzwO1LNzFYYunfYUPEBGQSqbjGMGBJ3easv+cvP3SQNETEyZCbkETDE
         baYq60zQPa6LCLZlXHb/5/Nja7YloC60Rl6J92K2iR9c5+0OKWeTvqmIzFDqt53MbRCz
         l6otRVMxZDQ6obrBIq8Nps4mWafK4gXBBYLGhBOYJrfwGLQH5Oo1JCVzAPl4LpgSsj/c
         p8bSwJLo5T4lw2Edqno2ArBV/XrOOtLgMgllzYTCiQBc1YMUcE847WpoeFXIUkyRVxNg
         Zi6xRqNQ9IElsOxjEzLBLhoN7yD8gdCB1HByvnULBHHyrx9Z2+rSTMfCupGQ24tXLyMq
         Z7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375285; x=1683967285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YiS7Xw21QmvVwpdnupwEjvYWlLbUE4ktfUHhlm6JOgE=;
        b=Fm1eJ3AM6UqSpGdqixxR80OlNkOcyrH/6m+vAIO+A6eBWHfGzDRqlgLfceaMll4I9s
         PaFbix8Q1xGQ8Way0P8OLnYNpHhL9pZBRTt0LwAod8ev3DsS0SifPm8SZD4CVqAO0B+J
         yT1OAQdGjsKaNkcb1iq5P93mnpfdTJ8snXRk7Cs90iDKWMwp1H03QBgm/87dLTe/9PkN
         TmZG47Xw/Glw6pN5gA6nPP6R2lQ08IoIwjnUnOzhUiqQrD18aNbUfDxHpIlJCEa7xYh9
         +pRDIi17SDiHdtgozaRtzEEgB4Ov/jMa5qTZskJjPZFGYO3iq8GaYhX8dTkmzOOvuozH
         ot5g==
X-Gm-Message-State: AAQBX9ef8Ve9sO/0IZb5NYL6XyUJcc22VZncnBxG1uNW182kqiIYQnza
        TLria8iLE9cItRW0xHdAuSzPJBIOepT+Fov1M28=
X-Google-Smtp-Source: AKy350bmE9xQnGU95nbPNivIp2OLCSM++q4Lju3jiZDXhGN5bSr9CoB4c7u3UIn/8rWC80ung91WjA==
X-Received: by 2002:a17:906:4bca:b0:94a:3ff1:53ad with SMTP id x10-20020a1709064bca00b0094a3ff153admr1989086ejv.75.1681375285316;
        Thu, 13 Apr 2023 01:41:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7? ([2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090632cd00b0094e96e46cc0sm636865ejk.69.2023.04.13.01.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 01:41:24 -0700 (PDT)
Message-ID: <f0d82428-aaa5-3dd4-bc29-f1057fe749bc@linaro.org>
Date:   Thu, 13 Apr 2023 10:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Content-Language: en-US
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230412084540.295411-1-changhuang.liang@starfivetech.com>
 <20230412084540.295411-2-changhuang.liang@starfivetech.com>
 <8dd0dc63-e0df-8764-f756-da032d9d671c@linaro.org>
 <eb47b7c7-bdbb-92d9-ba39-604ce487f297@starfivetech.com>
 <f6a4fb28-d635-4d99-44bb-d929cb41eef2@linaro.org>
 <b34a8d59-34e4-8358-9d2b-367f4707ca7c@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b34a8d59-34e4-8358-9d2b-367f4707ca7c@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 04:34, Changhuang Liang wrote:
>>>>> +  lane_maps:
>>>>
>>>> Why did this appear? Underscores are not allowed. It looks like you
>>>> re-implement some standard property.
>>>>
>>>
>>> Will change to lane-maps.
>>> Yes, according to Vinod advice, lane mapping table use device tree
>>> to parse makes sense.
>>
>> Hm, I have a feeling that I saw such property, so you should dig into
>> existing and in-flight bindings.
>>
>> Best regards,
>> Krzysztof
>>
> 
> A standard property? Like "clocks" or "resets"?

Like lane-polarities now submitted to one MIPI.

Anyway it does not look like a property of a board. You said it is fixed
per SoC, so it should be implied from the compatible. Otherwise please
explain in description and provide some rationale.

Best regards,
Krzysztof

