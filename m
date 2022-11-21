Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4B631972
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKUFSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKUFSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:18:07 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FF8DF2B;
        Sun, 20 Nov 2022 21:18:05 -0800 (PST)
X-UUID: 908a7b99af754b4083cbdc324f89f807-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Mc48Hynd/ws2zh6uHfv5FOf8hE9ji7Rv8HAmmTAxz1A=;
        b=lb7aBWUFB5kVOFY5u+JmxmYcmUa6hi5anEx7enRsDQ/Z+2ZQAdHTgO8TlaNsrc36O+0tnGlfa01R6Ynj/eWM4R7yCH5dW2Y9KdGXkb0eIPSMgWQYj7NerPyKxvj5zNehCxFga9kdshv0MHShPdghoIk5qjW51WdMys+/4kJQ0y8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:e8cc72d3-23d0-4fd7-b1cd-3205c1f979e2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:78a0c0db-6ad4-42ff-91f3-18e0272db660,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 908a7b99af754b4083cbdc324f89f807-20221121
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1563286320; Mon, 21 Nov 2022 13:17:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 21 Nov 2022 13:17:57 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 13:17:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAGuQ1Jzlj2qAZNwCDWaBLU61TgN0CnIqyPScAdzzgpzA6JoHtZRfz0reDZ8iRwdSrIAdfuA3MUHn0tyTuWdfvmIWm1umOMCI97IYqLoWFjBy7taEZqZGShP5latbVJpTE8LMdKEXPp1TS0mbljp4xxKBLJV3JyStaGd86kKhwwtB3AdS62MEfseGhpui0bCbM1Z57ORn9UWF8gONjcopBM+u3elJ6niaGElwLRbLDQ8eGZnsjsV1CMMrqxIXlc5uw5zSKdwbZmvzn3MPI73rdG5VmWfdG+Juaf5OMFGhGrXdlxLTIE3ZQoYW5JvZfWUfUDEf+PcSKyvvJc20i7ayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc48Hynd/ws2zh6uHfv5FOf8hE9ji7Rv8HAmmTAxz1A=;
 b=a81g/SxKfPLFBJ4FZoCg8Q5x0fn6gU94A2wLTCFyYyUDod6P2839U1JyNHoBvj3hzZL8wBEUGbc1elXs0UsZgETtCH7YdrplcHdWUA1LSAE9Sa98ND0hIyPYfen4+yZtUghwD/hO3PwDUpE4HtK2Jo1AQFhzXlkqReI04R7D30hwb07gJmDseRuqm0nys8hx4z2vkA3lwdD+7qhlI5gSeMcWmcn60LtXytdbZpbkHBS7rLRu5thoFv/Tdf/e/UhjSpfFrfMsTQaUAJXeab/lfsXAl+sFothxT9UAupZ/iZ1XcyGPFJRt+0KdSp4NgrZmGTP/VRcpPE9V0dnFiEsWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc48Hynd/ws2zh6uHfv5FOf8hE9ji7Rv8HAmmTAxz1A=;
 b=P9sRIyLjwi2vOQqofUd+DrVB4a2vxP+EN36yjWzlVMbTBD1dZW1MXRgpod8XeBO7N5Vym7HLridQXTL4hByDusQ3PvX60U4PwtDWUgEstv4oT0cvkZOeXqSvF3ozjjymSFFzQUeQkG1DN9CR6J7Xuv6SjsQGrmy47OvXViyXTqg=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEYPR03MB6603.apcprd03.prod.outlook.com (2603:1096:101:85::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Mon, 21 Nov 2022 05:17:54 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::be04:b90a:e582:9b0b]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::be04:b90a:e582:9b0b%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 05:17:54 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v4 2/4] iommu/mediatek: Adjust mtk_iommu_config flow
Thread-Topic: [PATCH v4 2/4] iommu/mediatek: Adjust mtk_iommu_config flow
Thread-Index: AQHY4r0QorQZNZOmwEeM6et2DUpC+K5JC70A
Date:   Mon, 21 Nov 2022 05:17:54 +0000
Message-ID: <2ea0120c31d4230701aa031daf57317720f78cf0.camel@mediatek.com>
References: <20221018064239.13391-1-chengci.xu@mediatek.com>
         <20221018064239.13391-3-chengci.xu@mediatek.com>
In-Reply-To: <20221018064239.13391-3-chengci.xu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEYPR03MB6603:EE_
x-ms-office365-filtering-correlation-id: 0126bf2c-b561-4c05-96b1-08dacb7fbeb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WXG0HGLQJ0v1DQKzWNovPNjErAUiTVcygApAlPM3JY6xLkVPTG1SVtr/EWwmqOZSDfh6NbH2WFV8tpxd28Kk7bKo/dFN7VJETTatotQ9maLanBCqrp6qwHBpGEWJlQ0IfaiDfIt81mfUpajlZLyH598nrlbSX96k8z1hDLn9k0hGajIyiPPf49QRBJyTqvmXzRlrdrR19BWVAdRL67wdegXjfKpnBxkF1Gf9bAyqOJRw7a+eIbyRGhB50tn0SmASS2POzzsagrrvEQe7DRGMkSqf3q5vK1lGt0lhUOFE1NqoI0oHBMVNxXXYn4zrlMHbNKiYv5qeps09Ea7+h2XFnxmb6UgxTCpdvd5JVUWzFuumQX8bTqyGn+qCAiSaxaQzPnowy2L2gQI80WMF8eHrnFjKnYyxuhR136ZB32oEG/vM1t+VE1gqd0RmQm2trybRJXg72wxb7hrE5zIS0uNSOobcl8dKKY3fyO2vsLUwNdhoTBWYK5CyXmDFtPSawlJ1jBJpTfC8Kjlpik4nLxC35BYryXZfkrcaYqvGER6k/Cy0fMkA4nFI9VTv2q0MjUD+oLC7IIn55TY0mosN5Sx9Ftabwie7+9RhiTni2ixAC6iT9+R1pFGWkGDq6Oz5+3mVeaxddJc8SLMDG6eARwIcRftxItCMgBImZKucfO22NG50+88Mqvvwfr8aepUwBCMnPdSmBA/TEPROM1CjpCg5fh97hJ8fbvaLEzTGC7xM6g4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(6862004)(6512007)(8936002)(2616005)(85182001)(26005)(186003)(7416002)(5660300002)(38100700002)(36756003)(316002)(478600001)(86362001)(6486002)(6506007)(71200400001)(6636002)(38070700005)(54906003)(37006003)(122000001)(41300700001)(64756008)(66446008)(4326008)(66556008)(76116006)(66476007)(66946007)(8676002)(83380400001)(4001150100001)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0RheEVqOWsrT3g1Nkhiak5tbWRqOE9OdnJIRzFRYVJYY3FyTEx0UG1OSTVw?=
 =?utf-8?B?dkJFM01hZTlKckdsWGxmVkNjeitNdDBqeHgrV255dk9mN3VBL2oycWFEeG5p?=
 =?utf-8?B?cUplRFo0QjdxT3FHKzV5US9USjZoN0VDMFJ3MndGWlVXWFNsZjZRdWpjelZo?=
 =?utf-8?B?ZHZ2MXdoc2I2dzUwVjdIS0hvSWVNVnp6R0llTDhCRVJMaTZ2NTNEYkZ1VTZ4?=
 =?utf-8?B?NFhVWVQ5RHlFOThTYzdmeHUxMmJCMFhwUm9JU01HWkp1TFVDZE1aazBqbVNn?=
 =?utf-8?B?N0ZTK09sdStSNUhjS2NOR0treGNHRjlLSUFheGF1MUh3alRvdG9SWERLK2tL?=
 =?utf-8?B?OEJWVDlhazc0MzJEUGxLN1VMQlpXUFlLOGMxWjlQaUpoaXBkeEhoY1BqMi9v?=
 =?utf-8?B?cWZ3cUpNYlZOcVVNVVpzaEZucmpIcTVtVHBXWEpRZEpCUHdMRGVrYzdLMXE2?=
 =?utf-8?B?amd2Ri9wVXRNMys2eDRvUHZ4NG9vR2xkWU5VeW9wMVE4TS85UDZPNmpKbUVu?=
 =?utf-8?B?K2NwZXFKaGV5TFNRQXUvWTdha2Z0R1dPQ09BZW9iYmhsYW9ldGFkeHVRMUYv?=
 =?utf-8?B?L0tFWHVDc3FFVEVpd1M5RkpZQS9xbHJDR2Exem12SmpiS1RqMnh0RmhXbXI2?=
 =?utf-8?B?YWRYOEpvWDltLzZHc2twWURyMFVzWnIxTTM1TVF3c1lkZDl4UnkvZTlKY0Zi?=
 =?utf-8?B?RE5vUXI2VWpURlJyUUVsNFN3T3BEVHlWNjNYVXU0MFVsUU9VRFVYVXZKM1lz?=
 =?utf-8?B?b3QreVVBQUxBMklmSDFjVFJ3S01YRmNKL2crQW5meTVsdEptUG51Z3FvWUhi?=
 =?utf-8?B?THVJTDM4UjhCZXBqeEVSVHNqY2NiVFZwaDFaRDB6bERRd3VQTDRZWEc1RXM4?=
 =?utf-8?B?c0I5N2JIWG9oSXRSdFZIaXBMcTVXNGprclZhOXA3ZS95YUpqWlBiYTJvWGNj?=
 =?utf-8?B?RlpIaFd5RFZxdmFCWVp6T1BxbXNIWGxGYXhPQ2tiWnY5b0UrU2huRHpvQjN2?=
 =?utf-8?B?OVcxYU1seDc2SFU0Q09sQW10MkpHcWZOQzExdlp2c1RWZFhyNjg2aGorckZX?=
 =?utf-8?B?MkdzWE1LMXprYWNEV1J3RDNyNzRXR3lmeG5kVDFiNTRHdWxzYlN2OTUxSERw?=
 =?utf-8?B?bkdVRFpkWnJwTEIrY1JLVHVjQzU0NUwvS3NGTGkrdEZlbmJwdjA5M2hjc0dx?=
 =?utf-8?B?dzM4dTBOa3Vpa3ZMbFZ2SEtVdUdERW0wN05DS2FrbmNXdmR3RDJaOGlLa2Qw?=
 =?utf-8?B?bWdKZ2hjeEkwMDJ5OG04VmQ5THVoVlVqcTlNTVVsUFFHM1dzT2c2czk0Y2Fh?=
 =?utf-8?B?R3hybEE4ZzVzNllnYWh5OWk0d2JkOVBaMWhUTVRnaW0wTFI5NUQvaDlndDND?=
 =?utf-8?B?QTN1b003bE5tUEd6Ujk1SHhoUnNTRExwdW5yYi81MmROU2VuQWxxQno0dldY?=
 =?utf-8?B?MjV5S2dwdjhJVUlISkp5WlpWMC9oYzJqYkQ5U2YrYUlXYUJnU1BkZFp5dTk0?=
 =?utf-8?B?RkgzUGQrdndLYVJhdmpNOXRwYUJ4V2dEc0dpd3NiOWRCMlIvaUNMN09nVi9G?=
 =?utf-8?B?SnlHajZudi91T1A0ZkZkdVR6SDk4TTlscUkyeGM4Ni9yY2ZIUlY4UzR2VTFw?=
 =?utf-8?B?QWpuTnh3cjVuSDRXV01FSUNkUEc0WTVrNWpFNmlGaTJxaVJ2alI4Y0NLVGh2?=
 =?utf-8?B?S1duNjF5NjI4dUxJUks0a1FDSWFrQWVLL0h1Z2kraTlhcm51RWhxeHNIUkVt?=
 =?utf-8?B?VkpCSnNTTWhWWnZuUXNYOW1ZZjRkOGp4RjZ1N1IwT3h1MHlQNTB5eEpIS3Zt?=
 =?utf-8?B?dFN0Zjc4RnRYTzY1czJIR2NtQlg1TSs4NE1GaGk3cmVEVDlpK21XL0ZTRjZQ?=
 =?utf-8?B?cENha3MvUHBiWDJtTEhKTGhBbDJRb2s1b1I5UUdiNTZib0FQVTBYSDRuNG9F?=
 =?utf-8?B?U2ZlZUlBL3FtTXZsbjhmN1ppVWJpdlhUMGZyUVVxamkyc25yclg1QlA1VHY3?=
 =?utf-8?B?dHl2V2htRzJjRnJZeGswNDdjdDdlSFRHOGtpUCtZUDJRVGwwbDJlOTd3dlZY?=
 =?utf-8?B?M2UrZnJYemphZ2xEY2p1TG5rV1ZNQm5lN0tGNktqNTgrR052a0dRRDVDeFNh?=
 =?utf-8?B?ZVdTZDUxQUZiQ280eWR6SXVyUWRManAzTnBUQUI2bE9NYlcvcjhoazJmV1NG?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8664C8EC211F8E46B725569BF2A09593@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0126bf2c-b561-4c05-96b1-08dacb7fbeb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 05:17:54.6840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ITMuSUFtOsAErhBPS6IFAPQgY4rC53rIVV2tRpopF4ZEO26BKKKrUTJACW2WsIswqwI5pTkcUwtbSl/8B3htgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6603
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

T24gVHVlLCAyMDIyLTEwLTE4IGF0IDE0OjQyICswODAwLCBDaGVuZ2NpLlh1IHdyb3RlOg0KPiBG
b3IgcmVkdWNlIGluZGVudGlvbiB3aXRob3V0IGZ1bmN0aW9uYWwgY2hhbmdlLCBwcmVwYXJlIGZv
ciBNVDgxODguDQo+IElmIHRoZXJlIGFyZSBtYW55IHBvcnQgaW4gYSBzYW1lIGxhcmIsIGN1cnJl
bnQgZmxvdyB3aWxsIHVwZGF0ZQ0KPiBsYXJiX21tdS0+bW11IG9yIHVwZGF0ZSBJTkZSQSByZWdp
c3RlciBmb3IgdG9vIG1hbnkgdGltZXMuDQo+IFNvIHdlIHNhdmUgYWxsIHBvcnQgdG8gcG9ydGlk
X21zayBpbiB0aGUgZnJvbnQgb2YgbXRrX2lvbW11X2NvbmZpZygpLA0KPiBhbmQgdGhlbiB1cGRh
dGUgb25seSBvbmNlIGZvciBJT01NVSBjb25maWd1cmUuIEJ5IHRoaXMgbW9kaWZpY2F0aW9uLA0K
PiB3ZSBjYW4gcHJldmVudCBNVDgxODggZnJvbSBzZW5kaW5nIHRvIG1hbnkgU01DIGNhbGxzLCBh
dm9pZGluZyBlbnRlcg0KPiBBVEYgZm9yIGVhY2ggcG9ydC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IENoZW5nY2kuWHUgPGNoZW5nY2kueHVAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMgfCA2MCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tDQo+IC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gaW5kZXggNWE0ZTAwZTRiYmJjLi5mYmFmNDAxZjM0
ZTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gKysrIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBAQCAtNTM0LDQxICs1MzQsNDkgQEAgc3RhdGljIGlu
dCBtdGtfaW9tbXVfY29uZmlnKHN0cnVjdA0KPiBtdGtfaW9tbXVfZGF0YSAqZGF0YSwgc3RydWN0
IGRldmljZSAqZGV2LA0KPiAgCXVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgbGFyYmlkLCBw
b3J0aWQ7DQo+ICAJc3RydWN0IGlvbW11X2Z3c3BlYyAqZndzcGVjID0gZGV2X2lvbW11X2Z3c3Bl
Y19nZXQoZGV2KTsNCj4gIAljb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2lvdmFfcmVnaW9uICpyZWdp
b247DQo+IC0JdTMyIHBlcmlfbW11ZW4sIHBlcmlfbW11ZW5fbXNrOw0KPiArCXVuc2lnbmVkIGxv
bmcgcG9ydGlkX21za19leHQ7DQo+ICsJdTMyIHBvcnRpZF9tc2sgPSAwOw0KPiAgCWludCBpLCBy
ZXQgPSAwOw0KPiAgDQo+ICAJZm9yIChpID0gMDsgaSA8IGZ3c3BlYy0+bnVtX2lkczsgKytpKSB7
DQo+IC0JCWxhcmJpZCA9IE1US19NNFVfVE9fTEFSQihmd3NwZWMtPmlkc1tpXSk7DQo+ICAJCXBv
cnRpZCA9IE1US19NNFVfVE9fUE9SVChmd3NwZWMtPmlkc1tpXSk7DQo+ICsJCXBvcnRpZF9tc2sg
fD0gQklUKHBvcnRpZCk7DQo+ICsJfQ0KPiAgDQo+IC0JCWlmIChNVEtfSU9NTVVfSVNfVFlQRShk
YXRhLT5wbGF0X2RhdGEsDQo+IE1US19JT01NVV9UWVBFX01NKSkgew0KPiAtCQkJbGFyYl9tbXUg
PSAmZGF0YS0+bGFyYl9pbXVbbGFyYmlkXTsNCj4gKwlpZiAoTVRLX0lPTU1VX0lTX1RZUEUoZGF0
YS0+cGxhdF9kYXRhLCBNVEtfSU9NTVVfVFlQRV9NTSkpIHsNCj4gKwkJLyogQWxsIHBvcnRzIHNo
b3VsZCBiZSBpbiB0aGUgc2FtZSBsYXJiLiBqdXN0IHVzZSAwDQo+IGhlcmUgKi8NCj4gKwkJbGFy
YmlkID0gTVRLX000VV9UT19MQVJCKGZ3c3BlYy0+aWRzWzBdKTsNCj4gKwkJbGFyYl9tbXUgPSAm
ZGF0YS0+bGFyYl9pbXVbbGFyYmlkXTsNCj4gKwkJcmVnaW9uID0gZGF0YS0+cGxhdF9kYXRhLT5p
b3ZhX3JlZ2lvbiArIHJlZ2lvbmlkOw0KPiAgDQo+IC0JCQlyZWdpb24gPSBkYXRhLT5wbGF0X2Rh
dGEtPmlvdmFfcmVnaW9uICsNCj4gcmVnaW9uaWQ7DQo+ICsJCXBvcnRpZF9tc2tfZXh0ID0gcG9y
dGlkX21zazsNCj4gKwkJZm9yX2VhY2hfc2V0X2JpdChwb3J0aWQsICZwb3J0aWRfbXNrX2V4dCwg
MzIpDQoNCldoeSBkbyB3ZSBuZWVkIGRlZmluZSBhIG5ldyBwb3J0aWRfbXNrX2V4dD8gQ2FuJ3Qg
d2UgdXNlIHBvcnRpZF9tc2sNCmRpcmVjdGx5Pw0KDQo+ICAJCQlsYXJiX21tdS0+YmFua1twb3J0
aWRdID0gdXBwZXJfMzJfYml0cyhyZWdpb24tDQo+ID5pb3ZhX2Jhc2UpOw0KPiAgDQo+IC0JCQlk
ZXZfZGJnKGRldiwgIiVzIGlvbW11IGZvciBsYXJiKCVzKSBwb3J0ICVkDQo+IHJlZ2lvbiAlZCBy
Z24tYmFuayAlZC5cbiIsDQo+IC0JCQkJZW5hYmxlID8gImVuYWJsZSIgOiAiZGlzYWJsZSIsDQo+
IGRldl9uYW1lKGxhcmJfbW11LT5kZXYpLA0KPiAtCQkJCXBvcnRpZCwgcmVnaW9uaWQsIGxhcmJf
bW11LQ0KPiA+YmFua1twb3J0aWRdKTsNCj4gLQ0KPiAtCQkJaWYgKGVuYWJsZSkNCj4gLQkJCQls
YXJiX21tdS0+bW11IHw9DQo+IE1US19TTUlfTU1VX0VOKHBvcnRpZCk7DQo+IC0JCQllbHNlDQo+
IC0JCQkJbGFyYl9tbXUtPm1tdSAmPQ0KPiB+TVRLX1NNSV9NTVVfRU4ocG9ydGlkKTsNCj4gLQkJ
fSBlbHNlIGlmIChNVEtfSU9NTVVfSVNfVFlQRShkYXRhLT5wbGF0X2RhdGEsDQo+IE1US19JT01N
VV9UWVBFX0lORlJBKSkgew0KPiAtCQkJcGVyaV9tbXVlbl9tc2sgPSBCSVQocG9ydGlkKTsNCj4g
LQkJCS8qIFBDSSBkZXYgaGFzIG9ubHkgb25lIG91dHB1dCBpZCwgZW5hYmxlIHRoZQ0KPiBuZXh0
IHdyaXRpbmcgYml0IGZvciBQQ0llICovDQo+IC0JCQlpZiAoZGV2X2lzX3BjaShkZXYpKQ0KPiAt
CQkJCXBlcmlfbW11ZW5fbXNrIHw9IEJJVChwb3J0aWQgKyAxKTsNCj4gLQ0KPiAtCQkJcGVyaV9t
bXVlbiA9IGVuYWJsZSA/IHBlcmlfbW11ZW5fbXNrIDogMDsNCj4gLQkJCXJldCA9IHJlZ21hcF91
cGRhdGVfYml0cyhkYXRhLT5wZXJpY2ZnLA0KPiBQRVJJQ0ZHX0lPTU1VXzEsDQo+IC0JCQkJCQkg
cGVyaV9tbXVlbl9tc2ssDQo+IHBlcmlfbW11ZW4pOw0KPiAtCQkJaWYgKHJldCkNCj4gLQkJCQlk
ZXZfZXJyKGRldiwgIiVzIGlvbW11KCVzKSBpbmZyYW1hc3Rlcg0KPiAweCV4IGZhaWwoJWQpLlxu
IiwNCj4gLQkJCQkJZW5hYmxlID8gImVuYWJsZSIgOiAiZGlzYWJsZSIsDQo+IC0JCQkJCWRldl9u
YW1lKGRhdGEtPmRldiksDQo+IHBlcmlfbW11ZW5fbXNrLCByZXQpOw0KPiArCQlkZXZfZGJnKGRl
diwgIiVzIGlvbW11IGZvciBsYXJiKCVzKSBwb3J0IDB4JXggcmVnaW9uICVkDQo+IHJnbi1iYW5r
ICVkLlxuIiwNCj4gKwkJCWVuYWJsZSA/ICJlbmFibGUiIDogImRpc2FibGUiLA0KPiBkZXZfbmFt
ZShsYXJiX21tdS0+ZGV2KSwNCj4gKwkJCXBvcnRpZF9tc2ssIHJlZ2lvbmlkLCB1cHBlcl8zMl9i
aXRzKHJlZ2lvbi0NCj4gPmlvdmFfYmFzZSkpOw0KPiArDQo+ICsJCWlmIChlbmFibGUpDQo+ICsJ
CQlsYXJiX21tdS0+bW11IHw9IHBvcnRpZF9tc2s7DQo+ICsJCWVsc2UNCj4gKwkJCWxhcmJfbW11
LT5tbXUgJj0gfnBvcnRpZF9tc2s7DQo+ICsJfSBlbHNlIGlmIChNVEtfSU9NTVVfSVNfVFlQRShk
YXRhLT5wbGF0X2RhdGEsDQo+IE1US19JT01NVV9UWVBFX0lORlJBKSkgew0KPiArCQkvKiBQQ0kg
ZGV2IGhhcyBvbmx5IG9uZSBvdXRwdXQgaWQsIGVuYWJsZSB0aGUgbmV4dA0KPiB3cml0aW5nIGJp
dCBmb3IgUENJZSAqLw0KPiArCQlpZiAoZGV2X2lzX3BjaShkZXYpKSB7DQo+ICsJCQlpZiAoZndz
cGVjLT5udW1faWRzICE9IDEpIHsNCj4gKwkJCQlkZXZfZXJyKGRldiwgIlBDSSBkZXYgY2FuIG9u
bHkgaGF2ZSBvbmUNCj4gcG9ydC5cbiIpOw0KPiArCQkJCXJldHVybiAtRU5PREVWOw0KPiArCQkJ
fQ0KPiArCQkJcG9ydGlkX21zayB8PSBCSVQocG9ydGlkICsgMSk7DQo+ICAJCX0NCj4gKw0KPiAr
CQlyZXQgPSByZWdtYXBfdXBkYXRlX2JpdHMoZGF0YS0+cGVyaWNmZywNCj4gUEVSSUNGR19JT01N
VV8xLA0KPiArCQkJCQkgcG9ydGlkX21zaywgZW5hYmxlID8NCj4gcG9ydGlkX21zayA6IDApOw0K
PiArCQlpZiAocmV0KQ0KPiArCQkJZGV2X2VycihkZXYsICIlcyBpb21tdSglcykgaW5mcmFtYXN0
ZXIgMHgleA0KPiBmYWlsKCVkKS5cbiIsDQo+ICsJCQkJZW5hYmxlID8gImVuYWJsZSIgOiAiZGlz
YWJsZSIsDQo+ICsJCQkJZGV2X25hbWUoZGF0YS0+ZGV2KSwgcG9ydGlkX21zaywgcmV0KTsNCj4g
IAl9DQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCg==
