Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C865646D2E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLHKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiLHKi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:38:26 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4AB8DBCC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:34:44 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id x6so1078730lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wlomM62NFx1YHTfCjgWd0qifHffMzgJBx2BRZ3hlQI=;
        b=Zgs/O1aroG9LaLScW+tiEaN9cZft2W8o9Evv0YHTmeo/J7OWXlj5LJEwhNgAobPHiU
         uilgBPlUmdc3dWoJqKobg/6nC4aL2RxR6aNKFTHd4U4P3je9IK7UEqrTPICpSn2ctSGw
         eUDfIP26E6Lw5Wv+vg41sGJQZ8NeuitsqCbYENnre0i2tddoYSvnfc1eEO69kmz9/+o1
         to1mVogkoa5gKRNde/SInp3how33I8ithQmxEwteCeiJA3PwCGK8QgY6btRuN9enSPAI
         knbNp4fHecsdEiSDq7pit8IZ8kZpXrooa222ZVaz/3sn/sfoy9dadArhBzNRkmI4FPEV
         cmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wlomM62NFx1YHTfCjgWd0qifHffMzgJBx2BRZ3hlQI=;
        b=OiPGNKxPyAKKEekDEqlkxCCQBuWpXhf55EnilghsR31JTwRBQwVf7zyHTCupOetq43
         E2trPK+p0hkiOJQFACIHb03Ppciafb+Kh5KiJB55pmojJG4kWA8t+xe1GLt39tEOS/gI
         GH5Z8ecQftQMHARE3o3A2ywbvgPU2RkdLLH/inpFcy/OyN4hpOoSpYi/CdLX5clMZdnb
         ACpGNkliKvXHG0JJudbB5+Cz+Sy3hi+6+JFnerDJO/YkBtwK0gJixQ4WMGhwmCkOMUdS
         iJkoiqlPAqgl+J25aPsGI7n5SHhxXaMn6/aYIBRJI3nE81dbSaF3bYX3DZNKe4GDusZT
         d45g==
X-Gm-Message-State: ANoB5pl4kOK8HR0z4dfNb6RDgetjV+QOF7wVIoSqPiUffBMoG7QyAKaa
        cimG47erzli9kyw9ptf35hZeow==
X-Google-Smtp-Source: AA0mqf7o/RMvkWwS4aIlrO6d/DFiefvL6HYy0xc580iCs1mlzMpUSHlZ3ewFzGXX1TIm3rivJd8baA==
X-Received: by 2002:a05:651c:198a:b0:277:6c67:1a7f with SMTP id bx10-20020a05651c198a00b002776c671a7fmr30533917ljb.133.1670495678436;
        Thu, 08 Dec 2022 02:34:38 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v11-20020a056512096b00b0048af9576d30sm3287258lft.83.2022.12.08.02.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:34:37 -0800 (PST)
Message-ID: <f2af0b1d-dfd9-32d4-8638-2023fe43f81c@linaro.org>
Date:   Thu, 8 Dec 2022 11:34:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] dt-bindings: leds: Add missing references to common
 LED schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yi Xin <Yixin.zhu@intel.com>,
        Mallikarjuna reddy <mallikarjunax.reddy@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20221207204327.2810001-1-robh@kernel.org>
 <20221207204327.2810001-2-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207204327.2810001-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 21:43, Rob Herring wrote:
> 'led' nodes should have a reference to LED common.yaml schema. Add it where
> missing and drop any duplicate properties.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/leds/leds-lgm.yaml       |  3 ++-
>  .../devicetree/bindings/leds/leds-max77650.yaml  |  9 ++-------
>  .../bindings/leds/rohm,bd71828-leds.yaml         | 16 +++-------------
>  3 files changed, 7 insertions(+), 21 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

