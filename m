Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5CF74B456
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGGP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGGP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:29:53 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9C2121;
        Fri,  7 Jul 2023 08:29:47 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-783546553ddso73817639f.0;
        Fri, 07 Jul 2023 08:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688743786; x=1691335786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Np7u1Gdthtj0H8HtGvq1aCjiEkrlbP9XGrbQ0FbEkYo=;
        b=TpiyLktzlJu1VOvrk61nmTy2bFqz/goUK+PJ9IZUru4nD5MJ9GUy9MTSY4xvb7igRv
         neX2LaMbGzi2JsO/6cSxxV8UyuHNoHL0ICT4J1YvFPU6Utk+oN+F4AMZ3X/Kqp12BWQl
         Q/cq+2l2Ws5RQYUUVXTPs8hkzmclMxJlbRJ/Tca9kR3dV1FP3knRasDzxTdEl8IhEF+G
         ONjb8dE8UnfasWiuKvQfQI7p6i21PkOgYqri0kY8iWIaHxeXlwFVLrUgp8QPDBE2zo7R
         k65UtgyKOnk7CoWY0jejAOvmxUa+bSzRx7DOqx74dhYqS/eVLWAH9ap0PeKUhyr+1/b+
         aWSA==
X-Gm-Message-State: ABy/qLanTvjr1y/SR22dr0CvTIJCuYTMahSTfbdUw6u+ak1gJvVPmez8
        pAFUGB6R7EHinrsYnv134w==
X-Google-Smtp-Source: APBJJlG5IZMtz1lyDHAnM11LNIdYWsO0vZyrcvTYEhT3rk7aFygsR8f+tCdOG6f4F+MnwTUZXCoSdA==
X-Received: by 2002:a92:d94d:0:b0:346:4293:df1 with SMTP id l13-20020a92d94d000000b0034642930df1mr2882969ilq.31.1688743786588;
        Fri, 07 Jul 2023 08:29:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p12-20020a92d48c000000b0033b2a123254sm1387612ilg.61.2023.07.07.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 08:29:45 -0700 (PDT)
Received: (nullmailer pid 337099 invoked by uid 1000);
        Fri, 07 Jul 2023 15:29:43 -0000
Date:   Fri, 7 Jul 2023 09:29:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/4] dt-bindings: power: add Amlogic C3 power domains
Message-ID: <168874378313.337045.7252600709382848540.robh@kernel.org>
References: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
 <20230707003710.2667989-3-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707003710.2667989-3-xianwei.zhao@amlogic.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Jul 2023 08:37:08 +0800, Xianwei Zhao wrote:
> Add devicetree binding document and related header file for Amlogic C3 secure power domains.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2:  Mofiy filename  matching compatibles.
> 	   Delete unnecessary blank line.
> ---
>  .../power/amlogic,meson-sec-pwrc.yaml         |  3 ++-
>  include/dt-bindings/power/amlogic,c3-pwrc.h   | 25 +++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/power/amlogic,c3-pwrc.h
> 

Acked-by: Rob Herring <robh@kernel.org>

