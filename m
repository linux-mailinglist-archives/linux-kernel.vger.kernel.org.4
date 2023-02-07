Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7517F68E32B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBGVxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBGVx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:53:26 -0500
Received: from omta33.uswest2.a.cloudfilter.net (omta33.uswest2.a.cloudfilter.net [35.89.44.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAAD3A5BA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 13:53:24 -0800 (PST)
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
        by cmsmtp with ESMTP
        id PIRKpFTPyII8dPVu0ppYCj; Tue, 07 Feb 2023 21:53:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id PVtzp5ijKx1YBPVtzpUzoV; Tue, 07 Feb 2023 21:53:23 +0000
X-Authority-Analysis: v=2.4 cv=OeaLszfY c=1 sm=1 tr=0 ts=63e2c853
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=m04uMKEZRckA:10
 a=wYkD_t78qR0A:10 a=XYAwZIGsAAAA:8 a=_Wotqz80AAAA:8 a=VwQbUJbxAAAA:8
 a=uBuKx8GwAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=cm27Pg_UAAAA:8
 a=VqYrzBdyEexCFwkAo-8A:9 a=QEXdDO2ut3YA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
 a=buJP51TR1BpY-zbLSsyS:22 a=AjGcO6oz07-iQ99wixmX:22 a=wZgZ3yaTFkxMEWn-yT5t:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Kozxu+Lu9GQf4DeUSmoMjgg/e36UBdioWg3iwVR23ws=; b=DdjpuonaMIcdvTNCChZ2t6+FpV
        rjMA7JRkaZCnof0nhbsBShBagbasqC4jzRuEWi2vHrftSk0+y+UGeDzj+eCgcTkprLcbhFeU31/mX
        tJntxIWmpO682DpjU0sNlsGbDgF8xm/VOX/ot/nYy1z7po0mUU/iF/hvZhs6la0emzozXpqaZRgDD
        BrspLBy1O3/DfEFBMe8opY+0ydaazosXj6jENZxw+diDEzzPoBe3sGN/gOefAt68xbLzhnCdcjKt2
        jiocnJWQIHKXLCrUEelwk+UhgErVO8+IrD/Yg8UqD+dfGWOMfJDy+rBZqsP7GPahl70A8FlhPBaJq
        g9Ugi7tw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:47838 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pPVty-003LHy-PH;
        Tue, 07 Feb 2023 15:53:22 -0600
Message-ID: <d881ad98-a291-1c9b-53dc-199f23f1625e@embeddedor.com>
Date:   Tue, 7 Feb 2023 15:53:42 -0600
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
        linux-hardening@vger.kernel.org, keescook@chromium.org
References: <cover.1663816572.git.gustavoars@kernel.org>
 <c80c0979933e0c05e80d95792ef167a28640a14b.1663816572.git.gustavoars@kernel.org>
 <CY4PR11MB12387B9F495BC7B5D0F5FD84E1DA9@CY4PR11MB1238.namprd11.prod.outlook.com>
 <16e6c434-44af-2efb-d4bc-a253e93e5590@embeddedor.com>
 <CY4PR11MB123855C0E92965CD5B46C9B6E1DB9@CY4PR11MB1238.namprd11.prod.outlook.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CY4PR11MB123855C0E92965CD5B46C9B6E1DB9@CY4PR11MB1238.namprd11.prod.outlook.com>
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
X-Exim-ID: 1pPVty-003LHy-PH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:47838
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIClfULj33ghOjU71b04TOSb6eO0vBB2m2xNLmqn2oiXSbcq/HnktC/FL/La7ZVfcNmrRMMcI/mqVCOOeoDjufkFf+Wt7RAU+WVT1pS7MpanIs4dijhn
 TbtfOmSp2s5vC+BZAyx9zReoxCuD/EYJvzPir496Z8MrxQfIHfxVz/YUgBiAI1O5+3m3jif4dCKOvDht9hcAo/HE+cfIyTY3jYtyNwF72fAUk0wBCgbzqiUS
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/23 15:08, Don.Brace@microchip.com wrote:
> 
> ________________________________
> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Sent: Monday, February 6, 2023 4:28 PM
> To: Don Brace - C33706 <Don.Brace@microchip.com>; gustavoars@kernel.org <gustavoars@kernel.org>; kevin.barnett@microsemi.com <kevin.barnett@microsemi.com>; storagedev <storagedev@microchip.com>; jejb@linux.ibm.com <jejb@linux.ibm.com>; martin.petersen@oracle.com <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org <linux-scsi@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-hardening@vger.kernel.org <linux-hardening@vger.kernel.org>; Kees Cook <keescook@chromium.org>
> Subject: Re: [PATCH 1/3][next] scsi: smartpqi: Replace one-element array with flexible-array member
> 
> 
>> NAK: What is actually happening is that we were taking on an extra list entry that is all zeros for the controller itself. This is intentional. These changes will break the driver.
> 
> Oh, great to know. :)
> 
> So, in this case, what do you think about this, instead:
> 
> diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
> index af27bb0f3133..228838eb3686 100644
> --- a/drivers/scsi/smartpqi/smartpqi.h
> +++ b/drivers/scsi/smartpqi/smartpqi.h
> @@ -954,7 +954,7 @@ struct report_log_lun {
> 
>    struct report_log_lun_list {
>           struct report_lun_header header;
> -       struct report_log_lun lun_entries[1];
> +       struct report_log_lun lun_entries[];
>    };
> 
> This HUNK is OK.
> Thanks for your patch.
> 
> Acked-by: Don Brace <don.brace@microchip.com>
> Don
> 
>    struct report_phys_lun_8byte_wwid {
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
> index d0446d4d4465..af8f1a8e9f8f 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -1277,6 +1277,10 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
>           logdev_data_length = sizeof(struct report_lun_header) +
>                   logdev_list_length;
> 
> +       /*
> +        * Notice that we take on an extra list entry (struct report_log_lun)
> +        * that is all zeros for the controller itself.
> +        */
>           internal_logdev_list = kmalloc(logdev_data_length +
>                   sizeof(struct report_log_lun), GFP_KERNEL);
>           if (!internal_logdev_list) {
> 
> The driver author has provided his input on the change to the above comment:
> 
> I think that'd I'd prefer that we just amplify the existing comment to something like this:
> 
>          /*
>           * Tack the controller itself onto the end of the logical device list
>                 * by adding a list entry that is all zeros.
>           */

OK. Great. :)

Thanks
--
Gustavo

> 
> Thank-you for your patch
> Don Brace <don.brace@microchip.com>
> 
> 
