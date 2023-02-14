Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953F9697072
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjBNWJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBNWJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:09:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1622327D62;
        Tue, 14 Feb 2023 14:09:17 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 84B776602173;
        Tue, 14 Feb 2023 22:09:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676412556;
        bh=alXr5cFGo6ZX+NcmH0aKeKPUofQn3NagXbNvEpCcFf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzHQaH3ubU12gc9D9ci87g24fmc54eqPFhD+EtZwabcZuvw0+vuX1iQl9/tixjQ2D
         AKsttnxf+pobj/u8QQlgfdcKRzOYalua5A64v9j5CxhkOHy1BjH/gLZsuenKy/qZfn
         LzvwTVTLNyD2Gb3ZS5P5L3Dg946+6K3Em6nfCLNY5aAZCfMaHqs7kPCxvHptV+47Sj
         5/bjxp8J/WJnvH++W1kfWwreVk19FRxzZi8x6zVfWUw7KsibIWZ4RPlqA0lTRMv+yU
         tFd1d1deoxTCjpZjOvOH8gWsMlWjn2j7w/Ac1OPMXRsCfW0SzIB27Tjyomxq5SohB7
         Cpw954tuXwFYA==
Received: by mercury (Postfix, from userid 1000)
        id B492310603FE; Tue, 14 Feb 2023 23:09:08 +0100 (CET)
Date:   Tue, 14 Feb 2023 23:09:08 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v4] power: reset: add Odroid Go Ultra poweroff driver
Message-ID: <20230214220908.vpzlduyhfcoqzenb@mercury.elektranox.org>
References: <20230126-b4-odroid-go-ultra-poweroff-v4-1-979efb6eb3fb@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t46mdvvr7bb4ua2l"
Content-Disposition: inline
In-Reply-To: <20230126-b4-odroid-go-ultra-poweroff-v4-1-979efb6eb3fb@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t46mdvvr7bb4ua2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 14, 2023 at 05:41:18PM +0100, Neil Armstrong wrote:
> The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a powe=
roff
> to its two PMICs in order, this represents the poweroff scheme needed to =
complete
> a clean poweroff of the system.
>=20
> This implement this scheme by implementing a self registering driver to p=
ermit
> using probe defer until both pmics are finally probed.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Previous submission was at [1], but I converted it to an independent
> platform device with device auto registration to permit waiting for
> both the PMICs drivers to probe.
>=20
> [1] https://lore.kernel.org/all/20221031-b4-odroid-go-ultra-initial-v1-2-=
42e3dbea86d5@linaro.org/
> ---

Thanks, queued.

-- Sebastian

--t46mdvvr7bb4ua2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPsBoQACgkQ2O7X88g7
+pqYSQ//ZQ7xDk9zbf/G8rWnumQwSRBpGvVYR8J5b4sfxFtcH5CmlDYXAtIrYyq5
pjcSnkQk6/v3g+hTX9yBcqLKtGUcC7xfk++QujipQKq2JNbVmq+0W3/A4dGlv+u/
b1fTXfXOfU1PxJ46NwXzj391GEFbsAFljwhpkfIcncU6LJsOknalZ35YXths/Woi
EDvxSkfbC01PV+JyFqd3lMzj1EPLlMBjHkVeVpQjj0EgGtaLIoi5t5w2w3euPm4C
6fsniaL7DwunQeqhB7L9bjekD9zyNjHyboB/IJg5YKnLNRj8y1g7DD4nVrhcWqpu
U6LRa1e5Y4D+Mgi8F4kkaS96A++gtMhWtwsXFzIy5OBP947kM3TQlNbufSMsEVOm
zTwk+yjohrNKygBrhJazt+tWO9vub1nEs9hEnlpLlOvEVpz4dRqKOUuS9boqbEgG
rOkxRLOvO0nnBhpKtwqXebJg/AZ7rctuqTnbsQnMtdIxZ0/jbzwObAtDf5C2xsG2
T6EwKSJrJZ+45i/9k9SrJirbNKgJsVM6I9V0Tr7m30pD7CbGciBvy/STvwb2PRDX
sjyWRm07aXPvSs+aYCfTr5fD3HPB310mXnYdVGhZ+bwFczOWiPifYnY1AZ4KVfp2
Yc5yDhollHdA9ptAvhs70YFPMPT7r6kVOT1QjplNcdeeFDduEPk=
=j0ok
-----END PGP SIGNATURE-----

--t46mdvvr7bb4ua2l--
