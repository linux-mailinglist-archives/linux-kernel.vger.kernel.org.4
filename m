Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA9664ED59
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiLPPCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiLPPCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:02:19 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAF84A5AC;
        Fri, 16 Dec 2022 07:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NPs0W5t2cOf2zrGs7tXQcsKuXaArtFEduwzkh4Ar+hk=; b=JFfMQXN4iJSg3sua/0RF14RQd7
        IvS7zX437DVWMc3mdg/V3lkDzIrC5VlaPM8f0G28+yFubGk38p3DrQrSkKmoXQnvBznD1fB7TcHet
        XlTiNDCMeLDa0z2kktFN+qjq+Zcly660lNT4jB7HDkqT5T9XFNoOXrNeW9diFEFbm41hlu57IWy4n
        GsZrqObbfNarSjd4CcqXG5V7KIV+REE/bde+u8fGu/W2wFbrcED0dv/97I2wz7VlOuKGh40530K1q
        mkpXmcKoDz5FZeWLSyNpHbTGPBtOv+sqcJ9kpHLr57vY/f+N2DJ6B2Z94FIb5ao8HeiOR5gV+pb9P
        uNZtWqHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6CDb-00BBxN-Cn; Fri, 16 Dec 2022 15:01:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB23330027E;
        Fri, 16 Dec 2022 16:01:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B203620A0465B; Fri, 16 Dec 2022 16:01:44 +0100 (CET)
Date:   Fri, 16 Dec 2022 16:01:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2][v2] cpuidle-haltpoll: Build as module by default
Message-ID: <Y5yIWKq5Ggpzvvag@hirez.programming.kicks-ass.net>
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
 <1670416895-50172-2-git-send-email-lirongqing@baidu.com>
 <080936016634.CAJZ5v0i9J2YimfQsqJiZjFMR9MLG0fdBf+Regr+_PcsYrAE=SQ@mail.gmail.com>
 <17a6782c79a44aada31246ddefe02bfb@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a6782c79a44aada31246ddefe02bfb@baidu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 02:32:15AM +0000, Li,Rongqing wrote:
> 
> > > Allow user to unload it in running
> > 
> > Just like that?  And corrupt things left and right while at it?
> > 
> > No way.
> > 
> > And why do you need this?
> 
> Cpuidle-haltpoll can not improve performance for all cases, like when
> guest has mwait, unixbench shows a small performance drop; So change
> it as module, user can insmod this drivers and rmmod this driver at
> run time

I'm thinking all this can be achieved by a small change to
haltpoll_want().
