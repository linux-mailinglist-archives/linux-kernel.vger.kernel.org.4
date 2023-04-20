Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D9C6E8F97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjDTKMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjDTKLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:11:49 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BFE9EE1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:08:30 -0700 (PDT)
X-ASG-Debug-ID: 1681985308-1eb14e63882dfa0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id UldYrculNOYAjf4U (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 20 Apr 2023 18:08:28 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 20 Apr
 2023 18:08:28 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 20 Apr
 2023 18:08:27 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <b65291ea-acca-7cd4-b5f5-f5bb46e679b4@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.21
Date:   Fri, 21 Apr 2023 02:08:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Fix some issues of xHCI for zhaoxin
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 0/3] Fix some issues of xHCI for zhaoxin
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tonywwang@zhaoxin.com>,
        <weitaowang@zhaoxin.com>
References: <20230420172130.375819-1-WeitaoWang-oc@zhaoxin.com>
 <ZEEF9E4Mmeg5hRWu@kroah.com>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <ZEEF9E4Mmeg5hRWu@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1681985308
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1179
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107673
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

On 2023/4/20 17:29, Greg KH wrote:
> On Fri, Apr 21, 2023 at 01:21:27AM +0800, Weitao Wang wrote:
>> Fix some issues of xHCI for zhaoxin.
>>
>> Weitao Wang (3):
>>    xhci: Add a quirk for zhaoxin xhci to fix issues.
>>    xhci: Add zhaoxin xHCI U1/U2 feature support
>>    xhci: Show zhaoxin xHCI root hub speed correctly
>>
>>   drivers/usb/host/xhci-pci.c |  5 ++++
>>   drivers/usb/host/xhci.c     | 49 +++++++++++++++++++++++++++++++++++--
>>   drivers/usb/host/xhci.h     |  1 +
>>   3 files changed, 53 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.32.0
>>
> 
> Do these replace:
> https://lore.kernel.org/r/20230420093603.3344-1-WeitaoWang-oc@zhaoxin.com
> or are they on top of them?
> 

This [patch 2/3] and [patch 3/3] share a xhci quirk flag XHCI_ZHAOXIN_HOST,
So I put these independent functional patch in this set group.
Above url and below url are independent xHCI patch for zhaoxin.
Is it more suitable to put all the patch for zhaoxin xhci in one group?
I Hope to receive your guidance. Thanks!

https://lore.kernel.org/all/20230420104826.4727-1-WeitaoWang-oc@zhaoxin.com/

Best Regards,
Weitao

> thanks,
> 
> greg k-h
> .
