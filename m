Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B0F72ED6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbjFMUyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbjFMUyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:54:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2AE1701
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SNTYUvQq/3batOkapGSECA6ix3wsUL7r3MNZpjEUVdY=; b=cawQPlJPfT5seEBGbzb0u/DPI3
        QCqqlR5asC0GnDMSLGBRmO/CxH/ATIarj8KbxrTEgAArhv+j5US4UDqgFdSRdcn3iO+eJRpWgdaBK
        uhK08EBkF/mpSJ//mihnuP5vOcgQmBd/jx3+wPYEPWfOERcF8H0t4Rgxr0bOAQAm+qyp3wwgRGvvh
        iwHlZCsNoDTV1+i42JrDEWzvOipRqyO3YW/Zgy2teO6VhXpBE4h0bU6lO8osLjo9CTNb0B9PaW/XW
        bG6hF3SCc/sekWoLeWaI6vbhfGuDNWMutoBfmzjp7m7FRYvxES8OsNXpxUfivc3zLko9x55QpKFCr
        MeaghKBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9B2G-004K9i-Gl; Tue, 13 Jun 2023 20:54:40 +0000
Date:   Tue, 13 Jun 2023 21:54:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm/gup_test.c: Convert verify_dma_pinned() to us
 folios
Message-ID: <ZIjXkB6Xj+lTfF7c@casper.infradead.org>
References: <20230613201827.9441-1-vishal.moola@gmail.com>
 <20230613201827.9441-4-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613201827.9441-4-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 01:18:25PM -0700, Vishal Moola (Oracle) wrote:
> verify_dma_pinned() checks that pages are dma-pinned. We can convert
> this to use folios.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
