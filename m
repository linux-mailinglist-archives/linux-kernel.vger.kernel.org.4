Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EAE6A5D14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjB1Q0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjB1Q0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:26:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8212ED41;
        Tue, 28 Feb 2023 08:26:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25C1CB80E77;
        Tue, 28 Feb 2023 16:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60C4C4339B;
        Tue, 28 Feb 2023 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677601590;
        bh=AkB87OLJPxh9UIAOkr0bc/Qc5bsWpH72J1kKlUqwG6w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PJ+K1r4DTU8UnWWt6rDeyIEw3brQj8Y50enjFxlDsxXyBFdtsobwRo2OuLPr07Z4c
         892oOad38RE0oMJXiWBb6yHcG1jEa/obwkIsuBuhYtP6m70kJoA+DbK/8guds5kura
         k5EjcKYr9HsL1pdCxaIQPyiRHTjEWnFRBIq4jOPsZpHRbrh5C7gI+N2RJ5Wp0lwb2V
         B4nnDuYm2CpX5j2F5tqFhfYhE2M3x7NYcdTG7VGGGpd9m/a4k3LiiBk6MS8Z2fnrNH
         ji9Mxrq4WgFIodwP7bQyI6MuZAcdoX0waw/Lp7Sm2PPjvXpy7KiA9O+0H0IHtGml+d
         /Yo7zMnF0OCHQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-17235c8dab9so11427491fac.7;
        Tue, 28 Feb 2023 08:26:30 -0800 (PST)
X-Gm-Message-State: AO0yUKVljMemMAeQbWz6Wiw/saH/4azJDorvafpPpY3pFMI5AsSRqlK7
        DWtMN2dGk0/GakimrpVx963AzCRaEu/C/i65nSU=
X-Google-Smtp-Source: AK7set+XkU42uYSE+s2398F/OQ9vjDr2sktTB9q7cO79kHz1YeeqQL2V9oj7FKqA0sumKSYwGJtv+OjxBCxoe2i9CVU=
X-Received: by 2002:a05:6870:c7a6:b0:171:8f59:3437 with SMTP id
 dy38-20020a056870c7a600b001718f593437mr893819oab.8.1677601590226; Tue, 28 Feb
 2023 08:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20230228031317.3415484-1-davidgow@google.com> <CAK7LNASBznyHmAwSRApOHw_6dyAXFuskmtKav65xFwKZdvNWJw@mail.gmail.com>
 <e8addca3-e539-110c-ea2b-9a4921a45d71@intel.com>
In-Reply-To: <e8addca3-e539-110c-ea2b-9a4921a45d71@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Mar 2023 01:25:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNASZwwHsbsEEHhqsLKg44ZUoGDWMqhteazuOrSx23uf1XQ@mail.gmail.com>
Message-ID: <CAK7LNASZwwHsbsEEHhqsLKg44ZUoGDWMqhteazuOrSx23uf1XQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kbuild: Add note about using (subst m,y)
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     David Gow <davidgow@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 12:16=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Masahiro Yamada <masahiroy@kernel.org>
> Date: Tue, 28 Feb 2023 17:30:09 +0900
>
> > On Tue, Feb 28, 2023 at 12:13=E2=80=AFPM David Gow <davidgow@google.com=
> wrote:
>
> [...]
>
> >> +Example::
> >> +
> >> +  #drivers/Makefile
> >> +  obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv/
> >> +
> >
> >
> > I think many subsystems simply do
> >
> > obj-y  +=3D hv/
>
> This creates a ton of empty built-in.a, each of them is listed in the
> Kbuild output. Someone may think that if a directory contains
> built-in.a, then something was built there. Sure it's their problems,
> but I'd prefer to not pollute the log and built-in.a contents when
> possible (empty files are still listed there IIRC).


You can choose whichever you like.
Up to each subsystem maintainer.






--=20
Best Regards
Masahiro Yamada
