Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042B672ED5F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjFMUyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjFMUx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:53:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7D210F4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Ssh0udG+9m+h1UfsnNWgjMJf/GSOsW2JFBwF/Vbf7M=; b=Dpygt5k/SkbjtdIpPJ3uaJ320A
        tDkpsNJLl3JAlh43HNRQE6lJfF6ecwBKoEevEI1h7ZWge52KOGyq7ZZCGsmZ2U8/PiZOEH62npk1O
        IE5PH0nxYg+ElpQeDDyocv/8C+/x8Fpq9e/WymJveTwuqlGLTtrZyAjRpP5pCasj7NM57LqMMhDBp
        8z4rtNO1fPeqdVwb3PLd0Jx3n9zgixgyHP/QhKnwMF+8sSexuLc2tD/HWxkqlNw6XhxFdt3UHIE8i
        wtSBYL1ZfiTM4k6NvmPLH1GD+KOHNuc7q0uTqHYaAvhZDfjt0KGSgFbBSy8Cjv2IaM1EEzFElg5wA
        G7DFm8RA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9B1W-004K5R-Nd; Tue, 13 Jun 2023 20:53:54 +0000
Date:   Tue, 13 Jun 2023 21:53:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] mmzone: Introduce folio_migratetype()
Message-ID: <ZIjXYqi5wbVaf6qo@casper.infradead.org>
References: <20230613201827.9441-1-vishal.moola@gmail.com>
 <20230613201827.9441-3-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613201827.9441-3-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 01:18:24PM -0700, Vishal Moola (Oracle) wrote:
> Introduce folio_migratetype() as a folio equivalent for
> get_pageblock_migratetype(). This function intends to return the
> migratetype the folio is located in, hence the name choice.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
