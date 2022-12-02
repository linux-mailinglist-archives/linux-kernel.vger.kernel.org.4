Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8601640171
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiLBIA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiLBIAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:00:22 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5041495802;
        Fri,  2 Dec 2022 00:00:16 -0800 (PST)
X-UUID: c091952b356240c8a9b9612289e6df8e-20221202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OC06ZioKCxr1TzH6pR3Ogotxqv2EI13zydY5nhD9WO8=;
        b=tSFHzVfeH3PkxTJ5jd+cOAO/Lo4vAwBSH/Yl9INPrqYOCZMWKzgMyqTMPj2EcgQCvEx3AmOjR//YsG1dd3j7JSaWjDtuT4SILg4IvaiDD0ERuhPsKUofN9UXGArbvnYUUpkFVT12pN4xcj7LJNMPnISXFqKj2K6FxS1y8RCnZms=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:119cad35-d7a2-4f3b-ba04-cbf833355445,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:98abf61e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c091952b356240c8a9b9612289e6df8e-20221202
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2062144112; Fri, 02 Dec 2022 16:00:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 2 Dec 2022 16:00:10 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 2 Dec 2022 16:00:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIKD2y7qSu99IFwssashLAhlhgr4VPSWj37a2TsUANbTDg95V4U2iNQYOme63woBDMtl+8BjzzOgc7evXgZyjPjbQ+XEh68jV9NMFwIGtVEKrtuEe4AccfCQIKz2DZL3LDGSHgiqR8qJ/ko2WH3z11yhah3nslyouekznOpi29MUmkBzf5LshNxnNncHocJF6teEzag551xvNpFl2b1bZySp0wS4HW5lEUNvE+d1Cl0W1EkNc1PLdhHUBgAtmYlCPnIUN0EdSyoFdf8jCL8xgY/BItxwnGLPvl7xpeihFIp6/yCHx3dizBOvlKzVHQosOOWBqw15Ra9/qXsHKwQqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC06ZioKCxr1TzH6pR3Ogotxqv2EI13zydY5nhD9WO8=;
 b=GFa147ZtsgWVC3PZ4df/itmR3bjlNtDgGoNT6JqH4LsB1utBnoQXXES25cLFFTACSGOMkbOjaVLJGDHp5QuUE0gPDLhes+4nfr2zFvf8DXr4eT4t8526LGLWsjaIjzee5JsIdarIDZ8mm3nJS2pn5JSG/JcopLKorCPY082g425RWVHDrlHOUBBW/pIURWyeDCOB+rOmvljqLIjyIAwiVJoKLmmL6qnCMnNMG57y95ngPqQVFXElQs9hsi+BmR4ALvXKAKSv/jFGSYptwbxoBnkyHVX+b0IoWZZgp4KF+Bc+fYKJ5LPCMsuaqNcYAVyaGcCzRs53Q8PVKy6imJljqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC06ZioKCxr1TzH6pR3Ogotxqv2EI13zydY5nhD9WO8=;
 b=SBh3zbbGaeob7BvwxLnuA0JO5chtv+LN8HgZBDCgrXquwd0e2O6UbVwfH/drHrkmhgzSgs/FqBZfZ/x3YjUfYtpcAPWQlV2LF6dNW6fDZ72JJjd99JL14ieXABsV4QF6VXzV0FgUosdIjHh2+bTaF+fdlOoivLpmSPcV6dK4r60=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by KL1PR0302MB5268.apcprd03.prod.outlook.com (2603:1096:820:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 08:00:05 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::af56:be8f:f:85b2]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::af56:be8f:f:85b2%9]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 08:00:05 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8192: Add adsp power domain controller
Thread-Topic: [PATCH] arm64: dts: mt8192: Add adsp power domain controller
Thread-Index: AQHZBVc4xOksO3burUGPCkRUXau3V65Yvf0AgAAA5oCAAAgPAIAAB0yAgAABWwCAAW3hAA==
Date:   Fri, 2 Dec 2022 08:00:04 +0000
Message-ID: <fd4e49139285e8506938ab142ccd429bae980fe2.camel@mediatek.com>
References: <20221201073328.1559-1-allen-kh.cheng@mediatek.com>
         <ba14a46f-477f-70af-761d-696fe8a4f41c@collabora.com>
         <CAGXv+5Gg6ozYQcp_NPrAiH1kF-ZkfjVZhQZVhLnbSmjQBwsFwQ@mail.gmail.com>
         <8ae2a510-abf6-6e1b-9893-293db7d930e7@collabora.com>
         <CAGXv+5H+msQ1ct5CUzYnT_BmYPnS72HbivvyO39uOfMfXbo5qg@mail.gmail.com>
         <28d94df0-6e87-3019-dc10-a587f84488fb@collabora.com>
In-Reply-To: <28d94df0-6e87-3019-dc10-a587f84488fb@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|KL1PR0302MB5268:EE_
x-ms-office365-filtering-correlation-id: 1841f646-fa8c-4469-7c79-08dad43b38f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IJnrLwz2jdUjR//WBg1hdy7NFRc5kBnPRlvN4NYx7u8tnrdmgQyRpNpO7Pnj7yJVbQV/vwhOERasaJoR6nRBryplyXwuvIYkx5eZQ4J6SZkBtCnK6TDbk7qUwwGrOZT+VSNFiN5TfCW+b8T0jDLSHMy4McBrqarb5ybNPUBEyUJbJOGIcEqwV6eoQSlMpbaOmHARr/4Zr6c3qCJVa3GAkMbZuyj3U0kpheBzRyrUGd4mah13zq4p1yUyGi9bGvPsWf4yY5XNW7yDv8Fxx28MOnmRu4NK7uzQF9oRKDnry0l11Wh050Xp+Kg/7kB8k4RQLP4eensj6nUkOhIzZ9ZRb1+9SJrYoWD5t0iJpO/RBTxWQqrAVpNBPWtuVjLL+/egbr5LvkGWJrZmgY1VtVoJF/OpxLhG73KlZC3iiVuWkFpPGio6TmDBops82Hkp8S84ZUv0QoJPljEkSytfpFvHzbuaJZ4NbQHxdfVTS1vaMf7xUiuonTz7vgK5TAr+pnKFZqlCjCb9m4x1D7fJ3bMUXYtNnw55DgzAaD6EPuNSD/eF3TVvsOW6BWKMDqfO1PgGqGVKZbpfEZXhEM3auR8mnQK0PGQ5YhNQ1UNogqM6D9vBXZj6sywaWX59B6rQxx7NlXopyMp3dlPayNwrJdl3ZNDbm0yCRzrJLo4OPUAI+CFJYnhLRkrG/CZ+IjDuoa2lmse5WQqQvQ18onAGZtDWeaCapD0HoRpC7vQ9agYtYdA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199015)(2616005)(186003)(6506007)(966005)(54906003)(86362001)(478600001)(110136005)(316002)(38070700005)(85182001)(38100700002)(83380400001)(36756003)(26005)(122000001)(53546011)(6512007)(5660300002)(6486002)(4326008)(66476007)(66446008)(71200400001)(8936002)(66946007)(76116006)(8676002)(2906002)(66556008)(41300700001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGpZRno2aTF0bTVSdEtROEZTNWtHZmhGOU5ZY1FEUWVMS3BjOWhGRkdBU2Ja?=
 =?utf-8?B?MkZWZktsd2ZZQUk3OFNCRzRDN3gyMkZiWE5KRVZDdWE0bUVwR3psQW04NDdD?=
 =?utf-8?B?TG1raVF2RWlFRGtreDVaeFYrM1I3aHdYbXlUc0pJVGN0VVpRTExISnEwQVJ0?=
 =?utf-8?B?bXFia0FmSjBRRE1CK1V5ZmY2VTFCenMxRXp4RlF4V1d6UUUrcUxpTU5ZZkxr?=
 =?utf-8?B?Q1lGSjZnbHhGazROMTN4MkNnZDk0S09DdlZYMUp5RVhtYmZrK2REMjV5UzBP?=
 =?utf-8?B?RmVTUGlnU055MXIxRWZ0VXo2VVZVcXdzSlRVZWFuRCtJRStIek5ISjAxajBI?=
 =?utf-8?B?K0JkcUdnSTRhTWtXTTR3Zy83S2JvQ0ZNeXh1eG0zdVpBeXA4UHV2REZRYnkv?=
 =?utf-8?B?SmdCdXRsbEJEcUlaZlc5cWZkaFptZC9YdXovRjJ0MWxNM3BwbXovTEhUT2gz?=
 =?utf-8?B?VE83dkZPcHZhQ1hKUm9kS0RHczkzN05RamF1M1l6MVA4ZWVzMmhKUHBYdnlR?=
 =?utf-8?B?YUhTaE9sNXRIODF5Z240UVRoUXFSMFEwQVFRNU9WNkVaOEdyUkw4eTkrbmFO?=
 =?utf-8?B?d2pIcjFoak8zSDk0bS9vUWdXaUhBQzdob0pzVWh5UFREZVg5cnhIN1kxMlNz?=
 =?utf-8?B?Qmd2VkZ5WTl2a2hwVW5tZ0VjTG93YmNHdjBNckdYVWl5M2cwWjBoNk14N04x?=
 =?utf-8?B?UzdGMjNnQ3FOWmg5SEFDOEMzVko4MEo1RUc0Y1cxMmhwbnJFYkxQK1BXYSsx?=
 =?utf-8?B?NDNvSXF4NXJWTlZuWDVLZXA5eGk3cXYxNStBUVNvWHcxVVU1SDY4RWxWRFU2?=
 =?utf-8?B?VmgyeXNEM0FuOHd0Z0JNcUhoaTYwaWtKYnJzN1A3Q25vZzNqbUZ2SDRHTUd0?=
 =?utf-8?B?M3pZTE9VYW5WVnMxTGkwbWdGa2s2bXpWTmowcTRyRnZRUVp4U21oYk83QSt3?=
 =?utf-8?B?amtqZE1tR3lyeG5DVGs4eGdkSnNTZUFyK3YwaXBncnBBbENDZDNKZmtqeVB2?=
 =?utf-8?B?d2VZcmV3U3l1Vm9IVjQ1MVV0OXRUZW5qdDN0VG5malJXeTQyZDBDVE03d3Y2?=
 =?utf-8?B?UVplWG9xR05HczNhZzloMUlvTCtuRFdnVDdqZXl1YUsxY0ltMzBKOWNTZVZD?=
 =?utf-8?B?YzdYT2E2aFFJNFpWbWpWVHNiTDZ6S0Z3QVdDSU0xdHZiRGU0eWxKR3JycVlF?=
 =?utf-8?B?L295d095bElqVE5Ta3gwa2preTdhT1JRcHBOWXgvVVBUVjFJWFpGdllBM1F5?=
 =?utf-8?B?c1JsN1RGYkxDc1pDamMxYm9ON1RsVzhLcCtEWGN2TUZ2RGFIZDRLUkFyOFUw?=
 =?utf-8?B?WGpmRDlOTmp2dVM4enl0cW9RbEtEZGRBVVpaRTFJRGpvMzdpMkkyOEtINlRa?=
 =?utf-8?B?dFJpd3dZdnlYM1Zqa01WN0FNWDdEb1VYZ0t2RjFMMFN5UlhxVlJIRkhQY09S?=
 =?utf-8?B?ZHM3OEZiTEVFLzVVb2NCODFubXJKQlVoNWJNcDRwK1VuMWVzWWt3NkNTNVJ4?=
 =?utf-8?B?bWxZVkV4UlVidVdCdzhYNUVMZ2IrMkluSW9namk5aFpmTklOUlNlemxTOUNx?=
 =?utf-8?B?eVp2Z2N5Q2Fjck5rR1JpeXZydTYzd3V2cVdGTEhCbWVLQmJsVzBKMlB0eU9n?=
 =?utf-8?B?OFlJRzU5Y1hZc2ZXL29TL3lVZnBUckdPK2tJRTA5d29LMGh4bEpkRkxsTDZP?=
 =?utf-8?B?cWFkSjdHdjlQWUNLMFRYMWFhbkFWYnUwMjMydzBzekNUSnI0bVBQSGtwNE1u?=
 =?utf-8?B?ZFVrdnd2QXVwM0JucHgxcEsyWVphMnBRSXpXZEFWZ1Y1TEJuQ2JXWWdJdnFt?=
 =?utf-8?B?QXNGM3ZaQXJQaW8rY3R5TjEwbzlMVXdRaG5LcGpFbTg2NmNSaERNekJqQlRZ?=
 =?utf-8?B?YmF6NlFFYmtZanY1K2o5T2wyeVVpS3VqZFdiMkQ2UEhrNkc5SFc4UGZqOE5J?=
 =?utf-8?B?VFBsRm10MG55ZzZONHVVVG41QWh2ZGtuVHRrUm5MaFVJcXZnSDY1d1lPZ20r?=
 =?utf-8?B?NnVyM3huMkRsMGl1QmZ4QmNhRi92ajZUbk95RCt4TS85QmNpMnNRQXp1Z3hB?=
 =?utf-8?B?WjZzYzBFQ2VDczJ2c3l4T21RUmNjM1hSNk51YjlvVWd6eVp2bmRqRytVVmVQ?=
 =?utf-8?B?NWpYMmRiaUtxNkd5WHh6MlVNYnBoaGtwVnZxTjRRelI4cjNia1NCTG5rdTVk?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <155D51069081424EA52CF1C1A5A57BCA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1841f646-fa8c-4469-7c79-08dad43b38f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 08:00:04.9518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXTBc/B8ULEqzcbafbF64P1YcqjswBCfoajd0UwNLhfxkzMhKFu9FrABzwkhZSveZU5TQgwt3FI+kObwtqzygoPlvut4mBvQtp97ClubxFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5268
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvIGFuZCBDaGVuLVl1LA0KDQpPbiBUaHUsIDIwMjItMTItMDEgYXQgMTE6MTAgKzAx
MDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAwMS8xMi8yMiAxMTow
NSwgQ2hlbi1ZdSBUc2FpIGhhIHNjcml0dG86DQo+ID4gT24gVGh1LCBEZWMgMSwgMjAyMiBhdCA1
OjM5IFBNIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+ID4gPGFuZ2Vsb2dpb2FjY2hpbm8u
ZGVscmVnbm9AY29sbGFib3JhLmNvbT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IElsIDAxLzEyLzIy
IDEwOjEwLCBDaGVuLVl1IFRzYWkgaGEgc2NyaXR0bzoNCj4gPiA+ID4gT24gVGh1LCBEZWMgMSwg
MjAyMiBhdCA1OjA3IFBNIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+ID4gPiA+IDxhbmdl
bG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IElsIDAxLzEyLzIyIDA4OjMzLCBBbGxlbi1LSCBDaGVuZyBoYSBzY3JpdHRvOg0K
PiA+ID4gPiA+ID4gQWRkIGFkc3AgcG93ZXIgZG9tYWluIGNvbnRyb2xsZXIgbm9kZSBmb3IgbXQ4
MTkyIFNvQy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxsZW4t
S0ggQ2hlbmcgPGFsbGVuLWtoLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0K
PiA+ID4gPiA+ID4gUmVmOiANCj4gPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yZWM4MGJkOC1kZmVmLWQyZTYtZWI0MS02ZTYwODgwNDNlMzNAY29sbGFib3JhLmNvbS8NCj4g
PiA+ID4gPiA+ICAgICAgICBbQWxsZW4tS0ggQ2hlbmcgPGFsbGVuLWtoLmNoZW5nQG1lZGlhdGVr
LmNvbT5dDQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gICAg
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kgfCA4ICsrKysrKysrDQo+
ID4gPiA+ID4gPiAgICAgaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxOTItcG93ZXIuaCB8
IDEgKw0KPiA+ID4gPiA+ID4gICAgIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBbGxlbiwgdGhhbmtzIGZvciB0aGlz
IG9uZSwgYnV0IGl0J3MgaW5jb21wbGV0ZS4uLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEZpcnN0
IG9mIGFsbCwgeW91IG11c3QgYWRkIHRoZSBwb3dlciBkb21haW4gb24gdGhlIGRyaXZlcg0KPiA+
ID4gPiA+IGl0c2VsZiwgc3BlY2lmaWNhbGx5LA0KPiA+ID4gPiA+IGluIGRyaXZlcnMvc29jL21l
ZGlhdGVrL210ODE5Mi1wbS1kb21haW5zLmggLSBvdGhlcndpc2UgdGhpcw0KPiA+ID4gPiA+IGNo
YW5nZSB3aWxsIGhhdmUgbm8NCj4gPiA+ID4gPiBlZmZlY3QhDQo+ID4gPiA+IA0KPiA+ID4gPiBB
Y3R1YWxseSBpdCdzIHdvcnNlLiBUaGUgZHJpdmVyIGRvZXNuJ3Qga25vdyBhYm91dCB0aGUgbmV3
DQo+ID4gPiA+IHBvd2VyIGRvbWFpbiwNCj4gPiA+ID4gYW5kIHNvIGl0IHdpbGwgZmFpbCB0byBw
cm9iZS4gV2UgbWlnaHQgbmVlZCB0byBtYWtlIHRoZSBwb3dlcg0KPiA+ID4gPiBkb21haW4gZHJp
dmVyDQo+ID4gPiA+IGZhaWwgZ3JhY2VmdWxseSBhbmQgc2tpcCB1bmtub3duIHBvd2VyIGRvbWFp
bnMuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBSaWdodC4gSXQncyB3b3JzZS4gSSBkb24ndCBr
bm93LCB0aG91Z2gsIGlmIGdyYWNlZnVsbHkgc2tpcHBpbmcNCj4gPiA+IHVua25vd24gcG93ZXIN
Cj4gPiA+IGRvbWFpbnMgaW4gdGhlIGRyaXZlciB3b3VsZCBiZSBhIGdvb2QgZGVjaXNpb24uLi4g
YXMgc29tZXRpbWVzDQo+ID4gPiBlcnJvciBtZXNzYWdlcw0KPiA+ID4gZ28gdW5ub3RpY2VkLg0K
PiA+ID4gDQo+ID4gPiBXaGVuIHRoZSBwbGF0Zm9ybSAiZXhwbG9kZXMiIGluc3RlYWQsIHlvdSdy
ZSBmb3JjZWQgdG8gcmVhZCB0aGF0DQo+ID4gPiBsb2cgY2FyZWZ1bGx5DQo+ID4gPiBhbmQgZ2V0
IGl0IHdvcmtpbmcgYWdhaW4uLi4gQW55d2F5LCBJJ20gb25seSB0aGlua2luZyBvdXQgbG91ZCwN
Cj4gPiA+IG5vdGhpbmcgbGVzcyBhbmQNCj4gPiA+IG5vdGhpbmcgbW9yZSB0aGFuIHRoYXQgOi0p
DQo+ID4gDQo+ID4gTWUgdG9vLiA6KQ0KPiA+IA0KPiA+ID4gQnkgdGhlIHdheSwgd2UgY2FuIHBy
b2JhYmx5IGV4cGFuZCBvbiB0aGF0IHRvcGljIGEgYml0IGxhdGVyLCBhcw0KPiA+ID4gaXQncyBv
dXRzaWRlIG9mDQo+ID4gPiB0aGUgc2NvcGUgb2YgdGhpcyBzcGVjaWZpYyBjaGFuZ2UuDQo+ID4g
PiANCj4gPiA+IEJhY2sgdG8gdG9waWMsIGlmIHdlIGdldCBvbmUgc2VyaWVzIGNvbnRhaW5pbmcg
Ym90aCBjaGFuZ2VzDQo+ID4gPiAoZGV2aWNldHJlZSwgYmluZGluZ3MNCj4gPiA+IGFuZCBkcml2
ZXIpIHdpdGggdGhlIHJpZ2h0IEZpeGVzIHRhZ3MgYW5kL29yIENjIHN0YWJsZSwgd2UNCj4gPiA+
IHNob3VsZG4ndCBoYXZlIHN1Y2gNCj4gPiA+IGlzc3VlIG9uIGJhY2twb3J0cyBzbyB3ZSBjYW4g
cHJvYmFibHkgaWdub3JlIHRoYXQgcG90ZW50aWFsDQo+ID4gPiBpc3N1ZSwgSSB0aGluaz8gOi0p
DQo+ID4gDQo+ID4gRXZlcnl0aGluZyBnb2VzIHRocm91Z2ggdGhlIHNvYyB0cmVlLCBzbyB0aGV5
IHNob3VsZCBhcHBlYXIgaW4NCj4gPiBMaW51cydzIHRyZWUNCj4gPiBhbmQgZ2V0IHBpY2tlZCBi
eSBzdGFibGUgYXQgbW9yZSBvciBsZXNzIHRoZSBzYW1lIHRpbWUuIEkgdGhpbmsgd2UNCj4gPiB3
b3VsZA0KPiA+IHdhbnQgdGhlIGRyaXZlciBjaGFuZ2UgdG8gYXBwZWFyIGJlZm9yZSB0aGUgZHRz
IGNoYW5nZSwgZm9yDQo+ID4gYmlzZWN0YWJpbGl0eSdzDQo+ID4gc2FrZSAoYmVjYXVzZSBvZiBo
ZWFkZXIgZGVwZW5kZW5jaWVzIGFuZCBkcml2ZXIgZXJyb3JzKS4NCj4gPiANCj4gPiBTbyB3ZSBw
cm9iYWJseSB3YW50Og0KPiA+IDEuIGRyaXZlciArIGJpbmRpbmcgaGVhZGVyIGNoYW5nZXMNCj4g
PiAyLiBkdHNpIGNoYW5nZXMNCj4gPiANCj4gPiBBbmQgaGF2ZSB0aGVzZSBtZXJnZWQgdGhyb3Vn
aCBmaXhlcyBzbyB0aGF0IHRoZSBoaXN0b3J5IGJldHdlZW4NCj4gPiB0aGVtIGlzIGxpbmVhci4N
Cj4gPiANCj4gDQo+IFBlcmZlY3QsIEkgZnVsbHkgYWdyZWUuDQo+IA0KDQpUaGFuayB5b3UgZm9y
IHlvdXIgY29tbWVudHMuDQoNCkkgbmVlZCB0byBjaGVjayBpbnRlcm5hbGx5IHdpdGggbXkgY293
b3JrZXJzIGZvciBkcml2ZXIgYW5kIHdpbGwgdXBkYXRlDQp2Mi4NCg0KQmVzdCBSZWdhcmRzLA0K
QWxsZW4NCg0KPiA+IA0KPiA+IENoZW5ZdQ0KPiA+IA0KPiA+ID4gQ2hlZXJzLA0KPiA+ID4gQW5n
ZWxvDQo+ID4gPiANCj4gPiA+ID4gQ2hlbll1DQo+ID4gPiA+IA0KPiA+ID4gPiA+IC4uLlRoZW4s
IGFzIENoZW4tWXUgc2FpZCwgeW91IHNob3VsZCBhbHNvIGFkZCB0aGUgcG93ZXINCj4gPiA+ID4g
PiBkb21haW4gdG8gdGhlIHNjcF9hZHNwDQo+ID4gPiA+ID4gY2xvY2sgbm9kZSBhcyB0aGF0J3Mg
c29sdmluZyB0aGUgbG9ja3VwIGlzc3VlLi4uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gLi4uLi4u
LmFuZCBsYXN0LCBidXQgbm90IGxlYXN0OiB3ZSBuZWVkIGEgRml4ZXMgdGFnIHRvDQo+ID4gPiA+
ID4gYmFja3BvcnQgdGhpcyBmaXgsIGhlcmUNCj4gPiA+ID4gPiBhbmQgb24gdGhlIGNvbW1pdCB0
aGF0IGFkZHMgdGhlIG1pc3NpbmcgcG93ZXIgZG9tYWluIGluIHRoZQ0KPiA+ID4gPiA+IGRyaXZl
ci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+ID4gQW5nZWxvDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRp
YXRlay9tdDgxOTIuZHRzaQ0KPiA+ID4gPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210ODE5Mi5kdHNpDQo+ID4gPiA+ID4gPiBpbmRleCA0MjRmYzg5Y2M2ZjcuLmU3MWFmYmE4
NzFmYyAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4MTkyLmR0c2kNCj4gPiA+ID4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTkyLmR0c2kNCj4gPiA+ID4gPiA+IEBAIC01MTQsNiArNTE0LDE0IEBADQo+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9
Ow0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07
DQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3dlci1k
b21haW5ATVQ4MTkyX1BPV0VSX0RPTQ0KPiA+ID4gPiA+ID4gQUlOX0FEU1Agew0KPiA+ID4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPQ0KPiA+ID4gPiA+
ID4gPE1UODE5Ml9QT1dFUl9ET01BSU5fQURTUD47DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmdG9wY2tnZW4NCj4gPiA+ID4gPiA+
IENMS19UT1BfQURTUF9TRUw+Ow0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJhZHNwIjsNCj4gPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVkaWF0ZWssaW5mcmFjZmcgPQ0KPiA+ID4g
PiA+ID4gPCZpbmZyYWNmZz47DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICNwb3dlci1kb21haW4tY2VsbHMgPQ0KPiA+ID4gPiA+ID4gPDA+Ow0KPiA+
ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgfTsN
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGlu
Z3MvcG93ZXIvbXQ4MTkyLXBvd2VyLmgNCj4gPiA+ID4gPiA+IGIvaW5jbHVkZS9kdC1iaW5kaW5n
cy9wb3dlci9tdDgxOTItcG93ZXIuaA0KPiA+ID4gPiA+ID4gaW5kZXggNGVhYTUzZDcyNzBhLi42
M2U4MWNkMGQwNmQgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdz
L3Bvd2VyL210ODE5Mi1wb3dlci5oDQo+ID4gPiA+ID4gPiArKysgYi9pbmNsdWRlL2R0LWJpbmRp
bmdzL3Bvd2VyL210ODE5Mi1wb3dlci5oDQo+ID4gPiA+ID4gPiBAQCAtMjgsNSArMjgsNiBAQA0K
PiA+ID4gPiA+ID4gICAgICNkZWZpbmUgTVQ4MTkyX1BPV0VSX0RPTUFJTl9DQU1fUkFXQSAgICAg
ICAgMTgNCj4gPiA+ID4gPiA+ICAgICAjZGVmaW5lIE1UODE5Ml9QT1dFUl9ET01BSU5fQ0FNX1JB
V0IgICAgICAgIDE5DQo+ID4gPiA+ID4gPiAgICAgI2RlZmluZSBNVDgxOTJfUE9XRVJfRE9NQUlO
X0NBTV9SQVdDICAgICAgICAyMA0KPiA+ID4gPiA+ID4gKyNkZWZpbmUgTVQ4MTkyX1BPV0VSX0RP
TUFJTl9BRFNQICAgICAyMQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAgICAgI2VuZGlmIC8q
IF9EVF9CSU5ESU5HU19QT1dFUl9NVDgxOTJfUE9XRVJfSCAqLw0KPiA+ID4gPiA+ID4gDQo+ID4g
PiANCj4gPiA+IA0KPiANCj4gDQo=
