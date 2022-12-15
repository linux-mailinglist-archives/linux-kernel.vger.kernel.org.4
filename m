Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD88964D9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiLOKvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiLOKvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:51:22 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCE8DBE;
        Thu, 15 Dec 2022 02:51:16 -0800 (PST)
X-UUID: ba7431ed7b3c4802805d21d800d0cc2a-20221215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=U9B9QVvUqWmXxzTmNVvahZr10x9gD77a3fryAoRy6pY=;
        b=KFfp8DycS8meSNOEU+rvbnwZxUFeSMWFw2PlaFvKkbrGjZTIiSV7TcYrJssiIbnhZ6utpP3Wm4QKqbDBf2KBGrhX7oRSq7BRcKvi/MlS27ws+G1E8cu5f2pnvhZ3G6FEF2YJ36oQuE6Vox6aHxqq6PBJQbw+7OeQBTORWUs/RGs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:e2662064-b60f-4ab9-a3fc-3fb9cb4e07bf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:e4cdbaaf-9f02-4d44-9c44-6e4bb4e4f412,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ba7431ed7b3c4802805d21d800d0cc2a-20221215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1814137526; Thu, 15 Dec 2022 18:51:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Dec 2022 18:51:10 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 15 Dec 2022 18:51:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6p/UoizqXxjbzKw4DMI/PYC5ElyzQpPOdexjaWArt2fkwOe/K55z54vRIq96Femd1LGGD/KtNfdAnDpOVhtQzgoMrvspRfncu1MlVHoVQKeLegTg8+uHGWmjYAuDCp+NCujMkfM7BPpdFvQOrUauRmMYpslM5ZZf2elvG3Bovoww2ED2eg29Xhyj1oXBywKuzZ1BAR8o6iU6aBRu7Py9h9AMciFcjj6Ibteq1qgSnad7U6S1z/h+B8vDiTQwloGQDwB1PdTyNgELoVskXraRXtRbw1laBMhLVXhLWOvBGC4ZokUQjS+7o+5jM6UvrMN4bkLJAcW/B12acqTjDKPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9B9QVvUqWmXxzTmNVvahZr10x9gD77a3fryAoRy6pY=;
 b=kAfuvnTbpUrDCW/iJ1Bh8vSingsLtSxYBi2qslKt87dvXQjn9SOHoMSoo5GJWXeTehlW0fkl+rauVKFHNDSMPnMoKC+/MPhhJG+uz30rIdZAhK664rmtm0XU1G+dvMXW9z8CS2H/J0V5KODErTcqQ82J5ySogbOYwU8YJfxos/x+4OZqOF9Yx0JNdaPhhmzy26oCFrHPMsNIFsQOajG/3sf6MLQkcs5OETTEMVAB3wzZ6oBhLH14j4l6eIbTRDvT32egsbow/zUEDJccznFg5cFVugPQuXBxq7lc8et/mYyNkqFWkuXbqXZ1XBsSbHUpbTNxGlnsijwtcWcshos5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9B9QVvUqWmXxzTmNVvahZr10x9gD77a3fryAoRy6pY=;
 b=S9ZBt973TFYEeYa84bdTMAjRrcb/zyYxkwuJur6DHUbfKokseTc1+2IougN+MI/0GLvHBFfOWetDuZ1OF7+F+YjOaQthQ7qFP24yaaK3lfocJScGNZtePVl5p4KtyXQxifkli6lwIHOmWU1FDKUG65n+5K8jylkyGPkYJ8cwIAU=
Received: from SG2PR03MB6263.apcprd03.prod.outlook.com (2603:1096:4:170::10)
 by SI2PR03MB6615.apcprd03.prod.outlook.com (2603:1096:4:1e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 10:50:23 +0000
Received: from SG2PR03MB6263.apcprd03.prod.outlook.com
 ([fe80::665b:1f7e:1947:8ac7]) by SG2PR03MB6263.apcprd03.prod.outlook.com
 ([fe80::665b:1f7e:1947:8ac7%5]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 10:50:23 +0000
From:   =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>
To:     "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?WGlhIEppYW5nICjmsZ/pnJ4p?= <Xia.Jiang@mediatek.com>
Subject: Re: [PATCH] media: jpeg: refactor multi-hw judgement
Thread-Topic: [PATCH] media: jpeg: refactor multi-hw judgement
Thread-Index: AQHZEGfxWziJGHPbr0m4uc3T47c9Da5uxT8A
Date:   Thu, 15 Dec 2022 10:50:22 +0000
Message-ID: <1895ff3f71fe7fe6c228d76dd046ea4f43b3dbf5.camel@mediatek.com>
References: <20221215093026.12322-1-irui.wang@mediatek.com>
In-Reply-To: <20221215093026.12322-1-irui.wang@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6263:EE_|SI2PR03MB6615:EE_
x-ms-office365-filtering-correlation-id: 22f8ed75-a56f-4725-0cf2-08dade8a2aba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1NYIRyGv2dXp7uYWJePpzKHKWegS2niByKpdVu1irYDSu5YU0VmKKei11803CEI8NZSuCSFFTzqZU6qzuQw/QVEuJiZv6G/cVLkHH1ISNWDJLSSyfTX0MqFbXWaQ9fHeNOvZczcy5BkFlkXy8kLI8M20pY6v+Vdsx4zlB05gXJcPI/0/ilRHDvxE9kd++abynbdWK+HxPb0WFjokKSfpKl2919Zfyg9vEXA7/4XnspYfQrlI2DlJk4yhdIBRiL5d2G4WK7AgEbwVTPAOHxu+igfa7StVf+FmpHRho5BmOZxxlGlOmMqH7H6TcsFtD9fgsL/jDvz30Jf/zpe05biMIlF7+zPjy95R1fCiC3NDNjrtwT/dzHNK/+u4+IODRfxQGAXsuKx0pR1Y3kk3fh9swTr/645GlJrOMMOuZtI9AZNDbpmDfzvVAzXwPZ8I/9Z5MikLRUL/vOMuN4j2/pHC4BDqFxYOmhQhy1jc8/oZjBva+K6/Kbwz4yX1R2YfQh9vZOTbCafDn84fpv/s1zC9ecUhhSpZLI1o6oMV0HYhDeNF248F5x2+WRV3llW5TVD4rB5R1RlLxs1Bsk9LYashmZLtILsgVGFfG2xPfAUqHDI+Y9tQoNm+xD33qeqw5gSRCxPOZdoKufYnBb2+sWmDKELgxrTqy7Cv+NTsY1bPMEaCIm5NBkveQEDT90xLuvR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6263.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(71200400001)(478600001)(6486002)(4001150100001)(86362001)(6506007)(8936002)(2906002)(85182001)(36756003)(2616005)(6512007)(38100700002)(7416002)(26005)(186003)(122000001)(38070700005)(5660300002)(107886003)(54906003)(4326008)(91956017)(41300700001)(83380400001)(8676002)(66556008)(66476007)(66446008)(66946007)(64756008)(110136005)(4744005)(76116006)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blJQMDQrbE9YL3d4cmg0ejBNbTFIVFdMWTU0M0JibkhuTHIyUUJvQmQydFFw?=
 =?utf-8?B?U1hOeG44L2hYakxqcUE3bklXZnVMY3pmZEEwQ3RIaUNraUdNbFczKzRBM2dF?=
 =?utf-8?B?YXlVK0lyY3oxVWRXOEFEakVnWW1GYldCRkZEVWJVU0JwYVk1RG5jU3dURjZv?=
 =?utf-8?B?UHpHaXU0M0hCaVZrU0pWeS9mTlh4OFlnVnhCeEgwNXY1amM5Wmg1cGdiZkxk?=
 =?utf-8?B?U0NGOHBRT29lV2ZERnpvZnJEZExMb1FBa29HSVhwRm1EZ0I0V0UrTDkydDFy?=
 =?utf-8?B?VStjOEFHalloZVFueS9PSWxudEtRRmVDSkRaZDhKeGxyK2Q0UFBiQjViQldq?=
 =?utf-8?B?Sjc2N0lOdWM0OHFmNklISzgwT0tWYW92OXlNUlFxVTF4NlZDTVNUd3ErQnBQ?=
 =?utf-8?B?a3RsUDk2R2xWWXZVZ0pxNmpubEtCSWxKTWk0WmxCVktrcC81NGx4NXFmUXN4?=
 =?utf-8?B?NWJLWGRxU1kvdnY4UWt3d2lBZWJoYVZuanNUR1l0eTduR0NNMWgxTnBaUTBR?=
 =?utf-8?B?UFFrbUdYcmI1WEhmNkpwaTVHd1luNlFqMnB4MUw2Y2VvNEJ2NnhIMkNjem5t?=
 =?utf-8?B?UFJWQk9SZ2JDWmF0Z0ZwbnpobTgyclZ5bTlKdmNlb2NOWUlDWnVzckNMMnVj?=
 =?utf-8?B?VHNxZ3UrRDFOd0I2dW5EWVNEbWl2bEduUHY0d2I4Z2c0NmkrQXdyUk9oRjJy?=
 =?utf-8?B?eTZYaThQYyszWXBGTzFWa0k2S1M3Mkw3YVZWSXk1S3ZIcFRQQ3JPSERKNkVk?=
 =?utf-8?B?WUJHdFBzYUFCWSt4ejdRa0tTdlVBeTNOZmJkb0FPeFZhM2g4MmhOdTlOV2Jv?=
 =?utf-8?B?TDRBdEFsaW1tRnBYTjB3MWJrNkFKbFBJZ0ttYzJBTk04NTBrdlgxSEhMWUYz?=
 =?utf-8?B?ZUJQS0t3VU5ybzRQTStQZk01bDlSQTBvSTF0YnFJTnp0VmhNNHdjZmgzSlNG?=
 =?utf-8?B?dVhPd1V4ZTc1NXpOUUl5eFZNekNoYzNuV3IvZG84N3JGSE9FM0VpR0wzbWRY?=
 =?utf-8?B?cFA2MU9Tb1k1M1NnZDMyV2xyVlhmcS9FZ1hEc0JWM3M2eHFCSmpNMlBsVW9v?=
 =?utf-8?B?L0s2c0NGdmtqODQxTy9ETEFjNFVzTVhjTG9aNW9DTHNmbEdpMFdrMWdvMGdW?=
 =?utf-8?B?WXVKdURTaENiR2lKcWdvamRDb2x6RjRGMTgxdVBoWTIxNUl3dmxiYXBwYTFH?=
 =?utf-8?B?RGh1a0x3OGpzSFBZTzB4UHNSM1U5RTF2NmdWYVFibndodTZ2bm5PVVk2aFVY?=
 =?utf-8?B?S3FDQ09pbjduUXRDWXlMblBKa0ovZVZ3S3ZyREhuWklvL2pNQVNkM1Axd21N?=
 =?utf-8?B?YlVSUnhOMVA1b3RZb1lFWGZpMW4veXl0SnBaWnNWaUxRRStNeW4wZHdxazBy?=
 =?utf-8?B?NE16K0pHQ3VucVA1ZGNVOW1ibGJwL2tTbEFvcjkvbkFoTGwvZzUyOWlkQThu?=
 =?utf-8?B?Z3Jzd3hhRmpaaUNVamcrYXVPVUFVMFZ3QnA4NjY0S3MyN0VsQVd6NmdudGhD?=
 =?utf-8?B?Y05HWmlsMEpWQ1U0LzYxeHp6R0FzcUFPTEtETmVKd2dEQ0xhQllTZDhPSll1?=
 =?utf-8?B?endLOVdKVkFzNGY1dENPcWhZaHhQcXh3V2I0ckhzWUtHWHVrUFl6UmZTSXph?=
 =?utf-8?B?STJncUFLY3B1SWl3VTZVMWREMmhTMXFwY0krMG0rWml2b3pPbjZNY3lxeG0y?=
 =?utf-8?B?WHVtcjN5bEE2TUhrRnVwNVZRZjJZT0xsQ24rUUVJUEtiMDhaK1Z6ck05SXBD?=
 =?utf-8?B?NWxjSGdEU0N2NjBjcDFsRTFqNGk5L25sWEhPMjNTZEExdlNueEJ5dVdzeW5U?=
 =?utf-8?B?VUxxVHppZi9FTDN5M3lldkVZeHRqdlRJUlBXV0lHYXBXU0w4UWJaRU1OZTdk?=
 =?utf-8?B?TmF3dkVXNjliOXZONk1KV2xvUzF4dDBUQ2hyS1U3ODdmaDZaWjFDOFpNOHgv?=
 =?utf-8?B?WmplNy9sMU1YcFY4aWxDbjlvZkJ6UzNJRFh0V3JFSG51YkwvaDZ1cm1sVUVX?=
 =?utf-8?B?QmlnUlRmY1dxcWlTMTc0N2pXYXNRN0pxV0pBd1dqdTRQdlhLcHl6d09NTDAr?=
 =?utf-8?B?ZUhwRmc1OUZmYWg4OEhBN09iUFRDaTkxWEVCL1B4dXloZlJlSGVKQWZoMGQ2?=
 =?utf-8?B?MWdJam1ibXpHL0luVDZxZDc0eG5VYisrVFBESnBJMkhOa0xQMEpHcjhIOHZN?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90C779592C10404E9404BEA2E7A74C76@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6263.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f8ed75-a56f-4725-0cf2-08dade8a2aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 10:50:22.9873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Bhd/0n1MDtfsj40PInQo2Gnjd8JRMolLbgFKkyQ8k/xzzmSKlLDYFgniKZk8cnr+c3S4825YUt/xgud8b8rZYRU4CEN9CbgeSgT9OpbALI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEyLTE1IGF0IDE3OjMwICswODAwLCBJcnVpIFdhbmcgd3JvdGU6DQo+IEZy
b206IGt5cmllIHd1IDxreXJpZS53dUBtZWRpYXRlay5jb20+DQo+IA0KPiBzb21lIGNoaXBzIGhh
dmUgbXVsdGktaHcsIGJ1dCBvdGhlcnMgaGF2ZSBvbmx5IG9uZSwNCj4gbW9kaWZ5IHRoZSBjb25k
aXRpb24gb2YgbXVsdGktaHcganVkZ2VtZW50DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBreXJpZSB3
dSA8a3lyaWUud3VAbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBpcnVpIHdhbmcgPGly
dWkud2FuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9t
dGstanBlZy9tdGtfanBlZ19jb3JlLmMgfCAgNSArKystLQ0KPiAgZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tdGstanBlZy9tdGtfanBlZ19jb3JlLmggfCAxMiArKysrKysrKysrKysNCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQoNClRoaXMg
bWF5IGNvbmZsaWN0IHdpdGgga2VybmVsIG1haW5saW5lIHNpbmNlIG10ay1qcGVnIGZvbGRlciBk
b2Vzbid0DQpleGlzdC4NClBsZWFzZSBmaXggaXQuDQoNCkJScywNCkpvaG5zb24gV2FuZw0K
