Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C5B6DA11E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbjDFT0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbjDFT0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:26:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C155F5FC8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:26:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n14so22569399plc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680809198; x=1683401198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sLvIqZG1OLnVf55c+E/ZW7Vy5Kftb/G5X9LswBpUOCs=;
        b=ciZmDBc5O16RC0PQCKL/84jqd6xkreIbOorJK+7IfsMqhdaAoOMcBY7lCfCnhZjV0G
         Z66jpadgimjztq1YYT9ZsnhecMiht8wQ/SfwlCZS1gKOngNg5LmAlamicmXJ5CULPRnT
         dWQpPrV3Px84hUWg0Nm3qykN/PGFeydelYCaghIaUyoRRvxFG/WPuug8bTLXKOmKZZXZ
         GH5vroFgxgteE1+0zvCoEIyi3a685qrO02HNoM/wPUJwF5L1kWAJ+yviWDXo4Q/gQGTa
         wZax2QCAexqChnpuxshdrWEG1Bhxn8d7xpXGpYjmizKh7+hdMiUoQ3evmCmW+EwIAq1K
         IYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680809198; x=1683401198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLvIqZG1OLnVf55c+E/ZW7Vy5Kftb/G5X9LswBpUOCs=;
        b=YiOhcNcWnKKT2TTxHblg9etfsBLZbe6Zrg2MLubqpQ3osQrNpF3cem53+eNKYnhE01
         GtwoiEZB84EPU9/BcjOeIEC7lJ9Z7z4PzL3roHkEUJEyCPgKsVuUz2n2KSn640aaIKDF
         NOTkB5xIHT0EJceyd10P0Y3R1vdt8vRYzTEnVmnNOMtObUZb/q7KoMZq4fij3anQpCb3
         4YbAtMxwuH8CLtjXAROimF3ck4DmMufpkrp3o6slPV0xcW9dMkDyaeYpG8/PcXVyPrnB
         2wdyvPmHj37nfaSZ5pLjCZg3Y/J0fnGNXneO7sHUL+EtsvgccX4t851B5g/rmn6D9Z3X
         ReZA==
X-Gm-Message-State: AAQBX9eV2J7+oGAJD/vAkAbMvevCl6cBgzr+JzULGMevGPh+jKx0bKqV
        NUggdS+DB8bdlyH2B/8SNsY=
X-Google-Smtp-Source: AKy350b/HFoAYPCYrGWnoMuCGCgD5LNQ1IVNZLVDwASFtUXOc4/thrp+dz1zm5zTKv5wZC88GHCvbw==
X-Received: by 2002:a17:90b:4d0a:b0:23d:e0c1:8b93 with SMTP id mw10-20020a17090b4d0a00b0023de0c18b93mr12270140pjb.34.1680809198123;
        Thu, 06 Apr 2023 12:26:38 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id o20-20020a17090ab89400b0023440af7aafsm1517783pjr.9.2023.04.06.12.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:26:37 -0700 (PDT)
Message-ID: <4632ce69-2a94-0c33-9a76-b97596436e24@gmail.com>
Date:   Fri, 7 Apr 2023 04:26:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/5] extcon: Get rid of not really used name field in
 struct extcon_dev
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>
References: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
 <20230405152745.24959-3-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230405152745.24959-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23. 4. 6. 00:27, Andy Shevchenko wrote:
> The name field is always set to the parent device name and never
> altered. No need to keep it inside the struct extcon_dev as we
> always may derive it from the dev_name(edev->dev.parent) call.
> 
> Moreover, the parent device pointer won't ever be NULL, otherwise
> we may not allocate the extcon device at all.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 12 +++---------
>  drivers/extcon/extcon.h |  3 ---
>  2 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 47819c5144d5..75a0147703c0 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -387,7 +387,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct extcon_dev *edev = dev_get_drvdata(dev);
>  
> -	return sysfs_emit(buf, "%s\n", edev->name);
> +	return sysfs_emit(buf, "%s\n", dev_name(edev->dev.parent));
>  }
>  static DEVICE_ATTR_RO(name);
>  
> @@ -885,7 +885,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  
>  	mutex_lock(&extcon_dev_list_lock);
>  	list_for_each_entry(sd, &extcon_dev_list, entry) {
> -		if (!strcmp(sd->name, extcon_name))
> +		if (device_match_name(sd->dev.parent, extcon_name))
>  			goto out;
>  	}
>  	sd = ERR_PTR(-EPROBE_DEFER);
> @@ -1269,12 +1269,6 @@ int extcon_dev_register(struct extcon_dev *edev)
>  	edev->dev.class = extcon_class;
>  	edev->dev.release = extcon_dev_release;
>  
> -	edev->name = dev_name(edev->dev.parent);
> -	if (IS_ERR_OR_NULL(edev->name)) {
> -		dev_err(&edev->dev,
> -			"extcon device name is null\n");
> -		return -EINVAL;
> -	}

>  	dev_set_name(&edev->dev, "extcon%lu",
>  			(unsigned long)atomic_inc_return(&edev_no));
>  
> @@ -1465,7 +1459,7 @@ EXPORT_SYMBOL_GPL(extcon_get_edev_by_phandle);
>   */
>  const char *extcon_get_edev_name(struct extcon_dev *edev)
>  {
> -	return !edev ? NULL : edev->name;
> +	return edev ? dev_name(edev->dev.parent) : NULL;
>  }
>  EXPORT_SYMBOL_GPL(extcon_get_edev_name);
>  
> diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
> index 49e4ed9f6450..9ce7042606d7 100644
> --- a/drivers/extcon/extcon.h
> +++ b/drivers/extcon/extcon.h
> @@ -6,8 +6,6 @@
>  
>  /**
>   * struct extcon_dev - An extcon device represents one external connector.
> - * @name:		The name of this extcon device. Parent device name is
> - *			used if NULL.
>   * @supported_cable:	Array of supported cable names ending with EXTCON_NONE.
>   *			If supported_cable is NULL, cable name related APIs
>   *			are disabled.
> @@ -40,7 +38,6 @@
>   */
>  struct extcon_dev {
>  	/* Optional user initializing data */
> -	const char *name;

No I don't want to remove the name even if the edev->name is equal
with the parent's name. I might reduce the readability and understaning
of the code user and I think that it is not good to use 'dev.parent' directly
at multiple point. I think that it just better to edit the wrong description
as following:


diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index 15616446140d..f03d596d148f 100644
--- a/drivers/extcon/extcon.h
+++ b/drivers/extcon/extcon.h
@@ -6,8 +6,7 @@
 
 /**
  * struct extcon_dev - An extcon device represents one external connector.
- * @name:              The name of this extcon device. Parent device name is
- *                     used if NULL.
+ * @name:              The name of this extcon device.
  * @supported_cable:   Array of supported cable names ending with EXTCON_NONE.
  *                     If supported_cable is NULL, cable name related APIs
  *                     are disabled.
@@ -39,7 +38,6 @@
  * are overwritten by register function.
  */
 struct extcon_dev {
-       /* Optional user initializing data */
        const char *name;
        const unsigned int *supported_cable;
        const u32 *mutually_exclusive;



>  	const unsigned int *supported_cable;
>  	const u32 *mutually_exclusive;


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

