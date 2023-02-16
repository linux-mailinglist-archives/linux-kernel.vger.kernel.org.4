Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25CB698A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBPCXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBPCXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:23:05 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584E431E1E;
        Wed, 15 Feb 2023 18:23:04 -0800 (PST)
Received: from [192.168.0.31] (bc065635.dsl.pool.telekom.hu [::ffff:188.6.86.53])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006E9F7.0000000063ED9384.002C0889; Thu, 16 Feb 2023 03:23:00 +0100
Message-ID: <952d1e7c-8f46-086a-8e14-fa225c6f5844@irl.hu>
Date:   Thu, 16 Feb 2023 03:22:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/3] Input: add ABS_SND_PROFILE
Content-Language: en-US, hu
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>
References: <20230209232539.91500-1-soyer@irl.hu>
 <Y+fCvaGTkddwNGP6@duo.ucw.cz>
From:   Gergo Koteles <soyer@irl.hu>
In-Reply-To: <Y+fCvaGTkddwNGP6@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,
> Hi!
> 
>> ABS_SND_PROFILE used to describe the state of a multi-value sound profile
>> switch. This will be used for the tri-state key on OnePlus phones or other
>> phones.
> 
> Looks like ABS_PROFILE would be fine to use there, no need to create
> new one, no?
> 

ABS_PROFILE used by some Xbox game controllers to switch controller 
profiles. In the future, it's imaginable to play games in a linux mobile 
with the controllers. If we don't want to know in userspace where the 
event comes from, I think ABS_SND_PROFILE would be better.

Thanks,
Gergo

> Best regards,
> 								Pavel
> 
>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>> ---
>>   Documentation/input/event-codes.rst    | 6 ++++++
>>   drivers/hid/hid-debug.c                | 1 +
>>   include/uapi/linux/input-event-codes.h | 1 +
>>   3 files changed, 8 insertions(+)
>>
>> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
>> index b4557462edd7..d43336e64d6a 100644
>> --- a/Documentation/input/event-codes.rst
>> +++ b/Documentation/input/event-codes.rst
>> @@ -241,6 +241,12 @@ A few EV_ABS codes have special meanings:
>>       emitted only when the selected profile changes, indicating the newly
>>       selected profile value.
>>   
>> +* ABS_SND_PROFILE:
>> +
>> +  - Used to describe the state of a multi-value sound profile switch.
>> +    An event is emitted only when the selected profile changes,
>> +    indicating the newly selected profile value.
>> +
>>   * ABS_MT_<name>:
>>   
>>     - Used to describe multitouch input events. Please see
>> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> 

