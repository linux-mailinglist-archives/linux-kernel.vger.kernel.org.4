Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F28E62BF09
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbiKPNHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiKPNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:07:21 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EAE43841
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:07:06 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id c25so21748786ljr.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMmmXbd1AvnwBt1nJKj5RFuyCCJg0LNhiDBkTFZ5/nQ=;
        b=MEgm7zz2qHlyy54OVMZT0PsRe+4rMhcfk5vf9jsnO6rKe5M2JENYTfqrBL5RvdlB+Z
         jqBvApp7d6n/GR3k1+mmN744asQ0t65iI8YJmjlCOKLdf8CnLPnGiFBCzPY7wMZvpaeb
         /+GDUkBXtLSr6Fq0okClScxFn0PPQqVbr7CETbDcYJ6EeM9oC6DdSsWPaGeLI+Ft+O3A
         5jwNc57zxYKcmt9ridnmQBAQuOzvfpKw5FdxB58QMfYNpPPspNEQ+wCd5pEq6NxZo2tg
         IO54+ov22bjrwKGdO0mUY82Rbs0bRzeTkhtPTVYV/x7h/xXYv1hiWtfnlKFpEdDrOegc
         S3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMmmXbd1AvnwBt1nJKj5RFuyCCJg0LNhiDBkTFZ5/nQ=;
        b=LG3nFPf2BughjFMYKfP1OShZnnCDlT/0YvCDYuG7/+zCQZPb1Ps676OGVptXagl2DT
         84xArg7k7Sm1dCrFsdOpsYt/8idCN0orZ1FEzrOe2ItqiSg0CZ8TrFrxlCIszyyjny4O
         i/Wyc6yzmg4ToQ+MF27G7Vz1jMNoZmYYUOWFuUNJ+4WAs1B7vTpKjWQwyFX9/YqcyYBs
         N6DVRU2cJ7FBviE8SNFvf/Q6aCJj9ZyRVJi5XhihCM9R18qE+H0YsQ1oNalz9N2YmFVa
         MlJm+jIC7AMTlZC8JP5tVzOJxA2VJKqOBd9nEiAdKaDqexEA19WSfBlFFozgRnsmAhTW
         Q6Jw==
X-Gm-Message-State: ANoB5pk3ua/i2SLHBsk1Sg9/6icd0BmX7kThdzcGrIqdR940jSkY+ssY
        Y1Cqs7SOXdRcbBYz6JTM5+gGyQ==
X-Google-Smtp-Source: AA0mqf7XxF/qNvuTCDlRAb9MmbqeSQGd5G3rdc3PlEH/sb+ENTMhYXSHU91J+hfqcp/zLuzoirgizA==
X-Received: by 2002:a2e:9998:0:b0:277:3609:bd2b with SMTP id w24-20020a2e9998000000b002773609bd2bmr7215346lji.340.1668604024429;
        Wed, 16 Nov 2022 05:07:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i16-20020a2ea230000000b0027710117ebdsm2997480ljm.121.2022.11.16.05.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:07:04 -0800 (PST)
Message-ID: <39fa75d4-2469-9340-aa0e-31af7dccf504@linaro.org>
Date:   Wed, 16 Nov 2022 14:07:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: qcom,pdc: Add compatible for SM8550
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221116114210.2673902-1-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116114210.2673902-1-abel.vesa@linaro.org>
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

On 16/11/2022 12:42, Abel Vesa wrote:
> Document the compatible for SM8550 PDC.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

