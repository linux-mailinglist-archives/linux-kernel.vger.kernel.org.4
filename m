Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2358691A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjBJI7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjBJI7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:59:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BFB5AB3D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 00:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1P4NzMdoEGpBlkz0Fde/YZOPgE1woS8ZcuOReSlZtHA=; b=IGY+0fqyR/OppJzoOi9ZObqCbm
        5edIslJ0AB2dC6u1FcyzHWJZ37diKmpjqV1MJ39ObdFjOudg0DKgOawGlcchs2me6eUPh45aQ8Ec6
        EqBxa5jT+Wv3F5bAXoo5O6Quw5vnymYsyks6HNIyru7SLaKBndUCFTnG7mtyc/nr7YhBnLSjC6dV5
        shuQpXv3LGGii98K27Ux6HFcnPeIJdW3+I8h9oa0mR0VPTGEFuHsvmnmr8ilkaems0r8Rvuf7wIWt
        l+Aey85prrcyAnsda0j9Mk3iqzI1Yl5pV9j/q77/86e9b6pKIrVRNXMp9R3atSaXW84/tylafOoin
        iSj7YRDQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pQPEg-008AA4-1A;
        Fri, 10 Feb 2023 08:58:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13167300293;
        Fri, 10 Feb 2023 09:59:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F10F820A1CFAF; Fri, 10 Feb 2023 09:59:04 +0100 (CET)
Date:   Fri, 10 Feb 2023 09:59:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] objtool: Honey, I shrunk the instruction
Message-ID: <Y+YHWHjv87qvc+8s@hirez.programming.kicks-ass.net>
References: <20230208171756.898991570@infradead.org>
 <20230209195740.v4dhjuuri53wimui@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209195740.v4dhjuuri53wimui@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 11:57:40AM -0800, Josh Poimboeuf wrote:

> To make the last patch legit we could just have reloc_offset(),
> reloc_addend(), reloc_type() helpers to abstract access to rela/rel
> fields.
> 
> And I'm sure there are other savings we could do to struct reloc, like
> single-linked lists, bitfields, etc.
> 
> Let me know if you want me to do it.

I'll make a start today -- I've got snot pouring out of me, so thinking
isn't going to happen, might as well just do the busy work :-)
