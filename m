Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07A764D157
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiLNUgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiLNUf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:35:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A20D186E8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:32:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 245DDB81A29
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 20:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D105C433EF;
        Wed, 14 Dec 2022 20:32:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="osp9pmAa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1671049945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wC3DK+YgPQ0ttmctrXPD0kFnokQIXCIWlQkz/+5zs88=;
        b=osp9pmAaLeaEtVc0TwsBqcNo3tuta3lIsUC5wP8EJ6F0nLDAtQAE3rCg/v5W+VpTxzRMZS
        +3NDvgIlfLEYW92bs+FQ6thKSq1dxwTpfhFG7X0AtwerHsqD5Ae/wHQvgn17IHu3g2faf9
        VBRDFcdEFAIzChH/oPx+OjS9NdtVYp4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ff4d9f61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 14 Dec 2022 20:32:24 +0000 (UTC)
Date:   Wed, 14 Dec 2022 13:32:18 -0700
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: lib: Separate instruction decoder MMIO type from
 MMIO trace
Message-ID: <Y5oy0vwZQAwzkDkr@zx2c4.com>
References: <20221212210254.2559995-1-Jason@zx2c4.com>
 <20221214195629.GA15255@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221214195629.GA15255@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:56:29AM -0800, Ricardo Neri wrote:
> > @@ -347,7 +347,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  	unsigned long *reg, val, vaddr;
> >  	char buffer[MAX_INSN_SIZE];
> >  	struct insn insn = {};
> > -	enum mmio_type mmio;
> > +	enum insn_mmio_type mmio;
> 
> It would be good to preserve the reverse fir order in the variable
> declarations.
>
> > -	enum mmio_type mmio;
> > +	enum insn_mmio_type mmio;
> 
> Same here.

Maintaining reverse Christmas trees would be in the holiday spirit,
after all. I'll send a v2.

Jason
