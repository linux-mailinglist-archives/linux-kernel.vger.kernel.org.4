Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E656531FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLUNqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiLUNqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:46:06 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C22D5F7F;
        Wed, 21 Dec 2022 05:46:01 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1322d768ba7so19213146fac.5;
        Wed, 21 Dec 2022 05:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TEqm+cWQNHqjxZ1dYY94SUrdlxLeTyeNr9UU8bL+CN4=;
        b=E9gWWjQGRzO8V4qPawoiNX8mT5dNUkzoqaoYhN0csyn03M9XnZ8xfrfPeies+f+bvl
         MpJnuAAU1woRL0OG4mPmdRTyXezxhTisqOf2fg+Nh1bBXpZ01NrOwLO6RE2Czu5j3s0c
         ddynztykadIzKx3BBc76jW5Doy9xCZwKSER5vlHyqFu5XifcYV1qD7qmU1PaH9yA/gXX
         5QzYW8E+Qh1c30ueW9oeOqW18O2V/+B+0seChGAka3Or+xvic+9r6md/HNQT0rsUgY0n
         QJk2KZMh+qRYdYKHAEqr+YJoBs6RUgqfPuJ9X87tnaUiQA6Z+lqcqW9WC+SjAFgML82w
         h+yQ==
X-Gm-Message-State: AFqh2kq/cgNB69097FPxQionfXTiDTEJiM9BJE/y2tNvVQYKHsKx2Nar
        4wuiu4euO2JsxijSSVWgrTKNgWmm9Q==
X-Google-Smtp-Source: AMrXdXshd+N5tqnvx4BjYWqMK259JeDpgS2H3sA2FNIH3uuAerbwEWb38/uWerAxzHpfXw2bAA+a7A==
X-Received: by 2002:a05:6870:40c8:b0:148:15ba:8869 with SMTP id l8-20020a05687040c800b0014815ba8869mr996840oal.8.1671630360299;
        Wed, 21 Dec 2022 05:46:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n22-20020a056870559600b0014435b51ef7sm7304861oao.30.2022.12.21.05.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:45:59 -0800 (PST)
Received: (nullmailer pid 2733906 invoked by uid 1000);
        Wed, 21 Dec 2022 13:45:59 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221221070216.17850-1-lujianhua000@gmail.com>
References: <20221221070216.17850-1-lujianhua000@gmail.com>
Message-Id: <167162961165.2717636.4535164259604449279.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: leds: backlight: add binding for Kinetic
 KTZ8866 backlight
Date:   Wed, 21 Dec 2022 07:45:59 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Dec 2022 15:02:16 +0800, Jianhua Lu wrote:
> Add device tree bindings for the Kinetic KTZ8866 backlight driver.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>  .../leds/backlight/kinetic,ktz8866.yaml       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml: properties:compatible:items: {'const': 'kinetic,ktz8866'} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221221070216.17850-1-lujianhua000@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

