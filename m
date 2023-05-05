Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310846F7AD3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 04:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjEECSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 22:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEECS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 22:18:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7745FA27D;
        Thu,  4 May 2023 19:18:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3452IC110013438, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3452IC110013438
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 5 May 2023 10:18:12 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 5 May 2023 10:17:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 5 May 2023 10:17:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 5 May 2023 10:17:30 +0800
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
Thread-Index: AQHZfjq3WwrVqDL5u06W58kFX8Z8v69JN46AgACNR7D//30mAIAAhxJA///zWACAATXfYA==
Date:   Fri, 5 May 2023 02:17:30 +0000
Message-ID: <0d1ed3a748cf4cec96d5ed890939e207@realtek.com>
References: <20230504034423.20813-1-stanley_chang@realtek.com>
 <96706396-7023-b895-169a-788aad11adcb@gmail.com>
 <44451716afa541e298b2e5640fe3aec9@realtek.com>
 <747ce0a9-a629-e3f9-c59c-388333d3d911@gmail.com>
 <59143dd6704540eda26b56a1ecf350e4@realtek.com>
 <ed78530f-55b2-9152-976c-d13cf19407ad@gmail.com>
In-Reply-To: <ed78530f-55b2-9152-976c-d13cf19407ad@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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

PiA+Pj4gSSBjYW4ndCB1bmRlcnN0YW5kIHlvdXIgbWVhbmluZy4NCj4gPj4+IERvIHlvdSBtZWFu
IEkgY2FuJ3QgdXNlIHJ0ZDF4eHggPw0KPiA+Pg0KPiA+PiAgICBZb3UgY2FuJ3QsIGluZGVlZC4N
Cj4gPj4NCj4gPiBUaGUgbmFtciBydGQxeHh4IGlzIHJlcHJlc2VudCB0aGUgbmFtZSBvZiBTb0Nz
LCBmb3IgcnRkMTI5eCwgcnRkMTM5eCwNCj4gcnRkMTZ4eCwgLi4uIGV0Yy4NCj4gPg0KPiA+IE11
c3QgSSB1c2UgYSByZWFsIGNoaXAgbmFtZSwgZXhhbXBsZSBydGQxMjl4Pw0KPiANCj4gICAgWWVz
IGJ1dCBpZmYgeCBpcyBub3QgYWxzbyBhIHdpbGRjYXJkLiBydGQxMjkwIHdvdWxkIGZpdCBpZmYg
dGhhdCBTb0MgYWN0dWFsbHkNCj4gZXhpc3RzLg0KPiANCj4gPiBPciBjYW4gSSB1c2UgInJ0ZCIg
b25seSB0byByZXByZXNlbnQgYWxsIFNvY3M/DQo+IA0KPiAgICBJZiB5b3UgaGF2ZSBhIGZhbGxi
YWNrIHZhbHVlIG9mIHRoZSAiY29tcGF0aWJsZSIgcHJvcCwgeW91IGNhbiB1c2UgaXQuLi4NCg0K
SSB3aWxsIHVzZSB0aGUgbmFtZSAicnRkIiB0byBpbnN0ZWFkIHRoZSAicnRkMXh4eCIuDQoNClRo
YW5rcywNClN0YW5sZXkNCg==
