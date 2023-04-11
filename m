Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EE96DD084
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjDKDzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDKDzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:55:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9CA1BC9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=R/oR2Zl7MvqPSjS/0v1XrvoRB9
        0iaya/hAIvfQ76VAGxrpeub9l3p/1fEGoXLnhKKvLxlrmHjOEoi0EcYwUQgxd42xk2oHpwPXMV9KM
        wnOm1YxlI7e9cW45nUz/j1T+E5yOM5bp1SmDeV7wDqWhot6cp/ZI5ekLsRhbCi0UZnuhCWVUdtzjQ
        r8OyerFKRotGVSXRnTqbe6vG7q4DuKc+GY7BBlswWuEoC+osWutQYkfxxnLiYZWT1JZNmqoRlrZfK
        kZhoQHxF+7gQx2JYaUgpCyTvVVFx+i74RjuQYeHiro4zDGhYuop/e2hjn7us2313RlT5FRqDJSTxP
        ge+sGvOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pm55u-00GMHc-2s;
        Tue, 11 Apr 2023 03:54:58 +0000
Date:   Mon, 10 Apr 2023 20:54:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Rix <trix@redhat.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: backing-dev: set variables dev_attr_min,max_bytes
 storage-class-specifier to static
Message-ID: <ZDTaEvCP7JYb0+g5@infradead.org>
References: <20230408141609.2703647-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408141609.2703647-1-trix@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
