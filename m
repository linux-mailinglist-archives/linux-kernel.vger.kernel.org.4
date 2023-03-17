Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E456BF090
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjCQSSe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 14:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCQSSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:18:32 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9654722A2E;
        Fri, 17 Mar 2023 11:18:30 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id er8so12005721edb.0;
        Fri, 17 Mar 2023 11:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679077109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YptXJwRXpxncMnTBG6/8A/xYJX7x56JvCTmg5lsowkU=;
        b=g4WLzOPTa4xZe7iZ/lnD2fcuXHZSFk9cD/KB5OQRRP8bec2XA/qUV54QDiu5mNcxFc
         sOSLlAGqvlUvjIRk+gWQrG9moMlST0R+5/2K6rVoExqbe6Yy/H/92Mmz3FPTbMR1nWaO
         gvAINjIJjptFtqHBB5PXR/7lPeSvg9g8N5ehgssYnOO8V+th0H+MBn+d8mVhuaSfMMmH
         SkQNwZAvAIWqkuPTDJ98YmE0Yjp9L5mBmtZV/1q3m5nhL/nMOGUquWiw6tG0kE3JKpOl
         fDfAhcW3VqsxGvZP9kpHS+lhKCYvlDJx+4aCzjIdsA2KG+kdonO/8wqc4CaxUi3p+XRQ
         YMzQ==
X-Gm-Message-State: AO0yUKVVBU/+tTcP2c2a1wL9MVoUrPZrXqVJ7LAzg7VbVRT702D2Zeo3
        D7UAZ5/PbOZ3RgBYiDG6xMsKbawb/63zlKmgfe8=
X-Google-Smtp-Source: AK7set8KLBjWewwqHlLO1d/RXgdglkGUMPq0AkZvo0bq44vDz+e18Q7ZzXCCp1wIrdN06JC7qMascKIjLBtk5eKzh84=
X-Received: by 2002:a50:a406:0:b0:4fb:c8e3:1ae2 with SMTP id
 u6-20020a50a406000000b004fbc8e31ae2mr1006016edb.3.1679077109137; Fri, 17 Mar
 2023 11:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
 <20230307133735.90772-4-daniel.lezcano@linaro.org> <ca4e9523-0d12-c29f-6de1-365d1713ec84@linaro.org>
 <CAJZ5v0iYk7mC0K7Tsv7Dh9N=dQW151YhVcphvLm7T2vEY10tMA@mail.gmail.com> <b0e158d4-5522-821f-d3e5-abc6f77509cb@linaro.org>
In-Reply-To: <b0e158d4-5522-821f-d3e5-abc6f77509cb@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Mar 2023 19:18:18 +0100
Message-ID: <CAJZ5v0g7Smzd5sOJ9K1sSF73C9sRC-GmDvAEV629+bYOa7F47Q@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] thermal/drivers/intel_menlow: Remove add_one_attribute
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        amitk@kernel.org, Sujith Thomas <sujith.thomas@intel.com>,
        "open list:INTEL MENLOW THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 1:35 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/03/2023 13:26, Rafael J. Wysocki wrote:
> > On Mon, Mar 13, 2023 at 11:55 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >>
> >> Hi,
> >>
> >> is this code removal acceptable ?
> >
> > I'll let you know later this week.
>
> Great, thank you

So it would be acceptable if it had no users, but that's somewhat hard
to establish.

As I wrote in a reply to the RFC version of this, I'd rather make
these attributes depend on a Kconfig option or a module parameter
before removing them completely.

> >> On 07/03/2023 14:37, Daniel Lezcano wrote:
> >>> The driver hooks the thermal framework sysfs to add some driver
> >>> specific information. A debatable approach as that may belong the
> >>> device sysfs directory, not the thermal zone directory.
> >>>
> >>> As the driver is accessing the thermal internals, we should provide at
> >>> least an API to the thermal framework to add an attribute to the
> >>> existing sysfs thermal zone entry.
> >>>
> >>> Before doing that and given the age of the driver (2008) may be it is
> >>> worth to double check if these attributes are really needed. So my
> >>> first proposal is to remove them if that does not hurt.
> >>>
> >>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>
> >>
> >>
> >>> ---
> >>>    drivers/thermal/intel/intel_menlow.c | 193 ---------------------------
> >>>    1 file changed, 193 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
> >>> index 5a6ad0552311..5a9738a93083 100644
> >>> --- a/drivers/thermal/intel/intel_menlow.c
> >>> +++ b/drivers/thermal/intel/intel_menlow.c
> >>> @@ -230,174 +230,8 @@ struct intel_menlow_attribute {
> >>>    static LIST_HEAD(intel_menlow_attr_list);
> >>>    static DEFINE_MUTEX(intel_menlow_attr_lock);
> >>>
> >>> -/*
> >>> - * sensor_get_auxtrip - get the current auxtrip value from sensor
> >>> - * @handle: Object handle
> >>> - * @index : GET_AUX1/GET_AUX0
> >>> - * @value : The address will be fill by the value
> >>> - */
> >>> -static int sensor_get_auxtrip(acpi_handle handle, int index,
> >>> -                                                     unsigned long long *value)
> >>> -{
> >>> -     acpi_status status;
> >>> -
> >>> -     if ((index != 0 && index != 1) || !value)
> >>> -             return -EINVAL;
> >>> -
> >>> -     status = acpi_evaluate_integer(handle, index ? GET_AUX1 : GET_AUX0,
> >>> -                                    NULL, value);
> >>> -     if (ACPI_FAILURE(status))
> >>> -             return -EIO;
> >>> -
> >>> -     return 0;
> >>> -}
> >>> -
> >>> -/*
> >>> - * sensor_set_auxtrip - set the new auxtrip value to sensor
> >>> - * @handle: Object handle
> >>> - * @index : GET_AUX1/GET_AUX0
> >>> - * @value : The value will be set
> >>> - */
> >>> -static int sensor_set_auxtrip(acpi_handle handle, int index, int value)
> >>> -{
> >>> -     acpi_status status;
> >>> -     union acpi_object arg = {
> >>> -             ACPI_TYPE_INTEGER
> >>> -     };
> >>> -     struct acpi_object_list args = {
> >>> -             1, &arg
> >>> -     };
> >>> -     unsigned long long temp;
> >>> -
> >>> -     if (index != 0 && index != 1)
> >>> -             return -EINVAL;
> >>> -
> >>> -     status = acpi_evaluate_integer(handle, index ? GET_AUX0 : GET_AUX1,
> >>> -                                    NULL, &temp);
> >>> -     if (ACPI_FAILURE(status))
> >>> -             return -EIO;
> >>> -     if ((index && value < temp) || (!index && value > temp))
> >>> -             return -EINVAL;
> >>> -
> >>> -     arg.integer.value = value;
> >>> -     status = acpi_evaluate_integer(handle, index ? SET_AUX1 : SET_AUX0,
> >>> -                                    &args, &temp);
> >>> -     if (ACPI_FAILURE(status))
> >>> -             return -EIO;
> >>> -
> >>> -     /* do we need to check the return value of SAX0/SAX1 ? */
> >>> -
> >>> -     return 0;
> >>> -}
> >>> -
> >>> -#define to_intel_menlow_attr(_attr)  \
> >>> -     container_of(_attr, struct intel_menlow_attribute, attr)
> >>> -
> >>> -static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
> >>> -                     char *buf, int idx)
> >>> -{
> >>> -     struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
> >>> -     unsigned long long value;
> >>> -     int result;
> >>> -
> >>> -     result = sensor_get_auxtrip(attr->handle, idx, &value);
> >>> -     if (result)
> >>> -             return result;
> >>> -
> >>> -     return sprintf(buf, "%lu", deci_kelvin_to_celsius(value));
> >>> -}
> >>> -
> >>> -static ssize_t aux0_show(struct device *dev,
> >>> -                      struct device_attribute *dev_attr, char *buf)
> >>> -{
> >>> -     return aux_show(dev, dev_attr, buf, 0);
> >>> -}
> >>> -
> >>> -static ssize_t aux1_show(struct device *dev,
> >>> -                      struct device_attribute *dev_attr, char *buf)
> >>> -{
> >>> -     return aux_show(dev, dev_attr, buf, 1);
> >>> -}
> >>> -
> >>> -static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
> >>> -                      const char *buf, size_t count, int idx)
> >>> -{
> >>> -     struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
> >>> -     int value;
> >>> -     int result;
> >>> -
> >>> -     /*Sanity check; should be a positive integer */
> >>> -     if (!sscanf(buf, "%d", &value))
> >>> -             return -EINVAL;
> >>> -
> >>> -     if (value < 0)
> >>> -             return -EINVAL;
> >>> -
> >>> -     result = sensor_set_auxtrip(attr->handle, idx,
> >>> -                                 celsius_to_deci_kelvin(value));
> >>> -     return result ? result : count;
> >>> -}
> >>> -
> >>> -static ssize_t aux0_store(struct device *dev,
> >>> -                       struct device_attribute *dev_attr,
> >>> -                       const char *buf, size_t count)
> >>> -{
> >>> -     return aux_store(dev, dev_attr, buf, count, 0);
> >>> -}
> >>> -
> >>> -static ssize_t aux1_store(struct device *dev,
> >>> -                       struct device_attribute *dev_attr,
> >>> -                       const char *buf, size_t count)
> >>> -{
> >>> -     return aux_store(dev, dev_attr, buf, count, 1);
> >>> -}
> >>> -
> >>>    /* BIOS can enable/disable the thermal user application in dabney platform */
> >>>    #define BIOS_ENABLED "\\_TZ.GSTS"
> >>> -static ssize_t bios_enabled_show(struct device *dev,
> >>> -                              struct device_attribute *attr, char *buf)
> >>> -{
> >>> -     acpi_status status;
> >>> -     unsigned long long bios_enabled;
> >>> -
> >>> -     status = acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL, &bios_enabled);
> >>> -     if (ACPI_FAILURE(status))
> >>> -             return -ENODEV;
> >>> -
> >>> -     return sprintf(buf, "%s\n", bios_enabled ? "enabled" : "disabled");
> >>> -}
> >>> -
> >>> -static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
> >>> -                                       void *store, struct device *dev,
> >>> -                                       acpi_handle handle)
> >>> -{
> >>> -     struct intel_menlow_attribute *attr;
> >>> -     int result;
> >>> -
> >>> -     attr = kzalloc(sizeof(struct intel_menlow_attribute), GFP_KERNEL);
> >>> -     if (!attr)
> >>> -             return -ENOMEM;
> >>> -
> >>> -     sysfs_attr_init(&attr->attr.attr); /* That is consistent naming :D */
> >>> -     attr->attr.attr.name = name;
> >>> -     attr->attr.attr.mode = mode;
> >>> -     attr->attr.show = show;
> >>> -     attr->attr.store = store;
> >>> -     attr->device = dev;
> >>> -     attr->handle = handle;
> >>> -
> >>> -     result = device_create_file(dev, &attr->attr);
> >>> -     if (result) {
> >>> -             kfree(attr);
> >>> -             return result;
> >>> -     }
> >>> -
> >>> -     mutex_lock(&intel_menlow_attr_lock);
> >>> -     list_add_tail(&attr->node, &intel_menlow_attr_list);
> >>> -     mutex_unlock(&intel_menlow_attr_lock);
> >>> -
> >>> -     return 0;
> >>> -}
> >>>
> >>>    static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
> >>>                                                void *context, void **rv)
> >>> @@ -420,12 +254,6 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
> >>>        if (ACPI_FAILURE(status))
> >>>                return (status == AE_NOT_FOUND) ? AE_OK : status;
> >>>
> >>> -     result = intel_menlow_add_one_attribute("aux0", 0644,
> >>> -                                             aux0_show, aux0_store,
> >>> -                                             &thermal->device, handle);
> >>> -     if (result)
> >>> -             return AE_ERROR;
> >>> -
> >>>        status = acpi_get_handle(handle, GET_AUX1, &dummy);
> >>>        if (ACPI_FAILURE(status))
> >>>                goto aux1_not_found;
> >>> @@ -434,27 +262,6 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
> >>>        if (ACPI_FAILURE(status))
> >>>                goto aux1_not_found;
> >>>
> >>> -     result = intel_menlow_add_one_attribute("aux1", 0644,
> >>> -                                             aux1_show, aux1_store,
> >>> -                                             &thermal->device, handle);
> >>> -     if (result) {
> >>> -             intel_menlow_unregister_sensor();
> >>> -             return AE_ERROR;
> >>> -     }
> >>> -
> >>> -     /*
> >>> -      * create the "dabney_enabled" attribute which means the user app
> >>> -      * should be loaded or not
> >>> -      */
> >>> -
> >>> -     result = intel_menlow_add_one_attribute("bios_enabled", 0444,
> >>> -                                             bios_enabled_show, NULL,
> >>> -                                             &thermal->device, handle);
> >>> -     if (result) {
> >>> -             intel_menlow_unregister_sensor();
> >>> -             return AE_ERROR;
> >>> -     }
> >>> -
> >>>        return AE_OK;
> >>>
> >>>     aux1_not_found:
> >>
> >> --
> >> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
