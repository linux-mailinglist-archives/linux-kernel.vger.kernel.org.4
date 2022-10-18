Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC32602405
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJRFvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJRFvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:51:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D054C5208D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:51:40 -0700 (PDT)
X-UUID: 51c28da1d78a4fe4bd90a7f5dbebb608-20221018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=IEt34iyP2upuE0wEPuy2yVTwjwJ9LOlL52xUb/sYyG4=;
        b=MNAYvAA6z3nrzmgahoNcamhu7ywejfDiW0W+MlfnFn8L5rQmPGgWqrAor8c2VsLMEHgNqSgaCQZpAJDp0e/ZkZoCqSTHw3hz1zYmShkLkzHQEvD06QATApn7II+6bTi18Poswm1sTbnUXOVhXu92cAFAXHMm/q9WhmvnBwesmgI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:b759c305-38c1-41c1-9a27-f8357efcf605,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:55411ea3-73e4-48dd-a911-57b5d5484f14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 51c28da1d78a4fe4bd90a7f5dbebb608-20221018
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1284728660; Tue, 18 Oct 2022 13:51:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 18 Oct 2022 13:51:32 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 18 Oct 2022 13:51:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TePhHs4KFq9d3FpR2SLbWmkt2wCwQpesJEyEOIwO69TRkwvGnTnv2wde1UFIuqSDQ3g8ZKhvC07+xQ7bD/EGv6oYgMwBoGVa7JodxKo0Si1ekv1qJ3SblKK3ECIsoUdm31ghXpyxHMO0S6G9JH5e4/Frvw9wYylR7Ej0NS+Mw4qw/EH0bUhCoRuy5+LIyFcysiz77zk36lc+b6G/HTUSuVQnAGfk6PdXaoYyYgQpyBONUNMlsmmWWVBbBoagYrxhhjO7tiwlORHEk0hLFmmi6Klv1fkwm1dCqo4KVc/DtqDnoS357Bsv2ckPtfS9Wv5cxqqm9yJAP5EbSGXwXqbX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEt34iyP2upuE0wEPuy2yVTwjwJ9LOlL52xUb/sYyG4=;
 b=C97SrEgHIUKb7T4t4O6lEQ5O92nqVGlNGs8LLzTthkQOMyyUACKEOyNJxiChzHSQGGXxSXKzNYqfaypVp4UpxAuF1W4Kg1Tuq9Dlfsq1B0E5tI6iaA++jwxXkzatMjm6TYt7IvK1Kfr0V6Aps89H83nerEYMeRyjszAdJhk6rDZ7d/CzfdCGO0GnX1BJ0DJQJf2+6r+aOdYk2u1dy0MFGUjJnZSM19GI6MpdqLbkx6hQ8OLjXN8MWf3OlhcYPAgl/+bTWfz/zDZ6p57qEpdjjVCQk5Zi/pUktRz+8VeSS7UspPypiIAmHr+vaRzkaZgRXvc3q49PtEzj/DS/moM3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEt34iyP2upuE0wEPuy2yVTwjwJ9LOlL52xUb/sYyG4=;
 b=QUAfrg1dEQTL+Df6XR/dT1Xyjoqn73pu4+0Lxo2lFeIU4HE8z3zl2HDiRlluvncFgWeRC8ihbMk6JNDRdPnvcU+ZiAxS3a3KLXj1hQ9dzzgm94u+UOG+MmQCOACPXmX7idihJQ1THbJ/1RIa7AndsBLpcaegPPEbEU7wrqgPECI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB6968.apcprd03.prod.outlook.com (2603:1096:301:f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.6; Tue, 18 Oct
 2022 05:51:30 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::7559:b2bb:eee0:fac]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::7559:b2bb:eee0:fac%5]) with mapi id 15.20.5746.015; Tue, 18 Oct 2022
 05:51:30 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v10, 3/4] mailbox: mtk-cmdq: add gce ddr enable support
 flow
Thread-Topic: [PATCH v10, 3/4] mailbox: mtk-cmdq: add gce ddr enable support
 flow
Thread-Index: AQHY3JwepB3EzI+nAEGXbEkHnCE7Vq4Tsh2A
Date:   Tue, 18 Oct 2022 05:51:30 +0000
Message-ID: <7003a88b24c8d2d096c5a5dacf13336c62a2ef4f.camel@mediatek.com>
References: <20221010085023.7621-1-yongqiang.niu@mediatek.com>
         <20221010085023.7621-4-yongqiang.niu@mediatek.com>
In-Reply-To: <20221010085023.7621-4-yongqiang.niu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB6968:EE_
x-ms-office365-filtering-correlation-id: b9819041-b878-43c5-2a48-08dab0cccdf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z1K35Q90OmTS9vo1fxFlGuAD5uoVTYCAbKuyWgfy2etAdqj8uMltbo1GfuE6+CbQSt65dkQOKrcu4oLwSef7zBZusey5/J6wxR1tiWb2BQsrhYrUzqMfFmpwyKH9h8SXtvRLOiI2Ljbp9sYZl07mxFkteIbtFqyZMcXPawyrvPwhXzEfzfEbZlHsPM3jrsCFFeH280Jl7koc+01TbriPYmc+m62cR3v3ZH58ucuz13hCYPdp5YV904X13wpsqOPUfWd73StEfelXmXv3JdBVw8/EgAvi6DA7hVLuTIAUSGE49AjCKNWwM9WQ92GAgQFcB8f4XmnoZr0/9vQt129Ob86VxpwtZ0lBuZ4jSj8i7/vYfK7kzQHS97o5dNCfWbmzOuizuT7Y7YyXioICB5JSbchvHtbVlD/kpqWpFgKtTai/aKzXD2rVfsmieGrg9WPrky+/D16oMor41D5RUp+vpKC/kUJT7//FKABPTQPgHwMW0BzGgaphp7w3W/os40vKS+tqsWqu/IGq+pgCWGpJvqnfvxTaXPH80wopwUnSR8LHo4lGEDOLk5hMy8iVkEIvqy1W94A/ZKjS9dpXrBDBtuzir8BbE3Q3PYrNjhHrJUrqpK6IHJGJe0vyDImVcK2X2KtGsGkow1BzYvEZcI35aXml37oEp9wgvV0GDeQv2H/S7sayaVjVbi5IzVuKiX/1wV0kqbA7VfAF1XgmkTVMmp9q4c8C2+BLVY5a92IyR86TGVNIKCn9zLgp71AfmC4Rw47XZ6BWzFIUDKhp2ehG6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(71200400001)(122000001)(2906002)(4001150100001)(38100700002)(38070700005)(15650500001)(5660300002)(26005)(83380400001)(86362001)(6512007)(2616005)(186003)(478600001)(36756003)(6486002)(85182001)(6506007)(4326008)(66556008)(76116006)(66476007)(66446008)(64756008)(110136005)(54906003)(8676002)(41300700001)(66946007)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0h2RUxVVmtpTkJuNFV1Y2E1bkRYU2R0WG1kblRQQUdnWWxYQVJyM0p4M2Ir?=
 =?utf-8?B?a2VtZDZwNDQxdldpVVpsR0lQOGJQNmQ0OEdqWmxxV3doeldyMkxhMHBWN3Zs?=
 =?utf-8?B?SjM1OTBCczlrYVpIM2crUGU5WE1tNGR6R2Vka0E3dXdaUFlwVWJtYzZCTUZj?=
 =?utf-8?B?QXZ4UTJ4OTBKemV3WE00ZDJqWW01Skw5OUpvODdLMFJVVG5xbmhOZThxdTZG?=
 =?utf-8?B?ak1obUEvR0pkdmtzajcxTnErR0Q4VjY3dW82SlF0MDQ5Z3MzZ3RjTDlpemNy?=
 =?utf-8?B?REE4L04yaVBtY0ZybVB5YWJjNXF1TmFkSWN4b2toZkYyZ3hJbHErTnpKdnEw?=
 =?utf-8?B?cWJGQy9iS2pPeGhVMktqb2dzNlNLWVVmL25STTNQTVo2M0I1ZVBadnlpcjBj?=
 =?utf-8?B?eWJrbGlxbGo0b2kxM3JQSmptUjJaK01mOEI5NnRFcHFzUSs3aFVib2RNdmlG?=
 =?utf-8?B?QkxwRmwvTnVkZ2JzRHdqWFEyUUV3aHlRc1QvSExwdmlFZ3FYczlKejhONG1z?=
 =?utf-8?B?UURMc0JidnBTRVBObktpYkJJTG9YcWY2aHpoUXZuNm5WMnN4bHVFQmw2U0Nh?=
 =?utf-8?B?L2Y1YmEwVlQ3ZG1zS1pnblQwWkNvTFNhOU1VbmpuSjdDaUJzRS9zSVBuZEwr?=
 =?utf-8?B?eFUrVFp3UVN5d3lpYWtzMWhNK0hlck1IS3FKU1FtSmtzS2xhWHlXV3JNSjVp?=
 =?utf-8?B?ZG5YTVhIaHc4NkR1b3FrT3NXSFU3NW8yaFRYbmdDdC9WSnloUmRuT2VhWFhN?=
 =?utf-8?B?UG9EdzdmM09LUFhWRWpNVFY1OXFmb3lrSlliaGdPeHM0QWxMWDRCdmcxM0pU?=
 =?utf-8?B?ZXZ5cGRNeG1rZ1U1ZWp1ajliWUNIdU1WbHF5VXJMSzliWkVhQ3l3UytWd2tK?=
 =?utf-8?B?Z2EvZ2wwS0d5dE0zRmVsQThmckNiVzNNdGhIMWJjUXNwYzlWeDBvT2orRlo0?=
 =?utf-8?B?R2VTREg2bnQzbkhNb3dmeTFUMzAxMjArVWM5WEwrMjJ0dmxYRnpGQlpmMHp1?=
 =?utf-8?B?SGFFMENwa2Zub0ppKyt3M0tlS1Jma0U3T09OaUFnY29wbFlqSzAxVCs1TFV2?=
 =?utf-8?B?Smg4TksvMFFtY1BQT0RRRHNJY2tmM2I0bHdvSVBrck12VStVNGdqSFNSTmFM?=
 =?utf-8?B?RFYrV3QyakNFbVNXY3BOb05OUEN1QzUxOW1OQkdXdk9qOGl5Sy9nVWlRdXNo?=
 =?utf-8?B?Vit6cWVVbU13d0VpWGM1SzFSVnM0NVNxWTQvYzlpdWM4ejVDSXBubGhqNzdo?=
 =?utf-8?B?T1RHYzJTYmlYVXpJSkRlUU9EbUNoNXhnaGdNT0VVSnFSYkt4TWJyejlyTjdu?=
 =?utf-8?B?aDY2czNlQ3FROGJtS3E4SHdHeTB2NFB3Sk15cHc5ZkErbnRzeWFtckhHVnlC?=
 =?utf-8?B?blBVaG4zeXcxYWtEeHEwTU93ekFVdCtaVUQ5bEZSSUVCR2RLU3hXeGhRSU50?=
 =?utf-8?B?NU05R2tXMHVSb1NJcGRqeVBna2tNUFYraEFMTm9ISm9ySUZ3Nmo3bnMzUDVr?=
 =?utf-8?B?V0diRy9STGhRWlZ5WXJwazQ0dEwzWWh2OEhhdGVNUlNOaDVSdkpMNmtWT01M?=
 =?utf-8?B?b0dPU2U0d2VGMnF3M2k4dmVoNDhSdnA1ejhkUlBHTzc1MTNQZjB4emIxcW5l?=
 =?utf-8?B?cmprUUdWWVJidEhWQ0pkVW1PQWVreVhpVVFKb256TGhGajI4Q0JBOHprckpy?=
 =?utf-8?B?RkRvSFFPQzZvWnM2aHhvcVNRTmUvRi9jVTBITjlmdnJsZTRPVmJFdEJHV1A4?=
 =?utf-8?B?L2ZiZktuZHlPVjJXVHoxWHJGZzdQVGpMUHRkSzBxcXFINEZ6YkF0K0IyYys2?=
 =?utf-8?B?REZiUnVVUWhGNE1GWU9HWWFlaVBFMXZPOGxJSWxadzhDQ1NLcVQ3emtRSjl2?=
 =?utf-8?B?Yk5NbDZWMmlkU3pvb0lLTkRpeDNPb0tidlhDTWZ6NFViL1Zmd0JScy9yaXFE?=
 =?utf-8?B?dTdnMDNZczcwNTlTYUZnY3Qxbm51bXFwSmNLeDl4Q0Q2SmZkTmppS2tWUEln?=
 =?utf-8?B?WDl0cWRNWGw4V0pxS1d1a0dFaE54ek90dXBCS2ZLc1pXcFlwYVJlWnRXSlVh?=
 =?utf-8?B?Y0tEWnE2K2txUUlzMWE4ZllONGdXL2poQ1VmYk1tcks3OW9NaVVaU0JobURn?=
 =?utf-8?B?WTQxSTBDanNJZmZCK0NBME1jMnI5MzF5Z1FscGxrTWVFayt4elQreG42aXhH?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88FB2C419F60014DBA73BC7445E61A93@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9819041-b878-43c5-2a48-08dab0cccdf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 05:51:30.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wk4KzYBwaGlrCN/9bJDsBl9mxOKV7VApCmjA9K5rq9MJVvHaXBmD+XzzejY5P4O3bd9c4JVVbsXsXRcMcwVZwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6968
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gTW9uLCAyMDIyLTEwLTEwIGF0IDE2OjUwICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBhZGQgZ2NlIGRkciBlbmFibGUgY29udHJvbCBmbG93IHdoZW4g
Z2NlIHN1c3BlbmQvcmVzdW1lDQo+IA0KPiB3aGVuIGFsbCBjbWRxIGluc3RydWN0aW9uIHRhc2sg
aGFzIGJlZW4gcHJvY2Vzc2VkIGRvbmUsDQo+IHdlIG5lZWQgc2V0IHRoaXMgZ2NlIGRkciBlbmFi
bGUgdG8gZGlzYWJsZSBzdGF0dXMgdG8gdGVsbA0KPiBjbWRxIGhhcmR3YXJlIGdjZSB0aGVyZSBp
cyBub25lIHRhc2sgbmVlZCBwcm9jZXNzLCBhbmQgdGhlIGhhcmR3YXJlDQo+IGNhbiBnbyBpbnRv
IGlkbGUgbW9kZSBhbmQgbm8gYWNjZXNzIGRkciBhbnltb3JlLCB0aGVuIHRoZSBzcG0gY2FuIGdv
DQo+IGludG8gc3VzcGVuZC4NCj4gDQo+IHRoZSBvcmlnaW5hbCBpc3N1ZSBpcyBnY2Ugc3RpbGwg
YWNjZXNzIGRkciB3aGVuIGNtZHEgc3VzcGVuZCBmdW5jdGlvbg0KPiBjYWxsLCBidXQgdGhlcmUg
aXMgbm8gdGFzayBydW4uDQo+IHNvLCB3ZSBuZWVkIGNvbnRyb2wgZ2NlIGFjY2VzcyBkZHIgd2l0
aCB0aGlzIGZsb3cuDQo+IHdoZW4gY21kcSBzdXNwZW5kIGZ1bmN0aW9uLCB0aGVyZSBpcyBubyB0
YXNrIG5lZWQgcHJvY2Vzcywgd2UgY2FuDQo+IGRpc2FibGUgZ2NlIGFjY2VzcyBkZHIsIHRvIG1h
a2Ugc3VyZSBzeXN0ZW0gZ28gaW50byBzdXNwZW5kIHN1Y2Nlc3MuDQoNClJldmlld2VkLWJ5OiBD
SyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlh
bmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFuZ2Vs
b0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xs
YWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMg
fCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMNCj4gYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IGluZGV4IGQy
MzYzYzZiOGI3YS4uNTM5MDQ1MTE1OThkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5jDQo+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMNCj4gQEAgLTk0LDYgKzk0LDE4IEBAIHN0cnVjdCBnY2VfcGxhdCB7DQo+ICAJdTMyIGdj
ZV9udW07DQo+ICB9Ow0KPiAgDQo+ICtzdGF0aWMgdm9pZCBjbWRxX3N3X2Rkcl9lbmFibGUoc3Ry
dWN0IGNtZHEgKmNtZHEsIGJvb2wgZW5hYmxlKQ0KPiArew0KPiArCVdBUk5fT04oY2xrX2J1bGtf
ZW5hYmxlKGNtZHEtPmdjZV9udW0sIGNtZHEtPmNsb2NrcykpOw0KPiArDQo+ICsJaWYgKGVuYWJs
ZSkNCj4gKwkJd3JpdGVsKEdDRV9ERFJfRU4gfCBHQ0VfQ1RSTF9CWV9TVywgY21kcS0+YmFzZSAr
DQo+IEdDRV9HQ1RMX1ZBTFVFKTsNCj4gKwllbHNlDQo+ICsJCXdyaXRlbChHQ0VfQ1RSTF9CWV9T
VywgY21kcS0+YmFzZSArIEdDRV9HQ1RMX1ZBTFVFKTsNCj4gKw0KPiArCWNsa19idWxrX2Rpc2Fi
bGUoY21kcS0+Z2NlX251bSwgY21kcS0+Y2xvY2tzKTsNCj4gK30NCj4gKw0KPiAgdTggY21kcV9n
ZXRfc2hpZnRfcGEoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gIHsNCj4gIAlzdHJ1Y3QgY21k
cSAqY21kcSA9IGNvbnRhaW5lcl9vZihjaGFuLT5tYm94LCBzdHJ1Y3QgY21kcSwNCj4gbWJveCk7
DQo+IEBAIC0zMjIsNiArMzM0LDkgQEAgc3RhdGljIGludCBjbWRxX3N1c3BlbmQoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiAgCWlmICh0YXNrX3J1bm5pbmcpDQo+ICAJCWRldl93YXJuKGRldiwgImV4
aXN0IHJ1bm5pbmcgdGFzayhzKSBpbiBzdXNwZW5kXG4iKTsNCj4gIA0KPiArCWlmIChjbWRxLT5z
d19kZHJfZW4pDQo+ICsJCWNtZHFfc3dfZGRyX2VuYWJsZShjbWRxLCBmYWxzZSk7DQo+ICsNCj4g
IAljbGtfYnVsa191bnByZXBhcmUoY21kcS0+Z2NlX251bSwgY21kcS0+Y2xvY2tzKTsNCj4gIA0K
PiAgCXJldHVybiAwOw0KPiBAQCAtMzMzLDYgKzM0OCwxMCBAQCBzdGF0aWMgaW50IGNtZHFfcmVz
dW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIA0KPiAgCVdBUk5fT04oY2xrX2J1bGtfcHJlcGFy
ZShjbWRxLT5nY2VfbnVtLCBjbWRxLT5jbG9ja3MpKTsNCj4gIAljbWRxLT5zdXNwZW5kZWQgPSBm
YWxzZTsNCj4gKw0KPiArCWlmIChjbWRxLT5zd19kZHJfZW4pDQo+ICsJCWNtZHFfc3dfZGRyX2Vu
YWJsZShjbWRxLCB0cnVlKTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IEBAIC0z
NDAsNiArMzU5LDkgQEAgc3RhdGljIGludCBjbWRxX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlDQo+ICpwZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBjbWRxICpjbWRxID0gcGxhdGZvcm1fZ2V0
X2RydmRhdGEocGRldik7DQo+ICANCj4gKwlpZiAoY21kcS0+c3dfZGRyX2VuKQ0KPiArCQljbWRx
X3N3X2Rkcl9lbmFibGUoY21kcSwgZmFsc2UpOw0KPiArDQo+ICAJY2xrX2J1bGtfdW5wcmVwYXJl
KGNtZHEtPmdjZV9udW0sIGNtZHEtPmNsb2Nrcyk7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo=
