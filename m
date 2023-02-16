Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C88F69910E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjBPKX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBPKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:23:25 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E84E41B78
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:23:22 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id he33so3906517ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQPmFYlzbC7KvPA9vOp38pjRFiHeLAnLDwoDfy/DHCQ=;
        b=G+3SK83ZR+HwM9/pu4pN5BF9nCzAAVMNouC4FBsdvrBx/CahgW9lfHK94lhACaEZ5Q
         tqC7+DWQZXXgTWKiSH9amNNGRs45HJ3yC983P8DQwUARHzT8F269RqvWGGybRLke1vEC
         VFVjsLaY7Hjxia/B5LHgftlTN5STrzqIwP52AGpNfCyLhMuE+TFqdFTEkBVuqpwAZuE+
         qP8CiWZOxCsfjVsoNGHIUslW8B/ozITvXANUiKYg9arfgeOqzNuMQOEwEigN7uxBLkJ/
         NaPsqvFRc8FtQP75N00Uw1mDjGiz9irCKX17djHPjqy8Jp8CXJZgyXADQ/lUkQ3bX33X
         VoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQPmFYlzbC7KvPA9vOp38pjRFiHeLAnLDwoDfy/DHCQ=;
        b=z35RKC53E9vH0jG5+Cygz83tcNw8LxkTFxmPGnCp1ASk12mG++sIthc5v3yysQfHTj
         v7AY2ywEi6tCCgIS0usBgpvGTEBCy3HrNs82cOIM/HqZnuSBfKPc3STY7cD12PR01hnj
         7ftq0qsdzvZRgQ9m3M+lP841EJyRx33398fBtDf+BI3kz3ChWLcRTwlj2MkK21SM82/G
         bJEQSXhDA9QUKqJjXri9hv5roPGTRvC5FM8ebIQFFzY/UP+mRxY8bo1KVS6mt/UYkcSO
         AZk+Lzb85DwlARQPDO3NhN5/QiUWbR2L8cl25vc5h2Kx1f3h5Gv52Q1D/iypkj9tPUoR
         Yl5w==
X-Gm-Message-State: AO0yUKU3bRDs+/PcHQExK8GdKM/8WjFwCYuRXjKC4VKfflZchFMh8FbZ
        AIh+1HTBUUJqhLn0n/d0UB/WBg==
X-Google-Smtp-Source: AK7set8RV32dZOV4847Uqa2HdLcRmRKN2CKjNW0l1ybJNPeIB6ipclW+lCXzwJkdnZR3ULc1QG2mWg==
X-Received: by 2002:a17:907:78c1:b0:8b1:32dd:3b0 with SMTP id kv1-20020a17090778c100b008b132dd03b0mr5426062ejc.57.1676543001076;
        Thu, 16 Feb 2023 02:23:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709063b4f00b008878909859bsm617630ejf.152.2023.02.16.02.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:23:06 -0800 (PST)
Message-ID: <41bcc545-6eda-6c30-c600-d97ef009abf2@linaro.org>
Date:   Thu, 16 Feb 2023 11:23:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230215113249.47727-5-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2023 12:32, William Qiu wrote:
> Add documentation to describe StarFive System Controller Registers.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---

Thank you for your patch. There is something to discuss/improve.

> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - starfive,jh7110-stg-syscon
> +          - starfive,jh7110-sys-syscon
> +          - starfive,jh7110-aon-syscon

Maybe keep them ordered alphabetically?

> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@10240000 {
> +        compatible = "starfive,jh7110-stg-syscon", "syscon";
> +        reg = <0x10240000 0x1000>;
> +    };

Keep only one example. All others are the same.


Best regards,
Krzysztof

