Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949866E0C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjDMLXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDMLXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:23:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC41C901C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mCo4jjCTt7+WfKx9scgq42GmMYkJ0sRMR3VcFCLLlTM=; b=Z0wmyNmvuUpNkpjs2Fk0MuXKjX
        4TI58mEbq6MVj7yUQBAnhQ3RdYWgBH+i7R6Cdx9+UQsB0QufWnpB8pyQTxxuyMfRrNtD7DawIkA/2
        pTsr/6Tx7nBX7KTzXJWmU0tJn+1rdS3VI25YilsELR+nfmM2gqzd/nf3jYDY6KXPv0IqOjaxl2h3P
        Gy9biHSjR4Igr9K1dnGzj3UNN7Pa3HY+3FLiNRrZ2juTgtAAPdiZFdDXZrlgtI2M/4kvpHnf5h8zB
        5lGWJ9L1RVzQV7Wc6zy9Frc1cAQQVyhGJZ6vmTRgJtgZ748YJdBsraBl/NdkZiRtsGhJZmz6h5viJ
        /IykfgmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmv33-00EihI-2J;
        Thu, 13 Apr 2023 11:23:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 480A830002F;
        Thu, 13 Apr 2023 13:23:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B641267A808D; Thu, 13 Apr 2023 13:23:29 +0200 (CEST)
Date:   Thu, 13 Apr 2023 13:23:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 3/3] objtool: Generate ORC data for __pfx code
Message-ID: <20230413112329.GL4253@hirez.programming.kicks-ass.net>
References: <cover.1681331135.git.jpoimboe@kernel.org>
 <bc3344e51f3e87102f1301a0be0f72a7689ea4a4.1681331135.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc3344e51f3e87102f1301a0be0f72a7689ea4a4.1681331135.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 01:26:15PM -0700, Josh Poimboeuf wrote:

> @@ -4158,7 +4172,7 @@ static int add_prefix_symbols(struct objtool_file *file)
>  {
>  	struct section *sec;
>  	struct symbol *func;
> -	int ret, warnings = 0;
> +	int warnings = 0;
>  
>  	for_each_sec(file, sec) {
>  		if (!(sec->sh.sh_flags & SHF_EXECINSTR))

Stray hunk that should go in the first patch I suppose.
