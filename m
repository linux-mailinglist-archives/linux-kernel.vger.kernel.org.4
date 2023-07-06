Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24E4749504
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjGFFfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjGFFf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:35:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A09E1BD6;
        Wed,  5 Jul 2023 22:35:20 -0700 (PDT)
X-UUID: e1815dfc1bbe11eeb20a276fd37b9834-20230706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QS72uvITm58o8lRhDbU9T9luY2xfF1lxxOtzickoaM4=;
        b=X/9KQEbYZ//DZDtv0nKEmaNRCWlptBeXdY/CqxYralYEWcyZQfVEkad1o8bS7D9fnwcPDGfhpywhn2M9v7DarJATa30s4dFHjOuooJ9T3CExpGryEd/ido08XFCGidZaNMImFiGx2Hw8GIh/1IY8JfxZu4N5Oo0eMr9SbEPm0r4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:f3e24981-f59b-4f89-93ce-250f3253a589,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:d7f3aeda-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: e1815dfc1bbe11eeb20a276fd37b9834-20230706
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1453866222; Thu, 06 Jul 2023 13:35:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jul 2023 13:35:12 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jul 2023 13:35:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IH5e7TE/UZmxzrZvegSJQwMMrWYXfNGTb+IxGejFNSp+SEuZA1jN79/PopmePRJA7zzfGrXDKJeaP1LjtxEI1VUqgrUnBC2427jL52pIHJBTHtGXteuQLgrtoaB2RxGY9l91IddxSENRso1th+FTym0i8GgbnaTC9EeKKhWnzGnGNEciv5eLwKW72HoT3EmEgBsntqrpMEgJcqFsaffEQE+FOBd8S9juZ+L7vkpDXmMbFuu2j/ezZxkD0pWZ2EnLzR74trYCCWmuQKZsFpLM8FckJ57WHtjHP+IRNukXTUd73sTwQ0HBXixsv0YhQBnGzA1FEksjyob5rfK0rxbl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QS72uvITm58o8lRhDbU9T9luY2xfF1lxxOtzickoaM4=;
 b=DxdCvhEZMkSbG/VwaekJ4WAUz4k3TtHbES5rEPni3rRN9/IXFXeuqgJ0HUpVBqvJOb96ECtwBS4AjA1vsrXcMl5uizCUgNjz9GwKvuE9yN0s8q6qdaRLKY76lByT+ClLTegxA/l0aunybDdNbOZSqi0nnshbOsC1rcGUybNLc7MHvMtd8S3ZfXJj7cfSXBBse6BcU7xUWZfLjODQRxdJ67/SAccQcbikY9D3ZNeUL7TLgXQTqezcW2FLE0heoPy3DjGeJjLbxgBIj/qZYxSJlgzOebMs6XvBO2rthH4zkUueRBdXILSrAQhiVGUWpis6FZaLPFQI7E4gdG0dc8Mmmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS72uvITm58o8lRhDbU9T9luY2xfF1lxxOtzickoaM4=;
 b=fvrym4M6OiYf7fH7wJvVJEHLFOS1jGW7ZGhqH44B46NwfgfHloBXFsjz2du/PPGEKU4xi2Gsm4BP6icpL+IHPixl/aAwQx+8g09HVW2ji8Gw4SjtxGXzclfTzgw79+5Tpj/zmMnQ5pri0SVEuwJyWbKd2sZq7yl8YJO/C2VscX0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB5493.apcprd03.prod.outlook.com (2603:1096:301:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 05:35:07 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 05:35:07 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2, 2/2] drm/mediatek: dp: Add the audio control to
 mtk_dp_data struct
Thread-Topic: [PATCH v2, 2/2] drm/mediatek: dp: Add the audio control to
 mtk_dp_data struct
Thread-Index: AQHZr6+ca7y1JpTzVU+WVNF2YGK2j6+sN94A
Date:   Thu, 6 Jul 2023 05:35:07 +0000
Message-ID: <e2ad22bcba31797f38a12a488d4246a01bf0cb2e.camel@mediatek.com>
References: <20230706021425.31735-1-shuijing.li@mediatek.com>
         <20230706021425.31735-3-shuijing.li@mediatek.com>
In-Reply-To: <20230706021425.31735-3-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB5493:EE_
x-ms-office365-filtering-correlation-id: a53186a0-5b23-4e06-1b4e-08db7de2c20c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H5EtnJDyLysn88QiujMemEhBuLt1pXjkcjKdQQaP8XfiyuuSqsx0NWPphbBG7yiPtiJ0T+Jc73oSrmlCa6vsU+Tb16o9z/72ujeLS1vO/HmVoZxWZPVzjOHtiigOQ7cuzNsywBLJAxoFAzOj4d57h3k5m/bzTfXbHESbhwgHFfTo9zr/pxmBPZZds/6k7KEo+o9NM/jFujFevEGQFQPb5DzfUFM6R+Rk0XKNYcP93IfEvQQqmzIrMUmHcofLqDoIeRQLcTgJKHM7BoGhLJpQ8x3QQJqQWN8caG1yfNzqc7BVAd+9WDuyEkCfpYX7QAnfulXYxI0hcm+5Qj4eiS04r9uLkGQ6Jhkz0Py7I6DWOp14k3aMI5F+Nhi26KtDHkyyeC2igEA4IPx2z9DZ3w25xZnr4WsOlrK8RRpb0QEJPL49V6BWXWfaZ/dcVXqcwI2+k2PTqaC6lFtw+iBZI249ox7x7XrlMyWc57mbtWpYsV5e5jR6Fyqbgn7wSkA2PCWv6dBNfwK6ZfVGlrMjjMuj9CKjakvX3pRIYxKh3sE2/kxVRxeEK/mr6uhHPbIlgz6dTslcX9SdcX7Z8LetuuOgTESiWAQmLxLg/KU5sJ3qo61aaJRjiMin0WAe9MBCykSrM2ipcvByb5f2y9ixSSYxucJ15rBw/OmEXd3TsHlDkok=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(2906002)(7416002)(5660300002)(2616005)(86362001)(66556008)(8676002)(66946007)(36756003)(8936002)(54906003)(478600001)(110136005)(6506007)(71200400001)(6486002)(186003)(107886003)(966005)(6512007)(26005)(122000001)(38070700005)(38100700002)(921005)(83380400001)(85182001)(316002)(4326008)(66476007)(66446008)(76116006)(64756008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkdQOXhCK1hMYXRMcE5FaEZ4VEtYbS9XWml1OFFiYWxDNEZXdTRMWkI4N1hU?=
 =?utf-8?B?RXNheG44cVlLZ0xLRVRwaWI1T0FMMlJqM285cEt0S3lwQ2hmYWttUUpwZTFI?=
 =?utf-8?B?UXhEV0dvM2dQRFlQaHZaZXY2UHNUNGp3MURRTXZoM3dlOFpPTGNBWXc4VHhF?=
 =?utf-8?B?NzFCNFM0a2hreTlCRmRFTmRGR25rSkdpNjZjVittMCt1Mmd6OGVjT3ZYM3RU?=
 =?utf-8?B?Mks5L0o3V0FMYVJUUHhSZFBXMVJDSEMrb2VXT3I4ekNtWlZnVWxLU2x0QUFX?=
 =?utf-8?B?emQzS09vdFhCKzhBNndHWDgrT1I0NEY0a212RFovYmxITlRmamN6cXNCeHo0?=
 =?utf-8?B?TE1rUW83M3AwYTQvc3Q3T05KSW5JRGI1OFc5OFBDOURiVkxRcDBFeWtkbnB2?=
 =?utf-8?B?QmtZbW5uM09UMlBTQkxMbWZwdmdiNENMWkcwUHYrRGRSSXR5VmZ3TUdlOHpY?=
 =?utf-8?B?bkpvUUEyY1JuazRwTk5RVFVzRGlmMUsxdjA2clN6RVJXOUFwL21jS1pUaGY4?=
 =?utf-8?B?cWRwcmpMeUtSbGh1RzNCbDd0ZytHZkxrU1BQalJPZTNOOG4rVWEwZzhyQXcx?=
 =?utf-8?B?WGRzY1E2UjRBWmtvOEtmZjVXa3k1bkNIY2twQkpzY04rMVhkc1d1UUgvNFZT?=
 =?utf-8?B?Rm1KdVRuVXgvdWx0NDFPTnp0bXU1MDhXOWU1TjkwYXNMMlI1SmZjeU9yNTFO?=
 =?utf-8?B?WklNVW9qblVVb3FYaEpTQnQ5dlJzTFJyMGllSUc5cXVWSGN0Umtra2V5WGZK?=
 =?utf-8?B?Ymd2RFVzQzJyaTg1dzFXUWluWkFoTzNGZXAyVUN6N0VHNTRMaG5ORzNmMTlz?=
 =?utf-8?B?UXg2TkRNYnFjMnllTzY4TVM2bGlxaEJVdlRGenJ1Mk9wQStZZndrT3U4bEdw?=
 =?utf-8?B?MXBpUXl4cThMMnBram1lVEt3TDhWTk9YelV1ZGFKcy8zNmhaSDMwUGtuL2ZH?=
 =?utf-8?B?RFkwZnY0dXZFWHArblE0aGRCa0lhWnlLUXVzN1QvU05KcERjYzRvd2drMEhC?=
 =?utf-8?B?TEU1dFRuVVQ3bytCOC9nejV5L3NlN1hyQTFrdmo4TzdJaHBucExiNGdHcUhq?=
 =?utf-8?B?ZHRFWU96QkJCVW5DczNJaERNTkNydWhNOGpkMDFkN0srQVNLaDRTM3hpRnEw?=
 =?utf-8?B?MHNFaUZmNHhGQkYrOWM4eVZHZFN2ZGIwYVJYTFVEbzZONFhJWnFwRUFHYkha?=
 =?utf-8?B?WUUvNG9FanVYWjlGd1o2RkpRVjJ4c05MVk11UDhGRjA5cDF4TVlXaG1qUmwx?=
 =?utf-8?B?aGZWVkZZUVYwb055QklPQzBGWmhycTZxSFJpRm5Td01Ia1ZaSGVqb0dwS05P?=
 =?utf-8?B?dHJNQUxEV29lOVVGTjRZTlNpeUhMa1ZGL296Ri80ZWFIY1hiOGNhZlRidllL?=
 =?utf-8?B?eXBsQ0lEcDJVMk9oNFpENEQ4T1lFVHV5WGxGSnBpdjNOUENhd24vMUJPVDdH?=
 =?utf-8?B?a3RzSGxYNDRBSUZ6KzFrSXcvMG5ycGs1SzNiSVdGOVBETnpkOVhuSWx6QWxq?=
 =?utf-8?B?Vyt5cWFuQlJ0Vk1hOHM2OGVnQTYweGtJemRRSDdvcmtMMFIxTGNJakxLUU11?=
 =?utf-8?B?SStyWnVHbkJJa01hNXh3dENFU2RkUDQvVjNuejJIdGR3aXNmanluc2JFUDVK?=
 =?utf-8?B?V0pUZEQ4NytEQ2Q4UWV2c0ptUDd2SXZmNk5pb3cwUVNWbFQ5UjczdzdXb1Vr?=
 =?utf-8?B?RDlyYXYzS09yWVMrWUF4ckpZcElSUi9JOFdCYnpLL2VrUzRvT0FtZGdmeXds?=
 =?utf-8?B?TGUxZWxxR0tkcmtDODBOOEFHUnQ1OEtJZ0tIL0oxZWNuQjduV1Z2VG9Kc1p0?=
 =?utf-8?B?bEZrenhJdG53T1g2YVNieE5LTzRvS3lqeVBMNWdsMjg5QmlkTmRtT0xSekZV?=
 =?utf-8?B?OXRKMUpWMnBNQjJHckdzSVAycHZYbXhkNUErUExUUkhrM3hkZFcrR3F0ZXk2?=
 =?utf-8?B?STYyWlRodWVBcm9uRjJhdmMwbUZPM2RmZDMxQUlIYkVRczBWRVYxWS85eXY4?=
 =?utf-8?B?ZE93ZmVzMVZxaTVMUURIMDdWWEdvdVA1OGJRNEJBbGw0djBuZnp4S1V4dVFP?=
 =?utf-8?B?UWxFUFB5MmdwYjlqMXNBSCt3amNZUmxYMjRjdDR6allIZTc2ZktQSXR1azE2?=
 =?utf-8?Q?JOU3M5RqhFEI+XdaEa4KQtHH4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18AE6EEB03B0B14E8443BA1502992FDB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53186a0-5b23-4e06-1b4e-08db7de2c20c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 05:35:07.4518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ueKr+hJQVGqbgCa7Gq7IinHBh0TkYe4N0B7frMz/T/2ZLgyqYH4NBSDTg7gW2xCUuVobvA6ZaOOs96ChPenhpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5493
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBUaHUsIDIwMjMtMDctMDYgYXQgMTA6MTQgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBNYWlubHkgYWRkIHRoZSBmb2xsb3dpbmcgdHdvIGZsYWc6DQo+IA0K
PiAxLlRoZSBhdWRpbyBwYWNrZXQgYXJyYW5nZW1lbnQgZnVuY3Rpb24gaXMgdG8gb25seSBhcnJh
bmdlIGF1ZGlvDQo+IHBhY2tldHMgaW50byB0aGUgSGJsYW5raW5nIGFyZWEuIEluIG9yZGVyIHRv
IGFsaWduIHdpdGggdGhlIEhXDQo+IGRlZmF1bHQgc2V0dGluZyBvZiBnMTIwMCwgdGhpcyBmdW5j
dGlvbiBuZWVkcyB0byBiZSB0dXJuZWQgb2ZmLg0KDQpJcyBnMTIwMCBhIGRwIHJlY2VpdmVyPyBJ
ZiBnMTIwMCBpcyBhIGRwIHJldmVpdmVyLCBJIHRoaW5rIHlvdSBzaG91bGQNCmFsc28gZml4IHRo
aXMgZm9yIG10ODE5NS4NCg0KPiANCj4gMi5EdWUgdG8gdGhlIGRpZmZlcmVuY2Ugb2YgSFcsIGRp
ZmZlcmVudCBkaXZpZGVycyBuZWVkIHRvIGJlIHNldC4NCg0KU2VwYXJhdGUgdGhlc2UgdHdvIHRo
aW5ncyBpbnRvIHR3byBkaWZmZXJlbnQgcGF0Y2hlcy4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFNodWlqaW5nIExpIDxzaHVpamluZy5saUBtZWRpYXRlay5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCj4gLS0t
DQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gY2hhbmdlIHRoZSB2YXJpYWJsZXMnIG5hbWUgdG8gYmUg
bW9yZSBkZXNjcmlwdGl2ZQ0KPiAtIGFkZCBhIGNvbW1lbnQgdGhhdCBkZXNjcmliZXMgdGhlIGZ1
bmN0aW9uIG9mDQo+IG10a19kcF9hdWRpb19zYW1wbGVfYXJyYW5nZQ0KPiAtIHJlZHVjZSBpbmRl
bnRhdGlvbiBieSBkb2luZyB0aGUgaW52ZXJzZSBjaGVjaw0KPiAtIGFkZCBhIGRlZmluaXRpb24g
b2Ygc29tZSBiaXRzDQo+IC0gYWRkIHN1cHBvcnQgZm9yIG1lZGlhdGVrLCBtdDgxODgtZWRwLXR4
DQo+IHBlciBzdWdnZXN0aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sL2FjMGZjZWM5LWEyZmUtMDZjYy1jNzI3LTE4OWVmN2JhYmU5
Y0Bjb2xsYWJvcmEuY29tLw0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHAuYyAgICAgfCA0Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHBfcmVnLmggfCAgNiArKysrDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDUyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwLmMNCj4gaW5kZXggNjRlZWU3NzQ1MmMwLi44ZTFhMTNhYjJiYTIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gQEAgLTEzOSw2ICsxMzksOCBAQCBzdHJ1
Y3QgbXRrX2RwX2RhdGEgew0KPiAgCXVuc2lnbmVkIGludCBzbWNfY21kOw0KPiAgCWNvbnN0IHN0
cnVjdCBtdGtfZHBfZWZ1c2VfZm10ICplZnVzZV9mbXQ7DQo+ICAJYm9vbCBhdWRpb19zdXBwb3J0
ZWQ7DQo+ICsJYm9vbCBhdWRpb19wa3RfaW5faGJsYW5rX2FyZWE7DQo+ICsJdTE2IGF1ZGlvX21f
ZGl2Ml9iaXQ7DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcF9lZnVz
ZV9mbXQNCj4gbXQ4MTk1X2VkcF9lZnVzZV9mbXRbTVRLX0RQX0NBTF9NQVhdID0gew0KPiBAQCAt
NjQ3LDcgKzY0OSw3IEBAIHN0YXRpYyB2b2lkDQo+IG10a19kcF9hdWRpb19zZHBfYXNwX3NldF9j
aGFubmVscyhzdHJ1Y3QgbXRrX2RwICptdGtfZHAsDQo+ICBzdGF0aWMgdm9pZCBtdGtfZHBfYXVk
aW9fc2V0X2RpdmlkZXIoc3RydWN0IG10a19kcCAqbXRrX2RwKQ0KPiAgew0KPiAgCW10a19kcF91
cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9FTkMwX1AwXzMwQkMsDQo+IC0JCQkgICBBVURJT19N
X0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfRElWXzIsDQo+ICsJCQkgICBtdGtfZHAtPmRh
dGEtPmF1ZGlvX21fZGl2Ml9iaXQsDQo+ICAJCQkgICBBVURJT19NX0NPREVfTVVMVF9ESVZfU0VM
X0RQX0VOQzBfUDBfTUFTSyk7DQo+ICB9DQo+ICANCj4gQEAgLTEzNjIsNiArMTM2NCwxOCBAQCBz
dGF0aWMgdm9pZA0KPiBtdGtfZHBfc2RwX3NldF9kb3duX2NudF9pbml0X2luX2hibGFuayhzdHJ1
Y3QgbXRrX2RwICptdGtfZHApDQo+ICAJCQkgICBTRFBfRE9XTl9DTlRfSU5JVF9JTl9IQkxBTktf
RFBfRU5DMV9QMF9NQVNLKQ0KPiA7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB2b2lkIG10a19kcF9h
dWRpb19zYW1wbGVfYXJyYW5nZShzdHJ1Y3QgbXRrX2RwICptdGtfZHApDQo+ICt7DQo+ICsJLyog
YXJyYW5nZSBhdWRpbyBwYWNrZXRzIGludG8gdGhlIEhibGFua2luZyBhbmQgVmJsYW5raW5nIGFy
ZWENCj4gKi8NCj4gKwlpZiAoIW10a19kcC0+ZGF0YS0+YXVkaW9fcGt0X2luX2hibGFua19hcmVh
KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwltdGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtf
RFBfRU5DMV9QMF8zMzc0LCAwLA0KPiArCQkJICAgU0RQX0FTUF9JTlNFUlRfSU5fSEJMQU5LX0RQ
X0VOQzFfUDBfTUFTSyk7DQo+ICsJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX0VO
QzFfUDBfMzM3NCwgMCwNCj4gKwkJCSAgIFNEUF9ET1dOX0FTUF9DTlRfSU5JVF9EUF9FTkMxX1Aw
X01BU0spOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBtdGtfZHBfc2V0dXBfdHUoc3RydWN0
IG10a19kcCAqbXRrX2RwKQ0KPiAgew0KPiAgCXUzMiBzcmFtX3JlYWRfc3RhcnQgPSBtaW5fdCh1
MzIsDQo+IE1US19EUF9UQkNfQlVGX1JFQURfU1RBUlRfQUREUiwNCj4gQEAgLTEzNzEsNiArMTM4
NSw3IEBAIHN0YXRpYyB2b2lkIG10a19kcF9zZXR1cF90dShzdHJ1Y3QgbXRrX2RwDQo+ICptdGtf
ZHApDQo+ICAJCQkJICAgIE1US19EUF9QSVhfUEVSX0FERFIpOw0KPiAgCW10a19kcF9zZXRfc3Jh
bV9yZWFkX3N0YXJ0KG10a19kcCwgc3JhbV9yZWFkX3N0YXJ0KTsNCj4gIAltdGtfZHBfc2V0dXBf
ZW5jb2RlcihtdGtfZHApOw0KPiArCW10a19kcF9hdWRpb19zYW1wbGVfYXJyYW5nZShtdGtfZHAp
Ow0KPiAgCW10a19kcF9zZHBfc2V0X2Rvd25fY250X2luaXRfaW5faGJsYW5rKG10a19kcCk7DQo+
ICAJbXRrX2RwX3NkcF9zZXRfZG93bl9jbnRfaW5pdChtdGtfZHAsIHNyYW1fcmVhZF9zdGFydCk7
DQo+ICB9DQo+IEBAIC0yNjE2LDExICsyNjMxLDMxIEBAIHN0YXRpYyBpbnQgbXRrX2RwX3Jlc3Vt
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICANCj4gIHN0YXRpYyBTSU1QTEVfREVWX1BNX09QUyht
dGtfZHBfcG1fb3BzLCBtdGtfZHBfc3VzcGVuZCwNCj4gbXRrX2RwX3Jlc3VtZSk7DQo+ICANCj4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4MTg4X2VkcF9kYXRhID0gew0KPiAr
CS5icmlkZ2VfdHlwZSA9IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFAsDQo+ICsJLnNtY19jbWQgPSBN
VEtfRFBfU0lQX0FURl9FRFBfVklERU9fVU5NVVRFLA0KPiArCS5lZnVzZV9mbXQgPSBtdDgxOTVf
ZWRwX2VmdXNlX2ZtdCwNCj4gKwkuYXVkaW9fc3VwcG9ydGVkID0gZmFsc2UsDQo+ICsJLmF1ZGlv
X3BrdF9pbl9oYmxhbmtfYXJlYSA9IGZhbHNlLA0KPiArCS5hdWRpb19tX2RpdjJfYml0ID0NCj4g
TVQ4MTg4X0FVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfMiwNCj4gK307
DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4MTg4X2RwX2RhdGEg
PSB7DQo+ICsJLmJyaWRnZV90eXBlID0gRFJNX01PREVfQ09OTkVDVE9SX0Rpc3BsYXlQb3J0LA0K
PiArCS5zbWNfY21kID0gTVRLX0RQX1NJUF9BVEZfVklERU9fVU5NVVRFLA0KPiArCS5lZnVzZV9m
bXQgPSBtdDgxOTVfZHBfZWZ1c2VfZm10LA0KPiArCS5hdWRpb19zdXBwb3J0ZWQgPSB0cnVlLA0K
PiArCS5hdWRpb19wa3RfaW5faGJsYW5rX2FyZWEgPSB0cnVlLA0KPiArCS5hdWRpb19tX2RpdjJf
Yml0ID0NCj4gTVQ4MTg4X0FVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZf
MiwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4MTk1
X2VkcF9kYXRhID0gew0KPiAgCS5icmlkZ2VfdHlwZSA9IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFAs
DQo+ICAJLnNtY19jbWQgPSBNVEtfRFBfU0lQX0FURl9FRFBfVklERU9fVU5NVVRFLA0KPiAgCS5l
ZnVzZV9mbXQgPSBtdDgxOTVfZWRwX2VmdXNlX2ZtdCwNCj4gIAkuYXVkaW9fc3VwcG9ydGVkID0g
ZmFsc2UsDQo+ICsJLmF1ZGlvX3BrdF9pbl9oYmxhbmtfYXJlYSA9IGZhbHNlLA0KPiArCS5hdWRp
b19tX2RpdjJfYml0ID0gQVVESU9fTV9DT0RFX01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX0RJVl8y
LA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBfZGF0YSBtdDgxOTVf
ZHBfZGF0YSA9IHsNCj4gQEAgLTI2MjgsOSArMjY2MywxOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19kcF9kYXRhIG10ODE5NV9kcF9kYXRhDQo+ID0gew0KPiAgCS5zbWNfY21kID0gTVRLX0RQ
X1NJUF9BVEZfVklERU9fVU5NVVRFLA0KPiAgCS5lZnVzZV9mbXQgPSBtdDgxOTVfZHBfZWZ1c2Vf
Zm10LA0KPiAgCS5hdWRpb19zdXBwb3J0ZWQgPSB0cnVlLA0KPiArCS5hdWRpb19wa3RfaW5faGJs
YW5rX2FyZWEgPSBmYWxzZSwNCj4gKwkuYXVkaW9fbV9kaXYyX2JpdCA9IEFVRElPX01fQ09ERV9N
VUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfMiwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kcF9vZl9tYXRjaFtdID0gew0KPiArCXsNCj4gKwkJ
LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LWVkcC10eCIsDQo+ICsJCS5kYXRhID0gJm10
ODE4OF9lZHBfZGF0YSwNCj4gKwl9LA0KPiArCXsNCj4gKwkJLmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTg4LWRwLXR4IiwNCj4gKwkJLmRhdGEgPSAmbXQ4MTg4X2RwX2RhdGEsDQo+ICsJfSwN
Cj4gIAl7DQo+ICAJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1lZHAtdHgiLA0KPiAg
CQkuZGF0YSA9ICZtdDgxOTVfZWRwX2RhdGEsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwX3JlZy5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcF9yZWcuaA0KPiBpbmRleCA4NGUzOGNlZjAzYzIuLjZkN2YwNDA1ODY3ZSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcuaA0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwX3JlZy5oDQo+IEBAIC0xNjIsNiArMTYyLDcgQEAN
Cj4gICNkZWZpbmUgQVVESU9fTV9DT0RFX01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX01VTF8yCSgx
IDw8IDgpDQo+ICAjZGVmaW5lIEFVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9N
VUxfNAkoMiA8PCA4KQ0KPiAgI2RlZmluZSBBVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VO
QzBfUDBfTVVMXzgJKDMgPDwgOCkNCj4gKyNkZWZpbmUgTVQ4MTg4X0FVRElPX01fQ09ERV9NVUxU
X0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfMgkoNCA8PA0KPiA4KQ0KPiAgI2RlZmluZSBBVURJT19N
X0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfRElWXzIJKDUgPDwgOCkNCj4gICNkZWZpbmUg
QVVESU9fTV9DT0RFX01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX0RJVl80CSg2IDw8IDgpDQo+ICAj
ZGVmaW5lIEFVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfOAkoNyA8PCA4
KQ0KPiBAQCAtMjI4LDYgKzIyOSwxMSBAQA0KPiAgCQkJCQkJCSBWSURFT19TVEFCTEVfQw0KPiBO
VF9USFJEX0RQX0VOQzFfUDAgfCBcDQo+ICAJCQkJCQkJIFNEUF9EUDEzX0VOX0RQDQo+IF9FTkMx
X1AwIHwgXA0KPiAgCQkJCQkJCSBCUzJCU19NT0RFX0RQXw0KPiBFTkMxX1AwKQ0KPiArDQo+ICsj
ZGVmaW5lIE1US19EUF9FTkMxX1AwXzMzNzQJCQkweDMzNzQNCj4gKyNkZWZpbmUgU0RQX0FTUF9J
TlNFUlRfSU5fSEJMQU5LX0RQX0VOQzFfUDBfTUFTSwlCSVQoMTIpDQo+ICsjZGVmaW5lIFNEUF9E
T1dOX0FTUF9DTlRfSU5JVF9EUF9FTkMxX1AwX01BU0sJCUdFTk1BU0sNCj4gKDExLCAwKQ0KPiAr
DQo+ICAjZGVmaW5lIE1US19EUF9FTkMxX1AwXzMzRjQJCQkweDMzZjQNCj4gICNkZWZpbmUgRFBf
RU5DX0RVTU1ZX1JXXzFfQVVESU9fUlNUX0VOCQkJQklUKDApDQo+ICAjZGVmaW5lIERQX0VOQ19E
VU1NWV9SV18xCQkJCUJJVCg5KQ0K
