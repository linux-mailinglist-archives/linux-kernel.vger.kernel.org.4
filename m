Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8D26FC27B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjEIJPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjEIJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:15:07 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620E2DC59
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:15:05 -0700 (PDT)
X-ASG-Debug-ID: 1683623699-1eb14e63866ee00001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id lQHn8UbFhW9MmM3a (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 09 May 2023 17:14:59 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 9 May
 2023 17:14:59 +0800
Received: from [192.168.3.85] (222.128.104.110) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 9 May
 2023 17:14:57 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <3202ceef-f369-4622-a83a-ff85c3011199@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.3.85
Date:   Wed, 10 May 2023 01:14:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 0/4] Fix some issues for ZHAOXIN xHCI host
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH v4 0/4] Fix some issues for ZHAOXIN xHCI host
To:     Mathias Nyman <mathias.nyman@intel.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <WeitaoWang@zhaoxin.com>
References: <20230508212058.6307-1-WeitaoWang-oc@zhaoxin.com>
 <d59ce91a-1992-6cae-1a6a-ada922594cda@intel.com>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <d59ce91a-1992-6cae-1a6a-ada922594cda@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [222.128.104.110]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1683623699
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 812
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.108524
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
        3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/9 16:08, Mathias Nyman wrote:
> On 9.5.2023 0.20, Weitao Wang wrote:
>> Fix some issues for ZHAOXIN xHCI host.
>>
>> Weitao Wang (4):
>>    xhci: Fix resume issue of some ZHAOXIN hosts
>>    xhci: Fix TRB prefetch issue of ZHAOXIN hosts
>>    xhci: Show ZHAOXIN xHCI root hub speed correctly
>>    xhci: Add ZHAOXIN xHCI host U1/U2 feature support
>>
>>   drivers/usb/host/xhci-mem.c | 38 ++++++++++++++++++++++++--------
>>   drivers/usb/host/xhci-pci.c | 13 +++++++++++
>>   drivers/usb/host/xhci.c     | 43 ++++++++++++++++---------------------
>>   drivers/usb/host/xhci.h     |  2 ++
>>   4 files changed, 62 insertions(+), 34 deletions(-)
>>
> 
> Thanks, added to queue
> 
> -Mathias

That's great! Thanks again for your help and suggestion.
Weitao

