Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB2666D71A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjAQHnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbjAQHne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:43:34 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E66F23DA9;
        Mon, 16 Jan 2023 23:43:25 -0800 (PST)
X-UUID: 9bce0206963a11eda06fc9ecc4dadd91-20230117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NFJ2lEHQgQOIWZp3bVfO9mMDEfQOOetA6+btPAI/W6g=;
        b=gvlvaYg5uWjHkh2RCIMjLlnYSNCisboBt1/HN8XQsKjvxCU10WTEUD+zdI57kse8qzwSwR1L1oxS8A9TWpnCbZTb5rKmsd7Gaxvvx64zhLiEIxPz5QoijC3qv0C9SYsUgqC9bl3T4/NBSgVIT3l/p65xajYGTP7i4QI1qIQSoF4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:5f27cfe0-8594-4209-aea2-8b3251c4a82a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:a0ca09f6-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 9bce0206963a11eda06fc9ecc4dadd91-20230117
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1487513168; Tue, 17 Jan 2023 15:43:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 17 Jan 2023 15:43:17 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 17 Jan 2023 15:43:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivSi0u4xHfG29bSYwfP8oZAzCXxhoKE9CAkL14wSB29u2pFstIDOUNyZFSo8tDSyIIi4GhQ20np6e1EST9INs2zb1IhLcpzqlqiZp15yUp78QNtXn9jUGePs1QpIc3m+cYD6KDs/81IFIykpeTiPiOj0vdyrsyzpIGwE4xtqS1/8jC22K9m9rNMf794sr3VfoTaGeEAikkpNDeY4MdybamrrPfr6UROapoopp29x6C8vILY9eTE9aJZFRTauSmYBC6Vny72AVr7CiHN+Ujpvv09TpYmBlfh8MnrH3awE+dGbYRosNdooeoK9RS2nN5hvxEwIPsB0L1Ic1Ej990yGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFJ2lEHQgQOIWZp3bVfO9mMDEfQOOetA6+btPAI/W6g=;
 b=h0wsJtMdxROIX3f7NKvy7ojh8r4974z4ra3cvDXl1EZJDdqBS0BaGX6VaYqhUtmjPJOGWchM+Du5B9230XzMA1M/1ISzg0FCBuV5VU+Y+Z0tSpDUKLOiEiZsDMpODFtLbxFwWNuzuc//MK3mrEdfsJ9mJTtF1q8xqObGW98LlhVgJnywOHqlOMG0F/88W+gJoXfLR2XqKv57cMjr/K0EKYoZP11usPMTMb+TjnxPR2gh0sH5GN8jgaWzcWVpH2lpUTALm08LICNy6CelkigaBqKZz4S7qs0JZ8bDItx7cM8ckW0d2W7MMPJA4d5GUdXURLxl3RKCDG3gKL8ty1BsXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFJ2lEHQgQOIWZp3bVfO9mMDEfQOOetA6+btPAI/W6g=;
 b=n1AHlSbILQq0CYfDL7kMHGy/2Cu+ZnAcm5vi4uOP97e64rcBKVut3cTZkm+lmO/TPTN6YuF2KsgNwkzGD4HbcmXBCkpQZ39VPuD9doXVpBuum0hpphODAFztAgAa23hkD/fwz3b+86+lBxbk6RnvYtfX4rLj5x7IzaCLtlfqJs8=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by KL1PR03MB5666.apcprd03.prod.outlook.com (2603:1096:820:7c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 07:43:15 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dbe7:4943:de9b:bc96]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dbe7:4943:de9b:bc96%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 07:43:15 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        =?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>
Subject: Re: [PATCH v3 00/11] Add support for MT8195 SCP 2nd core
Thread-Topic: [PATCH v3 00/11] Add support for MT8195 SCP 2nd core
Thread-Index: AQHY0hy9crJzPFm6uEajaBvXSO+J6K4qwCuAgHgqUIA=
Date:   Tue, 17 Jan 2023 07:43:14 +0000
Message-ID: <e212a9be095704ec1a69b4368a4070811e85524b.camel@mediatek.com>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
         <20221101204037.GA1656603@p14s>
In-Reply-To: <20221101204037.GA1656603@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|KL1PR03MB5666:EE_
x-ms-office365-filtering-correlation-id: 64a65036-28a8-4a44-1721-08daf85e7dbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H5h0OgejCOoM3HLvGAsfPULJUjFhA98Bdr6qbxd5VBLiQKKCse4tzNdGPX2wvr9OlDRiWR13uYipBiR/HCfwKoGywRZmlvZivSF5fr3t9sig4LgvB/bfZszrKqNBcMP4z7myuZZ1CqVDYwxwORR/7sqE0DXsc8j4IiuvYv12+SDBPZUpKdofTFHIED/PyJvFIPXAYm98WdpIXgOOmGZAwZryM2q9yHerArRPwHGyYzFcH6c5qVAHBdsR5SOkCq8Bkce09PEsqGrgU6zRYtVIt9oA0Ydmz6f00IU3PT5E3s4cm1+Cf5sAtAO/w+kVozGsA/E9Z3/KtwWeZO1P4mn+ctX7Qtwx8VE+J1KzDXmpASFNtlnAZAW4d0r/mhRAw74m2WPvWt+ZrztSGI+5ZTgUbwYMafjJWkWZL30j0UYylZpukhdCqbVSueLVLa+F+f18HwfqACi4Pw8GTieMHPzzJirll9QhOraac0iDYTKYL9UmNCNGzHs7yzmNX0bKdYWK9A0TSBxN9nA4KEo4hVJAmPQtV+0DPMwcGxMQYAgy3L6MIOj65H7q/9jLeVMSY50PMCddcFr6OpUHtfvxNxnyd8L7kRwwDLJv3ZKwk1Hm4CV2FYPfozzMwFmCBbKawGxGHMlzehXoD2XFrR0kXrzo5mQNZ/XRXYrCQJOhNdSfr/fehSzWEdnQ/YUyEk4WPdb0WydSh+5VqOJxjw490bHYO0SyqvjXcOJQq5flb6zjIAmyqiGRvHhY6Wz256YIHoBa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(2906002)(54906003)(107886003)(41300700001)(26005)(6512007)(2616005)(186003)(316002)(71200400001)(6506007)(64756008)(6916009)(91956017)(66446008)(86362001)(66476007)(4326008)(8676002)(83380400001)(66946007)(8936002)(76116006)(6486002)(5660300002)(478600001)(7416002)(66556008)(85182001)(38070700005)(36756003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmJSdGRtRElGd0krWTU5bld3WjdkT1RXcHRWYW9yM1BZbFdZbkxIUCtJNUl5?=
 =?utf-8?B?ajFCU1FRQk85SDhTVVhUNERzamk1TGNKNU9QamNud2NCU0JjQzZmaElqdyto?=
 =?utf-8?B?S04zS0o5WVhVQWtaM1RlakdUb2JHMzRMQ3g2MTFCVzNCSlE4KzQ0NzczU3Ji?=
 =?utf-8?B?MktvdWp3MzE4WXVnckRuOHhqL2xzY3loS0Rsb0RPdWN1QVo2Q0NRM2NYaENs?=
 =?utf-8?B?UnRjY0o5NEE5MHM5dm9xcXRoSDR2VFZhYlpZNGtsVDU1M2REQTY1b1h6dU1x?=
 =?utf-8?B?bDQwR3Bqd1NaY1BpUTRacHRWREZFVU1SZTNJWW1tNVdwYnhqOE9OMlVnenRl?=
 =?utf-8?B?VXZac1dkc0gzVmM4czhUNUwzS2V1SDVUQlZDSk9odFUrY1czRjBSZGZ2RlhW?=
 =?utf-8?B?NlIyYTUydy9oK1dySXFac2VkK0dIUXFFd3hVOCtvYkZYeGl0NVZpTFFnSWlD?=
 =?utf-8?B?cnRlcHlVTGxVWHE3TWplaDlNRmFMU3FWRlVLR2VBTzRaeG5MOFRwZE9qd0w0?=
 =?utf-8?B?R2Y5cEtITUtrMVpzUTZvM2VCWjQ1TXgrbUFGcHdpSGFHVGtaRWRnZ2JaWFJ1?=
 =?utf-8?B?bUdqUnZyM3FwQ0kxK2Z0TFQzZEM3bFFmVGJIMGVnRVFZUTQxYW5UV1VFZkpM?=
 =?utf-8?B?UDNzQXdpaUppL2RkQlZkRnRQanV5czZEWHJBSnRyOU5FR2Y3QVhsOVJ5b2U2?=
 =?utf-8?B?K0I1cEZrQkc0NUlIdzliTEI3dk5NczVRb2ZDb0FwN1dXYWhlaFJjUG43ZjZx?=
 =?utf-8?B?YW9KSmZmRlBrcjg5cFhWV1h3d1lKZGd0WVRmczhadEJpdE15MzhoRUR0K1dm?=
 =?utf-8?B?R0xHY0NJVGlybS9iRkMvMVFZRGJvZ2hmTUE5Nno1eS9KOTdqT29tNndyUnM1?=
 =?utf-8?B?NUFwcVBZajVaUFJEYldSaysvREU2SE1tMkxpaXdIWm42Q3JJWDVudnRXc2Uy?=
 =?utf-8?B?dVlRUDNxVTg3clliTWtQRnBtS1hFRlh2RDhaZlBiOFZMUk1rK2NDTjJmM1lQ?=
 =?utf-8?B?OG1hY1lId2pjNVZRWUtQMUE0YXcxcXR1WGtTVHdUQ1dkckFHdXJMOUcxaVFp?=
 =?utf-8?B?OHdacVNGQ0QwMFZyVm1icXpQa1dBeG5jQk5UTUpQVjZqVUIxcTVsM0o0dDVO?=
 =?utf-8?B?Wk5yQURVdXNMM2JlNENYaUxGVVU1NERMTlVhZlh1K1RrV3lNWGRsb21GOTNZ?=
 =?utf-8?B?NmNXbkNkalhYV3lGNTVjMEY0b1UzWUxCZkR1K0V2MEFDZ0E3MWpGbEJDRmFG?=
 =?utf-8?B?Z21LUGQxeGV3MXY5Vm9uc1lFbExIWnY5YmRYdUtwUjFlVmE5OHp2TkxPRnNN?=
 =?utf-8?B?TDl0RUsrZ2tXeElSNi9UMkVxQmtnVzBOUXd6T1c5czlmMDNlVnMxNW5rYUdn?=
 =?utf-8?B?bVhIandTU3liMzFKZ2VwT0FiSGV2RW4vUE9OWWo1VjVaa3htaVNFcnhpaytI?=
 =?utf-8?B?ZnlmUlJxbUVNWkRNcWpGOCtRZElaamg4SmphMzlvS29jbmRHRzNXbzh0TVgx?=
 =?utf-8?B?ZjBjMnU2OU4vR25Nc09vT3lzVXkxTGFHcmVDcnlzUUZKVW5nNzVsRFpzVWRS?=
 =?utf-8?B?Q3BVMGJRZCsyU202UWRyOTJnbzJ6VkpvM21MejFWMkRheVV0MXJHOG5Yc01z?=
 =?utf-8?B?ZmRHNVRuN0VIcmNWRmtzczVFY25oRUVqRGV2MjBBUWJyajcyQlhXdXJxM1Nn?=
 =?utf-8?B?RVFMcW9taWRwNU9MRjNoYmFaRVREeFEvTjFOTlM5a3E5aDVRSHJjZ0VTbE5U?=
 =?utf-8?B?T0hyUGJyb0NpRDVmVWNEYVdxVzc0OFZCc01qRUx1UU1KMk1pMnUvdDNFNnVK?=
 =?utf-8?B?OGJRdEt3RERQQjJ5Rm9xVVBHRlZQZGpZcmFSM1ExV0Qxc3liRlJzSTB1cTRa?=
 =?utf-8?B?dkRVS2RxRUZaZ0tNWlR5aHhRQ2kvc1JVRUl1Y1pZWEo3bUpBY2VTOUxlL05p?=
 =?utf-8?B?U1NteHRnQ21VNmdCdmR3YnI3S2M1UTZKVnF4eDBwNENTV0lPa1BsVEJ6SjVw?=
 =?utf-8?B?UGd3cHE5Sndkb2NJWVFldUZjQldQSmd1SmZsWThGcVNpZW92RDd2bTFQRWxD?=
 =?utf-8?B?UXV3Tzkxc25nY3VnTHgzaDZvaWFGVUt3YjNvbnhWL1hUSmhwRExHT0pPMUow?=
 =?utf-8?B?aDJSOGQ1alJxSDY2UTl2dmxKemRXWHVYNFI5Yzh2bnM0WkY1aDRJejdPSmp2?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECC287AE0C58284B917C33363843ECA5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a65036-28a8-4a44-1721-08daf85e7dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 07:43:14.6323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QezXO7xv1EYTdckIDjf7z+pbdb/QLzxgLsJHtGEeNYtxpuxVMY1Vajj0K/3X1iMVZp86Zc/WWr6U4JGDxdBdFYerAPtt4P4SzUgsqpCgpYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5666
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTAxIGF0IDE0OjQwIC0wNjAwLCBNYXRoaWV1IFBvaXJpZXIgd3JvdGU6
DQo+IEdvb2QgZGF5LA0KPiANCj4gQSBsb3Qgb2YgY29tbWVudHMgcmVsYXRlZCB0byB0aGUgaGFu
ZGxpbmcgb2YgU0NQIDAgYW5kIDEgaGF2ZSBhbHJlYWR5IGJlZW4gbWFkZQ0KPiBvbiB0aGlzIHBh
dGNoc2V0LCBhbG9uZyB3aXRoIG15IG93biBhZHZpY2UgZnJvbSB0aGUgcHJldmlvdXMgcGF0Y2hz
ZXQgb24gaG93IHRvDQo+IG1vdmUgZm9yd2FyZC4gIEFzIHN1Y2ggSSB3aWxsIHdhaXQgZm9yIGEg
bmV3IHJldmlzaW9uLg0KPiANCj4gVGhhbmtzLA0KPiBNYXRoaWV1DQoNClNvcnJ5IGZvciBsYXRl
IHJlc3BvbnNlLg0KSSdsbCB1cGRhdGUgdGhlIHNlcmllcyBiYXNlZCBvbiBhbGwgb2YgeW91ciBj
b21tZW50cy4NClRoYW5rIHlvdSENCg0KPiANCj4gT24gVHVlLCBTZXAgMjcsIDIwMjIgYXQgMTA6
NTU6NTVBTSArMDgwMCwgVGluZ2hhbiBTaGVuIHdyb3RlOg0KPiA+IFRoZSBtZWRpYXRlayByZW1v
dGVwcm9jIGRyaXZlciBjdXJyZW50bHkgb25seSBhbGxvd3MgYnJpbmdpbmcgdXAgYSANCj4gPiBz
aW5nbGUgY29yZSBTQ1AsIGUuZy4gTVQ4MTgzLiBJdCBhbHNvIG9ubHkgYnJpbmdpbmcgdXAgdGhl
IDFzdCANCj4gPiBjb3JlIGluIFNvQ3Mgd2l0aCBhIGR1YWwtY29yZSBTQ1AsIGUuZy4gTVQ4MTk1
LiBUaGlzIHNlcmllcyBzdXBwb3J0IA0KPiA+IHRvIGJyaW5nLXVwIHRoZSAybmQgY29yZSBvZiB0
aGUgZHVhbC1jb3JlIFNDUC4NCj4gPiANCj4gPiB2MiAtPiB2MzoNCj4gPiAxLiBjaGFuZ2UgdGhl
IHJlcHJlc2VudGF0aW9uIG9mIGR1YWwtY29yZSBTQ1AgaW4gZHRzIGZpbGUgYW5kIHVwZGF0ZSBT
Q1AgeWFtbA0KPiA+IDIuIHJld3JpdGUgU0NQIGRyaXZlciB0byByZWZsZWN0IHRoZSBjaGFuZ2Ug
b2YgZHRzIG5vZGUNCj4gPiAzLiBhZGQgU0NQIGNvcmUgMSBub2RlIHRvIG10ODE5NS5kdHNpDQo+
ID4gNC4gcmVtb3ZlIHJlZHVuZGFudCBjYWxsIG9mIHJwcm9jX2Jvb3QgZm9yIFNDUA0KPiA+IDUu
IHJlZmluZSBJUEkgZXJyb3IgbWVzc2FnZQ0KPiA+IA0KPiA+IHYxIC0+IHYyOg0KPiA+IDEuIHVw
ZGF0ZSBkdC1iaW5kaW5nIHByb3BlcnR5IGRlc2NyaXB0aW9uDQo+ID4gMi4gcmVtb3ZlIGtjb25m
aWcgZm9yIHNjcCBkdWFsIGRyaXZlcg0KPiA+IDMuIG1lcmdlIG10a19zY3BfZHVhbC5jIGFuZCBt
dGtfc2NwX3N1YmRldi5jIHRvIG10a19zY3AuYw0KPiA+IA0KPiA+IFRpbmdoYW4gU2hlbiAoMTEp
Og0KPiA+ICAgZHQtYmluZGluZ3M6IHJlbW90ZXByb2M6IG1lZGlhdGVrOiBHaXZlIHRoZSBzdWJu
b2RlIGEgcGVyc2lzdGVudCBuYW1lDQo+ID4gICBkdC1iaW5kaW5nczogcmVtb3RlcHJvYzogbWVk
aWF0ZWs6IFN1cHBvcnQgTVQ4MTk1IGR1YWwtY29yZSBTQ1ANCj4gPiAgIGFybTY0OiBkdHM6IG10
ODE5NTogQWRkIFNDUCBjb3JlIDEgbm9kZQ0KPiA+ICAgcmVtb3RlcHJvYzogbWVkaWF0ZWs6IFJl
bW92ZSByZWR1bmRhbnQgcnByb2NfYm9vdA0KPiA+ICAgcmVtb3RlcHJvYzogbWVkaWF0ZWs6IEFk
ZCBTQ1AgY29yZSAxIHJlZ2lzdGVyIGRlZmluaXRpb25zDQo+ID4gICByZW1vdGVwcm9jOiBtZWRp
YXRlazogQWRkIE1UODE5NSBTQ1AgY29yZSAxIG9wZXJhdGlvbnMNCj4gPiAgIHJlbW90ZXByb2M6
IG1lZGlhdGVrOiBQcm9iZSBNVDgxOTUgU0NQIGNvcmUgMQ0KPiA+ICAgcmVtb3RlcHJvYzogbWVk
aWF0ZWs6IENvbnRyb2wgU0NQIGNvcmUgMSBib290IGJ5IHJwcm9jIHN1YmRldmljZQ0KPiA+ICAg
cmVtb3RlcHJvYzogbWVkaWF0ZWs6IFNldHVwIE1UODE5NSBTQ1AgY29yZSAxIFNSQU0gb2Zmc2V0
DQo+ID4gICByZW1vdGVwcm9jOiBtZWRpYXRlazogSGFuZGxlIE1UODE5NSBTQ1AgY29yZSAxIHdh
dGNoZG9nIHRpbWVvdXQNCj4gPiAgIHJlbW90ZXByb2M6IG1lZGlhdGVrOiBSZWZpbmUgaXBpIGhh
bmRsZXIgZXJyb3IgbWVzc2FnZQ0KPiA+IA0KPiA+ICAuLi4vYmluZGluZ3MvcmVtb3RlcHJvYy9t
dGssc2NwLnlhbWwgICAgICAgICAgfCAxMzIgKysrKysrKystLQ0KPiA+ICAuLi4vYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLWt1a3VpLmR0c2kgfCAgIDIgKy0NCj4gPiAgYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaSAgICAgIHwgIDE0ICstDQo+ID4gIC4uLi9t
ZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19md19zY3AuYyAgICAgICB8ICAgMiArLQ0KPiA+ICBk
cml2ZXJzL3JlbW90ZXByb2MvbXRrX2NvbW1vbi5oICAgICAgICAgICAgICAgfCAgMzUgKysrDQo+
ID4gIGRyaXZlcnMvcmVtb3RlcHJvYy9tdGtfc2NwLmMgICAgICAgICAgICAgICAgICB8IDI0MSAr
KysrKysrKysrKysrKysrKy0NCj4gPiAgaW5jbHVkZS9saW51eC9yZW1vdGVwcm9jL210a19zY3Au
aCAgICAgICAgICAgIHwgICAxICsNCj4gPiAgNyBmaWxlcyBjaGFuZ2VkLCAzOTcgaW5zZXJ0aW9u
cygrKSwgMzAgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gLS0gDQo+ID4gMi4xOC4wDQo+ID4gDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVGluZ0hhbg0K
