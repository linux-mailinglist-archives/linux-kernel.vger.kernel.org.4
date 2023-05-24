Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADC770EB1E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbjEXCKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjEXCKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:10:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC75913E;
        Tue, 23 May 2023 19:09:56 -0700 (PDT)
X-UUID: 0fddf4c0f9d811ed9cb5633481061a41-20230524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kcxvnkHvUfCMLwLZwI/wZRXPXm8mchTdFUEtpbZK5ZM=;
        b=I6HvpBMIgd75JFoNnaPen92Yln4UdSBkWBMwpTPh/kMXHQaoUp1yEKscf4PKA868fOARZ+gni6XbMQckwerxAlubn2La7kYhJEporEhLR55539ijdP1Hyn1M4CpfQwS+3CoThzwayQGGaO2Qzp66GVwDFZgtYDZ7XsboFJAjkeA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:3e4632d7-c55f-42d6-9e3c-1860ac9cb272,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:3e4632d7-c55f-42d6-9e3c-1860ac9cb272,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:36ad263c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:2305232222386YBA74BH,BulkQuantity:6,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 0fddf4c0f9d811ed9cb5633481061a41-20230524
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1935736931; Wed, 24 May 2023 10:09:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 May 2023 10:09:48 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 May 2023 10:09:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiTlj0lque27Yi9GvqwjERvOFFv/ZxdOkX5m8rixvK1iOmIIvbsWGyFk3kGwdyNQ/ibS88O1z10TuVlH0sc8e6R98BqBaHJp5a//0+B5Mms4bxdD3w3xC/eM3KEKHBs7LfZclMqfvYuIC9D9r6zd9mallTy/ZZqvnjC5G9c1hA44H9OGsQADCNi5RuwUx47zrxJs+ej3Dj3zsKw2ixGF7Y7Bdc1wW2IKytWyzevCYwGEaMOUAXdXyivNtvR9lR4rsBYtmTBJAMv5eaqdvGi6o+4+J5NNJ1CqhwrLH9JcQTq60dWkXgSyrX+OjX4EgHuN3+Ud4OpWcJ/nISf3UooZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcxvnkHvUfCMLwLZwI/wZRXPXm8mchTdFUEtpbZK5ZM=;
 b=k98wtCgjwIIuLpeHgG9/Nrmx7aP3XiUIm8kw1hOYKgfDBHfj9w+JvKULHg1Aovo5eP4SjSlO85Sy5RgiQIVcEDweR/HSmz0hmsSmy5w/U2l92Be6uRh7R8HFPfe6aqgB2J0CWrMSbbdJxjmLeFhZhNpbSVaT3iwO/CdSKdCKtjWNstIr2RudbvoSvakSXP/MlsrQiFnlbihyVsyQpK5i4Y+cDrQhyFFwGHOuOg4TxtFsuLpsI3/1DEo1zGzCUjakRmzZXTW8d9rjI4fl7gQSAEuy/cLvKnCYvSksnunvai8s+KI1p/m+Gw2JPaUSID0dDdyr6KTaJYT08NGnsDgUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcxvnkHvUfCMLwLZwI/wZRXPXm8mchTdFUEtpbZK5ZM=;
 b=EfhaDk+EQwiuWwt7Y1A90gbFbmS1e7GYQFcC6OYD3QGcHY+wRYb3y9/JAZPWEz8N6DLVPe6dzRGey5E9SHuKnG7AOLUb5y8DKlP/50WRkSXmg3+DPEnNEfRsDAS85CgGheiqbEAVKIfZmOrNrMVHJiKoWCzL90XREyVq19OInA0=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TY0PR03MB6534.apcprd03.prod.outlook.com (2603:1096:400:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 02:09:46 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 02:09:45 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] ASoC: mediatek: mt8188: separate ADDA playback dai
 from capture dai
Thread-Topic: [PATCH v2 1/7] ASoC: mediatek: mt8188: separate ADDA playback
 dai from capture dai
Thread-Index: AQHZjR0F6yjZSse1DEyZ2HHXQBRQUq9n6ciAgADFmgA=
Date:   Wed, 24 May 2023 02:09:45 +0000
Message-ID: <818841fa2ec47940ff2931a56c915231aefa21e1.camel@mediatek.com>
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
         <20230523021933.3422-2-trevor.wu@mediatek.com>
         <1d3ba1d6-ff91-eedf-90e1-4ef5b16354c2@baylibre.com>
In-Reply-To: <1d3ba1d6-ff91-eedf-90e1-4ef5b16354c2@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TY0PR03MB6534:EE_
x-ms-office365-filtering-correlation-id: 0af06b33-0380-46e0-09ff-08db5bfbf1ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qQYRkytaBsaxcCm21AP/T0jhFzdgKoram+6SyOx9mE8eGZZB5ctla34f5Jsg+JXFtLr7FRBCLUcugFsrhixtDE+HhHiOXr63C9qYuM3WZsGvHhjx3CFeunzUlo/h4nhPjJgaDdnpR9M874BFl7J5Ievs/6miid2R1YMx3jaF8/209gn5vi05rmQUVKHe1Jblc2JmCUMZA9Zhw0xRtKUHZpQKyS0V0D1H9GlIb2Q3R49S3QXIq49jHB5A7mnHwoB8LhUPS6+LSaU8fCOVV63dAQGzbTgu29esEo1KGnozYOupuDm2Y2Th+I8ea5C5OkyUqoP6hxlX7FUunKzSn8w6fWb4HHpGKU/0maLIUkKlTzTzgKGQ4hkpFDKCT4doEk7k3kRqjICsGlaRM86UgGa2xdcbg+68BTW/v+7uhIDrhRzuPz9SdZi4TCv3OhDyOF3aBRzGQ9JHkcvuvL1XQYv1bFXnwU65Jb6tyBncxN+pk+DToYqS3CVPFf3P6ojcv2hhX6aZJlRtwoBSBD6RJbc4Va4hgPW8ArVsK/xsUn6tA9sKTFe8Et0zadAkltuJPqN2UFIM8ZKmawXPI7QkCI+Ha4iNxOwv6FyzoYHv+CbTMxsLbNi66WKCAlvI27B2v3KbeyJpLG1rXh5ewjaP/v90LBVweRXZvyK0WrgMExfapaA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199021)(38070700005)(54906003)(41300700001)(6486002)(110136005)(316002)(91956017)(4326008)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(71200400001)(8676002)(8936002)(5660300002)(478600001)(86362001)(38100700002)(122000001)(921005)(26005)(6506007)(7416002)(6512007)(53546011)(186003)(2906002)(4744005)(2616005)(36756003)(85182001)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnZzYWp1WGpsL3BDQlQ4WnVPci9DbzBKd0xPcStOTjRtRHhWblFwbzdJUnZU?=
 =?utf-8?B?c09mN2l2VEFaODNHOE16eWNxVE9TSld2SnJlL0o5RGZiUlFacHBEV05YcEUw?=
 =?utf-8?B?amxjd0R1ZzhtQm9WT3RobEpycE5oVzhLOHlPSXVuNDJtRDJ4dUpKMUZtdjJY?=
 =?utf-8?B?bVJmelFrNi85RXBNSFlJNFYraCtKQlZQbE5DQXZtc0NHRU9WK2xJdkQwRW5T?=
 =?utf-8?B?ekNaKzJ1QVB6R29Cd3EwZ2pLS0NYRWxLaDU5VHJjVmpJMUlBK0hSUUNhUlJv?=
 =?utf-8?B?ZU9QZzFIQlE0UTBUeWluczFOSk1lbFIyNGl3VGtMWlNQSTBrN1NOaU43bkNr?=
 =?utf-8?B?NWpoS3M1VVJ0VGNJbTdiNGQvdkl6SVNFV1lnMDZNQXB3ZWtBTmp4dHVKRTY2?=
 =?utf-8?B?ZWNjSXhoTzBjS0huRlJEQWZNYk5DVHEyYkp6b0djMlhpcGQzazBFelJqRFR3?=
 =?utf-8?B?WkZIaXdrQUdSalF2OERjNDdYczU5UCtUOUJCYmRqcHdwOFdrV0FIUG1hRVRN?=
 =?utf-8?B?N1VKOURqVy81QXNFUDY1ZnFraC9TemJVOXYyNUtocnFXV2RNMGNpd080c0p1?=
 =?utf-8?B?VkRmaStRNUFYNnhPWG9GUjg3K29qQVZSV0hnV0FoeStnVUNTZ0lKNVpEcGJv?=
 =?utf-8?B?RENERmxva2MycFlML0VCQjZmbHpnZ2VOYlM1WFZHVVhJNjRFVEt5ZWMwZ29x?=
 =?utf-8?B?eXRrZ3h6cDZVVEt4cUdJWkxKODd2MDMyYzFzbFF5c2RpUUVuckIvY3R1L2VZ?=
 =?utf-8?B?dVY4RGJXem9uWkk1N3IvWEVnVnl4OFVjaFdnbWVCMGsxVHNDcXFIa3NyQUhI?=
 =?utf-8?B?alZxQ3RqWGhxVTR1dkdEMlpib0VEWFRPQmVTelhYU2dMZjFqQnRMa0FWakc0?=
 =?utf-8?B?S1BpYUUwNDBtekt4b0l1aXNGdEQ4Q0RPQUxDTnlsUmFxQ3hKOVlqM1ZOQlM3?=
 =?utf-8?B?aFowejVGVmhzSlFWeFVyQlllL0VyT1VPNkFsUG9xcmFWTENuWVZOQklpOCtk?=
 =?utf-8?B?TlFiU1ZZU3ZqSlgva3Z2bzM1SXBGV000cEVLL3ZEMmJKSWhPNDZZR2E2MXNB?=
 =?utf-8?B?aSszYmI3UFZtMzZBQ3NSVEt6ZDMrTjNaTFhZQVI1VEpCR3AyaFhrOC9tdTNs?=
 =?utf-8?B?V0pVWXd1OXcyanRXd2NjNnFacnc4SU1BVEZ4Y25Vb1M1WEk5YlFXci9JM21V?=
 =?utf-8?B?MnBCV0c2VGNmWSt0MUwxdlFoelhXTUROS0hEOVBmOGtCc3BKcitEdFZ6RWwx?=
 =?utf-8?B?TWM5NFRtakNVYmNoT2VyUFVNUS9LZ094cEJwOXg0TG9qb3RJMmlWQ1RWZjJs?=
 =?utf-8?B?TnJBOHl6MUN4RWFSTmFpZE1qWHRZSHREekZ2NERtSGVFK0xmV296SEZ1QlZz?=
 =?utf-8?B?T0ZFNkJBV2hZVzJ6OUQxN3h0aE9ZSlRkZ1RkOTZpcUZ0ZEZ3cDBvMkMxUTQ3?=
 =?utf-8?B?SlZrQVJueUhqK1hGSlNtMVg5RW5xVzRRZWNlaDVMQzFzT1FLdlJsSVJSUG1Q?=
 =?utf-8?B?Z3Q0QUxNZ3lwUVIwVVNwVWZlTzMyVkZJK2hKUTZFdm8zWURxOE83Z1Z5a1Fz?=
 =?utf-8?B?MVgrOFBzc1VDQWE5OElwUlZ1RHdRNUhaYjZPOXd4N3h5L0tUR3F2eUVKMHpT?=
 =?utf-8?B?YVhOZHZNMW9RSERhaFo0UjRQMmNEMjJLdjZzOFd6T2ZOc1lYUFFVa1FQcDcw?=
 =?utf-8?B?THZBbEJ0Nk1YZFhVNHVxbTlhejNRMlZESXZOQVdrWjF0QkpvMmRFYUtGZXF4?=
 =?utf-8?B?ZTBrdForQ3hjcGJDNks1d0Foa25UclZsQnJzQVhnTjVaRFpZSHBXN1l4d0Nl?=
 =?utf-8?B?VGhJMURiblpzVDkvYittYzFCWGMwak5PYnRBK3ZxdVpSSlBHdmdkeWNoRDZr?=
 =?utf-8?B?bEJCY3JvMVY4SzM5WXVQV3puaktWNG85TnluTTdUUU53OEExS25rYVp5Unpu?=
 =?utf-8?B?RHdoU2VVdGRtNGVHczZzSzBYZmNJMDJ6dmkvZ0ZTWGdPMGNDNkRmOFlQb3FC?=
 =?utf-8?B?bWgwRmQvRGdqYU4yaWl5SXNqcVBuUHdrbEljK1YwY1FNREd1M2dxYmhMSnB3?=
 =?utf-8?B?L0FTblhIKzBCUHBVQy93S3pDRy82dHU4UVhqVDJxTWtaMWdiVlJESmVuRkVI?=
 =?utf-8?B?SHByVk5BT0JSbnR5bVE3OGZ0Y2UzaTcxWUNNb3FERU5uYzVUeWNCcUphZzk1?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFA178E524B43E4D887CE5EE1D631D32@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af06b33-0380-46e0-09ff-08db5bfbf1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 02:09:45.6588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puN1s8twyiBRYn0pK8/6RQYWoEOVnXHhd9QH9Oois1BALM27ANCOAW4WircY9FTX3tZtZGIxNzDbQGLSDFvHDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6534
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTIzIGF0IDE2OjIyICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiAyMy8wNS8yMDIzIDA0OjE5LCBUcmV2b3IgV3Ugd3JvdGU6
DQo+ID4gTVQ4MTg4IHdpbGwgc3VwcG9ydCBTT0YuIEluIFNPRiwgYmVfaHdfcGFyYW1zX2ZpeHVw
IGNhbGxiYWNrIGFyZQ0KPiA+IHVzZWQgdG8NCj4gDQo+IENhbiB5b3Ugd3JpdGUgd2hhdCBpcyBT
T0YgcGxlYXNlID8gKFNvdW5kIE9wZW4gRmlybXdhcmUgSSBndWVzcyA/KQ0KPiANCj4gPiBjb25m
aWd1cmUgQkUgaGFyZHdhcmUgcGFyYW1ldGVycy4gSG93ZXZlciwgcGxheWJhY2sgYW5kIGNhcHR1
cmUNCj4gPiBzdHJlYW0NCj4gPiBzaGFyZSB0aGUgc2FtZSBjYWxsYmFjayBmdW5jdGlvbiBpbiB3
aGljaCBpdCBjYW4ndCBrbm93IHRoZSBzdHJlYW0NCj4gPiB0eXBlLg0KPiA+IA0KPiA+IEl0J3Mg
cG9zc2libGUgdG8gcmVxdWlyZSBkaWZmZXJlbnQgcGFyZW10ZXJzIGZvciBwbGF5YmFjayBhbmQN
Cj4gPiBjYXB0dXJlDQo+IA0KPiBwYXJlbXRlcnMgPT4gcGFyYW1ldGVycw0KPiANCj4gQ29kZSBs
b29rcyBnb29kLCBhZnRlciB0aGUgY29tbWl0IG1lc3NhZ2VzIGZpeGVzOg0KPiANCj4gUmV2aWV3
ZWQtYnk6IEFsZXhhbmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+IA0KPiAt
LQ0KPiBSZWdhcmRzLA0KPiBBbGV4YW5kcmUNCj4gDQpIaSBBbGV4YW5kcmUsDQoNClRoYW5rIHlv
dSBmb3IgcG9pbnRpbmcgb3V0IG15IG1pc3Rha2UuDQpJIHdpbGwgY29ycmVjdCBpdCBpbiB2My4N
Cg0KVGhhbmtzLA0KVHJldm9yDQo=
