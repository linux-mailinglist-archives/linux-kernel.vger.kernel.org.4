Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE064DE95
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiLOQ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiLOQ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:26:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70C0218A4;
        Thu, 15 Dec 2022 08:25:07 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c66so27765411edf.5;
        Thu, 15 Dec 2022 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Py/vysFzJts4D379yYBV14GJq8PM0BBmsGxpLWSgnm4=;
        b=qqe3qUvy408KMlLwG9mEIR4A1pE/oxDioVE8Ttf6XiVsYLEoIpZ+aYEQTgwLgeWn4l
         XdsdHgGnBatNcu65+L5eDCGv2yNHsfbhdsvdFVb5y2aK+m6wT0rroNV3SOKE1UXP5Jxp
         gHh2Hs6OWa0RHPIvt/9sVN5AG/Ibsov/NBwRD7De892as8ztpB9h8gh1qCK4DJ6/aVEs
         4qgSok7j2dMwylblpeuhSZmpYoZ+kqqNW/O2WbTxtp9rT9DbevH0taI+h9xkhGCgS50K
         vNAL9sklTZSPKf9UzfIdLyM1mbtDv4jqe+0AdWTE6SAd0UkjKMzSMSxqfWn5/Ro2xkWw
         /UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Py/vysFzJts4D379yYBV14GJq8PM0BBmsGxpLWSgnm4=;
        b=G50w0klsvpjLwXSFjuZmExppptfCyFGKn8jeSihOWHZWsOftqf8qS0ezgdx7K4UP0g
         N7AcF1mach9RMYCGGlTKBgZ7bS08jiJuESAy/logPuWJF1Aoc7mwxch7OZwe69OrAlig
         4tMYgURxJszYCRdvXFOXVYS/3xCklSp9QhE5IbSnw6q9Sz/TiR4UopBFx6s2M0ClnjdT
         Mcm4wLgaFxsuqHS6zv+s5ecSc2r6WvyHcYCvywPjxfZ0DKDqtZwsLyMs+V177KNdFD7T
         ffBkON3g7QKJQETuYTjJhAFTodwNWV59WdssG/TpOya9OMy2dL3Zo9AiAfpBbZL52mjd
         mLNQ==
X-Gm-Message-State: ANoB5pm9A4a7j1XXoAavNwtlY62lucPh+ZCykp7ZhFYdV8xVC1ZP9TP+
        Uk5gA83hlCxyJc1XS5XfSZY=
X-Google-Smtp-Source: AA0mqf6FL2R1zzO7z+hBp3JngNFWlBB+FWzKinQVAYElo/QWwnvNovxJX5oHoFZFExl5VtI8B3qRgQ==
X-Received: by 2002:a05:6402:4491:b0:46f:777f:f9ad with SMTP id er17-20020a056402449100b0046f777ff9admr21141828edb.19.1671121506284;
        Thu, 15 Dec 2022 08:25:06 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7df94000000b0044dbecdcd29sm7612037edy.12.2022.12.15.08.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 08:25:05 -0800 (PST)
Message-ID: <a279467764c063fccf28c7d8fdfac2ab57570fee.camel@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ep93xx: Add
 cirrus,ep9301-adc description
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 15 Dec 2022 17:25:04 +0100
In-Reply-To: <20221215161835.GA138650-robh@kernel.org>
References: <20221214222024.951984-1-alexander.sverdlin@gmail.com>
         <20221215161835.GA138650-robh@kernel.org>
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

Thanks Krzysztof, Rob,

I'll incorporate your comments into the next version, but...

On Thu, 2022-12-15 at 10:18 -0600, Rob Herring wrote:
> > +=C2=A0 clock-names:
> > +=C2=A0=C2=A0=C2=A0 const: ep93xx-adc
>=20
> Weird name for a clock. Generally is signal name or what it=20
> controls (e.g. bus, core, etc.). Perhaps just drop it.
>=20
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - reg
> > +=C2=A0 - clocks
> > +=C2=A0 - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +=C2=A0 - |
> > +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/clock/cirrus,ep93xx-clock.h>

your robot was right, this dependency is missing, I thought I can prepare
the ADC driver in advance, but seems it has to go together with the whole
DT conversion of the EP93xx series.

--=20
Alexander Sverdlin.

