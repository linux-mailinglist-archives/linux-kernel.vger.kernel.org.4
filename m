Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C870682803
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjAaJEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjAaJEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:04:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99FA4FAD9;
        Tue, 31 Jan 2023 01:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UxxxgBztglBw+ZTAJ2+FtGofpM4h+lQfmGysVKJoL+U=; b=wj3qzkb8ZBbfNEQQWtmUlVwkeB
        HwvHAMVcxiOdB3yZ4DrT2ZUYjw2u40I8nuc3Y4spEsGBlWJZO3mdCBTb7gXHsVbXIL67ggV8gjJqP
        BwCnAjHkBzj/i5YBn0aSRjvoyq7r94fa9oRvXZkDzWeTQoq9UhyaX+I2oY22cTVaiwcv3SwdICMsW
        B16iFTZikNdaVb4/TIQA0AQSzxGEJWb/YYpEpdqkSF6ygM+VcyyA9ZzQlHa1JO5K2RDcvNIYBUp8a
        uNfJ60I7LLClYY7Lur3gllCioLWWbgYYBTeUCgGx7Ks96c3txXPgdDjjhIJusFLqNA7Ai60NnZwno
        1elGVb8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMmVO-006srN-Nk; Tue, 31 Jan 2023 09:00:42 +0000
Date:   Tue, 31 Jan 2023 01:00:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Remove mm.h from bvec.h
Message-ID: <Y9jYujFzx2HxOkC7@infradead.org>
References: <20230131050132.2627124-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131050132.2627124-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 05:01:32AM +0000, Matthew Wilcox (Oracle) wrote:
> This was originally added for the definition of nth_page(), but we no
> longer use nth_page() in this header, so we can drop the heavyweight
> mm.h now.

I'm for this, but I'd really prefer to have this survive the build bot
for a few days and random builds as there could be users that are
missing the explicit include by now.  And someone the buildbot seems
down or overloaded lately :(
