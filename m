Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95342693B80
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 01:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjBMA52 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 12 Feb 2023 19:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBMA50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 19:57:26 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F895240
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 16:57:25 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31D0v8cP5003820, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31D0v8cP5003820
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 13 Feb 2023 08:57:08 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 13 Feb 2023 08:57:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 13 Feb 2023 08:57:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 13 Feb 2023 08:57:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Dan Carpenter <error27@gmail.com>,
        "oe-kbuild@lists.linux.dev" <oe-kbuild@lists.linux.dev>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>
Subject: RE: drivers/net/wireless/realtek/rtw89/mac.c:3829 rtw89_mac_cfg_ppdu_status() warn: missing error code? 'ret'
Thread-Topic: drivers/net/wireless/realtek/rtw89/mac.c:3829
 rtw89_mac_cfg_ppdu_status() warn: missing error code? 'ret'
Thread-Index: AQHZPXeahvA2gD/Wl06jmE9Ze/ex9K7MEMyA
Date:   Mon, 13 Feb 2023 00:57:08 +0000
Message-ID: <5884ba04b5364eab9c875139fa1f408b@realtek.com>
References: <202302101023.ctlih5q0-lkp@intel.com>
In-Reply-To: <202302101023.ctlih5q0-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2023/2/12_=3F=3F_10:00:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Dan Carpenter <error27@gmail.com>
> Sent: Saturday, February 11, 2023 12:11 AM
> To: oe-kbuild@lists.linux.dev; Ping-Ke Shih <pkshih@realtek.com>
> Cc: lkp@intel.com; oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org; Kalle Valo
> <kvalo@kernel.org>
> Subject: drivers/net/wireless/realtek/rtw89/mac.c:3829 rtw89_mac_cfg_ppdu_status() warn: missing error
> code? 'ret'
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e544a07438522ab3688416e6e2e34bf0ee6d8755
> commit: 7ba49f4c6896d83b3841c0b046a0a7b1e97cc0dd rtw89: 8852c: add 8852ce to Makefile and Kconfig
> config: parisc-randconfig-m031-20230209
> (https://download.01.org/0day-ci/archive/20230210/202302101023.ctlih5q0-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202302101023.ctlih5q0-lkp@intel.com/
> 
> smatch warnings:
> drivers/net/wireless/realtek/rtw89/mac.c:3829 rtw89_mac_cfg_ppdu_status() warn: missing error code? 'ret'
> 
> vim +/ret +3829 drivers/net/wireless/realtek/rtw89/mac.c
> 
> e3ec7017f6a20d Ping-Ke Shih  2021-10-11  3818  int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8
> mac_idx, bool enable)
> e3ec7017f6a20d Ping-Ke Shih  2021-10-11  3819  {
> e3ec7017f6a20d Ping-Ke Shih  2021-10-11  3820  	u32 reg = rtw89_mac_reg_by_idx(R_AX_PPDU_STAT, mac_idx);
> e3ec7017f6a20d Ping-Ke Shih  2021-10-11  3821  	int ret = 0;
> e3ec7017f6a20d Ping-Ke Shih  2021-10-11  3822
> e3ec7017f6a20d Ping-Ke Shih  2021-10-11  3823  	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx,
> RTW89_CMAC_SEL);
> e3ec7017f6a20d Ping-Ke Shih  2021-10-11  3824  	if (ret)
> e3ec7017f6a20d Ping-Ke Shih  2021-10-11  3825  		return ret;
> e3ec7017f6a20d Ping-Ke Shih  2021-10-11  3826
> e3ec7017f6a20d Ping-Ke Shih  2021-10-11  3827  	if (!enable) {
> e3ec7017f6a20d Ping-Ke Shih  2021-10-11  3828  		rtw89_write32_clr(rtwdev, reg,
> B_AX_PPDU_STAT_RPT_EN);
> e3ec7017f6a20d Ping-Ke Shih  2021-10-11 @3829  		return ret;
> 
> The code is correct, but it would be more readable to return 0;

Yes, it will be more readable. I will send a patch to change them soon.
Thanks for pointing out this.

Ping-Ke


