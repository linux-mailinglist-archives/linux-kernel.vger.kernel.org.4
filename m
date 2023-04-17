Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5626E3D19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 03:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDQBHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 21:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQBHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 21:07:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6E1BDB;
        Sun, 16 Apr 2023 18:07:17 -0700 (PDT)
X-UUID: 2faf23fcdcbc11eda9a90f0bb45854f4-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xNeEzuq5nAC+2wTuz9s9aNIFaDsrIvInebk8HAP3N9o=;
        b=TY18iU3j6TGLm2rqVTilFjrj/2lhk8PpGlXu9Wsw5cJIYQsPmC68Irc/OE7MsP+A/T/guf+iMK54Tm9uaY7OpzQMDF8UHW52yrFpM/56rGvpEUdgznyhhEQUFZXqfsAcT7AjXXos4VIYuroS+A9KPzPVjIP6aOCiB8WwdLxm9Xg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8a135eed-b861-4a0e-b0ea-203e1d227061,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:18253d84-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 2faf23fcdcbc11eda9a90f0bb45854f4-20230417
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1694995345; Mon, 17 Apr 2023 09:07:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 09:07:11 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 09:07:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VErI7m5TaqsIWi5rZWphlVd8OSwgoiSA7fNiEnZr9V1syyUDT9KTcGwq4lVk64SDOC7lvEyaYZ99UbMhm1b3qOj6cRKgb4QG/ex/xiTweFZDY6zMCZu/FQ11LTSRFTNjyMGekFcaaFruxJpwYwN4YegcGGYAaow/MZUf0vVDDox0z2VQ892sBLYIf/1dIw91QutBzT7Iwg85kN5guilLhJVC2GnCxXgEKkNnVS2hrKkEqx4iOPjRlAq0UCt5eLzaGK/qfMtf1RmLgR38L7vhrSkBxYc3Z+1U4CsKT8OzRcQ3biPn5NiFYBzRHWH+/j+JjYrsAGf2WwKP5juiPEjEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNeEzuq5nAC+2wTuz9s9aNIFaDsrIvInebk8HAP3N9o=;
 b=Bc2GQj2s5XyBcJ9t/HZj2Ut4+XwvMmq4tdApqzOcwdXo5nD1FrIdBfn7RUqtQL1wHzl86IONE707JN5QSDUQkA52Jh06jilMX5IeU+H+b/qqT/TNV+fI0dVCvZCqtbvEk0xb13Ibj28ggRUhiDfUCP9/PaftlPdTb9mOD89Dc6GE3I0TecKbarK5IL5KaQHXMfoe2SlSbOTUABgYrkecMp8/3Ig3DFIw/3/rKKUj4iNIHly3jAggOoAHsMROhA6KNBtGcFfDUBINZ33mel2fY+ySI4Dvc6v+4b2V2ngkbUpeSXrHaKIlSoigBjCr006FrYBd0BFbCodPb00OtTxlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNeEzuq5nAC+2wTuz9s9aNIFaDsrIvInebk8HAP3N9o=;
 b=oedui0g7ig6PjlJsrXZJofeqfQkpIjVau93qL0EVU+XaQeCfINdVBaNofAOeHVGpdmD8p0oEtkuHdELkaShAd0FsLLo3ezvWb2z10xri03iTv2U9cRUwbV3ltLZD4azmPvy/JlzZuq+1tsvPQmey0+cveunUPNq+K9u55JEOo94=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR0302MB5460.apcprd03.prod.outlook.com (2603:1096:820:33::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 01:07:09 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5f8a:bed1:bdb3:7677]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5f8a:bed1:bdb3:7677%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 01:07:09 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        =?utf-8?B?VGlhbnBpbmcgRmFuZyAo5pa55aSp5bmzKQ==?= 
        <Tianping.Fang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/7] usb: mtu3: give back request when rx error happens
Thread-Topic: [PATCH 1/7] usb: mtu3: give back request when rx error happens
Thread-Index: AQHZZddXFpkvr0lWZECE7OMyd+pUOa8ZhNEAgAXzNYA=
Date:   Mon, 17 Apr 2023 01:07:08 +0000
Message-ID: <bdaf5fed70321a2fcead837a90f0aded57610cc5.camel@mediatek.com>
References: <20230403025230.25035-1-chunfeng.yun@mediatek.com>
         <6626cb88-9d9e-593f-f4c9-44c3035bad43@collabora.com>
In-Reply-To: <6626cb88-9d9e-593f-f4c9-44c3035bad43@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|KL1PR0302MB5460:EE_
x-ms-office365-filtering-correlation-id: ca9160fe-c5d7-45fe-c054-08db3ee01180
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K5Bqs2/TInei8DwSKVFCiSBy2U7MDhG19l8z/JsYas37FR8dV3ldXkckolIMA31iJwIXpt5NV1j8j+lV3kzM56Pyf0rsbpVZR3uBCk06dtVqqdRuFJSBOoJKlks0tKA7OZzUT1InMfd840AcRKzdl/Cpu1bCJCZZky8t0m+WgJP9BDHxEJqGKcWZBHoDZI/mOoOHwRcdJor36TRYPakKu8JzCcNRYH4McRbhl+3hC9yXsq8biEJBxgrX9bVTb+BvVR6RfY82z4gGrLp9SWHyoZvD6GiyQFHv786QAOH58v7q6F7zoJZ1tcmeLAHyd6YmUitpwCSZoiEpuITMtLj4roow63TRMDPllybwUV/I16JSn6X5acEHpaDyJrVQ7H5Seu4OZRSYJV6MxfAPBrfOQe4OZ9vKqBRVyqX4zLq/953UlgJFeq45proNI8yY8VQ5pQMtDwm3a+F0pLvGLwhOdiof9L80f8gXcY4QfK2bROUgdSBKYalI6pqDcJw+wCQzRtaKGap4rzp7QuJcIodxyPF9C/pVZmcs898VFl69r5rgHLidAwjhlDJTDBzlVRpRKfj9NNHRxdCVXSzYc2taQG9bIN8aujo8UiOkO50I4rm1BJqzC+2vtpWjOemKtRivxNm6f9QmUcuRdBDiuktYslceiFA6bWzomG46ryPkmDbOXj6FsD9Xvw2wHBmXCsCm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(36756003)(85182001)(7416002)(38070700005)(2906002)(5660300002)(8936002)(8676002)(41300700001)(122000001)(38100700002)(86362001)(478600001)(54906003)(2616005)(110136005)(6506007)(26005)(6512007)(71200400001)(186003)(6486002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDZvb0g5Z2JXb0h2cDFVczAyVUgzMlhvV3dQNmN0RkJ6MVJ4YytnUlRKV2Q2?=
 =?utf-8?B?MEtHbDRNVE9PanVIeTkvbC9VczUwcFh6ZmZoVWxGTS9uUjNoMExnTTJQd0h4?=
 =?utf-8?B?MVhxaGEyejdlQUNFZy9Md25rNEd4a1RPRTNKR0EwR2FsSW40M1Z1Y3NiY2xI?=
 =?utf-8?B?V0ZnUkxXOER1ams5anBFSWhmTFE3cjlKNUhON1lZMHhVU1YybkllWDZtWnpE?=
 =?utf-8?B?cWhmYUtGYnRRbzFTQnN3NDBlakJpWXNRRWEvZ1p4K0M5ak1HSlRVTGZ5RDlD?=
 =?utf-8?B?ZjhkbkcrR0lPVGlEWW9ka0ZtOVRPbFFuejVIckVFOUx1Z0dSY0RuWGxid3pp?=
 =?utf-8?B?K0tRL3JZT01QMENTU0pEdE0vMmhGR1hYQ3pSdG1xTkwvZGtjeTFuUmRndDU1?=
 =?utf-8?B?ZlRqWFkwclBiUEJFaEtUWFpvWW1rVEl2MVBwZDBLU21EYTlXOXNPaDFxazlx?=
 =?utf-8?B?YXg4MGVWdDIxRUZHRmFxWTR5aWIrUXBQcklBU1RtZ2VjT0lPREdUUzJjOWRq?=
 =?utf-8?B?YjAzNkJnalRyNFhPMGZORmw5ekRlYjZ3SkZucGhxWDFJTWdOdHA4cmpyYnhu?=
 =?utf-8?B?aUxRRllUNTIxUkZiVk0wdC9CaEQ5a01EMGVEZThNeU01YnoxNW15VHFNSlh6?=
 =?utf-8?B?Y1FoN1l5VC9JeEpGNzNGTzZDaU9LMmxEcWkwYi9IaGlYRjhhYkd2NS9qWUFx?=
 =?utf-8?B?NTFZV0JWbFBuRmpZZXVONGJBWTYvNFRlcy82RGNIRklOZGdzYisyK2hnNDhS?=
 =?utf-8?B?VlNsQi93Zmlrd3hnQWNlTjhXbHJlb0ZGdXlrcWh5emlTa2JwaTJEdnNramV6?=
 =?utf-8?B?RkhuL0RiWFM5TnpJd1BPaFNIWXFGT1ZFQUtncjc3Q2N5OTlLdGt2SEx6aWtj?=
 =?utf-8?B?RjNVYzhTSWFkK1dBQzJWOGtYbnVvbzFYU3JVMlB1aFFkSTl3U2hXU0hXZ2M5?=
 =?utf-8?B?Q0s0UDVWcmtvQjVwL1Y2NmNRc0VyRGFqT1k5WWMyYytUbVBrZVdDMVUvQ2tx?=
 =?utf-8?B?TFdacEVxaVZWeG43ODdDaTFvelVHSVUwL2d6U1A5OUQzUURqWWVCTjlqSWdR?=
 =?utf-8?B?T1BIZGlNQnAwTS9VRG42Y015Q1FYc2g4QzVFcGRNbjE4Zyt4TGFaWTBLaTBJ?=
 =?utf-8?B?S2drem82WjY0MTZ4K3QxQWErYzZ0R3g3blNFSUFIV1NkS3hRU3RkaE1mQjAw?=
 =?utf-8?B?ZXJ5OTRYQitSR05wdGVaUmlGUG9GTk4vdzFVTkRwbktCZkxJUmRFM0hoQS9y?=
 =?utf-8?B?UElRdHZtSFlBVkNTcmF6b0xHSVRSNjhYSGxPM2lGWGpWMUpmTm53aTZDK1g1?=
 =?utf-8?B?aGlkMVlyaGpKc0J0VDVscElzbWs2T08yVEJQbWhuVkE3V3lJMGcxdGN4S0Vm?=
 =?utf-8?B?Tm9YRFdyVWZjQit5alZ0V2RMYWtOaTFuL3hCbmoxQitGMEhXVlF3ZndlWXcy?=
 =?utf-8?B?aTNmdEdlRTl0RFdMbTNPUHNaaWM2UDJIejBwaDl2VHJwVTVJZTU1ZGIyUHVC?=
 =?utf-8?B?U05OQWI3a3JrTVVnY1oxR1RtdStPQjB1Nk01bkhnNkpibDRlYStFVVdSMTdX?=
 =?utf-8?B?dThSSDByd0RrS3Z6dHpTWEo5WStneUNmUHl1ek1FTGZEQVlINmEzUTBOWDB6?=
 =?utf-8?B?UmxWcFZHUWpWRStGNldhNDE4YXg5NDllODBrS3dKemUyamRONC82d0Z4ejRL?=
 =?utf-8?B?d3NMeFh3SDJOeGRiWFNwdTZwNEVSTmVBbmpwd2EwS3JpRExja1RIaFB6VVYr?=
 =?utf-8?B?ajZwankxTk1NOTJkbm9rb2VoR0kySFdNeVZadUpmcldFa291UUZELzVhTTRq?=
 =?utf-8?B?VGFnbTZpYkxFVzIzRXIzYy80cXB2c3Zqb05LcktXbXQzbCtPTzR5elUyWlFY?=
 =?utf-8?B?Z2tLcmwvV0RBSEx0SmhqbHpBTDBUMS92K0ZtaS9IenFkbkpleTJUWUV1MHpH?=
 =?utf-8?B?dGUwVUNCL0ZDUy85ZW5wZlZRMkRlSEVrUUpsNmhpL1FaUjdjZXJQbEtnZ1NU?=
 =?utf-8?B?MGVvUGtia1NOMXo1QkRHQ2FNU1JSZGpJVUlFN0V1dTJPZURvVnBrNkhsbEdC?=
 =?utf-8?B?K3RxYkc3T0g0Z2JwcWhrcys0KzBhZGQvcXhCazRPNFE4NFN6dTMwRENZL0ha?=
 =?utf-8?B?dUgybVhOdFI3MmVNR0Zkdm9QaDRYMnBEdk0vQ05NVnNkanhUT3c5c0VwbVNV?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <002D59971C805C4BB6FE5CCDCE476859@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9160fe-c5d7-45fe-c054-08db3ee01180
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 01:07:09.0016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0MoiVAxE2IdNuIvbAGVPZSRXxXi7oUqB9txIuLOYSnySk/S1cMbC2mwR1eDXS4ByzDhleV/H6snqyxuEVz8KgHO6XNWPbjR145ji0knUKpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5460
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDE0OjMxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwMy8wNC8yMyAwNDo1MiwgQ2h1bmZlbmcg
WXVuIGhhIHNjcml0dG86DQo+ID4gV2hlbiB0aGUgUnggZW5jb25udGVyIGVycm9ycywgY3VycmVu
dGx5LCBvbmx5IHByaW50IGVycm9yIGxvZ3MsDQo+ID4gdGhhdA0KPiA+IG1heSBjYXVzZSBjbGFz
cyBkcml2ZXIncyBSWCBoYWx0LCBzaGFsbCBnaXZlIGJhY2sgdGhlIHJlcXVlc3Qgd2l0aA0KPiA+
IGVycm9yIHN0YXR1cyBtZWFud2hpbGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZl
bmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiANCj4gIEZyb20gd2hhdCBJIHVu
ZGVyc3RhbmQsIHRoaXMgaXMgbm90IGEgbmV3IGZlYXR1cmUsIGJ1dCBhIGZpeCBmb3IgYQ0KPiB1
bndhbnRlZCBRTVUNCj4gaGFsdC4NCj4gVGhpcyBtZWFucyB0aGF0IHRoaXMgY29tbWl0IG5lZWRz
IGEgRml4ZXMgdGFnLg0KSSBkaWQgbm90IHRha2UgaW50byBhY2NvdW50IHRoaXMgY2FzZXMgd2hl
biB3cml0ZSB0aGlzIGRyaXZlciwgaXQNCmNhdXNlZCB0aGUgaXNzdWUgYnkgdGhlIGJ1ZyBvZiBo
b3N0IGRyaXZlci4NCg0KPiANCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvdXNiL210dTMvbXR1M19x
bXUuYyB8IDM5DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXR1My9tdHUzX3FtdS5jDQo+ID4gYi9kcml2
ZXJzL3VzYi9tdHUzL210dTNfcW11LmMNCj4gPiBpbmRleCBhMmZkYWI4YjYzYjIuLjdiZTRlNGJl
MWE2YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9tdHUzL210dTNfcW11LmMNCj4gPiAr
KysgYi9kcml2ZXJzL3VzYi9tdHUzL210dTNfcW11LmMNCj4gPiBAQCAtNDY2LDYgKzQ2NiwzOSBA
QCBzdGF0aWMgdm9pZCBxbXVfdHhfemxwX2Vycm9yX2hhbmRsZXIoc3RydWN0DQo+ID4gbXR1MyAq
bXR1LCB1OCBlcG51bSkNCj4gPiAgICAgICBtdHUzX3FtdV9yZXN1bWUobWVwKTsNCj4gPiAgIH0N
Cj4gPiANCj4gPiArLyoNCj4gPiArICogd2hlbiByeCBlcnJvciBoYXBwZW5zIChleGNlcHQgemxw
ZXJyKSwgUU1VIHdpbGwgc3RvcCwgYW5kIFJRQ1BSDQo+ID4gc2F2ZXMNCj4gPiArICogdGhlIEdQ
RCBlbmNvdW50ZXJlZCBlcnJvciwgRG9uZSBpcnEgd2lsbCBhcmlzZSBhZnRlciByZXN1bWluZw0K
PiA+IFFNVSBhZ2Fpbi4NCj4gPiArICovDQo+ID4gK3N0YXRpYyB2b2lkIHFtdV9lcnJvcl9yeChz
dHJ1Y3QgbXR1MyAqbXR1LCB1OCBlcG51bSkNCj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCBtdHUz
X2VwICptZXAgPSBtdHUtPm91dF9lcHMgKyBlcG51bTsNCj4gPiArICAgICBzdHJ1Y3QgbXR1M19n
cGRfcmluZyAqcmluZyA9ICZtZXAtPmdwZF9yaW5nOw0KPiA+ICsgICAgIHN0cnVjdCBxbXVfZ3Bk
ICpncGRfY3VycmVudCA9IE5VTEw7DQo+ID4gKyAgICAgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEg
PSBOVUxMOw0KPiA+ICsgICAgIHN0cnVjdCBtdHUzX3JlcXVlc3QgKm1yZXE7DQo+ID4gKyAgICAg
ZG1hX2FkZHJfdCBjdXJfZ3BkX2RtYTsNCj4gPiArDQo+ID4gKyAgICAgY3VyX2dwZF9kbWEgPSBy
ZWFkX3J4cV9jdXJfYWRkcihtdHUtPm1hY19iYXNlLCBlcG51bSk7DQo+ID4gKyAgICAgZ3BkX2N1
cnJlbnQgPSBncGRfZG1hX3RvX3ZpcnQocmluZywgY3VyX2dwZF9kbWEpOw0KPiA+ICsNCj4gPiAr
ICAgICBtcmVxID0gbmV4dF9yZXF1ZXN0KG1lcCk7DQo+ID4gKyAgICAgaWYgKCFtcmVxIHx8IG1y
ZXEtPmdwZCAhPSBncGRfY3VycmVudCkgew0KPiA+ICsgICAgICAgICAgICAgZGV2X2VycihtdHUt
PmRldiwgIm5vIGNvcnJlY3QgUlggcmVxIGlzIGZvdW5kXG4iKTsNCj4gPiArICAgICAgICAgICAg
IHJldHVybjsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIHJlcSA9ICZtcmVxLT5yZXF1
ZXN0Ow0KPiA+ICsgICAgIHJlcS0+c3RhdHVzID0gLUVBR0FJTjsNCj4gDQo+IFlvdSBkb24ndCBu
ZWVkIGEgKnJlcSBwb2ludGVyIGZvciBqdXN0IG9uZSBzaW1wbGUgYXNzaWdubWVudC4NCj4gDQo+
ICAgICAgICAgbXJlcS0+cmVxdWVzdC5zdGF0dXMgPSAtRUFHQUlOOw0KPiANCj4gdGhhdCdsbCBk
by4NClRoYXQncyBnb29kLCBJJ2xsIG1vZGlmeSBpdCwgdGhhbmtzDQo+IA0KPiA+ICsNCj4gPiAr
ICAgICAvKiBieSBwYXNzIHRoZSBjdXJyZW50IEdEUCAqLw0KPiA+ICsgICAgIGdwZF9jdXJyZW50
LT5kdzBfaW5mbyB8PSBjcHVfdG9fbGUzMihHUERfRkxBR1NfQlBTIHwNCj4gPiBHUERfRkxBR1Nf
SFdPKTsNCj4gPiArICAgICBtdHUzX3FtdV9yZXN1bWUobWVwKTsNCj4gPiArDQo+ID4gKyAgICAg
ZGV2X2RiZyhtdHUtPmRldiwgIiVzIEVQJWQsIGN1cnJlbnQ9JXAsIHJlcT0lcFxuIiwNCj4gPiAr
ICAgICAgICAgICAgIF9fZnVuY19fLCBlcG51bSwgZ3BkX2N1cnJlbnQsIG1yZXEpOw0KPiA+ICt9
DQo+ID4gKw0KPiA+ICAgLyoNCj4gPiAgICAqIE5PVEU6IHJlcXVlc3QgbGlzdCBtYXliZSBpcyBh
bHJlYWR5IGVtcHR5IGFzIGZvbGxvd2luZyBjYXNlOg0KPiA+ICAgICogcXVldWVfdHggLS0+IHFt
dV9pbnRlcnJ1cHQoY2xlYXIgaW50ZXJydXB0IHBlbmRpbmcsIHNjaGVkdWxlDQo+ID4gdGFza2xl
dCktLT4NCj4gPiBAQCAtNTcxLDE0ICs2MDQsMTggQEAgc3RhdGljIHZvaWQgcW11X2V4Y2VwdGlv
bl9pc3Ioc3RydWN0IG10dTMNCj4gPiAqbXR1LCB1MzIgcW11X3N0YXR1cykNCj4gPiANCj4gPiAg
ICAgICBpZiAoKHFtdV9zdGF0dXMgJiBSWFFfQ1NFUlJfSU5UKSB8fCAocW11X3N0YXR1cyAmDQo+
ID4gUlhRX0xFTkVSUl9JTlQpKSB7DQo+ID4gICAgICAgICAgICAgICBlcnJ2YWwgPSBtdHUzX3Jl
YWRsKG1iYXNlLCBVM0RfUlFFUlJJUjApOw0KPiA+ICsgICAgICAgICAgICAgbXR1M193cml0ZWwo
bWJhc2UsIFUzRF9SUUVSUklSMCwgZXJydmFsKTsNCj4gDQo+IFBsZWFzZSBtZW50aW9uIGluIHRo
ZSBjb21taXQgZGVzY3JpcHRpb24gdGhlIHJlYXNvbiB3aHkgeW91J3JlIG1vdmluZw0KPiB0aGlz
IHJlZ2lzdGVyDQo+IHdyaXRlIGhlcmUuDQpJdCBjbGVhcnMgaXJxIHN0YXR1cyBiZWZvcmUgaGFu
ZGxpbmcgdGhlIGVycm9yOw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCg==
