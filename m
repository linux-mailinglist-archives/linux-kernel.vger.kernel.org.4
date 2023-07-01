Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A985744BA1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 00:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjGAWZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 18:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAWZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 18:25:14 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B026F10CE;
        Sat,  1 Jul 2023 15:25:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A38EA3200A84;
        Sat,  1 Jul 2023 18:25:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 01 Jul 2023 18:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688250311; x=1688336711; bh=L5
        h/Ryrtjk3RSUbaAmGHoCMI71Hh6B3GS25Ko06eU7A=; b=l9tacFGlLNUW498NfR
        2HMQMmJCbKpZKi8ZrBBVmmOS1kfbP6UD9QRj0UvRLPfEE1CX5yCZS+95of92s2jt
        EgLsJU54z1zX3QXZZdIA+pAWQs5JOM8P1zB+ZGDf03krk9sukn9NUe6mk1YILu6L
        lzEbal6qkEMCRC+XDhPYKovoKm58+5ss8loOIYbVcBLRvmLLJbaeB9dd9WtLUdaT
        tdU04pNcut2hECqnBLgEic3ayrr4lraloH98SzSqjRIiNp1Ke6BZGP1vOLXpUnkE
        Y3uikCLqSV3gkGBp6jfZzzK9ws4N5dFMbFzS8ZEmhLumbFHVpDgKtWjVTCrAsJrH
        gQyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688250311; x=1688336711; bh=L5h/Ryrtjk3RS
        UbaAmGHoCMI71Hh6B3GS25Ko06eU7A=; b=dqd93ovx5UK1r5i99ilZw9lJnCIIA
        L+tDqCqsQFg1fnK++u17Lo8hOEZFeNAPN3/G51fUDNAEUG+ETs/BXhvZXfOpz1n1
        HO/rf4MlBBT6CJRUYHoNzGHLuF4ln9E/SdGLo4x+tx9FiOFP5uaueZxFI8ldp7A8
        y3h6EIXWQsVHz5+acySCAQ9UH4qf0VussviSzB5APSPHDGjhSOFsW3wY6IW1YO6W
        58TJU5VmfvNH0mjMlv/KFLCe7CRQCjqmV3y6tso2uOYAzyNaFq/HT6vNQa/DFJem
        nbHEoVIlmfv3Vh8RlPs+jClrTH/VI1lZO7lLXBsdXqul531hjmgCyKpSA==
X-ME-Sender: <xms:xqegZF4EXdtptYecUzKdN8BeIQcbgzWQSzXpXrIQtV3a_qoMUGwXSA>
    <xme:xqegZC5sJcuKFKNxurhqOd4jdIRVhpqaN3t6rcEoKZx5Qn5FagKvfD9A20yjomyow
    sRIMb3fknsj-fMt8Vk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdelgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:xqegZMe76LP1KMxgOhIEU7FTSpW7gUOtgxBbz_vmEMWQ19VAK-G98A>
    <xmx:xqegZOIpJKVnx3ex1K_E0pHZpY9m959DqoKy99wh-Tvlxw-lcPGZvA>
    <xmx:xqegZJKloqLtXh5N50gA7rMVQ_dBWML-ktCjO4-km_dJYT6G1mtvVQ>
    <xmx:x6egZC596rrEo0oU1CzyS9GOsWi2oZ3XsOlWXJwzcvzHICJhprDX8g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2B8ECB60086; Sat,  1 Jul 2023 18:25:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <393ca142-5226-4779-a963-c34fb0464c59@app.fastmail.com>
In-Reply-To: <20230701214503.550549-2-javierm@redhat.com>
References: <20230701214503.550549-1-javierm@redhat.com>
 <20230701214503.550549-2-javierm@redhat.com>
Date:   Sun, 02 Jul 2023 00:24:49 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Javier Martinez Canillas" <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, "Helge Deller" <deller@gmx.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 1/2] fbdev: Split frame buffer support in FB and FB_CORE symbols
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 1, 2023, at 23:44, Javier Martinez Canillas wrote:
> Currently the CONFIG_FB option has to be enabled even if no legacy fbdev
> drivers are needed (e.g: only to have support for framebuffer consoles).
>
> The DRM subsystem has a fbdev emulation layer, but depends on CONFIG_FB
> and so it can only be enabled if that dependency is enabled as well.
>
> That means fbdev drivers have to be explicitly disabled if users want to
> enable CONFIG_FB, only to use fbcon and/or the DRM fbdev emulation layer.
>
> This patch introduces a non-visible CONFIG_FB_CORE symbol that could be
> enabled just to have core support needed for CONFIG_DRM_FBDEV_EMULATION,
> allowing CONFIG_FB to be disabled (and automatically disabling all the
> fbdev drivers).
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

I found two more things now:

> 
> +menuconfig FB_CORE
> +	tristate "Core support for frame buffer devices"
> +

This is not actually a hidden option, since you left the prompt
after the 'tristate' keyword. There is also no pointn in having
it as a menu, just use the simpler

config FB_CORE
        tristate

or (as in my other email)

config FB_CORE
       def_tristate FB || (DRM && DRM_FBDEV_EMULATION)


> @@ -44,7 +54,7 @@ menuconfig FB
> 
>  config FIRMWARE_EDID
>  	bool "Enable firmware EDID"
> -	depends on FB
> +	depends on FB_CORE
>  	help
>  	  This enables access to the EDID transferred from the firmware.
>  	  On the i386, this is from the Video BIOS. Enable this if DDC/I2C
> @@ -59,7 +69,7 @@ config FIRMWARE_EDID
> 
>  config FB_DEVICE
>  	bool "Provide legacy /dev/fb* device"
> -	depends on FB
> +	select FB_CORE
>  	default y
>  	help
>  	  Say Y here if you want the legacy /dev/fb* device file and

These are now the only user visible sub-options when CONFIG_FB is
disabled. I missed FIRMWARE_EDID earlier, but this also looks like
it can clearly be left as depending on FB since nothing else calls
fb_firmware_edid. In fact, it looks like all of fbmon.c could be
left out since none of its exported symbols are needed for DRM.

That would leave CONFIG_FB_DEVICE as the only user visible option
for DRM-only configs, which is slightly odd for the menuconfig,
so I still wonder if that could be done differently.

Is there actually a point in configurations for kernels with FB=y,
DRM=n and FB_DEVICE=n? If we don't expect that to be a useful
configuration, an easier way would be to have CONFIG_FB turn it
on implicitly and instead have a user-visible Kconfig option
below CONFIG_DRM_FBDEV_EMULATION that allows controlling the
creation of /dev/fb*.

     Arnd
