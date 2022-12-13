Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9764B805
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiLMPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiLMPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:06:17 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73C8B862;
        Tue, 13 Dec 2022 07:06:11 -0800 (PST)
X-UUID: 2afe77f1c6ee4bb0b2a3c98a50d92fa1-20221213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kB8l0zcu+bnrpjUP6Y0RqXkohLtU8PXNSaqvvHExpgk=;
        b=CexUZ/wkr1z6C5bN1CjqDny6/G0UdZvM/y2uv7LWX/DMzSnSkFyZut7YykC2lGGZNoyWNqy5f0PpubOoJVBLgL9bIp5PXQvX6z857xyG9jc6InDSIPAnSeu7OoTK6LfUPQonevnDNnsKDx0JgxsYokdpsUajWiiUNTNQ3nM+PJk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:cec054c3-7cb4-4084-b8a7-cda92ba3e4ea,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:b53e2b25-4387-4253-a41d-4f6f2296b154,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2afe77f1c6ee4bb0b2a3c98a50d92fa1-20221213
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 759183469; Tue, 13 Dec 2022 23:06:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 13 Dec 2022 23:06:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 13 Dec 2022 23:06:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGMfQ1VF6huKEox5+cFTdRtTxiRKcM34zxqmMVmhA24cAWoMfWY7MwgLVx+l0fwraWy01Yrqo6gMDSMNO98HndVnCFlGkzTkyr+jxSN4GDnmJmi9BBXGfTinTe6jX/8YZPXzEmObsVkOLpZb4Gc83RbjCGpYtGkWLNZPOJBuCTijde83Hqhr0/WI7H8K3VXRuPnNkL45pEoq7CW7S7udLIQjBNK3cd5uN5xcrKiGkCPfYTa9D9yJign3mB0n8LDDF7t9jEE31bfToZu21gPjuG6j7vbJuLgUXCNf++C8ezxsa8NkWyjIi7ywdVOyur+O3Ioa2oUcPewBeKr+2PSdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB8l0zcu+bnrpjUP6Y0RqXkohLtU8PXNSaqvvHExpgk=;
 b=GPk4od/IQczhOaFGlfN77cRl39qXTx7hc3SyYOZhfc0ZOcQ6vJ1OiRB0JNTOIWHosQOm2YXJs/ZCp1cFPYPUYF0LaEsGcZ2xZtqPxPcsWXmva9GUmZlVmcWw6YDftYalFggm4h3x1FIj37gEn1YIVFGmD6mVUw3IBT0Lsa8yOdK+xFvFg41WyPTlVRsA+9p3vfvXKm4KnG3WmEJ0N+g/7OgfeHXyQSWUKR/bxZtwdX/Ds03yh7lYl126OOmJuLngotbOqpcVtbhHK5VNuyarlJU47FY+KNXP0HhznVraoBbjws9lEXFNltLGGrj4feRyXDd61KMEH5prbPazRcf90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB8l0zcu+bnrpjUP6Y0RqXkohLtU8PXNSaqvvHExpgk=;
 b=hpE9UjfNqm0y5Pmib4vZcAOAgBj7FjJysnieQkTJNj1jRYlXgS5NPmBK4d2CsR+MuVWixkMpqtAX6Otp3voiweAylZgtBZMJUzVStOsmOQkXNfVYmMuIoQpXog296Pnx7wH3R2BWnNNpsV3mAKZA7mPPVZXrwXcDpf0430KluW8=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by PSAPR03MB5749.apcprd03.prod.outlook.com (2603:1096:301:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 15:06:04 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 15:06:04 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Topic: [PATCH v3 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Index: AQHZCrW9BCZh9S7ETU2R3v1AiYWaeq5lWPGAgAALRgCAAEMtAIAD6koAgABjwQCAAf37gA==
Date:   Tue, 13 Dec 2022 15:06:03 +0000
Message-ID: <6eae5d7eef22443b6152c6655c89bdfd70e59089.camel@mediatek.com>
References: <20221208033148.21866-1-trevor.wu@mediatek.com>
         <20221208033148.21866-11-trevor.wu@mediatek.com>
         <d7d9f3c7-b3e3-1e13-a80f-c7bf7b38a5b1@linaro.org>
         <45b4b287dfd57b99e0ba5675bf99194f6d84d9da.camel@mediatek.com>
         <fb34e446-2904-a357-e54b-3e82a2b0745c@linaro.org>
         <e08fab2a694313abc12e0f8303de3e2e704b388c.camel@mediatek.com>
         <e20884d2-5d30-9519-d070-8e2ac07f2171@linaro.org>
In-Reply-To: <e20884d2-5d30-9519-d070-8e2ac07f2171@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|PSAPR03MB5749:EE_
x-ms-office365-filtering-correlation-id: fa82931f-82cc-4c52-6779-08dadd1b8dda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XHDRchvVSmHIts7B0WPZ3eTc+qAMmwIpDa78NvMZW5M00GH11pjNjOk94tLOEAYGOWbltqSeJlxKZQ7d3DSe5V6A5OJMCgW4xdM2p29FxgIDssdCCYxvCmk2XkWLZ8a7DYTh1efmtXBlLdPQqG0rlfGnXJJEaCXp2EjU3UqVjC8IPS1RgfV2JWLcR5BvHGVnGiSkAvTY4r4dSxOL+a7GCpARAD8JQoLmWzq0AZX3bKNNR1vOTFloqxNoYhiv9THtfyGZHZ2Ix7ZilNPRdcAeJM3mFuyL7eOwcAyC+PqXWRkBwShZaXC0jLm2vmbWRyz4iGOP2QHaJ3H5ohPvejsVyeEdWa39y/RjbRDxLcW97OZXH8+kuf8EfW8asmYFNPTnUDDfYz+yBQ/XuXRWmMc/1f21aIVKL6WhqRMvWZISGNg7hlpEjeusElap3FqY/wFW/LN91tY92e4nQDsYzQfx05+Mt/R2898je5kidJe9J4JT8XnZ8OwiBr6VG/A4VUiG0YvJ0QjRCpPR2u0sxzNqihXV5nz0OCQYXK8ld4SQmTPxJ/yK9nikqKlEZKEkyTnN3v19qneHRXe33c4jDq50SVWrjMmpOSAqB/nYQFtdXLA4tVVfNuOXaQu0nkgjbyW353lD8vrsPo6on5yeblNCRFS+g5zTYzqMaLr2SC8HAtJCfDwkYRbJTDAZKI+5Rdzwq6I0YNnIkUfj4i3b4JL5WsruLPYrt/xl8MEgkPor/zU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199015)(86362001)(36756003)(85182001)(4001150100001)(2906002)(53546011)(110136005)(83380400001)(4326008)(64756008)(54906003)(66946007)(316002)(8676002)(66556008)(76116006)(66476007)(66446008)(7416002)(38070700005)(26005)(38100700002)(6512007)(186003)(5660300002)(2616005)(6506007)(8936002)(41300700001)(122000001)(6486002)(71200400001)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXpLdWRBazVveDFRU0ZQTytqZndwd3FOWkNJbTJCc3d1cmlnbExUTjhuOFV5?=
 =?utf-8?B?OGlUZkRCVjdmRHgwbG1IRHFvYldzZmhkRmQ5TVVoSC8zbVJBY01qaC9ySEk2?=
 =?utf-8?B?aWt0SERESzNncTcraGZ4bjhIQUd6SE13cW90TCs0ZmZ5bXR4aXV3ejdCZ2xk?=
 =?utf-8?B?em5vbjZiSEFZZGo0K1h6VjQ4UGttRDJFeitFWTZGNFhaWXU1MDJselo1eE1G?=
 =?utf-8?B?UUM3R3h2WThUVzVSTi9XdFNDdXFDN1FSZkJSZVV6Y1cvTk94eTZkSFExTS9S?=
 =?utf-8?B?WVArTU1uRUdTdjJWT0dPNFNOeE90NkdNTmJLd3l4dEVjazNOeGZ3TnZGRzhl?=
 =?utf-8?B?SUNlZlNrQ21abEJZTGtYeXJzSFJqQTJnaFpMaFlRLzBaTGg0OVBqQTlFd1lE?=
 =?utf-8?B?S29abmxkK0lNYlVJZnNYWnVFVTdXQ3EyOGZkSDljb21kdGFUUUY2aVBtaEFQ?=
 =?utf-8?B?d1h3eUZKYUw0d2NHTFpUMEpEZjViYlMwN2RMWkozdFlCN0RiNDVFS0lja2Jk?=
 =?utf-8?B?SjJLdzhqbWpMMmNXUUxHd2xzMmc1U1lDa2wrbklJNDdwVlFkcHFzc3BBSUJV?=
 =?utf-8?B?K3p4Q0cxRXF2Y0owRTB0dUtYK2k0Q2FxWWdCVUhQaExRSEVwdnZUVnE5a0xq?=
 =?utf-8?B?c1c1bXNCOWF6RE9TQjNHQjhzclNaRU8yb2cwUE16WGhKcWpMaWJjaS9oRXBE?=
 =?utf-8?B?ZHNIcGtOMm1Zc0xuUWF2QURNcTlld0dFamFxQlNmRUE5emNoZjZkU2lTU3BY?=
 =?utf-8?B?MzhYb1R3QWlQVThMOFlFb0Rob3dPWmFjWEkzZU5iSkNpaFI1YnBHTWg4d2RO?=
 =?utf-8?B?ZXFWTk5yWGlrWnpNQTV6UUtDOHpuaGdOK2pPY0ZZMURoa0VIN040RnNYem1Y?=
 =?utf-8?B?YTczVUJtamljRjZjL1kvQUdXZ0RsMDRpZVYraVFDaWg0Y3NiYjFySjBmSGpM?=
 =?utf-8?B?V2dLNlBZUVNNcEd6ckVTY294THEyUWZjeS9lajdkNHRXcmN0bUMwbDZvUUN1?=
 =?utf-8?B?cDNYRDlIN3FvcHJ0cXJMcUo1dDI2SHVzc2hBcXh4YjF3azZZQTJwVStubDNS?=
 =?utf-8?B?MUtzN2JGZmp6K1NESFRXMDdsb2dheUxNcE9YUWI3cU1SaU9zM1o3S1RVSGZo?=
 =?utf-8?B?dEtBc211dTJNZEpZQTBhVC9Dcy9JL016Z1pRQXM3d1JRWmxYUDJPSzlJK29i?=
 =?utf-8?B?V21TWjZDL3FOZTRHZlVGVXlPLzJUTnlkK2NKV21sNXZhdnc0RGN6RHpuVmhI?=
 =?utf-8?B?M3pXVXpwK0RnRmRXSTJNWnZEem9GRzNNaXFLVGtEdU5aVGZzbGM4NGtwcUNw?=
 =?utf-8?B?UW9HU0V6WGVJQnY5eVBiQzdPNitjc1lsSGN6TEhjUmtreW83T2UwN2RxV0Zn?=
 =?utf-8?B?ZG5VOWxpNWIvaXZ3ZFp0ZHhid012WDdQZ3hBbS90WXIyTmczUmhHM1pJV281?=
 =?utf-8?B?UG1qMkE0cjI0cWFEWmRPZEZHZnZXemxMTHlSSXAySitxYTJzVHJGelBXUjcr?=
 =?utf-8?B?NGx3OThRYW5wQnJRZkQxRnAyNU5oWWRWbldzNWlLa0l1UnJSc2hhSnA5OGln?=
 =?utf-8?B?RGwzLzRRd0pCaHMyVzYwQm0xRzlaRE5zNk05bDkzTTdaWFdTL2NieXNzaU1z?=
 =?utf-8?B?TTlWbjAzT2R4bXZHYUxWOEgxZ1dvYmw4eDdLaTJjRldXNjk3cWVXRkRjd25V?=
 =?utf-8?B?Rmkxa0hXYk81RDVyWncxYkNVVFp3Tk9HZFh6UHErdHJzNTNRSmd6NTBHRStP?=
 =?utf-8?B?eGtweVBzZ3ZlZ2d4SVIveUlnVmhJeXZ0UktMSG1SblV2Tzd2S2xLVm5Pa1ZF?=
 =?utf-8?B?bEZrQWRHNlowK3JtVHJuSTd4dU9wOUlnbHBFN2RvQ0gxRHVxNVZSYmtNM0Jw?=
 =?utf-8?B?cTZ2Ty9kdkptaTJwYlJhY1ZoUk0xczFyVFBYNFBwbTZmZHZDK0FQNWptTHVZ?=
 =?utf-8?B?eVNYUDNZbzV4Q2hKM1JnT1ExbUtlZk9DeFNPRnkzd3k2QUZKMlNoZGpMdHZz?=
 =?utf-8?B?QWpkRzROOVZFMytGUFc3V09MSUlERDZNQVoxVG1Kbi9FWm5ETlh6RmpQVVg3?=
 =?utf-8?B?UlBWUnVYVjQ4cTNUV0lZNmdIU3prR0xXTHgyWHJ2YnpGTWdnY1J0bjB3b250?=
 =?utf-8?B?eUZQanh5VmpFOUVNVVZ1TmYvMHEweUxYUklNdmYwTnd3by9WZWFkVWRjTTh5?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05A69163156F11459B78A8C2FB67A210@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa82931f-82cc-4c52-6779-08dadd1b8dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 15:06:03.9790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCiS84MyLeRwiElJBnhwIC2qCbSWRR2mvD1/F3qQdDsKPA450Mvmqz2Gi5coLjFPVHsI2ka6NGb9mU8LT6nKlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5749
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEyLTEyIGF0IDA5OjQwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMi8xMi8yMDIyIDAzOjQzLCBUcmV2b3IgV3UgKOWQs+aWh+iJrykgd3JvdGU6
DQo+ID4gPiA+IA0KPiA+ID4gPiA+ID4gKyAgICB1bmlxdWVJdGVtczogdHJ1ZQ0KPiA+ID4gPiA+
ID4gKyAgICBpdGVtczoNCj4gPiA+ID4gPiA+ICsgICAgICBtaW5pbXVtOiAwDQo+ID4gPiA+ID4g
PiArICAgICAgbWF4aW11bTogMTUNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsgICJebWVk
aWF0ZWssZXRkbS1pblsxLTJdLW1jbGstYWx3YXlzLW9uLXJhdGUtaHokIjoNCj4gPiA+ID4gPiA+
ICsgICAgZGVzY3JpcHRpb246IFNwZWNpZnkgZXRkbSBpbiBtY2xrIG91dHB1dCByYXRlIGZvcg0K
PiA+ID4gPiA+ID4gYWx3YXlzDQo+ID4gPiA+ID4gPiBvbg0KPiA+ID4gPiA+ID4gY2FzZS4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBIb3cgaXMgaXQgZGlmZmVyZW50IHRoYW4gYXNzaWduZWQtY2xv
Y2stcmF0ZXM/DQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGluY2x1ZGVzIGNs
b2NrIGVuYWJsaW5nIGF0IGluaXQgc3RhZ2UuDQo+ID4gPiANCj4gPiA+IGFzc2lnbmVkLWNsb2Nr
LXJhdGVzIGFyZSBhbHNvIGF0IGluaXQgc3RhZ2UuIEkgYXNrZWQgd2hhdCBpcw0KPiA+ID4gZGlm
ZmVyZW50Lg0KPiA+ID4gDQo+ID4gDQo+ID4gSWYgdGhlIHByb3BlcnR5IGlzIHVzZWQsIHRoZXJl
IGFyZSB0aHJlZSBwYXJ0cyBpbmNsdWRlZCBpbiBkYWkNCj4gPiBkcml2ZXINCj4gPiBwcm9iZSBm
dW5jdGlvbi4NCj4gPiANCj4gPiAxLiBzZXQgY2xvY2sgcGFyZW50ICh3aGljaCBBUExMKQ0KPiA+
IDIuIHNldCBjbG9jayByYXRlIChNQ0xLIHJhdGUpDQo+ID4gMy4gZW5hYmxlIGNsb2NrIChNQ0xL
IE9uKQ0KPiA+IA0KPiA+IFRoZSBmaXJzdCB0d28gcGFydHMgY2FuIGJlIGRvbmUgYnkgZXhpc3Rp
bmcgZHRzIGNsb2NrIHByb3BlcnRpZXMsDQo+ID4gYnV0DQo+ID4gdGhlIGxhc3Qgb25lIGNhbid0
Lg0KPiA+IFdoZW4gTUNMSyBzaG91bGQgYmUgZW5hYmxlZCBhdCBib290IHRpbWUgYW5kIGtlcHQg
b24sIHRoaXMgcHJvcGVydHkNCj4gPiBpcyB1c2VkLiBUaGF0J3Mgd2h5IEkgc2F5IHRoZSBwcm9w
ZXJ0eSBpcyBkZXNpZ25lZCBmb3IgYWx3YXlzLW9uDQo+ID4gY2FzZS4NCj4gDQo+IEhlaCwgc28g
dGhlICJhbHdheXMgb24gY2FzZSIgbWVhbnMgdGhpcyBwcm9wZXJ0eSBlbmFibGVzIGNsb2NrPyBI
b3cNCj4gaXMNCj4gdGhpcyBldmVuIERUIHByb3BlcnR5PyBUaGF0J3Mgbm90IGhvdyBjbG9ja3Mg
c2hvdWxkIGJlIGtlcHQgZW5hYmxlZC4NCj4gWW91DQo+IG5lZWQgcHJvcGVyIGNsb2NrIHByb3Zp
ZGVyIGFuZCBjb25zdW1lci4NCj4gDQo+IA0KDQpIaSBLcnp5c3p0b2YsDQoNClNvcnJ5LCBJIGRv
bid0IGtub3cgaXQgaXMgbm90IGFwcHJvcHJpYXRlIHRvIG5vdGlmeSBkcml2ZXIgdGhhdCB0aGUN
CmNsb2NrIHNob3VsZCBiZSBrZXRwIGVuYWJsZWQgYWZ0ZXIgYm9vdC4NCg0KVGhlIG9yaWdpbmFs
IGlkZWEgaXMgdGhhdCBlbmFibGluZyB0aGlzIGNsb2NrIGluIHRoZSBtYWNoaW5lIGRyaXZlciwN
CmJ1dCBhIHByb3BlcnR5IHRvIGluZm9ybSBtYWNoaW5lIGRyaXZlciBpcyBhbHNvIHJlcXVpcmVk
IHdoZW4gdGhlDQptYWNoaW5lIGRyaXZlciBpcyBzaGFyZWQgYnkgZGlmZmVyZW50IGNvZGVjIGNv
bWJpbmF0aW9uLiBBbmQgaXQncw0KZWFzaWVyIHRvIGhhbmRsZSBzZXRfcmF0ZSBhbmQgc2V0X3Bh
cmVudCBpbiBldGRtIGRhaSBkcml2ZXIsIHNvIEkgcHV0DQp0aGUgcHJvcGVydHkgaGVyZS4NCg0K
RG8geW91IG1lYW4gaWYgdGhlIGNsb2NrIGNvbnN1bWVyKGF1ZGlvIGNvZGVjIG9yIGV4dGVybmFs
IERTUCkgcmVxdXJpZXMNCnRoZSBjbG9jaywgdGhlIGNvbnN1bWVyIHNob3VsZCBlbmFibGUgdGhl
IGNsb2NrIGJ5IGl0c2VsZj8NCg0KVGhhbmtzLA0KVHJldm9yDQo=
