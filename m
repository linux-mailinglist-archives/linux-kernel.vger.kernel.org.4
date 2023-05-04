Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DA46F68D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjEDKII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEDKIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:08:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02EE49C6;
        Thu,  4 May 2023 03:08:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aafa03f541so2351445ad.0;
        Thu, 04 May 2023 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683194883; x=1685786883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EvC0i2ubAm+sy441fyjK/wvLan+Q24d8vT0SBFBHw8=;
        b=sQQ34i4f0ZsdWrR7buWlwZEDegKaGTeUqv6DiRctqwB195ofWFFa2PEl+Zm7Q1wMlr
         J6Hoka5NxO6u6G+8vZnSn3hAuGRgdQS9d39xLZtCCaXHQedSS3MCvZvXuRgXIhTyQZXp
         qraR8TT3IpUatauHej8OdzdHXrlsKpP3GsPYobE3YsXha1oJJct25a4Cm7rceK44YOzX
         GFa9EiGqdWE3mcLJ9vU/GX4zQddl7rjBY/IKovF0YGW0S0rmfoPr7QVWit9RRjYRBV9H
         b5uKvOsLkZEi/Pjkro3WN2S8T1m6B/FHGZxgcTc6IXUBdvVPx3J24FFgHCm693aKYAmy
         +kOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683194883; x=1685786883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EvC0i2ubAm+sy441fyjK/wvLan+Q24d8vT0SBFBHw8=;
        b=ORA8bs82bg5siYgy6rk23r2pJExuBLpcZ2xtDzk25h/xWZXzGE7gXqVZ6YRqV1R1sQ
         hz8n1vnQ7/WbNLkhrA0V6xp+pBCltdik+r0BO52i5Yujz6Nq48xYGPlpmKAPcz0LJEjV
         GWId/mIMuQQz6zaVETsnVqWXrylyOZfRUAxsJXFCFZatTWNZ2TqWbA9yrY7jur0HLByR
         Sci0S4EYLqfQfn6lTc68t4sogBzVjNsQVcKAqktPxUSE4U0L0UMaIgD1Sz8Ce0I558J0
         81HBcXmw4avnLdWaPmQ1NlDV7KmvHTQpAYmYSFXWmFBiLDJF9P/EuLXwYOiTj0KT3p1w
         Nn7A==
X-Gm-Message-State: AC+VfDz+OtIBiUDFBGjSZFAEmGSoZYLi2zLO86GnfGaiM4ZGtxMp+F+8
        aeHSiXpe8TIkRPFoh3Tqjck=
X-Google-Smtp-Source: ACHHUZ5ZqDIKpKUsZVpo2OZogmebe0h5XLPpAAUxCzK8FOBRhjpARLbB3sfGP8Nj1NSLPCuPN9ojSQ==
X-Received: by 2002:a17:903:2341:b0:1ab:289f:65cf with SMTP id c1-20020a170903234100b001ab289f65cfmr4082515plh.54.1683194883120;
        Thu, 04 May 2023 03:08:03 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b001aae1eefc8dsm8752453plr.109.2023.05.04.03.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 03:08:02 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 91F2E106262; Thu,  4 May 2023 17:07:59 +0700 (WIB)
Date:   Thu, 4 May 2023 17:07:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Wang Honghui <honghui.wang@ucas.com.cn>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dc395x@twibble.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strcuture: Correct spelling mistakes in comments
Message-ID: <ZFOD/6rT36evHXNz@debian.me>
References: <262EBDA8BEEA7619+ZFN1b1D66/Lp8hzh@TP-P15V>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rm9y031/RW5E+/n9"
Content-Disposition: inline
In-Reply-To: <262EBDA8BEEA7619+ZFN1b1D66/Lp8hzh@TP-P15V>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rm9y031/RW5E+/n9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 05:05:51PM +0800, Wang Honghui wrote:
> Subject: [PATCH] strcuture: Correct spelling mistakes in comments

The patch subject should have been "scsi: dc395x: Correct 'structures'
spelling mistakes". For the description, though, I'd like to write
as 'As title', since the subject is self-explanatory.

Care to reroll?

>=20
> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
> ---
>  drivers/scsi/dc395x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
> index c8e86f8a631e..a3f00e6e3296 100644
> --- a/drivers/scsi/dc395x.c
> +++ b/drivers/scsi/dc395x.c
> @@ -3641,7 +3641,7 @@ static void adapter_add_device(struct AdapterCtlBlk=
 *acb,
>   * adapter_remove_device - Removes the device instance from the adaptor
>   * instance. The device instance is not check in any way or freed by thi=
s.=20
>   * The caller is expected to take care of that. This will simply remove =
the
> - * device from the adapters data strcutures.
> + * device from the adapters data structures.
>   *
>   * @acb: The adapter device to be updated
>   * @dcb: A device that has previously been added to the adapter.
> @@ -3980,7 +3980,7 @@ static void trms1040_read_all(struct NvRamType *eep=
rom, unsigned long io_port)
>   * Checks the checksum and if it's not correct it uses a set of default
>   * values.
>   *
> - * @eeprom:	caller allocated strcuture to read the eeprom data into
> + * @eeprom:	caller allocated structure to read the eeprom data into
>   * @io_port:	io port to read from
>   **/
>  static void check_eeprom(struct NvRamType *eeprom, unsigned long io_port)
> @@ -4578,7 +4578,7 @@ static void banner_display(void)
>   * dc395x_init_one - Initialise a single instance of the adapter.
>   *
>   * The PCI layer will call this once for each instance of the adapter
> - * that it finds in the system. The pci_dev strcuture indicates which
> + * that it finds in the system. The pci_dev structure indicates which
>   * instance we are being called from.
>   *=20
>   * @dev: The PCI device to initialize.

The diff LGTM, thanks!

For the diff only,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--rm9y031/RW5E+/n9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFOD+wAKCRD2uYlJVVFO
o3C2AP9Ls79SA755CeuI452Xk0CDmTjqKp1PmRcH71vHUOa3hwD/Swz2AG6FlUMn
/c9zWW28M+kUiv7Yp7ln7YQ7olQjowQ=
=43qK
-----END PGP SIGNATURE-----

--rm9y031/RW5E+/n9--
