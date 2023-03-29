Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7A26CD437
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjC2IPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjC2IPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:15:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4E2272A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:15:29 -0700 (PDT)
X-UUID: dbcff394ce0911eda9a90f0bb45854f4-20230329
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GgSL2KlHPXSPskKaN8x7F3M5iq9nzV7L2mm7hY97A3Q=;
        b=EtQYGIBYNil7gwFYJsrJIjmU5DB7D2hl0/IUoGC3TySIMkExHek7IL0jfjGRD3bKJbYkSpf3GpVgvfLiXL6br0HM24hJ5suAb62Q9YLMpvrF0UD1BCSc6vPRDMrAa6qZ8Iwskpf84qx9TXWLm5ECcinREWIbmRKzVuo7iLJR4Ok=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:20a8c82f-cb6c-4356-9206-8e3002c3b654,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:70ae44f7-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: dbcff394ce0911eda9a90f0bb45854f4-20230329
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1850637664; Wed, 29 Mar 2023 16:15:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 29 Mar 2023 16:15:24 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 29 Mar 2023 16:15:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z87Hte3uAHbOkm9XFWSA1utRyMRAGcDB+MWgiLHYCoO3IdQwtNoqgQOY7Qv9jSRCBcRbOJ1rLbaP1Lw6uiMh6PsmqYP3nfmCxv2fBER+82xrmoSha4bliAwTo5I2a0hDyBPVZcqBD/JRj+nYX6h/iz9Rh1uCsNhoRwnfYpBdADmthAccYWAJ2EiATY+RWwkyIu5OZCatO++PehQG+xy1+rTUbZa4GwzIE/k1cAxAw5gKRpRK6c7IcvaXN84V9lt1UDVIpORD2jeYg7l74L/BVVEZRgbwnxgncmHxqj+H3dBVixpgiomNOEbjl466cjnqMjxUDNFYIOqxv4bJfR/mrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgSL2KlHPXSPskKaN8x7F3M5iq9nzV7L2mm7hY97A3Q=;
 b=ikGtE3PV13W+N0ajuqacsRqxDAVm5f9FO0g1NWE+FfTiCanNJWjXOnG6jo5M4RzjFaDf6peLa+pVjbpiHnxzHH4JxI0XUjh24u7yt9QLEzWCd72eCngdCRswxmvWFf8IYgve5otyM+nz1selP7fTTH9qFXXeeaNf8g2ncKhlvT7Gn/KHM73NGLWyBBBNGEPr6G1LCPBZK+ZRtygUS9ISGanwBhhMmYWN5Bs6OwMtuj9WVs4z9qr6X8CT5rUnnYZ7/NQi8mvVBd5J32wFcq7VO9HXWPUcjuE+vHH+sITuRaASXiXlRpvNHIN3JUk8TNwl2BpDCmU1aFxiuveflJ1cNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgSL2KlHPXSPskKaN8x7F3M5iq9nzV7L2mm7hY97A3Q=;
 b=fXMDKWewZarPYKWtSE00I7BtXx4V90hGkpxZpB7XVVW+B/ulYTtpptalrAycPllRnwGrJVsjVcUjAQRlC9zIgAD4jTEv9NI2MHMka3AU250wD1pJNHiOdHsiNsxXubQP62gD1hJ1VNOIKn+x9S9sVGkToEqVpfyYbWmx1Gf+KQ0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB5998.apcprd03.prod.outlook.com (2603:1096:4:14a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 08:15:22 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d1ad:2b04:c433:f8]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d1ad:2b04:c433:f8%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 08:15:22 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] drm/mediatek: Add ovl_adaptor get format function
Thread-Topic: [PATCH v2] drm/mediatek: Add ovl_adaptor get format function
Thread-Index: AQHZYeIiS4iAeDM74UWHvitJqWqt5q8RaXGA
Date:   Wed, 29 Mar 2023 08:15:22 +0000
Message-ID: <ceb353983d48c5a0a967de7ea256dbe6a5de6bed.camel@mediatek.com>
References: <20230329015916.21684-1-nancy.lin@mediatek.com>
In-Reply-To: <20230329015916.21684-1-nancy.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB5998:EE_
x-ms-office365-filtering-correlation-id: 8bf7d7ee-fe06-43b2-f6b6-08db302dbdde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KgUl6hPaWpyO2MPEXU+oPob/acOZHzfOAtZ+sTD8StgTo07+/8tBlN2h3YWeDQAXEmrYVzjFXhPFWlXYPkWZpdb0P7E/KZdfHegJQKPoxsnrATuFPaU+pi7cd2V3TsB3fn4UZuq744YggoVjJOx6e1cUaS19TdEonaNpEHrBWSj1+9g3RbNWtJTUuQ4QCdaSHeRJnFGgfUJOXrQ/KHrhMrBJEI8mnt1mqNO7zXJkPrZ29JnMxHrDoOmSevXKYETe70R1qyJyb87qSWPWspOXu2wnpYoIt/eLzH7WPrRHbfrmuUtGmnjCUPRFdAPNDcqKHjY4bjLasGL2t2/0NGoRSX6FSWmKYk9hCWJTyO9SFJCkFb+CR0OWwC68vVObt8sPKMcYTZAzvcIgiqq/bLyTb2m93y1ASe+ev6HYNxUxCw+d0s08WsQ4HDsiGY907ebBUyBTByGgnmq/HvyNIuAGguH+5gLCZ9qNCoeAmIpBn9g4LZlq2hdQYxHHXLHmMwvQS4qngUjcq7HFUYT29uUFcSAjpRQVz/d+DNdvC3IW1gq11ybfCZCtT4Qhu3Tv7t83UsFAp6rSLI7S9ssjtjJPgVzsvAY/jm/ra49KNEtfjIAeLcBMb5/HK9sPtsWH1RjJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(26005)(54906003)(2906002)(6486002)(86362001)(71200400001)(6512007)(2616005)(66446008)(186003)(8676002)(38070700005)(66946007)(5660300002)(8936002)(76116006)(66556008)(85182001)(4326008)(36756003)(64756008)(66476007)(41300700001)(122000001)(38100700002)(478600001)(110136005)(6506007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjMvajdVR0tGUE5DbkxIL3RvU2NnbWIxL3huSnh1aWNzUmxaMm1CckZFdUNx?=
 =?utf-8?B?WG5sTVpoaEo5NG9wZEhuVjdDTTFkeVVBWjVBRFh3N3EybkRUOXQxd0FYeTA0?=
 =?utf-8?B?cHE3WXJMZlh4Y21JUVgrcTV1cGtuU05vRlRyZGkvQjZwRHlXejdZY21jY3N3?=
 =?utf-8?B?bWhzR2ZMVWZ6YmRSM3lmM1I5dnBMcnZqV1JTWXlXVXEyS3J1ZHBRMHp2Qk5p?=
 =?utf-8?B?Tit4RVFEenFtWVRVMEJ0a0NscXAvQkJDWFB0eld2YUFJUkV3SGlOdUZ6YnJz?=
 =?utf-8?B?Q1pXL0RsdUIvL3pPQk9lNTE3dTlZeC9sSlFxWHN3eUVKaHBRYVFQazAxSkd5?=
 =?utf-8?B?Vk43V0NPYWYyMHBralBkeXlYYXVGQU9QS00rMmYyemwrWmFMSWJNTXkvbEpv?=
 =?utf-8?B?NFlnajBoazFBU0ExbGJJamU1c243eEo1bnNvakdvR0t5ek1tQXNoczh1YnBa?=
 =?utf-8?B?R0VabG56TEJKcUVzZGRFd3I1SDJLSFRpTU5WNjB1ZWVZdU1NSHp3enQxWkl2?=
 =?utf-8?B?ZXhqRW93ZlZlRHlJWFdKTlBUaFhOVVBJcmZIaEJCN1NtcUJhOEdUbjNGa3pO?=
 =?utf-8?B?dGNGaFJVK3EvYzNJeVh4VTUwaHJFZDhKN2N2RTU0VzZHSEVwQ2ptUnZHbXgz?=
 =?utf-8?B?bmVyWXNXOWhVZWZ4TVZxYlVNeWlwaGJKcmExdEZ4a2JFamNRWk16RHlOTDNo?=
 =?utf-8?B?bkN3aGxJWGJLc0lOWG9kenIzZGhjWGFnQXBWV1BPaVM1K3dWNUxJZXpzN1lP?=
 =?utf-8?B?QnoxYVhLaVNvNlRzMldLNWN2YUVqY3VnV0xkZFRBY29NK0lNSnJpMUFRWEpv?=
 =?utf-8?B?Z1REN1VuMC9wck9QNmFDQXh4YkpaNEFYRWE0MUN1aEJlQ083UmNGcVkwZG5a?=
 =?utf-8?B?ZTMxMEJENStZQnRlamZMYTEwbHdWVCtpVWdidTRFYVdwbjZSSFFXZGVsZEpk?=
 =?utf-8?B?ZTFUd29RRU1pTk9MRHNNSHYzcExEU2Vzc0x4THE2Y2ZodEZ5dHJXa0Qrb3JK?=
 =?utf-8?B?NWlZQ0o1SzB4MFpZaWozam1wUENXdkR6cDhXVm1mVjR2a3ZVM201Y3VJTVMw?=
 =?utf-8?B?SnFjOS9HemJFTEVUT09MbzRxYnhPK1dCTDAzSkxReGZVTGVSS0RPb2poTi8y?=
 =?utf-8?B?R0VKWjZERWpTWktmSjl6aFlJUjRqRDZvVUxsVHBlRkJtajdYeFJjdGtJcU5m?=
 =?utf-8?B?MUhsK09HaEViS29GdjNZOHRxblUzck9lWExaMWs1MWpMQUhUenUvaE84ZC8r?=
 =?utf-8?B?dWEyTDN0VW8xamVQUDZGd3JNaHZJMkVUaExidHpwaVAvYUdDaEVxQS9Memcy?=
 =?utf-8?B?Q0I5MUVkUDF4VXJPeFBLWXlMOUliQ2RqRm9zMXBGK25sV3ZNZjZXZUdBamsw?=
 =?utf-8?B?OFgzRUxuTWVWazBYMHl6MmdFMUZ3ak9NYzB5LzR4Rnl6RHY0S0N0UGFtc3p2?=
 =?utf-8?B?WXVvNUFpNlB1VUx5ek5YeGtQV2I2Und0cGJFMXBQWkd1OXRBYlNoUGkvVmlw?=
 =?utf-8?B?cUZkYkNjbE5jbnhZNllMTEJqY2xpZXRNMGM1YVIyNUQ1V3NDWVBYUC91SGxJ?=
 =?utf-8?B?bFZYRTc3cXIxMkdMbWJGNUFRZEJjUTlGUUpvSTNkWTF4ZlRaZDNhMTB4QXBJ?=
 =?utf-8?B?OENLa0VVZjdrOGtoVkFVTkttSzlqVUVXdUdxUDNrS09LL3lVZEtnUlc4LzZk?=
 =?utf-8?B?cFdHbXVURzRQQzQ0WExBZTFGdWQ0SjJJdDRVWVhQN05nL0ZWRG51S09PcjdQ?=
 =?utf-8?B?Wm5GVUg5eDl4ZVZJdGU2SUpUNlJCbXpIVHV3cjhKOEM2eWVjWFNRb2V5ZTJH?=
 =?utf-8?B?TmRJNk5vYmN4bVUvaWYvamIrYW04c1k1NjZ6QVF5ZUhhRGxUMU44bXJRRSts?=
 =?utf-8?B?ZWFSdEJpZ1ZjbnFCWkZnekRDdHlZLzhMaHlkOW1EWTRoYjV6OEpZNTh0VzJ5?=
 =?utf-8?B?Y1Fra3d0U09HUjF0OVRjclFUbnRJVlozeGFaZWVSMUxBRk9tTUdDY1dVeFJF?=
 =?utf-8?B?S05NanlWSUhtaFVXY3QwalVBZ3hUaUQxd1h2UG5QTHg3RHJWWlZFWWZkZlB0?=
 =?utf-8?B?Q3Z5U3REcC9wcnRFMW4zS0htZG9PcDdmYVBEektPYjlXUzRDdjJic05HT2ND?=
 =?utf-8?Q?+rfPGhB2Pqt26wKZboLK3gW6j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72EE74242DF1894D81E8FA0D8BD3FD9F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf7d7ee-fe06-43b2-f6b6-08db302dbdde
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 08:15:22.0169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5bZTfp9larcnKX3yKyefW5pulZt6mglRzSUzS0Y5Hkr2+o2HHgbWP+iqac2+OlJKNHRp/Z04eNo05nEJbOMJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5998
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE5hbmN5Og0KDQpPbiBXZWQsIDIwMjMtMDMtMjkgYXQgMDk6NTkgKzA4MDAsIE5hbmN5Lkxp
biB3cm90ZToNCj4gQWRkIG92bF9hZGFwdG9yIGdldF9mb3JtYXQgYW5kIGdldF9udW1fZm9ybWF0
cyBjb21wb25lbnQgZnVuY3Rpb24uDQo+IFRoZSB0d28gZnVuY3Rpb25zIGFyZSBuZWVkIGZvciBn
ZXR0aW5nIHRoZSBzdXBwb3J0ZWQgZm9ybWF0IGluDQo+IG10a19wbGFuZV9pbml0KCkuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBOYW5jeS5MaW4gPG5hbmN5LmxpbkBtZWRpYXRlay5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICAgIHwgIDIg
KysNCj4gIC4uLi9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMgICB8IDI0
DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcF9jb21wLmMgICB8ICAyICsrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3BfZHJ2LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4g
aW5kZXggMGQyOGIyZTIwNjljLi5kYTJkZTE3Yjg0ZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gQEAgLTEyNCw2ICsxMjQsOCBAQCB2b2lkIG10a19v
dmxfYWRhcHRvcl9zdGFydChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgdm9pZCBtdGtfb3ZsX2Fk
YXB0b3Jfc3RvcChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgdW5zaWduZWQgaW50IG10a19vdmxf
YWRhcHRvcl9sYXllcl9ucihzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgc3RydWN0IGRldmljZSAq
bXRrX292bF9hZGFwdG9yX2RtYV9kZXZfZ2V0KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICtjb25z
dCB1MzIgKm10a19vdmxfYWRhcHRvcl9nZXRfZm9ybWF0cyhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0K
PiArc2l6ZV90IG10a19vdmxfYWRhcHRvcl9nZXRfbnVtX2Zvcm1hdHMoc3RydWN0IGRldmljZSAq
ZGV2KTsNCj4gIA0KPiAgdm9pZCBtdGtfcmRtYV9ieXBhc3Nfc2hhZG93KHN0cnVjdCBkZXZpY2Ug
KmRldik7DQo+ICBpbnQgbXRrX3JkbWFfY2xrX2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFw
dG9yLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3Iu
Yw0KPiBpbmRleCAwNDYyMTc4MjhhYjMuLmI1ZDI4YzM5MmM1NyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gQEAgLTI1LDYg
KzI1LDIwIEBADQo+ICAjZGVmaW5lIE1US19PVkxfQURBUFRPUl9SRE1BX01BWF9XSURUSCAxOTIw
DQo+ICAjZGVmaW5lIE1US19PVkxfQURBUFRPUl9MQVlFUl9OVU0gNA0KPiAgDQo+ICtzdGF0aWMg
Y29uc3QgdTMyIGZvcm1hdHNbXSA9IHsNCj4gKwlEUk1fRk9STUFUX1hSR0I4ODg4LA0KPiArCURS
TV9GT1JNQVRfQVJHQjg4ODgsDQo+ICsJRFJNX0ZPUk1BVF9CR1JYODg4OCwNCj4gKwlEUk1fRk9S
TUFUX0JHUkE4ODg4LA0KPiArCURSTV9GT1JNQVRfQUJHUjg4ODgsDQo+ICsJRFJNX0ZPUk1BVF9Y
QkdSODg4OCwNCj4gKwlEUk1fRk9STUFUX1JHQjg4OCwNCj4gKwlEUk1fRk9STUFUX0JHUjg4OCwN
Cj4gKwlEUk1fRk9STUFUX1JHQjU2NSwNCj4gKwlEUk1fRk9STUFUX1VZVlksDQo+ICsJRFJNX0ZP
Uk1BVF9ZVVlWLA0KPiArfTsNCj4gKw0KPiAgZW51bSBtdGtfb3ZsX2FkYXB0b3JfY29tcF90eXBl
IHsNCj4gIAlPVkxfQURBUFRPUl9UWVBFX1JETUEgPSAwLA0KPiAgCU9WTF9BREFQVE9SX1RZUEVf
TUVSR0UsDQo+IEBAIC0yOTcsNiArMzExLDE2IEBAIHZvaWQgbXRrX292bF9hZGFwdG9yX2Rpc2Fi
bGVfdmJsYW5rKHN0cnVjdA0KPiBkZXZpY2UgKmRldikNCj4gIAltdGtfZXRoZHJfZGlzYWJsZV92
Ymxhbmsob3ZsX2FkYXB0b3ItDQo+ID5vdmxfYWRhcHRvcl9jb21wW09WTF9BREFQVE9SX0VUSERS
MF0pOw0KPiAgfQ0KPiAgDQo+ICtjb25zdCB1MzIgKm10a19vdmxfYWRhcHRvcl9nZXRfZm9ybWF0
cyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJcmV0dXJuIGZvcm1hdHM7DQoNClRoZSBz
dXBwb3J0ZWQgZm9ybWF0cyBkZXBlbmQgb24gdGhlIG1kcC1yZG1hIGhhcmR3YXJlIGNhcGFiaWxp
dHksIHNvDQpnZXQgZm9ybWF0cyBmcm9tIG1kcC1yZG1hIGRyaXZlci4NCg0KUmVnYXJkcywNCkNL
DQoNCj4gK30NCj4gKw0KPiArc2l6ZV90IG10a19vdmxfYWRhcHRvcl9nZXRfbnVtX2Zvcm1hdHMo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXJldHVybiBBUlJBWV9TSVpFKGZvcm1hdHMp
Ow0KPiArfQ0KPiArDQo+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9hZGRfY29tcChzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBtdGtfbXV0ZXgNCj4gKm11dGV4KQ0KPiAgew0KPiAgCW10a19tdXRl
eF9hZGRfY29tcChtdXRleCwgRERQX0NPTVBPTkVOVF9NRFBfUkRNQTApOw0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gaW5kZXggMWEwYzRmN2Uz
NTJhLi5mMTE0ZGE0ZDM2YTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZGRwX2NvbXAuYw0KPiBAQCAtNDEwLDYgKzQxMCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgbXRrX2RkcF9jb21wX2Z1bmNzDQo+IGRkcF9vdmxfYWRhcHRvciA9IHsNCj4gIAkuZGlzY29u
bmVjdCA9IG10a19vdmxfYWRhcHRvcl9kaXNjb25uZWN0LA0KPiAgCS5hZGQgPSBtdGtfb3ZsX2Fk
YXB0b3JfYWRkX2NvbXAsDQo+ICAJLnJlbW92ZSA9IG10a19vdmxfYWRhcHRvcl9yZW1vdmVfY29t
cCwNCj4gKwkuZ2V0X2Zvcm1hdHMgPSBtdGtfb3ZsX2FkYXB0b3JfZ2V0X2Zvcm1hdHMsDQo+ICsJ
LmdldF9udW1fZm9ybWF0cyA9IG10a19vdmxfYWRhcHRvcl9nZXRfbnVtX2Zvcm1hdHMsDQo+ICB9
Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IG10a19kZHBfY29tcF9zdGVtW01U
S19ERFBfQ09NUF9UWVBFX01BWF0gPQ0KPiB7DQo=
