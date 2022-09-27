Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDC25EC4F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiI0NxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI0NxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:53:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E178130BC2;
        Tue, 27 Sep 2022 06:53:11 -0700 (PDT)
X-UUID: dc12868a4b4e444ca1e0c6a8003c140d-20220927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KnsEN83q1SWoRJJiOutY8J7wr/pnJ/aObtvgnKgdCU4=;
        b=fsV3RaSh1FW9Px2M9pLu+jwMAShNYPZQ9jHnQFDs4JNvzVPIRSCzV1QGkIPiIj7ac2eEs4QhTFAWdCwlIIP6KE26V4YabHtaz9QgeoYR8MhKUI8Pv3NzJMuljt0u1bbExl+AY5wctYg8UqYpmPCej8JEuyI5soccrjBv0Tt1no8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:b1ea7c2a-9485-41c6-9432-41551643f377,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.11,REQID:b1ea7c2a-9485-41c6-9432-41551643f377,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:166a3107-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:2209272140502UYJQ4UR,BulkQuantity:202,Recheck:0,SF:38|17|19|823|824,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: dc12868a4b4e444ca1e0c6a8003c140d-20220927
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 97127364; Tue, 27 Sep 2022 21:53:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 27 Sep 2022 21:53:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 27 Sep 2022 21:53:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gABoqzsA3hmjyAZV0K4iM1La0hTzllYian8LnlwlpU15l0boyn6nbUHSfFUQtFBa59MmdUEnW4r8X5iys0D8lA5G/uruy9sCa/XmZtJQmf4ztv5EpUJBi9pVNVOJpw4MrizCwg93XCkSkfFqNTvZlnwT2qRBn5rt/S09lcdd+W1et04GjYUdiXbKjbmadxgjipsCjRNbm1z5t5lN01pPy//xBsBKY4Zw8AeOiDDveziFFL/nwyhHjlXCH1UL76E0HG4L2hSfai6uHCeMo0wXPKPzCa5wxECfsEV63lh3CASsOgxWpjYIHrlavG0NAKbkfzyucl5ftZpzdPSVkVuJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnsEN83q1SWoRJJiOutY8J7wr/pnJ/aObtvgnKgdCU4=;
 b=OroZFEhXIpgO78Br0BvtsG4AlOHydujVJt3zQ3vJqRE7bScw73hIQDNxxp4wtLDiuHJ4jTd6NScJulg8axLNjODc2uOT6iLSeLlI7oeIRBQxPMsDJa9+ZshmuhPBsxHMDQ3m4XXCOm8elgca/bjJgHuKw5S6JhAnBTylRP3SQbVrdwnrd9clwgrOffOxy/EDW4ePpMtf9eDASq5Ue0NfvXP52+st0t7Ns1kN/kBrz6pUWsNuAz43zY3em6rYA66WL7yhp3Sygp02CIMZxc526UmtL/DHRj16yDH0tNclZr6yvF9YmXiAHvSus0Qd3SimLT16AuVb5kIAsfjmRFyVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnsEN83q1SWoRJJiOutY8J7wr/pnJ/aObtvgnKgdCU4=;
 b=tdQUIbKqUTYNZ7xwW81u8z3sMYCN1RBOG3mPO2bDYqjVTp9+xgXiVuWNApkB+ibJG7X7d1IKzXtSfMGEJwsva06AQlveZFeF2lL0zP93+/61e+Wgj4cDPcPijNvBXvWEAKafMsmNhg0tj64HV+gf/qKaPh+Fy2r78XlbJEU50DI=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by PS2PR03MB3720.apcprd03.prod.outlook.com (2603:1096:300:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Tue, 27 Sep
 2022 13:53:03 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a%3]) with mapi id 15.20.5676.014; Tue, 27 Sep 2022
 13:53:03 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/5] arm64: dts: mt8186: Add IOMMU and SMI nodes
Thread-Topic: [PATCH 3/5] arm64: dts: mt8186: Add IOMMU and SMI nodes
Thread-Index: AQHYz047GdDLxtbdhUmacvr6Su67U63zTtwAgAADcgA=
Date:   Tue, 27 Sep 2022 13:53:02 +0000
Message-ID: <8d1b3ce07de7974ec77976cf98d337e68967b11f.camel@mediatek.com>
References: <20220923131148.6678-1-allen-kh.cheng@mediatek.com>
         <20220923131148.6678-4-allen-kh.cheng@mediatek.com>
         <6f1deed3-87e5-6d73-74b7-f5123c7f4362@collabora.com>
In-Reply-To: <6f1deed3-87e5-6d73-74b7-f5123c7f4362@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|PS2PR03MB3720:EE_
x-ms-office365-filtering-correlation-id: 297122ec-a981-4994-0c53-08daa08f98c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PGmLkkdvpkSazSw1s0Qfn7SCAjhotih0cEXbCuh1mUMvqP5DAWIY3dkidS7tB7p5mjh78sFPLSdDL/kfPQb8cXEuaEgC8YDooIY721sEWd5ZNLUMQVdImddMuRP/d+wQsFx/2tZaNgGqKJAqFyxgRW9aRX7IL9F2GLVnOx7ZtrUw7NQLwqH6bEDrc9fOf2E1glZ+NkADcVMThwNric0OXgohJPMVep8ljBmyjiS4JJzegpebdMb3rA+yQbn/oxc3sAjhVExk1fP7bhqxL1+XIxFIDJa7XqqPoutsi5yi0B7aSp3R5M0W8iea03s18Vbw4riZHoyja1FM1Tkxsjew1FwZ4S2scp5/Y4y7cFntBXSudK4aA4CGlmQSynWWOijKw/KKtfqMaurk6T2fNk04bWpEGoZkPt4ltodqgHuioEfFWJlGEv3QGYZ9XHh04b+2HbOfECOiC0P7lwXv8SVxYK66uqqUVcPhyCt6b1oerIkAE2cwCvjBR1zL9oKselx6u53P8193SysoLmN9AI1sbviGuUmFNbT5AdZIbqNup51xB9icOmlvf0fFHMpzTRM/QdhxVMS2+gsCM1KGL/EyoDeD1ujbMAC1O0xY4uE3+NPOge7c0AOQHCpJgFqkjyHDm7DiECDXzoc+6ohawZZ7UB/Iy6OEPbZ1sHXTopYvUUAbEpCPiLYQu+kiAHo52aaXN4bgiKKTbidxey+9vAIQbIY6EpzMOup0wIOEMPq+naidBxfEcDJm+aRs5A729UjCKm8e+rTKYg64YZirHbz/R8gWc0iGHQRspF7V/vWEnsuccbkZdrhZROhXsdfNKh/h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(36756003)(38070700005)(85182001)(2616005)(122000001)(186003)(83380400001)(41300700001)(66946007)(110136005)(5660300002)(4326008)(76116006)(26005)(8936002)(38100700002)(66446008)(66556008)(7416002)(6512007)(66476007)(8676002)(6506007)(478600001)(6486002)(71200400001)(86362001)(2906002)(64756008)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWxRU0YrRnMyYXFhZUpLZUY1bkdqNDV4Q1NZY2s0c2lWQVFDRUE5S0ZGMnBP?=
 =?utf-8?B?NWpyU3laZXo2QlBKN0t3QW9Ec01IUmFaeVJoejVlZ05URkJITEF6ZHFTZmd1?=
 =?utf-8?B?VEJRRFd4ZHRkSG41TlJTRE5vTE0yZ3R6YW9XNXhSdWZaUEZoQ3o1T3lvMGxS?=
 =?utf-8?B?Rm4wT0c1amh0dlZyT0E0TUZCaEcxMSs1NnNZM05JREdmbElselZaSkt4RmlO?=
 =?utf-8?B?WEVqNUNNdEI2c3k3QURwV2dSN3NWQW9nWGo5WDBYNExkOVBGTXpvRzFTaitw?=
 =?utf-8?B?YnYxTXE5UFc5QnI5a3FNSStJRDU4Nm1lOVhrYlVDVGFhVlRsZWxvMXgwcEM0?=
 =?utf-8?B?Si8rUlJCajcxQVRXdFA0eEYvZElqRUJmZ1dENjJUR2xlRWFYcFNRdkYvRXVz?=
 =?utf-8?B?MlhNTmFMSDdKNUlLTG1MOW15K1d2TElYRFc4QTVveEVtNS9yMTdBSTRCako1?=
 =?utf-8?B?QmV2U1pSblNERnkyR0FWQkNpRmdia3pjNHR2R3VKSDE3dTVCNklUSGxTR2RZ?=
 =?utf-8?B?UDFDL0Z2NkRQQmU0T1pKSC9KNGVrSnBoR3gwWFpiYi91RmNRUjM5RnhUMW05?=
 =?utf-8?B?bGJ6d0QxYnFGY2M5VnROcFpwejBlWU9pS3libnpuL3o3Umx3TE9jZVI1aXIw?=
 =?utf-8?B?ejZxV1FwUEFOR1BtZDR6aUdCdjFwWWRiZmd6cUtnYTZVSEFwMVdTQ254WFVN?=
 =?utf-8?B?bHQ1RGVIUlE0VmFMem9pUTVybTlaMWptbXp3aThjYVQ5a3dhVW1yZkRmRm1H?=
 =?utf-8?B?T3JFOEliUjFMbVZXR3dQS3dqenlKLzREenhQbnZZMDFqTFY3TWloc2JBdzYv?=
 =?utf-8?B?emhydVFpdlN2NlpJTnZHQnBXNWdUUG83M3RXenM4Z1d1c2FaMG9TN0RFbkZG?=
 =?utf-8?B?bHdBQzhkZE9hcjY1L1BCU1R6bnQ0QVlXenhEV0llMFZ1eWY1UGZGUXNRbnlM?=
 =?utf-8?B?NEY0Y3F6U1RCaHdNSDV4K3QzNXlqUDNBRWt2VStkL3R5Y2NLTDAvVjV3RGZI?=
 =?utf-8?B?Tnh6bkpOWXNhMTcvWXgyVnFPK21HSVdmaVVwVmRpMkUzcHJGYW5oVjJiTHc3?=
 =?utf-8?B?RW5NQjBOcElPNnA2czRYRkZLU1NwWE5vd0dEd3BtMy80SFdBSU1HbmNwUXNT?=
 =?utf-8?B?bzJzNjlVaWNOQjZpZEt3b3Ivak83WjlnSjV5ZWJueEs2NTFqTmM3cWNFWlRp?=
 =?utf-8?B?WmFxR25TZFZzUDFPRGpUak1YNFJ3UDZWQWR2dWpDLzUwblR2K0c1eFhNb0Vn?=
 =?utf-8?B?REcyRE5sKzlveit5UmVReXlxazhkeXhpWU1ENHpRcFpXalMvRjlLdmcvejE3?=
 =?utf-8?B?MlpBUEJPWG5uZ0VmekYyNnRQVU5rZnNNRHBmUFZ6cWNyelJYS0NaTEkzT2pG?=
 =?utf-8?B?OFppclJPK3B4YjlKM01GMmNmT3JtVXI1Snh0T20xUENuTERyd25HTzdUanow?=
 =?utf-8?B?eU9qU3phNW9Jd0F1YXlyQ1NLakpPbU0xNGwwdlM4Mm5ReVcyYkZ1UkNsaWVR?=
 =?utf-8?B?L3pYdTg1eXhoVUpFLzRKdjlpNktnSDMxY2habmpuSVdRbVNkdkFLNWE2L3Ev?=
 =?utf-8?B?OWRtdWdaWXhpSmFQWnpXUG1GMVlNd1pwZTdsSWJIRU1KL2FaTmNreHpKNTR3?=
 =?utf-8?B?Tld0aGRHc3RELzNIeElaWEpVby8vNU5XdHZ2YndPMVNkSGR1QStPckc0UFVp?=
 =?utf-8?B?RjJlTHhwSmVjK3BvSEs2MXlvYWpQT0g0OEVaN1IwR3dvSk90SlduRFVrMGpO?=
 =?utf-8?B?RDZPeXVhUy8zZkZRcDBoMFdPUytWUW9kdGh1SFc0ZXV1eGRYNU9SUFBPQ04z?=
 =?utf-8?B?QU1BZ1FITU9Nc2IvQ3Rrcml3V2FKeHR0V21Wa0ZHa2ZUZ0Y1SmNYUTFUelhz?=
 =?utf-8?B?WjNsbGpEbHB6SEF4cWNqUnF1NEV2R0tJVWRPMkJSbjBIZGxhbUNEVllCY0tm?=
 =?utf-8?B?c0Zyb0liaStBV05sT0ptc1BlK1hlT3Vva0FhVkRwMmhRMkdrNHdDRGxNTzJa?=
 =?utf-8?B?OXNVbmFXMzQ5OVFRS1pXZU9EVTBGbG56YWJkOWR3WkF3bWVWRUpYK1I1cVpJ?=
 =?utf-8?B?SkQ4L1k1NU01aGdyVVdUSjl3MFRJcDNCTmFkL3JZKzBsTzdGdVhuaE9jSjl5?=
 =?utf-8?B?VFFYNEl3WGd3RlJhYy9pYUVOT0tFcXhWdFdrOE8zVWt3VzBMVWRzYmlMZzFX?=
 =?utf-8?Q?9ngYy+JKr4xF7cDu193W/lQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67B9D5633402154F81C6DCE520D1ED7E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297122ec-a981-4994-0c53-08daa08f98c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 13:53:02.9942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRs388EbAhR1mlxRJywwcbSKrEZvws3/+jImLl5vog79lddbwwa425RQqWTHuY7b/PFHoZoXQQaU34SbM52aGGD7rnD7UOiVC8DlaVhA6sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR03MB3720
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUdWUsIDIwMjItMDktMjcgYXQgMTU6NDAgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAyMy8wOS8yMiAxNToxMSwgQWxsZW4tS0gg
Q2hlbmcgaGEgc2NyaXR0bzoNCj4gPiBBZGQgaW9tbXUgYW5kIHNtaSBub2RlcyBmb3IgbXQ4MTg2
IFNvQy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGxlbi1LSCBDaGVuZyA8YWxsZW4ta2gu
Y2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxODYuZHRzaSB8IDE3Mw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMTczIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODYuZHRzaQ0KPiA+IGIvYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODYuZHRzaQ0KPiA+IGluZGV4IDgzM2U3MDM3
ZmUyMi4uNjhmMDZiZWY4OGYzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4MTg2LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210ODE4Ni5kdHNpDQo+ID4gQEAgLTcsNiArNyw3IEBADQo+ID4gICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvY2xvY2svbXQ4MTg2LWNsay5oPg0KPiA+ICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCj4gPiAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gPiArI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL21lbW9yeS9tdDgxODYtbWVtb3J5LXBvcnQuaD4NCj4gPiAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9waW5jdHJsL210ODE4Ni1waW5mdW5jLmg+DQo+ID4gICAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvcG93ZXIvbXQ4MTg2LXBvd2VyLmg+DQo+ID4gICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcGh5
L3BoeS5oPg0KPiA+IEBAIC05NDQsMjQgKzk0NSwxMTMgQEANCj4gPiAgIAkJCSNyZXNldC1jZWxs
cyA9IDwxPjsNCj4gPiAgIAkJfTsNCj4gPiAgIA0KPiA+ICsJCXNtaV9jb21tb246IHNtaUAxNDAw
MjAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg2LXNtaS1jb21tb24i
Ow0KPiA+ICsJCQlyZWcgPSA8MCAweDE0MDAyMDAwIDAgMHgxMDAwPjsNCj4gPiArCQkJY2xvY2tz
ID0gPCZtbXN5cyBDTEtfTU1fU01JX0NPTU1PTj4sIDwmbW1zeXMNCj4gPiBDTEtfTU1fU01JX0NP
TU1PTj4sDQo+ID4gKwkJCQkgPCZtbXN5cyBDTEtfTU1fU01JX0dBTFM+LCA8Jm1tc3lzDQo+ID4g
Q0xLX01NX1NNSV9HQUxTPjsNCj4gPiArCQkJY2xvY2stbmFtZXMgPSAiYXBiIiwgInNtaSIsICJn
YWxzMCIsICJnYWxzMSI7DQo+ID4gKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNwbSBNVDgxODZfUE9X
RVJfRE9NQUlOX0RJUz47DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4gKwkJbGFyYjA6IHNtaUAxNDAw
MzAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg2LXNtaS1sYXJiIjsN
Cj4gPiArCQkJcmVnID0gPDAgMHgxNDAwMzAwMCAwIDB4MTAwMD47DQo+ID4gKwkJCW1lZGlhdGVr
LGxhcmItaWQgPSA8MD47DQo+ID4gKwkJCW1lZGlhdGVrLHNtaSA9IDwmc21pX2NvbW1vbj47DQo+
IA0KPiBPcmRlciBieSBuYW1lIGFmdGVyIHJlZyBwbGVhc2UuLi4NCj4gDQo+IGNvbXBhdGlibGUN
Cj4gcmVnDQo+IGNsb2Nrcw0KPiBjbG9jay1uYW1lcw0KPiBtZWRpYXRlayxsYXJiLWlkDQo+IG1l
ZGlhdGVrLHNtaQ0KPiBwb3dlci1kb21haW5zDQo+IA0KDQpPaywgbm8gcHJvYmxlbS4NCg0KSW4g
dGhlIG5leHQgdmVyc2lvbiwgSSB3aWxsIHNvbHZlIHRoaXMuDQoNClRoYW5rcywNCkFsbGVuDQoN
Cg0KPiA+ICsJCQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9TTUlfQ09NTU9OPiwNCj4gPiArCQkJ
CSA8Jm1tc3lzIENMS19NTV9TTUlfQ09NTU9OPjsNCj4gPiArCQkJY2xvY2stbmFtZXMgPSAiYXBi
IiwgInNtaSI7DQo+ID4gKwkJCXBvd2VyLWRvbWFpbnMgPSA8JnNwbSBNVDgxODZfUE9XRVJfRE9N
QUlOX0RJUz47DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4gKwkJbGFyYjE6IHNtaUAxNDAwNDAwMCB7
DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg2LXNtaS1sYXJiIjsNCj4gPiAr
CQkJcmVnID0gPDAgMHgxNDAwNDAwMCAwIDB4MTAwMD47DQo+ID4gKwkJCW1lZGlhdGVrLGxhcmIt
aWQgPSA8MT47DQo+ID4gKwkJCW1lZGlhdGVrLHNtaSA9IDwmc21pX2NvbW1vbj47DQo+ID4gKwkJ
CWNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX1NNSV9DT01NT04+LA0KPiA+ICsJCQkJIDwmbW1zeXMg
Q0xLX01NX1NNSV9DT01NT04+Ow0KPiA+ICsJCQljbG9jay1uYW1lcyA9ICJhcGIiLCAic21pIjsN
Cj4gPiArCQkJcG93ZXItZG9tYWlucyA9IDwmc3BtIE1UODE4Nl9QT1dFUl9ET01BSU5fRElTPjsN
Cj4gPiArCQl9Ow0KPiA+ICsNCj4gPiArCQlpb21tdV9tbTogaW9tbXVAMTQwMTYwMDAgew0KPiA+
ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4Ni1pb21tdS1tbSI7DQo+ID4gKwkJCXJl
ZyA9IDwwIDB4MTQwMTYwMDAgMCAweDEwMDA+Ow0KPiA+ICsJCQltZWRpYXRlayxsYXJicyA9IDwm
bGFyYjAgJmxhcmIxICZsYXJiMiAmbGFyYjQNCj4gPiArCQkJCQkgICZsYXJiNyAmbGFyYjggJmxh
cmI5ICZsYXJiMTENCj4gPiArCQkJCQkgICZsYXJiMTMgJmxhcmIxNCAmbGFyYjE2DQo+ID4gJmxh
cmIxNw0KPiA+ICsJCQkJCSAgJmxhcmIxOSAmbGFyYjIwPjsNCj4gPiArCQkJaW50ZXJydXB0cyA9
IDxHSUNfU1BJIDMxMyBJUlFfVFlQRV9MRVZFTF9ISUdIDQo+ID4gMD47DQo+ID4gKwkJCWNsb2Nr
cyA9IDwmbW1zeXMgQ0xLX01NX1NNSV9JT01NVT47DQo+ID4gKwkJCWNsb2NrLW5hbWVzID0gImJj
bGsiOw0KPiANCj4gY2xvY2tzDQo+IGNsb2NrLW5hbWVzDQo+IGludGVycnVwdHMNCj4gbWVkaWF0
ZWssbGFyYnMNCj4gcG93ZXItZG9tYWlucw0KPiANCj4gLi4uZXRjIDotKQ0KPiANCj4gUC5TLjog
U2FtZSBjb21tZW50IGZvciB0aGUgb3RoZXIgY29tbWl0cywgdG9vIQ0KPiANCj4gUmVnYXJkcywN
Cj4gQW5nZWxvDQo+IA0KPiANCg==
