Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE7864E611
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 04:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLPC74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 21:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPC7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 21:59:54 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527092C666;
        Thu, 15 Dec 2022 18:59:52 -0800 (PST)
X-UUID: 25894adf2aca4a50b26db6e83cb4436b-20221216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=a9r92gHl5RSwHWtj6PjPR9lHKPvhjBBL6bjD/ZkoFhg=;
        b=r+BG4vIRrbBi7Cc4D5iPvxD6IbSf2V7P0jHofLY0QRxNLG66O9KFy/csRHxOrw/JgYuY72HnI91uxfk2PQkBzXaTtNjKwe6thF9oxcGnSYdy7VT+yZs/Q1E6GwV7okQTJW31gOE5bg7DF4tkR2t0Q7CWwAis8N+HQ8YKA4dwWj8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:9816dbad-0a4c-4354-91a2-0823048ae33f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:1c366535-a6a3-44f7-8aad-08fee1939a08,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 25894adf2aca4a50b26db6e83cb4436b-20221216
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <kyrie.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 784232071; Fri, 16 Dec 2022 10:59:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 16 Dec 2022 10:59:44 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 16 Dec 2022 10:59:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed3MTB6IQGrVfXMFlDHTl/MUrYIObfbqomeq+thyvSN1kPDAtLSrlmCtgK9N4+yv4irmUMyYWLNgNHTYspQX13dvoOun8DJpJ3PKHEWqiBhC/69mpGgOXJVVY4kOybhCUEqV+xqrr9QGYgHEfGWo8RW/MwKiZKr0uluBcdrlKrMdGKP7c/5RvJONuiO1eitW08KN9B+wnqXUjF6veYazGN9WkOF2R7AKM2u2GDRA1cpOPe08XcJLqMaomnWPQ9njSInd6Hft1M/tEplB+7FWRYeCohoCFK5KpSaR3/JRcn+vyOd790qZX/OFf7pCg/8oc5BPULtFnpWvg+8wXQUh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9r92gHl5RSwHWtj6PjPR9lHKPvhjBBL6bjD/ZkoFhg=;
 b=WovHp1TxPmwKkVDCugbV0dfj1b5I5vOXqCkjxgQbVvHBAPYQfbe3UsrB2yUVG43WU+SHk1X7o6A0LShfW9IsRTQ4XI5aSdqWcubtP50yK0Kon/ulwMxP+aqhQNLZV/s4S9Djvqql9wMlEjT45zdcD4+WEtWRYfsrrz+w7veIXDJOgNlushGnlOn5Pb3vlAY7BX/UuWl9UCWfPHrXoBWiS4iPabL7sTW5Y/uTOcdRIns33pmsu1bbCTVPuQ+pBZ8E0lcZN/Nzs0YdAthjvcCshKSLWRa2QuaILgzHaR1G5C68MdsOMXNrXqtVnRitnFVwcVbhEW2yhAcn1uG3BChUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9r92gHl5RSwHWtj6PjPR9lHKPvhjBBL6bjD/ZkoFhg=;
 b=h0kPUMfm74ystT2cvXSyGxJhVxuLMfgxjd41HcNI6uIWWxoo9hlFzpyXy2muMlezXp8fBvs5+vTb2/+a7xhNQpJqv/3fOIPLYmCCZBW+pCu9UFoAQ+81kdVoYuKeBdXLg+CHKMyEv6GEshV0I57imFZsMLZB1ddLgcOZva2kd8c=
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com (2603:1096:301:b9::5)
 by TYZPR03MB6694.apcprd03.prod.outlook.com (2603:1096:400:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 16 Dec
 2022 02:59:42 +0000
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::1034:e90c:9e7f:2b5f]) by PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::1034:e90c:9e7f:2b5f%4]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 02:59:42 +0000
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
Subject: Re: [PATCH] media: jpeg: refactor multi-hw judgement
Thread-Topic: [PATCH] media: jpeg: refactor multi-hw judgement
Thread-Index: AQHZEGfw5aBxnSQoE0mwMolHiJ6SI65usxgAgAEg+oA=
Date:   Fri, 16 Dec 2022 02:59:42 +0000
Message-ID: <df227dbb7c2022b11b221303956d4e83d4871292.camel@mediatek.com>
References: <20221215093026.12322-1-irui.wang@mediatek.com>
         <e265a659-c2a0-7736-ad9f-c6fe8fce5432@collabora.com>
In-Reply-To: <e265a659-c2a0-7736-ad9f-c6fe8fce5432@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB6186:EE_|TYZPR03MB6694:EE_
x-ms-office365-filtering-correlation-id: f5d6a1cb-f10f-4f4e-dd8c-08dadf119446
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pD76IZMtn8elXlKIgxYDoA4vlsKVD2YacaSnV/qpFWS6OBgoit2wl7RSiIFGrNRCmB8WsiJPAWcL5xFwNCsI2VETMbIja5muooHXggxfPkCUGunz4THr0/439jdHulinx5jWw2XAo2y0KsVCbDB2LeMaPiPOMZ2sN32BQVcbpbDLYVWfznGQQ8bfk6pOmIi4kFgOKcvYlxcvj/bLzumzeKnqy4dl/1BUTAoQ95OZQnsu0rOIZJP2AVeFm6SuHlGwMoE6heorAbyXJlxQb6yOgr4kRP8e40XGyPvOQBwlOmrCBvyuBnSug3P2cICkaX6L0JGiLs52Lrm2YecZV/3Jo6HGEzGwukMuV//XtvjPP8iWxTSVOnmzBrwVc2ePhNYbGd2vsiQPmHqo7fFoSjnYCQZOqUgiPyOcMopjC+xSyedDFp2jTGUHvkgIVEGC6rfhTh7G97ra1Rfxif7jjxh6u2I0O7R5RTIKv4yVoA+rE1M3Ib5A0GM6iko03dJws0eN30lvlPuutIilUeoG6XaWiZhzAhgmwt5W9uoqThleJyRQ/cSCXA0TObD6UjpC/89K63r9egr0mLKqiv2Z88bMlcX9AMVsXtKc9wB8GqMby2IDRM+bZuT03qmz23OfinSrdVGLsCWcSS92m1Tr61GK903DYpYDXX2W359r06GF9Fetzj7+X9tIcxAc8XpweVok
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6186.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199015)(76116006)(66946007)(66446008)(64756008)(91956017)(4326008)(8676002)(38100700002)(122000001)(478600001)(107886003)(66476007)(4001150100001)(26005)(66556008)(316002)(86362001)(6486002)(8936002)(5660300002)(7416002)(6512007)(6506007)(71200400001)(4744005)(36756003)(85182001)(41300700001)(2616005)(2906002)(54906003)(38070700005)(186003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWlLR3BySW0xL0hNSW00TUowaWRkdFRhRGVVbVpwUU9SYkpQcVJtZlhLdEgw?=
 =?utf-8?B?a0l4U1ROUFJLUlIzTkR6aGpCUzVNUnpUV3ZMYVdRemtOeWx1WlJSZzRjNG5B?=
 =?utf-8?B?Q2hEZVRIc3ZWMXpsVmtMaC90QnZyYjVWM2RnRDQ5WWRQQkc5ektzeURxOThS?=
 =?utf-8?B?NWZrbE9ITkYwMHJkNXBrcllrZnRYYVpvdXJBOWhZMnd1Vnl3M0tkMEVyYmZv?=
 =?utf-8?B?S3JDdGdqbzVzZHZGUnpGVlExemxkczA0bG5nMEJ3WEQ0d0NlVForQ1V5aTNP?=
 =?utf-8?B?YW4zVmxyZEt0N2RodGxxYUN6Y1hzd1RNelRSUk53aCtlTjZwcUxzbEJ1RkhN?=
 =?utf-8?B?Q3J5ajBNMDdWOXc4WDdWN0pJUTR4bXR6UXhaOTFCMWdXcHI5MDRyRDZ3dE15?=
 =?utf-8?B?QzlGWTJ3TWIrcjZ6SFRtMXZxY0FkRXM0dmVSREx6Q1V0VmRWMlpRMXhEZDNY?=
 =?utf-8?B?OEhkcXRzYmd5K2xnRXNWVkNqRXpPTUlQdGlBU050K1owdW5iYmZtWEp2OUtQ?=
 =?utf-8?B?L1l4d0M0eFVEdWJmb1BRSTVMendkekdOK2hvTTVZRVRaTzhUQ09JbFNoNjR4?=
 =?utf-8?B?VXdPeDlTSVpTa1ZreGpOQUZsTTdrdTZyQ1VoUVBrTnVrNHYxUm1ZSm5TVWYz?=
 =?utf-8?B?ZTI1ZjIvOTNIdUdTSStKRy9mSmRaWTFsTEhyTmxMZ29Ta0phOEZmbnh1Um4v?=
 =?utf-8?B?dGlQN3BwTm5ORlNJU01uVDhJZWpLaWp2OWdHclpRNVgzSU9QcGNCNnp0YXNh?=
 =?utf-8?B?SHNqQzlFcG1ZWVFUYTBLZEpXUDNhZzRrbjIwdDQzSjBNVStUMjBDMldEYVZq?=
 =?utf-8?B?OFNwSW0xMUFiWUZueGpXeC9IcWd3bEhJTFJPQWpPMjZDMk81RzNPWTNReURH?=
 =?utf-8?B?MVMwby9nRXMxbmJSdktITVhZTjJuZEJRZXVRdC9sVE9ORVI2UUlZSVFSWVRV?=
 =?utf-8?B?Uk9keFNTWnNua2hkMGR2YmlRckkrMWdQMVFhckxuYlJyRXBqWlBWZU4xQzM3?=
 =?utf-8?B?TmR2dFFvL3BQWktxa2ZiN3hKWVhwZlJGNWdFZ0JWQ0szbXRQcTcxSFBRc0cx?=
 =?utf-8?B?S1FEU2psYXRWbEVoeGJwMjlzb2JKVnBrNW5vTnZhUmZsd1M0ZzB3b0dUM2RG?=
 =?utf-8?B?V1VUSTQzWVBwNzJ5anp4ODJ3ZWhETXZjdmFWdjU5TG4rNXZVVkk3QmFlR2dq?=
 =?utf-8?B?TVlaNlk1dFdqY2xOS3lIVnpkekNYRWl6T09LK0owKzV3Z3RQRVBDem1SSElz?=
 =?utf-8?B?OTJ5MFRHSGRiU0xtbjZjWGpHQk1KZVArVzRteVh2YW5Ya0FTa2xoaDVSRTV0?=
 =?utf-8?B?WVVkZFFWcDd4TkpPSnh2R0c1b1QzdmtaTi9ybVJYNkNxR25DZGtWMzhTbW5r?=
 =?utf-8?B?a2s0a0wvVHFhdU9vS3FYMkQwdjBNdVJmNEdrdVFHaStRakFVRTE2cHJiN0Fr?=
 =?utf-8?B?ejI4c1F1UDE2ejRxdVBiMWpwQlNuNzIrWTNLbjhwVklvVGdHRW1LTm94azc1?=
 =?utf-8?B?V1pHT2xvTEMvUE13OTV3VkQrejBKTVQ4SkpWbTIrTTlPempFK05zQWE4ZkxX?=
 =?utf-8?B?WmtLSkxHOTNMRjVuTGdZaXNKOC9jOEJpZXIzeFdCK0IzQ1RaR0tpclJOaitM?=
 =?utf-8?B?QnVVNDBTRzdYNGE1WW4xdjNaaHJkNjAvVHZMbldTV29iNGp0UXdrRUY1Ukhw?=
 =?utf-8?B?REFVU25QVFRlMnJhanpLaGx3WDVveW4wOE1YWEdaKzFKMVo1L2VLREpScitF?=
 =?utf-8?B?VjJYanc2RUFjbnVnVUJkNm43WlpkNmJrZ2ltTE9SUS8zN3RMeWwvRmhJbTRl?=
 =?utf-8?B?L01TeHFaYTJsbGZiV1hRY0puajJHbURnL2lMa2llaEFZV1RrWmZMU2t6Mk41?=
 =?utf-8?B?ZXNTeVBkQXhDbHdRbDBZS1h1cEdod1hwdFl6cWNQWElRNVcrd1JUbndVdmNw?=
 =?utf-8?B?b29jQi9Vb09JcWt1UHpUczZkYzVkUnFSUjM5czF5R2lDN2ZxdTIvcHdMMDg0?=
 =?utf-8?B?eU1WMFJjWWJoSlNzYWdtZzRETnRjOWVoTmxQWmc1N1lGZ0JGdUVSaHY5NTc1?=
 =?utf-8?B?VjRkeVNaMGxFMEE1bzFiZzRNWU9qM0FmSys5QmpMMVdmNWFNVTBmVWxGTkRQ?=
 =?utf-8?B?bFo2OCthRzBzOHNhWkpRRzlNb2hyVGgybjRXbUhuTU1sdXVKNlMzeStUekNu?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A0D4A9E077CE24285DFAB0FE3885A24@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6186.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d6a1cb-f10f-4f4e-dd8c-08dadf119446
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 02:59:42.1144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njQDII/s3rT0vZLij9MbgM9lroC/E/I44lMZ/vhSVAfQvl+L/g0gBl126RnaJxAUj4RS+g8zvJQSQ42sGdyc4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6694
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEyLTE1IGF0IDEwOjQ1ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTUvMTIvMjIgMTA6MzAsIElydWkgV2FuZyBoYSBzY3JpdHRvOg0K
PiA+IEZyb206IGt5cmllIHd1IDxreXJpZS53dUBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gc29t
ZSBjaGlwcyBoYXZlIG11bHRpLWh3LCBidXQgb3RoZXJzIGhhdmUgb25seSBvbmUsDQo+ID4gbW9k
aWZ5IHRoZSBjb25kaXRpb24gb2YgbXVsdGktaHcganVkZ2VtZW50DQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieToga3lyaWUgd3UgPGt5cmllLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBpcnVpIHdhbmcgPGlydWkud2FuZ0BtZWRpYXRlay5jb20+DQo+IA0KPiBBZ3JlZWQuIEJ1
dCB0aGlzIG5lZWRzIGEgRml4ZXMgdGFnLCBwbGVhc2UgYWRkIHRoZSByaWdodCBvbmUuDQo+IA0K
PiBSZWdhcmRzLA0KPiBBbmdlbG8NCg0KSGVsbG8gQW5nZWxvLA0KDQpUaGFua3MgZm9yIHlvdXIg
a2luZCByZXBseSwgSSB3b3VsZCBhZGQgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KUmVnYXJk
cywNCkt5cmllLg0KPiANCj4gDQo=
