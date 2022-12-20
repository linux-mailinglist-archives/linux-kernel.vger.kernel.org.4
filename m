Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3486522C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiLTOgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiLTOfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:35:53 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A256454
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:35:52 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id b189so11894847vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sh188zIkxDCONEPP/MD0Q17USU6PjQm9Z+QknoEQD/M=;
        b=pqxLxpMAIUffofkgMntG+ivSHBiAfFtQi5aRiGEHSkR2ysa4EurdfwulgsFuvoEu2e
         H8GTVdHWWURaZ04bEwsW/8RGJZZVvpdhu7LBJb1qIps40XDzYFzLXpLM55FdaXh3FPlf
         KDkwac3qH7+1NYGie+8jBHyrTFChA+0xlvDgK8MjFtQ2tnofmAgJmUHin5O3JtNOGq62
         GD9ASAgY0ozi+cHQT8LO6dFB5l/5HvgcpkH6FzAw/9qF/VR13Hg7TBuTVKASfnCxIhVd
         DrLGxN8XoKX4clmvR/M7sKx3ZSU0btUjKP7zdOVyvRi4yJn45KDmIc7qa8o84mLAeDQZ
         CWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sh188zIkxDCONEPP/MD0Q17USU6PjQm9Z+QknoEQD/M=;
        b=ptiBKcgas81zUGflkEqtqYAzo7abv7uLfvKdDPdSL2faPhTrwgFt12Fbp7hUrc8tWk
         mIkg3fHR/lbePwirvES5mqH9G7t3xH/r+caQ9f9zEcOriXVreoyxIYY4RDG3sNOuFWjy
         PcBEcVdayN0PSoi78DBmZkZDp/qcSV+EOHWxPp8uZ9QnTYnwFIo1KlIyYppxKtE9vd+M
         f8BgPwVtLqAUZ0Tb2Vxt7vIyvpCkLearYYG+3VdxlTl1OyXZqRfhue5L13zPoWOwNBWv
         fXohQjYh8aEnii3WPJ+J4BUTQc4MGWw3V61UjTTUjCDz+k8+9S4TijLeU352ALPWjtD0
         ekmQ==
X-Gm-Message-State: ANoB5pmMjiDGvP/MK8G4fT8Orv/0cwlm4iqTZqOicXBpTvjO7N3vDDFP
        gIkKw13SNUxEBKyhcpKNEtvVrl247EXAL89WvVwvIcJB9ZEUVA==
X-Google-Smtp-Source: AA0mqf75cqBZcEjy82uWbF4vRFhb+atqyA1ifC+lCAod41qxdNHTjS2Cc5YXJ8nBnmOOR5Vc5ZHRUIUW35RQN/++csQ=
X-Received: by 2002:a05:6102:3f45:b0:3aa:2ae2:70ea with SMTP id
 l5-20020a0561023f4500b003aa2ae270eamr49155450vsv.5.1671546951135; Tue, 20 Dec
 2022 06:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20221214220727.1350784-1-jcormier@criticallink.com>
 <20221220000457.1163446-1-jcormier@criticallink.com> <20221220000457.1163446-2-jcormier@criticallink.com>
 <e0f620b4-5780-fbea-4446-fd68f281281a@linaro.org>
In-Reply-To: <e0f620b4-5780-fbea-4446-fd68f281281a@linaro.org>
From:   Jon Cormier <jcormier@criticallink.com>
Date:   Tue, 20 Dec 2022 09:35:38 -0500
Message-ID: <CADL8D3YUzgk+H70wEG1Qfq-kcn_csUdJyRg2rWfraVb3JsEa_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: hwmon: adi,ltc2945: Add binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 5:15 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/12/2022 01:04, Cormier, Jonathan wrote:
> > Create initial binding for the LTC2945 I2C power monitor.
> > Also adds shunt-resistor-micro-ohms parameter
>
> The last sentence does not make sense. I propose to skip it.
Ok
>
> >
> > Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>
> > ---
> >  .../bindings/hwmon/adi,ltc2945.yaml           | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> > new file mode 100644
> > index 000000000000..f90d40919ee6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/adi,ltc2945.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices LTC2945 wide range i2c power monitor
> > +
> > +maintainers:
> > +  - Guenter Roeck <linux@roeck-us.net>
>
> Maintainer of binding is person interested in the device, e.g. having
> the hardware or datasheet. Not the subsystem maintainer. Unless by
> coincidence this is the same person here?
What do you do with a basic kernel driver which hasn't been touched
since it was introduced except for various refactors? He seems to be
the one who introduced it and most consistently made changes to it.
>
>
> > +
> > +description: |
> > +  Analog Devices LTC2945 wide range i2c power monitor over I2C.
> > +
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/LTC2945.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ltc2945
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  shunt-resistor-micro-ohms:
> > +    description:
> > +      Shunt resistor value in micro-Ohms
> > +    default: 1000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +
> This is a friendly reminder during the review process.
>
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
My bad,
>
> Thank you.
>
> > +additionalProperties: false
> > +
>
> Best regards,
> Krzysztof
>


-- 
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
