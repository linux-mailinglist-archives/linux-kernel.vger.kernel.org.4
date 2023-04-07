Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A76DA9B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbjDGIEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDGID6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:03:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CD149CA;
        Fri,  7 Apr 2023 01:03:56 -0700 (PDT)
X-UUID: ba92ba14d51a11edb6b9f13eb10bd0fe-20230407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ira432C++HDRBNOLh9S18gjSYIXGsdcDWcU/E1zXyeg=;
        b=uB5TC84Wd6gC3SiX1keSP3oe5cVq9lzHKYQnzerzHxRRKd5TwADbluJN2NSjXXT4RAjQAfbEkOF6uNVMNIc6wZ6FSlr8c7erW1R+DDvreqmLFLOKTByzKImmf4JbOXbKrGU+5NbrEoGSaQpZsxqixU8C2XLH3x4ejKZBP1D4XnI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:3211ce51-0efe-441a-b7d6-0ddf060a72bf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:e17680b5-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: ba92ba14d51a11edb6b9f13eb10bd0fe-20230407
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1216706115; Fri, 07 Apr 2023 16:03:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 7 Apr 2023 16:03:48 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 7 Apr 2023 16:03:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXhOpmMEI9S5tK94v6nSi3ufcbZfqiPAx6/RhYfqFbi1MghQjERPbH90wrchGl4zBBm8LaGhFEFIK5/ivW7ga70mQWl2fJFgxeFVk/7bJjnwRSIwFN/ngZeYUawpdIfP9v/2cikCQCISUqXJeiBEq7vIkg4joOo445Tldj78e6S0w8QQ0TR9yqys2/IPdHflTH3ffLrQiAG7nzmwb9pkCqY2n26Xag6nU+ZsB4szxDQIOMS1822JW+Ml5RQinbYO81ML1QMEo/1tAWN7LeAG3ikNt+2L7iYSSorICHcSTnjk9GkmBWRvIrY1sHZlwDOOr20s9X3TEQaE9CI6FgI01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ira432C++HDRBNOLh9S18gjSYIXGsdcDWcU/E1zXyeg=;
 b=mi5siOcc8UCSp6flWfZpSGyskquRGhYnm3+9Z9UntbdRUSBsDaQITWponZx0rtmyvG3vLzv0lnw8gN3Mq7wL4c6c5PFLfJ331uq9ebL76bbxXqGQy894x+XOS/1ITTXgR8YK4nY1oILmpz6vtIMXFgfHxjvfFE4QH2eDLNz9FCHS8ugs1nFA29J87ObV0PZ/K43/0IwWIJszalwNvmdpqB8GiD7kG85zOXrm8herVpwSPL4KNbWt/cXN3KbR8lPKXb1faJoLVJ+jTuz+U8kIPOEoSG8R4ZVwXYSKtCtfhDbkedz70s1lZIkBNHFED2WLSjg4scJbY6DNYtlW1ui2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ira432C++HDRBNOLh9S18gjSYIXGsdcDWcU/E1zXyeg=;
 b=Qevnnh/D8WpgDb8vOz+wG3Wg0PfsC18pu8v4LcmWt7t3ymDIxH3Hox+z5cBex2S8Ic7jfWWjwB9y9oUQAHKFs+68h394dWKnP052ys7jMS+fBiuSwAmpWiO/WtaDYcPyv1md0qnTwdvCj+1OKuov5PuvF4r4WkGrrd8VC8E2vho=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by SG2PR03MB6778.apcprd03.prod.outlook.com (2603:1096:4:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Fri, 7 Apr
 2023 08:03:46 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::82b9:eab9:b4e3:8464]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::82b9:eab9:b4e3:8464%7]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 08:03:46 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        =?utf-8?B?VGlhbnBpbmcgRmFuZyAo5pa55aSp5bmzKQ==?= 
        <Tianping.Fang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 6/7] dt-bindings: usb: mtu3: add two optional clocks
Thread-Topic: [PATCH 6/7] dt-bindings: usb: mtu3: add two optional clocks
Thread-Index: AQHZZddnDMQICoi21kuPApRSIlQyE68bK0oAgARX+oA=
Date:   Fri, 7 Apr 2023 08:03:46 +0000
Message-ID: <f79700441eddb291d97ee84d89e56e3537c3e0f0.camel@mediatek.com>
References: <20230403025230.25035-1-chunfeng.yun@mediatek.com>
         <20230403025230.25035-6-chunfeng.yun@mediatek.com>
         <20230404134350.GA3782583-robh@kernel.org>
In-Reply-To: <20230404134350.GA3782583-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|SG2PR03MB6778:EE_
x-ms-office365-filtering-correlation-id: 411f31bd-a585-4b75-9a4b-08db373e9cd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aw0cPNamXJ4BeKfpmDyc6tLMYMaDLh+HeR1q/ww8SO3QWmPEwo7juVnTvAAGQmDfPplSfefqx7i95a+GlHor5wGYfhg3V8b9iQ9TyqUPJCUrpeRbIGkcGp9KqMRJFGKbBXS1zj0zxXGNgkoN10y0QXVIzOZznHoizD1yqBFvux0VDd/EV5zPQmcs+lmAgt0Jz0K32i7jctOxK7x7X6r3lvhU+hgm1ZhQMIC5lIEPCQu1fJNbsPhsopglNwhnUQDhny98PqUkPNoma+uUy5+UY0qej8l2uUgmOZE9iMTtPmtUEW0l++ErR9JvEuB3+pYXvFdQ/phw/GYuBCMRY5sO+/ta8okMtAK5PBcopyxQyHPNlGmfTzT54adC4WXQ3OJufHjSh7K7C6odaDDn9sqBrw6oo0W3NbF5+ghG9cSAw9GqwB3xxEMmmpSEzUHtGY8n7FRnOaTFfnQPrJrC/cXPZX/oFxQQVUrWge5jcmlqwHWu0ofK41PcT/L5cyWkMTvNawLiwNVO4FYSg7sfNJYG4CPtud5XAnNDElJ94IjiFU81wF+jYfNzeVE9D7mQVpB+RdjQ5taKUg0fXct14T6M1m5b5a2aKDfryDeiiCaFdccG42DTXmt6AVp1To9VEaB/BDWIIQvEq9asWxK2XIGOVuRdc3KRXfJL3rB2shIk7K0JDPn9Y0aQRcQa5pa3EhCg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199021)(41300700001)(8936002)(8676002)(7416002)(6486002)(85182001)(36756003)(91956017)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(2906002)(6916009)(316002)(54906003)(2616005)(478600001)(26005)(71200400001)(83380400001)(86362001)(186003)(38100700002)(122000001)(38070700005)(6506007)(5660300002)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU5vd1J1MjI3ZzRvQzV0ZHQyNEFCbC9UMkxYVFBwNUZOZ21PUStaMTYxbjZK?=
 =?utf-8?B?dzNEK0RaaTJVa1pZL242YTArVjcrWlF0aitOWWdzTldCUVFRMW0vRVh3N2Jh?=
 =?utf-8?B?dEcvZEI2bUsxR3FnblBONDF1RXBqWmV6RDRScWIzNFgvczMzdi9hMTdJQnVa?=
 =?utf-8?B?ZTZDVEs1TW0wSjRBVWtBbTZtSHl6eEZyQkMwMlB5ZXI3K0ZCaU5qY3BaV3cw?=
 =?utf-8?B?ekhUcmxnNTlVU0ErVjBncEt3QWFtZjJtTGNHdnNMRkRjWWpiUThKWVZBVm1O?=
 =?utf-8?B?cGtPUytOOWxpMmZCbTlGcUM0ckVPdVVaZFM2QTlaNFliVnZHd2MxM2pRb0Ir?=
 =?utf-8?B?UkZpVVpscXVxVzJTamFIbUZwS0NIbklVTzNqaFd1MHIxd283NWdHb25mbEk1?=
 =?utf-8?B?ckVra2x5NjRLUHJxMmFhN2R0SFRwQW5GZkhGcW16Z2JVOFpmZnhaSHFMNG0x?=
 =?utf-8?B?dkQ3eGtoTDd3VVJWOHBRVW5MUi9nZUFTSEVkM21nRUdNWVAvbzgrWjE4UFRx?=
 =?utf-8?B?UWRHZWJXaUVybVM3LzkzNnNZdWhLRWc4UnpoSTY2U1VycVlPYmd4M1ZvMkd3?=
 =?utf-8?B?eURBallNRFFZZkx1OXNnekhrZFFUczJldjhyZmNkVld6NXhWSXB1elp2TVFy?=
 =?utf-8?B?eUNwTGJSREJQbk9HQTd5NUhWQVlGYnlsN3kyQ2tqemw1NTVlT1FaSzV2V2E4?=
 =?utf-8?B?cHpPamQxcjNpOERqR2FpcnFrdUMrdlhFQURMU3BqSnM1cVZSVUNqa1VUMFlI?=
 =?utf-8?B?M3h0T1gzWWtuS0xieEJXY291SHhST2w1WjJScDJ4Q3IxQnVST0RveDZoLzc4?=
 =?utf-8?B?WWxoMHFwMldoL1NDU0tEMmJmd2lNTmZod1F4Q1djUXlEeWlMMlQ0TXBSWkhl?=
 =?utf-8?B?THdIRkc1anVOTFZad3ZkWDViamJBM3N1aEVaM0Ryb2JWeEdEOWhsWWVvTGIv?=
 =?utf-8?B?RE1RM0w5TUU0WGpJcHZDY3djN0NFSnA2bFl2WWFHT1ZmNlI4SEpBeVFxVEE1?=
 =?utf-8?B?UHhhRnhpbVl5TVlscC9ZODZCZFEvMjBZNTVVQVkrNGxuQS9aSlpDTGE0b0dm?=
 =?utf-8?B?N0JuWExaU3V1N0RIVXpDOWlsWHNhS2IxcndBY1hxdGU2OHYrZzR6NzFlczRS?=
 =?utf-8?B?UXFFSHY2OVQvWGVMWXJURXpPQ1JHcURoMmlBT2dPWXBEQzNTZDhJVHo5cXpI?=
 =?utf-8?B?cVlNU2g1dG9zV09BVWRVdDlpNU8yZHg1dndkczdLOXhZMzRoY3h0eHVKVVl0?=
 =?utf-8?B?R1lIMGVvb041UVVOUk4xWlVrSlliTFVHQWo0Y3BZa2VmNTFjMWwzeDYzZlJU?=
 =?utf-8?B?ZWowQXQzT3QyUUZnZTY5QlR5RHR4TXZBYlA4Y3ZLQWdxWFZsU3FzOS81NVln?=
 =?utf-8?B?eTlHRDNLci9SQTB2T2tsbWxueHlML3Ewb0tKM1FCWHRGc0VTMzZldWFCRzFE?=
 =?utf-8?B?bHJWaUlzdHZra0ZmTys3MW5pZzdZUC83UWdxMGsvUkk1VGFGTmc2UGJOQUNw?=
 =?utf-8?B?Y21IVStSSG5EZ2I1bzZlRk9NSlpBaTE3TU9BaVZZWW9SWGdoSi9uV0Q5cnZ3?=
 =?utf-8?B?RUl5V1Q1andhWURBaTFHMVRGK1VLSWVoZzJwZWxORVJzenZXUWRLdzhsMjg4?=
 =?utf-8?B?M21KVTlzdDFVWWJETWdBTlc0OE91SlB2WjRuRXh0UENQQUFkdi92SHJnYWpU?=
 =?utf-8?B?QTBmRFpVUC9QZGFzWThXeE5qVnYzUllIWHZUck9qVGVicTR3UVZEQkJJaW1s?=
 =?utf-8?B?ajBUcXZzcGJ2RkdaR0V0cHRTL05pTzNlbUlmanU2L0ttRVZzMU5hT2VFcHBK?=
 =?utf-8?B?Y1QvZXB2RXovanlPUkdEc2tHMXRSdmFiTzlmRHR6Tk8yS0tHMnVOSy9rS0xZ?=
 =?utf-8?B?d2xaeW5QTXJZSXJPSzJmV1RpOHFCMUZ0N2t2eFI3clJTVGpRc0NmRkh5UEtz?=
 =?utf-8?B?UVB1OTJHbXBzSHYzaDl3cmhQMnVvQUJXMy9kTDd1MFlCSTU0eURnd21aKyt4?=
 =?utf-8?B?ai9wQXg2cTF3dm5TYU96TTNORnhUZzFXYS85cVl0UnI5TmxRY001RFBjSkpu?=
 =?utf-8?B?aXVBNENYa2M2T2JQTS9mb0pITGFKckpkcnFvZ3F5eDdxN1Uwb2dHTThCMGJo?=
 =?utf-8?B?SjlOQXlDazYzNzBaSTN2OGVXZVFTYWdsYkxpcDdIY3UrSmdxZUpUMHZqNE1E?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E3A2BE106AE72458A442B39FD0C2DE3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411f31bd-a585-4b75-9a4b-08db373e9cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 08:03:46.1771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAWf4wx5ndOX/E+3ItRRQUu74YpFlnWphAxD2VKfAR+V+hTgMZ+4H40fWw31AnJuVEFdVxmzPoOcG91xz2z27oE7nBCyI0aNPVIRu18Zl5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6778
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA0LTA0IGF0IDA4OjQzIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiBNb24sIEFwciAwMywgMjAyMyBhdCAxMDo1MjoyOUFNICswODAwLCBD
aHVuZmVuZyBZdW4gd3JvdGU6DQo+ID4gQWRkIG9wdGlvbmFsIGNsb2NrICd4aGNpX2NrJyBhbmQg
J2ZybWNudF9jayc7DQo+ID4gQWRkIG9wdGlvbmFsIHByb3BlcnR5ICJhc3NpZ25lZC1jbG9jayIg
YW5kICJhc3NpZ25lZC1jbG9jay0NCj4gPiBwYXJlbnRzIjsNCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+
ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdHUzLnlhbWwgICAgICAg
fCAxMg0KPiA+ICsrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXR1My55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbA0KPiA+IGluZGV4IGQyNjU1
MTczZTEwOC4uNTBjMTVmMmNlMTRkIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXR1My55YW1sDQo+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdHUzLnlhbWwNCj4gPiBA
QCAtNjYsNiArNjYsOCBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBS
ZWZlcmVuY2UgY2xvY2sgdXNlZCBieSBsb3cgcG93ZXIgbW9kZSBldGMNCj4gPiAgICAgICAgLSBk
ZXNjcmlwdGlvbjogTWN1IGJ1cyBjbG9jayBmb3IgcmVnaXN0ZXIgYWNjZXNzDQo+ID4gICAgICAg
IC0gZGVzY3JpcHRpb246IERNQSBidXMgY2xvY2sgZm9yIGRhdGEgdHJhbnNmZXINCj4gPiArICAg
ICAgLSBkZXNjcmlwdGlvbjogRFJEIGNvbnRyb2xsZXIgY2xvY2sNCj4gPiArICAgICAgLSBkZXNj
cmlwdGlvbjogRnJhbWUgY291bnQgY2xvY2sNCj4gPiANCj4gPiAgICBjbG9jay1uYW1lczoNCj4g
PiAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gQEAgLTc0LDYgKzc2LDE2IEBAIHByb3BlcnRpZXM6DQo+
ID4gICAgICAgIC0gY29uc3Q6IHJlZl9jaw0KPiA+ICAgICAgICAtIGNvbnN0OiBtY3VfY2sNCj4g
PiAgICAgICAgLSBjb25zdDogZG1hX2NrDQo+ID4gKyAgICAgIC0gY29uc3Q6IHhoY2lfY2sNCj4g
PiArICAgICAgLSBjb25zdDogZnJtY250X2NrDQo+ID4gKw0KPiA+ICsgIGFzc2lnbmVkLWNsb2Nr
czoNCj4gPiArICAgIG1pbkl0ZW1zOiAxDQo+ID4gKyAgICBtYXhJdGVtczogNg0KPiA+ICsNCj4g
PiArICBhc3NpZ25lZC1jbG9jay1wYXJlbnRzOg0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiAr
ICAgIG1heEl0ZW1zOiA2DQo+IA0KPiBZb3UgZG9uJ3QgbmVlZCB0byBpbmNsdWRlIGFzc2lnbmVk
LWNsb2NrcyBwcm9wZXJ0aWVzLiBUaGV5IGFyZQ0KPiBpbXBsaWNpdGx5IGFsbG93ZWQgKHdoZW4g
Y2xvY2tzIGlzIHByZXNlbnQpLg0KR290IGl0LCB3aWxsIG1vZGlmeSBpdCwgdGhhbmtzIGEgbG90
DQoNCj4gDQo+IFJvYg0K
