Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4766EA22F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 05:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjDUDLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 23:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjDUDK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:10:58 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E02A76B8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 20:10:51 -0700 (PDT)
X-ASG-Debug-ID: 1682045806-086e237e5135620001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id xN8o7HmrECTUbDoa (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 21 Apr 2023 10:56:46 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 21 Apr
 2023 10:56:46 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 21 Apr
 2023 10:56:45 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <a270bd46-fb39-50a7-c2a7-da98b06458ff@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.21
Date:   Fri, 21 Apr 2023 18:56:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] xhci: Add zhaoxin xHCI U1/U2 feature support
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 2/3] xhci: Add zhaoxin xHCI U1/U2 feature support
To:     Mathias Nyman <mathias.nyman@intel.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>
References: <20230420172130.375819-1-WeitaoWang-oc@zhaoxin.com>
 <20230420172130.375819-3-WeitaoWang-oc@zhaoxin.com>
 <92cf6ed0-be37-d8a6-14c7-c5043f076916@intel.com>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <92cf6ed0-be37-d8a6-14c7-c5043f076916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1682045806
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5371
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107704
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
        3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/20 22:07, Mathias Nyman wrote:
> On 20.4.2023 20.21, Weitao Wang wrote:
>> Add U1/U2 feature support of xHCI for zhaoxin.
>>
>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>> ---
>>   drivers/usb/host/xhci-pci.c |  5 +++++
>>   drivers/usb/host/xhci.c     | 27 +++++++++++++++++++++++++--
>>   2 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index 6db07ca419c3..a235effe8e5c 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -334,6 +334,11 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>>            pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
>>           xhci->quirks |= XHCI_NO_SOFT_RETRY;
>> +    if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
>> +        xhci->quirks |= XHCI_LPM_SUPPORT;
>> +        xhci->quirks |= XHCI_ZHAOXIN_HOST;
>> +    }
>> +
>>       /* xHC spec requires PCI devices to support D3hot and D3cold */
>>       if (xhci->hci_version >= 0x120)
>>           xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index 6307bae9cddf..730c0f68518d 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -4802,7 +4802,7 @@ static u16 xhci_calculate_u1_timeout(struct xhci_hcd *xhci,
>>           }
>>       }
>> -    if (xhci->quirks & XHCI_INTEL_HOST)
>> +    if (xhci->quirks & (XHCI_INTEL_HOST | XHCI_ZHAOXIN_HOST))
>>           timeout_ns = xhci_calculate_intel_u1_timeout(udev, desc);
> 
> Looks odd to tie Zhaoxin vendor to Intel specific values but ok,
> if they diverge in the future we anyway need to modify this.

These Intel specific values look good for zhaoxin xHCI with test.
Reused this piece of code for simplicity. If there are any difference
for these value, update will be submitted in the future.

>>       else
>>           timeout_ns = udev->u1_params.sel;
>> @@ -4866,7 +4866,7 @@ static u16 xhci_calculate_u2_timeout(struct xhci_hcd *xhci,
>>           }
>>       }
>> -    if (xhci->quirks & XHCI_INTEL_HOST)
>> +    if (xhci->quirks & (XHCI_INTEL_HOST | XHCI_ZHAOXIN_HOST))
>>           timeout_ns = xhci_calculate_intel_u2_timeout(udev, desc);
> 
> same.
> 
>>       else
>>           timeout_ns = udev->u2_params.sel;
>> @@ -4938,6 +4938,27 @@ static int xhci_update_timeout_for_interface(struct xhci_hcd *xhci,
>>       return 0;
>>   }
>> +static int xhci_check_zhaoxin_tier_policy(struct usb_device *udev,
>> +        enum usb3_link_state state)
>> +{
>> +    struct usb_device *parent;
>> +    unsigned int num_hubs;
>> +
>> +    /* Don't enable U1/U2 if the device is on an external hub. */
>> +    for (parent = udev->parent, num_hubs = 0; parent->parent;
>> +            parent = parent->parent)
>> +        num_hubs++;
>> +
>> +    if (num_hubs < 1)
>> +        return 0;
>> +
>> +    dev_dbg(&udev->dev, "Disabling U1/U2 link state for device"
>> +            " below external hub.\n");
>> +    dev_dbg(&udev->dev, "Plug device into root hub "
>> +            "to decrease power consumption.\n");
>> +    return -E2BIG;
>> +}
>> +
> 
> I don't think we should add more vendor specific functions, this is almost
> an exact copy of xhci_check_intel_tier_policy().

Adding duplicate vendor related code is indeed a bit redundant.

> How about getting rid of both of those and use something like this instead (untested):
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 2b280beb0011..e9a25e4d99cf 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4926,10 +4926,24 @@ static int xhci_check_tier_policy(struct xhci_hcd *xhci,
>                  struct usb_device *udev,
>                  enum usb3_link_state state)
>   {
> -       if (xhci->quirks & XHCI_INTEL_HOST)
> -               return xhci_check_intel_tier_policy(udev, state);
> -       else
> -               return 0;
> +       struct usb_device *parent = udev->parent;
> +       int tier = 1; /* roothub is tier1 */
> +
> +       while (parent) {
> +               parent = parent->parent;
> +               tier++;
> +       }
> +
> +       if (xhci->quirks & XHCI_INTEL_HOST && tier > 3)
> +               goto fail;
> +       if (xhci->quirks & XHCI_ZHAOXIN_HOST && tier > 2)
> +               goto fail;
> +
> +       return 0;
> +fail:
> +       dev_dbg(&udev->dev, "Tier policy prevents U1/U2 LPM states for devices at tier %d\n",
> +               tier);
> +       return -E2BIG;
>   }

These code looks very elegant. Could I resubmit patch using your code
after testing pass on Intel and Zhaoxin platform.

Thanks,
weitao
> Or possibly even add a xhci->max_tier_for_lpm that can be set during probe based on
> vendor or from device property.
> 
> Thanks
> -Mathias
> 
> .
