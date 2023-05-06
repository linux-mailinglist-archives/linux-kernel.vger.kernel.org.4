Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A946F8E5A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 05:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjEFDix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 23:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjEFDiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 23:38:51 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836B15BAD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 20:38:48 -0700 (PDT)
X-ASG-Debug-ID: 1683344322-086e237e53681e0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id fBt37mRKNQNNOLBX (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Sat, 06 May 2023 11:38:43 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Sat, 6 May
 2023 11:38:42 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Sat, 6 May
 2023 11:38:41 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <6fc202dd-9dcf-187e-98dc-abd034874655@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.21
Date:   Sat, 6 May 2023 19:38:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] xhci: Show zhaoxin xHCI root hub speed correctly
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH v2 3/4] xhci: Show zhaoxin xHCI root hub speed correctly
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>
References: <20230421203853.387210-1-WeitaoWang-oc@zhaoxin.com>
 <20230421203853.387210-4-WeitaoWang-oc@zhaoxin.com>
 <f6689241-9749-28a2-6da4-842f3253c678@linux.intel.com>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <f6689241-9749-28a2-6da4-842f3253c678@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1683344322
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 7025
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.108386
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
        3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/5 18:52, Mathias Nyman wrote:
> On 21.4.2023 23.38, Weitao Wang wrote:
>> Some zhaoxin xHCI controllers follow usb3.1 spec,
>> but only support gen1 speed 5G. While in Linux kernel,
>> if xHCI suspport usb3.1,root hub speed will show on 10G.
>> To fix this issue of zhaoxin xHCI platforms, read usb speed ID
>> supported by xHCI to determine root hub speed.
>>
>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>> ---
>>   drivers/usb/host/xhci.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index 6307bae9cddf..31d6ace9cace 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -5294,6 +5294,7 @@ static void xhci_hcd_init_usb2_data(struct xhci_hcd *xhci, struct 
>> usb_hcd *hcd)
>>   static void xhci_hcd_init_usb3_data(struct xhci_hcd *xhci, struct usb_hcd *hcd)
>>   {
>>       unsigned int minor_rev;
>> +    unsigned int i, j;
>>       /*
>>        * Early xHCI 1.1 spec did not mention USB 3.1 capable hosts
>> @@ -5323,6 +5324,27 @@ static void xhci_hcd_init_usb3_data(struct xhci_hcd *xhci, struct 
>> usb_hcd *hcd)
>>           hcd->self.root_hub->ssp_rate = USB_SSP_GEN_2x1;
>>           break;
>>       }
>> +
>> +    /* Usb3.1 has gen1 and gen2, Some zhaoxin's xHCI controller
>> +     * that follow usb3.1 spec but only support gen1.
>> +     */
>> +    if (xhci->quirks & XHCI_ZHAOXIN_HOST) {
>> +        minor_rev = 0;
>> +        for (j = 0; j < xhci->num_port_caps; j++) {
>> +            for (i = 0; i < xhci->port_caps[j].psi_count; i++) {
>> +                if (XHCI_EXT_PORT_PSIV(xhci->port_caps[j].psi[i]) >= 5) {
>> +                    minor_rev = 1;
>> +                    break;
>> +                }
>> +            }
>> +            if (minor_rev)
>> +                break;
>> +        }
>> +        if (minor_rev != 1) {
>> +            hcd->speed = HCD_USB3;
>> +            hcd->self.root_hub->speed = USB_SPEED_SUPER;
>> +        }
>> +    }
>>       xhci_info(xhci, "Host supports USB 3.%x %sSuperSpeed\n",
>>             minor_rev, minor_rev ? "Enhanced " : "");
> 
> How about checking if port support over 5Gbps (psiv >= 5) when we parse the protocol speed ID
> entries the first time? This way we could avoid looping through all the port_cap psiv values.
> 
> Something like:
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index c4170421bc9c..2e4c80eb4972 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -1961,7 +1961,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int 
> num_ports,
>   {
>          u32 temp, port_offset, port_count;
>          int i;
> -       u8 major_revision, minor_revision;
> +       u8 major_revision, minor_revision, tmp_minor_revision;
>          struct xhci_hub *rhub;
>          struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
>          struct xhci_port_cap *port_cap;
> @@ -1981,6 +1981,11 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int 
> num_ports,
>                   */
>                  if (minor_revision > 0x00 && minor_revision < 0x10)
>                          minor_revision <<= 4;
> +               if (xhci->quirks & XHCI_ZHAOXIN_HOST) {
> +                       tmp_minor_revision = minor_revision;
> +                       minor_revision = 0;
> +               }
> +
>          } else if (major_revision <= 0x02) {
>                  rhub = &xhci->usb2_rhub;
>          } else {
> @@ -1989,10 +1994,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int 
> num_ports,
>                  /* Ignoring port protocol we can't understand. FIXME */
>                  return;
>          }
> -       rhub->maj_rev = XHCI_EXT_PORT_MAJOR(temp);
> -
> -       if (rhub->min_rev < minor_revision)
> -               rhub->min_rev = minor_revision;
> 
>          /* Port offset and count in the third dword, see section 7.2 */
>          temp = readl(addr + 2);
> @@ -2010,8 +2011,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int 
> num_ports,
>          if (xhci->num_port_caps > max_caps)
>                  return;
> 
> -       port_cap->maj_rev = major_revision;
> -       port_cap->min_rev = minor_revision;
>          port_cap->psi_count = XHCI_EXT_PORT_PSIC(temp);
> 
>          if (port_cap->psi_count) {
> @@ -2032,6 +2031,10 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int 
> num_ports,
>                                    XHCI_EXT_PORT_PSIV(port_cap->psi[i - 1])))
>                                  port_cap->psi_uid_count++;
> 
> +                       if (xhci->quirks & XHCI_ZHAOXIN_HOST &&
> +                           XHCI_EXT_PORT_PSIV(port_cap->psi[i]) >= 5)
> +                               minor_revision = tmp_minor_revision;
> +
>                          xhci_dbg(xhci, "PSIV:%d PSIE:%d PLT:%d PFD:%d LP:%d PSIM:%d\n",
>                                    XHCI_EXT_PORT_PSIV(port_cap->psi[i]),
>                                    XHCI_EXT_PORT_PSIE(port_cap->psi[i]),
> @@ -2041,6 +2044,15 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int 
> num_ports,
>                                    XHCI_EXT_PORT_PSIM(port_cap->psi[i]));
>                  }
>          }
> +
> +       rhub->maj_rev = major_revision;
> +
> +       if (rhub->min_rev < minor_revision)
> +               rhub->min_rev = minor_revision;
> +
> +       port_cap->maj_rev = major_revision;
> +       port_cap->min_rev = minor_revision;
> +

This patch solution is effective and concise. Thanks for your suggestion.
I'll adopt it in next patch version after other patches of this patch set
are reviewed or suggested.

Best Regards,
Weitao
>          /* cache usb2 port capabilities */
>          if (major_revision < 0x03 && xhci->num_ext_caps < max_caps)
>                  xhci->ext_caps[xhci->num_ext_caps++] = temp;
> 
> Thanks
> Mathias
> .
