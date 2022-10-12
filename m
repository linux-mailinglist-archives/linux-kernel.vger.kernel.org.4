Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE555FCB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJLTBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJLTAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:00:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142949B875;
        Wed, 12 Oct 2022 12:00:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z20so17074683plb.10;
        Wed, 12 Oct 2022 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOuKQ0zXiovSsPQnXuIXHqNIP5tKjtfrc0UJmoK1jFI=;
        b=i0BgDQb2aczsl0DrlhXtchMelkLflX1dQdIdy3mc+txnSZSEV3dgX9vR6QmPV4unAe
         7ZPP1yZYulrLrt0WgD9joy7Lw4gtvVBu6DUIcXJOOJRDcveeaQBx1C67V7PfFimltOhp
         bQFIWUqbZEwRV3L5malSls7kMkGp6gcq6B1uL5MCKOePlL/3Rp5rkEIxfQtFs7fRcjHs
         Ym4jtm5K6SLmKreVde3fiqTE7pxtHFb2j+rd/r41yNt3ktinXlBiuYFhUC4N4DBK0Ae3
         zC/oyhlWNRM0rpq1aqLLXBD9vmXwzN4IpgvH1dQ5JHF2sRUxj0XMhbJ0QAnGN9RTWCcM
         G4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOuKQ0zXiovSsPQnXuIXHqNIP5tKjtfrc0UJmoK1jFI=;
        b=aDEhIrs/R51MPA5DS8lc62bTYHvXGmXBlEiipplokQP3WYSZc0qRsbEWMwKUV85W8i
         gP6tEA1Oh0mgDZrA98tqpwu3r4Bt9gS+olmGt6EtWy5dQAwBi5RC1I/X2VkDG+PbsYMO
         p+3iDpvFgEmhBXKZ9cRVOv7Vhyr7vBKmPTlMmbRobNnw+CAlyp45v3W5fYqf6ScUiyyF
         9zximfsgIu5C3KQwQ86dd0SXiJlsZJxabA2SYaer+cJGara40XxezFhJgzhQ1sar4LyB
         Qmz70aqZs5jLe0j583k0BEsI15kMM2iLbKu2Aeq4go2blB5U6yJ9I6InoPd4NaLDmWTb
         6CZw==
X-Gm-Message-State: ACrzQf2T6IBPXYDJtVATDMiSQHGpvlJWz/2sp/NG+YRKuDiEj/G/fayd
        bXimkqJ814qUYX2idLFDPQY=
X-Google-Smtp-Source: AMsMyM7S63dSmSP82xcQhD5BhMNaURrMyjSfBmWRJ8G+5tsfYZKKzEAc/ayehcy3SrMXgVQV3wcdeQ==
X-Received: by 2002:a17:902:d544:b0:17d:318a:adf7 with SMTP id z4-20020a170902d54400b0017d318aadf7mr31332166plf.148.1665601254358;
        Wed, 12 Oct 2022 12:00:54 -0700 (PDT)
Received: from [172.30.1.63] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id 7-20020a620507000000b00540f96b7936sm236257pff.30.2022.10.12.12.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 12:00:53 -0700 (PDT)
Message-ID: <00ed0b46-54db-330e-8ff8-146ff9a09491@gmail.com>
Date:   Thu, 13 Oct 2022 04:00:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] devfreq: governor: Add a private governor_data for
 governors in devfreq
Content-Language: en-US
To:     Kant Fan <kant@allwinnertech.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010072202.78731-1-kant@allwinnertech.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20221010072202.78731-1-kant@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry for late reply. It looks good to me.
Instead, this patch should contain the 'Fixes' information
with the following commit because the changed code was merged
on the patch[1]. Also, need to send it to stable mailing list.

[1] ce26c5bb9569d8b826f01b8620fc16d8da6821e9
PM / devfreq: Add basic governors

Lastly, I think that need to change the patch title as following:
- PM / devfreq: governor: Add a private governor_data for governor


On 22. 10. 10. 16:22, Kant Fan wrote:
> The member void *data in the structure devfreq can be overwrite
> by governor_userspace. For example:
> 1. The device driver assigned the devfreq governor to simple_ondemand
> by the function devfreq_add_device() and init the devfreq member
> void *data to a pointer of a static structure devfreq_simple_ondemand_data
> by the function devfreq_add_device().
> 2. The user changed the devfreq governor to userspace by the command
> "echo userspace > /sys/class/devfreq/.../governor".
> 3. The governor userspace alloced a dynamic memory for the struct
> userspace_data and assigend the member void *data of devfreq to
> this memory by the function userspace_init().
> 4. The user changed the devfreq governor back to simple_ondemand
> by the command "echo simple_ondemand > /sys/class/devfreq/.../governor".
> 5. The governor userspace exited and assigned the member void *data
> in the structure devfreq to NULL by the function userspace_exit().
> 6. The governor simple_ondemand fetched the static information of
> devfreq_simple_ondemand_data in the function
> devfreq_simple_ondemand_func() but the member void *data of devfreq was
> assigned to NULL by the function userspace_exit().
> 7. The information of upthreshold and downdifferential is lost
> and the governor simple_ondemand can't work correctly.
> 
> The member void *data in the structure devfreq is designed for
> a static pointer used in a governor and inited by the function
> devfreq_add_device(). This patch add an element named governor_data
> in the devfreq structure which can be used by a governor(E.g userspace)
> who want to assign a private data to do some private things.
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 
> Signed-off-by: Kant Fan <kant@allwinnertech.com>
> ---
>  drivers/devfreq/governor_userspace.c | 12 ++++++------
>  include/linux/devfreq.h              |  7 ++++---
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index ab9db7adb3ad..d69672ccacc4 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -21,7 +21,7 @@ struct userspace_data {
>  
>  static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>  {
> -	struct userspace_data *data = df->data;
> +	struct userspace_data *data = df->governor_data;
>  
>  	if (data->valid)
>  		*freq = data->user_frequency;
> @@ -40,7 +40,7 @@ static ssize_t set_freq_store(struct device *dev, struct device_attribute *attr,
>  	int err = 0;
>  
>  	mutex_lock(&devfreq->lock);
> -	data = devfreq->data;
> +	data = devfreq->governor_data;
>  
>  	sscanf(buf, "%lu", &wanted);
>  	data->user_frequency = wanted;
> @@ -60,7 +60,7 @@ static ssize_t set_freq_show(struct device *dev,
>  	int err = 0;
>  
>  	mutex_lock(&devfreq->lock);
> -	data = devfreq->data;
> +	data = devfreq->governor_data;
>  
>  	if (data->valid)
>  		err = sprintf(buf, "%lu\n", data->user_frequency);
> @@ -91,7 +91,7 @@ static int userspace_init(struct devfreq *devfreq)
>  		goto out;
>  	}
>  	data->valid = false;
> -	devfreq->data = data;
> +	devfreq->governor_data = data;
>  
>  	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
>  out:
> @@ -107,8 +107,8 @@ static void userspace_exit(struct devfreq *devfreq)
>  	if (devfreq->dev.kobj.sd)
>  		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
>  
> -	kfree(devfreq->data);
> -	devfreq->data = NULL;
> +	kfree(devfreq->governor_data);
> +	devfreq->governor_data = NULL;
>  }
>  
>  static int devfreq_userspace_handler(struct devfreq *devfreq,
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 34aab4dd336c..d265af3fb0a4 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -152,8 +152,8 @@ struct devfreq_stats {
>   * @max_state:		count of entry present in the frequency table.
>   * @previous_freq:	previously configured frequency value.
>   * @last_status:	devfreq user device info, performance statistics
> - * @data:	Private data of the governor. The devfreq framework does not
> - *		touch this.
> + * @data:	devfreq core pass to governors, governor should not change it.
> + * @governor_data:	private data for governors, devfreq core doesn't touch it.
>   * @user_min_freq_req:	PM QoS minimum frequency request from user (via sysfs)
>   * @user_max_freq_req:	PM QoS maximum frequency request from user (via sysfs)
>   * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
> @@ -193,7 +193,8 @@ struct devfreq {
>  	unsigned long previous_freq;
>  	struct devfreq_dev_status last_status;
>  
> -	void *data; /* private data for governors */
> +	void *data;
> +	void *governor_data;
>  
>  	struct dev_pm_qos_request user_min_freq_req;
>  	struct dev_pm_qos_request user_max_freq_req;

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
