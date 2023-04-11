Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEFF6DDD5B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDKOLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDKOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:11:53 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC41A359D;
        Tue, 11 Apr 2023 07:11:52 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id cg4so146649qtb.11;
        Tue, 11 Apr 2023 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681222312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp5TeUo87Ef5LRFqAMptSkS+XyNmpn4jmV0jNCTXKOw=;
        b=Hf8ptq0WvJuev7sP/M2XDvm9UtgR/kCdTdNUNvr/4g/NGv3+CFcqK5Gd8wENKSbu48
         XwfVZY5aI8uJqXi174yCs1+/y+t+eHUXQI7Lc4NB207+G/ifkUF/+8QY8upbjGSMDj05
         S/rpjE9Hzok/DC0+98Wk3giPiPUj6p5nEm1RWRm50zJ1MCbGAMExaDv27ahEtJvBxce1
         5G9NM/S2uktq8/CHSTz1s50ek6B6BZYYpAJoCeed3m1mbOvN9Iv3QrzGRkAUlZ5fCK6A
         HzgxSUS1xL3/Z2RIOG5+AzNhUOyxjSEQfvAoVNB7tk3zhTzXcbZFpoeizvY8+nQHQ9Ib
         hsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp5TeUo87Ef5LRFqAMptSkS+XyNmpn4jmV0jNCTXKOw=;
        b=iXNuFcFFxdW6FaMVYzvxMhFo7CKHQM1UmLqWi/sKvbeN+UbjYrMEgG8g9KtU7VGXG5
         rq2WGG1nEs9fJINJ5VIUDSWomizVZqlY6uQQMveG57hKhRH5AFJZX++l6kNIrJ/YiTjN
         o48ghDnUPcSXRgRKKSfP8etW6OtdMXDc3Fz5yFR9Pszy24T+6GbyxUq+lYTCoVSJR6oe
         p9Ptye3eDxBT+ZKsf7/c7xWFykggZbhzwWOZNaERO9dNr3QHH0rfHYXAHvwGc3XEDog7
         2Usja4EmjKgJor3w2uGAiHFmmEjwQ5svH7Wgiwsr4DQg4lZPFzepJd+AeaLCt61xk0WR
         WDiA==
X-Gm-Message-State: AAQBX9fHF88MQ6h79Np7kOe4EJLAnBddH9OZyWHuMsb+Dc7Mbg8cAAVb
        drfQ/aEHxTwGwRkvYi1vkJPi8luC+eMeXPFnBjE=
X-Google-Smtp-Source: AKy350YPwoaaW9Y8GXCOfWW6C/PStwmdAlayzlDcVd0em0WPfCC44MrpTTN0GoQVUdzJvz++rNYsW1CfUJjO8M7TGcA=
X-Received: by 2002:a05:622a:1b92:b0:3e6:720f:baed with SMTP id
 bp18-20020a05622a1b9200b003e6720fbaedmr3708734qtb.0.1681222311675; Tue, 11
 Apr 2023 07:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230327130010.8342-1-okan.sahin@analog.com> <20230327130010.8342-3-okan.sahin@analog.com>
 <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
 <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
 <CACRpkdZJA0DyzgLxm9HFeHO03rqNUff=avuV=VrGuJkkOg6wNQ@mail.gmail.com>
 <25e1fda4b6df2d10444d7eca3cd0e387@walle.cc> <CACRpkdYKEid8-0-7sBECNgSyW3kMRCsv3DeBVUzxo4z6p+Grnw@mail.gmail.com>
 <ZDBivYlwJ6zgaFTg@surfacebook> <MN2PR03MB516879DCD6600827AEE2BDC9E7949@MN2PR03MB5168.namprd03.prod.outlook.com>
In-Reply-To: <MN2PR03MB516879DCD6600827AEE2BDC9E7949@MN2PR03MB5168.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Apr 2023 17:11:15 +0300
Message-ID: <CAHp75VcxscqmLFRKJ8apLsY3Dsih=FMQn65cRGTUSeCZ-qLy9Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 9, 2023 at 5:25=E2=80=AFPM Sahin, Okan <Okan.Sahin@analog.com> =
wrote:
> >Fri, Apr 07, 2023 at 03:48:25PM +0200, Linus Walleij kirjoitti:
> >> On Wed, Apr 5, 2023 at 3:57=E2=80=AFPM Michael Walle <michael@walle.cc=
> wrote:

...

> >> If the chip is *only* doing GPIO and nvram it can be a GPIO-only
> >> device I think.

I have read a datasheet, it has the pre-boot settings, but it doesn't
matter from the Linux point of view. The only thing which we need to
take care of is to have the EEPROM disabled during GPIO interaction.
However, there is a question as to how this device should actually
commit into EEPROM the state to survive the cold/warm power cycle.
What is the persistent flag for, btw, I haven't been familiar with it?

> >> The precedent is a ton of ethernet drivers with nvram for storing e.g.
> >> the MAC address. We don't make all of those into MFDs, as the nvram is
> >> closely tied to the one and only function of the block.
> >
> >I agree with Linus. This should be part of the actual (main) driver for =
the chip as many
> >do (like USB to serial adapters that have GPIO capability).
> >Also this code lacks of proper locking and has style issues.

...

> Could you give more detail related to locking and style issues?

You use a few IO accessors in a row without locking, which means at
any point of this flow some other CPUs may access the chip using the
same or other APIs of this driver.

--=20
With Best Regards,
Andy Shevchenko
