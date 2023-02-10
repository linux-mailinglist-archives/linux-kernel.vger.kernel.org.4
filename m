Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236096916B7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBJCfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBJCfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:35:42 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD1A21A22
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:35:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGVvx9gYG87xo1bxpoPx4UzGPTMK6wgpZZLS5uo66T/H/X+ZK+K4Pk13W+sYvoiqqn4DQP1X32bBsGfl2pj/kBtTiR7LXORnIxYCk0CHZNnbl53pj2dJ2sZRIJcMF1iQcdKADupQu6TYW6MjHLzl7ve2unbjPFJZq11pFxVzewjWwsbMSHndu0PTpZcbKvOskDKMjep8m7YDdwr7LE25KeBKoqHpJEI4s7KOQ+I7L3zzXia6UCqYrVHNpiqhQzqZ/mN/EDEZP++PqQnXrk8fC01oiEYC53vvbeutcaW1aRVPSK28TauK/ScP9ZfmMtH2F5X/3YS9W5hMEwESjxtMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0yKomsjRaumVznH1jBW7gj+dR6xWuoQ6qn0ryUfhNo=;
 b=F+j+7GijukDc34JHY3thdZU7xwpdzO3yMMmhjvMuup5b2ZgPmPGetmIQ2+vl4WKAr/nxLyvRU7u+3xu42SEUKYo6XeyeEBFSftt+zFQnvDQf5JCak49KMeS0wuAb/NE0GNKAmVIaJZNSy4O/jKhlI0+ot1XD+eZ6eJ0gVyQz2AtZao5h48EmucNYj3nWZzJUlgKgtTYtCW6o2/ZiDmBGwDl+GMrD8WU2boFNMkbEWA+OiLOBQrfIGq9+jMoDcnokEFwbSYt2hFPgLnwwNcHLyx7d8hFeNZZWVkOcdUE/qMVZ98VbL1BO0+zWwGuKng9Tu7b/VEd5h2YJ40okd24bLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 103.192.253.182) smtp.rcpttodomain=gmail.com smtp.mailfrom=zeku.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=zeku.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0yKomsjRaumVznH1jBW7gj+dR6xWuoQ6qn0ryUfhNo=;
 b=VXUDygMdjavkSjgsvUhhMhoUPLUh5MeE/9ueUh/lChWSBUNPoq6x0lUt/30WlcQVm9RWgR+E6ntSVzxXqPfm+yp0PyT7gDm+rEXClpt5Mzi1XvV9Iy4jiARs8ocOmys5gPtl6+mqQqUNkulF+DuloaamOTKrnLQlpMEfpYfbPk8gykjKlY4CkGCawHL44icxREiF4kPOCVZdpLC0B36prsuhdgbfNoQPyaBP+svv+CB++1Q7tyKRkl1O6pZ3o6Prpj2POW3JHar5yCVmXpHDKyfoOgUxVBlX3EcPH67PnodKHCKhxdg1jkwkUYDWUgqaALR2t0pgm8/z0z+X1ge0yQ==
Received: from PS2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::36) by TYZPR02MB6161.apcprd02.prod.outlook.com
 (2603:1096:400:28a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18; Fri, 10 Feb
 2023 02:35:36 +0000
Received: from PSAAPC01FT049.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:58:cafe::d3) by PS2PR01CA0048.outlook.office365.com
 (2603:1096:300:58::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Fri, 10 Feb 2023 02:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 103.192.253.182)
 smtp.mailfrom=zeku.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=zeku.com;
Received-SPF: Pass (protection.outlook.com: domain of zeku.com designates
 103.192.253.182 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.192.253.182; helo=sh-exhtc2.internal.zeku.com; pr=C
Received: from sh-exhtc2.internal.zeku.com (103.192.253.182) by
 PSAAPC01FT049.mail.protection.outlook.com (10.13.39.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.19 via Frontend Transport; Fri, 10 Feb 2023 02:35:36 +0000
Received: from sh-exhtc5.internal.zeku.com (10.123.154.252) by
 sh-exhtc2.internal.zeku.com (10.123.21.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Fri, 10 Feb 2023 10:32:30 +0800
Received: from sh-exhtc4.internal.zeku.com (10.123.154.251) by
 sh-exhtc5.internal.zeku.com (10.123.154.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5;
 Fri, 10 Feb 2023 10:32:29 +0800
Received: from sh-exhtc4.internal.zeku.com ([fe80::b447:eb25:37fd:3fd8]) by
 sh-exhtc4.internal.zeku.com ([fe80::b447:eb25:37fd:3fd8%3]) with mapi id
 15.02.0986.005; Fri, 10 Feb 2023 10:32:29 +0800
From:   =?utf-8?B?6KKB5biFKFNodWFpIFl1YW4p?= <yuanshuai@zeku.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
CC:     =?utf-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
        <ouyangweizhao@zeku.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Weizhao Ouyang <o451686892@gmail.com>,
        =?utf-8?B?5Lu756uL6bmPKFBlbmcgUmVuKQ==?= <renlipeng@zeku.com>
Subject: RE: [PATCH v2] kasan: fix deadlock in start_report()
Thread-Topic: [PATCH v2] kasan: fix deadlock in start_report()
Thread-Index: AQHZPDZzScKWhyj5L0eV70o/eMb/rq7FygeAgACH4+D//5aGAIAAy+8AgAC6aDA=
Date:   Fri, 10 Feb 2023 02:32:29 +0000
Message-ID: <b058a424e46d4f94a1f2fdc61292606b@zeku.com>
References: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
 <CACT4Y+Zrz4KOU82jjEperYOM0sEp6TCmgse4XVMPkwAkS+dXrA@mail.gmail.com>
 <93b94f59016145adbb1e01311a1103f8@zeku.com>
 <CACT4Y+a=BaMNUf=_suQ5or9=ZksX2ht9gX8=XBSDEgHogyy3mg@mail.gmail.com>
 <CA+fCnZf3k-rsaOeti0Q7rqkmvsqDb2XxgxOq6V5Gqp6FGLH7Yg@mail.gmail.com>
In-Reply-To: <CA+fCnZf3k-rsaOeti0Q7rqkmvsqDb2XxgxOq6V5Gqp6FGLH7Yg@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: PSAAPC01FT049:EE_|TYZPR02MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: aff9e88e-5d38-48f6-f4f9-08db0b0f7d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6LRCeDAcY71pXlxfgRGa74xJa9NWLWxXYi+6K5tCUzNo3XXIpSBcbVqT3ksJGnHlCBu/GnN9+4AEqCUy++d0f9Jkh2rnpignpKDsZza8DHJIFwl64JwFBmPpXORKRrYtmcT530FiZyPoTGCwBlsa9U1nvq5rDNczlJQgtds9JhFF62rh2hTYOosIslJ1yEkwXTphFVrSi9N6Ke91TGM8PBfgQi5W7X8gNFQHFaqdF3RUmG2LY6FVHu10snRxQms4KfLUUGMJTch0FtleJgoT/RChYEF1PklD16+3rJK8syfZCm/NY9ra1g1V8Al8Izz7nXMxz09PasPBXCnqq+A3tKbQVRGd//xN1dIcnCP9hjIXQ1lBpHhMm/t6Zt1YwaID/rPC8BTsSezsWoroLFI3lk4OvjljyPaeBOove0X6IU0Sa2OPSKsLgVdd+FNkzZyiC2Gfb/iqF8G7ZyCQ+dsE5xLm988kLAP5BAyCBuhhi6d/0pemkGr+ewYyAXYAIxIqwxBq+ivmV1Kl+MtoncoLLbvWhVYPNi/nktPDt05G1aXJIFuBH4ke2QjV2+sSKeoxcNyfeopA8GnUEQ2X/C49jVOFbN4op3yke1FKDUCNfHi8dPD7RCZBjUAW3zN8yYYOxmdgg+9MP33KROcauJvvsbEwqo5rvXYSn5hS8lZ/shjpWKSgy4Kjl+sK0dtSz3QHbAu2nBe7LgjeOnYZVqp6aamnKPY5r+Zt5ZZvKIFT/o=
X-Forefront-Antispam-Report: CIP:103.192.253.182;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sh-exhtc2.internal.zeku.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(39850400004)(136003)(451199018)(36840700001)(46966006)(2906002)(186003)(7416002)(86362001)(426003)(47076005)(108616005)(2616005)(8936002)(81166007)(336012)(5660300002)(26005)(82310400005)(36756003)(966005)(7696005)(478600001)(53546011)(24736004)(85182001)(107886003)(83380400001)(316002)(41300700001)(4326008)(40480700001)(8676002)(70586007)(82740400003)(54906003)(356005)(36860700001)(70206006)(110136005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 02:35:36.1101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff9e88e-5d38-48f6-f4f9-08db0b0f7d9d
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=171aedba-f024-43df-bc82-290d40e185ac;Ip=[103.192.253.182];Helo=[sh-exhtc2.internal.zeku.com]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT049.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpZGF5LCBGZWJydWFyeSAxMCwgMjAyMyBhdCA2OjU0IEFNIEFuZHJleSBLb25vdmFsb3Yg
PGFuZHJleWtudmxAZ21haWwuY29tPg0Kd3JvdGU6DQo+IE9uIFRodSwgRmViIDksIDIwMjMgYXQg
MTE6NDQgQU0gRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KPiB3cm90ZToNCj4g
Pg0KPiA+ICBPbiBUaHUsIDkgRmViIDIwMjMgYXQgMTA6MTksIOiigeW4hShTaHVhaSBZdWFuKSA8
eXVhbnNodWFpQHpla3UuY29tPg0KPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBIaSBEbWl0cnkgVnl1
a292DQo+ID4gPg0KPiA+ID4gVGhhbmtzLCBJIHNlZSB0aGF0IHlvdXIgbWVhbnMuDQo+ID4gPg0K
PiA+ID4gQ3VycmVudGx5LCByZXBvcnRfc3VwcHJlc3NlZCgpIHNlZW0gbm90IHdvcmsgaW4gS2Fz
YW4tSFcgbW9kZSwgaXQNCj4gYWx3YXlzIHJldHVybiBmYWxzZS4NCj4gPiA+IERvIHlvdSB0aGlu
ayBzaG91bGQgY2hhbmdlIHRoZSByZXBvcnRfc3VwcHJlc3NlZCBmdW5jdGlvbj8NCj4gPiA+IEkg
ZG9uJ3Qga25vdyB3aHkgQ09ORklHX0tBU0FOX0hXX1RBR1Mgd2FzIGJsb2NrZWQgc2VwYXJhdGVs
eQ0KPiBiZWZvcmUuDQo+ID4NCj4gPiBUaGF0IGxvZ2ljIHdhcyBhZGRlZCBieSBBbmRyZXkgaW46
DQo+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9y
dmFsZHMvbGludXguZ2l0L2NvbQ0KPiA+IG1pdC8/aWQ9YzA2ODY2NGM5N2M3Y2YNCj4gPg0KPiA+
IEFuZHJleSwgY2FuIHdlIG1ha2UgcmVwb3J0X2VuYWJsZWQoKSBjaGVjayBjdXJyZW50LT5rYXNh
bl9kZXB0aCBhbmQNCj4gPiByZW1vdmUgcmVwb3J0X3N1cHByZXNzZWQoKT8NCj4NCj4gSSBkZWNp
ZGVkIHRvIG5vdCB1c2Uga2FzYW5fZGVwdGggZm9yIEhXX1RBR1MsIGFzIHdlIGNhbiBhbHdheXMg
dXNlIGENCj4gbWF0Y2gtYWxsIHRhZyB0byBtYWtlICJpbnZhbGlkIiBtZW1vcnkgYWNjZXNzZXMu
DQo+DQo+IEkgdGhpbmsgd2UgY2FuIGZpeCB0aGUgcmVwb3J0aW5nIGNvZGUgdG8gZG8gZXhhY3Rs
eSB0aGF0IHNvIHRoYXQgaXQgZG9lc24ndA0KPiBjYXVzZSBNVEUgZmF1bHRzLg0KPg0KPiBTaHVh
aSwgY291bGQgeW91IGNsYXJpZnksIGF0IHdoaWNoIHBvaW50IGR1ZSBrYXNhbl9yZXBvcnRfaW52
YWxpZF9mcmVlIGFuDQo+IE1URSBleGNlcHRpb24gaXMgcmFpc2VkIGluIHlvdXIgdGVzdHM/DQoN
ClllcywgSSBuZWVkIHNvbWUgdGltZSB0byBjbGFyaWZ5IHRoaXMgcHJvYmxlbSB3aXRoIGEgY2xl
YXIgbG9nIGJ5IHRlc3QuDQoNCj4gPiBUaGVuIHdlIGNhbiBhbHNvIHJlbW92ZSB0aGUgY29tbWVu
dCBpbiBrYXNhbl9yZXBvcnRfaW52YWxpZF9mcmVlKCkuDQo+ID4NCj4gPiBJdCBsb29rcyBsaWtl
IGthc2FuX2Rpc2FibGVfY3VycmVudCgpIGluIGttZW1sZWFrIG5lZWRzIHRvIGFmZmVjdA0KPiA+
IEhXX1RBR1MgbW9kZSBhcyB3ZWxsOg0KPiA+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xp
bnV4L3Y2LjItcmM3L3NvdXJjZS9tbS9rbWVtbGVhay5jI0wzMDENCj4NCj4gSXQgdXNlcyBrYXNh
bl9yZXNldF90YWcsIHNvIGl0IHNob3VsZCB3b3JrIHByb3Blcmx5IHdpdGggSFdfVEFHUy4NClpF
S1UNCuS/oeaBr+WuieWFqOWjsOaYju+8muacrOmCruS7tuWMheWQq+S/oeaBr+W9kuWPkeS7tuS6
uuaJgOWcqOe7hOe7h1pFS1XmiYDmnInjgIIg56aB5q2i5Lu75L2V5Lq65Zyo5pyq57uP5o6I5p2D
55qE5oOF5Ya15LiL5Lul5Lu75L2V5b2i5byP77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW
6YOo5YiG5oqr6Zyy44CB5aSN5Yi25oiW5Lyg5pKt77yJ5L2/55So5YyF5ZCr55qE5L+h5oGv44CC
6Iul5oKo6ZSZ5pS25LqG5pys6YKu5Lu277yM6K+356uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l
5Y+R5Lu25Lq677yM5bm25Yig6Zmk5pys6YKu5Lu25Y+K6ZmE5Lu244CCDQpJbmZvcm1hdGlvbiBT
ZWN1cml0eSBOb3RpY2U6IFRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBtYWlsIGlz
IHNvbGVseSBwcm9wZXJ0eSBvZiB0aGUgc2VuZGVyJ3Mgb3JnYW5pemF0aW9uIFpFS1UuIEFueSB1
c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVk
aW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVw
cm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGlu
dGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGVt
YWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwg
aW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdC4NCg==
