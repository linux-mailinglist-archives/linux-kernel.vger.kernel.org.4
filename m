Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1F968CE67
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBGE60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBGE6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:58:25 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA81717CCF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:58:20 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 83ED824E263;
        Tue,  7 Feb 2023 12:58:08 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Feb
 2023 12:58:08 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 7 Feb 2023 12:58:08 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor@kernel.org>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v3 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Topic: [PATCH v3 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Index: AQHZMi9ZN0+4F1UUIkevO0NjoPA20663GzgAgACv2gCACzF7MA==
Date:   Tue, 7 Feb 2023 04:58:08 +0000
Message-ID: <167319074e1644868e0e5461590f7ada@EXMBX066.cuchost.com>
References: <20230127091051.1465278-1-jeeheng.sia@starfivetech.com>
 <20230127091051.1465278-5-jeeheng.sia@starfivetech.com>
 <Y9hTGo6dfgeusW4B@spud>
 <CAHVXubgoi8FsfdAXVocL=ZcfGT=mA72uiq60jPVJB52ovKhdzA@mail.gmail.com>
In-Reply-To: <CAHVXubgoi8FsfdAXVocL=ZcfGT=mA72uiq60jPVJB52ovKhdzA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZHJlIEdoaXRp
IDxhbGV4Z2hpdGlAcml2b3NpbmMuY29tPg0KPiBTZW50OiBUdWVzZGF5LCAzMSBKYW51YXJ5LCAy
MDIzIDY6MDAgUE0NCj4gVG86IENvbm9yIERvb2xleSA8Y29ub3JAa2VybmVsLm9yZz4NCj4gQ2M6
IEplZUhlbmcgU2lhIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPjsgcGF1bC53YWxtc2xl
eUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsg
bGludXgtDQo+IHJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IExleWZvb24gVGFuIDxsZXlmb29uLnRhbkBzdGFyZml2ZXRlY2guY29tPjsgTWFz
b24gSHVvDQo+IDxtYXNvbi5odW9Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyA0LzRdIFJJU0MtVjogQWRkIGFyY2ggZnVuY3Rpb25zIHRvIHN1cHBvcnQgaGliZXJu
YXRpb24vc3VzcGVuZC10by1kaXNrDQo+IA0KPiBIaSwNCj4gDQo+IE9uIFR1ZSwgSmFuIDMxLCAy
MDIzIGF0IDEyOjMwIEFNIENvbm9yIERvb2xleSA8Y29ub3JAa2VybmVsLm9yZz4gd3JvdGU6DQo+
ID4NCj4gPiArQ0MgQWxleA0KPiA+DQo+ID4gQWxleCwgY291bGQgeW91IHRha2UgYSBsb29rIGF0
IHRoZSBwYWdlIHRhYmxlIGJpdHMgaGVyZSB3aGVuIHlvdSBnZXQgYQ0KPiA+IGNoYW5jZSBwbGVh
c2U/DQo+IA0KPiBZZXMsIEknbGwgZG8gdGhhdCBzb29uLg0KSGkgQWxleCwgZG8geW91IGhhdmUg
YW55IGNvbW1lbnQ/IEkgc2hhbGwgc2VuZCBvdXQgdGhlIHY0IHNvb24gYW5kIHlvdSBjYW4gcHJv
dmlkZSBjb21tZW50IHRvIHRoZSB2NCBzZXJpZXM/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBBbGV4
DQo+IA0KPiA+DQo=
