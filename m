Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544476B9071
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCNKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCNKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:45:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047DC7281;
        Tue, 14 Mar 2023 03:45:06 -0700 (PDT)
X-UUID: f3b24684c25011eda06fc9ecc4dadd91-20230314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+zKWgH2K8LYpqiLdghK3Ozjf8OroUDY4hBiqGps4njI=;
        b=EfRdfMSx/4j+B6WAhZrsB7ZDBKt47eshUC+IDsvuOsk0jvYsxcQU08FaCX9A2WxDVWMJjxOai5XgG2FeVFFlsS1+RLkV7BgxuU0i1ePclBvA6FOtfnADrfh4ER/RYW4c7ZSyFfCNsNICvMc8wX/LbOPdTLw6GL3Lg6Kr/XFirbI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:ee9adbd6-d705-486b-bc7d-fed02a4664a7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:83295aa,CLOUDID:639a34b3-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: f3b24684c25011eda06fc9ecc4dadd91-20230314
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1798086004; Tue, 14 Mar 2023 18:14:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 14 Mar 2023 18:14:04 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 14 Mar 2023 18:14:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S973l+Gt47sf3k3a+v6AqiH4EPmrF4wW/t+cjZcuKgPhe5rqWejVFV8EclM+lUAIcJvidM+UsEa5FEX+tRn+rzbP+siqgvVAx3HR8m9WoKCXnkBN5dW0UvWmUeg1c5sHFiTeGt2RNLXLc8dZ5Xg1kUCB8trLF19ZSZ2u7TD3gL5xeYdYcg4PPQ1TYrpSPdAtHjSWHEFdnhPi89dctvuxhNIgrylO3uNsj6Jt4NU3yzFGtqnBKjpRThO2FhaXW74yxFyftITfjXz6yFRTwCM4JWdo2ALojwEELNiTKu2J/18bXTMoW9IZiiWOT+CGOcyOyTj7cIrwPmUhLwPqtbX+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zKWgH2K8LYpqiLdghK3Ozjf8OroUDY4hBiqGps4njI=;
 b=L525abJcXSGLhsEty3pwzyZEttCdSG2xkPPiawJKURhZ8TrmJck32iLIfFpXPU7KjkzQUf59QaJegv1ZIlRe8RsXQxXebWEIxujEa5O5vc/4Ds2FLtcfPyXgQ8MCBdif8iqRBpYrE2C8mS30vFnMkvMA/4pVrJUeMzw23jk4ox2VJE+ZgTbEMHCMKNhfs/YtbA37nA3c1moPz2dSoXwsYpyPk2BJ4HGEq8mBrLnqFpcfrNj3SAzwf4Z0vihAnrOBKA76XJFTitgLXploD5plXi9urBmPZNFcJGPoxNgXLB4jFT4IfFv8FJrFMPr7WAVIlmQrlNe/ykKb7ebxieID0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zKWgH2K8LYpqiLdghK3Ozjf8OroUDY4hBiqGps4njI=;
 b=ErDPaVp8FQOzRcqkvrE5cW3Hf2ugLbkcAGox363zm3MRs8GtK/3FUp8ZaFkZg4kTznKCt1o8ga8ZlKDhnM5Z0QPedXg/+UKL6QgDEH2NQK8IKc4VPSWCA9aKsf34+MrgS+iz6kRFdQJoAmiHIpPXr6Wab1Rg02usZ6ND0UsZPUE=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB7203.apcprd03.prod.outlook.com (2603:1096:400:339::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Tue, 14 Mar 2023 10:14:02 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1%3]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:14:02 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v8 1/7] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Thread-Topic: [PATCH v8 1/7] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Thread-Index: AQHZUMu55xpLrGlpK0q5UZyv49KYAa7wscOAgAjpuACAAEQ8gIAAOgYA
Date:   Tue, 14 Mar 2023 10:14:01 +0000
Message-ID: <43989ca5ffa67be0a21874dbdbdf38872f16378e.camel@mediatek.com>
References: <20230307080555.14399-1-yong.wu@mediatek.com>
         <20230307080555.14399-2-yong.wu@mediatek.com>
         <388e2274-d46a-68a4-3e85-5bd597085041@linaro.org>
         <aba29e7fd9a461f2d94c83cf2c7496521433847d.camel@mediatek.com>
         <4ac7e2e0-9b19-c911-7297-3510e55d6cfd@linaro.org>
In-Reply-To: <4ac7e2e0-9b19-c911-7297-3510e55d6cfd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB7203:EE_
x-ms-office365-filtering-correlation-id: 10309334-461d-476a-c5e0-08db2474d5b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SE1FRJJyICg/HqPcz/GxNOvU8ADk/r87AUN/Wzo/Cn8WVcxhpQvO9k5wgcvbJnthJ3MNIVfjWnkmHkK1NCEYfYM6A/Doc7UL+2hQ+bXv7qQ1jokiRkfj/QwXu0+qEKM7f79fr2npROG6KWJ3Iuo2aW9yTKeFkcLfHYgpVMh+zn+I6l67snz3A0MSjx3MIfmebMB7qzyNb6QpH/eTFNhTaktTITwkj9ukp/1JTLPwWK+MEVrw2gND6MDafoDmoL4lxLx0wyH0qIV7g012J95Mk/sSNt9hXAWTH0goJknMmkYiSkRklGG51Mh/ApvH77jimPSi8VPfzzrzp0Gq8k99iAlgewaDEZf0zQP9FQcyQDih86ePq0TFtwGpa1kYGOj0CMbv3TnaSrPTHL5jxlTGMugdy+x80HummaM1NIeQJYbnWXx867FltTTGuslDpdSBps1o00LuPKqGF+5ZuTB2QEvhIoJye5ftXf4SeZcnenbyaZQKzOAZDrDFbwzXIp2JZfiDXK63C/bDT7iNXvIjVy4NBEGbGOArH5A/hd3kvpo2E8FGvFfbmP+meZ/9mODGOMPAwLRWgsBXZf5pqcn1NY/N2C3WLqZISiZZadMy6qK5tX90vn0oglQGeBzsM+JKsY9C+9asfQOxejsIs3pGNTnRwAoNwsXIwTOBo002iG6FbqjmuIPY0jLV/vdWj6HRlvIwXFXkYTqF8o7Srjrq862oNE41g2pD/hM1pJIG3ssUpGzQs0q8YvSLmHDNIBPGdnE0gC6T/DogJQI9r+SJjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(85182001)(83380400001)(5660300002)(38100700002)(478600001)(316002)(122000001)(54906003)(186003)(8936002)(71200400001)(86362001)(66556008)(6506007)(36756003)(26005)(4326008)(8676002)(76116006)(7416002)(66446008)(66476007)(53546011)(66946007)(6512007)(64756008)(41300700001)(38070700005)(2616005)(6916009)(6486002)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVIzdFVCYVE4ZWpBUzZMWWZ4VjA3aFZPak1LZnI2VFIwcUNVeFNxU25EUkgx?=
 =?utf-8?B?ZGVpaFlEdzJXbEdseTZWMy9VdEdXOHhOK1VnOU9wa0ZMSWpFbTBqTWcxQ05k?=
 =?utf-8?B?dVlXSEZUZnRmb3ZNQjJzeTVwTEJOMDU3Z25KSWhFcUxZSjFKSnBwMFNaQTJ6?=
 =?utf-8?B?MzVmMEFBaHk0KzFaZHd5WjlnVjdKNDh6aXpTaXpJM0htTzhiRGkvRzJkWjhK?=
 =?utf-8?B?VTgxKy9kWHJqdVJRS0F4Rm5KSXJxTklpZ21Db3hnc2x2WU5rQkFLUGpUZVk1?=
 =?utf-8?B?Yk13cUVNMHhqaVpKalczNmVZSnAxYlZaU2pVT0tyVzFnM2wveVNSeEtSdHZV?=
 =?utf-8?B?SkNyZmhZV25EdnhjTmd1L0RMZ1ZHMUh6YVczS3krMzlmeXJhQy85Tm84MmRI?=
 =?utf-8?B?TEJGY3FXcGNJU3BvUUgxYTRKSEVKcUhkVTZjaGpieWQzbGZWdHh3MjdacGdQ?=
 =?utf-8?B?S3RKRElCMkpGTnk5aWRaTzVxN0MzQ3k1TzczMkRkZmdKVnJqR0Z6R2pWUFBs?=
 =?utf-8?B?Y1A2Qm9ZenFYZGhJcEduN2x5M2hoc04xWHY4NEtmOTlnUisxT1gyQnpzTlZT?=
 =?utf-8?B?a2E4dVRvSjhvNm03ZFhJRlkrYmdubkJMZkg5VW1CRTFhMmUwN05BbFQwRENJ?=
 =?utf-8?B?Z0xZcnRMK0hDTXZaVXlvd25rZ3hNbVlsczhQS201QTJVb1dpUlhRYXVJallP?=
 =?utf-8?B?aGpHYUd6NlJZcjkreUxjbGVFaWNEZEF1YzlxNFpJRmJrTndId0JKYlhHT0NZ?=
 =?utf-8?B?ZWhiS3Fxb0ZtRmk5b1Y3WXUyUlZNNVdPWnlpYk1rekU4ek13aGtnWmxwcENV?=
 =?utf-8?B?QkYrbXY1UmI0dEZZRXJrYUVLdkZnTFlzS1p4VzJaZUhWZmk3eTVDeHhkY0dh?=
 =?utf-8?B?YlFKQklhMXZjaXZvUU1TbWdrSTRVVTZpemRtYzRlQVlWTVVNL1U3NE9NRXhV?=
 =?utf-8?B?dlJTdTBDL3psREFHMHZsKzZ1NkNUOEpzelVGc1ZuMHpaa09kbDFGVmRNZE1r?=
 =?utf-8?B?Tnk3VktxUWZWY1JJUXlZYlJKZ1Z1TUM5LzlGT1dUbXBjVi9vSm9BNUxsRGZp?=
 =?utf-8?B?NmFGVjZuZS9mVmdnSlF6dk1DNi9IU0FuWlErQW95NnVUS2IyL3pnWC9ncmFa?=
 =?utf-8?B?UVhqU1FQMUV1dXpNTUM4U0VSa1c4Y0tjdW5xRUw0MThueW1Cbzc1akhRTjBK?=
 =?utf-8?B?ZFJvbVN1ODVEeUpRekN5d3NtaVIwQXFUZ3JWcWhvOWVWR0JlZzhKcG02K3JZ?=
 =?utf-8?B?bERNeHhaV3o5Y2tNZWlPSExmWko0V0YyNjI2N0pLNUg1bzYzTjFZeWZmTUFk?=
 =?utf-8?B?SEg1cUUrdGEvcEtWMElTdm44MEo5TEYyU2N2dEVyc2JUdElUbGU5QU93ZTlM?=
 =?utf-8?B?d05aLzQrVHRnS2U2eHA3YTREb0tLMTJ6SFBoelpwbzlDZFBwdVNGZlYwQjhZ?=
 =?utf-8?B?NHBCZXc1bnRtQnBvS2J5dSs5L3FMcXVIZ0x3dW0vbHkvQk1BUkR6eEpycVAv?=
 =?utf-8?B?WFAwanhXdmphSW9NMFBFZ3graUY3Q09YRGhjeEJvWFFpbmhzeDdBQjlHUFBt?=
 =?utf-8?B?L0g3aEpIWWZ3cVI0N0VmYmhZeGJpZjNWTUswaVByQzE0MlluUjhEUVZOL3ht?=
 =?utf-8?B?Skt1dmI0cGl3TG9Ed0VhQlVqR3lXMGx4VktzL0xPTkxERXZOenYwd0xXeUQz?=
 =?utf-8?B?TGcwb2tFc2VLOXMrekdERGp0bVpSUG4wZG1OWS9maU05R0g2YTdIcGt5WWhw?=
 =?utf-8?B?SisvM2ZYUjI0dGNZVXlqTSsxc0NNKzVxTTJpcWxlbDIxUUY2dEFvOGRIZ1ky?=
 =?utf-8?B?SEsveG5WUkFBOW85eFJtMGs5SS83ZSt0aUF2QVhKNm9IZW8wR01YSzBUSVI0?=
 =?utf-8?B?ZTJxTTBCcUdmNFA4TkNMYTRQZjlaYi8rQ2UxYnc5TkNMZU15NHRUeUM1bkg1?=
 =?utf-8?B?UlNwYXRKeHg4V3M1TXd6dExnTzlzYjRjdGdKRHJDWTgxTTArQWZsSVBiclZV?=
 =?utf-8?B?ZlRROHJtSy9VdG1GQ1VYOGNlQWkxRWNKNm13WDNSVEQ0Zk5iRXV0TlhoWUx6?=
 =?utf-8?B?UXhBTXlETzNSb2szZFZ0RzlxNHpXcEx3VGdvRzM0b3R1b0Z3ZmN4Y3RKTGRJ?=
 =?utf-8?B?NVg5T01TeDJLZ2hxN3kybW00NWJpbFJuQTIySVlOeWt6VWVYYkxkN2ladUZR?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F892C6565FC0C34D9CE0D4D41DE513BE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10309334-461d-476a-c5e0-08db2474d5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 10:14:02.2723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ey5R9N5XqnropleogyLhHXJvS4URWM0Am9NI401t1zG50OJ3HmV+xTj9OIfT5sXGCjp9D5UrUOHkQaa3LfyiMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7203
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAzLTE0IGF0IDA3OjQ2ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNC8wMy8yMDIzIDAzOjQxLCBZb25nIFd1ICjlkLTli4cpIHdyb3RlOg0KPiA+
IEhpIEtyenlzenRvZiwNCj4gPiANCj4gPiBUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGhlbHAg
cmV2aWV3Lg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyMy0wMy0wOCBhdCAxMTozNSArMDEwMCwgS3J6
eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+IE9uIDA3LzAzLzIwMjMgMDk6MDUsIFlvbmcg
V3Ugd3JvdGU6DQo+ID4gPiA+IEZyb206ICJDaGVuZ2NpLlh1IiA8Y2hlbmdjaS54dUBtZWRpYXRl
ay5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBBZGQgZGVzY3JpcHRpb25zIGZvciBtdDgxODggSU9N
TVUgd2hpY2ggYWxzbyB1c2UgQVJNIFNob3J0LQ0KPiA+ID4gPiBEZXNjcmlwdG9yDQo+ID4gPiA+
IHRyYW5zbGF0aW9uIHRhYmxlIGZvcm1hdC4NCj4gPiA+ID4gDQo+ID4gPiA+IEluIG10ODE4OCwg
dGhlcmUgYXJlIHR3byBzbWktY29tbW9uIEhXIGFuZCBJT01NVSwgb25lIGlzIGZvcg0KPiA+ID4g
PiB2ZG8odmlkZW8NCj4gPiA+ID4gb3V0cHV0KSwgdGhlIG90aGVyIGlzIGZvciB2cHAodmlkZW8g
cHJvY2Vzc2luZyBwaXBlKS4gVGhleQ0KPiA+ID4gPiBjb25uZWN0cw0KPiA+ID4gPiB3aXRoIGRp
ZmZlcmVudCBzbWktbGFyYnMsIHRoZW4gc29tZSBzZXR0aW5nKGxhcmJpZF9yZW1hcCkgaXMNCj4g
PiA+ID4gZGlmZmVyZW50Lg0KPiA+ID4gPiBEaWZmZXJlbnRpYXRlIHRoZW0gd2l0aCB0aGUgY29t
cGF0aWJsZSBzdHJpbmcuDQo+ID4gPiA+IA0KPiA+ID4gPiBTb21ldGhpbmcgbGlrZSB0aGlzOg0K
PiA+ID4gPiANCj4gPiA+ID4gICBJT01NVShWRE8pICAgICAgICAgIElPTU1VKFZQUCkNCj4gPiA+
ID4gICAgICAgfCAgICAgICAgICAgICAgICAgICB8DQo+ID4gPiA+IFNNSV9DT01NT05fVkRPICAg
ICAgU01JX0NPTU1PTl9WUFANCj4gPiA+ID4gDQo+ID4gPiA+IC0tLS0tLS0tLS0tLS0tLSAgICAg
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiAgIHwgICAgIHwgICAgLi4uICAgICAgfCAgICAgfCAg
ICAuLi4NCj4gPiA+ID4gbGFyYjAgbGFyYjIgIC4uLiAgICBsYXJiMSBsYXJiMyAgLi4uDQo+ID4g
PiA+IA0KPiA+ID4gPiBXZSBhbHNvIGhhdmUgYW4gSU9NTVUgdGhhdCBpcyBmb3IgaW5mcmEgbWFz
dGVyIGxpa2UgUENJZS4NCj4gPiA+ID4gQW5kIGluZnJhIG1hc3RlciBkb24ndCBoYXZlIHRoZSBs
YXJiIGFuZCBwb3J0cy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENoZW5nY2ku
WHUgPGNoZW5nY2kueHVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogWW9uZyBX
dSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gPiA+IEFja2VkLWJ5OiBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4gPiANCj4gPiA+IElu
ZGVlZCwgSSBtaXNzZWQgYnJva2VuIGNoZWNrcGF0Y2gvRENPIGNoYWluLg0KPiA+IA0KPiA+IEp1
c3QgY29uZmlybSB3aGF0IHRoaXMgbWVhbnMuDQo+ID4gDQo+ID4gRG8geW91IG1lYW4gTUFJTlRB
SU5FUlMgbmVlZCB0byBiZSB1cGRhdGVkIHNpbmNlIHdlIGFkZCBhIHByZWZpeA0KPiA+ICJtZWRp
YXRlaywiIGZvciB0aGUgaGVhZGVyIGZpbGU/DQo+IA0KPiBObyBpdCBtZWFucywgcnVuIGNoZWNr
cGF0Y2guDQoNCg0KIldBUk5JTkc6RklMRV9QQVRIX0NIQU5HRVM6IGFkZGVkLCBtb3ZlZCBvciBk
ZWxldGVkIGZpbGUocyksIGRvZXMNCk1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/Ig0KICANCiBU
aGlzIGlzIHRoZSBvbmx5IHdhcm5pbmcgd2hlbiBJIHJ1biBjaGVja3BhdGNoLiBJIHdpbGwgdXBk
YXRlIHRoZQ0KTUFJTlRBSU5FUlMgaW4gbmV4dCB2ZXJzaW9uLiBQbGVhc2UgdGVsbCBtZSBpZiBJ
IG1pc3NlZCBvdGhlciBwYXJ0cy4NCg0KVGhhbmtzLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KPiANCj4gDQo=
