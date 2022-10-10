Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F285F9AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiJJII3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 04:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiJJIIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:08:25 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C37564DE;
        Mon, 10 Oct 2022 01:08:19 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id D40D7122D25;
        Mon, 10 Oct 2022 10:08:16 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C346F121349;
        Mon, 10 Oct 2022 10:08:16 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Mon, 10 Oct 2022 10:08:16 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 10 Oct
 2022 10:08:16 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Mon, 10 Oct 2022 10:08:16 +0200
From:   =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2 1/2] mmc: block: Remove error check of hw_reset on reset
Thread-Topic: [PATCHv2 1/2] mmc: block: Remove error check of hw_reset on
 reset
Thread-Index: AdjaYu5u2TzZtJoER6CJQ4u+nZWuhAAfZYwAAGeu3xA=
Date:   Mon, 10 Oct 2022 08:08:16 +0000
Message-ID: <27343e2a17d1481f9a62d710480bc041@hyperstone.com>
References: <003d34d1643242488b533dc14f69830f@hyperstone.com>
 <e6acc89d-7d17-62ee-d67a-b78b1cdcd085@intel.com>
In-Reply-To: <e6acc89d-7d17-62ee-d67a-b78b1cdcd085@intel.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.46]
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27192.006
X-TMASE-Result: 10--9.415300-10.000000
X-TMASE-MatchedRID: gIwa0kWWszLUL3YCMmnG4vHkpkyUphL9t7k6BDMlB1hOxrPj90/dKGuJ
        DYJwJ/rlM21CreAEMZimmCZmjD3OP/t1xYHpY/PCrmLeMrcoM6hPnKxAOPp4WXy/Hx1AgJrrql7
        8LqyIlpc5raJItbvwp+affHI8kAmiHY/bzRmIaZHOvXpg7ONnXfWr7HvOSElauBsk5njfgGxXy5
        WRrp2ko/DUx4bwhs9g3TErNngKo62ZStso8r+rZ6jFA2STVo+4sk61leL8Ml8/gf7afIrQU9SxJ
        QWn8D5K4vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0Ubv+efAnnZBiL8z+Ba7+nv3uNtko
        0to1c3ImNNq+l0p9IPQY2t5KLO3rKGdxl/SWHeN+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: ee7e6519-70e2-4e84-aeeb-536d9f5279f9-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBBZHJpYW4gSHVudGVyIDxh
ZHJpYW4uaHVudGVyQGludGVsLmNvbT4gDQo+U2VudDogU2Ftc3RhZywgOC4gT2t0b2JlciAyMDIy
IDEwOjM4DQo+VG86IENocmlzdGlhbiBMw7ZobGUgPENMb2VobGVAaHlwZXJzdG9uZS5jb20+OyBV
bGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IExpbnV4IE1NQyBMaXN0IDxsaW51
eC1tbWNAdmdlci5rZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPlN1
YmplY3Q6IFJlOiBbUEFUQ0h2MiAxLzJdIG1tYzogYmxvY2s6IFJlbW92ZSBlcnJvciBjaGVjayBv
ZiBod19yZXNldCBvbiByZXNldA0KPg0KPk9uIDcvMTAvMjIgMTg6NDIsIENocmlzdGlhbiBMw7Zo
bGUgd3JvdGU6DQo+PiBCZWZvcmUgc3dpdGNoaW5nIGJhY2sgdG8gdGhlIHJpZ2h0IHBhcnRpdGlv
biBpbiBtbWNfYmxrX3Jlc2V0IHRoZXJlIA0KPj4gdXNlZCB0byBiZSBhIGNoZWNrIGlmIGh3X3Jl
c2V0IHdhcyBldmVuIHN1cHBvcnRlZC4NCj4+IFRoaXMgcmV0dXJuIHZhbHVlIHdhcyByZW1vdmVk
LCBzbyB0aGVyZSBpcyBubyByZWFzb24gdG8gY2hlY2suDQo+PiANCj4+IEZpeGVzOiBmZWZkZDNj
OTFlMGEgKCJtbWM6IGNvcmU6IERyb3Agc3VwZXJmbHVvdXMgdmFsaWRhdGlvbnMgaW4gDQo+PiBt
bWNfaHd8c3dfcmVzZXQoKSIpDQo+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4gDQo+
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gTG9laGxlIDxjbG9laGxlQGh5cGVyc3RvbmUuY29t
Pg0KPj4gLS0tDQo+PiAtdjI6IERvIG5vdCBhdHRlbXB0IHRvIHN3aXRjaCBwYXJ0aXRpb25zIGlm
IHJlc2V0IGZhaWxlZA0KPj4gDQo+PiAgZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIHwgMjggKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRp
b25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1j
L2NvcmUvYmxvY2suYyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyBpbmRleCANCj4+IGNlODk2
MTFhMTM2ZS4uOGRiNzJjYmEyYmJlIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9i
bG9jay5jDQo+PiArKysgYi9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCj4+IEBAIC05OTEsMjkg
Kzk5MSwyNyBAQCBzdGF0aWMgaW50IG1tY19ibGtfcmVzZXQoc3RydWN0IG1tY19ibGtfZGF0YSAq
bWQsIHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwNCj4+ICAJCQkgaW50IHR5cGUpDQo+PiAgew0KPj4g
IAlpbnQgZXJyOw0KPj4gKwlzdHJ1Y3QgbW1jX2Jsa19kYXRhICptYWluX21kID0gZGV2X2dldF9k
cnZkYXRhKCZob3N0LT5jYXJkLT5kZXYpOw0KPj4gKwlpbnQgcGFydF9lcnI7DQo+PiAgDQo+PiAg
CWlmIChtZC0+cmVzZXRfZG9uZSAmIHR5cGUpDQo+PiAgCQlyZXR1cm4gLUVFWElTVDsNCj4+ICAN
Cj4+ICAJbWQtPnJlc2V0X2RvbmUgfD0gdHlwZTsNCj4+ICAJZXJyID0gbW1jX2h3X3Jlc2V0KGhv
c3QtPmNhcmQpOw0KPj4gKwlpZiAoZXJyKQ0KPj4gKwkJcmV0dXJuIGVycjsNCj4gDQo+IFRoaXMg
Y291bGQgYmUgYSBwb3RlbnRpYWwgc291cmNlIG9mIGRhdGEgY29ycnVwdGlvbi4NCj4gDQo+IFRo
ZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGF0IGEgc3Vic2VxdWVudCBJL08gd2lsbCBmYWlsIGp1c3Qg
YmVjYXVzZSB0aGUgcmVzZXQgZmFpbGVkLiAgUmVhZGluZyAvIHdyaXRpbmcgdGhlIHdyb25nIHBh
cnRpdGlvbiB3b3VsZCBiZSBkaXNhc3Ryb3VzLCBzbyB3ZSBzaG91bGQgYWx3YXlzIHRyeSB0byBn
ZXQgYmFjayB0byB0aGUgY29ycmVjdCBwYXJ0aXRpb24uDQo+IA0KPiBJIGhhdmVuJ3QgbG9va2Vk
IGF0IHRoZSBwb3NzaWJpbGl0eSBvZiBqdXN0IGZsYWdnaW5nIHRoZSBwYXJ0aXRpb24gYXMgaW52
YWxpZCAtIG5lZWQgdG8gYmUgc3VyZSBhbnkgc3Vic2VxdWVudCBJL08gYXR0ZW1wdHMgc3RpbGwg
Z28gdGhyb3VnaCBhIHBhdGggdGhhdCBzd2l0Y2hlcyB0aGUgcGFydGl0aW9uLg0KDQpJIGNhbiBz
ZWUgd2hlcmUgeW91cmUgY29taW5nIGZyb20sIGJ1dCBzaW1pbGFybHkgYSBmYWlsaW5nIG1tY19i
bGtfcGFydF9zd2l0Y2ggZG9lc24ndCBpbXBseSBhbGwgc3Vic2VxdWVudCBJTyB3aWxsIGZhaWwu
DQpGbGFnZ2luZyB0aGUgcGFydGl0aW9uIGFzIGludmFsaWQgY2FuIGJlIHNlZW4gYXMgcmVuZGVy
aW5nIHRoZSBzeXN0ZW0gdG8gYSBwb3RlbnRpYWxseSB1c2VsZXNzIHN0YXRlLCB3aGljaCBpcyBh
IGJpdCBvdmVyYm9hcmQgZm9yIGUuZy4gb25lIENSQzcgZmFpbHVyZSBvbiB0aGUgc3dpdGNoLg0K
Tm90IHN1cmUgeWV0IHdoYXQgdGhlIGlkZWFsIGJlaGF2aW9yIGlzLCBidXQgZWl0aGVyIHdheSBJ
IHdvdWxkIGdvIHdpdGggdjEgMS8yIGFuZCB2MiAyLzIgZm9yIG5vdz8gVGhhdCBhbHJlYWR5IGZp
eGVzIGltbyB0aGUgbW9zdCByZWxldmFudCBwb3RlbnRpYWwgZGF0YSBjb3JydXB0aW9ucy4gKHN1
Y2Nlc3NmdWwgcmVzZXQgLT4gbm8gc3dpdGNoKQ0KVGhlbiB3ZSBjYW4gY29tZSB1cCB3aXRoIGEg
YSBnb29kIGhhbmRsaW5nIGZvciBtbWNfYmxrX3Jlc2V0IG9yIGV2ZW4gYXJvdW5kIG1tY19ibGtf
cGFydF9zd2l0Y2guDQpPciB3aGF0IGRvIHlvdSBzdWdnZXN0Pw0KDQpSZWdhcmRzLA0KQ2hyaXN0
aWFuDQoNCkh5cGVyc3RvbmUgR21iSCB8IFJlaWNoZW5hdXN0ci4gMzlhICB8IDc4NDY3IEtvbnN0
YW56Ck1hbmFnaW5nIERpcmVjdG9yOiBEci4gSmFuIFBldGVyIEJlcm5zLgpDb21tZXJjaWFsIHJl
Z2lzdGVyIG9mIGxvY2FsIGNvdXJ0czogRnJlaWJ1cmcgSFJCMzgxNzgy

