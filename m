Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8DE70B98A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjEVKAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjEVKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:00:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4535AA6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:00:23 -0700 (PDT)
X-UUID: 72bcbe48f88711ed9cb5633481061a41-20230522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0AVHhE6TaQ/QGw85exsBSe+zkFz4gLXp8YWrQRp0cFk=;
        b=fXkyaRiE1Ub3E2hcHuSW9xouNgPkyBGY40tIWZJaY5qDxytpvigP/CcDJ54ent9/sbtcTWjB0PefSoWFPUbHCTsQ1rGPkiiDS/qxElWZC/MOhKv73iZ8/ssTj2nUr4c6X2NnzxXPCq7oBmAdni1f4S/vCZPL+aFACpXba8dWNLY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:532f49ce-f15d-4a32-9256-59b21f59d893,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:ea50a2c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 72bcbe48f88711ed9cb5633481061a41-20230522
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 13337898; Mon, 22 May 2023 18:00:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 May 2023 18:00:13 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 May 2023 18:00:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSmRjJ8088AHsTThSc0gJmSDnP5M8azjOsDjiDOTP3wZUDdOIccZrPhBO9gzBYVyFOyJl+FFCE2kcWL1j4MCUp2Gx+TUqAy8J2EOAS9nk0kOa5rX0PmvQ1SAxhYPB5lXdghwylABN1lULk2/111KkMBr7Gxd1zTrEXMKIT289prUcVITXxKNCbiVDMyzrz/mZSsbGm7C8nC2pPz++tsP8o80LxbCRqpV9L7mzk6p3PaqZvG1W9Lg/zYfwK1aUwkIyliHUA/Y9Xq3AdB7DQt52wmvVcQPgCq7KtnclwYv11Tt56K2LNIUkw3loiUGpXuazN8ojIxYnwn4ckLyoqH1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AVHhE6TaQ/QGw85exsBSe+zkFz4gLXp8YWrQRp0cFk=;
 b=dyMHbqCJWqf8Y8rV0UstSeKMuGU2XDy91MTmCPi/j9Ru4ZKqgwTVjZBIG42OOqeb/1jRlkAfybu6rwNM5vNgQWk0Dz6ehQ6JlDNxCWTRXDeK5H3wg/aVHKf9Xl53ZQNq97z2KM7n4cq546nA23Rj8xxAifmJ1txUIqGVNAXGXwz5iHpsoccPy0/vTStJfOUf8EKeJ3koohAdApGBOgwpz6wfvZdDCcZE1aXyLAdddbuzkiSITMYJN6K2dNr7slJXdvOKGDNSon3LMAahc6yIBWYbJdnHtjQccTX4h6BBirOw+J5fd/G3/dO4ULUEKjPSj3CutYNTZ9uCW2viUjoCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AVHhE6TaQ/QGw85exsBSe+zkFz4gLXp8YWrQRp0cFk=;
 b=lP0Srda0wTGPkKVo0t+WwcKndCiKe1NPgc4EVjUCW8a33cme9+oHyf1ML0UbUlNv8oX1mvXS7eosXgoMF29aExwLg3bF6qCBmAyP00F+8mNFZxBVzLArsIycp+HuCpwWI/SU8G+HLroyBViaA2WZnhGP9k2OW6h/1Hq7gXxpkyU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB6495.apcprd03.prod.outlook.com (2603:1096:400:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 10:00:11 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6c78:65bd:917f:8c58]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6c78:65bd:917f:8c58%7]) with mapi id 15.20.6411.027; Mon, 22 May 2023
 10:00:11 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 05/11] drm/mediatek: gamma: Enable the Gamma LUT table
 only after programming
Thread-Topic: [PATCH v4 05/11] drm/mediatek: gamma: Enable the Gamma LUT table
 only after programming
Thread-Index: AQHZiXZxds3I7znU6Uy7wXDx+bim/q9mFXYA
Date:   Mon, 22 May 2023 10:00:11 +0000
Message-ID: <51a5fbd349cce69d372f4ccfff7010ea9e6e8f75.camel@mediatek.com>
References: <20230518104857.124265-1-angelogioacchino.delregno@collabora.com>
         <20230518104857.124265-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230518104857.124265-6-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB6495:EE_
x-ms-office365-filtering-correlation-id: f1231318-e32d-40da-5f52-08db5aab54e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j3gF6DOpg5QGN/fEfLTNsZ9pdeD5UVLf5xqIpzW+eeLJmrO9nqlsqivteBZX7XEAMZdP0aiQmhDSPaKwcA3i0w0LoLXNdFiG/wlg2XtKRRBH5J8ehq+/WtrLktvxIN68KNAD2r78+G50QT/zSaDOrhm4/ykpu+F71NdZAiwq3rIGGGiOaED1FHLDLAxv3eJTxZapb8wkpJpiPSx7QY9oqehC4j22OZuA0uRyysdHNfJ0lf+cHArfBNqJJ519+rmOFhUXUs80Nc9gBzBGtK6dyzGJQW7Upeoz5HXI7mln6G+xhxVVSGtaT+QOp4hf9TWads8G/gXHyeT53jlzdgE5SW429bFWED3SHGPpaSXfGcX+UvxoC31GqZoYWhfXf5mUyxevve+lEa8Qffo7967lH+llXtxhuDvbV/wqLRKA6xz4wQr+4IA12JjBedX2sIKYtZJ93nd9Kli5SUSsB40QXLDpa6iGymmU4Ct8cBQaaRMQ/8Hr6qwivXLYtM4/MyW/kqPkVLlbe0hZqTblFavnn16y77jgTvxhx9gpD9HFGQ6YOW1tEYSf5lRLwq9YghDR+1GuVyrSm+sXDUXxSu0JOAffZZpwQyaTXylC2x+9xdaXiu2P5ODXEgBaI6DfPaX+OUu0+mV/xAfV6YJB0GA0xgxYLdtU5O3BiJLo9MXjlfw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(478600001)(316002)(6506007)(6512007)(26005)(110136005)(54906003)(71200400001)(41300700001)(66476007)(66946007)(76116006)(64756008)(4326008)(6486002)(66556008)(66446008)(8936002)(8676002)(5660300002)(86362001)(83380400001)(2906002)(122000001)(38100700002)(38070700005)(85182001)(186003)(2616005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnJvcThselh4ZUxDTTBQU2xtWnV6SHAwYkdGWHB2dkRQRnVQZzBOM0pncXpW?=
 =?utf-8?B?eGgwNDRTQmFWVFpuNS8walBLUzdFcFYzUXFuQy9jZEZlaDBFclprL1JwMnJL?=
 =?utf-8?B?d1hrYkF3KytVT0NwMHlnWDd2VHhFTnFLdHBHZ0lrK050emxtR3g5cFEvMFhD?=
 =?utf-8?B?QkpQMnVROVU5eW83SzVQNzdJQ1ZmdjVOY2ZsSlhyTlEwSnArZzluTVRjZ0ht?=
 =?utf-8?B?bTVGZTkraDdhVjFuZ2I3Qnh5U3hVLytwMFROSGNPOThld1QyM3dYczBrNTFH?=
 =?utf-8?B?MitJK2kydm1jWUxGOUFlMFhUZWVoZTNqMEZ5cFZMVFB0ZWZxWWZKQ1Rld1RS?=
 =?utf-8?B?L2xvQTNMMWUvY2ZldFJRZzR5eitRSXBZTTRGVjFsMmo2c3l3M2EyanRiR0Vw?=
 =?utf-8?B?WCtvcXJjb0FTZjU5VVVmQlM0RFRDd205aEhZWU5zbjFmSzh1Q2dNV0JtV0Rq?=
 =?utf-8?B?dHVWUDBmOGNnbjV0MElRMDVHMWJmMHIzZDlFcWx5ay9SWEdtb2MrcGhSRWp6?=
 =?utf-8?B?cDMvN3FKLzZaTjFMRkJJb2U0V051c0JKUzVvakQvWTdvK1A4YkpnOWtNQ3RI?=
 =?utf-8?B?S0xVN1AzTU11NVJjWkorUHpBbHVmQVVZQ0RZQk5Lc0UyZFl6MzMwOUhWemxI?=
 =?utf-8?B?WnhaeG9XNlp3bEZRTTlreGZZMmxGQkVWLzdnU2c2T1ZiYytTVVVVN1FiSHVa?=
 =?utf-8?B?NzZPRGQ4NjM4OVY0bzQ2WWhIRWtPY1dTSEpxei8zY0QxL2diUktyOWtkNWtO?=
 =?utf-8?B?cWJtVHV1dDV0V2x3MUpPL25rT3RuOG1SdGllWGF4bzhlVSt4RGFOMHFWUkhM?=
 =?utf-8?B?UE13ZXNEdE5PVUE4VGpwbUdSNkZjcW41ZmlXZnNrTUNGRklDNkdOeFNPVWZU?=
 =?utf-8?B?UExyMmlMQWRyV0xOL095SDFmNGNyalYzNEcwVno5eCtEYTBNamNYcGZnTTln?=
 =?utf-8?B?UEt3dU45bE8vZGJiUnEzbHFsUVg5cHV2YmxoMzRsQnBYRllLV2lpenNKUFNM?=
 =?utf-8?B?Ry8zbDJmWDdwd3kwOVUvdHhkTWJ5OFY0TVRnV0dPbis2d0FGZCtPTkp2MkVI?=
 =?utf-8?B?cHNhUGczc3RlSkR5S1RkWFBiZThxajlWczU0dHEvdDNBbmF1dk1Td0JHckl4?=
 =?utf-8?B?MzR0NSszYnVacmNFVFRqQmlvSytJRzlTeXVSYWlqbFJzVERzSWRoYWFuMFJI?=
 =?utf-8?B?OTlHMzJRYnEwYk42L2tvMDcvL1NGV1dPc2xWYVhaNUN3dmg3UkROMTJoZnpU?=
 =?utf-8?B?ZVozSHFZT0QvWU5tN1JyaTZpdmtOajVaSHh1a1o5NDFFbCtmelN6ZkRoNHpP?=
 =?utf-8?B?TFk2U1NYTXAzV09IR1ZJNTh1VGU5S25rZnRWVzRZVXhhMGVFU1VZQ1gvb2Zi?=
 =?utf-8?B?VFZybDExVG1qWlNLbmhZWWhvbDNjV3ZVRGdFT1pLMzJwZHNBOHJ4aFhhc0NY?=
 =?utf-8?B?RDFUSDlVU3J3WmdSekRaWVU2UjVXeGU4aFhyQTV3WHMzRzFxdmRmQ2l0MGV3?=
 =?utf-8?B?bHp3ZkNXVnhidVFDS1pvbnU3T2JsOTNienBLMWhsc2pIdVdQRWVYSVp6TDZ2?=
 =?utf-8?B?R1RWd0tZT3FoM2ttbzNQOTRJWnJncGU1RFZEZHlqUzNDL0FrNjhuMmp0RHBI?=
 =?utf-8?B?Z0x1U1pxQjZlYVgyMWJjWXNUUUhBdU51VGpZc1paU2JxWlM2cXM1ajRMNGVP?=
 =?utf-8?B?K1ZkdVJYOEExOWNtWURmRS9mZGNjd3RBcjhzWnRMb0xqSkU5cktET2NJL0FW?=
 =?utf-8?B?NGdwTWNRbE9KTEZIS1pybjJaeDM2NDRITnV1N1lCRWxPVEdQSDZLOWV6Nm5X?=
 =?utf-8?B?T0MxL2hoemgxdE50RWJ6YWhSZ0ZWNTJpR0ljdzZKazBSeElUR2hWMGxWMi9h?=
 =?utf-8?B?VU5lT1FqeVI3Q0dkNGcxUFdTSkpFdEkwdG9ySWltc1dlRkNjYmQ3azRUcmZm?=
 =?utf-8?B?cTdUYWp3SFJmdTBQcDNJT1pocitqQUp5cGRndTRVQloxNDZtYTVlUURteDc1?=
 =?utf-8?B?bmFENEdYWEtCWForWDdwTEQ5dWNuM29Lc3RJSTJiZ2NaRCtOMjlrczF6MlBa?=
 =?utf-8?B?b3o0bzIwUW5TNS9UN2pJSkt2c3FHSjk1cEpaczdFMFlzUzIwd3RuT3hQOFFo?=
 =?utf-8?Q?r95sWDughTQkS/jNvlMI71NlO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <591955BC5209B44385519C2DBE6D20F2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1231318-e32d-40da-5f52-08db5aab54e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 10:00:11.3028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZTaljsHkmoJyGi0Nx8zb9w/1XQH7WR9DQrROF791ZB6R5krTx5ljn43rtMBQXxPIm8PewCeuWvMyLXy6HEaEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6495
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDIzLTA1LTE4IGF0IDEyOjQ4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVy
aWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBNb3ZlIHRoZSB3cml0
ZSB0byBESVNQX0dBTU1BX0NGRyB0byBlbmFibGUgdGhlIEdhbW1hIExVVCB0byBhZnRlcg0KPiBw
cm9ncmFtbWluZyB0aGUgYWN0dWFsIHRhYmxlIHRvIGF2b2lkIHBvdGVudGlhbCB2aXN1YWwgZ2xp
dGNoZXMNCj4gZHVyaW5nDQo+IHRhYmxlIG1vZGlmaWNhdGlvbi4NCg0KSSB0aGluayB1c2VyIGNv
dWxkIHVwZGF0ZSB0aGUgbHV0IHRhYmxlIGZyZXF1ZW50bHksIHNvIHdoZW4gZG8geW91DQpkaXNh
YmxlIHRoZSBnYW1tYSBmdW5jdGlvbiBiZWZvcmUgbmV4dCB1cGRhdGU/IEluIGFkZGl0aW9uLCBp
ZiB3ZQ0KcmVhbGx5IGNhcmUgdGhlIGdsaXRjaGVzLCB1cGRhdGUgdGhlIHJlZ2lzdGVyIGluIHZi
bGFuayBwZXJpb2Qgd2hpY2gNCnNob3VsZCB1c2UgY21kcSB0byB1cGRhdGUgdGhlIHJlZ2lzdGVy
LiBCdXQgbm93LCBJIHRoaW5rIHdlIGRvIG5vdCBjYXJlDQp0aGUgZ2xpdGNoZXMuIFlvdSBtYXkg
c2tpcCB0aGlzIHBhdGNoLCBvciBmaXggdGhlIHByb2JsZW0gSSBtZW50aW9uLg0KDQpSZWdhcmRz
LA0KQ0sNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8g
PA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IFJldmlld2Vk
LWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMgfCAxMyArKysrKysrKy0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1t
YS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gaW5k
ZXggNjBjY2VhOGMxZTFhLi4xNTkyNjE0YjZkZTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IEBAIC03MSwxMiArNzEsMTIgQEAgdW5zaWduZWQg
aW50IG10a19nYW1tYV9nZXRfbHV0X3NpemUoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0KPiAgdm9p
ZCBtdGtfZ2FtbWFfc2V0X2NvbW1vbihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgX19pb21lbSAq
cmVncywNCj4gc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkNCj4gIHsNCj4gICAgICAgICBz
dHJ1Y3QgbXRrX2Rpc3BfZ2FtbWEgKmdhbW1hID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+IC0g
ICAgICAgdW5zaWduZWQgaW50IGksIHJlZzsNCj4gKyAgICAgICB1bnNpZ25lZCBpbnQgaTsNCj4g
ICAgICAgICBzdHJ1Y3QgZHJtX2NvbG9yX2x1dCAqbHV0Ow0KPiAgICAgICAgIHZvaWQgX19pb21l
bSAqbHV0X2Jhc2U7DQo+ICAgICAgICAgYm9vbCBsdXRfZGlmZjsNCj4gICAgICAgICB1MTYgbHV0
X3NpemU7DQo+IC0gICAgICAgdTMyIHdvcmQ7DQo+ICsgICAgICAgdTMyIGNmZ192YWwsIHdvcmQ7
DQo+IA0KPiAgICAgICAgIC8qIElmIHRoZXJlJ3Mgbm8gZ2FtbWEgbHV0IHRoZXJlJ3Mgbm90aGlu
ZyB0byBkbyBoZXJlLiAqLw0KPiAgICAgICAgIGlmICghc3RhdGUtPmdhbW1hX2x1dCkNCj4gQEAg
LTkwLDkgKzkwLDcgQEAgdm9pZCBtdGtfZ2FtbWFfc2V0X2NvbW1vbihzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHZvaWQNCj4gX19pb21lbSAqcmVncywgc3RydWN0IGRybV9jcnQNCj4gICAgICAgICAgICAg
ICAgIGx1dF9zaXplID0gTFVUX1NJWkVfREVGQVVMVDsNCj4gICAgICAgICB9DQo+IA0KPiAtICAg
ICAgIHJlZyA9IHJlYWRsKHJlZ3MgKyBESVNQX0dBTU1BX0NGRyk7DQo+IC0gICAgICAgcmVnID0g
cmVnIHwgR0FNTUFfTFVUX0VOOw0KPiAtICAgICAgIHdyaXRlbChyZWcsIHJlZ3MgKyBESVNQX0dB
TU1BX0NGRyk7DQo+ICsgICAgICAgY2ZnX3ZhbCA9IHJlYWRsKHJlZ3MgKyBESVNQX0dBTU1BX0NG
Ryk7DQo+ICAgICAgICAgbHV0X2Jhc2UgPSByZWdzICsgRElTUF9HQU1NQV9MVVQ7DQo+ICAgICAg
ICAgbHV0ID0gKHN0cnVjdCBkcm1fY29sb3JfbHV0ICopc3RhdGUtPmdhbW1hX2x1dC0+ZGF0YTsN
Cj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbHV0X3NpemU7IGkrKykgew0KPiBAQCAtMTIyLDYg
KzEyMCwxMSBAQCB2b2lkIG10a19nYW1tYV9zZXRfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwN
Cj4gdm9pZCBfX2lvbWVtICpyZWdzLCBzdHJ1Y3QgZHJtX2NydA0KPiAgICAgICAgICAgICAgICAg
fQ0KPiAgICAgICAgICAgICAgICAgd3JpdGVsKHdvcmQsIChsdXRfYmFzZSArIGkgKiA0KSk7DQo+
ICAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgLyogRW5hYmxlIHRoZSBnYW1tYSB0YWJsZSAqLw0K
PiArICAgICAgIGNmZ192YWwgPSBjZmdfdmFsIHwgR0FNTUFfTFVUX0VOOw0KPiArDQo+ICsgICAg
ICAgd3JpdGVsKGNmZ192YWwsIHJlZ3MgKyBESVNQX0dBTU1BX0NGRyk7DQo+ICB9DQo+IA0KPiAg
dm9pZCBtdGtfZ2FtbWFfc2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRybV9jcnRjX3N0
YXRlICpzdGF0ZSkNCj4gLS0NCj4gMi40MC4xDQo+IA0K
