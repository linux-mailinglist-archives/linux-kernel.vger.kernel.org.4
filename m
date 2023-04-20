Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B0C6E8DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjDTJPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDTJPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:15:14 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D72499
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:15:12 -0700 (PDT)
X-ASG-Debug-ID: 1681982107-1eb14e63892d9e0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id FzLFaZOkexQJqRZs (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 20 Apr 2023 17:15:07 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 20 Apr
 2023 17:15:07 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 20 Apr
 2023 17:15:06 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <6a43e6aa-5609-ecd5-b040-010763a686ee@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.21
Date:   Fri, 21 Apr 2023 01:14:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_UHCI=ef=bc=9aadjust_zhaoxin_UHCI_contro?=
 =?UTF-8?Q?llers_OverCurrent_bit_value?=
Content-Language: en-US
X-ASG-Orig-Subj: =?UTF-8?Q?Re=3a_=5bPATCH=5d_UHCI=ef=bc=9aadjust_zhaoxin_UHCI_contro?=
 =?UTF-8?Q?llers_OverCurrent_bit_value?=
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tonywwang@zhaoxin.com>,
        <weitaowang@zhaoxin.com>
References: <20230420111445.5028-1-WeitaoWang-oc@zhaoxin.com>
 <ZEDyWC7GsbcEn7UK@kroah.com>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <ZEDyWC7GsbcEn7UK@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1681982107
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1883
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107671
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

On 2023/4/20 16:05, Greg KH wrote:
> On Thu, Apr 20, 2023 at 07:14:45PM +0800, Weitao Wang wrote:
>> Over Current condition is not standardized in the UHCI spec.
>> Zhaoxin UHCI controllers report OverCurrent bit active off.
>> Intel controllers report it active on, so we'll adjust the bit value.
>>
>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> 
> Note, your Subject: line has odd characters in it, can you rewrite it to
> just use ascii?  I think it's the '：' character which should be ':',
> right?Yes,you are right. it's my typo mistake. I'll rewrite this patch. Thanks!

>> ---
>>   drivers/usb/host/uhci-pci.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/host/uhci-pci.c b/drivers/usb/host/uhci-pci.c
>> index 3592f757fe05..177e3c2aa287 100644
>> --- a/drivers/usb/host/uhci-pci.c
>> +++ b/drivers/usb/host/uhci-pci.c
>> @@ -126,6 +126,10 @@ static int uhci_pci_init(struct usb_hcd *hcd)
>>   	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_VIA)
>>   		uhci->oc_low = 1;
>>   
>> +	/* ZHAOXIN controllers report OverCurrent bit active off. */
>> +	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_ZHAOXIN)
>> +		uhci->oc_low = 1;
>> +
> 
> This should also go to the stable kernels, right?
> 
> But a new UHCI controller?  And this affects all of them? 
All UHCI controller of zhaoxin have this issue, And Hope this
patch go to stable kernel.Could I resubmit this patch with
modify subject typo mistake?

> Intel an issue here (as you mention in the changelog text)?
> 
I got this info from uhci driver comments in function uhci_pci_init.

"Intel controllers report the OverCurrent bit active on.
VIA controllers report it active off, so we'll adjust the
bit value.  (It's not standardized in the UHCI spec.)"

Best Regards,
weitao

> thanks,
> 
> greg k-h
> .
