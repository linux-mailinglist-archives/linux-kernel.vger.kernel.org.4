Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB19E6045AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiJSMrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiJSMqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:46:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DECB4BA40
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:29:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b2so27844325lfp.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWIPtMpQ02ewOUSaXVuZNn1e8c5RAFg0cMiaOwfgDUw=;
        b=LioaiTyPzr2IVjMTKvSTS9sX8jga3+kPP/cOH70WRS9HnmHT2PVk8DAQhmYGMv2kIG
         u/1YCiZBETYyvralMXXTVoTz6LorXJaZr68izQXMs+Q62Spgb1h5pimLs2HvwcewlwD2
         1xVlrwmXYhEVDu9MCs6W1pZ5nUQ5xdyafaK0cTx7PyM+z6tkSIj6aFPi90ZtDPcADdsU
         Z9UiLbRuNzWB8qOOv/OeOmVAZD4Uec+numuby4X7wIQxo6OCI7ATVRhVA3dwyqokTBWl
         F7NZGzLEbiE9C0M9Tn2XK3iH0hvfzLs0lKh6o5DochDODqWNsT0e+XCmq3XuM3IhAeVX
         w7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWIPtMpQ02ewOUSaXVuZNn1e8c5RAFg0cMiaOwfgDUw=;
        b=f59hYNVM7W+qjjpGZB5d9fTl8xkX+lxKUA8jZ2KDEFBrJcNa8JaZD9Bphf0331nAqd
         vWQdnVjvUv/ccBgmDE+Meb21JMsuW6QU3xFYPb3wTQC5n4PrGgR4LU9J/w8xzzdr9mSA
         EguGFsFEuiXCUGoq9YxnSiomygKUkqpdXp8i+GAXNjUAfDPtLduKh71rXtIfl/bexB1f
         kJ6T4vAFvlRn3Y5AxLWasQkhHnDK4dSAOHgUiPFHOR4fw1uRWTPd6ds02XIWdes1ed6I
         Fg/tdBxeE3Yf5JzqzpmFrV552H6MdinTmuyO0kwPGkVG3yKiVNviVjwaTL/RwuHfYaPT
         IXKA==
X-Gm-Message-State: ACrzQf0mKggts/f62Cx7mFsn1OvaA4H3om3nPfMhWOSWgS3i0IRRsYoO
        foTpaQiZMnnmRHD0NXj2Ch4sAQ==
X-Google-Smtp-Source: AMsMyM6nzgBsd1noq45Pitnhpm1WORKQM6+ODRZrBZDypmZIxnxg2HmI0rirG4D9BWG9C7ygKHTzqA==
X-Received: by 2002:a05:6512:2314:b0:4a2:6c4a:4fb9 with SMTP id o20-20020a056512231400b004a26c4a4fb9mr2952516lfu.482.1666182527532;
        Wed, 19 Oct 2022 05:28:47 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b17-20020a2eb911000000b0026dd0ee72d1sm2426419ljb.72.2022.10.19.05.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:28:47 -0700 (PDT)
Message-ID: <9cad4f2c-7cc4-72bd-0b06-5579cd0aed2f@linaro.org>
Date:   Wed, 19 Oct 2022 15:28:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 01/15] phy: qcom-qmp-pcie: sort device-id table
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-2-johan+linaro@kernel.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221019113552.22353-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 14:35, Johan Hovold wrote:
> Sort the device-id table by compatible string to make it easier to find
> and add new entries.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

