Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010A9697517
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjBODzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBODzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:55:20 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D25615570;
        Tue, 14 Feb 2023 19:55:14 -0800 (PST)
X-UUID: 8a5b17b4ace411ed945fc101203acc17-20230215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nOj2a4PFB5dHqgTudK3bwC7yiwvsjXVwV0MJ6AK9lQY=;
        b=KGLYoVyJlenKsyV4YuTCk5i6Yji0Jpypyg/2YJ8X70SB7R4xkqD7kKYaMQLdFI8piIKEcNGopgsM6qKeOZn9bipW9hJyk21UMNz2Smb1Uh/N5h0Bfnk5fbxcGC1SO7AtNuH7t76XXUZiYmqSZ15u74VEn8dQ//z2w4A3QbY6CkQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:00061f15-10de-45b2-9ba5-f8e653c8f18c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:39927bb0-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 8a5b17b4ace411ed945fc101203acc17-20230215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 481378102; Wed, 15 Feb 2023 11:55:09 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 15 Feb 2023 11:55:08 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 15 Feb 2023 11:55:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSACJ3u80Bzshz+POAjACXj0x34qON5/DLD3gAYWDPsIJcJyFj+MbWV6DgiKxG5Bu4tXOwIZEXo+DBz3T2COZ+h5Jn2qMdDoyqMkr7ZQ8G37n5Fi1nsE+syaXcD3v5KAa102UGntAF0v5eiOhy6jHN4HRO73B8BEjvTxwuY05QHryHhnkha1PzDgA9LF5FMeyeaar5LVvMbTKa7j7ZDGxBH1gRWtWj2SRMUQDCdHJCWAaunCc4R0x0Fk4vXSwtO7M5/3MclFmTqHaNhB61eoc/apsV1IcMk/LuVEAILLPo4i155s1BLmNr5Tdvcrsa1ZbjqSW7cCoCE57LzF/EjxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOj2a4PFB5dHqgTudK3bwC7yiwvsjXVwV0MJ6AK9lQY=;
 b=M52F8Ksuh56quTyloVt74zy8X1nt4UHBr5CLDRHqb1WtJMHKD+xBNf0FwWFmLfLKM9xBiqOTCUGQp80G5KXJ5mpSDLbojyR6euyfOpYurJOOgfATZEtBSfiYhrlQmT4OV9rA60GGFkPh3YaTD8vVjbG71AQr7x/eATdiN5u2WhItv6oLE9j2LI9ZVlhiFPMcyY8QyIREi0ykbUKKHW0OFsyQHU+PcsUu0sJ1VDHAOOh0jWBh9eWsQVb3EXPBPxVK9ej0UUeiFvVs3atZwoNbTcI2DUKx9PfR2LOEsP7+hBLYPcFBYx56TecYJKe+27etRxH2nZoQHoyn3NtcEq5o4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOj2a4PFB5dHqgTudK3bwC7yiwvsjXVwV0MJ6AK9lQY=;
 b=hM+Sdm0BshwmjEAf6PNjfmryh4u9uqrEQeO6GYO7bpS/61vwAakKFwJhWTFvxxb6SU3lfWjlC8/j6/ImDtnpuZJ0+MM0O2b6XqZFnUNGLUAqeSyY/Zs2xZ1E9l9iddV5FE1AhF5frZgIASzZUY11g9lgNU6BVm8mAhlFQQmVzTc=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by SI2PR03MB6195.apcprd03.prod.outlook.com (2603:1096:4:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 03:55:05 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dbe7:4943:de9b:bc96]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dbe7:4943:de9b:bc96%4]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 03:55:05 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v6 07/12] remoteproc: mediatek: Probe multi-core SCP
Thread-Topic: [PATCH v6 07/12] remoteproc: mediatek: Probe multi-core SCP
Thread-Index: AQHZP1yvOSoLf4CMF0esBRc8NVZmwa7M+HmAgAJrXwA=
Date:   Wed, 15 Feb 2023 03:55:05 +0000
Message-ID: <4f689207b29e07e38c8f77597d6d768ac4fcfc9f.camel@mediatek.com>
References: <20230213033758.16681-1-tinghan.shen@mediatek.com>
         <20230213033758.16681-8-tinghan.shen@mediatek.com>
         <407e8e4e-fdcc-26ab-0bb3-e03b59f0d25c@collabora.com>
In-Reply-To: <407e8e4e-fdcc-26ab-0bb3-e03b59f0d25c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|SI2PR03MB6195:EE_
x-ms-office365-filtering-correlation-id: 904ea18d-e721-407b-cd58-08db0f086c6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cof6lIIb+f5lSwP/xtAnq2NFqTsrPY1pYwty8OJKDxNJLS/s7tV1RgphbXYaNeC75yaAJf+P6va1ZmLvw3a6pbqcadjyiigI8BISq+1tb3Ml2WVgDM2blPyHs1nbWL33q/uTliZWx8Kxo7RYhih8YNUACDyN1BUrv8SxR3aGmYyCGBc4YtU2dpJsK+zEGH1yrzCSvWx4sqYxySuXmc2NlfwsXukm1XDjaPEIYIDH2zPQV+786S6mlwS5B9PiwD/XBTwN7eg70d1db6NH0EPYLSzCkCrhCM53W1OQIYzUYRbyQVSLTy2NTrYSaIjeo/ccjUhGu1BFFIHa18o+71PljS0eiZ+Ai3XtOF6jmHER9hWeAO1Zh/7CPZC2hiJYV1H2DUiQME/PT6QF20n/PG71PfcvuLPm1ca8cD+//8/ZxyKGczQYPsRmmUZ8sHQxCN+ButmT+l/7fb3k1mGdby5VDLu+A8ZjCs3IaJrc6MXIy+oFtKw42gOunp5I+x/C6h1M5S5HSHXdfNmBsUNSpwLA+frieWIQXOan40krH0EX7feYp0/L9wrHXgKEzHNxJv1F+k1nSsVM34E1oYVTSafBe56j5LCjYyMES3hnNcf0W7SoTMBIBcXBIyR+ULDyxGJTv8bOfnFi5lx15hscw3fyebX31/VmBgTfDcMWC0hoSRF+5vxPhzg5rGll3jl2eUu2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199018)(6486002)(83380400001)(85182001)(110136005)(316002)(54906003)(122000001)(38100700002)(38070700005)(2906002)(107886003)(2616005)(478600001)(91956017)(86362001)(41300700001)(71200400001)(8676002)(4326008)(64756008)(76116006)(66556008)(66946007)(66476007)(66446008)(26005)(186003)(6512007)(5660300002)(6506007)(8936002)(7416002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWRxcFVWUnpZc25ySUw2WGxxQ0hFdFVXWmxyNEtsZ1NES2lUb3dHVmFqY2ww?=
 =?utf-8?B?MWdrMGJ0bDhmWWtXcmNiN2tlSG0wbTNDK1ZZZjR1cFNtSVJYcFJoaDliV096?=
 =?utf-8?B?OVRnaU82TjBQR1lPL1FlWkx4WiswNWJ0M21idFRCamhwbERPTzZXWjZxeWlM?=
 =?utf-8?B?dVBML3Z2TmIzMzI2RWxFNFRrVTFib2F2dGZsck5UaVdRYmw3ZUs3eE5KSVAx?=
 =?utf-8?B?TTVGY0NQRUhiRE1wYXh0WVFOVXV6K21OdWNJUWdNbStlUktSOFdLVWxvbXpj?=
 =?utf-8?B?MitnS0FhK3A2bXZFQ2NBL1ZEbVBnWHdTb0tkNnJ2b3F1dk16cnZsSXBIdjFk?=
 =?utf-8?B?Z2tDY2toV1p6TDVrc2g4Q3k4QzhBWTY5TU1peUZ2YkxPUXRIZG8ycXVybjVi?=
 =?utf-8?B?MTdkTElOcnkwbkpZYmg5NnNOckltWEtVcWJ5L0RxbmFvSCtjMHUrUVo3bzVa?=
 =?utf-8?B?a1lndmNQQ3M5U0p5Y1JKbU5xTEtuOE5mYWliTlFYWmVRakVraGlTZTgzVGZ5?=
 =?utf-8?B?U2VNUFZxZ0NPU2dqek44cWh0VXdWeUJSUWtKRGpSL1dvZ0pXTDZEa1NCY0Fu?=
 =?utf-8?B?eFBUQ2p6SzAwOVVnWVcwNUpLVVhsbGhvWEFMWEc3aldxSHM5WjI4VnhIN09m?=
 =?utf-8?B?QW5WcjVOTXJhYzJJTGxpR0tkK3RQNDNHWnJwS3lyam9ZMkhuSllDVU5CekFF?=
 =?utf-8?B?ZDFBemMvbEY3MERGV1cyYzFMY2NxeW9WZ3pCMVhxR0xDTkQzTFAzUXVWT1I2?=
 =?utf-8?B?NDNLNDR0d0YrbWJmTDZhVWVGSE5XQ1Z4eGJKempZampiMjhQQk5lNkQvQkty?=
 =?utf-8?B?RmR6VHd6UUtJK3ZrK2EvT1BIMnUwVUZTcEpYdDdaaEkycG1rZFF5TFcvTXBo?=
 =?utf-8?B?TU9iNVQ4Z0pDTjk2cTY1Wmk4UjcwYTAxTGRMVE1rTEhnTkE2S1pFVEhjbmVN?=
 =?utf-8?B?blBQbkJ3WWhOc3JOZFZkVldmWDcyUk5vSW94WTRTbUcyT2VsZUczL3k1M21Y?=
 =?utf-8?B?N3hnd1JBSFBNZWZYa2dYZmJhWUJ6N0daMjhOT21XdEN2d2tlNnFFUnRGV0V1?=
 =?utf-8?B?M09xWGxzdTZ5ME9sUTYwRXN6TUc0SStGVVBMVUprSm1VOFBIdzhFS2VCM09R?=
 =?utf-8?B?RFIwREJRa1VsK2lCOFRtSFltY0NFbDdoYm9QeDk4MlFwM216YXAvR1dNMkoy?=
 =?utf-8?B?aEh4MEZvV0pTSlB0MWFrRHVJSGpWL3NsQWpFMnJKcFhsbEdEMWlTbkU4RUVF?=
 =?utf-8?B?akk3c0g5eXhtT2wxTmh5bkRwaHNNVXJMQzd6VS8yYzBXa0VrRThpbDRPWjZ5?=
 =?utf-8?B?Mm1kT1BoUWM1bG1JcCttUXVaSkRRa2c4VDZQV2I1OWJZK3ZURWRlZGZITHB3?=
 =?utf-8?B?bzVzZDl3ZDVpY1NTZ1hjcHAyUEVORERrYi8ySStSSU9tRkpNeDJTRlhlZDRk?=
 =?utf-8?B?bXZxTFNubks0YS9OOW9NYjZBdnlMazM5aVhHdUNwY0pMWEx5WGsrcUFjM2xX?=
 =?utf-8?B?bzRTRHBCM3dZZng2QlVBd3prN2k1YkhxTmFRamdIRjlCeGRqUHVyV3VHS0JI?=
 =?utf-8?B?WmI0STZOU2E0VkZMMHNicnVsR3RldnVKVXBtVVdKNVBOcmhENmlSMkdkemVl?=
 =?utf-8?B?dWhrc2QwUnZ3ODRwd29UQUVDVmx4ZkZEUkU2dlF1ZUx4aXV0b2J2L2tPTjRI?=
 =?utf-8?B?TFlyZzdremZvV2Y0SFJsRjd1WjJ1RXJVaGhacmJ2R2krRHRVd25TRTVPRnRp?=
 =?utf-8?B?UFowVk5wTm5uUkEvL3dCclp5ZzJIU1FFQ3RRcUM5M1Q4djU0V3VDMTNQVFNS?=
 =?utf-8?B?MS9tYVdUSGNyN1VtTXBMNkJDeWt6RWt2UjFqbGtXM09jQndkeG9NV2VoNWly?=
 =?utf-8?B?NDVTNXlpOVkvbG1WNlF4NCtsY0Qvc1QvaC9Pdys4cFVIclJuQzZwTUZHME56?=
 =?utf-8?B?UG9sUitTNlBTbGd4bXRJNis3WFJPUk5XTWlmeDNxTWFlYWl1NTJKWkVpczdW?=
 =?utf-8?B?bE9xUGlIdVhBWEUzZVlsK3R1YVo4K1BHTFpQMXJrYXRINEZYRmpWdUk3d25B?=
 =?utf-8?B?SzA3M1JXUHVua3NmRTJyV21UWno4VTk2SEpQNmJlamZsVUFKSTNibEZuSXdV?=
 =?utf-8?B?MGxjRVI2Zlo3WWRKTDR1NHVRbDJUZTF4bm9hWi9iWk5sOFNMZTJQaXM3VWJt?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D73AC3B89C5E64A98A739EA3C12820C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904ea18d-e721-407b-cd58-08db0f086c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 03:55:05.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+AgjhP+WRfX6U4xHhIlhHXUkZvWS9LrbP2RTn0zTEzqHc3MgXWzu3L4IyL4fpmOG+DGyCTMr/JqwFbFOBQcg6Q6Dxa/txdeweOw/6scqKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6195
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTEzIGF0IDE1OjU4ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTMvMDIvMjMgMDQ6MzcsIFRpbmdoYW4gU2hlbiBoYSBzY3JpdHRv
Og0KPiA+IFRoZSBkaWZmZXJlbmNlIG9mIHNpbmdsZS1jb3JlIFNDUCBhbmQgbXVsdGktY29yZSBT
Q1AgZGV2aWNlIHRyZWUgaXMNCj4gPiB0aGUgcHJlc2VuY2Ugb2YgY2hpbGQgZGV2aWNlIG5vZGVz
IGRlc2NyaWJlZCBTQ1AgY29yZXMuIFRoZSBTQ1ANCj4gPiBkcml2ZXIgcG9wdWxhdGVzIHRoZSBw
bGF0Zm9ybSBkZXZpY2UgYW5kIGNoZWNrcyB0aGUgY2hpbGQgbm9kZXMNCj4gPiB0byBpZGVudGlm
eSB3aGV0aGVyIGl0J3MgYSBzaW5nbGUtY29yZSBTQ1Agb3IgYSBtdWx0aS1jb3JlIFNDUC4NCj4g
PiANCj4gPiBUaGUgcmVzb3VyY2Ugc3RydWN0dXJlIG9mIHRoZSBtdWx0aS1jb3JlIFNDUCBpcyBh
IGxpc3Qgb2YgcmVtb3RlcHJvYw0KPiA+IGluc3RhbmNlcyB3aGljaCBpcyBkaWZmZXJlbnQgdG8g
dGhlIHNpbmdsZS1jb3JlIFNDUC4gVGhlIGNvcnJlc3BvbmRpbmcNCj4gPiByZXNvdXJjZSByZWxl
YXNpbmcgYWN0aW9uIGlzIGJhc2VkIG9uIHRoZSB0eXBlIG9mIFNDUC4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBUaW5naGFuIFNoZW4gPHRpbmdoYW4uc2hlbkBtZWRpYXRlay5jb20+DQo+ID4g
LS0tDQo+ID4gICBkcml2ZXJzL3JlbW90ZXByb2MvbXRrX2NvbW1vbi5oIHwgICA3ICsrDQo+ID4g
ICBkcml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jICAgIHwgMTc3ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE2OSBpbnNlcnRpb25zKCsp
LCAxNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZW1vdGVw
cm9jL210a19jb21tb24uaCBiL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfY29tbW9uLmgNCj4gPiBp
bmRleCAzNzc4ODk0Yzk2ZjMuLjYzNWIxNzY3NmRlOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3JlbW90ZXByb2MvbXRrX2NvbW1vbi5oDQo+ID4gKysrIGIvZHJpdmVycy9yZW1vdGVwcm9jL210
a19jb21tb24uaA0KPiA+IEBAIC0xMTIsNiArMTEyLDEwIEBAIHN0cnVjdCBtdGtfc2NwX29mX2Rh
dGEgew0KPiA+ICAgCXNpemVfdCBpcGlfYnVmX29mZnNldDsNCj4gPiAgIH07DQo+ID4gICANCj4g
PiArc3RydWN0IG10a19zY3BfY2x1c3RlciB7DQo+ID4gKwlzdHJ1Y3QgbGlzdF9oZWFkIGNvcmVz
Ow0KPiANCj4gWW91IGRvbid0IG5lZWQgdGhpcyBzdHJ1Y3R1cmUuLi4gaXQncyBqdXN0IG9uZSBl
bGVtZW50IGluc2lkZSwgc28geW91IGNhbg0KPiBzaW1wbHkgYWRkIGl0IHRvIGBzdHJ1Y3QgbXRr
X3NjcGAgaW5zdGVhZDogZm9yIHJlYWRhYmlsaXR5IHB1cnBvc2VzLCB5b3UNCj4gY2FuIGNhbGwg
dGhpcyBsaXN0IGBjbHVzdGVyX2NvcmVzYC4NCj4gDQo+IEFmdGVyIHdoaWNoDQo+IA0KPiBSZXZp
ZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVs
cmVnbm9AY29sbGFib3JhLmNvbT4NCj4gDQo+IA0KDQpObyBwcm9ibGVtLCBidXQgSSBmZWVsIHRo
YXQgdGhpcyBjaGFuZ2UgaXMgbm90IHNtYWxsIGVub3VnaCB0byBoYXZlIHlvdXIgcmVpdmV3LWJ5
IHRhZyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KSSB3b3VsZCBsaWtlIHRvIGhhdmUgeW91ciBoZWxw
IHRvIHRha2UgYSBsb29rIGF0IHRoZSBuZXh0IHZlcnNpb24uDQoNCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpUaW5nSGFuDQo=
