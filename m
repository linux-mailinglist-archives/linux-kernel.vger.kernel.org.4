Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8663DBB6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiK3ROl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiK3ROJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:14:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 107591C10B;
        Wed, 30 Nov 2022 09:11:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47B6ED6E;
        Wed, 30 Nov 2022 09:11:40 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27DE83F73B;
        Wed, 30 Nov 2022 09:11:31 -0800 (PST)
Message-ID: <81d99fba-ce38-a9a4-4b80-aa3e2cc6f3c6@arm.com>
Date:   Wed, 30 Nov 2022 18:11:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] sched/topology: Remove EM_MAX_COMPLEXITY limit
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>, linux-eng@arm.com
Cc:     Ionela.Voinescu@arm.com, qperret@google.com,
        Lukasz Luba <lukasz.luba@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221121094336.3250917-1-pierre.gondois@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221121094336.3250917-1-pierre.gondois@arm.com>
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

On 21/11/2022 10:43, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>

[...]

> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> 
> Notes:
>     v2:
>      - Fix complexity computation in the commit message. [Dietmar]
>      - Use correct/latest function names. [Ionela]
>      - Added Rb from Lukasz.
>     v3:
>      - Keep paragraph 6.3 in sched-energy.rst with just a reference to
>        EM_MAX_NUM_CPUS, reference EM_MAX_NUM_CPUS in the commit message.
>        [Dietmar]

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
