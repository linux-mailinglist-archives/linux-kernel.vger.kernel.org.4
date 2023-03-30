Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7286CF8E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjC3ByL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjC3ByI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:54:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C441BC;
        Wed, 29 Mar 2023 18:54:07 -0700 (PDT)
X-UUID: be2d00aece9d11eda9a90f0bb45854f4-20230330
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=X0rIrLeaYvz73wbIa7DiRsH+NgQJFDzezalvlyWfPnY=;
        b=R1jdY6M3sXnwk5/8EvV7A1k5tyv/sgjNN5RQEEyaMCWvZDTYQbRdhYY52Sddsp4FE7Y3I86afzJgcGNhEZWZ8QOHb8ZQPYKBBZujl9RbQaMIY5V9T1HiCMfW0EpGpEjRZ16qUNCabBacrThApxAg9ec8pUd6s2qhkAGnPq9cv4w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8fdaf0ff-2c0b-4a56-8654-d2fe0bf15d40,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:8fdaf0ff-2c0b-4a56-8654-d2fe0bf15d40,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:40cf56f7-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230329184115KMUUBW9Q,BulkQuantity:8,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: be2d00aece9d11eda9a90f0bb45854f4-20230330
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 137735637; Thu, 30 Mar 2023 09:54:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 30 Mar 2023 09:54:00 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 30 Mar 2023 09:54:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIsYxdUNwng0inpZN4XHrSgMagkHSuHYmnKfhRPtBA8ny9/YL41QhiVzQEFbU09w1CxdWNEns4uQ8LM1uOuV8AknuNAbwuoWwSiDhcaQU+tWkaefqSSJsQvSYGSEHTFMwBV5cIDZ8qITl/uj4H3bcLmv8mrmxzDkgxKS/UBBGxMQFeVaJxK727TF/+2y8FfLOJ7cKYfosc8DfqvKjeB/xuv9/eI00tVV7YiMOFLzxNU45rMah7WJ19wxxGZU/GNbL5WFhvs/E1hSejny1oUvOd8Q4uub1p2t11kHLe2JdjWvJNct82gHGvma90i/zYlTibTqtOqiAwn/MERtOmUbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0rIrLeaYvz73wbIa7DiRsH+NgQJFDzezalvlyWfPnY=;
 b=Yi58Zb/4gQmU3Ze8TjxSmraeFjYhWEjWkpwiePSlkyFTqYIHLdmdKW36vMhD78QExtH351lldHp8Jr/r5y7M6JQ27vFtT8/j0XSZKmqQTkLgxFYHjLkWT4oHhsWV5pVezRJT6cpjDyHgVwjiYVBQw7W+JfXRHA3by4/CdbTKfTZTTvkl3n79Un1QCKHcof5q5sab02ehwkF+/7cscjHTQQ1D3Pc2b6sfi+F3SA47A9BcZkfYK6a25Kr77Bs+iT1lQghY+nUX8PDg7e5KqO/UgDNrZJSOLNxtZcRx3BKmlK1uvTWZXBCHrNeVeBDTOhCBa6OQH52u6aljcal1EnaJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0rIrLeaYvz73wbIa7DiRsH+NgQJFDzezalvlyWfPnY=;
 b=Uo8gGU2yjet37jkEOfV6VXBhyGDtutZ73/hRk9LIVUIU817jbz7i3wDxlQNEifcZOMhAKhrk0iXpZvb4A8G3zpYd+m5JeVw4Sfx4Iragl+c72VPdnW8i1+MEue/3oBgZTT93TpoxJn7IL1PRg0AT4ldrYmxTQ50NGq1DPP0Iz+4=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SI2PR03MB5942.apcprd03.prod.outlook.com (2603:1096:4:146::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Thu, 30 Mar 2023 01:53:57 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1%5]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 01:53:57 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH RESEND 1/6] dt-bindings: memory-controllers:
 mediatek,smi-common: add mt8365
Thread-Topic: [PATCH RESEND 1/6] dt-bindings: memory-controllers:
 mediatek,smi-common: add mt8365
Thread-Index: AQHZYiRilY8rMZXKrkWBLuSDiOmXHq8SkK+A
Date:   Thu, 30 Mar 2023 01:53:57 +0000
Message-ID: <488d226a8a66bc6f5b96063b2816b59dd065ad3f.camel@mediatek.com>
References: <20230207-iommu-support-v1-0-4a902f9aa412@baylibre.com>
         <20230207-iommu-support-v1-1-4a902f9aa412@baylibre.com>
In-Reply-To: <20230207-iommu-support-v1-1-4a902f9aa412@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SI2PR03MB5942:EE_
x-ms-office365-filtering-correlation-id: 6b4565ea-6b90-4eb0-240b-08db30c19ff0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: grD8LDDz3X8SEmWtnnVVp5PK1ZZdZxpAivIog76u3QxJJzZGH/sNNA85AmLpitd27UVDvcbyEmu99+jB3IQncxmDFp2wsK7lpmmmv5GDTJVMaj+ZAeJo6dpDdPVEXU6jLtU3AxjFgE50HPASLghkLRyhbthpJqDiM0fUVFTVbAjzF0x70cpRpjCdjBm8IgkcGnlQEPh5sjsjju1Kwcg7Bg2+QDMZPDeO6GjPIIGSdv893/VQsP4F6H1V2E/cMEux4YM6UPpKvtmlJHWOmozK5z4szNcerL67gWMRvIDPiHOD8dpM8zuVCURIUZK8Cd6NZxv6FemeybE2FxLUD3KLklCYzX7x6W7J7y7kpOXCBjfUUMIMuWMCHHY0i72FuWrh/HYGo88XkV2ZCuvoDQZdnUNZ2CNlCzKPGzpLyaCT2e0SqPXcS4KaqOoEcAm7NdVPVXO9SSBMoQtGi4IKiCguXLbYQ4K1q+vHm5FsiUBoMiIyCLmqrtrpYRWmaGgJzU00NnzOEMIilapfrrMfHFW4MmVn4+aKKJgn9OzI5NYC8XQV6pelS1yuO+iSXcNjWFysbGekBlTIuyfdOdnLS7l+FFOJcSPMwRqRF995CBQ/leibPWf7OSG7DKNyqI/4y8x4zzdXdblg40qov/e+uuEeu3BJt5p05MjbRdOlV9Wc9stTNksWkBXJ/1s6/wGZiUre
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(41300700001)(64756008)(66446008)(76116006)(91956017)(8676002)(4326008)(66556008)(186003)(66946007)(66476007)(6486002)(7416002)(71200400001)(5660300002)(122000001)(36756003)(6512007)(6506007)(86362001)(2906002)(38100700002)(26005)(8936002)(110136005)(85182001)(38070700005)(2616005)(316002)(54906003)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnRPL0tRVmYxRU5xMnpyc1VROTVvbS9wRHh4VURmUmVHYWc1T3hLKzJraTkx?=
 =?utf-8?B?OVdaYit6VWpyd2w5b2p2R0h3MlVBci9SdjZmVTIzMzU3QUNkcmdsOTQzRVZ3?=
 =?utf-8?B?UEN0aWkxbzZUN3VkM2FGRENPZ1g0cmlnKzUzd3pLNUhDemhlNGJ3SWx5UUhI?=
 =?utf-8?B?VTdwUmZJYmFlYnFqdFlUd1kydTRhSzd1THBpR2liek9sT2UveUpUUEV3U0po?=
 =?utf-8?B?VWtDVkd1eUtsNHk1dGNqV1Jod3ZuZ3RJSzVaOFc2RS8xK3AzUzVyVWZmZ283?=
 =?utf-8?B?SW9kUVI5VzZZdXNvRTZZWVU5SW5qSTA3UmkyYW92QXBPWDB3a3NrZlhWcGh6?=
 =?utf-8?B?NTRVLzhXdWdMTG0wczRhTEVWVDhuaHkwWTQ3Q3Zkb2xod1BVOHo3V0lOUGVu?=
 =?utf-8?B?MUhUSjA3RlM1aTIvL3U5WjhzZUFPY3N3UDRvalhFKzZJYmpuRTU2ZVE3eXlX?=
 =?utf-8?B?cks5alR2UUE4U21CV252b2xsWGFLK1pJV0ZYa0t1V2ZFdWFnRUprWFpwNEF2?=
 =?utf-8?B?bkhRbzBGemhXaXFBc1o3UVZrNnIrODI0MzdwVUNNeG1ucXY4N1A5MjBGYWs5?=
 =?utf-8?B?WkRxb1lDZWpjS081ZWtnN3dHeHdEZ2pvNUpSbFNEbG0wVzVOQXpLTUxHSHhl?=
 =?utf-8?B?bGVQSVVMVXFlRXdiYUppRHRGUHRyMElPUnY5b1JWOTU3aUd4c2w5ZnVjc2du?=
 =?utf-8?B?bE9nWE9XYzRaNDlCTFdDU1hEZGhpb1I5YzJBc0U5Rks0VEIyS05tK1JrY2VR?=
 =?utf-8?B?V3J4Z2g1QkZkQnc4akZiWUhVV1JPN2MrNzlja2JqUzkwY2ZQMHdwZytxMFZy?=
 =?utf-8?B?MTNGVUE4NEZUTnpZL0x5ckh0b2puZWhBaWRzN3RVeGNKanRTUTV4ZzZ2eGNp?=
 =?utf-8?B?d0Z1ams1R1BiMGhtdDRidjZsVTFxY3R1dXRmencwMTVxNG82UWdJVFF1bzNx?=
 =?utf-8?B?RitzSVk3b1EvSlN4V25HNlpZdFFIZlpqM0tSOFZIYjFFZ2FBN2VtZnBiSUNq?=
 =?utf-8?B?aDNpejN0cEJUS2dzWDA4UTlpcGx3Z2ZOVWFubmFpUFMxVlZSdXM1OTBFbjE0?=
 =?utf-8?B?OGpDR041YmpEVStNRDdMdDhhNTJNRVFnQXJFTkswaFhjRnBlQm5oUG91eXpX?=
 =?utf-8?B?UDIxN1hhVEt6UnRvVzdCS28zM0p0a25WbDQyZ2JHQklqTlk5eWJBY2swSkcx?=
 =?utf-8?B?OUdsb1N3a09KQmNmNHNxL3R4YzN3aEN4aS9nb2M4dzhXVWwrdjhZN0FGODZl?=
 =?utf-8?B?U1dpYnRwMVBCNkp1S3k4VU84Y2NTZEYxZ0lQUXFWN05ZQW5KNldkbEx3cmli?=
 =?utf-8?B?SkxycFNMMHNVV2VmcnZMTXRpUmRQYm8yWFlxVndwdjRDNVJadldqd0lNbmJz?=
 =?utf-8?B?dlhwZThWbGVLYmZXbVNoa3QwSzV4QTNjejFJbDFrZXh4WjFYWmNneXVXb3RB?=
 =?utf-8?B?MUJvNUdRdDFvRnk1NkxwbjBVd2xVV3FUcGdoQjBXZTNKS1M2VVQ1YTNNMG41?=
 =?utf-8?B?UVB4TlJ1TkZkK3ZvVlRPV0JtSTBUcG92YTZ4QTBhOHBiVnd5NktQdjhoblpr?=
 =?utf-8?B?NUNGbjJTLzQzSHY4MXdLSXEyKys1ZVFlbjJXMmNrQW1Wam1JTkFSZ0l6Q1Fs?=
 =?utf-8?B?UU9iYlFMUDNpRG5aUTRhaW8wQ1BFais2VE1YekV3NVJ3S3ZHU2FaRXVMcHlQ?=
 =?utf-8?B?MkFaVXNobGpJcFFCRHc5V0d4TWRBNndUOENaRHMzN2VyYjF5TmVDbC9ETFhY?=
 =?utf-8?B?TTdOL0FnZEVTZHpoUkNZd0tJVGtFUkp6ZTg1VTlCVmZTcDlVMThBSjJ3bFc3?=
 =?utf-8?B?MGovMWV1UWZrS2szZm45OXN0MmNvUlJ1ZHVYL2ZIdnN6N0hnSUxPdGd2OWNt?=
 =?utf-8?B?a3Vhbytlb1htYmZqZ1hCK1pkS2JiRmFRVFZVbGhKVVNQZWhwcStVQ1NhemJj?=
 =?utf-8?B?SE9hQVMxRllMRGlwTlBYZG1BcFF3ZzdnWVdpcVRkVTJvZ2x2em9IdlhydEhZ?=
 =?utf-8?B?Z2h1QU1VeEthNWI5NjhBUkp0a3pNWWVUS3Iyd3Z4aWozNSs2cDdZeVh2L3Zs?=
 =?utf-8?B?UXRMR0YrbTh0eEVMUGltQS95NEhjQVpFcXZibEZxakZ2QkFzTC9sdUdtWE50?=
 =?utf-8?B?ZVJWZUE4aW1nK2laZ2FsSDhOV2JaSjhSN2dMVzk5aWdyQXFZNnVCakRsRXFt?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F568D02D9E19A44ABF86AD5A1C0193D5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4565ea-6b90-4eb0-240b-08db30c19ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 01:53:57.2954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPczWzoVGwEOhHwf+BhDuveuSnkuWcQYfb10W1deohjZQoYXcTBuascLIRUztiwefpVFu+CxNqqD3CACBNqe5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5942
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

T24gV2VkLCAyMDIzLTAzLTI5IGF0IDExOjUyICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gDQo+IEFkZCBiaW5kaW5nIGRlc2NyaXB0aW9uIGZvciBtZWRpYXRlayxtdDgzNjUtc21p
LWNvbW1vbg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0
QGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnkt
Y29udHJvbGxlcnMvbWVkaWF0ZWssc21pLQ0KPiBjb21tb24ueWFtbCAgIHwgNCArKysrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS0NCj4gY29udHJvbGxlcnMvbWVkaWF0
ZWssc21pLWNvbW1vbi55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktDQo+IGNvbW1vbi55YW1sDQo+IGluZGV4
IGE4ZmRhMzBjY2NiYi4uZDU5OWExOTA5NTJmIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LQ0KPiBjb250cm9sbGVycy9tZWRpYXRlayxzbWkt
Y29tbW9uLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21l
bW9yeS0NCj4gY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi55YW1sDQo+IEBAIC00OSw2
ICs0OSwxMCBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10
NzYyMy1zbWktY29tbW9uDQo+ICAgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLXNt
aS1jb21tb24NCj4gDQo+ICsgICAgICAtIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29uc3Q6IG1l
ZGlhdGVrLG10ODM2NS1zbWktY29tbW9uDQo+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWss
bXQ4MTg2LXNtaS1jb21tb24NCj4gKw0KDQptdDgzNjUgaXMgbm90IHNhbWUgd2l0aCBtdDgxODYu
DQoNCkZyb20gdGhlIGNvZGUsIHRoZSBidXNfc2VsIGZvciBtdDgxODYgaXM6DQouYnVzX3NlbCAg
PSBGX01NVTFfTEFSQigxKSB8IEZfTU1VMV9MQVJCKDQpIHwgRl9NTVUxX0xBUkIoNyksDQoNCnRo
ZSBidXNfc2VsIGZvciBtdDgzNjUgaXM6DQouYnVzX3NlbCAgPSBGX01NVTFfTEFSQigyKSB8IEZf
TU1VMV9MQVJCKDQpLA0KDQpJIGd1ZXNzIHdlIHNob3VsZCBhZGQgYSBpbmRlcGVuZGVudCAibWVk
aWF0ZWssbXQ4MzY1LXNtaS1jb21tb24iLg0KDQo+ICAgIHJlZzoNCj4gICAgICBtYXhJdGVtczog
MQ0KPiANCj4gDQo+IC0tDQo+IDIuMjUuMQ0KPiANCg==
