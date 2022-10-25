Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2BA60D609
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 23:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiJYVP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 17:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiJYVPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 17:15:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B4F6C3F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bE+TEZM2u/ntPYHLTGayKrtfO8ubPaiQ0PQdgjZzeYc=; b=SHjewD6pGp/NWy2pEf/NhG2f6J
        IhEJKjxDqjmndXtLdw/O0ZZzAMMozscACwN5QT+4b40HrOF3w0aNz9xAK1ZhxOI6Q5AM93h+JVh6I
        gBIHXSnPdgskXYQyxm4qMJwECO5r7988MO34+uLb/4z9JGIMumIETK9Yt0uQPK+5/mSIb5roMUtUu
        XsLEo6IUKAHI3jGqAnEjZCcwBtsgzNTBFye4V+GQfkFAu4xA5s2tXUlI6sAIf4rmr9oHzlh+TVpsK
        XnJupIHR07RPA3fLz9j9yhO1pcntheIG8YetYxTDj98s26hrUVXKlcIh4hXuhgT0GyE7NtKmesyHg
        LTjNC48g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onRGw-00GXwv-0n; Tue, 25 Oct 2022 21:15:42 +0000
Date:   Tue, 25 Oct 2022 22:15:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Update copyright dates for test code
Message-ID: <Y1hR/RNpXB8O1sqZ@casper.infradead.org>
References: <20221025173709.2718725-1-Liam.Howlett@oracle.com>
 <8d8a291b5237750827d6847b29efde5b750a28f7.camel@perches.com>
 <20221025202305.pyzau7vzvkizqbir@revolver>
 <870346348d7c70f3d2e72a3f1abbb216f19cfb89.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <870346348d7c70f3d2e72a3f1abbb216f19cfb89.camel@perches.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 01:40:19PM -0700, Joe Perches wrote:
> Copyright reassignment not specified in commit message.

It's not copyright reassignment.  Liam has been an employee of Oracle
for the entire duration.  It is fixing the copyright notice to be correct.
