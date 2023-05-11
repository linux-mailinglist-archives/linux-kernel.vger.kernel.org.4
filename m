Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C66FF6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbjEKQQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbjEKQQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC232681;
        Thu, 11 May 2023 09:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F15C5619A5;
        Thu, 11 May 2023 16:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F355C4339E;
        Thu, 11 May 2023 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683821786;
        bh=37BLDMCQApsAYWkD2Fzkf9WBWnl8ntaXgQXEeNJfu6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vFduNp+AFVlR1whHWfYkSSUXtqdrbdmkSvG29SAJ52Fo0fYb7Za4cEdoiqrLKFoYL
         iSxEE9zmu3ljSqd/ykPAiKPbHFmZEAE1o8IX7Ej6ylyQIXFcaEUyThU73H1xSACKcl
         C21nEWbeImzjsQ4YRDUrYy+Zko54/xhHj5BKauuFicWNrXtohDqx3uzj2zl5iPetw+
         YIU3Rb8GqcklpcVqBigUvTcg4DWNkPz7YgxoDE114K1RL3FrUjyDCS+gxyYwoBVJHc
         hCYVzN3MlxvSYrvIn07dnnqa3Kn+SrwUmJASt2EoZCRo3auEAQigxFq/XbVB5NVXsx
         yTieR1wDilSVA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-192cfb46e75so4017367fac.3;
        Thu, 11 May 2023 09:16:26 -0700 (PDT)
X-Gm-Message-State: AC+VfDxQJoHFS3yu9RLiSqx35BMhtUMKgjelLHf5bmZczhHUpOsDgeJ1
        c/2Ch3vtUdDgl1NyEExNNAuVuBkrVaoEj38uloI=
X-Google-Smtp-Source: ACHHUZ4T2QkjrGxdQHl22Ge1T3nDuhIFk9OGTimOV7hj2Mp6VKkmVCr4clyp0D4xpw355k0a1jz+0o15ZxnnvtR6tlA=
X-Received: by 2002:a05:6870:a455:b0:196:3004:cc07 with SMTP id
 n21-20020a056870a45500b001963004cc07mr4435471oal.39.1683821785529; Thu, 11
 May 2023 09:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <4cb758c7-f4f5-820c-c7e7-5b900ccc2534@kernel.org>
In-Reply-To: <4cb758c7-f4f5-820c-c7e7-5b900ccc2534@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 12 May 2023 01:15:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQeT8MaQr450x0SpHJV=QU7nrfWfDO1ZRKimppVZG4KA@mail.gmail.com>
Message-ID: <CAK7LNATQeT8MaQr450x0SpHJV=QU7nrfWfDO1ZRKimppVZG4KA@mail.gmail.com>
Subject: Re: make localmodconfig doesn't work for thunderbolt
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, USB list <linux-usb@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Steven Rostedt, author of streamline_config.pl



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
>
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


I believe streamline_config.pl should be fixed.

There is no good reason to support only $(), but not ${}.


In fact, the comment line around line 395 of this script
uses the curly brace style.

  # a loaded module. This is a direct obj-${CONFIG_FOO} +=3D bar.o






> 2) how to fix that 'thunderbolt did not have configs'?

That warning is CONFIG_USB4 was unset in the resulting .config.

Was CONFIG_USB4 enabled before running localmodconfig?

In my understanding, the purpose of localmodconfig
is to slim down the .config file.

It disables unneeded CONFIG options, but
it does not enable needed CONFIG options.




If I start from allnoconfig (i.e. CONFIG_USB4 is unset), I see the warning.

$ echo thunderbolt >/tmp/tb/lsmod
$ make -s O=3D/tmp/tb allnoconfig
$ make O=3D/tmp/tb LSMOD=3D/tmp/tb/lsmod  localmodconfig
  GEN     Makefile
using config: '.config'
module thunderbolt did not have configs CONFIG_USB4



If I start from allmodconfig (i.e. CONFIG_USB4 is m), I do not see the warn=
ing.

$ echo thunderbolt >/tmp/tb/lsmod
$ make -s O=3D/tmp/tb allmodconfig
$ make O=3D/tmp/tb LSMOD=3D/tmp/tb/lsmod  localmodconfig
  GEN     Makefile
using config: '.config'





--=20
Best Regards
Masahiro Yamada
