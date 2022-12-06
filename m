Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A552D643F35
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiLFI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiLFI7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:59:47 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE5A1B1C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:59:45 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:947e:1fc0:ebbb:447b])
        by baptiste.telenet-ops.be with bizsmtp
        id swzj2800A4BwbnS01wzjWS; Tue, 06 Dec 2022 09:59:43 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1p2Tnj-002ibG-8h; Tue, 06 Dec 2022 09:59:43 +0100
Date:   Tue, 6 Dec 2022 09:59:43 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linux-wireless@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.1-rc8
In-Reply-To: <20221206085158.349363-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2212060957480.648028@ramsan.of.borg>
References: <CAHk-=wgyXu4D44b8wQU9dpTYUft6WhZ0wr3nV1fziy6k0GwCCw@mail.gmail.com> <20221206085158.349363-1-geert@linux-m68k.org>
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

On Tue, 6 Dec 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.1-rc8[1] to v6.1-rc7[3], the summaries are:
>  - build errors: +1/-3

   + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6152:45

sh4-gcc11/sh-allmodconfig

Looks like a real issue, albeit not new (but never seen before?).

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/76dcd734eca23168cb008912c0f69ff408905235/ (all 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b7b275e60bcd5f89771e865a8239325f86d9927d/ (all 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
