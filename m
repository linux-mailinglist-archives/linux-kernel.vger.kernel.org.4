Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268DD747D79
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjGEGu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjGEGub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:50:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285D919AD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:49:48 -0700 (PDT)
X-UUID: 0ec197101b0011eeb20a276fd37b9834-20230705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+Jpf5vF2Gj4U+fJtaTUw52Uvn4GLSnj5gbBTfyYkgDE=;
        b=DOQcrlan+snjg9pn+FMdV/YZn2JC5/cUOpA3D/8USmIyPCssaUhmmgoG2zCnK0P/0w/ondHKP3H3ryWDfKaSE8EAUvfVMWpkOc3P19jSkKOSs1rfkZ4VFCbzrRHw5abEih+LXzRxYdi5p7ib7aXALPUxXMagLom/y1WDWT67XPU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:cac55958-ade7-40ea-968a-e9b120395d7c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:782de10d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0ec197101b0011eeb20a276fd37b9834-20230705
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 914498954; Wed, 05 Jul 2023 14:49:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 5 Jul 2023 14:49:14 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 5 Jul 2023 14:49:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb5DfiKwU/Tz9o+VqI8PGbzqyT62DcxjZT1bK4XYGl6C8iujIJzk14kMA4x2D7j41J7bWPQX3dA68n96dBgy4jKCG4QFnzZr7lEDU45GHNRpQafsZqKGLPEvzSKbtBqjb3dhSkf9a6gaB6tMnwRZejLhnobAIhDZKKeXXtECaSQBW6JvhIo6avs/xJWcy1UBmw2Wv2YXmSBgZWsDYlXxb9cjdAxIup8pqd6D29BekA2QFxn9rh6t1NBBv7HWzemOpFprIwAxpYsYyWNFf3k5NhniRAoPujNRvvuPi8fBdGi9ABcHjcjFST3aWV91hAvTKCpT6cuj+FTw8rA9FnLdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Jpf5vF2Gj4U+fJtaTUw52Uvn4GLSnj5gbBTfyYkgDE=;
 b=KyDAVZwSUUuICiIKCqcNPgUVTSGprcA7GXDcze/BWIJvrkWvsPBVztbBGSbXbxhjwexdgygciu1iteq2dcBvftbZGcwVYhJe26uzy4snJVBvlbmoThjmQ+cqutO0SXZyp2f/ajObFQ8tuKkbumvkQJi8mBPuzac0b7VMsNAAeYHG15Q9YsJQlPZp+Y4J8Djw7U3YtNyu44GmB5uV2xiJH3g4a1OpaFRGrnTyPCFiWLkBd4Fo4tNBQFODcekrA6Gv3jZlhyt268LgGWSlqEnXBs7XqtLQQ7mbUSwJvgn2awrsMoFkEjsrHZHeQeoLdNnrgy4qBAK48FDOdH4Gvt/PKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jpf5vF2Gj4U+fJtaTUw52Uvn4GLSnj5gbBTfyYkgDE=;
 b=by/wu6m7+iNT7VgfZjqkHZ7w1wtO26Fg67xlYxxfZ9gAChEXMVuVb1Vm887J61kT2x7pkM7hL8w/wt6BOrR4g4Fd5R8+nMITam5r+KVRaY+sLDqARoFijoW51/QCz+fqNcyV4Fth+2bH9hKXlrttcCV3wKeDCbpG3ss1CXHIF38=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB5993.apcprd03.prod.outlook.com (2603:1096:400:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:49:12 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::7e2e:5683:6b3a:6e0b]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::7e2e:5683:6b3a:6e0b%4]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 06:49:11 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH] iommu/mediatek: Remove a unnecessary checking for larbid
Thread-Topic: [PATCH] iommu/mediatek: Remove a unnecessary checking for larbid
Thread-Index: AQHZrm6aTzoAKMSoMEKIwQ+LMGyTrK+phr6AgAE2AIA=
Date:   Wed, 5 Jul 2023 06:49:11 +0000
Message-ID: <ca4a06b89442e56df652c4aeba3ad83473f4db58.camel@mediatek.com>
References: <20230704115634.7727-1-yong.wu@mediatek.com>
         <633be7a7-0bb8-1575-535e-2f96302198bd@collabora.com>
In-Reply-To: <633be7a7-0bb8-1575-535e-2f96302198bd@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB5993:EE_
x-ms-office365-filtering-correlation-id: 5162fb2c-8014-4fb6-432a-08db7d23f0a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AV/Esb3T8L/U5JbszBzEAA5DVBYXY2gHnp+vzM0FTtcK+EDNEQsJSjqX6HZdlKLyfJZXIEDAc9cdKgapFE7X6tXOo+W2EwQUWm0eBwXz68sZiIbOmPu3NLZXE0RrHymxMiGqZ2Sf/Lp8CzhH6GHKPOH/ptXzaKrGVr7o+Rja5nUq+S7KjgOdiSTjJAEq4/tZPbvRxvMvfE/5AvSASEHxb3Gzk0ylUE7sPpfZvI0aG5l8Rkiys0+e3c4aH2CZoKNd5NfMLn4cG1WAKzO4R+m25rBI8W2u8AzHQUwH7S1511uK7aZ2mQF8AaGB3wCsjoYQ3x0wou/KeIjY+zVN6nnb9DajYsierZJjI5H3Dz4VYzk5ldPf4p1xdKajJ/1rBt/La6SXnhsd0I82Hi9UvrNGWFMlZZJDekLXzwD/JorxM6ELWlxCpfvk31y+y5RxTGSWfe3uP5ZUAoo/prj1VMnoPTig9lfmOvM2IsX4IR3wLzmItf2XuFx3A3V9/IBDgI+vXNR8ClO9JGFtRqyY2UphtWKxOMMvGd6WKoZBG0SIX7fR2fxAi9nW8hTvK0+lhskw5fR7CVB54ulIYY81+XZKPNhd0o4HVYlZfBQS1MO4Njj5DrSFgYaGJfoKpSnIWaJyKu2DTLtwbpjhZov+2asG1i04Q+GLKf/V451cQsUmVXIikLPZ3hYPDl8tJSocaUPu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(64756008)(41300700001)(478600001)(6512007)(38070700005)(110136005)(54906003)(86362001)(38100700002)(71200400001)(122000001)(6486002)(66446008)(83380400001)(4326008)(85182001)(36756003)(316002)(66946007)(66556008)(66476007)(76116006)(2906002)(2616005)(6506007)(26005)(5660300002)(186003)(8936002)(8676002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0FhVmkxYVhLK2dNV1lwNDBZa2dBblp2cjNZMHNIeHNwZDFNcTJDU3RKK09C?=
 =?utf-8?B?NkFjY0wwUDFUSnA0YSs2cmpvNHFZVG0yNkM2eDFCTDN5ZFpBSncxMGJ0NjYw?=
 =?utf-8?B?T3dNSFAza0llWGZwTm1UWWRSSDBZcmZjaSs5ZVM2b0l3MEpuYzdaYTN5VFBD?=
 =?utf-8?B?K0JBVFlPc2hDd2gra2dwSUNnNlMwNXFjVjRPOTE0NWZXVElBck96RVRhMWRU?=
 =?utf-8?B?bmZRRk5OL1dmaTVaQXFmM2kwcTVRR09CSXprWnRmRnJLaW9haG1VcGdiRGZL?=
 =?utf-8?B?MkxnV0V1a0FrWDZxc3lSVnRWRkdpZkVySm0wbGtnQjRLcS80TEJyMndXL29i?=
 =?utf-8?B?WHZhWlhlK25raWw1NGFtVUNubndka282aloyOW9UK1J3TlZFcGFidzIvMFVk?=
 =?utf-8?B?M0ozSFc0MWM3Sm1HTnd1MnFWeEVtRWR0UGMrMzF2MllZYlNxV0c4UG1GMmhh?=
 =?utf-8?B?R2VPcHVZQjZPd0xHTmVnVUtRcVZIZy9tMFBseHJ1c3NaM01TMFZjR0gxZTBm?=
 =?utf-8?B?czN2WFhBRGJPcEdlbGhiYzE4bDdmaGdVeE51NE5HZmRUNHI3UEoyMytKc3d4?=
 =?utf-8?B?dHJ4bHZDSFJQd0ZrOHUzTHlJSCsvZTlYSUQ2TWxZQnFOVzlVUmZsUm90Q3Yz?=
 =?utf-8?B?SnE3cWNJeTh3MUh2ZlFJajcxbjBhd3VYcmRWZGVUeFVVQ0J3alBleHFnenNT?=
 =?utf-8?B?RnBTbGdBYjRXendaVlh6L3ppaUVTajJmOC9pSDRSMFdmWk4xK3IvOEFUcXBX?=
 =?utf-8?B?S0N1eWFJOGwzc1NBZlpCMUZpRWNYZXNsRFdmTDhSeEhZY3RtUXRkdEpFQlRm?=
 =?utf-8?B?QU14eVFqWUxpSWYxL0d5YlNtbkk5T001T0UrQnpFeGYrVDU3R1NWNVU2T3Aw?=
 =?utf-8?B?cEo1V1pRYmMvRmx1a0paMGZSanE1S20wZXRQckMwTEdPRzJVL3lQNm93R0Q1?=
 =?utf-8?B?eEJvT1pOV3lPVnZyQ3VGK3Z3SmZxRlIvTmJuS2tYOHBnUTlmZTFOTFI4K3hO?=
 =?utf-8?B?cDhrU3F0VElDc3BML044allHeDNSejh2VzVqR2FMbzJncTZ6cXJMWlczVGE0?=
 =?utf-8?B?MGh3ZjV6dW5CMklPK1J2WmRJalVPYmNCRDRsb1RkQ3VMWnNBMlhYcXlJaEJm?=
 =?utf-8?B?b2U2NjQrMWg0Q0NZTkF5WmR0eUlsMWdRdm43NkhKQUpUNmROM0ZVZEMxQmIx?=
 =?utf-8?B?TktQbUZnR3E0WDlvaWVRUjZiRTVjYWg3cGtYZ3VWU045NWpacFhsbmt0OVR6?=
 =?utf-8?B?V3NRZ1lXQ3VPaDY4K2UwKzBwS3pVSEI5TGdHekFTRGlWOXRQb2VQZTNlU2Zs?=
 =?utf-8?B?d3B2MGc2WktqR0c5N1VFZ1hiRzhheU5ydHFYUDFPWGRZVDNEUEI2b2o2ZDNS?=
 =?utf-8?B?RjVyZkpodEt5L0tuZktub3RsTkd1QjRiUk5qenQwNlBZUGZZL20wT2l3Ny9h?=
 =?utf-8?B?WVFWSVJPSWlKOTgyZ24vVTJaTEJ2RW53S3BXSE02MHZLdDcvLzB0TDE1NHo5?=
 =?utf-8?B?TjBnL1RhcTF6MVpYbVoxWnVSbFo1R0JLV1Y3YTZpUDhRNGFVRkltT29lZ2U4?=
 =?utf-8?B?Mm45SWViVU1jcU5TZWU2WWhBeFYrNDB4N3FHd2E4eE9LYnZjMnl6WDh0eVVv?=
 =?utf-8?B?MmRlM0pGSjlGUHF5ZlJKN0ZIR3FMWXRnSVNqNXdkSVcvK2l6aWZyODJWSEk0?=
 =?utf-8?B?SU03a2ljQ0J4c1VtejJKUGMwaXdLU3diYW1UNUtLY3pYMGUwUCtzYzlQakRB?=
 =?utf-8?B?VUpaZ3hhVklDbmlxMUZCbnBOUlR5UHpQM2EybUJ1dFgzbjhWbjQwb2dtY2Q3?=
 =?utf-8?B?WlNma1NCQmF5OGxQbVM4WHhmK05qek4yVCtLUnBycFpNME8wK0V5T1NvWHNr?=
 =?utf-8?B?dmp6NXEwV2MyNzRCTmNwM0tnSzBGZk54ZmhsWllNcitEMVd1Sjdma3Fvck9C?=
 =?utf-8?B?UWh2cWQ3Zmt2ZHUwVGN0dStXb1J2OHpOQjJNOGg2N3Zsb2xxV3JtcDd6TTZE?=
 =?utf-8?B?SWFWQjQ3T2wxLy9EYVQvbm1oSU9RbldHVTN4RTlGWVFUektXZDh0MitCZHJ5?=
 =?utf-8?B?V2NnK3Bpa2oyUVZNS3M4QjNwZDRaNURYM0tCZVNsNHhLRnI3aFVXbWJiblR3?=
 =?utf-8?Q?H/SOijQIp5C1MKnuYO9fOTh2Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EE1876EE3374C40AC88A3C4932678AF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5162fb2c-8014-4fb6-432a-08db7d23f0a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 06:49:11.7577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qld2NP2l69FMvXuleicOIL0qHx34lLr01NLxOrzY1IjRc+KOOifyS3dJWXfTYMmNP9Z3sKoGXJUYEkHKAIX1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5993
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTA0IGF0IDE0OjE5ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAwNC8wNy8yMyAxMzo1NiwgWW9uZyBXdSBo
YSBzY3JpdHRvOg0KPiA+IEZpeCBhIGNvdmVyaXR5IGlzc3VlOg0KPiA+IA0KPiA+Pj4gYXNzaWdu
bWVudDogQXNzaWduaW5nOiBsYXJiaWQgPSAoZndzcGVjLT5pZHNbMF0gPj4gNSkgJiAweDFmVS4N
Cj4gPiBsYXJiaWQgPSBNVEtfTTRVX1RPX0xBUkIoZndzcGVjLT5pZHNbMF0pOw0KPiA+Pj4gYmV0
d2VlbjogQXQgY29uZGl0aW9uIGxhcmJpZCA+PSAzMlUsIHRoZSB2YWx1ZSBvZiBsYXJiaWQgbXVz
dCBiZQ0KPiBiZXR3ZWVuDQo+ID4+PiAwIGFuZCAzMS4NCj4gPj4+IGRlYWRfZXJyb3JfY29uZGl0
aW9uOiBUaGUgY29uZGl0aW9uIGxhcmJpZCA+PSAzMlUgY2Fubm90IGJlIHRydWUuDQo+ID4gaWYg
KGxhcmJpZCA+PSBNVEtfTEFSQl9OUl9NQVgpDQo+ID4+PiBDSUQgMTEzMDY0NzAgKCMxIG9mIDEp
OiBMb2dpY2FsbHkgZGVhZCBjb2RlIChERUFEQ09ERSkNCj4gPj4+IGRlYWRfZXJyb3JfbGluZTog
RXhlY3V0aW9uIGNhbm5vdCByZWFjaCB0aGlzIHN0YXRlbWVudDoNCj4gPj4+IHJldHVybiBFUlJf
UFRSKC0yMkwpOw0KPiA+ICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiA+IA0K
PiA+IFRoZSBjaGVja2luZyAiaWYgKGxhcmJpZCA+PSBNVEtfTEFSQl9OUl9NQVgpIiBpcyB1bm5l
Y2Vzc2FyeS4NCj4gPiANCj4gDQo+IEkgYWdyZWUgd2l0aCB0aGUgY292ZXJpdHkgdG9vbCBpbiB0
aGF0IGFmdGVyIHRoZSB0cmFuc2Zvcm1hdGlvbg0KPiAoZ29pbmcgdGhyb3VnaA0KPiB0aGUgZGVm
aW5pdGlvbiBvZiBNVEtfTTRVX1RPX0xBUkIpIHRoZSBjaGVjayBpcyBwb2ludGxlc3MsIGJ1dCBJ
DQo+IHRoaW5rIHRoYXQgdGhlDQo+IHJpZ2h0IGZpeCBoZXJlIGlzIHRvIGNoZWNrIGZvciB2YWxp
ZGl0eSBvZiBmd3NwZWMtPmlkc1swXSBpbnN0ZWFkIG9mDQo+IHNpbXBseQ0KPiByZW1vdmluZyB2
YWxpZGF0aW9uLg0KPiANCj4gSGF2aW5nIG5vIHZhbGlkYXRpb24gYWZ0ZXIgbXRrX2lvbW11X3By
b2JlX2RldmljZSgpIGlzIGZpbmUsIGJ1dA0KPiB0aGF0J3MNCj4gYmVjYXVzZSB3ZSBhc3N1bWUg
dGhhdCAqdGhpcyogZnVuY3Rpb24gcGVyZm9ybXMgYWxsIHZhbGlkYXRpb24gc3RlcHMuDQoNClRo
ZXJlIGFscmVhZHkgaXMgdmFsaWRhdGlvbiBjb2RlIGF0IHRoZSBwb2ludCBsYXRlciBpbiB0aGlz
IGZ1bmN0aW9uLg0KDQoiaWYgKCFsYXJiZGV2KSByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsiIC8v
aWYgdGhlIGxhcmJpZCBpcyBpbnZhbGlkLg0KDQpUaGlzIHBhdGNoIGp1c3QgcmVtb3ZlcyBhIGRl
YWRjb2RlLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gUmViYXNlIG9u
IHY2LjQtcmMxLg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDMg
LS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMNCj4gPiBpbmRleCBhZWNjN2QxNTRmMjguLjY3Y2FhOTBiNDgxYiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYw0KPiA+IEBAIC04MzgsOSArODM4LDYgQEAgc3RhdGljIHN0cnVjdCBpb21tdV9k
ZXZpY2UNCj4gKm10a19pb21tdV9wcm9iZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+
ICAgICogQWxsIHRoZSBwb3J0cyBpbiBlYWNoIGEgZGV2aWNlIHNob3VsZCBiZSBpbiB0aGUgc2Ft
ZSBsYXJicy4NCj4gPiAgICAqLw0KPiA+ICAgbGFyYmlkID0gTVRLX000VV9UT19MQVJCKGZ3c3Bl
Yy0+aWRzWzBdKTsNCj4gPiAtaWYgKGxhcmJpZCA+PSBNVEtfTEFSQl9OUl9NQVgpDQo+ID4gLXJl
dHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiA+IC0NCj4gPiAgIGZvciAoaSA9IDE7IGkgPCBmd3Nw
ZWMtPm51bV9pZHM7IGkrKykgew0KPiA+ICAgbGFyYmlkeCA9IE1US19NNFVfVE9fTEFSQihmd3Nw
ZWMtPmlkc1tpXSk7DQo+ID4gICBpZiAobGFyYmlkICE9IGxhcmJpZHgpIHsNCj4gDQo+IA0K
