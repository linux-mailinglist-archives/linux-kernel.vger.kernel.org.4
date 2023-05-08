Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151A26FA1FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjEHIPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjEHIPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:15:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7EF1A4B8;
        Mon,  8 May 2023 01:15:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaf2ede38fso41590365ad.2;
        Mon, 08 May 2023 01:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683533714; x=1686125714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJAuOZRANyE2SdinpFoEnHRS0xVw7wS0nXh6yXc7EkE=;
        b=TaEm7orbd2vqSzVUeBmc39wJhi3Y3BH1uyCp1T9Vjq4L3WqatoZyLpJ1edfB7cb4Dx
         mwjGj8hjI6wYyEO/KtUrDifm2JHCZk+DbtyrkHoEF5A0GbPXFCtxRYOsHOBfYKUrHn4T
         uju8kq3hnh2VDSFeCh7IjBojfsIop+41Y1GZ3utrvn/tsB6/K+oMQd7WBCgETD5G/0bR
         XTlst+Vci8UJz1ZferH/BxL6hKwdGUr9n7bXP+DRAABrZGiRx+BgfR73jTPlU8nkknez
         7D7YtVmMweOWiZK9vyGwBKjC40v1jyFXeiDZ0sXXjVQEAcChAzrKhmcSqWu8fZVNv9+T
         szSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683533714; x=1686125714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJAuOZRANyE2SdinpFoEnHRS0xVw7wS0nXh6yXc7EkE=;
        b=azTq4JYqwiy0GD9WWCWLzgOwitITcO7u5ezA08nvLZscEOnp6o/7bRXW5NxnfFCBcp
         mOTjDnEK9xJAQ6/YKcQ9QtJZUwdrv3dQJLtgRsYTi0gIMojo216hbVwv1i41qxcvKgYS
         so0XXtCsav1WYq9nmHcoAkfwwinxaV9CrHqPmyckhqQ0aNfY1/k1C/+DOy1TLJUhIvDL
         j5vSPvzYVuf5gKD3YDU/n/aIVorv8FFW5cnmk3SjjmFzwagjNa8KNDlltX9PjQbrY3gc
         8li2i7bRHSWDpw9ThhZbDkhUdaz61PIN8maGvBeECHY6K25tg7Y5uMaIg6HlFgFZUyi5
         xwKg==
X-Gm-Message-State: AC+VfDx+c9UsH8C9spZ3JWgSMWscxQfEmAw7XHFfrQmJoJee23YVJCUn
        LXp0q1ziJ4pWNZr+/hkWGNU=
X-Google-Smtp-Source: ACHHUZ49w/3ofYSdXv92t8ck4l5FD0BG2GBqx4beQ/NDKaDR3mzlHm2/pDKmEN79+AHka17ez9cagA==
X-Received: by 2002:a17:903:1d1:b0:19a:bbd0:c5cc with SMTP id e17-20020a17090301d100b0019abbd0c5ccmr10709173plh.60.1683533714188;
        Mon, 08 May 2023 01:15:14 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001ab1a737c8dsm6509331plb.285.2023.05.08.01.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 01:15:13 -0700 (PDT)
Message-ID: <36c718d7-2ccf-f4ee-295a-97dd01fc66ca@gmail.com>
Date:   Mon, 8 May 2023 16:15:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v10 06/10] dt-bindings: serial: Document ma35d1 uart
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     p.zabel@pengutronix.de, arnd@arndb.de, jirislaby@kernel.org,
        schung@nuvoton.com, tmaimon77@gmail.com,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, will@kernel.org,
        Jacky Huang <ychuang3@nuvoton.com>, lee@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        mjchen@nuvoton.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-7-ychuang570808@gmail.com>
 <168351638748.4154745.16515916544783600377.robh@kernel.org>
 <65914d45-95fb-9b44-daf2-5885ba62a180@linaro.org>
 <a62d278c-f47c-fa97-185e-b81ff4b28a4c@gmail.com>
 <25b2fcf6-6ba1-8e51-59e1-2dcf84b856bc@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <25b2fcf6-6ba1-8e51-59e1-2dcf84b856bc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/8 下午 04:05, Krzysztof Kozlowski wrote:
> On 08/05/2023 09:01, Jacky Huang wrote:
>>
>> On 2023/5/8 下午 02:31, Krzysztof Kozlowski wrote:
>>> On 08/05/2023 05:26, Rob Herring wrote:
>>>> On Mon, 08 May 2023 02:59:32 +0000, Jacky Huang wrote:
>>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>>
>>>>> Add documentation that describes the nuvoton ma35d1 UART driver bindings.
>>>>>
>>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> ---
>>>>>    .../serial/nuvoton,ma35d1-serial.yaml         | 48 +++++++++++++++++++
>>>>>    1 file changed, 48 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
>>>>>
>>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>>
>>>> yamllint warnings/errors:
>>>>
>>>> dtschema/dtc warnings/errors:
>>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
>>>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
>>>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
>>>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
>>>> Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.example.dts:25:18: fatal error: dt-bindings/clock/nuvoton,ma35d1-clk.h: No such file or directory
>>>>      25 |         #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>>>>         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> compilation terminated.
>>>> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.example.dtb] Error 1
>>> This however is related, although might be coming from earlier failure.
>>> I assume you run the check and you do not see any errors?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Dear Krzysztof,
>>
>> Thank you for your review.
>>
>> Of course I have run the check.
>> I did not see any errors, because I have
>> "dt-bindings/clock/nuvoton,ma35d1-clk.h".
>> This patch 6/10 depends on path 3/10 which include
>> "dt-bindings/clock/nuvoton,ma35d1-clk.h".
>> Should I combine this patch 6/10 into patch 3/10?
> No, it's fine. If you got the reviews and acks and no reports from
> kernel test robot, you can go in few days with Arnd's request and send
> everything to soc@.
>
> Best regards,
> Krzysztof
>

Dear Krzysztof,

I got it. Thank you very much.


Best Regards,
Jacky Huang


