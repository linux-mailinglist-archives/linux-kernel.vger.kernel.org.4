Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AC371F77A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjFBBDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjFBBDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:03:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F25DE2;
        Thu,  1 Jun 2023 18:03:29 -0700 (PDT)
X-UUID: 472d636000e111ee9cb5633481061a41-20230602
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SrnIMjBRJxRm4cy6UQbQ4J2Us9HZthsC+4KczoYoAB4=;
        b=i/2fhqGunEbMkyfm7ujTyvSGqmuYwx/t4Sgz1y3t53CMSnEC12XBABD1/X3ykPqWZli8xXrX/xRO40YxoNlTAt2vv6Ik+ZaJOxzmcE2om/OhwvfU+p0U66AKQT6lSQlUCIF3iwtH2hpBEKWsWm5BK9rSc7OqUCg2yS4LhMwvyxo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:88552668-021a-40e6-ac84-0ce8c533477a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:7324c46d-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 472d636000e111ee9cb5633481061a41-20230602
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2107300435; Fri, 02 Jun 2023 09:03:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 2 Jun 2023 09:03:24 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 2 Jun 2023 09:03:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QS6GOBDKMDe+Un+nz5M9wR4Y1Q4uahemF8y+4M6Vldgfo7L5q2piuCSlNFJSXp5HkFGP8THrd1EhnuA45UueQYqXaMVFNR/1wOIBD1ky/9ZEPjCqiBqsZdBdMrJjQ5NJVcQduQSDDdHu+AOzhutdp5zbA2lkMmuz1gg2vUEya+wh6S2DJmeLsAVaKoNNK4ipKrxaKGUPz3ii77xheF8jHvxEVYUm0EFkW7blr3LlbD9BfDIxK4kgH2pvLxt+8qaztARr7G89ekdyg/9WV0fqEL8NSvuZT0ZW9YFhWQhMX14Wkd9HZ0xxk2p07Tv6M6jEyXMcjG68ZuxSqZVlfbIuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrnIMjBRJxRm4cy6UQbQ4J2Us9HZthsC+4KczoYoAB4=;
 b=oKb48Kg7WwHN1t521MrolQQSyIVpMrJEJr22fE7NqPHU8+Es2aPimH/LChTZjRCId3SI+wVWPrynj2xHA2R9i2FbgX0XKbWGE5WXgd/39JBQJkMZKFRUDJpE9i6HVd9hbtbC6Jck23JlISlDQECcC10JdGdACC7bqL4A+R5xDpdI+Q0Lvu11TGOkuYfO2FCeB985itA6iBoRW4xtZpcQMdpDzKg+fDvO2ktTZIug4R0+7PSISInrkOM4v1rZ3JGJIO8UZfweCWkYjirrAT/9BcVj689ktZMQ6OVkGBrozqAz8oa1OeTPC1bS+861nmYMDi/1dKFGmKv7DuiSaD8ytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrnIMjBRJxRm4cy6UQbQ4J2Us9HZthsC+4KczoYoAB4=;
 b=n99qTryNraBVzytYytQkj5dcEeP6DoHL70DfrROXoFU1GJaJWhNzEffA2OWFMTwnen3UDpLwmXkFJ9MSj/DBOa7jSoPCCRzrgMF33wBZTnOuhG3rSZRACstShz7P9BwHo9GS7ZjbqDbJEMVaIyLMcmHa6jAAhSfsgYwS2xdVdVw=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB5678.apcprd03.prod.outlook.com (2603:1096:400:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 01:03:22 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 01:03:22 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 7/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: add
 NAU8825 support
Thread-Topic: [PATCH v3 7/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: add
 NAU8825 support
Thread-Index: AQHZj7UDT5ORb2TTd0usyg6ELGnmXa912TUAgADjbYA=
Date:   Fri, 2 Jun 2023 01:03:22 +0000
Message-ID: <3a916b8a839b54ff5166a12abbd9793530d19cf1.camel@mediatek.com>
References: <20230526093150.22923-1-trevor.wu@mediatek.com>
         <20230526093150.22923-8-trevor.wu@mediatek.com>
         <df12a113-109a-438c-9a6f-ece021550b69@sirena.org.uk>
In-Reply-To: <df12a113-109a-438c-9a6f-ece021550b69@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB5678:EE_
x-ms-office365-filtering-correlation-id: f8284546-e92b-446e-c7ca-08db630529a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d22yLHpnwA9KeDR3It9eQuClnvfclux6II2Ez6Z6lysYARHDXlC5yU8svQEOMAOJfzUE60Uf77CTUMvIhmYeEYJJy7B0qvJppDAuNh5EnqLgfoo4GflWXV3Bs4vajFq8M+7SArayz4pYkD+7jTu1Vj3pTyttl7he+DNYIY92KTvTcVu87g0czmV2FjG1BroBHMdK7T6WOvKsPdIWlQZZSDC3xJyQNzSv1kOOLxpwKZTiD8zcLW+1UBuNvfMr0yuxW8YsdNcOox0dpUJIP7TPFFdC8CqqRvm/kF90pSBXaSIHsoGvFSE8Sj+t/aJh5DqPYX5bWkicrBiimHMKwiPoL/3s/ef06NUPPpdYb90caPLSeRQUo4Om2HFBKipHdV4NXgFZ/wovEWkLuOhSm04x5J84ViOm4JbbT6jdZTYsKosiQRgF+Vq3qlVGlkoPZmewHxYWCrvMzWOR7/gOTFf/1RKxcyW+LZN3s4dowgX0qA+y1A5GucOimCHv4SBlCFaVB7IWUx5cLsDzW7ydyTO08ydWP6GGLPFS7fKij+J6qykYQT9TkW3Op4C9HLUko0yWdgv8+2L0axv66Mf/NxOWniFD6sLWj50EI56Je9HXehY5HIDno8o5vwuBTkuGib1jH+2iYotzCjLOWqNHi4jcO4e4Opj0Vz2VI0NXKmeZvpcv1SV6UZHoxyQBGLlEVHd+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(36756003)(85182001)(2906002)(4744005)(86362001)(38070700005)(5660300002)(7416002)(71200400001)(6486002)(186003)(6512007)(6506007)(26005)(91956017)(478600001)(54906003)(66446008)(66556008)(66476007)(76116006)(4326008)(122000001)(41300700001)(2616005)(64756008)(38100700002)(66946007)(316002)(6916009)(8936002)(8676002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmNmR2l0V2w3ZTZSbHBYVDFXaWJ6ZEcxUzlzUEg3NTJKMngzYXJuSk12Sm01?=
 =?utf-8?B?SVRydWp5eGV1TE9xbmVVekpiekc4VGtDckFwVTN6MWFOWUJWY3gwbWQwTmky?=
 =?utf-8?B?RE56bms4QjFhUWtFbVBId2kzSE1HQmg4am9iWkx6aEdCQ1A0cEZneEtwMDRo?=
 =?utf-8?B?YlpnbWRBOGEyZjQ5UzVkaGUzYWxaaWdTR1kySlJWRGY4cUl0ajZjQlQ4ZFht?=
 =?utf-8?B?Wm4waTRRWEhoc2lpYVNHQ2U1cHgrNHBTaWU4ZnhxTE1aQlJOQ0JCMEcxaGFN?=
 =?utf-8?B?eEwzTkRTZWVWMUw0RGNIQTJ6aFJGc3dpaTVKMWJDRnpxQ2xpY090Yk5QekNY?=
 =?utf-8?B?ZlpZZGdhSktEbk42MWNXeUxuaWpVRzBEL09ldElucjBOamxJSDFLVEo0OUI4?=
 =?utf-8?B?SzBHZHFOVlJZTkRLY1kvSlpTVUFQNnoyc2Z2cVdHaFljandUUVd3ajFQT2Uy?=
 =?utf-8?B?RVBhcG1JRzdUMkJTSUZuaU9tU2NqNzY3R3lzMHk1RzhsZmtXaW5rUE5BK0J1?=
 =?utf-8?B?NnJHWERVWUdHREFrZzAySnRrWVcxSngwSjFESDlLTVlnNTZHbWd3TjNLdU5F?=
 =?utf-8?B?aExwQjJaVU54QjgvZUR4cVFPQVh2bk1zUk5CajJWVXRobDB4cXpIVTNkOXYw?=
 =?utf-8?B?OFQ4eGg4R1g2T3BvVGdSV1pMbkVWNjJpVlpRckxCbWorUXFMNEJuZjh5Z3VU?=
 =?utf-8?B?Z1BLL0lpMFE4YVdYVTdUV2hFUWIyK0RXbEFSYTB6Y0I3a2FNUjE4ajlQSFBj?=
 =?utf-8?B?QTRuMTE3VHh5bUpLZ1FMTlkxZDhjSDZPVEpMSnJKdTVxMDk1NEhQUGlqOVlk?=
 =?utf-8?B?UW1PT3B0dU1WdERRL0xaQWk4QUU2MjczWk1YRk5mTzBzcWFTK0w2MmdOYk5F?=
 =?utf-8?B?aVdMYjFBc2U0N3J3K1drMUVtalVJTythMkdiSkZYcHhXWUtDT2xsVUdlcmFm?=
 =?utf-8?B?NGRRVUd6UVVLK3N1MlFwaldDV2I2T2hpM1hjZVFhZ1ZzaHd4QjMvY2hsdzRu?=
 =?utf-8?B?QlJnWmc5eW5LWjlZQVpUWTlqUkJCcWhZaVlBRlJIcFRsbkppYzhHeVU1T3F1?=
 =?utf-8?B?Y0V6aDU4U0R0YmwxWE5DcHR3NjRaWU5WQTlaSEtia2lJaEQrTlRtWHJ1aWZn?=
 =?utf-8?B?cjZMQU9aYUV5OExPK1pVZUgxTUZwUmFycmVoYWkvQjV3ajR2dWJtQkMyaEdw?=
 =?utf-8?B?ckhwcnMremt6Rzl5K01FcGxTMyt0N0t5UWlWWmVXSSs2aWJjL0gydUpKWHFE?=
 =?utf-8?B?bnhDN0pibExteUZPL20rUnE1bnZkS2h6SzVITnJORExqamZRMU0yZlB0bk03?=
 =?utf-8?B?WXFOdFI2VE9UR0FOQXVOQlJKeUdJK0tyUmtPNno2dUtseWRlbldpN2ExWG8w?=
 =?utf-8?B?Q1lrZWlwMEFOOXd4SktRcUJJeWNYb3paMTdjbjM4dGlQMnhTK1lUVVJSUkEz?=
 =?utf-8?B?OGFOM0EzZUhTSUtYL200Q3Vlb29BNXgzb0JzM0F2WVJYcnlSRGFOYlk3d0sx?=
 =?utf-8?B?TGtvNEp2ZzlHc1Yzd09NWUI0RDNuOHJjTFB1bytGMnlPb09HZmIzc0I4R3lT?=
 =?utf-8?B?UHYrY2JTK3Vhd1dsbXQxWTZ4NGhRNkd6N2xNalBQK3dmWUhLOFprS21QTFZo?=
 =?utf-8?B?cmRYbjcxMWdkNWQ3SFMrYmtLbGN5Mk13QlRJSHVWQU9ieldSTzArV0VGNy9l?=
 =?utf-8?B?dnZUVmZIVkpPa3BTaUdkbTdRWGZBeVZ6QTFvck5CM2o4MlBiUk9IMXFaRXJm?=
 =?utf-8?B?bUlrYTY0Qi8xbFJCMkQyeU5DVUxYOFdIUURsUExya3pVL2R3eFM4M003eVdt?=
 =?utf-8?B?Q2x3b1l1MUxKR2NiejM4eHhsSnNBRVhLRFB4emRVTStOcXdVdEM4ZGI3R2Er?=
 =?utf-8?B?dmJZcGtZMC93YXhURkxyV05aSWczMGlJUTdvWjRGUmJMRXljYlFEVTczaE4w?=
 =?utf-8?B?WXdOVTdHb0M4NWNsY1lWTlh5VDAza2tmTmlKV2Y1RW95RDRINUlMSkJYN3ZY?=
 =?utf-8?B?SUh3V3Z3UllsTzc4UUNBaDZrMTZlTFFLZDN0YUtmUWU0YmtTRDJ4aERYUEJC?=
 =?utf-8?B?a2RIUFdaeVJrc3ZCWDhPdExDWFRSSkNHbE4yaU5KT0hqVTVQSG9pK0R0TlY3?=
 =?utf-8?B?aHdkaFJiYllOK0M3bFp2cFJMZTlCT1hNVHFFVEl6cFEralNnVnl3em9SY1hJ?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5A3732A51A5F847A9AC8631AA59A9F7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8284546-e92b-446e-c7ca-08db630529a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 01:03:22.7035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcSD7Pu1OcFnkRH2Gnp4hLJJGFizOhn0Y4aKNBrrKCpa4TAQon1yu9LqwCTz36qGpqEAP8oKWCVgtMndDLWikg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5678
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTAxIGF0IDEyOjI5ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBGcmksIE1heSAyNiwgMjAyMyBhdCAwNTozMTo1MFBNICswODAwLCBUcmV2b3IgV3Ugd3JvdGU6
DQo+IA0KPiA+ICsgICAgICBkYWktZm9ybWF0Og0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBh
dWRpbyBmb3JtYXQuDQo+ID4gKyAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICBlbnVtOg0K
PiA+ICsgICAgICAgICAgICAtIGkycw0KPiA+ICsgICAgICAgICAgICAtIHJpZ2h0X2oNCj4gPiAr
ICAgICAgICAgICAgLSBsZWZ0X2oNCj4gPiArICAgICAgICAgICAgLSBkc3BfYQ0KPiA+ICsgICAg
ICAgICAgICAtIGRzcF9iDQo+IA0KPiBXaHkgaXMgdGhpcyBhIERUIHByb3BlcnR5IC0gd2h5IG5v
dCBqdXN0IHBpY2sgb25lIGluIHRoZSBkcml2ZXIgZ2l2ZW4NCj4gdGhhdCBpdCdzIGZvciBhIG1h
Y2hpbmUgd2l0aCBhIHNwZWNpZmljIENPREVDPw0KDQpIaSBNYXJrLA0KDQpXZSBhaW0gdG8gcmV1
c2UgdGhlIG1hY2hpbmUgZHJpdmVyIGZvciB2YXJpb3VzIGNvZGVjIGNvbWJpbmF0aW9ucy4gVG8N
CmFjaGlldmUgdGhpcywgSSBpbmNsdWRlZCB0aGUgcHJvcGVydHkgdGhhdCBhbGxvd3Mgb3Zlcndy
aXRpbmcgb2YgdGhlDQpkZWZhdWx0IGNvbmZpZ3VyYXRpb24gaW4gdGhlIG1hY2hpbmUgZHJpdmVy
Lg0KDQpUaGFua3MsDQpUcmV2b3INCg==
