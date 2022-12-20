Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB299652789
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiLTUH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLTUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:07:52 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43CA1AD8E;
        Tue, 20 Dec 2022 12:07:51 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id x44-20020a05683040ac00b006707c74330eso7825885ott.10;
        Tue, 20 Dec 2022 12:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTRY4n664eYpGqz7pUvffHACtaLgt0PqZGUdtixMML0=;
        b=XqVC63QgEazDpEtwhPq2sPZ4HTo9nPt5Bc3Gd+Joc0ZDY7ds8lg0vTCiirkbHWR4zR
         LMpYFDFbU0Pl9YWOTgqGEAaldqYv8IjDdaF+TZ7jY8sTHhNzz6T/N6soYPkvRKUIXjtw
         X01QzXnSNQ+rlukmY6bwYVL4nDZ5O+aA/GKr/nXogSj/BzyYKpi8uB6ZF9xc9CQFbfMn
         lO0fvNuE5ZwMnlOpcoLne3B2g0fU9dPEjWCb5ziNG0ANSsa6Hh1a8/ueRBM+CEe2bQoN
         yCqAn4LD9aN4nAn0lcOYR+1QEy8XGwHS+PS6EdK5pMlfChs1AZ1qlaWCnJyxUyfH53B8
         1k6Q==
X-Gm-Message-State: ANoB5pnSGRWLVxGMTLjzkQFjs8gVxqUsNqnP4KC5N8Zx7N4wLISFxqRp
        Y1879Q4+xKukzdUyF4g5PADQXdS//w==
X-Google-Smtp-Source: AA0mqf5s909aL1qngbgFerZJzK9g1fx2LyjHkUrU/JxF67JNABm4qC0nnivYDxA1d0bqmuS5LzEFQA==
X-Received: by 2002:a9d:1b01:0:b0:66d:3137:161d with SMTP id l1-20020a9d1b01000000b0066d3137161dmr21596311otl.8.1671566870707;
        Tue, 20 Dec 2022 12:07:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k14-20020a4ad10e000000b004a8eb1d8f1bsm5320442oor.39.2022.12.20.12.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:07:50 -0800 (PST)
Received: (nullmailer pid 1002958 invoked by uid 1000);
        Tue, 20 Dec 2022 20:07:49 -0000
Date:   Tue, 20 Dec 2022 14:07:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] regulator: dt-bindings: Convert Fairchild FAN53555 to DT
 schema
Message-ID: <20221220200749.GA993259-robh@kernel.org>
References: <20221219191125.1974879-1-robh@kernel.org>
 <167148427205.2336021.7936012930229650977.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167148427205.2336021.7936012930229650977.robh@kernel.org>
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

On Mon, Dec 19, 2022 at 03:22:08PM -0600, Rob Herring wrote:
> 
> On Mon, 19 Dec 2022 13:11:25 -0600, Rob Herring wrote:
> > Convert the Fairchild FAN53555 and compatible variants binding to DT
> > schema format.
> > 
> > The example was missing 'reg', so add it.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/regulator/fan53555.txt           | 24 --------
> >  .../bindings/regulator/fcs,fan53555.yaml      | 59 +++++++++++++++++++
> >  2 files changed, 59 insertions(+), 24 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/regulator/fan53555.txt
> >  create mode 100644 Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221219191125.1974879-1-robh@kernel.org
> 
> 
> regulator@40: Unevaluated properties are not allowed ('regulator-compatible', 'vsel-gpios' were unexpected)
> 	arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dtb

The h/w does have a VSEL pin, so I'll respin adding that.

> 
> regulator@40: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
> 	arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353p.dtb
> 	arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg503.dtb

Humm, not in the kernel. Seems u-boot has added some of their own 
properties...

Rob
