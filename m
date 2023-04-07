Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939C56DAB9C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbjDGKrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240586AbjDGKrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:47:08 -0400
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535039ECB;
        Fri,  7 Apr 2023 03:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680864379;
        bh=kp73pD+E/7lFpSQr+HtSNu3ENGOQL4UISw1spZ0wjhw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=pTlQ/dyi34mu7J3ZX2tVLFWNvBROgBX1ZvoJ7qX9sswMRJKAQeg32Qq0G4IWRGAcV
         9FfRcSELHFhKRfEMjpqUfk0y6bjzQmw3qlMF+Z2p28zVlHCRzi8uNyAhFbjPKj1crB
         7X9kOWu0h5aseTxwdYN35lqmrQQsfFGbFgH2avdJHJGi0IvL6qj/ZZf47wwof6kXCk
         vJuxHSmS0+bpt/fk9Xw9seLo7HHHNoCrkgalt/l9M7681CRS1oTe3x7w6IxGpOgn68
         Ddfwu6X7yTuCYZpoNvGU4H9Hdu4TK5zXI/tNOd1eSeU4IB7GHCrETkpnwzKMT/6YsI
         3vF2oViu2Y4eA==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel <kernel@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 3/4] ARM: dts: imx6ull-dhcor: Remove mmc aliases from
 SoM
Thread-Topic: [PATCH V3 3/4] ARM: dts: imx6ull-dhcor: Remove mmc aliases from
 SoM
Thread-Index: AQHZaNJbpGDzEm+YTUOc9MYoQJPb1q8fSSgAgABgSzA=
Date:   Fri, 7 Apr 2023 10:46:09 +0000
Message-ID: <652d4119d4a846b4bc517b9c4c5d451d@dh-electronics.com>
References: <20230406215315.13280-1-cniedermaier@dh-electronics.com>
 <20230406215315.13280-3-cniedermaier@dh-electronics.com>
 <7bd74002-cc15-ab59-4fd6-ff948cbcdb68@kernel.org>
In-Reply-To: <7bd74002-cc15-ab59-4fd6-ff948cbcdb68@kernel.org>
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

RnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSBbbWFpbHRvOmtyemtAa2VybmVsLm9yZ10NClNlbnQ6
IEZyaWRheSwgQXByaWwgNywgMjAyMyA4OjU3IEFNDQo+IE9uIDA2LzA0LzIwMjMgMjM6NTMsIENo
cmlzdG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4+IFJlbW92ZSBtbWMgYWxpYXNlcyB0byBiZSBh
YmxlIHRvIGRlZmluZSB0aGVtIGNvcnJlY3RseSBpbiB0aGUgYm9hcmQgZmlsZS4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggTmllZGVybWFpZXIgPGNuaWVkZXJtYWllckBkaC1lbGVj
dHJvbmljcy5jb20+DQo+PiAtLS0NCj4+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwu
b3JnPg0KPj4gQ2M6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRA
bGluYXJvLm9yZz4NCj4+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+PiBD
YzogTGkgWWFuZyA8bGVveWFuZy5saUBueHAuY29tPg0KPj4gQ2M6IE1hcmVrIFZhc3V0IDxtYXJl
eEBkZW54LmRlPg0KPj4gQ2M6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGRlbnguZGU+DQo+PiBD
YzogTlhQIExpbnV4IFRlYW0gPGxpbnV4LWlteEBueHAuY29tPg0KPj4gQ2M6IGtlcm5lbEBkaC1l
bGVjdHJvbmljcy5jb20NCj4+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPj4gQ2M6
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+IFRvOiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcNCj4+IC0tLQ0KPj4gVjM6IC0gQWRkIHRoaXMgcGF0Y2ggdG8gdGhl
IHNlcmllcw0KPj4gLS0tDQo+PiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1kaGNvci1zb20u
ZHRzaSB8IDUgKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtZGhjb3Itc29tLmR0c2kg
Yi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWRoY29yLXNvbS5kdHNpDQo+PiBpbmRleCA1ODgy
Yzc1NjVmNjQuLmEzODZjMWU5YmVkMyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZ1bGwtZGhjb3Itc29tLmR0c2kNCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1
bGwtZGhjb3Itc29tLmR0c2kNCj4+IEBAIC0xMSw2ICsxMSwxMSBAQA0KPj4gICNpbmNsdWRlICJp
bXg2dWxsLmR0c2kiDQo+Pg0KPj4gIC8gew0KPj4gKyAgICAgYWxpYXNlcyB7DQo+PiArICAgICAg
ICAgICAgIC9kZWxldGUtcHJvcGVydHkvIG1tYzA7DQo+PiArICAgICAgICAgICAgIC9kZWxldGUt
cHJvcGVydHkvIG1tYzE7DQo+PiArICAgICB9Ow0KPiANCj4gWW91IG5lZWQgdG8gcmUtYWRkIHRo
ZW0gaW4gcmVzcGVjdGl2ZSBib2FyZHM6IGRyYzAyLCBwZGsyIGFuZCBwaWNvaXR4Lg0KPiBPdGhl
cndpc2UgeW91IGp1c3QgcmVtb3ZlZCB0aGF0IGZ1bmN0aW9uYWxpdHkgd2l0aG91dCBhbnkgZXhw
bGFuYXRpb24gaW4NCj4gY29tbWl0IG1zZy4NCg0KRm9yIHRoZSBkcmMwMiwgcGRrMiBhbmQgcGlj
b2l0eCBib2FyZHMgdGhlcmUgaXMgYW4gYWRkaXRpb25hbCBTb00gbGF5ZXIgKERIQ09NKQ0KYmV0
d2Vlbi4gVGhlcmVmb3JlLCBpbiB2ZXJzaW9uIDQgSSB3aWxsIGFsc28gYWRhcHQgdGhlIERIQ09N
IFNvTSBsYXllci4NCg0KDQpUaGFua3MgYW5kIGJlc3QgcmVnYXJkcw0KQ2hyaXN0b3BoDQo=
