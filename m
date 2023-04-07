Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B02F6DAE5C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbjDGNvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjDGNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:51:16 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DA4CA03
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:48:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q5so1628131ybk.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680875316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKK09fngq38ILpy1qwOd5H4TNRR3elskTobTEmmbiwE=;
        b=gecNJ+X1UXFrJOR9jcDYcM6qMfLOurNZETsFwO7h71tAaUNxew8gclFKyL6cXUzze3
         Aptfhq7i7Hhh0c69UWzoA0lLdtiaXsP+LwYlb7dIGKCsvL2npvyvml+tRD3CpexDD3Am
         nlK34EUsiaWTGsygZivf6TaFZirXlH7i6YVwfyk64Pwboul69xIWB4A9H447UcHr30vH
         aq3ec57aimCI3IE40YFoqQXAXVxdsD0CKPQk+/NtO6iFdOV0wUQVqD3NKXIg5L2bKBB4
         mOa3oSGOUdMRjxVa+WAgNIGnir4KRvZaNTGeSGf5uTx2Gayb+XkwtNlDZN3apq2PH3o7
         aKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680875316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKK09fngq38ILpy1qwOd5H4TNRR3elskTobTEmmbiwE=;
        b=WsbWunxRnfROQ509Usqcqk0GJT6l7MUpohAQixO8tbQGYEazdRaMTXQBfKiQKKPn2g
         3YcoAWFcfn/Vtspm9u5SK5s0YdKYFo4YJKTHwmB39ggpPVVdfiGeYlHo5FFRUoWMP21Q
         c+rg/hoYqFAsDuvMokGHIzTc4CBTfMou96TVCQ0hd+UBW6f6K5ludtlR13qqaOwsiUMe
         1dutQZVbv3wUguPsECV1DLiFtVUKZKtPcngrn9L6Mv8SCegj0SEENMFXyCj+kQeafq0B
         spQ7ekWzzHPQHIife+RF8lw4hwWaYPSyi4RvKFzISMtWBowpSUGfBItAP30Yzdxe3e31
         prqw==
X-Gm-Message-State: AAQBX9e2FGd5fkirfuWDLk+72sehm1wuWyBu1+ohr8TmNeM79xPDBBvE
        XzmedYMZioB/WJTp6oeJCwLW3Hbs0EprD3jEhd5ARw==
X-Google-Smtp-Source: AKy350aaHrMYyuOilTUIt2bIGijezFMGhN+vlFiDrxGpwtyukP/2S2+L+vnBLQ8icbdnzVt0fXeoQ7uKNhgsTqwyKgo=
X-Received: by 2002:a25:740f:0:b0:b09:6f3d:ea1f with SMTP id
 p15-20020a25740f000000b00b096f3dea1fmr1907548ybc.4.1680875316286; Fri, 07 Apr
 2023 06:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230327130010.8342-1-okan.sahin@analog.com> <20230327130010.8342-3-okan.sahin@analog.com>
 <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
 <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
 <CACRpkdZJA0DyzgLxm9HFeHO03rqNUff=avuV=VrGuJkkOg6wNQ@mail.gmail.com> <25e1fda4b6df2d10444d7eca3cd0e387@walle.cc>
In-Reply-To: <25e1fda4b6df2d10444d7eca3cd0e387@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Apr 2023 15:48:25 +0200
Message-ID: <CACRpkdYKEid8-0-7sBECNgSyW3kMRCsv3DeBVUzxo4z6p+Grnw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
To:     Michael Walle <michael@walle.cc>
Cc:     "Sahin, Okan" <Okan.Sahin@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 3:57=E2=80=AFPM Michael Walle <michael@walle.cc> wro=
te:

> OTOH I'm not sure the driver is doing it correctly, because it also
> seems to switch the pullup resisters together with the direction.
> I'm not sure that is correct. So there might be just one register
> involved after all and the GPIO_REGMAP should work again.

I'm pretty sure that should be in the .set_config() callback.

> Also, according to the datasheet this has some nv memory (to set the
> initial state of the GPIOs [?]). So it should really be a multi-function
> device. I'm not sure if this has to be considered right from the
> beginning or if the device support can start with GPIO only and later
> be transitioned to a full featured MFD (probably with nvmem support).

That's a bit of a soft definition.

If the chip is *only* doing GPIO and nvram it can be a GPIO-only
device I think.

The precedent is a ton of ethernet drivers with nvram for storing
e.g. the MAC address. We don't make all of those into MFDs,
as the nvram is closely tied to the one and only function of the
block.

Yours,
Linus Walleij
