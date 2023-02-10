Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9ED6918BF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjBJGwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjBJGv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:51:56 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC21D92F;
        Thu,  9 Feb 2023 22:51:53 -0800 (PST)
X-UUID: 63d752e8a90f11eda06fc9ecc4dadd91-20230210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QC7iNAbMnFn99/SiiWGzHuZZVEj2/TpXk8XgMkt/9UA=;
        b=a2b1fr1uctsVFtUtsmJg6tSGK7ryHJ8bm7HOugAtSloRjPB31F6cktLRcYCw5B43EFK60Uv0CE0Urb1n82VImRMGQ19FbHbHP+dJpRO7QyQCCdmcJLSOY9Y00Hoy9sWVmTokairJvrmsl4FGAurz8g1mjjHoVveL+1rHRBxArfI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:76e0957d-10ae-4e6d-89cf-49be7fb21694,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:4c250bf8-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 63d752e8a90f11eda06fc9ecc4dadd91-20230210
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 479604770; Fri, 10 Feb 2023 14:51:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 10 Feb 2023 14:51:47 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 10 Feb 2023 14:51:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHS+4PlCJlAWp5vlK4frxs0xTkHyeYJkhUHLBGBS4SsFrXtjFdjVVqibKIq2SVEyZjPGPd65EpZqGmcvqLxsiiWl5id2KkFqRhs4JgfrY3LTUav2vSp2gtDkiN9r9Exwjzto6FJ0xLEWiMuKxat7gcmOWDYonK5gkCpABKQOe8pR11Jml8MTWN7ec0l9TL+ZjWXtsBSIJQV+ZILQp8Rge6Yah+oCmKDHurTeuXgVH51i+S42UTqDL5lWKIAd4DpRbXixq7qFCUgeu1m1KWcnqqQ9uAV7IF4mVPx+FxDr6QdsTP80HrlwatubOHHeGaruaADfrBnzvadrdRZUlztPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QC7iNAbMnFn99/SiiWGzHuZZVEj2/TpXk8XgMkt/9UA=;
 b=CGmegMrDJEqj0tXT0pz+COIOpdi6/kA+aF/pOuU11gQqOPvjelDGWpqzwzMCT/28owlgTyQPnhD7rwFl0l0qX6oYhBaiBSWQPWGIveA1mQe8QNOZ/lkylwrmW/5p/yvWkB5rjh4mO4IyhDmCYdZ2DPy/XxlerAewBG0+fJ6vEYIVfeYjtkvLlpGwQk6ZkpgvdnnPzcTwQL2sHr0T1vKSp7gW3o6lzKzfN/fP6B7R7f5m0Pw3Y8dE3ScP2gsiUlrKvVBi3HrvDLpqvdDvyXchSz9/HxUWI3x8ySVvdwTmWnTqJxqk7sQxk6LfN/xPNdtVy8nWqUBqe0YQv3taM/NK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC7iNAbMnFn99/SiiWGzHuZZVEj2/TpXk8XgMkt/9UA=;
 b=cnZJKbgQDNCOPyYr6gKotU8TDqxuxa/kU4A9uZ/j4DMx4yuKA5AOqz6YxXModJuJj6cMRhuqc1uQ6SErIZUFmi24f01JVGGKn5G2/Rtjxt9xhtyz3yYF4rJI4xDhMOD1JwJ7wCFfUmQKj4y6vC0rcCrQi4Bnb2xzIoWkUX+sIn0=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by PSAPR03MB5494.apcprd03.prod.outlook.com (2603:1096:301:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Fri, 10 Feb
 2023 06:51:45 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::ba47:a392:dffd:355f]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::ba47:a392:dffd:355f%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 06:51:44 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 03/16] dt-binding: mediatek: add MediaTek mt8195 MDP3
 components
Thread-Topic: [PATCH v4 03/16] dt-binding: mediatek: add MediaTek mt8195 MDP3
 components
Thread-Index: AQHZO57lmM4h1tCFKU+9Gh0vqzfCUa7G6c6AgADXOYA=
Date:   Fri, 10 Feb 2023 06:51:44 +0000
Message-ID: <c205d9aac2a5320c3225bcd5ab44b6b70d3075b5.camel@mediatek.com>
References: <20230208092209.19472-1-moudy.ho@mediatek.com>
         <20230208092209.19472-4-moudy.ho@mediatek.com>
         <20230209180125.GA557423-robh@kernel.org>
In-Reply-To: <20230209180125.GA557423-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|PSAPR03MB5494:EE_
x-ms-office365-filtering-correlation-id: 6469f86f-fafe-4d1e-67fb-08db0b3345d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNROaLGNA3zab4+vt4v5DwuVGRsKTogNdH9xrpEkX/bR6tUFUdBTJJahssOWlmu5vPDK0Zzi7csaakDcHQ5GhjYA6SSy9lyEs1YilHOwfI8AENjXBCHneeUA+I/8oMKlINfMBYtqF/NEFi7qGeaRRxzqNFGXaGshwZovVDkKBzVk7ZJEvC0kAbeVLeq8WPoipSgFXeRyA6TQihdwESuPhXuaxS/0rjKF30+mjhv1MS8z2ND1ixgKMISlx7aDQZDqHP0ndK12o0+uARK6YQOy95mxUEXWwGUN6qI5VUOXm4NwtcG7geLZgEKu5g6neN8qO+FZBPFcgZhxnP5MMyWbwrHzOaDjDIM3zE/CPmyWm7F1zjBo/tfMBceVfgpmzn/xFmmB7mQpQduolgjqiDb+gy6xVsSjFMeOwT3QGxohbE41ctrszstHiQBH2b06a2l93KN16Yo4jHV6GwGogyolFwGqfMGBzn9RVcBWYDu3/RChoRCyEs9DQas3XwY0vaC1PybOIzqW02aOejGeT76qBZTgGB/2TLbKjLqJj1/zIRKVJMj3FMIWsppqzvhYZh0oFp5FvIuLltutvnrulm/YZf1zr/yBNmOCy2vGe3ENOvRf806prL5eKCdmLbrPSe0TayVZba7zmphk4ZQHAxOJjEF6CRioVbOmUZJ8v6COSslRR+ucVoaeqmIrLEh7Cl6v9ZbDEhy9td2h574gyXlkuCnG1HRCVEV3OoFiZQNlqPXWd524qXjsTvMGXh+bbMrdEf8e5R9gplxWy+TadH7hscfYcu/E6+04HRRlXrUrRHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199018)(86362001)(2616005)(6506007)(478600001)(85182001)(71200400001)(6486002)(36756003)(83380400001)(4326008)(41300700001)(186003)(54906003)(316002)(6512007)(26005)(6916009)(64756008)(8936002)(66946007)(8676002)(91956017)(66476007)(76116006)(66556008)(5660300002)(2906002)(966005)(38070700005)(66446008)(38100700002)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVB1ZEdVWGpvNUpqZXY5SHdXRXp4cmVaeW9yMmR4MmF1cElqWXFPOU9WNWNT?=
 =?utf-8?B?VWM4eG5zdUJuSExvODR2Q3crb2dubnVEUnlJVWxNbjlROU9WZ2dWRUYveE5Z?=
 =?utf-8?B?WXN5MkpBVzdqQmV3Mm0yNGZoS2ZxQ1lPMjR2QXYyNDl6VUpYMTQwbk9Tc20z?=
 =?utf-8?B?SnJXQ1NPWHltN1hWd2taVmdJenlONjRPbkxJR1N5OXB0czF4Y0FZd2krRFd2?=
 =?utf-8?B?RTkyS00vaTNWRzdJVXErY2VSZkNmK2ttZjZsVzNEQlFSNmJhZW9CNUI4dEF6?=
 =?utf-8?B?aUdpaWI3M1o2TmJRSVFvdEdFaEpBVWlKS3NrUjhlQ0tBSS9taXpXNEh2UzJl?=
 =?utf-8?B?d3VKZzUxcC9XcFdWdXNGNXJFZDUrVFFYc3pSWWV0M2twMmpUc0pBaFdBNDd6?=
 =?utf-8?B?TEJ3RUVyeGdWK1c4OGM0QXZ3VUpKYkxTQVFvdzBBbUpjODhxOFFEeGNiUlRT?=
 =?utf-8?B?SU9hSWxOM09hWFBBeFdIOTEzRDVtVXpkMEVrSzVzbGFaTVJQUDJYeWdRZDlD?=
 =?utf-8?B?MkVJOTFyVmFiV0tqeVNPc2l5dHRoRGhzdVFabDZmTVdPUjMwUUUrN3NMTXE2?=
 =?utf-8?B?eEN3VkRhbHNaT1pyZXVKdk5oQzIvUFpSY2FVb2Y3MGtNcUU1SHlpbHI3aVFU?=
 =?utf-8?B?L2ZTaVFxeDBoQ3M2MlJkazRUZThjSlZNcnZ4MEd2MmxWbkhWcXdKZjJqRkhC?=
 =?utf-8?B?bjA0K2l6bklSb1NxVVZ4MlZ1TmxzM0daS2VSdE8zOS9zdHJRRHUxTXJ0OXNJ?=
 =?utf-8?B?UnJPZzlQSmFvcVdzWmtwYkc3SmRRaTg4TkdTKzd6ZXlWZTVkOGxIRUdRem9Q?=
 =?utf-8?B?cHJ5MUNZckNzOHNnY0IzOGs4emdicXU4SDJ4UWE4U0hUNk9JeCt1bVpOS2hh?=
 =?utf-8?B?L2x0Tlp6YkYva1JrS1EwanFhRU1vY1Ard1V3dUlRQllYdEtick0zK2tlNzFv?=
 =?utf-8?B?cTErKzhBMnFMS3dmTkdLRlVwSDZXaVJMMnZjWjVLajlqR245NFY4NWRhRUlt?=
 =?utf-8?B?a0xsNTUyK0swcEVUWkxZN0VwTTdZc3V1WjF4VFRzT1N5Q1hhYVVNT01lTmI4?=
 =?utf-8?B?WWVMaHNNa240K0laWTQydGxGZUdMNWt5QmZJczlGTU4vK1Y2SEl5UHN5TEh0?=
 =?utf-8?B?UzZWOVMyU3NiWmdDbVFNS2gyeEV1QmZ6OUJ2Zy9IM3Z5M0V6YWgwZ0FlRkRJ?=
 =?utf-8?B?RGpKSmdOeUxNM2tpajlMRWh5WFZnUTNYSE1rd1NhYjViRE5WeEdKZGg1L1FM?=
 =?utf-8?B?aDlJSkkzeFF6YnF5SlJXYkRyM214YllrdlpqNUd3bWFFS0pXNjBHQmFlY0Jz?=
 =?utf-8?B?czl0UTBnVzZ5QnNvVWlwWWp3ckJrc0dGQVlLSEN1UHE4TnZDRDczVStnQ0c3?=
 =?utf-8?B?UlNkTW5vajVlOXh2NHYvNWs0UldLVk81aDVvZUczOWVmRkRKMzF6S29pRVc3?=
 =?utf-8?B?YUVVby9QMjUvYU8yQzRJS0pKTmpCVFVxdU5VejdmbGV1OVlhbFpyTVJFMDhM?=
 =?utf-8?B?OC92QzhZd3QxVDNrcGRSMGN1alFiNTZldmdJcmFDVTc3bXRLaGJGdGtPa2lZ?=
 =?utf-8?B?V0h0SEwrU000MHVpUDNLVVBESHdwSTB4Q3JWa1BORUJ6WWFqYVMxVGIvUmJL?=
 =?utf-8?B?emNxYnRtUEQ3N1VHR2tJVGJqbGdPbTI1eDVBSUdlMkhDMmpLemdqaDhYSU5S?=
 =?utf-8?B?NFZyVzJqWWJRWXVmOTc0WnRKMGdrODNpOTNJMThaYmEwNFpJZ1FNdVFXbHo2?=
 =?utf-8?B?Z2h1ZWgvTzVJeFdmY3JPeHdFbTN6b1p0RXVNSUpodVJNbWpRL3RYVWUvZFlx?=
 =?utf-8?B?MWFsY0xvZVJ6czV2RHhJK09rOG9DSHZSSHhMaEozQTBGQ2sxUTNHUHBMZzdK?=
 =?utf-8?B?V2h2czZTeFV1S1BpaWpjYit4RmpCVy8yU3p6V3dqcW1XSktoVDBZOUNOWEJp?=
 =?utf-8?B?MnpTc2xZK3ZqV3RCR2M3WWQ1TjAyVE1qc2VBL09mdE1JWTZaNURjOGJBamk4?=
 =?utf-8?B?d3Qwdm13SW9SUzNqTlVhbmhiclh4OGRuWGhva3dKcU1jYzYwOGo0VUo3QlBw?=
 =?utf-8?B?bjJ2cnRVNS9sOHZ0YUJTb3hCd09nc1Bqc0h2UEZYbmVEWm9iRGZaei8yT01C?=
 =?utf-8?B?UkJWOGFGem1TdEhNbXZwSVBhT3RVVThLeDB6RkIrdDFQTzA1MXRlWFRFdmxU?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFB2BE0C75B24246A516B30E0224C492@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6469f86f-fafe-4d1e-67fb-08db0b3345d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 06:51:44.5349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ojaZP0OckOif8Bec67jYOG4qDzKJTFCYm6TubdJgnAOo4HnLxV9ywIz94SInjp1bQZFUW1Z2/W0TD4UuQy8ceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5494
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

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHRha2luZyB0aGUgdGltZSB0byByZXZpZXcgdGhvc2UgYmlu
ZGluZ3MuDQoNCk9uIFRodSwgMjAyMy0wMi0wOSBhdCAxMjowMSAtMDYwMCwgUm9iIEhlcnJpbmcg
d3JvdGU6DQo+IE9uIFdlZCwgRmViIDA4LCAyMDIzIGF0IDA1OjIxOjU2UE0gKzA4MDAsIE1vdWR5
IEhvIHdyb3RlOg0KPiA+IEFkZHMgc3VwcG9ydCBmb3IgTVQ4MTk1IE1EUDMgUkRNQSwgYW5kIGlu
dHJvZHVjZSBtb3JlIE1EUDMNCj4gPiBjb21wb25lbnRzDQo+ID4gcHJlc2VudCBpbiBNVDgxOTUu
DQo+IA0KPiBJJ20gc3VyZSBJIGFza2VkIHRoaXMgYmVmb3JlLCBidXQgaG93IGFyZSB0aGVzZSBi
bG9ja3MgZGlmZmVyZW50DQo+IGZyb20gDQo+IHdoYXQgd2UgYWxyZWFkeSBoYXZlIGluIGJpbmRp
bmdzL2Rpc3BsYXkvbWVkaWF0ZWsvLiBJdCdzIGFsbCB0aGUNCj4gc2FtZSANCj4gYmxvY2sgbmFt
ZXMuIElmIHRoZXkgYXJlIHRoZSBzYW1lL3NpbWlsYXIgaC93LCB0aGVuIGl0IHNob3VsZCBiZSAx
IA0KPiBiaW5kaW5nIGV2ZW4gaWYgeW91IGhhdmUgZGlmZmVyZW50IGNvbnN1bWVycyBpbiB0aGUg
a2VybmVsLg0KPiANCj4gSWYgbXkgcXVlc3Rpb25zIGFyZW4ndCBhbnN3ZXJlZCBpbiB0aGUgcGF0
Y2hlcywgdGhlbiBJJ2xsIGp1c3Qga2VlcCANCj4gYXNraW5nIGJlY2F1c2UgSSB3b24ndCByZW1l
bWJlci4uLg0KPiANCg0KQXMgeW91IG1lbnRpb25lZCwgc29tZSBibG9ja3MgYXJlIGluZGVlZCB0
aGUgc2FtZSBhcyB0aG9zZSB1bmRlciBwYXRoDQoiYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlayIs
IHRoZSBkaWZmZXJlbmNlIGlzIG9ubHkgaW4gdGhlIHdheSBvZg0Kb3BlcmF0aW9uLg0KDQoxLiBC
eSByZW1vdmUgdGhlIHJlcXVpcmVkIHByb3BlcnR5ICJpbnRlcnJ1cHRzIiwgMyBibG9ja3MgY2Fu
IGJlDQptZXJnZWQ6DQogICBtZWRpYXRlayxhYWwueWFtbA0KICAgbWVkaWF0ZWssY29sb3IueWFt
bA0KICAgbWVkaWF0ZWssb3ZsLnlhbWwNCg0KMi4gQnkgYWRkaW5nIG9wdGlvbmFsICJtZWRpYXRl
ayxnY2UtY2xpZW50LXJlZyIgcHJvcGVydHksIHRoZSBmb2xsb3dpbmcNCnR3byBjYW4gYWxzbyBi
ZSBtZXJnZWQ6DQogICBtZWRpYXRlayxtZXJnZS55YW1sDQogICBtZWRpYXRlayxzcGxpdC55YW1s
DQoNCjMuIEJlc2lkZXMsIHRoZXJlIGlzIGEgYmluZGluZyAibWVkaWF0ZWssbWRwLXJkbWEueWFt
bCIgdGhhdCBuZWVkcyB0bw0KYmUgZGlzY3Vzc2VkLCB3aGljaCBpcyBuZXdseSBhZGRlZCBhZnRl
ciB0aGUgUkRNQSBvZiBESVNQL01EUDMuDQogICBJdCBwcmVzZW50cyBpbiBtdDgxOTUgVkRPMSBh
bmQgdXBvbiBpbnNwZWN0aW9uIGl0IGhhcyB0aGUgc2FtZSBoL3cNCmFzIHRoZSBNRFAzIFJETUEu
DQogICBNYXkgSSByZW1vdmUgdGhpcyBmaWxlIGFuZCBsaXN0IGl0IGluICJtZWRpYS9tZWRpYXRl
ayxtZHAzLXJkbWEueWFtbCANCiIgd2l0aCBhbiBlbnVtPw0KDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogTW91ZHkgSG8gPG1vdWR5LmhvQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4u
L2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLG1kcDMtcmRtYS55YW1sICAgIHwgIDMwICstLQ0KPiA+
ICAuLi4vYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssbWRwMy1yc3oueWFtbCAgICAgfCAgIDUgKy0N
Cj4gPiAgLi4uL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLG10ODE5NS1tZHAzLnlhbWwgIHwgMTc0
DQo+ID4gKysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTk3IGluc2Vy
dGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssbXQ4MTk1LW1k
cDMueWFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssbWRwMy0NCj4gPiByZG1hLnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssbWRwMy0NCj4gPiByZG1hLnlh
bWwNCj4gPiBpbmRleCA0NjczMDY4N2M2NjIuLmFiYzMyODRiMjFkMCAxMDA2NDQNCj4gPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssbWRwMy0N
Cj4gPiByZG1hLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWVkaWEvbWVkaWF0ZWssbWRwMy0NCj4gPiByZG1hLnlhbWwNCj4gPiBAQCAtMjAsOCArMjAs
OSBAQCBkZXNjcmlwdGlvbjogfA0KPiA+ICANCj4gPiAgcHJvcGVydGllczoNCj4gPiAgICBjb21w
YXRpYmxlOg0KPiA+IC0gICAgaXRlbXM6DQo+ID4gLSAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10
ODE4My1tZHAzLXJkbWENCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gbWVkaWF0ZWssbXQ4
MTgzLW1kcDMtcmRtYQ0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE5NS1tZHAzLXJkbWENCj4g
PiAgDQo+ID4gICAgcmVnOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPiBAQCAtNDYsMjAgKzQ3
LDI4IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy91aW50MzItYXJyYXkNCj4gPiAgDQo+ID4gICAgcG93ZXItZG9tYWluczoNCj4g
PiAtICAgIG1heEl0ZW1zOiAxDQo+ID4gKyAgICBvbmVPZjoNCj4gPiArICAgICAgLSBpdGVtczoN
Cj4gPiArICAgICAgICAgIC0gZGVzY3JpcHRpb246IGZvciBSRE1BDQo+ID4gKyAgICAgIC0gaXRl
bXM6DQo+ID4gKyAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBmb3IgdnBwc3lzIDANCj4gPiArICAg
ICAgICAgIC0gZGVzY3JpcHRpb246IGZvciB2cHBzeXMgMQ0KPiA+ICANCj4gPiAgICBjbG9ja3M6
DQo+ID4gLSAgICBpdGVtczoNCj4gPiAtICAgICAgLSBkZXNjcmlwdGlvbjogUkRNQSBjbG9jaw0K
PiA+IC0gICAgICAtIGRlc2NyaXB0aW9uOiBSU1ogY2xvY2sNCj4gPiArICAgIG1pbkl0ZW1zOiAy
DQo+ID4gKyAgICBtYXhJdGVtczogMTkNCj4gPiAgDQo+ID4gICAgaW9tbXVzOg0KPiA+IC0gICAg
bWF4SXRlbXM6IDENCj4gPiArICAgIG9uZU9mOg0KPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsg
ICAgICAgICAgLSBkZXNjcmlwdGlvbjogUkRNQSBwb3J0DQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+
ID4gKyAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBSRE1BIHBvcnQNCj4gPiArICAgICAgICAgIC0g
ZGVzY3JpcHRpb246IFJETUEgdG8gV1JPVCBETCBwb3J0DQo+ID4gIA0KPiA+ICAgIG1ib3hlczoN
Cj4gPiAtICAgIGl0ZW1zOg0KPiA+IC0gICAgICAtIGRlc2NyaXB0aW9uOiB1c2VkIGZvciAxc3Qg
ZGF0YSBwaXBlIGZyb20gUkRNQQ0KPiA+IC0gICAgICAtIGRlc2NyaXB0aW9uOiB1c2VkIGZvciAy
bmQgZGF0YSBwaXBlIGZyb20gUkRNQQ0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArICAgIG1h
eEl0ZW1zOiA1DQo+ID4gIA0KPiA+ICAgICcjZG1hLWNlbGxzJzoNCj4gPiAgICAgIGNvbnN0OiAx
DQo+ID4gQEAgLTcyLDcgKzgxLDYgQEAgcmVxdWlyZWQ6DQo+ID4gICAgLSBwb3dlci1kb21haW5z
DQo+ID4gICAgLSBjbG9ja3MNCj4gPiAgICAtIGlvbW11cw0KPiA+IC0gIC0gbWJveGVzDQo+ID4g
ICAgLSAnI2RtYS1jZWxscycNCj4gPiAgDQo+ID4gIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxz
ZQ0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVk
aWEvbWVkaWF0ZWssbWRwMy0NCj4gPiByc3oueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayxtZHAzLQ0KPiA+IHJzei55YW1sDQo+ID4gaW5kZXgg
NzhmOWRlNjE5MmVmLi40YmM1YWMxMTJkMmEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLG1kcDMtDQo+ID4gcnN6LnlhbWwN
Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0
ZWssbWRwMy0NCj4gPiByc3oueWFtbA0KPiA+IEBAIC00MywxMiArNDMsMTUgQEAgcHJvcGVydGll
czoNCj4gPiAgDQo+ID4gICAgY2xvY2tzOg0KPiA+ICAgICAgbWluSXRlbXM6IDENCj4gPiArICAg
IG1heEl0ZW1zOiAyDQo+ID4gKw0KPiA+ICsgIHBvd2VyLWRvbWFpbnM6DQo+ID4gKyAgICBtYXhJ
dGVtczogMQ0KPiA+ICANCj4gPiAgcmVxdWlyZWQ6DQo+ID4gICAgLSBjb21wYXRpYmxlDQo+ID4g
ICAgLSByZWcNCj4gPiAgICAtIG1lZGlhdGVrLGdjZS1jbGllbnQtcmVnDQo+ID4gLSAgLSBtZWRp
YXRlayxnY2UtZXZlbnRzDQo+ID4gICAgLSBjbG9ja3MNCj4gPiAgDQo+ID4gIGFkZGl0aW9uYWxQ
cm9wZXJ0aWVzOiBmYWxzZQ0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayxtdDgxOTUtbWRwMy55YW1sIA0KPiA+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLG10ODE5NS1t
ZHAzLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAw
MC4uZDJiMDE0NTZjNDk1DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayxtdDgxOTUtDQo+ID4gbWRwMy55
YW1sDQo+ID4gQEAgLTAsMCArMSwxNzQgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICst
LS0NCj4gPiArJGlkOiANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2Rl
dmljZXRyZWUub3JnL3NjaGVtYXMvbWVkaWEvbWVkaWF0ZWssbXQ4MTk1LW1kcDMueWFtbCpfXztJ
dyEhQ1RSTktBOXdNZzBBUmJ3IW1PRGU4ZzlNQXhjM2xSWW5pWDFwSkExTXJrZ1o3V01FcUxIRlUt
S25lSG9ES3MwZ3NBR1RPenptRjNMMFNvcV9fX3JQR3JRZmJ1VmZudyTCoA0KPiA+ICANCj4gPiAr
JHNjaGVtYTogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchbU9E
ZThnOU1BeGMzbFJZbmlYMXBKQTFNcmtnWjdXTUVxTEhGVS1LbmVIb0RLczBnc0FHVE96em1GM0ww
U29xX19fclBHclFva2pLZTJRJMKgDQo+ID4gIA0KPiA+ICsNCj4gPiArdGl0bGU6IE1lZGlhVGVr
IE1lZGlhIERhdGEgUGF0aCAzIGRpc3BsYXkgY29tcG9uZW50cw0KPiA+ICsNCj4gPiArbWFpbnRh
aW5lcnM6DQo+ID4gKyAgLSBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29t
Pg0KPiA+ICsgIC0gTW91ZHkgSG8gPG1vdWR5LmhvQG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4g
K2Rlc2NyaXB0aW9uOg0KPiA+ICsgIEEgZ3JvdXAgb2YgZGlzcGxheSBwaXBlbGluZSBjb21wb25l
bnRzIGZvciBpbWFnZSBxdWFsaXR5DQo+ID4gYWRqdXN0bWVudCwNCj4gPiArICBjb2xvciBmb3Jt
YXQgY29udmVyc2lvbiBhbmQgZGF0YSBmbG93IGNvbnRyb2wsIGFuZCB0aGUNCj4gPiBhYmJyZXZp
YXRpb25zDQo+ID4gKyAgYXJlIGV4cGxhaW5lZCBiZWxvdy4NCj4gPiArICBBQUwgICAgLSBBbWJp
ZW50LWxpZ2h0IEFkYXB0aXZlIEx1bWEuDQo+ID4gKyAgQ29sb3IgIC0gRW5oYW5jZSBvciByZWR1
Y2UgY29sb3IgaW4gWS9TL0ggY2hhbm5lbC4NCj4gPiArICBGRyAgICAgLSBGaW1lIEdyYWluIGZv
ciBBVjEgc3BlYy4NCj4gPiArICBIRFIgICAgLSBQZXJmb3JtIEhEUiB0byBTRFIuDQo+ID4gKyAg
TUVSR0UgIC0gVXNlZCB0byBtZXJnZSB0d28gc2xpY2UtcGVyLWxpbmUgaW50byBvbmUgc2lkZS1i
eS1zaWRlLg0KPiA+ICsgIE9WTCAgICAtIFBlcmZvcm0gYWxwaGEgYmxlbmRpbmcuDQo+ID4gKyAg
UEFEICAgIC0gUHJlZGVmaW5lZCBhbHBoYSBvciBjb2xvciB2YWx1ZSBpbnNlcnRpb24uDQo+ID4g
KyAgU1BMSVQgIC0gU3BsaXQgYSBIRE1JIHN0cmVhbSBpbnRvIHR3byBvdXB0dXQuDQo+ID4gKyAg
U1RJVENIIC0gQ29tYmluZSBtdWx0aXBsZSB2aWRlbyBmcmFtZSB3aXRoIG92ZXJsYXBwaW5nIGZp
ZWxkcyBvZg0KPiA+IHZpZXcuDQo+ID4gKyAgVENDICAgIC0gSERSIGdhbW1hIGN1cnZlIGNvbnZl
cnNpb24gc3VwcG9ydC4NCj4gPiArICBURFNIUCAgLSBTaGFycG5lc3MgYW5kIGNvbnRyYXN0IGlt
cHJvdmVtZW50Lg0KPiANCj4gRWFjaCBibG9jayBsaWtlbHkgbmVlZHMgaXRzIG93biBzY2hlbWEu
DQo+IA0KDQpBZnRlciBkZWR1Y3RpbmcgdGhlIGJpbmRpbmdzIHRoYXQgY2FuIGJlIG1lcmdlZCBi
ZWZvcmUsIHRoZSByZW1haW5pbmcNCm9uZXMgd2lsbCBoYXZlIGV4YWN0bHkgdGhlIHNhbWUgYXR0
cmlidXRlcy4gQ2FuIHRob3NlIGJlIHNpbXBsaWZpZWQNCmludG8gb25lIGJpbmRpbmdzIGFzIGRp
c2N1c3NlZCBpbiB0aGUgM3JkIHZlcnNpb24/DQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC1tZWRpYS9wYXRjaC8yMDIzMDExNjAzMjE0Ny4yMzYwNy0yLW1vdWR5
LmhvQG1lZGlhdGVrLmNvbS8NCg0KU2luY2VyZWx5LA0KTW91ZHkNCg0KPiA+ICsNCj4gPiArcHJv
cGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgZW51bToNCj4gPiArICAgICAg
LSBtZWRpYXRlayxtdDgxOTUtbWRwMy1hYWwNCj4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxOTUt
bWRwMy1jb2xvcg0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE5NS1tZHAzLWZnDQo+ID4gKyAg
ICAgIC0gbWVkaWF0ZWssbXQ4MTk1LW1kcDMtaGRyDQo+ID4gKyAgICAgIC0gbWVkaWF0ZWssbXQ4
MTk1LW1kcDMtbWVyZ2UNCj4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxOTUtbWRwMy1vdmwNCj4g
PiArICAgICAgLSBtZWRpYXRlayxtdDgxOTUtbWRwMy1wYWQNCj4gPiArICAgICAgLSBtZWRpYXRl
ayxtdDgxOTUtbWRwMy1zcGxpdA0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE5NS1tZHAzLXN0
aXRjaA0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE5NS1tZHAzLXRjYw0KPiA+ICsgICAgICAt
IG1lZGlhdGVrLG10ODE5NS1tZHAzLXRkc2hwDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAg
IG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIG1lZGlhdGVrLGdjZS1jbGllbnQtcmVnOg0KPiA+
ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJh
eQ0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgIC0gZGVz
Y3JpcHRpb246IHBoYW5kbGUgb2YgR0NFDQo+ID4gKyAgICAgICAgLSBkZXNjcmlwdGlvbjogR0NF
IHN1YnN5cyBpZA0KPiA+ICsgICAgICAgIC0gZGVzY3JpcHRpb246IHJlZ2lzdGVyIG9mZnNldA0K
PiA+ICsgICAgICAgIC0gZGVzY3JpcHRpb246IHJlZ2lzdGVyIHNpemUNCj4gDQo+IEdpdmVuIHRo
ZXNlIG1hdGNoIHVwIHRvIHJlZyB2YWx1ZXMsIEknbSByZWFsbHkgd29uZGVyaW5nIHdoeSB3ZSBo
YXZlIA0KPiB0aGlzLg0KPiANCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBFYWNo
IEdDRSBzdWJzeXMgaWQgaXMgbWFwcGluZyB0byBhIGJhc2UgYWRkcmVzcyBvZiBkaXNwbGF5DQo+
ID4gZnVuY3Rpb24gYmxvY2tzDQo+ID4gKyAgICAgIHJlZ2lzdGVyIHdoaWNoIGlzIGRlZmluZWQg
aW4gPGluY2x1ZGUvZHQtDQo+ID4gYmluZGluZ3MvZ2NlL210ODE5NS1nY2UuaD4uDQo+ID4gKyAg
ICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBtaW5JdGVtczog
MQ0KPiA+ICsgICAgbWF4SXRlbXM6IDcNCj4gDQo+IFlvdSBoYXZlIHRvIGRlZmluZSB3aGF0IGVh
Y2ggY2xvY2sgaXMgd2hpY2ggcHJvYmFibHkgZGVwZW5kcyBvbiBlYWNoIA0KPiBibG9jay4NCj4g
DQo+IFJvYg0K
