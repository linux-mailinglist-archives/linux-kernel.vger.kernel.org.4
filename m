Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7765FE7B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJNDsY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Oct 2022 23:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJNDsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:48:19 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC47E192984
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:48:14 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id A901C401DE;
        Fri, 14 Oct 2022 03:48:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id AD57B20028;
        Fri, 14 Oct 2022 03:48:00 +0000 (UTC)
Message-ID: <3251b73cce77964413e01d4f5361de48942e98ae.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Add the --for-tree argument
From:   Joe Perches <joe@perches.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 13 Oct 2022 20:48:10 -0700
In-Reply-To: <mhng-220de489-6329-41ce-9a6f-d7acdd73344c@palmer-ri-x1c9a>
References: <mhng-220de489-6329-41ce-9a6f-d7acdd73344c@palmer-ri-x1c9a>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: ugof11ur5ew5jqn5rwc5f3jtw4hykyww
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: AD57B20028
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19KudPR12seH2SBnua8sGthUr5XMtuNAFE=
X-HE-Tag: 1665719280-754373
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-13 at 19:56 -0700, Palmer Dabbelt wrote:
> On Thu, 13 Oct 2022 17:39:53 PDT (-0700), joe@perches.com wrote:
> > On Thu, 2022-10-13 at 14:57 -0700, Palmer Dabbelt wrote:
> > > I recently wanted to look up the maintainers for each tree path via a
> > > script, and I couldn't find a better way to do that than poking
> > > get_maintainer.pl to add a new argument.  This lets folks run something
> > > like
> > > 
> > >     $ ./scripts/get_maintainer.pl --for-tree git://github.com/kvm-riscv/linux.git
> > >     Anup Patel <anup@brainfault.org> (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
> > >     kvm@vger.kernel.org (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
> > >     kvm-riscv@lists.infradead.org (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
> > >     linux-riscv@lists.infradead.org (maintainer:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv))
> > > 
> > > to find out who owns a tree.
> > 
> > I'm not sure this is useful.
[]
> Generally sound like you 
> don't want this one so I'm going to punt on fixing these for now, I 
> don't care all that much about having this merged.
> 
> LMK if you want a v2, though.

I think it's not necessary.

Thanks,  Joe
