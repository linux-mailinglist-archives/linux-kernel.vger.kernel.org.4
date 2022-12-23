Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904F5654CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiLWHfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLWHfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:35:14 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D653C30F48;
        Thu, 22 Dec 2022 23:35:11 -0800 (PST)
X-UUID: 99b606d77a534caeb9549ea2b98fcd4e-20221223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=yTCtXhkxvtLkiT1Zc63r/YKHtjuFiOTlRH3ukaf0RCw=;
        b=Jx8QhAJltIIvI5bf9eQQHLsP7x3fwffiNHN8jV0vD0X/jTqWwEovPs4XCvcRlLu9AvBLZMsi9hMiGIMh0y8xiWmwSqVHRpud2n+3I0Ji1nLyXQ7WDG97hgXIqprz8IwARc9aB2xwnwIuk4YfWwsXqNiGH8uPu9RjAnEK91BI/JQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:c163b474-12a2-4403-b4b1-5589e45f2f50,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:bc68338a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 99b606d77a534caeb9549ea2b98fcd4e-20221223
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <garmin.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 518194425; Fri, 23 Dec 2022 15:35:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 23 Dec 2022 15:35:04 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 23 Dec 2022 15:35:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBn1TGndQDO67BnxBdB26gjJ01OJsVJcdBD6OPhTXQLpDLzhswY3CNpIUPzssaPsao3t9ExTJ4X+lWTZN5C5iHknToNpOWV7HkU42zD49zWISzD1z3OGbu+v9b2/FrfdfAtxipY/t7G/aU7yFj92/Oy3ddNHuyiuwdApRaXaH8oeXxYgLaovbPRpn5w5ml0vdceVKJ6P8ple4On+db+tqX3P4D2n1jk7IkPmHjyMoM5uXcdNQxaT+188rwaVabczAvgyzDyUXrao6tQ8lt1H7g5RXfzpAuanu1npLPF+5VjRv4KyuYIOuPXAMA945SC5vum3alGoOWIcsiVuiLjE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTCtXhkxvtLkiT1Zc63r/YKHtjuFiOTlRH3ukaf0RCw=;
 b=kTfvqm97R8XMihj6aJX9JcIBLdKiKIi8IZs3lVoCQZuqwh5KaaXtwwtlSWvTSJgndGcj7WoNZbuEnN2jENxsI5lkoZ8NljKsETwa0AjaGHcrus+ts5j6U6jst5rUGGy7oafSDpP/l4DB3AtQ49pQmWz84ePMy34pV1S646NER2cT56TlcC9w7zg4xJH7cuXzTH7BEi5i5kG1G4jYTKZ7QtKp2mOueJK1CYUSsXkJ5YnPvDET7D9geiii/qbCsRzYMffNSwubgzFdYo29N2FIpJXzDajfss6lyo5pMUgQm0fC44LMyybvAwZG87YEVryQ5PA21K0DrV+NqU/8iGKfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTCtXhkxvtLkiT1Zc63r/YKHtjuFiOTlRH3ukaf0RCw=;
 b=HlRNC9InIHzFXzHKcPp6GIIee63JMdhvQEce5lC1lhu8qpD7UO09aR+EdGMWuDzvlawMOPbtQWYOeyUGhUrF+mD1qZeO9kXM+aj70PGRKqBEkBZn9Lt8W776YNdc2rEkxRAlDjcheo6OY2pHIJc9KaxOGJA5Qrjy/liPAn6bU3g=
Received: from SI2PR03MB5888.apcprd03.prod.outlook.com (2603:1096:4:145::6) by
 PSAPR03MB6233.apcprd03.prod.outlook.com (2603:1096:301:9a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Fri, 23 Dec 2022 07:35:02 +0000
Received: from SI2PR03MB5888.apcprd03.prod.outlook.com
 ([fe80::914:6297:ee3:511e]) by SI2PR03MB5888.apcprd03.prod.outlook.com
 ([fe80::914:6297:ee3:511e%9]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 07:35:02 +0000
From:   =?utf-8?B?R2FybWluIENoYW5nICjlvLXlrrbpipgp?= 
        <Garmin.Chang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 02/19] clk: mediatek: Add MT8188 apmixedsys clock
 support
Thread-Topic: [PATCH v2 02/19] clk: mediatek: Add MT8188 apmixedsys clock
 support
Thread-Index: AQHY540Sdh1qRfGKXUiLjpEMAxnZpa4h6wQAgFmIA4A=
Date:   Fri, 23 Dec 2022 07:35:02 +0000
Message-ID: <fca3f7945c07e71d83566e5e6b6bd3aaaa2ad0e5.camel@mediatek.com>
References: <20221024094254.29218-1-Garmin.Chang@mediatek.com>
         <20221024094254.29218-3-Garmin.Chang@mediatek.com>
         <1dbba01b-157d-c04b-8f06-4d9ec79b1d5c@collabora.com>
In-Reply-To: <1dbba01b-157d-c04b-8f06-4d9ec79b1d5c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5888:EE_|PSAPR03MB6233:EE_
x-ms-office365-filtering-correlation-id: c06c2fb6-2379-4f1e-0eb3-08dae4b83407
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xwvlxrppRGdWXejgLEN5EkRdK+c/3fNHaG+hgIFXgeU8y3KW45ch6M+hU+UJR+c6CPvFf8qZ1vFP58ybOxIQCCBZ8R3E6aY8IFFhbfwLFg6Bq/rDORWe8QtwmA7yvE8HkNs+aauByk+Z3WBBD74bM64WxYA4wKzGZVW26m866rlp1PXeqqv+zdUmZzFiZtJS4Uzqun2GcB0Y36SvGLi6CYn72D0fB0bs+Y4BYaSZNQZzPavzbFab80+jezGKqksWfxobwHU8w0/2Hcnr1njWoRM95cMxg1QdfYqR65pM498l55g/KSaQn/YUpdYd+rPAhde0BxCH9mQdETGYkwp/3OHDZObvWJm6ZTl0S5VBBU7zWXYsvTlHHcUYUj8DqFP9CmCLlTmJvssEN0N/E1whtN5hXxH/U8eyyKPv29bQ7I22err7U9aMfI4s6ljDRSYBaESQQAEDOL9IKCOt04XdFXWICyUrfw3Yac15inq9ojtXhWvTrAwuejXHThyagaKVYRbOozvSPITOR7YcDIxTvSoNriu7Fr0VWDnx3FErRqVJ/Tt+F6KS4LnRf8wb9CYlj8e7OBd3wOMLOc09ipNU2tgbZSS5LcNS2yoSoGQ2XhHBY4xe4BVJcTi3sWrn/UHLsH8Qpw273j4hetgQhmEExtzlDwcucUByQk6NohlyfosR8CU8zAxTaUHVXPgkMijRwO8rm8w/L4dSR8SBXJpK1LfenB0vM8grrLhp5P8DkDuTKV96c9DlW/UXBxguN8oI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199015)(86362001)(91956017)(66946007)(64756008)(66476007)(76116006)(8676002)(4326008)(316002)(66556008)(66446008)(85182001)(38070700005)(8936002)(2616005)(5660300002)(36756003)(41300700001)(6506007)(6512007)(83380400001)(26005)(186003)(71200400001)(110136005)(2906002)(6486002)(122000001)(54906003)(38100700002)(478600001)(4001150100001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ancxa1NxOXlwWHBRWFpLeXhkUUp4Y05HOEdpN05RY1JCOEZWdjJHZzU4eWFR?=
 =?utf-8?B?ZzFaMUs5eXRtNVpIYWN1am1SUXRZVHRraXVWY25VQWxwOTJEbjNEa0p5NmZR?=
 =?utf-8?B?WDNOZ1NRci9TTXRsYjlJOFd2WHk1RS84SG4rTXB4SlRMSzdMZjFkb2kvRHJM?=
 =?utf-8?B?WmJnS3BCc0E5bDFsL1hZWU5JeFJDUGMwZXcwQVI1WDllTG1lMW5mSnA5WlNu?=
 =?utf-8?B?bVR6bU5iazNLR2FPbnIxRzYrS1lPaktPaFBZa2lXeW5USFpwb04zSUVRd3BU?=
 =?utf-8?B?K21paFczWWJzeDF1VVBuNVdNVFFEWnBuMnVpQUVIQktHOHNnQ1FIS1Y1WHQx?=
 =?utf-8?B?bFI5TGkzazNQNFgrSFJSRTE1aWlkdGQ0K0t3WVErZjNvZVczNy9Ga01nTGJY?=
 =?utf-8?B?MEw4OXBrQWhFM2FGZ1h3TC9tekFsK09udzBIWXM3ZllPZVBFVWgrVm5aOXV4?=
 =?utf-8?B?elptbE9DWEw5bDlib1lERmtHNDEyQjZaK0VTOXl1VjY3TkoyWDZWamJwREhN?=
 =?utf-8?B?Yzdla2hxTTNVVjNxUjhQdWJ1b09VOEFMU0hpMkplQjRycnFFNFh3N1ZxMWps?=
 =?utf-8?B?NG5nRU5OT0c3eERIcWxUd2s0eC96UG9yQXFqZDdCVERvNlJCT0o1MDdaUFps?=
 =?utf-8?B?dHpGd3R2YWhUa1Nha2VwM3BwZmFNL3VnekI5VjltMEVscnVINkU3enM1QS93?=
 =?utf-8?B?bWZNTEJCMHpKd0hnMmhNRXF2Q0tMRE5nL0NmWEpzM1BHSU9XUGFoc0ZyVmZz?=
 =?utf-8?B?bzVFQm1BN3lUVm1YaVV4Z3d3eGptMXRiN2hYSSt4UTIvY0dIMytVdDJOQTRV?=
 =?utf-8?B?dW4xRUwzbWRCNDBGMXJsSzFXbUNnUHFhTUdRUDNqOEljL3UwL25oTFJIVzQx?=
 =?utf-8?B?dkQzNXJFNkVSK0JmOStzbHpNSHZyU04zd1ZjWXVCOEVhZjdhNldHdEZHaXFw?=
 =?utf-8?B?RzJvRUI0a1hVUzBrbWRZM1VwcG5kWGNiODZPbkVBWExtOGJqbzFmZld2akJV?=
 =?utf-8?B?NTB3cjA3d0hKZ09oOG5GNW92OHdRa2F6djc2Uk1iZWxBL3dHU0o4bHJ4dity?=
 =?utf-8?B?QWtBM2JkK2FxNnppQkt4UUhJV2xCYUNJT1BETlV0MHhvYmZMYmQ2ZmtFMEdZ?=
 =?utf-8?B?NVpGKzF4S25nT0xFLzF2Y0xXQWdJaHlaNFFrV0JGVjVkMHI0ZVUrOTR6SzZs?=
 =?utf-8?B?dTNoTkhobGVqbVlFRVA0cDR0Mi9kZ1hseDg5b2g4NkRvOHhjSmE5aWZmenpi?=
 =?utf-8?B?c1pIMkcrUlNTOGlRend4aytaQXdsdU9HSE80YkJjSGRvOXFOZURyNDJ0aVRy?=
 =?utf-8?B?SzhxQzdUYS9PNVdndE9uQmp0WTdtU2duMUdia1l6MlVyQmpiYjJqOTNNMWlN?=
 =?utf-8?B?eGtpemRZYlpIZ0Z5L3I3eXVhL1VSZzBOMy80R1FBWWQ2L3o1SU9iSVpsWDh4?=
 =?utf-8?B?RDVDb2V5L0xNK3lUbnJXL1JPa3ZVN0VOMjZjSmhPYWxGdVEwZkF6WWU5WWF4?=
 =?utf-8?B?UUFlSFhKM3g1SGpiQStVdmx6UFN6Y1NONllxOXcrTXp0Sm44dEw1Tjg2ZHFk?=
 =?utf-8?B?YzMzVEMxeW11VGVDaDNyYU1oN21LWjZudHpyUTByVExLakN1bmJlaUJvazBh?=
 =?utf-8?B?amRVOVhGUDdnUmpSNk5NRENFOCtaaktFVDZXbGhrdWZPS0pLL0o3ZStqaGVz?=
 =?utf-8?B?N21KQVBvUFk1WGJVaFRaTmpJZ2ZXRkpRUFFxSkdpU1RZbGVjWk4zbFFPQldh?=
 =?utf-8?B?L3ZZRFZ0S2NsQ1ZCcFArcjVsa3FpVVRyVnJiSnNmcUlYTHNFV3JCb1BjbEkz?=
 =?utf-8?B?cWJxejhnREFsbFQrV0Jmd2ZXNjZwNm5tQUVrcFFvQ3JPN2xrK1c3MVRMQ0hs?=
 =?utf-8?B?OFV2N3dEM2RsUlZCQitrSlNIcGlRN2llVFp4RkdseVNmZ2liTndxNmN5aUdw?=
 =?utf-8?B?Rk1pc0RmV2d1NEsvMUxyeTg0OEtwOHlCUUpiYkJScmxpVnBSL3U1aGhaR0NU?=
 =?utf-8?B?QzZzY0FSZ1RvYlBqV2VORkQ4ZmhzNFRKQ2h5UTVHUjJzS0hRVVFqSC9IZVMr?=
 =?utf-8?B?bWRFd25mNzBqTWRJVUs1Z1BOL0o3djVQbXArWlA1ZStHcGp0aEQ0Mnh5MUxY?=
 =?utf-8?B?ZlBpQytzOWRDNjFNQ3Y4Vy9KTEQ2RDVpNXRHcVB0eHM1SldSc2tES3M0Y3p5?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48816454E4666F45BC68C7F3799981DC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06c2fb6-2379-4f1e-0eb3-08dae4b83407
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 07:35:02.4183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2ZpZEbtL9L+ZaJy/O0j+bu7yCltnyZ+WwkqFwIboTF69iaS0DeWqeeDS5q5cDLTQ635Gid9UIKkbW31aK1iX65lWYCKo07Xdn71anpBbZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTI3IGF0IDEwOjIxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjQvMTAvMjIgMTE6NDIsIEdhcm1pbi5DaGFuZyBoYSBzY3JpdHRv
Og0KPiA+IEFkZCBNVDgxODggYXBtaXhlZHN5cyBjbG9jayBjb250cm9sbGVyIHdoaWNoIHByb3Zp
ZGVzIFBsbHMNCj4gPiBnZW5lcmF0ZWQgZnJvbSBTb0MgMjZtIGFuZCBzc3VzYiBjbG9jayBnYXRl
IGNvbnRyb2wuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogR2FybWluLkNoYW5nIDxHYXJtaW4u
Q2hhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IENoYW5nZS1JZDogSTNiMWI0NDE1NWNjNWJmZTViYTZl
ODYwZGU4NTdlN2U5ZjQ4YjY2YTcNCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvY2xrL21lZGlhdGVr
L0tjb25maWcgICAgICAgICAgICAgICAgIHwgIDExICsrDQo+ID4gICBkcml2ZXJzL2Nsay9tZWRp
YXRlay9NYWtlZmlsZSAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gICBkcml2ZXJzL2Nsay9t
ZWRpYXRlay9jbGstbXQ4MTg4LWFwbWl4ZWRzeXMuYyB8IDE1Mw0KPiA+ICsrKysrKysrKysrKysr
KysrKysNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTY1IGluc2VydGlvbnMoKykNCj4gPiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LWFwbWl4ZWRz
eXMuYw0KPiA+IA0KPiANCj4gLi5zbmlwLi4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y2xrL21lZGlhdGVrL2Nsay1tdDgxODgtYXBtaXhlZHN5cy5jDQo+ID4gYi9kcml2ZXJzL2Nsay9t
ZWRpYXRlay9jbGstbXQ4MTg4LWFwbWl4ZWRzeXMuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5mMDllMTFkMDI2MWUNCj4gPiAtLS0gL2Rldi9udWxs
DQo+ID4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OC1hcG1peGVkc3lzLmMN
Cj4gDQo+IC4uc25pcC4uDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIGludCBjbGtfbXQ4MTg4X2Fw
bWl4ZWRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiArew0KPiA+ICsJ
c3RydWN0IGNsa19od19vbmVjZWxsX2RhdGEgKmNsa19kYXRhOw0KPiA+ICsJc3RydWN0IGRldmlj
ZV9ub2RlICpub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+ID4gKwlpbnQgcjsNCj4gPiArDQo+
ID4gKwljbGtfZGF0YSA9IG10a19hbGxvY19jbGtfZGF0YShDTEtfQVBNSVhFRF9OUl9DTEspOw0K
PiA+ICsJaWYgKCFjbGtfZGF0YSkNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4g
KwlyID0gbXRrX2Nsa19yZWdpc3Rlcl9wbGxzKG5vZGUsIHBsbHMsIEFSUkFZX1NJWkUocGxscyks
DQo+ID4gY2xrX2RhdGEpOw0KPiA+ICsJaWYgKHIpDQo+ID4gKwkJZ290byBmcmVlX2FwbWl4ZWRf
ZGF0YTsNCj4gPiArDQo+ID4gKwlyID0gbXRrX2Nsa19yZWdpc3Rlcl9nYXRlcyhub2RlLCBhcG1p
eGVkX2Nsa3MsDQo+ID4gQVJSQVlfU0laRShhcG1peGVkX2Nsa3MpLCBjbGtfZGF0YSk7DQo+IA0K
PiBQbGVhc2UgdXNlIG10a19jbGtfcmVnaXN0ZXJfZ2F0ZXNfd2l0aF9kZXYoKS4NCj4gDQo+IFJl
Z2FyZHMsDQo+IEFuZ2Vsbw0KDQoNCiAgT2ssIEkgd2lsbCB1c2UgbXRrX2Nsa19yZWdpc3Rlcl9n
YXRlc193aXRoX2RldigpIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCj4gVGhhbmtzLA0KPiBCZXN0
IFJlZ2FyZHMsDQo+IEdhcm1pbg0K
