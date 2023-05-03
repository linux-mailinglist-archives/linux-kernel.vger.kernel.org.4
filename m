Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427346F58FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjECNXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjECNXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:23:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3986526B
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:23:28 -0700 (PDT)
X-UUID: acc0bad0e9b511edb20a276fd37b9834-20230503
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vBtfGqgwDxz3Lkn2+ohKdw0z4E8EKGHJpnQlcDVdcNk=;
        b=Xe2TAJxS8DplXJkU7iM5OjsyRbFPM/2SKOKyoDvndvLXq4x5ez/LapAojLZL6YrKTpbxBFtIjOK1Hprt8r75+flki+RXS6+Y0GxcA+DQPNIRQfzVXp8rN8oEDn3wj6IvMfWSVM/vqXAHIaVsj4XXqPbw7igrhytOibcYsj8OWew=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:123381e8-ffbe-4aa8-8bc0-ef359baf38e1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.23,REQID:123381e8-ffbe-4aa8-8bc0-ef359baf38e1,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:697ab71,CLOUDID:0898adbf-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230503212323VD7IQS1O,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: acc0bad0e9b511edb20a276fd37b9834-20230503
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 560500863; Wed, 03 May 2023 21:23:21 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 3 May 2023 21:23:20 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 3 May 2023 21:23:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXI6eLzfAiRZU7HPRHXmCuAwnbJkFZgH1UUWDyyOevW1+W9CEKJsk/Or4qtQIrWjk1da8gDe+wixXEPy1IU7hLHT+PXbTgGVmS6o6oaPongbVX1xIwJhxgboyPlD6n9lgYyINj2nMho/YsnB9QgZr+A4o1/VuBzOy/oy1IOvB++kRLUEizYe2hASaZZwbIAvUkXuye5MQGBMoAk1+mhDsi2Ibtg4X92Xk36ThnTfjIkoEcp3I4ddqz1TRXF0Dtn0YGlNGA6sKnoHLzWxdYJNCZiQDaK+Xf0/hTH+D7opY6e66xa6HxwOptfOCosBJWXCYf4hTVwx9+GESRrNWIOTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBtfGqgwDxz3Lkn2+ohKdw0z4E8EKGHJpnQlcDVdcNk=;
 b=hPJW6axysKd1ueK8L1Y3pbHtPlinDy15w09823msmBPERgDLnL2wGqSEqeWOcP1/iaAt0VfYU8W4JXE/59BK3Rdz7Xj7mwGldZN26GK2EnM74CcJT1aSunp/6MOX1lfFLk1KfMm6YYtMk9iFGNeRH2ss4u0YCZNOMXpjMqy9cAzGfklWJWbiBmSR8o31tQOwCl2veiaXrpboOWxtaCdLy7tH/0hjKcZACFGsYSYRnRui7FOWOcIUfBpkcvoS7iK/fgjd5IuZs/o8qC9EYVxK8enDSOopz0gHyqLAf3z1uEGQ+RbFXrJC8NwxuMvLRe9a57irl/DSK8jJY9xzXROEDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBtfGqgwDxz3Lkn2+ohKdw0z4E8EKGHJpnQlcDVdcNk=;
 b=IjZjO6uHiaVinjYYRDVDbliadOi8Ai2X/Um57gOkWdYabLA41mExj5Xh7+cR0ea1grVhwwDq+F36+If/0lbMORPO1+frBzmLwN2QguI84xTQX7LArQ129LZQ5HjurlfZkpgDh4kfyapRF8fHNeL/dHIvb6R0S0kYqZfwW3mEqK8=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by KL1PR03MB7768.apcprd03.prod.outlook.com (2603:1096:820:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Wed, 3 May
 2023 13:23:17 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 13:23:17 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "sound-open-firmware@alsa-project.org" 
        <sound-open-firmware@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "ribalda@chromium.org" <ribalda@chromium.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        =?utf-8?B?WUMgSHVuZyAo5rSq5aCv5L+KKQ==?= <yc.hung@mediatek.com>,
        "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        =?utf-8?B?Q2h1bnh1IExpICjmnY7mmKXml60p?= <Chunxu.Li@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>,
        "error27@gmail.com" <error27@gmail.com>
Subject: Re: [PATCH 3/5] ASoC: mediatek: mt8195-afe-pcm: Simplify runtime PM
 during probe
Thread-Topic: [PATCH 3/5] ASoC: mediatek: mt8195-afe-pcm: Simplify runtime PM
 during probe
Thread-Index: AQHZfbNgS+5ddLpbUUeKibpdr3MHvq9IiW8A
Date:   Wed, 3 May 2023 13:23:17 +0000
Message-ID: <46e01c133742d46cb59a9c381132858701b04844.camel@mediatek.com>
References: <20230503113413.149235-1-angelogioacchino.delregno@collabora.com>
         <20230503113413.149235-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230503113413.149235-4-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|KL1PR03MB7768:EE_
x-ms-office365-filtering-correlation-id: 035979b9-8d69-4c71-d2d1-08db4bd98e81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q+2Y/B6SvmPJPdWiPHV47dIQNAnRcetZ5nhbZJuMRhywwQBJ1l6b9q8GipArTRzowFR3FsgB4R3fywUDshwaPOM+cfaC3rCAUdQtT4NRgsXvpyZNsw/tUgC4dPekjg3ge/GT6ydws7Ig2TPjbKYsvYZaRg9e+nFBqIz5SIapje1werbOtnaugRjzAzxwJgD4ydew5/8FrCwmcHIHDccLM1C1ZY5m2tLNdb7xoIaw+BM9kTSNE94vPLOY3XHKXptZ7YJj8sg7dug0nI0d1xFU0Y7aVhN2NGPrLdN3lmq4GiS+smMe4n64LAwoyolnZgIixhUDdteR+5ChqSbQ1HC5tMUz1TH+jOH0CqQx51MdhOAraYqd28GEmkGyl7LwSuFdo1HD882deZnPTSPeSoQtQ/F1OCJpW41npftccuwtvQEiebIZac6yaMieKlBqV3bFwLKevEQ08cQ7KNcbdqX7Y8rV3FSMPbmzeVYVzKf3+0cjqnIQCyWodGYCvWMkmOupCT+KejLBHO3277h4UYWv8RWes3fAgN7eq+E9YrDK25Ipe87d+Ns0+SWb0dDI2ZthKZ0iVdiGq9/RvnF1ni1jdrQwt2wUM04tseVOLOWb/wfaSe0VlMfu+x7FJzBIToAWS2v04HWgeC/hlj+uGX6hlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(2616005)(5660300002)(8936002)(8676002)(41300700001)(83380400001)(71200400001)(110136005)(6486002)(54906003)(478600001)(66476007)(186003)(66946007)(76116006)(6512007)(64756008)(66556008)(6506007)(66446008)(26005)(4326008)(91956017)(316002)(36756003)(85182001)(2906002)(122000001)(38100700002)(86362001)(38070700005)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3RydlBqMUxHU0wraU5GVE1xQmhHQlZNc2ZlNUJzM2FqdHZZQzFSOCs0cDI3?=
 =?utf-8?B?Tm5KcVUzZ0ZVTzJtbitCY1RPRjZCRDJXZHJiMlc4dDlFZVB0RHNmOXYrTjdR?=
 =?utf-8?B?WFdCYksrR29nVktLNkVZM3IvOE1rM3M2SkR2RG1OSWZab2lLUkR6aE5kWWIy?=
 =?utf-8?B?T0ZOb3psUXhHQWUxd0NCR0VzTVF3NGRVNVBCWFNTSHNJT2VVNW1rclZVdDYy?=
 =?utf-8?B?ZEc2OHZVSE9KY3lXMXhRL3VuM09hU05RNEFnVk1hUWhpZDZtYktwZ1BkTTlo?=
 =?utf-8?B?a3cwZWZtbVlqN2M1bEQ3b3BsT3NpY2RuYVJIdk84Z1AyeHNGdG5UeGc5T1U5?=
 =?utf-8?B?Q0JjNDhBc2dTTUJOMFZRQVkrM2YzOGFqSlkzZFB4Z1EwbDVudCtZbG5LMUsx?=
 =?utf-8?B?WVhYTCthVE9JVXV2RUtJYmhGWGZoQmhydjhINTBvWno2QkptdCt0VHpqSVdO?=
 =?utf-8?B?SVp3N3FjQzV2YlIyME1peVFqcXkwa1dGanMwOHhleVVDMUF2a0I0cW94RUlt?=
 =?utf-8?B?akpJekVjOFhacFRXb2R2MjNWaURhTE01emEvMk5aS1Rkc3BSVitWOVA3bGFT?=
 =?utf-8?B?TG1zOGtiRzNVc1lFWXdSblc1MEhBbnMwOS9RSHZ5Z1BhM25iVHVqeDF0Mmtp?=
 =?utf-8?B?V000RmwweTVtd2srUmtUYjRSSkVUQWNneUlIdDl2RnFwMzlXdkxvQ3Y5WDBw?=
 =?utf-8?B?NVVVWGhHaWNjTjYzZy82ajcyRkh5d3oxWk1La0ttb2dDQTlVZ0xRWElVNWVZ?=
 =?utf-8?B?Q095ZjJGVXJ4UnNFdmczQUNEeDIrSDV3M050eTR4UVpBL3dJOU1VVVE4UDhZ?=
 =?utf-8?B?VDkvWGVTK0MwR1BpSW8vanNlZDhiRmNHaGc4SXh1cDJHajl5aGxwQ3g2MHBT?=
 =?utf-8?B?V1hVQ0RVYXV0emdhNndKbnpyOUJLQzhlN3VKbHRyNjBBYXRxc3pCcTg0YUVL?=
 =?utf-8?B?aVAvUnZOVWpabU5zK3RJeFdtc29qckl2RlJqODlZcVJhc2l6TkJiZEdMckI1?=
 =?utf-8?B?SDhTOE5PRSt6NUNOUjc1Uy9LcFV0Q0E3R3JFL3UzOHpNbmF6QytBNXF1bTFL?=
 =?utf-8?B?dWpWT3B3aHFpbmErN2RYQ2FnK1VMbnpaUUxaY044dUxhRmNuMVErbEFVSWxH?=
 =?utf-8?B?ZjlJSmVNRnRZbkpXaVlNV3c3ak9ZbkEvZXRDaUlpeVc1KzUxd2dLYTVZQkZa?=
 =?utf-8?B?eXhaVTIwTzFOUmJUU00ycnBGWWVReExXRDNkSzhTdkxEYytqSVZhNStESG13?=
 =?utf-8?B?djF4eE1UU0NFQnRrY1RaTzZrSFVMQ3FGK3lCWEdNaHBqaFhLVVpTQkpqMWhw?=
 =?utf-8?B?Z01KSzhQakFvTGNjWDJ2bUVJQTFCTERLSFF6NjNqN2NYbld3T2tLM3RQalhD?=
 =?utf-8?B?ZFZpazU0MjJIMnozck4wYUFYeGlURkI5K1JiRkppRUVUMnVkNmFBc2tWMnNv?=
 =?utf-8?B?bjU0YzRqQ3BzSXdyR1poUFAySmhGYXFUYWU5R3JWYm5GRzRjTHJhTUtTbVE2?=
 =?utf-8?B?UFREM2JBVmFJM0FtdUhPdzBicHpQRUdzLzRSWWRmSDJCM2lSWk9DS01BRlYr?=
 =?utf-8?B?ZzkrWitUSU5rSEZsQmVLYWtrWVJJUUJ1YVFNeEQvOXI5SWgzRU9mNCtQc3JR?=
 =?utf-8?B?UjhJcHcvRHFIM1RVUGkvTktjRXBMcG1RVUR6cFNRajdFaHdoeXVrRVI5Q1dl?=
 =?utf-8?B?dDdUY0s4TkwyUlZ4UG1EekJZellNZkhJN2l3TFF2V1gyaEVZejJscFRWcFJ6?=
 =?utf-8?B?MHJxV2wwSmEyVnp0Wk5BaWZSZU96NmNSWGJib1ZLd2JtbTJ6Yy95OTR5V2lv?=
 =?utf-8?B?VVBPTGVxZG1jQk1nUTdxNjNXMFB6Nk0vYjhlalR5R0pzTHJvdloxN0svVnlR?=
 =?utf-8?B?T3JITm9uUHVGbE9sUUV3TnRpZnN0VmlGYksvb1B5TklxZHkwT0VlWEVPSWVB?=
 =?utf-8?B?aVdRaHNFcXNSRHRLcDJKRjllT3gwMExJaDNRZWtEZFo3S3hnYU41TmE4QlhG?=
 =?utf-8?B?QVQ3dG94K0EzUGw3T2QrMm1qV1V3VjVDOGRqc1NXZXN4YXgxZHhCcFBQbm82?=
 =?utf-8?B?ZUErSk9rTGFYQlFBZ2k1NFRjTzFrdUMwSXB2WEdzYXlDaFFTOHluRmVkUG1X?=
 =?utf-8?B?bGYxUXBENENkWThxU0FSUGhDTzdIdUFXOE5aWXlzRDZqdlBqcjIrZmhsRkNF?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBC22CCCE541C046A52FFB3C57606242@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035979b9-8d69-4c71-d2d1-08db4bd98e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 13:23:17.3704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1IiS51huRf6KOQpeKmdt/LsO1WoWLyFtFpc6WkhysNahVnCxz+PFxIZh8zr61vPPTzQhpAo4wuoNWtbuukpCVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7768
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTAzIGF0IDEzOjM0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBVc2UgZGV2bV9wbV9ydW50aW1lX2VuYWJsZSgp
IGFuZCBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KCkgdG8NCj4gdG8gc2ltcGxpZnkgdGhlIHBy
b2JlIGZ1bmN0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwg
UmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQoNCkFj
a2VkLWJ5OiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgc291
bmQvc29jL21lZGlhdGVrL210ODE5NS9tdDgxOTUtYWZlLXBjbS5jIHwgMjIgKysrKysrKysrKysr
LS0tLS0tDQo+IC0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTk1
L210ODE5NS1hZmUtcGNtLmMNCj4gYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTk1L210ODE5NS1h
ZmUtcGNtLmMNCj4gaW5kZXggOWU0NWVmZWFkYTU1Li5hNTRjMTZlMGFhMDUgMTAwNjQ0DQo+IC0t
LSBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxOTUvbXQ4MTk1LWFmZS1wY20uYw0KPiArKysgYi9z
b3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTk1L210ODE5NS1hZmUtcGNtLmMNCj4gQEAgLTMxNzksMTYg
KzMxNzksMTYgQEAgc3RhdGljIGludCBtdDgxOTVfYWZlX3BjbV9kZXZfcHJvYmUoc3RydWN0DQo+
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+ICAgICAgICAgbXQ4MTk1X2FmZV9wYXJzZV9v
ZihhZmUsIHBkZXYtPmRldi5vZl9ub2RlKTsNCj4gDQo+IC0gICAgICAgcG1fcnVudGltZV9lbmFi
bGUoZGV2KTsNCj4gLSAgICAgICBpZiAoIXBtX3J1bnRpbWVfZW5hYmxlZChkZXYpKSB7DQo+IC0g
ICAgICAgICAgICAgICByZXQgPSBtdDgxOTVfYWZlX3J1bnRpbWVfcmVzdW1lKGRldik7DQo+IC0g
ICAgICAgICAgICAgICBpZiAocmV0KQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
cmV0Ow0KPiAtICAgICAgIH0NCj4gLQ0KPiAgICAgICAgIC8qIGVuYWJsZSBjbG9jayBmb3IgcmVn
Y2FjaGUgZ2V0IGRlZmF1bHQgdmFsdWUgZnJvbSBodyAqLw0KPiAgICAgICAgIGFmZV9wcml2LT5w
bV9ydW50aW1lX2J5cGFzc19yZWdfY3RsID0gdHJ1ZTsNCj4gLSAgICAgICBwbV9ydW50aW1lX2dl
dF9zeW5jKGRldik7DQo+ICsNCj4gKyAgICAgICByZXQgPSBkZXZtX3BtX3J1bnRpbWVfZW5hYmxl
KGRldik7DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7
DQo+ICsNCj4gKyAgICAgICByZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGRldik7DQo+
ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2Jl
KGRldiwgcmV0LCAiRmFpbGVkIHRvIHJlc3VtZQ0KPiBkZXZpY2VcbiIpOw0KPiANCj4gICAgICAg
ICBhZmUtPnJlZ21hcCA9IGRldm1fcmVnbWFwX2luaXRfbW1pbygmcGRldi0+ZGV2LCBhZmUtDQo+
ID5iYXNlX2FkZHIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJm10ODE5NV9hZmVfcmVnbWFwX2NvbmZpZw0KPiApOw0KPiBAQCAtMzIzOCw3ICszMjM4LDEw
IEBAIHN0YXRpYyBpbnQgbXQ4MTk1X2FmZV9wY21fZGV2X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+IA0KPiAgICAgICAgIG10ODE5NV9hZmVfaW5pdF9yZWdpc3RlcnMo
YWZlKTsNCj4gDQo+IC0gICAgICAgcG1fcnVudGltZV9wdXRfc3luYyhkZXYpOw0KPiArICAgICAg
IHJldCA9IHBtX3J1bnRpbWVfcHV0X3N5bmMoZGV2KTsNCj4gKyAgICAgICBpZiAocmV0KQ0KPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQgdG8g
c3VzcGVuZA0KPiBkZXZpY2VcbiIpOw0KPiArDQo+ICAgICAgICAgYWZlX3ByaXYtPnBtX3J1bnRp
bWVfYnlwYXNzX3JlZ19jdGwgPSBmYWxzZTsNCj4gDQo+ICAgICAgICAgcmVnY2FjaGVfY2FjaGVf
b25seShhZmUtPnJlZ21hcCwgdHJ1ZSk7DQo+IEBAIC0zMjQ4LDcgKzMyNTEsNiBAQCBzdGF0aWMg
aW50IG10ODE5NV9hZmVfcGNtX2Rldl9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiANCj4gIGVycl9wbV9wdXQ6DQo+ICAgICAgICAgcG1fcnVudGltZV9wdXRfc3luYyhk
ZXYpOw0KPiAtICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOw0KPiANCj4gICAgICAgICBy
ZXR1cm4gcmV0Ow0KPiAgfQ0KPiAtLQ0KPiAyLjQwLjENCj4gDQo+IA0K
