Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434E463F91B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiLAU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLAU0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:26:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A93BFCEF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LKGrEeIq6wXlpKjGZw/1KiVMGn2zrCU8BdExFG+pM7o=; b=ixFSF6hVMMo0C7tCMl26+N0aBo
        LKhP0lEYoxwAsGhVJlIFgHF9+DFwKOB1QzMw2ZWyGwOJHqhRW2ylU/VdnXGRM75K/RnvOR6TrBZEC
        JmrjzTqGDY5rEYTTsgqAqwKbqz9GKyEElx0Hd0ORzw1IuVWUm4aCSntT6NBpGJOs8y9XQXpGu/tIj
        7ddNX8B4Ui3WbWSG4O1MYlDRgIf6AEO2dFIFVNczGQQCdIf2/nd842rd1iPQC6ss5aqoreRTWPEaJ
        RHKLj+eplDFumE6o31V3jWTJGvuut3cZP39XqJh1tIDqlk077ulMqqKzgAF5WOEOQWs8tlaDIAqa1
        3IIAWuzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0q8b-00GuDr-E5; Thu, 01 Dec 2022 20:26:29 +0000
Date:   Thu, 1 Dec 2022 20:26:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     ye.xingchen@zte.com.cn
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: add TRANSPARENT_HUGEPAGE_NEVER for THP
Message-ID: <Y4kN9UAte0OQ6sGi@casper.infradead.org>
References: <202211301651462590168@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211301651462590168@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 04:51:46PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Sometimes we may need the /sys/kernel/mm/transparent_hugepage/enabled to
> default as [never] at the first time.

What is going wrong with THP enabled that you need to disable it?
