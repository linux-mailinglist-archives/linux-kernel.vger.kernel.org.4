Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9A70EB49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbjEXCVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEXCVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:21:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947C5198;
        Tue, 23 May 2023 19:21:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34O2LEYa8030191, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34O2LEYa8030191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 24 May 2023 10:21:14 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 24 May 2023 10:21:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 24 May 2023 10:21:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 24 May 2023 10:21:25 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] wifi: rtw89: coex: Fix __write_overflow_field error
Thread-Topic: [PATCH][next] wifi: rtw89: coex: Fix __write_overflow_field
 error
Thread-Index: AQHZjeUfoZQNequdOUWsjmGdWAjtMa9osDuw
Date:   Wed, 24 May 2023 02:21:25 +0000
Message-ID: <b45c71d19add4f749a687e5ca483244b@realtek.com>
References: <ZG1ynqdAnXArMfBE@work>
In-Reply-To: <ZG1ynqdAnXArMfBE@work>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VzdGF2byBBLiBSLiBT
aWx2YSA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAyNCwg
MjAyMyAxMDoxMyBBTQ0KPiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBL
YWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBHdXN0YXZvIEEuIFIuIFNp
bHZhDQo+IDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+OyBsaW51eC1oYXJkZW5pbmdAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF1bbmV4dF0gd2lmaTogcnR3ODk6IGNvZXg6IEZpeCBf
X3dyaXRlX292ZXJmbG93X2ZpZWxkIGVycm9yDQo+IA0KPiBPbmUtZWxlbWVudCBhcnJheXMgYXMg
ZmFrZSBmbGV4aWJsZSBhcnJheXMgYXJlIGRlcHJlY2F0ZWQsIGFuZCB3ZSBhcmUNCj4gbW92aW5n
IHRvd2FyZHMgYWRvcHRpbmcgQzk5IGZsZXhpYmxlLWFycmF5IG1lbWJlcnMgaW5zdGVhZC4NCj4g
DQo+IEZpeCB0aGUgZm9sbG93aW5nIGVycm9yIHNlZW4gdW5kZXIgR0NDLTEzIGFuZCAtZnN0cmlj
dC1mbGV4LWFycmF5cz0zOg0KPiBJbiBmdW5jdGlvbiDigJhmb3J0aWZ5X21lbWNweV9jaGvigJks
DQo+ICAgICBpbmxpbmVkIGZyb20g4oCYX2FwcGVuZF90ZG1h4oCZIGF0IGRyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29leC5jOjE1Nzk6MzoNCj4gaW5jbHVkZS9saW51eC9mb3J0
aWZ5LXN0cmluZy5oOjU4MzoyNTogZXJyb3I6IGNhbGwgdG8g4oCYX193cml0ZV9vdmVyZmxvd19m
aWVsZOKAmSBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZQ0KPiB3YXJuaW5nOiBkZXRlY3RlZCB3cml0
ZSBiZXlvbmQgc2l6ZSBvZiBmaWVsZCAoMXN0IHBhcmFtZXRlcik7IG1heWJlIHVzZSBzdHJ1Y3Rf
Z3JvdXAoKT8NCj4gWy1XZXJyb3I9YXR0cmlidXRlLXdhcm5pbmddDQo+ICAgNTgzIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgX193cml0ZV9vdmVyZmxvd19maWVsZChwX3NpemVfZmllbGQsIHNp
emUpOw0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiANCj4gVGhpcyBoZWxwcyB3aXRoIHRoZSBvbmdv
aW5nIGVmZm9ydHMgdG8gdGlnaHRlbiB0aGUgRk9SVElGWV9TT1VSQ0UNCj4gcm91dGluZXMgb24g
bWVtY3B5KCkgYW5kIGhlbHAgdXMgbWFrZSBwcm9ncmVzcyB0b3dhcmRzIGdsb2JhbGx5DQo+IGVu
YWJsaW5nIC1mc3RyaWN0LWZsZXgtYXJyYXlzPTMgWzFdLg0KPiANCj4gVGhpcyByZXN1bHRzIGlu
IG5vIGRpZmZlcmVuY2VzIGluIGJpbmFyeSBvdXRwdXQuDQo+IA0KPiBMaW5rOiBodHRwczovL2dp
dGh1Yi5jb20vS1NQUC9saW51eC9pc3N1ZXMvMjENCj4gTGluazogaHR0cHM6Ly9naXRodWIuY29t
L0tTUFAvbGludXgvaXNzdWVzLzI5OQ0KPiBMaW5rOiBodHRwczovL2djYy5nbnUub3JnL3BpcGVy
bWFpbC9nY2MtcGF0Y2hlcy8yMDIyLU9jdG9iZXIvNjAyOTAyLmh0bWwgWzFdDQo+IFNpZ25lZC1v
ZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9hcnNAa2VybmVsLm9yZz4NCj4gLS0t
DQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvZXguYyB8IDIgKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29leC5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9jb2V4LmMNCj4gaW5kZXggM2E1ODZhOTcx
ZThmLi5iZGEwZTFlOTlhOGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODkvY29leC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODkvY29leC5jDQo+IEBAIC0yMDYsNyArMjA2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBy
dHc4OV9idGNfdmVyIHJ0dzg5X2J0Y192ZXJfZGVmc1tdID0gew0KPiAgc3RydWN0IHJ0dzg5X2J0
Y19idGZfdGx2IHsNCj4gICAgICAgICB1OCB0eXBlOw0KPiAgICAgICAgIHU4IGxlbjsNCj4gLSAg
ICAgICB1OCB2YWxbMV07DQo+ICsgICAgICAgdTggdmFsW107DQo+ICB9IF9fcGFja2VkOw0KPiAN
Cj4gIGVudW0gYnRjX2J0Zl9zZXRfcmVwb3J0X2VuIHsNCg0KQXJuZCBoYXMgc2VudCB0aGUgc2Ft
ZSBwYXRjaCBbMV0gYXMgeW91cnMuIA0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtd2lyZWxlc3MvMjdhNzAxMGRlOGJlNDAwNmEzZTRiOTVlODUxNzgxYzZAcmVhbHRlay5jb20v
VC8jbWNhNjE5YzgyNjFiODdiODhlZWRkMzkxY2VhZmIzNGM0MGQ1MTNjZTUNCg0K
