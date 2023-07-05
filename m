Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AD1747AAD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 02:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjGEARU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 20:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjGEARS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 20:17:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF13C10EC;
        Tue,  4 Jul 2023 17:17:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3650GtYfA022836, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3650GtYfA022836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Jul 2023 08:16:55 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 5 Jul 2023 08:16:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 5 Jul 2023 08:16:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 5 Jul 2023 08:16:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()
Thread-Topic: [PATCH v2] wifi: rtw89: debug: fix error code in
 rtw89_debug_priv_send_h2c_set()
Thread-Index: AQHZrphiwDYjKTiieUyOq1vcNBvSGa+qS9AA
Date:   Wed, 5 Jul 2023 00:16:58 +0000
Message-ID: <023e7728935f49bf8307616691322c9f@realtek.com>
References: <tencent_54814178D4285CA3D64B8CDC90D49A6CB10A@qq.com>
In-Reply-To: <tencent_54814178D4285CA3D64B8CDC90D49A6CB10A@qq.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Zhang Shurong <zhang_shurong@foxmail.com>
> Sent: Wednesday, July 5, 2023 12:55 AM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: kvalo@kernel.org; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang Shurong
> <zhang_shurong@foxmail.com>
> Subject: [PATCH v2] wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()
> 
> If there is a failure during rtw89_fw_h2c_raw() rtw89_debug_priv_send_h2c
> should return negative error code instead of a positive value count.
> 
> Fix this bug by returning correct error code.
> 
> The changes in this version:
> - fix some compile error

As Larry mentioned, this should be added after delimiter '---'.

> 
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> 
> update

Also, remove this 'update'.

> ---
>  drivers/net/wireless/realtek/rtw89/debug.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
> index 1db2d59d33ff..a679f79b85ec 100644
> --- a/drivers/net/wireless/realtek/rtw89/debug.c
> +++ b/drivers/net/wireless/realtek/rtw89/debug.c
> @@ -3026,17 +3026,18 @@ static ssize_t rtw89_debug_priv_send_h2c_set(struct file *filp,
>         struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
>         struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;

Move 'int err = 0' here in reverse X'mas tree order, and use 'int ret = 0' instead,
so people don't need to guess if there is special meaning of 'err', which is just
a regular error code. 

>         u8 *h2c;
> +       int err = 0;
>         u16 h2c_len = count / 2;
> 
>         h2c = rtw89_hex2bin_user(rtwdev, user_buf, count);
>         if (IS_ERR(h2c))
>                 return -EFAULT;
> 
> -       rtw89_fw_h2c_raw(rtwdev, h2c, h2c_len);
> +       err = rtw89_fw_h2c_raw(rtwdev, h2c, h2c_len);
> 
>         kfree(h2c);
> 
> -       return count;
> +       return err ? err : count;
>  }
> 
>  static int
> --
> 2.41.0

