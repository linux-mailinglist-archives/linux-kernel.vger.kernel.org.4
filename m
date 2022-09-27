Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7B35EB97D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiI0FTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI0FTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:19:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAA21037
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 22:19:32 -0700 (PDT)
X-UUID: 69201fccbaee4ef585c2987edef0bca1-20220927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cxy9I/LBAFw7F/3jytJoWNEPBR9lydWArWYbA5kUWKQ=;
        b=Zb/WcBqxb79WSJ0TRp8wsgHOvObduFNBfoJi2qkAXEBsZ/ZbQ3IJns/vbEwkg8bmTbbGzpca4l67is9pUpT6HZonyuR6FuaCNWlSIz3HrB03VGkSU6uK7fFLUVeoqpJqNSNkQkOVr+0YlQF7CoWEMUQOetyA2O2P45IDE6jsFMo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:96250dee-d835-45dd-a9c9-965f2d9f06e9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:6da32fa3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 69201fccbaee4ef585c2987edef0bca1-20220927
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1304028244; Tue, 27 Sep 2022 13:19:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 27 Sep 2022 13:19:26 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 27 Sep 2022 13:19:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI48uBorzVZ0t93InHv4iu2XEcxMEAg/DEvV7j7zJ5DFks/JSpyslcle6nLwCo4DksPLX49LM9RbUwy4tSVrcY1CZiEDGMU4fxrw8LfAijGcBCZysrVKyOQJsZ2aAsudiSMYZF39LJpnFJKiUGbY8OCxIy1M1kRo2Pq9Dr4AssbOBF3MoxIFIN5FnGdxht1xw9zgRfpiIsCzAHMjL4Z5T6LPWUG3QRBZXumJj4PxmTByPGK5rhLhxMJ5BPLLtgDU7/ffoStnNZvpiD5Fnkbt2RW+GRb16PRxNZ6LaWW43tXDQeJVu9VjcHrTy6lwgUoOM6LkCYOuGDO5wrdx/Q1JlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxy9I/LBAFw7F/3jytJoWNEPBR9lydWArWYbA5kUWKQ=;
 b=CUo+3dxbvdidtxf9mt8rQRAhWmTbOESDBE9yUJyTKsfpY+8kBnkQa0SXb7wlhWTObZ2PMsmPPzvDTlNugO7gegohsE8Qo8oBhDlIMAYqn7AJ52aUm8vppQ/Zucjx+F4p4LuGggN2lw2khPKY4qP6uk90DXtTWnZC2r/OZ0k2C7Mt+PUfzhH9LllxwiMUllgoFTbu+fBVHeU+1u5oH3EEs2iJ9KyYUg0j3BGDpmy0Lk2fUUx6lB5AfMIbSgxIZSFB2XLRa7DaNE0XxlSyZrCHQBdFA6eVON1qiJTvwPALk0ugxq0fvGP8yyVTTzwWdzzD/ptp+ePHiG01yDjrkwxDqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxy9I/LBAFw7F/3jytJoWNEPBR9lydWArWYbA5kUWKQ=;
 b=f1QX0wS7gpzZ3qmYv4CJdbyRWmi4l+/sNZ4BASyqSHUW7NwJHUT3XFrRLRTczGjUx4wxEaOdDMAd/1hgp/iAwLqH4JJk0XM/NK/qhLdHT6PEa4Hi5jm49khZYdx1UYIxlV+k5ZUDAj2J0VkOjqoqF6m0+GXfO1xxIxTKQ8CcbcA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB4680.apcprd03.prod.outlook.com (2603:1096:820:11::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.13; Tue, 27 Sep
 2022 05:19:20 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed%7]) with mapi id 15.20.5676.011; Tue, 27 Sep 2022
 05:19:20 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>
Subject: Re: [PATCH v4] mailbox: mtk-cmdq: fix gce timeout issue
Thread-Topic: [PATCH v4] mailbox: mtk-cmdq: fix gce timeout issue
Thread-Index: AQHY0iXInBOSu79koEqudYY7JbrAZ63yvReA
Date:   Tue, 27 Sep 2022 05:19:20 +0000
Message-ID: <4f028db6f0e1b1b67df68f4adfde1f643d790b42.camel@mediatek.com>
References: <20220927040105.21494-1-yongqiang.niu@mediatek.com>
In-Reply-To: <20220927040105.21494-1-yongqiang.niu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB4680:EE_
x-ms-office365-filtering-correlation-id: b10b937c-8c7e-4a6f-d02f-08daa047d507
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYz0H0WYeKdC6gGs1BC2YnMLW6on1KLiUX2snoSIiGqQ6hLtujlIp1hAFHOv7QqPcTgEoGumjU6rXQL6BC3lXlRBLNOaoTXdwureeT5mNU87y1uX22btb3+v2PTwHboegIsUchfqQ9zFVtzxWe2ZhIuEdyvOETbl6K9c/1S2+c+xv3sFZ9L8a/L1n7fdZ9ILQEJS+x+BxvuzIdqE27efUYP/90GC30g+NzLPQ6TI8VjUCcyWgtQF5xIxDVH1Y9BLgyanb8ywHLg8zyom6WhNlqzv4GcNKQrF8cj/hkGi6UCdLRe3LDYpHGejkhlESDR7QdOgrYpHN2CK5AuYQ2OhonW/Sw/L3624Ug3wh0fzJ3qPzSu5M6y5pu/1UIki8qi15BzOd8vcanTwuSDlbbAK51sHvFw7OePR7bgMoNEvJ6KqXwpOq2L/C8QzWMREkWiYxXdAp1SFeJqNjldwM9h7ihGK8ZZtF29TqmgzQ4havKVPUHF1rvTxK/OEkf4LbYtKTMHKBHkIC5L1BNNkteuTgU8G1ydmL7YqSZvRgi0xGD3AQ0g2nPucm9cAB95z4FXca4B1WdjiujBGXus2p2oaSE/MhbuZi4soyJynig2vzR9ja/S8xhLgJjjZCtfHzQVN+f4k6bzT675hUkV5P96S1k0yMqG0ea/HDLxrsjK+wxw6LCQwdCOd9F+R4tecVBZrS6TlHwcxXUgowDIHyeSOUuR60dc6OvALLMKDBjqAdJKFxyWK1vJCMbVWIbojgDh4/U6mBBV6bIMypeBzq3uX8pv9VRnwYRM74tz+0WK96k4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(8676002)(76116006)(66446008)(66946007)(66556008)(4326008)(91956017)(5660300002)(41300700001)(316002)(110136005)(84970400001)(54906003)(66476007)(85182001)(86362001)(36756003)(8936002)(2906002)(15650500001)(83380400001)(38070700005)(64756008)(122000001)(26005)(38100700002)(6506007)(6512007)(478600001)(71200400001)(2616005)(6486002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVdDN052cTBOczZSbHRyOWhTS212WVl1YTBTNnhOMUltSFQrOFR6V3pLb2pp?=
 =?utf-8?B?SGdVU0YrRWd4TW4yKzNmK2UxQnNJS2RSMFRPeVZQYkVFQ1Q1b0NCbCtYOGRK?=
 =?utf-8?B?emZyVjM3WDdaMFVYcytDSk4zdUduSUtHU0p6MU1hR0NYV0lmSStveGFTV3gr?=
 =?utf-8?B?SU9EY1pycGFmK2VGN0psZ1JCTWpHK1UvMTJHRWR4K2FKT2lTZ0ErbDVrRmdw?=
 =?utf-8?B?U05QaW56MUdraE9LZkhmVzg3RUhPT1NaNlBJUHRhMVFQNWtSLzhudG5jdFFD?=
 =?utf-8?B?RlM2aEZlRjExNWlHc2ZXQkl0TmZ6TEs1ejVpUGJBMUlMU1l0a2g4blplVzVG?=
 =?utf-8?B?eWtuc1UwLzludWdyOWFXc2VURHlWcFdJck95dHFUSHVZMThWMTJZK0R5MytD?=
 =?utf-8?B?dGlpWWVneTk5MWlMSVYvdXlYUGlCVjk1K2tHZjVBNTV5RUcycVF0MG5ITFhn?=
 =?utf-8?B?QnRUelM0YU8xTHFML25EVzBVVmY4TEZsTjBQdnZZeVoyMmVsdVpXT3BzaU1N?=
 =?utf-8?B?YzRkWGlkMmJEam03UzJabVRYNTdkTU9CdExyMThsb2V2ZHllT2tybFlzci95?=
 =?utf-8?B?MWlRRzJ6WjdsM0l1S3A1dHRraGkramRLS0tsbHlBRDVzUE5uOVJGdE5vL09y?=
 =?utf-8?B?dW80Q0F5VCtmOGtaT2twNm9BRGUzd1NuMUJsYkNzMTZUWnN0ay9xSGs5QTk4?=
 =?utf-8?B?V0p6cUgyeGdlZUE2ZEpDd2locUhCZGVUWUp4dUlML2Z5b0tSRFdXQzlBNzlx?=
 =?utf-8?B?Tnd1bnFYQ090dG1PY0xYSjdnTVJjMVVWKzB2a01ZUGkwZVB3eWRob3lNdzB5?=
 =?utf-8?B?MXlVUXBHMDcyYU9pM0xsSmY2SGQyWlBLRFFITkF4OHhRd3B3eVptelhrMzRQ?=
 =?utf-8?B?Y1dUSzV1NVRFclVWZWdycDIxdzhTS1JBWmFlS0czRi9mQUJkOXZNajJjK3dI?=
 =?utf-8?B?Ymx1RmdnaS9qNmw4TTFXTWF4SjZPaGphUDVSSTBEUDJWZ3gxT3ZLZm1lcnFW?=
 =?utf-8?B?YWhvc0RQV1dSVzY4MFBla2pSWmhndm9TMTV6blJ5cURxTXdzVDNCZ1ZVS0pI?=
 =?utf-8?B?WTdTU3IzVFBtZWRxbFBUNW1uTjB3cm5FWUE2TWZ0OEI1ZkRweXp5N3ZYbXdm?=
 =?utf-8?B?NWdUT0tKclpBdytPYWJTWjY4NFdnSjV2a2xRMXZzTWdDSjJVYVJ1MmY3VFRy?=
 =?utf-8?B?ZENnMm5kYUZUZGlFWDRnbm5SWHRVTE9zWlhaWUVZY1VzblR0aHdsU2FJMDRY?=
 =?utf-8?B?M2w1UEhyQWZOOWJIcmEzTmdKaDVhSDREQisrRWdhUkkxUHR3a09lNkhXVHdF?=
 =?utf-8?B?SWFxWCs4K3d3NHY5UFZJdHZ6Z3c5QWszZWFReDMzUFF3ak5ncmttbkdhR3hr?=
 =?utf-8?B?dTd0YlRZTFFtWENXYUxUK21jVTJLY2tQaTdoMUV2djlLV0VFczNPUlBrb1A4?=
 =?utf-8?B?WG9iZytWdWJyeGx5T0hUMkdVZU9zYVUxZVNENllhQ0l0bXAyRm9EWkRUcklS?=
 =?utf-8?B?cXVXeXk3SC9vME4xbjdIaHMycDNkSXhvNjF1NUU3eWhwL2FWU0NNSW1KM1A0?=
 =?utf-8?B?eFVUTjFFa0cxaHpVZ3F5L3ExalZ4d0FaR2ppZ2NQM2dGdDdzb0t2U0JkOEcx?=
 =?utf-8?B?UUtUUWR6LzQvMzZKUCtqWUZsTEJmZ3JBR0V3MlJJR2k2UHJhU0VaWjBCZXRv?=
 =?utf-8?B?MW54UFVmRkFENDdpaHo4TDQ0WXNhUDNOYnRVUjc1OWZXcktWOGY4TndxVnlG?=
 =?utf-8?B?NUZGaTJDSlViWEhnN0s1WU5BRW4yNWwyVm9mV2VQalMvdFlWWnpBZXlLYW4w?=
 =?utf-8?B?dG43aXBWK0JlZGVZSnVJdHIyMVlORC9BbS92T3ppUzdVdWkwRm5oaC90QnZp?=
 =?utf-8?B?cFdQSDhmV3ZyQjl2WWtVRGdoRkNISUhJc2ZEMnRpQmsyek5JbFk4SHQ1TlA2?=
 =?utf-8?B?Q0xFSFNuZmxoMDNabGUrbmRodVNRTHJKSzd5NFZIUEhhYjM2YzBUNzRVeGFY?=
 =?utf-8?B?cGlnMXRVT2FweVY5ZlRzMlo3R2NRLzdJQnZkM0dnOWxxOG1jQVBWY2VJNCtx?=
 =?utf-8?B?V3BRaDliNHpDQVJsN0s3ZnpVNk12TGRWN3p2VGwvc014RG05OWNEb2F3Q3JW?=
 =?utf-8?Q?N+WyUowyDPRvoAKaX3rOKsdWO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00114B36BB7CF24C812580EDFA95F234@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10b937c-8c7e-4a6f-d02f-08daa047d507
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 05:19:20.3371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tE1L4M8CPVYOl+zvqbThrZ/c/g2Mubf/N+dkaMsukJyWNG/kec4yOhqCvNf3wtjxLZUeQBg03gNMMt1ujZqfVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB4680
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gVHVlLCAyMDIyLTA5LTI3IGF0IDEyOjAxICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiAxLiBlbmFibGUgZ2NlIGRkciBlbmFibGUoZ2NlIHJlaWdzdGVy
IG9mZnNldCAweDQ4LCBiaXQgMTYgdG8gMTgpIHdoZW4NCj4gZ2NlIHdvcmssDQo+IGFuZCBkaXNh
YmxlIGdjZSBkZHIgZW5hYmxlIHdoZW4gZ2NlIHdvcmsgam9iIGRvbmUNCj4gMi4gYWRkIGNtZHEg
ZGRyIGVuYWJsZS9kaXNhYmxlIGFwaSwgYW5kIGNvbnRyb2wgZ2NlIGRkcg0KPiBlbmFibGUvZGlz
YWJsZQ0KPiB0byBtYWtlIHN1cmUgaXQgY291bGQgcHJvdGVjdCB3aGVuIGNtZHEgaXMgbXVsdGlw
bGUgdXNlZCBieSBkaXNwbGF5DQo+IGFuZCBtZHANCj4gDQo+IHRoaXMgaXMgb25seSBmb3Igc29t
ZSBTT0Mgd2hpY2ggaGFzIGZsYWcgImdjZV9kZHJfZW4iLg0KPiBmb3IgdGhpcyBraW5kIG9mIGdj
ZSwgdGhlcmUgaXMgYSBoYW5kc2hha2UgZmxvdyBiZXR3ZWVuIGdjZSBhbmQgZGRyDQo+IGhhcmR3
YXJlLA0KPiBpZiBub3Qgc2V0IGRkciBlbmFibGUgZmxhZyBvZiBnY2UsIGRkciB3aWxsIGZhbGwg
aW50byBpZGxlIG1vZGUsDQo+IHRoZW4gZ2NlIGluc3RydWN0aW9ucyB3aWxsIG5vdCBwcm9jZXNz
IGRvbmUuDQo+IHdlIG5lZWQgc2V0IHRoaXMgZmxhZyBvZiBnY2UgdG8gdGVsbCBkZHIgd2hlbiBn
Y2UgaXMgaWRsZSBvciBidXN5DQo+IGNvbnRyb2xsZWQgYnkgc29mdHdhcmUgZmxvdy4NCj4gDQo+
IGRkciBwcm9ibGVtIGlzIGEgc3BlY2lhbCBjYXNlLg0KPiB3aGVuIHRlc3Qgc3VzcGVuZC9yZXN1
bWUgY2FzZSwgZ2NlIHNvbWV0aW1lcyB3aWxsIHB1bGwgZGRyLCBhbmQgZGRyDQo+IGNhbg0KPiBu
b3QgZ28gdG8gc3VzcGVuZC4NCj4gaWYgd2Ugc2V0IGdjZSByZWdpc3RlciAweDQ4IHRvIDB4Nywg
d2lsbCBmaXggdGhpcyBnY2UgcHVsbCBkZHIgaXNzdWUsDQo+IGFzIHlvdSBoYXZlIHJlZmVycmVk
IFsxXSBhbmQgWzJdICg4MTkyIGFuZCA4MTk1KQ0KPiBidXQgZm9yIG10ODE4NiwgdGhlIGdjZSBp
cyBtb3JlIHNwZWNpYWwsIGV4Y2VwdCBzZXR0aW5nIG9mIFsxXSBhbmQNCj4gWzJdLA0KPiB3ZSBu
ZWVkIGFkZCBtb3JlIHNldHRpbmcgc2V0IGdjZSByZWdpc3RlciAweDQ4IHRvICgweDcgPDwgMTYg
fCAweDcpDQo+IHdoZW4gZ2NlIHdvcmtpbmcgdG8gbWFrZSBzdXJlIGdjZSBjb3VsZCBwcm9jZXNz
IGFsbCBpbnN0cnVjdGlvbnMgb2suDQo+IHRoaXMgY2FzZSBqdXN0IG5lZWQgbm9ybWFsIGJvb3R1
cCwgaWYgd2Ugbm90IHNldCB0aGlzLCBkaXNwbGF5IGNtZHENCj4gdGFzayB3aWxsIHRpbWVvdXQs
IGFuZCBjaHJvbWUgaG9tZXNjcmVlbiB3aWxsIGFsd2F5cyBibGFjayBzY3JlZW4uDQo+IA0KPiBh
bmQgd2l0aCB0aGlzIHBhdGNoLCB3ZSBoYXZlIGRvbmUgdGhlc2UgdGVzdCBvbiBtdDgxODY6DQo+
IDEuc3VzcGVuZC9yZXN1bWUNCj4gMi5ib290IHVwIHRvIGhvbWUgc2NyZWVuDQo+IDMucGxheWJh
Y2sgdmlkZW8gd2l0aCB5b3V0dWJlLg0KPiANCj4gc3VzcGVuZCBpc3N1ZSBpcyBzcGVjaWFsIGdj
ZSBoYXJkd2FyZSBpc3N1ZSwgZ2NlIGNsaWVudCAgZHJpdmVyDQo+IGNvbW1hbmQgYWxyZWFkeSBw
cm9jZXNzIGRvbmUsIGJ1dCBnY2Ugc3RpbGwgcHVsbCBkZHIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gDQo+IC0tLQ0K
PiBjaGFuZ2Ugc2luY2UgdjM6DQo+IHNwbGl0IGNtZHFfc3dfZGRyX2VuYWJsZS9jbWRxX3N3X2Rk
cl9kaXNhYmxlIGludG8gc2luZ2xlIGFwaSB0bw0KPiBjb250cm9sIG10ODE4NiBnY2UgZGRyIGVu
YWJsZSBmbG93DQo+IC0tLQ0KPiANCj4gLS0tDQo+ICBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5jIHwgNjENCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5jDQo+IGluZGV4IDk0NjVmOTA4MTUxNS4uNjUwYTFlZDFhNTc5IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ICsrKyBiL2RyaXZlcnMv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gQEAgLTM4LDYgKzM4LDggQEANCj4gICNkZWZp
bmUgQ01EUV9USFJfUFJJT1JJVFkJCTB4NDANCj4gIA0KPiAgI2RlZmluZSBHQ0VfR0NUTF9WQUxV
RQkJCTB4NDgNCj4gKyNkZWZpbmUgR0NFX0NUUkxfQllfU1cJCQkJR0VOTUFTSygxOCwgMTYpDQo+
ICsjZGVmaW5lIEdDRV9ERFJfRU4JCQkJR0VOTUFTSygyLCAwKQ0KPiAgDQo+ICAjZGVmaW5lIENN
RFFfVEhSX0FDVElWRV9TTE9UX0NZQ0xFUwkweDMyMDANCj4gICNkZWZpbmUgQ01EUV9USFJfRU5B
QkxFRAkJMHgxDQo+IEBAIC04MCwxNiArODIsNTEgQEAgc3RydWN0IGNtZHEgew0KPiAgCWJvb2wJ
CQlzdXNwZW5kZWQ7DQo+ICAJdTgJCQlzaGlmdF9wYTsNCj4gIAlib29sCQkJY29udHJvbF9ieV9z
dzsNCj4gKwlib29sCQkJc3dfZGRyX2VuOw0KPiAgCXUzMgkJCWdjZV9udW07DQo+ICsJYXRvbWlj
X3QJCXVzYWdlOw0KPiArCXNwaW5sb2NrX3QJCWxvY2s7DQo+ICB9Ow0KPiAgDQo+ICBzdHJ1Y3Qg
Z2NlX3BsYXQgew0KPiAgCXUzMiB0aHJlYWRfbnI7DQo+ICAJdTggc2hpZnQ7DQo+ICAJYm9vbCBj
b250cm9sX2J5X3N3Ow0KPiArCWJvb2wgc3dfZGRyX2VuOw0KPiAgCXUzMiBnY2VfbnVtOw0KPiAg
fTsNCj4gIA0KPiArc3RhdGljIHZvaWQgY21kcV9zd19kZHJfZW5hYmxlKHN0cnVjdCBjbWRxICpj
bWRxKQ0KPiArew0KPiArCXMzMiB1c2FnZTsNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAr
DQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJmNtZHEtPmxvY2ssIGZsYWdzKTsNCj4gKw0KPiArCXVz
YWdlID0gYXRvbWljX2luY19yZXR1cm4oJmNtZHEtPnVzYWdlKTsNCj4gKw0KPiArCWlmICh1c2Fn
ZSA8PSAwKQ0KPiArCQlkZXZfZXJyKGNtZHEtPm1ib3guZGV2LCAicmVmIGNvdW50ICVkIHN1c3Bl
bmQgJWRcbiIsDQo+ICsJCQl1c2FnZSwgY21kcS0+c3VzcGVuZGVkKTsNCj4gKwllbHNlIGlmICh1
c2FnZSA9PSAxKQ0KPiArCQl3cml0ZWwoR0NFX0REUl9FTiArIEdDRV9DVFJMX0JZX1NXLCBjbWRx
LT5iYXNlICsNCj4gR0NFX0dDVExfVkFMVUUpOw0KPiArDQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmY21kcS0+bG9jaywgZmxhZ3MpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBjbWRx
X3N3X2Rkcl9kaXNhYmxlKHN0cnVjdCBjbWRxICpjbWRxKQ0KPiArew0KPiArCXMzMiB1c2FnZTsN
Cj4gKw0KPiArCXVzYWdlID0gYXRvbWljX2RlY19yZXR1cm4oJmNtZHEtPnVzYWdlKTsNCj4gKw0K
PiArCWlmICh1c2FnZSA8IDApDQo+ICsJCWRldl9lcnIoY21kcS0+bWJveC5kZXYsICJyZWYgY291
bnQgJWQgc3VzcGVuZCAlZFxuIiwNCj4gKwkJCXVzYWdlLCBjbWRxLT5zdXNwZW5kZWQpOw0KPiAr
CWVsc2UgaWYgKHVzYWdlID09IDApDQo+ICsJCXdyaXRlbChHQ0VfQ1RSTF9CWV9TVywgY21kcS0+
YmFzZSArIEdDRV9HQ1RMX1ZBTFVFKTsNCj4gK30NCj4gKw0KPiAgdTggY21kcV9nZXRfc2hpZnRf
cGEoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gIHsNCj4gIAlzdHJ1Y3QgY21kcSAqY21kcSA9
IGNvbnRhaW5lcl9vZihjaGFuLT5tYm94LCBzdHJ1Y3QgY21kcSwNCj4gbWJveCk7DQo+IEBAIC0y
NjYsNiArMzAzLDEwIEBAIHN0YXRpYyB2b2lkIGNtZHFfdGhyZWFkX2lycV9oYW5kbGVyKHN0cnVj
dCBjbWRxDQo+ICpjbWRxLA0KPiAgDQo+ICAJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19i
dXN5X2xpc3QpKSB7DQo+ICAJCWNtZHFfdGhyZWFkX2Rpc2FibGUoY21kcSwgdGhyZWFkKTsNCj4g
Kw0KPiArCQlpZiAoY21kcS0+c3dfZGRyX2VuKQ0KPiArCQkJY21kcV9zd19kZHJfZGlzYWJsZShj
bWRxKTsNCj4gKw0KPiAgCQljbGtfYnVsa19kaXNhYmxlKGNtZHEtPmdjZV9udW0sIGNtZHEtPmNs
b2Nrcyk7DQo+ICAJfQ0KPiAgfQ0KPiBAQCAtMzU3LDYgKzM5OCw4IEBAIHN0YXRpYyBpbnQgY21k
cV9tYm94X3NlbmRfZGF0YShzdHJ1Y3QgbWJveF9jaGFuDQo+ICpjaGFuLCB2b2lkICpkYXRhKQ0K
PiAgCWlmIChsaXN0X2VtcHR5KCZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0KSkgew0KPiAgCQlXQVJO
X09OKGNsa19idWxrX2VuYWJsZShjbWRxLT5nY2VfbnVtLCBjbWRxLT5jbG9ja3MpKTsNCj4gIA0K
PiArCQlpZiAoY21kcS0+c3dfZGRyX2VuKQ0KPiArCQkJY21kcV9zd19kZHJfZW5hYmxlKGNtZHEp
Ow0KDQpXaHkgZG8geW91IGR5bmFtaWNhbGx5IGVuYWJsZS9kaXNhYmxlIGl0IHdoZW4gcHJvY2Vz
cyBldmVyeSBwYWNrZXQ/IFdoeQ0Kbm90IGVuYWJsZSBpdCBpbiBjbWRxX21ib3hfc3RhcnR1cCgp
IGFuZCBkaXNhYmxlIGl0IGluDQpjbWRxX21ib3hfc2h1dGRvd24oKSwgc28geW91IGRvbid0IG5l
ZWQgYW4gZXh0cmEgbG9jayBmb3Igc3BpbmxvY2suDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAJCS8q
DQo+ICAJCSAqIFRoZSB0aHJlYWQgcmVzZXQgd2lsbCBjbGVhciB0aHJlYWQgcmVsYXRlZCByZWdp
c3Rlcg0KPiB0byAwLA0KPiAgCQkgKiBpbmNsdWRpbmcgcGMsIGVuZCwgcHJpb3JpdHksIGlycSwg
c3VzcGVuZCBhbmQNCj4gZW5hYmxlLiBUaHVzDQo+IEBAIC00MjcsNiArNDcwLDkgQEAgc3RhdGlj
IHZvaWQgY21kcV9tYm94X3NodXRkb3duKHN0cnVjdCBtYm94X2NoYW4NCj4gKmNoYW4pDQo+ICAJ
CWtmcmVlKHRhc2spOw0KPiAgCX0NCj4gIA0KPiArCWlmIChjbWRxLT5zd19kZHJfZW4pDQo+ICsJ
CWNtZHFfc3dfZGRyX2Rpc2FibGUoY21kcSk7DQo+ICsNCj4gIAljbWRxX3RocmVhZF9kaXNhYmxl
KGNtZHEsIHRocmVhZCk7DQo+ICAJY2xrX2J1bGtfZGlzYWJsZShjbWRxLT5nY2VfbnVtLCBjbWRx
LT5jbG9ja3MpOw0KPiAgDQo+IEBAIC00NjgsNiArNTE0LDEwIEBAIHN0YXRpYyBpbnQgY21kcV9t
Ym94X2ZsdXNoKHN0cnVjdCBtYm94X2NoYW4NCj4gKmNoYW4sIHVuc2lnbmVkIGxvbmcgdGltZW91
dCkNCj4gIA0KPiAgCWNtZHFfdGhyZWFkX3Jlc3VtZSh0aHJlYWQpOw0KPiAgCWNtZHFfdGhyZWFk
X2Rpc2FibGUoY21kcSwgdGhyZWFkKTsNCj4gKw0KPiArCWlmIChjbWRxLT5zd19kZHJfZW4pDQo+
ICsJCWNtZHFfc3dfZGRyX2Rpc2FibGUoY21kcSk7DQo+ICsNCj4gIAljbGtfYnVsa19kaXNhYmxl
KGNtZHEtPmdjZV9udW0sIGNtZHEtPmNsb2Nrcyk7DQo+ICANCj4gIG91dDoNCj4gQEAgLTU0Myw2
ICs1OTMsNyBAQCBzdGF0aWMgaW50IGNtZHFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0K
PiAqcGRldikNCj4gIAljbWRxLT50aHJlYWRfbnIgPSBwbGF0X2RhdGEtPnRocmVhZF9ucjsNCj4g
IAljbWRxLT5zaGlmdF9wYSA9IHBsYXRfZGF0YS0+c2hpZnQ7DQo+ICAJY21kcS0+Y29udHJvbF9i
eV9zdyA9IHBsYXRfZGF0YS0+Y29udHJvbF9ieV9zdzsNCj4gKwljbWRxLT5zd19kZHJfZW4gPSBw
bGF0X2RhdGEtPnN3X2Rkcl9lbjsNCj4gIAljbWRxLT5nY2VfbnVtID0gcGxhdF9kYXRhLT5nY2Vf
bnVtOw0KPiAgCWNtZHEtPmlycV9tYXNrID0gR0VOTUFTSyhjbWRxLT50aHJlYWRfbnIgLSAxLCAw
KTsNCj4gIAllcnIgPSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgY21kcS0+aXJxLCBjbWRxX2lycV9o
YW5kbGVyLA0KPiBJUlFGX1NIQVJFRCwNCj4gQEAgLTYxNSw2ICs2NjYsNyBAQCBzdGF0aWMgaW50
IGNtZHFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIA0KPiAgCVdB
Uk5fT04oY2xrX2J1bGtfcHJlcGFyZShjbWRxLT5nY2VfbnVtLCBjbWRxLT5jbG9ja3MpKTsNCj4g
IA0KPiArCXNwaW5fbG9ja19pbml0KCZjbWRxLT5sb2NrKTsNCj4gIAljbWRxX2luaXQoY21kcSk7
DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gQEAgLTY2MCw5ICs3MTIsMTggQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBnY2VfcGxhdCBnY2VfcGxhdF92NiA9IHsNCj4gIAkuZ2NlX251bSA9IDINCj4gIH07
DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRfdjcgPSB7DQo+
ICsJLnRocmVhZF9uciA9IDI0LA0KPiArCS5zaGlmdCA9IDMsDQo+ICsJLmNvbnRyb2xfYnlfc3cg
PSB0cnVlLA0KPiArCS5zd19kZHJfZW4gPSB0cnVlLA0KPiArCS5nY2VfbnVtID0gMQ0KPiArfTsN
Cj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgY21kcV9vZl9pZHNbXSA9
IHsNCj4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWdjZSIsIC5kYXRhID0gKHZv
aWQNCj4gKikmZ2NlX3BsYXRfdjJ9LA0KPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
ODMtZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF92M30sDQo+ICsJey5jb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE4Ni1nY2UiLCAuZGF0YSA9ICh2b2lkDQo+ICopJmdjZV9wbGF0
X3Y3fSwNCj4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5LWdjZSIsIC5kYXRhID0g
KHZvaWQNCj4gKikmZ2NlX3BsYXRfdjR9LA0KPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDgxOTItZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF92NX0sDQo+ICAJey5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1nY2UiLCAuZGF0YSA9ICh2b2lkDQo+ICopJmdjZV9w
bGF0X3Y2fSwNCg==
