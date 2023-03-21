Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132EC6C2ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCUGvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCUGvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:51:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967EF1A966;
        Mon, 20 Mar 2023 23:51:00 -0700 (PDT)
X-UUID: b9f35de8c7b411eda9a90f0bb45854f4-20230321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=W/tv/hlkLWVM4o8UX9l1XoOc09CK3MqtNYAvV2JgNnI=;
        b=u2ml8FDLTwfqvPc9klKXFH7iycUnrhCGw/O6cnFk94G1saMtcfqRTcX0SKO5YovitElD/NWGJjqrhyFJpFeM+6z4wHvCih2MdmVX8fLPGbOwCafQuBabZOO+dLnmOMxxJggZZS7O40zma7kAYXP+M2IP7N5Uwd5SrLr8VmUP8eo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:cfb05d4e-125f-4876-8a7b-ef78dfc4944b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:e40d6ef6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b9f35de8c7b411eda9a90f0bb45854f4-20230321
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1867399411; Tue, 21 Mar 2023 14:50:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 21 Mar 2023 14:50:53 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 21 Mar 2023 14:50:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEC3IjiWHoJ3fZ4v26WVEv6d8Gd4apCde2MfGGzHdibEoQY30P8wuT/pTs25Vbb09eHvH/rtwZAqTBVa0ADxfhtxkxkbsYrQQELHGAf5RgNPvzqx25YYDB5saDaVraUmse+SrL7oivqwJiIVGtcxeyz5gouNxWBvW7FLOcfmXh+gmBYy7MhEOre08cG20T63FQ3JznZIDlqiGTFK2F+YDi+05GO6JtkEk3sZnaaa14KllKhdhNUqe+gQy9+8RahPExV3YSlGbqkiZsyG2FHOIeL0ZXonWxPh0wmvHbc+mksSlY4gFwl1hK8iXntP8EYTL83vqKENN1gdvMqo2vL2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/tv/hlkLWVM4o8UX9l1XoOc09CK3MqtNYAvV2JgNnI=;
 b=A9az9oVYwP4Im69rV3rWVpLCU62c3oJW7wTlyf7TKeNwshpsPNrGnscXGMrFN3191EwILXt+MYK1v6WVHLdPDtHoLpjMPkYc/AhCR+S1CCHlhmaXglmizZvZjla90DbkHNTQgprHqczTiuPGDeG8DN+TTaqYr8n9qniZp6DlrTrBjS6Y0MN3DfcO7wAA3MUCbnWYporH9vRWx31vRVHDHSOBEjuKzpc8WzAOuCSlSWL+VxYE7qL0uSVYryhFZPZ0NVlf0M1bQVX54oQO1+F4NVwWAgDMx9SoDA/5G8MnDNl7Xh5mODMrPy/TZFzln3ZMkEr5O/fSDflluRjMkMOhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/tv/hlkLWVM4o8UX9l1XoOc09CK3MqtNYAvV2JgNnI=;
 b=DdwhbSB1dzTX9GUjzDbk2rUfmkTgkwF9T0BbVaHcfsB0dQklTVJ5n3eZwnp1UBSgjeFBkynssvzJfBThTmJ42zaYuNFd0wl9j7STY+3s8QKhMf7HBi1HWj3ujqfUtKCVg4kx22gSDOJdhMxH7EwrZw8NL07SGqhBQQGwW8RuHA8=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SI2PR03MB5465.apcprd03.prod.outlook.com (2603:1096:4:101::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Tue, 21 Mar 2023 06:50:49 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1%5]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 06:50:49 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>, "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v9 2/7] iommu/mediatek: Fix two IOMMU share pagetable
 issue
Thread-Topic: [PATCH v9 2/7] iommu/mediatek: Fix two IOMMU share pagetable
 issue
Thread-Index: AQHZWK5hBMkvUMxmkUm7eZJH4httBK7+tdgAgAYbugA=
Date:   Tue, 21 Mar 2023 06:50:49 +0000
Message-ID: <e724eb4b63901fd2ba9f7957d1a3cd6fdd234bf4.camel@mediatek.com>
References: <20230317085541.20447-1-yong.wu@mediatek.com>
         <20230317085541.20447-3-yong.wu@mediatek.com>
         <47cac7a6-c069-64a2-7979-b879b075058f@collabora.com>
In-Reply-To: <47cac7a6-c069-64a2-7979-b879b075058f@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SI2PR03MB5465:EE_
x-ms-office365-filtering-correlation-id: 979a6b00-1db5-4655-d963-08db29d89af7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cz4buXFh0pGFGu1Pg74DXJY1vm/0aGGksO+EBMiof9Gfj3mtxER6v1LhezuMJMgjv3KBg79YplVhijyL1cttIy8dzbrD3ViwXr5eTo92wxnoBaUdpEqTCpB74qAACUiKsua92iPLd4To92cbMAbsabvpdZc58TumLtuDhCuxJ5eRpyV6+B2KQYmknP9fV54HhGGfRSLOnR+ZpmhmE6SNDNlWL406SV3bBHCzelHhTv80nfvtUwqzhSwGDDNEeDpuTMnWCiABlcVu41Hh/Oq9feDg+QTOdVdKQ8VbhGs32Y/z0va8qdGq9sfAIUW6cJWqY8u7xNIVPM2xRb2yZDJgDkTXB1WDMCG0PKNf15jBKqfVfwrs6BNmv76Kvubxugsrr3GxqwLGoOemD7vd2TrI4oTu/P19sO1bG5/RTMZfIrcd4g8pUyiQfsJOCT5xEIyNyUOZRO9tb+M3iKrGJc5qeHjMjek5NVEMFv505tDIiuOhKRm6BVitWv2701/zyHG4JTEiBi1l/aj3msML4LX7/IqzWOBcT+mjdFwm/g3dPbkz16NiOUqgAGE6frV0UkEokM2BbGc1Kox9Vg4JoFK5BkMl3Z4Q2OexoZ0eLqvPoOWoYF1RWUAYKcePaC+RJh/uxwuoHQIvecT5cOhnPCqQOamk59lvrGOIwUP6dIWXvR8Fb2ZEwoA6nkfTldL3+1z1RJAcSb29jOLt78tk3jdx08ckZQsjIlsthE3k5l89t6M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199018)(86362001)(38070700005)(36756003)(4326008)(85182001)(66476007)(122000001)(38100700002)(41300700001)(478600001)(66946007)(66556008)(66446008)(8676002)(6916009)(8936002)(64756008)(54906003)(5660300002)(7416002)(2906002)(83380400001)(2616005)(186003)(316002)(6512007)(71200400001)(6506007)(76116006)(26005)(6486002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2duZWdGdnFSdlh3emhQSGd5OElqWTE2c2svTzRreGZKais0K3VqcVBBbUdI?=
 =?utf-8?B?T04vUEdydWp5UTRuaE5lTGZNK1RDREtFUVdlcHpJa2twbzk0YmRFN3djR3VR?=
 =?utf-8?B?eVNoVUk0d2FOM1JXZ0lOOC9sbkhwcXRoNzVLSGQwYnhwRmdLbW5LMVJkNUNs?=
 =?utf-8?B?MXEzVk9zRStHd21ZelZBUk9kSWVBUjM5WDhSRmRNZnFLN0hVOTJKWHNnSzFZ?=
 =?utf-8?B?azdZZ29OVkRrblNYaUtTWlV2YnRlU0swRzFwQUJZTVJvbXdxTGMxN3lPUDhw?=
 =?utf-8?B?dnY2ZHpWWHBPa0pKellZRWZrQWlhTEFMZVFsT0tBSkxER0M2MHpSSGp2bnBp?=
 =?utf-8?B?WVhsOVNvMFFKZFFYdElWOFFIaUZQZjVZSlFLWjREQXdmNnpYVnd4aUVOWTRR?=
 =?utf-8?B?WVhPVWlXakNJTnZpa2pqbGNYM0V2WkFNNUZ0aGYxajBVSytsa0Q1ZFRVZDE5?=
 =?utf-8?B?eGpUUUhwN3dCdDRsbDFEZkhSNU95bkxZaC9GWUxFYkJ1eHlLc3gxUlFrQkFa?=
 =?utf-8?B?aUJ1ZDR6aTZhMzQwMU9QcVNXTVVRNmhRQVF3eGxCZkN5ZTVuN3NuTGxxbkxK?=
 =?utf-8?B?alhOMG1oUzBONWd5ZUd4bVg4c0E1dzVEUUxPMGE5ZnB5N240Zy9FT2lIMHkv?=
 =?utf-8?B?emlWeEY1aW9HelN4WnBwUDhiMXF5K2ZiR2tHSXBmT3kvdkd1MXhpN0tyaU4z?=
 =?utf-8?B?RldXd1hya2ZoWEJ4L1VUdElPN0NNTm9lai9DRHp4YUZKbFZkS2NidURRN0Z3?=
 =?utf-8?B?NytEWlRtV2cyeE1IQXFZZkEzNkNSSjFRMnFwTmt4RGIxMGF6YTFIQ0k3cGUx?=
 =?utf-8?B?aUg5Z0pYVFBnOTdnR1hxSUxUK0NiVTZQSGYwV3RDZHN6WmlCa1UrdjE4QTV1?=
 =?utf-8?B?Qm9wNy9ONGpjM2VUSXJnUTJoQUxlQWk1clJXZ2g3eXkrZlRWVEZIRnplTTRL?=
 =?utf-8?B?SHJyZG5Tb2xKU3gxaGs2ZW4zekRsZ2tTZ3c3MmdHYm42R1d4UWVJdUorNUdU?=
 =?utf-8?B?alExME1sdUFuckl0WGd5NCtleGZsT24waXNSSm5hYllHQUdFMzkvQ29kQ0g1?=
 =?utf-8?B?N1JRbmQwUWlVK0NaWnpYTGhiUHBCMit5NDh1RkQwaE1ySzFZdU5Wb1pZV1N3?=
 =?utf-8?B?eGdLK0llMDZod2dQR3VSWDF6emdHY0RicW11MVlVZWtDcDBEaVVYRno4QkRD?=
 =?utf-8?B?WlhjcW5HSS9UNFFQVW1CR3J1WXhOMFJsVm9WTnVONlZSbW9DdGdMOVM3djN6?=
 =?utf-8?B?N0FwVDAxa0I5VlpRMVpPZUt0MHMzYUpUa2JlS0pxcDI2amthcHBqb1ZPa2Ja?=
 =?utf-8?B?WmFRdEY4QW5VdU94bDVUNTZoRVZHZFdKci8xejNub2VlLzk1MTh6UUQzd1Rs?=
 =?utf-8?B?cy9JbVFya2E1dWFETlZVZGRWZ2xucFNrUlpHWW80RkNkRVdLVFhNRFdjck1k?=
 =?utf-8?B?VmtZL0d6cXdQaHNzRlV2WnJ6RzA1N21vZ1ZYSXo0Vm1MV1ExdEFYRkQrbUNr?=
 =?utf-8?B?K1lpWmlJTWR0TmlYVGhmK2dHN21Xd1RwVHplUytSekphUGErZEZzdHFRb28r?=
 =?utf-8?B?SHZFVVowTnVtYzY5M2FkTi90eVZBSjYzZ1JFTFZxRmhpYjQwNktyTVBLaTEx?=
 =?utf-8?B?Y0QrZVZtT1FCQ1g5YzFaVEV3MXBzZWtFdDJNakFlTklreDF1ZTM2ZmRZT1Bk?=
 =?utf-8?B?SFUvZ2ttOVJSNFl1TDU2SFAwWWlkdzE3Q2VrNzl2bVp2WjFRTTcvSzd0dXgr?=
 =?utf-8?B?cytkY3dUd3VNdVRXZVBNQ1NGSW9zUnZZanVtVCtzMFJmS1FJNkk1cDJDRVc5?=
 =?utf-8?B?ZzZEaVNXR0xnL2NFbFZ0ZWpMUGE3UUtqVWVKNTNiMFpKQ05CeE90VDRta0hS?=
 =?utf-8?B?OFRFNXpVVUtWMEhPK0h4QzhDRlhBNitaVkFQaFdWZUc0WG5MNWROVm43ZjlL?=
 =?utf-8?B?N3hKNm5FK01Hc29GK1FYbzlqQ1RwNGFlRUZYbWhPL1BqcVp5cmlDc1NCSXJ2?=
 =?utf-8?B?OE5wN3J3c3FOVFFlZmxRbE5qbFlhZW9tdnJhSjJZOFlReTQvcEtiVnJHdjAr?=
 =?utf-8?B?VHpvQkZYM0NJbkhrYWoyRzJYU1ZVcFBCYy96UmpkOTZIZVdFaVYyejFGQVBi?=
 =?utf-8?B?SnJiOFNNeWQ3ZzRLSUI5QWdIcXJPTlRJQnRJbDVOL1AyUU9Ya3k1WnJ1cXhT?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13B722D0E758AC4286B8F5D0B4F57347@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979a6b00-1db5-4655-d963-08db29d89af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 06:50:49.2510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aSOt5YWGJmGBiN4wnxVM57Av/jjSZIsmbeD1OOrvm0RBauMQByHi8860qOPHyRerzaqC1M+F/RdTv1WOH7ReEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5465
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTE3IGF0IDEwOjM0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTcvMDMvMjMgMDk6NTUsIFlvbmcgV3UgaGEgc2NyaXR0bzoNCj4g
PiBGcm9tOiAiQ2hlbmdjaS5YdSIgPGNoZW5nY2kueHVAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+
IFByZXBhcmUgZm9yIG10ODE4OCB0byBmaXggYSB0d28gSU9NTVUgSFdzIHNoYXJlIHBhZ2V0YWJs
ZSBpc3N1ZS4NCj4gPiANCj4gPiBXZSBoYXZlIHR3byBNTSBJT01NVSBIV3MgaW4gbXQ4MTg4LCBv
bmUgaXMgVlBQLUlPTU1VLCBhbm90aGVyIGlzDQo+ID4gVkRPLUlPTU1VLg0KPiA+IFRoZSAyIE1N
IElPTU1VIEhXcyBzaGFyZSBwYWdldGFibGUgZG9uJ3Qgd29yayBpbiB0aGlzIGNhc2U6DQo+ID4g
ICBhKSBWUFAtSU9NTVUgcHJvYmUgZmlyc3RseS4NCj4gPiAgIGIpIFZETy1JT01NVSBwcm9iZS4N
Cj4gPiAgIGMpIFRoZSBtYXN0ZXIgZm9yIFZETy1JT01NVSBwcm9iZSAobWVhbnMgZnJzdGRhdGEg
aXMgdnBwLWlvbW11KS4NCj4gPiAgIGQpIFRoZSBtYXN0ZXIgaW4gYW5vdGhlciBkb21haW4gcHJv
YmUuIE5vIG1hdHRlciBpdCBpcyB2ZG8gb3INCj4gPiB2cHAuDQo+ID4gVGhlbiBpdCBzdGlsbCBj
cmVhdGUgYSBuZXcgcGFnZXRhYmxlIGluIHN0ZXAgZCkuIFRoZSBwcm9ibGVtIGlzDQo+ID4gImZy
c3RkYXRhLT5iYW5rWzBdLT5tNHVfZG9tIiB3YXMgbm90IGluaXRpYWxpemVkLiBUaGVuIHdoZW4g
ZCkNCj4gPiBlbnRlciwgaXQNCj4gPiBzdGlsbCBjcmVhdGUgYSBuZXcgb25lLg0KPiA+IA0KPiA+
IEluIHRoaXMgcGF0Y2gsIHdlIGNyZWF0ZSBhIG5ldyB2YXJpYWJsZSAic2hhcmVfZG9tIiBmb3Ig
dGhpcyBzaGFyZQ0KPiA+IHBndGFibGUgY2FzZSwgaXQgc2hvdWxkIGJlIGhlbHBmdWwgZm9yIHJl
YWRhYmxlLiBhbmQgcHV0IGFsbCB0aGUNCj4gPiBzaGFyZQ0KPiA+IHBndGFibGUgbG9naWMgaW4g
dGhlIG10a19pb21tdV9kb21haW5fZmluYWxpc2UuDQo+ID4gDQo+ID4gSW4gbXQ4MTk1LCB0aGUg
bWFzdGVyIG9mIFZQUC1JT01NVSBwcm9iZXMgYmVmb3JlIHRoYW4gVkRPLUlPTU1VDQo+ID4gZnJv
bSBpdHMgZHRzaSBub2RlIHNlcXVlbmNlLCB3ZSBkb24ndCBzZWUgdGhpcyBpc3N1ZSBpbiBpdC4g
UHJlcGFyZQ0KPiA+IGZvcg0KPiA+IG10ODE4OC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBD
aGVuZ2NpLlh1IDxjaGVuZ2NpLnh1QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZ
b25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gDQo+IEknbSBub3Qgc3VyZSB3aGV0aGVy
IHRoaXMgaXMgKm5vdCogYSBmaXguLi4gaWYgYSBzcGVjaWZpYyBwbGF0Zm9ybQ0KPiB3YXNuJ3QN
Cj4gYWZmZWN0ZWQsIHRoaXMgbWF5IHN0aWxsIGJlIGEgbG9naWMgbWlzdGFrZS4uLiB0byBiZSBj
YXV0aW91cywgSQ0KPiB3b3VsZA0KPiBzdGlsbCBhZGQgYSBGaXhlcyB0YWcgdG8gdGhpcyBvbmUu
DQoNCkkgdGhpbmsgeW91IGFyZSByaWdodC4gSWYgd2UgbmVlZCBhZGQgdGhlIEZpeGVzIHRhZywg
aXQgc2hvdWxkIGZpeCB0aGlzDQpvbmU6IDY0NWI4N2MxOTBjOSAoImlvbW11L21lZGlhdGVrOiBG
aXggMiBIVyBzaGFyaW5nIHBndGFibGUgaXNzdWUiKS4NCg0KQmVmb3JlIEkgdGhvdWdodCB0aGUg
Y29kZSBmbG93IHdhcyBjaGFuZ2VkIGEgbG90LiBJIGFkZGVkIHRoZSBiYW5rDQpzdHJ1Y3R1cmUg
YW5kIHJlbW92ZWQgdGhlIG10a19pb21tdS5oLCBJJ20gYSBiaXQgYWZyYWlkIHRoYXQgdGhpcyBm
aXgNCnBhdGNoIGNhbiBub3QgYmUgYXBwbGllZCBjbGVhbiwgdGhlbiBpdCB3aWxsIGludHJvZHVj
ZSBjb25mdXNlIHdoZW4NCmFwcGx5aW5nIHRvIHRoZSBwcmV2aW91cyB2ZXJzaW9uIGZvciB0aGUg
bWFpbnRhaW5lcnMuDQoNCk1lYW53aGlsZSwgQWZ0ZXIgbXQ4MTk1LCBtdDgxODYvbXQ2Nzk1L204
MzY1LzY3OTUgd2VyZSBtZXJnZWQgaW4NCnVwc3RyZWFtLiBBbGwgb2YgdGhlbSBkb24ndCBoYXZl
IHRoaXMgc2hhcmluZyBjYXNlLCB0aHVzIEkgdGhvdWdodCB0aGlzDQpmaXggaXQgaXMgbm90IHNv
IG5lY2Vzc2FyeS4NCg0KV2hhdCdzIHlvdXIgb3Bpbmlvbj8gYW5kIHNob3VsZCBJIHNlbmQgdGhp
cyBvbmUgc2VwYXJhdGVseSBpZiBJIGFkZCB0aGUNCmZpeGVzIHRhZz8NCg0KDQo+IE90aGVyd2lz
ZSwgSSB3b3VsZCByZXdvcmQgdGhlIGNvbW1pdCB0aXRsZSBhbmQgcmVtb3ZlIHRoZSAiRml4IiB3
b3JkLA0KPiBzbw0KPiB0aGF0IGl0IHdvdWxkIGxvb2sgc29tZXRoaW5nIGxpa2UuLi4NCj4gDQo+
IGlvbW11L21lZGlhdGVrOiBQcmVwYXJlIGZvciBwYWdldGFibGVzIGRvbWFpbiBzaGFyaW5nDQo+
IA0KPiBJJ20gc29ycnkgZm9yIG5vdGljaW5nIHRoYXQgb25seSBhdCB2OSwgYnV0IHRoZSBwcmV2
aW91cyB2ZXJzaW9ucyBoYWQNCj4gYSBiaXQNCj4gbW9yZSBzdHVmZiB0byBhZGRyZXNzIGFuZCBj
b3VsZG4ndCByZWFsbHkgZm9jdXMgb24gYW5hbHl6aW5nIHRoaXMNCj4gb25lLg0KPiANCj4gSWYg
dGhlcmUncyBhbnl0aGluZyBJJ3ZlIG1pc3VuZGVyc3Rvb2QgYWJvdXQgdGhpcyBwYXRjaCwgcGxl
YXNlIGZlZWwNCj4gZnJlZQ0KPiB0byBleHBsYWluLg0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxv
DQo+IA0K
