Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ACA6B105C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCHRoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHRoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:44:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00958136CA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hVlYW22a9H4WbVtUhENiaLSg/BVsrcRwxpU47Z6jYfI=; b=wUFyHJJFRm/W9C+KbbbQLDShKL
        8zmtCiBbugfrYh+ZZtIfj8CfdBNJ0Fr0kwQyxjgXB8yQ1vfz8NR8fEDByALiap6VqffsAbuNm03m4
        pyfT4vxxi4KNvAX+A8ENvidEGL0glxQ77WutIYBywdtZmv8yfkP/O58E+5LVzkZO4VW35NlDv4XwB
        lnauB9HHihOfLlH3uLmR9LPkm3kKvQKOlmOlceCeisaPoNAoej7XnRO1Rorj9Xs7/ukMInHFoRUeG
        bH4H4tD9g8DVhjEgorkJ4FkJ2dJiG+49o8D+V1F/cZ7FT7UZV/ErvpuGriSRxsyvn5s4tU4b2fWn3
        LTjCxlxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZxpM-007ahZ-JC; Wed, 08 Mar 2023 17:43:48 +0000
Date:   Wed, 8 Mar 2023 17:43:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Danilo Krummrich <dakr@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: export symbol mas_preallocate()
Message-ID: <ZAjJVNOkv/xL6GBC@casper.infradead.org>
References: <20230302011035.4928-1-dakr@redhat.com>
 <20230302015242.xi3y53okc4skmonn@revolver>
 <9abef101-3a9b-0bdd-7139-ced7d5e28ebe@suse.cz>
 <da65d59e-f918-d7d5-644b-33cc51c2ba6c@redhat.com>
 <20230308144343.GA16259@lst.de>
 <59b703ac-9660-a0e5-09f7-c5b69d4f39cb@redhat.com>
 <20230308152913.GA19628@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308152913.GA19628@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 04:29:13PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 08, 2023 at 04:18:55PM +0100, Danilo Krummrich wrote:
> > Consistency wise I think we should either also export mas_preallocate() or 
> > don't export the other ones either.
> 
> Please send a patch to drop all unused exports.

While that's usually a good rule, it just creates unnecessary friction
in this kind of case -- a set of library functions which have only been
introduced in the last few months.  If they're still unused in a year,
sure, let's get rid of the exports.
