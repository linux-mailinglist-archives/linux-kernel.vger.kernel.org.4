Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF16B1DFC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCII1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCII0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:26:32 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04126E95;
        Thu,  9 Mar 2023 00:24:30 -0800 (PST)
X-UUID: cc8a0aa2be5311eda06fc9ecc4dadd91-20230309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Is2VqhbOsS3IuWI76iSIP1Noak8iMHaPakEyzPgYdVU=;
        b=l0TBv2VZhCpKM95h/KvVrPPoApVkWZRoZk0VmC9zuigsqOeTQRX9cpD5DSGibYEuSNZZT5EAy9/hav38XTvUBaEAz+dv+zawlPApz3qJ3v6dM6dCAoNBZ18it4f0uYvQ9EqpqmrFKdZHJZuUV+V5hihDNPHHBQXv2cWST9r9qBk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:ce9ad68e-2953-4b12-b955-e8fbd725ed07,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:4331b6b2-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: cc8a0aa2be5311eda06fc9ecc4dadd91-20230309
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2046927754; Thu, 09 Mar 2023 16:24:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 9 Mar 2023 16:24:22 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 9 Mar 2023 16:24:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUeJA/3c2+rclh0opDWxnLrP0xTOyCarSdTsWzymfog/hAiAAAftCb7yY9TmzOrk5H3B7EvGipgQYA1SU7tu+GpRr/bEdYa77LrAJ/KQSsk7O549WQmTdlKjoCJabpdR+zPIZ/THCJ+Elnlxzq6y7R6+vt4lz1ZBpCLC5cy53P57nnSUt6jXWGW1yDNfwlbq0APoPUAv4yC6H2izUiwzn7o43iG6pTYUJ1OOx9uRL4fInm/qzxoonVW+5XaMgXcPAsNgkkpyZ+e5YZ9/Wp5uVqzcnLLj/C/d95i/yW1Ov0zP2odMVZaDqvM0Zvrj6EZHWrh4jmtN+ppJRStof+1ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Is2VqhbOsS3IuWI76iSIP1Noak8iMHaPakEyzPgYdVU=;
 b=mpnZBWasj6Blw18UgFwEVctGuhtwe23pM2WoGJamAiNs1JB8zoP6vDOuNFZl1OLgxeGdGLPUS8g+6m6RsJ+nNdk7y9h5t6CPM2TZcbsT5P1z1VluTRXevCc1TAdYCOUOVPOOCY3+XvLnxVZndKD9Q1lmgoNcJ5TOTqWPU0gghhuV23xAgljYQg8Fv5oHfBqvBO7GpN1P2+VSC7LbfFZgCAW+fE0V6aUZiBrVxWzK8C51LzD3hAXztfxjtWkyUHeqTsCQq2VkPmHha1loPu5rRnMApIjwypMgYKNYyuRKIOuAxppiKrXWHlPHXtOotH+t/Cz5GvRuBmAKeu3WZb3dvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is2VqhbOsS3IuWI76iSIP1Noak8iMHaPakEyzPgYdVU=;
 b=URkWxoVaJrs4psGeiSBlblC7+nABFqOJoQBKK9h6aH5wNtMnujSD+3MBf+GsdlWtBq8BmUTA0jWIfXXCihBMUWO/Znc6Mb/OFhylmW+NNqFq4p11hGOHcjz2GPK4ilh/DApq29h9j2NsChV98WBShMtPYK7A0InYRXHlVcqb/nM=
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com (2603:1096:820:73::5)
 by TY0PR03MB6821.apcprd03.prod.outlook.com (2603:1096:400:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.25; Thu, 9 Mar
 2023 08:24:20 +0000
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::40f8:8248:54d5:a6ca]) by KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::40f8:8248:54d5:a6ca%9]) with mapi id 15.20.6178.018; Thu, 9 Mar 2023
 08:24:19 +0000
From:   =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>
Subject: Re: [PATCH] remoteproc: mediatek: Dereferencing a pointer that might
 be NULL
Thread-Topic: [PATCH] remoteproc: mediatek: Dereferencing a pointer that might
 be NULL
Thread-Index: AQHZTbrUIf19zHSerkC4hHxClViIAK7pXiSAgAjHeoA=
Date:   Thu, 9 Mar 2023 08:24:19 +0000
Message-ID: <29643c069485b2c7e49fd9e40c26b60f86a63a86.camel@mediatek.com>
References: <20230303102751.9374-1-jason-ch.chen@mediatek.com>
         <CANLsYky0pbqiEfq7E6DZM=J+sm2JJ8gYST2atUyP8X7y9zdHWA@mail.gmail.com>
In-Reply-To: <CANLsYky0pbqiEfq7E6DZM=J+sm2JJ8gYST2atUyP8X7y9zdHWA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5650:EE_|TY0PR03MB6821:EE_
x-ms-office365-filtering-correlation-id: abc0a79b-2207-49cd-76ff-08db2077adbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vtg3zPehkL+ehKcs/4yNeRbwsr2VSQCiNeQgbds6vSHFXScz9v5o0Hm10Kw7FeJa7sdu93/Sf6FO2NQj6EeOiJBdamd95Ue3DQvLbX2mNZitGmMu/K5zJixsT2XW6ncc/tAW5592fWTMDP7tme888qsKGji6zNuAYOa1zxLuxDhQGi95EQOPCpqrvuSNLzlxISrGX6Hzlro4IMm16sGbQW52BUhDMEmzMSeam99sbJrkWYR7ZgZ1cJmTpF5vqUue0ExKDhwSBZ2gJVhwUUBIx6O1D9KEZ3C3wJi76uetOoyPN2qr6XocbYIIZJw4xx/rTUTEA7ylWoGUVvfP/LKLDXU1MRDsGM+Bw/Iw5Xre0ra0fVnlGSkddR5QXTzibJwg5cm72RQDmcZSs9xcbO66Po3w7K5I5eS9SqDNJThRKPrLpofQDZaAn+1Wn2LNKwPlYQiUvRKLLC/5uBBm2N1wxXOBhewPvXGyPfpIghKUkhvIT4Ov/D9E75x/g88vaHPSlPSv1uSH+cQiJh/n8CF1QEHtMbdMutratphFPR1kdodo6ELEnIo0caeaUfwFgRVyX76ROZNui1BNnGH/dxbJiQouSC0mRe7/MbOHRjeopdLmilHdY4KzQdv4SacUvxPivjmD4ryhtrcyMnTzYPt4t03o1upUJs6fXCtNz4p6C2p52a1U0OwiNFS3HbYisWqLBZ50HyOT8ezLJQ2QclJl5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5650.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199018)(5660300002)(186003)(66476007)(36756003)(85182001)(26005)(478600001)(41300700001)(71200400001)(6486002)(6512007)(2616005)(6506007)(38070700005)(66946007)(8676002)(66556008)(4326008)(6916009)(76116006)(66446008)(8936002)(86362001)(54906003)(64756008)(91956017)(38100700002)(122000001)(2906002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjM4TEhocUxCOGlFQ2d0VTFmMDBiVnhaREdhQ2hTRjRwbFh6dm1rK3dSUWVa?=
 =?utf-8?B?SVVXZ2hDbVRDbUQrSmJTd2tCR2ZqN2VhRXZDaUVRQ0RLMUs3UEx3OGZtNGtR?=
 =?utf-8?B?eVdqRWNYMFdybmo5ZGIrWnJ0cElrLzlNWmliQW9DNCtyTW1vYStEVzd2eXda?=
 =?utf-8?B?QWVoWXg0SjRuME5zQnlhOElncVRSREVQTUJZSHlaYjA5R0YxZDFBb25iUHhs?=
 =?utf-8?B?c2ptVGV2d3FKMHdUOWZ4bml0ejR5aDA5SnB3dmtJVXE0UW9teHhpVHo2R1JT?=
 =?utf-8?B?WDhHSis1bjVHT3lNL0dzV3Jjd2FOVWZsRFRVS1EyeWFmZDl2WTlpeDhseERX?=
 =?utf-8?B?Zy85Q3BOMlNkR3dTUWJlMWRRME9KK085UE9KVmFpQ2xwT3dvMm9DY3pqb3Iz?=
 =?utf-8?B?TnFQMG90S0U2bko4NmlLTW9rQVZadS9ZWFloZ1BDR2hHelNLMGgyUEYvZjBm?=
 =?utf-8?B?T1dFQ1pzalI5MmhBSklHR1lnbDhRN2ZLdTBzbWNMOXpObmFHVmgxZTNDTkRU?=
 =?utf-8?B?dmJFSkZERk1HeFNLdGF4a01OM2dLSHp5MnJDSVdBMkl3elVGRnBSV0JPWmRl?=
 =?utf-8?B?bXVKUWpzMGprOW9OYkRtN2FvNkZiMi9NbUd3d2Mwb0M2L1ZCUkhsS0VjRDJX?=
 =?utf-8?B?bmwydVYySTIxYThNa2hXWXVtemVYTWloOVBRN3NUcjJTK2NZUWpzVFk1V2R3?=
 =?utf-8?B?ZUY2Y0xmSmZ4NU96ekpHeXdvVFRUV1dBQ1NsaURYa1pHYzZ0c1NNbDVhQTdX?=
 =?utf-8?B?emlzNGFYb29HcGFWN2k3STNZWTNzU2RKQ0REek1scGMrWTlsTVNoakZCeXZ4?=
 =?utf-8?B?V1RkaHJuZGZWTHJhRjUyVlNHeUNhdWc4dHVjL2kxZkZBUkQ0T3FHN1hFNlJY?=
 =?utf-8?B?RTk1M0ZsbXNvbndnajRZcW8wYTlic2JPcGFHa3M5N0VVM3hQbUZ2QVJpUjBk?=
 =?utf-8?B?VzZxakczVVdpTXorVmhqN3U1N1oyTVYrNS94c3RQVVNJdC83OVNlelpCS3dp?=
 =?utf-8?B?UW9TMjFydnRxSDc3ZXBkcG5xM1FCVVdETVBSN1JsMStVK05iTjAzTUpWbUpQ?=
 =?utf-8?B?cWRTQmRYME1JcHJMVnBqcUI0L0szSmFBbFRqZzFuS29IVUlIc1lkK1FjZGNk?=
 =?utf-8?B?dElUMWo4VjNJZjhUQkdpeitPd1RqTTlOTFhISVBndlVUdFdXZ0RITFJKMXVR?=
 =?utf-8?B?MlpNRFl1MXpyVU92cS8yOURkRTFqYXpTekNkZ0lnOUFHL2k5R0pKVThyYTRB?=
 =?utf-8?B?dUZTdXZHajFUMkJSUi9SVk9pQm14cHJ4OEd4L1czYzdvQkdIb1dXOTlORUg1?=
 =?utf-8?B?Q1lIY2JiWnJ2cXJIUjdGc3RibkdWeU5pMXFDV3V3OTdoUE55V3ZPWVNJSVhM?=
 =?utf-8?B?Mk5UZWMvKzJvSTZMOWgzNFZ0WERyaEQvbU1XL1I5YzVvTHpaM3JiU1JhQ2V2?=
 =?utf-8?B?M0NwN2pPdUxtODVQaDgyMERkZHJxeTVGQTVtUXEzR0dCT1pwWmNWUVdSZ2Zk?=
 =?utf-8?B?U0VLYXBaRFZSbnlxdHY2QmZ2T25XaFgvUHh4SUdFK2FLWmljTUx6a0xZSnpM?=
 =?utf-8?B?ZHFIam5ndUJTWGV2UjdFZ1J0aUZFdUxHRzBLRUVFbTB2Y3RxWWk5N2cvY0tK?=
 =?utf-8?B?d2Nnc2NvcCtvcFJlNHhzcnM0ZDk5MTMwWEJLTVo0ZjZyb1dHaTN3N3FWb1cr?=
 =?utf-8?B?ZTdpRXZTZVhvMVp2YjVNNzJaRU5rd1crMWpGWnVwb2RMdEVXZXJjZmVKTWJp?=
 =?utf-8?B?anFHL0ZWUjF5UWdkTndvK3ZXVWQrOUNOOUUrZnltU1VZZk5mZGZ0UlVsazhw?=
 =?utf-8?B?MFJLN3lqTUtQcXRDekFTbTBDaUNHTVlYTXZSYUQwK0pKU3F6UjlvVmUvU1B6?=
 =?utf-8?B?S0tIOEQyYkpIdEM2R3loV1MwWFFGNDJ4dDhHUzh0dFVPNjdmSEVzVGdiMFYx?=
 =?utf-8?B?OStmRHVFazlzUjBYK2JQR0VyeDBYLzNLVXJUd3pZQlFqbmNDelFOMEZ6OTJU?=
 =?utf-8?B?ZjRvK2R5eEdUZW9rN2tRRDNpLzFwWkJnMEprUGhRMythbXBoaktlM3NPUTk0?=
 =?utf-8?B?RzdBS2J5ZDlVTHJLRmpnZlhxODNMdDkzMWNGUlpkL1hhZGVlaUhVUGFSZDR1?=
 =?utf-8?B?ZHc4dFlIeWZlV0VtUFdlNTJsUEVvTmhnSWlEL1grcFZFdUhnTmczejQyMWo1?=
 =?utf-8?Q?Udfo+FLFg78cHb2yfe29vcQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40A6DA48390042468B84766C0C09F685@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5650.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc0a79b-2207-49cd-76ff-08db2077adbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 08:24:19.0660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEbsKhbuktrfCE63mcb+t508VSYhV3Sp+bEJttoiYXKGmtiY6UAl6u7aOSyWBH0FuwA9tN6lrZxlrahcBODX+xskkYbeNKLESARLuL/swow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6821
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlldSwNCg0KT24gRnJpLCAyMDIzLTAzLTAzIGF0IDExOjIwIC0wNzAwLCBNYXRoaWV1
IFBvaXJpZXIgd3JvdGU6DQo+IE9uIEZyaSwgMyBNYXIgMjAyMyBhdCAwMzoyOCwgSmFzb24tY2gg
Q2hlbiA8DQo+IGphc29uLWNoLmNoZW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiBG
cm9tOiBqYXNvbi1jaCBjaGVuIDxKYXNvbi1jaC5DaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4g
PiBUaGUgcmVzIG1pZ2h0IGJlIE5VTEwgd2hlbiBjYWxsaW5nIHJlc291cmNlX3NpemUuDQo+ID4g
DQo+IA0KPiAicmVzb3VyY2Vfc2l6ZSIgPyAgV2hhdCBpcyB0aGF0Pw0KPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBqYXNvbi1jaCBjaGVuIDxKYXNvbi1jaC5DaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9yZW1vdGVwcm9jL210a19zY3AuYyB8IDMgKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9yZW1vdGVwcm9jL210a19zY3AuYw0KPiA+IGIvZHJpdmVycy9yZW1vdGVwcm9jL210a19zY3Au
Yw0KPiA+IGluZGV4IGVhY2RmMjQxZjRlZi4uODYzZDE4ZjYzZjU4IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfc2NwLmMNCj4gPiArKysgYi9kcml2ZXJzL3JlbW90ZXBy
b2MvbXRrX3NjcC5jDQo+ID4gQEAgLTgyOSw2ICs4MjksOSBAQCBzdGF0aWMgaW50IHNjcF9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ID4gKnBkZXYpDQo+ID4gICAgICAgICBwbGF0Zm9y
bV9zZXRfZHJ2ZGF0YShwZGV2LCBzY3ApOw0KPiA+IA0KPiA+ICAgICAgICAgcmVzID0gcGxhdGZv
cm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09VUkNFX01FTSwNCj4gPiAic3JhbSIp
Ow0KPiA+ICsgICAgICAgaWYgKCFyZXMpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5P
REVWOw0KPiA+ICsNCj4gDQo+IFBsZWFzZSBoYXZlIGEgbG9vayBhdCB0aGUgaW1wbGVtZW50YXRp
b24gb2YgZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkNCj4gYWxvbmcgd2l0aCB0aGUgZnVuY3Rpb24g
aXQgY2FsbHMgYW5kIGxldCBtZSBrbm93IGlmIHlvdXIgcGF0Y2ggaXMNCj4gbmVlZGVkLg0KPiAN
ClRoYW5rcyBmb3IgeW91ciByZXBseS4NCkl0IHNlZW1zIGlzIHBhdGNoIGlzIG5vdCBuZWVkZWQu
DQo+ID4gICAgICAgICBzY3AtPnNyYW1fYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYs
IHJlcyk7DQo+ID4gICAgICAgICBpZiAoSVNfRVJSKChfX2ZvcmNlIHZvaWQgKilzY3AtPnNyYW1f
YmFzZSkpIHsNCj4gPiAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcGFy
c2UgYW5kIG1hcCBzcmFtDQo+ID4gbWVtb3J5XG4iKTsNCj4gPiAtLQ0KPiA+IDIuMzcuMw0KPiA+
IA0K
