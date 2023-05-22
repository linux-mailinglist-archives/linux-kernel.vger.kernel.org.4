Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF970B2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjEVBtS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 21 May 2023 21:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjEVBtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:49:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFABB1;
        Sun, 21 May 2023 18:49:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34M1mrMW3022805, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34M1mrMW3022805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 22 May 2023 09:48:53 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 22 May 2023 09:49:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 22 May 2023 09:49:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 22 May 2023 09:49:04 +0800
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
Subject: RE: [PATCH wireless-next v1 4/4] wifi: rtw88: Add support for the SDIO based RTL8723DS chipset
Thread-Topic: [PATCH wireless-next v1 4/4] wifi: rtw88: Add support for the
 SDIO based RTL8723DS chipset
Thread-Index: AQHZiaRUZtMcbe/6JkOj8+lFfFXG4q9liyOQ
Date:   Mon, 22 May 2023 01:49:03 +0000
Message-ID: <c52c11c712e24e1fb783c2ce1251aba5@realtek.com>
References: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
 <20230518161749.1311949-5-martin.blumenstingl@googlemail.com>
In-Reply-To: <20230518161749.1311949-5-martin.blumenstingl@googlemail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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
> Subject: [PATCH wireless-next v1 4/4] wifi: rtw88: Add support for the SDIO based RTL8723DS chipset
> 
> Wire up RTL8723DS chipset support using the rtw88 SDIO HCI code as well
> as the existing RTL8723D chipset code.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I'm so surprised that this small patchset can support an new chip. Nice job. :-)

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

