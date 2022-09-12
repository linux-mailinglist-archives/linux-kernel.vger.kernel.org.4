Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237AE5B5357
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiILFG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiILFG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:06:58 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442E92872A;
        Sun, 11 Sep 2022 22:06:55 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 28C56bav015148;
        Mon, 12 Sep 2022 14:06:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 28C56bav015148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662959198;
        bh=JhHj8C0h27R6ov/QSDBAulzjoWe55R1PvENaiYyWYsk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c/KXSJ9qSqa67+xNqUvZHQxPr5ww9pKZKh1+5CrLcuf3iqFeKQFENWiIcpeQZB3vy
         4cCL8LUsbE1FIzpRWitwOkUg6UVa91x+U+3txCvB8oep86DATkJS87JuVHs5ELUOyA
         SbtfDIQ2CZsLA7uNHrq7lxhYZyRRrVi5+zz2blc9xtmWFadGeFnokA6Cqf9qEe/VCM
         4Rabn/Id5P+Bg8I68cE6H+9AfhGbrPBPghEntN/zF1YFAB6nHwPBvFudvBcuj+Ncqs
         +TW5184V/bPMdV2BR7HABGS7FxkG7dYfmqEKkX4/lrQpqXQ/X/cxbAUDea+hpVb8o9
         FM11s7fTemikg==
X-Nifty-SrcIP: [209.85.160.52]
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-12803ac8113so20481347fac.8;
        Sun, 11 Sep 2022 22:06:38 -0700 (PDT)
X-Gm-Message-State: ACgBeo3tUTihnywY0fphUn9T+sI1wZWFvMploJAaZYOoKT5lhNPodyQ4
        QHnwLtZvv+PdcwD1OFsoj9LEnaXYi5/Mz2CdCh4=
X-Google-Smtp-Source: AA6agR7RI6peqGquiKTA+DIWY4wXWAPeqqx4HPFvu7GhGMU/0N0J8lGDz3uQiVUHhgqCFSnq+AMtHUP5S3denw95608=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr10746548oab.287.1662959197332; Sun, 11
 Sep 2022 22:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220909090024.47458048@canb.auug.org.au> <CAK7LNARPX2Ov-nLAT6mPWbgqQMDCuoW84VN_C2sS1CJkR_n8YQ@mail.gmail.com>
 <20220909152453.5400cf7e@canb.auug.org.au> <20220909161354.2c94a495@canb.auug.org.au>
 <CAK7LNATR0-Y_yHTcD62J4N36T-_4G=-N1me8EWYNTNYbwXerDw@mail.gmail.com>
 <20220909174904.0342dcb8@canb.auug.org.au> <CAK7LNARiW66Hk5JJgRYb-edkb6sgTWPbNr1iETkq-RASCo-YkA@mail.gmail.com>
 <20220912095559.26de75c9@canb.auug.org.au>
In-Reply-To: <20220912095559.26de75c9@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 12 Sep 2022 14:06:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNARiGrDcnkFFH8fZMpAVyUePRr58Zz_=nUf7nicfiKoQyg@mail.gmail.com>
Message-ID: <CAK7LNARiGrDcnkFFH8fZMpAVyUePRr58Zz_=nUf7nicfiKoQyg@mail.gmail.com>
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

On Mon, Sep 12, 2022 at 8:59 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Masahiro,
>
> On Fri, 9 Sep 2022 19:30:24 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > The following fix will make it working again.
> >
>  diff --git a/Makefile b/Makefile
> > index b459e3d0fc5a..c8fba03ec93c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1151,7 +1151,6 @@ quiet_cmd_autoksyms_h = GEN     $@
> >  $(autoksyms_h):
> >         $(call cmd,autoksyms_h)
> >
> > -targets += vmlinux.o
> >  vmlinux.o: autoksyms_recursive $(KBUILD_VMLINUX_OBJS)
> > $(KBUILD_VMLINUX_LIBS) FORCE
> >         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
>
> Thank you.  The kbuild tree merge builds fine again.
>
> --
> Cheers,
> Stephen Rothwell



That is good news.




BTW, as you may have noticed already,
sub-directories are now listed in ./Kbuild.


So, you will need to move the rust/ entry accordingly.




obj-$(CONFIG_IO_URING)  += io_uring/
obj-$(CONFIG_RUST)      += rust/              <--- Move from Makefile
obj-y                   += drivers/



I have not tested the merge result, though.






--
Best Regards
Masahiro Yamada
