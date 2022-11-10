Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA346238F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiKJBid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKJBi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:38:29 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FA2643D;
        Wed,  9 Nov 2022 17:38:28 -0800 (PST)
X-UUID: 301d8acb076b49cf96d4af7b2c4091a9-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+sZLoutOrEwPhw2vES6uBko7SL1jDCO7aaf5kisaFLU=;
        b=DRYdwWT9YGGl6rGQqfPsShjcaOJcjVv8ZlB1iLaPB96xhWeUpZHnKuMRKIwUfSwZ1HfPo5E7ZdKPsJgv4lXn8myVt2SFGDXqu85MrqxaekdjeeLSB1Zsf8mBvK8xV9G44qyC9OIPbQWjZE+coNDf+CPoX8k3LBhV6RFHVlM04qA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:fe370b1b-1abe-40bb-9361-eaa3eeeb8694,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:351ad585-088c-4756-8f76-577be701e693,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 301d8acb076b49cf96d4af7b2c4091a9-20221110
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1510433059; Thu, 10 Nov 2022 09:38:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 10 Nov 2022 09:38:23 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 10 Nov 2022 09:38:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+SD+naVKjkYA7Rt6g7s5N1AfL7/lqgcT12ySJwvWfMFHGw2PhrCzUuJsYNV9Fts1Vj2c/fvMUfr/eHU5+zY6D2v76fG+/7Boj9UqMY6vHdiE0qbVJIDLMm8QaJXF+69zUakbOZwR779nUSczVeRNloxJmVHImDIGgZXAHAzqoTZxrOxN4Jk9G10RdqaOC00xSacUwphMjdKAjKpxIVgTdmxU6X30sNWKSPzKFcUaRD2kS2LoOM1obpHqa7Y5C3i2GAFNgk8bIRbxrF0MlmrbVCq5DNpfXiCmaa01geRl/p7JfFikugJ1gfp9wo8gVod2A3jzpD+B8WLQIyzuKFfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sZLoutOrEwPhw2vES6uBko7SL1jDCO7aaf5kisaFLU=;
 b=dITcnmclSKdctbydrW7tATiyNYG98mAn7P+EOrAn8L9kplINKN9Sntf3r472/qeJnHKMGb6LUC0UozlDF3rwBveczjpGco7t0b0RnQKx1DI8e0tZo9Quo7X3pNjx0es37a8U6pDNfUWyWVj6/54ee0BKXfHRh+pE17BRApBZhsp3H24sXSWhLEEGkvBzyOqoHw3OmW4IZp1W0wwY2O89Ek3ibhAXh/ItcKhvq/w3rtu/MKRigrAajyujNGsNyvdg+sjBI1IYCPPfiEUEaL0aemFh7sDRcMH6Uv4dwnfvXRNH7HqhjMlJtMS9mPUdfxvj5gEWuyvm4gIsO1GzXFqAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sZLoutOrEwPhw2vES6uBko7SL1jDCO7aaf5kisaFLU=;
 b=sLDPnr9Wtf4pX/WS2kpduJXjCCuPqw1TlSDqBeRkaDlM9vl20UMn02xK/S9HBeqUzbo89NdF5PPqF2XzPDsERQcO59H68h/UdycGgSLn5BVWJILSZj/piVk2SOG59QXy21T3ByZWvsYVVXUAwMIivGwLk1ZJqt8LaK3q0csaIIU=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 PUZPR03MB7211.apcprd03.prod.outlook.com (2603:1096:301:11f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Thu, 10 Nov 2022 01:38:22 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::20e6:df39:3119:99a1]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::20e6:df39:3119:99a1%5]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 01:38:21 +0000
From:   =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To:     "jwboyer@kernel.org" <jwboyer@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
        =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?= 
        <Soul.Huang@mediatek.com>,
        =?utf-8?B?WU4gQ2hlbiAo6Zmz5b2l5a+nKQ==?= <YN.Chen@mediatek.com>,
        =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?= <posh.sun@mediatek.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?= <ch.yeh@mediatek.com>,
        =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?= 
        <robin.chiu@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] linux-firmware: update firmware for MT7921 WiFi device
Thread-Topic: [PATCH] linux-firmware: update firmware for MT7921 WiFi device
Thread-Index: AQHY9ERk0mqh+w9TgE2sToOV/5JSVq424HyAgACBM4A=
Date:   Thu, 10 Nov 2022 01:38:21 +0000
Message-ID: <923f3fe069c166019975bd04cfb7c0745984a6e4.camel@mediatek.com>
References: <607ebf77d1d100f358b9b2df54cf241dc52df6d6.1668001244.git.deren.wu@mediatek.com>
         <CA+5PVA75PEj3TSiE39yd7vVfY-iRopNba+gcbg0=6HTfvi+V7A@mail.gmail.com>
In-Reply-To: <CA+5PVA75PEj3TSiE39yd7vVfY-iRopNba+gcbg0=6HTfvi+V7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|PUZPR03MB7211:EE_
x-ms-office365-filtering-correlation-id: 6c45ed3f-8065-4362-7e25-08dac2bc4071
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WESPQL4jqiOhE0biMXr79HEd9pbhWUDClcZh32piuBOdeoGFD/RGnsNCGVWjlqSrbbG1lbM21572/k36fYKZegI2xtATqVUzBwO8OkhFGoega606AP/uyiQDsQXw/s+SGCKnNp27IRYl32QbhnjOa68piamafuRdvD+rv2LdUXJV/DLbPOHKNh2MEiwldEnlqZx6A1Vp6KMkEEUW4QtoBYLvXCztlody3HQ9vOyEqItA7jVc9jEdCAntG1o2lqNMvQNgI5l1i09TK9wNkjywy/Tlbx7EEu1m9ecWdSCYKi0mCTeW1RJ2nHnEK/Ye/p6k7ATr732XddDtcrbUN4mme+GLDJZfL/hZ73/sk5NDDUrx8qI3YaDKI5r2UOM8I6TA0VQqvahd1NtKpi88KKIGf0AqkRwxH8PBpDC9yJ+hNFxxEEHjPxEXOulwf+E/XfuocA/siZLibUGC5UrrrBSl9Lz43BGt6f5KLWZSyxZ8W+jqwEjmyGuC5mr4ETvLEUXw3K1GYLNznXPDKD0pQsxYVfWNN6DMiYFvot819wWWhzAqqe7uJogRe9YhFNOXcqJIwC8qdJkv7j4adn8e88UIYgHg48t9q1RDXnjNz7uHrL8TM8wpIL5bQ5CsHc1ll42dXJEk4eg6RAiUwbH4CnBwRLr4EXkhrVBhiee0n6xH2WmcZO/oTgJfevZznM8U6PM5gaHXl66h8qPzEDdM+vBZoHEBdGV+3o5SGiyB44pNburEeUoBEhKm62g9FsAgmgU+k2Uk0tcmUzgoaIm7y9IcVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(76116006)(4326008)(66446008)(66556008)(66946007)(64756008)(6486002)(66476007)(38100700002)(316002)(8676002)(6506007)(6916009)(83380400001)(54906003)(91956017)(53546011)(8936002)(122000001)(5660300002)(71200400001)(36756003)(2616005)(41300700001)(26005)(15650500001)(6512007)(478600001)(2906002)(86362001)(38070700005)(186003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K25aTVA3TEpoaTY0WkEwZEg3b3B2MnBtaXlSeVI5MXA1L2ZGKzFGZy9Tai9K?=
 =?utf-8?B?bU51NFN5Y2pMY0VTWFF3dXYreEVYQ3phbDBIZms0L2ZJeGFhNUZFS1dSUHpt?=
 =?utf-8?B?ZW1Td1pXNGdOZitBN24rVWxPK205UXBCMllib0pwdno4SmtxU1lnd2RHQ2hh?=
 =?utf-8?B?TzJhY0NQOGlxNzVtOXEzdUdtc1lWUGtmSkZJWCtwajJHOGFONC9rWWxsU093?=
 =?utf-8?B?VVlUcDBOZTRxYXVQbjFJSWlhU21lVW9RbE9Lb2xNVnNRNzdENDdvM2dJelR1?=
 =?utf-8?B?MmxvVk9HSFY1bnhPRmJvQnRZbkhHZEdnc3FUSzBTVmZSVERaMnc5OWNqQU05?=
 =?utf-8?B?dTRraWVYOER6c3JoY00xZUd2UGdTYlhVT1YzMnZURTNETkNiQ2VTbXFrY3RN?=
 =?utf-8?B?Qm82VDkwTXh2Q21YWWhhK2pRTHN3bnhVUEY1bjhWN3ZUTUVueGx5NXdsQ0FG?=
 =?utf-8?B?Y2NNMHBzOUV5VlgxcWVuMkhmbittMGl0N1RaMVRHWWxucEp0eFg4OTFDUngz?=
 =?utf-8?B?THRlSkdxZnJna3NBS1V2Y1VzY0JpYmc0VDI1L0FFaEtMclI3WWRuMGVLbW9D?=
 =?utf-8?B?VURidnBlVkRudGxXQlZVOCsyTDU0OXlsZ2tkeEZKTHdlM3NnNVRXVXdZZFJP?=
 =?utf-8?B?Wndhck0yMjI5bmJEMHp0cmk1WHlDR09kZjRiL3RZWHRJQWpsUzlaRDFlYjg3?=
 =?utf-8?B?QldodWJueEFKM2hxalFXdHFDb0loc0NxRWlXZUF5V2NabHRLcHJKaXRrYTFB?=
 =?utf-8?B?MzJtZEw5ZVpMamIyQXo3N05BSmZpMGVDOTl4N0tvcUtzeWRQRHVxK1o4eU1z?=
 =?utf-8?B?a1g1ckxpQ3dYbk5oN25oVS8yWXZkWGRqc2NjRXFhQzVvZ1BsT2EydFdhdlJZ?=
 =?utf-8?B?WHF6ODFuV3FicnQ1ZVBSMWVHT3ZCTWh5Zm5kejM4L2Zkd3RGaXJ5eTV6TWVL?=
 =?utf-8?B?VG9ZZnFaNGgxeitYTGdvcVl3TjhsSWdnYVFHdVpFc1AxYzhLRG5lekJxbDZq?=
 =?utf-8?B?M3Brcm5rSUlQc2Z3aU1heDFTa1VsYk5UVUZUVUtYMFBtbUZ4ZEhBZ2pCUnVY?=
 =?utf-8?B?MlY5N3UxV25ZMGRlVk1IcnBjbTJYQ2k5M1BJRTErOTJuSVJMZW5JM1M4YzJt?=
 =?utf-8?B?cHR3OHZpaVd1OGRUU1BacEZMVFdhQzVKeStlQ2ZKZEM2MEQzNHUvNjVYN1Bs?=
 =?utf-8?B?VFVab20wL3BDWHNtY2Q2NCtTZzNSN3MwSVJxL1o5OVBVcW92U2hEQ3lHZUp3?=
 =?utf-8?B?R0kzengwZmF2bXM4bEhjSFhRVkFOVUxSMmJUbG5uMzIwbk43S2JoNWNsdjRw?=
 =?utf-8?B?SGtRNDJuRDQxZURQekd5ZDlSUEZHQzNKRW9XbWp1UkZCUjEyUmUxMWMwUXF3?=
 =?utf-8?B?OFhyYWhJVDBqMTM3OFBha2FBR1RhS3VSQlhoclE5OUYzQ2x5ZWZwRFpZZDdj?=
 =?utf-8?B?MHZLT0I4a0dOdVJRK1IwYmNMN0kzdWZyck50UjRId3lEem4rd2tiYW9hUE8r?=
 =?utf-8?B?Z09mQ3JvS05QdXFsSlhxWHJMby90TVd2dCt2OEptZ3h2cnVVQU9PZDRjWkxM?=
 =?utf-8?B?ZFh5RFlpMTZBSURJSkxKeEJOUml6MTd2K05SVE9ZaWw2MDlnMUVGTzk2THM4?=
 =?utf-8?B?WkNndHdKWk8zUi9wY0ZhMWswNmxGczBOOVI3bVhoSTZ2UjIrcnJlb1lhRFda?=
 =?utf-8?B?V2JocE5BWnZab0ZjMzFnQnMzb2xBSDVNbGErNU1WTDRzT3VTM09PL1JNZFIw?=
 =?utf-8?B?MEVjd0sraG5PVWNCSHRsTFpXMmVHUDUzd3p2N2tlRmdzelMyQUV3aVdQb0Zm?=
 =?utf-8?B?MjRweEJUcC9DVGh4NGNUUGZsdWxsZGRpS0ZGZ014dHhjbDFnQVhvYkEzUzRK?=
 =?utf-8?B?eE5UM3NpL1BrZHYrN1BVc0Q0UDdKTHdYZ0p2Szc4Nk1QSm9LdTNCRjVFNDNF?=
 =?utf-8?B?WVlndFNZczExcDNaa3hHYXZ5OTBCNm1EOUNQL2FZZVd2d0RlK0dFWU5VOTJU?=
 =?utf-8?B?bStpN21UMTNaQThiR3cxQ2RhWUxxNkludXVMOXkxaU0wMmoxemtJcmMxZnZU?=
 =?utf-8?B?dU5PV3lqRFVNVnNtME04d21pbkJpdCtxQktIM3hGNlFLRjc0RFdHM05CVjcr?=
 =?utf-8?B?NTJlNWhZTzh2NjhlblpueExLTFF6M2hEOUd0eHQ1VUdCQmN5UXlldlF1VDVO?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8FBF5E120649A499AA1CAC00742993B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c45ed3f-8065-4362-7e25-08dac2bc4071
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 01:38:21.6697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8M3bNmGvoFogITDpb2ebAHYeCUM/LJm4bNix33pIn7qDz8/2is2Whswy7Y73bJ2SFUC8QOfNl4cjKIpvjBVT6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9zaCwNCg0KT24gV2VkLCAyMDIyLTExLTA5IGF0IDEyOjU1IC0wNTAwLCBKb3NoIEJveWVy
IHdyb3RlOg0KPiBPbiBXZWQsIE5vdiA5LCAyMDIyIGF0IDk6MDcgQU0gRGVyZW4gV3UgPERlcmVu
Lld1QG1lZGlhdGVrLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogRGVyZW4gV3UgPGRl
cmVuLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBVcGRhdGUgYmluYXJ5IGZpcm13YXJlIGZv
ciBNVDc5MjEgV2lGaSBkZXZpY2VzDQo+ID4gDQo+ID4gRmlsZTogbWVkaWF0ZWsvV0lGSV9NVDc5
NjFfcGF0Y2hfbWN1XzFfMl9oZHIuYmluDQo+ID4gVmVyc2lvbjogMjAyMjExMDkxMTA5MThhDQo+
ID4gRmlsZTogbWVkaWF0ZWsvV0lGSV9SQU1fQ09ERV9NVDc5NjFfMS5iaW4NCj4gPiBWZXJzaW9u
OiAyMDIyMTEwOTExMTAwNQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERlcmVuIFd1IDxkZXJl
bi53dUBtZWRpYXRlay5jb20+DQo+IA0KPiBUaGlzIGRvZXNuJ3QgYXBwbHkuICBZb3Ugc2VudDoN
Cj4gDQo+IGNvbW1pdCA5NDkwZThhYzkyMjhiZDY3MGZmMGRkNTNjZTJhNDVmMTc3NjQzZmZiDQo+
IEF1dGhvcjogRGVyZW4gV3UgPGRlcmVuLnd1QG1lZGlhdGVrLmNvbT4NCj4gRGF0ZTogICBUdWUg
U2VwIDIwIDEzOjU5OjMwIDIwMjIgKzA4MDANCj4gDQo+ICAgICBsaW51eC1maXJtd2FyZTogdXBk
YXRlIGZpcm13YXJlIGZvciBNVDc5MjEgV2lGaSBkZXZpY2UNCj4gDQo+ICAgICBVcGRhdGUgYmlu
YXJ5IGZpcm13YXJlIGZvciBNVDc5MjEgV2lGaSBkZXZpY2VzDQo+IA0KPiAgICAgRmlsZTogbWVk
aWF0ZWsvV0lGSV9NVDc5NjFfcGF0Y2hfbWN1XzFfMl9oZHIuYmluDQo+ICAgICBWZXJzaW9uOiAy
MDIyMDkwODIxMDkxOWENCj4gICAgIEZpbGU6IG1lZGlhdGVrL1dJRklfUkFNX0NPREVfTVQ3OTYx
XzEuYmluDQo+ICAgICBWZXJzaW9uOiAyMDIyMDkwODIxMTAyMQ0KPiANCj4gICAgIFNpZ25lZC1v
ZmYtYnk6IERlcmVuIFd1IDxkZXJlbi53dUBtZWRpYXRlay5jb20+DQo+ICAgICBTaWduZWQtb2Zm
LWJ5OiBKb3NoIEJveWVyIDxqd2JveWVyQGtlcm5lbC5vcmc+DQo+IA0KPiB3aGljaCB1cGRhdGVk
IHRoZSBzYW1lIGZpcm13YXJlIHRvIHZlcnNpb25zIG5ld2VyIHRoYW4gd2hhdCB5b3UgYmFzZWQN
Cj4geW91ciBwYXRjaCBhZ2FpbnN0Lg0KPiANCj4gam9zaA0KDQpUaGFua3MgZm9yIGNoZWNrLiBJ
IHdpbGwgcG9zdCBhIG5ldyBvbmUgdG8gdXBkYXRlLg0KDQpSZWdhcmRzLA0KRGVyZW4NCg0KDQo+
IA0KPiA+IC0tLQ0KPiA+ICBXSEVOQ0UgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDQgKystLQ0KPiA+ICBtZWRpYXRlay9XSUZJX01UNzk2MV9wYXRjaF9tY3VfMV8yX2hk
ci5iaW4gfCBCaW4gOTIxOTIgLT4gOTIxOTINCj4gPiBieXRlcw0KPiA+ICBtZWRpYXRlay9XSUZJ
X1JBTV9DT0RFX01UNzk2MV8xLmJpbiAgICAgICAgfCBCaW4gNjg5ODY0IC0+IDcxODc3Mg0KPiA+
IGJ5dGVzDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9XSEVOQ0UgYi9XSEVOQ0UNCj4gPiBpbmRleCBl
MGUwZGFkLi5jOWJhMmRkIDEwMDY0NA0KPiA+IC0tLSBhL1dIRU5DRQ0KPiA+ICsrKyBiL1dIRU5D
RQ0KPiA+IEBAIC01MjIyLDkgKzUyMjIsOSBAQCBMaWNlbmNlOiBSZWRpc3RyaWJ1dGFibGUuIFNl
ZQ0KPiA+IExJQ0VOQ0UubWVkaWF0ZWsgZm9yIGRldGFpbHMuDQo+ID4gIERyaXZlcjogbXQ3OTIx
IC0gTWVkaWFUZWsgTVQ3OTIxIFdpcmVsZXNzIE1BQ3MNCj4gPiANCj4gPiAgRmlsZTogbWVkaWF0
ZWsvV0lGSV9NVDc5NjFfcGF0Y2hfbWN1XzFfMl9oZHIuYmluDQo+ID4gLVZlcnNpb246IDIwMjEx
MDE0MTUwODM4YQ0KPiA+ICtWZXJzaW9uOiAyMDIyMTEwOTExMDkxOGENCj4gPiAgRmlsZTogbWVk
aWF0ZWsvV0lGSV9SQU1fQ09ERV9NVDc5NjFfMS5iaW4NCj4gPiAtVmVyc2lvbjogMjAyMTEwMTQx
NTA5MjINCj4gPiArVmVyc2lvbjogMjAyMjExMDkxMTEwMDUNCj4gPiANCj4gPiAgTGljZW5jZTog
UmVkaXN0cmlidXRhYmxlLiBTZWUgTElDRU5DRS5tZWRpYXRlayBmb3IgZGV0YWlscy4NCj4gPiAN
Cj4gDQo+IA0K
