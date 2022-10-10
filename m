Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265A15F98A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiJJGxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiJJGxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:53:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED39BE5D;
        Sun,  9 Oct 2022 23:53:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A50F4B80E35;
        Mon, 10 Oct 2022 06:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A764C433C1;
        Mon, 10 Oct 2022 06:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665384827;
        bh=xYNnPQoUQwIIWl2kre4d76ZpVW+ogzY/w4upo85t1lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5KutiiHQxGPG8W6131D82Hslq0/3FZtm528OMtqWg8IWEsTSl+4aR1gnbfaf7aWr
         szdxIYtjrZtTpQfRhg36kwlM6Y5EgVFLQ15OLLNVU3Ct7rpvFQxjSp1/AmUnZsq8xk
         dA/McXsUnCoAm+r3PciEczkKe0ubnUgRf4kOcsmZ4Se/QmQimvWp6XkSyvP+1dhqyS
         PK+yrCfJHqq2+YaBNCg9dTAT/j9WPfTByG0omVMGgZte26zvgBrqwtSoxxAAKpCkHL
         rGH1/dHAFVHTIEswmcVqij3bDQ2WnNodCV/x8AQEz/0ZgW5J2Hil76LHzkJ9N+pfJ+
         qrTEeKXJ+8uoA==
Date:   Mon, 10 Oct 2022 08:53:40 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/5] arm64: dts: renesas: rzg2l-smarc-som: Drop enabling
 WDT2
Message-ID: <Y0PBdDtFzcsmbtMv@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221009230044.10961-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pIvuJ1YF55lgB1Fx"
Content-Disposition: inline
In-Reply-To: <20221009230044.10961-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pIvuJ1YF55lgB1Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2022 at 12:00:40AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> enabling WDT2.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I'd squash patches 1+2, but that's minor.


--pIvuJ1YF55lgB1Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNDwXAACgkQFA3kzBSg
KbZcCRAAsrAOyJqGEk48MeAUPFYnUVZXlYgo2WoWqBo1fokmrtI6ZhIH2qzeGG4e
NoPHwQpmQORQP4RmB+0xkdWO0cpSaW9vGExbuFKpvV2Io54mp96ml7Q/Hk7qwN58
VfU36KoXnosKxMbdD8/9UPts2oYLaNRWRXKRtNbQZgX3BetAbPZhtPqpTflm5ary
SJv5jlxrmDhzmm+TOJvo0uDC08P1NUs5tD8WQhsrUIsZX9MGNsjiXIf5+MyQPxRq
eHTj9Ktej+fVG9wPGLs3/Xd0GvQui7xLafX40CGvPabcKMqI7kfRHsILoHHA0AQH
s2dxxeNsak7mdzJ8dCnd9noXnSConnuHs0CZik7nInT+J/8FYRnpuygumE9aG8lD
aSrEQ5FWfn6VYjR4suXa/NKvt68m/TxVSjdkVEHOkhViZ7/K6HuMlrFQYKFWCfzI
YWe+7kwdtr6EZKaO5rNMEhRVkSInZJ16660O7VfcHOoA2L8Lk2XxZqDG7pLCBXm1
yZHcQYDhqKWuXmL8n/EHDTtBxJV+CQDw8YNDvtgqZZiAb+6CRs58f2onuhd4WPJr
z3w0XkC2BSlKBjJSHTPbkdXaXMjfxY7h/WYXIskY7JT+T7tuHDSsK5icvw6qqKQu
zJNDINsI5wbPCzrT4iteujA369Vms+UV7EVK7WSGwkG6NY2BcHw=
=sV/5
-----END PGP SIGNATURE-----

--pIvuJ1YF55lgB1Fx--
