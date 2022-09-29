Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51DC5EF35A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiI2KV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiI2KVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:21:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BB341A397
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:21:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD5C22309;
        Thu, 29 Sep 2022 03:21:21 -0700 (PDT)
Received: from [10.57.66.102] (unknown [10.57.66.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F403D3F73B;
        Thu, 29 Sep 2022 03:21:12 -0700 (PDT)
Message-ID: <0007218f-96f0-c348-0dfb-7cb54f014b1c@arm.com>
Date:   Thu, 29 Sep 2022 11:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH linux-next] coresight: use sysfs_emit() to instead of
 scnprintf()
To:     James Clark <james.clark@arm.com>, zhangsongyi.cgel@gmail.com
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20220927115136.259926-1-zhang.songyi@zte.com.cn>
 <b8ad73ea-a20e-0e74-766e-eeb4cdeb1890@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <b8ad73ea-a20e-0e74-766e-eeb4cdeb1890@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 15:56, James Clark wrote:
> 
> 
> On 27/09/2022 12:51, zhangsongyi.cgel@gmail.com wrote:
>> From: zhang songyi <zhang.songyi@zte.com.cn>
>>
>> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
>> should only use sysfs_emit() or sysfs_emit_at() when formatting the value
>> to be returned to user space.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>


>> ---
>>   drivers/hwtracing/coresight/coresight-stm.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
> 
> Reviewed-by: James Clark <james.clark@arm.com>


I have queued this locally for now, will push it once the next
cycle is out.

Suzuki
