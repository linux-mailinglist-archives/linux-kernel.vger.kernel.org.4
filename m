Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B14B64665C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 02:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLHBPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 20:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLHBPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 20:15:42 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A24D7B;
        Wed,  7 Dec 2022 17:15:40 -0800 (PST)
X-UUID: 62d88de4a48d406ca221f0b26c8b0f36-20221208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DZW9q7XDwuo/stFETycouWBNktMrYtpuW9Lfw0cfwzw=;
        b=uh6CWYw8HoEiwhmGDMj86tbqliX/XlHyX99Yw3hM5trsRgZ57lbPlUx3Q+RSzEa+5pys249C9QJkwFbk4xv1N3NuFTyhN/4+uCuotzNnaO2sPZ/Vlg6+GTTlWNs99JsIAW2+B69Mlj7dK7OwDooPV4i+CwQkGTfnn0hfKfHUAj4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:0f9921a9-906a-43e5-80ff-6def6b17b365,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:0f9921a9-906a-43e5-80ff-6def6b17b365,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:f403f5d1-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:22120617044101B54EE4,BulkQuantity:42,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 62d88de4a48d406ca221f0b26c8b0f36-20221208
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 525997365; Thu, 08 Dec 2022 09:15:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 8 Dec 2022 09:15:22 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 8 Dec 2022 09:15:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4Brsw61HMfcXFtLk5yceuyuBIzQZa96H6zGIuafHknSNiibQjqPgqKrhiuHSPyC58WrSJ9xixQ3hQu/uzs2l8jxarIs5E6AY23FPtf5SVlIm4JjGG3of6UIRD6kxcpz7KXWWGmanNgDWw8SzDQC0xuYYORXOZ3TVQBe7koUkmPOexwAo0RMLrRXyW7J8lYnmjhrDVgjWQW12LcLGrhdeRR9wV7BobtbtzsQ3v/Sn7m/cNDwLSOpe+NeiOyyS6/vbkEjqtu1XnygH0sBULHGmTONs6XMvqFWy1jUhiugqORTOhnXjGKQjbwTqn607S4z6lLenzh44NbepoiLj/uNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZW9q7XDwuo/stFETycouWBNktMrYtpuW9Lfw0cfwzw=;
 b=f3Qjl45HkLFG8IJ/QygGANggoEM8wjveRdhkZLvETGilZQmhoBlOD3pljxdKf/CQJbut1ahO0MnX97rggvrzcv1YiIM53iEdTLBisb+32MMejHTpD+6T2sn3+rKpFSNKtgUDOnL72+JVHgGWflyxUIjjXVfExobGPSv0TkuK0TMG39PZuvB/6UDJZnhK7IGSy+YtElOQ51GwvybZfiq/Y0S+CgQBgTK45k8uzz8x8vjlcfPGHcB/f6wUm1JXKloFcCT8jb2j5WARhFgaT3ZyVB2kZjXFfM+W5QEQufUFMinf4WDfCzNxMjX5gLsB/QqG/qW/ayVjLTWmkM2DdP2Lvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZW9q7XDwuo/stFETycouWBNktMrYtpuW9Lfw0cfwzw=;
 b=ML6orPZ+EU7VA7IYgpAHOAwV7d44XePJ7KWOM9PDvunNDYuKX5QBArv4huqeBsvo68paazUIWpdwifRaqi0pY6LWbTm1RQm6zfbsjij0i4Bj9FnuDVaRBjto9fLf91f1LcvnCrTn5skwsxp7grPoa7PoyolOqtzMiGtZtg7I1UI=
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com (2603:1096:4:84::10) by
 TYZPR03MB7241.apcprd03.prod.outlook.com (2603:1096:400:289::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 01:15:19 +0000
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7]) by SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7%6]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 01:15:19 +0000
From:   =?utf-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <Benliang.Zhao@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>
Subject: Re: [PATCH v2 7/9] dt-bindings: spi: mtk-snfi: Add read latch latency
 property
Thread-Topic: [PATCH v2 7/9] dt-bindings: spi: mtk-snfi: Add read latch
 latency property
Thread-Index: AQHZCHcIWFb1SQ8l7UecaYFwLXxxLa5fWMwAgAE5uQCAADahgIAA5TqAgACC4gCAAQLhAA==
Date:   Thu, 8 Dec 2022 01:15:19 +0000
Message-ID: <97408c484927b6520ec79b23220496d628156e5f.camel@mediatek.com>
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
         <20221205065756.26875-8-xiangsheng.hou@mediatek.com>
         <ce449a0c-efcc-0ac1-fb8e-c2b4148a5bc1@collabora.com>
         <a8f706b37f5decf91bfa9a9ac8cf04be4346dd85.camel@mediatek.com>
         <9992c9a5-059a-9396-32ce-7ed63cd12a96@collabora.com>
         <e2ccf42f94152ccacad3a2eaec234ae0566474ec.camel@mediatek.com>
         <b877af37-462e-c923-41c0-09c370062700@collabora.com>
In-Reply-To: <b877af37-462e-c923-41c0-09c370062700@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4565:EE_|TYZPR03MB7241:EE_
x-ms-office365-filtering-correlation-id: ff47ed76-4b94-444f-4477-08dad8b9ac03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xwxIFTC0ITGOEEt/VdZP3WR+C0FlcVNmx5+kR/iAAGpg1MmX+s3R/boxAvOoaXxo6Tl8ngzZPq7QSxh5ou7YNXu6djf2wI97PEml/aLqhJUp7dti1xgRw4bVzfD25fcfAFjEgNQSr0qdX/wwQBFyBacClT0JZ2n1pvlGQtEwtR08zbT4ONcHMQySe0QAn4iHYD2FvKVPLDs282T5oTVpqx3SCAVMXKVo84nIF9mM7XHji0xdV4HYBVeQJYJaT648rzwwtFP5Hil8NjrxOe07aQVnNwyk9Q4qlu+jFINFtIMFKv3KW3/rTLn0KGFVmwcU0WbddqpX16SSMOkC97imbQ8G9pyhRtIaFHGbET04JFzH7zyAiKlHeuQfvoHTeF+k7GPewEghuEhdNLyoGNzByKkkls7KO6LLjh7uh93F5p91F9MApOyJGv+1XaE44LgVMEefl/vuUeRFIlu1k0RYy6vsK/4m6o+d3AMLen3FdnspspjfotIDWS8p+IeIn4t7RiWZfHR725L9WZxd+0x5+iJDX9Lm7m7I7cdPmoDW5eSHbXz8yScc/ymJEkXoJzz3VFdfYCPkinctk0+pb0us9x+1WrF6eOvnxWFQpJLNs//I59AG3LNC5fDr2+guCNzl50KTjh6uwRxY612VWK+JuNZFpz0NYiqkTQbIUbLrw149Lk2YCbxWHrghsyMT5FdRCBpa7CkBAKebggopZQRhZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4565.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(316002)(107886003)(110136005)(54906003)(36756003)(85182001)(8936002)(5660300002)(66556008)(4326008)(66946007)(66446008)(66476007)(64756008)(41300700001)(7416002)(8676002)(83380400001)(38070700005)(38100700002)(2616005)(122000001)(26005)(6486002)(86362001)(186003)(71200400001)(76116006)(6512007)(6506007)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2U2SndpVEIzSCtKQWwzTkRUVmFhYlh5aGlXVmFUVDRQa2ticmpzckI3RzU5?=
 =?utf-8?B?MzFnQWtPTG9Zd2VrNW5vdFR5enZsSFJwZHpVZExZU3RzYSszUy9sSjNsUFFG?=
 =?utf-8?B?YWpCclA2SExBcXNHa0RvTFNZd2c1dTJlTzZmTkkvbFNOOXYxbTZzMnhpTWg2?=
 =?utf-8?B?aWJ5SWVYeCszbTBuZWIvVEhFeDFjVXJBakUwWmwyWXZmZ3JPWWRtMTZNQ0g0?=
 =?utf-8?B?SzhCQVZ6R1RpSHZFTS9tY2xETDF0YU5LMVE3WGNmQmwrQ0d5b05saEtJSHBi?=
 =?utf-8?B?N1FvWHkxb055dXVudmk5dGk0OE9BZmwrbFUzSkdRVm8rc1p6Qk9nelNwaW5k?=
 =?utf-8?B?bWtXNGhwZWVSNm85QVFhUlF6WG1Cenp0UEd6ZDV5Tm9XMkgrK2Z5S3hIbFUr?=
 =?utf-8?B?RGRHUVhpSmdEY3YzWmZleFpwalM1cHVVajh4aUljS052Y0JLeWNHS0pNbFl0?=
 =?utf-8?B?K0IzeXdqYkJKK2dpNFhLTkxWaFMwcDluWU8vcUdzaFBUYVZBZi9SVUFxQ0wy?=
 =?utf-8?B?M1JOWTFvNnJlRjJFV043YUFrWEtlZVhvQklJYW1rdHhLOHZJRXlDWUhmSDQv?=
 =?utf-8?B?RDk2Wlc4dXh1R2I2eUNpc0t4TThhbk9ONVNjQTkrUUlxZ3pjM3ZKd0lnZlhL?=
 =?utf-8?B?ampWd2NqYm5hWWd3dVNYZmNzN01TblJjM3pLZWx2QXk4bUFQdkZ0dGNUOEc5?=
 =?utf-8?B?ZzZNaGhuWlFtaXlYbWJkNXFqaUgyTTZ0TTkvYkhkTmRSSUExTyt5ckFjaWh1?=
 =?utf-8?B?M1NKdDlDeFFtcVdmRDhMQUZkVlEycGZXdXdGTkNnRzZ0QllyZC94eEFGeUhD?=
 =?utf-8?B?VmxDWTYwQnVsajU4S2VCcXoydmJmZE96blREWEZLYThXcGQyb1NVQUFPUFBu?=
 =?utf-8?B?WjRvYlR5MzBUa1pOQisvcVVYSDVXTDRRdWl4cmNsdi9MZnU5eFZxbVFsV0Qv?=
 =?utf-8?B?dE9yU3ZBN2RXbnlDMWlpODNIOFN2QUFkVHorTGJ4VDNzTVowSEptMXE2VFBS?=
 =?utf-8?B?ZmFXSFJqMWNOZERZaXI1Q2U1Yi9YemVXQzVlSTZkbFJrb3RvSGM0OU1XTlVu?=
 =?utf-8?B?YnVmMy9zL1gzcWZZZExUbS90WGU0bzlqamVLTHlOWjVJRDdOZzNkZ0h2eUQ0?=
 =?utf-8?B?c2d4d0l4N3V2Q0UrRXZEZUp2NWZWYUY3NEdTTlFLdWZZdGxybDlBNkxKY3Y0?=
 =?utf-8?B?U0RTOUdpL0RKUVVkbTlReVhVYm5vZXFQa3pRdGp4bnNYM3VsYVQ4SWp6a0tw?=
 =?utf-8?B?eUo2bkdxZnlDSW9XWmlOeklVNlRTRVB0ZG5QRVBqZytNajZmcE5qV0luZkNF?=
 =?utf-8?B?SGd2Z3BRdklwODZMb25Nbnp0aHlLUkFJTnBTS3ErNW5kVjZ3STl1V3A1cmt3?=
 =?utf-8?B?NENMK2Q4OVhDaHA3cG9oT2RnZWZGTmpXSmxJbFVDS0d1ZXhicm1TZ01SMzll?=
 =?utf-8?B?ems2K0RSeXNRdlFkUXJodGlta0hEcmdzZHkxNUNadmxFWXVNSlJIR3FJdzNh?=
 =?utf-8?B?UXVET2hVcU95WnR0cmVQRnRjKzBJYzBFOFZOZ1JBUzNDdk9nY3NzcTJoaEF2?=
 =?utf-8?B?M3Z3Q3Z6WnVaMzJrUjdnektMU0pqdExVd1RHMXNOU1FiVUVUNmQxU2lIMkZp?=
 =?utf-8?B?WmdOaUpmV3EyOTVQTFlrQ3Eza05scVJCOForM040NE92S2dpa1hOdE5PMWww?=
 =?utf-8?B?M05WT2JtVFkwUHM3RWlCMzdLOXErRDIxRlBma0I3a0kvWE1YYjFtTy82N29R?=
 =?utf-8?B?ZnRTUXh4SUNUMFc2TGw2aWdDUE1jWFNyVmlPbGpNTFJxOVNtV1MvWXhONnF1?=
 =?utf-8?B?cnBHVVMvWmhxSkRSR2s3bkpQcHFlSHBTeEZpMFlTanF3VEV2d1NrTXlRclhW?=
 =?utf-8?B?cUw2Y1JlZlVLdVdvaXBZNWEzWlVXNGZCbXFMSmpyR3ZSdmMxMkpGOStxcm1J?=
 =?utf-8?B?MzZuQmpYTm5ha3RoYnR4QjFMdHdCQVhZTFVOS09henQ2QTgzKzE0Vy9HaFpS?=
 =?utf-8?B?aHVlSzNSQkQ3QzgwOHBTRHFRTXNOYmhIR1l0RUNKZzYzN202K1VmaTJJa0Uz?=
 =?utf-8?B?NVVtQ2phS20wL1JNNHNBanVXQjdrR24rbksxcitJYVozUThjbkZOZXlzREdU?=
 =?utf-8?B?ZVAzdFdSZExzODRiWXRIZlFLaHhBNlBzVGNnUE5CdHlXSklYd0dIc0dveHQ2?=
 =?utf-8?Q?+9r0JcFuOnCinU+/s+h4ER8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF1A0D24A335154B82023672249CFEDB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4565.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff47ed76-4b94-444f-4477-08dad8b9ac03
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 01:15:19.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMcDZLQ/R/uFhW76ydt2WL6AXihmtPrE+QXrcH3VV8rk8wTjt32SeFmB/knv5ge+U5p8U9tMC0Ii3br0uH0bvh1pcq9hhCJvoARzhUEV90Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTEyLTA3IGF0IDEwOjQ4ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDcvMTIvMjIgMDM6MDAsIFhpYW5nc2hlbmcgSG91ICjkvq/npaXo
g5wpIGhhIHNjcml0dG86DQo+ID4gSGkgQW5nZWxvLA0KPiA+IA0KPiA+IE9uIFR1ZSwgMjAyMi0x
Mi0wNiBhdCAxMzoxOSArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiB3cm90
ZToNCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9tZWRpYXRlayxzcGktDQo+ID4gPiA+ID4gPiBtdGstc25m
aS55YW1sDQo+ID4gPiA+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
cGkvbWVkaWF0ZWssc3BpLQ0KPiA+ID4gPiA+ID4gbXRrLXNuZmkueWFtbA0KPiA+ID4gPiA+ID4g
aW5kZXggYmFiMjNmMWIxMWZkLi42ZTZmZjhkNzNmY2QgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL21lZGlhdGVrLHNwaS0NCj4g
PiA+ID4gPiA+IG10ay0NCj4gPiA+ID4gPiA+IHNuZmkueWFtbA0KPiA+ID4gPiA+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9tZWRpYXRlayxzcGktDQo+ID4g
PiA+ID4gPiBtdGstDQo+ID4gPiA+ID4gPiBzbmZpLnlhbWwNCj4gPiA+ID4gPiA+IEBAIC00NSw2
ICs0NSwxMyBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiA+ID4gICAgICAgICBkZXNjcmlwdGlvbjog
ZGV2aWNlLXRyZWUgbm9kZSBvZiB0aGUgYWNjb21wYW55aW5nDQo+ID4gPiA+ID4gPiBFQ0MNCj4g
PiA+ID4gPiA+IGVuZ2luZS4NCj4gPiA+ID4gPiA+ICAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+ID4gPiA+ID4gICAgIA0KPiA+ID4gPiA+
ID4gKyAgbWVkaWF0ZWsscngtbGF0Y2gtbGF0ZW5jeToNCj4gPiA+ID4gPiA+ICsgICAgZGVzY3Jp
cHRpb246IFJ4IGRlbGF5IHRvIHNhbXBsZSBkYXRhIHdpdGggdGhpcyB2YWx1ZSwNCj4gPiA+ID4g
PiA+IHRoZQ0KPiA+ID4gPiA+ID4gdmFsdWUNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAg
IHVuaXQgaXMgY2xvY2sgY3ljbGUuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ2FuJ3Qgd2UgdXNl
IG5hbm9zZWNvbmRzIG9yIG1pY3Jvc2Vjb25kcyBhcyBhIHVuaXQgaGVyZSwNCj4gPiA+ID4gPiBp
bnN0ZWFkDQo+ID4gPiA+ID4gb2YNCj4gPiA+ID4gPiBjbG9jayBjeWNsZXM/DQo+ID4gPiA+IA0K
PiA+ID4gPiBUaGUgY2xvY2sgY3ljbGUgd2lsbCBiZSB2YXJpb3VzIHdpdGggTWVkaWFUZWsgU1BJ
IE5BTkQNCj4gPiA+ID4gY29udHJvbGxlcg0KPiA+ID4gPiB3aGljaA0KPiA+ID4gPiBjbG9jayBm
cmVxdWVuY3kgY2FuIHN1cHBvcnQgMjYvNTIvNjgvODEvMTA0TUh6Li4uDQo+ID4gPiA+IEl0YHMg
bWF5IGJlIGVhc3kgdG8gY29uZmlndXJlIGFuZCB1bmRlcnN0YW5kIHdpdGggY2xvY2sgY3ljbGUN
Cj4gPiA+ID4gaW4NCj4gPiA+ID4gdW5pdC4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFllcywg
YnV0IHdoYXRldmVyIGNsb2NrIGZyZXF1ZW5jeSB3ZSB1c2UsIHRoZSB0YXJnZXQgaXMgdG8gYWx3
YXlzDQo+ID4gPiB3YWl0IGZvcg0KPiA+ID4gWCBuYW5vc2Vjb25kcywgcmlnaHQ/DQo+ID4gPiAN
Cj4gPiA+IFdhaXRpbmcgZm9yIDUgY2xvY2sgY3ljbGVzIGF0IDEwNE1IeiBpcyBvYnZpb3VzbHkg
bm90IHRoZSBzYW1lIGFzDQo+ID4gPiB3YWl0aW5nDQo+ID4gPiBmb3IgdGhlIHNhbWUgNSBjbG9j
ayBjeWNsZXMgYXQgMjZNSHo6IGluIHRoYXQgY2FzZSwgZXhwcmVzc2luZw0KPiA+ID4gdGhlDQo+
ID4gPiB2YWx1ZQ0KPiA+ID4gaW4gbmFub3NlY29uZHMgb3IgbWljcm9zZWNvbmRzIHdvdWxkIG1h
a2UgdGhhdCBpbmRlcGVuZGVudCBmcm9tDQo+ID4gPiB0aGUNCj4gPiA+IGNvbnRyb2xsZXIncyBj
bG9jayBmcmVxdWVuY3kgYXMgdGhlIGNhbGN1bGF0aW9uIGZyb20gYHRpbWVgIHRvDQo+ID4gPiBg
Y3ljbGVzYA0KPiA+ID4gd291bGQgYmUgcGVyZm9ybWVkIGluc2lkZSBvZiB0aGUgZHJpdmVyLg0K
PiA+IA0KPiA+IFRoZXJlIGhhdmUgdHdvIHJ4IHJlbGF0ZWQgdGltaW5nIHByb3BlcnRpZXMgaW4g
c3BpLXBlcmlwaGVyYWwtDQo+ID4gcHJvcHMuDQo+ID4gVGhlIHJ4LXNhbXBsZS1kZWxheS1ucyBo
YXZlIGJlZW4gdXNlZCBpbiBNZWRpYXRlayBzbmZpIGRyaXZlciB0bw0KPiA+IGFkanVzdA0KPiA+
IGNvbnRyb2xsZXIgc2FtcGxlIGRlbGF5Lg0KPiA+IEhvd2V2ZXIgYW5vdGhlciBzcGktcngtZGVs
YXktdXMgaXMgaW4gbWljcm9zZWNvbmRzLiBUYWtlIDUyTUh6IGZvcg0KPiA+IGV4YW1wbGUsIHRo
ZSBjbG9jayBjeWNsZSB3aWxsIGJlIDE5LjIzbnMgd2hpY2ggbG93ZXIgdGhhbiAxdXMuIFRoaXMN
Cj4gPiBtYXkNCj4gPiBub3QgZWFzeSB0byBieSBvbmUgY2xvY2sgY3ljbGUuDQo+ID4gDQo+IA0K
PiBJIGFncmVlLCBidXQgbm90aGluZyBwcmV2ZW50cyB5b3UgZnJvbSBhZGRpbmcgeW91ciBvd24g
cHJvcGVydHkgZm9yDQo+IHRoYXQuDQo+IA0KPiBJIHByb3Bvc2UgIm1lZGlhdGVrLHJ4LWxhdGNo
LWxhdGVuY3ktbnMiIG9yICJtZWRpYXRlayxyeC1sYXRlbmN5LW5zIiwgDQo+IHNvIHRoYXQNCj4g
d2UgY2FuIHNwZWNpZnkgdGhlIGRlbGF5IGluIG5hbm9zZWNvbmRzOiBpbiB0aGF0IGNhc2UsIHdo
ZW4gd2UNCj4gc3BlY2lmeSAxOW5zLA0KPiB0aGUgZHJpdmVyIHdpbGwgc2FmZWx5IHJvdW5kIHRo
YXQgcmVzdWx0aW5nIGluIDUyTUh6ID09IDE5LjIzbnMgPT4NCj4gMTlucyB2YWxpZC4NCg0KV2ls
bCBiZSBmaXhlZCBpbiBuZXh0IHNlcmllcy4NCg0KVGhhbmtzDQpYaWFuZ3NoZW5nIEhvdQ0K
