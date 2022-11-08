Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A94E62205A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiKHXbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiKHXbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:31:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6D0BBF63;
        Tue,  8 Nov 2022 15:31:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABE8C1FB;
        Tue,  8 Nov 2022 15:31:43 -0800 (PST)
Received: from [10.57.68.207] (unknown [10.57.68.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE19B3F703;
        Tue,  8 Nov 2022 15:31:35 -0800 (PST)
Message-ID: <10992b96-85b1-bf1f-d7e1-994b00a507eb@arm.com>
Date:   Tue, 8 Nov 2022 23:31:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v5 10/14] perf: cs-etm: Update record event to use new
 Trace ID protocol
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20221101163103.17921-1-mike.leach@linaro.org>
 <20221101163103.17921-11-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221101163103.17921-11-mike.leach@linaro.org>
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
> Trace IDs are now dynamically allocated.
> 
> Previously used the static association algorithm that is no longer
> used. The 'cpu * 2 + seed' was outdated and broken for systems with high
> core counts (>46). as it did not scale and was broken for larger
> core counts.
> 
> Trace ID will now be sent in PERF_RECORD_AUX_OUTPUT_HW_ID record.
> 
> Legacy ID algorithm renamed and retained for limited backward
> compatibility use.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: James Clark <james.clark@arm.com>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

