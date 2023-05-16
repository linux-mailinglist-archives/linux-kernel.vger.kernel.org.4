Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5947049BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjEPJzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjEPJzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:55:32 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9331713
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:55:26 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 96E2324E339;
        Tue, 16 May 2023 17:55:23 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 16 May
 2023 17:55:23 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX066.cuchost.com
 (172.16.7.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 16 May
 2023 17:55:23 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 16 May 2023 17:55:23 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Song Shuai <suagrfillet@gmail.com>,
        "alexghiti@rivosinc.com" <alexghiti@rivosinc.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@rivosinc.com" <palmer@rivosinc.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Bug report: kernel paniced when system hibernates
Thread-Topic: Bug report: kernel paniced when system hibernates
Thread-Index: AQHZh9g1UxpK4+O/SUareMzY680B/K9cp3zQ
Date:   Tue, 16 May 2023 09:55:23 +0000
Message-ID: <5902235c8f5046be9cbd7411955ec43e@EXMBX066.cuchost.com>
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
In-Reply-To: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [60.53.70.89]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU29uZywNCg0KVGhhbmtzIGZvciB0aGUgaW52ZXN0aWdhdGlvbi4gSW5kZWVkLCB0aGUgZXhw
b3N1cmUgb2YgdGhlIFBNUCByZXNlcnZlZCByZWdpb24gdG8gdGhlIGtlcm5lbCBwYWdlIHRhYmxl
IGlzIGNhdXNpbmcgdGhlIHByb2JsZW0uDQpIZXJlIGlzIHRoZSBzaW1pbGFyIHJlcG9ydDogaHR0
cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS91LzAvYS9ncm91cHMucmlzY3Yub3JnL2cvc3ctZGV2L2Mv
SVRYd2FLZkE2ejgNCg0KVGhhbmtzDQpSZWdhcmRzDQpKZWUgSGVuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNvbmcgU2h1YWkgPHN1YWdyZmlsbGV0QGdtYWlsLmNv
bT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDE2LCAyMDIzIDU6MjQgUE0NCj4gVG86IGFsZXhnaGl0
aUByaXZvc2luYy5jb207IHJvYmhAa2VybmVsLm9yZzsgQW5kcmV3IEpvbmVzIDxham9uZXNAdmVu
dGFuYW1pY3JvLmNvbT47IGFudXBAYnJhaW5mYXVsdC5vcmc7DQo+IHBhbG1lckByaXZvc2luYy5j
b207IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPjsgTGV5Zm9vbiBU
YW4gPGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+OyBNYXNvbiBIdW8NCj4gPG1hc29uLmh1
b0BzdGFyZml2ZXRlY2guY29tPjsgUGF1bCBXYWxtc2xleSA8cGF1bC53YWxtc2xleUBzaWZpdmUu
Y29tPjsgQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT47IEd1bw0KPiBS
ZW4gPGd1b3JlbkBrZXJuZWwub3JnPg0KPiBDYzogbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBCdWcgcmVwb3J0
OiBrZXJuZWwgcGFuaWNlZCB3aGVuIHN5c3RlbSBoaWJlcm5hdGVzDQo+IA0KPiBEZXNjcmlwdGlv
biBvZiBwcm9ibGVtOg0KPiANCj4gVGhlIGxhdGVzdCBoaWJlcm5hdGlvbiBzdXBwb3J0WzFdIG9m
IFJJU0MtViBMaW51eCBwcm9kdWNlZCBhIGtlcm5lbCBwYW5pYy4NCj4gVGhlIGVudGlyZSBsb2cg
aGFzIGJlZW4gcG9zdGVkIGF0IHRoaXMgbGluazogaHR0cHM6Ly90ZXJtYmluLmNvbS9zcGhsIC4N
Cj4gDQo+IEhvdyByZXByb2R1Y2libGU6DQo+IA0KPiBZb3UgY2FuIHJlcHJvZHVjZSBpdCB3aXRo
IHRoZSBmb2xsb3dpbmcgc3RlcCA6DQo+IA0KPiAxLiBwcmVwYXJlIHRoZSBlbnZpcm9ubWVudCB3
aXRoDQo+IC0gUWVtdS12aXJ0IHY4LjAuMCAod2l0aCBPcGVuU2JpIHYxLjIpDQo+IC0gTGludXgg
djYuNC1yYzENCj4gDQo+IDIuIHN0YXJ0IHRoZSBRZW11IHZpcnQNCj4gYGBgc2gNCj4gJCBjYXQg
fi84X3Jpc2N2L3N0YXJ0X2xhdGVzdC5zaA0KPiAjIS9iaW4vYmFzaA0KPiAvaG9tZS9zb25nLzhf
cmlzY3YvM19hY3BpL3FlbXUvb29vL3Vzci9sb2NhbC9iaW4vcWVtdS1zeXN0ZW0tcmlzY3Y2NCBc
DQo+IC1zbXAgMiAtbSA0RyAtbm9ncmFwaGljIC1tYWNoaW5lIHZpcnQgXA0KPiAta2VybmVsIC9o
b21lL3NvbmcvOV9saW51eC9saW51eC8wMF9ydl90ZXN0L2FyY2gvcmlzY3YvYm9vdC9JbWFnZSBc
DQo+IC1hcHBlbmQgInJvb3Q9L2Rldi92ZGEgcm8gZWF5bHljb249dWFydDgyNTAsbW1pbywweDEw
MDAwMDAwDQo+IGVhcmx5X2lvcmVtYXBfZGVidWcgY29uc29sZT10dHlTMCBsb2dsZXZlbD04IG1l
bWJsb2NrPWRlYnVnDQo+IG5vX2NvbnNvbGVfc3VzcGVuZCBhdWRpdD0wIDMiIFwNCj4gLWRyaXZl
IGZpbGU9L2hvbWUvc29uZy84X3Jpc2N2L2ZlZG9yYS9zdGFnZTQtZGlzay5pbWcsZm9ybWF0PXJh
dyxpZD1oZDAgXA0KPiAtZGV2aWNlIHZpcnRpby1ibGstZGV2aWNlLGRyaXZlPWhkMCBcDQo+IC1k
cml2ZSBmaWxlPS9ob21lL3NvbmcvOF9yaXNjdi9mZWRvcmEvYWRpc2sucWNvdzIsZm9ybWF0PXFj
b3cyLGlkPWhkMSBcDQo+IC1kZXZpY2UgdmlydGlvLWJsay1kZXZpY2UsZHJpdmU9aGQxIFwNCj4g
LWdkYiB0Y3A6OjEyMzYgIy1TDQo+IGBgYA0KPiAzLiBleGVjdXRlIGhpYmVybmF0aW9uDQo+IA0K
PiBgYGBzaA0KPiBzd2Fwb24gL2Rldi92ZGIyICMgdGhpcyBpcyBteSBzd2FwIGRpc2sNCj4gDQo+
IGVjaG8gZGlzayA+IC9zeXMvcG93ZXIvc3RhdGUNCj4gYGBgDQo+IA0KPiA0LiBUaGVuIHlvdSB3
aWxsIGVuY291bnRlciB0aGUga2VybmVsIHBhbmljIGxvZ2dlZCBpbiB0aGUgYWJvdmUgbGluaw0K
PiANCj4gDQo+IE90aGVyIEluZm9ybWF0aW9uOg0KPiANCj4gQWZ0ZXIgbXkgaW5pdGlhbCBhbmQg
aW5jb21wbGV0ZSBkaWctdXAsIHRoZSBjb21taXQgKDMzMzUwNjhmODcyMQ0KPiAicmlzY3Y6IFVz
ZSBQVUQvUDREL1BHRCBwYWdlcyBmb3IgdGhlIGxpbmVhciBtYXBwaW5nIilbMl0NCj4gaXMgY2xv
c2VseSByZWxhdGVkIHRvIHRoaXMgcGFuaWMuIFRoaXMgY29tbWl0IHVzZXMgcmUtZGVmaW5lZA0K
PiBgTUlOX01FTUJMT0NLX0FERFJgIHRvIGRpc2NvdmVyIHRoZSBlbnRpcmUgc3lzdGVtIG1lbW9y
eQ0KPiBhbmQgZXh0ZW5kcyB0aGUgYHZhX3BhX29mZnNldGAgZnJvbSBga2VybmVsX21hcC5waHlz
X2FkZHJgIHRvDQo+IGBwaHlzX3JhbV9iYXNlYCBmb3IgbGluZWFyIG1lbW9yeSBtYXBwaW5nLg0K
PiANCj4gSWYgdGhlIGZpcm13YXJlIGRlbGl2ZXJlZCB0aGUgZmlybXdhcmUgbWVtb3J5IHJlZ2lv
biAobGlrZTogYSBQTVANCj4gcHJvdGVjdGVkIHJlZ2lvbiBpbiBPcGVuU2JpKSB3aXRob3V0ICJu
by1tYXAiIHByb3ByaWV0eSwNCj4gdGhpcyBjb21taXQgd2lsbCByZXN1bHQgaW4gZmlybXdhcmUg
bWVtb3J5IGJlaW5nIGRpcmVjdGx5IG1hcHBlZCBieQ0KPiBgY3JlYXRlX2xpbmVhcl9tYXBwaW5n
X3BhZ2VfdGFibGUoKWAuDQo+IA0KPiBXZSBjYW4gc2VlIHRoZSBtYXBwaW5nIHZpYSBwdGR1bXAg
Og0KPiBgYGBjDQo+IC0tLVsgTGluZWFyIG1hcHBpbmcgXS0tLQ0KPiAweGZmNjAwMDAwMDAwMDAw
MDAtMHhmZjYwMDAwMDAwMjAwMDAwIDB4MDAwMDAwMDA4MDAwMDAwMCAyTSBQTUQgRCBBIEcNCj4g
LiAuIFcgUiBWIC0tLS0tLS0tLS0tLS0gdGhlIGZpcm13YXJlIG1lbW9yeQ0KPiAweGZmNjAwMDAw
MDAyMDAwMDAtMHhmZjYwMDAwMDAwYzAwMDAwIDB4MDAwMDAwMDA4MDIwMDAwMCAxME0gUE1EIEQg
QSBHIC4gLiAuIFIgVg0KPiAweGZmNjAwMDAwMDBjMDAwMDAtMHhmZjYwMDAwMDAxMDAwMDAwIDB4
MDAwMDAwMDA4MGMwMDAwMCA0TSBQTUQgRCBBIEcgLiAuIFcgUiBWDQo+IDB4ZmY2MDAwMDAwMTAw
MDAwMC0weGZmNjAwMDAwMDE2MDAwMDAgMHgwMDAwMDAwMDgxMDAwMDAwIDZNIFBNRCBEIEEgRyAu
IC4gLiBSIFYNCj4gMHhmZjYwMDAwMDAxNjAwMDAwLTB4ZmY2MDAwMDA0MDAwMDAwMCAweDAwMDAw
MDAwODE2MDAwMDAgMTAwMk0gUE1EIEQgQQ0KPiBHIC4gLiBXIFIgVg0KPiAweGZmNjAwMDAwNDAw
MDAwMDAtMHhmZjYwMDAwMTAwMDAwMDAwIDB4MDAwMDAwMDBjMDAwMDAwMCAzRyBQVUQgRCBBIEcg
LiAuIFcgUiBWDQo+IC0tLVsgTW9kdWxlcy9CUEYgbWFwcGluZyBdLS0tDQo+IC0tLVsgS2VybmVs
IG1hcHBpbmcgXS0tLQ0KPiAweGZmZmZmZmZmODAwMDAwMDAtMHhmZmZmZmZmZjgwYTAwMDAwIDB4
MDAwMDAwMDA4MDIwMDAwMCAxME0gUE1EIEQgQSBHIC4gWCAuIFIgVg0KPiAweGZmZmZmZmZmODBh
MDAwMDAtMHhmZmZmZmZmZjgwYzAwMDAwIDB4MDAwMDAwMDA4MGMwMDAwMCAyTSBQTUQgRCBBIEcg
LiAuIC4gUiBWDQo+IDB4ZmZmZmZmZmY4MGMwMDAwMC0weGZmZmZmZmZmODBlMDAwMDAgMHgwMDAw
MDAwMDgwZTAwMDAwIDJNIFBNRCBEIEEgRyAuIC4gVyBSIFYNCj4gMHhmZmZmZmZmZjgwZTAwMDAw
LTB4ZmZmZmZmZmY4MTQwMDAwMCAweDAwMDAwMDAwODEwMDAwMDAgNk0gUE1EIEQgQSBHIC4gLiAu
IFIgVg0KPiAweGZmZmZmZmZmODE0MDAwMDAtMHhmZmZmZmZmZjgxODAwMDAwIDB4MDAwMDAwMDA4
MTYwMDAwMCA0TSBQTUQNCj4gYGBgDQo+IA0KPiBJbiB0aGUgaGliZXJuYXRpb24gcHJvY2Vzcywg
YHN3c3VzcF9zYXZlKClgIGNhbGxzDQo+IGBjb3B5X2RhdGFfcGFnZXMoJmNvcHlfYm0sICZvcmln
X2JtKWAgdG8gY29weSB0aGVzZSB0d28gbWVtb3J5DQo+IGJpdG1hcHMsDQo+IHRoZSBPb3BzKGxv
YWQgYWNjZXNzIGZhdWx0KSBvY2N1cnJlZCB3aGlsZSBjb3B5aW5nIHRoZSBwYWdlIG9mDQo+IFBB
R0VfT0ZGU0VUICh3aGljaCBtYXBzIHRoZSBmaXJtd2FyZSBtZW1vcnkpLg0KPiANCj4gSSBhbHNv
IGRpZCB0d28gb3RoZXIgdGVzdHM6DQo+IFRlc3QxOg0KPiANCj4gVGhlIGhpYmVybmF0aW9uIHdv
cmtzIHdlbGwgaW4gdGhlIGtlcm5lbCB3aXRoIHRoZSBjb21taXQgMzMzNTA2OGY4NzIxDQo+IHJl
dmVydGVkIGF0IGxlYXN0IGluIHRoZSBjdXJyZW50IGVudmlyb25tZW50Lg0KPiANCj4gVGVzdDI6
DQo+IA0KPiBJIGJ1aWx0IGEgc2ltcGxlIGtlcm5lbCBtb2R1bGUgdG8gc2ltdWxhdGUgdGhlIGFj
Y2VzcyBvZiB0aGUgdmFsdWUgb2YNCj4gYFBBR0VfT0ZGU0VUYCBhZGRyZXNzLCBhbmQgdGhlIHNh
bWUgcGFuaWMgb2NjdXJyZWQgd2l0aCB0aGUgbG9hZA0KPiBhY2Nlc3MgZmF1bHQuDQo+IFNvIGhp
YmVybmF0aW9uIHNlZW1zIG5vdCB0aGUgb25seSBjYXNlIHRvIHRyaWdnZXIgdGhpcyBwYW5pYy4N
Cj4gDQo+IEZpbmFsbHksIHNob3VsZCB3ZSBhbHdheXMgbGVhdmUgdGhlIGZpcm13YXJlIG1lbW9y
eSB3aXRoDQo+IGBNRU1CTE9DS19OT01BUGAgZmxhZyBieSBzb21lIGVmZm9ydHMgZnJvbSBMaW51
eCBvciBPcGVuU2JpIChhdCBsZWFzdA0KPiBpbiB0aGUgY3VycmVudCBlbnZpcm9ubWVudCkgb3Ig
YW55IG90aGVyIHN1Z2dlc3Rpb25zPw0KPiANCj4gUGxlYXNlIGNvcnJlY3QgbWUgaWYgSSdtIHdy
b25nLg0KPiANCj4gWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwMzMwMDY0MzIx
LjEwMDgzNzMtNS1qZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tDQo+IFsyXTogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvci8yMDIzMDMyNDE1NTQyMS4yNzE1NDQtNC1hbGV4Z2hpdGlAcml2b3Np
bmMuY29tDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IFNvbmcNCg==
