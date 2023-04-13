Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F976E079A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDMHWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMHWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:22:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266E07DA5;
        Thu, 13 Apr 2023 00:22:05 -0700 (PDT)
X-UUID: e25ea5cad9cb11edb6b9f13eb10bd0fe-20230413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0dqX9706Nhzat/ZxZjFVtRNqxb8tShUrNXruz1yLY64=;
        b=kn19dU4fTDYRtA6xUbHNFZnr3nZXFqeE3UAxkemuPfY2ccuzMfrZ1HE/tyoZf5WThspctsbmwjzxwWK9USGjwF/bymp+5vlpXDndwNpkcEM2jJIiPF1y7WDkp5CVGd6uF8CkV1j28yMOQXTWVBfHhxP+tqz1fn3J6hERoSRItr8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:38565894-4527-4831-8cf3-6a44330e9495,IP:0,U
        RL:0,TC:0,Content:13,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:13
X-CID-META: VersionHash:120426c,CLOUDID:b2f030a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: e25ea5cad9cb11edb6b9f13eb10bd0fe-20230413
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1878921512; Thu, 13 Apr 2023 15:22:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Apr 2023 15:22:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 13 Apr 2023 15:22:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwmbd8cvFU06rbd1aizn0TK/cAdPhCPe7Ez2DZmhB68wYMjW7EfOrtbG7gAeqjB3vLn5+nJD5gAY9G7kRhZaqyr1CDWNsZ3nOgCmQ3KfVYEpYZ8onRYONOQYXdBd4IAU3NgICFc7ddmyslJ9LZgcIEZyRyYPCtmk4+qh93vJZAE97LbBKb+e/Kk2VKxfctEP/6u4/YvlSp+v4/jF8owz3auESVtI4KjxTXr1DrUaTeLdXUZYlczS4R3Q7eh7X/T+7mhb2I/cuR6ptv1Z1fQy87faZh9Ry/Z+Y87M3caX3rbBvYXbX3VoSbrSgIawxgOXUE589NUx3fM+hK5a8vSfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dqX9706Nhzat/ZxZjFVtRNqxb8tShUrNXruz1yLY64=;
 b=OIXhqS1+CQBFsY8yMaSq3MMWvIqPQcnijrbqOS+X6KBGuFfYpjxD/5pCLO3EeGKSVll6Ce2+cvpNC3et8n2XojdyZ9WgHEA+Y36qS2XmjcxU62cLU9SHRjIks4FKpxTFqKQuuHLnQ0cqbtWsKKEcZ/yW57fU75hR0xO84SJRfCnvffp+2dDnR6Sn6E6G4cLwCz/YFXV9fkCF/whDNd/pPLPmcOD3pvo18YYbSfXK1yUHJ+ZU3mOh6sXauIKOLOkoPtISWRljh1o5/iOeVuF/HRwH1JMmAn2JdOq9qc4nV63N5LvA+yqIe590JXmdPCbv6cdmkwB32QmMAQburGERSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dqX9706Nhzat/ZxZjFVtRNqxb8tShUrNXruz1yLY64=;
 b=Z0h2a4iOZFb8KQ5DCHwOAGBsnOmR2WkumSZ+AiGM15sX0WdgmBPnBXxNJTqha9IiMZT14rALinu5r/EeJt2ayllz6+JHr06+NMNOUFMAN5FEwRwQPNW56Hrb8F+F8fXLvCNdb2uijCTtJ4oICXcG9MPpNSFskWcF+DF5Q/oPhfw=
Received: from SG2PR03MB6540.apcprd03.prod.outlook.com (2603:1096:4:1d4::13)
 by SEYPR03MB7117.apcprd03.prod.outlook.com (2603:1096:101:d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 07:21:58 +0000
Received: from SG2PR03MB6540.apcprd03.prod.outlook.com
 ([fe80::577:6f28:8d2a:8a6]) by SG2PR03MB6540.apcprd03.prod.outlook.com
 ([fe80::577:6f28:8d2a:8a6%3]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 07:21:58 +0000
From:   =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        =?utf-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 2/2] drm/mediatek: dp: Add the audio control to
 mtk_dp_data struct
Thread-Topic: [PATCH 2/2] drm/mediatek: dp: Add the audio control to
 mtk_dp_data struct
Thread-Index: AQHZbb2Awi9t5waknUKYivK4KUGtaa8o1ceA
Date:   Thu, 13 Apr 2023 07:21:58 +0000
Message-ID: <8ef43d1b76721169f420ee1160087febc24dd9c8.camel@mediatek.com>
References: <1681358785-6930-1-git-send-email-xinlei.lee@mediatek.com>
         <1681358785-6930-3-git-send-email-xinlei.lee@mediatek.com>
In-Reply-To: <1681358785-6930-3-git-send-email-xinlei.lee@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6540:EE_|SEYPR03MB7117:EE_
x-ms-office365-filtering-correlation-id: a5e770c4-dfba-4697-fbfa-08db3befc46b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: grjS5BCMQEouI0vV4sGq72umBqjGer5e2CmLJ14D/ZRNylOWzw+KOGCtZx9uc2Vq/yyfynPPFsgIogUUAFx5zEskU3MA3o+9/nB/SouJIZsrZFphQhgLYnA1yHL7ZVX/Z/an5McNXVJfvahxxhnpmLmnOEpA7cCk4K8AcizwLP6q0+DzBh+5m55FnlGxuebiCkSsD8z15+ERbce5K8A9vbES/O+KDZhatv1mpc5qDknQVnBxqbFZ7yWnHmbemzZN8BX7BSithmG7fS0/SGsb/i2c7qjMYSYCl2CUwmxk4nLX+FXfT2zZD9DkxIB2bzxLYReb23lqmsUnHwP5CjKnlNfImRjzQpW6qIXt9SK4/D+TZqdOLQq/83Tqd7IArYprnJ/kmuVeqQs3WatPap2DGDrakouSrcK08Ut2yR+XrqXL0huNHSvJSAGvJ9KdZN8oBvQLDtnUZ/cAqsYvDjixPpmN5YBZYaIRp4DQH9eTCanKNJwNCKTFJ95muJ9uMenMZyVbUOoK1IpbwIFxxW3UyBVqDGinAnSIA2eafTVzdHTABdcA93g8fHvxVC33tgoswa7XOPowXrkC4vyiihW64iEP1Tig6EjbzP8Fvy5p6D4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6540.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36756003)(85182001)(86362001)(76116006)(41300700001)(110136005)(316002)(91956017)(6486002)(71200400001)(54906003)(4326008)(66556008)(66946007)(478600001)(66446008)(66476007)(64756008)(8676002)(5660300002)(7416002)(2906002)(38070700005)(122000001)(38100700002)(8936002)(186003)(83380400001)(6506007)(107886003)(26005)(2616005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d05MazNreHZSejJqZ1B0Q1kxbC9ySmc4bnRQTFR1TUpOaVZyVmZEVGVkZG5J?=
 =?utf-8?B?UGw0eUhRbjJva1IvTlBkMDFOMlZ0Y0hKcHkyMUhLRDlOSjlFR1BSYmkwY25T?=
 =?utf-8?B?Q3lHR1FaY0tuVnhSZUgzS0p3QTBpckgyNHBRUS9OckhlQmZvQkExSnhKdU1M?=
 =?utf-8?B?bDhpYS9hZ3phODdNZXRJS0pveFd4a3Z6cTMvNDVZTDVQVzJHZXQ2Y0NDbTNN?=
 =?utf-8?B?WmJucmhueWc0Yi8rUjJETUFaeHhIaWZkbk9HbXJ6MjdxV2lqWkdJTCtsMzVY?=
 =?utf-8?B?NWNXNDR3cjN2dnF1eFY1aDN4ZkZOZmVhTkYvWkwrSmNOZVBpUmxSTGtGZFVn?=
 =?utf-8?B?blhFU1VBM1pQMENkUmVOaHl6OFFZZXhhMEhrSGRvOHFVQmcrSlprNUNVVk1T?=
 =?utf-8?B?b1BQaWRCMTlzd3dpRXRsQmJGbmIxanVvclVJNXU5c0RDeittTHlRQW9wcG1s?=
 =?utf-8?B?aHg4U0xHcCtPcVZ3ZzVyaG5MZnBiMTNOOEpySEUydC9YM2tlRnlKTWxKYi95?=
 =?utf-8?B?ZHlWSFNGZ1RtajkzZVJlWS9Lbk1kOG9UK2IzMDBjbDVmcER3NEdwZGdmSVor?=
 =?utf-8?B?N3dNbFRqdHEzUER4TGVGVzhIZElCSVJLMDRlWExpTDVIbFVLVXNiVzhhRTh5?=
 =?utf-8?B?djZYc2VXUytYT0NqYmVvaVJ1WTJIek1RT0xwc20xV1pCOVpoWHZMUWthRTlN?=
 =?utf-8?B?czhyQ0V2R1Y0amFzV01zcGFUZkthekVxamEyYmJaOG0yOVRFZmw5QnViMHlH?=
 =?utf-8?B?M0F6a2JLcWUzNHRRQmUxSkpYcTloYzdRL3gwUzB3Tm5FMXhnUnErTzEwcEZW?=
 =?utf-8?B?aVQvbDUwOG03ZG1tTFdkSVc5ZzlsajRwMWp6UEhpTS9LMG1ZMFdOODJaUElX?=
 =?utf-8?B?Z2tPRkhxSXJSZEg0MFdLS2VmbEFMMmt4bFB5VkQxam94b2JYekdnR0RLTjR5?=
 =?utf-8?B?bW5sSFczaWJEZG9QNkNWV05DTzhqRFZrQ3JqaWJtQmdDZFFyS1B4MjMrNVg3?=
 =?utf-8?B?MGdoYi9ud0xGSmtYeUlkYWJZQW84eCtqdjFNZmJXVVM1ZU1nSHpFZzc4MWFZ?=
 =?utf-8?B?TExOY3ZWYW1NYTVlSFV6WWtqeWs0bkVjRmozclhKSTNpbkhrSDZOdnZaZ3Rn?=
 =?utf-8?B?NnhrRVk1TUhoSVU2dG1TNVRxUm5Mdk1LeDd4ZGoxZUFIQU0veElCWXNNUG5T?=
 =?utf-8?B?SXlrM0ZpTGFodXBKNDZPdUVkZ0w2V1Y2cmh2ZkpIZkhJSFJ1Uk0raWlZVzBi?=
 =?utf-8?B?aFFWWG1CektCVUw1NW5SV0g3WmJ1eDhxb2dqL0Z5cTRUdHE0Ry9FdXhhVHlj?=
 =?utf-8?B?dEhHRHppVENrMXZvZjlnTm9xdmdXKzdNQUYrOUpRVEJBT2tRSkNTUDBhU1pN?=
 =?utf-8?B?MWtIZEI1SWgrL2Z1TmhESkpXSVBEaVRVa0ZROGp5VUVhTWg2OXdsTEs5VzYv?=
 =?utf-8?B?UldsUzBNcndHVXRNNTNvcjFGeUtrNm5tY2MxZjR3bDJBNGdYZXdabmRub295?=
 =?utf-8?B?K0RoLy9ERFZIenFlR3ZjV2c1YzJGMWQ4Z0ZUaFhMU0JVSzdFVnZSdDZ3VXpq?=
 =?utf-8?B?ZnVtaE84aUZsdFFjZ3VwLzlERUZ0MWxSNkRMTkhOS3NVbVAwYkZMSUhmc1hp?=
 =?utf-8?B?QWEyeEFhenZqVVFqb2JodjhUTklSdzJCdXVmci9rWkVvZXJINnNBSFVrQVUx?=
 =?utf-8?B?ME4xVjNUOENKYTRhM0Q1RENpNzVFYmhKZ0xqTXkxeFQrY3ZCNnRQTDA0cEQ4?=
 =?utf-8?B?UU1PcWFoOVlDNUtJc1VnaTBKRGdVK0xCemlTekx1SDJNWDExK2VpQVVFTThO?=
 =?utf-8?B?dW9zTnFmYUNsc0w3ZGJUUXI1Q0FBTlJDZ3pBS3h1U3VrNk9nMVhaNEpmVnow?=
 =?utf-8?B?N2ZMWGVyU0lpTHFmaDQ5S2NnMFJXcjZ2V3J0K3d0bWFzK1I1VXF2QmFNalVN?=
 =?utf-8?B?eDdIbGZ2KzROM2Z1RkZKSTBEaWhrR3FMaFoyZnNyTm01cHFqRnhpVHg5cFFk?=
 =?utf-8?B?OGlaTjBhaEdjemFUK3owODFKSVFkbENJM2R0b0JlNXBvRWVFWlh2OE9QOUFS?=
 =?utf-8?B?SHQyWEFJNXdPcnFOR21idlNEcVIvMzRyUXZCZTNocGxZeGphM1Y0TFpNU3RX?=
 =?utf-8?B?NFJlR0pXZkVzOGRlOHpaVC9FOGJQbDJRSis4bVN0NDg3L1BkS1dBYzVVbkpu?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CBB5D374D9013488542B37F22B5B04B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6540.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e770c4-dfba-4697-fbfa-08db3befc46b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 07:21:58.1093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqSx2xyxu0iyriHFqkveK6snIA6YFuHjvfv2aAiusMqHQZhpJ3yRHf+iV+8saocQsSeqlXgd5+76LNnh1u/WyCaXEJDSXSE+Ob5rWVVJF0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gWGlubGVpLA0KDQpNeSBjb21tZW50cyBiZWxvdzoNCg0KT24gVGh1LCAyMDIzLTA0LTEz
IGF0IDEyOjA2ICswODAwLCB4aW5sZWkubGVlQG1lZGlhdGVrLmNvbSB3cm90ZToNCj4gRnJvbTog
WGlubGVpIExlZSA8eGlubGVpLmxlZUBtZWRpYXRlay5jb20+DQo+IA0KPiBNYWlubHkgYWRkIHRo
ZSBmb2xsb3dpbmcgdHdvIGZsYWc6DQo+IA0KPiAxLlRoZSBhdWRpbyBwYWNrZXQgYXJyYW5nZW1l
bnQgZnVuY3Rpb24gaXMgdG8gb25seSBhcnJhbmdlIGF1ZGlvDQo+IHBhY2tldHMgaW50byB0aGUg
SGJsYW5raW5nIGFyZWEuIEluIG9yZGVyIHRvIGFsaWduIHdpdGggdGhlIEhXDQo+IGRlZmF1bHQg
c2V0dGluZyBvZiBnMTIwMCwgdGhpcyBmdW5jdGlvbiBuZWVkcyB0byBiZSB0dXJuZWQgb2ZmLg0K
PiANCg0Kd2hhdCBpcyBnMTIwMD8NCg0KPiAyLkR1ZSB0byB0aGUgZGlmZmVyZW5jZSBvZiBIVywg
ZGlmZmVyZW50IGRpdmlkZXJzIG5lZWQgdG8gYmUgc2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
WGlubGVpIExlZSA8eGlubGVpLmxlZUBtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpp
dGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwLmMgICAgIHwgMzINCj4gKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwX3JlZy5oIHwgIDUgKysrKysN
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiBpbmRleCA3NjdiNzFkYTMxYTQuLjY1
YTk5ODRlYWM4MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiBAQCAtMTM5
LDYgKzEzOSw4IEBAIHN0cnVjdCBtdGtfZHBfZGF0YSB7DQo+ICAJdW5zaWduZWQgaW50IHNtY19j
bWQ7DQo+ICAJY29uc3Qgc3RydWN0IG10a19kcF9lZnVzZV9mbXQgKmVmdXNlX2ZtdDsNCj4gIAli
b29sIGF1ZGlvX3N1cHBvcnRlZDsNCj4gKwljb25zdCBib29sIGFycmFuZ2U7DQo+ICsJY29uc3Qg
dTggYXVkaW9fbV9kaXYyOw0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
ZHBfZWZ1c2VfZm10DQo+IG10ODE5NV9lZHBfZWZ1c2VfZm10W01US19EUF9DQUxfTUFYXSA9IHsN
Cj4gQEAgLTY0Niw4ICs2NDgsMTAgQEAgc3RhdGljIHZvaWQNCj4gbXRrX2RwX2F1ZGlvX3NkcF9h
c3Bfc2V0X2NoYW5uZWxzKHN0cnVjdCBtdGtfZHAgKm10a19kcCwNCj4gIA0KPiAgc3RhdGljIHZv
aWQgbXRrX2RwX2F1ZGlvX3NldF9kaXZpZGVyKHN0cnVjdCBtdGtfZHAgKm10a19kcCkNCj4gIHsN
Cj4gKwl1OCBkaXYyX2lkID0gbXRrX2RwLT5kYXRhLT5hdWRpb19tX2RpdjI7DQo+ICsNCj4gIAlt
dGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtfRFBfRU5DMF9QMF8zMEJDLA0KPiAtCQkJICAg
QVVESU9fTV9DT0RFX01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX0RJVl8yLA0KPiArCQkJICAgZGl2
Ml9pZCA8PA0KPiBBVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfU0hJRlQsDQo+
ICAJCQkgICBBVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfTUFTSyk7DQo+ICB9
DQo+ICANCj4gQEAgLTEzNjIsNiArMTM2NiwxNCBAQCBzdGF0aWMgdm9pZA0KPiBtdGtfZHBfc2Rw
X3NldF9kb3duX2NudF9pbml0X2luX2hibGFuayhzdHJ1Y3QgbXRrX2RwICptdGtfZHApDQo+ICAJ
CQkgICBTRFBfRE9XTl9DTlRfSU5JVF9JTl9IQkxBTktfRFBfRU5DMV9QMF9NQVNLKQ0KPiA7DQo+
ICB9DQo+ICANCj4gK3N0YXRpYyB2b2lkIG10a19kcF9hdWRpb19zYW1wbGVfYXJyYW5nZShzdHJ1
Y3QgbXRrX2RwICptdGtfZHApDQo+ICt7DQo+ICsJaWYgKG10a19kcC0+ZGF0YS0+YXJyYW5nZSkg
ew0KPiArCQltdGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtfRFBfRU5DMV9QMF8zMzc0LCAw
LA0KPiBCSVQoMTIpKTsNCj4gKwkJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX0VO
QzFfUDBfMzM3NCwgMCwNCj4gMHhGRkYpOw0KPiArCX0NCj4gK30NCj4gKw0KDQpSZW1vdmUgImlm
IChtdGtfZHAtPmRhdGEtPmFycmFuZ2UpIiBhbmQgYWRkIHRoZW0gb3VzaWRlIHRoaXMgZnVuY3Rp
b24uDQoNCj4gIHN0YXRpYyB2b2lkIG10a19kcF9zZXR1cF90dShzdHJ1Y3QgbXRrX2RwICptdGtf
ZHApDQo+ICB7DQo+ICAJdTMyIHNyYW1fcmVhZF9zdGFydCA9IG1pbl90KHUzMiwNCj4gTVRLX0RQ
X1RCQ19CVUZfUkVBRF9TVEFSVF9BRERSLA0KPiBAQCAtMTM3MSw2ICsxMzgzLDcgQEAgc3RhdGlj
IHZvaWQgbXRrX2RwX3NldHVwX3R1KHN0cnVjdCBtdGtfZHANCj4gKm10a19kcCkNCj4gIAkJCQkg
ICAgTVRLX0RQX1BJWF9QRVJfQUREUik7DQo+ICAJbXRrX2RwX3NldF9zcmFtX3JlYWRfc3RhcnQo
bXRrX2RwLCBzcmFtX3JlYWRfc3RhcnQpOw0KPiAgCW10a19kcF9zZXR1cF9lbmNvZGVyKG10a19k
cCk7DQo+ICsJbXRrX2RwX2F1ZGlvX3NhbXBsZV9hcnJhbmdlKG10a19kcCk7DQoNCmlmIChtdGtf
ZHAtPmRhdGEtPmFycmFuZ2UpDQogICAgICAgIG10a19kcF9hdWRpb19zYW1wbGVfYXJyYW5nZSht
dGtfZHApOw0KDQoNCkJScywNCkJvLUNoZW4NCg0KPiAgCW10a19kcF9zZHBfc2V0X2Rvd25fY250
X2luaXRfaW5faGJsYW5rKG10a19kcCk7DQo+ICAJbXRrX2RwX3NkcF9zZXRfZG93bl9jbnRfaW5p
dChtdGtfZHAsIHNyYW1fcmVhZF9zdGFydCk7DQo+ICB9DQo+IEBAIC0yNjE1LDExICsyNjI4LDIy
IEBAIHN0YXRpYyBpbnQgbXRrX2RwX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICANCj4g
IHN0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhtdGtfZHBfcG1fb3BzLCBtdGtfZHBfc3VzcGVuZCwN
Cj4gbXRrX2RwX3Jlc3VtZSk7DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2Rh
dGEgbXQ4MTg4X2RwX2RhdGEgPSB7DQo+ICsJLmJyaWRnZV90eXBlID0gRFJNX01PREVfQ09OTkVD
VE9SX0Rpc3BsYXlQb3J0LA0KPiArCS5zbWNfY21kID0gTVRLX0RQX1NJUF9BVEZfVklERU9fVU5N
VVRFLA0KPiArCS5lZnVzZV9mbXQgPSBtdDgxOTVfZHBfZWZ1c2VfZm10LA0KPiArCS5hdWRpb19z
dXBwb3J0ZWQgPSB0cnVlLA0KPiArCS5hcnJhbmdlID0gdHJ1ZSwNCj4gKwkuYXVkaW9fbV9kaXYy
ID0gNCwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4
MTk1X2VkcF9kYXRhID0gew0KPiAgCS5icmlkZ2VfdHlwZSA9IERSTV9NT0RFX0NPTk5FQ1RPUl9l
RFAsDQo+ICAJLnNtY19jbWQgPSBNVEtfRFBfU0lQX0FURl9FRFBfVklERU9fVU5NVVRFLA0KPiAg
CS5lZnVzZV9mbXQgPSBtdDgxOTVfZWRwX2VmdXNlX2ZtdCwNCj4gIAkuYXVkaW9fc3VwcG9ydGVk
ID0gZmFsc2UsDQo+ICsJLmFycmFuZ2UgPSBmYWxzZSwNCj4gKwkuYXVkaW9fbV9kaXYyID0gNSwN
Cj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4MTk1X2Rw
X2RhdGEgPSB7DQo+IEBAIC0yNjI3LDkgKzI2NTEsMTUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfZHBfZGF0YSBtdDgxOTVfZHBfZGF0YQ0KPiA9IHsNCj4gIAkuc21jX2NtZCA9IE1US19EUF9T
SVBfQVRGX1ZJREVPX1VOTVVURSwNCj4gIAkuZWZ1c2VfZm10ID0gbXQ4MTk1X2RwX2VmdXNlX2Zt
dCwNCj4gIAkuYXVkaW9fc3VwcG9ydGVkID0gdHJ1ZSwNCj4gKwkuYXJyYW5nZSA9IGZhbHNlLA0K
PiArCS5hdWRpb19tX2RpdjIgPSA1LA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgbXRrX2RwX29mX21hdGNoW10gPSB7DQo+ICsJew0KPiArCQkuY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtZHAtdHgiLA0KPiArCQkuZGF0YSA9ICZtdDgxODhfZHBf
ZGF0YSwNCj4gKwl9LA0KPiAgCXsNCj4gIAkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1
LWVkcC10eCIsDQo+ICAJCS5kYXRhID0gJm10ODE5NV9lZHBfZGF0YSwNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfcmVnLmgNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwX3JlZy5oDQo+IGluZGV4IDg0ZTM4Y2VmMDNjMi4uNGRjNGY3Y2Qw
ZWYyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwX3JlZy5o
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfcmVnLmgNCj4gQEAgLTE1
OCw2ICsxNTgsNyBAQA0KPiAgI2RlZmluZSBNVEtfRFBfRU5DMF9QMF8zMEE4CQkJMHgzMGE4DQo+
ICAjZGVmaW5lIE1US19EUF9FTkMwX1AwXzMwQkMJCQkweDMwYmMNCj4gICNkZWZpbmUgSVNSQ19D
T05UX0RQX0VOQzBfUDAJCQkJQklUKDApDQo+ICsjZGVmaW5lIEFVRElPX01fQ09ERV9NVUxUX0RJ
Vl9TRUxfRFBfRU5DMF9QMF9TSElGVAk4DQo+ICAjZGVmaW5lIEFVRElPX01fQ09ERV9NVUxUX0RJ
Vl9TRUxfRFBfRU5DMF9QMF9NQVNLCUdFTk1BU0soMTAsIDgpDQo+ICAjZGVmaW5lIEFVRElPX01f
Q09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9NVUxfMgkoMSA8PCA4KQ0KPiAgI2RlZmluZSBB
VURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfTVVMXzQJKDIgPDwgOCkNCj4gQEAg
LTIyOCw2ICsyMjksMTAgQEANCj4gIAkJCQkJCQkgVklERU9fU1RBQkxFX0MNCj4gTlRfVEhSRF9E
UF9FTkMxX1AwIHwgXA0KPiAgCQkJCQkJCSBTRFBfRFAxM19FTl9EUA0KPiBfRU5DMV9QMCB8IFwN
Cj4gIAkJCQkJCQkgQlMyQlNfTU9ERV9EUF8NCj4gRU5DMV9QMCkNCj4gKw0KPiArI2RlZmluZSBN
VEtfRFBfRU5DMV9QMF8zMzc0CQkJMHgzMzc0DQo+ICsjZGVmaW5lIEFVX0FTUF9QQUNLRVRfT05M
WV9JTl9IQkxBTktfRU5BQkxFX01BU0sJMHgxMDAwDQo+ICsNCj4gICNkZWZpbmUgTVRLX0RQX0VO
QzFfUDBfMzNGNAkJCTB4MzNmNA0KPiAgI2RlZmluZSBEUF9FTkNfRFVNTVlfUldfMV9BVURJT19S
U1RfRU4JCQlCSVQoMCkNCj4gICNkZWZpbmUgRFBfRU5DX0RVTU1ZX1JXXzEJCQkJQklUKDkpDQo=
