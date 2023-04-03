Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55676D4691
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjDCOKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjDCOKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:10:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113342C9E3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:10:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so32660060pjp.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680531021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1GEvhS4uRiEVRZXgLcLYYS/OtgUwrFKxy5oSfzg+/Y=;
        b=kKr3OsBDUSVPf4Rra45o1mucc1a49rCm0GktJRyU4LUwWUvXXF79awYIxT5uAubeUw
         1PNZbq+kyLsddWxVbyDRwnzc0c3mGSdsZWCAvXoqIbEzWPrY7vIBR9rqUricdDIA34z9
         VE3lLu2IKtiGzwZsKzEzmSqPsctZXsB1ltw/YR7zio0K8sxc5nWg+Bi5KG9V90GGkvHG
         IVdaOcnEQqKV5TSErf4rmlse2HKEUVH1oWauNiZfcSP2o4iyZr9hir3VpjI/5eWP/Ylq
         n+NmcOHacmagYhLlyQygJCCEd6Qw0Oa+333KWbOFRiZW2BY29SXOTcNUWxNWTrBW2/CU
         smAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680531021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1GEvhS4uRiEVRZXgLcLYYS/OtgUwrFKxy5oSfzg+/Y=;
        b=3R1sMDxx/KXIfNAoZ7/8LrffRe8TReoNakjr4YmMVaKscoJzYsmiyKy8kokS2U52tY
         PNbV/FTNvXV2qZO1AyMPEq7RBGC/rGAiOxDCbGo+VPfQAkLokNx4A3tZcAQABQMXa/1g
         JNignxgfnr2cUPpnLsAko9zazkVRlsacfF0v+pIBNmJ9IYraUbSHmbpqMAcVQ87YQNxT
         jlZP2MIzkEfo3cLR3Rrby0sy1tv2p7uXwoo+xNIAGvop238OEm3A3e3GnWRMtI236aND
         hbAfHoBS903kfK9t0j3i5fvzHQ2tmqbqesD3game8OOKcZyOmimfD72nSFDdjXs3BOUS
         0URw==
X-Gm-Message-State: AAQBX9dJ2XF+PjaLIIWizKslGd9o+idXVOidBk9F42pJqf4u8SLDtKb4
        N1MFqnvYtgcpuqvsqkyKMAkZ322DExZJJg==
X-Google-Smtp-Source: AKy350Z9G/83+yE2mM/oZ6KTxOeN26MIyU7M0/11/wDLLoaf9VGWeOQiFbNBJOUkqiKJu2tXqcuNsw==
X-Received: by 2002:a17:902:ecc4:b0:1a1:d949:a52d with SMTP id a4-20020a170902ecc400b001a1d949a52dmr45645205plh.65.1680531021282;
        Mon, 03 Apr 2023 07:10:21 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709029a0c00b001a1d5d47105sm6677079plp.53.2023.04.03.07.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:10:20 -0700 (PDT)
Message-ID: <cf82c26b-14ec-166f-c34c-e27b1e33238b@gmail.com>
Date:   Mon, 3 Apr 2023 23:10:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 04/14] extcon: use sysfs_emit() to instead of sprintf()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-5-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 22. 23:39, Andy Shevchenko wrote:
> Follow the advice of the Documentation/filesystems/sysfs.rst that
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 70e9755ba2bc..ac84f4aafc69 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -370,12 +370,12 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
>  	struct extcon_dev *edev = dev_get_drvdata(dev);
>  
>  	if (edev->max_supported == 0)
> -		return sprintf(buf, "%u\n", edev->state);
> +		return sysfs_emit(buf, "%u\n", edev->state);
>  
>  	for (i = 0; i < edev->max_supported; i++) {
> -		count += sprintf(buf + count, "%s=%d\n",
> -				extcon_info[edev->supported_cable[i]].name,
> -				 !!(edev->state & BIT(i)));
> +		count += sysfs_emit_at(buf, count, "%s=%d\n",
> +				       extcon_info[edev->supported_cable[i]].name,
> +				       !!(edev->state & BIT(i)));
>  	}
>  
>  	return count;
> @@ -387,7 +387,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct extcon_dev *edev = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%s\n", edev->name);
> +	return sysfs_emit(buf, "%s\n", edev->name);
>  }
>  static DEVICE_ATTR_RO(name);
>  
> @@ -398,8 +398,8 @@ static ssize_t cable_name_show(struct device *dev,
>  						  attr_name);
>  	int i = cable->cable_index;
>  
> -	return sprintf(buf, "%s\n",
> -			extcon_info[cable->edev->supported_cable[i]].name);
> +	return sysfs_emit(buf, "%s\n",
> +			  extcon_info[cable->edev->supported_cable[i]].name);
>  }
>  
>  static ssize_t cable_state_show(struct device *dev,
> @@ -410,8 +410,8 @@ static ssize_t cable_state_show(struct device *dev,
>  
>  	int i = cable->cable_index;
>  
> -	return sprintf(buf, "%d\n",
> -		extcon_get_state(cable->edev, cable->edev->supported_cable[i]));
> +	return sysfs_emit(buf, "%d\n",
> +			  extcon_get_state(cable->edev, cable->edev->supported_cable[i]));
>  }
>  
>  /**

Applied it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

