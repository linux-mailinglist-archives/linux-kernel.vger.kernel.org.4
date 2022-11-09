Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4F622B06
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiKIMAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKIMAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:00:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D7732AC67;
        Wed,  9 Nov 2022 04:00:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D0581FB;
        Wed,  9 Nov 2022 04:00:46 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2422B3F534;
        Wed,  9 Nov 2022 04:00:38 -0800 (PST)
Message-ID: <94ee3daf-f6f8-129d-0160-c7584393a3c7@arm.com>
Date:   Wed, 9 Nov 2022 12:00:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 12/14] perf: cs-etm: Handle
 PERF_RECORD_AUX_OUTPUT_HW_ID packet
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20221101163103.17921-1-mike.leach@linaro.org>
 <20221101163103.17921-13-mike.leach@linaro.org>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20221101163103.17921-13-mike.leach@linaro.org>
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

On 01/11/2022 16:31, Mike Leach wrote:
> When using dynamically assigned CoreSight trace IDs the drivers can output
> the ID / CPU association as a PERF_RECORD_AUX_OUTPUT_HW_ID packet.
> 
> Update cs-etm decoder to handle this packet by setting the CPU/Trace ID
> mapping.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: James Clark <james.clark@arm.com>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

