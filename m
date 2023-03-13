Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EB56B70E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCMIQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCMIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:16:43 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B583B2A9B6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:16:41 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:7ed1:e2c6:b94:264a])
        by andre.telenet-ops.be with bizsmtp
        id XkGf2900Y01Vtj801kGfhK; Mon, 13 Mar 2023 09:16:39 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbdMF-00C2KS-LJ;
        Mon, 13 Mar 2023 09:16:39 +0100
Date:   Mon, 13 Mar 2023 09:16:39 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linux-wireless@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.3-rc2
In-Reply-To: <20230313081127.636659-1-geert@linux-m68k.org>
Message-ID: <4753f327-0ab-bdf1-aa0-6044ca9dc776@linux-m68k.org>
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com> <20230313081127.636659-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.3-rc2[1] to v6.3-rc1[3], the summaries are:
>  - build errors: +1/-0

   + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6163:45

sh4-gcc11/sh-allmodconfig

Seen before, missing error checking in (all) calls to readStatusRid().

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/eeac8ede17557680855031c6f305ece2378af326/ (all 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fe15c26ee26efa11741a7b632e9f23b01aca4cc6/ (all 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
