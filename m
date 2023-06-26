Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2C073E5C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjFZQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFZQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB321B1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50EE660EFB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 16:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5DDC433C0;
        Mon, 26 Jun 2023 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687798184;
        bh=paOKeyA2C+7w0aTvrydeWORhfmX3bTsvihkIatcTxbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vb/yUXRBnuFU0aX8A1csFH/aBCs0vyhRSbEaADfifwI9F/Or/V5Ie41uZJcAIPDSZ
         nklHFHv/T6kUIVOOUTXHP/51WhU4I/jNmtWaleIfq1SlzfD1D3RRV8uEsX9ELvXA/j
         ip/dC8pn5xZpNM29R+A+LTW3Iwy1PI6y5fgM6J2LtBhDiBr07gHPtLLriQXoVwhSgY
         e50puBGBVFPcDglJnjrrIt4P/0xWah7CGkXjLkB/Ist4/g8cOsM1l6gOBrn5d6484K
         19nKfHTOPRr4kYY7z/UCRvxw0hjDbdaMg4EnPEB3+EXKDuV0VYphJKveoFeOQzruzD
         v0NTqanoMWWyw==
Date:   Mon, 26 Jun 2023 17:49:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Benjamin Bara <bbara93@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH RFC v4 07/13] regulator: find active protections during
 initialization
Message-ID: <08d6fc5d-30bc-4a55-a495-2a73b5800f79@sirena.org.uk>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
 <20230419-dynamic-vmon-v4-7-4d3734e62ada@skidata.com>
 <030a99f7-98f3-a24d-612c-d460859fc276@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jBYkEf8Gah+7Cv60"
Content-Disposition: inline
In-Reply-To: <030a99f7-98f3-a24d-612c-d460859fc276@gmail.com>
X-Cookie: Nihilism should commence with oneself.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jBYkEf8Gah+7Cv60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 04:56:21PM +0300, Matti Vaittinen wrote:
> On 6/20/23 23:03, Benjamin Bara wrote:

> > Warning can be fixed by enabling (or disabling) monitoring in the DT,
> > e.g.:
> > regulator-uv-protection-microvolt =3D <1>;
> > or
> > regulator-ov-error-microvolt =3D <0>;
> >=20
> > Constraints regarding the monitoring of a regulator can usually be found
> > in the docu.

> I am not entirely sure if this is the right thing to do. Should we expect
> the hardware state to be what is described in DT at Linux boot-up - or,
> should we silently accept the fact that for example boot can alter things.

> From the 'code pov' I have no complaints though. I just can't say if warn=
ing
> is the right idea. I'll leave this for bigger brains to decide :)

Yes, this isn't really the idiom we normally adopt - the default thing
is to just leave the hardware untouched, that should not usually be
regarded as a problem.

--jBYkEf8Gah+7Cv60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSZwaMACgkQJNaLcl1U
h9A9AQf+JCwR05HQvAZptjbBH8ZJk0cx7I6V68t1BVndeViMr7PbqgW44nyiHQRb
TvwrSlGTj34zGSXItM+srnOJBdPLxH1UrrBPA0UFcY5J6Zn0e7YJ+V3KKA9khhDT
vqZTFhbzBbSImS8Kj32j7sL2FflJVX46Ob66LKsD8zi0FXpl+HHiuqBuKntQ7gss
iz2+vtrYlJTNxlEKB/f09dvN42KyQz/NmT46gKKAGMNykdpZsJcmvfiYMcKhl35F
mOlQCsqBCxMbwKe3xjNV1PTXCT6q3AjtuG4eG65kx1MKl/DTGqBSd9lJFaXzfFRB
3hrCBBxLyBWzhZ6MTHmdSb4+ekTrnA==
=923m
-----END PGP SIGNATURE-----

--jBYkEf8Gah+7Cv60--
