Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3AF644437
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiLFNLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiLFNLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:11:13 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940966243;
        Tue,  6 Dec 2022 05:09:45 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id r11so11115589oie.13;
        Tue, 06 Dec 2022 05:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Twf2LUQQZEEsPFMs0YGDTeUVVUS9EWkbM3eJUG/VOf0=;
        b=wb94GU1QlHOKSB3GEWBJaC+I2S/bP+Wlt5KY3Qq9/I+uWBhhG2IyM1sBF3DCSo9oot
         ZhueNpYEKM+H3XjDT5/LNyzsgAvdULgRgf5x9xAgRyH3jyAGb1gFvRCmqyklj/uzS9ad
         YRUrRJNKjeakHHtemU7JuzumrPQVX43s1hEpb48PgZHDOscnvVq5HeVH4PENA7YnwEbt
         JUSx1GtJ69gQUo3CuWN97VCJMqPQNWtYnppPU5C+AcjK7gpXsPKOsdnmbXpAtHNrfueM
         Q5Upu+6wy5YpPTy2lJhct9K600n4vWpOMbWB7JfwXGqIObWUr+VyvlKFJ/FiqSUn6HQH
         ULyw==
X-Gm-Message-State: ANoB5pk4MhQafVBg0bFnbvLkJxa4r/6b++GgrgRQtDXGZBxUukADzkjC
        JWp3fYIUhuBy/GhKfYvQsCwSX1+J5Q==
X-Google-Smtp-Source: AA0mqf7a4XewMy+qenYc/uQHEe7SRvtkFJ8yQxfPCpF8rThyNv20WBRTh4LVw3I3MiVY6s7uZD0XLA==
X-Received: by 2002:a05:6808:22a4:b0:35a:388c:743d with SMTP id bo36-20020a05680822a400b0035a388c743dmr43974263oib.258.1670332184644;
        Tue, 06 Dec 2022 05:09:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z20-20020a4a9c94000000b004a3527e8279sm1321513ooj.0.2022.12.06.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:09:44 -0800 (PST)
Received: (nullmailer pid 236277 invoked by uid 1000);
        Tue, 06 Dec 2022 13:09:43 -0000
Date:   Tue, 6 Dec 2022 07:09:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: mfd/syscon: Add resets property
Message-ID: <167033218290.236219.3964235132732494862.robh@kernel.org>
References: <20221206073916.1606125-1-jk@codeconstruct.com.au>
 <20221206073916.1606125-2-jk@codeconstruct.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206073916.1606125-2-jk@codeconstruct.com.au>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 06 Dec 2022 15:39:15 +0800, Jeremy Kerr wrote:
> Simple syscon devices may require deassertion of a reset signal in order
> to access their register set. This change adds the `resets` property from
> reset.yaml#/properties/resets (referenced through core.yaml), specifying
> a maxItems of 1 for a single (optional) reset descriptor.
> 
> This will allow a future change to the syscon driver to implement reset
> control.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
