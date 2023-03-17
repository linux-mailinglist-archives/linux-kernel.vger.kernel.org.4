Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0693C6BE8BC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCQL71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCQL7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:59:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AA01C31E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:59:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w9so19426464edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679054354;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfwD9Nb1REU0KVSJdu/g50DFZCw6L5Vuzfju3chbQyk=;
        b=CsjaXHLfgHvl6Aplg33NJHdDHinluv1NRnHOGvTjcBEIs4avQrf8iVZUjjuhvMbFD3
         AgsTLcKbLkv6pzqqNHFq9nojCV3Jn3b3/Ha0AIeoTFdU1b4hzRmd/jKiFaeMhQ3ByQvw
         LgNyEr5m02VqEKdQu13cB0wCz4Z6PXmN4lad0TVFIoHI4pinyxx7vvdYtR38z5NGr+bo
         4w1iTKVoz9Qx0l9ys8IBWOHOwImKgumRIi4z8JTKvrSAFOEU9jzZftrWNyCyfr0PJAnT
         If/P0pqirFAZA11GmVE8Wrvwu/YaV+piqmQ69zwm3mzDzyYIVO9gme9rrEkmiVN510u4
         lAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679054354;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfwD9Nb1REU0KVSJdu/g50DFZCw6L5Vuzfju3chbQyk=;
        b=Gaos2Sj6JgDu225lOSxekzOvsaSE7gchRTw/j1rFLW9P9EH9Uw/NMHssixZ3ufFcvc
         iB9LPPBFrkOZnlj7Spo7jsNwI2bTiLmUS04W3xqiDAbTGmSCuHX4SdqwfN3bvMLq9hWF
         g84daPGlbOarwDUVyB3Hl9gr3/cp7NRAvOniDn/FX00mWwhYc4bjG44toA+57EeIAZfn
         4zZXxVw69Y1CiZ/duwhVvOgK+FGe7ENHr03LFWmpU2YIbLtuMTfu+Zj3G5AgjPdXXvx8
         khgx0KFywIJeCdcIaS960G/40cSVlY0NLsA0r7szTm550CVmADES2HuhSPxjNUNLyZ7Q
         d7+A==
X-Gm-Message-State: AO0yUKUrN72vpRLuXS+dIqqyrTS+k0rggda+AZlcIeyJWZYePz1dUpix
        ynl3Wv/3IHOMbAmJ7ggbP3w=
X-Google-Smtp-Source: AK7set/6CgHSZssxMo7MY49h5ZHgg9R0ZJwgR3dFinlfLu9c3UGeJmBFRRQFPT6ZjYjutZATRtqT1Q==
X-Received: by 2002:a17:906:2f07:b0:884:3707:bd83 with SMTP id v7-20020a1709062f0700b008843707bd83mr12877994eji.69.1679054354189;
        Fri, 17 Mar 2023 04:59:14 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c5b8:6200:19d2:4c04:290d:a1ea? (dynamic-2a01-0c23-c5b8-6200-19d2-4c04-290d-a1ea.c23.pool.telefonica.de. [2a01:c23:c5b8:6200:19d2:4c04:290d:a1ea])
        by smtp.googlemail.com with ESMTPSA id mj4-20020a170906af8400b008ca8b62cda6sm909987ejb.177.2023.03.17.04.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 04:59:13 -0700 (PDT)
Message-ID: <9d24dc05-3056-0cdb-025f-73123486db65@gmail.com>
Date:   Fri, 17 Mar 2023 12:59:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <d667b435-bf4c-ee7d-2da8-559354124578@gmail.com>
 <ZBP14wghbJPCnAFJ@kroah.com> <39e60d57-60f1-d706-d922-0411252d4567@gmail.com>
 <ZBRR35SVZeP652Z1@kroah.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] base: soc: set machine name in soc_device_register if
 empty
In-Reply-To: <ZBRR35SVZeP652Z1@kroah.com>
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

On 17.03.2023 12:41, Greg Kroah-Hartman wrote:
> On Fri, Mar 17, 2023 at 10:25:50AM +0100, Heiner Kallweit wrote:
>> On 17.03.2023 06:08, Greg Kroah-Hartman wrote:
>>> On Thu, Mar 16, 2023 at 09:35:59PM +0100, Heiner Kallweit wrote:
>>>> Several SoC drivers use the same of-based mechanism to populate the machine
>>>> name. Therefore move this to the core and try to populate the machine name
>>>> in soc_device_register if it's not set yet.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  drivers/base/soc.c | 15 +++++++++++++++
>>>>  1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
>>>> index 0fb1d4ab9..8dec5228f 100644
>>>> --- a/drivers/base/soc.c
>>>> +++ b/drivers/base/soc.c
>>>> @@ -7,6 +7,7 @@
>>>>  
>>>>  #include <linux/sysfs.h>
>>>>  #include <linux/init.h>
>>>> +#include <linux/of.h>
>>>>  #include <linux/stat.h>
>>>>  #include <linux/slab.h>
>>>>  #include <linux/idr.h>
>>>> @@ -110,6 +111,18 @@ static void soc_release(struct device *dev)
>>>>  	kfree(soc_dev);
>>>>  }
>>>>  
>>>> +static void soc_device_set_machine(struct soc_device_attribute *soc_dev_attr)
>>>> +{
>>>> +	struct device_node *np;
>>>> +
>>>> +	if (soc_dev_attr->machine)
>>>> +		return;
>>>> +
>>>> +	np = of_find_node_by_path("/");
>>>> +	of_property_read_string(np, "model", &soc_dev_attr->machine);
>>>> +	of_node_put(np);
>>>> +}
>>>> +
>>>>  static struct soc_device_attribute *early_soc_dev_attr;
>>>>  
>>>>  struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
>>>> @@ -118,6 +131,8 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
>>>>  	const struct attribute_group **soc_attr_groups;
>>>>  	int ret;
>>>>  
>>>> +	soc_device_set_machine(soc_dev_attr);
>>>> +
>>>
>>> Does this mean some SoC drivers should also be changed at the same time
>>> if they are trying to do this?
>>>
>> The then duplicated code can be removed from SoC drivers afterwards.
>> There's no need to do it at the same time.
>> This change just adds a fallback in case the SoC driver doesn't set "machine".
>> Means if a SoC driver populates machine differently, then this is respected
>> and not overwritten.
> 
> Please send this as a patch series that add this, and then removes this
> code from the SoC drivers so we can verify that it is all working
> properly.
> 
OK, I'll make it a series incl. one use case where I have the hw to test.

>>> And is "model" the correct of property for this?  I thought that devices
>>> also had "model" as a valid entry, is this documented somewhere in the
>>> DTS schema that I couldn't find?
>>>
>>
>> "model" is used by basically all SoC drivers for this purpose, a quick grep reveals:
>>
>> drivers/soc/samsung/exynos-chipid.c:    of_property_read_string(root, "model", &soc_dev_attr->machine);
>> drivers/soc/fsl/guts.c: if (of_property_read_string(of_root, "model", &machine))
>> drivers/soc/amlogic/meson-mx-socinfo.c: of_property_read_string(np, "model", &soc_dev_attr->machine);
>> drivers/soc/amlogic/meson-gx-socinfo.c: of_property_read_string(np, "model", &soc_dev_attr->machine);
>> drivers/soc/aspeed/aspeed-socinfo.c:    of_property_read_string(np, "model", &machine);
>> drivers/soc/ti/k3-socinfo.c:    of_property_read_string(node, "model", &soc_dev_attr->machine);
>> drivers/soc/loongson/loongson2_guts.c:  if (of_property_read_string(root, "model", &machine))
>> drivers/soc/renesas/renesas-soc.c:      of_property_read_string(np, "model", &soc_dev_attr->machine);
>> drivers/soc/imx/soc-imx.c:      ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
>> drivers/soc/imx/soc-imx8m.c:    ret = of_property_read_string(of_root, "model", &soc_dev_attr->machine);
>>
>> Some don't set machine at all.
> 
> So will this break systems that were not previously doing this by
> showing an odd value?
> 
This change may populate "machine" in cases where "machine" isn't populated
currently. AFAICS the only impact is that this value is exposed via sysfs.
Odd values I'd expect only if the "model" property in DTS is odd.
Not sure whether there's any such case, this would need to be fixed
in the DTS.

> thanks,
> 
> greg k-h

