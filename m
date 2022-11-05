Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4403661DDA9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKETSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKETSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:18:52 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBBDB7FA
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 12:18:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5BD993200312;
        Sat,  5 Nov 2022 15:18:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 05 Nov 2022 15:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1667675929; x=
        1667762329; bh=aegMO/1phxJ2SPeZarRdvuQSVoXGUAPnoXb9Rr6WjT4=; b=L
        iv7Khrc2PJfU5HQ2CVJrP/7YZO0QrB7LTDsjqS3oR9e8gyR0YHe4GMB78/sV6h8K
        mk2HfyqTe6qnockZPsZt+2tC7bnFTTpPf87jl0+NsH2yMV3pNFg6c4Z3O+yvGez/
        /g0JLDKdrFr1TITyEcRkmUax79XWPhYrmx1qbDcVdgo+MuBitvf70WaT0giyzf3z
        XihXANFCQy+AqKLLmdY5b3+dLXyElii0F+R+EJPectgHKaf1Nx1FwtSOLeoZeSTb
        gKZSrY0NmSYEl+55lPOY0f36J/n8RtklE46wZY19eHyekMATgLqg3rTsmTE4HiOD
        RbtO9MEocNf5YyLbkgHUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667675929; x=
        1667762329; bh=aegMO/1phxJ2SPeZarRdvuQSVoXGUAPnoXb9Rr6WjT4=; b=n
        ZUMRZcA2HV3fekLs6D6za35uWTHHI2iRQGXCHYgvzJ2EZH18f7AYfKt1I+llXs43
        3Xam6vQQNBeYGAUb98He16M3U6gG+1beU+RltdumknzZdCtZSNLzxECKFLtLaMcV
        h/tndsgEIluj+T91QJvbrJdwRuWteby425dChyvG/dLNCJEExzqdIhs7Alnjttex
        ZWengxrkI0Z6hu3lEDlU4zmsaE17Kx9qQr/d5cI/VqrdznPfOaproKoTfjq9VdKw
        TwpNRUuDm1/0fr6UoJZeAkNW8H7NwOXYuqYd2BpiZpeS7bSLnCUBE+rCyhdQBwSu
        NgHVSE506a7eqZX0dZ0Lg==
X-ME-Sender: <xms:GbdmY_Z2LQmbXEb4hxMkDAlYat99Bz28sVJSpNuwcmjeJURmLsrfkA>
    <xme:GbdmY-bG-gf7yYyPpm77gr2K3_v4OtbYoNoqyUnXtP8NH77AGW3oVC8SVWUuFvkf2
    7V-toYnaW52Yor-aw>
X-ME-Received: <xmr:GbdmYx-s4XsVtxYiUXsR5l2YfhFPG5qkCsbvLsONMuJnO4OpBgYvVEmIUCnwKJDYD4iW6BZmUmJGWTLYriw6ed-YsGYjYN5bvXddq0WuyWCikLvOubI_YjLj1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeggddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgeeikeeufedvvdeuteeivdeiffdtgfdtfeejgfetfeefgeffgfdv
    ffehjedvueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:GbdmY1qPMVNXfUz6VuiuRC69XchSd2TiOAGwYysjJYgjfKGlSXbyGw>
    <xmx:GbdmY6qpIGIVLyV9_Yt8toLiV4YDSctQGuCY4e35WNlq5fbZssc8ZA>
    <xmx:GbdmY7SV9XV9jr7ytxESdgMhEou4hNfIAF15azbQDGv2z1dz1cPEJQ>
    <xmx:GbdmYzmR1Vgt7pWCRvUQtWbhRFoNfCGQ4_B2ov41s0gex3YsZLGopw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Nov 2022 15:18:48 -0400 (EDT)
Message-ID: <c1e8a25e-3fd0-ba28-67a5-6775c6ce2d6d@sholland.org>
Date:   Sat, 5 Nov 2022 14:18:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     mripard@kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
        wens@csie.org
References: <9f8a0fc3-1d9a-b271-3c26-4f7373b8a3e9@gmail.com>
 <214ed3e0-5959-8fa7-8d66-196e33112cb0@sholland.org>
 <a68b44f5-fd04-4dbe-0782-1d761c42ce3f@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [BISECTED] Allwinner A33 tablet does not fully power off
In-Reply-To: <a68b44f5-fd04-4dbe-0782-1d761c42ce3f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/22 03:23, Ivaylo Dimitrov wrote:
> Hi Samuel,
> 
> On 5.11.22 г. 4:21 ч., Samuel Holland wrote:
>> Hi Ivo,
>>
>> On 10/29/22 10:23, Ivaylo Dimitrov wrote:
>>> After commit 843107498f91e57d1d4b22cd8787112726fdaeb4 (bus: sunxi-rsb:
>>> Implement suspend/resume/shutdown callbacks) Q8 A33 tablet I have here
>>> cannot be powered-on after power-off, it needs press-and-hold of the
>>> power button for 10 seconds (I guess some HW assisted power down
>>> happens) before it can be powered-on again.
>>>
>>> The following patch makes it behave correctly:
>>>
>>> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
>>> index 60b082fe2ed0..30016d62044c 100644
>>> --- a/drivers/bus/sunxi-rsb.c
>>> +++ b/drivers/bus/sunxi-rsb.c
>>> @@ -818,10 +818,7 @@ static int sunxi_rsb_remove(struct platform_device
>>> *pdev)
>>>
>>>   static void sunxi_rsb_shutdown(struct platform_device *pdev)
>>>   {
>>> -       struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
>>> -
>>>          pm_runtime_disable(&pdev->dev);
>>> -       sunxi_rsb_hw_exit(rsb);
>>>   }
>>>
>>>   static const struct dev_pm_ops sunxi_rsb_dev_pm_ops = {
>>>
>>>
>>> I guess the issue comes from the fact that by the time 'power off'
>>> command to the power management IC has to be send, the bus it lives on
>>> is already down, so the device is left in semi-powered down state. Ofc
>>> this is a wild guess, however, preventing the bus being turned off on
>>> shutdown fixes the issue.
>>
>> Your guess is correct. The controller gets shut down in
>>
>>    kernel_power_off()
>>      kernel_shutdown_prepare()
>>        device_shutdown()
>>
>> but the PMIC communication needs to happen later in
>>
>>    kernel_power_off()
>>      machine_power_off()
>>        pm_power_off()
>>
>>> Please LMK if the above is the correct approach so I will send a proper
>>> patch or something else shall be fixed.
>>
>> Yes, this is exactly the right approach. The whole sunxi_rsb_shutdown()
> 
> Don't we need pm_runtime_disable() on shutdown? As IIUC, the controller
> might be suspended and we have to resume it to put it in state to accept
> commands later on(in pm_power_off()).

sunxi_rsb_write() takes care of resuming the controller, so the
controller being suspended prior to pm_power_off() is fine.
pm_runtime_disable() would actually prevent resuming the controller
later in sunxi_rsb_write().

>> function should be removed. When you send a patch, please add a Fixes:
>> tag referencing the commit that you bisected to.

I found a couple of other issues as well, so I'll send out some fixes
with you CC'd.

Regards,
Samuel

