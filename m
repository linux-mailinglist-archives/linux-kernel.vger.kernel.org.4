Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD35BF7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiIUHjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiIUHji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:39:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E60A2736
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:39:36 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o2so7761684lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=tNVLuYYtNnbltSH1rqkGLOPuwpfzM6MeggviQef2o3c=;
        b=eeKsByuZdpqmneWBtxLifX0qYSG2bmYLjZyalf15bMTosJPkzUr/gCEWZLyngdl5nB
         iPpAGlIamGrdSLy9QODUQc/I5W5SQjWRUFconeJ5pmif9mzieq8AWqGzTTeI8kwXrY9H
         bosDBMxwk72pOPuCUIikaen2Oo6Ok72BVOQ+w3gIIvs8rxKMYY2Hq/p9TUlfzjMJVWiG
         h71rQrotW+Ef2FQ61204fLN7r/yaYxiQP6yet5sg30e/lu+PrZXDbP9f0F1Vqez9srD4
         /9BR2kiQRHaolnbGHM79h97j+59ktzI4GtKu2iCbPWsua7chMZlVqiOANtC2ZRqK12Yj
         U0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tNVLuYYtNnbltSH1rqkGLOPuwpfzM6MeggviQef2o3c=;
        b=3UISsZofasoyz9SF6aE7sAxHzSQSRaaF9rPXmM1boRv42gXL9j2b7kVap9cq7n73ml
         MOWiCLCdVBC/KjANF/GfSJV5Q7/kHR4WoMs1vV+gESZ42nAVrDcL6B758w9wA9lZbRId
         BC2kk8HwR1K2TPqDilJkiv4Hns6Avd4GOh4d+rfgA4JlDN/ffIh0wWZmJfCnD9Ya50aJ
         IY4AdLy2aOiL5KNKH5kDMJVvQMginDfHDBoWXBES9AzcrJb4E/fCEmI9opKnbC01c6Qj
         lO0S4n7BCEr0HvWwRMpnhQm8oLPTujD9Vx1bM4w3RDjJMsgvCSRUn745HGMFO5p7SJMr
         JNog==
X-Gm-Message-State: ACrzQf2tQ7LsjVVXg5MrMgZ2yDh/z4zT0iOzungAL/9DrMLglLC/n9Ea
        X4/7sWMp44IJXJ0eaFZeDDFnhw==
X-Google-Smtp-Source: AMsMyM72ZI2J7U3/gmd0qbBnFYhpkP11nSbXRVR9n3XjmBlVgP+lFhdLjbYR4M3dycy+3QB5oaH8VA==
X-Received: by 2002:a05:6512:2210:b0:499:d710:9c0d with SMTP id h16-20020a056512221000b00499d7109c0dmr10393748lfu.325.1663745974473;
        Wed, 21 Sep 2022 00:39:34 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x15-20020a056512078f00b00498f00420e9sm316688lfr.194.2022.09.21.00.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:39:33 -0700 (PDT)
Message-ID: <bd65f87f-4ef7-7191-594a-fad2df448503@linaro.org>
Date:   Wed, 21 Sep 2022 09:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/3] dt-bindings: pinctrl: qcom: add sdm670 pinctrl
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20220920222939.150330-1-mailingradian@gmail.com>
 <20220920222939.150330-2-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220920222939.150330-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 00:29, Richard Acayan wrote:
> There is a new driver for the Snapdragon 670 TLMM (Top-Level Mode
> Multiplexer). Document it.
> 
> Adapted from qcom,sm6350-pinctrl.yaml.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
