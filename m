Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2346375A7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKXJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiKXJzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:55:13 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066F413183A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:55:11 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id a7so1380348ljq.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gl/7TGyzpy+pZTg3h59RujM/8mUnVgCK8i1ipyGdQvI=;
        b=bLBGzMLkJdfApihJNz1TVCFpdbuZGi8bAjTs50At6ix5G6qvI0ynQStShji4Rob1Mx
         TlxX95JBrwoAynM8mVOVOFxEy+/scuuO/5WCHjaKpam2y9zVc+zSGKDZHYQr83DHxbp8
         xiKXx6RLtA70R7npc6ugH6Vim/vIcsS9jZC/qfvLdDYnKDOlQZSNRSEL3VLBiL78awU7
         nPPRmgV/PF2UbI4ptE/EsZd2Of/wV31K62+rbpGfSQ2Nf5ESpMTPCvLPYhz/4ZC3krKc
         ESUAIFzglxuezwYJkNFO5ux8VZf2kjZjRO3hNyAmufw/XaVvwWh0I8vctMQQx09GYLa/
         wAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gl/7TGyzpy+pZTg3h59RujM/8mUnVgCK8i1ipyGdQvI=;
        b=z+oOvysjLdtBmgAVn9IST17i1elCh5FmzpafoADLx9zNrGqxjD3jXqyf7uYDzLosdN
         1fvyrBbtqsroQDtz7mSfqTc/4jKk99RpPadA+16omp0foFQEVunqUU/QtVbeG0ArIw3k
         EFUaNAK6Rh49AHxHTNgnkOqxTxbSfqctso0H/5TahsRdGMl3UPYHW/TgGxVyBoPX/CYz
         Frv78HZynZc3FNLLeCCuUrMkr9ILyP+hxmSWKcz3rkt9gL0bA8/my9vPnYtzIwheU5mq
         E5YiDMfxYRDKVbDY20JSnzow/tHZcTXzO0FQBDElrJY7DWAWsXR/StZeiY3GxC1HcyG6
         GEZA==
X-Gm-Message-State: ANoB5pklGDouVRa4Na+Yk5tyhK33CJANFbfo3ilKYUwFfsd/ph1uXXpc
        cYhObeHoHrTBgVeMwQklK+TaAXd3D9tFnRvo
X-Google-Smtp-Source: AA0mqf7m0zUtfAC1gOAA2JFViPrXaFEsm8IxniEQisQ0LQOzAEP5G15k2I6zYc2R9mHt+4ZSqvOl8w==
X-Received: by 2002:a2e:a804:0:b0:277:81ff:c2c7 with SMTP id l4-20020a2ea804000000b0027781ffc2c7mr9515581ljq.23.1669283709403;
        Thu, 24 Nov 2022 01:55:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 13-20020ac2484d000000b004aac23e0dd6sm75788lfy.29.2022.11.24.01.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 01:55:08 -0800 (PST)
Message-ID: <9a62202d-2fb9-fe97-5601-f898e589a00d@linaro.org>
Date:   Thu, 24 Nov 2022 10:55:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: qcom,rpmh: Add compatible
 for PM8550
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221123153638.721254-1-abel.vesa@linaro.org>
 <20221123153638.721254-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123153638.721254-2-abel.vesa@linaro.org>
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

On 23/11/2022 16:36, Abel Vesa wrote:
> Add compatible string for PM8550 used in SM8550 boards.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

