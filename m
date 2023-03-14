Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178436B91D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjCNLka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCNLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:40:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55DC95E23
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P3ObctyVY3PQneInfc2NMV3keB7/J4tJpNfFoW/AfSw=; b=f5JL5y8yqN4RDO4Cyy5OyVQ852
        CJpeBxb4RM2Sg+Ok/66zcN2rVtZHPQuhMFc2nVgH/IlXt9C7C4F1T6Ou5ZLWbcri2GxXLY5GRe6XY
        XmdhUFwKaC+tgq4/eB5u1njWURf+cnBtVCuSv0xi8n3uuk/nd4R39vzPEO8TMTEqN+AtdAaZgnbe+
        ofRaPwwU5WUxMQ7MsilgiOmPzaqG+cVHlX4sVNaBKBFl8QCRiXnUPpsbLVKWYsVgT1uckU012653j
        7JNJ/WivkI+ywT1zZ9wE3suFFnPRDnSeYKZN+dYhZDwCDiqmJgK2KwYZ91hMiq8QUBG8jpXf/aJiS
        2NMdb58Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pc30t-00Cra8-DI; Tue, 14 Mar 2023 11:40:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A2E930030F;
        Tue, 14 Mar 2023 12:40:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A762202F7F8A; Tue, 14 Mar 2023 12:40:18 +0100 (CET)
Date:   Tue, 14 Mar 2023 12:40:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc2
Message-ID: <20230314114018.GF1845660@hirez.programming.kicks-ass.net>
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net>
 <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
 <ZA+ttVOPBvNOYHoC@lothringen>
 <dc031bc7-8ca4-7ca7-c24f-9db65b5547e4@roeck-us.net>
 <ZBBYCSZUJOWBg1s8@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBBYCSZUJOWBg1s8@localhost.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:18:33PM +0100, Frederic Weisbecker wrote:
> How does the following look like as a culprit?
> 
> 62b95a7b44d1 (ARM: 9282/1: vfp: Manipulate task VFP state with softirqs disabled)

Ooh yeah, that asm implementation of local_bh_{dis,en}able completely
miss out on the lockdep state tracking. Also I think it breaks RCU, note
how __local_bh_disable_ip() explicitly does rcu_read_lock() for the
first bh-disable.


