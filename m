Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0175A60281D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiJRJSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiJRJSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:18:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58DDBAA347
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:18:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 527F0113E;
        Tue, 18 Oct 2022 02:18:17 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E80D3F7D8;
        Tue, 18 Oct 2022 02:18:10 -0700 (PDT)
Message-ID: <9fc5ab20-c7f0-a917-4938-403e3661109f@arm.com>
Date:   Tue, 18 Oct 2022 10:18:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Question] Question about supporting sysreg only CoreSight
 ETMv4.4 on ACPI machines
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     yehaiyang2@hisilicon.com, wanghuiqiang <wanghuiqiang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>
References: <6e85db13-a65f-d4c6-1b6b-660a94cb7060@huawei.com>
Content-Language: en-US
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
In-Reply-To: <6e85db13-a65f-d4c6-1b6b-660a94cb7060@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Cc: Anshuman

On 18/10/2022 03:04, Xiongfeng Wang wrote:
> Hi, Suzuki
> 
>     We are testing CoreSight ETMv4.4 and TRBE recently. ETMv4.4 obsoletes memory
> mapped access to ETM and mandates the system registers. The following commit add
> driver for sysreg only devices, but it only support device tree.
>    commit 5214b563588e8414193bd7a174c52350256942a6
>    coresight: etm4x: Add support for sysreg only devices
> 
> ACPI machine can use 'ARMHC500' to report a ETM4x device. But the corresponding
> driver is etm4x_amba_driver. It needs memory resouces and doesn't support sysreg
> only device.

That is true. Unfortunately, supporting this requires us to move away 
from the AMBA framework (at least) for ETM4x devices. This is currently
developed by Anshuman. We can share it as soon as this is complete.

Thanks
Suzuki

> 
> Do we have some other way to use CoreSight ETMv4.4 on ACPI machines. Thanks a lot.
> 
> Thanks,
> Xiongfeng

