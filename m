Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5101D70F3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjEXKTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjEXKS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:18:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA68B18E;
        Wed, 24 May 2023 03:17:40 -0700 (PDT)
X-UUID: 31ca1f66fa1c11edb20a276fd37b9834-20230524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=B6/j2UBu0IzF0ImBVcKwh2PaGQmwx7dv/Z5c0S1fFyE=;
        b=T7mEb3Me5tbZ/tEzkvU3jmE9da6t9FMrzxt3WqZ2xZfh9Q3Zsg4vYRM2OF/yhGMujSypUpY+XQi29ZFtga5BzMooLHUmqUAi3oHMxaLsLMuOYmxMPEkQCSAXnVbofyRdlXy2U6JPSAuMBE6oFt6PskCqD6Ud5qMhY9NvXjBAJS4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:cf5615e7-f216-4d80-87d3-114497900719,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:4362e3c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 31ca1f66fa1c11edb20a276fd37b9834-20230524
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 319608962; Wed, 24 May 2023 18:17:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 May 2023 18:17:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 May 2023 18:17:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MD1Yvv4p67tbE4u9A1qTFMeTHIdeVFpzyXV/ZzAWZ98/diF8b2YwBqiV0wjQ3NYjFlykqdSJ79QaUiw40DQOFHS/tUZWu3+54PeWnPQ51f8VabdnioTFpW41c73d3DOz5c+WR358+coHvF1epz7oWtk9oRjFfpUcWVEFqXEEuuGxwKJoSY20AWhR0sta2Y0vrtUhkvl25y2mYsZBnyUqpL+il+kTU/LIJYnOmpA6uI+wavT2Guv6ZgFcPy+ZyXAUTuGlC5+AEssfihhSxjwpxZFr5rR5dImkgFDrKIMwsNBgvqfP4vV19b2yHoSDo0yOhmhuVfWOUuvz8eKtYooH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6/j2UBu0IzF0ImBVcKwh2PaGQmwx7dv/Z5c0S1fFyE=;
 b=NI+oNO52+iqh0tboYcMpzkw39839LDzOprW2Rnr5UnSKdFu/mbSS6kApcfmfZBrf3Xmsp99eJoWEpoiqF3SK4+315TmZW8dp99RDrhwPzrmp0dH0zeAGm19hXTbp58L9n5OeLMeaXeHXYlJq2aq83l82CiuEnN9pxHgO+PP7icjctiOwa5QdnWXbYz/0lPFR86/sccKWTB5riRQC5gMN3P7eWo/ytZxyKoqSPI8EA1PCl6oZTRoUfQB0Hsezcvj1L1Vshc5sobCbZ1JnSPhNHls6XuIzSiAdArfwIyVPJ4T7E7jtsQb3/kSUyVkTUmSZTkVbgsy5gk+eE34PC/3RmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6/j2UBu0IzF0ImBVcKwh2PaGQmwx7dv/Z5c0S1fFyE=;
 b=LVf9pO9U8m/4XzdLCJELr7RCsHbjJg+Y4WuzRREiFMUcfuUPUKYbhZSLfRt5SaWVV4sQ5q/0AFnG4We+IhMYl51caL1bQlIgA+om4XGWMLsilDorovkezIgeuE9RzUWud+F4b/+4s1tY8g5Nfuuohu4eIohgn/xRbWrhnoWVDdA=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SEZPR03MB7195.apcprd03.prod.outlook.com (2603:1096:101:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Wed, 24 May
 2023 10:16:24 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::506f:2b56:e564:ba5a]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::506f:2b56:e564:ba5a%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 10:16:24 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
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
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v7,0/2] media: mediatek: vcodec: add hevc stateless
 decoder driver in MT8195
Thread-Topic: [PATCH v7,0/2] media: mediatek: vcodec: add hevc stateless
 decoder driver in MT8195
Thread-Index: AQHZjhblwCORrbb14EatDBsGTnMM8K9pJ+GAgAANhoA=
Date:   Wed, 24 May 2023 10:16:24 +0000
Message-ID: <44558245fdfc49e33d3a6478e30069ba4b6d3b3e.camel@mediatek.com>
References: <20230524080739.17264-1-yunfei.dong@mediatek.com>
         <b5c45ac7-64ad-ddc1-a7a2-99d9d1c27ca7@xs4all.nl>
In-Reply-To: <b5c45ac7-64ad-ddc1-a7a2-99d9d1c27ca7@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SEZPR03MB7195:EE_
x-ms-office365-filtering-correlation-id: c1b8e3f0-57b3-4c15-2aa9-08db5c3fed98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q5YJpKKXexQLNoqSly/+yyoGlb7KS/0WT38JSVYxHvlxKLf5a34ZgRnredW4g1wUZXO48XQIZQpFnTrrru2pO7dX6hk6KlU3nTbGfeQXHokTkgxx/9IP7HvITK21FsG+S50OByIPQCJbEABd4uocoBPrJ/aNHewHZCdS4InUqiplS5Oe8IOcZH9IVkZe6+tBB129pLyDJFPrm+Kt5foqP8ObkSu+knzOuKmzL3uY3hirb/TLNwXCAIJbpXg+PsV/1WZOrEPDGNu4FDKJS2nSFM0uwMSZYJAMxrUo5oZZA1kI88d1cjh9bEbzSDv/z+K5ahdoGZbyr9q2XVXK5HUicsAyDAuDnz2V20KOA/9r2uydcjw7adGbxoiWX/qrg0WGvQEhpbN5eEZNz0lTIGy/XdFfOv/bGVSxIA26mUQRcUCFnOimcUfidKpYoviNwvgj7vEnWS3B1XFZZ1Hgd9BYNOMnSfcvMr3sJx5nwruqt0XHOZ2QalaTeaxC3IMZZTJG9qRIYGcr4pEVGRHK676/1GHNEtrPsFzL4/XC+VqlWwt8JTvFO9HUB5wIzvy7LnUna8Fc67Pt7djcnKcZgocosIFDIKRc2EpawzrGOb2NarRoYDkDACBkGo4qoKFcasVT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(316002)(966005)(71200400001)(4326008)(38070700005)(66476007)(6916009)(66446008)(66556008)(64756008)(66946007)(76116006)(91956017)(478600001)(54906003)(8936002)(8676002)(6486002)(86362001)(41300700001)(5660300002)(7416002)(38100700002)(26005)(36756003)(6506007)(85182001)(6512007)(83380400001)(122000001)(53546011)(186003)(2906002)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmJjMzVFVWdjdWNjeXVITW1QN2EwQVc4SlZkSEFqMnViRDdvYXZVRlRDWkVF?=
 =?utf-8?B?R2FtQytOWGlTMzdkN1ZRejF3UWN5cWhzeDdKWTY2R0gxOVIxWkFGbENFa2xo?=
 =?utf-8?B?cmxpUDh4cHNZekJWRzV4RGozZXEwemd5RmtPTWptV3g0Zkl6UWc0ZXhEenNQ?=
 =?utf-8?B?U2N6UHRDbG10eWZzOEFpa2djaWQ5QVdXcSt1cE9sTklUT3A4TGJGM2t3eVQ3?=
 =?utf-8?B?NHhaM2owYnlrdHo2TDNEVzhycUF2dm54T1hXNE1sNWE4M0xQZklSRy9UMGdo?=
 =?utf-8?B?VUszL1MwRkNCKytxMEk0NlRQOWpGN1pNT2FSRGJOcEd4KzJDUGhML0tzYldo?=
 =?utf-8?B?Y2ZSdG95RTIvdDBSWFpUM2xVL2M0WGJST05QeDJNaERtQmgxS3BicHZPbjhk?=
 =?utf-8?B?amlUUEtJalBmWXZSekRjUC9IYUhtVXNQV1lEZDlvTFJ5a2JpNlFFOWxqQ2VN?=
 =?utf-8?B?RngxaHM2cmYvQ1dJV0YyN1ltTVRHSDlOQlR5eHNsTWFnUVNBT25ETHppWDlK?=
 =?utf-8?B?bk5SZHZ5ek1JcXQzMVJCZTFnUWQ5WTY3ZktzelhSWGxCNWsrbmtNV0htSFQ5?=
 =?utf-8?B?ZlNCeWNRRmd1OWxzTXI0VDhFWi9ITm5HWW9aY1MwOHUraXdMenJyZWlVdVRy?=
 =?utf-8?B?eDhpQ3V5SUxSMHgwb3BxakJldWQ1alNrOUVpNnVsUEp2SVdUZG9CRWdhcnZR?=
 =?utf-8?B?anZzZVVwVEV3YUNTZ1NHNVpseE1sKzhIRUdmWDZ6aWt2UjRQc2tIUzRQTi9z?=
 =?utf-8?B?WFk4c0VxYm8vcTR1cmlFUG9HSVNUWXZpSUU2OE01N1lHbWh4NUtIbjNBd2FB?=
 =?utf-8?B?YzdmVkxwQnh0bEZhMkdWV2dpMDQvbVJCRFBIclRtQXpGZExBM0xWTHJvS3lp?=
 =?utf-8?B?cElzaXhjblNjM2VmOHRneFpOYUVUQXdBczBjV1hFQ1ZLODQ0d0MvUmc1ak12?=
 =?utf-8?B?VzQ5TjJkUnh4NUFnd3lseDgzTlVlTDZqMlNxd3NSTHlHWEh1dEIwMGx2Y1A2?=
 =?utf-8?B?bmNxbWVKbzZlcnpBSWZuM05yS3V5NHoxTUxDZ3Q1aFNCZjMxYlBmYW9MVmIz?=
 =?utf-8?B?cElUSVZRMjN0a0FheFIxK3hDeXJOdGR6cU1OcnVvcTJUd00remJUQjJRbW1j?=
 =?utf-8?B?L2pGU0wwK3o0KzdrVmlOVWR5OUN1SDdOby9qT0MyZ0Jud0NjSCtDb0xEd2Q5?=
 =?utf-8?B?RXdydElzc3FMZnRHS3BwYXJoZW1WRitpb0xTaHhYbG1hN2lwUm1wRkpEK2FD?=
 =?utf-8?B?UDNFaFlndzlBUGQ1YzF1NHJsSXJ1TjdNSDU5bm9uaE9kNnNmME9NajdtQUIx?=
 =?utf-8?B?TTU2aEp4YTlEQTdObnFQbzZIZGtNWTRvM0VKdDFtMHdjdWE1UmpJWDh3Y3gr?=
 =?utf-8?B?a3o5eExJYlQwend3MTJKMjREcVlxd05UbTMrc3JjRmxUS2prYnhFWTJocjJu?=
 =?utf-8?B?NVFsYTVGcEVWS2FuR1N3cE0xdmFUdHA3azNuZFBGbnlDRHlpTWpxOWQ2L2ht?=
 =?utf-8?B?OTVPeEtKaFdxWHltdXA2MGgyUHhCaGhjT3F3dDRlT2pwZld6ZkgyWW9xb3Vl?=
 =?utf-8?B?Qlc4MUo1ZElSRTN6K1BDTmN1UHFZVm5sYXJoNkdYV2MrV2daWVdOb2xzd29h?=
 =?utf-8?B?Q2RWdHBkTjQrMXNqc1gxSTFWWGdsSnEzbFExbXJQQk5CdkNRYk96TlJ5MUlv?=
 =?utf-8?B?WWxWVzUzR29PVnVKZ21wU2RGUGxIUGsyOXRYN0d2YldDMWhMNC9hc29tbWx4?=
 =?utf-8?B?bk1tcHZwbHFweGI5L2VpQUdwUzd6T1g0Y2FQL3RHQWNUbUJOUmhUS21kZGp6?=
 =?utf-8?B?dVA1aFlYMU82RHdhektjMTIvMFI1NHpuVTVyTXkwRllSRVB0R2lEQkwwL0V3?=
 =?utf-8?B?V0xvWE9zdVNOSmdhL0szS0ovSDdTVkpuNk1FTHBONlh2Q3NsVXVrSlpwbSt6?=
 =?utf-8?B?M1Zyc09GczhTUnRFME0vK3czUzRFSjdMTC9vSHR2cmJSQTNuU2FyTE0vVFMx?=
 =?utf-8?B?enkxR3lYNDJxVzB1ZUVHSzZZQjBqa2Q2czJoNXNFeXFESlBvRHFtaWoyNmVR?=
 =?utf-8?B?cHU1b2ZEak8veVlFMHZHS0VMalZ1TXNOSFg3NlZXRnp2YTBBRWpES2Jvdkdy?=
 =?utf-8?B?WTZyd2pBZ05HeVpUTktvN2RsZnhlN1VYR05idFdwdXlXdWVPdkM1L1ZBMFZG?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25077087D7702F429E9998C706AB0147@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b8e3f0-57b3-4c15-2aa9-08db5c3fed98
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 10:16:24.1779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nc7Q7AZ8Ifxu9CjAka92DX//mipa7WxnSar+NBO13MoO5xyR+1UyvlKCHkElaj4T9dkVhKgj2GKTYbdy0I9W067eIeEsJRMiN54Ba54h3DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7195
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQoNCkkgZG9uJ3QgdW5kZXJz
dGFuZCB5b3VyIG1lYW5zIHZlcnkgd2VsbCwgbmVlZCB0byBjb25maXJtIHdpdGggeW91DQphZ2Fp
bi4NCg0KaGV2Yyh2NykgLS0tID4gbWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IHN1cHBvcnQgc3Rh
dGVsZXNzIGhldmMgZGVjb2Rlcg0KcGx0KHYzKSAgLS0tLT4gbWVkaWE6IG1lZGlhdGVrOiB2Y29k
ZWM6IEZpeCBkZWNvZGVyIHVuZGVyIGZsb3cgYW5kIHBsdA0KdGVzdCBmYWlscyByYW5kb21seQ0K
DQpXaGV0aGVyIGhldmMgYW5kIHBsdCBwYXRjaGVzIG1lcmdlZCB0b2dldGhlcj8NCg0KV2hldGhl
ciB5b3UgbWVhbiBJIG5lZWQgdG8gcG9zdCB2OCBmb3IgaGV2YyBwYXRjaCBiYXNlZCBvbiBwbHQg
cGF0Y2ggYXMNCmJlbG93IG9yZGVyPw0KaGV2Yyh2NykNCnBsdCh2MykNCm1lZGlhIHN0YWdlIEhF
QUQNCg0KSSBjaGVycnkgcGljayBhbGwgcGF0Y2hlcywgd29uJ3QgZ2V0IGNvbmZsaWN0Lg0KDQpP
ciBJIG5lZWQgdG8gcG9zdCBoZXZjIHBhdGNoIGJhc2VkIG9uIG1lZGlhIHN0YWdlIEhFQUQ/DQpo
ZXZjKHY3KQ0KbWVkaWEgc3RhZ2UgSEVBRA0KDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0K
DQpPbiBXZWQsIDIwMjMtMDUtMjQgYXQgMTE6MjcgKzAyMDAsIEhhbnMgVmVya3VpbCB3cm90ZToN
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29u
dGVudC4NCj4gDQo+IA0KPiBIaSBZdW5mZWksDQo+IA0KPiBPbiAyNC8wNS8yMDIzIDEwOjA3LCBZ
dW5mZWkgRG9uZyB3cm90ZToNCj4gPiBBZGQgaGV2YyBzdGF0ZWxlc3MgZGVjb2RlciBkcml2ZXIg
dG8gc3VwcG9ydCBoYXJkd2FyZSBkZWNvZGUgaW4NCj4gPiBNVDgxOTUsIGFuZCB0aGUgZHJpdmVy
DQo+ID4gbmVlZCBudW1fZGVsdGFfcG9jc19vZl9yZWZfcnBzX2lkeCB2YWx1ZSB0byBwYXJzZSBz
bGljZSBoZWFkZXINCj4gPiBzaG9ydF90ZXJtX3JlZl9waWNfc2V0KCkuDQo+ID4gDQo+ID4gcGF0
Y2ggMSBhZGQgbnVtX2RlbHRhX3BvY3Nfb2ZfcmVmX3Jwc19pZHggZmllbGQuDQo+ID4gcGF0Y2gg
MiBhZGQgaGV2YyBzdGF0ZWxlc3MgZGVjb2RlciBkcml2ZXIuDQo+IA0KPiBUaGlzIHNlcmllcyBj
bGFzaGVzIHdpdGggdGhpcyBvbGRlciBzZXJpZXMgZnJvbSB5b3U6DQo+IA0KPiANCmh0dHBzOi8v
dXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5saW51eHR2Lm9yZy9wcm9qZWN0
L2xpbnV4LW1lZGlhL2NvdmVyLzIwMjMwNDI0MDYwMTMwLjE4Mzk1LTEteXVuZmVpLmRvbmdAbWVk
aWF0ZWsuY29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3IW5kaS02aTloMktrR2htMVNnZzRhQVhySTNp
WVZNS3R5eFIyYmp0LUhDdWpJTDVkOS1PZlN6ZkpubHZ3bVZ1SVJDd2dkWnRsUDR6MHpOVTFmdkNE
OVdQUXZwZXlLRHlVSyQNCj4gDQo+IENhbiB5b3UgcG9zdCBhIHY4IHRoYXQgc2l0cyBvbiB0b3Ag
b2YgdGhhdCBvbGRlciBzZXJpZXM/DQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gICAgICAgICBIYW5z
DQo+IA0KPiA+IC0tLQ0KPiA+IENoYW5nZWQgZnJvbSB2NjoNCj4gPiAtIGZpeCBBbmdlbG9HaW9h
Y2NoaW5vJ3Mgc3VnZ2VzdGlvbi4NCj4gPiANCj4gPiBDaGFuZ2VkIGZyb20gdjU6DQo+ID4gLSBj
aGVja3BhdGNoL2tlcm5lbC1kb2MgcGFzcy9idWlsZCBwYXNzLg0KPiA+IC0gZml4IHdhcm5pbmc6
IHN0cnVjdCB2ZGVjX2F2MV9zbGljZV9mYiAtPiBzdHJ1Y3QNCj4gPiB2ZGVjX2hldmNfc2xpY2Vf
ZmIuDQo+ID4gLSBmaXggd2FybmluZzogcmVtb3ZlIHVudXNlZCBjb21tZW50IGZvciBwYXJhbSAi
dHJhbnNfc3RhcnQiIGFuZA0KPiA+ICJ0cmFuc19lbmQiDQo+ID4gDQo+ID4gQ2hhbmdlZCBmcm9t
IHY0Og0KPiA+IC0gZml4IHNvbWUgY29tbWVudHMgYWNjb3JkaW5nIHRvIE5hdGhhbidzIHN1Z2dl
c3Rpb24uDQo+ID4gDQo+ID4gQ2hhbmdlZCBmcm9tIHYzOg0KPiA+IC0gYWRkIHRoZSBkZXBlbmRl
bmN5IHBhdGNoIHRvIHRoaXMgcGF0Y2ggc2VyaWVzIGZvciBwYXRjaCAxLg0KPiA+IA0KPiA+IENo
YW5nZWQgZnJvbSB2MjoNCj4gPiAtIGZpeCBvbmUgYnVpbGQgd2FybmluZy4NCj4gPiAtIGFkZCB0
aGUgZGVwZW5kZW5jeSBwYXRjaCBsaW5rLg0KPiA+IA0KPiA+IENoYW5nZWQgZnJvbSB2MToNCj4g
PiAtIGZpeCBidWlsZCBlcnJvciB3aGVuIGJ1aWxkIDMyYml0IHN5c3RlbS4NCj4gPiAtIGhldmMg
Zmx1c3RlciB0ZXN0IHJlc3VsdDogMTMyLzE0NyAobm90IHN1cHBvcnQ6IDEwYml0ID0+IDExIGFu
ZA0KPiA+IHJlc29sdXRpb24gPT4gNCkuDQo+ID4gLS0tDQo+ID4gQmVuamFtaW4gR2FpZ25hcmQg
KDEpOg0KPiA+ICAgbWVkaWE6IHVhcGk6IEhFVkM6IEFkZCBudW1fZGVsdGFfcG9jc19vZl9yZWZf
cnBzX2lkeCBmaWVsZA0KPiA+IA0KPiA+IFl1bmZlaSBEb25nICgxKToNCj4gPiAgIG1lZGlhOiBt
ZWRpYXRlazogdmNvZGVjOiBzdXBwb3J0IHN0YXRlbGVzcyBoZXZjIGRlY29kZXINCj4gPiANCj4g
PiAgLi4uL21lZGlhL3Y0bC9leHQtY3RybHMtY29kZWMtc3RhdGVsZXNzLnJzdCAgIHwgICAgNyAr
DQo+ID4gIC4uLi9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvTWFrZWZpbGUgICB8ICAg
IDEgKw0KPiA+ICAuLi4vdmNvZGVjL210a192Y29kZWNfZGVjX3N0YXRlbGVzcy5jICAgICAgICAg
fCAgIDU5ICstDQo+ID4gIC4uLi9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19k
cnYuaCB8ICAgIDEgKw0KPiA+ICAuLi4vdmNvZGVjL3ZkZWMvdmRlY19oZXZjX3JlcV9tdWx0aV9p
Zi5jICAgICAgfCAxMDk3DQo+ID4gKysrKysrKysrKysrKysrKysNCj4gPiAgLi4uL3BsYXRmb3Jt
L21lZGlhdGVrL3Zjb2RlYy92ZGVjX2Rydl9pZi5jICAgIHwgICAgNCArDQo+ID4gIC4uLi9wbGF0
Zm9ybS9tZWRpYXRlay92Y29kZWMvdmRlY19kcnZfaWYuaCAgICB8ICAgIDEgKw0KPiA+ICBpbmNs
dWRlL3VhcGkvbGludXgvdjRsMi1jb250cm9scy5oICAgICAgICAgICAgfCAgICA2ICstDQo+ID4g
IDggZmlsZXMgY2hhbmdlZCwgMTE3NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVr
L3Zjb2RlYy92ZGVjL3ZkZWNfaGV2Y19yZXFfbXVsdGlfaWYuDQo+ID4gYw0KPiA+IA0KPiANCj4g
DQo=
