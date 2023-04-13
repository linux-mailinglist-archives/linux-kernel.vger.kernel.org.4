Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8C26E13C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjDMRxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjDMRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:53:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5645113;
        Thu, 13 Apr 2023 10:53:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 461D662EDF;
        Thu, 13 Apr 2023 17:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804A4C433EF;
        Thu, 13 Apr 2023 17:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681408425;
        bh=lXBPCxuF7EjYBvfhzpTw/L+xKvHb2w0zcvAWzRhxCLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UkhRynFNdX5E9X0hxqVx29woLlIMhTtrEx/OABpMaOYpmWscVBC4DWVeTlbpsd7f0
         q7SW1cLAkLZZ3EensHfnvBZVl5leMLgBTN5CW5EPzR3ehT0KCZMY5GGjcvrwz/1Ph/
         l+GWxQlFhARci058xrqvGgmiYODv4p7ypKs2sM/jyGHWsU8bfQ/9x9wl7/inianQ4J
         i1bYb0cITfpO62IOcwpgjREgCXAojVCsnOvTFAobGyHC1h0n7JBqtd9/5oE6IG7bXy
         A5rR4zUqlVDGGVRp5wBBb3AyKXoKGQGXfJNe12Atu8wKdHZAYsPvvhYq08c0zAEA/+
         vtGk4t/edaMhg==
Received: by mail-lf1-f46.google.com with SMTP id z8so22046746lfb.12;
        Thu, 13 Apr 2023 10:53:45 -0700 (PDT)
X-Gm-Message-State: AAQBX9e4LUbXa6HBsQct++J84ruqM0oGERsFyd2eIyiHHZoKGddnTwnm
        n9AJAY198C+5XEZjB6Zwou3aCT6Ova3iq2gmh54=
X-Google-Smtp-Source: AKy350ZjZGtS5JwSNAMY8++eebVytlT/CSBXy9f5kDCNFTNt6sSc4D1HHZ7iqqn3bvz8UKwldSPSABzlK9GJnQ1Spbg=
X-Received: by 2002:ac2:48b1:0:b0:4eb:dcc:52ce with SMTP id
 u17-20020ac248b1000000b004eb0dcc52cemr1065401lfg.9.1681408423850; Thu, 13 Apr
 2023 10:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230411200944.2591330-1-maskray@google.com> <20230413145508.GC26421@willie-the-truck>
In-Reply-To: <20230413145508.GC26421@willie-the-truck>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 14 Apr 2023 02:53:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNATyYS2WA9kGQ9=OK+Xn5KdnG9bmcxSKE4=9Z5jc2kr+uA@mail.gmail.com>
Message-ID: <CAK7LNATyYS2WA9kGQ9=OK+Xn5KdnG9bmcxSKE4=9Z5jc2kr+uA@mail.gmail.com>
Subject: Re: [PATCH v3] Makefile: use -z pack-relative-relocs
To:     Will Deacon <will@kernel.org>
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 11:55=E2=80=AFPM Will Deacon <will@kernel.org> wrot=
e:
>
> On Tue, Apr 11, 2023 at 08:09:44PM +0000, Fangrui Song wrote:
> > Commit 27f2a4db76e8 ("Makefile: fix GDB warning with CONFIG_RELR")
> > added --use-android-relr-tags to fix a GDB warning
> >
> > BFD: /android0/linux-next/vmlinux: unknown type [0x13] section `.relr.d=
yn'
> >
> > The GDB warning has been fixed in version 11.2.
> >
> > The DT_ANDROID_RELR tag was deprecated since DT_RELR was standardized.
> > Thus, --use-android-relr-tags should be removed. While making the
> > change, try -z pack-relative-relocs, which is supported since LLD 15.
> > Keep supporting --pack-dyn-relocs=3Drelr as well for older LLD versions=
.
> > There is no indication of obsolescence for --pack-dyn-relocs=3Drelr.
> >
> > As of today, GNU ld supports the latter option for x86 and powerpc64
> > ports and has no intention to support --pack-dyn-relocs=3Drelr. In the
> > absence of the glibc symbol version GLIBC_ABI_DT_RELR,
> > --pack-dyn-relocs=3Drelr and -z pack-relative-relocs are identical in
> > ld.lld.
> >
> > GNU ld and newer versions of LLD report warnings (instead of errors) fo=
r
> > unknown -z options. Only errors lead to non-zero exit codes. Therefore,
> > we should test --pack-dyn-relocs=3Drelr before testing
> > -z pack-relative-relocs.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1057
> > Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Da=
619b58721f0a03fd91c27670d3e4c2fb0d88f1e
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  Makefile                      | 3 ++-
> >  scripts/tools-support-relr.sh | 8 ++++++--
> >  2 files changed, 8 insertions(+), 3 deletions(-)
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Masahiro -- are you happy to pick this one up?


Sure. Applied to linux-kbuild.


(I will push it next week.)


> If not, I can take it via
> arm64 (as the only arch currently using this reloc format).
>
> Cheers,
>
> Will



--=20
Best Regards
Masahiro Yamada
