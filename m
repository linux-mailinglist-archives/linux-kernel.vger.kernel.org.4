Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B4E654249
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiLVOBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbiLVOBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:01:48 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABB226AF2;
        Thu, 22 Dec 2022 06:01:47 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C109480654;
        Thu, 22 Dec 2022 15:01:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671717705;
        bh=YqaNO9kDy3nFfNc/a2RaV0OvzPrs8XfvxLhPTZxI0VQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aILuV8G0LVnhl9CsZCqq8FNrYyCr2x7Hs0Vs5ioyLmaR0iEyIBZ1h38scHWidtDDa
         x21BQnj9MfV0C8q4GCz7y9/rprMLjKtb0q28MJry4Y57y0Xc8yYk636EmayAb3UlV2
         HDegMUTAFoVpoiPy7/XKYY9etcJH1FvS2EnK2NdMrJUeWoboJBiUxZ1YeszoTrf1y6
         Ov79iM1dljOWzniDTE+DZHQiSdWVe2RUfI3zUl8vc5q3cVf1C2cXqeuL0oPDR2kYgj
         GqLhd6Iz/v59Ty777DgVMJJ2+slSkqAAvalF9IJcVBNm4phtpWOtJ+yTr8wh0dio5P
         f5jbfRB4sOcBg==
Message-ID: <3c555cae-999f-ccd2-d114-00b92abd19ba@denx.de>
Date:   Thu, 22 Dec 2022 15:01:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel <kernel@dh-electronics.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz> <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
 <20221130191905.GA2631320-robh@kernel.org>
 <4043d693-7739-4709-8551-9f476031db70@denx.de>
 <38c9aae4-0cae-a5a6-7c76-f23edf259dab@gmail.com>
 <e6b166b399314a91bc97db591c8ec5a7@dh-electronics.com>
 <Y6RgjV4FT57SaTQw@duo.ucw.cz>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <Y6RgjV4FT57SaTQw@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/22 14:50, Pavel Machek wrote:
> Hi!
> 
>>>> This part I understand. What is not clear to me is, why is 'label' being
>>>> un-deprecated.
>>>
>>> It shouldn't be. It seems to be Pavel's ad-hoc decision.
>>
>> Is there a majority agreement that the "label" property remains
>> deprecated?
> 
> 
>> If so, I would say we can mark the label as deprecated.
>>
>> On the other hand, the new generated standardized sysfs name does not seem
>> to provide a full replacement for the "label" property.
>> What is still missing?
> 
> Having reasonable naming of the LEDs is pre-requisite for deprecating
> label property.

As far as I can tell, function and function-enumerator is the reasonable 
naming. Jacek seem to confirm that. I would say, label can be deprecated 
. What is the counter-argument for why it should NOT be deprecated ?
