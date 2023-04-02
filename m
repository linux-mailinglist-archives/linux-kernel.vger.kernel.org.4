Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2254C6D387B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjDBOjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjDBOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:39:08 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99C55B95
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 07:39:06 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id m16so11721478ybk.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680446346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3N9fWZtpLO0Sg4sj3m76F/RV8ibBJc+bQijXm6DYBRk=;
        b=lOSB5J0kEhbBKItAbhHT2CtvJI2fMCJ0ZPYfIa8lq6BweDV22PbERN23NoDZPWlGY8
         O9QwFeB/s9ccjly3pzDO7ciysG0T1N77xkLX8th5Lc+5w8Xzrhcj4VxiAZxgTyAi4uc7
         MEUk3LM8HvQNeyHV1feFcBjwBhGIFTVWSQaOIUqmBGZ5vsgXxQa5WZbE4iSVdBulHFO0
         KzJJRYzbVQonpwEROy945v3rh0Pbsy8uxl8pRkCoAKrNIBndm6CjfSNOSkGoN/fw+jIB
         kbTW/fMb54XI/36yFxeFtKAk0i+i5jLYjvX6Bg8GouKA4wegchAaByku+YJ11vZ3R50Z
         7Jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680446346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N9fWZtpLO0Sg4sj3m76F/RV8ibBJc+bQijXm6DYBRk=;
        b=PrUYYmiXqsnZOZLS0+HBxQ2p+OJvMAZm6HRpj4c+ZDHSnd0Lqs6OnFYJIBjYaYGJmu
         Pz35E4pLII4ve2BShlbiHxYjf4fLwo8oMApoiKo4TETQ947EKgHWksswO38vOVriLIai
         0XeGeuBUpf6XrjWh39fGC1C1hTdPCCxc17hqaveatPPNahH/5K82LUmhS4c6ylkfnrzf
         o+T9p9rX3p7nyMSe9TxjGhvBbhX3l5QVuUJx+45xLvF3A3DDsA92RHsZTG2hL4vW0/gR
         gMetcaWd95bokCtLjpCSDUDe+U+i8E1H4ViyHmOlwTnVIrQ1SsqqqMdEQKLIeagmRK1Y
         eYlQ==
X-Gm-Message-State: AAQBX9eDsrdZdlGsJeXZwezIJGxlBl0YhjYwhgf5nRxb+zho5Kr4HE3Q
        uoITROB00fNZT6T/tIaRAvl0zwZcnsnbxanwYGxz2w==
X-Google-Smtp-Source: AKy350ZhXCUP/958dh5II/J6GHxeEHEThvQVDqrVLkvSNZyMUuITeZtAy4HwyF53yfHuaeTEZT+clQ==
X-Received: by 2002:a25:a429:0:b0:b60:5d8:d0f3 with SMTP id f38-20020a25a429000000b00b6005d8d0f3mr29273418ybi.57.1680446345787;
        Sun, 02 Apr 2023 07:39:05 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id s102-20020a25aa6f000000b00b7767ca7499sm1931445ybi.54.2023.04.02.07.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 07:39:04 -0700 (PDT)
Date:   Sun, 2 Apr 2023 10:39:02 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, techsupport@winsystems.com,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v5 3/3] gpio: ws16c48: Migrate to the regmap API
Message-ID: <ZCmThuzUBYdp29UR@fedora>
References: <cover.1679845842.git.william.gray@linaro.org>
 <58531b1b2428e4d5d2ea79e721f7ef6450665280.1679845842.git.william.gray@linaro.org>
 <ZCF9bdyefA/oDmdG@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7nykn8bRuuVzVdrV"
Content-Disposition: inline
In-Reply-To: <ZCF9bdyefA/oDmdG@smile.fi.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7nykn8bRuuVzVdrV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 02:26:37PM +0300, Andy Shevchenko wrote:
> On Sun, Mar 26, 2023 at 12:25:59PM -0400, William Breathitt Gray wrote:
> > The regmap API supports IO port accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver.
> >=20
> > The WinSystems WS16C48 provides the following registers:
> >=20
> >     Offset 0x0-0x5: Port 0-5 I/O
> >     Offset 0x6: Int_Pending
> >     Offset 0x7: Page/Lock
> >     Offset 0x8-0xA (Page 1): Pol_0-Pol_2
> >     Offset 0x8-0xA (Page 2): Enab_0-Enab_2
> >     Offset 0x8-0xA (Page 3): Int_ID0-Int_ID2
> >=20
> > Port 0-5 I/O provides access to 48 lines of digital I/O across six
> > registers, each bit position corresponding to the respective line.
> > Writing a 1 to a respective bit position causes that output pin to sink
> > current, while writing a 0 to the same bit position causes that output
> > pin to go to a high-impedance state and allows it to be used an input.
> > Reads on a port report the inverted state (0 =3D high, 1 =3D low) of an=
 I/O
> > pin when used in input mode. Interrupts are supported on Port 0-2.
> >=20
> > Int_Pending is a read-only register that reports the combined state of
> > the INT_ID0 through INT_ID2 registers; an interrupt pending is indicated
> > when any of the low three bits are set.
> >=20
> > The Page/Lock register provides the following bits:
> >=20
> >     Bit 0-5: Port 0-5 I/O Lock
> >     Bit 6-7: Page 0-3 Selection
> >=20
> > For Bits 0-5, writing a 1 to a respective bit position locks the output
> > state of the corresponding I/O port. Writing the page number to Bits 6-7
> > selects that respective register page for use.
> >=20
> > Pol_0-Pol_2 are accessible when Page 1 is selected. Writing a 1 to a
> > respective bit position selects the rising edge detection interrupts for
> > that input line, while writing a 0 to the same bit position selects the
> > falling edge detection interrupts.
> >=20
> > Enab_0-Enab_2 are accessible when Page 2 is selected. Writing a 1 to a
> > respective bit position enables interrupts for that input line, while
> > writing a 0 to that same bit position clears and disables interrupts for
> > that input line.
> >=20
> > Int_ID0-Int_ID2 are accessible when Page 3 is selected. A respective bit
> > when read as a 1 indicates that an edge of the polarity set in the
> > corresponding polarity register was detected for the corresponding input
> > line. Writing any value to this register clears all pending interrupts
> > for the register.
>=20
> ...
>=20
> > +static const struct regmap_config ws16c48_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.reg_stride =3D 1,
> > +	.val_bits =3D 8,
> > +	.io_port =3D true,
> > +	.max_register =3D 0xA,
> > +	.wr_table =3D &ws16c48_wr_table,
> > +	.rd_table =3D &ws16c48_rd_table,
> > +	.volatile_table =3D &ws16c48_volatile_table,
> > +	.cache_type =3D REGCACHE_FLAT,
> > +};
>=20
> Do we need regmap lock?

We make regmap calls within an interrupt context in this driver so I
think we need to disable the default regmap mutex locking behavior; I
believe the current raw_spin_lock locking in this driver is enough to
protect access.

> >  /**
> >   * struct ws16c48_gpio - GPIO device private data structure
> > - * @chip:	instance of the gpio_chip
> > - * @io_state:	bit I/O state (whether bit is set to input or output)
> > - * @out_state:	output bits state
> > + * @map:	regmap for the device
> >   * @lock:	synchronization lock to prevent I/O race conditions
> >   * @irq_mask:	I/O bits affected by interrupts
> > - * @flow_mask:	IRQ flow type mask for the respective I/O bits
> > - * @reg:	I/O address offset for the device registers
> >   */
> >  struct ws16c48_gpio {
> > -	struct gpio_chip chip;
> > -	unsigned char io_state[6];
> > -	unsigned char out_state[6];
> > +	struct regmap *map;
> >  	raw_spinlock_t lock;
> > -	unsigned long irq_mask;
> > -	unsigned long flow_mask;
> > -	struct ws16c48_reg __iomem *reg;
> > +	u8 irq_mask[WS16C48_NUM_IRQS / WS16C48_NGPIO_PER_REG];
>=20
> Looking at this (and also thinking about the previous patch) perhaps this
> should be declared as
>=20
> 	DECLARE_BITMAP(...);
>=20
> and corresponding bit ops to be used?

The irq_mask array is just used to store the previous mask_buf state for
comparision against the next time in the ws16c48_handle_mask_sync();
we're just checking if mask_buf has changed so we don't needless write
out to hardware.

I think declaring as BITMAP would obscure the intention of this array,
as well as increase the amount of code in ws16c48_handle_mask_sync()
because mask_buf is not declared as a bitmap and would need to be
converted for comparision against a bitmap irq_mask. So I believe we
should keep irq_mask as an array of u8 for now.

What might be worth discussing is whether the regmap_irq should
internally utilize BITMAP rather than passing around array elements and
indices. The regmap_irq buffer arrays (such as mask_buf) appear to
operate essentially as makeshift bitmaps, so I suspect they could
benefit from the Linux bitmap API.

> > +static int ws16c48_handle_pre_irq(void *const irq_drv_data)
> >  {
> > +	struct ws16c48_gpio *const ws16c48gpio =3D irq_drv_data;
> > =20
> > +	/* Lock to prevent Page/Lock register change while we handle IRQ */
> > +	raw_spin_lock(&ws16c48gpio->lock);
> > =20
> >  	return 0;
> >  }
>=20
> Hmm... Don't we have irq bus lock and unlock callbacks for this?

The WS16C48 shares the same address space for its interrupt polarity,
IRQ masking, and IRQ status/ACK registers; a page register is utilize in
order to multiplex between the three register pages.

Because the same address space is shared between these different
functions, we use the ws16c48gpio->lock to coordinate access between
them to prevent the registers from being clobbered. For example,
interrupt polarity is set in irq_set_type(), while IRQ masking and
ACKing occurs in irq_bus_sync_unlock(), and IRQ status reading happens
in regmap_irq_thread().

The lock acquired in ws16c48_handle_pre_irq() is for just this last
function of checking the IRQ status. We can't hold it through
irq_bus_lock() because we have to handle IRQ masking and ACKing in
irq_bus_sync_unlock().

> > +static int ws16c48_handle_post_irq(void *const irq_drv_data)
> >  {
> > +	struct ws16c48_gpio *const ws16c48gpio =3D irq_drv_data;
> > =20
> > +	raw_spin_unlock(&ws16c48gpio->lock);
> > =20
> >  	return 0;
> >  }
>=20
> Ditto.
>=20
> Also shouldn't you annotate them for sparse so it won't complain about
> unbalanced locks?

Yes, I'll annotate them with __acquires and __releases respectively.

William Breathitt Gray

--7nykn8bRuuVzVdrV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZCmThgAKCRC1SFbKvhIj
K3RYAP9hBePfdyC+LkCcOsy4FY3Ik1kYlm2xvDwczN5n163miwD/bogMJ75v3Ig7
A2iU9EkyHKauK8S+raBTE0wVRpFSowg=
=YsLS
-----END PGP SIGNATURE-----

--7nykn8bRuuVzVdrV--
