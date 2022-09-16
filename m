Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5868D5BA9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiIPKFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIPKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:05:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29484D27A;
        Fri, 16 Sep 2022 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663322715; x=1694858715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QJhaJZlzeBsCcRJwzatIAFEHttA8Lak9pZBYRJkQDxI=;
  b=dPLf2y4ZqS7qjGjPG0Me+htKyc0ic8XCYfeEd9Q5AG9F2JILiaifTk/N
   lNYmuL4I9DDK6ThusFW0kocSpV6HQ4QrQ4n1YKFZkuJzdv9o3cTdWjTaQ
   ddu27QZ/+ZYyb8IKkT6ALBTHnNa7I+Hijo9oI218ANI0QZXL5snaX47N2
   N7EhM37G+rtH1M0vK8+k7QWjMZRGZ0Np9Wn4jbi/uYBS6VxPXesj3iEoa
   01GAXWS4fThdawplcgH9jRy/YUfwvSBYcDK7WM+Y04ryXnk7QwKH+Hwb6
   wWfVifyts9hXhWq4mxTkDDKSm99MMO94e5jHTeA4bOXj27lUSUMcyVZfd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="300320723"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="300320723"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 03:05:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="617617827"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56]) ([10.252.61.56])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 03:05:08 -0700
Message-ID: <fe9b9897-ed37-386a-846f-c1f11087ed5c@linux.intel.com>
Date:   Fri, 16 Sep 2022 12:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] soundwire: qcom: update status from device id 1
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com, quic_srivasam@quicinc.com
References: <20220915124215.13703-1-srinivas.kandagatla@linaro.org>
 <3962348a-33b4-5941-4a0b-cb447a513a41@linux.intel.com>
 <bffab27c-6e25-5787-6958-648f9f2e2686@linaro.org>
 <2e1b81d2-e20f-db9f-b84e-b3c5ebb312cb@linux.intel.com>
 <4e42389e-c1c4-fe41-3bc8-03cc9a40ac0b@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <4e42389e-c1c4-fe41-3bc8-03cc9a40ac0b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/22 11:49, Srinivas Kandagatla wrote:
> 
> 
> On 16/09/2022 10:39, Pierre-Louis Bossart wrote:
>>
>>
>> On 9/16/22 11:12, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 15/09/2022 14:10, Pierre-Louis Bossart wrote:
>>>>
>>>>
>>>> On 9/15/22 14:42, Srinivas Kandagatla wrote:
>>>>> By default autoenumeration is enabled on QCom SoundWire controller
>>>>> which means the core should not be dealing with device 0 w.r.t
>>>>> enumeration.
>>>>> Currently device 0 status is also shared with SoundWire core which
>>>>> confuses
>>>>> the core sometimes and we endup adding 0:0:0:0 slave device.
>>>>
>>>> The change looks fine, but the description of the issue is surprising.
>>>
>>> Thanks Pierre,
>>>
>>>>
>>>> Whether autoenumeration is enabled or not is irrelevant, by spec the
>>>> device0 cannot be in ALERT status and throw in-band interrupts to the
>>>> host with this mechanism.
>>>
>>> This issue is more of around enumeration stage in specific during device
>>> status change interrupt from controller. Sharing the device 0 status
>>> with core makes it think that there is a device with 0:0:0:0 address and
>>> it tries to park device to group 13.
>> Still not clear, sorry, see my comment below.
> 
> 
>>
>>>
>>>
>>> --srini
>>>
>>>>
>>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>> ---
>>>>>    drivers/soundwire/qcom.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>>>>> index e21a3306bf01..871e4d8b32c7 100644
>>>>> --- a/drivers/soundwire/qcom.c
>>>>> +++ b/drivers/soundwire/qcom.c
>>>>> @@ -428,7 +428,7 @@ static int
>>>>> qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
>>>>>          ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
>>>>>    -    for (dev_num = 0; dev_num <= SDW_MAX_DEVICES; dev_num++) {
>>>>> +    for (dev_num = 1; dev_num <= SDW_MAX_DEVICES; dev_num++) {
>>>>>            status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
>>>>>              if ((status & SWRM_MCP_SLV_STATUS_MASK) ==
>>>>> SDW_SLAVE_ALERT) {
>>
>> can this really happen?
>>
> I have not see this happening, I had to change this line for consistency
> reasons due to other changes in the patch.
> 
> Only case the issue was seen is during enumeration.
> 
>> Device0 cannot be in alert status, can it? The only this it can do is
>> assert PREQ and set the Device0 status to 1 (ATTACHED). I don't get how
>> a device status could be 2.
>>
>> So even if the status is shared somehow,I don't see how this could be
>> related to parking the device as suggested above. If the condition is
>> always false then changing the loop counter from 0 to 1 would not have
>> an effect?
> 
> The reason why core tries to park this device is because it sees
> status[0] as SDW_SLAVE_ATTACHED and start programming the device id,
> however reading DEVID registers return zeros which does not match to any
> of the slaves in the list and the core attempts to park this device to
> Group 13.

ok, that makes sense, thanks for the explanations.

I would recommend splitting this patch in two then:

1) the change for the handling of the alert status, which is unrelated
to the auto-enumeration. That removes a test for an always-false condition

2) the change for the device status, that indeed is related to enumeration.


> 
> 
> 
> 
> --srini
> 
>>
>>
>>>>> @@ -448,7 +448,7 @@ static void qcom_swrm_get_device_status(struct
>>>>> qcom_swrm_ctrl *ctrl)
>>>>>        ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
>>>>>        ctrl->slave_status = val;
>>>>>    -    for (i = 0; i <= SDW_MAX_DEVICES; i++) {
>>>>> +    for (i = 1; i <= SDW_MAX_DEVICES; i++) {
>>>>>            u32 s;
>>>>>              s = (val >> (i * 2));
