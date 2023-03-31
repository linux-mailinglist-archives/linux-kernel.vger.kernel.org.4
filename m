Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4DF6D1E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCaK3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjCaK2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:28:33 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4161FD36
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:27:51 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id F19AE24E336;
        Fri, 31 Mar 2023 18:27:49 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 31 Mar
 2023 18:27:50 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 31 Mar
 2023 18:27:49 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Fri, 31 Mar 2023 18:27:49 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v8 0/4] RISC-V Hibernation Support
Thread-Topic: [PATCH v8 0/4] RISC-V Hibernation Support
Thread-Index: AQHZYtLvA9p1xyT6pkCpIR4M2BabXa8SXEcAgAJT22A=
Date:   Fri, 31 Mar 2023 10:27:49 +0000
Message-ID: <c9f9f648b8964c939309cafdc5feaee4@EXMBX066.cuchost.com>
References: <20230330064321.1008373-1-jeeheng.sia@starfivetech.com>
 <a73a194e-f7dd-4cf4-9fb7-62144672b71c@spud>
In-Reply-To: <a73a194e-f7dd-4cf4-9fb7-62144672b71c@spud>
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
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29ub3IgRG9vbGV5IDxj
b25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDMwLCAy
MDIzIDI6NTEgUE0NCj4gVG86IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2gu
Y29tPg0KPiBDYzogcGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207
IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExleWZvb24gVGFuIDxsZXlmb29uLnRh
bkBzdGFyZml2ZXRlY2guY29tPjsgTWFzb24gSHVvIDxtYXNvbi5odW9Ac3RhcmZpdmV0ZWNoLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAwLzRdIFJJU0MtViBIaWJlcm5hdGlvbiBTdXBw
b3J0DQo+IA0KPiBPbiBUaHUsIE1hciAzMCwgMjAyMyBhdCAwMjo0MzoxN1BNICswODAwLCBTaWEg
SmVlIEhlbmcgd3JvdGU6DQo+IA0KPiA+IENoYW5nZXMgc2luY2Ugdjc6DQo+ID4gLSBSZWJhc2Vk
IHRvIGtlcm5lbCB2Ni4zLXJjNA0KPiANCj4gQlRXLCB0aGVyZSBpcyBhYnNvbHV0ZWx5IG5vIG5l
ZWQgdG8gZG8gdGhpcyBldmVyeSB0aW1lIHlvdSByZXN1Ym1pdC4NCj4gVXN1YWxseSBwYXRjaGVz
IHdpbGwgZWl0aGVyIGJlIGFwcGxpZWQgdG8gZm9yLW5leHQgb3IgdG8gLXJjMSwgc28NCj4gcmVi
YXNpbmcgb24gdGhlIG5ld2VzdCAtcmMgaXMgbm90IG5lZWRlZCA6KQ0KTm90ZWQgd2l0aCB0aGFu
a3MhIPCfmIogVGhlIHJlYXNvbiB3aHkgSSB1cGRhdGUgdGhlIGtlcm5lbCB2ZXJzaW9uIHdpdGgg
ZXZlcnkgcmVzdWJtaXNzaW9uIGlzIHRoYXQgSSdtIGFmcmFpZCB0aGUgbmV3IHJlbGVhc2UgY2Fu
ZGlkYXRlIG1pZ2h0IGludHJvZHVjZSBzb21ldGhpbmcgdGhhdCBJJ20gbm90IGF3YXJlIG9mLCB3
aGljaCBjb3VsZCBwb3RlbnRpYWxseSBjYXVzZSBhIGJyZWFrIHNvbWV3aGVyZS4NCg==
