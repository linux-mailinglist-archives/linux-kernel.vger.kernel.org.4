Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2105EEFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiI2HvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiI2Hu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:50:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52EB72FFC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:50:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a8so993472lff.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YX0kQnHqLRgLj/fiiwZ+dmeDEJEDv1t27HAEZZLrNIU=;
        b=ubf1m+Rzi5cAXDE2XxYIV+4rOeItCeCC0DjBy+XiZ400769lnYYIm6t4tSaZaYQT9n
         0lF7zzyv4yD4g3/kC1vXVjHMOm0MDQrzGEtDdpLmb9jDQM3QUYOGvQPgWBbiMOD9vbVp
         ZzHDWYuiBw/gKOkH3jXKzycahc+/n5+1nXdmg0Go3s0fTaNNUf3kgq/c3p+mQ2GX2nJ0
         T+rcgGkEiPRP+Z1G1FDdAv8J2cMKmmkV7JPvVIziDkq2sW+oFs/iokosuNYdyJBpZ5ny
         gA0YuU5A7XjhCxJSfpjr6UCrm2S8AYR5/T+yfXU2BvbRZvLg7sUs0eZIrtEQKmo43SJ9
         7M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YX0kQnHqLRgLj/fiiwZ+dmeDEJEDv1t27HAEZZLrNIU=;
        b=CbqQWJAWfw12p3Od2ltW9VpPFImh5uj6H3ZYi8okJzutu9e4j1gT4MH1QW+UoQoNfq
         lxHn/NKfJjmjcJkzZFCN5P76qHYqmNZIe5Pv7cCYiyZYqlXankfbttKeMvBq2EixWHHI
         bMDD37z3ziOTBAYWWmqbT0cbfvxr++1S1DME0GMdRithMZ2mTO2Ua4sr5Jo3Qgz4P/nd
         NKfUZICzouVwCjcvAQZLucH4dltsuWbQZHNgGFTGeHtNQcdOwgDMpFwos4bXViJXlLLu
         hRyE64Qeb5jRG5Moid0YPHad7dIFoEz0eti4jUVAPMaPJor/b/8jvjjxks8RME1XCiHK
         6Vew==
X-Gm-Message-State: ACrzQf0vLc9cGnCJGONbt5w4P6w9TrYkgvMwNz2wsOGlqdJpl1tzA2yG
        SOYuxRKGVW71RVb/sAEwZ/TVag==
X-Google-Smtp-Source: AMsMyM7BYOHtd7mxGcjnCOWk4cIBLCmGQV4bivGPxpKFkg+2q7CMfyM6h9uuG4zBCYsOpo5UIx/JBw==
X-Received: by 2002:a05:6512:2212:b0:49a:3b51:e03c with SMTP id h18-20020a056512221200b0049a3b51e03cmr771411lfu.509.1664437853227;
        Thu, 29 Sep 2022 00:50:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e30-20020a2e501e000000b00261b175f9c4sm633775ljb.37.2022.09.29.00.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:50:52 -0700 (PDT)
Message-ID: <07a62d5a-1241-982b-74ca-04ebadfc9f38@linaro.org>
Date:   Thu, 29 Sep 2022 09:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Update SNPS Phy params for
 SC7280
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1664435628-4011-1-git-send-email-quic_kriskura@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1664435628-4011-1-git-send-email-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 09:13, Krishna Kurapati wrote:
> Override the SNPS Phy tuning parameters for SC7280 devices. These
> values are common for both trogdor and herobrine variants.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

