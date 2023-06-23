Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9A73AEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFWCcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFWCco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:32:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D611706;
        Thu, 22 Jun 2023 19:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xE1C24/lOyIj9IRbTbWR5/l6UaBcPrS9L49Zb3ZxlL0=; b=fj6j9TJyOUwx/I2H7kk/hHJMJX
        /Dcnt3VgJDz6cdL2Hz+z32T+wd5elrijJOwf9TOl6Rm9uRrma3oM66Eg/f4IBWN94Y/KAuSJ/SLAc
        tIKQMd1zoPL1wuG7gkFZX9LV+G8oFxZWzVIt87eQWD+cxEjEylQpVCsgS4H/igPHdno2sRoOZuBpl
        T6yfxjqYDvt+t/1TvViR/OOAuKbESE/gmWqnviLdeVfgr9Pg0ZEr4xoPbRpBZtiANBIKd+/5EFBQ7
        +QZawx+BkIwgncROL0PE3VLCZbdO2BwcqOrim6ozC2rUR+LW0A09lPDeXjy7xWOkqMpLVcPARRT1H
        w7eawjMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCWb6-00G6hp-Qd; Fri, 23 Jun 2023 02:32:28 +0000
Date:   Fri, 23 Jun 2023 03:32:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and the
 wider community
Message-ID: <ZJUEPPSIRsOFNoWP@casper.infradead.org>
References: <20230620212502.GI286961@mit.edu>
 <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:51:19AM +1000, Finn Thain wrote:
> - The roles of maintainer and reviewer should be taught in universities at 
>   a post-graduate level to increase the talent pool.

Umm.  I can't say that I know anyone who studied computer science at a
post-graduate level and then became a Linux maintainer.  They probably
exist, but I'm not aware of them.  In contrast, I can name two people
who started a PhD in another subject and then got lured into Linux
development, abandoning their PhD.  I suspect most have a bachelors.
Some do not have a degree.

I don't think it's the role of a computer science department to do
this kind of teaching.  It feels more practical.  Now maybe it's part
of a software engineering curriculum, but then I don't think it's a
post-graduate topic.

It could also be something a professional society pushes.  The British
Computer Society were really into that kind of thing twenty-five years
ago when they were trying to persuade me to join.
