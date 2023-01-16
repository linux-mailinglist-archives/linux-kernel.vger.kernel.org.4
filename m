Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC4A66BB0E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjAPJ44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAPJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:56:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6A115565;
        Mon, 16 Jan 2023 01:56:33 -0800 (PST)
X-UUID: 0b73d980958411ed945fc101203acc17-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WXgvx8O04Tc+TSCJm6e3F33yvrTWN+W1OIj/Ta3TO5w=;
        b=R2OAdkAD3E+T3Zbv7wup/Jww74k4n0k4A6PGSRP+A0IxJ4pQRCFZkNNaFsWGjTMoEIWnIM5RrazrVzR4X+ypF/gOpE6xiXKFJBLLy8Ov3EhyHBh4+2I80ERJArKh+Eo0ddna0KBC7n1bAi/kepfdbOsR1IVEQvQGBVvJ7Jn+g0Q=;
X-CID-CACHE: Type:Local,Time:202301161714+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:96c593da-4f98-4ddf-8289-7bf3dcb97c36,IP:0,U
        RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:2
X-CID-META: VersionHash:543e81c,CLOUDID:5deaeff5-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 0b73d980958411ed945fc101203acc17-20230116
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2077588835; Mon, 16 Jan 2023 17:56:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 16 Jan 2023 17:56:26 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 16 Jan 2023 17:56:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTC+zgyMDe3KFheF9Pbi1QvoaLaFcL691p2fdRaSxqiH67bnogLS3j6+IZ5aIje3EJcw1a46c6wwQDYowqeC/PbQ+umCp7Sxbza6hlf2yO63iJJVmUDgp8Fh0XwW7xsRleI3yxY587EIsB+VoJxAjpIBwlAMqEg1BfaNdz2aNDWpHrZyDdC7B783bngjRwDDtjVlRw89+1WdXEe2y7Il76ZXnG75NdmBOY0ssiSxDdZ26dOIu12hE4igfjnkPKSWP5gChQp1Jqs2ri2jCG2Og5KZ8FARzPIZXR04GKmf6yfzQWdcifLBETtJyhnIJ/5CFevvzrICtbNKMZRvmZVwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXgvx8O04Tc+TSCJm6e3F33yvrTWN+W1OIj/Ta3TO5w=;
 b=l/pMgnaQB91UK84KTFXZlPYKsBVRC5Dgxrr0GxuKlYhKxu5VP8hhlqxYTpKJVo9pnUaV7XubqBQiy3sA+GQ5s/nfxk7CIJ8hp9akyyiUCAwWGUn542yoM8qzD/LvlMk548oSJ1d0zm4U4aQI5fMG0mhvAgfpdKAydqQyezbJGqfPbPwP94rbIMlaMrFqJ8jXPYXuqmEGMbEBddD7+H8hAeC/J77/Umde/3TnicE4fGWAksgyBwyg028ruCo0u2ekrVW//vlOR3w3UXrE1obILg8AaT96Ja7xVAesL55vdwZIuTH4H2VOgoADR5auB5TwRzYWFtF6KdY13QR3JX4YQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXgvx8O04Tc+TSCJm6e3F33yvrTWN+W1OIj/Ta3TO5w=;
 b=UZobnoldioM9Co/ZeKlnErplkW5nRQ8B6hFWM3Duxew/ENuuPTZdM/R2DCbxaDRMRE9Bg+fKjreLCxVMBZd687yLkkqGm2hkHBWR90UUP3Q40kcH3IkpwPw46MgLCpkihCsb3C+BA4uRdlZvK9QycRkk6HrgQm08lx4guJSFsr4=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by SG2PR03MB6610.apcprd03.prod.outlook.com (2603:1096:4:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 09:56:24 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d%4]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 09:56:24 +0000
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
Subject: Re: [RESEND v3 02/13] arm64: dts: mediatek: mt8195: add MDP3 nodes
Thread-Topic: [RESEND v3 02/13] arm64: dts: mediatek: mt8195: add MDP3 nodes
Thread-Index: AQHZKVmtKUIj/R6yHUWKl/iIf9gAxK6gsZMAgAARooCAAADegIAACs6A
Date:   Mon, 16 Jan 2023 09:56:24 +0000
Message-ID: <170cbedbd067a45bf16afe9d694a81dea60b0239.camel@mediatek.com>
References: <20230116032147.23607-1-moudy.ho@mediatek.com>
         <20230116032147.23607-3-moudy.ho@mediatek.com>
         <63f3d41a-1aa3-396a-b515-bc805f4a19b4@linaro.org>
         <47f79e0ffda3fe72e574596aad8c4562a3b6e14a.camel@mediatek.com>
         <ea718cd4-db3c-12a8-aac6-688d7189fbf9@linaro.org>
In-Reply-To: <ea718cd4-db3c-12a8-aac6-688d7189fbf9@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|SG2PR03MB6610:EE_
x-ms-office365-filtering-correlation-id: 75c85a09-e388-4ce4-cd15-08daf7a7ed62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pvdlthggh7X6Q7VjPQ71xyWvMX9UJS8rR3mozry8N40ix39a31QY2T7CBwZWNtLN0RF/Mek650O4qCt9NH20xqjVA/xUIbvxaEF61ST2H687Yb2xvi8+0DrwnkcZyfl6Vmsf+NqYK2ds7C6AQ22apkT9Gami1epJ93Guo2s4DfTD0B9kcRH4/K5H5Kwus2SfGolnAWllk0+eLaMk6Qo4172s03dH3ggNFilbVt+s8TissFmfGr6uaYIBn1Kx5TlAzFBKjWoVnz/WV/bDrgOKc2AQR5FU1LK3APnvkxug8DWI411lj7q1z7EgixLkoAOj40nsjmDQLN6K53vMjuYsbJjrHnplT5oUtoRmmNGG9CjWIi/e0xlHgdHe9vUfauPif0tabH6JBReZw/dqiLQgqhwBRw40LjX1qxVrdXj+hCY/+B1F9kiAQW/d6VlwcmRbnzTjPUsJt++V4l6vdWF1VUiJZVvQtoNHR55GwNLDRIGasKjMuy5GS8LNvlgKsT+0rLEUC/Hz+oDiGlxoBrrcAnKgxz22+CZM58w07l8hjqSgNH78Qq8ZkbZ7ofcATYKkR5WZ7MMODN8c5ilPNSK9jquqU6a4nJYWUhEYXUcu6OuJj6QtLkdbJIfLVYopo/t8RsVeZT24J3FKSMgaJ7JzLwuNXpEiaiycoVkvGXyem0dNWe4hvRWTU2cZs1BwDlJh0XBA+DFRm4T40FiIKaXB8GCVQUb+LvJDNABiekGX8CIddfQg3v/UbMELhsQ5EPhj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(85182001)(36756003)(86362001)(38070700005)(4326008)(76116006)(8936002)(64756008)(66476007)(8676002)(66556008)(66946007)(66446008)(2906002)(7416002)(122000001)(38100700002)(5660300002)(966005)(478600001)(110136005)(71200400001)(54906003)(316002)(6486002)(41300700001)(91956017)(53546011)(2616005)(107886003)(6512007)(26005)(186003)(6506007)(99106002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djJOd2d2U0FMcVIzdkFUMUVudUJ4dVVyQmFtTEJ0M2Y4OVpFMUdCUVFwVHU1?=
 =?utf-8?B?NXBCTFJUdlllRTZHMGxSVzBPVXhZRERHZEpteEd2elk1ZTZuemxDODFqckJK?=
 =?utf-8?B?dDF1TUQwUk1NUkI3WjNrWnJwck5qUkcxU0Y4WkNsd3dvNXdvcE9zS2xnTU11?=
 =?utf-8?B?VzJWVURtVkpNQzZIMSs5WWRVdVppRWhmNnJPdGpNbXUvTnlsdHVoMldwdVdK?=
 =?utf-8?B?eE44Y0szYjNNaURnNktPOVBuY09tRWR5SnJ5WnZJVlJZdVpscU5mdURIeHVW?=
 =?utf-8?B?aVhQRVIvUG93TlBlWlJzSGFQVHpqMEZmSlQ5YjBLNnV3ekhJeXY5VllBdVpC?=
 =?utf-8?B?UVdEdjd0eTl1S2RyRjZ1eE4zVW5qK3FoRXBVM2Q4UlJnQlVDcDA1Y0V1TEFu?=
 =?utf-8?B?WkF6bGtRNWNrMXJxQTRVVXlkOXlWMnhKTmpGVlhLK2EyWlhtdGpCdWFpVmww?=
 =?utf-8?B?YmlrTFhKZnZxSFFNMjhHTzE3TW5STjFLY2tTL29ZUEM2UUJqUVpSZWRoalV3?=
 =?utf-8?B?c0ZHQWRaSVZaNjJnUWI0bEFyMmxvRkIzcHhveVpXQWgvY050M3VqeXRxcGdR?=
 =?utf-8?B?dHExTmYydWpUYy8zQ2NSKy9JU2tFYVYreFV2YjJBZHNzM3pUKzdaaXF5a2RX?=
 =?utf-8?B?Z0NRcWlDbWRLM2JVTU9WM0ZNVUhNSzNqeHhXczRySGVSMGJGemFISm5scGVm?=
 =?utf-8?B?Z2NJampHWGtZcUFhaGNFYUZkMy9laml3R3V3WjZYdXFUMTJpSUx0M0hxeUUw?=
 =?utf-8?B?dXZKMzVia3ljUFVpOG1qbGtsblltU1NEQWcxTVc4eE53UFNoM21YWlpsNTlD?=
 =?utf-8?B?eFBrVUFZa1l5OHRuR1NKVTJ4a29OUGZLaDdCZ0hTV3hOb0pCQzM2dEdTWk1z?=
 =?utf-8?B?b3Zlek5qdzBNeC9uei9ISERuRFhBTzgyZ3dvQjVPN3psTjNDR1JuQmJDL0VH?=
 =?utf-8?B?QUk1L1pXemlHMnF5T3MwNmo0V0RLa0FvUnB4Q0lLQWNkd3RNR3U1NEUrOXBU?=
 =?utf-8?B?YUdLc1ZxUnYzblF5R0lYRVhSNG1ZdThVdHpYaWVZQnJxQk5NOTZLTGVYN3Yx?=
 =?utf-8?B?MjBBRjFLbjF1UmJXZ08rNmVKNC81U1k4dE1JZkhkYmpPOVhmaCtKb1V3VytW?=
 =?utf-8?B?YWVRUWsyZE1WdWJQZldDSytlZVIxSW1MQ3Q5aVcyRUttL3Y2Z29GOC9oaFJp?=
 =?utf-8?B?ajY4L1JhNGZYNHcrblNMTmRjeGN3VW11VGdsNEp4aDVlZmF6TE12dUF3Rmg1?=
 =?utf-8?B?RStpbUtyeWNlbUt4L3RrS2dvS2hkQnZzSEgyWUVNWEpHeTR4STNEa1Q2dEJt?=
 =?utf-8?B?YzAxUEFOSCtuYnU0SUZPRWNyUWQ4S1hhTWpOazBqZWhJN2N5NDV5N3dyWjNk?=
 =?utf-8?B?ZEVrZ0xkTEw1a2lzYWdOT1h3T3AyRkh1SE9aRGpyM1NpT3AwUS9SYi96Nkdx?=
 =?utf-8?B?ekpUVE1vYjJVTHgwcWNUYkdlMmYyckV3WWFkMkQwdEF4eW5MWUpUS01GWUta?=
 =?utf-8?B?bzZDNEV3cWY3M0VPYVkzaE1kODE1OVptTUp6QllQYzNseDllYWlmMWk0d3Zu?=
 =?utf-8?B?N1BPOVBDK3ovWnFPVGRQMDBFL3BJaldhU3J4anVCQm11Tm5MSGpGMDRMYTI5?=
 =?utf-8?B?NHpYZWJ1dnVNOENyWTE4aGRsd3NXTlcrWDZnVjZPWDJ4L0lWWHFzUGFpVDJu?=
 =?utf-8?B?KzJydTVSYThqb1E3SlAvendxT2hab2MzZWQrSWMyc0tPTFEycUxWWnRFR2Ev?=
 =?utf-8?B?dm5Wa3pud1ZrZ1E2MEZieFZaOEkrc1FBZ0FmenZ0MjNSTDhTMGJRbDVLYm1z?=
 =?utf-8?B?NXhpRFRKeitUZ0xvWndZbzFvZWVRbVZJTjROcm9Lc0xseTR1aGt4bjBtRkph?=
 =?utf-8?B?RDNTUk9IVTNoRWVWdTRTUDVoOUxtVU9zakVkWnZ4Q0VGdGVVUjJ0em9LZ3RG?=
 =?utf-8?B?ZDJJNW1vMnludHQ1TW5ZVzA4Wmp4MjhzK1ZIQzRVY1BRbk5jTWx4NHhneFpn?=
 =?utf-8?B?VUgrenJBbUpZaG5OZU82a1J1OVl1OUY2dDFiMHZiQ3lDRW9ETVM5QUo5Mmpu?=
 =?utf-8?B?ZXFMQk0yWnFUTGcrNWgyV25pNWlWWWlGSEpScEpBd1U0N2VOU2NTV0cySzNa?=
 =?utf-8?B?VisrUTJ2UGtQSUw5ODFtZ1RxZ0RkMlhxSEpvOGRFazZhTkVkeDNTVTI1RGJZ?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFA1CB62586D0548A4394674A39C01CC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c85a09-e388-4ce4-cd15-08daf7a7ed62
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 09:56:24.0464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1h1lDc+UnSHa//ugkhF0b4niF6I+urM/5d0WnPeqYxnHnUYtQrsR3Qxz8tAuK9dXfn/Ommq6YDa5hzKutRAaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6610
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

T24gTW9uLCAyMDIzLTAxLTE2IGF0IDEwOjE3ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNi8wMS8yMDIzIDEwOjE0LCBNb3VkeSBIbyAo5L2V5a6X5Y6fKSB3cm90ZToN
Cj4gPiA+ID4gKwkJbWRwMy1mZzBAMTQwMDIwMDAgew0KPiA+ID4gDQo+ID4gPiBOb2RlIG5hbWVz
IHNob3VsZCBiZSBnZW5lcmljLg0KPiA+ID4gDQo+ID4gDQo+ID4gDQpodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9kZXZpY2V0cmVlLXNwZWNpZmljYXRpb24ucmVhZHRoZWRvY3Mu
aW8vZW4vbGF0ZXN0L2NoYXB0ZXIyLWRldmljZXRyZWUtYmFzaWNzLmh0bWwqZ2VuZXJpYy1uYW1l
cy1yZWNvbW1lbmRhdGlvbl9fO0l3ISFDVFJOS0E5d01nMEFSYnchZ211SUlrOXBIVEVHY1ZUdE9Y
TmVQM2E4WFV1Y29pVGQ1dlRteE5LOGxDSHR5dFJEYzNSOEVoNDRXT1dORVVrSmx2X3BQQ3RnX0R2
UENIc0NITnNjZzZfMGNmSmUkDQo+ID4gIA0KPiA+ID4gIA0KPiA+ID4gDQo+ID4gPiAiMCIgc3Vm
Zml4IGlzIGRlZmluaXRlbHkgbm90aGluZyBnZW5lcmljLiBEcm9wIHN1Y2ggc3VmZml4ZXMNCj4g
PiA+IGV2ZXJ5d2hlcmUuDQo+ID4gPiBEcm9wIGFsc28gIm1kcDMiIHByZWZpeCBldmVyeXdoZXJl
Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IEJlc3QgcmVnYXJkcywNCj4gPiA+IEtyenlzenRvZg0K
PiA+ID4gDQo+ID4gDQo+ID4gSGkgS3J6eXN6dG9mLA0KPiA+IA0KPiA+IE1heSBJIHVuaWZvcm1s
eSBuYW1lIGFsbCBNZWRpYVRlaydzIG1lZGlhIGRhdGEgcGF0aCB2ZXIuMyhNRFAzKQ0KPiA+IG5v
ZGVzDQo+ID4gYXMgIm1kcDNAeHh4Ij8NCj4gDQo+IE5vLCBiZWNhdXNlIGl0IGRvZXMgbm90IGRl
c2NyaWJlIGdlbmVyaWMgY2xhc3Mgb2YgYSBkZXZpY2UuIFNvbWUNCj4gbm9kZXMNCj4gYXJlIHBy
b2JhYmx5IHF1aXRlIHNwZWNpZmljLCB0aHVzIHdlIGRvIG5vdCBoYXZlIGdlbmVyaWMgbmFtZXMg
Zm9yDQo+IHRoZW0sDQo+IGJ1dCB0aGVuIGFueSBwcmVmaXhlcyBhcmUgYWxzbyBub3QgbmVlZWRl
ZC4gSWYgbm9kZSBpcyBpbWFnZS1zY2FsZXIsDQo+IGl0DQo+IGlzIGp1c3QgaW1hZ2Utc2NhbGVy
LCBub3QgIm1kcDMtaW1hZ2Utc2NhbGVyIi4gSWYgbm9kZSBpcyB2aWRlby1jb2RlYyANCj4gaXQN
Cj4gaXMgbm90IG1kcDMtdmlkZW8tY29kZWMuIGV0Yy4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9mDQoNCkhpIEtyenlzenRvZiwNCg0KQXBwcmVjaWF0ZSBmb3IgdGhlIGV4cGxhbmF0
aW9uLCByZWZlciB0byB0aGUgZ2VuZXJpYyBuYW1lcyBpbiB0aGUgbGluaw0KeW91IG1lbnRpb25l
ZCwgY291bGQgSSB1c2UgImRpc3BsYXkiIGluc3RlYWQ/DQoNClJlZ2FyZHMsDQpNb3VkeQ0K
