Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E38E702BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbjEOLxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241491AbjEOLxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:53:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FD55257;
        Mon, 15 May 2023 04:40:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34FBe30k9015761, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34FBe30k9015761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 15 May 2023 19:40:03 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 15 May 2023 19:40:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 15 May 2023 19:40:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 15 May 2023 19:40:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "rudi@heitbaum.com" <rudi@heitbaum.com>
Subject: Re: [PATCH wireless v1] wifi: rtw88: sdio: Always use two consecutive bytes for word operations
Thread-Topic: [PATCH wireless v1] wifi: rtw88: sdio: Always use two
 consecutive bytes for word operations
Thread-Index: AQHZhp8/d2Ix7H9Kp0Kc7VStDQy2qK9aesbQgACwxU3//4UPgA==
Date:   Mon, 15 May 2023 11:40:11 +0000
Message-ID: <4b19e201e33576bc83ab28c7c92771da64e7673e.camel@realtek.com>
References: <20230514200345.502807-1-martin.blumenstingl@googlemail.com>
         <a0bf69fdb10b42a989a9b14e490e2f07@realtek.com> <87mt25n9ll.fsf@kernel.org>
In-Reply-To: <87mt25n9ll.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.73.33]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <543963F18A1734489CF844553F6AD12E@realtek.com>
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

T24gTW9uLCAyMDIzLTA1LTE1IGF0IDEzOjU5ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyaXRlczoNCj4gDQo+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTWFydGluIEJsdW1lbnN0aW5n
bCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6IE1vbmRh
eSwgTWF5IDE1LCAyMDIzIDQ6MDQgQU0NCj4gPiA+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtl
cm5lbC5vcmcNCj4gPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IHRvbnkwNjIwZW1tYUBnbWFpbC5jb207DQo+ID4g
PiBrdmFsb0BrZXJuZWwub3JnOyBNYXJ0aW4gQmx1bWVuc3RpbmdsIDxtYXJ0aW4uYmx1bWVuc3Rp
bmdsQGdvb2dsZW1haWwuY29tPjsgTGFycnkgRmluZ2VyDQo+ID4gPiA8TGFycnkuRmluZ2VyQGx3
ZmluZ2VyLm5ldD47IFJ1ZGkgSGVpdGJhdW0gPHJ1ZGlAaGVpdGJhdW0uY29tPg0KPiA+ID4gU3Vi
amVjdDogW1BBVENIIHdpcmVsZXNzIHYxXSB3aWZpOiBydHc4ODogc2RpbzogQWx3YXlzIHVzZSB0
d28gY29uc2VjdXRpdmUgYnl0ZXMgZm9yIHdvcmQNCj4gPiA+IG9wZXJhdGlvbnMNCj4gPiA+IA0K
PiA+ID4gVGhlIEFsbHdpbm5lciBzdW54aS1tbWMgY29udHJvbGxlciBjYW5ub3QgaGFuZGxlIHdv
cmQgKDE2IGJpdCkNCj4gPiA+IHRyYW5zZmVycy4gU28gYW5kIHNkaW9fe3JlYWQsd3JpdGV9dyBm
YWlscyB3aXRoIG1lc3NhZ2VzIGxpa2UgdGhlDQo+ID4gPiBmb2xsb3dpbmcgZXhhbXBsZSB1c2lu
ZyBhbiBSVEw4ODIyQlMgKGJ1dCB0aGUgc2FtZSBwcm9ibGVtcyB3ZXJlIGFsc28NCj4gPiA+IG9i
c2VydmVkIHdpdGggUlRMODgyMkNTIGFuZCBSVEw4NzIzRFMgY2hpcHMpOg0KPiA+ID4gICBydHdf
ODgyMmJzIG1tYzE6MDAwMToxOiBGaXJtd2FyZSB2ZXJzaW9uIDI3LjIuMCwgSDJDIHZlcnNpb24g
MTMNCj4gPiA+ICAgc3VueGktbW1jIDQwMjEwMDAubW1jOiB1bmFsaWduZWQgc2NhdHRlcmxpc3Q6
IG9zIGY4MCBsZW5ndGggMg0KPiA+ID4gICBzdW54aS1tbWMgNDAyMTAwMC5tbWM6IG1hcCBETUEg
ZmFpbGVkDQo+ID4gPiAgIHJ0d184ODIyYnMgbW1jMTowMDAxOjE6IHNkaW8gcmVhZDE2IGZhaWxl
ZCAoMHgxMDIzMCk6IC0yMg0KPiA+ID4gDQo+ID4gPiBVc2UgdHdvIGNvbnNlY3V0aXZlIHNpbmds
ZSBieXRlIGFjY2Vzc2VzIGZvciB3b3JkIG9wZXJhdGlvbnMgaW5zdGVhZC4gSXQNCj4gPiA+IHR1
cm5zIG91dCB0aGF0IHVwb24gY2xvc2VyIGluc3BlY3Rpb24gdGhpcyBpcyBhbHNvIHdoYXQgdGhl
IHZlbmRvcg0KPiA+ID4gZHJpdmVyIGRvZXMsIGV2ZW4gdGhvdWdoIGl0IGRvZXMgaGF2ZSBzdXBw
b3J0IGZvciBzZGlvX3tyZWFkLHdyaXRlfXcuIFNvDQo+ID4gPiB3ZSBjYW4gY29uY2x1ZGUgdGhh
dCB0aGUgcnR3ODggY2hpcHMgZG8gc3VwcG9ydCB3b3JkIGFjY2VzcyBidXQgb25seSBvbg0KPiA+
ID4gU0RJTyBjb250cm9sbGVycyB0aGF0IGFsc28gc3VwcG9ydCBpdC4gU2luY2UgdGhlcmUncyBu
byB3YXkgdG8gZGV0ZWN0IGlmDQo+ID4gPiB0aGUgY29udHJvbGxlciBzdXBwb3J0cyB3b3JkIGFj
Y2VzcyBvciBub3QgdGhlIHJ0dzg4IHNkaW8gZHJpdmVyDQo+ID4gPiBzd2l0Y2hlcyB0byB0aGUg
ZWFzaWVzdCBhcHByb2FjaDogYXZvaWRpbmcgd29yZCBhY2Nlc3MuDQo+ID4gPiANCj4gPiA+IFJl
cG9ydGVkLWJ5OiBMYXJyeSBGaW5nZXIgPExhcnJ5LkZpbmdlckBsd2Zpbmdlci5uZXQ+DQo+ID4g
PiBDbG9zZXM6IA0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3Mv
NTI3NTg1ZTUtOWNkZC02NmVkLWMzYWYtNmRhMTYyZjRiNzIwQGx3ZmluZ2VyLm5ldC8NCj4gPiAN
Cj4gPiAiQ2xvc2VzOiIgc2VlbXMgbm90IGEgcmVndWxhciB0YWcuIFVzZSAiTGluazogIiBpbnN0
ZWFkLg0KPiANCj4gQWN0dWFsbHkgdGhlIGRvY3VtZW50YXRpb24gbm93IHRhbGtzIGFib3V0IENs
b3NlcyB0YWc6DQo+IA0KPiBodHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzLzUuUG9zdGlu
Zy5odG1sI3BhdGNoLWZvcm1hdHRpbmctYW5kLWNoYW5nZWxvZ3MNCj4gDQo+IEkgZ3Vlc3MgdGhp
cyB0YWcgaXMgYSByZWNlbnQgYWRkaXRpb24/DQo+IA0KDQpUaGFua3MgZm9yIGluZm9ybWF0aW9u
LiANCg0KVGhlbiwgdGhpcyBwYXRjaCBsb29rcyBnb29kIHRvIG1lLg0KDQpSZXZpZXdlZC1ieTog
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg==
