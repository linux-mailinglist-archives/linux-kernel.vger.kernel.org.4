Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371AA6A665F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCADOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCADOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:14:09 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C41E288;
        Tue, 28 Feb 2023 19:14:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 45521422CC;
        Wed,  1 Mar 2023 03:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1677640445; bh=UCKwk+pJV4EM3THeVIh/zQc6ljr1BqvcNCGraGweq7c=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=GjC4bTSb3lPoUPg4uFfDbZKKpZI/vbMVn7zFXGm7iET4RGkt1TLl+hrBeLtrR/UMi
         oIC93n48q4HvrUlCxtPovlgb6uLB+Rppplpxxd/3sSwqNJKLom8b5AMxlgb27sW0IV
         j8kFnBUnxzpYPWVGF9Nsl0U68qShbEJJEIrxJwab65s7Lcm0Q61P+Q/lTnUVi6aLcH
         Gg1dPAcWgLUj4MZloE4xzF4rAt352Fyd+LA8YIIu4msXNtREOIuGHw1G3UiTQaYr67
         Wwwc7x9v/McUNhJ8bzs3HQazUwHPRBoXhKtT5ItSUhABDQf5Cl3KJp6l/BJ7eH9ThL
         hiCSVlYsr53QQ==
Message-ID: <c875979d-68f9-6c4e-04ca-af310491b209@marcan.st>
Date:   Wed, 1 Mar 2023 12:13:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     sven@svenpeter.dev, fnkl.kernel@gmail.com, alyssa@rosenzweig.io,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, asahi@lists.linux.dev,
        rydberg@bitmath.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com>
 <87r0ufs574.fsf@bloch.sibelius.xs4all.nl>
 <CAMT+MTQOUd0aSDJ3DPBMfkVwaic=nbRPtfGgu2nduSdCdydcgg@mail.gmail.com>
 <e6c7eb27-1b60-4894-a623-28ca3bccdea5@app.fastmail.com>
 <1874e194-5210-460b-3e8f-0f48962f8a47@marcan.st>
 <87wn41qzpm.fsf@bloch.sibelius.xs4all.nl>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2
 controller bindings.
In-Reply-To: <87wn41qzpm.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 05.53, Mark Kettenis wrote:
>> Date: Tue, 28 Feb 2023 11:58:28 +0900
>> From: Hector Martin <marcan@marcan.st>
>>
>> On 24/02/2023 20.08, Sven Peter wrote:
>>> Hi,
>>>
>>>
>>> On Fri, Feb 24, 2023, at 12:04, Sasha Finkelstein wrote:
>>>> On Fri, 24 Feb 2023 at 11:55, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>>>>
>>>>> What is the motivation for including the firmware name in the device
>>>>> tree rather than constructing it in the driver like what is done for
>>>>> the broadcom wireless?
>>>> There is no way to identify the device subtype before the firmware is
>>>> uploaded, and so i need some way of figuring out which firmware to use.
>>>
>>> Some Broadcom bluetooth boards use the compatible of the root node (see
>>> btbcm_get_board_name in drivers/bluetooth/btbcm.c) which would be "apple,jXXX"
>>> for Apple Silicon. I believe the Broadcom WiFi driver has similar logic as well
>>> which marcan had to extend to instead of "brcm,board-type" because different
>>> WiFi boards can me matched to different Apple Silicon boards. I don't think
>>> that's the case for this touchscreen though.
>>
>> The reason why the brcmfmac stuff needs to construct the firmware name
>> itself is that parts of it come from the OTP contents, so there is no
>> way to know from the bootloader what the right firmware is.
> 
> The name of the "nvram" file is constructed as well, and that uses the
> compatible of the machine (the root of the device tree).  I suppose
> what is special in that case is that several files are tried so a
> single 'firmware-name" property wouldn't cut it.

No, if you look at the way the name is constructed, some of it comes
from OTP. The plain compatible stuff is for non-Apple platforms. Apple
platforms need lookup of nvram/etc per specific fields in the OTP, and
then we try multiple firmware names from most to least specific because
the distinction often isn't relevant (but in some cases it is, and this
even changes from macOS version to macOS version). Our firmware
extractor actually attempts to prune the firmware tree by deduplicating
and promoting the most popular variant up towards the root then pruning
redundant branches, because otherwise we'd end up with hundreds of
copies or links (which is what macOS does, they don't try multiple
firmware filenames).

If the OTP were easily readable from the bootloader I'd just have thrown
this in m1n1 and kept a fixed firmware-name property, but that involves
full PCIe init and power-up of the wlan module and that's way too much
junk to put in there. Hence, dynamically computing firmware names in the
kernel driver.

If it were a simple 1:1 mapping from device tree blob to firmware files,
I would certainly have advocated for "firmware-name" instead of the more
complex thing we do now.

>> That is not the case here, so it makes perfect sense to specify the
>> firmware with `firmware-name` (which is a standard DT property).
> 
> It certainly provides the flexibility to cater for all potential
> nonsense names Apple comes up with for future hardware.

We actually make up the firmware names ourselves in the extractor, so
that's not the reason. But if nothing else I'm pretty sure we already
have n:1 mappings (M2 Pro/Max laptops almost certainly share the same
touchpad firmware for at least the same size chassis models, if not all
4 - haven't looked at that yet though), so using a separate property
means we don't have to play symlink/hardlink games.

> 
>> As for the layout, both bare names and paths are in common use:
>>
>> qcom/sm8450-qrd.dts:    firmware-name = "qcom/sm8450/slpi.mbn";
>> ti/k3-am64-main.dtsi:   firmware-name = "am64-main-r5f0_0-fw";
>>
>> ... but the bare names in particular, judging by some Google searches,
>> are *actually* mapped to bare files in /lib/firmware anyway. So the
>> firmware-name property contains the firmware path in the linux-firmware
>> standard hierarchy, in every case.
> 
> Well, I think the device tree should not be tied to a particular OS
> and therefore not be tied to things like linux-firmware.

That's fine, but we need *some* source of truth, and just like the Linux
kernel tree is the system of record for device tree bindings today, I
don't see a good reason not to use linux-firmware as the defacto
standard for firmware organization. There's nothing OS-specific about,
effectively, a list of identifiers that particular firmwares should be
listed under. Think of it as a "path key => expected firmware blob"
mapping. How each OS implements that is up to the OS.

This is similar to the whole vendorfw mechanism I constructed for these
platforms. Sure, it's based on Linuxisms, but the whole thing is trivial
enough to reimplement on any OS without much trouble (just a
fixed-format CPIO archive in the ESP at a known path).

>> I already did the same thing for the touchpad on M2s (which requires
>> analogous Z2 firmware passed to it, just in a different format):
>>
>> dts/apple/t8112-j413.dts: firmware-name = "apple/tpmtfw-j413.bin";
>>
>> Why is having a directory a problem for OpenBSD? Regardless of how
>> firmware is handled behind the scenes, it seems logical to organize it
>> by vendor somehow. It seems to me that gratuitously diverging from the
>> standard firmware hierarchy is only going to cause trouble for OpenBSD.
>> Obviously it's fine to store it somewhere other than /lib/firmware or
>> use a completely unrelated mechanism other than files, but why does the
>> *organization* of the firmware have to diverge? There can only be one DT
>> binding, so we need to agree on a way of specifying firmwares that works
>> cross-OS, and I don't see why "apple/foo.bin" couldn't be made to work
>> for everyone in some way or another.
> 
> We organize the firmware by driver.  And driver names in *BSD differ
> from Linux since there are different constraints.  The firmware is
> organized by driver because we have separate firmware packages for
> each driver that get installed as-needed by a tool that matches on the
> driver name.

That's fair, but you can still have another level of hierarchy after the
driver, no? Or just throw away that level when you parse the
`firmware-name` if you prefer.

> Rather than have the device tree dictate the layout of the firmware
> files, I think it would be better to have the OS driver prepend the
> directory to match the convention of the OS in question.  This is what
> we typically do in OpenBSD.

The thing is that for better or for worse, some drivers drive devices
with firmware provided by multiple vendors, and then it can still make
sense to split off by vendor. E.g. brcmfmac wifi is already in the
process of diverging into three firmware lineages provided by
two(/three?) vendors, even if you ignore the entire Apple special
snowflake case. I expect pain to come out of that one for everyone
involved... (well, at least for Apple we can always special case
conditionals on "has OTP" which is effectively the "is Apple" flag).
ISTR that radeon/amdgpu also ended up with separate roots, but it's
mixed and with different firmware formats for each and a fallback.

> Now I did indeed forget about the "dockchannel" touchpad firmware that
> I already handle in OpenBSD.  That means I could handle the touchbar
> firmware in the same way.  But that is mostly because these firmwares
> are non-distributable, so we don't have firmware packages for them.
> Instead we rely on the Asahi installer to make the firmware available
> on the EFI partition and the OpenBSD installer to move the firmware in
> place on the root filesystem.
> 
> So this isn't a big issue.

:)

(Do let me know if you have any big issues of course, you know I don't
want to gratuitously make your life hard!)

- Hector
