Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23FF68C81A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjBFU7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjBFU7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:59:06 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BFA29162
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:59:04 -0800 (PST)
Received: from [192.168.1.103] (178.176.73.245) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Mon, 6 Feb 2023
 23:58:55 +0300
Subject: Re: [dm-devel] [PATCH] md: dm-ioctl: drop always-false condition
To:     Mikulas Patocka <mpatocka@redhat.com>
CC:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, <dm-devel@redhat.com>,
        <lvc-patches@linuxtesting.org>, <linux-kernel@vger.kernel.org>
References: <c8c9df45-1d59-3195-7631-51b3a58148ee@omp.ru>
 <alpine.LRH.2.21.2301180658250.13031@file01.intranet.prod.int.rdu2.redhat.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <b8269463-9f7e-4c28-2bfe-44663f3764c1@omp.ru>
Date:   Mon, 6 Feb 2023 23:58:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2301180658250.13031@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.73.245]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 02/06/2023 20:39:23
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 175298 [Feb 06 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.245 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.245 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 178.176.73.245:7.7.3,7.4.1,7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.245
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/06/2023 20:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/6/2023 6:36:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 2:59 PM, Mikulas Patocka wrote:

[...]

>> The expression 'indata[3] > ULONG_MAX' always evaluates to false since
>> indata[] is declared as an array of *unsigned long* elements and #define
>> ULONG_MAX represents the max value of that exact type...
>>
>> Note that gcc seems to be able to detect the dead code here and eliminate
>> this check anyway...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

   Thank you!

>> ---
>> This patch is atop of the 'for-next' branch of the device-mapper repo...
>>
>>  drivers/md/dm-ioctl.c |    3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> Index: linux-dm/drivers/md/dm-ioctl.c
>> ===================================================================
>> --- linux-dm.orig/drivers/md/dm-ioctl.c
>> +++ linux-dm/drivers/md/dm-ioctl.c
>> @@ -1073,8 +1073,7 @@ static int dev_set_geometry(struct file

   Returning to this patch, I think I should've added the name of the function
in question in both the subject and and commit msg... I'll recast...

>>  		goto out;
>>  	}
>>  
>> -	if (indata[0] > 65535 || indata[1] > 255 ||
>> -	    indata[2] > 255 || indata[3] > ULONG_MAX) {
>> +	if (indata[0] > 65535 || indata[1] > 255 || indata[2] > 255) {
>>  		DMERR("Geometry exceeds range limits.");
>>  		goto out;
>>  	}
>>

MBR, Sergey
