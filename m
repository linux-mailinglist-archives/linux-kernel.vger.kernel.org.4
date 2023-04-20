Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B736E8A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjDTGZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjDTGZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:25:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A0649DF;
        Wed, 19 Apr 2023 23:25:30 -0700 (PDT)
X-UUID: 2162512cdf4411eda9a90f0bb45854f4-20230420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3E2993OGHH5/hCEWLpYLE8wy7SHVvyfQz5Jxb9I/Oi0=;
        b=jXVzuUVtulm+l6AD+2fg7g93oLUZAyO5BSSNaxSl7UrR/4mDuC8un1Sl17JAobL16puAXLIVT6a5Y3mGbuqHLg2XyHI7izgh/g/iTMlFJ4+v8b2GvYxo/MEcJQ/GNNku8MVmJA0t55wPFGu+Pc4ETs7HyvagLyGXGGaLXBouimw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:04392907-5a41-4245-ba1a-e5dd11bfee69,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:304cf1a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 2162512cdf4411eda9a90f0bb45854f4-20230420
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 213163674; Thu, 20 Apr 2023 14:25:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 20 Apr 2023 14:25:21 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 20 Apr 2023 14:25:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAoFBwjxebR3oCSlN0IjMVOwp7Zz7I9DhwZ/iws6u9DE8+QTNM01BNXvm+ewY0cFq4oxvB101/NoqaPo8uTj26N5TemtHk00rEkXBBzBMu9t7dN8AyURYXgDV9/ANFSLf79NUkbLGiBkRxbxA1wXNd3b83wdffvMgHdD/toEO7a9OXnxz1qq0dVwJy4OwQXVEsK/gUfVWdJ/XXpU6PseqjGWb8aG1q9Xf5zmESUVQj8f9W39a6LSaJExMx8wsQBFvV4WDv8DO1VuiZSfclj8xikHCisTNG6bsbPxp/gq1/VJjo27A6OyflhFpl2v1M3sM1/eaMmHB5P1awb9ltKMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E2993OGHH5/hCEWLpYLE8wy7SHVvyfQz5Jxb9I/Oi0=;
 b=gnlpMdSw8hFcZSQ+Zf1TlYcbUQX0A8QgO4Ds0FgPdKockEQxRSMYqJ2UF40pck6c2wD9RK90oQi6+jNpi14kH10VMwFlgU9Fdo/QUx5nv0woNefwsX0S1bGukPzRAjWnP2pewD3gyJC4kVARCvuvCk0Z0Xcr0B/Ejd8cLv/pdcK1Sb0BxEgSPKtkf/0Ayxk5Q6RtRhkWfnCorav7fSaQR0GaKhxuqMkbUpOT47sIK969wIv3/005CHiITW9w0YNZPQaEzbgm9B6vP7hhqFZz55X6j5PkRO9nkOIMoMA3BiOZRP6gLP/PLVWNQzg3zx5pePMtHW9tEhWEeATf4n9nQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E2993OGHH5/hCEWLpYLE8wy7SHVvyfQz5Jxb9I/Oi0=;
 b=OHEB3GlgBxydiaRn8h3zRoEN5JyUmKIMfF1UxUgQxfy/To2N+qQ2i8+/e9Yr2AXJnxfcAYD7Wo1tUixQqdCUrJFApn9kp2loVnbTmjyD2xyS7Uhy40l2elq+5qg5aHiw9aUJHZ3rNP7zmp3kHJ0We2u2OwgLAiVA5HIPm47VTJs=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SEZPR03MB6594.apcprd03.prod.outlook.com (2603:1096:101:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Thu, 20 Apr
 2023 06:25:16 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 06:25:16 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Thread-Topic: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Thread-Index: AQHZbfV6H4OsAA5wEEW0uLoJpPACoq8sFaCAgAK7jICAAFbNAIABu8qAgAAh9YCAAsAZgA==
Date:   Thu, 20 Apr 2023 06:25:16 +0000
Message-ID: <f7b1e54804317616f964d669425a247edc0f21eb.camel@mediatek.com>
References: <20230413104713.7174-1-trevor.wu@mediatek.com>
         <20230413104713.7174-8-trevor.wu@mediatek.com>
         <310e8979-de96-dda8-6c95-0e6033d8b403@linaro.org>
         <b9daeea6d823b8e84db0ca0df0e04d3716a6b944.camel@mediatek.com>
         <382bc15e-f4e3-3a9f-9dbc-4d46ac1d76d6@collabora.com>
         <3fe703c1279bf4d25a890b63c23a4bc97abd4198.camel@mediatek.com>
         <47f27da1-8ed1-327e-74d7-ad4e3f12e3d6@linaro.org>
In-Reply-To: <47f27da1-8ed1-327e-74d7-ad4e3f12e3d6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SEZPR03MB6594:EE_
x-ms-office365-filtering-correlation-id: c121e0fa-e4de-4060-6f67-08db416801b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7qgZil+F4HZxS60q8oKX5IdwA2Yjd7lgoBxUpEMPRkOaP1ocD3l9p7DgEa0qD536oi/gSxYMij8EeGKaY6q6nuLyjQfRbY98Ls7PCHORgYtHOyyXrXj7TgIdFvM0N88Dzq5EzufWwcgXLoSp6Qn3GwX6ExYF5Gd4BI94wprMYLkihpXMhP7yhKe0MXJlGl8g5LRs8cUeCfcNy9M7ikg4KfcnOYfIXwRCi2UwyhQ/t+4OYGg8leirXbubYIevsm5nq56dM2eGrICWdgHHYHVjWsk4eqd7z9YQXMA28liNK7i85gL5Nw+iSA9KE12STiKrfz2BtkH5klgwJ1nWyuIvOMykc+SAOJ9qZ0qO6Zm7gL5tq8zFuHyf29NcFIYoSm6TlmlEmCUuOXjfFuM/Fji+wxEe53l6Ur/mKLcaIKm9espOVMbh32N5c0LGXB7QItL5HLCi4QYcXO4wbIFgZ0jc6NscixRPETmk1JLFK8VTUJquQt62TFmSvKyIOLJg4RUExowwD1hNgXRb781TD/+FzD1Kuo68wMvk5XIg5NET4jHjotv7hJ4LB/Jmrjc8+W+MXFHVB+Vab/ROFjbwEzungX57W2zdgoXa9UuDZfbzUNUuZr7oV0TZyOBpuzZrw6eFs3bORT5Ds1Ihe4mIPuF8ioIFb27RZ2gaXkyF0AxIea16p9yhqley3KZg7L/xpN0H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(6486002)(478600001)(110136005)(86362001)(71200400001)(36756003)(2616005)(83380400001)(85182001)(186003)(6506007)(53546011)(26005)(38100700002)(38070700005)(6512007)(122000001)(64756008)(316002)(66446008)(66476007)(66556008)(66946007)(2906002)(76116006)(91956017)(8936002)(7416002)(8676002)(5660300002)(41300700001)(4326008)(54906003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1F0L0RzMzNWS3VValgyU3V6L1NLbCtFVng0dnJMd2VQa3dGakI5TUZHU0JC?=
 =?utf-8?B?Zjh4Tkh5d0tLQy9veHVXL3l2dE8vMjhyUS9OS3ZnQ05jNmVGV0hGcnpmWmxu?=
 =?utf-8?B?VG9nQVdram1Qb0pHQXZwK2taeHk3TUpCSDhsVkhvd2U5ZW5jTkwxbzdwdHU4?=
 =?utf-8?B?eW10c3M4bnlDZmxybjNLdkp1cE1OM3NuUmRoOGxYSzUvRXI1dkpwdXJ5bktG?=
 =?utf-8?B?WTBqR1JCWkNrTFEweUF4OG5KRUJldlZtTHFXN1A3c01IOWhnUDVycGhvWm5M?=
 =?utf-8?B?YWZHWEJoNCsvdkRyTWIvRTAzbXcrcWk4bmp4TmZEbFgwYlI1L08veFl3WXI1?=
 =?utf-8?B?V0tsL2NjdmtDbDI2RS85YVBJTlBvZFVaUXhERXFyNmtuTzR3NGluWklyem84?=
 =?utf-8?B?Tlh4OWZ5a3VORTZZZ0tLOUNpclByQnNTbENNSzNZaVIzMTU3ZUllVWVmN0xr?=
 =?utf-8?B?UmJQWmZpUWpxcjlMY2l6WjBucThwZk5kcjEvbW1OaVJrMVZGMXEyMGcxSm8r?=
 =?utf-8?B?aUpkeGNCTUJCYkJnS3pjS0RFcTRYa1hwenlaNFg0bTk4U2QxN2FLTjdQcTZo?=
 =?utf-8?B?cTh4MkZpR0hidmdWV3lmS1V5eEZ3Y1FSSkpFL0ljSEdmNXZCZjY1NTgxeUg1?=
 =?utf-8?B?VmpLSnpnOVZWQjdKYWtyeWtMMzRDRjJKOEJINWlCdTQ1Z2dYVStRUENCSmsx?=
 =?utf-8?B?N0FYQzMybFp0SVpEQkg1QThJMSt1UFdWQkpJT1pVbWRqVWFXbHpqQlFiNHd2?=
 =?utf-8?B?dDJDSHFqV2hJcGxOdi96QlArSWRFTGJVYUpiTzl2NmpRL1FCcldTdWNKaGov?=
 =?utf-8?B?ektaR3BvNnlSUlVhUVo4bHE0aDdhUnVIdkMvclUvc2VqNEpSd01CTC8xNkM2?=
 =?utf-8?B?RmNacUV4Sk9iN3pmMU5Qd2w3TkZWYmwwTDlXTGhlVUoydjJUK1UzRG9wdHk2?=
 =?utf-8?B?aUR0QWVZOVhvaDlnRE10MkRvTzdnUVpKV2N1UzRvQzJrVzdnRXFDR05STTRw?=
 =?utf-8?B?NmVEZkxxRnoyQTdweDY3RUE3dEw1MlR2bkhLUEFLbTBIKzhjcDBDb2FmeUNn?=
 =?utf-8?B?KzR1TWpJMGJqc2RzaVZHLzAxZEVsWmRZMkJ4WDZsRDBqR0NTK3Q5ZUk0UXRa?=
 =?utf-8?B?YnQ1OVJPakFHSkNNUDBBNUpHOEN3cUhqYTNqcnE1bHMzMUxUKzlIb1A3K3hF?=
 =?utf-8?B?YzJnQkMyQTlKOXJMN0tJdzFBOWpGb284RXFaZDAvN3czeUpCT0Jhb2xFTk1m?=
 =?utf-8?B?S2xzN3lQbTBOb2tkczhoWlBqdWlBMXhGem52UXZ6aVdIajNPSVZMZ2lpMHJx?=
 =?utf-8?B?VWh0bTJTVUM4ZmdaS2NCRHNPUGpuUkhqV3lkemk1a3NRZEpILzlCYlF4aHox?=
 =?utf-8?B?UWYybWZSaEgzWG91Y29BbmdxQlBSV3l0U3JydDlpSEkzaklsdzFmRGhpZGJL?=
 =?utf-8?B?b0VBNGNDb1QyUFFSbGJncHJRdU52YkV3K2Q3R2FaWC9MSlhwQ0o1djdyaEts?=
 =?utf-8?B?S3orMEl4OC92NGFXYVVSQXB6U1hQUDVzNVIwU2w3NUFPU3dhc0thSjByRHFH?=
 =?utf-8?B?ZS80aXpzNU5jN1VsUVEwZEtVZmQ4ZEtZV2x5L0pZc2IvekJ5K3NqMTJQVzhy?=
 =?utf-8?B?SjVOeVVVbGpEVTVTTG1qL0xrS0U2aldjL2VteS83TDE0NHl6WXVaQVBCUVAv?=
 =?utf-8?B?ZHlZK2tUVDZIbUthQXdRaFZ4K2d5UFcvUjhESkozM0V6QThNQjd1Rk00V2x5?=
 =?utf-8?B?ODlucjdXUlB3dzR5R2JFcDludm5GelpSSkxlZmNFRytwSXJUZHUxUWgvNmFu?=
 =?utf-8?B?S0lvWDkxSDNCRUZRYy9vNG8xNTJndnp3NjhWemFIcDYrZlJpUHZHem9YeHov?=
 =?utf-8?B?bitqOFlCWHFEbmM4R1VDdng4UklZN0hyT3N3THhuUjQwUGRqb2NQa3hnb0o3?=
 =?utf-8?B?NzJMZHU1VnhYOE01aVpOMFQ5dXdJd3Z0NVR6ZGxSN1ZlYUk1TFVsUGNpSUlJ?=
 =?utf-8?B?cDN3bDBaY0lBSS9PUnNvQUU1WHZEaHZUMzk5OGxGQ25VcFhNZmNUMWdDcVIw?=
 =?utf-8?B?UmtRZmtXNXFmVG1qbHRZMkNHd0hmOGpMaVdid08rc2NmWjcyZ2tuNDhkZi9M?=
 =?utf-8?B?YWcwMkRFaW1KVkpNNVF4TWYvRU5BMGsweTAvQ1R4NGZRNHVqUUl2YVFwTGNV?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <616D6AE90FF665458CF404DCF1A8EE11@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c121e0fa-e4de-4060-6f67-08db416801b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 06:25:16.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YupSJSl9PlkGWdaMGjaIQLMH6ZreUoEZ19XZ2C+MiBAbLe7MJWxzLm+Zpi+rYprgj4FKEdyKNjGd+ze6LuvUVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6594
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA0LTE4IGF0IDE0OjI1ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxOC8wNC8yMDIzIDEyOjIzLCBUcmV2b3IgV3UgKOWQs+aWh+iJrykgd3JvdGU6
DQo+ID4gPiBBY3R1YWxseSwgZG9pbmcgdGhhdCBpcyBib3JkZXJsaW5lLW9rLi4uIHRoZXJlJ3Mg
bm8gZGV2aWNldHJlZQ0KPiA+ID4gZm9yDQo+ID4gPiBNVDgxODgNCj4gPiA+IHVwc3RyZWFtLCBz
byB0aGF0J3Mgbm90IGJyZWFraW5nIGFueXRoaW5nIGF0IGFsbC4NCj4gPiA+IEluIGFueSBjYXNl
LCBJIGFncmVlIHRoYXQgeW91IHNob3VsZCBnZW5lcmFsbHkgYXZvaWQgZG9pbmcgdGhhdA0KPiA+
ID4gYnV0IEkNCj4gPiA+IHRoaW5rDQo+ID4gPiB0aGF0IGluIHRoaXMgc3BlY2lmaWMgY2FzZSBp
dCdzIGZpbmU7IEknbSBub3QgYSBkZXZpY2V0cmVlDQo+ID4gPiBtYWludGFpbmVyDQo+ID4gPiB0
aG91Z2guDQo+ID4gPiANCj4gPiA+IFAuUy46IFRyZXZvciwgbmV4dCB0aW1lIHBsZWFzZSBtYWtl
IHJldmlld2VycyBhd2FyZSBvZiB0aGUgZmFjdA0KPiA+ID4gdGhhdA0KPiA+ID4gbm8gODE4OA0K
PiA+ID4gICAgICAgIGRldmljZXRyZWUgaXMgcHJlc2VudCB1cHN0cmVhbSENCj4gPiA+IA0KPiA+
IA0KPiA+IEdvdCBpdC4gVGhhbmtzLg0KPiA+IA0KPiA+IA0KPiA+IEhpIGtyenlzenRvZiwNCj4g
PiANCj4gPiBCZWNhdXNlIHRoZXJlIGlzIG5vIHVwc3RyZWFtIG10ODE4OCBEVFMsIHNob3VsZCBJ
IG1vdmUgdGhlIG5ldw0KPiA+IGNsb2NrIHRvDQo+ID4gdGhlIGVuZCBvZiBjbG9jayBsaXN0Pw0K
PiANCj4gV2hhdCBpcyB0aGUgcmVhc29uIHRvIGFkZCB0aGVtIGluIHRoZSBtaWRkbGU/IFNvIGZh
ciB0aGVyZSB3YXMgbm8NCj4gYXJndW1lbnQsIHNvIGFsd2F5cyBhZGQgYXQgdGhlIGVuZC4gSWYg
eW91IGhhdmUgYW4gYXJndW1lbnQsIGxldCdzDQo+IGRpc2N1c3MgaXQuDQo+IA0KTm8gc3BlY2lh
bCByZWFzb24uIEp1c3QgaG9wZSB0byBzb3J0IHRoZSBjbG9jayBieSB0aGUgY2xvY2sgdHlwZS4N
CkJ1dCBpdCdzIHBvc3NpYmxlIHRvIGV4dGVuZCB0aGUgY2xvY2sgbGlzdCBhZnRlciB3ZSB1cHN0
cmVhbSBNVDgxODgNCkRUUywgc28gaXQgd29uJ3QgZm9sbG93IHRoZSBvcmRlciBmaW5hbGx5Lg0K
SSB0aGluayBpdCBpcyBmaW5lIHRvIHB1dCB0aGUgY2xvY2sgYXQgdGhlIGVuZC4gSSB3aWxsIG1v
dmUgaXQgdG8gdGhlDQplbmQgaW4gVjIuDQoNCj4gPiANCj4gPiBJZiBJIG1vdmUgImFwbGwxX2Q0
IiB0byB0aGUgZW5kIG9mIHRoZSBsaXN0IGF0IGJpbmRpbmcgZmlsZSwgd2hlbiBJDQo+ID4gdXBz
dHJlYW0gdGhlIGRldmljZXRyZWUgbm9kZSBleGlzdGluZyBjbG9ja3MgYW5kIGNsb2NrLW5hbWVz
DQo+ID4gcHJvcGVydGllcw0KPiA+ICwgc2hvdWxkIEkgZm9sbG93IHRoZSBzZXF1ZW5jZSBkZWZp
bmVkIGluIGR0LWJpbmRpbmdzDQo+IA0KPiBJZiB5b3UgZG8gbm90IGZvbGxvdyB0aGUgc2VxdWVu
Y2Ugb2YgYmluZGluZ3MsIHlvdSB1cHN0cmVhbSBpbmNvcnJlY3QNCj4gRFRTIHdoaWNoIGRvZXMg
bm90IGZvbGxvdyBBQkkgYW5kIGZhaWxzIHRoZSB0ZXN0cy4gVGhlcmVmb3JlIHllcywgdXNlDQo+
IHRoZSBzYW1lIG9yZGVyIGFzIHlvdXIgYmluZGluZ3MgZGVmaW5lLg0KPiANCj4gPiBvciBjYW4g
SSBoYXZlIGENCj4gPiBuZXcgc2VxdWVuY2UgYmFzZWQgb24gdGhlIGNsb2NrIHR5cGUgb3IgYWxw
aGFiZXQ/DQo+IA0KPiBTb3JyeSwgSSBkb24ndCBrbm93IHdoYXQgaXMgdGhlIG9yZGVyIG9mIGNs
b2NrIHR5cGUgYW5kIGFscGhhYmV0LiBJZg0KPiB5b3UNCj4gbWVhbiBhbnl0aGluZyBlbHNlIHRo
YW4gYmluZGluZ3MsIHRoZW4gbm8sIGJlY2F1c2UgaG93IGlzIGl0IHN1cHBvc2VkDQo+IHRvDQo+
IHdvcmsgdGhlbj8NCj4gDQo+IA0KR290IGl0LiBUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCBleHBs
YW5hdGlvbi4NCkkgd2lsbCBmb2xsb3cgdGhlIG9yZGVyIGFzIGJpbmRpbmdzIHdoZW4gSSB1cGRh
dGUgdGhlIERUUyBub2RlLg0KDQoNClRoYW5rcywNClRyZXZvcg0K
