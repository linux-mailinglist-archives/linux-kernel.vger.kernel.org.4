Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245D66583E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiL1QxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiL1Qwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:52:45 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A26C1D0E4;
        Wed, 28 Dec 2022 08:47:32 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CA0A25C0197;
        Wed, 28 Dec 2022 11:47:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 28 Dec 2022 11:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672246051; x=
        1672332451; bh=kNEXh77+6wY23ZdF9C0dJh8nBDvRVsFvdpp9oNCrBQA=; b=T
        QXrNMCJuy72Qyz8a+hAKaJwHniwj+t/33+MUy98/s1jDMTK9TnCzM9PVH7veOxl2
        abNE3E53WEtzhRFn7rTT9+Nbgu/M2xZoSF3rdWbmlOHBI4tX4vCYEAqZliAn1dQX
        b3DLhKblswviltyAS+uGGNBV7eutuEOO6RfrmKlnPPEILM9rzuEK3isQaqGlz73u
        Pg1NwXRVhOaZS10FIPHtlhisbPSzMrQoYsVUwCFqBXHlNzoAhuJk2PnirM4UggJv
        faeCH6SJmNKSn5mNjjccthJNR0gUvd2zRE8elqKu8aN0dhaAxITW4VJrIbN7FMmf
        BlbulI98MbufWDvXO994Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672246051; x=1672332451; bh=kNEXh77+6wY23ZdF9C0dJh8nBDvR
        VsFvdpp9oNCrBQA=; b=Cm3M6SLAGROnguwnqsMb5REVOQ5WnIndpxqFT1cV0p3B
        mKlBHKOQzSbGx75r3ZjcNXq9csWpffkW/wAsaXGvTA5IBcHl+4/zzIqVob25kGvn
        1QekDtW1wM6jF8QwtEBYieJQV0LHIFcCBpabqKU5ntSWNc37jVZVmJi52ZCuyKqk
        RDh70r7a82gAAMQa1nLUT509oaZ5sb5DsvRznmAtfHlAfBZRlv0hE9LMUBlKLIf3
        WihKESlR30cejoaJNZB9wsrDERj1rc9z60hqSwoYc3g9BhBZI6NFOA2oSUGtY+p8
        EVeKXDQJtcKuT9IUdLSPkn4o0vasjacDpW3//t8DJg==
X-ME-Sender: <xms:I3OsYz5hRhYMEas7y71Sww6BGMce91_3xjYLIrPO8JIKTUVbD3s2IA>
    <xme:I3OsY443c2iCaPqRY9fawRe_q5ZjpN_leV-Cy4AinN3hXK7aiBoJ5MHBYCgF0Xtq6
    SWKf3lPGzGxvZ4>
X-ME-Received: <xmr:I3OsY6eTQE_gPzdh-k8l9cAqw5Fv7jp7seJhFsOBr3OfdYEJOc2VrZfqVEje>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepffgvmhhiucforghrihgvucfqsggvnhhouhhruceouggvmhhi
    sehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnh
    epudeileefueetvdelheeuteffjeegjeegffekleevueelueekjeejudffteejkeetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggvmhhise
    hinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:I3OsY0JU_veQtjYBiC3HniNOTkiOfWiL_4ain8QTEd81lO5O2OtKuQ>
    <xmx:I3OsY3LwGDztGLd08k5G3RwjsHDxi4uo8e1kg4GIeTEX-9IOEUP7DA>
    <xmx:I3OsY9xoowRss3v04ct5kDbOZPK7Q94VeH40CloN5IpBecwfYjkLtw>
    <xmx:I3OsY-XZ0ofbrNrxu-1W5UA3u95zki_rCPi9s1ugav9Q8YW02geH3w>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 11:47:30 -0500 (EST)
Date:   Wed, 28 Dec 2022 11:47:25 -0500
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     oss-security@lists.openwall.com
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Message-ID: <Y6xzIR9P+a6uaaEx@itl-email>
References: <Y6SJDbKBk471KE4k@p183>
 <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca>
 <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r4azVG4BR9kBokFk"
Content-Disposition: inline
In-Reply-To: <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r4azVG4BR9kBokFk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Dec 2022 11:47:25 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: oss-security@lists.openwall.com
Cc: Alejandro Colomar <alx.manpages@gmail.com>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly

On Wed, Dec 28, 2022 at 10:24:58AM -0500, Shawn Webb wrote:
> On Tue, Dec 27, 2022 at 04:44:49PM -0800, Lyndon Nerenberg (VE7TFX/VE6BBM=
) wrote:
> > Dominique Martinet writes:
> >=20
> > > But, really, I just don't see how this can practically be said to be =
parsable...
> >=20
> > In its current form it never will be.  The solution is to place
> > this variable-length field last.  Then you can "cut -d ' ' -f 51-"
> > to get the command+args part (assuming I counted all those fields
> > correctly ...)
> >=20
> > Of course, this breaks backwards compatability.
>=20
> It would also break forwards compatibility in the case new fields
> needed to be added.
>=20
> The only solution would be a libxo-style feature wherein a
> machine-parseable format is exposed by virtue of a file extension.
>=20
> Examples:
>=20
> 1. /proc/pid/stats.json
> 2. /proc/pid/stats.xml
> 3. /proc/pid/stats.yaml_shouldnt_be_a_thing

A binary format would be even better.  No risk of ambiguity.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--r4azVG4BR9kBokFk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmOscyIACgkQsoi1X/+c
IsHnOA//fT6cVIE4FIMywkI+AqPhk9XiChwWd7FjC1AvRuFHtzRVeZKbsQm5+TvP
zsyVq80XH79nYyCvOdjUsU6ItgvLFssJhLrgLHsLZLgOBF6aCjcKTGQ/Gt6yksqG
SYEf2mU5CDAvHiqqimYruOHU7I+4KLozQpk1zhOkb2YyVcl9Jwc6ia4k7p6Fffdi
K/W851sXSQ4MHRGwu3Acwu014W0OgwCji/0UeFIhktSMMyi/sOQrs9F/hfsCty+q
F1pCWeclNXERprw5653z5ujLGEUgD4eUX+DLoqxJ1oYQz0MvMITWISSZ8Q1lnPM+
xpaZZTF2cJG6IF0hBuMWqqudaOvfqKYlyXU2c92FyBKsVruaj1e7WDco60p4iFvX
rxaPlMsRUYeMYjWdO9Uvhz1GcygbI4eBdQk6+XCNX+jvCHAG2TtKtda5fPa5r2mt
wpfni8qiaGDJQybqsDqjAjjRlN+AgXQJYYK+GFDXCd7B6qdxpOGSJaTUmjw3Mf+6
vykA7kPEX2MrF2WCben6ve6pvUKQYI3NjjWUd+R1IDnnFrFMJiC7MdKgaRF2jN/1
x7w+U7oj6VngCGRWcwlbx01/BTkhJT1AvKF4wjCxffaG7OS9JYlOLfERAZTiXjMh
PlHFUvAsRpTaqXdVVT3/f4WvXlFMGB7jydW9E/PX1Qd3YZHaOUo=
=ujCS
-----END PGP SIGNATURE-----

--r4azVG4BR9kBokFk--
