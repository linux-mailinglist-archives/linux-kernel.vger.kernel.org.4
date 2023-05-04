Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7BA6F6500
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjEDG3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjEDG3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:29:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1CA2D68
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:29:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so14035886a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683181782; x=1685773782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AvF1b4T4ZW298PvVVsIkZ6nQgpxdBXnANG4ULYhpoJU=;
        b=zF7F4NLHOkCLy5pOF6eiSo28tB24mHId+nifiBgEoisMhWnSRUC/bBRvnGf8Kr6CP6
         4s2oD84bpTsNCXnDlwmHBU6HcKIltwLBOeJ7wrcMlOH+9G81NPV+SDJjSva7zk5iDs9v
         eVio/TrA51aHyxdaZNTiWi6SAw5c0oi2YuPH8sIJLtIniLJx3YJBbS3KD8nJMnHlW88Z
         vr96C8VG6R+nXNp0ggN9hIk4sTpEocI5gvI8nMOy+DmHEfWDbJGrOtw3fyfLsVjyYqkF
         K6QNA8N7aXQ5JW2oXBaA9sUq9uM50biBXBQgBvOEOdsmkFj8QuVk6j9HZx6gRdXIosLC
         ydUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181782; x=1685773782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvF1b4T4ZW298PvVVsIkZ6nQgpxdBXnANG4ULYhpoJU=;
        b=Od5PRmAxZhPZW056038qWi2ZcBVGQreO2fTPEriuT0yyYsy9KixDee1fGNm8zMsX1r
         utUue1w0wGrmofDr1ekjJnAyic7iSHmgwtn2HwaU6Y36cKNcuLM4BAXJcJ8Zj72SO/rW
         //4SwwGiO0F7Ob19M8OvHYccTYBj1ykkie+ITeNmxXlBIkDL6L8l5P0jU2XVwwhmKZ4S
         C+rqC3mTpUSewZql3rNMa/dqUp33BqZy1aNPPky2c45NT5NX4qWhMvrMLtLbmGxZYPfQ
         QjyuftDWENz+M7YY42xe7WnZ0ovlTvmbDw2p1WDws4rB5ehuLCjdbVtA36WyNmPudBpz
         bOJQ==
X-Gm-Message-State: AC+VfDymsxKewOaOnSugRyu6NGNhlfN3EKCYvQm27t61iofNPvpYSDYS
        73akdESAcoaWN61sn+Qj5eRWjg==
X-Google-Smtp-Source: ACHHUZ5xYPuvbWVazEaA9I9FitJyy80WTkiS4nTt8535HKaxP3/jcTZL5r84cDrsK7zzMC0lalDf2A==
X-Received: by 2002:a05:6402:26c2:b0:506:71bd:3931 with SMTP id x2-20020a05640226c200b0050671bd3931mr655360edd.2.1683181782093;
        Wed, 03 May 2023 23:29:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id z22-20020aa7c656000000b004fc01b0aa55sm1515408edr.4.2023.05.03.23.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:29:41 -0700 (PDT)
Message-ID: <7df7cf56-06fb-8c40-c7ca-17f725912236@linaro.org>
Date:   Thu, 4 May 2023 08:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v9 02/10] arm64: defconfig: Add support for Nuvoton MA35
 family SoCs
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230504033726.93-1-ychuang570808@gmail.com>
 <20230504033726.93-3-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504033726.93-3-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 05:37, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This adds support for the Nuvoton MA35 family SoCs which
> are based on the Cortex-A35 Armv8-A 64-bit architecture.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

