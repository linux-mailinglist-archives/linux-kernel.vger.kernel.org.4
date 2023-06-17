Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F68733F2A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346073AbjFQHZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346044AbjFQHZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:25:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60C582702;
        Sat, 17 Jun 2023 00:25:14 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Dxh+nYX41klz4GAA--.11400S3;
        Sat, 17 Jun 2023 15:25:12 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxGOXYX41k5wseAA--.19685S3;
        Sat, 17 Jun 2023 15:25:12 +0800 (CST)
Subject: Re: [PATCH v14 1/2] thermal: loongson-2: add thermal management
 support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        zhanghongchen <zhanghongchen@loongson.cn>, zhuyinbo@loongson.cn
References: <20230426062018.19755-1-zhuyinbo@loongson.cn>
 <af4d1e00-76d6-b71a-2ed1-562e6405306b@linaro.org>
 <bc081559-e6f5-7ac8-7ae1-3cfbbee51697@loongson.cn>
 <dd3cc9db-bb60-8dfd-19b7-afeeedb65177@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <dc4c03bb-9353-fd0a-03f3-8ab147424f65@loongson.cn>
Date:   Sat, 17 Jun 2023 15:25:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dd3cc9db-bb60-8dfd-19b7-afeeedb65177@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxGOXYX41k5wseAA--.19685S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/17 下午3:15, Daniel Lezcano 写道:
> On 17/06/2023 05:25, zhuyinbo wrote:
>>
>> Hi Daniel,
>>
>> 在 2023/6/12 下午10:22, Daniel Lezcano 写道:
>>
>> ...
>>
>>>>
>>>> +#define LOONGSON2_SOC_MAX_SENSOR_NUM            4
>>>> +
>>>> +#define LOONGSON2_TSENSOR_CTRL_HI            0x0
>>>> +#define LOONGSON2_TSENSOR_CTRL_LO            0x8
>>>> +#define LOONGSON2_TSENSOR_STATUS            0x10
>>>> +#define LOONGSON2_TSENSOR_OUT                0x14
>>>
>>> Please use BIT() macros
>>
>>
>> I learn about that BIT() is generally used to describe the functional
>> bit or control bit or status bits of a register, but these register was
>> some different register offset and not some control bit or status bit
>> So using BIT() here seems a bit inappropriate, Do you think so?
> 
> Yes, you are right


okay, I got it.

Thanks,
Yinbo

