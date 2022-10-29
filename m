Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6086123EB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJ2Oi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJ2Oi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:38:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B686CF41
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qO2WvT0yGAcy8FvTR3ivK9mAfY24udAkpeItbH+WHc8=; b=qmw+y3kH2Es2h47omujO6joiKi
        d4qqdTFm/PKEbbGCsLJaU7PrJpxpBJoLI0WLO7TR3EX1HJcPqbNh6S0S4Z7qhXWrY8Fs491xcvd+D
        7l65Z5YzdXYaWv4o0LnHNxbCv91e4KX7GiLppNL9wPZ+nPLVm3WDFSSHlN7GBEjR3WTOaIm9PJXPd
        llXUZvBhLsHxcvmmbXndDv0tkYTgRm4j2O7ULibm3aO0n/SqxrA6G0h8QtuyqAoFcACTu6qVaaF3Z
        P218Ycm5V+ntTz4S9bcugrye4r/59pD6k36Kq7e3Utj/1W7HE5ZGQWzyT1O6WUwYsrZ9ZkYdIsVG2
        cJBQJIEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oomyz-0028rO-Sp; Sat, 29 Oct 2022 14:38:45 +0000
Date:   Sat, 29 Oct 2022 15:38:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: delete rebundant word in comments
Message-ID: <Y1069b16xdOWSEi1@casper.infradead.org>
References: <20221029100431.10825-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029100431.10825-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 06:04:31AM -0400, Shaomin Deng wrote:
> Delete the repeated word "that" in comments.

I think you've misunderstood the comment.  NAK.
