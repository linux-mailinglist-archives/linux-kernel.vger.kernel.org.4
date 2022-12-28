Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B8D657327
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiL1GWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiL1GWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:22:21 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE3BE0D;
        Tue, 27 Dec 2022 22:22:19 -0800 (PST)
X-UUID: 67d583ca282249139cac763b9b474a37-20221228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dinwPjHW7/oWcX3ROL6vENL+v11Q5wf5F/W4EIalrFc=;
        b=ZWAMbRSbIi0YG4H+On0qaareh4Jju/z21iwkUP1OtTkHOM3o0L24pX2VVEKuKOceV+ob99m7mhGM9/ik8jrlaLXBgGo63QVxfwFMQ4XU0kBhgjgybvTYwYPtWXNBWwg/XviU2JHY3cVo28XKGejJ7Wvbr0vCgOeRWv6IOCeguRI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:0a9088e8-1320-48eb-83e5-2238b40b0950,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.14,REQID:0a9088e8-1320-48eb-83e5-2238b40b0950,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:dcaaed0,CLOUDID:6d450053-dd49-462e-a4be-2143a3ddc739,B
        ulkID:2212231724371MX7JH63,BulkQuantity:41,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: 67d583ca282249139cac763b9b474a37-20221228
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1756678523; Wed, 28 Dec 2022 14:22:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 28 Dec 2022 14:22:13 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 28 Dec 2022 14:22:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jInLqxLwYu2jYi6deR40J4L/5w5X4pOuikCFF38MlNaJOC1/cbjuu5940pvcelDiYJW7o+fIevEsieIqebYTf/OKctxHOHuBWu3vm+JN8RQFLZ28ywdpYPE0TScLcyK3V8wGiUyYqmXeQ7AT57EAhFFMbKxeR/5xJv5UXsLj+sdH2CZwQT6aCh7Vc+N9W2srzetpOcizNFpPyS2k957vMru/TsSI1N+JybxWF98ySQRvjdmfeX8fmTFYozTPTwh9B7yb93x/+i3aZ6vjPk6MR0y4MSLHHfxTiQhYbUcKdww/8fdvs7UBGX0udZ1Gr481rMK3w++MhMY+zePj1tH9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dinwPjHW7/oWcX3ROL6vENL+v11Q5wf5F/W4EIalrFc=;
 b=HA0yCuRsBNLz/OC68wTZRQRZQfM8ilMQTGdgV3opmohTqxJrlub7w1zIu1ZIRKm14tvkK3qs2L0a2mWhJ8TIBwKoMI2Zp+q+OFQtJ4nySj9GAD29xSEGUPQGFTP72WV4Kl9WP/S6l12oW4dwfZxlGpCuhquvYuJ+8HP6u1Ii5D7TMb6CGzJM9zRsYLVOR0KhT/9YqED0FvAUaa6DZOO0yKwDdzXtVKd5FlW7AEGdWxLX5W9NU8xBe60IBpIER6kew5AsrgI5tKcLtBwtUVnotQM6R2s8WvhWk9QrMxhiVqUuqYoj/p3gxMpCJlpMQD1xQ8Az0qjF3/uohwxlEfhhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dinwPjHW7/oWcX3ROL6vENL+v11Q5wf5F/W4EIalrFc=;
 b=oOP5kGYaDDD/4UrGdIdk4NHC3gQiOwgXXykE0PgVABQKkSdnJaF6Lfopo0z9H7kvntdLeaKyHvdZkiOQJAQgMg6JVm0GGPewNJ4XvAGq/Ol9LsALUh5++g2whcOgCV/N7ZCBVhithWmRqTVSFpamjFKzEQ8ZbEtiToXbstzWX/E=
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com (2603:1096:300:39::13)
 by PUZPR03MB5821.apcprd03.prod.outlook.com (2603:1096:301:a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 06:22:11 +0000
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56]) by PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56%6]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 06:22:11 +0000
From:   =?utf-8?B?QmlhbyBIdWFuZyAo6buE5b2qKQ==?= <Biao.Huang@mediatek.com>
To:     "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for
 special cases
Thread-Topic: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for
 special cases
Thread-Index: AQHZFnD46s2/SRWVcEOB7S9zlZaYAa57hgWAgAQHhwCAAMBsAIABCWEAgACZ/wCAAOszgA==
Date:   Wed, 28 Dec 2022 06:22:10 +0000
Message-ID: <e88410d2f1e770ceccd31e693cbcd07ad0c09a03.camel@mediatek.com>
References: <20221223015029.24978-1-biao.huang@mediatek.com>
         <20221223015029.24978-2-biao.huang@mediatek.com> <Y6W4vwJHG+6PI8fd@lunn.ch>
         <4a82aa5437e496e2b65b77ef08d7897a4b23f7e5.camel@mediatek.com>
         <Y6m7eNdWVL3IKFj2@lunn.ch>
         <5baa7c88716042421b0dd1d579c6aa70d253a546.camel@mediatek.com>
         <Y6sbRPbDDzeGbkM+@lunn.ch>
In-Reply-To: <Y6sbRPbDDzeGbkM+@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR03MB3877:EE_|PUZPR03MB5821:EE_
x-ms-office365-filtering-correlation-id: 52bb8db8-ebe4-4659-4b0d-08dae89bda8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fxwku/0PFWdU7SnJCJNg/6zmTljWOUxiSxxpXCDhvGn3E8LuS70jhS6cweHwzQOLyYsRvcJ5Qo8goyItPUCerldP/TFGIuAIVAbI0gFK99qEVQFsILGqyFY+SPclpqF/UVVIAjS+24LeB2e+1/GukorULZDz1ocFLLL7dkX5GdiZ1dib2UrsEVXLTQpseqTkdtNBB300fKOCGuRWjDZzDdFEGYO5q3Uy44F2AiFcnx2lIcDLicXXI9prdsCqde1yZQ5uiFfM5+jRMf76r5kws+0xiNvyVvasF4gvYZ7pYmffWH4dKm0B2amrndB8BIG/luIfwfsb9DSEJYA9oR6rzBN+92mIDEILsQpBv0YWOm4iEnIKC1rvIoYkAoA4yNFd87eUdENzA7hQzyHOucBkRi7K7zkIZM2vaWngZ7SPxxyDp74hLmCRwD7OA0Re/Z0mSVM/RvUk6V+QBusRbkq+OX6mWy2ExN+ZrKPFjL3Jjl7luCj0jesVD4jsIvP54zezFNlVVhrnFudDC9VyuLGQ8bR/2MsCvKFGrDKrndMTvN2uclCSSfCD6RdQpOdaqornr3MOW3i/RxhoF+zdyQnCsIu3mWElavEn5GQy13Zje4gVE943XL1Bd8GvCAndyXaes4C04Zh4+CfNM+vgxnB1h2c2l5FxB9WUMesikim2YLCTzRoKGAqIBvkPVYQSAXWCFk/VZqig8VY/TXmmRJWYzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR03MB3877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(86362001)(36756003)(26005)(6486002)(71200400001)(186003)(478600001)(85182001)(6512007)(41300700001)(6506007)(66556008)(64756008)(66446008)(76116006)(5660300002)(91956017)(66946007)(7416002)(4001150100001)(2906002)(8936002)(4326008)(8676002)(6916009)(4744005)(316002)(66476007)(54906003)(38070700005)(2616005)(38100700002)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkZuSXp5Um9UNjBKV0xuZ3Z5TkRzMHZncUZkd0JmcU9RUjhhYXhHZFlFOHJP?=
 =?utf-8?B?eXlhUE5hdEQ5cEdSbXFFNDFGV292VEFDQXVMbDhMMjNTL0lXUDFiZTRJb3Yw?=
 =?utf-8?B?Z1dJRkJzM0ppTGNlMnFJOGEyWUFxeGxnWi9NTXY0Uk1ZdXhPMy9VbDNIVWta?=
 =?utf-8?B?Y2VHU2IrTkpUSDZVYVoyazZLbEZMV3Joc0o5Y2Z4MDBvSVhmWEdYQkgxcmpM?=
 =?utf-8?B?Q1F5WXI2MVFxL1JDSEVZc3ozMUI5NU5uQjlBMHhIUStSM3MzZnZxZjF2SE9y?=
 =?utf-8?B?RWEwOUJDam9leC92K3FiaW1wdm8vcG5NcDF0SW5KQzJ4RmhpSmtUWXB6bHJZ?=
 =?utf-8?B?WE9XMmhYdXRBOStsc0tRQTJjVjBHc2dXNHJIQWoxNGkxOTRpMkh0L1lTOG9v?=
 =?utf-8?B?U1lyd2pJb1ZLaldxZERMVUVXZ0VDSk5pTUxGbnRCeDA1ZTVFdnNFeE9TZlph?=
 =?utf-8?B?NWMwTlo3THk1VDNOcDRqSjVSbXh0aUJhaHNNOWlNRCtnMUsyQjdZOXM2WC94?=
 =?utf-8?B?S3ZHVXZpK0JlS3E5NkFNdmVqY1V3K2VVUEszNVF4NjJhRkk3N1NyRmVsdjRD?=
 =?utf-8?B?NDZzOVlBOGhoc3NZbXBCalVveEt2THNCU1ExQnFvVVRXUlV4SU5lSU5PMWxP?=
 =?utf-8?B?a0FjMS9LR0NDK1BBUDR1WXZuU3J1aHRBVE8xZWJzRFNGYjYxVTl0SFAweVoz?=
 =?utf-8?B?elhqNVV4MlFRbHQzZXU4emxhUS92d3dtcWpsKytUMFhXUTFteVV0NWl2Rlk0?=
 =?utf-8?B?S1pVcklyQjQ3K2t2ajV4QUNET2p4Y3RjbUpmdkVaNEVHRVdXZlZSNXkvOVRi?=
 =?utf-8?B?NHF3ODBMQk9sRlZrZ3Q3RlBpcWlPNkNGUUlHa3FmcUgyMFY5VmZ4S3dEalUz?=
 =?utf-8?B?N1JXMzZGMGpNYlpBTU5tSkFwYm1PYm50eEVhamVqaUljTEk5MHJuVmFNU2VI?=
 =?utf-8?B?T0dDbm1NY3V3M3pPUmdsOG9ZVDh4d3N5RmVmRUNodlZWUUphQzFsN21Id1g3?=
 =?utf-8?B?bXhoQ3RLWUlocWtxSzNERnd1Yzh3RlM1MlE5VTRJRzNnSFVhS0llQnptekNi?=
 =?utf-8?B?Q054S3R1M2lDU1dwQnlXWXFWSjkvMEQ1Z21mb2ZkK2llbXIzcnp6M1V5a053?=
 =?utf-8?B?VjhaS1JFNllsSFVyUXB4akRzaVZuTURvbVhhaGxrWHE4aVRDU1kyUTZ0dDVu?=
 =?utf-8?B?am8zVVpNeDdZV3dkWkFBTUlZdWpPRWh3ZTRwSlhyaDJnSS9NNVVTaUlUbitF?=
 =?utf-8?B?dStMQ01UT1Y5dWt6S09MTWQwRUg0MThoYzBYL3F4NjBVNkdkRTROU3dnZitW?=
 =?utf-8?B?enAySWY3eEF1OG01YmRuOVJzOWMvNm5idEduTDgzMHNGZVdlS3g0MnBSQzlt?=
 =?utf-8?B?TnV1U0FIRUFNRnJzZTRTMUUwVE9ybGNOaXBEci90MmRoQ09MeDRMN0UzYmEy?=
 =?utf-8?B?K1RUN1JJZmlWSDB3cHY5dmI4U243RVlhQU9tWkptSmdpK2ZRZ3BRbW4wNG1n?=
 =?utf-8?B?YWRuVzBZMFRjWGFKNVY1OGF1bkZ6cWlWMzM1UUFIcXZleEpsUzh0eDVlZ21r?=
 =?utf-8?B?dFFNcUlBTXlKRE5rYk10eFRmWXdtSXZOUW1UNFdudzBBSUU2N0xEMy9FazhU?=
 =?utf-8?B?MGViT0hSMitrWlUxQWdNMDErdmlFZitzSSs0STYrdlVJdDYrc2JEUGFqVy9V?=
 =?utf-8?B?UnUwTVlFZUMraWtiU0JOc2RCdjRvUlZvZ0JsYVBjZHlpbm82UWdVeUxuT1Ny?=
 =?utf-8?B?Zmk1YWd0a3lUOTdzVm9PNmgxMFhWOHIzMWRzdi83c0NnUU1TWHN3OUh5d2VS?=
 =?utf-8?B?bm5OY0pobUx2eG03MGwzV1BmNWxodEZZR1ppTVlpUEpuck9kNWZ6Umw4OEZy?=
 =?utf-8?B?d2k2ZTdRSU9Dbzk1RmJ2T1JpR0ZGeXlMS3dyYnh4V2ppaDNTV1J3KzNPc0N0?=
 =?utf-8?B?VExxR0ptdVJuM21xeWREK2J0SHA1RnlMMFlWYUloVWxYWUlQSzRjbFhGOTJh?=
 =?utf-8?B?SXZFQ1F2QUQwQUh1ZDlYeVcyczFSSmdKSVhHcFIwRDhiZVpBZkNrcEF5aENL?=
 =?utf-8?B?cU5SNmFxdnN2N2orN2dsZ21sV2lFSjVkU1ZJeEl6aWdmSkxwemk4QXdFMCtP?=
 =?utf-8?B?ck5tM1Bpa0xCcHkraU4yUGVmODRPMmRnQzBMMHVJU1NvYy8wTW9yYWdFS0Ey?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F3CA9155017DA489C4410D17C017F28@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR03MB3877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bb8db8-ebe4-4659-4b0d-08dae89bda8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2022 06:22:11.0367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCVzQcP1CvsZBSc75DPSHsG75iCTzX7D9eTuqF8MC06AmaT2ZJdwkHgcNX7bJnNs5WfAaHJYl2v5OwZhpMVZag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5821
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBbmRyZXcsDQoJVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzfg0KDQpPbiBUdWUsIDIwMjIt
MTItMjcgYXQgMTc6MjAgKzAxMDAsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiA+IE9LLCBhcyB0byB0
aGlzIHNlcmllcywgSXMgdGhlIGZvbGxvd2luZyBtb2RpZmljYXRpb24gZW5vdWdoPw0KPiA+ICAg
ICAxLiBwaHktbW9kZSA9IHJnbWlpLWlkOyAgaW4gZHRzLg0KPiA+ICAgICAyLiByZW1vdmUgdGhl
IGZpeF9tYWNfc3BlZWQoKSBpbiBkcml2ZXIuDQo+IA0KPiBZZXAsIHRoYXQgaXMgZ29vZC4NCk9L
LCB3aWxsIHVwZGF0ZSBpbiBuZXh0IHNlbmQuDQo+IA0KPiAgICAgIEFuZHJldw0KQmVzdCBSZWdh
cmRzIQ0KQmlhbw0K
