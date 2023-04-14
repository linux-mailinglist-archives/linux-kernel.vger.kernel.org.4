Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211566E19B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDNB1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDNB1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:27:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A59449C;
        Thu, 13 Apr 2023 18:27:30 -0700 (PDT)
X-UUID: 835cc8fcda6311edb6b9f13eb10bd0fe-20230414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tmiMemq9+HPD8xryEHvzL5nBko3hHRnm0z/qU8+WWSQ=;
        b=nA8VEprU9al8a/bRnSoiSgM7VudTNmAUDphYXvqj7hOMyM49a+7/ZvGd1c6awcLJwA4V0dm1GIn+PbHMFg9NB6XNPfkd8xTp2GwwblEMboUfW6dkA0rjQoSMtZSzCNKEt2YpfMnEFvgAtXk0TlOqH+ZePbcqAIP+RJaLNt/t21s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:e205ba27-1a0b-49b3-8d96-7ae93b818410,IP:0,U
        RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:20
X-CID-META: VersionHash:120426c,CLOUDID:79da45a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 835cc8fcda6311edb6b9f13eb10bd0fe-20230414
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1802422131; Fri, 14 Apr 2023 09:27:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 14 Apr 2023 09:27:24 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 14 Apr 2023 09:27:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGQbsEfNkbuWTFpId8BIK1kS0FBSZys48IGSi/9tWJWHh0L002+zwAItO5eer5XPrdD5jHQ5pB8BrAchY2ujCdYZf/DzX2cTGGHZAVbgyspAjP6vMTCLyWNORSXwNeAXS1LIZf9OcnDUjag+vYe+bExryHEKhpQqLVqJjxYVDlmVktoGymsekcgjqdfirq8NgOSzwoIccIKc4vDhwhCfY7u7nyE0ps0qJ+JGuEIWrfbqblW9oKTQ/GZxIybcY5A0dfdwPafPYRLuWteN6AOtRtJDqdJyuxdwwcy8oHuSbdmV3l1TIXlwR6dl7hWPGtMhVTblL+zoA3XujUpO/fDZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmiMemq9+HPD8xryEHvzL5nBko3hHRnm0z/qU8+WWSQ=;
 b=TlXhL5GbIQoE7rTm5/DcgY/7hGcnoEtjZ0e9+wtm9LVU6/uPmsvn+7ni7XDyxR2YcsT3ti1FgKLDk8U24pvsRm0xCt9W1Eq5xoFYAvyTF+XKZV0kBTTTM8yPYoMiem0RklwX3zvPi0Vfq/Y69bTwqDXg2/VRLDdfsNqABgnLd+UnOpWIplmikxByPPEa/jPnoE2hgUHnPsX7FG4tAdrjnUZvzLPjN4/GFz3hCPK49W6FVWz30bkUK4JV3uJ3XeLZ8QHFDhbZ7gKFJ/kgz3lsK49CfgWK5MTzeptI48SZH06wlAPp+zd2sDREyxqWnh5/Ozhzhu2AOfbit9WtCDDqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmiMemq9+HPD8xryEHvzL5nBko3hHRnm0z/qU8+WWSQ=;
 b=G3na3jU6td4/gQ/8wZztodnbrlk4hg9FWJEUK2Wgcv805iCHVIzwbxoACBobeRftHHorDo1DBmNrIq6LqFpAUuLv+7LdbDayH5qhRZDD2mDVthQ5856retYvrlM5jbfS0fqVkrYE6qvkBdHrWyrX/IkHflsKbUDbLXHK9psj1qw=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by PUZPR03MB6885.apcprd03.prod.outlook.com (2603:1096:301:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 01:27:21 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::73e8:e17b:e9df:f097]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::73e8:e17b:e9df:f097%6]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 01:27:21 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/6] Add and update some driver nodes for MT8186 SoC
Thread-Topic: [PATCH v5 0/6] Add and update some driver nodes for MT8186 SoC
Thread-Index: AQHZXfZBOEccF0ydkEaZvusRS4GWQq8qJJWA
Date:   Fri, 14 Apr 2023 01:27:20 +0000
Message-ID: <737fdde9ff9e1a4d3b77ab178d10262e7d20dfb1.camel@mediatek.com>
References: <20230324021258.15863-1-allen-kh.cheng@mediatek.com>
In-Reply-To: <20230324021258.15863-1-allen-kh.cheng@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|PUZPR03MB6885:EE_
x-ms-office365-filtering-correlation-id: 10b75b15-e4c5-48cd-6561-08db3c876478
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AhJxJ+GpAxMWpxPishCEjcmX7Bc+Wy8OKcKxzOj8wE8WzeNMKcygBvQ4681+Icy+xSKwPP3u07z5c3L36zZ3uz+jw9EeHBJJ425iiWLK8f0fH4eJ+rkzHHyYXV9G32lqrpFt/8mON2GMdSn63EGBgtVDIbv/TyWyAPQXG0Wo6JTJGLW/TyOka7sUN8KoPOCq/jnHC4uBba1Ik4iGVduiqxZmkraMd1tZ9j2BY3Iw341th3bGU+uCsJAb5vXB9Y52tHIy0jn117xaoLxlHukzeFXSQjRVwtQLcz+57KlZOpAVJzjqB2FnE3LJENNyBerbwBQx/DO0R5jqmelzQwT4IUzCmC5m2HEp9XSNFISDJeRpNzzdQlgraKLdT7L2ZZ9ckO5lgs+swD4IF3Ww0gLRfG33IAomj4Wnn6c/Z5B0552YKh62GXZLxCaefdLSF3MSuE96LwE9xUzmYMtofc/OpSBpYNa3UWJkGAW/nYv28FjdyzN0xcuDP+p1Znx2V3g0mz8M28ZUWZ4sXuR72QGwaB+HjAV7x/k20sz+s9PlaKPUcaDdEx1a3jCos6ZePaiFo8R7xukS5xt+hVW7np9fpLC0g6VVGMh6mHQzx33fpF/ht+pyzhckg1jep8AWax6V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(84970400001)(8676002)(122000001)(36756003)(5660300002)(38070700005)(38100700002)(316002)(85182001)(7416002)(64756008)(8936002)(86362001)(66556008)(66476007)(66446008)(66946007)(2906002)(41300700001)(4326008)(83380400001)(2616005)(6506007)(76116006)(54906003)(26005)(71200400001)(110136005)(6512007)(186003)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VldWWVJXcnN3eEhHeFlQTE01N0lnQTAxUmxQSTQ0NVZrV0llaWN4S3N0elJY?=
 =?utf-8?B?YWlFUmNPVW1TM051d1dZWnJIajNCY2R3WS9YVTBqZVdJRGlJdCtUTlZHeG5W?=
 =?utf-8?B?eEtvZWhjNXVjTHo1NEQ0SzJ5amR1U3JEdlplWStyWFAvMnBzSDdvYjFzOGly?=
 =?utf-8?B?N2JBWTk3aU5DR3N4K2hEVXV4YW5LYVEyWi9Qbm5WdDF5L29zc1JLNjdmWlRJ?=
 =?utf-8?B?MFlzVVVVQlVZVGdkejZKaWhCRHd2cjIrQUE1MzJaZDRyeExTSndJV3dnTktU?=
 =?utf-8?B?VVlFR0RzNlQ3eTZUd2hReFhvMmwxb2R5a012LzN2Y0JKQ09XTCtPcEpsRUZa?=
 =?utf-8?B?SHArOXFIWlF2UUZHYXlIZmtFZkg5TjJMQXpDblVwOW0xSGRuZmYxMjVmbjd1?=
 =?utf-8?B?VTM1TjhubmlZQUlTUG5MZWZKTUs0dWdWMms1Lzd1WFBXUUZwb05lQVppVXFX?=
 =?utf-8?B?MjJxMzJxSzlqT1AzWWpzWThYbGMwSW1YTHc3dVpnek5PL3NHT3RqRDNPTHk1?=
 =?utf-8?B?VC8waUdoajliS2tVTE9ZMGZ0Y0pVclUxajJSSlFjVStWR2dDbEdKaEYwdkJv?=
 =?utf-8?B?OHI3R2xXODRNRWVGb3RqMVZDT0tqS0c5MG5wR1JUb05uU3ZaNU1sY1B3L251?=
 =?utf-8?B?eklqbUs1Rmh5V2tmYXdZWnkyc1Q1empRcWw1U1F0MkVVTEliV3E3akJ6cDA2?=
 =?utf-8?B?WmJWK01MRG5QdEhEdUNNZkFFN001THV6ZThIMXpXSFVMU2ZzK0VRYm82dkRR?=
 =?utf-8?B?UTcvWS80eDZRSHIxdWFKUzEyRGQvNnZmSEc3VWd0anZVdXpHcXExVFhmdlNE?=
 =?utf-8?B?dThsck9DZ1FuSnY0Z0xGRTFuSEs3bU5ReVM4Y0szQWZ2bE1VdUovMHpGcFZp?=
 =?utf-8?B?OHlEU1JEcXNGbnBzSGxVMEdtT09lOEx3R1dqN2tpN2Y4NjdybGhhcWxFTHZK?=
 =?utf-8?B?MEgxUElGTWg3eW02Ym9IL0ZuOFhJSUdWY1YrT3dyR2drVmRtc1hrd1R3TUZm?=
 =?utf-8?B?R1lOOUE3Q2MxUWpKYXErSFgrbmo5eUdUWjR1cFpvVjU5TWwvcFpCblFtWk51?=
 =?utf-8?B?bXdMOXNPQkF4VWxtY3VYNDlmZDFwbmJhazhlT3AzRzZZNTRiRjYxWDZWc3RB?=
 =?utf-8?B?L3VHY015b01tdXdLd2xHRkRSNVNhM2lKTGFGYjVaRlIxRnNQTEQ5anB3R3hw?=
 =?utf-8?B?WkN3R0NkbkR4bVlGMHpiNDlhd3BVYk9HUnNUZnE0cTZMVjJTWEp3cFpnSjY4?=
 =?utf-8?B?eGJFc1VFY2NLVXozRkFybjk4Y2dSVExibjI2cFZLQjZZVk1mcHhzSGJ3cGNS?=
 =?utf-8?B?VlBoZ0drWmN4ekpvRlUvcVNYSGdzY3M4aXd2SU5tb250RS9ZV0tDL3U1U3Qw?=
 =?utf-8?B?Si9mWG9KTG9MQ1ROM05VODA4dmhjYXg3amdWL05JdnFzVlF2bC9WeFJrc2pw?=
 =?utf-8?B?RlBwT2tNOUhBMFVLT2Q2bkJyeEZnaWk3VG1jWEFBS2JVc1NMdWhQWEo2Nml3?=
 =?utf-8?B?UTF1aFg2a2UvdnlrSDJESTJmVUpnK2JyT1dKMmpEaGVkTUMwSGRmK2g5ak1x?=
 =?utf-8?B?RjBndmRxdithOHJDZng3bXZmb2RNbUdlLy9HbVU5NHF3UDVVaWVvYy9wWWhx?=
 =?utf-8?B?L3lVTUhZak5WNzRJWVRwWVRuc24yNmsxb3dxTEZXWHFYbGtjVlZnWExwQzV1?=
 =?utf-8?B?d0FlaUNzbUsxQ3Y0RGc3WjN2S2pJWE1FVU01d0Vid1VuUmNzM21UWGtOcEhF?=
 =?utf-8?B?c0F2SWE1amF5M2pPeFlRTEYxRUd5YVFueHZjUjlEby9PT1hXUnh1aVFXd3BO?=
 =?utf-8?B?eFhjU2dYV3BvUWxtRllZcVpMTi9vSWpVNGxPdTQ2djB4am9rSXA4MUpreXVV?=
 =?utf-8?B?OVF3ZG5SOUgxQ3VEUFFHOGtqckNRRDlaZjhyZjJ1UzNPUFlWSEtQTGxvWURJ?=
 =?utf-8?B?L1dRZW1nQjBJaEZDNmJKR2l4K2wyUm12STA1QnNZWDhqY2l0QTduNUVybFFL?=
 =?utf-8?B?b0NlRDIrTW9Eb1RrL3dVK1hFSXVEVk40SDF0NEtwV1hKelZFMGFXaGZ4Zm50?=
 =?utf-8?B?RkZVVWYwNVgwQmlTVDRTdjMwYUxpaVVreWpaeEFmS0IwMExFVmhBd0VJZGY0?=
 =?utf-8?B?QkZ6NGFaRE5xNlJEUjArMUIxcjNzL3ZDVTRDTVNCL3ZUbFB0R21PZERWMDMv?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B03E2850BAD944496396E7FFD7DF19E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b75b15-e4c5-48cd-6561-08db3c876478
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 01:27:20.6646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKWgdgBpHh6Fm6hMTdgfCrUvjW84ORM51v/GF3vueaoeUlj3PkxseNUrS37hZ4xDcGOrlvvpCqyLbaZpQ3au31nIsR1csR4Wl1GJDQDlIAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWF0dGhpYXMsDQoNClRoaXMgc2VyaWVzIGhhcyBiZWVuIHJldmlld2VkIGJ5IEFuZ2Vs
by4NCg0KQ2FuIHlvdSBwbGVhc2UgdGFrZSBhIGxvb2sgYW5kL29yIHBpY2sgaXQ/DQpNYW55IHRo
YW5rcyENCg0KQmVzdCBSZWdhcmRzLA0KQWxsZW4NCg0KT24gRnJpLCAyMDIzLTAzLTI0IGF0IDEw
OjEyICswODAwLCBBbGxlbi1LSCBDaGVuZyB3cm90ZToNCj4gVGhpcyBzZXJpZXMgaXMgYmFzZWQg
b24gbGludXggZm9yLW5leHQuDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHY0Og0KPiAgLSBjb21wcmVz
cyB0aGUgY29tcGF0aWJsZSBzdHJpbmdzIGZvciBkaXNwbGF5IG5vZGVzDQo+IA0KPiBDaGFuZ2Vz
IHNpbmNlIHYzOg0KPiAgLSBBZGQgaW5kZXggZm9yIG92bCBpbiBhbGlhc2VzDQo+IA0KPiBDaGFu
Z2VzIHNpbmNlIHYyOg0KPiAgLSBSZW1vdmUgc29tZSB1bm5lY2Vzc2FyeSBsaW5lYnJlYWtzIGZv
ciBzb21lIG5vZGVzDQo+ICAtIFVzZSBvbmUgbGluZSBmb3Igc29tZSBwcm9wZXJ0aWVzDQo+ICAt
IERyb3AgIkZpeCB0aGUgZmFsbGJhY2sgZm9yIG1lZGlhdGVrLCBtdDgxODYtZGlzcC1jY29yciIg
cGF0Y2gNCj4gICAgKHNpbmNlIHRoaXMgaXMgYXBwbGllZCBpbiBjaHVua3VhbmcuaHUvbGludXgu
Z2l0L2xvZy8/aD1tZWRpYXRlay0NCj4gZHJtLW5leHQpDQo+ICAtIFNlcGFyYXRlIEdDRSBpbnRv
IGFub3RoZXIgcGF0Y2gNCj4gIC0gRHJvcCBzb21lIHBhdGNoZXMgd2hpY2ggYXJlIGFwcGllZCBp
biBtYXR0aGlhcyBnaXRodWINCj4gDQo+IENoYW5nZXMgc2luY2UgdjE6DQo+ICAtIFJlbW92ZSB0
aGUgdW5uZWNlc3NhcnkgdHJhaWxpbmcgbnVtYmVyDQo+ICAtIEFkZCBhbGlhc2VzIGZvciBvdmwq
IGFuZCByZG1hKg0KPiANCj4gQWxsZW4tS0ggQ2hlbmcgKDYpOg0KPiAgIGFybTY0OiBkdHM6IG1l
ZGlhdGVrOiBtdDgxODY6IEFkZCBNVFUzIG5vZGVzDQo+ICAgZHQtYmluZGluZ3M6IHNwbWk6IHNw
bWktbXRrLXBtaWY6IERvY3VtZW50IG1lZGlhdGVrLG10ODE5NS1zcG1pIGFzDQo+ICAgICBmYWxs
YmFjayBvZiBtZWRpYXRlayxtdDgxODYtc3BtaQ0KPiAgIGFybTY0OiBkdHM6IG1lZGlhdGVrOiBt
dDgxODY6IEFkZCBTUE1JIG5vZGUNCj4gICBhcm02NDogZHRzOiBtZWRpYXRlazogbXQ4MTg2OiBB
ZGQgQURTUCBub2RlDQo+ICAgYXJtNjQ6IGR0czogbWVkaWF0ZWs6IG10ODE4NjogQWRkIEdDRSBu
b2RlDQo+ICAgYXJtNjQ6IGR0czogbWVkaWF0ZWs6IG10ODE4NjogQWRkIGRpc3BsYXkgbm9kZXMN
Cj4gDQo+ICAuLi4vYmluZGluZ3Mvc3BtaS9tdGssc3BtaS1tdGstcG1pZi55YW1sICAgICAgfCAg
MTEgKy0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTg2LmR0c2kgICAgICB8
IDIyNQ0KPiArKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjMzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0K
