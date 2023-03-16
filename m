Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E336BC80A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCPIBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCPIBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:01:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F1359A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:00:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so4075137ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678953657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DSdjDU0w5FQnEaCXOhop9s0Twb0u6rluswiSnrTsDE=;
        b=j+P13YR0eUjpy79tY7AywvIQ9PlyVKEU1GaEf/tSNfcXlIEM7FV9zUVXy6j2pKXPYM
         Kut6xeuKYtDZaPV4kGjFtF4D7JSF7B1B7gC5wDMO7QJh0hlqxq3BbmKL/Zqle7GYmqQI
         Rpkl26zeayrfJLOU9/oTdPpArj4gP0ZdJfIkjQrvgWiyWuVfDErO85CFI9p4+InQHRn0
         E7qexJPA1tPJu8wouLaqykbQe5i5ydFGjwMsMOMcElkhOsxvEvKSt9pgcC+Mx0486HCp
         UN8d7bMya8WAlZvdQycZUuWmZfyBdyZmMmwa9FtOnliLRCyNce9bXtO36uG4DRh+3/9x
         Inug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678953657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DSdjDU0w5FQnEaCXOhop9s0Twb0u6rluswiSnrTsDE=;
        b=gC/AMhGANAXZhTFE/ZqD9BbbbxhHKivUXUQmSAeFRGUtpqCiet9z5Om6Y0Yb/4DRl4
         wcbZyRn73AWtlGU3I9Z/d4TPEb0IcE3D438m10SSvfmd19BIxMWuLTOXNw9B25FY4zEs
         wcEA5oZZSRGOXBOt2GpiEEacLf7rOU4ZcZ+O/9UGaBJjjNa721BSRccn9iIrif4moU6Q
         DYcMsWs5Eu3QdZe+DW8WFE6J7/AAC+VaWJ0LUWbBw0OYQXRwGPwAgiKj0OCRYgBa0zMs
         ZIz7OH2tz10nGsbeOTs1i7fmU7Oy4HhRaa3yPZjej511X1E9msaWQKMZiTDCss5Q0SWh
         Xi5g==
X-Gm-Message-State: AO0yUKWW5tnP5/oplEBKZo/tOB+/ki0Xy2Jmysp9Qev0xDJBNEl+ETl4
        WBxdsdSpHVyEZgdXUFtPiF1i2w==
X-Google-Smtp-Source: AK7set/iWxJbPG/O+5nY7JnlCh+pWaxI5PWWttcrRji7J2jZ3aDvxnXWCfa6qUW0dG/SzIXNfytG5g==
X-Received: by 2002:a17:906:4715:b0:8b1:812f:2578 with SMTP id y21-20020a170906471500b008b1812f2578mr8955146ejq.45.1678953657355;
        Thu, 16 Mar 2023 01:00:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906370e00b008d53ea69227sm3494678ejc.224.2023.03.16.01.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 01:00:57 -0700 (PDT)
Message-ID: <bd3d21bf-24bc-a074-957f-a223105d34a9@linaro.org>
Date:   Thu, 16 Mar 2023 09:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom: sm6115-pas: Add QCM2290
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230315183231.3562580-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315183231.3562580-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 19:32, Konrad Dybcio wrote:
> QCM2290 is more or less a fork of the same design that SM6115 is based
> on. As a result, the ADSP and modem found on it are identical.
> 
> Add compatibles for the QCM2290 with SM6115 fallbacks so as not to
> require any driver changes. Change the allOf:if:properties clauses
> to look for the presence of SM6115 compatibles and not an exact match.
> 
> Note that QCM2290 lacks a CDSP.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

