Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1143168BCC5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBFM30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFM3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:29:23 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3C4F75B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:29:22 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:5f4c:1e23:9c34:1a39])
        by xavier.telenet-ops.be with bizsmtp
        id HoVL290013XDBUl01oVLXF; Mon, 06 Feb 2023 13:29:20 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pP0cZ-008DGp-VV;
        Mon, 06 Feb 2023 13:29:19 +0100
Date:   Mon, 6 Feb 2023 13:29:19 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linuxppc-dev@lists.ozlabs.org
Subject: Re: Build regressions/improvements in v6.2-rc7
In-Reply-To: <20230206122557.3512171-1-geert@linux-m68k.org>
Message-ID: <9765d21e-f53-64d-5862-f49b996c36b@linux-m68k.org>
References: <CAHk-=whSVeeQN9vO-WSxFkNs0zbUJEBqND-1VO8OJtmu_sn_nw@mail.gmail.com> <20230206122557.3512171-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.2-rc7[1] to v6.2-rc6[3], the summaries are:
>  - build errors: +1/-1

   + /kisskb/src/arch/powerpc/kexec/file_load_64.c: error: implicit declaration of function 'memory_hotplug_max' [-Werror=implicit-function-declaration]:  => 993:33

powerpc-gcc1[12]/pseries_le_defconfig+NO_NUMA (fix available)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4ec5183ec48656cec489c49f989c508b68b518e3/ (all 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6d796c50f84ca79f1722bb131799e5a5710c4700/ (all 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
