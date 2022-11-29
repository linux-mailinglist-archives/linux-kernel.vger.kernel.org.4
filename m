Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAA563C319
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiK2OsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiK2OrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:47:19 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A15C0ED;
        Tue, 29 Nov 2022 06:47:19 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so9205614otl.10;
        Tue, 29 Nov 2022 06:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b+KzTjmPmnd8sTRNm0EY8X1XaPpeEAQRPlSuPUp3Dc=;
        b=RgY76oXl77RcXE0lF15iaKFdvztaHJxmMDgK7C1fz4ZmEswctCMqMt8895nt6/gZuI
         Fw4fMrKeoXZ+HXyt/tPw3iV7JsperB4lv1HsJ1neQ1c7DgrE1/9p0yZ7CgMz8oelQZYt
         doA3e8Pjj46QuPUI7mLzymzuZMpUHCjD7PJrOhovWG/e5uHajksGAClSIdnTTQL0Nxfb
         EeAl7OJ0SZyOdjmP6l8X34Smm8zcT3qNBlaZ8uud2DKaoEIxl5qgIr4ocDPwiDGVnXG7
         DskRVTSaA+mJVwcc1nU5iqjHvjFyUg8JPjaBp4BdrFiREZauhthbm0DvWQn31+ozKfZ3
         N2PA==
X-Gm-Message-State: ANoB5pnlnnyqRws2fQOJ0cwyRco/bbeDTQ/2WoBj4wQYiUeaWin3egeb
        3UmpcwcMRmftWgtkZKsBNQ==
X-Google-Smtp-Source: AA0mqf6RUgQcfhQifqPrbQhhWTd3qlbufh6rTmHyKMRV2ErM3Ll6gbUefGzqepRMMhx/FbvCYZLPfQ==
X-Received: by 2002:a05:6830:d87:b0:66d:8b98:683f with SMTP id bv7-20020a0568300d8700b0066d8b98683fmr29675043otb.40.1669733238376;
        Tue, 29 Nov 2022 06:47:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p83-20020acad856000000b00359af7ea8fdsm5563936oig.34.2022.11.29.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:47:17 -0800 (PST)
Received: (nullmailer pid 3635386 invoked by uid 1000);
        Tue, 29 Nov 2022 14:47:17 -0000
Date:   Tue, 29 Nov 2022 08:47:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] dt-bindings: qcom,pdc: Add missing compatibles
Message-ID: <166973322157.3635007.3803910516622082997.robh@kernel.org>
References: <20221013091208.356739-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013091208.356739-1-luca.weiss@fairphone.com>
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

On Thu, 13 Oct 2022 11:12:08 +0200, Luca Weiss wrote:
> Document the compatibles that are already in use in the upstream Linux
> kernel to resolve dtbs_check warnings.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml    | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks!
