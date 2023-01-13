Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63E1668975
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 03:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjAMCPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 21:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjAMCPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:15:20 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569FD5D699;
        Thu, 12 Jan 2023 18:15:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y1so22065109plb.2;
        Thu, 12 Jan 2023 18:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5i8kh9iMSXItZ0ToIdeEyrTAkIgZbNNjuV1Ce/CfBhQ=;
        b=MT0zNAKFBJ5Tzsy9wY3rVEVY9ARPLo7MZnvEhdlQ/QOv75A/FaFZH7Qs+NMk6OVTLt
         oVX4gcg1nxFfmvfy+KZrIVv1KSSq0jm9cAekfybqF5ZDt3EgKzar3Fky3rKOArQxffwO
         O9UkWSpifyPFYt3gq0KtuvJb1dTP3y1356RPCAbxwVzRt8iZW+ZblJFhQ5iF7rsGxmXU
         7fRozPMzvwoYgBAHI++4aJSiCJGLgqJ5j5uOAbWo15sRn8qSWXG2WYRwp37h8E5ow9yS
         Nk4XCIBs/OsE72inA424H4YICeVWmmYo0BXFdzSkQICl2cpgALe1656XdmSpHIkmNxe0
         18xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i8kh9iMSXItZ0ToIdeEyrTAkIgZbNNjuV1Ce/CfBhQ=;
        b=S2BesIZdKTgjPeBQ3PSbRnSb7WulHC5tBpG9TskNnhQB7p48OvkiMbvCzdvwNQ0Kiv
         bSru6e9PaseQvqDdieFxc9Q8G+mJm4dcwkeeAZifve6fCnwr0tPVmKOfJ0xkGb95sfU5
         qVCha8CIwdgmGWUAxBEvkPgVw+3FUUgrVdFTC9p9VbXHjgYaaVmyluaTlwZoGLD6fOY7
         KdW1JLVnyuoBj834batI5GXkoTfzBKfeBtGP3LseqGyzeFp7znP9kV8e2c56JYKavOdS
         LGbO8oCLp3YCKhARsJyox63N9ByL6b5mzi90Hjr+7Fw0Ov1ryv4bttGDHeuAGuDh4hjr
         ktmQ==
X-Gm-Message-State: AFqh2koekj+b5D04r9Jqe/CH6nGFXVFwn6oou6YUeGmF1+MFoPgqh+9Q
        90M/E/Ayg5Tcx8Y3HVO7p4U=
X-Google-Smtp-Source: AMrXdXtQZYiMTxpAp5qxjjEiBzga8+rxL6O8VRx1GIiQ/3NhcZAAoYqv+ZcVql3koILMc1nk0a1gOA==
X-Received: by 2002:a17:90b:24d:b0:227:248e:35ef with SMTP id fz13-20020a17090b024d00b00227248e35efmr8749095pjb.44.1673576118809;
        Thu, 12 Jan 2023 18:15:18 -0800 (PST)
Received: from debian.me (subs28-116-206-12-35.three.co.id. [116.206.12.35])
        by smtp.gmail.com with ESMTPSA id js8-20020a17090b148800b002191e769546sm11472322pjb.4.2023.01.12.18.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 18:15:17 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 1C8A7104054; Fri, 13 Jan 2023 09:15:13 +0700 (WIB)
Date:   Fri, 13 Jan 2023 09:15:13 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Niyas Sait <niyas.sait@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: Proofreading and updating the
 documentation accordingly
Message-ID: <Y8C+sYKKQNbeU++T@debian.me>
References: <20230109205456.30618-1-andriy.shevchenko@linux.intel.com>
 <Y70sHNqLVvx6UF41@debian.me>
 <Y7/zDAhyuoJrMfiU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NJwJLtRdcvc05lPQ"
Content-Disposition: inline
In-Reply-To: <Y7/zDAhyuoJrMfiU@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NJwJLtRdcvc05lPQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2023 at 01:46:20PM +0200, Andy Shevchenko wrote:
> Thank you for your input, can I add it as a separate change on top of min=
e? I would like to keep
> my stuff separate from the more intrusive changes (scope is mostly on the=
 examples and function
> references). If yes, can you provide your SoB tag?
>=20

Yes, please do.

And for the trailers:

Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--NJwJLtRdcvc05lPQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8C+rAAKCRD2uYlJVVFO
o4dtAP9ZBDVBb83TLxog3sCiYyOounvg4A6sB9puIP6x31l75AD+LhkZn1xfCHai
smdKTVVT2UQycwOWu2271FKocz9AYQ0=
=OfiS
-----END PGP SIGNATURE-----

--NJwJLtRdcvc05lPQ--
