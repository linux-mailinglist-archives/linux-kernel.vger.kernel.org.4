Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A15F32C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJCPkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJCPkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:40:46 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9EB248CA;
        Mon,  3 Oct 2022 08:40:43 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a10so12283316ljq.0;
        Mon, 03 Oct 2022 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7azzMhvCWlbBUnWsIL8gKYMDz75tdp+9lfOKf1YegqY=;
        b=BCoE7qaaF8gcAkgXdo9llnjy+CplurWz+WJ7fEq3i6ncsmjpIVX8dJIqvRgX/K3UIm
         AXTpr2IUBmDKd0kJfVKnLjEJyF6KbR4IUFKhpENUPlBc3R2NIv1+2g76Dma0v8lef6oQ
         vaT5tyKuhkAErqRxXuyh0qgcj3OPM0Nz429/oOJhu9F3aE73pDXhDQzE8bR/58Lu3Bhv
         dlQLClfNXrPnL1dV0Lptd1tYbQVsyBGafcmof+4W1yCsSFCsTJGI4sRxezZnHq0W3H95
         MlxmUQZ2o97WF+Aa1KnuryvplzmTPIjeb5FEz7vMj6TuQQ9wTcJsiOIbmk3WIQ+7Vele
         nGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7azzMhvCWlbBUnWsIL8gKYMDz75tdp+9lfOKf1YegqY=;
        b=hUDji2tO8BjFZ+AXckx1QXiftwVIGgj0hC8vOuSTfsNH1YvkMCo8nrG9G/yhJOLwbt
         uFO7Dy9CYu+eGIaTVOVehFl6TABQC8ciP48HVsXX4h2ZHIakYEghbcAjXw6YBvcweoYG
         lTomqDYwiRH0YJ2sb+D5/efrXtwrLOirVMTf31dLStf2LHV+Ey2E+KG5b8Vr6r06h+vb
         j0TSvev+QF2EwnitRd2elajmTjy7EgSa8avSLEtYkI0N3y5KjimvbFsaEt/4t+i9nv9k
         jtMoeUEw5OKFUaUHJWGx+Ypno44WJ4yHExam1jEwfP31zrIrsAl7sHnjo224j1tW8cmS
         IV5Q==
X-Gm-Message-State: ACrzQf3Av6kRIbxIaIl622ioPTsbQg8gTkrODqXul0f5EqlpF2GLv7rU
        YjE4EKKlTDcHj1mu3yDBjCU=
X-Google-Smtp-Source: AMsMyM59dfGDUkV2+ocD6JuR7+SaBlHxhfiHOrUacInEY6KjeVKJMUzjQ6QCGi/cOKeT159XKvRmCg==
X-Received: by 2002:a2e:924e:0:b0:26c:5dbc:2d80 with SMTP id v14-20020a2e924e000000b0026c5dbc2d80mr7158689ljg.290.1664811642111;
        Mon, 03 Oct 2022 08:40:42 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id x20-20020a2e9c94000000b00261ca0f940esm889238lji.62.2022.10.03.08.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:40:41 -0700 (PDT)
Date:   Mon, 3 Oct 2022 17:40:39 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: alps: Simplify the .remove function
Message-ID: <YzsCdyPxrNcHE3XF@gmail.com>
References: <33cf94ec234b88ffc79eb4496c640093aa8c5e70.1664721476.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pXKocOg+64y1zuMP"
Content-Disposition: inline
In-Reply-To: <33cf94ec234b88ffc79eb4496c640093aa8c5e70.1664721476.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pXKocOg+64y1zuMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christophe!

On Sun, Oct 02, 2022 at 04:38:26PM +0200, Christophe JAILLET wrote:
> If the .remove function of a 'hid_driver' is NULL, the default behavior is
> to call hid_hw_stop().
>=20
> So alps_remove() can be removed here, it is just hand-writing what
> already exists.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---


There is already a patch out there :-)

https://lore.kernel.org/all/20220915123438.520775-1-marcus.folkesson@gmail.=
com/

Best regards,
Marcus Folkesson

--pXKocOg+64y1zuMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmM7AnIACgkQiIBOb1ld
UjIH0g//Z+V4vf54jymsYpa+FtywfIyaRAaBXn4lJkD9THAzS8MgtwRlRqdkuZWz
NdqRPwqeBuoOwjh0iOfwFyesw7JFqeVpNKi91R1hP03v+1hS3e2kM7o9exvP0YQX
Kp1vnPnMBkB/LC6lUFpjIeZ3OLI5tY99nqxKeNY3TLbPylQUFYtQav9/ajhippky
5uN1MpAQcs7B6OKKp+GB2n0BfaRI1xKe9AlF1BoIhYTA7j59E/FJ74SQQYih5qLx
LA9U6iZ4Euj2FEq0BT5vYGjkRwnJkxCqoZMccsQXm21rQZSik2lwRUynK+D+Enec
aqKIsuZoIpA6dZqv0gkQ+fwv8OqE+A7/A8/1Y00WMAB3CHW1uMYBd28I+HWgQsRj
I7BBfxTk50v2q07SGH0bclApRIQFlAWPjb/VQPAS0qhdgkNXJufAPgoEm1Io1Esx
aC6L2gMQWizc2xlco9k1sXC/rSyBs8g2HVsgoU3yLo03GJaWgtGZC8QjsYh+yFiB
RZVdsHuVYEK5l7ZW9SxVgBmEFWeGPRE3cl1JUyOUHnvFU91Asii0B7L9gbxaAx7o
T9oDsWZKR9eOL+ufy3omcFtcjMabKI1Jhj7Qdm5+AfeVirTkFWZVHj2XKvDtChUA
T3n2+GC+/J8w5RWRX7qreQc5f7NKJwTM+Y+gcljtOJFRiPX2KDs=
=9TRx
-----END PGP SIGNATURE-----

--pXKocOg+64y1zuMP--
