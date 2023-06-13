Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C654672D962
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbjFMFjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240352AbjFMFiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:38:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87D02D4B;
        Mon, 12 Jun 2023 22:35:56 -0700 (PDT)
X-UUID: 276dc4ce09ac11eeb20a276fd37b9834-20230613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iyCKBt51voilasM/1bNkvmMfYK76A1uyMKWP7xJ9638=;
        b=YeMASLTAqb4BFEwnS/qD85Q3oDghZdhe/7E21NLOR5qFaRQ7cj7Jje0EySZ4QoRDTi28yzOL3IfK/csjwcLEXaqHBop85qrsT0O9GfMFKHyZ/1yRaa3t8jSoxxyKjdbtijgwC1Gwh8eE6deJ/efxBspYmfov0rYBre8mcbyvl+U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:60e90129-086d-49f7-8dd9-6e83c79063ef,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:2ef8e36e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 276dc4ce09ac11eeb20a276fd37b9834-20230613
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1945244379; Tue, 13 Jun 2023 13:35:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 13:35:49 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 13:35:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSiCO8rCluY4lpD2LJvH5dpEKVYCSEahqbU8ynsA+jMY2aZS0KizdMhITM8JTvppn1NRX4daRloQEEUECGx0CDCoNHKWMpG4XkIfLMCOqSPHgRopvky9gxmXgvo7GqXDSMXBBxIxm+Xt6xmWHhBwlr3opzL2wjqeP9mChw5sCZ4su1BJPfpyCx0h0rhIU9UfIJZm23d/PQPY+3zySiOy1YItn1vKTOXfP9wdCHROPrAgPLTukWS52UC72VJxj9ZcuaFdO9H+6dnueC0GTe3NZO1KWDSpbG2VJFGneHJAnqICjIt5JUXpwgYGSeBIDniZunBJheTwzOjOEhWbQe+KbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyCKBt51voilasM/1bNkvmMfYK76A1uyMKWP7xJ9638=;
 b=A/AgLe1h7ZQoQksE+P7IbNDyUmOJ6svdRoU5W9y1W7gONBLR0DWWl7UyLBT0EAs75u9upi11Bm4fUEIc2SSwMwmxWYFnWox80wDDGPJbxrN7y0/RvPiNDPdjy9JF6m4RWQNYWZ0Bhxey6VvRCsCv8ubozAKUbPK3fPpSnjko2bNORE2SfkrJmJ1uWg2ai7QOVmf7glUfAw+2eIb6460v6cbAH6CmO9JcqIxCYxLZUT8WcSNdBB8Q27E2xTLa9sxI4WSeH2yYgPlSnwTpoQ6q5ELiiG6PRgxbnQLqeMF2nVEoO54Y2MV3DK9XzvC7s3Bp3jZC5SIXYpkmiMDNvBdjEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyCKBt51voilasM/1bNkvmMfYK76A1uyMKWP7xJ9638=;
 b=rEmNfwmdDbCdcCntwrcHbwSJomuWbHP4hP+E+qUlpjlao/kzr7QHvx0Wooc1luB8iz/CJD8v6vAr5vmFr3AinvwRd5b0P7D2fZ0+B92cxtv9zoRy0AsXE3seWDbtf32OjjvcUVrQQdpn8eoyKrVcbrnJpm8dQeN7EYuiokSWRnw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8098.apcprd03.prod.outlook.com (2603:1096:990:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Tue, 13 Jun
 2023 05:35:46 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%6]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 05:35:46 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "granquet@baylibre.com" <granquet@baylibre.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?U3R1YXJ0IExlZSAo5p2O57+wKQ==?= <Stuart.Lee@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 5/8] drm/mediatek: hdmi: add v2 support
Thread-Topic: [PATCH v4 5/8] drm/mediatek: hdmi: add v2 support
Thread-Index: AQHZkjsmmHc/VTGOHU6M5MEfnDzs/6+ITVUA
Date:   Tue, 13 Jun 2023 05:35:45 +0000
Message-ID: <7805c3c41a72abd105b9fd40b266c70d5fcfdf39.camel@mediatek.com>
References: <20220919-v4-0-687f09a06dd9@baylibre.com>
         <20220919-v4-5-687f09a06dd9@baylibre.com>
In-Reply-To: <20220919-v4-5-687f09a06dd9@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8098:EE_
x-ms-office365-filtering-correlation-id: db53c129-cbcb-4ce8-18ae-08db6bd00981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cJvTl112HF3nByVm+C574WirVHpE4iMCfZ4L2vu9k3mQQnwxB++Fr0M6kDajSmTR79QcQjHb6cEHvU1V60cwVSKo1tjyZAiy9ihcqpuZIq/CiQASFMklS5Jwtx5I9PpBIlwdnjJoEDRcwwSuAB+9RsWAIXgF+Iwg1s/V6MRtNuDFCKPy66JDKU2ltPOjCftJrGqNdC733VD16O22+VxMqH3/YjtfvMIqwciIxqeULNZFMXqriRTViJuqNJrVneAjpueyeInZgn+UsgqnT6oJSPEj4Og4/ykPXNE+7MSzSDTajhPj2VKzXk9HOxOIzT/tM9XzUQ/6rs4/R3Y29Z2pnv8VcHuE6QITUQphlyR8TvLPzElkW+2totSNH6Uu11LdnJwSTAdhc+yy87pWWYJuh8kAnDIq8+vb5ez/gX77rDPwkv3aNtIMtbr+Zda/TlJOeRYEia5GMITfQ6Yso3RK/u3y/sTcrhuI0SyAA+5sGXctQmcEcW3+9JUpOVG8KuWMdiwk36rBl+ZmlQkwbZEF5GSlftpmuZY2GE0+fCQ38HJTGma5gMww8g9mOzo2XBvte2jerhlN4NZMNlUlySA4O//1NUzFE0AJnkTIa28LLC/5O6xZu0LyCB2HUFtThG8sVO2hqOapdzCeK0lSlG3OLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(66446008)(478600001)(110136005)(66476007)(71200400001)(76116006)(64756008)(66946007)(316002)(66556008)(54906003)(4326008)(36756003)(86362001)(85182001)(38070700005)(41300700001)(83380400001)(6506007)(26005)(186003)(5660300002)(8676002)(7416002)(8936002)(2906002)(6512007)(6486002)(38100700002)(122000001)(921005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmlyMnI4TU1vVnBXNVk1SHBlSGVxWCtUeTlnT3JyZkdlb1ZtVEQ3ZFJZMVFF?=
 =?utf-8?B?S202ZWNoVnM4cXRnVWk2NW5WMEhYOUhBa25sZTJFSUkwcExHSHZWaFhMSWpQ?=
 =?utf-8?B?dVMrV1dHWGw1cGI3VlZDQmNXNlJxaGkvMnpwR3kvZnpmSDJHdjdGSUJpN3BO?=
 =?utf-8?B?YUZkUDFNUXR6YjRDTmtwLy95NmRsZXZXR1RxbjlqanpTK2ZZL0lxOW5EbWVQ?=
 =?utf-8?B?YTc5ZVNoZ0hBQk9NVzlQQUdWYjZEK3oyaUttV2RiQkIxcVZGTUhNNU04Mndh?=
 =?utf-8?B?d1ZKQmxHNmtPQzh2dTlyTmdsOTZxZ1B1WkwrMVQ2bFlZWVZsRjhqOEF2T0hr?=
 =?utf-8?B?YTVBZXJUY3B1WnlFOUNWQXdVMTcybmJGeGpQVk5jcUtQcTZxQW5TUkhXRHow?=
 =?utf-8?B?NENJeFd4clpUekZwakowdFZxUEpnRVNVUmlqcTBKU09vTmxyZ1dCU2xCeGhw?=
 =?utf-8?B?dHVSTVM5MThGQlg2UUdBdWpQNTJyNTZLOG5XbHBnYkhFWkE2L3o5ajZCUXAz?=
 =?utf-8?B?dWpJalJzd0tDZjF5eU5FSWE2aWpiallwak41ZTZ2bG1ieFp2SjhvUmxNWk1i?=
 =?utf-8?B?UEt5dXpWekZock5BeE5VTjRmSEF6eEs2SW1BWW9vSUdqVXh2dWtsVG05Tm5I?=
 =?utf-8?B?WWZFWFpwSHVLMm8xVW0xOWtSelhDK2dNZzg1YzA5M0tIRGx2NVV2bExwbldS?=
 =?utf-8?B?MWRZOEUvL252M05rYWpSL2ZpdUM0dFNYNjlaVXE3czAvUTd2Y3lwQ1l3S2tI?=
 =?utf-8?B?T2ZGdDdqelNrTWVnQmRGQkJ3RmVyVUo0alorbGU3UVQyKzNzRVFETDZxdld6?=
 =?utf-8?B?UWE4ZlpqSDBDR3oxUzdWK0VvOVdTTXQ4VWNIRlZHd1FBR1I3U2FzRXBiTjBi?=
 =?utf-8?B?emxvOHFnMStxV0Y0WFhubzFrOUtJQzBqZ3ZPeFJQeU15eDB3enZJVjFBTTdN?=
 =?utf-8?B?VWw1QmtiQWRLR1MwbFZMMGxzZTg5MmhuaEZxaDR5VjlUcitPK3BRelZQVU1K?=
 =?utf-8?B?N0ZFNjlreEFXQ3p5MklMdmkxYnpabk0xb2FTOVg2QmlLMlRsQmd3RzlSMTVq?=
 =?utf-8?B?a1A2QThTeS9UdmlGOFZ4cWgwTEtiNWRGaG1BMEFLYjhjR3FhNStlZWlhU21N?=
 =?utf-8?B?VmdoakI0SEpTQS9vcjJOOEtpNkgrVHY2Q0UyUk43VDRTVFBlWjVOYUNjaTFB?=
 =?utf-8?B?UFpPVnE3L25lc3h2VTZRYmw1S0RwVkhwWlRyMlFZV1ZRU3BDaW4yaTNSVVVW?=
 =?utf-8?B?TGE5Z3RBTmx1YU14dlNWQjlmeUprS09vVGRSZ2tPRHdrYVR1NXR0MEI2Snkr?=
 =?utf-8?B?SmxvdldLOWNSNUpRVUZrOFlvelBqa0srMVNsMnFqdjNBRVZvTFpsTFFUZzk0?=
 =?utf-8?B?NlArZmkzcTlBb2NSWDNSM0RKV3V2cjJ5dWFlQkdtRXVYT0Z2WnliUUphV2U4?=
 =?utf-8?B?MWJPZ2EwV21OTmpkSXRlSFJJZnRzdjFQMVNMSWJhSWFNeWVxN1JMWU9DSjR1?=
 =?utf-8?B?TVhPVGhpNVNVUElGVjNQNGNiTkg5cUoySzVOY3dHTU43MTJOczBxYXhYYkNn?=
 =?utf-8?B?Q1dpeWM4OHZBZStWNER0L0JUeVpZalhrSzk3ZkprU2E0Ymw2Yk9mdEJuOGNw?=
 =?utf-8?B?alpPd1V4Rld0M1Rnem1yWk96Skl1NWxqK3ZoWXhybFR4Wk1oTEJRSGZ0aTlI?=
 =?utf-8?B?dzdWb2FRdUlxZjI4alc5cHc1enpaY2JmWExpMUZwb2FNTGg5L0MxTmV6UnlR?=
 =?utf-8?B?QmhQbFBsZW1pQldLOHA4YllhckZuYlNDc1dLRUJNa1F2dGptS1k2enQ3NzhD?=
 =?utf-8?B?K0lQVG9NRXdGQTl3Q2ZMMllIbU5OL0hldi9KTWVyM1Z4R0FkS25sTkk4cWRV?=
 =?utf-8?B?M0R4MUZ6YVZKbFVsNnF5NHNHZEN5c2ZMSkZZaER5NjBHcjVnVmZOQW0xMGo5?=
 =?utf-8?B?V2VTaGRNU0psQzExRVMyQzJaelNLNVBlVU1nVWlvVHhXcXkrVlZROTJ4NjZ3?=
 =?utf-8?B?eXQ4a3BPWWlPb2M1ckJ0Y0s2VENEMFNKTFphODU2TGttRXNVQzROS0E3Y01D?=
 =?utf-8?B?UzVjeFN3YnRneURLdmI5SndTclowbkozbTYzMFA0RVdLTDVQTytQTE0xVXJL?=
 =?utf-8?Q?OY1UJRIZ83zPccgp05h7D395T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E3B923A2B13E04D9DDCA2B2924A09B8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db53c129-cbcb-4ce8-18ae-08db6bd00981
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 05:35:45.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnCE0W/16l3c7O71EFPH5ZYNao/yXCqfp11W3zM+YocKa+kbRdMxSD0rNEoILXMw50BiPNRI6myJO+NsuYaDcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEd1aWxsYXVtZToNCg0KT24gTW9uLCAyMDIzLTA1LTI5IGF0IDE2OjMxICswMjAwLCBHdWls
bGF1bWUgUmFucXVldCB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZl
cmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBBZGRzIGhkbWkgYW5kIGhkbWkt
ZGRjIHN1cHBvcnQgZm9yIHYyIElQLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VpbGxhdW1lIFJh
bnF1ZXQgPGdyYW5xdWV0QGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+ICANCg0KW3NuaXBdDQoNCj4g
Kw0KPiArc3RhdGljIHVuc2lnbmVkIGNoYXINCj4gK2RkY21fcmVhZF9oZG1pKHN0cnVjdCBtdGtf
aGRtaV9kZGMgKmRkYywNCj4gKyAgICAgICB1bnNpZ25lZCBpbnQgdTRfY2xrX2RpdiwgdW5zaWdu
ZWQgY2hhciB1Y19kZXYsIHVuc2lnbmVkIGludA0KPiB1NF9hZGRyLA0KPiArICAgICAgIGVudW0g
c2lmX2JpdF90X2hkbWkgdWNfYWRkcl90eXBlLCB1bnNpZ25lZCBjaGFyICpwdWNfdmFsdWUsDQo+
ICsgICAgICAgdW5zaWduZWQgaW50IHU0X2NvdW50KQ0KPiArew0KPiArdTMyIHZhbDsNCj4gK3Vu
c2lnbmVkIGludCBpLCB0ZW1wX2xlbmd0aCwgbG9vcF9jb3VudGVyLCB1Y19yZWFkX2NvdW50LCB1
Y19pZHggPQ0KPiAwOw0KDQpJIHdvdWxkIGxpa2UgdGhlIHZhcmlhYmxlIG5hbWluZyBhcyBtdGtf
aGRtaV9kZGNfcmVhZF9tc2coKSBzbyB0aGF0DQppdCdzIGVhc3kgdG8gY29tcGFyZSB0aGlzIHR3
byBkcml2ZXIuIFNvIGRvZXMgdGhlIHZhcmlhYmxlIGNhbGN1bGF0aW5nDQp3YXkuDQoNCj4gKw0K
PiAraWYgKCFwdWNfdmFsdWUgfHwgIXU0X2NvdW50IHx8ICF1NF9jbGtfZGl2KQ0KPiArcmV0dXJu
IDA7DQo+ICsNCj4gK3VjX2lkeCA9IDA7DQo+ICtyZWdtYXBfcmVhZChkZGMtPnJlZ3MsIEhEQ1Ay
WF9ERENNX1NUQVRVUywgJnZhbCk7DQo+ICtpZiAodmFsICYgRERDX0kyQ19CVVNfTE9XKSB7DQo+
ICtyZWdtYXBfdXBkYXRlX2JpdHMoZGRjLT5yZWdzLCBERENfQ1RSTCwgRklFTERfUFJFUChERENf
Q01ELA0KPiBDTE9DS19TQ0wpLCBERENfQ01EKTsNCj4gK3VzbGVlcF9yYW5nZSgyNTAsIDMwMCk7
DQo+ICt9DQo+ICsNCj4gK3JlZ21hcF91cGRhdGVfYml0cyhkZGMtPnJlZ3MsIEREQ19DVFJMLCBG
SUVMRF9QUkVQKEREQ19DTUQsDQo+IENMRUFSX0ZJRk8pLCBERENfQ01EKTsNCj4gKw0KPiAraWYg
KHU0X2NvdW50ID49IDE2KSB7DQo+ICt0ZW1wX2xlbmd0aCA9IDE2Ow0KPiArbG9vcF9jb3VudGVy
ID0NCj4gK3U0X2NvdW50IC8gMTYgKyAodTRfY291bnQgJSAxNiA9PSAwKTsNCj4gK30gZWxzZSB7
DQo+ICt0ZW1wX2xlbmd0aCA9IHU0X2NvdW50Ow0KPiArbG9vcF9jb3VudGVyID0gMTsNCj4gK30N
Cj4gK2lmICh1Y19kZXYgPj0gRURJRF9JRCkgew0KPiAraWYgKHU0X2Nsa19kaXYgPCBEREMyX0NM
T0tfRURJRCkNCj4gK3U0X2Nsa19kaXYgPSBEREMyX0NMT0tfRURJRDsNCj4gK30NCj4gK3JlZ21h
cF91cGRhdGVfYml0cyhkZGMtPnJlZ3MsIEhQRF9ERENfQ1RSTCwNCj4gRklFTERfUFJFUChERENf
REVMQVlfQ05ULCB1NF9jbGtfZGl2KSwgRERDX0RFTEFZX0NOVCk7DQo+ICtmb3IgKGkgPSAwOyBp
IDwgbG9vcF9jb3VudGVyOyBpKyspIHsNCj4gK2lmIChpID09IChsb29wX2NvdW50ZXIgLSAxKSAm
JiBpICE9IDAgJiYNCj4gK3U0X2NvdW50ICUgMTYpDQo+ICt0ZW1wX2xlbmd0aCA9IHU0X2NvdW50
ICUgMTY7DQo+ICtpZiAodWNfZGV2ID4gRURJRF9JRCkgew0KPiArcmVnbWFwX3VwZGF0ZV9iaXRz
KGRkYy0+cmVncywgU0NEQ19DVFJMLCBGSUVMRF9QUkVQKEREQ19TRUdNRU5ULA0KPiB1Y19kZXYg
LSBFRElEX0lEKSwgRERDX1NFR01FTlQpOw0KPiArcmVnbWFwX3dyaXRlKGRkYy0+cmVncywgRERD
X0NUUkwsIEZJRUxEX1BSRVAoRERDX0NNRCwNCj4gRU5IX1JFQURfTk9fQUNLKSB8DQo+ICsgIEZJ
RUxEX1BSRVAoRERDX0RJTl9DTlQsIHRlbXBfbGVuZ3RoKSB8DQo+ICsgIEZJRUxEX1BSRVAoRERD
X09GRlNFVCwgdTRfYWRkciArIGkgKiB0ZW1wX2xlbmd0aCkgfA0KPiArICAoRURJRF9JRCA8PCAx
KSk7DQo+ICt9IGVsc2Ugew0KPiArcmVnbWFwX3dyaXRlKGRkYy0+cmVncywgRERDX0NUUkwsIEZJ
RUxEX1BSRVAoRERDX0NNRCwNCj4gU0VRX1JFQURfTk9fQUNLKSB8DQo+ICsgIEZJRUxEX1BSRVAo
RERDX0RJTl9DTlQsIHRlbXBfbGVuZ3RoKSB8DQo+ICsgIEZJRUxEX1BSRVAoRERDX09GRlNFVCwg
dTRfYWRkciArIGkgKiAxNikgfA0KPiArICAodWNfZGV2IDw8IDEpKTsNCj4gK30NCj4gK3VzbGVl
cF9yYW5nZSg1MDAwLCA1NTAwKTsNCj4gK2lmIChyZWdtYXBfcmVhZF9wb2xsX3RpbWVvdXQoZGRj
LT5yZWdzLCBIUERfRERDX1NUQVRVUywgdmFsLA0KPiArISh2YWwgJiBERENfSTJDX0lOX1BST0cp
LCAyMDAwLCB0ZW1wX2xlbmd0aCArIDUpKSB7DQo+ICtkZXZfZXJyKGRkYy0+ZGV2LCAidGltZSBv
dXQgd2FpdGluZyBmb3IgRERDIEkyQ1xuIik7DQo+ICtyZXR1cm4gMDsNCj4gK30NCj4gK3JlZ21h
cF9yZWFkKGRkYy0+cmVncywgSERDUDJYX0REQ01fU1RBVFVTLCAmdmFsKTsNCj4gK2lmICgodmFs
ICYgKEREQ19JMkNfTk9fQUNLIHwgRERDX0kyQ19CVVNfTE9XKSkpIHsNCj4gK3JlZ21hcF9yZWFk
KGRkYy0+cmVncywgSERDUDJYX0REQ01fU1RBVFVTLCAmdmFsKTsNCj4gK2lmICh2YWwgJiBERENf
STJDX0JVU19MT1cpIHsNCj4gK3JlZ21hcF91cGRhdGVfYml0cyhkZGMtPnJlZ3MsIEREQ19DVFJM
LA0KPiArIEZJRUxEX1BSRVAoRERDX0NNRCwgQ0xPQ0tfU0NMKSwgRERDX0NNRCk7DQo+ICt1c2xl
ZXBfcmFuZ2UoMjUwLCAzMDApOw0KPiArfQ0KPiArcmV0dXJuIDA7DQo+ICt9DQo+ICtmb3IgKHVj
X2lkeCA9IDA7IHVjX2lkeCA8IHRlbXBfbGVuZ3RoOyB1Y19pZHgrKykgew0KPiArcmVnbWFwX3dy
aXRlKGRkYy0+cmVncywgU0kyQ19DVFJMLA0KPiArICBGSUVMRF9QUkVQKFNJMkNfQUREUiwgU0ky
Q19BRERSX1JFQUQpIHwgU0kyQ19SRCk7DQo+ICtyZWdtYXBfd3JpdGUoZGRjLT5yZWdzLCBTSTJD
X0NUUkwsDQo+ICsgIEZJRUxEX1BSRVAoU0kyQ19BRERSLCBTSTJDX0FERFJfUkVBRCkgfCBTSTJD
X0NPTkZJUk1fUkVBRCk7DQo+ICtyZWdtYXBfcmVhZChkZGMtPnJlZ3MsIEhQRF9ERENfU1RBVFVT
LCAmdmFsKTsNCj4gK3B1Y192YWx1ZVtpICogMTYgKyB1Y19pZHhdID0gRklFTERfR0VUKEREQ19E
QVRBX09VVCwgdmFsKTsNCj4gKy8qDQo+ICsgKiB3aGVuIHJlYWRpbmcgZWRpZCwgaWYgaGRtaSBt
b2R1bGUgYmVlbiByZXNldCwNCj4gKyAqIGRkYyB3aWxsIGZhaWwgYW5kIGl0J3Mgc3BlZWQgd2ls
bCBiZSBzZXQgdG8gNDAwLg0KPiArICovDQo+ICtyZWdtYXBfcmVhZChkZGMtPnJlZ3MsIEhQRF9E
RENfQ1RSTCwgJnZhbCk7DQo+ICtpZiAoKCh2YWwgPj4gMTYpICYgMHhGRkZGKSA8IEREQzJfQ0xP
SykNCj4gK3JldHVybiAwOw0KPiArDQo+ICt1Y19yZWFkX2NvdW50ID0gaSAqIDE2ICsgdWNfaWR4
ICsgMTsNCj4gK30NCj4gK30NCj4gK3JldHVybiB1Y19yZWFkX2NvdW50Ow0KDQp1Y19yZWFkX2Nv
dW50IGlzIHU0X2NvdW50LCBpc24ndCBpdD8gU28geW91IGp1c3QgcmV0dXJuIHU0X2NvdW50IG9y
IDAsDQpzbyBJIHdvdWxkIGxpa2UgdG8gcmV0dXJuIDAgZm9yIHN1Y2Nlc3Mgb3IgZXJyb3IgY29k
ZS4NCg0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdW5zaWduZWQgY2hhciB2ZGRjX3JlYWQoc3RydWN0
IG10a19oZG1pX2RkYyAqZGRjLCB1bnNpZ25lZA0KPiBpbnQgdTRfY2xrX2RpdiwNCj4gKyAgICAg
ICB1bnNpZ25lZCBjaGFyIHVjX2RldiwgdW5zaWduZWQgaW50IHU0X2FkZHIsDQo+ICsgICAgICAg
ZW51bSBzaWZfYml0X3RfaGRtaSB1Y19hZGRyX3R5cGUsDQo+ICsgICAgICAgdW5zaWduZWQgY2hh
ciAqcHVjX3ZhbHVlLCB1bnNpZ25lZCBpbnQgdTRfY291bnQpDQo+ICt7DQo+ICt1bnNpZ25lZCBp
bnQgdTRfcmVhZF9jb3VudCA9IDA7DQo+ICt1bnNpZ25lZCBjaGFyIHVjX3JldHVybl92YWx1ZSA9
IDA7DQo+ICsNCj4gK2lmICghcHVjX3ZhbHVlIHx8ICF1NF9jb3VudCB8fCAhdTRfY2xrX2RpdiB8
fA0KPiArICAgIHVjX2FkZHJfdHlwZSA+IFNJRl8xNl9CSVRfSERNSSB8fA0KPiArICAgICh1Y19h
ZGRyX3R5cGUgPT0gU0lGXzhfQklUX0hETUkgJiYgdTRfYWRkciA+IDI1NSkgfHwNCj4gKyAgICAo
dWNfYWRkcl90eXBlID09IFNJRl8xNl9CSVRfSERNSSAmJiB1NF9hZGRyID4gNjU1MzUpKSB7DQo+
ICtyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAraWYgKHVjX2FkZHJfdHlwZSA9PSBTSUZfOF9CSVRf
SERNSSkNCj4gK3U0X3JlYWRfY291bnQgPSAyNTUgLSB1NF9hZGRyICsgMTsNCj4gK2Vsc2UgaWYg
KHVjX2FkZHJfdHlwZSA9PSBTSUZfMTZfQklUX0hETUkpDQo+ICt1NF9yZWFkX2NvdW50ID0gNjU1
MzUgLSB1NF9hZGRyICsgMTsNCj4gKw0KPiArdTRfcmVhZF9jb3VudCA9ICh1NF9yZWFkX2NvdW50
ID4gdTRfY291bnQpID8gdTRfY291bnQgOg0KPiB1NF9yZWFkX2NvdW50Ow0KDQoNCklmIHU0X3Jl
YWRfY291bnQgPCB1NF9jb3VudCwgdGhlIHJldHVybiB2YWx1ZSB3b3VsZCBub3QgYmUgdTRfY291
bnQsDQphbmQgdGhlIGNoZWNraW5nIGluIG10a19oZG1pX2RkY194ZmVyKCkgd291bGQgZmFpbC4g
SSB3b3VsZCBpdCdzIG5vdA0KbmVjZXNzYXJ5IHRvIGRvIHRoZSBuZXh0IHN0YXRlbWVudCwganVz
dCByZXR1cm4gMCBoZXJlLg0KSSdtIGN1cmlvdXMgYWJvdXQgd2h5IGRvIHRoaXM/IFdoeSBub3Qg
cmVhZCB1NF9jb3VudD8NCg0KUmVnYXJkcywNCkNLDQoNCj4gK3VjX3JldHVybl92YWx1ZSA9IGRk
Y21fcmVhZF9oZG1pKGRkYywgdTRfY2xrX2RpdiwgdWNfZGV2LCB1NF9hZGRyLA0KPiArIHVjX2Fk
ZHJfdHlwZSwgcHVjX3ZhbHVlLCB1NF9yZWFkX2NvdW50KTsNCj4gK3JldHVybiB1Y19yZXR1cm5f
dmFsdWU7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBib29sIGZnX2RkY19kYXRhX3JlYWQoc3RydWN0
IG10a19oZG1pX2RkYyAqZGRjLA0KPiArICAgICAgdW5zaWduZWQgY2hhciBiX2RldiwNCj4gKyAg
ICAgIHVuc2lnbmVkIGNoYXIgYl9kYXRhX2FkZHIsDQo+ICsgICAgICB1bnNpZ25lZCBjaGFyIGJf
ZGF0YV9jb3VudCwNCj4gKyAgICAgIHVuc2lnbmVkIGNoYXIgKnByX2RhdGEpDQo+ICt7DQo+ICtp
bnQgcmV0Ow0KPiArDQo+ICttdXRleF9sb2NrKCZkZGMtPm10eCk7DQo+ICsNCj4gK2hkbWlfZGRj
X3JlcXVlc3QoZGRjKTsNCj4gK3JldCA9IHZkZGNfcmVhZChkZGMsIEREQzJfQ0xPSywgYl9kZXYs
IGJfZGF0YV9hZGRyLCBTSUZfOF9CSVRfSERNSSwNCj4gKyAgICAgIHByX2RhdGEsIGJfZGF0YV9j
b3VudCk7DQo+ICttdXRleF91bmxvY2soJmRkYy0+bXR4KTsNCj4gKw0KPiArcmV0dXJuIHJldCA9
PSBiX2RhdGFfY291bnQ7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGZnX2RkY19kYXRhX3dy
aXRlKHN0cnVjdCBtdGtfaGRtaV9kZGMgKmRkYywNCj4gKyAgICAgICB1bnNpZ25lZCBjaGFyIGJf
ZGV2LA0KPiArICAgICAgIHVuc2lnbmVkIGNoYXIgYl9kYXRhX2FkZHIsDQo+ICsgICAgICAgdW5z
aWduZWQgY2hhciBiX2RhdGFfY291bnQsDQo+ICsgICAgICAgdW5zaWduZWQgY2hhciAqcHJfZGF0
YSkNCj4gK3sNCj4gK3Vuc2lnbmVkIGludCBpOw0KPiArDQo+ICttdXRleF9sb2NrKCZkZGMtPm10
eCk7DQo+ICsNCj4gK2hkbWlfZGRjX3JlcXVlc3QoZGRjKTsNCj4gK2ZvciAoaSA9IDA7IGkgPCBi
X2RhdGFfY291bnQ7IGkrKykNCj4gK210a19kZGNfd3Jfb25lKGRkYywgYl9kZXYsIGJfZGF0YV9h
ZGRyICsgaSwgKihwcl9kYXRhICsgaSkpOw0KPiArDQo+ICttdXRleF91bmxvY2soJmRkYy0+bXR4
KTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBtdGtfaGRtaV9kZGNfeGZlcihzdHJ1Y3QgaTJj
X2FkYXB0ZXIgKmFkYXB0ZXIsIHN0cnVjdA0KPiBpMmNfbXNnICptc2dzLA0KPiArICAgICBpbnQg
bnVtKQ0KPiArew0KPiArc3RydWN0IG10a19oZG1pX2RkYyAqZGRjID0gYWRhcHRlci0+YWxnb19k
YXRhOw0KPiArc3RydWN0IGRldmljZSAqZGV2ID0gYWRhcHRlci0+ZGV2LnBhcmVudDsNCj4gK2Jv
b2wgcmV0Ow0KPiAraW50IGk7DQo+ICt1bnNpZ25lZCBjaGFyIG9mZnNldDsNCj4gKw0KPiAraWYg
KCFkZGMpDQo+ICtyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArZm9yIChpID0gMDsgaSA8IG51bTsg
aSsrKSB7DQo+ICtzdHJ1Y3QgaTJjX21zZyAqbXNnID0gJm1zZ3NbaV07DQo+ICsNCj4gK2lmICht
c2ctPmZsYWdzICYgSTJDX01fUkQpIHsNCj4gKy8qIFRoZSB1bmRlcmx5aW5nIEREQyBoYXJkd2Fy
ZSBhbHdheXMgaXNzdWUgYSB3cml0ZSByZXF1ZXN0DQo+ICsgKiB0aGF0IGFzc2lnbnMgdGhlIHJl
YWQgb2Zmc2V0IGFzIHBhcnQgb2YgdGhlIHJlYWQgb3BlcmF0aW9uLg0KPiArICogVGhlcmVmb3Jl
IHdlIG5lZWQgdG8gdXNlIHRoZSBvZmZzZXQgdmFsdWUgYXNzaWduZWQNCj4gKyAqIGluIHRoZSBw
cmV2aW91cyB3cml0ZSByZXF1ZXN0IGZyb20gdGhlIGRybV9lZGlkLmMNCj4gKyAqLw0KPiArcmV0
ID0gZmdfZGRjX2RhdGFfcmVhZChkZGMsIG1zZy0+YWRkciwNCj4gKyAgICAgICBvZmZzZXQsIC8q
IGRldGVybWluZWQgYnkgcHJldmlvdXMgd3JpdGUgcmVxdWVzdHMgKi8NCj4gKyAgICAgICAobXNn
LT5sZW4pLCAmbXNnLT5idWZbMF0pOw0KPiAraWYgKCFyZXQpIHsNCj4gK2Rldl9lcnIoZGV2LCAi
ZGRjIHJlYWQgZmFpbGVkIDogJWRcbiIsIHJldCk7DQo+ICtyZXR1cm4gcmV0Ow0KPiArfQ0KPiAr
fSBlbHNlIHsNCj4gK2ZnX2RkY19kYXRhX3dyaXRlKGRkYywgbXNnLT5hZGRyLCBtc2ctPmJ1Zlsw
XSwNCj4gKyhtc2ctPmxlbiAtIDEpLCAmbXNnLT5idWZbMV0pOw0KPiArDQo+ICsvKiB3ZSBzdG9y
ZSB0aGUgb2Zmc2V0IHZhbHVlIHJlcXVlc3RlZCBieSBkcm1fZWRpZCBmcmFtZXdvcmsNCj4gKyAq
IHRvIHVzZSBpbiBzdWJzZXF1ZW50IHJlYWQgcmVxdWVzdHMuDQo+ICsgKi8NCj4gK2lmIChERENf
QUREUiA9PSBtc2ctPmFkZHIgJiYgMSA9PSBtc2ctPmxlbikNCj4gK29mZnNldCA9IG1zZy0+YnVm
WzBdOw0KPiArfQ0KPiArfQ0KPiArDQo+ICtyZXR1cm4gaTsNCj4gK30NCj4gKw0KPiANCg==
