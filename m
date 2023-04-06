Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019066D91C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbjDFIiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjDFIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:38:17 -0400
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062DBA1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680770249;
        bh=8tkHlYF+3cM8ZUpddjuwHvax8D5nVoRO30fP7gKwcgc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ahIO5Ufd3HDZK56Jmf9LZINmBoC6Qg/LjnUW/y9MMIXj//Xv7zT9/l5y06J21HN1F
         E7N4Q08yuNg2bwKluIEJgE8j3hxQBf7m9cKpwmkp9QTg9DWSUNn2alMGLhK5x8HVs8
         Uv9MmGVDFN+IWwcbqYlThGm3e6AITfEf/D0C0Bgy7NowibfHFOReXJOgYUyD9TP9K7
         fN8oaiQeF92JdQGnqxMa2hgeoVqnruE8RfF4Q6ZziYmzszHCdAAFv7DwEfIwPLSWLH
         D3ZrS7EY5hCXw3rC4hoM0P7YAWCOvBwAEGWNFGfj+uCGUiExKvceE2er5BqctOChYh
         w7yEMx0g2xdKQ==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Marek Vasut <marex@denx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 2/2] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Thread-Topic: [PATCH 2/2] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Thread-Index: AQHZZ9hJaqalrClMnUSWr1zaggJvEq8cxTeAgAA/z6D//+elAIABBfrQ
Date:   Thu, 6 Apr 2023 08:37:20 +0000
Message-ID: <531df359744f4bdb9fd34eafc864d2bc@dh-electronics.com>
References: <20230405160258.46998-1-cniedermaier@dh-electronics.com>
 <20230405160258.46998-2-cniedermaier@dh-electronics.com>
 <05fa147c-116b-59b4-d14b-760bbefd7602@denx.de>
 <e7aa3b3220e148ee96f5a1c361721845@dh-electronics.com>
 <42737c19-698f-8cc8-45b2-8ff08a274f87@denx.de>
In-Reply-To: <42737c19-698f-8cc8-45b2-8ff08a274f87@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyZWsgVmFzdXQgW21haWx0bzptYXJleEBkZW54LmRlXQ0KU2VudDogV2VkbmVzZGF5
LCBBcHJpbCA1LCAyMDIzIDg6NDcgUE0NCj4gT24gNC81LzIzIDIwOjI0LCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+PiBGcm9tOiBNYXJlayBWYXN1dCBbbWFpbHRvOm1hcmV4QGRlbngu
ZGVdDQo+PiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDUsIDIwMjMgNjoyNSBQTQ0KPj4+IE9uIDQv
NS8yMyAxODowMiwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4+DQo+Pj4gWy4uLl0N
Cj4+Pg0KPj4+PiArLyB7DQo+Pj4+ICsgICAgIG1vZGVsID0gIkRIIGVsZWN0cm9uaWNzIGkuTVg2
VUxMIERIQ09SIG9uIG1hdmVvIGJveCI7DQo+Pj4+ICsgICAgIGNvbXBhdGlibGUgPSAiZGgsaW14
NnVsbC1kaGNvci1tYXZlby1ib3giLCAiZGgsaW14NnVsbC1kaGNvci1zb20iLA0KPj4+PiArICAg
ICAgICAgICAgICAgICAgImZzbCxpbXg2dWxsIjsNCj4+Pj4gKw0KPj4+PiArICAgICBhbGlhc2Vz
IHsNCj4+Pj4gKyAgICAgICAgICAgICAvZGVsZXRlLXByb3BlcnR5LyBtbWMwOyAvKiBBdm9pZCBk
b3VibGUgZGVmaW5pdGlvbnMgKi8NCj4+Pj4gKyAgICAgICAgICAgICAvZGVsZXRlLXByb3BlcnR5
LyBtbWMxOw0KPj4+PiArICAgICAgICAgICAgIG1tYzIgPSAmdXNkaGMyOyAvKiBlTU1DIHNob3Vs
ZCBiZSBtbWMyICovDQo+Pj4NCj4+PiBXaHkgbm90IG1tYzAgPw0KPj4+DQo+Pj4gVXNlIHJvb3Q9
UEFSVFVVSUQ9IHdoZW4gYm9vdGluZyB0byBhdm9pZCBhbnkgZGVwZW5kZW5jeSBvbg0KPj4+IHJv
b3Q9L2Rldi9tbWNibGsycE4gZW51bWVyYXRpb24uDQo+Pg0KPj4gVGhpcyBpcyBkdWUgdG8gc29m
dHdhcmUgaW50ZXJjaGFuZ2VhYmlsaXR5IHdpdGggdGhlIERIQ09NDQo+PiBpLk1YNlVMTCwgd2hl
cmUgdGhlIGVNTUMgaXMgYWx3YXlzIG1tYzIuDQo+IA0KPiArQ0MgVWxmICwgSSB2YWd1ZWx5IHJl
Y2FsbCBzb21lIGRpc2N1c3Npb24gYWJvdXQgdGhpcyBlbnVtZXJhdGlvbiBhbmQgSQ0KPiBhbSBu
b3Qgc3VyZSBvbmUgY2FuIHJlYWxseSBkZXBlbmQgb24gdGhhdC4NCg0KVGhhdCB3aHkgSSB0aGlu
ayBpdCBnb29kIHRvIGhhdmUgYSBkZWZpbmVkIG51bWJlciBmb3IgbW1jYmxrIGRldmljZXMNCm9u
IGFuIGVtYmVkZGVkIHN5c3RlbS4gQW4gZXhjZXJwdCBmcm9tIFsxXToNCg0KQWx0ZXJuYXRpdmUg
c29sdXRpb25zIGxpa2UgUEFSVFVVSURzIGRvIG5vdCBjb3ZlciB0aGUgY2FzZSB3aGVyZSBtdWx0
aXBsZQ0KbW1jYmxrIGRldmljZXMgY29udGFpbiB0aGUgc2FtZSBpbWFnZS4gVGhpcyBpcyBhIGNv
bW1vbiBpc3N1ZSBvbiBkZXZpY2VzDQp0aGF0IGNhbiBib290IGJvdGggZnJvbSBlTU1DIChmb3Ig
cmVndWxhciBib290KSBhbmQgU0QgY2FyZHMgKGFzIGENCnRlbXBvcmFyeSBib290IG1lZGl1bSBm
b3IgZGV2ZWxvcG1lbnQpLiBXaGVuIGEgZmlybXdhcmUgaW1hZ2UgaXMNCmluc3RhbGxlZCB0byBl
TU1DIGFmdGVyIGEgdGVzdCBib290IHZpYSBTRCBjYXJkLCB0aGVyZSB3aWxsIGJlIG5vDQpyZWxp
YWJsZSB3YXkgdG8gcmVmZXIgdG8gYSBzcGVjaWZpYyBkZXZpY2UgdXNpbmcgKFBBUlQpVVVJRHMg
b2Rlcg0KTEFCRUxzDQoNClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
bGludXgtbW1jL3BhdGNoLzIwMjAwODI1MTM0NDQxLjE3NTM3LTItbWF0dGhpYXMuc2NoaWZmZXJA
ZXcudHEtZ3JvdXAuY29tLw0KDQpTbyBmYXIgSSBoYXZlIG5ldmVyIGhhZCBhIHByb2JsZW0gd2l0
aCBudW1iZXJpbmcgbW1jYmxrIGRldmljZXMgdmlhIGFsaWFzZXMuDQoNClJlZ2FyZHMNCkNocmlz
dG9waA0K
