Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8352654431
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiLVPWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiLVPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:21:54 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AA827DE1;
        Thu, 22 Dec 2022 07:21:52 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id EBE438535C;
        Thu, 22 Dec 2022 16:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671722510;
        bh=PN/hmxooUMT8XNFph9UDv6cR7gQs64H/ILYeISDd/40=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kCRBSw1XtVvx/yWUqBuqNJ1e/hVIMwGa74y4SEHfVhSJYUunzkPSVX65ULcYPfjKZ
         xVu8pWLNhq1eo/1c0HIMf/B8+SSdr8t+py2gz3QqYh1SrlHi/45iBaEHrXwLr+Obns
         DHX3XFSt2xXZ/0OTQnH+ehCwSmK7BsOJc/vF9mK7om9Z794W2RJNsFRTiysBiOKj57
         gxjo1FQwKAjKAco1jcMD56nnHd4+zKEYuFA+vV5XNNW1XBv2Q9ZS1RvZtD1fqzmPwi
         jxdRmszHr0J33rJUU4/5VJbY0hzyAoF22k2mNBBzohjdgz7r+Y32OPNl3cuESrpfDj
         a7g233pJmMsMA==
Message-ID: <cb3c3a1e-ec10-1e7b-1b21-3cb250f92ecf@denx.de>
Date:   Thu, 22 Dec 2022 16:21:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
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
 <Y6RgjV4FT57SaTQw@duo.ucw.cz> <3c555cae-999f-ccd2-d114-00b92abd19ba@denx.de>
 <Y6RwAcXnfY/zjk/b@duo.ucw.cz>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <Y6RwAcXnfY/zjk/b@duo.ucw.cz>
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

On 12/22/22 15:56, Pavel Machek wrote:
> On Thu 2022-12-22 15:01:44, Marek Vasut wrote:
>> On 12/22/22 14:50, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>> This part I understand. What is not clear to me is, why is 'label' being
>>>>>> un-deprecated.
>>>>>
>>>>> It shouldn't be. It seems to be Pavel's ad-hoc decision.
>>>>
>>>> Is there a majority agreement that the "label" property remains
>>>> deprecated?
>>>
>>>
>>>> If so, I would say we can mark the label as deprecated.
>>>>
>>>> On the other hand, the new generated standardized sysfs name does not seem
>>>> to provide a full replacement for the "label" property.
>>>> What is still missing?
>>>
>>> Having reasonable naming of the LEDs is pre-requisite for deprecating
>>> label property.
>>
>> As far as I can tell, function and function-enumerator is the reasonable
>> naming. Jacek seem to confirm that. I would say, label can be deprecated .
>> What is the counter-argument for why it should NOT be deprecated ?
> 
> When the label is no longer neccessary for naming leds, it can be
> deprecated. AFAICT, that is currently not the case.

I'm sorry, this is not a counter-argument, this is hand-waving .

Do you have anything to back your claim that the label is currently 
still needed, contrary to what the DT bindings document claims for 
years? "This property is deprecated - use 'function' and 'color' 
properties instead. function-enumerator has no effect when this property 
is present."

"
commit c5d18dd6b64e09dd6984bda9bdd55160af537a8c
Date:   Sun Jun 9 20:19:04 2019 +0200

     dt-bindings: leds: Add properties for LED name construction

     Introduce dedicated properties for conveying information about
     LED function and color. Mark old "label" property as deprecated.

     Additionally function-enumerator property is being provided
     for the cases when neither function nor color can be used
     for LED differentiation.
"

It seems the function and function-enumerator is very much the 
replacement for label, except standardized. If that's not the case, do 
elaborate. If there is a special case that is not covered by it, do 
point it out.
