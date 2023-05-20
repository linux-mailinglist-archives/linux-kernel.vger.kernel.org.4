Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF9A70A67E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 10:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjETIvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 04:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjETIvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 04:51:06 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49FFABD
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 01:51:05 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34K8oqrM027225;
        Sat, 20 May 2023 10:50:52 +0200
Date:   Sat, 20 May 2023 10:50:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: riscv: Fix up load/store instructions
 for rv32
Message-ID: <20230520085052.GC27206@1wt.eu>
References: <cover.1684425792.git.falcon@tinylab.org>
 <1425d092ef4c1242646ede2bbcbc3ac945c2b274.1684425792.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425d092ef4c1242646ede2bbcbc3ac945c2b274.1684425792.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhangjin,

On Fri, May 19, 2023 at 01:02:12AM +0800, Zhangjin Wu wrote:
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/arch-riscv.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

I'm having a comment regarding this one (which for now I've queued so that
Thomas can rebase his series), please provide a real commit message that
explains the purpose of the change and the solutions chosen. Feel free
to copy-paste from your cover letter if that fits, it's just that I do
want to see some justification for a change in the commit message itself
(i.e think about the poor person seeing a bisect stop on that one).

You can send me a paragraph or two and I'll happily copy them into my
local copy of the rebased commit.

Thank you!
Willy
