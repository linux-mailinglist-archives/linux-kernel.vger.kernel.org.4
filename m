Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5AF627005
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 15:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiKMOOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 09:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMOON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 09:14:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA328BE17
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 06:14:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74F38B80C73
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 14:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460F7C433C1;
        Sun, 13 Nov 2022 14:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668348849;
        bh=0N0faY7nLSbLb2KNcD5w20O8mhRpdTYXbjsNeB1Wlt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFEcQYM9Q52ZQjb9z3Sbl6pkgL6/Qid2n6rVNELB/BJX+fiDscq/7oV3zt25Fbf4C
         6QjMw91fuBwzG5LKeHiTCzGvLXMR56+xHvHQntXP9v/5TADr/0hnm/27nizNFfMbr9
         RiAyqAGeaJKsTzIVLCmFte1UdCVyt6Da25rb4m/P9PwU3V4GYCT+JbtYH9SdWGDxPU
         gwxgal1qIJbIbpL3dJ0w5ObhU6ToxJysx5bCurH9iqc3jRlVJysOCICMmr9CKHG1Jd
         HIn0DGhpf9T+SNlzWXX/zIJBbyr9TqBI2qLr7AmUa+njOTDTQm4n/uLbMYoSmT8617
         iadKYky65LMCw==
Date:   Sun, 13 Nov 2022 14:14:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     debug@rivosinc.com
Cc:     palmer@dabbelt.com, jan.kiszka@siemens.com, kbingham@kernel.org,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux@rivosinc.com
Subject: Re: [PATCH] gdb-script: updated lx_current for riscv
Message-ID: <Y3D7rF34CAI+bZQx@spud>
References: <20221111195938.1499148-1-debug@rivosinc.com>
 <20221111195938.1499148-2-debug@rivosinc.com>
 <Y3A2tPFbqcf1DPr5@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3A2tPFbqcf1DPr5@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 12:13:40AM +0000, Conor Dooley wrote:
> On Fri, Nov 11, 2022 at 11:59:38AM -0800, debug@rivosinc.com wrote:
> > From: Deepak Gupta <debug@rivosinc.com>
> > 
> > lx_current python gdb command defined in scripts/gdb/cpus.py updated
> > to support riscv architecture.
> 
> The commit which added support for arm64 gave an explanation of why
> SP_EL0 needed to be checked. Would be nice if you could do the same here
> for RISC-V. See 526940e39626 ("scripts/gdb: add lx_current support for
> arm64") for what I mean.
> 
> While you're at it, "scripts/gdb: add support for RISC-V" would appear

Realised I omitted a word there, sorry: s/add support/add lx_current support/

> to be a more standard $subject for this file.
> 
> Thanks,
> Conor.
> 
> > 
> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > ---
> >  scripts/gdb/linux/cpus.py | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> > index 15fc4626d236..ce6703f1e35a 100644
> > --- a/scripts/gdb/linux/cpus.py
> > +++ b/scripts/gdb/linux/cpus.py
> > @@ -173,6 +173,14 @@ def get_current_task(cpu):
> >           else:
> >               raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
> >                                  "while running in userspace(EL0)")
> > +    elif utils.is_target_arch("riscv"):
> > +         current_task_addr = gdb.parse_and_eval("$tp")
> > +         if((current_task_addr.cast(utils.get_long_type()) >> 63) != 0):
> > +             current_task = current_task_addr.cast(task_ptr_type)
> > +             return current_task.dereference()
> > +         else:
> > +             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
> > +                                "while running in userspace")
> >      else:
> >          raise gdb.GdbError("Sorry, obtaining the current task is not yet "
> >                             "supported with this arch")
> > -- 
> > 2.25.1
> > 
