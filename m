Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6D8712FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 00:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243854AbjEZWK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 18:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjEZWKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 18:10:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC395A4;
        Fri, 26 May 2023 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RMsi9LnFsMV3xoE3l7YWlz3cxx4u4D7P+QnIRXpeDDU=; b=4JfWg2jIBC5gt5ldmuKAzOdGZi
        t2TRVfBqfX+Mn9LriJKq6f5vmzUakpCggz7n1un6QbfM8KHIOJd829GjI000PbCchG/IFHRtHQ2k2
        LwIyAnDS9Ryra/GXvt8ytsolocShueLaRdFWSc/qDpaJw4EYok6UcMH+LwWvvAmpasDpznrYcpTaM
        D/MOJo90DKqZOldYmb0Gf3verLAdVqvS5NmUxquha/qmseh0/ESbNB1QM3AUw1r4KeEf468TvQ9qz
        xjord9Qh7CwdDDE7F7l5yXfImT0suUaK7rGVQLNwQI/lzdzXR/Y2aiTy+BDwzRsbdsIX6F6iaTf58
        Pcqub/1Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2fdx-0045Tt-2X;
        Fri, 26 May 2023 22:10:41 +0000
Date:   Fri, 26 May 2023 15:10:41 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     cai@lca.pw, thunder.leizhen@huawei.com,
        vincenzopalazzodev@gmail.com, wedsonaf@google.com,
        pmladek@suse.com, ojeda@kernel.org, peterz@infradead.org,
        keescook@chromium.org, alan.maguire@oracle.com,
        stephen.s.brennan@oracle.com, samitolvanen@google.com,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        v.narang@samsung.com
Subject: Re: [PATCH 1/1] kallsyms: remove unsed API lookup_symbol_attrs
Message-ID: <ZHEuYV7dyec0pmY2@bombadil.infradead.org>
References: <CGME20230526072134epcas5p12d0971c15890541639b4d2d85db84b43@epcas5p1.samsung.com>
 <20230526072123.807160-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526072123.807160-1-maninder1.s@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 12:51:23PM +0530, Maninder Singh wrote:
> with commit '7878c231dae0 ("slab: remove /proc/slab_allocators")'
> lookup_symbol_attrs usage is removed.
> 
> Thus removing redundant API.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Applied and pushed to modules-next, thanks!

  Luis
