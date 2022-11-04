Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30ED61A2EA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKDVII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiKDVIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:08:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C96D49B61
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:08:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b2so16406449eja.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBv38/Tzdui5Sh3CTV/WAZ2xreXg9R9Vghs8IIAZpdA=;
        b=kEaZQLERlhC+UuRGhV3KEZp7UoGkc8kN/9o+Wx39vIKtV/dhD4FdOQ3DADoeDOMemB
         LL+uNyiRSowNk2lqmA4TXvzgMwwMThh2JWym865Mc9bIIpi1a/QAAY0HnwJqBaO9u/t8
         u2xQwYpaMKyFK1sPYkEd4sUHqvxkRc+kpzpTzv9kkvcCTxGz1D+kYL4xEGSzdvqgoCbw
         7cOJ8DnYCLP38v3YDTUAkvWtS4KqZvt7J4EXrjBISP3xPMk+F4KGt1FuC0JPigId4gjU
         M6o3udqmvBPUwN3kYqjHQs1thn+NfxSBGlA6sUFTCggJqUSJ1IPWcqm8SlDFCxWo15nH
         TRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBv38/Tzdui5Sh3CTV/WAZ2xreXg9R9Vghs8IIAZpdA=;
        b=y9lgIRnU/UgrCLj9cVNdKkogO7A3XgtHNVt6RvzdqVs3/R1p8Ki6BWWHz8IC73QLV+
         cIJ02A4PKgT7GUbhrHNLDTsQGttxvz8R6UOjgl/Xb8fjAvPgke6ulzQDsav2RlBBvSCm
         XcABHqGr0VBwxikR8KsRyARpTQ590bPRwSLCPsKoEoomZpTGY+UuCup0gU4gd2amiOky
         Zc7kbu4pOtyxG//mJTS6VhXcVYpKIrjNYSD4uM7GFyZq5pCZR2hW4jg0EYi5/MbSj94D
         WPrw1JeLkLEah14Kz0M8xIS7HYTLePRq/lTAhiZ7ikRAf9oWxd4SV5MhPtVrDNr6AX3i
         1sDQ==
X-Gm-Message-State: ACrzQf1p3+zmx42dLf4w7p6KouufneMqea1hrHOXbLL6E81RSIMghOB2
        fSJRTt9LWmu6AggXsPMBFR4CwA==
X-Google-Smtp-Source: AMsMyM7ff7QJ4DEq8pSLF5w1HsakCgYSwGTbWFiFWs8eEyYmNQwDx8Ll1kU9Thmjn7PBJAchVIZSjg==
X-Received: by 2002:a17:906:8475:b0:7ad:c04:d3cf with SMTP id hx21-20020a170906847500b007ad0c04d3cfmr35054917ejc.463.1667596082491;
        Fri, 04 Nov 2022 14:08:02 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id o11-20020aa7c50b000000b00463b9d47e1fsm239808edq.71.2022.11.04.14.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:08:02 -0700 (PDT)
Date:   Fri, 4 Nov 2022 23:08:00 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 3/6] dt-bindings: clock: imx93: drop TPM1/3 LPIT1/2 entry
Message-ID: <Y2V/MM74gDLTWCbf@linaro.org>
References: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
 <20221028095211.2598312-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028095211.2598312-4-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-28 17:52:08, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per updated Reference Mannual, the TPM[1,3] LPIT[1,2] root clock entries
> are reserved, it is because writing the CCM registers does nothing
> because the TPM[1,3] and LPIT[1,2] IPs source from bus clk, not from the
> TPM[1,3] LPIT[1,2] entries. And because there is no SW entity is using the
> entries since adding them, let's drop them.
> 
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  include/dt-bindings/clock/imx93-clock.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
> index 19bc32788d81..8e02859d8ce2 100644
> --- a/include/dt-bindings/clock/imx93-clock.h
> +++ b/include/dt-bindings/clock/imx93-clock.h
> @@ -28,13 +28,9 @@
>  #define IMX93_CLK_M33_SYSTICK		19
>  #define IMX93_CLK_FLEXIO1		20
>  #define IMX93_CLK_FLEXIO2		21
> -#define IMX93_CLK_LPIT1			22
> -#define IMX93_CLK_LPIT2			23
>  #define IMX93_CLK_LPTMR1		24
>  #define IMX93_CLK_LPTMR2		25
> -#define IMX93_CLK_TPM1			26
>  #define IMX93_CLK_TPM2			27
> -#define IMX93_CLK_TPM3			28
>  #define IMX93_CLK_TPM4			29
>  #define IMX93_CLK_TPM5			30
>  #define IMX93_CLK_TPM6			31
> -- 
> 2.37.1
> 
