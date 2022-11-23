Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93815635304
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiKWIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiKWInr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:43:47 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7795EF8B;
        Wed, 23 Nov 2022 00:43:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id mv18so7684369pjb.0;
        Wed, 23 Nov 2022 00:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEqY7eSUYIrjPRbm/F0XJSLYxWUBYewQdwfH+fs0IZ0=;
        b=R74V8oy2vcORr2rvgm1i5wrIxPorzaR9tJLI0FGtoPIOFO33B8Zbypd2jkImSqh37A
         kSZqsVhGgW+LaNTJZ5jc3TDjXBKB0U6cFfMjc4i97c8U6w8BqxFIqH1AxTY3n5Ya75W1
         46+WYkEczUpeNVb510qObmcFgO3np/I59OHkVRQL8RzGqhkvG13sTRfPEGuVcNqFjenD
         rzOmeCXut1B57Lva46w45WH+c9ZM/6i3++8gdJKG8OHHZejzwqvTFHgZDZBo8jO12rS+
         0A2tMgrPBKQhatqhzmwMbGM3x5TItPt95xJTvxyZcfUSuW0qLs+6NPBeDyE4Mz2ZJGe9
         bmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEqY7eSUYIrjPRbm/F0XJSLYxWUBYewQdwfH+fs0IZ0=;
        b=74zU2AY812GxM1549GTekdI0pYnl4YFivaEXj2Zpa7hvgYWPzjEwvvDsHeo1KSo7Y2
         vsbEgGtkrG+NGZq+sZulnvjX0+5pFUMw7KsPYzxysVp9ZWQrG0JfdMKD/J7YShfz5Nh6
         bmzbtmPJIPMXEl9zGl9UomvabtlVZEBiUVPeGYsMLY9ckX2P9tWmdikLtgLt9N3ak/0P
         T7grb+Od1G8SfhxlI0X6zBXzD6GIF70f0SmLoNMUpNkfQptE5kyAhRNB52Wo54xro0yY
         QUemppIfCqM68RyydcDdCp7Oa4SivDy5Cmhqt64thHBINp2fyeFXfHYjclFpxnUJfDYr
         6/pg==
X-Gm-Message-State: ANoB5pmcqKJLEAANg+83pK3hFxUN1R6LEea7P82cNXgE0Kb0ueU5zmK+
        9O6r1anPJjHrymVPAN6T2GU=
X-Google-Smtp-Source: AA0mqf4QoiS6RD3VcBq4gMjB7ZeXjnm6haKPlDcJODzSaKVoSvZIvApR3jZFHnH8lpYomx8MAJaUfA==
X-Received: by 2002:a17:90a:d304:b0:218:8d0e:9f03 with SMTP id p4-20020a17090ad30400b002188d0e9f03mr23867092pju.114.1669193025711;
        Wed, 23 Nov 2022 00:43:45 -0800 (PST)
Received: from debian.me (subs03-180-214-233-3.three.co.id. [180.214.233.3])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902f14900b0017f7628cbddsm13487225plb.30.2022.11.23.00.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 00:43:45 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id AAB731041A8; Wed, 23 Nov 2022 15:43:41 +0700 (WIB)
Date:   Wed, 23 Nov 2022 15:43:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [v4 4/5] pwm: Add Aspeed ast2600 PWM support
Message-ID: <Y33dPbQywb5amyw4@debian.me>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-5-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jwnDXMyFOzlbJrYy"
Content-Disposition: inline
In-Reply-To: <20221123061635.32025-5-billy_tsai@aspeedtech.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jwnDXMyFOzlbJrYy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 02:16:34PM +0800, Billy Tsai wrote:
> Add the support of PWM controller which can be found at aspeed ast2600
> soc. The pwm supoorts up to 16 channels and it's part function of
> multi-function device "pwm-tach controller".
>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Reported-by: kernel test robot <lkp@intel.com>

Why do you add Reported-by from kernel test robot? I guess the bot
reported issues on previous version of this patch series, then you fix
them, right?

--=20
An old man doll... just what I always wanted! - Clara

--jwnDXMyFOzlbJrYy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY33dNQAKCRD2uYlJVVFO
o5QOAP4hPIbr2ww0mmYXCgvWkHUFUtnqMak3T0+BC07yQq6uYgEAjFVspeDnkpyZ
p9/Fd0xJYU24ygs1zJkB0Y1IhbLHTwc=
=blxx
-----END PGP SIGNATURE-----

--jwnDXMyFOzlbJrYy--
