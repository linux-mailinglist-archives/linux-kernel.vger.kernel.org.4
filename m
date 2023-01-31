Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455C068282A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjAaJFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjAaJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:05:10 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEED25FD0;
        Tue, 31 Jan 2023 01:01:41 -0800 (PST)
X-UUID: caa9a5eca14511ed945fc101203acc17-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=1prR7XYzEF/NEfU7UMlN8n8Cs+QhztG/5eBgNoMS/LU=;
        b=uIU4u4vtcSfZ8ZqzlZ/usooxdqezH2OEinFOlCSpNlGoDft0LmIafDBm3gqQo+2nW5utamOauDouiXl3NxZA8Xs3ggpp5nRx8ocGBC9EfmRdjxrhG1a/Zk6JkzCwL79FJEEApxEyR2yt6dcYNtPfUv9bAH3h5w0s5UeRSD7JM30=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:6bfe1f28-5646-4036-aba8-6165503c0ad1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:ea1a748d-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: caa9a5eca14511ed945fc101203acc17-20230131
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1852354152; Tue, 31 Jan 2023 17:01:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 31 Jan 2023 17:01:03 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 17:01:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irDaS+WGHbhNgt1YIdFT1Fd87l6PwfJDneEJvbchhw9K0Qp99WGHsmMR1VpZOSUWN/yYlo8dOOqp2eqf/5v4GnztlWH150jfax6xa4jb2i0lVCbgs2spcX0JuqgLo2khPdH6dOv9C9KEKRAmd4pJtPJIYaLMM3uz0yJ/lhXDlkon3qu8oKU6MaYvzlQBrrC4oGOyrlr7bghcZKqI6GM2aZuyic1B9hc7rYrtWDbH6+2jpk2XkqW2pI8UD4YHFhV4+zBzBSmO4ytdrWcGzljawSHSExRh2Ny7eAyEN1J2yXYTm2W/aMgSG7gQq/Aj8s0icAPqVheuiGbDv5CHSQXqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1prR7XYzEF/NEfU7UMlN8n8Cs+QhztG/5eBgNoMS/LU=;
 b=e70SBV/yzFX3rSDYv/6JlNS+SARukjYYU7VvXV4GaRbiNE/fLfZ3XOSodKILHQcMxBDNev/yDsLl9Zj36W9THZBv8W86bMCm6s5+9dCW/7huDuRb+fGcEbDWVZnFWlf+UZu9UMcWrZosdacZQFz2j5wxJcPvTJrbPSb33wEAllCGhygfZDkc2JN69ONrv64hXemAteaKZd6QdAffP1B/dTpgf86sv4Dfu4REEOoeqfVI/4m+KAQzvleuL7N1hFgRzME1LVaDOmk1KdDtemriSV1/F74COLeEU4y7BaH4jrRmRaNXkbzEWMdVk3iMjzoQxinvkVGl9pWPCKX478i1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1prR7XYzEF/NEfU7UMlN8n8Cs+QhztG/5eBgNoMS/LU=;
 b=kwEQgBBTe2FHJnRFNaeMgywUNBUtdRgmsjgYXVa+RuiVOVXnBXGbXuFTrFUC9+ZOE6NVfm/Vxyw2qSIf84/1JzbqYB8Zebtg9Uz85fnsjy+yxGECAo8pFj8320bYrlZ9BeRWTMQ0fB8eiV4lNTl7SdXDwcr6/xPgcJGyiqHS7nw=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by PUZPR03MB6132.apcprd03.prod.outlook.com (2603:1096:301:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Tue, 31 Jan
 2023 09:00:56 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1%3]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 09:00:56 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?WmhpeW9uZyBUYW8gKOmZtuW/l+WLhyk=?= 
        <Zhiyong.Tao@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bero@baylibre.com" <bero@baylibre.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v9 5/9] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC
 bindings
Thread-Topic: [PATCH v9 5/9] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC
 bindings
Thread-Index: AQHZMMpdVMDm7JVLGkecOU2Fb+Czca64Q3iA
Date:   Tue, 31 Jan 2023 09:00:56 +0000
Message-ID: <b246cfe16c9d0938ffd82f5235429788aa19c7a7.camel@mediatek.com>
References: <20230125143503.1015424-1-bero@baylibre.com>
         <20230125143503.1015424-6-bero@baylibre.com>
In-Reply-To: <20230125143503.1015424-6-bero@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|PUZPR03MB6132:EE_
x-ms-office365-filtering-correlation-id: 6e233220-b344-4930-ff1b-08db0369aa0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZd2XEH6pLDVcXRqzPKFd5E/y1MJlxUpkEH5ChWsSXIQWKfs8+Ph5iKuIVh7/eo1+xtrlEEFmuNAkHQwHNQER5I4c9Re2F22ci4e1W70dQ2TOB6oFVWJybMxhXMzDE0YqiKW+zmWCxPEjzgO1gVYcEG4+mcb6CAVDZVfYiJ58Ytxx87KgzE3/UJWGBRkdh2SLCMwvlIP/RgbgPrT2jUyYGXZmBbGmN9FRpQ/XEh81OA2YBNcXv0/RIA1x2hVmkccSDyZRFEERlEWnYIkwF0hfC5PuRzPmXKcepqglUvaWz2vegrEZ+tr37kf2jtyBd9mOVOxBZAsLoJOnSVf3aVUun7Y4ITaWh17RYUI04ZFjD46t7gbL/zvhp/PHV6qaZCq/rsEUqcUi9ldiIJirsgmCcVf31HQhf2S6hmyyP5ywutGT6b7ndeIuJHupXDQ4vTp+pP8KMWYGq7zjhyv7t2vxssz+P5Ph44TnVEDKCZBdyw+tW8LO1o9JKkNMOsPJ2stv0rqr0mnNnemdzbPyxxkyZKsqNFFv4ep02BHc1G1n5fhDzZ2AcEK060NGF/fMDLW2h3/NXPeYrkN9Zwxu/bc/BZjK25MS7BDODYXLL4VM/d6exHxqidCgrgEyE/PeM42Hm5rb/3gpsJ2Ym3bhcmM99MMW4fqBj5eSpdFo0ChuvXljIA9CHqlcS8XBxCDNx7WTKWypGcf1Nl0I09sMt7fFCeWF0hxmzQUJIKN/FUeGZNKzbHpRBRysrRowLOLsH2D1YGRrjT/ag6aTLxeNz0fC2JFryOogDXxAMDtfxtcw34=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199018)(2906002)(5660300002)(2616005)(41300700001)(8936002)(4744005)(8676002)(7416002)(85182001)(478600001)(26005)(186003)(6506007)(6512007)(316002)(38100700002)(921005)(38070700005)(86362001)(6486002)(91956017)(71200400001)(66476007)(76116006)(66446008)(64756008)(66946007)(122000001)(110136005)(36756003)(66556008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGdaMjRqWEh5RXFzTlROWk0rQWpwTFA3OTNNMU9rZG1FRUE4L3dKMGdmM2gv?=
 =?utf-8?B?OEVqUDFwQXloL1hweXVHVEZDanRiNjdpVk1SellSa1lFNmpCZFhoMnJlTUhQ?=
 =?utf-8?B?dXF1YTVQRHJDTmdrRnVaMkp3bmFvNXNDdGJRU0I3aXoyOGZsMXk5OHNBWjFM?=
 =?utf-8?B?Z1Q1UTBoRnQyaG4rUTQvbXlHRWtyRmxldVhvK3NFNjNKeFpSN2k0d3VtUmNH?=
 =?utf-8?B?NVdnVFJuZWZ0cWRMY0ovLzVia2tueXVsN3R1aDlzSTZSaTAydTNVeERBb0hG?=
 =?utf-8?B?QzVUR1NTRVg5UnlmMkpFdTRQeEI4QlpXSWxMeWw1YXVicjNQM1ZqZWxTcFo3?=
 =?utf-8?B?UXNJS1NtZ0dhQ2t2ZVpqa1pDTkp1NGNxNHJqVFBwK3VsVXZ4eFdna0o2c0Rs?=
 =?utf-8?B?UXFrK3ZkSkhzcjA3SysvSUEzSyt6NTVEQVBKU29pMzd3WkkyRVFNc0xQSGkr?=
 =?utf-8?B?bmxxLytLRGVMWGpWUzhEK3ljeEhyZnVKNWNDelJzTDQrTHFaeklGcmpNRTJ1?=
 =?utf-8?B?cFdaY1BlZ2VITmhLRnQ4NkRSeFE5Y2ZKYit0L2FlcnNDbUV2UlFwYnRRU0Yy?=
 =?utf-8?B?ZWx3aEhKUVEzRkxlN3dTb0gxUEtLYlVoV2t2UXBOUG5yZWp6OUhHc0tPbWhi?=
 =?utf-8?B?blNYRm5tTHJ3THBXTW5BL05udTRNaHpxZWNTNjJJN1ZSOTZhL3k4TXhpdHhD?=
 =?utf-8?B?M2JadThEdXZlV3FuSzgveHFNamJFUWVXaC92RmRHRkNMS1gyOVo4bDlrRWR3?=
 =?utf-8?B?N2VIeHhRZTRqMVNVZXUwcnNTTEdjMG1lY1huU1FyeWxnNHdDbjNaZGNCdUdj?=
 =?utf-8?B?Y0VHZjA0SUZNNXVYVGc1ZERtMDRKaXJScDJpQnRYaEJUN0lWWm1OQ2ZscG5k?=
 =?utf-8?B?QnNSb1ZRSWo3RXdyUndtelVoMCtTVzAzaG83bGV4aERqUlZFTWt6bEdaZXNH?=
 =?utf-8?B?dTlWSFVJU2VwQUw3TnQzSlpvRXM4MmNCUmxMdklqNVhrb2hiMjRnUUxHVGN3?=
 =?utf-8?B?MzZyR1hhK3M1NmU0c2JhWi9WU0FUY0NkVEhDekxObHpIaFJsVDRSaXVEU21T?=
 =?utf-8?B?WUk5bi90TVpWRHp6MGdLN1kyd2xMa1IrWHA1QUVYM1pBL0syNUR1Y00zbVNM?=
 =?utf-8?B?UzYzZjVSOVpPR2lENlBkajhSSUVYbGhEK1VDckREMnNlNWJLakJOMHQrUnkv?=
 =?utf-8?B?eXU1VE9zUWJwckR0SG5QS2JWRERTNGhEaDdLbW0yVGJkSjdMMGdjb3NuVW0v?=
 =?utf-8?B?UXlpeGNLck9KcDRUKyttMGFpQm9xVFhkN1lWdm5UcTllZ09abVZ4cSt4aStk?=
 =?utf-8?B?VjI5ODg1VDZlSi9pMWNBWGJyMXRsVDdwN0w2KzhLMnU2dmNwcC9vTDVNY2po?=
 =?utf-8?B?OFhObFdjQ1d1amxWc0JJM2hwM2N5bXk5U3JCdGExc1FKUjUwaVZZNTJWbWFt?=
 =?utf-8?B?dVNDZzVZSEVEc3hyWDAvd1NKWGowaU9ZazZoWW4zK3pDbzlON3VHL084bzlO?=
 =?utf-8?B?VnlZaXVTK0ZzbGhHT1pLVDBzM2pMSFRGZi9OTWI0UGg4VmFSQVVlblczNmh5?=
 =?utf-8?B?aWx0Ris5dUZZaEpQTTBKTEl4NEI5bWh5cDhkOWhjTU10K1Q1UmhlWWtMMm12?=
 =?utf-8?B?OU0zTjdIU0RUNFRCOGJBbkcwVERkZ0lYalMyc2JmaGZpVFBNSXh2YXJnQW1G?=
 =?utf-8?B?MlJuYUJIbExsVEdXZ3hYcGdkL1dZT3Jra3VuRnFydmJlcnpMeXBGL3I0TDFh?=
 =?utf-8?B?d0VPcWxHOC8rd1BFT1l3Y3lnZk9UMVBlWUVSaWpURDk3dW1EbE5ZSlR5RHor?=
 =?utf-8?B?UXE5NTJTNThrNVRZbDZ5Zk9yd1dxdkU5OXhDa0F1KzFCbXowdHMxSGhONVBT?=
 =?utf-8?B?RTNZTzA3Z29NOGVxS2pxc1Q4S3JnOVB0dnp3VENMb2UwY0xvb1lYdWlFMDda?=
 =?utf-8?B?ZXNERkgyQzdTM0o4SnJpQ3NwakczUXVyWlQ5VEZNcktkQmZTV1pERTNWR2xR?=
 =?utf-8?B?aXp0bmpIRkpsZ3lXUjQwcGlKR01NYU5KZHJHRTJKdHoyZDBaRmpGMHBWSzJx?=
 =?utf-8?B?aVpCeGFsWU12UWtvTVFRV1lxcXpzNmRSdmRjQjlOTG96MzdCc2RGMkVWWnRp?=
 =?utf-8?B?QkxNNFk0ZHlkcTVWeDk3Vk1jdWYwR2MzZC9IZlNBdjN5M0c4ZUxDS25QV3Rt?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1B4619221710741A234752F34A62EC5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e233220-b344-4930-ff1b-08db0369aa0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 09:00:56.2212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBPfHbaos1N1GUcDVuzOszH3bdbizCac7QrhYQgIv+D+1//JKKKg2inf8Bb4ulbU7RDI9aMxOBXp9v3xCp2yXw8411EPNRdF11BLzTLBY/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6132
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

T24gV2VkLCAyMDIzLTAxLTI1IGF0IDE1OjM0ICswMTAwLCBCZXJuaGFyZCBSb3Nlbmtyw6RuemVy
IHdyb3RlOg0KPiBGcm9tOiBGYWJpZW4gUGFyZW50IDxmcGFyZW50QGJheWxpYnJlLmNvbT4NCj4g
DQo+IEFkZCBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIHRoZSBNVDgzNjUgU29DLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRmFiaWVuIFBhcmVudCA8ZnBhcmVudEBiYXlsaWJyZS5jb20+DQo+IEFj
a2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5v
cmc+DQo+IFNpZ25lZC1vZmYtYnk6IEJlcm5oYXJkIFJvc2Vua3LDpG56ZXIgPGJlcm9AYmF5bGli
cmUuY29tPg0KPiBSZXZpZXdlZC1ieTogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdt
YWlsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4g
YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXR1My55YW1sIHwgMSAr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbA0K
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXR1My55
YW1sDQo+IGluZGV4IDcxNjgxMTBlMmY5ZGUuLmQyNjU1MTczZTEwOGMgMTAwNjQ0DQo+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXR1My55YW1s
DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWss
bXR1My55YW1sDQo+IEBAIC0yOCw2ICsyOCw3IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICAgICAg
LSBtZWRpYXRlayxtdDgxODgtbXR1Mw0KPiAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLW10
dTMNCj4gICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS1tdHUzDQo+ICsgICAgICAgICAgLSBt
ZWRpYXRlayxtdDgzNjUtbXR1Mw0KPiAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXR1Mw0KPiAg
DQo+ICAgIHJlZzoNCg0KUmV2aWV3ZWQtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1l
ZGlhdGVrLmNvbT4NCg0KVGhhbmtzDQoNCg0K
