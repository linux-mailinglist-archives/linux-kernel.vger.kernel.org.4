Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79F75E53B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiIUTSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiIUTSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:18:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5442E91D2F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:18:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a8so10793420lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=j7Zzskc2rhkyZt4aqWcee91EDVAwF85JPaMAbyfab3Q=;
        b=Mhx8OwegiP6Jv0hMBn8Y4RWNWr0LVYQ32+KIyYLk1RJWq2KBq2Mk4lk1USxlERFZIW
         NEFus+5qn33Rf/D13z+fy50CZrm6onl+1DYRLTHZdqo0Xq0L1IqGoJCghDE+gUZNU6bX
         W+Lzl1WRkmIkcQVa8Xoh7eJ/9Qp3qmjj3JlCQ5aYwqgRbsOsbgnErp/RgfgOm2/3sB9q
         O87Shl/IEKEQKkfp54oqeP1Kb2ZVCM6hgZaCFQUUVIiCfjGvpze54xE0CaM/oXKOPC6V
         4JuBjShKyXo+WulWpCzCc1bCIWql5ijD9JGklxjn8eI1mk0AGsAGQFeIzHklFhMvc+vh
         b6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=j7Zzskc2rhkyZt4aqWcee91EDVAwF85JPaMAbyfab3Q=;
        b=1GGbK+Fs1RZQYW9cvgnUOwKijGRZpG5alV3vwx/3NFnTqA/aB6s0x18FM+Kuph+uaV
         rLaRdGsT7M5R5QZC0s41oklKfJFybmA0owuyhDS1RuhLSPjv8bQTwFxllojHOOko4MaD
         JaA4BWoDtVEqqwvGFBb7SPXhYOlRWzJsn5VCEJu0S+lwRibc7c48fZRpzFsmosZZfuu6
         DQit1AUaKTkpSDli4Im7kXa8m2hyA1XS15XaSCB6MjTB8JpeJ8wYlGIchO0W22rBQj4F
         WIx02UdFjGLj8vKxaD2Hf7swG2PrImFn9wcQBK/V9tl8mYHBxkYr9M7TjNEFWEeLw6QS
         dZIg==
X-Gm-Message-State: ACrzQf2B6s7MDfI73tZokRlN4BjZerqbJg8TInujoZOVTdWo3zusnSl8
        LW5kDMxFbFB40SxMCfUvbqCvtw==
X-Google-Smtp-Source: AMsMyM79FUTqb3FH+w/AQyWA76aHLgd9cF6t83YWs9qLpGlQ1PFAP5b5BleFg8D2meqIKEtclShxPA==
X-Received: by 2002:a05:6512:11c8:b0:497:c19e:c709 with SMTP id h8-20020a05651211c800b00497c19ec709mr11719279lfr.152.1663787891679;
        Wed, 21 Sep 2022 12:18:11 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a056512344c00b00494a1b242dasm567177lfr.14.2022.09.21.12.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 12:18:11 -0700 (PDT)
Message-ID: <e4e2b3a5-cbf9-86a6-681a-8089d4e22cbc@linaro.org>
Date:   Wed, 21 Sep 2022 21:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 4/4] dt-bindings: remoteproc: qcom: wcnss: Add
 compatible for pronto v3
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
 <20220921043648.2152725-5-sireeshkodali1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921043648.2152725-5-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 06:36, Sireesh Kodali wrote:
> The pronto v3 remoteproc is similar to pronto v2. It is found on the
> MSM8953 platform, which is used by SDM450, SDM625, SDM626, APQ8053 and
> other SoCs. Since the configuration is same on all SoCs, a single
> compatible is used.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

