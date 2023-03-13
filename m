Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ED36B7553
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCMLHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCMLHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:07:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B64560D4C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:07:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so2977015pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678705660;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dpkRxKwKC6L8xSyPLVy2ASVN++7O1trppTR6ZV0T2o=;
        b=NoxibzGySgGJCnEKJvGuwXouv6xgaEIRNxzdSU41/H0+thOqg/hkSqzboXQf9hLCgM
         sETFm0wVb6pUW4s9OASHyEM4ftXK8y7XH4uTWclvR+A9LY6XXyHShpNv4HVtSYfHIIua
         5UXZM3wlzJNfE/IpLKdYt1Lpa9DTrXP+0Q3uBwBJvzJnP5ksg8ZSTRDyt0hoZpGmGCP6
         x7N70lM15pO1wiwiQhsINS+Qrm16AWSVDPnXS7WaApj56F43+YWMeTWOBqBzzLJ4y/0J
         EgulPaj1PthB8d+mmCNzG6sxoRtopEoklfu4JoCvBxJdm/9WMpYX3cdYocQD86PQibwt
         Agwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678705660;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dpkRxKwKC6L8xSyPLVy2ASVN++7O1trppTR6ZV0T2o=;
        b=NYYgjQuwlGc0m62DpdpdFZNcoJe7t7g8v0boT50JxNMI+QOJTvxLS7rRV2JEGSe/is
         66ZG00+i0fI/3S0sk21ktC2mtl8bbNQdPeVkFT+eXvdNnfVaVSb0JLHNzsyE9MIy8sf1
         O8PUsLIly0WQRGgPYWg+8xiagSh9jJ5bbrqXHyk9Y0o/TzZuT+fIq7NatAmefX0yYjMq
         aUY37O3XPoUsLgVNHeZYLlGw6fl3/LqAJ1o3y0LIE0fAW6ZFdcU/KwhszY1D+CkEovYQ
         I2Tl5Yxx91vgtCYClsz/WQAnHRDbfyADHKeW4b006w9plA/5upXv0PbMf57MVvqPYlrX
         IaQw==
X-Gm-Message-State: AO0yUKVCvd63rQl9uHAWJiaoaBW97Q4JivPJyx/ylaeNx/6DK7qIxi2D
        nndwSKHor/Z6uEaDeiSbsIOlswSnJ7q7mQ==
X-Google-Smtp-Source: AK7set9NsEy9eUVt1KRpU/yYjTJqg41HXXs/agH1ShVh26/xL+NhytKfsJ/7SXEmlG4NxrW0VFZtCg==
X-Received: by 2002:a17:902:d4c9:b0:19d:323:e70 with SMTP id o9-20020a170902d4c900b0019d03230e70mr42122275plg.33.1678705659842;
        Mon, 13 Mar 2023 04:07:39 -0700 (PDT)
Received: from [172.30.1.89] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b0019ee045a2b3sm4473337plg.308.2023.03.13.04.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 04:07:39 -0700 (PDT)
Message-ID: <5fb2c4a3-71c1-5ccc-a928-258d31b8af8e@gmail.com>
Date:   Mon, 13 Mar 2023 20:07:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/4] extcon: Added extcon_alloc_cables to simplify
 extcon register function
Content-Language: en-US
From:   Chanwoo Choi <cwchoi00@gmail.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
References: <20230302090143.46678-1-bw365.lee@samsung.com>
 <CGME20230302090149epcas1p2bad39de9aa367644cda3ffcb4dd4a612@epcas1p2.samsung.com>
 <20230302090143.46678-3-bw365.lee@samsung.com>
 <c2e6aae5-e980-112d-e75f-187d27c3af5d@gmail.com>
In-Reply-To: <c2e6aae5-e980-112d-e75f-187d27c3af5d@gmail.com>
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

On 23. 3. 13. 20:06, Chanwoo Choi wrote:
> On 23. 3. 2. 18:01, Bumwoo Lee wrote:
>> The cable allocation part is functionalized from extcon_dev_register.
>>
>> Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
>> ---
>>  drivers/extcon/extcon.c | 108 +++++++++++++++++++++++-----------------
>>  1 file changed, 62 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
>> index adcf01132f70..49605e96bedd 100644
>> --- a/drivers/extcon/extcon.c
>> +++ b/drivers/extcon/extcon.c
>> @@ -1070,6 +1070,63 @@ void extcon_dev_free(struct extcon_dev *edev)
>>  }
>>  EXPORT_SYMBOL_GPL(extcon_dev_free);
>>  
>> +/**
>> + * extcon_alloc_cables() - alloc the cables for extcon device
>> + * @edev:	extcon device which has cables
>> + *
>> + * Returns 0 if success or error number if fail.
>> + */
>> +static int extcon_alloc_cables(struct extcon_dev *edev)
>> +{
>> +	int index;
>> +	char *str;
>> +	struct extcon_cable *cable;
>> +
>> +	if (!edev->max_supported)
>> +		return 0;
> 
> 
> Need to check whether edev is NULL or not 
> because make the separate function.
> 
> 	if (!edev && !edev->max_supported)


Instead of previous my comment, need to check it as following:

	if (!edev)
		return -EINVAL;


	if (!edev->max_supported)
		return 0;


> 
>> +
>> +	edev->cables = kcalloc(edev->max_supported,
>> +			       sizeof(struct extcon_cable),
>> +			       GFP_KERNEL);
>> +	if (!edev->cables)
>> +		return -ENOMEM;
>> +
>> +	for (index = 0; index < edev->max_supported; index++) {
>> +		cable = &edev->cables[index];
>> +
>> +		str = kasprintf(GFP_KERNEL, "cable.%d", index);
>> +		if (!str) {
>> +			for (index--; index >= 0; index--) {
>> +				cable = &edev->cables[index];
>> +				kfree(cable->attr_g.name);
>> +			}
>> +
>> +			kfree(edev->cables);
>> +			return -ENOMEM;
>> +		}
>> +
>> +		cable->edev = edev;
>> +		cable->cable_index = index;
>> +		cable->attrs[0] = &cable->attr_name.attr;
>> +		cable->attrs[1] = &cable->attr_state.attr;
>> +		cable->attrs[2] = NULL;
>> +		cable->attr_g.name = str;
>> +		cable->attr_g.attrs = cable->attrs;
>> +
>> +		sysfs_attr_init(&cable->attr_name.attr);
>> +		cable->attr_name.attr.name = "name";
>> +		cable->attr_name.attr.mode = 0444;
>> +		cable->attr_name.show = cable_name_show;
>> +
>> +		sysfs_attr_init(&cable->attr_state.attr);
>> +		cable->attr_state.attr.name = "state";
>> +		cable->attr_state.attr.mode = 0444;
>> +		cable->attr_state.show = cable_state_show;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * extcon_dev_register() - Register an new extcon device
>>   * @edev:	the extcon device to be registered
>> @@ -1117,50 +1174,9 @@ int extcon_dev_register(struct extcon_dev *edev)
>>  	dev_set_name(&edev->dev, "extcon%lu",
>>  			(unsigned long)atomic_inc_return(&edev_no));
>>  
>> -	if (edev->max_supported) {
>> -		char *str;
>> -		struct extcon_cable *cable;
>> -
>> -		edev->cables = kcalloc(edev->max_supported,
>> -				       sizeof(struct extcon_cable),
>> -				       GFP_KERNEL);
>> -		if (!edev->cables) {
>> -			ret = -ENOMEM;
>> -			goto err_sysfs_alloc;
>> -		}
>> -		for (index = 0; index < edev->max_supported; index++) {
>> -			cable = &edev->cables[index];
>> -
>> -			str = kasprintf(GFP_KERNEL, "cable.%d", index);
>> -			if (!str) {
>> -				for (index--; index >= 0; index--) {
>> -					cable = &edev->cables[index];
>> -					kfree(cable->attr_g.name);
>> -				}
>> -				ret = -ENOMEM;
>> -
>> -				goto err_alloc_cables;
>> -			}
>> -
>> -			cable->edev = edev;
>> -			cable->cable_index = index;
>> -			cable->attrs[0] = &cable->attr_name.attr;
>> -			cable->attrs[1] = &cable->attr_state.attr;
>> -			cable->attrs[2] = NULL;
>> -			cable->attr_g.name = str;
>> -			cable->attr_g.attrs = cable->attrs;
>> -
>> -			sysfs_attr_init(&cable->attr_name.attr);
>> -			cable->attr_name.attr.name = "name";
>> -			cable->attr_name.attr.mode = 0444;
>> -			cable->attr_name.show = cable_name_show;
>> -
>> -			sysfs_attr_init(&cable->attr_state.attr);
>> -			cable->attr_state.attr.name = "state";
>> -			cable->attr_state.attr.mode = 0444;
>> -			cable->attr_state.show = cable_state_show;
>> -		}
>> -	}
>> +	ret = extcon_alloc_cables(edev);
>> +	if (ret < 0)
>> +		goto err_alloc_cables;
>>  
>>  	if (edev->max_supported && edev->mutually_exclusive) {
>>  		char *name;
>> @@ -1279,10 +1295,10 @@ int extcon_dev_register(struct extcon_dev *edev)
>>  err_muex:
>>  	for (index = 0; index < edev->max_supported; index++)
>>  		kfree(edev->cables[index].attr_g.name);
>> -err_alloc_cables:
>>  	if (edev->max_supported)
>>  		kfree(edev->cables);
>> -err_sysfs_alloc:
>> +err_alloc_cables:
>> +
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(extcon_dev_register);
> 

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

