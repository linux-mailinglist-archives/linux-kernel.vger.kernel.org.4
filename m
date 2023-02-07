Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF8168E435
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBGXJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBGXJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:09:19 -0500
Received: from omta37.uswest2.a.cloudfilter.net (omta37.uswest2.a.cloudfilter.net [35.89.44.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8B7367C8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 15:08:53 -0800 (PST)
Received: from eig-obgw-6018a.ext.cloudfilter.net ([10.0.30.233])
        by cmsmtp with ESMTP
        id PS3epA2RiYHR1PX50pXQJ1; Tue, 07 Feb 2023 23:08:50 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id PX4zpK970y1hcPX50pldnm; Tue, 07 Feb 2023 23:08:50 +0000
X-Authority-Analysis: v=2.4 cv=cqSILn0i c=1 sm=1 tr=0 ts=63e2da02
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=m04uMKEZRckA:10
 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=_Wotqz80AAAA:8 a=lepexe-JEeTRwUq4UYcA:9 a=QEXdDO2ut3YA:10
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
 a=buJP51TR1BpY-zbLSsyS:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ED4y54RMLPXzNI1joWSXaV4TBbQzFSz900g2AHgM1Ro=; b=P0mahWdIRcjVu7mRciLzvxhWo2
        zH53lbynCFt2QyDV/S0rRfXsJ0c592YM6fT91me/yHXehAttNjFSsOVRFNPjHIWbbUTy6i/SPMyvF
        AYMSZoPJS1bXb5ATyIfwHF1oJE3gX9p4O0gpPEMwRvfGxKlByKnzdrnB37TppNxG2lBymgMhsAPE9
        Dak3tZmi22bo1TCrSkUNcyfQWy/RImJ9qrEj85ATjjWCY3iquvF2lk/xdzwVhvyOWGUx9U3V5VZR7
        1pfzSm09lRKSMec3QJrZB73mm/ByrPlszkxH7cuE+iofjzonKwhr89DFGcRR7XRqd0G1hcuzXVyBG
        ziYj2jGA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:56074 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pPX4y-000Jun-Tl;
        Tue, 07 Feb 2023 17:08:49 -0600
Message-ID: <22599902-57bb-a137-047e-867f35b45b69@embeddedor.com>
Date:   Tue, 7 Feb 2023 17:09:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3][next] scsi: smartpqi: Replace one-element array with
 flexible-array member
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Y+LJz/r6+UeLqnV3@work>
 <63e2d840.170a0220.2b199.00a7@mx.google.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <63e2d840.170a0220.2b199.00a7@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1pPX4y-000Jun-Tl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:56074
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKjTyjr5lkneV+jPCPlVcF1qoHJUD949zU8zMyowvzXEFAZhABfKQbuEL+JfKi4C8cn78J9UTb3x+AvYHSBrp7cVQWvHvh0TXzHKN+RqdTeyCWDYhoD6
 ZW28i8hV9RZAyoAP4+QXB16kgltMzkg/aSRZh01p2cr5Wt/SY+JsdMr0QIgNLCWqUxQ3poa7V35aDHdbqdklo/cn1UQ0ahokZYIbuXfGEympLEQOJtPV43sC
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/23 17:01, Kees Cook wrote:
> On Tue, Feb 07, 2023 at 03:59:43PM -0600, Gustavo A. R. Silva wrote:
>> One-element arrays are deprecated, and we are replacing them with flexible
>> array members instead. So, replace one-element array with flexible-array
>> member in struct report_log_lun_list.
>>
>> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
>> on memcpy().
>>
>> Link: https://github.com/KSPP/linux/issues/79
>> Link: https://github.com/KSPP/linux/issues/204
>> Acked-by: Don Brace <don.brace@microchip.com>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Looks good to me -- both before and after, there is 1 extra all-zero
> entry at the end. But now the struct is using a flex array correctly.

Yep. :)

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!
--
Gustavo

> 
> -Kees
> 
>> ---
>> Changes in v3:
>>   - Amplify the existing comment instead of adding a new one. By Don
>>     Brace[1].
>>   - Add Don's Acked-by tag to the changelog.
>>     Link: https://lore.kernel.org/linux-hardening/d881ad98-a291-1c9b-53dc-199f23f1625e@embeddedor.com/ [1]
>>
>> Changes in v2:
>>   - In v1 we thought that the original code was allocating one too-many
>>     entries for the list. However, Don Brace commented that the allocation
>>     was actually intentional[2]. So, I added a code comment with his feedback.
>>     Link: https://lore.kernel.org/linux-hardening/16e6c434-44af-2efb-d4bc-a253e93e5590@embeddedor.com/  [2]
>>
>> v1:
>>   - Link: https://lore.kernel.org/linux-hardening/c80c0979933e0c05e80d95792ef167a28640a14b.1663816572.git.gustavoars@kernel.org/
>>
>>   drivers/scsi/smartpqi/smartpqi.h      | 2 +-
>>   drivers/scsi/smartpqi/smartpqi_init.c | 3 ++-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
>> index af27bb0f3133..228838eb3686 100644
>> --- a/drivers/scsi/smartpqi/smartpqi.h
>> +++ b/drivers/scsi/smartpqi/smartpqi.h
>> @@ -954,7 +954,7 @@ struct report_log_lun {
>>   
>>   struct report_log_lun_list {
>>   	struct report_lun_header header;
>> -	struct report_log_lun lun_entries[1];
>> +	struct report_log_lun lun_entries[];
>>   };
>>   
>>   struct report_phys_lun_8byte_wwid {
>> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
>> index d0446d4d4465..49a8f91810b6 100644
>> --- a/drivers/scsi/smartpqi/smartpqi_init.c
>> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
>> @@ -1259,7 +1259,8 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
>>   			"report logical LUNs failed\n");
>>   
>>   	/*
>> -	 * Tack the controller itself onto the end of the logical device list.
>> +	 * Tack the controller itself onto the end of the logical device list
>> +	 * by adding a list entry that is all zeros.
>>   	 */
>>   
>>   	logdev_data = *logdev_list;
>> -- 
>> 2.34.1
>>
> 
