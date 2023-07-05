Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7E747CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGEGAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGEGAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:00:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A9410D5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:00:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so7123470a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688536805; x=1691128805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lg4p70yBEKgSpD1cT2YGaKlK1TI1DMTxkPYru7t7pjo=;
        b=JuxdT/xEit4IrqGeHlnyYjKmGmvgAzwPA8szxaSJH3EZcEWwW63T44Zc6/atD6SZSi
         OHBv//7Ewd32S3ndKkXVvv1U81h/6FDKWuKhz9E+VHS0Yx0Ubstgg3xT7IuJxr5DLfQ/
         +Y9WBvvo46+zTP4dmeFiih5GUAD+tGqaTA9cwBhlS5YhmHgci/emfftL3DCoHUhRaHFo
         nbvT1yD4uC9SPhEGcPcsR99OcyBwYSVxCz+PlpodlKeuhew8rvdUVl5L4Kbvb2TZopri
         4DcwPfXRWwC4l35FCWKhfZg70GjOlvVeaFYDjB8AQhR2Oh+rajLl5L6dXXbcFzPVSNqf
         lBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688536805; x=1691128805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lg4p70yBEKgSpD1cT2YGaKlK1TI1DMTxkPYru7t7pjo=;
        b=F9JektzA9isl8SRIEPSpIrocsVox4j5VPnXZ1jvhzyba52lX/8XTwO2wSznqgrn5uj
         UPBlzPvTS5qoOKURKcT58DRCCzHzCgScPGmwOXA6ZJyog2T2rflNDI90DpQjSMv/z5Hc
         OyfGHfIjvvQCqW+CiThwpluLdLs6aTomAUuYurxbrqDZmj6xDPCQ1VwbxOFvWiIRZMKW
         AIT5Co9nf+q1TcYygXIlAkspySYjRd4j1yp2bCb+w9kvYwzxxbEFE/Mn/FbqiRhj/uob
         LupqWQAuD3pGR2NTjReH80KSnnXZJb8o4dDppOL2vUkcZgZ0HmBvCW688YTrYSOL01m0
         zBwg==
X-Gm-Message-State: ABy/qLbiF9tqqm1pJjM6iaGOXCejuD9qCEbVd08BCQJzg1mSMEOO0hd6
        nFT4a+kyM+GdQ9Ohu5yKei682g==
X-Google-Smtp-Source: APBJJlHovpZJ6c+S3ijS7SQT3N5tbS5WFllsIv8PWnLvlpcF+jgm5rZjp5jo94AHu/4D3FFDZ5JmTA==
X-Received: by 2002:a17:906:a38b:b0:991:f207:411e with SMTP id k11-20020a170906a38b00b00991f207411emr10107006ejz.69.1688536804831;
        Tue, 04 Jul 2023 23:00:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090666d900b00982842ea98bsm14071542ejp.195.2023.07.04.23.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:00:04 -0700 (PDT)
Message-ID: <afcf67e3-a017-b747-a0cf-284a87a8d24a@linaro.org>
Date:   Wed, 5 Jul 2023 08:00:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND v1 1/2] dt-binding: spi: constrain minItems of clocks and
 clock-names
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230704092200.85401-1-william.qiu@starfivetech.com>
 <20230704092200.85401-2-william.qiu@starfivetech.com>
 <1b65e8d1-d5e1-0d6b-1248-d9683be44db8@linaro.org>
 <c5027d42-b9be-090d-bd43-86c9b1448c99@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c5027d42-b9be-090d-bd43-86c9b1448c99@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 05:37, William Qiu wrote:
>>> ---
>>>  Documentation/devicetree/bindings/spi/spi-pl022.yaml | 11 ++++++++---
>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
>>> index 91e540a92faf..42bb34c39971 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
>>> @@ -11,6 +11,7 @@ maintainers:
>>>
>>>  allOf:
>>>    - $ref: spi-controller.yaml#
>>> +  - $ref: /schemas/arm/primecell.yaml#
>>
>> This looks unrelated, so keep it as separate commit with its own rationale.
>>
> Because "arm,primecell-periphid"  is need in JH7110 SoC, so I added them in
> one commit, so do I need to put them in two commit?

You need to provide rationale why this is needed. I would assume this is
needed for every primecell, not only JH7110, right?



Best regards,
Krzysztof

