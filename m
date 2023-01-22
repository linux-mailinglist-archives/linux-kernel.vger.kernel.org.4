Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F426770CF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjAVQxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjAVQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:53:35 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D3A196B7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 08:53:34 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id i70so4657540ioa.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 08:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eOOpS877RbdMk9+2ubqEo2V/9WGV2dh88ER6QWnCNlg=;
        b=cnc5Qs0w/DIvnCz8gTNZxM6X57omamoi955rvAG3CtFtJeX2cT+dnvqkN+7Xus2Q4c
         s2qxzQO46fr1gA+uRdQSA13CzzgxLJ0a7YEQ3r7wvURAVb2KoHmW3IFupl+9fvSCirlI
         Jq8HMZHvBq4lvD+1LNhXqcyZvcvn3+rHfDy12EoXfsijMtND/rVR0UEeVBxICFWeareC
         UWDzRwYbSOP9VV6Y/bCmFXUv8izM3d6/Coxh9S4RzOgHkhvyfdGerdXkdDYkTh0WKxYF
         q6XRrslKWZ1mHkUYFtl4b140S23dcsGcg9ytcn1uVUBP4GMlnWhCTs+K0mUbdAU10BM4
         k6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOOpS877RbdMk9+2ubqEo2V/9WGV2dh88ER6QWnCNlg=;
        b=55B1RoVoD9Zk/a0bRn53yPTYqyRPKONomlGpDDqPeqYMRUoBswVrfN/YGgkpJ+4o08
         b+sqJJNPjHdEcmAJqwzhZYQFkN1UIAhxndILvR5iDZfnrrEa0Ksio+xikVEM1O+Lw0VB
         yDge2Z+ZkGT95Un7C+a9B+htuYEIDklzR9sEROphpNPROJ3z/+4lV0tLFTwC0OewLmFA
         aWJF/r9lizJ8SCIw8w5q5GRt/TXVRuj2C1t7ekgsVQYq5sd2sHYNZyRimfgGbebiBuKP
         mgxVDqETz0eKS52KVHxGUg+754lQXDjBLjhp8VLgPT0ZvF7L/VzhwJMi8OnvC1uPLyGk
         RgTQ==
X-Gm-Message-State: AFqh2kqhulL0sZHnwZwiq3foCXyVoMJW0ebpnGOzRgx6mwWiXBLq8FD+
        KwuPKjaN3fwYv39yFPYND+k=
X-Google-Smtp-Source: AMrXdXvjVsBryuY5uffw2HQNjOTKrgAe5dY1Ufl78re2BxE1nBEkaqrToGy6dA7Qx+mrhm/aXVP46w==
X-Received: by 2002:a6b:f012:0:b0:704:5d40:dfbf with SMTP id w18-20020a6bf012000000b007045d40dfbfmr15589897ioc.1.1674406413503;
        Sun, 22 Jan 2023 08:53:33 -0800 (PST)
Received: from [192.168.75.211] ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id y13-20020a056638228d00b003a0565a5750sm9829265jas.119.2023.01.22.08.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 08:53:33 -0800 (PST)
Message-ID: <3b323793-2e98-216c-d84f-97187feb4b72@gmail.com>
Date:   Sun, 22 Jan 2023 10:53:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add quirks for One XPlayer
 handheld variants
Content-Language: en-US
To:     maarten.lankhorst@linux.intel.com
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221213171044.14869-1-ruinairas1992@gmail.com>
From:   Matthew Anderson <ruinairas1992@gmail.com>
In-Reply-To: <20221213171044.14869-1-ruinairas1992@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm just following up to see where things are standing for this patch. 
I've seen other orientation patches make it's way to the kernel and am 
wondering if there is something I need to do on my end.

On 12/13/22 11:10 AM, Matthew Anderson wrote:
> We have more handhelds in the One XPLAYER lineup now that needs support added to the orientation-quirks.
> By adding more native resolution checks and the one unique BIOS variant available we add support to most devices.
>
> Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
> ---
>   .../gpu/drm/drm_panel_orientation_quirks.c    | 30 +++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 52d8800a8ab8..335d636e6696 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -103,6 +103,12 @@ static const struct drm_dmi_panel_orientation_data lcd800x1280_rightside_up = {
>   	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
>   };
>   
> +static const struct drm_dmi_panel_orientation_data lcd800x1280_leftside_up = {
> +	.width = 800,
> +	.height = 1280,
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
> +};
> +
>   static const struct drm_dmi_panel_orientation_data lcd1080x1920_leftside_up = {
>   	.width = 1080,
>   	.height = 1920,
> @@ -115,6 +121,12 @@ static const struct drm_dmi_panel_orientation_data lcd1200x1920_rightside_up = {
>   	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
>   };
>   
> +static const struct drm_dmi_panel_orientation_data lcd1200x1920_leftside_up = {
> +	.width = 1200,
> +	.height = 1920,
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
> +};
> +
>   static const struct drm_dmi_panel_orientation_data lcd1280x1920_rightside_up = {
>   	.width = 1280,
>   	.height = 1920,
> @@ -344,6 +356,24 @@ static const struct dmi_system_id orientation_data[] = {
>   		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
>   		},
>   		.driver_data = (void *)&lcd1600x2560_leftside_up,
> +	}, {	/* OneXPlayer Mini 800p */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK TECHNOLOGY CO., LTD."),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
> +		},
> +		.driver_data = (void *)&lcd800x1280_leftside_up,
> +	}, {	/* OneXPlayer Mini 1200p */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK TECHNOLOGY CO., LTD."),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
> +		},
> +		.driver_data = (void *)&lcd1200x1920_leftside_up,
> +	}, {	/* OneXPlayer Mini A07 Bios Variant */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER mini A07"),
> +		},
> +		.driver_data = (void *)&lcd800x1280_leftside_up,
>   	}, {	/* Samsung GalaxyBook 10.6 */
>   		.matches = {
>   		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
