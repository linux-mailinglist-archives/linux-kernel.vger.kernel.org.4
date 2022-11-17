Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6762D6E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiKQJaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiKQJ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:29:59 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF0A240A3;
        Thu, 17 Nov 2022 01:29:57 -0800 (PST)
X-UUID: f5637aa8b83b4b76ac3cfda5a62ac85f-20221117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kMJofAfPx9be9VZLFI+uJ1bJaijY57uykZrVywYt2H0=;
        b=tl4AXqrrfuzwyDKQdHge/RNv2Ar7VfgdgLXGSYAKtFqZTZyFijWFJdulFcq+RW2DAAaT9kEoJO373zkHxZmQxUlJ1XEuOrKEubZmIznEAjlVwip+aF/bVTgXzCPnfHHskG4I6OtRB29RODHtlSlxxVr/a95yOH7dOfzqn4Xv3x0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:0a9fc4b0-1322-4910-9afd-a9b4c7d6f4cb,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:5b9588f8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f5637aa8b83b4b76ac3cfda5a62ac85f-20221117
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 148137694; Thu, 17 Nov 2022 17:29:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 17 Nov 2022 17:29:49 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 17 Nov 2022 17:29:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSpCXVuCr1Yvb7nVvwgjEzbLyu1tG4SnP0Td4qNuH4v+wxmo4AydgZr9f5q6svnyD34brHE8H9TcOBa4QSMRgDNa7PS3OMsFMWeGnLTdaewb9AIYkCNj3gubzOK+9eC4XtnL8WRp3mCCcSNrIS/yUTr+ly4GUmKXzK5GtSONyuB/tgtItcdcJnXzkM91KhWB6rZqxyjhqbxQ4p0/CIma9a5oRh/V1BqK0gkpeEC6bqZIJROCWhO40f8UW66muJT00XOtNQS3R8Uc6i1omVbgGrwQHMlt2CFNoAswMjeKLkm/ulhJhHWwt2ublW2E52wRVqZVk057HjP29YOTR/rSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMJofAfPx9be9VZLFI+uJ1bJaijY57uykZrVywYt2H0=;
 b=Q728nrlPA5yO5uYE595/ltdMYIsLUaoJ64BV9Cc5BS2+yZpqKN0Jxnp/7rBf9IQPv/V2lEfuOd/cTligSfqcg/QKoB3moBTVVI2cYqlHtuJq0oRXwwl5QDycnyPuoVQ2nAkDDOWE7WqvCOfLJUH0nE2BIBYPdhVyiSexLMDav0xAsu+CED7jjOAWzkhfLwkYTeXj9+o9gYTL65bBgeOA1YRmZbxuI9yO/A3LPxisLOGLAXhHuxLQVcPLqZWpKxr1inGNUFM+sQA58xlW4qtLnpwlt2N6hQ1s/uQtSTDzeAPZ/bnZVycBOO/TWUZ2SkNXhPTvUMX3wOU49WCgADtAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMJofAfPx9be9VZLFI+uJ1bJaijY57uykZrVywYt2H0=;
 b=ISDNfHd/N5ZpqSSyLPkZcIyj3tMNHHy01v7oLDpcYTUQ479vZUU/EUawVXQ3HfBY4HosSR0JvcAbuZID8Dlw92KKT1HyBk6HTWXPQRR0N/rY/iNBsOUPvAFvWvwRg5E/not0XMoxCLDU/oD0VZf6Rhm+B9zthV44NNnB1dkQxeI=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SEZPR03MB6618.apcprd03.prod.outlook.com (2603:1096:101:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 09:29:47 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::a0e1:17bd:db1c:f57b%6]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 09:29:47 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     =?utf-8?B?WGlhb3lvbmcgTHUgKOWNouWwj+WLhyk=?= 
        <Xiaoyong.Lu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?R2VvcmdlIFN1biAo5a2Z5p6XKQ==?= <George.Sun@mediatek.com>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/5] media: mediatek: vcodec: Fix h264 set lat buffer
 error
Thread-Topic: [PATCH 3/5] media: mediatek: vcodec: Fix h264 set lat buffer
 error
Thread-Index: AQHY9nsHD3oFxlP8WkWq38HWHyF+va4+SvmAgASWUoA=
Date:   Thu, 17 Nov 2022 09:29:46 +0000
Message-ID: <41b8bf48d4a672de483a8afff574642335c384b7.camel@mediatek.com>
References: <20221112094144.4256-1-yunfei.dong@mediatek.com>
         <20221112094144.4256-4-yunfei.dong@mediatek.com>
         <11a5fbb6-f462-bdc5-1592-32e8f2664a48@collabora.com>
In-Reply-To: <11a5fbb6-f462-bdc5-1592-32e8f2664a48@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SEZPR03MB6618:EE_
x-ms-office365-filtering-correlation-id: fa569fc8-5d54-4aea-2454-08dac87e449e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nAuVQTf1/6ib6bYtMB8APL7DjAXEnuZ8If85N+tLc98QJUw/QoYAVamKIQP/BeLR0z6PXRHTVFXJqdaFQHQdwaiyEFiSl5tySOKQFyuMcTbjqJN76U3E3gChgozHPA9Rp39HTZGfODbeEoXXBcwpA8Qn/Gg0NDARiri6lp7ktQZiEPsxtUumTi3k4fRCZh6r39/aZfIzzlky2MUHrPxL4hvSDdHSu1557G1NZq/gEdedLriivcUkD/WNyQEdkds4Ql5VLNTjiQw04LUaVN8WDRzwVYjDEj/E9v6BIOcnpnQ/4DOXyG7WZMiDIWa5kDWjbR50IN/bYg5ZN2MqBCr4O4/nL/aed64YpSrcmAjZx4iI3rcz8PxjKDidLyCeVagISYKFchxXq7wW+m7UgJWgU8EpnymLjY/hX9w36JacWuce17Dtkv/5cMK44+9N/GMhwi31bM/fnv5rzVmT7zT/QLYFVap9vY6dIj5uPC/YrOsNypn0Xqph8eaSrhqcHuo1dh63xbSKfsTAWv4A7D+8/wSd5uas2gLoBbHrU0hwYUwoVmMoL3Ek48eyacAC9UEM+YW0TgRFb0WkaQtay+KQJweaKeO1AhGbsp1zGVK25tDoRfLDAPOznO5f3ZmSqugMWH/2EqBARwXbwa3ZLYPrLvhGABeRs191+lwUB6gyeBE5+y3bDVb0Cljq4JzMbipdg7wUXVxopv0ODBKZirul0R6/RlfT/m1WuJMU2xBf/SI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(186003)(6486002)(2616005)(83380400001)(478600001)(5660300002)(85182001)(36756003)(6512007)(26005)(41300700001)(86362001)(38070700005)(6506007)(122000001)(71200400001)(38100700002)(4001150100001)(64756008)(66446008)(7416002)(66476007)(66556008)(8676002)(4326008)(66946007)(91956017)(8936002)(76116006)(54906003)(316002)(2906002)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzhXamtaWU1nQ0RFMy92YWg5V1dFajdtUnV0bWhxWGhNcVduVmIyc2p6N0ZO?=
 =?utf-8?B?RzljaWVkZUF6WEc0VDZVREoydzFGRHhGVnMzdGExeG43V21LVTNzWkJPL0JM?=
 =?utf-8?B?a3Y5UDdHWDlJRWdmQ3dxUERBT2wxMlMreStPMC80L0dDREVyL3dFNEVWejhi?=
 =?utf-8?B?MzRTVXZHWm1TVHE1MURGWUZxL05OamEweWJ4emhrcHRCbDMyVTRZY2xlL3RK?=
 =?utf-8?B?ZjYrVUREYXpVMnJxQTZCTkxRNWtoanV4eDRDQnZBaUtGeU5WNzdUb1BtY0pR?=
 =?utf-8?B?aHlEWjZPbGhvK1c2QzdMbFpyODNCNGpOd25Oei9nWEpOcDRXeWNiem1odnEw?=
 =?utf-8?B?VXhocHBoK2lWNHl0Y0F4MzRQU3RtZEZCNjdzMEFBUUdJMHBrS3FiOTR3Nmp3?=
 =?utf-8?B?QWRUV0RJQk51c0dkZHdLUjhTUjFqMGFJQ2huaEl3akV5RTllMWQ1K2ZJZG5n?=
 =?utf-8?B?encwYk1xemRIMFoxb21zQVM3QzRiemNCVWFRQXd0VjBvUE9IR0xwMEpsczNt?=
 =?utf-8?B?SzBSZFZBd2FJb3I3WG9SOHI0b3lIV3V0bUFvZ3U4VU1RVE1mZFdtMGNtQWgy?=
 =?utf-8?B?NFVVNHVINnVpZUpHUk9OaDB2N2l4bG9ZY0plbk8yeE1MOXJEanBOdnR6ZXJE?=
 =?utf-8?B?Qmh2bXljSVZYN2QrSkxRdElXOExjMHoxbGpSK2NJV0wrYlVGZXk1VkhpM1Fx?=
 =?utf-8?B?QS9pS2F1Q0JJcU9YQkFSbnNhYlFFUW5rSDQwR1VUTkNoYkRlOGhDVVBEV1Ji?=
 =?utf-8?B?NlZHOUs1VjlkY1Y2UFJwcFZ0QjdtV2JERGFYRUVDNDd2cUFLK0ptUlZZajNN?=
 =?utf-8?B?Z1E5Yysvb21XaHRrWDhVbW9vZklYQTQyVDIyUTFXMVc0NG1vT0RIN3pBdXJz?=
 =?utf-8?B?cUIyWDdxTnpQaUxYVm5YL04vWEI0WWdoNVk3VWdLR3M4cW1kdlVEcCtCelpI?=
 =?utf-8?B?SWVUNmd4dmhKaDFsYW03cTEzZGc0YTlGZG5HVERzOWdoTngycjVoTXZqV2ZB?=
 =?utf-8?B?Z1hXMTd1N0FrQlBseHg4UWZmREphZnNncXJnaE5vS2tUT3lzdjFYcW1KamZ3?=
 =?utf-8?B?MkxaY1FKUWFUNFIxZDZnVExrRE9VUmdMQm55ZDBBNCtBRkNHSUxNcU0rRSty?=
 =?utf-8?B?SS9nT1M2cnZNRVd5V3VkUFJGQkZJVXQvNEZRZ3VSbnByZGhpWldhU0FrWnVz?=
 =?utf-8?B?Y2MwampoQnB3VGpONWNnNWg2L0pzOGlsT1Z6bzJBS2xNNmN4T1AvN3M2Uzk3?=
 =?utf-8?B?eCtoQ3JsTGg4Si9IQS9xTFRnZ3Z2N3EzTHp2UWlsTEMyQWgyZFluQkwya1JO?=
 =?utf-8?B?VlNqTmdJdmhOZ2xvNVRKR3BFVU9qTnl0T0pLSTRDTVRSMDg3QVNIK1NYVko5?=
 =?utf-8?B?dmhSSjBNNXBwZEJwYUxuakl0NFd1bXM1RkhtQUZMeXNhOGFzSnliMVJOSzVI?=
 =?utf-8?B?OSt1b1RaRnhiN1ZISm8zNExiN0RJYnNWUWgxNzZjeG5Mb000VjA1eEJGek5U?=
 =?utf-8?B?ekdoVmVJR3BSOEkyenBseFF3YWdsK0lDbXpGbTJUN252VDlqcUNHNnkwOHhi?=
 =?utf-8?B?VTNrNWIxamgyOHpTWWdYR25icTBvM0dCMytITlZYL3E2a0dIL1lDaFkyNGFI?=
 =?utf-8?B?MlFZSnBsT3RjUmtxUnV1UFZoS2hDUjd6WUY5OG5ZeC9PWURDcGh2YXVqL096?=
 =?utf-8?B?S05CSFhwRmlCckxJTEtSY25NaVVyYjJlUXp6SXYwUiszNGFLMTY0Sk5ubEVZ?=
 =?utf-8?B?K1NyUXRJN0Y3dk9YN0N0MzgrVWNybldBUWhwWC9kLzhNZnhhSlFDNm9kSHpV?=
 =?utf-8?B?bjBvbnVjY29GU0FBTEYzVzJ5UjRZNEZXQU9hSnhjSEx4cFFqOGdTT2tXUTE0?=
 =?utf-8?B?K2ZFa3BtSnVsVXpYNU9CaVdXd0dmMXhsQzFRV2UzVHdTMHEvZUVvUUR1aWps?=
 =?utf-8?B?L25nZk1QVXFrTUx3MnFMOTk3YUNXVDVzaE9haXNlUU5vckNjTnFobWMzeFUx?=
 =?utf-8?B?ZCtrbmdoNGxJZ0tZR1pLZGVUTXdzQnNENmRGUEVQSzRWSHRvOGJCK21yY2pZ?=
 =?utf-8?B?dGRuUXBGMnQyTGJhTE5VVVM0YVdxQ3pSN1I4V3hDaHdWWGg1Sm1ZZzlZSnNp?=
 =?utf-8?B?TXBNT2JLVk14Znk4YzQ1amNYdGNtZ3phNlA3WVFvRDFoeFpLR2dLWlpUS0Fm?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA9C6C68D16F2E4A9B7A31C2C4A6A98B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa569fc8-5d54-4aea-2454-08dac87e449e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 09:29:46.8683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdYU500BOKWgShSdgbEnvyFw47DcG+apjTborouz7h+hX7YaVP7uc3MoB9wXellpyDnw5Vgxy4WhjQ1MU9pGFu1vf5jKtOhlNLQuqCsxq8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6618
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

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIGRldGFpbCBjb21tZW50cy4N
Cg0KQ2hhbmdlIHRoZSBkcml2ZXIgYWNjb3JkaW5nIHRvIHlvdXIgc3VnZ2VzdGlvbiBpbiB2Mi4N
Cg0KQmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCg0KT24gTW9uLCAyMDIyLTExLTE0IGF0IDEy
OjI2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMTIvMTEv
MjIgMTA6NDEsIFl1bmZlaSBEb25nIGhhIHNjcml0dG86DQo+ID4gV2lsbCBzZXQgbGF0IGJ1ZmZl
ciB0byBsYXRfbGlzdCB0d28gdGltZXMgd2hlbiBsYXQgZGVjb2RlIHRpbWVvdXQNCj4gPiBmb3IN
Cj4gPiBpbm5lciByYWNpbmcgbW9kZS4NCj4gPiANCj4gPiBJZiBjb3JlIHRocmVhZCBjYW4ndCBn
ZXQgZnJhbWUgYnVmZmVyLCBuZWVkIHRvIHJldHVybiBlcnJvciB2YWx1ZS4NCj4gPiANCj4gPiBG
aXhlczogNTlmYmE5ZWVkNWE3ICgibWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IHN1cHBvcnQgc3Rh
dGVsZXNzDQo+ID4gSC4yNjQgZGVjb2RpbmcgZm9yIG10ODE5MiIpDQo+ID4gU2lnbmVkLW9mZi1i
eTogWXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IC4uLi92Y29kZWMvdmRlYy92ZGVjX2gyNjRfcmVxX211bHRpX2lmLmMgICAgICB8IDIzICsrKysr
KysrKysrKw0KPiA+IC0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL3ZkZWMvdmRlY19oMjY0X3JlcV9tdWx0aV9p
DQo+ID4gZi5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy92
ZGVjL3ZkZWNfaDI2NF9yZXFfbXVsdGlfaQ0KPiA+IGYuYw0KPiA+IGluZGV4IDRjYzkyNzAwNjky
Yi4uMmI3NTc2MjY1ZjQ4IDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tZWRpYXRlay92Y29kZWMvdmRlYy92ZGVjX2gyNjRfcmVxX211bHRpX2kNCj4gPiBmLmMN
Cj4gPiArKysNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL3Zk
ZWMvdmRlY19oMjY0X3JlcV9tdWx0aV9pDQo+ID4gZi5jDQo+ID4gQEAgLTQ3MSw2ICs0NzEsMTIg
QEAgc3RhdGljIGludCB2ZGVjX2gyNjRfc2xpY2VfY29yZV9kZWNvZGUoc3RydWN0DQo+ID4gdmRl
Y19sYXRfYnVmICpsYXRfYnVmKQ0KPiA+ICAgCSAgICAgICBzaXplb2Yoc2hhcmVfaW5mby0+aDI2
NF9zbGljZV9wYXJhbXMpKTsNCj4gPiAgIA0KPiA+ICAgCWZiID0gY3R4LT5kZXYtPnZkZWNfcGRh
dGEtPmdldF9jYXBfYnVmZmVyKGN0eCk7DQo+ID4gKwlpZiAoIWZiKSB7DQo+ID4gKwkJZXJyID0g
LUVCVVNZOw0KPiA+ICsJCW10a192Y29kZWNfZXJyKGluc3QsICJmYiBidWZmZXIgaXMgTlVMTCIp
Ow0KPiA+ICsJCWdvdG8gdmRlY19kZWNfZW5kOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgIAl5X2Zi
X2RtYSA9IGZiID8gKHU2NClmYi0+YmFzZV95LmRtYV9hZGRyIDogMDsNCj4gDQo+IElmIHlvdSdy
ZSBqdW1waW5nIHRvIHZkZWNfZGVjX2VuZCwgdGhpcyBjaGVjayBiZWNvbWVzIHBvaW50bGVzcyBh
cw0KPiB5X2ZiX2RtYQ0KPiB3aWxsIG5ldmVyIGJlIHNldCB0byAwLCBzbyB5b3UgY2FuIHJlbW92
ZSB0aGUgY29uZGl0aW9uYWwgb24NCj4gYXNzaWduaW5nDQo+IHRoZSBkbWEgYWRkcmVzcyB0byBg
eV9mYl9kbWFgLg0KPiANCj4gU2FtZSBjb21tZW50IGEgZmV3IGxpbmVzIGxhdGVyIGZvciBgY19m
Yl9kbWFgLg0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KPiANCg==
