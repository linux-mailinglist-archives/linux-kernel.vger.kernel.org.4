Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357646EB6E5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 04:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDVCnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 22:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVCnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 22:43:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72A31BDD;
        Fri, 21 Apr 2023 19:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6s42dEkhm+h+7Bop8LtLFtXQGDgrgIugEwb6pwLtltI=; b=ME3SRQ7wA+waI0Ddl4KOd/ZFye
        SCp9rPX+MMV3sfIVb1TXRcU6UAchfvFDuwB03VJMyi2a/Pnfs788e9pPtBxFHlx/JG/F7tSjBk2He
        Dts47hcGQAb9c44hYLzhGlBVZGMHqJ32mesMHfWuldPvzkvBFusbG8YB0j0ED0qP+12pwWHv11opR
        3q0JW0CiAdJlAD/+ehPeJDlRqO0Sf+u+bM3xmxmLHTNMi9+P8P4Xui9qqFxcPr6F64QS9iqWhyKhG
        xoQfPuXzM2QGUt/g1Y61D5Kkz2xIaeBgcn5Udn0V4xwDW1FQilmED8QK1PTY1LSewTi2wF5ak5C0j
        sld1j4sA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pq3DV-00CGf4-2h;
        Sat, 22 Apr 2023 02:43:14 +0000
Message-ID: <43df1f32-3506-fc2f-a033-b452852b5e25@infradead.org>
Date:   Fri, 21 Apr 2023 19:43:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] platform/x86: wmi: Add documentation
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420233226.14561-1-W_Armin@gmx.de>
 <20230420233226.14561-4-W_Armin@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230420233226.14561-4-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/20/23 16:32, Armin Wolf wrote:
> Add documentation for the WMI subsystem. The documentation describes
> both the ACPI WMI interface and the driver API for interacting with
> the WMI driver core. The information regarding the ACPI interface
> where retrieved from the Ubuntu kernel references and the

  were?  I would say "was".

> Windows driver samples available on GitHub. The documentation is
> supposed to help driver developers writing WMI drivers, as many
> modern machines designed to run Windows provide a ACPI WMI interface.

                                                  an ACPI

For the Documentation/ files, AFAIK, we still have an 80-column preferred
limit.  coding-style.rst does not say anything about Documentation/ being
exempt from that limit.

> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  Documentation/driver-api/index.rst   |  1 +
>  Documentation/driver-api/wmi.rst     | 19 ++++++
>  Documentation/subsystem-apis.rst     |  1 +
>  Documentation/wmi/acpi-interface.rst | 86 ++++++++++++++++++++++++++++
>  Documentation/wmi/index.rst          | 18 ++++++
>  MAINTAINERS                          |  2 +
>  include/linux/wmi.h                  |  2 +-
>  7 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/driver-api/wmi.rst
>  create mode 100644 Documentation/wmi/acpi-interface.rst
>  create mode 100644 Documentation/wmi/index.rst
> 
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index ff9aa1afdc62..1e16a40da3ba 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -113,6 +113,7 @@ available subsections can be seen below.
>     xillybus
>     zorro
>     hte/index
> +   wmi
> 
>  .. only::  subproject and html
> 
> diff --git a/Documentation/driver-api/wmi.rst b/Documentation/driver-api/wmi.rst
> new file mode 100644
> index 000000000000..06cecbe36afd
> --- /dev/null
> +++ b/Documentation/driver-api/wmi.rst
> @@ -0,0 +1,19 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +==============
> +WMI Driver API
> +==============
> +
> +The WMI driver core supports a more modern bus-based interface for interacting with WMI devices,
> +and an older GUID-based interface. The later interface is considered to be deprecated, so new

ITYM                                      latter

> +WMI drivers should generally avoid it since it has some issues with multiple WMI devices and
> +events sharing the same GUIDs and/or notification IDs. The modern bus-based interface instead
> +maps each WMI device to a :c:type:`struct wmi_device <wmi_device>`, so it supports WMI devices
> +sharing GUIDs and/or notification IDs. Drivers can then register a :c:type:`struct wmi_driver <wmi_driver>`,
> +which will get bound to compatible WMI devices by the driver core.

s/get/be/ preferably.

> +
> +.. kernel-doc:: include/linux/wmi.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/platform/x86/wmi.c
> +   :export:
> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
> index b51f38527e14..69f5e4d53bad 100644
> --- a/Documentation/subsystem-apis.rst
> +++ b/Documentation/subsystem-apis.rst
> @@ -57,3 +57,4 @@ needed).
>     scheduler/index
>     mhi/index
>     peci/index
> +   wmi/index
> diff --git a/Documentation/wmi/acpi-interface.rst b/Documentation/wmi/acpi-interface.rst
> new file mode 100644
> index 000000000000..c0afdb6c5885
> --- /dev/null
> +++ b/Documentation/wmi/acpi-interface.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +==================
> +ACPI WMI interface
> +==================
> +
> +The ACPI WMI interface is a proprietary extension of the ACPI specification made by Microsoft
> +to allow hardware vendors to embed WMI (Windows Management Instrumentation) objects inside
> +their ACPI firmware. Typical functions implemented over ACPI WMI are hotkey events on modern
> +notebooks and configuration of BIOS options.
> +
> +PNP0C14 ACPI device
> +-------------------
> +
> +Discovery of WMI objects is handled by defining ACPI devices with a PNP ID of ``PNP0C14``.
> +These devices will contain a set of ACPI buffers and methods used for mapping and execution
> +of WMI methods and/or queries. If there exist multiple of such devices, then each device is
> +required to have a unique ACPI UID.
> +
> +_WDG buffer
> +-----------
> +
> +The ``_WDG`` buffer is used to discover WMI objects and is required to be static. Its internal
> +structure consists of data blocks with a size of 20 bytes, containing the following data:
> +
> +======= =============== =====================================================
> +Offset  Size (in bytes) Content
> +======= =============== =====================================================
> +0x00    16              128 bit Variant 2 object GUID.
> +0x10    2               2 character method ID or single byte notification ID.
> +0x12    1               Object instance count.
> +0x13    1               Object flags.
> +======= =============== =====================================================
> +
> +The WMI object flags control whether the method or notification ID is used:
> +
> +- 0x1: Data block usage is expensive and must be explicitly enabled/disabled.
> +- 0x2: Data block contains WMI methods.
> +- 0x4: Data block contains ASCIZ string.
> +- 0x8: Data block describes a WMI event, use notification ID instead of method ID.
> +
> +Each WMI object GUID can appear multiple times inside a system. The method/notification ID
> +is used to construct the ACPI method names used for interacting with the WMI object.
> +
> +WQxx ACPI methods
> +-----------------
> +
> +If a data block does not contain WMI methods, then its content can be retrieved by this required
> +ACPI methods. The last two characters of the ACPI method name are the method ID of the data block

   ACPI method.

> +to query. Their single parameter is a integer describing the instance which should be queried. This

                                       an integer

> +parameter can be omitted if the data block contains only a single instance.
> +
> +WSxx ACPI methods
> +-----------------
> +
> +Similar to the ``WQxx`` ACPI methods, except that it is optional and takes an additional buffer
> +as its second argument. The instance argument also cannot be omitted.
> +
> +WMxx ACPI methods
> +-----------------
> +
> +Used for executing WMI methods associated with a data block. The last two characters of the ACPI method
> +name are the method ID of the data block containing the WMI methods. Their first parameter is a integer

                                                                                                 an integer

> +describing the instance which methods should be executed. The second parameter is a integer describing
> +the WMI method ID to execute, and the third parameter is a buffer containing the WMI method parameters.
> +If the data block is marked as containing a ASCIZ string, then this buffer should contain a ASCIZ string.

                                             an ASCIZ string,                                an ASCIZ string.

> +The ACPI method will return the result of the executed WMI method.
> +
> +WExx ACPI methods
> +-----------------
> +
> +Used for optionally enabling/disabling WMI events, the last two characters of the ACPI method are the
> +notification ID of the data block describing the WMI event as hexadecimal value. Their first parameter
> +is an integer with a value of 0 if the WMI event should be disabled, other values will enable the WMI event.
> +
> +WCxx ACPI methods
> +-----------------
> +Similar to the ``WExx`` ACPI methods, except that it controls data collection instead of events
> +and thus the last two characters of the ACPI method name are the method ID of the data block
> +to enable/disable.
> +
> +_WED ACPI method
> +----------------
> +
> +Used to retrieve additional WMI event data, its single parameter is a integer holding the
> +notification ID of the event.
> diff --git a/Documentation/wmi/index.rst b/Documentation/wmi/index.rst
> new file mode 100644
> index 000000000000..b29933a86380
> --- /dev/null
> +++ b/Documentation/wmi/index.rst
> @@ -0,0 +1,18 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=============
> +WMI Subsystem
> +=============
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   acpi-interface
> +
> +.. only::  subproject and html
> +
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c9011f5fc17..979d37176429 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -449,6 +449,8 @@ F:	include/linux/acpi_viot.h
>  ACPI WMI DRIVER
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Orphan
> +F:	Documentation/driver-api/wmi.rst
> +F:	Documentation/wmi/
>  F:	drivers/platform/x86/wmi.c
>  F:	include/uapi/linux/wmi.h
> 
> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
> index 88f66b12eef9..87822effdf3c 100644
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -49,7 +49,7 @@ extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);
>   *
>   * This represents WMI drivers which handle WMI devices.
>   * @filter_callback is only necessary for drivers which
> - * want to set up a WMI IOCTL interface.
> + * want to set up a WMI IOCTL interface

Nothing wrong with the ending '.' there.

>   */
>  struct wmi_driver {
>  	struct device_driver driver;
> --
> 2.30.2
> 

-- 
~Randy
