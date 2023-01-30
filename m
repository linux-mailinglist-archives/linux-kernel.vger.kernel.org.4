Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02768152F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbjA3Pgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjA3Pgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:36:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C35E3B4;
        Mon, 30 Jan 2023 07:36:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso3461701wms.5;
        Mon, 30 Jan 2023 07:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dOXRUmBXFiifXvzPC8imf6hOLL/T6qZBqV64N2nOgU=;
        b=fTQ3P9YCjeLCmcnsVKhrpsPP8aZsKY6HBgLCPuqzSrFWX/iT8Sp44LdM2UB/fyhNMV
         E66b241sIzZeZ4NCpropV3vUUcZSTPL7mSKjBAx833SMSi7MJqfX8PZWt0+sF5JLx9A3
         ufIdnyL1VLNXgDPn7Ef9iNvj9t7ZkYeNfFyGlc8OGvuKjuVEGVgwMvACU2gt+bciF8t2
         sYbfj5SgBQ27AasRjJ2BFXK1cEFTtMG2zXkRWyXJo/J25nesB4xWs26L47z7P39NYVkN
         EoVaVqbNL8HQ0mwhDPgA6jIC21Rc+xjWhJ2HZJZwtZZUJ9P9xPN0pS57zmHm3e6fS4Ld
         1jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dOXRUmBXFiifXvzPC8imf6hOLL/T6qZBqV64N2nOgU=;
        b=db/xycjH2ZVlVPQ1kBRxfIyckkWsS01zO5zUXtCUz3C6LAR5P5BewE6LbXTNvq/9a5
         bLXGcqIgsYiOImX7VaXKH351wL/rbzCStQ7RJM0HOkwG5qD5fuBHRcVz1mzum0FCv/6u
         uMWPp3bgh0hMyDLsTpJ/Ju57gfbZ2/zT8vHcj2XqXG79EU5RQKUt1xEZ7uIAqnwa4kVn
         r8C36Wq5cN9/EvGQnwzRBrrqWw7JDowForu6Q+FmHS1i5R8WkEC6agaLeUYfomMuoIAX
         nks8Eebbfunb2JWlwpNBFdT+jxZj6vhWSRpQ065fFekhnLtwN1Q+mbw+7JZ+4YiGTmrF
         o8PA==
X-Gm-Message-State: AO0yUKUW0KMPQK9SX83ZKjm+q5dzruDEuu1Ek/mknoeAg3oTywHO6333
        VyH9vI9DiQnUY5AlWk5ZiL4=
X-Google-Smtp-Source: AK7set/4JeVm2sUMgE7ALABnOi8bhC2azYZoYx20b9heveQtDktZVPMBf2tjCnHNbw8+1PRZTZeMhQ==
X-Received: by 2002:a05:600c:3595:b0:3dc:1054:3acd with SMTP id p21-20020a05600c359500b003dc10543acdmr23270906wmq.17.1675092993971;
        Mon, 30 Jan 2023 07:36:33 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id w16-20020a05600c099000b003daf681d05dsm13068005wmp.26.2023.01.30.07.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:36:33 -0800 (PST)
Date:   Mon, 30 Jan 2023 16:36:31 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: sifive: Always let the first pwm_apply_state
 succeed
Message-ID: <Y9fj/72Tl5FN+HSf@orome>
References: <20221109113724.519021-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ir6Gg7F9FhCRM+tI"
Content-Disposition: inline
In-Reply-To: <20221109113724.519021-1-emil.renner.berthing@canonical.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ir6Gg7F9FhCRM+tI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 09, 2022 at 12:37:24PM +0100, Emil Renner Berthing wrote:
> Commit 2cfe9bbec56ea579135cdd92409fff371841904f added support for the
> RGB and green PWM controlled LEDs on the HiFive Unmatched board
> managed by the leds-pwm-multicolor and leds-pwm drivers respectively.
> All three colours of the RGB LED and the green LED run from different
> lines of the same PWM, but with the same period so this works fine when
> the LED drivers are loaded one after the other.
>=20
> Unfortunately it does expose a race in the PWM driver when both LED
> drivers are loaded at roughly the same time. Here is an example:
>=20
>   |          Thread A           |          Thread B           |
>   |  led_pwm_mc_probe           |  led_pwm_probe              |
>   |    devm_fwnode_pwm_get      |                             |
>   |      pwm_sifive_request     |                             |
>   |        ddata->user_count++  |                             |
>   |                             |    devm_fwnode_pwm_get      |
>   |                             |      pwm_sifive_request     |
>   |                             |        ddata->user_count++  |
>   |         ...                 |          ...                |
>   |    pwm_state_apply          |    pwm_state_apply          |
>   |      pwm_sifive_apply       |      pwm_sifive_apply       |
>=20
> Now both calls to pwm_sifive_apply will see that ddata->approx_period,
> initially 0, is different from the requested period and the clock needs
> to be updated. But since ddata->user_count >=3D 2 both calls will fail
> with -EBUSY, which will then cause both LED drivers to fail to probe.
>=20
> Fix it by letting the first call to pwm_sifive_apply update the clock
> even when ddata->user_count !=3D 1.
>=20
> Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  drivers/pwm/pwm-sifive.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

I've applied this as-is for now. What I'm wondering is if perhaps we
want to implement something into the PWM core to deal with this, now
fairly common, situation.

Thierry

--ir6Gg7F9FhCRM+tI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPX4/wACgkQ3SOs138+
s6GN+Q/9GErvttbzCfQ8UlLEkSt6ZyC2QIVVZhEDF7LoH4jprLifKAEsGMR9BK5y
XS2nldqcUtb9q/p6hVdnGcMjyDmoH9OLoVeM3PX56BaeKYaEBdUeg97uFAwsIJU4
TdcFpAzIVKNCsPyK0wwPw2P4bWyiEs1+rf6Go4jNu7aZE77yI11TrhjUxXBc++9g
EcDChQ2pu3PJgCaBx16GZ4RQ5CgkR7JSL50ZohmKbdO/8asYi3aGEBxo5YN6BTaV
NKI2H1n1XH1KKC6m/3/eIC2fM3bv9q+JqRe7vJ9kalxTdYnwZKglRv2WyFsA0kF1
e1bTJrq3P3fpZVfY+dH1SfddToqGftPOc5vBd+NnK/brfmX+uCpg+vDoo/YeP+jU
TDh9FZkWGMJ7XhZh1A65QQazsKfo67gyG5xKZZU/XtT6U9vUXBAffpzWryeS+ulr
iDo6WjhtqBw+7hk57paDn5f49wVJIRijvNU0dAVIGGxaZceiAo1WJsaC7zUxrvq+
9fCZb/o7bfsnFd+/QG8tVcuZ41dKTrqlXHU70qzhXJ4tBxE8NVrk0hG8AmghyGt3
oQiyNw4LJE777ES/OVpkndtr4DMaERL7+e6ZAqJ8w/YQNHEedacHM8KopOrGUTHp
f33dJEjjcqFU3r0PWfo9mRRaxLF7AeWJxOdlMUK28f1k5fQo+V4=
=oOaj
-----END PGP SIGNATURE-----

--ir6Gg7F9FhCRM+tI--
