Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1E76E50F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDQTby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQTbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:31:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A935F5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S2Ya0QvtngUWlqhtoEuXxfCTWvNNw9kIk63C6oNr7NE=; b=D7vcx3i1GUvOHhfdrAT8CnQBd+
        O6sTujXMnYPZBb73gUbL5Hg1WG/GCVDx7l9JX3PyCD1u0ZlP2VJ75qJpCLT/hGL+Tt8HeIs1P2LoM
        sjuFRLMhzEjSQgQAHd18lY0031SE1nua5zt9TLYKYlurXQ/z4BgB3MemEhkxUVnUnqAOYEE0DB1S0
        K9KePd+Sa8xem6OEZSrwAOZWZy91EpaP2PcTOlBeDYvRaq50ENlZt3C56P/6jEmngV6EaAYfDCQRW
        5qb3qZkzYK2lb99oCE2Mh63dLw7rOqJQurh0Fg6rNe+8s9ozcKS1/C9w3aIIID/gfXBREMfaHXqfh
        22T9O8DA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poUZi-00BcMh-Q7; Mon, 17 Apr 2023 19:31:42 +0000
Date:   Mon, 17 Apr 2023 20:31:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/slab: break up RCU readers on
 SLAB_TYPESAFE_BY_RCU example code
Message-ID: <ZD2eno0AmkyHe8+P@casper.infradead.org>
References: <ZD2HlGwNkrrj+Odz@casper.infradead.org>
 <20230417190129.1454-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417190129.1454-1-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 07:01:29PM +0000, SeongJae Park wrote:
> Thank you for this suggestion, Matthew!  Will send a new version.

Please wait 24 hours between sending new versions.  Give discussion
some time to happen.
