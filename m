Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A703D685C9E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjBAB17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBAB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:27:57 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68860C151;
        Tue, 31 Jan 2023 17:27:56 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1685cf2003aso1355371fac.12;
        Tue, 31 Jan 2023 17:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UZisrer2jiVUWM8OC9EddWtu72fSzkcUXDFx1sXqgc=;
        b=HxPHBgFXjIT1hQlHHq5GcQddGwNQYECWmHfbNjCKcJfJR5uj6oGXgm4bWabMP8EDEH
         jwoXunOkoL/PigpedG05GlK5orJAIPdNfTTb/xZ7ajaDfmvciXevEtPU4ypDLl73vsZr
         ZDa1oT+cOrDBYo1IMFAsJIuCfJaM8fg3wV1mPETernbL9hBttjAuvEAm0dWmIRoZGopU
         XBNCRhYLysTDEugtuyz4ZBnFo6e564PS/b6HXcBjdaYwpicEdAdGgZgEYpjfi5k2KEcI
         929sT6iaETNWoNKzOzE7RLGwuTf42VCatvPY/xSmKPH7hnqvUMzYTsDYntk4AqWhbmht
         Xe4g==
X-Gm-Message-State: AO0yUKWFF1GeG+/YkEqrFEH82CNEC8GlhInTdy7hlOWs0sqGlsTGqO8z
        te/vcxx98XeTL1x8NSNjzQ==
X-Google-Smtp-Source: AK7set9evM5gxTPaMLZmGqGApIAGfUNqw7Yrj2SASyTAWucczBYUFMgXGV1DP9K7ildUQiFYOJPKWg==
X-Received: by 2002:a05:6870:f14b:b0:163:19e1:3b8a with SMTP id l11-20020a056870f14b00b0016319e13b8amr95220oac.31.1675214875564;
        Tue, 31 Jan 2023 17:27:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id nr9-20020a056870dc4900b00140d421445bsm7202265oab.11.2023.01.31.17.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 17:27:55 -0800 (PST)
Received: (nullmailer pid 2279370 invoked by uid 1000);
        Wed, 01 Feb 2023 01:27:54 -0000
Date:   Tue, 31 Jan 2023 19:27:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/1] dt-bindings: Fix .gitignore
Message-ID: <167521487245.2279300.8949761709442968191.robh@kernel.org>
References: <20230127150225.18148-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127150225.18148-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Jan 2023 17:02:25 +0200, Andy Shevchenko wrote:
> The tracked files should not be ignored.
> 
> Fixes: 44ec8b20d1e9 ("dt-bindings: Add running yamllint to dt_binding_check")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/.gitignore | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Applied, thanks!

