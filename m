Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA84C666B15
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 07:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbjALGFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 01:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbjALGF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 01:05:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A760432192;
        Wed, 11 Jan 2023 22:05:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34DC461F6E;
        Thu, 12 Jan 2023 06:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C505C43398;
        Thu, 12 Jan 2023 06:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673503527;
        bh=fLOxnvGzIYVtypNTSZJWVFXieiaShiwicfrgtP+APLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DxGESJnt1vELtHFm0oai8xXC8+5GbAPNLfHOpcENPziNKxlK90W2cbOPhbr84Aev0
         qTfu7HNpN16FV0L4ylKrB83qXSiiOryscfQ9Y5rOihmrxDYzrO5tJq80p63L4z7XBp
         VbBJEzQ1EWIv1HLqqThEqqq0crwwK1P5ZwhcVCbYAmetfANd+Bli5W2ImvqhXBqIJd
         loh2Mom0NtPjZJhPVNKTkGHG4a7su/GBzIB9pmX0tCL4hfpriS4cVshRCRGSRCTTXi
         E/NhJeJRik6T7semqkkT3drliY/pvmzpJxsJ6vXhB/X0wwp9uTZ2DIPGQeWY8mMdMr
         rAuXGnW41lA0g==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-14455716674so17914987fac.7;
        Wed, 11 Jan 2023 22:05:27 -0800 (PST)
X-Gm-Message-State: AFqh2kqHN3rNtTHEMZdlCGzqgpcfmR/tGniyxMQ6gAwuWm28ChJhoMQN
        /JNenwjhjzoifpPFKWw1aaQuoE6hAt5UG/Hrwmc=
X-Google-Smtp-Source: AMrXdXsbKuYyiriVmNmlUn+MZXGsK911wAs1ywABFmVdFJDs0JNt8l3m/yUNdw835VfD238fQTzOyibjPL5yrT+RkDE=
X-Received: by 2002:a05:6870:514c:b0:150:7e4a:2f00 with SMTP id
 z12-20020a056870514c00b001507e4a2f00mr2619143oak.194.1673503526768; Wed, 11
 Jan 2023 22:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <CANiq72m_+xJYUxrwFc7vNLkuOb6zC-W-wDzXjbPb8Ursqzwiaw@mail.gmail.com>
In-Reply-To: <CANiq72m_+xJYUxrwFc7vNLkuOb6zC-W-wDzXjbPb8Ursqzwiaw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 Jan 2023 15:04:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmRkSU2n6AaeJenE-18gbUd4ZShFNfKysEjyCo4Q-eAA@mail.gmail.com>
Message-ID: <CAK7LNATmRkSU2n6AaeJenE-18gbUd4ZShFNfKysEjyCo4Q-eAA@mail.gmail.com>
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

On Tue, Jan 10, 2023 at 6:06 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jan 9, 2023 at 9:45 PM Miguel Ojeda <ojeda@kernel.org> wrote:
> >
> > +* Or ``LIBCLANG_PATH`` can be pointed to a ``libclang`` shared library
> > +  or to the directoy containing it.
>
> I just noticed the typo here, sorry: directoy -> directory
>
> Masahiro: if you take them, please feel free to correct it.


Yes, I can take this, but the doc change
is independent of the rest, and will not conflict with
any Kbuild changes.

So, you can apply this one to your tree.





>
> Cheers,
> Miguel



--
Best Regards
Masahiro Yamada
