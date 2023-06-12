Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A9172B709
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjFLExy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 00:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjFLExf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:53:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D88710D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 21:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=4eY/ywIugfofczrBm0qERLAgihZ9+hCwbUIkEYA8S/A=; b=ohSp1EKD8zf7Cs+mrzxbnxUdMF
        T6+XxQ9cb4DAIwGEsZpJh4y3tmFn72ZZR20Ku/MNFw07eRi5a7SJCZrTvijKWfgcWM9sXD+s43WaE
        C6iSp3up9C4wpoazrb7WneNbjRhH1//nJ5zSVKMhEmdJvPkNW8HuOnm7GsPyLyXQcZjZn8N/+6V0I
        4i8kbUsf+68dWk8xzE94U8kEv57W98SKbrboPRgr/xeH6l0lHWExyFswSI+13dbfR4EB7dNwaNfqD
        pWMlx45SZfImdfbUetSkG4wMWVyfuY+y+RImq1w/XtoW4OpdOi5MusoUBLYgfTkdbsmcFqdWvatYi
        hvYkB08A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8ZYY-002aFl-37;
        Mon, 12 Jun 2023 04:53:30 +0000
Date:   Sun, 11 Jun 2023 21:53:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH v3] mm/migrate_device: Try to handle swapcache pages
Message-ID: <ZIakyrbyENaIjS9q@infradead.org>
References: <20230606050149.25699-1-mpenttil@redhat.com>
 <ZICPx7RU0Qzh5zQY@infradead.org>
 <20adfaff-054f-ab5e-0ff4-4ce3952fbd58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20adfaff-054f-ab5e-0ff4-4ce3952fbd58@redhat.com>
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

On Wed, Jun 07, 2023 at 07:06:06PM +0300, Mika Penttilä wrote:
> 
> 
> On 7.6.2023 17.10, Christoph Hellwig wrote:
> > On Tue, Jun 06, 2023 at 08:01:49AM +0300, mpenttil@redhat.com wrote:
> > > From: Mika Penttilä <mpenttil@redhat.com>
> > > 
> > > Migrating file pages and swapcache pages into device memory is not supported.
> > > The decision is done based on page_mapping(). For now, swapcache pages are not migrated.
> > 
> > Please fix the commit log formatting, it should not exceed 7 lines.
> 
> Not sure what you mean should not exceed 7 lines..?

Sorry, this should be 73.

