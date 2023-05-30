Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28880715EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjE3MQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjE3MQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:16:37 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6D5B102;
        Tue, 30 May 2023 05:16:33 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id EF2E692009C; Tue, 30 May 2023 14:16:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E80CB92009B;
        Tue, 30 May 2023 13:16:32 +0100 (BST)
Date:   Tue, 30 May 2023 13:16:32 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and
 M5150
In-Reply-To: <BCECE3BF-7A4D-43BF-8AA8-2232D974CD71@flygoat.com>
Message-ID: <alpine.DEB.2.21.2305301315120.42601@angie.orcam.me.uk>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com> <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk> <684C1A48-C743-4045-AF12-B0846FCE8EBE@flygoat.com> <alpine.DEB.2.21.2305301152080.42601@angie.orcam.me.uk>
 <BCECE3BF-7A4D-43BF-8AA8-2232D974CD71@flygoat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023, Jiaxun Yang wrote:

> > Sure, but this change is not needed for it.  You just need to declare 
> > which ISA revisions your platform supports and leave `__get_cpu_type' 
> > alone.  It has worked like that for a decade now.
> 
> I’m afraid it won’t work as you expected.
> 
> Actually I ran into a problem that `case CPU_P5600` in c-r4k.c is optimised out
> by compiler, because the codepath is marked as unreachable.

 Maybe there's a bug elsewhere then.  Send me your .config and I'll try to 
reproduce it.

  Maciej
