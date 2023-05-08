Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B36FA36A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjEHJeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEHJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:34:04 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5543BFD
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:34:01 -0700 (PDT)
X-ASG-Debug-ID: 1683538437-086e237e516de40001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id Yl6PW2wbkHolTVsk (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 08 May 2023 17:33:57 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 8 May
 2023 17:33:57 +0800
Received: from [192.168.3.72] (222.128.104.110) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 8 May
 2023 17:33:56 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <734023dc-3001-3653-399f-aa66b99ba27e@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.3.72
Date:   Tue, 9 May 2023 01:33:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/4] xhci: Add some quirks for zhaoxin xhci to fix
 issues
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH v3 1/4] xhci: Add some quirks for zhaoxin xhci to fix
 issues
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>,
        <stable@vger.kernel.org>
References: <20230506201536.7362-1-WeitaoWang-oc@zhaoxin.com>
 <20230506201536.7362-2-WeitaoWang-oc@zhaoxin.com>
 <71834813-4f59-a453-5d17-1a44010047ad@linux.intel.com>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <71834813-4f59-a453-5d17-1a44010047ad@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [222.128.104.110]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1683538437
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1589
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.108481
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
        3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/8 17:01, Mathias Nyman wrote:
> On 6.5.2023 23.15, Weitao Wang wrote:
>> Add a quirk XHCI_ZHAOXIN_HOST for zhaoxin xhci to fix issues,
>> there are two cases will be used.
>> - add u1/u2 support.
>> - fix xHCI root hub speed show issue in zhaoxin platform.
>>
>> Add a quirk XHCI_ZHAOXIN_TRB_FETCH to fix TRB prefetch issue.
>>
>> On Zhaoxin ZX-100 project, xHCI can't work normally after resume
>> from system Sx state. To fix this issue, when resume from system
>> Sx state, reinitialize xHCI instead of restore.
>> So, Add XHCI_RESET_ON_RESUME quirk for ZX-100 to fix issue of
>> resuming from system Sx state.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> 
> 
> I'd split this series into different logical parts:
> 
> patch 1/4
>    Set XHCI_RESET_ON_RESUME quirk to ZHAOXIN host to fix resume issue.
>    cc: stable
> 
> patch 2/4
>    Add XHCI_ZHAOXIN_TRB_FETCH quirk flag together with code that allocates double pages
>    cc: stable
> 
> patch 3/4
>    Add XHCI_ZHAOXIN_HOST quirk flag together with code that corrects USB3 roothub minor 
> version
>    cc: stable
> 
> patch 4/4
>    Set XHCI_LPM_SUPPORT quirk together with code that sets tier policy and u1/u2 timeouts,
>    Don't add stable as this is about adding feature support.
> 
Okay,no problem, I'll modify this patch series according to
above solution and order in the next version.

Best Regards,
Weitao
> (Accidentally replied to older v2 series with the above comments)
> 
> Thanks
> -Mathias
> 
> .
