Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78FA6A27F8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 09:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBYIzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 03:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBYIzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 03:55:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF293FF00;
        Sat, 25 Feb 2023 00:55:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93C71B80186;
        Sat, 25 Feb 2023 08:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59628C433EF;
        Sat, 25 Feb 2023 08:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677315317;
        bh=xHzp2b3mLyKTo/ernQaYQpt0xw+N9bTWe3K5PGUubns=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rT6Z2PTeZzefOvYlmquvGZaTLmQEGzSJt5MewbFujx05N9RqbrISQhLj/FgxHTacq
         EYWuD8LSz9/fBWoiWVEa+aENSqU8PgnctN9jEnAQ6sAVwtzKcwOQKrwIElwcQ3C/DD
         x250gK1jVkWGpDBbWe/6M5azDeKSVvnSRVtsVDoksl+OXlK+mZH4WfllhBs1nO0bCS
         mxz9isyXYDHmH65SMM1GAj9ySdHRA2HJE2qemM+3ti8PaBVA9BFV7h34ml0Z0ztBFb
         p+bHTC6yT961g2CPYNYgsAGHUpq12brdMmAdbYQUssalKYAELfP0GWPq7f/61HNsbt
         +LwhuugJhDsMA==
Received: by mail-oo1-f45.google.com with SMTP id e12-20020a4ae0cc000000b00525034ca5e9so279368oot.0;
        Sat, 25 Feb 2023 00:55:17 -0800 (PST)
X-Gm-Message-State: AO0yUKXXMplBAw88BGUy9xJDb15Mkz6uvK0JQHA0RTP3cXy02+EhbLWn
        sfpwQisBMeTuYzpmB+oShRGIPLPFotDBO1S+VxA=
X-Google-Smtp-Source: AK7set/qGUKgQLS82qxHFuumRFQAI8VR1eRpYeYNH+tiXxq9A/Xk5+XIHLRZw39MJkVHmt/9Cb2CH0NDTdNAv6h3cKQ=
X-Received: by 2002:a4a:a4ca:0:b0:525:2b11:9632 with SMTP id
 c10-20020a4aa4ca000000b005252b119632mr1984974oom.1.1677315316670; Sat, 25 Feb
 2023 00:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20230215012034.403356-1-masahiroy@kernel.org> <20230215012034.403356-7-masahiroy@kernel.org>
 <Y/k9VkL+Amj8JaSe@fjasle.eu>
In-Reply-To: <Y/k9VkL+Amj8JaSe@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 25 Feb 2023 17:54:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATb=zyH_0Rf6XXh5iyNaT09gfZH+2mX+ano6pv0120QfA@mail.gmail.com>
Message-ID: <CAK7LNATb=zyH_0Rf6XXh5iyNaT09gfZH+2mX+ano6pv0120QfA@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] kbuild: deb-pkg: switch over to source format
 3.0 (quilt)
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 7:48 AM Nicolas Schier <nicolas@fjasle.eu> wrote:


>
> bike-shedding:
>
>         cat <<-eof
>         Subject: Add .config
>         Author: ${maintainer}
>
>         --- /dev/null
>         +++ linux/.config
>         eof



I agree this is more readable, but I used echo to
avoid a process fork.

'echo' is a shell built-in for bash and dash but 'cat' is not.

So, this is a trade-off between readability vs
one less process fork.

If the code were much longer, I would prefer 'cat'.









>
> > +     diff -u /dev/null "${KCONFIG_CONFIG}" | tail -n +3
> > +} > debian/patches/config
> > +echo config > debian/patches/series
> >
> >  echo $debarch > debian/arch
> >  extra_build_depends=", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-dev:native)"
> > --
> > 2.34.1
>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>



--
Best Regards
Masahiro Yamada
