Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E796A92D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjCCInf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCCInd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:43:33 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA038654
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:43:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o15so7176509edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 00:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677833010;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1SHnypdnvbI7SIdNVtDw35hlwQf+FyIzygcPEhvN5k=;
        b=BYmToDteLTHaLTm4P9MHkO6cvhq95+Lmg3ZHCcoiaiChkRjBFbD6fIPnwy1OXzkpBr
         pbbqDOcAogwTCRFdFEBqnsd6Zw67bUZ0Ko49rT2RY6zCMPMn3D8GRn1kbe+AK6v87cbT
         zRFmJt2DBxA2tOg6tnn3iDdeV6zVX7s+v1jKYpb5HoeUh9cCKMvwlqEiQZ5M4rUvyI+Y
         nJv6kUvLBbIkUrus7lneqZejeMfWejKg5t/JNkm13alTtUAwOxwWEvsykjTBk1OwfHCJ
         K8+rH5xUvIV7UzEKt2MwAUq7VjgAYHI8ZyrPuPThlYPM+fwfK5K1lZmiUpSByhKv0tJf
         uajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677833010;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1SHnypdnvbI7SIdNVtDw35hlwQf+FyIzygcPEhvN5k=;
        b=Cj0Ep+p07uJQBvfJ1f9MUF42UXS67nOtULu4G4edQKOxf3ICw4ZZP5Fu4QJdMNoncH
         QCylozh7SX/zjNbQfL21fn/jqPOJHtgvwCmNRydllJBsUv0T2gOlui9uENZFWxOtsNDc
         JX06IHJ3WaFBhZvI3xsxrN4c8sz6pMU7jsyxiotS/ouavS8IcCo/nVann0DfCftUX+Jy
         LYoi9o3RMBn3kIoHVW0VuPGGZz4dBFuhg3S19CIcDmFrF0ocrtz7+cbmp/rcgpfKw8AI
         8A2h1HErs+roXkQgXgvj6Y4AREQ0gEVD4qnZDWdr5V/Al0H2B/i7DAq7aRB0r8Tuyt7w
         0dAA==
X-Gm-Message-State: AO0yUKUwwBBcuGYe3WP6+jotF8BYfc+bMJ+XK1zroY2/suR0x9lh+c3O
        kOY0F4UI/UUMN63Da6lFEcbkLw==
X-Google-Smtp-Source: AK7set/+JGRmw9ap1A1Qpd1ItK/VpFw3Zdya1otCv0GrqomDlgivyeq9IO7YrQGwxjrhPnvMiXw7Fg==
X-Received: by 2002:a17:907:8c09:b0:88a:888b:c8b with SMTP id ta9-20020a1709078c0900b0088a888b0c8bmr1062300ejc.35.1677833009833;
        Fri, 03 Mar 2023 00:43:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n26-20020a50c21a000000b004a27046b7a7sm877520edf.73.2023.03.03.00.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 00:43:29 -0800 (PST)
Message-ID: <bd6c9135-e12c-a6ac-db46-416403850751@linaro.org>
Date:   Fri, 3 Mar 2023 09:43:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 11/11] media: starfive: enable building
Content-Language: en-US
To:     "jack.zhu" <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230302091921.43309-1-jack.zhu@starfivetech.com>
 <20230302091921.43309-12-jack.zhu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302091921.43309-12-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 10:19, jack.zhu wrote:
> Add Kconfig and Makefie, update platform/Kconfig and platform/Makefile
> to enable building of the Starfive Camera subsystem driver.
> 
> Signed-off-by: jack.zhu <jack.zhu@starfivetech.com>
> ---
>  drivers/media/platform/Kconfig           |  1 +
>  drivers/media/platform/Makefile          |  1 +
>  drivers/media/platform/starfive/Kconfig  | 18 ++++++++++++++++++
>  drivers/media/platform/starfive/Makefile | 14 ++++++++++++++

This is not a separate commit. If it were, it would mean you just added
dead code in previous commits, so why adding dead code in first place?

Squash it.

Best regards,
Krzysztof

