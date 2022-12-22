Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EBD653D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiLVJhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiLVJg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:36:57 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180DF2791C;
        Thu, 22 Dec 2022 01:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1671701773;
        bh=Ewz2mZ4/G74YVQS5DrzTxOh0V5fZcV4L+hYTmmtl+ws=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=F7owkF4znc/MEsjpVBsyEe5LtxZgpN0EdlMogxlG1IAUQGKHiI2yC9IIY+UW3JphG
         4vBLATQZgUquD5mR/PMovEIvtLqQgrupMCif/7ScHdJIkIGwwBzqmP5cnQOi96T0fU
         cvyetdSz8Gl27No9oZVcsEA/uwdHvs45JppezbXby/q1Px126dSxbD1gEAecG6jxFv
         KDm9oagCySbyotP9Ng7kJlml7VBcB5oGgOpsSORRHtS8/C6l460kOXYj/+Nzy2Zt4f
         DrMYsHlAcF3aQrH1Plwjt1MsSjjcxlmrg7p5ozh3aSbJbuqjc7N/Is5Ej/jGZcw0QA
         M974aOBD4hAbg==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        kernel <kernel@dh-electronics.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: leds: Mark label property as deprecated
Thread-Topic: [PATCH] dt-bindings: leds: Mark label property as deprecated
Thread-Index: AQHY/mNSBezL52aWUU2g6jlYT+Ed+a5KzPaAgAVOqgCAB7gPgIAB27kAgAX2P4CAGih2UA==
Date:   Thu, 22 Dec 2022 09:36:07 +0000
Message-ID: <e6b166b399314a91bc97db591c8ec5a7@dh-electronics.com>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz> <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
 <20221130191905.GA2631320-robh@kernel.org>
 <4043d693-7739-4709-8551-9f476031db70@denx.de>
 <38c9aae4-0cae-a5a6-7c76-f23edf259dab@gmail.com>
In-Reply-To: <38c9aae4-0cae-a5a6-7c76-f23edf259dab@gmail.com>
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

RnJvbTogSmFjZWsgQW5hc3pld3NraSBbbWFpbHRvOmphY2VrLmFuYXN6ZXdza2lAZ21haWwuY29t
XQ0KU2VudDogTW9uZGF5LCBEZWNlbWJlciA1LCAyMDIyIDc6NDQgUE0NCj4gDQo+IEhpIGFsbCwN
Cj4NCg0KSGkgYWxsLA0KDQo+IE9uIDEyLzIvMjIgMDA6NDEsIE1hcmVrIFZhc3V0IHdyb3RlOg0K
Pj4gT24gMTEvMzAvMjIgMjA6MTksIFJvYiBIZXJyaW5nIHdyb3RlOg0KPj4+IE9uIEZyaSwgTm92
IDI1LCAyMDIyIGF0IDEwOjI2OjMwUE0gKzAxMDAsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPj4+PiBP
biAxMS8yMi8yMiAxMzoyMywgUGF2ZWwgTWFjaGVrIHdyb3RlOg0KPj4+Pj4gSGkhDQo+Pj4+DQo+
Pj4+IEhpLA0KPj4+Pg0KPj4+Pj4+IE1hcmsgdGhlIGxhYmVsIHByb3BlcnR5IGFzIGRlcHJlY2F0
ZWQgYXMgaXQgaXMgbWVudGlvbmVkDQo+Pj4+Pj4gaW4gdGhlIGRlc2NyaXB0aW9uLg0KPj4+Pj4N
Cj4+Pj4+IExldHMgZG8gaXQgdGhlIG90aGVyIHdheSBhcm91bmQuIEZ1bmN0aW9ucyAoZXRjKSBk
b24ndCByZWFsbHkgcHJvdmlkZQ0KPj4+Pj4gZ29vZCBlbm91Z2ggZGVzY3JpcHRpb24gb2YgTEVE
LCBhbmQgbGFiZWwgaXMgc3RpbGwgbmVlZGVkLg0KPj4+Pg0KPj4+PiBDYW4geW91IHBsZWFzZSBw
cm92aWRlIGEgY2xlYXIgZXhwbGFuYXRpb24gd2hpY2ggcHJvcGVydHkgb3IgYXBwcm9hY2gNCj4+
Pj4gaXMgdGhlDQo+Pj4+IGNvcnJlY3Qgb25lIGZvciBuZXcgRFRzID8NCj4+Pj4NCj4+Pj4gU28g
ZmFyLCB0aGUgZG9jdW1lbnRhdGlvbiBzdGF0ZXMgdGhhdCAibGFiZWwiIGlzIGRlcHJlY2F0ZWQs
IGFuZCB1c2Vycw0KPj4+PiBzaG91bGQgcmVwbGFjZSBpdCB3aXRoICJmdW5jdGlvbiIgYW5kICJj
b2xvciIuDQo+Pj4NCj4+PiAnZnVuY3Rpb24nIGlzIHdoYXQgYWN0aXZpdHkvb3BlcmF0aW9uIHRo
ZSBMRUQgaXMgYXNzb2NpYXRlZCB3aXRoLiBJdCBpcw0KPj4+IGEgZml4ZWQgc2V0IG9mIHN0cmlu
Z3Mgd2hpY2ggcy93IG1heSB1c2UuIEl0IGlzIGEgcmVwbGFjZW1lbnQgZm9yDQo+Pj4gJ2xpbnV4
LGRlZmF1bHQtdHJpZ2dlcicuDQo+Pg0KPj4gSXNuJ3QgdGhpcyAnZnVuY3Rpb24nIG1vcmUgb2Yg
YSBzdGFuZGFyZGl6ZWQgcmVwbGFjZW1lbnQgZm9yICdsYWJlbCcgPw0KPiANCj4gWWVzIGl0IGlz
LiBJbnRyb2R1Y3Rpb24gb2YgZnVuY3Rpb24gYW5kIGNvbG9yIHByb3BlcnRpZXMgYWltZWQgYXQN
Cj4gc3RhbmRhcmRpemluZyBMRUQgbmFtaW5nLiBCZWZvcmUgdGhlcmUgd2FzIG9ubHkgJ2xhYmVs
JyB1c2VkIGZvciB0aGF0LA0KPiB3aXRoIERUIG5vZGUgbmFtZSBhcyBmYWxsYmFjayBpZiAnbGFi
ZWwnIHByb3BlcnR5IHdhcyBub3QgcHJvdmlkZWQuDQo+IFdpdGggaW50cm9kdWN0aW9uIG9mICdm
dW5jdGlvbicgYW5kICdjb2xvcicgbGFiZWwgd2FzIGRlcHJlY2F0ZWQgaW4NCj4gdGhlIHNlbnNl
IHRoYXQgaWYgdGhlIGZvcm1lciB0d28gYXJlIHByZXNlbnQsIHRoZXkgYXJlIHVzZWQgZm9yDQo+
IGNvbXBvc2luZyB0aGUgTEVEIG5hbWUuDQo+IA0KPiBJbiBMRUQgZG9jdW1lbnRhdGlvbiBbMF0g
cGVvcGxlIGFyZSBlbmNvdXJhZ2VkIHRvIHVzZSBkZWZpbml0aW9ucyBmcm9tDQo+IGluY2x1ZGUv
ZHQtYmluZGluZ3MvbGVkcy9jb21tb24uaCB0byBrZWVwIExFRCBuYW1pbmcgdW5pZm9ybS4NCj4g
SXQgYWxsb3dzIHRvIGF2b2lkIGR1cGxpY2F0ZXMgbGlrZSAid2xhbiIgYW5kICJ3aWZpIi4NCj4g
DQo+PiAkIGdpdCBncmVwIExFRF9GVU5DVElPTl8gaW5jbHVkZS8NCj4+IC4uLg0KPj4gaW5jbHVk
ZS9kdC1iaW5kaW5ncy9sZWRzL2NvbW1vbi5oOiNkZWZpbmUgTEVEX0ZVTkNUSU9OX1BMQVlFUjUg
InBsYXllci01Ig0KPj4gaW5jbHVkZS9kdC1iaW5kaW5ncy9sZWRzL2NvbW1vbi5oOiNkZWZpbmUg
TEVEX0ZVTkNUSU9OX0FDVElWSVRZICJhY3Rpdml0eSINCj4+IGluY2x1ZGUvZHQtYmluZGluZ3Mv
bGVkcy9jb21tb24uaDojZGVmaW5lIExFRF9GVU5DVElPTl9BTEFSTSAiYWxhcm0iDQo+PiBpbmNs
dWRlL2R0LWJpbmRpbmdzL2xlZHMvY29tbW9uLmg6I2RlZmluZSBMRURfRlVOQ1RJT05fQkFDS0xJ
R0hUDQo+PiAiYmFja2xpZ2h0Ig0KPj4gaW5jbHVkZS9kdC1iaW5kaW5ncy9sZWRzL2NvbW1vbi5o
OiNkZWZpbmUgTEVEX0ZVTkNUSU9OX0JMVUVUT09USA0KPj4gImJsdWV0b290aCINCj4+IGluY2x1
ZGUvZHQtYmluZGluZ3MvbGVkcy9jb21tb24uaDojZGVmaW5lIExFRF9GVU5DVElPTl9CT09UICJi
b290Ig0KPj4gLi4uDQo+Pg0KPj4gU2VlbXMgdG8gbWUgdGhhdCBeIGlzIGNsb3NlciB0byBhICJz
dGFuZGFyZGl6ZWQiIGZvcm0gb2YgJ2xhYmVsJyAuDQo+Pg0KPj4gVGhlIExFRCBzdWJzeXN0ZW0g
ZG9lcyBub3QgaW5mZXIgYW55IGJlaGF2aW9yIG9mIHRob3NlIExFRHMgYmFzZWQgb24NCj4+IHRo
ZWlyICdmdW5jdGlvbicgcHJvcGVydHkgYXMgZmFyIGFzIEkgY2FuIHRlbGwsIGF0IGxlYXN0IG5v
dCBpbiB0aGUgd2F5DQo+PiAnbGludXgsZGVmYXVsdC10cmlnZ2VyJyBiZWhhdmVzLg0KPj4NCj4+
PiAnbGFiZWwnIGlzIHdoYXQgaXMgcHJpbnRlZCBuZXh0IHRvIHRoZSBMRUQgZm9yIGEgaHVtYW4g
dG8gcmVhZC4gJ2xhYmVsJw0KPj4+IGNhbiBiZSBhbnl0aGluZyBhbmQgdGhlIE9TIHNob3VsZG4n
dCBjYXJlIHdoYXQgaXQgaXMuDQo+Pg0KPj4gVGhpcyBwYXJ0IEkgdW5kZXJzdGFuZC4gV2hhdCBp
cyBub3QgY2xlYXIgdG8gbWUgaXMsIHdoeSBpcyAnbGFiZWwnIGJlaW5nDQo+PiB1bi1kZXByZWNh
dGVkLg0KPiANCj4gSXQgc2hvdWxkbid0IGJlLiBJdCBzZWVtcyB0byBiZSBQYXZlbCdzIGFkLWhv
YyBkZWNpc2lvbi4NCg0KSXMgdGhlcmUgYSBtYWpvcml0eSBhZ3JlZW1lbnQgdGhhdCB0aGUgImxh
YmVsIiBwcm9wZXJ0eSByZW1haW5zIGRlcHJlY2F0ZWQ/DQpJZiBzbywgSSB3b3VsZCBzYXkgd2Ug
Y2FuIG1hcmsgdGhlIGxhYmVsIGFzIGRlcHJlY2F0ZWQuDQoNCk9uIHRoZSBvdGhlciBoYW5kLCB0
aGUgbmV3IGdlbmVyYXRlZCBzdGFuZGFyZGl6ZWQgc3lzZnMgbmFtZSBkb2VzIG5vdCBzZWVtDQp0
byBwcm92aWRlIGEgZnVsbCByZXBsYWNlbWVudCBmb3IgdGhlICJsYWJlbCIgcHJvcGVydHkuDQpX
aGF0IGlzIHN0aWxsIG1pc3Npbmc/DQpIb3cgY2FuIHRoZSBjdXJyZW50IHN0YXRlIGJlIGV4dGVu
ZGVkIHRvIGZpbmQgbW9yZSBhY2NlcHRhbmNlPw0KDQpbLi4uXQ0KDQpSZWdhcmRzDQpDaHJpc3Rv
cGgNCg==
