Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EFE7349B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjFSBaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFSB37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:29:59 -0400
X-Greylist: delayed 6276 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Jun 2023 18:29:58 PDT
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DB2CD1;
        Sun, 18 Jun 2023 18:29:58 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5DA7392009C; Mon, 19 Jun 2023 03:29:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 523E792009B;
        Mon, 19 Jun 2023 02:29:57 +0100 (BST)
Date:   Mon, 19 Jun 2023 02:29:57 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Sam Ravnborg <sam@ravnborg.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
In-Reply-To: <ea8b0e25-fd2e-4fe1-3157-7556e29eee87@infradead.org>
Message-ID: <alpine.DEB.2.21.2306190202050.14084@angie.orcam.me.uk>
References: <20230406160548.25721-1-rdunlap@infradead.org> <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk> <20230406203207.GA1534216@ravnborg.org> <alpine.DEB.2.21.2304062144520.44308@angie.orcam.me.uk> <20230407200313.GA1655046@ravnborg.org>
 <alpine.DEB.2.21.2304072142290.62619@angie.orcam.me.uk> <a05558c3-8d5c-c389-ba4c-be134c75ac1c@infradead.org> <alpine.DEB.2.21.2306190000530.14084@angie.orcam.me.uk> <ea8b0e25-fd2e-4fe1-3157-7556e29eee87@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

> >  What happened to DaveM?
> 
> I haven't seen him merge any arch/sparc/ patches lately.
> I have a couple that are still pending.

 Oh, I hope he's been doing good then, and it's just a change of life 
priorities or suchlike.  Patch reviews can take a lot of mental effort, 
and I can't claim I've been as effective as I wished to with stuff that 
lands on my plate either.

> >  In any case after a couple of iterations I have made a succesful build of 
> > a 32-bit SPARC toolchain now, which I was able to verify a fix with I have 
> 
> Is your newly built toolchain for riscv hosting?

 Are you asking whether the SPARC toolchain has been built/installed on a 
RISC-V system?  If so, then no, it hasn't.  It runs on POWER9.

  Maciej
