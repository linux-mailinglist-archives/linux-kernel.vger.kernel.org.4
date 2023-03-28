Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902B96CB57C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 06:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjC1ErE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 00:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1ErB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 00:47:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6D41FEE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 21:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ypv8+CH7Q6NpkZf86J8lzL3Lc4pGkQmgM3WoxMZ0Be4=; b=BUesIyQeD48bsfZVTvqhiPR7jC
        bC/96figXudcJ6U6VQapH+2ONTJPPzOMnyj3rNrJxSTtf7QVGIFjgZgHqA8rKFfGJ+imfP4qGnfBE
        eGQWByJMOBrrEJKpB9HSmEeE/ha0YmTfI9/0DTnya000d0FwAhUzqNHHWxlMvuA0Nwa68UcImYYsO
        k7knV8JeBoJ2nhDIPsLVZ6oRMLGTObAfGzibKBN2rgmgKOGKxwSCW5zuZBv4oGPEfUzyFm5SHwcTn
        rjlmzELpdCtPVBsVKzZg84OnYp/gzbzmb5kxVryMB4g8ZEAlm5BesLzQbK3AQxB+5+wJRDUL1mgNJ
        U01zpcBg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ph1EQ-00D8Kw-1Q;
        Tue, 28 Mar 2023 04:46:50 +0000
Date:   Mon, 27 Mar 2023 21:46:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net,
        Josef Bacik <josef@toxicpanda.com>,
        Jeff Layton <jlayton@kernel.org>,
        Eric Van Hensbergen <ericvh@gmail.com>, lucho@ionkov.net,
        linux-kernel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: 9p regression linux-next next-20230327
Message-ID: <ZCJxOgV92yPc3zu1@bombadil.infradead.org>
References: <ZCI+7Wg5OclSlE8c@bombadil.infradead.org>
 <ZCJGjuOYR6nGXiAw@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCJGjuOYR6nGXiAw@codewreck.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:44:46AM +0900, asmadeus@codewreck.org wrote:
> I'm going to rant a bit here, but my main problem with testing is that
> there are plenty of tools, but I have very little compute available for
> this (just a small machine at home that's getting close to 10 years
> old...), as this is really a free time activity which isn't getting any
> funding.
> [read: happy to spend a bit more time on 9p if it's getting paid :P]

I think we can likely help with at least hardware access to help test 9p well.
If you're interested let me know!

  Luis
