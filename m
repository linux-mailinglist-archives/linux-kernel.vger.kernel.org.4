Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A42074778A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjGDRK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjGDRKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:10:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63F9E76;
        Tue,  4 Jul 2023 10:10:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF4C61313;
        Tue,  4 Jul 2023 17:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D70C433C8;
        Tue,  4 Jul 2023 17:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688490652;
        bh=8Dr/7AdunY9Rh66EGYBdO6pdEuVWqkq1brkfB1efLMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spDp7NPZHlvHh8f8/hg7JANXwWf/A8Jb3ygxaIrl7kIgexT9jjiuSMxasIY6gf9k5
         0uc296A9hDKKK9E7uZ9P+WJKxVefn95W+Httd683yp42N0+gZNPaT745DR3MJRggpt
         J2BUMm6251psBOWBCz1+Xgv58q9CuWkJohZZZliAIoL7E5xvCXsfMOmYF8oDkd7KtP
         IgMshHbvODfuuUyNMZxpPd+d0VRtuyifYk5ukDQzI8rc5vloiLq8vxjTsO4yxM5tpg
         MXXl3yrAuSJUS03QaSoHwE3flhU5m6AUkddU15Pbrxn1LQnZWAJYmpEHwQ7qiDievD
         bu5YEfhD3AW4w==
Date:   Tue, 4 Jul 2023 18:10:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        jirislaby@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, kelvin.zhang@amlogic.com,
        xianwei.zhao@amlogic.com, kernel@sberdevices.ru,
        rockosov@gmail.com, linux-amlogic@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 5/5] arm64: dts: meson: a1: change uart compatible
 string
Message-ID: <20230704-staff-smilingly-401b99e28edd@spud>
References: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
 <20230704135936.14697-6-ddrokosov@sberdevices.ru>
 <20230704-cannabis-cannon-19397cd806bc@spud>
 <20230704170843.wksxekltre2ob4en@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ZqyNyARjhPwp6q6"
Content-Disposition: inline
In-Reply-To: <20230704170843.wksxekltre2ob4en@CAB-WSD-L081021>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ZqyNyARjhPwp6q6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 08:08:43PM +0300, Dmitry Rokosov wrote:
> On Tue, Jul 04, 2023 at 06:02:58PM +0100, Conor Dooley wrote:
> > On Tue, Jul 04, 2023 at 04:59:36PM +0300, Dmitry Rokosov wrote:
> > > In the current implementation, the meson-a1 configuration incorporate=
s a
> > > unique compatibility tag "amlogic,meson-a1-uart' within the meson-uart
> > > driver due to its usage of the new console device name "ttyS".
> > > Consequently, the previous compatibility tag designated for the
> > > 'amlogic,meson-gx-uart' configuration has become obsolete and is no
> > > longer relevant to the current setup.
> >=20
> > I don't really see why you would remove the gx-uart to be honest, and
> > not use it as a fallback. Neil's platform though, so his call :)
> >=20
>=20
> Because of amlogic,meson-gx-uart has legacy devname, we do not want to
> use it in the A1.

Which I did read in your commit message, fallback being the operative
word here.

--3ZqyNyARjhPwp6q6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKRSlgAKCRB4tDGHoIJi
0q1CAQCJDaZX5TQ96AtLIC2BAMcsEl3+ACdSRUZh8O6dA4AmVQD5AT3UxCGqKIP8
MQ0E7A15dvDYTT1+a0WE9Zuf+uLlkg4=
=BCBN
-----END PGP SIGNATURE-----

--3ZqyNyARjhPwp6q6--
