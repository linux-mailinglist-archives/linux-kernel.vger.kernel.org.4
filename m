Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE28711DB7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjEZCUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEZCUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:20:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8B2F7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:20:29 -0700 (PDT)
X-UUID: dda3adc0fb6b11edb20a276fd37b9834-20230526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wP2fmFHRHufL34rJI3XQ2vYE4qniY4YAKtEES8WbUsQ=;
        b=ZLuD40Z6MzG9U8CO0cn/rZZHpAsOLmHwSOXXPcJEKmKxAAQsJLEc9KxxReIw7MyG1RoNk+x1LdOsNufXCCFQd1yr/aYrY12Z5QP1rVWyMMM++IqD8xb2tu2KqwvLcualw21vcUEC0VSPLRqQxCTdtY65MgJaKqpYpU2+3cFpULY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:92315a2e-9858-49ef-97dc-46e0261f1684,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:92315a2e-9858-49ef-97dc-46e0261f1684,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:0cf5973c-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:2305261020231CBP92KJ,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: dda3adc0fb6b11edb20a276fd37b9834-20230526
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 753963937; Fri, 26 May 2023 10:20:21 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 May 2023 10:20:20 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 May 2023 10:20:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNroyRg/N0EUCSfATsx9g/bIJ9vcsEG0rwMi8y5XmcpEsLLk1fFbj5zGGmqRkb+WE5XqO8d6AYnVeyrxGipHOa+i9P0qh0ygBTdpMjUY7TjAjKYDq8mQst6gUeKsFq1hfwoNuuNWMiXN7/Jgh4yPcx0MfhuQeluVP4y+Y9ref1npWJ3vOqu7Dp3ghArzqrZHkw2LkjNn38J+iX//k9sw5MQcRIjqZSnUkIzywA1nFeB+u4fKJZm01BUbUHyWMZ+NcHMcASOg3Qz24IMOwFXaSugN9BQOZ4PnU2Q8+QanU2E0iNOPgPx97zdjnkvJn2HFxdIYEYi9il6cXaf4oMEgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP2fmFHRHufL34rJI3XQ2vYE4qniY4YAKtEES8WbUsQ=;
 b=XFx71zcXOPMj4JEuoQGL4CIlmJLQqsVVcMXAcf6pVlf1BkzVbBlk6NbEYJiQ7Fog2F4FJb8fJAzyqxZIZ4jAo+1alW5D+HHNRh+NEwse9vl+mvCpVs9Frwa0ypuLOmpb+6kGQNfycx6vFfUvkmnimABi+q16YACf9eSgQRtZznnDYeCmNIT3ZZCpvf3lSDjsm4hxHqtSR1MYizirL6/zv90z4pmiJx6mIgteoJSa8BiSN1J2jpmMNWWa6nQHjZp9ENwqlAIdW3ZY6+KvvCM+g79rSmQoZeGDMBGdSjVtTlWPySVmW7WpKvmL550eSbSJUwrnNQyroy/cDy5h4m5l7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP2fmFHRHufL34rJI3XQ2vYE4qniY4YAKtEES8WbUsQ=;
 b=qwvG65srUXCRECMOB1PEpoIHgZ/9jSeVJBzzRaGZk5Xetg7XdqjD3Uq0vA8dg3J+m86ffC4ChD/kVoyyljoTbyqO6LbwZgARxsHm46ziJDNveZqckGggBMIJn/kjW/15FuXRs3WyE9AkZqQOuTaXGQmkFggEoZoxB2ip2uwjBI4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6964.apcprd03.prod.outlook.com (2603:1096:101:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 02:20:17 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6c78:65bd:917f:8c58]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6c78:65bd:917f:8c58%7]) with mapi id 15.20.6411.030; Fri, 26 May 2023
 02:20:17 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 05/11] drm/mediatek: gamma: Enable the Gamma LUT table
 only after programming
Thread-Topic: [PATCH v4 05/11] drm/mediatek: gamma: Enable the Gamma LUT table
 only after programming
Thread-Index: AQHZiXZxds3I7znU6Uy7wXDx+bim/q9mFXYAgAAorYCABaApgA==
Date:   Fri, 26 May 2023 02:20:17 +0000
Message-ID: <3f8996c27ca5415bbb661c558145a5ed486e5057.camel@mediatek.com>
References: <20230518104857.124265-1-angelogioacchino.delregno@collabora.com>
         <20230518104857.124265-6-angelogioacchino.delregno@collabora.com>
         <51a5fbd349cce69d372f4ccfff7010ea9e6e8f75.camel@mediatek.com>
         <a28293b1-18d9-6a85-5325-3b7944d97a14@collabora.com>
In-Reply-To: <a28293b1-18d9-6a85-5325-3b7944d97a14@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6964:EE_
x-ms-office365-filtering-correlation-id: ce916099-d704-415a-7094-08db5d8fbf7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QDdWOX/HRNRxNCpt98qJeb/Njmj0ygJYXGVmDHcFhpK/IZ24OXx2y+WjJAbiTKRyIUuVf5dxHwlGo4ZEAq262zi/yuISwVN2LoHmqiUiCuKq9WfX1CrEW8nKHPb2GkrB00gpcQLJMWKunHHcw/g3ejw8xQeN9Vq8DKhQAirk6NV/LQnSNGC9O/Ag7DtifDXyMgMYjARacoSwlkztolNDCfn2OYHnTvps6S6lPflWu5B/1l1XLThLNJbgFxAKddjNUk8GFim3TdvM3cRs/MLwv1paoejLiAQY1NkiZoJdsr/hA+46ndaPjDpsWcssJNtjmigwcOdxntTmZUgfNpFamnmj3WIsPKwjDOUXWuf+cTkw6fXDsy13GnapStWuNauD9Fbeb9A6ottmL+juAfdDnZAT5mOIfC+oNHrcDnu9enX9ReiEmrk+8nCs95DRJJdB+Xo5SjOQT+/ewJSIbTMtw+JSnowd3U+/Ea9/fEpVFJgOaY+EfSQ1O4tfKf9tBL4HnhzgJmOaRNVlfBjG6O/nj+1QpFTeTVxIh6kEGaCI/PVGG/pEEunTWwCnNzjlZzX/gvuOAT0Y1nI9SzbizFfYANJEkZrjarHpmbRXbKEoNoBVUZ+AVvQHGLT3evoC8zFs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(6512007)(8676002)(8936002)(26005)(2616005)(186003)(86362001)(6506007)(4326008)(41300700001)(85182001)(36756003)(2906002)(66476007)(66946007)(38070700005)(66556008)(64756008)(66446008)(110136005)(316002)(54906003)(76116006)(83380400001)(6486002)(38100700002)(5660300002)(478600001)(71200400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWFYTXQvbDZ3VVVGcFJtaUNXUHduN2I2OGxURlJJRWl3dThMcXFCYTZCQlpi?=
 =?utf-8?B?OVU1OEZiRkVydXVqTW53bCttU2hwWUpTdU9QMVBpUExEME9yNmhRTVN5cWdV?=
 =?utf-8?B?OUQyM1E1elM3ZDYwKzlnUlh3WCtsR3JjQWlKczViQjA5R29CL1NaY1BiVk5L?=
 =?utf-8?B?b1ozUUR3QzZBOUtwS2ZHMzZtMXZqOTkwa2hOdjF1RGJmL0dGNjZyVzIxM2xz?=
 =?utf-8?B?TmxKcXUyTzhGZGk0UUYybU50TjRzRjRUYzlhRmJxdTdqdkpsb1o4SFRwNnc4?=
 =?utf-8?B?TUJpaCtwWE8rMXVvVUxJZWZ2d3M4U3A2WFZQU012bXZJTWhURm9RRE1iRWI1?=
 =?utf-8?B?UXV3S0dDdk5vcS85aXRWclNOKzFQczY0aWlHMHF5NTA5YkVVdldFaThDdDVD?=
 =?utf-8?B?V3Npdmw4L0tTbTFxaVlhbFZSK2FKL2RSY2NTdmJvaENSN0FuTFZTNS9LMmpp?=
 =?utf-8?B?RjRjdGQxclVkVVJlVjVsbXZDSkRuUXU3bFprcUxxMXhCYjJvUUtZd3BabTM5?=
 =?utf-8?B?VloyWEZ3Z2FobmhoRnUvdHJNUDNzYXVjUytNYWdlWFoxVTB6d1cxVWpkWGtI?=
 =?utf-8?B?VndQdXFNeVRxRGw4K1BHSkZLK0tlbXZBNUR6aHpzcjNFc2RGbGdrMngrNzFB?=
 =?utf-8?B?Z09PVmVvU0UvVmZSanFxUjBLMis2dDUyYzhqc25LK1lSNndYcVdJUUpNVjlB?=
 =?utf-8?B?SXlQc2g5Q2dZK3hkelFEL3c1eHJ6NmxNSUtabm9TSENNMURsQisyMys5aWty?=
 =?utf-8?B?VzhldHpNZEhXSDRPbDBFQ3MxZWh3YUtjOEVoNUNudW5aYithbW9HVXN4S0RK?=
 =?utf-8?B?azRhOWtuaFBCRS9GL2h2SWk5RjFYQnpuQUp0Z2E3WkVXbHFEbzUvUlpOZ2lT?=
 =?utf-8?B?TDhOSk1FNnNjL2pVeHRKLzhHc1Z2cXpaWWRlSFdjb3pLRVp2Z2pvWmZDV0Y3?=
 =?utf-8?B?SUYrT29XNEJlVFU5bFJmMlI4cFB2U1JlRnhhd0piYk96eEpIeU4wWmhhR0tI?=
 =?utf-8?B?WVlJWmMyMi93RURKZWZEN2YwZnluV29CQ1dhVUVLMzgxSElQdm80TlVidis1?=
 =?utf-8?B?UGdnaVRsYWhtd1ErYzVhUU1KemNpb3Z4Qm95WWdYVUdOaDNNODRuREtVWkd1?=
 =?utf-8?B?RmgyMzRwMDloRmR3N01lWDZRUXNFZE1vcytuYTBNMnFaSlhvaTNBeU02VjRk?=
 =?utf-8?B?VHpIbDZFbUphbmF4ZVgxb1poYWZnUzdTbDZseXhHY1dSN2daMWd6RTVsUHVF?=
 =?utf-8?B?eURONE00Mys1WTRRVWJSOEtZdmt4ZU5xdVJCaXFJMGNYdHVqbWIraXFyNlZy?=
 =?utf-8?B?L2lEZ0VTaXBQemprbGNUbmRzMjZhbDNJT3pVNlBHK2RvVVlEZFRuYi94cFRq?=
 =?utf-8?B?Rit5d25ZeldzelZnaE96Mk1vMkV1Z1ZwTDUxZkYwN0oxdUp0ZGlRRzl5c0JJ?=
 =?utf-8?B?UmxWZzNJUm1FSzE0ekRFQ29tdkNSZDBWRkpxSkdiZUNDVU0wSVYrdk5mV3J5?=
 =?utf-8?B?c3BVam5DcGRxd3lHOVZUcVNMQWw0NGNRMWcwUUE2UnRVdktJc05PVlFObmVU?=
 =?utf-8?B?VWZKaFl3SExjb2h6dExmalBRU05STFBhMFIyV3NiRHdubGFVRE9Dck1uWVQx?=
 =?utf-8?B?Z0wwcFN1QUpnbXBzQVRjSUpUSTFKbUVVUDlXK0JtTXB3UUI4L0tpa0dBOTRD?=
 =?utf-8?B?UmZxOTlRc0gyTXhrcEE0eGx1SmRubmlSTnRtN1BSWVhYd2QwYXFxUkwrbDd6?=
 =?utf-8?B?QkM2N2dhd2lCemhUSEtuWEp1bnZWYjZaVGRIMVRwdjdoOE5ZdW1QQUJwczNT?=
 =?utf-8?B?UXFiV2FWOEFiY3VHQ0RjdnhZVjdvNkdIcnF3VytSRjVHdkgvbGo2UXRTTHVR?=
 =?utf-8?B?VHE3MWRGbXkydjFMbzRVNG1pS0R4aERteDU4TjYvVkNZQTNsS2FCTG5CWVZX?=
 =?utf-8?B?MDl0RGZWNURwelFYb1ZoL0ttUlV5TnlCcUJSbDhzTEtNVlQ3ZDhRTmhSbjVK?=
 =?utf-8?B?SDRXNmlZTmROWW9OWmFGV1NJdFV6cXZNaG50amZXUnBkMzRCU0ZFRGt3NVNl?=
 =?utf-8?B?OFJtQmhkRU44Z0dpRS9ReEI5dnhqNHBXcktyVFhIN0M3MzhYM1VvREJPNndH?=
 =?utf-8?Q?lBhDOSWpWJrqRhDAnj6kCH+b4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A759E8F56C9F4344848350F137BDDD5C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce916099-d704-415a-7094-08db5d8fbf7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 02:20:17.7402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XTDiXzWLznrX96EBVf2RwtdFwpf3oJgf2btwaTQiBRFMveysNg8UxyldGapOTO3YKh0HZjNDY8oGs6rd2rqSYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6964
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gTW9uLCAyMDIzLTA1LTIyIGF0IDE0OjI1ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVy
aWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAyMi8wNS8yMyAx
MjowMCwgQ0sgSHUgKOiDoeS/iuWFiSkgaGEgc2NyaXR0bzoNCj4gPiBIaSwgQW5nZWxvOg0KPiA+
IA0KPiA+IE9uIFRodSwgMjAyMy0wNS0xOCBhdCAxMjo0OCArMDIwMCwgQW5nZWxvR2lvYWNjaGlu
byBEZWwgUmVnbm8NCj4gPiB3cm90ZToNCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiBNb3ZlIHRoZSB3cml0ZSB0byBESVNQX0dBTU1BX0NGRyB0byBlbmFibGUgdGhl
IEdhbW1hIExVVCB0byBhZnRlcg0KPiA+ID4gcHJvZ3JhbW1pbmcgdGhlIGFjdHVhbCB0YWJsZSB0
byBhdm9pZCBwb3RlbnRpYWwgdmlzdWFsIGdsaXRjaGVzDQo+ID4gPiBkdXJpbmcNCj4gPiA+IHRh
YmxlIG1vZGlmaWNhdGlvbi4NCj4gPiANCj4gPiBJIHRoaW5rIHVzZXIgY291bGQgdXBkYXRlIHRo
ZSBsdXQgdGFibGUgZnJlcXVlbnRseSwgc28gd2hlbiBkbyB5b3UNCj4gPiBkaXNhYmxlIHRoZSBn
YW1tYSBmdW5jdGlvbiBiZWZvcmUgbmV4dCB1cGRhdGU/IEluIGFkZGl0aW9uLCBpZiB3ZQ0KPiA+
IHJlYWxseSBjYXJlIHRoZSBnbGl0Y2hlcywgdXBkYXRlIHRoZSByZWdpc3RlciBpbiB2Ymxhbmsg
cGVyaW9kDQo+ID4gd2hpY2gNCj4gPiBzaG91bGQgdXNlIGNtZHEgdG8gdXBkYXRlIHRoZSByZWdp
c3Rlci4gQnV0IG5vdywgSSB0aGluayB3ZSBkbyBub3QNCj4gPiBjYXJlDQo+ID4gdGhlIGdsaXRj
aGVzLiBZb3UgbWF5IHNraXAgdGhpcyBwYXRjaCwgb3IgZml4IHRoZSBwcm9ibGVtIEkNCj4gPiBt
ZW50aW9uLg0KPiA+IA0KPiANCj4gSWYgeW91IGRpc2FibGUgdGhlIEdBTU1BIGZ1bmN0aW9uIChl
aXRoZXIgc2V0IFJFTEFZIG1vZGUgb3IgZGlzYWJsZQ0KPiB0aGUNCj4gR0FNTUFfTFVUX0VOIGJp
dCBpbiBHQU1NQV9DRkcpLCB0aGVyZSB3aWxsIGJlIGdsaXRjaGVzIGR1cmluZyBzZXR0aW5nDQo+
IHZpYQ0KPiB0aGUgR05PTUUgTmlnaHQgTW9kZSBjb2xvciB0ZW1wZXJhdHVyZSBzbGlkZXIuDQo+
IA0KPiBUaGlzIGNvbW1pdCBwcmV2ZW50cyBhIGdsaXRjaCBpbiB0aGUgY2FzZSBpbiB3aGljaCB0
aGUgR0FNTUEgTFVUDQo+IHJlZ2lzdGVycw0KPiBhcmUgbm90IHplcm9lZCBiZWZvcmUgc2V0dGlu
ZyB0aGUgZXhwZWN0ZWQgTFVULCBmb3Igd2hpY2ggcmVhc29uIEkNCj4gZGlzYWdyZWUNCj4gYWJv
dXQgc2tpcHBpbmcgdGhpcyBwYXRjaC4NCj4gDQo+IFBsZWFzZSBub3RlIHRoYXQsIHdoaWxlIEkg
YWdyZWUgYWJvdXQgdXBkYXRpbmcgdGhlIEdBTU1BIExVVCB0aHJvdWdoDQo+IENNRFENCj4gc2V0
dGluZyBhbmQgYmV0d2VlbiB2YmxhbmtzLCB0aGlzIHJlcXVpcmVzIGEgbG90IG1vcmUgZWZmb3J0
IHRvDQo+IGltcGxlbWVudA0KPiBhbmQgaXQncyBvdXQgb2Ygc2NvcGUgZm9yIHRoaXMgc3BlY2lm
aWMgc2VyaWVzOyBkZXBlbmRpbmcgb24gbXkNCj4gYmFuZHdpZHRoLA0KPiB0aGlzIG1heSBjb21l
IGxhdGVyIGFuZCBpdCB3b3VsZCBpbiBhbnkgY2FzZSByZXF1aXJlIHRoaXMgcGF0Y2ggdG8NCj4g
bW92ZQ0KPiB0aGUgTFVUIGVuYWJsZW1lbnQgdG8gYWZ0ZXIgTFVUIHJlZ2lzdGVycyBzZXR0aW5n
LiBCZXNpZGVzLCBJIGhhdmUNCj4gYWxyZWFkeQ0KPiB0cmllZCB0byBlbmFibGUgdGhpcyB0aHJv
dWdoIENNRFEsIGJ1dCBkaWRuJ3Qgd29yayBhcyBleHBlY3RlZCBhbmQNCj4gc2luY2UgSQ0KPiBo
YWQgbm8gdGltZSB0byBkaWcgZnVydGhlciwgSSBkZWVtZWQgdGhpcyB0byBiZSBlc3NlbnRpYWwg
Zm9yIGF0DQo+IGxlYXN0IGFuDQo+IGluaXRpYWwgZnVuY3Rpb25hbGl0eSBpbXBsZW1lbnRhdGlv
biBmb3IgTVQ4MTk1LCBhbmQgYSBjbGVhbnVwIG9mDQo+IHRoaXMNCj4gZHJpdmVyLg0KPiBPYnZp
b3VzbHksIHRoZSAqb25seSogd2F5IHRvIGZpeCAqYWxsKiBvZiB0aGUgY29ybmVyIGNhc2VzIG9m
IHRoZQ0KPiBwcm9ibGVtDQo+IHRoYXQgeW91IG1lbnRpb25lZCBpcyB0byB1c2UgQ01EUSBhbmQg
dHJ5aW5nIHRvIGltcGxlbWVudCB0aGlzIHB1cmVseQ0KPiB3aXRoDQo+IGNwdSB3cml0ZXMgd2ls
bCBpbiBhbnkgY2FzZSBiZSBwcm9uZSB0byBhdCBsZWFzdCBzb21lIGdsaXRjaGVzLg0KPiANCj4g
SW4gYW55IGNhc2UsIHdoaWxlIHlvdXIgY29uY2VybiBpcyB2YWxpZCwgSSdtIHN1cmUgdGhhdCB5
b3UgYWdyZWUNCj4gd2l0aCBtZQ0KPiBvbiB0aGUgZmFjdCB0aGF0IGVuYWJsaW5nIHRoZSBMVVQg
YmVmb3JlIGFjdHVhbGx5IHByb2dyYW1taW5nIGl0IGlzDQo+IHNvbWV0aGluZw0KPiB0aGF0IHNo
b3VsZCBub3QgaGFwcGVuIGluIHByaW5jaXBsZS4gRm9yIHRoaXMgcmVhc29uLCBhbmQgZm9yIHRo
ZQ0KPiBvdGhlcnMgdGhhdA0KPiBJJ3ZlIGp1c3QgbWVudGlvbmVkLCBJIHRoaW5rIHRoYXQgdGhp
cyBwYXRjaCBpcyB0b3RhbGx5IHZhbGlkLg0KDQpPSy4gU28gcGxlYXNlIGFkZCB0aGVzZSBjb21t
ZW50IHRvIHBhdGNoIGRlc2NyaXB0aW9uIHNvIHRoYXQgd2UgY291bGQNCmtub3cgdGhlcmUgaXMg
c29tZXRoaW5nIHRvIGRvLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gUmVnYXJkcywNCj4gQW5n
ZWxvDQo+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gQ0sNCj4gPiANCj4gPiA+IA0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+ID4gYW5nZWxvZ2lvYWNj
aGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IEphc29uLUpI
LkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYyB8IDEzICsrKysrKysrLS0tLS0N
Cj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkN
Cj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9nYW1tYS5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9n
YW1tYS5jDQo+ID4gPiBpbmRleCA2MGNjZWE4YzFlMWEuLjE1OTI2MTRiNmRlNyAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+ID4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYw0KPiA+ID4g
QEAgLTcxLDEyICs3MSwxMiBAQCB1bnNpZ25lZCBpbnQgbXRrX2dhbW1hX2dldF9sdXRfc2l6ZShz
dHJ1Y3QNCj4gPiA+IGRldmljZQ0KPiA+ID4gKmRldikNCj4gPiA+ICAgdm9pZCBtdGtfZ2FtbWFf
c2V0X2NvbW1vbihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgX19pb21lbQ0KPiA+ID4gKnJlZ3Ms
DQo+ID4gPiBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKnN0YXRlKQ0KPiA+ID4gICB7DQo+ID4gPiAg
ICAgICAgICBzdHJ1Y3QgbXRrX2Rpc3BfZ2FtbWEgKmdhbW1hID0gZGV2X2dldF9kcnZkYXRhKGRl
dik7DQo+ID4gPiAtICAgICAgIHVuc2lnbmVkIGludCBpLCByZWc7DQo+ID4gPiArICAgICAgIHVu
c2lnbmVkIGludCBpOw0KPiA+ID4gICAgICAgICAgc3RydWN0IGRybV9jb2xvcl9sdXQgKmx1dDsN
Cj4gPiA+ICAgICAgICAgIHZvaWQgX19pb21lbSAqbHV0X2Jhc2U7DQo+ID4gPiAgICAgICAgICBi
b29sIGx1dF9kaWZmOw0KPiA+ID4gICAgICAgICAgdTE2IGx1dF9zaXplOw0KPiA+ID4gLSAgICAg
ICB1MzIgd29yZDsNCj4gPiA+ICsgICAgICAgdTMyIGNmZ192YWwsIHdvcmQ7DQo+ID4gPiANCj4g
PiA+ICAgICAgICAgIC8qIElmIHRoZXJlJ3Mgbm8gZ2FtbWEgbHV0IHRoZXJlJ3Mgbm90aGluZyB0
byBkbyBoZXJlLg0KPiA+ID4gKi8NCj4gPiA+ICAgICAgICAgIGlmICghc3RhdGUtPmdhbW1hX2x1
dCkNCj4gPiA+IEBAIC05MCw5ICs5MCw3IEBAIHZvaWQgbXRrX2dhbW1hX3NldF9jb21tb24oc3Ry
dWN0IGRldmljZSAqZGV2LA0KPiA+ID4gdm9pZA0KPiA+ID4gX19pb21lbSAqcmVncywgc3RydWN0
IGRybV9jcnQNCj4gPiA+ICAgICAgICAgICAgICAgICAgbHV0X3NpemUgPSBMVVRfU0laRV9ERUZB
VUxUOw0KPiA+ID4gICAgICAgICAgfQ0KPiA+ID4gDQo+ID4gPiAtICAgICAgIHJlZyA9IHJlYWRs
KHJlZ3MgKyBESVNQX0dBTU1BX0NGRyk7DQo+ID4gPiAtICAgICAgIHJlZyA9IHJlZyB8IEdBTU1B
X0xVVF9FTjsNCj4gPiA+IC0gICAgICAgd3JpdGVsKHJlZywgcmVncyArIERJU1BfR0FNTUFfQ0ZH
KTsNCj4gPiA+ICsgICAgICAgY2ZnX3ZhbCA9IHJlYWRsKHJlZ3MgKyBESVNQX0dBTU1BX0NGRyk7
DQo+ID4gPiAgICAgICAgICBsdXRfYmFzZSA9IHJlZ3MgKyBESVNQX0dBTU1BX0xVVDsNCj4gPiA+
ICAgICAgICAgIGx1dCA9IChzdHJ1Y3QgZHJtX2NvbG9yX2x1dCAqKXN0YXRlLT5nYW1tYV9sdXQt
PmRhdGE7DQo+ID4gPiAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbHV0X3NpemU7IGkrKykgew0K
PiA+ID4gQEAgLTEyMiw2ICsxMjAsMTEgQEAgdm9pZCBtdGtfZ2FtbWFfc2V0X2NvbW1vbihzdHJ1
Y3QgZGV2aWNlDQo+ID4gPiAqZGV2LA0KPiA+ID4gdm9pZCBfX2lvbWVtICpyZWdzLCBzdHJ1Y3Qg
ZHJtX2NydA0KPiA+ID4gICAgICAgICAgICAgICAgICB9DQo+ID4gPiAgICAgICAgICAgICAgICAg
IHdyaXRlbCh3b3JkLCAobHV0X2Jhc2UgKyBpICogNCkpOw0KPiA+ID4gICAgICAgICAgfQ0KPiA+
ID4gKw0KPiA+ID4gKyAgICAgICAvKiBFbmFibGUgdGhlIGdhbW1hIHRhYmxlICovDQo+ID4gPiAr
ICAgICAgIGNmZ192YWwgPSBjZmdfdmFsIHwgR0FNTUFfTFVUX0VOOw0KPiA+ID4gKw0KPiA+ID4g
KyAgICAgICB3cml0ZWwoY2ZnX3ZhbCwgcmVncyArIERJU1BfR0FNTUFfQ0ZHKTsNCj4gPiA+ICAg
fQ0KPiA+ID4gDQo+ID4gPiAgIHZvaWQgbXRrX2dhbW1hX3NldChzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCBkcm1fY3J0Y19zdGF0ZQ0KPiA+ID4gKnN0YXRlKQ0KPiA+ID4gLS0NCj4gPiA+IDIu
NDAuMQ0KPiA+ID4gDQo+IA0KPiANCg==
