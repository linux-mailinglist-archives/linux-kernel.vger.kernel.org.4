Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9C6C9C00
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjC0HaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjC0HaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:30:01 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7341705
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:29:59 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by baptiste.telenet-ops.be with bizsmtp
        id dKVx2900j1C8whw01KVxHD; Mon, 27 Mar 2023 09:29:58 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pghIj-00ExIC-Qs;
        Mon, 27 Mar 2023 09:29:57 +0200
Date:   Mon, 27 Mar 2023 09:29:57 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linux-wireless@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        sparclinux@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.3-rc4
In-Reply-To: <20230327072641.3591802-1-geert@linux-m68k.org>
Message-ID: <eb55ca34-ca71-ed19-dae2-6e5e87c170@linux-m68k.org>
References: <CAHk-=whcaHLNpb7Mu_QX7ABwPgyRyfW-V8=v4Mv0S22fpjY4JQ@mail.gmail.com> <20230327072641.3591802-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.3-rc4[1] to v6.3-rc3[3], the summaries are:
>  - build errors: +9/-1

   + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6163:45

sh4-gcc11/sh-allmodconfig
seen before

   + error: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!:  => N/A
   + error: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!:  => N/A

sparc64-gcc11/sparc-allmodconfig
seen before

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/197b6b60ae7bc51dd0814953c562833143b292aa/ (all 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e8d018dd0257f744ca50a729e3d042cf2ec9da65/ (all 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
