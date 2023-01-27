Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E2F67E986
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjA0Pdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjA0Pdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:33:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D0C820D0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:33:35 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso5650895wmn.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNGvS2ID0Pc1q19b8jVCARHoPS77fpPLbsMdQVhJjRU=;
        b=jupml07bP3Bg4HgWDYrj5yhkar2XTFy/mzaT7nmJaAKRDc7HajJAQSLRasOIEMYbgW
         toa5tC6p4fdIli6TzFjsiLoQYK6kIerLkRffjHfjfNsKfk5JNnr/sAsYCbMevPU7GNX1
         oT/3+f8ZqRAp3AW6ihO1j6D6HNirmOVn+W36iy+fpPuNOx0RIdlcG+eYPTPz8MH6Wvzs
         gi2B464Dj9KV3uZ69Se4zf/l6ijENcoFZt7cFy9HqhxO8Zy+yB0f1c55lD4QwWfEUzyF
         qK3f29c4U8gAG3B2ck+j5p2gKUHXNCRjV2dI9gGRukoUT6PQSvKWbM49vHgSYsap8Dwa
         ZXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNGvS2ID0Pc1q19b8jVCARHoPS77fpPLbsMdQVhJjRU=;
        b=hMHS0t/PSP1ZsDs8SV8OLMJpdLTjkK9/Y2UEU1khOA1LtdDmzD9axgo/nkfnEXrlRM
         QMDLx/5wL4fTOQRm1EW01v98blGmllQ/NCBnKJ7+q9isZl0aHQztKgcMHqzy6qEYH6YW
         9R4nSe4qHnL0G73O4HolgKisjcK32ujwCTj3grS5QPPSVTCufJjs2dn9xIb6fYZcowm3
         IkOahxckcBl9ngnoweNEnE1QboubuccPgjoQT60F3Ict3wRhdxOWADGxniXFRqjPENP2
         ZP2YPSNVYGbcII3ojfiTAwESaU8cbAi+wmAmEIFjQKHianjOOJ5FZKv2YD07zS7JpyMv
         DAdA==
X-Gm-Message-State: AFqh2ko7IQTwzU6w/pcRbEgcCp+zPAASr1m2CMB9h3ROGIGm+kYo28Jn
        dgMEbGiXF55C1KypDDNwlpALqA==
X-Google-Smtp-Source: AMrXdXtB+suh5m7saotaP8clkeCqLgJ+9SlofDAlsQ/ZtH13Uj0zCpjo1eW7fJyzu6be3Zzr1nS+3A==
X-Received: by 2002:a05:600c:995:b0:3da:f4f5:ad0e with SMTP id w21-20020a05600c099500b003daf4f5ad0emr39233519wmp.9.1674833613373;
        Fri, 27 Jan 2023 07:33:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc350000000b003d9aa76dc6asm9724450wmj.0.2023.01.27.07.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 07:33:32 -0800 (PST)
Message-ID: <7428b6d9-1653-4a4a-8e12-bc7ededef8a0@linaro.org>
Date:   Fri, 27 Jan 2023 16:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] arm64: dts: qcom: Fix regulators node names
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20230127130106.1136226-1-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230127130106.1136226-1-abel.vesa@linaro.org>
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

On 27/01/2023 14:01, Abel Vesa wrote:
> Bindings check fails as the schema expects the regulator node names to
> have the suffix -regulators, so use the name and the id of the pmic to
> compile the node name instead.
> 
> Fixes: 71342fb91eae ("arm64: dts: qcom: Add base SM8550 MTP dts")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

No, the original code is what we requested.

You are making it now incorrect (although bindings need to catch up).

See:
https://lore.kernel.org/linux-arm-msm/9e805614-8d21-4f8b-1b31-790686c95aa5@linaro.org/T/#t

Best regards,
Krzysztof

