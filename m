Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1DA63196C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiKUFR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKUFRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:17:24 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F7912620;
        Sun, 20 Nov 2022 21:17:16 -0800 (PST)
X-UUID: c363a48abc3345a39a32f36420fa6d08-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=n109LRgXB85JQKNz4YiWZG1SNhXjxBmpyjCkvN3/fdw=;
        b=FfxvWBAM25hQwpo45x1Uf/e/wFadfr+oCAQcma/9ZnpBD3tG9IuWZIQ+ZhIm7L+e59IM9NroIMn+xWBo27Pzd4ApFca0Bb2CJz1D5EkwymxkAaTqb7NlarlKxL8euMkvKWcXqVQFYXSXduJ0dznQ5+ZOupwlWo+Mf8J9kKtXco8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:c5f3b500-20c7-4694-9324-8cefe977b950,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:f00dd2f8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c363a48abc3345a39a32f36420fa6d08-20221121
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 910843348; Mon, 21 Nov 2022 13:17:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 21 Nov 2022 13:17:11 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 13:17:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTOUM1yPWkcH+g/jlAD7wdhWgD1Fcel8SqMGVlWmnnxylbiZ2g+TFzFC/iiOs19R2Q/g2hjYy8Mc2JPMkW0qdmIpXKGyI44d86hcLyj2TJwP7zWO9kVqd+1ner/9+wp6tJPUWNAddYrvaBz0jXjvgP5TP6SOluk+qNBt6l0F0cU6FsaThr1TQcKY5DgXgO/YBqU4GJ+JA6/sPhHhQzOQ9w+SFYKTY63vknvLFSOucrSecZmFVEHKusFDhpesUM9M6GPiGj59TZ/y4yTyCZrRlpLXuX0w2y8IPaRJIdtGDFzE7aflzQaxXgh2LaS2lI8DSQQBtUwmPBAmtgRZrQz+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n109LRgXB85JQKNz4YiWZG1SNhXjxBmpyjCkvN3/fdw=;
 b=Y+ebwzi87/+c+sMcmvpR2VTvmPVjdvI2dL3H8FLveyMxTpN2qJ/JPCM5bn8/9MZrzzGi61hY39w93/ROO1oeBN8R5D3/zqg3vyximqC16r8It1F7rmuA11eKH44GOROF0HzW5MGGGUoFExX33yNKWrB66gmo94jperxTFYdyOQpPCYxN210XiQ0dPZJjnrk9k9UHcfC/ozePJHDNqUKw6vslJND3G/TBk8I89qgcMRvOBnNcEN6LOcCUDTrkjlYfahapIOjTtFly4j4rw7ZjP9bHI1p1deuEyi5Vs+3dw+cH7tOhncr4RFdZ5locmLpyewNDdJAqE2gjOdKm2wCYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n109LRgXB85JQKNz4YiWZG1SNhXjxBmpyjCkvN3/fdw=;
 b=YbKthvJXNFOF9SVcjwdfi5PjlhrhI+2LVTrzVx0zbki5f5WPsPvkDKcSd0yLWCEGbERPYN3qYzjvBfNCfM44oyYheSBd/MbXPWLvW+nfYP/MZK8l88yfPWrLPhlMC57lhyCpyCPOn5zafIVJSoLorCTG3PehD2sqkul1tMSZfdQ=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB5296.apcprd03.prod.outlook.com (2603:1096:400:3a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Mon, 21 Nov 2022 05:17:09 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::be04:b90a:e582:9b0b]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::be04:b90a:e582:9b0b%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 05:17:08 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Thread-Topic: [PATCH v4 1/4] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Thread-Index: AQHY4r0Bs+Wvn4yFEEW+yA6HstpMCK5JC4YA
Date:   Mon, 21 Nov 2022 05:17:08 +0000
Message-ID: <0b5b1d9e302f70df2e6ea207a88e7483eabd469c.camel@mediatek.com>
References: <20221018064239.13391-1-chengci.xu@mediatek.com>
         <20221018064239.13391-2-chengci.xu@mediatek.com>
In-Reply-To: <20221018064239.13391-2-chengci.xu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB5296:EE_
x-ms-office365-filtering-correlation-id: adba95f0-f0e6-4af8-da3a-08dacb7fa35d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k4kR8PRfXzkS4PanpautsyE2sVpoCqACTe0brrVjiUtG7wjczVWyr5WEbUsKXN887UDbhutIk7kHzx7si/BqGFmkbUY9mcWeBrBTPxLth3eiIxq7YS9XykJhK1hkdljoaH2HjVNp9En2o0Vwo4oUR2b/gINZ/eKZ5klTK289OVt8DO7kwczpqqD25hEEQftf8v4mOndJAEn1k6UImP5/pLUUzeIxeiAmkd7O8w74P97eRBbvo+FusqcIu5LMxofzeX5jqMVcO8RlmT6kGIVOPaXmQ+1u87Dl11AZFNAfk/J+PzLJtBLI09OoQAeecblppTInYUFLUak3bjeEDwK5D/YimUtJeUJFwxkPECQAQIwkUaoslknb5khQW31zhAdHtw5StpqbDTSs5C0DRA8Vcxbd8PN4qIBSG1m/igDROxW5J9UJ9tQpbwr/ecKEb30LfyQLEyMomVw/YMZqvOn8p1CRE7o0PBvMQBf7suFYoM1/truqRq8h8Fq5D8FU54Fhw5Ht8BVDEFapmroky2gaDIFOJt2+2JSl6qRzjHOTNeC+SfxYYWBQ7oayn5P+8LzHfDMW1NiVio/I+BcBLa2MqNuY1lNQDfjSzILG/Ba4em3Lqw0dzUeelJOqPTYVK6AFQvasuS1iUsPmZIgCQ0j/JOOs+5IsUDSLI/O73WKmaEd0Ex0bs09XkfOJAqEqVkd1gov5YKJctlSYbuObeipW0TV7xEJI0uIN805YMvE/D1w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199015)(85182001)(36756003)(86362001)(122000001)(38070700005)(66476007)(66946007)(76116006)(66556008)(316002)(66446008)(41300700001)(64756008)(8676002)(4326008)(38100700002)(478600001)(71200400001)(54906003)(6486002)(110136005)(4744005)(5660300002)(8936002)(2906002)(4001150100001)(7416002)(186003)(2616005)(26005)(6506007)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjVqYlk2UFlDQU5CQkduMDBrOUJIZmcyaG91dk13cDE3clkxN0ZtUmN5SnN2?=
 =?utf-8?B?NThKYXhvVFQwL3dQRkxvUkIyNkVWSXhZQlBYOWZGL2dWRndXeWRYUVJHQU02?=
 =?utf-8?B?bjN5S2FOd0VzcHZzRHBrWnltTlJPRVhpYjRLczNvMkNwODJuK2FWdnVxQlVV?=
 =?utf-8?B?S3ZWSHRINkh0cWpRWisxanJUU0dpeXNxQ1JRQjBKWFlwVGlSVVVuKzRCcWJK?=
 =?utf-8?B?QklnQUZHQkJBRDNFN0k5TWp4RkpEOHNCV1g5cWdPRHR3NjdYNmw4REt3OFV4?=
 =?utf-8?B?MXl2dytremtJWlJPVHNwQTE4VVdqZmUvakpTSkhoc05MUDkxNVVYRWZBNm9q?=
 =?utf-8?B?V25vK2x5NnFBNU14MmNWVFNlRkNCSTZodWJIQlhTMXBPNW5DQWZlOHdSekRB?=
 =?utf-8?B?aUMxcXpoSHpCVjJ5VTczU2haRldBdVRjK0RLWnBlSHdiQWNIenlDOVI0MW00?=
 =?utf-8?B?RDRCNDNkRFBNOEg2aFUxUHFvSFU5V0k1Y3FSRG5IVnlLTENNSHcwWFZybTNH?=
 =?utf-8?B?d0R6MzRCK3JjM25xaTNQVTA2K2lQMVJQU1VIbGUyK2JHZlh6U2ZxdFhPQUV3?=
 =?utf-8?B?bFQ3czZjSm8yZWRrRmJyOXpnQitGVVBxeW9YNllzY05ZcHBoU2IwTnRaWGJs?=
 =?utf-8?B?NUVsd0E1TVR5ZEhzQUNzVnE0cmFGeXlqNFQrd0l5UTVVbnhpdDBiOURxZ0gw?=
 =?utf-8?B?L3FyVEVKOEE5T0hETlU3ZjVUcUlMc0ZBNDJmc1crTzk3U2Y5RzhyVTBoZmo2?=
 =?utf-8?B?elJ5cFlOTk9qQy9hT3FtSy8vZUxOQ3VvMmcrZnorR2xFZ2xSc0xid21ua1Vi?=
 =?utf-8?B?OFpONDFwQW9GS2Ewc0F5Vis3Njh2ZDZWSC9xVzl4dE1NSjlmZW1QMEkxanli?=
 =?utf-8?B?WkNMWFlzL0dxNFdnTFp1YTFQdmllMmRzais0TFc4RGVLV1V2YWV0WkZsclRk?=
 =?utf-8?B?c0UxdU52bDFQeitJNVhpUUZOdC9IR0JLdWN6ZVFaNUZxUWxJVmMzdG40MUxN?=
 =?utf-8?B?TWUvVnN6Ulc3QjVRYVVUTVYvUDFNODJZWTB1R0lwNVBCK29hRkRhak1xZDFX?=
 =?utf-8?B?ajBXL1ZYeUhxYjZPd2lzQVphb3RtaUEySTVKb0dObktzUUJSQkJCT0hDaWRR?=
 =?utf-8?B?a0dCRitheVBXaHpiQzlxZFV4QXFOVXJDNWNiWGlIZHQzQ29qRmdkKzF0M0ZF?=
 =?utf-8?B?cy9XUWd3NlhUT09kcVhPZ1BHR1FZOFVmNkE1ZVlLRmZ3QW4rNE9TemNQWWlY?=
 =?utf-8?B?N2NrTmM5a3haeG1Lak1FVjIyWlBmNmFzZ1dyVDhaMWNSYkVncSttdTlNSndu?=
 =?utf-8?B?UE45ajcrYXVtVEw2ZFAzb3MzVS9NZkU5VXRIYSs1NHhHRGM0Q2NpMEF4Tity?=
 =?utf-8?B?SWZWN0lJRktZMlpzazlDRXBKSm1yVzZZWHlMVlBaUGxmOEs5eHpKK2JkcGJN?=
 =?utf-8?B?aUViMGFLcE5mcHVQd1M2ZzV6ZTBPcGtBSE9KQmZ1dUo2U1M5V2VBR2w5b1cr?=
 =?utf-8?B?UkFnZWRwZHFNMksrT3lnZUpMMjJBdFhNT0dqTnlsVGtYQjgyRXE2NUlKeHdz?=
 =?utf-8?B?RTRVT0MrYTVxem13aHBKQTgyTUltakVsTXZ3UkQ2UDYwM253amVPRlBlSE5s?=
 =?utf-8?B?d2tkdnAzS0ZkamVkR3ZqenRUNHZuWHFlUE4rajVGbGNvNHVjMXVUSzhVWEMx?=
 =?utf-8?B?OXRJSVJXT3dMeG05K3lBejlXczVacllpQ3JDUHErL0lweitIU1h4bXU1OHRs?=
 =?utf-8?B?eVNESWJmTkt6cFlCQnQxQkdHSEZZMXJVRkRRQm5Mdi9rMk1DT2ZsZkVWb3NF?=
 =?utf-8?B?T1ROc3kvaDJ2L05nRm9hR0w4cDM2aUY1ZkVOR2NJbnB4REp2c3E3UlVCbS91?=
 =?utf-8?B?UjBOVk1SOUdlN1RTTnh5VVFqMEhUTEQ4YlFEUXFKU1NFa0p0VTlJTXp0ZzJ0?=
 =?utf-8?B?Tk82MTJGWDhLK2VmM2hBNlpzY2FjYyttaThIQ2RtQlFCMWFoZUJkaElaVm9t?=
 =?utf-8?B?Z1hmd2ZUMlpFN1pkMU9mSFNYazlRZEY3MW44NTFiemFwRHdvVFpFYmdQalcz?=
 =?utf-8?B?Wmt3YVNRem1ydlJ2YWNVZHBtQTc3MjhvZXJlcDNtNTh4UEk4UUxXWkJRK3oz?=
 =?utf-8?B?ck1JQjdqakdVNUNTVnQyc2J0QmdqeUpPVDc5NzFLM0VMZ1VDdVZ3bHJiSmZk?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A91B6EBEB7B38C45BA5F759FD00A8E17@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adba95f0-f0e6-4af8-da3a-08dacb7fa35d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 05:17:08.7832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dc18ID58PrHP3WLC9Kf8JiSzdvvNiz4vKHZ1ZpC5/Uqu3knKeaiG72ExLty2vDNDwSb53/CGw9wPjHHuU73sFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5296
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTE4IGF0IDE0OjQyICswODAwLCBDaGVuZ2NpLlh1IHdyb3RlOg0KPiBB
ZGRzIGRlc2NyaXB0aW9ucyBmb3IgbXQ4MTg4IElPTU1VIHdoaWNoIGFsc28gdXNlIEFSTSBTaG9y
dC0NCj4gRGVzY3JpcHRvcg0KPiB0cmFuc2xhdGlvbiB0YWJsZSBmb3JtYXQuDQo+IA0KPiBJbiBt
dDgxODgsIHRoZXJlIGFyZSB0d28gc21pLWNvbW1vbiBIVyBhbmQgSU9NTVUsIG9uZSBpcyBmb3IN
Cj4gdmRvKHZpZGVvDQo+IG91dHB1dCksIHRoZSBvdGhlciBpcyBmb3IgdnBwKHZpZGVvIHByb2Nl
c3NpbmcgcGlwZSkuIFRoZXkgY29ubmVjdHMNCj4gd2l0aCBkaWZmZXJlbnQgc21pLWxhcmJzLCB0
aGVuIHNvbWUgc2V0dGluZyhsYXJiaWRfcmVtYXApIGlzDQo+IGRpZmZlcmVudC4NCj4gRGlmZmVy
ZW50aWF0ZSB0aGVtIHdpdGggdGhlIGNvbXBhdGlibGUgc3RyaW5nLg0KPiANCj4gU29tZXRoaW5n
IGxpa2UgdGhpczoNCj4gDQo+ICAgSU9NTVUoVkRPKSAgICAgICAgICBJT01NVShWUFApDQo+ICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgfA0KPiBTTUlfQ09NTU9OX1ZETyAgICAgIFNNSV9DT01N
T05fVlBQDQo+IC0tLS0tLS0tLS0tLS0tLSAgICAgLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIHwgICAg
IHwgICAgLi4uICAgICAgfCAgICAgfCAgICAuLi4NCj4gbGFyYjAgbGFyYjIgIC4uLiAgICBsYXJi
MSBsYXJiMyAgLi4uDQo+IA0KPiBXZSBhbHNvIGhhdmUgYW4gSU9NTVUgdGhhdCBpcyBmb3IgaW5m
cmEgbWFzdGVyIGxpa2UgUENJZS4NCj4gQW5kIGluZnJhIG1hc3RlciBkb24ndCBoYXZlIHRoZSBs
YXJiIGFuZCBwb3J0cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoZW5nY2kuWHUgPGNoZW5nY2ku
eHVAbWVkaWF0ZWsuY29tPg0KPiBBY2tlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6
dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gIC4uLi9iaW5kaW5ncy9pb21tdS9t
ZWRpYXRlayxpb21tdS55YW1sICAgICAgICB8ICAxMiArLQ0KPiAgLi4uL21lbW9yeS9tZWRpYXRl
ayxtdDgxODgtbWVtb3J5LXBvcnQuaCAgICAgIHwgNDgyDQo+ICsrKysrKysrKysrKysrKysrKw0K
DQpSZXZpZXdlZC1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQoNCg==
