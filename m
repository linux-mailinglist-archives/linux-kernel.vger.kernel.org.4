Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D750F6217A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiKHPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiKHPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:04:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDFDF1834F;
        Tue,  8 Nov 2022 07:04:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73CA81FB;
        Tue,  8 Nov 2022 07:04:59 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0D053F73D;
        Tue,  8 Nov 2022 07:04:51 -0800 (PST)
Message-ID: <c974168f-d997-18e0-22fd-07a0e73c5aef@arm.com>
Date:   Tue, 8 Nov 2022 15:04:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 03/14] coresight: perf: traceid: Add perf ID allocation
 and notifiers
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20221101163103.17921-1-mike.leach@linaro.org>
 <20221101163103.17921-4-mike.leach@linaro.org>
Content-Language: en-US
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221101163103.17921-4-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2022 16:30, Mike Leach wrote:
> Adds in calls to allocate and release Trace ID for the CPUs in use
> by the perf session.
> 
> Adds in notifier calls to the trace ID allocator that perf
> events are starting and stopping.
> 
> This ensures that Trace IDs associated with CPUs remain the same
> throughout the perf session, and are only released when all perf
> sessions are complete.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

