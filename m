Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3FC63A1BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiK1HBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiK1HA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:00:59 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA26263
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 23:00:56 -0800 (PST)
X-UUID: a1ad12c8c0ca469eb362deae3a2f738f-20221128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6D1mUzaxP0QwqL+ByQM1WUT+FsSZ6OuGyyFL/63soR4=;
        b=nRboxZPJ8nq4Z9INZ99KxfYu+K12YwwpmjmlTL+keyQG+5TBTgQr+eLDwpIB8qrwqpwcD5367LTGrohnaNgoIfVREpt5HPKqo3OJELriijSb4Sph4tb/OpC+4BOB1Whme9djG0UH7COX/MbCp2ydmKlgKlk1rja+MOMcbhEmDjE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:b32e51b6-0b1e-4042-b132-36d9e32b8dfb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:b32e51b6-0b1e-4042-b132-36d9e32b8dfb,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:3be7ff2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:2211281500549LIAWSQA,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a1ad12c8c0ca469eb362deae3a2f738f-20221128
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 573274809; Mon, 28 Nov 2022 15:00:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 28 Nov 2022 15:00:53 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 28 Nov 2022 15:00:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of4MGdB/1oYGDrgx7CIucNprm47Sf8QCh+bi3jQpL1tKpvdrYXpr8F55ouMCMr/kipZOvDhaT5IflUWfzy8rMnjhGMOvlajhOJ0vZV00XSWrisKB8bLd7EwryE1CbFXqWiooYVjG2jbkT7dyJbccP0FLWjolFy+0y4KOOUrq6rlU6UdXYc7Yw/4TWm20X+SFqbHMIYx3RkxycqZBrD06jYe9dIkCPHRycpsOu+qntGhSC6LTpBRW99BA0TuAWne2BBEPUzXeH9ZFwB0012DZPJwFbMqEgxMcHuxIgynqhZ+i7gLXAtSHQ2nxol76cRiCdl195qaF0uHMmyBrdQrhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6D1mUzaxP0QwqL+ByQM1WUT+FsSZ6OuGyyFL/63soR4=;
 b=IXqveTByJ/Gaw0MIztpKzizEoezhKXAF555LcGxf6lx7d6isZm70G9uqZWwDReNNxDL6HIrcE7tNrreMzfF86dZxDDVBxHAi2fe+4xxuPT4CwxHwYysSjiSGyL+x90ythewbk0i2n/QF5WkyrTFnVomYOGgR7leaDxPHYzpFT80Inpm14ec7uOSJa6YVUWyr45v5vUSLpsZXL+wlOlna0FAMwSvjiYT3jnF9m2jDifkWPT3b1n6iWly3lyF88KyDK9tAm6vWFjdrKdq5IFBO/ypjvundhA7Mg3dGKFM6py6/JnGrZaz0cg60RkNy2OXfV1iwHCpnbTIaWxbk6zMnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6D1mUzaxP0QwqL+ByQM1WUT+FsSZ6OuGyyFL/63soR4=;
 b=j9vkUdCqwCVHqC6DnqIiIskkVnDZv5T6QwAUk09Lh+sVV89Xm24NYGigjEnODdzN73+/S+bbl6pOQkZoW5dau3+36lU6Of3Co1p+VEO+0cgsDpPUmET739oDcpoXouoXoVII8vEZXx67lblUWgJdfO7fNbR43W9hluR90z5j6OM=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by PUZPR03MB6855.apcprd03.prod.outlook.com (2603:1096:301:e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 07:00:51 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696%5]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 07:00:50 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        =?utf-8?B?VGlhbnBpbmcgRmFuZyAo5pa55aSp5bmzKQ==?= 
        <Tianping.Fang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v4 2/3] phy: core: add debugfs root
Thread-Topic: [PATCH v4 2/3] phy: core: add debugfs root
Thread-Index: AQHY9QgpVRJM2vxsIUeK39IN/xwo7q5ObUSAgAWW9oA=
Date:   Mon, 28 Nov 2022 07:00:50 +0000
Message-ID: <0326f3314c47853876c0a7e3a2cd32c5a4f21427.camel@mediatek.com>
References: <20221110132716.12294-1-chunfeng.yun@mediatek.com>
         <20221110132716.12294-2-chunfeng.yun@mediatek.com>
         <Y3+sQewHEpCU0xu9@matsya>
In-Reply-To: <Y3+sQewHEpCU0xu9@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|PUZPR03MB6855:EE_
x-ms-office365-filtering-correlation-id: 1910a596-d14b-4557-a5bb-08dad10e4887
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SvFPiLozxkGuL6/xaNtjcSFXwB3z/ZyDo2CORTUQP9MODxJNa1JQmNXNi+HUR8VdWylDD7oMH3t9VTyz3P3sJAH+1LE8EEhgzC6+SVBaamrhEOYruSO5jUIIZ8eRE5O0u4YhKLbWyaD0M1QKTg/nUY5yQ3TDifKc71Eoyw9BB596R9fHkI8AQQTetP7ic9kKVDzOIK0QsNxByz7pA5Z6iwx8ytC65A0xKq/TuMXhw5/eBCsLJqAU9rIz26Zhc6qeKtzhIkKlHwc1nSVSFxKBvLE65IUKIAgzSm6rvIJ3mUo8OO6CA2PqXKZwTobyVUgF3WwRDg5BVyXh2NwcQJ985G4sTruL8Jwp8SAaZ8H7rczWL6tapFdD3OQ5mQgKQ27W7Z7HL5XpZOoXq81Imp05Bd5rRZeJ8cs7M3OxYJcByF5Ym2q5aC9vp4mNZ5ZSzqgTL/67w1cSx/fZMq8B/U/UyrcKyCVFZ4NkGtb6YgBRG3b2Kn+XcIu+4dgxaUSWN0iaz/RXi5gN9qgVX/11R7mJh+0tVCs3R36FFzwtr39vb9969Ik9QGWxduY8F96TdAB19dGuU3UcS6inao3Gdvq3MzmIyhnMBddceguu02B2O7oufxlpCxJbDJqkGqg9MDJzVA3R3xJa8RI27U7vMO2HMQ5cV/G5LCCFZL/9d6uCWUixHPThFHXbt20qkBSbQ/++PHeAAHaC4zTczYzIx+wHrMm+t+Tuq7gr0aY536Fbag7gGUwI3+l3I+ZmYduyTFYzZrFMcj4xTOgE20phVQFWfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(8936002)(71200400001)(5660300002)(76116006)(91956017)(66446008)(4326008)(66946007)(64756008)(8676002)(66556008)(36756003)(85182001)(6916009)(186003)(66476007)(54906003)(41300700001)(316002)(122000001)(38070700005)(38100700002)(478600001)(6486002)(26005)(86362001)(6512007)(2616005)(53546011)(6506007)(7416002)(2906002)(4001150100001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXBCS0hBaEZmR0c3aG55a1p6cEJsdzFFeHR5ZGd0TjhQRTFjWnBKaCs1bWV1?=
 =?utf-8?B?M09RcG1ucm5SUXhkanh1SUxXUXREcFJ4VGRoQWFpM2dGYzZoSjhES0lQeGM0?=
 =?utf-8?B?V2xnYVZxaWwxVzYvVDM1RFhqcWd5NjIyd2FMdU5BY1hwcjM1L3c1VUNpS1d4?=
 =?utf-8?B?a01ER2tFYmdOY0JrUk1vSHJNbW9mSG1FNnhzdmdwbHQxVmptOHJXNHYvWmV2?=
 =?utf-8?B?djNQSDhFR09PWlZhRThqbE52Rk1PWTFRVDdTTjdOdGVQREY2R1BYWE1pS21L?=
 =?utf-8?B?clR3OHA0SGgwUVNWazlSUlBDU2dZRjdMaThPbUhBMUwraWw3WEpIdzB0Q3V1?=
 =?utf-8?B?RElidko0T3lhemhoREs1eFh6cWtkWG15ZDl1cFVxM3RIUHZURGdFNE9KbWRn?=
 =?utf-8?B?cGVhek9FRCtkWnpYOTcvNlE4MnRqbWUrZmY0WUZyWU0rZXM2K2lleTBhR1Mv?=
 =?utf-8?B?OVVKZkwrMTdOcFJpTm5KQW5kdFRTcFZyU3lob2ZxdmVRVzA5RkxJUTdja3lD?=
 =?utf-8?B?Mmd5K25xSHo3Y0hoOVN3Zjc4dXpxWUJScTFFUFhmMUlDNy9HMnJkaWhmTE9P?=
 =?utf-8?B?Ym1odnJJRUtvd0ZhRC91VEdHd2Y0OFBBVXRTaytiZzlPWVRIb2VwZjg4bGdX?=
 =?utf-8?B?bTAxcldDS0lUK0l2MVFoY2x6NmZWbVJOV3lpVEVkTW5HaEc4UWRGTUdsZW91?=
 =?utf-8?B?eWh3djhUUXBrbjY4VnhZc3JxUWNHTXhkK2x3Vm9ZMTlsMXl3RFk5bm13bEs1?=
 =?utf-8?B?ZVZ3ZGNML1dNRmE3bVNmTnptZUVpblNCYUF1MmdsNWZsb1NCOUFKNytFbWpE?=
 =?utf-8?B?SEcwOWV3TmJ6cFNOcTVLYXphaStDd3hKc2p5empMam9Mb09YL3AyQXphcWhK?=
 =?utf-8?B?OGY3UVJMNERvVklHa2RDU0R0UkRDR2d2TzB5ZzJUK2dha3llem9tUXIxV1E5?=
 =?utf-8?B?aU5IVytQMjVMUVFPMnJlaFl1WFFuRWV2dStGSm5aMjl3elNpR0JtSzY3SUUz?=
 =?utf-8?B?cm02c1kwcVVFWnF0dUtYcTlkeGFnS1JPL0tsRm52dUpuN3lEeWF2QWdPRkZV?=
 =?utf-8?B?ZXh1N2s4RjJQMTNCbnBoMDVodWs4cGJXWlJUa3pXU3hKTmF4ZStzMHl5SE9U?=
 =?utf-8?B?cWp1b1M3cmNBeUtrSGpQVVpuRUpSZGdJYUhtUThpSHRscXdaTzhWemlMM09i?=
 =?utf-8?B?ZHdaQkJwSUlqeVdQUWtYRERzaXVKV2Q2dlFsY1BJZm8zZnFEQUZpcXA2M2Rj?=
 =?utf-8?B?WTVDL0VXcmJ2alp0amxwQmRucUsyR3Vsb0VERHlQZENNbHlxSENxdHBndGRF?=
 =?utf-8?B?SzdsWk1rSTBESjVQNnVNaHVjYWpmTzNDR01kMk1Ebk1qUVU3L2xmS0hHRGRy?=
 =?utf-8?B?cjMxUEVlR05ERTFRTGgzb21iditLeUI0dXdaUkE1QkNUNnd1UytsZjUrL3p6?=
 =?utf-8?B?Y3B6TEdUaUJISWp3bU1iMmxXQXhmUjhkbWtJbFg2SmU2YmpZVWh1TzM0em9W?=
 =?utf-8?B?a1FDbjFtRk5oZDZ2YXZHdFppODA4WXFhaExFTThsWEtUZzlUcUFTOGJUZ0FY?=
 =?utf-8?B?dFREN0Rqb01qZGNtS1BNTFB1ZkRMSUtZUElUbnZGemtDUTRQR1JQdWRDWU8r?=
 =?utf-8?B?a01ObTlPRnBoOStrdGFLblZ4RHpXL0ZXc2ExeDJzM1RHTjU2RUtFTVR1MUw4?=
 =?utf-8?B?NklzQW1xd2dSVi9GQ1hlQUJrbklUYTN6WHRiY3gxbUZObHpldnlKZXVxdWlP?=
 =?utf-8?B?dGlDSFVtaHdnSFI4Y0swbzNWUmw5ckR1ZGdNRDh5NlFnTE13cHJ1cFZHcVVD?=
 =?utf-8?B?am1oVUZBbTZkUytEM0ZVVkpyRjhhbHRoUTBUN2pSZFZKNlIrS1RRa3RubGF2?=
 =?utf-8?B?L1V1WDFWMlM5UjFPM2dhallDbTJGR0tFKy9RTWprcWRFZm8zMDlJOUovZlJ5?=
 =?utf-8?B?cVJ6aHY0dkFZa1E4R0ErUU9jRVNsUHBlSmI4MEVzRFdML0VNemVEOGh0RHRR?=
 =?utf-8?B?VEtWSmpZdDhLeSsrL2FvcVprOUxCRnEwWnRseHRncTBHOHVGUE1GNVZSVGxJ?=
 =?utf-8?B?bXU1QVl3VlNzOVhMdHdnMnJuOWJWblphOUhQaVRlalE2bFFXNTlQYlhIWXVT?=
 =?utf-8?B?blBQeFFDN3BiVHlWTFB5V3ZGU21IY0o1TlVNSDdxZ3l3MnNNSWJJcVo3bDEx?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <191F212D591B6A48A1ED075B3BBB6E5D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1910a596-d14b-4557-a5bb-08dad10e4887
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 07:00:50.2318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTMxc/9m9rF9m84mznWQRiwkFPTOTw2k3le8fjIuUZGm8OReRNtuQ119eLNmvjzbx3kuxuQIemnYH0WiJ+2q0eWGkeNCet1UCrXObXl9hRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6855
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTI0IGF0IDIzOjA5ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBP
biAxMC0xMS0yMiwgMjE6MjcsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiBBZGQgYSBkZWJ1Z2Zz
IHJvb3QgZm9yIHBoeSBjbGFzcywgdGhlbiBwaHkgZHJpdmVycyBjYW4gYWRkIGRlYnVnZnMNCj4g
PiBmaWxlcw0KPiA+IHVuZGVyIHRoaXMgZm9sZGVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2
Mn52NDogbm8gY2hhbmdlcw0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BoeS9waHktY29yZS5jICB8
IDYgKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvcGh5L3BoeS5oIHwgMiArKw0KPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BoeS9waHktY29yZS5jIGIvZHJpdmVycy9waHkvcGh5LWNvcmUuYw0KPiA+IGluZGV4IGQ5
M2RkZjEyNjJjNS4uMmY5ZjY5MTkwNTE5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGh5L3Bo
eS1jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9waHktY29yZS5jDQo+ID4gQEAgLTExLDYg
KzExLDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2V4cG9ydC5oPg0KPiA+ICAjaW5jbHVkZSA8
bGludXgvbW9kdWxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9lcnIuaD4NCj4gPiArI2luY2x1
ZGUgPGxpbnV4L2RlYnVnZnMuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4g
PiBAQCAtMTIwNCw2ICsxMjA1LDkgQEAgdm9pZCBkZXZtX29mX3BoeV9wcm92aWRlcl91bnJlZ2lz
dGVyKHN0cnVjdA0KPiA+IGRldmljZSAqZGV2LA0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xf
R1BMKGRldm1fb2ZfcGh5X3Byb3ZpZGVyX3VucmVnaXN0ZXIpOw0KPiA+ICANCj4gPiArc3RydWN0
IGRlbnRyeSAqcGh5X2RlYnVnX3Jvb3Q7DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHBoeV9kZWJ1
Z19yb290KTsNCj4gDQo+IFdoeSBleHBvc2UgdGhpcyB0byB3aG9sZSB3b3JsZD8gQWx0ZXJuYXRl
IGFwcHJvYWNoIHdvdWxkIGJlIHRvIGFkZA0KPiB0aGlzDQo+IGluIHN0cnVjdCBwaHkNCklmIG9u
bHkgYWRkIGl0IGluIHN0cnVjdCBwaHksIG1hbnkgcGh5IGZvbGRlcnMgd2lsbCBiZSBjcmVhdGVk
IHVuZGVyDQovc3lzL2tlcm5lbC9kZWJ1Zy8sIGFuZCBjcmVhdGUgdGhlbSB1bmRlciAvc3lzL2tl
cm5lbC9kZWJ1Zy9waHkgc2VlbXMNCm1vcmUgY2xlYXJlciwgdGhpcyBhbHNvIGZvbGxvd3Mgb3Ro
ZXIgY2xhc3MsIHN1Y2ggYXMgdXNiDQoNCj4gDQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICogcGh5
X3JlbGVhc2UoKSAtIHJlbGVhc2UgdGhlIHBoeQ0KPiA+ICAgKiBAZGV2OiB0aGUgZGV2IG1lbWJl
ciB3aXRoaW4gcGh5DQo+ID4gQEAgLTEyMzMsNiArMTIzNyw4IEBAIHN0YXRpYyBpbnQgX19pbml0
IHBoeV9jb3JlX2luaXQodm9pZCkNCj4gPiAgDQo+ID4gIAlwaHlfY2xhc3MtPmRldl9yZWxlYXNl
ID0gcGh5X3JlbGVhc2U7DQo+ID4gIA0KPiA+ICsJcGh5X2RlYnVnX3Jvb3QgPSBkZWJ1Z2ZzX2Ny
ZWF0ZV9kaXIoInBoeSIsIE5VTEwpOw0KPiA+ICsNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+
ID4gIGRldmljZV9pbml0Y2FsbChwaHlfY29yZV9pbml0KTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9waHkvcGh5LmggYi9pbmNsdWRlL2xpbnV4L3BoeS9waHkuaA0KPiA+IGluZGV4
IGIxNDEzNzU3ZmNjMy4uYzM5ODc0OWQ0OWI5IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvcGh5L3BoeS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9waHkvcGh5LmgNCj4gPiBAQCAt
MjA1LDYgKzIwNSw4IEBAIHN0cnVjdCBwaHlfbG9va3VwIHsNCj4gPiAgI2RlZmluZSBkZXZtX29m
X3BoeV9wcm92aWRlcl9yZWdpc3Rlcl9mdWxsKGRldiwgY2hpbGRyZW4sIHhsYXRlKSBcDQo+ID4g
IAlfX2Rldm1fb2ZfcGh5X3Byb3ZpZGVyX3JlZ2lzdGVyKGRldiwgY2hpbGRyZW4sIFRISVNfTU9E
VUxFLA0KPiA+IHhsYXRlKQ0KPiA+ICANCj4gPiArZXh0ZXJuIHN0cnVjdCBkZW50cnkgKnBoeV9k
ZWJ1Z19yb290Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGlubGluZSB2b2lkIHBoeV9zZXRfZHJ2ZGF0
YShzdHJ1Y3QgcGh5ICpwaHksIHZvaWQgKmRhdGEpDQo+ID4gIHsNCj4gPiAgCWRldl9zZXRfZHJ2
ZGF0YSgmcGh5LT5kZXYsIGRhdGEpOw0KPiA+IC0tIA0KPiA+IDIuMTguMA0KPiANCj4gDQo=
