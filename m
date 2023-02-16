Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064EA698B38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 04:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBPDcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 22:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBPDcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 22:32:08 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7878528865;
        Wed, 15 Feb 2023 19:32:07 -0800 (PST)
Received: from [192.168.0.31] (bc065635.dsl.pool.telekom.hu [::ffff:188.6.86.53])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006EEE5.0000000063EDA3B3.002C0988; Thu, 16 Feb 2023 04:32:03 +0100
Message-ID: <007239f0-1b13-77b9-0d9c-d68747e20331@irl.hu>
Date:   Thu, 16 Feb 2023 04:32:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm845-oneplus: add
 tri-state-key
Content-Language: en-US, hu
To:     Caleb Connolly <caleb@connolly.tech>, Pavel Machek <pavel@ucw.cz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230209232556.91554-1-soyer@irl.hu>
 <Y+fE7gIMD4BDCffy@duo.ucw.cz>
 <d1959211-bf33-f4fd-01a8-91dcd247aa70@connolly.tech>
From:   Gergo Koteles <soyer@irl.hu>
In-Reply-To: <d1959211-bf33-f4fd-01a8-91dcd247aa70@connolly.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> 
> On 11/02/2023 16:40, Pavel Machek wrote:
>> Hi!
>>
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>>> @@ -52,6 +52,43 @@ key-vol-up {
>>>   		};
>>>   	};
>>>
>>> +	tri-state-key {
>>> +		compatible = "gpio-keys";
>>> +		label = "Tri-state key";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&tri_state_key_default>;
>>> +		state-top {
>>> +			label = "Tri-state key top";
>>
>> "top/middle" is not too useful. Do we need the label at all? If so,
>> should it say "loud/vibrations only/mute"?
> 
> "mute", "vibrate" and "ring" sound good to me.
> 

OnePlus uses the silent/vibrate/ring, iPhone the silent/ring names.
Maybe silent/vibrate/ring are more familiar.

Adding labels can document these modes here.
Should we also document these in input-event-codes.h?
#define ABS_SND_PROFILE		0x22 /* 0 = silent; 1 = vibrate; 2 = ring */


Thanks,
Gergo

> Although it would be nice if users can easily map the physical key
> position to the action when viewing the input device or remapping the
> key in userspace.
> 
> Do you have any ideas or recommendations on how to do this?
>>
>> BR,
>> 								Pavel
> 
> --
> Kind Regards,
> Caleb
> 

