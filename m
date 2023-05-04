Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E310F6F6317
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjEDDAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjEDDAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:00:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F1E73
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 20:00:24 -0700 (PDT)
X-UUID: ce93b0d2ea2711ed9cb5633481061a41-20230504
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2/dNkGOn/lN329oAyXoXh8MgauVts3mVsLCWqq2XLo8=;
        b=eoFqlfPhBeN73nau7EaTAZQLBNE0ee9zsS1qZjaTPwBtdQRSo1fygrhNGO+RvBqIeIYmzxER+bFKlA70t0Vz8xkz9kPG9zWiHG2SWcWjl9tYDyM8w/uqmQtR0ZQVkd5RB+szq0jmL7K5jQ6+bHrvPWXWU7ZO/E8DvPyShEQkj6w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:261f9cae-f50a-4eb7-beb5-0a0be7b01067,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:697ab71,CLOUDID:e899ad30-6935-4eab-a959-f84f8da15543,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: ce93b0d2ea2711ed9cb5633481061a41-20230504
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1236892021; Thu, 04 May 2023 11:00:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 4 May 2023 11:00:19 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 4 May 2023 11:00:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaOLaEOKKPkpXa1i6yAqECLoelJt3ikCtw43wHBfQ9cV+fbdh4NTTTnWaXEKuXfgbHSrMvWFPm8AXEfHkMKQJ99V/zUT7Hxp1nTXI/d9YL55HLPBk0x/RraZolPpUDV9j/jbFBmIq4PZNj/dMW8Vylv5IrwUsR9M/qZAUq5cW9QGSC/tlu4+/eYS1EJ5rlLwljvzjwYa4kwNsJcJ/Rsy0rOZpAZnRFSzdpGQUtcn7FiYY22firxha/4xQM9+YQDvVF0DLsBxFK5KqcD57PI7wJvmc3KVoG1mpRz5O0NOTkTls08SGw+Vb0IIEMHrmW05ZTLCvvkSUvhi6ki3KlTc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/dNkGOn/lN329oAyXoXh8MgauVts3mVsLCWqq2XLo8=;
 b=n7pLz2pXnUhF/7Ve0NSJBC6YwB9IfC84xJKqd36fgcVhPWWQ3gytFYQ+LajFxCZ3oaEf6yYKQ3ne7rz61q4pYZm1jLeUeuUx6tgfuDq9XJeDlWWSiLUyA4qEK8d6De0uVlQ3hCFVqmf/swuf1ZoWqB+3R8xWJ8Px8BeYEmoltj2UuawAIA+wSXSuLAaFhbZCpeNE0KUBOK6Y4PHcMmV9YUUqqY53rCo7Ibygy76/lzwvYecTDVFT0qNvezoh87ZccR1OUUEvcXVHBZ9OYYF/ZGxYjkJjorg5pVyKF63THNaGjj2RXqPblUE7wTeG1E63JV9pXdTTkX3SWlvzipw3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/dNkGOn/lN329oAyXoXh8MgauVts3mVsLCWqq2XLo8=;
 b=PRTt3/xTjcyP7CAuWm7ikStA8QfoMX5zLHogsW0K5kFjjrCj/jfCO7d/Mk2rQkEr/C+SCZSbHk/NDZFfv722cLs1A2uq452PrddAveb6JYks7qXphqTd+MQur0rNn4zQnFbKHEfAQ6/poTO+m9adyLpSSoVWSCXGZ7pOrcOElls=
Received: from SI2PR03MB5830.apcprd03.prod.outlook.com (2603:1096:4:142::9) by
 SEZPR03MB7735.apcprd03.prod.outlook.com (2603:1096:101:12d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.34; Thu, 4 May 2023 03:00:17 +0000
Received: from SI2PR03MB5830.apcprd03.prod.outlook.com
 ([fe80::ba52:eec4:47a:1458]) by SI2PR03MB5830.apcprd03.prod.outlook.com
 ([fe80::ba52:eec4:47a:1458%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 03:00:16 +0000
From:   =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "hsinyi@google.com" <hsinyi@google.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH] PM / devfreq: mtk-cci: refactor error handling of probe
 and remove
Thread-Topic: [PATCH] PM / devfreq: mtk-cci: refactor error handling of probe
 and remove
Thread-Index: AQHZfaGcMT5i4r3tkkGWmyym0sCYba9IbPsAgAEA24A=
Date:   Thu, 4 May 2023 03:00:16 +0000
Message-ID: <414e7dbd903920183d731844666667f8f1a3c6da.camel@mediatek.com>
References: <20230503092742.19404-1-jia-wei.chang@mediatek.com>
         <6439bf4e-979e-889e-c97d-e7b1dd94b4f1@collabora.com>
In-Reply-To: <6439bf4e-979e-889e-c97d-e7b1dd94b4f1@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5830:EE_|SEZPR03MB7735:EE_
x-ms-office365-filtering-correlation-id: f1e71d10-d7cf-42f0-f0c4-08db4c4bb04f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RX0QQyrUmqcDZvq6IfvR75zOdELEy2NdZongp90OEQ+A/uZf7t5l9hoBRsnXaikmItHIxZbMqWQ+4fGlvcKzESz/jCt9BbAgKiBJm75le5Ir5/FpfaNqPljB9CRSZef92PCphB26n5PSGlsP2sdRLhDzUbx4B6ZbTitmz6vIx7tlvSsj6rqTUg2vE2clPB5r/bfxXL/cChONvp9SGX8ourLqebuOjsNlfkZ436TBwI3PWOqhWmpxKfZO14yn8ymJXK94AbvqS6NEwhkvFbyvpRJyEvIBSzuvdlaw3kDUyK0tkwA2P8TUBAO+CySpZ0udLhkcpG0UyPf9J3tKUkq1BzTujf66GOodRr0Zr+7xuDXPuSWUjNIdmJJceSWuCB5aNXy3f0epO/ggFV4+e7TOvMG+ADTW2q+O4nKdosxfGHqipKC7L8uETaWzaoIURQK1iAWdToYqAyDzZuebQnctQgCYJyBL3EhkkDQs6cWi4DAyJxplkihB7uNY+SFp1DU7o+wktlyV5kTyWKauOwSpQNUoKRg4tH48yRcL+mFr/xgUBahjZikndQSopZIvtIfU7i4hWXqj2BX5pgPrhSDfNnrOmS9WaB4GeYdudC+fR69q8h2MWWhMj4ML4O6fqZR1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5830.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(6506007)(5660300002)(186003)(6486002)(26005)(6512007)(107886003)(66476007)(478600001)(54906003)(110136005)(66556008)(71200400001)(8676002)(41300700001)(4326008)(91956017)(76116006)(66946007)(316002)(8936002)(64756008)(66446008)(2906002)(122000001)(38100700002)(38070700005)(86362001)(85182001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MExvNk02V0NSMjdVM243OXU5K01wWURxSGhQY01nczRnWmVmRlB5TGxvS290?=
 =?utf-8?B?blNWYmhIYVU3dVM3NjlTMmNWaFZrd2c5S1ZUUHFSd3dLWDRIcVcxNU5kOXAy?=
 =?utf-8?B?UFdIbWZaYjlKajVJOU5oK3VKN0xqKyt0Nklhb0U2N0FaSEJqWW9kNmxJa0Zj?=
 =?utf-8?B?ay96WXN0OGhwTjlhMTNKNDVScEdWeko0TUVkSjhLYm1NdnRVLzd5cVdJdFp3?=
 =?utf-8?B?dHZ1SnJmcGdwL2R6ZktadzQxV2kxcldrQjEvY1BNVzJTd2VUR20wUS9WZEd3?=
 =?utf-8?B?Ym9wcHhHaUZyOUJFSTVZRVB5Y1ZyYWNHTDdNWDJtN3JUbVhONSt5YU95My9O?=
 =?utf-8?B?NkJ5M0dHcDhGTExDQzIxd2hpUGdXZi9ZeXpiTjlZcGdHd05TY3Z1dUJRUkts?=
 =?utf-8?B?M1QrTlp3QkVnaFo3UVg0bHdkYzVmRU8rMGp4MXdXVnZqUjlWVUM2dzZ2UkVz?=
 =?utf-8?B?RXdFSnFGbzRteG1IUjRDZFZscjFDVEFMajVZeTZwZzFqWlloeGdhS0tuN3ZI?=
 =?utf-8?B?YVZLUVBpd3dOKzYzUm51ajRDdXUzcCszRjZHbk5MWU1uN21pQ2VXRzVVODht?=
 =?utf-8?B?Z1JaL1hFMWJLUVk5dlJFUGZueDU0SzRLNk9DN0lSSU5BM3dHa2w4RlpaWGxl?=
 =?utf-8?B?TmJwT2VjUXZ4OXd0dGcxbk1WMmpxajkvTFRZSVF6QTlFVFV1Q3Nld1ZqdWFR?=
 =?utf-8?B?L2lpall3SWZ6UUZSeEpOMStPZjZkWHVXNVlYMW9CQUkvRnFQclp5TFVhTUQx?=
 =?utf-8?B?bC9zYjQ4NjhsaE1GbFl2NnBiM1NXZlVJbnk4bitJR1lHY0pXTHltZThSMys5?=
 =?utf-8?B?MktOeGhITXV5b1R0TnRET2cxaXRwVlkvQUkwbWhjMDRIaS93YVVsdFFMODE0?=
 =?utf-8?B?ZG5nNkpMY0U4MVFGeEVSVWVHU3g0Q1dTTUtIN0VRc3FpS3RZdnFtWU1iWGUz?=
 =?utf-8?B?NGlHUStuVDhEbW0rTjY4N2R4ZlR4NHJMdm5GK1ZvRVNFVWJsMXpZamZhdTBS?=
 =?utf-8?B?eW4zZlBucThvNmQ3SmNVendoR2FER1o2NllnRys4Q29TeVVjTlpmMjlSK3pE?=
 =?utf-8?B?aG9HYUVXLzZRSmc1NzVvRE9aSW1NcFRPRHpXTDBkeFM1Z1ZkelNFV3M0ckFL?=
 =?utf-8?B?aU5udkRmcmRCLzZBQUpTUHlBYkxZaWRxRXpqMlhUYlZoYjJTTk5SRVZQTTRT?=
 =?utf-8?B?YXdacEJnZWJBOExTVnZ5RXZFWGt2RmpRTUpDbnQ2bnNqZlhzVWc0UWp5bnJH?=
 =?utf-8?B?RjBMdXliNXJXTlJLOTE2bE5hN3gvcUxIR3ZqVktZdFA1NUxCeTVGWnpvVVpM?=
 =?utf-8?B?QzNIR0NQbit1MFRiUS9aakpnMnFaVG1jaGhDMk9jY0ZjRkh5MGVEeUc5c1BV?=
 =?utf-8?B?ZWhvQmw2R05rWC94TDgvRGkzRmlRWFJ1OXlnZnJRbEw3LzQ3VEFRZi9maUlq?=
 =?utf-8?B?cmxlZGIxM1p2UTM3aFhkajFGV3FDU1V4M3NRMGFUQ1JBL0NMMHVkYVlIZ1pV?=
 =?utf-8?B?NHJwV3AvTkd5cDR5eDNPRzg4eWIxNkh2MC9RNTg3MGxNYVVneEJkWWl4cEhG?=
 =?utf-8?B?UnJnaExzNFdlekdBdWo4MnlCTTdzRDFUNUpDRTNnYndHN1VLWVZaSHZVL3hZ?=
 =?utf-8?B?WVRsajlSU2ZWVWYvSk1yL2MrT1NscVhHVi95b1hpSTNSTmFtYWNMUGdUUXRT?=
 =?utf-8?B?ajgrY3Z4VlBQYTVmeUkwMVNVRzdHeVpIN0pmMWhnNHBKdkd5VzBXL0lRQXh6?=
 =?utf-8?B?bzMvNG5vNnVKcDNpMWRUV3JDOW1PRVk1aTdBTFFsdSs4ME9EQlpZMTRHekJS?=
 =?utf-8?B?UUc3NnNkZ2JlZ29iN2MreFlBVlVBOFRwcUNmUndtMHExbml2QXR3SUpUOTR6?=
 =?utf-8?B?NzZjRWlEK3Bjc0ZZOUFkUjg0UkpJUGVIOW5HT3lwZDlSeGlMT0oxTG81RVBj?=
 =?utf-8?B?RkQraXhmbmo5SXRwVWFlc2pSdkRMQ0RleHQ4Y2tCbnV1VnhGbFZZeFNiOWVP?=
 =?utf-8?B?UWNsRnBBNEd5djJDZ25yUm0xcTBvYnhqWmJZeGVJWUtIVFVsTHgxNnBNNm1m?=
 =?utf-8?B?aU51TmRSL0lUcEZValpWT1NDUGVJWlNVNS9ZRGhieU5BbnFzOTFiRDFFQm1s?=
 =?utf-8?B?QjVCaE1EcXByR2tVR29tTXlCWk0weXF6TS9Ld2dtSWgyaU9yalVQc2ZGK3JQ?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF1F7DC964CAB14B81EBF64985A3612A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5830.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e71d10-d7cf-42f0-f0c4-08db4c4bb04f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 03:00:16.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bG93F+J6mPkwDpa9eA+hAc/u5TSimL+BrDZaFzg2CCnjXJTNT6um+SqT4DaM+gYTy3I1Lb6jKDsUIyOPO7RaXTen8NP8kPHcHIeP3XcAMPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7735
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTAzIGF0IDEzOjQwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwMy8wNS8yMyAxMToyNywgamlhLXdlaS5j
aGFuZyBoYSBzY3JpdHRvOg0KPiA+IEZyb206IEppYS1XZWkgQ2hhbmcgPGppYS13ZWkuY2hhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IFRvIHJlZmFjdG9yIHRoZSByZWd1bGF0b3IvY2xrIGhh
bmRsZXJzIHNvIGl0IGNhbiBmb2xsb3cgdGhlIHdheSBvZg0KPiA+ICJGcmVlDQo+ID4gdGhlIExh
c3QgVGhpbmcgU3R5bGUiLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYS1XZWkgQ2hhbmcg
PGppYS13ZWkuY2hhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IEZpeGVzOiA4NmQyMzFiMWRiMWIgKCJQ
TSAvIGRldmZyZXE6IG1lZGlhdGVrOiBJbnRyb2R1Y2UgTWVkaWFUZWsNCj4gPiBDQ0kgZGV2ZnJl
cSBkcml2ZXIiKQ0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9kZXZmcmVxL210ay1jY2ktZGV2ZnJl
cS5jIHwgNDcgKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gLS0tLS0tLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RldmZyZXEvbXRrLWNjaS1kZXZmcmVxLmMNCj4gPiBiL2Ry
aXZlcnMvZGV2ZnJlcS9tdGstY2NpLWRldmZyZXEuYw0KPiA+IGluZGV4IGU1NDU4YWRhNTE5Ny4u
ZDJmNzQzNzc0MTQ3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZGV2ZnJlcS9tdGstY2NpLWRl
dmZyZXEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9tdGstY2NpLWRldmZyZXEuYw0KPiA+
IEBAIC0yOTQsMTQgKzI5NCwxNCBAQCBzdGF0aWMgaW50IG10a19jY2lmcmVxX3Byb2JlKHN0cnVj
dA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgICAgICBpZiAoSVNfRVJSKGRydi0+
c3JhbV9yZWcpKSB7DQo+ID4gICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKGRydi0+c3JhbV9y
ZWcpOw0KPiA+ICAgICAgICAgICAgICAgaWYgKHJldCA9PSAtRVBST0JFX0RFRkVSKQ0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICBnb3RvIG91dF9mcmVlX3Jlc291cmNlczsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgZ290byBvdXRfZGlzYWJsZV9wcm9jX3JlZzsNCj4gPiANCj4gPiAgICAg
ICAgICAgICAgIGRydi0+c3JhbV9yZWcgPSBOVUxMOw0KPiA+ICAgICAgIH0gZWxzZSB7DQo+ID4g
ICAgICAgICAgICAgICByZXQgPSByZWd1bGF0b3JfZW5hYmxlKGRydi0+c3JhbV9yZWcpOw0KPiA+
ICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBkZXZf
ZXJyKGRldiwgImZhaWxlZCB0byBlbmFibGUgc3JhbQ0KPiA+IHJlZ3VsYXRvclxuIik7DQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0X2ZyZWVfcmVzb3VyY2VzOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBnb3RvIG91dF9kaXNhYmxlX3Byb2NfcmVnOw0KPiA+ICAgICAgICAg
ICAgICAgfQ0KPiA+ICAgICAgIH0NCj4gPiANCj4gPiBAQCAtMzE2LDEyICszMTYsMTYgQEAgc3Rh
dGljIGludCBtdGtfY2NpZnJlcV9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ID4gDQo+ID4gICAgICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGRydi0+Y2NpX2Ns
ayk7DQo+ID4gICAgICAgaWYgKHJldCkNCj4gPiAtICAgICAgICAgICAgIGdvdG8gb3V0X2ZyZWVf
cmVzb3VyY2VzOw0KPiA+ICsgICAgICAgICAgICAgZ290byBvdXRfZGlzYWJsZV9zcmFtX3JlZzsN
Cj4gPiArDQo+ID4gKyAgICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGRydi0+aW50ZXJfY2xr
KTsNCj4gDQo+IEFkZGluZyBhIGNsa19wcmVwYXJlX2VuYWJsZSgpIGNhbGwgZm9yIGEgY2xvY2sg
bXVzdCBiZSBkb25lIGluIGENCj4gc2VwYXJhdGUgY29tbWl0Lg0KPiBCZXNpZGVzLCB0aGVyZSBz
aG91bGRuJ3QgYmUgYW55IG5lZWQgdG8gZG8gdGhhdCwgYXMgd2hlbiB5b3UgY2FsbA0KPiBjbGtf
c2V0X3BhcmVudCgpDQo+IChkb25lIGluIG10a19jY2lmcmVxX3RhcmdldCgpKSBvbiBhIGNsb2Nr
IHRoYXQgaGFzIGZsYWcNCj4gQ0xLX09QU19QQVJFTlRfRU5BQkxFLCB0aGUNCj4gY2xrIGNvcmUg
d2lsbCBhdXRvbWF0aWNhbGx5IGNhbGwgY2xrX2NvcmVfcHJlcGFyZV9lbmFibGUoKSBvbiB0aGUg
bmV3DQo+IHBhcmVudC4NCj4gDQo+IElmIHlvdSdyZSBmYWNpbmcgYSBidWcgZm9yIHdoaWNoIHRo
ZSBwYXJlbnQgaXMgbm90IGdldHRpbmcgZW5hYmxlZCwNCj4gdGhlIHNvbHV0aW9uDQo+IGlzIHRv
IGFkZCBDTEtfT1BTX1BBUkVOVF9FTkFCTEUgdG8gdGhlIGludGVyZXN0ZWQgY2xvY2suDQo+IA0K
PiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQoNCkhpIEFuZ2VsbyBTaXIsDQoNClRoYW5rcyBmb3Ig
eW91ciBzdWdnZXN0aW9uLg0KSSB3aWxsIHNlbmQgYSBuZXcgcGF0Y2ggdG8gcmVtb3ZlIGNsa19w
cmVwYXJlX2VuYWJsZSgpIGNhbGwgb24gdGhlDQpwYXJlbnQgY2xvY2ssIHNpbmNlIGl0IGlzIG5v
dCBkaXJlY3RseSByZWxhdGVkIHRvIHRoaXMgY29tbWl0IHB1cnBvc2UuDQoNCkFzIHlvdSBzdWdn
ZXN0ZWQsIGNsb2NrIHBhcmVudCBlbmFibGUgd2lsbCBiZSBoYW5kbGVkIGJ5IGZsYWcgaWYNCm5l
Y2Vzc2FyeS4NCg0K
