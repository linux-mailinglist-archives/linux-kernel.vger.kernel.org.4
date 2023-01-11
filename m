Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCE665986
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjAKKzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbjAKKzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:55:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6CB13CCD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:54:54 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t5so10211073wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxXCKDUAt/ugcAI+DZvfbg7KmtNeD6xEZbvZei/U3jk=;
        b=ZnyU31aea6paHgmN2eO8Gaa49x7lbvnUYI68q4UT7GGgiNscqXdTBV8BR2uqomF1kK
         jEAkiRija+iN0XCvjX1DzxlQxidrlogU0V82kJpFdjZL4NRWtucFKjjbEt6XjUIGok0v
         9zSS78JwELt1ODZfnOKDcTIintqN5sgxCrxxc8YHQM2ApB4DiZWCgZAf32vJIW00GTZo
         DRVA/vzj9bNG8XAKQpj42Gn1x+/zVU2vKLfiG2wPCnWzj1BKeSRc7ThYsgBmd/GTrti3
         pwhsijKz/J4xcT4wPYlqZkzUkOXL3BRwcoy7IEcN6xwZxXfF07nllDmq9H2kB4BZ3dWP
         zGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxXCKDUAt/ugcAI+DZvfbg7KmtNeD6xEZbvZei/U3jk=;
        b=x3astr9OgixYQjYjCwvEkrcJjtNAUwae9v0KW8s9knls+ZaD9rASg66PwDnZmXKoKp
         dtrLzAkDSR0Dj/hOHvxFCSmkbM3ywhBsMshs+2k+Sn1Gx2W6Ho7ZkCd2Q2Z5l8ydjE5W
         KTid0n4ZIm2WoYqn4yHBGS2C84qwNwe79CRa/cwN3olgZROQl6wmVC6uiJPW0glkQtHG
         DeRC3/810/MDy6dQCBIZDPCQCr7gJRymsQzRHhI3ZLUSx75i2Qw4QHPYOzzwAclhHCIz
         oWKTIEi2sLaxGXLmZSZj8uba2i8vYJifqVaNYNRMHjxzmwNf2B9qCZz0223YXp+jzaUm
         7Abg==
X-Gm-Message-State: AFqh2krlwQqe0zpWHrCTKX8Z5qzk9MCsnU6zbK0Ajrxu6fboTcn+N4mX
        odP5CN/VqnN3oHS7J+d+tsjU6g==
X-Google-Smtp-Source: AMrXdXutjzfc1dfaq5oIChJut1HAaxFO7LgX1Tqk7Ft2shkRwozE89CPD30ksu8qcUs5DaOGZ6o+dw==
X-Received: by 2002:a5d:5346:0:b0:2bd:c499:8f7 with SMTP id t6-20020a5d5346000000b002bdc49908f7mr988897wrv.27.1673434493289;
        Wed, 11 Jan 2023 02:54:53 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l13-20020adfe58d000000b00296730b5c3esm13557067wrm.102.2023.01.11.02.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 02:54:52 -0800 (PST)
Message-ID: <69b95d48-381f-3443-1124-679657bc9b88@linaro.org>
Date:   Wed, 11 Jan 2023 11:54:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v18 2/3] dt-bindings: memory-controllers: nuvoton: Add
 NPCM memory controller
Content-Language: en-US
To:     Marvin Lin <milkfafa@gmail.com>, robh+dt@kernel.org, bp@alien8.de,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, ctcchien@nuvoton.com,
        kflin@nuvoton.com, Rob Herring <robh@kernel.org>
References: <20230111093245.318745-1-milkfafa@gmail.com>
 <20230111093245.318745-3-milkfafa@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230111093245.318745-3-milkfafa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 10:32, Marvin Lin wrote:
> Add dt-bindings document for Nuvoton NPCM memory controller.
> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../nuvoton,npcm-memory-controller.yaml       | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-memory-controller.yaml

I assume this can go with the driver via EDAC tree. Otherwise let me
know if I should take it via memory-controllers:


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

