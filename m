Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0778570539F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjEPQWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjEPQW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:22:29 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923E5A5F3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:21:59 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ba829f93da3so1109987276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684254102; x=1686846102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KRdVZnZozM7538MJGEv9ThHfJJ5JnEkvpcZbQEUrvYQ=;
        b=bSkyNbzvh1sU76jSaxUUfy7kzwJRr+UrPQrcagopWhTUOyoayPvhjCQqEIz2y76PxK
         ZxYWdMY907IA8jX6ZvxM9TKm8V1yF1pxt8mC8LNkJdZ2yzvK8bOx5TFcfberPgS/UaFY
         5yrNQs6DMhdbu754ENMnoaOGLCkJTpqkbz9/GtfrqwGv3k7VQRvCvsa/D1LLmwKy8rOW
         aqPaznbYICNoyVUTW7DepzySqqRK/3CrdO/xJwV4i5bGYtQAcOMuHrzONrqJrc+esaqh
         k7N02t3oJfFQ8vJaHxTsFPZRwsOougDJAZ7zFKk/7M7bSzIOibIxyLYTD1g0//qmDqQD
         QoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684254102; x=1686846102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRdVZnZozM7538MJGEv9ThHfJJ5JnEkvpcZbQEUrvYQ=;
        b=X1EB+9+h4yeNhoLZhvCL0kQbIXE/81x3kPqQAPuW6SGl6e0tmtT4jKKxOV3LJPhL/H
         dXv2AoFoSqujY6hFmBNJWGoSZbxgp+XuWqIXRSlk6/YTLOG+AR4TPTgL92mKc1wi6EZI
         P1RwbtbC1OI6bAbDg41dyN8TiShBUDXvqpPPvvL8xXNUc7/3/8PJ5y+y2/VMYb1r12hh
         Gu54lYtEE+hh/PPB2ZQZazHmDkF7qCoJM6dJtqGKYDyJcqpKFBmawRb/T6fbq/myev4W
         k65vmmMEMPvV1Ut+XeYc3+cLqDAoE4gSEjwo6Itk7XoNAJkT7+oo1L1M1d8FLRgom7cL
         Dhpg==
X-Gm-Message-State: AC+VfDzm1ajgfyybvQ6TzhVUrg3WhNy1JpYYfYon0PzKtBcqkN95xe+Q
        brh3YIBtpMxECYQt1dOQaxviy20GxryVnxNLHp2bpA==
X-Google-Smtp-Source: ACHHUZ6x/jNQiXF8D8l1ESNJYnmAPTBLf6713saqFrJ4URs8yZtG/NZXPv395o+eR0L5SYFiSL1EypP2+BUVUz+UAD4=
X-Received: by 2002:a0d:cb8d:0:b0:559:d9a0:5e52 with SMTP id
 n135-20020a0dcb8d000000b00559d9a05e52mr34036142ywd.31.1684254102054; Tue, 16
 May 2023 09:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230516154539.238655-1-krzysztof.kozlowski@linaro.org> <20230516154539.238655-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516154539.238655-2-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 16 May 2023 19:21:31 +0300
Message-ID: <CAA8EJpqbRHGJ0-dAHcCu2AiwPUfM1cH_q3wuMbHKeBQ-FTpyMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8550-mtp: drop redundant MDP status
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 at 18:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> MDP in sm8550.dtsi is not disabled (although its parent MDSS is), so
> board DTS does not have to enable it.
>
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes in v2:
> 1. New patch
> ---
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
