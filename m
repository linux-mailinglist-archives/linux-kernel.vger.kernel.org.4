Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E61870C604
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjEVTOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjEVTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:14:19 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4621130;
        Mon, 22 May 2023 12:14:14 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-19a156dd5d2so2746458fac.0;
        Mon, 22 May 2023 12:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684782854; x=1687374854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gtw5or+8nSyicZi6zB4ROPQrdOxYpGpQ5eXf7PnG2K0=;
        b=Ek5f+EZOk0ZXAsviiLf9uGuNDhdyn1ldpY0pMdmxrCJnqkiGOQw6l0DffCXOxzLkI8
         wwqCut6JPwX8ASS7JViNF2SAFuHtIAOH+rsGtQpt+3cMW5EkS/Qq2qsu5V0jfeIxeVIE
         m7X5K0JfBSk4J1j+bD8UJJEcBQYMYcsrA8qWepJSL/ZkFjw1zVMDrRB0SlZoNlVFyrR7
         BRpzVfWIxeLhMIcYc5ZSg4NDTek2MUUZPaIfuPWhLNgYcsVuGmlQq8wq3CU31nCelge9
         blz+ryXOqeBLkQ0UblmqKzzL+GoyV4JSMM21ZIdqFSlBJXPrpJN0QSkF5IyXUIsts5/O
         BXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684782854; x=1687374854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gtw5or+8nSyicZi6zB4ROPQrdOxYpGpQ5eXf7PnG2K0=;
        b=iUbeMfxGdsWtqgkdiEl7lZ/9AE6+cJDSgDSg/H5lT13JQlCSxPNuEh7DNA1DGyA7h5
         jHJzxhYTtdi873JFj1B7YFg8piVD2AE9+lKZfhrRTajmLgJ0eAkWLBPsyla1qu3DXMBp
         W0kLdUIoCKJbu/+H+GBEAq2gzWaVuh16Y8jwC01CK4shApJhl0CY4//eiEPahItD3Qys
         rfSP6FlS99GhG5Rf/tG0Yow4D2KCQ56tqfppNTXfEW4oWqwS42sKtqjcFJZGLrWOWME2
         5e5ftqT4mwXldSew5yfKZvHLX0173UxsB9HMCJKdO1OZ1bpYe69I9WNTlg27JzWMaBbR
         eHcw==
X-Gm-Message-State: AC+VfDyZ+ERQzDHelvLinu2lY2G5eDaNt2RvgWjFweTUp/uDiijXvFUs
        UbahiKSjNpcKWmpoxNh4a09t9ks1zvBg85Ndhp7KxdYvM7c=
X-Google-Smtp-Source: ACHHUZ4DliWk73qV9hbw7g8v/vutLIyFl/MjZRXca6tk/MtOMVtGtCXbo/b/JKQwQqYVnNXbGdQDg4IymHy1fY+GM6g=
X-Received: by 2002:a05:6870:a3c3:b0:19a:1f5e:7404 with SMTP id
 h3-20020a056870a3c300b0019a1f5e7404mr6611290oak.7.1684782853898; Mon, 22 May
 2023 12:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230522171557.32027acf@canb.auug.org.au> <ZGuYeDA9jDlxzfZN@google.com>
 <CADnq5_OoGDVWX5UwV_hQQBfPorBuE2jJymMA-hW+Y3+7ni0f5g@mail.gmail.com> <CAKwvOdk6cO9L2Km+gBFNGkhdnODMAnizwA-PctJ=FcKTu=XFxw@mail.gmail.com>
In-Reply-To: <CAKwvOdk6cO9L2Km+gBFNGkhdnODMAnizwA-PctJ=FcKTu=XFxw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 May 2023 15:14:02 -0400
Message-ID: <CADnq5_OPERQR1_3uCU-h7rQ-kxfhrZDfCR_Z4fw06ajOqTF2VA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 12:47=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, May 22, 2023 at 9:36=E2=80=AFAM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Mon, May 22, 2023 at 12:29=E2=80=AFPM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Mon, May 22, 2023 at 05:15:57PM +1000, Stephen Rothwell wrote:
> > > > Hi all,
> > > >
> > > > After merging the amdgpu tree, today's linux-next build (arm allmod=
config
> > > > clang-17) failed like this:
> > > >
> > > > drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:146:54: error: format spec=
ifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka=
 'unsigned int') [-Werror,-Wformat]
> > > >
> > > > Caused by commit
> > > >
> > > >   d020a29b6b58 ("drm/amdgpu: Allocate GART table in RAM for AMD APU=
")
> > > >
> > > > Reported by the kernelci.org bot.
> > >
> > > Alex,
> > > This is the third report of linux-next being broken for clang due to =
the
> > > AMDGPU tree.
> > > 1. https://lore.kernel.org/lkml/20230522171557.32027acf@canb.auug.org=
.au/
> > > 2. https://lore.kernel.org/lkml/20230522171145.38a8bd4d@canb.auug.org=
.au/
> > > 3. https://lore.kernel.org/lkml/20230522170031.5fb87a64@canb.auug.org=
.au/
> > >
> > > Our CI is red as a result.
> > > https://github.com/ClangBuiltLinux/continuous-integration2/actions/ru=
ns/5045716034/jobs/9053211936
> > >
> > > When will AMD start testing their kernels with Clang?
> >
> > We have clang as part of our CI system and have had it for a while.
> > I'm not sure why it didn't catch these.  Our CI clang builds are
> > currently passing.
>
> Can you verify that the driver configs are enabled for those builds?

They are definitely enabled.  It's the whole point of the builds.

>
> Looking through my CI reports, it looks like allmodconfig/allyesconfig
> is red from this tree for ARCH=3Dx86_64 and ARCH=3Darm64.
> Examples:
> x86_64: https://github.com/ClangBuiltLinux/continuous-integration2/action=
s/runs/5045594636/jobs/9052932014
> arm64: https://github.com/ClangBuiltLinux/continuous-integration2/actions=
/runs/5045594636/jobs/9052930995

I looked into this quickly and I think in this particular case, it's
the result of a manual merge last week where the fixes from the
fallout didn't end up getting mirrored to my drm-next tree, and I
don't think CONFIG_WERROR is set in the config.  IIRC, we had a lot of
problems with that config option and older compilers when it was added
and I think we ultimately turned it off at the time.  We should
revisit that.  I'll talk to the CI team tomorrow.

Alex


>
> >
> > Alex
> >
> > >
> > > >
> > > > --
> > > > Cheers,
> > > > Stephen Rothwell
> > >
> > > Thanks for reporting these, Stephen.
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
