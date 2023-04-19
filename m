Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFFD6E71B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjDSDih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjDSDic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:38:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDB140DB;
        Tue, 18 Apr 2023 20:38:25 -0700 (PDT)
X-UUID: a0211606de6311eda9a90f0bb45854f4-20230419
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Sw8keh5rYatayW9tkEyVFjqQPne9nlAKDwSrIEZD0Nk=;
        b=gKyWxhPxYQIea/F5JNSSJtVQoPVKTH1dbAu79LjQTYc8t3+BO2S0Pr2WHBnaYT6NG1XqSZF0WEuI7aTC+m+AgcbYC6LMsD95o2FV3pb4DKBWbfxQ/oYiG48tWaJKyudFWIn1GpCOyq/+9o1SPM+31Fsmz/Xe7scSyPYvFPRU5hA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8b536818-6e8d-47fa-be09-bd158ff77548,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:292f8884-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: a0211606de6311eda9a90f0bb45854f4-20230419
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1789717639; Wed, 19 Apr 2023 11:38:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 19 Apr 2023 11:38:17 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 19 Apr 2023 11:38:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ktp7g792VA7nofqs9ytj2np7jG1Q9QYcrM24vOs4SwYnWbVq/AGycW3kxLsK3GjF5U0N8DkfqLOBf8bT/Oar17HKJTprQYpHpLoVUSjRmJr9H3dN2x0Sv6jRPEe4Q1LO/AsWxu/r0V1AF1y9bke36PLUVbdZyaxukRwIg3BlVMp0f6C+6og39zW66FEG4gaiC9UUy0vgRAKstI1+ISdcWfbDaTft2seAWZZJdk7LMQQl3pAs6+/1n1TumJMgJmMewEZzfDcAcypgm9uDSlEnneKAdzUeTs1gun2oew98rCQzPdWCc3m0DbibpAf/AFEkiyWWymc5WBFW+HFcBobq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw8keh5rYatayW9tkEyVFjqQPne9nlAKDwSrIEZD0Nk=;
 b=ENGhp1/+VlHiijoJjnU2crBsCMR9HxKKXXSLEs365CUV+q8qBlf8HR8cGGGZByBOtyy7e8FD9LVGQWqRJVONhQuYLoYODCJx5Za2KxDwXt/DrNeEOan8d/CdqfB8VeyUVn/i5raFRP/Ytlmeua72kEtBSSC1YhwgVec6a+a7y/s0cYnSAjsfOzTeuxrVWc6IBwPuTkosJxBDQfOvoPacL7VonUHI7zRgpjyx2VAlULWTxsv26vrcwIlh20ABnGpwxSYgrnYbTYBW8QZpLtSnz+qjQDshas+TBFrqAggX2/2Zzwk5/GYOaBQndDUayRMjc8+lhiC4ZmO3ln2DSVDJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw8keh5rYatayW9tkEyVFjqQPne9nlAKDwSrIEZD0Nk=;
 b=C/v5xEDIiUBRfFBq3ZpIwp50gYH+2LH4S/ZyXVJO0dC6l/0RMCR3ps+nHEbdyRr0o2ks0qY/N7A7vcLs1SGKLU/kDtaCMpfuRf4yHWbKloSRS2WALJsgGNOybweaDFizW0NJF0FRoq2jiLGDyKmeaVl2HUQ2TuPspfgNTEqnCdo=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by PUZPR03MB7212.apcprd03.prod.outlook.com (2603:1096:301:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 03:38:14 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::d9b0:e117:9f08:3475]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::d9b0:e117:9f08:3475%5]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 03:38:14 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v9 05/11] remoteproc: mediatek: Extract remoteproc
 initialization flow
Thread-Topic: [PATCH v9 05/11] remoteproc: mediatek: Extract remoteproc
 initialization flow
Thread-Index: AQHZYRz7NOKolAghB0WgqNOx57Prf68VLquAgBzv14A=
Date:   Wed, 19 Apr 2023 03:38:14 +0000
Message-ID: <46baff1f95fa13976d7a07b5e50ff2175e464baa.camel@mediatek.com>
References: <20230328022733.29910-1-tinghan.shen@mediatek.com>
         <20230328022733.29910-6-tinghan.shen@mediatek.com>
         <20230331174431.GA3504605@p14s>
In-Reply-To: <20230331174431.GA3504605@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|PUZPR03MB7212:EE_
x-ms-office365-filtering-correlation-id: 7de2f678-0b84-4bb7-4392-08db408781d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4loOOYM1hU0mMFDhLz3QqEgiZRV4bYqB7j5Ue4YFWABel59u9vbVwuR6wtZMB9pL0fBb6tgcqt9VDrJrYLoX/YTDVsykbNZMh0XOClEzPwXbCSu7M1XVp23eSLByzdYQDbPlyM93KyzTezLIoGUmnt5VhnzOBodN2+I7ENyhGe6BZxaCbQFjrDnb6GMc4QuR+3iTXJIUgCGY4P0o6+ONVAfl70IIptsDGz35Qftrc5bKkasc7jnraWEnEUjRdMkD5qo0uWp9jUCoFF4XwLJ8H0YSmyNm1kOqtsd8suolsU5AD6vKGXtNUBeRrXUF+cVQY3OUhdH1O0H9tJoQArmrGnbj+kXkhQ62LAItRRT+DdlfLvg8RvFX9C7S4dCrB1MSe9864mHB8cBOcxsD+I5ABlk9oIr3c0zSD7uKHecmV2Qr0XpYIEdzZicvsieh7D/BZPmwHxZKC78sorP6W9Nou242VULrzgCPMz7E/LKBGfW5Oairg8LxUqa5KkgOkUhPVN4lJNWDv0VLy5/kQVRCi3Z41cuOD+Gu2gkYl1xpHUQwkLmtpmuT8pPqSWG5CuYFH7JKGmTCEBBh6VZRnxLXZvnDGJ73W+zRZKI1s94MNp16PC2jx6IUGtnyQWwFu3awIfcu7b/qPHy/MuTjAK6Hm1++1kKHZNXcR2QZknu0rDs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(2906002)(2616005)(478600001)(71200400001)(86362001)(26005)(6512007)(6506007)(6486002)(36756003)(186003)(38070700005)(85182001)(41300700001)(122000001)(54906003)(38100700002)(8676002)(8936002)(4326008)(66446008)(66556008)(66476007)(91956017)(83380400001)(66946007)(64756008)(76116006)(316002)(6916009)(7416002)(5660300002)(414714003)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEc1REduSzNOZXo1OE51VU9iSE1MREpOdXRJSzBjNWNBSWk3NGxKMnNGWjNF?=
 =?utf-8?B?RWJuQTkxdlN5N00wYjRhaDhaM1dmcUpFM3FLZjdzeEFxUDdaVmVvczN3TlRZ?=
 =?utf-8?B?RzBSQ05VVHdPcE4xeU12cUdGeHQ0Y1lHTjRKMU5uc3JuWFA2WE9SQXBWaWlh?=
 =?utf-8?B?dk0xaG1EMkUwUFBqZXh4ZWRwM1cvWGxoMi9hQ09CelkwZ3UzeHg4VzNwcnJC?=
 =?utf-8?B?TlJVZlpmODN4YlNKVjV0bitieWY0MkZoK24rL3h3QUNRbUVvemxONHhQQVdp?=
 =?utf-8?B?U3JxNHJUYnl1blBBdVFlUGloTnpaUytMS2haSEJIUjhMdmhGSm56bVBDZ2pO?=
 =?utf-8?B?WVNGVE1XWU1OcE9KYm91bC9KR0F5Zm1welJtK1RVN0ovcXQxblNuSjZkNXJ5?=
 =?utf-8?B?T1kxd2dLZmNGRHdYa3NWTGVnV1hFY1JLMXJoVjVoTUtFeWZJR0dnTVhiM0Zj?=
 =?utf-8?B?TmIwRTduM1pnd2s4a1BISm1qam9kQ3J6dlBuNjk3ZGxiQkpsMmJBVU9vNjBB?=
 =?utf-8?B?RTZiSTl2b0IzNmU3cldHVDY4dUZoVUlkditVVVlQRGF3TnJGSWQ0T016Wm85?=
 =?utf-8?B?NTk5bEtHeWdUOVdTZzRjN2NHamZVdmhEcHR0bU9wV203RmNpaVVTUi9pL1lj?=
 =?utf-8?B?SFRpWjJFMTk1eDJ5MnZ2Smd0TytnSnNKeTNrUXQrMm1xMzAwSHl3SFdqUnpX?=
 =?utf-8?B?bWFCSHk4SU9rVmdjTENucVd2OGZtZzRSdXM0UUFDSktYZFYrTVV5YnlTcTFu?=
 =?utf-8?B?Vm1KVGlYVzBTS2Jtc3RSTnZXTThNZVE1ellWVGZlYWhNWFhCbm9FUzRBaThL?=
 =?utf-8?B?TDVpL3JhaWpmWUh2Y3FaQTNPZVQ3Nm5tWnB6Q0F0b29oRGZ3U2tEUWhMMGdM?=
 =?utf-8?B?N2ZkaWpHZ040Y040NlI3d0swYVhieDBxbElnOERpd2lPekRZK055aVJyd0hu?=
 =?utf-8?B?ci9wRUtJT3hxVmJVeS9lSXNLWitjMmNpcmhHS0xvSEpZaE5XVkM2cmV2WG1T?=
 =?utf-8?B?THpmeGNxWEVlUG1GM2xUeGRwNFFQb2JhNWx2UENlWTUrbWJKazBtRkN1ZzhX?=
 =?utf-8?B?VFpUZ2lEdDhodjh6ckVxOEFBZ2l0UDhzK25vdDVxbW1oNzRuSm9wOGFSckxT?=
 =?utf-8?B?VFdzZ3Foek96VUJXaCtKU1BFdzVTRHZBUEVNYUZDS2MzaDI4MytIRXJIWFRm?=
 =?utf-8?B?QmtpWG9SZk81dHdtb2hQTmY3TkJMNjNBa281Qk5qcDRsWU40WVpQWi90VHph?=
 =?utf-8?B?Nkp6L25vOC9MMUlFeng0em9ZNjJWWE5TN0lSZU9PcFBVR1dwb0FNMzk1bmdL?=
 =?utf-8?B?WHFDUlAxdTJQVmVBdktHRTVQb0ExVlFLQXpwQWdubGdMNHdSSEJjNVNIdSt3?=
 =?utf-8?B?akpOMnBKUUp4dGN2QW9NUkdVUnUveGpLQjFFa3RFeFY0WGpqSDcvR1d4Mm0y?=
 =?utf-8?B?aThQeUdLV2lTajJPVHJRajZaYmplTGY3cVZVUTlldGZmTmtaTEgva3VGbGdl?=
 =?utf-8?B?RjI5NTZLZm85V3h4dXJqTDNndzc0K2Nqd3VmYk5jSEZxWWhHYlRTSDBmNGV6?=
 =?utf-8?B?ZlFtTWRTMW5jUTlCNjdwemNmOFA2K29GZjJ4M3FhRTJ4aXhYazRRc1Z0ZXJa?=
 =?utf-8?B?dW5kTkNrdnFhRWNBdFdpcDlVTG90OVA3dzJVVDVpRkI0cmE0VUxkMXBMYjV0?=
 =?utf-8?B?dTQ4UklBcHBQeXV3TTNPcml3RysyU1RaN2xSTWFHMW5uL2V4MmdpNUlJSWZn?=
 =?utf-8?B?eUp4dHozQ3lxWnNYaTA3dHErdTl2TDNtZXIzZnpkajR2QUp1RjNBQVQrOUk2?=
 =?utf-8?B?ZUl2bnV1RmNCVmV0WFc4V05rQ2IvdjA5K0FMMGptYURybFJpZU8zUmhUbGg1?=
 =?utf-8?B?SUxZSnRtbkovTW1tZWRGSkd2V2FxMG5sTGJWTmdWZEdFdGhndU1iVVZBSlJo?=
 =?utf-8?B?SlFTbEVrK25EZVFJalVqaWw0OUFRSkVJYnlFd1hSaTN3OVFldDk4U2ZhT0Ro?=
 =?utf-8?B?by9mZCtRVDRLbWJySDVXMGJVbkJnSm5UcVZFa01VbG9GejdWam5VeGI2NXRI?=
 =?utf-8?B?RG5JRzUvR2dtZ0F6eTMvQkVvSTBMQTgrNkJFekNRbFVnd1IzZzJLWmtNMUJq?=
 =?utf-8?B?UG0xZ0xWcWVieHBsVWNFUlRlVk9nOERteGE0V1hoRnQzWVB4TGcvTVM3VDU4?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7E13753810DC043AB9F6F83E1094A61@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de2f678-0b84-4bb7-4392-08db408781d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 03:38:14.5903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5VDdYSP+zYVgnkApikauVT2GjOnN+tPbIu8nuaMsfV4h48M1Eq+TDPHtgf1HpL+FwdJenCJ5+7KKIet7rYTepUPaTBhEw1pJJXRaDNMkWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7212
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlldSwNCg0KT24gRnJpLCAyMDIzLTAzLTMxIGF0IDExOjQ0IC0wNjAwLCBNYXRoaWV1
IFBvaXJpZXIgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5k
ZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gT24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMTA6
Mjc6MjdBTSArMDgwMCwgVGluZ2hhbiBTaGVuIHdyb3RlOg0KPiA+IFRoaXMgaXMgdGhlIHByZXBh
cmF0aW9uIGZvciBwcm9iaW5nIG11bHRpLWNvcmUgU0NQLiBUaGUgcmVtb3RlcHJvYw0KPiA+IGlu
aXRpYWxpemF0aW9uIGZsb3cgaXMgc2ltaWxhciBvbiBjb3JlcyBhbmQgaXMgcmV1c2VkIHRvIGF2
b2lkDQo+ID4gcmVkdW5kYW50IGNvZGUuDQo+ID4gDQo+ID4gVGhlIHJlZ2lzdGVycyBvZiBjb25m
aWcgYW5kIGwxdGNtIGFyZSBzaGFyZWQgZm9yIG11bHRpLWNvcmUNCj4gPiBTQ1AuIFJldXNlIHRo
ZSBtYXBwZWQgYWRkcmVzc2VzIGZvciBhbGwgY29yZXMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogVGluZ2hhbiBTaGVuIDx0aW5naGFuLnNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IFJldmlld2Vk
LWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdu
b0Bjb2xsYWJvcmEuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3JlbW90ZXByb2MvbXRrX3Nj
cC5jIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9yZW1vdGVwcm9jL210a19zY3AuYyBiL2RyaXZlcnMvcmVtb3Rl
cHJvYy9tdGtfc2NwLmMNCj4gPiBpbmRleCBhM2I5YmMxNThjZDkuLjMyZWNkMTQ1MGM2ZiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jDQo+ID4gKysrIGIvZHJp
dmVycy9yZW1vdGVwcm9jL210a19zY3AuYw0KPiA+IEBAIC0yMyw2ICsyMywxMyBAQA0KPiA+ICAj
ZGVmaW5lIE1BWF9DT0RFX1NJWkUgMHg1MDAwMDANCj4gPiAgI2RlZmluZSBTRUNUSU9OX05BTUVf
SVBJX0JVRkZFUiAiLmlwaV9idWZmZXIiDQo+ID4gDQo+ID4gK3N0cnVjdCBtdGtfc2NwX29mX3Jl
Z3Mgew0KPiA+ICsgICAgIHZvaWQgX19pb21lbSAqcmVnX2Jhc2U7DQo+ID4gKyAgICAgdm9pZCBf
X2lvbWVtICpsMXRjbV9iYXNlOw0KPiA+ICsgICAgIHNpemVfdCBsMXRjbV9zaXplOw0KPiA+ICsg
ICAgIHBoeXNfYWRkcl90IGwxdGNtX3BoeXM7DQo+ID4gK307DQo+ID4gKw0KPiANCj4gVGhpcyBz
aG91bGQgcmVwcmVzZW50IHRoZSBjbHVzdGVyIHdpdGggYSBsaXN0IG9mIG10a19zY3AgaW5zdGVh
ZCBvZiBAY2x1c3Rlcl9jb3JlcyBhcw0KPiBpbnRyb2R1Y2VkIGluIHRoZSBuZXh0IHBhdGNoLg0K
DQpJZiBJJ20gdW5kZXJzdGFuZGluZyB5b3UgY29ycmVjdGx5LCB5b3UncmUgc3VnZ2VzdGluZyB0
aGF0IEBjbHVzdGVyX2NvcmVzIHNob3VsZCBiZSBpbmNsdWRlZCANCmFzIGEgbWVtYmVyIG9mIHRo
aXMgc3RydWN0dXJlLiBJcyB0aGF0IGNvcnJlY3Q/DQoNCkJlc3QgcmVnYXJkcywNClRpbmdIYW4N
Cg0KPiANCj4gPiAgLyoqDQo+ID4gICAqIHNjcF9nZXQoKSAtIGdldCBhIHJlZmVyZW5jZSB0byBT
Q1AuDQo+ID4gICAqDQo+ID4gQEAgLTg1NSw3ICs4NjIsOCBAQCBzdGF0aWMgdm9pZCBzY3BfcmVt
b3ZlX3JwbXNnX3N1YmRldihzdHJ1Y3QgbXRrX3NjcCAqc2NwKQ0KPiA+ICAgICAgIH0NCj4gPiAg
fQ0KPiA+IA0KPiA+IC1zdGF0aWMgaW50IHNjcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiA+ICtzdGF0aWMgaW50IHNjcF9ycHJvY19pbml0KHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG10a19zY3Bf
b2ZfcmVncyAqb2ZfcmVncykNCj4gPiAgew0KPiA+ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9
ICZwZGV2LT5kZXY7DQo+ID4gICAgICAgc3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldi0+b2Zf
bm9kZTsNCj4gPiBAQCAtODc5LDYgKzg4NywxMSBAQCBzdGF0aWMgaW50IHNjcF9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgIHNjcC0+ZGF0YSA9IG9mX2Rldmlj
ZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiA+ICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBk
ZXYsIHNjcCk7DQo+ID4gDQo+ID4gKyAgICAgc2NwLT5yZWdfYmFzZSA9IG9mX3JlZ3MtPnJlZ19i
YXNlOw0KPiA+ICsgICAgIHNjcC0+bDF0Y21fYmFzZSA9IG9mX3JlZ3MtPmwxdGNtX2Jhc2U7DQo+
ID4gKyAgICAgc2NwLT5sMXRjbV9zaXplID0gb2ZfcmVncy0+bDF0Y21fc2l6ZTsNCj4gPiArICAg
ICBzY3AtPmwxdGNtX3BoeXMgPSBvZl9yZWdzLT5sMXRjbV9waHlzOw0KPiA+ICsNCj4gPiAgICAg
ICByZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVN
LCAic3JhbSIpOw0KPiA+ICAgICAgIHNjcC0+c3JhbV9iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291
cmNlKGRldiwgcmVzKTsNCj4gPiAgICAgICBpZiAoSVNfRVJSKHNjcC0+c3JhbV9iYXNlKSkNCj4g
PiBAQCAtODg4LDI0ICs5MDEsNiBAQCBzdGF0aWMgaW50IHNjcF9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgIHNjcC0+c3JhbV9zaXplID0gcmVzb3VyY2Vfc2l6
ZShyZXMpOw0KPiA+ICAgICAgIHNjcC0+c3JhbV9waHlzID0gcmVzLT5zdGFydDsNCj4gPiANCj4g
PiAtICAgICAvKiBsMXRjbSBpcyBhbiBvcHRpb25hbCBtZW1vcnkgcmVnaW9uICovDQo+ID4gLSAg
ICAgcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09VUkNFX01F
TSwgImwxdGNtIik7DQo+ID4gLSAgICAgc2NwLT5sMXRjbV9iYXNlID0gZGV2bV9pb3JlbWFwX3Jl
c291cmNlKGRldiwgcmVzKTsNCj4gPiAtICAgICBpZiAoSVNfRVJSKHNjcC0+bDF0Y21fYmFzZSkp
IHsNCj4gPiAtICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoc2NwLT5sMXRjbV9iYXNlKTsNCj4g
PiAtICAgICAgICAgICAgIGlmIChyZXQgIT0gLUVJTlZBTCkgew0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBtYXAgbDF0
Y20gbWVtb3J5XG4iKTsNCj4gPiAtICAgICAgICAgICAgIH0NCj4gPiAtICAgICB9IGVsc2Ugew0K
PiANCj4gICAgICAgICAgICAgICAgIHNjcC0+bDF0Y21fYmFzZSA9IE5VTEw7DQo+IA0KPiA+IC0g
ICAgICAgICAgICAgc2NwLT5sMXRjbV9zaXplID0gcmVzb3VyY2Vfc2l6ZShyZXMpOw0KPiA+IC0g
ICAgICAgICAgICAgc2NwLT5sMXRjbV9waHlzID0gcmVzLT5zdGFydDsNCj4gPiAtICAgICB9DQo+
ID4gLQ0KPiA+IC0gICAgIHNjcC0+cmVnX2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVz
b3VyY2VfYnluYW1lKHBkZXYsICJjZmciKTsNCj4gPiAtICAgICBpZiAoSVNfRVJSKHNjcC0+cmVn
X2Jhc2UpKQ0KPiA+IC0gICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJf
RVJSKHNjcC0+cmVnX2Jhc2UpLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIkZhaWxlZCB0byBwYXJzZSBhbmQgbWFwIGNmZyBtZW1vcnlcbiIpOw0KPiA+IC0NCj4gPiAg
ICAgICByZXQgPSBzY3AtPmRhdGEtPnNjcF9jbGtfZ2V0KHNjcCk7DQo+ID4gICAgICAgaWYgKHJl
dCkNCj4gPiAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gQEAgLTk1Nyw2ICs5NTIsMzcg
QEAgc3RhdGljIGludCBzY3BfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
PiAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gDQo+ID4gK3N0YXRpYyBpbnQgc2NwX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4gPiArICAgICBzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsgICAgIHN0cnVjdCBtdGtfc2NwX29m
X3JlZ3Mgc2NwX3JlZ3M7DQo+ID4gKyAgICAgc3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4gKyAg
ICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICAgcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNl
X2J5bmFtZShwZGV2LCBJT1JFU09VUkNFX01FTSwgImNmZyIpOw0KPiA+ICsgICAgIHNjcF9yZWdz
LnJlZ19iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gPiArICAgICBp
ZiAoSVNfRVJSKHNjcF9yZWdzLnJlZ19iYXNlKSkNCj4gPiArICAgICAgICAgICAgIHJldHVybiBk
ZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihzY3BfcmVncy5yZWdfYmFzZSksDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIHRvIHBhcnNlIGFuZCBtYXAgY2Zn
IG1lbW9yeVxuIik7DQo+ID4gKw0KPiA+ICsgICAgIC8qIGwxdGNtIGlzIGFuIG9wdGlvbmFsIG1l
bW9yeSByZWdpb24gKi8NCj4gPiArICAgICByZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnlu
YW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAibDF0Y20iKTsNCj4gPiArICAgICBzY3BfcmVncy5s
MXRjbV9iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gPiArICAgICBp
ZiAoSVNfRVJSKHNjcF9yZWdzLmwxdGNtX2Jhc2UpKSB7DQo+ID4gKyAgICAgICAgICAgICByZXQg
PSBQVFJfRVJSKHNjcF9yZWdzLmwxdGNtX2Jhc2UpOw0KPiA+ICsgICAgICAgICAgICAgaWYgKHJl
dCAhPSAtRUlOVkFMKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9w
cm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBtYXAgbDF0Y20gbWVtb3J5XG4iKTsNCj4gPiArDQo+
ID4gKyAgICAgICAgICAgICBzY3BfcmVncy5sMXRjbV9zaXplID0gMDsNCj4gPiArICAgICAgICAg
ICAgIHNjcF9yZWdzLmwxdGNtX3BoeXMgPSAwOw0KPiA+ICsgICAgIH0gZWxzZSB7DQo+ID4gKyAg
ICAgICAgICAgICBzY3BfcmVncy5sMXRjbV9zaXplID0gcmVzb3VyY2Vfc2l6ZShyZXMpOw0KPiA+
ICsgICAgICAgICAgICAgc2NwX3JlZ3MubDF0Y21fcGh5cyA9IHJlcy0+c3RhcnQ7DQo+ID4gKyAg
ICAgfQ0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gc2NwX3Jwcm9jX2luaXQocGRldiwgJnNjcF9y
ZWdzKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBzY3BfcmVtb3ZlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIHsNCj4gPiAgICAgICBzdHJ1Y3QgbXRrX3NjcCAq
c2NwID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ID4gLS0NCj4gPiAyLjE4LjANCj4g
PiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpUaW5nSGFuDQo=
