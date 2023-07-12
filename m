Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E68750BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjGLPJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjGLPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:09:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9E41FF6;
        Wed, 12 Jul 2023 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DNc/ePBoNgd+bEoPBcid3Rf/V7MDlOQu7ZJsXNCj0Mw=; b=jiqWTed+ZeLN2KTPCdu1HY3ZBo
        wH5c3x89xYsxPuc/QHg8uV5veO+oAqZ8AmXA9rY0Q98FKHPJw+OiAe6dHd+NFpKwLxhvWknI6uMXq
        Wcg903Vv3L9yDHlbBHFkDjr+1DAA5jBhb/YE8PD7rHARUVRRUk0lkM5C7TOWCaVhccxl8adTzE5Eb
        rO4px1w5Nj3DcFx0QKzw0kVjHuMi3zhu9LU/2T5c1R3YOdlzMfzBwe4iYmlQ9h/D+LG9RJ0VprlSG
        4BxIWdiLfUH9WK3mMzqlzC004PI9QICt61A+eXbUdghJDnkZ+i2o5ZgjpnknSikyCmebQfhFb/MR6
        qlI+KlLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJbS0-00Gnv5-1z; Wed, 12 Jul 2023 15:08:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F90030036B;
        Wed, 12 Jul 2023 17:08:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8781D240EBDA6; Wed, 12 Jul 2023 17:08:18 +0200 (CEST)
Date:   Wed, 12 Jul 2023 17:08:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [RFC][PATCH] sched: Rename DIE domain
Message-ID: <20230712150818.GL3100107@hirez.programming.kicks-ass.net>
References: <20230712141056.GI3100107@hirez.programming.kicks-ass.net>
 <xhsmh1qhduq9d.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh1qhduq9d.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:02:38PM +0100, Valentin Schneider wrote:
> On 12/07/23 16:10, Peter Zijlstra wrote:
> > Hi
> >
> > Thomas just tripped over the x86 topology setup creating a 'DIE' domain
> > for the package mask :-)
> >
> > Since these names are SCHED_DEBUG only, rename them.
> > I don't think anybody *should* be relying on this, but who knows.
> >
> 
> FWIW I don't care much about the actual name.

Confusion is due to x86 growing an actual die topology and this not
being it.

Other than that, I can't be bothered too much about the silly name
either.

> There are some stray references to DIE in comments - see below. Bit funny
> to see:
> - *  - Package (DIE)
> + *  - Package (PKG)
> 
> With that:
> Acked-by: Valentin Schneider <vschneid@redhat.com>

Durr, I did a git-grep SD_INIT_NAME().. Thanks!
