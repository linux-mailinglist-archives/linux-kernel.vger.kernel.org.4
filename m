Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38A5BFA2F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiIUJGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiIUJGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:06:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66555282C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:06:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so8136338lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=iflmB5x5LTYMrMHTxSanZDTUtp9dd6sgn5pXgx/Vdng=;
        b=Wvz9zspPWxKA1FuKB4wFstJJbHiCtuy77PPzpRWhnRaj7NoZDRI0zmz9l3S5KJ4NGH
         UzJHehdTYphn8teBJH+5syX4sNrGfwL65UDWaR/b6oowSVh+U/nZ1thZaGeewiTAPN3W
         UBFLA6+pRdZwHjfFHe14p9J04UVxjQOIemtKBGCKpADfNdxb2IwU1dj45YReGEtEy69W
         EuLO1CPQ5nvlw2SowyH21Tk6y8hKYbARqwsLWuxi36L+BXEvOH89Lqu/+U95dZyewJJw
         Xv6Uv2LzGO1KoZl07cKhsZ89DzI2HT9dbtHOcYG0Ymu9PkOxiE2YVQ+CO8u8kd8Y3V1o
         jqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iflmB5x5LTYMrMHTxSanZDTUtp9dd6sgn5pXgx/Vdng=;
        b=EiqNB9FCmoad8vSTe0eqjg5iU9Hlf8w0DxC3Dm0fLDJ+xuVK4ImnMSdseQIYf/nJbF
         hjPYF6M5GvJiMlA6eVVoNQ7CyUy9yHp/GWuzmBMDV2cVFd1UIYmxJh33dWl1NkK+YL/C
         vDk0/Mt9yGWXX5QJB+aG6AkvWQkMRSNzx0HrLnpLbhcctXY9wxO6wFHXhQzEmwx7Yya3
         mFfWPrujX0ajNqoOBmhAj86xOMGrG3GNgfVQJNen+jMqp37bfCsVfvZO7h/VexTqNzh2
         jeGPJ2hHt9quFC77TIDorEtuQhcWYdEOeidEtVUcnf1ylXCaGf/c5CMcLNxiyGv5D88C
         kBig==
X-Gm-Message-State: ACrzQf2L/f2Dl7WjiXYpneuVZyI113NFSBJeNec0Gqf6LJRNTULclGHD
        r3XrStkMm27V0L8x7/BSpNYYyw==
X-Google-Smtp-Source: AMsMyM58IzsnA595B1qkjNLxAIC7vRF3fBUU1L97H5m1cBukR4RlSTXSO+jA9ERwdFAn/hOCDCrJag==
X-Received: by 2002:a05:6512:3d1d:b0:499:aefe:c71b with SMTP id d29-20020a0565123d1d00b00499aefec71bmr9400457lfv.589.1663751167073;
        Wed, 21 Sep 2022 02:06:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j9-20020a056512398900b0049fe6f36880sm352848lfu.51.2022.09.21.02.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:06:06 -0700 (PDT)
Message-ID: <37087d37-3c06-624b-a1ab-ea800c52d2cc@linaro.org>
Date:   Wed, 21 Sep 2022 11:06:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: qcom,smd-rpm: Add a
 compatible for SM6375
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
References: <20220921004534.151990-1-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921004534.151990-1-konrad.dybcio@somainline.org>
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

On 21/09/2022 02:45, Konrad Dybcio wrote:
> Document the compatible for SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> - changed the compatible to match the style used in the file


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

