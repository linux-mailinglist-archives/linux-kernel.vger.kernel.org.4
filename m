Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96B3682C99
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjAaMdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjAaMdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:33:49 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7DF29438;
        Tue, 31 Jan 2023 04:33:46 -0800 (PST)
Received: from [192.168.1.103] (31.173.86.113) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Tue, 31 Jan
 2023 15:33:41 +0300
Subject: Re: [PATCH] libata: clean up some inconsistent indenting
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230131085431.30549-1-jiapeng.chong@linux.alibaba.com>
 <d8d117bf-4ab1-3473-85e2-00f1b1a85cba@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d5a59ca8-1b17-9cf2-80d0-3e267e558fd5@omp.ru>
Date:   Tue, 31 Jan 2023 15:33:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d8d117bf-4ab1-3473-85e2-00f1b1a85cba@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.86.113]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 01/31/2023 12:18:15
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 175146 [Jan 31 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;bugzilla.openanolis.cn:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.86.113
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/31/2023 12:20:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/31/2023 10:39:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/23 2:26 PM, Damien Le Moal wrote:
[...]
>> No functional modification involved.
>>
>> drivers/ata/pata_serverworks.c:443 serverworks_init_one() warn: inconsistent indenting.
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3905
>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>> ---
>>  drivers/ata/pata_serverworks.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
>> index c0bc4af0d196..c6bd9e95d4e8 100644
>> --- a/drivers/ata/pata_serverworks.c
>> +++ b/drivers/ata/pata_serverworks.c
>> @@ -434,10 +434,9 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
>>  		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
>>  		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) {
>>  
>> -		 /* If the returned btr is the newer revision then
>> -		    select the right info block */
>> -		 if (rc == 3)
>> -		 	ppi[0] = &info[3];
>> +		/* If the returned btr is the newer revision then select the right info block */
> 
> Very long line. Please make that a proper multi-line comment.

   Perhaps the material of a separate patch?

> And the patch title should be:
> 
> ata: pata_serverworks: clean up indentation

   Yes!

[...]

MBR, Sergey
