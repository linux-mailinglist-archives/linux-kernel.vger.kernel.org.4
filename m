Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4969426D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjBMKMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjBMKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:11:55 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E151E3A7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:11:53 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:5d34:d0af:a884:130e])
        by laurent.telenet-ops.be with bizsmtp
        id LaBq2900Q3vMoCy01aBqf9; Mon, 13 Feb 2023 11:11:51 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pRVoM-008u3i-AL;
        Mon, 13 Feb 2023 11:11:50 +0100
Date:   Mon, 13 Feb 2023 11:11:50 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Build regressions/improvements in v6.2-rc8
In-Reply-To: <20230213100542.328169-1-geert@linux-m68k.org>
Message-ID: <7154f87-ca35-4d13-7a7c-1e29105d3b8c@linux-m68k.org>
References: <CAHk-=wj1=T1KzpPWbhqfFWOEp5Wf_kj3JjTHSHmEngf0-Vv7aA@mail.gmail.com> <20230213100542.328169-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.2-rc8[1] to v6.2-rc7[3], the summaries are:
>  - build errors: +11/-1

   + {standard input}: Error: unrecognized opcode: `dcbfl':  => 5736, 4743, 4327, 4476, 4447, 5067, 4602, 5212, 5224, 4298, 5594, 4315, 5050, 5195, 4464, 5079
   + {standard input}: Error: unrecognized opcode: `dlmzb.':  => 2848, 18800, 2842, 2383, 106, 2377, 3327, 112
   + {standard input}: Error: unrecognized opcode: `iccci':  => 204, 163, 510
   + {standard input}: Error: unrecognized opcode: `lbarx':  => 570, 196
   + {standard input}: Error: unrecognized opcode: `mbar':  => 887, 558, 1172, 539, 516, 837, 1457, 1125, 815, 7523, 1100, 1385, 368, 703, 662, 468, 441, 1410
   + {standard input}: Error: unrecognized opcode: `mfdcr':  => 3589, 4358, 3565, 3493, 3614, 128, 3445, 276, 3518, 3541, 3469, 4413
   + {standard input}: Error: unrecognized opcode: `mtdcr':  => 265, 4402, 4430, 4375, 4388, 4347, 117, 4443
   + {standard input}: Error: unrecognized opcode: `stbcx.':  => 196, 570
   + {standard input}: Error: unrecognized opcode: `tlbwe':  => 475, 476, 477

powerpc-gcc11/ppc64_book3e_allmodconfig
powerpc-gcc11/powerpc-allmodconfig
powerpc-gcc11/corenet64_smp_defconfig
powerpc-gcc11/powerpc-allyesconfig
powerpc-gcc11/44x/fsp2_defconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ceaa837f96adb69c0df0397937cd74991d5d821a/ (all 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4ec5183ec48656cec489c49f989c508b68b518e3/ (all 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
