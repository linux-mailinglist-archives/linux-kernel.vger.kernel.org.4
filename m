Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F140F750CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjGLPgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjGLPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:36:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B91BD7;
        Wed, 12 Jul 2023 08:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77FC061866;
        Wed, 12 Jul 2023 15:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6086C433C9;
        Wed, 12 Jul 2023 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689176173;
        bh=PbujtPfodhCW0MYV6O63M6+F36QFLvoD3ngwcw7WrFg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cIFQ1OFr8yslaCWLonyOhCB0w5DknRmqEe6BJ1LKgE98CEVO03mXlJLOMcYVFn7yA
         50DAOvcTnYgRd0DLOgM1IctIUDNKcaRWrG2GwWIxIIR3XAPZ7ag6MrjWT3j0t6urjX
         zA8SN76X2sQIggBgBY+rhYVbFvwYhCDKCtzMx2K9NpX28ZkrYYg7cAM6n7rJ7JOq6V
         y007Ewu5XN5/jwUMzWiwuMXqnaaUgxIKYSPCvQVvcyfOnOeb/1HgV5iCEU/+SzmP+u
         aaUQlg96QEXrRoHk9JaDmimJ4aqSZ8n489ekQGwqxmwDn3i+QQFfvzCUVa++465Maj
         vFvDvGzMykt7A==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5661e8f4c45so5345821eaf.1;
        Wed, 12 Jul 2023 08:36:13 -0700 (PDT)
X-Gm-Message-State: ABy/qLaEiglq9vw+uaDJY6bZQSYaYbRimnWM4aFhf9kusVU++NSdfyQY
        eKlixfz06Jiiy+QAeW14WwSFJ+bUikG5o7oJw+w=
X-Google-Smtp-Source: APBJJlFbM0VFa3OxwRC/aO/EMh8klZvvhHtzg90Srpdh1IYyak39lWyIU46Nut5Aj6jmqYKwGhBDHK6WP3EWzz6upEo=
X-Received: by 2002:a4a:b045:0:b0:560:ac0f:b87c with SMTP id
 g5-20020a4ab045000000b00560ac0fb87cmr14241977oon.8.1689176173111; Wed, 12 Jul
 2023 08:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230704055246.22893-1-rdunlap@infradead.org>
In-Reply-To: <20230704055246.22893-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 13 Jul 2023 00:35:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNASAvkNTwTfVZm29Q=oGGc3-oHwW4FSm=8NSROp5V1A-tw@mail.gmail.com>
Message-ID: <CAK7LNASAvkNTwTfVZm29Q=oGGc3-oHwW4FSm=8NSROp5V1A-tw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: tell the kconfig symbol of the restart reason
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
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

On Tue, Jul 4, 2023 at 2:52=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> When running 'make oldconfig' or 'make olddefconfig' without waiting

olddefconfig is not interactive in the first place.

'make config', 'make oldconfig', 'make syncconfig' are affected.


> for prompts, it can be useful to know the restart reason so that it
> can be fixed manually.
>
> This is usually when the prompt value is a number or a string,
> i.e., something other than y/m/n.



I do not understand what you mean.

Please give me some examples to see why this is useful.


BTW, "due to symbol ..." is not the reason for the restart.
It shows the first CONFIG option shown after the restart.



>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> ---
> Can the test for sym->name be omitted?

Not all symbols have a name.
For example, 'choice' may not have a name.

[test code]

choice
       prompt "A or B"
       depends on FOO

config A
       bool "A"

config B
       bool "B"

endchoice

config FOO
       bool "foo"



If you omit, sym->name test,
"due to symbol: (null)" will be displayed.
Not a crash, but users will be misguided.




foo (FOO) [N/y/?] (NEW) y
*
* Restart config...
* due to symbol: (null)
*
*
* Linux/x86 6.5.0-rc1 Kernel Configuration
*
A or B
> 1. A (A) (NEW)
  2. B (B) (NEW)












>  scripts/kconfig/conf.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff -- a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -652,8 +652,12 @@ static void check_conf(struct menu *menu
>                         printf("-----\n");
>                         break;
>                 default:
> -                       if (!conf_cnt++)
> -                               printf("*\n* Restart config...\n*\n");
> +                       if (!conf_cnt++) {
> +                               printf("*\n* Restart config...\n");
> +                               if (sym->name)
> +                                       printf("* due to symbol: %s\n", s=
ym->name);
> +                               printf("*\n");
> +                       }
>                         rootEntry =3D menu_get_parent_menu(menu);
>                         conf(rootEntry);
>                         break;



--=20
Best Regards
Masahiro Yamada
