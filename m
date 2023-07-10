Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C3974C93E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 02:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjGJAZp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Jul 2023 20:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGJAZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 20:25:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36257114;
        Sun,  9 Jul 2023 17:25:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36A0PJwyC019293, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36A0PJwyC019293
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Jul 2023 08:25:19 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 10 Jul 2023 08:25:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 10 Jul 2023 08:25:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 10 Jul 2023 08:25:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH AUTOSEL 6.4 03/26] wifi: rtw89: 8851be: add 8851BE PCI entry and fill PCI capabilities
Thread-Topic: [PATCH AUTOSEL 6.4 03/26] wifi: rtw89: 8851be: add 8851BE PCI
 entry and fill PCI capabilities
Thread-Index: AQHZsnfgXMSGHzodCUaXywPdVBk+uK+yI1DA
Date:   Mon, 10 Jul 2023 00:25:24 +0000
Message-ID: <b8854720cdd2412b920c7b548d7eebd6@realtek.com>
References: <20230709151255.512931-1-sashal@kernel.org>
 <20230709151255.512931-3-sashal@kernel.org>
In-Reply-To: <20230709151255.512931-3-sashal@kernel.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sasha Levin <sashal@kernel.org>
> Sent: Sunday, July 9, 2023 11:13 PM
> To: linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Cc: Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>; Sasha Levin <sashal@kernel.org>;
> linux-wireless@vger.kernel.org
> Subject: [PATCH AUTOSEL 6.4 03/26] wifi: rtw89: 8851be: add 8851BE PCI entry and fill PCI capabilities
> 
> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> [ Upstream commit 99ff8da56322cda9eb9b37021e27b127c2d1cad8 ]
> 
> Add PCI entry to 8851BE with its device ID 10ec:b851, also fill PCI info
> according to its capabilities.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Link: https://lore.kernel.org/r/20230421024551.29994-3-pkshih@realtek.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Please don't take this patch to 6.4, 6.3, 6.1, and other stable branches. 
With this patch, it still can't enable 8851BE, so let kernel 6.5 to be the
first version that supports 8851BE.

Thank you
Ping-Ke

