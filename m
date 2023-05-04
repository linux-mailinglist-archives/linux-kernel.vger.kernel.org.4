Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3EF6F676B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjEDI3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjEDI3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:29:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D02855A8;
        Thu,  4 May 2023 01:26:17 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3448Q2qsC028464, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3448Q2qsC028464
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 4 May 2023 16:26:02 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 4 May 2023 16:26:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 4 May 2023 16:26:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 4 May 2023 16:26:06 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] usb: dwc3: core: add support for realtek SoCs custom's global register start address
Thread-Topic: [PATCH v5] usb: dwc3: core: add support for realtek SoCs
 custom's global register start address
Thread-Index: AQHZfjq3WwrVqDL5u06W58kFX8Z8v69JN46AgACNR7A=
Date:   Thu, 4 May 2023 08:26:06 +0000
Message-ID: <44451716afa541e298b2e5640fe3aec9@realtek.com>
References: <20230504034423.20813-1-stanley_chang@realtek.com>
 <96706396-7023-b895-169a-788aad11adcb@gmail.com>
In-Reply-To: <96706396-7023-b895-169a-788aad11adcb@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA1LzQvMjMgNjo0NCBBTSwgU3RhbmxleSBDaGFuZyB3cm90ZToNCj4gDQo+ID4gVGhlIFJl
YWx0ZWsgUlREMXh4eCBTb0NzIHdlcmUgZGVzaWduZWQsIHRoZSBnbG9iYWwgcmVnaXN0ZXIgYWRk
cmVzcw0KPiA+IG9mZnNldCBhdCAweDgxMDAuDQo+IA0KPiAgIENhbid0IHBhcnNlIHRoYXQsIHBl
cmhhcHMgIndpdGgiIGlzIG1pc3Npbmc/DQo+IA0KPiA+IFRoZSBkZWZhdWx0IGFkZHJlc3Mgb2Zm
c2V0IGlzIGNvbnN0YW50IGF0IERXQzNfR0xPQkFMU19SRUdTX1NUQVJUDQo+ID4gKDB4YzEwMCku
IFRoZXJlZm9yZSwgYWRkIGEgY2hlY2sgaWYgdGhlIGNvbXBhdGlibGUgbmFtZSBvZiB0aGUgcGFy
ZW50DQo+ID4gaXMgInJlYWx0ZWsscnRkMXh4eC1kd2MzIiwgdGhlbiBnbG9iYWwNCj4gDQo+ICAg
IFdpbGRjYXJkcyBhcmUgbm90IGFsbG93ZWQgaW4gdGhlICJjb21wYXRpYmxlIiBwcm9wcy4uLg0K
DQpJIGNhbid0IHVuZGVyc3RhbmQgeW91ciBtZWFuaW5nLg0KRG8geW91IG1lYW4gSSBjYW4ndCB1
c2UgcnRkMXh4eCA/DQoNCg==
