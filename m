Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FE861E16F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKFJxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKFJxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:53:46 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7DBEE31;
        Sun,  6 Nov 2022 01:53:38 -0800 (PST)
X-UUID: fa9ab583784a45358557b7f50f11c7e9-20221106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eGkiiX6xG1kjJiX8DiKEV/TzBGy0N8U88s/VBszc5DM=;
        b=V2WJYwVuNw9DHEs0Is31xRBjzBqdsOrjClIGREeQenhS2Bi1TR6eNe+hlKZZPGX9W/KNtdQvL/n4+xjSX2mkB7ir+y5CPb3k2fvagNYPPzvGOWN/8k3CalH0MrJhHepprYb95P2OWgT4cJNCB6ibnaRuxwNxj6m2d5f73sBFt0Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:30af1c8c-933a-4b7a-90a2-95b2bd1901f5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:a4c48eeb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: fa9ab583784a45358557b7f50f11c7e9-20221106
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <mengqi.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 459553310; Sun, 06 Nov 2022 17:53:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 6 Nov 2022 17:53:32 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sun, 6 Nov 2022 17:53:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFRvT2ot2hZ7L7SxJOwS+Yk8yuIJPo852F86Fu/qbhSoNEX4c3brafwlz8aWPUioFLVRpPSTUSTFKC90pUHjaDUg19x7nNTImCPd4qVeFY2V6zIWTktfHC4OCUAoSYdqSveaVZqndgizPVUeuGQc0zMFizZX5tqQ3cNddxm40XNY4qZMAQEGBlWVd1GFIbYM9H6hWBmOCMBLqCy9KSlP5RsfJoVRr4vuATtGcQsBy2a34mpMs0spoqp1aNx3My5FSF7o3Tbaz8eViWdqgYfI2qK5q4Od4NAGe0nvrSlPVxrjb8JzjieNH8GL5ca3p16BrEuR82mQdikOmk01YMzq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGkiiX6xG1kjJiX8DiKEV/TzBGy0N8U88s/VBszc5DM=;
 b=S5kvDGb2Dqc0RCuU3AFaAHPBWx3u1iKWU4VVdjeK8qrhqy4h5/S6jGCBf7stepKkBOB8a1FlQ3BHaBlathb7cNfJXWAsjAk8sWToLLDsUKr3BwwV/XJqdplZDct8hmxfP7mIbFq2MWanUvVRrgOmsDFi2Pq2hPC5DK3SnhyNb9Ucijxai/a3HSdN19r2cT3G4Q9lFr1cKpiRFVcATYbNfDbJiZj4MZEnrGcoqT90zg5byIGOw1/jxXpaVf/NfDlSn9GSgFH5Df5iJZ2n6SZTg9PD9Km66UczldIqVZflobEw3Dkkrv4dfoLRxoBl0cW6hbRNqUtkxQgVj36hvPHowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGkiiX6xG1kjJiX8DiKEV/TzBGy0N8U88s/VBszc5DM=;
 b=MN84beWro/+htB97TTjGx0sLUKh2eD+qSbxVYmW87DzBaMaPD+d414AhTKQJcDwSSiDrNEzs5Q/ePdQaFNUpUzw/8Vdbf1X2xr5uUtoNdMcOYDy0yr3w/7/jkqmn/Z1QDrvYRF6fzwThB6McnB0vSLTUKn5gDTJXijaCAR06HKA=
Received: from SG2PR03MB6261.apcprd03.prod.outlook.com (2603:1096:4:175::12)
 by KL1PR03MB5919.apcprd03.prod.outlook.com (2603:1096:820:88::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Sun, 6 Nov
 2022 09:53:31 +0000
Received: from SG2PR03MB6261.apcprd03.prod.outlook.com
 ([fe80::b993:c60:a25e:5707]) by SG2PR03MB6261.apcprd03.prod.outlook.com
 ([fe80::b993:c60:a25e:5707%2]) with mapi id 15.20.5791.025; Sun, 6 Nov 2022
 09:53:30 +0000
From:   =?utf-8?B?TWVuZ3FpIFpoYW5nICjlvKDmoqbnkKYp?= 
        <Mengqi.Zhang@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bingdings: mmc: Mediatek: add ICE clock
Thread-Topic: [PATCH 2/2] dt-bingdings: mmc: Mediatek: add ICE clock
Thread-Index: AQHY4jOUgyH6+5+WtkSOcn+enm8V6a4T6beAgB3dIQA=
Date:   Sun, 6 Nov 2022 09:53:30 +0000
Message-ID: <dcf68e23266c8cd71c867e7ee632f74991e3261c.camel@mediatek.com>
References: <20221017142007.5408-1-mengqi.zhang@mediatek.com>
         <20221017142007.5408-3-mengqi.zhang@mediatek.com>
         <92af9496-b622-9234-d89c-d478b4c77d62@collabora.com>
In-Reply-To: <92af9496-b622-9234-d89c-d478b4c77d62@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6261:EE_|KL1PR03MB5919:EE_
x-ms-office365-filtering-correlation-id: 4f359fd7-a18c-4478-1837-08dabfdcc2be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UsDEPD2KEFnBUArAVnGuPqgQ6biD0QfSzk5UrFQISp74UjF/RoA6OsWvM8ogafW+YrCCpK/XKG7/SE1W0GVbj6rI9lmXgD+Rw3kWbJa103FnPHoF3YJT/F5ZYn0QvcOAWmoidVO3jIs3jRCpvbSdLakkymTsvPuderg9Dh7ZMMYuR8SwwbsT/2KMSN6D/Pq8mo4p4PFhRNf8s8G4uwJmTtXcL/gKOIs2cV+pjU10p62WR3vrxqUK4eQ1xj/3v1r0e3cAQ4IveNTSlgRnb+Zs90pWF5nZDQYZJY0uDWrhoojW3pIy7PeqQgGCVq2SQSjRoBy3pcGhJf4uz4imB6oP0zzAX2vUSFLyOu9+hyO0t4rKNFU07TYRNbKyoftFuht89rmtUVLFJR/hqYhbUyPIoZots2gCHD+0E80oKwWPJogY5SQI5SBoMp9q7j+S2UR27wSrMh403v15jQH66BssfvkmXKgZdwIwx40epDWaMgnzIfmFZT6OkH1dY8TZ0BdJmHua58pLbweT708tc8ArLwsH5Dw3jk37kdsowMoNy827rkbL8JUXqtu76eyzwyrck1IViccn9Uvubph3tyf75Zmm3bwEmTyWfWAFhhHSkGpvC9jr6cT3izawmxsTpW7qQkfSWY5hAufeYT7d/x0fRuOyeUbP28MEmG5WJFt6ZqQq7ArcKG9KsIgZL7XTmh65GNjpW0QMLR/BByxmBwzuw79DnxtRfCP2Lzn4CePluKM9JtreOjXLatzQZ2blnh3gPZw06KJuxZtUJrHDHvAoLBCo/mUrSMkjaHMrN4t6DOSEC5ffX7+Z8ysvoeosYTrWSl+YenAayj0cH5WnI3REG3o71HNjyhDdlqwKX7n+EFI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6261.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39850400004)(366004)(376002)(396003)(346002)(451199015)(66446008)(64756008)(66476007)(66556008)(86362001)(8676002)(4326008)(7416002)(4744005)(41300700001)(5660300002)(66946007)(76116006)(110136005)(54906003)(8936002)(71200400001)(186003)(122000001)(83380400001)(2906002)(966005)(6486002)(4001150100001)(478600001)(2616005)(38100700002)(316002)(38070700005)(6512007)(26005)(36756003)(6506007)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anVYM1IzdVVNSmlXbnlYTGRjekZyd3dDb0FuQWJZSG81Zko2WDhQU3QvN0NC?=
 =?utf-8?B?RXBhOEQvUzlEODFFTHZPR0lDbHA4YnRYa3c5OStYVjgwa0RQNW9vSllGelJD?=
 =?utf-8?B?bHovWjdwVjRvSmZHcjk5UFMweEJVLzBhd0o2Zk1QWGZ6SlRtWEpLTVY1UmM3?=
 =?utf-8?B?cVB5d1FWbGhqbmtqVVVaU28rZnB1QXcyOTJvbXZWc1NqQ0gyTnRnZ2oxZlVq?=
 =?utf-8?B?bE9OcWhKYXJjMEx5eDRmNXFZRlNmWVNHYXYyaEJMOFNNUGljSzBwR1ZXRy9G?=
 =?utf-8?B?emlteXNiS0dtRnNjaExEcXV2Ukk2TTFGK1QzbmZ6VUVqSDZRcUdMR203UWNm?=
 =?utf-8?B?NDRDV2Y3cllaMFo3ZC8zMnU1WFNTMVNZOHJRYzhNNjBOa0RvY01qQXBKMGpZ?=
 =?utf-8?B?NHpFU252NjBlbUtWTExwL3lxOC91Mm1iOTBKWmFldWFIOFR6K0ZlcTdXMjBB?=
 =?utf-8?B?N25yQzhTalAyamlPMmJLMGVjYmY3NnZNZTJsZXJhNXJYb2pOcFM5WGs0LzFH?=
 =?utf-8?B?RVBEalNmdW9LT0hGa1FiajY5R0tQd052OTA4amFrUDJaclR4MHBiQXpoU05T?=
 =?utf-8?B?elpuWDVKbW9DU2VYS3RiRXRXcy8zZ2RneDRFeXcrRUxUcFVQTUlxR3N6VHF1?=
 =?utf-8?B?UE9FaFQwbFQ2UVRZeXpzdWk2NlNkdjMvWGpXbFRjQ1ZneC9JSFJ0M0FPdG5L?=
 =?utf-8?B?TW5wMSt5R0FyRTNZUFhBcWcyMi9yK0pidWxTU3Y3WXhjZjZma2tUak4rMkRy?=
 =?utf-8?B?TjNvSTJDQm44Sk00dVRwSGlqZm5kaTNINjZmRUFYU1lNSDR4ZkV2T0ZjbTJZ?=
 =?utf-8?B?dmlEcnl2Ym5FZ3VNU1dDTnZtVzY3YnRCTDRsazl4WlRMNmRwMWN5cy96NzRr?=
 =?utf-8?B?QVprOGtVU1JaSWIzeFAzeVIyMG5ySmJMOU5ZZDFOeGJhNzV0TjhQYThWdjVr?=
 =?utf-8?B?NnExUERnaERLdlhSUVJCU0d1VnVrYXZTMldpZlBvaG51MHg3TmhQUTVySWlG?=
 =?utf-8?B?UzlxWnhNNllpTDEyUWlodHRaMG1Jd3YvQ25IUG5scGwwb01LUEhwMzhVcjhi?=
 =?utf-8?B?aXVXVWx5NnJkZXdkdm00d3NyUWp1MGQvZ01Va3dwOWVhOGVJaUdXVWRTcWs2?=
 =?utf-8?B?SC9rZzMxMFgwd2VPLzBGZ1dzdUtiSU5TcU9tYXdUbENJKzNLWDRPZ1JzL09m?=
 =?utf-8?B?bUtDelN6OFpkT2ZoT0U0WTZqaHUyS2kwcHRQMmh6L2M2QWZJZGwxNEtwZStY?=
 =?utf-8?B?M1FJaVFRNFZ4YzcxNXd5QkVGUTByMXRuSlBnYlhQRUtIS3kxdUZhZnZzcWl2?=
 =?utf-8?B?VkJvdXhCaE5hTWpSM1NvZENrUkVLcGNnenIycWt1TFpxZTExUjFQemhqMEtJ?=
 =?utf-8?B?WFNwOGlNdUlRRmVxQmt0S1NoSHU2bzN2b1Jhck1wbG13ZDBnZW1PS1hzbEUv?=
 =?utf-8?B?VVV0eHFtUmtieG1XTSt3Zno1VHFmL3l3dmRIcU1IOEszbVgrUzhPQTc1MGNJ?=
 =?utf-8?B?N2YvSEZIamNrQ1ZSZ3FqSzVQejMzR2tmc1lNVkxWVkhBSmhkWEd3YU9oN05T?=
 =?utf-8?B?UHFWQ21EcGNzOWhaWk5qWTUrVFBOL1VEVXNMNW1IRnh1dEJOOFpiNkFjMXVz?=
 =?utf-8?B?TUU2akcxRE9VRFQyMTRxZHBSSnVsZHp1Z1dvUFZDem4rQnVzczlRVDRVVU1v?=
 =?utf-8?B?Sm4vNEVvMmtoTTNQS2xCbHgzUTg0ZUZsRUJ6Y3kyU2c4RGdqNjJvbFhyVXBq?=
 =?utf-8?B?M1I5QzlGYm8wZ0RWb1lLQkxRS0RwMmNISFBqZnNYQzhtNnZ1dnUvNDF1SktM?=
 =?utf-8?B?cnBZSnFpTEN2VjBQM2oxaExPazlIS3pDeE4reVVBbVdxUElqKzJWYS9tTWpV?=
 =?utf-8?B?UWpXeW93NzJZR3BaR0dOcmFpRXQwU3dtSFNBRlBERk5UNkdmVFV5d2Jwa0JJ?=
 =?utf-8?B?RG9ESXZGbTlNeExyNGRKZGg5bzNlOW9GbFFyL0ppR210UXNiRlljV3Nad3d4?=
 =?utf-8?B?S3Y3aGxTVlY2UWZxWGV6azUwZ3htaFdHWkhjU0VOZytHWW12TnRMWVhGZHh1?=
 =?utf-8?B?RzBra1B1ZHJWSzF0SkhBR3Vob0NaQ0szSW14aGZQUU5DNFBYcnpmcElsSFh0?=
 =?utf-8?B?anZrUkNzN0FST2l1NDRPMG1UL0VQVExOb3NHREFoMEVpQ1E3MGtiTWwyQjd0?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AE5AB4F9B75EF4EBDA5D5906DB01C15@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6261.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f359fd7-a18c-4478-1837-08dabfdcc2be
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2022 09:53:30.6826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smM9hc4aAvC+IKaYIlLrRrNIoqw0sedkZvguIcK8gnEEUiAJ39Jpt4LTnXPte7MXe0CknQ/pQYJAYUhyOC+dM3CIq150gwmJ0Jq900rpUv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5919
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTE4IGF0IDExOjUwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTcvMTAvMjIgMTY6MjAsIE1lbmdxaSBaaGFuZyBoYSBzY3JpdHRv
Og0KPiA+IERvY3VtZW50IHRoZSBiaW5kaW5nIGZvciBjcnlwdG8gY2xvY2sgb2YgdGhlIElubGlu
ZSBDcnlwdG8gRW5naW5lDQo+ID4gb2YgTWVkaWF0ZWsgU29Dcy4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNZW5ncWkgWmhhbmcgPG1lbmdxaS56aGFuZ0BtZWRpYXRlay5jb20+DQo+IA0KPiBM
b29rcyBnb29kLCBidXQgcGxlYXNlIGZpeCB0aGUgdHlwbyBpbiB0aGUgY29tbWl0IHRpdGxlLg0K
PiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KDQpIaSBBbmdlbG8sDQpJIGhhdmUgcmUtc2Vu
dCBteSBwYXRjaCBiYXNlIG9uIG5ldyBjb2RlIGJhc2UuDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LW1tYy8yMDIyMTEwNjAzMzkyNC45ODU0LTMtbWVuZ3FpLnpoYW5nQG1lZGlhdGVr
LmNvbS8NClBsZWFzZSBoZWxwIHRvIHJldmlldy4NClRoYW5rcyENCg0KUmVnYXJkcywNCk1lbmdx
aQ0K
