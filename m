Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D421C5EA6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiIZNGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiIZNGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:06:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479401BCAC2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:37:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a8so10316619lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Mn7BtO0CrR75wwHD6k8uIcJOsYMT6YL8yxp/m4Q8puQ=;
        b=wO8YP6TNZZoEtju7Dw0zWf3yBLCurwNYxWl6RG55tJ/VjElqS7W2G2asZzd9Qw9gJS
         2dakReW3g38wAY8RVcZmxnWEYNfvbjZcgMPfRKLsC2u34r05pATjTUED+wAsYgjhmjVi
         vMd4Sl70xy158KuXfXLih1p5RctuH/O0pmYf86+H0+Pr8U3p2pzS260jQr9K84v6p2RQ
         0UvKaxORwyfjIEh/7WacVePt7On5+h5hsrroXSVGxDpY3MI1A82Vu9lrc2YHt6mEUaZN
         Vfp9g1l0uJVJAInurNFDQ9S8KKc6Icgn/g0biNig1aN4yi+Uslblt2TKvExQAkD5/rcC
         F/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Mn7BtO0CrR75wwHD6k8uIcJOsYMT6YL8yxp/m4Q8puQ=;
        b=HX9QCo1hABRQvRiHW8ufCrAmKk9qf0Eujz67pL704RdKgJMDZtPWE/+Vg+WWmw5ooI
         +cj4Z/yI5a6C3sd/LqwDxzn0L2JS9ylgOzDvUj73rGwDwRRafGD5PkW4b5XzMIPjzKZl
         h328guSJdtYxqy5vGWLFFcgIZiuMl7wuCKs3LaT79VzR+mw+retdFBCvEpcUxZJ/jW71
         D4Rajj+QtnFsrouenMdcRNleFHVc+AadcBSVXCA9hWlwBiZaNWxrZjiKfPxQqmWVZE1f
         OnQVxRmtkBa7izdXHBT41abIXcPhEpPRD2sTuPODJj9iOh4sKSzj0pXjjve1AGoTjXdm
         bNqQ==
X-Gm-Message-State: ACrzQf1cKs3XVq8mpqm8Mi+Lq265mStDImyOmd/rTqVHHaaiNp3fbnPv
        1zexWOJBvy9VanxXRGM4El/lFQ==
X-Google-Smtp-Source: AMsMyM7w99Hat5BiH38tnNlm0fceWMlGL7bmPq3hmcHc8k+/5IujyjhiEhQkKzF13BaWnd467/dXLg==
X-Received: by 2002:ac2:568a:0:b0:49a:1fe:64e2 with SMTP id 10-20020ac2568a000000b0049a01fe64e2mr9240626lfr.156.1664192163103;
        Mon, 26 Sep 2022 04:36:03 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bi33-20020a05651c232100b0026beeeafab7sm2353259ljb.94.2022.09.26.04.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 04:36:02 -0700 (PDT)
Message-ID: <816c1431-72cb-b73b-79b6-0eae3344eda2@linaro.org>
Date:   Mon, 26 Sep 2022 13:36:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5] dt-bindings: qcom: document preferred compatible
 naming
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
References: <20220720073326.19591-1-krzysztof.kozlowski@linaro.org>
 <7fdcff6a-9db9-a9d0-4013-7d3ff5fd5d8c@linaro.org>
 <CAA8EJprom=CfxPQke5JjZi0CSSvvB=cw1RxOO8StLThpASG3ew@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJprom=CfxPQke5JjZi0CSSvvB=cw1RxOO8StLThpASG3ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 13:16, Dmitry Baryshkov wrote:
>>
>> This is waiting for two months. If you do not like it, please respond
>> with some comments.
> 
> I'd say, this is good, it documents what was agreed before.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


Thanks. I will rebase and resend.

Best regards,
Krzysztof

