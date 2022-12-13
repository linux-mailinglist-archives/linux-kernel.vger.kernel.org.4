Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0105164B728
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiLMOTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiLMOTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:19:30 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54081F2C1;
        Tue, 13 Dec 2022 06:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xj+46XsGCiuRptzmCeVp1J+10N8VecdenZbr/C6ML0A=; b=KABBl5RXxw55KkplnsTtB+joDl
        fwFA+fpf/6D9A6XSn7bI281TV3T3UIECtimeg28f+0xnDjBwGWjzcOBNrJY66501fr2tsL7jaX8AZ
        gx3LtwvEHYoE5ZtJPICJXfGY7m2qF59uKLvRjecYGPwXtS0AuQgcDE1xMN05aVrG3hZFqwX+1Vi7R
        gEe01CuuYVsJhwP4JT2KghDQv6oxXPgQ2bbg7QkyMoQ3JENpN6mMdrtxM85ctX/THAZRuAL78UGaL
        m7UjqcH2IohruaWlJDIqb46JdZActLJncLgUGOAgEMpx7qSj7HCzuxH6Hy806ZyRIjFw+DGUJN/MH
        CwEqJGRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p567x-00AA4V-9Q; Tue, 13 Dec 2022 14:19:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7302030036B;
        Tue, 13 Dec 2022 15:18:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54DB1201D93F0; Tue, 13 Dec 2022 15:18:08 +0100 (CET)
Date:   Tue, 13 Dec 2022 15:18:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix spelling mistake "teh" -> "the"
Message-ID: <Y5iJoAJn2zSBLx/h@hirez.programming.kicks-ass.net>
References: <20221207094512.2281808-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207094512.2281808-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 09:45:12AM +0000, Colin Ian King wrote:
> There is a spelling mistake in a WARN_FUNC message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/objtool/check.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 4350be739f4f..71d6e9b85217 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -3859,7 +3859,7 @@ static int validate_entry(struct objtool_file *file, struct instruction *insn)
>  		}
>  
>  		if (!next) {
> -			WARN_FUNC("teh end!", insn->sec, insn->offset);
> +			WARN_FUNC("the end!", insn->sec, insn->offset);

This was quite on purpose, you need to teach your spell checker about
nerd humour :-)
