Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C03E7197A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjFAJtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjFAJtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:49:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E3C107;
        Thu,  1 Jun 2023 02:49:09 -0700 (PDT)
X-UUID: 8a40edfa006111eeb20a276fd37b9834-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fTgFoGQWUXXw0lttzXQHTW0Lk8lvDA+wPq9pMUVzsKs=;
        b=T9xWFodGEg+mV8tie7XkZlNr8SACCi+3FG3muO+XEybexa2LmkBmnVDvTnBZiBA5sUE5RUSPD+BnVKbbGXbivs8d4PlSH8wLewCgjDZ7z3WwEtcoHhQtv48E+DHtX1DzQSXG3RbSbVBKOavXjdzms6GxE2QQZtgOYP4/fYjtb3w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:73be2429-dbd2-4f51-928a-7d21edbfb737,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:c449b56d-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 8a40edfa006111eeb20a276fd37b9834-20230601
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 953059568; Thu, 01 Jun 2023 17:49:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 17:49:01 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 17:49:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi9RZn3lS65izG6VmWnQhOo0xucKvuI7D0StQsH6kH1p5PyDzNKpLh2Mg0WFujCTl5VewG6+Sc/rQAVqg0kVsUW4tY1CEOAUGeq/SNnR5QXZqBgmACic2pqg1sS6ht35rKOIn21iIuokfWtg0+lSFlwPSxE/j5PWnfvrxN4QMBtpCMf1byv5M7CmYGIN0Kbx+WiyT/p2gn/0vjrJgCuszC9jyvYaCyk7gqMrGq3CdU+CXIs7R6INKv/Mj8k8LoKssP9alrHcbX3KTzUsvTpQkKTi5DPiscIYievit/cwZIYY5YUDn1fkcxx1ff62IlLaSkAzubwPHoL+WfAvZ9xqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTgFoGQWUXXw0lttzXQHTW0Lk8lvDA+wPq9pMUVzsKs=;
 b=EWOUANBM/MSSdS/WkqsXzDhhKvFUbdzAYiNgfpFYTA34lV23JV8sAekS9I7/sQmqy7G7F0pEjeYKZa1o12Wq3ZIymJ+mlaOGU9z0GzzVpqmoKRPgFxI+ZRk9VV/7dtFLP2e6ak3Da43qWcr36v5O/YYp1j/UheJlZAbHXXGM7VR7rlowXmG9ll8ETh0Xjpgx7TZ60abswHonc1pvuCYK3Z8wEa4N+yLhY2h9fJWanJ+3oZgJyRhTfkcj8zQal+nZW94c1wlTSG50pbX3iRhD0xh//7hDFhP8alAXg+ip5EalBT6ipyIXsA+wygYtXBAJYGSkwb9b4cVtYvYupzBZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTgFoGQWUXXw0lttzXQHTW0Lk8lvDA+wPq9pMUVzsKs=;
 b=CGYD98lOVC178WiWIhsA4Ao5b1/hmexJwwDhQUJ8iXkkDYmYS3sV+/MlFjjxmZUASmOE1Vdw0g/6ql8xlMKMO47IMGMyBGczNX+MZH8A49S+HomgogSQyx6gnVpWgym23R0vecsYpWgqfqPNE09HdPzcE37Uq0xxHTSfD9XE7DM=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by KL1PR03MB8087.apcprd03.prod.outlook.com (2603:1096:820:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 09:48:58 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::8fce:558a:2511:c41b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::8fce:558a:2511:c41b%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:48:58 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH 0/8] media: mediatek: vcodec: separate encoder and decoder
Thread-Topic: [PATCH 0/8] media: mediatek: vcodec: separate encoder and
 decoder
Thread-Index: AQHZlGwJ5/N7VCLpGUaiUox5B73dP691s7mA
Date:   Thu, 1 Jun 2023 09:48:58 +0000
Message-ID: <94287d1d9ca5fdb2ee69b41c9c4ce233349238d7.camel@mediatek.com>
References: <20230601030256.29875-1-yunfei.dong@mediatek.com>
         <937fb46e-7e52-5689-9c49-efef477211db@collabora.com>
In-Reply-To: <937fb46e-7e52-5689-9c49-efef477211db@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|KL1PR03MB8087:EE_
x-ms-office365-filtering-correlation-id: f7466ef1-5b0c-41c8-4558-08db62856c0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bqa1H9nVp6HtWsFaYCOKVB7xP5S1wZd1awrqTVo/LWmv0RehIJMIYn6AZUVV4aeqkqiQOuDvuzk7aPM2OZCC8kGxkSwvQQqY4Xrpj5ld+ytk3xV/NXx8cM80ByGAxPP9pbQiplfejcMWvoH04N4aJ8QZggaBluwZBEhg8ELqzMNzNoDz+V3s9Auo0fhrrlpTCZFOY3QrpEcoJyoopvuo/7Jf5nlkww5XgKH6+UsPRNIOnoXeKoPelpDfqgb6IpEAb2CuKBNCJOQiwdTkTPeJHPWFG7OTtqYuFNJ1zu55dxhC1aSc28K65+8Z151jaxBlFIVbaFPA57uG5QBW4Lk4J3Cs9+xzX425xDhaWksxFbGc1yDzCBZmejaRfVVoJ9J4vw2f1b3MhPH35lfRBGGHx8LBhgxmRHsJvHYB4tZKw3B4maGeOKyC+j3AykQhut9HK8LEmOXkz2ry7YEzLRTn45QPMC1nPT/sGLaZPVjaoQtGLKdmB6rFRNTKswvCMij/ljxfYDWEvBKCRzg7EupaWkpg+pWu13gXyVmRaFCseks5JZwg9PJqXq2oHM8e99LGR695VG3tCK460OU00/zWnDMI7X+9ufloUIiwJIp2iNY5JBkkpftmq4kaxn6/oRprT1XOhTJ+JRVWAE5+TnGdOMXMFs1JP2QZA8Fe27RoYYvMzjW7rZ9blEadYLSBVkCm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(76116006)(91956017)(86362001)(26005)(478600001)(6506007)(6512007)(36756003)(85182001)(8936002)(8676002)(38100700002)(41300700001)(186003)(6486002)(2906002)(71200400001)(38070700005)(5660300002)(7416002)(122000001)(66946007)(2616005)(64756008)(66446008)(6916009)(4326008)(66556008)(66476007)(316002)(83380400001)(54906003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0VPNUUzQ3lVSjU0KzB5NENMQWlORXA1YndqaUJPYVhvWVlyd1Y0YXVHcVcr?=
 =?utf-8?B?cnoxSnVUQU96SFRJWjBOdkpTTVNaREU0UHNhUHhRTzBGbEx2Sk1HTFFhWHRG?=
 =?utf-8?B?NS9GY3l6YzFyM2ltOXFiRFgzemxCd2NNZkh1SHJIUE9rbGUxbE5GR0lYcjI1?=
 =?utf-8?B?aDVUajlLK09wd0hpdEVVTUNtb1I1TnhLaW4reUh4aEEyM0tOYTJYYUxidmpx?=
 =?utf-8?B?OVNsMERLZ1QydnJqV2dQUy9aT09PamMvSzE5SWZweC9CVmFKNkJTRWdxcmp4?=
 =?utf-8?B?a3hHbXdjb2VMMVhxejlyWWJuM00yTUgxMFRnaUorakYvM0tWeXlRdW5ZSzhh?=
 =?utf-8?B?SE5rTFM1R0pkUUI1bHQ1TkVYdXkwTE9sdUZabnFkZzNESjRicXhjaTJEaFJ3?=
 =?utf-8?B?cVBaVzhaRTVHdDlCb1hTT0ptUExrMlNTbmNNVXJTbGI4MVJtRHpMOCtldEJB?=
 =?utf-8?B?U0R5cUJZOE5xRzBnNVRxUmtVUndKTVVUZ2dQNEFDSnZzdXRsLzNtbGt1QkFS?=
 =?utf-8?B?aDFNZ0MzQUJCK1U3cXlVcXVTb3QwZW1ybnRjb3gxcjRXeVZYYjloNkNEY1cy?=
 =?utf-8?B?R3JXSEFMRjJUdDJTcDE2MzE0MjMza0ZMS1ZTVjRxQXBLbjIzR3BtVnNNRWM3?=
 =?utf-8?B?OFByV3VWaEE1aW5oeml1UXY2VlRCeTFROUpsbWRtZHArMmsvMjJ3UG9MSTdt?=
 =?utf-8?B?U3FISENObVFkaStQcjQzSTE3dVZOOTNZaWlTbkRDRU5KeEtLTFUwVXFXajla?=
 =?utf-8?B?VGYvd1VwOExWZHNGOEtWenBzTDVFUG9reFg3S09FZjBBWUNXZUxlQU5zWlZm?=
 =?utf-8?B?QXFoK2s0U2pFSGV1WVkxQlgyUk9ZY3ZTZ0hLWXJxTTFwVTdrbzE4MERmZ01J?=
 =?utf-8?B?NHIwYlY0ODc0enN6ZzBzOG1FMS95THYyb1BrK2tHYkhHV1BOclkwb3BWZ1Ji?=
 =?utf-8?B?d0Mrem1naGt0VXdINWZGM2toUDZuSWlBcTNFcUhoMFhaeTNUNmdwcnZoQnZP?=
 =?utf-8?B?S2srMUFPYWl6VThpL1E5S3k0UzJOdlZKRml4d3prL2hoaHZzUS82dzltcnJJ?=
 =?utf-8?B?Vit1cWcwMmdLUXJzalVJdTk5cXEza2xmN041Y01zRzRHQ0paTmluWTJEam5Y?=
 =?utf-8?B?WDZ1RWlwUXA0R3lHSUJkYXFJSUVxRTB3dHFDYjArK0hseHVYNklSaThqdHY2?=
 =?utf-8?B?T3ZsaWFKeG1keVJ2bnV1RWtUbFBWcFhvRm8xcXZVRFBheFhTakhLNU1Ha3lS?=
 =?utf-8?B?dTVuTGl2NklPMlBoN0xMRUcvRmFFZnhQTE45VFB4eE9JNFQvZUhHY0IwMHBD?=
 =?utf-8?B?T3luMzJyeU94ZmhWR29TS2xUeHNmQytqQlF0Y2hhTFRCcStQcE10b0daSG5T?=
 =?utf-8?B?OWZHSVZLUHdmeVVRMGtPdG8yK1FRdVZleXNVTU5tUjhFa0ZLOXNwVG9BSUJS?=
 =?utf-8?B?UFQxN0ZlVUVRbUl2azRpOW5pb1c1STZZVkw4eXc0MjlpN2Z0dkx0TGhxWUdw?=
 =?utf-8?B?cXc5eDFiUW9ZSkQrMjhNYS9aNlhmV0R0WUdLcGR5UWgrb3RseHRoVnBBRzhP?=
 =?utf-8?B?MmtFTGJ3ekFLRUN6T01FbEVucnR5ek9YVHFnNlJIbFI1ZHlSYUg3VTc0K2NX?=
 =?utf-8?B?RXRra3dObks0cldTcW16QncrdFAwNDRhMld3ZUV6N1FqNHhzUkRyUlVTcWpT?=
 =?utf-8?B?bUV3clBHb05SbFlxZ1lhYVpVbUl5azBHemk3b3VPVzNkZG9SUVZ6eWVBK3BB?=
 =?utf-8?B?Rmw2QTJnRGVyeHBCblIxSFdJemlueWYxZTdvRkZUZWNTRWI0SFFQNk5xdjV5?=
 =?utf-8?B?ZjI4Mm5FS0NvLzI4Mk9rUzY5WVgzMEN0VTI2a1lFcUxsU1REcVhTbE83Mnpm?=
 =?utf-8?B?Ky84ZXdCYllMTS9pblZON0UxdlFVWEJENEZEKzBJd3BPV05OTWFseS82YmVI?=
 =?utf-8?B?cDk4ZG5RYnhOUWJuQXlWeWxHUEdIUDVZOSszdTlkM0tqK3d3SytlUzVFeVRl?=
 =?utf-8?B?dGJXdVJrcUZBWEJ2OFFrTlhVRFFxQ1pGa2l1aVF5b0dIMjRSMkJQeHpTdWRy?=
 =?utf-8?B?Mm11UlFlYlpzUUtUVWc2T0VFUWpOVWd1MngwN1h4OEdmWTVaMVNMOUVUZStD?=
 =?utf-8?B?d05jWG9Rd0hFaDJXOVptSms3VFVaT2FzVm9NWldRL0Y3SjhpMnBVV1NWQzl2?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EAE84E68735B2458218B6D32E2CD41F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7466ef1-5b0c-41c8-4558-08db62856c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 09:48:58.6022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20GQK9dIfloMRQ4Dw6/LE/v/jaDHzmOL98z94JX9C+I8HgUG0OBnCcQ+MFx8MGmkTmYTpLSHqAmOImSLWtzrkAqw7nsOslekbXkT2rg5cMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8087
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpPbiBU
aHUsIDIwMjMtMDYtMDEgYXQgMTE6MzIgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNl
bmRlciBvciB0aGUgY29udGVudC4NCj4gIElsIDAxLzA2LzIzIDA1OjAyLCBZdW5mZWkgRG9uZyBo
YSBzY3JpdHRvOg0KPiA+IFdpdGggdGhlIGRyaXZlciBtb3JlIGFuZCBtb3JlIGNvbXBsZXgsIGVu
Y29kZXIgYW5kIGRlY29kZXIgbmVlZCB0bw0KPiBhZGQgbW9yZSBwYXJhbWV0ZXINCj4gPiBpbiBz
aGFyZWQgc3RydWN0ICdtdGtfdmNvZGVjX2N0eCcgYW5kICdtdGtfdmNvZGVjX2RldicuIEVuY29k
ZXIgdXNlDQo+IGFib3V0IDQwJSBhbmQNCj4gPiBkZWNvZGVyIHVzZSA2MCUgcGFyYW1ldGVyLiBO
ZWVkIHRvIGFsbG9jYXRlIGV4dHJhIHVudXNlZCBtZW1vcnkNCj4gd2hlbiBlbmNvZGVyIGFuZCBk
ZWNvZGVyDQo+ID4gd29ya2luZy4NCj4gPiANCj4gPiBTZXBhcmF0ZSBlbmNvZGVyIGFuZCBkZWNv
ZGVyIGluIGRpZmZlcmVudCBmb2xkZXIgYW5kIHVzZQ0KPiBpbmRlcGVuZGVudCBkYXRhIHN0cnVj
dC4NCj4gPiANCj4gDQo+IEdyZWF0IGNsZWFudXAgaW5pdGlhdGl2ZSEgTG92ZSBpdCENCj4gDQo+
IE15IHN1Z2dnZXN0aW9uIGhlcmUgaXMgdG8gY2hhbmdlIHRoZSBuZXcgZm9sZGVyIG5hbWVzIHRv
IGRyb3AgInZpZGVvLQ0KPiAiOg0KPiB0aGlzIGlzIGFscmVhZHkgaW4gZm9sZGVyIHZjb2RlYy8g
d2hpY2ggbWVhbnMgdGhhdCBpdCBpcyB2aWRlbyBjb2RlYw0KPiByZWxhdGVkLg0KPiANCj4gU28s
IGluc3RlYWQgb2YgaGF2aW5nIGZvbGRlcnMgInZpZGVvLWNvbW1vbiIsICJ2aWRlby1kZWNvZGVy
IiwNCj4gInZpZGVvLWVuY29kZXIiLA0KPiB3ZSBzaG91bGQgaGF2ZSAiY29tbW9uIiwgImRlY29k
ZXIiLCAiZW5jb2RlciIgaW5zdGVhZC4NCj4gDQo+IENoZWVycywNCj4gQW5nZWxvDQo+IA0KSSB3
aWxsIGNoYW5nZSB0aGUgZm9sZGVyIG5hbWUgaW4gdGhlIGZ1dHVyZSBwYXRjaC4NCg0KQmVzdCBS
ZWdhcmRzLA0KWXVuZmVpIERvbmcNCg==
