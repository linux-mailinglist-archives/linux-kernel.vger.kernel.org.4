Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5825B7001C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbjELHw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbjELHwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:52:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30ACE723;
        Fri, 12 May 2023 00:52:22 -0700 (PDT)
X-UUID: e9bcad0af09911ed9cb5633481061a41-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Zdq3wPu89sAkkQH3KbS66vEXDujgY2S0Kf1IY56AcBs=;
        b=IgZKv6pYXe+v7wvnHqDpgsrc7/F2lXwGtArP2u+Q4h0O0Ey6w/ZrVf9AVI+Zzd38iyq709raXgVlGAHNoL1KyuE8PDtDog7ApVvZZtdRPxN0pjRcAF3bgCewYjtPW/FI/srDG6u4GvraN6fkkb4AFzCVsdzJVkypSAw4BcxPmA0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:3872b544-30a4-4787-b211-36dbda949612,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:ed4aa1c0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: e9bcad0af09911ed9cb5633481061a41-20230512
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1563688302; Fri, 12 May 2023 15:52:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 15:52:14 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 15:52:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQoKilAUZVn61nQvX+Tb6th8mPggTsjVxwuZzp8pJOg0q3kp+D8IIBirvg/CTl3X6Pxyi12R+SOmshOsCQ/kv9D8F1gRPWtETTN0MHRS3hbKHE8LuESfgbIIPPVRiZWdaZ1h9MGJO43WV142W09onPvGthayXbXyUijoMNBqWwpg+/cXzDGZ6gXS/5ZHBTAtbJgeg4Ppx6S8kubzzK6f4DDKco3oJT98jfsxbHx9IOwa+Qv6DCqqvJqeJ57p1I4AvbP1EvhX6h83BJKd4uMbHCjX26wOVJS7NqaKJ2yI+liQJ8q3bYLFanoX16oJkNhVzq84pQbP3m5qwosXw7mejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zdq3wPu89sAkkQH3KbS66vEXDujgY2S0Kf1IY56AcBs=;
 b=Z1h67FZUQwZzjqKCaJ0zuU6ntZhXTsazbhZDA9p+kAGbVlODYDUJ9rkTGINspHi3DagLf4lwiIQDKGCKnWu8FEAkrGDLn6aTmZPBpTBnwM1ZvJy6OFh6IbH7iV/X0jdO9VqZaqyR6ETev6BzONRG5LvTktu11pJ+YahUaV37uG600paJ28T7z24D10qOc6SUyvyFObEyAwDL+mnRWrj4bOpu9KpSrgs/CR6hdQAm1eKtW1F31m4uTQz1UXOwShluzsBakTvD+TOqx9VYDy26ENqTl4CUQ9yosLHC/WRNqhS72L0sBaR/1gS9pb52tXCTQ/dk/vi6d6uSPpcBwEnVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdq3wPu89sAkkQH3KbS66vEXDujgY2S0Kf1IY56AcBs=;
 b=eUqcG4f7Z2chCtYJ2VeE6oFNVM/IvZPDvmAxDzzRAGq90bp8rJ+m/+H290WkrX3eBrWG+0n05B0at3qxoxb4lUbBIitZ14gLtPqh/9NCJPDtfHunS5z3V9t2Xu5HiNT3ld3QHuiPO81cBr69WIABPA0rk/Fi3aqlEBPz9QIMquw=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 KL1PR03MB7765.apcprd03.prod.outlook.com (2603:1096:820:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.23; Fri, 12 May 2023 07:52:12 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 07:52:12 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        =?utf-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>
Subject: Re: [PATCH v1 2/6] dt-bindings: hypervisor: Add binding for MediaTek
 GenieZone hypervisor
Thread-Topic: [PATCH v1 2/6] dt-bindings: hypervisor: Add binding for MediaTek
 GenieZone hypervisor
Thread-Index: AQHZbeeIpBD7nBGd2ESOfkL+LicR1a8pNVKAgAFHHoCAAAHcAIAr8zQA
Date:   Fri, 12 May 2023 07:52:12 +0000
Message-ID: <89e7c62e18d1a21a26dd6ee7a3c94e39307d58d8.camel@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
         <20230413090735.4182-3-yi-de.wu@mediatek.com>
         <8ace9b0f-742a-7ebc-555f-1f8be04a5955@linaro.org>
         <7b4492efa4a1becbdfb79d23a0a0c0fe11dba5f4.camel@mediatek.com>
         <759c3b60-07f8-99c8-6ac2-73256538370e@linaro.org>
In-Reply-To: <759c3b60-07f8-99c8-6ac2-73256538370e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|KL1PR03MB7765:EE_
x-ms-office365-filtering-correlation-id: 88730d6b-3481-49f1-96c2-08db52bdcb93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQArKvvSI8FYMjPfzZB+9vaNJsFx8jjWOTDX24gD1V5c/J6/fa4G/GKR54aaaEB5VzenyDWBL9GnSZ+pxAkNfX3rOcUWvjIk7xxnqiU+ozfEawvLTJUFKnqsiFOBTRajKtmNMRDCgiwK67wia4D1P2pReHCrIsSIL0pHk2oqM0Hr+BBmoNNlScU1P9xYljsIjFPonTvHTEYYpQKslbqlFYcSRp7JcK07/iAzl/TOrYQSzd9v31k1X8DJNp8aUaCvEzLkLwOVyfL62PzZ+1wUc4b4aUGZ3opgzYiUbJfLNjTr+RLNHbYGmge77hngpBivjo94r/gMX01099mNTiAJnWpR07+IAiUA2O/aQm6Davj0XiaND2jUmVJbXhWrQfCF2RMs2JmkK8m9byl1XQ2LANFDKgEuqak38qub2M3JLUwqvKVtZYhBibCIkq31NRGZ4hxtYUVkF29uIy/Av2FBcwEh5Ggmr0I/AjXAu0keIfdo00cZgC8vwXIFqJcAfhBPeTpC42xKl8EvX/BiKdsPOL6bgtOyznBXJNKXJr/8FCopAOzvvhfrsALvMb+uGLIgtJl+HuRddTiHRtEreTyjTty50LToL1nagFoKjFfVPDPzcXqAJ75fFWAlzP7CtLUL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(7416002)(85182001)(36756003)(8676002)(8936002)(38070700005)(5660300002)(4744005)(2906002)(91956017)(2616005)(64756008)(66476007)(66446008)(66556008)(76116006)(66946007)(41300700001)(83380400001)(86362001)(316002)(4326008)(26005)(107886003)(53546011)(6512007)(110136005)(6506007)(186003)(478600001)(54906003)(122000001)(71200400001)(38100700002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?andSUjZ5ZWtwdlVNY3FibE8vNFlldTd6ZnZadkZCSHlDLzNPdGNyZVZlY1g5?=
 =?utf-8?B?aHVFR3NJMjRqeDRQV3lqazdnVXRrVWZ6THJrM2hXQUxnV2s3aWdERHUyNzdy?=
 =?utf-8?B?L3pacElHaldYb0xNY1dBbll2Ulo2MTd1NVZqSDgydTI4NUJLanJQUXNteEFw?=
 =?utf-8?B?NlVCK1dXeCs1V0piWlZjZjBmVko1MmhpcEs2cU5DZFBPTHpOSGVIUXc2TDhY?=
 =?utf-8?B?ditNaTlnWmYrUXNrQnB2bEZ5QWgwNXMvMkEwUTRkcWdwRGNxWW5GcTV3d0Jx?=
 =?utf-8?B?bzU5K1FnL0Zrak8yRU9UdVo0Y0w3Tmhsd2FwL0N3NjBENGhFakl5a0ZBNnJB?=
 =?utf-8?B?RnRDVHpONFl1YkVGYThLaTdpUUpRWEZrVEVWZXBtZjNaTCtpQmNEOXpnVUs2?=
 =?utf-8?B?emJrWGw0eVBCVVBYTnk2SHBUWXdGNHF5OVBWWDUwZkh3cjBDbGdTbWx2eE40?=
 =?utf-8?B?ODhsL2ZVUk1GdXZEajFSVjBnUk1nZ2crS2dONExLMndjUkN2WWVOeld4ZXRa?=
 =?utf-8?B?QUdVTFQrSVZydHRsdzZHaFhlSlVHVTZIb3RYOFRVdmhhL2FCSHBPekI5aEZX?=
 =?utf-8?B?L3NHUWNLaEJCOTlFbDhpWDBjdzljYzdTOC9aTDR0UXJvSGc3ZkgzUHF2WjJn?=
 =?utf-8?B?SWtRd1pHRmdCT3Q0dnZhNjNTUkV1VlRrbDVUSXQweGZkT0VQOG1qcEtJQzN0?=
 =?utf-8?B?QlpUaXJ5THd3QXBuOURiWERHd0tDRXNiRnFHTEcvUUR5MEJxbTI0YUxrbHJW?=
 =?utf-8?B?NGhybkdKcXhmS1pNeHFEQnQxY25qTHJLMjJlaUV0ckFjLzNGR01ZdkRHMFMr?=
 =?utf-8?B?K3NWSXk3amFzeUtmQUU5MXE3YWV2WlZ6cHgyK0R3eFUyS2p2T1NzdzFHaHNH?=
 =?utf-8?B?SzR1SjBVRmh5QWFOMnRmdTFZUnJ3YzRKeGp3K0RUdUFQT1hVRlY2eTU5Ylpt?=
 =?utf-8?B?UG8yYXBZV3FPakVwMVl4SHk1V0N4YVJKMVNYV2l3U0V0Zm13ZU02ejZOUGg0?=
 =?utf-8?B?eGo2UURtdTFkYlI5RGtyeWl5d1g3dWozdEpTUXlMRktVOW1CMU5RWXRBS0xt?=
 =?utf-8?B?cWN1aCtWL3pwUUc5akxWT0x0bG1RWTBNZ1pERWZSYU1wVjJkNXlXSSttZ2c4?=
 =?utf-8?B?TmkyTFFWcVFuaXdZOW0wemNoN1dhQUdvcDE1MCs2K2VRNzFmeGJ5ajFickRw?=
 =?utf-8?B?azU3bU5SaWpxWHhBTy9lM3pNTGJYaW1BU0lPQ08rSXhnUC9NSS9LYWwwVXpS?=
 =?utf-8?B?QkpyM1lkOTRLMnplZEZnVG00TnVRRDk3cDBsMWIrMnJNem5oNmtzZ0ZTcUlK?=
 =?utf-8?B?NjNSK29LYmdaOE1QK3lIV3cwRWgwSXMwazdKZWd1V3ZxWXpCL25uZDgrZDg3?=
 =?utf-8?B?MXJYeFJNREtHbnMrWHczejZIOHUzM2N1Q3MyQVA1RkZFL2ZlNkRsUnZ3eDVz?=
 =?utf-8?B?NVl2TVk1V0JoS3FPREpLV3pTYXYwTmF0c0tpaVlFNlM5aWJRaFVtK0ZQRlFy?=
 =?utf-8?B?eW9uWThlNmVhSVJZVmdlaVplMVE4TTFaODRWQU1LVWpjRHY1cHVMMUc2ODdw?=
 =?utf-8?B?dzV6dE5UOVRXQ1duYU1ZMGl3TTlYbWE2TzJIeUhMTnF0dkNkRXYwSlV6TExH?=
 =?utf-8?B?Q01kc2RtZ1dXOVY5MTBjYk51Z1BheG5neVFHK1RYaURPdG96bzdkbW91NERE?=
 =?utf-8?B?S1QvajVyaGpUYVVhRUt1SzBvd0JMTmFTRFpZUnk4QjUxLzFYelgwSkRXTUdF?=
 =?utf-8?B?YUFzMVFQZTNjWkw4cENHK01TbnR5UXY5MlBzdWkwYnRycHpnVXBDL3ZsMXRY?=
 =?utf-8?B?UkVkQm5BeXJhMnQ0Q2lGWEFXMkFuNFRhbnVKYUVuU2lZeTVhUXdpV0lUSktB?=
 =?utf-8?B?ZjZBUHVLL3ZNenhKR2pCYlkzUEx3aGR6ZFhTWjQrSEFTbmtrNndLcjIwTXJ6?=
 =?utf-8?B?YU1vWUdNSzZRT1A0QlI1MTk2eDhmTnpwanlBN3E4OXZTUmJaaHFIcWF5L0lV?=
 =?utf-8?B?Q0phVWhUZFcvTzlXQzlkYnRWbng4WlJaNWRTSTVlUzJxR0lNQVNYTkRXMXlX?=
 =?utf-8?B?S1UwbXJXS2c4Y09RbEd4NGpPZ0NLSldONXFwTHhQa0ZCSzhmQi80cFVsYnRm?=
 =?utf-8?B?cGJ4YVN3QTNMSTU2TkIwYWQyMTBQUVBRcG5TVGd2RDJBcjA4QVJJMG1zVmRy?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C408E2716FD474BBC43264CBA3D7CA3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88730d6b-3481-49f1-96c2-08db52bdcb93
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 07:52:12.0701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNj41SIz5htSgpgTiC+XPbEaPDHxAbqm1ym056SZQ0X1oZtn28Sx2T5Mkjz7Fvpx6mGpSZ7fvDvyMZkXOXQTEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7765
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDEwOjQyICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDE0LzA0LzIwMjMgMTA6MzUsIFlpLURlIFd1ICjlkLPk
uIDlvrcpIHdyb3RlOg0KPiA+ID4gSSBkb24ndCBrbm93IGlmIHdlIGFjdHVhbGx5IHdhbnQgdG8g
c3VwcG9ydCBwcm9wcmlldGFyeQ0KPiA+ID4gaHlwZXJ2aXNvcnMuDQo+ID4gPiBUaGVyZSBjYW4g
YmUgaHVuZHJlZHMgb2YgdGhlbSwgb25lIHBlciBlYWNoIFNvQyBtYW51ZmFjdHVyZXIsIGFuZA0K
PiA+ID4gdGhleQ0KPiA+ID4gY2FuIGNvbWUgd2l0aCBtYW55IHJpZGljdWxvdXMgaWRlYXMuDQo+
ID4gPiANCj4gPiANCj4gPiBNZWRpYVRlaywgYXMgYSBwYXJ0bmVyIG9mIEFuZHJvaWQsIG91ciBH
ZW5pZVpvbmUgaHlwZXJ2aXNvciBoYXMNCj4gPiBiZWVuDQo+ID4gb25lIG9mIHRoZSBiYWNrZW5k
IG9wdGlvbnMgdW5kZXIgQW5kcm9pZCBWaXJ0dWFsaXphdGlvbg0KPiA+IEZyYW1ld29yayhBVkYp
DQo+ID4gbm93Lg0KPiA+IFRodXMsIHdlJ2QgbGlrZSB0byBkb25hdGUgdGhlc2UgcGF0Y2hlcyBm
b3IgYmV0dGVyIHN1cHBvcnRpbmcgdGhlDQo+ID4gTGludXgvQW5kcm9pZCBlY29zeXN0ZW0uDQo+
IA0KPiBJZiBpdCBpcyBwcm9wcmlldGFyeSwgSSBkb24ndCBoYXZlIG11Y2ggaW50ZXJlc3RzIGlu
IGl0LiBNYWtlIGl0DQo+IG9wZW4tc291cmNlLiA6KQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBL
cnp5c3p0b2YNCj4gDQpJJ20gc29ycnkgaXQncyBoYXJkIGZvciB1cyB0byBvcGVuIHNvdXJjZSBy
aWdodCBhd2F5LiBXZSB0ZW5kIHRvDQplbGFib3JhdGUgbW9yZSBvbiBvdXIgZGVzaWduIGluIHRo
ZSBkb2N1bWVudGF0aW9uIGFuZCBtYWtlIGl0IG1vcmUNCnRyYW5zcGFyZW50IHRvIHRoZSBwdWJs
aWMgYW5kIHJldmlld2Vycy4NCg==
