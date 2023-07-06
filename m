Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4CD749E9A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjGFOHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjGFOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:07:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E931FEF;
        Thu,  6 Jul 2023 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ffikayycz3LGYHi7iyJdcEJ4MZmz23w6Tsm5M6StKu8=; b=L0hduGVH/MJ/I7f9EVBOQddoQ4
        +yqkbsdjSOfYhMthwsIds1wgzvWzCz0fnmJ9Q2Qh/ULXgiz4R4Y4cinitKsjSTSL9G/beU1U7GdPk
        aWx8glAh6Or9B1vePAIVF8xBKJ1pGY62p1z/ZK+i0QoLWOJkOpNpRM69dGJvdUohjs2uNHBCvkmnL
        vFo/marILc8QiU/gvHq3FHJRNCh7hW+woMOM8NefIA5QCDksS1cmldjCipjCxwkzXVFRAKSj8PenN
        2p4WGT2QTljZMr6ozOhVQzNAvjx+FvtL7/PWAM5UCutBlEk6fOH43Nhkp/7gz4drXfygVxVtERZfo
        8FHHwWrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHPd2-001q4M-0F;
        Thu, 06 Jul 2023 14:06:40 +0000
Date:   Thu, 6 Jul 2023 07:06:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Julian Pidancet <julian.pidancet@oracle.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/slub: disable slab merging in the default
 configuration
Message-ID: <ZKbKcMehHbo+7cPU@infradead.org>
References: <20230627132131.214475-1-julian.pidancet@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627132131.214475-1-julian.pidancet@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The slab merging has always been bothering me as it makes debugging
things really hard.  I agree with the other comments on improving
the commit log, but with that:

Acked-by: Christoph Hellwig <hch@lst.de>
