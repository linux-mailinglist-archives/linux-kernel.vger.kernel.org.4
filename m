Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D2B666311
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbjAKSvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbjAKSvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:51:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFD43C727;
        Wed, 11 Jan 2023 10:51:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4490861DDB;
        Wed, 11 Jan 2023 18:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4984C433F2;
        Wed, 11 Jan 2023 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673463101;
        bh=axUFVrPs7N9cL5MO4o87vO6dg0FtJ7dFMoDJKd0dZag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZD63/IBN8i+bh5GNAaAmj4KrnBceZXHG4Poend7uhAG0lHzWDRvFkSBYaB/TrctZ+
         FZ39KogmsJ35T6f+DaxaxETQWI1JdDpfRiyXLXXdhSnSw0HBmww6KDUgFqIyjE2+6p
         3GZATDIsmX77q7ntgDTAn8WtANf1Brjk4nnUE3aTYnislyhOg73qtmIlhhJZMezOAD
         7ihS6uiyn1RaYtDLWUQM1BdqWMVVeSNDqZhKbIzSViF+uQCcg9F5ZkZ6ArV3VLRfIA
         XOuv7ODQQ56Dc1R5BEWWzACwAoNCvWnLnHjcY4+zXn/r4G8TvBVymsSU+FiYVfff6I
         VbSGqWHUe31fw==
Received: by mail-vs1-f44.google.com with SMTP id s127so16715179vsb.5;
        Wed, 11 Jan 2023 10:51:41 -0800 (PST)
X-Gm-Message-State: AFqh2kreD60ukc8rReTrC2nNVdg8AFV6gBDnW9RFze5C4KvG94pVo81k
        cKtOjV1yd7zIrAa/YmeoCHEpA95cPRfgXAObSg==
X-Google-Smtp-Source: AMrXdXtXruJvpjaTFbuGUvtVSAwsHG8eOKdDqA/3MaHpOLfKdzyNcXXXMI3SkJV2DJokdrUAI/UF5qIbwPYHscRGLHs=
X-Received: by 2002:a67:fbd6:0:b0:3ce:c25f:ad85 with SMTP id
 o22-20020a67fbd6000000b003cec25fad85mr3575889vsr.6.1673463100617; Wed, 11 Jan
 2023 10:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20230111163404.3526248-1-w.egorov@phytec.de> <167346265519.1103752.16521267476598663004.robh@kernel.org>
In-Reply-To: <167346265519.1103752.16521267476598663004.robh@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 11 Jan 2023 12:51:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ0e__gb6xQxJ-XhJfyBx3mYdhqipqi9i1AoBaxoaBHiA@mail.gmail.com>
Message-ID: <CAL_JsqJ0e__gb6xQxJ-XhJfyBx3mYdhqipqi9i1AoBaxoaBHiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: Convert PCA9532 to dtschema
To:     Wadim Egorov <w.egorov@phytec.de>
Cc:     a.zummo@towertech.it, krzysztof.kozlowski+dt@linaro.org,
        riku.voipio@iki.fi, pavel@ucw.cz, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, lee@kernel.org,
        linux-leds@vger.kernel.org, upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:47 PM Rob Herring <robh@kernel.org> wrote:
>
>
> On Wed, 11 Jan 2023 17:34:03 +0100, Wadim Egorov wrote:
> > Convert the PCA9532 LED dimmer to dtschema.
> > While at it, also update and the the example to match
> > recommended node names and the link to the product datasheet.
> >
> > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > ---
> > v2:
> >   - Rename yaml file to match compatibles, nxp,pca953x.yaml
> >   - Remove Jacek Anaszewski from maintainers list
> >   - Remove color labels in example
> >   - Restore labels/default-states from original example
> >   - Drop reg description
> >   - Add unevaluatedProperties to patternProperties scope
> >   - Update description of type property & set default to 0
> >   - Fix indentation in example
> > ---
> >  .../devicetree/bindings/leds/leds-pca9532.txt | 49 -----------
> >  .../devicetree/bindings/leds/nxp,pca953x.yaml | 85 +++++++++++++++++++
> >  2 files changed, 85 insertions(+), 49 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/leds/leds-pca9532.txt
> >  create mode 100644 Documentation/devicetree/bindings/leds/nxp,pca953x.yaml
> >
>
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>
> Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230111163404.3526248-1-w.egorov@phytec.de
>
>
> leddimmer@62: 'led1', 'led2', 'led3', 'led4' do not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
>         arch/arm/boot/dts/rk3288-phycore-rdk.dtb
>
> leds@62: 'led1', 'led2', 'led3' do not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
>         arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
>
> pca9530@61: 'tft-panel@0' does not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
>         arch/arm/boot/dts/am335x-pdu001.dtb
>
> pca9532@60: '#gpio-cells', 'gpio-controller' do not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
>         arch/arm/boot/dts/lpc3250-ea3250.dtb

Looks like GPIO properties need to be added as we have dts file and
the driver supports GPIO. It's fine to add in the conversion, just
mention it in the commit msg.

Also, your 2 patches in the series are unrelated and go to different
maintainers, so send them separately next time.

Rob
