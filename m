Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06CE6320C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKULgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiKULfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:35:51 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45172BF597
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MhKhD9m2/0VFhnbA/V+dlzuPgzWihjvXSSVAZ4aiFOI=; b=Pzx1qJbYR4uWKHV3HpkOi4De/Y
        pCTyV5ThdkQih4wFqFR+Lk6JMo8RWI+qZjdAYWZVyS8+HFcmpc975wGWVoX/6ucfgi9ey5LHh1y4z
        XsrAkosbz0Nk2GwebPNdPCdUHgVntL1eciSbHj/foAtAhLBaYhrhB/pJB6MCe5k8lH8XMrRcOIuyM
        2dnnD1R2g4GLmVpJfJ0HS9hyq8MdDElmelzrgvuoBeCij11lIIn0FOM8+qdHCQUA0gDUpPtBBbNye
        vARS/UPo7NR9e1H5XVH6SLpWoKKKCKtuqpEWBu41tV6SSVOIRQtdvMO07vv7or+5tRE84D/l49Mbt
        xgrJaK/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ox51r-0035fY-2H; Mon, 21 Nov 2022 11:31:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C7C4300244;
        Mon, 21 Nov 2022 12:31:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CBEE203A8993; Mon, 21 Nov 2022 12:31:57 +0100 (CET)
Date:   Mon, 21 Nov 2022 12:31:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     jpoimboe@kernel.org, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning for next-20221118
Message-ID: <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 08:07:36PM -0800, Paul E. McKenney wrote:
> Hello!
> 
> I have started getting this from rcutorture scenario TREE09:
> 
> vmlinux.o: warning: objtool: do_idle+0x25f: unreachable instruction
> 
> Should I be worried?

Typically not a scary warning that.

> If so, please let me know what additional information you need.

.config and compiler version so that I might recreate and observe what
it's complaining about would help :-)
