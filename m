Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BE15E8EA8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiIXQ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiIXQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:56:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E23857E6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:56:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a8so4722315lff.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=qCvUzRzeULor4WnIiJD8wT2Pery0VW3IjzzZAt+uUKI=;
        b=YrT3IgVkLxnd7lidhwQ5ASDEIJwxgK36UxOQkbdeRE7hB0B8wzZBtMF0jfsEL5rnMJ
         TmhP2cc7k2DOZULm2xKxAQwR6NEaCgCknCft51BBR5i6G0ierThFmNjmt+AUuxyQduMy
         t0eLTJ1C5ZZKjqwBCcmQjLPxu4HwHkEVQULR8JrXmZHTPgSyZv/yV9O+Ryxu/LElp6h2
         i42ASsvHNuDzXVQjaMHifVay2O70bcey4kpW8Rsxila4FZUIg/5VsM5ZEeM79Qk1DCbD
         T2Pq9JeMlZ19HLmQg+O+0Vq5X8cC2RKZqizzdRLL8sdmTKeRCWSRIeA2+Y8iTdNGzhK/
         mxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qCvUzRzeULor4WnIiJD8wT2Pery0VW3IjzzZAt+uUKI=;
        b=s+kwo+QWfcn1vLH0EOLbH6t1f0yP1E7qptXWPYxF+z2KT4eabbdp7NtMi558kzh5Ce
         QYZjX/92L/1QbDTaoWF3PTEr7L6xcGQkJmcOe8MgNJQ/FLmNXtQaHbChWMdltqY2Ifii
         Mt54jgGTahTiIwSk88JbK+AEnEABqUKvxTFZR6iXln21wK5UBZQwjpjuNPxoAmkzqQup
         OMNWligj5G2bF0+yoxq51Xc1Mqhqip2iZHjkETJQm0OpmcWBw9IKCmFJ346rNy/1++8u
         Z1wAOKC1tNVXWN3NUIkJNRGmFb32W1iECafaQdd1pJsjfTzmFpHufTXIh2pB2aXyyE95
         ox6A==
X-Gm-Message-State: ACrzQf1UskQHlvf8cU4F9eIOiUKIV2bQd+6tUkAiJOHtibAarqyEOmVp
        mjLY6iWIWfWx6Y299aIH1ouDAA==
X-Google-Smtp-Source: AMsMyM4cBGD1nJDClwlGskZMtBadV77/jXdaK8NpBV5chtC2K4VAqeN5up0Rn8Uz0Cyv6BPxMYK2PA==
X-Received: by 2002:a05:6512:10d1:b0:49d:7dac:e2e3 with SMTP id k17-20020a05651210d100b0049d7dace2e3mr5464359lfg.224.1664038561051;
        Sat, 24 Sep 2022 09:56:01 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bf31-20020a2eaa1f000000b0026c2e0258bcsm1844780ljb.42.2022.09.24.09.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 09:56:00 -0700 (PDT)
Message-ID: <ea2d5008-d250-cc5a-e608-cb35a6ad67b8@linaro.org>
Date:   Sat, 24 Sep 2022 18:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] ARM: dts: qcom: add 'chassis-type' property
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220924154422.9896-1-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220924154422.9896-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2022 17:44, Luca Weiss wrote:
> Add the chassis-type property to arm32 Qualcomm watches, phones and
> tablets.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

