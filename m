Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF3E6C0D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCTJd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjCTJdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:33:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE931ACF6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:33:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o12so44019508edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679304826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3QdF0wMkBTmtVBS8ynp8ovaXMshD0DpAnNchV77vtY=;
        b=UesMPWRFpR2JX5vPVbvxYR1zQ+M+IhSMpWZH2lIpwZ0WZoIufebUX5DzgeExhxsh7f
         2ANido3DAEPiekrASioV8YH/Jgcw3esOfddOi4zUrFGfwZH+R7TNm67sArqs/cA7Zz5F
         A7AyqxWgJjo8G9/PU64k17rMzERIA8qXy56VI5gym42uXNTsm/mpiul0NW5VkB4AhCiI
         4Kyo+ano9ElnW2faIL27Uj7bGtTQbDO4kn+9y4GHB2ELbwX5BjABnNaG0vWTvrEkjcu1
         q/HiAokTchc8jfj0QCgB/f8Zcm/suqr7eLzE29iRGb5WnLKftKTj1VuEUDJ0dBI48GyS
         cozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679304826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3QdF0wMkBTmtVBS8ynp8ovaXMshD0DpAnNchV77vtY=;
        b=JBg0DDK9BRfNuFSyh1IAvEZN5+gwmkVngVX+2HENjBtBgDxtciVtesWUUr2iBsjaF0
         buqDu+FgKk6ZdjC+LtzDbtMMj6rcBTHmhpESBZ5W4tLWyGieOZYVY7Jq4xTDjbLmXsBo
         GBmpSPtN9r3SY6wBtRixWeoypQprlMbWBZLzZfqIxkB8DC+lU2MWAE6rUMPn00Hx7pQj
         yhSysK8XUiEp4t4lLUTnltrXXxpjigOT1Em6crDPz2IOq05S8HFWB3NlJ0DWDAj4K9WT
         kNeiOsTei++Pa0UEbdIUh65li+ADuGUQmo5DESu1sSedcFEbz5NtQBGiOEtyJlf8Wnrv
         pTeA==
X-Gm-Message-State: AO0yUKXT+oHjzotTAxJJXxYGVYQQj+Rq9eEfHDb/c13itNES0zSlZI9x
        JqYgpAmOIPHnrZXEo2SZyy8=
X-Google-Smtp-Source: AK7set8Qn657Y7DA+BYuCWXB4qfbuxFmPEcongWcCbMjvnz5MP4Uux0KQPqqqU1zWuDfyZSENqbyDw==
X-Received: by 2002:a17:906:f193:b0:933:868:413a with SMTP id gs19-20020a170906f19300b009330868413amr8046651ejb.15.1679304825710;
        Mon, 20 Mar 2023 02:33:45 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id p25-20020a17090653d900b009333b82f061sm2492372ejo.80.2023.03.20.02.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 02:33:45 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:33:43 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [PATCH] Staging: greybus: Fix lines ending with '('
Message-ID: <ZBgod938/PJX1xsE@khadija-virtual-machine>
References: <20230319164520.GA125117@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319164520.GA125117@sumitra.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 09:45:20AM -0700, Sumitra Sharma wrote:
> The coding style used to limit lines to 80 characters,
> which led to splitting of these function headers into multiple
> lines and ends the first line with a '('.
> Such splits causes checks reported by the checkpatch.
> 
> Place the function parameters of each function immediately after
> '(' in a single line to align the function headers.
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
>  .../staging/greybus/audio_manager_module.c    | 40 +++++++++----------
>  1 file changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
> index 0a0f0a394c84..81b4ba607a0e 100644
> --- a/drivers/staging/greybus/audio_manager_module.c
> +++ b/drivers/staging/greybus/audio_manager_module.c
> @@ -70,9 +70,8 @@ static void gb_audio_module_release(struct kobject *kobj)
>  	kfree(module);
>  }
>  
> -static ssize_t gb_audio_module_name_show(
> -	struct gb_audio_manager_module *module,
> -	struct gb_audio_manager_module_attribute *attr, char *buf)
> +static ssize_t gb_audio_module_name_show(struct gb_audio_manager_module *module,
> +					 struct gb_audio_manager_module_attribute *attr, char *buf)
>  {
>  	return sprintf(buf, "%s", module->desc.name);
>  }
> @@ -80,9 +79,8 @@ static ssize_t gb_audio_module_name_show(
>  static struct gb_audio_manager_module_attribute gb_audio_module_name_attribute =
>  	__ATTR(name, 0664, gb_audio_module_name_show, NULL);
>  
> -static ssize_t gb_audio_module_vid_show(
> -	struct gb_audio_manager_module *module,
> -	struct gb_audio_manager_module_attribute *attr, char *buf)
> +static ssize_t gb_audio_module_vid_show(struct gb_audio_manager_module *module,
> +					struct gb_audio_manager_module_attribute *attr, char *buf)
>  {
>  	return sprintf(buf, "%d", module->desc.vid);
>  }
> @@ -90,9 +88,8 @@ static ssize_t gb_audio_module_vid_show(
>  static struct gb_audio_manager_module_attribute gb_audio_module_vid_attribute =
>  	__ATTR(vid, 0664, gb_audio_module_vid_show, NULL);
>  
> -static ssize_t gb_audio_module_pid_show(
> -	struct gb_audio_manager_module *module,
> -	struct gb_audio_manager_module_attribute *attr, char *buf)
> +static ssize_t gb_audio_module_pid_show(struct gb_audio_manager_module *module,
> +					struct gb_audio_manager_module_attribute *attr, char *buf)
>  {
>  	return sprintf(buf, "%d", module->desc.pid);
>  }
> @@ -100,9 +97,9 @@ static ssize_t gb_audio_module_pid_show(
>  static struct gb_audio_manager_module_attribute gb_audio_module_pid_attribute =
>  	__ATTR(pid, 0664, gb_audio_module_pid_show, NULL);
>  
> -static ssize_t gb_audio_module_intf_id_show(
> -	struct gb_audio_manager_module *module,
> -	struct gb_audio_manager_module_attribute *attr, char *buf)
> +static ssize_t gb_audio_module_intf_id_show(struct gb_audio_manager_module *module,
> +					    struct gb_audio_manager_module_attribute *attr,
> +					    char *buf)
>  {
>  	return sprintf(buf, "%d", module->desc.intf_id);
>  }
> @@ -111,9 +108,9 @@ static struct gb_audio_manager_module_attribute
>  					gb_audio_module_intf_id_attribute =
>  	__ATTR(intf_id, 0664, gb_audio_module_intf_id_show, NULL);
>  
> -static ssize_t gb_audio_module_ip_devices_show(
> -	struct gb_audio_manager_module *module,
> -	struct gb_audio_manager_module_attribute *attr, char *buf)
> +static ssize_t gb_audio_module_ip_devices_show(struct gb_audio_manager_module *module,
> +					       struct gb_audio_manager_module_attribute *attr,
> +					       char *buf)
>  {
>  	return sprintf(buf, "0x%X", module->desc.ip_devices);
>  }
> @@ -122,9 +119,9 @@ static struct gb_audio_manager_module_attribute
>  					gb_audio_module_ip_devices_attribute =
>  	__ATTR(ip_devices, 0664, gb_audio_module_ip_devices_show, NULL);
>  
> -static ssize_t gb_audio_module_op_devices_show(
> -	struct gb_audio_manager_module *module,
> -	struct gb_audio_manager_module_attribute *attr, char *buf)
> +static ssize_t gb_audio_module_op_devices_show(struct gb_audio_manager_module *module,
> +					       struct gb_audio_manager_module_attribute *attr,
> +					       char *buf)
>  {
>  	return sprintf(buf, "0x%X", module->desc.op_devices);
>  }
> @@ -181,10 +178,9 @@ static void send_add_uevent(struct gb_audio_manager_module *module)
>  	kobject_uevent_env(&module->kobj, KOBJ_ADD, envp);
>  }
>  
> -int gb_audio_manager_module_create(
> -	struct gb_audio_manager_module **module,
> -	struct kset *manager_kset,
> -	int id, struct gb_audio_manager_module_descriptor *desc)
> +int gb_audio_manager_module_create(struct gb_audio_manager_module **module,
> +				   struct kset *manager_kset,
> +				   int id, struct gb_audio_manager_module_descriptor *desc)
>  {
>  	int err;
>  	struct gb_audio_manager_module *m;
> -- 
> 2.25.1
> 
>

Hi Mentors,

I came across a same check error in greybus/audio_topology file.
Would it be okay to send a patch similar to this one?

Regards,
Khadija

