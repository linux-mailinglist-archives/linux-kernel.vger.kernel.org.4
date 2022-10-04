Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318255F408F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiJDKIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJDKIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:08:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECED27B3F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:08:32 -0700 (PDT)
X-UUID: 0b26ec96ae404ef99cf78e9162e5855f-20221004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MrKwzreO828uITqB6oTcq1Vlnjzw98XkV0MUrnOLvik=;
        b=Yf98kJJtmI9RcZ1Elx2iSgOEP7Hrw2XlEaz/8fxx6M6P2PFBjXQfw3L3lS3GY7or8WplMvhONFfEPlUo2WLr4gRvp5UjlvRoUhO1BVJlGiIaUHtdy9zGexeIa23QVHpfSELRDTIrK9hQeV/YubRL1UJuvFz4JLTVaoRgbDjOb2Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:fa769b86-db7c-4bf8-a0df-da02587d9916,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.11,REQID:fa769b86-db7c-4bf8-a0df-da02587d9916,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:45add269-c578-4abf-baf4-d93ecc5e701f,B
        ulkID:221003120041V1HGKMWL,BulkQuantity:205,Recheck:0,SF:38|17|19|102,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 0b26ec96ae404ef99cf78e9162e5855f-20221004
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1524259918; Tue, 04 Oct 2022 18:08:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 4 Oct 2022 18:08:25 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 4 Oct 2022 18:08:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7PU6qTvH/+G3EqElhBYM5NA7x22A1goJsuymdNHpcZBC3PXRBjDr+a1+RtD7JxD2yYHxsUQG507WhHLyYf7ci7eTILWm5YI5qhL5YqHyuKmdBN4Oe3QPcnjt/fK/KvApbtL4Sz4L025EMkPsL0kNkBQ+qX4dbVir40l2tsd4ncMgbodU9GFrYSWdRQXKEroeNxgMy6NB4EzTiSjjb/ox10kwh3GTT50hbxRpgTl3LJyK5/nFBxRa5A6KP+9pZTw0h/vBLSZtxaPRuTotkrp4l8WJCTGADTj5Ah/XRyCsGhQKsspGfrCWQ1idQLeLNrzHg/3kHtv1G0eyS+bNVue6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrKwzreO828uITqB6oTcq1Vlnjzw98XkV0MUrnOLvik=;
 b=Z8oc4aNvgmfPmRDWM1E8IvAx/ZZUTkv7rdfWFGFWvfu+vqEH5VKkMDkpUoIWBuB/xI5l1Oekmlido0u9U+RmfOv7tvbgQRz6dFABAgWnXB5ku62tOLKY1zLuN+/VZWl2kb/jkJgo1sDk2E16nTr+DYSpzMky/2seJnP8H2UWaBCiXbrwBtuJ3u9AVS2DzqYsY/engytIFNH+DhQClUOxg01sD9sIpCDIvjj4BabFHo+mnKLga0MlGgInbCDwX4eRabdQluZqTnUEaACrqMKgeAJdzPGKqcj7ujCOVA9lcx0hva8+ARJ4FHjP5FoHG3+5ho0IBSEgODrXXXwBW0gSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrKwzreO828uITqB6oTcq1Vlnjzw98XkV0MUrnOLvik=;
 b=JyGFTeQkkW/ZvKxOvuSAbpuKk+Wpyu87u7Rj0oO57Z12GyYjJZK6Fe4eA9u5q+AGSg5rWc6GgBOEHSI+/CxZpybEMYp2D17JApCVXh4oFxM8l7RsNC8Pi6J+PoiJxXJroSs71yJZ/7+P71GYQdLNHGuZpNO6y61npP9fLxXmEtc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.8; Tue, 4 Oct
 2022 10:08:22 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed%8]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 10:08:21 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>
Subject: Re: [PATCH v8, 1/4] mailbox: mtk-cmdq: add gce software ddr enable
 private data
Thread-Topic: [PATCH v8, 1/4] mailbox: mtk-cmdq: add gce software ddr enable
 private data
Thread-Index: AQHY1ObPx+txU1VQPkeXIrGkp8wdoa38D4MAgAHwCwCAAAkZAA==
Date:   Tue, 4 Oct 2022 10:08:21 +0000
Message-ID: <d3682cab8685f25cdb2bee4b54c6cc71067a1e9c.camel@mediatek.com>
References: <20220930160638.7588-1-yongqiang.niu@mediatek.com>
         <20220930160638.7588-2-yongqiang.niu@mediatek.com>
         <ec6f3ea90c3386c55d2894f79c117d9ac508a20d.camel@mediatek.com>
         <38f315581afa8b42113a931a9009b0688a226bbe.camel@mediatek.com>
In-Reply-To: <38f315581afa8b42113a931a9009b0688a226bbe.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB5545:EE_
x-ms-office365-filtering-correlation-id: d571e7ca-d37c-4d5b-d63d-08daa5f05e1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z/IkLOucy6U9u8Y/+2fK25ECRnjSXOdA9xbQCGqjJDDo/wx+dVxbhj7CjOj6GNAKD7pI+KQXoozlWIu4BQpdo5EoRXE+GNNR+z9697HMWwMS+xMfB0fi1iKa5RCU8tUeet2ry/m1x5yf6bYVV6u90SDgNE4q/9qIZwZ/Id53iyjlKJF8lOMMbLp8BB/90FpSa2IGwYABW8ZZk7eouzWdCrXSnI/3nolRuxvgNq4mu5Mlejy6FJtPuiUYlsz6JjClI1567nqdDjfSVIc8j+KrYCgVN6KiAgFxu9DrbGJeq+n28FHv1+Hbpp6NOkiUx7265Xa9Rrv91Y4nAqvSQJINSv3kcdS5diQoAwGwlBpXy41zqcqbfqwI7wcuMX5hp62ydxPu+zfxDf7uTyMh8obwhxEDf1Mh6s6/+MVfVU958M2awhmlDQGYmIX1BLdY0xSt15R5oiUt0hJ9Gtnyzk0dah2YETZ5evTekXKtvWVTfH/3Zs4k+3MclK6cFjJxAuJE5tNDuHb9EmgxLbha6k/6jHhod9XQftRd9eruhlqivQz2qslEZ1O4g7quQkIkuc9b87dvG+HWDR7YTmCCg0PLAuN1NtmfA0+LBGWjKoP+7XyN4wFYhWUkwsi14W5zkxhpGOKqdOokAVziysmAm+Lmwil+FsvmKcZHmZxhqXUQTFIp9fIBwMcGi/vIB3Vu/17SrmEv40ssAaPHtOvRUqg9dFxVv/1sd8PnXTL2u88Q327phEct7CI1zQ7u5iTA28h7cLBgOKjzsMX9zECLNK6PZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199015)(8936002)(5660300002)(15650500001)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(41300700001)(4326008)(316002)(8676002)(54906003)(36756003)(110136005)(85182001)(2906002)(83380400001)(2616005)(122000001)(186003)(38100700002)(71200400001)(478600001)(6486002)(86362001)(38070700005)(6506007)(26005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXpKRUNUWmJBRlFNU2xwS082N1drSEFlV1E3TGJEQ29SaFlzS0RBU2tXaEM4?=
 =?utf-8?B?L3NCcUFKSkpRcmVpNlhVbTlCcmxUZEM2NDZPMitCUnNmRjVjZEl5ME56Zllv?=
 =?utf-8?B?cVFTNldJa2hmVXZ2UzFGOW9TN2JvR3VESG1Wc1dVWVliM0FrMGdQOUMwemlM?=
 =?utf-8?B?OW5sZVhEZjB2SEVKWGY3eWdEcjdIdXEvdC91V1RQeDJwZUtUM21XcU9aL0dP?=
 =?utf-8?B?UkxYUG1JVjlMMExuQXUzV1JvcGh6cWdOeGlKL01QdEIxUVEvSm52STVGS1RZ?=
 =?utf-8?B?VFJ2blVyRU0rTHZHK3MxZFBPK24wSWpoZ3RHc2t1OUFzV2hjSnZCZDE1RWRu?=
 =?utf-8?B?V1g3TTBFZTBpRUpTYmdOa05qcXdZMS9hNUtYRENqZ1VRdXgrei8wQTdzcnNy?=
 =?utf-8?B?b2pHd1NxTkNud1d5SWZ4M2hwTDlBNXJqWFJ3YkFpRHdBaE5vMWNNcXpPMzZX?=
 =?utf-8?B?dmtLdXpKQ2hHUVQ5ZTUxT2trK2gvY3J0cXFpcWgwZWZpc0J1UllFNmk1Rmpv?=
 =?utf-8?B?MGFsdVZkNmpFQS9hSHlQbVhHVk9UYnN1eWNPWTA1ZC9zci9NbnZLclJvNjdT?=
 =?utf-8?B?RytnKzBxcGZaYXA4NXBKbERTUGozZXhFK2JFUDRwb3Z3RDVsWjhCbm10bmFC?=
 =?utf-8?B?cy9FdVhJNzFvcEVndXVPczdsalpHcDQweXdUUWxYcjNWN0hwSnhnV2YySmw2?=
 =?utf-8?B?OFpUWEk2MkxJUUUreXpzS1Q5MFkzZW9BUmRjWkRhTGNJbitQMkI0MnBWVE9G?=
 =?utf-8?B?bEs5dzdCeVNDendkRzcyUzg0Mkw1YUI0NXlzN2dUYWtIOUtvN1pLRE55OWZK?=
 =?utf-8?B?RmhScHA4UDZMUkVJV1pqMnMvTHN6OGJpMnJUeG5TM1JuWnl5RXhZVUxOR2dK?=
 =?utf-8?B?MjdsMjltQkhsNkdpZHF4ZmJsN1J3emd2bFhIa2tFUXJuMFhETWZRL0VZUUlu?=
 =?utf-8?B?WHVXK0tRaFFIU3dzNFhDQzlWRlNKK1ZlS3h1SysxQitUOU9lTkZYVHl0Mjl4?=
 =?utf-8?B?SWtlbStEVGo0K3U4MVVNVGZEdkkreTJ3MHh3SmZuSDduckovU3lGUkRaZ1NZ?=
 =?utf-8?B?UHdpTVRpM3J2NnpxYjZKMjRzWXdNUTk1d1B2bW5MSVFMbEY4YVlNVXpEeWVG?=
 =?utf-8?B?NDdPNGFXb3ZQRDFMajVrVHZxZjhjZENhTnUwOVpQYnlVNVptOTFCaVpBRk1I?=
 =?utf-8?B?cCtjTTFkd1JjbzNSQmFqUkJmemFNOW1BaXJQQ0JzeEY0RnNHS3puVy9BM0ZZ?=
 =?utf-8?B?Y0tsYXhNWCt5TmlIRjFTLzhSWDRUM2E4UE9iQkk5VmYrR3FEazIybTQ5amIw?=
 =?utf-8?B?U0xUNjl4NDJWYUpITjhGUXhXcWhtWXhOa1lla2lIS2h1ZkliR3dBcVd4UGQ2?=
 =?utf-8?B?OHlaRXpZaWtiRWs2VklmTHNIWnBaU3RldVJ4UFZndVhrbDRMeW9NOE42V081?=
 =?utf-8?B?MkRJbFlURGRGS052RENBVUgxOFRwL0RPYWkwTG1IcjZrcmZMQTVRZmVFMGUx?=
 =?utf-8?B?WmZaeFhJek16N2ZVYTRPaWhFMVArcElPaHprcy9wQm8zTlRiZ3pDQ3ZCSnVF?=
 =?utf-8?B?YWdqS3hXRWVmV1FUWDZGY1J3dHM3K1FYdjUrQVFRNXZuVkJQRjY0T2h3cEJa?=
 =?utf-8?B?eDd3MUZlVjNvcVRXUmJlWVBxUlJ2aTlUMjlTdGtrWkJKQUhMeVVTY0U0QjNK?=
 =?utf-8?B?M0MrQ2s5S0p4MDFzdWNZcFE1KzRnWW9LY25IRWU2TTlPcjkwYklsR0g0TlBJ?=
 =?utf-8?B?VnVRcm9HYVJCa0UvRkVPemhsVkdrVVM5aFVJS0VyS2ltNVhTQWJQQmlDNVR1?=
 =?utf-8?B?dFU5QmNQeE13REJ3ZmFDbE5CRkRkQ3FwdzhhOWdCNVQycDFqSFZtdFF2MTR5?=
 =?utf-8?B?QjIwd0NpWmNJcVQ5TGlhamhYekhsYjFYdzBQenUyKzVTWnprbDZDOUpqTjZz?=
 =?utf-8?B?OVFjM2VONG1PUTM2aEp0OGhXTmRYOE5zS21XL2VkSytJQlRCMllaclYrbzRH?=
 =?utf-8?B?YnYxVVYxdnVDUmRQODNFcmNqbEo2akxpSVlJTXU1VDVJRHBqODFUUTlSNDha?=
 =?utf-8?B?ZFVqNlZWUERiOU5yb3JYKyt2bEw3QmtxUVUxMFJUcHpENVdtZEpoYk9hSVZo?=
 =?utf-8?Q?lTU3PmTQN/CMzLN1TojNt+5W3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43A43F3308AB314BBCFF94A7983BE509@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d571e7ca-d37c-4d5b-d63d-08daa5f05e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 10:08:21.6003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJqloR99TCP9ax/P85Ei+yrHbDbVY8pn9guveNEW10SK+27iuhhbHk/NYzkJb0uc0angVbehtwI3xqHk5cC8PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5545
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gVHVlLCAyMDIyLTEwLTA0IGF0IDE3OjM1ICswODAwLCB5b25n
cWlhbmcubml1IHdyb3RlOg0KPiBPbiBNb24sIDIwMjItMTAtMDMgYXQgMTI6MDAgKzA4MDAsIENL
IEh1ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiA+IEhpLCBZb25ncWlhbmc6DQo+ID4gDQo+ID4gT24g
U2F0LCAyMDIyLTEwLTAxIGF0IDAwOjA2ICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0KPiA+
ID4gaWYgZ2NlIHdvcmsgY29udHJvbCBieSBzb2Z0d2FyZSwgd2UgbmVlZCBzZXQgc29mdHdhcmUg
ZW5hYmxlDQo+ID4gPiBmb3IgTVQ4MTg2IFNvYw0KPiA+ID4gDQo+ID4gPiB0aGVyZSBpcyBhIGhh
bmRzaGFrZSBmbG93IGJldHdlZW4gZ2NlIGFuZCBkZHIgaGFyZHdhcmUsDQo+ID4gPiBpZiBub3Qg
c2V0IGRkciBlbmFibGUgZmxhZyBvZiBnY2UsIGRkciB3aWxsIGZhbGwgaW50byBpZGxlDQo+ID4g
PiBtb2RlLCB0aGVuIGdjZSBpbnN0cnVjdGlvbnMgd2lsbCBub3QgcHJvY2VzcyBkb25lLg0KPiA+
ID4gd2UgbmVlZCBzZXQgdGhpcyBmbGFnIG9mIGdjZSB0byB0ZWxsIGRkciB3aGVuIGdjZSBpcyBp
ZGxlIG9yIGJ1c3kNCj4gPiA+IGNvbnRyb2xsZWQgYnkgc29mdHdhcmUgZmxvdy4NCj4gPiA+IA0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRl
ay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5jIHwgOSArKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
DQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFp
bGJveC5jDQo+ID4gPiBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiA+
IGluZGV4IDk0NjVmOTA4MTUxNS4uODhkYjZiNDY0MmRiIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJp
dmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gKysrIGIvZHJpdmVycy9tYWls
Ym94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gQEAgLTM4LDYgKzM4LDggQEANCj4gPiA+ICAj
ZGVmaW5lIENNRFFfVEhSX1BSSU9SSVRZCQkweDQwDQo+ID4gPiAgDQo+ID4gPiAgI2RlZmluZSBH
Q0VfR0NUTF9WQUxVRQkJCTB4NDgNCj4gPiA+ICsjZGVmaW5lIEdDRV9DVFJMX0JZX1NXCQkJCUdF
Tk1BU0soMiwgMCkNCj4gPiA+ICsjZGVmaW5lIEdDRV9ERFJfRU4JCQkJR0VOTUFTSygxOCwgMTYp
DQo+ID4gPiAgDQo+ID4gPiAgI2RlZmluZSBDTURRX1RIUl9BQ1RJVkVfU0xPVF9DWUNMRVMJMHgz
MjAwDQo+ID4gPiAgI2RlZmluZSBDTURRX1RIUl9FTkFCTEVECQkweDENCj4gPiA+IEBAIC04MCw2
ICs4Miw3IEBAIHN0cnVjdCBjbWRxIHsNCj4gPiA+ICAJYm9vbAkJCXN1c3BlbmRlZDsNCj4gPiA+
ICAJdTgJCQlzaGlmdF9wYTsNCj4gPiA+ICAJYm9vbAkJCWNvbnRyb2xfYnlfc3c7DQo+ID4gPiAr
CWJvb2wJCQlzd19kZHJfZW47DQo+ID4gPiAgCXUzMgkJCWdjZV9udW07DQo+ID4gPiAgfTsNCj4g
PiA+ICANCj4gPiA+IEBAIC04Nyw2ICs5MCw3IEBAIHN0cnVjdCBnY2VfcGxhdCB7DQo+ID4gPiAg
CXUzMiB0aHJlYWRfbnI7DQo+ID4gPiAgCXU4IHNoaWZ0Ow0KPiA+ID4gIAlib29sIGNvbnRyb2xf
Ynlfc3c7DQo+ID4gPiArCWJvb2wgc3dfZGRyX2VuOw0KPiA+ID4gIAl1MzIgZ2NlX251bTsNCj4g
PiA+ICB9Ow0KPiA+ID4gIA0KPiA+ID4gQEAgLTEzMCw2ICsxMzQsMTAgQEAgc3RhdGljIHZvaWQg
Y21kcV9pbml0KHN0cnVjdCBjbWRxICpjbWRxKQ0KPiA+ID4gIAlXQVJOX09OKGNsa19idWxrX2Vu
YWJsZShjbWRxLT5nY2VfbnVtLCBjbWRxLT5jbG9ja3MpKTsNCj4gPiA+ICAJaWYgKGNtZHEtPmNv
bnRyb2xfYnlfc3cpDQo+ID4gPiAgCQl3cml0ZWwoMHg3LCBjbWRxLT5iYXNlICsgR0NFX0dDVExf
VkFMVUUpOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoY21kcS0+c3dfZGRyX2VuKQ0KPiA+ID4gKwkJ
d3JpdGVsKEdDRV9ERFJfRU4gfCBHQ0VfQ1RSTF9CWV9TVywgY21kcS0+YmFzZSArDQo+ID4gPiBH
Q0VfR0NUTF9WQUxVRSk7DQo+ID4gDQo+ID4gSSB0aGluayAweDQ4WzE4OjE2XTB4NDhbMjowXSBh
bmQgMHg0OFsyOjBdIGNvbnRyb2wgZGlmZmVyZW50IHRoaW5ncw0KPiA+IGFuZCBmaXgNCj4gPiBk
aWZmZXJlbnQgcHJvYmxlbS4gU28gZm9yIHRoaXMgcGF0Y2gsIHlvdSBzaG91bGQganVzdCBjb250
cm9sDQo+ID4gMHg0OFsxODoxNl0gYW5kIHRoZSBjb2RlIHdvdWxkIGJlOg0KPiA+IA0KPiA+IGlm
IChjbWRxLT5zd19kZHJfZW4pIHsNCj4gPiAJcmVnID0gcmVhZGwoY21kcS0+YmFzZSArIEdDRV9H
Q1RMX1ZBTFVFKTsNCj4gPiAJcmVnIHw9IEdDRV9ERFJfRU47DQo+ID4gCXdyaXRlbChyZWcsIGNt
ZHEtPmJhc2UgKyBHQ0VfR0NUTF9WQUxVRSk7DQo+ID4gfQ0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+
ID4gQ0sNCj4gDQo+IDB4NDhbMjowXSBtZWFucyBjb250cm9sIGJ5IHNvZnR3YXJlDQo+IDB4NDhb
MTg6MTZdIG1lYW5zIGRkciBlbmFibGUgDQo+IDB4NDhbMjowXSBpcyBwcmUtY29uZGl0aW9uIG9m
IDB4NDhbMTg6MTZdLg0KPiBpZiB3ZSB3YW50IHNldCAweDQ4WzE4OjE2XSBkZHIgZW5hYmxlLCAw
eDQ4WzI6MF0gbXVzdCBiZSBzZXQgYXQgc2FtZQ0KPiB0aW1lLg0KDQpPSywgYWRkIGNvbW1lbnQg
Zm9yIHRoaXMuDQoNCj4gDQo+IA0KPiA+IA0KPiA+ID4gKw0KPiA+ID4gIAl3cml0ZWwoQ01EUV9U
SFJfQUNUSVZFX1NMT1RfQ1lDTEVTLCBjbWRxLT5iYXNlICsNCj4gPiA+IENNRFFfVEhSX1NMT1Rf
Q1lDTEVTKTsNCj4gPiA+ICAJZm9yIChpID0gMDsgaSA8PSBDTURRX01BWF9FVkVOVDsgaSsrKQ0K
PiA+ID4gIAkJd3JpdGVsKGksIGNtZHEtPmJhc2UgKyBDTURRX1NZTkNfVE9LRU5fVVBEQVRFKTsN
Cj4gPiA+IEBAIC01NDMsNiArNTUxLDcgQEAgc3RhdGljIGludCBjbWRxX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UNCj4gPiA+ICpwZGV2KQ0KPiA+ID4gIAljbWRxLT50aHJlYWRfbnIgPSBw
bGF0X2RhdGEtPnRocmVhZF9ucjsNCj4gPiA+ICAJY21kcS0+c2hpZnRfcGEgPSBwbGF0X2RhdGEt
PnNoaWZ0Ow0KPiA+ID4gIAljbWRxLT5jb250cm9sX2J5X3N3ID0gcGxhdF9kYXRhLT5jb250cm9s
X2J5X3N3Ow0KPiA+ID4gKwljbWRxLT5zd19kZHJfZW4gPSBwbGF0X2RhdGEtPnN3X2Rkcl9lbjsN
Cj4gPiA+ICAJY21kcS0+Z2NlX251bSA9IHBsYXRfZGF0YS0+Z2NlX251bTsNCj4gPiA+ICAJY21k
cS0+aXJxX21hc2sgPSBHRU5NQVNLKGNtZHEtPnRocmVhZF9uciAtIDEsIDApOw0KPiA+ID4gIAll
cnIgPSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgY21kcS0+aXJxLCBjbWRxX2lycV9oYW5kbGVyLA0K
PiA+ID4gSVJRRl9TSEFSRUQsDQo+IA0KPiANCg==
