Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E046DF2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDLLQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDLLQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:16:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA65868D;
        Wed, 12 Apr 2023 04:15:35 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33CBEAZP0014228, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33CBEAZP0014228
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 12 Apr 2023 19:14:10 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 12 Apr 2023 19:14:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 12 Apr 2023 19:14:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Wed, 12 Apr 2023 19:14:31 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] usb: dwc3: core: add support for remapping global register start address
Thread-Topic: [PATCH v2 1/2] usb: dwc3: core: add support for remapping global
 register start address
Thread-Index: AQHZbO8TMZxQ6xFEbEmr471D6ePiYq8nhUxA
Date:   Wed, 12 Apr 2023 11:14:31 +0000
Message-ID: <25395b3fdffc43379ee11b36361dd930@realtek.com>
References: <20230412033006.10859-1-stanley_chang@realtek.com>
In-Reply-To: <20230412033006.10859-1-stanley_chang@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpDQyBtb3JlIG1haW50YWluZXJzIGJ5IHVzaW5nIHNjcmlwdHMvZ2V0X21haW50YWluZXJzLnBs
DQoNClRoYW5rcywNClN0YW5sZXkNCg0K
