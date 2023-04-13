Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A3C6E0A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjDMJhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjDMJhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:37:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E113903C;
        Thu, 13 Apr 2023 02:37:13 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33D9aanG7025474, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33D9aanG7025474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 13 Apr 2023 17:36:36 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 13 Apr 2023 17:36:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 13 Apr 2023 17:36:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Thu, 13 Apr 2023 17:36:58 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] dt-bindings: usb: snps,dwc3: Add 'snps,parkmode-disable-hs-quirk' quirk
Thread-Topic: [PATCH v3 2/2] dt-bindings: usb: snps,dwc3: Add
 'snps,parkmode-disable-hs-quirk' quirk
Thread-Index: AQHZbeV4n9ISXGFxX0ujqFU22ysHaK8oboUAgACKbHA=
Date:   Thu, 13 Apr 2023 09:36:58 +0000
Message-ID: <6c2dae45c7ca490d889ddc7a0dab027f@realtek.com>
References: <20230413085351.26808-1-stanley_chang@realtek.com>
 <2023041346-shamrock-sterilize-9165@gregkh>
In-Reply-To: <2023041346-shamrock-sterilize-9165@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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

PiBUaGlzIGlzIG5vdCBwcm9wZXJseSB0aHJlYWRlZCB3aXRoIHBhdGNoIDEvMiBmb3Igc29tZSBy
ZWFzb24sIHNvIG91ciB0b29scyBjYW4NCj4gbm90IHBpY2sgdXAgdGhlIHdob2xlIHRocmVhZCBh
dCBvbmNlLiAgUGxlYXNlIGZpeCB1cCB5b3VyIHNlbmRpbmcgc2NyaXB0LCBvcg0KPiBqdXN0IHVz
ZSBnaXQgc2VuZC1lbWFpbCBkaXJlY3RseS4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1o
DQo+IA0KDQpJIHNlbmQgdGhlIHBhdGNoIGJ5IGdpdCBzZW5kLWVtYWlsLg0KDQpnaXQgc2VuZC1l
bWFpbCAtLWNjPSJTdGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPiIgLS10
bz0iVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPiIgLS1jYy1jbWQ9Jy4v
c2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtbm9yb2xlc3RhdHMgdjMtMDAwMS11c2ItZHdjMy1j
b3JlLWFkZC1zdXBwb3J0LWZvci1kaXNhYmxpbmctSGlnaC1zcGVlLnBhdGNoJyAtLWFubm90YXRl
IHYzLTAwMDEtdXNiLWR3YzMtY29yZS1hZGQtc3VwcG9ydC1mb3ItZGlzYWJsaW5nLUhpZ2gtc3Bl
ZS5wYXRjaA0KDQpnaXQgc2VuZC1lbWFpbCAtLWNjPSJTdGFubGV5IENoYW5nIDxzdGFubGV5X2No
YW5nQHJlYWx0ZWsuY29tPiIgLS10bz0iVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3Bz
eXMuY29tPiIgLS1jYy1jbWQ9Jy4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtbm9yb2xlc2F0
cyB2My0wMDAyLWR0LWJpbmRpbmdzLXVzYi1zbnBzLWR3YzMtQWRkLXNucHMtcGFya21vZGUtZGlz
YWIucGF0Y2gnIC0tYW5ub3RhdGUgdjMtMDAwMi1kdC1iaW5kaW5ncy11c2Itc25wcy1kd2MzLUFk
ZC1zbnBzLXBhcmttb2RlLWRpc2FiLnBhdGNoDQoNCkkgZG9uJ3Qga25vdyB3aHkgaXQgY2FuJ3Qg
dGhyZWFkIHdpdGggMiBwYXRjaGVzPw0KRG8gSSBuZWVkIHRvIHJlc2VuZCB2NCBwYXRjaD8NCk9y
IGhvdyBjYW4gSSB0byByZXNvbHZlIHRoaXMgcHJvYmxlbT8NCg0KDQoNCg==
