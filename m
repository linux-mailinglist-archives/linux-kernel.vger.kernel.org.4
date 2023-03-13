Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653996B7546
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCMLGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCMLGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:06:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E8C76BF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:06:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13so1550847pjh.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678705575;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkFGpX/eytRfCnIWS2LFVwG+AZS8z2rXKsDz1orSn7Y=;
        b=lWp/gJZNNgMGbBo5ukpQCXfLhSRK2GWILiz4uidZmM4ZERjpntSLvW0WyQAvUtWcPb
         1D+a8QzwI1xci1PmDAy0jEpeCB7DWlYlstq+eG3lId9dn/aiXTe8ll30RTIOpONAK/Eo
         rPnz2+gIIsA939BstS6mvUmt/VWZszc+MWzCrxlg1/DRQliyV3W3YAHKh36FsV2vjI7i
         2Jtbd2Nu0rihXhVZhDzuHY6ICTCTzO+/PGiNKiPVmASGj9hRi9Ly1h+ZqHD67rlu6kJU
         wWzXKMaQYH+4EbmN4K80CUAQmQHtsiypoW0QUhem3DdlQ7UQYGFwZjysWKVN6KVxH44d
         hP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678705575;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkFGpX/eytRfCnIWS2LFVwG+AZS8z2rXKsDz1orSn7Y=;
        b=Nk7mMrQVdyO5Dei9oqRQPOm6fqxn19W0sgLYwStIv0NstL+6d4emMMyIi+tUQfd5Kc
         WgaWYhCJkMk73UnsK57TBj4uTC/kLUapQggFPuAy3Yl98bLl2G3tJdM+BHZ90XBYS2ne
         ZxqIRwNmzxBzRVOabVlCPRaRT9vY3CDrnaOZUniywRVc8FsYcquEMli33Yx9DdXuL58t
         6IE4vDUFJuTGjFpnchcQmr8b4dlymwCUMtz7dysMbXxY5MMqPxhNAWmu9mHYkSeDlflO
         HiWJ6tVaLtqmlhyXyhrVbgiCuNIQLhYBjWBarM6pL1M/1bVFrHfq1t92SY6xYTmFi09N
         gOkA==
X-Gm-Message-State: AO0yUKUG5Ct8m4V+QK/Re063nrbBeCfCdDbqQBPeMWBahu9SaKe7H5E8
        cmrg1JAKCsUNISI+dTQtD5I=
X-Google-Smtp-Source: AK7set9/hq90vejCEDTqUHV4EhsRte7LeGb5L5G/+6VprdaiCjSXXVHcY1yJKcHCsgNVld79QdfTPQ==
X-Received: by 2002:a17:903:2309:b0:1a0:49eb:4cb8 with SMTP id d9-20020a170903230900b001a049eb4cb8mr3312175plh.44.1678705575602;
        Mon, 13 Mar 2023 04:06:15 -0700 (PDT)
Received: from [172.30.1.89] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id g1-20020a1709026b4100b0019a96d3b456sm4543543plt.44.2023.03.13.04.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 04:06:15 -0700 (PDT)
Message-ID: <c2e6aae5-e980-112d-e75f-187d27c3af5d@gmail.com>
Date:   Mon, 13 Mar 2023 20:06:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/4] extcon: Added extcon_alloc_cables to simplify
 extcon register function
Content-Language: en-US
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
References: <20230302090143.46678-1-bw365.lee@samsung.com>
 <CGME20230302090149epcas1p2bad39de9aa367644cda3ffcb4dd4a612@epcas1p2.samsung.com>
 <20230302090143.46678-3-bw365.lee@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230302090143.46678-3-bw365.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 2. 18:01, Bumwoo Lee wrote:
> The cable allocation part is functionalized from extcon_dev_register.
> 
> Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
> ---
>  drivers/extcon/extcon.c | 108 +++++++++++++++++++++++-----------------
>  1 file changed, 62 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index adcf01132f70..49605e96bedd 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1070,6 +1070,63 @@ void extcon_dev_free(struct extcon_dev *edev)
>  }
>  EXPORT_SYMBOL_GPL(extcon_dev_free);
>  
> +/**
> + * extcon_alloc_cables() - alloc the cables for extcon device
> + * @edev:	extcon device which has cables
> + *
> + * Returns 0 if success or error number if fail.
> + */
> +static int extcon_alloc_cables(struct extcon_dev *edev)
> +{
> +	int index;
> +	char *str;
> +	struct extcon_cable *cable;
> +
> +	if (!edev->max_supported)
> +		return 0;


Need to check whether edev is NULL or not 
because make the separate function.

	if (!edev && !edev->max_supported)

> +
> +	edev->cables = kcalloc(edev->max_supported,
> +			       sizeof(struct extcon_cable),
> +			       GFP_KERNEL);
> +	if (!edev->cables)
> +		return -ENOMEM;
> +
> +	for (index = 0; index < edev->max_supported; index++) {
> +		cable = &edev->cables[index];
> +
> +		str = kasprintf(GFP_KERNEL, "cable.%d", index);
> +		if (!str) {
> +			for (index--; index >= 0; index--) {
> +				cable = &edev->cables[index];
> +				kfree(cable->attr_g.name);
> +			}
> +
> +			kfree(edev->cables);
> +			return -ENOMEM;
> +		}
> +
> +		cable->edev = edev;
> +		cable->cable_index = index;
> +		cable->attrs[0] = &cable->attr_name.attr;
> +		cable->attrs[1] = &cable->attr_state.attr;
> +		cable->attrs[2] = NULL;
> +		cable->attr_g.name = str;
> +		cable->attr_g.attrs = cable->attrs;
> +
> +		sysfs_attr_init(&cable->attr_name.attr);
> +		cable->attr_name.attr.name = "name";
> +		cable->attr_name.attr.mode = 0444;
> +		cable->attr_name.show = cable_name_show;
> +
> +		sysfs_attr_init(&cable->attr_state.attr);
> +		cable->attr_state.attr.name = "state";
> +		cable->attr_state.attr.mode = 0444;
> +		cable->attr_state.show = cable_state_show;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * extcon_dev_register() - Register an new extcon device
>   * @edev:	the extcon device to be registered
> @@ -1117,50 +1174,9 @@ int extcon_dev_register(struct extcon_dev *edev)
>  	dev_set_name(&edev->dev, "extcon%lu",
>  			(unsigned long)atomic_inc_return(&edev_no));
>  
> -	if (edev->max_supported) {
> -		char *str;
> -		struct extcon_cable *cable;
> -
> -		edev->cables = kcalloc(edev->max_supported,
> -				       sizeof(struct extcon_cable),
> -				       GFP_KERNEL);
> -		if (!edev->cables) {
> -			ret = -ENOMEM;
> -			goto err_sysfs_alloc;
> -		}
> -		for (index = 0; index < edev->max_supported; index++) {
> -			cable = &edev->cables[index];
> -
> -			str = kasprintf(GFP_KERNEL, "cable.%d", index);
> -			if (!str) {
> -				for (index--; index >= 0; index--) {
> -					cable = &edev->cables[index];
> -					kfree(cable->attr_g.name);
> -				}
> -				ret = -ENOMEM;
> -
> -				goto err_alloc_cables;
> -			}
> -
> -			cable->edev = edev;
> -			cable->cable_index = index;
> -			cable->attrs[0] = &cable->attr_name.attr;
> -			cable->attrs[1] = &cable->attr_state.attr;
> -			cable->attrs[2] = NULL;
> -			cable->attr_g.name = str;
> -			cable->attr_g.attrs = cable->attrs;
> -
> -			sysfs_attr_init(&cable->attr_name.attr);
> -			cable->attr_name.attr.name = "name";
> -			cable->attr_name.attr.mode = 0444;
> -			cable->attr_name.show = cable_name_show;
> -
> -			sysfs_attr_init(&cable->attr_state.attr);
> -			cable->attr_state.attr.name = "state";
> -			cable->attr_state.attr.mode = 0444;
> -			cable->attr_state.show = cable_state_show;
> -		}
> -	}
> +	ret = extcon_alloc_cables(edev);
> +	if (ret < 0)
> +		goto err_alloc_cables;
>  
>  	if (edev->max_supported && edev->mutually_exclusive) {
>  		char *name;
> @@ -1279,10 +1295,10 @@ int extcon_dev_register(struct extcon_dev *edev)
>  err_muex:
>  	for (index = 0; index < edev->max_supported; index++)
>  		kfree(edev->cables[index].attr_g.name);
> -err_alloc_cables:
>  	if (edev->max_supported)
>  		kfree(edev->cables);
> -err_sysfs_alloc:
> +err_alloc_cables:
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(extcon_dev_register);

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

