Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE336DA889
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 07:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjDGFfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 01:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDGFfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 01:35:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAFC7EE1;
        Thu,  6 Apr 2023 22:35:08 -0700 (PDT)
X-UUID: f1e1bb92d50511eda9a90f0bb45854f4-20230407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NKdYTCnWFLSmGCDJe9LIn7LaPomCg2/9iFxIYGZ7ZK0=;
        b=k48nU66PRTWg09u0A8lw4ImSnAD4UBnARJe/eQ6Zzx1h3HyMAVNTa6UqaEyYKU0ZBSG9l5T4y22Px965RycaNbrkOgPaYMXg/JVoLUMO3g1ZIY3sjietyVxgNDwVVD5ehvlWQvRBzf9A0xDKcuYT1/QHmJGXbNZeIy5cNZyVyNU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:54866c55-7e2c-4493-912b-79a574a0fec1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:bf539a2a-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: f1e1bb92d50511eda9a90f0bb45854f4-20230407
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1759425723; Fri, 07 Apr 2023 13:35:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 7 Apr 2023 13:35:01 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 7 Apr 2023 13:35:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2Pga9wkjc+zAN2j6eBBrrMcExHCiQ8Gfy1fBXSNdiJVOcMVXvyu747vKqszrqW/cNxdmZoBjrKwgpJaOewA0R1vRMBOrmzRIwLDZZl6MDTc36AJ9amljNQvgBRfUKabq6U9tcSMe3I9jGbmHwKVlI36+7HHX8udlZ/2HeI/ZRNkXGpZCMSo6iiptN86AvEHZEuKYcCUnxKlSPmRKgIlj/sPyQGsUmRgSJWrAIhs/D5TwqFEjktC2PMLtu0NeL6mm7jOXx1G83emxkFcEZnjKrck4TBg+DG0f6LyhGOYWpheQzprBXq6iFt1rPBfzfGmCs15LXNI1gufyTnZSIKuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKdYTCnWFLSmGCDJe9LIn7LaPomCg2/9iFxIYGZ7ZK0=;
 b=DdpmWZ+5y7GZBPruoRup/EBuq4GY3ydDHUMTPqC1tsTXL1iVaY9TkLqvQFhYc2E3tcbneBacJYY5GmDmd93SmnfY2jDuUnDrrYk3Z0R08dpbu5kf4yrx9kMJsinrk7il6varP41OkIUwVNbMsI2/XwzgJczRJC3i40PTgXkYW0pGZVq8HLPRV3vf+hs8cptbQPt+GLMsLhQPKvlzYhJNz/kiCM8HDQFBl4HuhH6PJKHM2ITwko7wzFajA6D/pNSXOZjMcO3RUTWwhhJWOVwXyEU5/JFlIBQOONc0h53RrNzVtFQ8+7LE/P9jIxrUPWZHwOsFIxYoMKECmBDIUJ6SOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKdYTCnWFLSmGCDJe9LIn7LaPomCg2/9iFxIYGZ7ZK0=;
 b=C06IqJvv4UgJDoUC3DgXMksFW4IONkZCdULbwozqAw4g+6QD2BSVhIjSKFt48mixXaGHSc1MFdOpn4Aoc/RBo+Q3y2Xs2rhQ+A1VS8w3KwNjE+yju9rpuJGIUZokVRFXa/2Lmv1waN+pvp9z2EOUYtoC1CgZWJswlH+PtBPo4Do=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by TYZPR03MB5263.apcprd03.prod.outlook.com (2603:1096:405:6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Fri, 7 Apr
 2023 05:34:59 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::82b9:eab9:b4e3:8464]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::82b9:eab9:b4e3:8464%7]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 05:34:59 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        =?utf-8?B?VGlhbnBpbmcgRmFuZyAo5pa55aSp5bmzKQ==?= 
        <Tianping.Fang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: mtk-xhci: add an optional frame
 count clock
Thread-Topic: [PATCH 1/2] dt-bindings: usb: mtk-xhci: add an optional frame
 count clock
Thread-Index: AQHZZfHnqsZMRPnKDk+pyt9fQI5ZZ68Z9pUAgAVi6AA=
Date:   Fri, 7 Apr 2023 05:34:59 +0000
Message-ID: <c45f53067f79ea631d006964d36aaac2fadeea1f.camel@mediatek.com>
References: <20230403060232.25699-1-chunfeng.yun@mediatek.com>
         <d8f3432a-b364-e939-c1f2-b4d55b1586e9@linaro.org>
In-Reply-To: <d8f3432a-b364-e939-c1f2-b4d55b1586e9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|TYZPR03MB5263:EE_
x-ms-office365-filtering-correlation-id: efac4f94-5ccd-49e0-6ce7-08db3729d432
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gk0OGPSUGCJfm+7i4/YCKQt4aHMWofT5SsXnwhtvJKBv48G/fo9xNU6r7o0sPNGb1R0TMhZQHmNjBaNulv7AHT6MwPlqYIElWflIV9R2rh4vzO+X5mNSyxUek8lDjHXZn8l2pYfsT0VEeqrUGhYe2uZLaLdLJm7t/nPQxQFSLz8Kylb5O7y+4BRuonr+q5OBHOfqPJR2pbmrKydcxYA6A1wYBi5o4MFHTaw3AmTJOmeACAPpKjadv3zGU2y55MNU/jrgpDv+VpeT7/nftse9SMd5ShXKqV6GkNbGkeioxp4Nm4HXuPdBq26v7UIH4EGxxgWWyiirKOV+cMYGk5k3zil0kWfMw/Dr9Y5vpTa8fGiRE/oUXUi5ivPLoXbOD21aRBVBYp/CvCm68v97yc/3zk6TfhkqIVLhztVPfSA4Cbv0zdKFExkujVV/LWcs6fj+jxsmYrIv3gDpsJFAHQqV6YaOZbt/A4dF0a3FIdaqCEe4H/GvQw3My6Hau1dI+OIUnQ77Ij96ux6bJJOiuU1rOrNlwigw7PgocEXwd5ybQv5hzo95YTcFG9NHEhuvFM4tgb7CzV3ZiiCSRoiOFZkST3i+6ogZ//TEeCsgV5t19Ordo1QihkKzlWeHfY3DC4Xe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(85182001)(122000001)(38100700002)(5660300002)(7416002)(2906002)(64756008)(4326008)(76116006)(38070700005)(8936002)(86362001)(66476007)(66946007)(66446008)(8676002)(41300700001)(66556008)(6486002)(966005)(83380400001)(36756003)(2616005)(91956017)(110136005)(54906003)(53546011)(6506007)(26005)(478600001)(6512007)(186003)(71200400001)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUhENG1ITDJwaThvNXowb28zQUg1RWtFV2RVVno5K1AwNkFIWndGNENZaTR3?=
 =?utf-8?B?aW1aL3duWjNtVkREVWZxQ2ZQclJqL0RqanZpMnI5c2loNzFjekhiQ0NCTWpT?=
 =?utf-8?B?QzhyMDBuQTcrVkNvanlFcVJVSU96MGt1M3NjUXFkWXlVYlQyRStWVVRsbS9U?=
 =?utf-8?B?c2VUeXRKcVlxNHRldkMrRDRVUVZIQW5jaXBGQm5zK3JUcVpPQU5aTUlKUUU4?=
 =?utf-8?B?SWJrUm02MVk5OFZ5V1BGbHIwSUcvMWlaUTROVFVLUHRuRytiMlNLVnpNdDZS?=
 =?utf-8?B?TnpmQnR4bEVITTB0VlR6aEVUWVhNVW16dC9qbDRrUmxHem5yZEFDV3RCdXhZ?=
 =?utf-8?B?alVxOURUUDZKRE1RdHRMZFZ1dVUySjQ1Z1FqMjQ4aSttdGNrd1pJYUpuS2R2?=
 =?utf-8?B?MXVGeGFQVmYvWTNyL3R6eHlyZ3lYa2EvNjNwUmcrbFdkVStUVGRicWRCTUd0?=
 =?utf-8?B?WCtlT3RMQVRRR1BOcHROSjV3a1V2L0ZkRlNheUpESTdDZEdhZk9heUJYd29W?=
 =?utf-8?B?WndwdEVPY0tpMFl0WnRFWVVqV3FjNTA2cHFvYXV2NWI5OUYwRDVwZlBVV1BJ?=
 =?utf-8?B?NUh3c1pGWFhNUVd3ZkxUbW5EcW9FK0lVM05iVGE2L3M2bDUyVWdEeS9KN3dL?=
 =?utf-8?B?U3BDdXQ5cG5uQ1Y3ZXlxU1VESW0vZzFqYWtxU3prV3h4dHoyVytVa29YVGlC?=
 =?utf-8?B?WXd5TnNNVEswR1FJN0gyTjB4RDd0MTQ1M3ZiMk41TFJnbHAzNi9PM005WVA0?=
 =?utf-8?B?NmJTc3RqWmM4bUVnUzNYaDF2ZmxrYjF0bnc5VlBMRUlNSWFzc3NPWXFab3VS?=
 =?utf-8?B?bUwwL213cEJBNWZVWWJHRk5mMnNTbU9YeGVPeVM2TDdKY2J4cE9sc255b3NN?=
 =?utf-8?B?OHVIbnlDL29ucnpPLzZvUkZsUVR0SXNyazZEdmNuMHVEc3pWdlZTY3pxRklL?=
 =?utf-8?B?cjAzNVV1QytPZGpnWHF4UFpVSDhEdTFPZmo2QWJIOWlRZUs5N0tSMU9zL001?=
 =?utf-8?B?c1AybjZCYjdyM3NuK29uUDlWaGVUMWpnYkJhUTdaZW14RVgzTlZQWkl2NVlo?=
 =?utf-8?B?M1I3dkFMUThlSHR6bjFUc0dUNHFhM0pSVno4T1Y1NU5IRThrWUZBdEMxdVox?=
 =?utf-8?B?Q09MRVBSRm85c2dxZnpVTncrdGUwNzliaVB3TWxRZ0NVTy9rZWo0TnVLeFNj?=
 =?utf-8?B?VXBjd3lxYnFxcmt1WjlVTEVDSkhXSCs1NzZaMVFoVEZKeVV4ZFBxeW8yd0Nl?=
 =?utf-8?B?ckJiaE5wRmxGN0Y1Z3lWVFg3R2ZnMnQ5M1JxOElWWHlWUXhJK1Jkb3hBaE9G?=
 =?utf-8?B?eFJjcEloZVNXSVA4amRNeVZJRFk5TXMvWVhva3dXL0w5TklvTHJ1QUU0NVdk?=
 =?utf-8?B?OFlUSzYvMFNic05zWERDd1prNjdOeG5JZmJYbi8rMnZjbTVZZVY0NzNvM09X?=
 =?utf-8?B?OHVHV2lhR0tKL3FrWktsWEJJbVRuOU5rRkJveW9oMWpxM3Nsb0J6djBKdkRE?=
 =?utf-8?B?TDVKUG1Va3d0TEw3NjRxTzFvalJPWlpRVDlQUGdVSW5yU1JZbUhaVElDZTR4?=
 =?utf-8?B?UTdhYmljelBMSXVtWHZlakk5dlhZME5Ic2tTT0QzQmtTTXpGYm5DN3BIOUF4?=
 =?utf-8?B?QVdKa3IwTkh2YlpHVEJNN0ErQmFTYnVjdzBtY3cwRXhKNnZobFY0V1BGTHdU?=
 =?utf-8?B?eldWbVFMMmhWZEVobXlERlpNU3ZHY3VLeW9hNTA5OEt2ZlJKVDlRNkRJUldX?=
 =?utf-8?B?NHA2TnJOUnZzbkRDOG5CMmx3QjZYRmlyRmwrS2QxdmlLTndSZW0rM0FQaHFh?=
 =?utf-8?B?ME5oUlNKTDlrM2JaRmhBQXI1VDdKMTA0YUxXRmZ6dS9Mdm5RNFFFa01LRWNP?=
 =?utf-8?B?Y2gyWWxBeGltSEM5eWMxQUV6WU1rSXlvWGh3RjIzcjYzSkF2bTNJTWYvQ1pE?=
 =?utf-8?B?OVl4QzVFdWZzeFFjRVZvMmFMQnpGOUlCOWdCSDNQUWlSRzNBeVI0dWV2OHNX?=
 =?utf-8?B?OElaZm5JM3hrTnozNms0a2VueG9iblJJYXJCZFhYaE5JOU5nNTVLWjBKWHND?=
 =?utf-8?B?aWVwM3RDNlc2Q0hNVHpsSEVGaUt5dzljYjVwWEpHQktWUlZlZ29GdkZtaWdU?=
 =?utf-8?B?MDBXTnlPVHY1OWJRV25vS1FweXdSd2tJdkpUV0d6bzY0MlhoNC9tZWkvZ0hr?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C32B496800C284CB821295880B873F6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efac4f94-5ccd-49e0-6ce7-08db3729d432
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 05:34:59.5812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FI7DnZpIbK21KaCSK4Z17JYs9m53HcNt69YfSBWQ5eIlBWaJSaJkQojOyJBUKhuhwchB3Xg+B2uOC7mY9qSsZlRUulSZTMiGDg649gTGl7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5263
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDIxOjE5ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDAzLzA0LzIwMjMgMDg6MDIsIENodW5mZW5nIFl1biB3
cm90ZToNCj4gPiBBZGQgb3B0aW9uYWwgY2xvY2sgJ2ZybWNudF9jaycgdXNlZCBvbiA0bm0gb3Ig
YWR2YW5jZWQgcHJvY2VzcyBTb0MNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZ
dW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sICAgICAgICAgIHwgNg0KPiA+
ICsrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdXNiL21lZGlhdGVrLG10ay0NCj4gPiB4aGNpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay0NCj4gPiB4aGNpLnlhbWwNCj4gPiBp
bmRleCBjMTE5Y2FhOWFkMTYuLmVlODE2N2ZiYzU0MSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwNCj4g
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10
ay14aGNpLnlhbWwNCj4gPiBAQCAtNzcsNiArNzcsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAg
ICAtIGRlc2NyaXB0aW9uOiBNY3UgYnVzIGNsb2NrIGZvciByZWdpc3RlciBhY2Nlc3MNCj4gPiAg
ICAgICAgLSBkZXNjcmlwdGlvbjogRE1BIGJ1cyBjbG9jayBmb3IgZGF0YSB0cmFuc2Zlcg0KPiA+
ICAgICAgICAtIGRlc2NyaXB0aW9uOiBjb250cm9sbGVyIGNsb2NrDQo+ID4gKyAgICAgIC0gZGVz
Y3JpcHRpb246IGZyYW1lIGNvdW50IGNsb2NrDQo+ID4gDQo+ID4gICAgY2xvY2stbmFtZXM6DQo+
ID4gICAgICBtaW5JdGVtczogMQ0KPiA+IEBAIC04NiwxNCArODcsMTUgQEAgcHJvcGVydGllczoN
Cj4gPiAgICAgICAgLSBjb25zdDogbWN1X2NrDQo+ID4gICAgICAgIC0gY29uc3Q6IGRtYV9jaw0K
PiA+ICAgICAgICAtIGNvbnN0OiB4aGNpX2NrDQo+ID4gKyAgICAgIC0gY29uc3Q6IGZybWNudF9j
aw0KPiANCj4gDQo+IEFja2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296
bG93c2tpQGxpbmFyby5vcmc+DQo+IA0KPiA+IA0KPiA+ICAgIGFzc2lnbmVkLWNsb2NrczoNCj4g
PiAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gLSAgICBtYXhJdGVtczogNQ0KPiA+ICsgICAgbWF4SXRl
bXM6IDYNCj4gDQo+IEJ1dCB0aGVzZSBzaG91bGQgYmUgZHJvcHBlZDoNCj4gDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1kZXZpY2V0cmVlLzIwMjMwNDAzMTkxODUwLjM3NDgzOS0xLWty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZy9ULyN0DQo+IA0KT2ssIEknbGwgZHJvcCBhc3Np
Z25lZC1jbG9ja3MgY2hhbmdlLCB0aGFua3MNCg0KPiA+IA0KPiA+ICAgIGFzc2lnbmVkLWNsb2Nr
LXBhcmVudHM6DQo+ID4gICAgICBtaW5JdGVtczogMQ0KPiA+IC0gICAgbWF4SXRlbXM6IDUNCj4g
PiArICAgIG1heEl0ZW1zOiA2DQo+ID4gDQo+ID4gICAgcGh5czoNCj4gPiAgICAgIGRlc2NyaXB0
aW9uOg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=
