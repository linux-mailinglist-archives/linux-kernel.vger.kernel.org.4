Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B357B63BF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiK2LeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiK2Ldf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:33:35 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AD11C919
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:33:33 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e15so8678417ljl.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ix1zUCbgQqNjiqrZotQcxi2n0mLA33fCJ/Y8CbfyMak=;
        b=AWgMKsiwlMHio9kpBzCQvD/Ikan06tkuZEXzm8Bq0u0AL65Z3pmqoLTGuwLcBp6ftb
         5lsUyNTlSd6wAZvru5+oF9j+zA/3n3bX8XMSLF/Qw84jB+Nzj3j7rYvzS8AW44dCCBDF
         MZHVxnHjpnpTuWCPBEz278jt6ssqw2ltd7XoEkQrRIDV6u9Jk3pd73NBP33cHMcIPEfM
         L4RSWf6DGGLi9Jwo9UFYEWZg6GSCNHLkdplVMChycoJ6Z9FI221h08HR3n8GG4b0WkyH
         nXcRhqhV9EG9lk1r7/dTzCSqem8sn+WTQGoh79t4kjJpmVz8MkVeg4YYc0tp4r6Tvz4d
         f51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ix1zUCbgQqNjiqrZotQcxi2n0mLA33fCJ/Y8CbfyMak=;
        b=Gg11LkLAGVPXPLIgyEJFn9VtwYav1eKgHkVNqI5HtlncSRTBIt2dBANNUhybPIpRxc
         6dYIedAe9AGGmMhxHuUamIRTOueJAHlpLOn2Fh0OuIR0P/J/+RCAH80xvY0e2Kms10BP
         U1OXKlBueXqlukhtFrAOGCJ7B9ELU6C6TLge52W0t57zTLyaNLnSovAbMzxzB7DoDpiy
         tn6SOrs9H0lEnPRz+4C5xCYKko/XPFZFnamSPMlA3TsIHMVQlhkVLXxSTcW6Z7kCRqtl
         tPFIRu+5EBWCxKvTrmBCHwaf7S+OqZpOuTZIjQ2DCuoM1uj5zd2+qw1WwnTEIeI2L90I
         c6Rg==
X-Gm-Message-State: ANoB5plSJN9HMwvhZW8ledt/oz6Aqu5qrxvq9mgQqn23WBGYalnOKijy
        /vCfoCz6wIU6MH3UFK0zjd35tg==
X-Google-Smtp-Source: AA0mqf42hOdOIcYYRA19T0oydUDPcwBysm71T+mKzWQ2bo1pnDXFQtkZEXIKYGqcaWoHrBQMgyNU+g==
X-Received: by 2002:a05:651c:1948:b0:277:21c8:aac5 with SMTP id bs8-20020a05651c194800b0027721c8aac5mr13621365ljb.491.1669721612097;
        Tue, 29 Nov 2022 03:33:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512074a00b004b1907d85e9sm2165160lfs.161.2022.11.29.03.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 03:33:31 -0800 (PST)
Message-ID: <946465a8-9d7b-2a4f-dcf8-062ddf01aa91@linaro.org>
Date:   Tue, 29 Nov 2022 12:33:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: qcom: Add zombie
Content-Language: en-US
To:     Owen Yang <ecs.taipeikernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Matthias Kaehlcke <mka@google.com>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Gavin Lee <gavin.lee@ecs.com.tw>, Harvey <hunge@google.com>,
        Bob Moragues <moragues@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221129191901.v6.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129191901.v6.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 12:19, Owen Yang wrote:
> Add entries in the device tree binding for sc7280-zombie.
> 
> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> ---
> 
> (no changes since v1)

It is the third v6 and still no improvements. I am not going to repeat
myself, but if something is not clear in documentation let us know.

Additionally, each submission must be its own version, so this is v8.
Your next one will be v9. Not v6 again...

Best regards,
Krzysztof

