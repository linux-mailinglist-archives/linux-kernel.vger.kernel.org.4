Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B0A694F81
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjBMSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBMSgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:36:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5241C16AE4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:36:41 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676313399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpciheN3Iwu+fTexs6isklXyu+ChUUbfNFz2x9B2V48=;
        b=yAtRztmBvZ/k/QLNGbyzhUwno22HztEOaYCEqpsCo4OfpmJzs4C/wPhePy7P4D3rnBWUEf
        7ySsvigzBXyU5qSKqTmsmApqIudIJCN4nFqwZiRrBtwfrwcC0GDsKDsIW2USlBNMcXPRKO
        P+ViPFOkIlReZlTh9yBry58dKA4Dgr2S2UXzizjhiJZo+GT9VW0Fzhca+P2HkvucOmB5uw
        YhnBWcCK62GnxGl1oocauFmqDtzx3OA0akGGItbvG6tcMJhBKltz7kknVaGvarqk57UK11
        TzyFBb+gf3dFiU7Q9ccH8/RCAvqb066/j+9uskNsZVVPDklZlhm9QdDATV5z0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676313399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpciheN3Iwu+fTexs6isklXyu+ChUUbfNFz2x9B2V48=;
        b=AQWYanLmgFUyVrPh1SY9YZonBzl73CNW8mk8K0kaDmMd73khJL4yAAe0IJCK3tsS+NmiD8
        SO2veFSZYQOLmaCw==
To:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/6] timers/nohz: Fixes and cleanups
In-Reply-To: <20230210140917.279062-1-frederic@kernel.org>
References: <20230210140917.279062-1-frederic@kernel.org>
Date:   Mon, 13 Feb 2023 19:36:39 +0100
Message-ID: <87fsb9tnt4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10 2023 at 15:09, Frederic Weisbecker wrote:
> Try to (partially) fix the issue reported in https://lore.kernel.org/lkml/20230128020051.2328465-1-liaoyu15@huawei.com/

Looks about right. Can you please remove that assert in the selftest
which started all this?

Thanks,

        tglx
