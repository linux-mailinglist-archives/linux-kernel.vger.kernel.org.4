Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A426632220
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiKUMcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiKUMcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:32:02 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF3FA8C2D;
        Mon, 21 Nov 2022 04:30:47 -0800 (PST)
X-UUID: 6be01bb700354364ad3fbd395f0a947b-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8SKgTZ7Kumx9R0XsThUS+c1u0VDbKZJLG8lGGOFT3u4=;
        b=UyHAhz1/KyRDQqbonufHmzo9dv8UFjZ5vaEkEioefFjayisRwvdU1JnUCxrYxhrfLBrxPUwHnwoc0/8i5X24uap61sUFHk96LX8bJ8Wl5vuhwj4ix8g6Q8gVxAetG6FFo1wQDShjOiYvjM3vM+ncMinKRZK13kcUMgBGlT/Ri54=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:77897f6d-aede-4a59-a1bb-da75f9493102,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.12,REQID:77897f6d-aede-4a59-a1bb-da75f9493102,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:0723622f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221121203043P8KHDRTP,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6be01bb700354364ad3fbd395f0a947b-20221121
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 385388203; Mon, 21 Nov 2022 20:30:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 21 Nov 2022 20:30:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 20:30:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcAfK0jaqLDFRK0dsnaEDIn0aTjVvCMul4hAXKYpzO/hhE0my+LhmrkWvmymyZp6J7aTA2WK2/T1vtz8jbe2+vU4+FPefH62oHJ0o3c+jswgj56YdWolhbc3R82mmZW36Iwr49Nwjj7Thsbyux64fSHJv/7swpac1JWwL9HtjLJ5L7pBh2yQn4aL2mpm5jWVFrWcQ1//t8e4abY/YLtIacrRnZOvfW4/eKmCg9B0NtLE1Kvl5u4F70cvwp84tJvomJLlnFXLYKjJCYsTk7Z3ZD4BPQ9+iJGBIdeQ1HW4foSzjhZK4wagiNx1CXq57xQmdZjUMi+mNulX+2sG5n0cZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SKgTZ7Kumx9R0XsThUS+c1u0VDbKZJLG8lGGOFT3u4=;
 b=ON+hJJ+8aleHpBFswnv0bj7/ZjIqi+HdSiP+ab6nN4mQaCeYeJd6ZsqDPUgi8Wl8cOPqmtFLo5wc3gNgVIh5xnCgOzZZcz31vWTv8iAs+PgIu+pB0Ft/oCJ4af0T5r4VnMk+3wGR6TVSx331kbBQzii/dCx0sLy5R7zAOg3n73AYIx4Dam3VV7IB5PNSL9av+O3jr92LGW6lFHJSVK063A/ivS8PCsoASRC0ciSzTHGiFTqMEYEGzT1qwJe86wfTU7C+1mbmaNHs5XYD3V1xOLpBMGZwMxr/z/2obvMXwyMFDzfn1QGt58rwgECVnBAycYMnF97yEqktFZq21QAHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SKgTZ7Kumx9R0XsThUS+c1u0VDbKZJLG8lGGOFT3u4=;
 b=Cu4jRE3d/vAUEzu0KsKFvUWG9XNhRnbXpI9fwGA/SLCov9AMA28FPJNbPN+3DwbENwXJ47bwO9XeW7WbehOmpSmYJNsLMLMWKSxde/SqfRChd/j2W156/FZ5OlhK4uYGtIVbvKaem96FmWhiHZZcMaHMLMHCXDHB+j//uT8IPwQ=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SEZPR03MB6492.apcprd03.prod.outlook.com (2603:1096:101:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 12:30:38 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::7e10:1fdf:c6f6:597e]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::7e10:1fdf:c6f6:597e%7]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 12:30:37 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: mt8192: Add vcodec lat and core nodes
Thread-Topic: [PATCH v4 2/2] arm64: dts: mt8192: Add vcodec lat and core nodes
Thread-Index: AQHY1L8uCwcOtsh1BUCWcyixrdoU7a5FBZSAgASbCAA=
Date:   Mon, 21 Nov 2022 12:30:37 +0000
Message-ID: <5bb52e10002be4ea00ccb97d08235ebb97161756.camel@mediatek.com>
References: <20220930112237.14411-1-allen-kh.cheng@mediatek.com>
         <20220930112237.14411-3-allen-kh.cheng@mediatek.com>
         <20221118141039.y2ap7dzdp26ih2la@notapiano>
In-Reply-To: <20221118141039.y2ap7dzdp26ih2la@notapiano>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SEZPR03MB6492:EE_
x-ms-office365-filtering-correlation-id: 02ef24f8-04e0-441e-b976-08dacbbc31f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MP/KdLZ/bDi0OSi6YF0ef6Ee9qLBY7o8A3eRAVtng0rCsoh5/3+fL0bog5N5siRT4IE5GIAmb2likVQJfLxhB2Q79iMl9y7q+mJoOpcOH9iIqZwOQ2eIK/LYrunqroyJiMnNP9czwyPCLrySR5XpnOu7WvtI7IKfSI36j7XedpFzyb8hgO1RAhjMnWwj7vMWVE2qDk17P+QcaJWwM2VLiMWGb7v/thWBX7MTjH9NSqECUgi8r+7OOZ+IGMwE5BMJSFli9oUn09D2d2vE22b1DdkK8YcHEkoJCH4LaDjUooWvBaw2IX5wtb+QqgFj+3gigXJ6JVBmKBHbL91Z1Com+bOUZZbjFUdsY/K3BtrMgWgmuTRlDyxjAQ2E1Ux2IeNxQoG/D61qHG3QI87PAsvYpo8NV+ytgu92dfruov8wf7Sp+psjxHhkBlNWKxBpprC6qPSjW+cf5Iln2zEFCxJwS5cZXTciI0wXMw+0Bc6pKz66MwMmxOQ77O7cixAnSD1sBUNPb7FZhye0j8IgqPGU66ZjbvRQtaQCBl4uvXnlnqlZ/W1Utk56ymb4AK61mo83CtcfD4E1VNmIaS11pXlTF3z5ZTO9NWdP9nOm5R0QabuQcPV1xxB6Tm1B2ld0r+GcoRpWk0CswJ+VzKHweHsOzPd6wQGzQwmwPzJg6Bah3JhlGxtZ7hWJ8gzCjuIlMoE91vfoHrCr3appamREtqTl5mL7XlhfU4tYMeq6pgJD594WVCnK1J+IU0d9d6/p9IQL/wUFepBlSg7J5qwBosQ1Rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199015)(4001150100001)(83380400001)(2906002)(91956017)(76116006)(2616005)(41300700001)(66556008)(66476007)(85182001)(36756003)(66946007)(86362001)(54906003)(6916009)(6506007)(38100700002)(6512007)(122000001)(38070700005)(5660300002)(8936002)(186003)(7416002)(8676002)(66446008)(64756008)(4326008)(966005)(6486002)(26005)(316002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVkyYWpBdURFY09BalpodGxOTG1VZ0pVMGdoSlcvY3FwSFFiQkpQbklRSksw?=
 =?utf-8?B?NTArREV2ek0zRXVHeDFVdlpNaDRrNm9TcFlBMDlaM1hSZVpSMmUxNTBzYytF?=
 =?utf-8?B?eHZkUUZXcWJ3aHZiZW95Z0xXRmE5SzZCYy9YSzJwWTkvQU41WnZBQ3RsR2dE?=
 =?utf-8?B?YTdjNzlDSDhINkFzTXF0MDBhU1BLZnlwQjY2OUIyQ3JnZFZmaTNtMWVDLzkx?=
 =?utf-8?B?NkNXdllMZElXVUpkYjJwTHQrTzYyZXc3RE85d1NoME5QcE9sbXFOMFoxWnlX?=
 =?utf-8?B?UWxWaHJCMmxja0t0bkVzeDU4RWkrb3JLTnRTQkFWNXVyZTdLMU82blphQkx3?=
 =?utf-8?B?NW9La2loZ0RyRWYyNlhHSk80NGZlVlMzeURGYkdMQXEyN0JrREtEemQwNFJ3?=
 =?utf-8?B?NVk0ODVrYUkzMEd0cHJKM28rWjlYK2NUdlBPUFYrTC9WWU93TzVYclNnWVZH?=
 =?utf-8?B?bWpNZmIwSkpXdWlyWm9QbU94Mjc3d09DWElDNmorZVRaa2laWWR4Y3hXWkxh?=
 =?utf-8?B?cXRZRHRhU0szY0ozRUdUV3c5VURqcXVobWo3UnprNGJ4QVdwSDZiSitiRnFr?=
 =?utf-8?B?WTYvWkZyZjN2VUtzQ2FycWphZFRRaS82TytDMTdZZVlzblNlQTJBR0lvWFc0?=
 =?utf-8?B?ZDFBanR4Sklkek9RdmdaZlpUV3IzSGozT1BvczFPeWpJZGpFQ3Q1djRIcDdS?=
 =?utf-8?B?Yjd6ZTlrcUtScnV6VFZLNC9FUU0reWVhZXptUmhNbzdTMGFUQWZnb0lON2I0?=
 =?utf-8?B?U1BmTHVDaUdHL1d6bXRNV2RMc294TmgxNnAyb1h0VndIY2NGNUE3Z0NhTkg1?=
 =?utf-8?B?WURNZGJWZlZxNUZQbmp1V3lUT3BVTVdvcEthSy9SeUR2Qy81aVFhcklLWDJ4?=
 =?utf-8?B?d2Q4SEp1R1Z0RmN4aTNOYk0wenBCajZ5SEwzNEtkNkxFN3pmNDlNeERxaFNa?=
 =?utf-8?B?WkZmUGo0MEFydGQ1Z3VlNVU4bTdyU2Y4di9waGN3R3hZNzFKNjVMSHlqa2Z6?=
 =?utf-8?B?dGExWE9nb2l6RjJWLys3WTg5ZDNydjhneFljWHYzREZlNzRwM0FLRThUbkNR?=
 =?utf-8?B?blVWdlpCVk9uU3NjbDNyQVRtSllZOHJLNnN3TlBrWlBJVlFYVlV6UERqQ2E5?=
 =?utf-8?B?UkUyUlMxclpnRnF2a2JWQkpRak1lZnBJZytnUlBzTmErK2Y5bU1VRkRuWS9K?=
 =?utf-8?B?U0tnSWhCSnVqblhvcEY0VHBQUXJ5YUdKTkFCUExNVFd6cDRvajM5cjJNYk9n?=
 =?utf-8?B?NVNUQ1Z4TGxURlQ1My9jd1JrOHg1eDlsUzkxWlVHd1E5VXIrTmpqaDhvMUhq?=
 =?utf-8?B?aElSSFJRWVZwdm8wYnVjd2x2TXZYOW1yWDE3RG1LOTV5Y3FMYnRPNmt2SWJx?=
 =?utf-8?B?c3dNMUY3OVIwMnp1VnFqQm5lQzM3dUlpbnJwUXFsQzJQZzdHeEpMYXA0cjJX?=
 =?utf-8?B?MWdxSXd4ZVFrUHpRRGxudkM0bHRNNGQvczl0YmdHWDd1RWhVcjRmS2k1Z3Na?=
 =?utf-8?B?R1B1eGZSZE1xUi84ZlRZaFRjUWNPNHgwT2RaelhJQm5tTjIxK2xKMWVWekUz?=
 =?utf-8?B?ckZuUnZELzZjR2xQYlhhVVZ3Z1VYSkNmTUlmZXJwWmRWTlFndFBYTFRaR3VR?=
 =?utf-8?B?ckFBS0ZUNTl4bDJYeXdTMTBUTk9uWERROVhqNm9Ba05PbWRUSldHSjBCdG90?=
 =?utf-8?B?dTlOOGw1NEhhYXdvSHZBSEZVR1ZsWXE2YlNZK1NGaWk2S0JnRlUvZnFReEZy?=
 =?utf-8?B?Wk12MnhucHpEU2RoZCtHV3A5NDUvL2JKV081d2xLTnl4VVF4ZWtmcHJPVGJj?=
 =?utf-8?B?aXdoaVN5eC94YXkwQTlveC9nU09iTDlqUUk3ZWt6QXVnbzRLTG5LRm9nN1ln?=
 =?utf-8?B?SGVDZEJGNGtJSXZuUFdlVkJMc2N6ZHlGU283K1piOGR6N3QrcmpjdDRPWito?=
 =?utf-8?B?R1lyUEg2cStnYnhiQ0Q5UTNRSCtpUkR5bmJReUFEN08rdVYxWkljbnkwOGNI?=
 =?utf-8?B?NHlJNCtkd2FEZWZVT3F4UmNka1l3TklXRmRXTW9zVlVqL1pIZ0NVQU84WDl0?=
 =?utf-8?B?V0xQWkJPM2NJUkoyZUhxckxubXYwZjhCNUZ2b0E2UlZUaU5LRkxvcU9rakQx?=
 =?utf-8?B?R0VyY0ZhTHpLRWNyMENWRzFFa253TndObGVYNjl2bTlLZ2ZxRUN5cnFBSHFJ?=
 =?utf-8?Q?bgjiHBkAGf/Q1O8KuqIv3tE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E7BCF0FBEF3E0468F5DAFA62E697BC5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ef24f8-04e0-441e-b976-08dacbbc31f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 12:30:37.7937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dF4pKlqQ3hLS6aueIfllYKq5ux1HqbLCsDYRkrvyN+adpAqovmR5I2fX41BmD+7ouUKFADT6MKXoAap3KT8LfbjZKQYsUigsCA1S/uq+hPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6492
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTsOtY29sYXMsDQoNCk9uIEZyaSwgMjAyMi0xMS0xOCBhdCAwOToxMCAtMDUwMCwgTsOtY29s
YXMgRi4gUi4gQS4gUHJhZG8gd3JvdGU6DQo+IE9uIEZyaSwgU2VwIDMwLCAyMDIyIGF0IDA3OjIy
OjM3UE0gKzA4MDAsIEFsbGVuLUtIIENoZW5nIHdyb3RlOg0KPiA+IEFkZCB2Y29kZWMgbGF0IGFu
ZCBjb3JlIG5vZGVzIGZvciBtdDgxOTIgU29DLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFs
bGVuLUtIIENoZW5nIDxhbGxlbi1raC5jaGVuZ0BtZWRpYXRlay5jb20+DQo+ID4gVGVzdGVkLWJ5
OiBDaGVuLVl1IFRzYWkgPHdlbnN0QGNocm9taXVtLm9yZz4NCj4gPiBSZXZpZXdlZC1ieTogQW5n
ZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9A
Y29sbGFib3JhLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxOTIuZHRzaSB8IDYwDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kNCj4gPiBpbmRleCA2YjIwMzc2MTkxYTcuLjky
YTIwZjg3NDY4YiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210ODE5Mi5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgx
OTIuZHRzaQ0KPiA+IEBAIC0xNDQ5LDYgKzE0NDksNjYgQEANCj4gPiAgCQkJcG93ZXItZG9tYWlu
cyA9IDwmc3BtDQo+ID4gTVQ4MTkyX1BPV0VSX0RPTUFJTl9JU1AyPjsNCj4gPiAgCQl9Ow0KPiA+
ICANCj4gPiArCQl2Y29kZWNfZGVjOiB2aWRlby1jb2RlY0AxNjAwMDAwMCB7DQo+ID4gKwkJCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLXZjb2RlYy1kZWMiOw0KPiA+ICsJCQlyZWcgPSA8
MCAweDE2MDAwMDAwIDAgMHgxMDAwPjsNCj4gPiArCQkJbWVkaWF0ZWssc2NwID0gPCZzY3A+Ow0K
PiA+ICsJCQlpb21tdXMgPSA8JmlvbW11MCBNNFVfUE9SVF9MNF9WREVDX01DX0VYVD47DQo+ID4g
KwkJCWRtYS1yYW5nZXMgPSA8MHgxIDB4MCAweDAgMHg0MDAwMDAwMCAweDANCj4gPiAweGZmZjAw
MDAwPjsNCj4gDQo+IEhpLA0KPiANCj4gc2luY2UgY29tbWl0IDk1MWQ0ODg1NWQ4NiAoIm9mOiBN
YWtlIG9mX2RtYV9nZXRfcmFuZ2UoKSB3b3JrIG9uIGJ1cw0KPiBub2RlcyIpIFsxXQ0KPiB3YXMg
bWVyZ2VkIHRoaXMgbm8gbG9uZ2VyIHdvcmtzIGFzIGlzLiBSdW5uaW5nIHRoZSBmbHVzdGVyIGNv
ZGVjDQo+IHRlc3RzIHJlc3VsdHMNCj4gaW4gSU9NTVUgZmF1bHRzOg0KPiANCj4gCVsgIDM4Ni4y
MzM5NzZdIG10ay1pb21tdSAxNDAxZDAwMC5tNHU6IGZhdWx0IHR5cGU9MHgyODANCj4gaW92YT0w
eDFmY2RjMDAwMCBwYT0weDAgbWFzdGVyPTB4NTAwMDQxYyhsYXJiPTQgcG9ydD03KSBsYXllcj0w
IHJlYWQNCj4gCVsgIDM4Ni4yNTA2NjZdIG10a192ZGVjX3dvcmtlcigpLDI0MToNCj4gW01US19W
NEwyXVtFUlJPUl0gIDw9PT1bMTM4XSwgc3JjX2J1ZlswXSBzej0weDI5OCBwdHM9MA0KPiB2ZGVj
X2lmX2RlY29kZSgpIHJldD0xIHJlc19jaGc9MD09PT4NCj4gDQo+IFRoZSBpc3N1ZSBpcyB0aGF0
IHRoZSBETUEgY29uZmlndXJhdGlvbiBzdXBwbGllZCBieSBkbWEtcmFuZ2VzIGlzIG5vdw0KPiBs
b29rZWQgZm9yDQo+IGluIHRoZSBwYXJlbnQgbm9kZSwgc28gdGhlIHZjb2RlY19kZWMgbm9kZSBu
byBsb25nZXIgZ2V0cyB0aGUNCj4gY29uZmlndXJhdGlvbiBpdA0KPiBleHBlY3RlZC4NCj4gDQo+
IFRoYXQgc2FpZCwgZ2l2ZW4gdGhhdCB0aGUgbm9kZSBhbHJlYWR5IHVzZXMgdGhlIElPTU1VIGZv
ciB0aGUgYWRkcmVzcw0KPiB0cmFuc2xhdGlvbnMgKGlvbW11cyBwcm9wZXJ0eSksIHRoZXJlIHNo
b3VsZG4ndCBldmVuIGJlIGEgZG1hLXJhbmdlcw0KPiBwcm9wZXJ0eS4NCj4gSW5kZWVkIHNpbXBs
eSByZW1vdmluZyB0aGUgZG1hLXJhbmdlcyBwcm9wZXJ0eSBmcm9tIHRoaXMgbm9kZSBmaXhlcw0K
PiB0aGUgaXNzdWUNCj4gYW5kIGdldHMgdGhlIGRlY29kZXIgd29ya2luZyBhZ2Fpbi4NCj4gDQo+
IFRoYW5rcywNCj4gTsOtY29sYXMNCj4gDQo+IFsxXSANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWYxYWQ1MzM4YTRkNTdmZTFmZTY0NzUwMDNhY2I4
YzcwYmY5ZDFiZGZfXzshIUNUUk5LQTl3TWcwQVJidyF4ZGhobnZYTVk1LUJqSTJCWFBIUUktSHc4
emd0WjFsdkZ5RkZ2N0t0TnVDRHhXMTdWQzdScUFhVzlCX3VYc1F1Y1Qxc0xrX0RVbC1jOTlpakY5
ZEY4UVhiSlEkDQo+ICANCg0KTm90ZWQhDQoNClRoZSBwYXJldCBub2RlIHNob3VsZCBiZQ0KDQp2
Y29kZWNfZGVjOiB2aWRlby1jb2RlY0AxNjAwMDAwMCB7DQoJY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxOTItdmNvZGVjLWRlYyI7DQoJcmVnID0gPDAgMHgxNjAwMDAwMCAwIDB4MTAwMD47DQoJ
bWVkaWF0ZWssc2NwID0gPCZzY3A+Ow0KCWlvbW11cyA9IDwmaW9tbXUwIE00VV9QT1JUX0w0X1ZE
RUNfTUNfRVhUPjsNCgkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCgkjc2l6ZS1jZWxscyA9IDwyPjsN
CglyYW5nZXMgPSA8MCAwIDAgMHgxNjAwMDAwMCAwIDB4MjYwMDA+Ow0KCQ0KCXZpZGVvLWNvZGVj
LWxhdEAxMDAwMCB7DQouLi4NCg0KfQ0KDQpBbSBJIHJpZ2h0Pw0KDQpUaGFua3MsDQpBbGxlbg0K
DQo+IA0KPiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiArCQkJI3NpemUtY2VsbHMg
PSA8Mj47DQo+ID4gKwkJCXJhbmdlcyA9IDwwIDAgMCAweDE2MDAwMDAwIDAgMHgyNjAwMD47DQo+
ID4gKw0KPiA+ICsJCQl2aWRlby1jb2RlYy1sYXRAMTAwMDAgew0KPiA+ICsJCQkJY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdGstdmNvZGVjLWxhdCI7DQo+ID4gKwkJCQlyZWcgPSA8MHgwIDB4MTAw
MDAgMCAweDgwMD47DQo+ID4gKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNDI2DQo+ID4gSVJR
X1RZUEVfTEVWRUxfSElHSCAwPjsNCj4gPiArCQkJCWlvbW11cyA9IDwmaW9tbXUwDQo+ID4gTTRV
X1BPUlRfTDVfVkRFQ19MQVQwX1ZMRF9FWFQ+LA0KPiA+ICsJCQkJCSA8JmlvbW11MA0KPiA+IE00
VV9QT1JUX0w1X1ZERUNfTEFUMF9WTEQyX0VYVD4sDQo+ID4gKwkJCQkJIDwmaW9tbXUwDQo+ID4g
TTRVX1BPUlRfTDVfVkRFQ19MQVQwX0FWQ19NVl9FWFQ+LA0KPiA+ICsJCQkJCSA8JmlvbW11MA0K
PiA+IE00VV9QT1JUX0w1X1ZERUNfTEFUMF9QUkVEX1JEX0VYVD4sDQo+ID4gKwkJCQkJIDwmaW9t
bXUwDQo+ID4gTTRVX1BPUlRfTDVfVkRFQ19MQVQwX1RJTEVfRVhUPiwNCj4gPiArCQkJCQkgPCZp
b21tdTANCj4gPiBNNFVfUE9SVF9MNV9WREVDX0xBVDBfV0RNQV9FWFQ+LA0KPiA+ICsJCQkJCSA8
JmlvbW11MA0KPiA+IE00VV9QT1JUX0w1X1ZERUNfTEFUMF9SR19DVFJMX0RNQV9FWFQ+LA0KPiA+
ICsJCQkJCSA8JmlvbW11MA0KPiA+IE00VV9QT1JUX0w1X1ZERUNfVUZPX0VOQ19FWFQ+Ow0KPiA+
ICsJCQkJY2xvY2tzID0gPCZ0b3Bja2dlbiBDTEtfVE9QX1ZERUNfU0VMPiwNCj4gPiArCQkJCQkg
PCZ2ZGVjc3lzX3NvYw0KPiA+IENMS19WREVDX1NPQ19WREVDPiwNCj4gPiArCQkJCQkgPCZ2ZGVj
c3lzX3NvYw0KPiA+IENMS19WREVDX1NPQ19MQVQ+LA0KPiA+ICsJCQkJCSA8JnZkZWNzeXNfc29j
DQo+ID4gQ0xLX1ZERUNfU09DX0xBUkIxPiwNCj4gPiArCQkJCQkgPCZ0b3Bja2dlbg0KPiA+IENM
S19UT1BfTUFJTlBMTF9END47DQo+ID4gKwkJCQljbG9jay1uYW1lcyA9ICJzZWwiLCAic29jLXZk
ZWMiLCAic29jLQ0KPiA+IGxhdCIsICJ2ZGVjIiwgInRvcCI7DQo+ID4gKwkJCQlhc3NpZ25lZC1j
bG9ja3MgPSA8JnRvcGNrZ2VuDQo+ID4gQ0xLX1RPUF9WREVDX1NFTD47DQo+ID4gKwkJCQlhc3Np
Z25lZC1jbG9jay1wYXJlbnRzID0gPCZ0b3Bja2dlbg0KPiA+IENMS19UT1BfTUFJTlBMTF9END47
DQo+ID4gKwkJCQlwb3dlci1kb21haW5zID0gPCZzcG0NCj4gPiBNVDgxOTJfUE9XRVJfRE9NQUlO
X1ZERUM+Ow0KPiA+ICsJCQl9Ow0KPiA+ICsNCj4gPiArCQkJdmlkZW8tY29kZWMtY29yZUAyNTAw
MCB7DQo+ID4gKwkJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ay12Y29kZWMtDQo+ID4gY29y
ZSI7DQo+ID4gKwkJCQlyZWcgPSA8MCAweDI1MDAwIDAgMHgxMDAwPjsNCj4gPiArCQkJCWludGVy
cnVwdHMgPSA8R0lDX1NQSSA0MjUNCj4gPiBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0KPiA+ICsJ
CQkJaW9tbXVzID0gPCZpb21tdTANCj4gPiBNNFVfUE9SVF9MNF9WREVDX01DX0VYVD4sDQo+ID4g
KwkJCQkJIDwmaW9tbXUwDQo+ID4gTTRVX1BPUlRfTDRfVkRFQ19VRk9fRVhUPiwNCj4gPiArCQkJ
CQkgPCZpb21tdTANCj4gPiBNNFVfUE9SVF9MNF9WREVDX1BQX0VYVD4sDQo+ID4gKwkJCQkJIDwm
aW9tbXUwDQo+ID4gTTRVX1BPUlRfTDRfVkRFQ19QUkVEX1JEX0VYVD4sDQo+ID4gKwkJCQkJIDwm
aW9tbXUwDQo+ID4gTTRVX1BPUlRfTDRfVkRFQ19QUkVEX1dSX0VYVD4sDQo+ID4gKwkJCQkJIDwm
aW9tbXUwDQo+ID4gTTRVX1BPUlRfTDRfVkRFQ19QUFdSQVBfRVhUPiwNCj4gPiArCQkJCQkgPCZp
b21tdTANCj4gPiBNNFVfUE9SVF9MNF9WREVDX1RJTEVfRVhUPiwNCj4gPiArCQkJCQkgPCZpb21t
dTANCj4gPiBNNFVfUE9SVF9MNF9WREVDX1ZMRF9FWFQ+LA0KPiA+ICsJCQkJCSA8JmlvbW11MA0K
PiA+IE00VV9QT1JUX0w0X1ZERUNfVkxEMl9FWFQ+LA0KPiA+ICsJCQkJCSA8JmlvbW11MA0KPiA+
IE00VV9QT1JUX0w0X1ZERUNfQVZDX01WX0VYVD4sDQo+ID4gKwkJCQkJIDwmaW9tbXUwDQo+ID4g
TTRVX1BPUlRfTDRfVkRFQ19SR19DVFJMX0RNQV9FWFQ+Ow0KPiA+ICsJCQkJY2xvY2tzID0gPCZ0
b3Bja2dlbiBDTEtfVE9QX1ZERUNfU0VMPiwNCj4gPiArCQkJCQkgPCZ2ZGVjc3lzIENMS19WREVD
X1ZERUM+LA0KPiA+ICsJCQkJCSA8JnZkZWNzeXMgQ0xLX1ZERUNfTEFUPiwNCj4gPiArCQkJCQkg
PCZ2ZGVjc3lzIENMS19WREVDX0xBUkIxPiwNCj4gPiArCQkJCQkgPCZ0b3Bja2dlbg0KPiA+IENM
S19UT1BfTUFJTlBMTF9END47DQo+ID4gKwkJCQljbG9jay1uYW1lcyA9ICJzZWwiLCAic29jLXZk
ZWMiLCAic29jLQ0KPiA+IGxhdCIsICJ2ZGVjIiwgInRvcCI7DQo+ID4gKwkJCQlhc3NpZ25lZC1j
bG9ja3MgPSA8JnRvcGNrZ2VuDQo+ID4gQ0xLX1RPUF9WREVDX1NFTD47DQo+ID4gKwkJCQlhc3Np
Z25lZC1jbG9jay1wYXJlbnRzID0gPCZ0b3Bja2dlbg0KPiA+IENMS19UT1BfTUFJTlBMTF9END47
DQo+ID4gKwkJCQlwb3dlci1kb21haW5zID0gPCZzcG0NCj4gPiBNVDgxOTJfUE9XRVJfRE9NQUlO
X1ZERUMyPjsNCj4gPiArCQkJfTsNCj4gPiArCQl9Ow0KPiA+ICsNCg==
