Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E43664B92
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjAJSul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbjAJSuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:50:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6829485A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pm/cTwtUffgVrCqgBgzGRApBPSb2FAw/g+vaVmt6ZAg=; b=ph9vbyDy4TLBn+6dKNHmIpNrH7
        JliDx1bFrx9M60fugUTdLtJA3AJ27G2QqjHQWrDaZk/YHk94Cj684Gyw9KMmaCKook8POatw+dSmk
        o3whUr5yIoM18uOd8xBZZ7C0X7omgJNqkAvAaLm0CxCj7JNQWrXwu62wbt4A8bbLJVl6EMMB/kdKK
        D4dbFAgWnD97TNkAidnZlDgvYgSmpr09wK9/bRx+iopHnwo4FqnuRWRlheNB7MAVst8owzyIaXVhX
        8O+TnuOuSSjRz9D1FZkmIiLMol0073dUZRyloUrrPA+wJ5hp6gIUAR7YiVxKFC5Yo05aeGCL2U/EH
        fQYQwHGw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFJak-003S5r-7o; Tue, 10 Jan 2023 18:43:22 +0000
Date:   Tue, 10 Jan 2023 18:43:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vernon Yang <vernon2gm@gmail.com>
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: fix comment of mte_destroy_walk
Message-ID: <Y72xykdPydb1Gav6@casper.infradead.org>
References: <20230110152216.1712120-1-vernon2gm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110152216.1712120-1-vernon2gm@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 11:22:16PM +0800, Vernon Yang wrote:
>  /*
>   * mte_destroy_walk() - Free a tree or sub-tree.
>   * @enode - the encoded maple node (maple_enode) to start
> - * @mn - the tree to free - needed for node types.
> + * @mt - the tree to free - needed for node types.

Should probably also fix the separator between the parameter name and
the description to be : instead of -.
