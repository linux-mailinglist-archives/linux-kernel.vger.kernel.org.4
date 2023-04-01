Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BDE6D3136
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDAOGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDAOGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:06:44 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00847B45E
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 07:06:42 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id k17so30263747ybm.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680358002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3wPDaCqdxNaWMMs3wQlLt6E3mfPbGjDIw/Hm+74bU44=;
        b=LW3TJoTv75yQ65vG5bWQB/oLy5fdK6HkW+bxvYAgHVgK2mAkrWFOUh9BHkm9q4dr+J
         1HCRe+Ej45FDpoI/sefcKKGUgvlV1JSg0092/7aWaQbU4tLdv6YjVwQpLekCxWK9Nh7Q
         fcV2sljSIrK5njcXAhNgQ1ZMF0PympZo4sd5xTpqfMpYvJU4aFthlyid9uT+2cOzO+SA
         RcZBN4kXsuYk7TdXlnBpEuRY9Z/M3ZeRJfioocULmsYdhuPkQxNlVWkMC8ZpTC0QzHgO
         aS2ctw30oT57REadH7//SfPjaANaWSFzk59xf80akaOyfjGzALYxkrgpBmVg1ISbwJNl
         +umA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680358002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wPDaCqdxNaWMMs3wQlLt6E3mfPbGjDIw/Hm+74bU44=;
        b=EP4OKrH0PgO9iJFnnKwPdsngDN93taC2NEV+PMLgIfcWYiZKa4FtQly1we5H+mm05w
         Nc0RvM0uFCJPi6M5s+SLSZYw+rgNIQRb5FwXDz+IU/bdb0MI2TMGpsSWowozzR5WopZ9
         eMj5pdZ4MPlh6iv9jgzCm4Re7R7k6k0lANLmab2FE/3jVlKGb0P5zE5IZKvoLCNs4Gzz
         zNnE0+Qipmm55h57FPsavATd/ZI/am0pS49WXgpm0/XZAITZqmIrR2HHXk0hm05mOdSg
         89Oa/Gi3l1utL8AIiNXhsq689QtTxTXP55QtU2Bhs3JNSxeVN7YGegRVQNf2uCKWGky3
         Aorg==
X-Gm-Message-State: AAQBX9fT/uyLjMgghTPDURPwuUfyV5S7a492JbvwG6KsqT0EdAvoutMr
        Z0Ors0hW1K9RuIfY+iXqPuRrTw==
X-Google-Smtp-Source: AKy350ZQ1/tJ4mGhUx5o70JfOu6p/yd+B/eNIRi1NomrtEBRPj0mD4MzyXimvi7YlHQL5AcPJtabFg==
X-Received: by 2002:a05:6902:1029:b0:b3e:dbf8:ba34 with SMTP id x9-20020a056902102900b00b3edbf8ba34mr31574597ybt.36.1680358002139;
        Sat, 01 Apr 2023 07:06:42 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id x8-20020a056902102800b00b7767ca746asm1239823ybt.7.2023.04.01.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 07:06:40 -0700 (PDT)
Date:   Sat, 1 Apr 2023 10:06:38 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: addac: stx104: Migrate to the regmap API
Message-ID: <ZCg6bhkxGKmkMloM@fedora>
References: <cover.1679867815.git.william.gray@linaro.org>
 <4ebc1b6b609a086846420954b893e914fd395384.1679867815.git.william.gray@linaro.org>
 <ZCGBIAvr7OQLwNXv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/yW4sqb6LeVhtg6s"
Content-Disposition: inline
In-Reply-To: <ZCGBIAvr7OQLwNXv@smile.fi.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/yW4sqb6LeVhtg6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 02:42:24PM +0300, Andy Shevchenko wrote:
> On Sun, Mar 26, 2023 at 06:05:57PM -0400, William Breathitt Gray wrote:
> > The regmap API supports IO port accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver.
>=20
> ...
>=20
> > +static const struct regmap_config aio_ctl_regmap_config =3D {
> > +	.name =3D "aio_ctl",
> > +	.reg_bits =3D 8,
> > +	.reg_stride =3D 1,
> > +	.reg_base =3D STX104_AIO_BASE,
> > +	.val_bits =3D 8,
> > +	.io_port =3D true,
> > +	.max_register =3D 0x11,
>=20
> Not sure if define would be better for this, so it will be grouped with
> register offset definitions. (Same for the other configs)

Actually, I'll remove this max_register line because it's superfluous
when we define both rd_table and wr_table.

However, I explain my reasoning for hardcoding the max_register value in
a response to the ebc-c384_wdt watchdog driver conversion [0]. To
summarize, it's not immediately obvious whether a FOO_REGISTER comes
before or after a BAR_REGISTER so someone reading the code would need to
verify the define; there are cases as well, such as GPIO drivers, where
the only the base register is defined but the max register would be an
extent from there; and finally, a reviewer would ultimately need to
check against the datasheet to verify that the max_register is actually
at the named defined register location, whereas it is far easier to
lookup the address range in the datasheet rather than named registers.
These things make hardcoding max_register to be not only clearer code to
read and verify but also less likely to be set to the wrong address.

[0] https://lore.kernel.org/all/ZAyY3VGlo4N4SLZQ@fedora/

> > +	.wr_table =3D &aio_ctl_wr_table,
> > +	.rd_table =3D &aio_ctl_rd_table,
> > +	.volatile_table =3D &aio_ctl_volatile_table,
> > +	.cache_type =3D REGCACHE_FLAT,
> > +};
>=20
> Do we need regmap lock?

I think the regmap lock is opt-out, so I don't think we need to set an
custom lock callback for the regmaps in this driver.

Jonathan, do read_raw() and write_raw() require explicit locking?

> > +		err =3D regmap_read(priv->aio_ctl_map, STX104_ADC_CONFIGURATION, &ad=
c_config);
> > +		if (err)
> > +			return err;
> > =20
> > -		*val =3D 1 << gain;
> > +		*val =3D 1 << u8_get_bits(adc_config, STX104_GAIN);
>=20
> Maybe not for this change, but why not BIT()?

This probably should have been BIT(gain) when it was originally
introduced. I'm avoiding it here just to keep this migration patch more
straight-forward to review; but perhaps I'll make this change afterall
in a v4 submission.

> >  	case IIO_CHAN_INFO_RAW:
> >  		if (chan->output) {
>=20
> You can decrease indentation by
>=20
> 		if (!chan->output)
> 			return -EINVAL;
>=20
> here.

Sure I can make this change as well in a v4.

William Breathitt Gray

--/yW4sqb6LeVhtg6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZCg6bgAKCRC1SFbKvhIj
K9ZyAQDUzIF5/JKTWriFyF4UIAK/m3LufltaEhYoY2e9UMm7HAEAjjbhh8T6QNrn
xZDGS5LJrKuhlUrkheaVBPHtp8N1sAs=
=814R
-----END PGP SIGNATURE-----

--/yW4sqb6LeVhtg6s--
