Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880A063422E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiKVRHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiKVRHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:07:02 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E582786DD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:07:00 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id n186so16465979oih.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh7BYV8ldd+aVLWtYBb3n7Ai4AxpbwGyNsdWp9GvDlA=;
        b=jUP6RHkQSske/F+HQG0rgsOzOS9EixygiT2hAENmGUN4lt7rnahXONxOw9jtqS8QFt
         tGzs7PnxH/zetT8/BTmG8RcGA4G4kdvJQsllVPcotYx2XBTEzm30Z+2hfq6qwFLt5EFx
         7VW6clI/54aZ7e95clqsfPKIVqgbg+Pc5P9mDBcms8XLlzkAyjm8ckxeultBtFVmFde+
         BJ/5UsyKFIFt1MBFiI1OoZqrWoa8DkEhSFLYHMG4P/0MKQToFWYb441Quf60X6m2N4Ce
         tRr9HwanI6kso1/O/uGweIbKFJSIjHaKBwOR/26lmbnbN+t/kwboPA0AESIcOHtBtHqV
         HmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh7BYV8ldd+aVLWtYBb3n7Ai4AxpbwGyNsdWp9GvDlA=;
        b=nsVMF6dGkky/fpPQYNzJLSILLM3d8QkPyP7qRhzyekKdGUKagp76599jO63lDmqQxc
         IyK5PAMpV13ElEl2wJQT8iqR9R2VHpybNVp7t0XCzKYpJEee+JUpriCHxCwca7Lx3PRQ
         +6oGtw5oZj98AGcpjEPN81CWCE3MfzoFnRKBIM5iIWh7sa9ZEz0N5g/+DKJZg0LTnArM
         Or1sbQfru3sltmpeWJ/VsPcALhnLjoKu0Yam2uKPw3siAuJpOsn/CKkJWBLvTkN1AbOe
         /zPHlD1HKZl/bMStnqvBLJiaTv/0q0xA+hIQRbfW5recu/wirYYjuZsF2bJt9gv+7ODq
         xDOQ==
X-Gm-Message-State: ANoB5pm+tewYntGcImZe2ntuIxjLlAJyztfUSlt1CJEIQFZhJ2cPyJG/
        edy7rgiWzI24nanVsrEZ+1omag==
X-Google-Smtp-Source: AA0mqf4R2fwe9mXisYxdxk2B7RMHSxlbNDgKawJ7eHNKe15WYBOVqCMg6zNLuHqPdbwIlfApL1xNfA==
X-Received: by 2002:a05:6808:1293:b0:359:dc34:5b5e with SMTP id a19-20020a056808129300b00359dc345b5emr14355355oiw.259.1669136819193;
        Tue, 22 Nov 2022 09:06:59 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h14-20020a9d6f8e000000b0066d2fc495a4sm6403704otq.48.2022.11.22.09.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 09:06:57 -0800 (PST)
Date:   Mon, 21 Nov 2022 20:00:02 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc
Subject: Re: [PATCH v2 2/4] regmap-irq: Add handle_mask_sync() callback
Message-ID: <Y3wfEgejAVCsUNcI@fedora>
References: <cover.1668129763.git.william.gray@linaro.org>
 <53e9e89cc9d7e9c20cbdfc13b360dcb43d07f832.1668129763.git.william.gray@linaro.org>
 <Y3PI5n8FXxOtGhzP@sirena.org.uk>
 <Y3ZMga3nphqmAtka@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V2jF4YziYQWRDZVm"
Content-Disposition: inline
In-Reply-To: <Y3ZMga3nphqmAtka@fedora>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V2jF4YziYQWRDZVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 10:00:17AM -0500, William Breathitt Gray wrote:
> On Tue, Nov 15, 2022 at 05:14:14PM +0000, Mark Brown wrote:
> > On Thu, Nov 10, 2022 at 08:55:51PM -0500, William Breathitt Gray wrote:
> >=20
> > > Provide a public callback handle_mask_sync() that drivers can use when
> > > they have more complex IRQ masking logic. The default implementation =
is
> > > regmap_irq_handle_mask_sync(), used if the chip doesn't provide its o=
wn
> > > callback.
> >=20
> > Can you provide examples of something that would make sense to
> > open code in a driver rather than factoring out?  It looks like
> > this has been added due to one of the devices you're looking at
> > for some reason disabling it's upstream interrupt when all of the
> > downstream interrupts are masked, while weird that doesn't seem
> > especally device specific.
>=20
> Sure, I actually intend to use this callback for the 104-idi-48 module
> as well in the v3 submission so I'll describe that situations well.
>=20
> For the 104-dio-48e we have the following:
>=20
>     Base Address +B (Write): Enable Interrupt
>     Base Address +B (Read): Disable Interrupt
>     Base Address +F (Read/Write): Clear Interrupt
>=20
> So for 104-dio-48e, any write to 0xB will enable interrupts, while any
> read will disable interrupts; interrupts are with either a read or any
> write to 0xF. There's no status register either so software just has to
> assume that if an interrupt is raised then it was for the
> 104-dio-48e device.
>=20
> For the 104-idi-48, we do get a status register and some basic masking
> but it's broken down by banks rather than individual GPIO; there are six
> 8-bit banks (Port 0 Low Byte, Port 0 Mid Byte, Port 0 High Byte, Port 1
> Low Byte, Port 1 Mid Byte, Port 1 High Byte):
>=20
>     Base Address + 0 (Read/Write): Port 0 Low Byte
>     Base Address + 1 (Read/Write): Port 0 Mid Byte
>     Base Address + 2 (Read/Write): Port 0 High Byte
>     Base Address + 3: N/A
>     Base Address + 4 (Read/Write): Port 1 Low Byte
>     Base Address + 5 (Read/Write): Port 1 Mid Byte
>     Base Address + 6 (Read/Write): Port 1 High Byte
>     Base Address + 7 (Read): IRQ Status Register/IRQ Clear
>         Bit 0-5: Respective Bank IRQ Statuses
>         Bit 6: IRQ Status (Active Low)
>         Bit 7: IRQ Enable Status
>     Base Address + 7 (Write): IRQ Enable/Disable
>         Bit 0-5: Respective Bank IRQ Enable/Disable
>=20
> In this case, masking a bank will mask all 8 GPIO within that bank;
> so ideally I want a way to only mask a bank when all GPIO are masked,
> and unmasking when at least one is unmasked.
>=20
> Are there existing ways to support these kinds of configuration in
> regmap_irq?
>=20
> William Breathitt Gray

After trying to implement a handle_mask_sync() callback for the
104-idi-48 I discovered that it's not so straight-forward a task. The
mask_buf parameter is unsigned int so I can only represent 32 GPIO at a
time.

I could set the struct regmap_irq_chip num_regs member to '2' to
increase the number of mask_buf elements, but that creates side effects
because the regmap-irq API believes there there are more registers than
the device actually has.

For now with the 104-idi-48 module utilizing the regmap-irq API, we'll
have to leave it where masking one GPIO line masks the entire bank, and
vice versa for unmasking.

William Breathitt Gray

--V2jF4YziYQWRDZVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3wfEgAKCRC1SFbKvhIj
K5IHAQD6GpjmRsEsuUu32ly6ysmGQCT/dnT7Z9jDdRCSrHOvkgD/VFCwVvdchLwO
YAYeUFK5CnMQS6Lx1KFzaXjaXuuEGwM=
=c+EM
-----END PGP SIGNATURE-----

--V2jF4YziYQWRDZVm--
