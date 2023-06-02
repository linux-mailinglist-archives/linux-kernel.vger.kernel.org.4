Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E71720235
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjFBMhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjFBMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:37:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F91C13D;
        Fri,  2 Jun 2023 05:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D25E65009;
        Fri,  2 Jun 2023 12:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED292C433D2;
        Fri,  2 Jun 2023 12:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685709452;
        bh=4s8OXtoTbJZD/v1ujaQ7NAJywfgyjstSkB61QAt8a5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OjNCw0sWr9gg7Sf0CWsGrIRa2SRJdYq+z4pNxBJnUqq/1PW40XJt0GwlK6EX3VDKs
         r9S7ibfAoItZHchH337EBcrKbsMEbCNlIamufbI2oMjw/5v9sRujJyS2YOTE8PrgJC
         8gINrO/Y6ykfuyE5sVVC9JekLLIc81YFu98Kg2Q5rFFDrO0bMRW4/3ukDlbW5HHGhD
         oFJuZh+ZY36vlW0JKaBu5U9mKZDay3XM/In9hP4FLgd9csO12EnOIrhq71CAj7RHP3
         d0PfXP+Fx17XaRPq4464opR61hB87JC6KZhKOYVPTstecb064BDqriv6SfeRJPzTqy
         Y4LWOQ4TqP8Uw==
Date:   Fri, 2 Jun 2023 13:37:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use
 PROBE_FORCE_SYNCHRONOUS"
Message-ID: <1bc79c48-7cba-476d-9a7e-5754a88fcdae@sirena.org.uk>
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
 <552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org>
 <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
 <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
 <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
 <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
 <CAMi1Hd1WCtNvNaY_kVMx5F8T0nMVHvsjk9LsSETCMWWQyaq_Vw@mail.gmail.com>
 <CAD=FV=W5Y_SHp0y2MEs8d1k255bm_PXdRYEmYei+g79pjnzYuA@mail.gmail.com>
 <CAMi1Hd2OeL940r7jq0=Z_oxE8MYVioy0YnJXQC_5e0vJONd2sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PaqPH2sNW6kiPPjU"
Content-Disposition: inline
In-Reply-To: <CAMi1Hd2OeL940r7jq0=Z_oxE8MYVioy0YnJXQC_5e0vJONd2sQ@mail.gmail.com>
X-Cookie: War is an equal opportunity destroyer.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PaqPH2sNW6kiPPjU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 01:00:52PM +0530, Amit Pundir wrote:
> On Thu, 1 Jun 2023 at 19:35, Doug Anderson <dianders@chromium.org> wrote:
> > On Wed, May 31, 2023 at 11:11=E2=80=AFPM Amit Pundir <amit.pundir@linar=
o.org> wrote:
> > > On Wed, 17 May 2023 at 02:54, Doug Anderson <dianders@chromium.org> w=
rote:
> > > > On Tue, May 16, 2023 at 11:12=E2=80=AFAM Amit Pundir <amit.pundir@l=
inaro.org> wrote:
> > > > > On Mon, 15 May 2023 at 20:33, Doug Anderson <dianders@chromium.or=
g> wrote:
> > > > > > On Mon, May 15, 2023 at 7:42=E2=80=AFAM Amit Pundir <amit.pundi=
r@linaro.org> wrote:
> > > > > > > On Sun, 14 May 2023 at 18:11, Caleb Connolly <caleb.connolly@=
linaro.org> wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > If you reorder the nodes in the device tree, I think it'll change the
> > probe order. Does that affect anything? I'm wondering if there's some
> > sort of delayed reaction from a previous regulator.

> Hi, Bumping lvs1 and lvs2 regulators up to the top of the list in the
> DTS https://bugs.linaro.org/show_bug.cgi?id=3D5975#c4 does seem to work.
> I can't reproduce the crash in 125 reboots so far, while I'm still
> testing with only qcom-rpmh-regulator kernel module. I'll do some more
> testing with full system running and send this re-ordering fix I can't
> reproduce the crash further.

So whatever the issue is here it's a timing/race condition - this seems
like a workaround which works just now but it's not getting to whatever
the actual issue is and that could come back.

--PaqPH2sNW6kiPPjU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR54oUACgkQJNaLcl1U
h9BRGQf+NorZBDSfdJgfTx9UsVuZ3dRz/Z4NE1+GHwiFHctMiMjKkdVWR+fPAJu5
c3CAbS2UqbaLhZYurNvm9vh+nYXObI1FdbI8hjvh2im1kr3697WK7FiJ/E/I2D+/
5MfZmD1/vl2tazXkv9q0/Bl6tQdsv64G8QBFVkl27JNFRGVl+JTwjsZYowDIygHu
Jani44nVfJQkZQVRufbbpAYjghJepJPAvhRYf05Gxe4R+EZMTGgle03esHeC/8yP
nrj0ASpBRE6XOvP077EydxPl/HU/GD32vBpwItEoJ7uqtfKKhDoYg6pIAVXC5B3a
mDoTPoNymnCIubnX+/uu0azhyRC4rg==
=cVsb
-----END PGP SIGNATURE-----

--PaqPH2sNW6kiPPjU--
