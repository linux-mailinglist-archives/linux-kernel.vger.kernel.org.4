Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665346813E6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbjA3O5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3O5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:57:41 -0500
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Jan 2023 06:57:39 PST
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748102942E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:57:39 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:248c:95e8:a1ca:b26b])
        by xavier.telenet-ops.be with bizsmtp
        id F2sc2900x0Ggu3t012scby; Mon, 30 Jan 2023 15:52:36 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pMVWO-007t2N-Kb;
        Mon, 30 Jan 2023 15:52:36 +0100
Date:   Mon, 30 Jan 2023 15:52:36 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linux-mips@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.2-rc6
In-Reply-To: <20230130144829.4116738-1-geert@linux-m68k.org>
Message-ID: <556e38d-4eec-abf-e7ac-137a3f7b366d@linux-m68k.org>
References: <CAHk-=wiJcsgmgjEitJ97x3unFpaKv1d=YyNr_5NbOTGsGqCG=A@mail.gmail.com> <20230130144829.4116738-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.2-rc6[1] to v6.2-rc5[3], the summaries are:
>  - build errors: +4/-1

   + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: 'gimple_call_addr_fndecl' was not declared in this scope:  => 2790:10
   + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: 'is_gimple_reg' was not declared in this scope:  => 2556:18
   + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: field 'call_clobbered' has incomplete type 'pt_solution':  => 284:22
   + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: field 'call_used' has incomplete type 'pt_solution':  => 283:22

mipsel-gcc5/mips-allmodconfig

Looks like an issue with the gcc plugins installed on kisskb.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6d796c50f84ca79f1722bb131799e5a5710c4700/ (all 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2241ab53cbb5cdb08a6b2d4688feb13971058f65/ (all 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
