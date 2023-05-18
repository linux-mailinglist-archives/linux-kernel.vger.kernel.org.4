Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F50708145
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjERM3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjERM3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:29:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CA510CF;
        Thu, 18 May 2023 05:29:09 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QMTjJ3r0qzLppC;
        Thu, 18 May 2023 20:26:12 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 20:29:05 +0800
Message-ID: <f013d4c6-afbe-ebc8-cb2d-1a12b55cc1d4@huawei.com>
Date:   Thu, 18 May 2023 20:29:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] soc: hisilicon: Support HCCS driver on Kunpeng SoC
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <wanghuiqiang@huawei.com>, <tanxiaofei@huawei.com>,
        <liuyonglong@huawei.com>, <huangdaode@huawei.com>,
        <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230515130807.pdvx7bxwjkfdsmsr@bogus>
 <aa5b1919-74c6-1f97-78af-ab5f0904c3ce@huawei.com>
 <20230516122931.il4ai7fyxdo5gsff@bogus>
 <f0733521-2557-fdaf-e59b-b10d515c487c@huawei.com>
 <20230516143530.venhj4gax6stinah@bogus>
 <a98e3620-57da-000e-f5ee-2c2e47e97906@huawei.com>
 <20230517093033.4jvwjxuoeic46a24@bogus>
 <5ca49494-5a0c-4dc8-9cf5-fc4bc3b8e1b2@huawei.com>
 <20230517131614.cwi2fcj2cngaq7dm@bogus>
 <aec13381-e9be-4f3d-1834-52f32f9f8418@huawei.com>
 <20230518083841.nqmjvqqxnea6qrbe@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230518083841.nqmjvqqxnea6qrbe@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/18 16:38, Sudeep Holla 写道:
> On Thu, May 18, 2023 at 04:24:36PM +0800, lihuisong (C) wrote:
>> 在 2023/5/17 21:16, Sudeep Holla 写道:
>>> On Wed, May 17, 2023 at 07:35:25PM +0800, lihuisong (C) wrote:
>>>> 在 2023/5/17 17:30, Sudeep Holla 写道:
>>>>> On Wed, May 17, 2023 at 03:16:12PM +0800, lihuisong (C) wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>> No. I want to use this flag to make compability between different platforms.
>>>>>> This driver only use PCC OpRegion to access to the channel if platform
>>>>>> support use PCC OpRegion.
>>>>> What do you mean by that ? It is not correct. If there is a PCC Opregion,
>>>>> then you need to make it work with drivers/acpi/acpi_pcc.c
>>>>>
>>>>> You need to have all the other details in the firmware(ASL). By looking
>>>>> at the driver, it has no connection to PCC Opregion IMO unless I am missing
>>>>> something.
>>>> Driver just needs to call these APIs, such as acpi_evaluate_integer(), if
>>>> want to use PCC OpRegion.
>>> OK, please provide examples. I am definitely lost as it doesn't match with
>>> my understanding of how PCC Opregions are/can be used.
>>>
>>>> I know that. I have tested PCC OpRegion before.
>>> Cool, examples please.
>>>
>>>> You've completely misunderstood what I said.😅
>>>>
>>> Hmm, may be but I need examples.
>> As you said below, the driver works just for PCC not PCC Opregion for now.
>> not sure if we need to discuss how PCC Opregion is used here.
> Good let us drop the idea of using PCC Opregion with this driver for now.
>
>>>> I mean that this driver plans to support both PCC and PCC OpRegion.
>>>> For example,
>>>> Platform A: this driver use PCC (as the current implementation)
>>> Good, then just keep what it needs in the implementation nothing more
>>> until you add support for something you have described below(not that
>>> I agree, just want you to make progress here based on what is actually
>>> required today)
>> Agreed.
>>>> Platform B: this driver use PCC OpRegion (Currently, this patch does not
>>>> implement it, but it may be available in the future.)
>>> Then let us discuss that in the future, don't add unnecessary complexity
>>> for some future use case today. You can always add it when you introduce
>>> that feature or support in the future.
>> Yes. We just need to focus on the current.
>> If there are any usage problems with PCC OpRegion in the future, we can
>> discuss that later.
>>
> Agreed.
>
>> My original full scheme is as follows:
>> -->
>> dev_flags = get_device_flags();  // to know if use PCC OpRegion
>> if (USE_PCC_OPREGION_B in dev_flags is 0) {
>>      chan_id = get_pcc_chan_id();
>>      init_mbox_client();
>>      pcc_mbox_request_channel(cl, chan_id)
>> } else {
>>      /* we need to return unsupport now because of no this feature in this
>> driver. */
>>      do_nothing();
>> }
>>
>> void get_some_info(...) {
>>      if (USE_PCC_OPREGION_B in dev_flags is 0)
>>          pcc_cmd_send();  // use PCC to communicate with Platform
>>      else
>>          acpi_evaluate_object(); // will be used in future.
>> }
>>
>> As described in the pseudocode above,
>> it is necessary to put "dev_flags" in this current driver first in case of
>> the version driver runs on the platform which just use PCC Opregion.
> No, you can't randomly define dev_flags just to assist your driver
> implementation. If you need it, you need to get the spec updated. We
> will not add anything unless that happens.
>
> Note that I don't agree with the flags at all but if you convince and get
> them added to spec, I won't object.
Ok，let us drop it.
>>>> Note:
>>>> This driver selects only one of them (PCC and PCC OpRegion) to communicate
>>>> with firmware on one platform.
>>> Let us keep it simple(KISS). The driver works just for PCC not PCC Opregion
>>> for now.
>> ok.
> Good
>
>>>> We use one bit in device-flags to know which one this driver will use.
>>>>
>>> NACK again just to re-iterate my point if you have not yet accepted that
>>> fact.
>> Above is our plan. Do you still think we shouldn't add this device-flags?
>> please let me know.
> Correct, no device flags as I see no use for it with your PCC only use case
> for now, right ?
Yes, it can still work well.
As for PCC Opregion way on other platform, I think of other way.
>
>>>> I'm not sure if you can understand what I mean by saing that.
>>>> If you're not confused about this now, can you reply to my last email
>>>> again?😁
>>>>
>>> The example you had IIRC is use of System Memory Opregion to demonstrate
>>> some _DSM. That has nothing to do with PCC Opregion.
>> Yes, it doesn't matter.
>> I just want to have a way to get device-flags which contains many bits(every
>> bits can be used to as one feature for expanding), rigtht?
> Get it through the spec, we don't allow random additions for some
> implementations like this.
Get it.
>>> Commit 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for
>>> the PCC Type 3 subtype") has the example in the commit message. IIRC,
>> Your example is very useful to the user.
>>> you have even fixed couple of bugs in that driver. That is the reason
>>> why I don't understand how you think this driver and that can or must
>> Understand you, Sudeep.
>> At that time, I tested it by a simple demo driver on the platform supported
>> type3.
>>
> OK
>
>> This driver will support multiple platforms.
>> On some platforms, we can only use PCC with polling way.
>> And we will add PCC Opregion way for others platforms.
> Again when you do please post the patch with the ASL snippet as I am
> very much interested in understanding how you would make that work.
All right.
>
>> What's more, every platform just use one of them(PCC and PCC Opregion).
> OK
>
>>> work together. At least I fail to see how ATM(examples please, by that
>>> I mean ASL snippet for PCC vs PCC Opregion usage to work with this driver)
>> ok!
>> For PCC, ASL snippet is little.
>> I will add ASL snippet when this driver addes PCC Opregion way.
>
> Sounds like a plan to make progress at-least for now.
>
