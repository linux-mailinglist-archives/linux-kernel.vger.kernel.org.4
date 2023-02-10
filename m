Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D107369171F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjBJDZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBJDZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:25:05 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E126CCD;
        Thu,  9 Feb 2023 19:25:03 -0800 (PST)
X-UUID: 7f3a668ca8f211eda06fc9ecc4dadd91-20230210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1D3nyNcUBXnHU9H5iE3+QSY09RmHyu5xetDhDV3vLH4=;
        b=IrQ8wM6U1zzfUCXpU1sF/WT6jCexi2X6RCUAM5XTy+C1ScsM9mDfx974EZVLBsIexxbsbvA0+IlyF8tgsydk7T1WAtsfcf1seEptzGa9/SS3TYiK4LjG/Zk6J1caIES3bD3/k0MKdwqc+WQ3Iie5pFUL/bjAAxBGKg7ZTq0oBzE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:04e02dc2-b54c-4f0d-9ff5-15bd01f8e3e6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:54addb56-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 7f3a668ca8f211eda06fc9ecc4dadd91-20230210
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1427925450; Fri, 10 Feb 2023 11:24:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 10 Feb 2023 11:24:57 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 10 Feb 2023 11:24:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOWE4eG+cpr65YwpTiql+pTQ3Tb4Cbz+414a6aLhRZr71sIq79EPXo0QzSMfdcW/YbDqQx5Nmo1WA8A+b/v9SGWeSVZPEHbA9YCQ8QtcNJT7xOtEJfdomJQKdy8YDBap8lhwLqkGckTmh11Eddyf9amM0ibBB8x+JJRDDt02KIpGgfbS/kKwMgn88IyIcQMEQBTSGHf7xq6eTJoJCGTPekVJNUBQUazAV2k+aAYx4RBWpilrOmW+RektJ5y/S0RKY3ASPTNfLHrlI9ckTW+IuYqKqFpaqwYd4QAFLXiRHFwnAjHOEr8WAey3XzuMV113hR0TsTLuGzP0JVZyvHoFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D3nyNcUBXnHU9H5iE3+QSY09RmHyu5xetDhDV3vLH4=;
 b=VvRhGhmK9aCSVMNRz5/LYMHfnrZwOrn7WTN6TEXuUCo4PvmTLWlRLHlOdaoX6bbNDMqM5GBUdwqQVCwp7aVvlLeU/1U3YtgbEXXK251/DvWahM0IGP4iK78XEnellPmcAxzkcKPofrrWcvdE6EfqlRP0R1tAMykEsQyiJKp++2UDGmiSljeeNbeDBsc6KyctZkld14cuUEIQgOi8DctQBcNlVtMfX+FGPV0Kaj2T2joBMxqQIggtcgSW0jtqHLvZ8RH2ioexpttcug180KRYmJpgLpViGYTkf9D78rKV8xwZeYFes1Bi0i1Y7GdazyjrDtje9cNQ8SeDLI6LkpdjWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D3nyNcUBXnHU9H5iE3+QSY09RmHyu5xetDhDV3vLH4=;
 b=hwOhpLodsaPDrf9CePJ9jGd1vEIWKmmoP4CcLqJh2JDxDIRWreiN7M0tmpJDMoCaGLMWE4nKLbMxfVzVqZMtcIEXUpNJlkIDq0gYOg6mSypMRUsDtSK8z24F0XfJLxR72iNEmWu4fqRjzU/OSEr4ePiUCNYRx3qmJ5dJeQP8Kds=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by PUZPR03MB6910.apcprd03.prod.outlook.com (2603:1096:301:fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 03:24:53 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dbe7:4943:de9b:bc96]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dbe7:4943:de9b:bc96%4]) with mapi id 15.20.6086.018; Fri, 10 Feb 2023
 03:24:53 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v4 10/12] remoteproc: mediatek: Handle MT8195 SCP core 1
 watchdog timeout
Thread-Topic: [PATCH v4 10/12] remoteproc: mediatek: Handle MT8195 SCP core 1
 watchdog timeout
Thread-Index: AQHZPFnsgQ/iXZ1m0UWcOkqUz9OYtK7GkQmAgAD0vAA=
Date:   Fri, 10 Feb 2023 03:24:53 +0000
Message-ID: <5040026810f25a0defd557981c89c599b8d9bfc0.camel@mediatek.com>
References: <20230209074021.13936-1-tinghan.shen@mediatek.com>
         <20230209074021.13936-11-tinghan.shen@mediatek.com>
         <5c677b40-7bbd-5d69-9f9b-4879c8aeddf8@collabora.com>
In-Reply-To: <5c677b40-7bbd-5d69-9f9b-4879c8aeddf8@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|PUZPR03MB6910:EE_
x-ms-office365-filtering-correlation-id: 76ef40ef-27fd-488e-54e4-08db0b166002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C1TFsZovkKZAN0NP1huct6Jg80uP4uhysEwRdfyBjmnMM7lDWmKSFVKr/0aHEe5ynWlP5k9ZnWbVt/uweupOwwKE0MPQR3dK9RxlxZdhaeGsVR6L0/Fm20PDGQ/j4/xgDA09m/BN18JZsdiv28VzY7cRn9PEEjaJj5kGWEvqaOiXpSV/6yAONSUai2/BryLaAyJt8XvcwU0YuN9iepMi9wjSM+ndaj4Lg2+OMiPhx5ybNuLqIg7hYYk5kZt3zk9WpgeWVgPx+TMr9Zr5wnQ1bWOnEw0exrO5B2/0gds0A1qWv359tNOBO5Qe+kzHt9ZxOjciPq/ETiuhXkTQuyBrpBllSTWuef+M/O23DDo1inpu6vtcm9CQZCsB0ugZXOtQcqnt1GG7GxW5P1Obs+7+2///SLiijjE6y/oIBvAetE6j/QsWcgRr/AEaAyeUk/eG8iIT9yM+9ob7rnRwB05my+PBm3cADAbkm/xO+t6lq7+qlLxC+NFhGqtylSCEpUKVhmQqT2bmTeOTWkzM+DMvaOhQh3fb9xvLzZma/GOPaHRIREHsgMGjBFuTvFpFbI8RcPQUoRmiplc79Dvw8XMQzAMQ3Q8VisS/aCGzbjUIahKTwqYgMSzWC4JxUlyfR5p08vweL0jqaMgvW7oGdPFOSRzUGPSAJdA18AaOk7czV7m3i4wE9BY3kJZh/cBQl8NvauqdDfVUQT+3LvEJjsFBEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199018)(2906002)(186003)(7416002)(86362001)(2616005)(122000001)(8936002)(5660300002)(38070700005)(26005)(36756003)(6486002)(6506007)(478600001)(85182001)(107886003)(71200400001)(83380400001)(6512007)(38100700002)(316002)(64756008)(41300700001)(4326008)(66946007)(8676002)(66556008)(66446008)(66476007)(91956017)(54906003)(76116006)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlJISURXUkYzV0k3L2J5QjI3NmlKTWN5dWg4MjNIMGJ4ak5tU09vbVRwc3c3?=
 =?utf-8?B?RzczMkR4NTVISHFqL1V2enNwV2E4anRlNjJ5cTh6d1VWdFZUc213dG1Lbm5k?=
 =?utf-8?B?L1B4bUU3VzdqcURmT01pa0J3UXNZZk1QVmpma3ZiaWs2QjNxOWJmbzBmbHhC?=
 =?utf-8?B?ZzNua2JEU3JnWU9KeDRLK1E0ZWQzdGFZSUcvN2kvajFxNU9WSDRUTGNNbHJ3?=
 =?utf-8?B?N1Vodi9lc3IrK1JGeDgvcllBTlVuRGpISlJYcE5Db0hjaVZSUEhSTDBjRWZZ?=
 =?utf-8?B?V0w1Q0k2UmJWYjZhZE8yL1A5Sms5VUFVWU11aDhoRWlBVWwxRGg3b0hEWkxh?=
 =?utf-8?B?TnB4UFlyZmhGUmxESGNsak8vUzdxTmFVbEtLc20zaWVVVi95NENVMEVmU0w3?=
 =?utf-8?B?MTZ6L2dqWWZ6UWQvVzlMS0RsempLeU95WjUvZEJuZ0l1ME5qMkcrQ1BTejZv?=
 =?utf-8?B?YUhvK0FIQS94L3RGWStyYVVJOWY4S09US01zYXpncUxjQXpJYWNVMXJyVmlH?=
 =?utf-8?B?VTNnNkY3aTAwZ0M5N1JGaXF2ZFQvNjY5UCt4Q3N1SkVacGNkY004aEY5dy90?=
 =?utf-8?B?MEdveHQ1TUw3QmZTZGVGRHBHZy8xUldnMWI4NkE2Y0N6SzV1NUlMdHkydCtB?=
 =?utf-8?B?Rk5xRHpLUTQwOFJQTkphRkNjTWdSblZ6cXMwb1M3YXA5K2lDUStSOFFzMVk4?=
 =?utf-8?B?N2l5VkZlQ3lLc1F4dFJWUk1aUnNrT3NzcXdhajBYMmNrUE9RODdpaW43NEh5?=
 =?utf-8?B?QjBrT29rKytyMmZZMEhlQU1DNk8zeXNlQkJ3SGV4MWQ5L0tMSC9rcXB2VTJr?=
 =?utf-8?B?cWFQQjNEN3A3U3JZc3lIQm92dWxtakRPYk9CMlNDRXgvb2pOb0ZEVThEb0pH?=
 =?utf-8?B?UzcyaVVoYktTSURXQVU3bThUVXhQcE1UTzFmNFRzMEJVUDFudmV2RTdtUE5I?=
 =?utf-8?B?QUZhOHpMQlZMNTVwVUZNWU1hVGlMOXV5STE1b2VBOUoxQi9CbGFZZ040bHZ4?=
 =?utf-8?B?MVFyL0pSUnBuM3VWd001OURGVC9xZ1VLTU92a3lVNGRyZ2xsQTJlY24rcmND?=
 =?utf-8?B?eEhaaEd5ckw3TlhZaXY2bldrMXR6dkxCUzBhQVZ3TjVMN3hlYnJqMWsxTFR1?=
 =?utf-8?B?V2RUdVZMTUN1c3RFR0g1Zm9XOEN0NElKQWx5QnRrMU9iR0xRTGF5Nis5NGZL?=
 =?utf-8?B?bC9Ed29XOFVMUGRpUk84NTlSbmNTUUpWTDZuVWpheUloZjB0RWQ1aEdHNW9T?=
 =?utf-8?B?L1RsUnVuczY0Z25NTlFHTUVzdHp5eW50ZThyTzJQc3czUG9RMkFGWGUrbTQx?=
 =?utf-8?B?bUlCbVdTQlJMblpSNFd4bHloRUc1TSsvaTBpVE0yZHI0ZFlVU1RMTzFhRHZv?=
 =?utf-8?B?akRKY210UWFpL2Nsd0swQUVhU2M0N2FxbHE3VGdPWXhrMStQK3JzTmxEQU9w?=
 =?utf-8?B?QXo0L0FncWJtOXIzQmplWGRhbG84R1dTa05Nbnk1aU1FTGxnZjhZeWpTOGU2?=
 =?utf-8?B?WEU4T3BldEd1SFY3VmgvVThUS1hRanlzTG9HM2xqRjU4TFJuREV4blNQZm5v?=
 =?utf-8?B?K3BwU0plYXFabjBSQlRnK3RHbVA4OXR5czdrZkRWdFBZU1FLV2xLTUdJVkFP?=
 =?utf-8?B?czVCUmdCSjFNRldTZWVIVTdqayticnhYNk5MNEpDVGRZWTVmRTROMlByOWpp?=
 =?utf-8?B?RTVxaGF2SU1yUTFveUtZYzVGdUNjM1ArR0grV21DN0RLY0tVSDJqeHNaQWhk?=
 =?utf-8?B?UFpOR2k1bVQ4Rzg3TmpLNmNpeTZYSjlhYUsvRGR2RTJVUTMzMWk2RXNPNW0w?=
 =?utf-8?B?TSt6L2VKUWVvdHJESzhUVjNxc3g1UnJkUGdqaTFlTFRqSnpUNEd4RktXclZu?=
 =?utf-8?B?a1ROZHU1N2VqQUcxdndzUnYrRkRyb1czSFA5LzkxWk1GTEovbVdma3R4NXdh?=
 =?utf-8?B?NUlYU0labS8wQmgveHg1M21nek1CaFlFTTJZWDN1UDFSSDlPUkV5ZFA2bGdS?=
 =?utf-8?B?UjU3ZFNTOFhZbmlDNUl1SWgzLzFNMWY1SFJ4aUNKTVFvM09YNFdTZDN4bVBD?=
 =?utf-8?B?KzNTcXNzaVFDZHNzOHE0Z2dXYk5weXRBaHZhUWZnWExCSVREMGF6Umk5VUJE?=
 =?utf-8?B?MkRuYklzT3l1dmpMd05TRHdxSTBybEk5S1JSUmcvMmVmTW00bnp0aGJQdU9R?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B298B177F1438E4DA028AD3AE84AAA4E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ef40ef-27fd-488e-54e4-08db0b166002
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 03:24:53.0540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QF8/Nh/Kj3oFYf+eB9KugZ8j29VkAb2BcGKu+Ud1dbmVrwb1ANanhDVpkfq+EuoFmTAzF8lL9c/oaXHl9Jn89RF6LZjvZCQnAS6k91inMwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6910
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTA5IGF0IDEzOjQ4ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDkvMDIvMjMgMDg6NDAsIFRpbmdoYW4gU2hlbiBoYSBzY3JpdHRv
Og0KPiA+IFRoZSBNVDgxOTUgU0NQIGNvcmUgMSB3YXRjaGRvZyB0aW1lb3V0IG5lZWRzIHRvIGJl
IGhhbmRsZWQgaW4gdGhlDQo+ID4gU0NQIGNvcmUgMCBJUlEgaGFuZGxlciBiZWNhdXNlIHRoZSBN
VDgxOTUgU0NQIGNvcmUgMSB3YXRjaGRvZyB0aW1lb3V0DQo+ID4gSVJRIGlzIHdpcmVkIG9uIHRo
ZSBzYW1lIElSUSBlbnRyeSBmb3IgY29yZSAwIHdhdGNoZG9nIHRpbWVvdXQuDQo+ID4gTVQ4MTk1
IFNDUCBoYXMgYSB3YXRjaGRvZyBzdGF0dXMgcmVnaXN0ZXIgdG8gaWRlbnRpZnkgdGhlIHdhdGNo
ZG9nDQo+ID4gdGltZW91dCBzb3VyY2Ugd2hlbiBJUlEgdHJpZ2dlcmVkLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFRpbmdoYW4gU2hlbiA8dGluZ2hhbi5zaGVuQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIGRyaXZlcnMvcmVtb3RlcHJvYy9tdGtfY29tbW9uLmggfCAgNCArKysrDQo+
ID4gICBkcml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jICAgIHwgMjQgKysrKysrKysrKysrKysr
KysrKysrKystDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZW1vdGVwcm9jL210a19j
b21tb24uaCBiL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfY29tbW9uLmgNCj4gPiBpbmRleCBlNGVm
OTdmMmQzYTEuLmNhMjM5NWI5OGQyNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JlbW90ZXBy
b2MvbXRrX2NvbW1vbi5oDQo+ID4gKysrIGIvZHJpdmVycy9yZW1vdGVwcm9jL210a19jb21tb24u
aA0KPiA+IEBAIC01NSw2ICs1NSwxMCBAQA0KPiA+ICAgI2RlZmluZSBNVDgxOTJfQ09SRTBfV0RU
X0lSUQkJMHgxMDAzMA0KPiA+ICAgI2RlZmluZSBNVDgxOTJfQ09SRTBfV0RUX0NGRwkJMHgxMDAz
NA0KPiA+ICAgDQo+ID4gKyNkZWZpbmUgTVQ4MTk1X1NZU19TVEFUVVMJCTB4NDAwNA0KPiA+ICsj
ZGVmaW5lIE1UODE5NV9DT1JFMF9XRFQJCUJJVCgxNikNCj4gPiArI2RlZmluZSBNVDgxOTVfQ09S
RTFfV0RUCQlCSVQoMTcpDQo+ID4gKw0KPiA+ICAgI2RlZmluZSBNVDgxOTVfTDFUQ01fU1JBTV9Q
RE5fUkVTRVJWRURfUlNJX0JJVFMJCUdFTk1BU0soNywgNCkNCj4gPiAgIA0KPiA+ICAgI2RlZmlu
ZSBNVDgxOTVfQ1BVMV9TUkFNX1BECQkJMHgxMDg0DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cmVtb3RlcHJvYy9tdGtfc2NwLmMgYi9kcml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jDQo+ID4g
aW5kZXggY2ZjYjcxOWJhNTBiLi45ZmJiYzQ3NTE0MzMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9yZW1vdGVwcm9jL210a19zY3AuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtf
c2NwLmMNCj4gPiBAQCAtMjIyLDYgKzIyMiwyOCBAQCBzdGF0aWMgdm9pZCBtdDgxOTJfc2NwX2ly
cV9oYW5kbGVyKHN0cnVjdCBtdGtfc2NwICpzY3ApDQo+ID4gICAJfQ0KPiA+ICAgfQ0KPiA+ICAg
DQo+ID4gK3N0YXRpYyB2b2lkIG10ODE5NV9zY3BfaXJxX2hhbmRsZXIoc3RydWN0IG10a19zY3Ag
KnNjcCkNCj4gDQo+IExvb2tpbmcgYXQgdGhlIEMxIGludGVycnVwdCBoYW5kbGVyLCBJIGRvbid0
IHNlZSBhbnkgV0RUIHRpbWVvdXQgaGFuZGxpbmcsIGhlbmNlDQo+IGEgcXVlc3Rpb24gbmF0dXJh
bGx5IGFyaXNlczoNCj4gDQo+IFdvdWxkIGl0IGV2ZXIgYmUgcG9zc2libGUgZm9yICpib3RoKiBD
T1JFMCBhbmQgQ09SRTEgV0RUIHRpbWVvdXQgdG8gaGFwcGVuDQo+IGF0IHRoZSBzYW1lIHRpbWU/
DQo+IA0KPiBNZWFuaW5nIHRoYXQgTVQ4MTk1X1NZU19TVEFUVVMgaGFzICpib3RoKiBDT1JFMF9X
RFQgYW5kIENPUkUxX1dEVCBiaXRzIHNldCB3aGVuDQo+IHdlIHJlYWNoIHRoaXMgaW50ZXJydXB0
IGhhbmRsZXI/DQo+IEluIHRoYXQgY2FzZSwgdGhlIGZpeCB3b3VsZCBiZSB0byBqdXN0IGNoYW5n
ZS4uLi4NCj4gDQo+ID4gK3sNCj4gPiArCXUzMiBzY3BfdG9faG9zdDsNCj4gPiArDQo+ID4gKwlz
Y3BfdG9faG9zdCA9IHJlYWRsKHNjcC0+cmVnX2Jhc2UgKyBNVDgxOTJfU0NQMkFQTUNVX0lQQ19T
RVQpOw0KPiA+ICsNCj4gPiArCWlmIChzY3BfdG9faG9zdCAmIE1UODE5Ml9TQ1BfSVBDX0lOVF9C
SVQpIHsNCj4gPiArCQlzY3BfaXBpX2hhbmRsZXIoc2NwKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4g
KwkJdTMyIHJlYXNvbiA9IHJlYWRsKHNjcC0+cmVnX2Jhc2UgKyBNVDgxOTVfU1lTX1NUQVRVUyk7
DQo+ID4gKw0KPiA+ICsJCWlmIChyZWFzb24gJiBNVDgxOTVfQ09SRTFfV0RUKQ0KPiA+ICsJCQl3
cml0ZWwoMSwgc2NwLT5yZWdfYmFzZSArIE1UODE5NV9DT1JFMV9XRFRfSVJRKTsNCj4gPiArCQll
bHNlDQo+IA0KPiAuLi50aGUgJ2Vsc2UnIHRvIGFub3RoZXIgY29uZGl0aW9uYWwgOi0pDQo+IA0K
PiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+IA0KDQpZZXMsIGl0J3MgcG9zc2libGUuIEkgb3Zl
cmxvb2tlZCB0aGlzIGNhc2UuDQpUaGFua3MhDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVGluZ0hh
bg0K
