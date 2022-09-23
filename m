Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B15E790F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiIWLFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIWLFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:05:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974CE2CC8B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=32ensgDBOQz5xWHfSGKcwK3n4M02OBIJrH3OD6Cje10=; b=Z5pizHX2VGbREA8O0D7gIopoF2
        kiHxX37/gciQBWP3z35OGsS6mj5KkStoMmwuJjnx+I9dSEmdcwEBQsNzT6Ju1s4Ks8J7vWyStLzto
        /b7h7D1lBtlJeWYUNcjHcAy+pVMdaSIGD235pV2nVTgUa40chOJAnXqttDeVxhDpbBHKANKLsFZ6y
        JNLWMY2DZUN6g1d/+kh4w8YwChtJ4pdW3ceRmUBzcDGlH7vrtT3kBooFBknhgOPxLxJ5e5zofXNaX
        JrDLqpg2euQF6NdzCbN5PyN2qfk64hbTy8jnT5ftEQSTE5zbTjGSSzEEVPoPMtefzyIT1p8b0Y8yS
        Vx8k1rmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obgUL-00FCYM-C3; Fri, 23 Sep 2022 11:04:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6830A300074;
        Fri, 23 Sep 2022 13:04:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC8F3201D93FD; Fri, 23 Sep 2022 13:04:55 +0200 (CEST)
Date:   Fri, 23 Sep 2022 13:04:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        quic_namajain@quicinc.com
Subject: Re: [PATCH] kernel/hung_task: add option to ignore task
Message-ID: <Yy2S16jOPVzDZSBe@hirez.programming.kicks-ass.net>
References: <20220923085335.19593-1-quic_yingangl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923085335.19593-1-quic_yingangl@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 04:53:35PM +0800, Kassey Li wrote:
> By default, hung_task will iterate the tasklist and check
> state in TASK_UNINTERRUPTIBLE with a given timeout value.
> 
> Some tasks may in this state as expected but reported by hung_task.

Please explain..
