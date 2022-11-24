Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334CA63769A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKXKiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:38:09 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04801B7B4;
        Thu, 24 Nov 2022 02:38:07 -0800 (PST)
X-UUID: d8a029f41ffc422d889101d78d84bb0d-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mrIAgvMXfWfHerH7mZc58m1HMzuY6JLLCqXhj582NUU=;
        b=Z7SojgAJ1MFUdBbRSP9VFL2ArxW43jpGjIxP1dUtpocG7EUbyBgocXQ2HQjQCIAHaUlQDFQo/jU3Z9BZVlBvSYNa37zzce0TA0k+VGSVjVp3OQZzfrWiIr348xhO4vlUaEFxfdRUvrtT85/4845WxWCZeDRbxk9lwoNQ5+9e3eI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:44b0da7a-189a-4bdf-a166-8bf1fe58bed6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:b3d8b82f-2938-482e-aafd-98d66723b8a9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d8a029f41ffc422d889101d78d84bb0d-20221124
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 571373999; Thu, 24 Nov 2022 18:38:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 24 Nov 2022 18:38:02 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 24 Nov 2022 18:38:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpIi7cDL86tEGQT8KSIklWo/Sz2O/muk+H8WMICFnKLqC7oEbf2jpAY1J/jZBuQhtuH7wbDIZJvmUQZ1MCOK36kOWtl6UcwQVi4CS4sOvAAvhpfRe30zCFyJtDvv2ZwKftzNU6DMdmuMLquQ/ZW9ttV477Hv4AqFJPt+Ah1UAlZi/awq4EkJey+sHzLkB2Z6mN495zybgqVyP58vCc8K9yLlwRQjuNEnZvzAIFE5VOPeT81KsZI4QQ1RimgZDrH+MXePqxXOb1EdyBsZzAxuWtxBc4y++5vVCeaDmWCcAfJc51nz5q9L2Bpt9DJ9iC2wrqtuQ4AiitPmw+Ojdq/DBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrIAgvMXfWfHerH7mZc58m1HMzuY6JLLCqXhj582NUU=;
 b=JyAI9RKU84txGBARYQvT7iVVP+2G9kxWBqftNQrP1n/QwQD3LkXqTRQOhfp4AI4u/jubrcSIOXrVJrUIZ3PXk0Y6Hg5ql+08hleLylhrwrzKlVW1FCCXoQbhJ7NpOhs7pegf6wMGRKYarPy1gASucBKWee6WBysm/muGB5/NQTTHCLMOqz0M50NgjmjtQENCGceBeQXDM/Sk7kHhWYYMGGE4e9++zMeMnNbV7eRifpcSc6otiYRrJ+aU4DnRRMvU7eFoPpf6jN/3X3DP9oz9XF6izNcOLakWSiO64ePV/Gbw4MwFiz11Z4QzgBL6zTN5y8FIws7wWoFteo9f8CKrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrIAgvMXfWfHerH7mZc58m1HMzuY6JLLCqXhj582NUU=;
 b=rhZRi35lkK5U+u495DE/UOzDIwVlFIUYZfAW7Y4sAD4xsG2T5Ul0xgFP8/rRPO+4hdlU1cTkvpfdFrnTroZMVZ6jEBA8COyj5YUJZ6dSjI8TDX9LD+T0qT/VaBLU0ZNDbyhGv7i3QFceJTIp6HA0z+43i2fPBfBrUSWvc59luLw=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by SI2PR03MB5659.apcprd03.prod.outlook.com (2603:1096:4:15e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 10:38:00 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696%5]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 10:38:00 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: xhci-mtk: omit shared hcd if either root hub
 has no ports
Thread-Topic: [PATCH] usb: host: xhci-mtk: omit shared hcd if either root hub
 has no ports
Thread-Index: AQHY+z0cVRMPp1EvGkKE/tItjF/i765MYdAAgAGJWoA=
Date:   Thu, 24 Nov 2022 10:38:00 +0000
Message-ID: <02552cc60b3aae16b2c2e9717b42c800180e3a87.camel@mediatek.com>
References: <20221118110116.20165-1-chunfeng.yun@mediatek.com>
         <a384d15d-c1df-160c-030b-fddd5d965996@linux.intel.com>
In-Reply-To: <a384d15d-c1df-160c-030b-fddd5d965996@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|SI2PR03MB5659:EE_
x-ms-office365-filtering-correlation-id: 39d10701-acde-4d4d-ecad-08dace07f55e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9MNXNIS5OqUyecI9QUxOX4uZ30I6uXwnobiQ1ux5sbuaRwB7h2lfRdZt7x/uR6BGYT69zZzFOlmhy0DMrXc6riSiRP2D25b7ihwc2+TNzYzu2WNMVXl4kccqPqtF5Czhhi6CSCA5DJVJ1SlLs2Zy4mDi+2bWMT+7t/ih0nY/c6Pl/PAEY54QD1oWtXZ83HAvlGnh1OXkSBnV0U05SZp4efRYRPMFLIwN1mvbQ/ZYVqxAY0qrHjidflbY43tstr9VNxEF3odo5ptN5KewyNBs77alhWGn0I7+8eY+ctUubqFSPwZ2mxo4ieZsn0dBiaqCW1MuYrT5jbzwEOLpCUQeQJm/eStsFFneCs9KhNh8m0tiQzE1aniYJda19j8KhuAcufKZL60g1xHsVRyG8fmeRe4vK9/aCEDDbxyIZ8KaXO05jnSpowBzgR2Mstd4wDzBffN8MeN5XIpSBGGLOWH5uP8TmvjW3/CV/1pmC4xuV9kbcG83eDql01YqzYL9Ul463hd9H8oU+wrdu2UGJ24GIg/5TBnNjtFDAcNh2hofX9iRVmTDgQQ62ZYHhQ0kC0d0+kzDbssw/Uh7FiqwMda5PJSSrxIUH081RrnSPFZml7HlarRyGceX4fin2fjqbBBCNvFHuh5nyOC37DhA0JidE65/rcU46u1cHT6JF/2iHokQ7oM6Y8BW9lDfnhB2z7F7Wd/CEd3HfsIxmYZhAgxJBGygrnxacOOGAAY5d1BBCa8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(86362001)(66946007)(38070700005)(38100700002)(110136005)(41300700001)(76116006)(4326008)(66556008)(8676002)(64756008)(66476007)(66446008)(91956017)(54906003)(316002)(83380400001)(5660300002)(8936002)(6486002)(4001150100001)(2906002)(122000001)(71200400001)(478600001)(6506007)(2616005)(186003)(26005)(6512007)(66899015)(85182001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnhSaVd1bzl1VENESVNYN0ZaWXBCWW5HeExyU1dyVGZiNFF2MWxwU2EyYmtL?=
 =?utf-8?B?dm1rMGNrcmNrWFIzaXZ3Q2ZOcVM5M1E1NWFvZjR4ZC9WdjR5bTBMK3FFZUVQ?=
 =?utf-8?B?KzY2bFFjckl5YkdDQXkrWFo3aFh5MnF2UDFxVVd1RUljeVpWcTVGT0RpT0I3?=
 =?utf-8?B?dmFKYU9JczRiY2ZBYmJYeUxtRGphNTVmUzRJTllLWTlCQ2lpbnFqNmZCYWls?=
 =?utf-8?B?OWNod0xmSWxCRitnOEc5L3lLZjhuTUdMeVdwNVpnMUdmR2VYMVBRL3ZWTUhh?=
 =?utf-8?B?VXorbVdEeU8zWExMek1FK0hrU3NRaXI5dDRqQytydk9YS1Z3NG0xalM2c3Q4?=
 =?utf-8?B?elh4cGlFTE9EWk1CekorbVNZTnNuSTA4MnRvK3Z5UmNUNDBUVmt6N0Yvb0ho?=
 =?utf-8?B?bkNjRkRBTVpNaEFkTFRyMGlVSk0vVzdiQlg0cVNOaHM3dFNUSzFnR2xnaC9q?=
 =?utf-8?B?ZzExcm1zcHhnVHFRRHRNRjgyLzlEcWJIelJXbnRQOGV0aDI2VkJaYm9yaFZK?=
 =?utf-8?B?RHp3UjFUMHA2SWVvc0N1K2JxVDBqbVArUXpjYzZvQkk0TEVPS1diUmpkQkJi?=
 =?utf-8?B?N1YwOTlScnRFaVI4aVVqQnVmdEQzelpoYStlUm9Vcjc1UDl1bnovVFVNbFFB?=
 =?utf-8?B?RWFNbFdNaDdZK3dvV3RTalRId1lrTllQeG5VaVgxOE5MakNCN0NUbzB6c3ZT?=
 =?utf-8?B?dmx4TmZZaG1yNG8xbjVZZlBSRmZxNnJkSUorYjBxQStXNHhaYlRRQnlnNHZB?=
 =?utf-8?B?ZU5aWm16a1JaS1NWYnNNekhCUUdJUlVmZzNSbTE0eVVWK2kxck5hUzVWVEpy?=
 =?utf-8?B?dERjaHl2NzFsVkg4YnpaaXZTSjRQMEVpdEVSRDVNdmIyd2tkTWQ3d0c1WmNS?=
 =?utf-8?B?L29xZFdSL2FuVWd2eXYrOHBVbU5nNko0TjZLWEhKUnhoT1AxODFDQVBPTFNz?=
 =?utf-8?B?MHBYdjdEUUtuRjNxWnpDMkU4RC9lZFFyM1dvSUZwNGFTSXh2SklBQlNZcWl1?=
 =?utf-8?B?NzRBQ21oYWFYS0JtVnhWY2RrdENSZ0g0eC9FZDd6c0tZZW13VC9aZFVMSkpn?=
 =?utf-8?B?bStnQlBOSDF4VHR2V1pDT2RWNyt0ZHNySVBSVGRKUzZ1ZTlFUW51RXlVQ0Vt?=
 =?utf-8?B?NnVTK1lyT21hRVdNd1hWby9qbERwU3N3dEg2MXZUeHdjYlA3RjU5akNYVHE0?=
 =?utf-8?B?dlhPMXZRRzFDYXVJT0VsVC9OZHZYWUw4QlpxM0lqcVZpLzl3c2RacmFKNzNk?=
 =?utf-8?B?VTJWbE9vYzk0blhReENhZmFaZmpXaVNwbVJTaThKZXRqWFFpVWJuNUJGL2xW?=
 =?utf-8?B?Q1VTTm1xZHRKc3dBWnVLMEppSEZ1NkdycFBpcUg1SG9kaFVQa2VTYTRsdVhQ?=
 =?utf-8?B?RVM3QStkVWtBSDFoQnVxQW1QUzl1S3pnZHRsUVRGd3lQRUROT0Q3ZzhIV2F5?=
 =?utf-8?B?RVRiNG1rSzAwcHRzS2VyTGlReVpqaWhySTVZb0Y3MTQrZTJMbFR6TEpjOU9X?=
 =?utf-8?B?KzFaMWpkT0VPZ3luVkg0RFlrSjdGZnppQ0svQ0M5cFJ3MkxPK2oyOHJlM3lJ?=
 =?utf-8?B?RGZ4SlBDVkZFaERZZGNsTVAvK0g2dVdGUnQxV1NTRkpZZm5IbTJoM04rWXdN?=
 =?utf-8?B?b0xRQTZVMU9jTGlIeVBQelpoYzJQdGJvSGhQb2U3NzN5TkgzYytxekl0Tm5z?=
 =?utf-8?B?SmMrZEwyd1pyZzk2MXVXZktVVHd4Um9FUG1VdlF6b0gycElZcU5udzdMdzN2?=
 =?utf-8?B?b1NTaVhQWmtjUGFVSC9Qb3EwSHZkSGFReDYvUVBZNWR6aFRDc044SzduWDFx?=
 =?utf-8?B?ZVRjSVlsVkt5MUE5YTJOOXRaSDZEa0o0OU5TVmV6U09vTkZHT0ZkODdvQ1J2?=
 =?utf-8?B?RlBHZGp1R05wUnh1VFVTS3dJbnYyT3V0cmhad1Y1N1g0akczQ2d0SHUvOUxx?=
 =?utf-8?B?dXRZdjZHZk1JVnRYdGV0VDFtbFRrUnd1ekNPUDhrTEtxVC80TVkyVHd4VG1X?=
 =?utf-8?B?UW1abXdnZVFmTS9GeHZFRUkvRUNKcEozb3o5R1JMNnJkTlR5Wkt5OFZzYisx?=
 =?utf-8?B?TU5YWG1kTzY5T3NZRi8wVHNSVDZmVk5IYmQ4VFUwYythVGhTZWczQVFPUWRp?=
 =?utf-8?B?aHJHR210ejVPd2pvbHR5L0pvV0hneG5QOGpDcmVvM3ZZZ3E1ZllQYTRlTE52?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2520CF88A12D4945A678B104198E7409@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d10701-acde-4d4d-ecad-08dace07f55e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 10:38:00.2453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGNtK9rSXZITvINvvjDhjDth6eZpCogg+tsiah2p7+F+03+IJSKvWVJ6glnJCiZ+VmHV2nBA1RJB1oMvJO679wj6q7BtePQOMBwr0k9lWys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5659
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTIzIGF0IDEzOjEwICswMjAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0K
PiBPbiAxOC4xMS4yMDIyIDEzLjAxLCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+ID4gVGhlcmUgaXMg
ZXJyb3IgbG9nIHdoZW4gYWRkIGEgdXNiMyByb290IGh1YiB3aXRob3V0IHBvcnRzOg0KPiA+ICJo
dWIgNC0wOjEuMDogY29uZmlnIGZhaWxlZCwgaHViIGRvZXNuJ3QgaGF2ZSBhbnkgcG9ydHMhIChl
cnIgLTE5KSINCj4gPiANCj4gPiBzbyBvbWl0IHRoZSBzaGFyZWQgaGNkIGlmIGVpdGhlciBvZiB0
aGUgcm9vdCBodWJzIGhhcyBubyBwb3J0cywgYnV0DQo+ID4gdXN1YWxseSB0aGVyZSBpcyBubyB1
c2IzIHBvcnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVu
Zy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy91c2IvaG9zdC94aGNp
LW10ay5jIHwgNzIgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gPiAtLS0tLQ0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgYi9kcml2
ZXJzL3VzYi9ob3N0L3hoY2ktDQo+ID4gbXRrLmMNCj4gPiBpbmRleCAwMTcwNWU1NTljNDIuLmNm
ZjNjNGFlYTAzNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCj4gPiBAQCAtNDg1LDYgKzQ4
NSw3IEBAIHN0YXRpYyBpbnQgeGhjaV9tdGtfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiA+ICAgCWNvbnN0IHN0cnVjdCBoY19kcml2ZXIgKmRyaXZlcjsNCj4gPiAg
IAlzdHJ1Y3QgeGhjaV9oY2QgKnhoY2k7DQo+ID4gICAJc3RydWN0IHJlc291cmNlICpyZXM7DQo+
ID4gKwlzdHJ1Y3QgdXNiX2hjZCAqdXNiM19oY2Q7DQo+ID4gICAJc3RydWN0IHVzYl9oY2QgKmhj
ZDsNCj4gPiAgIAlpbnQgcmV0ID0gLUVOT0RFVjsNCj4gPiAgIAlpbnQgd2FrZXVwX2lycTsNCj4g
PiBAQCAtNTkzLDYgKzU5NCw3IEBAIHN0YXRpYyBpbnQgeGhjaV9tdGtfcHJvYmUoc3RydWN0DQo+
ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgDQo+ID4gICAJeGhjaSA9IGhjZF90b194
aGNpKGhjZCk7DQo+ID4gICAJeGhjaS0+bWFpbl9oY2QgPSBoY2Q7DQo+ID4gKwl4aGNpLT5hbGxv
d19zaW5nbGVfcm9vdGh1YiA9IDE7DQo+ID4gICANCj4gPiAgIAkvKg0KPiA+ICAgCSAqIGltb2Rf
aW50ZXJ2YWwgaXMgdGhlIGludGVycnVwdCBtb2RlcmF0aW9uIHZhbHVlIGluDQo+ID4gbmFub3Nl
Y29uZHMuDQo+ID4gQEAgLTYwMiwyNCArNjA0LDI5IEBAIHN0YXRpYyBpbnQgeGhjaV9tdGtfcHJv
YmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgCXhoY2ktPmltb2Rf
aW50ZXJ2YWwgPSA1MDAwOw0KPiA+ICAgCWRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJp
bW9kLWludGVydmFsLW5zIiwgJnhoY2ktDQo+ID4gPmltb2RfaW50ZXJ2YWwpOw0KPiA+ICAgDQo+
ID4gLQl4aGNpLT5zaGFyZWRfaGNkID0gdXNiX2NyZWF0ZV9zaGFyZWRfaGNkKGRyaXZlciwgZGV2
LA0KPiA+IC0JCQlkZXZfbmFtZShkZXYpLCBoY2QpOw0KPiA+IC0JaWYgKCF4aGNpLT5zaGFyZWRf
aGNkKSB7DQo+ID4gLQkJcmV0ID0gLUVOT01FTTsNCj4gPiAtCQlnb3RvIGRpc2FibGVfZGV2aWNl
X3dha2V1cDsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gICAJcmV0ID0gdXNiX2FkZF9oY2QoaGNkLCBp
cnEsIElSUUZfU0hBUkVEKTsNCj4gPiAgIAlpZiAocmV0KQ0KPiA+IC0JCWdvdG8gcHV0X3VzYjNf
aGNkOw0KPiA+ICsJCWdvdG8gZGlzYWJsZV9kZXZpY2Vfd2FrZXVwOw0KPiA+ICAgDQo+ID4gLQlp
ZiAoSENDX01BWF9QU0EoeGhjaS0+aGNjX3BhcmFtcykgPj0gNCAmJg0KPiA+ICsJaWYgKCF4aGNp
X2hhc19vbmVfcm9vdGh1Yih4aGNpKSkgew0KPiA+ICsJCXhoY2ktPnNoYXJlZF9oY2QgPSB1c2Jf
Y3JlYXRlX3NoYXJlZF9oY2QoZHJpdmVyLCBkZXYsDQo+ID4gKwkJCQkJCQkgZGV2X25hbWUoZGV2
KSwNCj4gPiBoY2QpOw0KPiA+ICsJCWlmICgheGhjaS0+c2hhcmVkX2hjZCkgew0KPiA+ICsJCQly
ZXQgPSAtRU5PTUVNOw0KPiA+ICsJCQlnb3RvIGRlYWxsb2NfdXNiMl9oY2Q7DQo+ID4gKwkJfQ0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArCXVzYjNfaGNkID0geGhjaV9nZXRfdXNiM19oY2QoeGhjaSk7
DQo+ID4gKwlpZiAodXNiM19oY2QgJiYgSENDX01BWF9QU0EoeGhjaS0+aGNjX3BhcmFtcykgPj0g
NCAmJg0KPiA+ICAgCSAgICAhKHhoY2ktPnF1aXJrcyAmIFhIQ0lfQlJPS0VOX1NUUkVBTVMpKQ0K
PiA+IC0JCXhoY2ktPnNoYXJlZF9oY2QtPmNhbl9kb19zdHJlYW1zID0gMTsNCj4gPiArCQl1c2Iz
X2hjZC0+Y2FuX2RvX3N0cmVhbXMgPSAxOw0KPiA+ICAgDQo+ID4gLQlyZXQgPSB1c2JfYWRkX2hj
ZCh4aGNpLT5zaGFyZWRfaGNkLCBpcnEsIElSUUZfU0hBUkVEKTsNCj4gPiAtCWlmIChyZXQpDQo+
ID4gLQkJZ290byBkZWFsbG9jX3VzYjJfaGNkOw0KPiA+ICsJaWYgKHhoY2ktPnNoYXJlZF9oY2Qp
IHsNCj4gPiArCQlyZXQgPSB1c2JfYWRkX2hjZCh4aGNpLT5zaGFyZWRfaGNkLCBpcnEsIElSUUZf
U0hBUkVEKTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlnb3RvIHB1dF91c2IzX2hjZDsNCj4g
PiArCX0NCj4gPiAgIA0KPiA+ICAgCWlmICh3YWtldXBfaXJxID4gMCkgew0KPiA+ICAgCQlyZXQg
PSBkZXZfcG1fc2V0X2RlZGljYXRlZF93YWtlX2lycV9yZXZlcnNlKGRldiwNCj4gPiB3YWtldXBf
aXJxKTsNCj4gDQo+IAkNCj4gZGV2X3BtX3NldF9kZWRpY2F0ZWRfd2FrZV9pcnFfcmV2ZXJzZSgp
IGNhbiBiZSBjYWxsZWQgd2l0aCBqdXN0IG9uZQ0KPiBoY2QsIGlmIGl0IGZhaWxzDQo+IGl0IHdp
bGwgZ290byBkZWFsbG9jX3VzYjNfaGNkOg0KPiANCj4gZGVhbGxvY191c2IzX2hjZDoNCj4gCXVz
Yl9yZW1vdmVfaGNkKHhoY2ktPnNoYXJlZF9oY2QpOyAgIC8vIHhoY2ktPnNoYXJlZF9oY2QgbWF5
IGJlIA0KPiBudWxsDQp1c2JfcmVtb3ZlX2hjZCgpIGhhcyBoYW5kbGVkIE5VTEwgYXJndW1lbnQs
IG5vIG5lZWQgY2hlY2sgaXQgaGVyZQ0KDQo+IAl4aGNpLT5zaGFyZWRfaGNkID0gTlVMTDsgLy8g
Y2F1c2VzIHVzYl9wdXRfaGNkKCkgaXNzdWVzIGlmDQo+IHNoYXJlZF9oY2QgZXhpc3RzDQpUaGlz
IGxpbmUgc2hhbGwgYmUgcmVtb3ZlZCwgSSdsbCBwcmVwYXJlIGEgcGF0Y2guDQoNCj4gDQo+IHB1
dF91c2IzX2hjZDoNCj4gICAgICAgICAgdXNiX3B1dF9oY2QoeGhjaS0+c2hhcmVkX2hjZCk7IC8v
IHNoYXJlZF9oY2QgbWF5IGJlIHNldCBOVUxMDQo+IGFib3ZlDQp1c2JfcHV0X2hjZCgpIGhhcyBo
YW5kbGVkIE5VTEwgYXJndW1lbnQsIG5vIG5lZWQgY2hlY2sgaXQgaGVyZQ0KDQpUaGFua3MgYSBs
b3QNCg0KPiANCj4gLU1hdGhpYXMNCj4gICANCg==
