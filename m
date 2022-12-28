Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCFE658570
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiL1SDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiL1SDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:03:07 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636CA2FA;
        Wed, 28 Dec 2022 10:02:45 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BC0E65C0081;
        Wed, 28 Dec 2022 13:02:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 28 Dec 2022 13:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672250561; x=
        1672336961; bh=c7NmyHHySc4TjiTj5MpYoylB3a/6CpCUH0DjRLdd1lU=; b=S
        jjLlDIvmwsM4cWOGVPAfCPJ3Iqw47RWqA2A26yerdb1yMyZsRpOIgVAjNTwWFoyj
        nMsZp3+w8LtFji4OSuW6w+vQaZ8NTcLfDN2D9/hmwqsrvvYajnVOjmGnsxV59XHB
        /Jjut9L0u8P1i06X7/1GBUM7W5YRgUpNyfQx1S7LlCMYquZ9yIClV4umM6VXAKyv
        SVW+pXrGb/D51KN4ZIpznZgZRYzppqfDdjIyLVFho9UgGMfnV3Kg0WGyKB+taLUf
        OrmE3yzMGvoOyBYVAIFP1++UB1p772BkeCm54hvc+v3RE6q4vnBPuJe1uE5nbatc
        l+R8WvC8JNEYe/MZTXiNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672250561; x=1672336961; bh=c7NmyHHySc4TjiTj5MpYoylB3a/6
        CpCUH0DjRLdd1lU=; b=G08Uqk4JD2HKMOsIYHW1j6f5WHpI4b6VPMipox68x9t+
        Dsgjq3lwh3b2TZxrUQ/Wt4jU6ZkYauJA9ZRPES/AFA0HXDxuUm/rMEdNALk+wPXF
        gT+L5t2ukQaPqOzuTLungjFipvHE1lupmRpKiqalgkDbwaMawjmbCE1Vz8/zsd6m
        CCINFlaznifdI9E77xFxngtcjp00ZQqWuX8kY5pihVA4OHhJruShMFdr6A1fldMF
        2Ak7tSziw0YQws3EfKgWmlJO1MNCt4y0Ew+MNjJvrQ9F9YbJWVJkmLS6vehtk1Jc
        rSbxYuX/Zi+HnEuE7W7r6RpPdwsGd08b8N5WhLL3YQ==
X-ME-Sender: <xms:wYSsY9cpR5iT9ExQsZn84DS25qtEfYjVqsqSpwKGXs4kPp3nA67YTg>
    <xme:wYSsY7MWDhJFDXndWqGpJyLFzh0NRwKCXTE-u-Kj-prIdrgTLCR1auJ1Ogq2vn96e
    kRO8zj7J3Iq6k0>
X-ME-Received: <xmr:wYSsY2jUyHa5Lz3p6VSdFa-srRY2a9lKM4f60YQKAX71J9wusw_BPqHrNwSm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpeffvghmihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghm
    ihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrh
    hnpedvjeetgeekhfetudfhgfetffegfffguddvgffhffeifeeikeektdehgeetheffleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmih
    esihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:wYSsY29MG0dofwNMNTPH0v7ExPp2SQKxzWfWfXkHHPi4PzPBA3cHjg>
    <xmx:wYSsY5sJ48EVau6xxv4IHpP0SjyQCi2eKUvAjhw9JQX0KKGHrfYnfA>
    <xmx:wYSsY1H1Fk5xtDtxXDcVplxNdvdcG9wjhtI1CyT8ZfMM2l2lsz4WsQ>
    <xmx:wYSsYy6PbWaeFjq6DmwZEz-6Bos1hmZOulAPMtXNU64UufNMx9DqIg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 13:02:41 -0500 (EST)
Date:   Wed, 28 Dec 2022 13:02:35 -0500
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     oss-security@lists.openwall.com
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Message-ID: <Y6yEv+6iYQQNaqi9@itl-email>
References: <Y6SJDbKBk471KE4k@p183>
 <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca>
 <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
 <Y6xzIR9P+a6uaaEx@itl-email>
 <20221228172517.l7h3m7wjfpxr3dzw@mutt-hbsd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h7PZ10vsTAyj4PIA"
Content-Disposition: inline
In-Reply-To: <20221228172517.l7h3m7wjfpxr3dzw@mutt-hbsd>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h7PZ10vsTAyj4PIA
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Dec 2022 13:02:35 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: oss-security@lists.openwall.com
Cc: Alejandro Colomar <alx.manpages@gmail.com>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly

On Wed, Dec 28, 2022 at 12:25:17PM -0500, Shawn Webb wrote:
> On Wed, Dec 28, 2022 at 11:47:25AM -0500, Demi Marie Obenour wrote:
> > On Wed, Dec 28, 2022 at 10:24:58AM -0500, Shawn Webb wrote:
> > > On Tue, Dec 27, 2022 at 04:44:49PM -0800, Lyndon Nerenberg (VE7TFX/VE=
6BBM) wrote:
> > > > Dominique Martinet writes:
> > > >=20
> > > > > But, really, I just don't see how this can practically be said to=
 be parsable...
> > > >=20
> > > > In its current form it never will be.  The solution is to place
> > > > this variable-length field last.  Then you can "cut -d ' ' -f 51-"
> > > > to get the command+args part (assuming I counted all those fields
> > > > correctly ...)
> > > >=20
> > > > Of course, this breaks backwards compatability.
> > >=20
> > > It would also break forwards compatibility in the case new fields
> > > needed to be added.
> > >=20
> > > The only solution would be a libxo-style feature wherein a
> > > machine-parseable format is exposed by virtue of a file extension.
> > >=20
> > > Examples:
> > >=20
> > > 1. /proc/pid/stats.json
> > > 2. /proc/pid/stats.xml
> > > 3. /proc/pid/stats.yaml_shouldnt_be_a_thing
> >=20
> > A binary format would be even better.  No risk of ambiguity.
>=20
> I think the argument I'm trying to make is to be flexible in
> implementation, allowing for future needs and wants--that is "future
> proofing".

Linux should not have an XML, JSON, or YAML serializer.  Linux already
does way too much; let=E2=80=99s not add one more thing to the list.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--h7PZ10vsTAyj4PIA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmOshMAACgkQsoi1X/+c
IsFRcRAAyi/536j5gBlVkcg6xT9EIcHZq2MRXB1xoJuKa5bRWIH6vBDgH924yy7i
gSNF0CfemdwbPvI/SCF5E+MdJJPzYlb1cyZe8faDey92XGKadi7w61YQSZT/sLT5
Oa66GmF+BcPi5v7wPArP8dOXHItwG7nazKZehsWcWk6pX2TBW6xvVBgmjQlDXNFM
KdgeSKnD6nBr3ehkr1u3U8FdTCoy1x7+3M7aZDQsho23gJ2EGLZP4tEMrJuhU6ny
gMCM0GVvLJhEbw7cpV+2qCDs9nGEIuma99RXHYQq5gzjIQD7X+FbWpa75KigpS7a
nDB/ZdY8DJ4sychM1/GqSqckrOoazq8kTQHrF3BbOHFZ5NUMiPK9BPO18x76DfuY
L/gzOxeZmmu0bq0WUBJQg/vlmvAINZTw3C6j9q5P9HPOb1DbiMVJbk0XJ6GplSNL
W7BN6bHHsKa05QGXzF7j6Kk2BBnyzXDKzIgkexP+pDR5ZTyKkijQGxIOdTV5qO4R
DfcpQAGX5x2R2kxD8jtMt1d+Nky1/lziX0n9+nXo0OO6uevjDrj0aPY+01N9OGM2
rqqscUS9mUuT8v/5+1CkNhl0G009b673iKyZVN9QM7MhGMypwQJ6IMS8hRgFcqjl
XFanvw16iKAKxSRt2s1bckswJ/TlXNsGwjvAJreboDybPHBpewY=
=Wdo0
-----END PGP SIGNATURE-----

--h7PZ10vsTAyj4PIA--
