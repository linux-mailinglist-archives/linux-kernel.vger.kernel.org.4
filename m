Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6515F3C86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 07:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJDFvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 01:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJDFu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 01:50:58 -0400
X-Greylist: delayed 912 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Oct 2022 22:50:50 PDT
Received: from smtp2.tsag.net (smtp2.tsag.net [208.118.68.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EC02F03A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 22:50:49 -0700 (PDT)
Received: from linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
        (user=smtprelay@linuxfromscratch.org mech=PLAIN bits=0)
        by smtp2.tsag.net  with ESMTP id 2945X303007436-2945X305007436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Oct 2022 23:33:03 -0600
Received: from localhost.localdomain (xry111.site [89.208.246.23])
        by linuxfromscratch.org (Postfix) with ESMTPSA id 92BDA1C3481;
        Tue,  4 Oct 2022 05:32:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfromscratch.org;
        s=cert4; t=1664861583;
        bh=RHHv5zvqhnXl7Kqs8UFl9hLaQq62LgXxAZvC/XhNV6U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=PBp5MZhPOWGMcTY+ete3ItPxu5vaToEhSAdAQ6cjuzfK+1N2D/jHD5GumwX+/M6tf
         j80jL9usyAoyqaDpclFiyPpyLQvfrpjPxiCkKzb0sHfUViWqoWa2VvQvl6ffhBaAyj
         LENtOkFrGjI9yaRYPdAoAPGStV7CfSKNmvx2x5GicCyVUGbBCt0ELfzaARJo24PGfo
         7njNgUpeA/UxrXBBrmZOSeMYQoElbBH5AyChbWN/iuSE/oXgb6VeOdsrYFcSbpsHtP
         05Ve2tk7DoD1T37wf01E0ugrmFEez+bsK2+GXqIVgSLvLYxitwclp3Lv3hyaj3cdeI
         EerRlVAUx83gQ==
Message-ID: <8d9810e2de8aa658223542a651346118ee7be4ac.camel@linuxfromscratch.org>
Subject: Re: [GIT PULL] Rust introduction for v6.1-rc1
From:   Xi Ruoyao <xry111@linuxfromscratch.org>
To:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Fox Chen <foxhlchen@gmail.com>, Gary Guo <gary@garyguo.net>,
        Geert Stappers <stappers@stappers.nl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joe Perches <joe@perches.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Julian Merkle <me@jvmerkle.de>,
        =?ISO-8859-1?Q?L=E9o?= Lanteri Thauvin 
        <leseulartichaut@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Matthew Bakhtiari <dev@mtbk.me>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        =?ISO-8859-1?Q?N=E1ndor_Istv=E1n_?= =?ISO-8859-1?Q?Kr=E1cser?= 
        <bonifaido@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Niklas Mohrin <dev@niklasmohrin.de>,
        Petr Mladek <pmladek@suse.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Viktor Garske <viktor@v-gar.de>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Wei Liu <wei.liu@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yuki Okushi <jtitor@2k36.org>
Date:   Tue, 04 Oct 2022 13:32:49 +0800
In-Reply-To: <202210010816.1317F2C@keescook>
References: <202210010816.1317F2C@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
X-FEAS-Auth-User: smtprelay@linuxfromscratch.org
X-FEAS-DKIM: Valid
Authentication-Results: smtp2.tsag.net;
        dkim=pass header.i=@linuxfromscratch.org;
        dmarc=pass header.from=linuxfromscratch.org
X-FE-Policy-ID: 0:14:3:linuxfromscratch.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-10-01 at 08:58 -0700, Kees Cook wrote:
> Hi Linus,
>=20
> Please pull the initial Rust support for v6.1-rc1. The tree has a recent
> base, but has fundamentally been in linux-next for a year and a half[1].
> It's been updated based on feedback from the Kernel Maintainer's Summit,
> and to gain recent Reviewed-by: tags. Miguel is the primary maintainer,
> with me helping where needed/wanted. Our plan is for the tree to switch t=
o
> the standard non-rebasing practice once this initial infrastructure serie=
s
> lands. The contents are the absolute minimum to get Rust code building
> in the kernel, with many more interfaces[2] (and drivers[3]) on the way.

Hi,

As a Linux From Scratch maintainer I have to express some concern.

I think I have the most open attitude to Rust among all Linux From
Scratch members.  But this will be just *too* troubling for us.

I'm not against the use of Rust in kernel, but:

1. Current implementation strictly depends on bindgen, which depends on
libclang in turn.  It means even if the Rust support land in GCC 13,
we'll still need to build and install the giant LLVM for building the
Rust components in the kernel.  Is it possible to use some different
approach (for example, including the binding in the kernel tree)?

2. Squashing all the cmake, LLVM, and Rustc stuff into the Linux From
Scratch book will be extremely painful, but still possible.  However, we
currently need "A particular version of the Rust compiler".  This is
just annoying.  What will happen if a security vulnerability suddenly
shows up in the "particular version" required by a kernel LTS branch?=20
And from a distro maintainer's point of view this will forces us to
build multiple Rustc versions.  I see the reason "the kernel depends on
some unstable Rust features", but then shouldn't we wait for (or urge
the Rustc developers for) the stabilization of these features, instead
of merging Rust into the mainline too quickly?  Now they can declare the
victory like "oh, the kernel is now using our language!" but *we* are
paying all costs.

