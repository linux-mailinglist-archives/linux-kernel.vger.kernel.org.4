Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD59731484
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbjFOJwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343515AbjFOJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:51:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA2D2961;
        Thu, 15 Jun 2023 02:51:37 -0700 (PDT)
X-UUID: 31aaf3dc0b6211eeb20a276fd37b9834-20230615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pZKcARPCWQXk7UgTS8EcJjAPE/zXh762X/KI3/fBfPU=;
        b=Q5JLKQHioKu0lU/KqxVagd+SVALFqCI2p2pvOfjuox+QRxLXmDl0Wl5JUB7kH6yZ22yTw6BS35Dd44R4QdvFcru4G62FroAcgFoeWab/seULi64iW0rbbGafmF75qYV9uJcItmiuzaV2tdYzojCYpgvcXb+WHZvoxnFWAgnOkrU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:015b4a04-38ab-4885-83a8-9dea1ab8f489,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:2e522b6f-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 31aaf3dc0b6211eeb20a276fd37b9834-20230615
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1676922407; Thu, 15 Jun 2023 17:51:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Jun 2023 17:51:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Jun 2023 17:51:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6k5SBvyzfwtlWkp/Y/xp0504+yASSyhYfcPLkMsU1fUMDszp0se4VaUbjq7uC4NzEfIaaDTdznfHmwqBBrseUgK0bd+Dme0Ng9wyB2hKO1DBqduypZy9UNEvNgjFVme09YIfd00c3yPlnVNY4Chzb5rsHbEDUuYIDV25rE+Z4DIgk1E55xrAsy9Gyxo6GjBHm0/OoLDNo0IKmavhhw12rkfPMwVLyf0/55FapnSU8pkw5r4lAGZSjvQzMkazhU/4FHPNPxaMBzJ2VD3cFYmduWXRVhoQqxmIRuLMnjH1kMbOd1LuSPMlFGHmidltS9cyzGjl6GZB8o/QBYW/KUBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZKcARPCWQXk7UgTS8EcJjAPE/zXh762X/KI3/fBfPU=;
 b=EEDz3lg22e3rKdjyDoQhcr77Ipo0PXP3TU3eo1avZaj9CnY+N0TDhAWSbT91hbnv2+T9Jm1jPaCw0Hg9gfmQdkJJ9rsvGJ+hA4XsEZR4iJ0Gg78XNsBJlgmSlgMSBmmWE5xuxBHo7WlMNH8AfNmgp+5VjuroZT/XDMf2SGWfVTZ6/gK03BZ8Ejbh0tpSk3uImKxju80R7CGqWt+1iwWcNNHHZX+m9bn1yiztj2vpYmxEzyNybSyJtn/TWv0IVmHOOR4g5pjLfrIUN1DVSGxKWE46WZpXlwFy5PIxjF+f5xnsFSFT0VGXmK/xaePGVPe/FMs2b5Sw/GkBoEo1IepJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZKcARPCWQXk7UgTS8EcJjAPE/zXh762X/KI3/fBfPU=;
 b=ljpSHD/6NowE8emFNHuSGQF9C2QFHzbWGvmcNuyaqeVO0FDaNy2/yZ68hk/8eZupJgPFlJtH3gOOe0LxpA3vbTdCkeV4fa1zYnQcRQr1eitLTiC0jMr8/sgClisa68vGt6AQgxUyK0wxg03n+gadZwR+MESNGsohgTTp1m18z/0=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by PSAPR03MB5367.apcprd03.prod.outlook.com (2603:1096:301:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 09:51:21 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::2648:bb51:77fb:125b]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::2648:bb51:77fb:125b%4]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 09:51:21 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        =?utf-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        =?utf-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?V2VpeWkgTHUgKOWRguWogeWEgCk=?= <Weiyi.Lu@mediatek.com>,
        "ikjn@chromium.org" <ikjn@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8192: Make sure MSDCPLL's
 rate is 400MHz
Thread-Topic: [PATCH 1/2] arm64: dts: mediatek: mt8192: Make sure MSDCPLL's
 rate is 400MHz
Thread-Index: AQHZjJAWrLfN185o/UOQgdTEl4VP7K+LxL2A
Date:   Thu, 15 Jun 2023 09:51:20 +0000
Message-ID: <45cba46f9fb34acf393ec2743206403bc6a5e137.camel@mediatek.com>
References: <20230522093002.75137-1-angelogioacchino.delregno@collabora.com>
         <20230522093002.75137-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230522093002.75137-2-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|PSAPR03MB5367:EE_
x-ms-office365-filtering-correlation-id: 2431a76b-83ee-4ceb-ec4a-08db6d8612b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eWdf87lkg+x/Blq8wXRsxR/S2ZUxahF8mn+5WTFgSwGrFhG2bcYDjEhnWmpvTAVEtObcUpZJEXDQTdLWHuPOmyRW0E9LjfXzPWwmoV+pYaSqtuHeiJIwfktss2mO415hl5+rrVoD203QFaQTWe7R/Snw4johgZC6mtPwh/zAnpjR6ym8SL9NEtND7j6lhFKHQcJxoiDS5Yg2MzZdxCJXs+Ue8Y9ssU7VP/vPSqNxHIRctHacaBhT5aEkOqW4HDQFz+RsOyIEG90cyntKVS4JraxT9LAvSbLPVS0RHlewJ6eodErYOqSutw9GInH0qdt1uD8+FN/BzqnERiBtI/kqTD/WByUZJpw6/CAXsSGcNa2S6+fHsCCspf3smr6C6yruyDOEcAkMM3Y4LKcm9n1oo15OyI+rVRAtq6rB7EKGEILjXOCNlTwqNkQW6qeJ/NMWy8WemQZsZLk2e+QKbVK5VlL20TBfFjZzc6c5sqGylyGdlGL2offzCYqAexnhd2rv5KP6/Pr+BWiC9Iufg3qZstl41/Cpd6kWpe9h9xXbNN4rA+VF8H9J7HxuuX7dp/OrP1qvbHq286iErLcJFXc9CFBBf4d59Eu1TBZQ871EGrwHy12KcTEX6aVbDTROdl8rAo+hIEEupRpdKJLvKCrLqXcqkACtIX+GKY6JWSjUHLQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(26005)(6506007)(6512007)(38070700005)(85182001)(36756003)(38100700002)(86362001)(54906003)(110136005)(186003)(478600001)(8936002)(8676002)(7416002)(5660300002)(83380400001)(41300700001)(76116006)(6486002)(2906002)(66946007)(66556008)(4326008)(6636002)(66476007)(64756008)(66446008)(71200400001)(91956017)(316002)(2616005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXlYenRHcElhMHJhZmxiWEptNVphZ2xyTzl2TVVheDZmZk5ieVpVNlpKOG1J?=
 =?utf-8?B?OXhHTlN3K3hUMVkxRzlOSUR5VkJRMDlUM0p5VjhVelNEK05seHBlL3RrU0JO?=
 =?utf-8?B?NWFCeUs5MERadDVyaks1Vi9OQnBlTlZrZnVoZzh1L2UrYXJWV0tDU3Z5aVlL?=
 =?utf-8?B?SFRhTFpVVW9rUUZaUkZsbllKOGltbWcxekVwSWV6WGNWb1h4aHo0N3JyeGVk?=
 =?utf-8?B?aDIydzgwQ2tkMDVqK0R5NWwwU05ZcW9wUnlUdHFXNkdsMklEaklqMkdZREc0?=
 =?utf-8?B?MEFhK0g1dUx5TW96Q2JFOG9EbjdSOGQ2cXRGT0Vpb0dnOEhRdGtqbk9DTzFQ?=
 =?utf-8?B?RGZxdmhuTDBGRjNoRHlmekJIOFBSMURwbWMraG5jejVDVnRweEJ1R0tMRWtY?=
 =?utf-8?B?NzZIZDk4VVA3eGp5NWZqVUZuektrcFJZVGNkcTNrUGdCSkYzVUZmTm81OGRP?=
 =?utf-8?B?UitmRSs0OGEyRnBkNnNzRWVtVjdTM2g2dFN5MFEzbVhOdjA2OXNhYzlkckF3?=
 =?utf-8?B?L1huVHlNVUppZngxRWhOWXpaakVLQ2FQM3cwSDVNYTNCUjZkekdsL1NPNE9K?=
 =?utf-8?B?YUx2OXJPRFlXVEd4YTlmRFM4cjVjd090emZ6NUxtVjh1dFRYRGF4TmZvbE5w?=
 =?utf-8?B?WUFUblczY0R3Z2FudzNqR0R3TmZpb3FuZW1LYkJIU2RpY0RmOVpXSW5Kem5Y?=
 =?utf-8?B?cDJxZE4zMmlvSVU5VXhScGU2YS9BZGtVRUMxeUd4d25zeWdjVmVIR2JyS3Qx?=
 =?utf-8?B?bzJGT1pHb25mK1Fac2phUHRtZjhxM0lFQUtMMzhwbGozaVZyY3gxdkRkZkYz?=
 =?utf-8?B?WncreGhKbldIMjlqTng4ejlySkV5VG1MbU0xUlA0QXFLYTYxRGNaODVIeTVi?=
 =?utf-8?B?KzBNR2dFWUdZQ0R3VlFVSVpueDBwVFZRYmNwMlpUQXdjemxDU3NvaHBXQVN1?=
 =?utf-8?B?U2haNGFlUXFwSUh4dENndmlnR1ZLSmkydTRjWUZWMGpTaWdyci9HbzR5ZHYy?=
 =?utf-8?B?NVpyMTdwbW9jS0tXSVlEWmQveVpqVmJaRzdmVzRxZ2xVa0s2ZE4wWC9qVzQ2?=
 =?utf-8?B?OFZxMjhRbzhSOXlyYzV0dC9jaVFURkl0d1FTOXB5aE9WZXltcXpMa0ZVOWQv?=
 =?utf-8?B?d1FKVm5UT0ZwOU9GT0FGRWh5M0x5VUdjVHlNalJ2TEpaMm82WGl3dEdtTWVW?=
 =?utf-8?B?STVqSHQzdllleFVzWjc5bHNTN1JWbXVwR3JZd3pnNWVuNmNWSEdrZ3ErL2tG?=
 =?utf-8?B?YUJDa2FuN3YreTYrWXYvb29EcFNxOXdva2NLeHd3NkR5cWtKeFJVTWhHR1dw?=
 =?utf-8?B?VUIzK2E0aTFyT3B1Qk1XdnY4V0hGdjU5N1FLTUhwN0xEM0JVcnlXa21lQ09a?=
 =?utf-8?B?bzNEeVFDUldpRDc1RVVPS05VK1RrVjlUTmVhcjFBS0Fzbm9kaWx4K01hdWNI?=
 =?utf-8?B?am9jUGorSWs0MU1Yc3VZS3RMbDlDVVRnemNQV0NCWlg3WGdxME52YTRjNUs2?=
 =?utf-8?B?c2Y5ajZxUXU1UHQva2FKRXoxbXpWSzN0bVpxS3JqREQ4Y0NyZjR2aVAyejlE?=
 =?utf-8?B?a1FHZmJSaTJUNlhxYU1Cd01PckRlVFVhTkNPVzhaUmplMG9GNnVCMkpMQ0x0?=
 =?utf-8?B?MXk4TEh6eWM5bVdxUy9CT0F3THRmWElQcXBKampSY2V4QzNJUldLWXd6QjNj?=
 =?utf-8?B?ZElFZzZzSzNISzB0Q2ttQjhHN3V6R3lRRkd2ZjZwOGhDM2lxa25PWDc2NWdR?=
 =?utf-8?B?TjUvbzN3RzlXVzIyYU1jYkoySndCb0IwV0JYdFFuTmFQNVc4cHBEdjVNb1hz?=
 =?utf-8?B?T2dFTjJuUm9VYjU5c3RRcVNrRmJRclllUCtvRHVYM3BTNTVUTnJMSi9tc2ta?=
 =?utf-8?B?N1d1RU5jbkhIcFBENWdGZGJoNGptZDllZW90dEJCWkRvaG13czJHaXMyZU9O?=
 =?utf-8?B?aFBmMzhBZm5xYncwWnZIQUZ4UkMyaGlMZ3RvTENuN1YvMWxXYWZZQTgwNEJa?=
 =?utf-8?B?a3BKYjkyemlGV2ZESm5DQmRKd2RDMk95c1V4NnpHUmtEaStTTTh2NmxpTEYy?=
 =?utf-8?B?eHJ4UkQ5dzUzelJ6dy9VOTVYM2E0MEFnWFc3Yzh6SnlkZkx6VEdVcjZCc3pm?=
 =?utf-8?B?L0ZQM0N5UGExUXBiQXJWNS95VncweEpIQnAvZEdBSCtTbUZlWlZjZnREeG1L?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E6DABC02D09C947A0A5D4DD45AE0455@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2431a76b-83ee-4ceb-ec4a-08db6d8612b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 09:51:20.9992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sgZsRBUaRRQyuZd0pSNm99UzK9ZWDYBMJBaR26ldIa/nqpVhffR+aAC13GbejXVEQMwgS4ouXYvHcL4tZP+VuElF0UC8H1DpxtmeBiOUp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5367
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KT24gTW9uLCAyMDIzLTA1LTIyIGF0IDExOjMwICswMjAw
LCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQ
bGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhh
dmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBTb21lIGJv
b3Rsb2FkZXJzIHdpbGwgc2V0IE1TRENQTEwncyByYXRlIGxvd2VyIHRoYW4gNDAwTUh6OiB3aGF0
IEkgaGF2ZQ0KPiBzZWVuIGlzIHRoaXMgY2xvY2sgYmVpbmcgc2V0IGF0IGFyb3VuZCAzODRNSHou
DQo+IFRoaXMgaXMgYSBwZXJmb3JtYW5jZSBjb25jZXJuIChhbmQgcG9zc2libHkgYSBzdGFiaWxp
dHkgb25lLCBmb3IgcGlja3kNCj4gZU1NQy9TRCBjYXJkcykgYXMgdGhlIE1TREMgY29udHJvbGxl
cidzIGludGVybmFsIGRpdmllciB3aWxsIGNob29zZSBhDQo+IGZyZXF1ZW5jeSB0aGF0IGlzIGxv
d2VyIHRoYW4gZXhwZWN0ZWQsIGluIHRoZSBlbmQgY2F1c2luZyBhIGRpZmZlcmVuY2UNCj4gaW4g
dGhlIGV4cGVjdGVkIG1tYy9zZCBkZXZpY2UncyB0aW1pbmdzLg0KPiANCj4gTWFrZSBzdXJlIHRo
YXQgdGhlIE1TRENQTEwgZnJlcXVlbmN5IGlzIGFsd2F5cyBzZXQgdG8gNDAwTUh6IHRvIGJvdGgN
Cj4gaW1wcm92ZSBwZXJmb3JtYW5jZSBhbmQgcmVsaWFiaWxpdHkgb2YgdGhlIHNkL21tYyBzdG9y
YWdlLg0KPiANCj4gRml4ZXM6IDVkMmI4OTdiYzZmNSAoImFybTY0OiBkdHM6IG1lZGlhdGVrOiBB
ZGQgbXQ4MTkyIGNsb2NrIGNvbnRyb2xsZXJzIikNCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lv
YWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNv
bT4NCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpIHwg
MiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQo+IGluZGV4IDVjMzBjYWY3NDAyNi4uNmZj
MTQwMDRmNmZkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE5Mi5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0
c2kNCj4gQEAgLTY3Nyw2ICs2NzcsOCBAQCBhcG1peGVkc3lzOiBzeXNjb25AMTAwMGMwMDAgew0K
PiAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1h
cG1peGVkc3lzIiwgInN5c2NvbiI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDww
IDB4MTAwMGMwMDAgMCAweDEwMDA+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAjY2xvY2st
Y2VsbHMgPSA8MT47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGFzc2lnbmVkLWNsb2NrcyA9
IDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9NU0RDUExMPjsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8NDAwMDAwMDAwPjsNCj4gICAgICAgICAgICAg
ICAgIH07DQo+IA0KPiAgICAgICAgICAgICAgICAgc3lzdGltZXI6IHRpbWVyQDEwMDE3MDAwIHsN
Cj4gLS0NCj4gMi40MC4xDQo+IA0KDQpDb21tZW50IGZyb20gbXRrIGVtbWMgb3duZXIsDQoNCiJB
cyB3ZSBhbGwga25vdywgdGhlIGNsb2NrIGhhcyBzb21lIGppdHRlciwgd2hlbiB3ZSBzZXQgTVNE
Q1BMTCB0byA0MDBNLCANCmJ1dCB0aGUgYWN0dWFsIG1lYXN1cmVtZW50IGlzIG5vdCBleGFjdGx5
IDIwME0uDQpGb3IgZU1NQywgdGhlIHNwZWMgc3RpcHVsYXRlcyB0aGF0IGNsb2NrIGNhbm5vdCBl
eGNlZWQgMjAwTS4gDQpJZiBNU0RDUExMIGlzIHNldCB0byA0MDBNLCB0aGUgYWN0dWFsIG1lYXN1
cmVtZW50IG1heSBleGNlZWQgdGhlIHNwZWMuDQpTbyB3ZSBzZXQgTVNEQ1BMTCB0byAzODRNIGlu
IHRoZSBib290bG9hZGVyIHN0YWdlIHRvIGF2b2lkIGV4Y2VlZGluZyB0aGUgc3BlYy4iDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVGluZ0hhbg0K
