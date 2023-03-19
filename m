Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F94A6C047C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 20:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCSTmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 15:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCSTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 15:42:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67B13DD3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 12:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dckGfQg6kn3B8kgvZ3tmjZnRr1vtXFAdWVSiqcNmDYA=; b=keiJjIFniHCX8fhpO8BrWfQDwc
        +xwQ+qHC8BCpNgEg2qx+S8wZ+VcnIVxCEOzLW7uu9YnPWXq0b42uh0q3t+eU7qK8lkzHn6h1bRyT4
        5fuX4cbxHZOMZUyR6AvPIsD3dPFoIdurzgNlgXrBUlsq7k6omFSHZYKpDgKBubUgtBEtHkU8oL0fI
        BBC/20GSmImV6rDbfnfvkUcY/6HIZWRchyhtbiBA2Ry2dci/s6gs/skEvxajIz4wn6BadtenowyqF
        T8FMzdl5mqsVv0Baka5PlwujpKZoITJSPV3nqCJMKLcrkz82RlIk/O5sjH3SQdU2OzhH0x+LLt8/x
        Uibee0rQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pdyv2-000Ktv-20; Sun, 19 Mar 2023 19:42:16 +0000
Date:   Sun, 19 Mar 2023 19:42:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Liam.Howlett@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] maple_tree: remove unused maple_tree functions
Message-ID: <ZBdlmDVKdrtM4BXb@casper.infradead.org>
References: <20230319132903.1702426-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319132903.1702426-1-trix@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 09:29:03AM -0400, Tom Rix wrote:
> clang with W=1 reports
> lib/maple_tree.c:331:21: error: unused function
>   'mte_set_full' [-Werror,-Wunused-function]
> static inline void *mte_set_full(const struct maple_enode *node)
>                     ^
> lib/maple_tree.c:336:21: error: unused function
>   'mte_clear_full' [-Werror,-Wunused-function]
> static inline void *mte_clear_full(const struct maple_enode *node)
>                     ^
> lib/maple_tree.c:341:20: error: unused function
>   'mte_has_null' [-Werror,-Wunused-function]
> static inline bool mte_has_null(const struct maple_enode *node)
>                    ^
> These static functions are not used, so remove them.

No.  They're just not used yet.  NACK.
