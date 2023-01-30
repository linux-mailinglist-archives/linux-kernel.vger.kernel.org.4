Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4368037F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 02:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjA3B33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 20:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3B32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:29:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D01193C4;
        Sun, 29 Jan 2023 17:29:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F691B80D52;
        Mon, 30 Jan 2023 01:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395DBC433EF;
        Mon, 30 Jan 2023 01:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675042164;
        bh=1QHPPOkHUofpih9Jmlmgw0bRuqh8Fb1o1ZhTnb38xaM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NEgo+H4FDaaL5RQhV97LWpkly81rGnp4W8RKF2CNF5FpOztWr1+fuTxOBz3gP7Kmd
         jIfPOyfEM6fs6lVM6Y2fkxG6SvgyFC5PRSt5aot14RyKuo7NVh9FgKwA5mZTS77pXF
         dn48zQlOwhGxxgtZOB8iRihxbekX9WYOqrcAj9emTS3sGHLrlfOmm3feHjfcgEu93H
         GWs5ZfC8qMsgPgVSummKampNkUdYO29X0oDdJQEUPubaOlM104Qf9kzwY9qlPwsrg/
         Sj4IB5L2E4GElOCn501Gh4wlOeyKyuiouqnlzaN+s1h33ULxR4YxDroxoC3m6D1FUr
         psQZ631o6llSw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-163bd802238so1190516fac.1;
        Sun, 29 Jan 2023 17:29:24 -0800 (PST)
X-Gm-Message-State: AO0yUKXRr+vpzC+D8xbVG6OF8oRh3dSsatYn4f5avX+ul6iQ1zgdpDJh
        a9hf3/sJzZswbBd+mmqnPZZUnqPfLfRSgue2zXI=
X-Google-Smtp-Source: AK7set+y4ElpO/no/fM/exM/HohyKTb/NVh6kgI3s5IQP6qKQhWIPe/6MqIiLqiYGROfX+tePBJqQey7KQctSe2K4JI=
X-Received: by 2002:a05:6870:330b:b0:163:a45a:9e41 with SMTP id
 x11-20020a056870330b00b00163a45a9e41mr208021oae.194.1675042163510; Sun, 29
 Jan 2023 17:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20230129184602.3974058-1-masahiroy@kernel.org>
 <20230129184602.3974058-4-masahiroy@kernel.org> <CANiq72=BRW9TunjKQmeMthm7Esc_YKM++NmWh-Dqc9Av13SNow@mail.gmail.com>
In-Reply-To: <CANiq72=BRW9TunjKQmeMthm7Esc_YKM++NmWh-Dqc9Av13SNow@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 30 Jan 2023 10:28:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQttb=qc5vsZNudYwTxmn=y3HZzVqZwAzMvLfUJXa4OFQ@mail.gmail.com>
Message-ID: <CAK7LNAQttb=qc5vsZNudYwTxmn=y3HZzVqZwAzMvLfUJXa4OFQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kbuild: srcrpm-pkg: create source package without cleaning
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 8:20 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, Jan 29, 2023 at 7:46 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > -               include init io_uring ipc kernel lib mm net rust \
>
> For Rust, it is early to deal with packaging, so removing this from
> here should not hurt.

I guess you are talking about kernel-devel-*.rpm
(and linux-headers-.deb).

They are not useful for building external modules
written in Rust since they do not contain *.rmeta etc.
I am not caring about that because Rust support is not
mature enough yet.


This series does not touch binary packages,
rather it just changes how the source package is created.

I stopped hard-coding the top-level directories.
The resulting source package still contains all check-in files
under rust/, so it is good from the source package perspective.




> In any case, I quickly tried the series and noticed that the
> `.src.rpm` does not end in the `SRPMS` folder (as it did before) -- is
> that expected?


5/5 changed the behavior because rpm-pkg re-uses the
*.src.rpm generated by srcrpm-pkg.


Having *.src.rpm in the kernel tree seems Redhat's preference.
Commit 8818039f959b2efc0d6f2cb101f8061332f0c77e
added --define='_srcrpmdir $(srctree)'.



In contrast, binary rpm files are generated under rpmbuild/RPMS/.
I want to fix this inconsistency, though.



-- 
Best Regards
Masahiro Yamada
