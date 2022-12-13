Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1893864B760
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiLMObQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiLMObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:31:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4772420BD7;
        Tue, 13 Dec 2022 06:31:06 -0800 (PST)
X-UUID: 7f124fa97f674adfbaa906c5b97cb1cf-20221213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dIuHXzLUQBLDktJzW6ZzE0LA/DAeF/XfX0PXypiYsaY=;
        b=hviiE3jTQ/dDKnfzWo9H7cdVFQdVCjPgs4h5XzlesgQ7kA5iGkgbRG+YpfwEJK1KSPtkC5gsfFL1Fo3YGbtuwrOHdeKjqTFaq5s3AtdlUOp5BKWSBHxUbFAzT4WX08YVTP0cfEpGl8ho7+eER2yjS0kyHgLAoISAprP8WQ22Qos=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:de661393-4f8f-48d8-8ec5-5aaae0221593,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:bec32a25-4387-4253-a41d-4f6f2296b154,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7f124fa97f674adfbaa906c5b97cb1cf-20221213
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1735080448; Tue, 13 Dec 2022 22:30:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 13 Dec 2022 22:30:54 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 13 Dec 2022 22:30:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZLmgZpKDrti0s5vE1tpQcyQmsCNTmz4J+bQaVtGF3mGO/tITDEK9cyKI6A9jE+Rwv+ApKLmJ2GZZ7otvcsUdbpHUlHYpU1pn0Sk48c4NDIhrivPU4D0yOgAQAlcEhIE47aHRPArcnjnpz4k+VGK6kVm/yK09sV3X0eYiPtr3uU5Ju2bKPvhYA5SBaEkcto9yVuVsqyBN5Wtwa4V+1OZ08dFxY3w4xkwpibe4i72qQRI1/+WQZl/sqBhOYS3IiYEVObsnkokzOJXwWLuO0nEKdF89W5FemO7P+waqJ+QlxVRA0/+riFkjHUyU3MFm6mLJxU3E4nXJH0UMS274b1EUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIuHXzLUQBLDktJzW6ZzE0LA/DAeF/XfX0PXypiYsaY=;
 b=GJ5qteGmD1pp2JXA0r+OH43wi3JLZWFxPvM3FKPVRyy1nG6i6Bxzb4DDIX5Bh0tEMrOrrpQeJ5UpOjTCCYZspPfQJ58gMTP8RkohEOr19aGxLYtgvYyxG/JBfPJwH7yiy7abfChZOK7vs+CiyxITWokZ8fIK9w/jF7Hq6ZfUIma0t1/53mAy+c3Q3u+fD0Wy53aAOneQZpxroIy+bTtRX3xEzmfkq/3oSKmOUFMK5+CwdqvUqQnXM/V/qjm091b8sDw8tAlhurg94pZjiE9h9b6yr+2+BBn37386bomOOza02mPGdyl9yL6dfNcz5NSgUe8ff+ien5/nmBWwoUMp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIuHXzLUQBLDktJzW6ZzE0LA/DAeF/XfX0PXypiYsaY=;
 b=q+UgDvOqGDsXsf5rHOP9B0pLoW5IsokyK5Acrpe1gg8nr9GBVlWVIRWCRfO2U1nHoSJjmPTO+MYRkZxGIGzGjM/ILIoafp+/4mOubn094/DtwMHMYoBdqcHj26+M1abATey9uBoyChK44SGjVvGgc8N3vxDlfuTXuQWaUiQ5ngE=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by PUZPR03MB7233.apcprd03.prod.outlook.com (2603:1096:301:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 14:30:52 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 14:30:52 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
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
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 05/12] ASoC: mediatek: mt8188: support etdm in platform
 driver
Thread-Topic: [PATCH v3 05/12] ASoC: mediatek: mt8188: support etdm in
 platform driver
Thread-Index: AQHZCrW4CMhbIjiEPEeT+A8sHHkrza5rqqAAgAA+8AA=
Date:   Tue, 13 Dec 2022 14:30:51 +0000
Message-ID: <b7ef068fa748c145d98161f6e0933f6cb5f3eb5d.camel@mediatek.com>
References: <20221208033148.21866-1-trevor.wu@mediatek.com>
         <20221208033148.21866-6-trevor.wu@mediatek.com>
         <869cfa5a-2cfa-e5b7-b8f5-a79b9b364b25@collabora.com>
In-Reply-To: <869cfa5a-2cfa-e5b7-b8f5-a79b9b364b25@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|PUZPR03MB7233:EE_
x-ms-office365-filtering-correlation-id: 6638739c-25c2-4c30-2b9e-08dadd16a2fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jbxZX/pNc9I6VIlE0FUVRDPv4Wwabr/8Uq9uHNkmx2x6hO79TEGrv1ZohXLgRIklCr+PM06oA+32IDuBuEbarOePaiHXIFPDxKfjUOTfgXhO58/xUkboQG3rtUOU6FA0b4EjX80VmEBsVrqfwSGcB3uErnt171cGaDvQCORsKcZV+7ocT2voP5qxsBseo8z4u0yd66a9/k9FLcF0QdqSIXkwub4ODF6XblffDotBeIof/v+nwTmMrfgfrKiahRrT6RUfPfRvK7OeXgm7Z9uhb6ObX2BENVCdq2Vk3FlEdLmgmw0/37oM7I2h/leXY74E86L6Yf34nFbxzYB5hJ7qOJgr8J+l18CczKcIla9Zy7fXr2pqqCLjMRbyeknIWIYLZ1N5u1Ze1g9FwzC2TmLdm1yD8ncbpTzGeFrOEOaWN4vK4TDYu9ggic38YbHzutxHS9fcG9S5PA/4uOWK50ernEx4Fs4ikFzqRSmuNkkzErjG7t7asVo7nnqvtbpslPzdS0On1MEEhs0Ekjv6sxSJuvJjTWO1QtbAxr0eexe05GkuP9P/624vXOVAg+/AAX4y8ewocSKV6aGm/ODOZQ6LXfvpBip5z8v027w5os9xz56QSaQQwFo0P3RA8K0gPjCzEQr2hhTktDaTjuzBNt0cQPAtfBYtpOG5RPzo+DAbs5KmvKV3JdWgcqLNQsoPh7Cd8fc8gieGaIS/z3KWH7HulMoPmgrPg0kr45pit+s97O/KFUBzttSmWRc7IgSTPs1WsF4mOmXBWHusVmIr3tJnUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(316002)(6512007)(6486002)(71200400001)(110136005)(54906003)(64756008)(66446008)(478600001)(85182001)(36756003)(66556008)(186003)(6506007)(26005)(66946007)(76116006)(66476007)(4326008)(4001150100001)(2616005)(2906002)(8676002)(7416002)(8936002)(122000001)(38100700002)(83380400001)(5660300002)(38070700005)(86362001)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGNRR3ZNVmtjVkJZeTRpd29lRGlPdzJLK2h4R2F4RGdSUWRrN0U1RS91aHZC?=
 =?utf-8?B?VUFzVzkxaVVaNEFHejZtL1NQVmVQL3RqVzVERmdIcnJvVVIrWUxTZDltWXZv?=
 =?utf-8?B?RTRKNHNuYkhWUWZpb2FIVVFUa1g5UC9CTFVPdEQ0NGZYeHlmZFB6TUl2Wjlz?=
 =?utf-8?B?Ym9NL2FYR0QzeDVvTUNPL1JIME9VRksrV2hUcUxZdWh1NkE3MzhENVp1aG9F?=
 =?utf-8?B?bUc0MnFWbTJNT3RpUnpqekNtWGtoMC9USWZmRlh5dDIvOFVheklFTHVPbkJl?=
 =?utf-8?B?L0IyblROb1F2azg5NWtDNkVSZ3RvNGd0bW9WVlRZQUZsYi9LVUd5M3hKNGxh?=
 =?utf-8?B?bGkwUHNpKzJIcm01c09xSW9lVy9pMGlnWTI3RXNGWi9IMnZoaUcvaUZUUkJu?=
 =?utf-8?B?cno3Mjc3VWx3OVJ2Wkw4M281aHlFQTVRYzBzVmVGREcrREVwZ1ZyR2V6aXFj?=
 =?utf-8?B?TGQzNGpVQjFsL2Z2bW9yNjZ1UGtqVTVobGVDY29sbFFPVlBhVWxIbHNORGt3?=
 =?utf-8?B?dEVqRXlXUGdJV0ZTUmpDSTlHNlZqcmx1NFZSalBPNGlFVGFyNFhDYXkraDBk?=
 =?utf-8?B?WEtUcWNIOG4ybjFKVVVaRlJyQnpsTmxNLzFBUDFGRUovWndOOGFyWTZ0bFdS?=
 =?utf-8?B?VzZtd2NuZUJGdWRwTEc3aG9sWEw0RnlKSG90bnZTR1FEQTRyNWZaQ21ZeHlz?=
 =?utf-8?B?VWJTV2pRdzBTb2NEY0wxczVJU1M0R3Z4T2w0ZDliRXF4cHdnOGtsTzVZN29T?=
 =?utf-8?B?VGRzVjg5ZUJHUEhhUm1keWhEemprQ0tFaWkrNCtrTzBrNndGbTZGckpFMFN3?=
 =?utf-8?B?VXhWV1c0Nk0ySFNYeHdoMUw0TWZZTjViakVxSWhrYmdxQldDL3ZxZkxsTkc1?=
 =?utf-8?B?R2ZJb0s1N2Q1U1R6a0c2SlNlVGczRjZlMnk5V0tKRjhGT054cFp6a2VFaFVX?=
 =?utf-8?B?YW5pVEZZZ3FseTR0UzJrRTloV2p0ektoNU9UbmZsSVFpdGZablJ2OFZITHZK?=
 =?utf-8?B?djZNUmRMUWVSbEdzMjFqamVaMEFndWp4RTB3SndkNWE5YlozNG5aTlpTVmZ6?=
 =?utf-8?B?K2Z0UUFuVHYxWklWU3BlRjNJSXV0NlBKQ1BZaFFnK3ptclo0dk5GSk5XQk5p?=
 =?utf-8?B?NUZDbEdUYnlyYjZQeDhkM3lRVy9pM2IzMDBQRzZwY2lvWm4xYnVPVEt6R0pS?=
 =?utf-8?B?RDJTTVNWMGNCMkxBeFdBakU1VHljem80VDhCYXM4Zm03Q2g5bmpRTU1mcFJs?=
 =?utf-8?B?L3dMbVZxa1hDQmtzclJJQm02NzY1aWFwVlprcC9PWGZaMENLTGcyUHlGSndu?=
 =?utf-8?B?S2N2YWtpdkRSTExScTNIQUtwTHZQZ2dMejNzQ1YyOFVYQ05YdTZSWTA0QkUv?=
 =?utf-8?B?cVFVK1d0dm1vdHVCazNDbFRpeWF2Q05vbFlKc010N1hodHRvcHJhdlU3RmJ6?=
 =?utf-8?B?UFZOc2YwclVSZWYyNERCMHVUZHFrdThEd0lOc0J4SkduUzRDdDJMdkRKTXgv?=
 =?utf-8?B?dzJic29sNWRRY2M4Tk9wakQ3RDNhSjcrZzN3bDFJRlFsdGIxTVcxVUE3andv?=
 =?utf-8?B?MnBjWFhYTWt3Z09ZcmhuOW1sZlpBV014dStWMWhySWtxQUk0R3g4VFZoRXhB?=
 =?utf-8?B?LysrcHI5Uk1MNTJzV09BQVdIdmdVYWIxWjBVa2dmMTZ4VnJFTWIra0ZXVy9r?=
 =?utf-8?B?R0hwSTlZVDdmYWRtRXI2ZUl3RG5jdWFQVnVISmd3NTNuaFdhakRqM1JLdlpC?=
 =?utf-8?B?aVZ3cXBKUU9mdi9XLzc1b095TUgvOGlYVHo1TnFyL0tBOU9BeUxNN1hVS3Iz?=
 =?utf-8?B?ZUQ4NjZPL0ZjQlpvYmZEbzRtK0dYOUFGcVNJd3JuMTVOd3g1aTlhZkN4Z0dI?=
 =?utf-8?B?cytYUEwxaDRUcmw0RkpZampQdjlVQWc0MFF0OFdKZGJOZ2VPbzhCenBicWtp?=
 =?utf-8?B?MDRwNTVYOE1DOGQ1ODJJUmNIbktvVGZlTHhvK1dZaWlkNGNnLzJ5OFRPUkdS?=
 =?utf-8?B?dTIxeXdGMjdmMXNGZjhsczNEdUZ1Q0VBNmZ4QVBnUVliT0J2d1I5NjVrSzlh?=
 =?utf-8?B?MGlMNmhDdXJqL0YwNWVXVGNtM2dqQVl1aDNCUzE2amlhYkR4eEpEaWplTE5j?=
 =?utf-8?B?VnZvenpBOHg4dDV6bnZlbkJwLzBKWWFDWEEwLy9VZEtPU0RRZ1JRZmFZTjVE?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D67B09BCE6086245B055098F1384FBDE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6638739c-25c2-4c30-2b9e-08dadd16a2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 14:30:51.9110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7q/3jD98L0nKf6Wy9PifNxDdaUSJ5zlL7T9bHyZALya+bMvEn3kkLSjdQdbal3cZDPeqeOOWPIkaKEBlKK5Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7233
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEyLTEzIGF0IDExOjQ1ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDgvMTIvMjIgMDQ6MzEsIFRyZXZvciBXdSBoYSBzY3JpdHRvOg0K
PiA+IEFkZCBtdDgxODggZXRkbSBkYWkgZHJpdmVyIHN1cHBvcnQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogVHJldm9yIFd1IDx0cmV2b3Iud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
IEkgZG9uJ3QgYWRkIFJldmlld2VkLWJ5IHRhZyBiZWNhdXNlIG9uZSBuZXcgaGVhZGVyIGZpbGUg
aXMgaW5jbHVkZWQNCj4gPiBpbiB0aGUgcGF0Y2ggdG8gcmVzb2x2ZSBjb21waWxpbmcgaXNzdWUg
Zm91bmQgYnkga2VybmVsIHRlc3Qgcm9ib3QuDQo+ID4gQWRkaXRpb25hbGx5LCBJIHJlLWxheW91
dCB0aGUgY29kZSBmb3IgYmV0dGVyIHVuZGVyc3RhbmRpbmcgb2YgdGhlDQo+ID4gZm9sbG93LXVw
IHBhdGNoLg0KPiA+IC0tLQ0KPiA+ICAgc291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgt
ZGFpLWV0ZG0uYyB8IDI1OTENCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMjU5MSBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgc291
bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtZGFpLWV0ZG0uYw0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1kYWktZXRkbS5jDQo+ID4g
Yi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1kYWktZXRkbS5jDQo+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmM2NTNmYTVlM2Y4NQ0KPiA+
IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4
OC1kYWktZXRkbS5jDQo+IA0KPiAuLnNuaXAuLg0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lk
IG10ODE4OF9kYWlfZXRkbV9wYXJzZV9vZihzdHJ1Y3QgbXRrX2Jhc2VfYWZlICphZmUpDQo+ID4g
K3sNCj4gPiArCWNvbnN0IHN0cnVjdCBkZXZpY2Vfbm9kZSAqb2Zfbm9kZSA9IGFmZS0+ZGV2LT5v
Zl9ub2RlOw0KPiA+ICsJc3RydWN0IG10ODE4OF9hZmVfcHJpdmF0ZSAqYWZlX3ByaXYgPSBhZmUt
PnBsYXRmb3JtX3ByaXY7DQo+ID4gKwlzdHJ1Y3QgbXRrX2RhaV9ldGRtX3ByaXYgKmV0ZG1fZGF0
YTsNCj4gPiArCWludCBpLCBqOw0KPiA+ICsJY2hhciBwcm9wWzQ4XTsNCj4gPiArCXU4IGRpc2Fi
bGVfY2huW01UODE4OF9FVERNX01BWF9DSEFOTkVMU107DQo+ID4gKwlpbnQgbWF4X2NobiA9IE1U
ODE4OF9FVERNX01BWF9DSEFOTkVMUzsNCj4gPiArCXUzMiBzZWw7DQo+ID4gKwlpbnQgcmV0Ow0K
PiA+ICsJaW50IGRhaV9pZDsNCj4gPiArCXVuc2lnbmVkIGludCBzeW5jX2lkOw0KPiA+ICsJc3Ry
dWN0IHsNCj4gPiArCQljb25zdCBjaGFyICpuYW1lOw0KPiA+ICsJCWNvbnN0IHVuc2lnbmVkIGlu
dCBzeW5jX2lkOw0KPiA+ICsJfSBvZl9hZmVfZXRkbXNbTVQ4MTg4X0FGRV9JT19FVERNX05VTV0g
PSB7DQo+ID4gKwkJeyJldGRtLWluMSIsIEVURE1fU1lOQ19GUk9NX0lOMX0sDQo+ID4gKwkJeyJl
dGRtLWluMiIsIEVURE1fU1lOQ19GUk9NX0lOMn0sDQo+ID4gKwkJeyJldGRtLW91dDEiLCBFVERN
X1NZTkNfRlJPTV9PVVQxfSwNCj4gPiArCQl7ImV0ZG0tb3V0MiIsIEVURE1fU1lOQ19GUk9NX09V
VDJ9LA0KPiA+ICsJCXsiZXRkbS1vdXQzIiwgRVRETV9TWU5DX0ZST01fT1VUM30sDQo+ID4gKwl9
Ow0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBNVDgxODhfQUZFX0lPX0VURE1fTlVNOyBp
KyspIHsNCj4gPiArCQlkYWlfaWQgPSBFVERNX1RPX0RBSV9JRChpKTsNCj4gPiArCQlldGRtX2Rh
dGEgPSBhZmVfcHJpdi0+ZGFpX3ByaXZbZGFpX2lkXTsNCj4gPiArDQo+ID4gKwkJcmV0ID0gc25w
cmludGYocHJvcCwgc2l6ZW9mKHByb3ApLA0KPiA+ICsJCQkgICAgICAgIm1lZGlhdGVrLCVzLW1j
bGstYWx3YXlzLW9uLXJhdGUiLA0KPiA+ICsJCQkgICAgICAgb2ZfYWZlX2V0ZG1zW2ldLm5hbWUp
Ow0KPiA+ICsJCWlmIChyZXQgPCAwKSB7DQo+ID4gKwkJCWRldl9pbmZvKGFmZS0+ZGV2LCAiJXMg
c25wcmludGYgZXJyPSVkXG4iLA0KPiANCj4gSXMgdGhpcyBwcm9wZXJ0eSBvcHRpb25hbD8gSWYg
eWVzLCB0aGlzIGRldl9pbmZvKCkgbXVzdCBiZSBhDQo+IGRldl9kYmcoKSwNCj4gb3RoZXJ3aXNl
LCB0aGlzIG11c3QgYmUgYSBkZXZfZXJyKCkuDQo+IA0KPiBQbGVhc2UgZml4IGFsbCBwcmludHMg
dG8gdXNlIHRoZSByaWdodCBtZXNzYWdlIGxldmVsLg0KDQpIaSBBbmdlbG8sDQoNClllcywgdGhp
cyBwcm9wZXJ0eSBpcyBvcHRpb25hbCwgc28gSSBkb24ndCB1c2UgZGV2X2VyciBoZXJlLg0KZGV2
X2RiZyBpcyBoYXJkIHRvIGZpbmQgdGhlIHByb2JsZW0uDQpJIHdpbGwgbWFrZSB1c2Ugb2YgZGV2
X2VyciBpbnN0ZWFkIG9mIGRldl9pbmZvIGluIFY0Lg0KDQo+IA0KPiA+ICsJCQkJIF9fZnVuY19f
LCByZXQpOw0KPiA+ICsJCQlyZXR1cm47DQo+IA0KPiBBbHNvLCBpcyBpdCBwb3NzaWJsZSB0byBz
cGVjaWZ5IHRoaXMgcHJvcGVydHkgb25seSBvbiBzZWxlY3RlZCBlVERNcz8NCj4gDQo+IEFzIGl0
IGlzIHJpZ2h0IG5vdywgaWYgYW55b25lIHdhbnRzIHRvIHNwZWNpZnkgdGhpcyBvbmx5IG9uLCBm
b3INCj4gZXhhbXBsZSwNCj4gZXRkbS1vdXQxIGFuZCBvdXQyLCB0aGF0IHdvbid0IHdvcmsuDQo+
IEluIHRoYXQgY2FzZSwgeW91IHNob3VsZCByZXBsYWNlIHRoYXQgcmV0dXJuIHdpdGggYSBgY29u
dGludWVgLg0KPiANCj4gUC5TLjogSSdtIHJhaXNpbmcgdGhpcyBxdWVzdGlvbiBiZWNhdXNlIHlv
dSdyZSBub3QgZm9yY2luZyAiYWxsIG9yDQo+IG5vdGhpbmciDQo+ICAgICAgICBpbiBjb21taXQg
WzEwLzEyXSB3aGVyZSB5b3UgaW50cm9kdWNlIHRoZSBiaW5kaW5ncyBmb3IgdGhpcw0KPiBkcml2
ZXIsDQo+ICAgICAgICBzbyBJIHN1cHBvc2UgdGhhdCByZXR1cm5pbmcgKGhlbmNlIHN0b3BwaW5n
IHRvIHBhcnNlKSBpcyBhDQo+IG1pc3Rha2UuDQo+IA0KDQpJdCBpcyBPSyB0byBzcGVjaWZ5IG9u
bHkgZXRkbS1vdXQxIGFuZCBvdXQyIG9uLg0KVGhpcyBpcyBqdXN0IGFuIHNpbXBsZSBlcnJvciBo
YW5kbGluZyBmb3Igc25wcmludGYgdG8gc2lsZW5jZSBjb3Zlcml0eS4NCkJlY2F1c2UgaXQgc2hv
dWxkbid0IGhhcHBlbiwgSSBkb24ndCByZXR1cm4gYW4gZXJyb3IgdmFsdWUgdG8gbWFrZQ0KcHJv
YmUgZmFpbGVkLg0KDQpUaGFua3MsDQpUcmV2b3INCg0KPiA+ICsJCX0NCj4gPiArCQlyZXQgPSBv
Zl9wcm9wZXJ0eV9yZWFkX3UzMihvZl9ub2RlLCBwcm9wLCAmc2VsKTsNCj4gPiArCQlpZiAocmV0
ID09IDApIHsNCj4gPiArCQkJZXRkbV9kYXRhLT5tY2xrX2RpciA9IFNORF9TT0NfQ0xPQ0tfT1VU
Ow0KPiA+ICsJCQlpZiAobXRrX2RhaV9ldGRtX2NhbF9tY2xrKGFmZSwgc2VsLCBkYWlfaWQpKQ0K
PiA+ICsJCQkJZGV2X2luZm8oYWZlLT5kZXYsICIlcyB1bnN1cHBvcnRlZCBtY2xrDQo+ID4gJXVI
elxuIiwNCj4gPiArCQkJCQkgX19mdW5jX18sIHNlbCk7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gDQo+
IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo=
