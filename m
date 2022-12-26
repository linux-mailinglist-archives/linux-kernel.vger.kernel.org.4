Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACB16560E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 08:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiLZHtQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Dec 2022 02:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiLZHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:49:13 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7316638BA;
        Sun, 25 Dec 2022 23:49:12 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BQ7mFOX1020361, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BQ7mFOX1020361
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 26 Dec 2022 15:48:15 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 26 Dec 2022 15:49:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 26 Dec 2022 15:49:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b]) by
 RTEXMBS04.realtek.com.tw ([fe80::15b5:fc4b:72f3:424b%5]) with mapi id
 15.01.2375.007; Mon, 26 Dec 2022 15:49:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Masanari Iida <standby24x7@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifl: rtw89: Fix a typo in debug message
Thread-Topic: [PATCH] wifl: rtw89: Fix a typo in debug message
Thread-Index: AQHZFrhFp9+a6iFOlkKPuSkmjbsSfq5/ziiQgAAA5qA=
Date:   Mon, 26 Dec 2022 07:49:07 +0000
Message-ID: <a2db890c081544bfa23d62e2a956a5c1@realtek.com>
References: <20221223102058.162179-1-standby24x7@gmail.com>
 <6703100d830544c59be69abd9cce7f92@realtek.com>
In-Reply-To: <6703100d830544c59be69abd9cce7f92@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/12/26_=3F=3F_04:37:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ping-Ke Shih <pkshih@realtek.com>
> Sent: Monday, December 26, 2022 3:44 PM
> To: Masanari Iida <standby24x7@gmail.com>; linux-kernel@vger.kernel.org; linux-wireless@vger.kernel.org
> Subject: RE: [PATCH] wifl: rtw89: Fix a typo in debug message
> 
> > -----Original Message-----
> > From: Masanari Iida <standby24x7@gmail.com>
> > Sent: Friday, December 23, 2022 6:21 PM
> > To: linux-kernel@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>; linux-wireless@vger.kernel.org
> > Cc: Masanari Iida <standby24x7@gmail.com>
> > Subject: [PATCH] wifl: rtw89: Fix a typo in debug message

Oops. It should be "wifi:" instead "wifl:".
Please fix the typo.

> >
> > This patch fixes a spelling typo in debug message.
> >
> > Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> 
> > ---
> >  drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> > b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> > index 582ff0d3a9ea..cd6c39b7f802 100644
> > --- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> > +++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
> > @@ -1643,7 +1643,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
> >  	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
> >
> >  	rtw89_debug(rtwdev, RTW89_DBG_RFK,
> > -		    "[IQK]==========IQK strat!!!!!==========\n");
> > +		    "[IQK]==========IQK start!!!!!==========\n");
> >  	iqk_info->iqk_times++;
> >  	iqk_info->kcount = 0;
> >  	iqk_info->version = RTW8852A_IQK_VER;
> > --
> > 2.38.1
> 
> 
> ------Please consider the environment before printing this e-mail.
