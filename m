Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652D972D74E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbjFMCTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbjFMCT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:19:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24361718;
        Mon, 12 Jun 2023 19:19:26 -0700 (PDT)
X-UUID: b3c02cda099011eeb20a276fd37b9834-20230613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=z+89LRzux1llJZDsU9oW/y2sS6oTabgmm+ABowQx170=;
        b=RMa2A/4PEd72Ceh+25CZqS5l46/ZNLtqMAJ2DLrsygBG8BmyuQOu0NmK0RbKyVydfbNSrWReF49JN6sr0gNTnTeA9KOqgex+6fKggmI2xZZIEVpqovbzn7ChKdTXRRCwWr9X4o85++6MM7wu0lqFM5oz8PauoJ+WXW7QS4fjD9s=;
X-CID-CACHE: Type:Local,Time:202306130952+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:827e682d-f3d8-4b75-be97-8f3012e7694c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:d08edc6e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b3c02cda099011eeb20a276fd37b9834-20230613
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 462626881; Tue, 13 Jun 2023 10:19:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 10:19:13 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 10:19:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTU/ZK767ViiItoO/sVoP47BiLWyn/jFhqMcMh6OMhqzUz5Ifm6A8S8zDN3xcm4z+/eVVWXwxO7aZbdvsHvy4rI9uWKD/KGAOO+DLjnQvxvuPPbP3CJmMVUj8fqijk0p0qivXSvGqBRg4z/Ja0yqYbHclavOy0XcIc07j5Bvs5tElJDz0ABMZMF06ZCeSiEjdb7wUsPJhnT5DyDO5QusE5bA+yKzcJlUIxLTxuqPa80r70MmvE81uySZHMSObYmyk+hZ0zXWOaeNjVjh9LQlL5YF4gsZHrxBD14xIejvny2IACG9qDbHV41e6I3REE6F4nBhtREQOdj7qVv0MFD+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+89LRzux1llJZDsU9oW/y2sS6oTabgmm+ABowQx170=;
 b=YB+pMhB2naO1nFHNGaqEzx9XSQ1WhxOF7nS+smy9HTy01SVMePa90Xuw9tZd9VOtOC8T+1AcswIOoA9qjjj0IsKY+/oe0ETHA2T88xaEUQIVuHPXrKVWf3G0x5ufszCy/09D+r8JT+j/Wp2zjgr2ExLFVnBfALq/UUPwocK83rgTBmR7MlEywa+uabiy98JRs8MGyfI4ISsneW2IqSnQruPFpq2MrC/7gzBPUhAhBon7SZuDL4esj2iRa0A4nS05w8+Z6X2QA1wGZ6jiOZ0PhfZGa5nBULPX4RUbnOE+8KoB4+0w2ifZkWXK0Lxpja6KvFwy/ugf9kzx51ohnPkXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+89LRzux1llJZDsU9oW/y2sS6oTabgmm+ABowQx170=;
 b=TvKq6SjkA0aGk+LjBWftno1mjohUaoIiwLjlMZUeTPOKR2bHkLk3WvtTWRyp1GWI30Y0teLQGrDrOj060a4tWIcXr0BbJ/DdVFOSW9U2Ho22EfX7pNa2lCpnxHoouOHt3ldicwFaq3MiLIB19SJ7kLegkqbZsRk8fDLPzBrD7OI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYUPR03MB7207.apcprd03.prod.outlook.com (2603:1096:400:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 02:19:10 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%6]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 02:19:10 +0000
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
Thread-Index: AQHZkjsmmHc/VTGOHU6M5MEfnDzs/6+IFmcA
Date:   Tue, 13 Jun 2023 02:19:10 +0000
Message-ID: <72a13a42260d39c2495c59241d661f3a7a18c492.camel@mediatek.com>
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
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYUPR03MB7207:EE_
x-ms-office365-filtering-correlation-id: 823c2220-213c-49d3-0f0e-08db6bb492fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hS37FRpPJ6JUWCuWb9hb+U+Z5buujOYWslDFM9XTxe0NwCBZV22nS/AK16LDEoLk0z3IaCsKa0nkEtZI/dzNnxxmcRm8L0rAdjrm+DgsbTmz1L2mUd1v5kgUs1jumXGZsOqqR5uPEjhOvKkPMs5SCCJrqEmR+oaGsnF5GMgCGqND9ggcdNf1akg2Uy1/IiRT+8nrXodzP/QFBSKDBIk3rVzmsmYnFfmpgPT30UvT3+w/52iBOwywss+EZpIUhLgqMLnOWXtqQXhAuXpC+WEMymF1q/cgKuFR5322mgkHs/Dw6X1bFt/ZPBXNcv0A15EURRxspxxmk5DOsZAOCwf7XEUbw2g+gp/6DHOeJt/TU92gUrGQQd0mS/tSLlzKjLEnhBbQOq1aoDWgAudTxUq4fYvGJz6dxq9nZpjBtaBGtapXAWQBhUC4CBMoVpG6yXLSlTKI4eCCsESFC3FYScGteL6uzfSqDcuTZM08gTSchQ/8lwKOtGeL1UOzeFPp4o3Js9XV9SiDVoK5Gs5txErt/Y8SN04rQpOzjhc7dvJfN34jWKi5C10fzSACxEOhlHKGF06e+IptPsBH8OjB4W8gsS1d8KdXpMcP0LjeDfahJhJndNRpgQLlyjraCCjLJ2BjGG2ZM7VMkRrd4Y+OdAkIlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199021)(66946007)(8676002)(4326008)(66556008)(76116006)(36756003)(85182001)(41300700001)(64756008)(66476007)(66446008)(316002)(6486002)(8936002)(86362001)(83380400001)(7416002)(5660300002)(2906002)(54906003)(110136005)(478600001)(71200400001)(38070700005)(38100700002)(186003)(122000001)(2616005)(921005)(6512007)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGUvUVR0QUd5RDF2bUdFZmxGbUp0N04vOWJ6Y3NzaWlhOUlITFFsclZvOVF3?=
 =?utf-8?B?ZEorRUxrc1Z3OU90M0ZqbjBpOWYzRWt2Y1l2TzM2WGZaS3V1UUhENDhUT1JP?=
 =?utf-8?B?ZlVxd3NOd0d0RmhPYTFuVU1uTm5tUXg2d1Z6OVA1a2JYanJMVTZaajBJSjBj?=
 =?utf-8?B?T25ndGZkb1VHOS94WFFtcExlaGk2eS84Nk5EZGdrTDdIZDRyNnJyQWhibmEw?=
 =?utf-8?B?c1ZOaGFGWFhodGJ0cnZ3Y3Y3RC82SUU1eUc4eWt4TUpZbUxISEJkQnZXbklM?=
 =?utf-8?B?eTg3VG1EckZvdmVaSm5rc2s1L0dwMzdkU1dzQVN2Y0VUSTEyZFBQK0ExTmox?=
 =?utf-8?B?OFlSaDRJeDUwWldRT1JESURVQ1JpTVdqWmZqcGkyeE5FSGpWanpJTlpjQno3?=
 =?utf-8?B?Vm5XVlFMdU0xRW8zV1hqamM5dzZselBZRnBjMkluNTA1TTVuN3pFMURVYTRL?=
 =?utf-8?B?OFF2NXVwVFdrT0p1ZXg1M2dhcllvalJZTkZxUDZ6eEowdWYrYTIvdVpwdzBt?=
 =?utf-8?B?eDZhaVM2R0xGaXhFU2JqWVpQTnFOZVA2cG9WNG5XbEhCcnNrYklscUNHYU5n?=
 =?utf-8?B?dTdIUC9tOXA2ZzdwREN0c1JSRkltL3Ayby8yc2RLUHA2cXB1bXN6VlkvcnBQ?=
 =?utf-8?B?VVBKQ0M5alJEczJKbFEvbFhZRVdmWEpsb2tYRzhWL01UUUNwdXJDUWNvNkhw?=
 =?utf-8?B?R3loYlk0bStZVW1nb0ZkMFpza01rYVIzbGpJcWdJUXR5Q0dnUVBGRC9IZFJp?=
 =?utf-8?B?UmtOSkVOMFVmdGN0V3dTK0hwc3ZNRjFzSWZnZDZRS1k5aG51NWtxelEvTDNF?=
 =?utf-8?B?VlB6WkF2bDkvUmcvZ1dnbFk3S2VZT2hld2ZmVGdxS3NtS2NoOXQxaGdlaTEv?=
 =?utf-8?B?akZ3bjJiYnhRY1VaajM5WjdrUkw3bjFsVS9waVJBZE9pSXpURXBQRG1XanFT?=
 =?utf-8?B?eWlxR3VMbklxRlFFTjhINTBTTmZQeE4xdVdETUdvMVdxYWI1OWNsU1crU1hX?=
 =?utf-8?B?dUJpaEtpN2NrUlIzZzBIc0pVMmsrM2tXZTNUNHh1UGpzTW1kU3FNVDhDMENU?=
 =?utf-8?B?ZEFhWTVUNi9KRG00TnRFMElMdGVCcEsvbHdLK09UUG5aNjU0RlIzdFBUNlpF?=
 =?utf-8?B?K3pZT05wK0o0c05rd1RNcE5TaXNyTlBqQmJFeEVqSEZleU1raTYrUmRoZndz?=
 =?utf-8?B?WkFHRXVUUUdQOWFEd1hzMENXSFN6QzFCb0ZtYkd2aU5NWklzWWtHaVMxOFVr?=
 =?utf-8?B?RjBYWDVMSURhYXFDNXdNMHQzdmhFL25uRU9yUGk2eW0xQ1FJQS84c2tYNmpw?=
 =?utf-8?B?bUlVNkpWMzVBV2N5QVRNY1N0WU12Rlk4VDZTTlpMZU5qeVkrb2xDSzRyYTZD?=
 =?utf-8?B?eTVQc0ttMzdiYzdvaEtDT213eTVqemdMaGsxTDJvR1JKWTNjRTlnVURYYTJu?=
 =?utf-8?B?WGp4TjVBd0RFRktOaml1RWhzeE5KR281WXQyUWVrVTBLUm94UCtKVnUrcUsy?=
 =?utf-8?B?aGd0b0RGbmdjTWZ5N2g5SENrakJGdzlUOGlheC9Ka3BqV3p4UWxyeE04NHRo?=
 =?utf-8?B?emJmdG95K3RSdGEyVERqZ01ic0hlTVo2eWlOMXVTN3hFNit2SWtta2hlUW5j?=
 =?utf-8?B?S1ZzekNnd21acUd2aDA4ZmZFeXp5ZTM1bmRwcThDTjVZTDMvTmZKWXlNT09j?=
 =?utf-8?B?WjRIOGI2bWxsSTRTRG0rTE1rdGNuTll5MmtkMHJneWxrZng0K3V5ZFZ3dmM2?=
 =?utf-8?B?TUw0czA1OWtVYzFVd2I5UUxObTAzMEpmRXdZNG1rNFBhdldDbzhYNitGeE5Y?=
 =?utf-8?B?QU5qbVZwbnNJcDQzVmkyWHVXREJnVmNlTlhqS2puZFRWL21xWHpUdlU5NVAy?=
 =?utf-8?B?UTZYMEN6S0ZEaEhrZmtBZ1dvazl6ekhBWkJEajBRWEIzK2dCVS9DZkh4Ukxw?=
 =?utf-8?B?dVgzTXRyTU5rYTVGNHZVVlF2N2xMWGw5SUVLV3FqT09BenNpUDR1Lzh1VTJX?=
 =?utf-8?B?bXI1MXp0dXBzbGZyK3ltRTV4d1FqVmtnVVhTOXI1T0o2L1VHT0l3Tld6TWNi?=
 =?utf-8?B?cjZldnVBMCtHTlhXSVNnQlV2T0cwOTA0SzJVL20zWXFnbnp2Uk5waitscm4w?=
 =?utf-8?Q?pOYE1IpYXz5vMhH6fA3zt6Xcw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C31301C935D9E4199FEA32ADC86FCDC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823c2220-213c-49d3-0f0e-08db6bb492fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 02:19:10.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +KJCa+KSGp6o+5/fNAhTRMmwQosgtsvYycNe+XajKd9O7tq17fjo1UlsJFFPftw+cKw2hlh9vBX3ioz8g4jehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7207
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
bnF1ZXQgPGdyYW5xdWV0QGJheWxpYnJlLmNvbT4NCj4gLS0tDQoNCltzbmlwXQ0KDQo+ICsNCj4g
K3N0YXRpYyBib29sIGZnX2RkY19kYXRhX3JlYWQoc3RydWN0IG10a19oZG1pX2RkYyAqZGRjLA0K
PiArICAgICAgdW5zaWduZWQgY2hhciBiX2RldiwNCj4gKyAgICAgIHVuc2lnbmVkIGNoYXIgYl9k
YXRhX2FkZHIsDQo+ICsgICAgICB1bnNpZ25lZCBjaGFyIGJfZGF0YV9jb3VudCwNCj4gKyAgICAg
IHVuc2lnbmVkIGNoYXIgKnByX2RhdGEpDQo+ICt7DQo+ICtpbnQgcmV0Ow0KPiArDQo+ICttdXRl
eF9sb2NrKCZkZGMtPm10eCk7DQoNCldoeSBkbyB5b3UgbmVlZCB0aGlzIG11dGV4PyBmZ19kZGNf
ZGF0YV9yZWFkKCkgYW5kIGZnX2RkY19kYXRhX3dyaXRlKCkNCmFyZSBjYWxsZWQgYnkgbXRrX2hk
bWlfZGRjX3hmZXIoKSB3aGljaCBpcyB0aGUgY2FsbGJhY2sgZnVuY3Rpb24gb2YNCm1hc3Rlcl94
ZmVyLiBJbiBvcmlnaW5hbCBoZG1pIGRyaXZlciwgaXQncyBub3QgbmVjZXNzYXJ5IHRvIHVzZSBh
IG11dGV4DQp0byBwcm90ZWN0IG1hc3Rlcl94ZmVyLCBzbyBJIHRoaW5rIHRoaXMgaXMgbm90IG5l
Y2Vzc2FyeS4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKw0KPiAraGRtaV9kZGNfcmVxdWVzdChkZGMp
Ow0KPiArcmV0ID0gdmRkY19yZWFkKGRkYywgRERDMl9DTE9LLCBiX2RldiwgYl9kYXRhX2FkZHIs
IFNJRl84X0JJVF9IRE1JLA0KPiArICAgICAgcHJfZGF0YSwgYl9kYXRhX2NvdW50KTsNCj4gK211
dGV4X3VubG9jaygmZGRjLT5tdHgpOw0KPiArDQo+ICtyZXR1cm4gcmV0ID09IGJfZGF0YV9jb3Vu
dDsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgZmdfZGRjX2RhdGFfd3JpdGUoc3RydWN0IG10
a19oZG1pX2RkYyAqZGRjLA0KPiArICAgICAgIHVuc2lnbmVkIGNoYXIgYl9kZXYsDQo+ICsgICAg
ICAgdW5zaWduZWQgY2hhciBiX2RhdGFfYWRkciwNCj4gKyAgICAgICB1bnNpZ25lZCBjaGFyIGJf
ZGF0YV9jb3VudCwNCj4gKyAgICAgICB1bnNpZ25lZCBjaGFyICpwcl9kYXRhKQ0KPiArew0KPiAr
dW5zaWduZWQgaW50IGk7DQo+ICsNCj4gK211dGV4X2xvY2soJmRkYy0+bXR4KTsNCj4gKw0KPiAr
aGRtaV9kZGNfcmVxdWVzdChkZGMpOw0KPiArZm9yIChpID0gMDsgaSA8IGJfZGF0YV9jb3VudDsg
aSsrKQ0KPiArbXRrX2RkY193cl9vbmUoZGRjLCBiX2RldiwgYl9kYXRhX2FkZHIgKyBpLCAqKHBy
X2RhdGEgKyBpKSk7DQo+ICsNCj4gK211dGV4X3VubG9jaygmZGRjLT5tdHgpOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgaW50IG10a19oZG1pX2RkY194ZmVyKHN0cnVjdCBpMmNfYWRhcHRlciAqYWRh
cHRlciwgc3RydWN0DQo+IGkyY19tc2cgKm1zZ3MsDQo+ICsgICAgIGludCBudW0pDQo+ICt7DQo+
ICtzdHJ1Y3QgbXRrX2hkbWlfZGRjICpkZGMgPSBhZGFwdGVyLT5hbGdvX2RhdGE7DQo+ICtzdHJ1
Y3QgZGV2aWNlICpkZXYgPSBhZGFwdGVyLT5kZXYucGFyZW50Ow0KPiArYm9vbCByZXQ7DQo+ICtp
bnQgaTsNCj4gK3Vuc2lnbmVkIGNoYXIgb2Zmc2V0Ow0KPiArDQo+ICtpZiAoIWRkYykNCj4gK3Jl
dHVybiAtRUlOVkFMOw0KPiArDQo+ICtmb3IgKGkgPSAwOyBpIDwgbnVtOyBpKyspIHsNCj4gK3N0
cnVjdCBpMmNfbXNnICptc2cgPSAmbXNnc1tpXTsNCj4gKw0KPiAraWYgKG1zZy0+ZmxhZ3MgJiBJ
MkNfTV9SRCkgew0KPiArLyogVGhlIHVuZGVybHlpbmcgRERDIGhhcmR3YXJlIGFsd2F5cyBpc3N1
ZSBhIHdyaXRlIHJlcXVlc3QNCj4gKyAqIHRoYXQgYXNzaWducyB0aGUgcmVhZCBvZmZzZXQgYXMg
cGFydCBvZiB0aGUgcmVhZCBvcGVyYXRpb24uDQo+ICsgKiBUaGVyZWZvcmUgd2UgbmVlZCB0byB1
c2UgdGhlIG9mZnNldCB2YWx1ZSBhc3NpZ25lZA0KPiArICogaW4gdGhlIHByZXZpb3VzIHdyaXRl
IHJlcXVlc3QgZnJvbSB0aGUgZHJtX2VkaWQuYw0KPiArICovDQo+ICtyZXQgPSBmZ19kZGNfZGF0
YV9yZWFkKGRkYywgbXNnLT5hZGRyLA0KPiArICAgICAgIG9mZnNldCwgLyogZGV0ZXJtaW5lZCBi
eSBwcmV2aW91cyB3cml0ZSByZXF1ZXN0cyAqLw0KPiArICAgICAgIChtc2ctPmxlbiksICZtc2ct
PmJ1ZlswXSk7DQo+ICtpZiAoIXJldCkgew0KPiArZGV2X2VycihkZXYsICJkZGMgcmVhZCBmYWls
ZWQgOiAlZFxuIiwgcmV0KTsNCj4gK3JldHVybiByZXQ7DQo+ICt9DQo+ICt9IGVsc2Ugew0KPiAr
ZmdfZGRjX2RhdGFfd3JpdGUoZGRjLCBtc2ctPmFkZHIsIG1zZy0+YnVmWzBdLA0KPiArKG1zZy0+
bGVuIC0gMSksICZtc2ctPmJ1ZlsxXSk7DQo+ICsNCj4gKy8qIHdlIHN0b3JlIHRoZSBvZmZzZXQg
dmFsdWUgcmVxdWVzdGVkIGJ5IGRybV9lZGlkIGZyYW1ld29yaw0KPiArICogdG8gdXNlIGluIHN1
YnNlcXVlbnQgcmVhZCByZXF1ZXN0cy4NCj4gKyAqLw0KPiAraWYgKEREQ19BRERSID09IG1zZy0+
YWRkciAmJiAxID09IG1zZy0+bGVuKQ0KPiArb2Zmc2V0ID0gbXNnLT5idWZbMF07DQo+ICt9DQo+
ICt9DQo+ICsNCj4gK3JldHVybiBpOw0KPiArfQ0KPiArDQo=
