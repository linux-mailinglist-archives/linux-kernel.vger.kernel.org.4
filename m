Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABCD70C33A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjEVQZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEVQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:25:29 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435D2BF;
        Mon, 22 May 2023 09:25:28 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2af2958db45so37436271fa.1;
        Mon, 22 May 2023 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684772726; x=1687364726;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80B43K+HMb959gXBqRZ/OvFr8ljOQgNH2EwC06xQffw=;
        b=S0z5xMiYZQ1r1qqhYm54ud7ihqF3nrCt0+MiobBZMlJt0/LNbV3fdxl4pzBvu75fwg
         t5RmqWSkda3swzGhpFlUOdW899BOCoimsNjDSa99SfPzX3+1NuiovKXSqyWKS4uk2Vvu
         VKWaLZ+ZX+GABhjXWodWRM0wtao0j8ip6O4YwCR2MzyAJmC+8w4Q5DCiyZExyHZf3rgW
         maOjGJg3B6pVhB18Wlt7BBI8rE3aai7WICSgDjkEOm17UmxXSIZMXfShDk5z9TQoDflY
         dxQMd4DMKQTMPEoPwE95DaX9nSwa7gOJqhYcw3NJ95aXr9ASgaPlVK0T4HkETP2hlxgB
         tNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684772726; x=1687364726;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80B43K+HMb959gXBqRZ/OvFr8ljOQgNH2EwC06xQffw=;
        b=DcCPuU/humBxqhvs9RH+yMmc8C+NNVeFB3YDxSmjzrCnTlfzGR09TBdOjnGHsScqft
         QorIvV+2cJfSTbaqS8IhgxqYq5XoVWikWDSKoqIpPPVzsJt3lkYjnDD3LpLEPdlUIbjf
         f1/iMsqoZmUbop2em1KEucKNEhYw5FFBZ5e1xYdw41RffCwUUbjM8GC2Qsx3cth8RWU+
         nO1cF9c4KuFqVRPU/kJ/N9dJNH3OS+7D7quICSavzrhNkJm857UYVw3PvMTQbDqNfH9O
         4+sM/qd3YThVZAMOI8OhllXkY2v1sWQZGpxIYnmdWGiz9Frv444MLTr1Em4H+hemTglO
         Js9g==
X-Gm-Message-State: AC+VfDxMAhHK7Rej+GrD2YOJMQnXbpLQ4nNVHbK+vhjyPpKh92+KXXNt
        wpe29hQMwK89qrr7eusFMr90sHEMjeU=
X-Google-Smtp-Source: ACHHUZ4iSGMCko/aWVRiQgaIE6rrPkjvzy0duNZBzpqg0YkdhYElPY8CIFv/dI6T3kMmnxCT/xppag==
X-Received: by 2002:a2e:9c06:0:b0:2ad:ae71:4f21 with SMTP id s6-20020a2e9c06000000b002adae714f21mr4080510lji.48.1684772726141;
        Mon, 22 May 2023 09:25:26 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b9-20020a2e9889000000b002ad8fc8dda6sm1203576ljj.17.2023.05.22.09.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:25:25 -0700 (PDT)
Date:   Mon, 22 May 2023 18:25:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: PWM regression causing failures with the pwm-atmel driver
Message-ID: <ZGuXc13mRhqDAVu_@orome>
References: <7e2cfb55-e39f-2e5c-7f43-e1d275428bb5@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yQ4FAPurPO6iFeq7"
Content-Disposition: inline
In-Reply-To: <7e2cfb55-e39f-2e5c-7f43-e1d275428bb5@axentia.se>
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


--yQ4FAPurPO6iFeq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 05:19:43PM +0200, Peter Rosin wrote:
> Hi!
>=20
> I have a device with a "sound card" that has an amplifier that needs
> an extra boost when high amplification is requested. This extra
> boost is controlled with a pwm-regulator.
>=20
> As of commit c73a3107624d ("pwm: Handle .get_state() failures") this
> device no longer works. I have tracked the problem to an unfortunate
> interaction between the underlying PWM driver and the PWM core.
>=20
> The driver is drivers/pwm/pwm-atmel.c which has difficulties getting
> the period and/or duty_cycle from the HW when the PWM is not enabled.
> Because of this, I think, the driver does not fill in .period and
> .duty_cycle at all in atmel_pwm_get_state() unless the PWM is enabled.
>=20
> However, the PWM core is not expecting these fields to be left as-is,
> at least not in pwm_adjust_config(), and its local state variable on
> the stack ends up with whatever crap was on the stack on entry for
> these fields. That fails spectacularly when the function continues to
> do math on these uninitialized values.
>=20
> In particular, I find this in the kernel log when a bad kernel runs:
> pwm-regulator: probe of reg-ana failed with error -22
>=20
> Before commit c73a3107624d this was a silent failure, and the situation
> "repaired itself" when the PWM was later reprogrammed, at least for my
> case. After that commit, the failure is fatal and the "sound card"
> fails to come up at all.
>=20
>=20
> I see a couple of adjustments that could be made.
>=20
> 1. Zero out some fields in the driver:
>=20
> @@ -390,4 +390,6 @@ static int atmel_pwm_get_state(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  		state->enabled =3D true;
>  	} else {
> +		state->period =3D 0;
> +		state->duty_cycle =3D 0;
>  		state->enabled =3D false;
>  	}

I prefer this version. Drivers are supposed to set the state as
accurately as they can. If they can't say anything about the hardware
state because it's in an undetermined state, clearing out all the state
fields seems like the best option.

We could probably do this within the core to avoid any such bugs, but it
doesn't really hurt for drivers to be explicit either. Maybe Uwe has
additional thoughts on this.

Thierry

--yQ4FAPurPO6iFeq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRrl3EACgkQ3SOs138+
s6HN6g/9FZdbO0+sT4vNe3BcuLgE8jgBk/xci2tz1QWagmX7V9O8YwAdohK9W6RI
EmqOmjvmShmtUXLzPFvG1TQOSsyCG3OWQpdxxTVOnDIQfg9FawWaLzVmfhhCLrI2
oWsZ7zagEcq9iz76N8BbFBhHK8er1pc82Pg9LNXNDsAGqFZ2N/tl61aFq8SM1DhE
iMh1uk5iP2Z6J0KSQaXBMuBAicyMf1DPsrvR3lXbkI2Z1xVLrwJURDBjYezUk39H
OcRU0vi4wriFkAKhh11UwXl8G+Cft3bRCoCEz1MQM6fXgLP+anpFqTODeK6/18tb
LtbqwsVRhk8mXNOMpAnp0GoMp9Ew5WIJWyzpJv/Qg5QtgjqaBOy3Phnch1+1P2p5
audVNIoKGlWV0EawNVdYVQTWW6koWPsqKttww/tMf8wga5Ojrhu7aZIanGhheBAo
ml0hRxEwmknicjnW5rCnAQW22FzlMNrK936ePBnRoz787YPXLXg5IeFP/d3siPti
9TsoVFF4xl45sg5sxH8c95zUqhQdIQBkHj0mFqbc4D1VNNgRpPlNeVzltH/xBqoV
7OPfPMX3Ft3lIXTBKbzoX7QkroChjeWXRkgDWhN2vSFYDXdNkNYcDZMrtYFyRLZT
70BGoMCl5/f3cQ2hsayHjHbaenbmKrm9MaYcdrw9b7TY8fljF5Q=
=yipu
-----END PGP SIGNATURE-----

--yQ4FAPurPO6iFeq7--
