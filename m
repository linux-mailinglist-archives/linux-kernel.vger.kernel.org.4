Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378D06F1158
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 07:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjD1FhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 01:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345141AbjD1Fg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:36:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEEB359D;
        Thu, 27 Apr 2023 22:36:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A426268D0A; Fri, 28 Apr 2023 07:36:54 +0200 (CEST)
Date:   Fri, 28 Apr 2023 07:36:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [GIT PULL] MM updates for 6.4-rc1
Message-ID: <20230428053654.GA8549@lst.de>
References: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org> <CAHk-=wjaYXeWKsyifQCS=gJf4mxav-b6cdf5boKpMO6M1C-2LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjaYXeWKsyifQCS=gJf4mxav-b6cdf5boKpMO6M1C-2LQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 08:15:56PM -0700, Linus Torvalds wrote:
> Most of the bulk of the conflicts were around __filemap_get_folio()
> now returning an ERR_PTR, particularly then with Willy doing the ext4
> folio conversion.
> 
> So Christoph, Willy, mind just double-checking me?

The merge looks fine to me.
