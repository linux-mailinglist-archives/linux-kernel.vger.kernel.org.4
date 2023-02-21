Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0427269E9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBUVyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBUVyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:54:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3158B459
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xgS+ycFf/PgttNNqDkkgjsbdy6evPruk1xeeMxOJIrE=; b=Qbx2zhcCMHUs6dwRRDjeryf/+U
        T1cktGjlGmbshBLQ8fZ0okp4t6ye6wcHORE1uz0qbWB1g314zS7KNU6lWNeKISnOgyGZXrjhz1FBe
        9P8FzsLYbU05iTa4YzKec1qiJzaBYkWMKaNPudxU7CzQLK+rgpGPsE6zKTcvoHxnxoTlF6GMyAjaI
        U7/4Gtm3VQ5CsValxMOYVcHlyk0OrFxYTQJxd9iFjw4wreYmwFmDWXQkd8rZcyCBuHyQ5geNVI/CG
        PLIJ4PEjrgfHph1awcBZZqlNBy7wMoatxcEHpmijgeeZqo7ss+blIK2FEVMOZlrudr98XsBanVgkM
        xy9zdy3Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUaaH-009tDq-7D; Tue, 21 Feb 2023 21:54:01 +0000
Date:   Tue, 21 Feb 2023 13:54:01 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Message-ID: <Y/U9ecRsrrCQBl3Q@bombadil.infradead.org>
References: <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
 <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
 <Y9z76ZLe4On96xIN@hirez.programming.kicks-ass.net>
 <Y9z+SerR8mlZYo16@hirez.programming.kicks-ass.net>
 <6c47dbcf-2a17-6bb2-719b-841d851c603b@I-love.SAKURA.ne.jp>
 <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
 <caa13441-5f95-b7d6-dd5d-1cf49e709714@I-love.SAKURA.ne.jp>
 <Y+Eh9CFdTwwv+hot@bombadil.infradead.org>
 <Y+pWzult7UDgoilC@hirez.programming.kicks-ass.net>
 <m21qmkahoj.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m21qmkahoj.fsf@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:31:58AM +0800, Schspa Shi wrote:
> I have written a SmPL patch to complete this
> check

<-- etc -->

> And I have found a lot of bad usage

Can you share what you found here? Just a simple list of affected
files.

  Luis
