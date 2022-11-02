Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B221A61604C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiKBJ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBJ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:58:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB3711172;
        Wed,  2 Nov 2022 02:58:27 -0700 (PDT)
X-UUID: 3110575c23ae46959253cfbe0a6b0869-20221102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=P8sHLA4+kgIqfYE/EMFM37I93H0Yy6t9peVVZsb/ckY=;
        b=YjKbt5tpNcCwkc7fB6YcjLQpBklM2N6tr/VrIS1hVGQisAysB/V2id1i+0mCm19haEd8zZJrHf7ueu/gWgwQP9Oz0+0SD5j5DQMczWRX2n6eseC5PL1W1FQd+kyOsGQnEfh2g05vxvA6wUiVIMdQQOU6H+2i5NkSbe7W7Sctae0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:23bedf73-e492-4698-a700-d60315f45e55,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:8e4a35eb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3110575c23ae46959253cfbe0a6b0869-20221102
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <elvis.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2019246187; Wed, 02 Nov 2022 17:58:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 2 Nov 2022 17:58:21 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 2 Nov 2022 17:58:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0q7vjLEzLsoolq4X7bNjInJeKy7ZfH8nnVI2bHOrQhohm50TF5jBFC2Cc3hEG3SKDNYogSOvWIwYHitMPO6bgm7oEBgFo0poZxj6MHHFYISTd2/92Nm/KR0alQCelm1dJiuq7e/vJrQwuuWL8hti8bum0gLNdHg1p035Sk+7b8lztDTWcIM4fncu7y+AcIGlJrGob+oIzRuv5X9TIeL0blFfpIaZYgKCszIiTER4TmJ5q0bTTiPRRrd8bf1nNG+8UOYMEHtpPMYx4X9FSlNCyjABx1+2Z0xQ5MPhMOqxPK8m4dRpP4GPCcQJKjeIukMCxhhK+m4/XFk5A2T6bDrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8sHLA4+kgIqfYE/EMFM37I93H0Yy6t9peVVZsb/ckY=;
 b=NA6nckyZk3ACOjo7kltwQ6f38pXYjNzyHmyUA8J2XSoloyp6HiMCCTlwEChElXaYODGf2PD5AejtbnpjanqzwgI0L5sbkYyi/rfXwGhXNBOOsZKvEJLxnGF3PF7mcMes/rZSsjY6g08SFQHAL9fpN3VierZRu+k6DVt1o8Xjm0zIkwFLezv2Bpo2H5YhLYw3JnCu2Fu0D+S72CxlAdw58V211UDBYOTCRJYgX3UAwZm2WN/XeocIIQ74zydydbOQezA0+OQKuEt7AeLHWqGGqpHSbUt3gUF5q/43Pl+t3jUsJPJJa2a1m5Bpwdxz/OOqUq4F5nSKpqFDc7Wm+b+vVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8sHLA4+kgIqfYE/EMFM37I93H0Yy6t9peVVZsb/ckY=;
 b=sQP5cVSxIFdFlEP82jwt/tilHqKAIPS8oP7c0wMARpI4302K6644yHsg0BiFA4QhblCqnjv1exDdFqtj+6qVNrMvdRgVRP5/Z9feziHX8IlrovT7QQDiPJmU/Yxs8M3dfFD2HszyYHyH0FQAi284iqnTVSkDbnlr1EOe8wmbp/Q=
Received: from SG2PR03MB3228.apcprd03.prod.outlook.com (2603:1096:4:d::22) by
 PSAPR03MB5509.apcprd03.prod.outlook.com (2603:1096:301:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.17; Wed, 2 Nov 2022 09:58:20 +0000
Received: from SG2PR03MB3228.apcprd03.prod.outlook.com
 ([fe80::9f80:493b:36dc:30bd]) by SG2PR03MB3228.apcprd03.prod.outlook.com
 ([fe80::9f80:493b:36dc:30bd%3]) with mapi id 15.20.5791.017; Wed, 2 Nov 2022
 09:58:20 +0000
From:   =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SG91bG9uZyBXZWkgKOmtj+WOmum+mSk=?= 
        <houlong.wei@mediatek.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bingings: gce: add gce header file for mt8188
Thread-Topic: [PATCH v2 1/2] dt-bingings: gce: add gce header file for mt8188
Thread-Index: AQHY64RNwdaqaV1/j0yoBxgZriLaI64oiCUAgALkF4A=
Date:   Wed, 2 Nov 2022 09:58:20 +0000
Message-ID: <2f0e05a74f8b7997682262aca926b7d1544a037e.camel@mediatek.com>
References: <20221029105017.20734-1-Elvis.Wang@mediatek.com>
         <20221029105017.20734-2-Elvis.Wang@mediatek.com>
         <e0d37670-cb88-3a20-5230-9f14411edec1@collabora.com>
In-Reply-To: <e0d37670-cb88-3a20-5230-9f14411edec1@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3228:EE_|PSAPR03MB5509:EE_
x-ms-office365-filtering-correlation-id: bf655e27-e514-4c5d-124f-08dabcb8c5b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOXmdA8YqACwaOEi+VEmrlCrQOW/uU27oj+5g5Rj0K9lo1Slvy63/Xt7pvVa2nTIo5kAnM2e+R/+386BfHm+cigzgKX9hJtXvdOa+6rfIOZ2cwneMM4EyW0H6lcqHLaoSZkBkAwHpwFsoPUI8S2zG3YjF75pja5T9ZJrhyqN4/S1N8ev6ojxjT1LQ1d9fD3G/jaeAT43DvGICHimEOj0hD+onkVdX1qsZUC3/KPOh1x9cRJiyHXdO5K5Lopq/qLtXYFONWD8+fROjINQCCsqO06Zjh9zi7DQhsVOFD7WyIexCLFW7yB4VzN/57XeznM9BRuX6sNt+BFMD0sexJS6NRMHCqTLi62Q16JkS9xwX+vta38tZdgKFOWNEoYPwXcljaV7bzUA53a5XQGMZyNXX+27HgBM9KiQC5+IeLRW2aePSBfsHMrCwnjLRYZv0In14wFSZJIkpuPQcW1kAzmToF3GmPwi99JdDwy2BxRWXZGAwdHCRD4osMkKHeyJQXHUZEUmkWokh0HymGlwa4u1Mx3nKMnj7wESTU5xHdYXRKX0ZUWm486fEi/GHD3lsnmcxVXjoHjRNUQ8nCSxNBRZX1liPu6NQgJdN2KSMxMRbUwOUG3H34CtORXC6VzpToD4ezcUD6ev7no+UQ2xKOWiFbvlrfTSaEIy1LlBQKSX4qj5QoInkZqAyFN8V6wtPko0BAmRhS420ZRiUf0JwZrt2BahoRQoeDOZlhN0AJTIXLH6SrjF7N3UqjULxCRYr8JxdWw4PODXQtnW/iNPLF/VSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3228.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199015)(54906003)(85182001)(110136005)(76116006)(5660300002)(6512007)(2616005)(66476007)(26005)(4001150100001)(186003)(4744005)(2906002)(66446008)(4326008)(66946007)(66556008)(41300700001)(7416002)(36756003)(478600001)(107886003)(64756008)(8676002)(86362001)(316002)(6506007)(83380400001)(71200400001)(8936002)(38100700002)(6486002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGJNY1JTN2M5M29iL2ZkVzN5Q0ltKzRUZFIySldjRmdXcDZaYVdKdGhZTGor?=
 =?utf-8?B?VVlBVWhsS2MrSk43ZW9XMWc5TG1wTzlORlRuWEJ5eGJxMjFEYkk1b2N1L0NW?=
 =?utf-8?B?d3Vqa0FjRTF1WGsxQ0dKdmFRMGF6T2YyR2lwMERRV291MEVmNTRzbVpZYzdK?=
 =?utf-8?B?OTErdDNlVk5OcFV2d0lFZ3lRUEZtK0ZZa1p3ZGZJeERtaHVtNHYwOTYwdG5z?=
 =?utf-8?B?TTRrKzNJazZtQUx0T1hvdjJkTWdZTnJ0MUFGWmFzTHg0TUp3N1cwV1g2Mmp0?=
 =?utf-8?B?MVpWWERoMDlHcDZvNktVdDVsTTduTWlneEVaaUJGRmdZUnRNOStkZjh3ZWRZ?=
 =?utf-8?B?QjhXQ2FlOXRRcVB6bmFmY0pnaUdUcW83MlR1QlVBNkQxWWx3SDhZU3pCSDBU?=
 =?utf-8?B?YW9FanFnNkIvb1VOUHYySFI1ZFdibkpQZFhFaHMzVlBnbkI1SVJXNlUrWDZD?=
 =?utf-8?B?Y2pnYWFzNVNtcFdnUWdUK1NweVBrZkFlRUNVa0t0SFdOc0VzVTBNaXJqbjh5?=
 =?utf-8?B?M2N2aWJNSXk3bEphK3dOWU83WHN0NEw2UHcvazZXYmZuSlgzMWZLaXRVelZK?=
 =?utf-8?B?MFJISXo4Y2pteWhWT1E1VFBrMjhCZk05NlJLbDZjMDRGSUlFVUFOdGhBMUJy?=
 =?utf-8?B?K3hPcEViUUJLWDhyRE4xN2VHSUhrdVB0VGYvdVpINmd6OXZMeVYzS0dGK1V4?=
 =?utf-8?B?RFNYWlZmVlBtRUxnbUFtY2RxTWxjbkNiYjlSbFk3dFEzQ0k4dS9keHVMb2Zh?=
 =?utf-8?B?WHd2WGZNbFRSK0VJMDJQdUhZNjFiY25CNVJRWkRzdnZVblJhZzlKb2NtMmhO?=
 =?utf-8?B?UXl3UG1rTzlxS28vVE9Rb052Q0l5Qnh1RzFKSnpkNUdYeEV4OFhlYlExOVdj?=
 =?utf-8?B?cGJKSUozcThuSzJDMzBUUkQxZ3cyVDYybkVjQTB5bkxmZkhUY2pSRGJUd0NG?=
 =?utf-8?B?TExSUlF5YXh5V0NtV2dyN0VFMVNKUjlGaXVEZnYrOURLVzA3L0lZNVhGOVY4?=
 =?utf-8?B?ZGxrR25ORlNjaHpoZEJQY1dHTGVrL01VcHNBWUM4bGFRTjR3dUdTT3kwVjk4?=
 =?utf-8?B?NytmcytLQnNCODJOZ1F6LzI1OXA2U2lJa2xPcDNvWk5Uc3hpZGZKZXQvSnI1?=
 =?utf-8?B?TWV4OE1VVGl4b2pWVW0vWlQzdUpzUmg4SmhSNjVndSttTG4xazQyYmQ4ZVNw?=
 =?utf-8?B?QS9Gc2NpUkN3bS8yZ1AzZy9VdTFzOXFoRWtZQ1NIOUU2ZVd1RXkvSjVSNTZM?=
 =?utf-8?B?dGoxaTdodEF5YXJFak5RWDE5N0hwNTJFYTMveDFTL3N4RHkyeTFaWTMrMVNt?=
 =?utf-8?B?QlVhc2pUaFNLdk1TczFzd0VYWEFCRldoOHJSZmcxZHhNYW9KZ09id2p0TWk4?=
 =?utf-8?B?ZHlzbzlyY2FkNktwYkYxT0F0c1VXSjArMlRoS2kzcEp3c3BRMWl5QllDcnFu?=
 =?utf-8?B?aE96SzVYMHVZVGt1VkVnTHJQOVJycXNtWFFUcnNNam0wU3Q5ckZyNGx1QkF4?=
 =?utf-8?B?SnlZclRNWUVJQXcvaXlQa3duajJNZW5kOWxlRmZsaDJ3eVVTby9VZ3lMNENT?=
 =?utf-8?B?MzZLYUgzblpWRVJ5YlREa0IzQThOQS96UkVBYjh5bFZxQURCaTJGWm51TCty?=
 =?utf-8?B?RDYzdWxlU0VWTDgwU0x3aEtyVXV6aXBjQzloZ3hQZ3J5M1RHL0lBdStsSjdP?=
 =?utf-8?B?TlRqdnpVcGpLQkVJeVZqeWFQSzFsUDV1c0RwNVBERXZTK1JRSW5LK2lmMzk0?=
 =?utf-8?B?TlBOSnRMYXRIclQvd05ucDh0VHo0TVdyRlhBM3c0cmsvdURZWkc5TmdvYUI5?=
 =?utf-8?B?dWlhZis2UFFCcHFRamt0SUtNR3poTDJ6Rk1kM3RSdjd3NXNEZkN0MTdicXVP?=
 =?utf-8?B?aW8yeW5Gc01CTG5OTXJZT1lHeWtmRVZIenIxYlMwWEtKUDR3RndUcG4rV0Zx?=
 =?utf-8?B?OGF6MytGU0Rzam5FS0RUTkF6d1lzSDBrTjdTMmx4RGsyVldMeW9VYmhhK3pS?=
 =?utf-8?B?MHNkeERzcWZ4RzdwMEZUVFFLbEhUYWg2eDZCK1k5UHR6TkxzTUR3RXdvV2VC?=
 =?utf-8?B?T3VJc3V1eDhPbllMWGtBb1d3RHJMdFdyaTEvNmVxa0RKMGFsUVJWd1hJeXB2?=
 =?utf-8?B?VUY4RllmWWxLR2hKSko3eDFHaGd4Uk5QaVZwc05HUjNGY2g3VStObXhZcWV6?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F215FBA5DEF4742AA584A4CBEB8BC83@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3228.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf655e27-e514-4c5d-124f-08dabcb8c5b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 09:58:20.2598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krXjceUwNyiy12WzYBTscrgYTcs3A1qDO0kyCqGwxZO0zeBhufJX1EW8tcdnjjnskLzNPCOMKRV6Ke4Gi5sHHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5509
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTMxIGF0IDE0OjQ5ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjkvMTAvMjIgMTI6NTAsIEVsdmlzLldhbmcgaGEgc2NyaXR0bzoN
Cj4gPiBGcm9tOiBFbHZpcyBXYW5nIDxFbHZpcy5XYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4g
PiBhZGQgZ2NlIGhlYWRlciBmaWxlIHRvIGRlZmluZSB0aGUgZ2NlIHRocmVhZCBwcmlvcml0eSwg
Z2NlIHN1YnN5cw0KPiA+IGlkLA0KPiA+ICAgZXZlbnQgYW5kIGNvbnN0YW50IGZvciBtdDgxODgu
DQo+ID4gdjIgLSB1c2UgdmVuZG9yIGluIGZpbGVuYW1lLCB1c2UgRHVhbCBsaWNlbnNlLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEVsdmlzIFdhbmcgPEVsdmlzLldhbmdAbWVkaWF0ZWsuY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBCby1DaGVuIENoZW4gPHJleC1iYy5jaGVuQG1lZGlhdGVrLmNv
bT4NCj4gPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxv
d3NraUBsaW5hcm8ub3JnPg0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgdGhlIHJldmlld3MsIEkgaGF2
ZSBmaXhlZCB0aGVtLg0KPiANCj4gSSBjYW4ndCBzZWUgd2hlcmUvd2hlbiBLcnp5c3p0b2YgZ2F2
ZSB5b3UgaGlzIFItYiB0YWcuIERyb3AgaXQuDQoNClNvcnJ5IGZvciB0aGUgdW5uZWNlc3Nhcnkg
bWlzdW5kZXJzdGFuZGluZywNClJlZ2FyZGluZyB0aGUgIlJldmlld2QtYnkiIGluIHRoZSBtZXNz
YWdlLCBteSBwcmV2aW91cyB1bmRlcnN0YW5kaW5nDQp3YXMgd3JvbmcuIEkgdW5kZXJzdGFuZCBp
cyB3aG8gcmV2aWV3ZWQgaXQgbm90IGFjY2VwdGVkIGl0LiBJIHdpbGwNCmRlbGV0ZSBpdCBpbiB0
aGUgbmV4dCB2ZXJzaW9uLCB0aGFua3MuDQoNCj4gDQo+IEFsc28sIHBsZWFzZSBmaXggdGhlIHR5
cG8gaW4gdGhlIGNvbW1pdCB0aXRsZS4gcy9iaW5naW5ncy9iaW5kaW5ncy9nLg0KDQp3aWxsIGZp
eCBpbiBuZXh0IHZlcnNpb24sIHRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiANCj4gUmVnYXJk
cywNCj4gQW5nZWxvDQo+IA0KDQoNCg0K
