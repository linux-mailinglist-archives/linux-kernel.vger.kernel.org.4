Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1BF667301
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjALNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjALNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:16:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772A16306
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zKBXSuS/0mrd++K5B4B9sqLRDVg+207ZHUFlsubT1ho=; b=ivO/HzfpPy5e0bP1agVhYaz32I
        Xo8kYhvJU22VOXdt0sJvH4stUcY76P4aRmzZ46O0H/PlO4ciORut/jJjGjBMFnrquJR6vwPBX37ZT
        tSdUWP82qbCzNkqXYwoI/hVRnK3oRctfyMbiJqC4rqn3nYS7QCqk3Bcp3lIkc3/Zoqr+S70sSspg2
        /+UIhaaoSs/4JK8UvqVyG0beHy1BCOvO1U2pP8P8l/X39zGH0xQLYZjufqOu199KI3G4y2y2TMtmR
        mAxSPX330i+jjT3QUrnxe9sMHMYOb0ipW68ctxxhkk3VHpQrrsJGBspXEedO+c3jMuh5Z3PeVkM53
        +dmUVRJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFxRv-0054ud-3H; Thu, 12 Jan 2023 13:16:55 +0000
Date:   Thu, 12 Jan 2023 13:16:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [PATCH -next] mm: madvise: use vm_normal_folio() in
 madvise_free_pte_range()
Message-ID: <Y8AIR6yc3SGA7ZAo@casper.infradead.org>
References: <20230112124028.16964-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112124028.16964-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 08:40:28PM +0800, Kefeng Wang wrote:
> There is already a vm_normal_folio(), use it to make
> madvise_free_pte_range() only use a folio.

In my defence, there wasn't a vm_normal_folio() at the time I modified
this function to use folios ;-)

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
