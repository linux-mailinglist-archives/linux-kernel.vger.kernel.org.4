Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC31658660
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 20:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiL1TYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 14:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiL1TYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:24:42 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F35213EB6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 11:24:38 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id x65so2861313vsb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 11:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hardenedbsd.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQoSPV/1oOCa8cF4Ca8Amt2eQFnSyvUDA4BmxDEFR+w=;
        b=kIAmp8g/mEVi078s384yPgoXQvrA3mRa1XYHXxSOJDxEkuRxmjWy6JnVDv+rSkC5Cy
         0DUwDdB1bSP5DbelGgaMTIpaMKagza7eCPCU9Fa80nmpaCXBihPM9u+txr/UwhrVZBT1
         1I/E+PJ3yvAzx5ZSFRqbRzEON7RweLfIqlQiTAq6buKurVxF9AzBpGxOJsscmpwIuarM
         fDUk6ZomH64X4SrwgIW0kSHfY33Qwbj74mckd4TKZSBVZJ/nFuN0X+lJCWcxzYfqr/kF
         RdSAWLkcKSk7QeplI2BpJ9cVewKW4q2voiiIntzUD4hgT64wvHc7bDC009VjTzIg2Oss
         Pytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQoSPV/1oOCa8cF4Ca8Amt2eQFnSyvUDA4BmxDEFR+w=;
        b=wWke1hw391quaQlzt5xD54HUNJD+LTDPCkYYNxBYLSQCNUjTab++zeZvGNgXc9y2PH
         Ssr6aEhISRLMMK6bvesqcJms+fbfBuR8Sfm1gJ0HZbQ3bB0iDIkkTWWZBmim+z0Q6Xlj
         NY9bwD2q3aXPDijnPL2kxIhfHSn/2u/LBOvDPWiWlNoCBkkY1XBPtCZmC7eW7/VPWYPP
         dgcBDGdAf5L+cqivWt0ze7vYi5bOJNNm9vDvJuy8ez+V85WoGF70lBBd3lv+lh0HtVIh
         gXN/VPkVQHFmKcY6NACji9+IvTeAftj7a8BsOE28L4cMrrVFRt25WqWcX8Geb9b26O+l
         GQMA==
X-Gm-Message-State: AFqh2krt2Uc4lm0Cnm3YDialh6jN0iLjcfs+1TCwLJyWvgpTblGLbU9W
        UcSNKMFrylZy1ZlHltMpVhOVshsEYDBaUPQN
X-Google-Smtp-Source: AMrXdXum8fPc3sjwaK/zW/xv//enj22K0WAIsRX0JtKDbvNzJgE95zxm9bniqRvhIYwLpgGtgczLcA==
X-Received: by 2002:a05:6102:52c:b0:3cb:bb2:7d37 with SMTP id m12-20020a056102052c00b003cb0bb27d37mr1614387vsa.33.1672255477254;
        Wed, 28 Dec 2022 11:24:37 -0800 (PST)
Received: from mutt-hbsd (pool-100-16-219-215.bltmmd.fios.verizon.net. [100.16.219.215])
        by smtp.gmail.com with ESMTPSA id bj4-20020a05620a190400b006fa2cc1b0fbsm9227728qkb.11.2022.12.28.11.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 11:24:36 -0800 (PST)
Date:   Wed, 28 Dec 2022 14:24:36 -0500
From:   Shawn Webb <shawn.webb@hardenedbsd.org>
To:     oss-security@lists.openwall.com
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Message-ID: <20221228192436.viuoyil2ntr4lxjo@mutt-hbsd>
X-Operating-System: FreeBSD mutt-hbsd 14.0-CURRENT-HBSD FreeBSD
 14.0-CURRENT-HBSD 
X-PGP-Key: https://git.hardenedbsd.org/hardenedbsd/pubkeys/-/blob/master/Shawn_Webb/03A4CBEBB82EA5A67D9F3853FF2E67A277F8E1FA.pub.asc
References: <Y6SJDbKBk471KE4k@p183>
 <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca>
 <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
 <Y6xzIR9P+a6uaaEx@itl-email>
 <20221228172517.l7h3m7wjfpxr3dzw@mutt-hbsd>
 <Y6yEv+6iYQQNaqi9@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cqcy4xsopj5osl73"
Content-Disposition: inline
In-Reply-To: <Y6yEv+6iYQQNaqi9@itl-email>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cqcy4xsopj5osl73
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 01:02:35PM -0500, Demi Marie Obenour wrote:
> On Wed, Dec 28, 2022 at 12:25:17PM -0500, Shawn Webb wrote:
> > On Wed, Dec 28, 2022 at 11:47:25AM -0500, Demi Marie Obenour wrote:
> > > On Wed, Dec 28, 2022 at 10:24:58AM -0500, Shawn Webb wrote:
> > > > On Tue, Dec 27, 2022 at 04:44:49PM -0800, Lyndon Nerenberg (VE7TFX/=
VE6BBM) wrote:
> > > > > Dominique Martinet writes:
> > > > >=20
> > > > > > But, really, I just don't see how this can practically be said =
to be parsable...
> > > > >=20
> > > > > In its current form it never will be.  The solution is to place
> > > > > this variable-length field last.  Then you can "cut -d ' ' -f 51-"
> > > > > to get the command+args part (assuming I counted all those fields
> > > > > correctly ...)
> > > > >=20
> > > > > Of course, this breaks backwards compatability.
> > > >=20
> > > > It would also break forwards compatibility in the case new fields
> > > > needed to be added.
> > > >=20
> > > > The only solution would be a libxo-style feature wherein a
> > > > machine-parseable format is exposed by virtue of a file extension.
> > > >=20
> > > > Examples:
> > > >=20
> > > > 1. /proc/pid/stats.json
> > > > 2. /proc/pid/stats.xml
> > > > 3. /proc/pid/stats.yaml_shouldnt_be_a_thing
> > >=20
> > > A binary format would be even better.  No risk of ambiguity.
> >=20
> > I think the argument I'm trying to make is to be flexible in
> > implementation, allowing for future needs and wants--that is "future
> > proofing".
>=20
> Linux should not have an XML, JSON, or YAML serializer.  Linux already
> does way too much; let=E2=80=99s not add one more thing to the list.

Somewhat agreed. I think formats like JSON provide a good balance
between machine parseable and human readable.

As I described earlier, though, when it comes to concepts like procfs
and sysfs, I have a bias towards abandoning them in favor of sysctl.
If sysctl nodes were to be used, no new serialization formats would
need to be implemented--and developers would also use a safter method
of system and process inspection and manipulation.

--=20
Shawn Webb
Cofounder / Security Engineer
HardenedBSD

https://git.hardenedbsd.org/hardenedbsd/pubkeys/-/raw/master/Shawn_Webb/03A=
4CBEBB82EA5A67D9F3853FF2E67A277F8E1FA.pub.asc

--cqcy4xsopj5osl73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEA6TL67gupaZ9nzhT/y5nonf44foFAmOsl/MACgkQ/y5nonf4
4fruEA//dlGqPyMLJmcW57PIEZ2w6Y/ctFuHGK1vfHncR7lDgTCgjQICFSqnVLt3
PyESWAmZus4ZqneCmReoxzy6y/io4jyRWcEZEywcRk/n+asD5+5eEcL8yKdCXszF
FLL9VGA1U4jUnQuUQgArkpjo7pNNScp34FjKRKD0RJKbpKDNGPcTz2ASMpM4vt7n
9klfnjP7e7+XD9cuZaNQVK0nz2/BNObKGdikJR9cMv3SONkGTOlRZxOj+y2Rc86P
QpSmfMC+PJxULFSfIW4bucmnzC2qQenTELgoEUEhG4IZNT3VYv1mDRKU9xlVeSvQ
Pcm6JcFQxd759On8QW1aY4N9KGs6U7hH0elQkNxBctM3Nh9YowNxZGXuZGF9Kwu1
Vyw9tDADZiMh0GqXgO9tSwc95kcVdeUgIzwBhF31YhSNv95CpDwdtQhvmt2qTXea
Zec8Ys0hNcvd5xn8FLIk73m+yvNkTBEkyejo/cyQZFHW/gQmf5znozMht0qeYt/j
9Na9M094IX1zLLy3dMlNZe1j7pzBsRJgbWBwWcmixkao2pJ7vLuocQjDJmrpet2Q
wkkSKSRDw33S7fRZxKJClXeP1agiTxgpnC3Hi1mmmWVff900O6xTrMl6tds6c8CY
EP6VZqmBqlNBAP2yGTGPFXLVm91UV5DvHZ1VdAfSZukqq6rCIU0=
=jiq0
-----END PGP SIGNATURE-----

--cqcy4xsopj5osl73--
