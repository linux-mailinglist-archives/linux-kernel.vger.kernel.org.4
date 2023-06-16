Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C0732B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245205AbjFPJS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244520AbjFPJSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:18:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC35226AA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:18:46 -0700 (PDT)
X-UUID: c88a2ace0c2611eeb20a276fd37b9834-20230616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SFdlmVCyCckamm+lKXnhRAg0leRG6PKkVRaewEJPJok=;
        b=YNl4t6zOWf1rOWHcv//2vItQM40Q5eU2oXWaga9f3MaAe/Z0FumBn7IRDFecXVYihZxYW1SZnosi8oo07pSPdAdIoirmOYUr8pgofO13pO61WAu6dXxrsTBdQ/XZlFg00Hv9E/F/qSK+c5L8rVDWK0xpqY5ig3ngN+5Y+shd8Jc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:7f124d59-dbdd-41dc-a12d-2c8d144572b1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:4cfcd53e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c88a2ace0c2611eeb20a276fd37b9834-20230616
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <john.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 725181138; Fri, 16 Jun 2023 17:18:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 17:18:39 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Jun 2023 17:18:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwkV2LqnFL5gmVDrQgDNCdaqt82ewM0GXOma/Do/1Wm25XoDymYcCsWZ7veNsjtCcYOY9KOiq26UqTq3lFFF5ZUKq7AnQzSIqqHWljhPlDHJwmVvPmNybcA/TPSQiGcPwVG2b657++hY60aNtOC6SEfT2vOaKz2fAXRhxYVuEKxm4AqSYLurIKtE0YVXnqD1dC6sIPdvIJ/bfBAfwufSdLD2jLeN2o+iSaQKCZ3Al9+JGLNrmMSfvEAqa4w+WMiPPLoSyZSCbaEtJ5RonYektV26I3yr7xg8WKzLIs4ND0t/7QDKw3z8S91kdeS6rqQ+j3hYlGSyorGAFD1RucByWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFdlmVCyCckamm+lKXnhRAg0leRG6PKkVRaewEJPJok=;
 b=P2n4zduQfzsjNZO2M556wVz+oOCuZVyQWKi8MgcyqcQGwfrq5hpMCzhOt26VmdQ3+jToLt7QSkQkYU63kFPHmfieOoVSR1sTs8sb7blzDO57VOgZ3N4rtnutXjPSPwmOGlKI5JybHcNSBUgOWIhoN7/smGHVCeISHWQXZF70nLj5ZR+9KzPNc/S3hpDMjEkN7OagKJPRCDTlODjJNhuGoF1B5fMl1k/pIXsCyUOJaVyjjERY0r4AxZNe9QXBBXYwPhAyhYnS9AUhGXVSF/1HMf6S0VbkjqQoGym/IYDfdciKciqHk1S23xViPfitC7mc4Gvx2Oq62Ih0NuqP27IDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFdlmVCyCckamm+lKXnhRAg0leRG6PKkVRaewEJPJok=;
 b=hr++UQ7ibawpBry+RdHr1C/LuMLxRPu4Jfs8HcvIGZ7t8INc32rStvhWZwMZGb3qosdxaeF8kZJlTyb1JEaSCbkXyw1VllP05M6f7bmMk/UE30QyE+1SB4ffgBupRM5e0dsL7aGPrVO0ZR7LsUx+idyZWaVDSWOf9F+4EDc4Rs0=
Received: from PUZPR03MB5963.apcprd03.prod.outlook.com (2603:1096:301:b3::11)
 by PSAPR03MB5414.apcprd03.prod.outlook.com (2603:1096:301:47::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 09:18:37 +0000
Received: from PUZPR03MB5963.apcprd03.prod.outlook.com
 ([fe80::8a5d:6e63:e180:1c57]) by PUZPR03MB5963.apcprd03.prod.outlook.com
 ([fe80::8a5d:6e63:e180:1c57%4]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 09:18:37 +0000
From:   =?utf-8?B?Sm9obiBIc3UgKOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
To:     "Liam.Howlett@Oracle.com" <Liam.Howlett@Oracle.com>
CC:     =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Thread-Topic: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Thread-Index: AQHZmq2hr8VIEXfZDUmuykLw57Rh9K+IzHcAgAEbhYCAAJTEAIACtPMA
Date:   Fri, 16 Jun 2023 09:18:37 +0000
Message-ID: <ed7899c7328aabfbe9bc9589f0776a75e6c9d1ee.camel@mediatek.com>
References: <9cb8c599b1d7f9c1c300d1a334d5eb70ec4d7357.camel@mediatek.com>
         <20230613141114.bwbnqsdazqbmyj3u@revolver>
         <3b14df2fc2a7f18fe12f87a27574b7d40f2899ba.camel@mediatek.com>
         <20230614155826.cxcpv33hs763gyrg@revolver>
In-Reply-To: <20230614155826.cxcpv33hs763gyrg@revolver>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5963:EE_|PSAPR03MB5414:EE_
x-ms-office365-filtering-correlation-id: 458a7f5d-d45c-46b3-a313-08db6e4aaad2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jwbiU/JpV6l+iOV72cBrxlmzP4A7ABYhHFK2VeLIk7wYzkHNpHUsdPINO/q4loTofFg0aKxEdYPUbPc/m7VFk8Ucu0Rnq+3iiN35iZ3AfkBwirIclkQdMWQA0zg/JJALGfV7ARyvcAveajhC1qWAcr5thvrs+DvH4shudW8aMSgzyfzZFz8ZRTLdtwZ5N5inrtmJa2zcQ2JBM5hftRZTADp/1pKK+x4H28SP9rPYoN6efdBkYUzryPCywvT/L0+0n4peNSHkie6mS2e70qc+qIWVPxB04zlZuFnZOqXb7BslVvuIA0KjqJkzH22D75ThcMQww+SPmEVSKcPxpNtZQ0EEvsuldvzlUVrOXwKrk8HsFfahJuqr2UEaUhnoMGxB9g/OW5t4qX9rRMC1e7V9DO/54CzZ7JChPFe/yD49lZg+CyTph2cTES1XFymyGKm9IlpB4ZDEJ1cUNA06CFHTaUD0SODbYM13MV5SGgUAM3i7oZ67UuBkAZ5wLY4HGsv/6e2RYt3WPuxlaff80hc1DPqIk2p4C3NNdHn4nA2e/TLPX9+HEcFaHHdoOvQsThgdfbp0cAwYbh2U2tbtJoN+/HQKHKrF/W+Q1bGuCwzjUh1divnMxdPJg4sH67LLWZidWntGIAeOa2Cj0nwUzgIJGbIpjwbjF8Ht6/rI73PxPYE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5963.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(478600001)(54906003)(122000001)(6486002)(5660300002)(8936002)(8676002)(85182001)(36756003)(2906002)(38070700005)(86362001)(41300700001)(38100700002)(66476007)(66556008)(64756008)(66446008)(316002)(6916009)(66946007)(4326008)(76116006)(91956017)(71200400001)(26005)(186003)(6512007)(6506007)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uy9hcEF2dEl6akQrbFQ1UE8ra2tXUU5RM2ViN1FqcUExd2FSQklkbmJxYTdS?=
 =?utf-8?B?UDFLRDhYMEY4cWZmSEFCRUhCdXFOQ1JkRlo0eGViSEtxZFRsMnVDbEpxQVd4?=
 =?utf-8?B?WXdaSlM2NDFLM1BoWWQ2VTN1ZUFuMi9yVXhCRzROb3c5c2ZhdGswRFh2MjBD?=
 =?utf-8?B?R1h1ZTk4MVFVQVE3U0lJenVnQ2NwN0t0RVhrNk41NWtoYjFwNld3WkpxUzZq?=
 =?utf-8?B?V0FhbGhrOTkrT296RkxiOVJlSVBUUVJNVU9NRWxRMDNzRTBzbUl5QUZnRzZQ?=
 =?utf-8?B?bndDQTRUM21DSTE4dGlqbnBBaW5CY1F3bXo5QXJ6VUoxK09JMUNkMUF6MlJD?=
 =?utf-8?B?a1JwSlBXbmNYMGJuNnFVV05TblFudkFYeU1qSlNESHE4T2RVcnNqMnRlKzBY?=
 =?utf-8?B?WERHUmZ2b2dnSGdPWTh0THVVWXdTUzhDd0ZNaHBsVXdIZ0JucExFWFBWMnNI?=
 =?utf-8?B?OThMb1JsQXVsR1IyWWlRY1ZkMjFkZE5ua0luZ20vaHIvVW1FRENJZUorWnA3?=
 =?utf-8?B?eTkyOC93SWZuMXdZZ1lZRkJPMW03UG04N1RXelR5bGNtRlROUUdVZlZOVzhn?=
 =?utf-8?B?OXhxZ2pJcW5GT2tjb2ozaWp3OHZ1T2o0cDh0c1Z1VndJbHg3VzNzaXNsY1BF?=
 =?utf-8?B?V0cvT1I2aHhGQU5vSlBvUUxVK1czcGwzdnVITGQvV0FBaFpLYUY5VWtsVFMr?=
 =?utf-8?B?Ui9DamNFR2lKbGw3bjMwVTlrYzV5MXI2WFBOZVlzc0tPZUIzYkRsM3ZHNGdL?=
 =?utf-8?B?N2V5VEdMYmtHR2tFWVdEVjl2TjhCUS93K0cySHkvMkd5bUlQVTVPaTdiY3hX?=
 =?utf-8?B?aWFLamN4VlF5UitjUmV4UEhvSnNxcWpkZXVNN0ZnbDJZSkNDM2tEdVpVQXhG?=
 =?utf-8?B?L0ozSk5yY0JLTTdDQmNIWGlhVWVNNndpR2RMc0h2R1c1czlrZGZhL2FDK3p4?=
 =?utf-8?B?RzRjZ2pzWnJGTUpyS2c3enV4VC9VeDVPMnVEa2hKdzhUUlI4ak5KN3p1blp4?=
 =?utf-8?B?ZUJuUkpEOUU5dGY5bDR5dGs4eXNGVlBwT2J6MlNxNWZRdm1LZk9kTHFwRkN5?=
 =?utf-8?B?MGdhKzlweFBWeEpFWHBhc1B4d2pFaXMxY3ErYXg2VUNKU3dTOFpubXVqWjJu?=
 =?utf-8?B?emZXVStTRi9UN1cvRXRwQThBM0RMQ0l0OWE3UGxwaEp2Q25GWVJRR1ZwK2ZX?=
 =?utf-8?B?TFMzZm01NXg5VEFWOXlLY0ZFSmwxK1NVVFNkcWVlaWNJd1o2ZGdIcHFTYkkx?=
 =?utf-8?B?MmsvRWhBSU13MDEyUWJ6cHFrc0hiNzlpaVFwK0J0Vjh3SVdSdVlMdXVmeHZV?=
 =?utf-8?B?a1Bjby9iOXVlWnhpcGZYSmg3Nytoems1akk2RFA5ZU1iWGpHMnc5SExaTjNu?=
 =?utf-8?B?Q1I0R2lsWnJtMTVsSzYreTRYelRpUlpSOUttSkQvZTlGaVFCYW4wZjU0bDBC?=
 =?utf-8?B?TjZrTHlhNE84bHR1ZUZrMXY5Q0hVSVZ4SENVc1ZGZ3RvWkVGN3llODJrTFFF?=
 =?utf-8?B?RHR1ZXRiUDRyWnNXZlJCY1U5ZHJsWmMrbTZaZThla2Q4VW5YaE1JWDJIRnNK?=
 =?utf-8?B?Z0xPQlZ0Y1pYbEZjQVRzV3ZaUFYyY2hweW11TlJMN1NkUzFZV1JQRW5zYnlj?=
 =?utf-8?B?SEgzSlRELzFNY3JYZjJNbS91c0N2ODBtUVp3dVoremgxbm9LclYwRGNTM2RM?=
 =?utf-8?B?bXRHeDg4QTNMa0FyaVhTOFpjbEhGb2NLcWY0cnNSMjlFbHZIRUdNT05iTXpS?=
 =?utf-8?B?TExZKzJndlpjcnExdGJ6SVEyNzhud3NaQ2h6Wmx6MVFwaXk0V204dU96Wm5x?=
 =?utf-8?B?anVjdGxLMFQwcG9iQldLdzIzcExYSzNPdmY2RUx4VGhqRCtscHJ6MERrU3Nv?=
 =?utf-8?B?eDZSZ1QzVDV5aFJ6ZXBMQ1lLQzdoZ1R6Y1pXakdwenBZOFdYUXdFZUJyeVJl?=
 =?utf-8?B?eVA1RlBxeFVKd3ZoMlF1S2ZiQ3htblZrMU5IS1hRQjFaOXg1Zkh6VFBzakJ1?=
 =?utf-8?B?bFFrMkc0ZStnUnpNUyt5cGpjUXFKTkMrcENHbGx5N1YydENlUG1na0JRVDdH?=
 =?utf-8?B?L25IbVdSYStJYkt0cU5VTWMvYjRRWUpLWnFVaGI5d3Q0VklsUzFXOHJoNThk?=
 =?utf-8?B?c2NJMUVZSmZjejkxZnRZR3dwWk80aEZPcWk2OXlZUlJ5ejAyVFBNNTdleklP?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C2361455B37AE498AD4F7720160765B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5963.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458a7f5d-d45c-46b3-a313-08db6e4aaad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 09:18:37.5354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KJVpAWXLoERuKVybHrm60iKa7/RROur+AG74dyk85+tKEY04M1MN3zLO8K/66lszA+oC9GZUC7aPmbgyueomQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5414
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDExOjU4IC0wNDAwLCBMaWFtIFIuIEhvd2xldHQgd3JvdGU6
DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiAgKiBKb2huIEhzdSAo6Kix5rC457+wKSA8Sm9obi5Ic3VAbWVkaWF0
ZWsuY29tPiBbMjMwNjE0IDAzOjA2XToNCj4gPiBIaSBMaWFtLCB0aGFua3MgZm9yIHlvdXIgcmVw
bHkuDQo+IA0KPiBTb3JyeSwgeW91ciBlbWFpbCByZXNwb25zZSB3aXRoIHRvcCBwb3N0aW5nIGlz
IGhhcmQgdG8gZm9sbG93IHNvIEkNCj4gd2lsbA0KPiBkbyBteSBiZXN0IHRvIGFuc3dlciB5b3Vy
IHF1ZXN0aW9ucy4NCg0KU29ycnkgZm9yIHRoZSB3cm9uZyBmb3JtYXQuLi4uDQoNCj4gPiANCj4g
PiANCj4gPiANCj4gPiB2ZXJzaW9uIDYuMSBvciA2LjEueD8gIFdoaWNoIGV4YWN0IHZlcnNpb24g
KGdpdCBpZCBvciB2ZXJzaW9uDQo+IG51bWJlcikNCj4gPiANCj4gPiBPdXIgZW52aXJvbm1lbnQg
aXMga2VybmVsLTYuMS4yNS1tYWlubGluZS1hbmRyb2lkMTQtNS0NCj4gZ2RlYTA0YmYyYzM5OGQu
DQo+IA0KPiBPa2F5LCBJIGNhbiBoYXZlIGEgbG9vayBhdCA2LjEuMjUgdGhlbi4NCg0KT0ssIHRo
YW5rcy4NCg0KPiA+IA0KPiA+IA0KPiA+IFRoaXMgQlVHX09OKCkgaXMgbmVjZXNzYXJ5IHNpbmNl
IHRoaXMgZnVuY3Rpb24gc2hvdWxkIF9uZXZlcl8gcnVuDQo+IG91dCBvZg0KPiA+IA0KPiA+IG1l
bW9yeTsgdGhpcyBmdW5jdGlvbiBkb2VzIG5vdCByZXR1cm4gYW4gZXJyb3IgY29kZS4NCj4gbWFz
X3ByZWFsbG9jYXRlKCkNCj4gPiANCj4gPiBzaG91bGQgaGF2ZSBnb3R0ZW4geW91IHRoZSBtZW1v
cnkgbmVjZXNzYXJ5IChvciByZXR1cm5lZCBhbg0KPiAtRU5PTUVNKQ0KPiA+IA0KPiA+IHByaW9y
IHRvIHRoZSBjYWxsIHRvIG1hc19zdG9yZV9wcmVhbGxvYygpLCBzbyB0aGlzIGlzIHByb2JhYmx5
IGFuDQo+ID4gDQo+ID4gaW50ZXJuYWwgdHJlZSBwcm9ibGVtLg0KPiA+IA0KPiA+IFRoZXJlIGlz
IGEgdHJlZSBvcGVyYXRpb24gYmVpbmcgcGVyZm9ybWVkIGhlcmUuICBtcHJvdGVjdCBpcw0KPiBt
ZXJnaW5nIGENCj4gPiANCj4gPiB2bWEgYnkgdGhlIGxvb2tzIG9mIHRoZSBjYWxsIHN0YWNrLiAg
V2h5IGRvIHlvdSB0aGluayBubyB0cmVlDQo+IG9wZXJhdGlvbg0KPiA+IA0KPiA+IGlzIG5lY2Vz
c2FyeT8NCj4gPiANCj4gPiBBcyB5b3UgbWVudGlvbmVkLCBtYXNfcHJlYWxsb2NhdGUoKSBzaG91
bGQgYWxsb2NhdGUgZW5vdWdoIG5vZGUsDQo+IGJ1dCB0aGVyZSBpcyBzdWNoIGZ1bmN0aW9ucyBt
YXNfbm9kZV9jb3VudCgpIGluIG1hc19zdG9yZV9wcmVhbGxvYygpLg0KPiA+IEluIG1hc19ub2Rl
X2NvdW50KCkgY2hlY2tzIHdoZXRoZXIgdGhlICptYXMqIGhhcyBlbm91Z2ggbm9kZXMsIGFuZA0K
PiBhbGxvY2F0ZSBtZW1vcnkgZm9yIG5vZGUgaWYgdGhlcmUgd2FzIG5vIGVub3VnaCBub2RlcyBp
biBtYXMuDQo+IA0KPiBSaWdodCwgd2UgY2FsbCBtYXNfbm9kZV9jb3VudCgpIHNvIHRoYXQgYm90
aCBjb2RlIHBhdGhzIGFyZSB1c2VkIGZvcg0KPiBwcmVhbGxvY2F0aW9ucyBhbmQgcmVndWxhciBt
YXNfc3RvcmUoKS9tYXNfc3RvcmVfZ2ZwKCkuICBJdCBzaG91bGRuJ3QNCj4gdGFrZSBhIHNpZ25p
ZmljYW50IGFtb3VudCBvZiB0aW1lIHRvIHZlcmlmeSB0aGVyZSBpcyBlbm91Z2ggbm9kZXMuDQoN
CllhcC4uLiwgaXQgZGlkbid0IHRha2UgYSBzaWduaWZpY2FudCBhbW91bnQgb2YgdGltZSB0byB2
ZXJpZnkgd2hldGhlcg0KdGhlcmUgaXMgZW5vdWdoIG5vZGVzLiBUaGUgcHJvYmxlbSBpcyB3aHkg
dGhlIGZsb3cgaW4gbWFzX25vZGVfY291bnQNCndpbGwgYWxsb2Mgbm9kZXMgaWYgdGhlcmUgd2Fz
IG5vIGVub3VnaCBub2RlcyBpbiBtYXM/DQoNCj4gPiBJIHRoaW5rIHRoYXQgaWYgbWFzX3ByZWFs
bG9jYXRlKCkgYWxsb2NhdGUgZW5vdWdoIG5vZGUsIHdoeSB3ZQ0KPiBjaGVjayB0aGUgbm9kZSBj
b3VudCBhbmQgYWxsb2NhdGUgbm9kZXMgaWYgdGhlcmUgd2FzIG5vIGVub3VnaCBub2Rlcw0KPiBp
biBtYXMgaW4gbWFzX25vZGVfY291bnQoKT8NCj4gDQo+IFdlIGNoZWNrIGZvciB0aGUgYWJvdmUg
cmVhc29uLg0KPiANCg0KT0suLi4sIHRoaXMgaXMgb25lIG9mIHRoZSByb290IGNhdXNlIG9mIHRo
aXMgQlVHLg0KDQo+ID4gDQo+ID4gV2UgaGF2ZSBzZWVuIHRoYXQgdGhlcmUgbWF5IGJlIHNvbWUg
bWFwbGVfdHJlZSBvcGVyYXRpb25zIGluDQo+IG1lcmdlX3ZtYS4uLg0KPiANCj4gSWYgbWVyZ2Vf
dm1hKCkgZG9lcyBhbnl0aGluZywgdGhlbiB0aGVyZSB3YXMgYW4gb3BlcmF0aW9uIHRvIHRoZQ0K
PiBtYXBsZQ0KPiB0cmVlLg0KPiANCj4gPiANCj4gPiBNb3Jlb3Zlciwgd291bGQgbWFwbGVfdHJl
ZSBwcm92aWRlcyBhbiBBUEkgZm9yIGFzc2lnbmluZyB1c2VyJ3MgZ2ZwDQo+IGZsYWcgZm9yIGFs
bG9jYXRpbmcgbm9kZT8NCj4gDQo+IG1hc19wcmVhbGxvY2F0ZSgpIGFuZCBtYXNfc3RvcmVfZ2Zw
KCkgaGFzIGdmcCBmbGFncyBhcyBhbg0KPiBhcmd1bWVudC4gIEluDQo+IHlvdXIgY2FsbCBzdGFj
aywgaXQgd2lsbCBiZSBjYWxsZWQgaW4gX192bWFfYWRqdXN0KCkgYXMgc3VjaDoNCj4gDQo+IGlm
IChtYXNfcHJlYWxsb2NhdGUoJm1hcywgdm1hLCBHRlBfS0VSTkVMKSkNCj4gcmV0dXJuIC1FTk9N
RU07DQo+IA0KPiBsaW5lIDcxNSBpbiB2Ni4xLjI1DQo+IA0KPiA+IEluIHJiX3RyZWUsIHdlIGFs
bG9jYXRlIHZtYV9hcmVhX3N0cnVjdCAocmJfbm9kZSBpcyBpbiB0aGlzDQo+IHN0cnVjdC4pIHdp
dGggR0ZQX0tFUk5FTCwgYW5kIG1hcGxlX3RyZWUgYWxsb2NhdGUgbm9kZSB3aXRoDQo+IEdGUF9O
T1dBSVQgYW5kIF9fR0ZQX05PV0FSTi4NCj4gDQo+IFdlIHVzZSBHRlBfS0VSTkVMIGFzIEkgZXhw
bGFpbmVkIGFib3ZlIGZvciB0aGUgVk1BIHRyZWUuDQoNCkdvdCBpdCEgQnV0IHRoZSBtYXNfbm9k
ZV9jb3VudCgpIGFsd2F5cyB1c2UgR0ZQX05PV0FJVCBhbmQgX19HRlBfTk9XQVJODQppbiBpbnNl
cnRpbmcgdHJlZSBmbG93LiBEbyB5b3UgY29uc2lkZXIgdGhlIHBlcmZvcm1hbmNlIG9mIG1haW50
YWluaW5nDQp0aGUgc3RydWN0dXJlIG9mIG1hcGxlX3RyZWU/DQoNCj4gSXQgYWxzbyB3aWxsIGRy
b3AgdGhlIGxvY2sgYW5kIHJldHJ5IHdpdGggR0ZQX0tFUk5FTCBvbiBmYWlsdXJlDQo+IHdoZW4g
bm90IHVzaW5nIHRoZSBleHRlcm5hbCBsb2NrLiAgVGhlIG1tYXBfbG9jayBpcyBjb25maWd1cmVk
IGFzIGFuDQo+IGV4dGVybmFsIGxvY2suDQo+IA0KPiA+IEFsbG9jYXRpb24gd2lsbCBub3Qgd2Fp
dCBmb3IgcmVjbGFpbWluZyBhbmQgY29tcGFjdGluZyB3aGVuIHRoZXJlDQo+IGlzIG5vIGVub3Vn
aCBhdmFpbGFibGUgbWVtb3J5Lg0KPiA+IElzIHRoZXJlIGFueSBjb25jZXJuIGZvciB0aGlzIGRl
c2lnbj8NCj4gDQo+IFRoaXMgaGFzIGJlZW4gYWRkcmVzc2VkIGFib3ZlLCBidXQgbGV0IG1lIGtu
b3cgaWYgSSBtaXNzZWQgYW55dGhpbmcNCj4gaGVyZS4NCj4gDQoNCkkgdGhpbmsgdGhhdCB0aGUg
bWFzX25vZGVfY291bnQoKSBoYXMgaGlnaGVyIHJhdGUgb2YgdHJpZ2dlcmluZw0KQlVHX09OKCkg
d2hlbiBhbGxvY2F0aW5nIG5vZGVzIHdpdGggR0ZQX05PV0FJVCBhbmQgX19HRlBfTk9XQVJOLiBJ
Zg0KbWFzX25vZGVfY291bnQoKSB1c2UgR0ZQX0tFUk5FTCBhcyBtYXNfcHJlYWxsb2NhdGUoKSBp
biB0aGUgbW1hcC5jLCB0aGUNCmFsbG9jYXRpb24gZmFpbCByYXRlIG1heSBiZSBsb3dlciB0aGFu
IHVzZSBHRlBfTk9XQUlULg0KDQo+ID4gDQo+ID4gDQo+ID4gSSBzZWUgdGhpcyBpcyBhcm02NC4g
IERvIHlvdSBoYXZlIGEgcmVwcm9kdWNlcj8gIElmIHlvdSBkb24ndCBoYXZlDQo+IGENCj4gPiAN
Cj4gPiByZXByb2R1Y2VyLCBJIGNhbiB0cnkgc3RyZXNzLW5nIG9uIGFtcjY0IHRvIHNpbXVsYXRl
IHlvdXIgd29ya2xvYWQNCj4gdXNpbmcNCj4gPiANCj4gPiBtcHJvdGVjdCwgYnV0IEkgbmVlZCB0
byBrbm93IHRoZSBleGFjdCBrZXJuZWwgdmVyc2lvbiBhcyB0aGlzIGlzc3VlDQo+IG1heQ0KPiA+
IA0KPiA+IGhhdmUgYmVlbiBmaXhlZCBpbiBhIGxhdGVyIHN0YWJsZSByZWxlYXNlLg0KPiA+IA0K
PiA+IEl0IGlzIG9mZmVuIG9jY3VyIHVuZGVyIGxvdyBtZW1vcnkgY29uZGljdGlvbi4gTWF5YmUg
eW91IGNhbiB0cnkNCj4gc3RyZXNzLW5nIG9uIGFybTY0IHVuZGVyIGhpZ2ggbWVtb3J5IHN0cmVz
cyhlLmcuIHJlc2VydmVkIGxvdHMgb2YNCj4gbWVtb3J5KS4NCj4gDQo+IE9rYXksIEkgd2lsbCB0
cnkgYXJtNjQgd2l0aCB2Ni4xLjI1Lg0KDQpPSywgdGhhbmtzLg0KPiAuLi4NCj4gPiA+IGZvbGxv
d2luZyBhcmUgdGhlIGJhY2t0cmFjZToNCj4gPiANCj4gPiA+IG1hc19zdG9yZV9wcmVhbGxvYysw
eDIzYy8weDQ4NA0KPiA+IA0KPiA+ID4gdm1hX21hc19zdG9yZSsweGU0LzB4MmQwDQo+ID4gDQo+
ID4gPiBfX3ZtYV9hZGp1c3QrMHhhYjAvMHgxNDcwDQo+ID4gDQo+ID4gPiB2bWFfbWVyZ2UrMHg1
YjgvMHg1ZDQNCj4gPiANCj4gPiA+IG1wcm90ZWN0X2ZpeHVwKzB4MWY0LzB4NDc4DQo+ID4gDQo+
ID4gPiBfX2FybTY0X3N5c19tcHJvdGVjdCsweDZiMC8weDhmMA0KPiA+IA0KPiA+ID4gaW52b2tl
X3N5c2NhbGwrMHg4NC8weDI2NA0KPiA+IA0KPiA+ID4gZWwwX3N2Y19jb21tb24rMHgxMTgvMHgx
ZjANCj4gPiANCj4gPiA+IGRvX2VsMF9zdmMrMHg1Yy8weDE4NA0KPiA+IA0KPiA+ID4gZWwwX3N2
YysweDM4LzB4OTgNCj4gPiANCj4gDQo+IFRoYW5rcywNCj4gTGlhbQ0KDQpCUnMsDQpKb2huIEhz
dQ0K
