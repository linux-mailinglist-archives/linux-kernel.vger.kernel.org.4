Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9818E6DF52C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjDLM1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjDLM0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:26:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83D32D73
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:26:32 -0700 (PDT)
X-UUID: 37abf7d4d92d11edb6b9f13eb10bd0fe-20230412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=aLldu3eXrrctrffw8/FQpX0H82PytsZbucCdTGzj8Wk=;
        b=AQIEaWXiXg3rLZGjR+FO+J4IgfRbIlZIEf1GMQLiinyA3bNS+7Ab+lJN/3EV8RFXMM+JwIXLPFkx3h+bkwRbuMb47LclwgVqmxNWiZdyVfO6pikxGVkXqMYrsd3jdvKX+4Z7BLEgnGZlCAAeuQWE7+3RohDwfyYUTSLoS9Jz/Ec=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:27839cdb-5093-4c60-8a01-60ddeeed30c4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:c62abbea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 37abf7d4d92d11edb6b9f13eb10bd0fe-20230412
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1858512667; Wed, 12 Apr 2023 20:26:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 12 Apr 2023 20:26:13 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 12 Apr 2023 20:26:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0c+RTZyaxnURAqjrFlvi8YssXuSCKJEA/QKPoAyrbyiynT5p5xCAzRJi1VG3eoJe5A+oh5TO0sDgvYQ5Oqa0qzEj//a54WPDSrEhYYb0vTwQIIRMnnlvWw8JJvQEoDO85tk0PdPB4ktcFKqHucrOFqzaVymn/wZfjNXFZXmXzydc1Seq+iMgKWxDsBBVFo8qOIqcPRpKysdAFeSsHBqHXNTm/R8wpAqXByK47XWM1khrb5rdjlHBDszLlHyYOzRTCBdDZ6FfaXrohJBHWvrHNdoFNr34T5BHVygAKzFpT5HhSFwPIplR5/lobHMOJKb+2+vGwV6/joykOhRNtmabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLldu3eXrrctrffw8/FQpX0H82PytsZbucCdTGzj8Wk=;
 b=MjDREHXMP9sjuKeKrbBMFQWYuHuxL1Bv7KiN9MGNncM1iV4iUonrfGcnCPWilhAGvIYzIcBLmr9xnuZoCkjqRw7Tvi1HmJtQHOH134cwMUkZmEBcllgokx2t9vNw0Et06skTCreEg0Yvpq9R/FRVWdBhzoZmWzJxWOBgA/d6MTL5JPaauuQXRcAcPtNd0CotDW05tfVzqkmwwhAQ3Phl7o66pUFmAU69gziYKzXqwINbMnwyLsZBa6sL6CDj28dPuwFN63O/3hxWCIFtzuuqGfH0MkE+Otn+XnPTJHmwFlOjmoVLbDXzqxAPKQO4svrkmNyn6Sau/1vqO64jCQSb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLldu3eXrrctrffw8/FQpX0H82PytsZbucCdTGzj8Wk=;
 b=FYHncb4ZwNju+iSccJ/4xwaGXuAriheQl6V6Q5qAKweVLp6zH6FKrQUWzFryRqkJWyMD+QZp2Exry8MexOrSlhkA6qkKKtyp6HrvGerIBavZUfSDTV/jEckwJ29YUe/+d9xdkEZy4qsA3c75uCq69zu0AN7Y8K3LFQbY0OL3nSY=
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com (2603:1096:803:3b::21)
 by TYZPR03MB5664.apcprd03.prod.outlook.com (2603:1096:400:70::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Wed, 12 Apr
 2023 12:26:12 +0000
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::1a06:cad2:c8e3:beec]) by PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::1a06:cad2:c8e3:beec%4]) with mapi id 15.20.6298.028; Wed, 12 Apr 2023
 12:26:11 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jonson.wang@mediatek.com" <jonson.wang@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH 1/2] drm/mediatek: Add ability to support dynamic
 connector selection
Thread-Topic: [PATCH 1/2] drm/mediatek: Add ability to support dynamic
 connector selection
Thread-Index: AQHZZ84lHJ6kj7yq20K7qh3z7+Vhka8ndSsAgAAvJQA=
Date:   Wed, 12 Apr 2023 12:26:11 +0000
Message-ID: <2e1341b234484a924e6b03fe0453c3ee29a100c3.camel@mediatek.com>
References: <20230405145129.18835-1-jason-jh.lin@mediatek.com>
         <20230405145129.18835-2-jason-jh.lin@mediatek.com>
         <f95ee9f4-71a3-2f92-ed9b-037e11b8e893@baylibre.com>
In-Reply-To: <f95ee9f4-71a3-2f92-ed9b-037e11b8e893@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU1PR03MB3062:EE_|TYZPR03MB5664:EE_
x-ms-office365-filtering-correlation-id: 6d5f11f0-8edb-48d8-bdb7-08db3b5119b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d8JvlKo+8UDgd2FX9+i3yceKG76Ml4QPzyhnG2BYAmnyVjXs+YXnmSSWOxd2OTCYakt0KUr7Pf+hwlVylm0yTfJmrT1mxYYpXRMN9u7LTNw2lkq1r4ye2wTbWqFmPF/Y+ExAF3omIcqAa0Kz/8I/sikGiBsfRRyILZMpPg/Vn4Ruc0geMqCUoAqv0xXE87FOHq65of9B2BIYftEOp4zV4mpUOJzHJAK122qdPVeuaUTBnJwrAIKCBmTzpbIZ4hbzEY+M/eb0S71E+GNf4gP+XlJDQBFPnTgaoAeMQ9heUsZU0iQ2HZmfD9pO+fhFSoPvhsP1YL+toXEyuZctApZiwWGiasUGEmTvfi+QJMEkKFaJ3eG04wrEdugOczlkk/4/f3mmVAbSiIp5IVSo4eNcU/leC7jpATp4dc9SwHDzo18o7kOkguBv+uhmXTpJO9uGVKKwu2+OAMmX98erCtCxJ2h86TdEqL9oYFojABd7MeAYOTlcuMsE0/Yp0ld4LECFPUsbxKO276WrBMTY6u60FOA0GHLExCezKJuVhonPOMCGZFQ3Kez1Mk2ishE9h8h3efzJ8N4YUHoCiZiCZ6pNyWyse7KoREhOiWeLwKmrTlc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU1PR03MB3062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(66446008)(4326008)(6486002)(966005)(110136005)(316002)(54906003)(66556008)(91956017)(66946007)(76116006)(64756008)(66476007)(53546011)(478600001)(71200400001)(5660300002)(41300700001)(8936002)(8676002)(2906002)(38070700005)(122000001)(85182001)(86362001)(36756003)(2616005)(38100700002)(6506007)(186003)(83380400001)(26005)(6512007)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUZOdHlnaS9yZThNVE1Ga3psc0RuS2RjS3VTRlU1ZzZzUGN5Z0xiM0xndGJ5?=
 =?utf-8?B?ZEczUyt4N2cvbFdXZ3Jyem5aTXBEbm1jMUxjM1EvdHh1OXR2djlHVkNaOVh2?=
 =?utf-8?B?Nkg1WnIyQUp5K0d0ckZtUmN6QnBmU1VKa0VJaHVNOVdBZ081K1pMeG80MnYv?=
 =?utf-8?B?ekQvTlBCUHI5cXlvQXZ6cW9GdHFtYWlUUDNLZnNERDZ1ZDVKTFlBTU9KbEdB?=
 =?utf-8?B?OXFVbloyNXdXTk9pOEZ4d2dneWlrRjQrSEF1T2srWURaZ2NBZlFYZEFPd2Fn?=
 =?utf-8?B?Q1BwZTZ0clhMWDIrSVgwTHJXMm9UVThZRzdSbVp6cmg5NG80MmlROG1iS3Y4?=
 =?utf-8?B?UEdmc1lNNTB0VzN4UXh4cTlMODhxUnFsb2JTY0w4NEJPKys3TFBadTNNcVhI?=
 =?utf-8?B?R0RTRjVjQ0RiOEZVV3ptUzFzL2VjdXZxL1R3SUNBMFphTWw3UTAwRnB5bVl2?=
 =?utf-8?B?c1lGN2ZrZCtVM25HTjA4YThlTTI5MEVROTkzSXlQcFg1T2NOUjY0QjBaZjlZ?=
 =?utf-8?B?SWxLQlNtSitRSXZJRlhlUkdhMWU1RlVpek1ZaUxjTUwzTnBVbVhYNmpZUnQ3?=
 =?utf-8?B?Z1IwTXArdWtpMFVKaklTR0JFbmw0YlIwWXNYbHJvd3ZycStDcWk4ckJNUzJN?=
 =?utf-8?B?dVZCUlJ0NldSSlhkNUdYejk0Rm11WXppM24xU2ZJRTNPSzZGS3hZQmc0ZTdy?=
 =?utf-8?B?YzZncjg2TWVOR0hqQUZPZTJTRElET09JeHR6ekxIb0diNHA5QzRtWlVTQ3ZE?=
 =?utf-8?B?K2c1WVlGbVpacFVkUE1VTy9YeWg3OTBJQTdjWmFxdkdoYUZtT2habmFFQWkr?=
 =?utf-8?B?VXhzZ0pBVHN0UkU0SmxqUmZBTit6VWhNRXdJRWhLZ2tEZnc1TmZmQ3RHOXE2?=
 =?utf-8?B?Zyt3c3V1U0drM1dMZVZWTXl4RHltbk5OVDNWZ0RVdkx4Q3AyZEJuK1ozOVE3?=
 =?utf-8?B?VDlLazhIeWpuUmxEU3dOVDBJelVabGhsOVlYUTVkckg5NHU5R0IvdUZPdThq?=
 =?utf-8?B?K3BuTjJiakUwU1crcFRtOEFsYU4zV0dHN2VKd1UyTlRmNE5sUytXeG85SGEz?=
 =?utf-8?B?blFKOHFBYXYzT1RCc3ZoSVUreWFNYkk5QUdzMTl5TG1vTE1PNENnRWtyS2pZ?=
 =?utf-8?B?eFJWOVNRS0NOeXltMEp6Skhha0xxbkMvek1JalFlN2FlVTBSZ21FWDREQklC?=
 =?utf-8?B?ZmVoU1pCSXQ5K0p0Qm9pVUluUW8rbGxyZmsycWlFQUFsRjUvWFhITjRpT3Y2?=
 =?utf-8?B?QWo1dk4xUm12T25CdU9zM0tQMmxvemh4WVNDTWxqNENRRHdHcWFTR3NCcmtV?=
 =?utf-8?B?UXlWK2s2Skxvd2dlb3lveDZXYklPODJqUWJIa1N3dktLTnhnaVY2bCt4WEtF?=
 =?utf-8?B?UUE1YUtlUEQrNStpeTk4YXY5eWhNOHFZbXl6UTNuSW5DZWlwUXphWGVRR2Fs?=
 =?utf-8?B?dkZJb3loL3VjZUcrVTZiekJ6SmVSb1ZuMTEyMWZTU2s4Nmhha2xzOXd1Mit5?=
 =?utf-8?B?Q0VndHA3WXp2UE1xTWMxbElFTGNxdThnWXp4UlFnQkVSeTJIZExMbFY0dWlw?=
 =?utf-8?B?RmpHZUFIZEhMTU1Oc296UXUzeERaRjdTVGEyNUwvaHcxS21wVi9FL2NIWEZB?=
 =?utf-8?B?TmF2cXJrZjBXcmhZSWYvQkNKZFdneEhDSHFrcjZWTW13Smg4alg4ZDFFME5O?=
 =?utf-8?B?T3E4K3FUZGwzc2tZUmFBOGFoTmY0RWVMLysrb0Zsa290cHkvR0svLytFR05D?=
 =?utf-8?B?YkY0MTIrRTBRRWtkSVJ6ZmsvMW5kcVYxMWNWWlhYVGhBL2VNVlFwcnJ5UTFm?=
 =?utf-8?B?OGZDK0NaUitOUXhkczdCUERONDlJZ3RoZWhDb2ZJV0ZiamZHY2tqMFY3V1Yv?=
 =?utf-8?B?Zkl3d3dJZEVNZmwxcytNK2FNd2o3WVluZlVJbXlkTlNRbU5INVdmSGMyT3lK?=
 =?utf-8?B?YkFpWklzRWx2NTU1aFo4TGFtellGTGpzWXE4SEdYdXdYK29CaXBEUjlqRzhj?=
 =?utf-8?B?ek8rZ3Fic0F5UWlkSW5MYXBUUEtLQmFtUWFVNXVCYjFZaS9oOUthZkd6VzY2?=
 =?utf-8?B?Q2cvMENsZmhmQWhUdTdDcXlVd2U2YTlXTzgyVlY2UnFqVEZJR3IzTGFLYURq?=
 =?utf-8?B?OFNaTVIwbzNaUkt2ZFJ6N0xvcndFRDJ4M1BsVUtLUzRXZzYwNzR6Z0k0b3hk?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EA20D7FA753D3418F96363805F46913@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU1PR03MB3062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5f11f0-8edb-48d8-bdb7-08db3b5119b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 12:26:11.2485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2j2OOfdRp0tOEWFm55CFjvlh6sKcd9NuRQE6jYM4U5B+jbgLw6uUlFWPSGzAatlrzDl6uyWt0Yk1zPyWCaawLYb5NX/7o+KXvfgaVtbAOUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5664
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZHJlLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBXZWQsIDIwMjMt
MDQtMTIgYXQgMTE6MzcgKzAyMDAsIEFsZXhhbmRyZSBNZXJnbmF0IHdyb3RlOg0KPiBFeHRlcm5h
bCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAN
Cj4gDQo+IEhpIEphc29uLA0KPiANCj4gQ2FuIHlvdSBnaXZlIG1lIHRoZSBiYXNlZCBnaXQgdHJl
ZS9icmFuY2ggZm9yIHRoaXMgc2VyaWVzIHBsZWFzZSA/DQo+IEkgd2FudCB0byBkbyBhIG5vbi1y
ZWdyZXNzaW9uIHRlc3QgZm9yIG10ODM2NS1ldmsgYm9hcmQuDQo+IA0KU29ycnkgZm9yIG1pc3Np
bmcgdGhpcyBpbmZvcm1hdGlvbiwgSSdsbCBhZGQgdGhpcyBpbnRvIFtQQVRDSCAwLzJdIGF0DQpu
ZXh0IHZlcnNpb24uDQoNCkl0IGJhc2VkIG9uIG1lZGlhdGVrLWRybSBtYWludGFpbmVyJ3MgdHJl
ZSAvIG1lZGlhdGVrLWRybS1uZXh0IGJyYW5jaCA6DQoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NodW5rdWFuZy5odS9saW51eC5naXQvbG9nLz9oPW1l
ZGlhdGVrLWRybS1uZXh0DQoNCg0KPiBGZWVkYmFjayBiZWxvdzoNCj4gDQo+IE9uIDA1LzA0LzIw
MjMgMTY6NTEsIEphc29uLUpILkxpbiB3cm90ZToNCj4gPiAxLiBNb3ZlIG91dHB1dCBkcm0gY29u
bmVjdG9yIGZyb20gZWFjaCBkZHBfcGF0aCBhcnJheSB0byBjb25uZWN0b3INCj4gPiBhcnJheS4N
Cj4gPiAyLiBBZGQgZHluYW1pYyBzZWxlY3QgYXZhaWxhYmxlIGNvbm5lY3RvciBmbG93IGluIGNy
dGMgY3JlYXRlIGFuZA0KPiA+IGVuYWJsZS4NCj4gPiBzbmlwLi4uDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+IGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gaW5kZXggZDQwMTQyODQyZjg1Li41
ZmYyMGQwZGUyOWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fY3J0Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jDQo+ID4gQEAgLTYwLDggKzYwLDEzIEBAIHN0cnVjdCBtdGtfZHJtX2NydGMgew0KPiA+
ICAgICAgIHN0cnVjdCBkZXZpY2UgICAgICAgICAgICAgICAgICAgKm1tc3lzX2RldjsNCj4gPiAg
ICAgICBzdHJ1Y3QgZGV2aWNlICAgICAgICAgICAgICAgICAgICpkbWFfZGV2Ow0KPiA+ICAgICAg
IHN0cnVjdCBtdGtfbXV0ZXggICAgICAgICAgICAgICAgKm11dGV4Ow0KPiA+ICsNCj4gDQo+IFJl
bW92ZSB0aGlzIGV4dHJhIGxpbmUgcGxlYXNlLg0KPiANCk9LLCBJJ2xsIHJlbW92ZSBpdC4NCg0K
PiA+ICsgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgICAgZGRwX2NvbXBfbnJfb3Jp
Ow0KPiA+ICsgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgICAgbWF4X2RkcF9jb21w
X25yOw0KPiA+ICAgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgICAgZGRwX2NvbXBf
bnI7DQo+ID4gICAgICAgc3RydWN0IG10a19kZHBfY29tcCAgICAgICAgICAgICAqKmRkcF9jb21w
Ow0KPiA+ICsgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgICAgY29ubl9yb3V0ZV9u
cjsNCj4gPiArICAgICBjb25zdCBzdHJ1Y3QgbXRrX2RybV9yb3V0ZSAgICAgICpjb25uX3JvdXRl
czsNCj4gPiANCj4gPiAgICAgICAvKiBsb2NrIGZvciBkaXNwbGF5IGhhcmR3YXJlIGFjY2VzcyAq
Lw0KPiA+ICAgICAgIHN0cnVjdCBtdXRleCAgICAgICAgICAgICAgICAgICAgaHdfbG9jazsNCj4g
PiBAQCAtNjQ5LDYgKzY1NCw4NSBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NydGNfZGlzYWJsZV92
Ymxhbmsoc3RydWN0DQo+ID4gZHJtX2NydGMgKmNydGMpDQo+ID4gICAgICAgbXRrX2RkcF9jb21w
X2Rpc2FibGVfdmJsYW5rKGNvbXApOw0KPiA+ICAgfQ0KPiA+IA0KPiA+ICtzdGF0aWMgdW5zaWdu
ZWQgaW50IG10a19kcm1fY3J0Y19tYXhfbnVtX3JvdXRlX2NvbXAoc3RydWN0DQo+ID4gbXRrX2Ry
bV9jcnRjICptdGtfY3J0YykNCj4gPiArew0KPiA+ICsgICAgIHVuc2lnbmVkIGludCBtYXhfbnVt
ID0gMDsNCj4gPiArICAgICB1bnNpZ25lZCBpbnQgaTsNCj4gPiArDQo+ID4gKyAgICAgaWYgKCFt
dGtfY3J0Yy0+Y29ubl9yb3V0ZV9ucikNCj4gPiArICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+
ICsNCj4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPmNvbm5fcm91dGVfbnI7IGkr
KykNCj4gPiArICAgICAgICAgICAgIG1heF9udW0gPSAobWF4X251bSA+IG10a19jcnRjLQ0KPiA+
ID5jb25uX3JvdXRlc1tpXS5yb3V0ZV9sZW4pID8gbWF4X251bSA6DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbXRrX2NydGMtPmNvbm5fcm91dGVzW2ldLnJvdXRlX2xlbjsNCj4g
DQo+IGlmIHRlc3QgaXMgdHJ1ZSwgdGhlbiBkbyAibWF4X251bSA9IG1heF9udW0iDQo+IEknbSBu
b3Qgc3VyZSB0aGUgY29tcGlsZXIgd2lsbCBvcHRpbWl6ZSB0aGF0Lg0KPiBBbHNvLCBJIHRoaW5r
IGl0IG1vcmUgcmVhZGFibGUgbGlrZSB0aGF0Og0KPiANCj4gaWYgKG1heF9udW0gPCBtdGtfY3J0
Yy0+Y29ubl9yb3V0ZXNbaV0ucm91dGVfbGVuKSB7DQo+ICAgICAgICAgbWF4X251bSA9IG10a19j
cnRjLT5jb25uX3JvdXRlc1tpXS5yb3V0ZV9sZW47DQo+IH0NCj4gDQpPSywgSSdsbCByZWZpbmUg
dGhpcy4NCg0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gbWF4X251bTsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiArc3RhdGljIGludCBtdGtfZHJtX2NydGNfdXBkYXRlX291dHB1dChzdHJ1Y3QgZHJtX2Ny
dGMgKmNydGMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlKQ0KPiA+ICt7DQo+ID4gKyAgICAgaW50IGNydGNfaW5k
ZXggPSBkcm1fY3J0Y19pbmRleChjcnRjKTsNCj4gPiArICAgICBzdHJ1Y3QgZHJtX2NydGNfc3Rh
dGUgKmNydGNfc3RhdGUgPSBzdGF0ZS0NCj4gPiA+Y3J0Y3NbY3J0Y19pbmRleF0ubmV3X3N0YXRl
Ow0KPiA+ICsgICAgIHVuc2lnbmVkIGludCBlbmNvZGVyX21hc2sgPSBjcnRjX3N0YXRlLT5lbmNv
ZGVyX21hc2s7DQo+ID4gKyAgICAgc3RydWN0IG10a19kcm1fcHJpdmF0ZSAqcHJpdiA9IGNydGMt
PmRldi0+ZGV2X3ByaXZhdGU7DQo+ID4gKyAgICAgc3RydWN0IGRldmljZSAqZGV2Ow0KPiA+ICsg
ICAgIHN0cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjID0gdG9fbXRrX2NydGMoY3J0Yyk7DQo+
ID4gKyAgICAgY29uc3Qgc3RydWN0IG10a19kcm1fcm91dGUgKmNvbm5fcm91dGVzOw0KPiA+ICsg
ICAgIHVuc2lnbmVkIGludCByb3V0ZV9sZW4gPSAwLCByb3V0ZV9pbmRleCA9IDA7DQo+ID4gKyAg
ICAgdW5zaWduZWQgaW50IGNvbXBfaWQ7DQo+ID4gKyAgICAgaW50IGk7DQo+IA0KPiBDYW4geW91
IHB1dCB0aGVtIGluIGFscGhhYmV0aWNhbCBvcmRlciBwbGVhc2UgPw0KPiANCk9LLCBJJ2xsIHB1
dCB0aGVtIGluIGFscGhhYmV0aWNhbCBvcmRlci4NCg0KPiA+ICsNCj4gPiArICAgICBpZiAoIW10
a19jcnRjLT5jb25uX3JvdXRlX25yKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4g
Kw0KPiA+IHNuaXAuLi4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fY3J0Yy5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9j
cnRjLmgNCj4gPiBpbmRleCAzZTkwNDY5OTNkMDkuLjk2NzkwZjhmN2E5NCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmgNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmgNCj4gPiBAQCAtNyw2ICs3LDcg
QEANCj4gPiAgICNkZWZpbmUgTVRLX0RSTV9DUlRDX0gNCj4gPiANCj4gPiAgICNpbmNsdWRlIDxk
cm0vZHJtX2NydGMuaD4NCj4gPiArI2luY2x1ZGUgIm10a19kcm1fZHJ2LmgiDQo+IA0KPiBBbHBo
YWJldGljYWwgb3JkZXIgcGxlYXNlLg0KDQpPSywgSSdsbCBwdXQgdGhlbSBpbiBhbHBoYWJldGlj
YWwgb3JkZXIuDQoNCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KPiANCj4gPiAgICNpbmNsdWRl
ICJtdGtfZHJtX2RkcF9jb21wLmgiDQo+ID4gICAjaW5jbHVkZSAibXRrX2RybV9wbGFuZS5oIg0K
PiA+IA0KPiA+IEBAIC0xOCw3ICsxOSw5IEBAIHZvaWQgbXRrX2RybV9jcnRjX2NvbW1pdChzdHJ1
Y3QgZHJtX2NydGMgKmNydGMpOw0KPiA+ICAgaW50IG10a19kcm1fY3J0Y19jcmVhdGUoc3RydWN0
IGRybV9kZXZpY2UgKmRybV9kZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHVu
c2lnbmVkIGludCAqcGF0aCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50
IHBhdGhfbGVuLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBpbnQgcHJpdl9kYXRhX2luZGV4
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgaW50IHByaXZfZGF0YV9pbmRleCwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IG10a19kcm1fcm91dGUgKmNvbm5fcm91
dGVzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgY29ubl9yb3V0ZXNf
bnVtKTsNCj4gPiAgIGludCBtdGtfZHJtX2NydGNfcGxhbmVfY2hlY2soc3RydWN0IGRybV9jcnRj
ICpjcnRjLCBzdHJ1Y3QNCj4gPiBkcm1fcGxhbmUgKnBsYW5lLA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnN0YXRlKTsNCj4gPiAgIHZvaWQg
bXRrX2RybV9jcnRjX2FzeW5jX3VwZGF0ZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsIHN0cnVjdA0K
PiA+IGRybV9wbGFuZSAqcGxhbmUsDQo+IA0KPiANCj4gUmVnYXJkcywNCj4gQWxleGFuZHJlDQo+
IA0K
