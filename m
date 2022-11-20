Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B86A63155D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 18:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKTRFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 12:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTRFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 12:05:16 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2615800B;
        Sun, 20 Nov 2022 09:05:14 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-14286d5ebc3so8068673fac.3;
        Sun, 20 Nov 2022 09:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VheYSDFtvLHCDiituLIR+eRxXrleFk3aorOpSVzMQ4U=;
        b=02RCHBfY/JbB+jtltqGWqCpUs1ufgupKWQSpwdFwa8TyqXyDfRLH4IK30HR69zsWAo
         qAcaznQ5WqaiqYBXpyZTAiXB67yiPrsyO+LA909GFIDquz2xeDQ267qpZbHZI+BfmjJN
         /JYCP5qTLP0AQV1upJCrhUfGZjIlxIq2cAXjjTUgo4oXqluCfdaSmDiHO4SjeKWS2Kai
         TG7FgmXiiHHlznkH0Jf4auu2Ai8lWbXzeKbit0qqgWDCiTTkCfgKa/G1xucQ3gReUzrq
         KRJbv0ZTXtDyz0bsHATn3sr895fxE0cZ7IkSmf2aF7/2EluI0xpE/91PzMegYoBPZboq
         8wrQ==
X-Gm-Message-State: ANoB5plygqy5AqeesL8++1a3swnD2pqPxuP+sPEAKK0A4E4fDiuTj+06
        oEY2rY7vkx8LEu+uYHpKCfMoGuJvGw==
X-Google-Smtp-Source: AA0mqf67G516TnraaP+JTVCHo56B4CXRmRuPFyOwAhESA4hEJqYmyLjQMdbVK1YDhqM7/GIM3MGdLw==
X-Received: by 2002:a05:6870:2c85:b0:13c:4592:c2f2 with SMTP id oh5-20020a0568702c8500b0013c4592c2f2mr8070284oab.160.1668963913800;
        Sun, 20 Nov 2022 09:05:13 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f8:5cb3:df5a:23c3:86fb:15a6])
        by smtp.gmail.com with ESMTPSA id 59-20020a9d0141000000b0066aba96addbsm3945259otu.81.2022.11.20.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 09:05:13 -0800 (PST)
Received: (nullmailer pid 3203993 invoked by uid 1000);
        Sun, 20 Nov 2022 17:05:14 -0000
Date:   Sun, 20 Nov 2022 11:05:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Message-ID: <20221120170514.GA3192266-robh@kernel.org>
References: <20221116213615.1256297-1-Naresh.Solanki@9elements.com>
 <20221116213615.1256297-2-Naresh.Solanki@9elements.com>
 <20221120151331.GA1791561@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120151331.GA1791561@roeck-us.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 07:13:31AM -0800, Guenter Roeck wrote:
> On Wed, Nov 16, 2022 at 10:36:13PM +0100, Naresh Solanki wrote:
> > Add common fan properties bindings to a schema.
> > 
> > Bindings for fan controllers can reference the common schema for the
> > fan
> > 
> > child nodes:
> > 
> >   patternProperties:
> >     "^fan@[0-2]":
> >       type: object
> >       $ref: fan-common.yaml#
> > 
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
> >  .../devicetree/bindings/hwmon/fan-common.yaml | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> > new file mode 100644
> > index 000000000000..1954882eed77
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> > @@ -0,0 +1,42 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common fan properties
> > +
> > +maintainers:
> > +  - Naresh Solanki <naresh.solanki@9elements.com>
> > +
> > +properties:
> > +  max-rpm:
> > +    description:
> > +      Max RPM supported by fan.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  pulses-per-revolution:
> > +    description:
> > +      The number of pulse from fan sensor per revolution.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  target-rpm:
> > +    description:
> > +      Target RPM the fan should be configured during driver probe.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  pwms:
> > +    description:
> > +      PWM provider.
> > +
> > +  label:
> > +    description:
> > +      Optional fan label
> > +
> > +  fan-supply:
> > +    description:
> > +      Power supply for fan.
> > +
> 
> I still think that at least min-rpm should be added. It is just as common
> as max-rpm.

Or a table if the response is not linear like LEDs/backlights? Though if 
there's a tach, that wouldn't be necessary.

Rob
