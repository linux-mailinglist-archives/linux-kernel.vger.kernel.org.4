Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA2F5F9A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiJJHlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiJJHkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:40:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052095FAFD;
        Mon, 10 Oct 2022 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IubIfg5PM0k+nLBu0W9G4H26hA5QLhWrO28e455qTr4=; b=XVK4eqvavav2G7Np2xMONjhKpk
        vfQ0l0kBlVGZrJzAbl8+PYHrSGiTJhX9CWDgSujbfAhyFrQOILN7CRUI7E4t1RPXdsWxlAIkj0Y47
        65+pdp3HehwpfuBeXUnPUTXkVMTxhCs/tF1IFhvn+XMmbst0VNp0UW8sBvxFoj/tKmkL6P1PFm8rt
        xoq9TY9Fp+5QFHDgLqmT0NRwBw1pr/P1gXeaWecWu1+UPNGJMRx/Q+z5gxvvwPsRGCiY7B0nN8utb
        bGvzP52MbyO3DcZE3x3Cla08o/XwaT7vgvnEYRXp96NlWaIeaYkPl8+R6tBQgz1d7lxyTAsQ2WXcG
        9b++DfdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohn5H-00HNDD-6p; Mon, 10 Oct 2022 07:20:19 +0000
Date:   Mon, 10 Oct 2022 00:20:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: allow specifying default iosched in config
Message-ID: <Y0PHsxmsWHFYiLPK@infradead.org>
References: <20220926220134.2633692-1-khazhy@google.com>
 <fff022da-72f2-0fdb-e792-8d75069441cc@opensource.wdc.com>
 <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com>
 <7e3a521e-acf7-c3a8-a29b-c51874862344@opensource.wdc.com>
 <CACGdZYKvTLd0g2yBuFX+++XeSa6aapuAwOM7e63zhKgdKFEGEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGdZYKvTLd0g2yBuFX+++XeSa6aapuAwOM7e63zhKgdKFEGEw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 04:15:20PM -0700, Khazhy Kumykov wrote:
> The kernel already picks and hardcodes a default scheduler, my
> thinking is: why not let folks choose? This was allowed in the old
> block layer since 2005.

You can choose it using CONFIG_CMDLINE.  We can't add a config option
for every bloody default as that simply does not scale.
