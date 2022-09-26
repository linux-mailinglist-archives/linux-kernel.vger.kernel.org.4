Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1655EA7F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiIZOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiIZOHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:07:55 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51A868E0DB;
        Mon, 26 Sep 2022 05:18:53 -0700 (PDT)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbWt6lzFjEDgiAA--.14903S2;
        Mon, 26 Sep 2022 20:13:52 +0800 (CST)
Subject: xxxxxx
To:     zhuyinbo@loongson.cn
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20220921015605.17078-1-zhuyinbo@loongson.cn>
 <19451295e1563de5e6628e51fa8222b843f55eed.camel@perches.com>
 <58fd6600.c0e4.1837908822e.Coremail.zhuyinbo@loongson.cn>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <911bc990-668d-bd95-0090-3879503b57e1@loongson.cn>
Date:   Mon, 26 Sep 2022 20:13:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <58fd6600.c0e4.1837908822e.Coremail.zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxbWt6lzFjEDgiAA--.14903S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4UWFyUKr45KrWktw1DZFb_yoW8uw4Upa
        17Cay8Cr1kGr18Ca1kKFy3CFn0va48trnrWFnxG3sY9FZIywnxG3WfXFnruay7GFy0gFWj
        grn7WwnFga1Yv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7VUbrOz3UUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/26 下午5:02, Yinbo Zhu 写道:
>
>
>> -----原始邮件-----
>> 发件人: "Joe Perches" <joe@perches.com>
>> 发送时间:2022-09-21 10:06:55 (星期三)
>> 收件人: "Yinbo Zhu" <zhuyinbo@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Amit
>>   Kucheria" <amitk@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
>> 抄送: zhanghongchen <zhanghongchen@loongson.cn>
>> 主题: Re: [PATCH v2 1/3] MAINTAINERS: add maintainer for thermal driver for loongson2 SoCs
>>
>> On Wed, 2022-09-21 at 09:56 +0800, Yinbo Zhu wrote:
>>> Add zhanghongchen and myself as maintainer of the loongson2 SoC
>>> series thermal driver.
>> []
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>> []
>>> @@ -11899,6 +11899,14 @@ F:	drivers/*/*loongarch*
>>>   F:	Documentation/loongarch/
>>>   F:	Documentation/translations/zh_CN/loongarch/
>>>   
>>> +LOONGSON2 SOC SERIES THERMAL DRIVER
>>> +M:	zhanghongchen <zhanghongchen@loongson.cn>
>>> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>>> +L:	linux-pm@vger.kernel.org
>>> +S:	Maintained
>>> +F:	Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>> +F:	drivers/thermal/loongson2_thermal.c
>>> +
>>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>>   M:	Sathya Prakash <sathya.prakash@broadcom.com>
>>>   M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
>>  From the MAINTAINERS headers:
>>
>> 	S: *Status*, one of the following:
>> 	   Supported:	Someone is actually paid to look after this.
>> 	   Maintained:	Someone actually looks after it.
>>
>> If you both are being paid to maintain this driver,
>> this S: entry should be Supported.
> Sorry for replying to you so late, because this email has entered the spam list.
> I with zhanghongchen will focus on thermal driver and looks after it actually.
> so add zhanghongchen with me as loongson2 thermal maintainer.
>
> TKs,
> BRs,
> Yinbo Zhu.

