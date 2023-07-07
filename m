Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3C174AB2E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjGGGfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjGGGe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:34:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FF71FDA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 23:34:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d93425853so1900968a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688711669; x=1691303669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lo9Ybkp8C7hyjxxxAW7ckg0KRs9g3goLaPeETqx3qFc=;
        b=roioZ0eYvwTT7tPzv5TyxFc/Ekjoo/kOdQ8i6mdJzkYNlB7+eY0d2uGCC/Hse9ujFg
         5PMz/RRUmb2OORgU9ftSLxbqkbQbX8WHM0IdjreZyMNIz4u+g06CdggLv4FZvhVf9UDz
         7Zsy19b8HgsiW/qYZ1aoa9xeRnBGMDYGT+E+t8NzzW3fYB4GhPEeSz10rRCakKZtPwqQ
         eRsCfqvgQmK00hC+hAXc1HmwnxuNs61Epuegn9DMTBSeArGqbF4UcL4N+jOhb0A0j73c
         3K9xcAriOUVxYdhpPCZyR/giaoafNyCWEN8q/Gvgcyz8c1xq7lA4hV+RzDIPb2dCZv2f
         13sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688711669; x=1691303669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lo9Ybkp8C7hyjxxxAW7ckg0KRs9g3goLaPeETqx3qFc=;
        b=BA9ou4UUTY+9ZBWgzBXbnhmrM0J8oir6inqnBlrnxzmGf41EmLjqQrA8EjbQxmowr7
         xjn3RgdrnA4oJbYo+YkgPXrBHkQoo2/b6tEnI5GxydFnJ57gJluFbdiHHiDnp2L4OhCg
         6OJaMxXTdng2Tb4d4ssXGtNlkZ935qmgGWkhXfkiMMX0SIXF3rCPNtZA4Z/UOkdaUP/w
         tKNiNcmfaFMtmlL7g4f5eMVL+Cjx0wJSWdh94pUekWgU5rJPZjA+skcuhCjasc0cNEWx
         gq3ZY3T6tpJflVOCLOUhNEZ64GY0gOxj7AxRem48RlZE+zIr0VCi/LxnYCajmVXQ5Mhi
         6wwg==
X-Gm-Message-State: ABy/qLY0o/PINDxSb7hYAECz4vykB/LZCBugqbgnV+aBysYdi0MOv3VU
        Cta1mHwp+5hVJa+sahMxZ0GuXQ==
X-Google-Smtp-Source: APBJJlF2VOmcYgfChy7bMAqvwhS2dCJYj3prVbUZDw9t+pJQ45oDeOR9Pccv8izstFNC8DH9mX8oJg==
X-Received: by 2002:a17:906:7a08:b0:974:1ef1:81ad with SMTP id d8-20020a1709067a0800b009741ef181admr3494616ejo.4.1688711669248;
        Thu, 06 Jul 2023 23:34:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y23-20020a170906471700b00993928e4d1bsm1721167ejq.24.2023.07.06.23.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 23:34:28 -0700 (PDT)
Message-ID: <e9b0b9ea-4871-5fec-b859-aebc1a0e6372@linaro.org>
Date:   Fri, 7 Jul 2023 08:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/4] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba
 support
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <1688707209-30151-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688707209-30151-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688707209-30151-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 07:20, Rohit Agarwal wrote:
> Add support for the pm7550ba GPIO support to the Qualcomm PMIC GPIO
> binding.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

