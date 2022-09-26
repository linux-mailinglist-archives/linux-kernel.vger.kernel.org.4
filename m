Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F25E9D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiIZJ3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiIZJ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:29:09 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8F9DEF1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:27:51 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:b923:b6a4:31f6:7444])
        by michel.telenet-ops.be with bizsmtp
        id QZTp2800r0EchQB06ZTpQt; Mon, 26 Sep 2022 11:27:49 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ockOz-006HnW-Bg; Mon, 26 Sep 2022 11:27:49 +0200
Date:   Mon, 26 Sep 2022 11:27:49 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.0-rc7
In-Reply-To: <20220926085820.2990710-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2209261127060.1498357@ramsan.of.borg>
References: <CAHk-=wjc_CDPy5WbN=e_FtPrd0Yn2Wp4JcdRByeyDoM9azK1mA@mail.gmail.com> <20220926085820.2990710-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> JFYI, when comparing v6.0-rc7[1] to v6.0-rc6[3], the summaries are:
>  - build errors: +1/-16

   + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33

sh4-gcc11/sh-all{mod,yes}config
Seen in other sh4-gcc11 builds before

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f76349cf41451c5c42a99f18a9163377e4b364ff/ (all 135 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/521a547ced6477c54b4b0cc206000406c221b4d6/ (all 135 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
