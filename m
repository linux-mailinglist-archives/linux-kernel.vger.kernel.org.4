Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316DD61F4A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiKGNtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiKGNtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:49:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989B31CFD5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NU1vGtevCfkjD19Qpc/cZx4YgjSiy01VlZ3NjxC1aHI=; b=Xcd8crgFuGdweudd8YCGqf4+yP
        Mw+tXrROaI8AYntoajg+8xHYEeqH2WxCkDG5mVkpnvzY3A9W6Gh9go72bpecalehEVQPxQlPvITJK
        eYZYJa6zfsKh1x8rbwW+JpulWK3wnUBH/X+JzBXg0ngdrosr0Q0NQtAlkTXln0ErKY/xWb7rCXEKR
        VjKtU7pAG0zfD1X3StfQ/Uh9fCavh/Ck7BwCeKvZDVxlAhcmqf/UoDF+UZg+4udd4cqQnB+XSgaLq
        SK8apeWySAN6w3gvWKrsJvWvAA8xhucVuq1WTpI5ymAdKSK+qYuEVULGffsHLdmycoOuAKIMgap/5
        9T9++DTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1os2VD-009OrF-Nc; Mon, 07 Nov 2022 13:49:27 +0000
Date:   Mon, 7 Nov 2022 13:49:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 1/2] migrate: convert unmap_and_move() to use folios
Message-ID: <Y2kM5+iCpxKL4Bk+@casper.infradead.org>
References: <20221104083020.155835-1-ying.huang@intel.com>
 <20221104083020.155835-2-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104083020.155835-2-ying.huang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 04:30:19PM +0800, Huang Ying wrote:
> Quite straightforward, the page functions are converted to
> corresponding folio functions.  Same for comments.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
