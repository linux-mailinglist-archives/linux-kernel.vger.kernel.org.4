Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEBD5ED7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiI1I1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiI1I12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:27:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38937674B;
        Wed, 28 Sep 2022 01:27:24 -0700 (PDT)
X-UUID: 29c21bcc3d624c14bfed5dbdfb5b6065-20220928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rGIi9Lw18mkbmK9AUVsY/QGDJ7oMGzpVMBibNBFiPHs=;
        b=RauDXtPlVvccnvQfkBnbKleQ4v4hIhUHNLrYRZv+iC+fUtoTEz6I9RCqb6Q0FeLk3SRGxowmLClaalqpHR3goXw+tGsWefhjsXRmPL1udtwJzTb0f75LSa2tx2p/VeaAzoRXV8NFNW8G1RhpenqmK1+qHMdzi2cpgPtwrO+amsk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:fddd4991-5854-45b1-9af6-98070dae4171,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:eec04b07-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 29c21bcc3d624c14bfed5dbdfb5b6065-20220928
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1031817969; Wed, 28 Sep 2022 16:27:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 28 Sep 2022 16:27:17 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 28 Sep 2022 16:27:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkxyiNjg02i/NYqHmBz0B+O+zx2a/5tzr3MqjRUG2lXnOodCn9pkZfXrcuHLVz4G3czTYVhM2GlNBy25cJB4pMHrZR85IEM+CkjVrAVC3frL7oZhpTaZ/7/VmzRdB9h3Qife8oq5xzt/9llhnu1S244T4+9UgVzZoqO6zTJF4TFTnuNLiJ84D8G6ioZNVH+aYvmLSDOFoSqx3eaXHrYVvpI20KioWJHTJsTSYJ9NClJtNQIyoHZGh9cEU0HX9bCES0LbThqHjeEpiI2KPAqcuBlmIww9qy6HoTiXNCs5/AKCqfY5c1dBtlcBGteUZ+S55R4xosNjEIcrXcmsk1BrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGIi9Lw18mkbmK9AUVsY/QGDJ7oMGzpVMBibNBFiPHs=;
 b=l+7+Ls0WU6IcSdPHDwX+dAIK/8hPN3NeDeD+uNDSZN+Opd6DJsnzlT0+KZGUrxzra9VJUEBMUZcJW0U3T4LJRAIsR1yXYTTvxvBTSnnvH5oagggWwtEOyml/Z6JNNWs7xr14KCP63f3gAi0ofT9yT3x6lCNuUsgkaAx4uBAitfm+AjbIDs6prUquo/9IYraUvGfk7cumGn4QpfNMrokNJZYVR3C113eBhPoNW9U+d51FrVh72mhgUZPvPRtM9PTVHi14Z2cdGn+05znFra/Uj2tnO6EFTdZzYQWQQWWyGOp0CRK7tZV5Mr+cT9r9OIGApVc2srIbs/SEwBjCJ11+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGIi9Lw18mkbmK9AUVsY/QGDJ7oMGzpVMBibNBFiPHs=;
 b=Kfs+1Hxk591hGLZpd1loQWqCdHT0EnoHRG49ZWY4k1Cb2m9m/Rvja+uWIGJ2nzaMWP0tlc8VP8mqyZ5QKgbjb9bs6dwmT0IoeH5YQqrbnEmTEHiM2Hc8jYvmnL9OKbfZZNvyNNVw7/eR7bNZMdJfmWmMxpmrXV2zudDSU56kMjI=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by HK0PR03MB4754.apcprd03.prod.outlook.com (2603:1096:203:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 28 Sep
 2022 08:27:14 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::fd9e:be5e:18eb:3382]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::fd9e:be5e:18eb:3382%5]) with mapi id 15.20.5676.015; Wed, 28 Sep 2022
 08:27:13 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        =?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 04/11] remoteproc: mediatek: Remove redundant
 rproc_boot
Thread-Topic: [PATCH v3 04/11] remoteproc: mediatek: Remove redundant
 rproc_boot
Thread-Index: AQHY0hz3VPC4ao3ZCE2dhuy+ykKQqK3zHXAAgAFmi4A=
Date:   Wed, 28 Sep 2022 08:27:13 +0000
Message-ID: <71748c8dfe0fccee352d04323b40ff998031aeea.camel@mediatek.com>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
         <20220927025606.26673-5-tinghan.shen@mediatek.com>
         <da5dcffc-746f-207f-eee7-f47e2550eab0@collabora.com>
In-Reply-To: <da5dcffc-746f-207f-eee7-f47e2550eab0@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|HK0PR03MB4754:EE_
x-ms-office365-filtering-correlation-id: 404ef2f9-0e56-45b9-79a7-08daa12b3f06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUh4ov9P0ukINXh9k42vj5DlyVMA5ppuzg77OIGhRoVAFUvzVN4UeMVsaKrsnNlU6sToGcGUmokRBhd2JxNOhOsWZ8Wl1UKdsRY7uMhU7JBhj7GXapyZm05DgPuXzXpV3iifth0fewZDPYFcN75JNtpyJTtBaZgzBU/lX1CKKr/Rbqh6Gkp/KZNDvebAka9B6xQbwnX+h34ReReLQO4Q3UkhbQyfoYjlagU4bFgk0vFcpfrQ90skH9ATwqQvga/OXoQF6yNAfOtputt23DDQVu6svqnTA64lLJiu2oFvfFnhBmULeWvWeCCiHTeToaearZehoB45FLbuwCyAYj0wo2Ie2vtfgyWvjMCWaoeDAtsCpW7gSRefqoNtbIXsCiH7ZkaW3P/YmVGr9VHvZt/s77nppRBRwoQbORFjxxVZe5CrGz9A7GzAN/eYA68/Top78lbvbL42OVlX+IWr1LDCaQHeW4X6uMBJTjRr3x/58hHcntA7wu4k85odxwU+An+bEcJzTutPzVA7wpIwROhmImQ3Lc1ee4FMqzftYyqSreU7HXpjYpJCDQxG5URLMxti/u6861OmoecjgAgUNp5JkhwQ/ik93qF3Z7EUvbBUKg+/6pJCL734kAolKTyPOFeYhgXZSRacKhu9RgbkIu5Rfls6ySmdfnnStaLvQwE9ZPUkBC9nloA3PaZs0xc6Lq9nKPJu5nl09th4F5LUGwBNqGUi9tr03tgNnCoJNQQzOjzXtFaQlyA60Dl/nEEmRXW6Ummq2e/6wg8y2ZMhbQ9cTHoSd+2NeJCuG8jMYPpC4QNJzo///xHkKf/Pbg5ZlstYeRGGQiWUkmmpEByUkJbMFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(7416002)(4744005)(921005)(2906002)(8936002)(86362001)(38070700005)(66946007)(76116006)(91956017)(122000001)(38100700002)(85182001)(36756003)(186003)(2616005)(110136005)(6486002)(6512007)(71200400001)(5660300002)(64756008)(4326008)(8676002)(66556008)(66476007)(66446008)(478600001)(26005)(54906003)(6506007)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODZGLzQ5b2E4bWI0YUlFU3FZWlN1OER6bU5JTS81SldJV3l3dnFzVkRyOUtp?=
 =?utf-8?B?dWpZUGx5YzJ1clNTK2VFRG1PdGlqQ0g5VTg5Z1RDWWF3WGl5N3l0RDdTN05M?=
 =?utf-8?B?ZnFEQ1JiRGNacXF3U3BvNFZKdytMcG05aTVPZjNCTjVaZXV6aVdJM3RXR3Bl?=
 =?utf-8?B?R0REdFFSMWt4c2hIS3VLVVBwTnJVQjVBNjFldkt3R21FUnFZUTlWMXZ2MnQw?=
 =?utf-8?B?VkE2QXBQeHZJVXd6Y04vM2lqakU3bkVjZjUwTnFlVEpxeGF3OThYQUJZcmdV?=
 =?utf-8?B?S1N0UG1teThVN3loQ1dodmFYRUtRdVhnSlVPdDFlU0Q3cERDS2NWYjRSbkZJ?=
 =?utf-8?B?SnB1TXRDOGJFb1BlanoxakxJZTQ2V2hLSlAxQU84Q05raHJmcUU3Y1Era0NT?=
 =?utf-8?B?eU1RK2hVdGE4SDMxYjVUUEtJbkhuY1plT3RCYktVQXhyVzFqWk9tK1JtbXQ0?=
 =?utf-8?B?T1dkSlQrZDZISTh3eVcyamVNYzhWQXRxR3JYdzlnd2ZBblJUNi84S1FvZjQv?=
 =?utf-8?B?M1ZZVXZWQVQzaG9GNE0xVmhZZXhFUW82SlVjMVBjR2ZoOVdIOEhWZkd6ckcv?=
 =?utf-8?B?eERXQ1AzaThNS1lhN21rRENEbGNtbUUrZ3d1MTRPTUxmcEdFN0RhcVViZ1Ni?=
 =?utf-8?B?bE1GWXRFajVDWkNwbE5SQTl2cmxML29RSEpwZC9SNlRZdVFqV0JFeWQrdXBX?=
 =?utf-8?B?eTlTNC9hVnhock1zYmQzSWFwQVhQdU1LZHVDeHRpQWJuV3VWNDdZenhpZ0R1?=
 =?utf-8?B?cG5haGNZRlIxc2JLZU5qRDF5c2hDQldXWkJFS284TGJXRjFQU3daS2dPVXF1?=
 =?utf-8?B?YWNzZnQ3M0NtZW9JZUdHWjI1dFV4Vk8rTGZvVHpyM3V6eDJxTElrK3RFV0dV?=
 =?utf-8?B?aEFlbER3QkN4c002NVZPeXBHUTg4cWJLeFZEaEV0R05PVXFxejZXOHNkWFFa?=
 =?utf-8?B?WlQvam03VEh5WXNvVE1QRjlLWDhxODdFbDhLREgwTEh6TFFsdzExZ2puMFly?=
 =?utf-8?B?cjNZVnBzODQySklYUU1ZN2lHYlZFMC9JL1BnOUwzTUMwMnJ2OFhjM3FjcDdo?=
 =?utf-8?B?YTlpTzJlVWhVYmVOM3BiVjhTWmNnLzl4TFpRKy9jOFpYUFJPRnhvNDJ6RmRM?=
 =?utf-8?B?T2tIN1pvZkJrak0rZ1NmTnpGZFNENVd6SytmV2duZDBNY2JoVEtWSjRGTHZS?=
 =?utf-8?B?Mk12RzcrVGgvZlU0TmQ3UENCeWRGa3o2ZVRzZUxsMmsxT1NVclV6T0lJL3Vz?=
 =?utf-8?B?K2IzckF3cndJUXRGdnQ3enB5eU1VSU9IYndMeVlkNTdrZjg4d25kckNTc095?=
 =?utf-8?B?ZmJLcFMxZ1dHV1B2NTAvT09wKzlqaXkrcnRxYlFScHlUendldGdheWtGM0c1?=
 =?utf-8?B?TTNNQkJCbmF0bWpBekR6UVdMdTB4WHlKYVJrSlVrUzJhYnR3Yzlrb1lIMC96?=
 =?utf-8?B?eG1PTWpmNTBKWlQ4U040RHAzQkExYjIyR3VkdjUweWFzOFR3S2NEOTdmbG1m?=
 =?utf-8?B?NHZaa3UvUmliTVRxTTlwWElKRUJpb2ljZUNIai92SUpBRzhobjh2N0ppblIw?=
 =?utf-8?B?cDAzbG1ia1ZhREpmZ0dGSHJLT1I3L2VRZEc4cnpaTURuUHphb24xMGlEMjFF?=
 =?utf-8?B?cFhBVEpHeThxZGRRdDVPZGVObHkxRUNONXpkSjdXR3R1VHh0dWpnZkE2MmVn?=
 =?utf-8?B?Nkx1MGpSNm5uT0VUZWsrS3JMTHc2RVE2N2ViM2ZtVTVKZlZxRlZGa2N2Vyth?=
 =?utf-8?B?cW5hSmVkQ2NyRWNGZEFxajdMMXhQSmtCR2JwOHlRNnYxYUN5VTdRSm1TNjV6?=
 =?utf-8?B?ZUthdW5reU5jRWtyb1FYbjBXSncvS29hZXhtaDFnb1hod1VUbEpJT0FobHJy?=
 =?utf-8?B?emFRZUpjUGJTcjJKUmp4SXE3MU9IbUpZbjN1UDZ6SFVLVFArU0w3VWZYM3lU?=
 =?utf-8?B?U3JTR2VjS3c5ZXB0Y3dselNPRjJyczBOa29ISWtuU0xFMGkyYm11M0RRT0Rh?=
 =?utf-8?B?TWNnWVcxaVhsOVB3ODlCTDF6a3FGU0VkV1lEZVBWU3R1K0x6NkM4Z0VOS085?=
 =?utf-8?B?akdLSHdlaFJGa2g1blQrWnpUZTVkZzNPVWlVL0ptQURQOGJ6Rm1DMFNIZHNn?=
 =?utf-8?B?SGNCNFY2Q1N1WlRzRjkzUE9laWg4NW1TdFU2eVlpSDU2QVRueExCaURqR0E5?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6459E7D95ADABB42BCBF9C526752B81F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404ef2f9-0e56-45b9-79a7-08daa12b3f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 08:27:13.8776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kp1eMvJktvi8i6RJHBx7ub4eeFIbbFRocL2eVETgrndeHTCujERG43vib01CRFxRiJNC/IVJLjf/l/Y/H17muar1F35/aSlH6KZ5aP7RN4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4754
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA5LTI3IGF0IDEzOjAzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjcvMDkvMjIgMDQ6NTUsIFRpbmdoYW4gU2hlbiBoYSBzY3JpdHRv
Og0KPiA+IFRoZSB2aWRlbyBjb2RlYyBkb2Vzbid0IG5lZWQgdG8gZXhwbGljaXRseSBib290IFND
UCBpbiBpdHMgZmxvdw0KPiA+IGJlY2F1c2UgdGhlIFNDUCByZW1vdGUgcHJvY2Vzc29yIGVuYWJs
ZXMgYXV0byBib290Lg0KPiA+IA0KPiA+IFRoZSByZWR1bmRhbnQgdXNhZ2Ugb2YgcnByb2NfYm9v
dCBpbmNyZWFzZXMgdGhlIG51bWJlciBvZiBycHJvYy5wb3dlcg0KPiA+IG92ZXIgMSBhbmQgcHJl
dmVudHMgc3VjY2Vzc2Z1bGx5IHNodXR0aW5nIGRvd24gU0NQIGJ5IHJwcm9jX3NodXRkb3duLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpbmdoYW4gU2hlbiA8dGluZ2hhbi5zaGVuQG1lZGlh
dGVrLmNvbT4NCj4gDQo+IFlvdSBzaG91bGQgQ2Mgc3RhYmxlIG9uIHRoaXMgY29tbWl0LCBhcyBp
dCdzIGEgcXVpdGUgaW1wb3J0YW50IGZpeC4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiAN
CkhpIEFuZ2VsbywNCg0KT2ssIEknbGwgYWRkIGl0IGF0IG5leHQgdmVyc2lvbi4NCg0KVGhhbmtz
LA0KVGluZ0hhbg0K
