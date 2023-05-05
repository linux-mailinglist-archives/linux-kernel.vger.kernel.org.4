Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEABB6F884D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjEER7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjEER7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:59:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09DB199F
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:59:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso4017009a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683309548; x=1685901548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vAlt6O6yberXT/q1iCFb3pphBERUMSoJcMq1bbzlTew=;
        b=PX+6PYsnu0Xw0CNoIAe0o3q6cgUBerGRr+oz/zyspHyo16otVFbuWSIk57/rgZlxwP
         Y28zHlFoo+1uibZ01164uLxzE0UBnjmc5GamxUezFlAnKC0T5YUXgPYNLs45+U3AsJ2l
         QrkfuU2n6U6RaRSxHBT9CLdJE0i6ZUxH571n20i0OAvn6NpfqGZqgxyJrEQR1qdbzTRt
         fSNRp9J6h2SVIibCCOCfLf653CTLFqMTmyc3zV89yh+WXf6XM42CUO9YUyK+r7y9nNWN
         qL9PuFkaWhEfk9l98NbQxSlOkV7cODvAya0KEgcupveHEKLDkvlVFIUoSphBI56m4aWq
         sl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683309548; x=1685901548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vAlt6O6yberXT/q1iCFb3pphBERUMSoJcMq1bbzlTew=;
        b=YJZY4mz8QJa1feiqlYm/h9fF6dFYfrasf/5yj4hP2898JCyXxMU9J2LgZLJZRAQTNO
         ApbNp7vT/loV+o3mHlqiFkU2rjzZIFAAr7z20w0U0yqcwmuLKc34SZ9r8Vgt+xUEsODI
         Y6zwvMWrtIP4xwd2Z8sRTt9DRJDXYAkGWaSQgZ7LVvdRncdxf3pBTklm42NekZCE1DU8
         jpOikQIsGKP1qU+CZMm/AACX+pb3Dh8TOhxyC2ylFh4lJyjZXxFNQyyEkQGpAuLvcuYH
         3EcOIP8i2xmh0kITX1D3Dr6WptK0fzeuYF3ZCsETqf7CxaodhDRv2BXfgwpWw7+IUHSM
         Bmsg==
X-Gm-Message-State: AC+VfDwew6JMDs+g9A6B8sC2BjEpGZoAW3VFF1YEwN6MsnzmZa/JtukS
        Ky1jDrp1ShbghUJiEjOVmWh8Ow==
X-Google-Smtp-Source: ACHHUZ7Ju+z84XTMEonG42W1r2skxLO+SYWEwTCp6nYorm/cogWY+g8riUQpHVL4uznC21BUYb8rkw==
X-Received: by 2002:aa7:d382:0:b0:50b:c3b1:9790 with SMTP id x2-20020aa7d382000000b0050bc3b19790mr1978523edq.16.1683309548207;
        Fri, 05 May 2023 10:59:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7dc0a000000b005084014ae2bsm3100547edu.45.2023.05.05.10.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 10:59:07 -0700 (PDT)
Message-ID: <e46b399d-9797-a713-c7d7-162622115d5f@linaro.org>
Date:   Fri, 5 May 2023 19:59:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: qcom: Add Fxtec Pro1X
Content-Language: en-US
To:     Dang Huynh <danct12@riseup.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230505-fxtec-pro1x-support-v2-0-0ea2378ba9ae@riseup.net>
 <20230505-fxtec-pro1x-support-v2-2-0ea2378ba9ae@riseup.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505-fxtec-pro1x-support-v2-2-0ea2378ba9ae@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 19:12, Dang Huynh wrote:
> Document F(x)tec Pro1X as a SM6115 device.
> 

Which part of the comment "Missing bindings (first patch in the
series)." suggested to put it second in the series?


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

