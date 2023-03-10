Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E809A6B32EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 01:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCJAwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 19:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCJAwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:52:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388ADF9D3F;
        Thu,  9 Mar 2023 16:52:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01AE9B8214B;
        Fri, 10 Mar 2023 00:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3A5C4339B;
        Fri, 10 Mar 2023 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678409551;
        bh=cRmUg/JbMLYRj4dYJKHAWXpm1hjbKTemJQlot7tsaNk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rqd302DAUEgu5krm9SK8F/aIg8qM7iW92/aw6Gg+n9kwEZqw7LIrQJwwQDzcL9yUS
         SYRYS1xg5Rp6jIGuZ3NnpLuk1YJWSvjsYt4UbgZXqlsjI6eL4RBs1YGSUvKPhgVWa5
         1S7GXyIjFWmtDolUVA1wlv/CdJavnFGK1Gq701WZuf13lwG4NQSi3sxEo2ycSX5U9E
         fWqpIv++IBur5DrqvBOid9b1pIGkE++A7s8GJVvr7pULCdh2Ot8XZx4uvERukueE2Z
         u8IQeyaBG6lLNkHlHleZTsptD5oApW8WLXVuBgPlSDxI1foNiosxLLio63V4Cghrh4
         a47Xs7nNDxYMQ==
Received: by mail-oi1-f169.google.com with SMTP id bi17so3110535oib.3;
        Thu, 09 Mar 2023 16:52:31 -0800 (PST)
X-Gm-Message-State: AO0yUKUjnB3q3KeBA7YPzy+WG/5w5RgMBhzB/w1zRqgHHF8HPaIWDz8B
        Vk+Fc4L6TcOjoy0oLCca98QbHwZ2bNshoNFAJP8=
X-Google-Smtp-Source: AK7set/6V1ep4bExi657Fv9hL6PvA+h/Vyrj5b0U3JEytRzS267de4Lryhfzk9CTAdBojIEIfqxRcIZ8JluTCfy3iYs=
X-Received: by 2002:a05:6808:30c:b0:383:e7b5:8177 with SMTP id
 i12-20020a056808030c00b00383e7b58177mr7918567oie.11.1678409550878; Thu, 09
 Mar 2023 16:52:30 -0800 (PST)
MIME-Version: 1.0
References: <a10e1319-b631-6d3b-5e1d-b07223350502@igalia.com>
In-Reply-To: <a10e1319-b631-6d3b-5e1d-b07223350502@igalia.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 10 Mar 2023 09:51:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQmXwpEpY84-fdLiwALSFLUEkfsOHejbqy33c6ceM=4Tw@mail.gmail.com>
Message-ID: <CAK7LNAQmXwpEpY84-fdLiwALSFLUEkfsOHejbqy33c6ceM=4Tw@mail.gmail.com>
Subject: Re: About the .scmversion removal (commit f6e09b07cc12)
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kbuild@vger.kernel.org, nathan@kernel.org,
        rasmus.villemoes@prevas.dk,
        Nick Desaulniers <ndesaulniers@google.com>, nicolas@fjasle.eu,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
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

On Fri, Mar 10, 2023 at 6:15=E2=80=AFAM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> Hi Masahiro / all, I was rebuilding the kernel today, just adding some
> debug statements, when I noticed a lot of stuff got built again. I was
> using ".scmversion" to prevent UTS version changes, so only affected
> files got indeed rebuilt.
>
> After commit f6e09b07cc12 ("kbuild: do not put .scmversion into the
> source tarball"), seems this file is automatically deleted and I'm not
> sure how should I proceed to continue with the same behavior.
>
> Apologies if this is a silly question, any advice is much appreciated!
> Also, I've CCed all the emails from [0], so apologies if anybody looped
> here shouldn't be CCed.


Not a silly question, but .scmversion was intended for source
package creation (deb, rpm) in my understanding.

If you want to use a fixed string for the UTS version,
please pass KERNELRELEASE=3D<some-string> to the build command line.






--=20
Best Regards
Masahiro Yamada
