Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B4D7258AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbjFGIxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239533AbjFGIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:53:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFF02128;
        Wed,  7 Jun 2023 01:51:37 -0700 (PDT)
X-UUID: 5e4d3e2a051011eeb20a276fd37b9834-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MrrAaLgEQLYh4DXZcbfcFB2yDXzxqatDaQ3k+6nYSI0=;
        b=Yx6gjv35NGP4x08lCbdbeNe3fNI0BgfIOc92+JRSvVG7g20ZarumO4qzFu8kPia+pPDOa1FCPBUBbf22Pven6C6D5YGBD/Pgk396xq0nzn4Ulls22elbtQw1+RECkN4RtuJOg+dVEwxRnlOL3uDtI4IwXBxA82ZCmeMwBfXtcZk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:ec36a47f-da6d-4947-94c4-2874f98f8a03,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:a99dd93d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 5e4d3e2a051011eeb20a276fd37b9834-20230607
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2105586098; Wed, 07 Jun 2023 16:50:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 16:50:34 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 16:50:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW7jQ04ry1PHJh0NGnwDK9mtqe4nmCHiZxxUvr4jNkurwM1w2+tADfjC/x416ab/fuWE2a4dfNczWe1ol33TC2Uv7IHSgLNYucUowsBkD8A6BtuKzoG5y2Us2rqkTa0IQUjR4bVWGnILkwlcMjY2Zw5nXPY1Dm3eiMG1pQjdA7+Yf16EQVSPf03OBHwIyMfKoAhEOEUnMh2vNKQZ2QqqJuIf27kI6CE4QiaoIME2hkGYwtk/kBWAfb/dSM6XmWq3JP5o7GwFXtorxtuyPbVr8kLdNKoIJEkMI3qsWYIbNztRxWZcCAo0mRmCf9LlDZnG+o/VsGo6NWlP6sESdw7Wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrrAaLgEQLYh4DXZcbfcFB2yDXzxqatDaQ3k+6nYSI0=;
 b=PtYP7Ib5Dm3XKMqd/zXTRjyEbpI0Z9FDDPI679U7CbD9CacuEc0L43jGu+fLQuskf89OKnDFbS2sRuZMhRiKjV3KSRGJOymxSDljrlvZ3uA+26yDsdvDzv9W4s/mxz8DwTb2GVkbP/3UvYHc4Z0qwnoLjKGezKbEG7aQgcTfiWU0paCoBBJOVtI3Io77FJGKycD4VixDAjw/UJTY16XxN5x3+PiJSF3K5B5zCsGTNlMxezgLkR0yxsSSuvN5HNUZfM+VMxFomIivFwtug0KaLn+uJEx1giYRxmwirYBUjBitm1F/uY9IyDEVL/3OxPX58bZMSd4O/C5+taBDPhBY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrrAaLgEQLYh4DXZcbfcFB2yDXzxqatDaQ3k+6nYSI0=;
 b=V9n7dfUiLBI7ektVSzAZNRJu6AYA1XdLlIptO8OaQomRhLO04cJUL1RnTO5zartLQfhKuTwC8gpKDEnwimHI5Y6vbd2zYCarOChuRxBlKGLh76MkQm3goRLg5Gd977ooeiFKmfKprMxymPOCPzGvtRWMJTDhxNChFUvFy6hSXnM=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB8167.apcprd03.prod.outlook.com (2603:1096:400:453::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Wed, 7 Jun
 2023 08:50:32 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::8fce:558a:2511:c41b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::8fce:558a:2511:c41b%4]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 08:50:32 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/8] media: mediatek: vcodec: separate encoder and decoder
Thread-Topic: [PATCH 0/8] media: mediatek: vcodec: separate encoder and
 decoder
Thread-Index: AQHZlGwJ5/N7VCLpGUaiUox5B73dP69/EWKA
Date:   Wed, 7 Jun 2023 08:50:32 +0000
Message-ID: <26672825cfbd4364c66cd34307888f63239a04f5.camel@mediatek.com>
References: <20230601030256.29875-1-yunfei.dong@mediatek.com>
         <937fb46e-7e52-5689-9c49-efef477211db@collabora.com>
In-Reply-To: <937fb46e-7e52-5689-9c49-efef477211db@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB8167:EE_
x-ms-office365-filtering-correlation-id: fea1d3af-6134-42f9-f24b-08db673440c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGnSFi2XoEHpMon4PytxU9I1UEv8B5NXGCIGXyGl0tVERa4tjXiWYkCcm97lq8q9/ejIRwFbDNVxXSyJXqlo7k4+T7cncxhYHvM2CxfmpuTmI1GNCFidZqTQPyKT1Ql7Kd5A+TuN6RalqJGb7S0NqV8bej89CRd/otAn0NZ2UkMFpQFO6TCuIpHtLnQ4QtQcLY6Yajq1ayJP1qUpfqPdCQDUHAMFO/LQ0fo1OdhgnLoCrZX+3ItrA4r/A+IZL82+urcSEdpejsR6vjfqfoaspVEM/8b0w3W2zgOXhk6daWA3MMvFmHrR79J5KBpJ/Fr/yyx3iFcT1cOpbIGyhiUCroqjh3RWOlQacADkF3+hycAls5NHsIyRDizHtMAVCSQsRXfxBWcqp0GWIr1sAO6KTHC6E36opWjHxrBujvI/tCe0W/pYBY/QA0O8lVpTLcVBQhOijrlK9V37Qot2acNmy06lePPwb1/TbrZsofA410mBqqq8gxkwWfzMzcxgf+bcTomDoikM2wM2LmI8/3aNsEXSLkOyHylZ2FCmg5vQGE6B3ctOlxwrnhgJq+L6j7aK6Dz3NXnUM4o9w9exBzP66IRM0cs4tHLbdNQPhtRHeCTWAQ1+/L2RNVxs44NvEqkXlBH+HzcCpxb+2CAkXkQe/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(36756003)(7416002)(85182001)(86362001)(38070700005)(5660300002)(2906002)(83380400001)(71200400001)(186003)(6506007)(26005)(6512007)(478600001)(91956017)(6486002)(54906003)(110136005)(66556008)(38100700002)(64756008)(2616005)(4326008)(76116006)(8936002)(66946007)(66446008)(122000001)(316002)(41300700001)(8676002)(66476007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEplVGx2cVRpNU9EZ1hWT2hzdkVpVFo1N0J6ejZrQVl0dTFvT0Y2T2p5VGhL?=
 =?utf-8?B?UkdtRjJldlFpaGpCV2ttOTZCMHZVdmRkTXJETkRFdmRXSktWRXBkNkN5OS83?=
 =?utf-8?B?ejJjK2NqSFRzN0Y2bVgxUk5rN2hiLzk4MmtuelM5Qlp4SDAxVHl3MTZ0ekcr?=
 =?utf-8?B?UXk1ZDNNNldzaEF0Znk3VFQ0VnJHc1RyZDhNNHFyaFU3ZWpzWmZyWmNSTDlU?=
 =?utf-8?B?YVg1SUs5S3NUZzhBZ0NkRGpZZDVsaHF0QXNsak9xRjA2YXN4SnBtZklKR25M?=
 =?utf-8?B?bDVwUHVVNXVnc0x5bHNTYlRDWTBJV1dMNllIVVU4bTB3UzM0K2lXQjV6aldN?=
 =?utf-8?B?V3dSQ1NMeWcxcGlGNFdmZ2RjQ1FBbGRIdTVrOTRSMktDQjkyRDY0Y0s3Z0p6?=
 =?utf-8?B?M3pnSG5rOURTU0o1enFFV21jZmFERGxJYWFzQ0xmWFdEbFJJWWEzRG95UDBi?=
 =?utf-8?B?eXErTkM1bkJPdXRaOVM3MVRVUVBlUm9PdFc0amNORHpnR3hmSGlaVHpLdkx4?=
 =?utf-8?B?NFpGRnpkd2NTeFlBQmpNa0lINWZCZEczeTJtSUdLeGJveUZWN1ZOSzVOQ1Ax?=
 =?utf-8?B?c3F2aFcxSmJPeW5oaGJPcGlGeHphK1lPSjIxNzRqN1huQklFbEVTK2dzSE1X?=
 =?utf-8?B?QXc0QXBlWTRLTDNUMWVVcURYcFZqSHlMZXpXTXMxS2RJYnVJc1Vtd3NKbXp2?=
 =?utf-8?B?bXFoelB1aVdkZXQ5akxNL21OcW5na2ZMcUkyendlNEhmSWdGdko3UzhXVHBw?=
 =?utf-8?B?MHAyanIxdUtDcmhjUEVuUDlRcW9OTjMzRExZU2phM0ptbUMrVkRQRWlBa3pS?=
 =?utf-8?B?bFdnSExmL09pOC9zTGlwZDlrbmdqOVcyUWcwZmdITzlLY3poR0pYMnN6Sy85?=
 =?utf-8?B?WXhaV0g5TzQxOThBM0xxTDNCZVZSbm1jaWJERVgrTzAwVzFBOW40Vk01MnRC?=
 =?utf-8?B?M0JzcEpaMWEwcWJoYkV1VjZaczNtTXQreHhMNjlFa3MrYkdvcU9RYjNmUmtQ?=
 =?utf-8?B?RUNUSHZlbnJLdHYxSXo0MmM0U3Y0VnczZUJkMDh5MWJvSTlaemJHMUdJazkv?=
 =?utf-8?B?NkVFRTdOTUpZZjU0Njc2L0dreFdBTUJEOWNLbkRUaWkzYlo5SUNuelBtZGdH?=
 =?utf-8?B?MGpEK2g3T1dWWEdJKzFSaDVvUWIxdXZPOGhNYjdWNzdyL0RobzkvRjFJYmdL?=
 =?utf-8?B?VW1iNnY2NUFuQkt2aHhwQ2JBVUdEQTRRUGpUT1Q2WlZwVUpPM3VNcHc3M0NR?=
 =?utf-8?B?ZnFVaVQ1TWNKaHpuNE51WnIzczZ5TzQzUDVMblQwRXU5WDdJempXdW5SZ3Jl?=
 =?utf-8?B?Yzc4aGIrMHJwMFYzVHhnMmJFK091MmQzNDRVaTNDT3lndWYrQ1dZQW1wZG0z?=
 =?utf-8?B?TGpFVEVScTgxbHlwVVcyTHBGRHR0WXFoSFZWbUJRNmI2QmlOb0d2YUdIS3Yx?=
 =?utf-8?B?Y0hqWXZiazhycTV0QzhnUXdWVnNwNnh6NVBUSkVsKzFhZ3JmODVXL1IyeE05?=
 =?utf-8?B?UkVjMWp6S1JEdHI5aFMvcUhHckhwZzlWVGwyWkhyczg5b0F5NlhpSWdjZkFT?=
 =?utf-8?B?dHlrdXJaRkZtV3o0U05lWndMK0EyU0xGY0J4M0dlRlVTM09CSDdUejE3bS80?=
 =?utf-8?B?RHFaUG84dGxJSWhaWHBDaXRaRnJFR1N0ZXN5dis3WmlwNm14bGp0MmVlbzVu?=
 =?utf-8?B?cU5vWmM2TDE2YTZKUlNhbS84Q1c1QytlMXlXdzNkbkRGaTJ1clp5bzBMRTdn?=
 =?utf-8?B?RmV3dDZsS0NrRTFYeDQ2OVJzcEp2bExVdThIU1grVmsvVTdZS1NFdFR0ZXZy?=
 =?utf-8?B?MzVWWGh5UVNwaFptcHFrQnNqNS9LK3A2ek1Gb2JvY2MzS2ZsYWdIYTg5RHI4?=
 =?utf-8?B?eXVWdTJsY1FqMmdqNTMvNE9uaFVaTkZhUVJYZlY1alZublFRdmUzK2VSMTU2?=
 =?utf-8?B?OWt4czQ2Vk5NSk9rcFR6SnltY0FoVEFldUhyd1didERiMHdaZEg2ekQ0VjhN?=
 =?utf-8?B?SVdiVTUvVzBYM3lLaU54aFlidElZTXFpcTBXNVUzSHM1d0o5QjZHODd0NzFn?=
 =?utf-8?B?WTNpZTBBY1BaZEs0WUNtcE9WMDNCM0xzUHVsVmNmRFZHd3VrMDViL1VIZDdV?=
 =?utf-8?B?Q09sR1lER1BKSGZBUlI2MkhFQlJuMnJCc1lwaFMvRjV2WjdYcGtGTWtrWmwv?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82A7D911FEEBCB4685F6209C574A5657@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea1d3af-6134-42f9-f24b-08db673440c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 08:50:32.5163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7vEij9BkgIbrmkGRNhXCOo1gMyQNbLVc4ZGG1HcaHG4azhG7ByBxRXh1iWmEMuZt6o5V5cthJF97WsJCTMfhLBRH47e/91Um5Lts5O9RjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8167
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpPbiBU
aHUsIDIwMjMtMDYtMDEgYXQgMTE6MzIgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNl
bmRlciBvciB0aGUgY29udGVudC4NCj4gIElsIDAxLzA2LzIzIDA1OjAyLCBZdW5mZWkgRG9uZyBo
YSBzY3JpdHRvOg0KPiA+IFdpdGggdGhlIGRyaXZlciBtb3JlIGFuZCBtb3JlIGNvbXBsZXgsIGVu
Y29kZXIgYW5kIGRlY29kZXIgbmVlZCB0bw0KPiBhZGQgbW9yZSBwYXJhbWV0ZXINCj4gPiBpbiBz
aGFyZWQgc3RydWN0ICdtdGtfdmNvZGVjX2N0eCcgYW5kICdtdGtfdmNvZGVjX2RldicuIEVuY29k
ZXIgdXNlDQo+IGFib3V0IDQwJSBhbmQNCj4gPiBkZWNvZGVyIHVzZSA2MCUgcGFyYW1ldGVyLiBO
ZWVkIHRvIGFsbG9jYXRlIGV4dHJhIHVudXNlZCBtZW1vcnkNCj4gd2hlbiBlbmNvZGVyIGFuZCBk
ZWNvZGVyDQo+ID4gd29ya2luZy4NCj4gPiANCj4gPiBTZXBhcmF0ZSBlbmNvZGVyIGFuZCBkZWNv
ZGVyIGluIGRpZmZlcmVudCBmb2xkZXIgYW5kIHVzZQ0KPiBpbmRlcGVuZGVudCBkYXRhIHN0cnVj
dC4NCj4gPiANCj4gDQo+IEdyZWF0IGNsZWFudXAgaW5pdGlhdGl2ZSEgTG92ZSBpdCENCj4gDQo+
IE15IHN1Z2dnZXN0aW9uIGhlcmUgaXMgdG8gY2hhbmdlIHRoZSBuZXcgZm9sZGVyIG5hbWVzIHRv
IGRyb3AgInZpZGVvLQ0KPiAiOg0KPiB0aGlzIGlzIGFscmVhZHkgaW4gZm9sZGVyIHZjb2RlYy8g
d2hpY2ggbWVhbnMgdGhhdCBpdCBpcyB2aWRlbyBjb2RlYw0KPiByZWxhdGVkLg0KPiANCj4gU28s
IGluc3RlYWQgb2YgaGF2aW5nIGZvbGRlcnMgInZpZGVvLWNvbW1vbiIsICJ2aWRlby1kZWNvZGVy
IiwNCj4gInZpZGVvLWVuY29kZXIiLA0KPiB3ZSBzaG91bGQgaGF2ZSAiY29tbW9uIiwgImRlY29k
ZXIiLCAiZW5jb2RlciIgaW5zdGVhZC4NCj4gDQo+IENoZWVycywNCj4gQW5nZWxvDQo+IA0KRml4
ZWQgaW4gcGF0Y2ggdjIuDQoNCkJlc3QgUmVnYXJkcywNCll1bmZlaSBEb25nDQo=
