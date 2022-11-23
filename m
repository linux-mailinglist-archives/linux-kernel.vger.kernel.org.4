Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C426359D4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiKWK1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbiKWK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:26:43 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1215130C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:09:58 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u2so20837424ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RjVx0yPImCcrCeHJYSZsdrbYMFr6VcjIJVu6xhC1kYQ=;
        b=LoDEChFlLgzRfgj2sVBMbstyjMSGKEC6XjMZqmuvucEVuveBIlMXgMMSiuI++6+IcQ
         aS9bnxmzJlAaKE+MfOds2q1b+s9mvevdH7oyVKelyHFFwUitnM3B6hVK/Q4+dSUZML4m
         Shqp7BNXicViAayytoxOzh5SIR1YozQRAcKIIho5gSGw7Yly/2XOiUkYyMnPzevrBxSO
         9eKLGtlDGoav4GxFExmr0nsywKeoBzKpnkjYraQgBUnOY+M7H4qofnwhO41PkZw+vYzx
         wXuLtPXV8ddWlwU8afXb2XTDejwM14uouwWAX0eYMVU2UOu7cuRnrakbiNz7eCLy607j
         FcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjVx0yPImCcrCeHJYSZsdrbYMFr6VcjIJVu6xhC1kYQ=;
        b=P0jpLd3A8G9YB8R+81OmfkbIgO1mBMi89hTOHAL+7qK+9W8jr3aIH/dSz0SVt1MwiZ
         GHEHrU1BCJAgPtdnPTnuV278J+vU5naFFjaVDHH7ADbjZb1VLJzM0s1Fa0CKHLI4D3NJ
         b1Ies1cp771eV4Ds8aeAikc+hD8TewLWjZEVENVSoTZXk6PrsHWtkX8zq9vtN8CMQ9nP
         lCmdDn7SF6q2kBR5qX4dA1tGvsQ3IgP96Uxona2hBB6jKC73r/jkkcZ2Jx0NjTVP2Ttt
         H/CNZsCLpVsAZ/qMnCCmarU4jbj7cxftEu+KoR2E5l1I5ODJ7PIxnF0iekTZaGFzOtJ5
         uakQ==
X-Gm-Message-State: ANoB5pkpZElCRHf37YVKO0Fb/obG4bRW4pjMSh2uaK4KRJ1D02MBbxS1
        VHRiDMPPkOJwNQ4HaAJy3cE34g==
X-Google-Smtp-Source: AA0mqf5TV5txgsK0WFTA0l4gRjfGYwijM8avNcNq2kGWPcaw69fP3+7jectvC9FDgDMfpYRzpwNglg==
X-Received: by 2002:a2e:8891:0:b0:277:a4e:98f2 with SMTP id k17-20020a2e8891000000b002770a4e98f2mr9186739lji.358.1669198197083;
        Wed, 23 Nov 2022 02:09:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c28-20020a2ebf1c000000b0026b2094f6fcsm2141922ljr.73.2022.11.23.02.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 02:09:56 -0800 (PST)
Message-ID: <09a443b3-4e27-a751-ba2c-057d69363a13@linaro.org>
Date:   Wed, 23 Nov 2022 11:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V5 3/4] clk: meson: s4: add s4 SoC peripheral clock
 controller driver and bindings
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com
References: <20221123021346.18136-1-yu.tu@amlogic.com>
 <20221123021346.18136-4-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123021346.18136-4-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 03:13, Yu Tu wrote:
> Add the peripherals clock controller found and bindings in the s4 SoC family.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  .../clock/amlogic,s4-peripherals-clkc.yaml    |  105 +

No, this is total mess now.

Additionally, you received a lot of feedback but your changelog says only:
"V3 -> V4: change format and clock flags."
so you ignored entire feedback?

That's not the way to work with patches.

Best regards,
Krzysztof

