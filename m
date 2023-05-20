Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DA870A85A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjETNdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 09:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjETNdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 09:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D22134;
        Sat, 20 May 2023 06:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B441760EEB;
        Sat, 20 May 2023 13:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC42C433EF;
        Sat, 20 May 2023 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684589586;
        bh=tsZSAODnnzHZGwnOC0E85QelYlCAX4TyqFef9jcN3Pw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GIdjUITKHjPofMJr3CD33keb2nGaXjdHrLUQdJGpciN8mKR0veUn0VdBRGjq9Jyjy
         DF5tJwpp8BQDsHsnDDWoGnc4iDDe5Q1979SEi5CYKNUfU7T0jNKHXGweISa3LeyA4d
         Es7InHXFc7rVnFlzvlkmbaziFsKHHUo8Xpf5VVONTNkg/vOrCERnENFvEt3iXRg5Jz
         GNgGP+ERXQoytIMu//nDR6jMMivmU3gjO/TCbWdYjQsmCVdp8OICuXc1C/kUJbA1AG
         4OENR444CZPZSvE+XbYjpIOv4z5JeNyAtMQCf0TzVzcSSk1Py+Zwe5mVsCnUqztwgL
         QT81gwUJZlVRw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5552cbcda35so17040eaf.1;
        Sat, 20 May 2023 06:33:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDwlqFXQKj3m0HhUNZpWEGcLqphVjNGgW3xUmogtSQAsI49s2Mi6
        XqjHR28gwzGAKxNAwb7Xf4uEX2QXgeU1YkHfWoc=
X-Google-Smtp-Source: ACHHUZ4iR416n0bKcGNuCnKcBdPvX8udgu6aKxn76ySivU0RvkYKmjs/vm6nQr23xDTIdv32slCXdW9e/+AW+YNLnJE=
X-Received: by 2002:aca:d18:0:b0:389:7c1e:3b83 with SMTP id
 24-20020aca0d18000000b003897c1e3b83mr3013621oin.32.1684589585415; Sat, 20 May
 2023 06:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-4-masahiroy@kernel.org>
 <CAKwvOdmM5PsCy=p=CmWR9faCWwGsrmqPHv5MH7sfRS5fKz+=rQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmM5PsCy=p=CmWR9faCWwGsrmqPHv5MH7sfRS5fKz+=rQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 20 May 2023 22:32:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRAK+VNJS-9SZQDanw7Ob5+D_H5zjsfn+5vBbzzWuDDA@mail.gmail.com>
Message-ID: <CAK7LNAQRAK+VNJS-9SZQDanw7Ob5+D_H5zjsfn+5vBbzzWuDDA@mail.gmail.com>
Subject: Re: [PATCH v5 03/21] modpost: remove get_prettyname()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 6:44=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 14, 2023 at 8:27=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > This is the last user of get_pretty_name() - it is just used to
> > distinguish whether the symbol is a function or not. It is not
> > valuable information.
>
> I thought it's a nice touch. Not like it should slow things down
> unless there are extable warnings to report. May we keep it?


I do not think so.

The ex_table quite often points to assembly code, where
the distinction of function/data is not so important.

The extable has a lot of code just to print annoyingly
long error messages.




--=20
Best Regards
Masahiro Yamada
