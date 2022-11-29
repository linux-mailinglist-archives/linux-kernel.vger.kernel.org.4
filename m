Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EAE63BC78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiK2JEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiK2JEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:04:41 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E091DF19;
        Tue, 29 Nov 2022 01:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669712633;
        bh=ex3+90piavyGGu+Bb5TUi5MmQaDDfTSAe/EWCK3J5PY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TQOvZr0t1jCAlbM54NINjswd3QSssniKZOFN1jRF/3/alMRYeFiBtRM2tj/Dzic8S
         4skIYhdiV8qQoV5z/xxTgkS2IYsWyUsttA9PnIaz7P9Ack1McxI42WSiYiY3t5QV4e
         hJMl2aJw0VFdS1Qasnb+mY6Bnup9GChHkmx4WfApXlkC1U1ZzOLPaoMnNltYPO+GG8
         K8m/E8O4enEd6QXIN9BDYEpCoEAC3zxqOZpbZMY2kYnmYdOfqjmSh4REHokW9z8Gs7
         rLAcyOYJ8sk7aZ4LB4uuMw/2+Z5NE+VeYTT+jhp9NpK+DLl+ilqIAjXzPpRvtiCtnn
         OAch0iS1PxAzg==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Marek Vasut <marex@denx.de>, Pavel Machek <pavel@ucw.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        kernel <kernel@dh-electronics.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: leds: Mark label property as deprecated
Thread-Topic: [PATCH] dt-bindings: leds: Mark label property as deprecated
Thread-Index: AQHY/mNSBezL52aWUU2g6jlYT+Ed+a5KzPaAgAVOqgCABYLpoA==
Date:   Tue, 29 Nov 2022 09:03:40 +0000
Message-ID: <5cf45c8d1fa54f6fa41b12f28bb0ddf9@dh-electronics.com>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz> <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
In-Reply-To: <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyZWsgVmFzdXQgW21haWx0bzptYXJleEBkZW54LmRlXQ0KU2VudDogRnJpZGF5LCBO
b3ZlbWJlciAyNSwgMjAyMiAxMDoyNyBQTQ0KPiBPbiAxMS8yMi8yMiAxMzoyMywgUGF2ZWwgTWFj
aGVrIHdyb3RlOg0KPj4gSGkhDQo+IA0KPiBIaSwNCj4gDQoNCkhpLA0KDQo+Pj4gTWFyayB0aGUg
bGFiZWwgcHJvcGVydHkgYXMgZGVwcmVjYXRlZCBhcyBpdCBpcyBtZW50aW9uZWQNCj4+PiBpbiB0
aGUgZGVzY3JpcHRpb24uDQo+Pg0KPj4gTGV0cyBkbyBpdCB0aGUgb3RoZXIgd2F5IGFyb3VuZC4g
RnVuY3Rpb25zIChldGMpIGRvbid0IHJlYWxseSBwcm92aWRlDQo+PiBnb29kIGVub3VnaCBkZXNj
cmlwdGlvbiBvZiBMRUQsIGFuZCBsYWJlbCBpcyBzdGlsbCBuZWVkZWQuDQo+IA0KPiBDYW4geW91
IHBsZWFzZSBwcm92aWRlIGEgY2xlYXIgZXhwbGFuYXRpb24gd2hpY2ggcHJvcGVydHkgb3IgYXBw
cm9hY2ggaXMNCj4gdGhlIGNvcnJlY3Qgb25lIGZvciBuZXcgRFRzID8NCj4gDQo+IFNvIGZhciwg
dGhlIGRvY3VtZW50YXRpb24gc3RhdGVzIHRoYXQgImxhYmVsIiBpcyBkZXByZWNhdGVkLCBhbmQg
dXNlcnMNCj4gc2hvdWxkIHJlcGxhY2UgaXQgd2l0aCAiZnVuY3Rpb24iIGFuZCAiY29sb3IiLg0K
DQpJJ20gYSBsaXR0bGUgY29uZnVzZWQgYmVjYXVzZSB0aGUgZGlyZWN0aW9uIHNlZW1zIHRvIGhh
dmUgY2hhbmdlZCBoZXJlLg0KRG8geW91IHdhbnQgbGFiZWwgYW5kIGZ1bmN0aW9ucyAoZXRjLikg
dG8gYmUgYWJsZSB0byBiZSB1c2VkIGVxdWFsbHkNCnNpZGUgYnkgc2lkZSwgb3Igc2hvdWxkIG9u
ZSBvZiB0aGVtIGJlIHByZWZlcnJlZD8NCg0KSSBhbHNvIGRvIERUcyBhbmQgaXQgd291bGQgYmUg
Z29vZCB0byBrbm93IHdoYXQgdG8gZ28gZm9yLg0KQ291bGQgeW91IHBsZWFzZSBwcm92aWRlIGZ1
cnRoZXIgZXhwbGFuYXRpb24/DQoNCg0KUmVnYXJkcw0KQ2hyaXN0b3BoDQo=
