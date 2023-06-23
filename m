Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9724773BBB3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjFWPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:33:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43772 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjFWPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:33:37 -0400
Received: from localhost (cpc147930-brnt3-2-0-cust60.4-2.cable.virginm.net [86.15.196.61])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id C09158465432;
        Fri, 23 Jun 2023 08:33:35 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:33:29 +0100 (BST)
Message-Id: <20230623.163329.1458342120776268478.davem@davemloft.net>
To:     macro@orcam.me.uk
Cc:     rdunlap@infradead.org, sam@ravnborg.org, schnelle@linux.ibm.com,
        linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
From:   David Miller <davem@davemloft.net>
In-Reply-To: <alpine.DEB.2.21.2306190202050.14084@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2306190000530.14084@angie.orcam.me.uk>
        <ea8b0e25-fd2e-4fe1-3157-7556e29eee87@infradead.org>
        <alpine.DEB.2.21.2306190202050.14084@angie.orcam.me.uk>
X-Mailer: Mew version 6.9 on Emacs 28.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 23 Jun 2023 08:33:37 -0700 (PDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Date: Mon, 19 Jun 2023 02:29:57 +0100 (BST)

> Hi Randy,
> 
>> >  What happened to DaveM?
>> 
>> I haven't seen him merge any arch/sparc/ patches lately.
>> I have a couple that are still pending.
> 
>  Oh, I hope he's been doing good then, and it's just a change of life 
> priorities or suchlike.  Patch reviews can take a lot of mental effort, 
> and I can't claim I've been as effective as I wished to with stuff that 
> lands on my plate either.

I'm good just too busy with networking and real life.

Thanks.
