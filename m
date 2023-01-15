Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27D566AF2B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 04:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjAODAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 22:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjAODAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 22:00:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACEC5241;
        Sat, 14 Jan 2023 19:00:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97BFDB80A1F;
        Sun, 15 Jan 2023 03:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43769C4339E;
        Sun, 15 Jan 2023 03:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673751613;
        bh=bFt4YyLZX3/rsuJcCaW/XUF1jJTkYU+iSnk+mOJWZAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cnokAca9jqyPnzNzziv8PiziNAlvm5bdxgipQ6Tfs3kBMybKuZTs4new4FZODbned
         8sFO3zww5fD3KhHKwIOWFfvgDfd7XxU1VCbGNu8QiGeH0q5chjb+R+KkoonkYPdCfJ
         MAmrx+ti4sugCc0Qn1NKDZb2/HouW3iT3Fl+qeYAzo4FND0+TDcNfbIDAqFgxoODLr
         hCjVXNHyzVJsBODPuLTp4Yj3kLzyYZ69aNC8vt8k5zlv2Tpa6YC0Z1RiF/EYXIOREK
         pvlS1Tx5gkOBNIG4NfBZtwX1gU+4io6KUZ3Fukv9dbMXNjXd5tKKrr9JAoX+tYNY53
         iAa64CdeGoGYg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-15ebfdf69adso8755635fac.0;
        Sat, 14 Jan 2023 19:00:13 -0800 (PST)
X-Gm-Message-State: AFqh2ko2sH/7yySKQy7ZnLUcsODMfFOaK9hF2TkYimUsE78uUw5DJSps
        Pxs5uIjKBuMiU8LBTpMNvIUjQ5i+SxPNk3HXMp8=
X-Google-Smtp-Source: AMrXdXtag8LojjjmvIbOa2XBgTbaRTmcJdZZtQWLHPjWioe6kI27FrmC2/fiB8BfkJo1AtDhkgE8aR/uCRps3wqhkPc=
X-Received: by 2002:a05:6870:80ce:b0:15f:1e44:71fd with SMTP id
 r14-20020a05687080ce00b0015f1e4471fdmr78632oab.194.1673751612406; Sat, 14 Jan
 2023 19:00:12 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <CANiq72m_+xJYUxrwFc7vNLkuOb6zC-W-wDzXjbPb8Ursqzwiaw@mail.gmail.com>
 <CAK7LNATmRkSU2n6AaeJenE-18gbUd4ZShFNfKysEjyCo4Q-eAA@mail.gmail.com> <CANiq72=G0P-XZ6Kn2XYFwbSdqG7Yh4f5zgAr-fn+85QJCMRZUA@mail.gmail.com>
In-Reply-To: <CANiq72=G0P-XZ6Kn2XYFwbSdqG7Yh4f5zgAr-fn+85QJCMRZUA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 15 Jan 2023 11:59:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNASB2EToZMUyt5PRoDyBcmF3a1QgVXsRvb9EjQ3yifRLKQ@mail.gmail.com>
Message-ID: <CAK7LNASB2EToZMUyt5PRoDyBcmF3a1QgVXsRvb9EjQ3yifRLKQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] docs: rust: add paragraph about finding a suitable `libclang`
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 8:13 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jan 12, 2023 at 7:05 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Yes, I can take this, but the doc change
> > is independent of the rest, and will not conflict with
> > any Kbuild changes.
> >
> > So, you can apply this one to your tree.
>
> The doc change is not fully independent: this patch is first because
> the next commit uses the fact that the documentation is written (to
> point the user to it), and the commit message mentions this.
>
> Not a big deal, but it would look better if all are in at once.
>
> Cheers,
> Miguel


Now I think it is better to ask you to pick up my patch [1]
and apply all of this patch set in your tree
since you are adding bigger changes.




[1]: https://patchwork.kernel.org/project/linux-kbuild/patch/20230109061436.3146442-1-masahiroy@kernel.org/






-- 
Best Regards
Masahiro Yamada
