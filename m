Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6796166E0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjAQO3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjAQO2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:28:30 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423AD30195;
        Tue, 17 Jan 2023 06:27:30 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i65so20121593pfc.0;
        Tue, 17 Jan 2023 06:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/wAjm4lS10HgUJLm0Th42PdGl6ITPn76MtUbapp87lY=;
        b=fPZRLdQAAUyzM7c37jr3ONsaBuqZNfW8jdyWJf3e47FYY+eMvUe62hcJvNFEIT9wI9
         +aYQZ+1AhCvo1tWmKauq6/kefRZHXC5Ndp6PpuNQnsTKXUBrZq7259i6P6NKHIbGCEm2
         oUyrGAdU5oHEDgxZkmCdoNmveAXa+2mh1k1c91lQEAXYateyLG3RRAFO9P+8+W5/TpGN
         kbhuthUe2c2FLYl9r4CJR0fMlLz62xDsEFG5KzGJxgkKSr33PJ6pso6Jvwkm1aqNITpZ
         hUcRFo/KQCGWyMPF4rd11fkzpmFeAqOQztVdlcP95DEF4y+mXwTmzX15juOc8d8+d/qp
         P61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wAjm4lS10HgUJLm0Th42PdGl6ITPn76MtUbapp87lY=;
        b=z/A0bR5EBF5OmdWPpJXNFQWFaVYEfB2t0F2fCkni4u7uIDRNidoEhhnGdgIvyKIxu0
         NzlyjBNmr6gQzpHrqiO9zbDdD22sLTyaG+SxltFPWnO53zdWzOj/ddADzuLyOG4iL2zE
         GWr98I4/UWI35xteTYfgJ1ULPFR2Z/PAbRs6+G2Xj0o6fo6oNAxUPyyzthLQnwI5yK/V
         LEeWWL6YC8uyy9ex0DXbpdTsQ7bo/SaxsV/LSMil26hNbtjXDoB1xf5gW9xWUPClnZkC
         JjkIF2eVxa1p/+eJKtJOtR2a7F9j+IqLbXDHAlPqLnyce7XU7q47Wd/x5qDnKTprh4RD
         uerg==
X-Gm-Message-State: AFqh2kr9eHSO/QHmy3xoTPJKMcxxSYRzIJ0KDZ7ljKOmft/bL5vukQfu
        KSfGOA+2Cvt/7eGqcWDJ+68=
X-Google-Smtp-Source: AMrXdXtZhFaK22c6A/K6XbPnHmwDiY00Yu63fNedu4I8HEdO9kKbgmkA8su7raejpBEPBibThdEoBA==
X-Received: by 2002:a05:6a00:1da3:b0:563:cc80:fb66 with SMTP id z35-20020a056a001da300b00563cc80fb66mr3647881pfw.0.1673965649774;
        Tue, 17 Jan 2023 06:27:29 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id h124-20020a628382000000b0058bb2f12080sm8006446pfe.48.2023.01.17.06.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:27:29 -0800 (PST)
Date:   Tue, 17 Jan 2023 22:27:22 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Message-ID: <Y8awSrqiWLoPQvIa@Gentoo>
References: <20230117134742.23238-1-lujianhua000@gmail.com>
 <20230117134742.23238-2-lujianhua000@gmail.com>
 <Y8avDJj5PCy8OVWV@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8avDJj5PCy8OVWV@aspen.lan>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:22:04PM +0000, Daniel Thompson wrote:
> On Tue, Jan 17, 2023 at 09:47:42PM +0800, Jianhua Lu wrote:
> > Add Kinetic KTZ8866 backlight binding documentation.
> >
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> 
> Might be a good idea to take a look at this bit of the docs because
> the patchset is not in the right order (I.5):
> https://docs.kernel.org/devicetree/bindings/submitting-patches.html
Thanks, I will read it.
> 
> 
> > ---
> > Changes in v2:
> >   - Remove "items" between "compatible" and "const: kinetic,ktz8866"
> >   - Change "additionalProperties" to "unevaluatedProperties"
> >
> > Changes in v3:
> >   - Add Krzysztof's R-b
> >
> > Changes in v4:
> >   - Drop Krzysztof's R-b
> >   - Add some new properties
> >
> >  .../leds/backlight/kinetic,ktz8866.yaml       | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > new file mode 100644
> > index 000000000000..18571d69accb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktz8866.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Kinetic Technologies KTZ8866 backlight
> > +
> > +maintainers:
> > +  - Jianhua Lu <lujianhua000@gmail.com>
> > +
> > +description: |
> > +  The Kinetic Technologies KTZ8866 is a high efficiency 6-sinks led backlight
> > +  with dual lcd bias power.
> > +  https://www.kinet-ic.com/ktz8866/
> > +
> > +allOf:
> > +  - $ref: common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: kinetic,ktz8866
> > +
> > +  current-num-sinks:
> > +    description: Number of LED current sinks.
> > +
> > +  current-ramping-time:
> > +    description: LED current ramping time.
> 
> Needs to document know what units this value is expressed in. IIRC
> this should be expressed in SI units and included the property name.
> Something like:
> 
>   current-ramping-time-us:
>     description: LED current ramping time in microseconds.
> 
Get it, I will send a new version patch.
> 
> > +
> > +  led-ramping-time:
> > +    description: LED on/off ramping time.
> 
> +1
> 
> 
> Daniel.
