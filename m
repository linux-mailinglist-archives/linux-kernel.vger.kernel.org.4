Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F995B2F45
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIIGtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIIGtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:49:50 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF20399DF;
        Thu,  8 Sep 2022 23:49:48 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2896nWEH008040;
        Fri, 9 Sep 2022 15:49:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2896nWEH008040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662706172;
        bh=Cc3I8prCyjIf+TwPWUqhp4g8QHweMf8EdEJMF8PoPyk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bnSbpi/TymqsyEfu13N4nX7hrp7+peEKtGPV4Nwcu5zPaW0nT2f3Dmy9yDh8y5VRZ
         qZCtAifA2IlaAVofRwCo0EMu4UhH7sxUcHDFzYNvgFhzSg2eIuU8FrG0B0HE+Xs1ep
         dmaxB7rB0ZYAq+YsIp94oTNd2gxpl1/2hsaq4YPpS8Q1udpB4EVgR/cK+tGewnk5QS
         E17mD62ppdeGz82EmrHBErBmk2u2fOaws/iRqEDZGw57BGhMaGrlvqzieKFkH3K8VP
         oauKwcA73VDNfUAvVGO2S3COsYRO9B3Sab/HizOJl03p5K+etg5Uq8jGDkAJ/l81mJ
         AogDkshKHSmHw==
X-Nifty-SrcIP: [209.85.160.54]
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1274ec87ad5so1738012fac.0;
        Thu, 08 Sep 2022 23:49:32 -0700 (PDT)
X-Gm-Message-State: ACgBeo3jMFAyTCXoBrTp7wvvf4zoTJ5OuOSh6vFRbSRueaaB+GpdQR7D
        cxotLWBKhcgkKq5Zx2ljqeyo5vugIchpA9ovM2s=
X-Google-Smtp-Source: AA6agR7DCnkNpqAsKTA8sOFPusKO1t0TevFalhSq2GcpOyOtcGFKvrZDd2MUshccB9W0YNcZrtYZZtYZo8MTdVwPdqE=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr1439040oib.194.1662706171558; Thu, 08
 Sep 2022 23:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220909090024.47458048@canb.auug.org.au> <CAK7LNARPX2Ov-nLAT6mPWbgqQMDCuoW84VN_C2sS1CJkR_n8YQ@mail.gmail.com>
 <20220909152453.5400cf7e@canb.auug.org.au> <20220909161354.2c94a495@canb.auug.org.au>
In-Reply-To: <20220909161354.2c94a495@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Sep 2022 15:48:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNATR0-Y_yHTcD62J4N36T-_4G=-N1me8EWYNTNYbwXerDw@mail.gmail.com>
Message-ID: <CAK7LNATR0-Y_yHTcD62J4N36T-_4G=-N1me8EWYNTNYbwXerDw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 3:14 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi,
>
> On Fri, 9 Sep 2022 15:24:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Fri, 9 Sep 2022 14:10:06 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > Hmm, I am testing allmodconfig in my tree,
> > > but it is not reproducible so far.
> > >
> > > Do you have any more hint?
> > > (which commit exactly?, and what build command did you use? etc.)
> >
> > I was trying your top of tree commit
> >
> >   99ea8da56dca "kbuild: use objtool-args-y to clean up objtool arguments"
> >
> > (merged with Linus' tree and some fix patches).
> >
> > I am doing a cross build with an out of tree object directory:
> >
> > $ make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- O=../x86_64_allmodconfig -s allmodconfig
> > $ make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- O=../x86_64_allmodconfig -j100 -O -s
>
> So it seems to be related to doing an incremental build.  I have just
> built my "pending-fixes" branch (which I have pushed out to the
> linux-next tree on git.kernel.org), then merged your tree and then
> built again:

I tried this.

I built fa8e6bb658f682ff63b3af3dd4c5e4d3b43f4ffd (pending-fixes) first,
then merged b326faa3e125.



masahiro@oscar:~/ref/linux-next$ git show --pretty=fuller
commit ca2e36215ba55dab29160cfe0512b5a8a172efe0 (HEAD -> merge-kbuild)
Merge: fa8e6bb658f6 b326faa3e125
Author:     Masahiro Yamada <masahiroy@kernel.org>
AuthorDate: Fri Sep 9 15:41:07 2022 +0900
Commit:     Masahiro Yamada <masahiroy@kernel.org>
CommitDate: Fri Sep 9 15:41:07 2022 +0900

    Merge ../../workspace/linux-kbuild into merge-kbuild



>
> $ make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- O=../obj -j15 -O
> make[1]: Entering directory '/home/sfr/kernels/obj'
>   GEN     Makefile
> make[1]: Leaving directory '/home/sfr/kernels/obj'
> make[1]: Entering directory '/home/sfr/kernels/obj'
>   UPD     include/generated/compile.h
> make[1]: Leaving directory '/home/sfr/kernels/obj'


Weird 'Entering/Leaving directory' logs.






In my case, it went quite normally.

I see only one 'Entering directory', with no error.



masahiro@oscar:~/ref/linux-next$ make ARCH=x86_64
CROSS_COMPILE=x86_64-linux-gnu- O=../obj  -j24
make[1]: Entering directory '/home/masahiro/ref/obj'
  GEN     Makefile
  DESCEND objtool
  CALL    /home/masahiro/ref/linux-next/scripts/atomic/check-atomics.sh
  CALL    /home/masahiro/ref/linux-next/scripts/checksyscalls.sh
  CHK     include/generated/compile.h










>   DESCEND objtool
> make[2]: *** No rule to make target 'objtool/objtool'.  Stop.
> make[1]: *** [/home/sfr/kernels/test/Makefile:1361: tools/objtool/objtool] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:222: __sub-make] Error 2
>
> (I actually did this on my laptop rather than my build machine, but the
> compiles are still cross compiles - just from arm64 instead of
> powerpc64le).
> --
> Cheers,
> Stephen Rothwell



-- 
Best Regards
Masahiro Yamada
