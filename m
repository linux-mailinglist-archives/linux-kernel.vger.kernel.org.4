Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C216FA066
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjEHHBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjEHHBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:01:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D06126;
        Mon,  8 May 2023 00:01:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64115eef620so32227362b3a.1;
        Mon, 08 May 2023 00:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683529266; x=1686121266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jthW37Br3CWW6oDDp73mfLXu8mJlozgP0I5MOOkOdf0=;
        b=Oj3IUqP4wi7mlIkA56gMt2DdHfomWG2wlyiwmRL1ehxXsXIMnOrc7VYHhzaRrQwFia
         f+ZK5t6F2NxMAwoQ6rxxofyNcD8hDlC/YKAAZCMn6ZoKAaTeQ84QKAVyBnIdb3W7iuEi
         GoNl229/h1EIRU5g7vrd7PmUSt2jipcH1nR55g8IzM5WuV/qfkhL5dXVLNhyLNJDP/3M
         bohQrYNbwDWkLtahGjt2z5TxAl0wJxFaACdfAEIZnP0B6Oi73k43UYJ2lWKYvUIZNTb5
         NENHMcSm4iLSfpqdpiZliiZlqQifQSMxrGECdtcYhSW2dMH7KTZqOyXALuRpv5jAObEC
         Xgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683529266; x=1686121266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jthW37Br3CWW6oDDp73mfLXu8mJlozgP0I5MOOkOdf0=;
        b=HlQ5A6w48Qb8nZ4ljFuQKWiQP4plgGpBNYZpRUYNZ+GLQR1B7+U1poZfvd8v69/+G0
         IWg1AL3gfe1CurhtLnanMNdvfEibyPsGkR3NIPVHcvYzoTBaWH6Vqf2gbNnaCn4eRP17
         VSeeSX+eQMUmr0bji1cs7Gj+tEFu8fgF/yJEeGsOywB56xvNo0byDVm7KRPfxI3B3NTz
         zLIqdmdeS+tsGaw/ppL6GEtum2qF4sva49ueRCdqexVvmCsTz/lywhkc1G2/kvk5FrLX
         TLdjagxg+XxCegX29Yj3YpZ28OzzCY9f2e+zm1NQpKvlrj/jhqsV2dy5qwEB7h+tY+tE
         tU8Q==
X-Gm-Message-State: AC+VfDz3U9f2XuAzQ5U7JDq0tSjB8kgd/kyeI90s5MLH4AjYYQvDbctF
        Uxtta9xzj0ivzLL9aQzepHPF6o+Pmv0hgQ==
X-Google-Smtp-Source: ACHHUZ7EQNNsKFSqhaVH+uhIoQpOPTr7J+y/fYLRFXjp3WHBn0CxJfpX2Fhd2tICzPW/UxQyi7BEqw==
X-Received: by 2002:a17:90b:1188:b0:250:32dc:3369 with SMTP id gk8-20020a17090b118800b0025032dc3369mr10934362pjb.15.1683529266341;
        Mon, 08 May 2023 00:01:06 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b001a934af187esm3891407pld.153.2023.05.08.00.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 00:01:05 -0700 (PDT)
Message-ID: <a62d278c-f47c-fa97-185e-b81ff4b28a4c@gmail.com>
Date:   Mon, 8 May 2023 15:01:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v10 06/10] dt-bindings: serial: Document ma35d1 uart
 controller
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
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <65914d45-95fb-9b44-daf2-5885ba62a180@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/8 下午 02:31, Krzysztof Kozlowski wrote:
> On 08/05/2023 05:26, Rob Herring wrote:
>> On Mon, 08 May 2023 02:59:32 +0000, Jacky Huang wrote:
>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>
>>> Add documentation that describes the nuvoton ma35d1 UART driver bindings.
>>>
>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>   .../serial/nuvoton,ma35d1-serial.yaml         | 48 +++++++++++++++++++
>>>   1 file changed, 48 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
>>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
>> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
>> Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.example.dts:25:18: fatal error: dt-bindings/clock/nuvoton,ma35d1-clk.h: No such file or directory
>>     25 |         #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> compilation terminated.
>> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.example.dtb] Error 1
> This however is related, although might be coming from earlier failure.
> I assume you run the check and you do not see any errors?
>
> Best regards,
> Krzysztof
>

Dear Krzysztof,

Thank you for your review.

Of course I have run the check.
I did not see any errors, because I have 
"dt-bindings/clock/nuvoton,ma35d1-clk.h".
This patch 6/10 depends on path 3/10 which include 
"dt-bindings/clock/nuvoton,ma35d1-clk.h".
Should I combine this patch 6/10 into patch 3/10?


Best Regards,
Jacky Huang

