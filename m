Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF76E6D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjDRUly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjDRUlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:41:37 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC6F10251
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:41:35 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0BA922C0533;
        Wed, 19 Apr 2023 08:41:33 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1681850493;
        bh=b3HTt0Kmrn0e7txKrycgHrd50xUzJaZcGOGUB1isLRc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hCZDkBEsDDb2j7gCxweVXXC8Y9OvfipBoeC995+DSYXyC01umbagxQrIaADGQk9dO
         BHx3ilK/Zo9xN1S3UmhwDHC2PJHjVEqa31XiMTQ3HXGWDeqRizVcBWqA1cSoNEnzDv
         j+9atOUBz+210kP5B/wAOr3Fonw7ItnWylNEj7pC9dpfJJSB4tYvMbBnqplK/bqlW6
         o2D6+x+wSQnwFHMskaTlZYvmR1Nfewxea4MK+9HvhFpS4tqz0tcmUh+dTcmMpYz2rH
         jhC8VaIuxzICoyTKH49Kp3ZYPFjuPTH4FQSTCE6qJ6d+PMQbuy4tt77bVqvS6KFDBF
         rxEJaehMvgpVw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B643f007c0001>; Wed, 19 Apr 2023 08:41:32 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Wed, 19 Apr 2023 08:41:32 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Apr 2023 08:41:32 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 19 Apr 2023 08:41:32 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     =?utf-8?B?TWFyaXVzeiBCaWHFgm/FhGN6eWs=?= <manio@skyboo.net>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: hwmon: (adt7475) Add support for inverting pwm output
Thread-Topic: hwmon: (adt7475) Add support for inverting pwm output
Thread-Index: AQHZceXWdXchU+yVXUm4m0tN5Sjguq8wv1sA
Date:   Tue, 18 Apr 2023 20:41:32 +0000
Message-ID: <e398560f-f8d1-afbc-4aae-ab3cf2555e8e@alliedtelesis.co.nz>
References: <20230418110623.vk6kettnjondulri@skyboo.net>
In-Reply-To: <20230418110623.vk6kettnjondulri@skyboo.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC7428B434BA4542BA77958505AF8516@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VfuJw2h9 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=dKHAf1wccvYA:10 a=UbjIg8FyWNnKGg8gc2YA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaXVzLA0KDQorY2MgbGludXgtaHdtb24sIGxrbWwNCg0KT24gMTgvMDQvMjMgMjM6MDYs
IE1hcml1c3ogQmlhxYJvxYRjenlrIHdyb3RlOg0KPiBIaSBDaHJpcywNCj4gSSBkaXNjb3ZlcmVk
IGJ5IGFjY2lkZW50IHRoYXQgbXkgZG1lc2cgaXMgdGVsbGluZyBtZToNCj4gW01vbiBBcHIgMTcg
MTk6MDg6NTkgMjAyM10gYWR0NzQ3NSAxOS0wMDJlOiBFcnJvciBjb25maWd1cmluZyBwd20gcG9s
YXJpdHkNCj4gW01vbiBBcHIgMTcgMTk6MDg6NTkgMjAyM10gYWR0NzQ3NSAxOS0wMDJlOiBBRFQ3
NDczIGRldmljZSwgcmV2aXNpb24gMQ0KPg0KPiBtb3RoZXJib2FyZDoNCj4gRE1JOiBTeXN0ZW0g
bWFudWZhY3R1cmVyIFN5c3RlbSBQcm9kdWN0IE5hbWUvTTRBNzg1VEQtViBFVk8sIEJJT1MgMjEw
NSAgICAwNy8yMy8yMDEwDQo+DQo+IElzIHRoaXMgc29tZXRoaW5nIGkgbmVlZCB0byBiZSBhZnJh
aWQsIG9yIGl0J3Mgbm90aGluZyBzZXJpb3VzPw0KDQpJdCdzIHByb2JhYmx5IGhhcm1sZXNzLCB1
bmxlc3MgeW91ciBib2FyZCBpcyBpbnRlbnRpb25hbGx5IHNldHRpbmcgdGhlIA0KcHdtLWFjdGl2
ZS1zdGF0ZSAod2hpY2ggSSBzdXNwZWN0IGl0IHdvbid0IGJlIGFzIHlvdXIgQklPUyBpcyBwcm9i
YWJseSANCnRha2luZyBjYXJlIG9mIHRoYXQgaWYgcmVxdWlyZWQpLiBJIHN1c3BlY3QgaXQncyBt
b3JlIGEgY2FzZSBvZiB0aGUgY29kZSANCm5vdCBoYW5kbGluZyB0aGUgYWJzZW5jZSBvZiBhIGRl
dmljZSB0cmVlIHdoaWNoIHRoZSBjaGVjayBmb3IgLUVJTlZBTCANCndhcyBzdXBwb3NlZCB0byBk
ZWFsIHdpdGguIFRoZXJlJ3MgYW4gb3V0c2lkZSBjaGFuY2UgdGhhdCB0aGVyZSBpcyBhIA0KcHJv
YmxlbSBvbiB0aGUgSTJDIGJ1cyBidXQgdGhhdCB3b3VsZCByZXF1aXJlIHlvdXIgcGxhdGZvcm0g
dG8gYmUgDQphY3RpdmVseSB1c2luZyB0aGUgcHdtIHBvbGFyaXR5IGZlYXR1cmUgdmlhIGEgZGV2
aWNlIHRyZWUgKHVubGlrZWx5IA0Kb3V0c2lkZSBvZiBlbWJlZGRlZCBkZXZpY2VzKS4NCg0KSSB0
aGluayBpdCdkIHN0aWxsIGJlIGEgZ29vZCBpZGVhIHRvIHNxdWFzaCB0aGUgZXJyYW50IHdhcm5p
bmcgc28gDQpnZW51aW5lIGVycm9ycyBhcmUgY2F1Z2h0LiBJJ2xsIHNlZSBpZiBJIGNhbiBwcm92
b2tlIHRoZSBpc3N1ZSBvbiANCmRldmljZXMgSSBoYXZlIGFjY2VzcyB0by4gQXJlIHlvdSBpbiBh
IHBvc2l0aW9uIHRvIHRyeSBhIHBhdGNoIGlmIEkgY29tZSANCnVwIHdpdGggb25lPw0K
