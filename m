Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC9A6717DE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjARJf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjARJ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:26:37 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AB7530FC;
        Wed, 18 Jan 2023 00:52:30 -0800 (PST)
X-UUID: 6d3504b6970d11ed945fc101203acc17-20230118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7oWGcqc6umv1n6EjRJx6TZsOAagTABpA6oCSVX0FXK8=;
        b=fNwE3XAaKJVJ2mjEunKkbv4O42ok1lhfP8jlYkbMDvZL9fq8hD4iYffmge4xUxidPA47kr6nXOZsi2IfZXeJvU/r6uN5ap6tUnny1evdD33TrymETIFn0BGEn+K7+KgjmppfQ6HDTJfqRFPYt/1Ao6n11zrRXn3Fv5VWHwF9d84=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:69ebcc0a-64e5-4bd9-a10f-47f3ab4e73b3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:f080ff54-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 6d3504b6970d11ed945fc101203acc17-20230118
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1962576115; Wed, 18 Jan 2023 16:52:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 18 Jan 2023 16:52:22 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 18 Jan 2023 16:52:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3xtajWMJpKIRM/1jhdemGPyHC+Bd3xvp1JyAgEvP9gBBKXSr4uvQLmw6MWPX8H0yKro2IjoepNCRiUqXvh808RXIGUWE5IpmdCYPSAzDZwEv6u77oXv1bZJgZ6zqhd2JYfYZqcNDMzWfukUB0XMdLiCgmULYqXoilveuV2kk45SFNh5y53iAaj4ojAeoSfWiRmjPnN3CdDYQAS5C+f6mTBnV6BHoW3xHVPjwnVveXJaEK6I6k27k07ZI/Vc1KAj8Mn7pwKvJmaX52yQun33xsejNGB3BuGkkZaeLu4+pa16NAc83E8YfQWVBMmrAxUMszNM5E78SMZ0XHvXZXHoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oWGcqc6umv1n6EjRJx6TZsOAagTABpA6oCSVX0FXK8=;
 b=JGoVxj1RwyRmFKLtxepvNe0CUvmpFJcbOjOehHQFx636NMmvFoTokPuIG7DujDJfOfrNaRM2x7XGvcM0btLr8mWI2rgJLMZwGUFWNPbx4/c1xc98m8u7uBj4lIHCahJx+v7REpAzNmZE47ghViz+V/HWrI3vSZx2XNqvHwJcqncDxexG4EaXBEkV//HVM3oDaiFWr9iBdt9wUT/cL4w81AXtQ90llWgOOOU73EJR/YcnBEC5xlaeAhlzCJ6A/2pcr7rIX9XRjHb+oLvVEpdI4Izf0H/n/zQDejZUh4vRnVhyHK3ZlxFTyCDQ5T+RAsH0Uc7YUUP7SGS2gFTEpzZvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oWGcqc6umv1n6EjRJx6TZsOAagTABpA6oCSVX0FXK8=;
 b=V+jG4FPdpwmmS3xW8DH+orfsibE4ElLG6c9myLrjBZm17f3T0+3z2fYGbcWWLMNze/Sm07sGYFd/vfCqgMuczHND7jQQSqj8w8x6lAmS+NW/BaDVzM5LMw/2GzQTV+8hc9siDo/iBVyKjr87g3xTH36S4A/qn+VpFWEy+2EV9TI=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by TYZPR03MB5939.apcprd03.prod.outlook.com (2603:1096:400:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 18 Jan
 2023 08:52:21 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d%4]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 08:52:20 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [RESEND v3 01/13] dt-binding: mediatek: add bindings for MediaTek
 mt8195 MDP3 components
Thread-Topic: [RESEND v3 01/13] dt-binding: mediatek: add bindings for
 MediaTek mt8195 MDP3 components
Thread-Index: AQHZKVms05m6LhvokEeyIkOE8xk7Za6gsTCAgAMwdIA=
Date:   Wed, 18 Jan 2023 08:52:20 +0000
Message-ID: <bd6bbc3d126a39dd8b8499e891b152c25b6713a7.camel@mediatek.com>
References: <20230116032147.23607-1-moudy.ho@mediatek.com>
         <20230116032147.23607-2-moudy.ho@mediatek.com>
         <f24a54f1-2720-3345-9596-bb8d388ba16f@linaro.org>
In-Reply-To: <f24a54f1-2720-3345-9596-bb8d388ba16f@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|TYZPR03MB5939:EE_
x-ms-office365-filtering-correlation-id: abca9a7e-977b-42ed-e37a-08daf9314f83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: alErhBTAq4k++HsxS4qYLK6+8CnPlRgWay7q6kjM2RGedoaddivjI5Hsq5z+4TjDmYva7OCtRaXTbxUmQQZFLUTRQJhiQ8TaxnxpYfF3wNMuYmQ1CLjpHTm5QYJtzgyhLDy1a4ta9mP7n4UJG27WPDS2qcATR47uWBUGUGUu30IC5xbtFtdOFVFB66/TkPRYOtQ8+ELTOomJcbqbsLQb43B2aRZIsNfybkkQcd9E3qwvqzUK/pEpKBgvU450cKMruGjORkFrIxVVlzhctMJV+fYyCfp5/mPn6l5mIukoWIIc1lsuryY8Tri1ycmvFK5e8XdEQOzwx+svHoZlA7peQELf7GlBdElMj8ceVrR/BspoI2jb1q7PYLypB/Won7iiW3Rr2/3opUSDPrTOJ0gODVgcp4oifCHgVckkNw7CX/xHMR9uYyoSvQ4ghdCshf/QrVyy2++fsC27wQHGgHNOAlukNOsC9rgxhZi/m4gbibdxW6B7D8yZLtQGT/yfnCkiw/c0gZMt8/hibNSG2zCAI7hw1c1gB2XoyV9ldCpUnT3YY2vpxCPoXDtZgL/QNiDptQiD25ijkb/UJjZJK1r52woLFftgpML068iVZQohxuvXGljnXk9qaLq67d5Z0qwHfcfLdZ6fdi/m5J0OUILKNfwNjJnLV3InRnFpqPZNGg8dr81jZVXgfLJh7YHU8KtbeMZvUfe/OXWvURu/nofo+XM0RDzLNeyG6+siuHyPoU3T9A+C3hb3ga611TPgiQL5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(36756003)(83380400001)(41300700001)(8936002)(85182001)(2906002)(66476007)(122000001)(76116006)(2616005)(4326008)(54906003)(8676002)(66446008)(110136005)(64756008)(316002)(53546011)(5660300002)(38100700002)(38070700005)(86362001)(7416002)(66556008)(91956017)(66946007)(26005)(6512007)(478600001)(186003)(966005)(6486002)(6506007)(71200400001)(107886003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODRWVmdtTWcwREpDQ3V4YTFvYTlubDdmZFFYWGl1TXM1dlB3dVJSelBwUTl3?=
 =?utf-8?B?Zm9kSjllQW1HNi9VcmZVWElXSGpxaS91d1V6RGt6NFhlYTE1MjBYSXVycG9W?=
 =?utf-8?B?eHNkbHczNXdNYmhGTC9pU0UxVEk4ci9GblVwMVVNNUREMU5NQ1VCMGhOQmha?=
 =?utf-8?B?ejVkRzJnUTF3RDNDQzRRWElQUGhkQTZ3cm5GM01oVnFNamZjeVJwNFNDQjBJ?=
 =?utf-8?B?SWUreDlqU2svMCtWelRWNUh4N3QyOHQrVGRFMVJZdUNISm9La2w4R2tkcmpa?=
 =?utf-8?B?eHI5bWd0WWlhRVc4MTJEMlpTNWRmTlZVR04wam5sMldOVUE1THZ3QWJiRzB6?=
 =?utf-8?B?USs5a0o0NFJiWjBsWisvUzJVQzJEcU9zR1BHdEYxaDRSRFFEak1yaDVuTDFF?=
 =?utf-8?B?b2VmTFREeEt1aUNZQ0t4RkVoWUg2cFlNN2ExbDdWYnFTem1YdWNtOU5nRUFj?=
 =?utf-8?B?N1ZBTjcxVzVUbFBGc1paM0JOV2kzdnE3Rm82bGRmd0FTUjBiSlhnL3NRSnBy?=
 =?utf-8?B?aXBhM2FycnNsNUF3ZjlnTFBpYWpUYkxxZDQrK1c0dEkrUVpTZlRBaGZXMkwv?=
 =?utf-8?B?dWNSeDlvSGs1UUVTckcrMGQ2WFhqS1c3TGpXQlo3RlNoZVBVVjNiK3g4Vmp6?=
 =?utf-8?B?YWI4TS9tVmtUZ0NYSDJ3TkRGYVBhOU01bWdDbnNMaEdjM1I1N1hnWXQ0Szdl?=
 =?utf-8?B?RC9hR1FTZHJ3WGZjenVIbEJGaVJ3cHdNMjJxNExwNnNXb3huUUkreTBwVFds?=
 =?utf-8?B?ZDlhS1draHJVbmlGUzJibEpINUNWOHRTZ1JwRWJUSGhZdnlTRndEVGYxTUwy?=
 =?utf-8?B?bGlmWmFEQU9RNW5XOVMyUXRZeXZ6emt5cnJOb3JETk1BVHFEd2loc3A3S3Fp?=
 =?utf-8?B?c3JScS9UT0E0M2taOG03OHVvUWR2WUlEaWhOWEd5T1J0aWV5eXVPa0RDaVNi?=
 =?utf-8?B?Q1NMSmhxdVZRK3pQNGZqUHhFbmRwc1doeS8zaGc4c3hoMW9xb3VyMFBjOVFh?=
 =?utf-8?B?YW8vcGUxWTRXUmQyTk1zRGhqS0h6L1RGVkNZQlpUS0NJaWd2SUNTNGJleURl?=
 =?utf-8?B?ZXlNRlRHVXN1QUFVd1lFSFJIYnp0cHhIMGtmRVJ3am1vWi83M2MxQnJQVUpz?=
 =?utf-8?B?clRYejc0TC9BVlRVQkUzZkovL0Zic2l5dFJPTDNYQ2tWOS9SOTlMSGtvM1hu?=
 =?utf-8?B?a1FTUW9wTmdHaVRaWjVWdzBiY1NaUG9KVWhqN0ZIOURaenFHOUxVK0Nyc1B2?=
 =?utf-8?B?ZzVYQjdPeDhQTnF1NG9WcGF3VFUxa1k2VzdqLzZrcUdsbGRPRHVKU1FBa0pz?=
 =?utf-8?B?Z3E2aGdzN1FjQWtseERyaUVCV0RuRk83dGFoTlhFV2xmSHdHaWRDTm1IOUhG?=
 =?utf-8?B?anliaUF5OGRWWXc2OTBpL1YraUtTL3B6OGNTUU5rQXc3am94blJvUUF5cFZa?=
 =?utf-8?B?ZEJic0l4bmhxUVh6cGcvVGhmeWwwamo1Q0tCYm1SdUhlVWd5ZUtIOG5tUWlR?=
 =?utf-8?B?SVcvc2RBZEtWazNyL3pMYitmSVZMNFJUQ0tad0g3a0wwZHpNRlJnVm9jcExF?=
 =?utf-8?B?bU5GR21uTDlBT2FJd1FZaHFHWXdKZFJYSlBGWkpCZXA1ZVJ3Y1d5MjU4WlhW?=
 =?utf-8?B?NElqZ2VqMElwS2hFZ3hUeXkycGdHVy9QNGxWUjlKbnJZcndubzkwOERkaEVM?=
 =?utf-8?B?UFFaMzdXT2ZxRjQzOW9LeitIdmZUaUF0RTBpdDhaWENRTFc0MUd6MXNqcllN?=
 =?utf-8?B?VGNtY1htZmlsaDdvYm5lb0daQ1FjNDhGbEdmc0QyVHdXTDFjL2RBOThRaHhh?=
 =?utf-8?B?REpHSjdxZWFUb2pUMGJtTzdLV3IrY3lYWUV6REhqaDNndUh2L1ZXaWx1UjZR?=
 =?utf-8?B?eStVYnpSam9jWjliSkpZTXpyTjhFVjBsNXVDK1hlNHgvajcxSFB0V1ljUk5j?=
 =?utf-8?B?cGo2b0V3TXNqZUoxWUlab2sraWQwWnJHaU9KVm9paGxvZzUrUHFTVU80OWZQ?=
 =?utf-8?B?d2V3WXd4L3NoV3VUYmRiRG9QbUIyZWhXME1YYVJBUlI0cGl6U3NuOXlUTWpt?=
 =?utf-8?B?SVpUZ05JdkV6bDh4TTIxV2dpN0d5dzVMakQ2LzNUNGVvRjlPejBDTkxYT0dB?=
 =?utf-8?B?dkZzVWlYZStKUU1XQlRIYlR6dVJSRERBb0Z1QW1wNnp3Mk0rb0ptQ3FTTnlV?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8091A707113A544A7DC419DBA1AC766@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abca9a7e-977b-42ed-e37a-08daf9314f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 08:52:20.8635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6UZ2WuTi/9lBKGEmhK0NKfX/C38kPxZtCakWv4Mc4sjLIxXQICF/Qw5jW0HiG7GWzmr5M70fWt3tTMIYPGapg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5939
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

T24gTW9uLCAyMDIzLTAxLTE2IGF0IDA5OjEwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNi8wMS8yMDIzIDA0OjIxLCBNb3VkeSBIbyB3cm90ZToNCg0KKHNuaXApDQoN
Cj4gPiArICBtZWRpYXRlayxnY2UtY2xpZW50LXJlZzoNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0K
PiA+ICsgICAgICBUaGUgcmVnaXN0ZXIgb2YgY2xpZW50IGRyaXZlciBjYW4gYmUgY29uZmlndXJl
ZCBieSBnY2Ugd2l0aA0KPiA+IDQgYXJndW1lbnRzDQo+ID4gKyAgICAgIGRlZmluZWQgaW4gdGhp
cyBwcm9wZXJ0eSwgc3VjaCBhcyBwaGFuZGxlIG9mIGdjZSwgc3Vic3lzIGlkLA0KPiA+ICsgICAg
ICByZWdpc3RlciBvZmZzZXQgYW5kIHNpemUuDQo+ID4gKyAgICAgIEVhY2ggc3Vic3lzIGlkIGlz
IG1hcHBpbmcgdG8gYSBiYXNlIGFkZHJlc3Mgb2YgZGlzcGxheQ0KPiA+IGZ1bmN0aW9uIGJsb2Nr
cw0KPiA+ICsgICAgICByZWdpc3RlciB3aGljaCBpcyBkZWZpbmVkIGluIHRoZSBnY2UgaGVhZGVy
DQo+ID4gKyAgICAgIGluY2x1ZGUvZHQtYmluZGluZ3MvZ2NlLzxjaGlwPi1nY2UuaC4NCj4gPiAr
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUtYXJyYXkN
Cj4gPiArICAgIG1heEl0ZW1zOiAxDQo+IA0KPiBpdGVtcyB3aXRoIGl0ZW1zIHN5bnRheCBpbnN0
ZWFkOg0KPiANCj4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjUuMTgtcmMxL3NvdXJjZS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc29jL3NhbXN1bmcvZXh5bm9zLXVzaS55YW1sKkw0Ml9fO0l3ISFDVFJOS0E5
d01nMEFSYnchbGNmZXJyRkZQLW1zaERITkwtcndKTGdOS0RyWEY5ZlhvbGpwcUwzMGs1WUtUTnZD
d3VDM3dlYnpSMzJWblFRb1BlRnZTdkFld05rZXVwY1Q0bWpkRV9yb3hXVW8kwqANCj4gIA0KPiAN
Cj4gPiArDQoNCihzbmlwKQ0KDQo+ID4gKw0KPiA+ICsgIG1lZGlhdGVrLGdjZS1jbGllbnQtcmVn
Og0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFRoZSByZWdpc3RlciBvZiBjbGll
bnQgZHJpdmVyIGNhbiBiZSBjb25maWd1cmVkIGJ5IGdjZSB3aXRoDQo+ID4gNCBhcmd1bWVudHMN
Cj4gPiArICAgICAgZGVmaW5lZCBpbiB0aGlzIHByb3BlcnR5LCBzdWNoIGFzIHBoYW5kbGUgb2Yg
Z2NlLCBzdWJzeXMgaWQsDQo+ID4gKyAgICAgIHJlZ2lzdGVyIG9mZnNldCBhbmQgc2l6ZS4NCj4g
PiArICAgICAgRWFjaCBzdWJzeXMgaWQgaXMgbWFwcGluZyB0byBhIGJhc2UgYWRkcmVzcyBvZiBk
aXNwbGF5DQo+ID4gZnVuY3Rpb24gYmxvY2tzDQo+ID4gKyAgICAgIHJlZ2lzdGVyIHdoaWNoIGlz
IGRlZmluZWQgaW4gdGhlIGdjZSBoZWFkZXINCj4gPiArICAgICAgaW5jbHVkZS9kdC1iaW5kaW5n
cy9nY2UvPGNoaXA+LWdjZS5oLg0KPiANCj4gRnVsbCwgcmVhbCBwYXRoIHBsZWFzZSwgc28gaXQg
Y291bGQgYmUgdmFsaWRhdGVkIHdpdGggdG9vbHMuDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCj4gDQoNCkhpIEtyenlzenRvZiwNCg0KU29ycnkgdG8gYnVnIHlvdSBhZ2Fp
biBhYm91dCB0aGlzIHByb3BlcnR5LCBjb3VsZCBpdCBiZSBjaGFuZ2VkIHRvDQpmb2xsb3dpbmcg
Zm9ybS4NCg0KICAgIG1lZGlhdGVrLGdjZS1jbGllbnQtcmVnOg0KICAgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheQ0KICAgICAgaXRlbXM6DQog
ICAgICAgIGl0ZW1zOg0KICAgICAgICAgIC0gZGVzY3JpcHRpb246IHBoYW5kbGUgb2YgR0NFDQog
ICAgICAgICAgLSBkZXNjcmlwdGlvbjogR0NFIHN1YnN5cyBpZA0KICAgICAgICAgIC0gZGVzY3Jp
cHRpb246IHJlZ2lzdGVyIG9mZnNldA0KICAgICAgICAgIC0gZGVzY3JpcHRpb246IHJlZ2lzdGVy
IHNpemUNCiAgICAgIGRlc2NyaXB0aW9uOg0KICAgICAgICAuLi4gZGVmaW5lZCBpbiA8aW5jbHVk
ZS9kdC1iaW5kaW5ncy9nY2UvbXQ4MTk1LWdjZS5oPi4NCiAgICAgbWF4SXRlbXM6IDEgDQogIA0K
QWxzbywgaXMgdGhlIGluY2x1ZGUgaGVhZGVyIHBhdGggc3RpbGwgbmVjZXNzYXJ5IGluIHRoaXMg
Zm9ybT8NCg0KU2luY2VyZWx5LA0KTW91ZHkNCg==
