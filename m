Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F36F7159A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjE3JNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjE3JNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:13:50 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42FB9EC;
        Tue, 30 May 2023 02:13:49 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id EEDC992009C; Tue, 30 May 2023 11:13:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E8B7A92009B;
        Tue, 30 May 2023 10:13:47 +0100 (BST)
Date:   Tue, 30 May 2023 10:13:47 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Paul Cercueil <paul@crapouillou.net>
cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and
 M5150
In-Reply-To: <45a42e25658393e3767071960214b0ff47f0737b.camel@crapouillou.net>
Message-ID: <alpine.DEB.2.21.2305301011580.25569@angie.orcam.me.uk>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>  <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk> <45a42e25658393e3767071960214b0ff47f0737b.camel@crapouillou.net>
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

Hi Paul,

> >  I don't know why CPU_XBURST is also listed as both R1 and R2, the
> > history 
> > looks convoluted with no explanation.  Paul, is the CPU also dual-
> > revision 
> > or is it just a bug and it is supposed to be listed under one ISA
> > revision
> > only, presumably R2?
> 
> The XBurst CPU is R1 in older Ingenic SoCs (JZ4760B and older), and R2
> in newer SoCs (JZ4770 and newer).

 Great, thanks for confirming.  So the current arrangement is right and 
still we don't want to dual-list the P5600 or M5150.

  Maciej
