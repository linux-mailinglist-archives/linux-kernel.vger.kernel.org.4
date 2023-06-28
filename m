Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745F4741B09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjF1VfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjF1VfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:35:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D94B1FE3;
        Wed, 28 Jun 2023 14:35:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687988098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oGFgO8vIJKfZgOfsYstghjtI2K67VzhERDDt0pVsmX8=;
        b=nDj6a4qXdIVzMoLU9lWgktdyaajqTMRQcqRamqUCj4Xe5nS75xNTGYvEPDrKCcpwHlpxjJ
        jeKxnk5O8vNoZIhphXNDu+JDZNrmHnsUhO8csIFqeu0ImVuNL65nG2A78Sopxp2C4k13HI
        YmeueUKOd7c/364kGKPapcnbrmz1pBY0ead+FuU4dySjTF8SDIe3hoaQVa1xHS60LN1P1e
        aRp14zckfPHgSpukUIWfB+gG14BYvJdfnb2wx68t0vxzmxrpVQDG4+vM+p9R7QGKtQZ94v
        nQSRcONI+mLsIXqCUlpOs+4cn/sj01bjf/jLlzNhNFccSYQ+sk3WOGaYBOjrEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687988098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oGFgO8vIJKfZgOfsYstghjtI2K67VzhERDDt0pVsmX8=;
        b=ExYSDHM8G4ATjuwOcPG9HtIntjW48Iw73IyQoq/mZGVjKIRfmsLDITkSJMLoKg5bxOwI0b
        a8kpeZGJDbCcfxDg==
To:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc:     ashok.raj@intel.com, stable-commits@vger.kernel.org
Subject: Re: Patch "x86/smp: Cure kexec() vs. mwait_play_dead() breakage"
 has been added to the 4.14-stable tree
In-Reply-To: <2023062812-regime-demote-14f8@gregkh>
References: <2023062810-override-roundup-e5bf@gregkh>
 <2023062859-snowboard-surrogate-8484@gregkh>
 <2023062812-regime-demote-14f8@gregkh>
Date:   Wed, 28 Jun 2023 23:34:58 +0200
Message-ID: <87r0pv2rul.ffs@tglx>
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

On Wed, Jun 28 2023 at 21:40, Greg KH wrote:
> On Wed, Jun 28, 2023 at 09:39:09PM +0200, Greg KH wrote:
>> On Wed, Jun 28, 2023 at 09:32:12PM +0200, gregkh@linuxfoundation.org wrote:
>> > 
>> > This is a note to let you know that I've just added the patch titled
>> > 
>> >     x86/smp: Cure kexec() vs. mwait_play_dead() breakage
>> > 
>> > to the 4.14-stable tree which can be found at:
>> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>> > 
>> > The filename of the patch is:
>> >      x86-smp-cure-kexec-vs.-mwait_play_dead-breakage.patch
>> > and it can be found in the queue-4.14 subdirectory.
>> 
>> Oops, nope, this breaks the build on 4.14.y :(
>
> And on 4.19.y, 5.4.y, 5.10.y, and 5.15.y, so dropped from all of them as
> well.

I'll have a look at it tomorrow.
