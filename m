Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7516B06B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCHMQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCHMQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:16:10 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0574999D4E;
        Wed,  8 Mar 2023 04:16:04 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 123615FD36;
        Wed,  8 Mar 2023 15:16:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678277762;
        bh=F/3XE83M6XTlt7FQbpfyt5CQFybm6iR0tVjxdj532zA=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=fqQ9S+MEQzECZrBVc00tq2O6u3boFfuVyqHa7oOabDKoUIqRzhomKwCkHFNixhCrb
         6KmuRyHqQ3szevjVS1MtqpumeCHkOx2si41HhvrDm/YqI6vqNiswMtHlttTpdVrik1
         K2DQxdWfkcABCut863HBIozvluewhKpKe0RpcxfuKASNCmw9+oNYjEXKLVdjrgUoW2
         sJFjzKtQ1JnQx/FEy8Asb4yIeo0l60yKi9KBz9N8PGTfGHqp0V9k2VfbASXS50u0Vs
         LI/SQ5Q7buVFNuKfFWcbFtZWmtCXDf/pjXVpneBXGWGdLwlScBdlkec0cKZpoDwS4J
         mmhT5jvtr9oFA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  8 Mar 2023 15:16:00 +0300 (MSK)
From:   George Stark <GNStark@sberdevices.ru>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1] Revert "pwm: Clear chip_data in pwm_put()"
Thread-Topic: [RFC PATCH v1] Revert "pwm: Clear chip_data in pwm_put()"
Thread-Index: AQHZUTfmbk4BaJWELU63+l8Yrk1F9a7vopQAgAD3OoA=
Date:   Wed, 8 Mar 2023 12:16:00 +0000
Message-ID: <cc73a82d-89fa-1edf-650a-a1a3824cc791@sberdevices.ru>
References: <20230307210014.1380102-1-gnstark@sberdevices.ru>
 <20230307212744.rx2julmzxe7nvhvr@pengutronix.de>
In-Reply-To: <20230307212744.rx2julmzxe7nvhvr@pengutronix.de>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.13]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A5BEDF0AC98104F8DD1133821D4D989@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/08 10:43:00 #20925189
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVXdlDQoNCk9uIDMvOC8yMyAwMDoyOCwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+
IEhlbGxvIEdlb3JnZSwNCj4NCj4gT24gV2VkLCBNYXIgMDgsIDIwMjMgYXQgMTI6MDA6MTRBTSAr
MDMwMCwgR2VvcmdlIFN0YXJrIHdyb3RlOg0KPj4gRnJvbTogR2VvcmdlIFN0YXJrIDxHTlN0YXJr
QHNiZXJkZXZpY2VzLnJ1Pg0KPj4NCj4+IFRoaXMgcmV2ZXJ0cyBjb21taXQgZTkyNmIxMmM2MTFj
MjA5NWM3OTc2ZTJlZDMxNzUzYWQ2ZWI1ZmYxYS4NCj4+DQo+PiBUaGVyZSdyZSBzZXZlcmFsIGlz
c3VlcyB3aXRoIHRoZSBvcmlnaW5hbCBjaGFuZ2U6DQo+Pg0KPj4gLSBpdCBicmVha3MgZ2VuZXJp
YyBzZW1hbnRpY3Mgb2Ygc2V0X2RyaXZlcl9kYXRhLWxpa2Ugcm91dGluZXMgdGhhdA0KPj4gb25s
eSBjbGllbnQgY29kZSBjb250cm9scyBsaWZldGltZSBvZiBpdCdzIG93biBkYXRhLg0KPj4NCj4+
IC0gaXQgYnJlYWtzIHB3bS1zdGkuYyBkcml2ZXI6IHB3bV9zZXRfY2hpcF9kYXRhIGlzIHVzZWQg
b25seSBpbiBwcm9iZSBzdGFnZQ0KPj4gdGhlbiBwd21fZ2V0X2NoaXBfZGF0YSB1c2VkIGluIGNh
cHR1cmUgY2FsbGJhY2sNCj4gcHdtLXN0aSBpcyBhbHNvIGJyb2tlbiBpbiBvdGhlciByZWdhcmRz
LiBwd21fc2V0X2NoaXBfZGF0YSgpIGlzIG9ubHkNCj4gY2FsbGVkIGFmdGVyIHB3bWNoaXBfYWRk
KCkuIEJ1dCBhcyBzb29uIGFzIHB3bWNoaXBfYWRkKCkgaXMgY2FsbGVkLCB0aGUNCj4gY2FsbGJh
Y2tzIChlLmcuIGNhcHR1cmUpIG1pZ2h0IGJlIGNhbGxlZC4gVGhlbiB0aGUgY2FsbCB0bw0KPiBw
d21fc2V0X2NoaXBfZGF0YSgpIG1pZ2h0IGJlIHRvbyBsYXRlLg0KPg0KPj4gQ2hhbmdlLUlkOiBJ
NTc4N2M2YjRjNTIwZDRhMDk5NzU2N2M0MTZiMjZmYTRlMDgwNmI5NA0KPiBQbGVhc2UgZG9uJ3Qg
YWRkIGEgQ2hhbmdlLUlkIGZvb3RlciBmb3IgTGludXggc3VibWlzc2lvbnMuDQptaXNzZWQgaXQg
c29tZWhvdy4gU29ycnkgYWJvdXQgdGhhdA0KPg0KPiBJZiB5b3UgYXNrIG1lLCBiZXR0ZXIgZHJv
cCBwd21fc2V0X2NoaXBfZGF0YSgpIGNvbXBsZXRlbHkuIEl0IGFkZHMgbm8NCj4gdXNlZnVsIHZh
bHVlLiBJdCdzIGp1c3QgYSB2YXJpYW50IG9mIGRyaXZlciBkYXRhIGFuZCB1c2luZyBib3RoDQo+
IGNvbXBsaWNhdGVzIHRoZSBkcml2ZXIgYW5kIHByb2JhYmx5IGZyYWdtZW50cyBtZW1vcnkgYWxs
b2NhdGlvbnMuIEFsc28NCj4gdGhlIHNlbWF0aWMgb2YgZHJpdmVyIGRhdGEgaXMgYmV0dGVyIGtu
b3duIGFzIGl0J3MgdGhlIHNhbWUgZm9yIGFsbA0KPiBzdWJzeXN0ZW1zLg0KPg0KPiBEbyB5b3Ug
dXNlIHRoZSBjYXB0dXJlIGZ1bmN0aW9uYWxpdHk/IEluIG15IGV5ZXMgdGhlIGNhcHR1cmUgcGFy
dCBvZiB0aGUNCj4gcHdtIHN1YnN5c3RlbSBpcyB2ZXJ5IGFsaWVuLiBPbmx5IGEgc21hbGwgc3Vi
c2V0IG9mIHRoZSBoYXJkd2FyZQ0KPiBzdXBwb3J0cyB0aGlzIGFuZCB0aGUgY291bnRlciBmcmFt
ZXdvcmsgc2hvdWxkIGJlIGJldHRlciBzdWl0ZWQgZm9yIHN1Y2gNCj4gdGFza3MuDQpJIGRvbid0
IHVzZSBwd20tc3RpIGRyaXZlci4gSSB1cGRhdGUgbWVzb24gcHdtIGRyaXZlciBmb3IgbmV3IGNo
aXBzDQphbmQgd2hlbiBzdGFydGVkIHVzaW5nIHB3bV9zZXRfY2hpcF9kYXRhIGluIHByb2JlIEkg
d2FzIHZlcnkgc3VycHJpc2VkIHRoYXQNCm15IGRhdGEgaXMgbG9zdCBhZnRlciBzeXNmcyBleHBv
cnQvdW5leHBvcnQgY2FsbHMuIFRoZW4gSSBmb3VuZCB0aGUgDQpwYXRjaCBhbmQNCmNoZWNrZWQg
b3RoZXIgZHJpdmVycyBmb3Igc2ltaWxhciB1c2VjYXNlcy4NClByb2JhYmx5IHlvdSdyZSByaWdo
dCBhYm91dCBkcm9wcGluZyBwd21fc2V0X2NoaXBfZGF0YS4NCj4gQmVzdCByZWdhcmRzDQo+IFV3
ZQ0KPg0KQmVzdCByZWdhcmRzDQpHZW9yZ2UNCg0K
