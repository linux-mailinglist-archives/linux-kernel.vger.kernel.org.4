Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140E5610937
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 06:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJ1EMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 00:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ1EM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 00:12:27 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7E010EA17;
        Thu, 27 Oct 2022 21:12:24 -0700 (PDT)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 400C8FA;
        Thu, 27 Oct 2022 21:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1666930344;
        bh=dKSznSQzRP+QlIAygny9pcwjmOkZrx6+cUvIow2CZxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VThKMQWhZix0AYTvfE5WNjtNwZkVKf3QFlRZnS7xT7UDK9Ly2cjo4kO4UL861zcuZ
         qZa1i9H6G4/1Kz5wcdRMtt963KHe51Zm8XsUSApjmManA7L/BIfA9evdXGXjxX6nx0
         rvy/8uYOWO/f3omIOBD+D3Vrob6ofQeU8Ne847SI=
Date:   Thu, 27 Oct 2022 21:12:22 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add regulator-output bindingg
Message-ID: <Y1tWpikPogEtV0+x@hatter.bewilderbeest.net>
References: <20220925220319.12572-1-zev@bewilderbeest.net>
 <20220925220319.12572-3-zev@bewilderbeest.net>
 <20220929210714.GA2684335-robh@kernel.org>
 <YzYNt+IQRomycRLs@hatter.bewilderbeest.net>
 <Y1rRCq9Kdd2zPPkw@hatter.bewilderbeest.net>
 <ee37b5a1-5afc-71b3-f777-add295d9ce17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ee37b5a1-5afc-71b3-f777-add295d9ce17@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 06:22:10PM PDT, Krzysztof Kozlowski wrote:
>On 27/10/2022 14:42, Zev Weiss wrote:
>> On Thu, Sep 29, 2022 at 02:27:20PM PDT, Zev Weiss wrote:
>>> On Thu, Sep 29, 2022 at 02:07:14PM PDT, Rob Herring wrote:
>>>> On Sun, Sep 25, 2022 at 03:03:18PM -0700, Zev Weiss wrote:
>>>>> This describes a power output supplied by a regulator, such as a
>>>>> power outlet on a power distribution unit (PDU).
>>>>>
>>>>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>>>> ---
>>>>> .../bindings/regulator/regulator-output.yaml  | 47 +++++++++++++++++++
>>>>> 1 file changed, 47 insertions(+)
>>>>> create mode 100644 Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..40953ec48e9e
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>>> @@ -0,0 +1,47 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +
>>>>> +$id: http://devicetree.org/schemas/regulator/regulator-output.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Regulator output connector
>>>>> +
>>>>> +maintainers:
>>>>> +  - Zev Weiss <zev@bewilderbeest.net>
>>>>> +
>>>>> +description: |
>>>>> +  This describes a power output connector supplied by a regulator,
>>>>> +  such as a power outlet on a power distribution unit (PDU).  The
>>>>> +  connector may be standalone or merely one channel or set of pins
>>>>> +  within a ganged physical connector carrying multiple independent
>>>>> +  power outputs.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: regulator-output
>>>>> +
>>>>> +  vout-supply:
>>>>> +    description:
>>>>> +      Phandle of the regulator supplying the output.
>>>>> +
>>>>> +  regulator-leave-on:
>>>>> +    description: |
>>>>> +      If the regulator is enabled when software relinquishes control
>>>>> +      of it (such as when shutting down) it should be left enabled
>>>>> +      instead of being turned off.
>>>>> +    type: boolean
>>>>
>>>> I'm not too sure about this one as there could be various times when
>>>> control is relinquished. It is userspace closing its access?
>>>> driver unbind? module unload? Does a bootloader pay attention to this?
>>>>
>>>> Rob
>>>
>>> Thanks for the feedback, Rob -- I'll admit I was a bit unsure how to
>>> approach that, and this may well not be the right answer.  What I'm
>>> really aiming for is an appropriate way to express that regulator
>>> on/off state should only ever be changed by explicit (external, e.g.
>>> userspace) request, never as any sort of default/automatic action.
>>> The two obvious things to guard against there seem to be automatic
>>> enablement during initialization and automatic disablement on de-init
>>> (shutdown, unbind, etc.).  The former I think can be avoided by simply
>>> not setting regulator-boot-on, so I added this as a corresponding
>>> property to avoid the latter.
>>>
>>> I'm definitely open to suggestions for a better approach though.
>>>
>>
>> Ping...
>>
>> Would something like this be preferable as a more direct description of
>> that?
>>
>>    regulator-manually-controlled:
>>      description: |
>>        The regulator should never be enabled or disabled automatically,
>>        only when explicitly requested by an external actor (e.g.
>>        userspace).
>>      type: boolean
>
>This looks like putting policy and OS behavior into DT.

I can see why it might look that way, but I'd argue it's actually not.  
The systems this is intended to support provide power to entirely 
separate external devices -- think of a power distribution unit that 
might have arbitrary things plugged into it.  It seems to me like a 
property of the hardware that those things shouldn't have their power 
supply turned off (or on) just because a controller in the PDU rebooted.

>I guess it easy
>to understand in case of Linux which disables unclaimed regulators
>during. But what if other system/firmware does not behave like that?
>

In this case, then no change would be needed -- a system that (unlike 
Linux) doesn't twiddle regulator state on its own would just continue to 
not do that.

>And what is the "external actor"? OS is not an external actor?

It's admittedly a bit vague, but I couldn't think of a clearer way to 
express what is a sort of nebulous concept -- essentially, some entity 
outside the "driver" (or analogous software component) using the 
information in the device-tree.  In many common cases this would 
essentially mean "a human user", since in the PDU-like systems I'm 
targeting here the only thing that should ever be deciding to turn the 
regulator on or off is an operator logged in to the system to manually 
enable or disable an outlet.  I was aiming to leave the wording a bit 
more general though, since in some other context I could imagine some 
other piece of software toggling things automatedly (e.g. lights getting 
turned on and off on a schedule or something, if that's what happens to 
be plugged in).

>
>I could not get the problem you want to solve with this property - I
>looked at cover letter and at commit msg.
>

The problem is that a driver deciding on its own to enable or disable 
the regulator (e.g. during boot or shutdown) would be a critical failure 
for the kind of systems I'm aiming to support.

>I can only imagine that you want to keep regulator on, after last its
>user disappears... but for what purpose? Do you expect that after system
>shutdown the pin will stay high so regulator will be also on? If so, you
>need hardware design, e.g. with some pull up (if control is over GPIO).
>

As described above, the regulators involved here (in these sorts of 
PDU-like systems) provide power for external systems and devices.  It is 
critical that the controller's boot and shutdown sequences not alter the 
state of the regulator.

If some additional concrete details would help clarify, the particular 
system I'm working on at the moment is the Delta Power AHE-50DC [0].  It 
has two redundant BMCs controlling 50 power outputs, each of which is 
managed by an LM25066 [1] attached to the controllers via I2C.  The 
LM25066s maintain their power state independently of the controllers 
booting or shutting down, and it's very important that if one controller 
reboots (for a firmware update, say) that it not send I2C commands to 
all the LM25066s telling them to turn off their outputs.

[0] https://www.open19.org/marketplace/delta-16kw-power-shelf/
[1] https://www.ti.com/lit/ds/symlink/lm25066.pdf


Thanks,
Zev

