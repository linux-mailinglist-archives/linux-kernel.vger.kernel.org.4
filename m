Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9946C5B3E03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiIIRfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiIIRe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:34:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FFC6DF9D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I0v54nIro6xZOofj83qxb1rrafZloA4ndyS6HrxaMJo=; b=oyA2Ohn4752Av6E0PXE5atTkSG
        rBmt2NpT++cm9zlx1pCjKtaZJtttn2j1vhfeMhV/Lr5B5VQcOoy2nB11fH6GzaAEDFdx/oHK1kCWP
        cCgdPIhZQ//mZvgnDRPMctfndm4motNSZbHkda3GXtYHDjbA/QW3/iAROuR3AahPdor5bYwePlpq+
        0zJ4BhNROw8h4iMiwJnGRhPFmY2f24tGhgo3lOop27MloVhorvl9k9MLiXuHs+SIwxIbQXyypioOh
        /NGrkmCsqWpCe7kO8WgXazvNKK7BXPLrPfqBxCuJkgzB/vyUqPQ+SzqJBUKXrmZvOZh0Yv/d2uz9H
        VfaAL/aw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWhtx-00DR6H-Nm; Fri, 09 Sep 2022 17:34:49 +0000
Date:   Fri, 9 Sep 2022 18:34:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] tools: Split <linux/gfp_types.h> out of <linux/gfp.h>
Message-ID: <Yxt5OdpHdm4JchRu@casper.infradead.org>
References: <20220909160801.11070-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909160801.11070-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:08:01PM +0000, Wei Yang wrote:
> Commit 9f162193d6e4 ("radix-tree: replace gfp.h inclusion with
> gfp_types.h") change the include file, which is introduced in
> commit cb5a065b4ea9c ("headers/deps: mm: Split <linux/gfp_types.h> out
> of <linux/gfp.h>"). Since we don't do the split for test, current build
> for radix-tree would fail.

https://lore.kernel.org/lkml/20220902191923.1735933-1-willy@infradead.org/
