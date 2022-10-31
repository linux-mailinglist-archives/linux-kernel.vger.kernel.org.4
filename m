Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB96612F36
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 04:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJaDFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 23:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJaDE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 23:04:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EBB657D;
        Sun, 30 Oct 2022 20:04:52 -0700 (PDT)
X-UUID: 148ed8c2bf154c65a3461dba9e59e226-20221031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+yb3iDgVnQ85GxxgN+gEYRPOiLZKqS86iWU9/Ctvdnw=;
        b=KUUIqtVNp2YAsDcqHowoBIt7QF7/0OQtxt91TVtX2FswHJYO1vppryxZ3ySCp2LLWMYaGdKL+WHgI4wn/afekWDWw0l8sC3BnygRcGS8QF0hZ0L8jmg5JwBVcYijjKYnN5zxuXIHzYowzaPez0SXW/Uo7w+hJQ3DPQ04n4JcV5M=;
X-CID-CACHE: Type:Local,Time:202210311016+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:b918c083-476b-40b3-aa51-1a87b3b50d1d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:cc440e90-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 148ed8c2bf154c65a3461dba9e59e226-20221031
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 799265038; Mon, 31 Oct 2022 11:04:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 31 Oct 2022 11:04:44 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 31 Oct 2022 11:04:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd9CtHMYSTY7ABszDauSy4+PRX75bx/5gLP2tDXS0FEmj1hH34WoOaD8uULhDkyGReyZ7jYAJs3vqjfkcCZq3xXsMlJobK8oXfBLAtOtewMLv+KdQX3WNk+vnWcpd4N36CADgdAzgGeG6w9wTY5/cjc2fbiPfvcGhzekkaIXtiIQ8ZnDC4Hu+s7V4Hl+iHnh43t1Ms3QldgsgjEi4XnN3N8NNOatEu6jY+Jcwn+oqlmbmI0T38ANr1e+OXOtvZwHLO5XfmPRiCswlYRXd5WLlMRkrJbn+e6K9Oy6cDGMMq3gVWG7Xapxz/V08udmAiegHNwlyzbItpq0yQc36yH7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yb3iDgVnQ85GxxgN+gEYRPOiLZKqS86iWU9/Ctvdnw=;
 b=dcPF7nD+oyH3HYcwCeHFMs5u6jJolGqq/pJIHv/OB0a7QR0wQ/V/yibY+bCvfy3KMTr6S5hqDty01HI6hdE04Hg8mYPhfdlxGzrmKbKyYNy1qvlEBHIunGbyKYQvKD/gHetyBhQBczEv+QyeoP7J34IEs5LcptyTswX6DR/GGt5RWqR8nsAlVhCFx/TeKJkM1jqpeTSdVKQcoyMAVxtzEm/vEyCaPtdCcSmKSHMrClZ3+A1PnSs6QWJyMttx9c0Nilds2Ri6qcsruYscDGeL0UJ5d2DpK90r/ktxjymgSacdpnYumM8qDPoC2OVKffRNTu6tuzWX3ozedjpT6EOEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yb3iDgVnQ85GxxgN+gEYRPOiLZKqS86iWU9/Ctvdnw=;
 b=Q0GSFD7Z/ds+2fM1fIsJObFEpZWpEKkxki5etXd0t/0rQCR0VJ3gXfyisWUVFZeSkRx328RZQ2M+dVCiRqXHL5uW9WwkJ0pvz7ElzUYnhTwoR05fT+oLHA2l9jEBfY5zHx+7pOtWu5LeyZ+RVWXuIiwjfpX7qnhPvcjw4I/cdCQ=
Received: from SEYPR03MB6531.apcprd03.prod.outlook.com (2603:1096:101:8a::9)
 by SI2PR03MB5420.apcprd03.prod.outlook.com (2603:1096:4:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.10; Mon, 31 Oct
 2022 03:04:39 +0000
Received: from SEYPR03MB6531.apcprd03.prod.outlook.com
 ([fe80::d882:f0e9:8578:7b2]) by SEYPR03MB6531.apcprd03.prod.outlook.com
 ([fe80::d882:f0e9:8578:7b2%6]) with mapi id 15.20.5791.010; Mon, 31 Oct 2022
 03:04:39 +0000
From:   =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?SG91bG9uZyBXZWkgKOmtj+WOmum+mSk=?= 
        <houlong.wei@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bingings: gce: add gce header file for mt8188
Thread-Topic: [PATCH v2 1/2] dt-bingings: gce: add gce header file for mt8188
Thread-Index: AQHY64RNl/UyGNWiw06BBySJYcHnU64n0/0A
Date:   Mon, 31 Oct 2022 03:04:39 +0000
Message-ID: <d04b6b07c69becd7cf80736a88d556138340c974.camel@mediatek.com>
References: <20221029105017.20734-1-Elvis.Wang@mediatek.com>
         <20221029105017.20734-2-Elvis.Wang@mediatek.com>
In-Reply-To: <20221029105017.20734-2-Elvis.Wang@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6531:EE_|SI2PR03MB5420:EE_
x-ms-office365-filtering-correlation-id: 36d3f36c-05b9-475b-26d4-08dabaeca699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 04/lDCyMhhqvVLzRpTao9eYXraFXx3nFyDlxuqMkDdwN0M7JeVVM2YjE8mccZt5jBph6Vf7p8hQCBds557huOQbsX3necnIf1kkXQc7dGySS8dFThBerofJ6eYwffRYdb38XbXBbswhvVY+OzbwJdQJdF5wGsmyN3tSqhXgH5FA4sJT433IZqqvcDkLMF6Q/j3tP4Ihvd9Wp+NeL2WW3czLoc/FgHf1r8lMU1QvUjO3/ryJzIHIgWe1ILs9QoihzDAtZ788ywBF4fve4SimefJmsyqJ4Di/RHA1uvwj1ZZeJz90wSMsSoWXpmc7pl2FwTIk4/XYFP7gRrL57jwmA+ytGUGk4weMMZBcqysRlUSWnekYo/A4qc7/+SfBHwXWo6agTZ48m2Y6XY7b3boBP/qRzZIXXHzLbpMCiq1cDb+Q3/ipMBL9MPgTTdGI4QT8W0nd+pQPpnKw6vyWwbslRKNUwJIlMZO42ppyun51GwRkfBiRfwoCxAsBL/GD5uTGp2jaASeSuuaA0rBIOf2uokridrNG5LkwfYMcYYgaIpO1tcsa5/oTHz5iNYkUGniAFy2fs18N4zOxUZCxUKpk9fMjHXeq3h728jdqBjTr9+VtM4f915zj6IfPYHVhVyr9/ogE7I+O9imPJHVmCvtckzDrRbRu7uOneTAVxH7SxEjlNbJxMm3Vv+BSPRSQBrs2K0S0C4ThR5XUqTIEythZ0IrwGLqbVRoXoZdnxZjQRMmSrSd80wCCdvNeU4Prfv/QJp0aMbKJpGjxGQMveo2lDB6srZy8fQmIgcyTWocuF+hY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6531.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(91956017)(38100700002)(66556008)(66476007)(66446008)(76116006)(64756008)(66946007)(8676002)(4326008)(2906002)(4744005)(4001150100001)(186003)(2616005)(26005)(122000001)(36756003)(86362001)(6506007)(41300700001)(8936002)(6512007)(5660300002)(85182001)(38070700005)(71200400001)(478600001)(6486002)(966005)(316002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkIwVTlWR216eEkyZjJBeHBxOHd4clhJa1NtY0RYQm9IaUlQZ3RYTmUwRksr?=
 =?utf-8?B?SkpML3VWNUt6Yk4ycjBBMW8zclJ6bEN5QlZ3QlJZdXNWMDI3YThJT0s5T2ZT?=
 =?utf-8?B?Snk0SFNhWkE0VkpmcG04K3Q1akNzUTFMUUlCUnVSNTROczA4ZDE2eHVhbGMr?=
 =?utf-8?B?dzQxOW5DNkxlYjlNMFJ3VE0wYWpNQnFmdHVsOXRWa1d2M2RCZWVnNlJQdmZx?=
 =?utf-8?B?SElhRklWM0hUaG5JWkQ5ZlFqc3k0aUhmeFN3RkdSc0ROSkhudmZnQmdmNytw?=
 =?utf-8?B?Qk40Y2Y1enZxOGdXYXVtODVqcllVR1hmVnlwbnFXVFQ1U3A2VFhjYXJqdFc4?=
 =?utf-8?B?RjFRNVFiaktVTWRTTElwRGt0R0xFbVArMEtGc1c0am5Ea2VvQWJuSWRGYVpR?=
 =?utf-8?B?S3kvbkc3SHh4YzBHa1BNclZuaCt2bGh4YVZiWU1IWitoL3g0ekVWVnF5U0VJ?=
 =?utf-8?B?NFpzYm13TkdmS2orL1hjR25FWk5JaTZJRmcrVVdTdzJPRmVNRzlycTlnakl2?=
 =?utf-8?B?U2JwMS9ydXJLQzluNDVWdnFVMlRSMjlsUFlDSVBNSTR3RjR4ZFgxZTFsTFpO?=
 =?utf-8?B?N1RJRU1BWFZ4ZWh3eVpXNTU3alp5aSttNEs1Q0swMnU3aENGbkg2dkVhQWgr?=
 =?utf-8?B?RE5Zekk4dDU0TVdEdDVEWEFNOE5iS0t1S3gyWnBoMnQxdzlkT2ZkdWFWUTYx?=
 =?utf-8?B?LzB2TlprMW5IUm5IYmlxWGJhenNtTHpvVjJ5eWZTTTF1dmxudnF4Ym1tckVX?=
 =?utf-8?B?WUZpYjlpRmhpT2hBUU8zc0xWUmVhUFNEV0NnZTBJK2JaaXdlVWUxb2dxV1pV?=
 =?utf-8?B?Q2JQcmRQK1VYSnB3ZjRacm9NNkppd05GTjduTDFDd0JPS3kwVWpBNXIyRUpI?=
 =?utf-8?B?YmpuU1dBeHdxaHBXbDBsdFdmVkxtcEs5QXFDRmZ5S2ZNczlCZkdadFRVQ3VL?=
 =?utf-8?B?dkhoWUZMV2lTVWsxSm5kVU0vbGxiYVhVTmF1Z05xVTBGVkE1TG42aWU3Tk9P?=
 =?utf-8?B?dmE4ZnFlb0YrRHhWdHQ2NU9mUHh1SWVNcnNvOHVLU0lZWGdjQzdnTkRKTzRJ?=
 =?utf-8?B?Nmg3NzlxdUxNZVNmV1I2RzdyNy95U3huTmFVcXdpeDZldmNNL1k4am0xYUY0?=
 =?utf-8?B?YlFjTEJ1V2ZZa25icnBzRzU5cXE0QXZiWGdwNDJjZFNYK240YXpuWThmRFBI?=
 =?utf-8?B?cHVxWFVnL1NlNVMxRDkyeGVETGw1SytubTVjTHhMTTNOKzJ1eGpuUTRjV3Jm?=
 =?utf-8?B?WlhrR1kwQUt3UjlVL0NoQWZQNVBwME9rRGtlRmw1d1E1NTRtYzV2cU9OUEhS?=
 =?utf-8?B?Mkx3dnRvVGQyc1h6Smhsd3lQMnpCcGE3Qko4cmh6eHhxQkEwUEcyNVU1bDJD?=
 =?utf-8?B?d3dHYzQ3ZEl4bUJQelY5R283Nk5Xbloxc3M4RDhGTDZNTHluVElpT2p0VjBQ?=
 =?utf-8?B?c2s2dVBKQ2UzdXFlQ1dKeFdrSnhFaWlhcGVOSzRTVzZQWG5QOUo5b1hISGla?=
 =?utf-8?B?SlpBRWtWVTAxUzBHRW4wcFZiYzlISEJyNHVzbGJISUNJK0xweUlyRG5pYWFI?=
 =?utf-8?B?dnRFeldmcjBNaERVdHVSUURWTUlteDgrSjBSSSswSTJwaVE4aHNTK2Y1bjN3?=
 =?utf-8?B?cUp6bE80ckV4ckx0Ri84RGl2VmtNcHdjODRxR0dlR2hicm9QVHNqMXRLT2lQ?=
 =?utf-8?B?NTgvc2JQNUFXRDlTbzMxNk5ESDJvanVJNThlbEc5ME93eUpVM2lQZTNiY1RT?=
 =?utf-8?B?emZsanFZMnVzSGt6d1dyTUdxV1R3b0UrQ254WExrSkFrSENoOHJPcktXcUFy?=
 =?utf-8?B?UW5QV0NIaEgzQXBTWk41SDVSVG5Id3VOM3NWMmlJV0lRR0FJQ2JNZE04bmpD?=
 =?utf-8?B?QWdEYnVzU2JqRkZzV08zdm5JTkdnakZMZlVXdHJ4UWRucGovU3loMnpGRUUr?=
 =?utf-8?B?d0FKQmpvb2hxNklaSEJhS3U2WjdEK0dmY3VML05xMVJoYUE4S3MyeDVmUndv?=
 =?utf-8?B?QWJDNHBIKzROWnl5ejJ4UEpCWklGMUtYUTdMVElzWE9mQzVRVTU3VjVpNGpE?=
 =?utf-8?B?RVdOWkVOMmZGNlIxZWl0dUNtei9WZzhkTERwRTN5bFJzSDFSRi9aczRPYllS?=
 =?utf-8?B?SkRKNllDUVlGeTJ2MExOMGRDNUJkSU50M3ZuVUxaekIxbDFzajBmV21sWHlv?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F0901D55607904BB1630B1123019DC0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6531.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d3f36c-05b9-475b-26d4-08dabaeca699
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 03:04:39.5824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AhPL1+ZeKfQEuSV8nV2IuHbSEjFDnSysJ1iiC1fqq6irs4H7FnXsEEb6GDWeeHto/EvKo0UGFGkkVkUzlh+flu8kPm1AK2O0+wYFbZ0dTkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5420
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIyLTEwLTI5IGF0IDE4OjUwICswODAwLCBFbHZpcy5XYW5nIHdyb3RlOg0KPiBG
cm9tOiBFbHZpcyBXYW5nIDxFbHZpcy5XYW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IGFkZCBnY2Ug
aGVhZGVyIGZpbGUgdG8gZGVmaW5lIHRoZSBnY2UgdGhyZWFkIHByaW9yaXR5LCBnY2Ugc3Vic3lz
IGlkLA0KPiAgZXZlbnQgYW5kIGNvbnN0YW50IGZvciBtdDgxODguDQo+IHYyIC0gdXNlIHZlbmRv
ciBpbiBmaWxlbmFtZSwgdXNlIER1YWwgbGljZW5zZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVs
dmlzIFdhbmcgPEVsdmlzLldhbmdAbWVkaWF0ZWsuY29tPg0KPiBSZXZpZXdlZC1ieTogQm8tQ2hl
biBDaGVuIDxyZXgtYmMuY2hlbkBtZWRpYXRlay5jb20+DQo+IFJldmlld2VkLWJ5OiBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IA0KPiBUaGFu
a3MgZm9yIHRoZSByZXZpZXdzLCBJIGhhdmUgZml4ZWQgdGhlbS4NCj4gDQpIZWxsbyBFbHZpcywN
Cg0KSSB0aGluayBLcnp5c3p0b2YgYW5kIEkgZG9uJ3QgZ2l2ZSB5b3Ugb3VyICJSZXZpZXdlZC1i
eSIgdGFnLg0KVGhpcyB0YWcgc2hvd3MgdGhhdCB3ZSBhY2NlcHQgeW91IHBhdGNoIGJ1dCB3ZSBk
b24ndCBhY2NlcHQgeW91ciBwYXRjaC4NCg0KWW91IGNhbiBhZGQgdGhpcyB0YWcgaWYgeW91IHNl
ZSBzb21lb25lIGxlYXZlIHNvbWV0aGluZyBsaWtlIHRoaXM6DQoiUmV2aWV3ZWQtYnk6IEJvLUNo
ZW4gQ2hlbiA8cmV4LWJjLmNoZW5AbWVkaWF0ZWsuY29tPiIgYW5kIHRoZW4geW91IGNhbg0KYWRk
IGl0IHRvIHlvdXIgcGF0Y2guDQoNClBsZWFzZSByZW1vdmUgdGhlbS4NCg0KUGxlYXNlIHJlYWQg
dGhpczoNCg0KDQoNCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvdjQuMTcvcHJvY2Vz
cy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbCN1c2luZy1yZXBvcnRlZC1ieS10ZXN0ZWQtYnktcmV2
aWV3ZWQtYnktc3VnZ2VzdGVkLWJ5LWFuZC1maXhlcw0KDQpCUnMsDQpCby1DaGVuDQo=
