Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F956A518B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjB1C6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjB1C6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:58:46 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2278F2D68;
        Mon, 27 Feb 2023 18:58:36 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 69FD43FA55;
        Tue, 28 Feb 2023 02:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1677553113; bh=VPx/RaRvEWklS2vFmotN6RsQ6+fRmCqm4iwrYL0/7Ys=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=QqD1dDRsk94y7q4iesV9vahaj8NRNo1Y1PQiIsWspg0DNooo/MwSkP7KzoAzuLsV6
         gFcldFmERYjg1kYKWWaxc9J470QbKird/FXZ0235VS4rwAWBLfxURkp+4wdmOCdKJU
         apdESR4gfMtJ3rFxrbK4TRA+GbXxn5b/xO4x13D3OrpNwP7OxNqwnC+8O1oRDShE8P
         KtHkqPiUfJA4GOOD4pLN7GdLXc69zXBgt/+eejZFY5gYN+lQ81WCvV51jydgbIp/fl
         HYzEyHWJMIvY1K1SSyAlutGpqGL2KcAAceoOl7mezLy8UiNLSAzq7F/3y22UivH3zh
         lHlPU6r5Fj6LQ==
Message-ID: <1874e194-5210-460b-3e8f-0f48962f8a47@marcan.st>
Date:   Tue, 28 Feb 2023 11:58:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        asahi@lists.linux.dev, Henrik Rydberg <rydberg@bitmath.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com>
 <87r0ufs574.fsf@bloch.sibelius.xs4all.nl>
 <CAMT+MTQOUd0aSDJ3DPBMfkVwaic=nbRPtfGgu2nduSdCdydcgg@mail.gmail.com>
 <e6c7eb27-1b60-4894-a623-28ca3bccdea5@app.fastmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2
 controller bindings.
In-Reply-To: <e6c7eb27-1b60-4894-a623-28ca3bccdea5@app.fastmail.com>
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

On 24/02/2023 20.08, Sven Peter wrote:
> Hi,
> 
> 
> On Fri, Feb 24, 2023, at 12:04, Sasha Finkelstein wrote:
>> On Fri, 24 Feb 2023 at 11:55, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>>
>>> What is the motivation for including the firmware name in the device
>>> tree rather than constructing it in the driver like what is done for
>>> the broadcom wireless?
>> There is no way to identify the device subtype before the firmware is
>> uploaded, and so i need some way of figuring out which firmware to use.
> 
> Some Broadcom bluetooth boards use the compatible of the root node (see
> btbcm_get_board_name in drivers/bluetooth/btbcm.c) which would be "apple,jXXX"
> for Apple Silicon. I believe the Broadcom WiFi driver has similar logic as well
> which marcan had to extend to instead of "brcm,board-type" because different
> WiFi boards can me matched to different Apple Silicon boards. I don't think
> that's the case for this touchscreen though.

The reason why the brcmfmac stuff needs to construct the firmware name
itself is that parts of it come from the OTP contents, so there is no
way to know from the bootloader what the right firmware is.

That is not the case here, so it makes perfect sense to specify the
firmware with `firmware-name` (which is a standard DT property).

As for the layout, both bare names and paths are in common use:

qcom/sm8450-qrd.dts:    firmware-name = "qcom/sm8450/slpi.mbn";
ti/k3-am64-main.dtsi:   firmware-name = "am64-main-r5f0_0-fw";

... but the bare names in particular, judging by some Google searches,
are *actually* mapped to bare files in /lib/firmware anyway. So the
firmware-name property contains the firmware path in the linux-firmware
standard hierarchy, in every case.

I already did the same thing for the touchpad on M2s (which requires
analogous Z2 firmware passed to it, just in a different format):

dts/apple/t8112-j413.dts: firmware-name = "apple/tpmtfw-j413.bin";

Why is having a directory a problem for OpenBSD? Regardless of how
firmware is handled behind the scenes, it seems logical to organize it
by vendor somehow. It seems to me that gratuitously diverging from the
standard firmware hierarchy is only going to cause trouble for OpenBSD.
Obviously it's fine to store it somewhere other than /lib/firmware or
use a completely unrelated mechanism other than files, but why does the
*organization* of the firmware have to diverge? There can only be one DT
binding, so we need to agree on a way of specifying firmwares that works
cross-OS, and I don't see why "apple/foo.bin" couldn't be made to work
for everyone in some way or another.

- Hector
