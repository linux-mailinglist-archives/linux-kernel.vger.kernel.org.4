Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF7C5FB2B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJKM40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJKM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:56:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B0A923D1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hZqRab8Xh0kTKORmYeRboLgdwGLM+e9+FaiYThREHvk=; b=DmXvSUYqDdZ3gVd5XbBMI8azn1
        dhbQkhFJDe1ubWHkFlhmJb/yDdBDpcpxqaPnVgLjG+cMDZYQgknLY3vwjX/iHqwxUBWfhrOOENtjK
        ZZieGmZk5x4x0btdKloph/8ZY679Ae0LvJqcAJLmBNAlaiI08Bx7CYCmdNU5vYWeHt1BTwnDXhxzF
        WGlh1jXc0oLBweCWZzOjS5HPT5yeyeM0CzCGkSJUJDOgLZDRJjmlzou7n9SQx55zrM+jgYtY1Umyu
        gWIC6Z1wWuTFtrop2ibiom+BZm45AW+hwAIjZek9WWYlMENZJOm8bRUmDBU0cjRRa/nDtHwQ6Gu6O
        6hWOnFdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiEnu-004xxE-JH; Tue, 11 Oct 2022 12:56:14 +0000
Date:   Tue, 11 Oct 2022 13:56:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v14 07/70] lib/test_maple_tree: add testing for maple tree
Message-ID: <Y0Vn7o4nmy2FNkLC@casper.infradead.org>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
 <20220906194824.2110408-8-Liam.Howlett@oracle.com>
 <alpine.DEB.2.22.394.2210111414020.303227@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210111414020.303227@ramsan.of.borg>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:16:02PM +0200, Geert Uytterhoeven wrote:
> > lib/test_maple_tree.c             | 38307 ++++++++++++++++++++++++++++
> 
> Does this test really belong under lib/?
> All other test modules there can be compiled and run as part of the
> kernel itself.

So can this.  It's just like test_ida and test_xarray; it can be
built as a module, or it can be extracted into userspace and run there.

