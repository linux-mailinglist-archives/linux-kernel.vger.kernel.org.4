Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E68653230
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiLUOIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUOIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:08:15 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F7D12744;
        Wed, 21 Dec 2022 06:08:14 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f9so10462128pgf.7;
        Wed, 21 Dec 2022 06:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjjOsySxC8KtamJqbFsBGyGlUqooXGkZCEvhMDcPZMc=;
        b=PjlRdBqA4xcsiWU9cyQfMYZUemYMA9B0sNlIsb2eDL6j61bmg4T8jXbDt3o27xT9FE
         IRs0LOGnmBLpX5gMoQfgDo++GH3NYSX5/LNLDpPDiseQ/hVwswV1QDyyMn7iWKjzMaFM
         v0fbmRhZDSv/fBSaPyFmheGGMnrzLqc+IW9gd0ASdn2kIW2a3KZNh0XaNaSQBSmF8kAV
         y5dRAHyrcGovOtC+471UBb4bu6S8cZ7VzA+RTcW2nyaWOFUjiitKZ2XUCawCauP0CNkt
         SdvQDCg3p8HPRO04s3uUWqd9DGhTq3+2TJhB92j8/gpKUItH8XdlS9pt6Z7vn2Mgclbn
         dWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjjOsySxC8KtamJqbFsBGyGlUqooXGkZCEvhMDcPZMc=;
        b=rc7d3vkqGmi66m4mOfQc/PZPLX2bbi6K6GQ+GerXJpDcWWfIQJZBD2hA+vn5iqj61I
         6cDYWZ6f6kcv/sYaSWz7KklhV1+8p+e9sm0Q8ejCCAVKgnMRScdBe/KLCtG1tYwnF4II
         /bgty3zuV5J+jGXYXM1JRxXke/789/uCZ6aEudmsWAcsCTU8RLw1HlrA3zaA2yUa5Ee8
         gJ8ULTJ++xJeE9NBAWlVJuct3s9zf6DjupWN1RyqKuO624gNQ7x0lnKhK1esafoYSPdz
         0m9f3npxFb+ThdIYCDYL7U9/F9gX7SNjuluRk96HUzG5OvCpwkWSqq9snprGQGz7pzJ6
         UY1g==
X-Gm-Message-State: AFqh2kocVV7u5cydGEjyteSYd9FjAOCkn4rZivSXsdnDUeVifT7q9BLT
        KkP7o1T6+zMrNG05cT4fVTj+/bfjCPAkaZlvg2M=
X-Google-Smtp-Source: AMrXdXtyGf2rgvJjdtB6ak8nDkAHOfT0HtK/RO5tQoqnIbQHTPLGtucPkNOxJ/HFsmsWZyiTY/lJxA==
X-Received: by 2002:a62:6102:0:b0:578:3bc0:57d7 with SMTP id v2-20020a626102000000b005783bc057d7mr2068137pfb.13.1671631694307;
        Wed, 21 Dec 2022 06:08:14 -0800 (PST)
Received: from Gentoo ([45.62.172.3])
        by smtp.gmail.com with ESMTPSA id o198-20020a62cdcf000000b00575d90636dcsm10622810pfg.6.2022.12.21.06.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:08:13 -0800 (PST)
Date:   Wed, 21 Dec 2022 22:08:07 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: leds: backlight: add binding for
 Kinetic KTZ8866 backlight
Message-ID: <Y6MTR0g6O0j37ogY@Gentoo>
References: <20221221070216.17850-1-lujianhua000@gmail.com>
 <167162961165.2717636.4535164259604449279.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167162961165.2717636.4535164259604449279.robh@kernel.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 07:45:59AM -0600, Rob Herring wrote:
> 
> On Wed, 21 Dec 2022 15:02:16 +0800, Jianhua Lu wrote:
> > Add device tree bindings for the Kinetic KTZ8866 backlight driver.
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> >  .../leds/backlight/kinetic,ktz8866.yaml       | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml: properties:compatible:items: {'const': 'kinetic,ktz8866'} is not of type 'array'
> 	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221221070216.17850-1-lujianhua000@gmail.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

I have resent a new patch and gotten rip of errors of the old dt-binding yaml.
