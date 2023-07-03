Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAEA745F9C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjGCPOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGCPOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:14:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A996AFD;
        Mon,  3 Jul 2023 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1dry4yStP7R+lFUBsIqEAanf2sgiJUFqT925Vnhzd/8=; b=jIczw6TIczw+NZuhX+R0pmyY1w
        Ij+QI+Wqb3Zap6jh36hJtKCXnRpyyuN17o7fgrqa5/shRGMdQoBpzjcc3C6v+DKUNYmiQD4fU+iRX
        QLOoJ7DOinxcJEsqbJNRiQrl+7YjM6Uj7aqBxb7pbB5HZasnrexBCYK62Ci7rOQhwzK13/awnJm9b
        ZydCSNdYDJMbclQcgvrx5GZ1RuOlCLFXn4e6ifu7GNYpRe0LL3KjGGf2AQix6nWx1EfM7Dsc6zGxi
        io8OvM2e0REzHq/2ktzXnau3WMTrGXnMjz0BVM3eLo+lOTVyuZThcGCZXKwzyIZSPDioGgWwJNR9Q
        L09TQFcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGLFe-00A6np-3C;
        Mon, 03 Jul 2023 15:14:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CB1B30023F;
        Mon,  3 Jul 2023 17:14:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7BB52028E983; Mon,  3 Jul 2023 17:14:05 +0200 (CEST)
Date:   Mon, 3 Jul 2023 17:14:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the block tree
Message-ID: <20230703151405.GM4253@hirez.programming.kicks-ass.net>
References: <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
 <20230411215518.u2fgi7napfcwyuce@treble>
 <4959d0b8-96fe-7fe5-8b36-7e0a266d1d17@kernel.dk>
 <20230412001400.yraku5fwsjdchxvk@treble>
 <20230412114400.GB628377@hirez.programming.kicks-ass.net>
 <20230412162517.gji52t34zlvcu5bh@treble>
 <20230616124354.GD4253@hirez.programming.kicks-ass.net>
 <20230703110405.GU38236@hirez.programming.kicks-ass.net>
 <c47b8ba6-1384-8864-8767-949ec45c3bbe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c47b8ba6-1384-8864-8767-949ec45c3bbe@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 08:18:38AM -0600, Jens Axboe wrote:
> On 7/3/23 5:04?AM, Peter Zijlstra wrote:
> > On Fri, Jun 16, 2023 at 02:43:55PM +0200, Peter Zijlstra wrote:
> > 
> >> I've been getting reports from some anonymous people still using ancient
> >> GCCs (10.4) that also need the following:
> > 
> > Jens, will you pick this up or should I route it through the objtool
> > tree?
> 
> Sorry, guess it was waiting on me. Would be great if you could route it
> through the objtool tree. Thanks!

Will do! Thanks!
