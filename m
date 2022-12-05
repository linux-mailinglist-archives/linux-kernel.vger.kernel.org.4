Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B24642A69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiLEOcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiLEOcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:32:04 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81DC12771
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=gMUhJn01PNmaB5ePS6jMbGvmKgU5N/9Ep6unef2i9Is=; b=f+TphnqNcFdvRRdMgiiUrr7l/r
        uONhi6A7KYq76Srqyf6u657aFHq2p/elaPmGD9nRvshwAXwH5DI1x5Lqgfm8fPD03e21edMo/5nVg
        FLb2LzPNZhDqstq4Eg1Xe74m3MtIyTyjN2FDAo95ZOBOgivIJi1Q+26JYKLL7IAhyzq3jh7b6nhek
        I36w8dcRNKvEsJ1JcvKGCefbRCzstkTfal9KGmhOwNIVpCiqKqU/SptDvILkkRjS2JwqYwNuAuVL/
        6IOqmuh8Ne0V8r9ezaT9F4yneSKSbZCA6d/L/zq/BowhMvCT4HgGIlO70IZqVf4q5F1NE4+T6NGgY
        aggUypx7R4bWUTYRbdv/cmLFIjlWxoIoV/QyBsrTq89GmvM4HUgixJ9cFxKIosPdBFV1LvZ+UxPi4
        TduQMtFVCO6EwpWMpZQR/ThIHoKT0t5lTEPbhB4bJnxGeWPf5sOvCgyt6Bvp9dcCKRe55+eeMnz4V
        4DqBESusRDAyNKWVoAiecoftMiQsLid8B3Pi9tc4O31u2Vf9ue91ERcTJdYK+vltZjE7RaZTH/jCo
        9vk0QoFQQhK2qH8pErg7mX59ihvL0m5mKNt7DFVY+wiY2yPe3JFinXlDJupw0wGvNJz16/i90bMB7
        Duj23PzUNn8Q2r7jbrZynldCJ/O2txSaSgCzp2ZLY=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the v9fs tree
Date:   Mon, 05 Dec 2022 15:31:57 +0100
Message-ID: <46397336.ChKRcxMYMu@silver>
In-Reply-To: <Y41vKkaH9tvRXCfv@codewreck.org>
References: <20221205150316.6fac25f2@canb.auug.org.au> <Y41vKkaH9tvRXCfv@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 5, 2022 5:10:18 AM CET Dominique Martinet wrote:
> Stephen Rothwell wrote on Mon, Dec 05, 2022 at 03:03:16PM +1100:
> > After merging the v9fs tree, today's linux-next build (i386 defconfig)
> > failed like this:
[...]
> > net/9p/client.c:523:17: note: in expansion of macro 'pr_err'
> >   523 |                 pr_err(
> >       |                 ^~~~~~
> > cc1: all warnings being treated as errors
> > 
> > Caused by commit
> > 
> >   36cd2f80abf8 ("net/9p: fix response size check in p9_check_errors()")
> > 
> > I have applied the following patch for today:
> 
> Thank you!
> I guess I should start building one 32bit kernel somewhere...

:/ I'll setup a 32-bit build system as well, sorry!

Best regards,
Christian Schoenebeck


