Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6327C5FEC41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 12:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJNKGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 06:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJNKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 06:06:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A2A558ED;
        Fri, 14 Oct 2022 03:06:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 58D1A210E6;
        Fri, 14 Oct 2022 10:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665741984;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3jOl8gRn53zY9VNX7PfkIKoK/NWxcfZizAA6mvNxSBw=;
        b=Gg08K8xPxQzdBvaQ2mRSbwRLrQTnboSmS7B/2e22y8d5raRjb/4b9vADfjpxX4mhynem+l
        jQWSdhcNjLUbywlhMEXL/h742RYkc8/bz1/UrWGUGl2pRbx679Gmlcu0B/b8gQyaAueX8o
        LPaPOLGDfgujtMDmSk7Q0pw9PbEgU8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665741984;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3jOl8gRn53zY9VNX7PfkIKoK/NWxcfZizAA6mvNxSBw=;
        b=AxmlGtFUwzwvA5WbzReI/JvNgYa0tnPd6CKbzt66SbS9Od511n/M2eNhPUsSeol0ZmIyaR
        Xuhgkc0yomc5oyDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2ECF513A4A;
        Fri, 14 Oct 2022 10:06:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LzehCqA0SWOeNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Oct 2022 10:06:24 +0000
Date:   Fri, 14 Oct 2022 12:06:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [GIT PULL] Kbuild updates for v6.1-rc1
Message-ID: <20221014100617.GC13389@suse.cz>
Reply-To: dsterba@suse.cz
References: <CAK7LNASzGEiQfPTaLmhG4k7VAwB5yznd-VqWdJHEF2YjgSQTcA@mail.gmail.com>
 <20221014094930.GB13389@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014094930.GB13389@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 11:49:30AM +0200, David Sterba wrote:
> On Thu, Oct 06, 2022 at 11:29:44PM +0900, Masahiro Yamada wrote:
> > Masahiro Yamada (35):
> >       kbuild: remove the target in signal traps when interrupted
> >       kbuild: add phony targets to ./Kbuild
> >       kbuild: hard-code KBUILD_ALLDIRS in scripts/Makefile.package
> >       kbuild: check sha1sum just once for each atomic header
> >       kbuild: do not deduplicate modules.order
> >       nios2: move core-y in arch/nios2/Makefile to arch/nios2/Kbuild
> >       kbuild: remove duplicated dependency between modules and modules_check
> 
> This patch merged as f75a03340c2c2eea772e4d59412135021afea493 breaks
> build of modules when it's specified by path like 'make fs/btrfs/'. The
> 'make M=fs/btrfs' works but I don't see any reason why the former should
> stop working. Also the patch does not mention anything like that so it's
> most likely a bug.

Sorry, it must be a different commit, the build works on that one.
Here's the full bisect log:

# bad: [9c9155a3509a2ebdb06d77c7a621e9685c802eac] Merge tag 'drm-next-2022-10-14' of git://anongit.freedesktop.org/drm/drm
# good: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
git bisect start 'master' 'v6.0'
# good: [7171a8da00035e7913c3013ca5fb5beb5b8b22f0] Merge tag 'arm-dt-6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 7171a8da00035e7913c3013ca5fb5beb5b8b22f0
# good: [bdc753c7fcb4eb009ae246a188ea7ac6dac98ce1] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect good bdc753c7fcb4eb009ae246a188ea7ac6dac98ce1
# bad: [27bc50fc90647bbf7b734c3fc306a5e61350da53] Merge tag 'mm-stable-2022-10-08' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 27bc50fc90647bbf7b734c3fc306a5e61350da53
# bad: [d4013bc4d49f6da8178a340348369bb9920225c9] Merge tag 'bitmap-6.1-rc1' of https://github.com/norov/linux
git bisect bad d4013bc4d49f6da8178a340348369bb9920225c9
# good: [e572410e47a4e9647d5d7a49ca699a1497378707] Merge tag 'signal-for-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
git bisect good e572410e47a4e9647d5d7a49ca699a1497378707
# good: [52abb27abfff8c5ddf44eef4d759f3d1e9f166c5] Merge tag 'slab-for-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
git bisect good 52abb27abfff8c5ddf44eef4d759f3d1e9f166c5
# bad: [8afc66e8d43be8edcf442165b70d50dd33091e68] Merge tag 'kbuild-v6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
git bisect bad 8afc66e8d43be8edcf442165b70d50dd33091e68
# good: [b520410654103086ccc0d339c0ff645d4c4dd697] Merge tag 'printk-for-6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux
git bisect good b520410654103086ccc0d339c0ff645d4c4dd697
# bad: [26ef40de5cbb24728a34a319e8d42cdec99f186c] kbuild: move .vmlinux.objs rule to Makefile.modpost
git bisect bad 26ef40de5cbb24728a34a319e8d42cdec99f186c
# bad: [a55f283e8b473a3124705934a17d0ad61e34e6c1] kbuild: generate include/generated/compile.h in top Makefile
git bisect bad a55f283e8b473a3124705934a17d0ad61e34e6c1
# good: [e30d448754284d6c7580b8f330e257e9801bec76] nios2: move core-y in arch/nios2/Makefile to arch/nios2/Kbuild
git bisect good e30d448754284d6c7580b8f330e257e9801bec76
# bad: [7f37181393a9aaa695187701bb38f356df1f1cf8] kbuild: move 'PHONY += modules_prepare' to the common part
git bisect bad 7f37181393a9aaa695187701bb38f356df1f1cf8
# bad: [f110e5a250e3c5db417e094b3dd86f1c135291ca] kbuild: refactor single builds of *.ko
git bisect bad f110e5a250e3c5db417e094b3dd86f1c135291ca

f110e5a250e3c5d "kbuild: refactor single builds of *.ko"

that looks plausible but reverting the commit does not make it work.
