Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8128B622200
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKICkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKICkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:40:42 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580061A80D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 18:40:39 -0800 (PST)
X-UUID: ef5e4fedead048cbaf4fdbfd0c87b241-20221109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FItReXbeHmWXnDRhBNn6OFW6okjRbI7OMSeZ1DM8V2A=;
        b=FVK9DreZ9lHBG/6od1Ok9MlqvCblqEQ5grrd8fdL1zV6lDW4HeyIuhjN28u7RHZ7DhooHFFYuNulrz7wrQQ9d7WeqxysL1kOGm2lYCHMneSVAWi55BjA/4K4hYxk19I9z2YFmGdjCQIIFpwEk/xf7M4HjNv6Lu9gpI/7nn9PEm8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:79d30ebc-e933-4449-9017-ee8530fb6492,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:9ab4daeb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ef5e4fedead048cbaf4fdbfd0c87b241-20221109
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1910659441; Wed, 09 Nov 2022 10:40:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 9 Nov 2022 10:40:34 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 9 Nov 2022 10:40:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPCxQobDGDYt5QZm9qIpOOUNSHH5XsdisY1ieTp2rfplWx4+Qy2gFr37A8Olw8R0ZA8uCvRhp9J51MwjmiDqzGj1DNF64FqN2xsLBO6t0q+lTi+424yfUxKrrz/gaYLGLiYq4zZR9qlB6dlEghp21WyHEbz8G8dt7HWzwu+E5pIjy87K0wBB5uiCQOL+7FvSl5jbAUP18iln9AkXAKof7hTkBZ2ljFEY6I2/0Ic0KL7i0WvVwIxsUD7k2eRnBqWs1tVwRcURnXDWZA7yQCKlbGiLcv0od2WkmsTq8WIvOo36Z35YhyHQhN6qUCcRuT4C87b0eW/kweZu4cjwPeflKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FItReXbeHmWXnDRhBNn6OFW6okjRbI7OMSeZ1DM8V2A=;
 b=J2SRPlBqsRMlCT7632Vk258uSogZqnukpu8mNW3ftlM6JQbBLZobUACEHeO2CZtrQ9YSyRRhajWwwTxDm46/Ip8Vy5CwYScz8v4RpLy5Nlbe0PtgMXPQU0GsKdnmlSlJm7jd7HsbXDle9KosCArq5Upcs0dc6bjTRVNsqEJ7ECEEw7Zu79EUHQ2sobwisYmSWbCrJ5XlYROokZ7bF4QyTfGyjOoVTAf7/s7Irut2zDA1m6tJQnScQwAtRppEZDH7pBa5LB/zbJCfiYY/0xpUgz+JwLiO0Mct0eF86Sswc5HxGgGivzFEsypM/NLNk72VgzMlVXdT0B+HsmjVeITl/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FItReXbeHmWXnDRhBNn6OFW6okjRbI7OMSeZ1DM8V2A=;
 b=IQbvs1LL1Am+Lf5IaOWj1AjXhMv5PJ1BOm5og7i3/PWpslsUgUlL7M3ASIcwYFfNOcKDMd3MWTYpI5/ujR15wNrgA+Ote7Tge1XDg5/57YPU86YnolUVhAeL4R3HrUQqmQVymhr+OtGss1uFajiMcDeiWEPML3lsas8G9y3B2VM=
Received: from SI2PR03MB5339.apcprd03.prod.outlook.com (2603:1096:4:105::9) by
 SEZPR03MB6891.apcprd03.prod.outlook.com (2603:1096:101:a2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Wed, 9 Nov 2022 02:40:32 +0000
Received: from SI2PR03MB5339.apcprd03.prod.outlook.com
 ([fe80::c97d:476e:330:2459]) by SI2PR03MB5339.apcprd03.prod.outlook.com
 ([fe80::c97d:476e:330:2459%5]) with mapi id 15.20.5791.019; Wed, 9 Nov 2022
 02:40:32 +0000
From:   =?utf-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v13,0/3] Add dpi output format control for MT8186
Thread-Topic: [PATCH v13,0/3] Add dpi output format control for MT8186
Thread-Index: AQHY500U1URKonZQ80qaY9Su5ki+rq41cMwAgACJ5gA=
Date:   Wed, 9 Nov 2022 02:40:32 +0000
Message-ID: <b69311d4d39eae54d1120760532a83bb62213277.camel@mediatek.com>
References: <1666577099-3859-1-git-send-email-xinlei.lee@mediatek.com>
         <c9228b64-c786-fa24-ff96-376eacfb1816@gmail.com>
In-Reply-To: <c9228b64-c786-fa24-ff96-376eacfb1816@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5339:EE_|SEZPR03MB6891:EE_
x-ms-office365-filtering-correlation-id: 6f7cd35b-8401-488e-9b0d-08dac1fbc5b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/D5p2N3e2ItUq8gc/brOFA7RbUoI1zP46omJzanLH2MYwRgQ15UOHSpeQgsIz7G7437LRcvq0DHI6gMJmewjTuxdoqkqSqdXPxBQDwbU204RvVuYZss5EAvzLD3BXE3dGPWjnO7mGrxdjg7Hw+EI/rziW3caHGyiaSHSq7zLBGsRBd/oMnIdtyUSqgnkB+SQokXQyjKycsr1/1XrJNb+DGld3KpMV7mInICp17yBboiIMSPl9wjyGW2YIYwWJ1RM/78AURGrI3r23zPXnA6x1U70FmS7IWQupJYoCvsmEqazcD2v4QcMTc+8IBe/5z/BVKsYJUwTiG0Qjl93IxvGg/YRjeSdhO2gMp7ZnkBc1LeAuM8xphmCyL9+atLlVnVAubDcb0lro/pN7RDX0sgz+5OcEtnJzEzoMry2YJbSZ9QmLzW4NSmzNC+orIVouXfdas9lGh2hjSOLHaNwrTGRlsrmUK/xnAzu6evL7obPQ3hes8q/J4g4dx49zUfdseVRMVpdK8WVcYilyJcyDozz49wCFhG6WHJmC0+czdRnmadOmmBhE/3oEZ75dBhFWLftfOlfuY87ow5KouPoO3t+7Ya9AIBZVZS2ywk0zq9XiHVc1VNMzcQZ0Qa4OwVLGdHUhaZJWQ2UAG2qZOO9NmyDz732u2pHd0iR1nVu1GG4K97ihwtxbE+J8dHxmJ2QGuT3k/TKSsq41pa6ZYv8vLs3bU2ocCkiaVemA0z5miC6XnFxu4Ijdzb9qJtwy4ky/ZNiACm7KOwjTyzEElqMytQI2+Pkf4Vl22VYhFg7ua0ZaohHdke9YVF8JCLuCM8aqukUhzdDEORRPoGA5OlDp0oUHEaBGWAHdTu3AygTLrqnGp+x46GmCG2WN+2EmFaPQga
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5339.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(6512007)(6506007)(83380400001)(2616005)(26005)(107886003)(7416002)(186003)(53546011)(2906002)(4326008)(76116006)(71200400001)(5660300002)(966005)(8936002)(41300700001)(6486002)(316002)(8676002)(110136005)(64756008)(66556008)(66446008)(66946007)(66476007)(478600001)(54906003)(122000001)(38070700005)(85182001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0QyTjI4Wk9qWHBCaFpDSnhPS1h2bXRxS05sK3ZITENvRjdZQlluSDZva3Zm?=
 =?utf-8?B?NzVOeWd0TVg2OFh1V0RSVysxdzFqUkJOeGprWTdLNEVvVlYzMTJwdWtYd0pV?=
 =?utf-8?B?VFF1VkthVlZBUzNwNVYrdlBVUUZvM3JERWJJWkJaSFdjN2Q2QTRheHh4SldY?=
 =?utf-8?B?TU9La3NWL0ZYWGdXK0Z6dXZyZjlQMmVMOWdMcUJkSnY2OFk4UTN0ZGliVnZM?=
 =?utf-8?B?N21ZTmZwZ2Q1eVBDMk5vMGZ2V25LSWpUY09KTDBVbDhidEJLTHpLamJQblhQ?=
 =?utf-8?B?MUlKS1RHMm1JNE95dHk3dkNRRHRpUENYNFdIL2ZGaC94U1o4cUE3ak1reFNO?=
 =?utf-8?B?R1c4Z0Q5QldZMFJlcTZ0ZWpBT0RENUVjQXpuSzNKa1g2V01rUlFPWU5MNXpN?=
 =?utf-8?B?QzVvSlNPdVRoY0VwMG13NkdIbjRQOVkzNXZTTjNpcnZ1REdmU0NuMGdQTk9p?=
 =?utf-8?B?OUJmQ0N4Tm5TZG5CUTdKa0YrQWZMa1ZuZXBIYTBPOEJoN1B2aW01YytYWDA5?=
 =?utf-8?B?K1R0NkFKa1AvRjREdnplSmh6eWRTa0g4MnJ5MjZ2S0RoUktMUmhWVTdhenlY?=
 =?utf-8?B?V2VIeXMzU2ZhVStqR1M2ZjdQQWZZVDBROFZqd1NUNUROSUtqbVExK0ZYZ0lx?=
 =?utf-8?B?NGtNVXB2eVFGUXhpTnF3S3VHdXJLOHg4NHQyMXNpSmtzMTRBUmFrTnpubmRq?=
 =?utf-8?B?MGNlNm95aEZoSm9pS01EeDZXQ3RLcGpTYk1PVjdFUm5jYTdHekM1K3hEcC9C?=
 =?utf-8?B?RmRwZHEzelBSOFNucnZnNnJaOWtzVEczeTM1RTRGdzlNSzE4YUw1by9mWjU4?=
 =?utf-8?B?bkZrMitleFRIczlIRzFFUklyZitpOW9oWE4ybUlqTUdRSnU5aUc1MC81OVBp?=
 =?utf-8?B?L3VxL2Z6NEkvbDVDY0NyelAwWnFmZkJvYWFHWmw0cUdKUjhHalRrNTVPb3Iy?=
 =?utf-8?B?b2RQNUl6YnkvU3JxRDFsYSt3clFvS1p2ajZ5bzE0U20rSUxNem5iZDNkT28v?=
 =?utf-8?B?TGQ2WFQ5VnNkaXR0SDBJM2t1T0RPM3hoblRYdUM3OVFhUkdFdzRTZUxYc0xJ?=
 =?utf-8?B?SkJJWVlyL1AyRkxlYUZpb0dxTGU3VlNOaW9zM1g3dzZIeFl1T1lpb0lkMmF0?=
 =?utf-8?B?U3V0eUl0aUkrVnppbzR0dGNtZDByRWpJYXJQekl0YXNrV1o4dG5sTHRCOVp4?=
 =?utf-8?B?c0dpeldGVGlocXpYaUZVTTVWZjR5VVFUa0VsU0FWc3RVd2hyVzVVQ1R0bmF0?=
 =?utf-8?B?Snc4Q3YwWTlxeUpqNzA0bnFqWGlKbmNybFhqQjZTendGZE9PcXg5Uk04NHNL?=
 =?utf-8?B?UEc2eDNYUWRTVXM2WnpUZUNiSE5KckJVcXY1N0pEbkc4TXZRYjJLcmJyQldZ?=
 =?utf-8?B?aXV5Tmt1SUtTUldFWHZKM09XOEppT1krM2tiMHh4SzFIVHVXMXVsSitOaFJk?=
 =?utf-8?B?T3RxNzk2elZDMzZaTTBqRTRNVVRmTXhYSFR0K24vS2JNdFNTZTdlcWFieWh2?=
 =?utf-8?B?bFhxd2NMbTVvcTVoVmxDczlaVDdlWG1ObTZHWmtWZDJ4OUh1Q3NqRVY3UFB1?=
 =?utf-8?B?MzFvZFpORjFPRjJyc1lVRUpwM2s3aGdKZHhwQkVZOWt2TnlOSW05YmZ2Y0Ri?=
 =?utf-8?B?SjBDRDIyOTJJOWxqNmgyaDhFR1dWbmMyMGxFaktZZktRMDlyR2JHTmRYUVph?=
 =?utf-8?B?S3ZRNk5jTzBjd3U1bnRHTVRFYU9XcTF0QlltYVlBRy9tMFRyRkNLTFFwWTdC?=
 =?utf-8?B?NVUwQzVVUnhaSThDck9kMDlwUUtjb041bmV6L0ppVC9TUi9PaUp3NGN0cDdi?=
 =?utf-8?B?cXRqNFBTZ0FVcTJJbU1RWmtoSnU0NkZ5d01uazRGTTV6bXkrR0VmQmtvM0dy?=
 =?utf-8?B?WnhjMFc1QVkwNWVXNURTeDVFUi9UQU84d2s4UENzSC8vekdlNThiRm82TXJ6?=
 =?utf-8?B?czV5cXNycGhiRlpNMG9sbHFEL3NTdXlqeVhQWWR3aHk2MnZUY1g5V2JrNHJh?=
 =?utf-8?B?dExuakFDUVNvWnpTcTg5SDNtZGpvcGkrREt3Tkl6SlFkZFl4OGtjYWtJUTBt?=
 =?utf-8?B?OXJHTW5xTWRUejBOT0YyaFVrVyt5ZGpockFqTkZWZy9DME1TdjBSYkt5dThj?=
 =?utf-8?B?cGxKejVDMW5zNXFvcWdNT01kejBjdUdZV0x2KzNQR1NKcytSK1ZzeXNDd284?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F35CE93F590EF48BFF459C269D516CB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5339.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7cd35b-8401-488e-9b0d-08dac1fbc5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 02:40:32.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Dg6fBtDKIr3CtH26pChmNF94Mx8GbW694zqejjNEkiKkogz3vO1+gEqMDV+xsYoYINQzz5Hg5yNvLjgyfALjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTA4IGF0IDE5OjI3ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiBIaSBYaW5sZWksDQo+IA0KPiBTb21laG93IGI0IGJyb2tlIHdpdGggeW91ciB0aHJlYWQg
YnV0IEkgd2FzIGFibGUgdG8gYXBwbHkgcGF0Y2ggMSBhbmQNCj4gMiBieSBoYW5kLg0KPiANCj4g
VGhhbmtzDQo+IE1hdHRoaWFzDQo+IA0KPiBPbiAyNC8xMC8yMDIyIDA0OjA0LCB4aW5sZWkubGVl
QG1lZGlhdGVrLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBYaW5sZWkgTGVlIDx4aW5sZWkubGVlQG1l
ZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBCYXNlIG9uIHRoZSBicmFuY2ggb2YgbGludXMvbWFzdGVy
IHY2LjEgcmMxLg0KPiA+IA0KPiA+IENoYW5nZSBzaW5jZSB2MTI6DQo+ID4gMS4gQWRkIE1UODE4
Nl8gcHJlZml4IHRvIHZhcmlhYmxlcyBhZGRlZCBpbiBtdDgxODYtbW1zeXMuaCBmaWxlLg0KPiA+
IA0KPiA+IENoYW5nZSBzaW5jZSB2MTE6DQo+ID4gMS4gUmViYXNlIG9uIHY2LjEtcmMxLiBDaGFu
Z2Ugbm90aGluZy4NCj4gPiANCj4gPiBDaGFuZ2Ugc2luY2UgdjEwOg0KPiA+IDEuIE1vZGlmeSBw
YXRjaCB0aXRsZSBhbmQgYWRkIHJldmlldyB0YWcuDQo+ID4gDQo+ID4gQ2hhbmdlIHNpbmNlIHY5
Og0KPiA+IDEuIE1vZGlmeSB0aGUgbG9jYXRpb24gb2YgdGhlIG1tc3lzX2RldiBtZW1iZXIgdmFy
aWFibGUuDQo+ID4gDQo+ID4gQ2hhbmdlIHNpbmNlIHY4Og0KPiA+IDEuIE1vZGlmaWVkIHRoZSB0
aXRsZSBhbmQgc29tZSBkZXNjcmlwdGlvbiBpbmZvcm1hdGlvbi4NCj4gPiANCj4gPiBDaGFuZ2Vz
IHNpbmNlIHY3Og0KPiA+IDEuIFRoaXMgc2VyaWVzIGlzIGJhc2VkIG9uIHRoZSBmb2xsb3dpbmcg
cGF0Y2g6DQo+ID4gICAgIFsxXSBzb2M6IG1lZGlhdGVrOiBBZGQgbW1zeXMgZnVuYyB0byBhZGFw
dCB0byBkcGkgb3V0cHV0IGZvcg0KPiA+IE1UODE4Ng0KPiA+ICAgICANCj4gPiBodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xp
bnV4LW1lZGlhdGVrL3BhdGNoLzE2NjMxNjE2NjItMTU5OC0yLWdpdC1zZW5kLWVtYWlsLXhpbmxl
aS5sZWVAbWVkaWF0ZWsuY29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3ITN0WFRMM1A2U2djUDhRX3Jj
eUNybzY0ZHhJWEU2VnVWYmNOZnRVMFpuWDZUTnRVMWFrWHdkOTZZZm5vSnNfZkVpZyQNCj4gPiAg
DQo+ID4gMi4gTW9kaWZ5IHRoZSBEUElfRk9STUFUX01BU0sgbWFjcm8gZGVmaW5pdGlvbiB0byBH
RU5NQVNLKDEsIDApOw0KPiA+IDMuIEFkZCBhbGwgc2V0dGluZ3MgdG8gbXRrX21tc3lzX2RkcF9k
cGlfZm10X2NvbmZpZzsNCj4gPiA0LiBNb2RpZnkgdGhlIGNvbW1pdCB0aXRsZSB0byBBZGQgbXQ4
MTg2IGRwaSBjb21wYXRpYmxlcyBhbmQNCj4gPiBwbGF0Zm9ybQ0KPiA+IGRhdGEuDQo+ID4gDQo+
ID4gQ2hhbmdlcyBzaW5jZSB2NjoNCj4gPiAxLiBEaWZmZXJlbnQgZnJvbSBvdGhlciBJQ3MsIHdo
ZW4gbXQ4MTg2IERQSSBjaGFuZ2VzIHRoZSBvdXRwdXQNCj4gPiBmb3JtYXQsDQo+ID4gdGhlIG1t
c3lzX2Jhc2UrNDAwIHJlZ2lzdGVyIG5lZWRzIHRvIGJlIHNldCB0byBiZSB2YWxpZCBhdCB0aGUg
c2FtZQ0KPiA+IHRpbWUuDQo+ID4gICAgIEluIHRoaXMgc2VyaWVzLCBhbGwgdGhlIHNpdHVhdGlv
bnMgdGhhdCBtbXN5cyBuZWVkIHRvIGJlIHNldCB1cA0KPiA+IGFyZQ0KPiA+IHBlcmZlY3RlZCAo
bm90IG5lY2Vzc2FyaWx5IHVzZWQgaW4gcHJhY3RpY2UpLg0KPiA+IDIuIFB1dCB0aGUgdmFsdWUg
dGhhdCBjb250cm9scyB0aGUgbW1zeXMgZnVuY3Rpb24gaW4gbXRrLW1tc3lzLmguDQo+ID4gMy4g
RW5jb3VudGVyZWQgdGhlIHNpbmsgaWMgc3dpdGNoZWQgYmV0d2VlbiBkdWFsIGVkZ2UgYW5kIHNp
bmdsZQ0KPiA+IGVkZ2UsDQo+ID4gcGVyZmVjdGVkIHNldHRpbmcgYW5kIGNsZWFyaW5nIG1tc3lz
IGJpdCBvcGVyYXRpb25zIGluIG10a19kcGkuYy4NCj4gPiANCj4gPiBDaGFuZ2VzIHNpbmNlIHY1
Og0KPiA+IDEuIFNlcGFyYXRlIHRoZSBwYXRjaCB0aGF0IGFkZHMgZWRnZV9jZmdfaW5fbW1zeXMg
ZnJvbSB0aGUgcGF0Y2gNCj4gPiB0aGF0DQo+ID4gYWRkcyBtdDgxODYgZHBpIHN1cHBvcnQuDQo+
ID4gMi4gTW92ZSB0aGUgbW1zeXMgcmVnaXN0ZXIgZGVmaW5pdGlvbiB0byBtbXN5cyBkcml2ZXIu
DQo+ID4gICANCj4gPiBDaGFuZ2VzIHNpbmNlIHY0Og0KPiA+IDEuIFRoaXMgc2VyaWVzIG9mIGNh
bmNlbGxhdGlvbnMgaXMgYmFzZWQgb24gdGhlIGZvbGxvd2luZyBwYXRjaGVzOg0KPiA+ICAgICBb
MV0gQWRkIE1lZGlhVGVrIFNvQyh2ZG9zeXMxKSBzdXBwb3J0IGZvciBtdDgxOTUNCj4gPiAgICAg
DQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9jb3Zlci8yMDIyMDcxMTA3NTI0NS4xMDQ5Mi0x
LW5hbmN5LmxpbkBtZWRpYXRlay5jb20vX187ISFDVFJOS0E5d01nMEFSYnchM3RYVEwzUDZTZ2NQ
OFFfcmN5Q3JvNjRkeElYRTZWdVZiY05mdFUwWm5YNlROdFUxYWtYd2Q5NllmbnF2MF9RWXBnJA0K
PiA+ICANCj4gPiAgICAgWzJdIEFkZCBNZWRpYVRlayBTb0MgRFJNICh2ZG9zeXMxKSBzdXBwb3J0
IGZvciBtdDgxOTUNCj4gPiAgICAgDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9jb3Zlci8y
MDIyMDgwNDA3MjgyNy4yMjM4My0xLW5hbmN5LmxpbkBtZWRpYXRlay5jb20vX187ISFDVFJOS0E5
d01nMEFSYnchM3RYVEwzUDZTZ2NQOFFfcmN5Q3JvNjRkeElYRTZWdVZiY05mdFUwWm5YNlROdFUx
YWtYd2Q5Nllmbm9aTVpfcGVBJA0KPiA+ICANCj4gPiAyLiBBZGRlZCBtdGtfbW1zeXNfdXBkYXRl
X2JpdHMgZnVuY3Rpb24gaW4gbXRrLW1tc3lzLmM7DQo+ID4gMy4gTU1TWVMgMHg0MDAgcmVnaXN0
ZXIgaXMgbW9kaWZpZWQgdG8NCj4gPiBNVDgxODZfTU1TWVNfRFBJX09VVFBVVF9GT1JNQVQ7DQo+
ID4gNC4gRml4IGZvcm1hdHRpbmcgaXNzdWVzLg0KPiA+IA0KPiA+IENoYW5nZXMgc2luY2UgdjM6
DQo+ID4gMS4gRml4IGZvcm1hdHRpbmcgaXNzdWVzOw0KPiA+IDIuIE1vZGlmeSB0aGUgZWRnZSBv
dXRwdXQgY29udHJvbCBuYW1lICYgZGVzY3JpcHRpb247DQo+ID4gMy4gRml4IHRoZSB0aHJlYWRp
bmcgcHJvYmxlbS4NCj4gPiANCj4gPiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiA+IDEuIE1vZGlmeSBr
ZXkgbm91bnMgaW4gdGhlIGRlc2NyaXB0aW9uOw0KPiA+IDIuIEFkZCB0aGUgbGFiZWwgb2Ygaml0
YW8gdG8gQ28tZGV2ZWxvcGVkLWJ5Ow0KPiA+IDMuIE1hY3JvIGRlZmluaXRpb24gYWRkcmVzcyBs
b3dlcmNhc2UgcHJvYmxlbSBhbmQgZnVuY3Rpb24gbmFtaW5nOw0KPiA+IDQuIEFkZCBtaXNzaW5n
IGEgZGVzY3JpcHRpb24gb2YgdGhpcyBwcm9wZXJ0eSBpbiB0aGUgbXRrX2RwaV9jb25mLg0KPiA+
IA0KPiA+IENoYW5nZSBzaW5jZSB2MToNCj4gPiAxLiBNb2RpZnkgbXQ4MTg2IGNvbXBhdGlhYmxl
IGxvY2F0aW9uLg0KPiA+IDIuIE1vZGlmeSBNVDgxODZfRFBJX09VVFBVVF9GT1JNQVQgbmFtZS4N
Cj4gPiANCj4gPiBXaGVuIE1UODE4NiBvdXRwdXRzIGRwaSBzaWduYWwsIGl0IGlzIG5lY2Vzc2Fy
eSB0byBhZGQgZHVhbCBlZGdlDQo+ID4gb3V0cHV0DQo+ID4gZm9ybWF0IGNvbnRyb2wgaW4gbW1z
eXMuDQo+ID4gDQo+ID4gWGlubGVpIExlZSAoMyk6DQo+ID4gICAgc29jOiBtZWRpYXRlazogQWRk
IGFsbCBzZXR0aW5ncyB0byBtdGtfbW1zeXNfZGRwX2RwaV9mbXRfY29uZmlnDQo+ID4gZnVuYw0K
PiA+ICAgIGRybTogbWVkaWF0ZWs6IFNldCBkcGkgZm9ybWF0IGluIG1tc3lzDQo+ID4gICAgZHJt
OiBtZWRpYXRlazogQWRkIG10ODE4NiBkcGkgY29tcGF0aWJsZXMgYW5kIHBsYXRmb3JtIGRhdGEN
Cj4gPiANCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgICAgIHwgMzIN
Cj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZHJ2LmMgfCAgMiArKw0KPiA+ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXQ4MTg2LW1tc3lzLmggICAgfCAgOCArKysrLS0tDQo+ID4gICBkcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstbW1zeXMuYyAgICAgICB8IDI3ICsrKysrKysrKysrKysrKysrLS0NCj4gPiAtLS0NCj4g
PiAgIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1tbXN5cy5oIHwgIDcgKysrKysrDQo+
ID4gICA1IGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+
ID4gDQoNCkhpIE1hdHRoaWFzOg0KDQpJcyB5b3VyIHByb2JsZW0gc29sdmVkPw0KDQpJIHRyaWVk
IHRvIHB1bGwgdGhlIHNlcmllcyBpbiBsaW5rWzFdIHRvIHRoZSBrZXJuZWwgNi4xLXJjMSB2ZXJz
aW9uLCANCnRoZSBwYXRjaGVzIGFyZSBhbGwgc3VjY2Vzc2Z1bGx5IGFwcGxpZWQsIGFuZCB0aGUg
cGF0Y2ggaW4gbGlua1sxXSANCmxvb2tzIGNvbXBsZXRlLg0KDQpJZiB5b3Ugc3RpbGwgdGhpbmsg
dGhlcmUgaXMgc29tZXRoaW5nIHdyb25nLCBwbGVhc2UgbGV0IG1lIGtub3cgYW5kIEkgDQpjYW4g
c2VuZCBhIG5ldyB2ZXJzaW9uIHRvIHRyeSB0byBmaXggaXQuDQoNClsxXTogDQpodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvY292ZXIvMTY2NjU3NzA5
OS0zODU5LTEtZ2l0LXNlbmQtZW1haWwteGlubGVpLmxlZUBtZWRpYXRlay5jb20vDQoNCkJlc3Qg
UmVnYXJkcyENCnhpbmxlaQ0K
