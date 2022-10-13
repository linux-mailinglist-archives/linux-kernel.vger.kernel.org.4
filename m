Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFA5FD5D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiJMIAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJMIAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:00:16 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696C05BC35
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=DXATLH+obw6y9J96vlKNL20zNH8M
        LnaUTwMkIF9xrTU=; b=GcS0REM5/s+itC+QTLV0jFnKi70swnQq9DZ1LA+XHOW5
        MjlfG9sdsfNtkAqWSH3OtD8GSo5L3oRjXLABqtn7WXtvNHGQximMgVmiRcx1e6wN
        75UWlsymdsoS6CsYwdzjbq9VX3h3n83epPv0+oMbbSv9yiXtv9V9I99ioY3PKfw=
Received: (qmail 1014314 invoked from network); 13 Oct 2022 10:00:08 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Oct 2022 10:00:08 +0200
X-UD-Smtp-Session: l3s3148p1@Zbur5eXqFNMucrTR
Date:   Thu, 13 Oct 2022 10:00:04 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hai Pham <hai.pham.ud@renesas.com>
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document R-Car V4H
 support
Message-ID: <Y0fFhHYhKC4pbBnh@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hai Pham <hai.pham.ud@renesas.com>
References: <c268cb4497cbe79773bb6568f36c37adc6fb5bbe.1665582645.git.geert+renesas@glider.be>
 <Y0cPpJin64ou4ivI@shikoro>
 <CAMuHMdUqp6J8PZOx57tGpKZKxQBY_bkU7b8Kiqu9DNjmj2vCGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vw7px0cDU9Va6jay"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUqp6J8PZOx57tGpKZKxQBY_bkU7b8Kiqu9DNjmj2vCGg@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vw7px0cDU9Va6jay
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I actually wrote such a patch a while back.
> However, I didn't send it after discovering the R-Car V3U Series
> User=E2=80=99s Manual Rev. 0.50 does not mention the fourth Strobe Timing
> Adjustment bit (STRTIM) in the RPC-IF PHY Control Register (PHYCNT),
> which is present on R-Car S4-8 and V4H, but not on R-Car Gen3.

I see. Thanks for the heads up! Maybe this is worth a comment because it
is an exception to the usual behaviour?


--vw7px0cDU9Va6jay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNHxYEACgkQFA3kzBSg
KbaE+Q//bnEtAOVCo/nT6BWLWDXnMoTyIyk8dUMXmQIMoEFbPDO4hIVvpSzapxC8
Bo3+Hrnt2BAWF5BQE49ZA+9TQc3TrFubmeosb+GM9e125XQiheeiGX+gzaSqONoz
5VWMFrnZYq8M2Y0eLb6/TswbqKTM2TEV33S5ervQQ4S3+j1fe9IsRNok5JCAuttg
0OJ1PC7c4tFl3rzobLJzuWVA8p4//kWWk7STzo3oUM+p/3BzR8qSrTTfTsxnw6Bs
THCvCL0MINFEYlW/Ab28PV8iSXxoNgcRwyPxG6WXYEpurKlcDLJM+T948HYpgPt/
/QGIpTHpIpnIiOe/+keeWbrZ/vyWjf/RhaHY4gmuYvO2OdO/zbg6D7bzlMarNnPD
XCtJ9GL1qR2rMRdNHsBVStEiQWcgBcPQ7RhsqTYblJMvXjKzdGOW+DGLeAbO0+Ly
kttNoXnFfyEBTAsxa4onrxJFOcwy7Ri04I2PonC+9NXkE3MZvSGzrfClaNvbZ7Ja
UOV6K3izlOrBsOfyi1Rkr7uCfDIXnSI2VtZ949DyUSgK2Wo9DboGWZqLbi+sEdaK
bVj5cXP9tQHEDxpiopG7oxQJEeZby9qqf+eW4fJpxol1LOUO3V2oH7dI/rdqrX0l
tEUhdhINZJywPf1V8KWrPfPhLWoVqNcDIviqEmhVJeePoPuk+Y0=
=pJBc
-----END PGP SIGNATURE-----

--vw7px0cDU9Va6jay--
