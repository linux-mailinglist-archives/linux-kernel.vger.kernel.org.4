Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E774748E5C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjGETwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjGETww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:52:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96F71BFB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8r8IbHXxyrtSBUgD+AK6vzNCLGv5fWqNBe5mA3Kw1Fs=; b=NcEOkF3B3rcQ/is0ZQrgWiOLXx
        Dk5rYXB2TgP3+2RGHIWDvWPzxmZNUUgbPoZY0I/9UpLwwdocgmtSTWnoMhlXQNmalgRg4Lcghnndf
        4c0QnVNIaihTPbK70+8JAWIVVRzUa2PhPoTNYb4Wf3NmtQU9MKIL9tQVJ4go24IQT1QGNFuOksa8U
        BeNZ2aGxaOUGdm0XLwvn2faf4OjXPkpRTmk7HjbSdt0HBsWp39NGoXE7SYBFkIyIXbmGfeUX6tPvh
        lHxXZP3yLUdWdxwPLnwk68agVeYM3gfjfDZgX5f8yFo3WZlD9tbjGMSeF/5pEgPWT8qg49Z8fdKn9
        hgWzMIzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qH8Xy-00ANRT-Db; Wed, 05 Jul 2023 19:52:18 +0000
Date:   Wed, 5 Jul 2023 20:52:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 1/4] mm/memory: convert do_page_mkwrite() to use folios
Message-ID: <ZKXJ8hOKm6/VY0Z1@casper.infradead.org>
References: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 12:43:32PM -0700, Sidhartha Kumar wrote:
> Saves one implicit call to compound_head();
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
