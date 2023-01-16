Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F9766B582
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 03:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjAPCMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 21:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjAPCMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 21:12:53 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609315277;
        Sun, 15 Jan 2023 18:12:46 -0800 (PST)
X-UUID: 40c50a28954311ed945fc101203acc17-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8kaaHiyziYZm1tytxienoNakF89AEq6CFsGqOPzqrn0=;
        b=AMpDY4n+Re1XTjOfvCds6R5eua6GXyqQysL+NioVG5Yvq5DVPUj2OFZtLNfO2mLEyTnaTZR2pJdL2yoA8KxYWLE3PRexrr5uRqfpjLVzei9sTFk9xKus2F0cjjBOdNw5VywYPJFWz/aq+pZ37hun1LNAng/AadeFcewH87rEaNc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:027effd0-ec3e-44fd-8ae4-55ca5fc2dffe,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:f205e2f5-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 40c50a28954311ed945fc101203acc17-20230116
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1994513398; Mon, 16 Jan 2023 10:12:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 16 Jan 2023 10:12:39 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 16 Jan 2023 10:12:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLtiDfdpDuORFd0sjtw8DvAoY5jbP/KeM1CPpzjAyQLNL88kcWwjaxfDWICAz5Ay1OKil/p1G0fIJzlp8F5bXvHHeQDE+f7XX9DfZGR4JPtTvTNFnfQzhzSHz7I031WRI3KyyRdK08Kd6FQwlf3DPgj593L55sL/xdivDWrtzWOYu9mgmXw703vFKIQnmUoZwCo9zEDpC13X5BREf3Ymxa+N3jT3mJVRBumFOay2u8CW09FwyrTmbkA72B3YwJ7V+wGDoQQF/A4Mgpvekw7Uiap5pCb29osGIAbcbrx0i8wZJY2RxxrXtzXKf9y6ht+JOTvKxhZhzHyf9g1J63/kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kaaHiyziYZm1tytxienoNakF89AEq6CFsGqOPzqrn0=;
 b=YVIgMDgWe4SCypuZOoTRlNaN03QCWbjLq5hD7PuhVePY29HGoHTUm1AIm1yEtD8ildA/d3kDvOKx5q1pOcZevpquAG4qlsG9KH74nr3MCW7FSCFy6mpyXZMIIk0eQiyqrpweIqLAVHDn5fqKhuhHZ/sC9mhPhcLJ6Q7d2m141IrvMNEwgoNWuzFgCZ/hvT7GnH3/iXay5FE0yZJjXlaMdejt29o10V6UlSjvCWOjofMqDqA+Wj3t6X3Wax1WfcswyEjpw3z44wSEqBw7XVUG7xiswXkaSteSqNIaLeposhnnMj9edBokBJ5WOdNjsGGN6suPMFveQQpTdHhHXh7GcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kaaHiyziYZm1tytxienoNakF89AEq6CFsGqOPzqrn0=;
 b=eavbUA6PL93jPrTEry2E2b8hrdFz6C3x8gUDCpT+ByEPKOefoMG4iSbXBiV9XEpnnq417+41Ec9X0w2HLyHjNkPfzRQtqHCwfoC/WRNb0fvGfj+gFZdTs3Iyv6iXvw3MrHeX2QH9eqwmwbiDT6Sas1gJXw5c3ixYcV7iQTy4dVo=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by KL1PR03MB7149.apcprd03.prod.outlook.com (2603:1096:820:ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Mon, 16 Jan
 2023 02:12:37 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d%4]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 02:12:36 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v3 01/13] dt-binding: mediatek: add bindings for MediaTek
 mt8195 MDP3 components
Thread-Topic: [PATCH v3 01/13] dt-binding: mediatek: add bindings for MediaTek
 mt8195 MDP3 components
Thread-Index: AQHZJy3mq3vQGKAM1kygTsqqqmen2K6cI9iAgAQty4A=
Date:   Mon, 16 Jan 2023 02:12:36 +0000
Message-ID: <3f0d145bc118335dff717947b21bd99678815f06.camel@mediatek.com>
References: <20230113090321.25128-1-moudy.ho@mediatek.com>
         <20230113090321.25128-2-moudy.ho@mediatek.com>
         <656ab366-05c9-64fa-651b-12597251d116@kernel.org>
In-Reply-To: <656ab366-05c9-64fa-651b-12597251d116@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|KL1PR03MB7149:EE_
x-ms-office365-filtering-correlation-id: 25fdc9c0-36bc-429f-8c21-08daf76722e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UWz8bLiuzJAe7oxgf/kTcCNW6hOgB96FVxpi7Sc4mxe6V6SbpFytzCT3woDNOPamNCKhFWZ1Zlwjvb6bYogO4pZTO1X0EJ9fc8nNq5AsTxHDr9ngWfPEbn61Ky8FO+TwVprAKRa0t8m4fPEAzwSbQFx5qnza14nfkqaAM6vKm7G/zRTi1qsK31jmxHNs+f7+ELWDROJmstukscSehdNhLUNh3EmDII0+w8sNFo7YR2rHSBmdTSV1W0bzO9NlsJPveY5n2FM6IK/AO4qmmNJvKFTKZdE85pJG3NPfX7iwQi8oQIgDGKi2twS33so+xFn8tNX5PkMi7OzjuD37orGCVVBq6yX+ILO096sG3oGxYwPI3YMW6PwFRUrZMWJBVI9S4Mv3e1wdDxKbnYgCb6+0dqDPjHIeBs3sofxmxT22zi195PSzpzD5CfgyWxzi99a62WV5B8ZVl3kRJfVZYpy8yi1ukwDXRvrLpC4//qhsNg+TVMrf52k4YfM8nLdyjivtZm5ZnLPpolxn6tkoDGSM2tECdWceSqhWIxFm8A+Ihry4XfyBImJGn/dV/ZCpMvs7d0OoxbsDDiLDpmDtF4ewKpAGDiIs2m6eJxS0FefjA6fNmwqLZinlbvJIoiG5F3pubyfx/1SV16iyTQ7/OGVrPW5UuwtaYh1+McDrXtgoCEnOE1CupvS2CrSBbXjuyl/CEVNG3f2w89mXkS5ySBCPtfonYktgWV67uzXBqMzn52Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(85182001)(36756003)(38070700005)(316002)(54906003)(110136005)(86362001)(53546011)(478600001)(107886003)(6486002)(8676002)(2906002)(66446008)(66476007)(4744005)(5660300002)(66556008)(4326008)(76116006)(41300700001)(66946007)(91956017)(71200400001)(8936002)(64756008)(38100700002)(122000001)(186003)(6512007)(6506007)(83380400001)(26005)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFo3c2ZpVHNkazk5VjJrczQvNmgxb2YwV3doQzlBY1VNMVI2RmlUTEdPOE5r?=
 =?utf-8?B?aFhReGZ0Zy8wOGE3cHNVdXZ6L3FqNWhlS2tCZ0VzV0pGeVFFYWh1MXVSK010?=
 =?utf-8?B?SFMzUENHOGpkQkFxRWU5VEJaREQxSmFkSitTRXZrY012WVAyelFYNDBIeitQ?=
 =?utf-8?B?NGJXVklBM0g1K2sveStOYmdHT1gxUVRGRElyZy9XMkFXTndVdkRDaEE4Q05t?=
 =?utf-8?B?WVpZeHVua1RFMFZtQjMwa1UwMk43blhLWkp4U2dNOWRFc0UyVWdTTzBDTWZD?=
 =?utf-8?B?RmpwMWhZb3h3a0MyeXF4VU1kZVdOVmhua2UrVWdQV0hRWjZRVGUyQVNRaEdL?=
 =?utf-8?B?a3UwT1lNMjNIaklJM3NPSXhhdXBQMFJyUFk5VGY3YUMrY3g0RU1Xb0ZleTgr?=
 =?utf-8?B?dGttSmlmVXV6dFlLT3hGbkZ2UzVEQS9uVk9lUVBDUFJjWjVSU0dUQXY5UWVs?=
 =?utf-8?B?S0wyRUtmenh2aHE5TE53ekRNNkRaUDBFWUhLNEZNQnFtT3FvZWVVWkM1Smlp?=
 =?utf-8?B?R0xTNy9lam1iVUpuemdxejZmQ2Y4WnlwK0pSRk56NG9PUlJVOFZTZHZscDRw?=
 =?utf-8?B?Slh4aENRQ28rVk5CWm1rUk9kTzdSUFdPc1lPUUI4TXVaMmJyeU02eDZJMlVL?=
 =?utf-8?B?ZC9VRHcrVEVMZTl2bHplSy9xaFViTnRIYnM4UWZsYXEwZVRDcGJkeFpLQXJU?=
 =?utf-8?B?QWRWQVpicmdWdm4rR0EvTmFiek4yZ28vbXd0dVQzelNEam9DOExOZkJKMnpO?=
 =?utf-8?B?enZNYkpQaGZzeThkdWVOL2U5YUkwU3lFQmZ6ZE9NcDdMckxINXRCaVNWb0Iz?=
 =?utf-8?B?VUordlI3WVJmcjh4cWZSL2NWZkprbGlOdzNjVmNBUSs0QWJFQUhUZzNmUzB2?=
 =?utf-8?B?cExqM1N1amZXMmEwbk5CMEFBMjA3ZE5iZUo5NFRiOC9zQytDelhYekNxbENO?=
 =?utf-8?B?bFVJdXlCRDcyUWl1eno1RDhvVDZETWlnc3BPSE9tVll3a3Z2YVNrS2ZRUGkz?=
 =?utf-8?B?VnRzSTBlbkFvZWFDUS90VDlWTFdVcUF4V3lDUC92czlVaFh5blV1VzZSMmxY?=
 =?utf-8?B?VFVvMUt2RC9VQ2hWcDhBWUtBejJ6U3RNWnIyMTdhQm0ydGdRNGtWMURMcmFD?=
 =?utf-8?B?UFpCbm9kUVhmZGJYM2ZGdHJmOWR0SzNjTkljVy9CMHg2TTFTakR6Z1RJRUs4?=
 =?utf-8?B?Mk9xZUx5Z3pBQkZHNUttWVdqSE9Wa0pRWnpiR25aY00wMGM1ZStFaEJFVHRE?=
 =?utf-8?B?TytXbWVzbmkrK1FtYjVyb05wU0cyTDlRQWNkRXhoUnVnSDBKQ0hLMjFBNWV6?=
 =?utf-8?B?KzF6V1dYNThkaFVjc0RES0F0OUR1NG1KTzkrQmtkMXFDS083eitveHRPdFlr?=
 =?utf-8?B?SW9HYVF1Rzh6aWdOY0NpQ0R3NVpGdzdyU0JsK2Qwb2lVYnNubHk0bVdPeFNO?=
 =?utf-8?B?WloyUVpMb3Z0MzAwYklEbTRIUmRwWVU3MXRhdlNFWElBbzZEcklhTXQ4WGEz?=
 =?utf-8?B?NWVXblY1bDFnRS8xQmVzWXU4MEczdk5leW5qbTljTE9QSGs1NmIvQjB5WUhm?=
 =?utf-8?B?d3d2d1kyb240TmZlMTMyZmg5SmtraXMzcVpONUpnZ1RlZ0UvMWhPUjBsaThj?=
 =?utf-8?B?TzR4ak1kQ0FmcTVlczd5dHByMExDL1ZTMEluVGVGODJLMVA5KytYM2s2dmZG?=
 =?utf-8?B?L1Jma2dnQWN6c1FRMGZEdndBc1RjQzQ0Tzg1UFJudW5STW1WNDEwdzl2ZktH?=
 =?utf-8?B?TVErQmNhdUlEc0k3dUVaVzJER1FMblJjSWVJdEpIdkRlbG1LRVdYSHVPcjht?=
 =?utf-8?B?dDFxTitPSS9wb3hiRm1reWNZNHhxZ1ExTDNvT2pteEJ5UkZKL1RRV05ZUnF5?=
 =?utf-8?B?UXhRMUlWMDRzSXpOOW04d1ZhK3JLWWx2QnJVUkZCNysyc2JnbURDSDEvYitO?=
 =?utf-8?B?dmZ2MDcrZFRVYkErUUhHMDFKVUVsNnhXVzZKK1cxWE1aQ25SUS9XZVNLMzdi?=
 =?utf-8?B?M1dOdWs4MldQUTBNTVFuZCt0RjdnRFV0TUNkY2tvTWJrM2R0QmFtM2tVQXp1?=
 =?utf-8?B?YmtQb3hxSGxaS0FPYzJERkRGQ25LOWdWM1NxOWREWnJTcm5lOStOSUNWTW9a?=
 =?utf-8?B?V25KN3NqaWNUWE1weDNIZmxXYlQvUDBPRklPeENTK2xHWC9hRUEzUmllK2ZV?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8DAB09C8C205746A00F9C3F8E66ABA4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fdc9c0-36bc-429f-8c21-08daf76722e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 02:12:36.5235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yE486cVxnmcE+KlQOMkmsWAUWSOf4QwZOzb4tgsedMSdBMOZaPUSnjl+/en7RkTsdR2+l2luDdFCYmqhQzj/3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7149
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTEzIGF0IDExOjIzICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMy8wMS8yMDIzIDEwOjAzLCBNb3VkeSBIbyB3cm90ZToNCj4gPiBUaGlzIHBh
dGNoIGFkZHMgc3VwcG9ydCBmb3IgTVQ4MTk1IE1EUDMgUkRNQSwgYW5kIGludHJvZHVjZSBtb3Jl
DQo+ID4gTURQMyBjb21wb25lbnRzIHByZXNlbnQgaW4gTVQ4MTk1Lg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE1vdWR5IEhvIDxtb3VkeS5ob0BtZWRpYXRlay5jb20+DQo+IA0KPiBQbGVhc2Ug
dXNlIHNjcmlwdHMvZ2V0X21haW50YWluZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2YgbmVjZXNzYXJ5
DQo+IHBlb3BsZQ0KPiBhbmQgbGlzdHMgdG8gQ0MuICBJdCBtaWdodCBoYXBwZW4sIHRoYXQgY29t
bWFuZCB3aGVuIHJ1biBvbiBhbiBvbGRlcg0KPiBrZXJuZWwsIGdpdmVzIHlvdSBvdXRkYXRlZCBl
bnRyaWVzLiAgVGhlcmVmb3JlIHBsZWFzZSBiZSBzdXJlIHlvdQ0KPiBiYXNlDQo+IHlvdXIgcGF0
Y2hlcyBvbiByZWNlbnQgTGludXgga2VybmVsLg0KPiANCj4gWW91IG1pc3NlZCBzZXZlcmFsIGVu
dHJpZXMsIHNvIHBsZWFzZSByZXNlbmQuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0KPiANCg0KSGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZW1pbmRlciwgSSdsbCBy
dW4gdGhlIHNjcmlwdCB0byBnZXQgdGhlIGNvcnJlY3QgbGlzdA0KYW5kIHJlc2VuZC4NCg0KU2lu
Y2VyZWx5LA0KTW91ZHkNCg==
