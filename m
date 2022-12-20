Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CD76518B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 03:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiLTCPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 21:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTCPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 21:15:16 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36FA451;
        Mon, 19 Dec 2022 18:15:14 -0800 (PST)
X-UUID: cbf54ed16a9f46e7b315b1cbf1142095-20221220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Si594MYj0JewDKK+NwLLxzCkEPSePktQpLndmfhBszs=;
        b=efo9xi/8Q+rVAFGbF5PkQ/8I4cgxKe3dWmT2zEJO2utE51jnmK9EcGSAgGC+hZdZML9lDIZoSKhMrGrIBqIayqYkXlj/A1W+t8gw/L2iYlZedz2IXNKZwKkpk5eiqcghKjTut0F8ZcGNs58s0WeMJb+ikLuKvIGvrRWADWRc/3Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:71c36a24-9f5b-4566-a3f2-1984f40caf46,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:71c36a24-9f5b-4566-a3f2-1984f40caf46,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:f37c3952-dd49-462e-a4be-2143a3ddc739,B
        ulkID:22121911245894658U2V,BulkQuantity:10,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: cbf54ed16a9f46e7b315b1cbf1142095-20221220
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 280705521; Tue, 20 Dec 2022 10:15:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 20 Dec 2022 10:15:08 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 20 Dec 2022 10:15:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPc+omjlRRbYNs7uGD6xyQ6+zGKAVXwoKUgS0Glplb3oGK6nG8FxKJK+thPm53cdNQzCxDfSdjzRNQd2gh+bG+2QASexmjfoUesyomf5sXEIsDRhO+qCH7NjKdbcURtoEShDeNLMXnjVkWEDuOsGgr1vT/qg6ppZxtvqWp89No4KZh7PuyVyP7aGMjC5baU2bbb48EJBqr11hu1eutFcwvvxNhJQh/LXiqHvDRZAw5hgJ/wQvzqd4kbfCTF6heB7wSwC9stYynSE1M0XgGk/yJaOayU8KF34NJhnAdE2C08Mk6w++BDt2Bvbb9HoZoUDqYPt64mD9EgKgppGWmicXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Si594MYj0JewDKK+NwLLxzCkEPSePktQpLndmfhBszs=;
 b=M0Nn4oJeSpRBinYdja6NO/yGaCoaxHE3xX8iPOQjZCUVn0TtZIbtBeVHcrI2EYU9rMj8WE/b0vqBUy7zBbzF2YhX43Ez5trTfd364png6868/MO0AURSLJ3b7g0XmNsHvLlVZw767F/d0PU11aRmStRT3ixD7s2f7U9Lq9FDfNIaMtxQ39ttmrvEbzVGDzL745JGi9FEwmZ8wrOsp8mnHh3NfSfV7dexNnW6K2kQcH5yHL+rD65gBgYs5DYoOID94e8GWlobpSyaAtSuYaRvgney6lfsW5soW7i2dORPl2ebynfUscKWg+gwHnRuVPSmzzEwmxSe9wgrkaxJJ9LW4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Si594MYj0JewDKK+NwLLxzCkEPSePktQpLndmfhBszs=;
 b=X8Mq1H35+wD7XNj8xQ+KEMuFVo8eVl4iAX/6HsuG4By/zguqRJKV43JNGSf1VcoL5w+PQvHaSU4VFB9Yz7Jr8o2IGMQwhxL3Im9CuCPjwVwkNCqdcv9nQo9h3WkI7r4L7kO0lW6IBiOY7xbSv019JWUfuJ51rnFIxqEGkA2PbmA=
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com (2603:1096:4:84::10) by
 KL1PR03MB5862.apcprd03.prod.outlook.com (2603:1096:820:84::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Tue, 20 Dec 2022 02:15:05 +0000
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7]) by SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 02:15:05 +0000
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
Subject: Re: [PATCH v5 01/10] spi: mtk-snfi: Change default page format to
 setup default setting
Thread-Topic: [PATCH v5 01/10] spi: mtk-snfi: Change default page format to
 setup default setting
Thread-Index: AQHZE1NHYiEe8abswEW4177v2fHgHq51VwMAgAC0FAA=
Date:   Tue, 20 Dec 2022 02:15:05 +0000
Message-ID: <b9295291171dad0a455928cdb44a8ca91782532d.camel@mediatek.com>
References: <20221219024019.31974-1-xiangsheng.hou@mediatek.com>
         <20221219024019.31974-2-xiangsheng.hou@mediatek.com>
         <5ebaf98b-a77e-3c5a-3e08-bbb0119558a2@gmail.com>
In-Reply-To: <5ebaf98b-a77e-3c5a-3e08-bbb0119558a2@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4565:EE_|KL1PR03MB5862:EE_
x-ms-office365-filtering-correlation-id: 46ec686f-f07b-4d6c-e6b2-08dae230029d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HLj5VeaqD7IfmoeWpfjOglizOps/PsD19sPEvMNNd8jbEjWTfsY7EbANiDFdFpB93u1OnGCQlRO7osTasBN4dNd/EPg7aWIdk7+khfZiymqPb9v4DK9Nfc78qstwCPtvW2VM2M9uEBD/OUgFLvJB7vkKkfOm3IeVYda+zV42RDeZM8wKWbWwIcFEmNlyfC2cO5tNekfU54wiJ8G+pDNN63ba09QIXe7f1/Xhi0wk5c9nfDdQ3s2RjiXAYzHmngBGCfcfLo2JDMd3sidGGNbRg8aXxEvtyYO2dpSOPVjxx/LmFOgIF5qAf7FwDuy5YA4Nl0P9pW6pNMefEhg1/9f7iE9p1udQfMvC8fMCvOJ0E4C7EAB29WfoTBh+uU96OhJ7W0MHNF693+v3NSNo1rh1u+R1SUQ1RoB1nFabTV9JWmE1U2ONjpnmn9OjRVcmsTL9hYzZ18duOamHKeztWOUED2DNQ72TD2Pp+GCjuIj/CB1VIfCN72cVf0LRcwIVJalSMLjOTNmEbEdWpTLjzUMSIOXQLtpVYZ/qVvXES2KnfZZu0GlZX5J9AlfNJoMm4WDcWxoKNpLtFfnQGgPtEai02+dIVXm/xQ+FjqohAN7qIw4qTuFiugN9V5kt4IUwHLu3K8lhHB4J/FLOU/zJzqX4pUgc/DIj267Ge2BWRk6qNoHg46o5s4L4xJfGdbZ3yzQnAqMdjZkOVl2Be5O36pIWVO/OWcI1aCLKQ/BXcuPIWL3JDV7TMKGLkmVmgslYmAZr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4565.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(4001150100001)(122000001)(38100700002)(2906002)(85182001)(36756003)(316002)(186003)(6512007)(26005)(41300700001)(38070700005)(86362001)(8676002)(5660300002)(91956017)(76116006)(7416002)(4326008)(83380400001)(66446008)(66476007)(2616005)(64756008)(66946007)(478600001)(107886003)(54906003)(66556008)(53546011)(6506007)(6486002)(71200400001)(8936002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEJKYWF3MVlJSWoxaDdTTXV2OFlyb2VtWU5KNThSS2FGQkw1WGovVjFnaEhF?=
 =?utf-8?B?QlNPcHlxWUJDejVkeW9ueGl3NzdXQ3dLSXVidkNQSFI5bi9uNmwxSWxmNm9i?=
 =?utf-8?B?d0ZaMlRnYlo3eW4rcVRaN210bEx2OU9JMUdac1ZJQm5aK3VGSGVsVytLbENF?=
 =?utf-8?B?cVFpSEdsVGJmUDF4aWRMYURZSXJUZ1ZQdFZPUitjZm93UjFlOEFEbjQ5dklp?=
 =?utf-8?B?ZzVEL09JRFUyQ2RzNjNKNWNONzJ4Z0l3YXBPdlhqWnBtaHkvL2MyNFZiQmFn?=
 =?utf-8?B?Y1pHM1NyWjVNQVBNdXpMVlA0eXcvSDZDaThnRVF1c0huVXRhOFVUaGIrdGxJ?=
 =?utf-8?B?aEpYalF0TXJ3M1FDN1pTQ0ZEVGQySE4xak1NM0pGU09VeTdVOEZ0N0JQYTFS?=
 =?utf-8?B?S0ZpbkFma3B6aTJoQ1UvVzFjeUU5WEdLNkt4ODZ6OUFQSjd5clc0Mm9JTXFy?=
 =?utf-8?B?M1JNZmJDRHZjdTRrdTcwUklPZFAxaVpGKzR3R3RzUzloNWZkbWMxOHRQL2tW?=
 =?utf-8?B?NEk5VFBxVTVQLzdUQ3dJbVhwZ2xwOFFIc1RiWDZBY1Nrd3hPVCsyWVJEdWVh?=
 =?utf-8?B?M1pHRG8yOGpNd0pDVlZIRENrMzhPb28vU3NrMmlCQzRsU3ZMOVlpTXJPVUIr?=
 =?utf-8?B?RnN6UGh0RnlGT3VLNlljaUQwWnNxMmtBUThvT3d6ZVBGeGhwWW9VK0ZnVmNZ?=
 =?utf-8?B?SFFYRDhaMGQ0Uk0ra3RwNmphRm8vZzFxdFdvWmJCRGs5K2VLQjZ3L09TaG4x?=
 =?utf-8?B?QTVnMkxmK2srWDc4S0hHNFJWdEF6ZjhjZWw4YS9SbDZabDdaQ0ZSSmJ0K01m?=
 =?utf-8?B?b21UVXB5OFNBUkJVMUJUOURGRXpzdCtaTW9SRFE0dm9wQVBtRkVOcllyS3cy?=
 =?utf-8?B?c2REYjJXK3BZODFJVVhuZGlIYnd6SmZxV1IwUU9sVkF0TmN3bmhjcDBlVHRo?=
 =?utf-8?B?aElEZjFCYXlIR1VkT1VvYUM0TkpEZ3lZTkpGKy9oc2hvWEVvRVJvK1F4M1B5?=
 =?utf-8?B?U1pYTkdad2lacUpza2h3Znlwc1FlNXB0WkZmamNVdW9zSlhUVFQ1TGtTZ0tT?=
 =?utf-8?B?M2ZkeWVRc1dreVRja0tNRFVpRUtmRTh6QWVDSThXMUpaejQ2TEg4b01aUW5s?=
 =?utf-8?B?SWxiK2Zmc2tUZjNQWTlTaFMwUWJGcDN1dWE4dUYxS0hBM2c0bll5d1ZpM1J5?=
 =?utf-8?B?SjFKekFIVHl2L09IS2xnN1RkVW12aGkzclFoUGlhaTNoL2ZBakhxSkhGdlo5?=
 =?utf-8?B?NGNmRldOMXdQUGNoRUlseEZaSlZ6ODlab2h1SDFzWGlzOXZBYlRVcFRqS2Vv?=
 =?utf-8?B?a0hpYWRlOVlMbUdtRTdpeDc3Z1lQNS9sSVdQcnN2QXNFMmdKdVNTVm9ldFBr?=
 =?utf-8?B?bXpsY3dWNHdpbEw0Vk0vMzhRSFJHY3A5RjE4eWZacXo0c0tINFhveDY1RTR6?=
 =?utf-8?B?VVBQTkpHZm4zOUQzaWh6VXkwbWxtNkF6T1k5SlJjMFU1Sy90QjE0MTFObTVt?=
 =?utf-8?B?ZEQweGZFQU1LaFUvclhHVGZmckdZZ1lxUEhMdU4wUnlCNjh5eWZwSUJrMWIx?=
 =?utf-8?B?RFBCdVFiYnUxb0ZMOWxxTStzWHdrNUpZKzJJdlAvcEs1RVpNWDRPdExycmhq?=
 =?utf-8?B?RUp3akRicmtqbFU1dHo5OWR3NUtwdk5IVjAvRi95K25NZnVVODJjOWY1YUZv?=
 =?utf-8?B?bng2VDJweDh3ZE9Zdm9QaXBtd1lQdUFvTVR0UkxvYlJVc2JrQkRNWDY5cHJI?=
 =?utf-8?B?b0E4QUsvWWZZdTlGeVdoVDQ1bXUxdnZlQS9MdWRDZjBlOFBYUnYxMzRLcWl3?=
 =?utf-8?B?TThQQnRJdnNVblRiMkxKUXJqNzdTbTg0RTBjbmU4bWNrcFRjOGgxeUxEd05W?=
 =?utf-8?B?Zjc3cFBEeStHbldrdnMrMGNGNExSZFpJVmJibkM2WnJ6T3JzUW84b2lNc2FY?=
 =?utf-8?B?OWlrR05kZllpV0o2TnFFcGxxNkdXSnRCeUpJTUdOOEFMM2tIelE0SXlpSEZw?=
 =?utf-8?B?QzBnQmxETjJGSFFoVitDNDQ0QmhQNTZrSml3SDVWLzJNeHZNVHVrV2dHSkxa?=
 =?utf-8?B?Wk9KTEhzS2h4QmRDQ0VMcjRaYzBhVTAxRXVjUWNmdXNkNHQrRUhMUWNpdkhB?=
 =?utf-8?B?MnBmbitHZjV2UmFBallCdzJJcWxhM2hrczYvWVBOenhWOTNpMkFTRFlZT2Vk?=
 =?utf-8?Q?Bo4R8k4I9+GSZvsCKbj6MuY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D933AB2A29F90D41BD518127A15BBA56@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4565.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ec686f-f07b-4d6c-e6b2-08dae230029d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 02:15:05.6087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7y3XESKSSIyY4Guc759aALngYIluqQ7PCb9c3YWJLR06IJjV5ksvT32aFmr8gSrMTsBQed1Vj5x+PBQlLDUOy8q+dKeKY9aOSgh9R5pVx1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5862
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCk9uIE1vbiwgMjAyMi0xMi0xOSBhdCAxNjozMCArMDEwMCwgTWF0dGhp
YXMgQnJ1Z2dlciB3cm90ZToNCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoISBUaGVyZSBpcyBzb21l
dGhpbmcgdG8gaW1wcm92ZSBwbGVhc2Ugc2VlDQo+IGJlbG93Lg0KPiANCj4gT24gMTkvMTIvMjAy
MiAwMzo0MCwgWGlhbmdzaGVuZyBIb3Ugd3JvdGU6DQo+ID4gQ2hhbmdlIGRlZmF1bHQgcGFnZSBm
b3JtYXQgdG8gc2V0dXAgZGVmYXVsdCBzZXR0aW5nIHNpbmNlIHRoZQ0KPiA+IHNlY3Rvcg0KPiA+
IHNpemUgMTAyNCBvbiBNVDc5ODYgd2lsbCBsZWFkIHRvIHByb2JlIGZhaWwuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogWGlhbmdzaGVuZyBIb3UgPHhpYW5nc2hlbmcuaG91QG1lZGlhdGVrLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc3BpL3NwaS1tdGstc25maS5jIHwgMyArLS0NCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLW10ay1zbmZpLmMgYi9kcml2ZXJzL3Nw
aS9zcGktbXRrLQ0KPiA+IHNuZmkuYw0KPiA+IGluZGV4IGZhODQxMmJhMjBlMi4uNzE5ZmM2ZjUz
YWIxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1tdGstc25maS5jDQo+ID4gKysr
IGIvZHJpdmVycy9zcGkvc3BpLW10ay1zbmZpLmMNCj4gPiBAQCAtMTQzMCw4ICsxNDMwLDcgQEAg
c3RhdGljIGludCBtdGtfc25hbmRfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ICAgDQo+ID4gICAJLy8gc2V0dXAgYW4gaW5pdGlhbCBwYWdlIGZvcm1hdCBmb3Ig
b3BzIG1hdGNoaW5nIHBhZ2VfY2FjaGVfb3ANCj4gPiB0ZW1wbGF0ZQ0KPiA+ICAgCS8vIGJlZm9y
ZSBFQ0MgaXMgY2FsbGVkLg0KPiA+IC0JcmV0ID0gbXRrX3NuYW5kX3NldHVwX3BhZ2VmbXQobXMs
IG1zLT5jYXBzLT5zZWN0b3Jfc2l6ZSwNCj4gPiAtCQkJCSAgICAgIG1zLT5jYXBzLT5zcGFyZV9z
aXplc1swXSk7DQo+ID4gKwlyZXQgPSBtdGtfc25hbmRfc2V0dXBfcGFnZWZtdChtcywgU1pfMkss
IFNaXzY0KTsNCj4gDQo+IENvdWxkbid0IHlvdSBqdXN0IHNldCBzZWN0b3Jfc2l6ZSBpbiBtdDc5
ODZfc25hbmRfY2Fwcz8NCg0KVGhlIGZ1bmN0aW9uIG10a19zbmFuZF9zZXR1cF9wYWdlZm10IG5l
ZWQgdXNlIHBhZ2UgYW5kIE9PQiBzaXplIG9mIE5BTkQNCmRldmljZSB0byBzZXR1cCBwYWdlZm10
Lg0KVGhlIGNvbnRyb2xsZXIgcGFnZSBzaXplIGNhbiBzdXBwb3J0IDUxMi8xay8yay80ay4uLiwg
dGhlIHNlY3RvciBzaXplDQoxayBoYXZlIGJlZW4gc2V0IGluIG10Nzk4Nl9zbmFuZF9jYXBzLiBI
b3dldmVyIHRoaXMgd2lsbCBhbHNvIGxlYWQgdG8NCmZhaWwgaW4gdGhpcyBmdW5jdGlvbiBzaW5j
ZSB0aGUgMWsgcGFnZSBzaXplIHdpbGwgbm90IGJlIHN1cHBvcnRlZC4NCkp1c3QgdXNlIHBhZ2Ug
c2l6ZSAyayBhbmQgT09CIHNpemUgNjQgYXMgZGVmYXVsdCBwYXJhbWV0ZXIgc2luY2UgdGhpcw0K
Y2FuIGJlIHN1cHBvcnRlZCBieSBhbGwgSUNzIHdpdGggdGhpcyBjb250cm9sbGVyLg0KDQpUaGFu
a3MNClhpYW5nc2hlbmcgSG91DQo=
