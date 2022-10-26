Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B380A60DBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiJZHKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiJZHKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:10:11 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B007C1D3;
        Wed, 26 Oct 2022 00:10:09 -0700 (PDT)
Message-ID: <d75c757b-91af-d8e5-9362-8496afc2a74f@lirui.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666768208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYyjv5sHorlR+bRaGTpE5Ne+PADO5gOacNsgNuB19s0=;
        b=gLsdgQmDJpNSKOIOXx6awv31bwRk8FTPu/qeAQiWwKwQqjMaxndtjkIwBZJSIIuC/XuPmK
        67gGtiYLnw1sFZwjrLX6WfQh9hNMdV2n6f0yqhE/BIIHtPgiFNTjNkOhHikkD0DWbb9iLH
        33YivYz/YaGuLWViuy14mocSV0pgDNtUHgipOO3pA6mCFLp59aNXDz02LCqEGcHkVkXXhi
        PzSlASA0okwrUb/oXExtFwfQPTMtxXOBjT0qde4aZEUWTtsKcegtCTbOFufJkpWnOiLuU/
        zlGLeWnMdiTSiTwHrI4/aqeGq2HiCaM9D0w8hpUGAQlRqsAqZIu+WRhhx1vLAA==
Date:   Wed, 26 Oct 2022 15:09:57 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] docs/zh_CN: Add userspace-api/sysfs-platform_profile
 Chinese translation
Content-Language: en-US
To:     YanTeng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Shi <alexs@kernel.org>
References: <20221025061804.35801-1-me@lirui.org>
 <e75fb7c4-67d8-1e17-8bf4-59e1be87893c@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Rui Li <me@lirui.org>
In-Reply-To: <e75fb7c4-67d8-1e17-8bf4-59e1be87893c@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/26 9:48, YanTeng Si wrote:
>
> 在 2022/10/25 14:18, Rui Li 写道:
>> Translate the following documents into Chinese:
>>
>> - userspace-api/sysfs-platform_profile.rst
>>
>> Signed-off-by: Rui Li <me@lirui.org>
>> ---
>>   .../zh_CN/userspace-api/index.rst             |  2 +-
>>   .../userspace-api/sysfs-platform_profile.rst  | 40 +++++++++++++++++++
>>   2 files changed, 41 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst
>>
>> diff --git a/Documentation/translations/zh_CN/userspace-api/index.rst b/Documentation/translations/zh_CN/userspace-api/index.rst
>> index 6a7e82ac16b9..0f3483a46fa2 100644
>> --- a/Documentation/translations/zh_CN/userspace-api/index.rst
>> +++ b/Documentation/translations/zh_CN/userspace-api/index.rst
>> @@ -26,6 +26,7 @@ Linux 内核用户空间API指南
>>        ebpf/index
>>      no_new_privs
>> +   sysfs-platform_profile
>>     TODOList:
>>   @@ -38,7 +39,6 @@ TODOList:
>>   * iommu
>>   * media/index
>>   * netlink/index
>> -* sysfs-platform_profile
>>   * vduse
>>   * futex2
>>   diff --git a/Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst b/Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst
>> new file mode 100644
>> index 000000000000..6e861f911424
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst
>> @@ -0,0 +1,40 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/userspace-api/sysfs-platform_profile.rst
>> +
>> +:翻译:
>> +
>> + 李睿 Rui Li <me@lirui.org>
>> +
>> +==========================================================
>> +平台配置文件选择（如 /sys/firmware/acpi/platform_profile）
>> +==========================================================
>> +
>> +现代系统中平台性能、温度、风扇和其他硬件相关的特性通常是可以动态配置的。平台
>> +配置通常会根据当前的状态由一些自动机制（很可能存在于内核之外）来自动调整。
>> +
>> +这些平台自动调整机制通常能够被配置成多个平台配置文件中的一个，要么偏向低功率
>> +工作，要么偏向性能。
> How about 其要么偏向节能运行，要么偏向性能运行？
>> +
>> +platform_profile属性的目的是提供一个通用的sysfs API来选择这些平台自动配置
>> +机制的配置文件。
>> +
>> +需要注意的是，这个API只能用作选择平台配置文件。其目的并不是为了监测改变所致
>> +的性能特征。监测性能最好使用设备/供应商提供的工具，比如turbostat。
>
> Original: it is NOT a goal of this API to allow monitoring the resulting performance characteristics.
>
>
> Here maybe the translation could be improved
>
>> +
>> +具体来说，当选择高性能配置文件时，真实能达到的性能可能受制于多种因素，比如：
>> +其他组件的发热，房间温度，笔记本底部的自由空气流动等。这个API的目的明显不是让
>> +用户空间知道任何阻碍达到要求性能等级的欠佳条件。
> Hmmm, how about 让用户空间知道任何阻碍达到要求的性能水平的局部最优条件，显然不是这个API的目标?
>> +
>> +由于数字本身并不能代表一个配置文件会调整的多个变量（功耗，发热等），这个API使
>> +用字符串来描述多种配置文件。为了保证用户空间能够获得一致的体验，
>> +sysfs-platform_profile ABI 文档定义了一个固定的配置文件名集合。驱动程序
>> +*必须* 将它们内置的配置文件表示映射到这个固定的集合中。
>> +
>> +如果映射时没有很好的匹配，可以添加一个新的配置文件名称。驱动希望引入的新配置文
>> +件名称时必须：
>> +
>> + 1. 解释为什么无法使用已有的配置文件名称。
>> + 2. 添加一个新的配置文件名称，以及预期行为的清晰描述，保存到
>> +    sysfs-platform_profile ABI文档中。
>
>
> Thanks,
>
> Yanteng
>
Thanks, Yanteng! I will improve these translation in version 2. :)

-- 
Rui Li    0x77E6D821D7AE84FE

