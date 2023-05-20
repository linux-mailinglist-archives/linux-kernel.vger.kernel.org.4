Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E6270A6B9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 11:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjETJd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 05:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjETJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 05:33:28 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61B8E1B4
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 02:33:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34K9X7q5027290;
        Sat, 20 May 2023 11:33:07 +0200
Date:   Sat, 20 May 2023 11:33:07 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulmck@kernel.org
Subject: Re: Re: [PATCH 1/2] tools/nolibc: riscv: Fix up load/store
 instructions for rv32
Message-ID: <20230520093307.GA27287@1wt.eu>
References: <20230520085052.GC27206@1wt.eu>
 <20230520091144.30599-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520091144.30599-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 05:11:44PM +0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> This is a full commit message for this patch:
> 
> When compile for rv32, we got such error:
> 
> ---
> 
> nolibc/sysroot/riscv/include/arch.h:190: Error: unrecognized opcode `ld a4,0(a3)'
> nolibc/sysroot/riscv/include/arch.h:194: Error: unrecognized opcode `sd a3,%lo(_auxv)(a4)'
> nolibc/sysroot/riscv/include/arch.h:196: Error: unrecognized opcode `sd a2,%lo(environ)(a3)'
> 
> Refer to arch/riscv/include/asm/asm.h and add REG_L/REG_S macros here to let
> rv32 use its own lw/sw instructions.
> 
> ---

That's fine, thank you!

> I will send a new version with the above full message for you, wait for a
> while, very sorry ;-)

Don't waste your time resending, I can perfectly take that one and
put it into the series.

Thanks!
Willy
