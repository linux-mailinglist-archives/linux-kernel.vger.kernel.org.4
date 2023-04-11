Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A602C6DD035
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDKDcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDKDc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:32:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2671724
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:32:22 -0700 (PDT)
X-UUID: 74f55190d81911eda9a90f0bb45854f4-20230411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZtWtLNHlT7mO73lwjcTiDNCYaVGKpwizFSrhhw3UJM0=;
        b=pR2446PeZmy4WTATaKFyOs/4tfmqqD7spIzJmLvsKruosPC57JeIOR3sVFWG0TueV2VnfvH8TrzBmPl+mOpJrfAQD1qqATthWPl02uPhoN/8intCLRc7GxFlSLI/Gc3xvoKfJG3aEOYKy2z45fNskSQS02WbQI9teocRnPCNYxg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:42db7a0d-68a7-4d5d-a760-002a4b78cd5b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:2d4fe7a0-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 74f55190d81911eda9a90f0bb45854f4-20230411
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1119130840; Tue, 11 Apr 2023 11:32:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Apr 2023 11:32:15 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 11 Apr 2023 11:32:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhC+ez9YpoxyyRrMHCp01JcSzG/3w0iCGpLKhfo4QCEUIY6c2DvXBXkQJ34LWPttoosO9ag307Ar8yuuDsIjEdz949YSbyDa+Bp4AC+WLZkUHBDkmM7T0CJiAf6PaXPe3HP2nNbuu3gB0vG1r/vZOC2jLxDcOZwRkf0uzM9o6ynnS+6fLgXBUZWqHk7JfZI3CtoiQ/Ue575uOOxvtRomNhmfbxQT052ik7FdhKGqrYLYFPEoDTsGlPaHOalTUvqbCHs5tRXU0Jo/VL6QiQKRbhNeYI5bYL4phIxExsT9DGoldEddBig/QRzMeFuczq0gfUCf7Nmk5H2Zi+rq6XG72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtWtLNHlT7mO73lwjcTiDNCYaVGKpwizFSrhhw3UJM0=;
 b=eZjO70CJb8OhUGCzwSfRZDpJN9vi4X1YLQRWQ0TjhmV5aie+BbRCI02y5afVnchxTEfrLjHEFNKCW0MKTwWAl3zPvVWQYta8nYZGln08Ceu+mZbA9rx4gDUCthb81SgezFjqflOsQOfRUdYC7/m9RCVtPDQEUe+8X9wTcsiGj7wn0cTVDmBLCmi7q/6kGpVz9hyRygD5K04UaEed5z58dxgDSNp+aEntxJ2bujBBhBXukGpBlL+3DJW2m8DZlglD5ojciD/VLY/mFOFUw/nKcHHCaQ9EzAhuoj1BuTQqDV5jarl9kpIvxc/qWbXcffYToUp6B1ho+IcQXkpF4JYqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtWtLNHlT7mO73lwjcTiDNCYaVGKpwizFSrhhw3UJM0=;
 b=BdWultVw7DdLBpdWjUAt5Dxfli7OXUw5gLHSjEzKff9FTUQZls6F+2YZXxQ7PohiwwO6j+D4SPux7JKIKoZsqIiGO33HsND1UrmZ/LqWMPYOw8+u3f+7kq3rNuFfPgiEFMnjPYfZVPUqeZRrd8NF5BDYQrHeqQQr2aY7lfFO1lI=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SI2PR03MB6112.apcprd03.prod.outlook.com (2603:1096:4:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 03:32:13 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 03:32:13 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "shraash@google.com" <shraash@google.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "julia.lawall@inria.fr" <julia.lawall@inria.fr>
Subject: Re: [PATCH] ASoC: mediatek: common: Fix refcount leak in
 parse_dai_link_info
Thread-Topic: [PATCH] ASoC: mediatek: common: Fix refcount leak in
 parse_dai_link_info
Thread-Index: AQHZbA1xqN3M8LrD3kK3fdGKol+LNq8ldE6A
Date:   Tue, 11 Apr 2023 03:32:13 +0000
Message-ID: <948eb609271ed2b735a480266480fd23c148d42f.camel@mediatek.com>
References: <20230411003431.4048700-1-shraash@google.com>
In-Reply-To: <20230411003431.4048700-1-shraash@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SI2PR03MB6112:EE_
x-ms-office365-filtering-correlation-id: 5b10157f-2c50-4318-db9a-08db3a3d5779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4LNFEDPaWi/Yaq18zlPew42xzndUmHNZYgxXKV8Gdawnm4vuTk2UkOnYehycTmv1NDO3bAshnrRjx4BQyB/R9pptZS64J8yh06owWJ5pj5x3PpSY3e64ZTST2Z+nV7eU8qvlDqgdKOGUqSBJyGCn8U9Q2IysnrwNZTzzZYqTFFRlAFbwfZ9RTSW8hlHGpXSWOV141DvkDjnrFvXJLpxtGCiKHqTKCULtLE3ld9Zgnhv+ZRb0FMq4D7q6YCdbgoBsfnx6UCXqNJ4BBlj4+MZMCh0prdL0xOioZvhnl602+0TOaYChMRDrulj7g2Jw7DM/uVDNVFtPKf+8oIAQ7bqGUfC5CZ1DWzNBEN3k+iNzho9RRRNybe/BNdNyOR2GUmQvP6o588Jo4lMBEQLW5Xxmd/KObYGyH53d1WT6p1c2TKa7XBu0/iQXxyLLE+oYYvuYr5jPWTBa0Va1+k5d12OOdq60IoRHwE9+raY4CGcGuVE3tEpXZbs2rK2PqZJOZw2gAn2CDzdfbFTlj581K4qII87MALykhdxtq9aa1N4XNSt0RvRlR+UbQBcwegIihygXDPmYkCYBIURitZASdDT5pqZH4PH+D0fcpGxIgjwNY8BqSkzCiqIajpMh650ldd0aIdHJMpCmFAm15QGVwYUV8kmQK4scOpqMsavUq02q9To=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(85182001)(36756003)(86362001)(91956017)(110136005)(316002)(41300700001)(76116006)(66946007)(4326008)(66476007)(66556008)(71200400001)(6486002)(478600001)(966005)(64756008)(66446008)(54906003)(5660300002)(8936002)(8676002)(2906002)(7416002)(38070700005)(38100700002)(122000001)(186003)(6512007)(6506007)(26005)(2616005)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXkxOVNEdUJtSEh1UDhMZXBCczdXSGU5SHlwcnVJeEV4ZWpUczkzTzdxQVJV?=
 =?utf-8?B?bGVRM3ZhNzA3Zy9zdngxNDZ2eW5iY1VrK0t5WVNyOUlNb2V3V0RwRHVvZDIr?=
 =?utf-8?B?cksxYlJiZ3FkVVozdDRLMUFmRWIxY3Z1c1FOY2NaOUZxMHlqNFQyekl4Nndi?=
 =?utf-8?B?clVueUlSVUpsNy9Xd3hVZFVmUTlxOGxmZzVXOGNRWVZEM2VQOU1uN2dUNlFM?=
 =?utf-8?B?M1dTa0NNb3RxQnhGMmZEUGRvTVVSR01QdHg1cUMvWUNldjUrdS9aZ1FhN2Ra?=
 =?utf-8?B?clZQL0RhSUNxakFCcTk0R2E0aHkvYld2empRNTdNNUV1dFc0cFhXWjF5dDRL?=
 =?utf-8?B?UGppUW1sZVpSbnV6ODBxOE1HYXo0NTg4ZUk3Nysrd29zYlp2NHNaaGREbXJz?=
 =?utf-8?B?b3kvNUZHQnRNTHdndnBKR1JzQW4yc1NWaWZ0Q0c0ZG1pT3prbkFVcVdRdlEx?=
 =?utf-8?B?RGMxMFowK2JhTjBSZ1JPeERkQWpoai8vZHdpd2U4MXJQMi8vOTRFYmNyMlFQ?=
 =?utf-8?B?eXMvUlRTdzcrc2VBRHdhbDNkYUM0Y1JobnRUaHRyc1Rrb0VRQS83OEI0eTdG?=
 =?utf-8?B?VnJ5djRSayttYit6Sng3N2lnWFI5dFZXZzcwUS9JRW0rVnRLcUlQbnFpSXh0?=
 =?utf-8?B?cW5IdnltZFBnbDBSYzlMSFVQQ2V2WXBvcTc1UHRBY0lNYjAyRUVJK0t6bXZ1?=
 =?utf-8?B?eVUxRGtTMjhJV0J5ZUJOTUg0MnhUcWhIZExyOFNNNHM0SFZxOGxHaGlMOVVv?=
 =?utf-8?B?NTNBZWFrRVdlN0IxazdUcW5kWGwzNkJDYXBRTEFmQWc2d2NzT3hFdWIxa0dH?=
 =?utf-8?B?d1RpN1paS2J4SDV0dmNNRXkyL2RkYUYyNVV6MEpWZFFHRnYyZWlOTGFISDdt?=
 =?utf-8?B?MnFoUkIreW5yYi9nUENHdWozaFBkTVlidWgwN3dkcHMySWNUZjNkYzZjYmJC?=
 =?utf-8?B?ZEhDOHZFaHp1S0p3TkVsaXNmd3gwdlR5QldiYTkyRFI4RkN1OHc5bHF0WlFR?=
 =?utf-8?B?aVpBNFd5TXY3LzZ6dUc3aERyM2Ntc2xYN29tSzBFWWo3UFUxL3F2a2ZLTWpG?=
 =?utf-8?B?MktKQjYvRVJiT2hydnNJemhONzVnVFF6R09oUTA5bnFDdC9WQUMzVCt3c3px?=
 =?utf-8?B?UjJIaS9kRHpZTVR6WVdrVzMzUmJ6TE50Rld5ckM3TE9ZQlluaXdQRllJUE1k?=
 =?utf-8?B?VWFKTWtXV2ttcHRvbmM0a0s0NThkMnlGUjF4VjlDRnZaaENNSnBKNFBSbjF4?=
 =?utf-8?B?VDQyd1BJU1BWcTlETWh1eXJqRG5lNW95ZHlKd0huUHVxb3V3d0FHaWExTkJD?=
 =?utf-8?B?WXJPU2pJS0VCZlp1S0RLNVM3cGdqY3dzdkRaK2V6Z1NqcHQ0RFJjVDBWUjJW?=
 =?utf-8?B?RFYyQlUyRk43eUZDWUszYVM5UFNLdXNVL3FqdVhlRVZZNWI1aEZQZEs5WVJF?=
 =?utf-8?B?a3FETEJDYmpNWldSMC9abWVrMm1UYm92YzNvWjBWR3RoVVUzendCbWwrWU5m?=
 =?utf-8?B?YUdmVTZPNXN0UXZoNlgwNlljNVFKWlhtSVBBcHlvTzR2MlQzdXNDbkhKWmNZ?=
 =?utf-8?B?KzZKTGdtM2c2MkVYd3lqb0RQM1FqOVhJZ290blVoVDNmcXBhVE5yZC9IaHMz?=
 =?utf-8?B?Y0FCYmhtN05lVkttNkNKVlQ5TGlaaWI0WVR3eDR5UlU5WE1BQkJrQjRnYWNX?=
 =?utf-8?B?cWhWTzFUZ21LY0VnQVVkTlhDYU1uV3VyNS9UMkVRRmFqT3hKbFNVMXk2YXl0?=
 =?utf-8?B?VVlLeWltK0ZIVDF4V0lEQU9wM3l4RGdOWUcrWFVxVWJPUUxXcGhBdXV5T1V6?=
 =?utf-8?B?T2R3K2lXaUE2UlpuK2dvOFBJdWNTSS95SVFIS0ZIc2VsZzN1VUdrNFc3bmlj?=
 =?utf-8?B?MkFIbTY4Vm1oQ0x5RFVqdE9Zd2hlRy8ySUliWnlZcnI2UXhIRE1TdjVnZzNE?=
 =?utf-8?B?T21MRXlZWmhOTTU0U2tqSGhyMHpPdzkyU0RuanZKb0JSL2hRaFB5WVllTlpj?=
 =?utf-8?B?dXRBMHAwNnBwWEEzdFI4VHJKcTRXUDlQbUhjUXo4MkcvTGNtbnR3TU1Wd3JW?=
 =?utf-8?B?QWV3K2tOejV6czM0OEJXV0l1YmFmUW45OHNGb2g4YUJGRVlpYlJyWENiZ05D?=
 =?utf-8?B?Q01LNE1Yc0xLdnhKNEVEVURBc000MTlsWm9lZWZuU0RGWFczSzRXNkVYTGJt?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4B23C8B28445E47A5943FCCCAC258B6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b10157f-2c50-4318-db9a-08db3a3d5779
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 03:32:13.7509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMliszaWpRXtvGQpnY0fTPnBBkLeN/cobnmkm7/hmzhMhf5T/J+q/NLZSJ372ekSKuZZxUbE4wNMr6zbW+Inbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6112
X-MTK:  N
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA0LTExIGF0IDA2OjA0ICswNTMwLCBBYXNoaXNoIFNoYXJtYSB3cm90ZToN
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29u
dGVudC4NCj4gDQo+IA0KPiBBZGQgbWlzc2luZyBvZl9ub2RlX3B1dCgpcyBiZWZvcmUgdGhlIHJl
dHVybnMgdG8gYmFsYW5jZQ0KPiBvZl9ub2RlX2dldCgpcyBhbmQgb2Zfbm9kZV9wdXQoKXMsIHdo
aWNoIG1heSBnZXQgdW5iYWxhbmNlZA0KPiBpbiBjYXNlIHRoZSBmb3IgbG9vcCAnZm9yX2VhY2hf
YXZhaWxhYmxlX2NoaWxkX29mX25vZGUnIHJldHVybnMNCj4gZWFybHkuDQo+IA0KPiBGaXhlczog
NDMwMjE4N2Q5NTVmICgiQVNvQzogbWVkaWF0ZWs6IGNvbW1vbjogYWRkIHNvdW5kY2FyZCBkcml2
ZXINCj4gY29tbW9uIGNvZGUiKQ0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxr
cEBpbnRlbC5jb20+DQo+IFJlcG9ydGVkLWJ5OiBKdWxpYSBMYXdhbGwgPGp1bGlhLmxhd2FsbEBp
bnJpYS5mcj4NCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMDQwOTA1MDQu
Mks4TDZzb2otbGtwQGludGVsLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTogQWFzaGlzaCBTaGFybWEg
PHNocmFhc2hAZ29vZ2xlLmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogVHJldm9yIFd1IDx0cmV2b3Iu
d3VAbWVkaWF0ZWsuY29tPg0KDQo+IC0tLQ0KPiAgc291bmQvc29jL21lZGlhdGVrL2NvbW1vbi9t
dGstc291bmRjYXJkLWRyaXZlci5jIHwgMTIgKysrKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Nv
dW5kL3NvYy9tZWRpYXRlay9jb21tb24vbXRrLXNvdW5kY2FyZC1kcml2ZXIuYw0KPiBiL3NvdW5k
L3NvYy9tZWRpYXRlay9jb21tb24vbXRrLXNvdW5kY2FyZC1kcml2ZXIuYw0KPiBpbmRleCA3YzU1
YzJjYjFmMjEuLjczODA5MzQ1MWNjYiAxMDA2NDQNCj4gLS0tIGEvc291bmQvc29jL21lZGlhdGVr
L2NvbW1vbi9tdGstc291bmRjYXJkLWRyaXZlci5jDQo+ICsrKyBiL3NvdW5kL3NvYy9tZWRpYXRl
ay9jb21tb24vbXRrLXNvdW5kY2FyZC1kcml2ZXIuYw0KPiBAQCAtNDcsMjAgKzQ3LDI2IEBAIGlu
dCBwYXJzZV9kYWlfbGlua19pbmZvKHN0cnVjdCBzbmRfc29jX2NhcmQNCj4gKmNhcmQpDQo+ICAg
ICAgICAgLyogTG9vcCBvdmVyIGFsbCB0aGUgZGFpIGxpbmsgc3ViIG5vZGVzICovDQo+ICAgICAg
ICAgZm9yX2VhY2hfYXZhaWxhYmxlX2NoaWxkX29mX25vZGUoZGV2LT5vZl9ub2RlLCBzdWJfbm9k
ZSkgew0KPiAgICAgICAgICAgICAgICAgaWYgKG9mX3Byb3BlcnR5X3JlYWRfc3RyaW5nKHN1Yl9u
b2RlLCAibGluay1uYW1lIiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmZGFpX2xpbmtfbmFtZSkpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJmRhaV9saW5rX25hbWUpKSB7DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIG9mX25vZGVfcHV0KHN1Yl9ub2RlKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ICsgICAgICAgICAgICAgICB9DQo+IA0KPiAgICAgICAgICAgICAgICAg
Zm9yX2VhY2hfY2FyZF9wcmVsaW5rcyhjYXJkLCBpLCBkYWlfbGluaykgew0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICBpZiAoIXN0cmNtcChkYWlfbGlua19uYW1lLCBkYWlfbGluay0+bmFtZSkp
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgICAg
ICAgICB9DQo+IA0KPiAtICAgICAgICAgICAgICAgaWYgKGkgPj0gY2FyZC0+bnVtX2xpbmtzKQ0K
PiArICAgICAgICAgICAgICAgaWYgKGkgPj0gY2FyZC0+bnVtX2xpbmtzKSB7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIG9mX25vZGVfcHV0KHN1Yl9ub2RlKTsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsgICAgICAgICAgICAgICB9DQo+IA0KPiAgICAg
ICAgICAgICAgICAgcmV0ID0gc2V0X2NhcmRfY29kZWNfaW5mbyhjYXJkLCBzdWJfbm9kZSwgZGFp
X2xpbmspOw0KPiAtICAgICAgICAgICAgICAgaWYgKHJldCA8IDApDQo+ICsgICAgICAgICAgICAg
ICBpZiAocmV0IDwgMCkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBvZl9ub2RlX3B1dChz
dWJfbm9kZSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAg
ICAgICAgICAgICB9DQo+ICAgICAgICAgfQ0KPiANCj4gICAgICAgICByZXR1cm4gMDsNCj4gLS0N
Cj4gMi40MC4wLjU3Ny5nYWMxZTQ0MzQyNC1nb29nDQo+IA0K
