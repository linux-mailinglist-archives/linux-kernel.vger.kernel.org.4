Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E1B607429
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiJUJfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJUJfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:35:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66C5187DCE;
        Fri, 21 Oct 2022 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666344902;
        bh=iwiQ6dtbZMd6P2Wdtt4KO30QQTINxxu0iK5jUadx5B8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bsRzn9LyTs5Lj+EVkw8ZcnshNG8GjixWpJQ+/MFpksfPNyPHCmgPyYiWTF64XkPQu
         TPNpFehB5PK6AzDUnGaUOvFS0W9BMQMNMxFFNIaWPhCMfwQnmV1LiM3hvzVS4m6H2B
         2c9CqxaBlKw5K5RDShx8D0UF5C7kUzrFW0egCxss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.16.10.126] ([141.76.176.167]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNpH-1pXUSZ07hd-00lpDi; Fri, 21
 Oct 2022 11:35:02 +0200
Subject: Re: [PATCH v2 2/2] platform/x86: dell: Add new dell-wmi-ddv driver
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     markgross@kernel.org, rafael@kernel.org, lenb@kernel.org,
        hmh@hmh.eng.br, matan@svgalib.org, corentin.chary@gmail.com,
        jeremy@system76.com, productdev@system76.com,
        mario.limonciello@amd.com, pobrn@protonmail.com,
        coproscefalo@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220927204521.601887-1-W_Armin@gmx.de>
 <20220927204521.601887-3-W_Armin@gmx.de>
 <YzQmQw0hEwzXV/iz@smile.fi.intel.com>
 <34774c9d-1210-0015-f78e-97fdf717480c@gmx.de>
 <YzVqbSBHm3OrjIaQ@smile.fi.intel.com>
 <bf84f13d-f76a-c0ac-8a1f-f4e1b55e6f51@redhat.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <11964cd1-94b5-dc6a-a6c9-7fd5fe335ed4@gmx.de>
Date:   Fri, 21 Oct 2022 11:34:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bf84f13d-f76a-c0ac-8a1f-f4e1b55e6f51@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:X4pEoToi4QT7HuAczkuIfzBTEdr5/qhm3nE5Pi+nOj4pzMhjYCO
 1HI8G2L0Q58QWEknTr3HL0zMRi9uFy7i5HHRGdu4LM+gybgxhCc28eVvSJEr/xjtqX3F8wN
 kKJ3l9bKuh4xcB0hjaL9KMJXvUObYBeGV6N73MM8paXSWr3Qjh9+pVVd10lluR4SMaJFg30
 Jv6TkJA4ThhK52fhrQMvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Hmq+Ne4wC4=:vzadYy6YPg0iPRTOzPQRAJ
 5dFTqHAwfr0TQTmnCySkD0icSEuwtmZ6pZUYfCPGItQK0OzhyTmUswj7Yt7F9mA2m4kKeuY+s
 pzz7KtCx+wacZw1f1UQggvrdT8TdoI4AihLboEs445kP2N1pdsBCxjz1L1aRGFPwGBDGSDbEj
 2Ff/0SBmJKwxJRxmGDku3qHnr/2jO+Vq9YcGviWd1BuGkvShH1QKvPlO5hlj5Lu6g8f/NLM+d
 Ls+5wR2cosg5s4rDU1U+tMQJmRD6RPXZ6mnP7x9go0LptsBoZPztc5H+fKv2Saqp3nF20PNUh
 bYi242BRmiWhzc2jaJXghYVMXFQuWiM9QifgSKHaZpSgfMQ1HU4gflSj9BGvKF6v4NH0EKjdI
 vPRYS70C9yNroORTJInmdcwq9lCbXL2G4IfEUBZuDbAZDy0GeaykaTImu4jmHIdedtxO3RJl/
 cL/esEUK4NdwfkDnZbj+ysei4vht6/dtCYXTP6vj4qnPvlTdynQmrtIelHJKCHiqpZ0/rzw10
 kNbQKe3KcWNLt3/3wXvmRw0rR7aUqJl0iTnN2jaXoeY5syRlDDj3MadQhhqbJo8CvJCcsvkDb
 gT5uKSH1F7vY+1ClzqkVVqkknD8i8bRDdI9SPv59v4WeFWLmw+Fb43ppb1FOaUJIN/0rOpuQF
 d1RQuHljfUpODJlTfkwOUhngrZ9eyfJk516wpCRtb9dZOZ+hwyV0rCJP3TVpVztrdnGvVO1iL
 zpIZwtcABTKmtz2Yj+6Iu2aTDEB0ep04ySWy1v+3GQHyYPhf6zy53PdWDqP2wu+fflsHgTtL1
 mhs+rorYP82uWu6Ljp75Uh6Az8FlcDpEt+ljTKxi7d6+Xls4nHh+ViUbtPKAJPyD5rHsv0SL7
 ViUAMTqlFo5kZ6Y6wF05jW20YWVygDkajAgzEDE9sxYIeBCP9b8TD2cCW6Po5LWnsf6mu/dLv
 y1nMx28j4R9ocFrOpDZ6jj8wOxppn58WUip1c7tRIRQO38IwQuPlP3gCVe1nnlkNocacvaJN/
 0YqyzOw+6RI9+SliSELeI1b53hHbTcQFP4r5u0pbFqRyoogi4uQcGtYwX66Xn4cxprrf6YvvJ
 bCbNltRcSGaikwAPA/HYEqu4LihGeKMU8FHCZeRinaSyhxwPJbaciyvldhU1jUqbF6VxaiVbw
 YP56fywvy5GkS5kxQxcwQsAXo9VdLPuaidFwqtQbm36WjgBlriePtlmK+03Aio8YUtyppksKz
 UmymwatVgzfbroRp0pSrQxYHvJQz7kH1lK6UasheSFAylHL+CiDGqt8ActlfAEqnj4hEd41Gp
 K32qNM+6kHR6YR2dzVU1tgwWStJTIeatjb/5bKAvUr+PRXSgEwilBkEQ/Sd3xlCFvH/y6nnz7
 oERSAi7yGhEFkXwxlJreJiG4Zk9hG4+eVQvRgiypqu+JQy2mi+fZQDi6HoIVPU5oWeNglSBuG
 zkNFb/d+8Y2kLPH5jwVDBguGKNL5a3Ptx9FmorE+hP4VBtMO/rjs2teONHkZtjrAcXts1wATx
 Q0sykocID5b0n1WcLLk19EJJPH8fnsmTZlmHamYIQ1V0v
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 29.09.22 um 15:12 schrieb Hans de Goede:

> Hi,
>
> On 9/29/22 11:50, Andy Shevchenko wrote:
>> On Wed, Sep 28, 2022 at 10:57:16PM +0200, Armin Wolf wrote:
>>> Am 28.09.22 um 12:47 schrieb Andy Shevchenko:
>>>> On Tue, Sep 27, 2022 at 10:45:21PM +0200, Armin Wolf wrote:
>> ...
>>
>>>>> +static void dell_wmi_ddv_debugfs_init(struct wmi_device *wdev)
>>>> Strictly speaking this should return int (see below).
>>>>
>>>>> +{
>>>>> +	struct dentry *entry;
>>>>> +	char name[64];
>>>>> +Fujitsu Academy
>>>>>
>>>>> +	scnprintf(name, ARRAY_SIZE(name), "%s-%s", DRIVER_NAME, dev_name(&=
wdev->dev));
>>>>> +	entry =3D debugfs_create_dir(name, NULL);
>>>>> +
>>>>> +	debugfs_create_devm_seqfile(&wdev->dev, "fan_sensor_information", =
entry,
>>>>> +				    dell_wmi_ddv_fan_read);
>>>>> +	debugfs_create_devm_seqfile(&wdev->dev, "thermal_sensor_informatio=
n", entry,
>>>>> +				    dell_wmi_ddv_temp_read);
>>>>> +
>>>>> +	devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_debugfs_remove, =
entry);
>>>> return devm...
>>>>
>>>> This is not related to debugfs and there is no rule to avoid checking=
 error
>>>> codes from devm_add_action_or_reset().
>>>>
>>> According to the documentation of debugfs_create_dir(), drivers should=
 work fine if debugfs
>>> initialization fails. Thus the the return value of dell_wmi_ddv_debugf=
s_init() would be ignored
>>> when called, which means that returning an error would serve no purpos=
e.
>>> Additionally, devm_add_action_or_reset() automatically executes the cl=
eanup function if devres
>>> registration fails, so we do not have to care about that.
>> The problem with your code that if devm_ call fails and you ain't stop =
probing
>> the remove-insert module (or unbind-bind) cycle will fail, because of e=
xisting
>> (leaked) debugfs dentries.
> No it won't if the devm_ call fails then it will directly call
> the passed in handler so in this case we can simply continue
> without debugfs entries (which will have been removed by the
> handler). The directly calling of the action handler on
> failure is the whole difference between devm_add_action()
> and devm_add_action_or_reset()
>
> So using it this way in the case of a debugfs init function
> is fine.
>
>>>>> +		.name =3D DRIVER_NAME,
>>>> I would use explicit literal since this is a (semi-) ABI, and having =
it as
>>>> a define feels not fully right.
>>> The driver name is used in two places (init and debugfs), so having a =
define for it
>>> avoids problems in case someone forgets to change both.
>> Which is exactly what we must prevent developer to do. If changing debu=
gfs it
>> mustn't change the driver name, because the latter is ABI, while the fo=
rmer is
>> not.
> Arguably both are not really ABI. Drivers have been renamed in the past
> without issues for userspace.
>
> Regards,
>
> Hans
>
What is the current status of this patch set? If necessary, i can submit a=
n v3 patch set which includes the
patch regarding the minor style fixes. I also tested the driver on my Dell=
 Insprion 3505 for some time, so
i can proof it works.

Armin Wolf

