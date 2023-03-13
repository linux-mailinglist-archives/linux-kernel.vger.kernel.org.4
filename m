Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA16B85FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCMXRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCMXRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:17:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758997F015;
        Mon, 13 Mar 2023 16:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB530CE1290;
        Mon, 13 Mar 2023 23:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DA5C433D2;
        Mon, 13 Mar 2023 23:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678749445;
        bh=rkf+w2R5U9yIyPxz2FD9JcXK7xhs8LnPgBEvZWq+PXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4uiqAV+1Dom/tq2BBK/v5VM0GdAD+C72IHMEwHM9H8xKqSslhSoJJWeWm9kUAp68
         FqEqZXgcCQfhwmRRvRxuG6APBkfypGak6gjl5658yMjV+vJxytUgyvyE8aJOy4c4RS
         5ZSwkfobbVqFcrFdDTr46j9cgzSbY6IKXedhVCswu9hjlObWlFucvzo5bwzVD4FzZf
         vBm5sJc+4OloxUOZ9fZkHxwst0a1NPq1SGoWXUldtCJmaWZ1a7SpGAIq5qcdTJO8t0
         TFxKgE7Wg15Qw3sN0us/GNeR27WazFQn89Mec3R4UpKzeF04WQRuXXQb5+O7029qb0
         RVIIdll/Fkv6A==
Received: by mercury (Postfix, from userid 1000)
        id 172041061E59; Tue, 14 Mar 2023 00:17:19 +0100 (CET)
Date:   Tue, 14 Mar 2023 00:17:19 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv1 04/11] power: supply: generic-adc-battery: fix unit
 scaling
Message-ID: <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-5-sre@kernel.org>
 <CACRpkdaa6ZOt7U+iLwjrTGx87BdgXX6wbW2Ab_bHye_TNzi9Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7uyvyepd44usvzdp"
Content-Disposition: inline
In-Reply-To: <CACRpkdaa6ZOt7U+iLwjrTGx87BdgXX6wbW2Ab_bHye_TNzi9Tg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7uyvyepd44usvzdp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 10, 2023 at 09:23:06AM +0100, Linus Walleij wrote:
> On Thu, Mar 9, 2023 at 11:50=E2=80=AFPM Sebastian Reichel <sre@kernel.org=
> wrote:
>=20
> > power-supply properties are reported in =C2=B5V, =C2=B5A and =C2=B5W.
> > The IIO API provides mV, mA, mW, so the values need to
> > be multiplied by 1000.
> >
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
>=20
> Fixes: tag?
> Cc: stable@vger.kernel.org
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> This code can not have seen much testing.

There is no mainline board using this driver and I think there
never was one. I did add a Fixes tag now, but its probably not worth
any backporting trouble considering it has no users.

-- Sebastian

--7uyvyepd44usvzdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQPrvcACgkQ2O7X88g7
+pr+5g//boqvVUatIQJz3AYJDUC/o9r62m7SjGB5Zumh4KgV0KuIQmVqm3yxiW6u
o3Gxo+SrJw5aUmUceXIhjzueK34uaZm9ncHeIch/IcwyepZKvPBEz4o5+hOwwfG7
b1nDx93sQsOkB2mOiCFGID6DB8M6slRagc6qIbk01lkKppWhTqxnUh1yvG1nURZo
FaNqXkB8KJbQglknVOZZ4nVsJnkt8jj0L3H5LfoHaSEBJtd48j/22kVfHI4KCdo3
Shyxh6B8Z+RDPxWmqGEOQd9IrCPxje07M2mq0p1XG4gARUtFc8oS+kWW15Jv2W9x
DDy5HlPvPQ2legMlLTjsYWcDBDmO8TU1Sj/aTi6h+lV18fi2nfC/FSpUBXHW/tfI
1/KCzDKziTMxRPAjVa4l+AjJCtOW48uTc1r+OxXpSBjQ4Tj91f+xLR2pgtq7Fvv9
E3uNigw8WDlfzrvjFXKr5Mrt/mixYexfmfm9hRdAkhs7vMSkhnyDMGgUEylHSYtD
6ZzLvCrF1ClMSFfN54wgk596TLM1QFIO/LZvc4/820MuprXpGqCK9OLbcyGt9OdW
PrHSQmdCFmW+u6YGMurTeJMaxTw0fHK6QibluRvZUbLqR974sRJ4ilVfVruMEBNS
yz1R8ifTVTACoJoKFKcWKp+HLjrTJSP/4yKcoxCoo2doUMyrbXs=
=+FR2
-----END PGP SIGNATURE-----

--7uyvyepd44usvzdp--
