Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E40D72AF92
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 00:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjFJWor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 18:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFJWop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 18:44:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFC135A9;
        Sat, 10 Jun 2023 15:44:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686437082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V3yau0vghxw/AlYR4hWr8BYruFNzgWhFzOkKNumR8JQ=;
        b=xCKf4rx8SoGlrUPIcCKgO9G01gpf9BncjgTd3o+brtlCNMxjCg95UKoP4j7iCGm+jykn9b
        XHr2mNagemCsfyleC7cM/CCottB9UNwZBF71bzSfweOZB3B55fdmYDwCitmHPYP88P5wHw
        kKGZk2iHxqpAHchRnXJ1VwMOJeB37dAyYreWV0tJqdDmjqR3RUCAnCjzpBT/Ekuh41q/H1
        ksEoUyIamAdDlCam04n4XqczaKSDnx9iv1KjYZ2lXn1+OqB4C6O8fnq7s2UktF+qwKirJy
        dWi0a2cnv1GY3vFtLabJhgMYVzGsYxpx26as8ulOCgSPW5SGv3T2kUN4KT2R3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686437082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V3yau0vghxw/AlYR4hWr8BYruFNzgWhFzOkKNumR8JQ=;
        b=NpRuBkBrtJqMx0CUz6W4ucvNFlU95T1lHC6Iz01YkRJq6+xAXyDej5i6neoyCPTk5GRlZW
        MbH4WeepBpMCuTCQ==
To:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        npiggin@gmail.com, akpm@linux-foundation.org
Subject: Re: [merged mm-hotfixes-stable]
 lazy-tlb-fix-hotplug-exit-race-with-mmu_lazy_tlb_shootdown.patch removed
 from -mm tree
In-Reply-To: <20230607200008.C2154C433D2@smtp.kernel.org>
References: <20230607200008.C2154C433D2@smtp.kernel.org>
Date:   Sun, 11 Jun 2023 00:44:42 +0200
Message-ID: <87zg576ip1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07 2023 at 13:00, Andrew Morton wrote:

> The quilt patch titled
>      Subject: lazy tlb: fix hotplug exit race with MMU_LAZY_TLB_SHOOTDOWN
> has been removed from the -mm tree.  Its filename was
>      lazy-tlb-fix-hotplug-exit-race-with-mmu_lazy_tlb_shootdown.patch
>
> This patch was dropped because it was merged into the mm-hotfixes-stable branch
> of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Can you please drop that completely as there is no point to merge a
bogus "fix'.

Thanks,

        tglx
