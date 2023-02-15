Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F19C6977AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjBOH42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjBOH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:56:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E792A144;
        Tue, 14 Feb 2023 23:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GDPaKLD2RtwtaKC/1ACIxv9LS9IsDyUE/QNlCjQUiTI=; b=a9coD/go/11dKfYzFPdPly2z2C
        9wfJw7niarZV8o6wpALSKdDLsj4oQwqe9GabRMwJtAkMFzmT1hyQ05+oi4sijYmTw9N/OJ2wmb05o
        ieDa2ALxZ2a9dApJF+g0fi+tPll4qbSXbP8Fv8avRVQZBQ7neJQX4+tdeS0MxdSUFpz/tanx91UJf
        64EojX+EwsxFafY8/v+IMBpz3Cl6yIn6XKNYD8qjndAy6vxteWKD5ncIkUdGIWYxo4Ohw8FDkQckA
        kxRgahtS5ZPIRrHge3myoInPiX26xaMsszPbtywx4UzeBO6Q80xO3lbg2woI8QMcrExQmZBHMc1YH
        6aJnjDKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSCeN-0056av-8p; Wed, 15 Feb 2023 07:56:23 +0000
Date:   Tue, 14 Feb 2023 23:56:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/1] lib/bitmap: Export __bitmap_or_equal
Message-ID: <Y+yQJ5dRRQd3z4bx@infradead.org>
References: <20230215021407.13369-1-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215021407.13369-1-quic_gurus@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 06:14:07PM -0800, Guru Das Srinagesh wrote:
> Commit b9fa6442f704 ("cpumask: Implement cpumask_or_equal()") missed out on
> exporting __bitmap_or_equal() while introducing it. Fix this.

What code fails to build without it?

Right now it only appears to be used by the x86 APIC code through
cpumask_or_equal, which must be built in.
