Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FFD61EF46
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiKGJls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiKGJlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:41:46 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED42DD4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:41:40 -0800 (PST)
X-UUID: e877668e4ad04566acad40daa6537d19-20221107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=84PXzgCcuNCzUgOH5NeEORQamStSZEsCZQIinDzGyac=;
        b=sRKvrAVyw0W0X8QCzkmqgezIUqEimt1r1nDjUcbEN4qkbO3P30v6Fn9/q4pO90P75YNLU31wRZrGnEetlNvcyoWIJprck9l/JBVV+FRUITcsAfZDu/ikvCKzBo7DZQAvBwKp9nyThjxYcNWP3cwN4z236ANMlN+9T3y+FXiH4JM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:a8a1e40e-6710-4ebf-a7d3-61ea50ff5ab0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:a6a3a9eb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e877668e4ad04566acad40daa6537d19-20221107
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <jian-min.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1962453662; Mon, 07 Nov 2022 17:41:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 7 Nov 2022 17:41:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 7 Nov 2022 17:41:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKbbvM4ZndPatVxlEvBCZbvRSiBnmum5uqsJBTbrIGy2cxr8AIgmo2zYdaXX6zMa4YqgTsHAVsh5uF5ddw1qSTDa/0cXK1x45Fqw9OaAsywyrPiy8/UwAz+uTjeAFE4jfoUe3FRyIKo6Q7a4Z9v1lMjVQfejynGUlY7JyBtGFUTWbKvQw86QRwM2tFR0hnROZfhK96ilWWq6s1SIrL2+ksXkNZHUU1JA7eawn0HTJVIp6XQhXsocn9W/7B+ZkY3twQCyt5Ima1uDWDFowEdqRSDwSLFBQPbC0Jlj5qq2n2kFWh+YLDqGf5ixlny9fRTWXUoJFZX0O0BtKydizOfGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84PXzgCcuNCzUgOH5NeEORQamStSZEsCZQIinDzGyac=;
 b=Ha9HXeQ/NwVzFJcb/D0tiPLN7ILxSH8ypnTZCHNgObRuDW1HwG9pqB6I8MfqLGLKIp0U2aC118oN5KX9/Paft6NGXZJQ5jfUDHzMYsnGWXv9g1iE5Dz7rc7SICn3HcZB4LNqychuckK7EMGBJPNmaL58l5o3g6thXeyTAP+WYic4FJ36CIGWTxnVUGp6JqVExa7oWF9opKKihaFVGLIF4WGKsnzS++uzjxJVykg/CHWVDLZM+FxzZ7Rfxs3NNCgsYvYE5LWZ4io2NuDCXDuOpetWNNUP4ILkFdNBEP1AlIR7DI6Y1IYqIUBU20Fx6Z3jSJGA4v1vF0rimkB1O7G7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84PXzgCcuNCzUgOH5NeEORQamStSZEsCZQIinDzGyac=;
 b=jNkFI1JZ20ZfDNPyS1EsaVhppSXqSXqrucPTZfLaNH9O6s/2czg6xyUAifuuubU24KTeTIVImS3n/nByEurtUfPBYSY7S+X/4tWU+6wkAlWimUEg0M2TaV/qUKVG7iiC6tRBjPo/uSfhTfoyI3D+5TpgvlXJoj6wyAmB8TGJe9E=
Received: from PSAPR03MB5254.apcprd03.prod.outlook.com (2603:1096:301:4d::8)
 by PUZPR03MB5823.apcprd03.prod.outlook.com (2603:1096:301:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 09:41:29 +0000
Received: from PSAPR03MB5254.apcprd03.prod.outlook.com
 ([fe80::b8bb:3a65:53a3:c60a]) by PSAPR03MB5254.apcprd03.prod.outlook.com
 ([fe80::b8bb:3a65:53a3:c60a%8]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 09:41:29 +0000
From:   =?utf-8?B?Smlhbi1NaW4gTGl1ICjlionlu7rml7sp?= 
        <Jian-Min.Liu@mediatek.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        =?utf-8?B?Sm9uYXRoYW4gSk1DaGVuICjpmbPlrrbmmI4p?= 
        <Jonathan.JMChen@mediatek.com>,
        "vdonnefort@google.com" <vdonnefort@google.com>,
        "qperret@google.com" <qperret@google.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Thread-Topic: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Thread-Index: AQHYu2wCqHDV919CVkmxzM5DdbM5LK3pBAuAgA1WD4CAPUlEgA==
Date:   Mon, 7 Nov 2022 09:41:29 +0000
Message-ID: <64aedc190a7f3fc91967f42b2ad7ca244df63f89.camel@mediatek.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
         <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
         <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
In-Reply-To: <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5254:EE_|PUZPR03MB5823:EE_
x-ms-office365-filtering-correlation-id: 0c441c27-bdf2-494f-771e-08dac0a43f38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: chA0AiQVozMMgdCt67mrLoADa8IH/bieHESLbXLTlUFdJA98v5sTZ3BRDVPz0NQFOv0azKyxNqsvHbqPxFrS4DJws8VjfbIagL9EsQ2/Y5WEc/hCmklK7XhilTWK0AVw5axuw6wywsyg+TZBlUMyJM/vOKErHiluN9pgfS/5AlpX9EbehmDOWOOMQcy0hYg+03VIp2S6Kn+Dm3DOfHuPwOZQMzCX1msuEuaT2JTVXc/CUVMk0/BUUouwdrfhhegwSPPR2AH/2hNgsSF0AQyvYYPomU3fHys9h7nx8aGaW6wUGpp+bJ+KfbLqeyQ+ULHgcGI3evV6/ihcNdztPlpCv9Ui4NfYwFM3jBCX28fT/jkq6a+cIEGcYg6ff1mdise8oyyT5KmFpE477X0F034FEuEnPDPgcf9Or7XAcAytUXpSw70eIfhCgI5WnZ9wjVIkXwC0QWKAHzbJZF8oFkoFCCm27PyShrrsZUIc3tnao4EbJ+38cXI7OcmkZuYkGWbtsDFr+1XNAAXoFSK8xslZz0UuPZRkA5ZHHca9j1z+Xo6Vwr0HT0qzDt+UJI3/UxCgw/JRw5C7KvTZL6Y+agpo9uWbRi64abfvaBjbQ9CInpRP06C6jlx68OW4UiVK3c1c0a/kn9Yxa2ab/ByRE7KCg72KABQt0CDQ1YzBUvvhKHeDe33HE99osva+FfPKB3hXLuET1Ys8dTKQ3g5U5lrCAVm3tdWUDGOE0OA6OZDlPXhdWjzkPBk4kxphkMyKT8Hd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5254.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(6486002)(71200400001)(5660300002)(8936002)(478600001)(41300700001)(7416002)(2906002)(6916009)(54906003)(66476007)(66446008)(316002)(76116006)(66946007)(66556008)(64756008)(91956017)(8676002)(4326008)(83380400001)(38070700005)(38100700002)(122000001)(6506007)(86362001)(26005)(6512007)(2616005)(186003)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkJkamRBOG1SWVp3UkR3aEFvUTFaeFIybFd1MlM1SFNhblJRMDZIQUpDM0M2?=
 =?utf-8?B?dmpaVnFIOXROblQveGgyNHBNLzRHS0V5M1FFWHNncmRuUGIrS0RXRzAzUnFS?=
 =?utf-8?B?WGtGcm16Nkx0dFdUT2xHZHVtVjlaVytaMC93RVBnWnE3MWF4VkdOUGZoUHJG?=
 =?utf-8?B?T0FZOTBKcXlaVDNlRFBzVkYrVnRTZStHOEVITXBRZ1FlV2dtdGJoV2pkbEJ3?=
 =?utf-8?B?RnRac1NrNHNvMDJ3M3dTTGN0dnNhcytDT0tldXRyMDdxc2FSTWdmdUh4OWhP?=
 =?utf-8?B?dG15R2k0RndBSzMybjIvSXNsWlhoTWZGK25MY1VDTUFpMXV2K0FOYlR1UFla?=
 =?utf-8?B?Q1ZVTkM5VUtVNXl3MVpmdkVJbHRsUWhQd3lHWHJzTDFkdTdXTmlxVlFrVll3?=
 =?utf-8?B?dXNnd1dqQm8vTkxRUzNEc282OUQyUnh5MG04dkNtazd3Z3VNR3JPeXUzd2tS?=
 =?utf-8?B?dW45TWUzMWFldEc4TXhIOTM3cmhnazNkVXNmdHJ2ZXZGSWcxUDJabFVpVU11?=
 =?utf-8?B?U0FVaHlZVlJkS1dlM1pDZ1RJMUJ2Y0crb1RvcHZ6dm1SVjFIZnpFdGkxSS9K?=
 =?utf-8?B?RjVxMDB2cHB5YmxiVmMvRWd0UWQ2cG51b1dvUzlRaHV3Q1BYUi9zK21PanJS?=
 =?utf-8?B?a09LNDd0UjloeWdSS1hzelFVNjVVbjJQdDFNaG96K1F3NSt5R3IxSHJ5eVJB?=
 =?utf-8?B?OEdISWtESGd3V1BSL3Z1dURtUUJxM1lPb2gvd3NZQjJiT0c2akw1UmZxN2Zl?=
 =?utf-8?B?T0lneExsUUk4K3pXYVJPWmxDeVV0aEd1V21KRzJPRE85MTNReitRT1V6elZO?=
 =?utf-8?B?eTZRY2tPNFZ1em5QQ0I4MmFBdVcySGNLYUJyVkl5alYvd1FlVVdWN0VPMGx2?=
 =?utf-8?B?a0p6bVYwUzJsZUFURmcrNnlyZ2R3RUE1SldFczFLY2k3UjFUMlNBd2xEdGQ0?=
 =?utf-8?B?VTYzMFE5dVJSdnZaYUdKblVpWEl3emhRcW1EQWhORkx5cGlxT1Y2TFNXRndh?=
 =?utf-8?B?c0FnNUVQTmNoYWljVk1oS09hZmtHRHlQc0ZVWU54S3hqNlZhVXhPMkZHVHNs?=
 =?utf-8?B?WWs0OTFGTGFBdXM4N3c1dmpnTlloSzNMNnNzV1lTbEpYM25HRVdrdlFwNVBu?=
 =?utf-8?B?NlhORHY2N0dlUWZmUllOZGxSeE85b2hVa09wVjZPUUJmSm5hcDdNYnpqajlI?=
 =?utf-8?B?NkhxZndEbU42a2lucko5a1BFTHdIWkMwWUt5dzhuQnFzSGpickJHSVhzN0JB?=
 =?utf-8?B?QTVFdlNNVFZ3YVdsVVJDL1BicVNaNlZRb2luQWZIUCs3VEEzZXBibHloTk1C?=
 =?utf-8?B?MGVnb2IxODNSVmRFUW9mSnZ3MHF0WU1IN20rVFprWWhhZnFaNHl1aXhVaDF3?=
 =?utf-8?B?UjJmaUZqZkU4dGdEZm1aRGoxeTlnaUs2Q1AxSGdXRE1na3NlWVo1MGtDVFhJ?=
 =?utf-8?B?N1Y2MkErZmlxajd4NDJleU12bFdyTHQ3dDE3c2dxNnNzNjF2bkE4QjFVVUxF?=
 =?utf-8?B?REZ5aHhZZ1pqbnRxQWpMeEdGbytncEN4R2dzeXJhSjljVml2Q0gwV2hhRTVL?=
 =?utf-8?B?QTMxL2FWYitmOWJwQUV4MStYM1YraEszLzFNWjQ3amM4VzZRWCtIdkFPTWYv?=
 =?utf-8?B?ZUpvU0RXNUZnN3liSmNQNG1VdkFlZzlGdVM1bldWTENhTGxudUNWODVIRmhh?=
 =?utf-8?B?MVZwSG5Ic3JDU3paRTl5T3NyQnRvMjIvdFVsVmZYMEx3T2xNSDQ0K2NWakl3?=
 =?utf-8?B?T2VmTVZQaC9ZZ1VWR0JDeFN0a1dPQ0c4ckFKZnVvY0h6QUJhK090UVhVdmVl?=
 =?utf-8?B?dGsxOENubHMzTG9VbFdIbWh3eUhXejlMcU1qZlV6b3pvdldGaDYvenU2V2xw?=
 =?utf-8?B?UzRxbkhDZWJYNUF0Wmd1aU1hSENwRCs0MXVwOWpNam1uS2VaMXRCU2hOZDhu?=
 =?utf-8?B?NytQTWpkM0J4cVBpL1ZSQjM4YXRpc3N5THZOUVE0bk1UQTNKR1Y2UFdERGo4?=
 =?utf-8?B?bGJMYzc0K2VOUmE1RkpxaXU4UVRZZEhyMnlwVUFaM1YycDNsSHM5UjRxUmhx?=
 =?utf-8?B?QVhxUU0ySGNJNG9WYjhJR256TlM2T1ZDRG54dEQ4bkhLeE5BTXZCSWt2OTU5?=
 =?utf-8?B?cE1EeURJcXJWRnhFbC9FSy9tSXl0TzFvMVRKdTNZVEFWNW5DV3VYN3VNUElK?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6862395F8DAC144AE494D2BA851ED47@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5254.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c441c27-bdf2-494f-771e-08dac0a43f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 09:41:29.3556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUx1EiGjP34w4PxuaGVyuTYW1j4riKxi30zQ7odRJEXihRbkrn23OFR8lBN446Ra3OPOpaYHIkrOvQkiB2cH5yv/uDxs/hNn67taq2/ito0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5823
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIA0KDQpPbiBUaHUsIDIwMjItMDktMjkgYXQgMTE6NDcgKzAyMDAsIFBldGVyIFppamxzdHJh
IHdyb3RlOg0KPiBCZWNhdXNlIGl0IG1lc3NlcyB1cCB0aGUgb3JkZXIgaW4gd2hpY2ggcGVvcGxl
IG5vcm1hbGx5IHJlYWQgdGV4dC4NCj4gV2h5IGlzIHRvcC1wb3N0aW5nIHN1Y2ggYSBiYWQgdGhp
bmc/DQo+IFRvcC1wb3N0aW5nLg0KPiBXaGF0IGlzIHRoZSBtb3N0IGFubm95aW5nIHRoaW5nIGlu
IGUtbWFpbD8NCj4gDQoNClNvcnJ5IGZvciB0b3AtcG9zdGluZy4uLiANCg0KPiBPbiBUdWUsIFNl
cCAyMCwgMjAyMiBhdCAxMDowNzo1OVBNICswODAwLCBKaWFuLU1pbiBMaXUgd3JvdGU6DQo+ID4g
DQo+ID4gVXBkYXRlIHNvbWUgdGVzdCBkYXRhIGluIGFuZHJvaWQgcGhvbmUgdG8gc3VwcG9ydCBz
d2l0Y2hpbmcgUEVMVA0KPiA+IEhMIA0KPiA+IGlzIGhlbHBmdWwgZnVuY3Rpb25hbGl0eS4NCj4g
PiANCj4gPiBXZSBzd2l0Y2ggcnVudGltZSBQRUxUIEhMIGR1cmluZyBydW50aW1lIGJ5IGRpZmZl
cmVuY2Ugc2NlbmFyaW8NCj4gPiBlLmcuDQo+ID4gcGVsdDggaW4gcGxheWluZyBnYW1lLCBwZWx0
MzIgaW4gY2FtZXJhIHZpZGVvLiBTdXBwb3J0IHJ1bm50aW1lDQo+ID4gc3dpdGNoaW5nIFBFTFQg
SEwgaXMgZmxleGlibGUgZm9yIGRpZmZlcmVudCB3b3JrbG9hZHMuDQo+ID4gDQo+ID4gdGhlIGJl
bG93IHRhYmxlIHNob3cgcGVyZm9ybWFuY2UgJiBwb3dlciBkYXRhIHBvaW50czogDQo+ID4gDQo+
ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gPiAtLS0tDQo+ID4gLS18ICAgICAgICAgICAgICAgICAgICAgIHwgUEVM
VA0KPiA+IGhhbGZsaWZlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+ID4gLS0tfA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAz
MiAgICAgIHwgICAgICAgMTYgICAgICB8ICAgICAgIDggICANCj4gPiA+ICAgIHwNCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgIHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gPiAtLS18DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICB8IGF2ZyAgbWlu
ICBhdmcgfCBhdmcgIG1pbiAgYXZnIHwNCj4gPiA+IGF2ZyAgbWluICBhdmd8DQo+ID4gPiBTY2Vu
YXJpb3MgICAgICAgICAgICB8IGZwcyAgZnBzICBwd3IgfCBmcHMgIGZwcyAgcHdyIHwNCj4gPiA+
IGZwcyAgZnBzICBwd3J8DQo+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+IC0tLS0tLXwNCj4gPiA+IEhPSyBn
YW1lIDYwZnBzICAgICAgIHwgMTAwICAxMDAgIDEwMCB8IDEwNSAqMTM0KiAxMDIgfCAxMDQgKjE1
MioNCj4gPiA+IDEwNnwNCj4gPiA+IEhPSyBnYW1lIDkwZnBzICAgICAgIHwgMTAwICAxMDAgIDEw
MCB8IDEwMSAqMTE0KiAxMDEgfCAxMDMgKjEyOSoNCj4gPiA+IDEwNXwNCj4gPiA+IEhPSyBnYW1l
IDEyMGZwcyAgICAgIHwgMTAwICAxMDAgIDEwMCB8IDEwMiAqMTI0KiAxMDIgfCAxMDUgKjEzNCoN
Cj4gPiA+IDEwNXwNCj4gDQo+IFlvdSBoYXZlIHlvdXIgbWluIGFuZCBhdmcgZnBzIGNvbHVtbnMg
bWl4ZWQgdXAsIHlvdXIgbWluIGNhbm5vdCBiZQ0KPiBsYXJnZXINCj4gdGhhbiBhdmcuDQo+IA0K
PiBBbHNvLCB3aXRoIG1pbiBmcHMgbW9zdGx5IGFib3ZlIHRoZSBhY3R1YWwgc2NyZWVuIGZwcywg
d2hvIGNhcmVzLiBBbmQNCj4gc2VyaW91c2x5IDEyMGZwcyBvbiBhIHBob25lICE/IT8gZm9yIHdv
cnNlIHBvd2VyIHVzYWdlISB5b3UgZ290dGEgYmUNCj4ga2lkZGluZyBtZS4NCj4gDQo+IEFuZCBJ
IGdvb2dsZWQgdGhpcyBnYW1lOyBpdCBpcyBzb21lIHRvcC1kb3duIHRhY3RpY2FsIHRoaW5nIHdp
dGgNCj4gcmVhbC10aW1lIGNvbWJhdCAoYXMgb3Bwb3NlZCB0byB0dXJuLWJhc2VkKSAoRE9UQSBs
aWtlIEkgc3VwcG9zZSksDQo+IDYwIGZwcyBsb2NrZWQgc2hvdWxkIGJlIHBsZW50eSBmaW5lLg0K
PiANCj4gPiA+IEZIRCB2aWRlbyByZWMuIDYwZnBzIHwgMTAwICAxMDAgIDEwMCB8IG4vYSAgbi9h
ICBuL2EgfA0KPiA+ID4gMTAwICAxMDAgIDEwM3wNCj4gPiA+IENhbWVyYSBzbmFwc2hvdCAgICAg
IHwgMTAwICAxMDAgIDEwMCB8IG4vYSAgbi9hICBuL2EgfA0KPiA+ID4gMTAwICAxMDAgIDEwMnwN
Cj4gDQo+IE1vc3RseSBJIHRoaW5rIHlvdSd2ZSBkZW1vbnN0cmF0ZWQgdGhhdCBub25lIG9mIHRo
aXMgaXMgd29ydGggaXQuDQo+IA0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0tLS0tDQo+ID4gDQo+ID4g
SE9LIC4uLiBIb25vdXIgT2YgS2luZ3MsIFZpZGVvIGdhbWUNCj4gPiBGSEQgLi4uIEZ1bGwgSGln
aCBEZWZpbml0aW9uDQo+ID4gZnBzIC4uLiBmcmFtZSBwZXIgc2Vjb25kDQo+ID4gcHdyIC4uLiBw
b3dlciBjb25zdW1wdGlvbg0KPiA+IA0KPiA+IHRhYmxlIHZhbHVlcyBhcmUgaW4gJQ0KPiANCj4g
T2guLi4gdGhhdCdzIGJsb29keSBpbnNhbmU7IHRoYXQncyB3aHkgbm9uZSBvZiBpdCBtYWtlcyBz
ZW5zZS4NCj4gDQo+IA0KPiBIb3cgaXMgYW55IG9mIHRoYXQgYW4gYW5zd2VyIHRvOg0KPiANCj4g
ICAiVGhleSB3YW50OyBJIHdhbnQgYW4gZXhwbGFuYXRpb24gb2Ygd2hhdCBleGFjdCBwcm9ibGVt
IGlzIGZpeGVkDQo+IGhvdyA7LSkiDQo+IA0KPiBUaGlzIGlzIGp1c3QgcmFuZG9tIG51bWJlcnMg
c2hvd2luZyBwb2tpbmcgdGhlIG51bWJlciBoYXMgc29tZQ0KPiBlZmZlY3Q7DQo+IGl0IGhhcyB6
ZXJvIGV4cGxhaW5hdGlvbiBvZiB3aHkgcG9raW5nIHRoZSBudW1iZXIgY2hhbmdlcyB0aGUNCj4g
d29ya2xvYWQNCj4gYW5kIGlmIHRoYXQgaXMgaW4gZmFjdCB0aGUgcmlnaHQgd2F5IHRvIGdvIGFi
b3V0IHNvbHZpbmcgdGhhdA0KPiBwYXJ0aWN1bGFyDQo+IGlzc3VlLg0KDQoNClNvcnJ5IHRoYXQg
dGhlIGRhdGEgd2Fzbid0IGNsZWFyIHRvIHVuZGVyc3RhbmQuIEkgdHJ5IGFnYWluIHdpdGgNCmFi
c29sdXRlIEZQUyBudW1iZXJzIGFuZCBzb21lIGFkZGl0aW9uYWwgZXhwbGFuYXRpb24gYXMgd2Vs
bCBhcyBhDQpzdW1tYXJ5IHdoeSB3ZSBuZWVkIHRvIGhhdmUgdGhlIFBFTFQgaGFsZmxpZmUgdHVu
YWJsZSBhIHJ1bnRpbWUuDQoNCkhPSyogNjBGUFMNCg0KKy0tLS0tLS0rLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQp8ICAgICAgIHwgICAgIGF2Zy4gRlBTICAgfCAg
ICAgbWluLiBGUFMgIHwgcG93ZXIgIHwNCistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0rLS0tLS0t
LSstLS0tLS0tKy0tLS0tLS0tKw0KfGtlcm5lbCB8IHZhbHVlICB8ZGlmZiglKXwgdmFsdWUgfGRp
ZmYoJSl8IGRpZmYoJSl8DQorLS0tLS0tLSstLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0rLS0tLS0t
LSstLS0tLS0tLSsNCnxwZWx0XzEgfCA1NC4xICAgfCAwLjAlICB8IDIxLjggIHwgIDAuMCUgfCAg
MC4wJSAgfA0KKy0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0rLS0tLS0t
LS0rDQp8cGVsdF8yIHwgNTYuOSAgIHwgNS4yJSAgfCAyOS4yICB8IDM0LjAlIHwgIDIuMiUgIHwN
CistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0rLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0tKw0KfHBl
bHRfNCB8IDU2LjYgICB8IDQuNSUgIHwgMzMuMiAgfCA1Mi40JSB8ICA2LjMlICB8DQorLS0tLS0t
LSstLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0rLS0tLS0tLSstLS0tLS0tLSsNCg0KKkhvbm91ciBP
ZiBLaW5ncywgdmlkZW8gZ2FtZQ0KDQpUZXN0IG1ldGhvZG9sb2d5Og0KDQpXZSBjaG9vc2UgNjBG
UFMgaW4gdGhlIGdhbWUgc2V0dXAuIEFuZHJvaWQncyBzeXN0cmFjZSAoc2ltaWxhciB0bw0KZnRy
YWNlKSB0aGVuIHByb3ZpZGVzIHRoZSByZWFsIEZQUyBmcm9tIHdoaWNoIHdlIHRha2UgdGhlIGF2
ZXJhZ2UgYW5kDQptaW5pbXVtIHZhbHVlLg0KDQpTb3JyeSwgYnV0IHdlIGNhbid0IHNoYXJlIGFi
c29sdXRlIG51bWJlcnMgZm9yIHBvd2VyIGZyb20gb3VyIHRlc3QNCmRldmljZSBzaW5jZSB0aGlz
IGlzIHN0aWxsIGNvbnNpZGVyZWQgc2Vuc2l0aXZlIGluZm9ybWF0aW9uLg0KDQoNCkZIRCA2MGZw
cyB2aWRlbyByZWNvcmRpbmcNCg0KKy0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0rDQp8ICAgICAgIHwgICAgYXZnLiBGUFMgICAgfCAgICBtaW4uIEZQUyAg
IHwgcG93ZXIgIHwNCistLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0rLS0tLS0tLSstLS0tLS0tKy0t
LS0tLS0tKw0KfGtlcm5lbCB8IHZhbHVlICB8ZGlmZiglKXwgdmFsdWUgfGRpZmYoJSl8IGRpZmYo
JSl8DQorLS0tLS0tLSstLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0rLS0tLS0tLSstLS0tLS0tLSsN
CnxwZWx0XzEgfCA2MC4wICAgfCAwLjAlICB8IDYwLjAgIHwgIDAuMCUgfCAgMC4wJSAgfA0KKy0t
LS0tLS0rLS0tLS0tLS0rLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0rLS0tLS0tLS0rDQp8cGVsdF80
IHwgNjAuMCAgIHwgMC4wJSAgfCA2MC4wICB8ICAwLjAlIHwgIDIuMSUgIHwNCistLS0tLS0tKy0t
LS0tLS0tKy0tLS0tLS0rLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0tKw0KDQoNClRvIHN1bW1hcml6
ZSwgd2UgbmVlZCBhIHNtYWxsZXIgUEVMVCBoYWxmbGlmZSB0byByZWFjaCBoaWdoZXIgYXZnLiBG
UFMNCmFuZCBtaW4uIEZQUyB2YWx1ZXMgZm9yIHZpZGVvIGdhbWluZyB0byBhY2hpZXZlIGEgc21v
b3RoZXIgZ2FtZS1wbGF5DQpleHBlcmllbmNlIGV2ZW4gd2hlbiBpdCBjb21lcyB3aXRoIHNsaWdo
dGx5IGhpZ2hlciBwb3dlciBjb25zdW1wdGlvbi4NCkVzcGVjaWFsbHkgdGhlIGltcHJvdmVtZW50
IGluIG1pbi4gRlBTIGlzIGltcG9ydGFudCBoZXJlIHRvIG1pbmltaXplDQpzaXR1YXRpb25zIGlu
IHdoaWNoIHRoZSBnYW1lIG90aGVyd2lzZSB3b3VsZCBzdHV0dGVyLg0KU2luY2Ugbm90IGFsbCB1
c2UgY2FzZXMgcHJvZml0IGZyb20gdGhpcyBiZWhhdmlvdXIgKGUuZy4gdmlkZW8NCnJlY29yZGlu
ZykgdGhlIFBFTFQgaGFsZmxpZmUgc2hvdWxkIGJlIHR1bmFibGUgYXQgcnVudGltZS4NCg0KDQo=
