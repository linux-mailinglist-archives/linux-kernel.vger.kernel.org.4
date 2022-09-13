Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC0C5B78C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiIMRsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiIMRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:48:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB846266E;
        Tue, 13 Sep 2022 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663087503;
        bh=jBwficGryDBYoZ+eFIh2ke1IjpQ1mDZoKa0/4u6YIs0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cp7Obo5CYd24dk1TOmt+Wkp+4F90x+sdJGLT5L7663W1z6Z1CmXDybSG5WFB9lYaT
         L72pDy24Ydo3zBMb6qFxEMWA5DkQYd1OUAJGfAkEoQZQV+Pg0rRMxnR7c/mOc/4Rpn
         zLQER8qwRpdTcKitQNCT7Q+GTmN1df3NIzwVjG08=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2aD-1p0IS82yut-00kB5N; Tue, 13
 Sep 2022 18:45:03 +0200
Subject: Re: [PATCH 5/5] platform/x86: dell: Add new dell-wmi-ddv driver
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "hmh@hmh.eng.br" <hmh@hmh.eng.br>,
        "matan@svgalib.org" <matan@svgalib.org>,
        "corentin.chary@gmail.com" <corentin.chary@gmail.com>,
        "jeremy@system76.com" <jeremy@system76.com>,
        "productdev@system76.com" <productdev@system76.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-6-W_Armin@gmx.de>
 <b1b794b4-f6c3-7697-5d5a-b811809a9313@infradead.org>
 <2aae0ae9-9608-675a-ec0c-6e7526e57363@gmx.de>
 <MN0PR12MB6101CE9055DC152A6E96B2EDE2479@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <9e603bfc-697b-2570-6f9e-f82ce109cd6e@gmx.de>
Date:   Tue, 13 Sep 2022 18:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <MN0PR12MB6101CE9055DC152A6E96B2EDE2479@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:zTfD3ssnDkGcum1yD24gglWAs89Pvs7oHPLEr1di1BTxisAeUmN
 9o3b2O1UnR8pW4719aLtz0LicHewgS9weI/sAD4VvUh5pIrY6E/vBodjQfLOUDXdNDUDKit
 VA+WD08DTLcc0AFuLrIu0PQyyepLal+wpx78VTPnSbcXurFl8JP0ekjdGAgdASy001he1i8
 1dPnxsH4tHPCpV11hmCPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pKZfZPA/e6Q=:VsgN4m/wQ4pbvJA/2QSVSX
 dMIeyYd7BoTaj3Yew8IF69cMN3s4AE+obaLeduF2TYA7dRGcPzUm0cZJgf0kEHYYjDXkThl3h
 TpYRiSj4Q5ltZ2xsSe+jvm5WuLGXls4ELflCB4BXzqu2LZhOAaDtwapmBkyVVhf5V1lTZ/DHF
 1KNwvOtv+vaBq3wFUl2HJ86GnH7FQ97vp/EDqxCL22q3J2yzqVUDlGIDKdguxaID7UpfL+iUh
 CO/Lk3FREPHRDvNm/SX6U54vVZIeMwH1U6NBHN6jYV95+K08D1prTzoqb11ohHPDoEHLXzGGn
 VgSO24EvVyvRc68mogSrgilMSewN52zkmHk2ijH9e29EaCRqQzfOqob3D37IAlhBuDxl6t8jc
 D2CTv/1i4T5+QgmZ+4XNHxeqOsPMRAGAHV8b/DOOa/GxxGBgUaydNtiPstFBBEPHHM0dNvA09
 6t5vO0AF9C2GYrii+OMApgbKe+V/p/I8cVudC7UpGBgSVPpo0+mMEfpnSvK/cc/ERGykkFJxU
 wDBS0Z3a7BEK0tMCUL1bOUp459wqOkhZuNpgByv2crCHJs13e3wZo43Ww58cEiJ5wpR4HACS5
 aUYyyzimHuG03JDdugUAR+SIC+lVSicMgf0MmdNmSIiL1dmSRObJAX7qziCCK8CMsMxH9NYZW
 TiecmDnXQEWgvEuephJ8Bo5WKtRAlxWsYD06Ic6cjmuuYoT4v2SRfN8jIIbRjgq7c0cB5WuJk
 Leiux4RyG1kVtdR4CZJkUslEu3XnOAHnj5P6KNo8umenLI+ZYDRED1MO0z2mV9Dd+9HlKoPWL
 dGU4LIzIovSVxK3j7FOyjwZwcd2nkCPtmpGllSisWp74YmYy9tKYVRAZG3ylhRgOQiRbBxCFS
 oX6ldKYrDyZdtbJz67s4geLnffQLOrIlDCEc1b9bjpZxOnwVQtz6/upvg7RS6HkMurymGIywp
 KUal3/Vj0JiVhL6/K6njx5MupEyI6F3rWZyK94Z58Pel2hqtFxLGcicacgAPXwbXyqofchuYI
 XlUdzJTJD7Y7vxuAxw9+ipf7QfZlZ9Wz41szZpEPW7eZXB2FYypay2czb8r1sJSbJgw7I5Uzl
 UraKAJA6vzJgIl7ZcuI5DyHxikE2vHX76MaM6m26LnTawXB7ie/VKk9hoWxbrKuIq22ogHKx7
 PAEvAOepiu+HMchDZwhMFf+MGn
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.09.22 um 18:08 schrieb Limonciello, Mario:

> [Public]
>
>
>
>> -----Original Message-----
>> From: Armin Wolf <W_Armin@gmx.de>
>> Sent: Tuesday, September 13, 2022 09:41
>> To: Randy Dunlap <rdunlap@infradead.org>; hdegoede@redhat.com;
>> markgross@kernel.org
>> Cc: rafael@kernel.org; lenb@kernel.org; hmh@hmh.eng.br;
>> matan@svgalib.org; corentin.chary@gmail.com; jeremy@system76.com;
>> productdev@system76.com; platform-driver-x86@vger.kernel.org; linux-
>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 5/5] platform/x86: dell: Add new dell-wmi-ddv driver
>>
>> Am 12.09.22 um 23:56 schrieb Randy Dunlap:
>>
>>> Hi--
>>>
>>> On 9/12/22 05:53, Armin Wolf wrote:
>>>> diff --git a/drivers/platform/x86/dell/Kconfig
>> b/drivers/platform/x86/dell/Kconfig
>>>> index 25421e061c47..209e63e347e2 100644
>>>> --- a/drivers/platform/x86/dell/Kconfig
>>>> +++ b/drivers/platform/x86/dell/Kconfig
>>>> @@ -189,6 +189,19 @@ config DELL_WMI_DESCRIPTOR
>>>>    	default n
>>>>    	depends on ACPI_WMI
>>>>
>>>> +config DELL_WMI_DDV
>>>> +	tristate "Dell WMI sensors Support"
>>>> +	default m
>>> You should (try to) justify default m, otherwise just
>>> don't have a default for it.
>> I have chosen default m since many other Dell platform drivers are being
>> default m. Since this driver is not essential for normal operation,
>> i will drop default m then.
> Actually Dell drivers directory are a bit unique in this regard.  There is a special
> top level boolean.  I would suggest to keep it as is.
>
> Take a look at:
> menuconfig X86_PLATFORM_DRIVERS_DELL

Ok.

Armin Wolf

>> Armin Wolf
>>
>>>> +	depends on ACPI_BATTERY
>>>> +	depends on ACPI_WMI
>>>> +	help
>>>> +	  This option adds support for WMI-based sensors like
>>>> +	  battery temperature sensors found on some Dell notebooks.
>>>> +	  It also supports reading of the batteries ePPID.
>>>> +
>>>> +	  To compile this drivers as a module, choose M here: the module will
>>>> +	  be called dell-wmi-ddv.
