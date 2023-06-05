Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2117F721B91
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 03:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjFEBib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 21:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFEBi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:38:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC07DA;
        Sun,  4 Jun 2023 18:38:18 -0700 (PDT)
X-UUID: a1f8a6e4034111ee9cb5633481061a41-20230605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZTFmvjcxnSPWL4V8BU/zxLQ8v4e1t3DoznPIVPHHRuE=;
        b=X56g9sSFC+QimP9TltLJsQ7ZUw+dVluoZyJDycYdd/P+Aj9WaT9iff7n1gau+fag3S6OoS80xpa5gMtv9ZeigjGXHMPOJWE27HCY4IVbVyKUi2I3oQPNxWOTRoIa4wvPjal2TMOZCgKsXg1HItxNqzcf8M8WP6nvuoIOuZjRtHw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:ebee8a99-0de1-4fe2-89e6-0001fd510884,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:ebee8a99-0de1-4fe2-89e6-0001fd510884,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:939afd6d-2f20-4998-991c-3b78627e4938,B
        ulkID:230605093813B5CG5SKO,BulkQuantity:0,Recheck:0,SF:19|38|17|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: a1f8a6e4034111ee9cb5633481061a41-20230605
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 771284861; Mon, 05 Jun 2023 09:38:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 09:38:10 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 09:38:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASVptu84OIxV+9RZNj3hR21CAQwGGz2L2WPKpVQKy9N5AlhMW7q+6ZWd+Kl4LfBADvddKbZKpDSkTzFAlfcn6T4rjJv8D7kbevDCW1a7dxX4R12ercZmYYJH7IM70zw7fg+IzN8FzMC+YKXtrINvriHU3msCAntTwZEGOOiJnk3W3F0HmS49BbMRJ9UiAP+2PQn8BrFR3jiPzoD3Mn3UbL/jgpuY7aHSKQbMdWHxzNjePju1DweoGoXPKATCEp9lxXQsauG7WJMXpr0V9N9kAkD86q3i1BF1K/hAVTij7AzgDxwyKv+RHNdk/K5mm85SroLJv1x8BHdBPkJTm3Hheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTFmvjcxnSPWL4V8BU/zxLQ8v4e1t3DoznPIVPHHRuE=;
 b=dCWTxT/ApWZ3kGpG8lNFW3z3knMqGWY5cI5KitJ/2XEOvMSL9Up9/o7Gbb0NfXYoAtzmysJ9oXjy/yhSAGRpmCAjAuIxM2Z8Ts+xrZALEFJjdRs9VQ2gWPbe9VoF9Jdlws4KQwBYWsVYw5QW/3lmZENH99s1vR+pgTv1q80HdEWfE1FyYSAxH4Cz2sc2lEMSUwPxLqYphPm+2ytTYMAfMOUIoJEOWFN54DQXKEmTHf/y0F+Pno8f6awon8ssffZ5eO1NQG6frSTTtU5pG2VqFQdFvFQlsiu3ipe65WFXn0iL34mgiXlFYlY5jxLTLNArte11XPeaNpOtJhESAQJnqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTFmvjcxnSPWL4V8BU/zxLQ8v4e1t3DoznPIVPHHRuE=;
 b=sOibSEZrrPi/YpTU4zyzP1tUJeav4ch0IQKghioE9DPuryic1wA0yHMKJUitdI3b61epTFSQ7piRiArAGIK8QlKmBn91tVbFBMsvWPooxYpjTQBIPFTmWUoLwbv7aN+4waz1XyRAJDCENmsFMQzMo9QXSZtk0/NXbipglmbgqP8=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by PSAPR03MB5286.apcprd03.prod.outlook.com (2603:1096:301:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 01:38:08 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%9]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 01:38:08 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH v2] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZguL8DXJ4wwqPNE+3vDjAEU6xMa9fzDYAgBRRdwCAAA2JgIABPfCAgABw3wCAACPbAIAAA3kAgAWVooA=
Date:   Mon, 5 Jun 2023 01:38:08 +0000
Message-ID: <c4f5a6a8784dac7013884ae0fa85cd66f683b108.camel@mediatek.com>
References: <20230510015851.11830-1-wenbin.mei@mediatek.com>
         <0df3968e-da34-b36c-4cb4-92d66508a46a@collabora.com>
         <e682b8b66261a71601707a4e74af2829f86800dc.camel@mediatek.com>
         <7f5e14e5-a814-efd7-6082-c4eff697c536@collabora.com>
         <59568b9e6d50135787932cf8e92624914f29e27b.camel@mediatek.com>
         <c26f8cab-9509-1e8a-600f-4f61f38c8b17@collabora.com>
         <5844a9f47e4f9e23185da856cb24085a234cd7dd.camel@mediatek.com>
         <8ad982ba-f8c0-4d15-3740-1883a5aefd29@collabora.com>
In-Reply-To: <8ad982ba-f8c0-4d15-3740-1883a5aefd29@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|PSAPR03MB5286:EE_
x-ms-office365-filtering-correlation-id: e9fa780c-c3a5-437f-3373-08db65658417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UxBUVNTMqhtd4kNXHW8zn3xEz44jUQ6Wk58AYKLIpooNnfdB5brVJG+rdYrdvxMYxQev5hu6yMdl+Z2HsA0iEbzXqP7mepdVFh+AzYPCrFT6KAIRwwvxGfyJXdUUmhtFHmkRdU+Gh5kxB6AlhMw+vuV4mP7fsVZ+ULwtcxLeI99lY1G0pRmMP7kScgyfvFtwc3rnzCIMAUcUdJKoR/patG5k8pn9AsGtuyr9xYjoewbN7GuddkdxuqMSbuY01ca+u57C7Dj+hTCl6phPovYi8n5QDZntgiGm+ZCPtL6rT632ICE/RsOrVsOsbJlAyzpJWU2H1pHpCXnkMXScPw9eeFdWK8+lW7xbfoeesMuI18IvcuEl9/y2yN192p5mE1/vxS3WlCXZPyn58uojUsjNFmeXjWZhC0AmdVSJC7N45i73B7OFNOFYLilaA/dB6I3fYKFGZLd1KGWo2+PUex9CbuEfgH0A7v4c73SvEhbPo7bQI8CtDG8dXxiTosEz92Q/p7edsSZwZOch06jCtNiMoVKHw1uw5msWLnNonbXIqr3Rh3BVc7nmF7hqUximKDSD2NR+9WIr+74sfhP3tOmuNIVVWbIPlzmmiQEk/hmjyCdid0j6FbLwP0zwGMu9f2un
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(376002)(366004)(136003)(396003)(451199021)(41300700001)(316002)(54906003)(110136005)(122000001)(5660300002)(2906002)(4326008)(64756008)(66446008)(66946007)(66556008)(66476007)(76116006)(8676002)(8936002)(478600001)(71200400001)(38070700005)(6486002)(86362001)(186003)(36756003)(85182001)(2616005)(38100700002)(107886003)(26005)(6506007)(6512007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STNlYWNxWmV1d0lVVU5BRStEMkQva1BIUS9FQzRJUm9INWVBcXJOYVhsdlJB?=
 =?utf-8?B?cXgyckEzUGhhL0JpTDlqd2p0UnlKTTlzY0N6aHBTejN6QWlibW44ZTF3MjVV?=
 =?utf-8?B?TzcvMmxFZ1AzeFdVZ1ROVTgzQ1N5aFAxQ2Fzcnkxc29vQUxqMUgvMDhzVlB0?=
 =?utf-8?B?Q3UyQkd1ak9qcmpaZzFwUVZWaVdxQk96L3o3UmI4MjlWZElKRUh2TWprOGNJ?=
 =?utf-8?B?Y2oyNSsvNmZVUDdOWUZTZjFRWGVMMDJZdkQzOW5vMHo3NUh3dWtqMy9TTUdS?=
 =?utf-8?B?aXpNS2tmbnVmYlJ3b0s1QzUvbTdDaGJkSXBnUlZoZ1VFZU16S2V4V09TMWx3?=
 =?utf-8?B?Zmc0dGk5bG5abmEzMFkxREZKWWRuNUFCQis5YTAxTkJza2Jxb0FVVWZVN2ZC?=
 =?utf-8?B?a0hnK1NQSkJGbjNPK0hBQUtlcCtucnEvaDFoeExOK1NleGRYaDUwRVNXSWdK?=
 =?utf-8?B?RE43cDJkTERJK2pDV05tdFhIalF4ZkEvdlVRdVBnUFo2Um0rdVNocjE3WlI1?=
 =?utf-8?B?RE43dmdPcFFmRmhBNnBwcnBKaElpLzNXZy9lR3BPSEJISnVqNCtYbTc1dmhp?=
 =?utf-8?B?Y2ovamtNNzkxMk9IRjFid2ZZdFRRajBIaHQ5dmtvanhhWmdjUUtkUTRBUHF4?=
 =?utf-8?B?UkFZK05EN0pVbmY1eDMwZlE2c3ZOTmF0WnpPVXhaQm5nRCtZZlB5KzJlY0Jl?=
 =?utf-8?B?Z1NaWFFJM1k4L3pSaE04aHBwd2NwQU9TL2p0SkZuWFpCRkhSRTVWRmlZVmFo?=
 =?utf-8?B?ekZIdlZxWmtZUDAyNVVSOWRLcHBRdWRBbDRkMUxodVdhemxIMmQ4Q2FvNDdD?=
 =?utf-8?B?OG5iRm5KZk9EVE9wQ0l6ZEdxTWZ1eForOUpRNFVER1g1UzZWU21lOVR6L3Q2?=
 =?utf-8?B?aGR0aTNFeWpNMmRYR0E0Q21HWkI4QUFmb0s3RGRaOWUxOVB5VFdEN2ZuN1ZJ?=
 =?utf-8?B?bUh6emU3Z2diYWdkbVNLVEtQY2Z0bU1vWHp4Q1l1blVCU1U3NUFld0ZybG5t?=
 =?utf-8?B?NW5Db3BTZFJENlRQRnFkcjVFR3dsU3A2QmJyWXdzRTk4OGQwZCsvMVkwUVdj?=
 =?utf-8?B?Y2lDc2srQ3RLSTlOWEJHejhscVkyVnpMM1pCY0FBdHJUS2k5Y2doU01BSDF2?=
 =?utf-8?B?VXhLYW9nd1JiVVIyS29rUTZlZzQzek1uSlVUblg3SUIzK2J1RUYyOHVwSzN3?=
 =?utf-8?B?TmhEN0lQL3o3L3d0U1NsTVZqd09lOGd1VVdxdFlNaXFsQjFqWDF3MTNWTDgz?=
 =?utf-8?B?Z3Zjc25JdENSS28wSC9kVHFhY3R3ZkJmWVN2OFZFMERjUExZY01Ma25JamI5?=
 =?utf-8?B?Vk93c3BjaWQ0VVBabHljb0dyM3M3dm1URjl1dk5LSURiRjJQU2xoRVRHK1Jk?=
 =?utf-8?B?NG5wb0sxMjdGQnArZ3FBZnNDVnRXYkRXeVFFODRjZUJJVmtKYldXb0RBWFZW?=
 =?utf-8?B?NE9mY21MdWlKVEVCejBYZ3diUGd4UFd6akpNQk5pQjd2ckFBdFlWY1BxOXIr?=
 =?utf-8?B?MFFmTXVKWWxBNHlvYVJQQUJ2RzQ3OW5KUmhJQVYwV3BwUkp6UEM1WUtNRndH?=
 =?utf-8?B?ZHd3RVpZa0NkbzRzUjYxUEN5S1A5QzN1OUsrTmJ3TVpPSWorVkhycTlpT3kx?=
 =?utf-8?B?elZTT2xtWUhVYlJ3aUkrK1M2M0NueXFZY0lOMWc1YjdZaEhXMm1wZWxjMjRV?=
 =?utf-8?B?KzJrcFNSWXJWamhkVGVuMlIrSm40WTFwaGdEbHlUdWFMTENkL1ljVVRPcVlq?=
 =?utf-8?B?eDAzZkFJS2t4Wndyai9ONTkvV2podjB4QTJMTFZsUysrQnZCUXpub2xIYkk4?=
 =?utf-8?B?S21KL3Z0TG8yclBQR0crVlRub01yaWZuYTM3MVUyYm9QMHRob3B5c09IRWtm?=
 =?utf-8?B?SnhtY3dGSS9XWkVzUk90RHEwNWRZQUtZNENaV29LL1d3WEN1ZkxhMlorWWhk?=
 =?utf-8?B?Ulc0MmphL0RPb2hIczl2cVVLUW4zKzRJZVBINHFzWFNubDR3cm4xMXFtb1ZC?=
 =?utf-8?B?WjBCaVlUbWk5amRPRnZST0t1bnRORGFsK3NLQmxkWnJZK0R2Q2xYUy9OSzl1?=
 =?utf-8?B?bU5XWTZEQk1rZUNpVjFQT3ZpOE81MytlYUtzVVMvMzI2VmxUTUF0Sk13LzZU?=
 =?utf-8?B?Nyt1ZWFQZDRYRG05Ni9aN094QjB2aXRZeURZYlVTVE9Id2R5YXNlY1Z1SFN6?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E46628B178E3AA408A5D00C22598CA49@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fa780c-c3a5-437f-3373-08db65658417
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 01:38:08.5015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OT/vkh/FAZnXCYRx7QL0iYPXHEp/PyJhx+XJMwXJzWb1BhK8/RipXTqhq+7CnwiADQYVBY0LhdcB15x3NL959Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5286
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTAxIGF0IDE0OjIxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAwMS8wNi8yMyAxNDowOCwgV2VuYmluIE1l
aSAo5qKF5paH5b2sKSBoYSBzY3JpdHRvOg0KPiA+IE9uIFRodSwgMjAyMy0wNi0wMSBhdCAxMjow
MCArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gd3JvdGU6DQo+ID4+ICAgDQo+
ID4+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzDQo+IHVudGlsDQo+ID4+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ID4+ICAgSWwgMDEvMDYvMjMgMDU6MTYsIFdlbmJpbiBNZWkgKOaiheaW
h+W9rCkgaGEgc2NyaXR0bzoNCj4gPj4+IE9uIFdlZCwgMjAyMy0wNS0zMSBhdCAxMDoxOCArMDIw
MCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPj4gd3JvdGU6DQo+ID4+PiBFeHRlcm5h
bCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0K
PiA+PiB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiA+Pj4NCj4gPj4+IElsIDMxLzA1LzIzIDA5OjMyLCBXZW5iaW4gTWVpICjmooXmloflvawpIGhh
IHNjcml0dG86DQo+ID4+Pg0KPiA+Pj4+IE9uIFRodSwgMjAyMy0wNS0xOCBhdCAxMToxMyArMDIw
MCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPj4gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4+
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cw0KPiA+PiB1bnRpbA0KPiA+Pj4NCj4gPj4+Pj4geW91IGhhdmUgdmVyaWZpZWQgdGhl
IHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPj4+DQo+ID4+Pj4+DQo+ID4+Pg0KPiA+Pj4+Pg0K
PiA+Pj4NCj4gPj4+Pj4gSWwgMTAvMDUvMjMgMDM6NTgsIFdlbmJpbiBNZWkgaGEgc2NyaXR0bzoN
Cj4gPj4+DQo+ID4+Pj4+PiBDUUhDSV9TU0MxIGluZGljYXRlcyB0byBDUUUgdGhlIHBvbGxpbmcg
cGVyaW9kIHRvIHVzZSB3aGVuDQo+IHVzaW5nDQo+ID4+Pg0KPiA+Pj4+Pj4gcGVyaW9kaWMNCj4g
Pj4+DQo+ID4+Pj4+PiBTRU5EX1FVRVVFX1NUQVRVUyhDTUQxMykgcG9sbGluZy4NCj4gPj4+DQo+
ID4+Pj4+PiBUaGUgZGVmYXVsdCB2YWx1ZSAweDEwMDAgdGhhdCBjb3JyZXNwb25kcyB0byAxNTB1
cywgbGV0J3MNCj4gPj4gZGVjcmVhc2UNCj4gPj4+DQo+ID4+Pj4+PiBpdCB0bw0KPiA+Pj4NCj4g
Pj4+Pj4NCj4gPj4+DQo+ID4+Pj4+IFRoZSBkZWZhdWx0IHZhbHVlIDB4MTAwMCAoNDA5NikgY29y
cmVzcG9uZHMgdG8gNDA5NiAqIDUyLjA4dVMgPQ0KPiA+Pj4NCj4gPj4+Pj4gMjMxLjMzdVMNCj4g
Pj4+DQo+ID4+Pj4+IC4uLnNvIHRoZSBkZWZhdWx0IGlzIG5vdCAxNTB1Uy4NCj4gPj4+DQo+ID4+
Pj4+DQo+ID4+Pg0KPiA+Pj4+PiBJZiBJJ20gd3JvbmcsIHRoaXMgbWVhbnMgdGhhdCB0aGUgQ1FD
QVAgZmllbGQgaXMgbm90IDAsIHdoaWNoDQo+ID4+IHdvdWxkDQo+ID4+Pg0KPiA+Pj4+PiBtZWFu
DQo+ID4+Pg0KPiA+Pj4+PiB0aGF0IHRoZSBleHBlY3RlZCAzdVMgd291bGQgYmUgd3JvbmcuDQo+
ID4+Pg0KPiA+Pj4+Pg0KPiA+Pj4NCj4gPj4+Pj4gQWxzbywgc2luY2UgdGhlIGNhbGN1bGF0aW9u
IGNhbiBiZSBkb25lIGR5bmFtaWNhbGx5LCB0aGlzIGlzDQo+IHdoYXQNCj4gPj4gd2UNCj4gPj4+
DQo+ID4+Pj4+IHNob3VsZA0KPiA+Pj4NCj4gPj4+Pj4gYWN0dWFsbHkgZG8gaW4gdGhlIGRyaXZl
ciwgYXMgdGhpcyBnaXZlcyBpbmZvcm1hdGlvbiB0byB0aGUNCj4gbmV4dA0KPiA+Pj4NCj4gPj4+
Pj4gZW5naW5lZXINCj4gPj4+DQo+ID4+Pj4+IGNoZWNraW5nIHRoaXMgcGllY2Ugb2YgY29kZS4N
Cj4gPj4+DQo+ID4+Pj4+DQo+ID4+Pg0KPiA+Pj4+PiBBcGFydCBmcm9tIHRoaXMsIGJ5IGp1c3Qg
d3JpdGluZyAweDQwIHRvIHRoZSBDUUhDSV9TU0MxDQo+IHJlZ2lzdGVyLA0KPiA+PiB5b3UNCj4g
Pj4+DQo+ID4+Pj4+IGFyZQ0KPiA+Pj4NCj4gPj4+Pj4gYXNzdW1pbmcgdGhhdCB0aGUgQ1FDQVAg
dmFsdWUgcmVxdWlyZW1lbnQgaXMgZnVsbGZpbGxlZCwgYnV0DQo+IHlvdQ0KPiA+Pj4NCj4gPj4+
Pj4gY2Fubm90DQo+ID4+Pg0KPiA+Pj4+PiBhc3N1bWUgdGhhdCB0aGUgYm9vdGxvYWRlciBoYXMg
c2V0IHRoZSBDUUNBUCdzIElUQ0ZWQUwgYW5kDQo+ID4+IElUQ0ZNVUwNCj4gPj4+DQo+ID4+Pj4+
IGZpZWxkcw0KPiA+Pj4NCj4gPj4+Pj4gYXMgeW91IGV4cGVjdCBvbiBhbGwgcGxhdGZvcm1zOiB0
aGlzIG1lYW5zIHRoYXQgaW1wbGVtZW50aW5nDQo+IHRoaXMNCj4gPj4+DQo+ID4+Pj4+IHRha2Vz
DQo+ID4+Pg0KPiA+Pj4+PiBhIGxpdHRsZSBtb3JlIGVmZm9ydC4NCj4gPj4+DQo+ID4+Pj4+DQo+
ID4+Pg0KPiA+Pj4+PiBZb3UgaGF2ZSB0d28gd2F5cyB0byBpbXBsZW1lbnQgdGhpczoNCj4gPj4+
DQo+ID4+Pj4+ICAgICAgKioqIEZpcnN0ICoqKg0KPiA+Pj4NCj4gPj4+Pj4gICAgICAxLiBSZWFk
IElUQ0ZNVUwgYW5kIElUQ0ZWQUwsIHRoZW46DQo+ID4+Pg0KPiA+Pj4+PiAgICAgICAgIHRjbGtf
bXVsID0gaXRjZm11bF90b19taHooSVRDRk1VTCk7IC8qIHBzZXVkbyBmdW5jdGlvbg0KPiA+Pj4N
Cj4gPj4+Pj4gaW50ZXJwcmV0cyByZWcgdmFsdWUqLw0KPiA+Pj4NCj4gPj4+Pj4gICAgICAgICB0
Y2xrID0gSVRDRlZBTCAqIHRjbGtfbXVsOw0KPiA+Pj4NCj4gPj4+Pj4NCj4gPj4+DQo+ID4+Pj4+
ICAgICAgMi4gU2V0IFNTQzEgc28gdGhhdCB3ZSBnZXQgM25TOg0KPiA+Pj4NCj4gPj4+Pj4gICAg
ICAgICAjZGVmaW5lIENRSENJX1NTQzFfQ0lUIEdFTk1BU0soMTUsIDApDQo+ID4+Pg0KPiA+Pj4+
PiAgICAgICAgIHBvbGxfdGltZSA9IGNpdF90aW1lX25zX3RvX3JlZ3ZhbCgzKTsNCj4gPj4+DQo+
ID4+Pj4+ICAgICAgICAgc3NjaXQgPSBGSUVMRF9QUkVQKENRSENJX1NTQzFfQ0lULCBwb2xsX3Rp
bWUpDQo+ID4+Pg0KPiA+Pj4+PiAgICAgICAgIGNxaGNpX3dyaXRlbCggLi4uICkNCj4gPj4+DQo+
ID4+Pj4+DQo+ID4+Pg0KPiA+Pj4+PiAgICAgICoqKiBTZWNvbmQgKioNCj4gPj4+DQo+ID4+Pj4+
DQo+ID4+Pg0KPiA+Pj4+PiAgICAgIDEuIFByZS1zZXQgSVRDRk1VTCBhbmQgSVRDRlZBTCB0bw0K
PiA+Pj4NCj4gPj4+Pj4gICAgICAgICBJVENGVkFMID0gMTkyIChkZWNpbWFsKQ0KPiA+Pj4NCj4g
Pj4+Pj4gICAgICAgICBJVENGTVVMID0gMiAod2hlcmUgMiA9PSAwLjFNSHopDQo+ID4+Pg0KPiA+
Pj4+Pg0KPiA+Pj4NCj4gPj4+Pj4gICAgICAyLiBTZXQgU1NDMSBzbyB0aGF0IHdlIGdldCAzblM6
DQo+ID4+Pg0KPiA+Pj4+PiAgICAgICAgICNkZWZpbmUgQ1FIQ0lfU1NDMV9DSVQgR0VOTUFTSygx
NSwgMCkNCj4gPj4+DQo+ID4+Pj4+ICAgICAgICAgcG9sbF90aW1lID0gY2l0X3RpbWVfbnNfdG9f
cmVndmFsKDMpOw0KPiA+Pj4NCj4gPj4+Pj4gICAgICAgICBzc2NpdCA9IEZJRUxEX1BSRVAoQ1FI
Q0lfU1NDMV9DSVQsIHBvbGxfdGltZSkNCj4gPj4+DQo+ID4+Pj4+ICAgICAgICAgY3FoY2lfd3Jp
dGVsKCAuLi4gKQ0KPiA+Pj4NCj4gPj4+Pj4NCj4gPj4+DQo+ID4+Pj4+IEkgd291bGQgaW1wbGVt
ZW50IHRoZSBmaXJzdCB3YXksIGFzIGl0IHBhdmVzIHRoZSB3YXkgdG8gZXh0ZW5kDQo+ID4+IHRo
aXMNCj4gPj4+DQo+ID4+Pj4+IHRvIGRpZmZlcmVudA0KPiA+Pj4NCj4gPj4+Pj4gdGNsayB2YWx1
ZXMgaWYgbmVlZGVkIGluIHRoZSBmdXR1cmUuDQo+ID4+Pg0KPiA+Pj4+Pg0KPiA+Pj4NCj4gPj4+
Pj4gUmVnYXJkcywNCj4gPj4+DQo+ID4+Pj4+IEFuZ2Vsbw0KPiA+Pj4NCj4gPj4+PiBIaSBBbmdl
bG8sDQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4+IFNvcnJ5IGZvciBsYXRlbHkgcmVwbHku
DQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4+IEZvciBNZWRpYXRlayBtbWMgaG9zdCBJUCwg
SVRDRk1VTCBpcyAweDIoMHgxTUh6KSwgSVRWRlZBTA0KPiByZXBvcnRzDQo+ID4+IDE4MiwNCj4g
Pj4+DQo+ID4+Pj4gYW5kIHRoZXNlIGZpZWxkcyBhcmUgdGhlIHNhbWUgYW5kIGFyZSByZWFkb25s
eSBmb3IgYWxsIElDLCBidXQNCj4gPj4gc2luY2UNCj4gPj4+DQo+ID4+Pj4gTWVkaWF0ZWsgQ1FF
IHVzZXMgbXNkY19oY2xrKDI3M01IeiksIENNRDEzJ2ludGVydmFsIGNhbGN1bGF0aW9uDQo+ID4+
IGRyaXZlcg0KPiA+Pj4NCj4gPj4+PiBzaG91bGQgdXNlIDI3M01IeiB0byBnZXQgdGhlIGFjdHVh
bCB0aW1lLCBzbyB0aGUgYWN0dWFsIGNsb2NrIGlzDQo+ID4+Pg0KPiA+Pj4+IDI3LjNNSHouDQo+
ID4+Pg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IFlvdSdyZSByaWdodCwgSSd2ZSBtaXNy
ZWFkIHRoZSBkYXRhc2hlZXQsIGp1c3QgcmVjaGVja2VkIGFuZCBpdA0KPiA+PiByZXBvcnRzIFJP
Lg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pj4gSWYgQ0lUIGlzIDB4MTAwMCBieSBkZWZhdWx0LCBDTUQg
aWRsZSB0aW1lOiAweDEwMDAgKiAxIC8gMjcuM01Ieg0KPiA9DQo+ID4+Pg0KPiA+Pj4+IGFyb3Vu
ZCAxNTB1cy4NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+DQo+ID4+Pj4gSW4gYWRkaXRpb24gdGhlIGJv
b3Rsb2FkZXIgd2lsbCBub3Qgc2V0IHRoZSBDUUNBUCdzIElUQ0ZWQUwgYW5kDQo+ID4+IElUQ0ZN
VUwNCj4gPj4+DQo+ID4+Pj4gZmllbGRzLCBiZWNhdXNlIHRoZXNlIGZpZWxkcyBvZiBDUUNBUCBy
ZWdpc3RlciBpcyBSTyhyZWFkb25seSksDQo+IHNvDQo+ID4+IHdlDQo+ID4+Pg0KPiA+Pj4+IGNh
biBpZ25vcmUgdGhlIGNoYW5nZSBmb3IgdGhlIENRQ0FQJ3MgSVRDRlZBTCBhbmQgSVRDRk1VTA0K
PiBmaWVsZHMuDQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IFllcywgdGhhdCdz
IHJpZ2h0LCBhZ2FpbiAtIHRoaXMgbWVhbnMgdGhhdCB5b3Ugc2hvdWxkIGdvIGZvciB0aGUNCj4g
Pj4gZmlyc3QNCj4gPj4+DQo+ID4+PiBwcm9wb3NlZCBpbXBsZW1lbnRhdGlvbiwgYXMgZnV0dXJl
IE1lZGlhVGVrIFNvQ3MgbWF5IChvciBtYXkgbm90KQ0KPiA+PiBjaGFuZ2UNCj4gPj4+DQo+ID4+
PiB0aGF0OiBpZiB5b3UgaW1wbGVtZW50IGFzIHByb3Bvc2VkLCB0aGlzIGlzIGdvaW5nIHRvIGJl
IGEgb25lLQ0KPiB0aW1lDQo+ID4+IHRoaW5nDQo+ID4+Pg0KPiA+Pj4gYW5kIGZ1dHVyZSBTb0Nz
IHdvbid0IG5lZWQgc3BlY2lmaWMgY2hhbmdlcy4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gVGhhdCBp
bXBsZW1lbnRhdGlvbiBhbHNvIGRvY3VtZW50cyB0aGUgZmxvdyBhYm91dCBob3cgd2UncmUNCj4g
Z2V0dGluZw0KPiA+PiB0bw0KPiA+Pj4NCj4gPj4+IHRoZSBhY3R1YWwgdmFsdWUsIHdoaWNoIGlz
IGltcG9ydGFudCBmb3IgY29tbXVuaXR5IHBlb3BsZSByZWFkaW5nDQo+ID4+IHRoaXMNCj4gPj4+
DQo+ID4+PiBkcml2ZXIgaW4gdGhlIGZ1dHVyZSBmb3IgZGVidWdnaW5nIHB1cnBvc2VzLg0KPiA+
Pj4NCj4gPj4+DQo+ID4+PiBSZWdhcmRzLA0KPiA+Pj4NCj4gPj4+IEFuZ2Vsbw0KPiA+Pj4NCj4g
Pj4+DQo+ID4+Pg0KPiA+Pj4gVGhhbmtzIGZvciB5b3VyIHByb3Bvc2FsLg0KPiA+Pj4NCj4gPj4+
DQo+ID4+PiBJIGhhdmUgZGlzY3Vzc2VkIHdpdGggb3VyIGRlc2lnbmVyLCBhbmQgdGhpcyBmaWVs
ZHMgb2YgQ1FDQVAncw0KPiA+PiBJVENGVkFMIGFuZCBJVENGTVVMIHdpbGwgbm90IGNoYW5nZS4N
Cj4gPj4+IElmIHdlIGFkZCBtb3JlIGNvZGUgZm9yIGl0LCB0aGVzZSBjb2RlcyB3aWxsIGFsc28g
YWZmZWN0IHRoZQ0KPiA+PiBleGVjdXRpb24gZWZmaWNpZW5jeSwgZXZlbiBpZiBpdCBoYXMgYSB2
ZXJ5DQo+ID4+PiBzbWFsbCBlZmZlY3QuDQo+ID4+PiBJIHRoaW5rIGlmIGl0J3MganVzdCBmb3Ig
cmVhZGluZyBjb252ZW5pZW5jZSwgd2UgY2FuIGFkZCBtb2RlDQo+ID4+IGNvbW1lbnRzIHRvIG1h
a2UgaXQgZWFzaWVyIHRvIHJlYWQgdGhlIGNvZGUuDQo+ID4+PiBEbyB5b3UgdGhpbmsgaXQncyBv
a2F5IHRvIGFkZCBtb3JlIGNvbW1lbnRzPw0KPiA+Pj4NCj4gPj4NCj4gPj4gVGhpcyBpc24ndCBh
IHBlcmZvcm1hbmNlIHBhdGgsIGJ1dCBhbnl3YXksIGlmIHlvdSB0aGluayB0aGF0IGl0DQo+IHdp
bGwNCj4gPj4gYmUgYXQgc29tZQ0KPiA+PiBwb2ludCwgeW91IGNhbiByZWFkIHRoZSB0d28gcmVn
aXN0ZXJzIGF0IHByb2JlIHRpbWUgYXMgcGFydCBvZiB0aGUNCj4gPj4gTU1DX0NBUDJfQ1FFDQo+
ID4+IGlmIGJyYW5jaCwgYW5kIHRoZW4gY2FjaGUgdGhlIGludmFyaWFibGUgdmFsdWVzIHRvIGBz
dHJ1Y3QNCj4gPj4gbXNkY19ob3N0YDogdGhpcw0KPiA+PiB3aWxsIG1ha2UgeW91IGFibGUgdG8g
bmV2ZXIgcGVyZm9ybSByZWdpc3RlciByZWFkcyBmb3INCj4gSVRDRlZBTC9GTVVMDQo+ID4+IGlu
DQo+ID4+IG1zZGNfY3FlX2VuYWJsZSgpLCByZXNvbHZpbmcgdGhlIGVmZmljaWVuY3kgaXNzdWUu
DQo+ID4+DQo+ID4+IEV2ZW4gYmV0dGVyLCBpbnN0ZWFkIG9mIGNhY2hpbmcgSVRDRlZBTC9GTVVM
IHRvIHR3byB2YXJpYWJsZXMsDQo+IHNpbmNlDQo+ID4+IHRoZSBpZGxlDQo+ID4+IHRpbWVyIHZh
bHVlIGxpa2VseSB3b24ndCBldmVyIGNoYW5nZSBkdXJpbmcgcnVudGltZSwgeW91IGNhbg0KPiBk
aXJlY3RseQ0KPiA+PiBwZXJmb3JtDQo+ID4+IHRoZSBjYWxjdWxhdGlvbiBmb3IgU1NDMSBhdCBw
cm9iZSB0aW1lIGFuZCBjYWNoZSB0aGF0IHZhbHVlDQo+IGluc3RlYWQsDQo+ID4+IHNvIHRoYXQN
Cj4gPj4gaW4gbXNkY19jcWVfZW5hYmxlKCkgeW91IHdpbGwgaGF2ZSBzb21ldGhpbmcgbGlrZS4u
Lg0KPiA+Pg0KPiA+PiAvKiBTZXQgdGhlIHNlbmQgc3RhdHVzIGNvbW1hbmQgaWRsZSB0aW1lciAq
Lw0KPiA+PiBjcWhjaV93cml0ZWwoY3FfaG9zdCwgaG9zdC0+Y3Ffc3NjMV90aW1lLCBDUUhDSV9T
U0MxKTsNCj4gPj4NCj4gPj4gd2hlcmUgY3Ffc3NjMV90aW1lIGlzDQo+ID4+IHN0cnVjdCBtc2Rj
X2hvc3Qgew0KPiA+PiAuLi4uLi4uDQo+ID4+IHUzMiBjcV9zc2MxX3RpbWU7DQo+ID4+IC4uLi4N
Cj4gPj4gfQ0KPiA+Pg0KPiA+PiBhbmQgd2hlcmUgeW91ciBwcm9iZSBmdW5jdGlvbiBpcw0KPiA+
Pg0KPiA+PiBzdGF0aWMgaW50IG1zZGNfZHJ2X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4+IHsNCj4gPj4gLi4uLi4uDQo+ID4+DQo+ID4+IGlmIChtbWMtPmNhcHMyICYg
TU1DX0NBUDJfQ1FFKSB7DQo+ID4+IGhvc3QtPmNxX2hvc3QgPSAuLi4uLi4NCj4gPj4gLi4uLi4u
Li4NCj4gPj4gcmVhZCBpdGNmdmFsOw0KPiA+PiByZWFkIGl0Y2ZtdWw7DQo+ID4+IGhvc3QtPmNx
X3NzYzFfdGltZSA9IGNhbGN1bGF0ZWQtdmFsdWU7DQo+ID4+IC4uLi4uLi4uDQo+ID4+IH0NCj4g
Pj4NCj4gPj4gLi4uLi4uLg0KPiA+PiB9DQo+ID4+DQo+ID4gWWVzLCBJIHRoaW5rIGl0J3Mgb2th
eSBmb3IgbWUuDQo+ID4gQW5vdGhlciBwcm9ibGVtLCBJVENGVkFMIHJlcG9ydHMgMTgyIGZvciBN
ZWRpYVRlayBTb0NzLCBidXQgd2UgY2FuDQo+IG5vdA0KPiA+IHVzZSBpdCB0byBjYWxjdWxhdGUs
IGFzIGkgc2FpZCBlYXJsaWVyLCBzaW5jZSBvdXIgQ1FFIHVzZXMNCj4gPiBtc2RjX2hjbGsoMjcz
TUh6KSwgQ01EMTMnIGludGVydmFsIGNhbGN1bGF0aW9uIGRyaXZlcnMgc2hvdWxkIHVzZQ0KPiA+
IDI3M01IeiB0byBnZXQgdGhlIGFjdHVhbCB0aW1lLCBub3QgMTgyTUh6Lg0KPiA+IElmIHdlIHVz
ZSBJVENGVkFMLCB3ZSB3aWxsIGdldCBhIHdyb25nIHZhbHVlLg0KPiA+IFNvIEkgdGhpbmsgaXQn
cyBtZWFuaW5nbGVzcy4NCj4gDQo+IGNsa19nZXRfcmF0ZShtc2RjX2hjbGspIGdpdmVzIHlvdSB0
aGUgY3VycmVudCBtc2RjX2hjbGsgY2xvY2sgcmF0ZToNCj4gdXNlIGl0DQo+IGluIHBsYWNlIG9m
IHJlYWRpbmcgSVRDRlZBTCwgdGhhdCdzIHlvdXIgc29sdXRpb24uDQo+IA0KPiBJIHdvdWxkIGlt
YWdpbmUgdGhhdCAqYXQgbGVhc3QqIElUQ0ZNVUwgaXMgY29ycmVjdCBvbiBNZWRpYVRlayBTb0Nz
LA0KPiBzbyB5b3UNCj4gY2FuIHVzZSB0aGF0IG9uZSBhcyBpdCBpcy4NClRoYW5rcyBmb3IgeW91
ciByZXZpZXcuDQpJIHdpbGwgaW1wbGVtZW50IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJl
Z2FyZHMsDQpXZW5iaW4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCj4gPiANCj4gPiBC
ZWdhcmRzLA0KPiA+IFdlbmJpbg0KPiA+PiBSZWdhcmRzLA0KPiA+PiBBbmdlbG8NCj4gPj4NCj4g
Pj4NCj4gPj4+IEJlZ2FyZHMsDQo+ID4+PiBXZW5iaW4NCj4gPj4+DQo+ID4+Pj4gVGhhbmtzDQo+
ID4+Pg0KPiA+Pj4+IFdlbmJpbg0KPiA+Pj4NCj4gPj4+Pj4NCj4gPj4+DQo+ID4+Pj4+PiAweDQw
IHRoYXQgY29ycmVzcG9uZHMgdG8gM3VzLCB3aGljaCBjYW4gaW1wcm92ZSB0aGUNCj4gcGVyZm9y
bWFuY2UNCj4gPj4gb2YNCj4gPj4+DQo+ID4+Pj4+PiBzb21lDQo+ID4+Pg0KPiA+Pj4+Pj4gZU1N
QyBkZXZpY2VzLg0KPiA+Pj4NCj4gPj4+Pj4+DQo+ID4+Pg0KPiA+Pj4+Pj4gU2lnbmVkLW9mZi1i
eTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRpYXRlay5jb20+DQo+ID4+Pg0KPiA+Pj4+Pj4g
LS0tDQo+ID4+Pg0KPiA+Pj4+Pj4gICAgICBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgNCAr
KysrDQo+ID4+Pg0KPiA+Pj4+Pj4gICAgICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
DQo+ID4+Pg0KPiA+Pj4+Pj4NCj4gPj4+DQo+ID4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvaG9zdC9tdGstc2QuYyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLQ0KPiA+PiBzZC5jDQo+ID4+
Pg0KPiA+Pj4+Pj4gaW5kZXggZWRhZGUwZTU0YTBjLi5mZmVjY2RkY2QwMjggMTAwNjQ0DQo+ID4+
Pg0KPiA+Pj4+Pj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+Pj4NCj4gPj4+
Pj4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPj4+DQo+ID4+Pj4+PiBAQCAt
MjQ1Myw2ICsyNDUzLDcgQEAgc3RhdGljIHZvaWQNCj4gPj4gbXNkY19oczQwMF9lbmhhbmNlZF9z
dHJvYmUoc3RydWN0DQo+ID4+Pg0KPiA+Pj4+Pj4gbW1jX2hvc3QgKm1tYywNCj4gPj4+DQo+ID4+
Pj4+PiAgICAgIHN0YXRpYyB2b2lkIG1zZGNfY3FlX2VuYWJsZShzdHJ1Y3QgbW1jX2hvc3QgKm1t
YykNCj4gPj4+DQo+ID4+Pj4+PiAgICAgIHsNCj4gPj4+DQo+ID4+Pj4+PiAgICAgICAgICBzdHJ1
Y3QgbXNkY19ob3N0ICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCj4gPj4+DQo+ID4+Pj4+PiArICAg
ICBzdHJ1Y3QgY3FoY2lfaG9zdCAqY3FfaG9zdCA9IG1tYy0+Y3FlX3ByaXZhdGU7DQo+ID4+Pg0K
PiA+Pj4+Pj4NCj4gPj4+DQo+ID4+Pj4+PiAgICAgICAgICAvKiBlbmFibGUgY21kcSBpcnEgKi8N
Cj4gPj4+DQo+ID4+Pj4+PiAgICAgICAgICB3cml0ZWwoTVNEQ19JTlRfQ01EUSwgaG9zdC0+YmFz
ZSArIE1TRENfSU5URU4pOw0KPiA+Pj4NCj4gPj4+Pj4+IEBAIC0yNDYyLDYgKzI0NjMsOSBAQCBz
dGF0aWMgdm9pZCBtc2RjX2NxZV9lbmFibGUoc3RydWN0DQo+ID4+IG1tY19ob3N0DQo+ID4+Pg0K
PiA+Pj4+Pj4gKm1tYykNCj4gPj4+DQo+ID4+Pj4+PiAgICAgICAgICBtc2RjX3NldF9idXN5X3Rp
bWVvdXQoaG9zdCwgMjAgKiAxMDAwMDAwMDAwVUxMLCAwKTsNCj4gPj4+DQo+ID4+Pj4+PiAgICAg
ICAgICAvKiBkZWZhdWx0IHJlYWQgZGF0YSB0aW1lb3V0IDFzICovDQo+ID4+Pg0KPiA+Pj4+Pj4g
ICAgICAgICAgbXNkY19zZXRfdGltZW91dChob3N0LCAxMDAwMDAwMDAwVUxMLCAwKTsNCj4gPj4+
DQo+ID4+Pj4+PiArDQo+ID4+Pg0KPiA+Pj4+Pj4gKyAgICAgLyogZGVjcmVhc2UgdGhlIHNlbmQg
c3RhdHVzIGNvbW1hbmQgaWRsZSB0aW1lciB0byAzdXMgKi8NCj4gPj4+DQo+ID4+Pj4+PiArICAg
ICBjcWhjaV93cml0ZWwoY3FfaG9zdCwgMHg0MCwgQ1FIQ0lfU1NDMSk7DQo+ID4+Pg0KPiA+Pj4+
Pj4gICAgICB9DQo+ID4+Pg0KPiA+Pj4+Pj4NCj4gPj4+DQo+ID4+Pj4+PiAgICAgIHN0YXRpYyB2
b2lkIG1zZGNfY3FlX2Rpc2FibGUoc3RydWN0IG1tY19ob3N0ICptbWMsIGJvb2wNCj4gPj4gcmVj
b3ZlcnkpDQo+ID4+Pg0KPiA+Pj4+Pg0KPiA+Pj4NCj4gPj4+Pj4NCj4gPj4+DQo+ID4+Pg0KPiA+
Pj4NCj4gPj4NCj4gDQo=
