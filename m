Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C857084B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjERPOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjERPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:14:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F570C3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:14:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzfKl-0007Kv-DE; Thu, 18 May 2023 17:14:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzfKk-00172Q-Kt; Thu, 18 May 2023 17:14:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzfKj-005gmx-Rx; Thu, 18 May 2023 17:14:25 +0200
Date:   Thu, 18 May 2023 17:14:25 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v18 1/2] pwm: add microchip soft ip corePWM driver
Message-ID: <20230518151425.fy45t6brs7a7rmdm@pengutronix.de>
References: <20230518-reactive-nursing-23b7fe093048@wendy>
 <20230518-dandy-bless-fbd1e2c23dd0@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f6ksgjaxmglv7ul5"
Content-Disposition: inline
In-Reply-To: <20230518-dandy-bless-fbd1e2c23dd0@wendy>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f6ksgjaxmglv7ul5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Thu, May 18, 2023 at 01:29:20PM +0100, Conor Dooley wrote:
> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for perseverance,

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--f6ksgjaxmglv7ul5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRmQNAACgkQj4D7WH0S
/k6F4gf9ErdZXnexbDjJIiWItWNzb5YEKF8FvwDv6ibeULwG+RIOcaLbam21AmFT
913r69IaAWh68bdBNkf4BhUs6BmOUPOre2egQP6eKBby01RmcMjoh4Cxq1aPqdDT
AL6gZ+Z37mXc3agps6hJgZHBOx0Es3GRUEeQdixjnZsccj03sMqC5+Zbj5VqLrOv
HWJ+sTaYv03wlTlx4cefJKWuQX8N0eFyrW3gZxkr/QwhU5UailbEI56E3pHxuBd7
yCeg+/K2tQ7dqAfv3xefMT2AmsOqNJ3dhfUsjZD22CnYMQUnM4Ec2Zzc2MK6AQeU
wSOH7akI53F68KvFOWv3QFV2N7xVTA==
=IEww
-----END PGP SIGNATURE-----

--f6ksgjaxmglv7ul5--
