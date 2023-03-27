Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54DD6CA13F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjC0KYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjC0KYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:24:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E752C59EB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:23:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c29so10725944lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679912637;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXY8IRNCSKZca0K2kiIzOX2fUKB15EaV/gOhP693Hqs=;
        b=Rp4mSsS5/CFBgAMWJhDxq7VhPlhdmak0SfpaRUcycI38SjUL/5FWhAhdpY+rm4qJby
         EnIK0ziGReOzY5mHdnle4BZYGz88umvm/B8+9KYdXl1KPYO5AgOiJGCWiLXAdPAq0XAr
         wECP36Hh/s8jzqIrQwRMAx/wfMIz/qua7t+EocX7R4YDZIriJVIwMRo0fqf11/IZcVhz
         LUC83ZQT7KH2kiaDfhfet5ddz8dNkNtZ1A6OHAfi/Nf3Wd9+IALUJrUTCveSWQ81G2CP
         Icq3AqGL+i5s9Qs3lwtA3ux78Q2XBCSrV0xACQmglb2fWJmv5hJ69wpo2Ia+ALs6f234
         lFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912637;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXY8IRNCSKZca0K2kiIzOX2fUKB15EaV/gOhP693Hqs=;
        b=h9igoXE94NKcb+bv+XUC/xOe7ohyFJTsklmqI1Rktz3IB1oopU42i3yLBoMQNC84oR
         2wvIwBD+V9S5OFavT8u6l1TTckhYqfE9+vc220zPrt8DRoNPEisRfNoiC11bumSCcXfN
         V2u0/Z5V7kit7etYvnKl2TRloqNT1rVdJbjsK9aF98oeFAZGlo4eiyucwnnlN7v6gs0o
         SDF4Q4FlktD66Dn+1ZKsdsI1EAOMI5MOKHlD/2kzWdNyvh3ESlIiEmkYWsu1hjqSrMI3
         l1hEz4hQZpFI/qerv4wNpc2cgB9+h2J38VsY2rTt1inTugNdcDVI43L204rrk0W11tcs
         BW8A==
X-Gm-Message-State: AAQBX9dCqoqNQbxxZmknffrhukT9l7J3/SDBMXcWG++tQea9paMsT1Cj
        dbz21qMJEk0gqowDFq3cta/HzOr/LXvymXEBBxVr798r
X-Google-Smtp-Source: AKy350b53GGowlrJj3Qj5suXs1ON/M2gAxWORjYROJ4mBEOwZdzBmU7Uky4JdXT32164TgGdZf/21Q==
X-Received: by 2002:a19:551a:0:b0:4dd:9931:c4f6 with SMTP id n26-20020a19551a000000b004dd9931c4f6mr3506834lfe.16.1679912637208;
        Mon, 27 Mar 2023 03:23:57 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id r28-20020ac252bc000000b004e9cad1cd7csm3530126lfm.229.2023.03.27.03.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:23:56 -0700 (PDT)
Message-ID: <d3456d31-ce4a-f49e-4d46-f07d84968ccd@linaro.org>
Date:   Mon, 27 Mar 2023 13:23:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/11] arm64: dts: qcom: sdm845-xiaomi-beryllium: correct
 compatible
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326155753.92007-1-krzysztof.kozlowski@linaro.org>
 <20230326155753.92007-11-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230326155753.92007-11-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2023 18:57, Krzysztof Kozlowski wrote:
> Tianma FHD panel is supposed to be used with fallback compatible:
> 
>    sdm845-xiaomi-beryllium-tianma.dtb: panel@0: compatible: ['tianma,fhd-video'] is too short
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

