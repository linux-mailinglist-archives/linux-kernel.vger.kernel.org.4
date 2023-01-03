Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96F265B97C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 03:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjACCvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 21:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACCvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 21:51:14 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F29327;
        Mon,  2 Jan 2023 18:51:09 -0800 (PST)
X-UUID: 59490458d47e4d2fb2579898b8dc7e43-20230103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uGBGqJbnx+tCPMxYV82cfs00Y0Mb0In/3qgEha/A/Gs=;
        b=XiJparUzdAbvX1zLU96yIASp26aFuJHKKc55r2vOAlBX5uzuGm3H3PoyWaWzlpHHTI9tGDTzNEYPrjm/1+plDjdI/esMK85kh8SKn7W6bRhcMMeasHL80P5dHPFCGZ3zB1vFOljpeaNj/EOnPqsX9vWjXWBybvbE1u/rgRD9MWM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:0babbedd-4e10-4ec0-953f-db2da7ba0d94,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:09771b1,CLOUDID:3d729af4-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 59490458d47e4d2fb2579898b8dc7e43-20230103
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <kyrie.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1049500561; Tue, 03 Jan 2023 10:51:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 3 Jan 2023 10:51:05 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 3 Jan 2023 10:51:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyOUPOCgaXM4zZLNXfVmiSu3I83zhkjrXqGw4UzG1F/GJVl96b0Sk4eF7bcz++7meyIo0Zsu2mwZWEz2lENm+E2J47A9srTML4MzDcW3bqqCM0lwrEJpsR3qeAw0ZvPQOrjronsjkUhLVo2q33q11F1OuINpEB5moRkILl8nCY9VLfmbaXHHYS5SPYXTTx4HIwerZGHDkhlMzyejHejKL4vXwRsKtysD8JpB2By+8E1AtIrvgzlrzAB2M1DxcKnko0ilRLhHTuCagLfQsrhboSmDem13ByK9VKGfUkmIohRoa8HAL2AZt60nEp6f6teJKQ8LCxlMvnPSP6NkGiWUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGBGqJbnx+tCPMxYV82cfs00Y0Mb0In/3qgEha/A/Gs=;
 b=UuYl4Net8r/nMGH1ogHhRsyOjeFwRa1TEs4IFiV0DJ93miTkuIcd8iTS3mmY4X86VTwoF4awn4QwjuM//IaQpmAMe8go/z+oqbncW51i9/GWr2Qu0gwBpQWYqaieamzHTccE6Wk4/XEXhGnkN02YpNue6tRy6QGb9GxqKE8a2hUuCzSPV9mf9xCMine8NTV3sLBVoyAdO8hKhyHPsPUiS79MpeFxzHveYaltvg3ySnl+RVuwWBw3rslWlTEdnAiJyiR5GUM+2NXpVx7WrjQnmS3xm40C28OojniTuAe7JNtHLmFN8gsuAHsIsGykRwLtpDOuYUp35In7bejLoiJ65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGBGqJbnx+tCPMxYV82cfs00Y0Mb0In/3qgEha/A/Gs=;
 b=tCWw+SnykfdaVv1URoumoDtLJtX0gP5sKFhE6OT4++BLRj78kaaqy6JH9K9ngsVAnZB0Lj/snGfoTMApxOwr4Lw2wnVh3UsUQj3pUlq9buy2EmuaNpDa36vhr7IgbDHKstoprpUvSQwEV/0hcbKlPWrXvsD5CMD0VZXGsLMu2/A=
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com (2603:1096:301:b9::5)
 by TYZPR03MB5996.apcprd03.prod.outlook.com (2603:1096:400:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 02:51:03 +0000
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::c77c:2f56:104e:3ffd]) by PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::c77c:2f56:104e:3ffd%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 02:51:03 +0000
From:   =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>
To:     "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?WGlhIEppYW5nICjmsZ/pnJ4p?= <Xia.Jiang@mediatek.com>
Subject: Re: [V3] media: jpeg: Fixes multi-hw judgement
Thread-Topic: [V3] media: jpeg: Fixes multi-hw judgement
Thread-Index: AQHZGoovQTcaHbcypUmT2KmpPh1Uba6LPIQAgADK1IA=
Date:   Tue, 3 Jan 2023 02:51:03 +0000
Message-ID: <b602b385f148fccdf33b35f2abe59584748562fe.camel@mediatek.com>
References: <20221228070006.11111-1-irui.wang@mediatek.com>
         <fb003af2-ada4-6608-0f66-4bc929a23c69@collabora.com>
In-Reply-To: <fb003af2-ada4-6608-0f66-4bc929a23c69@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB6186:EE_|TYZPR03MB5996:EE_
x-ms-office365-filtering-correlation-id: 816dd194-3c20-4098-fa46-08daed355a50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CihMcNK4w8pRGaDzBt67GSxHVYkFTtQkMQV5dLc6j9YDuCY9An0FlJpKaVlW6AUEcCnszIzLkceuq/fmXZaelLDTWlt4uybmtOVNAAd4Mgyka5H2PbC1lJIsjycTVZJFQWamOhQmGWlliDwW0sUNZ97MoHVdiONak8MXrlGVNkEcsVHLEWt8a76FfY++4EbGigXBm194PfIzaQMEywZP5YRbJNF50YEoaOwFFq6vUZmEtNht+c5MGYotoxbCES2vG3ZTRSkT+79vOq85v1QrezDZ6UrdzBEQ0YdsDV91UUUUOBaTkIUCOmrUYtqiA7ygZQUwctBWzU/4uHcgGfPYiYia6YONEM5bbAKzJW2BGInl2EyXkIA0S+ELLDIG7ku6Fq41zmHkMIXgfhSk6s3xebDkXUHBtTrZEQBgsWUP8uUBFx0Gf7Bbw5vUXt4O042ROPKFmG3tgYjwP20mbyasHE15C9o9j7+vGuAZZjDTTNXr6kJ3ImQ34Ni3WOeKOCRNZMgK+eIb0LFx+G2Dasc5ATSC7LSJUfw552Tb9XCNtWtgTbd14abg+MLdomg0Op29mHW3vbS6rc4P/eIsHJlWrL1tseGw2Kg0mNIA9SLAR8s3mNCAj7J/Rl+zZmUYTeRXS0NevZh87dIPk+vTrLfgUjJXFOGVRq2BFqR5b5L11CK5HgFhIFACGzGrQpG5bmmprk7CBRU0b+ml2cfwyRBuxmyGMO6fE0RR9lnoH2okWl8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6186.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(38070700005)(122000001)(38100700002)(36756003)(85182001)(86362001)(66946007)(64756008)(6506007)(2616005)(66446008)(66476007)(478600001)(66556008)(76116006)(6486002)(26005)(186003)(6512007)(71200400001)(316002)(110136005)(54906003)(107886003)(91956017)(2906002)(8676002)(4326008)(41300700001)(8936002)(4744005)(5660300002)(7416002)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0dhOUhkK3JvRTJaOTQvaVIwaEh6MThpQXprQ2NQTXVWVjR4Y20rV1VuYnIx?=
 =?utf-8?B?YXE5MEhCOTJQRGhvaDJBWkE4VWZkZ2VtenBtc2QxYUlzVm1QcGx4dWlsYy9B?=
 =?utf-8?B?ViswOWx2alVrMXFJNEZ6QlVBMk90V3JyMjA1SG1EWFJBZnI4aXRzV1JGQzg0?=
 =?utf-8?B?cFp1YkNsYVJ5cmJoajI5K2FBSVlxNXBSN2RwOFVVSDEzbkQySHZWZkt4dVlK?=
 =?utf-8?B?NEt6S215YkNpUkVvZTdUdjdMT0F4QlVIWjJNczNhR3BoUVc4Zkd3MUtoQzZE?=
 =?utf-8?B?SERGaFh6WTg2dURYNXI0RmJsVXpmTzBndFpPZTRtS3oxeFhLTlVad281OVpC?=
 =?utf-8?B?SkFza1oyZG92TnJJU00ySHA2S21URWllcFlpTjhkck1oY2pQQlc1cW5pMXUv?=
 =?utf-8?B?Q0ZKZG1wVmc4YmwyeW55bExya3JGWENlMUUzV0grVnNBb1hRaEJRTWxFUDE4?=
 =?utf-8?B?R1V2bnRQMmhxd2pGYVd3c2E0TWZRK2N5Nk1qdVVVc0daR3BQWnZxYkZsNlpq?=
 =?utf-8?B?Ukx3NzVpVzcwbm5ocDM4QUNwQjBnUStIWENGcHlCWGdhcGpUVHRUY2N1UWpi?=
 =?utf-8?B?VDhWd1FOSThCcVpzWUUvbjNmb1M3UmdPUUxaSVpVY0NqeDMySUpncXowTzQ2?=
 =?utf-8?B?RDJYWFVmWUVYVDNOVXRkbWxvdWltSUdxRDEzYURvNHN4UVpBTGhDTEpsU1Fy?=
 =?utf-8?B?Q0toY1gvcDR4RmM1M05weUllbElraG0zcllTcUREbUlHTnFTMEV6bWVhSHZC?=
 =?utf-8?B?YUlRZHJTZmlhcXhJTnI4NkgwTTdxdGtNRkdPUjZnRHgvN0JOZEhFaldXMzh5?=
 =?utf-8?B?WmxOOFFNL084OENjb2JmVW1YN3RHTGl6amhnN0tRT0NxUmd5bU9NQmRhV0p4?=
 =?utf-8?B?TlAxRllvOTNjMHptaDhFcDRtQ2Z0OWUrUy9Pc0lxcmZKNWMvYVl4QTMreHJk?=
 =?utf-8?B?cXNZRjZTL3hBVDZNQlFYWEZWc0F3YmlnYTBIWWcrZGh6SUtQeUFHOEhndGlM?=
 =?utf-8?B?TTB5SndtZ0dYOVNUOGV4QmtENDRndEtBdE5iWHlBME1ULzRienJyZnhaRTEy?=
 =?utf-8?B?WjdiQlVCY01VNDdpa055emkrQWlvVlVxZE1uRmkxUEo3Sk44NWd3emJvREhR?=
 =?utf-8?B?cE9zZ3dHU0Q3RTNrSytUVFQ2alNLYWZ4d3A4cE5obG9ZenVNTHk5WlMrUFhx?=
 =?utf-8?B?ZDNrenk3WnRNak5YTlV2Nll6SlpQbHhrNEdIRlUrMlZ6L1pNQ1hJdmgzeVpr?=
 =?utf-8?B?WEozb3VyZFJGRzBHbWNrZUVZMEZCQXdadzViUGVMWnVWYThtQ2xqM3pzcHhy?=
 =?utf-8?B?aFZvTXR1cVpDd0tyMExCdGFRbDFqVTI2NHF1amV0VG51UHdjbmNIWW1PcHg4?=
 =?utf-8?B?U2JFaCtIeWJuVHk2TjZFK0tTRXhIVFdGbXY3WC9LS3hIQlVqSWdrOURrY0RC?=
 =?utf-8?B?bHBYNkwrQ0J3OHNzTWREZlhsdE9DNG1zTjFwRDBQQzlQTW92em9IRHRONkRV?=
 =?utf-8?B?ZW5sUVJoOGhIZDVPT09YTWRMbEdGZ1VXdWh4YXY0aGlEdzN2QU01TktFTExR?=
 =?utf-8?B?RzZ6ajJJSW5CQmh5Ry92QVllQ0t3ZWd0aTZpTjNjbWNNRlFiZ280Uy82R25n?=
 =?utf-8?B?bkN3STJvU3BOd1FHdzBZUjhsU0dJMTJnWElqRW9jKzdILzk4TU9RK0JuMk15?=
 =?utf-8?B?VDZjQTRTUTFLZGh2VFNKUnJSenY1ZmRYRnZKMXBLdHJlRHR3Ry9DcU50WExr?=
 =?utf-8?B?ZWpDLzdvOEpyYnlsSGcrMzYxUEdveFVUaEQwZjBkUXIvb2pqZHd5RVJwTk13?=
 =?utf-8?B?L3BQMGpzOUV1Vys5M1FGU0RDNVRjWWZSN0R6UXFndThVRmR2enZMOVdaMXZi?=
 =?utf-8?B?TVU0elJvN2JaTkNQdUcxZm9CRmtmNy9SbHcrNVduMis2Q2pWRTZ3V0RPSHNy?=
 =?utf-8?B?dm8yK0Q2Q3hoT0lmWFExc2JNaDJVZHVlZU0xMFhSanNKODc0dmJSeTdLT1dC?=
 =?utf-8?B?RDJCY0pkWEg1eXRYa1g3UUtUbTNJcnNHbzF4cmIzTHBaNU1RUStVVUV5RXpY?=
 =?utf-8?B?Um5zalJkNUNzTzdsOU5temRFb29XLzhQS20rMGNvLzJkYXZ5T2JkdlBydHV0?=
 =?utf-8?B?b2VEMCs1ZE1qQW1KZGpyUUZENkZacUpUVStLRGwzM0VPaU9ReTQ3d1NVUU1Z?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9828B88DFEA8F2499FA63F736A7F6E54@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6186.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816dd194-3c20-4098-fa46-08daed355a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 02:51:03.0496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5orTsfoPxepliJN2RXn2I9PnpaHmtxpYBwHonYXSlMt8zv7fwiQxUzdCTSvCOAF238LPiDMG/AM9+C2ul4mp5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTAyIGF0IDE1OjQ1ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjgvMTIvMjIgMDg6MDAsIElydWkgV2FuZyBoYSBzY3JpdHRvOg0K
PiA+IEZyb206IGt5cmllIHd1IDxreXJpZS53dUBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gc29t
ZSBjaGlwcyBoYXZlIG11bHRpLWh3LCBidXQgb3RoZXJzIGhhdmUgb25seSBvbmUsDQo+ID4gbW9k
aWZ5IHRoZSBjb25kaXRpb24gb2YgbXVsdGktaHcganVkZ2VtZW50DQo+ID4gDQo+ID4gRml4ZXM6
IDkzNGU4YmNjYWM5NSAoIm10ay1qcGVnZW5jOiBzdXBwb3J0IGpwZWdlbmMgbXVsdGktaGFyZHdh
cmUiKQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IGt5cmllIHd1IDxreXJpZS53dUBtZWRpYXRl
ay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogaXJ1aSB3YW5nIDxpcnVpLndhbmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gUGxlYXNlIGNsYXJpZnkgdGhlIGNvbW1pdCB0aXRsZSwgYXMgIm1lZGlhOiBq
cGVnOiIgaXMgZ2VuZXJpYywgYnV0DQo+IHlvdSdyZQ0KPiB0b3VjaGluZyBhIGRyaXZlciBmb3Ig
TWVkaWFUZWsncyBKUEVHIEhXIGRlYy9lbmNvZGVyLg0KPiANCj4gQ2hhbmdlIGl0IHRvICJtZWRp
YTogbXRrLWpwZWc6IEZpeCBqcGVnaHcgbXVsdGktY29yZSBqdWRnZW1lbnQiLA0KPiBhZnRlciB3
aGljaDoNCj4gDQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+
IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gDQo+IFJlZ2FyZHMs
DQo+IEFuZ2Vsbw0KSGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHlvdXIgYWR2aWNlcywgSSB3aWxs
IGZpeCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MgYSBsb3QuDQoNClJlZ2FyZHMs
DQpLeXJpZS4NCg==
