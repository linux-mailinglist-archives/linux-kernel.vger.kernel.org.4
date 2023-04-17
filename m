Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92DC6E3D88
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDQCov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQCos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:44:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F9E1FFE;
        Sun, 16 Apr 2023 19:44:46 -0700 (PDT)
X-UUID: cd2acb9cdcc911edb6b9f13eb10bd0fe-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bl2XIiJvBE0v4Y52MpO60SbVdY8OrnLiQ61VeOEUMAI=;
        b=K1JFmRqPld1iKFWlold4AKLmYJJ0HLUgusNxgeTUoOSMOGTIRFbYBGGxxwBjxxr+itvqYVpsN2f/5sDThbUvz+hmN4Lh32+72wtdc+/9uGiqV81NWweB4/VHxuV6g69Kv2lwv2ryjVgqIIyZWfgdYshXtw73NWh1CCsiXjfPSIU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:9590d3e1-7548-478b-ab1f-8be81b031d19,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:b4c627eb-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: cd2acb9cdcc911edb6b9f13eb10bd0fe-20230417
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1096249071; Mon, 17 Apr 2023 10:44:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 10:44:39 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 10:44:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayqr6lcaTZWlXO5jelLQf+vPgZDLJ0RGtW0xXJoXijWSKFXzdHq0ZnyJJrNjOzS//ZNZkuRGBoBylR9z9/gP5xlGlxfitz8nroO4+ZfslKo95SNbxQD888ShJsKTq5qc6cgbtNAwH0+kKXNDXNbMhNpKXEbzAji346Lj1CKTPCwS+Y+rz+t+sYpwK/Bb7/5cnwUf4jck0OZBQKF6hG155VqNKeMAsguM+IOUtIM2pNR68ddQiytzhXgpVGkFFew4qZFkKXb9XUO9HzwHW8jYbX6gCP4twqVWBEO/XG+fYooBR44krEGPtCCBoztpBbxvvvxLNGDyUdKzkKZC+QZZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl2XIiJvBE0v4Y52MpO60SbVdY8OrnLiQ61VeOEUMAI=;
 b=CyFlezQYNNOH4E3vPEpOHxuXy/0bAd1SbQ8GoGZ2S4kUD0hrppkg8mgahJZMgWM3xMs6KAHbkj/Po5K5uYx7/4LKkCDGFRkMYI1eF+KtuNc0i6oO+FnJ2uNNiWSP88OgnIIflh9J3fa8I3CWoGZlN2FutYjywLJrLQ5Mq9roPfvIi+zmPSDzIy7Vcd9ipDmR0ORDfJRGC0uX6OLJBhYeu/mCoKTp3S/kLyOfFiqQGL19pcgb29fWDio0KpIo/8QdV2wTjrXvDJTeUvxTqHi5AqUVpCkud4KifnMTlqEDElMKtXThoD/b+UPythTbXqbL5CZEaVtdf+btmhwvd0zAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl2XIiJvBE0v4Y52MpO60SbVdY8OrnLiQ61VeOEUMAI=;
 b=q7YIcP+DtmB3efaHNoWhnfkeS4lkFhZXzUV1VN+Hifb0u4hRLfvr+sXgF4q4BypOEjfHzcBnHCU0rVHjDHme9uY8OId1OSA091hKSUbSbM2F2f+PdwUGIsQVRO7QK4NCzdTlpOo/qmbRAbuHiUDrUfPvFxyf9MGqI78cDwsMllM=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SEZPR03MB7217.apcprd03.prod.outlook.com (2603:1096:101:ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 02:44:37 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 02:44:36 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
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
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Thread-Topic: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Thread-Index: AQHZbfV6H4OsAA5wEEW0uLoJpPACoq8sFaCAgAK7jIA=
Date:   Mon, 17 Apr 2023 02:44:36 +0000
Message-ID: <b9daeea6d823b8e84db0ca0df0e04d3716a6b944.camel@mediatek.com>
References: <20230413104713.7174-1-trevor.wu@mediatek.com>
         <20230413104713.7174-8-trevor.wu@mediatek.com>
         <310e8979-de96-dda8-6c95-0e6033d8b403@linaro.org>
In-Reply-To: <310e8979-de96-dda8-6c95-0e6033d8b403@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SEZPR03MB7217:EE_
x-ms-office365-filtering-correlation-id: a19334aa-1c63-4381-be99-08db3eedaf0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BFBf6TPvE68vAIoMHc098gKuAJqWcxzQxXazkx9a4hGrT8Y3v0O0hKgIXcmhmoLXkwEf+yFcJ8CcxAQ/pOBskNPaRhILfujrolzCYHOEhw+YsAaW70OL6SwO3JU4mOTgUfevmTNi++SCiPy8aLb1DrPhuiiUCY0jIswEe2VeC/HK6ELU8ayi8+i9jywRsGeKB9zDiLRT/srVDA11OA67VPsan3JAhRD10vGqsPRxbntQWNjirCg9OrY4lCRkERb2QnWdhJAtll08vvJlDVCiKIyMzIqBh424w/wa3iB3mZfssq+cTHtVgfQ3iCq0oqJCpF1sUXk0OgsfvRHeg1zMhcsHv4UmrPHIYbKloGrnU+1MNXAGfRWlQuhVBfLd5m323b/VlOtKbIVtf9MoONZozVK3/YNgk+NaenZ0mewk+c7Tm7OczxCgBo/gjrDLIc2vlDG72uvLfI71uszMvjkczD7U5OpuwppfYKhFgrmCzMN8zNXKaC2R2FsxtW0U/995srnOdIXl4N8sUdvAQa3uLhdl0TOP6mSsSWCQmOgBK9UtNGvnt38+qKZUsg4eV6oF7aCaPnjv0dJGxvCdF7FNZ65FOx0PoqsqyLTVB9UM2pt+D3NcqQh/UtmxjrC3xh3NxHFmXnY/PfbBa9p69WSrQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(5660300002)(71200400001)(6486002)(66476007)(66556008)(2906002)(85182001)(66946007)(4326008)(76116006)(91956017)(64756008)(36756003)(66446008)(7416002)(86362001)(38070700005)(122000001)(38100700002)(41300700001)(478600001)(8676002)(316002)(8936002)(54906003)(53546011)(110136005)(6506007)(6512007)(26005)(2616005)(186003)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0NJR2V2RGhpOU8rVTA2OTZuZEFlUlJnUE1WSGFPZFg3aStQTk5ITEovV1ZI?=
 =?utf-8?B?dFZ2VXNYeXRTWUlJY0hmZklrY2ZjQ2ZIR0dZaDV2OVh0OTlrbnRra1k0Smsv?=
 =?utf-8?B?dHgxdFJ2Q3V3MzNYNUdScHlhRlVFV2J6bVVnTDN3VE1COTg0WkMxemFuNjB4?=
 =?utf-8?B?ZGJaK2RHMnNuemlmU2pZNnJiT2s1TFdYSTVvTkhVeXBrV2tENm5ER1MwWU0r?=
 =?utf-8?B?dmpLd0VtMWw4eUFBOC9KM0dxYjdURkszVEx6aU1uOHhtMVNoZ3h5Tm5IR2hD?=
 =?utf-8?B?bzBqR25VdjhyRXRvSjVSOWQ0eTZOWm5XODVLZGpERmhRSUxZc3I2NXBSYUx5?=
 =?utf-8?B?aHhmV1VGbDRTVUhObFYvMGtjUjdFOTlVaU1nT0pRUzB3UWZlRk5Jbmc4YmNW?=
 =?utf-8?B?Z0ovbnNSV0xHSFh2TDZPVXIwMDI1WnVLUG5ScjczSEhpaGVFZ3Zpd0J4Szlu?=
 =?utf-8?B?VTh3UlVCM3B1RGptNE5UcjIzaDRzbFJncmdmRTN0ck5KL2Q4RVUvOEFqWXEx?=
 =?utf-8?B?cXpSY1UxMEliSUtCdHlqWkxyNUFGa2JQOG9rWGlnYTdGYm0rQnNMRUZDclBm?=
 =?utf-8?B?Z2NoK3l4MHNuSE9NQVBoTVF6MkQzZy9OdjBOeWtmaVBlVTVmM1BtNkJ4QVZp?=
 =?utf-8?B?MG0vdTdRZExQVk5NaTRmUDVvbHdiR1FyeTdaNHJSV3pwT0FZOWhiNmRNdTRr?=
 =?utf-8?B?cnZKRmp3YlVvbnpyWUJob2pqRG4vejlDOCtmVzRVaXhYZ09CTXlpeG5GcFE3?=
 =?utf-8?B?VWlhRUhEeVBhMU5BWXlNTHUrcFVWdWo5aTJGWGFITzd0c1lQVTA1aEQ4QjRO?=
 =?utf-8?B?V0YrZy9yZkhUdzZJZHZteGVUQmEwb1hsNlJ3YVUxb1lHdXliRGwzNVJ6TmVv?=
 =?utf-8?B?NklDL0xnSXN6Z1FYUktBRS9RK0g0Y2RiMG5IK20ydG81THhrWnB2MGo5VWFS?=
 =?utf-8?B?bUxGenV1aTJTL2Npem54NTdTOXlZWTJpMmJ0RGsrUjBIOHlNZXg4aE5pZlY1?=
 =?utf-8?B?Z3R0eVFnR0psekhyMC94Mnp0d3FhQm96RWNQVHNKUk0vRG9CVE1RZ1lSblRV?=
 =?utf-8?B?cE5HNmttZHBYODFVdnBBSmpZYVkxRTE5RXRvaGlXUUJQUXZoWGVkQzNPeVhT?=
 =?utf-8?B?UkFNQ292eWVWYVE5T0pvRjBWN0FVMDkxNStNcXFza1NFb2lFVFl6dEx1ZUUx?=
 =?utf-8?B?ZUhWRmxtVHZPUkxSaGhOeS8yMCtSU0JHNVV6SStBM3ZCYXcrSE5NWVBXa3pQ?=
 =?utf-8?B?U2hVUkJQVlZsdUE1Y3FuRmNRR0JvN2pKOWFYSTB4S0xIRFB3Y1RMUUpIcnVV?=
 =?utf-8?B?ejBrV2FDTW04bXFiMnAxUHoybDRRNWwxdzE1RXRRVlNzaEs0dndIcVJ2NEdj?=
 =?utf-8?B?d0wwVzlHblFTRW9rT3E0YWVCRzBOS0RMNDV2ZTBzMHNUN3luQm02M0RFVSsw?=
 =?utf-8?B?SFFSQ0c4ZkxKWENPcDFYUVQwZlFNLzlXSmJRQXBCQWhzbXd3MktwU1JmZ1E4?=
 =?utf-8?B?cEEyY1IvM0d6K0VvYytmV0htaGhPUFQvNjhFQ0RLN3pBT21jYU9OQ2JENHhw?=
 =?utf-8?B?dGxBaHk5SzVRbWcwcTh2U0s5STRha1gyWFExT2FlMHY4QVlscXhpUzI5eTNl?=
 =?utf-8?B?azlPa2RwUG1sS04vM09WSnl0WGUzcCtZdEc2bzlzeTk2cEtRdUtuZzRKUlpK?=
 =?utf-8?B?M3g0NVp5aysxQStUMnFFeVJMTTAva3NQdTRkWFNvY0J4bmw1QlhUYlN6UlUv?=
 =?utf-8?B?eGJPVmZwZ2t1eDdLK2Y2S2VrSjI2WHpQQk9qSC9xMFlFcnBCUW5RQmh1U3I0?=
 =?utf-8?B?MEZXaXY2d3ppMzlGZ1NQbjk5aFZWQnVPaEpCd25PODZYem9IZXBwNHA3TDQ3?=
 =?utf-8?B?SDg4UGY3Sno0QnlHVjQycnJhL2FhN1JuUmFMTkZzN3FLU24rTlRrWldDZm9Y?=
 =?utf-8?B?S1hjQ1dDOWQrMlp3aGd1ZEx0YU91MUJjVkRWZUhieHloM1Q5MzhkV3BpZ242?=
 =?utf-8?B?YWtkTzczOTc0b3o1WFBvK1FGM0Myck5KZmkzTjdCOG1zVEQvbTFxYzUybW9W?=
 =?utf-8?B?L0FLYklpN1VQQlFpSEVZclZIbiszeDdlOHloY2d1VlFIOHk2WVZTaTU0eGF3?=
 =?utf-8?B?TGtMVitlclk3cWE1TlVJOXIvNlBrS3c1SGcxV3B4a2RlaWRrSEx0a0hwS3kw?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F04F60A030B1B842AFA65D1B76316DE4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19334aa-1c63-4381-be99-08db3eedaf0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 02:44:36.7837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lAVW4zsqZ7oOKeHFM/ICiKOYD+EBiggzAYLPlllmYbOs3AXS3czcEnm9G5Q8rTK8LSuZADVFnlJfWnl5SllXxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7217
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA0LTE1IGF0IDExOjAwICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiANCj4gT24gMTMvMDQvMjAyMyAxMjo0NywgVHJldm9yIFd1IHdyb3RlOg0KPiA+IEFz
c2lnbiB0b3BfYTFzeXNfaHAgY2xvY2sgdG8gMjZNLCBhbmQgYWRkIGFwbGwxX2Q0IHRvIGNsb2Nr
cyBmb3INCj4gPiBzd2l0Y2hpbmcNCj4gPiB0aGUgcGFyZW50IG9mIHRvcF9hMXN5c19ocCBkeW5h
bWljYWxseQ0KPiA+IE9uIHRoZSBvdGhlciBoYW5kLCAibWVkaWF0ZWssaW5mcmFjZmciIGlzIGlu
Y2x1ZGVkIGZvciBidXMNCj4gPiBwcm90ZWN0aW9uLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFRyZXZvciBXdSA8dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2Jp
bmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC1hZmUueWFtbCAgICB8IDE4DQo+ID4gKysrKysr
KysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvdW5kL21lZGlhdGVrLG10ODE4OC1hZmUueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OC1hZmUueWFtbA0KPiA+IGluZGV4
IDgyY2NiMzJmMDhmMi4uMDMzMDFkNTA4MmYzIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxODgtDQo+ID4gYWZlLnlh
bWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVk
aWF0ZWssbXQ4MTg4LQ0KPiA+IGFmZS55YW1sDQo+ID4gQEAgLTI5LDYgKzI5LDEwIEBAIHByb3Bl
cnRpZXM6DQo+ID4gICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9w
aGFuZGxlDQo+ID4gICAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgb2YgdGhlIG1lZGlhdGVr
IHRvcGNrZ2VuIGNvbnRyb2xsZXINCj4gPiANCj4gPiArICBtZWRpYXRlayxpbmZyYWNmZzoNCj4g
PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4g
PiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBvZiB0aGUgbWVkaWF0ZWsgaW5mcmFjZmcg
Y29udHJvbGxlcg0KPiA+ICsNCj4gPiAgICBwb3dlci1kb21haW5zOg0KPiA+ICAgICAgbWF4SXRl
bXM6IDENCj4gPiANCj4gPiBAQCAtMzcsNiArNDEsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAg
ICAtIGRlc2NyaXB0aW9uOiAyNk0gY2xvY2sNCj4gPiAgICAgICAgLSBkZXNjcmlwdGlvbjogYXVk
aW8gcGxsMSBjbG9jaw0KPiA+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBhdWRpbyBwbGwyIGNsb2Nr
DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IGF1ZGlvIHBsbDEgZGl2aWRlIDQNCj4gPiAgICAg
ICAgLSBkZXNjcmlwdGlvbjogY2xvY2sgZGl2aWRlciBmb3IgaTJzaTFfbWNrDQo+ID4gICAgICAg
IC0gZGVzY3JpcHRpb246IGNsb2NrIGRpdmlkZXIgZm9yIGkyc2kyX21jaw0KPiA+ICAgICAgICAt
IGRlc2NyaXB0aW9uOiBjbG9jayBkaXZpZGVyIGZvciBpMnNvMV9tY2sNCj4gPiBAQCAtNTgsNiAr
NjMsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAtIGNvbnN0OiBjbGsyNm0NCj4gPiAgICAg
ICAgLSBjb25zdDogYXBsbDENCj4gPiAgICAgICAgLSBjb25zdDogYXBsbDINCj4gPiArICAgICAg
LSBjb25zdDogYXBsbDFfZDQNCj4gDQo+IFdoeSBkbyB5b3UgYWRkIGNsb2NrcyBpbiB0aGUgbWlk
ZGxlPyBUaGUgb3JkZXIgaXMgc3RyaWN0LCBzbyB5b3UganVzdA0KPiBicm9rZSBhbGwgRFRTLg0K
PiANCg0KSW4gRFRTIGZpbGUsIEkgb25seSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBvcmRl
ciBpbiBjbG9ja3Mgc2hvdWxkDQpiZSB0aGUgc2FtZSBhcyBjbG9jay1uYW1lcywgc28gSSBtaXN1
bmRlcnN0b29kIHRoYXQgSSBjYW4gYWRkIHRoZSBjbG9jaw0KaW4gdGhlIG1pZGRsZSBiYXNlZCBv
biB0aGUgY2xvY2sgdHlwZS4NCg0KU29ycnksIEkgZGlkbid0IGtub3cgdGhlIG9yZGVyIGlzIHN0
cmljdC4gSSB3aWxsIG1vdmUgdGhlIG5ldyBjbG9jayB0bw0KdGhlIGxhc3Qgb25lIGluIHYyLg0K
DQo+ID4gICAgICAgIC0gY29uc3Q6IGFwbGwxMl9kaXYwDQo+ID4gICAgICAgIC0gY29uc3Q6IGFw
bGwxMl9kaXYxDQo+ID4gICAgICAgIC0gY29uc3Q6IGFwbGwxMl9kaXYyDQo+ID4gQEAgLTc0LDYg
KzgwLDEyIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgIC0gY29uc3Q6IGkyc2kyX21fc2VsDQo+
ID4gICAgICAgIC0gY29uc3Q6IGFkc3BfYXVkaW9fMjZtDQo+ID4gDQo+ID4gKyAgYXNzaWduZWQt
Y2xvY2tzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgYXNzaWduZWQtY2xv
Y2stcGFyZW50czoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+IA0KPiBVc3VhbGx5IHRoZXNlIHR3
byBhcmUgbm90IG5lZWRlZC4NCj4gDQpPSy4gSSB3aWxsIHJlbW92ZSB0aGVzZSB0d28gcHJvcGVy
dGllcyBpbiB2Mi4NCg0KPiA+ICsNCj4gPiAgICBtZWRpYXRlayxldGRtLWluMS1jb3dvcmstc291
cmNlOg0KPiA+ICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWlu
dDMyDQo+ID4gICAgICBkZXNjcmlwdGlvbjoNCj4gPiBAQCAtMTQ3LDYgKzE1OSw4IEBAIHJlcXVp
cmVkOg0KPiA+ICAgIC0gcG93ZXItZG9tYWlucw0KPiA+ICAgIC0gY2xvY2tzDQo+ID4gICAgLSBj
bG9jay1uYW1lcw0KPiA+ICsgIC0gYXNzaWduZWQtY2xvY2tzDQo+ID4gKyAgLSBhc3NpZ25lZC1j
bG9jay1wYXJlbnRzDQo+IA0KPiBXaHkgbWFraW5nIHRoZW0gcmVxdWlyZWQ/DQoNCkFzIEkgbWVu
dGlvbmVkIGluIHRoZSBjb21taXQgbWVzc2FnZSwgc3dpdGNoaW5nIHRoZSBwYXJlbnQgb2YNCnRv
cF9hMXN5c19ocCB3YXMgaW5jbHVkZWQgaW4gdGhlIHNlcmllcy4gSSBtYWtlIHVzZSBvZiB0aGVz
ZSB0d28NCnByb3BlcnRpZXMgdG8gaW5pdGlhbGl6ZSB0aGUgY2xvY2sgdG8gMjZNSHosIHNvIEFQ
TEwxIGNhbiBiZSBlbmFibGVkDQpvbmx5IHdoZW4gaXQncyByZWFsbHkgcmVxdWlyZWQuDQoNCg0K
VGhhbmtzLA0KVHJldm9yDQo+IA0K
