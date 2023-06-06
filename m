Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0910B72361E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjFFEQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjFFEQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5CC187;
        Mon,  5 Jun 2023 21:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 277FE62CDE;
        Tue,  6 Jun 2023 04:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888B1C4339E;
        Tue,  6 Jun 2023 04:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686025001;
        bh=MAE1ythoLNBeB1ORLNtzTYQQ0a3o9L1jKtxPLPiEWmU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jl4vVm5svBlUMPsgHxndQpZVMWaMB6+4JhuIYcov7MW0R6GYSEql+3cfpRvC6DZJI
         S1DLuzTdBdJDOFiPraR1MXhn25/nL046JgrODvmZUPkENOAgBVpEOSyMMy/3k1A2d/
         nnHxis0P85OJn0bJQbyN7E9hfl7oodjTegS47golMW9K8rgxWz6NefvPJioSDyR1vw
         vZk8KSZwkFhYVO5zccQpstwapn8NhJ8bcfvmoLn1w8fomYiHvXlAVDQcSXdv+3v6FP
         2bh11G9zFqaovMio/hkLi1V/7WK3SvBnvYnUSZYUhN7f6QAT1FuMA7/5FnoLc/BNbI
         wCsOVRvunVXEA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-55b069a7cf4so162331eaf.3;
        Mon, 05 Jun 2023 21:16:41 -0700 (PDT)
X-Gm-Message-State: AC+VfDxaVMNonZRH+zNe+96pDZeQtXDpX9zsUlENGos1pGvf1qOQNw8M
        4CkusCatghjQkZX27g4cv6GhDIFU8YoPOAOzPlE=
X-Google-Smtp-Source: ACHHUZ6G60KlPawm1PRr84CTkNAX3J2skcs6tNEdohnBPRKzMwC7Ux6v297e5B1nE34u8Sw1UgXSXDYO5EuX+YFldDU=
X-Received: by 2002:a4a:dec2:0:b0:558:b7e5:1dd0 with SMTP id
 w2-20020a4adec2000000b00558b7e51dd0mr730630oou.3.1686025000793; Mon, 05 Jun
 2023 21:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <4cb758c7-f4f5-820c-c7e7-5b900ccc2534@kernel.org>
In-Reply-To: <4cb758c7-f4f5-820c-c7e7-5b900ccc2534@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 6 Jun 2023 13:16:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNATn=8a0F=4Rq2q3vz6-eupkVy6LvYUBLSiGeshujEu0zw@mail.gmail.com>
Message-ID: <CAK7LNATn=8a0F=4Rq2q3vz6-eupkVy6LvYUBLSiGeshujEu0zw@mail.gmail.com>
Subject: Re: make localmodconfig doesn't work for thunderbolt
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, USB list <linux-usb@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
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

Hi Jiri,


On Wed, May 10, 2023 at 8:01=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> Hi,
>
> if I use localmodconfig for example like this:
> mkdir /tmp/tb/
> echo thunderbolt >/tmp/tb/lsmod
> make O=3D/tmp/tb LSMOD=3D/tmp/tb/lsmod localmodconfig
>
> I get:
> using config: '.config'
> thunderbolt config not found!!
>
> $ grep 'USB4\>' /tmp/tb/.config
> # CONFIG_USB4 is not set
>
> I believe it's due to:
>    obj-${CONFIG_USB4} :=3D thunderbolt.o
> in drivers/thunderbolt/Makefile. I.e. ${} used instead of more common $()=
.
>
> But even if I change the parser:
>
> --- a/scripts/kconfig/streamline_config.pl
> +++ b/scripts/kconfig/streamline_config.pl
> @@ -317,7 +317,7 @@ foreach my $makefile (@makefiles) {
>          $_ =3D convert_vars($_, %make_vars);
>
>          # collect objects after obj-$(CONFIG_FOO_BAR)
> -       if (/obj-\$\((CONFIG_[^\)]*)\)\s*[+:]?=3D\s*(.*)/) {
> +       if (/obj-\$[({](CONFIG_[^})]*)[)}]\s*[+:]?=3D\s*(.*)/) {
>              $var =3D $1;
>              $objs =3D $2;
>


Will you send this fix as a patch?






> I see:
> module thunderbolt did not have configs CONFIG_USB4
>
> and:
> $ grep 'USB4\>' /tmp/tb/.config
> # CONFIG_USB4 is not set
>
> So two questions:
> 1) is ${} supported and should be the above change sent as a patch? Or
> should be drivers/thunderbolt/Makefile fixed to use $(). (And maybe
> other Makefiles too.)
>
> 2) how to fix that 'thunderbolt did not have configs'?
>
> thanks,
> --
> js
> suse labs



--=20
Best Regards
Masahiro Yamada
