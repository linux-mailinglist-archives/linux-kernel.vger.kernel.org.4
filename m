Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE160932D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiJWM6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiJWM6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:58:41 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE4C43616
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 05:58:28 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id m6so4757506qkm.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0z3soCr06Zq0kPYXvNfFb6hXYXBXXKTaiiag2YWRGu8=;
        b=IsJoNIMWKUhHLeCPBiRmDtFQwAxA4AhLGG+zemw3FJVDpIOd3QWebMHcv1S2SEGZBE
         elx5HMv1e9SnTfNnIQrqmq1WEI/XE+97ONJXVav82ANWXgT6Q/qkLMZ6Nh4OM2e1SLw4
         4edM2uPeN94OKhdyPW3ohF/Eud0oytVfkZR2VD13W3SR4uaYPOXQRUNbpjXIX6i20tcK
         XBcvLcOl8euZ/TMi7L82JObYUhPOYuzj1rB5QkNq3dGTyPV7hAGqqF0zs/4poDdxCbpC
         mJdVymaXvLj29YFmxmSLHUSGRgWJnAQDaHciidKCRbYw8S8tZuP82pFGDM36v4F4CRqL
         avJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0z3soCr06Zq0kPYXvNfFb6hXYXBXXKTaiiag2YWRGu8=;
        b=TWh4qk791xH2064fwqSRAWfj/AEE1Mm8R6ZSiR2XA3p2hF7k1pqIsdEoW+Bk8XGJZr
         Te/77LlzC+2V1Vf50YhaGbn81WLYGMrtKbp0HT4F538diRhjXgtZ/Pomh01/v7h7KOQj
         3QjGAHk0NtkC3dbAz/KmcWtimnSht73f4Ch1EsCO0WfE6FFj44VzIZTProoosZ3dNpNi
         DcGjo3Xdk/utWQiZmW09hvdypo9DqD77rzhkD19htydQEGXjZSX+loGKUm02eWgHhFzB
         p2SBm06aY7FNFAyShZMmuatp1jbwIzWJNRnnd56imEiLsMBnmW/3tOIORmJF0i1T2Cm9
         N31A==
X-Gm-Message-State: ACrzQf2oL84jT9VuGw+l5vdGTBWPFcaj4yr6gGsZKqLFpdP+B5LzrHDZ
        OkegbXnDmBz9n1l+YNCebERgtA==
X-Google-Smtp-Source: AMsMyM6zx60rvjPqJhJZ+Ib1C4hVgCQITXAutUU09g8oy0D32Wpre37Ff9xf83MQAM+x5h45lV/GHg==
X-Received: by 2002:a05:620a:490d:b0:6e6:b1ad:7a81 with SMTP id ed13-20020a05620a490d00b006e6b1ad7a81mr18167276qkb.695.1666529863105;
        Sun, 23 Oct 2022 05:57:43 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id r17-20020ac87951000000b0039cb9ef50b5sm11098932qtt.26.2022.10.23.05.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 05:57:42 -0700 (PDT)
Message-ID: <8522ae69-26c4-9764-7701-6e977540374e@linaro.org>
Date:   Sun, 23 Oct 2022 08:57:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/4] dt-bindings: arm: qcom: Document SM6375 & Xperia 10
 IV
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221022194218.210941-1-konrad.dybcio@somainline.org>
 <20221022194218.210941-2-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221022194218.210941-2-konrad.dybcio@somainline.org>
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

On 22/10/2022 15:42, Konrad Dybcio wrote:
> Add compatibles for Sony Xperia 10 IV (PDX225) and the SM6375 SoC
> it's based on.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

