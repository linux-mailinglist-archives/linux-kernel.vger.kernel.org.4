Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2093772FC30
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjFNLQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjFNLQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:16:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AFB12E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OUbSjgz5CiDvA3N1a/uPgCM7O8dmgJlF93ndUOwjOtA=; b=fyaob3fGXO1t1tzA4yYgp7vjgW
        +EsKjmIbCqY/y+zFMiJg62Jl1Bdrhbu0OtJkdqR/YpMI6mDhv1zlOnjrR3T2BJgGXeH6wI1ZkI1CG
        47zhKjjoHy4b9uGbu7y2jP9wpwKNZIKV0VIsLCrdY/HXon6TLOW5O9Dz73GhCkWhB7U3bU6XOgzzS
        cI2w8vQXmK76l+j9IIOMLP/NWQSXvFgCRL0V0AI+IaqoIYrB4vyd5Jc67YTm1E1b8Jjan0bMKZamx
        R1pgLdmxQ5OvP9HupBmLDmFWgQrTtZ4eVER+iRtNgzfVP3NgSmtFHlXpi1mJCYaSmNq229NL10IMZ
        5x2lFT0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9OUX-006Bmm-Mk; Wed, 14 Jun 2023 11:16:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B6153002A9;
        Wed, 14 Jun 2023 13:16:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CBC426979290; Wed, 14 Jun 2023 13:16:44 +0200 (CEST)
Date:   Wed, 14 Jun 2023 13:16:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614111644.GH1639749@hirez.programming.kicks-ass.net>
References: <20230613134105.GA10301@redhat.com>
 <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
 <20230614094522.GA7636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614094522.GA7636@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:45:22AM +0100, Richard W.M. Jones wrote:
> Debian should work too actually, just run the following command until
> it hangs:
> 
> > >   $ while guestfish -a /dev/null -v run >& /tmp/log; do echo -n . ; done

What kernel with guestfish use?
