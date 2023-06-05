Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6BE722354
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjFEKX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjFEKX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:23:27 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89E0A1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:23:26 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:f07e:6d89:4e02:be9])
        by laurent.telenet-ops.be with bizsmtp
        id 5NPP2A00940Pbp601NPPs3; Mon, 05 Jun 2023 12:23:24 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q67Mx-00BeIq-Qr;
        Mon, 05 Jun 2023 12:23:23 +0200
Date:   Mon, 5 Jun 2023 12:23:23 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: Build regressions/improvements in v6.4-rc5
In-Reply-To: <20230605101536.1864030-1-geert@linux-m68k.org>
Message-ID: <ef69a925-966e-7c8c-394-5a1d17f87036@linux-m68k.org>
References: <CAHk-=wifuPqAFXQQTTLkp_+FMzxGFHpSG-hEtZazG-46s=noAw@mail.gmail.com> <20230605101536.1864030-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.4-rc5[1] to v6.4-rc4[3], the summaries are:
>  - build errors: +2/-4

arm64-gcc5/arm64-allmodconfig (seen before)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9561de3a55bed6bdd44a12820ba81ec416e705a7/ (151 out of 152 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7877cb91f1081754a1487c144d85dc0d2e2e7fc4/ (151 out of 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
