Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FDF68C953
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjBFW2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBFW2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:28:12 -0500
Received: from omta035.useast.a.cloudfilter.net (omta035.useast.a.cloudfilter.net [44.202.169.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732DBA5DA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:28:11 -0800 (PST)
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
        by cmsmtp with ESMTP
        id P8AupTZJwsq1sP9y6p6Taf; Mon, 06 Feb 2023 22:28:10 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id P9y5psbO1VU6VP9y5pFH4K; Mon, 06 Feb 2023 22:28:09 +0000
X-Authority-Analysis: v=2.4 cv=Z/j/oVdA c=1 sm=1 tr=0 ts=63e17ef9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=m04uMKEZRckA:10
 a=wYkD_t78qR0A:10 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=uBuKx8GwAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=_EeEMxcBAAAA:8 a=NEAV23lmAAAA:8
 a=P2NOn8ILFETLmG1s00YA:9 a=QEXdDO2ut3YA:10 a=0gt-Z038NCQA:10
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22 a=wZgZ3yaTFkxMEWn-yT5t:22
 a=syqr5EOPB93U0NEwqYpB:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oBRdVV4OQ9+UkcuWmevW9ANGZ4beTCdlnFfFZ1evJM4=; b=MgGFqT0a1dhZ0a+L/MbZT1xpII
        lBpBCElDN/5C18sVWItHWGQ3IQZQZd9q1nVtfUMOoW5C/BzYwjxQCSmUkw6ERkdGcWP8s8Gkf0Q+N
        lxs1W9X/yBIDF/MQrNx5BHdXH5M/OjdN9GO9Lm6vuHDicK4IxiV5LHoHzFJZ1SyXquTWAmSvAG0ij
        jRpA71i5ronROxe6mcF20N5qk5TvMyOxOof66iIKkDr9chk7IAkGoVwIYCjSx9rpHpAl5EidZOFkw
        bkYYcZC+ZoOXWPVHAM3L1SvAOWYbECAGuBadiwkRpKqH6dF7R6PjC29FFzTkcdePAq9uTCRW2JKaQ
        hwHNfe6A==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:41250 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pP9y4-000JJQ-Ex;
        Mon, 06 Feb 2023 16:28:08 -0600
Message-ID: <16e6c434-44af-2efb-d4bc-a253e93e5590@embeddedor.com>
Date:   Mon, 6 Feb 2023 16:28:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3][next] scsi: smartpqi: Replace one-element array with
 flexible-array member
Content-Language: en-US
To:     Don.Brace@microchip.com, gustavoars@kernel.org,
        kevin.barnett@microsemi.com, storagedev@microchip.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <cover.1663816572.git.gustavoars@kernel.org>
 <c80c0979933e0c05e80d95792ef167a28640a14b.1663816572.git.gustavoars@kernel.org>
 <CY4PR11MB12387B9F495BC7B5D0F5FD84E1DA9@CY4PR11MB1238.namprd11.prod.outlook.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CY4PR11MB12387B9F495BC7B5D0F5FD84E1DA9@CY4PR11MB1238.namprd11.prod.outlook.com>
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
X-Exim-ID: 1pP9y4-000JJQ-Ex
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:41250
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfM5PhJDnXIrB5XVCp3uekKyASS0qnkT3Rtmvfjb9lTUWbun0LVrH2KNFqjx35QCZVCKWxGOwDAZXCfGFkX6HbPolpn0n4tPLJeAQusOQWFG3CafG1ABz
 bwCyz69UEpFmCgnWcLqxgTeEvyNVtsC+kz3t84yOKMsrRFG+Iefg2mLXHAM0lYVylM4mTQ1QG4aiU0c7668wADaL4cyyPzOprjmg7fmSHzWYpy/D3XgryOoQ
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/23 15:58, Don.Brace@microchip.com wrote:
> 
> ________________________________
> From: Gustavo A. R. Silva <gustavoars@kernel.org>
> Sent: Wednesday, September 21, 2022 11:28 PM
> To: Kevin Barnett <kevin.barnett@microsemi.com>; Don Brace - C33706 <Don.Brace@microchip.com>; storagedev <storagedev@microchip.com>; James E.J. Bottomley <jejb@linux.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org <linux-scsi@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Gustavo A. R. Silva <gustavoars@kernel.org>; linux-hardening@vger.kernel.org <linux-hardening@vger.kernel.org>
> Subject: [PATCH 1/3][next] scsi: smartpqi: Replace one-element array with flexible-array member
> 
> [Some people who received this message don't often get email from gustavoars@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct MR_DRV_RAID_MAP and refactor the the rest of the code
> accordingly.
> 
> It seems that the addition of sizeof(struct report_log_lun) in all the
> places that are modified by this patch is due to the fact that
> the one-element array struct report_log_lun lun_entries[1]; always
> contributes to the size of the containing structure struct
> report_log_lun_list.
> 
> Notice that at line 1267 while allocating memory for an instance of
> struct report_log_lun_list, some _extra_ space seems to be allocated
> for one element of type struct report_log_lun, which is the type of
> the elements in array lun_entries:
> 
>   1267         internal_logdev_list = kmalloc(logdev_data_length +
>   1268                 sizeof(struct report_log_lun), GFP_KERNEL);
> 
> However, at line 1275 just logdev_data_length bytes are copied into
> internal_logdev_list (remember that we allocated space for logdev_data_length +
> sizeof(struct report_log_lun) bytes at line 1267), and then exactly
> sizeof(struct report_log_lun) bytes are being zeroing out at line 1276.
> 
>   1275         memcpy(internal_logdev_list, logdev_data, logdev_data_length);
>   1276         memset((u8 *)internal_logdev_list + logdev_data_length, 0,
>   1277                 sizeof(struct report_log_lun));
> 
> All the above makes think that it's just fine if we transform array
> lun_entries into a flexible-array member and just don't allocate
> that extra sizeof(struct report_log_lun) bytes of space. With this
> we can remove that memset() call and we also need to modify the code
> that updates the total length (internal_logdev_list->header.list_length)
> of array lun_entries at line 1278:
> 
>   1278         put_unaligned_be32(logdev_list_length +
>   1279                 sizeof(struct report_log_lun),
>   1280                 &internal_logdev_list->header.list_length);
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/204
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> NAK: What is actually happening is that we were taking on an extra list entry that is all zeros for the controller itself. This is intentional. These changes will break the driver.

Oh, great to know. :)

So, in this case, what do you think about this, instead:

diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
index af27bb0f3133..228838eb3686 100644
--- a/drivers/scsi/smartpqi/smartpqi.h
+++ b/drivers/scsi/smartpqi/smartpqi.h
@@ -954,7 +954,7 @@ struct report_log_lun {

  struct report_log_lun_list {
         struct report_lun_header header;
-       struct report_log_lun lun_entries[1];
+       struct report_log_lun lun_entries[];
  };

  struct report_phys_lun_8byte_wwid {
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index d0446d4d4465..af8f1a8e9f8f 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1277,6 +1277,10 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
         logdev_data_length = sizeof(struct report_lun_header) +
                 logdev_list_length;

+       /*
+        * Notice that we take on an extra list entry (struct report_log_lun)
+        * that is all zeros for the controller itself.
+        */
         internal_logdev_list = kmalloc(logdev_data_length +
                 sizeof(struct report_log_lun), GFP_KERNEL);
         if (!internal_logdev_list) {


Thanks for the feedback!
--
Gustavo

> 
> Thanks,
> Don Brace <don.brace@microchip.com>
> 
> 
> ---
> And of course, it'd be great if maintainers can confirm what I described
> in the changelog text. :)
> 
>   drivers/scsi/smartpqi/smartpqi.h      |  2 +-
>   drivers/scsi/smartpqi/smartpqi_init.c | 10 +++-------
>   2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
> index e550b12e525a..d1756c9d1112 100644
> --- a/drivers/scsi/smartpqi/smartpqi.h
> +++ b/drivers/scsi/smartpqi/smartpqi.h
> @@ -954,7 +954,7 @@ struct report_log_lun {
> 
>   struct report_log_lun_list {
>          struct report_lun_header header;
> -       struct report_log_lun lun_entries[1];
> +       struct report_log_lun lun_entries[];
>   };
> 
>   struct report_phys_lun_8byte_wwid {
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
> index b971fbe3b3a1..544cd18a90d7 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -1264,8 +1264,7 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
>          logdev_data_length = sizeof(struct report_lun_header) +
>                  logdev_list_length;
> 
> -       internal_logdev_list = kmalloc(logdev_data_length +
> -               sizeof(struct report_log_lun), GFP_KERNEL);
> +       internal_logdev_list = kmalloc(logdev_data_length, GFP_KERNEL);
>          if (!internal_logdev_list) {
>                  kfree(*logdev_list);
>                  *logdev_list = NULL;
> @@ -1273,11 +1272,8 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
>          }
> 
>          memcpy(internal_logdev_list, logdev_data, logdev_data_length);
> -       memset((u8 *)internal_logdev_list + logdev_data_length, 0,
> -               sizeof(struct report_log_lun));
> -       put_unaligned_be32(logdev_list_length +
> -               sizeof(struct report_log_lun),
> -               &internal_logdev_list->header.list_length);
> +       put_unaligned_be32(logdev_list_length,
> +                          &internal_logdev_list->header.list_length);
> 
>          kfree(*logdev_list);
>          *logdev_list = internal_logdev_list;
> --
> 2.34.1
> 
> 
