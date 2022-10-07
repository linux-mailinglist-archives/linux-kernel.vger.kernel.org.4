Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7DB5F7AC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJGPnr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Oct 2022 11:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJGPnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:43:45 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A685D73C8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:43:44 -0700 (PDT)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 13EF712131A;
        Fri,  7 Oct 2022 15:43:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 8BFEC20012;
        Fri,  7 Oct 2022 15:43:20 +0000 (UTC)
Message-ID: <62acd27e418ff202ef2ffedd2474ae7f53f93368.camel@perches.com>
Subject: Re: [PATCH v2 1/3] mtd: mtdoops: change printk() to counterpart pr_
 functions
From:   Joe Perches <joe@perches.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Ray Zhang <sgzhang@google.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Oct 2022 08:43:39 -0700
In-Reply-To: <20221007095236.37113034@xps-13>
References: <20221007065042.700761-1-sgzhang@google.com>
         <20221007065042.700761-2-sgzhang@google.com>
         <070d253e718c1a6d72fb52c1d2f02ec461d825a1.camel@perches.com>
         <20221007095236.37113034@xps-13>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8BFEC20012
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: za138si87dtfybssdp7nwo3qnip19zdb
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18P8E5dDtrUnR65WTaWOg4rMOxd5qzw2vI=
X-HE-Tag: 1665157400-298926
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-07 at 09:52 +0200, Miquel Raynal wrote:
> Hi Joe, Ray,
> 
> joe@perches.com wrote on Fri, 07 Oct 2022 00:09:26 -0700:
> 
> > On Fri, 2022-10-07 at 06:50 +0000, Ray Zhang wrote:
> > > To comply with latest kernel code requirement, change printk() to
> > > counterpart pr_ functions in mtdoops driver:
> > > - change printk(INFO) to pr_info()
> > > - change printk(DEBUG) to pr_debug()  
> > 
> > There is a different behavior with printk(KERN_DEBUG to pr_debug(
> > as pr_debug is a no-op unless dynamic debugging is enabled or
> > DEBUG is defined.
> 
> I didn't know about this difference. I was expecting printk(KERN_DEBUG)
> to behave the same as pr_debug/dev_dbg.

No worries.  Most people do not know this trivia.

I just wanted to inform in case it matters here.
Likely it does not matter.

> But honestly in this driver I feel fine changing the printk(KERN_DEBUG)
> into pr_debug().

Your choice...
