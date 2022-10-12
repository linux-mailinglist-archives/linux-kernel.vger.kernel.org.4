Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEC35FCBAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJLToM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJLToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:44:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79357D7A4;
        Wed, 12 Oct 2022 12:44:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q1so8056100pgl.11;
        Wed, 12 Oct 2022 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GP8R9b8X0vVdCTIRB5D133eRHeLBtAx7ECCX776impk=;
        b=THejl0pIlG7JbmbIlMS3DXlksVsBPH10tiaaH48toQVAtTivJTGHJdtM5cQ4Yx5Mqd
         TOwrIW36ClMw157BXSH/uR6rlGrsarasUWCs1zcuA9/yQm/QwrEoW+inyQwwWVeuApKV
         1FbjY9DB4OyM5CrKzNnTOpEAxiN4YEeRajwje0I6Pa+So4/aNDZCU+FhH7VfXrAujlo+
         4jZzm0o2dqzk68ELG0mK6pImkZaYz7BncPTJQU8Q9psKeHiDSZIspYlQ0+ctT9QRiO9X
         MY+oYcFdXznWbMuQpSligxtZ0p4kLrzl9i1ACmWwZjVvdb5wFps2kgWkiEIshZ7XA82U
         nHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GP8R9b8X0vVdCTIRB5D133eRHeLBtAx7ECCX776impk=;
        b=5m9X5VmEDD3KVb6Vgv7F7qaUoluOmb9x7j6QReb7B/G8RMrHiTu1BHIm+42yQqvm7K
         nnDeRyHEn+uATrslEP6VcswQzH70sioEki/K0U0s3sqLZxTfKbUA0DYlvanjSZz0+x2N
         rKo18OUL1TWyM1IWNyr3HU1fZ8LbMotst9nBk6EJmO7U2Nfe7fCDow1EIIqoEj17Ln2A
         S3C4vHBvaR+j4ALN5pTInBsq+/ETFJvH7ycQ6h6Z49PNngngOHArQZWPN9EcDRQKs7wp
         5kk3YCB7+91Brugt80IrdOfWN2rLCgICP5GueHBBOqJu7caVhQOnonU//ds3VB2vRvN+
         X5Kg==
X-Gm-Message-State: ACrzQf3xesSsXE2I7oDR7FUOjgq2Y9GFREaB2z+qmy2EUiTJh3i6ubBB
        38+MU64pGw7HD8ZWAExa4r8=
X-Google-Smtp-Source: AMsMyM6UhxAwUXUfvZ4N+q0zgWdTigKYWORFNiiIy1Og6PEll1vKZCm8iLWHQixh3a+2k+DAth3rgg==
X-Received: by 2002:a05:6a00:1343:b0:562:ea5e:57e5 with SMTP id k3-20020a056a00134300b00562ea5e57e5mr25818183pfu.45.1665603846152;
        Wed, 12 Oct 2022 12:44:06 -0700 (PDT)
Received: from [172.30.1.63] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id i186-20020a626dc3000000b005627ddbc7a4sm222303pfc.191.2022.10.12.12.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 12:44:05 -0700 (PDT)
Message-ID: <24e701e9-b560-5350-a2f7-89e2a4a1c97a@gmail.com>
Date:   Thu, 13 Oct 2022 04:44:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] devfreq: Support device update function
Content-Language: en-US
To:     Johnny Liu <johnliu@nvidia.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221003060201.14833-1-johnliu@nvidia.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20221003060201.14833-1-johnliu@nvidia.com>
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

Basically, struct devfreq_dev_profile is used to pass the devfreq device data
from devfreq driver to governor. But, This means that it passes
the data from governor to devfreq driver reversely?

On 22. 10. 3. 15:02, Johnny Liu wrote:
> To realize interrupt-driven closed-loop governors, governors need to be

Could you explain the detailed means of 'interrupt-driven closed-loop governors'?

> able to send data to the underlying devfreq driver to ask for updating
> the device settings, such as hardware registers for frequency limits,

I think that governor is not able to get the hardware information direclty
instead of devfreq driver. Usually, the devfreq driver should get the
h/w info and then passed to governor if required.

Lastly, this patch doesn't contain the any use-case of devfreq_update_dev().
I prefer to post the real use-case of this patch. 

> which are compared against the device frequency to generate interrupts
> 
> Since governors might export several tunable parameters, users can
> enforce different policies for the control logics. Under different
> policies, governors need to send different information to inform the
> devfreq driver to configure the device accordingly.
> 
> The introduced update function improves the flexibility of governors
> and acts as a communication interface between governors and devfreq
> drivers.
> 
> Signed-off-by: Johnny Liu <johnliu@nvidia.com>
> ---
> v2: Correct the function signature of devfreq_update_dev
> 
>  drivers/devfreq/governor.h | 8 ++++++++
>  include/linux/devfreq.h    | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 0adfebc0467a..b5781fa549c7 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -124,4 +124,12 @@ static inline int devfreq_update_stats(struct devfreq *df)
>  
>  	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
>  }
> +
> +static inline int devfreq_update_dev(struct devfreq *df, void *data)
> +{
> +	if (!df->profile->update)
> +		return -EINVAL;
> +
> +	return df->profile->update(df->dev.parent, data);
> +}
>  #endif /* _GOVERNOR_H */
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 34aab4dd336c..91648e8f8d76 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -92,6 +92,8 @@ struct devfreq_dev_status {
>   *			devfreq.last_status.
>   * @get_cur_freq:	The device should provide the current frequency
>   *			at which it is operating.
> + * @update:		An optional function to allow governors send data back
> + *			to the devfreq driver to update the device settings.

IMO, 'update' word is too generic. I think that 'update_device_data' is better
to improve the readability.

>   * @exit:		An optional callback that is called when devfreq
>   *			is removing the devfreq object due to error or
>   *			from devfreq_remove_device() call. If the user
> @@ -114,6 +116,7 @@ struct devfreq_dev_profile {
>  	int (*get_dev_status)(struct device *dev,
>  			      struct devfreq_dev_status *stat);
>  	int (*get_cur_freq)(struct device *dev, unsigned long *freq);
> +	int (*update)(struct device *dev, void *data);
>  	void (*exit)(struct device *dev);
>  
>  	unsigned long *freq_table> @@ -451,6 +454,11 @@ static inline int devfreq_update_stats(struct devfreq *df)
>  {
>  	return -EINVAL;
>  }
> +
> +static inline int devfreq_update_dev(struct devfreq *df, void *data)
> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_PM_DEVFREQ */
>  
>  #endif /* __LINUX_DEVFREQ_H__ */



-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
