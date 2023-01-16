Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FC966B5BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 03:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjAPCtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 21:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjAPCth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 21:49:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1142D728E;
        Sun, 15 Jan 2023 18:49:35 -0800 (PST)
X-UUID: 668713be954811eda06fc9ecc4dadd91-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jCb3bRSh04kRbsbK6tOttRD15lIzn+Ernm/BYZoE0Rs=;
        b=XwZnyIyKYBoOgNDZ/ppeI77CmQ8GQDzKKyTnMv+GFq/M2O8KCOeSIrNOlUgr8GbZsvTY1IEQrTFrH4SgaOB8wdj8/7MDZpeQD1jzkP6SYB6DTYyR50XlHncGdv0vRIVVb1RcKAozCH3haSME71uo0uvsg3eYGOuQbNsM++LCTlI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:39b4064a-fb78-45df-8faa-5eb9d2459c37,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.17,REQID:39b4064a-fb78-45df-8faa-5eb9d2459c37,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:543e81c,CLOUDID:f278e3f5-ff42-4fb0-b929-626456a83c14,B
        ulkID:2301131959552AUAILSZ,BulkQuantity:9,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: 668713be954811eda06fc9ecc4dadd91-20230116
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 61784185; Mon, 16 Jan 2023 10:49:30 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 16 Jan 2023 10:49:29 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 16 Jan 2023 10:49:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJ6wglwG+JVmhXY/dbWLbYGFi6KYNHDHjKlOgH1phQjZGMKnpbliQ2tB18N3wfD5j6+tl1q4s1hGo8JvWZZeivc89urXPKoCIIcrcGsA0l0t9X+hSe2f8NlzzhzU9nWfHU5VARgneSyaKjXEaMxmqwJl/2wgXnIQHF4Re8M43xGTr8ocMZrcwx05H2fFJAwz3l7u0STbyiXX2phZPoiazMSKrwzF54T1CcHRGD3jQXbU4P9ROj9AgZAhJW2zA0Sw0fIX35acpPiTYGVAxe01NIaQolwFrP6bgUO8DmMwSpkUu/aQd0e0bTmT+wEzuBQPqAni/wGEg8Fjvw5BdtnkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCb3bRSh04kRbsbK6tOttRD15lIzn+Ernm/BYZoE0Rs=;
 b=glrHksGm8y+lTzJLMlmchFbOJcuB3kbA/EOuoGShStKryh4MKX5N4C93yQMyl0e6iQ2nH3Qq5TKp2vv3mzm1U7pVLU3OOMGM6pHElChM51OU8+UHB7nSGpGrt3OXdKbHhBvG5YnbESCxgIZ4r1wBHulSfzmAmhAaAw1OlzYchLJaPrDUCitNp6oFac8ZQ66bk5BFr/oJwL6MmFKgCN5o2uUHnTSxk+fJWbZo6KZFsvIoekmdhVEDgnM+fx2xcWNJlbmhngGZEG1Z14hNpsSbk4jtnTHPmR5eUxwJItrbNWh7m1SZZq0v5BfhFqdwNmvGwT8vP/H2j5qWQjPPllx/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCb3bRSh04kRbsbK6tOttRD15lIzn+Ernm/BYZoE0Rs=;
 b=vNC03rG7lhyxscAkfDzoUf7iy+ES2dFPOUI8/PTjQjXA1M3evV0s4G3xu1gu4hDi9eWGuHvhY/gBMC4BL/appwRyNPmnyGvHApxzzcah2EoKdAgK3rfSCOJwFJfsc99/RWI0j+jtg8dc9G3Smz4I1wkz1l1FPXUJKWtJdb09BSQ=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by KL1PR03MB5618.apcprd03.prod.outlook.com (2603:1096:820:3b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Mon, 16 Jan
 2023 02:49:27 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d%4]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 02:49:27 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v5 02/10] dt-bindings: arm: mediatek: mmsys: Add support
 for MT8195 VPPSYS
Thread-Topic: [PATCH v5 02/10] dt-bindings: arm: mediatek: mmsys: Add support
 for MT8195 VPPSYS
Thread-Index: AQHZJxHqN7EdSO15vEGirGp2QiEpdK6cPu6AgAQdOAA=
Date:   Mon, 16 Jan 2023 02:49:27 +0000
Message-ID: <4e638f60bd316104be8bb110d22dcb17e05fc6a4.camel@mediatek.com>
References: <20230113054304.21841-1-moudy.ho@mediatek.com>
         <20230113054304.21841-3-moudy.ho@mediatek.com>
         <d16ed246-86b3-7837-845d-ba33dd61b482@linaro.org>
In-Reply-To: <d16ed246-86b3-7837-845d-ba33dd61b482@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|KL1PR03MB5618:EE_
x-ms-office365-filtering-correlation-id: 6181d919-7d17-469f-1183-08daf76c488e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spopha5KsoRXDOjhwKzndir4fbUNPi9uZrFyJRs+KqhRzqnH/OtQM+zjLJqzCkhJCSnH0kBnY9Bo4VbNClw2Npw8aj5RDuSIGJU2hCix+RU8lp026vj8PTKbblENETZd/KpilN/Uio4VCYWaegypimrRXga1Il7ihvVr1o6/R/CaK1oRkqLc+FE7hj3piyJbGhuJA1dRzv/tsHTJoco5f34yuAANWkv6SvOoVYE0oLKTMEiAz4bz8gbQuiB38flkvwU7E53i59GLG8b9yiI0v7mckXXkvmBBxBlM3xsTZJ991sSB9U6Q8cI9VYxp7gtBrdfxG2CoN4O2djMyWlV/CosrgVb4vboCNE3pkOH9zgl/BU0/Konb/Y5lQRBQGKKGoc1ZOYaS9V2wdhICJXvhCsFWkfbKtluDBp8g77p4eXmYX9BN5AwWghzUPrpUubcghRaKXdGRl/bQeDT77ADaszz1bYYBL03KIdO8r/9UbPEeIr3mr6LAB0t7e4L4Vxxm8+SkSn8oxcEW3RV+/kWFvri8JjFDXHKYrTVUDxAq9nCfnB8poCAZSeLeCMSip0mcnyfQfAj+dWIMeeeLdZBcREn71KaZGTsLqC97USsXL8sibfeZRKgD1zBxdD9zI7hKmli1zjBE+1pFcaVFofeZeY0+4sLeudP7RX5QxicCxtSmy709BAdPwmItlgwhcVF93tSwFYhxpkDUydaNaw//rWT5PVfKVKKupBfmYQTMH84=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199015)(38100700002)(122000001)(41300700001)(38070700005)(7416002)(86362001)(8936002)(5660300002)(2906002)(53546011)(6506007)(66446008)(64756008)(66556008)(107886003)(6512007)(186003)(83380400001)(26005)(316002)(66946007)(66476007)(110136005)(76116006)(54906003)(4326008)(8676002)(478600001)(71200400001)(2616005)(6486002)(85182001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1JNcUxlMDZTTk5KTUdZdXV1UWl5SXBmTnc3Smh6SnRUQlI1RG9jWXBOSjBs?=
 =?utf-8?B?cm9pMlZLYW5UK2JkMkVKc2ZOT2lvWnVXdERRWDdxaS9UTnd6N1BzS3RPNkxo?=
 =?utf-8?B?Vkx1UUNsbEx0NlRkVmwvVGZMdksvR0JUeWNOTU45TTU2ZGs3K2FwNDlCQjBI?=
 =?utf-8?B?MXVnaUpMVTRpdXY5OGNlSnFKSUYzZ013anBRTGVuNzh2TThCTS93Wno4Njg2?=
 =?utf-8?B?ZXZTTXVtNmx6cEFKa3RHbDFpV1JHa2FlbU1ETy9iUDRGTlhvYUhQK2UvbFBV?=
 =?utf-8?B?QmovYmg3VGR6elZ0S0dOVHV5Z2NBY0ZxUHZ0a21zbStuQ1Y3S3RxZ2N2bW1O?=
 =?utf-8?B?Vi9kS2hGN2x0L0VPZ1cvVUx1SGJVOWFuU3FKYUk3OHZVNUp5eHVFcmlmc3E0?=
 =?utf-8?B?WVBIZlJMV1ZrRjQrWDFwalg0LzRqbE5aVzlMUldHSDFjdndZM0JPSldqVzhR?=
 =?utf-8?B?ZlZpNUJkcnRwVUtMajBhQ09KdkhSL01KVnZmeGdYRzlMMXRtcnBlOXk3aFFm?=
 =?utf-8?B?SG1LdUw5Y25hck9zQVY4alFLN0RHSFVqMDRLZFU3bzAySUpkZnQzcWp5eVg4?=
 =?utf-8?B?ckZuTUlPUytaamhaUDN0WmxWaE1ienlUQ21rUlQ5b3o3anJmK0FXWG0zaDZO?=
 =?utf-8?B?WEIzaVF2WXFjL1NtU1UrWVZFNWEzbGFGdGdFZUI5eXQ1VWNZZzJ6QTlJeHdh?=
 =?utf-8?B?VTU5cVUyeGdmamZmWWxvdGhQcjBBVW5CdTVoaVBYV3crUEFTckF5WWRKQnA1?=
 =?utf-8?B?OFdMZk9rUGRHdnVaYUIvUGhCcDNrRWpyS1kyRUJidVYrcUlEcGwzOEREM0ZM?=
 =?utf-8?B?V1ZpUHphL0YrV2ZsMEk4aUg1dVljYS9LM0g3TE9UNnJFRkJpeHlJY1VrVTlw?=
 =?utf-8?B?KzhRUHJFYkg0d2hUZWsvK2txVlFyMWViNkJ4VUczYnQ1T2o1c1pWbTVQdWls?=
 =?utf-8?B?eHJGVHN3bGE4eHZtU01TVCtWRGtiZnIzY3g1K0tTTEFRaW5ORFZ1a0k2aHlz?=
 =?utf-8?B?NWp3a0N2cGtPN291T0hCdTJqK1VsdUROTnl4cWZobXF2SjAyeStzd0hoUXox?=
 =?utf-8?B?VlR3di9vTll6WVNMOTFBc01VYXpkR2t3RjQxOElmVEFtYTluaUJhb3hha0tZ?=
 =?utf-8?B?d1hTTVJ4NHpoWVZnK2h5MHFReWJQcDJYL1VrTEZzbm9iRkhtNmpZUkFmamVT?=
 =?utf-8?B?c1dTOEdCREcyKy9RaWcrc1EyQzVVd1V3K2hPcWJkbE1xdFVabTRlTnFsUHYz?=
 =?utf-8?B?bnJML2tXTlk2Z2svY1lYZWlaRUJUL09wdjBlVkxnbTJIMEwxUG83TkY1cTh5?=
 =?utf-8?B?Rit6RDlMR2VxTWswOC9SV3pSQ1pRalBRSms3OHNRTzRPUWFqaFVrdThvUEZH?=
 =?utf-8?B?bWdpQnFBVk4vN2J3K0FCTlVBcDVPUFJ6TjlQeE1LSHdqOW80K0xxbnZvalgy?=
 =?utf-8?B?MjhUZFZQMlJZSkF3TUVVaVRqVjY3U2NFVk10R2x1c3YwTUc1MnArcXZCUXpV?=
 =?utf-8?B?cDRxU0h0aHZaSmhxeUluTk5EWDlraDVHdUVNSmR5YjBMMVJwelQ2aEpubm5D?=
 =?utf-8?B?TUh4dWJWc3REVUtNL1BSa0crN2dCeFp1T05RUWlnRVJoMmVHUUpDdVc4b0hw?=
 =?utf-8?B?YmtITi9kMEt3dmcrU3lya09PYmUwWEEzc1ZGSzFlV2FxcGRqUzRHZDZIZDFx?=
 =?utf-8?B?QlhVY2cxdnl5TXR2OXFMcTExR3ptb1FiTWc2bVlYMmRYbTkwUzZOMHBMaFFL?=
 =?utf-8?B?OUw3U0c3K2tRV3NFSGdYR0lYaW5VejNYQTBXdjVYUlBYS1pnbEtCVlpLaG9M?=
 =?utf-8?B?Q3ZNSlZCYWNrT204d2EzYkxHTVV0MzZoOVF2Wm9yUVRSTnQ0ZkNIQVJrYVh2?=
 =?utf-8?B?NHJpbTNNVFNJeDJ4VmZsZ2tzTE9FbEFZVWxUVjFOZlo2YjQ1aStsUm9YVGpX?=
 =?utf-8?B?QzhYRmxmTXZRcU1VZEVpR3g0UXZmT0RySHNUWE5kTzY1SHIwYVdES3VVVWVx?=
 =?utf-8?B?NHdxUDFLQk1JN25la0dyclplYm8rbkQ3ZVVKaTdSZEZBYUw1bXZRWDVTa1kz?=
 =?utf-8?B?TDBSdWlpY1I2MS9TNkJRNERYamlBa2ZJa2RGSjhXQjdZeFZWZUdady8zNEY2?=
 =?utf-8?B?UjF6RStVTHF1MXZ5SVNacFF0VXh1ZHA2Z2Y3WURFWkdzcHlWdHNOUFZtS1BI?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B5B07B38F7CD34BAA594E796D1F7722@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6181d919-7d17-469f-1183-08daf76c488e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 02:49:27.1989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKPghNHkC+UgccHLor+ycS+XUlcny49CADyqVPiZH70g7wW8tR9pUJJjMIBqu5ifGuENK6b1E75tYyFs2/359w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5618
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

T24gRnJpLCAyMDIzLTAxLTEzIGF0IDEyOjU5ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMy8wMS8yMDIzIDA2OjQyLCBNb3VkeSBIbyB3cm90ZToNCj4gPiBGb3IgTVQ4
MTk1LCBWUFBTWVMwIGFuZCBWUFBTWVMxIGFyZSAyIGRpc3BsYXkgcGlwZXMgd2l0aA0KPiA+IGhh
cmR3YXJlIGRpZmZlcmVuY2VzIGluIHBvd2VyIGRvbWFpbnMsIGNsb2NrcyBhbmQgc3Vic3lzdGVt
IGNvdW50cywNCj4gPiB3aGljaCBzaG91bGQgYmUgZGV0ZXJtaW5lZCBieSBjb21wYXRpYmxlIG5h
bWVzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1vdWR5IEhvIDxtb3VkeS5ob0BtZWRpYXRl
ay5jb20+DQo+ID4gQWNrZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3ps
b3dza2lAbGluYXJvLm9yZz4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnlhbWwgICAgICAgIHwNCj4gPiAyICsrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+
ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlh
dGVrLG1tc3lzLnlhbQ0KPiA+IGwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMueWFtDQo+ID4gbA0KPiA+IGluZGV4IDg0
ZGUxMjcwOTMyMy4uMjdkMjYzMWQ0M2QzIDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy55YW0N
Cj4gPiBsDQo+ID4gKysrDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnlhbQ0KPiA+IGwNCj4gPiBAQCAtMzQsNiArMzQs
OCBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXZk
b3N5czANCj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1tbXN5cw0KPiA+ICAg
ICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MzY1LW1tc3lzDQo+ID4gKyAgICAgICAgICAgICAg
LSBtZWRpYXRlayxtdDgxOTUtdnBwc3lzMA0KPiA+ICsgICAgICAgICAgICAgIC0gbWVkaWF0ZWss
bXQ4MTk1LXZwcHN5czENCj4gDQo+IFRoYXQncyBicm9rZW4gb3JkZXIgYW5kIEkgZGlkIG5vdCBh
Y2sgc29tZXRoaW5nIGxpa2UgdGhpcy4gV2hhdCdzDQo+IGhhcHBlbmluZyB3aXRoIHRoZXNlIHBh
dGNoZXM/DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCkhpIEtyenlzenRv
ZiwNCg0KQXBvbG9naXplIGZvciB0aGUgdGFnIG5vdCBiZWluZyByZW1vdmVkIGFuZCB0aGUgd3Jv
bmcgYWxwaGEtb3JkZXIuDQpUaGVzZSB3aWxsIGJlIGNvcnJlY3RlZCBpbiB0aGUgbmV4dCB2ZXJz
aW9uLg0KDQpUaGFua3MgJiBSZWdhcmRzLA0KTW91ZHkNCg==
