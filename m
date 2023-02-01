Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3236568615F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjBAIN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjBAINy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:13:54 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796205B58B;
        Wed,  1 Feb 2023 00:13:52 -0800 (PST)
X-UUID: 59caac2ca20811ed945fc101203acc17-20230201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PlKgK13mEFviD5QIG3oSw4/N/raNUw4GIyvNWhFgc9o=;
        b=P5ovBK2LZbDix5apoo/5Gss5CNRZ3Vpguqvoc+E5/1KCLSYjGqOhhTA+uQaeV9jTyvklaa9tJ5oWgcpi9aaO2UVQZZg25FhRON7mTvTQv+2OuGf20tP8TXo/pZtfjxE6qQ9T6W0ndxeFmEXI1OQruX+XzkfnijAwZJ6oebDSRe8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:6425e208-4a30-4d4b-b620-d5857cd151b0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:5644918d-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 59caac2ca20811ed945fc101203acc17-20230201
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2033554696; Wed, 01 Feb 2023 16:13:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Feb 2023 16:13:45 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 1 Feb 2023 16:13:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8iAOJD0Myo3cLlkIQwbYvbKPQ07HlyLEjQ7Gd/y8V7VcIfSmgsGS/nnHtuDChxAEnOHH0DS81fzhuRdwu3S2NouaIdfC/E2795fAJIPMOOvMXqudzltEgApdMCumVT5YjZSdnw+pXmirDSvCIJLRSS0fPG7f0Qnc3Iti2Ir94YXmPy0iVvnctrOd6UEKYtv8AFIm0MeLrAn7P+UoIDq0YZje44kbpfdfLCxaPSe/xNuPe5+HD0xRaEJSdXgNH8LcRjbt9CCr1LYJCsLZOSrAURr3X2EOp2fG1Sbwy5iwlPuHU6Gx8qNM7f8W20mH1nW3Ko4Adf6yAxisVfq3u9IPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlKgK13mEFviD5QIG3oSw4/N/raNUw4GIyvNWhFgc9o=;
 b=giyVWVSfzDqXU/uyZ6eU8tLnd4AGKMz1D5gKraxwPraidYyEnty1W1Qis6ROACE9IcylEKeD/KkiqrR5dyJ8wQ4QBexBiGg54QacOYpp4lnrNj85DJz9W6MZmcM4PV97rsVNNCvb/yfadLq5U70mhy1ncanGnv9X9qBkkjnXKajrXC+4fBpU+HMnVkkr1kPfOCwkSvV6AbapCyDdxCFNnqk2yVfhkxx5JnofdusuYi/+meOiKxUc5cCS0q9SCGQOIDv4WeXhtdn8vuhLU+trW6+g7yawmSGlsBokANs6NyFN9tNQ6FW2oIB6tYvADv9bqJpvNfMYMkD1R8aqDP32WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlKgK13mEFviD5QIG3oSw4/N/raNUw4GIyvNWhFgc9o=;
 b=odA2MM4/E3OTAwewfU35IHdFrsKOk7uAtHjyFObhKAnxmj4A0dV+xmCiIP2kuq+LfIIjJdlH2SXznf2ayY+tou8CZRSdWwmT0b23RwZl8sCIPl9CSgzH7isMrVR6CxXFIZwdetAHRVf5uNlFdf1b+T0YfmjtGwUKd2qZ+paT3Xs=
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com (2603:1096:4:26::14) by
 TYUPR03MB7111.apcprd03.prod.outlook.com (2603:1096:400:350::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.22; Wed, 1 Feb 2023 08:13:43 +0000
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::42eb:28a2:4d2e:d051]) by SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::42eb:28a2:4d2e:d051%5]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 08:13:43 +0000
From:   =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>
To:     "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "drinkcat@google.com" <drinkcat@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>,
        =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>
Subject: Re: [PATCH v4 13/14] soc: mediatek: mtk-svs: use common function to
 disable restore voltages
Thread-Topic: [PATCH v4 13/14] soc: mediatek: mtk-svs: use common function to
 disable restore voltages
Thread-Index: AQHZJZDJksdHW0eyYkeOf8iPI5hbp664p/0AgAE3D4A=
Date:   Wed, 1 Feb 2023 08:13:42 +0000
Message-ID: <b53a1c3cfc794e333a2d3e164a74f2e2c9bc6c7c.camel@mediatek.com>
References: <20230111074528.29354-1-roger.lu@mediatek.com>
         <20230111074528.29354-14-roger.lu@mediatek.com>
         <64702a9b-6c78-3065-8335-28d31c6fc1ab@gmail.com>
In-Reply-To: <64702a9b-6c78-3065-8335-28d31c6fc1ab@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3434:EE_|TYUPR03MB7111:EE_
x-ms-office365-filtering-correlation-id: c555a5e0-8712-472c-8bc9-08db042c3bbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yyorc6hLWKs1/b68VjEsDFXJ8WAxJI3ixdQFvFUhGPCPi7Px/V4BA9IV35tDWSACKjmwkgra4c0VIMJGWZNILRs9hzG7aMcr04fRVmrzYbXzqusPPMhfyBQDSlGavO2pFYmVLHeRXqSDagCvnn33sM/KZLBZ4CS2cw0C0KDVmjvUzdvF79IFufMRnn/DRG10ou6bpEnsi6yKlOnIXlgjZYsvTeNNoal1/uTL9Ip8txK67solt0nFUAP4zEyToo1kqZqFcjwX4EEpat5WQ39MpzXg2C3AHNnYH8/YCue5clvqVLf56BMphxQuIGNTIjarP82IrWtEujKMtCHh8tMqqoGXfUZ53muh7JwQsFcF8Ddh2uhtzeIPkdYqBsnLpwfS4k+oOG3jlrNz4Gw75QpKGygnKfIOKHGzD3UirCiL25YgraZuGj0BVn/qXK1HR6S5BSoFAiRgacQ/2O0O9lrbUipL+cX4NLkYGkQeXsbLo7FkyvLDtfii68yTQ5RiSuTraFw6iKhp9E+60YjUiWGPcbOZcTYl/C5Er6R88XbtBMo1SRv95xvSvHZP5uKFUIlLX/0ychJv3gRZ0/Y6BG/whlMw+I/JGpzNQCFNgnE6IeSi+0f73OObYKAienEmgH/3gcxHfZg/veEUG96Q2BgNQi7Yooc0h86zlSaVwude143Y+d9Zyx+CUt7ad0/hEDntbW4t7tRZQiEmFs24Tklm6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3434.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199018)(2906002)(38070700005)(4744005)(36756003)(85182001)(86362001)(5660300002)(6486002)(107886003)(6506007)(6512007)(26005)(2616005)(83380400001)(478600001)(186003)(41300700001)(8936002)(53546011)(122000001)(38100700002)(54906003)(110136005)(71200400001)(66446008)(66556008)(66946007)(76116006)(64756008)(316002)(4326008)(66476007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Szd0K1N1TnRGSEVUZks1eWJHd1lETmxQckE0V1I3VU5jajhwSG5uZFVzd2dE?=
 =?utf-8?B?cnN2ZUZSaWNzUkl2cFhWTFAzK3doSjI3a3dvamFVaHpOc2pSVzJ5OE53MHdh?=
 =?utf-8?B?T3N4WjcvQ3ZXOElSWE9NTWx1MkdzUkhJdk5XQTlyNmoxM2JsalBlc1RtNnpm?=
 =?utf-8?B?VzdtK2dOSDNESmNja2preDdIbVZuWDhWelgxelpneDJmNVdMY05kYTdpKzN4?=
 =?utf-8?B?bmgvYXZzYUcyOWk5VzV1eFM2RUNVZzBBRENiRFdReTZJaUdCdWV0RDlNelU2?=
 =?utf-8?B?KzViU1dFNTMvYmJjalNqb29VVURneVQ3eE9nZi96VTk0dmFkWlcvWUZaS2hn?=
 =?utf-8?B?U1g3UkQvWTVoWU1OaWVvTHY3SmJvdVczdFFiYS9nNTJnWktBTzlqM1o0c1pt?=
 =?utf-8?B?ZHhJMmUyUmlzZ0FvbWhYQWRtNWx4dnA2Z0pJWVVpNE5BaFN3aHlVdVN4M1lk?=
 =?utf-8?B?R1N4N0xLYnh2dmE3UHR2d1A4aFRaOVZSMEwzMko0QW1WRnFsOEJFNmV6L0Fa?=
 =?utf-8?B?VWFJaktPREVRQW1TbkJGSXM0SFRJMXN4MzRvbThPMjVuKys5RmNrOWxTazJ0?=
 =?utf-8?B?bEVJRkFWMFNsMkY0ZDJ3VDFnTDdWbkJHL09TK0FqYWZQem5RMDJFMmR1dVZm?=
 =?utf-8?B?K1FQY0JNZ21YYUc3VHNzK3dzcXNnL1NYVk1OWXlEcHVPbGxTYW0vSURLTHFV?=
 =?utf-8?B?NnB6SFNQNDlUU3pxbThNdFhzZER2NXNUejR3a1dCMEk4bElCbmNRb2swb1F4?=
 =?utf-8?B?V3pBZHVaN29NQnA4WVlTNk9MbTlaS0IxNG80ZkxuZWVaS1lQVkdEbVA2WkVC?=
 =?utf-8?B?QjRCYk41YnRSNHdsOWxsZDVyOGNJcUpNU04vWitJd1NteXM2WENsUVVIejZI?=
 =?utf-8?B?R0ZFYkp1bDNqOG5UUGNFTW9KSkdLa2pFaFRNKzNkY1NKTjJCcC9QSDNQN3A4?=
 =?utf-8?B?NUMrdUx1VjI3RnVCbFE5QW9CZUFsOEhwTDNKdmpvNnJheHhSOUVBZGtxTmdK?=
 =?utf-8?B?dnZSeU5UcVB0L2RsbnFtZGViSG8zcWUycG43YW5vSi9XdTlzc2lEdzVRR1lz?=
 =?utf-8?B?ZzZiU3NGMlNwbTB0SzZkSEVIRzBrL0tmRm1jaHpMdTY0L2t4MGdialYzbEhx?=
 =?utf-8?B?eXN5aHVseC83T0FzTWpjM2tSOWJhNHpJOWVFUFRUakNhK1J4cVJsWFU1eFZp?=
 =?utf-8?B?dHpxK1V5cEF2MXBXRzlLQ1F6cFNCc3hHcGZabmUrNGw5RjA5MEQ1Zm95RkRn?=
 =?utf-8?B?empmWHV1M3hpQ2ZjWDZjZ3MxdlF5YXc3WDVSWWphcEUwODhtQkRYS2hZdTdN?=
 =?utf-8?B?S0l1SVJMT3drTFFuc3dlWkVhQUR3UTJ0SGIxNFExVDArTHB1R3E1cTdmVGZr?=
 =?utf-8?B?bzk4NDh3OUxsTXJndjc5MXNiREt3Ylh0d1BNaHp4SFpvbHFMenk4QWo3UFZ6?=
 =?utf-8?B?YnBrL0cwVFlaMFdCRlR1RFFwTkhHUzZjZmJ5WHdSbjFvRDk5T2ZYMnltOFlY?=
 =?utf-8?B?dGd5OEdScHVsSmRtYVc4TUZjWjIxa1EzWDBpNmpDT2RDN3k4UTNrVXd1Nnhj?=
 =?utf-8?B?UVNScng4QUFTZXRtWkNhTCs0STJjejNWdHV2VWJHV29pK1RPcERUOGdwUTl5?=
 =?utf-8?B?WGlmYXB1MWVGa2FoTWxTMmFzWFYwc3ErbmlpSzE1dGRmUHZQMWNveWhkbXhp?=
 =?utf-8?B?RWowZDlxeG14b1QyaGh2dk5tV08rLzlkcmZ4Y1RVUmFnL3JXR2dpUUN6ZVM0?=
 =?utf-8?B?QU1GL3VQMW15SEc1aHAvNm05dFpzMWE1YWRFTjJqM3kyTUU0Q1FEN0hNd2hZ?=
 =?utf-8?B?Ti9Xc2twM05VdWwvY1BILy8xSDlUankrMVR4RHl0M3pnRE1CRGp6NVFrOU11?=
 =?utf-8?B?emp2dFhhZDdsa1JWQ3prdXFCL3JQZ1pBL25KamRzeDdVT2VlbU4wZUwvOVNM?=
 =?utf-8?B?VDlOenh3Vk9mVmpsSEZhMEMxeWJKK1l2U1pMUkFtR2JvQ0NzQVUwRUtFL1o3?=
 =?utf-8?B?VEh1WlZsTjBSRkp0RWEvNy9MUWZVa201d2NHY2kxb09LODNzempqTUdhWHRU?=
 =?utf-8?B?eHNZR2ZTQ21SNmcxZDZ0M21IN1hFa2dOeVc0aXZoQUNTanpRc1J2c2h5bmdS?=
 =?utf-8?B?MHJ5Q08zV1ZhTE9qd21CRmhnZzZWVXJvYWZOamNFeDl5eE54ZFJZNHQ2MEE2?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B336770E86034045B70BDEA023CEDAAC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3434.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c555a5e0-8712-472c-8bc9-08db042c3bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 08:13:42.9807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QH3Yg4/GC3VF8RE45g1cmAQcIi1eTknrfx715QjGxb/6mN+FJyMgw0mtcYRp72Vy8gF00EIGionMies1Kk3xag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMgU2lyLA0KDQpPbiBUdWUsIDIwMjMtMDEtMzEgYXQgMTQ6NDAgKzAxMDAsIE1h
dHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAxMS8wMS8yMDIzIDA4OjQ1LCBSb2dlciBM
dSB3cm90ZToNCj4gPiBUaGUgdGltaW5nIG9mIGRpc2FibGluZyBTVlMgYmFuayBhbmQgcmVzdG9y
ZSBkZWZhdWx0IHZvbHRhZ2UgaXMgbW9yZQ0KPiA+IHRoYW4gb25lIHBsYWNlLiBUaGVyZWZvcmUs
IGFkZCBhIGNvbW1vbiBmdW5jdGlvbiB0byB1c2UgZm9yIHJlbW92aW5nDQo+ID4gdGhlIHN1cGVy
Zmx1b3VzIGNvZGVzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIEx1IDxyb2dlci5s
dUBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vIDwNCj4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IA0K
PiBTYW1lIGhlcmUsIGNoYW5nZSBsb29rcyBnb29kLiBDb3VsZCB5b3UgcGxlYXNlIHJlYmFzZSBh
bmQgcmVzZW5kOg0KDQpObyBQcm9ibGVtLCBJJ2xsIHJlYmFzZSBhbmQgcmVzZW5kIGl0LiBUaGFu
a3MuDQoNCj4gDQo+IFJldmlld2VkLWJ5OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dA
Z21haWwuY29tPg0KDQouLi4gW3NuaXBdIC4uLg0K
