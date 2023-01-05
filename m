Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69F65E2B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjAEByB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjAEBx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:53:59 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4EC431BB;
        Wed,  4 Jan 2023 17:53:57 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id EFC9424E0DF;
        Thu,  5 Jan 2023 09:53:53 +0800 (CST)
Received: from EXMBX163.cuchost.com (172.16.7.73) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 5 Jan
 2023 09:53:53 +0800
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX163.cuchost.com
 (172.16.6.73) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 5 Jan
 2023 09:53:53 +0800
Received: from EXMBX161.cuchost.com ([fe80::f152:b9a3:2243:db3c]) by
 EXMBX161.cuchost.com ([fe80::f152:b9a3:2243:db3c%15]) with mapi id
 15.00.1497.044; Thu, 5 Jan 2023 09:53:52 +0800
From:   Leyfoon Tan <leyfoon.tan@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Alex Shi" <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] dt-bindings: arm: move cpu-capacity to a shared
 loation
Thread-Topic: [PATCH v1 1/2] dt-bindings: arm: move cpu-capacity to a shared
 loation
Thread-Index: AQHZIGczv+ER1RubV0i+ee2HiF67i66PDikg
Date:   Thu, 5 Jan 2023 01:53:52 +0000
Message-ID: <9350bdbcd0604507812a52e705fc3f77@EXMBX161.cuchost.com>
References: <20230104180513.1379453-1-conor@kernel.org>
 <20230104180513.1379453-2-conor@kernel.org>
In-Reply-To: <20230104180513.1379453-2-conor@kernel.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gDQo+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+
DQo+IA0KPiBSSVNDLVYgdXNlcyB0aGUgc2FtZSBnZW5lcmljIHRvcG9sb2d5IGNvZGUgYXMgYXJt
NjQgJiB3aGlsZSB0aGVyZQ0KPiBjdXJyZW50bHkgZXhpc3RzIG5vIGJpbmRpbmcgZm9yIGNwdS1j
YXBhY2l0eSBvbiBSSVNDLVYsIHRoZSBjb2RlIHBhdGhzIGNhbiBiZQ0KPiBoaXQgaWYgdGhlIHBy
b3BlcnR5IGlzIHByZXNlbnQuDQo+IA0KPiBNb3ZlIHRoZSBkb2N1bWVudGF0aW9uIG9mIGNwdS1j
YXBhY2l0eSB0byBhIHNoYXJlZCBsb2NhdGlvbiwgYWhlYWQgb2YNCj4gZGVmaW5pbmcgYSBiaW5k
aW5nIGZvciBjYXBhY2l0eS1kbWlwcy1taHogb24gUklTQy1WLiBVcGRhdGUgc29tZQ0KPiByZWZl
cmVuY2VzIHRvIHRoaXMgZG9jdW1lbnQgaW4gdGhlIHByb2Nlc3MuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQpIaSBDb25v
cg0KDQpJIHBsYW4gdG8gbW92ZSBjcHUtY2FwYWNpdHkudHh0IGJpbmRpbmcgdG8gZ2VuZXJpYyBk
aXJlY3RvcnkgYXMgd2VsbCBhZnRlciBbMV0uIFRoYW5rcyBmb3IgeW91ciBwYXRjaCBzZXJpZXMg
aGVscGluZyB0aGlzLg0KDQoNClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2pl
Y3QvbGludXgtcmlzY3YvcGF0Y2gvMjAyMzAxMDMwMzUzMTYuMzg0MTMwMy0xLWxleWZvb24udGFu
QHN0YXJmaXZldGVjaC5jb20vDQoNCg0KUmV2aWV3ZWQtYnk6IExleSBGb29uIFRhbiA8bGV5Zm9v
bi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCg0KUmVnYXJkcw0KTGV5IEZvb24NCg0K
