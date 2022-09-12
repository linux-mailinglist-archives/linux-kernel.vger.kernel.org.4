Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE125B556D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiILHjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiILHjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:39:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA212AC7F;
        Mon, 12 Sep 2022 00:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+OAxmEm1T5J6vPtIEq+6pqcyk6deyOQGMlnazsf+tkY=; b=UNFOjkjXRAR6GWbSloLeWIFve6
        Re+70yddduqrLnzFk/dhuvc4L3GejzX4v9ml8UkgB4SOiSsKPBBvXa0IfgjYdjmSjN7YfYYLxXCUb
        58PQpT7ySp9WTe4nhp96yiKe4uDlICAvIJk1hfuhV+2LNIicLh4PPPnytlKqpf6l1y/jw2sjsVaOh
        v6dJoYtNGAdlZCpsYO/F+f1ni9zGjqhRJSF0vuDgVkf3R4mZ/cz8JzR4zmSF3Y2V1uRBPCVybps9s
        ka50aIt44JcWXm1lNI2UaaKI1t5yx40nQXsjLjbICN09oeP3ALlrcB5wtVe1HLdo26sFaCK5WVBZk
        AjljIoFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXe23-00FiGc-Nv; Mon, 12 Sep 2022 07:39:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 935C33002AE;
        Mon, 12 Sep 2022 09:38:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 448332029F86F; Mon, 12 Sep 2022 09:38:58 +0200 (CEST)
Date:   Mon, 12 Sep 2022 09:38:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the cgroup tree
Message-ID: <Yx7iEv/wy5Olgu0M@hirez.programming.kicks-ass.net>
References: <20220912161812.072aaa3b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220912161812.072aaa3b@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 04:18:12PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the cgroup tree, today's linux-next build (x86_64
> allmodconfig) failed like this:

Hmm,. TJ should I base sched/psi on top of drivers-core-next and your
cgroup tree?
