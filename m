Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3D70EB52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbjEXC0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjEXC0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:26:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DECC2;
        Tue, 23 May 2023 19:26:05 -0700 (PDT)
X-UUID: 52a75736f9da11ed9cb5633481061a41-20230524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=E5j+wb+IjUdDwDFaJ3eCfZPEeyIIr7F6qmmk6FF+0N0=;
        b=M6kYM8LWPdjGWIVKGToOJKPmcb9/t4mrd2B6OkMYjyxkFFm5nV1ml9I073SCvox1e4bq6UApM8PJ8cKtg9DfpST1uS7JWmDXEZE9k7yM02i8QP2HQeaoiYS8pfemmtgi53nK9XPONwLhNN7PiPdgVp+/DThFVkjA+cW9IaptIVA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:9a264622-9a1e-478f-956c-1ed9cf742198,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:9a264622-9a1e-478f-956c-1ed9cf742198,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:2595d3c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:2305240026178M5ZVZQD,BulkQuantity:6,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 52a75736f9da11ed9cb5633481061a41-20230524
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 43547712; Wed, 24 May 2023 10:26:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 May 2023 10:25:59 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 May 2023 10:25:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW1g67SF30crzZ2A/kovhCoEluvgZeDKhm/yDObsacJNW9NXlhvcHhl0uRe1zfFxAugh7pFS9Fa8FHQF1wAvf+bkgQN23s1Q24vejTXkTqu4snhYfAHIiciTc8AezRNHM7bf8iF6XqiLedBcHe7GY49lTz8waiN4l3M7EQC/F/cgE2C+jl4mrUinOGxhUuRr7Mq2dfrQTLqFEZc17sDygKCLA2F4WuQ9HlpmlXqX5cSMBCXRQmmH+w5dboVEdXFimhwQsKT1CITz9FkifF6qjl1UaWBr/HNKAgGqUmZYOvEYHDVl9NpvEHDoCcLJ0ZbV2VJmA+K2Z+nyGAm4aloupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5j+wb+IjUdDwDFaJ3eCfZPEeyIIr7F6qmmk6FF+0N0=;
 b=OS4L57nxPxojO2KAtOc9oHWP8HncRCJWvK5lHi48XwmAafA5/N5hCQet07IzUSq0hx+XEGFE9+I61h7gVOXuoZT2Xb9Hp7/rzg+VZ/UMNTxlOtYxXF9JhfmzWMkWs+oMRLd9BwcKF9Es2gZkllo43PFDT9jKC3oJhhoMeWutqAZqQ+8wiPauWi+pLkzg/9+7ZLWYDRmo7Re0NxKYvl209w42Dnyxzw6EgEUpGOHdeUOZK4O0WFCL9DdTtjYsJ/M8g9LMWbQEO21XuNDFSfDTaakpAWDVniYZT41Rh4rdCk5errv2irAuk7V/+W4rf4c54rV9+9d/oRaLPOrKwgk5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5j+wb+IjUdDwDFaJ3eCfZPEeyIIr7F6qmmk6FF+0N0=;
 b=EBuJoB+/0QGMx4gpPADXbY7/uF8tgHDBkHxqXqN2SLOxulOnyrcgq9wo2/p3l8CGl3DMDuaFZ1ut6Euk59ZMeDwWxwAytarv7P5QKNUen3Vd7i3WbhU18/qQE3b5ECcGmZFAFz/yILV0M10EAdIN3cbHMs0LA8aOLN5EASRULqM=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SG2PR03MB6381.apcprd03.prod.outlook.com (2603:1096:4:17c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.30; Wed, 24 May
 2023 02:25:55 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 02:25:55 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
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
Subject: Re: [PATCH v2 2/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: remove
 ADDA_BE from link-name
Thread-Topic: [PATCH v2 2/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: remove
 ADDA_BE from link-name
Thread-Index: AQHZjR0FfmF6vQnyyUC64/q6ES0fra9oDFOAgACnk4A=
Date:   Wed, 24 May 2023 02:25:54 +0000
Message-ID: <b9eecdf886b6496131e51e1e2f49536c782c3b67.camel@mediatek.com>
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
         <20230523021933.3422-3-trevor.wu@mediatek.com>
         <cb69dbab-0966-8ecb-d9b9-017f430fd7ea@baylibre.com>
In-Reply-To: <cb69dbab-0966-8ecb-d9b9-017f430fd7ea@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SG2PR03MB6381:EE_
x-ms-office365-filtering-correlation-id: 069fb0cf-d13b-402c-d47b-08db5bfe33dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W/eYmGrcRkAKaM3umfjbD1XkRVL3zOzLlm5lFLjSYcihUgthxbpWxjgeR3u8mBm+ZqE9kSsRCfXjgGkywM7rdOfyXfm4N9IXR1CpmPWL0PWxWyYoIl6yISaLHH8CuwzYaJcS8K3Z7OhvCs8uSEFELpgbSAxK3KCi+PiqBgp0odaE9+5OHvYqo0cqy0WiMF1+m84+8tde3TPRRwhFfnkj9NmkkC4a9hyOtceMjkPe7NYZnDfHnSGLBt8j1iqi7lSkFZmSzn3KctWXm2Gh8vZFs9hNuAQnISSPARGeVyuBTqcLbovVnyrATH3JWMm42FUum8fPeKLEV/xevmN8MvAaCPaXdKWQhpMk3vIMcLteWob/+smZBZVqfz2U4oKdqnUCrd5XTQeymCuD33iDReXQnD+M4X0uNl7l3v/OGkw2isKnCBrRBCpKgVmvz4EDaepQc2v4EoR8vMwPObU030ggDgrLD10wfyurr4H9p0NRXsB/OktglHdb+L0ArQmnQ7BoweTLBdXDTQVMLOHjGkjPsgHcb37VphVoaA9+7oW8/8p/9EPhz8ZtVHqlZ2da16JQbN3PGjC6Jo4oBL6NddwlRpdiWrQqeLqYH3xWoF7yOYqngH505IhgLhSkzAa4IBww9KVpFMKoFcKV5bSEJqZl7iYROfWQIUFx6v+FpS17MGrcsYghyH41RPkkX0Pf1CjryQN7OSIZX0q/6tP2lk2c4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(26005)(186003)(122000001)(6506007)(6512007)(38100700002)(83380400001)(6486002)(53546011)(921005)(71200400001)(478600001)(110136005)(54906003)(2616005)(8676002)(8936002)(7416002)(4326008)(66446008)(76116006)(66556008)(66946007)(64756008)(66476007)(5660300002)(2906002)(38070700005)(41300700001)(316002)(91956017)(4744005)(86362001)(36756003)(85182001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2d3dXh4RSszRGhja3lYZm9FeVNRRjA5WEVYYmsvR2xVQW5VWXE0Yld0YTRF?=
 =?utf-8?B?VGxzZVYxNHM3NEovazhWM0NqNlB3dlRGc3lGZ2J6b3RBeGt0aUdGTzN3ZGhC?=
 =?utf-8?B?eEdoSnNtaHV1aWozTUlrYy9uRFVrNnNrVWxWbzgyUElEeDlHdVBrQ2x6RjFF?=
 =?utf-8?B?OFViRW43cEVlMzBpU2hoUVVGTC9waVd3R0Y4bk5sbWN4V2ZyZlN1TlE4WXZK?=
 =?utf-8?B?dEF5Y0huUTQybnh2bmk0Qm05QUNBSkZZcFdFVXM5eUdEWExGQm4wM2lONEho?=
 =?utf-8?B?eDRUdko0NHhNM2VEc3dKeUd4Z0l3OThaNjNpS0NWeDNHT3hPU1BUanV6NnlG?=
 =?utf-8?B?SVJyTzRTTkZHWlI2blk5a2kvSWw3azAyYm1RWGVFL0xSYitxYTBlT0NzNHBP?=
 =?utf-8?B?TVdoYUE3NEQyZXhwcStFRnQ0QlcxQTNkQ1lOakNOeW56anE4NEpqOFQ2bVVC?=
 =?utf-8?B?OTl5ajlqVjVDblBCdEIwVUR0c3Iyb0RrM291RGR4bFJXb05nZW83QjZBbXhH?=
 =?utf-8?B?TzRLRXBjUVFtL1kxYVB4ZmxTYkNiK0tvWlpINFVpcnVpNTBseWkxUDlxSlJF?=
 =?utf-8?B?c0FuV296VmxYNEFad0YxZUdkdGZIWmVQZnp1WGN5NFJNd25tOVZKNjVhS1Yv?=
 =?utf-8?B?K2FjTHFqYWY1a1R6TWxYVFFKNGtnMUZLV21UakpxYk91SWl5VFl5SkhJU1lt?=
 =?utf-8?B?Z1hNZUJFQWVUdmF2bmdpSkZLbjhCeElBL3ZuQUhFbE9sWEwxTnp1cDNaVEpU?=
 =?utf-8?B?dXAyWlJPQTZCTnRaVmVZR1M2dGk0cXYxT0xsQkh2T3JLWXp5SkNucFhETkli?=
 =?utf-8?B?OHhZemxQWERkbE1rVXhuUzhrdlUyN1RTUTYvRGFUMm1ESkZvdjZob0JVVUQr?=
 =?utf-8?B?aEZ2K3ZzY00yT1p3QWc0TXIzcmtFa2VJaWRlVFNYM25WN1VTS1VldkpvVlU3?=
 =?utf-8?B?eHA3Q0NtY1hQSGFlTzcrdjFKdW1SNUcrZStvN0VLVDlseURDaU12MklWR0Y5?=
 =?utf-8?B?c3F0bkhZYW1vc2FqWVhWbkR2WnJUWFV4Y3pwd1lsdjVvU3N5U3FRMUV1OWsz?=
 =?utf-8?B?anhJM1c3OE9DTUhNVHFjSGpqTXBSWC9PZUFWd3dCcHdsZG5hKzd0TXdDL1I1?=
 =?utf-8?B?VXNCVk5HZHFWOUZIMFJXbU5TRmlYbHUyUTJOcU1DN2k0VkpVRFZzWmhmZHFB?=
 =?utf-8?B?ZzFmL1kxMDVjYTJVZGwwTGZkTjdtZVdXcXpvNDVXdjYyRnRzZnVYaWRMSExW?=
 =?utf-8?B?T2l4L3kxK2FPN2pzWlozSDlpTS9VZGIyZVJEdmNySVZ1aUw0TFZFTHBKTmQw?=
 =?utf-8?B?c0R5M1ArNGdMejVTdG1EcXlDNjlNL0E2dVo4cEtqMWllYzBzSXpxSWpxNEhQ?=
 =?utf-8?B?cE52T3NodktKMC9tOGdma2xxNHBrajltQUV3N2FkVWFVaUFucUZiQ2lVSWZx?=
 =?utf-8?B?TWpCWGRhNUdHL1N1VlpVMy95Q0l2Y3R2UGRxQ3I1N1dFYVRNRmpwM2tWbEZE?=
 =?utf-8?B?eXljYTdoV0d5N1BnZ0NHYTl5ZUp2TWZvNXlRYlNpQ1M3ZURWMExib25meWlT?=
 =?utf-8?B?MkJNMzZNTDhhNmFlTE51MHVBanE5RW5SZVp1SGQrUHp0WTJkVFFkTVJpWTB4?=
 =?utf-8?B?MytMdkpaV0JqQlVVREtxdmJVSmlTeS9SaUZnK1ZxMzd1dTdFN3dNenkxSlFn?=
 =?utf-8?B?YSszWmRqTHNnUk55aytIRW1iTEI1TmIzaHJha2RkWVZaMEFjMWI3WHpEQURB?=
 =?utf-8?B?Z3lLa0JtUU0rK1NUL1JWMnhOQk1mTklVOHFxZDV3azhwQlhHSFM4OTlDcTVn?=
 =?utf-8?B?NDFLQ00vRUEyUkhSUFp4ZUJQcVpxUDdvQTNEb213UjhHSmVLRWxRWjkvamQr?=
 =?utf-8?B?TTFNUHlJKy9VUy9yQ28vdHh6SnRhTEFhQyt3ZG5uU2pLdkRjbHVmZjM1dlEx?=
 =?utf-8?B?a1VIUVFuN1kybVVPSy9JR3Yya2ErMWl5TnF2OTg5MEk1TnU5VUg4cTJBZmcr?=
 =?utf-8?B?VmpwSWhCV1E0bzBGTHV2RFgxdFZjZ29hYVZLNTFONU1tYlkyMFhLMHRBWVJp?=
 =?utf-8?B?dDdzNVd0NFpTc2xVRUxSamZnQkpZSUpVbU9pU1F3OVJ4RjBZaHB0VTJNTk1T?=
 =?utf-8?B?bCtUdFdHcjlUbTl5MDkrb1ZNNzIxV3NkVTJWZnF1enJydkgwQ0YyMUtjTzFX?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9D6474C4C327F43A598AB0112FA8425@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069fb0cf-d13b-402c-d47b-08db5bfe33dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 02:25:55.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXu1SELDlpdpfI5wAcqRieE2rShWlA5eogVSUeessMlG6cYBN+l+fxpdVdn+XCFhRsaPGRhk/Sozvd38KUYilA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6381
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

T24gVHVlLCAyMDIzLTA1LTIzIGF0IDE4OjI2ICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gT24gMjMvMDUvMjAyMyAwNDoxOSwgVHJldm9yIFd1IHdyb3RlOg0KPiA+IEFEREFfQkUg
aXMgdXNlZCB0byBjb25uZWN0IHRvIG10NjM1OS4gRm9yIG1hY2hpbmUgbXQ4MTg4LW10NjM1OSwN
Cj4gPiBjb2RlYw0KPiA+IGZvciBBRERBX0JFIG11c3QgYmUgbXQ2MzU5IHdoaWNoIGFyZSBjb25m
aWd1cmVkIG9uIHRoZSBtYWNoaW5lDQo+ID4gZHJpdmVyLg0KPiA+IEJlc2lkZXMsIEFEREFfQkUg
aXMgZGl2aWRlZCBpbnRvIHR3byBkYWlzLCBVTF9TUkNfQkUgYW5kIERMX1NSQ19CRS4NCj4gPiBB
cyBhIHJlc3VsdCwgcmVtb3ZlIEFEREFfQkUgZnJvbSBpdGVtcyBvZiBsaW5rLW5hbWUuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogVHJldm9yIFd1PHRyZXZvci53dUBtZWRpYXRlay5jb20+DQo+
IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQgaG93ICJETF9TUkNfQkUiIGFuZCAiVUxfU1JDX0JFIiBs
aW5rcyBhcmUgZG9uZS4NCj4gV2h5IHRoZXNlIGRhaXMgZG9uJ3QgcmVwbGFjZSAiQUREQV9CRSIg
aW4gdGhpcyBiaW5kaW5nID8NCj4gDQo+IFJlZ2FyZHMsDQo+IEFsZXhhbmRyZQ0KPiANCg0KSGkg
QWxleGFuZHJlLA0KDQpCZWNhdXNlIHRoZSBzb3VuZCBjYXJkIGlzIG10ODE4OC1tdDYzNTksIHRo
ZSBjb2RlYyBmb3IgdGhlc2UgdHdvIGxpbmtzDQptdXN0IGJlIG10NjM1OS4gVGh1cywgSSBzcGVj
aWZpeSB0aGUgY29kZWMgaW4gbWFjaGluZSBkcml2ZXIgZGlyZWN0bHkuDQpJZiB0aGUgY29kZWMg
aXMgY2hhbmdlZCwgdGhlcmUgd2lsbCBiZSBhIG5ldyBzb3VuZCBjYXJkIGFuZCBiaW5kaW5nDQpm
aWxlLiBJbiBjb25jbHVzaW9uLCB0aGUgY29kZWMgd29uJ3QgYmUgdXBkYXRlZCB2aWEgZHRzLCBh
bmQgdGhhdCdzIHdoeQ0KSSBkb24ndCBqdXN0IHJlcGxhY2UgQUREQV9CRSBpbiB0aGlzIGJpbmRp
bmcuDQoNCkRvIHlvdSBzdWdnZXN0IG1lIGFkZCBzb21lIGluZm9ybWF0aW9uIGluIHRoZSBjb21t
aXQgbWVzc2FnZT8NCg0KVGhhbmtzLA0KVHJldm9yDQo=
