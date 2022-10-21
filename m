Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389E96077E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJUNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiJUNKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:10:05 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64E1BC61B;
        Fri, 21 Oct 2022 06:09:51 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C67351C09D6; Fri, 21 Oct 2022 15:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1666357725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tA4VVF/5mJdTqrprHndtKRiYsUiXim9pA/NSbFuYx+w=;
        b=UuklZPUvRWZRTiez/dBmhtGqXT8KwjCD7Mc5OZc/qB0w/+fN4qkswgBc0GWoKHYL33BE46
        y8nXBwhA7NbUJbKK69rEjTNZdW+LRh8u0jWlFvuD4B1yNIJpVYJGT2PPydNzCDa7iLTxUg
        XuS6TFsCse5ifAaLk9Lbg1ioJIUpFXI=
Date:   Fri, 21 Oct 2022 15:08:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] leds-pca955x: Remove the unused function
 pca95xx_num_led_regs()
Message-ID: <20221021130845.GA16264@duo.ucw.cz>
References: <20221017081053.52388-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20221017081053.52388-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The function pca95xx_num_led_regs() is defined in the leds-pca955x.c
> file, but not called elsewhere, so delete this unused function.
>=20
> drivers/leds/leds-pca955x.c:149:19: warning: unused function 'pca95xx_num=
_led_regs'.

Thank you, applied.

Best regards,
									Pavel


> +++ b/drivers/leds/leds-pca955x.c
> @@ -145,12 +145,6 @@ static inline int pca95xx_num_input_regs(int bits)
>  	return (bits + 7) / 8;
>  }
> =20
> -/* 4 bits per LED selector register */
> -static inline int pca95xx_num_led_regs(int bits)
> -{
> -	return (bits + 3)  / 4;
> -}
> -
>  /*
>   * Return an LED selector register value based on an existing one, with
>   * the appropriate 2-bit state value set for the given LED number (0-3).

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1KZ3QAKCRAw5/Bqldv6
8nMaAJ43HmLO4zeFHwMAiePUeNJgL3pThgCdFbbgxqTMLO9ylnTp4j8ny+YOHks=
=1LkM
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
