Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37F968AF55
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 11:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBEKWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 05:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBEKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 05:22:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D826213C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 02:22:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 92A7FCE11AB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 10:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1CEC433EF;
        Sun,  5 Feb 2023 10:22:44 +0000 (UTC)
Date:   Sun, 5 Feb 2023 05:22:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     wuqiang <wuqiang.matt@bytedance.com>, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v8 0/5] lib,kprobes: kretprobe scalability improvement
Message-ID: <20230205052240.4581ef09@rorschach.local.home>
In-Reply-To: <20221229235220.4044edccae7c9d39798af8e9@kernel.org>
References: <20221218050310.1338630-1-wuqiang.matt@bytedance.com>
        <20221229235220.4044edccae7c9d39798af8e9@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 23:52:20 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Matt,
> 
> Sorry, I missed to commented v7 patch. Anyway, please read
> my comments on previous version.
> 
> On Sun, 18 Dec 2022 13:03:05 +0800
> wuqiang <wuqiang.matt@bytedance.com> wrote:
> 
> > This patch series introduces a scalable and lockless ring-array based
> > object pool and replaces the original freelist (a LIFO queue based on
> > singly linked list) to improve scalability of kretprobed routines.
> > 
> > v8:
> >   1) objpool: refcount added for objpool lifecycle management  
> 
> At least this update part looks good to me.
> (But I think this may be useful only for kretprobe/rethook
> use cases...)
> 

Masami,

Were there other updates you expected from this series?

-- Steve
