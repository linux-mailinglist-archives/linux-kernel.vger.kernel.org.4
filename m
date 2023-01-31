Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CAC683753
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjAaUOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjAaUOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:14:30 -0500
Received: from omta35.uswest2.a.cloudfilter.net (omta35.uswest2.a.cloudfilter.net [35.89.44.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8643F5894E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:14:12 -0800 (PST)
Received: from eig-obgw-6018a.ext.cloudfilter.net ([10.0.30.233])
        by cmsmtp with ESMTP
        id MfGVp1nEKE9lPMx1ApFu0T; Tue, 31 Jan 2023 20:14:12 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id Mx19paStay1hcMx19pCFfx; Tue, 31 Jan 2023 20:14:11 +0000
X-Authority-Analysis: v=2.4 cv=cqSILn0i c=1 sm=1 tr=0 ts=63d97693
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=RvmDmJFTN0MA:10
 a=wYkD_t78qR0A:10 a=8pif782wAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=mDV3o1hIAAAA:8 a=rQwXfPfrytjjklgZoK0A:9 a=QEXdDO2ut3YA:10 a=o-vr1ZrRZO8A:10
 a=3SQbtOYribkA:10 a=AjGcO6oz07-iQ99wixmX:22 a=_FVE-zBwftR9WsbkzFJk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=w7c0OSkAfjTz5fKechJKG0JstQNvIvF9iDgA1jWVlfI=; b=ln7Guya0Fn0+7ib+RlmLCQW/7Z
        /we4xbNByB0hqPXLQfXAzLihIxfJBvw8qJ9upNCtmJ5lIh7/DIPmuL5sUQ1PaARHft1MQSXGGZPhJ
        jjkHNlBsNNAF6JaWOCQ0GWAZC4mzIa299NtFJq0QnCGZeQesogBFbwvFJcfsMneP3QgbUSjQTVRIv
        grdQ2mDsS2tkcQI66bcGpXirfrBYSb31o6my8S/62O/osQ0WWCGxhEA9EkmMygqewcNlcna/dMXve
        OBLjGMJkY3rNCauW/Q79JjGSAYoBzI+Kkz3VodV5eZ08TxQ3DLSsHe1aBdvxig9CiKGL8oDtlEqA+
        uXMwrNJw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:57042 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pMx18-0033gy-FB;
        Tue, 31 Jan 2023 14:14:10 -0600
Message-ID: <ab1caeae-4bf2-ab03-36f7-40b04f34f007@embeddedor.com>
Date:   Tue, 31 Jan 2023 14:14:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/3][next] scsi: smartpqi: Replace one-element arrays with
 flexible-array members
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        Don Brace <don.brace@microchip.com>, storagedev@microchip.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1663816572.git.gustavoars@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <cover.1663816572.git.gustavoars@kernel.org>
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
X-Exim-ID: 1pMx18-0033gy-FB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:57042
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfM6HHn7kbzLuTLLwRmITvKTomt+0odICH7ug5LS40r/5HWLWqPKJ89Ts3fQXTomiWeesZ46DE1njmIPqO8nMdTNh064IycWYdKIkJCgE9FvhpvSHKNuN
 Afo2s5pltinXk9wiMdQA2pJIk/J678PL9Q4xy39KUWyXPEKBClNggOJ5XzwzQ60+Wg/Wwc12YJiBMOLszZsXw/43j3UyOnqeLeFTEh9cgkPT/Wk7Qid8U4fg
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping: who can review/take this, please? :)

Thanks
--
Gustavo

On 9/21/22 23:26, Gustavo A. R. Silva wrote:
> Hi!
> 
> This series aims to replace one-element arrays with flexible-array
> members in drivers/scsi/smartpqi/smartpqi.h
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://en.wikipedia.org/wiki/Flexible_array_member
> Link: https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> 
> Gustavo A. R. Silva (3):
>    scsi: smartpqi: Replace one-element array with flexible-array member
>    scsi: smartpqi: Replace one-element arrays with flexible-array members
>    scsi: smartpqi: Use struct_size() helper in pqi_report_phys_luns()
> 
>   drivers/scsi/smartpqi/smartpqi.h      |  6 +++---
>   drivers/scsi/smartpqi/smartpqi_init.c | 12 ++++--------
>   2 files changed, 7 insertions(+), 11 deletions(-)
> 
