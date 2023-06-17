Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD726733F24
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbjFQHXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjFQHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:23:42 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE7EE26BE;
        Sat, 17 Jun 2023 00:23:38 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Cx8Oh4X41kbj4GAA--.11327S3;
        Sat, 17 Jun 2023 15:23:36 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxNeR4X41krwseAA--.19496S3;
        Sat, 17 Jun 2023 15:23:36 +0800 (CST)
Subject: Re: [PATCH] thermal/drivers/loongson2: Fix thermal zone private data
 access
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, loongson-kernel@lists.loongnix.cn,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, zhuyinbo@loongson.cn
References: <8ca44091-35fd-cc24-9896-0317772c5620@loongson.cn>
 <20230616143407.689515-1-daniel.lezcano@linaro.org>
 <9c12ece8-3a85-105b-d8d3-208fe816734a@linaro.org>
 <323267b7-3dbc-8982-7f16-08672b19039b@loongson.cn>
 <422def66-911e-9e2b-34a4-f595776f43dd@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <87cca5f5-5b43-ed6f-4c54-d6a583f951ba@loongson.cn>
Date:   Sat, 17 Jun 2023 15:23:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <422def66-911e-9e2b-34a4-f595776f43dd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxNeR4X41krwseAA--.19496S3
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



在 2023/6/17 下午3:12, Daniel Lezcano 写道:
> On 17/06/2023 03:52, zhuyinbo wrote:
>>
>>
>> 在 2023/6/16 下午10:35, Daniel Lezcano 写道:
>>> On 16/06/2023 16:34, Daniel Lezcano wrote:
>>>> The thermal zone device won't be accessible directly anymore.
>>>>
>>>> Use the private data accessor.
>>>
>>> To be folded with your next version
>>>
>>
>>
>> okay, If I understand correctly, I will make this patch as a independent
>> [3/3] patch of the v15 series patch.
> 
> It is better to merge it with your patch 2 in order to prevent a git 
> bisecting error (no need to add a my signoff or whatever)


okay, I got it.

Thanks,
Yinbo
> 

