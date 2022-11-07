Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373EB61EADC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKGGWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiKGGWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:22:02 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB4EE2A;
        Sun,  6 Nov 2022 22:21:56 -0800 (PST)
X-UUID: c118027b361541a38a415c7e19dd930d-20221107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Z5Fe1BLmv843rOUQ7R6vrvY+P/4BKNSdZZ03STd3nL0=;
        b=tMYTHRVsMgpXRx/9+xfXEv+uNLdx1Pb8azRak0qKJLfeKGfWyMvpG9z4DyWWigU2KQTnuy1mFtFnpEKT+620zJBNxFeTXSM8eNtKDYlW0TOWZD3VmoMz91qm0/Nqq8dpMxx6SKVurTijZZehArtcV60TRx89uB/I9xz2nXE5Mz8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:106aa7c2-7c0a-46f0-bd5e-b316edaf0eab,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:e767c990-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c118027b361541a38a415c7e19dd930d-20221107
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1363655708; Mon, 07 Nov 2022 14:21:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 7 Nov 2022 14:21:45 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 7 Nov 2022 14:21:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8Y0ImPwNm1kXYIRtPtb4/cLkOxW8LZZOyr6GGAITPaQAY2qxNa8GuqiqcHsLxiRNC14cj0n4PkutUhP808K3rPieDG8PQk5rigGQcxp743LASxPLcTE0irIxWnwpxnGRFiHWhVmufxjkWP37Yqlz8LskHOw3mAosah8nLYZjSx9JVxfmUEKuDpVqcxUUGJKKOPiB9Q1vMLkCuLlRsMyE0uFyXbAKvds7lTrh28mMDMc9+Fdtv/QP/qA0UpWSxcSh1TBoyyZI5aiiDbCto5FqaoBQRfimPC6nxsPvtsJ3cqcDExoiYjNj0rgPe3IHgwQSvNNWumK/s6rkb/tRO5z0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5Fe1BLmv843rOUQ7R6vrvY+P/4BKNSdZZ03STd3nL0=;
 b=BShTpWceaa2ywmQ/HYhc1fkEvqrV6b0BVSNgcoUyaAX4JUt2uvYd7ebhtV2rPNjbwVykfPyZY4bY9QGE1Xr583UdW4zbBwl3XOf6dKAa5ZFhyE3HngCQp5sQQ/kpJLZ8C2Bcml1R25vDnBunjng2RgCA2nFCv2wX+sNyku94n0bEd5aPJMfkAUJMWzOu3c6pmQmCJVVfwZjj4I3Eu5GIbm1S2/BriesHN8T8hRcRn38vltQNcbjq9dbWj4hTEKa+oIdXvw2RZ9Etwj6gCeX3EVt1iOkFujnfYSk3CUDoJBP7uBmSGSJn+wgX+ustmCMUG/SCTnJV8FG/7IxCx1ag+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5Fe1BLmv843rOUQ7R6vrvY+P/4BKNSdZZ03STd3nL0=;
 b=N/Qp1ugCmjHJr6sxHD+PT32g9c6gK+e3WAOb+MLOvirYPfbcfJTh9RtnsCLU05aAYsk7/5YxtGsfAQB0hBGdGO83cLNYtOkCpbT2lcKLxf/EpC306o1kqFXx3vXKpKgh5w7s6V3+IsPcLqLoMlVI6gAOZavIvbCEH4dBWGIOd4Y=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by SEYPR03MB6723.apcprd03.prod.outlook.com (2603:1096:101:69::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 06:21:43 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::80f0:f72d:8b24:b2e5]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::80f0:f72d:8b24:b2e5%8]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 06:21:43 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1 1/2] media: platform: mtk-mdp3: extend mdp_color format
 for compressed mode
Thread-Topic: [PATCH v1 1/2] media: platform: mtk-mdp3: extend mdp_color
 format for compressed mode
Thread-Index: AQHY2i5o3+CEmPgprkOWVvroS1kVzq4u0/GAgARaGQA=
Date:   Mon, 7 Nov 2022 06:21:42 +0000
Message-ID: <de75d3359a6e3707a82ce094774b2c9a1cc0c9ff.camel@mediatek.com>
References: <20221007092230.11893-1-moudy.ho@mediatek.com>
         <20221007092230.11893-2-moudy.ho@mediatek.com>
         <0c815bd9-2d51-8153-3cee-0f195b76debd@xs4all.nl>
In-Reply-To: <0c815bd9-2d51-8153-3cee-0f195b76debd@xs4all.nl>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|SEYPR03MB6723:EE_
x-ms-office365-filtering-correlation-id: 2bd6ab19-ea36-4620-689d-08dac08856c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Mb/7FW8GWcYIazOBE84SNYXnLa2Kt2pioZzJOwvjSKgZIgyEwmX3uFWhlpqpECGHqS78lYKuCXfPIpykE05Bv3ysuDzmajlzbEHDrYXK2/j9MNj/zh8CbYrYTqoOchhvNYMjFsCmkMfZHwpLnj2Oc/M3+o69FYeWpeb7HgnS41FTmsAC6tHswWCXBjlPA5fVg6GMj0FLTJ9Ueo1xjlSKHKvp4Crpfr0/hUmol3f4XqD+lf+8yRh6KLJIe/6ynjTRYfCgr/dLoX3bGA84TNJrzJvRw2vYnh+rOUJNq4bnkE/P78LNgsDaL+QEhXWiuldteKhjg2U8dZQ5L1kIfdwnVEpso1PBM4ktHzNR7Eh5aBlwcYhLKq1FM4vZSR5IZwdyUDjx0wr2IL8qEvnodVZBwRoKRnaNqh2dyAWbRjh1v4O9FO6obyaa6pQzvpz2z1QogrUt1t2QyzUKCxJwFBw/H8ZMwovxyu8rkKxf5VCmEagRvT7LCaASwHhd+F/KGmmwVEXt0/K2CR7YsNb2fifwiaYZAN+xEFxYC5UJexz7NNGQZpvLMV3dt6wokNCZyFRHpKc+caBBbLIpfmVswKjOe5uVBJeBr6P6AwsIy79AeDg+IRXJmgVnVjGE/YnQBbVPCx6MyjJSKaRvK8zA5S42f9biH9PckgW4RSryX2Y2XfILJLnEDULHG4cTJAaxiuw8+18Hv/LWwMbOXykBXPDjmu9fHQPk6aSj+A/v3m1XEEORZ7ruvM+NnMA5CM5fy9SHeXFTAyclkw7yVtp5DS3vP7b5yxFnp096weWAYkIQNjBjXV8bREBVdCYOMePgGBERUITl8rqVVi4GAcUDX6mnNhHll7qGl99OjuW+i6A86A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199015)(71200400001)(38070700005)(966005)(107886003)(54906003)(110136005)(6486002)(316002)(478600001)(2906002)(122000001)(66556008)(66946007)(38100700002)(53546011)(6506007)(66446008)(64756008)(66476007)(76116006)(26005)(8676002)(4326008)(41300700001)(8936002)(86362001)(5660300002)(2616005)(186003)(6512007)(36756003)(83380400001)(85182001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0MxNVpYdUF3NmVtWnRLZURpTkhCblhLVDJHSXVTOTR5U2MvQ2NVSE5ydnVu?=
 =?utf-8?B?bWEwTk9oVnNrd1NCRS9OQ2liWDBqUDIvM0ZJd1V0cjY4Y2tkT2czVkRVbWNy?=
 =?utf-8?B?akFWZmZUc09iM2JvdnVYZ0lQMzRBeExvajF4Um1zeTNNY0V6UWVIV1NOOC9O?=
 =?utf-8?B?M2M1YzRCL1BWZXpTTTE5WDhiRFFabmlkbnNSS0VtZTB0ZkMxeXJiL2txc1A1?=
 =?utf-8?B?VUZXODJheC9IT3BYbllnSG4xdnVzK1NqUnIwRnJZL2RwNFBhdWJQVXA5T20v?=
 =?utf-8?B?cFVCOWxZRnhHMkNQendBTDkxNmQ0Mk1PN09HS0NybVlFTUFDT1cyZE1YQ1Fl?=
 =?utf-8?B?Q0hDM09HcTBmanRKNmp1NlZqN2lNRERsLzlvV2orSkFBK2RCNXFLNHlKTmJD?=
 =?utf-8?B?TUZuZzJZaWNxT01VSW8vQ1cvM0xsb1AzYUpXZmhnQ0dyVVBjMlJCL1hpOExs?=
 =?utf-8?B?ck96TVZtMmZDQmtFMnlweEFreWxpYlliUXNQd3Y0Q3hESzNZRGU5QTZhbXZI?=
 =?utf-8?B?UnhQOGxESUFPQVl6SWtRU1dXMENmMlBnSS9tQjdZTmhJVFFaLzVXVWUvVVY1?=
 =?utf-8?B?YkJmK1AweVJSUjJzdnB3VG1CQjlMQUNENStUUHJVRlU0QXF2d1NnQm1Td1ZV?=
 =?utf-8?B?ekFFN1A5dTJTODRyUTVBT0sxUlByKzBoaEFIck5yWVAzYmszL2NsMmFteFhv?=
 =?utf-8?B?eXJEckZaNlowQkN1RGtPTFgrcVMyb3NPcC8wbkx3TXFLcXM2Z0FXeFo0a0pr?=
 =?utf-8?B?Tm1ualNZYm9SRjB2eHl6RERqN0lTckFERGo5ZVpuWUNiNmlSOVozQ1pkU1pU?=
 =?utf-8?B?MjhqODFpSkg2UXRLUEtXakpHLzJWWGhHK0N0UUJsUVN6MmxhL2hrRVRyb0hT?=
 =?utf-8?B?M0daUGFQSU9keTdGYlNGaTBNNUlnc0Z1dk41c3YvcDZKMHNYSXhlbVhMVWJx?=
 =?utf-8?B?NE93NFRNTWdyODFYejg1ZFR3V1VIdnFQbm8rVk5wbDlwV0tpRU9TY25wcVh2?=
 =?utf-8?B?TFpkVlEzQ2NtWmwvZXcwSDBTNnNWcFkrVUVDMCthcXJ2N1lnSDAzbXZKcVg0?=
 =?utf-8?B?WGFnNklBS2VGSGZLVkFTVWVsVjg2UURKNTdYTGdpaEdaeURFaUsrL05lTWsy?=
 =?utf-8?B?RmUvR1EzeWVZWmcyVmFzMFVRUVAwNEFsZ3RCQ2pqMTl1NkQwNU9ydjRINE9i?=
 =?utf-8?B?NFBNRDdrenBMclA4K0lQcldlYWJpc3FoNXpDT3pMVktTTi91cGx6NENCODdX?=
 =?utf-8?B?YS94c0NGVlZQb293S2xzam8wYjFEUDlvMHBXS1M5L2ZLc2t1SER0ZlMvY2tQ?=
 =?utf-8?B?QUpNM3krZ3U2NFNZRmplcGpmNUZiTFlPU1VGWnM4bkhYNlZ1QUdGVk1MSDkr?=
 =?utf-8?B?QlFMOWdPUnpIVEViNDZUWEtpMTRBVHRLSnlyRldpWU90aC9JNVR1ZW5PdHV4?=
 =?utf-8?B?eGk5VU4vT2t0YzVrM1lWcm9TN2pNc3FYSGVEUmhEU0c2VnNpRVE3eFhOOGFB?=
 =?utf-8?B?Tkt4SzVUTEZRQ0VWWkNFcHBoc25xSm1FQ3JXV1dXNGcrM3dRV3k4Y2oyZ2Ex?=
 =?utf-8?B?aGsvelJGcnlUMVNLNXl5YXBGdTJtS3pObVZMT1NXQUJEMjRiYUdndzdRMUE2?=
 =?utf-8?B?bHdIVEtGSWFlaW1Rb1pFYnJiN0lZQjJlZmt6c1JhNFd3SmNxZ252WklYZDd4?=
 =?utf-8?B?M0JrOXFZTlRheEJZb0hwbllIZzlvRDFoWU1CakhyTHh1MmxmSWdINEUzdkpk?=
 =?utf-8?B?U0tGK0ZFNWNLUCtIYTFDeTFEWEhPeW12VHppaHd3cXppdS9kQ1FxMTU3ZTJs?=
 =?utf-8?B?aDNLZ3JGV0ZrM1JrWEpyNkpyVk1KaGRYL3JVdkJTdkFTdGtBQjFibWZmTkk0?=
 =?utf-8?B?akZQNHlWRXJGYUI3QWpXUzk4SjMvUFE4UWVqTDlVZWJxbURhdXBCeThWQjQ2?=
 =?utf-8?B?U0JTbDF5ajRma0JONGxDamxPcGJqeGdQeHk3SUJGekJhdmF6RTIxdzVGZ3lS?=
 =?utf-8?B?ODBIdjdlVmlDTytNS2ZSRVdWbjg4WTQ1aDkzWkJJV2FBY0Rqa1lBODhjY0F0?=
 =?utf-8?B?MkZ5QmMrLzYrc1k1dXJ6ajdFaGN1TXB3UjZ1ZFl4bjdEK2UzcnhEZnZKS1Zw?=
 =?utf-8?B?YkpSV3dPa2pyQnBQQnlyQUZGMVBFeTZZd3RNRFM0S09kbThyanI1TVNXREVC?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A88A0310B50B3C4D8A34DBAFB5EDCD2B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd6ab19-ea36-4620-689d-08dac08856c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 06:21:42.9897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rBYKhk6+2zDPRKeRGf1sa3EU+ctktg5ls/ZzPYZTgJHKoLAIxa0XZRaRxj4Rsj472P76cqlG5U6bc1LbohZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6723
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTA0IGF0IDEyOjU0ICswMTAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+
IE9uIDA3LzEwLzIwMjIgMTE6MjIsIE1vdWR5IEhvIHdyb3RlOg0KPiA+IER1ZSB0byBmdXR1cmUg
c3VwcG9ydCBmb3IgaGFyZHdhcmUgY29tcHJlc3Npb24gZm9ybWF0cywgdGhlIE1EUDMNCj4gPiBp
bnRlcm5hbCBjb2xvciBmb3JtYXQgZXhwcmVzc2lvbiBuZWVkcyB0byBiZSBleHRlbmRlZC4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNb3VkeSBIbyA8bW91ZHkuaG9AbWVkaWF0ZWsuY29tPg0K
PiA+IC0tLQ0KPiA+ICAuLi4vcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1yZWdzLmgg
ICAgfCAxOTMgKysrKysrKysrLS0tLS0NCj4gPiAtLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5
NyBpbnNlcnRpb25zKCspLCA5NiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLXJlZ3MuaA0KPiA+
IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLXJlZ3MuaA0K
PiA+IGluZGV4IDFhMjZjMWJjZmQ4ZC4uNDM5ZjcyZGMxZmY1IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1yZWdzLmgNCj4gPiAr
KysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLW1kcDMtcmVncy5o
DQo+ID4gQEAgLTE4LDExICsxOCwxMiBAQA0KPiA+ICAgKiBWLXN1YnNhbXBsZTogMCwgMQ0KPiA+
ICAgKiBDb2xvciBncm91cDogMC1SR0IsIDEtWVVWLCAyLXJhdw0KPiA+ICAgKi8NCg0KKHNuaXAp
DQoNCj4gPiAgDQo+ID4gIAkvKiBQYWNrZWQgMTAtYml0IGZvcm1hdHMgKi8NCj4gPiAtCU1EUF9D
T0xPUl9SR0JBMTAxMDEwMgk9IE1EUF9DT0xPUigxLCAwLCAwLCAxLCAwLCAwLA0KPiA+IDMyLCAg
MCwgMSwgMiksDQo+ID4gLQlNRFBfQ09MT1JfQkdSQTEwMTAxMDIJPSBNRFBfQ09MT1IoMSwgMCwg
MCwgMSwgMCwgMCwNCj4gPiAzMiwgIDAsIDAsIDIpLA0KPiA+ICsJTURQX0NPTE9SX1JHQkExMDEw
MTAyCT0gTURQX0NPTE9SKDAsIDEsIDAsIDAsIDEsIDAsIDAsDQo+ID4gMzIsICAwLCAxLCAyKSwN
Cj4gPiArCU1EUF9DT0xPUl9CR1JBMTAxMDEwMgk9IE1EUF9DT0xPUigwLCAxLCAwLCAwLCAxLCAw
LCAwLA0KPiA+IDMyLCAgMCwgMCwgMiksDQo+ID4gIAkvKiBQYWNrZWQgMTAtYml0IFVZVlkgKi8N
Cj4gPiAgCU1EUF9DT0xPUl9VWVZZXzEwUAk9IE1EUF9DT0xPUigxLCAwLCAwLCAxLCAxLCAwLCAy
MCwgIDEsIDAsDQo+ID4gNCksDQo+IA0KPiBZb3UgbWlzc2VkIHRoaXMgb25lLCBpdCBuZWVkcyBh
biBhZGRpdGlvbmFsIGFyZ3VtZW50LiBJIGd1ZXNzIHlvdQ0KPiBkaWRuJ3QgY29tcGlsZSB0aGlz
Pw0KPiANCj4gUmVnYXJkcywNCj4gDQo+IAlIYW5zDQo+IA0KDQpIaSBIYW5zLA0KDQpUaGFua3Mg
Zm9yIHRoZSByZW1pbmRlciwgdGhpcyBlcnJvciBoYXMgYmVlbiBmaXhlZCBhdCB2MiBhbmQgdGhl
IGxhdGVzdA0KdjMuDQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51
eC1tZWRpYXRlay9wYXRjaC8yMDIyMTEwMzA2NDg0Mi4xMjA0Mi04LW1vdWR5LmhvQG1lZGlhdGVr
LmNvbS8NCg0KU2luY2VyZWx5LA0KTW91ZHkgSG8NCg0KPiA+ICAJLyogUGFja2VkIDEwLWJpdCBO
VjIxICovDQo+ID4gLQlNRFBfQ09MT1JfTlYyMV8xMFAJPSBNRFBfQ09MT1IoMSwgMCwgMCwgMiwg
MSwgMSwgMTAsICAxLCAxLA0KPiA+IDEyKSwNCj4gPiArCU1EUF9DT0xPUl9OVjIxXzEwUAk9IE1E
UF9DT0xPUigwLCAxLCAwLCAwLCAyLCAxLCAxLCAxMCwgIDEsIDEsDQo+ID4gMTIpLA0KPiA+ICAJ
LyogMTAtYml0IGJsb2NrIG1vZGUgKi8NCj4gPiAtCU1EUF9DT0xPUl80MjBfQkxLXzEwX0gJPSBN
RFBfQ09MT1IoMSwgMCwgMSwgMiwgMSwgMSwgMzIwLA0KPiA+IDEsIDAsIDEyKSwNCj4gPiArCU1E
UF9DT0xPUl80MjBfQkxLXzEwX0gJPSBNRFBfQ09MT1IoMCwgMSwgMCwgMSwgMiwgMSwgMSwNCj4g
PiAzMjAsIDEsIDAsIDEyKSwNCj4gPiAgCS8qIDEwLWJpdCBIRVZDIHRpbGUgbW9kZSAqLw0KPiA+
IC0JTURQX0NPTE9SXzQyMF9CTEtfMTBfVgk9IE1EUF9DT0xPUigxLCAxLCAxLCAyLCAxLCAxLCAz
MjAsDQo+ID4gMSwgMCwgMTIpLA0KPiA+ICsJTURQX0NPTE9SXzQyMF9CTEtfMTBfVgk9IE1EUF9D
T0xPUigwLCAxLCAxLCAxLCAyLCAxLCAxLA0KPiA+IDMyMCwgMSwgMCwgMTIpLA0KPiA+ICAJLyog
VUZPIGVuY29kZWQgMTAtYml0IGJsb2NrIG1vZGUgKi8NCj4gPiAtCU1EUF9DT0xPUl80MjBfQkxL
X1UxMF9ICT0gTURQX0NPTE9SKDEsIDAsIDUsIDIsIDEsIDEsIDMyMCwNCj4gPiAxLCAwLCAxMiks
DQo+ID4gKwlNRFBfQ09MT1JfNDIwX0JMS19VMTBfSAk9IE1EUF9DT0xPUigwLCAxLCAwLCA1LCAy
LCAxLCAxLA0KPiA+IDMyMCwgMSwgMCwgMTIpLA0KPiA+ICAJLyogVUZPIGVuY29kZWQgMTAtYml0
IEhFVkMgdGlsZSBtb2RlICovDQo+ID4gLQlNRFBfQ09MT1JfNDIwX0JMS19VMTBfVgk9IE1EUF9D
T0xPUigxLCAxLCA1LCAyLCAxLCAxLCAzMjAsDQo+ID4gMSwgMCwgMTIpLA0KPiA+ICsJTURQX0NP
TE9SXzQyMF9CTEtfVTEwX1YJPSAgTURQX0NPTE9SKDAsIDEsIDEsIDUsIDIsIDEsIDEsDQo+ID4g
MzIwLCAxLCAwLCAxMiksDQo+ID4gIA0KPiA+ICAJLyogTG9vc2UgMTAtYml0IGZvcm1hdHMgKi8N
Cj4gPiAtCU1EUF9DT0xPUl9VWVZZXzEwTAk9IE1EUF9DT0xPUigwLCAxLCAwLCAxLCAxLCAwLCAy
MCwgIDEsIDAsDQo+ID4gNCksDQo+ID4gLQlNRFBfQ09MT1JfVllVWV8xMEwJPSBNRFBfQ09MT1Io
MCwgMSwgMCwgMSwgMSwgMCwgMjAsICAxLCAxLA0KPiA+IDQpLA0KPiA+IC0JTURQX0NPTE9SX1lV
WVZfMTBMCT0gTURQX0NPTE9SKDAsIDEsIDAsIDEsIDEsIDAsIDIwLCAgMSwgMCwNCj4gPiA1KSwN
Cj4gPiAtCU1EUF9DT0xPUl9ZVllVXzEwTAk9IE1EUF9DT0xPUigwLCAxLCAwLCAxLCAxLCAwLCAy
MCwgIDEsIDEsDQo+ID4gNSksDQo+ID4gLQlNRFBfQ09MT1JfTlYxMl8xMEwJPSBNRFBfQ09MT1Io
MCwgMSwgMCwgMiwgMSwgMSwgMTAsICAxLCAwLA0KPiA+IDEyKSwNCj4gPiAtCU1EUF9DT0xPUl9O
VjIxXzEwTAk9IE1EUF9DT0xPUigwLCAxLCAwLCAyLCAxLCAxLCAxMCwgIDEsIDEsDQo+ID4gMTIp
LA0KPiA+IC0JTURQX0NPTE9SX05WMTZfMTBMCT0gTURQX0NPTE9SKDAsIDEsIDAsIDIsIDEsIDAs
IDEwLCAgMSwgMCwNCj4gPiAxMyksDQo+ID4gLQlNRFBfQ09MT1JfTlY2MV8xMEwJPSBNRFBfQ09M
T1IoMCwgMSwgMCwgMiwgMSwgMCwgMTAsICAxLCAxLA0KPiA+IDEzKSwNCj4gPiAtCU1EUF9DT0xP
Ul9ZVjEyXzEwTAk9IE1EUF9DT0xPUigwLCAxLCAwLCAzLCAxLCAxLCAxMCwgIDEsIDEsDQo+ID4g
OCksDQo+ID4gLQlNRFBfQ09MT1JfSTQyMF8xMEwJPSBNRFBfQ09MT1IoMCwgMSwgMCwgMywgMSwg
MSwgMTAsICAxLCAwLA0KPiA+IDgpLA0KPiA+ICsJTURQX0NPTE9SX1VZVllfMTBMCT0gTURQX0NP
TE9SKDAsIDAsIDEsIDAsIDEsIDEsIDAsIDIwLCAgMSwgMCwNCj4gPiA0KSwNCj4gPiArCU1EUF9D
T0xPUl9WWVVZXzEwTAk9IE1EUF9DT0xPUigwLCAwLCAxLCAwLCAxLCAxLCAwLCAyMCwgIDEsIDEs
DQo+ID4gNCksDQo+ID4gKwlNRFBfQ09MT1JfWVVZVl8xMEwJPSBNRFBfQ09MT1IoMCwgMCwgMSwg
MCwgMSwgMSwgMCwgMjAsICAxLCAwLA0KPiA+IDUpLA0KPiA+ICsJTURQX0NPTE9SX1lWWVVfMTBM
CT0gTURQX0NPTE9SKDAsIDAsIDEsIDAsIDEsIDEsIDAsIDIwLCAgMSwgMSwNCj4gPiA1KSwNCj4g
PiArCU1EUF9DT0xPUl9OVjEyXzEwTAk9IE1EUF9DT0xPUigwLCAwLCAxLCAwLCAyLCAxLCAxLCAx
NiwgIDEsIDAsDQo+ID4gMTIpLA0KPiA+ICsJTURQX0NPTE9SX05WMjFfMTBMCT0gTURQX0NPTE9S
KDAsIDAsIDEsIDAsIDIsIDEsIDEsIDE2LCAgMSwgMSwNCj4gPiAxMiksDQo+ID4gKwlNRFBfQ09M
T1JfTlYxNl8xMEwJPSBNRFBfQ09MT1IoMCwgMCwgMSwgMCwgMiwgMSwgMCwgMTYsICAxLCAwLA0K
PiA+IDEzKSwNCj4gPiArCU1EUF9DT0xPUl9OVjYxXzEwTAk9IE1EUF9DT0xPUigwLCAwLCAxLCAw
LCAyLCAxLCAwLCAxNiwgIDEsIDEsDQo+ID4gMTMpLA0KPiA+ICsJTURQX0NPTE9SX1lWMTJfMTBM
CT0gTURQX0NPTE9SKDAsIDAsIDEsIDAsIDMsIDEsIDEsIDE2LCAgMSwgMSwNCj4gPiA4KSwNCj4g
PiArCU1EUF9DT0xPUl9JNDIwXzEwTAk9IE1EUF9DT0xPUigwLCAwLCAxLCAwLCAzLCAxLCAxLCAx
NiwgIDEsIDAsDQo+ID4gOCksDQo+ID4gIH07DQo+ID4gIA0KPiA+ICBzdGF0aWMgaW5saW5lIGJv
b2wgTURQX0NPTE9SX0lTX1VWX0NPUExBTkUoZW51bSBtZHBfY29sb3IgYykNCj4gDQo+IA0K
