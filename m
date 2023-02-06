Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2E68B40E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 03:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBFCBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 21:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBFCBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 21:01:52 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7841ADC0;
        Sun,  5 Feb 2023 18:01:45 -0800 (PST)
X-UUID: 30be81b0a5c211ed945fc101203acc17-20230206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=a93JdUbtkM8YCZrQazYMx8ctGOHXQwLKS02g3KulzTY=;
        b=N8PzXTrRsWijktVs7Ob8FBToWSRaKOMYA4qFEDhEBtqvBJJ7aBx3TufeuQXt7SMzk/bPXzRIRUkcQOd+HYBtOAkb5OgZJKWexDk+M7fSbnDPKsgvc/rB/FH+QP5h58hZ+jIsGMCDG+UMzoZfkdeL+O5MTRTJDriQzOe0rGfxsek=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:6554f831-fc59-44dd-b3aa-afa1f3019424,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:441a6256-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 30be81b0a5c211ed945fc101203acc17-20230206
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1661281947; Mon, 06 Feb 2023 10:01:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 6 Feb 2023 10:01:37 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 6 Feb 2023 10:01:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWOlU/Gwfo3/EOYz3o2LrBS/nipNfZv5emZ9tuUxopM1RLw+Aq8C0h+LgzuMHjpRZLgPkDQ5sbXdCxQlBrv5PNxxfpho8EA6id0Pj4ELy22bykO/XtKt8Q3v84xY0ID/zB15sMT29a6CGP9u+1gscMRt6mwXxKNJ8HIquRrYrK/PRUTNLZdjluwlmSGj3Laoh9gpx8cCJnR4wZ+G/sskkumZixDwdtdnYESdp8Hwga1tg16KMNL+kVd337oKUf28V0L0X2Mi1dTF/r4D6LTYwZeP8uxq/FjtBV/nr51E7ZgmAzBGRPv4QsOu78ICr12n+LkWmhaMBNpb8WokKB6RCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a93JdUbtkM8YCZrQazYMx8ctGOHXQwLKS02g3KulzTY=;
 b=H174tN445JumXP5Z5yp9zUliIOJd/f3UVNZZhNREArdjwgcYi6kAGRyG+kZXihhEBOlb9E9SDec1Dxnf01IKrBokLED3rnnGttd7oAqTQTh5E9I+ja3jKzSyqvNLwjbTne0vuvlczpJpXxUu6iGytStDaZuKY15NAh14Rk+440VXms2PVGbPWELvIjgcaViiCOQJrXNGDHJHPVBgT0jfGOJvlz/TkaF2ERT5Z5CNwqpXWSnbOojF5M9Ix+xIj77i6cXGISitmDzxHeAdaS03UluoeC6gN+GEBOYZXKwZjbGOZ86SVEeKqy9f3Lm8ihReaDAPGNu2xfTQXwXw1hOIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a93JdUbtkM8YCZrQazYMx8ctGOHXQwLKS02g3KulzTY=;
 b=fDw5oJYDqnddQ+kThaZD+zfr2lUCpNyoMDhSKJwskX34tj01ddsWCJsRnGKVc6gLYYL7L+heyzx/RVrPfswyWYo0eKqVqg6/m4nCrLzz4/SVIXSPWppetL9XYlHLNTdOqwri0LGUBtdrzefPlTF0lQWYn8H3BiOAuDeTV8vISDo=
Received: from TY2PR03MB3439.apcprd03.prod.outlook.com (2603:1096:404:33::10)
 by TYZPR03MB6672.apcprd03.prod.outlook.com (2603:1096:400:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Mon, 6 Feb
 2023 02:01:35 +0000
Received: from TY2PR03MB3439.apcprd03.prod.outlook.com
 ([fe80::c628:9f8b:322:bef6]) by TY2PR03MB3439.apcprd03.prod.outlook.com
 ([fe80::c628:9f8b:322:bef6%3]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 02:01:35 +0000
From:   =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>
To:     "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "drinkcat@google.com" <drinkcat@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>,
        =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>
Subject: Re: [PATCH v4 05/14] soc: mediatek: mtk-svs: use svs clk control APIs
Thread-Topic: [PATCH v4 05/14] soc: mediatek: mtk-svs: use svs clk control
 APIs
Thread-Index: AQHZJZDHI+SQIEhX8UKhJMQ/hdyBe664ohSAgAGESoCAAXDlgIAFu3kA
Date:   Mon, 6 Feb 2023 02:01:34 +0000
Message-ID: <615b406692504bb68bd781030023c0fa7b2bd11e.camel@mediatek.com>
References: <20230111074528.29354-1-roger.lu@mediatek.com>
         <20230111074528.29354-6-roger.lu@mediatek.com>
         <5192bc94-12c7-dce4-c2e6-fa4b8c1ced9d@gmail.com>
         <546d7f2b3607310f0ebe11b3d4e0aac40ac44c7a.camel@mediatek.com>
         <68d19d2b-0613-f1b4-08ff-9d86f5021f9f@gmail.com>
In-Reply-To: <68d19d2b-0613-f1b4-08ff-9d86f5021f9f@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR03MB3439:EE_|TYZPR03MB6672:EE_
x-ms-office365-filtering-correlation-id: 74ba0f9f-ef6d-414d-0938-08db07e61339
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C/Z02Tkqq92jPESZmXR7gbTypow9mz61CRnilsnVZsdoF+rDMIQYqlXaP0VnWa8GKzyOX5yTy6qLeGOi/EplEhm0E7dvRF4mIKihiFyxPGxNmnluW5PJ/j8v+64wy9nMXzpa6EzCDamE9iXkxyZEaHDg+WzU7Mb4fzJ7Z0Z/X2XBjvhyJn+yJpLsxSTcOcWbSU4DDGhM7tUC9MxGEXjFNzuDvT5xNEtHgX0vXYIISJHtMuJhbWh9kO5JbP6ENOKP4wHhnoRFrWZPhkmY4xNFyrgB1x7dtdvmgGQaaIh8J9m6y5IbHF0jJ+VzEh2F9vMrciom/6vIPQU7aBb5OFdlKP6RUZio0dJ5U/fiZ9PVQYG/9nJrG77bYFYQ/5L6ycGUuFDslrZ861jelhI48qQqht4hAQSeptSfZIAIWbYMrvnd/7weL4ipFjvzXxlf22pmVjFAC03HHLL7OuAlEmg64VEXsl8cENv3rSE7DZAuzNcb/ISmal/mrveHHVhwlodG9tL30QP2PHBYxiFOYPdsDGy3kLQthRRCeR5T3t3eLe1BgDNJ//cafMu9ZwP8vim3IjBSi9zXKdG2fnjSjYkdUQGZNat4Ah/CoBXoCDEIPGc4jdiD+iRtDiwn4PQLXcrXJM2gBYdvl/2FgQq90ccjrjjS4QIe80x7pVodhehE5JMfU6zbjjlepSeJ2LPhKH45YN6Hvzbe5S+KFmG9ppEqIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR03MB3439.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(396003)(136003)(346002)(366004)(376002)(451199018)(85182001)(36756003)(66446008)(7416002)(66556008)(76116006)(6512007)(38070700005)(110136005)(54906003)(4326008)(6506007)(122000001)(478600001)(38100700002)(71200400001)(2906002)(316002)(6486002)(53546011)(83380400001)(26005)(8936002)(41300700001)(86362001)(5660300002)(8676002)(64756008)(66476007)(66946007)(186003)(107886003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0U0L2RXRE1lZi8rL1pHRFlqdXAyU2p2Qit0VFNvcThFUGRlWks5Zk52NWFZ?=
 =?utf-8?B?aFA3LzZrbk1la1FFOWhQd0orSys3VEJYcnNuM1Z5ajJwQmRGWk5KbENVdWpO?=
 =?utf-8?B?ZnZ3MnlQSEc0Q1JQeWp3WEhwQ1dZekwza0VldmZyM1AvcmdVRnFXUVVxZm8r?=
 =?utf-8?B?VjdvTnJNc3dwSzJWMTdtMDlUUzViK053b0pnZnM4bHBySmZ2V1hTU0tDeVU5?=
 =?utf-8?B?ZVpQNExQSWVIZGUvbEltc3AwQUhUb3QwOVE3QUErL3h0cXdJUmtCRzdzS0Fw?=
 =?utf-8?B?ZEdmQWdmTlkwWkpET2kwMkJNQ0ljTUo1Zmo5K3lTUHRSQU84TWJqdEFETlVL?=
 =?utf-8?B?VElCLzUrVnVRa0poSDdZZ1lsOTA5VUR2c09lcENzNldrQ1dHU1FrT3MzYmxL?=
 =?utf-8?B?ZGloYWxiWXJYalJHbUwyK0V5SzBhb3V5eTVuYUMyK2tUcVBJSFlGeTljQ1R3?=
 =?utf-8?B?R1k1R1pyQko4RFQzTlVnMTlIMWtRUDlKVWRpdld6OThyZWFzbFpUcm4ycVN3?=
 =?utf-8?B?cjI5RGVmZTV1TXFMUWR2NzVCTkV3M3BWcGNuQi8ySDl4S1ExWDBEOSsvcjc3?=
 =?utf-8?B?QXgwTi9DbTR2WE83N0ZodUZhWWNBVDFSdUI2c091UVBDVFJGZTAzMW9WeVVo?=
 =?utf-8?B?ZDN2ZmV4blU2cjhYYVd5cEFQOUhRcXUwN2ZjSnlVL1d6V0wxYndtSmM0VHl0?=
 =?utf-8?B?S2hlWkpWajJqVWkxUlhwQmpUZGFCVVdZd3V0aDBTY08zazk3N1laRmVuc2kv?=
 =?utf-8?B?MTBEdEliSjNXZ2VNalZVM3ZtcFUwOVZvQzNDeTRxdUZ1NFNpM2dsaUlTSVYz?=
 =?utf-8?B?djdxSDBDT0NjVjBwZVl2aEhXNkJzSWsreEdhQ3RYdCs4SytIRDZ5VlJMK25h?=
 =?utf-8?B?OVp0eVJCYlpCZ3JYVTIvZ05UWnFKZkV0NE1EdU1NK1dLenNwa0N4aGZRalVq?=
 =?utf-8?B?UTgwTmxMSjJPeWtDaTRIMEZGWWloa3Z3enA4SE94Q2c5RVo2MzZXWjI2WnRk?=
 =?utf-8?B?dGxzQkxXRDFOZnlEVlpTdzdlOHRUN0xnbmNRN3J4YjJ2bW5OeGhYbGJNMEkz?=
 =?utf-8?B?akFGWXp2TnNvWUdRUzBEQklSMk9EaGx0dHRGdWpqOGNhaFc3Q004NTRUSnJz?=
 =?utf-8?B?M2FCa2RmeEhBbnFkQndpVjYrVGRWZDc3R2VPK1RxellReERqSmpsN3l4eENu?=
 =?utf-8?B?dmhtc21RVFpibTlwV2NtUzB5QlBBdFZDSXFxT2xBajY1OFVjVmF1VnRSY2RU?=
 =?utf-8?B?NEczaGx2dDB3NlpuUmFHV3pRUHp6U2MxM0FsT0xoaXpOa2lqNmVQOUk1M1U5?=
 =?utf-8?B?RnJodytWR2p6VWdsVHFZaGpsQ0hFRHAvTDA4YW5nWWhWcEM2a01OdHAzcjla?=
 =?utf-8?B?TW5RTWVUaXJ3WlBTZ3IzNDJKTUpESFZVMWJ6dWVZWjRZN3hxVm1YL0crT1VX?=
 =?utf-8?B?QWUrbzFZN1ZhWjRiRlRoZTNhaHlIYmZESFNwZmlxZ3BDck4vdTVmZUxJSzFs?=
 =?utf-8?B?NDQyV0NwZiszd0VtdmJzL090MDJjVTMvZzNod3R0UVovNGo3d21yYjh0c2JG?=
 =?utf-8?B?MytCVW9GMFRBQ2o0bkp4cmtQZ2FNYkRreFJZY0hGQUdyQ3JyT0RkeEF0d0Jp?=
 =?utf-8?B?VDB6SkRmQUNxMXdpL2hleU1oaWFYR052eU5HNEptTzlnSG45UzJyK2tpekx2?=
 =?utf-8?B?M2kvMW1sdktVMVJQZmhPN2pPYllUa21neHA2M3dPN1ROVnpBRnNtM2xHalI0?=
 =?utf-8?B?aWVSMSthcU9qazJFQ3JocFEzT1lyeHc1OWJEQXZFMEtXb2N5NU9wSGlWZG1W?=
 =?utf-8?B?ZFpaY3JrTEN1V2d1UjlUREI5emFDaW1ZM0RWdGdSK3NlMjBTTTZQbTNqdnBV?=
 =?utf-8?B?YjkwOHpjSHhYWVhKQmJ2N2FxQWxmcXIwK2J0bjZCdWMvVC8wRmpDMzRRNC8z?=
 =?utf-8?B?ZG15ZjFmWjB5MVd5VXY0RmlzdVkzWFROZ29zZ2dhWDRyRHgxT3BVTHlseGdB?=
 =?utf-8?B?bkM1Q1VrN1lmTUhMOGFnekxnem1Qb0FNc1NFZExnMS9hYnZ0NXZOaDFBcEty?=
 =?utf-8?B?Zms0OXNnS0tUekdqcE5lUlorS2tmbDkxQktDbFJoNUdWUXNUWktPYU5XTjZG?=
 =?utf-8?B?T1lSMXhYTDNhODNreElSeVVFTjVmaXlkSUlSMDJEbHdCZmgxTThsTyt6TXdQ?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67EF1038C570574DB1BFCFB78AC85AEB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR03MB3439.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ba0f9f-ef6d-414d-0938-08db07e61339
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 02:01:34.8965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /X+z3tbPLhpNICCy7xNFem3DysMnzDMKdLjTUIro4Z4tM3lnLoh2ho941enBSbUbi2JD9uX5G/O1IwtKpuA3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6672
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMgU2lyLA0KDQoNCk9uIFRodSwgMjAyMy0wMi0wMiBhdCAxMToyOSArMDEwMCwg
TWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4g5L2g5aW977yMDQoNCkkgZ290IHNob2NrIGFuZCB0
aG91Z2h0IHNvbWVvbmUgdXNlZCB5b3VyIG5hbWUgdG8gcmVwbHkuIEhvd2V2ZXIsDQp5b3VyIGVt
YWlsIGFjY291bnQgaGVscHMgbWUgY2xlYXIgbXkgbWluZC4gSGFoYS4uIE5pY2UgYW5kIHdhcm0g
dG8gc2VlIG1hbmRhcmluDQpvbiBwYXRjaHdvcmsuIEl0J3Mgc28gZnJlc2ggYW5kIGV4Y2l0aW5n
IDotKS4NCg0KPiANCj4gT24gMDEvMDIvMjAyMyAxMzoyOCwgUm9nZXIgTHUgKOmZuOeRnuWCkSkg
d3JvdGU6DQo+ID4gSGkgTWF0dGhpYXMgU2lyLA0KPiA+IA0KPiA+IE9uIFR1ZSwgMjAyMy0wMS0z
MSBhdCAxNDoxOSArMDEwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gPiA+IA0KPiA+ID4g
T24gMTEvMDEvMjAyMyAwODo0NSwgUm9nZXIgTHUgd3JvdGU6DQo+ID4gPiA+IEluIE1lZGlhVGVr
IEhXIGRlc2lnbiwgc3ZzIGFuZCB0aGVybWFsIGJvdGggdXNlIHRoZSBzYW1lIGNsayBzb3VyY2Uu
DQo+ID4gPiA+IEl0IG1lYW5zIHRoYXQgc3ZzIGNsayByZWZlcmVuY2UgY291bnQgZnJvbSBDQ0Yg
aW5jbHVkZXMgdGhlcm1hbCBjb250cm9sDQo+ID4gPiA+IGNvdW50cy4gVGhhdCBtYWtlcyBzdnMg
ZHJpdmVyIGNvbmZ1c2Ugd2hldGhlciBpdCBkaXNhYmxlZCBzdnMncyBtYWluIGNsaw0KPiA+ID4g
PiBvciBub3QgZnJvbSBDQ0YncyBwZXJzcGVjdGl2ZSBhbmQgbGVhZCB0byB0dXJuIG9mZiB0aGVp
ciBzaGFyZWQgY2xrDQo+ID4gPiA+IHVuZXhwZWN0ZWRseS4gVGhlcmVmb3JlLCB3ZSBhZGQgc3Zz
IGNsayBjb250cm9sIEFQSXMgdG8gbWFrZSBzdXJlIHN2cydzDQo+ID4gPiA+IG1haW4gY2xrIGlz
IGNvbnRyb2xsZWQgd2VsbCBieSBzdnMgZHJpdmVyIGl0c2VsZi4NCj4gPiA+ID4gDQo+ID4gPiA+
IEhlcmUgaXMgYSBORyBleGFtcGxlLiBSZWx5IG9uIENDRidzIHJlZmVyZW5jZSBjb3VudCBhbmQg
Y2F1c2UgcHJvYmxlbS4NCj4gPiA+ID4gDQo+ID4gPiA+IHRoZXJtYWwgcHJvYmUgKGNsayByZWYg
PSAxKQ0KPiA+ID4gPiAtPiBzdnMgcHJvYmUgKGNsayByZWYgPSAyKQ0KPiA+ID4gPiAgICAgIC0+
IHN2cyBzdXNwZW5kIChjbGsgcmVmID0gMSkNCj4gPiA+ID4gICAgICAgICAtPiB0aGVybWFsIHN1
c3BlbmQgKGNsayByZWYgPSAwKQ0KPiA+ID4gPiAgICAgICAgIC0+IHRoZXJtYWwgcmVzdW1lIChj
bGsgcmVmID0gMSkNCj4gPiA+ID4gICAgICAtPiBzdnMgcmVzdW1lIChlbmNvdW50ZXIgZXJyb3Is
IGNsayByZWYgPSAxKQ0KPiA+ID4gPiAgICAgIC0+IHN2cyBzdXNwZW5kIChjbGsgcmVmID0gMCkN
Cj4gPiA+ID4gICAgICAgICAtPiB0aGVybWFsIHN1c3BlbmQgKEZhaWwgaGVyZSwgdGhlcm1hbCBI
VyBjb250cm9sIHcvbyBjbGspDQo+ID4gPiA+IA0KPiA+ID4gPiBGaXhlczogYTgyNWQ3MmY3NGEz
ICgic29jOiBtZWRpYXRlazogZml4IG1pc3NpbmcgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKCkNCj4g
PiA+ID4gb24NCj4gPiA+ID4gZXJyIGluIHN2c19yZXN1bWUoKSIpDQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFJvZ2VyIEx1IDxyb2dlci5sdUBtZWRpYXRlay5jb20+DQo+ID4gPiANCj4gPiA+IFRo
YXQgbG9va3Mgd3JvbmcuIEFsdGhvdWdoIEkgZG9uJ3Qgb3V0IG9mIG15IG1pbmQsIHRoZXJlIHNo
b3VsZCBiZSBhIHdheQ0KPiA+ID4gdG8NCj4gPiA+IHRlbGwNCj4gPiA+IHRoZSBjbG9jayBmcmFt
ZXdvcmsgdGhhdCB0aGlzIGNsb2NrIGlzIHNoYXJlZCBiZXR3ZWVuIHNldmVyYWwgZGV2aWNlcy4N
Cj4gPiA+IA0KPiA+ID4gSSB3b25kZXIgaWYgdXNpbmcgY2xrX2VuYWJsZSBhbmQgY2xrX2Rpc2Fi
bGUgaW4gc3ZzX3Jlc3VtZS9zdXNwZW5kDQo+ID4gPiB3b3VsZG4ndA0KPiA+ID4gYmUNCj4gPiA+
IGVub3VnaC4NCj4gPiANCj4gPiBPaCB5ZXMsIENvbW1vbiBDbG9jayBGcmFtZXdvcmsgKENDRikg
a25vd3MgdGhlIGNsb2NrIHNoYXJlZCBiZXR3ZWVuIHNldmVyYWwNCj4gPiBkZXZpY2VzIGFuZCBt
YWludGFpbnMgY2xvY2sgIm9uL29mZiIgYnkgcmVmZXJlbmNlIGNvdW50Lg0KPiA+IA0KPiANCj4g
VGhlIHRoaW5nIGlzIGlmIHlvdSB1c2UgY2xrX3ByZXBhcmVfZW5hYmxlIHRoZW4gdGhlIGNsb2Nr
IGZyYW1ld29yayBjaGVjaydzDQo+IGlmIA0KPiB0aGUgY2xvY2sgaXMgYWxyZWFkeSBwcmVwYXJl
ZCwgd2hpY2ggY291bGQgaGFwcGVuIGxpa2UgeW91IGRlc2NyaWJlZCBpbiB0aGUgDQo+IHN2c19y
ZXN1bWUgKGVuY291bnQgZXJyb3IpIGNhc2UgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLiBUaGUgcXVl
c3Rpb24gaXMsIGNhbid0DQo+IHdlIA0KPiBqdXN0IHVzZSBjbGtfZW5hYmxlIGFuZCBjbGtfZGlz
YWJsZSBpbiByZXN1bWUvc3VzcGVuZCBhbmQgb25seSBwcmVwYXJlIHRoZQ0KPiBjbG9jayANCj4g
aW4gdGhlIHByb2JlIGZ1bmN0aW9uPw0KDQpXZSdsbCB0aGluayBpZiB0aGlzIGNhbiBmaXggdGhl
IHByb2JsZW0uIFRoYW5rcyBmb3IgdGhlIGFkdmljZSB2ZXJ5IG11Y2guDQoNCj4gDQo+ID4gV2Ug
Y29uY2VybiBob3cgdG8gc3RvcCBydW5uaW5nIHN2c19zdXNwZW5kKCkgd2hlbiBzdnMgY2xrIGlz
IGFscmVhZHkNCj4gPiBkaXNhYmxlZCBieQ0KPiA+IHN2c19yZXN1bWUoKS4gVGFrZSBhbiBleGFt
cGxlIGFzIGJlbG93LCBpZiB3ZSByZWZlcnMgdG8gX19jbGtfaXNfZW5hYmxlZCgpDQo+ID4gcmVz
dWx0IGZvciBrbm93aW5nIHN2cyBjbGsgc3RhdHVzLCBpdCB3aWxsIHJldHVybiAidHJ1ZSIgYWxs
IHRoZSB0aW1lDQo+ID4gYmVjYXVzZQ0KPiA+IHRoZXJtYWwgY2xrIGlzIHN0aWxsIG9uLiBUaGlz
IGNhdXNlcyB0aGUgcHJvYmxlbSBtZW50aW9uZWQgaW4gY29tbWl0DQo+ID4gbWVzc2FnZS4NCj4g
PiANCj4gDQo+IEkgd291bGQgZXhwZWN0IHRoYXQgdGhlIGtlcm5lbCB0YWtlcyBjYXJlIHRoYXQg
d2UgY2FuJ3QgZW50ZXIgYSByZXN1bWUgcGF0aA0KPiBmb3IgDQo+IGEgZGV2aWNlIGJlZm9yZSB0
aGUgc3VzcGVuZCBwYXRoIGhhcyBmaW5pc2hlZC4gSG9uZXN0bHkgSSBkb24ndCByZWFsbHkgDQo+
IHVuZGVyc3RhbmQgdGhlIHByb2JsZW0gaGVyZS4gSXQgc2VlbXMgc29tZXRoaW5nIGRpZmZlcmVu
dCB0aGVuIHdoYXQgeW91IA0KPiBkZXNjcmliZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiAN
Cj4gUGxlYXNlIGhlbHAgbWUgdW5kZXJzdGFuZCBiZXR0ZXIuDQoNCkkgc2VlLiBUaGlzIHBhdGNo
IHRpdGxlIG5lZWRzIHRvIGJlIGNoYW5nZWQgdG8gImF2b2lkIHR1cm5pbmcgb2ZmIHN2cyBjbGsg
dHdpY2UNCnVuZXhwZWN0ZWRseSIgZm9yIHBvaW50aW5nIG91dCB0aGUgcHJvYmxlbSBwcmVjaXNl
bHkuIFdlIHNhdyBhIGxvb3Bob2xlIHRoYXQgc3ZzDQpjbGsgbWlnaHQgYmUgdHVybmVkIG9mZiBp
biBzdnNfcmVzdW1lKCkgZmlyc3QgYW5kIGluIHN2c19zdXNwZW5kKCkgYWdhaW4gd2l0aG91dA0K
ZW5hYmxpbmcgc3ZzIGNsayBkdXJpbmcgdGhlc2UgdGhlIHByb2Nlc3MuIFRoZXJlZm9yZSwgd2Ug
dHJ5IHRvIGZpeCBpdCBieSB0aGlzDQpwYXRjaC4gQmVsb3cgaXMgb3VyIHRoaW5raW5nIHByb2Nl
c3MgdG8gZXhwbGFpbiBob3cgd2UgZ290IGhlcmUuDQoNCjEuIChhYmFuZG9uZWQpIFdlIGFkZCBf
X2Nsa19pc19lbmFibGVkKCkgY2hlY2sgaW4gc3ZzX3N1c3BlbmQoKSB0byBwcmV2ZW50IHN2cw0K
Y2xrIGZyb20gYmVpbmcgdHVybmVkIG9mZiB0d2ljZSB3aGVuIHN2c19yZXN1bWUoKSB0dXJuZWQg
b2ZmIHN2cyBjbGsgaW4gdGhlDQplcnJvci1oYW5kbGluZyBwcm9jZXNzLiBOb25ldGhlbGVzcywg
d2UgbWV0IHRoZSBORyBjYXNlIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCjIuIChjdXJyZW50IHBh
dGNoKSBXZSBhZGQgc3ZzIGNsayBjb250cm9sIGhpbnQgdG8gdW5kZXJzdGFuZCBpZiB3ZSBuZWVk
IHRvIHJ1bg0Kc3ZzX3N1c3BlbmQoKSBvciBub3QgaWYgc3ZzX3Jlc3VtZSgpIHR1cm5lZCBvZmYg
c3ZzIGNsayBiZWZvcmUuDQoNCj4gDQo+IOiwouiwou+8jOWGjeingQ0KDQo6LSkNCg0KDQpTaW5j
ZXJlbHksDQpSb2dlciBMdQ0K
