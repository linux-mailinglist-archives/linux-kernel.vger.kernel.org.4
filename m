Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9762D110
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiKQCRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKQCRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:17:05 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF3FCD8;
        Wed, 16 Nov 2022 18:16:57 -0800 (PST)
X-UUID: a407e0341b4944f69dcc47d58ce461ac-20221117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BjOIDViY7rMz0QwihaDRFDZ5sR/r2h77j7ZQbZFCnMs=;
        b=UBkRY98VFMV5z5kgqNFdL/irWb2pZI401liRp9tcLlMDWX+zhAfJd8qVntSPulJLAfvd5f6rl5Q0leBAryYomX/X/TmNmYUsA6wzokoRGxAgEiIeKlxxOxASCTqJsbAYuZfkDVzaXFbN8dToDhN60Z0nMiuO+dQ1s4JnMiF0J2A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:054283a1-28dd-4305-81f6-0d9e1931e761,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:1f32bbf3-9094-45e8-b6eb-26f09041f731,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a407e0341b4944f69dcc47d58ce461ac-20221117
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 769493635; Thu, 17 Nov 2022 10:16:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 17 Nov 2022 10:16:50 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 17 Nov 2022 10:16:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgMAl1fZu4kJQXqMBG6gVKP35hdqrQxoqAqesdWKsjolMEuJ1xC4ywQ5l+MKRtPMirQyQ9WMmmePPH9X4SZuGcLI11XKdr8CrGzhYt3l46FYufVUv8YQBPIUKALYfaxoR/JJmVbwZdGWraKw3V32qmnm/X8rVjSwja70bCPaZfYBve/PSM9zSjQcMMuv6otZ4dk4v7Oc5H4OdYSGSV3VlNyOvxjU7+6dxTuCoetYtpj2xShZx9pcx62C5ob4P0+2wYUPTs6YDd0o3usDctz5SmoO3ll+u0jUvC3DqtwAdLKgSvhOelzjmRKjg+n3lSfxjcsu8ggx2ZMmD64jD8ztuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjOIDViY7rMz0QwihaDRFDZ5sR/r2h77j7ZQbZFCnMs=;
 b=JaY4rPORfPDbn/gpAmO/KK3PAI6nI4XtGrhDEUTiyC9xYGgKWzsRnZb3z6oWnDSVQU9+S27YETX3dpJ5m06A2gjk+whKXjTBF5EQddZK3/eDJ3wNU9YRZXcccFDtIogMZCadQDBwayHslMvdtxOfXtob5YiBVo6HvxqX30Tnv233Bd34FDIf5DCnxlb+xsRFV5xERJs4D2I4ctOZpUj/fwL6TngAJntStJ7limDyQskByRBwd6YqBlGPN6MQmwbDaq6OIyw6U4QMt0SGRqQ2Iw5VJfosqlqUzIu5Bo49EUUwMEDn0ir84pJ2HfWETNBs1libyZtYnb6rf1mhReB3zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjOIDViY7rMz0QwihaDRFDZ5sR/r2h77j7ZQbZFCnMs=;
 b=AKthKDl8oh9Kt7xe4G3kNTg7yafLlGedkc1nC6Ek9lZw+f4OmfYgKrlMwkrXLEOwkNKT17v+h8OsWJgvmIgQKc+4VodUZNbofizzfBbnE4UwLRq2qfUK6TLw2cHUe2JSqlDnEWbWAfsHBfGPouIn9RFjlvqNCoAiknmylEGsRP4=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TY0PR03MB6882.apcprd03.prod.outlook.com (2603:1096:400:265::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 02:16:49 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b%6]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 02:16:49 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2,1/3] media: dt-bindings: media: mediatek: vcodec: Fix
 clock num not correctly
Thread-Topic: [PATCH v2,1/3] media: dt-bindings: media: mediatek: vcodec: Fix
 clock num not correctly
Thread-Index: AQHY9O9JtBuSy65JiUSbaCxiUr6+YK5B2DMAgACTNwA=
Date:   Thu, 17 Nov 2022 02:16:49 +0000
Message-ID: <b31b0928147804323149ced94fe284cc595ffca1.camel@mediatek.com>
References: <20221110102834.8946-1-yunfei.dong@mediatek.com>
         <20221116172952.GA461876-robh@kernel.org>
In-Reply-To: <20221116172952.GA461876-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TY0PR03MB6882:EE_
x-ms-office365-filtering-correlation-id: 39206c69-9d5b-4c45-c56b-08dac841c8b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wQfFiXLnpONYdkmTEwKvwtODSeF8VbZ1JtTLfd/DxoHINxgZFPL47TP6hiRdKPapMtAxWktuvQzfmWagtjc2JX/HSTryaUFOJcscqCUfKjz8bcDF9q9jobqZox3BIMn4qoQGlZXYMHYTDnVHPG2acNMTAxDsBS7TMW6dyQ8401TUhRIdKmIb89TaMsN4wh4ck0e6c/Y0iInYvZBCZm/4lWTTyGOr/Cer1310Ie1dL/0GjGEjK3tv7JakdQZEwKtJqbPcGaCXt85IYNyN/IRRX3U7O5fAuQNvrdn7XDuvYt3l5mG1PXLhD8n1SbwTsQl4Tv74fnup2pDpg3TcHNOss4Rlrjy39ecCuTBwzH2PbAUvk9AiLmS7E6MXWaAP8gNq9LGBR8Vd7pDx/DKK3EtLbhiE+3NyCq9h+Knw9M+cBFa1/I/Apq45EQw23jrmYe6oD4lMUDSgRLfwkmLjuc4W031s8R+++nZzygjAeo3uFGEqKoSq/hxP37lTcCGFkLY2LpuOimTV7u6FOjHV1cNDs7e7Gst7t3JG4IWslfWwb/L7jPNoA03UqtVByVEb3Ez0qxHjFPxVZf6U2O2ZX5PjDb9Y0NdzvJnBFM5ZeTfU4M8DtYcg1tAmTkDo4McG5UCGJ1Le5sYj0unrDoMYyXqr5PY3QO2/7WjZp5/aq3976jy/CCiWdJqII985WqIL6+ZMQ90oprDMhenNifjjnskRVigBQeHkX/kYpgR5Zn7aWoHXBKsTaVmtvXx/3LjR9fqVXDVCqeAQGCKa+ioGADLU9/INc79w8yI7SXQAR6pK58=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(6506007)(2616005)(6512007)(26005)(38100700002)(186003)(83380400001)(122000001)(7416002)(5660300002)(4001150100001)(2906002)(71200400001)(6486002)(478600001)(54906003)(64756008)(4326008)(8936002)(8676002)(76116006)(41300700001)(66446008)(66556008)(316002)(66946007)(66476007)(6916009)(91956017)(36756003)(85182001)(38070700005)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVEzTnJKc1ArS0d6NEVhMnMyUURzS05SajEyMDZCLythbUUwVFJhUkhaK1Vp?=
 =?utf-8?B?WndORFJPaEdyV3VUSERFblNtelhhcGROa2J4TWQ0b1FGdTFzeDdrV2dKUGFF?=
 =?utf-8?B?QW53bi9UWUdYMUxCNkg3dlpCdisrdFg3V0dLTHNBR3F4RjlGWUpSZnUyOFBs?=
 =?utf-8?B?WVg0QjhwQjB3NEpWak56ejR6cmI5Nko5UTZqc0cxb0tTSnl0WEwyVHVZRWg3?=
 =?utf-8?B?V2pDT0x5dE4zRERlSlZSWFY2Nkw2cktyOCtBUWRaV0E1QWNvL2JJcStLR21t?=
 =?utf-8?B?WHArVkZDUzE0Y2txRHBETGZSdjR6R0lmT3BENEowZnRsc0xPa1JRd2s4R3Fm?=
 =?utf-8?B?c2RBVEc0NTQvbURURGZhOVBoUWJiYlhGVk5CU3JUS2ZDRTkyQ2dqd2tIc3gz?=
 =?utf-8?B?dVBKcG5yUnJjUlBsWjNKcTRsOE5vUk1XMGkrL1VYcm8vRngrRGI2VXcyVXk2?=
 =?utf-8?B?SW9Uc1VUU0VOeGNKcExEb043VTY4VVJvQWR4OFAxbU1IeHVPcVcvRU9tTG1x?=
 =?utf-8?B?RGJLbDB4QU1jeVdQSnBzeUtwcHpJN2VBNFFJYjFUQXF3cFVZQnVjSWpqcU8w?=
 =?utf-8?B?Rzg5WndsS3pLYmYwbFlVVVlVVytMU2NZN2tWUVlKa3lmWnlibnRla2ZObjlW?=
 =?utf-8?B?OFpKZmp6dUhCeTkvRWMwUWN1bkV3cGl1TVNxYzY3Qkk4N05VazdmVnJvcTdm?=
 =?utf-8?B?S3hFVVNWdlZxSWRWSU81SFUrKzBmM01iaExhTWtFaURkVWRWTDFpUmRSbE5l?=
 =?utf-8?B?NzVvUndoRUx4WjdsYmM3SmFqeENKTHk5WFZuVFlZQWxYcE0wWFpwa1NYdjZu?=
 =?utf-8?B?Tm4wZVYwMkl2ckg0b2xhRkpSYnNnaklHdXhTVFA5MXMrWUpEUUNjSmJqeHc3?=
 =?utf-8?B?WlJWU1ZuUEFxTUJ0Z1U2UzBVSDZPQThsUGRXbnlLY1VQRVJxazBrelpwUHlj?=
 =?utf-8?B?ZU8xMGJickFvSFZwKy9jTVg1eTNVdzFOTjZidktSY2Q4S21UMXM1RGhBcGh0?=
 =?utf-8?B?RE1wdC9hdGdGSEhNcjFkNUhDNHdvR3Znd0Q2cGltQW9YcHpBOG1vQjJ1ZWRl?=
 =?utf-8?B?YXVnZ0YzSjYzQXY5eHJ1b29pek5PWEVsL2h6aXRGUUQwc0dVbkN6Rk9zSXFL?=
 =?utf-8?B?RVNFSkVZL09zL2dKWGtJNnNzeVdCVlVaQVB6b1FnaVpVMVhqYVptd0E5OWlp?=
 =?utf-8?B?VGRRSzM3c1VnYWZTcVltUXpxR2lCTzFBT2xZN3orVFdPalpxeUdoazd1R3RO?=
 =?utf-8?B?aUVoRE83UmVReTVYdDY0dHZDb0NiclorL2pReWZHRmxGNXNYVElJalJMWWdG?=
 =?utf-8?B?Y2ZOdHJuUkNaRTQ3dUV1TCttbUJLT0FUTitpbENZZkU5NUNoTDV0Q1o1YVdv?=
 =?utf-8?B?dlpmQmpHdzhQUmlzOHY1YmZyK0RlOUFjVHBjMndkelNTZWR4UnBrcldKL3Fl?=
 =?utf-8?B?VjliQ1JjajZyaisramlUdGIwdkgzSEYwTldKMG9CQzlrMVExU2d6Ylc1Nko2?=
 =?utf-8?B?WkcwZjczMng2ZnRtQmhQVWFuS3V0bnJ0dTI3UTAxMzU3Y2wySEIzcEJmekpD?=
 =?utf-8?B?TmRTMlorNTQyM3lXUkh2Z1p0YmFVQlB1MjFlSVFQREwzelJDMmpOUXFWSlYx?=
 =?utf-8?B?TjFGN2hyTkZoVk5yWGplbDh1YVdGVWpoT1Z0SkRFdUNqWWJDYXdHdUJsZVda?=
 =?utf-8?B?YkFoVFR3WWQrUmt6QnAvdFVBMHZQRlZ5V1NxTnFtcGFwOGY3SFN0ejZXenFJ?=
 =?utf-8?B?T0gyNnRCSWFydjRVYlY1U2U1cDdZVlJ6bkUvb0dKV0NxOWN2ZWF1bGUzb3NB?=
 =?utf-8?B?bW04ajA5YUJhWDdRVlo3ZkQwN1l4WW1ZTDZoV0JxTUlCN1c4VUtkVElJaGx4?=
 =?utf-8?B?Z1JuMklockRWYVlGUHNMVEJ4eUNValhrYzRqandLZmY0MjhxSExkZHUzc3J0?=
 =?utf-8?B?cURqRDhZdG5wVkdRWVNrcjN5ajhvRXNVNGlnOXJBRGRTN0VGakVDUDhRU0Z1?=
 =?utf-8?B?WlVDZUdDRnRWME0yekFJa3krb09HMFM1K2o5TU9jaVRRQTNTaFhOQjBKei8r?=
 =?utf-8?B?bzFpRVJWY09wa1ZKOWd4TUt3Tm9rVGh1MW1oWUo4MnI5SWc1bWRibFJNNEZR?=
 =?utf-8?B?Q0F5ZVlPMVdtZmtvZUFEWTBJTFNRNGs1NVBnQ2grTlZrWHMxOTB1OTIzZ3Ev?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93C221CF3EB33C48944CF9743A7DCDCD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39206c69-9d5b-4c45-c56b-08dac841c8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 02:16:49.1713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrUFluB1RkHjFyGtOzA74PyAQWM+OrqCWL/NXUBP4giFvRBeLkR4ePLWASYu6xUeVyB4gnEjskY9qAOyg6NgyjuCjcMjidF4p51uy2PDWtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6882
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQpPbiBXZWQsIDIwMjItMTEtMTYg
YXQgMTE6MjkgLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUaHUsIE5vdiAxMCwgMjAy
MiBhdCAwNjoyODozMlBNICswODAwLCBZdW5mZWkgRG9uZyB3cm90ZToNCj4gPiBtdDgxOTUgYW5k
IG10ODE5MiBoYXZlIGRpZmZlcmVudCBjbG9jayBudW1iZXJzLCBjYW4ndCB3cml0ZQ0KPiA+ICdj
bG9ja3MnIGFuZA0KPiA+ICdjbG9jay1uYW1lcycgd2l0aCBjb25zdCB2YWx1ZS4NCj4gDQo+IE5v
dCBhIGNvbXBhdGlibGUgY2hhbmdlLiBFeHBsYWluIHdoeSB0aGF0IGlzIG9rYXkgaWYgaXQgaXMu
DQo+IA0KVGhpcyBjaGFuZ2UgaXMgdXNlZCBmb3IgbXQ4MTk1IHBsYXRmb3JtIGZvciBzb21lIGFy
Y2hpdGVjdHVyZSBjaGFuZ2VkLg0KTmVlZCB0byBzZXBhcmF0ZSB2Y29kZWMtbGF0IHdpdGggdmNv
ZGVjLWxhdC1zb2MgaW50byBkaWZmZXJlbnQgY2hpbGQNCm5vZGUuDQoNCkF0IHRoZSBzYW1lIHRp
bWUsIHZjb2RlYy1sYXQtc29jIGRvbid0IGhhdmUgaW50ZXJydXB0LCBidXQgaGF2aW5nIHBvd2Vy
DQpkb21haW4gYW5kIGNsa3MuDQo+ID4gDQo+ID4gTW92ZSAnYXNzaWduZWQtY2xvY2tzJyBhbmQg
J2Fzc2lnbmVkLWNsb2NrLXBhcmVudHMnIHRvIHBhcmVudCBub2RlLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFl1bmZlaSBEb25nIDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIC4uLi9tZWRpYS9tZWRpYXRlayx2Y29kZWMtc3ViZGV2LWRlY29kZXIueWFtbCB8IDEx
OSArKysrKysrKysrKy0tLQ0KPiA+IC0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcyIGluc2Vy
dGlvbnMoKyksIDQ3IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29kZWMtc3Vi
ZGV2LQ0KPiA+IGRlY29kZXIueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21lZGlhL21lZGlhdGVrLHZjb2RlYy1zdWJkZXYtDQo+ID4gZGVjb2Rlci55YW1sDQo+
ID4gaW5kZXggYzRmMjBhY2RjMWY4Li43OTQwMTI4NTM4MzQgMTAwNjQ0DQo+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLHZjb2RlYy0NCj4g
PiBzdWJkZXYtZGVjb2Rlci55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLHZjb2RlYy0NCj4gPiBzdWJkZXYtZGVjb2Rlci55YW1s
DQo+ID4gQEAgLTg5LDIzICs4OSwzMyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICANCj4gPiAgICByYW5n
ZXM6IHRydWUNCj4gPiAgDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4g
PiArICAgIG1heEl0ZW1zOiA1DQo+ID4gKw0KPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAg
bWluSXRlbXM6IDENCj4gPiArICAgIG1heEl0ZW1zOiA1DQo+IA0KPiBXaHkgZG8gYm90aCB0aGUg
cGFyZW50IGFuZCBjaGlsZCBoYXZlIGNsb2Nrcz8NCj4gDQpJZiBtb3ZlIGFzc2lnbmVkLWNsb2Nr
LXBhcmVudHMgdG8gY2hpbGQgbm9kZSwgbmVlZCB0byBhZGQgJ3NzaWduZWQtDQpjbG9jay1wYXJl
bnRzJyBhbmQgJ2Fzc2lnbmVkLWNsb2NrcycgZm9yIGVhY2ggY2hpbGQgbm9kZS4gT25seSBuZWVk
IHRvDQphZGQgb25lIGluIHBhcmVudCBub2RlLCBjaGlsZCBub2RlIG5vIG5lZWQgdG8gYWRkIGlm
IGFkZCAnc3NpZ25lZC0NCmNsb2NrLXBhcmVudHMnIGFuZCAnYXNzaWduZWQtY2xvY2tzJyBpbiBw
YXJlbnQgbm9kZS4NCg0KQWRkaW5nICdhc3NpZ25lZC1jbG9jay1wYXJlbnRzJyBhbmQgJ2Fzc2ln
bmVkLWNsb2NrcycgbmVlZCB0byBhZGQNCidjbG9ja3MnIGFuZCAnY2xvY2stbmFtZXMnLCBvciB3
aWxsIGNoZWNrIGZhaWwuDQo+ID4gKw0KPiA+ICsgIGFzc2lnbmVkLWNsb2NrczoNCj4gPiArICAg
IG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGFzc2lnbmVkLWNsb2NrLXBhcmVudHM6DQo+ID4g
KyAgICBtYXhJdGVtczogMQ0KPiANCj4gWW91IGNhbiBqdXN0IGRyb3AgYXNzaWduZWQtY2xvY2sg
cHJvcGVydGllcy4gVGhleSBhcmUgYWxsb3dlZCBpbiBhbnkgDQo+IG5vZGUgd2l0aCAnY2xvY2tz
Jy4NCj4gDQpPbmx5IG5lZWQgdG8gYWRkIG9uZSBpbiBwYXJlbnQgbm9kZSwgb3IgbmVlZCB0byBh
ZGQgZm9yIGVhY2ggY2hpbGQNCm5vZGUuDQo+ID4gKw0KPiA+ICAjIFJlcXVpcmVkIGNoaWxkIG5v
ZGU6DQo+ID4gIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+IC0gICdedmNvZGVjLWxhdEBbMC05YS1m
XSskJzoNCj4gPiArICAnXnZjb2RlYy1sYXQtc29jQFswLTlhLWZdKyQnOg0KPiA+ICAgICAgdHlw
ZTogb2JqZWN0DQo+ID4gIA0KPiA+ICAgICAgcHJvcGVydGllczoNCj4gPiAgICAgICAgY29tcGF0
aWJsZToNCj4gPiAgICAgICAgICBlbnVtOg0KPiA+IC0gICAgICAgICAgLSBtZWRpYXRlayxtdGst
dmNvZGVjLWxhdA0KPiA+ICAgICAgICAgICAgLSBtZWRpYXRlayxtdGstdmNvZGVjLWxhdC1zb2MN
Cj4gPiAgDQo+ID4gICAgICAgIHJlZzoNCj4gPiAgICAgICAgICBtYXhJdGVtczogMQ0KPiA+ICAN
Cj4gPiAtICAgICAgaW50ZXJydXB0czoNCj4gPiAtICAgICAgICBtYXhJdGVtczogMQ0KPiA+IC0N
Cj4gDQo+IERyb3BwaW5nIGludGVycnVwdHM/IE5vdCBleHBsYWluZWQgaW4gdGhlIGNvbW1pdCBt
c2cgKHdoeT8pLg0KPiANCnZjb2RlYy1sYXQtc29jIG5vIG5lZWQgaW50ZXJydXB0cywgd2lsbCBh
ZGQgZGV0YWlsIGNvbW1pdCBtZXNzYWdlIGluDQpuZXh0IHBhdGNoLg0KPiA+ICAgICAgICBpb21t
dXM6DQo+ID4gICAgICAgICAgbWluSXRlbXM6IDENCj4gPiAgICAgICAgICBtYXhJdGVtczogMzIN
Cj4gPiBAQCAtMTE0LDIyICsxMjQsNTUgQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gICAgICAg
ICAgICBSZWZlciB0byBiaW5kaW5ncy9pb21tdS9tZWRpYXRlayxpb21tdS55YW1sLg0KPiA+ICAN
Cj4gPiAgICAgICAgY2xvY2tzOg0KPiA+ICsgICAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gICAgICAg
ICAgbWF4SXRlbXM6IDUNCj4gPiAgDQo+ID4gICAgICAgIGNsb2NrLW5hbWVzOg0KPiA+IC0gICAg
ICAgIGl0ZW1zOg0KPiA+IC0gICAgICAgICAgLSBjb25zdDogc2VsDQo+ID4gLSAgICAgICAgICAt
IGNvbnN0OiBzb2MtdmRlYw0KPiA+IC0gICAgICAgICAgLSBjb25zdDogc29jLWxhdA0KPiA+IC0g
ICAgICAgICAgLSBjb25zdDogdmRlYw0KPiA+IC0gICAgICAgICAgLSBjb25zdDogdG9wDQo+ID4g
KyAgICAgICAgbWluSXRlbXM6IDENCj4gPiArICAgICAgICBtYXhJdGVtczogNQ0KPiANCj4gV2Ug
aGFkIG5hbWVzIGRlZmluZWQgYW5kIG5vdyB3ZSBkb24ndC4gVGhhdCdzIGEgc3RlcCBiYWNrd2Fy
ZHMuDQo+IA0KTXQ4MTk1L210ODE5Mi9tdDgxODYvbXQ4MTg4IGhhdmUgZGlmZmVyZW50IGNsb2Nr
IG51bWJlciBhbmQgY2xvY2sNCm5hbWVzLCBzbyBjaGFuZ2UgaXQgbGlrZSB0aGlzLCBkbyB5b3Ug
aGF2ZSBhbnkgb3RoZXIgc3VnZ2VzdGlvbj8NCj4gPiAgDQo+ID4gLSAgICAgIGFzc2lnbmVkLWNs
b2NrczoNCj4gPiArICAgICAgcG93ZXItZG9tYWluczoNCj4gDQo+IEFkZGluZyBwb3dlci1kb21h
aW5zPw0KVmNvZGVjLWxhdC1zb2MgbmVlZCBwb3dlciBkb21haW4gYW5kIGFkZCBvbmUgbmV3IGNo
aWxkIG5vZGUgdmNvZGVjLWxhdC0NCnNvYy4NCg0KQmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcN
Cj4gDQo+IFJvYg0K
