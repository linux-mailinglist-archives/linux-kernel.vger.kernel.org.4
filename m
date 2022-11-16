Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A343762B9A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiKPKoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiKPKnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:43:21 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A7430562
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:31:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp15so28727802lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tmbfh1WVbfQ1CxANG3LWdUaNW2xXxnk6OP5I/SiHoqQ=;
        b=Ii5yWdXpRvIeKUwFh+G+w7l4ImMz1za7x2GtYWLNZTt0iK8ooqW/3PBeCKo3rWTNDF
         Ky6vpVbOB3mGvrygUeo7oWjyROpZvCu8cB1oyG+FmkZxVTqH5936gcQkk782PIsgt2Kh
         ZITXIYdA7xmY50dFwXpKSOpfw2dOqxlGK0LOfHgxxDP7nOsEKoCEWw8sOT8pbuSXBYIw
         YmsOWPGn6hraMkaBcn0VgDeaqwmMdlEGKpEzVvuaGxUZtXn+/4LCTpd5fHLUn1AYdlIW
         JeiPWxa6A3JFFrac5WbHXrpE/5acQeuN8y9XV5vR8vgF12u9XbhurzbF/ZD2nDzG+YL3
         NlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tmbfh1WVbfQ1CxANG3LWdUaNW2xXxnk6OP5I/SiHoqQ=;
        b=BWttI7fwvA57+CgFpqa4IU0CDQWQbb1Ar5PkzLuuSLT5VEMr2EXkWtOomfkFeB8avu
         rVCo4tw/iMFj1hQnXwc3Cl3GooQNSczFEE9QXcYQZOqLwKrLFIZRYl4Rh4REmVfbLcRN
         elSB7yoKQLB8yAZ4bC8aYfgbalOSmJ45L6sMj8gT1TYIdfed/9XAqcau6fnxxqymRYmV
         hjeP+9lAhbXunx5NY+7GSVTsGbMMhpzQtgvtYYDM0UcQEvgPOY6MJJQNNu4w4XgrSvz+
         8X3SAxYjjkWAhbdWZNIL4UHqXvlEFhcd7cL+dGOzM8SnRFVv1LsqMxf04FXj2JswQXGT
         LAkQ==
X-Gm-Message-State: ANoB5pmy59ftLWDofnihAhVuMsuzjt8xGNlss/PsaSZN6dedSTxt85YD
        Tl8hHrJGGTZIxdzVaRVy5aB37A==
X-Google-Smtp-Source: AA0mqf6hlz01gAPME7ihSspi7xB+EbsERsLFpWZyqMysHgKXZ7emPnC3hw/0rQ1Vd8mBo1qsh29uhA==
X-Received: by 2002:ac2:5ded:0:b0:4a2:b387:8b19 with SMTP id z13-20020ac25ded000000b004a2b3878b19mr6699305lfq.284.1668594694293;
        Wed, 16 Nov 2022 02:31:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f15-20020a05651c160f00b002770f0a742bsm2915094ljq.41.2022.11.16.02.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 02:31:33 -0800 (PST)
Message-ID: <a171d20f-5491-f660-939a-82795063b06c@linaro.org>
Date:   Wed, 16 Nov 2022 11:31:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: document SM8550
 compatibles
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-bwmon-v1-0-b6dd08927f35@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-bwmon-v1-0-b6dd08927f35@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 11:14, Neil Armstrong wrote:
> This documents the compatibles used to describe the Bandwidth Monitors
> present on the SM8550 platform.

Do not use "This commit/patch", so just "Document the ...."

https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> A BWMON v4 IP monitors the CPU bandwidth, and a v5 does the LLCC
> bandwidth monitoring.
> 
> This is described this by adding "llcc" and "cpu" into the compatible

One "this" too many.

> strings to differentiate the BWMON IPs.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

