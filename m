Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D267E176
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjA0KVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjA0KVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:21:10 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AED91EBC5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:21:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so5221449wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5M8wwaIB6hTb2DPTPd13/t9PHi09rEsWJLeVtxBFkfU=;
        b=PAxQb29zuGGv5AA29BFPSf3KAUsQ3nHyP+xRhfvF4wlTZjFlRtOHf07wE8ZMIhv9cu
         jf4nlnMmKPwH8nhbJGw7qgwMbyN65/N1EPFnm2XcdZSaz2wbns20UjxAO5kw+WwJgo5U
         Jaam+M2+lX1EQ2TGy3Ar2YFaVRq9oJQ8awLb42jrhol8vaJp0yiXyxBlipNiNPJRjJyl
         A5GaIV0mecZi2notqu/t5bNq9XS1HYsbvpJJks93DaHmBjFh159zmpe7Mu5NZ2/qD0b0
         AUVG3lBormCjK1Dkba0DSUQtcWi0xVaSq1mpXxvJxrsnRZ9I8gwC0yfTUfvXLLTEP+tT
         Xr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5M8wwaIB6hTb2DPTPd13/t9PHi09rEsWJLeVtxBFkfU=;
        b=PHWJ2DMWLkgZtnmPkrHLqV53AK9bYJu0S7ptDiKd/O3eXZy0Vr3oUBQZFPQQ6+4eSo
         oDpufYCP/ISKp4jYoBWBylaQSeDW6pObcD/8PwuMiarkIZZfNrwTKB2yczz58W2mcW6v
         a7/wdyTOC71r9bZeRLKF2PtJk1n2wcsNhV4WAwVUrs3LKA9EytadvbF0GmoqO7iNCYDx
         hPzpwrvb9fWu3funyFcnv7ipuLGFTNuFJS9Pk/essQmd6Z2pi3/YBksaktlugCdLHtFw
         W9fsK1c9+EpKzZgN2PNFN1o7RqP5qLzd1Ma8yjgx5aIBaeLhvEtoQcpeDNkDRRtJq9j7
         Dobw==
X-Gm-Message-State: AFqh2krFmUsMpzHs8YvrI1y573l0Iqrx9jGUWXXCAGiyNlbHYHSrRIOI
        Jqs+t5yEovc5zkaw+rCU+fXnLg==
X-Google-Smtp-Source: AMrXdXtQgHrtT79dnJjv5rE9O7zhxmcspNgS9NhZpF3jn1szrHImeCZB/Se7RvSrAv7pSLj85FXSuA==
X-Received: by 2002:a05:600c:3b1b:b0:3da:11d7:dba3 with SMTP id m27-20020a05600c3b1b00b003da11d7dba3mr37744059wms.5.1674814863127;
        Fri, 27 Jan 2023 02:21:03 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bh6-20020a05600c3d0600b003daffc2ecdesm7243158wmb.13.2023.01.27.02.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 02:21:02 -0800 (PST)
Message-ID: <8c0b2020-cca7-7b16-5bb3-a0e5eddc9709@linaro.org>
Date:   Fri, 27 Jan 2023 11:21:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: Add Qcom SM6125 GPUCC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126181335.12970-1-konrad.dybcio@linaro.org>
 <20230126181335.12970-2-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126181335.12970-2-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 19:13, Konrad Dybcio wrote:
> Add device tree bindings for graphics clock controller for Qualcomm
> Technology Inc's SM6125 SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

