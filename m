Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE80D611B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJ1TyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJ1TyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:54:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E3A245EA8;
        Fri, 28 Oct 2022 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e5314e7MKAMLIb3zwbxdaealEyLm4PnV3W7SwfDYJKo=; b=dCAwGvL9ZNNRsZqUE3tpFOXlhe
        FJqQ+QK9lDRNSqOe/XXWWaqqBaGQurTrGKmAoVwKmXT1p6aEqFtx3DB8TyhxlnUdovZFlgNas/0mR
        L4NfoKU/LoZWUvN8p68gToayE783JvI4cXNTWE6qlvhidGOFwrcMjR4GyuZ5CjLxZSte9Z67jTi2H
        MT7Y93jkIEmPZ0Xf4xAZPp0GSEf05kwyi5AjDHhmYKhHcrj60neqASAvUEGTgd8ig9Su/JzeIVpo4
        pOnLdhEC+LAX8leIyEpErZ+JFTi4oZd+tg98d3JU2Osl+Kp0uMnyrT0lhonQWF+lQWrAGrZNMxsK6
        2PsrMJjw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooVQU-007AUn-4O; Fri, 28 Oct 2022 19:53:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9EE5830008D;
        Fri, 28 Oct 2022 21:53:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BE9A2C26AB85; Fri, 28 Oct 2022 21:53:57 +0200 (CEST)
Date:   Fri, 28 Oct 2022 21:53:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        linux-tip-commits@vger.kernel.org,
        Pavan Kondeti <quic_pkondeti@quicinc.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [External] [tip: sched/core] sched/psi: Fix avgs_work re-arm in
 psi_avgs_work()
Message-ID: <Y1wzVeCYDFSO0KYe@hirez.programming.kicks-ass.net>
References: <20221010104206.12184-1-zhouchengming@bytedance.com>
 <166693932887.29415.17016910542871419770.tip-bot2@tip-bot2>
 <f990a324-e28e-6de1-acb0-ba764808a56a@bytedance.com>
 <CAJuCfpHOt1Vfc=ZtAYt_2QamOujfuFtNHAdJe7iBMmDgTLGtyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHOt1Vfc=ZtAYt_2QamOujfuFtNHAdJe7iBMmDgTLGtyw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 08:58:03AM -0700, Suren Baghdasaryan wrote:

> Not sure what went wrong. Peter, could you please replace this one

Probably me being an idiot and searching on subject instead of msgid :/

I'll go fix up -- tomorrow though, it's late and I'm likely to mess it
up again.

