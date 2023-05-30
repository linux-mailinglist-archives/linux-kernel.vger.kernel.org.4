Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5677157DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjE3IDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjE3IDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:03:39 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CD2CA8;
        Tue, 30 May 2023 01:03:34 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8A96192009C; Tue, 30 May 2023 10:03:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8397492009B;
        Tue, 30 May 2023 09:03:32 +0100 (BST)
Date:   Tue, 30 May 2023 09:03:32 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Cercueil <paul@crapouillou.net>
cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and
 M5150
In-Reply-To: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
Message-ID: <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
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

On Mon, 29 May 2023, Jiaxun Yang wrote:

> M5150 and P5600 are two MIPS32R5 kernels, however as MIPS32R5 is
> backward compatible with MIPS32R2 there is no reason to forbid
> M5150 and P5600 on MIPS32R2 kernel.

 What problem are you trying to solve?  The CONFIG_SYS_HAS_CPU_* settings 
denote overall platform's support for the given CPU and have nothing to do 
with what architecture level a given kernel has been configured for.  You 
do need to get the settings right for your platform, just as you do in 
2/2, but this 1/2 part looks wrong to me.

 NB CPU_4KEC is double-listed as R1 and R2 because early revisions of the 
4KEc core were actually R1 before switching to R2, so this CPU can report 
either revision.

 I don't know why CPU_XBURST is also listed as both R1 and R2, the history 
looks convoluted with no explanation.  Paul, is the CPU also dual-revision 
or is it just a bug and it is supposed to be listed under one ISA revision
only, presumably R2?

  Maciej
