Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BAA63718F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKXEr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKXErX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:47:23 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AC3C72FB;
        Wed, 23 Nov 2022 20:47:18 -0800 (PST)
X-UUID: a0c103488e4242519736092dddd4937f-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LoAdzcxtV+qdIZckisYgsEmf1gyGSH4jXhX1fFuPyOk=;
        b=XL2xgPK7mxFzL7NU0U3bIJUrSlrQmUW/8Ggd/U+zvYIZLf8eE/voNjkvju462re59carlAA3THiRgL12ehMeX1yM0PcRO7laoOuvf4AxsElyaM59GHM7TdXyxoEmqMlhGgVy5dJQXDetwHOSSvLMxL8kYLYrb8BjEjbGENeLgDk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:8b0dd164-44d3-450c-bfc3-413e06c02eee,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.14,REQID:8b0dd164-44d3-450c-bfc3-413e06c02eee,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:dcaaed0,CLOUDID:5223ae2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:2211241247098CYTBXPP,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a0c103488e4242519736092dddd4937f-20221124
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 522457582; Thu, 24 Nov 2022 12:47:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 24 Nov 2022 12:47:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 24 Nov 2022 12:47:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRk+CxeJz1QGdoZwvHnP6APmIRkOfqj956Zi2U53oHvAuAqiAnOddjVDpfrXB5LexqIxtN16MJM/6JXjRIKzWksRyvTvTc3jjybPVXQhG5dP4cif6cjzvDdXIwUGOfumPGSwtmJindtJRdhrFPQRu7dbv3k7Du71GB8KtgoJshfq14MQwshIUjdtnlmBqwnxUCzjEaihGfmJv9Zv4mWLIJVNnZZ4TNOMPHA3boCqxBoPqXDmshV8P4LBxSmVIFRoowpwqg4ixUMQRH2Z+mf5zb7/XehKKdatrVX7M00InXfnVpzw/nJ43eW53jJA5eWXJo7Wmk+X7pYR6d7aklfgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoAdzcxtV+qdIZckisYgsEmf1gyGSH4jXhX1fFuPyOk=;
 b=Bii5z68K1Fhr0e/puAoKHqztc/cg5i10dmLQs9jS2JelyyuDBTXAfZ5LFJTuaSC9g+FwPza7HsTFbAN1Ui5qGMrTkrc7jUn9gG+gfJYa9AEWZEIs+mUpt/wIS+LK/fqQ1YUdnPsHt4N395HQyfwX9a3FVAQF4R6Q8MFwsAu7EXvVPGOFt7LKOX7kmJ+fmOM1LlBb6OEaeOYgkx+UHupIVKxXP9yqV4JXn3Jv7859/aVhPGgwCzkuR10NHM0dch1V0rUjROqRcN6svqXJzfNkQLJBSgpbKHpKHfzT5O7gqJmo9cO/vXynFzleWy9c4HyZh69Wh9i6UiFy8GBztqqisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoAdzcxtV+qdIZckisYgsEmf1gyGSH4jXhX1fFuPyOk=;
 b=lSMOAX6y8tgp0F0ViBRmX2Lu+aRJaA2dUDQdgznbH6CbTSzk2RQ7YuUYdLIQWYa4op5f7pNpIAgen8j51IzfpcrOHo1aBYhDk9P8Ij5FE1rTGVkcMWZGklQ8NDtIwFO0cIZMM/VlOghhvpe832M3K0ETA1HLlhMc1EnyPfszjWA=
Received: from SG2PR03MB3035.apcprd03.prod.outlook.com (2603:1096:4:11::15) by
 KL1PR03MB5588.apcprd03.prod.outlook.com (2603:1096:820:52::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17; Thu, 24 Nov 2022 04:47:04 +0000
Received: from SG2PR03MB3035.apcprd03.prod.outlook.com
 ([fe80::e692:7d40:92d:8189]) by SG2PR03MB3035.apcprd03.prod.outlook.com
 ([fe80::e692:7d40:92d:8189%7]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 04:47:04 +0000
From:   sam.shih@mediatek.com
To:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     "daniel@makrotopia.org" <daniel@makrotopia.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pwm: mediatek: Add support for MT7986
Thread-Topic: [PATCH 1/2] pwm: mediatek: Add support for MT7986
Thread-Index: AQHY6DqtqEtMSnv/kEKnb0uTLZiC/a4fLaqAgCP5GwCACohdgA==
Date:   Thu, 24 Nov 2022 04:47:03 +0000
Message-ID: <ca3283fbe762db7c7f665eda15e807d7207bb578.camel@mediatek.com>
References: <Y1K5ym1EL8kwzQEt@makrotopia.org>
         <b5ab84b4d595713588f1d8a68a1585ca3ae5521e.camel@mediatek.com>
         <20221117115624.t2kbwscxvkvffo7x@pengutronix.de>
In-Reply-To: <20221117115624.t2kbwscxvkvffo7x@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3035:EE_|KL1PR03MB5588:EE_
x-ms-office365-filtering-correlation-id: d048ce6a-0de6-4360-6cb1-08dacdd6eed2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywDAGPsW9FFHQ4fBNQ4IZulzt1b6kpB+nBwb7q4WfQtq6EZb7JzO0PNk/VHsrPOis0axPTvllDyWwKYNNo9jQbV7jMVYPowcyQWKZOFO60jtEucx7G07VPGtE5LLB49zYo5AwkF8UtmKYEq/ccZeU2mIJLwntLmk6gS7QbALs4o+T2Q6xi2Uhlnx6aVhR2RCjgcy4eOVh+L5BKhYXOGwyxUIoV8frXToyRY/GeFz/hQmAYb5YoelE9OydqOjcOtp2P3fO1aiIfghrLFBl4m8xiVojjwpQE9pexk430AgT/Uqmk1I+ewRuGpNLKo2JsgfivdbXIFsu6MHF9qsyIKsk2IjqJNwOf+hgdLS2EXJC5qk4xfmWL0JH/5iUjnXsCLTHOl+ONuuq+GM7IB+lI09K7Qz+lij6/WkrpkbPgdl9AnPyi03dz0ZOZExniEf4AogYomcKU0cGOx4BIa+QgzT7kJ9FPN30nmtqDSpXGFXO8rg106rJcA9BeSb1KrrbvB+Nj4MXTulRBqVa8wp805sK0cS/359HsBKKu2hwmSOe2cV+70P+pstCASh7qmbEGDr/buSoHUvT6mrZbxyfylPX8tbxZRULkezA9jU1Uwc/4z9zI6xVA6Ie8A2xmzxfIynOvm++zkRqtk4iAkDI5nIbrL/uzrP/mnygV4SoLDpLBk4udCiMHaAVjFxHEcHL9tyhKbq8lIJzhSBjnRki9v1Mlo+i3J+iqsMandODykd1xs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3035.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199015)(83380400001)(4001150100001)(2906002)(2616005)(85182001)(36756003)(66946007)(66556008)(41300700001)(64756008)(66476007)(66446008)(186003)(86362001)(76116006)(38070700005)(6506007)(54906003)(6916009)(38100700002)(122000001)(66574015)(8936002)(5660300002)(26005)(8676002)(91956017)(4326008)(6512007)(316002)(6486002)(478600001)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cngvNnEyOVZyenVkQ045dnBJbnNSU3J4MVlNUzVpMDIvdEF4UFJUTkQ2S1Jr?=
 =?utf-8?B?aENjM2FEazRVdVJBN3ZIQ3o5VHRvTVFySlFLT1EwOGFPeWV1ay8ya0QvSlg4?=
 =?utf-8?B?dU5PWDdGWUt1QklWZlZhOTYrYTYyR0ptRE83R0JtQ0tKSEkyWmNMVGNaZ1Vj?=
 =?utf-8?B?UnE0MkxMUGhxNnZXdkN5eW5oWVBFNkw5dkRucXYxak9uVHdrTXU2YnZRclZl?=
 =?utf-8?B?V0NnSzl2SnNCbnYxeHRBbC80MjRxTlJjM1dhUjZNWXhxWFM3Rzk1SktGdFhu?=
 =?utf-8?B?OHpFYkNCY1gyOUxDL3Y1WWxTRWpkYUNPTFpEOG9nQ3lsZ2tSVXd6dkdiTExa?=
 =?utf-8?B?RFdVd0NnbHpOMFR5YkJ5V1dHSGVUZ3ZJbUJoU2YxNVQyT0dwK01JU3A3S2N0?=
 =?utf-8?B?WTh4d2Z6SldPQWVmTFpVSWJkdUNNdnJBV3pKN1gvUi9FSWRtODNvSnJGN1E2?=
 =?utf-8?B?NXhET05jWktZYUFBa2Jpc1lxczNUc2NjUEFCTDNJelRBcy9WaXkxLzYvWmZP?=
 =?utf-8?B?N1N1WXhDVjU4VzRnWThOdTdJdmNlR1FnazdYNmhMZCtMMzRJSFpBKzg1S1hn?=
 =?utf-8?B?bnNRMS9PRjg0Z0VRTnozU1RWOU11YmhPZFFxNVlGeTlRdVFwa3ZxYU5vdEdp?=
 =?utf-8?B?WUhNNVF6N1pZd1BwNTlXWXFKYTdXQ2xreTY2NlhuTzhSU2N5QWZYTS9yQjVp?=
 =?utf-8?B?OUdjRlRzdWM1VDhSbDFtS216SU1Pa1dRb2pJakJzaXRnSStud1NRblJEQ3pF?=
 =?utf-8?B?NS8wcVhuVVIwRmNhVGQ5L3VGdkI3WGNaUVdJa1I1M3FhWFNWVVVVSmdrT3FX?=
 =?utf-8?B?WlVTQ083dWx3U0RDeEQyREZuWWEwV3ZRRlZxSWkxczdyMkNDOWVjcng4ckdB?=
 =?utf-8?B?T2ZVN1JKVllxbHROeTl1WVdxZWtUQW1ySlhYV0lnMTg0MlhwWi9yVEZQdUVs?=
 =?utf-8?B?TGw2bEdITVo1bmVjOVRtRUNFbUlTUjUwMjZpQlhnd0VjNlY0RGNmc1VjdEx1?=
 =?utf-8?B?Ync3L1hScEM4ek42SzFtRVVBdHIzaVNRZU1YTFZtRWxVeVVKYTBhQUhtbDBy?=
 =?utf-8?B?QXhQbG4vMk5FNVJSWUd2RW1yK1RhcW85bEswWWhhNzcrZmZkV2pGQVVhOGNN?=
 =?utf-8?B?SFU5bTVFNjFnR3dpemlBVUs0R0IyR1Q1RERUYThUYTRnbDlRK2RTL2FIeEFN?=
 =?utf-8?B?UEtjcWczSTBFNGYxV2F4d1RHOFBRT0MwVDRBSVpaNUxGNlFSRHlLYjBWaXFI?=
 =?utf-8?B?M21BRkd6cjFwdk94Q1dUTGFIQlovWjE4aFRYU2JoamJqaTc5OExlQWdoL1Q0?=
 =?utf-8?B?RDRzNHNwU1ovcFNvbjUzNWowRm91MUp3NnZ5Z1lRYkhyR2JWUVRjK1B5NE9o?=
 =?utf-8?B?dzI4aUJVc1pPRm4vcUs3TFpEYWhMcWpUajErTWdnTlgyYWhCUjI1ZnNHVVQx?=
 =?utf-8?B?VHJlN2pyMmdvMTBBMmNZY1djLzVFbEpLYW5scDJUNmVFSFNTKzU5R0Q4bHh3?=
 =?utf-8?B?Tk1Ndm40azZqMCtmRVNLNWh4c0JTRmNwU0JpL0VUSFZTSFYrVnR5Y1JWRXNp?=
 =?utf-8?B?bi9CRFV4b2VKdHRhWnpBeWJsOWthaFdQSVV0LzgrZ2ZWWHIyUUtCUnVOOWky?=
 =?utf-8?B?RTlOSmZxVllRaW04UmMrNmxWUFUvNUg5Y3oyaHpFMmp0NzJnODZHV3VLb3VU?=
 =?utf-8?B?RFpudVJSV1lHWWFpc3BGUHFqNzg0ckpaZnFlR0VhV0l5QmtvMnVNODdmZ1F0?=
 =?utf-8?B?amtTZXpqS052YUFEZHU1bndsbHNuQzlVYnUxUEFkQ3d3NHdtajd6R3VialpY?=
 =?utf-8?B?cVVKL1hydHpjbHpjbXpJcGRONHpwYU1KUnhEeGdsdnNJRmYrUlpsRUc3NW41?=
 =?utf-8?B?bHBuZ0Y2RWpDMVQ4eG52Ui80dmllTk9lVmZmYkxjOE1ERUp1MitGazRTbzB6?=
 =?utf-8?B?bks5TmdOVVpTUHdqcENveDV3dEVkUk5Dd0kxcGFVb3ljdzh4NlBzUkErWUVu?=
 =?utf-8?B?OE02cU5KcEtXTlgwNUNNTzRNcCtjWWFlcHFsb3VTR3NZTzE2YzFhc1A0T0kz?=
 =?utf-8?B?cmduYjE0dENWVlExZzIwRVgxZE40bmh5V2M1aUpGL2diaGVwUldsc2c2QUlq?=
 =?utf-8?B?bTNsOFIyeXduWWhHRDlwRnVpZXREOUZ6akNIT2JrUVJYUUZhVU9sQVI0Z1hO?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97622F615AB9764399D9E21798514F78@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3035.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d048ce6a-0de6-4360-6cb1-08dacdd6eed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 04:47:03.9653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzolpRU7cUcG4U+Zl947qqRzXfwxur1HEnbMGjlJLfXPxL8tcw3QZDbOn8/xpAIJtbDbcB4R/3T/9wUCiAwRtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5588
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVXdlLA0KDQpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuDQoNClNpbmNlIHRoZSBDS18yNk1f
U0VMIHJlZ2lzdGVyIGRvZXMgZXhpc3Qgb24gTVQ3OTg2LCBhbmQgZm9yIHRoZSBvdGhlcg0KbWVk
aWF0ZWsgU29Dcywgd2Ugc2hvdWxkIHVwZGF0ZSB0aGUgdmFsdWUgb2YgdGhlIENLXzI2TV9TRUwg
cmVnaXN0ZXIgaWYNCml0IGV4aXN0cyBvbiB0aGUgU29DLCBldmVuIHRoZSBNVDc5ODYncyBQV00g
aGFyZHdhcmUganVzdCBieXBhc3NlcyB0aGlzDQpzZXR0aW5nLg0KDQpGcm9tIHRoaXMgcG9pbnQg
b2YgdmlldywgSSB0aGluayBpdCBpcyBmaW5lIHRvIG1hcmsgICcuaGFzX2NrXzI2bV9zZWwnDQph
dHRyaWJ1dGUgdG8gJ3RydWUnLg0KDQoNCkZvciB0aGlzIHBhdGNoOg0KDQpSZXZpZXdlZC1ieTog
U2FtIFNoaWggPHNhbS5zaGloQG1lZGlhdGVrLmNvbT4NCg0KDQoNClRoYW5rcywNCkJlc3QgUmVn
YXJkcywNClNhbSBTaGloDQoNCg0KT24gVGh1LCAyMDIyLTExLTE3IGF0IDEyOjU2ICswMTAwLCBV
d2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4gT24gVHVlLCBPY3QgMjUsIDIwMjIgYXQgMDI6MzU6
NDNQTSArMDgwMCwgU2FtIFNoaWggd3JvdGU6DQo+ID4gSGkgRGFuaWVsOg0KPiA+IA0KPiA+IE9u
IEZyaSwgMjAyMi0xMC0yMSBhdCAxNjoyNCArMDEwMCwgRGFuaWVsIEdvbGxlIHdyb3RlOg0KPiA+
ID4gQWRkIHN1cHBvcnQgZm9yIFBXTSBvbiBNVDc5ODYgd2hpY2ggaGFzIDIgUFdNIGNoYW5uZWxz
LCBvbmUgb2YNCj4gPiA+IHRoZW0NCj4gPiA+IGlzDQo+ID4gPiB0eXBpY2FsbHkgdXNlZCBmb3Ig
YSB0ZW1wZXJhdHVyZSBjb250cm9sbGVkIGZhbi4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogRGFuaWVsIEdvbGxlIDxkYW5pZWxAbWFrcm90b3BpYS5vcmc+DQo+ID4gPiAtLS0NCj4gPiA+
ICBkcml2ZXJzL3B3bS9wd20tbWVkaWF0ZWsuYyB8IDcgKysrKysrKw0KPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcHdtL3B3bS1tZWRpYXRlay5jIGIvZHJpdmVycy9wd20vcHdtLQ0KPiA+ID4gbWVkaWF0ZWsu
Yw0KPiA+ID4gaW5kZXggNjkwMWE0NGRjNDI4ZGUuLjIyMTljYmEwMzNlMzQ4IDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9wd20vcHdtLW1lZGlhdGVrLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMv
cHdtL3B3bS1tZWRpYXRlay5jDQo+ID4gPiBAQCAtMzI5LDYgKzMyOSwxMiBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHB3bV9tZWRpYXRla19vZl9kYXRhDQo+ID4gPiBtdDgzNjVfcHdtX2RhdGEgPSB7
DQo+ID4gPiAgCS5oYXNfY2tfMjZtX3NlbCA9IHRydWUsDQo+ID4gPiAgfTsNCj4gPiA+ICANCj4g
PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHB3bV9tZWRpYXRla19vZl9kYXRhIG10Nzk4Nl9wd21f
ZGF0YSA9IHsNCj4gPiA+ICsJLm51bV9wd21zID0gMiwNCj4gPiA+ICsJLnB3bTQ1X2ZpeHVwID0g
ZmFsc2UsDQo+ID4gPiArCS5oYXNfY2tfMjZtX3NlbCA9IHRydWUsDQo+ID4gDQo+ID4gRm9yIE1U
Nzk4NiBTb0MsIEkgdGhpbmsgdGhlIHZhbHVlIG9mICJoYXNfY2tfMjZtX3NlbCIgc2hvdWxkIGJl
DQo+ID4gJ2ZhbHNlJyANCj4gDQo+IFRoZSBzdGF0dXMgb2YgdGhlIGRpc2N1c3Npb24gaXNuJ3Qg
Y2xlYXIgdG8gbWUuIFlvdSBkaWRuJ3QgdmlzaWJseQ0KPiBhZ3JlZQ0KPiB3aGljaCB2YWx1ZSBp
cyByaWdodCBub3cuIFdpbGwgdGhlcmUgYmUgYSB2MiBvZiB0aGlzIHBhdGNoPyBPciBpcyBpdA0K
PiBleHBlY3RlZCB0byBiZSBwaWNrZWQgdXAgYXMgaXMuDQo+IA0KPiBGcm9tIG15IHNpZGUgKGku
ZS4gbm90IGhhdmluZyBjaGVja2VkIHRoZSBodyBkZXRhaWxzIGp1c3QganVkZ2luZw0KPiB3aXRo
DQo+IHRoZSBQV00gaGF0IG9uKSB0aGUgcGF0Y2ggaXMgZmluZS4NCj4gDQo+IEJlc3QgcmVnYXJk
cw0KPiBVd2UNCj4gDQo=

