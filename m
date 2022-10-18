Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B666032AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiJRSpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJRSpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:45:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF16851A1D;
        Tue, 18 Oct 2022 11:44:59 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666118698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwT036ED2R2Jt6a0Ta2+W8JmfCSdT3LrmtR/TD7MVIw=;
        b=EnqWK9ZsZtBkiT1LCEjQIeN1bsNJv8zFJ9OQZsW0Zw0En2mWC7K5sjEcMkAWCXvq7IW84S
        C7ywFsuE32I4eRk4DZQnXCLxMW22FvL6JaMvEXXT0Q3N0BCteBWjeWYQ4tVur+GY3twITP
        gHvTCT/hzLT2tAZ97cVXEGC1ghrngDWu6kBQEEq6jFq/617vhwfoo27eGjt6rGYkcSn9W2
        yEq/lfOprltUHjVZ32FQC0mYlH/B8CEfhOVeqsx0xwlyHYuTNJOfvC+uXTo/d8AKjB2RqT
        LxmeVRoBx2DExa1oItawsYjNcm4GlcxhFFUXDOm+OUblFbKpjJpdq4kgvQpTiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666118698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwT036ED2R2Jt6a0Ta2+W8JmfCSdT3LrmtR/TD7MVIw=;
        b=uizRVPT/u/lw8SAeEl+0DAOf6UjsSkfVsO6mhplAsrjza8Rp5EGdQLZRr3KMnGfDHqjAEj
        KfuR1rEVW+C6kRBQ==
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        pmladek@suse.com, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
In-Reply-To: <20221018152418.GR5600@paulmck-ThinkPad-P17-Gen-1>
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <87k04x4e0r.fsf@jogness.linutronix.de>
 <20221018152418.GR5600@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 18 Oct 2022 20:50:57 +0206
Message-ID: <87ilkh0y52.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-18, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> Currently, I have this series on -rcu branch srcunmisafe.2022.10.03a,
> with Frederic's patches on branch "dev".  I will be producing a shiny
> new branch with your fix and Frederic's debug later today, Pacific
> Time.  With luck, based on v6.1-rc1.

Perfect!

> I will be incorporating these commits from Frederic:
>
> 6558b914fc4e ("srcu: Warn when NMI-unsafe API is used in NMI")
> 5dc788627109 ("srcu: Explain the reason behind the read side critical section on GP start")
> 54a118fce487 ("srcu: Debug NMI safety even on archs that don't require it")
>
> Are there other patches I should be applying?

Not that I am aware of.

John
