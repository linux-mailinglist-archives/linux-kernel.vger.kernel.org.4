Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02179659422
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 03:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiL3CLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 21:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiL3CK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 21:10:59 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13385FFA;
        Thu, 29 Dec 2022 18:10:51 -0800 (PST)
X-UUID: 1cb945c14aef4d9eb2cd260991644f55-20221230
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tpikKhpgvAeaIbAXJrbt062qRM6wP3yQHq5Y5agESqk=;
        b=HPpX0zTUhf7fHNTSsRny2jqzxe+Ox9dt6avQe7vHWSClR2jmUwyVozebgNwy527dBDv4mTn4/ybsQL08v/JWm8ETDSNmyhP38RVb2+/H1dhPbkGKTT2NfwlmOfJ/lhylqnbwA1PHAZV68ZPs0kuGLiBj/3JGmW0ipc3sGYpHJTA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:603b9204-b524-4238-9adf-59a3b30dc809,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.16,REQID:603b9204-b524-4238-9adf-59a3b30dc809,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:09771b1,CLOUDID:44902f53-dd49-462e-a4be-2143a3ddc739,B
        ulkID:221230091534QK9W5G6T,BulkQuantity:9,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OS
        A:0
X-CID-BVR: 0,NGT
X-UUID: 1cb945c14aef4d9eb2cd260991644f55-20221230
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1872732974; Fri, 30 Dec 2022 10:10:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Dec 2022 10:10:44 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 30 Dec 2022 10:10:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHxCwabww8Y5Hq2d8HN9e8Mfdv8JOqO3e/VwyJbPQkC7OrSuz6tWXI+Bd2Hcq9u4Mf7s5Pkm2TGDCIQ4hX7TKRECrt7uw0JgwL11wLVyNh4zT1lb4dTKbFGVvVKWdgrNS002Ie/SX/XCgipR299jmV0vMPsha5jezQeZHMa9jBezj8uGrp76sPU5lUZzSBXdBzghbqFtk0U79SQy3reVYJHqapJSQG8XZ3h7Ea7yX/c68eUP5nLELt9Df597AYKJa8O2KI5Q5Pd9i54zGLcajnJCZxyMPajizqfNcK5j7/CaoZ5O/tNyDvALOrjLSYBEyU02UQrcbNxW/KLM9dCmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpikKhpgvAeaIbAXJrbt062qRM6wP3yQHq5Y5agESqk=;
 b=LNNAT0GwFDNbVjcRE7mcXWvFA4GYXkuC6arURy15DcS1KsgrKKOa6IZ36J8x766ae9wp2811PaJ8i26+od9dgl+qJGD3SVWFsB4AfcrhLNZC0vPRWrJ/uUXdo4ZA94xl4qtdrBy7AYymkWpE+H+qQOKCPQHgKJNulxto3Ft+L3aHjGRFANYdtPFAKYgUpXWrmqEMJqn2LoUPKkc8KKZADGoQPr0FgCRv7ayJsdJ0cghOatHl/UrjuGWF75tUijO8QaMnI8Xo87wEt4Z60fo5ePQhzpTvMtwCpMriG7VaM4TmLLKvKRJsEP9sgBg9LqR4TAr4IDXHsgr13PZ40KxQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpikKhpgvAeaIbAXJrbt062qRM6wP3yQHq5Y5agESqk=;
 b=m2w6mP8ydMDTFG3lSgRBBp99EYZQCRvMakNquByKSXalyrrdNEdirtnxG/2n5l+fKvvZ5dBjk4hdwiPn9W3z6bom73aRcv8E3PkUWr3yig8oRnXD0bFYKmspvfNFk4ELPJGWu7C+N4lxeTp2GJKyvYVITdqJnIp7zOCOgJLdfRo=
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com (2603:1096:300:39::13)
 by TY0PR03MB6584.apcprd03.prod.outlook.com (2603:1096:400:205::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 02:10:41 +0000
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56]) by PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56%6]) with mapi id 15.20.5944.018; Fri, 30 Dec 2022
 02:10:41 +0000
From:   =?utf-8?B?QmlhbyBIdWFuZyAo6buE5b2qKQ==?= <Biao.Huang@mediatek.com>
To:     "kuba@kernel.org" <kuba@kernel.org>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
Subject: Re: [PATCH v6 0/2] arm64: dts: mt8195: Add Ethernet controller
Thread-Topic: [PATCH v6 0/2] arm64: dts: mt8195: Add Ethernet controller
Thread-Index: AQHZGoZT3ROHpxl5DEWt+P0rehWHY66Fo1sAgAAPaQA=
Date:   Fri, 30 Dec 2022 02:10:41 +0000
Message-ID: <dd571d0ef3dc72d319ab20a0e1a960145c23845a.camel@mediatek.com>
References: <20221228063331.10756-1-biao.huang@mediatek.com>
         <20221229171528.510b7a37@kernel.org>
In-Reply-To: <20221229171528.510b7a37@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR03MB3877:EE_|TY0PR03MB6584:EE_
x-ms-office365-filtering-correlation-id: 48c42942-e845-4488-a65d-08daea0b0d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFqFpBOsoxSy1GGpHChejyRtTBK5db2VpV+oZ64bPvfeHfrKBAdrpU0lWrfMehr+Jj68+t8phQVSTdXcQQXecka6XxQahPJiuAa/l8qN9rFwKkq7GLYwa4Jmj3EJJlCfU+htoq0PHKhzGCUCug9RO2fwP09jkRZS6GxZTvf7kDRuQU+QHujVi0cisXZJJhLWGfNgK6LY1KgJX1hDgeIVJaWjYjSAMz0RzsEQFtgrK56P5N/MwoGLlO28io9bnE68fTZXjXQcV/qzoePBZYPEnaGTUDQ4buK1Gyx/GInHF4LKGm+dXJd582LjmfCdE9izJ7zXbeDqizzoQxxysv3KuPiv91Uj0FqVEotfFs+5Z+B1ChzVWxgzHmc7OXruIb9aaS5OlYklm/+9d3EZRyPtOK7Ynb/NFpUvuUvf+M4eMRu6ixcD9ImjKBJueY202zCZK84APyYgyUR3293xCT4I4Iy/BQGBXB+DJxj+vszrX9HJC+/bHmQY/XA8YNhc8rGMneYdYBXoIsgVuPb635Q6PvCCtT7sN1QOUZEGkCC1a6rpI7RoP53OJrlIkwdLjUPEslgE3r7Q/yTMMyJS8RSNweVGGWV7HRp0syCb0JVb/8MGbviPqDf28ve/nZ2oZuGk+/0NBpqXS6Oy07x24H+iRuXWTuIaxtkd3IsxRnMxb25n04ZH5oh49AowQJWjTZ2G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR03MB3877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(83380400001)(86362001)(4001150100001)(5660300002)(38100700002)(122000001)(66946007)(2906002)(8936002)(7416002)(41300700001)(76116006)(26005)(91956017)(478600001)(2616005)(8676002)(186003)(6512007)(4326008)(6486002)(6506007)(54906003)(71200400001)(6916009)(316002)(66446008)(64756008)(66476007)(66556008)(38070700005)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3M5K1lzd2wvb0k4cWJncS9UdGx0RFBxZkd2U2dKUFAyNEJLUzYvNnEwV3Fw?=
 =?utf-8?B?eUQxSHNJaUJuVnZ5T1cyVUVFSjdVR2FaUzdIaXFwYTBFZWZIenk4dWtKaERj?=
 =?utf-8?B?SEVjQTBzL0lSVytTNVlDTGRxL2pReXQrYUNkTWIxYTQyblAweWY0MjRNSXdt?=
 =?utf-8?B?K2dvSFhOVkJ2RnplTzVITENHMlRMSmpkUXhiajZNTllJRllYL1I5RU9LbUI4?=
 =?utf-8?B?YkZMaTBhUlhySmlwRWl6ZHN4VXV2TlNHNCtlSE9BSmZCS3FpM2JZVDc2MVJx?=
 =?utf-8?B?Yjk2dFZTcHZWbTNDbnBNV1BZZ1djZFREcmQ0eE1qNDdOS0M5N250NE95OWlN?=
 =?utf-8?B?Nm1CWXVHaUtIdlF5VDJCdEZHQWtEcmRPUDhUYVArdVN0Rkc3d25FQ21PRi9B?=
 =?utf-8?B?dDNtUzlqYWxSc01tT1pBemxOdXRSNWZFSit6ZHc0QWJpaVhlY1JGZHl4VHQ0?=
 =?utf-8?B?SFBGYlRCdWJHMVhQMnlGL21Xa2J4cWdqWnB2NGM5M1Jna09odE1ibnZBUmNw?=
 =?utf-8?B?dkZWRVBLV2NsWUdKdXR0TnBOVVoyRjFlaUlTb0VxVlV4WVVUY2JoNVZQK1BO?=
 =?utf-8?B?TDVUYzUyUEpZTjJ6Z251UW82TXRYWjBaZkREK1BXNldvVTc0ZG1qRkhwN0lt?=
 =?utf-8?B?Z25SS2J5UXNyUmQvTEl5ZzdzS2pnTndlQ2VPTWVGbjJ1WDMza0VZeWZ0VGdz?=
 =?utf-8?B?SEthbEZ6ZFRheEhzMnIrenFVVmZqYTNhK3E0Z1VGeXBVaE0xYmdsM3pZYUlJ?=
 =?utf-8?B?VFU3cDV3akdTdzBYdHd5ckpTWjBmN2tsY0lyZDhDSW03eEZITFN2N0QvS3ZF?=
 =?utf-8?B?VlJ3RFEwUDl2azhoSnEyQjd1UVF2VkRZdUJ4akVQQjhka29NeUF0QWJPQSs4?=
 =?utf-8?B?WmxFNFRoenZvSUNaUWZjMEs0WHR0Q2pYZjREZm9FTUJEb1BzczY2TjNIdDVV?=
 =?utf-8?B?SnVYeVlXcUFheUl1ZDNZdFlrQnZZdzZHK0RvcUdKVU84OERST1k1MUhwaXdZ?=
 =?utf-8?B?ay9BbFE3SWVaUnpyS3B3U2IvMDdRaWd0aXJJS1E3WlVtdG1mZzRDWkh2ZEZP?=
 =?utf-8?B?TlRObDFZSGFpQW8rQ3FEUDZjNXVnK0p1b0wwTnVobzlPdkh0OSt2a1Bnc2hC?=
 =?utf-8?B?a29VbTVuV1FPd0ljS0hXUVRnMlBzMDAvTFIraHpPam9GWXM4REQ2a3lXQ0Yy?=
 =?utf-8?B?RURNRWc0S0FqaXFFNys0Ukxqdk1KbktsUFh6dGdaZUdvVDdrSm5NRHFVSlFk?=
 =?utf-8?B?blBCRldZQkNkbzhsb1VTVHhtek5uUnN2NytjOU9kSjhNUGtXSmQzSjRHdWZo?=
 =?utf-8?B?bDgzaU5lbG84cHdhbTAvV2lkc09uVFJ5OFBqdzFXZzdCSjkzYkFmcFZsbFhs?=
 =?utf-8?B?RkgrVmZtTXZONW1BTitCbVVpTHR3S3Aza01wSUxDbFZ5dE8yQnpHMWJJaDJZ?=
 =?utf-8?B?M2hyNURxM0k1MHhVbFZsTEIzUUd5b3FQeGlIOHg1V25KSXprRjhwaG83ajUx?=
 =?utf-8?B?TldOMkxCWDRxVy9KWUdacDNSKzNoeWN1QlEwam1kRnMzZmdoN0VJdlBQN1Qy?=
 =?utf-8?B?N1FzS1d3UlFvbVo1M1c0Wm5aUy81VWpUMjVabkdKQWR1SmdQcWk5YnNBOGU3?=
 =?utf-8?B?THhEbjUwVDJ4UXhpbzZuQ3NXUmg5ZS9hRDFTMzVhNmcxSzNQNHd3eUs4S2Jq?=
 =?utf-8?B?SG9VSHBYdlpNYlVoSjNBc2xTaVZZS2NCQ1hOVHJOWWNibUlLeWdXT2JLQlR4?=
 =?utf-8?B?RWl5NkRKTE1lYUhmaWRpZWZ5L0tqVnNob0srekt1MVd5clhJcmw0ZXBtMnBW?=
 =?utf-8?B?U241YkIxck1FZys2RG50OThBdnNnWTZHd1Vzc0FUenpvOGw1WTBNdmJlZ29T?=
 =?utf-8?B?ODZIbW9wWXh3aXNDTlNFOXRvZFVBZzNhT3J5SFlKRnhCK1ZuWDI4Qk9HbVhW?=
 =?utf-8?B?cU9JVWU2TnpscnNkSUtnSng5M3Rtc1JBQjNQU0VwZkxsdE5QcEJYc1ZRTHVO?=
 =?utf-8?B?QjVwaDAyVGpCYVQyZ3lpVHl4VndJcFZKQWdFVnkwTjVHcHJFbVBqM2FYcEpZ?=
 =?utf-8?B?UG5qMFNIWU93YkJ0TDAzaFc2UDRvc1pvSFJPZ0RCOWR1NE9OTmNLRnIyY1JN?=
 =?utf-8?B?RzcvTE5GY0FOZnlXd05URXBnMWxtYXRpb3N4UWFIZXNENXJRZkpBaHFDM2M1?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FCCCD942AB855428A30228CCDF3E2A3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR03MB3877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c42942-e845-4488-a65d-08daea0b0d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 02:10:41.2906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WbknghZ9BOt5sboLDyuO6a1H81doKT8JKSWUjsgKQfPW15ATTsyUf+VpcLvKy13xl2Qr4MgJbqnt2C+pnJSP1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6584
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEyLTI5IGF0IDE3OjE1IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCAyOCBEZWMgMjAyMiAxNDozMzoyOCArMDgwMCBCaWFvIEh1YW5nIHdyb3RlOg0K
PiA+IENoYW5nZXMgaW4gdjY6DQo+ID4gMS4gYWRkIHJldmlld2VkLWJ5IGFzIEFuZ2VsbydzIGNv
bW1lbnRzDQo+ID4gMi4gcmVtb3ZlIGZpeF9tYWNfc3BlZWQgaW4gZHJpdmVyIGFzIEFuZHJldydz
IGNvbW1lbnRzLg0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjU6DQo+ID4gMS4gcmVvcmRlciB0aGUg
Y2xvY2tzIGFzIEFuZ2VsbydzIGNvbW1lbnRzDQo+ID4gMi4gYWRkIGEgZHJpdmVyIHBhdGNoIHRv
IGZpeCByZ21paS1pZCBpc3N1ZSwgdGhlbiB3ZSBjYW4NCj4gPiB1c2UgYSB1c3VzYWwgd2F5IHJn
bWlpL3JnbWlpLWlkIGFzIEFuZHJldydzIGNvbW1lbnRzLg0KPiA+IA0KPiA+IENoYW5nZXMgaW4g
djQ6DQo+ID4gMS4gcmVtb3ZlIHthZGRyZXNzLHNpemV9LWNlbGxzID0gPDA+IHRvIGF2b2lkIHdh
cm5pbmcgYXMgQW5nZWxvJ3MNCj4gPiBmZWVkYmFjay4NCj4gPiAyLiBBZGQgcmV2aWV3ZC1ieSBh
cyBBbmdlbG8ncyBjb21tZW50cy4NCj4gPiANCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+IDEuIG1v
dmUgc3RtbWFjLWF4aS1jb25maWcsIHJ4LXF1ZXVlcy1jb25maWcsIHR4LXF1ZXVlcy1jb25maWdz
DQo+ID4gaW5zaWRlIGV0aGVybmV0DQo+ID4gbm9kZSBhcyBBbmdlbG8ncyBjb21tZW50cy4NCj4g
PiAyLiBhZGQge2FkZHJlc3Msc2l6ZX0tY2VsbHMgPSA8MD4gaW4gZXRoZXJuZXQgbm9kZSBhcyBB
bmdlbG8ncw0KPiA+IGNvbW1lbnRzLg0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gMS4g
bW9kaWZ5IHBpbmN0cmwgbm9kZSB1c2VkIGJ5IGV0aGVybmV0IHRvIG1hdGNoIHJ1bGVzIGluIHBp
bmN0cmwtDQo+ID4gbXQ4MTk1LnlhbWwsDQo+ID4gd2hpY2ggaXMgcG9pbnRlZCBieSBLcnp5c3p0
b2YuDQo+ID4gMi4gcmVtb3ZlICJtYWMtYWRkcmVzcyIgcHJvcGVydHkgaW4gZXRoZXJuZXQgbm9k
ZSBhcyBjb21tZW50cyBvZg0KPiA+IEtyenlzenRvZi4NCj4gDQo+IFBsZWFzZSBtYWtlIHN1cmUg
dG8gQ0MgbmV0ZGV2QCBvbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZSBwYXRjaGVzLg0KVGhhbmtz
IGZvciB5b3VyIGtpbmRseSByZW1pbmRlci4NCg0KQmVzdCBSZWdhcmRzIQ0KQmlhbw0K
