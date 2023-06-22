Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5573A86E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjFVSng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjFVSne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:43:34 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57FE1FFC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:43:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2BF9D3200935;
        Thu, 22 Jun 2023 14:43:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 14:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687459412; x=1687545812; bh=eBehM+By9caRLN1To9jpxpV1YmtkZ9cdehs
        yjMSmcT8=; b=gB/SYAPTnJxEdyg0FJl/nqw57HV1pe4+VudP0ghdc4fq2CzgPah
        qMirdHdSoJso86qPcsIMmfmU1tC/HHy82grih+D5WmKBsPK49OkQKJ5JU4/OZ/1E
        k/Y9h8QYyl85BcD/G8vuQPxs5/ubJud0sZILO+8UrhJaENfDBfB2/4MY4XgScKf+
        MmAvdfYnQJ4xcqJKbRdkHNmlVGnFaq3k+SdKv0xRo4Z0O0TuDqUL2qkYuPX+ZtiP
        T3w4IqbSUZrpt9BcCtcupewGlYafMfYLoT5etmHNAVHgNWXbcgavK0kGBwX2Pr++
        MtyVieWHZ92Y9oxfSkrOEdKhh64fEzQDMWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687459412; x=1687545812; bh=eBehM+By9caRL
        N1To9jpxpV1YmtkZ9cdehsyjMSmcT8=; b=Bo3ilMKdlBQ30diAF4nCu/PBMxkHP
        i86bAbjd+FDPno9WTgIQVUO9jmffNeemfHvNmYhlIqYT2/Sku6+cgR5/n1VNx1he
        K4+vkAgZbYsOSUB3rGazGdljdp7vO0vbe1llDmKEfuyuM/+mhgJXGhyjkoVBunE6
        GG1ITE1GQS7uuaS5OjC91NCaO+SVP6Nexg99ugzz/VTZEHcjOuk8V1s99fKci/Ba
        zcqAL1MJR/RJFc/QqFgZ3zW2G3ZDovStxMMMxiUSoWBiKF7jwdB7S0JXmsdknWvv
        nVhNYK5o1sZhUUxnZ4ta0v6jxXsOGxDdYyblv570/SruPYeTuRyOznoDg==
X-ME-Sender: <xms:VJaUZAem5FStipcU4FIi_BsGmMDixLfqyIjbElUyEwzIx_ivcSO2Ww>
    <xme:VJaUZCMX7_pZu1-JGZmV7xoh2hN4CVykgAy62J8Q7zhrC7QKR3ct-fMWXyau28gnp
    QdttDSDcZ2OvR8>
X-ME-Received: <xmr:VJaUZBikOkyrJ1sOruQgIvalg-AIk6lVqrZf5n1G5MdrBDvqTuGc3QLvEQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeefkefgkedvtefguedtffejlefh
    leetveekhefgfeetvefgtdektedtkeeuiedtfeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    uggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:VJaUZF_aaH81Hbvd9uYqol3HLHWL-SBKPMYsQvxX382EVMwbavxWaQ>
    <xmx:VJaUZMsYrmHgkoZaIO5j3SSnP0mtdXw6OS4vFdUhcagGv-eyTemiew>
    <xmx:VJaUZMGMcWdGr4RFDBAdzeBerU6AEAy_4CAB-sFuuBnwAOgoUEdcFg>
    <xmx:VJaUZJUyNzhawX-eN0FgMbBN1qraifSlCy9WYseNebYNZFdu-1PbDQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jun 2023 14:43:32 -0400 (EDT)
Date:   Thu, 22 Jun 2023 14:43:29 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] device-mapper: Avoid double-fetch of version
Message-ID: <ZJSWUpKSCrxmGfqt@itl-email>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
 <20230603145244.1538-1-demi@invisiblethingslab.com>
 <20230603145244.1538-5-demi@invisiblethingslab.com>
 <ZJR02A79ljoUjbFl@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w81VBFPtBLle1co8"
Content-Disposition: inline
In-Reply-To: <ZJR02A79ljoUjbFl@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w81VBFPtBLle1co8
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2023 14:43:29 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] device-mapper: Avoid double-fetch of version

On Thu, Jun 22, 2023 at 12:20:40PM -0400, Mike Snitzer wrote:
> On Sat, Jun 03 2023 at 10:52P -0400,
> Demi Marie Obenour <demi@invisiblethingslab.com> wrote:
>=20
> > The version is fetched once in check_version(), which then does some
> > validation and then overwrites the version in userspace with the API
> > version supported by the kernel.  copy_params() then fetches the version
> > from userspace *again*, and this time no validation is done.  The result
> > is that the kernel's version number is completely controllable by
> > userspace, provided that userspace can win a race condition.
> >=20
> > Fix this flaw by not copying the version back to the kernel the second
> > time.  This is not exploitable as the version is not further used in the
> > kernel.  However, it could become a problem if future patches start
> > relying on the version field.
> >=20
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > ---
> >  drivers/md/dm-ioctl.c | 30 ++++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> > index da6ca26b51d0953df380582bb3a51c2ec22c27cb..7510afe237d979a5ee71afe=
87a20d49f631de1aa 100644
> > --- a/drivers/md/dm-ioctl.c
> > +++ b/drivers/md/dm-ioctl.c
> > @@ -1873,30 +1873,33 @@ static ioctl_fn lookup_ioctl(unsigned int cmd, =
int *ioctl_flags)
> >   * As well as checking the version compatibility this always
> >   * copies the kernel interface version out.
> >   */
> > -static int check_version(unsigned int cmd, struct dm_ioctl __user *use=
r)
> > +static int check_version(unsigned int cmd, struct dm_ioctl __user *use=
r,
> > +			 struct dm_ioctl *kernel_params)
> >  {
> > -	uint32_t version[3];
> >  	int r =3D 0;
> > =20
> > -	if (copy_from_user(version, user->version, sizeof(version)))
> > +	if (copy_from_user(kernel_params->version, user->version, sizeof(kern=
el_params->version)))
> >  		return -EFAULT;
> > =20
> > -	if ((version[0] !=3D DM_VERSION_MAJOR) ||
> > -	    (version[1] > DM_VERSION_MINOR)) {
> > +	if ((kernel_params->version[0] !=3D DM_VERSION_MAJOR) ||
> > +	    (kernel_params->version[1] > DM_VERSION_MINOR)) {
> >  		DMERR("ioctl interface mismatch: kernel(%u.%u.%u), user(%u.%u.%u), c=
md(%d)",
> >  		      DM_VERSION_MAJOR, DM_VERSION_MINOR,
> >  		      DM_VERSION_PATCHLEVEL,
> > -		      version[0], version[1], version[2], cmd);
> > +		      kernel_params->version[0],
> > +		      kernel_params->version[1],
> > +		      kernel_params->version[2],
> > +		      cmd);
> >  		r =3D -EINVAL;
> >  	}
> > =20
> >  	/*
> >  	 * Fill in the kernel version.
> >  	 */
> > -	version[0] =3D DM_VERSION_MAJOR;
> > -	version[1] =3D DM_VERSION_MINOR;
> > -	version[2] =3D DM_VERSION_PATCHLEVEL;
> > -	if (copy_to_user(user->version, version, sizeof(version)))
> > +	kernel_params->version[0] =3D DM_VERSION_MAJOR;
> > +	kernel_params->version[1] =3D DM_VERSION_MINOR;
> > +	kernel_params->version[2] =3D DM_VERSION_PATCHLEVEL;
> > +	if (copy_to_user(user->version, kernel_params->version, sizeof(kernel=
_params->version)))
> >  		return -EFAULT;
> > =20
> >  	return r;
> > @@ -1922,7 +1925,10 @@ static int copy_params(struct dm_ioctl __user *u=
ser, struct dm_ioctl *param_kern
> >  	const size_t minimum_data_size =3D offsetof(struct dm_ioctl, data);
> >  	unsigned int noio_flag;
> > =20
> > -	if (copy_from_user(param_kernel, user, minimum_data_size))
> > +	/* Version has been copied from userspace already, avoid TOCTOU */
> > +	if (copy_from_user((char *)param_kernel + sizeof(param_kernel->versio=
n),
> > +			   (char __user *)user + sizeof(param_kernel->version),
> > +			   minimum_data_size - sizeof(param_kernel->version)))
> >  		return -EFAULT;
> > =20
> >  	if (param_kernel->data_size < minimum_data_size) {
> > @@ -2034,7 +2040,7 @@ static int ctl_ioctl(struct file *file, uint comm=
and, struct dm_ioctl __user *us
> >  	 * Check the interface version passed in.  This also
> >  	 * writes out the kernel's interface version.
> >  	 */
> > -	r =3D check_version(cmd, user);
> > +	r =3D check_version(cmd, user, &param_kernel);
> >  	if (r)
> >  		return r;
> > =20
>=20
> I picked this patch up for 6.5, please see:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.gi=
t/commit/?h=3Ddm-6.5&id=3Dc71878e9982075eab2e9f6dc5a09ba7b60ac1e24

That=E2=80=99s great, thanks!

> But FYI, I folded these changes in:
>=20
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 526464904fc1..b58a15e212a3 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1838,6 +1838,9 @@ static int check_version(unsigned int cmd, struct d=
m_ioctl __user *user,
>  {
>  	int r =3D 0;
> =20
> +	/* Make certain version is first member of dm_ioctl struct */
> +	BUILD_BUG_ON(offsetof(struct dm_ioctl, version) !=3D 0);
> +
>  	if (copy_from_user(kernel_params->version, user->version, sizeof(kernel=
_params->version)))
>  		return -EFAULT;
> =20
> @@ -1885,7 +1888,7 @@ static int copy_params(struct dm_ioctl __user *user=
, struct dm_ioctl *param_kern
>  	const size_t minimum_data_size =3D offsetof(struct dm_ioctl, data);
>  	unsigned int noio_flag;
> =20
> -	/* Version has been copied from userspace already, avoid TOCTOU */
> +	/* check_version() already copied version from userspace, avoid TOCTOU =
*/
>  	if (copy_from_user((char *)param_kernel + sizeof(param_kernel->version),
>  			   (char __user *)user + sizeof(param_kernel->version),
>  			   minimum_data_size - sizeof(param_kernel->version)))

Those changes indeed make the code better, thanks for including them!
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--w81VBFPtBLle1co8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSUllIACgkQsoi1X/+c
IsHGaw/+OBQ6qqQ+9bo9YQkg1nj6MfuKLh81ZlnTdR/VEjDch6hEcnYeeVf8jctF
x0QcB8odZp9ASSiwYn6pkWj3ZlXhfoQUeG+zSYZdOtMa+bao1ddEpqsBU5vPTex+
uMHHTm9SVMQKAGbA/rcY+iKamz9lM6qSGgMcopmVlWYD+76yQ2b5HocNDQZhtEGI
qeACZe8BlGlRhBN2os339ZllG8BeFx9xYU1AXLiJ6IjsUicOWdM1D8mQ1km7yhCE
MNPMxvHAPe3jPLPjK+ZkoFtqn74i8ijI9gIxhTaeNr1ZSt8PvNm/FnKOgf+Ap4/o
456us8OpKy5dflgzXmIFj8Ai0/yfbl54dBijOUKhJtqt7sLsWpxRHSLlIWQxZYv0
8XccQqzGdDKOKSJs6tzC22UD4ZKuV0hD9BfZ8iq6WOOvzZQOFe89E4bugEMkeSpO
XuzDrVdHkOXCLfWXAdOF2ty4xTCKh6Rr/PURsSin/NXathb1F50j47JBRGrTHqIC
iQ700EwDo3ituhp2JcAiaBKA5SpVfNL4j2js5MeeMr/TDdK/sJL9v07e79B7Qgn/
2U/EAE4aq8sdfF/jFjduZWR2Suv0EqeZAyynIchm2fFP7BASCxQwc1gG0JXoH/2J
sfPwCECoTvkwjiBHhZVoSf4f5zkbjdr0TWdf0tgDcm+oVL7I/Xw=
=Vywc
-----END PGP SIGNATURE-----

--w81VBFPtBLle1co8--
