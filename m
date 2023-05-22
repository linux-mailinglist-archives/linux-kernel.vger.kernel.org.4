Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4082170B2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjEVBq3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 21 May 2023 21:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjEVBq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:46:27 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B288AD7;
        Sun, 21 May 2023 18:46:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34M1k5k75018981, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34M1k5k75018981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 22 May 2023 09:46:05 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 22 May 2023 09:46:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 22 May 2023 09:46:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 22 May 2023 09:46:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "Peter Robinson" <pbrobinson@gmail.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
Subject: RE: [PATCH wireless-next v1 3/4] mmc: sdio: Add/rename SDIO ID of the RTL8723DS SDIO wifi cards
Thread-Topic: [PATCH wireless-next v1 3/4] mmc: sdio: Add/rename SDIO ID of
 the RTL8723DS SDIO wifi cards
Thread-Index: AQHZiaRU2yqqdyKoHUKqEdo0JlyLb69litiw
Date:   Mon, 22 May 2023 01:46:14 +0000
Message-ID: <2ffdaf9f38fa4886ab5d2a5b8323d584@realtek.com>
References: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
 <20230518161749.1311949-4-martin.blumenstingl@googlemail.com>
In-Reply-To: <20230518161749.1311949-4-martin.blumenstingl@googlemail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Sent: Friday, May 19, 2023 12:18 AM
> To: linux-wireless@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; ulf.hansson@linaro.org; kvalo@kernel.org;
> tony0620emma@gmail.com; Peter Robinson <pbrobinson@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>;
> jernej.skrabec@gmail.com; Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Subject: [PATCH wireless-next v1 3/4] mmc: sdio: Add/rename SDIO ID of the RTL8723DS SDIO wifi cards
> 
> RTL8723DS comes in two variant and each of them has their own SDIO ID:
> - 0xd723 can connect two antennas. The WiFi part is still 1x1 so the
>   second antenna can be dedicated to Bluetooth
> - 0xd724 can only connect one antenna so it's shared between WiFi and
>   Bluetooth
> 
> Add a new entry for the single antenna RTL8723DS (0xd724) which can be
> found on the MangoPi MQ-Quad. Also rename the existing RTL8723DS entry
> (0xd723) so it's name reflects that it's the variant with support for
> two antennas.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  include/linux/mmc/sdio_ids.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index c653accdc7fd..7fada7a714fe 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -121,7 +121,8 @@
>  #define SDIO_DEVICE_ID_REALTEK_RTW8822BS       0xb822
>  #define SDIO_DEVICE_ID_REALTEK_RTW8821CS       0xc821
>  #define SDIO_DEVICE_ID_REALTEK_RTW8822CS       0xc822
> -#define SDIO_DEVICE_ID_REALTEK_RTW8723DS       0xd723
> +#define SDIO_DEVICE_ID_REALTEK_RTW8723DS_2ANT  0xd723
> +#define SDIO_DEVICE_ID_REALTEK_RTW8723DS_1ANT  0xd724
>  #define SDIO_DEVICE_ID_REALTEK_RTW8821DS       0xd821
> 
>  #define SDIO_VENDOR_ID_SIANO                   0x039a
> --
> 2.40.1

