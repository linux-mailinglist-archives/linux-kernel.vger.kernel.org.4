Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE943723E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbjFFJxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbjFFJxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:53:33 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F46DE64;
        Tue,  6 Jun 2023 02:53:32 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b280319df5so1325104a34.3;
        Tue, 06 Jun 2023 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686045211; x=1688637211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lOpu32PhwAH+y2CsyaGvCkA26cD8OM8Rml/LSqtjsoE=;
        b=fP3Ilf16oLu5WijsBUtNq4TB3B9goiU87PJ+PeiN9EzUpEA30yMjEWtf4JF7RbtUhP
         bz3769Jc7xiKO3Nu7COn48wLaoBCzZV9b1AeSDEsWM6JBdjfhVlRg0NAxVr+znHVLsOy
         D1nyszBQg88zFIW/grMMkhzOuHs/1bkmxgOoZaYfWjj3E+aA1eKnp6FXADZge2jPbhXO
         lfwpXQKuy9lahyUCDguHDjqnv4BzzwkzUgTUX7/M95Ojm/uFWhPGAv4cJvmIihUzVCVx
         4E52DrDa1+BeINt01k3wdl2F32J7iFOMcIi9dcYeXYCZuFnmW4UAD16v3RKBi8zCw2sz
         C7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686045211; x=1688637211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOpu32PhwAH+y2CsyaGvCkA26cD8OM8Rml/LSqtjsoE=;
        b=L3UdiD8bSNCJ0okSHuH6+YZucWKzMeHDahSlG59AbdD/99SKQm5O/tbFZ6jCWHZ4OL
         IuWWepyErlecNXipzMdnT2XRbmN8ORhS2noAYNhL/QJgKYkfqSyk/U+1jt/MYHA30Ced
         saQly1ckW5sb1XJGsfU1uVaeOYLnVjaIrVUpgWjzb9gCmYnvJ2Gc4lGUZp0u/yFz7gbD
         x/j7Y5X7hfhWmTiFPqZDd0xevdFWV8vQnLTySws2fFpbVJEtueNBjgCcE1H+aYFTka0n
         gWh6aYBpf8vtKgvht1SDcVCwr0qoXO3OEgXuhBLYreWjq0OtVeLdeep4hb7ICCzjtgEK
         H/dA==
X-Gm-Message-State: AC+VfDyZ4lX9POx45mxo9klHXPCpAGTuTuEpHNoTXhgbmLWXnCMLVl4h
        4WvAFimi/MfPPkzK/XPBzoULkPxb8fIxd2Pp6VPnNcqPr8W7UnzV
X-Google-Smtp-Source: ACHHUZ6fJ+lm5zUsJk5S2R0UpmRMZl7c/I44n44LLk5rtB9JXQgf91+EjrQY12voSkxdgWm9stQ4SMDSrEq6J6aCBto=
X-Received: by 2002:a05:6358:bb8f:b0:129:8c5e:84c1 with SMTP id
 df15-20020a056358bb8f00b001298c5e84c1mr2067090rwb.32.1686045211341; Tue, 06
 Jun 2023 02:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230605153539.497602-1-pavacic.p@gmail.com> <20230605153539.497602-3-pavacic.p@gmail.com>
 <7255ff65-9dac-3cce-fb74-09a8984775f2@linaro.org>
In-Reply-To: <7255ff65-9dac-3cce-fb74-09a8984775f2@linaro.org>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Tue, 6 Jun 2023 11:53:20 +0200
Message-ID: <CAO9szn2WbTqCmj=eSZ_GzYP9anBoBkv7ESD_Jga-EBEqr1rxoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: panel: add fannal,c3004
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

uto, 6. lip 2023. u 09:10 Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> napisao je:
>
> On 05/06/2023 17:35, Paulo Pavacic wrote:
> > Added fannal to vendor-prefixes and dt bindings for Fannal C3004.
> > Fannal C3004 is a 480x800 MIPI DSI Panel which requires
> > DCS initialization sequences with certain delays between certain
> > commands.
>
>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    dsi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        panel@0 {
> > +            compatible = "fannal,c3004";
> > +            reg = <0>;
> > +            pinctrl-0 = <&pinctrl_mipi_dsi_rst>;
> > +            pinctrl-names = "default";
> > +            reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> > +            vdd-supply = <&reg1>;
> > +            vddio-supply = <&reg2>;
> > +            width-mm = <93>;
> > +            height-mm = <56>;
> > +            panel-timing {
> > +                clock-frequency = <27000000>;
> > +                hactive = <480>;
> > +                vactive = <800>;
> > +                hfront-porch = <30>;
> > +                hback-porch = <30>;
> > +                hsync-len = <8>;
> > +                vback-porch = <30>;
> > +                vfront-porch = <30>;
> > +                vsync-len = <8>;
> > +            };
> > +        };
> > +    };
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5c22c828ab46..62374c8424b9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6427,6 +6427,12 @@ T:     git git://anongit.freedesktop.org/drm/drm-misc
> >  F:   Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
> >  F:   drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> >
> > +DRM DRIVER FOR FANNAL C3004373132019A
> > +M:   Paulo Pavacic <pavacic.p@gmail.com>
> > +S:   Maintained
> > +C:   matrix:r/mipi-dsi-bringup:matrix.org
>
> I don't think we have chat channels for individual, small drivers. Add a
> channel for entire subsystem.
Okay I will add matrix:r/linux-drm:matrix.org
>
> Best regards,
> Krzysztof
>

Best regards,
Paulo
