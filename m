Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C417105DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 08:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbjEYG5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 02:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjEYG5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 02:57:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB01DE46;
        Wed, 24 May 2023 23:57:09 -0700 (PDT)
X-UUID: 5b13419cfac911edb20a276fd37b9834-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bIZ9O1DYa8BNDGKCyrZ3ZvMbaxPHnSTT1h0cSTPl7Oo=;
        b=oU/IVioC6uyu7ytwtdOg3DRwBCVPrXMjjTCmHvMU4qohJc6MrpnBsYilLOlFOcFW1yarwXXdX86BTbbICqe2msYj5FcXYzAseTs+muHIrMnJiQbm00oFFG/4PryEtOXnV+YnaYnKqhsA30IreHWiIMt+0XVmT5h+++GWo49WpGY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:b69818ef-1d61-4265-87d1-c6e7c455a572,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:b69818ef-1d61-4265-87d1-c6e7c455a572,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:c624813c-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:23052504085121PFVSSS,BulkQuantity:1,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 5b13419cfac911edb20a276fd37b9834-20230525
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 966036026; Thu, 25 May 2023 14:57:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 14:57:03 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 14:57:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4SvwxAx6kocmP+vIKytqFVT/pPjA09T88XFrZ5+jxEyHvggwlT3RVFp5mmOTlcPyAX7I9/rlxIVHQ4a3qFqDt8r7HO8UDPWhpvGoyAvFaHcO+G40Gxnes/Dj1EaHGQQBV3u2I3a6oRKwCYpEhhffIoJXUwPId91tTQDSM2D4nU+5PTkPjvTMM2Iuyi06UKXH/7KbcG/OrIGXZvY7cJ3TXkjn5lrV8Jhl6LLYWcH3CKdWgRXVYhD8WmFeG6rPc9igZ73Qzx8XO3KNktltDDkW1aqWzyOKvD7JT3YNW+fHGplx0BRISTjffi/JL4NSF6e02B+0SkKgGKr+l3eScU8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIZ9O1DYa8BNDGKCyrZ3ZvMbaxPHnSTT1h0cSTPl7Oo=;
 b=SZvUFYqhSPwaVmoZBK76ym13onhziSqIhseb7k2QTPoboYfHrSSFe1wUWvg3kxfdjAAXECKi/KW/9l0TYFW1KCPAjcJBBS9j3zEz2DAQSTJMqEglJlGeEf2R7LMjxU3q1bcUh/4hLkuS6hpL8fylpHlaUW9IVVyY+uKESc+DDbeNSkfqWP5F+rnjGXJwscc4XVD8kyYnkSD8hp8LA4T5QRZ3pUofY3uG0hyon/w2/+el4bDr9xxjD6l4iiKsJ+ktq9c6Leb7T2Sc+YA6c+XElgVm6dKhNmkZU6JwSF8PJiCLpLdjciseblmEn3B0LPNfLyKCbSpL1/OfISNdms0vXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIZ9O1DYa8BNDGKCyrZ3ZvMbaxPHnSTT1h0cSTPl7Oo=;
 b=TpAc4tbwugIxQUSYTI9oI1X0HrxmwmBx3ooggDnC2NHbsKSziLvgLp8xsvvzw4kWgl8w/51wcIzNGAVrGUJdPUOsHE6V7fl6osUwfRZyyxYVJZSfl/D88CPziyhgzKg0mgqhfhTXMPNegL76ZHAZRaSOztIXeKFH0hNOWmLK37U=
Received: from SG2PR03MB5070.apcprd03.prod.outlook.com (2603:1096:4:d0::19) by
 TYZPR03MB7747.apcprd03.prod.outlook.com (2603:1096:400:423::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.16; Thu, 25 May 2023 06:57:00 +0000
Received: from SG2PR03MB5070.apcprd03.prod.outlook.com
 ([fe80::da23:cc83:c195:77cd]) by SG2PR03MB5070.apcprd03.prod.outlook.com
 ([fe80::da23:cc83:c195:77cd%4]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 06:57:00 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Thread-Topic: [PATCH v2] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Thread-Index: AQHZjka5lU0ovT+FCESHYvP2H4MimK9qj6QA
Date:   Thu, 25 May 2023 06:57:00 +0000
Message-ID: <87bee7defd2578dba9502c14b53b7e5a91b5a5a8.camel@mediatek.com>
References: <1684936207-23529-1-git-send-email-quic_prashk@quicinc.com>
In-Reply-To: <1684936207-23529-1-git-send-email-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB5070:EE_|TYZPR03MB7747:EE_
x-ms-office365-filtering-correlation-id: f0b1068d-b96d-45d6-0b1f-08db5ced3d2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpchPNTUjuyCYnjGnTCLeqqRMxT0woz7ZNFq9nTx4KITkS2JpCCiLKh3rq+FgUoYwzmJavDfmf2fGuUNeJGOLxA8uFrFwOdBH/3Uc7yGQWyfpDUV/eYTROnuViqi0AJ9iFZgSlp9t0/b4CLGxYHYbj/JNEpOiZOtycD5ZWIaUyE+YpjOyoh562+NDCQn1pxK+bsKD3RfO65asXucEBwhmZL/JkibeQZeeWmDEIEFcKjQU1QbaMGsrtYU25O9jLB7jZUepCMd7T3Uwx5KWOFcX8efyy74jlOBKWk/yNbKRc/8BepBXdwTSLYZl6sIyqJkMg3NtTRYtpoCvMHNaAWoUCsDXEo6e+8SqO/9Pqf58W+3l/KSVYEIa1FAutZyKaTtW1dZOSx7pnLyclp+mVofIzjDVKMBeqXBSpP0zc/TDiUB1TcmOGNgKEToTcgRy2AJ9hZAPW05NT572y6gTYkKdRAXsnmFS2qcoQJmeHv/c780DldBkbqm7s7MRZWbSmuwqKJjZR6fM5kV/VaHRuW1lVOTQnAlPGLWqr14D9WcMHFKYf2CyvgTvMhloo+N4ErwrM7U49/DB7O/rMvcq5uLuVMHx5MfwavGqqUDbGi3RWQV4lVpqmOXIBAGgaCqVMGcueFcsf1uTuvjVwaJDJoNH9fpLboFdLuuN2bF4i7coAY1HfBVMhQXvAAPI0IpD1ay
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB5070.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(2906002)(83380400001)(186003)(2616005)(36756003)(38100700002)(85182001)(86362001)(38070700005)(122000001)(71200400001)(316002)(6486002)(41300700001)(8936002)(5660300002)(8676002)(478600001)(54906003)(110136005)(66476007)(66556008)(64756008)(4326008)(66946007)(76116006)(91956017)(66446008)(26005)(6512007)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHNsbGpVS1AybTF4dWN2bEZvT2tlOXFVM2FNd0VYMVZJNzVBVm1DZUpzSGQv?=
 =?utf-8?B?azIrQnZTK0RlN3FPTmpnQ0lGQk50cExQNlBSOUM3SU5ldUZtakhHaFFWN3h1?=
 =?utf-8?B?ZVpMbEZmbENCKy9ldURIL1dkYldpbSs5Sk5EaGttSEd4cklFRGNQc1pkTEJS?=
 =?utf-8?B?NlA5VDIvZTZFVHJ2MEg3MzlqKzBRakNYeEpPSmFYdk83UGFXNzBvcUFDSzNs?=
 =?utf-8?B?RjNqMFZGaVZGcEZTUS9pM2NSNldUWlExdXBueDY5UHk1SHF1UkVHNFFWRG13?=
 =?utf-8?B?UjdYcDRUL2pCNWYwNXRGU2E0R3E0UnhUL1B0d0F4Vm9IMFlsQjBrVTIzVTQ2?=
 =?utf-8?B?UGtjSTFmU2pSTVVtWU5oMmdCbnVPLy9UbUg2N3pDd1Y0ek43L0VFZDNrZlc4?=
 =?utf-8?B?NmkwRjBnZWJhOEVFVUp2Mmp5Qzlhb0xVbFBWdEJ0MWJsSDVMTGNVT0U2dU03?=
 =?utf-8?B?Q28zWFNEOUl4RVk4b09GeWV3eS9PL3QrMjV6TExnYSt2aUY1MGVQUHQ1K1Zk?=
 =?utf-8?B?SUVuQkRvR0tPVjNiUkxYcWdjTG9HQW0wSExtcVh2VkJCV0Z3NWxOdlE4MGx0?=
 =?utf-8?B?QVRBTXRFSzgzZUU2RzcyenUzLzhlTUZGWUJ6OU1kZ1lWT1U3YjBpRlBPYmtO?=
 =?utf-8?B?V3VPbXI0ZXM1bVhKTStsblJpNTU2YjZPMG1pTVF3NTZUckV3cmthOUhwNG1u?=
 =?utf-8?B?WWRuQ3M4eVoycEJrTVhQSGdsMUczRUttTFZkc2tnS25jZFFaTFRScFdWR0I3?=
 =?utf-8?B?NVNvOUlIaXN6d1pnZU56N0taSFhvQTlrNENvOXdEUGJuc0ZkTDd3MGNCS3pj?=
 =?utf-8?B?bmViUGFpVlNoeDhmUmZIWGE2TUNNQ3F1dXlQdUk0SndPeGtJcEpKZDJDLytY?=
 =?utf-8?B?OTJZS2NyZlk5UzNQS0txMFdsaWxzcW1jTDVMRmg3ZXg0MlJDMUZ4dERSTkFT?=
 =?utf-8?B?UkxLdzYyMEZ0STZnU1lEclVnRWQ0cG01cU0rMGxsL2tSMjdRYldCR1lRcjVR?=
 =?utf-8?B?T25TT2M3dXFjdU1Pdm1OZkhyc3kwUjA1SjhrdFVwenN6RXJZU2NaajdQZjNC?=
 =?utf-8?B?Vnc2V0dUaDhmL0F0R1A3ZDN1NlFHM21XOXVpelpMWTFNT3duTkV1dXVFWTNS?=
 =?utf-8?B?bG5VWkU3MnhRRVF2ZzcwamZlaDFEbEVxZE9BZmN0UExMTTJxRDFMVFVocy91?=
 =?utf-8?B?Z1QyQjJZQXRCeGIrb0lPSjdSUGlRYUJDRExrakRIYktVMko1MDBvV2hUSFVu?=
 =?utf-8?B?SExhejQ5Y09UUU04TW5BdUhmeVFxa1htMUJyVDVRZlNtYVRaY2l1SjNNUHJV?=
 =?utf-8?B?NjJUcTdmMU5EZnB6Y2RQR0cxeWN6dmQ4ZjlXd0Jsb2tJc1BCZFcyTDJ6RXJF?=
 =?utf-8?B?Qmk2Y2lQRTcvNWlaV09kL20yenRtTHhPeHljb1J6OWpTR0llT0FYeWFMWUxs?=
 =?utf-8?B?RWNCOXZ3OEVnSFBTcWFVVVRxMGM1cjhiZWZsN2lYVlg0Q0FTZ2J2N2dGdnFi?=
 =?utf-8?B?MzlTRFBEY0EzdU1OUjB0VG8rZzZMRmd4L0xNeFkwbWNDV1hITWtSeVNZZ0Zu?=
 =?utf-8?B?MTkxaUovTk5xNVlmbGU2ZkFSNUcxcG9MZlltS1IvTlhONk11cWdOYW11emp2?=
 =?utf-8?B?eC9GYjVJdkJreWVtaHMyNXZNR1hONW94L0lsYmpZUS9XVnN1ZXlLNTk3TXor?=
 =?utf-8?B?K05SaDJRbXZ1aUtIMGdrd2ppWXNOSUdPRnJRUW0zZndFSFFKOSt0UzZFZnVN?=
 =?utf-8?B?Mi8yZFdMYk81MHByWW91UmhRUENrd0RGc3BWQjh4azZuTmlUQlNZY2VZeDZB?=
 =?utf-8?B?VktBdmxreElveHNpSXhlNCs4Rkliai9UbzNwZ0o2YmxDSnEyb2dycHhBY09p?=
 =?utf-8?B?VHJKK0xjdjNLTzgrMGRtOWJyUjVidXFLVXVYNW5RS0djcDQyVUZBVEJGTkty?=
 =?utf-8?B?NWhsTzJOR0RYR2p4akJGTTJOZlU4Tm5DVUNjRHNMMURNNjVBdGtPaWpsZ1Bi?=
 =?utf-8?B?YUhoN1E2YU1Ta3kwOTJZdzdGdWJndnZmY1JJR0I0VzM5a2FXeHdleTFoL0Rp?=
 =?utf-8?B?dTNnK3QvS2hvSkpnR2ppQTdsRmltL2lSUENyMDdZTDduWGNwQ0w4RkNrOFRD?=
 =?utf-8?B?ZExvdkJ3dFhZS3RGY1ZLank2T2w3bGZ0UjgrUmlFaTNzRnAwUXEveU8xS1lr?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <962E4413ECFB9D43B71A0DD6EF74D309@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5070.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b1068d-b96d-45d6-0b1f-08db5ced3d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 06:57:00.5930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQbsXd3xd+I764ro5LTXtnMrIqFwaMlJinVPUAGvxo224f5+dfXehJedlz4Qr5DjFoDutHIkhqo5MWT6xGalGHFNqYB3qLhsE36wpbK9cVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7747
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTI0IGF0IDE5OjIwICswNTMwLCBQcmFzaGFudGggSyB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBDdXJyZW50bHkgaWYgd2UgYm9vdHVwIGEgZGV2aWNlIHdpdGhvdXQgY2Fi
bGUgY29ubmVjdGVkLCB0aGVuDQo+IHVzYi1jb25uLWdwaW8gd29uJ3QgY2FsbCBzZXRfcm9sZSgp
IHNpbmNlIGxhc3Rfcm9sZSBpcyBzYW1lIGFzDQo+IGN1cnJlbnQgcm9sZS4gVGhpcyBoYXBwZW5z
IGJlY2F1c2UgZHVyaW5nIHByb2JlIGxhc3Rfcm9sZSBnZXRzDQo+IGluaXRpYWxpemVkIHRvIHpl
cm8uDQo+IA0KPiBUbyBhdm9pZCB0aGlzLCBhZGRlZCBhIG5ldyBjb25zdGFudCBpbiBlbnVtIHVz
Yl9yb2xlLCBsYXN0X3JvbGUNCj4gaXMgc2V0IHRvIFVTQl9ST0xFX1VOS05PV04gYmVmb3JlIHBl
cmZvcm1pbmcgaW5pdGlhbCBkZXRlY3Rpb24uDQo+IA0KPiBGaXhlczogNDYwMmYzYmZmMjY2ICgi
dXNiOiBjb21tb246IGFkZCBVU0IgR1BJTyBiYXNlZCBjb25uZWN0aW9uDQo+IGRldGVjdGlvbiBk
cml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBQcmFzaGFudGggSyA8cXVpY19wcmFzaGtAcXVpY2lu
Yy5jb20+DQo+IC0tLQ0KPiB2MjogQWRkZWQgVVNCX1JPTEVfVU5LTldPTiB0byBlbnVtIHVzYl9y
b2xlDQo+IA0KPiAgZHJpdmVycy91c2IvY29tbW9uL3VzYi1jb25uLWdwaW8uYyB8IDMgKysrDQo+
ICBpbmNsdWRlL2xpbnV4L3VzYi9yb2xlLmggICAgICAgICAgIHwgMSArDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2Nv
bW1vbi91c2ItY29ubi1ncGlvLmMNCj4gYi9kcml2ZXJzL3VzYi9jb21tb24vdXNiLWNvbm4tZ3Bp
by5jDQo+IGluZGV4IGUyMDg3NGMuLjMwYmRiODEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2NvbW1vbi91c2ItY29ubi1ncGlvLmMNCj4gKysrIGIvZHJpdmVycy91c2IvY29tbW9uL3VzYi1j
b25uLWdwaW8uYw0KPiBAQCAtMjU3LDYgKzI1Nyw5IEBAIHN0YXRpYyBpbnQgdXNiX2Nvbm5fcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gICAgICAgICBwbGF0Zm9ybV9z
ZXRfZHJ2ZGF0YShwZGV2LCBpbmZvKTsNCj4gICAgICAgICBkZXZpY2Vfc2V0X3dha2V1cF9jYXBh
YmxlKCZwZGV2LT5kZXYsIHRydWUpOw0KPiANCj4gKyAgICAgICAvKiBTZXQgbGFzdCByb2xlIHRv
IHVua25vd24gYmVmb3JlIHBlcmZvcm1pbmcgdGhlIGluaXRpYWwNCj4gZGV0ZWN0aW9uICovDQo+
ICsgICAgICAgaW5mby0+bGFzdF9yb2xlID0gVVNCX1JPTEVfVU5LTk9XTjsNCg0KRG8geW91IG9u
bHkgdXNlIHZidXMtcGluPw0KDQpUaGlzIGRyaXZlciBhc3N1bWVzIHRoYXQgdGhlIGdhZGdldCBk
cml2ZXIncyBkZWZhdWx0IHJvbGUgaXMgbm9uZS4NCg0KDQo+ICsNCj4gICAgICAgICAvKiBQZXJm
b3JtIGluaXRpYWwgZGV0ZWN0aW9uICovDQo+ICAgICAgICAgdXNiX2Nvbm5fcXVldWVfZHdvcmso
aW5mbywgMCk7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC91c2Ivcm9sZS5oIGIv
aW5jbHVkZS9saW51eC91c2Ivcm9sZS5oDQo+IGluZGV4IGI1ZGVhZmQuLjIyMWQ0NjIgMTAwNjQ0
DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvdXNiL3JvbGUuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4
L3VzYi9yb2xlLmgNCj4gQEAgLTgsNiArOCw3IEBADQo+ICBzdHJ1Y3QgdXNiX3JvbGVfc3dpdGNo
Ow0KPiANCj4gIGVudW0gdXNiX3JvbGUgew0KPiArICAgICAgIFVTQl9ST0xFX1VOS05PV04gPSAt
MSwNCj4gICAgICAgICBVU0JfUk9MRV9OT05FLA0KPiAgICAgICAgIFVTQl9ST0xFX0hPU1QsDQo+
ICAgICAgICAgVVNCX1JPTEVfREVWSUNFLA0KPiAtLQ0KPiAyLjcuNA0KPiANCg==
