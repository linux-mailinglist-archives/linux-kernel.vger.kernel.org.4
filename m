Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE9C748167
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjGEJtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjGEJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:49:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292901719
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:49:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9922d6f003cso792994166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 02:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688550542; x=1691142542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0hymjdKc3LsDVZbTn71V/iWvkbZjVQzkC0ykYCrDKA=;
        b=yAI+yvX50cia2w9g3lMHPgK1Gj8OjNFJSebhnkV/MYd6/+cOKoXjNTbDKMyAU8SATj
         YGSwBZUzVqYnNhZ8moPIiSUE50iEZOGh45nlzpgnlzu0Hzl6U/qF0sUrBVfah4MzC51d
         M78rLVgYEdGjqmGgMJ7BXB3glgWDvDPQe3GVJKbGU6BS7Znls1D02PsZNK3N/IPV30uN
         jYGpHwl7mu/H6ypDxCFF9NI5/e0K/1J16CYBp46cMl5ZSX+KVceX9ewajZqQyVfRJ2iU
         ZraZ2nTu2DEeUawCgomituhKmvRfBH5iZMn3zNcA55MQVoKqcL2DWx9A8l9MkT480CUf
         OQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688550542; x=1691142542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0hymjdKc3LsDVZbTn71V/iWvkbZjVQzkC0ykYCrDKA=;
        b=bLG0VlijFm5C7a5T3hzll2H1POxyY75cO4iximRZzwVRwbSEHO1jQTGmfODDEoRLIB
         wp0S1tPePvHnxExAqRCasiWSrKDDGUPqX5LDuLTpJK5wa06P7B3CDq3AmrSns40k34c8
         fNE+dYA35Y7uOkTSa1pLZ4jzfRAmwQsvVe3F8O67fMv313qaB73RncEkjQYh7UBnExYP
         LkdLICHWuS0VBOwOXD8cF31TT6d7YNjruZV4WZJyt6SnfRA4AlsrVneAEG/kLhOaf2UJ
         cUWDchvJS9t220Xfk6UQJRB1x4R6NUarRGNfN8mLXp2NEgvDkjyslgc/1bFwhHkml7le
         hhfg==
X-Gm-Message-State: ABy/qLZHrfJDXK9hkGWv4kTuzR3amo3fj0e5Q2KymMec/OugJ5LjMQvt
        eqykqm2F82djhg6Nc88A+ULz8A==
X-Google-Smtp-Source: APBJJlHizyjKeH7/oYcU4+EGoyZ6s2G1hWWl7OQFBPr94hAtXsAhkUwUDD4PlFbie+q6czFqVk7J3w==
X-Received: by 2002:a17:906:114e:b0:966:5a6c:752d with SMTP id i14-20020a170906114e00b009665a6c752dmr11681724eja.20.1688550542639;
        Wed, 05 Jul 2023 02:49:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n5-20020a170906088500b0098963eb0c3dsm14325556eje.26.2023.07.05.02.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:49:02 -0700 (PDT)
Message-ID: <f888e7e2-9a7d-4525-78a3-cfdecdc8a918@linaro.org>
Date:   Wed, 5 Jul 2023 11:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/7] clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        map220v <map220v300@gmail.com>
References: <20230704163848.169853-2-davidwronek@gmail.com>
 <20230704163848.169853-6-davidwronek@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230704163848.169853-6-davidwronek@gmail.com>
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

On 04/07/2023 18:31, David Wronek wrote:
> From: map220v <map220v300@gmail.com>
> 
> Add the PARENT_ENABLE flag to prevent the clock from getting stuck at
> boot.

What does it mean that "clock getting stuck at boot"? How a clock can stuck?

> 
> Fixes: 17269568f726 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7180")
> Signed-off-by: map220v <map220v300@gmail.com>

Same concerns as for other patches with this. Look:
https://github.com/map220v/sm7125-mainline/commit/e754e5725cb596049df2437d7c857e4d232e87fb

No SoB.

> Signed-off-by: David Wronek <davidwronek@gmail.com>

Fixes must be either first in series or better sent separately. There is
no reason for them to be in this patchset in the first place, because
they are not related.

Best regards,
Krzysztof

