Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7382B5F6FF3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiJFVIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiJFVIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:08:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADB5C14A3;
        Thu,  6 Oct 2022 14:08:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mk3vM33ZQz4xFv;
        Fri,  7 Oct 2022 08:08:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665090513;
        bh=tBh7R6EFNvNHC472p+hpxdozssjAKs0uoyZ2/Iz5m7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lEZ1s/HQiOR9m8FWwvlBEaEksytuS4VvE0NaNWxJyYQUqlyvAgZV9TvsHaf8jc+0F
         TMbVyFcXYBIBH1GRM2dfDclqp0olE3JhdqgiOlM02TBf3ifpLxwe0y7qgBco6xYr//
         TrnyLkwtS7pFp5fKipMYaYCoYsWSo+suiCDC9y9tvJ370eCjGwKA2+BxDQBi92NFoP
         xx9AyE7ttg86rcV5lvlsAyfUHOcWzEE8lyMK4ghfM5X0MtyVxfVn4yYOn/wFCH+qR0
         BSBfEKgW9sOOF+2Z7+us9y+wJu/NzsOI7BQe581i8o1E1N38oqDfsKdSW8ypePg/ce
         2LEnAms0O1R8w==
Date:   Fri, 7 Oct 2022 03:52:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Airlie <airlied@redhat.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: linux-next: build failure after merge of the drm tree
Message-ID: <20221007035244.46e258a3@canb.auug.org.au>
In-Reply-To: <CADnq5_N1cZiG39KzUzdHCtLRRCipMMNXjaNuAvoQs8=VTjtGCA@mail.gmail.com>
References: <20220930105434.111407-1-broonie@kernel.org>
        <20221004132047.435d42db@canb.auug.org.au>
        <CAMwc25oshRcJBoCT70B+b42bh5sPqgyoHuBx6K6ZLrwBMHnJzw@mail.gmail.com>
        <20221004140558.64f59f2c@canb.auug.org.au>
        <YzwbW4YQwQPsRPYw@sirena.org.uk>
        <CADnq5_PbPQPui1tOdUMB+OYbz6UBMKCgtwvE95oA+SfcN0RzNg@mail.gmail.com>
        <09cd11c5-2a15-3653-957c-88c751fa9029@amd.com>
        <20221006092810.0c3a2238@canb.auug.org.au>
        <20221006191245.11bb0e2c@canb.auug.org.au>
        <CADnq5_N1cZiG39KzUzdHCtLRRCipMMNXjaNuAvoQs8=VTjtGCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yq=CMsPbtfbw3ZbIbj0A.8v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yq=CMsPbtfbw3ZbIbj0A.8v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Thu, 6 Oct 2022 09:56:32 -0400 Alex Deucher <alexdeucher@gmail.com> wrot=
e:
>
> This looks good to me.  Care to add you s-o-b?
>=20
> On Thu, Oct 6, 2022 at 4:12 AM Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> >
> > This works as well, and (in my opinion) is better:
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_stream.c
> > index ae13887756bf..fb6222d4c430 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> > @@ -499,7 +499,7 @@ bool dc_stream_remove_writeback(struct dc *dc,
> >                 struct dc_stream_state *stream,
> >                 uint32_t dwb_pipe_inst)
> >  {
> > -       int i =3D 0, j =3D 0;
> > +       unsigned int i, j;
> >         if (stream =3D=3D NULL) {
> >                 dm_error("DC: dc_stream is NULL!\n");
> >                 return false;
> > @@ -520,9 +520,9 @@ bool dc_stream_remove_writeback(struct dc *dc,
> >         }
> >
> >         /* remove writeback info for disabled writeback pipes from stre=
am */
> > -       for (i =3D 0, j =3D 0; i < stream->num_wb_info && j < MAX_DWB_P=
IPES; i++) {
> > +       for (i =3D 0, j =3D 0; i < stream->num_wb_info; i++) {
> >                 if (stream->writeback_info[i].wb_enabled) {
> > -                       if (i !=3D j)
> > +                       if (j < i)
> >                                 /* trim the array */
> >                                 stream->writeback_info[j] =3D stream->w=
riteback_info[i];
> >                         j++;

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/yq=CMsPbtfbw3ZbIbj0A.8v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM/B9wACgkQAVBC80lX
0GxPBwf/X9e+0uhZmXWuqnUtNXKQwd59fHfR7z+ygsIZb+QvXVfou3rxBBG01k9L
ynx2bUMXHzZclPr4YRBTujJg+WUrGRaSSwQLYMnaMldJPLIw1DVOzQPJc55MzkTx
Ot1EwdItYS0CohnccfrUZwWTs7j8j5rkn9tQNDRmkPAS5HQ+SzIir2oA0axR78yT
tL9uxN762UYNBTPGH07aZ2Z/tMMTglop9JtzsAhtJJzUMK9G4VMMP1UDld8PfYwf
1yz85G9JBKhEjk+NItYGvKLK3XzxERwusBaUUGgb77dsZ2A/njBwZkkHjPeP7Djr
gvipz9skgMi5RjNrKa3caq0X0EYP6g==
=mEP6
-----END PGP SIGNATURE-----

--Sig_/yq=CMsPbtfbw3ZbIbj0A.8v--
