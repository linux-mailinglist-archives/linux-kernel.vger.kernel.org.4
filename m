Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C546AB851
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCFIbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCFIbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:31:31 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F28CC14F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:31:29 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id j11so15562048edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678091488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Xaqn3Wtp4TVTPrRcIPaDbpDe95HG3mHsonCqLhjryY=;
        b=lqFE4D5RDxbwQUwRZ8A+URmExaOLLdnsTZBl1ZHWR92w3O33klSZ676ADY2Nljnz4m
         wsju6Ze2VRK0CIdJzzAUUKrYHdOSaGlrEcG4MxnHggSekX7qA3gmNVp1ZddS6kF9eGvI
         Z2TFzkmtUYBpfO6doocDeiJuL3f7s3QiUkDjPZLRLW6JS/N0hSxXRFZu3mU3TfwqlOVk
         cWCw1rPUvh1v46d9ql3EIzZtyowp9bDiTeISG9oeBq16Lsc9WG/YiDORAkK5OMJVrDWo
         BMssytDifvDaUM71bWpgZv/3XF6mNSOQjgIn9+YEpt2hZphf3FjvYgYUVltKouz6s73u
         9hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678091488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xaqn3Wtp4TVTPrRcIPaDbpDe95HG3mHsonCqLhjryY=;
        b=Man53Bc1cdx7G6F410TnsOufehAZR3TlRFJjOTmXBosGpp/rrAZcqw1cWgFbZ3gdUa
         SPHMG/AlgWV9lyHv6xbYIGqigu6xIO+CEhYQ2NnShV8lLDHiLhwshhzy267y1b7Jj0Eh
         48SMbeloCtG7XMszyn1CdlPhYMshZSDePW1ssz6KrF5nJ5J9mVq4mvfxFqVRiHm07UgV
         /YD1J041lpCLMpo29A7qUA3PZXDeRTtx1zfKkqJQsYE0jFQozz+bSZGVptVIGmRaHnWr
         /BjCqgUiSR3h9VLTPQnx9Qo/F0AmdkBuqAvs06FGU9W7XYeCthBeghBRobqHYXyPxKTe
         08Dg==
X-Gm-Message-State: AO0yUKXsPY3edGTEQdU9NsJHclhW9kj0vgAL6jprL46TeQdwyZ+OQHZh
        U5AxA+cOKzxWWfQZkKuZLTmnfgtjVZfvqF1xcio=
X-Google-Smtp-Source: AK7set/cax5hkkYB7Y6YQ2meozWHhmJVvLlifpdJfjX5Gbu40+9X3wFOrjunz0pSeWuo6UQ2KLuSjQ==
X-Received: by 2002:a17:906:308e:b0:8b1:3ba7:723b with SMTP id 14-20020a170906308e00b008b13ba7723bmr9319991ejv.30.1678091488041;
        Mon, 06 Mar 2023 00:31:28 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id y4-20020a170906524400b008d71e08c78dsm4192265ejm.81.2023.03.06.00.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:31:27 -0800 (PST)
Message-ID: <d54b644e-bdf3-7459-4f23-187dce78344f@linaro.org>
Date:   Mon, 6 Mar 2023 09:31:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230306040739.51488-1-blarson@amd.com>
 <20230306040739.51488-5-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306040739.51488-5-blarson@amd.com>
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

On 06/03/2023 05:07, Brad Larson wrote:
> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

