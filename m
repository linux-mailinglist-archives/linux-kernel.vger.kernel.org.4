Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0ED6F7BC2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEEEKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjEEEKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:10:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C1C8A7D;
        Thu,  4 May 2023 21:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F8SyAx82elMQX9OByRGapXDLinwDYRK6kS/ZTry4wr8=; b=Ta9uMF/yR+y+mnLc/ox7u+hEt2
        5yyTafQgjAzh8Tux3N78t/Anxy5qydrVGF9sN/bQ5NH89n0UX7EX4ESeDYLzu7m4IfHDh0NiX0hGH
        la4h4RoadM1QFaLht0La36rUs2hFpAMNQGTmg3S+kA811pKbJCFKLMrWyOrWDrObpD+Ibwdy4nhIB
        IYLFJmfq8opJygHOlz96f97svjei7nxazfSIy7bQeHpr8ey1fVvorML4a2rBoO2TY1RoWZnEXCnhj
        3tXZUwcRgTKNc3pPlOHqJ6JZAMMQoaihm8qyZs2sUrcZ4I/y/K78G0PZ2R+lJSOXsv4Oz0BByWNR4
        56aGWv6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pumlU-00BDYI-Nn; Fri, 05 May 2023 04:09:52 +0000
Date:   Fri, 5 May 2023 05:09:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 02/11] rust: add `pages` module for handling page
 allocation
Message-ID: <ZFSBkFuvJOiz600W@casper.infradead.org>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-3-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503090708.2524310-3-nmi@metaspace.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 11:06:59AM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> This patch adds support for working with pages of order 0. Support for pages
> with higher order is deferred. Page allocation flags are fixed in this patch.
> Future work might allow the user to specify allocation flags.
> 
> This patch is a heavily modified version of code available in the rust tree [1],
> primarily adding support for multiple page mapping strategies.

This also seems misaligned with the direction of Linux development.
Folios are the future, pages are legacy.  Please, ask about what's
going on before wasting time on the past.
