Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97035BFA50
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiIUJMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiIUJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:12:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B88C44D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a14so6172488ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZjHHQRJGwuqbDb8JIxiASWCllE12kTjIQC60uJoZPaI=;
        b=YuErZJV2pcu4GLKPVzROsL/ZFPM/2cBi3CO3JcxSL0sLn2a0aoSKkQ49biOU3vQFl4
         rFuD5jTF7kr/tV/QRX8D7qFA4+NjcdWbKqSzzSyPvg2lSv6TrOUf3HyOY0NbL0s4aWHy
         2ZmoNFiV9Dv8RFiDbHC6rVPqvP9/ldz9T9uENNTe17wpDE28tSUHmDwCWExEO7+1m0mO
         ipGEVyO8kYnFhGKEO4gt8A1wYCvy8+23sKy+bq9zQSJuILIqOP1SZx0Ng6Y4pEZGQPfw
         IqU4IdRvxGTPaDsvwhCU02Pr40YgjsYT6mGUkHsACiHdCUGtJC23f+kBzWr2ZhbmixBh
         kLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZjHHQRJGwuqbDb8JIxiASWCllE12kTjIQC60uJoZPaI=;
        b=FGy5JaMdu50kaZu2yCwRggj/FY17nTqgoQi6Jl4OIhNh+1u2QTOZQifM2OpN84ElOM
         UhyTkemLf2jG5pCPrRtU3J/8uwhDDNL99pblz/4ZZ1+uh7iP9/jqk3EXSArWUBXE8/B1
         S4x95J3HtcqD5zvJPIcQw1o/HXdLL1RuyC3aeCSa74pNVbXu7W9ZoOmgYSlnFuAuoSVK
         qRYwVvl68kX8lRkoaA4/cVTlueRfKCaZYxILJPPU3yjknlk6LdnxLGUzYiiJrBI6C0Zo
         1cKyWxYZ4FwtT3gTX/NdCFb8xxeHVZuiAAp6FymHMx0OWsJT/vWrINSz09C3eElvzrVi
         Khcw==
X-Gm-Message-State: ACrzQf3RmAE/mH/31HzOE6BA47HvQJjTwgdc2St3E0TWUjj1mjbNd0V5
        KH9YSK+zWtvzik/jZdpiLlvUbA==
X-Google-Smtp-Source: AMsMyM65d5eh3QTDjIdjafQW8dzPMN1JuhFSyd33DcYi8WKHjVw2P4dSaMoRtYcFZO8HGZNMKcwuxQ==
X-Received: by 2002:a05:651c:1043:b0:26c:565b:2942 with SMTP id x3-20020a05651c104300b0026c565b2942mr3569911ljm.440.1663751523110;
        Wed, 21 Sep 2022 02:12:03 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m14-20020ac24ace000000b0049462af8614sm347898lfp.145.2022.09.21.02.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:12:02 -0700 (PDT)
Message-ID: <7f8f15bf-806f-a638-f35b-a66d2cb93db7@linaro.org>
Date:   Wed, 21 Sep 2022 11:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 2/3] dt-bindings: clock: add SM6375 QCOM global clock
 bindings
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220921001303.56151-1-konrad.dybcio@somainline.org>
 <20220921001303.56151-2-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921001303.56151-2-konrad.dybcio@somainline.org>
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

On 21/09/2022 02:13, Konrad Dybcio wrote:
> Add device tree bindings for global clock controller for SM6375 SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v3:
> - bring back clocks and compatible as required
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

