Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29576A12CC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBWW0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBWW0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:26:09 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650492CC5C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 14:26:06 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id w42so12693966qtc.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 14:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4aRkfuMxBc9ewMqWHFZPLHdqd85jaacaMcVFCbnmpOs=;
        b=fQeSMD7KDyMwJs1vAOT6bG7m39Oec0Z/MKgnAkA8MzMHGV0jQz6Z4mudK7FnLQr8nf
         jDjO5IawkkgwPvy901aWl3YSe0WOBOriP2Tfzkemo5COAW3ErdQdchZEPZBiV/V4d55r
         14BzHMB//LtxpcOm0uEXwZnwJWlCz7Vr1L9z5c40E0JeE/0JyPNz/iWXIK4k0Cz3a+q2
         lGYl+6bwZcPGpgB4v9JSQIJcML959i8CPawOx9m6pYDwCyrFCNJSJGPMGQZC+pYshgV0
         b4rQEiwcfUxKCAxdCUB3ceaUBbzUD4Xw+IGZPlXqK6XMTmyUYKIxt2qeJ+GH7rde8L75
         //QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aRkfuMxBc9ewMqWHFZPLHdqd85jaacaMcVFCbnmpOs=;
        b=Ag09kly4qRsyNM8uMHZlf1dRtvUB1x49gPul0Ux29ntN1IhjaqdRMG2+i1kJ+oqbmK
         gzHeNktlSzbe6H9/c2c7VI71X+1CJ3giDMW5vqL+kTryBVTq5RLqfkseed6RK8+X1ifn
         L0Yh1DC9MSwc2k6HUMosmy+O2JryZ2AWX+hXn5vdAOzilvGKbudMT2L30DBMUXZiUNS5
         1FKeCVIhXTAK4cwWFH9L5yLpCgxY8N/QKtufsW8QK/gZJCgHL+snQi6DUmLMfovbkmld
         SwbpFOrNQ8nHwG7b+VYVHKcLWjH6hJG1cSx5fpEQ1/9uL9+RVS8cd7JXvLPoIA8vUvYF
         CaHg==
X-Gm-Message-State: AO0yUKVfmt6XgBxuAEFC2E1hb0rOrKmgEy3vrB3uHSEt+oeMzTHO8KKN
        NS9GigXm7pTrvhwQq8OXf9Ecbg==
X-Google-Smtp-Source: AK7set8uiKG1MUzasi/n3VVtFnl+d7IKJzaEYN4Lvb/9+vqFbEIFGB7AM5nLVcqLT+g6wpjTA8vmwA==
X-Received: by 2002:a05:622a:2:b0:3b9:bf32:f8c8 with SMTP id x2-20020a05622a000200b003b9bf32f8c8mr26337378qtw.24.1677191165487;
        Thu, 23 Feb 2023 14:26:05 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id p62-20020a374241000000b007423cfb8d64sm3051493qka.65.2023.02.23.14.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 14:26:04 -0800 (PST)
Date:   Wed, 22 Feb 2023 12:46:05 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] regmap-irq: Place kernel doc of struct
 regmap_irq_chip in order
Message-ID: <Y/ZU3YWmC+/sN2iq@fedora>
References: <20230220153334.87049-1-andriy.shevchenko@linux.intel.com>
 <Y/ZGMDI9wcOwMUWI@fedora>
 <Y/e19Oqf1XwDo/aw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B4wdNZTGTtOtgH+c"
Content-Disposition: inline
In-Reply-To: <Y/e19Oqf1XwDo/aw@smile.fi.intel.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B4wdNZTGTtOtgH+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2023 at 08:52:36PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 22, 2023 at 11:43:28AM -0500, William Breathitt Gray wrote:
> > On Mon, Feb 20, 2023 at 05:33:34PM +0200, Andy Shevchenko wrote:
> > >  	unsigned int use_ack:1;
> > >  	unsigned int ack_invert:1;
> > >  	unsigned int clear_ack:1;
> > > +	unsigned int status_invert:1;
> > >  	unsigned int wake_invert:1;
> > > -	unsigned int runtime_pm:1;
> > >  	unsigned int type_in_mask:1;
> > >  	unsigned int clear_on_unmask:1;
> > > +	unsigned int runtime_pm:1;
> > >  	unsigned int not_fixed_stride:1;
> > > -	unsigned int status_invert:1;
> >=20
> > These don't look alphabetical, so what is the order for these?
>=20
> Nope, the order is to follow:
> a) kernel doc
> b) semantics of each of the groups
>=20
> Do you think the order can be improved? Can you point out how?

No, I don't have any particular improvement suggestions, I'm just want
to understand the current order for when I introduce something new here
(e.g. no_status). If I understand correctly, status_invert was moved up
to be with the other "*_invert" flags, but why was runtime_pm moved
to above not_fixed_stride rather than below it?

William Breathitt Gray

--B4wdNZTGTtOtgH+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY/ZU3QAKCRC1SFbKvhIj
K7S+AP44DVvucOXGUFtN8DDP1Fk6qjpB4a/mhR1bOt+h19e5dAD/clB1T8bAdLU0
79BpL6nEZOpPg5kwlsDU5s5soK8Gawg=
=Q276
-----END PGP SIGNATURE-----

--B4wdNZTGTtOtgH+c--
