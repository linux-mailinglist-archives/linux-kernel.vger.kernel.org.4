Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E655727726
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjFHGQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjFHGQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:16:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1454106;
        Wed,  7 Jun 2023 23:16:00 -0700 (PDT)
X-UUID: ebc5adce05c311eeb20a276fd37b9834-20230608
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tAU5pTPe1AK+qGtTcI9Kkh9u4GbW337tHdGJR6WygQM=;
        b=AVR00oyh23nszYkbG7I1Z0TFjvY2ASXJofjWTtP5t8kAUoAKbtBBUjllIMME4d10Iodtx4ZNGQtO7dGm6kGXthxbhV7z4Q4iQj2WcWArZxsTq6VYwgF/tJZQWtWRP4ofspPFCE9H0InfZgYddsWVTnflMcMW2YVtVXS26jfLEBk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:03e3c687-68e3-417f-8b71-1341bc3f4619,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:79
X-CID-INFO: VERSION:1.1.26,REQID:03e3c687-68e3-417f-8b71-1341bc3f4619,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:79
X-CID-META: VersionHash:cb9a4e1,CLOUDID:e4e6686e-2f20-4998-991c-3b78627e4938,B
        ulkID:2306071527481U3980PY,BulkQuantity:36,Recheck:0,SF:38|29|28|17|19|48|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_OBB,TF_CID_SPAM_FCD,TF_CID_SPAM_SNR
X-UUID: ebc5adce05c311eeb20a276fd37b9834-20230608
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1560925467; Thu, 08 Jun 2023 14:15:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Jun 2023 14:15:51 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 8 Jun 2023 14:15:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m16f0uibR9KZtG1XEVhR3bxvvcGC+HoarJwkh9iJ/goAe2xc3u9VM87K57ro1XTanJrSX2rVMP1RmLkaW1x9nlO7IYi1KoGJL9c7eC5uTM8T7apDSv+1CiqsLyWNucc9YM/PxQsE1mUScjv3LQCP9CsW/U407rnr0V6ETKQK6qge/oYtyvaF3wte91JvMv/nbNgNlRs8nRbWIjapYuOXtVNetiea94VpbtjQnIExKNlgeOd96pV4hsydDlJHvJj4mjYZEkKDkjv466ehtHlLoyp3fc0vPGn8doQsPVpEdFASxuZpDnyiQE7rkaMv4Wvd8XJXRf4VsixBdQkbf9vACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAU5pTPe1AK+qGtTcI9Kkh9u4GbW337tHdGJR6WygQM=;
 b=j0bIDSSizVh9KWzIfQhwnH+6c9TWu4KU7LVfI+MTuPCFwZI0rzAABwIhUTE+qOdsjatsc5nSGBr59r2MkxbCUldJECaOy4nXGjbw2YUjQaJM37X9bxEtcJ2VJE4CJJg/ZYPiFpqTQIr+5cZ92vXR0d+TuQQgoAY7IyuiV/c0hfY9xfJzLoAx7CccteLVVbaPFxE+ooQyLrBgIba97hO4dO/sQfremRBSEwqpv7uBjXdH6S5pM0/d+ijblFxcTwfW+ctZf61jWACEgKjWQgnA/6M7X6AbuzPZsZHSvMT9Rx6cuD9ZWTlQsuok/L97GIBINvHd0BJIiSM2eqIVVfkOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAU5pTPe1AK+qGtTcI9Kkh9u4GbW337tHdGJR6WygQM=;
 b=nyvIckDiRQcgMHZO92XOU84y1igAAOR52r2qWXx3XwBY1DEBYDkKkWLhR7xOkNcmZWI5BP6SKK2Y/2+fZSpcNQ1YT6Fs/mMKQaFVAiICDJBWL89u94BbdSRtfD7UPpEUoAolX5jkOeGGcEazWERQx0GXeyaVeNOaypKCmgsnBOk=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by PUZPR03MB5794.apcprd03.prod.outlook.com (2603:1096:301:a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 06:15:47 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66%5]) with mapi id 15.20.6455.028; Thu, 8 Jun 2023
 06:15:47 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "fshao@google.com" <fshao@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 2/6] dt-bindings: reset: mt8188: Add reset control bits
 for VDOSYS1
Thread-Topic: [PATCH v1 2/6] dt-bindings: reset: mt8188: Add reset control
 bits for VDOSYS1
Thread-Index: AQHZmQccoZ+M6FRhCUuwkVRvA364Ja9+98iAgAFBMoCAADZLgA==
Date:   Thu, 8 Jun 2023 06:15:47 +0000
Message-ID: <08f52dc699db1dfe3a1dfff57cda00c7600d97d5.camel@mediatek.com>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
         <20230607061121.6732-3-shawn.sung@mediatek.com>
         <72b71e37-f9e7-b182-824c-163d920723b8@collabora.com>
         <a769105743d480c0da846a4c50de43811382626e.camel@mediatek.com>
In-Reply-To: <a769105743d480c0da846a4c50de43811382626e.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|PUZPR03MB5794:EE_
x-ms-office365-filtering-correlation-id: bdf17978-44b4-48a5-2ad6-08db67e7cd03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sx+71XNaR1wq+13hG8ofed9gV2tMkf5HgGSYViPfRF2rVcg0FlDVpi860iiTpbiHvC7uDUFpEM7ZMLsGxF8Hcj1eL+VIFwQz849MVH2SYblvoZPHiVbF+jUyhwDTSROke4+puULjjYVzA0hVdBy6Zjtm0jNBJSkNiKC9jswstmZUKlB8Ziut6CqUcQF+PE4qPfd1a1Y1NlItyUci8573i5u8rMRrZhXMBvNEon0yQMzDiETjJlX3/lnc7RLxjf5u+AmF7INpO4RzltqZhVHN3Dvs6TMIf9wfXiBsN1vhli5vuPVCHUAr5N28KqDGgLa+csapwEl2XxnZml+DGfiAvFeVCWjU3Ne88eXut/xXS7XLUiMyiPYzLL8PQWdFBtMY3BLJCXMcDmiIsMGLGaWgMn/VXa4+b98QCg7rtuavSCkOAyBm2iPdOE/RUFK7oyAj4ttDoSQq3tIpqyeuCWE9gWxmCj0BXRoHj1DIshQX6HRSe1hTdJFiqMBJPg7Bu4KtDQvfCVN0dkwHQvD0FZSEOA2Ts6WTmD6nl3ZyzgTQHqIqLbJ8doM+SJBrQJ/COdu+eIWb+TUI9bEzs1TiP4IUoCKT9hbjRnXyE+kVB2gZCigaQ1ZgtV56xMP4rEcqczUObijDHFAXwUzKJRGHQLsbh3aJPzARM5vK6xqANvRq82A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199021)(26005)(6512007)(6506007)(2616005)(83380400001)(186003)(66446008)(64756008)(122000001)(2906002)(76116006)(66946007)(66476007)(66556008)(6486002)(71200400001)(5660300002)(38100700002)(7416002)(8936002)(86362001)(8676002)(38070700005)(85182001)(54906003)(36756003)(110136005)(478600001)(41300700001)(316002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm92TTlOM28ybllUT3FKQTBxcjJMTE9TQXRQbXVqZXF6Rk1JZUdpS0dOVHVW?=
 =?utf-8?B?T1U1ZWcvdE1QOHF4aTlDSFRCZnJZZ05mQkVMV3BXYzM1VkhhL3ZrMWRNazM2?=
 =?utf-8?B?VUMvU1lSaWpKWnUyUHhUZWhHd2I1QmZsUW9VanUrRVd1UjBVU0dNcFVkU05a?=
 =?utf-8?B?Z0wzd0hDNXhKZjV5Qm9yRUh1Z1BZSVpTYnF4SE9LVDc2UXdRT3o5S3RIUXpi?=
 =?utf-8?B?Rjg4N3dkeUVOR01DWlNIWmFJY2lCV0UyVDNWeDcwRzc2VlFGL08rOE9yQVdN?=
 =?utf-8?B?RGdjMUxEY05PUzhQQ2F6ZXpMSGJsOW4rdk1CK09XZ0RZeEQvTWdva1lyTU8v?=
 =?utf-8?B?cS9ZcmZzRzlEa3BaTnNDOUo2V3RCejhnVDZBR0FKQnpnKzhXamV6MTI3Y3p4?=
 =?utf-8?B?dEg4NVF2WnVsQUQ4dHNwWGpuOVlQUnZCeW5hUkNEVG93SlhHSS80c25KVjgy?=
 =?utf-8?B?UnUvYzJPOGlqRW1aNjlndjg0YXpJcmFGWEF0Y1NYZy9nUUFrU29NTWU4K3Rm?=
 =?utf-8?B?c3RRaXpDUXNVMW5TNHNFUVlCN0gyZWphMzdxU1ovbTM3WWp6dVAxcFVXcHZE?=
 =?utf-8?B?bVBRMDlBZGpUMVVzTHVhVmJFTE1MSTQwTmdQNUZZSWs5cW1QaG9QREdvN2JS?=
 =?utf-8?B?RlJNK1QrUXUwQ0JVUUxOdWlZVXhuVENWVlRqdXJjWFk4R0c2UGxHV0hxM2pz?=
 =?utf-8?B?UkFTcjUvdUlWbjR3WE9qRWh3NjM1OHRNZ0o4UjlNUTNjZFBGVkp1VDRRRGZs?=
 =?utf-8?B?aVJYQ0hGQkZOL1B2eitjcVZyMFFJZDhaVGVibS9PRFlNSXRYTUUrVE9rWjA2?=
 =?utf-8?B?ME1JT0h3Wk1tTVh0RTFQMkVHZFIxa09qVHFQdFF5UXMwSVNTejJPU3JuZmpU?=
 =?utf-8?B?ZXdHcU81TEp5bnM0d0dLWCtScWVUcDRPRUlCR2tOTk55eFU4OHdmM3JYNm1Z?=
 =?utf-8?B?cjVMT3NnbmgyMnVRTzFtdUJsTnZ2SURUYVRsOG1KaGVpRk1ORllXRm5EbE9Y?=
 =?utf-8?B?YWM1SE9ORTJzc0ZPUUljWVdFR3preDFPUVZ2Y3hXRVMveENKaHFvSFlNcHI5?=
 =?utf-8?B?VGl0VWhZdDZ6a1dycWFSY1A3dHBZQWkxMWZLTnU3aUl3aURVNktTVVV3azhR?=
 =?utf-8?B?dXFTdGR2S1p3bVRNQytKN3VqVzNGYVl2Tzd0SXl5UW1FMG5xRkpTcGp5QXA1?=
 =?utf-8?B?aEk3ejkyTXRRTlFzYXlDM0ZrSUVNV0I5ekU0V21rV1FGYXlSVlE1cmwyZzV4?=
 =?utf-8?B?K2g1a250WGU5Ulh2b2ZuSHBINWQ4elMxTDQwb1UzdFQyRExLRFBabTUzdnBj?=
 =?utf-8?B?S0M1ZDJUTDMxdjEwQk10WEtUOEVmSHdRbU1wMmplMEc5YVF2TTJVdW1ucVBI?=
 =?utf-8?B?VWx1RWpkYjNScnFOSEkzRW5QQXVHZkVnaEhGL2tXZWxhcmN6RUVZV1lWT1Rp?=
 =?utf-8?B?TUUwUjJmdktCRlc2M25VTE10ZlZ0eGF5MG5rR294T1VyZlhxdENhbC9DOWJG?=
 =?utf-8?B?TnlQRmloR0x1NkxtVEorbDZQd0syeWIwUG5jdkdaZGlHYys3Vjh3MjVLai9I?=
 =?utf-8?B?U0ZSSGlMTXRQcEIrYXBDbEtQaTF4Y1EwazdkTTR3OFRjQUZadVlwOEkvbmVw?=
 =?utf-8?B?elpQc2EvUmpGYzc5bUJ2NXc2K1NMTFZsd3E2NGVCYjJWVWpYTjNHWUpCVktn?=
 =?utf-8?B?aDArSUwrTllMZ1JpZXpqWGcvSlJmdlJ0RUkvZUZqT3lrQ0hVem1LY1M1SWZS?=
 =?utf-8?B?Mmpya2hKeEloQlFvTzRFMTlzY1VVcUgvSjA2V1ZxYVAvVmt0NTNYMHVnSXZD?=
 =?utf-8?B?TFIrbzNBN3BnWThOSTBpMDloQTRnNDU1ZDBSV1I5ODRSc2U2TXdjQ0ZTcUd5?=
 =?utf-8?B?RStuQ2MwbFZ6WWVCVFo0S1JKQ0MrdUVINzJMa0dDOFpXM3dyUW1iREEzMHh4?=
 =?utf-8?B?cWJxTnpOY3Z0S3Y3MkkzTy9jYVllQjdHbnc5NGpQc1BxRkNRQUd1Z0hBSFcz?=
 =?utf-8?B?MkdiYzJxR3hNeXpzL2tLN0FmcGdiUHNreUZLeFVjWXZNaTI3czVPVG5qSWs3?=
 =?utf-8?B?Ym1mWE1EUzY3VmszZWZTQ08yckR6QjQydit1THpnc3lJOWR5K3puek9DemJY?=
 =?utf-8?B?SnVqS3ZERmtEc0pobDNaaTV2dG9wczlnVWplYnkvT1h3RENMMlZEYnZ0U1E3?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0D2FD7CE9355B45B9AD9404EF4B9DAD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf17978-44b4-48a5-2ad6-08db67e7cd03
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 06:15:47.7585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6929vFqyK5mDVrHfHHOPeszJwsYhk+SD7ysdM09rms7L4+JYexWHkk3U/piL4f1NP4DYHd+TzMbhlCTXMR9JwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5794
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXBkYXRlOg0KDQpJdCBzZWVtcyBkZXZpY2UgdHJlZSBkb2Vzbid0IGFjY2VwdCBlbnVtLg0KSSds
bCB1c2UgI2RlZmluZSBoZXJlLg0KDQpPbiBUaHUsIDIwMjMtMDYtMDggYXQgMTE6MDEgKzA4MDAs
IHNoYXduLnN1bmcgd3JvdGU6DQo+IEhpIEFuZ2Vsb0dpb2FjY2hpbm8sDQo+IA0KPiBTaG91bGQg
SSB1c2UgZW51bSBpbnN0ZWFkIG9mICNkZWZpbmUgaWYgcmVzZXQgSUQgbXVzdCBzdGFydHMgZnJv
bSAwPw0KPiANCj4gVGhhbmtzLA0KPiBIc2lhbyBDaGllbiBTdW5nDQo+IA0KPiBPbiBXZWQsIDIw
MjMtMDYtMDcgYXQgMDk6NTEgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3Rl
Og0KPiA+ICAJIA0KPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gdW50aWwNCj4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ICANCj4gPiBJbCAwNy8wNi8yMyAwODoxMSwg
SHNpYW8gQ2hpZW4gU3VuZyBoYSBzY3JpdHRvOg0KPiA+ID4gQWRkIHJlc2V0IGNvbnRyb2wgYml0
cyBmb3IgIE1UODE4OCBWRE9TWVMxLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lh
byBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4g
ICBpbmNsdWRlL2R0LWJpbmRpbmdzL3Jlc2V0L210ODE4OC1yZXNldHMuaCB8IDEyICsrKysrKysr
KysrKw0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+
ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNldC9tdDgxODgtcmVzZXRz
LmgNCj4gPiANCj4gPiBiL2luY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQvbXQ4MTg4LXJlc2V0cy5o
DQo+ID4gPiBpbmRleCAzNzdjZGZkYTgyYTkuLjQzOWE5YTI1Y2ExOSAxMDA2NDQNCj4gPiA+IC0t
LSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQvbXQ4MTg4LXJlc2V0cy5oDQo+ID4gPiArKysg
Yi9pbmNsdWRlL2R0LWJpbmRpbmdzL3Jlc2V0L210ODE4OC1yZXNldHMuaA0KPiA+ID4gQEAgLTMz
LDQgKzMzLDE2IEBADQo+ID4gPiANCj4gPiA+ICAgI2RlZmluZSBNVDgxODhfVE9QUkdVX1NXX1JT
VF9OVU0gICAgICAgICAgICAgICAyNA0KPiA+ID4gDQo+ID4gPiArLyogVkRPU1lTMSAqLw0KPiA+
ID4gKyNkZWZpbmUgTVQ4MTg4X1ZETzFfUlNUX01FUkdFMF9ETF9BU1lOQyAgICAgICAgIDkNCj4g
PiANCj4gPiBTb3JyeSwgSSd2ZSBqdXN0IG5vdGljZWQgdGhhdCB0aGVyZSdzIG5vIGluZGV4IDAg
aW4gcHJldmlvdXMNCj4gPiBkZWZpbml0aW9uczogdGhpcw0KPiA+IGlzIHdyb25nLCBpdCBtdXN0
IHN0YXJ0IGZyb20gMCBhbmQgbXVzdCBiZSBzZXF1ZW50aWFsLg0KPiA+IA0KPiA+IA0K
