Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33575EF0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiI2IyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiI2Ixw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:53:52 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB363139F4E;
        Thu, 29 Sep 2022 01:53:49 -0700 (PDT)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOIVXTVjjrIjAA--.1808S2;
        Thu, 29 Sep 2022 16:53:41 +0800 (CST)
Subject: Re: [PATCH v6 1/3] MAINTAINERS: add maintainer for thermal driver for
 loongson2 SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, zhuyinbo@loongson.cn
References: <20220929071312.29536-1-zhuyinbo@loongson.cn>
 <d6880b08-e370-5fa1-b4f0-a6cc2f13a8f5@linaro.org>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <505d42e3-f069-2bf4-a554-60a4d7e8424f@loongson.cn>
Date:   Thu, 29 Sep 2022 16:53:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d6880b08-e370-5fa1-b4f0-a6cc2f13a8f5@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxBOIVXTVjjrIjAA--.1808S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWUKF1DWryxtw47Zw48tFb_yoWkCwb_CF
        42k3s7Za18AFn7KayvqF9ay3yjgw4kA3WrAas2qwsrX34Uta43AFn5Jwn7uw18Ar4rCFs5
        CFWktr1S9r1aqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbTxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/29 下午3:49, Krzysztof Kozlowski 写道:
> On 29/09/2022 09:13, Yinbo Zhu wrote:
>> Add zhanghongchen and myself as maintainer of the loongson2 SoC
>> series thermal driver.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   MAINTAINERS | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 589517372408..0be0f520c032 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11899,6 +11899,14 @@ F:	drivers/*/*loongarch*
>>   F:	Documentation/loongarch/
>>   F:	Documentation/translations/zh_CN/loongarch/
>>   
>> +LOONGSON2 SOC SERIES THERMAL DRIVER
>> +M:	zhanghongchen <zhanghongchen@loongson.cn>
>> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>> +L:	linux-pm@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> 
> This cannot be a first patch. It is not bisectable and causes (again)
> warnings. Either this should be squashed with last patch (driver change)
> or just be a last patch in the series.
> 
> Best regards,
> Krzysztof
okay, I got it. Thank you for reminding me!

BRs,
Yinbo Zhu.

> 

