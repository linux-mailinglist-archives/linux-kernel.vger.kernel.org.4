Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42111680082
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 18:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjA2Rmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 12:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbjA2Rmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:42:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8281EFD0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:42:30 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg26so767559wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34Hkkbw634RC9Fbld7Eci9GLP2rbD+JaNfekHKUfXNo=;
        b=Dr1Q4ox+yEMCIIgQ6ygG+UKmdT2M6H8Da1GMcciWz/NuJ7KtwC3lYk8GEESwiQAiwB
         uFkaMt5WGrLzn4GlBD6OQRhy02mKdmH0IimIjGsWnxBvYSEPHdxt9Y0DpGaAN3nUIIAQ
         g9coapWPSNH2UgdEPLy7fXtwa2lovpiwbvWyRcasOXE4UohIQZTWYfsM4ZFV3mCyRbU5
         AvF8Rh9u+uA1O+2Mn0p6yHvzl+wFdNDK+xva6lhDXh/kM6ZfuasYa0St9j8EfsVUTiQR
         UK5Ii2gJSDD+apOAlvfdAw+OUcKntBCvUvF+pwjGPpbult9uHRKXW+0I1u0KLUM8kE1v
         Z/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34Hkkbw634RC9Fbld7Eci9GLP2rbD+JaNfekHKUfXNo=;
        b=dzfLtZzHj6f+OB6sdhtkBSKxh8rKxoP+Pv8YJ//j408tlWu/z4zIeqtUhP/fhALRGp
         l5x3YwiNjkYVw1tB+HjKCviKiZtYkv/xhVycZctUxZ/IOaLDFLnxqq6rLsNI9XqCx0/P
         yetMTq1XsFemEmwwpbwprPI52vFXZ0L5tcgDs38nOoL+GLDERJ7O2SOswJuicVuzFhpU
         /Clzaxs4h/x6KXSTmLN4naGP0t30npAxHHICnFM3ZUY8sRtNmaisgeCCUeOIFVQ1wity
         +/3e+wcKED2kAdCpBt9Rn9UKPbwycY0zf0XASQ8WkS5vwL0s2JX0owALe9ER9Xq2wIAJ
         AUWQ==
X-Gm-Message-State: AO0yUKXQt/enPseBAWMPKr6xSqKQSoVcxSCAt7XV/CZql6yoJ/y/O0sg
        AEAR6k4lCLK9J56FeJSNiELgzw==
X-Google-Smtp-Source: AK7set/mvmGmVMpNZl6PzqdJ7LQUH9WapUEZ7DRqpjONCtidqEpb6FtGnwBdTrMaCUdhyh08//kGKg==
X-Received: by 2002:a7b:c8c7:0:b0:3dc:5a7c:f8ad with SMTP id f7-20020a7bc8c7000000b003dc5a7cf8admr285059wml.21.1675014149566;
        Sun, 29 Jan 2023 09:42:29 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id f1-20020a7bc8c1000000b003c6bbe910fdsm15922293wml.9.2023.01.29.09.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 09:42:29 -0800 (PST)
Date:   Sun, 29 Jan 2023 19:42:27 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1 0/2] ARM: arm64: dts/clk: imx: indentation
 permission whitespace cleanup 2
Message-ID: <Y9awA42VPpC9Ne8o@linaro.org>
References: <20230119085421.102804-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119085421.102804-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-19 09:54:19, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> 
> While further synchronising them imx device trees with U-Boot I stumbled
> over more checkpatch warnings. This series addresses those trivial
> indentation, file permission and/or whitespace cleanups.

Nitpick: The subject line should not contain "ARM: arm64:" prefix, as it makes it
confusing for maintainers through which tree the patches should be
applied.

> 
> 
> Marcel Ziswiler (2):
>   clk: imx6sll: add proper spdx license identifier
>   dt-bindings: imx8ulp: clock: no spaces before tabs
> 
>  include/dt-bindings/clock/imx6sll-clock.h | 2 +-
>  include/dt-bindings/clock/imx8ulp-clock.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.36.1
> 
