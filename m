Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7144F6AA307
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjCCVxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjCCVwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:52:30 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB96F493
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 13:47:47 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h19so4498505qtk.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 13:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677879984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9GyH6PvrYz76tQ69KklK9vAGMdL/HL5FMP81h6rev4=;
        b=TY98D/Vd9hutJ+rFgn75gJncB2EJqFyP1hW99JZyDZfQg54KEyaoB8vPI4UT5Jo5s8
         EGprKDLKdPJY4/APyFyPgULhMV9Ns3ao44WWmQYY/7Zq9FvhLEpyMmsCj8K2wekflwEn
         G3qWvzS6yJ8Ki7hphBmsLmaHYiFN7uss3cGJugqYvXhgTfOx7nCUOvfpBTkpqHTu+FPY
         ikVLxXei8KZKMQ6raUp61nuh38Z8vnGg3zVuXdSfkkAT1YxjHmJfug+6N38X08n3916m
         1u3lpfM+3gD/8m1PfHPAZmMGo0KjGHFTla8IocWdFOGrnkwYPBt7HuBmXcO9GaI2rkFv
         wGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677879984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9GyH6PvrYz76tQ69KklK9vAGMdL/HL5FMP81h6rev4=;
        b=jf8jcsVV0cZt2+hotzO7OUsGskRAVkpcBorRtjz8NnPXgVOylUjPZ9voiN9ZcwmyXC
         X0hNQcLV/vCvfMsnBYOD7Iwvg5qUE8NDxZAGCl4eW5XwM3wmoTKzY+F/YIwalV4Vv38y
         JaNf+zJCHOvKXf90+8nu51eck7VBWhQmKr2LKj7wI5gpC7/I2Ooqrje4jRzqp6gc4F0F
         rSwJiIjEPdImjmNM9Y4mWRtqtovpo3WAiIFvO7dWxbVb9DPl5C6iAvFhzc/vjYtoc2Zh
         3q+5h9uBFqaBZWugI9VnESafArcOzl6sYt+Ta9QpT4rkw5wbt/Aesma1vM1PdcnpwCx5
         uYlg==
X-Gm-Message-State: AO0yUKXTDSKECyqcx+8V5si5y98XlNlzTC+5dBL9zbPzkmnvEyXTMXyO
        huXHh2MrXcyvY3lDfPQoVg82Ac0ypvw=
X-Google-Smtp-Source: AK7set9xByrPNRa27PcYJ6fG5Mu7tMBwfd3+9u3GzkWHpU9ILZ+2rFEZ1V4nIB92gC4BsaoqGzmiTg==
X-Received: by 2002:ac8:5dd0:0:b0:3bf:b6ba:1c1f with SMTP id e16-20020ac85dd0000000b003bfb6ba1c1fmr5502695qtx.10.1677879984553;
        Fri, 03 Mar 2023 13:46:24 -0800 (PST)
Received: from mjollnir ([137.118.186.11])
        by smtp.gmail.com with ESMTPSA id b1-20020ac812c1000000b003bfa932525dsm2465361qtj.51.2023.03.03.13.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:46:23 -0800 (PST)
Date:   Fri, 3 Mar 2023 16:46:21 -0500
From:   Storm Dragon <stormdragon2976@gmail.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Message-ID: <ZAJqrfcfoM2eO5VL@mjollnir>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
 <Y/OacHw6nL/ZtrH3@hotmail.com>
 <00e5aee7-c7b3-4077-8c9f-4f28ec220567@t-8ch.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JAK3wBCOzlxuTE/K"
Content-Disposition: inline
In-Reply-To: <00e5aee7-c7b3-4077-8c9f-4f28ec220567@t-8ch.de>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JAK3wBCOzlxuTE/K
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 09:12:50PM +0000, Thomas Wei=C3=9Fschuh wrote:
>Sorry for the long delay, but this should be fixed in the current round
>of stable kernels. Can you try the following:
>
>pacman -U https://mirrors.edge.kernel.org/archlinux/testing/os/x86_64/linu=
x-6.2.2.arch1-1-x86_64.pkg.tar.zst
>
>Thomas

I have installed the package above. My screen reader is behaving much
better now. Interestingly, however, trying to cat the /dev/vcs device
still shows the following:

cat: /dev/vcs: No such device or address

cat: /dev/vcsa: No such device or address

cat: /dev/vcsa1: No such device or address

Is this expected behavior?=20

--JAK3wBCOzlxuTE/K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEjjImGMhZhYoKESBfW+ojcUPdwZMFAmQCaqoACgkQW+ojcUPd
wZPq5w//WeeUto0XS2zLGXUG6EUapeTDUUcHpP5Jf/qvS6FrLHCASETvY6kDKu7q
kRzlWGYAARjrdSWWKGShtx0aizojQE7DQyBTbTOdx+Zbos5LCrhzSe7FpKDgl5AC
HRj49VRKDB4kx8bYFw6XcuHiXTjZDUlqipOo1iRdThZtMlXZWs9lIwMx3tfcQN0k
XPQOFmW16V5zNqd3wwEPlAoH5rJO8lX1XJOs/GqavphDOzXhHaNwoFqZkT0ziq3D
493Qm1ZG47USuyJX/nn9Tlie0VI2sjnupKv8Hy+CBiLEwTxuWOwNJ5u/Ty21LY5X
gaaqgbAuk5ZZBn09VXkCdODfB2CmTjh1GkjVhLMHe+tkAY3RAGXFD0SIPl1qzDNv
9EoMH+KolCA+JnLlugtVg7+zNXLkFEpoBgiwU93X0hDa45UmMOWxkQeEObfzKnvF
9CRmLgPeV2zsSg3qD5f1wYspxToNT6m6V4GJd/pS505gCn2tbMfh1F3nc1w4iTfR
jKV5RbqThZKx1puwO6ae5Hi1G78z/JBjryd1i6aStzNQH6a0yTtT3a1HbL2oDElx
cCPwfTnAlSnwYDxMZy6mOZJ9eUby3EzTdSdxOAvL5hiixG7IqBAqiCVzxvhyr/Pr
+o591FJarLkbI6KU39Hpz3sf0WOfR158nj7mZ+e9UfYaUmcWDjU=
=IEr2
-----END PGP SIGNATURE-----

--JAK3wBCOzlxuTE/K--
