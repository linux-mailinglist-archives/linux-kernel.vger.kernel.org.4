Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD1A74294C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjF2PRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjF2PR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:17:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1CB1BC5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Br5lmtkM4xEPXhnEaSyMakyTIFN7fYK9NHh54UdMeT0=; b=Nmd6u7CTxl4EWCi8FGYXJ74Qpu
        bAcilZ1J7uer3chhnj9MN/wr3YlSmQwFKddAHjADFftWFDNj8j6wVmV9lmXVGQ7hbllm/xnZBWkTq
        D4nBq3DBaEIm3a4D31XhJNZJUtW8UZBSiQbR5kICGO0FzEElP70STZR/WqzWrBv2ahNjKTeLhA0qT
        TqiOifl12mHfnHDZC/ZVhU+ZeU778mdD+KSAUDczreAq54NcsJd/KO8z2utjgtS3O9Hk7COLoXsNq
        a3PX8GJ5wdi5mtjI20jqjKQ2ZHbYmh8T5Fa5v7tZ7A1guEVNONDXPygWDhvJwB50dt0TPckJKdwi+
        XXJFRrBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEtOZ-004xdy-03; Thu, 29 Jun 2023 15:17:19 +0000
Date:   Thu, 29 Jun 2023 16:17:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] mm: remove arguments of show_mem()
Message-ID: <ZJ2gfixfUBXCV/+P@casper.infradead.org>
References: <20230629104357.35455-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629104357.35455-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 06:43:56PM +0800, Kefeng Wang wrote:
> Directly call __show_mem(0, NULL, MAX_NR_ZONES - 1) in show_mem()
> to remove the arguments of show_mem().

Do you mean, "All callers of show_mem() pass 0 and NULL, so we can
remove the two arguments"?
