Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F23A6EE92B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjDYUmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjDYUma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:42:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9824A14453;
        Tue, 25 Apr 2023 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=h+gCbLUKJQC2+HAU7qLDwILmdLj2XYRzMdm02Sw/aGk=; b=v9xUI/Ky9wuDLiCrjsKc+yrRzD
        QjRckxkVRzUNt9wP106rV/XDexqyKU77Mkbuym1tqe0g2wNeB/gWxy75jTIWbHKFuvGe7l08z8tJn
        H3Zi410B6L9lZv4pYgtZGXr2eQEt4zORbgQC9WBDpxOZE52yg5ozuRC8tIKcGp/MfpZug0E0jX7Qd
        iesTXntZamj8g+X7zlKa46Ho5WPXv3NDCurdUAUHvnKlJq/kRE22OzB/JrJmY2TcTQp7zAt+tfusa
        3cwQ5QmLvbdaPIyL1zWVJ8wdNeSE6yd351xG/wp08cN47mZDW1zHjEqkwjL28ATaR1BwL0AD4lYs9
        55sTg0CQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1prPUS-002BSk-2a;
        Tue, 25 Apr 2023 20:42:20 +0000
Message-ID: <72ca1f1c-aa4a-b848-5c99-f653e7151b8b@infradead.org>
Date:   Tue, 25 Apr 2023 13:42:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/4] platform/x86: wmi: Add documentation
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
        markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424222939.208137-1-W_Armin@gmx.de>
 <20230424222939.208137-4-W_Armin@gmx.de>
 <fd333355-8059-4d7d-7a7e-be67006ad3fc@infradead.org>
 <1b68caa2-3c4a-1f47-6409-5ebfd34e431f@redhat.com>
 <75059f5f-32c5-65fb-5d4b-1b9bc595691e@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <75059f5f-32c5-65fb-5d4b-1b9bc595691e@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/23 13:29, Armin Wolf wrote:
> Am 25.04.23 um 18:30 schrieb Hans de Goede:
> 
>> Hi All,
>>
>> Armin thank you very mich for the WMI documentation work,
>> this is much appreciated!
>>
>> On 4/25/23 05:07, Randy Dunlap wrote:
>>> Hi--
>>>
>>> On 4/24/23 15:29, Armin Wolf wrote:
>>>> Add documentation for the WMI subsystem. The documentation describes
>>>> both the ACPI WMI interface and the driver API for interacting with
>>>> the WMI driver core. The information regarding the ACPI interface
>>>> was retrieved from the Ubuntu kernel references and the Windows driver
>>>> samples available on GitHub. The documentation is supposed to help
>>>> driver developers writing WMI drivers, as many modern machines designed
>>>> to run Windows provide an ACPI WMI interface.
>>>>
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>> ---
>>>>   Documentation/driver-api/index.rst   |  1 +
>>>>   Documentation/driver-api/wmi.rst     | 21 ++++++
>>>>   Documentation/subsystem-apis.rst     |  1 +
>>>>   Documentation/wmi/acpi-interface.rst | 96 ++++++++++++++++++++++++++++
>>>>   Documentation/wmi/index.rst          | 18 ++++++
>>>>   MAINTAINERS                          |  2 +
>>>>   6 files changed, 139 insertions(+)
>>>>   create mode 100644 Documentation/driver-api/wmi.rst
>>>>   create mode 100644 Documentation/wmi/acpi-interface.rst
>>>>   create mode 100644 Documentation/wmi/index.rst
>>>>
>>>> diff --git a/Documentation/driver-api/wmi.rst b/Documentation/driver-api/wmi.rst
>>>> new file mode 100644
>>>> index 000000000000..6ca58c8249e5
>>>> --- /dev/null
>>>> +++ b/Documentation/driver-api/wmi.rst
>>>> @@ -0,0 +1,21 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>>>> +
>>>> +==============
>>>> +WMI Driver API
>>>> +==============
>>>> +
>>>> +The WMI driver core supports a more modern bus-based interface for interacting
>>>> +with WMI devices, and an older GUID-based interface. The latter interface is
>>>> +considered to be deprecated, so new WMI drivers should generally avoid it since
>>>> +it has some issues with multiple WMI devices and events sharing the same GUIDs
>>>> +and/or notification IDs. The modern bus-based interface instead maps each
>>>> +WMI device to a :c:type:`struct wmi_device <wmi_device>`, so it supports
>>>> +WMI devices sharing GUIDs and/or notification IDs. Drivers can then register
>>>> +a :c:type:`struct wmi_driver <wmi_driver>`, which will be bound to compatible
>>>> +WMI devices by the driver core.
>>>> +
>>>> +.. kernel-doc:: include/linux/wmi.h
>>>> +   :internal:
>>> There are no kernel-doc comments in include/linux/wmi.h, so this
>>> causes a kernel-doc warning:
>>>
>>> ../include/linux/wmi.h:1: warning: no structured comments found
>>>
>>> Otherwise this all looks good.
>> So what is the plan here, is there something we can do to fix this
>> new warning and should I expect a v3?  Or shall I merge this as is ?
>>
>> Regards,
>>
>> Hans
>>
> I did a complete rebuild of the documentation on my machine, and this
> error message did not appear. Also include/linux/wmi.h does include
> kernel-doc comments for macros like wmi_driver_register(), so i do not
> know why this warning is issued by sphinx.

OK, Hans, go ahead and merge it as is.

Thanks.
-- 
~Randy
