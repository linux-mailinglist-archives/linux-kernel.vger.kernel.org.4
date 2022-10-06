Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B716E5F5ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 04:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJFCtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 22:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJFCs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:48:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECAD87F86;
        Wed,  5 Oct 2022 19:48:57 -0700 (PDT)
X-UUID: 7dfce0357f15490d9a34d7077f1b58d0-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=a06HEoUgpekDG2yiGkW1c2LenSxZINm9oeMNKfs27A0=;
        b=KwE8BdWMyeXiMbnKd3LsT0qnEkEpxLqosg/byoDXPPg0CGb7Dyh1zSZ+KNSkSZWhYEg+LxlgcJQoEfMpoNM0ggbqNCPbADsK045epU30JBKHiHiQCfvb/V2UyxUiu3Z82p0RrpKhR+str2N6VnIHl+hO/gvhG9PSXK3o5l4KUAc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:8f1eb14f-3202-4552-8e1f-4f530aeaeb88,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:0c5ea8b8-daef-48a8-8c50-40026d6a74c2,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7dfce0357f15490d9a34d7077f1b58d0-20221006
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 357396961; Thu, 06 Oct 2022 10:48:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 6 Oct 2022 10:48:52 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 6 Oct 2022 10:48:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce6ivoS354xt+/peqRqDiq6THG3q/ul1rtNJo4ugBRCHKwPIsUhb176hScRM5bs50P1/TDM67wmyztX7np8VuvA++5kM5aA71KCP5QNzlnslBB5zYijgOVfdh6nuTI+NOv39nedXiJJouPQg69ekBjHP0q4/XG902SjxYnCx/+uYI3WA0DLCCScuIPNguejb43eDoCfbgQRIKfrxlO3KT1N3MgrDZbY0kb/I0Wpt24kfE68xi3rWck6BZSYbvaARabwlSfhKf4zkVbA3Drn+nCVHuZ48SmfmPByP5+Lw+evx9UdopZOdgZaFIn43npLf1TsGnRhQQwjEHl5ZfDu0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a06HEoUgpekDG2yiGkW1c2LenSxZINm9oeMNKfs27A0=;
 b=I/KzhHTYrEoP2Qaijrj2drMtdtF4aOzYs72oJdp7VtveJKdBaO4ZQdlsABiZGvRAveMWAdhnpKueQozZyE3bREanjiUs9OPa88zt7IjFMf83LXm530CdEJAwvfOD223+fX09uZqMzyfFMcTNZcsd/tMlPvpkRgaVUuyDYoG+C6aWK5xuyXO9i6u/sYnLR2GHUCZxSjx5k4/bzwSYJ4AByYHYVTHRc7oG0EPGXrWWYy0TIgZdIur5faT4G93HRcOtm5W5IhZGwXzdnyWcxpjQAkTOSRxdG5aBANVu3Na5u6YKbngTBUH9/ERJJkl8/l43Na9kgZO4qqml2sFzD2Jnlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a06HEoUgpekDG2yiGkW1c2LenSxZINm9oeMNKfs27A0=;
 b=BPy1raGL2vhtWQ/fKDK0Umc9l5bPK1UPsaA0tBOrwCmyPVsMWb5E8mcVQdBAjCGeP55Sac2flA8raj0FoZrF4joeDNh7teC4vAcuTNejYRgkE+/M7Q7tqQOJ6r00FCSHyUDWGxaAr9UFrtkx79sjRb4pE67dgn5GFK47IcuYX0Q=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by KL1PR03MB6199.apcprd03.prod.outlook.com (2603:1096:820:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.9; Thu, 6 Oct
 2022 02:48:50 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3035:799a:e0e2:26ff]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3035:799a:e0e2:26ff%3]) with mapi id 15.20.5676.014; Thu, 6 Oct 2022
 02:48:50 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 08/12] ASoC: mediatek: mt8188: add platform driver
Thread-Topic: [PATCH 08/12] ASoC: mediatek: mt8188: add platform driver
Thread-Index: AQHY1N0E4TAVmPuXsEGI3cvUVfYPj639/+WAgAKys4A=
Date:   Thu, 6 Oct 2022 02:48:50 +0000
Message-ID: <3c29ee7116597caf5469bab813ece3bb45723b84.camel@mediatek.com>
References: <20220930145701.18790-1-trevor.wu@mediatek.com>
         <20220930145701.18790-9-trevor.wu@mediatek.com>
         <50e12f7a-bf15-9f27-0606-5d23b310bf2d@collabora.com>
In-Reply-To: <50e12f7a-bf15-9f27-0606-5d23b310bf2d@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|KL1PR03MB6199:EE_
x-ms-office365-filtering-correlation-id: a81d94bd-1ff1-4b03-1e01-08daa7454c9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3yeM/zrjXhR3X12cV+WkKhIv0CTW8C9/mkLAX3VWfqAyLVXMxXy+3G4640tVe21CUyplkDIUrITjKc1JnlgWuQW3PGKXv2pQ4DYTcUC+0ku5BpDU+22ZDfGOOTiFUqEBDego8pe7lq9nmVkfGGQ47QhqrsD+dj8wpepEmzrWIp+wJCvMVqktLW/QcFHUTEqSEnrmC8P/XmBUnBio8i4gCXI4IXcvx3m+kaYsF/orWaQzdb0402asKwQNqjSYzjqEhCxD+K5CLiIyeuCLMTnYpUBuLboM+DIuUPLuIYJQJ7dORhb+m8CZou4H66/nPZ7YQvRrDm1+n1DbAHdIywTWe//zChJpdK4lDgm8hTJdCAMr4FwfMs7xtrhb7C1MOMxMj+kuxdBVI/rwHvHWPwROumej2I8Okgyoxp5tMFUKbJBSUSUQ1/dT16VRMgpYiRVQkdmiMkn6KSEat1Y9NOorthmJjCCmyoS/Uf//mNWzWgcY6gyBoxerZdXnDWueSh3HuvfoU2ls3jo2Q9g/r3UCy8S5LCHa+21ErJvLUcg7LStWvucB2hJMJbuECQM7/j0MKu3gj3XJ0dRfBRiXDXWYHstHaONaT2du7Yk2gzkPiYm9saekPLQf7NE1tllk5WjnvDhcEgtOyVmapzHMJAzK1vvI97COulHl1onF17D7wE28QG3pemvvO4WCAVbiakDcQa+lVITCQ8jD6iWx7tsmGAVWCPcFfu4ri0P5O6DgKAHGGlGRRIiel1NlwRZnFWDJXsHT0XJDTZD3pH1OpV6nBh4MUOF4U8OVr4IXfDFLluaz6x6ecbSarrUNpzVCGz2b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199015)(26005)(6506007)(6486002)(6512007)(86362001)(8936002)(36756003)(38070700005)(7416002)(41300700001)(5660300002)(38100700002)(85182001)(122000001)(2906002)(966005)(478600001)(110136005)(66476007)(4326008)(83380400001)(186003)(64756008)(71200400001)(8676002)(316002)(54906003)(66946007)(66556008)(2616005)(91956017)(76116006)(66446008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzZtVnpETjBvVW1LL2xOeEZxQzZrSE1hWjUzVU9VK3VpOW1jb2x0b1ZhQVIy?=
 =?utf-8?B?YUNxNHlFcm1PVytlTjEreWIySzBsbTk1R3hwSTlQS1J5aklNa05oSStqWFBQ?=
 =?utf-8?B?bVdFbTNlTDdJU2NCZVVaS3g1dEtORTRkY2phdmdka3RUaDF3OGdlYUhwVXRu?=
 =?utf-8?B?NUxIUnBRSTA0a3ZlNFNmbkJ4b3p6bXY5cjdWNGpwY0xwVTNUOGpJZk5GWFlB?=
 =?utf-8?B?V1RJK0YwN3hhTitSbm5QUkdPL29iU1ErdHpyQlRhQ05NdS9ZK0NVTmh1Sjgz?=
 =?utf-8?B?T3NtZHNRSldHWEJRWjhOeVhCeFhDRjRLWEJscEtVSE9ZaDhBUE1YRWFlQW5O?=
 =?utf-8?B?Z2t2UnpvRnRySHVNYWorblVZaDJLVXJESlhZeXlxbllqbUVqM1BDWExWZ0J4?=
 =?utf-8?B?eFpYdmFNNlk1ZHhMOHQxc2x5aU1FRWVBN2hmK2VSOXBNSllMbmdPd3ZoeWI0?=
 =?utf-8?B?ek1DN1hPZGlrcC93SmVlRmIzV3NVMXRFZktKSit3cEQ3dWNrMCtkWjJtZit2?=
 =?utf-8?B?L2puUENCWXJmcVoxQzFSRGZxYnVhT1FCRENnblJLSUJPS2lGTnJhWGh1MzJa?=
 =?utf-8?B?Y0x3YTBQaUxvNzlPYUYrWGlFOWpScnBHdzdSaHROeTRWWVN4OGNTbFcvUEFo?=
 =?utf-8?B?VUVEMjZvYzErVmM1Tk9QeTE4NnJJYnA4UlhXS3Q5MXdYaXo4QW9pYnRtSHVp?=
 =?utf-8?B?TTZxTGpIRXY0dWtSVjNkN29aTlg2R25ETFM0Zlp5SjVqQ0wxbnNLbkRoS3lI?=
 =?utf-8?B?ZVZSTGNPeUxsanM0U2lPeHludlUxangyYlFqYzR5WWsxbWVMeWdkRUwvR0Vs?=
 =?utf-8?B?M1VjcStCK1NxRzExNklJenNTQk9IeVVqZTNzL3grOUdHYS9WWVA1eTNzQlJP?=
 =?utf-8?B?NHorYi9WYnI4bGVzS0FTMk8zTFN5eW1QMDRQUktYL0RpY1lkOW9hbDhINkJB?=
 =?utf-8?B?QlFFSFFBaUVNTnA2aUh5M0o4b2hhUUZWaUdqdDRQajA0OU5sNC92N2VkNUpN?=
 =?utf-8?B?MkpsVnlkZTJudUtPTC9KcFY4M1JPZWtPVW41dG1QNnRUdE55RW94bW5iWUZ1?=
 =?utf-8?B?RHFwL2V5a0h4NnJqQmpmUjNoYTBQN2hKd0JVQ2VkTldoa0VhYlc1RjlUeUZG?=
 =?utf-8?B?Y1VRZ1dTSktLMXVpUEhqeHluME91YkJkYnBZK0ZIOE9iVUlCcFRuODdjclB3?=
 =?utf-8?B?QXJuamFGRk9VR0Q5Nyt0d05lMHBoZTc3TFR6NXAxR0s3TFViVVdTYkhWY0tI?=
 =?utf-8?B?a3Q1WWc5ZDhrZDUvaVVJYWVhU09md2M0L1lkTWtiM1FxTHZtcDFPRmxTa3Nr?=
 =?utf-8?B?VnBaY3NkQVoydVQxMHI3cFFoSTlzZ1BXbmppdTdjeE9IZzhlaXRNWGZEbUNI?=
 =?utf-8?B?bDlRVkZhcWh1ZTVMUDdENWE0TldtWTBvMHArK0R2WVI3NURjWWZGWlI3MHFy?=
 =?utf-8?B?SjF6T3dVRmErdUFUL2FMRHNJRXZsTTFRb21XeDNla3N5TkZydERmMm9vdHBz?=
 =?utf-8?B?RkcxVlJESVIrbXg4bUxFck1ZQ2lET003ZDdTM3RiS2tKT0hOS3BKREpycWY3?=
 =?utf-8?B?OTFhUzdZcVFpeWVaRzlZUFRUUUlzdHBBVGkwZWhSVW8yZDBFNy9hRWE2N2lV?=
 =?utf-8?B?WWFPWU1BTzJ4MG5adFdQT3VXR2E4Qng5cW9mWTBzbjNXOEN4WVRKSWFnRjhV?=
 =?utf-8?B?Ty9mdVdQQ2RJd2hxdlRxL2NqQXlFUXA5bHhVYjVRZDJYYktqbU5NUjR5RzF2?=
 =?utf-8?B?bzhPdHFDdlUyUHpGM3laOTRwNjNZYUJFODUvZ3RUa0l2eCsweHlqUTBRR3FS?=
 =?utf-8?B?U0lSQWc3Qm9UVGZYT2lMTVdtaUh5Y0w2a2VWTmVRU0h5Q0ZSMWxRWEJMMFl4?=
 =?utf-8?B?blZYaGhyaVdtK0pWdFQ4TVQreDZvLzBSendaMVYzOFJhYWlJR3d4WncxcSs5?=
 =?utf-8?B?OENBNHJQV1N4b1BmZmhpVXpvU1k2ZWQrdzdsdGJ0TWwzZThLWHQvaUtoSkRV?=
 =?utf-8?B?aFNlbGp4S2NBMGdobHRLaUNDVjVyOUMxU2dPUTNPWnhNSzEzcVVqUm42UTdu?=
 =?utf-8?B?RFoyYmpJS3M2UWdzNlUwY2ZMOEFYR2ZSQmR4N3U2bW9TcERrNXVIYW5WS1ky?=
 =?utf-8?B?Y2lMYjZCVmZWNG9KbVZGL3Y0RElGQ2ZQdGJwWWZOM1BnTEtQWm5HUWpOZ0Rw?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EB4AEC4816FEC49BEC3037656888D1A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81d94bd-1ff1-4b03-1e01-08daa7454c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 02:48:50.5890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XaNNrTXfGl4rL16BrAlOIxvD2FfPFrd1l9D58rB/64G/H6Bj/O8CiMYNZfHJWbiNVNv+qjcYxKr5rqBGogIBMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6199
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

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDExOjM2ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMzAvMDkvMjIgMTY6NTYsIFRyZXZvciBXdSBoYSBzY3JpdHRvOg0K
PiA+IEFkZCBtdDgxODggcGxhdGZvcm0gZHJpdmVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFRyZXZvciBXdSA8dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiBUaGlzIHBh
dGNoIGRlcGVuZHMgb24gdGhlIGZvbGxvd2luZyBzZXJpZXMgdGhhdCBoYXMgbm90IGJlZW4NCj4g
PiBhY2NlcHRlZC4NCj4gPiANCj4gPiBbMV0gQWRkIHBvd2VyIGRvbWFpbiBzdXBwb3J0IGZvciBN
VDgxODgNCj4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTY4MTM1OV9f
OyEhQ1RSTktBOXdNZzBBUmJ3ITNVMHN4S01nQThEN3hoaGFKM25TRU9qNERXTHJXajZfUXNZR3dE
YkN2dEJ2WnBvS3VEcTV5WExEZk1XMWFjb1BvZyQNCj4gPiAgDQo+ID4gKGxpbnV4L3NvYy9tZWRp
YXRlay9pbmZyYWNmZy5oIGlzIGluY2x1ZGVkKQ0KPiA+IC0tLQ0KPiA+ICAgc291bmQvc29jL21l
ZGlhdGVrL0tjb25maWcgICAgICAgICAgICAgICAgIHwgICAxMyArDQo+ID4gICBzb3VuZC9zb2Mv
bWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgfCAgICAxICsNCj4gPiAgIHNvdW5kL3Nv
Yy9tZWRpYXRlay9tdDgxODgvTWFrZWZpbGUgICAgICAgICB8ICAgMTIgKw0KPiA+ICAgc291bmQv
c29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtYWZlLXBjbS5jIHwgMjk0NQ0KPiA+ICsrKysrKysr
KysrKysrKysrKysrDQo+ID4gDQouLnNuaXANCg0KPiA+ICsjaW5jbHVkZSA8bGludXgvYXJtLXNt
Y2NjLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvZG1hLW1hcHBpbmcuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvbWZkL3N5c2Nvbi5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4
L29mX3BsYXRmb3JtLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc29jL21lZGlh
dGVrL2luZnJhY2ZnLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrX3Np
cF9zdmMuaD4NCj4gPiArI2luY2x1ZGUgPHNvdW5kL3BjbV9wYXJhbXMuaD4NCj4gPiArI2luY2x1
ZGUgIm10ODE4OC1hZmUtY29tbW9uLmgiDQo+ID4gKyNpbmNsdWRlICJtdDgxODgtYWZlLWNsay5o
Ig0KPiA+ICsjaW5jbHVkZSAibXQ4MTg4LXJlZy5oIg0KPiA+ICsjaW5jbHVkZSAiLi4vY29tbW9u
L210ay1hZmUtcGxhdGZvcm0tZHJpdmVyLmgiDQo+ID4gKyNpbmNsdWRlICIuLi9jb21tb24vbXRr
LWFmZS1mZS1kYWkuaCINCj4gPiArDQo+ID4gKyNkZWZpbmUgTVRLX1NJUF9BVURJT19DT05UUk9M
IE1US19TSVBfU01DX0NNRCgweDUxNykNCj4gDQo+IFRoaXMgZGVmaW5pdGlvbiBnb2VzIHRvIGlu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210a19zaXBfc3ZjLmgNCj4gDQpIaSBBbmdlbG8sDQoN
CklmIEkgbW92ZSB0aGUgZGVmaW5pdGlvbiB0byAiaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrX3NpcF9zdmMuaCIsDQpJIHNob3VsZCBzdWJtaXQgaXQgdG8gYW5vdGhlciB0cmVlLg0KSW4g
dGhlIGNhc2UsIGRvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9uIHRvIGhhbmRsZSB0aGUgZGVwZW5k
ZW50DQpwcm9ibGVtPw0KDQo+ID4gKw0KPiA+ICsjZGVmaW5lIE1UODE4OF9NRU1JRl9CVUZGRVJf
QllURVNfQUxJR04gICgweDQwKQ0KPiA+ICsjZGVmaW5lIE1UODE4OF9NRU1JRl9ETDdfTUFYX1BF
UklPRF9TSVpFICgweDNmZmYpDQo+ID4gKw0KPiA+ICsjZGVmaW5lIE1FTUlGX0FYSV9NSU5MRU4g
OSAvL3JlZ2lzdGVyIGRlZmF1bHQgdmFsdWUNCj4gDQo+IC4uLmFuZCBwbGVhc2UgZml4IGNvbW1l
bnRzIHN0eWxlLg0KDQpPSy4NCj4gDQo+ID4gKw0KPiA+ICtzdHJ1Y3QgbXRrX2RhaV9tZW1pZl9w
cml2IHsNCj4gPiArCXVuc2lnbmVkIGludCBhc3lzX3RpbWluZ19zZWw7DQo+ID4gKwl1bnNpZ25l
ZCBpbnQgZnNfdGltaW5nOw0KPiA+ICt9Ow0KPiA+ICsNCj4gDQo+IC4uc25pcC4uDQo+IA0KPiA+
ICsNCj4gPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJNZWRpYXRlayBBTFNBIFNvQyBBRkUgcGxhdGZv
cm0gZHJpdmVyIGZvcg0KPiA+IDgxODgiKTsNCj4gDQo+IE1lZGlhVGVrIFNvQyBBRkUgcGxhdGZv
cm0gZHJpdmVyIGZvciBBTFNBIE1UODE4OA0KPiANCk9LLiBJIHdpbGwgdXBkYXRlIHRoZSBkZXNj
cmlwdGlvbiBpbiBWMi4NCg0KVGhhbmtzLA0KVHJldm9yDQoNCj4gPiArTU9EVUxFX0FVVEhPUigi
Q2h1bi1DaGlhLkNoaXUgPGNodW4tY2hpYS5jaGl1QG1lZGlhdGVrLmNvbT4iKTsNCj4gPiArTU9E
VUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiANCj4gDQo+IA0K
