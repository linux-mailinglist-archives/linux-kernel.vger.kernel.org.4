Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EAA60FD50
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiJ0Qlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiJ0Qlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:41:45 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6723E32A9A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:41:44 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id ml12so1863578qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+dZTd+qxlNL4C2zbzq+PUUb0fE++cs6e0qO1dkC+1d0=;
        b=KbSFHZi66J7A7z8J3zgeVIa5ht/8xqzuQQX875huW4Yxvzs81Rms2W3X7/FTEWjZ+P
         LVYnCL5iD+OW4B4UUVsSt3hLdASSw0L+MnWaRRBMOswYb0+Hqhugt9i3JKnk/HFJuNP3
         dHYwWna0yHRQPtvb9aOYYrtAoM9jKIz9UkSQOuMOz/6zelxQc5pGXUKwljjiySfFEeVg
         hp0Wuwh5RN2wOMS3QuGZMT2wq7HauSng1VByL3HCEsV58j6JZK4oKaTgR4AsVlTJJqWp
         yobgRy8IA5nIg5lgm8bsF45RGy/uzdsB/6rj5I8HYvVrUJMrcmuUAuLvnIs5jsBAa3tS
         pBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dZTd+qxlNL4C2zbzq+PUUb0fE++cs6e0qO1dkC+1d0=;
        b=pERklc6ksUMn0yflCLYljhVscp5fmPWdtwrJkXJaSkZeNUEq33GAEIGE/N1M/C2A+P
         qMZqcGIbvoXAEps8Ng1U9yLUJ4r+vqD4KjrILZqzuweyuZZNL3Nq1h6hf641b9iCbrgk
         2aiwkXvG8hn+etaT5dk+9ET+8GWLJxrMa3aK2+r8/k4Cme9mj1qkdcfVZcw5IcGxhyt5
         FLEMK0v8FJMy/bU7/haMPMBBiR9vzJbuXVvXLMeXVVW6pap8mE9QAGl+QoCUGbAgdJGb
         PmAm/sLvW2AOj428pOm1JyoxkqgSaxNlwmP8Ex3B0/KDtU5LwQii4J0ierNvc2tAnzqu
         Jcdw==
X-Gm-Message-State: ACrzQf1Woe7isCPxLUl8dIS7ScljFJa6MVPFn3MmLEEbqi2oukJzKWZY
        xUBnPGwusCQI7kdWxjy89Xkmqg==
X-Google-Smtp-Source: AMsMyM4Bpfo5BUIun3yTRoYe/cizJvgDMhFJDAL/lk4osTM33PmJjmOo3MmEpgvFLr/wWHx3BK8uGQ==
X-Received: by 2002:a0c:e2c8:0:b0:4b7:c1bf:784a with SMTP id t8-20020a0ce2c8000000b004b7c1bf784amr34750710qvl.17.1666888903588;
        Thu, 27 Oct 2022 09:41:43 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b006cf38fd659asm1251996qki.103.2022.10.27.09.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 09:41:43 -0700 (PDT)
Message-ID: <5ac123f9-8583-c6b8-c157-1a255f92f685@linaro.org>
Date:   Thu, 27 Oct 2022 12:41:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 4/5] dt-bindings: arm: qcom,ids: Add SoC IDs for
 QDU1000/QRU1000
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026190549.4005703-1-quic_molvera@quicinc.com>
 <20221026190549.4005703-5-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026190549.4005703-5-quic_molvera@quicinc.com>
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

On 26/10/2022 15:05, Melody Olvera wrote:
> Add SoC IDs for Qualcomm QDU1000 and QRU1000 platforms and their
> variants.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---

Looks good, just CC of maintainers is missing.

Best regards,
Krzysztof

