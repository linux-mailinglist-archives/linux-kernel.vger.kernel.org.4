Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440726966C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjBNO0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjBNO00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:26:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD5929170;
        Tue, 14 Feb 2023 06:26:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a2so15847816wrd.6;
        Tue, 14 Feb 2023 06:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1KUT1tm2JstK4SHwVMqDxwvsGpX4N3Zg4TqA6+/967I=;
        b=bkGxPa/4UTf9Yqbew+EqucLOjb01XPqUnayINAeq3O8YkqvGssbdeX/j8ftFQRIaZb
         jAg93u+jCxGYoyz2nqeousjEOlYWsh6yKqKBxSeZYNYsgAXhfgAjXuHewG01HdjDKqXm
         YiW22MT2QQfmbnveSJjA9ty3/uS19S3c9+k7xw3PDBMfI1pv9i6KQ9lbw0PYytNK4cpU
         IdLUGZLhWebpw5up5YHxzdbiP+zd/z9EaV3S4k+PfXX74zLGCCwlZo1FQRB+MfxYBrAg
         DOTbPYf5EdRFzN2UagvgW8LVQZHdVckbr4BMDUfnenBmTZh2WSA48rZnEgk4ukkY3YIx
         agjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KUT1tm2JstK4SHwVMqDxwvsGpX4N3Zg4TqA6+/967I=;
        b=7jKcdU4ovPBk0LPuPDl5QisNjFHxUIB+vuG0imHry9RzGd9sICNeac5lN83oAx1MQN
         dCjtEodzMVvMYEBx+kJ9mzLhnAPE4O6HnKAecnhssfGdPxVjlk9ZSB09m2bkLR6jwCr+
         fs94/jx8LP84JNODb5Kk3NBb/Zw0yFiPHIxfyXg8kQywvaA7fgsCCLy7kWkpLhgGgXVw
         pVnxcsI+mwxTnLs67XosBi5Q3lzN+u70uuF1n77HMFLvUXQ1yqwz8qnZZv36bvHfqSbe
         8U/jBsYSUMIYdrmWAuruKkwh+pcnSw47li6J/pmbLnXSOXVrUf8sf+LLuMoF0eiuNu+V
         Hoig==
X-Gm-Message-State: AO0yUKXxj3NYytna2DtDIUWJ37eUYpiG5dYMQqW2NYtVKHu8KaYDLSS1
        /I3+NTT4wFJIWXkI3epa96U=
X-Google-Smtp-Source: AK7set8dprBf3qnsvY1G06+DkvcfRpjsUDfPlDx4iUVhJnmFWS8SPhMrb7n+rF97nB8B4OL22RuZig==
X-Received: by 2002:adf:f806:0:b0:2c5:5184:abc with SMTP id s6-20020adff806000000b002c551840abcmr2347554wrp.59.1676384775231;
        Tue, 14 Feb 2023 06:26:15 -0800 (PST)
Received: from tuxbook.home ([2a02:1210:8629:800:b2be:83ff:fe21:42e1])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bca57000000b003de8a1b06c0sm20322136wml.7.2023.02.14.06.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:26:14 -0800 (PST)
Message-ID: <ba51ecefb814115e977d90062ca5fe99859cb327.camel@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: ep93xx: Add I2S and AC'97
 descriptions
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Feb 2023 15:26:14 +0100
In-Reply-To: <c4f5f733-ce22-2dfa-30f7-cde309eadaf9@linaro.org>
References: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
         <46d5b6af-23e1-4178-83bc-b4a435b1426e@linaro.org>
         <109868b9492aecaca0a7170cba9fb51e62de7116.camel@gmail.com>
         <c4f5f733-ce22-2dfa-30f7-cde309eadaf9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof!

On Tue, 2023-02-14 at 15:11 +0100, Krzysztof Kozlowski wrote:
> > > > +=C2=A0 interrupts:
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 clocks:
> > > > +=C2=A0=C2=A0=C2=A0 minItems: 3
> > >=20
> > > maxItems instead
> >=20
> > reg and clocks are required, I suppose I should include both minItems
> > and maxItems for both of them?
>=20
> No. minItems is implied.

I see. But I think minItems "3" should be included for clocks, right?

> >=20
> > > > +
> > > > +=C2=A0 clock-names:
> > > > +=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: mclk
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sclk
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: lrclk
> > >=20
> > >=20
> > > The clk suffixes are quite redundant. Don't these inputs have some
> > > meaningful name?
> >=20
> > They are actually meaningful, as they are usually named in I2S, please
> > refer to the EP93xx User's Guide:
> > https://cdn.embeddedts.com/resource-attachments/ts-7000_ep9301-ug.pdf
> > page 71, for instance.
>=20
> OK, but then I like the example - if datasheet would use name
> "clk_clk_this_is_clk" would you still find it meaningful?
>=20
> Every clock input in clocks is a clock. There is usually no need to say
> that a clock is a clock...

I see you point, but this is legacy code (sound/soc/cirrus/ep93xx-i2s.c)
which took these names back in platform data times... I also see that
rather majority of *i2s*.yaml use something "*clk", so maybe it could
be accepted for legacy code?
=20
--=20
Alexander Sverdlin.

