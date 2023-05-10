Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C646FD7E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbjEJHKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbjEJHJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:09:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F56C4486
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:09:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so12227456a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683702590; x=1686294590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJvf3WnGfiNmFmKHLfiwqmHicsidW15LaCdZqZNR7to=;
        b=CaBXCo7zlGmZqcb46dpr5dnGUiRLX2GuWsmdUXt/KlWSntoyOknfpMG0/Vilp4leNh
         ZQNxDXGovRR/jmNIhBVBZAL1ggvoi/MWDP7SGMQTUcO3LIV0vWHcin0oMsAZQSEfs3/W
         ga/03SxrGNCOzBLAimCOfRBr51ChkvwcjZfu8TRNC7QY8eL20Z6ZTp0HOWXnMJ1uPv2L
         7FxrL9Z/T0+jLqZsqw88TP3nsPrO3/+yZU7qnZJ6DELwjVGLkjxNOs3QFM7moQVgEsFh
         oXzCeUPk0FTa/EaV6alI4R8urepPEZm+cDVxzy4P+I6NYdxTraSDR6dA643OR2LM06qj
         qq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683702590; x=1686294590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJvf3WnGfiNmFmKHLfiwqmHicsidW15LaCdZqZNR7to=;
        b=feq2fb9TDcepNmMjb3R8oSEWsIHRFK/rnp+ZMe3uSHp5atCwrc7UjECg4d1oXoKiNR
         9uMeoPQBTI7LL71PIR4oOFvEqJ6m/gIkF4/sx85/1iRK27jxfFCWY/C+PbnMzvALkUcZ
         HyQ6mFiYXCXKqOfJA3VGGrBEOBFim7PGVsc/NedPutw4jUx29A4635O0sB7DZENdUEFg
         +fgUsXiUcXj3psH2xpdbZjx8LsmjaCzDPjsKl5BxB4NwSg1dYthlHHWyF9tNdsJQLXof
         18gGigrfD1Sc6J38zPx0Ky/S5fIuvlCtZZONOmH1LHC3+RG6+FnespVjbl2s3EhwM2tI
         RPyg==
X-Gm-Message-State: AC+VfDw7vYsGGmkocehvhp+5oig7oDMW9zknqCqpp3xdVruyTHa4tU+M
        tX7+IHohGmax/XD/mzczBjn2HA==
X-Google-Smtp-Source: ACHHUZ45V9nWx+xpymCCTDt+xqMHZN//QImYns3SLixe0knjRClRjdgBA/A6jG8Yv/UnrJA85OvrJg==
X-Received: by 2002:a17:907:8688:b0:96a:3005:61b7 with SMTP id qa8-20020a170907868800b0096a300561b7mr612454ejc.74.1683702589873;
        Wed, 10 May 2023 00:09:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id w21-20020a170906131500b0096637a19dccsm2277509ejb.210.2023.05.10.00.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:09:49 -0700 (PDT)
Message-ID: <0ffa55bb-9869-f94a-17e8-46530c2d91bd@linaro.org>
Date:   Wed, 10 May 2023 09:09:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] dt-bindings: clock: qcom,mmcc: define
 clocks/clock-names for MSM8226
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230509-msm8226-mmcc-parents-v1-0-83a2dfc986ab@z3ntu.xyz>
 <20230509-msm8226-mmcc-parents-v1-2-83a2dfc986ab@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509-msm8226-mmcc-parents-v1-2-83a2dfc986ab@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 23:16, Luca Weiss wrote:
> Define clock/clock-names properties of the MMCC device node to be used
> on MSM8226 platform.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

