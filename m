Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7551E5EF2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiI2JuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiI2Jtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:49:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A37314AD52
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oWI8BGhzz8ExLE9i1bUY15LzE2VNb5VTJohfRI0WA5o=; b=tI7vuN/5D7RyNXnRlZSL7tHGXL
        rP+0OrHexBFS1SIgWqrufm3GaZtIlpdoRypCdrYaLRLaPZL8g0NCcMp0EOr8pl+Q8zUbiMRYKxKPb
        /XWB26tUGyrB7Aa/1mFKo5dxD4BIEV5lgyZ7B1JQcFJXQXeW8r3BMtkmRL3ET4bgYMK27y89SEvTQ
        18teP6PnJWIGPpn3NwIkF/4NbUK7AKWoIlW4+8T0Ns5vEiJ2QT6ywrEMlmm1Wx4Es/h21FRaXrY6t
        aBEVEZvKsMXDGSlEjct22xuWV5yDuQWivg122BszXjZzHuL613FKiX68uCudYTynkkD09Q1cDUdx9
        i3QU+96g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odq8f-00DAY2-4E; Thu, 29 Sep 2022 09:47:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DCE78300342;
        Thu, 29 Sep 2022 11:47:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6255203D9A2D; Thu, 29 Sep 2022 11:47:23 +0200 (CEST)
Date:   Thu, 29 Sep 2022 11:47:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jian-Min Liu <jian-min.liu@mediatek.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Because it messes up the order in which people normally read text.
Why is top-posting such a bad thing?
Top-posting.
What is the most annoying thing in e-mail?

On Tue, Sep 20, 2022 at 10:07:59PM +0800, Jian-Min Liu wrote:
> 
> Update some test data in android phone to support switching PELT HL 
> is helpful functionality.
> 
> We switch runtime PELT HL during runtime by difference scenario e.g.
> pelt8 in playing game, pelt32 in camera video. Support runntime
> switching PELT HL is flexible for different workloads.
> 
> the below table show performance & power data points: 
> 
> ---------------------------------------------------------------------
> --|                      | PELT
> halflife                                |
> |                      |----------------------------------------------|
> |                      |       32      |       16      |       8      |
> |                      |----------------------------------------------|
> |                      | avg  min  avg | avg  min  avg | avg  min  avg|
> | Scenarios            | fps  fps  pwr | fps  fps  pwr | fps  fps  pwr|
> |---------------------------------------------------------------------|
> | HOK game 60fps       | 100  100  100 | 105 *134* 102 | 104 *152* 106|
> | HOK game 90fps       | 100  100  100 | 101 *114* 101 | 103 *129* 105|
> | HOK game 120fps      | 100  100  100 | 102 *124* 102 | 105 *134* 105|

You have your min and avg fps columns mixed up, your min cannot be larger
than avg.

Also, with min fps mostly above the actual screen fps, who cares. And
seriously 120fps on a phone !?!? for worse power usage! you gotta be
kidding me.

And I googled this game; it is some top-down tactical thing with
real-time combat (as opposed to turn-based) (DOTA like I suppose),
60 fps locked should be plenty fine.

> | FHD video rec. 60fps | 100  100  100 | n/a  n/a  n/a | 100  100  103|
> | Camera snapshot      | 100  100  100 | n/a  n/a  n/a | 100  100  102|

Mostly I think you've demonstrated that none of this is worth it.

> -----------------------------------------------------------------------
> 
> HOK ... Honour Of Kings, Video game
> FHD ... Full High Definition
> fps ... frame per second
> pwr ... power consumption
> 
> table values are in %

Oh... that's bloody insane; that's why none of it makes sense.


How is any of that an answer to:

  "They want; I want an explanation of what exact problem is fixed how ;-)"

This is just random numbers showing poking the number has some effect;
it has zero explaination of why poking the number changes the workload
and if that is in fact the right way to go about solving that particular
issue.
