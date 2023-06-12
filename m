Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9F472BCD7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjFLJiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjFLJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:37:28 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248326189
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:28:26 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:8f41:e69:ef53:9db3])
        by michel.telenet-ops.be with bizsmtp
        id 89UQ2A00B41JBE4069UQnQ; Mon, 12 Jun 2023 11:28:24 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q8dqa-008cV2-D4;
        Mon, 12 Jun 2023 11:28:24 +0200
Date:   Mon, 12 Jun 2023 11:28:24 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linux-um@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.4-rc6
In-Reply-To: <20230612090911.1579029-1-geert@linux-m68k.org>
Message-ID: <9c7f3e17-c1-1a3a-7e87-9b1ea25d9d7@linux-m68k.org>
References: <CAHk-=wgmbjQu3bVSa5JJhEymeQhkr7N3cjg-CoNLVituUnfW8w@mail.gmail.com> <20230612090911.1579029-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-85567032-1686562104=:2054603"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-85567032-1686562104=:2054603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 12 Jun 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.4-rc6[1] to v6.4-rc5[3], the summaries are:
>  - build errors: +5/-6

   + /kisskb/src/drivers/spi/spi-stm32-qspi.c: error: ‘op’ is used uninitialized [-Werror=uninitialized]:  => 523:27, 564:27

um-all{mod,yes}config

Seen before
(why did the type of quotes around 'op' in the compiler output change?)

   + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: field ‘call_clobbered’ has incomplete type ‘pt_solution’:  => 284:22
   + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: field ‘call_used’ has incomplete type ‘pt_solution’:  => 283:22
   + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: ‘gimple_call_addr_fndecl’ was not declared in this scope; did you mean ‘gimple_call_set_fndecl’?:  => 2790:10
   + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/gimple.h: error: ‘is_gimple_reg’ was not declared in this scope; did you mean ‘is_gimple_assign’?:  => 2556:18

mipsel-gcc5/mips-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/858fd168a95c5b9669aac8db6c14a9aeab446375/ (151 out of 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9561de3a55bed6bdd44a12820ba81ec416e705a7/ (151 out of 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
--8323329-85567032-1686562104=:2054603--
