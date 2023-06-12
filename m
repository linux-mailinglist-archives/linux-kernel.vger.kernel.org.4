Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2882E72B51F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 03:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjFLBd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 21:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFLBdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 21:33:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA44BE41;
        Sun, 11 Jun 2023 18:33:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b3a9e5bf6aso8154895ad.3;
        Sun, 11 Jun 2023 18:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686533628; x=1689125628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pj8Psjqk7CgWPc+v//HZXxY7XZibLgT4Jrs268KptsY=;
        b=SeLKtZUDZuopbxgpwykl9UBZkOEpcVJhEVEBWYWAR708Ot8Nb5rgHOqDhiBxXXLc0h
         1gcQKsqbe7SCPY8eMEfbvZz1w8Twr7A4b6bLtbxdA4nnURORJb7I6SBThjrPKKQqAwTm
         BpTx9z5ITGmexslmFp++ui3mieLK6z0e9NGcsDxwP06L6rft1l9RWnXVp64ZrdgyHmDG
         aLcLyFTa7IBKOf/0W26/mr/g7vTxinAJQAjOsAQj5QAfcBsaY9cjU/U4roiycw9C6bul
         mCVVaZoBKwiu2q0GQaCXHQcH2VzHieOvYoPL+zi2taesHqX3aJinoGgYJG+Ttf07MhrU
         dnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686533628; x=1689125628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pj8Psjqk7CgWPc+v//HZXxY7XZibLgT4Jrs268KptsY=;
        b=Ile4MUJHHq0AXiTlZvCdcwZWj8ZndMJXyO4H8tRtLd0xCmwLpy/k5UccdAF1MKg/Mq
         cnopMydV3l4Kjbz7TQz968Bls6syO1gNTkuFwh1JQqyNxp+tiq3XETd+2iYbS9/WPvwS
         djZJB4j+zKSPPhb483ycye9Y0e6BxjgYAZawHabayVDiWrqwYXiRk2C+4I58SPXPDJiz
         hiNXKHgXE3fnpOZCsybCpVXQatRrqfci0R6Jwkhi/EdjaTZUgtgieAHZLdpJlxeERTnQ
         vCrTh2kxJmDvTmxQen5OGEtxZj07FIxfbHljOIHSdFoEmtYDuIq7IE3UN2Df7Ju4giFz
         leCA==
X-Gm-Message-State: AC+VfDxatS71yuIcALCciGH4unACq8SYO4X1ArYCoSEiIryDqKbVocHO
        M6ryGGN4m2e6ay4dI0Fg+inc8/KkuR0=
X-Google-Smtp-Source: ACHHUZ4NlhL/4lcVM5lAWw/oCFvSortwIYk1gB8R29RjN6q6E+VuMQT32+qlqhj9RaiJfcvFyDrmgg==
X-Received: by 2002:a17:902:c406:b0:1b0:48e9:cddd with SMTP id k6-20020a170902c40600b001b048e9cdddmr7194103plk.69.1686533628246;
        Sun, 11 Jun 2023 18:33:48 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id jm18-20020a17090304d200b001a1d553de0fsm6914241plb.271.2023.06.11.18.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 18:33:47 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C3CAD106B23; Mon, 12 Jun 2023 08:33:42 +0700 (WIB)
Date:   Mon, 12 Jun 2023 08:33:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: virt: correct location of haltpoll module
 params
Message-ID: <ZIZ19ghqt_dbEEQF@debian.me>
References: <20230610054302.6223-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pOsHwrdnPQXWfJ2n"
Content-Disposition: inline
In-Reply-To: <20230610054302.6223-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pOsHwrdnPQXWfJ2n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 10:43:02PM -0700, Randy Dunlap wrote:
> diff -- a/Documentation/virt/guest-halt-polling.rst b/Documentation/virt/=
guest-halt-polling.rst
> --- a/Documentation/virt/guest-halt-polling.rst
> +++ b/Documentation/virt/guest-halt-polling.rst
> @@ -72,7 +72,7 @@ high once achieves global guest_halt_pol
> =20
>  Default: Y
> =20
> -The module parameters can be set from the debugfs files in::
> +The module parameters can be set from the sysfs files in::
> =20
>  	/sys/module/haltpoll/parameters/
> =20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--pOsHwrdnPQXWfJ2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIZ17wAKCRD2uYlJVVFO
oxPUAP9Nd0IqK7CJvUjbdoPbvj+rByu59sIirlsDAgiPKeGd5QEAnIoxS7TiUYnw
Zrze6zXCLU/uktE2qFQbDojBhuk1JQE=
=/gTz
-----END PGP SIGNATURE-----

--pOsHwrdnPQXWfJ2n--
