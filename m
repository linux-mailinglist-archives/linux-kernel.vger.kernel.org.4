Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6936750850
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjGLMbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLMbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:31:49 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313BD9B;
        Wed, 12 Jul 2023 05:31:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so111057291fa.1;
        Wed, 12 Jul 2023 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689165106; x=1691757106;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLDCsqk2xRlIsL3XZA81rY+sf128Ic9tOGsPN+MZbKY=;
        b=dllFv4HwAWOD/P+j7J7tusv3hAu7LfIkPcDFewOYEa6a9qqo2a3oc4rirJDPcqlebU
         Nqyi0CNbw3c3bEE9Vr+NoTt7a5U4mXKVwZBNy6yRkLhF6rz0DX1mYs0psP1Fd7cS/mrm
         ZAD9ss4CB0RrK/jGZm/rvWjAXwt457bdDI/Z1cD3Zs3zZYu/DDV218CiowRTIVyNYbKB
         X40VpuXt1fk5d9UF3DHkO01B1XEHJOuXyyjbIUmsTJ9EQeNcr0SCWF+W/d3H2OqYR+HY
         o5Hq1Ao4EZ+ccIx+/10voscbHKsl4qEF+QlLveyBFM/xh4HjVsGno7YhU0IH3UH00JLm
         soQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689165106; x=1691757106;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLDCsqk2xRlIsL3XZA81rY+sf128Ic9tOGsPN+MZbKY=;
        b=X3C3gxxlCJpJYSFPmg9hdkv89lLlbSt/4jD5RZWmuHyuT7hPDKyV6vNHrIj5BbAY3i
         fSB2aBovg42xJwZS7xsWPstuh3b+leb07t82P0rtRbOZP9O63jQ9l/OV7+JFVDvYBBHo
         nwzTcLuwNSQlqNyCa1BRlHLWCTpiWGArSO3VK5MPF88Y4hQWux4DODdK/fcvnSG+A6Rl
         hkr3IP42N6UJiPEkMc7bI3jX2jK9EQ17bsP5D04yjks4BcBRuKrPNPA4du8qj+3xO3lM
         QfZdQA7GvMHFrhU2ba1ukb2ald+Qy3JkAlA8pVBf1zYFIumFxxZ6rJIHRJzUQStt8fP1
         G07g==
X-Gm-Message-State: ABy/qLaQGHWM+yG3Bz0oaMFEaMWrEuIW3MObplaYEedQYf4te/xzuqUV
        31blRzvSqXfYB9Em/qlCzz0=
X-Google-Smtp-Source: APBJJlEb5Mh5GoAwyBlCw7ptWeVUfKQXfYn0EW38Ka9/7hnTYl51PRRTAk2lmNhgIlPs2/q21M7KRQ==
X-Received: by 2002:a2e:9a8e:0:b0:2b6:c61c:745b with SMTP id p14-20020a2e9a8e000000b002b6c61c745bmr15930028lji.3.1689165106007;
        Wed, 12 Jul 2023 05:31:46 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906261a00b00992f8110a2bsm2526819ejc.150.2023.07.12.05.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 05:31:45 -0700 (PDT)
Date:   Wed, 12 Jul 2023 14:31:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, claudiu.beznea@microchip.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: atmel: Enable clk when pwm already enabled in
 bootloader
Message-ID: <ZK6dL84DsQDhsFWl@orome>
References: <20230711200905.6464-1-aarongt.shen@gmail.com>
 <20230711203017.cdfe2nrjx7lt25tm@pengutronix.de>
 <90830c22-0437-591e-cee0-67b16214bc55@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eFQATVRlcI61GrFj"
Content-Disposition: inline
In-Reply-To: <90830c22-0437-591e-cee0-67b16214bc55@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eFQATVRlcI61GrFj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 09:45:08AM +0800, Guiting Shen wrote:
> On Wed, Jul 12, 2023 at 04:30:17AM GMT+8, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > On Wed, Jul 12, 2023 at 04:09:05AM +0800, Guiting Shen wrote:
> >> +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pw=
m)
> >> +{
> >> +	unsigned int i;
> >> +	int err;
> >> +	u32 sr;
> >> +
> >> +	sr =3D atmel_pwm_readl(atmel_pwm, PWM_SR);
> >> +	if (!sr)
> >> +		return 0;
> >> +
> >> +	for (i =3D 0; i < atmel_pwm->chip.npwm; i++) {
> >> +		if (!(sr & (1 << i)))
> >> +			continue;
> >> +
> >> +		err =3D clk_enable(atmel_pwm->clk);
> >> +		if (err) {
> >> +			dev_err(atmel_pwm->chip.dev,
> >> +				"failed to enable clock: %pe\n", ERR_PTR(err));
> >=20
> > Here you leak possibly a few enables. While it's not likely that the
> > (say) third enable goes wrong, it's also not that hard to handle?!
>=20
> The driver used the enable_count member of struct clk_core to count the
> PWM channels(4 channels). It will enable hardware clock only when one of
> the PWM channels becomed on from all PWM channels off which maybe return
> error. And in second/third/fourth times to clk_enable(), it just
> increased the enable_count of struct clk_core which would never return
> error.
>=20
> It maybe confused at first time to view the code.
> Do it need to add something like that: ?
>=20
> for (i =3D 0; i < atmel_pwm->chip.npwm; i++) {
> 	if (!(sr & (1 << i)))
> 		continue;
>=20
> 	err =3D clk_enable(atmel_pwm->clk);
> 	if (err) {
> 		dev_err(atmel_pwm->chip.dev,
> 			"failed to enable clock: %pe\n", ERR_PTR(err));
>=20
> 		for (i =3D 0; i < cnt; i++)
> 			clk_disable(atmel_pwm->clk);
> 		return err;
> 	}
> 	cnt++;

You can also achieve this by decrementing i back to zero, that way you
avoid the additional variable and you get a more natural unwinding of
what you did before.

So something like:

	while (i--)
		clk_disable(atmel_pwm->clk);

should do the same thing.

Thierry

--eFQATVRlcI61GrFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSunS8ACgkQ3SOs138+
s6E41RAAovk3sb2LqH5DqsSa6g5cHTX0O0rUtwg6WYnUd/4aa6/pk17jxeGQ3Yqu
DTB+i0g2WT5DzdL6kWo4fDiKgbujIL90zOunkq0JarZ/E+f7n6TrN3RM4hzcSIPs
n/ad6mfv9/mx/iGvF/Xdt1Ujr8jMcQTyv2/5Ok6b+t6VML5RLpOhatKCaijznK2G
YIiXb8U+h6cVP27TLpdb3BOqb9eCWkXKMX2nkvkS5ugsctqufkg+r5rjzO8Q/PFw
rnXTyTuntaXrqaWYrN91SP8aZwtYMgb/7avt2/BDWjLEam8d8lP31q41B8sQuPCn
PBDSWpAD4LI/S/CP+8AyvAKRBkK9UlIW2Qcna28jmRTjdHsypf5B+SIejYwJQbg3
uZFsWf0M0bvRBTzPYIeDXzuGBqe5X9qgq5VztZ3MmMG6GsY6E5Nkiv8yb16fg/aV
IUSSMVdPXP7IK3JosFMMdrrZLm3SMYhJDHN3D1xYL2ICYXuwfLYdQ9SB/diLlMRW
Pn+BBQ+KlVLpooxbAS78kKfF27/hRykVEUNsO7ZUy9V/Pq4tPoPfDdSOo/m6oPzT
fmtHRdHyMX1eHIvi/xM0wzJYZTED0I+rbAVZ9xgtrVO/0icpZE54p9XLzuqiNs/a
SVfwWqCc/PWWicB3sjQ7/iEz6tVdY9hvJ65vES2FTJamznAteH8=
=Bllm
-----END PGP SIGNATURE-----

--eFQATVRlcI61GrFj--
