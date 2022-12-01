Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A79863FA0F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiLAVvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLAVvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:51:10 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857AFC23D8;
        Thu,  1 Dec 2022 13:51:09 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so1826006otl.10;
        Thu, 01 Dec 2022 13:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCxA5/CuCgYwnUVI/4t4TfvyLqUoBZnwHl9AJY21ld4=;
        b=lU0NiLSR4L6xAuQMFGxgLFd8fC73rDsWVmckap8p3IVmzmWJfrSgTtYeRlX125JN1j
         Zil1YMWDndUZaNK5Lkscfj+Rgao7Ra1CfXRnS9VYM/tUZXBaQghQxX0h8U7YHep3+P81
         xvyFHMrxr259R+2ECEruuTT0xEihXiwRg5P++JWY/o74Te3lEpKduguj3VawV+X0xsT7
         n4fUPTNxvha9xnjxecgL7zHPlG7i3XWIrytSnZEZPsm5MXMolgUgFUZt5I9yRhgY+rnj
         eTCH5aqDqYgj0Ke0EQ9VL5LD+QJJRA8J6u8COrHpkAHeuSbhS0jud7cRAPTOlGEuVoNE
         l2nQ==
X-Gm-Message-State: ANoB5pl3sqhs2E9HEM5fAyP/roeVsCRhJHOG+o5cnl61Gd8Gz+YuUESZ
        SJwwvgYst6mOtgT/lhaLog==
X-Google-Smtp-Source: AA0mqf7HWyICj4sOWhHjnOb6Mv68DEhmyWr7Dd9Re17nQQMY+x2TFU8bs8YQdFngp6Q20ZDD9AS3nQ==
X-Received: by 2002:a9d:2664:0:b0:66e:800d:46db with SMTP id a91-20020a9d2664000000b0066e800d46dbmr238501otb.3.1669931468777;
        Thu, 01 Dec 2022 13:51:08 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h19-20020a9d6f93000000b006619f38a686sm2552548otq.56.2022.12.01.13.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:51:08 -0800 (PST)
Received: (nullmailer pid 1508799 invoked by uid 1000);
        Thu, 01 Dec 2022 21:51:07 -0000
Date:   Thu, 1 Dec 2022 15:51:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>,
        devicetree@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos5433
Message-ID: <166993146654.1508717.4737738851808573029.robh@kernel.org>
References: <20221127123259.20339-1-krzysztof.kozlowski@linaro.org>
 <20221127123259.20339-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127123259.20339-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Nov 2022 13:32:58 +0100, Krzysztof Kozlowski wrote:
> Exynos5433 has several different SYSREGs, so use dedicated compatibles
> for them and deprecate usage of generic Exynos5433 compatible alone (as
> it is too generic).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Sriranjani P <sriranjani.p@samsung.com>
> 
> ---
> 
> Changes since v1:
> 1. Add Rb tags.
> 
> Cc: Sriranjani P <sriranjani.p@samsung.com>
> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../bindings/soc/samsung/samsung,exynos-sysreg.yaml | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
