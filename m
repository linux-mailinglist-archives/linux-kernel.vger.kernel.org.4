Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915FB67BF77
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjAYWAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjAYV76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:59:58 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0EA5D111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:59:54 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id u3so5065070uae.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ5Mm5ygDFJ/dbpXHc8aAO+GKU6ptqcF+btQdWq/FjQ=;
        b=k3ppRTlBBGLRNaaLWoiXK9R56Ttogya6SSKR7o/k4rXxD/wEfQ1bgYq0B/GYeOWqfI
         YhLXDUAeggwXR9kIEXDsFjb3kYGAXc/cSnVMrC1bYHGTJ7mQAtOQmP45RVxmuiW6CJ0f
         bqVzigypl50W9XtpidbG37z5wF3FE7ljyQkX1jyFPkuK9EiUTn1yr7oRPWuo5FTF78w3
         d1kuUo222ArFeF0KoR2JDpYJaVXYQ7Pn3cnslgHDD/52BiMzot+3SlPDXTfG9dIMLKwi
         XkdGBT6760p0zsvUb7z/4dsuubRw6iXflzw6ZBO/WwmoGZCwhwVgoOeHfZCLZ+LaWB+g
         aHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQ5Mm5ygDFJ/dbpXHc8aAO+GKU6ptqcF+btQdWq/FjQ=;
        b=rpdQSCz0p+/w/JWUBO0bgav9wyjTM4Wl9oPXRHQni6U3LtrrUoGwaB5nryhMlWPlVL
         pbsYMVTb5WffVIf9bvzoMVFyG9OIY83v2RAUYLUL1wppxxFwjCWFmZIqGRLVBjmk+Fll
         nQH7LVnSCbG8dJ7+8gDJEnKsISPx1CXHHVEQ49YMprkKjYmFIWvxZeboMVe8yImlBqGu
         GDhtQa5R9Xn3DAc8iL1JoRSkHOgzThePDfRtA8C7v/R2Gu43EEL+eM6qKXlKhM6lJjHQ
         Nh4U3qyNL1Rc8kGp062vw5CxicQl13Bp3l/KKOVCHv0lQvGzNrrKA6tEn15850OfHz1/
         4QLg==
X-Gm-Message-State: AO0yUKVNqKuVtOyeFSzOhQ/dM554vnzuUs9q6s30AqEbnvxRWcYQgYGv
        v0KV1uBo/qy825ZfyrLVwKVf8G1hFQAv9FiSFCedKA==
X-Google-Smtp-Source: AK7set/0yJAWCwrxnr8GVGtPpFu9vcmoxfKwCikOjdfR+xtz3EDp3RRSro35y/qInifYZ4Io23kqMnHm9kaVY62GHSg=
X-Received: by 2002:ab0:230d:0:b0:654:fe4b:af9c with SMTP id
 a13-20020ab0230d000000b00654fe4baf9cmr913514uao.81.1674683992901; Wed, 25 Jan
 2023 13:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20230125-tfp410_i2c-v1-0-66a4d4e390b7@criticallink.com>
 <20230125-tfp410_i2c-v1-1-66a4d4e390b7@criticallink.com> <Y9GeD/vXZ1RJ1MLZ@pendragon.ideasonboard.com>
In-Reply-To: <Y9GeD/vXZ1RJ1MLZ@pendragon.ideasonboard.com>
From:   Jon Cormier <jcormier@criticallink.com>
Date:   Wed, 25 Jan 2023 16:59:41 -0500
Message-ID: <CADL8D3YggahBhipLVO1_E+0+N8bQgzfwkwPUkFm3MxD_F-m-nQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: bridge: tfp410: Add tfp410 i2c example
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 4:24 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jonathan,
>
> Thank you for the patch.
>
> On Wed, Jan 25, 2023 at 04:09:09PM -0500, Jonathan Cormier wrote:
> > Add a i2c example with HDMI connector
> >
> > Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> > ---
> >  .../bindings/display/bridge/ti,tfp410.yaml         | 42 ++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> > index 4c5dd8ec2951..456214f14b47 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> > @@ -116,4 +116,46 @@ examples:
> >          };
> >      };
> >
> > +  - |
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
>
> Please use 4 spaces for indentation, as in the other example.
Will do, the whole file is 2 space indents. I didn't notice the
examples switch to 4 spaces.
>
> > +
> > +      hdmi_encoder: tfp410@38 {
> > +        compatible = "ti,tfp410";
> > +        reg = <0x38>;
> > +
> > +        ports {
> > +          address-cells = <1>;
> > +          size-cells = <0>;
> > +
> > +          port@0 {
> > +            reg = <0>;
> > +            tfp410_in: endpoint {
> > +              remote-endpoint = <&dpi1_out>;
> > +            };
> > +          };
> > +
> > +          port@1 {
> > +            reg = <1>;
> > +            tfp410_out: endpoint {
> > +              remote-endpoint = <&hdmi_connector_in>;
> > +            };
> > +          };
> > +        };
> > +      };
> > +    };
> > +
> > +    hdmi: hdmi_connector {
> > +      compatible = "hdmi-connector";
> > +      label = "hdmi";
> > +      type = "a";
> > +      ddc-i2c-bus = <&i2c1>;
> > +      port {
> > +        hdmi_connector_in: endpoint {
> > +          remote-endpoint = <&tfp410_out>;
> > +        };
> > +      };
> > +    };
> > +
>
> You can drop the hdmi connector, the example will still validate.
Okay
>
> >  ...
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
