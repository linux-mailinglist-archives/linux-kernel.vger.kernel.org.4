Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5665B9EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 05:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjACEGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 23:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACEGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 23:06:44 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17C0B99;
        Mon,  2 Jan 2023 20:06:38 -0800 (PST)
X-UUID: b6389961df0944bf848fbabc8d388b8f-20230103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8trfwv4DbgchhkqPLnZUJAshWySHJg7hXL3RQtki2lk=;
        b=H0IgnWRc1/Gu/kjO0RmclC1MRT1FHmOkAQSi+Rxd5Y9A9lNa4rwFIwuUxsIRkYD0fwjL04NE7NAB6oVRRiGdxVQvqVETdhsHjCKlDodvBEmkwY2T5zviuXhi9gaD3Bu8589+WRAMXyuEYlVShKe0HTG/HUJoaZHAf5I2PPQVbWM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:bf534e7e-c9fa-4658-8e38-e1b28027598b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:09771b1,CLOUDID:f6069df4-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: b6389961df0944bf848fbabc8d388b8f-20230103
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1311122031; Tue, 03 Jan 2023 12:06:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 3 Jan 2023 12:06:32 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 3 Jan 2023 12:06:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtkV7tWEsZQgbfisanOo3PQoflk9VZXuCpqH9mnhOUUbzBmUkC8WvFoEqqAU0RoE29uFvPILsgOSDz5J5cuQMOo+WNpLKh285Jo9CzKQpGd6OLxTjJAvKpy2BmC1af6X09LABXnvsL5Jgs+IUJmGRmVZ6i+abGzqh6dEZ4Jf+D40kAfFtCM1Qz1Mzu9LgAOyFrC7PGcC2dlXZd/986wJ99knbRikUPl/vYST7ySuskujNk9Qm6zE9unIvz/diqQLTDWuz4T1fiJORBq9RLP3HLz2+Lq53UkhLnuVtuZqV83znAsqI9puC1nAZJFlALQT0G6A5b7PTHGNc5AIzxBxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8trfwv4DbgchhkqPLnZUJAshWySHJg7hXL3RQtki2lk=;
 b=KKt9x8jau+xS/7gN9zy4/ulSKNw2b3nxncsTgYC9y1v+8DVmQSFshpDG93SRd1SGRRse5sYeZpkwwYuv784AmChvP+lYrlmEJ38cCTW+Te6Ww9b00k41e8A+XElycXIkP1tnRszjQE7WhPeVA1k6RcuzrpfLoZXMSKmp5qwOn6NKhO4ss8j33WxpFr0gcaafx0PJeSwLTzDL4Z0sIQtgKUcB85zJiWGL3TLsWSydzHBu/Ox+UmQ/yc5tHbxBtirfo0Qq6Di77YlF2JWKbzLVIV0pFUktKwJgIB1NXuocyDWNYczJgtxqV/L9dBbZ/CYkn7NjXC9FJ8XlWXAe5q8DVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8trfwv4DbgchhkqPLnZUJAshWySHJg7hXL3RQtki2lk=;
 b=mhGaP6ds+p8PKy0d2h8UCNMQ6HqkxSq5pmpJ2xKC6kAASGFL/zrMn38glihQTVzw4iRPKOqueo5MslpqmqTXbrnagtLmXGY9X3WHibiARKmDGDc6hSeuxatCxMhjsKNsPc0iET222YUhGRRrIqyvqPHWxMElZZVcyxKBDnPoQnY=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SI2PR03MB5802.apcprd03.prod.outlook.com (2603:1096:4:142::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 04:06:29 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 04:06:29 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 05/13] ASoC: mediatek: mt8188: support etdm in platform
 driver
Thread-Topic: [PATCH v4 05/13] ASoC: mediatek: mt8188: support etdm in
 platform driver
Thread-Index: AQHZHBOEAYI9SSjDfUKQIrG9L/nuMa6LLhGAgADrRwA=
Date:   Tue, 3 Jan 2023 04:06:29 +0000
Message-ID: <98252c70856919ef1b5b6716d9fa88d9c0a24c35.camel@mediatek.com>
References: <20221230055443.16024-1-trevor.wu@mediatek.com>
         <20221230055443.16024-6-trevor.wu@mediatek.com>
         <6309e7c5-f740-fa22-bdf0-937187b19285@collabora.com>
In-Reply-To: <6309e7c5-f740-fa22-bdf0-937187b19285@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SI2PR03MB5802:EE_
x-ms-office365-filtering-correlation-id: 831b99f5-6bec-4582-881e-08daed3fe42e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TvsJlUD5NrgTMBbcOQ5rn2RR4vIj0/g4XC548NFlmVeMTSBR+yY673vLWbQ4tYkqMuVYO/85Cxm2umoCxogwQHsnYWJvznii6ysXsOCIE7MLAuEyEs0dzW1AJdFJ29w/uoR2hHtO3LkBiFLbB1UBT2vmUQAqvMzZJKcYV1AADGE2EkQNtMDjf2ycCc5IVfdnTNwpQw+3kmAfFSu3iCBRp2Hw9EAje5ubXyKxFO//MWpwbC9Nok4udtDAjEiiiCwsodT3ELjsf7OvkGmC2zBJn46ZL/098FWmrPjbzgHpd3l1xNvygh4yXNwxHBlPv8pVkP2p4IVf+Ao8NmF0nH6bnkdl28UlJJ5mh94US48jMfYfAWFD7iYIzRK9J66dyW1omuJkonM6iLf/o2rQJfrsA9+YC5vXJixr5eV/XJ5FeFxubAzVc5F1vGbO2PHeGBpqX8gxgN0rTYWIpqoDwl8b5U6OsbGhNctHg/BKJFz0fllt+ZnhrHpZo9CWqmipxlU12GwErKROvBSLbTl76W45SH85WtD8+OE3+6ge16MRZKTLVRELyZD97/pIpbLvjzqC4ZY4jr7ssWgFFqeYc7yjNlqHobNYSlM7VlCNapEpQj+NmeKHdvwpDEQlBY1jCKn2Zgyh8LA2ohRKLlp8/4yXLSsmRAAP93vthDT95zYcMGUjsYOUXRgn4m/8s5eLBgdZFWRgRdyJ2I4RZ0SbM2XbudneXKLT7rFaiOrcmBVW+4SHjncUBAKZOuN0q00ktPGbIK8jH7UI+aKyIFqapCbBW5bOAYGD1fIwIGBm2JTFB2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(7416002)(41300700001)(91956017)(66446008)(66476007)(8676002)(64756008)(66946007)(66556008)(76116006)(54906003)(2906002)(5660300002)(110136005)(8936002)(4326008)(6506007)(71200400001)(6486002)(478600001)(6512007)(186003)(26005)(86362001)(2616005)(83380400001)(85182001)(38100700002)(36756003)(38070700005)(122000001)(316002)(22166006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2ZBRlI4VkR0NkNBRzlBcExVMVBJY1Vtdm9tMGNDeTl6ajNtandQTllzdG5Z?=
 =?utf-8?B?TGZwRXNjcm9vYzNLSW5NRVJQbFpVRTFkanNWaktQaW5paXZ5V1ZJZjZlbDRW?=
 =?utf-8?B?azEzdzRVcXk0dnZGa1loUzVsT0tBbW0veGZZQVpIdGRYcEoxWDZROXBaQzB0?=
 =?utf-8?B?RGl5bys5bmtLUGhpRHdVdTVFYk5GQTcwUmtBdFp3UjVRN2U0ZzdUSXVibFFj?=
 =?utf-8?B?UHk2SmtEa3B2bURFRkNXVU5qcWNVTlJieWJ4TjBleGNxLzl2dEtBdnlLZHYy?=
 =?utf-8?B?cHNORGtZTS9MaU1vcnF3MkJVVlJ4ZzlEbzlJa3JhY1hmOFhvLzNQUHF0Tk93?=
 =?utf-8?B?elhuK014UkdCYWtOSVV0TmNNa0Q3UlY5R3MrS2dFZktqSzVKWFNTWHlnd3ZD?=
 =?utf-8?B?TVM3UWVWQ1I2TVl6TjlySE1WeXdVMHhrdE52bHR4K0pNTWJNVGJXbkRaZHlj?=
 =?utf-8?B?REd5VXJDYkJ1MTV5aHlpWHUvRS9BNjZYS0NDQk9YZWdKQnpKMTVwM0EzT3lE?=
 =?utf-8?B?alQ2TENzWlYrNEkwSlVCL0NWT3B2eWV0a0Q2YnhsVDdaczBnVkM5cC9peFRi?=
 =?utf-8?B?eitTcFdLY29WVDhZS1hMMUVSWTcwajBHNzVRZzU4NG9xa01TVmJNSmlLWEdl?=
 =?utf-8?B?UE55WXVQU2Z1aW5QM0VwMWhlTUszR1oxSWVETitWVStTczhWbWlMaWJnMDFB?=
 =?utf-8?B?MDZmYlBpcExhU1NrR0UyQVIydFl3WkVVZGhJTy9pUmhNU1pXMnFqYmc1eXgz?=
 =?utf-8?B?RHllNGxGdHRyK1RtUUxzbDM4QTZRTWorZWVtWlNlaTRFT2p4MWtqU1dkbmhB?=
 =?utf-8?B?eElDWDhqdC9oMXpxMHphR1lKZlM5U0NudXFhTWRyTmdRa2xnMmN0ZnJQQjhE?=
 =?utf-8?B?ZzJLejRFaVBqMzF1Nm4xT3RyN2hPODNsN0tGWFAyYjVnSkQ3aDE1Z3NkaDZr?=
 =?utf-8?B?WVFKK1prUDlEU0RNaCtrelJqRnJrZGY2NTNCckxYYU05S3BTdjZJRENyTkY1?=
 =?utf-8?B?aUE0SE9Wck8yK0ZKbUhHSG0rNExxNzlQaVNZSkh1ZFhCYy9OZDd6c1FDbTl0?=
 =?utf-8?B?LzRiZkVaVkV2bUJOSnM0TFlzWGQ3M1c3WkUzU2JJUUcvSUlFdEE4YWtOTHpq?=
 =?utf-8?B?SHk0UWxYd2tweDh3YWRvREthUUhGWUNHczRBbmh3RmVBeW5aTTJuRXJrWHY1?=
 =?utf-8?B?TDM3OHRZMzh2UExCU3VhWXZOT0UrNnY0V1dXMGd3ZHdvMTR5SzBIZlp5RDUy?=
 =?utf-8?B?NWJMa2lFdVFrMUxrc1pnQ0lIblNaV1FqVFB5YW9nNGFlRTRHb0hmMUhqSThZ?=
 =?utf-8?B?SHp4dTQvRW9vQWluM0g0akhqZ2R3aWVkblZWeHhwN1g1SUNyUW1yVVdYaEN5?=
 =?utf-8?B?T0N1c1oyeDVOclgyeGp6OVplSUNnRDYrdWJHaTYvaUp4enh5UjZEcmFEWldn?=
 =?utf-8?B?VWpGbkVYYXd0YU9aOTdQNTNQQmNDc3V3NzlKcGpTZUJYNDFFd0lZdGp6cTZ3?=
 =?utf-8?B?STB0aWdoZ1Z6RFc4ZWJkdWoyNGRZNklFSUtjRG5udmd1SUcxT2VSRWVXT0xq?=
 =?utf-8?B?YjdFeDU5UDkvdzYxZFlYdGNPOW93U283V0RITndlbmdjVXcxU1g2REtJdGxl?=
 =?utf-8?B?c2hHMVBYdVFMTDNiUm0zNGxLcDZQT3Jxa1dvL0JiNHF3MnBzNXRlUVhrZEYr?=
 =?utf-8?B?aE44dVErcGxsQTZJbVI2YTgrWGdEcy8zNnNjbEw1VjRsbG9ZSlQ1ejRPUmFt?=
 =?utf-8?B?a2J0QWt3NFFMeWswN2F2NFNqSUhjc0ZiSThZckhEWTdLVVZVd3RPSHJrbHFO?=
 =?utf-8?B?RUJBd00zNWliY0QxZ3gvTTVZUjNjTFczN1ROWndYOXR4NlVaTWFEbkJaTEgw?=
 =?utf-8?B?bFlQMGdYYWEyOHRSa2t6aEdTTDNBaVJTdG51VTZqL2lEWlJpa2Urd3k4L0lP?=
 =?utf-8?B?dFpOSmxjSE15VkVraW8yQllOUkVuUHd2cnZoSXRJSi9BSXY2NHJpSHZOdHpP?=
 =?utf-8?B?c29UdFJwUWNaT1BHN0tuT2lVNUpUNUVkd1BLcENXd0ZrN3pReDlVMzVvRDRG?=
 =?utf-8?B?K2x0L09yVXVISjErcjM0T1VTMTQ2bTFYRndrRVhodlZwQkxKeTlzZ0pSUGdC?=
 =?utf-8?B?Wms0T3UwNlVsWUM3UzFoZ24vN3B5dU5xQWtQQkRLYW04NkY0MmREalU3dXZ2?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D050A3377F370241B24CE7B91A77B7B9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831b99f5-6bec-4582-881e-08daed3fe42e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 04:06:29.3011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysVglMkemgD/5vZ5Wi9LGe+gl4UffQ5pdplJ07+PE/ifn5lf6PR5Od+QU4jmgjZXlvzCj7Sca3T7AtYdcZBi5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5802
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

T24gTW9uLCAyMDIzLTAxLTAyIGF0IDE1OjA0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMzAvMTIvMjIgMDY6NTQsIFRyZXZvciBXdSBoYSBzY3JpdHRvOg0K
PiA+IEFkZCBtdDgxODggZXRkbSBkYWkgZHJpdmVyIHN1cHBvcnQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogVHJldm9yIFd1IDx0cmV2b3Iud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
ICAgc291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtZGFpLWV0ZG0uYyB8IDI1OTENCj4g
PiArKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjU5MSBpbnNlcnRp
b25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgc291bmQvc29jL21lZGlhdGVrL210ODE4
OC9tdDgxODgtZGFpLWV0ZG0uYw0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVk
aWF0ZWsvbXQ4MTg4L210ODE4OC1kYWktZXRkbS5jDQo+ID4gYi9zb3VuZC9zb2MvbWVkaWF0ZWsv
bXQ4MTg4L210ODE4OC1kYWktZXRkbS5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBp
bmRleCAwMDAwMDAwMDAwMDAuLmY4ZTY5ZDY1NTcwNg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiAr
KysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1kYWktZXRkbS5jDQo+ID4gQEAg
LTAsMCArMSwyNTkxIEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
DQo+ID4gKy8qDQo+ID4gKyAqIE1lZGlhVGVrIEFMU0EgU29DIEF1ZGlvIERBSSBlVERNIENvbnRy
b2wNCj4gPiArICoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDIyIE1lZGlhVGVrIEluYy4NCj4g
PiArICogQXV0aG9yOiBCaWN5Y2xlIFRzYWkgPGJpY3ljbGUudHNhaUBtZWRpYXRlay5jb20+DQo+
ID4gKyAqICAgICAgICAgVHJldm9yIFd1IDx0cmV2b3Iud3VAbWVkaWF0ZWsuY29tPg0KPiA+ICsg
KiAgICAgICAgIENodW4tQ2hpYSBDaGl1IDxjaHVuLWNoaWEuY2hpdUBtZWRpYXRlay5jb20+DQo+
ID4gKyAqLw0KPiA+ICsNCj4gDQo+IC4uc25pcC4uDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIGlu
dCBtdGtfZGFpX2V0ZG1fZ2V0X2Nsa2Rpdl9pZF9ieV9kYWlfaWQoaW50IGRhaV9pZCkNCj4gPiAr
ew0KPiA+ICsJaW50IGNsa19pZCA9IC0xOw0KPiA+ICsNCj4gPiArCXN3aXRjaCAoZGFpX2lkKSB7
DQo+ID4gKwljYXNlIE1UODE4OF9BRkVfSU9fRFBUWDoNCj4gPiArCQljbGtfaWQgPSBNVDgxODhf
Q0xLX1RPUF9BUExMMTJfRElWOTsNCj4gDQo+IAkJcmV0dXJuIE1UODE4OF9DTEtfVE9QX0FQTEwx
Ml9ESVZfOTsNCj4gDQo+ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIE1UODE4OF9BRkVfSU9fRVRE
TTFfSU46DQo+ID4gKwkJY2xrX2lkID0gTVQ4MTg4X0NMS19UT1BfQVBMTDEyX0RJVjA7DQo+IA0K
PiAJCXJldHVybiBNVDgxODhfQ0xLX1RPUF9BUExMMTJfRElWMDsNCj4gDQo+ID4gKwkJYnJlYWs7
DQo+ID4gKwljYXNlIE1UODE4OF9BRkVfSU9fRVRETTJfSU46DQo+ID4gKwkJY2xrX2lkID0gTVQ4
MTg4X0NMS19UT1BfQVBMTDEyX0RJVjE7DQo+IA0KPiByZXR1cm4gLi4uLi4NCj4gDQo+ID4gKwkJ
YnJlYWs7DQo+ID4gKwljYXNlIE1UODE4OF9BRkVfSU9fRVRETTFfT1VUOg0KPiA+ICsJCWNsa19p
ZCA9IE1UODE4OF9DTEtfVE9QX0FQTEwxMl9ESVYyOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2Fz
ZSBNVDgxODhfQUZFX0lPX0VURE0yX09VVDoNCj4gPiArCQljbGtfaWQgPSBNVDgxODhfQ0xLX1RP
UF9BUExMMTJfRElWMzsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgTVQ4MTg4X0FGRV9JT19F
VERNM19PVVQ6DQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJfQ0KPiA+ICsN
Cj4gPiArCXJldHVybiBjbGtfaWQ7DQo+IA0KPiAJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAuLi5z
byB5b3UgZG9uJ3QgbmVlZCBjbGtfaWQgYXQgYWxsIDotKQ0KPiANCj4gPiArfQ0KPiA+ICsNCj4g
DQo+IC4uc25pcC4uDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtdGtfZGFpX2V0ZG1fbWNs
a19jb25maWd1cmUoc3RydWN0IG10a19iYXNlX2FmZSAqYWZlLA0KPiA+IGludCBkYWlfaWQpDQo+
ID4gK3sNCj4gPiArCXN0cnVjdCBtdDgxODhfYWZlX3ByaXZhdGUgKmFmZV9wcml2ID0gYWZlLT5w
bGF0Zm9ybV9wcml2Ow0KPiA+ICsJc3RydWN0IG10a19kYWlfZXRkbV9wcml2ICpldGRtX2RhdGE7
DQo+ID4gKwlpbnQgY2xrX2lkID0gbXRrX2RhaV9ldGRtX2dldF9jbGtfaWRfYnlfZGFpX2lkKGRh
aV9pZCk7DQo+ID4gKwlpbnQgY2xrZGl2X2lkID0gbXRrX2RhaV9ldGRtX2dldF9jbGtkaXZfaWRf
YnlfZGFpX2lkKGRhaV9pZCk7DQo+ID4gKwlpbnQgYXBsbDsNCj4gPiArCWludCBhcGxsX2Nsa19p
ZDsNCj4gPiArCXN0cnVjdCBldGRtX2Nvbl9yZWcgZXRkbV9yZWc7DQo+ID4gKwlpbnQgcmV0ID0g
MDsNCj4gPiArDQo+ID4gKwlpZiAoY2xrX2lkIDwgMCB8fCBjbGtkaXZfaWQgPCAwKQ0KPiA+ICsJ
CXJldHVybiAwOw0KPiA+ICsNCj4gPiArCWlmICghaXNfdmFsaWRfZXRkbV9kYWkoZGFpX2lkKSkN
Cj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCWV0ZG1fZGF0YSA9IGFmZV9wcml2LT5kYWlf
cHJpdltkYWlfaWRdOw0KPiA+ICsNCj4gPiArCXJldCA9IGdldF9ldGRtX3JlZyhkYWlfaWQsICZl
dGRtX3JlZyk7DQo+ID4gKwlpZiAocmV0IDwgMCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsN
Cj4gPiArCWlmIChldGRtX2RhdGEtPm1jbGtfZGlyID09IFNORF9TT0NfQ0xPQ0tfT1VUKQ0KPiA+
ICsJCXJlZ21hcF9zZXRfYml0cyhhZmUtPnJlZ21hcCwgZXRkbV9yZWcuY29uMSwNCj4gPiArCQkJ
CUVURE1fQ09OMV9NQ0xLX09VVFBVVCk7DQo+ID4gKwllbHNlDQo+ID4gKwkJcmVnbWFwX2NsZWFy
X2JpdHMoYWZlLT5yZWdtYXAsIGV0ZG1fcmVnLmNvbjEsDQo+ID4gKwkJCQkgIEVURE1fQ09OMV9N
Q0xLX09VVFBVVCk7DQo+ID4gKw0KPiA+ICsJaWYgKGV0ZG1fZGF0YS0+bWNsa19mcmVxKSB7DQo+
ID4gKwkJYXBsbCA9IGV0ZG1fZGF0YS0+bWNsa19hcGxsOw0KPiA+ICsJCWFwbGxfY2xrX2lkID0g
bXQ4MTg4X2FmZV9nZXRfbWNsa19zb3VyY2VfY2xrX2lkKGFwbGwpOw0KPiA+ICsJCWlmIChhcGxs
X2Nsa19pZCA8IDApDQo+ID4gKwkJCXJldHVybiBhcGxsX2Nsa19pZDsNCj4gPiArDQo+ID4gKwkJ
Lyogc2VsZWN0IGFwbGwgKi8NCj4gPiArCQlyZXQgPSBtdDgxODhfYWZlX3NldF9jbGtfcGFyZW50
KGFmZSwgYWZlX3ByaXYtDQo+ID4gPmNsa1tjbGtfaWRdLA0KPiA+ICsJCQkJCQlhZmVfcHJpdi0N
Cj4gPiA+Y2xrW2FwbGxfY2xrX2lkXSk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJu
IHJldDsNCj4gPiArDQo+ID4gKwkJLyogc2V0IHJhdGUgKi8NCj4gPiArCQlyZXQgPSBtdDgxODhf
YWZlX3NldF9jbGtfcmF0ZShhZmUsIGFmZV9wcml2LQ0KPiA+ID5jbGtbY2xrZGl2X2lkXSwNCj4g
PiArCQkJCQkgICAgICBldGRtX2RhdGEtPm1jbGtfZnJlcSk7DQo+IA0KPiBDaGVjayByZXQgaGVy
ZS4uLg0KPiANCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJaWYgKGV0ZG1fZGF0YS0+bWNsa19kaXIg
PT0gU05EX1NPQ19DTE9DS19PVVQpDQo+ID4gKwkJCWRldl9kYmcoYWZlLT5kZXYsICIlcyBtY2xr
IGZyZXEgPSAwXG4iLA0KPiA+IF9fZnVuY19fKTsNCj4gPiArCX0NCj4gPiArDQo+IA0KPiAuLi5h
bmQgcmV0dXJuIDAgaGVyZS4NCj4gDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0K
PiANCj4gLi5zbmlwLi4NCj4gDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10a19kYWlfZXRkbV9o
d19wYXJhbXMoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtDQo+ID4gKnN1YnN0cmVhbSwNCj4gPiAr
CQkJCSAgc3RydWN0IHNuZF9wY21faHdfcGFyYW1zICpwYXJhbXMsDQo+ID4gKwkJCQkgIHN0cnVj
dCBzbmRfc29jX2RhaSAqZGFpKQ0KPiA+ICt7DQo+ID4gKwlpbnQgcmV0ID0gMDsNCj4gPiArCXVu
c2lnbmVkIGludCByYXRlID0gcGFyYW1zX3JhdGUocGFyYW1zKTsNCj4gPiArCXVuc2lnbmVkIGlu
dCBiaXRfd2lkdGggPSBwYXJhbXNfd2lkdGgocGFyYW1zKTsNCj4gPiArCXVuc2lnbmVkIGludCBj
aGFubmVscyA9IHBhcmFtc19jaGFubmVscyhwYXJhbXMpOw0KPiA+ICsJc3RydWN0IG10a19iYXNl
X2FmZSAqYWZlID0gc25kX3NvY19kYWlfZ2V0X2RydmRhdGEoZGFpKTsNCj4gPiArCXN0cnVjdCBt
dDgxODhfYWZlX3ByaXZhdGUgKmFmZV9wcml2ID0gYWZlLT5wbGF0Zm9ybV9wcml2Ow0KPiA+ICsJ
c3RydWN0IG10a19kYWlfZXRkbV9wcml2ICptc3RfZXRkbV9kYXRhOw0KPiA+ICsJaW50IG1zdF9k
YWlfaWQ7DQo+ID4gKwlpbnQgc2x2X2RhaV9pZDsNCj4gPiArCWludCBpOw0KPiA+ICsNCj4gPiAr
CWRldl9kYmcoYWZlLT5kZXYsICIlcyAnJXMnIHBlcmlvZCAldS0ldVxuIiwNCj4gPiArCQlfX2Z1
bmNfXywgc25kX3BjbV9zdHJlYW1fc3RyKHN1YnN0cmVhbSksDQo+ID4gKwkJcGFyYW1zX3Blcmlv
ZF9zaXplKHBhcmFtcyksIHBhcmFtc19wZXJpb2RzKHBhcmFtcykpOw0KPiA+ICsNCj4gPiArCWlm
IChpc19jb3dvcmtfbW9kZShkYWkpKSB7DQo+ID4gKwkJbXN0X2RhaV9pZCA9IGdldF9ldGRtX2Nv
d29ya19tYXN0ZXJfaWQoZGFpKTsNCj4gPiArCQlpZiAoIWlzX3ZhbGlkX2V0ZG1fZGFpKG1zdF9k
YWlfaWQpKQ0KPiA+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwkJcmV0ID0gbXRr
X2RhaV9ldGRtX21jbGtfY29uZmlndXJlKGFmZSwgbXN0X2RhaV9pZCk7DQo+ID4gKwkJaWYgKHJl
dCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkJcmV0ID0gbXRrX2RhaV9ldGRt
X2NvbmZpZ3VyZShhZmUsIHJhdGUsIGNoYW5uZWxzLA0KPiA+ICsJCQkJCSAgICAgYml0X3dpZHRo
LCBtc3RfZGFpX2lkKTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+
ICsNCj4gPiArCQltc3RfZXRkbV9kYXRhID0gYWZlX3ByaXYtPmRhaV9wcml2W21zdF9kYWlfaWRd
Ow0KPiA+ICsJCWZvciAoaSA9IDA7IGkgPCBtc3RfZXRkbV9kYXRhLT5jb3dvcmtfc2x2X2NvdW50
OyBpKyspIHsNCj4gPiArCQkJc2x2X2RhaV9pZCA9IG1zdF9ldGRtX2RhdGEtPmNvd29ya19zbHZf
aWRbaV07DQo+ID4gKwkJCXJldCA9IG10a19kYWlfZXRkbV9jb25maWd1cmUoYWZlLCByYXRlLA0K
PiA+IGNoYW5uZWxzLA0KPiA+ICsJCQkJCQkgICAgIGJpdF93aWR0aCwNCj4gPiBzbHZfZGFpX2lk
KTsNCj4gPiArCQkJaWYgKHJldCkNCj4gPiArCQkJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJ
CQlyZXQgPSBtdDgxODhfZXRkbV9zeW5jX21vZGVfY29uZmlndXJlKGFmZSwNCj4gPiBzbHZfZGFp
X2lkKTsNCj4gPiArCQkJaWYgKHJldCkNCj4gPiArCQkJCXJldHVybiByZXQ7DQo+ID4gKwkJfQ0K
PiA+ICsJfSBlbHNlIHsNCj4gPiArCQlyZXQgPSBtdGtfZGFpX2V0ZG1fbWNsa19jb25maWd1cmUo
YWZlLCBkYWktPmlkKTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+
ICsNCj4gPiArCQlyZXQgPSBtdGtfZGFpX2V0ZG1fY29uZmlndXJlKGFmZSwgcmF0ZSwgY2hhbm5l
bHMsDQo+ID4gKwkJCQkJICAgICBiaXRfd2lkdGgsIGRhaS0+aWQpOw0KPiANCj4gQ2hlY2sgcmV0
dXJuIHZhbHVlIGhlcmUuLi4NCj4gDQo+ID4gKwl9DQo+ID4gKw0KPiANCj4gLi4uYW5kIHJldHVy
biAwIGhlcmUuDQo+IA0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3Rh
dGljIGludCBtdGtfZGFpX2V0ZG1fcHJlcGFyZShzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0NCj4g
PiAqc3Vic3RyZWFtLA0KPiA+ICsJCQkJc3RydWN0IHNuZF9zb2NfZGFpICpkYWkpDQo+ID4gK3sN
Cj4gPiArCXN0cnVjdCBtdGtfYmFzZV9hZmUgKmFmZSA9IHNuZF9zb2NfZGFpX2dldF9kcnZkYXRh
KGRhaSk7DQo+ID4gKwlzdHJ1Y3QgbXQ4MTg4X2FmZV9wcml2YXRlICphZmVfcHJpdiA9IGFmZS0+
cGxhdGZvcm1fcHJpdjsNCj4gPiArCXN0cnVjdCBtdGtfZGFpX2V0ZG1fcHJpdiAqbXN0X2V0ZG1f
ZGF0YTsNCj4gPiArCWludCBtc3RfZGFpX2lkOw0KPiA+ICsJaW50IHNsdl9kYWlfaWQ7DQo+ID4g
KwlpbnQgaTsNCj4gPiArCWludCByZXQgPSAwOw0KPiA+ICsNCj4gPiArCWlmICghaXNfdmFsaWRf
ZXRkbV9kYWkoZGFpLT5pZCkpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwltc3RfZXRk
bV9kYXRhID0gYWZlX3ByaXYtPmRhaV9wcml2W2RhaS0+aWRdOw0KPiA+ICsNCj4gPiArCWRldl9k
YmcoYWZlLT5kZXYsICIlcygpLCBkYWkgaWQgJWQsIHByZXBhcmVkICVkXG4iLCBfX2Z1bmNfXywN
Cj4gPiBkYWktPmlkLA0KPiA+ICsJCW1zdF9ldGRtX2RhdGEtPmlzX3ByZXBhcmVkKTsNCj4gPiAr
DQo+ID4gKwlpZiAobXN0X2V0ZG1fZGF0YS0+aXNfcHJlcGFyZWQpDQo+ID4gKwkJcmV0dXJuIDA7
DQo+ID4gKw0KPiA+ICsJbXN0X2V0ZG1fZGF0YS0+aXNfcHJlcGFyZWQgPSB0cnVlOw0KPiA+ICsN
Cj4gPiArCWlmIChpc19jb3dvcmtfbW9kZShkYWkpKSB7DQo+ID4gKwkJbXN0X2RhaV9pZCA9IGdl
dF9ldGRtX2Nvd29ya19tYXN0ZXJfaWQoZGFpKTsNCj4gPiArCQlpZiAoIWlzX3ZhbGlkX2V0ZG1f
ZGFpKG1zdF9kYWlfaWQpKQ0KPiA+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCQltc3RfZXRk
bV9kYXRhID0gYWZlX3ByaXYtPmRhaV9wcml2W21zdF9kYWlfaWRdOw0KPiA+ICsNCj4gPiArCQlm
b3IgKGkgPSAwOyBpIDwgbXN0X2V0ZG1fZGF0YS0+Y293b3JrX3Nsdl9jb3VudDsgaSsrKSB7DQo+
ID4gKwkJCXNsdl9kYWlfaWQgPSBtc3RfZXRkbV9kYXRhLT5jb3dvcmtfc2x2X2lkW2ldOw0KPiA+
ICsJCQlyZXQgfD0gbXQ4MTg4X2FmZV9lbmFibGVfZXRkbShhZmUsIHNsdl9kYWlfaWQpOw0KPiA+
ICsJCX0NCj4gPiArDQo+ID4gKwkJcmV0IHw9IG10ODE4OF9hZmVfZW5hYmxlX2V0ZG0oYWZlLCBt
c3RfZGFpX2lkKTsNCj4gDQo+IE9SJ2luZyByZXR1cm4gdmFsdWVzIGlzIG5vdCBhbiBhY2NlcHRh
YmxlIHByYWN0aWNlOiB5b3Ugc2hvdWxkIGNoZWNrDQo+IGZvciBlcnJvcg0KPiByaWdodCBhZnRl
ciB0aGUgY2FsbCBhbmQgaW1tZWRpYXRlbHkgdGFrZSBhY3Rpb24gaWYgYW55dGhpbmcgd3JvbmcN
Cj4gaGFwcGVuZWQuDQo+IA0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlyZXQgPSBtdDgxODhfYWZl
X2VuYWJsZV9ldGRtKGFmZSwgZGFpLT5pZCk7DQo+IA0KPiBTYW1lIGNvbW1lbnQgYXMgdGhlIHBy
ZXZpb3VzIGZ1bmN0aW9uOiBjaGVjayByZXQgaGVyZS4NCj4gDQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gDQo+IC4uc25pcC4uDQo+IA0KPiA+ICsN
Cj4gPiArc3RhdGljIGludCBtdGtfZGFpX2hkbWl0eF9kcHR4X3ByZXBhcmUoc3RydWN0IHNuZF9w
Y21fc3Vic3RyZWFtDQo+ID4gKnN1YnN0cmVhbSwNCj4gPiArCQkJCSAgICAgICBzdHJ1Y3Qgc25k
X3NvY19kYWkgKmRhaSkNCj4gPiArew0KPiA+ICsJc3RydWN0IG10a19iYXNlX2FmZSAqYWZlID0g
c25kX3NvY19kYWlfZ2V0X2RydmRhdGEoZGFpKTsNCj4gPiArCXN0cnVjdCBtdDgxODhfYWZlX3By
aXZhdGUgKmFmZV9wcml2ID0gYWZlLT5wbGF0Zm9ybV9wcml2Ow0KPiA+ICsJc3RydWN0IG10a19k
YWlfZXRkbV9wcml2ICpldGRtX2RhdGE7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWlm
ICghaXNfdmFsaWRfZXRkbV9kYWkoZGFpLT5pZCkpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+
ID4gKwlldGRtX2RhdGEgPSBhZmVfcHJpdi0+ZGFpX3ByaXZbZGFpLT5pZF07DQo+ID4gKw0KPiA+
ICsJZGV2X2RiZyhhZmUtPmRldiwgIiVzKCksIGRhaSBpZCAlZCwgcHJlcGFyZWQgJWRcbiIsIF9f
ZnVuY19fLA0KPiA+IGRhaS0+aWQsDQo+ID4gKwkJZXRkbV9kYXRhLT5pc19wcmVwYXJlZCk7DQo+
ID4gKw0KPiA+ICsJaWYgKGV0ZG1fZGF0YS0+aXNfcHJlcGFyZWQpDQo+ID4gKwkJcmV0dXJuIDA7
DQo+ID4gKw0KPiA+ICsJZXRkbV9kYXRhLT5pc19wcmVwYXJlZCA9IHRydWU7DQo+ID4gKw0KPiA+
ICsJLyogZW5hYmxlIGRwdHggaW50ZXJmYWNlICovDQo+ID4gKwlpZiAoZGFpLT5pZCA9PSBNVDgx
ODhfQUZFX0lPX0RQVFgpDQo+ID4gKwkJcmVnbWFwX3NldF9iaXRzKGFmZS0+cmVnbWFwLCBBRkVf
RFBUWF9DT04sDQo+ID4gQUZFX0RQVFhfQ09OX09OKTsNCj4gPiArDQo+ID4gKwkvKiBlbmFibGUg
ZXRkbV9vdXQzICovDQo+ID4gKwlyZXQgPSBtdDgxODhfYWZlX2VuYWJsZV9ldGRtKGFmZSwgZGFp
LT5pZCk7DQo+IA0KPiBZb3UgZG9uJ3QgbmVlZCB0aGUgYHJldGAgdmFyaWFibGUgaGVyZS4uLg0K
PiANCj4gCXJldHVybiBtdDgxODhfYWZlX2VuYWJsZV9ldGRtKGFmZSwgZGFpLT5pZCk7DQo+IA0K
PiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+IA0KPiBBcGFydCBmcm9t
IHRoaXMsIGxvb2tzIGdvb2QuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQoNCkhpIEFu
Z2VsbywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCkknbGwgYWRvcHQgYWxsIHN1Z2dlc3Rp
b25zIGluIHY1Lg0KDQpUaGFua3MsDQpUcmV2b3INCg==
