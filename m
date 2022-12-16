Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD1B64E778
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLPHEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLPHEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:04:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BF736C42;
        Thu, 15 Dec 2022 23:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bdn3uI2+vY5pQpRy4ybJdHr0gzTwg0wCHFdFjlS66os=; b=bLfJhBuvLnKfTacOfntkdpS2po
        uAg/4/QhYMKzf4mZgSJhDGyiG4KkB7RTxyWxK+FqZuwCXC8tpmImbDTEiVw8UVc+KvhOJZwd+TbOc
        7kpyqxiSfd89La05577BSU/N1Pm2w8f8wLgenw8HtpqxFH6ll6ph504SagudlnHyZx6qJMo1qy6jn
        AfwOY34DFkgeTgN3TI/aAh9YaQOP8l5RlBs5skn91XVAHisw2DYcVEtJH7x1Y9BkNfvRDnZIPnSpG
        kZI+PpexyIt88X90R0K4QYbleTEnC5uzu9vnCte4RRH8VN4oR6+1PeqqWzbpC1HI80DUDcbOla61k
        qNV6+6Ag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p64ln-00DJ0d-Mf; Fri, 16 Dec 2022 07:04:35 +0000
Date:   Thu, 15 Dec 2022 23:04:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/21] block, blkfilter: Block Device Filtering
 Mechanism
Message-ID: <Y5wYgwtFYPj2xq/m@infradead.org>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-3-sergei.shtepa@veeam.com>
 <Y5roR3jjhQwgFWVM@infradead.org>
 <28b715eb-f9bc-c0d3-8dfd-22d0f84080c0@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28b715eb-f9bc-c0d3-8dfd-22d0f84080c0@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 11:46:35AM +0100, Sergei Shtepa wrote:
> I am very glad to see your comments, Christoph.
> Thank you so much for the review.
> 
> I have read all the comments and agree with them.
> Now I see new ways to make the code of the filter and the blksnap module better.

Sorry for being so late, but I was stuck onder a pile of work last
time you posted it.  But compared to the versions before I think we've
made a lot of progress and we'll get there.  Also feel free to ask me
for input on changes before the sending the whole series if you have any
questions.
