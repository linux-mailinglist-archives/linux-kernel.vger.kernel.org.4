Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC44736891
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjFTKAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjFTJ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:59:11 -0400
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 78B661987
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:56:22 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id A605F11010FC13;
        Tue, 20 Jun 2023 17:56:19 +0800 (CST)
Received: from ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 20 Jun 2023 17:56:19 +0800
Received: from ZJY02-ACTMBX-02.didichuxing.com ([fe80::c920:6157:2a82:1d80])
 by ZJY02-ACTMBX-02.didichuxing.com ([fe80::c920:6157:2a82:1d80%4]) with mapi
 id 15.01.2507.021; Tue, 20 Jun 2023 17:56:19 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   =?utf-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
To:     Joe Perches <joe@perches.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zyhtheonly@gmail.com" <zyhtheonly@gmail.com>,
        "zyhtheonly@yeah.net" <zyhtheonly@yeah.net>
Subject: Re: [PATCH] workqueue: format pr_warn exceeds line length in
 wq_numa_init
Thread-Topic: [PATCH] workqueue: format pr_warn exceeds line length in
 wq_numa_init
Thread-Index: AQHZoCBIFmFPOcCtZ0eLy08xIEAfk6+PP52AgADjqYCAA1digA==
Date:   Tue, 20 Jun 2023 09:56:19 +0000
Message-ID: <B84468F3-390F-4B0C-AD8C-5541E6891842@didiglobal.com>
In-Reply-To: <4fefbd7697c593b25ecc981668cc7bae1a1212d9.camel@perches.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.71.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <111FA3050E88F34EB5D1E2ADFEE1C208@didichuxing.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9lLCANCg0KVGhhbmtzIGZvciB5b3VyIGFkdmljZS4NCg0KSU1ITywgaW4gd29ya3F1ZXVl
LCBzb21lIHByaW50cyBzdGFydCB3aXRoICJ3b3JrcXVldWUgJXM6IiB3aGljaCBtZWFucyB0aGUg
d29ya3F1ZXVlX3N0cnVjdCwgbm90IHRoZSB3b3JrcXVldWUgbW9kdWxlLiBTaW5jZSB3ZSBjb3Vs
ZCBub3QgcmVtb3ZlIHRob3NlLCBzdGFydGluZyB3aXRoICJ3b3JrcXVldWU6IHdvcmtxdWV1ZSAl
cyIgbWlnaHQgYmUgY29uZnVzaW5nIHNvbWV0aW1lcyBJIGd1ZXNzLg0KDQpTbyBtYXliZQ0KI2Rl
ZmluZSBwcl9mbXQoZm10KSAiV09SS1FVRVVFOiAiIGZtdCANCm1pZ2h0IHdvcms/DQoNCg0KDQrv
u7/lnKggMjAyMy82LzE5IDEwOjQx77yM4oCcSm9lIFBlcmNoZXPigJ08am9lQHBlcmNoZXMuY29t
IDxtYWlsdG86am9lQHBlcmNoZXMuY29tPiA8bWFpbHRvOmpvZUBwZXJjaGVzLmNvbSA8bWFpbHRv
OmpvZUBwZXJjaGVzLmNvbT4+PiDlhpnlhaU6DQoNCg0KDQoNCk9uIFN1biwgMjAyMy0wNi0xOCBh
dCAwOToxOSArMDgwMCwgTGFpIEppYW5nc2hhbiB3cm90ZToNCj4gT24gRnJpLCBKdW4gMTYsIDIw
MjMgYXQgMzowMCBQTSB0aW96aGFuZyA8dGlvemhhbmdAZGlkaWdsb2JhbC5jb20gPG1haWx0bzp0
aW96aGFuZ0BkaWRpZ2xvYmFsLmNvbT4gPG1haWx0bzp0aW96aGFuZ0BkaWRpZ2xvYmFsLmNvbSA8
bWFpbHRvOnRpb3poYW5nQGRpZGlnbG9iYWwuY29tPj4+IHdyb3RlOg0KPiA+IA0KPiA+IEZvcm1h
dCB0aGlzIGxvbmcgbGluZSB3aGljaCB3b3VsZCBwb3RlbnRpYWxseSBsZXQgY2hlY2twYXRjaCBj
b21wbGFpbg0KPiA+ICJXQVJOSU5HOiBsaW5lIGxlbmd0aCBvZiAxMDMgZXhjZWVkcyAxMDAgY29s
dW1ucyIuDQpbXQ0KPiBUaGlzIHBhdGNoIGh1cnRzIHRoZSByZWFkYWJpbGl0eSBhY3R1YWxseS4g
QSBmZXcgZXh0cmEgY2hhcmFjdGVycyBleGNlZWRpbmcNCj4gaXMgT2theSBmb3IgbWUuDQpbXQ0K
PiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvd29ya3F1ZXVlLmMgYi9rZXJuZWwvd29ya3F1ZXVlLmMN
CltdDQo+ID4gQEAgLTU5NTksNyArNTk1OSw4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCB3cV9udW1h
X2luaXQodm9pZCkNCj4gPiANCj4gPiBmb3JfZWFjaF9wb3NzaWJsZV9jcHUoY3B1KSB7DQo+ID4g
aWYgKFdBUk5fT04oY3B1X3RvX25vZGUoY3B1KSA9PSBOVU1BX05PX05PREUpKSB7DQo+ID4gLSBw
cl93YXJuKCJ3b3JrcXVldWU6IE5VTUEgbm9kZSBtYXBwaW5nIG5vdCBhdmFpbGFibGUgZm9yIGNw
dSVkLCBkaXNhYmxpbmcgTlVNQSBzdXBwb3J0XG4iLCBjcHUpOw0KPiA+ICsgcHJfd2Fybigid29y
a3F1ZXVlOiBOVU1BIG5vZGUgbWFwcGluZyBub3QgYXZhaWxhYmxlIGZvciBjcHUlZCwgZGlzYWJs
aW5nIE5VTUEgc3VwcG9ydFxuIiwNCj4gPiArIGNwdSk7DQoNCg0KDQoNCldoYXQgX21pZ2h0XyB3
b3JrIHJlYXNvbmFibHkgd2VsbCBpcyB0byBhZGQNCg0KDQoNCg0KI2RlZmluZSBwcl9mbXQoZm10
KSBLQlVJTERfTU9ETkFNRSAiOiAiIGZtdA0KDQoNCg0KDQpiZWZvcmUgYW55IGluY2x1ZGUgYW5k
IHJlbW92ZSAid29ya3F1ZXVlOiAiIGZyb20NCmFsbCBwcl88Zm9vPiB1c2VzLg0KDQoNCg0KDQoN
Cg0KDQoNCg0KDQoNCg==
