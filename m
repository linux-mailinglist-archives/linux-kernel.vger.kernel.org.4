Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1A26FDE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbjEJMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbjEJMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:46:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DE42116
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:46:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-953343581a4so1111568266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683722760; x=1686314760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+GAXgKKqLnJrZPTG1dBuVZu539BZ2VsxFnQSgAU5CU=;
        b=BYx6Cfdzz3EhDB4qUMFWjkjugUsbbEOYVB+6e9+oHXHsePBAOiGIBZfkglBtnmYwZy
         JG4QbKk0fZSV8i4rnb+VmCJSBlqXDZiGEqEFOkt5rrhbMWPGuLJOzswRX9IIj0u/FRpx
         aUi3xBXUfBGb1qfxd+teP3TKaMgEXjr3JYd3NcYCFqJnGympnU8eduU4n64S1aEe6AK+
         BGjuay3kK/DeJWwLjzso2Gl/cS5PUbGcq80meZIPUooh0bR8msETdrSG7/SpUMMJl8DB
         g2C718dTIvgpKQpAyXMURry3f3AiJlTRZF9DlXSxNpEHzlTJGfPbOX3oWoz5lVOzkPQO
         aayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683722760; x=1686314760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+GAXgKKqLnJrZPTG1dBuVZu539BZ2VsxFnQSgAU5CU=;
        b=O4dXvaVxz3AGrhpMqft0meZFZFSKJSrDp3XNAY4wGBOHRedaq/1T+xRC/T5ak5hvxG
         8POKbKP9gB/0Ph1XjJ1VQHneCzGz4s5+PELaLppFJPJ0FBh798zdWElOPC9f3oNW3vnl
         H2SNQ8Ef9GXNgbVaXmYTkQuMFWKxL0kno3pRHNpf+SZL3gbe9XY6sGxK7Z40GGJM2tPd
         uIDnc6gttmS4Lj+sCzwgbFygYFErySKg9H1cadDC5KuTUYhzijAY/d1lh580hc1Qwih2
         LX7+0Wpfo3xAgGFKJDg0nFygDXlEyuGz6cJFw6qCNrwuZIob01gg1vC2ANMT1VZixhvm
         pLag==
X-Gm-Message-State: AC+VfDxhdco4M3IW3VdjW6TpSNdUY5pFiOwbJZRSVYFaDSCCUjDauduA
        7hepnkZtG7S/izDl2TuAD6rLyQ==
X-Google-Smtp-Source: ACHHUZ7GaUKUCqtCApScxrhvWbhNQxQqNb8+624SHR+r6CSp3SP/aW4XVqD1cmULgpBP4VQEU29jpw==
X-Received: by 2002:a17:907:5c6:b0:939:e870:2b37 with SMTP id wg6-20020a17090705c600b00939e8702b37mr15414063ejb.70.1683722760139;
        Wed, 10 May 2023 05:46:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00960005e09a3sm2677528ejb.61.2023.05.10.05.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 05:45:59 -0700 (PDT)
Message-ID: <b5c48154-134a-11fc-c2ce-47c1579a3de6@linaro.org>
Date:   Wed, 10 May 2023 14:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document AL02-C2 board based
 on IPQ9574 family
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
References: <20230510104359.16678-1-quic_devipriy@quicinc.com>
 <20230510104359.16678-2-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510104359.16678-2-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 12:43, Devi Priya wrote:
> Document AL02-C2 (Reference Design Platform 418) board based on IPQ9574
> family of SoCs.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

