Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461A56F3BF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjEBBwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjEBBw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:52:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159051FE2
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 18:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A852B6209C
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1B8C4339B;
        Tue,  2 May 2023 01:52:24 +0000 (UTC)
Date:   Mon, 1 May 2023 21:52:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v4 00/12] sched: Avoid unnecessary migrations within SMT
 domains
Message-ID: <20230501215220.2591dd22@gandalf.local.home>
In-Reply-To: <20230502014254.GA1219@ranerica-svr.sc.intel.com>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
        <20230429153219.GC1495785@hirez.programming.kicks-ass.net>
        <20230502014254.GA1219@ranerica-svr.sc.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 May 2023 18:42:55 -0700
Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:

> I am sorry changelogs are not sufficiently clear. I thought stating the
> overall goal in the cover letter was enough. In the future, would you
> prefer that I repeat the cover letter instead of referring to it? Should
> individual changelogs state the overall goal?

Yes. Every commit should have a change log that explains why that commit
was done without having to look elsewhere.

The cover letter should be the summary of what the patches do. But 5 to 10
years from now, when a git bisect comes across a commit, there's no
guarantee that a cover letter will be easily found. The change log may be
the only thing a developer debugging some code will have to understand what
the change was for.

I'm guilty of having poor change logs which I myself suffered from, as I
don't remember what I meant. So I've been more adamant on adding more
detail to my change logs which has saved me a few times.

-- Steve
