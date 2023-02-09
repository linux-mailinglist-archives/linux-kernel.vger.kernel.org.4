Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284D569036A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjBIJUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjBIJUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:20:17 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2124.outbound.protection.outlook.com [40.107.215.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B98627A0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:19:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mditzaUP/IK1twdcLeJIWZMMZC6gI5ScMKtnvmn37aZxyekfQyeFfc68p243lbfLZqc01lWsAYJyriNvraIX1i7pgY4hvah+PC+1pZiF5ugkJO+U8BYLfnYYrW3XNIGCf38PRg5QLUKuY5LMCRGBB1aXTywW+DfUasjNvuMQ3Kgye1cBYpmuYW0uo0bEP2hUlTXaVCtws9BvqWsHwXbNzlsqjnthviam0rC97MAEabTDiwjl6hFNCB7iQo59w8WDPSFpTqGzh0384MkDd0aWasrRM2AmbrsLy/vwh1vTSLHDdjAJ1Kfo6506D3VjubcizIHnIhEQr8FjmsG8pBsuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McAQJGMKN/TmiQo7yu4Phiw0Odr17i6xAvCZt7wtyXs=;
 b=Wizo1r1hfxS4belXhqX9onPEREC9wMN0D9o0M4QGGZsFpt6KxJ/ESi9uMwtvwTffSbvJiO9snqsIKWtYahGsbFz3uflWuLd7RkpgtTIguV5CiGu8WQkIZMfux0b08XW/2SPtFEO1RRwL01aDuNio3Wz0LF+EVD9Q8uhue+erLHTBO1wk9iDYzdhPSy336pZMm/VvRKeyGJHcduQK9XWG+LDIR3NB3FJdDeNrB7352KQtm/Py6DVFwk+o+OI0EtFwwGATQRgiYC62SwYNV2/cUc1wyF+9DWTnE+2/8iLytjXQ0zorn6ADfUZdys4fAubfgC1lqyMm/nAnr7JJYgSCaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 103.192.253.182) smtp.rcpttodomain=google.com smtp.mailfrom=zeku.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=zeku.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McAQJGMKN/TmiQo7yu4Phiw0Odr17i6xAvCZt7wtyXs=;
 b=73wEl8j7tmnUerNhy6SpCpr3fgcsUOb0QCVnYsrl8boT+fufzhzFR5mVtbgaw3R2X2xRdz0RI5IAaJ9kwq8FEndFf5DcDqlhFKnFLazj1t2KMZyP8u2FNxfEudZgGsC453hjdR5NSimfaZP/q8lPKFJ2O2iaw/zmv97G2r6crMDKCCXRwtBjD4kourHp3lujHuzngi//PUj0cXB0sxsq1u9JyG/jeI/332OVBh4M26PPw4VrHKpbcagXNfhkXnS3VFeYSRHheRohLrcWEc0UzojgO5phHOsgaTQKrWlhdU9jjYzXbuHMGBLSCIgcGo1dh9drzjAKa8/Ch9/eKvULgg==
Received: from SL2P216CA0216.KORP216.PROD.OUTLOOK.COM (2603:1096:101:18::11)
 by PSAPR02MB4567.apcprd02.prod.outlook.com (2603:1096:301:23::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Thu, 9 Feb
 2023 09:19:27 +0000
Received: from PSAAPC01FT030.eop-APC01.prod.protection.outlook.com
 (2603:1096:101:18:cafe::c5) by SL2P216CA0216.outlook.office365.com
 (2603:1096:101:18::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 09:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 103.192.253.182)
 smtp.mailfrom=zeku.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=zeku.com;
Received-SPF: Pass (protection.outlook.com: domain of zeku.com designates
 103.192.253.182 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.192.253.182; helo=sh-exhtc2.internal.zeku.com; pr=C
Received: from sh-exhtc2.internal.zeku.com (103.192.253.182) by
 PSAAPC01FT030.mail.protection.outlook.com (10.13.39.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 09:19:26 +0000
Received: from sh-exhtc1.internal.zeku.com (10.123.21.105) by
 sh-exhtc2.internal.zeku.com (10.123.21.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Thu, 9 Feb 2023 17:19:25 +0800
Received: from sh-exhtc4.internal.zeku.com (10.123.154.251) by
 sh-exhtc1.internal.zeku.com (10.123.21.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Thu, 9 Feb 2023 17:19:25 +0800
Received: from sh-exhtc4.internal.zeku.com ([fe80::b447:eb25:37fd:3fd8]) by
 sh-exhtc4.internal.zeku.com ([fe80::b447:eb25:37fd:3fd8%3]) with mapi id
 15.02.0986.005; Thu, 9 Feb 2023 17:19:25 +0800
From:   =?utf-8?B?6KKB5biFKFNodWFpIFl1YW4p?= <yuanshuai@zeku.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        =?utf-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
        <ouyangweizhao@zeku.com>
CC:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Weizhao Ouyang <o451686892@gmail.com>,
        =?utf-8?B?5Lu756uL6bmPKFBlbmcgUmVuKQ==?= <renlipeng@zeku.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIGthc2FuOiBmaXggZGVhZGxvY2sgaW4gc3Rh?=
 =?utf-8?Q?rt=5Freport()?=
Thread-Topic: [PATCH v2] kasan: fix deadlock in start_report()
Thread-Index: AQHZPDZzScKWhyj5L0eV70o/eMb/rq7FygeAgACH4+A=
Date:   Thu, 9 Feb 2023 09:19:24 +0000
Message-ID: <93b94f59016145adbb1e01311a1103f8@zeku.com>
References: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
 <CACT4Y+Zrz4KOU82jjEperYOM0sEp6TCmgse4XVMPkwAkS+dXrA@mail.gmail.com>
In-Reply-To: <CACT4Y+Zrz4KOU82jjEperYOM0sEp6TCmgse4XVMPkwAkS+dXrA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.122.89.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT030:EE_|PSAPR02MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a950e9-5094-47d7-94d1-08db0a7ebd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2PJueE/mc0UibPlfP171yloPOivmSXdhBrGOk07u94H7c7ExkN9UD706J/ET9xQ3nPMRHxOYpR/04LejNZLuzZhxS+XXQLFwjp16OoOONBsfm+EuxrxLK1vzcrKeLDVLhOoryezOuFnQIhjgUFJRPPYIPzBPjkhCc2QBbgQYEEQbsij0R9kIKBW6BnG1WhFpCHea95U9Y5yuZDzZwfSoLeuVGOpLkfSqcwZLy6xHfpF5YWdY8gFolDBTjCNExZRbqA/hbhrpglyvUFBrke7Z/9T0KVWtrMKzfTaxxT0K77IJaZpNXQMWhgq74q/hfoFVePa9ztx5EEuwMULfVH3/GIMN1lNZw5TfQ5ax/VB9PGeL2jrkNYv0dwEoh8hR3+lcTifp7JFQWJCdp/+1F59uWd7V8MdB4zMlCJEZNsPp+OmekBG1yCAslGZ3VJZ9uxiCmVYim4z10YY0WzLZOuOp8A3OJy04xuEyvkkwMCq/NMJGMu1gb6IIaUBwqqrbOT1ytcS/pEEZJQF0wArt7VmL8TNXN4ccxVjX9QuRB4wpKem969HBSrVdCRevWXHDfwL6+lPd/SHUdJ8D4rOrQjXYpb3wTPIzndJAXrKenzA1JYilvigGK3h1eWaL6YSNbN53jMMDJD9+jqYFCNy3zclOLAVEOlOX+InoK72xxthPveiq83ruCTArtJgYGBiWnUn5w35yLWYHFOL9MPNSu73Gw==
X-Forefront-Antispam-Report: CIP:103.192.253.182;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sh-exhtc2.internal.zeku.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(39850400004)(136003)(451199018)(36840700001)(46966006)(81166007)(24736004)(70206006)(70586007)(108616005)(41300700001)(26005)(4326008)(8936002)(186003)(54906003)(478600001)(966005)(82310400005)(86362001)(107886003)(6636002)(224303003)(83380400001)(110136005)(2906002)(7696005)(426003)(5660300002)(7416002)(40480700001)(356005)(336012)(85182001)(36756003)(2616005)(47076005)(316002)(82740400003)(36860700001)(66899018)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 09:19:26.2044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a950e9-5094-47d7-94d1-08db0a7ebd79
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=171aedba-f024-43df-bc82-290d40e185ac;Ip=[103.192.253.182];Helo=[sh-exhtc2.internal.zeku.com]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT030.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR02MB4567
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5IFZ5dWtvdg0KDQpUaGFua3MsIEkgc2VlIHRoYXQgeW91ciBtZWFucy4NCg0KQ3Vy
cmVudGx5LCByZXBvcnRfc3VwcHJlc3NlZCgpIHNlZW0gbm90IHdvcmsgaW4gS2FzYW4tSFcgbW9k
ZSwgaXQgYWx3YXlzIHJldHVybiBmYWxzZS4NCkRvIHlvdSB0aGluayBzaG91bGQgY2hhbmdlIHRo
ZSByZXBvcnRfc3VwcHJlc3NlZCBmdW5jdGlvbj8NCkkgZG9uJ3Qga25vdyB3aHkgQ09ORklHX0tB
U0FOX0hXX1RBR1Mgd2FzIGJsb2NrZWQgc2VwYXJhdGVseSBiZWZvcmUuDQoNCi0tLS0t6YKu5Lu2
5Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29t
Pg0K5Y+R6YCB5pe26Ze0OiAyMDIz5bm0MuaciDnml6UgMTY6NTYNCuaUtuS7tuS6ujog5qyn6Ziz
54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKSA8b3V5YW5nd2Vpemhhb0B6ZWt1LmNvbT4NCuaKhOmAgTog
QW5kcmV5IFJ5YWJpbmluIDxyeWFiaW5pbi5hLmFAZ21haWwuY29tPjsgQWxleGFuZGVyIFBvdGFw
ZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+OyBBbmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdt
YWlsLmNvbT47IFZpbmNlbnpvIEZyYXNjaW5vIDx2aW5jZW56by5mcmFzY2lub0Bhcm0uY29tPjsg
QW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IGthc2FuLWRldkBnb29n
bGVncm91cHMuY29tOyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IFdlaXpoYW8gT3V5YW5nIDxvNDUxNjg2ODkyQGdtYWlsLmNvbT47IOiigeW4hShTaHVh
aSBZdWFuKSA8eXVhbnNodWFpQHpla3UuY29tPjsg5Lu756uL6bmPKFBlbmcgUmVuKSA8cmVubGlw
ZW5nQHpla3UuY29tPg0K5Li76aKYOiBSZTogW1BBVENIIHYyXSBrYXNhbjogZml4IGRlYWRsb2Nr
IGluIHN0YXJ0X3JlcG9ydCgpDQoNCk9uIFRodSwgOSBGZWIgMjAyMyBhdCAwNDoyNywgV2Vpemhh
byBPdXlhbmcgPG91eWFuZ3dlaXpoYW9AemVrdS5jb20+IHdyb3RlOg0KPg0KPiBGcm9tOiBXZWl6
aGFvIE91eWFuZyA8bzQ1MTY4Njg5MkBnbWFpbC5jb20+DQo+DQo+IEZyb206IFNodWFpIFl1YW4g
PHl1YW5zaHVhaUB6ZWt1LmNvbT4NCj4NCj4gQ2FsbGluZyBzdGFydF9yZXBvcnQoKSBhZ2FpbiBi
ZXR3ZWVuIHN0YXJ0X3JlcG9ydCgpIGFuZCBlbmRfcmVwb3J0KCkNCj4gd2lsbCByZXN1bHQgaW4g
YSByYWNlIGlzc3VlIGZvciB0aGUgcmVwb3J0X2xvY2suIEluIGV4dHJlbWUgY2FzZXMgdGhpcw0K
PiBwcm9ibGVtIGFyb3NlIGluIEt1bml0IHRlc3RzIGluIHRoZSBoYXJkd2FyZSB0YWctYmFzZWQg
S2FzYW4gbW9kZS4NCj4NCj4gRm9yIGV4YW1wbGUsIHdoZW4gYW4gaW52YWxpZCBtZW1vcnkgcmVs
ZWFzZSBwcm9ibGVtIGlzIGZvdW5kLA0KPiBrYXNhbl9yZXBvcnRfaW52YWxpZF9mcmVlKCkgd2ls
bCBwcmludCBlcnJvciBsb2csIGJ1dCBpZiBhbiBNVEUNCj4gZXhjZXB0aW9uIGlzIHJhaXNlZCBk
dXJpbmcgdGhlIG91dHB1dCBsb2csIHRoZSBrYXNhbl9yZXBvcnQoKSBpcw0KPiBjYWxsZWQsIHJl
c3VsdGluZyBpbiBhIGRlYWRsb2NrIHByb2JsZW0uIFRoZSBrYXNhbl9kZXB0aCBub3QgcHJvdGVj
dA0KPiBpdCBpbiBoYXJkd2FyZSB0YWctYmFzZWQgS2FzYW4gbW9kZS4NCg0KSSB0aGluayBjaGVj
a2luZyByZXBvcnRfc3VwcHJlc3NlZCgpIHdvdWxkIGJlIGNsZWFuZXIgYW5kIHNpbXBsZXIgdGhh
biBpZ25vcmluZyBhbGwgdHJ5bG9jayBmYWlsdXJlcy4gSWYgdHJ5bG9jayBmYWlscywgaXQgZG9l
cyBub3QgbWVhbiB0aGF0IHRoZSBjdXJyZW50IHRocmVhZCBpcyBob2xkaW5nIGl0LiBXZSBvZiBj
b3Vyc2UgY291bGQgZG8gYSBjdXN0b20gbG9jayB3aGljaCBzdG9yZXMgY3VycmVudC0+dGlkIGlu
IHRoZSBsb2NrIHdvcmQsIGJ1dCBpdCBsb29rcyBlZmZlY3RpdmVseSBlcXVpdmFsZW50IHRvIGNo
ZWNraW5nIHJlcG9ydF9zdXBwcmVzc2VkKCkuDQoNCg0KDQo+IFNpZ25lZC1vZmYtYnk6IFNodWFp
IFl1YW4gPHl1YW5zaHVhaUB6ZWt1LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFdlaXpoYW8gT3V5YW5n
IDxvdXlhbmd3ZWl6aGFvQHpla3UuY29tPg0KPiBSZXZpZXdlZC1ieTogUGVuZyBSZW4gPHJlbmxp
cGVuZ0B6ZWt1LmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0tIHJlbW92ZSByZWR1
bmRhbnQgbG9nDQo+DQo+ICBtbS9rYXNhbi9yZXBvcnQuYyB8IDI1ICsrKysrKysrKysrKysrKysr
KysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvbW0va2FzYW4vcmVwb3J0LmMgYi9tbS9rYXNhbi9yZXBv
cnQuYyBpbmRleA0KPiAyMjU5OGIyMGM3YjcuLmFhMzlhYThiMTg1NSAxMDA2NDQNCj4gLS0tIGEv
bW0va2FzYW4vcmVwb3J0LmMNCj4gKysrIGIvbW0va2FzYW4vcmVwb3J0LmMNCj4gQEAgLTE2Niw3
ICsxNjYsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZmFpbF9ub25fa2FzYW5fa3VuaXRfdGVzdCh2
b2lkKQ0KPiB7IH0NCj4NCj4gIHN0YXRpYyBERUZJTkVfU1BJTkxPQ0socmVwb3J0X2xvY2spOw0K
Pg0KPiAtc3RhdGljIHZvaWQgc3RhcnRfcmVwb3J0KHVuc2lnbmVkIGxvbmcgKmZsYWdzLCBib29s
IHN5bmMpDQo+ICtzdGF0aWMgYm9vbCBzdGFydF9yZXBvcnQodW5zaWduZWQgbG9uZyAqZmxhZ3Ms
IGJvb2wgc3luYykNCj4gIHsNCj4gICAgICAgICBmYWlsX25vbl9rYXNhbl9rdW5pdF90ZXN0KCk7
DQo+ICAgICAgICAgLyogUmVzcGVjdCB0aGUgL3Byb2Mvc3lzL2tlcm5lbC90cmFjZW9mZl9vbl93
YXJuaW5nIGludGVyZmFjZS4NCj4gKi8gQEAgLTE3NSw4ICsxNzUsMTMgQEAgc3RhdGljIHZvaWQg
c3RhcnRfcmVwb3J0KHVuc2lnbmVkIGxvbmcgKmZsYWdzLCBib29sIHN5bmMpDQo+ICAgICAgICAg
bG9ja2RlcF9vZmYoKTsNCj4gICAgICAgICAvKiBNYWtlIHN1cmUgd2UgZG9uJ3QgZW5kIHVwIGlu
IGxvb3AuICovDQo+ICAgICAgICAga2FzYW5fZGlzYWJsZV9jdXJyZW50KCk7DQo+IC0gICAgICAg
c3Bpbl9sb2NrX2lycXNhdmUoJnJlcG9ydF9sb2NrLCAqZmxhZ3MpOw0KPiArICAgICAgIGlmICgh
c3Bpbl90cnlsb2NrX2lycXNhdmUoJnJlcG9ydF9sb2NrLCAqZmxhZ3MpKSB7DQo+ICsgICAgICAg
ICAgICAgICBsb2NrZGVwX29uKCk7DQo+ICsgICAgICAgICAgICAgICBrYXNhbl9lbmFibGVfY3Vy
cmVudCgpOw0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgICAgIH0NCj4N
Cj4gcHJfZXJyKCI9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KPiA9PT09XG4iKTsNCj4gKyAgICAgICByZXR1cm4gdHJ1ZTsNCj4g
IH0NCj4NCj4gIHN0YXRpYyB2b2lkIGVuZF9yZXBvcnQodW5zaWduZWQgbG9uZyAqZmxhZ3MsIHZv
aWQgKmFkZHIpIEBAIC00NjgsNw0KPiArNDczLDEwIEBAIHZvaWQga2FzYW5fcmVwb3J0X2ludmFs
aWRfZnJlZSh2b2lkICpwdHIsIHVuc2lnbmVkIGxvbmcgaXAsIGVudW0ga2FzYW5fcmVwb3J0X3R5
DQo+ICAgICAgICAgaWYgKHVubGlrZWx5KCFyZXBvcnRfZW5hYmxlZCgpKSkNCj4gICAgICAgICAg
ICAgICAgIHJldHVybjsNCj4NCj4gLSAgICAgICBzdGFydF9yZXBvcnQoJmZsYWdzLCB0cnVlKTsN
Cj4gKyAgICAgICBpZiAoIXN0YXJ0X3JlcG9ydCgmZmxhZ3MsIHRydWUpKSB7DQo+ICsgICAgICAg
ICAgICAgICBwcl9lcnIoIiVzOiByZXBvcnQgaWdub3JlXG4iLCBfX2Z1bmNfXyk7DQo+ICsgICAg
ICAgICAgICAgICByZXR1cm47DQo+ICsgICAgICAgfQ0KPg0KPiAgICAgICAgIG1lbXNldCgmaW5m
bywgMCwgc2l6ZW9mKGluZm8pKTsNCj4gICAgICAgICBpbmZvLnR5cGUgPSB0eXBlOw0KPiBAQCAt
NTAzLDcgKzUxMSwxMSBAQCBib29sIGthc2FuX3JlcG9ydCh1bnNpZ25lZCBsb25nIGFkZHIsIHNp
emVfdCBzaXplLCBib29sIGlzX3dyaXRlLA0KPiAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+
ICAgICAgICAgfQ0KPg0KPiAtICAgICAgIHN0YXJ0X3JlcG9ydCgmaXJxX2ZsYWdzLCB0cnVlKTsN
Cj4gKyAgICAgICBpZiAoIXN0YXJ0X3JlcG9ydCgmaXJxX2ZsYWdzLCB0cnVlKSkgew0KPiArICAg
ICAgICAgICAgICAgcmV0ID0gZmFsc2U7DQo+ICsgICAgICAgICAgICAgICBwcl9lcnIoIiVzOiBy
ZXBvcnQgaWdub3JlXG4iLCBfX2Z1bmNfXyk7DQo+ICsgICAgICAgICAgICAgICBnb3RvIG91dDsN
Cj4gKyAgICAgICB9DQo+DQo+ICAgICAgICAgbWVtc2V0KCZpbmZvLCAwLCBzaXplb2YoaW5mbykp
Ow0KPiAgICAgICAgIGluZm8udHlwZSA9IEtBU0FOX1JFUE9SVF9BQ0NFU1M7IEBAIC01MzYsNyAr
NTQ4LDEwIEBAIHZvaWQNCj4ga2FzYW5fcmVwb3J0X2FzeW5jKHZvaWQpDQo+ICAgICAgICAgaWYg
KHVubGlrZWx5KCFyZXBvcnRfZW5hYmxlZCgpKSkNCj4gICAgICAgICAgICAgICAgIHJldHVybjsN
Cj4NCj4gLSAgICAgICBzdGFydF9yZXBvcnQoJmZsYWdzLCBmYWxzZSk7DQo+ICsgICAgICAgaWYg
KCFzdGFydF9yZXBvcnQoJmZsYWdzLCBmYWxzZSkpIHsNCj4gKyAgICAgICAgICAgICAgIHByX2Vy
cigiJXM6IHJlcG9ydCBpZ25vcmVcbiIsIF9fZnVuY19fKTsNCj4gKyAgICAgICAgICAgICAgIHJl
dHVybjsNCj4gKyAgICAgICB9DQo+ICAgICAgICAgcHJfZXJyKCJCVUc6IEtBU0FOOiBpbnZhbGlk
LWFjY2Vzc1xuIik7DQo+ICAgICAgICAgcHJfZXJyKCJBc3luY2hyb25vdXMgZmF1bHQ6IG5vIGRl
dGFpbHMgYXZhaWxhYmxlXG4iKTsNCj4gICAgICAgICBwcl9lcnIoIlxuIik7DQo+IC0tDQo+IDIu
MjUuMQ0KPg0KPiAtLQ0KPiBZb3UgcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGJlY2F1c2UgeW91IGFy
ZSBzdWJzY3JpYmVkIHRvIHRoZSBHb29nbGUgR3JvdXBzICJrYXNhbi1kZXYiIGdyb3VwLg0KPiBU
byB1bnN1YnNjcmliZSBmcm9tIHRoaXMgZ3JvdXAgYW5kIHN0b3AgcmVjZWl2aW5nIGVtYWlscyBm
cm9tIGl0LCBzZW5kIGFuIGVtYWlsIHRvIGthc2FuLWRldit1bnN1YnNjcmliZUBnb29nbGVncm91
cHMuY29tLg0KPiBUbyB2aWV3IHRoaXMgZGlzY3Vzc2lvbiBvbiB0aGUgd2ViIHZpc2l0IGh0dHBz
Oi8vZ3JvdXBzLmdvb2dsZS5jb20vZC9tc2dpZC9rYXNhbi1kZXYvMjAyMzAyMDkwMzExNTkuMjMz
NzQ0NS0xLW91eWFuZ3dlaXpoYW8lNDB6ZWt1LmNvbS4NClpFS1UNCuS/oeaBr+WuieWFqOWjsOaY
ju+8muacrOmCruS7tuWMheWQq+S/oeaBr+W9kuWPkeS7tuS6uuaJgOWcqOe7hOe7h1pFS1XmiYDm
nInjgIIg56aB5q2i5Lu75L2V5Lq65Zyo5pyq57uP5o6I5p2D55qE5oOF5Ya15LiL5Lul5Lu75L2V
5b2i5byP77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW6YOo5YiG5oqr6Zyy44CB5aSN5Yi2
5oiW5Lyg5pKt77yJ5L2/55So5YyF5ZCr55qE5L+h5oGv44CC6Iul5oKo6ZSZ5pS25LqG5pys6YKu
5Lu277yM6K+356uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq677yM5bm25Yig6Zmk
5pys6YKu5Lu25Y+K6ZmE5Lu244CCDQpJbmZvcm1hdGlvbiBTZWN1cml0eSBOb3RpY2U6IFRoZSBp
bmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBtYWlsIGlzIHNvbGVseSBwcm9wZXJ0eSBvZiB0
aGUgc2VuZGVyJ3Mgb3JnYW5pemF0aW9uIFpFS1UuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9u
IGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQg
dG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1p
bmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBp
cyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGVtYWlsIGluIGVycm9yLCBwbGVhc2Ug
bm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0
ZSBpdC4NCg==
