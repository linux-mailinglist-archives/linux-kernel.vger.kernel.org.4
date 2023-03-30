Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11216D0745
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjC3NuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjC3NuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:50:03 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA7A4EDE;
        Thu, 30 Mar 2023 06:50:02 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id bi31so14167938oib.9;
        Thu, 30 Mar 2023 06:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680184202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKdeKXMZKkzRzmYzogTN+akOjOk8EAmTZBQ/2FEAwgg=;
        b=5I/G/T9bn3WMdtobQ55G4BFKMmSfPDG/EkrI1hpf4mGHdYWa5WH2xejbi+3DS1UGtq
         +DgpI66YvsmcFxKRBiU6a8EDLkiaqYUkgT++r9014JLJU4Zy6K+9NxdJJa/qE5YY/NXq
         P8avfxbNxbpdi4QiefemCerHslRBaVUe0n685J9RLCze8Ucgbhg6YmqJ+chha9gFvAUy
         N0NQ8qlIKyZZvMsrcSthWCpt0jbccZhLlYAiaT4yP1hdZcW4NNOHw3gbbkEaEg6ah30h
         qHX7KGqiImElMr+3mQIVyDSqx9suYsNxvdptJhev3lRZFjD9No5Z9ief9utMyOiiMUS3
         1i/Q==
X-Gm-Message-State: AAQBX9dvDBrRRNM5NQtxrdfSi7DZUFNzyo7pDBXPVqBjcahDfpJwLXIw
        PKDwsDPcXuonzgYayXudEg==
X-Google-Smtp-Source: AKy350bFeV3x8EQIVtLXWGoO3fQp/HyP946oOhe7XGW6LnNcoGBq+6UaL8exWCu6W4e++Ed/2NEAcg==
X-Received: by 2002:aca:280c:0:b0:389:72d5:f16f with SMTP id 12-20020aca280c000000b0038972d5f16fmr1649086oix.28.1680184201780;
        Thu, 30 Mar 2023 06:50:01 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o184-20020acabec1000000b0038934c5b400sm4334154oif.25.2023.03.30.06.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 06:50:01 -0700 (PDT)
Received: (nullmailer pid 1903371 invoked by uid 1000);
        Thu, 30 Mar 2023 13:50:00 -0000
Date:   Thu, 30 Mar 2023 08:50:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: mediatek: deprecate custom
 drive strength property
Message-ID: <20230330135000.GA1898063-robh@kernel.org>
References: <20230327-cleanup-pinctrl-binding-v1-0-b695e32e4f2e@baylibre.com>
 <20230327-cleanup-pinctrl-binding-v1-1-b695e32e4f2e@baylibre.com>
 <334089fd-f0e8-bf63-5100-d8632c478ccc@collabora.com>
 <3fbb78e9-a450-3741-070b-2caedbaa47a5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fbb78e9-a450-3741-070b-2caedbaa47a5@linaro.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 09:58:57AM +0200, Krzysztof Kozlowski wrote:
> On 28/03/2023 15:41, AngeloGioacchino Del Regno wrote:
> > Il 28/03/23 15:06, Alexandre Mergnat ha scritto:
> >> Deprecate mediatek,drive-strength-adv which shall not exist, that was an
> >> unnecessary property that leaked upstream from downstream kernels and
> >> there's no reason to use it.
> >>
> >> The generic property drive-strength-microamp should be used instead.
> >>
> >> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> >> ---
> >>   .../devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml      | 8 ++++++--
> >>   .../devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml      | 6 +++++-
> >>   2 files changed, 11 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
> >> index c30cd0d010dd..b82a066b91ec 100644
> >> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
> >> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
> > 
> > Thanks for doing MT8183!!!
> > 
> >> @@ -110,8 +110,13 @@ patternProperties:
> >>             drive-strength:
> > 
> > ..snip..
> > 
> >> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> >> index 4b96884a1afc..347f533776ba 100644
> >> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> >> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> >> @@ -91,8 +91,13 @@ patternProperties:
> >>   
> >>             input-schmitt-disable: true
> >>   
> >> +          drive-strength-microamp:
> >> +            enum: [125, 250, 500, 1000]
> >> +
> >>             mediatek,drive-strength-adv:
> >> +            deprecated: true
> > 
> > In the case of MT8365, since there's *no* devicetree using this property, *at all*,
> > I think you can even just entirely remove this block, as that should not be
> > considered an ABI breakage in that case.
> > 
> > Krzysztof, can you please confirm?
> 
> If it is defined as ABI in a released kernel, then should be rather
> deprecated.

Yes, but if no one notices it's not an ABI. It's up to the platform 
maintainers really. I only care that the commits indicate they know what 
they are doing (usually not).

Rob
