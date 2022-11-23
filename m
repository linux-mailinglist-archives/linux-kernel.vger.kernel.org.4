Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75A0635A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbiKWKx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbiKWKx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:53:27 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D412F40D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:41:03 -0800 (PST)
X-UUID: 3ff3130dc70141658f3f10930a32c1bf-20221123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kTVa043mdrBZyCOVncXC6zLLYnNSvkJ+JcMYfNJCJfQ=;
        b=S4pfQdztOXoMPj3fGEfxmkYlGnLrpWJZPTWnxxYziluQkx3LS09a4hJ0FGHLJnrbScITouFMgUfMLE/ovZvG3hoc+yc0ikYh79rPJZkxk/+QQxJnZmkJcOth1dwvT9psJRCJdgNe8y3OxnD0qNPZi8f6ufJHkvpFXvkyh9mJSkY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:dd3a2a16-ac29-4848-8f85-331efa952ac2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.12,REQID:dd3a2a16-ac29-4848-8f85-331efa952ac2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:664c18f9-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:2211231820086JBZSXD3,BulkQuantity:6,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 3ff3130dc70141658f3f10930a32c1bf-20221123
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 934488538; Wed, 23 Nov 2022 18:40:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 23 Nov 2022 18:40:55 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 23 Nov 2022 18:40:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9PG2DFUTGrPV4gHlzjGLH8dXdEGH1jD23nrZPkcVZoKBIZGwFx1JyPMqIUOAyaOnCiFA8AK9isZGp5tyPghF+TCviQO/h7w1eqgYxjzZn6ukEGS6ZSG69kpc7qlW7nyfmCUB9BX6usG583x1tv60JwuvUwKeHrokncAJa6S6yxoaytirhCXHVE7fbQySEZ9yoBYTdlq1i8rEZabVxQBIa6howgbVg++b4u4Sh43PDNRdG8zInQSioA5jjN1qMd2OksoDn6Ydt15qi3TIaJGtuus5+6CIJuR0sPYq3Ep7n7iLdCziP6fnV3xptrLwKL84LYxKvr3GJ1LTYFjlYW/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTVa043mdrBZyCOVncXC6zLLYnNSvkJ+JcMYfNJCJfQ=;
 b=V8w39MyQKGO6GI2+XylEMedXqy4qGkyBNFNHUl9ZFor9CzsO3a+injYmKEIwyE0/6DXIRFLTkIeEubnALrxRSfRXDXaZMqzfFN5I3e7Q6D3CBEKDT6a+9cW5ZOChbOJsTVin3RGcPZhQ3kzzsjdPct/Hz48v/wLsPg4COkPoOB3FxicQCT8BaHiapbsMbL3wjPc0svNNY8F1qaSmHpAFUhN/fPA7st01xK+qnyd4dazAbokjzhgxAWOdUDwH20oREXycQC6STL67wifhquxGPQsBYOzvK9Z41W75YBIgXeiKMBvB2OpS86DiJQ1ghu6LINjuydrxXspwKGTXPxS1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTVa043mdrBZyCOVncXC6zLLYnNSvkJ+JcMYfNJCJfQ=;
 b=IBXyiJKUMBcpNjhESSWUhc504xt2wiSMKnAv1qw0YAPS97hVztyYNQnYs8bJ5C0tsyDlfLBydm5204PKIUrutvgiDJLeS+dcYZAjLUL+pGttiWoPi0g7n9DXxzB/N7AtZ32ET9nQU/tlxVR8qd/TnWe8o2E/eVSRx3uQJz3uYxI=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by TYZPR03MB5630.apcprd03.prod.outlook.com (2603:1096:400:58::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 10:40:54 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::a302:d5da:f54f:a75d]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::a302:d5da:f54f:a75d%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 10:40:53 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1] soc: mediatek: mtk-pm-domains: Allow mt8186 ADSP
 default power on
Thread-Topic: [PATCH v1] soc: mediatek: mtk-pm-domains: Allow mt8186 ADSP
 default power on
Thread-Index: AQHY3g/idaSasqXP7E+kkGotWaHzpK5MjisAgAAF0gA=
Date:   Wed, 23 Nov 2022 10:40:53 +0000
Message-ID: <d4856589cdbb8ba31d5139604abffa4a06c5c73b.camel@mediatek.com>
References: <20221012075434.30009-1-tinghan.shen@mediatek.com>
         <ce1c6a1a-9183-e56d-6757-947f5fc8133d@gmail.com>
In-Reply-To: <ce1c6a1a-9183-e56d-6757-947f5fc8133d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|TYZPR03MB5630:EE_
x-ms-office365-filtering-correlation-id: 29806437-93bd-4aa6-9120-08dacd3f322b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OI1nG5AZ6A+UVoGLwKr9pOi/u6A3ynhltu2JKOoOLQD71+lu3qndD0z0+VE2Ki7rDy0TfBYWpZCOvHqSUxMqsSLIPyNgNcX0JZShCSpyKiDPxl7AUe/O0t2SO5opoBrf9TkVdlYcIfZ0ONTd3G51Ovl2fsPDUQCfB13Y8XDPdXZIYUq42VTWfEmK/mohRnK1UnDwBLozyzjFEe90El1PtlVjFd4uPK+QsY+5jq1o2gEFICX/mvEjBk5SG+lWYYrXPQrlZry03yF1M8Rhfq5fXNmx6rzLdvEUwH86YRr5G4jVGqskEZ8fl+8YL7aAUDQp16UpQWH5rkQqufEJufqOnS6UOPvDnBsDm6dpx05ketvOQxXQZvDgSPlJXANPN3wicRr8byANLAOF/rSDM5G0be+IcoiSeGAwLmMObbe1JTVpr+DZ0FrDfIZabJKtK7btDAexJPFxh3o4x/XPBes+dbPT/Y3+9BxY7XAyvbZkDZBAXKQwZ+Nwcw5alvIIMXDnALajJRFkRud8BNAAJv9enUWIHFjXLo47p67qUdKM13Ys5nXg/LaI2rW7RsyZtwl+5zwowNX50ml9MuKuJlogf3WU8mzmZWepVacLrApmV4yI8BNux7fXzKQ6/S0jciEEe31jeYoVRwVvOjDDOb4V77J4Nx9NIfes7qqlnYOKUDmrfnXtKfBTy1a/ahlyXDvTF0mADkbq3wUqXkfhpcGSeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(26005)(6506007)(6512007)(83380400001)(53546011)(186003)(2616005)(86362001)(36756003)(122000001)(38100700002)(85182001)(38070700005)(107886003)(4001150100001)(2906002)(66476007)(6916009)(316002)(54906003)(4326008)(8676002)(66946007)(5660300002)(66556008)(66446008)(64756008)(41300700001)(91956017)(8936002)(76116006)(478600001)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXhUSW15QlVkZEhML3pzZkpNV0x4YkM2cHFYUjh0QjY1VTVSaXpMdVh1Ykpt?=
 =?utf-8?B?SHlETk5JZ3BMMDg5NldrVkNlZm9QUktqcnA1dHZTRVRaMUkyQjBSdGdUWnNl?=
 =?utf-8?B?emdvT0tpV1RFZ00vcjBaYXg0dzhqWkUyUzQ1MnlGNDBEbWtBcEd4YlFPSlZ0?=
 =?utf-8?B?cjN3UDFUTC9LQXFleUhRUW11SytSSHcvandCdXJVYytwTlNvNS9FSzU5bW5X?=
 =?utf-8?B?bWIwSkduV1pzMGtLc1BDNXVUUTVCaTB0RXJsa1VQNk1SNkZHczFFVjNid3lS?=
 =?utf-8?B?aC9JdUJWNmozNzQ4RVFjbVFncDZhemRCS3RRdmp2S0NuNThwbjUwZXhXZXh0?=
 =?utf-8?B?OFh4NHJSZW5ZaHltN1RINUZxeWRWOUtoQVFKdXNzRXJheHBISHh5MW5YVTVs?=
 =?utf-8?B?aFJJaUlDQ2JacHFmNW1ScXZOa2pOMTB6QkxXQ3QzRm5HdHRpQjlzV1lvNlVY?=
 =?utf-8?B?ZjcwYlhhRFllTmJHU2dzUE5NSjRKdVJ1Zm8vZFduUzFRVUxTSnptTzVkUnNE?=
 =?utf-8?B?UERkY1VQejBhYzJnaHFubFpEUDZoMEpqZWdoV1d3VW1IbDVJU28vM29Qc252?=
 =?utf-8?B?bHlRa24yeUMwNy9Tei9hQ1RDREdZbkwxU0xaVkJ4clNOSTc1SXdRcXlIZE8w?=
 =?utf-8?B?SEVGY3hRWTUvYXJjNmxaTS96Q3piS0dzZEJ3MlYzOTNNVG90bWhsT0JOZWEv?=
 =?utf-8?B?djR6WjIxZmtDTnpZUFBYZkpHc0dkYTI2bWFHRVBjeU9iVHo3SmY1OW43N29V?=
 =?utf-8?B?Zi9xeTJsWGFKeWhlM1J6RjJXWEx6TWk4ZXRyL1RYVHVtQXcvTmVGTzRGREdI?=
 =?utf-8?B?SVhISlhSR3pLay9IZkFYUk9ZRFQ5OVlTMCtTc1p0SmVZWFlsa1pTT3JYMFhr?=
 =?utf-8?B?VUVwejlRek9HZHRjY3RBRGlibVBnelNxMUZQYzkxckludkIvc0Ftc3Y5WlRj?=
 =?utf-8?B?NC9Kb2s0VFBocmt3YWhidjlhNUpkbXBPWERLQW9Pbkpaa1p3U20rYWNkaTJS?=
 =?utf-8?B?T1hCNTQ2UnlBd1RMakhoZEZ0cEFmVzJodzRseVRvRHlNeTl3MUErT1FiQUtG?=
 =?utf-8?B?YnpER0ZMMVYxbzZiTWFOcTlCMUM3UFhnVVE5NVZmUjVvYlJjcVpmenJ4Z1VO?=
 =?utf-8?B?VVZHRXJtUm1EM1NpVnFPRUJZOVYwTWlNUVdyS1VRbDljdE5hNW84U0RHUXla?=
 =?utf-8?B?ejdhNXFoZ3Z0WTRJSlpYQjBFQUxrSEk0NVcralRxQU5pVjFSczNEN2Q1VDRZ?=
 =?utf-8?B?S0FIU2FnMEFSNWYvUElaYTdTeFk0bFJDd29oV1NwYjR5aSs5Q2xKL3BlYU9m?=
 =?utf-8?B?V2M2MDlLYXF1N2pLMDFUZTFGWkFlWXBOdnRieFhQVmFJWVEvcFgzbHJjMVYx?=
 =?utf-8?B?R3k4REhienJFQkJlSjA0NW9YQ3pURk5qL3hGZlV3UE9UWVh5NjF5V3Z4dWN1?=
 =?utf-8?B?cExjaTFVQUxxSGU5NEtxMnFOc1E5cGR3R280K3N0aVRJTmlaOUNuUC8wMXBp?=
 =?utf-8?B?TDNxdXhhSEhDYmZyWGI5M0ExM3NPb2wxZWY2bTFSL3ZhT2o3QnFVZkgzV25j?=
 =?utf-8?B?SEoySytvaUtnWDlxOG05NmRVeXIyR2kxcnJVNDR0TEtMRHBJNndNYmhiYWpU?=
 =?utf-8?B?eUJQZDUyWCtPSmRENk5FclNNQ1Q3K00wb0dUSWZxTE1DQ1MzbVRocVdFMjlj?=
 =?utf-8?B?c3dOdXVBMlZnaGlJb3VCUTdqcnFwUzBCc09nVFAzblB3NjNtT09oZ3FCVmg2?=
 =?utf-8?B?RXhNcUpqUmRUSlFMZ1cyZEV6OHY4M0hDTWJEQUxJSUtZWjBQaHBOZy9WZjdk?=
 =?utf-8?B?QkpOVGFJUzROT3BkM0prdFRmeUhEUGZWZlhLVDJHMURkTFBYWjJZbWwwVFJz?=
 =?utf-8?B?VzZrM2Z5OUxoVVFUc3ZaSUYvNWoyUUpuZ3oyYnRiQUFuTjQwVnUvb3JReHBm?=
 =?utf-8?B?NldqR093TUx5YVVjVUdSZUhHanVPUnVjeGhlZnpyem42WUgraHl3Rm10OFRH?=
 =?utf-8?B?YmNsQ3htOVBoU0JIM2pxcEk1cHRZM2dvZ2VJSktRalhmV01HQU5sRDJaeDZy?=
 =?utf-8?B?U0RJcWVWSWdoM1FjcWxWTUZsdUtNMjFiQk9xNUpwbkxiZEs2bDE3MjVhSllX?=
 =?utf-8?B?MmVMNmdhbDBQeURhTHFOU1E0TTdTNk1mc3NZT2pHN2grVU5hVlNZM3pjcCtP?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23087A07487CD645BC656FFDD5968FDD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29806437-93bd-4aa6-9120-08dacd3f322b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 10:40:53.4539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtwEjQUKrdm0rNdsqG3V4hzXaf+AOzOCvZjrKfl3wY6wStUrV4AaPJEjIyG/7B/tlzHEMtZh/phIIj9/KqTkDSTgpK2xKbLk1/Zo6RcR7os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5630
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTIzIGF0IDExOjIwICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTIvMTAvMjAyMiAwOTo1NCwgVGluZ2hhbiBTaGVuIHdyb3RlOg0KPiA+IElu
IHRoZSB1c2UgY2FzZSBvZiBjb25maWd1cmluZyB0aGUgYWNjZXNzIHBlcm1pc3Npb25zIG9mIHRo
ZSBBRFNQIGNvcmUsDQo+ID4gdGhlIG10ODE4NiBTb0MgQURTUCBwb3dlciB3aWxsIGJlIHN3aXRj
aGVkIG9uIGluIHRoZSBib290bG9hZGVyIGJlY2F1c2UNCj4gPiB0aGUgcGVybWlzc2lvbiBjb250
cm9sIHJlZ2lzdGVycyBhcmUgbG9jYXRlZCBpbiB0aGUgQURTUCBzdWJzeXMuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogVGluZ2hhbiBTaGVuIDx0aW5naGFuLnNoZW5AbWVkaWF0ZWsuY29tPg0K
PiANCj4gRG8gd2UgbmVlZCBhIGZpeGVzIHRhZyBoZXJlPw0KPiBNeSBiZXQgaXM6DQo+IEZpeGVz
OiA4ODU5MGNiYzE3MDMgKCJzb2M6IG1lZGlhdGVrOiBwbS1kb21haW5zOiBBZGQgc3VwcG9ydCBm
b3IgbXQ4MTg2IikNCj4gDQo+IE9yIGlzIHRoaXMgbm90IHlldCBhIHByb2JsZW0gYnV0IG5lZWRl
ZCB0byBiZSBhYmxlIHRvIGltcGxlbWVudCBhY2Nlc3MgDQo+IHBlcm1pc3Npb24gY29uZmlndXJh
dGlvbiBpbiB0aGUgQURTUCBkcml2ZXI/DQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KDQpU
aGlzIHBhdGNoIGlzIG5lZWRlZCB0byBmaXggYSB3YXJuaW5nIHdoZW4gaW1wbGVtZW50aW5nIHRo
ZSBBRFNQIGFjY2VzcyBwZXJtaXNzaW9uIGNvbmZpZ3VyYXRpb24gaW4gcHJlbG9hZGVyLg0KDQoJ
WyAgICAwLjMzNDE1NF0gbXRrLXBvd2VyLWNvbnRyb2xsZXIgMTAwMDYwMDAuc3lzY29uOnBvd2Vy
LWNvbnRyb2xsZXI6IC9zb2Mvc3lzY29uQDEwMDA2MDAwL3Bvd2VyLWNvbnRyb2xsZXIvcG93ZXIt
ZG9tYWluQDE4L3Bvd2VyLWRvbWFpbkAxOS9wb3dlci1kb21haW5AMjA6IEEgZGVmYXVsdCBvZmYg
cG93ZXIgZG9tYWluIGhhcyBiZWVuDQpPTg0KCVsgICAgMC4zMzQyNDZdIC0tLS0tLS0tLS0tLVsg
Y3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KCVsgICAgMC4zMzQyNTJdIHRvcF9hZHNwX2J1cyBhbHJl
YWR5IGRpc2FibGVkDQoJWyAgICAwLjMzNDI3NF0gV0FSTklORzogQ1BVOiA1IFBJRDogMTEzIGF0
IGRyaXZlcnMvY2xrL2Nsay5jOjk2OSBjbGtfY29yZV9kaXNhYmxlKzB4OTAvMHhiMA0KDQpJZiBu
b3QgZm9yIHRoaXMgY2FzZSwgdGhlIHBtLWRvbWFpbiB3b3JrcyBmaW5lLg0KDQoNCkJlc3QgcmVn
YXJkcywNClRpbmdIYW4NCg0KPiANCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc29jL21lZGlhdGVr
L210ODE4Ni1wbS1kb21haW5zLmggfCA0ICstLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXQ4MTg2LXBtLWRvbWFpbnMuaCBiL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ODE4Ni1wbS1kb21haW5zLmgNCj4gPiBpbmRleCAxMDhhZjYxODU0YTMuLmZjZTg2Zjc5YzUw
NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdDgxODYtcG0tZG9tYWlu
cy5oDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXQ4MTg2LXBtLWRvbWFpbnMuaA0K
PiA+IEBAIC0zMDQsNyArMzA0LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzY3BzeXNfZG9tYWlu
X2RhdGEgc2Nwc3lzX2RvbWFpbl9kYXRhX210ODE4NltdID0gew0KPiA+ICAgCQkuY3RsX29mZnMg
PSAweDlGQywNCj4gPiAgIAkJLnB3cl9zdGFfb2ZmcyA9IDB4MTZDLA0KPiA+ICAgCQkucHdyX3N0
YTJuZF9vZmZzID0gMHgxNzAsDQo+ID4gLQkJLmNhcHMgPSBNVEtfU0NQRF9LRUVQX0RFRkFVTFRf
T0ZGLA0KPiA+ICAgCX0sDQo+ID4gICAJW01UODE4Nl9QT1dFUl9ET01BSU5fQURTUF9JTkZSQV0g
PSB7DQo+ID4gICAJCS5uYW1lID0gImFkc3BfaW5mcmEiLA0KPiA+IEBAIC0zMTIsNyArMzExLDYg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzY3BzeXNfZG9tYWluX2RhdGEgc2Nwc3lzX2RvbWFpbl9k
YXRhX210ODE4NltdID0gew0KPiA+ICAgCQkuY3RsX29mZnMgPSAweDlGOCwNCj4gPiAgIAkJLnB3
cl9zdGFfb2ZmcyA9IDB4MTZDLA0KPiA+ICAgCQkucHdyX3N0YTJuZF9vZmZzID0gMHgxNzAsDQo+
ID4gLQkJLmNhcHMgPSBNVEtfU0NQRF9LRUVQX0RFRkFVTFRfT0ZGLA0KPiA+ICAgCX0sDQo+ID4g
ICAJW01UODE4Nl9QT1dFUl9ET01BSU5fQURTUF9UT1BdID0gew0KPiA+ICAgCQkubmFtZSA9ICJh
ZHNwX3RvcCIsDQo+ID4gQEAgLTMzMiw3ICszMzAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNj
cHN5c19kb21haW5fZGF0YSBzY3BzeXNfZG9tYWluX2RhdGFfbXQ4MTg2W10gPSB7DQo+ID4gICAJ
CQkJTVQ4MTg2X1RPUF9BWElfUFJPVF9FTl8zX0NMUiwNCj4gPiAgIAkJCQlNVDgxODZfVE9QX0FY
SV9QUk9UX0VOXzNfU1RBKSwNCj4gPiAgIAkJfSwNCj4gPiAtCQkuY2FwcyA9IE1US19TQ1BEX1NS
QU1fSVNPIHwgTVRLX1NDUERfS0VFUF9ERUZBVUxUX09GRiB8IE1US19TQ1BEX0FDVElWRV9XQUtF
VVAsDQo+ID4gKwkJLmNhcHMgPSBNVEtfU0NQRF9TUkFNX0lTTyB8IE1US19TQ1BEX0FDVElWRV9X
QUtFVVAsDQo+ID4gICAJfSwNCj4gPiAgIH07DQo+ID4gICANCg0KDQo=
