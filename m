Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F283A6815D8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjA3QBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjA3QBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:01:08 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4934B13529;
        Mon, 30 Jan 2023 08:01:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B6F0C5C024E;
        Mon, 30 Jan 2023 11:01:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 30 Jan 2023 11:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675094466; x=1675180866; bh=jrCNG/L10m
        2bCPDDClIWddYCrrD5yIk/wZPGea4Pa2Q=; b=jutPnCIuWdPjpVJIc+bwacB6YE
        WcJanFNw8fQZuAXSMqtaF5HueN89p3hsoUCn3dt23LevmWPl4ImuvTzgz4F7OLzP
        Yj+K9odJYh5IGUcrfrl8BJe+842BPyn+R4WoX795/FRJkKzQJR87Gii8m85hoy0J
        xAh5sKKV1m3k0VyIKCXGlpCSMxNP1sPJwUxSyh8EFagp6LovC7ZlRCFq+k68W/LO
        OleN7WR66EQvlisrOqJbJHrtYE+Ou6yMhawAPj3ZGpjhG8sf0fvDTsr+vKgZs0ZN
        ht3T8G5Q3IxB/L3EGtgkm8r1/dJ9XbeUcR2lNcaLf3Cx/wqRSJoj2anmxCKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675094466; x=1675180866; bh=jrCNG/L10m2bCPDDClIWddYCrrD5
        yIk/wZPGea4Pa2Q=; b=VGFcZrBXVcEYYVKYaRUlBizWSVowk9cfSpgyKFV+kNau
        qsilNlO4ZIbIq3Rwxyz+32xAs6X90sPClVSAxdT3A5xFaTSYthGXxAIjB1ry7NLL
        5NJmcycNFgFWyTD2CGktMyYAIn9tclYAkafK9R28cJ0cU2tRbj3kvoTU+onGkKkM
        iGSlK2HvZqTYhJxcFsatUUcQxhXis/ZClBRRZchJ+H/65R7SXzWP02taiGTDdg9l
        xYUZxpNuuskK400QxCUePyDMNOSnvFnCagwJLORFHxVKjRfG1VOuI8ak+cIM+6RI
        Fj7NDKSMiSyR2XKU+7SZVpGCuRy0kK9X3OkWSzWI1Q==
X-ME-Sender: <xms:wenXY-pwauXd1tB_i9JyVQFVkxOWc9NZWK5UUTwMBp1mVVnSPxawxw>
    <xme:wenXY8prcptxOxfYZlPnXQD1eVoFacH2aAkE8JH8SN6J--7AufBIrUGfG8vv-2Tow
    mU9h-W-_AJC1w>
X-ME-Received: <xmr:wenXYzO5J37DrmOff9b_jXTkUYpxJRwkXxmPP0_87Pp7LKxqOEdNdMAaKcH1s227p26cpoxoauxBob_zb9M293s4ZAWzk6phucWC-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:wenXY94YNaF11JczY3jWp5GygXE-OZvRlDjnus-N8_fxSWingJmYhA>
    <xmx:wenXY97O3gQmNIW6bS9YJeOBzrKa5YwuXg2NTw4FO9WGRPdMYPx8NA>
    <xmx:wenXY9gkSPrU14psvxDLJNldJ8WG_ZWzoYXeVhc0cXnnjxaqahpWIw>
    <xmx:wunXYw1SPu_WlsnQ420DnZ1HNeIAfIbmieo1KBywKvOOjwjf_qQbnw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jan 2023 11:01:04 -0500 (EST)
Date:   Mon, 30 Jan 2023 17:01:01 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <Y9fpvZCPlqTSvu1O@kroah.com>
References: <20230130152818.03c00ea3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130152818.03c00ea3@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 03:28:18PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> arch/powerpc/platforms/ps3/system-bus.c:472:19: error: initialization of 'int (*)(const struct device *, struct kobj_uevent_env *)' from incompatible pointer type 'int (*)(struct device *, struct kobj_uevent_env *)' [-Werror=incompatible-pointer-types]
>   472 |         .uevent = ps3_system_bus_uevent,
>       |                   ^~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/platforms/ps3/system-bus.c:472:19: note: (near initialization for 'ps3_system_bus_type.uevent')
> arch/powerpc/platforms/pseries/ibmebus.c:436:22: error: initialization of 'int (*)(const struct device *, struct kobj_uevent_env *)' from incompatible pointer type 'int (*)(struct device *, struct kobj_uevent_env *)' [-Werror=incompatible-pointer-types]
>   436 |         .uevent    = ibmebus_bus_modalias,
>       |                      ^~~~~~~~~~~~~~~~~~~~
> arch/powerpc/platforms/pseries/ibmebus.c:436:22: note: (near initialization for 'ibmebus_bus_type.uevent')
> 
> Caused by commit
> 
>   2a81ada32f0e ("driver core: make struct bus_type.uevent() take a const *")
> 
> I have applied the following merge fix patch.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 30 Jan 2023 14:31:49 +1100
> Subject: [PATCH] driver core: fixup for "driver core: make struct bus_type.uevent() take a const *"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/include/asm/ps3.h           | 2 +-
>  arch/powerpc/platforms/ps3/system-bus.c  | 2 +-
>  arch/powerpc/platforms/pseries/ibmebus.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
> index d503dbd7856c..a5f36546a052 100644
> --- a/arch/powerpc/include/asm/ps3.h
> +++ b/arch/powerpc/include/asm/ps3.h
> @@ -396,7 +396,7 @@ static inline struct ps3_system_bus_driver *ps3_drv_to_system_bus_drv(
>  	return container_of(_drv, struct ps3_system_bus_driver, core);
>  }
>  static inline struct ps3_system_bus_device *ps3_dev_to_system_bus_dev(
> -	struct device *_dev)
> +	const struct device *_dev)
>  {
>  	return container_of(_dev, struct ps3_system_bus_device, core);
>  }
> diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
> index 38a7e02295c8..d6b5f5ecd515 100644
> --- a/arch/powerpc/platforms/ps3/system-bus.c
> +++ b/arch/powerpc/platforms/ps3/system-bus.c
> @@ -439,7 +439,7 @@ static void ps3_system_bus_shutdown(struct device *_dev)
>  	dev_dbg(&dev->core, " <- %s:%d\n", __func__, __LINE__);
>  }
>  
> -static int ps3_system_bus_uevent(struct device *_dev, struct kobj_uevent_env *env)
> +static int ps3_system_bus_uevent(const struct device *_dev, struct kobj_uevent_env *env)
>  {
>  	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
>  
> diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
> index 58b798a0e879..bb9c18682783 100644
> --- a/arch/powerpc/platforms/pseries/ibmebus.c
> +++ b/arch/powerpc/platforms/pseries/ibmebus.c
> @@ -426,7 +426,7 @@ static struct attribute *ibmebus_bus_device_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(ibmebus_bus_device);
>  
> -static int ibmebus_bus_modalias(struct device *dev, struct kobj_uevent_env *env)
> +static int ibmebus_bus_modalias(const struct device *dev, struct kobj_uevent_env *env)
>  {
>  	return of_device_uevent_modalias(dev, env);
>  }
> -- 
> 2.35.1
> 

Ick, 0-day didn't catch this, which is odd, it must not build those
arches :(

I'll go queue this up now, thanks for the fix!

greg k-h
