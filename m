Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E8A6A0D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjBWP7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjBWP7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:59:44 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486BB18B26
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:59:43 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c19so886984qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6btNxmPTA9mFQHtoTcPKUI3lR43VlkT+xc7DS18jvNI=;
        b=GoOcq8BONrLPlKqCYRfk7T6PYpQQ4FwaeF3Nq4wWTWq4rpe5qyd6EXPxvJbFuYgAtW
         9U3h7hWcVyTyloSb+kPhtg1A49WcSlZmmG+KaE4ZDLD6dpMFT5yGULhKF2E4bv0BDyEz
         ZSjlLMdzPxCBU0iNA26btRn7+MxtFa3wPndwHJTUjrfjo/Q4IDpEyacUt0wXR7xhjJ0r
         HrUzbpQleJuchyEmPjYgls7014UwIFf/i6EUw4L91Edh4T5uPqSI4Re2z5DxjUU/eb1K
         rLJUGNir+Th4pMafvUwe5E9NJ3WzcQ3CtVmAwQC/IBKjZaZxg1caxSH5oZUdRb0S53+a
         3QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6btNxmPTA9mFQHtoTcPKUI3lR43VlkT+xc7DS18jvNI=;
        b=7XIXtom8t1SpXdaeyUTIimISEj2WO31erbGavSWek6MR27Wm6wupxp6ufm4AkrG5KH
         58NgNJW4QZ5UoIdMmNgnUqCmnSax+ezD8/TRhjmB29KtHrooc54RpgRMmGguRFHHCCqD
         lBRzzocNbIfeCOI5elFLHmuMfVemKvjDLwoV/+DkQtYLg8WcjfA/8weSn4jqfGlWLzZ5
         gJ1eu09Ntp4mBI3nyL59kxVpBWBi1pi5IMu70dq4zg7smaGSr++yg/f0BmVgJgScmVvK
         FwyK8FMP/H3RwASSvc+o/M/xffe4opzCSbHnv1rKDFCEP6Il9VNaBDv2GNXmoAC7R48r
         gw7g==
X-Gm-Message-State: AO0yUKUbpZYyUuHG5hsM+rgCbwEgbDMFq0aYXp/4NWhegHejujAa82Jh
        JQqpkMR8ZZSrMgxufXx18LNSqBsu2BnpsWmn
X-Google-Smtp-Source: AK7set8dEE6rVuQ7r5OUj0cZfYhECEQL9icEk2cth6CTRhdt3mKhJU7iPbbm0VokAbVDlhn7tITKrA==
X-Received: by 2002:a05:622a:170a:b0:3b8:6aff:9b58 with SMTP id h10-20020a05622a170a00b003b86aff9b58mr23466107qtk.35.1677167982344;
        Thu, 23 Feb 2023 07:59:42 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id o16-20020a374110000000b0074266529b50sm489651qka.94.2023.02.23.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:59:41 -0800 (PST)
Date:   Wed, 22 Feb 2023 11:43:28 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] regmap-irq: Place kernel doc of struct
 regmap_irq_chip in order
Message-ID: <Y/ZGMDI9wcOwMUWI@fedora>
References: <20230220153334.87049-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QZuyeSJ5jh8ff65q"
Content-Disposition: inline
In-Reply-To: <20230220153334.87049-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QZuyeSJ5jh8ff65q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2023 at 05:33:34PM +0200, Andy Shevchenko wrote:
> It seems that a couple of members got lost theirorder, put them back.

Looks like a typographical error here: "theirorder".

> Besides that, split field descriptions into groups in the same way
> as it's done in the structure definition.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: rebased on the latest Linux Next (Mark)
>  include/linux/regmap.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 4d10790adeb0..1c777566fb7d 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -1551,6 +1551,7 @@ struct regmap_irq_chip_data;
>   * @use_ack:     Use @ack register even if it is zero.
>   * @ack_invert:  Inverted ack register: cleared bits for ack.
>   * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupt=
s.
> + * @status_invert: Inverted status register: cleared bits are active int=
errupts.
>   * @wake_invert: Inverted wake register: cleared bits are wake enabled.
>   * @type_in_mask: Use the mask registers for controlling irq type. Use t=
his if
>   *		  the hardware provides separate bits for rising/falling edge
> @@ -1560,18 +1561,19 @@ struct regmap_irq_chip_data;
>   * @clear_on_unmask: For chips with interrupts cleared on read: read the=
 status
>   *                   registers before unmasking interrupts to clear any =
bits
>   *                   set when they were masked.
> + * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
>   * @not_fixed_stride: Used when chip peripherals are not laid out with f=
ixed
>   *		      stride. Must be used with sub_reg_offsets containing the
>   *		      offsets to each peripheral. Deprecated; the same thing
>   *		      can be accomplished with a @get_irq_reg callback, without
>   *		      the need for a @sub_reg_offsets table.
> - * @status_invert: Inverted status register: cleared bits are active int=
errupts.
> - * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
>   *
>   * @num_regs:    Number of registers in each control bank.
> + *
>   * @irqs:        Descriptors for individual IRQs.  Interrupt numbers are
>   *               assigned based on the index in the array of the interru=
pt.
>   * @num_irqs:    Number of descriptors.
> + *
>   * @num_type_reg:    Number of type registers. Deprecated, use config re=
gisters
>   *		     instead.
>   * @num_virt_regs:   Number of non-standard irq configuration registers.
> @@ -1579,6 +1581,7 @@ struct regmap_irq_chip_data;
>   *		     instead.
>   * @num_config_bases:	Number of config base registers.
>   * @num_config_regs:	Number of config registers for each config base reg=
ister.
> + *
>   * @handle_pre_irq:  Driver specific callback to handle interrupt from d=
evice
>   *		     before regmap_irq_handler process the interrupts.
>   * @handle_post_irq: Driver specific callback to handle interrupt from d=
evice
> @@ -1625,12 +1628,12 @@ struct regmap_irq_chip {
>  	unsigned int use_ack:1;
>  	unsigned int ack_invert:1;
>  	unsigned int clear_ack:1;
> +	unsigned int status_invert:1;
>  	unsigned int wake_invert:1;
> -	unsigned int runtime_pm:1;
>  	unsigned int type_in_mask:1;
>  	unsigned int clear_on_unmask:1;
> +	unsigned int runtime_pm:1;
>  	unsigned int not_fixed_stride:1;
> -	unsigned int status_invert:1;

These don't look alphabetical, so what is the order for these?

William Breathitt Gray

> =20
>  	int num_regs;
> =20
> --=20
> 2.39.1
>=20

--QZuyeSJ5jh8ff65q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY/ZGMAAKCRC1SFbKvhIj
K0RVAP4115MuM9UpsVt5YhzZLGrZqzO2wxd3tdW/Q8Ekq8kBlgEA/AL2+yMaYMjR
WkbDTKSY97gjSK5no7rDItNXiNbwjwo=
=mrgx
-----END PGP SIGNATURE-----

--QZuyeSJ5jh8ff65q--
