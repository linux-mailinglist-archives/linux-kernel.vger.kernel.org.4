Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3297015AB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbjEMJ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjEMJ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:29:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C53582
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:29:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96a2b6de3cbso731656366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683970153; x=1686562153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZFPzkUq5fjkT/XAwddhc7FJwecr3Vxjb2F6rFeEitA=;
        b=D8OkNtQFNmFXcFrQ6E+pgBGiQnwpyxXyE33DVSKsPoQ6Ypj0zKvfhKfyk3tv8OppeY
         Y+U/NIeN369Su9Mihuxk6yqlSn/2e6iloeZ/82ywbhzFbUdiKPT8MWnXRFzVTBhx4q+M
         fNQs3nCW9xpNHwYhFHcTxth2HoVVOyROG2xR60VMGit46t8lnwxRLXrxIDslAxzPmG89
         Zy1LdJsbJ1Y9XQmD0WesRgUknxQBTVd9Q84/O51YnuF2uFhvNnEdEiLUSet8WtDcQgzc
         LjWQlBzF8dQTfikKvHpCR2O+486GtjCf21DpHwYX+wEwcYMR4ASj0rIBGyV7icj2zCnQ
         BoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683970153; x=1686562153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZFPzkUq5fjkT/XAwddhc7FJwecr3Vxjb2F6rFeEitA=;
        b=b5CclG3+RRkwQgZRb4tnjmqmmtkkxfkNmtIgOObIppmST9ysaZAE4vqMSz2Mk9zUAG
         M0dZ6R6kAOvIIsvjdbgUtbQakirTOP1OJQHL7Yy/EmbDfGehUx9XsvAsH265KyUNzvin
         VeD1vlZSfRN5iV3PVdX1vJ1FyuQ0jewKuTxApdQAiHbUTJV2tIwEOVo+uwBnzwNqNf2G
         NImyAg5OPxE7GIM84L+cI4R9FyagmJPeJMbVH+wr8vQhurGXqWdoD8yaxoYEhJJ+qUth
         OjeFAQujigZzGSNQbN+J2JVJieVnVFJ6zmGLsp8fWIC3cSQQAxaDueV7GyoMbMNP3E2c
         RL3Q==
X-Gm-Message-State: AC+VfDxbpVWwzd57wVPQOnGoekWBtc/vxhLPYId2fnzWuvfskxUHOD+m
        uLAXa+lUyzLbxLgoDjeDS6jnpg==
X-Google-Smtp-Source: ACHHUZ7IA9rSCrcG3EzFbtg+41tbzkCdq4ssKuHHqr3GcPR+vSFA+AhYi4T6PVtMxBJFhlKXqwYmRQ==
X-Received: by 2002:a17:907:744:b0:953:83a2:c813 with SMTP id xc4-20020a170907074400b0095383a2c813mr20551069ejb.32.1683970152914;
        Sat, 13 May 2023 02:29:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1d0:810a:586c:c5ba? ([2a02:810d:15c0:828:1d0:810a:586c:c5ba])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906725100b0096a6bf89259sm3202087ejk.167.2023.05.13.02.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 02:29:12 -0700 (PDT)
Message-ID: <c9e37cb2-75f7-e335-05ac-01197a9ba14c@linaro.org>
Date:   Sat, 13 May 2023 11:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 07/10] dt-bindings: arm: msm: Add LLCC compatible for
 QDU1000/QRU1000
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-8-quic_kbajaj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512122134.24339-8-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 14:21, Komal Bajaj wrote:
> Add LLCC compatible for QDU1000/QRU1000 SoCs.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching). In this case - cache: qcom,llcc: - and drop
redundant parts in subject.

With subject fixes:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

