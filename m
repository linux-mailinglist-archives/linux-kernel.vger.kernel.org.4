Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5041A5EE6E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiI1U5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI1U5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:57:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E0E5F20A;
        Wed, 28 Sep 2022 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664398638;
        bh=CFph/fnZBnA8ilu2HLIUiJ/GqqCUZHdkKGi61xNZqsI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JHSkelQ4tL/Rr6l0HG4iLUUB93THsxkY13mrjURA25L0ZjRisUgEwwzEUEpXctHCH
         41ZhChan10bC6rT7kmaKKMyO0KKdJvYZLOWKVcut8Z3ZmYMJ5TDNk9iWrrroRG3oai
         Ex382T0K3yR0t+1JfM8cvNkgty1VR9FbQuwk2sU4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1pH7kL3fcm-014BjN; Wed, 28
 Sep 2022 22:57:18 +0200
Subject: Re: [PATCH v2 2/2] platform/x86: dell: Add new dell-wmi-ddv driver
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, rafael@kernel.org,
        lenb@kernel.org, hmh@hmh.eng.br, matan@svgalib.org,
        corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220927204521.601887-1-W_Armin@gmx.de>
 <20220927204521.601887-3-W_Armin@gmx.de>
 <YzQmQw0hEwzXV/iz@smile.fi.intel.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <34774c9d-1210-0015-f78e-97fdf717480c@gmx.de>
Date:   Wed, 28 Sep 2022 22:57:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YzQmQw0hEwzXV/iz@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:5EN9kv8yQUVWjzFY1V9LZveD8YCFxumwS5eYHwGrVDGhA31aeoJ
 XhczMGYhrq+opU8rtD5tcLCaih461gTvCsf4ZR+3e5hCuFDAmAXAbac/ojXOiE+Srr2BJlJ
 E3i8hjQ0kikBjHJEbwj8ZtDLkRWuFk1sIanQyg9oO3dFyzMwHKE7ppUMpsfckOulp7hzBFN
 VM3PmBXE4gfnfksbnnfBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gpeOdQQ7lTE=:EbSR4aypockO+7OcGx4zYu
 4jB6VSUuKxUEewTFmtKjLXwtBYiGB5/h0J7nI3NbNtS4//QKCdEgLbuWhu05b+p2WH0VtUrJf
 NCRxiokLVqHwbHbiA2cLM9lSOUCIrqFNg7JksIktzZPgc3d6xCb7ygw/+piwEK+verhsoZKwP
 za0uyh/DlHIGUTAjtLJdBZXd/Y8JRx1ncKJYWH6G7r/AqDHKMmAtC7YPf6X2WTTdI5s6yFKbg
 +/8nLaR5e2qOnc8eG6T3lk19x/cpQPCgs389QleqptE2uvFnsbNAYVRCnssv+oCKFGgCPvYc0
 s3tcrJjTIlZPcm5x/8DjMu/45djYuvMaGmdaRsAjk6RKgNu4K6mqTF3E7UO6sYAGp1ONNy3/6
 QEoj6ppUbhZSWr8pKvSO3TgGbsUFCCfUfnJgerMIFeWNd/7KosYXvNmrVBFxmPS5vFm0yC9cy
 OAruoU+Gq23nKOELQaARV1fOQP2mP4eIOVhT6HLZKBVXmq4a/t+ehDDXcN7odBc/ezYvB2Cp6
 6vINAgtQ/tsqHv4YKhn0Ms9S0Ku7VDd/wlORYsHnjxa3UMzWef0VbTANtdZ0tjNmiZkX2ZECe
 K5Yx3cnj+bkk7uK/3NheKWwpEEdYhIraN5fLSCBsLH3GkA+bF2t7qbqVFRGmUS141tKmx5uFQ
 /A12XaIgcKGBkCkxHn8TesPNNbk+pT7/jIdYGgsIZz6XpMaEyOd2lEwyGcdn3P9yTXpn6rzGh
 0pZ8ZKI4XM3G7uF9i4UjXWZJDShJvBgjmLX3dvACzi/I5at3uSBM84xfmDt4R9pMHGs8v/xCY
 IKgsURzy9otrQW067QbYUshF6KSjO8BBcpLrht98q5PkMKjmoli8kPzR7Vzkpavsbes/t2cbA
 GnP440edWd9gl/OyEC5wljQAKp5NAOH2K6hb9LBzQ8AT5kxqlquGtQ9ccdNzuYHM2l7xtR0GN
 fj2AIoRUBZVlqjUIwCcEpmpHxJbZ1YwUsafbe0M1Q6WuANDkMjpY2NydUNRzb4uJSmOo8Am/s
 uHUMaV5KYBZhQMSHB0DV/Ng2/b5tr0jG+Kszx0b86JFEyy+EOb5a46Fxq8iFDU9eSON3jmBYI
 KEHriN9Xc29+chMM3/qRYrEWwnLjskFyRvc1u/ArjNMP8Va2HdDPlcGH0+DwxNZybbn0evPcV
 ydvlgt8RGyh+L53nj36auyaXev
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.09.22 um 12:47 schrieb Andy Shevchenko:

> On Tue, Sep 27, 2022 at 10:45:21PM +0200, Armin Wolf wrote:
>> The dell-wmi-ddv driver adds support for reading
>> the current temperature and ePPID of ACPI batteries
>> on supported Dell machines.
>>
>> Since the WMI interface used by this driver does not
>> do any input validation and thus cannot be used for probing,
>> the driver depends on the ACPI battery extension machanism
>> to discover batteries.
>>
>> The driver also supports a debugfs interface for retrieving
>> buffers containing fan and thermal sensor information.
>> Since the meaing of the content of those buffers is currently
>> unknown, the interface is meant for reverse-engineering and
>> will likely be replaced with an hwmon interface once the
>> meaning has been understood.
>>
>> The driver was tested on a Dell Inspiron 3505.
> ...
>
>> +config DELL_WMI_DDV
>> +	tristate "Dell WMI sensors Support"
>> +	default m
> Why? (Imagine I have Dell, but old machine)
>
> (And yes, I see that other Kconfig options are using it, but we shall avoid
>   cargo cult and each default choice like this has to be explained at least.)
>
> ...
>
>> + * dell-wmi-ddv.c -- Linux driver for WMI sensor information on Dell notebooks.
> Please, remove file name from the file. This will be an additional burden in
> the future in case it will be renamed.
>
> ...
>
>> +#include <acpi/battery.h>
> Is it required to be the first? Otherwise it seems ACPI specific to me and the
> general rule is to put inclusions from generic towards custom. I.o.w. can you
> move it after linux/wmi.h with a blank line in between?
>
>> +#include <linux/acpi.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kstrtox.h>
>> +#include <linux/math.h>
>> +#include <linux/module.h>
>> +#include <linux/limits.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/wmi.h>
> ...
>
>> +struct dell_wmi_ddv_data {
>> +	struct acpi_battery_hook hook;
>> +	struct device_attribute temp_attr, eppid_attr;
> It's hard to read and easy to miss that the data type has two members here.
> Please, put one member per one line.
>
>> +	struct wmi_device *wdev;
>> +};
> ...
>
>> +	if (obj->type != type) {
>> +		kfree(obj);
>> +		return -EIO;
> EINVAL?

In my opinion, EINVAL should be returned if the parameters are invalid.
In this case however, the error comes from the wmi device returning invalid
data, which would be represented better with EIO.

>> +	}
> ...
>
>> +	kfree(obj);
> I'm wondering what is the best to use in the drivers:
>   1) kfree()
>   2) acpi_os_free()
>   3) ACPI_FREE()
>
> ?
>
> ...
>
>> +static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *index)
>> +{
>> +	const char *uid_str = acpi_device_uid(acpi_dev);
>> +
>> +	if (!uid_str)
>> +		return -ENODEV;
> It will be better for maintaining to have
>
> 	const char *uid_str...;
>
> 	uid_str = ...
> 	if (!uid_str)
> 		...
>
>> +	return kstrtou32(uid_str, 10, index);
>> +}
> ...
>
>> +	/* Return 0 instead of error to avoid being unloaded */
>> +	ret = dell_wmi_ddv_battery_index(to_acpi_device(battery->dev.parent), &index);
>> +	if (ret < 0)
>> +		return 0;
> How index is used?
>
> ...
>
>> +	ret = device_create_file(&battery->dev, &data->temp_attr);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = device_create_file(&battery->dev, &data->eppid_attr);
>> +	if (ret < 0) {
>> +		device_remove_file(&battery->dev, &data->temp_attr);
>> +
>> +		return ret;
>> +	}
> Why dev_groups member can't be utilized?
>
> ...
>
>> +static void dell_wmi_ddv_debugfs_init(struct wmi_device *wdev)
> Strictly speaking this should return int (see below).
>
>> +{
>> +	struct dentry *entry;
>> +	char name[64];
>> +
>> +	scnprintf(name, ARRAY_SIZE(name), "%s-%s", DRIVER_NAME, dev_name(&wdev->dev));
>> +	entry = debugfs_create_dir(name, NULL);
>> +
>> +	debugfs_create_devm_seqfile(&wdev->dev, "fan_sensor_information", entry,
>> +				    dell_wmi_ddv_fan_read);
>> +	debugfs_create_devm_seqfile(&wdev->dev, "thermal_sensor_information", entry,
>> +				    dell_wmi_ddv_temp_read);
>> +
>> +	devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_debugfs_remove, entry);
> return devm...
>
> This is not related to debugfs and there is no rule to avoid checking error
> codes from devm_add_action_or_reset().
>
According to the documentation of debugfs_create_dir(), drivers should work fine if debugfs
initialization fails. Thus the the return value of dell_wmi_ddv_debugfs_init() would be ignored
when called, which means that returning an error would serve no purpose.
Additionally, devm_add_action_or_reset() automatically executes the cleanup function if devres
registration fails, so we do not have to care about that.

>> +}
> ...
>
>> +static struct wmi_driver dell_wmi_ddv_driver = {
>> +	.driver = {
>> +		.name = DRIVER_NAME,
> I would use explicit literal since this is a (semi-) ABI, and having it as
> a define feels not fully right.

The driver name is used in two places (init and debugfs), so having a define for it
avoids problems in case someone forgets to change both.

Armin Wolf

>> +	},
>> +	.id_table = dell_wmi_ddv_id_table,
>> +	.probe = dell_wmi_ddv_probe,
>> +};
