Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD93623AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiKJDvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiKJDvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:51:50 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8722FC35;
        Wed,  9 Nov 2022 19:51:49 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id d26-20020a05683018fa00b0066ab705617aso480370otf.13;
        Wed, 09 Nov 2022 19:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggDLXS8C7H/fGONZ51hHpbZ+HaczVFYvC4iINiZo8+Y=;
        b=3/lvNq3z2iklQMb1vktGUWm1a27Q/iHhGL7u2K0Uew3Ji2n496soe6L+xkZT/mF7Xg
         V+JZky1sbast/XDTyiN5ajAAxxK5ekJ+VS7UT44jWYeuDRPo1yO9plx9RF0woSLOM3rI
         rBI36p3OGacr8hYH+MmpryqFZ8AC2eE2vpL8n016qofcnXEEtb+UcUr9QlICmlzQkHbq
         fFPJpf+PR+KwvSd+g5mpuiWfOLGZOJZz00X09oMiz5plPAmwhynfFnK90s+NAKAnQZ7C
         5ttzEEHk4MfxR3yXwz1HtwPlOOq0i7yuSQOZUmZ7wTCH2nieq2w5mfDitAQFj5F6l/zF
         RcOg==
X-Gm-Message-State: ACrzQf1fj1vosGqExh7xZChgsWQEzBUIJ3to3kgXdJWvbqGsRzDA/WmY
        aA26wIf07rwmpPa9z1BHiQ==
X-Google-Smtp-Source: AMsMyM4jIqBTy5OSUbxEJJvNBC8mWaF73kdsvN0TVQ1mE7inCd/BtT6E6HpUnQqdQ1NoweSFTL+LxA==
X-Received: by 2002:a9d:6a0d:0:b0:662:2138:f51b with SMTP id g13-20020a9d6a0d000000b006622138f51bmr1061856otn.73.1668052309167;
        Wed, 09 Nov 2022 19:51:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y23-20020a9d6357000000b00660d9afc216sm5996281otk.17.2022.11.09.19.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 19:51:48 -0800 (PST)
Received: (nullmailer pid 3436645 invoked by uid 1000);
        Thu, 10 Nov 2022 03:51:50 -0000
Date:   Wed, 9 Nov 2022 21:51:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Christian Eggers <ceggers@arri.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: nvmem: Fix example
Message-ID: <166805230789.3436553.2751149076603069326.robh@kernel.org>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
 <20221104163833.1289857-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104163833.1289857-2-miquel.raynal@bootlin.com>
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


On Fri, 04 Nov 2022 17:38:28 +0100, Miquel Raynal wrote:
> Despite not being listed nor required within the top level nvmem yaml
> file, the "compatible" property is mandatory and is actually enforced by
> all the nvmem provider bindings.
> 
> Unfortunately, the lack of compatible in the nvmem.yaml to level
> description file lead to the example not matching anything and thus not
> being checked at all.
> 
> Let's pick a compatible almost randomly (one which is already used with
> the qfprom label) to make the example at least valid on a semantic
> point of view and getting it checked.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
