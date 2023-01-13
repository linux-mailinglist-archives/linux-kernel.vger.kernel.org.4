Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9D266A2D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjAMTWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjAMTWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:22:20 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3192C765D;
        Fri, 13 Jan 2023 11:22:19 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1442977d77dso23317131fac.6;
        Fri, 13 Jan 2023 11:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnIElTfHLmYJlSQZsd2r0PfuB8VIVcTxz0HDLLL+PKw=;
        b=JTq1FgenG9oM4Ibo8kcKaylcUeZt+D9coXTmWNr3WeJ2250SDjZWwpuaoIBWwZqC8D
         r3N1YoKcVqlad81yXEmUdfVwnUqJ2Gm3i7z9FVUReagNPndeWq4uO4gY4ynlKD1PydyI
         sDHrdhH824HQAU6zek8td89ND9SbV7AtBUioN+kT0fsun8BJsqvcrvhopAfeRPItB2vh
         wmTcgs833jUC3rT1YnSCE0AQuEi70i7hQei2EWZYekia/Ogd7KWyxEyklTgjlzXLre//
         o09WDG0d8lKxnWpMk87JfnXOvf0WaQ1WoiDmnG/rEa319IZ7aWqpghqfyuyMgyVcf6+Z
         QQ+A==
X-Gm-Message-State: AFqh2kqML//vCWicT1yvGahv7Oxt4uip/aaQTkSACgft+Hhjo9VePdip
        KkiCZ41ycPYauyPVFcOOgA==
X-Google-Smtp-Source: AMrXdXvjAFDlRfQqNskLkJOqoqbqbik11as4xsx8YdSb3mgcqGRmDQ7rQmX70rhkAVdxcFjXISAtqg==
X-Received: by 2002:a05:6870:79a:b0:15e:d91b:1a89 with SMTP id en26-20020a056870079a00b0015ed91b1a89mr2572663oab.5.1673637738445;
        Fri, 13 Jan 2023 11:22:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870d20400b0013ae5246449sm10855024oac.22.2023.01.13.11.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:22:17 -0800 (PST)
Received: (nullmailer pid 2800507 invoked by uid 1000);
        Fri, 13 Jan 2023 19:22:17 -0000
Date:   Fri, 13 Jan 2023 13:22:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wadim Egorov <W.Egorov@phytec.de>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: Convert PCA9532 to dtschema
Message-ID: <20230113192217.GA2772523-robh@kernel.org>
References: <20230111163404.3526248-1-w.egorov@phytec.de>
 <167346265519.1103752.16521267476598663004.robh@kernel.org>
 <CAL_JsqJ0e__gb6xQxJ-XhJfyBx3mYdhqipqi9i1AoBaxoaBHiA@mail.gmail.com>
 <9e544e49-3f28-c628-196f-2e0fed6584ec@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e544e49-3f28-c628-196f-2e0fed6584ec@phytec.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 04:18:26PM +0000, Wadim Egorov wrote:
> Am 11.01.23 um 19:51 schrieb Rob Herring:
> > On Wed, Jan 11, 2023 at 12:47 PM Rob Herring <robh@kernel.org> wrote:
> >>
> >> On Wed, 11 Jan 2023 17:34:03 +0100, Wadim Egorov wrote:
> >>> Convert the PCA9532 LED dimmer to dtschema.
> >>> While at it, also update and the the example to match
> >>> recommended node names and the link to the product datasheet.
> >>>
> >>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> >>> ---
> >>> v2:
> >>>    - Rename yaml file to match compatibles, nxp,pca953x.yaml
> >>>    - Remove Jacek Anaszewski from maintainers list
> >>>    - Remove color labels in example
> >>>    - Restore labels/default-states from original example
> >>>    - Drop reg description
> >>>    - Add unevaluatedProperties to patternProperties scope
> >>>    - Update description of type property & set default to 0
> >>>    - Fix indentation in example
> >>> ---
> >>>   .../devicetree/bindings/leds/leds-pca9532.txt | 49 -----------
> >>>   .../devicetree/bindings/leds/nxp,pca953x.yaml | 85 +++++++++++++++++++
> >>>   2 files changed, 85 insertions(+), 49 deletions(-)
> >>>   delete mode 100644 Documentation/devicetree/bindings/leds/leds-pca9532.txt
> >>>   create mode 100644 Documentation/devicetree/bindings/leds/nxp,pca953x.yaml
> >>>
> >> Running 'make dtbs_check' with the schema in this patch gives the
> >> following warnings. Consider if they are expected or the schema is
> >> incorrect. These may not be new warnings.
> >>
> >> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> >> This will change in the future.
> >>
> >> Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230111163404.3526248-1-w.egorov@phytec.de
> >>
> >>
> >> leddimmer@62: 'led1', 'led2', 'led3', 'led4' do not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
> >>          arch/arm/boot/dts/rk3288-phycore-rdk.dtb
> >>
> >> leds@62: 'led1', 'led2', 'led3' do not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
> >>          arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> >>
> >> pca9530@61: 'tft-panel@0' does not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
> >>          arch/arm/boot/dts/am335x-pdu001.dtb
> 
> How do I comply with the LED label warnings?
> I am not sure about the proper convention. I was assuming led-<name> is correct.
> The first two warnings can be fixed by dropping the '-' in the regex.
> But I don't see how the last warning should comply with a proper LED node name. 
> Or can this be ignored?

Those dts files should be fixed, not the schema. You don't have to do 
that.

Rob
