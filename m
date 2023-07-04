Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2360C746946
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjGDF6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGDF6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:58:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF829E52;
        Mon,  3 Jul 2023 22:58:09 -0700 (PDT)
X-UUID: bc5d0e801a2f11ee9cb5633481061a41-20230704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jDy4CIJ5hybF6LV/OTCGUvWX/Cw4CtLVdZswcpzlhI4=;
        b=Z0J7mWIUjMLRcWXd6fOwoLM+rrZFRz74eOhO6t/xSEyaHgJrFwsyCBSS+/roI/3zkKUqfNM2EkxYeqCrnq925RvnUlPZAEwa42Be3XU3mQp5q2+CQ+yppyz4faAxP475P4EotE75yAOYgO8SMfQ87jTFFtaIeKadagAA0LtZjDU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:844cbb35-7014-4a2b-85c8-1e1cb53d3694,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.27,REQID:844cbb35-7014-4a2b-85c8-1e1cb53d3694,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:01c9525,CLOUDID:66b498da-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:230704135805F3N2L8XL,BulkQuantity:1,Recheck:0,SF:38|29|28|17|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULS
X-UUID: bc5d0e801a2f11ee9cb5633481061a41-20230704
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 662042285; Tue, 04 Jul 2023 13:58:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Jul 2023 13:58:01 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 4 Jul 2023 13:58:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3ABvo0gsHiDkCiFrnWx5KnpR5x+ulXhNWEpkzr6CpTsPohuKR1LCvTeEYxoclRrimZAzesbxyLbZpR9D8kVyg6FHiCd4Qw/ENbP/xijHDjkKC8Xb3DK0GExcO8ikcm0rDJwGwmPn/f9SHYnwHwdvv6iYst5BQBk/jaWbVr8GJ6lCyOPmzDmHYjz5xSzl+J/89/6808m/MjKxFxSoSgL7vSj/4DlNt/D4zHwXF/PlnKsNt1EGU028EW4gAqr+7Bl68o9/eaS1bxXtFFKwrELnQQt58iT2GQzHTiqInni+eGq8e9hZ9k7xwW3zRubu1iTibnMKj0qUrZ2I75WqTjveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDy4CIJ5hybF6LV/OTCGUvWX/Cw4CtLVdZswcpzlhI4=;
 b=WhN2MNsAdt4HGXvQSzyMq9U2a8yRheOPYOJKJ2SPjtZAZg/4s5LHeCiC8xmsfp5IVmVQF1rj1ZnGEMor9FET7KXzwp+RnhQieJeebG94MimMjkvn16w1Z17pxbr1SyQwJbiIv4rYw8b35AItLh7YVGR2wAfxKEWPhtW6qAJFVM6gjYFoCQ9m/I2x6BdlLlokBNIqdUChWYsPJ2kAQe0ujPgGmEfoM9nTDqyXkfNykeuyRwuss48lGyFmqOa0UGE3z/gV4YDTzkoyTiFC0bBDtCV/UJZb2hpA1/w7Eam1g/ChQay7405VJADyqyq2QliQaS3mUWswFOQ84axMg7oYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDy4CIJ5hybF6LV/OTCGUvWX/Cw4CtLVdZswcpzlhI4=;
 b=hjxy1C/EDiPssYqkrYluToikfyTh54fGVGCX4lI2+bJKS5h2+FjtFA72FHqRlkEMk3qz0tmzTe4CqVeSVM1DmCrqZOmQ/w9rl6Yg/YWCgw73J2dKUm7I11GTG3OWy9fFnisUSzDr0Uqsi9UHZmKgBbg9EEiNS9WNICTyFmOkUCg=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by TYUPR03MB7180.apcprd03.prod.outlook.com (2603:1096:400:355::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 05:57:58 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::1657:85e0:8243:3acf]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::1657:85e0:8243:3acf%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 05:57:58 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "ribalda@chromium.org" <ribalda@chromium.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] usb: xhci-mtk: set the dma max_seg_size
Thread-Topic: [PATCH] usb: xhci-mtk: set the dma max_seg_size
Thread-Index: AQHZqgOylhGANDFf/0qaMR6laapm4K+iFj4AgAAFFACAAA3MgIABDg0AgAXtw4A=
Date:   Tue, 4 Jul 2023 05:57:58 +0000
Message-ID: <516070d1504e6ff5ef6a81db75851bf86296e47d.camel@mediatek.com>
References: <20230628-mtk-usb-v1-1-3c5b2ea3d6b9@chromium.org>
         <0efd9388-4cbc-d27c-f82f-d14291580150@arm.com>
         <CANiDSCvvtdtS2E1a5qyOERG=DKzcTX2oLGWSecRz2gCi-Oo1tw@mail.gmail.com>
         <c412681d-c845-c8a9-01ed-aafb14a0381a@arm.com>
         <11d23da6-af10-7533-cf6c-98f6b836100f@linux.intel.com>
In-Reply-To: <11d23da6-af10-7533-cf6c-98f6b836100f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|TYUPR03MB7180:EE_
x-ms-office365-filtering-correlation-id: 96b2c3fe-ad50-4d35-6e71-08db7c539e39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cUZ67LEeyXaDj99zsfCory8HsMN2ol8ItPe6PoRZP7G9lb38GfR94Xjl/cbTIEVIpdk+SLLZPJS3kH168L48ktvKMCr1ZARQgEL9sIn8/X9sAld7LuDXVssLPgS8/0ajcHAjjhhN9rnHUMp88RHp4+3zqlICWTi1u9WnUYkBcyZbd/fRXhhO/K5sR8a5NyA3/7q1jrzF/Pva49PniVuVKgcwACtLQvyTMAzpqqBRwV/IY7gqf26mA4fmI7S6B4TDLm0UqhOT4Y9hjzqan2S16i364i+P+Z416fZEsZE/+GIueHoSJldqoN3WDmXqgf7RC0/5VFp15HYXT53/DEmFsYJxFmCkOpNe7FnRZRrolB6VYB9Ls/6KxEy44i9NGrLIEbtkuh6xDDrLuuVtxHG9slVL1yDnRiNeU7alp+GhRe5EGzOJboIEreZOd3/GQ2GAlPeEeL/x8bSqRB76Oj7I3jX1Ijbx/GCwY7kTFeOYmedF6IHQztGenlK+C7HzSCnSSJo7XO5SYrYthbOE9Paq9wKHYIZAmoyvSc8ud9xFLTJcO6DS2WJ9HpOQqs++AMgOvf+ONxUMKwFiYFwsmD3fLRhd4OOs97i2aY/M8f6nfHsUIM+Z/M1mvrFBbMQ5CJCLAGEki4HSbPyBgH4e93ZaBAe/tz5Y/x2VeIVTIXYvfrcE5qx36AJyfLaHXtu5jPrC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(66476007)(66946007)(316002)(66556008)(76116006)(38070700005)(66446008)(64756008)(91956017)(38100700002)(122000001)(4326008)(6512007)(26005)(186003)(53546011)(6506007)(6486002)(71200400001)(478600001)(966005)(110136005)(54906003)(2616005)(83380400001)(8936002)(7416002)(2906002)(5660300002)(85182001)(36756003)(86362001)(8676002)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE85cENRR09xZkFzWGY4bHQ2OUlvZFAwNjluZ2ovTHoxSjVMT0dETS95M1I1?=
 =?utf-8?B?L24yZzk2STkyMk5qejkrazZ0VFVCaWxESmVyKzFUM2ZaZHBxdVpUZzZOZlBB?=
 =?utf-8?B?U3NZdmR3RnRBN2lhOHVVT3Z5QnlUUGhyUWVqYWJDNnlsOWhIZHM1ZUVVN1RT?=
 =?utf-8?B?bUVVdStKd3ZmWHBpYlpTQVp5eFIwbHJkbTRvcko3d3NZYzh2YkhUcXlhcmNY?=
 =?utf-8?B?ZktyR0dOb3lNMmhDVTV5TDR6TjhnTktzUGRJZWpycGhpbHNWalFqVFM2S1Q0?=
 =?utf-8?B?ZzN2YVRDWWQrdDNoL0tHL3cwWStjNGhEbnRzU2JMbnM4a2VXRzU3c2hjMWFl?=
 =?utf-8?B?TlhlLzM4cnJvVVZYVlNyQ0hpenI0RGc3d0pESlZiRUtBT3AyQ3BnM2RuTzFu?=
 =?utf-8?B?M2crZXBwaHJCUGRRdFgxSUN6TDh5WlRwaTBhQ1Z3dk9zeW9pQ0c4TmVFbElM?=
 =?utf-8?B?RFp1Tk9saFpSSDN5dkd0SUd1aUJmZW9XVldmMWkvTlI5UU5nTmZ6SmVxakxV?=
 =?utf-8?B?cmlSMy8vQmRVbUsxM2QrUkR0aTJxRHBvc2VXTVBwNWhBUWlYNkEzdmZldzJ3?=
 =?utf-8?B?Mjh3U2hhQnJOOGUwb0g2L3BJcDFVZlliQUhjK0JVc3dyTVBGOWJzT3BkNFZo?=
 =?utf-8?B?ejBKdVZEYlhVMW52RkFRb1RiQldvUHc1S0tqVjVPcE9VL2dDV0tLTE96Um16?=
 =?utf-8?B?d0doaUV4RUM1S3JjSkgwME9Fcm9TbXJEWkZMSmtYelB0MTBRem9UWldOdStt?=
 =?utf-8?B?dHZNdkd4VWdBbXo4MU41V1RYbmtUNzhJOVd3VHdXeTRaYzc3dE1LRnVvaGlm?=
 =?utf-8?B?L0RPVnI0cjN6czhheU1hMDQ4dnRNVHh0V25ia1dDdWQ5a2txM2xWUDRZMnFa?=
 =?utf-8?B?ZVpyM2tBdFU1NW4wRkNnWWRiNW1KenRieXlwR2tkdGFSOFY0L1hjcENwWlh0?=
 =?utf-8?B?cURPQVNCMzVYQVJCdmVkS3ZONHVBZGNveTNFUWQrbXBYYWs3ZERuVktiWUV2?=
 =?utf-8?B?dHdobFZBUDNIMGN0d0RpZmJrajRwQmdZNENiTzd0dXVMRURzcVNqWHN5em5I?=
 =?utf-8?B?ZFU5RHdYZFFvYmtmaDFhWUNPellMK3poSWRYeGgrRjFBeENwaFFteXNBOXl3?=
 =?utf-8?B?TEl2L3pXSkFkRXBZMmd2RnFDd0JRY25EUE51aW1LMTlkOFhNMjNoeXE3ZUlq?=
 =?utf-8?B?SElsNkRqdUtYVmt3c0MzQzNrcFdnaHU3a1BJNmtiRVpJMDJPcnVTQ3V3d0h4?=
 =?utf-8?B?S0U2UUJZOGo1SmVIaURvU0p1VjRvUmg1Um5HT3dBV25iMnhhbUIyV0NuOE9h?=
 =?utf-8?B?T0p3c2czRDdzUWlCR3hwaXZDL1lWQ09LOUw2cVlvZTZKVkR3V1NQaDNpdHVu?=
 =?utf-8?B?N0k2VnNqazdBZEVVQU9FajUrczlaZ21ZVnhnSmU3NXo2MDh6K25JWGhOQ1k1?=
 =?utf-8?B?VlZ4d2tZNFg2bG05a1V2NGRGK21HOGNNWnhkTjhFMnJDSDR4Qm1tZWh2OFpQ?=
 =?utf-8?B?eUtJaW80Qms5aDRYMkNJVHR2NzlJb1NEMitaL2J0YXViUCs0RkgvQWxqcXVV?=
 =?utf-8?B?S0pka0cwRW0xRnFTQ1liUjlHc3luVW1ZMkE2RW1sNllpeGsxUkU4eDNva0Fx?=
 =?utf-8?B?aHZZZjVxMFZwdHBraUNRSHk2NE0zRk5KSnRsK2dVVmx0bTdOK0N6K2tVNFBs?=
 =?utf-8?B?eHgrOFI1bEsxZndDcVFlTytNUjVkK3dLSGsxVHIxb21GL2pRUng0UjRDbEp6?=
 =?utf-8?B?ZzNuSHhIb1ZIV2FKM0tKcmdzSFM1L0ZnSFVlRVNrKzI3N2ZCNFo4YkdYOW04?=
 =?utf-8?B?THBMdDEzS3VPaHh2TzlUdUk5WjVxSTRIYURPTDR2YzRFWG5FK25YNXVnbWlZ?=
 =?utf-8?B?aWxHbHlXQ3RKS004d2VvaFBWR09hZE1OZmhJNWRlYjFFRGhWOHhhM044aTdV?=
 =?utf-8?B?R3AyOHNTWHZtc2ZaM2FlM1gzdnJnZG5pczBZOWl2ZUlSeng5ZWFabURYdWx5?=
 =?utf-8?B?Uk9WRTVSRmpYRWU4S3ZiQ2JIRnhRVytSc1Y1ZlpTM1JqbFVlbnNpQ05aMHNC?=
 =?utf-8?B?dmtnTWpJbC9vVTJNOTc5T092ZWhNMzFCNlJMVGtTQXh3dENjYzdNYmU4UW1r?=
 =?utf-8?B?ci9CbE12ajVsZjV4ZDJqUHU3bDRMVFhHRzd5eVlrZktoUUxoekRURDJZS0xL?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC75848DBB7D3C47980A6D58B9B0A711@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b2c3fe-ad50-4d35-6e71-08db7c539e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 05:57:58.1682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Toe4RDDViodJyR45acYQYNk0asUonyZq9mIi5/WYMjqgV9RuT427GEGVH/dGBRhE1Ezck+BXfU+aNenmdCfaOwEwMkh43KDgC2ImPmt9GCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7180
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTMwIGF0IDE0OjI1ICswMzAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIE9uIDI5LjYuMjAyMyAyMi4xOSwgUm9iaW4gTXVycGh5IHdyb3RlOg0K
PiA+IE9uIDIwMjMtMDYtMjkgMTk6MjksIFJpY2FyZG8gUmliYWxkYSB3cm90ZToNCj4gPj4gSGkg
Um9iaW4NCj4gPj4NCj4gPj4gT24gVGh1LCAyOSBKdW4gMjAyMyBhdCAyMDoxMSwgUm9iaW4gTXVy
cGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4gT24gMjAy
My0wNi0yOCAyMjowMCwgUmljYXJkbyBSaWJhbGRhIHdyb3RlOg0KPiA+Pj4+IEFsbG93IGRldmlj
ZXMgdG8gaGF2ZSBkbWEgb3BlcmF0aW9ucyBiZXlvbmQgNjRLLCBhbmQgYXZvaWQNCj4gd2Fybmlu
Z3Mgc3VjaA0KPiA+Pj4+IGFzOg0KPiA+Pj4NCj4gPj4+IEhhbmcgb24sIGlzIHRoaXMgYWN0dWFs
bHkgY29ycmVjdD8gSSBqdXN0IGhhZCBhIHZhZ3VlIG1lbW9yeSBvZg0KPiBYSENJDQo+ID4+PiBo
YXZpbmcgc29tZSByZXN0cmljdGlvbnMsIGFuZCBzdXJlIGVub3VnaCBhY2NvcmRpbmcgdG8gdGhl
IHNwZWMNCj4gaXQNCj4gPj4+ICpkb2VzKiByZXF1aXJlIGJ1ZmZlcnMgdG8gYmUgc3BsaXQgYXQg
NjRLQiBib3VuZGFyaWVzLCBzaW5jZQ0KPiB0aGF0J3MgdGhlDQo+ID4+PiBtYXhpbXVtIGxlbmd0
aCBhIHNpbmdsZSBUUkIgY2FuIGVuY29kZSAtIHRoYXQncyBleGFjdGx5IHRoZSBraW5kDQo+IG9m
DQo+ID4+PiBjb25zdHJhaW50IHRoYXQgdGhlIG1heF9zZWdfc2l6ZSBhYnN0cmFjdGlvbiBpcyBp
bnRlbmRlZCB0bw0KPiByZXByZXNlbnQsDQo+ID4+PiBzbyBpdCBzZWVtcyBhIGJpdCBvZGQgdG8g
YmUgZXhwbGljaXRseSBjbGFpbWluZyBhIHZlcnkgZGlmZmVyZW50DQo+IHZhbHVlLg0KPiA+Pj4N
Cj4gPj4+IFRoYW5rcywNCj4gPj4+IFJvYmluLg0KPiA+Pg0KPiA+PiBJIHRoaW5rIHdlIGhhZCBh
IHNpbWlsYXIgZGlzY3Vzc2lvbiBmb3IgIDkzOTE1YTQxNzBlOSAoInhoY2ktcGNpOg0KPiBzZXQN
Cj4gPj4gdGhlIGRtYSBtYXhfc2VnX3NpemUiKQ0KPiA+PiBvbg0KPiA+PiANCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzFmZThmOGE3LWM4OGYtMGM5MS1lNzRmLTRkM2YyZjg4NWM4OUBs
aW51eC5pbnRlbC5jb20vDQo+ID4+DQo+ID4+IGBgYA0KPiA+PiBQcmVmZXJyZWQgbWF4IHNlZ21l
bnQgc2l6ZSBvZiBzZyBsaXN0IHdvdWxkIGJlIDY0ayBhcyB4SEMgaGFyZHdhcmUNCj4gaGFzDQo+
ID4+IDY0ayBUUkIgcGF5bG9hZCBzaXplDQo+ID4+IGxpbWl0LCBidXQgeGhjaSBkcml2ZXIgd2ls
bCB0YWtlIGNhcmUgb2YgbGFyZ2VyIHNlZ21lbnRzLA0KPiBzcGxpdHRpbmcNCj4gPj4gdGhlbSBp
bnRvIDY0ayBjaHVua3MuDQo+ID4+IGBgYA0KPiA+IA0KPiA+IE9LLCBidXQgaXQgc3RpbGwgc2Vl
bXMgb2ZmIHRvIG1lIHRvIGNsYWltIHRvIHN1cHBvcnQgc29tZXRoaW5nIHRoYXQNCj4gdGhlIGhh
cmR3YXJlIGRvZXNuJ3Qgc3VwcG9ydCwgYW5kIHRoZSBkcml2ZXIgaGFzIHRvIGZha2UsIGVzcGVj
aWFsbHkNCj4gd2hlbiBpdCdzIG9ubHkgdG8gcGFwZXIgb3ZlciBhIHdhcm5pbmcgd2hpY2ggaXNu
J3QgZXZlbiB0aGUgZHJpdmVyJ3MNCj4gZmF1bHQgaW4gdGhlIGZpcnN0IHBsYWNlLg0KPiANCj4g
eEhDIEhhcmR3YXJlIGhhcyBvZGQgYWxpZ25tZW50cyBhbmQgc2l6ZSByZXN0cmljdGlvbnMgdGhh
dCB0aGUgZHJpdmVyDQo+IGFueXdheSBuZWVkIHRvIHNvcnQgb3V0Lg0KPiBUaGUgNjRLIGlzIGFs
cmVhZHkgZmFrZSwgaXQncyB0aGUgbW9zdCBjb21tb24gbWF4IHN1cHBvcnRlZCBzaXplIGZvcg0K
PiBUUkJzLCBidXQgbm90IGFsd2F5cyB0cnVlLg0KPiBWYXJpZXMgZGVwZW5kaW5nIG9uIFRSQiBs
b2NhdGlvbiBpbiBUUkIgcmluZy4NCj4gDQo+IHhoY2kgZHJpdmVyIGNhbiBoYW5kbGUgYW55IHNp
emUuDQo+IA0KPiA+IA0KPiA+IFRoZSBhaW0gb2YgdGhlIERNQV9BUElfREVCVUdfU0cgd2Fybmlu
Z3Mgd2Fzbid0IHRvIGdvIHJvdW5kIGJsaW5kbHkNCj4gYWRkaW5nIGRtYV9zZXRfbWF4X3NlZ19z
aXplKFVJTlRfTUFYKSBhbGwgb3ZlciB0aGUgcGxhY2UsIGl0IHdhcw0KPiBhbHdheXMgdG8gY29u
c2lkZXIgd2hldGhlciB0aGUgZG1hX21hcF9zZygpIGNhbGwgYW5kL29yIHRoZQ0KPiBzY2F0dGVy
bGlzdCBpdHNlbGYgYXJlIHJpZ2h0LCBqdXN0IGFzIG11Y2ggYXMgd2hldGhlciB0aGUgZHJpdmVy
IG1heQ0KPiBoYXZlIGZvcmdvdHRlbiB0byBzZXQgYW4gYXBwcm9wcmlhdGUgcGFyYW1ldGVyLiBB
cyBJJ3ZlIGFscmVhZHkNCj4gcmFpc2VkLCBpbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSBJIHRoaW5r
IGl0J3MgYWN0dWFsbHkgdGhlIGRlYnVnIGNoZWNrDQo+IHRoYXQncyBtaXNwbGFjZWQsIHNpbmNl
IGl0J3Mgbm90IGRtYV9tYXBfc2coKSBhbnl3YXksIGJ1dCBhcyBpdA0KPiBzdGFuZHMsIHRoZSBp
bXBsZW1lbnRhdGlvbnMgb2YgZG1hX2FsbG9jX25vbmNvbnRpZ3VvdXMoKSBhcmUNCj4gZGVmaW5p
dGVseSBkb2luZyB0aGUgd3JvbmcgdGhpbmcgd2l0aCByZXNwZWN0IHRvIHdoYXQgaXQgaXMgdGhl
bg0KPiBhc2tpbmcgdG8gdmFsaWRhdGUuDQo+IA0KPiBBZ3JlZSB0aGF0IHRoaXMgc2VlbXMgdG8g
YmUgYW4gaXNzdWUgaW4gdGhlIERNQSBkZWJ1Z2dpbmcgc2lkZS4NCj4gV291bGQgaXQgbmVlZCB0
byB0YWtlIGludG8gYWNjb3VudCBjYXNlcyB3aGVyZSBkZXZpY2UgZHJpdmVyIGNhbg0KPiBzdXBw
b3J0IGRpZmZlcmVudCBzaXplcyB0aGFuIHRoZSBob3N0IGNvbnRyb2xsZXI/DQoNCnN0YXRpYyBp
bmxpbmUgdW5zaWduZWQgaW50IGRtYV9nZXRfbWF4X3NlZ19zaXplKHN0cnVjdCBkZXZpY2UgKmRl
dikNCnsNCiAgICBpZiAoZGV2LT5kbWFfcGFybXMgJiYgZGV2LT5kbWFfcGFybXMtPm1heF9zZWdt
ZW50X3NpemUpDQogICAgICAgIHJldHVybiBkZXYtPmRtYV9wYXJtcy0+bWF4X3NlZ21lbnRfc2l6
ZTsNCiAgICByZXR1cm4gU1pfNjRLOw0KfQ0KDQpCeSB0aGUgd2F5LCB3aHkgaXQgcmV0dXJucyBT
Wl82NEssIGJ1dCBub3QgVUlOVF9NQVg/DQoNCkkgZmluZCBtYW55IGRyaXZlcnMgc2V0IG1heF9z
ZWdtZW50X3NpemUgYXMgVUlOVF9NQVgsIHNlZW0gaXQncyBiZXR0ZXINCnRvIHJldHVybiBVTklU
X01BWCBieSBkZWZhdWx0LCBpZiB0aGVyZSBpcyBubyBsaW1pdGF0aW9uIGZvciBhIGRyaXZlci4N
Cg0KDQo+IA0KPiA+IA0KPiA+IFVubGVzcyB0aGVyZSBpcyBzb21lIGtub3duIHJlYXNvbiB0byBt
YWtlIHRoaXMgY2hhbmdlIHRvIGFueSBVU0INCj4gaG9zdCBjb250cm9sbGVyICpvdGhlciogdGhh
biB0aGF0IHNvbWVvbmUgc2VlcyBVVkMgYWxsb2NhdGUgYSA+NjRLQg0KPiBidWZmZXIgdmlhIHRo
aXMgcGF0aCBvbiBhIHN5c3RlbSB3aGljaCBoYXBwZW5zIHRvIGhhdmUgdGhhdA0KPiBwYXJ0aWN1
bGFyIEhDRCwgaXQgaXMgbm90IHRoZSByaWdodCBjaGFuZ2UgdG8gbWFrZS4NCj4gDQo+IFRoaXMg
d291bGQgYmUgYWxsIFVTQiAzLnggaG9zdHMsIGZyb20gYWxsIHZlbmRvcnMuDQo+IA0KPiBrZWVw
aW5nIHRoZSA2NEsgbWF4IHNlZyBzaXplLCBhbmQgZml4aW5nIHRoZSBkbWEgZGVidWcgc2lkZSB3
b3VsZCBiZQ0KPiBvcHRpbWFsLCBidXQgdW50aWwgdGhhdCBnZXRzIGRvbmUgSSB0aGluaw0KPiB3
ZSBjYW4gdGFrZSB0aGlzIG9uZWxpbmVyIGFzIGl0IHJlc29sdmVzIGEgcmVhbCB3b3JsZCBpc3N1
ZSB3aGVyZSBVU0INCj4gaXNuJ3Qgd29ya2luZy4NCj4gDQo+IFRoYW5rcw0KPiAtTWF0aGlhcw0K
PiANCg==
