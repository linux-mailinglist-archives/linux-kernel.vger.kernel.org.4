Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B546774E958
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGKItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGKItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:49:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ED610C4;
        Tue, 11 Jul 2023 01:48:44 -0700 (PDT)
X-UUID: bade8d481fc711ee9cb5633481061a41-20230711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1U88EiNdAO3cehX2mEylfPDQYS5FLe2SBLTZRAmvNcc=;
        b=foTXeaycN65jSS7X+I0CsDZmUTGHoE9RR4EPH/cmG46usddd5xui2EG1GlVY4QwEPqpECy4EKjEcbj/jAftL4bsGV1jkePhe34D2l2Q5MUGbEyGhtBAH1p7mNufsorbArzEdwt8No6RfSjBykzE8+eWVZ+cPoOsnD0YMvmNx4fw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:85b01e26-90af-4c35-846b-1b5660729a4f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.28,REQID:85b01e26-90af-4c35-846b-1b5660729a4f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:176cd25,CLOUDID:d74e1a0e-c22b-45ab-8a43-3004e9216b56,B
        ulkID:230711164024TKTZRTAF,BulkQuantity:5,Recheck:0,SF:29|28|17|19|48|38|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-UUID: bade8d481fc711ee9cb5633481061a41-20230711
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 776695581; Tue, 11 Jul 2023 16:48:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 11 Jul 2023 16:48:37 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 11 Jul 2023 16:48:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6Ax/xb8A7DRJWpaqKP8kCvzXiCo6HJ1lsD3yiUORUkx9cW3r7hvrZdr/kg1zt0QrbfvuBfXuxunL+lGon259e8laLWkkzfzJDOZ+88i4qX8keUnS+DTUPM5K626uLOmtrON3u58myBVHjOV/eyp8uW4SYRRoUqhoLMuF02VNW8EOxQh1ZNVge4E4gihmXdqv7yBdFibut12ihfPLxRKt2KUIao3eiARy3736z7+GX1uCVq+l0vh7J8xwqqojAu7L/M4yNglRkonpt835AHIVURPGbcUe15ul7L31agK1NB9j9xyFYhc7mpBFTM6usGOBU5e8P+PgPNPy4BqLglY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U88EiNdAO3cehX2mEylfPDQYS5FLe2SBLTZRAmvNcc=;
 b=W2H/KKVUBdyda2ate2AvWKmjT7GIKSZtNYzWLZAHdFvx3lvicb4cBo6oUr0t38qgIeEOPpH4soEPJ9+vZP6FZ/MpxqUZGH7ekKzN1MbrrbGc2xZKrZRZaOxc5SSEamkpbqBTSvihSdkmXRQb1PVyoNyrYbQBaaxWkbU3kqV/OGGw7ZMqVH+GuunmH74oMlQmIF2dLYm4onHuoX27puJk5/6TqUeDFIE2lNBb3WC8RVaGrKvMPS67PiQm/3zw4Ez5YZPRdZNZLSN4SmITmcdqJx4/pbuecdCBlTdV+rHNtOd1j4ty5YsZfulvWTyQZoGEBtj8ium59h9cNzkR3eZrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U88EiNdAO3cehX2mEylfPDQYS5FLe2SBLTZRAmvNcc=;
 b=iFgOHKabMolN4fEGz+9UBzVMlMvx4EwaqnN5BZ9NKoXKBVSDy+5bBc9d2wlQ8nj15iA8LaYdWLUSxj3OfC+BeB6ezeptrv234G8SVsBo6EeKnYX/e3D1Y7JLPV539LjO0EeaoYRtu2A6jCUEi49OkxDO8EIy8TX+NhCCuU3li44=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by SEZPR03MB7419.apcprd03.prod.outlook.com (2603:1096:101:12a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 08:48:35 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::fdc9:3156:45ef:a4ed]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::fdc9:3156:45ef:a4ed%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 08:48:35 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "yhao016@ucr.edu" <yhao016@ucr.edu>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: mtu3: Fix possible use-before-initialization bug
Thread-Topic: [PATCH] usb: mtu3: Fix possible use-before-initialization bug
Thread-Index: AQHZrs8UvTbDMJF+YUeLRsTWjG5vnK+qsAqAgAeCw4CAAF5bAIABui0A
Date:   Tue, 11 Jul 2023 08:48:35 +0000
Message-ID: <29a71cbb61148d2085cc08da681526c4e20d31b9.camel@mediatek.com>
References: <CA+UBctDxfb6+70+hzuXJ-gwb65E0uoNzXYEhpJT92sXr2CE7OA@mail.gmail.com>
         <20230705080625.02b2bac5@bootlin.com>
         <CA+UBctBqtSvyBWf9ZwKbecTrh9_6sCDm_TyU-ncb+6h5y19K5g@mail.gmail.com>
         <20230710082558.2f82d607@bootlin.com>
In-Reply-To: <20230710082558.2f82d607@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|SEZPR03MB7419:EE_
x-ms-office365-filtering-correlation-id: 906bd58a-481e-4fea-2467-08db81eb9d26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6KtQX4xqd55z89uwbYlnxEkC5XE0P+zNgwfYiQxm5TZalfhzmpgPTdKlk46gYyKdBCwIXb7JbT4/DgyOZGrgyf4dlssm0I5fQKGZ4TVdjkhelmFA2DR+160AAgjxGAft7q9kG2numQ5zAEQFoy0gcJvZFfH40Klf4arEIWDjGXnx31aT9NriWIsfzVqK9ltKx8xFzK8qKCFHI2s7VqjUyuIgTWQV4uit2V2rOW4L7BESC26hyh5IJllCiwmU4vuy7AhU1oA7Hmk6wYf10IFQaRj9BSyI68vAQWipe+8md8G6ld0mpbDL8j0lNurbeD5LrNcPphmVnIEZp3nKwbYggGAfMgYWM8hQW4M3mKAE6HUa813yCMZuu/x8mlRrRRd0+CflK62ZtP6dwnNO7y69CHoIN3A5TY3wq8Cguq53+BqiHvaFw/4RCwlF03mmuP7DBqptyGd7mupPcy12aFxOV91Uy47JC6zQyFc4biXRA+ZBX7tiPNCZcwk1kf9z99NjIP4CsvJc8VRbmitDOIalD1lHuEAZwh21Suf20XAp+vOz931abqjy3RAgg6wlSx7u5qdRXBEnDfLWYUIPp3gXULcSqr0YCLOVpHmEYt0mSi/414PD0KUNQb+45W3/zUUfh6WjDhLl0Kl/Ac9D51iC95IStqK57ng5DFJwh3bWrGV8WeGWjnOHwwRtkUGx+vZM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(85182001)(38070700005)(36756003)(86362001)(38100700002)(122000001)(478600001)(110136005)(71200400001)(54906003)(6486002)(6512007)(8676002)(8936002)(5660300002)(2906002)(316002)(91956017)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(2616005)(26005)(6506007)(83380400001)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ymc2dTUvRi9KZzIyRzdBOE1FcEU4MFR3R1FMUVZzbmU5VXFwOWVnYjlPWVh0?=
 =?utf-8?B?LzEwUXpuY2VML0ZCZVFzM3gvc3pLbjA3ejU1Sk5QSmx3Y2hoUlh5YlVGckNy?=
 =?utf-8?B?RUNIQzFiaTZHRGxnSThsakpsUXhDWEVnbHNSRGVGSDBQM3lReWpLMEtzS2I4?=
 =?utf-8?B?RWtpRDQzM0tvb3Q1QnVzcTNmck5qTWJqdUZvNlFDQ21qSFRpTVd0UTJxN2d4?=
 =?utf-8?B?clRHS09Wd09XSDA5YkFCZ3BnUlh4c3BOZzVzMkhXdmlYSUtJMHprRnBUeWxn?=
 =?utf-8?B?cmo3cjNXSW0yUEE4ZFpxeE4rN3FwUE02WHZoL1pvRjFGaTNId3JMaWUwV2Vw?=
 =?utf-8?B?MXh3Rzl5L2p6YUdiVFJNWU5yL1dKZGE2SGxFalBIeTZ5RlI4OHEva3FYckVW?=
 =?utf-8?B?U21idTVnNHR4bHRFb0wycm1Ra1R4Qzl6Tk9uaWdrd2Zsc1VucDF4SDBjSE5C?=
 =?utf-8?B?WHMxSGVCUW1UWkV4NjlPQ3hRUCttYndQTHJCRXRtczBzS2pIWE90OS9UVFI5?=
 =?utf-8?B?RU9tUjhXOXpJYndCaWUyNWxzMHI1SjZTNFJYSVM0eTJXbUxWdUpvcnhkbHN0?=
 =?utf-8?B?NFdxUHhlVm8xci9Nd1NMV2J5WnZtZjRodmFtbUl6SzFIS0huRDFFSkVnY3lU?=
 =?utf-8?B?YmUzR0NaeUFlYlRaOFQ3NnFoYXZFWVNWM0c3Z3pGbjdUV2VrTFFXbGV5am5S?=
 =?utf-8?B?alNHTUVGV0VKeEtkZXlQZFYwRFUrWVloaktrWkJ4S3FKM3pQQUIzaXJ3ckh6?=
 =?utf-8?B?YUNGcE4xMk5PbzNTS051MFp2aWRKWjRsbXBoaUFuYkE4WXRoV0piNmdIenVn?=
 =?utf-8?B?S0kyWEwvZ212eHNuV1YwUkNFMEc4dzA4SzFMMnAvdERKYVZhU241elg1L1NZ?=
 =?utf-8?B?OW1BQktrM05abGI2Vm5ZZkNJb2wvRjd1cnVNYlFBQ0ZtV3lza2VOcUtoU1lT?=
 =?utf-8?B?NGtGcW9tNXdBVFNIZkRVSjZHa2E0S2lVbmc0Z2l2N3pkL3hjcE95a2NmOTI5?=
 =?utf-8?B?NE1nU0FEV3J2SkdpM3VsWmYzNkFRemdCMFdJcWZxckRQYUtsejFtVmViMXgz?=
 =?utf-8?B?cFNQbFo4ZzY5MjlKd3RjZGJuQ1NYd3JSYzZZY2hzN2kxUjBoQ1NhbE5GZWlk?=
 =?utf-8?B?L3ZNM3AybTI5TTQvdGhtditVY2ZVWm5zWlVJT3Z5WUpiRlkzallnMXBRcFU4?=
 =?utf-8?B?M2NTTkJFK2FYMW16Y21GY2JFQmJRZGx6OVpTalFubnJjQ1QrL050cElQVGVU?=
 =?utf-8?B?RmVxQWt5NGpBeDFxdnExSzd4RFhKZ2YrRWJWdmRoekU2VE5lWUxGcFE3ck10?=
 =?utf-8?B?em50WWE1SmdqVm05dUpTaW1Fb1gydEQyU01xbHVIYWl1WDNoRTVCRjRFbjNJ?=
 =?utf-8?B?aWZNbUlQQTF1VVloaGZES2ttVDNZV20wVUFPOHhkQUZLWnFJOHlqdERVdCtq?=
 =?utf-8?B?b3YvUWFoRkJBZVVUbTc4eHVpNjNiQVZDTWgvTVBvZUU0NXpzdXVrdWJaSGlx?=
 =?utf-8?B?R25ZUTd3OFFCYmwzOGhrbUhadHRBTXhhcDF0VVlOR0ZpaHBxcDZVRTVlZGFw?=
 =?utf-8?B?NVdEdnM5cDVnejZwVkZzUDRzNytCWnZId0VyVnlXT29LbTVRcUVzZ3BmWlpD?=
 =?utf-8?B?OUNWSi9UY1JvemtnUFk2bHhlZERKMDdaRVY1Yy9jRDU5aFB0NnlvWHkwZGNE?=
 =?utf-8?B?NFdHdkY4Q21pdWh6ci9GTytrVm50VlJERnhoVElqY3dtK0pQblllMWkwekF4?=
 =?utf-8?B?WDFrRU9vQW8zZVd0aUp5bTNNNjVYMWt0Wk1GbnNDa0E3QVNTYlRZelpWUlhE?=
 =?utf-8?B?bFdHS2dRUnJTTWErZ3U4SHJUbkJzaCt6ejgya1ZSdHAwRW10akc2RjdRZnFq?=
 =?utf-8?B?djNxNmR2MHJSLzl5R3FpWUZqN1FpK0daajcxSjBUWlFGU2xEM0h3MEZmQUpS?=
 =?utf-8?B?eWM0NVY2RVlIN0lEQi85eS9NaFgwZDJvM0crQUU1dDVxMDg5VDlzYm53YWxZ?=
 =?utf-8?B?UDMwR1JqRXJPc2RPU1MzNlhPcHZzTzhWRHJXcUxtS3QzQ2lkUWZvRXpQMTZG?=
 =?utf-8?B?K1AzS2hSV25lKzliZk1mUmtqZmFnNUx5eVFNNDZ5VGgyamFlbFI1a1JwdENF?=
 =?utf-8?B?eHdZNTdJbjU3aWtUU0xZbmZmcmt6ODZJdHJPVTN5dFBETUpveUt2bm5WRjFH?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01DB54075659B748A79127B77095078A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906bd58a-481e-4fea-2467-08db81eb9d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 08:48:35.6131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VmYjM/IBWIee0xi3BDATY4LaRsZFwyUL09w0wkXWvC10OmBGMbvS0JBydefSO4JeoaXXxjjOaHRYNQ+Z5FKbn3SPwdbYh1DQB4GgzOwisYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7419
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTEwIGF0IDA4OjI1ICswMjAwLCBIZXJ2ZSBDb2RpbmEgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgSGkgWXUsDQo+IA0KPiBPbiBTdW4sIDkgSnVsIDIwMjMgMTc6NDg6MTUg
LTA3MDANCj4gWXUgSGFvIDx5aGFvMDE2QHVjci5lZHU+IHdyb3RlOg0KPiANCj4gPiBIaSBIZXJ2
w6ksDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgY29tbWVudHMuIEhvdyBhYm91dCB0aGlzIHBh
dGNoPw0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3VzYi9tdHUzL210dTNfZ2FkZ2V0X2VwMC5jIHwg
MTEgKysrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXR1My9tdHUz
X2dhZGdldF9lcDAuYw0KPiA+IGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2dhZGdldF9lcDAuYw0K
PiA+IGluZGV4IGU0ZmQxYmIxNGE1NS4uYWYyODg0OTQzYzJhIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXRfZXAwLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9t
dHUzL210dTNfZ2FkZ2V0X2VwMC5jDQo+ID4gQEAgLTYwMCw3ICs2MDAsNyBAQCBzdGF0aWMgdm9p
ZCBlcDBfdHhfc3RhdGUoc3RydWN0IG10dTMgKm10dSkNCj4gPiAgICAgICAgIG10dTNfcmVhZGwo
bXR1LT5tYWNfYmFzZSwgVTNEX0VQMENTUikpOw0KPiA+ICB9DQo+ID4gDQo+ID4gLXN0YXRpYyB2
b2lkIGVwMF9yZWFkX3NldHVwKHN0cnVjdCBtdHUzICptdHUsIHN0cnVjdA0KPiB1c2JfY3RybHJl
cXVlc3QgKnNldHVwKQ0KPiA+ICtzdGF0aWMgaW50IGVwMF9yZWFkX3NldHVwKHN0cnVjdCBtdHUz
ICptdHUsIHN0cnVjdCB1c2JfY3RybHJlcXVlc3QNCj4gKnNldHVwKQ0KPiA+ICB7DQo+ID4gICAg
IHN0cnVjdCBtdHUzX3JlcXVlc3QgKm1yZXE7DQo+ID4gICAgIHUzMiBjb3VudDsNCj4gPiBAQCAt
NjA4LDYgKzYwOCw4IEBAIHN0YXRpYyB2b2lkIGVwMF9yZWFkX3NldHVwKHN0cnVjdCBtdHUzICpt
dHUsDQo+ID4gc3RydWN0IHVzYl9jdHJscmVxdWVzdCAqc2V0dXApDQo+ID4gDQo+ID4gICAgIGNz
ciA9IG10dTNfcmVhZGwobXR1LT5tYWNfYmFzZSwgVTNEX0VQMENTUikgJiBFUDBfVzFDX0JJVFM7
DQo+ID4gICAgIGNvdW50ID0gbXR1M19yZWFkbChtdHUtPm1hY19iYXNlLCBVM0RfUlhDT1VOVDAp
Ow0KPiA+ICsgICBpZiAoY291bnQgPT0gMCkNCj4gPiArICAgICAgIHJldHVybiAtRUlOVkFMOw0K
PiANCj4gJ2NvdW50JyBzaG91bGQgYmUgdGVzdGVkIGFnYWluc3Qgc2l6ZW9mKCpzZXR1cCkuIElu
ZGVlZCwgd2UgbmVlZCB0bw0KPiBoYXZlIGENCj4gc2V0dXAgZGF0YSBwYWNrZXQgaW4gdGhlIGZp
Zm8uDQo+IA0KPiBXaGF0IGRvIHlvdSB0aGluayBhYm91dDoNCj4gaWYgKGNvdW50IDwgc2l6ZWYo
KnNldHVwKSkNCj4gcmV0dXJuIC1FSU5WQUw7DQpiZWZvcmUgY2FsbCB0aGlzIGZ1bmN0aW9uLCBh
bHJlYWR5IGNoZWNrIHRoZSBkYXRhIGxlbmd0aCBpbiBmaWZvLCBpdA0Kc2hvdWxkIGJlIDggYnl0
ZXMuDQpzZWUgbXR1M19lcDBfaXNyKCksIGFib3V0IGxpbmUgNzYxLiANCg0KSSB0aGluayBubyBu
ZWVkIHRoaXMgcGF0Y2gNCg0KVGhhbmtzIGEgbG90DQoNCj4gDQo+ID4gDQo+ID4gICAgIGVwMF9y
ZWFkX2ZpZm8obXR1LT5lcDAsICh1OCAqKXNldHVwLCBjb3VudCk7DQo+ID4gDQo+ID4gQEAgLTY0
Miw3ICs2NDQsOCBAQCBfX2FjcXVpcmVzKG10dS0+bG9jaykNCj4gPiAgICAgc3RydWN0IG10dTNf
cmVxdWVzdCAqbXJlcTsNCj4gPiAgICAgaW50IGhhbmRsZWQgPSAwOw0KPiA+IA0KPiA+IC0gICBl
cDBfcmVhZF9zZXR1cChtdHUsICZzZXR1cCk7DQo+ID4gKyAgIGlmIChlcDBfcmVhZF9zZXR1cCht
dHUsICZzZXR1cCkpDQo+ID4gKyAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gDQo+IEZvcndhcmQg
dGhlIGVycm9yIGNvZGUgdG8gdGhlIGNhbGxlciA/DQo+IA0KPiByZXQgPSBlcDBfcmVhZF9zZXR1
cChtdHUsICZzZXR1cCkNCj4gaWYgKHJldCA8IDApDQo+IHJldHVybiByZXQ7DQo+IA0KPiANCj4g
PiAgICAgdHJhY2VfbXR1M19oYW5kbGVfc2V0dXAoJnNldHVwKTsNCj4gPiANCj4gPiAgICAgaWYg
KChzZXR1cC5iUmVxdWVzdFR5cGUgJiBVU0JfVFlQRV9NQVNLKSA9PSBVU0JfVFlQRV9TVEFOREFS
RCkNCj4gPiBAQCAtNzY0LDcgKzc2Nyw5IEBAIGlycXJldHVybl90IG10dTNfZXAwX2lzcihzdHJ1
Y3QgbXR1MyAqbXR1KQ0KPiA+ICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAgfQ0KPiA+
IA0KPiA+IC0gICAgICAgZXAwX2hhbmRsZV9zZXR1cChtdHUpOw0KPiA+ICsgICAgICAgaWYgKGVw
MF9oYW5kbGVfc2V0dXAobXR1KSkNCj4gPiArICAgICAgICAgICBicmVhazsNCj4gPiArDQo+IA0K
PiBPaw0KPiANCj4gPiAgICAgICAgIHJldCA9IElSUV9IQU5ETEVEOw0KPiA+ICAgICAgICAgYnJl
YWs7DQo+ID4gICAgIGRlZmF1bHQ6DQo+IA0KPiBCZSBjYXJlZnVsLCB5b3VyIHBhdGNoIGlzIHdy
b25nbHkgaW5kZW50ZWQuDQo+IHRhYnMgcmVwbGFjZWQgYnkgNCBzcGFjZXMuIFlvdSBuZWVkIHRv
IGtlZXAgdGFicy4NCj4gDQo+IFJlZ2FyZHMsDQo+IEhlcnbDqSBDb2RpbmENCj4gDQo=
