Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9C06F679B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjEDIgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEDIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:36:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23534A6;
        Thu,  4 May 2023 01:36:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3448aKRk9016839, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3448aKRk9016839
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 4 May 2023 16:36:20 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 4 May 2023 16:36:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 4 May 2023 16:36:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 4 May 2023 16:36:25 +0800
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
Thread-Index: AQHZfjq3WwrVqDL5u06W58kFX8Z8v69JN46AgACNR7D//30mAIAAhxJA
Date:   Thu, 4 May 2023 08:36:24 +0000
Message-ID: <59143dd6704540eda26b56a1ecf350e4@realtek.com>
References: <20230504034423.20813-1-stanley_chang@realtek.com>
 <96706396-7023-b895-169a-788aad11adcb@gmail.com>
 <44451716afa541e298b2e5640fe3aec9@realtek.com>
 <747ce0a9-a629-e3f9-c59c-388333d3d911@gmail.com>
In-Reply-To: <747ce0a9-a629-e3f9-c59c-388333d3d911@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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

DQo+ID4gSSBjYW4ndCB1bmRlcnN0YW5kIHlvdXIgbWVhbmluZy4NCj4gPiBEbyB5b3UgbWVhbiBJ
IGNhbid0IHVzZSBydGQxeHh4ID8NCj4gDQo+ICAgIFlvdSBjYW4ndCwgaW5kZWVkLg0KPiANClRo
ZSBuYW1yIHJ0ZDF4eHggaXMgcmVwcmVzZW50IHRoZSBuYW1lIG9mIFNvQ3MsIGZvciBydGQxMjl4
LCBydGQxMzl4LCBydGQxNnh4LCAuLi4gZXRjLg0KDQpNdXN0IEkgdXNlIGEgcmVhbCBjaGlwIG5h
bWUsIGV4YW1wbGUgcnRkMTI5eD8NCk9yIGNhbiBJIHVzZSAicnRkIiBvbmx5IHRvIHJlcHJlc2Vu
dCBhbGwgU29jcz8NCg0K
