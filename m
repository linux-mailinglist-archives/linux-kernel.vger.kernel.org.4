Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A303B68D2F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjBGJh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjBGJhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:37:24 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA4E44BE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:37:19 -0800 (PST)
X-UUID: 01118d72a6cb11eda06fc9ecc4dadd91-20230207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UXklP6hvH81dLp4vjHEjJRE+LeaTeSNVLCBwDLz9l/c=;
        b=TE7ZuIXWh+2B9V76+RFJ0bJOCuvov3iuSytyQ/YiZRwrc4dGQ7vy9PNUAfgLbOKxRgvd/e4A+HDfRG7HIl7o5Q9LbwVN1G2KzWZCXQbMfkRus1Z5WqitnsXJib3Ls+i4DHN/WwqlOgTx8+IHJmZc6N/Le/vXgAm3RcNKjQj6RVk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:787e961b-2d29-4b31-bfbb-cd21fba55307,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:fbaf8d56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 01118d72a6cb11eda06fc9ecc4dadd91-20230207
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1169950387; Tue, 07 Feb 2023 17:37:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 7 Feb 2023 17:37:13 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 7 Feb 2023 17:37:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCMr2kNQTkXMV1ythWQc32nmnx/KPCopidn3nGmGZMEoldFFn4wrazDN7QP0EJcQWIqPwYKpjkLPGN3pztB/V4ku7OmYoQPcgSM05NerXiO7x+Xb1PwqzGReCjImWqDSyxlMwMS5USeOA5Bog/9Xc8m2EjcA8JqdKyJGZxDxbj0fJlvxjFyJcT8xMRJVZbXZiVTy99H6QPMaVb1+xzmgggRJjDSJHdD0Sg9BDvnKtrrjCH1UQRCu4EE0zS90Y6ryJ9+f3OaVdpAUuXzA7QrE2elMyiieg4WexmboHtNE4X7/tre0RKjELDNUiqIbSMG+hk4Q0sMH60rW+juPICyuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXklP6hvH81dLp4vjHEjJRE+LeaTeSNVLCBwDLz9l/c=;
 b=Ut3b/awtE9rfu7eBsEu1mRv0uREfSEAOjOtDnItnikFKxlAyuNjtvHG9O5u0s8hmWs9c76lB0Bio/EhdlS9VZsBH98WtLFpwi+BWJdtjm4V+mWsv+C6jKTR7hkt1rEFakp7iWARrI3+N4S/zaZ979c/Q5VQRH5Me0Z0gw2lBm0/DSbxdGwnX8ydNZETsLx7X+7kgFxQhZ/3DKmkXBt41JQEsyLgjDaiQKc4abCWlDsdc2QznC8MrwoqLp0wCszwpLrRJp7izjbNVcF6MvFfBvDS0XkqFlWhLmgjIH5cFFrEgQEHDGlDqYWhK42YQFuBaoQ7RNm2QwM7CuqJSnBDPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXklP6hvH81dLp4vjHEjJRE+LeaTeSNVLCBwDLz9l/c=;
 b=ZtOdtalE6HI4cB6pwHZ8o8tj+jp6wo4nsLR71MJcafvRQdW5lK255UBtLmPr+9mVEcHR8H06Azs1iMlET3Brr4Bvps63TzKIvyHx3GMJqET6Rs5vUX8r8PQ0D1UsR4QLkukFl3Q3dfTNn8CySePKxX6k2iSZs+Cr7gg9ZKRwTvw=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by SI2PR03MB6784.apcprd03.prod.outlook.com (2603:1096:4:1ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Tue, 7 Feb
 2023 09:37:08 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1%3]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 09:37:08 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v7 2/3] phy: core: add debugfs root
Thread-Topic: [PATCH v7 2/3] phy: core: add debugfs root
Thread-Index: AQHZKxj7fxkP5kQWUUCaWx8rB9jLMa67uaiAgAefooA=
Date:   Tue, 7 Feb 2023 09:37:08 +0000
Message-ID: <f63868b6510eb2ec9c99925062dd0ab1c669f555.camel@mediatek.com>
References: <20230118084343.26913-1-chunfeng.yun@mediatek.com>
         <20230118084343.26913-2-chunfeng.yun@mediatek.com>
         <Y9u2nTgCcb/Et60d@matsya>
In-Reply-To: <Y9u2nTgCcb/Et60d@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|SI2PR03MB6784:EE_
x-ms-office365-filtering-correlation-id: e42b9cf9-58e5-41ec-1fcc-08db08eee1bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e6MZZwuCx1xOq5TsUEdhr1wZqa0UklKtXB9R8yJ6xg9vGzWpPD4zXtlGpYZsFfnffmT1vNilDIAkBAinsJxmyl5n1sQLWR66WtkRYW4Xe1MUOhJUw1t04T8UzVkd5zAhB5EiWS5zwT2uIcasysbk4B5hGClxYbnd2R631P3E6xjnfE9hCbbzdGh3VXt+vCWAh6vvSIq8fJK2gLubrPbbG7IDIpXPHAOg7kQe0li9f5COPTmZDTA8jn5MvMNE4oZt8G8zqqVhPXpFIRnWYbymxfdV05MRyT95ZV6pibk5QOlv6tgzGWYAh1oEv6UH0oxipCOF3QFV0X+Ir3yOj03L0YrjsmTu4Yw5ulh3ntj7f5qF7R68RuAFGiJNTPv98g1lxADpcxTClYUegkcRlLa1VAKBafnSDeteQH3wX6Z5xA3XrG0p9u2DHGuNIuy/RjiaMWxQ40C051DSD8Se9ffz1lyTtkpOzxsS+Sq4+dhgDoBCtQEflQMjpuCB6gfFSgEtjg03AxRrc3mci0XNBlGNa0BLWanW1tt7k+Cy7uPDhLnDTsDRCnMJ6cHZH7UgFApA4BHiNz+AcHZyHTgB6gwHEPA9ZIDUXYxMe/X7VdFTZlLQav4LxJU7tDYgXE03w41XgYDKZ1rsDvgtwOYqVt/wFAtoS9yNOQBHLcVOnuePXpfXEcHDfwApdMW/UAaXKv6OzsjgVKbGpWNus5QwegrPRYNmflxmZ5NqY5aTtqXFqj04hqRnoA+vXlkqwj+msacSGL3DpzkBOLRwjYQgdaff/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199018)(2906002)(86362001)(36756003)(85182001)(478600001)(7416002)(26005)(186003)(6506007)(6512007)(8936002)(91956017)(71200400001)(6486002)(2616005)(38070700005)(53546011)(41300700001)(5660300002)(66556008)(66946007)(316002)(76116006)(4326008)(64756008)(83380400001)(122000001)(6916009)(8676002)(66476007)(54906003)(38100700002)(66446008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0tHZVkyQTVOVWpFVXZWNnpYaDNKUnptaElTUGVFVUk3dEpTNGdlNS9CaTJH?=
 =?utf-8?B?blFFeWhLM2FIWnUvMGc1N3NCaE9IdysyK1VWUFpNaDNwM0t5REZ0bHhmTVk4?=
 =?utf-8?B?MkpxakoxTWluNko0anlaaWNBNTZieHNXOFVKaHpzU2t4dHRhTTlzdWZHU2dE?=
 =?utf-8?B?SE5wd3dDSGh6K0l1blM5OXhHTmZPMlorZTRXYk5OKy9aTEhGaUhCak9LTTlm?=
 =?utf-8?B?Znl2ZzdnaXJ5OWd6VmhMUHRlLzg5Y2VlakNkYWRDWlYxam1hWVlCWGhIcHY1?=
 =?utf-8?B?T3hqSHV1UEFMbVBwTnhhQzVGS0lDNm5sRVhQTkFXSGM0VGdZaW9LenlLQ3JJ?=
 =?utf-8?B?c0VGUDhnenlGYW9Xbko5RHMydlNTcXAvbU5JRlQvUjdxUnZFaUYxbnBiLzhI?=
 =?utf-8?B?OUd6QW53NmRGRjRTc01uVTlNb3BZUmJXUTdLbWRDR2hRQzFFTGplZC8rVlZx?=
 =?utf-8?B?c2I4RHlSRXk4ZzNyUHlFa3FlN1doZHpZaXhFZkJhQVdOSSs4OU5iRVZKZFBx?=
 =?utf-8?B?MjVDUldoSUt4ZzFPTzRXZFkyUk5mMmxTL2FDWDJLYVlZMnNubXo1MUpFZE02?=
 =?utf-8?B?RC9IYzIycS9LdWZkQ0lwNGMyOVE3NTV0MytBMHAwMGQrL09IOGgxUWlFMG5x?=
 =?utf-8?B?VmtleDd3MjZZSjRUZ3dhOUw2eGFFRWlQcWdYZzIvV2hNS0RZdFVVNE9CdUlz?=
 =?utf-8?B?MFlBODVDb3oxdzZPdzBYVlpFcUxPTjNPcmw2U3ZITGlyVUZPbXdDWllaOEdQ?=
 =?utf-8?B?SlFJNUZJY2piM0VhdXB0T1AxaWUvUVFFUDZiU0FLTTdxN3MyTXN5anhrTVNZ?=
 =?utf-8?B?NVdtL0UrZm5NcVREYzB2ZWlVZ1NOSHArYktMWnB1aGpjWlRFNE5BV3VRMGtI?=
 =?utf-8?B?NkUvSS92OXprQTRCekJHMlpyU2NiUlJHY2hJbnZ4M25JdTdRZ0dJQ2JLUDFS?=
 =?utf-8?B?NVBndFBaZWRFczRIeldPelBNWStWK21Ldnl4TzRQNzdGQjlHZ2VxdjVMM0Ix?=
 =?utf-8?B?bEtUbEZvSXpiQkx5Ry9vQWtDMjdBOTlkRTV2cU1McGlsNFF4Mk9xdmtLZzBP?=
 =?utf-8?B?UTZKZ0RUMWlMVTBKWGFYQXFvOUJUakl3cjdRTE94cThuYVBsSGlZUXlvdlo0?=
 =?utf-8?B?RXUrYUNRYVhPdnE4UEJYN3NFUGFlMDhnT1M4a3lQMHJXWHZlVXhsYkhocVhU?=
 =?utf-8?B?ei9waXlxVGl1bTk3L2dra0VLVm9KUkRYOG44OVhmelFJbk8zT2IrY2JGU2ty?=
 =?utf-8?B?Z3Z1ZUFSejZnNEZqamF5NGVEdXU0Tk82dGd6M2phaDY2UGdhcS9Oa2x4bFFr?=
 =?utf-8?B?R3VjbHMydkZ4WkllWmFQSlpwbGVzOStzcklDUDdIRWtnb1A5VEJCZ1RpOGhE?=
 =?utf-8?B?eWRRWmV3ZlRuOFpuTHNhbzhtNEZmNmc1bFlUYXlPN1Myb0Q2RldrN2s5bUpG?=
 =?utf-8?B?SU5FbWxYUGJ6enN4UkQxK0ZVV1UrQWRKeHNEd1o1aGJCWmY1L2NPcWlhdnA4?=
 =?utf-8?B?V1I5VURsV0ZCNDRQbG11Z3JhVlpaUURsVlVkb1Y3ZGFwd0RWQVhzbitSR3JK?=
 =?utf-8?B?aSs1TlFKcFNHTTZRWXJ1QW1jSUtQbFdKVXNVeDF4R1hFbGwwWTlnZGk1SmhN?=
 =?utf-8?B?L1JlWWNLdkVrN3YvS2VBSHo5dklUaDlYcllwZ1FCVFExUFNjL0l1UVBGSGV6?=
 =?utf-8?B?YVpldUNCbVBNdXNVV2U4OUtPcmp3UUlhZG9aUTNGY3FQT2NBaXk3VU5RVFBZ?=
 =?utf-8?B?MG1lM1Z1M2xkTzhlUmxjOEJER1l6QzlpdXBMV0pWT3lLcGRCUmtKTzdqdzRj?=
 =?utf-8?B?MGszUGkrUnlIRThsNDdnNjVWVEpka2kveHVpaEJBS1Z0a0dFcVIyMWx4TUVk?=
 =?utf-8?B?OWNrNXFmajJjWEl5UGptUmFaSkdTRkpiVHY2d1F4WVNvdld2VU5rV3FENDNE?=
 =?utf-8?B?QmE0eUxDSjhSZUs2RUxIWkJCb21jK3ZUZHdZdkNsdCt5N2ttS0Rqc1Vta29R?=
 =?utf-8?B?a3F4ZGd0ZDNrcXdpWWZZVGFOR0MrY1lTam0raWVKNHBFZmtZUklMd3NuT1Rr?=
 =?utf-8?B?bitHclR4VUhMNG12aUF1aEx4c3k3R2tkby9uNkR0eDFpL1dOV1dRZUIrOUM0?=
 =?utf-8?B?RktnQStFRnZQMWZrRU53b09WYWY3ako1UE9XK2twOTdzVnRkQ2J4YURPQURk?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2671CB407A4477499D424E0C575038E7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42b9cf9-58e5-41ec-1fcc-08db08eee1bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 09:37:08.5382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIcNV0mEdobW8S1f0S4KJfOcWGLEk+IE0KbsTcjbkZXwTbR5iebLOYnHEA2KHD/+/Ex/P/WPet7NWYNbRCfiRdLb9us1kBUCGHCfCbgE3dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6784
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTAyIGF0IDE4OjQxICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBP
biAxOC0wMS0yMywgMTY6NDMsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiBBZGQgYSBkZWJ1Z2Zz
IHJvb3QgZm9yIHBoeSBjbGFzcywgdGhlbiBwaHkgZHJpdmVycyBjYW4gYWRkIGRlYnVnZnMNCj4g
PiBmaWxlcw0KPiA+IHVuZGVyIHRoaXMgZm9sZGVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2
Mn52Nzogbm8gY2hhbmdlcw0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BoeS9waHktY29yZS5jICB8
IDYgKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvcGh5L3BoeS5oIHwgMiArKw0KPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BoeS9waHktY29yZS5jIGIvZHJpdmVycy9waHkvcGh5LWNvcmUuYw0KPiA+IGluZGV4IGQ5
M2RkZjEyNjJjNS4uMmY5ZjY5MTkwNTE5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGh5L3Bo
eS1jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9waHktY29yZS5jDQo+ID4gQEAgLTExLDYg
KzExLDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2V4cG9ydC5oPg0KPiA+ICAjaW5jbHVkZSA8
bGludXgvbW9kdWxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9lcnIuaD4NCj4gPiArI2luY2x1
ZGUgPGxpbnV4L2RlYnVnZnMuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4g
PiBAQCAtMTIwNCw2ICsxMjA1LDkgQEAgdm9pZCBkZXZtX29mX3BoeV9wcm92aWRlcl91bnJlZ2lz
dGVyKHN0cnVjdA0KPiA+IGRldmljZSAqZGV2LA0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xf
R1BMKGRldm1fb2ZfcGh5X3Byb3ZpZGVyX3VucmVnaXN0ZXIpOw0KPiA+ICANCj4gPiArc3RydWN0
IGRlbnRyeSAqcGh5X2RlYnVnX3Jvb3Q7DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHBoeV9kZWJ1
Z19yb290KTsNCj4gDQo+IFBsZWFzZSBtYWtlIHRoaXMgYSBtZW1iZXIgb2Ygc3RydWN0IHBoeSwg
dGhhdCB3YXkgYWxsIHBoeSBkcml2ZXJzDQo+IGhhdmUgYWNjZXNzDQo+IHRvIHRoaXMgYW5kIHdl
IHdvbnQgbmVlZCB0byBleHBvcnQgdGhpcyENCk9rLCBJJ2xsIG1vZGlmeSBpdCwgdGhhbmtzDQoN
Cj4gDQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICogcGh5X3JlbGVhc2UoKSAtIHJlbGVhc2UgdGhl
IHBoeQ0KPiA+ICAgKiBAZGV2OiB0aGUgZGV2IG1lbWJlciB3aXRoaW4gcGh5DQo+ID4gQEAgLTEy
MzMsNiArMTIzNyw4IEBAIHN0YXRpYyBpbnQgX19pbml0IHBoeV9jb3JlX2luaXQodm9pZCkNCj4g
PiAgDQo+ID4gIAlwaHlfY2xhc3MtPmRldl9yZWxlYXNlID0gcGh5X3JlbGVhc2U7DQo+ID4gIA0K
PiA+ICsJcGh5X2RlYnVnX3Jvb3QgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoInBoeSIsIE5VTEwpOw0K
PiA+ICsNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gIGRldmljZV9pbml0Y2FsbChwaHlf
Y29yZV9pbml0KTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9waHkvcGh5LmggYi9p
bmNsdWRlL2xpbnV4L3BoeS9waHkuaA0KPiA+IGluZGV4IGIxNDEzNzU3ZmNjMy4uYzM5ODc0OWQ0
OWI5IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvcGh5L3BoeS5oDQo+ID4gKysrIGIv
aW5jbHVkZS9saW51eC9waHkvcGh5LmgNCj4gPiBAQCAtMjA1LDYgKzIwNSw4IEBAIHN0cnVjdCBw
aHlfbG9va3VwIHsNCj4gPiAgI2RlZmluZSBkZXZtX29mX3BoeV9wcm92aWRlcl9yZWdpc3Rlcl9m
dWxsKGRldiwgY2hpbGRyZW4sIHhsYXRlKSBcDQo+ID4gIAlfX2Rldm1fb2ZfcGh5X3Byb3ZpZGVy
X3JlZ2lzdGVyKGRldiwgY2hpbGRyZW4sIFRISVNfTU9EVUxFLA0KPiA+IHhsYXRlKQ0KPiA+ICAN
Cj4gPiArZXh0ZXJuIHN0cnVjdCBkZW50cnkgKnBoeV9kZWJ1Z19yb290Ow0KPiA+ICsNCj4gPiAg
c3RhdGljIGlubGluZSB2b2lkIHBoeV9zZXRfZHJ2ZGF0YShzdHJ1Y3QgcGh5ICpwaHksIHZvaWQg
KmRhdGEpDQo+ID4gIHsNCj4gPiAgCWRldl9zZXRfZHJ2ZGF0YSgmcGh5LT5kZXYsIGRhdGEpOw0K
PiA+IC0tIA0KPiA+IDIuMTguMA0KPiANCj4gDQo=
