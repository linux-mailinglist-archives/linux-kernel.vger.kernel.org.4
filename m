Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22F762889A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiKNSxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:52:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CB619035
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:52:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B437DB811BC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FAAC433C1;
        Mon, 14 Nov 2022 18:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668451973;
        bh=zvg4yxCGie4tX/vQmTmF0cCzkrLxEjab7mvc5+U8IcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JEbKDv+IN0jvUH1bxC7CP5GCvElH9fdkjAl4tEW+0hY35kctPwL0EYbL/eUjc0b8M
         P+4gZah0g5s82bpEihxQp2kJmUMmMFwn6WlrMAvQoUKWlCSGwKmwl2d9uEqOkxtRjK
         aiqRg8lLNFtTn7HSjS08UKtPRAGFfWYyY90oQVog0MTy1Hcie0e+trso83JI81r6sR
         PvNXXADI6P5FBgdDTA5qkbseGo9TqP8Bnt/R/g7n2LkjU/FN3V8wFkU9tAufvjuYA2
         S4RTCzxgA7YDg35E1cgmkh/QqJkgVy19wNBtC9JvZ4OkY/bAcoyGab+49gEHohEIbP
         yEXNZpAVQj/Mg==
Date:   Mon, 14 Nov 2022 10:52:51 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 08/46] static_call, lto: Mark static keys as __visible
Message-ID: <20221114185251.eq45bjri6tsv4nct@treble>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-9-jirislaby@kernel.org>
 <Y3Jj67TZ9tA2a6Pf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3Jj67TZ9tA2a6Pf@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:51:07PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 14, 2022 at 12:43:06PM +0100, Jiri Slaby (SUSE) wrote:
> > From: Andi Kleen <andi@firstfloor.org>
> > 
> > Symbols referenced from assembler (either directly or e.f. from
> > DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
> > they could end up in a different object file than the assembler. This
> > can lead to linker errors without this patch.
> > 
> > So mark static call functions as __visible, namely static keys here.
> 
> Why doesn't llvm-lto need this?
> 
> Also, why am I getting a random selection of the patchset?

Same, please Cc me on the whole set next time.

-- 
Josh
