Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9662B0A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiKPBmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKPBm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:42:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626B01EC7A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:42:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC7856174F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF7DC433C1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668562945;
        bh=/73c+abN4QftE1DbXzsL5nCqHYd+wSDjYNjJfma3RpM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ldTpPluM0iki4tcyAUAFdVlF3guA3JyKKKBIJ9GWawHUrkxeCvKTXdYJdpSaia6qY
         xAe81NJmcoR4Wen0QVQgAC0mpizUPuMqKY3imVpfYGS7Xf7zWMzOFTeA2unW4Z3QUO
         0q0JGwko21GculukSvnotZKrj6CF7D/s437DW3FXCt7ihtsy+qgO9745blza7bGCKg
         c8U+vJ1qJaEDfXKDB3HurQ47WcSv50STwTP7U7Tuy606fw1xKAldv1JzMrc756gcke
         7SZ9XtmQRcKkw+TT/d49NPDmlEfDhtx1C2vHBjRA6yMmK9dDoK8QGbWrwbpoM5cPx6
         wWbWkNKxFUw/w==
Received: by mail-ed1-f51.google.com with SMTP id s5so8293530edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:42:25 -0800 (PST)
X-Gm-Message-State: ANoB5pnFt0QfyEyJgnIxXMGbfl07knGMAj1CORfQbufjOgBBxDqK01tg
        cMjGRdvrfSnBYHOZOWa3cuqs+ELa0m1g3SokSZw=
X-Google-Smtp-Source: AA0mqf43jAe2+JFCQVOPNWtQ4LWc7dlgmJCk0zRPyjuABonKCHNzbeIq1QpbCjJz1+xl7Pb4KUyyQTFBARvH0Mjuq60=
X-Received: by 2002:aa7:ce83:0:b0:457:23cb:20ab with SMTP id
 y3-20020aa7ce83000000b0045723cb20abmr16899813edv.254.1668562943489; Tue, 15
 Nov 2022 17:42:23 -0800 (PST)
MIME-Version: 1.0
References: <1668506549-28261-1-git-send-email-yangtiezhu@loongson.cn> <7e606e2c3df5d727a6c69b74a803d9f2c8e717b0.camel@xry111.site>
In-Reply-To: <7e606e2c3df5d727a6c69b74a803d9f2c8e717b0.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 16 Nov 2022 09:42:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4enbgFoNCvnon9TW9JE0BuiMiX6ZHW27+GMX-SKEBK9g@mail.gmail.com>
Message-ID: <CAAhV-H4enbgFoNCvnon9TW9JE0BuiMiX6ZHW27+GMX-SKEBK9g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Makefile: use "grep -E" instead of "egrep"
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-fixes, thanks.

Huacai

On Tue, Nov 15, 2022 at 10:28 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Tue, 2022-11-15 at 18:02 +0800, Tiezhu Yang wrote:
> > The latest version of grep claims the egrep is now obsolete so the
> > build
> > now contains warnings that look like:
> >         egrep: warning: egrep is obsolescent; using grep -E
> > fix this up by moving the LoongArch Makefile to use "grep -E" instead.
>
> For future reference: this warning message is imprecise because on some
> non-POSIX platforms grep does not support -E (see "Limitations of Usual
> Tools" in autoconf info page).
>
> However (1) we are already using -w, which is not guaranteed to be
> supported as well; (2) I don't think anyone will build LoongArch kernel
> on such an old non-POSIX system.
>
> So LGTM.
>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  arch/loongarch/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index a0fc1f9..5232d8c 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -97,7 +97,7 @@ KBUILD_LDFLAGS        += -m $(ld-emul)
> >
> >  ifdef CONFIG_LOONGARCH
> >  CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null |
> > \
> > -       egrep -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
> > +       grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
> >         sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e
> > 's/\$$/&&/g')
> >  endif
> >
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
