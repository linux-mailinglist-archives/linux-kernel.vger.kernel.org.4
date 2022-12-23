Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD236654D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiLWIUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLWIUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:20:30 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3C733CC7;
        Fri, 23 Dec 2022 00:20:27 -0800 (PST)
X-UUID: 36055c4921b54eaea2f02362b65c2d28-20221223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4lwBTSfkHjYTSwp6y8KXn4mIbJ/SOgRjftExRw5ldSc=;
        b=b+mU2Yy/ZnPsjEdiUrdmImBK1SFSSnLn52o5gIW5kxkjhI0A4YnjAYgPoFzHHVpahv0o0WopJ2ZVtpsrX3EWijv5dqBb2ntoX9mCmTcPg2sgUC+6Nacc13m5POGbhvkx5tWKiVuojTXio5qoxp7+Fxyl+5RlZbPAWW/i38kqj8o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:76a1f3b8-22d6-45ed-b12b-01ce0efc0cb9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:26d2348a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 36055c4921b54eaea2f02362b65c2d28-20221223
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <garmin.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2124057781; Fri, 23 Dec 2022 16:20:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Dec 2022 16:20:21 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 23 Dec 2022 16:20:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agvnG4bUROWXizI9DQfgkSnvKo/kk4CJ7zK0ZAp9qTUSTqLAIHSBodBMreUWHlWAyNSgQucjiHLu25UoKIibOQkmWDU7Ep/10cxMiAX10iffG45LqTA88sr0HRu4NN45AE+YRsCagbW+JzFpC9Rkynrrlkt9lkTNDYLEbhSh08v62TUz3Mpr+zTMJBWLLPmCDqcZwqdYRZkWt+CuceJJCKmdatZEtja6nNhmYj8du3UMqRvv/taQyilo+YvfuOmzpq3bKpYYgDel/ogFyrIrIVrMJInxMpJoQjke3fqcxF+X0XDNxR4CTtwLvFeZc2gUgM1GSthsPMdiyYzTYm4QbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lwBTSfkHjYTSwp6y8KXn4mIbJ/SOgRjftExRw5ldSc=;
 b=bG4kJVo2hatQ4RCll0mzWtjSgRQuyTE2G2tFENfiacH+Em3IYSXlBUEpQbjDZzlpabHPo/+2+QqCRq5DiNBqE9nXCqzU1CE75+voI/tjMme8iCTX8GR5Xia9jvmT4CYN+lqZyeW+XjfLtBJIH3F+0MPvPiN3A3CTs3p3Yhh3ijrvLGoW7twWKou8P2CLjsF4dqEq5XvsUL0XvNWbNcIzsIYICznN2jgEVOfko5H/uT0dkQJ+hmZruK55uhWFaVnx9mG7RHrdZqHL9AzhQyr6C19P1w6wJLbZBf4qONhNrfpvtPxNt0VLNd6MFYdlTEQT7BAopMSqvnnSrert1c9eTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lwBTSfkHjYTSwp6y8KXn4mIbJ/SOgRjftExRw5ldSc=;
 b=RGhjL3CCKHC1nk9OyM0kNacHJBK47IsQeBKCxddEvxBam82wAQOoUy9pAmE/Dxjk1+ucOGKT6tH4mW+HFkrYx3WmGj/iFLNN7sbv3rtP2zVpa9jU36WlSMQ1QF+Xsa0+/sVvnEE3a+Txwa5ZvAtFNvPfPcxEiHD8bfQDKy3dHoI=
Received: from SI2PR03MB5888.apcprd03.prod.outlook.com (2603:1096:4:145::6) by
 TYZPR03MB5774.apcprd03.prod.outlook.com (2603:1096:400:65::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Fri, 23 Dec 2022 08:20:19 +0000
Received: from SI2PR03MB5888.apcprd03.prod.outlook.com
 ([fe80::914:6297:ee3:511e]) by SI2PR03MB5888.apcprd03.prod.outlook.com
 ([fe80::914:6297:ee3:511e%9]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 08:20:19 +0000
From:   =?utf-8?B?R2FybWluIENoYW5nICjlvLXlrrbpipgp?= 
        <Garmin.Chang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 01/19] dt-bindings: ARM: MediaTek: Add new document
 bindings of MT8188 clock
Thread-Topic: [PATCH v2 01/19] dt-bindings: ARM: MediaTek: Add new document
 bindings of MT8188 clock
Thread-Index: AQHY541ORvs9lWxTS0S/dbP9QCwQpq4iRMyAgFk64QA=
Date:   Fri, 23 Dec 2022 08:20:18 +0000
Message-ID: <374127db954e43d47032f980bb7d9704a5bd2a1d.camel@mediatek.com>
References: <20221024094254.29218-1-Garmin.Chang@mediatek.com>
         <20221024094254.29218-2-Garmin.Chang@mediatek.com>
         <9092152a-35c9-1f80-8674-ea4124a1bb36@linaro.org>
In-Reply-To: <9092152a-35c9-1f80-8674-ea4124a1bb36@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5888:EE_|TYZPR03MB5774:EE_
x-ms-office365-filtering-correlation-id: 8d152648-be02-4c8d-b336-08dae4be8735
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 17i9NRyssEx4/qR4C2TcwVGCvFaqCyBVfzkdvgs6fGoLs8l03cDd4jedZISzM5wH+M10fZ5peY3SxG2FTsNQzhLdZDFQSXQVCmodLk1gU2uE/LAcaWROMKHqubaUVTrikQFFFUprE6XK+uLle2a/yrJin4GjoApUshOhElUlXkrl/K8+PJStk7ZnzYe2Kg+ZO/EitFLUzIKiF8jXc4MXdC5GIe8nykuPiuN9x5kdMTSGSuaRmtWs2Pzdrj75uC90sfJrJkmlXnuAb5n0aSrF4GGHFiTMw6bdeq9SU4HKp/ZDwFMWPfSrwgBS/hnmu1fPEnxvi7Ak7GdGWzz9oc4m5AZrfGlQDob/gmjvOac0/7tE9rhmTL2zm59mVPVl4kbVhBeL3cQcykkIMsRtH1zGzz707UulZBUXl3yT4faJuoYmIRk22ffrFH7unXV6N/wLbsyk+WTSBj1Z+3jxCCtX1yZZgNBp9uw/lYPmYORPncgTo+mkqSHTIma1rDV6kljCII0o3UkZFKNivsIBCvEmie0cKRgubCAJwCVxbKgPq2cNzgCK2npKC5bzansNfowZvVC+uiquPhsZu8mm/BUjfYG/7gMn2HwL7guYusx2Tit8T46oypOGlpvQqlbP40h7ddhkEqvukpcCVD3qxbKtCMpdEe6tqRcpwhXeyvARx7hKelzMOeev3aa4BX9xiojYM8adeOxwZ/f4cQFEPNKaIT0lKfrI0hoAHkk3G2Cf+k6zfer58E9Z8iX7K8edvyApa/NQKjdRzsVMZRafzUawFqzgIthh/z11MGsCfDKaufjnbJxbln1Put6PAb8/b/9i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(2906002)(7416002)(5660300002)(8936002)(66556008)(316002)(41300700001)(8676002)(66446008)(4326008)(76116006)(66946007)(66476007)(64756008)(4001150100001)(6506007)(85182001)(36756003)(6512007)(54906003)(2616005)(86362001)(110136005)(966005)(71200400001)(478600001)(26005)(6486002)(53546011)(83380400001)(38100700002)(38070700005)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmFNOXk4SjR3T0xHM0Rhbyt3dFI5OUpmbXRDcERIeWdJNFpPdlNMbWdyeGMy?=
 =?utf-8?B?MGdXZXVuZ1g4bk5LKzh0TDNURFdBeTVPbDdWZkY0TVpTL3pleFZoZFN5L1V0?=
 =?utf-8?B?R1lXM2lTekVLVGtWcGJpZGxxRGpLdUU3RTBhbFJrSVFHd1g3OVg2YitQb09y?=
 =?utf-8?B?RlIrQitZRlNiQkJuVHFaTExpT0FOdjVRVUJXSmxvSnBkTENMQmo1cXR1NC9o?=
 =?utf-8?B?ckE1blc3SktxZGlQQlVZV2lwd2R4UWJOeHZ4akN0MTNxN213RDl3Qmx0VStT?=
 =?utf-8?B?b1dZS2hWQkZvMVcybVdodkF3RFRlRVRGSG1VckVkZW10KzFRQkU5R3piZWhP?=
 =?utf-8?B?eWIxV1NQUE1TaFZCTjJrczh6OFJvY3lDN3RxMXBpblpUM2RrdUpCRnRWLzU4?=
 =?utf-8?B?c20zWlVHakx4RGNJK1RLQmRnbmhjS2RHZG5ESWY4NGJiNkRjLzJ1bmxONXRQ?=
 =?utf-8?B?ZGlZYzFQQzJnMFA2THdMVGNrbmdZbE13c25XWm52Z25JdHlVbzhBdFJCZHA0?=
 =?utf-8?B?VGh5RVdmTE5aS25TeU10bU9Pdm9ZY3pyV0xLZnJiVWVaOHBicGIwT2tyKzJj?=
 =?utf-8?B?UnNZczdVYXpJejhsNENrUGJlNS9GTDhINnFEQzFmdlMySjRSRGVQQk5nbHov?=
 =?utf-8?B?dko4azh3TmhSRm1oZFdCTWVoaEZxUjdmWW1VbkZUSldVQ1MrR3dIZEVlUjNr?=
 =?utf-8?B?M2FSTlgzbjE1SEdBbHlmUHpSY3Z1S08wMUZoZjlydjJLa0tSZS9zaEpCZTZi?=
 =?utf-8?B?YzhpKzZGTzNiUVRGOXc4blZvdzFQNlVCUE8xVTFtb3N3UElZTSswWFpjZ2Zi?=
 =?utf-8?B?Zm5GaFd6ZVJwR1lTMEhxTzZSNmpKZXNDR3pJcUxFSG5iR1lKM05uYlhVUTZU?=
 =?utf-8?B?OGRlYldITXhaYVdHZEtiM3JPSVBTVUZob0VKTVFITVZ1VXVueCtWMUd3YXpF?=
 =?utf-8?B?azdNOVZCRVRJbmJhRFZRZEhPM25mV1FCdC9jclFlajZBVnh5YWg2Q01nZjl3?=
 =?utf-8?B?aXZOckdVcTArTXpsSGlNaEdpa1hTWnBTUHp2cFpIV3pLcStzb05FVG5VeXVw?=
 =?utf-8?B?M1lvRk1DZWgxUlJlRXdRUjI5czFiLzlvQ0VMcWpXZDJMTjhCWEh3N0dhdmc5?=
 =?utf-8?B?YklQQU1jZ0RBeXI3VHBxQlgvVzQ3L094Q0NIWjRxcHF0K05yTUh6ckVlWU5N?=
 =?utf-8?B?cWtwek4ycFN0TkJmWnZybmlwdmw5S09BckZDeXVPYklOVFlFN2VCZ3h3T2pu?=
 =?utf-8?B?cVVNUTFHVk1GZlg3NE1YekQyTFcyZE0zeHZ1REozNm1rNHptWHpja1MyNkRJ?=
 =?utf-8?B?bGx0Tk9jL28vQ1Q4UFBCMnl3MThlMnZCckZwRlk3ckxSUmVCYk1FWXdNS1FY?=
 =?utf-8?B?SXNUYjNMeWxqdmNFWkEyaWdWSXphVng1dERRSnV1dGJQQm1QdEw4SUpFTnp5?=
 =?utf-8?B?OW1aWTB3c1dWb3BNdjBtWENLOXdjUXlJN2RMVXcramVacXdlSEdWTFBRdFlD?=
 =?utf-8?B?R0FCVmYydGZmWU5RczRZRTJPUVJxVEJvVytDTWVKZ2NGRkltb0k0KytIalhQ?=
 =?utf-8?B?VTNPbGFBMDd3TXZET0Z1WVRtek9qVHJjdHRiR05tU0VtaHdsZnU1ZnpaQ2s2?=
 =?utf-8?B?NC9lVjZGQm40Yi90eUMrMXYzNVp5c1JEZ21Cd0tSRTJZa0dVeGtZbkZjODJw?=
 =?utf-8?B?UHYwWXQ3UnhNeFFiSkEwQVRGdVRBRG55TzFYMW5pQm03RFhrc2lQVXV5anlU?=
 =?utf-8?B?aWZ0UG5jTENoUC9YVkhrNS9rVFNlcWlDVDdUUUloZm5pbE43WUI3RXVaTExN?=
 =?utf-8?B?ZWdnNlFDT1BpYU5LSkpsODR1MjZ2WkxNQWpCY0o3czVTZnJUQUdoTElKa0pL?=
 =?utf-8?B?U0N0SkU2bzFETTlqdTVjOC8rRm9kOUpoRnZST0Q2QVQxaCswOWpSV2J6dTVj?=
 =?utf-8?B?OGtKakdiOEU0Q01JWEpEdXFWSklTUFpISEFndjJqcmpTclRKV1ZBTUpqdERw?=
 =?utf-8?B?ZUx6NFUvaFlwcXhzNnRkRzVBTjFnWURZZG91aVRhM29HdnoxTDJjUXFKcC9p?=
 =?utf-8?B?eEtRSzhLVXZ1VXBHeUFXS29uQTdMVTNSNmxZcVM3SEF2QkdEKy9ZYlA3VElw?=
 =?utf-8?B?NlJYZlMxTTFKSVY3K1JIK2h1Mk9ub0h6TVBEVWhRZkw0SmQ2U1R6alV4eFF4?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90EEED77BA542347A98455477B70DB72@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d152648-be02-4c8d-b336-08dae4be8735
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 08:20:18.9240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Kub52pJ1urjmiYwlBCAMPtFGRMMJXhehEFad6zffHDRx9QFlHvwu2aj5fL73bSuaqmybqPvuoKbAr29fOCeaYgYFYGujTxsVzbMPzaxDv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5774
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTI3IGF0IDA5OjQyIC0wNDAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAyNC8xMC8yMDIyIDA1OjQyLCBHYXJtaW4uQ2hhbmcgd3JvdGU6DQo+ID4gQWRk
IHRoZSBuZXcgYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciBzeXN0ZW0gY2xvY2sNCj4gPiBhbmQg
ZnVuY3Rpb25hbCBjbG9jayBvbiBNZWRpYVRlayBNVDgxODguDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogR2FybWluLkNoYW5nIDxHYXJtaW4uQ2hhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICAuLi4vYXJtL21lZGlhdGVrL21lZGlhdGVrLG10ODE4OC1jbG9jay55YW1sICAgfCAgNzAg
KysNCj4gPiAgLi4uL21lZGlhdGVrL21lZGlhdGVrLG10ODE4OC1zeXMtY2xvY2sueWFtbCAgIHwg
IDU1ICsrDQo+ID4gIC4uLi9kdC1iaW5kaW5ncy9jbG9jay9tZWRpYXRlayxtdDgxODgtY2xrLmgg
ICB8IDczMw0KPiA+ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDg1
OCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTg4LQ0KPiA+
IGNsb2NrLnlhbWwNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtdDgxODgtc3lzLQ0KPiA+
IGNsb2NrLnlhbWwNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3Mv
Y2xvY2svbWVkaWF0ZWssbXQ4MTg4LWNsay5oDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxt
dDgxODgtDQo+ID4gY2xvY2sueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtdDgxODgtDQo+ID4gY2xvY2sueWFtbA0KPiA+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi40OWRjNjgxZTY2
MDENCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG10ODE4OC0NCj4gPiBjbG9jay55
YW1sDQo+ID4gQEAgLTAsMCArMSw3MCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4g
PiArJGlkOiANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRy
ZWUub3JnL3NjaGVtYXMvYXJtL21lZGlhdGVrL21lZGlhdGVrLG10ODE4OC1jbG9jay55YW1sKl9f
O0l3ISFDVFJOS0E5d01nMEFSYnchd1p6Tld6LXp4N2FRdDFtVFlUSy1FZlBFQ2xKYkNlX1cwbUVJ
Rlh3TzN5cXVxY1pwNlQ3X05wcXR2bkR1Q2NlVEFacyQNCj4gPiAgDQo+ID4gKyRzY2hlbWE6IA0K
PiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS1zY2hlbWFzL2NvcmUueWFtbCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IXdaek5Xei16eDdhUXQx
bVRZVEstRWZQRUNsSmJDZV9XMG1FSUZYd08zeXF1cWNacDZUN19OcHF0dm5EdUh1R1RrMFUkDQo+
ID4gIA0KPiA+ICsNCj4gPiArdGl0bGU6IE1lZGlhVGVrIEZ1bmN0aW9uYWwgQ2xvY2sgQ29udHJv
bGxlciBmb3IgTVQ4MTg4DQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEdhcm1p
biBDaGFuZyA8Z2FybWluLmNoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0
aW9uOiB8DQo+ID4gKyAgVGhlIGNsb2NrIGFyY2hpdGVjdHVyZSBpbiBNZWRpYVRlayBsaWtlIGJl
bG93DQo+ID4gKyAgUExMcyAtLT4NCj4gPiArICAgICAgICAgIGRpdmlkZXJzIC0tPg0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgbXV4ZXMNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLS0+DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrIGdhdGUNCj4g
PiArDQo+ID4gKyAgVGhlIGRldmljZXMgcHJvdmlkZSBjbG9jayBnYXRlIGNvbnRyb2wgaW4gZGlm
ZmVyZW50IElQIGJsb2Nrcy4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0
aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LWFkc3Bf
YXVkaW8yNm0NCj4gDQo+IE5vIHVuZGVyc2NvcmVzIGluIGNvbXBhdGlibGVzLg0KPiANCj4gPiAr
ICAgICAgLSBtZWRpYXRlayxtdDgxODgtaW1wX2lpY193cmFwX2MNCj4gPiArICAgICAgLSBtZWRp
YXRlayxtdDgxODgtaW1wX2lpY193cmFwX2VuDQo+ID4gKyAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4
LWltcF9paWNfd3JhcF93DQo+ID4gKyAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LW1mZ2NmZw0KPiA+
ICsgICAgICAtIG1lZGlhdGVrLG10ODE4OC12cHBzeXMwDQo+ID4gKyAgICAgIC0gbWVkaWF0ZWss
bXQ4MTg4LXdwZXN5cw0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE4OC13cGVzeXNfdnBwMA0K
PiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE4OC12cHBzeXMxDQo+ID4gKyAgICAgIC0gbWVkaWF0
ZWssbXQ4MTg4LWltZ3N5cw0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE4OC1pbWdzeXNfd3Bl
MQ0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE4OC1pbWdzeXNfd3BlMg0KPiA+ICsgICAgICAt
IG1lZGlhdGVrLG10ODE4OC1pbWdzeXNfd3BlMw0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE4
OC1pbWdzeXMxX2RpcF90b3ANCj4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxODgtaW1nc3lzMV9k
aXBfbnINCj4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxODgtaXBlc3lzDQo+ID4gKyAgICAgIC0g
bWVkaWF0ZWssbXQ4MTg4LWNhbXN5cw0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE4OC1jYW1z
eXNfcmF3YQ0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE4OC1jYW1zeXNfeXV2YQ0KPiA+ICsg
ICAgICAtIG1lZGlhdGVrLG10ODE4OC1jYW1zeXNfcmF3Yg0KPiA+ICsgICAgICAtIG1lZGlhdGVr
LG10ODE4OC1jYW1zeXNfeXV2Yg0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE4OC1jY3VzeXMN
Cj4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxODgtdmRlY3N5c19zb2MNCj4gPiArICAgICAgLSBt
ZWRpYXRlayxtdDgxODgtdmRlY3N5cw0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE4OC12ZW5j
c3lzDQo+IA0KPiBCbGFuayBsaW5lIGhlcmUNCj4gDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWF4
SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgJyNjbG9jay1jZWxscyc6DQo+ID4gKyAgICBjb25zdDog
MQ0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSBy
ZWcNCj4gPiArICAtICcjY2xvY2stY2VsbHMnDQo+ID4gKw0KPiA+ICthZGRpdGlvbmFsUHJvcGVy
dGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAg
aW1wX2lpY193cmFwX2M6IGNsb2NrLWNvbnRyb2xsZXJAMTEyODMwMDAgew0KPiANCj4gRHJvcCB0
aGUgbGFiZWwsIG5vdCB1c2VkLA0KPiANCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE4OC1pbXBfaWljX3dyYXBfYyI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4MTEyODMw
MDAgMHgxMDAwPjsNCj4gPiArICAgICAgICAjY2xvY2stY2VsbHMgPSA8MT47DQo+ID4gKyAgICB9
Ow0KPiA+ICsNCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG10ODE4OC0NCj4gPiBzeXMtY2xvY2sueWFt
bA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9t
ZWRpYXRlayxtdDgxODgtDQo+ID4gc3lzLWNsb2NrLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMzU5NjJiMzc0NmUxDQo+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ICsrKw0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9tZWRpYXRlay9tZWRpYXRlayxtdDgxODgtDQo+ID4gc3lzLWNsb2NrLnlhbWwNCj4gPiBAQCAt
MCwwICsxLDU1IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9S
IEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IA0KPiA+
IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1h
cy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTg4LXN5cy1jbG9jay55YW1sKl9fO0l3ISFDVFJO
S0E5d01nMEFSYnchd1p6Tld6LXp4N2FRdDFtVFlUSy1FZlBFQ2xKYkNlX1cwbUVJRlh3TzN5cXVx
Y1pwNlQ3X05wcXR2bkR1Nlc4OE9xayQNCj4gPiAgDQo+ID4gKyRzY2hlbWE6IA0KPiA+IGh0dHBz
Oi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFz
L2NvcmUueWFtbCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IXdaek5Xei16eDdhUXQxbVRZVEstRWZQ
RUNsSmJDZV9XMG1FSUZYd08zeXF1cWNacDZUN19OcHF0dm5EdUh1R1RrMFUkDQo+ID4gIA0KPiA+
ICsNCj4gPiArdGl0bGU6IE1lZGlhVGVrIFN5c3RlbSBDbG9jayBDb250cm9sbGVyIGZvciBNVDgx
ODgNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gR2FybWluIENoYW5nIDxnYXJt
aW4uY2hhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4gPiAr
ICBUaGUgY2xvY2sgYXJjaGl0ZWN0dXJlIGluIE1lZGlhVGVrIGxpa2UgYmVsb3cNCj4gPiArICBQ
TExzIC0tPg0KPiA+ICsgICAgICAgICAgZGl2aWRlcnMgLS0+DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICBtdXhlcw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAtLT4NCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2sgZ2F0ZQ0KPiA+ICsNCj4gPiArICBU
aGUgYXBtaXhlZHN5cyBwcm92aWRlcyBtb3N0IG9mIFBMTHMgd2hpY2ggZ2VuZXJhdGVkIGZyb20g
U29DDQo+ID4gMjZtLg0KPiA+ICsgIFRoZSB0b3Bja2dlbiBwcm92aWRlcyBkaXZpZGVycyBhbmQg
bXV4ZXMgd2hpY2ggcHJvdmlkZSB0aGUgY2xvY2sNCj4gPiBzb3VyY2UgdG8gb3RoZXIgSVAgYmxv
Y2tzLg0KPiA+ICsgIFRoZSBpbmZyYWNmZ19hbyBwcm92aWRlcyBjbG9jayBnYXRlIGluIHBlcmlw
aGVyYWwgYW5kDQo+ID4gaW5mcmFzdHJ1Y3R1cmUgSVAgYmxvY2tzLg0KPiA+ICsgIFRoZSBtY3Vz
eXMgcHJvdmlkZXMgbXV4IGNvbnRyb2wgdG8gc2VsZWN0IHRoZSBjbG9jayBzb3VyY2UgaW4gQVAN
Cj4gPiBNQ1UuDQo+ID4gKyAgVGhlIGRldmljZSBub2RlcyBhbHNvIHByb3ZpZGUgdGhlIHN5c3Rl
bSBjb250cm9sIGNhcGFjaXR5IGZvcg0KPiA+IGNvbmZpZ3VyYXRpb24uDQo+ID4gKw0KPiA+ICtw
cm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAg
ICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtdG9wY2tnZW4NCj4g
PiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LWluZnJhY2ZnX2FvDQo+IA0KPiBTYW1lIGNv
bW1lbnQuDQo+IA0KPiA+ICsgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtYXBtaXhlZHN5cw0K
PiA+ICsgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtcGVyaWNmZ19hbw0KPiA+ICsgICAgICAt
IGNvbnN0OiBzeXNjb24NCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWF4SXRlbXM6IDEN
Cj4gPiArDQo+ID4gKyAgJyNjbG9jay1jZWxscyc6DQo+ID4gKyAgICBjb25zdDogMQ0KPiA+ICsN
Cj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiAr
ICAtICcjY2xvY2stY2VsbHMnDQo+ID4gKw0KPiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFs
c2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgdG9wY2tnZW46
IHN5c2NvbkAxMDAwMDAwMCB7DQo+IA0KPiBEcm9wIGxhYmVsLg0KPiANCj4gPiArICAgICAgICBj
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC10b3Bja2dlbiIsICJzeXNjb24iOw0KPiA+ICsg
ICAgICAgIHJlZyA9IDwweDEwMDAwMDAwIDB4MTAwMD47DQo+ID4gKyAgICAgICAgI2Nsb2NrLWNl
bGxzID0gPDE+Ow0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCiAgVGhh
bmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb25zLg0KDQogIEkgd2lsbCBtb2RpZnkgdW5kZXJzY29y
ZXMgaW4gY29tcGF0aWJsZXMsIGFkZCBibGFuayBsaW5lIGFuZCBkcm9wICAgIA0KICBsYWJlbC4N
Cg0KPiBUaGFua3MsDQo+IEJlc3QgUmVnYXJkcywNCj4gR2FybWluDQo=
