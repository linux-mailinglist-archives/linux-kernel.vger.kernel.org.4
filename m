Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340407193CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjFAHA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjFAHAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:00:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6811A2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:00:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-974265a1a40so388837666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 00:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685602808; x=1688194808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZDlrGzZznfoRh38IZ4BuhQJoDgfvEZtOrnmqrwUyyQ=;
        b=ttZtbkT8BFN3nOIpl9ofTPk8v+Lt44fZo5uLadVUPBGWgA+x9LsdD42oeKoIE7R1vf
         44aKBiwmeXDGrKsA65f8N7wvFT7bpRZV7Z2wopeH1jY3E8sKyg+sgBxb2anr1WQ51E8o
         HHan2Ug0EP8LLF5yrYbFUprG4n5ZhnOSfacBYJtHID8jbq8yKhHZANzLMvFT7sZgxWRq
         flj35ew+CxQjJFpXWQgzmXXxPYCj1eUImlMEFy2kaTWPTjpOEro3fv6QtkVuyi6Nbr1X
         Ok/RDMX3/53noGbrXl6CtHAG/1Z8aSyxyfgT1GlCYBNQbVGJyePYc78jiVD9oZpCbQ2M
         A1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685602808; x=1688194808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZDlrGzZznfoRh38IZ4BuhQJoDgfvEZtOrnmqrwUyyQ=;
        b=jlIMXJTCMpFG3xiQwQXvWE4AR3/Fp1quCbMJUuI7yz1yKFF0y2yhCp/Wfv5kcCe29k
         RvsUog01AYe/GlexLVNAcaK/06GcyUAJC4Gr/+UoMZ4836Y2QkBpAI1zbCM3BS31n5Zl
         J4pnfEQvwFHA3qDkNCEGtPuBAK+KBgGDqzN+0Z8w8wZq+i2QMd4Szrckb8SciKY1/Ae1
         c7OR0BJnAfRAqbkaNtV3syFmqdpqq5WlyO3NYu16GvbIyKAnzsjTIvmGZmJyBp+TUtEB
         l0SnwPoR2JH473dke4eNhQbksF4wRnxg6UABi+TjhIMQ782ac8D1CnucKlOdxYeDOJfg
         jJSA==
X-Gm-Message-State: AC+VfDx0cbOsN0eGYwXQgEjmqToc0Xk/t2eT8bxgkJCx15TDcmkdarNq
        uUX4IDH9rO8JIT2SpSV7sFKG+g==
X-Google-Smtp-Source: ACHHUZ4mh5gVUd0k89XyvS9Bk4MnVaXyEnyBLY0aoruOI8MoHI/h3NUE4U1qUwOiXUadHjPQ7cLlLw==
X-Received: by 2002:a17:907:7d89:b0:96a:1ee9:4b0 with SMTP id oz9-20020a1709077d8900b0096a1ee904b0mr760202ejc.33.1685602808456;
        Thu, 01 Jun 2023 00:00:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id dv22-20020a170906b81600b0096f78953b77sm10125944ejb.147.2023.06.01.00.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 00:00:07 -0700 (PDT)
Message-ID: <96f40b17-ad7a-ede2-dcbc-a35b6b7df1d2@linaro.org>
Date:   Thu, 1 Jun 2023 09:00:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: qdu1000: Add SDHCI pin
 configuration to DTSI
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601065805.18079-1-quic_kbajaj@quicinc.com>
 <20230601065805.18079-4-quic_kbajaj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601065805.18079-4-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 08:58, Komal Bajaj wrote:
> Add required pins for SDHCI, so that the interface can work reliably.
> 

This is not a separate commit. The pin configuration by itself does not
make sense and we don't need it. It's part of adding SDHCI, so squash it.

Best regards,
Krzysztof

