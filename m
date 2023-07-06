Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D9974A36A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGFRss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGFRsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:48:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562C51703
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zvCK+ggfyFtwG4SgbAiL62pHThXL+GZjqrpqrWAXIp0=; b=QsGeDFP49VwqsU4lHSykqmBSCy
        gLT/CMdNVfno73sR/q9wuL1cXPfrbrw0XTX4550mKY20Ny+JBdcif7WJrXtmWXk7aPEjl38Ug9oj2
        YKATX08TQC7ofx6MUy4LRQDG5VeCWiCpVki95CegVWA1Zu5XSVUWbQP2ikt04XH6RZZE6ILs5AblE
        VPexFt2jhREPWxb18FZAMzK5Vq/mlTeBDdj/vN/po56iH/FAl8TTI1wyJ7n4nobByqdLfyONdAB08
        M4NBWz1x0+/pYKHkkJOtyOqlVOKnXwQeMXraPV8uZjgZ4N9Ms9PaDjMHw+WGmkXsy7k1CQnunpFbd
        NRTvij7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHT5q-00BGuq-VT; Thu, 06 Jul 2023 17:48:39 +0000
Date:   Thu, 6 Jul 2023 18:48:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, zhangpeng362@huawei.com
Subject: Re: [PATCH v3 2/4] mm/memory: convert wp_page_shared() to use folios
Message-ID: <ZKb+dimvau+g6TEC@casper.infradead.org>
References: <20230706163847.403202-1-sidhartha.kumar@oracle.com>
 <20230706163847.403202-2-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706163847.403202-2-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 09:38:45AM -0700, Sidhartha Kumar wrote:
> Saves six implicit calls to compound_head().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
