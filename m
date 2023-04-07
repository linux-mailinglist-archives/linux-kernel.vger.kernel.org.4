Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3656DA9A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 09:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjDGH7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 03:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDGH7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:59:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE4772A6;
        Fri,  7 Apr 2023 00:59:44 -0700 (PDT)
X-UUID: 24091a66d51a11eda9a90f0bb45854f4-20230407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6XTHSFz9Csk/WWBN8g+L5eoT+SkcV5NqHbLAmZpHMe8=;
        b=c1ATrrATT/mGoYt5ktBiTS249Uk+A8ZgERjHSN0v3JN6h86u97evWRlZXnUmFlY19vzhhOZ2VDm0li3ZfYCrh2rnUBiPXyAi8Vu133/gPLcfvG81toOq3VlzBRLFGjOZ+24V5GzgX8f7nnZJ3XIPfAN6LgOFBSVXEuKLtwvc8Io=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:de911ed2-cf4a-42a2-981c-437fab4c4bf5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:de911ed2-cf4a-42a2-981c-437fab4c4bf5,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:e81e9f2a-564d-42d9-9875-7c868ee415ec,B
        ulkID:23040715245364FBV1FL,BulkQuantity:10,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 24091a66d51a11eda9a90f0bb45854f4-20230407
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 903000857; Fri, 07 Apr 2023 15:59:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 7 Apr 2023 15:59:35 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 7 Apr 2023 15:59:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2nub7SbB7mIATf6hKXzNaKSeVVtNWCL86osOk9wpAxMBZomq6IH6K2Tg7+0NPjkpe0vVkxdt1wSyqnPvVux5wO0JuVzASAaBKG0byPkk9kIDuQ+BSYceOm3rGZ92zcAwaLdlpKc4/0irrrOWR0ySHFDfuZrCNxhJlvRkUCwJ6M3X87gScA7KWsW+r+T1cecvzgdM/OBoBi9uszj+qfPcwWO360fzUmopwCTdc82iNVe7ZWTS230FarmgRqUp/JY2mUJWOHr/1v0EvVjZjjGn5LW3keHNY2Z/gTCc8QAQSJgfq6qpzzeCbmin/FawPdCF+C6EludE4xclQzKFgDhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XTHSFz9Csk/WWBN8g+L5eoT+SkcV5NqHbLAmZpHMe8=;
 b=ZIHnGRzUOfrVcfy6hLQu3kK2EgMu+twvbeuHejUW94MPTHzlSAt/xeNK+BFpbhmBsW8I4kQ+1GzC3SbQy2JazR0gb8uK1seWmCp0hTqahN+iy21AM0/B0IJ/9SiuhDYWaZiPGOQxYae2MoTAjUMWPyaQs/N24KJYiWQzkwPWMby+/SscCBdtWUiMngZL9z6eJ4rX+Nb7xNfDKeEDFMGaO8AdSvPYroSlyFjW0mGtJLwBC6p/bxzgIQ0IZbQuP9OpipvfIwtQmn0b3KVQkez1yEt1EshaPCwU7D9TIoKQoSHqVMFHFdiJO7CzmdBKKzEoTmufZP5devaPj5n3+B5QFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XTHSFz9Csk/WWBN8g+L5eoT+SkcV5NqHbLAmZpHMe8=;
 b=bbHdeVCqd1fvziNuJioV8xSFcKIFgk1SZBsqyFXr+FKxJ9oLwKhHHqz/FESBEA7c1QQrT8R1F3/OsTkqeS56YwCdK9c8TS5V4IaoT9oISMKvg+Y8EsPvmOshY7/X3Th9g1YmxZWHDJcUwNlZvxluKoFlQVFYmPbmh1WF55NYP4U=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by SEYPR03MB6697.apcprd03.prod.outlook.com (2603:1096:101:80::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Fri, 7 Apr
 2023 07:59:33 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::82b9:eab9:b4e3:8464]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::82b9:eab9:b4e3:8464%7]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 07:59:33 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        =?utf-8?B?VGlhbnBpbmcgRmFuZyAo5pa55aSp5bmzKQ==?= 
        <Tianping.Fang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/7] usb: mtu3: fix KE at qmu transfer done irq handler
Thread-Topic: [PATCH 3/7] usb: mtu3: fix KE at qmu transfer done irq handler
Thread-Index: AQHZZddlqnrTfT7dSkenJLmKao1R8a8ZhMQAgAX9UYA=
Date:   Fri, 7 Apr 2023 07:59:32 +0000
Message-ID: <40ed6eb5c664b624e85576f957625a61d9615530.camel@mediatek.com>
References: <20230403025230.25035-1-chunfeng.yun@mediatek.com>
         <20230403025230.25035-3-chunfeng.yun@mediatek.com>
         <1cfde490-40a4-c83b-3bd5-c9baeba5187d@collabora.com>
In-Reply-To: <1cfde490-40a4-c83b-3bd5-c9baeba5187d@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|SEYPR03MB6697:EE_
x-ms-office365-filtering-correlation-id: b15e60f6-c387-4288-4b1b-08db373e05eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u1pHxuQEx6PBqeg6bjcQuSDp3cdmJSc9398k74gOaB2H/aVZT8YKiJOQkzvPx23CgnCsfG1aB0G8XjLUTJEgUzQg/ECg62k+9b7Ywm/oAIRn1bsLrgdBz9+RM++ncqHp7kj/ZqA0kRlnZQ/BSIhsbseVsq5GOHTXhwh0x1eBjb5D11sHVju834gM668plg6kwhQY9uelvn52+4MPVG3Fm7uLJIsbt2cXScZZx1pSkcG0bSrMfruOzTqD0pF0bYZbE0O3mRZYfZzMwRXm6xiZrtxi/0oYSaWDSS3QwoJj2yMCdWME919cE7RxtVBRnoY3bskOQ2+xPsgz/WjbnKIr5faISokMdTviFzsPR0e9LPFulvsYz1VH9B/3gEEoxxz0TQ/yofkr2lTZR9K6dfxuhQqxgfQUgmqCFkk2DaWcqG+VOq4zCmmKDsOxybtwBLi4tYEeRUo5Qohz5kDKF6Fo3DOWS+CtLC+PhFDCbvNVZnRugMPAD9Z7Qu5hNyL+DaR+kAVM+WpyiCp3oBuBwVfoR4xHmhFueQXQ7cwYl/axX8VPjLYqIeMNPH2YEztPXYHwFVkS+pHKgAX1XChrcqNEz0Qu9/l9pzer/hfpxTklGJvcUU3rbdxhy58uQem3ETsSrxSgYQI7aK1+3vd2Ubu3fu+UsjZ3CQQ1W7HZyWIHhjxsP1HjyL3+CO+DPn7n+XYM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199021)(122000001)(38100700002)(36756003)(86362001)(85182001)(38070700005)(83380400001)(8936002)(71200400001)(6486002)(478600001)(110136005)(7416002)(91956017)(316002)(5660300002)(26005)(2906002)(2616005)(186003)(6506007)(6512007)(76116006)(66446008)(64756008)(8676002)(66946007)(54906003)(66476007)(66556008)(41300700001)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjBaZGtwb2E0aGZBV1N4QktGQUM2SWJEcXNBYm5tQkRsemthVDVmTXBHV0x5?=
 =?utf-8?B?UzhKOVkxejUxa0xvTjNKQ2dndmxvWHNNcW9PcWFnV3RVdHRnQ1RrcmNqOWxs?=
 =?utf-8?B?ZVJKL09JdFVFWnZXOHdKQVNWdmpDck9NRzVBcnp0UWpLTWY0OU1HeTh4dnY5?=
 =?utf-8?B?RDFLdWNZZkxsbDJRM1pvSlNRaWFYeU1XTU8xOFNMcEkybGJ4Mm1tdkRZN2cz?=
 =?utf-8?B?RU5ZajlRK2svQ3VWOFdLb2RVYU8zank3T1dtRVRzTjJxMlFFUkRwVjBkNGt3?=
 =?utf-8?B?aVBrYktUWVhnUXBjNlA4TmdCdURqN3lkdFhoZERsbzFGNnlVVjhFWmZGSDk0?=
 =?utf-8?B?NGtFWUVkWWpJZGRKeHBoaFg5NWJOZitYWmtQNkMyY1VqTm1CaTJWdTFuZzFF?=
 =?utf-8?B?emdPV2pXczc1Z1R0ak5iQzlYbGFGQkpDMzcrZDNtV29xcENEeEJJcWtoWElD?=
 =?utf-8?B?eE1samY1YWZsUzQ4UTlqYk1HUEdTTUFzRTBjcUE2bVZ2R09WSC91cTdJVkR6?=
 =?utf-8?B?UE1wQlJZd1BjMEZ4MnNFWmc4d0lpWXc3SGlGbFdSRGwrWGJ3c1QwMWc1T2Zs?=
 =?utf-8?B?T1hWd285YjFHMGgraExrZEN1VUFZL0JNWWo4OTQyUlhQRFYybGlQZDBESnhr?=
 =?utf-8?B?UGlmL0pjejlucTluQUwyc1UyUFpwV04yZGthRW9leUduS0pqSFA0Nlc2UTNS?=
 =?utf-8?B?ZllUMVJVZ3pJOTNrRnRhbVVvY0V0Z3pFOUhiQ0svSFRBa1pBUkRVMzdmalVC?=
 =?utf-8?B?b21KUEk2bjFpSVNsaHdpU3h1SG5FL3pOSnRPY240cTVuNm1yeFdkYVlkazhL?=
 =?utf-8?B?Smg5VjBCNGNBdHp6QTMxQnZTNzVQMytnZDRpNGN0L0pWdnpjRlVvRHVzdTZW?=
 =?utf-8?B?cVYxK3hsaHpNUzZLdEVIb0w3bkVCUEdjMWpBUWtHV1F4MzdsVXltWFdMTU45?=
 =?utf-8?B?S0pSYjRMY0FIYTloSWlSRC83VjQ0WC9IQ01ycGd3ODNwVFh0OTRnNExxR2RI?=
 =?utf-8?B?YnJRNEw0TVpsMTBOWkJaQ3Yrc2s0NjA3REFRMEVVWjhkQjQyV0NjWmlNbVAw?=
 =?utf-8?B?aE5xc1NaUW9NM3U3ZmtUaXp6amVwczFOYzVHdkd3ZlYxQ0R4UEYrTWVBODdp?=
 =?utf-8?B?MlVSbnRvanNLUXdRNEhIVHNDd1ZSMGpHcUttQ0thb1hvVWRxd3R6TVJxcHgr?=
 =?utf-8?B?d1I2ckJZNGxaRy9aQ0xLdzhVWFUzL01XSVhQZlNzSnVSVHhyT1htb0tVUTll?=
 =?utf-8?B?MDZaNm1ISEdjaDlpSzdUZnlNZzRmYU8xY21qWjhEVVViVjNjWmtkbitjVWg2?=
 =?utf-8?B?ZHREK1FCNU9lQUJsTldTT2gzV3dlc0dTMVQzRmhqT1AwbjFFRVFiSmpKL1Mw?=
 =?utf-8?B?dnhqWWRaY1B4aDhiZ0IvT2xQNy85Ym1JVld4WlQ1Mkg2aXQrZDF1REd2NjNk?=
 =?utf-8?B?UzNEenBTWVRpUDIzODE3NENhSi91Ujk1RlZIb1BkREtUUUh6cklwUlRtcUE4?=
 =?utf-8?B?MzJOUGhmZzk3SXJlZC9zWFROZ0E2WmFUK3Q5bjVjTWZ5QjVLckhobWV6V2JG?=
 =?utf-8?B?UEdiblJvNm5hdXFtVGxZNks0VWlEeFBxSDFJVE9XcFFUdFlHc2crZ0lFMHFD?=
 =?utf-8?B?aytEMDF2c2hPZVZxMjVZQmJERWRTYW1zNnBtWXBtZkl3RU5UMHNaTjllR09r?=
 =?utf-8?B?cjZpdmdxbGt5R25yNHNXNkxuMndYUVdSdW1yaGRDa0ZCQXdkYXlDbllIRk5x?=
 =?utf-8?B?S01oTEdBVkcvR1pITHpjSXNwcHFnTGZmYjRCcTlBZDRkSWtyZEJNaUE4ZlNN?=
 =?utf-8?B?ditpVmlDL0RjSHBHVXkxdk5CL3graXBUWGdmWFpoNzM2OXk3M0dHV20xazJV?=
 =?utf-8?B?dTd3S2tYSFNoS2pYcXREZXVaU0l0eEtZOHdaZGs2Lzl1RlBPbFVENE9LRXB1?=
 =?utf-8?B?TjcveVdOeERPT29XY2ZoZnJMMzVjcUxwelgvMlprR3A2Mml5eXg2MERLL2Zm?=
 =?utf-8?B?ZnJtSWtpQ3NPTmsrUFNHTHR4aW1WcHlxL2JxclJWK29rWXlRZGtaQjlKR3dl?=
 =?utf-8?B?a2ZiMXBZRHo5c0V0c2pWVy9DeTFFcWIwVWd2ODZ2dmNETEd6c0RmV0Rpc3A1?=
 =?utf-8?B?NE9nUWtYT0ZxMXBvM3BwNEhKd09DQzRQbEhNUEFYMWhYS1BjeFQrbGlFM2tB?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7F957F8B37F4B41AD77E7E2830B9CE7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15e60f6-c387-4288-4b1b-08db373e05eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 07:59:32.9534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qgsKnApf299nVW8iB9hpOd/yJhSA2PfVMRmlsgMF8N0sQzzc8+agXeXYH0DLa0RwRs03vtsqqpMjXdZ24Ps0++rl5EVVoblFaA2NhVYdl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6697
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDE0OjMxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwMy8wNC8yMyAwNDo1MiwgQ2h1bmZlbmcg
WXVuIGhhIHNjcml0dG86DQo+ID4gV2hlbiBoYW5kbGUgcW11IHRyYW5zZmVyIGlycSwgaXQgd2ls
bCB1bmxvY2sgQG10dS0+bG9jayBiZWZvcmUgZ2l2ZQ0KPiA+IGJhY2sNCj4gPiByZXF1ZXN0LCBp
ZiBhbm90aGVyIHRocmVhZCBoYW5sZGUgZGlzY29ubmVjdCBldmVudCBhdCB0aGUgc2FtZQ0KPiA+
IHRpbWUsIGFuZA0KPiA+IHRyeSB0byBkaXNhYmxlIGVwLCBpdCBtYXkgbG9jayBAbXR1LT5sb2Nr
IGFuZCBmcmVlIHFtdSByaW5nLCB0aGVuDQo+ID4gcW11DQo+ID4gaXJxIGhhbmxkZXIgbWF5IGdl
dCBhIE5VTEwgZ3BkLCBhdm9pZCB0aGUgS0UgYnkgY2hlY2tpbmcgZ3BkJ3MNCj4gPiB2YWx1ZSBi
ZWZvcmUNCj4gDQo+IEtFID09IEtlcm5lbCBFcnJvcj8gSSB0aGluayB5b3Ugd2FudGVkIHRvIHNh
eSBLUCA9PSBLZXJuZWwgUGFuaWMNCj4gaW5zdGVhZC4NCj4gDQo+IEFsc28sIHMvaGFubGRlci9o
YW5kbGVyL2cuDQpPaywgd2lsbCBtb2RpZnkgaXQNCj4gDQo+ID4gaGFuZGxpbmcgaXQuDQo+ID4g
DQo+ID4gZS5nLg0KPiA+IHFtdSBkb25lIGlycSBvbiBjcHUwICAgICAgICAgICAgICAgICB0aHJl
YWQgcnVubmluZyBvbiBjcHUxDQo+ID4gDQo+ID4gcW11X2RvbmVfdHgoKQ0KPiA+ICAgIGhhbmRs
ZSBncGQgWzBdDQo+ID4gICAgICBtdHUzX3JlcXVfY29tcGxldGUoKSAgICAgICAgbXR1M19nYWRn
ZXRfZXBfZGlzYWJsZSgpDQo+ID4gICAgICAgIHVubG9jayBAbXR1LT5sb2NrDQo+ID4gICAgICAg
ICAgZ2l2ZSBiYWNrIHJlcXVlc3QgICAgICAgICBsb2NrIEBtdHUtPmxvY2sNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXR1M19lcF9kaXNhYmxlKCkNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtdHUzX2dwZF9yaW5nX2ZyZWUoKQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVubG9jayBAbXR1LT5sb2Nr
DQo+ID4gICAgICAgIGxvY2sgQG10dS0+bG9jaw0KPiA+ICAgICAgZ2V0IG5leHQgZ3BkIFsxXQ0K
PiA+IA0KPiA+IFsxXTogZ290byBbMF0gdG8gaGFuZGxlIG5leHQgZ3BkLCBhbmQgbmV4dCBncGQg
bWF5IGJlIE5VTEwuDQo+IA0KPiAgPg0KPiAgPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4g
PGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+IA0KPiBUaGlzIGlzIGEgZml4IGFuZCBuZWVk
cyBhIEZpeGVzIHRhZy4NCkkgdXN1YWxseSBhZGQgRml4ZXMgdGFnIHdoZW4gdGhlIGlzc3VlIGlu
dHJvZHVjZWQgYnkgYSBwYXRjaCBleGNlcHQgdGhlDQpvcmlnaW5hbCBvbmUgd2hlbiB0aGUgZHJp
dmVyIGFwcGxpZWQuDQoNClRoYW5rcyBhIGxvdA0KDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8N
Cj4gDQo+IA0K
