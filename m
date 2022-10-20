Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECC7605624
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJTDyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJTDyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:54:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CBB29C92;
        Wed, 19 Oct 2022 20:54:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so1863807pjb.2;
        Wed, 19 Oct 2022 20:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cls9hPD2bbrQKC1wtXrkJF4y2UlILPEIkviM6fS1b4M=;
        b=opDupmmzU/oD8a1/HD/V48st6LXQIvxaLoJxuqnkFZaIAYnnxph8RJ5qGQCg5CfU2p
         P6yEivAwEpoMS6Omy3YHbgYnNPP90Z2WJu4+9cM4zSdPl/STf1y5qitqxogaqg3ZkVLr
         NUIpIjJTGxVNg2I0ufEztP2yjINBis1s+TaLtuHQLWgyKRSKJpmyHx09HHlWYP5OH+rT
         pZGARW/SnfgTvIquFWUaUw9/4I0gCOrOUdSPumsMVVHtX3IWIZhj0ju0hUForAxSX1NP
         4BeGtfcuB7qdEv7SRROIFDBc+Tgsp2Elk6RNB3+3bzYNzFLtmOS2snWNuP3gyJTJV5F7
         X2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cls9hPD2bbrQKC1wtXrkJF4y2UlILPEIkviM6fS1b4M=;
        b=T1AgHpre7vX8xh7Qq6ZR6ILvW64Jk11Jnx+E5rm/BID3wZ+gaH2LtIXYMwA1qCEJtG
         Qar8Z3ZD8hsJipHdkYp8CAWNExOWcU/7G6anqbkNVgAvtTPjKaeRhSm4aP6zzClH1EeS
         qYDEHlaeFe69G0fUOGdbj6m8okK13nBfimqaDQBfKMy8xCebRgUQbfBSjrKMQ0FIQK86
         BGdGRU/RHrQWai1/yQwA7adpYHLDqPZFNu/pKBEvgu8h+WnUdgSW5MG/+LiCAGSw7lVR
         h/rbDEHptqv5KbrN7XySeSZufIZCw/DXnZmgU5wY2mZgAZx6UndB0J44JmjWUWcC/pkG
         jFjQ==
X-Gm-Message-State: ACrzQf3JVNHoxRDDP+UJLP25q8pUAkkmMDMYmILoB5LaEU83M3pgdxlg
        VBlNQsf/DNVl5ryCQ49uLTQ=
X-Google-Smtp-Source: AMsMyM7C8fvckchyhYqiVeDNIPQxtK5440sc5fzIo9KHDa6ah0cFoiiDd/OYzTOAAozoOBHcUBLpdw==
X-Received: by 2002:a17:90a:930b:b0:20b:a5d:35d6 with SMTP id p11-20020a17090a930b00b0020b0a5d35d6mr48789899pjo.146.1666238084014;
        Wed, 19 Oct 2022 20:54:44 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-92.three.co.id. [180.214.233.92])
        by smtp.gmail.com with ESMTPSA id w14-20020a17090a5e0e00b0020ad53b5883sm722300pjf.14.2022.10.19.20.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 20:54:43 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 509B11032B1; Thu, 20 Oct 2022 10:54:39 +0700 (WIB)
Date:   Thu, 20 Oct 2022 10:54:38 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] serial: RS485 kerneldoc/documentation improvements
Message-ID: <Y1DGfq8mNI5dc8Hz@debian.me>
References: <20221019093343.9546-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g0j7Qa5xVl5Dx7IW"
Content-Disposition: inline
In-Reply-To: <20221019093343.9546-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g0j7Qa5xVl5Dx7IW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2022 at 12:33:38PM +0300, Ilpo J=C3=A4rvinen wrote:
> RS485 documentation improvements. While doing the kerneldoc conversion,
> a few other items came up so they're now included in this series.
>=20
> v5:
> - Make formatting of names more consistent
> - serial_rs485::flags bits are: -> The flag bits are:
>=20
> v4:
> - Remove wrong private: markers
> - Fix grammar problems
>=20
> v3:
> - More fixes to kernel doc formatting (thanks to Jiri)
> - Added a few other related improvements
>=20
> v2:
> - Include serial_rs485 into documentation
> - Add * to multi-line flag descriptions
>=20
> Ilpo J=C3=A4rvinen (5):
>   serial: Convert serial_rs485 to kernel doc
>   Documentation: rs485: Link reference properly
>   Documentation: rs485: Mention uart_get_rs485_mode()
>   Documentation: rs485: Fix struct referencing
>   Documentation: Make formatting consistent for rs485 docs
>=20
>  .../driver-api/serial/serial-rs485.rst        | 56 ++++++++++---------
>  include/uapi/linux/serial.h                   | 55 +++++++++++-------
>  2 files changed, 66 insertions(+), 45 deletions(-)
>=20

The doc LGTM, thanks.

For the series,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--g0j7Qa5xVl5Dx7IW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1DGdQAKCRD2uYlJVVFO
oyQtAP4pvAC4qMzXjOMlbzC8eFOqbfWjfJv2EMaZN2YpLeWp4AEA8Iz1+qEtNz6Y
3N7RWNuRZQZBsT1WkSK5QjKukLQW0AU=
=9D5b
-----END PGP SIGNATURE-----

--g0j7Qa5xVl5Dx7IW--
