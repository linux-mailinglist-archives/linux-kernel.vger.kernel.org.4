Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFD96C8D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCYLEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjCYLEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:04:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192D3FF2F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 04:04:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id er18so6094591edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679742273;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGuQcUMPAohDQdYCn6esi5t8mBDfcwG+UMgt1Vpx+WM=;
        b=pMAvRb8aCJ2b0iCd+bQbJvnxrHmZdtK2pRSRcgh8uUGqvblJeke1gYjt2UVdKTPv2T
         tE/Jx7SUB3KniKeL3tXU9iLtWMVaVOQn2bD0tkfIwL+eY/NlNpJBI/hXmIDAh8bMyaYI
         HxIWizm/znH9TrCyib1AJNP0PMJXPbJ1I8+dxmfRO9M6mkYHa9lSvSjWmGoAta0y3o61
         RUXOIC0PIN/nYSvCp4SDQyCd2//4jjpLR3o1hFqT22PbPt8syu6kWex4RbPC1Voip8PD
         jMvgpF3URNTFFCWYZiTX/Qv30J+QbEIufaG3hIQmjufi0hl6LEfjfX2yX6SW+1o5ZMfX
         LrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679742273;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGuQcUMPAohDQdYCn6esi5t8mBDfcwG+UMgt1Vpx+WM=;
        b=o+2secAjA/di4zJItXlaRYhhndV65F5qwnBJif52aKlGvW/lfJETB/ycTZ5+r5ZbUU
         4t480aipYU1NVZwakwYR9doGkbEMz0DOZ9VFpJYNwJhnkR25BDGrB0Bedmgz0Nu4Ajsn
         EUz9Rfgo6Y2X5a0tz60x7Ek5C18evXKy5hdbR4c/MYQtlb+wbFs0AjE/jlbc4J9mn3pr
         kvsTaCAUI/y1xXGSLXczX4nOKuROe2uYBqs8pduESWHIOaeoS817S0dzOl+CvkNEOSci
         l6YtXh3La4kB/8kHUAFeeVcy8/gcEstgEh71OVBp2DSMwuazrz97FxDiCOFD7NdBW8c7
         yMyQ==
X-Gm-Message-State: AAQBX9dFHyywtjz9VXIQ3iiSD/17N9dA5WMQIP/qgYIW7BWsoruUifC1
        pO13LnBX/h+Fo9wsqb3P9RV3Cw==
X-Google-Smtp-Source: AKy350Y/NlId/yerM/9zRTivgf+nQ019MPql1v8mGNitanGiTO1YCTgARhntB8wDoJL8eH7ILlPbiQ==
X-Received: by 2002:a17:906:951:b0:933:3cc7:4420 with SMTP id j17-20020a170906095100b009333cc74420mr5852539ejd.45.1679742273597;
        Sat, 25 Mar 2023 04:04:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d230:b2c7:d55:c9c8? ([2a02:810d:15c0:828:d230:b2c7:d55:c9c8])
        by smtp.gmail.com with ESMTPSA id b1-20020a1709065e4100b008ca52f7fbcbsm11602168eju.1.2023.03.25.04.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 04:04:33 -0700 (PDT)
Message-ID: <55ab6fdb-7b93-38bb-bbf9-9d9e2051afba@linaro.org>
Date:   Sat, 25 Mar 2023 12:04:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V4 02/10] dt-bindings: timestamp: Add Tegra234 support
Content-Language: en-US
To:     Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-3-dipenp@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323012929.10815-3-dipenp@nvidia.com>
Content-Type: text/plain; charset=UTF-8
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

On 23/03/2023 02:29, Dipen Patel wrote:
> Added timestamp provider support for the Tegra234 in devicetree
> bindings.
> 
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
> v2:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

