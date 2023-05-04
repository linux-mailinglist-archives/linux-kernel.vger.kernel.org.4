Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC506F7008
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjEDQld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEDQlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:41:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DDA30E2
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:41:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f6c285d92so124880966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683218488; x=1685810488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvUenGVei7nQV1NZPbdhqe6dVzAgpLwd1C7FvgUlc3I=;
        b=D3wO2ANzbWdSJf1kU0QMbWC8vopBP2cxIwLBAIuybTWb2lPeQZeIMcWVvy2zCYeOtd
         kfu+KJIL1LJz393SLXd4Qy8PlaJpPafYWKR/OMSoxtJCA5LraLe+LWEg4/2bUtaLVAn0
         CRjQXy0QDJhyBsbzkyFNAR9vpUt63cMF3T978OX9oPWIG8Qm71nr0IIg5TbBrrUkTJqR
         YNMbw1tyawXMQ3b3EU3du/+7lORolQpyUgb+cNnUHF0wQwuHgz52rsMDBEAIgzE9Q5R+
         prf2RGYqBkTnN4tUjJWvGeJhNwKBDnko7CdzHqduAHx+ke9dadQU9rrZEsoEfZXZc/q0
         oskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683218488; x=1685810488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvUenGVei7nQV1NZPbdhqe6dVzAgpLwd1C7FvgUlc3I=;
        b=gY6mQUPAw2AO4GDpiD9wWb6ITurOvH8PsGJHUUV7iEsjAyzyvGUM+yVy4Ih4zs1Thp
         ZAVc+SdnYG3V3ZsPCcKSd6FIze9TKFhA28FQf2a5GRqc76Qklv8D2hAuxJ8uZOA73YeS
         xBamfM+uf8OB5ox9SIcMLlpGzHonXCgwOi62TXni3W2aj4iD1vn0xsiBsB95vCxQ+4z9
         KfjHS7fdwosCocT2nNHtAa+BdT4xhcFra6qmcrdW3nOe9lSfA+6+O9J7n/kSyWRYtfKy
         GhXXFgcqplnv7nENth0wIbeTp9x4631iMWiVGlDgB25+T74gUc5h9VCuXgMl8WE1vOMu
         eaPQ==
X-Gm-Message-State: AC+VfDyqlY/qPG4OPst67eTvjh80SHa6SzHLhUhvEvuLX89W1Z0BTZCw
        v4I44qwV6v4/oXILfByp0Ycabw==
X-Google-Smtp-Source: ACHHUZ6mMWWw9f+zdN48Q0JuY+408xe5MZZtFzW8c+CdTJtn071oEb+5NBdnIQ5I0aE1y//s9DDrlQ==
X-Received: by 2002:a17:907:3604:b0:960:ddba:e5c3 with SMTP id bk4-20020a170907360400b00960ddbae5c3mr7101840ejc.32.1683218488087;
        Thu, 04 May 2023 09:41:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bdb9:99c4:33a5:6114? ([2a02:810d:15c0:828:bdb9:99c4:33a5:6114])
        by smtp.gmail.com with ESMTPSA id d20-20020a1709063ed400b0094e93ec20adsm19023598ejj.106.2023.05.04.09.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 09:41:27 -0700 (PDT)
Message-ID: <3f9098ad-5f9a-4614-e770-9abc62c520c0@linaro.org>
Date:   Thu, 4 May 2023 18:41:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: aoss-qmp: add compatible for
 sa8775p
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230504161755.197417-1-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504161755.197417-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 18:17, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Document the AOSS QMP compatible for SA8775P.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

