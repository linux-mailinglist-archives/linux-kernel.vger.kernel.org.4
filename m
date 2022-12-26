Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D518655F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 04:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiLZDvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 22:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLZDu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 22:50:58 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C2DD77;
        Sun, 25 Dec 2022 19:50:53 -0800 (PST)
X-UUID: 1fb5700ac84944528736a5a1f3012afe-20221226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=N2BJTUnKUQDlu0GFNOqcbiL2qG+0tIfeyqwpDSJai/k=;
        b=CHUcCtBLJNf6snPLT4V/1HmXtFBfpMJmmNG/gX+cNjdBACqdfulJrDM4uwVWAJfZiaLTe+y6N3BqDEr5+KMStvMZoSkOif2XrCYOLMcsnvEBxSFjeHX3jcgsnzGz8oeIBW9kOAoBmy3mOdfQpBLOtf/ebf856ZyRl/hyRWRdhsk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:0b361aa9-ea67-4e45-ab6e-6f131d5b731b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:a7fac452-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1fb5700ac84944528736a5a1f3012afe-20221226
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1314284767; Mon, 26 Dec 2022 11:50:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 26 Dec 2022 11:50:45 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 26 Dec 2022 11:50:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQR4hxTFx9Qi0tsSfMlP9Qfl6pI7OJw1FeNJUq5WN8T6ygBx2xldQ1xazRB7WrE9Uc0MBvAQDhdvotsnaSOOGdamnd3Zl5vMHO6140/yZ7keJ/KFQ0EXBqyS0oHfT2KBPz2Eovl6UyHoGq76bkVcoE0wKe3dBmj9U6MMW/qky73HvKoJXoJNGbmdKMaRea5Sl55qVjwXf36ZAwwir4lzw83DQMKlthLlGNVcgl/gKG9t1vHzphOe4zjh6KOCaiVcmmXvoKgUlaxoVx8rQcJFI64Y4iN6oPoNvwFqLxu8MTYSSgmei+QJ0fxZh6567+cBjShX3f5Dme6EX0mMNisVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2BJTUnKUQDlu0GFNOqcbiL2qG+0tIfeyqwpDSJai/k=;
 b=eNWc1tbGUEZUiSrI8HvtzaZ2wUL8nnA+F2iuhJ8wJZYSs+0QRhlKgFnPqHof9xhloPkQMHR/fyAxFhqonHLlekQ7bXTGNvRP1ufivjkbpq1mfC+KvxoMdULQLKXfd2FpLRULSZ2HYgPbwPQMMLxl++GBXLnEEGzBLomejjFtkNprb1/TcWYNtAp/qFJiaAssLojdUKG8auZGqKyLPKOqg6X/8cHuo3e3ASXJXqPIPBEs/eHDEdZl5D8eEZXlXf/vjDbhj+LacFVWotl/riwXO4L9VbrLP/YLoNanYEweOpSpyL6W/ljQ75QzHagSn3nvv8JdjhDmZ1mhz5dTVSkweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2BJTUnKUQDlu0GFNOqcbiL2qG+0tIfeyqwpDSJai/k=;
 b=nRDvUe15ED4c5IW6jhjlquerkNuwRXCza/zLVcD37VzLhs75x6gT7xLyoDVx63ZixoqXyfX9xtxpuFY8MbrXfO+lVY0++d9y5KsfF87JUlYc2jSgUqZQpmoTfGXGWnETRfa1ntQ5Ui4gp9pF78WcVvFNXzwXURpXBw1MntfrNww=
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com (2603:1096:300:39::13)
 by SEZPR03MB6890.apcprd03.prod.outlook.com (2603:1096:101:a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 26 Dec
 2022 03:50:40 +0000
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56]) by PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56%6]) with mapi id 15.20.5944.016; Mon, 26 Dec 2022
 03:50:40 +0000
From:   =?utf-8?B?QmlhbyBIdWFuZyAo6buE5b2qKQ==?= <Biao.Huang@mediatek.com>
To:     "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for
 special cases
Thread-Topic: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for
 special cases
Thread-Index: AQHZFnD46s2/SRWVcEOB7S9zlZaYAa57hgWAgAQHhwA=
Date:   Mon, 26 Dec 2022 03:50:39 +0000
Message-ID: <4a82aa5437e496e2b65b77ef08d7897a4b23f7e5.camel@mediatek.com>
References: <20221223015029.24978-1-biao.huang@mediatek.com>
         <20221223015029.24978-2-biao.huang@mediatek.com> <Y6W4vwJHG+6PI8fd@lunn.ch>
In-Reply-To: <Y6W4vwJHG+6PI8fd@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR03MB3877:EE_|SEZPR03MB6890:EE_
x-ms-office365-filtering-correlation-id: 82c0cec8-a9fc-47f9-f6a7-08dae6f45b11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ivTavwP77SXm+gH2CAMdgkxd+diy6HwHwU5ZvaU+IHmGYlo6pnzytuNnzEOD8EPyYiLlFWoq+Ht+R9pU6ErqM28udx8rUUliIFC4/re2hcsNmlQt8yAjVwu2cxCbpZOgjCAgK8C1zbnHuCbim3ayIWo6VvH3ylSLxAon1mYmaoLjY/fBxXgeFzRemDLeIwN2uo67BauXZca5TXerf/uNHXq2vDgfqRM3x+Lj4WF7JGOsnVdKb5ORD1iN58XglY2F3DyGEBnqD1IOyKyA6I/WlHoc8VD/mS2io5FFhiqXp+ZFb7JOvVJP6vKCX1u+2c6K6APeykqhOOa+V5mOUxytaTVB9Opx/0L43mCbzK5ItDMMLCUkh92PSbw6u1suomt17fdydjy8hiafkjq0IKzpbG20I3MZAB8qP2PlhauLB0TgACyAgZBdgGfKrF+qZUNKf29tJBhf8s7ov+45Lzv9S5kh9FCSO5MoFIkU7DpCKBL5DNFurztWFAlRlUA25hNmLMtLIwTcTFq7FSaituS1I66GVBADeRXOrTW5fzoLdgTYiex8NXkTIyFLriFVVpE3ruhezkRRl0/gx9xOnbGrsTSLdD2BlJJJMjCF78Qies4zIc3tlDoho8bNglTEgMfQGQDaL3rMUDNQKfoJLXw2cBVdVCUEJKd79XW7xoewseQx61DPRGPcYhlNDjC2LlMML5lxRfpWlPB+4xHVV8ldw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR03MB3877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(41300700001)(4326008)(2906002)(38100700002)(36756003)(4001150100001)(8676002)(83380400001)(5660300002)(38070700005)(8936002)(122000001)(7416002)(85182001)(6506007)(316002)(478600001)(6486002)(66446008)(66476007)(66556008)(71200400001)(54906003)(91956017)(66946007)(64756008)(6916009)(186003)(76116006)(26005)(86362001)(2616005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnk4Njd6b0ZzK2RUMGRBT0FNcWtmUnEya1h1MU1FTWRwS0tNYVM5cE9GM1RK?=
 =?utf-8?B?WURDQzRtaFBvT2RDeGFoQ3NkYSt1OHh3NWlIVW9CQzdVRmNRazBzcStuVlpL?=
 =?utf-8?B?UjVJSDh6aElUT0l2OE54QXVFRE92NEFsNEE4UUczMVloS1praGFJZ2l0cDh4?=
 =?utf-8?B?a1JYbXhrVkFNdFRHOVV5TjBsOUxFUFVJV0VyWW1HckFWMlB3UmQ1TUpnQjlv?=
 =?utf-8?B?Q0xLejFLT0EyVWRGemFYb25RZ2gzUEIzZjhndyt4aTgwVEZNRjFQYjZOS3px?=
 =?utf-8?B?dnlJSVoxYXFmMWZ3TTdYL1BvSFk4TlZQSmlud1A0M1pZTnU0NFhmWGdPbzRY?=
 =?utf-8?B?MnBINmE1YlFwazlKTTQxeVdkUFROWDF0c25qOUpUR0ZqenFFck10MVRUcjJp?=
 =?utf-8?B?YzJYTUFFbXhkQXAxMlptOWJXRVViWmRENUd0K1I1eHYyVk1lSi9aRlVuMGp6?=
 =?utf-8?B?NXBFSmFoVVJsRExBOS9mNnppaW9ZcW5wV2VzeE9LUEFqWXh0ZHlzRG84WW1j?=
 =?utf-8?B?a2dibU95U3BjZWhLS2V3ak1tdU5acWVVMVVPandvc3o4anIzbnRPc3U5aEZX?=
 =?utf-8?B?emsvSGFvNkpMT3AzQSs5UVQzMk1waDdvbUd1SjVnb1VnOGRZdXNRcS9hc1cx?=
 =?utf-8?B?eVhJcERrcjVlTC9wWWpER2JQd1l5Z0M0Yi9BaTJ4YXc3bGxKdEZhRm1meW1Q?=
 =?utf-8?B?N2s1eVBiN2YyaUFzUHJRYWx3WktVakFtZlFRZU1lZnR0VGw3RE9sdk5UeUIv?=
 =?utf-8?B?UWtQU1loNWRXd1dBS2xMTGkvdlQvcTVhWDBrd1crQlcwejZEMnpxL2VhU3Jy?=
 =?utf-8?B?aWhXcFUxc2pxbXkvdndKclFJVWs2NTgrbnZ1UzNFMDQ4K3ZTVEdiUXBDTHJT?=
 =?utf-8?B?N0dpTUttTU41YWZvS3g4Z3YrakI0MVd6YVpjdU4rdDJqdC92WDBGeGtBUTlk?=
 =?utf-8?B?S1Q1cnIwUDVwUXB4VlBES2JoZ0NQWG92cXlBQi8rRTJhK3grNUkwdU1yZ1Q4?=
 =?utf-8?B?VitsYVFqK1duV3BkT3preWhmZWpsR2dSK1Jpc0ZiZW5SejlEZVIvR0J1dDA4?=
 =?utf-8?B?WTVPNEpZVVZGdFRWU2xsQ1dFMUZKT2NMeU8yQktKaXIxOEprT056UXZBNENm?=
 =?utf-8?B?T2xQR3IxWDBpL0I2cjB6ZzhvQ3V5YVNZWEhQWDlsa09KamlreDZ1Y1Uzd2RU?=
 =?utf-8?B?ME1ad0tpek80Q1FVVUlnbUZGdEl6aDFmamUxbDFhOTk4N2x1cWM1NHYxRlA4?=
 =?utf-8?B?eWJucGlMajFsclRmRzdSdzRnc2hvQTBteDVuZ3J1cm9xN1U3dnIzQXpmNEoz?=
 =?utf-8?B?WDhac2lnSzhxeEwzcmk2SWRKd2gzRmxRVTZhV0NjeURJdUZtbXN5T1ovaFdP?=
 =?utf-8?B?SExYM1pYalZ3L2FqUkxOaGUvd2FOU3RubHE0Y2xNZ2RiRDJGYW1BT1RxOWtC?=
 =?utf-8?B?ZHIwcUwwRzVtdldXTk8rYzhWak9SNXQrdkpRMnRLdE94SEdCVXlQYzhpZVNC?=
 =?utf-8?B?UCt1OWFGUW93c2pjTjJTZG42Wk1xaTRQQmVzOGtielovT2tVQTU0cU5sTFgv?=
 =?utf-8?B?Q29TUndzNDFQZ1l5eEFERFYxUmhwSU5Sa3RtQnZBRUNkYmlManpnVm1oOEph?=
 =?utf-8?B?QXhTdzgyN3hvb2xjbFNEdlRVc2o2QVlTQjYrUjdpZlhKd1NwclZ3RE9uVHpB?=
 =?utf-8?B?Q3VKNzArbXkzQmMvTFY5d2lZOVRneXVqL2E1VmVla0R4RmE0a0F5ZVRPaDJl?=
 =?utf-8?B?RmFoMUFHa0JMZk5BNGxSbkU3TjExL1ZIOEJzMlBweDltNHdVa2tsaXlRSGZM?=
 =?utf-8?B?TElBWjN3akZkK3BUTlpWK2pwa21CRDdyZWRwVENRRXpsZnRtTFJBVnJRUExM?=
 =?utf-8?B?K1A0K3lQRDdnTlBxWmcwYlJicnJzMWtpQWpFQ1pFNWpIdzhsNW1QcTBRWkdN?=
 =?utf-8?B?T2hIZmtWTEd4SHQ0dG9hVW5nbzFndFI0QXorWkc4d3lFaXZxMDdvS2xWdEly?=
 =?utf-8?B?bW5DNTc2ZlhGU3NDeU11UlVyNmpobFg2WUdyWUV1ZDg0TlNKZ2dFcUZKMEFy?=
 =?utf-8?B?c0xwcUxiNGtoUmpLU0cyZHB3NFFUMzB0MnJHSjZhaExMNUpPMHpVM1o2YjBT?=
 =?utf-8?B?MmM2ZU81Si9kT1VpYVUySzYvODI1bmxqVGx0VEIvOW5pazJvbnR4eVFJNW1V?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E43507E919F2284B96EE84F62C4DB419@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR03MB3877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c0cec8-a9fc-47f9-f6a7-08dae6f45b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2022 03:50:40.0034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnCd82LUWr4/156wH8FwL60Ozv8lzRuf2FIqscQmjy1Sjw/PFfqJUVkeV2l/Gn8UCyvUnscpI731IskbZA+H1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6890
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBbmRyZXcsDQoJVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQpPbiBGcmksIDIwMjIt
MTItMjMgYXQgMTU6MTggKzAxMDAsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBPbiBGcmksIERlYyAy
MywgMjAyMiBhdCAwOTo1MDoyOEFNICswODAwLCBCaWFvIEh1YW5nIHdyb3RlOg0KPiA+IEluIGN1
cnJlbnQgZHJpdmVyLCBNQUMgd2lsbCBhbHdheXMgZW5hYmxlIDJucyBkZWxheSBpbiBSR01JSSBt
b2RlLA0KPiA+IGJ1dCB0aGF0IHdpbGwgbGVhZCB0byB0cmFuc21pc3Npb24gZmFpbHVyZXMgZm9y
ICJyZ21paS1pZCIvInJnbWlpLQ0KPiA+IHR4aWQiDQo+ID4gY2FzZXMuDQo+ID4gDQo+ID4gTW9k
aWZ5IHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBmaXhfbWFjX3NwZWVkKCkgdG8gZW5zdXJlIHRoZSAy
bnMNCj4gPiBkZWxheQ0KPiA+IHdpbGwgb25seSB0YWtlIGVmZmVjdCBmb3IgInJnbWlpLXJ4aWQi
LyJyZ21paSIgY2FzZXMsIHRoZW4gdXNlciBjYW4NCj4gPiBjaG9vc2UgcGh5LW1vZGUgZnJlZWx5
Lg0KPiANCj4gVGhpcyBkb2VzIG5vdCBzZWVtIGNvcnJlY3QuIFRoZXJlIGFyZSB0aHJlZSB3YXlz
IHRoZSBkZWxheXMgY2FuIGJlDQo+IGFkZGVkOg0KPiANCj4gMSkgVGhlIE1BQw0KPiAyKSBUaGUg
UEhZDQo+IDMpIEV4dHJhIGxvbmcgbGluZXMgb24gdGhlIGJvYXJkLg0KPiANCj4gV2hhdCB0aGUg
Zm91ciBSR01JSSBtb2RlcyB0ZWxsIHlvdSBpcyB3aGF0IGlzIG5lZWRlZCBpbiBhZGRpdGlvbiB0
bw0KPiB3aGF0ZXZlciB0aGUgYm9hcmQgcHJvdmlkZXMuIFNvIGl0IGRlc2NyaWJlcyB0aGUgY29t
YmluYXRpb24gb2YgMSkNCj4gYW5kDQo+IDIpLiBZb3VyIGJvYXJkIGRvZXMgbm90IGFwcGVhciB0
byBiZSBhcHBseWluZyBhbnkgZGVsYXlzLCBzbyB5b3UNCj4gc2hvdWxkIGJlIHVzaW5nIHJnbWlp
LWlkLg0KPiANCj4gVGhlIE1BQyBhbmQgUEhZIGRyaXZlciB0aGVuIG5lZWQgdG8gZGVjaWRlIGhv
dyB0byBhZGQgdGhlc2UgZGVsYXlzLA0KPiBhbmQgaW4gbW9zdCBjYXNlcywgdGhlIE1BQyBkb2Vz
IG5vdGhpbmcsIGFuZCBwYXNzZXMgcGh5LW1vZGUgdG8gdGhlDQo+IFBIWSBhbmQgdGhlIFBIWSBh
ZGRzIHRoZSBkZWxheS4NCj4gDQo+IFRoZSBNQUMgY2FuIGFkZCBkZWxheXMsIGJ1dCBpZiBpdCBk
b2VzLCBpdCBuZWVkIHRvIG1hc2sgb3V0IHRoZQ0KPiBkZWxheXMNCj4gaXQgYWRkZWQgdG8gdGhl
IHZhbHVlIHBhc3NlZCB0byB0aGUgUEhZLiBPdGhlcndpc2UgdGhlIFBIWSB3aWxsIGFkZA0KPiB0
aGUgZGVsYXkgYXMgd2VsbC4NCmluIHRoZSBldGhlcm5ldC1jb250cm9sbGVyLnlhbWwsDQogNzcg
ICAgICAgIyBSWCBhbmQgVFggZGVsYXlzIGFyZSBhZGRlZCBieSB0aGUgTUFDIHdoZW4gcmVxdWly
ZWQNCiA3OCAgICAgICAtIHJnbWlpDQogNzkNCiA4MCAgICAgICAjIFJHTUlJIHdpdGggaW50ZXJu
YWwgUlggYW5kIFRYIGRlbGF5cyBwcm92aWRlZCBieSB0aGUgUEhZLA0KIDgxICAgICAgICMgdGhl
IE1BQyBzaG91bGQgbm90IGFkZCB0aGUgUlggb3IgVFggZGVsYXlzIGluIHRoaXMgY2FzZQ0KIDgy
ICAgICAgIC0gcmdtaWktaWQNCiA4Mw0KIDg0ICAgICAgICMgUkdNSUkgd2l0aCBpbnRlcm5hbCBS
WCBkZWxheSBwcm92aWRlZCBieSB0aGUgUEhZLCB0aGUgTUFDDQogODUgICAgICAgIyBzaG91bGQg
bm90IGFkZCBhbiBSWCBkZWxheSBpbiB0aGlzIGNhc2UNCiA4NiAgICAgICAtIHJnbWlpLXJ4aWQN
CiA4Nw0KIDg4ICAgICAgICMgUkdNSUkgd2l0aCBpbnRlcm5hbCBUWCBkZWxheSBwcm92aWRlZCBi
eSB0aGUgUEhZLCB0aGUgTUFDDQogODkgICAgICAgIyBzaG91bGQgbm90IGFkZCBhbiBUWCBkZWxh
eSBpbiB0aGlzIGNhc2UNCiA5MCAgICAgICAtIHJnbWlpLXR4aWQNCg0Kc28sIHdoeSBkb24ndCBN
QUMgc2V0IGRlbGF5IGFjY29yZGluZyB0byByZ21paS0qKiA/DQpyZ21paS1yeGlkICAgLS0+IG1h
YyBzZXQgdHgsIGJ1dCBub3Qgc2V0IHJ4IGRlbGF5DQpyZ21paS10eGlkICAgLS0+IG1hYyBzZXQg
cngsIGJ1dCBub3Qgc2V0IHR4IGRlbGF5DQouLi4NCg0KYW5kIFBIWSBzZWVtcyBzZXQgZGVsYXkg
YWNjb3JkaW5nIHRvIHJnbWlpLSoqIGluIHRoZWlyIGRpcnZlci4NCg0KPiANCj4gPiAgDQo+ID4g
LQlpZiAoKHBoeV9pbnRlcmZhY2VfbW9kZV9pc19yZ21paShwcml2X3BsYXQtPnBoeV9tb2RlKSkp
IHsNCj4gPiArCXN3aXRjaCAocHJpdl9wbGF0LT5waHlfbW9kZSkgew0KPiA+ICsJY2FzZSBQSFlf
SU5URVJGQUNFX01PREVfUkdNSUk6DQo+ID4gKwljYXNlIFBIWV9JTlRFUkZBQ0VfTU9ERV9SR01J
SV9SWElEOg0KPiA+ICAJCS8qIHByZWZlciAybnMgZml4ZWQgZGVsYXkgd2hpY2ggaXMgY29udHJv
bGxlZCBieQ0KPiA+IFRYQ19QSEFTRV9DVFJMLA0KPiA+ICAJCSAqIHdoZW4gbGluayBzcGVlZCBp
cyAxR2JwcyB3aXRoIFJHTUlJIGludGVyZmFjZSwNCj4gPiAgCQkgKiBGYWxsIGJhY2sgdG8gZGVs
YXkgbWFjcm8gY2lyY3VpdCBmb3IgMTAvMTAwTWJwcyBsaW5rDQo+ID4gc3BlZWQuDQo+IA0KPiBT
byB0aGlzIGlzIHdyb25nLiBQSFlfSU5URVJGQUNFX01PREVfUkdNSUkgbWVhbnMgdGhlIGJvYXJk
IGlzIGFkZGluZw0KPiB0aGUgZGVsYXkgdmlhIGxvbmcgbGluZXMuIFlvdSBzaG91bGQgbm90IGJl
IGFkZGVkIGFueSBkZWxheSBhdCBhbGwuDQo+IA0KPiBGb3IgUEhZX0lOVEVSRkFDRV9NT0RFX1JH
TUlJX1JYSUQsIHlvdSBuZWVkIHRvIG1hc2sgdGhlIFJYSUQgYml0IGZyb20NCj4gcGh5X21vZGUg
d2hlbiBjb25uZWN0aW5nIHRoZSBNQUMgdG8gdGhlIFBIWS4gT3RoZXJ3aXNlIHRoZSBQSFkgaXMN
Cj4gZ29pbmcgdG8gYWRkIHRoaXMgZGVsYXkgYXMgd2VsbC4NCg0KVGhlc2UgbGluZXMgb25seSBz
ZXQgdHggZGVsYXkgd2hlbiBwaHlfbW9kZSBpcyBSR01JSS9SR01JX1JYSUQsIHdoZW4NCnBoeSB3
aWxsIG5vdCBhZGQgdHggZGVsYXkgaW50ZXJuYWxseS4NCldlIGRvbid0IHdhbnQgdG8gcmVzdHJp
Y3QgcGh5LW1vZGUgdG8gcmdtaWktaWQgb25seSwgc28gSSBkb24ndCB0aGluaw0Kd2UgbmVlZCBt
YXNrIFJYSUQgYml0LCB0aGVuLCBVc2VyIGNhbiB1c2UgcmdtaWktcnhpZC8tdHhpZC8taWQgYXMg
dGhlaXINCndpbGwuDQoNCklmIEkgbWlzdW5kZXJzdG9vZCwgcGxlYXNlIGNvcnJlY3QgbWUuIFRo
YW5rcy4NCj4gDQo+IAkgQW5kcmV3DQpCZXN0IFJlZ2FyZHMhDQpCaWFvDQo=
