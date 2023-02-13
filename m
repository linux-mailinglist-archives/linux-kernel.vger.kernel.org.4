Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C625D693CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjBMDfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBMDfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:35:05 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514F4CA1B;
        Sun, 12 Feb 2023 19:34:59 -0800 (PST)
X-UUID: 5ed746eeab4f11ed945fc101203acc17-20230213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vKrkDyXckcKBTg9PsqU1vrRNhEDfdlxdLQqnqe06CtQ=;
        b=luMzbFIZEFWTVF/QA1XxfDRkZYIddfom2It0KbpT3wBVtINZfVYiqeKzc0acboL4Syx1ml6yZKbvegCHdWqkb16QX56/FE5S2CVDfekucC+KkJMBaLc2+ScISy5Fimo2vxK1PtmA/pX6YCNRMFA+E59LQePgmmTuJObaut5j7Fs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:75a61e1e-f9ba-4a68-92ad-76f8245ab013,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:33b01257-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 5ed746eeab4f11ed945fc101203acc17-20230213
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2077942993; Mon, 13 Feb 2023 11:34:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 13 Feb 2023 11:34:48 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 13 Feb 2023 11:34:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xwhxx+Q26b7oi66kdYh01qjuTDwxn8oB2YMwkmn+JODRMG3uWm0ZTVI5IGtulAjv+ijlzf+/ZgQ8QffiSPcmjL87dF1cauYoLRIMGJwn2Gk4U7PC91OcPNbytQgsMFyvt0h5ICIOVoWy12PG5YwDZD17hGOnGdeA2BL3te0PfJbntC+vX4iRWwepjxN8p+XCTdjeOFx0KNn+8yRy5834jG1N5kLd75jkpCZ62PDVTjj1rnVm5Q2LW4SArWfCj1SXOqKlrjpQRlW1L1bsnFh1d7zWZj9nvG7BhW2I0KsuEKFmen8602meqLbqlzIqKDw2mDg6UIVnZFtSDlEtLMTgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKrkDyXckcKBTg9PsqU1vrRNhEDfdlxdLQqnqe06CtQ=;
 b=YAiRANpwviUrYkZZsnF6HESIhQyQK/9kCWJwXa5s/r3n894tgGqU6QiKHP9kg4lw0vfRkI7hPxihnEp8ZpmUhOV6EUjs+DkgoCBdkndgMMIwEbO2ZoxuBBgiJ+ePYygk1uYEA5dAwCqZk/MFq4Ts+tTFTDPt7WCDa4SS+/ebm/gflDznZkNRNizkGWX13rVYYCHBynygtjHAkuVUVdv4HLd2S73Hbsjg01otXWoJ0dBi4knBoBq+o6idA2AGWgVNWD+AN+m2iBIS9m2FmJIulUYktdrDmxWcWvTcrhXBxZR//tEc7CCTOU8+euMTikjFOYf+ANgncWCWwUebjWP4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKrkDyXckcKBTg9PsqU1vrRNhEDfdlxdLQqnqe06CtQ=;
 b=KUYTrcssuhWOP6whl8n2LHSyGc/LQQaNt8CJ0PWE9uBZ33e3hbFfTLpaK+T8gglpJzRo0puBpMMpC0u8HWdavDQQwcJM2TGAaGrZ7zZG274V++KHocSRuWGQWEr444gP1coz6Eu+Zqk5xoBlUx66jKFThMJmcLv63eeEzLnSw6s=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by SG2PR03MB6683.apcprd03.prod.outlook.com (2603:1096:4:1d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 03:34:46 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dbe7:4943:de9b:bc96]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dbe7:4943:de9b:bc96%4]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 03:34:45 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v5 06/12] remoteproc: mediatek: Extract remoteproc
 initialization flow
Thread-Topic: [PATCH v5 06/12] remoteproc: mediatek: Extract remoteproc
 initialization flow
Thread-Index: AQHZPS4UVewBOZ0oLk2d0SPsGb0V3q7INk4AgAQHjoA=
Date:   Mon, 13 Feb 2023 03:34:45 +0000
Message-ID: <1e4227d56f66d090810d8990f13914e30343b0a7.camel@mediatek.com>
References: <20230210085931.8941-1-tinghan.shen@mediatek.com>
         <20230210085931.8941-7-tinghan.shen@mediatek.com>
         <ace701a0-45cb-3b48-cdc5-e4d39384b8aa@collabora.com>
In-Reply-To: <ace701a0-45cb-3b48-cdc5-e4d39384b8aa@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|SG2PR03MB6683:EE_
x-ms-office365-filtering-correlation-id: 4526771a-4764-4125-debe-08db0d734027
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w48RZ2c4gaZxRUgm2HOEgRZ+LvVdkl9ZA9OYEPJEE4b7h/CXr3pf4JMyj0zYY+po5Z3Dx9q+yngpd7JitmC0l4UVJPOxEeKSFOkon+nAWegdaE8PMT/6myJVsOFuXseFEXKhw8Bl/DP1Hy03qCL88i93jGN4BWxmp5qYcthny2gZNpFb5Aa8pjBNI7/0lytnQWIl9KVlOK3BSbQm94fPKLJ4ubL+bnwwn2rfNXCUVcW/WZBErqhjHVLdXu9obvjIr4Jo91UxZwSqylC+cqlNtEHR6jgrjZ1iQy8k10s5AkWR1LkIHB6aK2Y4OJUENiPSqc6r3zL6y7WsYnPBKVwVkCRa0BGFLxznCrgS0qpxpQRnsCRm05DzZSXk6EaSGWQRvFlevlHLPrbJDNyUzL+c5i6wtkeDuOzN2rPe2ZFSqzTfjzR10Bk2JaiBf+8TOp0yX/Adz5qfvaV9H+igInlibOwsdNV5ncnN0DeA6RLlXBJyL/HErCJVE85dc1oyGzppYSjpqhpS2KCrEhMd5W+6Lmi5xZ1iW4GMhMAWtgDXbA2zCRWvEbzWbwXyKknvb1V8UYJPOABAdyIUJ6162qiO58Gup8h2QWmtwz9Lo5qElyQVPJxgmu2T9gacYaKz9ihmDi4FU3cgZaPeilhEz+zY0w4BLplgqzjlORKYcrTUcq29Yj7ZHPwdJFp+hE5aFX2QcYt4tRMMZBomZ72phXm/SlKz9eWMrjDVViFN2EMBvjf6/jam42Yp45noqDBwEmTO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(5660300002)(8936002)(7416002)(41300700001)(71200400001)(26005)(186003)(6506007)(6512007)(107886003)(2906002)(38100700002)(38070700005)(478600001)(110136005)(316002)(6486002)(54906003)(8676002)(91956017)(4326008)(86362001)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(85182001)(83380400001)(36756003)(2616005)(122000001)(473944003)(414714003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDJyODFNM1ZicmdBWjZiZWlycmJXSzNSNFlRbzV5QlhFbE5ReS82dlNEdnVU?=
 =?utf-8?B?U0x5NDRNWkZhQ2dVcjY5WVIxT1hucmY3MlpDL3llbEpPcUltSkZCTkpKVVhk?=
 =?utf-8?B?a3ByNHAzYmJ4Y2JlYnV4MEVEcjFCV1RTaHdpcDRyb1l5OEh4dFRoMEZXMHYz?=
 =?utf-8?B?S296Z1J0YVBUQWRZL25PVEZhakJrQmFSRkpCZ0xlTk1xTU0ybTNDaVROOXdB?=
 =?utf-8?B?RUxqQWZVSWVrTHMrL2huSzhzWFdia0RDcERaS0E3U1FNUFhoSTQwRTZ0b3du?=
 =?utf-8?B?S2prajJUQzhpWWo1aTRCcktMSEZ1RGd4T2E4elhJWkFGamp1UVNyaHd1TmRP?=
 =?utf-8?B?V1Y2YUFGbmVBUElKNUJwc3NXTDhBaThPUFZPVVNNdVpXK1BlenBBN29IT2do?=
 =?utf-8?B?Z1BoU0NJUlBhdzNBS3YzTU9EMGZvY1RiQ2xJL3JmNi8vTVB0SkxERDdOQXln?=
 =?utf-8?B?Vmd3NUdGMjBPWEtqQ2IvZWRpNzBvMDdLQTA1Ri91S2FxWTBVYzFMWVJlTjc5?=
 =?utf-8?B?Tjhra0J6RkN4dDMvd1BvRlZzLytFV01mTmN2T1NtdVYwK2N3Y2NXbGt2UDBi?=
 =?utf-8?B?WlduWHpzZnoyNWdxRHVORlNURHc1WkJ0eng0b3A4Z3VJaUZ1elFpRnN0RzNZ?=
 =?utf-8?B?MlhNUm1aUDhRRU53ejNyZFNONzUzblNSNEtzVEJwVnNqUkx0L084aHk2L0dG?=
 =?utf-8?B?SnVZMitHcFFLWXZBaTA2ZlZpVXhKOFNwTjlSc2NrMzhlR3NTU2tlSEU5eVpm?=
 =?utf-8?B?Z3FCYktiZmsxd09Kb1dWWjlBQXlpSTFoL2ZrTDNObnNHaVR1dUNwWFA3dzd6?=
 =?utf-8?B?cExxVWNRUFZLaWlIVEpzalBHekRvZjdCOHRMNUcvaTJCeHdyR1hDNFp5ZkMv?=
 =?utf-8?B?S0xEK3EwaEQvZElPdm1DbzVPRTM2Y2xDWHZVUjFuRGdxVnp3TlFOeUFQczFQ?=
 =?utf-8?B?d1FXdnZsV21WWG8raTFCbGlqL1plOGJmR2g0bGZmNGQyR1IzWis0SVdpdlg5?=
 =?utf-8?B?V1doMFl3SFlnbFNsd2VSMlUxOXJhU1JId05VaHVhUmFBakZmbThWZk1DYmFR?=
 =?utf-8?B?MTJXK1B1eWJFN3dIdytGQWJ0RjQwTitLZnZTVStxSW9VTUJVTHJ4aTMyVVJ1?=
 =?utf-8?B?elMyWVRQc2V2bWRZbkxTaGZkK1N5VkhITmQvbUJJSDVTbGFLdS9tRnNmK0Ny?=
 =?utf-8?B?RDNKS0VCZ1Ewci9tMmJuSlQrNXhDQXEyejc1eTJacW5pWXVBWFNnVkJ6QmZ4?=
 =?utf-8?B?aWVkZnBJTUJxb28rV0xSaVdRc0R1Rm5FSERUbzVvVi90QWpBZzlDMnJ0MnVl?=
 =?utf-8?B?QUp2UHZXV3k4dHZxeUJDY1ZJNk5PcHdqMHBjdTl4UzFsNEE3am4rYTlIbTJ2?=
 =?utf-8?B?ZFk5SEMxMWFlTmN2YWN1b1VCWUgrRnNYVVhMd0MzZG1JRWF5dEJyMm5vaWJ2?=
 =?utf-8?B?SXFEWk51dWlSSTBJNHMvNm0ranFVMEU2Q01jN3o4U0ZweGt2Vm9sa3pzVkhp?=
 =?utf-8?B?M0ZvcGhMTXNZbnFTSWRJczJLQ0VPK1Z4dzNhUG9HTm5hTTRFdlVXY21TV2F3?=
 =?utf-8?B?VXYwMGE0OUN5WUZmcCt4bHVwR2VLK21BNVRFaFFPTGUzenZXUC9IaFJDUTQv?=
 =?utf-8?B?MVU5bGZ0OC85L0dHQnVmcWFvWWgyQ2cwN1dVY1J3T3N5Wkc0aUdUZWRQZEZh?=
 =?utf-8?B?RkNHZ2NucFlpdGV6WVRjUkhJbVV2aUdBNWxDdlNqY28rZklvbGtpd01rSDJD?=
 =?utf-8?B?dW8vWExQVmdOZ0N6SVRHWWxUQ0FtMUxic0hEUDJyZ2N6KzlUK2UvT2FnL2dq?=
 =?utf-8?B?Y3RaWWt2ZFh2ZFREUlU0ZFhWZ0cva3FTVUFtK1VpVkJRWFZ5SDE2cDRzQkg5?=
 =?utf-8?B?UE1FNEtaUVZaTXdMU0s2SVh2WkhKT1l3TE1PRXFHL1U2WmdNL0s2dkNJcTl0?=
 =?utf-8?B?MnFSQnJiZHV5dHp1WDY5WDV2SFozamFkZFIvbFdRZjI4SkFMZzFsL2NYbElo?=
 =?utf-8?B?T1F4YUFOc1lDS2ZMcllmOXpFT05vRnNzRzQzM3dzcGFDaXdpUjJYaFlTSjVS?=
 =?utf-8?B?SW55UUZ5UkZXTXNYdUhHYUwrM3JodG0yN1BUMEJmbVVBL3N0M1loRXN4cFQ5?=
 =?utf-8?B?QjhheXNtc1JVTTJORys1QUN1a09BMWxYTkZCbmd0cFlvOVNyRE5wR3pWRSs4?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9936F0CE6EAA04191E641D9492842D3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4526771a-4764-4125-debe-08db0d734027
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 03:34:45.1499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBnWGyAIEW1D07eU/0BegHFXJuJu6/aDrQkl2cTIlkxIeztRXq6PVmK9J7ZSzyHqm9EQ/M9/rYRJ5pqoqsG3ULQuPQGWmqsfz5Aju0TBh2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6683
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTEwIGF0IDE1OjAyICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTAvMDIvMjMgMDk6NTksIFRpbmdoYW4gU2hlbiBoYSBzY3JpdHRv
Og0KPiA+IFRoaXMgaXMgdGhlIHByZXBhcmF0aW9uIGZvciBwcm9iaW5nIG11bHRpLWNvcmUgU0NQ
LiBUaGUgcmVtb3RlcHJvYw0KPiA+IGluaXRpYWxpemF0aW9uIGZsb3cgaXMgc2ltaWxhciBvbiBj
b3JlcyBhbmQgaXMgcmV1ZXNkIHRvIGF2b2lkDQo+ID4gcmVkdW5kYW50IGNvZGUuDQo+ID4gDQo+
ID4gVGhlIHJlZ2lzdGVycyBvZiBjb25maWcgYW5kIGwxdGNtIGFyZSBzaGFyZWQgZm9yIG11bHRp
LWNvcmUNCj4gPiBTQ1AuIFJldXNlIHRoZSBtYXBwZWQgYWRkcmVzc2VzIGZvciBhbGwgY29yZXMu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVGluZ2hhbiBTaGVuIDx0aW5naGFuLnNoZW5AbWVk
aWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9yZW1vdGVwcm9jL210a19jb21tb24u
aCB8ICA3ICsrKysrDQo+ID4gICBkcml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jICAgIHwgNTUg
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQs
IDQyIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3JlbW90ZXByb2MvbXRrX2NvbW1vbi5oIGIvZHJpdmVycy9yZW1vdGVwcm9jL210
a19jb21tb24uaA0KPiA+IGluZGV4IDM3Nzg4OTRjOTZmMy4uMjBjMWE5MGJlNzdkIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfY29tbW9uLmgNCj4gPiArKysgYi9kcml2
ZXJzL3JlbW90ZXByb2MvbXRrX2NvbW1vbi5oDQo+ID4gQEAgLTExMiw2ICsxMTIsMTMgQEAgc3Ry
dWN0IG10a19zY3Bfb2ZfZGF0YSB7DQo+ID4gICAJc2l6ZV90IGlwaV9idWZfb2Zmc2V0Ow0KPiA+
ICAgfTsNCj4gPiAgIA0KPiA+ICtzdHJ1Y3QgbXRrX3NjcF9vZl9yZWdzIHsNCj4gDQo+IEluIHY0
LCBJIGFscmVhZHkgY29tbWVudGVkIG9uIHRoaXMgb25lLCBzYXlpbmcgdGhhdCB0aGlzIHN0cnVj
dHVyZSBpcyB1c2VkDQo+IG9ubHkgaW4gbXRrX3NjcC5jIGFzIGEgY29tbW9kaXR5IGFuZCAqb25s
eSogYXMgYSBjb21tb2RpdHkgZm9yIHBhc3NpbmcgZGF0YQ0KPiBiZXR3ZWVuIHR3byBmdW5jdGlv
bnMsIGFuZCBJIGFscmVhZHkgYXNrZWQgdG8gbW92ZSB0aGlzIHN0cnVjdHVyZSBkZWZpbml0aW9u
DQo+IHRvIG10a19zY3AuYy4NCg0KSSdtIHNvcnJ5LiBJIG1pc3NlZCB0aGlzIHBhcnQuDQpJJ2xs
IHVwZGF0ZSB0aGlzIGluIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gVGhhbmtzLA0KPiBBbmdlbG8N
Cj4gDQo+ID4gKwl2b2lkIF9faW9tZW0gKnJlZ19iYXNlOw0KPiA+ICsJdm9pZCBfX2lvbWVtICps
MXRjbV9iYXNlOw0KPiA+ICsJc2l6ZV90IGwxdGNtX3NpemU7DQo+ID4gKwlwaHlzX2FkZHJfdCBs
MXRjbV9waHlzOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgIHN0cnVjdCBtdGtfc2NwIHsNCj4gPiAg
IAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gICAJc3RydWN0IHJwcm9jICpycHJvYzsNCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9yZW1vdGVwcm9jL210a19zY3AuYyBiL2RyaXZlcnMvcmVtb3Rl
cHJvYy9tdGtfc2NwLmMNCj4gPiBpbmRleCBiOTIyNzQwNjc1MjIuLjg5ODAzOTg3OTE0MiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jDQo+ID4gKysrIGIvZHJp
dmVycy9yZW1vdGVwcm9jL210a19zY3AuYw0KPiA+IEBAIC04NTQsNyArODU0LDggQEAgc3RhdGlj
IHZvaWQgc2NwX3JlbW92ZV9ycG1zZ19zdWJkZXYoc3RydWN0IG10a19zY3AgKnNjcCkNCj4gPiAg
IAl9DQo+ID4gICB9DQo+ID4gICANCj4gPiAtc3RhdGljIGludCBzY3BfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gPiArc3RhdGljIGludCBzY3BfcnByb2NfaW5pdChzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICsJCQkgIHN0cnVjdCBtdGtfc2NwX29mX3Jl
Z3MgKm9mX3JlZ3MpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYt
PmRldjsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0KPiA+
IEBAIC04NzgsNiArODc5LDExIEBAIHN0YXRpYyBpbnQgc2NwX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gICAJc2NwLT5kYXRhID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9k
YXRhKGRldik7DQo+ID4gICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgc2NwKTsNCj4gPiAg
IA0KPiA+ICsJc2NwLT5yZWdfYmFzZSA9IG9mX3JlZ3MtPnJlZ19iYXNlOw0KPiA+ICsJc2NwLT5s
MXRjbV9iYXNlID0gb2ZfcmVncy0+bDF0Y21fYmFzZTsNCj4gPiArCXNjcC0+bDF0Y21fc2l6ZSA9
IG9mX3JlZ3MtPmwxdGNtX3NpemU7DQo+ID4gKwlzY3AtPmwxdGNtX3BoeXMgPSBvZl9yZWdzLT5s
MXRjbV9waHlzOw0KPiA+ICsNCj4gPiAgIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnlu
YW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAic3JhbSIpOw0KPiA+ICAgCXNjcC0+c3JhbV9iYXNl
ID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gPiAgIAlpZiAoSVNfRVJSKHNj
cC0+c3JhbV9iYXNlKSkNCj4gPiBAQCAtODg3LDI0ICs4OTMsNiBAQCBzdGF0aWMgaW50IHNjcF9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgCXNjcC0+c3JhbV9zaXpl
ID0gcmVzb3VyY2Vfc2l6ZShyZXMpOw0KPiA+ICAgCXNjcC0+c3JhbV9waHlzID0gcmVzLT5zdGFy
dDsNCj4gPiAgIA0KPiA+IC0JLyogbDF0Y20gaXMgYW4gb3B0aW9uYWwgbWVtb3J5IHJlZ2lvbiAq
Lw0KPiA+IC0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09V
UkNFX01FTSwgImwxdGNtIik7DQo+ID4gLQlzY3AtPmwxdGNtX2Jhc2UgPSBkZXZtX2lvcmVtYXBf
cmVzb3VyY2UoZGV2LCByZXMpOw0KPiA+IC0JaWYgKElTX0VSUihzY3AtPmwxdGNtX2Jhc2UpKSB7
DQo+ID4gLQkJcmV0ID0gUFRSX0VSUihzY3AtPmwxdGNtX2Jhc2UpOw0KPiA+IC0JCWlmIChyZXQg
IT0gLUVJTlZBTCkgew0KPiA+IC0JCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZh
aWxlZCB0byBtYXAgbDF0Y20gbWVtb3J5XG4iKTsNCj4gPiAtCQl9DQo+ID4gLQl9IGVsc2Ugew0K
PiA+IC0JCXNjcC0+bDF0Y21fc2l6ZSA9IHJlc291cmNlX3NpemUocmVzKTsNCj4gPiAtCQlzY3At
PmwxdGNtX3BoeXMgPSByZXMtPnN0YXJ0Ow0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAtCXNjcC0+cmVn
X2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsICJjZmci
KTsNCj4gPiAtCWlmIChJU19FUlIoc2NwLT5yZWdfYmFzZSkpDQo+ID4gLQkJcmV0dXJuIGRldl9l
cnJfcHJvYmUoZGV2LCBQVFJfRVJSKHNjcC0+cmVnX2Jhc2UpLA0KPiA+IC0JCQkJICAgICAiRmFp
bGVkIHRvIHBhcnNlIGFuZCBtYXAgY2ZnIG1lbW9yeVxuIik7DQo+ID4gLQ0KPiA+ICAgCXJldCA9
IHNjcC0+ZGF0YS0+c2NwX2Nsa19nZXQoc2NwKTsNCj4gPiAgIAlpZiAocmV0KQ0KPiA+ICAgCQly
ZXR1cm4gcmV0Ow0KPiA+IEBAIC05MzIsNyArOTIwLDYgQEAgc3RhdGljIGludCBzY3BfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgIAlyZXQgPSBkZXZtX3JlcXVlc3Rf
dGhyZWFkZWRfaXJxKGRldiwgcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKSwgTlVMTCwNCj4gPiAg
IAkJCQkJc2NwX2lycV9oYW5kbGVyLCBJUlFGX09ORVNIT1QsDQo+ID4gICAJCQkJCXBkZXYtPm5h
bWUsIHNjcCk7DQo+ID4gLQ0KPiA+ICAgCWlmIChyZXQpIHsNCj4gPiAgIAkJZGV2X2VycihkZXYs
ICJmYWlsZWQgdG8gcmVxdWVzdCBpcnFcbiIpOw0KPiA+ICAgCQlnb3RvIHJlbW92ZV9zdWJkZXY7
DQo+ID4gQEAgLTk1Niw2ICs5NDMsMzQgQEAgc3RhdGljIGludCBzY3BfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgIAlyZXR1cm4gcmV0Ow0KPiA+ICAgfQ0KPiA+ICAg
DQo+ID4gK3N0YXRpYyBpbnQgc2NwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKwlz
dHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gPiArCXN0cnVjdCBtdGtfc2NwX29mX3JlZ3Mgc2NwX3Jl
Z3M7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNv
dXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0sICJjZmciKTsNCj4gPiArCXNjcF9yZWdz
LnJlZ19iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gPiArCWlmIChJ
U19FUlIoc2NwX3JlZ3MucmVnX2Jhc2UpKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRl
diwgUFRSX0VSUihzY3BfcmVncy5yZWdfYmFzZSksDQo+ID4gKwkJCQkgICAgICJGYWlsZWQgdG8g
cGFyc2UgYW5kIG1hcCBjZmcgbWVtb3J5XG4iKTsNCj4gPiArDQo+ID4gKwkvKiBsMXRjbSBpcyBh
biBvcHRpb25hbCBtZW1vcnkgcmVnaW9uICovDQo+ID4gKwlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVz
b3VyY2VfYnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAibDF0Y20iKTsNCj4gPiArCXNjcF9y
ZWdzLmwxdGNtX2Jhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiA+ICsJ
aWYgKElTX0VSUihzY3BfcmVncy5sMXRjbV9iYXNlKSkgew0KPiA+ICsJCXJldCA9IFBUUl9FUlIo
c2NwX3JlZ3MubDF0Y21fYmFzZSk7DQo+ID4gKwkJaWYgKHJldCAhPSAtRUlOVkFMKQ0KPiA+ICsJ
CQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBtYXAgbDF0Y20gbWVt
b3J5XG4iKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJc2NwX3JlZ3MubDF0Y21fc2l6ZSA9IHJl
c291cmNlX3NpemUocmVzKTsNCj4gPiArCQlzY3BfcmVncy5sMXRjbV9waHlzID0gcmVzLT5zdGFy
dDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gc2NwX3Jwcm9jX2luaXQocGRldiwgJnNj
cF9yZWdzKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBpbnQgc2NwX3JlbW92ZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBtdGtfc2Nw
ICpzY3AgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gDQo+IA0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClRpbmdIYW4NCg==
