Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2269A5E9812
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 04:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiIZCtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 22:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiIZCtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 22:49:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A66E2BA;
        Sun, 25 Sep 2022 19:49:33 -0700 (PDT)
X-UUID: 90b89faf345b484fa8ab45e8bcbb4434-20220926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=f9r1DZlngSWdfH4vZxWT6quZUvrN8ldIl1D8jWVrpV0=;
        b=geszGnfg8Bn+0euHCoX4oENQyXSF3xip7XVSuopKRyUGOYTQPLpIn9ITXYMDxH2rNEmiMDMbnlBlOWaY0h4hlNJ5cjrwkjE/qzpGxBWsxql5biNy5jowd+xyoJpY1SpWt0yUWWoOFCabnbPRUjF5F3TuG3FcwKYINTv2GWc88Po=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:ab8444cb-4871-4a57-8b09-23c086c2267e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:7bcef806-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 90b89faf345b484fa8ab45e8bcbb4434-20220926
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1487828809; Mon, 26 Sep 2022 10:49:30 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 26 Sep 2022 10:49:29 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 26 Sep 2022 10:49:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBsWqzgLrXOkPQtS4ull0/wK6L6ijxMKxWelqQoW1EiK5zp0mtybPsh28/jGbYUVRCcPFnufvzR2+WMJMYQgtIhMa9a15izXYjkuWoY8vVliJfMZssvK4DeYoOxBgviTus0UM8VtRqjSKk3r7yEpkEwzGllSfFJ/1PQhGv8+kLMvGrkZ09+uUmi9RBsyMX8+VDj+WmfNUrFWZCWbo+QtrtEXXKBhSNG6ibhoN6eCOHUfE39RHmZgl1nbMQ3OmWUPfK0Yeoz/gpfZXan2PLuJS3Dhv0rHOgh82AX1D/aYSnsn+1BZG+IbL86q/y+T2h/fZMQwxZK7TDp/Ls79twJbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9r1DZlngSWdfH4vZxWT6quZUvrN8ldIl1D8jWVrpV0=;
 b=axxf6WTgiPUo5rydpE/DUjQo/sxpK2FGB6HyaCP/VOA5oYvcYy0yeM+UYzKheDXRWQeBdT3GJhjJQzAxmQLReQSqRu+TLAbtQZgEZSKwtBBjXHGXscRo3AIGy8cwKHrF/A3141lLMafNRuJwGYFhmqO8Hnly9FnJN2rFBYAb2/nH2PEkoIj7CC6glSkXNvRPAAskfQir+C46FTfld9FdJAV2/d2iNjqJLy6dlm8E7Z5Av9Qh5/7PFNEDD3sS2hrWElrld+hivybnicLUxeLb8zNi7epM645KQH6PmMV7Sg6hUL7hN/8jd3J1eom8jy0Xe7WMFOCIYT2Bm9CSwmm22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9r1DZlngSWdfH4vZxWT6quZUvrN8ldIl1D8jWVrpV0=;
 b=Z9POYJkPNlJ7xyOyeGN3qLZIIA/++NTTkvXvnyUAraUPoakwsfNgfVfbeq/rQl0xzfwqcCf5ftavbkPKssUyemnwLuJ5uao9AD5gmBx9y2o8d95Jvh1MESuA2jzuqR/IxYnGkvmwG0aScq23FDVhIiAFqCRWSeCHIMOg+TXaT6w=
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com (2603:1096:803:3b::21)
 by SI2PR03MB6055.apcprd03.prod.outlook.com (2603:1096:4:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.14; Mon, 26 Sep
 2022 02:49:26 +0000
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::2750:5f7b:1d14:d1a8]) by PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::2750:5f7b:1d14:d1a8%5]) with mapi id 15.20.5676.013; Mon, 26 Sep 2022
 02:49:25 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: mediatek: mmsys: change
 compatible for MT8195
Thread-Topic: [PATCH v4 1/6] dt-bindings: arm: mediatek: mmsys: change
 compatible for MT8195
Thread-Index: AQHYz+vboK/WYXWDzUaGZ4HNo8ogna3vx8EAgAEkkwCAABkAAA==
Date:   Mon, 26 Sep 2022 02:49:25 +0000
Message-ID: <99c38ceec83c2470fa4eb6a4d1416388b0679c55.camel@mediatek.com>
References: <20220924080058.20566-1-jason-jh.lin@mediatek.com>
         <20220924080058.20566-2-jason-jh.lin@mediatek.com>
         <6bbe9527-ae48-30e0-fb45-519223a744d7@linaro.org>
         <23fd466265eec1effd83de6e8ad4ff64eadf5cae.camel@mediatek.com>
In-Reply-To: <23fd466265eec1effd83de6e8ad4ff64eadf5cae.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU1PR03MB3062:EE_|SI2PR03MB6055:EE_
x-ms-office365-filtering-correlation-id: 08c0ba87-a94a-404b-15a0-08da9f69b94b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZ+w66pTbNoPo/c7/nQ1Ab1WXz44KuggcfUjGsYpbJDmjE64MPVBD29/7qhbYXbOf/bqDDMS+ZamFoeXSd22ZRPigK35d8p+wuce2R++fgjCwG+ZFk54yrUZ+QEsAFv9OZf0CDrybXq0K9yvieHsiEeIDlI/VHFRGJCOnN6B+/+mPxiiaY3UlrweIVMA/a4FyaXz25I3NMPOvImveiE6xjhP4aYm/jeym2CTrWk/T0Avem85ehVoatq27PvWhEWHfVWt11q37tQ98WSVL2Z1eZY2EeXm3e+ohRV9kZlNUeNVWCBrl9lIV9/jNRGFBxOpBU3JDMEiaXx07Z1bKlrgRo5baRFv7NkXJTo13pCc/BrMnP1hUOETi7VMLslxCLPscdn2/q+sgilgQxAd7pyQDhQrydKVVTYJ/RVe5J2QU4qu8fer0+uski1Mvw0oc5QpsnsNVcbYM9sGqcaqS2+M2wlSBmJbWoTAmYs0HJDtXc9bCdNXyohjyTYLB2dGR+Bri0aL8EHqOc8pRRsu7ntIumDKpsn69yjNhgJ15lYrO4eF4j4vxJURkLwgUCRNRF4j9CQHOzhn3sg4rkcb6Pk1rn57npXb9x0YN1win6U3AzQWwzu4SUqwpjm7AgXYU/xgsNxJ14CBvT7bR/u+G7FT3fuVCpSGBJB0kvKHgEQp7G05DxaWSAd6vE+LZnp9BDgcJTOVvC47WK6S1sHmxogWTxeDOinkmutHmiOoCRdzK+Zl3LecKcA8yaZo5m3D96tZOp2mB/eoERn1cii9oxxFTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU1PR03MB3062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199015)(316002)(110136005)(54906003)(4326008)(76116006)(66556008)(64756008)(66946007)(66476007)(66446008)(6486002)(86362001)(8676002)(91956017)(71200400001)(38070700005)(26005)(6512007)(8936002)(7416002)(36756003)(85182001)(83380400001)(5660300002)(6506007)(53546011)(107886003)(41300700001)(2616005)(186003)(478600001)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3JhSFhRRndVOVFxWThrUTVEZXdwZ3FjbDM2K0NDSGZxY2dGN0pLN2VUNDdW?=
 =?utf-8?B?Ymp6M2dwUys0T3ZZblIzTDFvSXdrMUFIOGVreHJtaGJmaHZlWTdEWUd3UzZL?=
 =?utf-8?B?QzdWb0laZjdLR3l1UHBtNllyWm9Cak5aU3F0cUY4a2hRbFljWmFQbDdyQlBU?=
 =?utf-8?B?TXU3aStZbDNQYU5wenhoZy82Q1pTTFFmblFveGp2cFZYNWZPMHNQZm81NktR?=
 =?utf-8?B?RzdxVGhtNXdBakJ5bVJwbHh4Q3JEeW9OamY4TFptc3FCdGc4YkJnNmZkSnlr?=
 =?utf-8?B?LzBkNTJYNmpRaytBTWM1S3UwZ253QnU0RDRtcEhQaE1lT1Nvc1QwVTVFZHJY?=
 =?utf-8?B?OFVtSzFrOWdXdzZ5dEdvaktDcHE1UUlPMlZYQ2E3U3JOVE5DRFhCU3M0YUJv?=
 =?utf-8?B?RkdUa2dxa1M4dkxEcVNwRjE0YnNvdWlvQXZnMThVbHpxazBGTkhHTkdqUFRJ?=
 =?utf-8?B?MExlelNucXByRWxZV1kzL0UxSktOYmgyelg4YzMzNEdrQ0d1cWlWYkNFVGZD?=
 =?utf-8?B?cjV4K2JwVzNhOXNyeG5JWXBPeGpsWktWVWY3YXgwTWVjR3FpQjJsTThVaEJi?=
 =?utf-8?B?VkNvUXFSZmp5SDJTa1pZbDk3UmVURGU0bWRjaFVNT3VYTktDaU1ETHpVaUVH?=
 =?utf-8?B?bzFkeWt5TE9Cb0h6OFY4d3prVGpJaEs1STdQbWNBaUhLMzlqU1BIaVhoUXgv?=
 =?utf-8?B?c1gzSGV6NFEwNHJ6YnJXTlYveTgwTHpXQkcxalNtYkVBSXQ5VmlKUEZxdVN5?=
 =?utf-8?B?Uk5XdzBGUS9xZC9IRkNBeTkwa0FSeUNsR3FuZW9sY1A5VzJPMFFCbDd5dHBE?=
 =?utf-8?B?TGg1Q05YQWZpZmpEak9VZlpCWnEwcEE3djEzWGwrNlNpK0ZzZ3lKRU9HeXZF?=
 =?utf-8?B?dTFxaWJ4cEl1UmhtMGZQV09oYXg2dklicGNrMjRMNk84bzFreVorVjlyeE5X?=
 =?utf-8?B?MzRBM3A0aTFTcGRKQ3RRK3A0a01WYUx1UmNSWDNGNHYzT04vQXkxOWxCZHlt?=
 =?utf-8?B?U3lUaTFVNzhmYlR3Wkt4K281Uk1ZNU1vZGt2NFY2RWRJRXNtM25CT3YrMVNs?=
 =?utf-8?B?ZWovd0Nya3hjSmZZbGg3MEY0M1Y5N2lSa05RdlRtM1Z0bzJRMyt3MUZlT1Fw?=
 =?utf-8?B?c0pwak13L2x5aDJ1K1FER0E0cGdTM2VFQWJQbWlhRktiSXJLMmVIbU83VmdX?=
 =?utf-8?B?SXFnMXYyWVFuWHorWjFzMndSMlpNSVAwLzArUW5idGo0YWd6WStwNkIzY05i?=
 =?utf-8?B?d0ZHdWVWYUYvam4wUEZSeWF2WDRTQVlyN2tzTTFwclFXYXJEbTZFbjF0enBS?=
 =?utf-8?B?T0F3YklkajNxcVoyb0pzbUFHaWdHYVZiN2RoYkl5N2VZQUNHUUdMUkZranpM?=
 =?utf-8?B?UktPcTNZWEpjTy9GZEJvNmM4dzJVTTAxSHBIVm5QT2ppcGdObkpQQU5lVVkz?=
 =?utf-8?B?UlFXNlp2UHJEb3Zna3hVT09LWWxtalJLaTNvQlFNblNMZkpwR01VYkRHUTdt?=
 =?utf-8?B?b2puUGJXdWVFNVVsSm1Fb1VqTGVoMCt0cWI1OGFlRG4yYlZMcXFLdGVqcExy?=
 =?utf-8?B?M3grMGNoU0JrRWsxam80ZFdCczlVQjRKZmVBb1FJY0ZHK0Z1elRzTS8vMERQ?=
 =?utf-8?B?S0FvN0pna21FcEpER0JZd1VmL2NDNXlqd0tmVHVpaTJBS2luTm1xUlVpMnZY?=
 =?utf-8?B?NGpJSGZrWjhPMTZMMXV4NWhGVUNQdkphMFBuZ2dNeElRK3Q2a3Naek1tTjBF?=
 =?utf-8?B?ZjVrTnp5WDFTZWNpOEtNMU5aVXpBTHdFaG9Ma1RPOC82YTRqTUJXYWRNVkNz?=
 =?utf-8?B?WjdleWZnNGJENHNhL2Q1Z0dXbnRBN0dLTFZLd0xISUd6dkpMWEMwbVFOazcy?=
 =?utf-8?B?S2Z6Y21SanlFS1FzczB4Z0hUcEhvRU5oNkUwOXloMUI5U1Y4SHV1NldiaEpJ?=
 =?utf-8?B?MU5OT1FDbGZBdHU1K2xxQW8vVXhpWEQ4U3pNRHBKVlVwcFlmdmhIU0RWVkZp?=
 =?utf-8?B?aDV0NEJFL2VrOGlsVGNTeGNyeHVSR3REcXQ3cWRvakJSYzhiZmNoRDN4c3lz?=
 =?utf-8?B?QVhvYnppQ2JZY2JuMDNnVVc4L1daWVZVTnJQQmdtVnJLM1dxemZWUkxQN2FS?=
 =?utf-8?B?aU1ESmFLbGNRNVUydWlVZUFpdlpOTC9oVWdRc1VQMkw4ZDR4L2krb1FjeTBs?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90278F4B3A1F394282C5A22B14257C28@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU1PR03MB3062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c0ba87-a94a-404b-15a0-08da9f69b94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 02:49:25.4965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sppsx6hRdvcEkJhuuba8zC9O/nB80qAW/Qs8Gvuk9SWvY/6So4+JfERTPLC7eHqvWiUG+Qw8Lde6sWWZVNWY5e7SdMU+XUnCWY7bUbXG7dI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA5LTI2IGF0IDA5OjE5ICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+
IEhpIEtyenlzenRvZiwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQo+IA0KPiBPbiBT
dW4sIDIwMjItMDktMjUgYXQgMDk6NTIgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6
DQo+ID4gT24gMjQvMDkvMjAyMiAxMDowMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+ID4gRm9y
IHByZXZpb3VzIE1lZGlhVGVrIFNvQ3MsIHN1Y2ggYXMgTVQ4MTczLCB0aGVyZSBhcmUgMiBkaXNw
bGF5DQo+ID4gPiBIVw0KPiA+ID4gcGlwZWxpbmVzIGJpbmRpbmcgdG8gMSBtbXN5cyB3aXRoIHRo
ZSBzYW1lIHBvd2VyIGRvbWFpbiwgdGhlIHNhbWUNCj4gPiA+IGNsb2NrIGRyaXZlciBhbmQgdGhl
IHNhbWUgbWVkaWF0ZWstZHJtIGRyaXZlci4NCj4gPiA+IA0KPiA+ID4gRm9yIE1UODE5NSwgVkRP
U1lTMCBhbmQgVkRPU1lTMSBhcmUgMiBkaXNwbGF5IEhXIHBpcGVsaW5lcw0KPiA+ID4gYmluZGlu
Zw0KPiA+ID4gdG8NCj4gPiA+IDIgZGlmZmVyZW50IHBvd2VyIGRvbWFpbnMsIGRpZmZlcmVudCBj
bG9jayBkcml2ZXJzIGFuZCBkaWZmZXJlbnQNCj4gPiA+IG1lZGlhdGVrLWRybSBkcml2ZXJzLg0K
PiA+ID4gDQo+ID4gPiBNb3Jlb3ZlciwgSGFyZHdhcmUgcGlwZWxpbmUgb2YgVkRPU1lTMCBoYXMg
dGhlc2UgY29tcG9uZW50czoNCj4gPiA+IENPTE9SLA0KPiA+ID4gQ0NPUlIsIEFBTCwgR0FNTUEs
IERJVEhFUi4gVGhleSBhcmUgcmVsYXRlZCB0byB0aGUgUFEgKFBpY3R1cmUNCj4gPiA+IFF1YWxp
dHkpDQo+ID4gPiBhbmQgdGhleSBtYWtlcyBWRE9TWVMwIHN1cHBvcnRzIFBRIGZ1bmN0aW9uIHdo
aWxlIHRoZXkgYXJlIG5vdA0KPiA+ID4gaW5jbHVkaW5nIGluIFZET1NZUzEuDQo+ID4gPiANCj4g
PiA+IEhhcmR3YXJlIHBpcGVsaW5lIG9mIFZET1NZUzEgaGFzIHRoZSBjb21wb25lbnQgRVRIRFIg
KEhEUiByZWxhdGVkDQo+ID4gPiBjb21wb25lbnQpLiBJdCBtYWtlcyBWRE9TWVMxIHN1cHBvcnRz
IHRoZSBIRFIgZnVuY3Rpb24gd2hpbGUgaXQncw0KPiA+ID4gbm90DQo+ID4gPiBpbmNsdWRpbmcg
aW4gVkRPU1lTMC4NCj4gPiA+IA0KPiA+ID4gVG8gc3VtbWFyaXplMDoNCj4gPiA+IE9ubHkgVkRP
U1lTMCBjYW4gc3VwcG9ydCBQUSBhZGp1c3RtZW50Lg0KPiA+ID4gT25seSBWRE9TWVMxIGNhbiBz
dXBwb3J0IEhEUiBhZGp1c3RtZW50Lg0KPiA+ID4gDQo+ID4gPiBUaGVyZWZvcmUsIHdlIG5lZWQg
dG8gc2VwYXJhdGUgdGhlc2UgdHdvIGRpZmZlcmVudCBtbXN5cw0KPiA+ID4gaGFyZHdhcmVzDQo+
ID4gPiB0bw0KPiA+ID4gMiBkaWZmZXJlbnQgY29tcGF0aWJsZXMgZm9yIE1UODE5NS4NCj4gPiA+
IA0KPiA+ID4gRml4ZXM6IDgxYzVhNDFkMTBiOSAoImR0LWJpbmRpbmdzOiBhcm06IG1lZGlhdGVr
OiBtbXN5czogYWRkDQo+ID4gPiBtdDgxOTUNCj4gPiA+IFNvQyBiaW5kaW5nIikNCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IEJvLUNoZW4gQ2hlbiA8cmV4LWJjLmNoZW5AbWVkaWF0ZWsuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVr
L21lZGlhdGVrLG1tc3lzLnlhbWwgICAgIHwgNQ0KPiA+ID4gKysrKy0NCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRp
ZmYgLS1naXQNCj4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9t
ZWRpYXRlay9tZWRpYXRlayxtbXN5cy55DQo+ID4gPiBhbQ0KPiA+ID4gbA0KPiA+ID4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lz
LnkNCj4gPiA+IGFtDQo+ID4gPiBsDQo+ID4gPiBpbmRleCA2YWQwMjNlZWMxOTMuLjRmOTBlYTAz
YzU5NiAxMDA2NDQNCj4gPiA+IC0tLQ0KPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnkNCj4gPiA+IGFtDQo+ID4gPiBs
DQo+ID4gPiArKysNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy55DQo+ID4gPiBhbQ0KPiA+ID4gbA0KPiA+ID4gQEAg
LTMxLDEzICszMSwxNiBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gICAgICAgICAgICAgICAgLSBtZWRp
YXRlayxtdDgxODMtbW1zeXMNCj4gPiA+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg2
LW1tc3lzDQo+ID4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1tbXN5cw0KPiA+
ID4gLSAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtbW1zeXMNCj4gPiANCj4gPiBXZSBr
ZWVwIG1ha2luZyBjaXJjbGVzLi4uDQo+IA0KPiBJIGRpZG4ndCBmaW5kIHRoZSBzYW1wbGUgb2Yg
ImRlcHJlY2F0ZWQiIGluIHRoZSBleGFtcGxlLXNjaGVtYS55YW1sLA0KPiBzbyBJIGtlZXAgbWlz
dW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLg0KPiBJJ20gc29ycnkgYWJvdXQgdGhhdC4uLg0KPiAN
Cj4gPiANCj4gPiBJIGFza2VkICJhbmQgd2h5IG1lZGlhdGVrLG10ODE5NS1tbXN5cyBpcyBrZXB0
IGFzIG5vbi1kZXByZWNhdGVkPyINCj4gPiANCj4gDQo+IFllcywgaXQgc2hvdWxkIGJlIGRlcHJl
Y2F0ZWQuIEkgc2hvdWxkbid0IHJlbW92ZSBpdC4uLg0KPiANCj4gPiBhbmQgeW91ciByZXNwb25z
ZSBpcyB0byByZW1vdmUgaXQuLi4gRWgsIG9rYXksIHRoYXQncyBmaW5lIGJ1dCBub3cNCj4gPiB5
b3VyDQo+ID4gY2hhbmdlIGNhdXNlcyBub3cgd2FybmluZ3MgaW4gZXhpc3RpbmcgRFRTLiBFaXRo
ZXIgeW91IGtlZXAgb2xkDQo+ID4gZW50cnkNCj4gPiBhcw0KPiA+IGRlcHJlY2F0ZWQgKGp1c3Qg
Z2l0IGdyZXAgZm9yIGRlcHJlY2F0ZWQsIHlvdSB3aWxsIGZpbmQgZXhhbXBsZXMNCj4gPiBob3cN
Cj4gPiB0bw0KPiA+IGRvIGl0KSBvciBmaXggdGhlIERUUy4NCj4gPiANCj4gDQo+IFRoYW5rcyBm
b3IgdGhlIGFkdmljZS4NCj4gDQo+IE5vdyBJIGZvdW5kIGFuIGV4YW1wbGUgaW4gb3RoZXIgeWFt
bCwgc28gSSBqdXN0IGFkZGVkIHRoZQ0KPiAiZGVwcmVjYXRlZCINCj4gdGFnIGxpa2UgdGhpcywg
cmlnaHQ/DQo+IA0KPiAgLSBpdGVtczoNCj4gICAgICAgICAgIC0gZW51bToNCj4gICAgICAgICAg
ICAgICAtIG1lZGlhdGVrLG10MjcwMS1tbXN5cw0KPiAgICAgICAgICAgICAgIC0gbWVkaWF0ZWss
bXQyNzEyLW1tc3lzDQo+ICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDY3NjUtbW1zeXMNCj4g
ICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10Njc3OS1tbXN5cw0KPiAgICAgICAgICAgICAgIC0g
bWVkaWF0ZWssbXQ2Nzk3LW1tc3lzDQo+ICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxNjct
bW1zeXMNCj4gICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE3My1tbXN5cw0KPiAgICAgICAg
ICAgICAgIC0gbWVkaWF0ZWssbXQ4MTgzLW1tc3lzDQo+ICAgICAgICAgICAgICAgLSBtZWRpYXRl
ayxtdDgxODYtbW1zeXMNCj4gICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1tbXN5cw0K
PiAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LW1tc3lzDQo+ICAgICAgICAgICAgICAg
ICAgIGRlcHJlY2F0ZWQ6IHRydWUNCj4gICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODM2NS1t
bXN5cw0KPiAgICAgICAgICAgLSBjb25zdDogc3lzY29uDQoNCk5vLCB0aGlzIGNhbiBub3QgcGFz
cyB0aGUgRFRfU0NIRU1BIGNoZWNraW5nLi4uDQoNCg0KSSBoYXZlIHRvIG1vdmUgaXQgb3V0IGxp
a2UgdGhpcywgYnV0IEknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIGNvcnJlY3Q/DQoNCi0gaXRlbXM6
DQogICAgICAgICAgLSBlbnVtOg0KICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10MjcwMS1tbXN5
cw0KICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10MjcxMi1tbXN5cw0KICAgICAgICAgICAgICAt
IG1lZGlhdGVrLG10Njc2NS1tbXN5cw0KICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10Njc3OS1t
bXN5cw0KICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10Njc5Ny1tbXN5cw0KICAgICAgICAgICAg
ICAtIG1lZGlhdGVrLG10ODE2Ny1tbXN5cw0KICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE3
My1tbXN5cw0KICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4My1tbXN5cw0KICAgICAgICAg
ICAgICAtIG1lZGlhdGVrLG10ODE4Ni1tbXN5cw0KICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10
ODE5Mi1tbXN5cw0KICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODM2NS1tbXN5cw0KICAgICAg
ICAgIC0gY29uc3Q6IHN5c2Nvbg0KICAgICAgLSBkZXNjcmlwdGlvbjogRm9yIG10ODE5NSwgdmRv
c3lzMCBhbmQgdmRvc3lzMSBhcmUgMiBkaXNwbGF5IEhXDQpwaXBlbGluZXMgYmluZGluZywNCiAg
ICAgICAgICAgICAgICAgICAgIHNvIG1lZGlhdGVrLG10ODE5NS1tbXN5cyBzaG91bGQgYmUgZGVw
cmVjYXRlZC4NCiAgICAgICAgZGVwcmVjYXRlZDogdHJ1ZQ0KICAgICAgICBpdGVtczoNCiAgICAg
ICAgICAtIGVudW06DQogICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LW1tc3lzDQogICAg
ICAgICAgLSBjb25zdDogc3lzY29uDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiANCj4g
UmVnYXJkLA0KPiBKYXNvbi1KSC5MaW4NCj4gDQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IEtyenlz
enRvZg0KPiA+IA0K
