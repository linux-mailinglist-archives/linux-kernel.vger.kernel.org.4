Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9886463EE4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiLAKpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiLAKne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:43:34 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D744A0BFB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:43:31 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b9so1405406ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1kyrvMls8wTQMlQrJqyGrjffl641Id/9a8Nkb4/gCx4=;
        b=VB6ARDsUl9VDYdCN2+lOHBpQREZqTxeDFRGhmdVSMuUrYfsXQIto7O3WmA0gaY2O2f
         VuJKiviMybBR6jRObOdA+JBaGb7zyI62bejJiEeHMNjPmP5vhpgZxLQFrSSiaYXs6Y+g
         rT3rs+lg8U7/oP6GK5q8QYMYM74Z1SLVVGcwElaerQ+0qpLx3crZryC+QPmNSRrmYcZl
         K9TeuOcGRkkMD+Sw1AJrQT69wUGhum6nY3BIBm9aYaK7paFXTOBlQV2roe/AFpWcv41x
         3el058IRSwutRldsN83xt7MRmJRwCcLbCW5B6tRw9wMtQMA91NbvTBafz5VwV6S+Ki+K
         CLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kyrvMls8wTQMlQrJqyGrjffl641Id/9a8Nkb4/gCx4=;
        b=Sc/DdTzEFGCR/mIRkObhA9GA24gFOGNveHqSDyFGCnr6csEnEc8UhMI4URx3ZL5P0Y
         zPqmOdrsmwSf3nsrHblfbAtoiE30lKRBJ3uSw7k4x3jVeVoIcbpzNvzA6Xs8lpKzdu63
         WPa3q+je/NoYIOq7WTFAe3YSHUSbEH9dSfcDpv1JiIWa6GKvT5XDdWpyDEAQgZf0k6tt
         V1Ub0B7z51VsQs8jNQVXNbsOu7/U+bvjTjpB0p5gd9Z1TrYO5w4Ni9zP3Vmv4uhOv9Jx
         ot5ag9hrxo8AI6a4IbGfAykLAeYHN1Qw7HN8SX8IjIUgdp1WxmcFMtJBVeuM+BWLFIsg
         AZnw==
X-Gm-Message-State: ANoB5pnggNj5rW6AyZmFAE8/3KH9YwHislH5YyfMIpuxRgGbG894Lh2W
        R1MggWDKWATvLY1gQNugHglHVQ==
X-Google-Smtp-Source: AA0mqf7dZn8tcHCSTqwKdg59rVP2szYiKJd/88+xPBwamyUC0rkQTrwxWM43ihM6G6ZIvZydte88ig==
X-Received: by 2002:a05:651c:239e:b0:279:c7b9:c365 with SMTP id bk30-20020a05651c239e00b00279c7b9c365mr2133580ljb.134.1669891409697;
        Thu, 01 Dec 2022 02:43:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi41-20020a0565120ea900b00492ce573726sm607522lfb.47.2022.12.01.02.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 02:43:28 -0800 (PST)
Message-ID: <cae9f009-d75b-9088-8f22-ea54552e9f34@linaro.org>
Date:   Thu, 1 Dec 2022 11:43:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: Add Qualcomm SM8550
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20221130132059.3145243-1-abel.vesa@linaro.org>
 <20221130132059.3145243-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130132059.3145243-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 14:20, Abel Vesa wrote:
> The Qualcomm SM8550 SoC has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v3:
>  * Dropped qcom,sm8550-rpmh.h and qcom,rpmh.h from examples
>  * Added the header for interconnect IDs to the top-level description
>  * Fixed examples indentation


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

