Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBF36459C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLGMWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiLGMWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:22:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 720BC4C246;
        Wed,  7 Dec 2022 04:22:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97D0D23A;
        Wed,  7 Dec 2022 04:22:07 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 561E03F73D;
        Wed,  7 Dec 2022 04:21:57 -0800 (PST)
Message-ID: <40ff1e4c-b128-c0d0-a024-e454e843ee46@arm.com>
Date:   Wed, 7 Dec 2022 13:21:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 04/22] sched/core: Add user_tick as argument to
 scheduler_tick()
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-5-ricardo.neri-calderon@linux.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221128132100.30253-5-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 14:20, Ricardo Neri wrote:
> Differentiate between user and kernel ticks so that the scheduler updates
> the IPC class of the current task during the latter.

Just to make sure ,,, 05/22 introduces `rq->curr` IPCC update during
user_tick, i.e. the former?

[...]
