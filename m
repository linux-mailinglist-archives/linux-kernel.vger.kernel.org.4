Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D811B6BFFD0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCSHoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 03:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCSHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:44:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE9C18A82
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 00:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F191360A5A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F20C433D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679211865;
        bh=auhz0CvB76rQYPGzbXcu4yKtwVKZTALMGP7GXVWVaAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UBEx+4U511tDqbOUn0BhvOUAuPe2OMz6j9yXCodfT+5H/7p4VqP8Tm2ycUXQnJ6iw
         W0svzLtKLMcWl/6bfXBWTlLv5ZzogYalnsEZ6GD21dlqP3m4WK4E7CVP5QpMqUTp2d
         s5YxkAdL3L5+nEmSQY66goz72JkyTP08PJvwc1ggyAZEWO8a+/bMe5OHZrqUBGywem
         J1SjtiYpMacgUIDxaOKR/BV9yg0rGk9rdEfSjtbc8jA52y9oAVIPqZZopn8UXddYhc
         LPqsNVY9W1oH3g42eLY5igv3euRAo0TMzVs7cPHWi4bIycziwL6tkzswNii8WctsIs
         nc+jw7ul/a+uQ==
Received: by mail-oi1-f179.google.com with SMTP id be16so6807034oib.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 00:44:25 -0700 (PDT)
X-Gm-Message-State: AO0yUKUNc95bQR9Pm7nymNCOMR5PSO5mYnqGX94CtHvLKEMBo581j90o
        ecoBtx2+VtCSvjNWSrCt6pMY3LR1eihyCAfSjnc=
X-Google-Smtp-Source: AK7set97A4blbBCLvg06yMPN58v2VMu5AOsyds4mMFxTMfrU5qM3Wi0s4iTiUSiIxZU3X1FIxAkaxIjp6bJfzqUrkAQ=
X-Received: by 2002:a05:6808:2d8:b0:384:33df:4dfc with SMTP id
 a24-20020a05680802d800b0038433df4dfcmr4994892oid.11.1679211864641; Sun, 19
 Mar 2023 00:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221217084155.663235-1-mgorny@gentoo.org> <CAK7LNAQ8=YbOVvugBUQBo8eXRMH+YA49aS-1C=2hCGq0xoW7XA@mail.gmail.com>
 <628c5e32a437ad198866b03f2d6ff8a9c65754df.camel@gentoo.org>
 <897BDBF1-6C6E-4C69-8BA7-FEEFEB8ADC11@gentoo.org> <1416803D-E4E9-426B-8419-60251B8245B7@gentoo.org>
 <87wn3g2qfk.fsf@gentoo.org>
In-Reply-To: <87wn3g2qfk.fsf@gentoo.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Mar 2023 16:43:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATfrxu7BK0ZRq+qSjObiz6GpS3U5L=12vDys5_yy=Mdow@mail.gmail.com>
Message-ID: <CAK7LNATfrxu7BK0ZRq+qSjObiz6GpS3U5L=12vDys5_yy=Mdow@mail.gmail.com>
Subject: Re: [PATCH] kheaders: prefer gtar over tar for better compatibility
To:     Sam James <sam@gentoo.org>
Cc:     =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Dmitry Goldin <dgoldin+lkml@protonmail.ch>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dist-kernel@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I had relied this before, but
something awkward was happening because
the original email was addressed to
yamada.masahiro@socionext.com, which is
no longer valid.

Resending from masahiroy@kernel.org...






In the top Makefile, please add

TAR  =3D tar

and export TAR.



In kernel/gen_kheaders.sh,
please replace 'tar' with ${TAR:-tar}





On Gentoo systems, you can do

 $ make TAR=3Dgtar


or if you need to run gen_kheaders.sh directly

 $ TAR=3Dgtar scripts/gen_kheaders.sh


Thanks.








On Fri, Mar 17, 2023 at 9:05=E2=80=AFAM Sam James <sam@gentoo.org> wrote:
>
>
> Sam James <sam@gentoo.org> writes:
>
> > [[PGP Signed Part:Undecided]]
> >
> >
> >> On 17 Jan 2023, at 19:01, Sam James <sam@gentoo.org> wrote:
> >>
> >>
> >>
> >>> On 25 Dec 2022, at 16:33, Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> =
wrote:
> >>>
> >>> On Sun, 2022-12-25 at 01:45 +0900, Masahiro Yamada wrote:
> >>>> Instead of inserting a workaround like this,
> >>>> another way is to allow users to override a variable
> >>>> from the command line.
> >>>>
> >>>>
> >>>> See the top Makefile, for example,
> >>>>
> >>>>
> >>>> AWK             =3D awk
> >>>>
> >>>>
> >>>> Then, users can do "make AWK=3Dgawk"
> >>>
> >>> I'm sorry but are you requesting that I remove the check and use $TAR
> >>> instead, or allow overriding with TAR, and fall back to gtar or tar
> >>> respectively?  If the former, should the script unconditionally assum=
e
> >>> that TAR will be always set in the environment, or include fallback t=
o
> >>> tar for when the script is run directly?
> >>
> >>
> >> Masahiro, what do you reckon? Thanks.
> >>
> >
> > Ping.
>
> ping^2. We'd really love to get this in to fix a bug for our users in
> Gentoo.
>
> >
> >> Best,
> >> sam
> >
> >
> > [[End of PGP Signed Part]]
>

--
Best Regards
Masahiro Yamada
