Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC74268D4D6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjBGKvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjBGKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:51:18 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E9D38675
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:51:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y1so13131564wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zbgcjKYoWJCkhckrue0q7TZn73MXFvSGOBBrPy6j+Y=;
        b=s4CbjzO6J6A9v5S/sUwlmOQ7sOpwKcZ2drd9lFpEQbKXN0DC52EPkz+/dF0voMq8GJ
         FNts/ikE6jxXG87f54+V7O0rgTTljqknT1ds8ArF/vffQypPxvR0qvlyXbk3L6yXbdVY
         Gn12EALOA1vpxLqKowcAKrIkEkl8M2L19faTbEf2sLqE2Jg6cKDdx2PnAJmlFIgV4AEU
         3lFHFhMENCZKrxRKdedtg5APRkfBelNKXhD+TYty4K1q0FuVwjYbzO/8rj2XsRiiZd+i
         hyKPekOLBJ7fnv0iJG4dgFHJaziCyrwffYPsQjrgY16GTWzn0HPJX0nl0s2ZWYN2OFQH
         EKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zbgcjKYoWJCkhckrue0q7TZn73MXFvSGOBBrPy6j+Y=;
        b=o9xKtmUgRhApKM8b7O6e5OErS7WsD+buqxj/Yk+ZLiuGz2PpYrv+4pSGMb6NoLYV8I
         t+s1ru/1Vdm5o2XmLFFApLQAG00s5TqGiqIcceLBN13UxkeljuQOQkjDNde74IZRFtlJ
         XC9gO3uBIY74srwy9DoPaaXc9TIcbAd6cxd1Mn3klWYj0ImrIemq+8YF/0q/xo4yidIf
         teFtP4B/YU34Kws2Fx2c0FOrH4Be03Vhus15HDABLBqRBpMUEzml3Bpc3c3lNvaA1bBx
         pG7yyTTuYP0ewS7YniC4FQ09RtnrgyokZkVcggkhsHrPf/JFmOjpV/cgUpmJ1cjavlwW
         tqSA==
X-Gm-Message-State: AO0yUKX13Z/lkyKpgqtL1u1MUXpUxNIHNT//AJYKuRwMSDX/TGlJ0z8v
        JkaJvFq+zTReqQc4H1DqaVAOvt/CVybAcysw
X-Google-Smtp-Source: AK7set8ZyDYnJ2rUSDX4dEM3L1E32b7g2/1USCexOeAEGZ0Q5WtJ5TEnJ2xG8h7Cy4JEcl5mzBt1+Q==
X-Received: by 2002:a5d:4685:0:b0:2c3:c4cd:2e28 with SMTP id u5-20020a5d4685000000b002c3c4cd2e28mr2209426wrq.26.1675767065169;
        Tue, 07 Feb 2023 02:51:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe585000000b002c3e3ee7d1asm6316806wrm.79.2023.02.07.02.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:51:04 -0800 (PST)
Message-ID: <dff4bad0-c2e2-ff5a-41fa-f419e3d4b957@linaro.org>
Date:   Tue, 7 Feb 2023 11:51:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] dt-bindings: arm: add the SoC ID for qcom SA8775P
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230207100730.218725-1-brgl@bgdev.pl>
 <20230207100730.218725-3-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207100730.218725-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 11:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 

subject prefixes:
dt-bindings: arm: qcom:

(or last piece qcom,ids)

> Add the SoC ID entry for SA8775P.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

