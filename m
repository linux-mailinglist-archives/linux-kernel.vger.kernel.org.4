Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45426297D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiKOL5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiKOL4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:56:39 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2316418387
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:56:37 -0800 (PST)
X-UUID: 1f65aa761ea04fb59f00a5067cac0bce-20221115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fHV1FFsbajViwx+5mQs//CBu4BRe86chrvbLi5SHO8I=;
        b=oYSk449Q9/7SPz7+jXRRCkljLnJiWxf1R1MxPXIsQYR5doZhQ1e14M/R4uQ2LUMgtC9Lle9AN0FOHc4aKzIxh5rI3zkijFuv5DfS0Kwkq5iWxHKV4apJktfADdZemTzZ38QLkIgJj2DByaEiA2yrBcdNCZCS8G2fHeWst5RDKLY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:445c90ef-022f-4772-8f7e-2184c72caf4a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d12e911,CLOUDID:f2ce3828-7328-4d53-af97-37d3ca89e562,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1f65aa761ea04fb59f00a5067cac0bce-20221115
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 577911261; Tue, 15 Nov 2022 19:56:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 15 Nov 2022 19:56:34 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 15 Nov 2022 19:56:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOOjZc3tx4WkB80nYS63p6W0Z2sRSvdxJlgKWz2d1r7VxrBLBorwUvU5TAAqCD6zPaRtMAvpDCnS5CFnVFl+JSJwenx6LcvAR1gAv134ByVxtzCQHXXO8YKhwkb1jQfYwIhlRySf7j4ed9HSyZ93tz2fIqlic7kAlPNBoI/J4YyzKb9F4c3zudy5DOnP3fHLvTzp/i33zUo3HFpmF+Ov9U3NsdJLXrNdXupMPzLOVA1vOXR02MMQp7t0t2jptviUNKcruLKm/h7xFgIpDLxK2vbbk9ZOn6nOQjqTBeniIGlgA4/NNl9+MAgmFO9MvPBhEcwpLLYDlRvy6T3cDdj0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHV1FFsbajViwx+5mQs//CBu4BRe86chrvbLi5SHO8I=;
 b=MwkjmFTUYHLZREF0SDDO0utKgUDCaau1M3Plq31CN/wJa6LAuptVgfV69StaugPUR9hTId6lhl4DSNJhlURbU8ADQ9asB5MtHkKfUd2rFBX/uLURtO28vOugNAAmFfW5LxAvln7MvBvCpCb2KZz9o73CRQUUAq+KISHb4FovA0ab8DpxhbU0rvwobIp3DLSLZMCAJd9FQgMl8RKu2Nk6DKJH4BOjYnZ7WjD5ObVddQJp9TmeKGEs/beKF3PF+UIAyOfhm99xEaNHUEt4hYtvsGPoB8+dJDgTdfgmIgtBIxSsDMFpk1TmzcPIUMC4qMav84BHwR7rPKWn0yroAeQDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHV1FFsbajViwx+5mQs//CBu4BRe86chrvbLi5SHO8I=;
 b=O1gXKz2SIklSpB069XbvQirxCVGVkNHVpKF3oAsCMXDMPojygtb/Jp8xd2S3bfBF1yunHSOM3yykrGo7FkOli0cROHHASNBxf9s0GjGIlGno4MA1U0fdfO0depen4cxVh9agl1L8Xg7caW6axB7LG1SXWgHV1MIrwIG2pEpYL3g=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by TY0PR03MB6583.apcprd03.prod.outlook.com (2603:1096:400:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 11:56:32 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::a302:d5da:f54f:a75d]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::a302:d5da:f54f:a75d%4]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 11:56:31 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1] soc: mediatek: mtk-pm-domains: Allow mt8186 ADSP
 default power on
Thread-Topic: [PATCH v1] soc: mediatek: mtk-pm-domains: Allow mt8186 ADSP
 default power on
Thread-Index: AQHY3g/idaSasqXP7E+kkGotWaHzpK5AFnYA
Date:   Tue, 15 Nov 2022 11:56:31 +0000
Message-ID: <c704f86f4085be5e180ea84b078d1cc81864c53c.camel@mediatek.com>
References: <20221012075434.30009-1-tinghan.shen@mediatek.com>
In-Reply-To: <20221012075434.30009-1-tinghan.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|TY0PR03MB6583:EE_
x-ms-office365-filtering-correlation-id: d5543d1a-7d90-4d93-0a61-08dac7006ff6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +KlDVtOpdZN/BKKeM6dmOnRLTPsy7yOiwAUNkrXGtbHNHBW5kilPbEJ8BmI9wGqxLiBgLrYKvOsti3y41QHsF6sd156Kv+WSev9AlyH6HdCvyiau5/dptIEwjRjWejFHkWo+dqqkqUKcfKTjnqxAR6H0CZzr6iYnFbIp2h3yI71NHZ/9jiC+4EPbcQXleRMJSJ7bJQXcSOYi+74NBYxR+JVaBCGHd94ax5tItRHh754rPokVKw2HboUtKZxLmu1nbcgIK1pc0T9ZiB79xi/o+pQN0Y9K7amcuOlTRPEkY/Dorj2RJ5hYrkFkjThJsRKGi6W6VNj2wRsdEXcWbBJ7+X2qBuHNMbHFNEYw69Q6DK0rmRVzyIbj0sANgaa1MGc4YFwKfZgp/wSfU5MteDWscj3jtbjtbH03R0D2+Ki9RqZD4hK5Vmfb2/DsZ6g3FwwB2wqEqW3+gexXqVrcJGT0YbMgNbaXRCFXcZK8tRqEBcsFG1VELzkMTsFw+ZXdmt9RqCz2VnrA2kTIkEuf76PITFgo+gNUjtUm0/an5ZnDlfUSE0dRT16tOw0hXCyEwsKLR7kZ0s4EA6lNQLAjeu3DTzDycHSqimw+87HfTWptRo+SZ6ZCmuVP/fB13HZrO6mV1O7+Q5GLm45aD67iHs6Ab5Mv3OabyE9z/o2z2erp6fzK2G9+PwhS8xS+fhv3lYZZAsegPoVuMwdGF0whgNTdwASrOApESUjIRFJ7FC3MLEfi2PBjZO4aQ68zEGoatch7yhtj7iS+9rZgWlKcEO+ZSRtJDeFH5w81vbdT8/82njnovO7cn3vaNS96P+Iv6o1q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(107886003)(71200400001)(478600001)(6486002)(54906003)(6916009)(5660300002)(66556008)(8936002)(85182001)(36756003)(6506007)(41300700001)(2616005)(2906002)(4001150100001)(66476007)(91956017)(316002)(6512007)(26005)(8676002)(76116006)(4326008)(64756008)(66946007)(66446008)(186003)(83380400001)(86362001)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1hEMHFoTnJLZlYwaTZjRkpLZmMvQTYwMjUyZFFCRzVXZVhwakdIWUVnSWxO?=
 =?utf-8?B?TjU4N2hvWUFUUzJnaGtYQyszbkdlbEo4Ui9ETE85cHQ5TkFrYUFCVm1FZFBR?=
 =?utf-8?B?RHAvVG1EMjhUcmwrRzVlWURYelBYNnRhM1B6VG9lTW91VjA4UUJ0WHUrTWtv?=
 =?utf-8?B?RUZiMTNVaUpkdFZQNmg3bmxlakE5ZUJkRFVaYmltalMrSEpEbnlKUVFab0RH?=
 =?utf-8?B?YzZOSVBSQllKMHFZay85cmFSUjdYei93dDdOclBOVTkvbFk3NnVSUVpNUWpt?=
 =?utf-8?B?NmNyQkgrcXdHMmhoUWF6M2M3VXE3MnB4T2daK20yMUJoS0wxNU1STzV3NFow?=
 =?utf-8?B?ZWJoVCtTRmxQSmlTY0xGWXFKNUtwQkVQbVhTckxid1Nrb2hXeFUvODRDSWdv?=
 =?utf-8?B?b3RabGRZeTFpemZBLzJMdGRUNlI2Qmprem1pWVh2bER3R3ZhQnl3MVkzcEtX?=
 =?utf-8?B?eWpTRzAyTzQwdkNBTW4vWWJQTitpK0VOM3NLN0dkMjcvZmpNbjJqc1YzdjZQ?=
 =?utf-8?B?am5pS0E2YkRkRFdjbmNsZ09rODc2YmNJS1FkenpST2pETWNCdFF5UEw0V0NQ?=
 =?utf-8?B?d1Q0MzFxY1A3YWp0cWljY3pGUUluSW1WYWZYeWlNMFZsakdmb0xrNCtLSUVH?=
 =?utf-8?B?OXRCUkw2VlVldVc3ZmVBRFZoaE1keTV5TE0zaGMxL2FHcnd5N2RKUkFtdWlv?=
 =?utf-8?B?eUdKdld3YlA1OUNFcmVBVkNrMHhVT1VBVTh0bGV0UFJUSEs1L0RoRTlEcEJp?=
 =?utf-8?B?a24valdvWnl2T29PZWdwejBycUhvU1Fxa0ptYjF3ellWZmJ5OVM1bEdNWG1k?=
 =?utf-8?B?RnNSbUFqK2hxemdJeUxGZnJHV2V3MTlWOUlQbzdSS1FvZW1PZ0hCQk04VUVt?=
 =?utf-8?B?cHhrQ1JrYWtTL1VpYlFqZjEyZy9yUCtnUHRZYUo0empndnY2c0lCS3IyZE55?=
 =?utf-8?B?SXIyd2RDdnJrUTJ2NXgrY21Hand0KzRMeno2YUlPUVptZlpISnB4MU1FQnFH?=
 =?utf-8?B?T1ZaUWtGcU5kR2gxN29ZS0h2VEZxb1dTcEliTzZ6cWJWdGJ4WnV6WmxjcXR2?=
 =?utf-8?B?V2E0MXJxT1RZcFk0Y1hBYk1ycXdtKzVWZmdrV2JtOFZXRld3WnpBYTJmZDV5?=
 =?utf-8?B?QUVvVWtaTXFYcDNCQWNXYWVTaXVIT1I1WnQxa25JZU9WeWtTSnZyaXY1SWNT?=
 =?utf-8?B?bzgvMEM2V3BqWVVqeHhzS0VQVTVqUWZHVVdrQ2NzVGFUZ2NJYVYyWDNqSEJ3?=
 =?utf-8?B?UHdadmhTWG1VR3craG94UXpmM3ZzbHVCQXA5Nlh4ak5mMGcrTWFad1c3Ukhi?=
 =?utf-8?B?aEh3bjRsekNtNTVFMWtXbjd1Vk5wbFpJek11NUJuWHJzR09vcmZSTmM4NHNQ?=
 =?utf-8?B?aWJxT013QnJyV1M2ajVkQzdwbzhibkp6eWpGdWtWMFZNdnhsRnROcU45ekx6?=
 =?utf-8?B?WFUyNnRjZGNhWE5Zd1A2NHFrbS9IdWgyeHEwckFHbVNySGJaYXA2QmZtamFy?=
 =?utf-8?B?RnlhWEllUGE2aWpMR3Vnd2FsNUkyenQ0ZVAyMXFLREpPQ1dRMXVSOGV1clZL?=
 =?utf-8?B?djl6RXl1enhWTS9acHJBRzlPOENhOUhqeW45bmNhVlI1ckpaNVJPek5FbEN1?=
 =?utf-8?B?YWdmd1Z5d1ZoeGthRnJqSlk2cGNLYmZZM0VuQnBLVklCWGlpYzZiUTZFVHp5?=
 =?utf-8?B?OVJjd3JaeHNFVlAwRk1pSDZUOS9LSE5FK0JvS0JuOGJrVXp6QjFITzBFRGF4?=
 =?utf-8?B?NHJVbmRpenBsYVUwNndWUXBmWUZhUVpmWGQ0U25LSlBzK0NKMC9oV1Ava2g0?=
 =?utf-8?B?Yzd1OEF5bThOdVZDSGlJdlVTTzFKUHI4blVmRC8xdHlBMXcxdytQNVpzaDRu?=
 =?utf-8?B?eW9ib2Q4T0syOFNhci9SQmtVMVB6NFFkaEdNblcxbzdZUWpNeG1PZG1TRGNW?=
 =?utf-8?B?NW04cFdKTmtYYmNHY2hxeWZSVUs0MlEwRkZMNFBWSFZnRE1vYkZSY1NaTGVm?=
 =?utf-8?B?R21kelR3M0pBbmJKcjFTTkMrWDdiMGdQQ2dYS1ZtZ1VGN2lCU2RuaW85eC92?=
 =?utf-8?B?UVRpNDd4N3NqdHRDRytxbld5aWNlZjhlU1MwcjR5WlFnRnQydXcvczN1OGM0?=
 =?utf-8?B?elRPUU1BMnYyQVF1VWhsNVlraFBxdXFnN3k4SWVKeGtuQ1JUOE5MRDhseDdY?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56741B4674D7FA489C242AB3512D66BC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5543d1a-7d90-4d93-0a61-08dac7006ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 11:56:31.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kZi0IH3lfFA1Icuu/t3DmyAulvicgtXHRJE44dVtnmNO0mvlVmGNIgklDZOXoUE365p/m43lMisPysAyU71V96NcWSqzpXpTWOhlYy+GEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6583
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCkdlbnRseSBwaW5nIGZvciB0aGlzIHBhdGNoLg0KTWF5IEkga25vdyB0
aGlzIHBhdGNoIGN1cnJlbnQgc3RhdHVzPyBJdCBzZWVtcyBpcyB1bmRlciB5b3VyIHJldmlld2lu
ZyBzdGF0ZT8NCg0KQmVzdCByZWdhcmRzLA0KVGluZ0hhbg0KDQpPbiBXZWQsIDIwMjItMTAtMTIg
YXQgMTU6NTQgKzA4MDAsIFRpbmdoYW4gU2hlbiB3cm90ZToNCj4gSW4gdGhlIHVzZSBjYXNlIG9m
IGNvbmZpZ3VyaW5nIHRoZSBhY2Nlc3MgcGVybWlzc2lvbnMgb2YgdGhlIEFEU1AgY29yZSwNCj4g
dGhlIG10ODE4NiBTb0MgQURTUCBwb3dlciB3aWxsIGJlIHN3aXRjaGVkIG9uIGluIHRoZSBib290
bG9hZGVyIGJlY2F1c2UNCj4gdGhlIHBlcm1pc3Npb24gY29udHJvbCByZWdpc3RlcnMgYXJlIGxv
Y2F0ZWQgaW4gdGhlIEFEU1Agc3Vic3lzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGluZ2hhbiBT
aGVuIDx0aW5naGFuLnNoZW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL21l
ZGlhdGVrL210ODE4Ni1wbS1kb21haW5zLmggfCA0ICstLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdDgxODYtcG0tZG9tYWlucy5oIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXQ4MTg2LXBtLWRvbWFpbnMuaA0KPiBpbmRleCAxMDhhZjYxODU0YTMuLmZjZTg2Zjc5YzUwNSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXQ4MTg2LXBtLWRvbWFpbnMuaA0K
PiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdDgxODYtcG0tZG9tYWlucy5oDQo+IEBAIC0z
MDQsNyArMzA0LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzY3BzeXNfZG9tYWluX2RhdGEgc2Nw
c3lzX2RvbWFpbl9kYXRhX210ODE4NltdID0gew0KPiAgCQkuY3RsX29mZnMgPSAweDlGQywNCj4g
IAkJLnB3cl9zdGFfb2ZmcyA9IDB4MTZDLA0KPiAgCQkucHdyX3N0YTJuZF9vZmZzID0gMHgxNzAs
DQo+IC0JCS5jYXBzID0gTVRLX1NDUERfS0VFUF9ERUZBVUxUX09GRiwNCj4gIAl9LA0KPiAgCVtN
VDgxODZfUE9XRVJfRE9NQUlOX0FEU1BfSU5GUkFdID0gew0KPiAgCQkubmFtZSA9ICJhZHNwX2lu
ZnJhIiwNCj4gQEAgLTMxMiw3ICszMTEsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNjcHN5c19k
b21haW5fZGF0YSBzY3BzeXNfZG9tYWluX2RhdGFfbXQ4MTg2W10gPSB7DQo+ICAJCS5jdGxfb2Zm
cyA9IDB4OUY4LA0KPiAgCQkucHdyX3N0YV9vZmZzID0gMHgxNkMsDQo+ICAJCS5wd3Jfc3RhMm5k
X29mZnMgPSAweDE3MCwNCj4gLQkJLmNhcHMgPSBNVEtfU0NQRF9LRUVQX0RFRkFVTFRfT0ZGLA0K
PiAgCX0sDQo+ICAJW01UODE4Nl9QT1dFUl9ET01BSU5fQURTUF9UT1BdID0gew0KPiAgCQkubmFt
ZSA9ICJhZHNwX3RvcCIsDQo+IEBAIC0zMzIsNyArMzMwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBzY3BzeXNfZG9tYWluX2RhdGEgc2Nwc3lzX2RvbWFpbl9kYXRhX210ODE4NltdID0gew0KPiAg
CQkJCU1UODE4Nl9UT1BfQVhJX1BST1RfRU5fM19DTFIsDQo+ICAJCQkJTVQ4MTg2X1RPUF9BWElf
UFJPVF9FTl8zX1NUQSksDQo+ICAJCX0sDQo+IC0JCS5jYXBzID0gTVRLX1NDUERfU1JBTV9JU08g
fCBNVEtfU0NQRF9LRUVQX0RFRkFVTFRfT0ZGIHwgTVRLX1NDUERfQUNUSVZFX1dBS0VVUCwNCj4g
KwkJLmNhcHMgPSBNVEtfU0NQRF9TUkFNX0lTTyB8IE1US19TQ1BEX0FDVElWRV9XQUtFVVAsDQo+
ICAJfSwNCj4gIH07DQo+ICANCg0KDQo=
