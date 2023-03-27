Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421716C9C14
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjC0Hdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjC0Hdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:33:47 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFA1DD;
        Mon, 27 Mar 2023 00:33:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 03DA95C00C4;
        Mon, 27 Mar 2023 03:33:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 27 Mar 2023 03:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679902426; x=1679988826; bh=iZ
        VKGqLoCdEPkISZF4FL4MZSJlV8JzOOF5tIRWsSX9U=; b=mPYBndhPThvDuiK17z
        /1mXZcXux+KIFPjvXauFA676uB7NN3CUEjPTg1wNZLQB/5jezw+AlYB9qFEWsnRT
        DAjcgjPa+tD5imXRWNWkZYuq3oj1cW19BACQmmyjf3o6XO92VYyBottWTmTvvEue
        +hWY8pJtM+mr7Fy5jrS8Xv9N/1+gfYCCKS7wEgtD0d7aG/YC5RJpFhtpJ6wpp5rP
        vNQMSdk3I8FtQoUbCMYjRodAugGoH3o39tjR5Ph/MdDnPVRgBiFoF5UHUbxtUx7V
        M4cXMcUQ+fQ9kJdyqXm8xQF/njZpqusURs21zZakILMfURXxR9pcs7MYtYHzgIc2
        Nxqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679902426; x=1679988826; bh=iZVKGqLoCdEPk
        ISZF4FL4MZSJlV8JzOOF5tIRWsSX9U=; b=gtW9GFt5DOBX+ZxLYEEySiG0QrDAj
        iC+zmPf1faQIdI9q0JK5s6iGJ+wJ161oIXjZnKjcQgJ2rco2GpwQKBGXTrf+ZYLk
        H/ZURlHtGfSP3HnOZ0tVZyIYWZw6gtACKJyRr0hZiTufcaWRO2aHIRPxjqtqODbq
        MGsNgptzzECi45evMU5AYw0zKSTpMogjBWJB/6dkwP+hs1XupiCD8w7TIuB3fJVI
        Qlh2HzhS52RCA//2T6uAjdP8f/g9NKNIsCkSZSjpWu2TyE+ORJxuzLDL6qgmJQ0Z
        6B1k0i6apTwNxR27mN2QuPJ0fc8k/FDdkdRBlaYnh7TeRCYQIBDLEFfLg==
X-ME-Sender: <xms:2UYhZLeW9byx0F3oUEGqNQZukI8qFmLs7SzscFKJeonyGOmt0137zw>
    <xme:2UYhZBOyowSpF3_Xmo3V90wLFOzkGIdiB-a8qpTRwkQ-7iaa6iV_9vGrlikYE3KGZ
    nenSRQJulJx7g>
X-ME-Received: <xmr:2UYhZEg8lKYiCrTNAPAt_e2zwXHIY84DsELxQjkeye00BcWIzXYGhPrZavZ9nfTaf67B2qby0pRBiwf6qTk7aUqIEISjoqUjSVXm_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehuddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelud
    eitdehjeetffdukeeugfekgeeugfelkeeguedvtdelkeetieefueefudeggfenucffohhm
    rghinhepvghllhgvrhhmrghnrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:2UYhZM_GiWJkGu_Q-AGs7KwJr_pHbdzPjXpD0BwBbdVkgpqmx_w9Hw>
    <xmx:2UYhZHtkX8IEJ2gcFQSNa2LGYYUvwxtQLMh7T7Cm4kthx1RtmTH-FA>
    <xmx:2UYhZLHmLkPa6tqHRvDV9pHe8eJFuoZyAIzXufNtcGzjEvIVOKDDpA>
    <xmx:2UYhZAHQYlJr59hSTsR2re345eB_bnyJBQ78z1uof495zjdxRhamNA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 03:33:45 -0400 (EDT)
Date:   Mon, 27 Mar 2023 09:33:42 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <ZCFG1hUpsoB9acpi@kroah.com>
References: <20230327154655.58dd627d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327154655.58dd627d@canb.auug.org.au>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 03:46:55PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build
> (s390-defconfig) failed like this:
> 
> drivers/s390/crypto/ap_bus.c:1596:20: error: initialization of 'ssize_t (*)(const struct bus_type *, char *)' {aka 'long int (*)(const struct bus_type *, char *)'} from incompatible pointer type 'ssize_t (*)(struct bus_type *, char *)' {aka 'long int (*)(struct bus_type *, char *)'} [-Werror=incompatible-pointer-types]
> 
> (reported here: http://kisskb.ellerman.id.au/kisskb/buildresult/14902509/)
> 
> Caused by commit
> 
>   75cff725d956 ("driver core: bus: mark the struct bus_type for sysfs callbacks as constant")
> 
> interacting with commit
> 
>   d7b1813af6a5 ("s390/ap: introduce new AP bus sysfs attribute features")
> 
> from the s390 tree.
> 
> I will apply the following (currently untested) merge fix up patch from
> tomorrow:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 27 Mar 2023 15:42:41 +1100
> Subject: [PATCH] fixup for "driver core: bus: mark the struct bus_type for sysfs callbacks as constant"
> 
> interacting with "s390/ap: introduce new AP bus sysfs attribute features"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/s390/crypto/ap_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index 85bb0de15e76..8d6b9a52bf3c 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -1570,7 +1570,7 @@ static ssize_t bindings_show(const struct bus_type *bus, char *buf)
>  
>  static BUS_ATTR_RO(bindings);
>  
> -static ssize_t features_show(struct bus_type *bus, char *buf)
> +static ssize_t features_show(const struct bus_type *bus, char *buf)

Patch is correct, thank you.

s390 developers, if you have a persistent tag/branch, I can suck this
into the driver core tree and apply this fixup there so that you don't
have to deal with any merge issues for 6.4-rc1 if you want.  Or I can
provide one for you if you need/want that instead.  Or we can just leave
it alone and deal with it during the 6.4-rc1 merge window, your choice.

thanks,

greg k-h
