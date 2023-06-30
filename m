Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0979D743212
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 03:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjF3BCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 21:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjF3BCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 21:02:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5E6EC;
        Thu, 29 Jun 2023 18:02:43 -0700 (PDT)
X-UUID: cb54589016e111eeb20a276fd37b9834-20230630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mc66VViX9SRgpefsK+kqguOkVOBTRalEOEJgRSrVqG4=;
        b=ORJ79RQ6/TqDt2hq1rXbyq+YFbWpIE5qqQR+kuSyIRYa14EDKEaWa/AS7DG1I2aj2hXpRtrMNbaMWrAN4mr+bmMRgtfwQ/DQn8BsZho/5B0XaB6K9rwVYvc9cMLKIyzWJ6SoipX7w5xoqUELkKxdDe2m6gW1AFyi8B3ZC8nAFYs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:850cc360-0614-48d6-b92e-da88d17dd02f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:d88074da-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cb54589016e111eeb20a276fd37b9834-20230630
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2033139307; Fri, 30 Jun 2023 09:02:32 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 30 Jun 2023 09:02:31 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 30 Jun 2023 09:02:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0jLAWgWGjffwjW7WGzsOdfKKa8YGIbw9jjPfNe+DWV+5WFeabhjQ9QmPkqDTKBG41T+y1nsn0ULiTMkXZ4h2HOot/NIy6nHgNmLdTcKbPLn5hIAi5csDY2Ri7wrHag13eT8v/wRExH2PNVq0Q24ejWHYzxsKVnaR3arlOsOsQmiSQzJekXTPzgQ9wypRun59hYSkJ0cdP/Y1FKoLdDVPYG4xTWHQiWshrBxqppiZlQmUeVYObeRikaTyfbef+JrRjSXhOhZYQNB+WItqDevaMgcEqACEvKLUlFOFBvJEV3SBkg9mTrxtsaq41AtnXKMqGYvNxsPYf3eVi8vuQLVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mc66VViX9SRgpefsK+kqguOkVOBTRalEOEJgRSrVqG4=;
 b=hc/RGM0gOZUBWsz1tDwwVRuJs6KXPkw7QnDS+ko9jfjwcH/5O6dWbeuL3QxK80uE1Xt2IqSY7ZOLz0WvuokG3JTylHnn6DiDTTNaSLlEq1VMK/vKNAG9BTku857Z4Oq9HklqwMJ7lrRCXZSMIQUPwFtUslQTwEmNVxBFifA9IJQtaaAg8XDPuDRErJkIaehL91R9Omv1Ms8AQku0MOerQe3Z96Az8EWzmQiNUGjPvy0ts7j1WomaYJvVvcD53rcfkzC83VVn04uj4hWB3Hf6gMksidsgXuFjp6lMiFbMKEKC1hAkq1b3XeTwpYnV7Pg1pYHDIN2NOJcBpjjVO8q7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc66VViX9SRgpefsK+kqguOkVOBTRalEOEJgRSrVqG4=;
 b=DO1rfNU/BI9YGY/TRkUoiE+sCDSKO+0HQp11yALjCrYgNLWcWCB7ohfw3OMOaTDXgQ5lYcrQ1XFpcW8S+5yaJ4VcyHQLAd+ZucDmYPP4jEVH7Jm2JAWlSLEyDzov/SCI1zReq2UHWAGiE3GFlaz3pK5nztkd7ZMbrmZkTWqElI0=
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com (2603:1096:301:b4::11)
 by SEYPR03MB7507.apcprd03.prod.outlook.com (2603:1096:101:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 30 Jun
 2023 01:01:36 +0000
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::db8b:63d1:40ab:cb5e]) by PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::db8b:63d1:40ab:cb5e%5]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 01:01:35 +0000
From:   =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "kbingham@kernel.org" <kbingham@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] scripts/gdb: fix 'lx-lsmod' show the wrong size
Thread-Topic: [PATCH] scripts/gdb: fix 'lx-lsmod' show the wrong size
Thread-Index: AQHZo1xmwpM5k4kpiE2XQmDIwwaXNa+ilhyA
Date:   Fri, 30 Jun 2023 01:01:35 +0000
Message-ID: <956205d17a304364d1026db694d544cecfe28d50.camel@mediatek.com>
References: <20230620094834.14688-1-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20230620094834.14688-1-Kuan-Ying.Lee@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5964:EE_|SEYPR03MB7507:EE_
x-ms-office365-filtering-correlation-id: e06f2824-c5e0-41c6-13b9-08db79058d76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u4U5D01C5DhCSvDKZz3+PUWQ8OEGd2gDyyuOcdFT9PC0FnaSPUKxVEJtIj1uHfWfNXjwYGL7RS6AK6C5wiD9XfvXjqMxEBhsRgEMbOoL52UbNb0MfkuCOCu0pQfCTKUinJG8vV/uhPkUpsAtMcmL1lAvZnhCUDtvq1AxRU+jjYjm5pvUwbZrLktOlQeNvd33nVzqrW3IEPTYGFh6Gx7CE/GfuXUwyqF8rI0IdzDxikRWHnZ9kzSnypxlDM6ygS85BQmysN80uFIKm8NOYAcldVw9UzVWJUB3nzVcqupG8V06fwQ45WqINZXi4DjeGt5MYIoyY5cUPxX2sRQ7uemLfQQBPxDrlcnaRrDT3efoVGXeZW83cUiZ5TYNRWuGPfgqnJHs97w27KMAM4SSTNox53v20dQqYWbXfhxoiMmwmfZHERO0/bPDzx6ifoJNZLMdY3HWhXMCgonWkqCypXP8edLS720dFAmw9Qcwv3H9hRKG+GT2R/45yOlGgtX4FDB/AOAYXVShyT3qvPLyTZ12uUkqYQBL5RaiJLFCxNlgr2wl36680Gzjpy4rnWdMkxbUJCYRV/FQW+aQQX2KoQFNFTAotrt5k14KGkXh+Q6DjwHScOxZZHBOKYPhhUeUjXE3NaHp0u91Q18bbSKLLk+BLEpBEmiMIT7Y4j5/E7VWbV0ft4y5IUKEOL7JFn7WpYwv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5964.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(26005)(6512007)(2906002)(86362001)(6486002)(122000001)(38100700002)(83380400001)(71200400001)(2616005)(38070700005)(186003)(54906003)(110136005)(41300700001)(85182001)(4326008)(478600001)(36756003)(64756008)(66946007)(316002)(66446008)(66556008)(76116006)(91956017)(66476007)(7416002)(5660300002)(8936002)(8676002)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDdSU2w1UC9vQ1hrb2xEODE5SXpNcC94N0NpS0ZnWnYvUFkrWThqeVVMUkZz?=
 =?utf-8?B?NUY1QzhROEhkZkovY0Z2TXpNL3gweW11RXpEZFdON3hVcndBVjc5WG9ZMG5P?=
 =?utf-8?B?dEsrRlpHaFRoREtHZkphNUdFaSsyY1RwK2FCbStMb2s2eTJZeHc1ekdnVkJ1?=
 =?utf-8?B?c1NZUGNxUjhOSk1CL0JYWStnNjB3Smc4S1VDY2tFTEgvOTF0MHRpNnR3dThQ?=
 =?utf-8?B?ZXA0Q1RlZEZaQk85Y0dhWklIbWxDb0tlT1p4TDVSVlJacGdnV0NRbkVHa25x?=
 =?utf-8?B?c0FmTm9hc2JXR2FFT0YzMSt0MjZSUTlxM1dTSS9xdTRoU0lud01vUmRtaEhx?=
 =?utf-8?B?K0ZSYjhkOXl0RHpKUURWK1grVWtlMndNcXJ5NHpYM0RVcklqMmVuZ2JBQ1R0?=
 =?utf-8?B?b2p5WmJTUmxMZzVSNEVreG1qa0xMd1NiOVVvVE5xdlk5SGN5ZTYxK1d6Q2ll?=
 =?utf-8?B?cFQ3WGY4MXZtbWlkRkQwbG1TVjd5TXBwOGl1VTVobjhKdE1tVFRYdEhlZ3JG?=
 =?utf-8?B?VDJ5eFdQYk4rN1BVQnFTckdsSkZqZCt2RFQzUy9CeGZYK0RONnNPUWRKODBG?=
 =?utf-8?B?Wmh1QkVWMUdiZVhhaERQSUt3ZjZaeTRVbkF1UFNlYXZKT3BhRTlBbFFObyty?=
 =?utf-8?B?aDZubktaNHN3OU16S2VBajk3anFCYitGV2p5U1NlRzVIa3hzRjdSc0E5Y1Zu?=
 =?utf-8?B?MmE5K1lTQWRCRmZXNG05Y1hLRHVwdENFWjlVc24zeUpXZmdhMjNLY3pxMnl2?=
 =?utf-8?B?dFJZVVYwVitkb3EzczZZZm5uY3NFYzdKclB3Uk5WNlJ0MG5KSytMODZSY1V0?=
 =?utf-8?B?cFU0VVc1d2FjLzhueGd3VWszeStvczZHQzdTak9FNWpmN3lKUGNnTzArSUpZ?=
 =?utf-8?B?ck8zZjFNZUZXcHpkTlhvTnZuUlprNjc4Y09yTXFZSjUwS0NqSDhPam5yZ2xJ?=
 =?utf-8?B?S2JlbEl4N0RkR2FDcUZjVWtZQlVCdERYNkpEUmZnSVl5RndtV3ZDVlU3bFNr?=
 =?utf-8?B?VW1RRSt5NEdLMVcxNmc1Z3gwMFU4Wk9kQm1kbmtXbTh2MlNkQTIwQWVXbGZF?=
 =?utf-8?B?K2dZYVNHME1wN21GOVFlZ3dIOCtuRUFhUlhHdmU5QWs4YjBwWTNHYlVsamJC?=
 =?utf-8?B?NXgxU0Y0ZllybmNjdzhMNVNCM0hNbE5JOUlRSCtCWm5rdjB0Z2JFL1N0bjA3?=
 =?utf-8?B?R0NMZmx0a0F4dWxMcWpqT0pMRTE1ZENZYVJibktPTkdhbHRiamdNYzY4dU0x?=
 =?utf-8?B?YWhLM2JVdlIvREJicG9mU1FFZEttM2RiVDRxclZZVXA5aml1WVY2SEMrMDJX?=
 =?utf-8?B?SXBPRXlwQllvbnNXaXcyRm5jNzRLbmV1ajV1akovaUFMTmp3ZkxDRGo2Qysy?=
 =?utf-8?B?K2YvejNCYWdBRHQ4NnBzS2s2d0lZTUNYd0FkT1Njc3AvNjJoVjU2aDlMWUJn?=
 =?utf-8?B?a244R25vRm1BWmFIUndVWHlTOCtGaGdBUTdDRFJQYWdoRDBJbHNjb3dyZVFi?=
 =?utf-8?B?dzRVVUtYcE11WG5KM1VzSms2NmgvMVhidUk1eU94Qm0wWFNQdDFkM2tUb2Rj?=
 =?utf-8?B?WThLRmJ1ekRoeTJHNEJ3Ky9wL3dkb042YU5vamRKTUxGTGhmVTJkRUhIVUJ3?=
 =?utf-8?B?RVpTVkZMai9RdXRVUlppMGthaTY5MENCOWxJWkpOdTlobDlVQ3Y2dTB4MGFu?=
 =?utf-8?B?eHBCYytjVTRKN2R4dkwwQ29iblEwZ0hiVGhVcWtRQlFiRlNYT01FYjdIQTJ2?=
 =?utf-8?B?NlRETEVXajVQZHhIdXRTNlBEVEdybmNOOVhObWNEeUFKeXRudU1qMVkxam1U?=
 =?utf-8?B?V0dFbjZZMDgwZWVzeVdQUnZOL2RGVk1QRGc5YS9JY0RmMjRBYklGdWh6QjFm?=
 =?utf-8?B?MWtSSncrZU1VWk9JOWw1dTFueUkrbXhUVlIycVFyWG5zcVFyTGFkekU1cjEw?=
 =?utf-8?B?TkVPOG1JV1NCUUszSVJzQlhueUF0K0x6dFJJT0RTQWt3dlRnRzYreGcxdWwv?=
 =?utf-8?B?NGk2S2pjblE1ZlIrL29NNDArbUtJWnNwMWtKWXJJbVhadG1EWUk5bWI5M1ls?=
 =?utf-8?B?elFSUGlGQ3Z3L2pjMWthd1c5ek5Hd041SnlQQTlESTRSWUpWTG96dExYUk1h?=
 =?utf-8?B?b0V6S1M0dVQ3NmZLYjl6ekErU3ZpVXNJc0huZjMxYW9aSVJBdUphRkx2Nk11?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00F2F6307952224B9FD81DDAD32CBCB9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5964.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06f2824-c5e0-41c6-13b9-08db79058d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 01:01:35.8039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gj/XF0WPi18jHmEov/SNcZnE/EQ0R2VwJFD/pxYfsL0hgTfgFGVnUPy3qDYi1niSKDJ1iqm50tzTzlzny08eLBXqBjFV7xBotjhqgSdhofk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7507
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S2luZGx5IHBpbmcsIGFueSBjb21tZW50Pw0KDQpDYyBsaW51eC1tb2R1bGVzLg0KDQpUaGFua3Ms
DQpLdWFuLVlpbmcgTGVlDQoNCk9uIFR1ZSwgMjAyMy0wNi0yMCBhdCAxNzo0OCArMDgwMCwgS3Vh
bi1ZaW5nIExlZSB3cm90ZToNCj4gJ2xzbW9kJyBzaG93cyB0b3RhbCBjb3JlIGxheW91dCBzaXpl
LCBzbyB3ZSBuZWVkIHRvDQo+IHN1bSB1cCBhbGwgdGhlIHNlY3Rpb25zIGluIGNvcmUgbGF5b3V0
IGluIGdkYiBzY3JpcHRzLg0KPiANCj4gLyAjIGxzbW9kDQo+IGthc2FuX3Rlc3QgMjAwNzA0IDAg
LSBMaXZlIDB4ZmZmZjgwMDA3ZjY0MDAwMA0KPiANCj4gQmVmb3JlIHBhdGNoOg0KPiAoZ2RiKSBs
eC1sc21vZA0KPiBBZGRyZXNzICAgICAgICAgICAgTW9kdWxlICAgICAgICAgICAgICAgICAgU2l6
ZSAgVXNlZCBieQ0KPiAweGZmZmY4MDAwN2Y2NDAwMDAga2FzYW5fdGVzdCAgICAgICAgICAgICAz
Njg2NCAgMA0KPiANCj4gQWZ0ZXIgcGF0Y2g6DQo+IChnZGIpIGx4LWxzbW9kDQo+IEFkZHJlc3Mg
ICAgICAgICAgICBNb2R1bGUgICAgICAgICAgICAgICAgICBTaXplICBVc2VkIGJ5DQo+IDB4ZmZm
ZjgwMDA3ZjY0MDAwMCBrYXNhbl90ZXN0ICAgICAgICAgICAgMjAwNzA0ICAwDQo+IA0KPiBGaXhl
czogYjRhZmY3NTEzZGYzICgic2NyaXB0cy9nZGI6IHVzZSBtZW0gaW5zdGVhZCBvZiBjb3JlX2xh
eW91dCB0bw0KPiBnZXQgdGhlIG1vZHVsZSBhZGRyZXNzIikNCj4gU2lnbmVkLW9mZi1ieTogS3Vh
bi1ZaW5nIExlZSA8S3Vhbi1ZaW5nLkxlZUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgc2NyaXB0
cy9nZGIvbGludXgvY29uc3RhbnRzLnB5LmluIHwgIDMgKysrDQo+ICBzY3JpcHRzL2dkYi9saW51
eC9tb2R1bGVzLnB5ICAgICAgfCAxMiArKysrKysrKystLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9zY3Jp
cHRzL2dkYi9saW51eC9jb25zdGFudHMucHkuaW4NCj4gYi9zY3JpcHRzL2dkYi9saW51eC9jb25z
dGFudHMucHkuaW4NCj4gaW5kZXggNTBhOTJjNGU5OTg0Li5mYWI3NGNhOWRmNmYgMTAwNjQ0DQo+
IC0tLSBhL3NjcmlwdHMvZ2RiL2xpbnV4L2NvbnN0YW50cy5weS5pbg0KPiArKysgYi9zY3JpcHRz
L2dkYi9saW51eC9jb25zdGFudHMucHkuaW4NCj4gQEAgLTY0LDYgKzY0LDkgQEAgTFhfR0RCUEFS
U0VEKElSUV9ISURERU4pDQo+ICANCj4gIC8qIGxpbnV4L21vZHVsZS5oICovDQo+ICBMWF9HREJQ
QVJTRUQoTU9EX1RFWFQpDQo+ICtMWF9HREJQQVJTRUQoTU9EX0RBVEEpDQo+ICtMWF9HREJQQVJT
RUQoTU9EX1JPREFUQSkNCj4gK0xYX0dEQlBBUlNFRChNT0RfUk9fQUZURVJfSU5JVCkNCj4gIA0K
PiAgLyogbGludXgvbW91bnQuaCAqLw0KPiAgTFhfVkFMVUUoTU5UX05PU1VJRCkNCj4gZGlmZiAt
LWdpdCBhL3NjcmlwdHMvZ2RiL2xpbnV4L21vZHVsZXMucHkNCj4gYi9zY3JpcHRzL2dkYi9saW51
eC9tb2R1bGVzLnB5DQo+IGluZGV4IDI2MWYyODY0MGY0Yy4uODQ5MzNjNGMxMDgzIDEwMDY0NA0K
PiAtLS0gYS9zY3JpcHRzL2dkYi9saW51eC9tb2R1bGVzLnB5DQo+ICsrKyBiL3NjcmlwdHMvZ2Ri
L2xpbnV4L21vZHVsZXMucHkNCj4gQEAgLTczLDExICs3MywxNyBAQCBjbGFzcyBMeExzbW9kKGdk
Yi5Db21tYW5kKToNCj4gICAgICAgICAgICAgICAgICAiICAgICAgICAiIGlmIHV0aWxzLmdldF9s
b25nX3R5cGUoKS5zaXplb2YgPT0gOCBlbHNlDQo+ICIiKSkNCj4gIA0KPiAgICAgICAgICBmb3Ig
bW9kdWxlIGluIG1vZHVsZV9saXN0KCk6DQo+IC0gICAgICAgICAgICBsYXlvdXQgPSBtb2R1bGVb
J21lbSddW2NvbnN0YW50cy5MWF9NT0RfVEVYVF0NCj4gKyAgICAgICAgICAgIHRvdGFsX3NpemUg
PSAwDQo+ICsgICAgICAgICAgICBmb3IgaSBpbiByYW5nZShjb25zdGFudHMuTFhfTU9EX1RFWFQs
DQo+IGNvbnN0YW50cy5MWF9NT0RfUk9fQUZURVJfSU5JVCArIDEpOg0KPiArICAgICAgICAgICAg
ICAgIGxheW91dCA9IG1vZHVsZVsnbWVtJ11baV0NCj4gKyAgICAgICAgICAgICAgICBpZiBpID09
IGNvbnN0YW50cy5MWF9NT0RfVEVYVDoNCj4gKyAgICAgICAgICAgICAgICAgICAgdGV4dF9hZGRy
ID0gc3RyKGxheW91dFsnYmFzZSddKS5zcGxpdCgpWzBdDQo+ICsgICAgICAgICAgICAgICAgdG90
YWxfc2l6ZSArPSBsYXlvdXRbJ3NpemUnXQ0KPiArDQo+ICAgICAgICAgICAgICBnZGIud3JpdGUo
InthZGRyZXNzfSB7bmFtZTo8MTl9DQo+IHtzaXplOj44fSAge3JlZn0iLmZvcm1hdCgNCj4gLSAg
ICAgICAgICAgICAgICBhZGRyZXNzPXN0cihsYXlvdXRbJ2Jhc2UnXSkuc3BsaXQoKVswXSwNCj4g
KyAgICAgICAgICAgICAgICBhZGRyZXNzPXRleHRfYWRkciwNCj4gICAgICAgICAgICAgICAgICBu
YW1lPW1vZHVsZVsnbmFtZSddLnN0cmluZygpLA0KPiAtICAgICAgICAgICAgICAgIHNpemU9c3Ry
KGxheW91dFsnc2l6ZSddKSwNCj4gKyAgICAgICAgICAgICAgICBzaXplPXN0cih0b3RhbF9zaXpl
KSwNCj4gICAgICAgICAgICAgICAgICByZWY9c3RyKG1vZHVsZVsncmVmY250J11bJ2NvdW50ZXIn
XSAtIDEpKSkNCj4gIA0KPiAgICAgICAgICAgICAgdCA9IHNlbGYuX21vZHVsZV91c2VfdHlwZS5n
ZXRfdHlwZSgpLnBvaW50ZXIoKQ0KPiAtLSANCj4gMi4xOC4wDQo+IA0K
