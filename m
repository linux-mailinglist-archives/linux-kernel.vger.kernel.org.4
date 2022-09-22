Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E74D5E5B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiIVGdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIVGdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:33:53 -0400
Received: from h3cspam01-ex.h3c.com (smtp.h3c.com [221.12.31.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4066B5A6E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:33:51 -0700 (PDT)
Received: from mail.maildlp.com ([172.25.15.155])
        by h3cspam01-ex.h3c.com with ESMTP id 28M6WGeo051830;
        Thu, 22 Sep 2022 14:32:16 +0800 (GMT-8)
        (envelope-from wang.binglei@h3c.com)
Received: from DAG2EX10-IDC.srv.huawei-3com.com (unknown [172.20.54.133])
        by mail.maildlp.com (Postfix) with ESMTP id 4139E2011778;
        Thu, 22 Sep 2022 14:33:22 +0800 (CST)
Received: from DAG2EX10-IDC.srv.huawei-3com.com (172.20.54.133) by
 DAG2EX10-IDC.srv.huawei-3com.com (172.20.54.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 22 Sep 2022 14:32:16 +0800
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([fe80::e886:502d:5063:7e2b])
 by DAG2EX10-IDC.srv.huawei-3com.com ([fe80::e886:502d:5063:7e2b%10]) with
 mapi id 15.01.2375.017; Thu, 22 Sep 2022 14:32:16 +0800
From:   Wangbinglei <wang.binglei@h3c.com>
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l3b2w1@gmail.com" <l3b2w1@gmail.com>
Subject: Re: [PATCH] rethook: add riscv rethook implementation.
Thread-Topic: [PATCH] rethook: add riscv rethook implementation.
Thread-Index: AdjOTPwSnSDegFjUTkauX/rKCFQbeg==
Date:   Thu, 22 Sep 2022 06:32:16 +0000
Message-ID: <e7fc6ce7cb7849558a0e33e4fd90485b@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.153.26]
x-sender-location: DAG2
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 28M6WGeo051830
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHRpcHMsIEkgcmVzZW5kZWQgbW9kaWZpZWQgcGF0Y2ggdXNpbmcgYW5v
dGhlciBtYWlsIGFkZHIobDNiMncxQGdtYWlsLmNvbSkuDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0K
t6K8/sjLOiBDb25vciBEb29sZXkgW21haWx0bzpjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbV0N
Creiy83KsbzkOiAyMDIyxOo51MIyMMjVIDE4OjMyDQrK1bz+yMs6IHdhbmdiaW5nbGVpIChSRCkg
PHdhbmcuYmluZ2xlaUBoM2MuY29tPg0Ks63LzTogcGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBw
YWxtZXJAZGFiYmVsdC5jb207IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsgbGludXgtcmlzY3ZAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbDNiMncxQGdt
YWlsLmNvbQ0K1vfM4jogUmU6IFtQQVRDSF0gcmV0aG9vazogYWRkIHJpc2N2IHJldGhvb2sgaW1w
bGVtZW50YXRpb24uDQoNCk9uIFR1ZSwgU2VwIDIwLCAyMDIyIGF0IDA1OjM2OjMwUE0gKzA4MDAs
IEJpbmdsZWkgV2FuZyB3cm90ZToNCj4gRnJvbTogIndhbmcuYmluZ2xlaSIgPHdhbmcuYmluZ2xl
aUBoM2MuY29tPg0KPg0KPiBNb3N0IG9mIHRoZSBjb2RlIGNvcGllZCBmcm9tDQo+IGFyY2gvcmlz
Y3Yva2VybmVsL3Byb2Jlcy9rcHJvYmVzX3RyYW1wb2xpbmUuUw0KDQpIZXkgV2FuZyBCaW5nbGVp
LA0KDQpQbGVhc2UgdXNlIHRoZSBjb21taXQgbG9nIHRvIGV4cGxhaW4gdGhlIHJlYXNvbnMgYmVo
aW5kIHRoZSBjaGFuZ2UgeW91DQphcmUgbWFraW5nOg0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9k
b2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbCNkZXNjcmliZS15
b3VyLWNoYW5nZXMNCg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiB3YW5nLmJpbmdsZWkgPHdhbmcuYmlu
Z2xlaUBoM2MuY29tPg0KDQpVbmZvcnR1bmF0ZWx5IEkgZG9uJ3Qga25vdyBtdWNoIGFib3V0IEFz
aWFuIG5hbWluZywgYnV0IEkgYXNzdW1lIHRoYXQNCnRoZSAuIGlzIG5vdCBwYXJ0IG9mIHlvdXIg
bmFtZT8NCg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvcHJvYmVzL2twcm9iZXMu
YyBiL2FyY2gvcmlzY3Yva2VybmVsL3Byb2Jlcy9rcHJvYmVzLmMNCj4gaW5kZXggZTZlOTUwYjdj
Li4yYzE4NDc5MjEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL3Byb2Jlcy9rcHJv
YmVzLmMNCj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYw0KPiBAQCAt
MzQ1LDYgKzM0NSw3IEBAIGludCBfX2luaXQgYXJjaF9wb3B1bGF0ZV9rcHJvYmVfYmxhY2tsaXN0
KHZvaWQpDQo+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gIH0NCj4NCj4gKyNpZm5kZWYgQ09ORklH
X0tSRVRQUk9CRV9PTl9SRVRIT09LDQoNClRoaXMgc2VlbXMgcXVpdGUgdW51c3VhbCwgb3RoZXIg
YXJjaHMgZG9uJ3Qgc2VlbSB0byBoYXZlIGlmZGVmLWVyeQ0KdXNpbmcgQ09ORklHX0tSRVRQUk9C
RV9PTl9SRVRIT09LIGluIHRoZWlyIGFyY2ggY29kZSBzbyB3aHkgc2hvdWxkDQpSSVNDLVY/DQoN
Cj4gIHZvaWQgX19rcHJvYmVzIF9fdXNlZCAqdHJhbXBvbGluZV9wcm9iZV9oYW5kbGVyKHN0cnVj
dCBwdF9yZWdzICpyZWdzKQ0KPiAgew0KPiAgICAgICAgIHJldHVybiAodm9pZCAqKWtyZXRwcm9i
ZV90cmFtcG9saW5lX2hhbmRsZXIocmVncywgTlVMTCk7DQo+IEBAIC0zNTcsNiArMzU4LDEyIEBA
IHZvaWQgX19rcHJvYmVzIGFyY2hfcHJlcGFyZV9rcmV0cHJvYmUoc3RydWN0IGtyZXRwcm9iZV9p
bnN0YW5jZSAqcmksDQo+ICAgICAgICAgcmktPmZwID0gTlVMTDsNCj4gICAgICAgICByZWdzLT5y
YSA9ICh1bnNpZ25lZCBsb25nKSAmX19rcmV0cHJvYmVfdHJhbXBvbGluZTsNCj4gIH0NCj4gKyNl
bHNlDQo+ICt2b2lkIF9fa3Byb2JlcyAqdHJhbXBvbGluZV9wcm9iZV9oYW5kbGVyKHN0cnVjdCBw
dF9yZWdzICpyZWdzKQ0KPiArew0KPiArICAgICAgIHJldHVybiBOVUxMOw0KPiArfQ0KPiArI2Vu
ZGlmDQoNCg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvcHJvYmVzL3JldGhvb2tf
dHJhbXBvbGluZS5TIGIvYXJjaC9yaXNjdi9rZXJuZWwvcHJvYmVzL3JldGhvb2tfdHJhbXBvbGlu
ZS5TDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMC4uYWE3OTYzMGFj
DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvcHJvYmVzL3JldGhv
b2tfdHJhbXBvbGluZS5TDQo+IEBAIC0wLDAgKzEsOTQgQEANCj4gKy8qIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wICovDQo+ICsvKg0KPiArICogcmV0aG9vayB0cmFtcG9saW5lLg0K
PiArICogQ29waWVkIGZyb20gYXJjaC9yaXNjdi9rZXJuZWwvcHJvYmVzL2twcm9iZXNfdHJhbXBv
bGluZS5TDQoNCklzIHRoaXMgYSAxOjEgY29weT8gSWYgc28sIGNvdWxkIHRoZSBjb2RlIGJlIHNo
YXJlZD8NCg0KPiBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlk
ZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTmV3IEgzQywgd2hpY2ggaXMNCj4gaW50ZW5kZWQgb25s
eSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUu
IEFueSB1c2Ugb2YgdGhlDQo+IGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdh
eSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwNCj4gZGlz
Y2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVy
IHRoYW4gdGhlIGludGVuZGVkDQo+IHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3Ug
cmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyDQo+
IGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhDQoNClVoLW9oISBZ
b3UnbGwgaGF2ZSB0byB3b3JrIHdpdGggeW91ciBJVCB0byBnZXQgdGhpcyByZW1vdmVkIGJlZm9y
ZSB5b3VyDQpwYXRjaGVzIGNhbiBiZSBhY2NlcHRlZDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9ZZ0VueG1EOVpFNGpWaFA1QGtyb2FoLmNvbS8NCg0KVGhlIHBhdGNoIGRvZXMgbm90IGFw
cGx5IHRvIC1uZXh0IGZvciBtZSBlaXRoZXIuLg0KDQpUaGFua3MsDQpDb25vci4NCg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0Ksb7Tyrz+vLDG5Li9vP66rNPQ0MK7qsj9vK/NxbXEsaPD3NDFz6KjrL32
z97T2reiy824+MnPw+a12Na31tDB0LP2DQq1xLj2yMu78si61+mho7371rnIzrrOxuTL+8jL0tTI
zrrO0M7Kvcq508OjqLD8wKi1q7K7z97T2sirsr+78rK/t9a12NC5wrahori01sahog0Ku/LJorei
o6mxvtPKvP7W0LXE0MXPoqGjyOe5+8T6tO3K1cHLsb7Tyrz+o6zH68T6waK8tLXnu7C78tPKvP7N
qNaqt6K8/sjLsqLJvrP9sb4NCtPKvP6joQ0KVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50
cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIE5ldyBIM0MsIHdoaWNoIGlz
DQppbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlz
IGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUNCmluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJl
aW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBh
cnRpYWwNCmRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiwgb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVy
c29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZA0KcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQu
IElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBz
ZW5kZXINCmJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhDQo=
