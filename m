Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B71D7258C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbjFGIze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbjFGIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:54:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302FD1BCB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:54:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so1088963a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686128042; x=1688720042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X96dpBw8S4IY6Gzd4KpRfg7hYofA6lqYbeQBswygWX8=;
        b=Rub0Qx/sbOrUtTriSDzOsFqIWDAXZSm2DLB0RlGmTUNapdv6VM5lxilTBurtQiorNa
         vxKd47kcNmBomEu4Y57Jxuik9LkohylcEJjsxRXyAbQpbf9OzeICl3cUQrQzGN267+71
         dxZ5xN4030LlJtPIm8pI3kQtk5z+ABjbfOjfGRL11DR+jHpe8Nq6/BujsirGk0Rf7ksq
         t6MNLB8Z1pl9AWNn1W+G8AEnX3DLhSWhvEgYC41ccVEaC96qm2RUQ1AknQYkEyNgtVNy
         F1srZXKIbcXJJURehv9/tC6y0dciIv7xVeBVhdQE147nCZ1Pl76eEFyhRzEHkyv+PO6e
         8zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128042; x=1688720042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X96dpBw8S4IY6Gzd4KpRfg7hYofA6lqYbeQBswygWX8=;
        b=aY9yydpHC3kRPq1C63goNMUiGHhATfH84Y5zckZP7LTrLuf+I53Mn9IZkMx8pBVnIi
         QMo7b4Rs4idt5s6OnUvReoW6vy2ZW9D7RO8P53+0IZYNAvFegCDL2t6Y7XSB3j6a7xue
         8QqUOip2jW/tboEl4ltvIqyQEWmnrkBXZV8zezLq8ZwzFwya334IcW6cKVCGy4luXf+O
         d0nf2CDjF7Qj5GlVNV/Oujfs6qpqUVq90rJumiRmKSMngoxY3lkTDjlNplKViG1u/v2K
         57THU962jxyqBNuo2abRFxpyn3muKkXq310QLzDvp03p9BDo4pOYIexy95ZalNl5ai1Z
         efPQ==
X-Gm-Message-State: AC+VfDx0MIBgK7PdDMPjzb836LVQl7N1HQIx5KKB1Gdhc8I1UMvVNJe/
        Ah4flPi0pWJioXdT8ZQ7kaUcgQ==
X-Google-Smtp-Source: ACHHUZ7yX1CFlPtzj5ye82i6EMSyNPrLJX5q2v+anBRmgx/s3kNd1PeNOoPKK0AdUrHHxO7MOx8/ZA==
X-Received: by 2002:a17:907:3da9:b0:973:f321:36a6 with SMTP id he41-20020a1709073da900b00973f32136a6mr4765561ejc.31.1686128042291;
        Wed, 07 Jun 2023 01:54:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i5-20020a170906850500b0097886843f75sm328645ejx.177.2023.06.07.01.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 01:54:01 -0700 (PDT)
Message-ID: <08da4e86-433a-7d2e-25ff-ffa24221abdf@linaro.org>
Date:   Wed, 7 Jun 2023 10:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] dt-bindings: nand: meson: Fix 'nand-rb' property
Content-Language: en-US
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230606193507.35024-1-AVKrasnov@sberdevices.ru>
 <20230607095802.3adcd4f9@xps-13>
 <166bdc27-f77c-9076-f866-180cfa5bff76@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <166bdc27-f77c-9076-f866-180cfa5bff76@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 10:40, Arseniy Krasnov wrote:
> Hello Miquel, 
> 
> On 07.06.2023 10:58, Miquel Raynal wrote:
> 
>> Hi Arseniy,
>>
>> AVKrasnov@sberdevices.ru wrote on Tue, 6 Jun 2023 22:35:07 +0300:
>>
>>> Add description of 'nand-rb' property. Use "Fixes" because this property
>>> must be supported since the beginning. For this controller 'nand-rb' is
>>> stored in the controller node (not in chip), because it has only single
>>> r/b wire for all chips.
>>
>> Sorry if I mislead you in the first place, but you could definitely
>> have two chips and only one with RB wired. It needs to be defined in
>> the chips.
> 
> Ok, so to clarify: is it ok, that in bindings this property will be placed in the
> chip, but in driver, i'm trying to read it from the controller node (thus  in
> dts file it will be also in controller node)?

No, because how would your DTS pass validation? I understand you did not
test the bindings, but this will improve, right?

> Because in driver there is no sense
> to store this value in chip structure. 

Driver does not shape the DTS. Hardware does.



Best regards,
Krzysztof

