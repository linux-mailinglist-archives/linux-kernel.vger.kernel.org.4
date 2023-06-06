Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ADD723DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjFFJhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbjFFJgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:36:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A473A1731;
        Tue,  6 Jun 2023 02:36:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C31582F4;
        Tue,  6 Jun 2023 02:37:10 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A1093F587;
        Tue,  6 Jun 2023 02:36:23 -0700 (PDT)
Message-ID: <49c9e20a-f020-0dc5-8601-06b5f0ab8c5c@arm.com>
Date:   Tue, 6 Jun 2023 10:36:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V5 6/6] coresight: etm4x: Add ACPI support in platform
 driver
Content-Language: en-US
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     scclevenger@os.amperecomputing.com,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>
References: <20230529062511.52016-1-anshuman.khandual@arm.com>
 <20230529062511.52016-7-anshuman.khandual@arm.com>
 <4c3572f8-9710-0955-72c6-a9907ce6ce8b@arm.com>
In-Reply-To: <4c3572f8-9710-0955-72c6-a9907ce6ce8b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Gentle ping.

On 30/05/2023 10:57, Suzuki K Poulose wrote:
> Hi Rafael
> 
> On 29/05/2023 07:25, Anshuman Khandual wrote:
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> Drop ETM4X ACPI ID from the AMBA ACPI device list, and instead just 
>> move it
>> inside the new ACPI devices list detected and used via platform driver.
>>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com> (for ACPI specific 
>> changes)
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/acpi/acpi_amba.c                           |  1 -
> 
> We would like to push this via the coresight tree. Please could you Ack 
> this change if you are happy with the proposal and the change ?
> 


Suzuki


> Suzuki
> 
> 
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++++
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
>> index f5b443ab01c2..099966cbac5a 100644
>> --- a/drivers/acpi/acpi_amba.c
>> +++ b/drivers/acpi/acpi_amba.c
>> @@ -22,7 +22,6 @@
>>   static const struct acpi_device_id amba_id_list[] = {
>>       {"ARMH0061", 0}, /* PL061 GPIO Device */
>>       {"ARMH0330", 0}, /* ARM DMA Controller DMA-330 */
>> -    {"ARMHC500", 0}, /* ARM CoreSight ETM4x */
>>       {"ARMHC501", 0}, /* ARM CoreSight ETR */
>>       {"ARMHC502", 0}, /* ARM CoreSight STM */
>>       {"ARMHC503", 0}, /* ARM CoreSight Debug */
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c 
>> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index e10f6676dd9b..fd6f9dff5881 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -3,6 +3,7 @@
>>    * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>>    */
>> +#include <linux/acpi.h>
>>   #include <linux/bitops.h>
>>   #include <linux/kernel.h>
>>   #include <linux/moduleparam.h>
>> @@ -2344,12 +2345,21 @@ static const struct of_device_id 
>> etm4_sysreg_match[] = {
>>       {}
>>   };
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id etm4x_acpi_ids[] = {
>> +    {"ARMHC500", 0}, /* ARM CoreSight ETM4x */
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, etm4x_acpi_ids);
>> +#endif
>> +
>>   static struct platform_driver etm4_platform_driver = {
>>       .probe        = etm4_probe_platform_dev,
>>       .remove        = etm4_remove_platform_dev,
>>       .driver            = {
>>           .name            = "coresight-etm4x",
>>           .of_match_table        = etm4_sysreg_match,
>> +        .acpi_match_table    = ACPI_PTR(etm4x_acpi_ids),
>>           .suppress_bind_attrs    = true,
>>           .pm            = &etm4_dev_pm_ops,
>>       },
> 

