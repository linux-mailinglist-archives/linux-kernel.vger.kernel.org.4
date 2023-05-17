Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EAF7067C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjEQMN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEQMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:13:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D037B1;
        Wed, 17 May 2023 05:13:23 -0700 (PDT)
X-UUID: 349df08ef4ac11ed9cb5633481061a41-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CWuHZ6AHLCNVvKru471VbgA2r58WhC/618EWL5GsanE=;
        b=jLmpTSbdWNGjxxGmHjes6nZNFKPyhk+8v+QOsAbFxRhMsjd0z58OLBX2nrJGjM3zxQ6nZndFJTgF2NZQT3QyzuM9A4vs2Aail/AZdqmqfTrdthRqOUNKEeYk78gxlygSI9464xZKliNgC8xwOIkG8TnIGDJ2i0Kxs+rOhOPDsr0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:86f3aea3-b891-4fdc-a8af-d21c1e436ef1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:aa2e1f6c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 349df08ef4ac11ed9cb5633481061a41-20230517
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 137115995; Wed, 17 May 2023 20:13:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 20:13:16 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 20:13:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrUEgltKxSF+vlcIikAUEdbCOnRt1xl7vRVl6dLKZdzO/z9SaDJ/rKWzHpJds1dGTd8iiB8uSRdj3LpDetahRv26xrY9E45O4kBaNl4ORw/kf7i+wlABiGMFWKMj/PnOhYgCukVQqDlcvw8YWLr7waFaeyVZKVXKhFsEqpZ5PGdWR4UDeduo3T80jKeNHiQMZjM5Rw/ndNc0LWhFzLmY33x3lABBqlLoQW6dmx7FY8DoP3aUDztgMqPOdLvIywuxbNxYGmj67MvAN9q51niMovkVqbQaAfrbrlJ1++lDroso8BWmrr0aQnCogcC/dkWjp9sN3RoHmdjClkrjHIyD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWuHZ6AHLCNVvKru471VbgA2r58WhC/618EWL5GsanE=;
 b=azKgg3PZDCaGh+mlYJ/Ns5GgzItPqFuOdFmxCbJpDjSb+zOu/ZRQ5XDsJOYK9gJUQweCyy4PghomqJAxhV4GePj7je4RKX71SQnxqGk22x+hmzLDoIs14D/EFRdDNW2O/8tYWVc4HtofZST6yra8bJOuZpRy/G25pdKIbAlyzF4KN++Z1uFlKxuCLN3auDModYoEw3jAcoR8EEoDQAsRMBR+h1FkPWCtPL4l9Ezl9n5qUxAUeODq5/6qtkzYoLFo4meawVxbc+TPiJRy3C8dpgxadw9QZcgzg35EW2u7bBgBUjoLZg0wbsDpw/PIF+0ME6oZtZXW96g0oarD+PZc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWuHZ6AHLCNVvKru471VbgA2r58WhC/618EWL5GsanE=;
 b=mytE5KDh+dhOkK3YQlMTdvipKqP+3rtaA+LS2fYCKM/uCvqFyebJ0DINxp7vD7CdxizAzjFZ5E1ooMZyUr0nVkulL0vUnlmghi5tm6ZhsZ+Hv8WrUWlsjPpO2srAbVLrQ3klHYzmfas8knQtT7kk2bBsSeCsUj1Gjr4/aQv4dXk=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by PSAPR03MB5192.apcprd03.prod.outlook.com (2603:1096:301:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 12:13:14 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 12:13:13 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/5] ASoC: mediatek: mt8188: separate ADDA playback dai
 from capture dai
Thread-Topic: [PATCH 1/5] ASoC: mediatek: mt8188: separate ADDA playback dai
 from capture dai
Thread-Index: AQHZiLDrK222lHVkCUWF2nRgQpKtH69eV2WAgAAJHoA=
Date:   Wed, 17 May 2023 12:13:13 +0000
Message-ID: <520bb4d2d65958dddba314d7fb931282959ba44e.camel@mediatek.com>
References: <20230517111534.32630-1-trevor.wu@mediatek.com>
         <20230517111534.32630-2-trevor.wu@mediatek.com>
         <678f3582-ff1e-033a-f8d9-f73910156d15@collabora.com>
In-Reply-To: <678f3582-ff1e-033a-f8d9-f73910156d15@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|PSAPR03MB5192:EE_
x-ms-office365-filtering-correlation-id: 00bbcbef-d290-403e-a1e2-08db56d016ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: slRWwefJxDw6kK38wjSBIIB4/5A19gzixFSPuEug+zTlPqyTwb2Ao8p0Pw/LQLOyRzPNyWj8Zu8JSdPFtEBY0gXWJdVBiiTFOYVRSUKH8t1OTNWBVKCoxnkBSF7aF+ezTp8stnP19lgNSSQELRNgQYtJX35Gme7d8qqLJWVIJflPiuX6FJX5GPegsuch97EvvXznnKgmIXKv8xxNvm2jLX8X8IruVg0Zcol2bV04pQNTH54eJzPONlrAdz5tqU0UnqlG8ge6fDfIFLZ6PiJdzHCiVAAJ/IoaCKlzdnVUZehuFUUs5R0u9VQUGec5x6WSBFrILEM6e4rlvXWMVO4gI68uDhEQ3Rx4k/a4KVGQMPV+BuPo1m+QMLt4Yb1osil/VWh4GOZYhbubbYTZ3ZVl5iyn7kptTGiQAJDHG8oexgQ3ESY6VU9yuSMLlq7rDUvVf1GRq0yryzQ5Vye1IFRg4eCXZ/4hD9sBWtpv9OPTNBQwRYrS0m12gFEXC9ohfzqjmKQDZV6kjc8ps7EuETGYx+ltZj0tcsvJcL5DSsV67brFP56b7nXujAzgMfP+8ouJo8vOkdtKi5GWapUk43h6atqsTFMjDOdRAuqpTuF1r9GD7FH8KqDsYx4I29yT7/3TlzYxkZgPLlxzoNLUW3R6NY88Nn9Vh69lxddyur98XF8JjnXGg0HCMAf3UnddIkRs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199021)(2906002)(110136005)(54906003)(5660300002)(83380400001)(7416002)(8676002)(8936002)(41300700001)(91956017)(76116006)(85182001)(316002)(64756008)(66446008)(66476007)(66556008)(66946007)(478600001)(36756003)(4326008)(71200400001)(6486002)(6512007)(26005)(122000001)(2616005)(86362001)(6506007)(186003)(38070700005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0Nmb3Jkb2xhalhDcC9kQWJtVFBFb1BHbmpobTB1dWtEbEJLajVkMXhKQXR3?=
 =?utf-8?B?UEtmVngyNENlanhlcU9BVitJUUxKcml0eitPT2pwVXBSSndGbDJpcXNHZS8x?=
 =?utf-8?B?WlJFTmlUM29xSUg2T2dNZ1g3bGtreTFuTmIzVWYyZFRKZWRuQytNUEhKZHFU?=
 =?utf-8?B?S3NXQ0FsU0J3K0dkVXpIUnk4aHYxeUJGNjkyN3NQL1RwV1JONWE4MjZvN0pD?=
 =?utf-8?B?c0tIYVBZUU5YUVg1Z3MveEFBSmVTcyswa1VvZlFhRDJJOWl5dWFXUDIwaDZC?=
 =?utf-8?B?a0NiL1RiNHduZnFXd0FXY1RDdEpBR0U2RmVyWGRwTk8vdXlzcVFOS2RtNGVw?=
 =?utf-8?B?ekVwbVoxdUE0R2E4NnFBYkNWRE9kYnRPd0RTaUtDVjRTWTR0d2NkdW94VzRH?=
 =?utf-8?B?WkZxV0owWTdMVWJIcnFvV0R6SjJpKzJjanhXYkkvN2NDa3R5ZW5CK01pUlpW?=
 =?utf-8?B?UkRpUE1IV0txeTIyM0pvV3FJd2FadDlBVW1tNmhRRWRWYktLOEZEWWFEeG9r?=
 =?utf-8?B?Vks3MlFFRkFMWTlleGtWMjFmWWFvSlY5K3VJZEV5UnplclFIQnBTY2JXdCtp?=
 =?utf-8?B?N01BcElTdlVJc0dGZ2FJbFJObitCMjRzeDlFeG9lNFlIMXNHYyt2ajQvZm1S?=
 =?utf-8?B?eG5pYzNoOE1NcWhyZTNQOTJtOG5xbkZWWWlNelNueHpKSDVCM3JRSkhBMlJx?=
 =?utf-8?B?NklTYjU5T1JFU3VubkZlVjUxZFNzdzFMS1dzT1dQN043US8xYU5hakFrZ3R6?=
 =?utf-8?B?TStLcTMxb1ZzNTE0aGQ1MTRqUUNLZnA2STMxUi9FdDFsVzVyeWpOVVdRaWJs?=
 =?utf-8?B?NEZHNWZaVkI1QnRrd285eVN1dXBvWXI5MjBtR2NScCt6QWhPcE55bE9KQTdZ?=
 =?utf-8?B?eC9EdHk0TVlqeC9lNEl4NDlndFFzT0ZjUmRGZEJzclkzZU1XcDdUTjM4L2hm?=
 =?utf-8?B?aC9RMU5tczlaeGptYnJDVGZkNkpzMGt3cjVJTktJR1ZvVVBhb2JxVWM2ckVy?=
 =?utf-8?B?cUo0a2hzMndLL2VoNk5ORzNKa3pIS2hMaTh0SkROcXVmR3RzU25Pc1k0aXZO?=
 =?utf-8?B?em9OcjZLTjRiZWVXNlcyWE5iem1MZEgrdlRCNjN4QlIxN1V0Y1V4T0o5Wlpm?=
 =?utf-8?B?TTFJZWk2ejk5L2h0L0dJOXZVMmRhTDZsOFNKZU5laTFmZWpsNUZhNThXWkFQ?=
 =?utf-8?B?SWFMaXZGQ3lGV2ptSzhkK01RNzQ5UVRtcFFLL08rWncybU1CMHh3bkFvc1Q3?=
 =?utf-8?B?Y3VZKzVjV3ZvYmZoczNSQjZhd3gwRWxFQUhPU2l5dW1ISGVSUXFlYTF2d05v?=
 =?utf-8?B?NG0zeExrMTJaVmtoOGpRSmRyZG1tMldFcElYT2d6QWR6amIvbDJReGdnOXNG?=
 =?utf-8?B?anppSkJUWGRVd1JmQWVuUlNBS2xCaTZYR2p3WDQ3OThsZEc0N1AxUm9QeUtY?=
 =?utf-8?B?V0FFNnVTb21NdUt0cExmUUIvcWtMVEt0M25jK0dhdmNBdW5ONE0wa29VeUZj?=
 =?utf-8?B?cndCUUJQWFRsdjlZUUJzd3VyODdibkx2MkppVDF4cm1DZ1gvbFFCMnNmSXlP?=
 =?utf-8?B?WThtWUFpWmFIUU5pclkvWEMrTDNXaTZRalNnbUxPNmRkL2Q0cVFONGwrNmRL?=
 =?utf-8?B?bzVBVVNieTlMcVZBdWFHU1RzK0NMWXI3emZ6bnVUb2NQQndWY08ycis1U3hq?=
 =?utf-8?B?T3J2cGJOdmsrNVdXcGxjQ2JZMm5tdjhJbkJ0b2lqZ0pqMGltZjR1eWNqNGlm?=
 =?utf-8?B?ZXMrVjB3Slo1TnNTU2s1c2xlTFVRYXpZTVE1MmVNNWJiYmdEV1BkOGZpa3NY?=
 =?utf-8?B?eExVK2hManQzaFkwUkp0amVjbkFtWmVaZFFPb0hCZVlwcEZmRDZNM2crSlk0?=
 =?utf-8?B?OVJoK2dDcDVVTzJJSk5Oa0Z5Vmk2RjdzS082QXMvTGp1OHhTVXVWVXh3L3J6?=
 =?utf-8?B?WXFXZUFaUGlaNVlCd3ZOeWRma2VXV05Cblh3Zksxbzg5SVFGMkFDOTVSV1lX?=
 =?utf-8?B?MUR2MElVZGhoRTc2UjZjcmZaQ0o3RnBLR0JEazhNUitxNS94NysyQkdGSVhv?=
 =?utf-8?B?NjZ5SUFQSTlZT2VlTEU5TkNZYUdpaG5kWUN0MlMvV203RGx6eEw5SXFVNlI3?=
 =?utf-8?B?T0pJU2I4SExJSTlVWGUxS2pPd3dsQ0NDSnM0blNvemsxelNwaVZ4TkVJTUIv?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <084314D78BE55F4989B3DB203DF368D2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bbcbef-d290-403e-a1e2-08db56d016ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 12:13:13.6259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OI5PUr1+2PP2NAUlPSOEs/6XcBNpdR/FF0Kf2hNo17FUZHolLY+QU4zfTAvQBYTSFCwaKebeutoW2KBf3gGXVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5192
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTE3IGF0IDEzOjQwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxNy8wNS8yMyAxMzoxNSwgVHJldm9yIFd1
IGhhIHNjcml0dG86DQo+ID4gTVQ4MTg4IHdpbGwgc3VwcG9ydCBTT0YuIEluIFNPRiwgYmVfaHdf
cGFyYW1zX2ZpeHVwIGNhbGxiYWNrIGFyZQ0KPiA+IHVzZWQgdG8NCj4gPiBjb25maWd1cmUgQkUg
aGFyZHdhcmUgcGFyYW1ldGVycy4gSG93ZXZlciwgcGxheWJhY2sgYW5kIGNhcHR1cmUNCj4gPiBz
dHJlYW0NCj4gPiBzaGFyZSB0aGUgc2FtZSBjYWxsYmFjayBmdW5jdGlvbiBpbiB3aGljaCBpdCBj
YW4ndCBrbm93IHRoZSBzdHJlYW0NCj4gPiB0eXBlLg0KPiA+IA0KPiA+IEl0J3MgcG9zc2libGUg
dG8gcmVxdWlyZSBkaWZmZXJlbnQgcGFyZW10ZXJzIGZvciBwbGF5YmFjayBhbmQNCj4gPiBjYXB0
dXJlDQo+ID4gc3RyZWFtLCBzbyBzZXBhcmF0ZSB0aGVtIGludG8gdHdvIGRhaXMgZm9yIFNPRiB1
c2FnZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4
OC1hZmUtY29tbW9uLmggfCAgMyArLQ0KPiA+ICAgc291bmQvc29jL21lZGlhdGVrL210ODE4OC9t
dDgxODgtZGFpLWFkZGEuYyAgIHwgNzYgKysrKysrKysrKy0tDQo+ID4gLS0tLS0tLQ0KPiA+ICAg
c291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtbXQ2MzU5LmMgICAgIHwgMzQgKysrKysr
Ky0tDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKyksIDQ1IGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210
ODE4OC1hZmUtY29tbW9uLmgNCj4gPiBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4
LWFmZS1jb21tb24uaA0KPiA+IGluZGV4IGViN2U1N2MyMzliZC4uMTMwNGQ2ODVhMzA2IDEwMDY0
NA0KPiA+IC0tLSBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LWFmZS1jb21tb24u
aA0KPiA+ICsrKyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LWFmZS1jb21tb24u
aA0KPiA+IEBAIC0zOSw3ICszOSw3IEBAIGVudW0gew0KPiA+ICAgICAgIE1UODE4OF9BRkVfTUVN
SUZfRU5ELA0KPiA+ICAgICAgIE1UODE4OF9BRkVfTUVNSUZfTlVNID0gKE1UODE4OF9BRkVfTUVN
SUZfRU5EIC0NCj4gPiBNVDgxODhfQUZFX01FTUlGX1NUQVJUKSwNCj4gPiAgICAgICBNVDgxODhf
QUZFX0lPX1NUQVJUID0gTVQ4MTg4X0FGRV9NRU1JRl9FTkQsDQo+ID4gLSAgICAgTVQ4MTg4X0FG
RV9JT19BRERBID0gTVQ4MTg4X0FGRV9JT19TVEFSVCwNCj4gPiArICAgICBNVDgxODhfQUZFX0lP
X0RMX1NSQyA9IE1UODE4OF9BRkVfSU9fU1RBUlQsDQo+ID4gICAgICAgTVQ4MTg4X0FGRV9JT19E
TUlDX0lOLA0KPiA+ICAgICAgIE1UODE4OF9BRkVfSU9fRFBUWCwNCj4gPiAgICAgICBNVDgxODhf
QUZFX0lPX0VURE1fU1RBUlQsDQo+ID4gQEAgLTUyLDYgKzUyLDcgQEAgZW51bSB7DQo+ID4gICAg
ICAgTVQ4MTg4X0FGRV9JT19FVERNX05VTSA9DQo+ID4gICAgICAgICAgICAgICAoTVQ4MTg4X0FG
RV9JT19FVERNX0VORCAtIE1UODE4OF9BRkVfSU9fRVRETV9TVEFSVCksDQo+ID4gICAgICAgTVQ4
MTg4X0FGRV9JT19QQ00gPSBNVDgxODhfQUZFX0lPX0VURE1fRU5ELA0KPiA+ICsgICAgIE1UODE4
OF9BRkVfSU9fVUxfU1JDLA0KPiA+ICAgICAgIE1UODE4OF9BRkVfSU9fRU5ELA0KPiA+ICAgICAg
IE1UODE4OF9BRkVfSU9fTlVNID0gKE1UODE4OF9BRkVfSU9fRU5EIC0NCj4gPiBNVDgxODhfQUZF
X0lPX1NUQVJUKSwNCj4gPiAgICAgICBNVDgxODhfREFJX0VORCA9IE1UODE4OF9BRkVfSU9fRU5E
LA0KPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1kYWkt
YWRkYS5jDQo+ID4gYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1kYWktYWRkYS5j
DQo+ID4gaW5kZXggZmVkOWY5MjdlNjIzLi45YTY2NzNhNmYyOGEgMTAwNjQ0DQo+ID4gLS0tIGEv
c291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtZGFpLWFkZGEuYw0KPiA+ICsrKyBiL3Nv
dW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LWRhaS1hZGRhLmMNCj4gPiBAQCAtNTMsOCAr
NTMsNyBAQCBlbnVtIHsNCj4gPiAgIH07DQo+ID4gDQo+ID4gICBzdHJ1Y3QgbXRrX2RhaV9hZGRh
X3ByaXYgew0KPiA+IC0gICAgIHVuc2lnbmVkIGludCBkbF9yYXRlOw0KPiA+IC0gICAgIHVuc2ln
bmVkIGludCB1bF9yYXRlOw0KPiA+ICsgICAgIGJvb2wgaGlyZXNfcmVxdWlyZWQ7DQo+ID4gICB9
Ow0KPiA+IA0KPiA+ICAgc3RhdGljIHVuc2lnbmVkIGludCBhZmVfYWRkYV9kbF9yYXRlX3RyYW5z
Zm9ybShzdHJ1Y3QNCj4gPiBtdGtfYmFzZV9hZmUgKmFmZSwNCj4gDQo+IC4uc25pcC4uDQo+IA0K
PiA+IEBAIC01MDMsMTMgKzQ5NSwxNSBAQCBzdGF0aWMgaW50IG10a19kYWlfYWRkYV9od19wYXJh
bXMoc3RydWN0DQo+ID4gc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCj4gPiAgICAgICBk
ZXZfZGJnKGFmZS0+ZGV2LCAiJXMoKSwgaWQgJWQsIHN0cmVhbSAlZCwgcmF0ZSAldVxuIiwNCj4g
PiAgICAgICAgICAgICAgIF9fZnVuY19fLCBpZCwgc3Vic3RyZWFtLT5zdHJlYW0sIHJhdGUpOw0K
PiA+IA0KPiA+IC0gICAgIGlmIChzdWJzdHJlYW0tPnN0cmVhbSA9PSBTTkRSVl9QQ01fU1RSRUFN
X1BMQVlCQUNLKSB7DQo+ID4gLSAgICAgICAgICAgICBhZGRhX3ByaXYtPmRsX3JhdGUgPSByYXRl
Ow0KPiA+ICsgICAgIGlmIChyYXRlID4gQUREQV9ISVJFU19USFJFUykNCj4gPiArICAgICAgICAg
ICAgIGFkZGFfcHJpdi0+aGlyZXNfcmVxdWlyZWQgPSAxOw0KPiA+ICsgICAgIGVsc2UNCj4gPiAr
ICAgICAgICAgICAgIGFkZGFfcHJpdi0+aGlyZXNfcmVxdWlyZWQgPSAwOw0KPiA+ICsNCj4gDQo+
IGhpcmVzX3JlcXVpcmVkIGlzIGEgYm9vbGVhbiwgc28gYXNzaWduaW5nIDEgb3IgMCBzaG91bGQg
YmUgcmVwbGFjZWQNCj4gd2l0aA0KPiBhc3NpZ25pbmcgdHJ1ZSBvciBmYWxzZTsgcmVnYXJkbGVz
cyBvZiB0aGF0LCB3aGF0IGFib3V0Li4uDQo+IA0KPiAgICAgICAgIGFkZGFfcHJpdi0+aGlyZXNf
cmVxdWlyZWQgPSAocmF0ZSA+IEFEREFfSElSRVNfVEhSRVMpOw0KPiANCg0KSXQncyBncmVhdCEh
IEkgd2lsbCBhZG9wdCBpdCBpbiBWMi4NCg0KVGhhbmtzLA0KVHJldm9yDQoNCj4gPiArICAgICBp
ZiAoc3Vic3RyZWFtLT5zdHJlYW0gPT0gU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSykNCj4gPiAg
ICAgICAgICAgICAgIHJldCA9IG10a19kYWlfZGFfY29uZmlndXJlKGFmZSwgcmF0ZSwgaWQpOw0K
PiA+IC0gICAgIH0gZWxzZSB7DQo+ID4gLSAgICAgICAgICAgICBhZGRhX3ByaXYtPnVsX3JhdGUg
PSByYXRlOw0KPiA+ICsgICAgIGVsc2UNCj4gPiAgICAgICAgICAgICAgIHJldCA9IG10a19kYWlf
YWRfY29uZmlndXJlKGFmZSwgcmF0ZSwgaWQpOw0KPiA+IC0gICAgIH0NCj4gPiANCj4gPiAgICAg
ICByZXR1cm4gcmV0Ow0KPiA+ICAgfQ0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo=
