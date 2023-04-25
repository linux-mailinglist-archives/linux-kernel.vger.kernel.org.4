Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8E6EE90F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjDYU3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDYU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:29:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB55D32E;
        Tue, 25 Apr 2023 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682454560; i=w_armin@gmx.de;
        bh=0GPbQLH5Fqtkdbc0/OykYHNjrdeZ2doffseAKM+I/gE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V4wj0rIyDqMuac2NcnE7qX303BafP2y5C+wTWs995Dy6J5GiFi7TO4qjnwcLWPcmj
         EmuP6P7Y+a/HVjWv+4ISJUd+OXkETjlAXL46Yv3blx8KALglt15rAMRIW/fy74FsQw
         s1oEKo92O7WlBFt9RGrBEqP03FF0zqAcanPqwxJ8Glz+VYuLp2rm2cirKAmHdus+kU
         IWmCevV8khTmiAEaa181afjKwPvm4n+0I2HrCZUPTRVAYCO4WdhRRw5Q4RahUpB8qv
         ByTH/s3Gv+otPO19f45XlqzS9SINdestZYM7hvLVkFziPEkbH3Af2PQYx0xcA+ESm8
         s0FBjqzSGlHUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JqV-1prgP30eYb-000K1L; Tue, 25
 Apr 2023 22:29:20 +0200
Subject: Re: [PATCH v2 3/4] platform/x86: wmi: Add documentation
To:     Hans de Goede <hdegoede@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>, markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424222939.208137-1-W_Armin@gmx.de>
 <20230424222939.208137-4-W_Armin@gmx.de>
 <fd333355-8059-4d7d-7a7e-be67006ad3fc@infradead.org>
 <1b68caa2-3c4a-1f47-6409-5ebfd34e431f@redhat.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <75059f5f-32c5-65fb-5d4b-1b9bc595691e@gmx.de>
Date:   Tue, 25 Apr 2023 22:29:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1b68caa2-3c4a-1f47-6409-5ebfd34e431f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:+7aDKAmBxVsDCjbkC0jUzt+xE/I5LnSYNAtgnlnBQ+D7dVgbgZV
 uKQ46D1DaB5I0cIAj131F7mhqAQ9ut4exF9Rh0GFz6jLfcrVDpsqZ+PHiIXSx+vrpjDRLrQ
 VkI/jSzsib0wig9Biyi68QkvGsb36MA3odvlyFncnFLAPn89vh01Av6d73lzDfL2SvXAgTv
 NRTpJ7GE94QnLG/EZv0iA==
UI-OutboundReport: notjunk:1;M01:P0:z+bNqp/nk7s=;IfzibxZqOm5mQaM+PnECTPSjad5
 Dkha8jy0+aA5JHKSboAIzbwIfPPPgIP3m6cd+Bwd4wvwIOH+YSaR2YiZ1EFHwvlvd0szAuYNw
 QueZDj6WqLEUrpJQLt/v9ivG69kvBRQFqRXIc/nlCESLou7a6tCbX3nVSuROxd5OlIVzSmSNz
 YQo3WLnnMQzl14H0j7Cq2tRCqyN3HqoAv78rxftzfDcr7T2CAn0hRVRfCyte0JfZ5oWalp/Xb
 CTCUAaJp4IUR2EwTTYoz8mc2mN9X9Ux2ATFAlD0bw0KUNODrq4DGzSz67eqqtPx/ol7JRkseX
 vWxZz++uPMJlcnOfMnDK/Nte8s5MHJu7/w6XTTlVw9BPLvYZaF1YUgonxifQ0qx5BU1g7Nmfb
 6guevN2DWbWyXPoaOT6vkNlJ/CAqZMwhN4wiVlxK4cn2/e9mN6bcc9MstrfysQU4wiZ/EQZCQ
 /q+Bf9NYf2RRPcQEkht79L3rxbOKet2tDGrkq+OQsZ9RI9kl5NP3w/ZbMfAx9NxWgMeSQpCh/
 BE4kCOjAZhYr3TQvEezxEYbqfKkhDhK5L1BymPSYYr/UNRlZm/u+7NStZQKgp1ga5n81o/Fzu
 B7PG3N7ZCZLXTd7exPYO72mr5jZIhu+ENw9gf+SLTugwTCCSDeR+D+KINVmpKw1ouuDlMkS0B
 DxU7ZfDvIBbyryFkpOujTiYCgQe0hoaHaKNCU3264aUdts4CL6GEpAslrkjgCa9S18ug7CJcV
 TeL3uSm0wGjBO0L4tOAAvBD1RvX6f2c06o5ief86S8N0DQIbXTc2WIdCOlmdgrleyp2HNoblr
 64GaWZODck0kHNTDFsBet2+s8vOS7nzU6n1yOl0o0UKMIJfcEIADQItjOwFma+BPjPHJL0lxW
 sdPJpMJ/WRb4Tif9ahwyJr70/W5yxFPSdZWXqB7GbK6FVimYC1QJIfmGjemEdfN+0SKXf4gUp
 G0YZmTZrX4HVFB6NunpZS/0BX0o=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.04.23 um 18:30 schrieb Hans de Goede:

> Hi All,
>
> Armin thank you very mich for the WMI documentation work,
> this is much appreciated!
>
> On 4/25/23 05:07, Randy Dunlap wrote:
>> Hi--
>>
>> On 4/24/23 15:29, Armin Wolf wrote:
>>> Add documentation for the WMI subsystem. The documentation describes
>>> both the ACPI WMI interface and the driver API for interacting with
>>> the WMI driver core. The information regarding the ACPI interface
>>> was retrieved from the Ubuntu kernel references and the Windows driver
>>> samples available on GitHub. The documentation is supposed to help
>>> driver developers writing WMI drivers, as many modern machines designed
>>> to run Windows provide an ACPI WMI interface.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>>   Documentation/driver-api/index.rst   |  1 +
>>>   Documentation/driver-api/wmi.rst     | 21 ++++++
>>>   Documentation/subsystem-apis.rst     |  1 +
>>>   Documentation/wmi/acpi-interface.rst | 96 ++++++++++++++++++++++++++++
>>>   Documentation/wmi/index.rst          | 18 ++++++
>>>   MAINTAINERS                          |  2 +
>>>   6 files changed, 139 insertions(+)
>>>   create mode 100644 Documentation/driver-api/wmi.rst
>>>   create mode 100644 Documentation/wmi/acpi-interface.rst
>>>   create mode 100644 Documentation/wmi/index.rst
>>>
>>> diff --git a/Documentation/driver-api/wmi.rst b/Documentation/driver-api/wmi.rst
>>> new file mode 100644
>>> index 000000000000..6ca58c8249e5
>>> --- /dev/null
>>> +++ b/Documentation/driver-api/wmi.rst
>>> @@ -0,0 +1,21 @@
>>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +==============
>>> +WMI Driver API
>>> +==============
>>> +
>>> +The WMI driver core supports a more modern bus-based interface for interacting
>>> +with WMI devices, and an older GUID-based interface. The latter interface is
>>> +considered to be deprecated, so new WMI drivers should generally avoid it since
>>> +it has some issues with multiple WMI devices and events sharing the same GUIDs
>>> +and/or notification IDs. The modern bus-based interface instead maps each
>>> +WMI device to a :c:type:`struct wmi_device <wmi_device>`, so it supports
>>> +WMI devices sharing GUIDs and/or notification IDs. Drivers can then register
>>> +a :c:type:`struct wmi_driver <wmi_driver>`, which will be bound to compatible
>>> +WMI devices by the driver core.
>>> +
>>> +.. kernel-doc:: include/linux/wmi.h
>>> +   :internal:
>> There are no kernel-doc comments in include/linux/wmi.h, so this
>> causes a kernel-doc warning:
>>
>> ../include/linux/wmi.h:1: warning: no structured comments found
>>
>> Otherwise this all looks good.
> So what is the plan here, is there something we can do to fix this
> new warning and should I expect a v3?  Or shall I merge this as is ?
>
> Regards,
>
> Hans
>
I did a complete rebuild of the documentation on my machine, and this
error message did not appear. Also include/linux/wmi.h does include
kernel-doc comments for macros like wmi_driver_register(), so i do not
know why this warning is issued by sphinx.

Armin Wolf

>
>
>
>>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> thanks.
