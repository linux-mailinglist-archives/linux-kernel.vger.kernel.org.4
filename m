Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9ED6CC2F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjC1OuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjC1Otr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:49:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0878D526F;
        Tue, 28 Mar 2023 07:49:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t10so50656881edd.12;
        Tue, 28 Mar 2023 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680014955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Tt3ZzUkrDQsON+ZeEjdNFMpp88GP4K8dLDvvazCVRo=;
        b=gIO5hW5j2jIj9Jq+V+O4zBSoDtnqWq3tlXuQDtVN9vd5ttZp+TEov34IajeBAFzh05
         POOsOcyr/qRYs+41dHvz0XvjbOI8M8uqF1p3gvTz0Pqi277gvgL1iBfPx/LYmtRBQLOx
         7+cxsk6dZViurUFYtOx4Kg57WYquFEzASNrdFi6tQ4dK/DyChfz3kT8bDae0Ile0r34B
         0w9uHux3ohTBeX3E06eGIeeICwEra+1F9TrEXNodX8l29BYK1aQFzQmKR2i2BoAP9URC
         cEqyiEZPxZM54FfG//OWafs4d58nW5oSW8GBvfv7LMn7TLKPNpmiNKt3dGdVTJ5sDwPC
         Nj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680014955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Tt3ZzUkrDQsON+ZeEjdNFMpp88GP4K8dLDvvazCVRo=;
        b=JVC5gecRenZUfBZa6P/8s7LovaRw8adrhqnEEsOjVK0W+7dKIbUp50hFhrmrnSTjwA
         +jpaysswTlirDGn42wynyIuM3bY54HfEjr9vc90UGBQE0xJAfX0PKmIOz1kJnwYu29HT
         Di5rsMiUdXH+em5UJZjmnSDHFmeGtBJebSdOocimDSEE8puQ3+F6YyK0wnonRLYIHBFS
         RuHBoLxvVS3PRFLuxRUZ7ArQOqUYpSKVKBtsO8WAoXSnJ6aVESfUbA3kMyW6m3zoZVnR
         RBqxHc+I2UGjjqn6De88t1M7taTEWm3rMGZC4z+I9Xxq7osCjmQ32sUfBWU2nEJ+U6Xx
         pDGw==
X-Gm-Message-State: AAQBX9elqJFbFgM6qNqUgzBrch0zmXf93Okrty0uRj595mgW+Dw00ZH9
        Hw7wDqItVCAt5b3N7y/M5pk=
X-Google-Smtp-Source: AKy350aaILPWkwq8PQ4wGpMo8dXGo/pYG1HXsb65QpQDJGVFJqgFJIbcZRt0XHmtkSaT+b/Y6UYDWQ==
X-Received: by 2002:a17:906:539a:b0:946:bc67:67ac with SMTP id g26-20020a170906539a00b00946bc6767acmr2934052ejo.75.1680014955057;
        Tue, 28 Mar 2023 07:49:15 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id p25-20020a170906499900b008b2aba5fb22sm15308329eju.206.2023.03.28.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:49:14 -0700 (PDT)
Message-ID: <60bbad1b38b8e3c9c3efefb0fb7b8d3cad7fa98c.camel@gmail.com>
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date:   Tue, 28 Mar 2023 16:51:18 +0200
In-Reply-To: <ZCL7J5a7UZVayQVS@smile.fi.intel.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
         <20230307112835.81886-6-okan.sahin@analog.com>
         <20230315175223.GI9667@google.com> <20230315175257.GJ9667@google.com>
         <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
         <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
         <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
         <d2bed74b-9eb9-45af-8f45-ad2c2889024a@sirena.org.uk>
         <fc07de9af0b691fbd3a5915c8293f0c7ad4c4e06.camel@gmail.com>
         <ZCL7J5a7UZVayQVS@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-28 at 17:35 +0300, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 04:18:30PM +0200, Nuno S=C3=A1 wrote:
> > On Tue, 2023-03-28 at 14:46 +0100, Mark Brown wrote:
> > > On Tue, Mar 28, 2023 at 03:26:44PM +0200, Nuno S=C3=A1 wrote:
> > >=20
> > > > IIRC, regmap_read() is not really reentrant and it is used in
> > > > the
> > > > IIO
> > > > driver on the sysfs interface. So, yeah, I think you need the
> > > > regmap
> > > > lock and better just leave the config as is. Yes, the lock is
> > > > opt-
> > > > out
> > > > so let's not disable it :)
> > >=20
> > > All the regmap operations are fully thread safe.
> >=20
> > Even if 'config->disable_locking' is set? I think that is what's
> > being
> > discussed in here...
>=20
> In case the driver has its own lock to serialize IO how on earth the
> regmap
> lock is needed. That's what I asked the author of the driver. He told
> the code

Well, if the driver has it's own locking, then sure we do not need
regmap's lock...

> doesn't require the regmap lock, and I tend to believe the author.
> So, why to
> keep it?
>=20

However, if you look at the adc driver, I can see plain regmap_read()
calls without any "outside" locking.

- Nuno S=C3=A1
