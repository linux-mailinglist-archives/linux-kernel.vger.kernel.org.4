Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDFB5ED9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiI1KPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiI1KOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:14:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B612B10AF;
        Wed, 28 Sep 2022 03:14:49 -0700 (PDT)
X-UUID: 8effed5802944f458f08f027d5f7ba66-20220928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mjoEaNQVQjHMK4pt3jyj81OBHP9Jmol50Eonrr3ejw4=;
        b=g2fo4B0tjucGbLJvsBhjT2dRqMUFOAJtaLQLeR6MweYKbjQ29jRm8jgJwx6hJp8CrkEgDCZeN4Qs4XELBepb1ddJ0e4Xja22mx5Mq1Gj2fUVNy3cpDT246CR1oR0Y/UfHB92s/Sam7YyQkY6Ayke3VZyft2AVxH0e5r8uSx9lRw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:8a4b173b-a8fa-4713-bf19-0fcf892a9aee,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.11,REQID:8a4b173b-a8fa-4713-bf19-0fcf892a9aee,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:66a14f07-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:22092816273792W3AIBY,BulkQuantity:139,Recheck:0,SF:38|17|19|823|824|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,C
        OL:0
X-UUID: 8effed5802944f458f08f027d5f7ba66-20220928
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 884709630; Wed, 28 Sep 2022 18:14:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 28 Sep 2022 18:14:41 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 28 Sep 2022 18:14:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elGoWM/Lcdk+PMfN1NkHwJprcA5c4a67nIE8WiGjNMFO4I0PUNWUgfqKH3iq2fm/iBq2SmapP5VFbGROVKeiWns8+X+PBuHXEJWjrb98WbPitMQFE7ZYdHZWjJHtBJcIZ3/ClVUIOIUS23dOJ3wsqC5c8LB0pUs3qytbM9nRWWKsuZDlfLGQEkAWZtJMjW0svym+3YtLw+IAoKKUUxRSyfPFCTVC0pPJFBiRgGQqePyZNAZKS6LhY1cL8U6CGlVV5o3ZXoezEl0nSCdlA5t5+9tIeDTuA9A7+TXrPZaDY/eQFaIsJMFMkQRjIdfwT4DKZO5ndRALWj/LYd/CiW9oOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjoEaNQVQjHMK4pt3jyj81OBHP9Jmol50Eonrr3ejw4=;
 b=B3KaxaERql/DTYI3z46H+oYrVpCot8rYjR0Oys6WcDe6x7o0IMD5x8zF5Z+/i4YmvDfpprRBO5ftilKqoXXTqcRXTUgEzxeJ7vR9Fo5p6/p4N8R+vFC1TYNMkJhfgxdZpzFBXeBqmkgfLZux/jlZHGOc4zHgni+4aRrLWte/jxNlFN7BJAEpJqvzEfRJIbrhGCCtQBz/zZz/nRCPNR+qNsVflhSCSwMlDSRsJf4U4qNTN7r/uGmuZDejaxWc1MEc2p9h80m8TIJz6MzLHFNGBsf0kxjiC+odA4TPelNx6HtNr62zXamJbzsWD3euwFcJ6Ptx837hzWqIZqs9tRkgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjoEaNQVQjHMK4pt3jyj81OBHP9Jmol50Eonrr3ejw4=;
 b=a2RS5eF2elm+nRyHdVusamjlr9nS2OT94uGrb45Sh6HtG4WD8QcMZWw1CWSRgZuAioHqxk1Um3A8kL1k7yj/2IQzp4PWX4JGx7WCAYFqD3i+2eGXYRbeyUYSMZf3asLC3ZwTr3cWPHDJS2NdscaEX/k7DdcxCusIEq1o1QXts3o=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Wed, 28 Sep
 2022 10:14:39 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::fd9e:be5e:18eb:3382]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::fd9e:be5e:18eb:3382%5]) with mapi id 15.20.5676.015; Wed, 28 Sep 2022
 10:14:39 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 04/11] remoteproc: mediatek: Remove redundant
 rproc_boot
Thread-Topic: [PATCH v3 04/11] remoteproc: mediatek: Remove redundant
 rproc_boot
Thread-Index: AQHY0hz3VPC4ao3ZCE2dhuy+ykKQqK3zHXAAgAFmi4CAABRgAIAACaYA
Date:   Wed, 28 Sep 2022 10:14:39 +0000
Message-ID: <fa964a4f15f4296b12f3dbcda77d508a41648fe5.camel@mediatek.com>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
         <20220927025606.26673-5-tinghan.shen@mediatek.com>
         <da5dcffc-746f-207f-eee7-f47e2550eab0@collabora.com>
         <71748c8dfe0fccee352d04323b40ff998031aeea.camel@mediatek.com>
         <d4f43e5f-367e-db52-96d4-286d7fa9d1c9@oss.nxp.com>
In-Reply-To: <d4f43e5f-367e-db52-96d4-286d7fa9d1c9@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|KL1PR03MB5062:EE_
x-ms-office365-filtering-correlation-id: aa51b6a0-ccb4-43f7-2c5a-08daa13a40ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AcirntfEpqG9cb5EEYokbE34Z+DykqFk1w1AH91jKnLIZK1iei03AY4Kk1NA0JKEDZVbH1dgc4PplSM1NPcSKYB2dFMEupot0ewDx05ycgmSn3fKeTDpDS6HsWrMJ9833Abk3p9OHO45JxMyukJhfxTeHeHVt6BCS6rCDwMEV3m7OriQ1nb5Qa3BwjQlpzY4suVbwU+OTIejEWDw/WSkqvTq1wCeAFUa8ixi3czgrG3ve4EPg80UJ17f6dLUjepQ36YryduoFybxmhgSD/7wtHIUcPD9hQKS5oZg7L43y+AwSC+bfHtwc4lxPbu3a4pDj0OyzSVUshiPhvLdC6v9yPTzkB6AzXPnz7QbKVqGl8y0LUUTLAxz+n8MKDNQRAC1eD5WRslYo+I/RX7gLlTA3WO5xQisIDTgSUFTEVxuYITeEH/ZSllknXXl+dwbkmFT7tNgQrMXx9rZfkXOAT2L9/EUnyf4hJwZET46x8B1Q5TAIzf4TIryU8Pa936A5xx6ImKdCMUAU0PUO03IKQS9223/8HUkFhZKuDjS6ZlvAc1EdlAzPdSAY0/VtfsmtXJOzcsr2yqsXmFr0d3E8lHNh/JJf0gRqxRAi9iM1hioCZ1uak3+x4wmSiAFIS0Vy/X7M/Fycn3SpHxomVu5gRWX4Vumyz9nlALqda/jbK1HtFfvHbYuv8DoQ6c3SlCQkTC+xr3L6ZA9A7g3PV5w+ZnXp7UQ67VUPyNKz5p3xrMHiNJ5nAK4cOhLX6VcQbwjR+cMeCzzMVBzE+PoYe3/CKK/qMkfASVYWu0mDI1p4YuUh7o9UTLyoUIhgCOXfOclrjOnup2/xpFBsEdlg9u8rI9nuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199015)(478600001)(36756003)(53546011)(122000001)(86362001)(5660300002)(38100700002)(38070700005)(8936002)(85182001)(26005)(921005)(316002)(6512007)(4744005)(110136005)(6486002)(7416002)(2906002)(71200400001)(66476007)(66946007)(64756008)(186003)(66446008)(66556008)(41300700001)(91956017)(4326008)(8676002)(6506007)(76116006)(54906003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0V0UUJFZzFZV3RwQzVpVGFDbmJMaC9hUFFEUWREbU54REp6N1hLSGtBcVVU?=
 =?utf-8?B?amVUc0ZVaVFQelJDUzYyL20vWGhURFZDQ0RmYWFjUjNPWEMvRVBHR1hWS3lL?=
 =?utf-8?B?eVcrbG80bG5zNFl2UlR3bnZCYkJuZ3AwQWViQzZISzlaSGR4MDcxUXZ4QzFh?=
 =?utf-8?B?NnlwSW44MjVsZFRwNThkWnZWcXNQTWxRelNlbGtlR01HcytNSk9kSmFzR1cw?=
 =?utf-8?B?a0pmZlVtZE0zRlhHNWN5R3lMblBIOWpNRjBMRitaZ3l3aGJESmI4eEZFQzh0?=
 =?utf-8?B?czIxa1I1ellFbU5Cb2FvK2g4ZzhYUFNRaTVKZE9lTERPSzFrMVFNRkxablFq?=
 =?utf-8?B?cEdDazI2eUh3QmhJK3k5cHp3NWt4MW12cVRTRXJ5cjJKQy9DaWNkT2hJakxx?=
 =?utf-8?B?YlE1Z3QxVHh3aTlXUElsY0Z6TmpyZnphNnFGR01JbWxKcGZkdnMvSW45QXBB?=
 =?utf-8?B?anBCZkdhQm5wMFlSQXF0WTNBYld4TDlTVzJoUCtEenhoRENBNWNBVk1YR3N3?=
 =?utf-8?B?ek9JN1hXZnRBRHBLd0U4R0NVWktReHhZOTZlMkJPbUJ0K1loMFFFbTFjckFu?=
 =?utf-8?B?ZnB1b1A0b0h4VFRkdmVRZ2pxUHBweG9obG1HSFlWVUtSM3Y4VUxKaEFXSlpT?=
 =?utf-8?B?b1FURmIwMld2dkNXTHJhbFk0ZTZOKzNzb1BESnR2aEZIZVJPRloyYkd1c3Ir?=
 =?utf-8?B?NThnQ1k4UDVTSkc0MWxIME5xbXpXNnJwNnBIMENwSG5CVlJxUE5aOEpKVVlx?=
 =?utf-8?B?NHNxQ1hMbFNWNXZzbmpLbHVnNDA2V0lESkhFNFFQZWFrc2hNeDJnUjh4OTVv?=
 =?utf-8?B?TUY2dEZER1pVejIzUkxUc091YTRPazZoL2xDN3Jhb0JlWExMdlA5SUpHMnll?=
 =?utf-8?B?enkwaWVkNnlqZ0xJc0QzdzNPdGx4cWhJdnI1MjIwR0xOYVhlWU1EcEpZdUI2?=
 =?utf-8?B?Q1dWNXpzMURJc3NMOEZ1T2xTQ0hzZjlidzVIM3d1TTU5MEdZV0xpQzNPL2t3?=
 =?utf-8?B?TnlqaVcwaEw0ZjhKSTBGSy9ZRUtadnN2KzRjYnhIekJVSlpDUGxqYTd3aUZ6?=
 =?utf-8?B?RFEwcmEwTnNXMHhIdTZuNmNUeHc3RHBIQUtqSWh5VkoveFVxS2QycS9tVktv?=
 =?utf-8?B?MlBrOFRESlJKcjVILzBVeldFSWpVTTRQV3BjUklhRy90dHU1bDM4WXc1ZS9w?=
 =?utf-8?B?UmtwYm9mSEZLZjVmMGc2VXJaelc3czJKUFFWYUdYT0tjTVV3WmNJUFVMcFdK?=
 =?utf-8?B?ZVZJSlNOeEtDRDkvOUhsVUgxMnhINWdpS1dlaWZlMGVrb0JEbE5mL2tpd05w?=
 =?utf-8?B?VVVIdWQrWEVRbHZuczYvMm81Nkt2eUxGTkNRc0tCa2E1bElmOUdKNk9HQWZm?=
 =?utf-8?B?Z0NFY3Q1YURYTDU2eS82T0lEOHhudGpoT0dNZzRTaVF5NEllRjNyRTIrMGds?=
 =?utf-8?B?Y3VBNWxOdFZTNllhUTJJcmFrcVp5T25RNU5qRDJiUEE4VnpPMU5QTUNmc1hU?=
 =?utf-8?B?V3hQZnUxbHJ6MVBhbHZkdUVtaWtoc244V1d6UFRBY0dJZDhHWGErNWx3ZUJx?=
 =?utf-8?B?dzVNeTV2dUQ3aSttaEdLU01EMm1La0ppbTIwWlhGY2NOMzV6aDVMRHUyV3do?=
 =?utf-8?B?bDFCZHF2RTVIR05pL2x4amM4WUV1dm9HUjNibXdNVldQcE45aFphMWNVN0Fl?=
 =?utf-8?B?d0FtMFMzNzdLb3pNWEVPV0dmaFkxSjZXL2o0TUE4YUlqNFJmaGhlUHladGMy?=
 =?utf-8?B?aURpZWp6TFBCVyt6eGpzRDU5ajRPVXZBbEFBWXpLaWswR0lWdTV1WGN6SC82?=
 =?utf-8?B?c3pwR0txOCttM1dwN2V5ZnZEek5EN1ZsQnhaTFcwakxGdDBQOU1EVmd1YVNR?=
 =?utf-8?B?WllqTndLMmorYXRKZGdTSTBpeHgyYTdvK09hZDBRU1lodUJlemR6T0lJV1RV?=
 =?utf-8?B?TDNPSysySUcvcWdpWmFLYk5nazByUG5Mcno4RVRxTDZ2cVdod2RBaDIwWHZk?=
 =?utf-8?B?NW5UM2NjUDhKS2M5QmUzckFwZ3hnRVBaWXJPdGpSZnVlWUZzNk5IeHpGQ1RJ?=
 =?utf-8?B?RitwalBqV3cybTNHRk9RTFRsNlNlSEFWanlqU3l3UUxwTXJpVTUrMFZCaWdP?=
 =?utf-8?B?S2J5bzBpelQ1L3p1dzdNZmN3Nmx2T3RGdFBmS0ZrR2FuWVpVdGRSZDFIREF3?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <166F31A8F0149C4CA7A91D99EBA1D45A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa51b6a0-ccb4-43f7-2c5a-08daa13a40ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 10:14:39.1012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyvHV7KXalp72WeZOPxr7imm50pS9DoWDCZ/gEXqMpaZXZUZS3EZQWcgw6QYLcyTph3G4VXA1HLbE0mx9+hwx+Fixk+t9lNgy9xEPq9cuoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA5LTI4IGF0IDE3OjQwICswODAwLCBQZW5nIEZhbiB3cm90ZToNCj4gDQo+
IE9uIDkvMjgvMjAyMiA0OjI3IFBNLCBUaW5nSGFuIFNoZW4gKOayiOW7t+e/sCkgd3JvdGU6DQo+
ID4gT24gVHVlLCAyMDIyLTA5LTI3IGF0IDEzOjAzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERl
bCBSZWdubyB3cm90ZToNCj4gPiA+IElsIDI3LzA5LzIyIDA0OjU1LCBUaW5naGFuIFNoZW4gaGEg
c2NyaXR0bzoNCj4gPiA+ID4gVGhlIHZpZGVvIGNvZGVjIGRvZXNuJ3QgbmVlZCB0byBleHBsaWNp
dGx5IGJvb3QgU0NQIGluIGl0cyBmbG93DQo+ID4gPiA+IGJlY2F1c2UgdGhlIFNDUCByZW1vdGUg
cHJvY2Vzc29yIGVuYWJsZXMgYXV0byBib290Lg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIHJlZHVu
ZGFudCB1c2FnZSBvZiBycHJvY19ib290IGluY3JlYXNlcyB0aGUgbnVtYmVyIG9mIHJwcm9jLnBv
d2VyDQo+ID4gPiA+IG92ZXIgMSBhbmQgcHJldmVudHMgc3VjY2Vzc2Z1bGx5IHNodXR0aW5nIGRv
d24gU0NQIGJ5IHJwcm9jX3NodXRkb3duLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogVGluZ2hhbiBTaGVuIDx0aW5naGFuLnNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gDQo+ID4g
PiBZb3Ugc2hvdWxkIENjIHN0YWJsZSBvbiB0aGlzIGNvbW1pdCwgYXMgaXQncyBhIHF1aXRlIGlt
cG9ydGFudCBmaXguDQo+ID4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBBbmdlbG8NCj4gPiA+
IA0KPiA+IA0KPiA+IEhpIEFuZ2VsbywNCj4gPiANCj4gPiBPaywgSSdsbCBhZGQgaXQgYXQgbmV4
dCB2ZXJzaW9uLg0KPiANCj4gSWYgdGhpcyBwYXRjaCBpcyBub3QgcmVsZXZhbnQgd2l0aCB0aGUg
U0NQIDEgc3VwcG9ydCBpbiB0aGlzIHBhdGNoc2V0LCANCj4gYmV0dGVyIHNlcGFyYXRlIHRoaXMg
cGF0Y2ggb3V0IGFzIGEgc3RhbmRhbG9uZSBmaXguDQoNCk9rLCBJJ2xsIHNlbmQgaXQgc2VwYXJh
dGVseS4NCg0KUmVnYXJkcywNClRpbmdIYW4NCg0KPiANCj4gUmVnYXJkcywNCj4gUGVuZy4NCj4g
DQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFRpbmdIYW4NCg0K
