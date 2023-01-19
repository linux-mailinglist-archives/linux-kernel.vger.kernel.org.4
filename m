Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5156733AE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjASI3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjASI3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:29:34 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801CB4B4A6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:29:24 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E29065C0046;
        Thu, 19 Jan 2023 03:29:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 19 Jan 2023 03:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1674116963; x=1674203363; bh=J7
        tU+IG41sGbrGJxFhVsXzXkGTETH/yClz9JTE7BPK0=; b=oP1uP1ofoKtrBhikJJ
        H/iyFmRXBi790tp4NGKpMWeX4WucWyDGQTY8WSZv71gkX6O6l4riG1VokZ4A5goj
        Cbk9CwXNTtk3aD7NV9rDsnAB6qbILYoL1RIUCeMuazg89dx0YOSxPr/LKLcmtKVt
        f5ek9qtj5bkTbBxzrGFBgngLrgjR426CFtfE43tHDKeP4D5Rmy2F4imyOtpHGcxp
        LTml3nvnE5qPMzp8VEnUrhoH97XEYyaKY0ZoHOoA8rlQQDwdXgnYR6I4OAmlKRYh
        vv14njMrF+UkN8pN4Dt7d+rBkASzaElU0b7eRQ9OW+RLOU+mmvv1LhXg3fXcpVrT
        4l+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674116963; x=1674203363; bh=J7tU+IG41sGbrGJxFhVsXzXkGTET
        H/yClz9JTE7BPK0=; b=PZzX7Q1lQH3z0tCWemwbV6QNNvfU93en+QqkPPf+7qq+
        0tCnE3J3B/gnpWJijqq9fKvCgkV2s52Dxhhej9z1VHGrkRZZ0Olt9FXkxVsQp8Rn
        h4y55uzfhxE6alOu9e1CYLoWNJmrNDM+7aiFNrs3uVuRFHjHI/l8Zd5YM16xH+g1
        /X2W/UoAJgqWU7N4DmbdZiBT1JkX2l6k7pcpKcBpuKvm3lkwQTSIhXmqnZ+jHi0j
        9qrkMA5dcI2LEzGPzwbs1xwZFnpvnszS3JDwY/zmNF76b9FSp0E1aiuScBSOl9Yx
        Dbg5pQlO0LOUvM4jH2vzcIiCkJUJ5h9ssIEQ4X4W2Q==
X-ME-Sender: <xms:Y__IY2fMYE3RETmvP6T5ShCZfEQcvsZaB24rvu_iNO-bGyK-IeFFRg>
    <xme:Y__IYwOuxfJ2dflGCcSEjge56QF_lkxGfZ6XcdA0hzmyavcPVtaFtqay8cZs33DBj
    mku73u4rkOJkd1waqk>
X-ME-Received: <xmr:Y__IY3ghpvSeSFikhvzlWs8qXvrXKX39g-AOI39uKsOQW-jgXzVFSogqtFu9Q0wGAcJkOaw224EB57lZBBAnMFOJMA265A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtledguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
    uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
    htthgvrhhnpeeggfdvgffgveetueeuffduueejtedvleektdffvdevleejtdejtdfhvdel
    vdfgtdenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:Y__IYz98UZwJ5WwHffjHulyz4lL1NeTkMChWgjrOZyQtzTXClzE2bg>
    <xmx:Y__IYytFqiwYcRpezEWwGaO0ABoKxK9_XG9ye2yVbSpj0krMNtZ9Ow>
    <xmx:Y__IY6GxLo0knAwCPtVXZx5lK3LBa_NHtPxBVTWMVNeC03g5Dfnzfg>
    <xmx:Y__IYwBYgMx6U3a6_ow2E7YoOaV5TGvSoiHeL1fANc1b93B3kg8OCQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 03:29:21 -0500 (EST)
Date:   Thu, 19 Jan 2023 09:29:20 +0100
From:   Klaus Jensen <its@irrelevant.dk>
To:     Martin Wilck <mwilck@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression on aarch64? panic on boot
Message-ID: <Y8j/YLA9O7Q+haE/@cormorant.local>
References: <Y8XINx8fpGPKudW6@cormorant.local>
 <20230117055819.GB13795@lst.de>
 <Y8ZA30EoAFaFPwVC@cormorant.local>
 <20230117063735.GA14468@lst.de>
 <59599137a9556355cb43563a4fbcc05b0fe769b4.camel@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/wMxtvFL3yVWbTgo"
Content-Disposition: inline
In-Reply-To: <59599137a9556355cb43563a4fbcc05b0fe769b4.camel@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/wMxtvFL3yVWbTgo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 17 13:11, Martin Wilck wrote:
> On Tue, 2023-01-17 at 07:37 +0100, Christoph Hellwig wrote:
> > On Tue, Jan 17, 2023 at 07:31:59AM +0100, Klaus Jensen wrote:
> > > Good morning Christoph,
> > >=20
> > > Yep, the above works.
> >=20
> > Context for the newly added: This is dropping the newly added
> > PROBE_PREFER_ASYNCHRONOUS in nvme, which causes Klaus' arm64 (but not
> > other boot tests) to fail.=C2=A0 Any idea what could be going wrong the=
re
> > probably in userspace?
>=20
> If this is an aarch64 userspace issue, maybe related to
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D107678 ?
>=20
> That bug causes segfaults of user space programs if for some reason the
> unwind code is invoked. It happens only if libgcc_s.so is compiled with
> gcc 13, and the pauth CPU feature is enabled in qemu.
>=20
> Martin
>=20

I just observed the same panic on qemu emulated ppc64 as well. It's
pretty rare, maybe 1 in 20. 'rootwait' or removing the the prefer
asynchronous probe fixes it as well.

--/wMxtvFL3yVWbTgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPI/18ACgkQTeGvMW1P
DelXYAf9H5/rtUW2fNjGQYkeNQY3NOPT2QtRx6Ix2uuwGaM5ICTJCK97IE7ZMCZ9
yAIgFKDJc9Cyho+FnlzmTWYWVxIXDoQQktj3fUrFSRajxRBzVTJynC8m9O0We6cm
YBJvPxpfjOfst5SAq3PVjTX6r88xd4FPfbm0r11efWp0U0egEt6HpeUFA1hnPjoL
jsH062D2VVDEAM5pi2tSeKbWi1CLt5pN+aC16Q64x3zQUcTjh1T/QHGPii0Gjjsh
ds0d3lZA4WGUstS+ufRtZno+wQt/qW8lekGBidIaAmuUhVpupbaOzirNkNc8FGGR
5/YSRyr/+v4A3Z7tNo5hp36wfB/yQw==
=cc4b
-----END PGP SIGNATURE-----

--/wMxtvFL3yVWbTgo--
