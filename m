Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F66D682820
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjAaJG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjAaJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:05:57 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0719DF758;
        Tue, 31 Jan 2023 01:02:06 -0800 (PST)
X-UUID: dc7f9a06a14511eda06fc9ecc4dadd91-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=Nc/+u1MoO/0bDiZalPpTZRYD3fER3qBlP1+4E0vPDag=;
        b=HwVoRyljGXosHJM+WWHMLoNF+ODlTLTeCBcRfLq8YUSq2Bp0DTseZIzCzvrVqnavjK7f3HTqC8hlrqGK+yFc29S1jVTDPu303DYKy0LuSu3vuNNC1S2FaJBM3Y9ID9ak6ZkLsoKL8aYhGsnha5zjM9JT55F+QNT97Kl1RLt/nug=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:cfb1ea77-f683-4dfa-9b91-c56426dbdaad,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:a51c03f7-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: dc7f9a06a14511eda06fc9ecc4dadd91-20230131
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 639872228; Tue, 31 Jan 2023 17:01:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 31 Jan 2023 17:01:33 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 31 Jan 2023 17:01:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McumalBLB/jO84eX+NKL5GXK0eNRu0Si8qlmqMGCt+MrkS1t/QRY9Cm2mcCQ49UThmbaXYd2oHUJvOQ7Ap9NiGPXeYN4KJR1wvyTGO09y/IC1UnFJiNo0d2u21REvChVT/CL7h6KfQpSwa83WGKwMXzKwh6Avha5b9Mbv0MuEfXpmx4Ks2Nx+t5RmYAbzug4xV2r+W5J1Qb/ab/pDP6VQMQze+CdXA7WQ19bSN9jh5p5ygYSVLHRcQIerPNaYJftGS8HJYuXRQOfLAGp3tn3260+in1lIuEn215i4d4XykNqiAegGnIA4k+kO9zpv50f1nE4fAOaxgyhBLLlkGhBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc/+u1MoO/0bDiZalPpTZRYD3fER3qBlP1+4E0vPDag=;
 b=flTnaUb6za8oxdomfddZhA4saLJnkBxnsvVmNpdWTl+VzwQ/3whkMkqr7H7suDHrYB4Zx7t9hM81K3u7Wwes90x2G/4zUF85bJCI0dHg6SkcIshi8/Wb+U7Ifvh/vduzBMGyyOqCE5m+/Hg3GCI5ASzmh9gEZr2/2fr6h9BgUUx/stYMW18JYQ9L0F1Sgh/nV8ygbNVXjqXyzF2JSDBcf/QueaUYt5pgA7oPorRkJFdiIeVyRSPMVL3qfT3uh9mTG74q4GHmE62YYiQYmi09sn66D5l00sRz+/A7BDSabtzV2cBB6yHgZjp+OsJXkOshcogNRgsi/7yB1iglVypUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc/+u1MoO/0bDiZalPpTZRYD3fER3qBlP1+4E0vPDag=;
 b=vn0Lp6LY3S1Ry2dzrkT7V36LTBozpM+JilD31mvYCRlEYnfP+rEqz+sAZqyrgGBBO2Cmi6lwtyDiz3fBoCajqX0o3eJY5r5Q8MYJU/n2/BCjxpMvFnN2+DqhUP16G2Xj6L5ibp0xLWKOPtpJmdanuvqsMGt+to1hc+qbukMWOXk=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by PSAPR03MB5688.apcprd03.prod.outlook.com (2603:1096:301:88::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 09:01:31 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1%3]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 09:01:31 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?WmhpeW9uZyBUYW8gKOmZtuW/l+WLhyk=?= 
        <Zhiyong.Tao@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bero@baylibre.com" <bero@baylibre.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v9 6/9] dt-bindings: usb: mediatek,mtk-xhci: add MT8365
 SoC bindings
Thread-Topic: [PATCH v9 6/9] dt-bindings: usb: mediatek,mtk-xhci: add MT8365
 SoC bindings
Thread-Index: AQHZMMpYSkJycLIrDUWc7NTGTCn+RK64Q6IA
Date:   Tue, 31 Jan 2023 09:01:31 +0000
Message-ID: <c08d3cea3965bfd58221f97f8a69ba57749af353.camel@mediatek.com>
References: <20230125143503.1015424-1-bero@baylibre.com>
         <20230125143503.1015424-7-bero@baylibre.com>
In-Reply-To: <20230125143503.1015424-7-bero@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|PSAPR03MB5688:EE_
x-ms-office365-filtering-correlation-id: 176c4cdf-c72f-4890-cb4e-08db0369bee9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/O/ei9yL2aatWzWcVo24QIaWgc0QtBsBWqBH+KAMijbIAtMH0paeO/pz6xJBYdajtys9O316EGgiRyYMRuNLS+B2rIrOReYSDJuYKKdbOclW4oQ+MndG3rqgj0NVBU+qH5X4YQmSci6EnQH1zE/cf2ztEzcMGqxeQVT8FEdmpKZLP66vppETJHhaQ0xJxUUWzt74KuEO+OQh6sbvb8ecMo00db+CLrjspsivPt7vN6iyL23j24lhj30wZNuzOlBkLlLfcoUYJnRNhJziflRlVMxlZKtaqqF4AhM89rkSTPc15CmfquCsI+nShppDvaKOLhDVjQgOlLYiYE1jm0lHDryXzD/E2lXLyu5jPtBgEw9OKgmkKGI6MVKJ2jKreZ58f0A95egjfx/wdK+dFQGi8wY1dpOz6OORwFrplKHHNxFfTFtgQl8P5vFunKcGKXUXCJNK3qzRzjus/NZGo6Ltot/ItLKGFCCmPjnSqZ8a30zTjgp4wV8P6Q7a+nsqSgqGP3s73NCRZgtLHTZVhsmDmAX9+M9qXZyqcGK4oe4qnBCfVUYv7luYphpUg8K3fM+vJ+1RxjO6KZmsg/32C+U3yhBcMU/d+FEVrbRDlATDeW/CviejUdkL9fFiIueNjuJ8OcF3wV8YKgR7owFu+DHm+5We7G109yP0rw9fOvqG+7OnxTiP2aNgwxF5rlJyGpcQIBSkUSi2KQmXl4ytDVFQa2naHFPpZ0JVj/Z9byesA1t3Mu8igoyIBl0jtMzGKqEbzw5sl+buERwGBRMkV8668126nllXIxQr81O4fbVGuI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199018)(5660300002)(7416002)(8936002)(41300700001)(38100700002)(122000001)(38070700005)(85182001)(36756003)(86362001)(921005)(2906002)(110136005)(6486002)(2616005)(186003)(478600001)(26005)(6512007)(71200400001)(6506007)(91956017)(316002)(66446008)(8676002)(76116006)(66946007)(66556008)(64756008)(66476007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnpid21ZTHRGZ3R3ZjZYdGp2ZWtpSGUwNHNoWW9LOXlmMmRJaDZqRTFLOTdG?=
 =?utf-8?B?Q05sc1IwSU9hb3NHbkZPSW9wMjQ3citPK1dBaUF1S0hWT3NiN3BwemJzcHNJ?=
 =?utf-8?B?MDQ5eHRlQ1hWdDM0MlgreXdXZ1RGdEdkMUptTWZNeDV4Ti9JYU95U2ZsVUlv?=
 =?utf-8?B?L0JPVEZXU3VQV05oSjEvWXBrQWxmZzg4b0ZiRUUweks1cmorK2wwUUlJazJp?=
 =?utf-8?B?T0VrNTM3SklkVlF5Z0s1ei9YZXVXcFIwYTVIdXB3ZGNrd2RMdHVhVjgrYWdW?=
 =?utf-8?B?MmdTYUdSUUIzaHVtdDV6RHp6aFZpUCs2ZkdLbWFxclNKR2hlb09VVTB4Z28v?=
 =?utf-8?B?SGxLMDBhT2ZIVUtKWTRFdSs2c0ZSdEVYd0NMR3FDVXdYQk1vOENFUUlTdDhm?=
 =?utf-8?B?OERnQTdNT0ttcjNraUhYanZCUUVtRW9pcWNOL0ZMYzVDaWVCbjV3eHBTZ3po?=
 =?utf-8?B?Rm9HQzJRVURJQ1R4QUN5d2dIYXY2TzRvSEVPTVA5a0V6eWtEOGdQckNPYmM0?=
 =?utf-8?B?WTNZYzVzK3NKSVYxNmZiVWVvUDZ1SVBkV000TlU0T3o3NlN6RlZJVm9iNTdK?=
 =?utf-8?B?Ny9VZ2tYOC9aQ1g0aE9vbFRjZkFMNUxpVmNOV3dDWFU1TllhdXZjdUNwT1V5?=
 =?utf-8?B?a0ZienZQbTF3em04NGRteHl6M2FERFgwUXRqYzhnVXh4TTd3R0dHZnd5UVRk?=
 =?utf-8?B?NnU0cENLQnJZNEl0RHNxa05HSnNXK2hKOElTSHBzNVVFOU4rTXdaMThYd1lV?=
 =?utf-8?B?cEErZGFoT21KdkJnSmxJM00xc1VQY3VuS0dkbHhQTXh6RkVCUmttcm1KcTlq?=
 =?utf-8?B?U3phdjEvV0o1UE1WTS9xclJlYUpVTUUzSTNTUDJSNEorSVYrNHRxZVo3ZVc4?=
 =?utf-8?B?V0lnM0VBeWViQWJ5Y2pNd3BTejU5ajdGS3pkQjVnNDFIZTd2Sm9ncHJtOXFC?=
 =?utf-8?B?RVZvTXhscE1DWmhnOVc1SUxpRnlJaERjTEc0bVBOcVdVK2djZFNRK2ROTXVK?=
 =?utf-8?B?UXQrTFd2VXNUa3BoRGdmSE5EZ0luWEVmRTFuRDVEa3JQM01hTlg0VS9LUUVi?=
 =?utf-8?B?SjFpNy9XT1g2SDNSZGQ3eDhQTFEyUjhuSnZjUGhVQzdMVmZhQVMydzVvRHJH?=
 =?utf-8?B?ZXV6LzE1eURkbURFNXI3WGxjbDFlMkpCWFlPYVNEU3hTL3pRK1FLa2ExT3hO?=
 =?utf-8?B?S3NBWlRGSVIwSTI5aHROL2JBem5ObmQ3NkxFNTZUelk1MlptUlFVbmVlaFNM?=
 =?utf-8?B?VWt5aVdQOW54Y3Z3VW1oc0ppcmhjOUdQRFRJVFVZbWF5bTAzSzR5UnNxK0Z1?=
 =?utf-8?B?bldiK0xMaDg1VkxPelJHS3oxUGtrOVBtUWVMajZvSG5za0owNXRXTFQ1d01u?=
 =?utf-8?B?UGtLMHZyano2VUtXenNWTWN3cTFmZGEybXhIM2R0YTVkUVhXV3RvelpGeXR2?=
 =?utf-8?B?cm5wa1h6UWM4VlNFZWJPQ3RRNkEwQmhKNnhlSHdiOHo2ajByUUsrVmJ3eVpr?=
 =?utf-8?B?d2JWWE9VMU9xMFZVaWFnNjYzZ2FhQVN4RG9XS2w5QzBITm84M0daYkZlMnhJ?=
 =?utf-8?B?L2R0ZXc5OHgyd0owcnFvOGczUXBxUitoNnhlT2FpVHFSNW43RmttWlpRc213?=
 =?utf-8?B?OUxubFBKWEMwdnozaXR5TjgrZThDQk9McENtMVFrWUdFaW9FaWJVWnlINWtj?=
 =?utf-8?B?WUppME5SajdPeSs1NVN6bzhwZGdzMjNHc0VZZm9mMW1aRDQ5Z0x3U0lkSUtX?=
 =?utf-8?B?b0dqSWhTU25BVVZ1NHZnN2lTWkgrVlhVcW1DV1RreEorcWtabEIrczlUTTgy?=
 =?utf-8?B?SEhjQUMvaVhiUzZHaFhzbFhJU1dTOUJSZ3k4UG9GY3VCVDJKNVZ4d0RudE1L?=
 =?utf-8?B?bzRUZm4vYTZRUkFKZGxoaXpSUkkrV3kxR3czMk12KzJoWFk1bk5oeVJYY1hE?=
 =?utf-8?B?eEZRai9jYWgzdHZoQ1NUaXRSdlR2b0NwK1kxelFKeTBIaFZrZ3F4aU12WlVD?=
 =?utf-8?B?aUFBd1V4SnZNUkVWcjRjM2F1WlVud0l1TXAzWjc2dVBURXVUd1N1N2swUDhy?=
 =?utf-8?B?SERnWE9uVE9kaFVab3BOTWppZWM2WlpmL20rOFNIMDJZMlEvSjVTbVFGY2pv?=
 =?utf-8?B?RjMzT1JVRHZzd1hUUnhsVGV3SkxIakszV0VWOVI3U3NZazFZaHg5Z3U4Vlla?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <135D4D716B3C0349B8D57989D4E4C6AA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176c4cdf-c72f-4890-cb4e-08db0369bee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 09:01:31.2187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCy2UBxdWBU4VMGyi8xuP7UzzVMlG/1ZldN860agG1dhO3baUvJCpdEFsJv1zRY2wLiFsRBqTKDkfE8slMBrHRkFwYQgmPmjmPmwYLkIrbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5688
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

T24gV2VkLCAyMDIzLTAxLTI1IGF0IDE1OjM1ICswMTAwLCBCZXJuaGFyZCBSb3Nlbmtyw6RuemVy
IHdyb3RlOg0KPiBGcm9tOiBGYWJpZW4gUGFyZW50IDxmcGFyZW50QGJheWxpYnJlLmNvbT4NCj4g
DQo+IEFkZCBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIHRoZSBNVDgzNjUgU29DLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRmFiaWVuIFBhcmVudCA8ZnBhcmVudEBiYXlsaWJyZS5jb20+DQo+IFti
ZXJvQGJheWxpYnJlLmNvbTogQ2xlYW51cHMgc3VnZ2VzdGVkIGJ5IHJldmlld2Vyc10NCj4gU2ln
bmVkLW9mZi1ieTogQmVybmhhcmQgUm9zZW5rcsOkbnplciA8YmVyb0BiYXlsaWJyZS5jb20+DQo+
IEFja2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFy
by5vcmc+DQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFu
Z2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1h
dHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sIHwg
MSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay0NCj4g
eGhjaS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRl
ayxtdGstDQo+IHhoY2kueWFtbA0KPiBpbmRleCBhM2MzNzk0NGM2MzA1Li5jMTE5Y2FhOWFkMTY4
IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21l
ZGlhdGVrLG10ay14aGNpLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sDQo+IEBAIC0zNSw2ICszNSw3IEBAIHBy
b3BlcnRpZXM6DQo+ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgteGhjaQ0KPiAgICAgICAg
ICAgIC0gbWVkaWF0ZWssbXQ4MTkyLXhoY2kNCj4gICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5
NS14aGNpDQo+ICsgICAgICAgICAgLSBtZWRpYXRlayxtdDgzNjUteGhjaQ0KPiAgICAgICAgLSBj
b25zdDogbWVkaWF0ZWssbXRrLXhoY2kNCj4gIA0KPiAgICByZWc6DQoNClJldmlld2VkLWJ5OiBD
aHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQoNClRoYW5rcw0KDQo=
