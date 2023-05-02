Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616856F46FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjEBPW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjEBPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:22:56 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B291BD7
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:22:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2a8b082d6feso38371441fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683040970; x=1685632970;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fPK0QjUxHX3a6I/jaRNvVSBSf3l6DRXHloilqaGemEk=;
        b=gXT3z0mL4BcBfHS+MMvmBznO2GyQc6ucwsF15zrxc4N0gh+SZ2q1d4tEES4uwUwvGH
         MzRvNfA9B0yzfEzxlm+aSMjh391/xbx7C1gBzcqIXKuP48+zPW0NRtbLQSyjC2C+G+dv
         V4HSTMB/iG9jq+9YVM1b+GCzcmVv52ydR7jEtNpJvLsvt5rC41cxwcB6QV4qkCqrYg3j
         y9vwSiB5RkpOys0/5t11tzrjOqAw0bGdN5OuTeQbIwFENA+tqeo78VHAwU6Xd1RKRNLF
         9cWQmpRT4jNoCOaPygd0H1qlSiPy3h5NR/8Z9dq4NEHgbGCk/OguHs+j7Be0y5RZcetI
         Mc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683040970; x=1685632970;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPK0QjUxHX3a6I/jaRNvVSBSf3l6DRXHloilqaGemEk=;
        b=M4CgM5bDomHKF2z4w4fk+V2/EwlK/4y3/kMWuQgGFMb5FdJVqNyHVVSC6XVA/3+pqk
         cR5zsz492ll3D/NgBU1Sc58xt9RCk1URyUiR9AWi6ScBk25fWy37vpINT2nShUbO5yUr
         8hCGxwBctPljgoxE0nj9kKgZoBRba4Nw3Vq1c6gUvHS29jywFS8HlkstVOw80xF9jcEl
         djVfLvAS8YRecKxypG1WAWGJMKaROeGWCX4G1P7G/4Rvj7DdN46gVn6kkFTHhsHKUrFN
         28djCdR/9g2zDIT1GUVoLt+fCC86KVYH6GseZ9d2WIQBb4c1kjHsgxZ+4xIyfkv2Dsz0
         SppQ==
X-Gm-Message-State: AC+VfDw1ckxKs7UU6/wuC9MPfJ1pSY+MqU3Pn1NAvIlTO9Tu8rRUy4wp
        2jPDikEmtZx4MlWwyyDuXus=
X-Google-Smtp-Source: ACHHUZ5NKlETULJWN9Uqbjy1tAPW4/+WZBAbCJu0M2sfzSCehvg3akwUcIMvmFKMcpFfSsuiIy2B6g==
X-Received: by 2002:a19:f502:0:b0:4e8:3d24:de6f with SMTP id j2-20020a19f502000000b004e83d24de6fmr91127lfb.14.1683040969517;
        Tue, 02 May 2023 08:22:49 -0700 (PDT)
Received: from [192.168.0.131] (catv-89-134-213-173.catv.fixed.vodafone.hu. [89.134.213.173])
        by smtp.gmail.com with ESMTPSA id p5-20020ac246c5000000b004eafabb4dc1sm5430672lfo.250.2023.05.02.08.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:22:48 -0700 (PDT)
Message-ID: <c54414482b685af0991a6b095cbfb7534d998afc.camel@gmail.com>
Subject: Re: [RFC PATCH 0/1] Add AMDGPU_INFO_GUILTY_APP ioctl
From:   Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org,
        "Pelloux-Prayer, Pierre-Eric" <pierre-eric.pelloux-prayer@amd.com>,
        Marek =?UTF-8?Q?Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
        michel.daenzer@mailbox.org,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
Date:   Tue, 02 May 2023 17:22:46 +0200
In-Reply-To: <CADnq5_NHtFbwT=x8u7GYc4ESL_HVFzjgtOd3AnVFBYMrjZq55w@mail.gmail.com>
References: <20230501185747.33519-1-andrealmeid@igalia.com>
         <CADnq5_NXj4W44F_etRQ7HWdVTnf5zARCM3Y_o3EiwWiHj8QMpA@mail.gmail.com>
         <6ab2ff76-4518-6fac-071e-5d0d5adc4fcd@igalia.com>
         <cb3d2590-a1f8-fe7e-0bba-638ee80719af@amd.com>
         <CAFF-SiV0=WNmRW-D9uYUuj68Zq0APxtGLya9KR6FfZ7v0Zf2RQ@mail.gmail.com>
         <fcca2934-a556-797c-535d-a66fc67bbe30@amd.com>
         <85c538b01efb6f3fa6ff05ed1a0bc3ff87df7a61.camel@gmail.com>
         <CADnq5_NHtFbwT=x8u7GYc4ESL_HVFzjgtOd3AnVFBYMrjZq55w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-02 at 09:45 -0400, Alex Deucher wrote:
> On Tue, May 2, 2023 at 9:35=E2=80=AFAM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > Hi,
> >=20
> > On Tue, 2023-05-02 at 13:14 +0200, Christian K=C3=B6nig wrote:
> > > >=20
> > > > Christian K=C3=B6nig <christian.koenig@amd.com> ezt =C3=ADrta (id=
=C5=91pont:
> > > > 2023.
> > > > m=C3=A1j. 2., Ke 9:59):
> > > >=20
> > > > > Am 02.05.23 um 03:26 schrieb Andr=C3=A9 Almeida:
> > > > > =C2=A0> Em 01/05/2023 16:24, Alex Deucher escreveu:
> > > > > =C2=A0>> On Mon, May 1, 2023 at 2:58=E2=80=AFPM Andr=C3=A9 Almeid=
a
> > > > > <andrealmeid@igalia.com>
> > > > > =C2=A0>> wrote:
> > > > > =C2=A0>>>
> > > > > =C2=A0>>> I know that devcoredump is also used for this kind of
> > > > > information,
> > > > > =C2=A0>>> but I believe
> > > > > =C2=A0>>> that using an IOCTL is better for interfacing Mesa +
> > > > > Linux
> > > > > rather
> > > > > =C2=A0>>> than parsing
> > > > > =C2=A0>>> a file that its contents are subjected to be changed.
> > > > > =C2=A0>>
> > > > > =C2=A0>> Can you elaborate a bit on that?=C2=A0 Isn't the whole p=
oint
> > > > > of
> > > > > devcoredump
> > > > > =C2=A0>> to store this sort of information?
> > > > > =C2=A0>>
> > > > > =C2=A0>
> > > > > =C2=A0> I think that devcoredump is something that you could use
> > > > > to
> > > > > submit to
> > > > > =C2=A0> a bug report as it is, and then people can read/parse as
> > > > > they
> > > > > want,
> > > > > =C2=A0> not as an interface to be read by Mesa... I'm not sure
> > > > > that
> > > > > it's
> > > > > =C2=A0> something that I would call an API. But I might be wrong,
> > > > > if
> > > > > you know
> > > > > =C2=A0> something that uses that as an API please share.
> > > > > =C2=A0>
> > > > > =C2=A0> Anyway, relying on that for Mesa would mean that we would
> > > > > need
> > > > > to
> > > > > =C2=A0> ensure stability for the file content and format, making
> > > > > it
> > > > > less
> > > > > =C2=A0> flexible to modify in the future and probe to bugs, while
> > > > > the
> > > > > IOCTL is
> > > > > =C2=A0> well defined and extensible. Maybe the dump from Mesa +
> > > > > devcoredump
> > > > > =C2=A0> could be complementary information to a bug report.
> > > > >=20
> > > > > =C2=A0Neither using an IOCTL nor devcoredump is a good approach
> > > > > for
> > > > > this since
> > > > > =C2=A0the values read from the hw register are completely
> > > > > unreliable.
> > > > > They
> > > > > =C2=A0could not be available because of GFXOFF or they could be
> > > > > overwritten or
> > > > > =C2=A0not even updated by the CP in the first place because of a
> > > > > hang
> > > > > etc....
> > > > >=20
> > > > > =C2=A0If you want to track progress inside an IB what you do
> > > > > instead
> > > > > is to
> > > > > =C2=A0insert intermediate fence write commands into the IB. E.g.
> > > > > something
> > > > > =C2=A0like write value X to location Y when this executes.
> > > > >=20
> > > > > =C2=A0This way you can not only track how far the IB processed,
> > > > > but
> > > > > also in
> > > > > =C2=A0which stages of processing we where when the hang occurred.
> > > > > E.g.
> > > > > End of
> > > > > =C2=A0Pipe, End of Shaders, specific shader stages etc...
> > > > >=20
> > > > >=20
> > > >=20
> > > > Currently our biggest challenge in the userspace driver is
> > > > debugging "random" GPU hangs. We have many dozens of bug
> > > > reports
> > > > from users which are like: "play the game for X hours and it
> > > > will
> > > > eventually hang the GPU". With the currently available tools,
> > > > it is
> > > > impossible for us to tackle these issues. Andr=C3=A9's proposal
> > > > would be
> > > > a step in improving this situation.
> > > >=20
> > > > We already do something like what you suggest, but there are
> > > > multiple problems with that approach:
> > > >=20
> > > > 1. we can only submit 1 command buffer at a time because we
> > > > won't
> > > > know which IB hanged
> > > > 2. we can't use chaining because we don't know where in the IB
> > > > it
> > > > hanged
> > > > 3. it needs userspace to insert (a lot of) extra commands such
> > > > as
> > > > extra synchronization and memory writes
> > > > 4. It doesn't work when GPU recovery is enabled because the
> > > > information is already gone when we detect the hang
> > > >=20
> > > =C2=A0You can still submit multiple IBs and even chain them. All you
> > > need
> > > to do is to insert into each IB commands which write to an extra
> > > memory location with the IB executed and the position inside the
> > > IB.
> > >=20
> > > =C2=A0The write data command allows to write as many dw as you want
> > > (up to
> > > multiple kb). The only potential problem is when you submit the
> > > same
> > > IB multiple times.
> > >=20
> > > =C2=A0And yes that is of course quite some extra overhead, but I thin=
k
> > > that should be manageable.
> >=20
> > Thanks, this sounds doable and would solve the limitation of how
> > many
> > IBs are submitted at a time. However it doesn't address the problem
> > that enabling this sort of debugging will still have extra
> > overhead.
> >=20
> > I don't mean the overhead from writing a couple of dwords for the
> > trace, but rather, the overhead from needing to emit flushes or top
> > of
> > pipe events or whatever else we need so that we can tell which
> > command
> > hung the GPU.
> >=20
> > >=20
> > > > In my opinion, the correct solution to those problems would be
> > > > if
> > > > the kernel could give userspace the necessary information about
> > > > a
> > > > GPU hang before a GPU reset.
> > > >=20
> > > =C2=A0The fundamental problem here is that the kernel doesn't have
> > > that
> > > information either. We know which IB timed out and can
> > > potentially do
> > > a devcoredump when that happens, but that's it.
> >=20
> >=20
> > Is it really not possible to know such a fundamental thing as what
> > the
> > GPU was doing when it hung? How are we supposed to do any kind of
> > debugging without knowing that?
> >=20
> > I wonder what AMD's Windows driver team is doing with this problem,
> > surely they must have better tools to deal with GPU hangs?
>=20
> For better or worse, most teams internally rely on scan dumps via
> JTAG
> which sort of limits the usefulness outside of AMD, but also gives
> you
> the exact state of the hardware when it's hung so the hardware teams
> prefer it.
>=20

How does this approach scale? It's not something we can ask users to
do, and even if all of us in the radv team had a JTAG device, we
wouldn't be able to play every game that users experience random hangs
with.



