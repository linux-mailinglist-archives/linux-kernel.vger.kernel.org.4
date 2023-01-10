Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C967C663B16
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjAJIcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjAJIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:32:27 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF58D140A7;
        Tue, 10 Jan 2023 00:32:21 -0800 (PST)
X-UUID: 7750c0cc4a3a486db498d4ee2deaabc8-20230110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Yq1moWc+h/KnG43ExuC3vXzW1Ks8TEXB6qkdIdoqUs4=;
        b=q00K1t38yj84YOpcdTRkf2gmAdLL0J1OZZlLvFf1LtCYKu/1AiXj4krUMvwFGV1sLEjqH4c1BTtdLX0iG4TJ8aea6gAM/9TBu2KUQrd0e7zdG59xl1PA6/9q+IgMOgOKLcsEG60qE0fu0JwO1AGVSyVVDt5LUvNDYkeq1ZVOL7g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:9b0661cc-42f0-4981-89ff-629cf47e14ff,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:a8063754-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 7750c0cc4a3a486db498d4ee2deaabc8-20230110
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1139104386; Tue, 10 Jan 2023 16:32:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 10 Jan 2023 16:32:13 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 10 Jan 2023 16:32:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SraeHUikpO6BDlH7fRE0OQta/w/eKblE6ToM9UIzDB+xKqDjgmBXs2ocERxAi2gfCDePGOoli+2kBL+0PzkzgEX75B8WThGc1oNdBlhNrauG0g3E0MdEqboVkgiZ2Yp55TJ1rRfrcxMEIsGWWX7hB+CsX6qPWQYHs9+SRZrt1SWkWs9MTx1aRstcTTHf0VWlmoMDqOYz0QtpFyyM+e71P9I/1mWo6PAeNp1uTItZwe7qAkOhQsa2QRA+fwcpE8wME1NIY23iFkvaGTPiSygYl5eNiw1V8MDuMQk4sEJCh/QL8fpE0LEWz0spFHrR6cxTjptfwJs8PXjo939CaaPQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yq1moWc+h/KnG43ExuC3vXzW1Ks8TEXB6qkdIdoqUs4=;
 b=S3xGle0tZWInZVwyDmWE7e51DhR6hwpbfWQNXyup/LjYDXQ1BG9sg04tPf82aP8T3yV/9h5SVQb4ikNYysC98X8XCJRrhU+Kg92rNhe7a7EDvYRhpw2WPGIgtCYy/JLQJxWl7gApJWrSFCo8Gpy3OFfUk2b2TRdkWVXiZ5O6xMtDSR6T5ZjPQ4GpP5j113qafr/byfheDMG26p9R2KrSPdUxYjf1veQAmx1SmjwM2PR16TwanuIaqfsqr65YaT3xSptC3eCDjTlW63nWDFvZmyQ2QFKakERiDgsdDPHgUP1nOywXO6N6heHxQk2uaPpDzoC6XcdbhzKRgMg3VtUc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq1moWc+h/KnG43ExuC3vXzW1Ks8TEXB6qkdIdoqUs4=;
 b=tzuxIY9BKV+JMh9TAhBsKY7scDe2D2w1x8okjqV6+r+9cbDgQ0pr/Dsh1uBeuQO+2VbljcN7O7h5oVMw/kKtuHDiqQb9n4wTv9U7orBw8m4k8axXbtUyu/ZtsNcFjeWixKkNnUReIFXbkzVddHfE8RV/+6c378tfT3shEiuvgJ4=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by PUZPR03MB7091.apcprd03.prod.outlook.com (2603:1096:301:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 08:32:10 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::31b6:c8e3:d2ae:70ac]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::31b6:c8e3:d2ae:70ac%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 08:32:10 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?WUMgSHVuZyAo5rSq5aCv5L+KKQ==?= <yc.hung@mediatek.com>,
        "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        =?utf-8?B?Q2h1bnh1IExpICjmnY7mmKXml60p?= <Chunxu.Li@mediatek.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "error27@gmail.com" <error27@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "sound-open-firmware@alsa-project.org" 
        <sound-open-firmware@alsa-project.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1 2/3] ASoC: SOF: mediatek: Support mt8188 platform
Thread-Topic: [PATCH v1 2/3] ASoC: SOF: mediatek: Support mt8188 platform
Thread-Index: AQHZFdZoODcxabTe/UOnHRjoxKRkX655wBEAgB2wUIA=
Date:   Tue, 10 Jan 2023 08:32:10 +0000
Message-ID: <d139005348032f44684488df9c7c9727ccb36ffe.camel@mediatek.com>
References: <20221222072150.10627-1-tinghan.shen@mediatek.com>
         <20221222072150.10627-3-tinghan.shen@mediatek.com>
         <31b2946b-d4f2-5e5b-a107-45b3454c601b@collabora.com>
In-Reply-To: <31b2946b-d4f2-5e5b-a107-45b3454c601b@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|PUZPR03MB7091:EE_
x-ms-office365-filtering-correlation-id: e0492166-fdf1-409e-efaa-08daf2e52ab1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1lD92+X8u9N4SsJZ1Kvtl7OBz3djFjzrsrS1U5vY+Q8jQekQZ+oneieyVmt5NUZcKA7cF9D2nWOSIkzpQAwA3nrOGVu8uyui78v6AAY2QAdgiwut/TXxzQneKVRI/oF0tKXi9KKYOwj/g7c3rbnho00P+gLnRUv+uv0ArsFbA88Tnf2sAE3IOZTkvGySIH5in9bF9/mF4NDLplegCSKxIqwGde2Bq1YRS12+dRWuc8ie4dsWrT90/QQJka4NgbDpk2miqKBKoEZpKCGZ/YZBhfUrTULeMaIu8uOujvqrk582ndrPnZjp698fxgFuL2JgSy7JZ6n8WB9cBthTAzWwMCugeCK5XISn0WPx9uy2/gdO2JWYJC35DcZGRdUYwOwt2R6A2WeFTDrAT9NtjrhhTBnIHCtfRK6b9CSJ7DaMak3T7nSdyRYkfM5Zriu/1nEUE+fihyfwAGulUeWJT4dGCMYm6u/FP2QGYd5H498LESpmjJLYCLT2+SHX03nxlVKfW+MwnIO2oY7Nzb6j0GPmfwh328k0PxxIk+G76Yn7/4i9wzA2F8ltdkyeMskY2xb4nVFxW/hcZ60tfEuB6C80INY10CAdheeD0FrkcUk0d7UZUu2E/hIT5/NJotJcXsyTrGdejYmYIfnrr4RknxMzlLU2NR21Aed/GbwxzRn1GWSbCLQiUN3vJavzi18pA4N64wJJxVMR5dKXiMfGO4DKTwG0688wp/HL35v/0Rk3FboCKmEqLU+SQpBqURlxcbd5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(4001150100001)(2906002)(186003)(5660300002)(8936002)(26005)(6512007)(7416002)(41300700001)(36756003)(85182001)(921005)(71200400001)(122000001)(8676002)(86362001)(66556008)(76116006)(66946007)(64756008)(4326008)(66476007)(66446008)(38100700002)(478600001)(91956017)(83380400001)(107886003)(6506007)(6486002)(38070700005)(54906003)(110136005)(2616005)(316002)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG0weFRucnFoQytvaGVSQ3hSR3FCY1hLeTArNWNiM0tzbkVISnJ0K1RNVHV0?=
 =?utf-8?B?V2FGdHpGdDkyeGxsY3ZrNDR2SWRTdXlGSSttcm55cWI4Qm1WWHI3cWFqekw5?=
 =?utf-8?B?eDE2aWFGbWxqbjJpVE5YTWJBRm1kUklBalpRbjJheTdGTGxQWlVFbk43dzM5?=
 =?utf-8?B?bDN4ZU1ER1ZrQXZ1QVdDblc2NVpSeVlFM2ZJYXhPZ3h3WVBaWTZ0Sy9QV1Yr?=
 =?utf-8?B?Wm05UXhjTk01am5KUU5DVzZIU3dzK1o0OCttWVh2Y0xEMU9QSDNHZmw0QzYy?=
 =?utf-8?B?V1pvai81Y3hFNXVUaHQwZkxIMm1lSVg2YTRKTS9hRHhTTVRuQW55SmNQT2hV?=
 =?utf-8?B?QWt2UUM0WG5Tc0sxbGpaOXdLdkprQ3kwaURFU2xvRmtBZW50WWhsb1c1L2xq?=
 =?utf-8?B?YURZRHhMM1JDaGVZYjhmS053V0JHZ3EzM0FYVkphbWFPaE54M1dXRFdnQUI1?=
 =?utf-8?B?QTBDei9DcjR4SStUcjl6RFB6a2MrL2ZpOXF4TWxVQTBjd2xvVTVIbGNpVjFW?=
 =?utf-8?B?LzgxSGlHaDBudmxnTUFJZ245NFdickJCK0JCRTVYMS8xVjRVaHBJV2RTWGpI?=
 =?utf-8?B?TWJRVWJoS2s4Z2cwU0EwSjVIaGhmdkVHdkt2Q2RJWVphM1FnbFdxZmdZUE5Q?=
 =?utf-8?B?Q3E5ZEk1ek5lMXJBSDBhZUxJN2VMd245aFBXOWhEOGlzdno4SEN2cVFFazNq?=
 =?utf-8?B?d2JQWTV5T3BHTkp5L0NGelpzOGZabFZwMTBUTFlpcXh0RlZMS3VVQnhTWlZ2?=
 =?utf-8?B?ZGRtdmp0RTY4cDdaWXBMeGhxUmZyTGRINy80V0FqdW1wT1Y2VGVZU0kraFZ0?=
 =?utf-8?B?b1NKWFRXRUxybVl0WWlyNmZGRzhseUhFN0dqeEF6RHhSd1MwVUNJd3VGTkVN?=
 =?utf-8?B?dXpHV0N5REFSUU4rajR3T2gydGRHUHZyM25IV0haNzZOT05haXgxSEozOUU0?=
 =?utf-8?B?ZUNWRTh6TW9Rd3pnSzVxZGViY0hTMTM2aksvRFMvNUNlOEI2M0xlMjFvcjlR?=
 =?utf-8?B?Y1IvUHlQck1Jbnl5RDdJMStEL2haWE5mcXpYVjNwend5cXZKRnRZSTgxNTJQ?=
 =?utf-8?B?WklYcjhidk9zOGtyTkZEQ2taWlphMFM4cThMS2Y0bDE1citmcUdHRkFhNkZF?=
 =?utf-8?B?VmcxS2FCU2ZnaUYvcnNwREhxUkpCS0JyWEwya3Z5ZEJ2SXd5YTZwdUNKUDg5?=
 =?utf-8?B?bzhzNThwaUlpNUs3TTN2M01HVkZnZXhSR2txYnZjc25CZEY1MVl2TTRrNlRj?=
 =?utf-8?B?MzUwWWM1SFlSQU5xTDdYNzRuVjBwSTV4NkUvSWpUOUNKa3Q1SDUxbWlMZDcw?=
 =?utf-8?B?Nm5BSzlRS2t2SFE4aGlSMnIxanZsRnVXNmZVZjJyNUd6TnUxNUdrVC9ad2Ry?=
 =?utf-8?B?VC9ZVlFlZjZ3bTQrdGU4VGtBWjhPYWl1ZGdlZGljNm1uTUNpbHFlR1I0dWRq?=
 =?utf-8?B?V2RZOXdpeTNSSGNoMHBqYnAvTHdmOUhJOGRwTkU1TmlNbEVjYlN4U1AxZ3lJ?=
 =?utf-8?B?VCs4eEs3R2ZER1JMNzJhTnRXZXRaVHIydXRuZW9BWGE3a1FuQmszSkN1TVBF?=
 =?utf-8?B?ZDIvaDdGWndXM1M5NVFiOHV6S0grZzFYTENsRVI4UDUzbTYraXNZZjZ6aVA2?=
 =?utf-8?B?QWNyaG1INVpSL2FsQTRUVy9vcEpNSHJreVN5NVhoTkhDTUYvOTJTU2paTFFW?=
 =?utf-8?B?aGdnN0lUUi9QKzJxZlhGSFJ4RzhJUVlnQTNiZUQ2Z056OHF0T00vb2ZmY3hy?=
 =?utf-8?B?Wk05a1BGbW5OaGs5dy85OUg2L0g1a2tBNFZQMjBGTnJJazgwTzM3VHdCQ3lS?=
 =?utf-8?B?Z0VCOU1JajArb0RrRVhCOXJXMXdWY3NMS08yMzBsYzlzK1J2WmJxUnJZeUtI?=
 =?utf-8?B?bk1BRGQ2Um14MHhwczNLUzFldm5IMU9iR3VVN3pEeFR6c2NVc25yTUtINXZy?=
 =?utf-8?B?L3NYS25EeU9LZ3hUY3lvRHRLbzBFUmJQWGJMbWFkSWk4MEd0RVVqcWl2Rzht?=
 =?utf-8?B?R0FPVWRveHg1UzRpYy9WbFNvdDk1UjVWMW9KK1krQ0dURjlVR0hpRk5MYjFv?=
 =?utf-8?B?TTFaUWdYTFF6c3pScW1QTXBlaWEyVTdGbDV2QUVrMHlCU1E0djZsSXc3azEr?=
 =?utf-8?B?d3hEOFpRdUp1VU1sU0dzcENPSzZJZGFacG5sTGhVb3dLQnFBQlRsbmF6SVFO?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89B549AD18C8AE49A9246072A2848CF6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0492166-fdf1-409e-efaa-08daf2e52ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 08:32:10.3614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFaswHGxzJvGAvhDkYqzvk7k/kpQ0Y6yUaStkhGdQaxXSqxyubiX2pXUebdp2g04ajHB8hw2skrCsF/VCeftOBatc25shOYE21NiNprQvUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUaHUsIDIwMjItMTItMjIgYXQgMTI6MDkgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAyMi8xMi8yMiAwODoyMSwgVGluZ2hhbiBT
aGVuIGhhIHNjcml0dG86DQo+ID4gQWRkIHN1cHBvcnQgb2YgU09GIG9uIE1lZGlhVGVrIE1UODE4
OCBTb0MuDQo+ID4gTVQ4MTg4IEFEU1AgaW50ZWdyYXRlcyB3aXRoIGEgc2luZ2xlIGNvcmUgQ2Fk
ZW5jZSBIaUZpLTUgRFNQLg0KPiA+IFRoZSBJUEMgY29tbXVuaWNhdGlvbiBiZXR3ZWVuIEFQIGFu
ZCBEU1AgaXMgYmFzZWQgb24gc2hhcmVkIERSQU0gYW5kDQo+ID4gbWFpbGJveCBpbnRlcnJ1cHQu
DQo+ID4gDQo+ID4gVGhlIGNoYW5nZSBpbiB0aGUgbXQ4MTg2LmggaXMgY29tcGF0aWJsZSBvbiBi
b3RoIG10ODE4NiBhbmQNCj4gPiBtdDgxODguIFRoZSByZWdpc3RlciBjb250cm9scyBib290aW5n
IHRoZSBEU1AgY29yZSB3aXRoIHRoZQ0KPiA+IGRlZmF1bHQgYWRkcmVzcyBvciB0aGUgdXNlciBz
cGVjaWZpZWQgYWRkcmVzcy4gQm90aCBtdDgxODYNCj4gPiBhbmQgbXQ4MTg4IHNob3VsZCBib290
IHdpdGggdGhlIHVzZXIgc3BlY2lmaWVkIGJvb3QgaW4gdGhlIGRyaXZlci4NCj4gPiBUaGUgdXNh
Z2Ugb2YgdGhlIHJlZ2lzdGVyIGlzIHRoZSBzYW1lIG9uIGJvdGggU29DLCBidXQgdGhlDQo+ID4g
Y29udHJvbCBiaXQgaXMgZGlmZmVyZW50IG9uIG10ODE4NiBhbmQgbXQ4MTg4LCB3aGljaCBpcyBi
aXQgMSBvbiBtdDgxODYNCj4gPiBhbmQgYml0IDAgb24gbXQ4MTg4LiBDb25maWd1cmUgdGhlIHJl
ZHVuZGFudCBiaXQgaGFzIG5vc2lkZSBlZmZlY3QNCj4gPiBvbiBib3RoIFNvQ3MuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogVGluZ2hhbiBTaGVuIDx0aW5naGFuLnNoZW5AbWVkaWF0ZWsuY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBQw6l0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNpQGxpbnV4
LmludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJy
ZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogUmFuamFu
aSBTcmlkaGFyYW4gPHJhbmphbmkuc3JpZGhhcmFuQGxpbnV4LmludGVsLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIHNvdW5kL3NvYy9zb2YvbWVkaWF0ZWsvbXQ4MTg2L210ODE4Ni5jIHwgMTcgKysrKysr
KysrKysrKysrKysNCj4gPiAgIHNvdW5kL3NvYy9zb2YvbWVkaWF0ZWsvbXQ4MTg2L210ODE4Ni5o
IHwgIDMgKystDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3NvZi9tZWRpYXRlay9t
dDgxODYvbXQ4MTg2LmMgYi9zb3VuZC9zb2Mvc29mL21lZGlhdGVrL210ODE4Ni9tdDgxODYuYw0K
PiA+IGluZGV4IDc5ZGEyNTcyNTk4Ny4uYWYwZGZjMmZjNGNjIDEwMDY0NA0KPiA+IC0tLSBhL3Nv
dW5kL3NvYy9zb2YvbWVkaWF0ZWsvbXQ4MTg2L210ODE4Ni5jDQo+ID4gKysrIGIvc291bmQvc29j
L3NvZi9tZWRpYXRlay9tdDgxODYvbXQ4MTg2LmMNCj4gPiBAQCAtNjI1LDggKzYyNSwyNSBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHNvZl9kZXZfZGVzYyBzb2Zfb2ZfbXQ4MTg2X2Rlc2MgPSB7DQo+
ID4gICAJLm9wcyA9ICZzb2ZfbXQ4MTg2X29wcywNCj4gPiAgIH07DQo+ID4gICANCj4gPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBzb2ZfZGV2X2Rlc2Mgc29mX29mX210ODE4OF9kZXNjID0gew0KPiA+
ICsJLmlwY19zdXBwb3J0ZWRfbWFzawk9IEJJVChTT0ZfSVBDKSwNCj4gPiArCS5pcGNfZGVmYXVs
dAkJPSBTT0ZfSVBDLA0KPiA+ICsJLmRlZmF1bHRfZndfcGF0aCA9IHsNCj4gPiArCQlbU09GX0lQ
Q10gPSAibWVkaWF0ZWsvc29mIiwNCj4gPiArCX0sDQo+ID4gKwkuZGVmYXVsdF90cGxnX3BhdGgg
PSB7DQo+ID4gKwkJW1NPRl9JUENdID0gIm1lZGlhdGVrL3NvZi10cGxnIiwNCj4gPiArCX0sDQo+
ID4gKwkuZGVmYXVsdF9md19maWxlbmFtZSA9IHsNCj4gPiArCQlbU09GX0lQQ10gPSAic29mLW10
ODE4OC5yaSIsDQo+ID4gKwl9LA0KPiA+ICsJLm5vY29kZWNfdHBsZ19maWxlbmFtZSA9ICJzb2Yt
bXQ4MTg4LW5vY29kZWMudHBsZyIsDQo+ID4gKwkub3BzID0gJnNvZl9tdDgxODZfb3BzLA0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNvZl9v
Zl9tdDgxODZfaWRzW10gPSB7DQo+ID4gICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
ODYtZHNwIiwgLmRhdGEgPSAmc29mX29mX210ODE4Nl9kZXNjfSwNCj4gPiArCXsgLmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ4MTg4LWRzcCIsIC5kYXRhID0gJnNvZl9vZl9tdDgxODhfZGVzY30s
DQo+ID4gICAJeyB9DQo+ID4gICB9Ow0KPiA+ICAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgc29m
X29mX210ODE4Nl9pZHMpOw0KPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc29mL21lZGlhdGVr
L210ODE4Ni9tdDgxODYuaCBiL3NvdW5kL3NvYy9zb2YvbWVkaWF0ZWsvbXQ4MTg2L210ODE4Ni5o
DQo+ID4gaW5kZXggOThiMjk2NWU1YmE2Li44ODZkNjg3NDQ5ZTMgMTAwNjQ0DQo+ID4gLS0tIGEv
c291bmQvc29jL3NvZi9tZWRpYXRlay9tdDgxODYvbXQ4MTg2LmgNCj4gPiArKysgYi9zb3VuZC9z
b2Mvc29mL21lZGlhdGVrL210ODE4Ni9tdDgxODYuaA0KPiA+IEBAIC01Miw3ICs1Miw4IEBAIHN0
cnVjdCBzbmRfc29mX2RldjsNCj4gPiAgICNkZWZpbmUgQURTUF9QUklECQkJMHgwDQo+ID4gICAj
ZGVmaW5lIEFEU1BfQUxUVkVDX0MwCQkJMHgwNA0KPiA+ICAgI2RlZmluZSBBRFNQX0FMVFZFQ1NF
TAkJCTB4MEMNCj4gPiAtI2RlZmluZSBBRFNQX0FMVFZFQ1NFTF9DMAkJQklUKDEpDQo+ID4gKy8q
IEJJVCgxKSBmb3IgbXQ4MTg2LiBCSVQoMCkgZm9yIG10ODE4OCAqLw0KPiANCj4gV2UgY2FuIGJl
IGNsZWFyZXIgaGVyZToNCj4gDQo+ICNkZWZpbmUgTVQ4MTg4X0FEU1BfQUxUVkVDU0VMX0MwCUJJ
VCgwKQ0KPiAjZGVmaW5lIE1UODE4Nl9BRFNQX0FMVFZFQ1NFTF9DMAlCSVQoMSkNCj4gDQo+IC8q
DQo+ICAgKiBPbiBNVDgxODgsIEJJVCgxKSBpcyBub3QgZXZhbHVhdGVkIGFuZCBvbiBNVDgxODYg
QklUKDApIGlzIG5vdCBldmFsdWF0ZWQ6DQo+ICAgKiBXZSBjYW4gc2ltcGxpZnkgdGhlIGRyaXZl
ciBieSBzYWZlbHkgc2V0dGluZyBib3RoIGJpdHMgcmVnYXJkbGVzcyBvZiB0aGUgU29DLg0KPiAg
ICovDQo+ICNkZWZpbmUgQURTUF9BTFRWRUNTRUxfQzAJCShNVDgxODhfQURTUF9BTFRWRUNTRUxf
QzAgfA0KPiAJCQkJCSBNVDgxODZfQURTUF9BTFRWRUNTRUxfQzApDQo+IA0KPiAuLi5zbyB0aGF0
IHdlIGRvbid0IGhhdmUgdG8gY2hlY2sgdGhlIGNvbW1pdCBoaXN0b3J5IHRvIHVuZGVyc3RhbmQg
d2hhdCdzIGdvaW5nDQo+IG9uIGhlcmUsIGFuZCBpdCBiZWNvbWVzIGNsZWFyIHRoYXQgQUxUVkVD
U0VMIGlzIG5vdCBib3RoIGJpdHMsIGJ1dCBvbmUgb2YgdGhlbS4NCj4gDQo+IENoZWVycywNCj4g
QW5nZWxvDQo+IA0KDQpPaywgSSdsbCB1ZHBhdGUgaW4gdGhlIG5leHQgdmVyc2lvbi4NClRoYW5r
IHlvdS4NCg0KLS0NCkJlc3QgcmVnYXJkcywNClRpbmdIYW4NCg==
