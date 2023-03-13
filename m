Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B8E6B77A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCMMgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCMMgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:36:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA802384C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:35:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso10860075wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678710929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1h7GOIGxs3iAslzA1gNh3FrOPX1TRnStsyDzIxuwajg=;
        b=OliCQ9ESAeZbjZcIu8SOZobIBaXq5dqC5raS7vf2Sz6eBynaWY2/lU04ZS9jkUyWy+
         KY0FtgSWDjzb98XKvKJ+M6Gxc6ajIfqsuLj/qscYa7B8a6HKPx1hZdWsWTH+TlXPFqXs
         FqWghyD9o3KQz8xdQW22QoOxRESEmTMvw4yC/A7I/3dVg4LZ5cuIkiQTVopzAICZMwNt
         IOqrHPCrsDJaYUpbhFptpeuANe+rXiOUvxBgrCuqEnK8QbEvADRimULsQsxeRaJlTru2
         ZjSHM4fyOTS/TZnDgLJ39sG/Jd0BfqiFCsVZDE4CN3fS50HeJz6j3Wk/35cRBCZZRuDm
         ULiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678710929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1h7GOIGxs3iAslzA1gNh3FrOPX1TRnStsyDzIxuwajg=;
        b=Shg+oewzroX+2e/aPXcn171OhKnalIGnsK8Yr3gCBKbHbAG2Q1Zutljvg/rQsb+25u
         zJUNoBzKe1YUWmjgQ+2YwEkh4UOYGq7PyX+F5tN/bHRtPE9t0eLCANHBsjGC3AcC4Z05
         +cbhqHBerix4hdzeb6MqKHtdPcEfpLlb1NMmYI4+bp6SI8JvVg/PfVmI2pjoocToVJlF
         GU8Hldn27pMaZeiuN3Ia8qjoDefurBMtX3VVKPyXR08faPCOoztLhxGVTKCWNm4JRZ25
         iOw3HrNBb5yum6lk0zdUG8OTRjh75aDphBygRsSPbO4orZGopVpdX03YtQPnP6+QTV2X
         nq/A==
X-Gm-Message-State: AO0yUKULD6HjNg7N0jP4gvXobtTtwh9IUUNCuwW3K9Y373ZzijSRZjut
        MIS2th/tuRt82Wd55J5rekfgkw==
X-Google-Smtp-Source: AK7set+Aa+2Hp+/+ErXyH3V42KCpd/qXrE5E1ZzrrHQuD04UncRYrbMy9W/Lgjnv/1xbOZSO+jWbvw==
X-Received: by 2002:a05:600c:3d11:b0:3e2:6ec:7fbe with SMTP id bh17-20020a05600c3d1100b003e206ec7fbemr9961627wmb.40.1678710929050;
        Mon, 13 Mar 2023 05:35:29 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8522:ca6e:1db4:96c6? ([2a05:6e02:1041:c10:8522:ca6e:1db4:96c6])
        by smtp.googlemail.com with ESMTPSA id t17-20020a05600c451100b003dc434b39c7sm11022411wmo.0.2023.03.13.05.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:35:28 -0700 (PDT)
Message-ID: <b0e158d4-5522-821f-d3e5-abc6f77509cb@linaro.org>
Date:   Mon, 13 Mar 2023 13:35:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 03/11] thermal/drivers/intel_menlow: Remove
 add_one_attribute
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        Sujith Thomas <sujith.thomas@intel.com>,
        "open list:INTEL MENLOW THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
 <20230307133735.90772-4-daniel.lezcano@linaro.org>
 <ca4e9523-0d12-c29f-6de1-365d1713ec84@linaro.org>
 <CAJZ5v0iYk7mC0K7Tsv7Dh9N=dQW151YhVcphvLm7T2vEY10tMA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iYk7mC0K7Tsv7Dh9N=dQW151YhVcphvLm7T2vEY10tMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 13:26, Rafael J. Wysocki wrote:
> On Mon, Mar 13, 2023 at 11:55 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi,
>>
>> is this code removal acceptable ?
> 
> I'll let you know later this week.

Great, thank you


>> On 07/03/2023 14:37, Daniel Lezcano wrote:
>>> The driver hooks the thermal framework sysfs to add some driver
>>> specific information. A debatable approach as that may belong the
>>> device sysfs directory, not the thermal zone directory.
>>>
>>> As the driver is accessing the thermal internals, we should provide at
>>> least an API to the thermal framework to add an attribute to the
>>> existing sysfs thermal zone entry.
>>>
>>> Before doing that and given the age of the driver (2008) may be it is
>>> worth to double check if these attributes are really needed. So my
>>> first proposal is to remove them if that does not hurt.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>>
>>
>>> ---
>>>    drivers/thermal/intel/intel_menlow.c | 193 ---------------------------
>>>    1 file changed, 193 deletions(-)
>>>
>>> diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
>>> index 5a6ad0552311..5a9738a93083 100644
>>> --- a/drivers/thermal/intel/intel_menlow.c
>>> +++ b/drivers/thermal/intel/intel_menlow.c
>>> @@ -230,174 +230,8 @@ struct intel_menlow_attribute {
>>>    static LIST_HEAD(intel_menlow_attr_list);
>>>    static DEFINE_MUTEX(intel_menlow_attr_lock);
>>>
>>> -/*
>>> - * sensor_get_auxtrip - get the current auxtrip value from sensor
>>> - * @handle: Object handle
>>> - * @index : GET_AUX1/GET_AUX0
>>> - * @value : The address will be fill by the value
>>> - */
>>> -static int sensor_get_auxtrip(acpi_handle handle, int index,
>>> -                                                     unsigned long long *value)
>>> -{
>>> -     acpi_status status;
>>> -
>>> -     if ((index != 0 && index != 1) || !value)
>>> -             return -EINVAL;
>>> -
>>> -     status = acpi_evaluate_integer(handle, index ? GET_AUX1 : GET_AUX0,
>>> -                                    NULL, value);
>>> -     if (ACPI_FAILURE(status))
>>> -             return -EIO;
>>> -
>>> -     return 0;
>>> -}
>>> -
>>> -/*
>>> - * sensor_set_auxtrip - set the new auxtrip value to sensor
>>> - * @handle: Object handle
>>> - * @index : GET_AUX1/GET_AUX0
>>> - * @value : The value will be set
>>> - */
>>> -static int sensor_set_auxtrip(acpi_handle handle, int index, int value)
>>> -{
>>> -     acpi_status status;
>>> -     union acpi_object arg = {
>>> -             ACPI_TYPE_INTEGER
>>> -     };
>>> -     struct acpi_object_list args = {
>>> -             1, &arg
>>> -     };
>>> -     unsigned long long temp;
>>> -
>>> -     if (index != 0 && index != 1)
>>> -             return -EINVAL;
>>> -
>>> -     status = acpi_evaluate_integer(handle, index ? GET_AUX0 : GET_AUX1,
>>> -                                    NULL, &temp);
>>> -     if (ACPI_FAILURE(status))
>>> -             return -EIO;
>>> -     if ((index && value < temp) || (!index && value > temp))
>>> -             return -EINVAL;
>>> -
>>> -     arg.integer.value = value;
>>> -     status = acpi_evaluate_integer(handle, index ? SET_AUX1 : SET_AUX0,
>>> -                                    &args, &temp);
>>> -     if (ACPI_FAILURE(status))
>>> -             return -EIO;
>>> -
>>> -     /* do we need to check the return value of SAX0/SAX1 ? */
>>> -
>>> -     return 0;
>>> -}
>>> -
>>> -#define to_intel_menlow_attr(_attr)  \
>>> -     container_of(_attr, struct intel_menlow_attribute, attr)
>>> -
>>> -static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
>>> -                     char *buf, int idx)
>>> -{
>>> -     struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
>>> -     unsigned long long value;
>>> -     int result;
>>> -
>>> -     result = sensor_get_auxtrip(attr->handle, idx, &value);
>>> -     if (result)
>>> -             return result;
>>> -
>>> -     return sprintf(buf, "%lu", deci_kelvin_to_celsius(value));
>>> -}
>>> -
>>> -static ssize_t aux0_show(struct device *dev,
>>> -                      struct device_attribute *dev_attr, char *buf)
>>> -{
>>> -     return aux_show(dev, dev_attr, buf, 0);
>>> -}
>>> -
>>> -static ssize_t aux1_show(struct device *dev,
>>> -                      struct device_attribute *dev_attr, char *buf)
>>> -{
>>> -     return aux_show(dev, dev_attr, buf, 1);
>>> -}
>>> -
>>> -static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
>>> -                      const char *buf, size_t count, int idx)
>>> -{
>>> -     struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
>>> -     int value;
>>> -     int result;
>>> -
>>> -     /*Sanity check; should be a positive integer */
>>> -     if (!sscanf(buf, "%d", &value))
>>> -             return -EINVAL;
>>> -
>>> -     if (value < 0)
>>> -             return -EINVAL;
>>> -
>>> -     result = sensor_set_auxtrip(attr->handle, idx,
>>> -                                 celsius_to_deci_kelvin(value));
>>> -     return result ? result : count;
>>> -}
>>> -
>>> -static ssize_t aux0_store(struct device *dev,
>>> -                       struct device_attribute *dev_attr,
>>> -                       const char *buf, size_t count)
>>> -{
>>> -     return aux_store(dev, dev_attr, buf, count, 0);
>>> -}
>>> -
>>> -static ssize_t aux1_store(struct device *dev,
>>> -                       struct device_attribute *dev_attr,
>>> -                       const char *buf, size_t count)
>>> -{
>>> -     return aux_store(dev, dev_attr, buf, count, 1);
>>> -}
>>> -
>>>    /* BIOS can enable/disable the thermal user application in dabney platform */
>>>    #define BIOS_ENABLED "\\_TZ.GSTS"
>>> -static ssize_t bios_enabled_show(struct device *dev,
>>> -                              struct device_attribute *attr, char *buf)
>>> -{
>>> -     acpi_status status;
>>> -     unsigned long long bios_enabled;
>>> -
>>> -     status = acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL, &bios_enabled);
>>> -     if (ACPI_FAILURE(status))
>>> -             return -ENODEV;
>>> -
>>> -     return sprintf(buf, "%s\n", bios_enabled ? "enabled" : "disabled");
>>> -}
>>> -
>>> -static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
>>> -                                       void *store, struct device *dev,
>>> -                                       acpi_handle handle)
>>> -{
>>> -     struct intel_menlow_attribute *attr;
>>> -     int result;
>>> -
>>> -     attr = kzalloc(sizeof(struct intel_menlow_attribute), GFP_KERNEL);
>>> -     if (!attr)
>>> -             return -ENOMEM;
>>> -
>>> -     sysfs_attr_init(&attr->attr.attr); /* That is consistent naming :D */
>>> -     attr->attr.attr.name = name;
>>> -     attr->attr.attr.mode = mode;
>>> -     attr->attr.show = show;
>>> -     attr->attr.store = store;
>>> -     attr->device = dev;
>>> -     attr->handle = handle;
>>> -
>>> -     result = device_create_file(dev, &attr->attr);
>>> -     if (result) {
>>> -             kfree(attr);
>>> -             return result;
>>> -     }
>>> -
>>> -     mutex_lock(&intel_menlow_attr_lock);
>>> -     list_add_tail(&attr->node, &intel_menlow_attr_list);
>>> -     mutex_unlock(&intel_menlow_attr_lock);
>>> -
>>> -     return 0;
>>> -}
>>>
>>>    static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
>>>                                                void *context, void **rv)
>>> @@ -420,12 +254,6 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
>>>        if (ACPI_FAILURE(status))
>>>                return (status == AE_NOT_FOUND) ? AE_OK : status;
>>>
>>> -     result = intel_menlow_add_one_attribute("aux0", 0644,
>>> -                                             aux0_show, aux0_store,
>>> -                                             &thermal->device, handle);
>>> -     if (result)
>>> -             return AE_ERROR;
>>> -
>>>        status = acpi_get_handle(handle, GET_AUX1, &dummy);
>>>        if (ACPI_FAILURE(status))
>>>                goto aux1_not_found;
>>> @@ -434,27 +262,6 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
>>>        if (ACPI_FAILURE(status))
>>>                goto aux1_not_found;
>>>
>>> -     result = intel_menlow_add_one_attribute("aux1", 0644,
>>> -                                             aux1_show, aux1_store,
>>> -                                             &thermal->device, handle);
>>> -     if (result) {
>>> -             intel_menlow_unregister_sensor();
>>> -             return AE_ERROR;
>>> -     }
>>> -
>>> -     /*
>>> -      * create the "dabney_enabled" attribute which means the user app
>>> -      * should be loaded or not
>>> -      */
>>> -
>>> -     result = intel_menlow_add_one_attribute("bios_enabled", 0444,
>>> -                                             bios_enabled_show, NULL,
>>> -                                             &thermal->device, handle);
>>> -     if (result) {
>>> -             intel_menlow_unregister_sensor();
>>> -             return AE_ERROR;
>>> -     }
>>> -
>>>        return AE_OK;
>>>
>>>     aux1_not_found:
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

