Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017B2707A50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjERGko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjERGkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:40:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDFD2D7D
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:40:31 -0700 (PDT)
X-UUID: dee6efa6f54611ed9cb5633481061a41-20230518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ddmr7Q9GMaGgccWNRDYcOI0cNYg7s7wsWXW2eGvDXDg=;
        b=jEn4VsZ7ErPW1gmKS4ZZDSlSLF3ypi/xbB8tFh/zCL1BqsAMJxRcDWhaK/LGNuJthS+gcwt9rtXLLZUa97q7EXGvLx+3CsdzI8lPvwskyYqpefqy2W8j6ebsKr38+75B6QbAc/FRzS+7sUtwJBDXYPuJulJguioHNavdxAeTQyk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:09d178cd-fccf-494e-ae9d-a420da791481,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:9a34356c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: dee6efa6f54611ed9cb5633481061a41-20230518
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <xiaoming.ding@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 992742874; Thu, 18 May 2023 14:40:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 May 2023 14:40:24 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 May 2023 14:40:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUaykpI9AVSvJHMevOd/PGsq6gQOIgd231px+iuvSHWU6qETXt5lJ1Qkx9vsjQUo8DlZXOu8yzase6BEyuplpgxzcw1trECl246eZejmu9RetCPcgOM+M2o20SJ8SgpXgCQmg806b3hxgifAulEf6+s+v24baSmpj0PJXc7LknxAXxpJzzoUAlOKBKVDsPXGEh6SLUTRKNYM7fxfVOJUI/qUeb1rTeeXRd7kTCCXJQl/oZD0PZve7kWvVXQLl84gp1ptgXlzKfjA7gdUjRm/BW7BLvzuydQG5NfbCV+pGfD+ajruSNGXkW1ni8zYHXzZZBMkrbkI9dFb60l80kwYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddmr7Q9GMaGgccWNRDYcOI0cNYg7s7wsWXW2eGvDXDg=;
 b=EF1mqzealXBgW+OpycnASCvffsis08n+ytIL+Fe7k6z3vC0WxK0qYnTONnrMyzkol4cd4u4fkRXFeUZNwKTkGWwO28nH+WPmW565eB4Xmwc9yjCECbeLdEIRjl0DijmUKoGG192b+pXl4XDhCvwIagnMZAHEoQ1C31KZrZGxU8Flt+6HZ3tr6/nLS8qNlTpd9YiSk81C86Jlix/Z9yznBlHsmm4g96ruJH9E8gOqPiEnobJqKOPnu6k4Oivcd/23ARqPAONarqZoAiNTiEGiyskUmrtWc1Q6zX/sq+V3aMriIHnZ89fgq0v3iWmBwrziGyGubMG7byX9U/de/wOJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddmr7Q9GMaGgccWNRDYcOI0cNYg7s7wsWXW2eGvDXDg=;
 b=HZey3vw8HKJXxuWcvu57JMm6vhKAr2y61fHVofkqIORw/6k3p8iMazQq0H0LcCNdGPEjqmQfk0LuGtDv7GZp3FM+l0+mJa3ExTBuWcsZgAsCbD8E3UcoDAajcbQwMJt8vytmvMtH0cRYjpehOexH9fzeETs/B7Z2FZADlwKx1Co=
Received: from SI2PR03MB5369.apcprd03.prod.outlook.com (2603:1096:4:10a::14)
 by KL1PR03MB7125.apcprd03.prod.outlook.com (2603:1096:820:df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 06:40:21 +0000
Received: from SI2PR03MB5369.apcprd03.prod.outlook.com
 ([fe80::b0c2:cc68:d340:fab]) by SI2PR03MB5369.apcprd03.prod.outlook.com
 ([fe80::b0c2:cc68:d340:fab%6]) with mapi id 15.20.6411.018; Thu, 18 May 2023
 06:40:21 +0000
From:   =?utf-8?B?WGlhb21pbmcgRGluZyAo5LiB5pmT5piOKQ==?= 
        <Xiaoming.Ding@mediatek.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>
CC:     =?utf-8?B?RmVpIFh1ICjlvpDpo54p?= <Fei.Xu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Thread-Topic: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Thread-Index: AQHZiG5Ti2msX8Qf8EyhdjKxcboKPK9eE0uAgAAFAYCAAARtAIAAFamAgAACxoCAAAv5AIABVT0A
Date:   Thu, 18 May 2023 06:40:20 +0000
Message-ID: <781d993204fbbdf30a6ca495b59b3b0aa7a2e496.camel@mediatek.com>
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
         <ZGSDoVKKVqCkbaCB@infradead.org>
         <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
         <ZGSLiiK/JzD5KMd7@infradead.org>
         <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
         <ZGSgCZrg+RjAbGO1@infradead.org>
         <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
In-Reply-To: <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5369:EE_|KL1PR03MB7125:EE_
x-ms-office365-filtering-correlation-id: 2bc0a026-17a0-4537-2aff-08db576ac06f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DvslF5rrxJrp37gG9DpxEtJXPXF3phnMYJfVcmZnyHrfDTqSukePm7nJs9SpNFS6kK4dmVr6UAlPz2B8lqyzKI82QvmfoFPxw+5iAAhdpl19OZgM+YpiLEu9leK+YR975SxLiOVD1NHtztsmI6LzbTqhDuhuKoHrO6pnlIppdOHILZRJw79VJ0kyRZJYYk99Fs5OG1vG+vWMn0wP/xlgvp3XX9JBPbKtYJvilXgTMUYkxgie5KvdJor5YlVZpXJVUXt6moxEKGC4NH+fr6pmKw71rnE6iJnublfFzUC+06tHn6FRmDFI6WKcX2OKGMCY2qGytZXZZNIrzwRRi+zEbpU66X2QS9orR+PN2lMr0vbYxJnqsBtMYOYpY7rYn05ECNJYaTmIQlKpaf4t1nkt8ylvE5cx++NRv6UMm0mp+G4lx4z/Tu3xp65R/lFleuDA/RLdJlC+dOLov+R5VXkNllfwjy2jM864kp6okSTMfkBkJu5zCmUm8Peo1NQWuShW1xtQYe0mldCEIWQ3QvyAYB6iGG2kkXO/8gOp+aSWY1UbP4TsXS2W37KJNgUpoEKbthgCKJZfOYnhtYLl5VMaPApczgEswEUzPAGKvaRwT6xufD+2nCGDCMMYv0luDfW7NE4aMH+Jp3IGijKGmApw+gzftO0+utThd3dTPGQ397U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5369.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199021)(2906002)(316002)(478600001)(41300700001)(8676002)(8936002)(4326008)(6486002)(54906003)(110136005)(7416002)(71200400001)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(91956017)(5660300002)(53546011)(6512007)(6506007)(26005)(38100700002)(186003)(83380400001)(2616005)(36756003)(85182001)(38070700005)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTVPc29CSnZxMDVuRHdwa2xzdFhuN1dpSmtJTm5oaS9MVkRYWTQ0b3dlYncx?=
 =?utf-8?B?OXJ3RFE4bGpReVJWTzBuQ0FWN0hQME50RllHOVZSQWNIMDJaczNuQnlhMVlM?=
 =?utf-8?B?cnY2TUcvelE5Mzc4TkF1eHdKMkRTUTI2QzJUZXRad2E2R0tyekhoNmhCWExM?=
 =?utf-8?B?NHZZTXhYSmZwS2hkZVM2TVpMLy9ZVGdxTS80d1Nsc1VOd3h5U2UxWS9KS0NN?=
 =?utf-8?B?dzE0cnVhb0x0c3luMlV6RTVEZitIZ0NtV1VOUmdKWmkzbnE0Um9MUEUzZTVk?=
 =?utf-8?B?bW1PVzdLV21IQ0diZGJpbjVQeFRVZ01xa2xMWVNQdDdSbWhPNmtzMGs1QUtC?=
 =?utf-8?B?S0cwSCtxN3Y3MU5RSXV0N1F0d0lvVzZ0T1NHeGdmdVZmL25YWU52SmtRaEFl?=
 =?utf-8?B?c2dtNitXZ3JPcVU3NUxuOFpVZ2NRTitDV2dwa0Y4N1VMdUpFbWdiM0w0N2Vk?=
 =?utf-8?B?SzdLWVdReVRiREplSmIvZWRpV2k1a0VpM014YVVpOFMyT2lJaGJ1QmxiUW5r?=
 =?utf-8?B?RlZOTWdsU2FmQnhCV1hUZ2VVc0c1ck55dXJGQklzVE93eDhzZ3VuSTI5SHZz?=
 =?utf-8?B?WlRRaU1xc3QzbEtPZXhkZXVkd3JiNWZsM0U4YW42UGYxMk5pVHF6bkJLTWlI?=
 =?utf-8?B?SExyMitMa3VvRVpseFdMOGQxNnRkSU8yMzlZYXJUSTRRREZRNEYyOERsVlN0?=
 =?utf-8?B?TmQvdXVTcmh5TmFkK3U3ekY4V1l0RFBrUzN1NzFFTTRPOFdFSmkxQjBiUlR3?=
 =?utf-8?B?VDBRWWVqMDU3ZitHRVVMdzZGVlRJSVZ3QTlrNVo5UmlMcFYrSmdNa0pva0l1?=
 =?utf-8?B?VGlIVi9aT2Ura3RKZWhTanZDU2o4dkpOVlBTdnh0S25tbHVUdTRWL1p1YStp?=
 =?utf-8?B?QXJVamswUzBCN3IrL2lhT3NZNjVleU9INkY5d3JuY1ZxMzdGYmN5MkQ3TU9U?=
 =?utf-8?B?cERmY3lzbkR1RkhSaE9UaGYyZnFsMCtHd2cvaTAvVDFBcVJTV2VKMGFjSTJI?=
 =?utf-8?B?UVMrR0NKOVh6c3FiR1pkdGhTMkFEaUsySGE0VUtwa05XTC9INHZvc0g0Skpi?=
 =?utf-8?B?dmtuZ2ZPYUZkSEN3NVhXUVFtcVhQYm9nOXNPT0ZOOU1hRm1TcUVnZjRXZFht?=
 =?utf-8?B?SFVjdmswM1Nuazk3WllGR2FCUS8yMk9BN2l3cnRQRHUraXdxNWlLbGlBU1Fp?=
 =?utf-8?B?bDFFT2w4UzlrYm5IQ3hVbVFIMzVhRG0vZElXdFdXb3dOWWx6VXliVmFwQ0Vn?=
 =?utf-8?B?SG10aGtpV1YzVUw1MVFYb201V0NMbkxIc1RtVFVjMXR3b1plcHErVTZjV1Ra?=
 =?utf-8?B?d3I4NHlkS1RvMitDQ0I5VTk3WlVMRkx4My9RaVFFVmllQlorSmtBRW1Jc3NX?=
 =?utf-8?B?UWE1UDNTWHVneGJISWJRUFF1MWp0YTQxZXV3dkxlYlQrSWNuRjhJVk52c05m?=
 =?utf-8?B?V2xMVDAxSUJRTUdieVo2UDRYZUw1c0NuWXhwVmY4bGhseUgvZ2VJbVUybnJ3?=
 =?utf-8?B?UmhYTzA5bWhWbWVpb2tqVnB5NWttd1F4dmk3bXh0c2ZTZ2tBRmNxQiswSFVl?=
 =?utf-8?B?N3dOT05majhyZ1NaZ2I5dzhhMnBWQWNqUzZWY2cyZzZZcFo2akUzUlBwOHMz?=
 =?utf-8?B?eHBxSjlCVkQ5N3lXZ1plY1ZRK2VVV1o5OHZnd1A5b0NPU3lrdXlFUGtQTElD?=
 =?utf-8?B?cmdCK2FBWjkzb3dNcVlSeksyN1FlSHpkQmViRmF1eEYya1ZjSE5ld0Z0aDBN?=
 =?utf-8?B?VXhCT0JJUVJLSHRYVUZEN3llMDNJZjBWVXVkZVlmRUpVUStnTG1RNDFCLzk1?=
 =?utf-8?B?WXF2NmFvbVNoM0VwRUhDeEtROER2UjZ5NE01QVkxZzRMZmd6THRCeVNJWkp1?=
 =?utf-8?B?T2pMYU5YRmwrQVEyS3prVkxiUGIydUplMG45R05WZnN5SFpDVEE5MUx6amdX?=
 =?utf-8?B?Uno2TGNiTnQ4dnpwMjRWVzhMdTg2NE1td2lzaEd3VDFQd1NaUUxZbG5aZGdk?=
 =?utf-8?B?UUV3UGgwMGlNQXNLTnJLaG5pM1hud0VhNXF4SDdlMVpHanVzTWsxUUo5TWFx?=
 =?utf-8?B?L1BZdm5iRWlYV2EzMkcxbG1Ka2ZrYkF3Y0RCUEpacG9qKzZVdXMvQ2htQk1R?=
 =?utf-8?B?MTBZSTFuZ3NHN1pqWTlMZGVXRG1jT2V0VDZpVjlpbS90ekFPdGRwY2FINnB1?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C00584D1C4818E4BA64BA1603015766C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5369.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc0a026-17a0-4537-2aff-08db576ac06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 06:40:20.9293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gD8Hq9fmQJa+JUmCyGaXSUd+VPmdpng0ayR+++TdavH8lAchnNGNuzbvKB7YRxRMsIV0QSXWH7mgeiRNcnBHBqlV9M5yoMOgLG3flRoyLEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbSAzNWZkMDYyZDVjYmM0ZDE4MmVlZTAxODM4NDNjZDYzNTBkMTI2Nzg4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogWGlhb21pbmcgRGluZyA8eGlhb21pbmcuZGluZ0BtZWRpYXRl
ay5jb20+DQpEYXRlOiBXZWQsIDEwIE1heSAyMDIzIDEwOjE1OjIzICswODAwDQpTdWJqZWN0OiBb
UEFUQ0ggdjJdIHRlZTogYWRkIEZPTExfTE9OR1RFUk0gZm9yIENNQSBjYXNlIHdoZW4gYWxsb2Mg
c2htDQoNCkNNQSBpcyB3aWRlbHkgdXNlZCBvbiBpbnN1ZmZpY2llbnQgbWVtb3J5IHBsYXRmb3Jt
IGZvciANCnNlY3VyZSBtZWRpYSBwbGF5YmFjayBjYXNlLCBhbmQgRk9MTF9MT05HVEVSTSB3aWxs
IA0KYXZvaWQgdGVlX3NobSBhbGxvYyBwYWdlcyBmcm9tIENNQSByZWdpb24uDQp3aXRob3V0IEZP
TExfTE9OR1RFUk0sIENNQSByZWdpb24gbWF5IGFsbG9jIGZhaWxlZCBzaW5jZSANCnRlZV9zaG0g
aGFzIGEgY2hhbmNlIHRvIHVzZSBpdCBpbiBhZHZhbmNlLg0KDQptb2RpZnkgaXMgdmVyaWZpZWQg
b24gT1BURUUgWFRFU1QgYW5kIGtpbmRzIG9mIHNlY3VyZSArIGNsZWFyIHBsYXliYWNrIA0KDQoN
CkZpeGVzOiAwMzNkZGYxMmJjZjUgKCJ0ZWU6IGFkZCByZWdpc3RlciB1c2VyIG1lbW9yeSIpDQpT
aWduZWQtb2ZmLWJ5OiBYaWFvbWluZyBEaW5nIDx4aWFvbWluZy5kaW5nQG1lZGlhdGVrLmNvbT4N
Ci0tLQ0KdjEgLT4gdjI6IHRha2Ugb2ZmIHRoZSBpZmRlZiBhbmQgYXBwbHkgRk9MTF9MT05HVEVS
TSBieSBkZWZhdWx0DQoNCiBkcml2ZXJzL3RlZS90ZWVfc2htLmMgfCAyICstDQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3RlZS90ZWVfc2htLmMgYi9kcml2ZXJzL3RlZS90ZWVfc2htLmMNCmluZGV4IDY3M2NmMDM1
OTQ5NC4uMzg4NzhlNTQ5Y2E0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy90ZWUvdGVlX3NobS5jDQor
KysgYi9kcml2ZXJzL3RlZS90ZWVfc2htLmMNCkBAIC0yNTcsNyArMjU3LDcgQEAgcmVnaXN0ZXJf
c2htX2hlbHBlcihzdHJ1Y3QgdGVlX2NvbnRleHQgKmN0eCwNCnVuc2lnbmVkIGxvbmcgYWRkciwN
CiAJfQ0KIA0KIAlpZiAoZmxhZ3MgJiBURUVfU0hNX1VTRVJfTUFQUEVEKQ0KLQkJcmMgPSBwaW5f
dXNlcl9wYWdlc19mYXN0KHN0YXJ0LCBudW1fcGFnZXMsIEZPTExfV1JJVEUsDQorCQlyYyA9IHBp
bl91c2VyX3BhZ2VzX2Zhc3Qoc3RhcnQsIG51bV9wYWdlcywgRk9MTF9XUklURSB8DQpGT0xMX0xP
TkdURVJNLA0KIAkJCQkJIHNobS0+cGFnZXMpOw0KIAllbHNlDQogCQlyYyA9IHNobV9nZXRfa2Vy
bmVsX3BhZ2VzKHN0YXJ0LCBudW1fcGFnZXMsIHNobS0NCj5wYWdlcyk7DQotLSANCjIuMTguMA0K
DQpPbiBXZWQsIDIwMjMtMDUtMTcgYXQgMTU6NDkgKzA1MzAsIFN1bWl0IEdhcmcgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gT24gV2VkLCAxNyBNYXkgMjAyMyBhdCAxNTowNiwgQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPg0KPiB3cm90ZToNCj4gPiANCj4gPiBPbiBXZWQsIE1h
eSAxNywgMjAyMyBhdCAwMjo1NjoxM1BNICswNTMwLCBTdW1pdCBHYXJnIHdyb3RlOg0KPiA+ID4g
RG8geW91IG1lYW4gYSBwaW5uZWQgdXNlci1zcGFjZSBwYWdlIGNhbiBiZSBwYWdlZCBvdXQNCj4g
PiA+IGF1dG9tYXRpY2FsbHk/DQo+ID4gDQo+ID4gTm8sIHBpbm5lZCBwYWdlcyBjYW4ndCBiZSBw
YWdlZCBvdXQuDQo+ID4gDQo+ID4gQnV0IGEgc2hvcnQgdGVybSBwaW4gaW1wbGllcyBpdCB3aWxs
IGJlIHJlbGVhc2UgYWZ0ZXIgYSBzaG9ydA0KPiA+IGRlbGF5LA0KPiA+IGFuZCBpdCBpcyBmZWFz
aWJsZSBmb3Igd2FpdCBmb3IgdGhlIHBpbiB0byBnbyBhd2F5Lg0KPiANCj4gT2theSwgSSBzZWUu
IEkgd291bGQgYmUgaW50ZXJlc3RlZCB0byBrbm93IHRoZSByYW5nZXMgZm9yIHRoYXQgc2hvcnQN
Cj4gZGVsYXkuIEkgZ3Vlc3MgaXQgbWF5IGRlcGVuZCBvbiBob3cgbXVjaCBtZW1vcnkgcHJlc3N1
cmUgdGhlcmUgaXMuLi4NCj4gDQo+ID4gDQo+ID4gRm9yIGEgbG9uZyB0ZXJtIHBpbiB3YWl0aW5n
IGlzIG5vdCBhbiBvcHRpb24sIGFuZCBhbnlvbmUgd2FudGluZyB0bw0KPiA+IGRvIHNvbWV0aGlu
ZyB3aXRoIHRoZSBwaW5uZWQgcGFnZSB0aGF0IHJlcXVpcmVzIGl0IHRvIG5vdCBiZSBwaW5uZWQN
Cj4gPiBtdXN0IHNpbXBseSBnaXZlIHVwLg0KPiA+IA0KPiA+ID4gSnVzdCBGWUksIHRoZSB1bmRl
cmx5aW5nIHVzZS1jYXNlIGZvciBURUUgcmVnaXN0ZXJlZCBzaGFyZWQNCj4gPiA+IG1lbW9yeSBp
cw0KPiA+ID4gdGhhdCB0aGUgcmVmZXJlbmNlcyB0byBwaW5uZWQgcGFnZXMgYXJlIHByb3ZpZGVk
IHRvIFRFRQ0KPiA+ID4gaW1wbGVtZW50YXRpb24NCj4gPiA+IHRvIG9wZXJhdGUgdXBvbi4gVGhp
cyBjYW4gaGFwcGVuIG92ZXIgbXVsdGlwbGUgc3lzY2FsbHMgYW5kIHdlDQo+ID4gPiB3YW50DQo+
ID4gPiB0aGUgcGlubmVkIHBhZ2VzIHRvIGJlIGFsd2F5cyBpbiBSQU0gYXMgb3RoZXJ3aXNlIHRo
ZSBwaHlzaWNhbA0KPiA+ID4gYWRkcmVzc2VzIG1heSBjaGFuZ2UgaWYgdGhleSBhcmUgcGFnZWQg
b3V0IGluIGJldHdlZW4uDQo+ID4gDQo+ID4gVGhhdCdzIGEgdmVyeSB1c2UgY2xlYXIgY2FzZSBm
b3IgYSBsb25nIHRlcm0gcGluLg0KPiANCj4gLi4uaG93ZXZlciwgdGhhbmtzIGZvciB0aGUgaW5z
aWdodHMuDQo+IA0KPiBAWGlhb21pbmcsDQo+IA0KPiBQbGVhc2UgdXNlIHRoZSBmb2xsb3dpbmcg
Zml4ZXMgdGFnIGZvciB0aGUgdjIgYWxvbmcgd2l0aCBleHRlbmRpbmcNCj4gdGhlDQo+IGNvbW1p
dCBkZXNjcmlwdGlvbiByZWdhcmRpbmcgdGhlIHJlbGlhYmlsaXR5IHByb3ZpZGVkIGJ5IHRoZSBs
b25nDQo+IHRlcm0NCj4gZmxhZy4NCj4gDQo+IEZpeGVzOiAwMzNkZGYxMmJjZjUgKCJ0ZWU6IGFk
ZCByZWdpc3RlciB1c2VyIG1lbW9yeSIpDQo+IA0KPiAtU3VtaXQNCg==
