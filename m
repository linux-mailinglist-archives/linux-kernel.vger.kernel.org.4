Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB63C6D92B0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjDFJ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbjDFJ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:29:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696883A9E;
        Thu,  6 Apr 2023 02:28:59 -0700 (PDT)
X-UUID: 726c3002d45d11edb6b9f13eb10bd0fe-20230406
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AGZXtfF4aNQkgTqUuzmjUIktp0KmyzK3qlYfiP4alUU=;
        b=lECGSZvfJgWKaVR5xtK1SCuTmtTkLoh56Cas/R51+HCZ5GY4xXL4cUOA+T4wAP+GybJIA8i5fnjG7aD3fhm0c/gxmWRfWMNG1ftb33QgplMMkCzI7ZUl8nQ4cPMZ6uZ1U14xdZtsD8OSa/deKpZQ8leYtk+ERW9GNWD9PihXTFM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:d10bd3df-4d1d-44ef-ba9b-24a588ccb545,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.22,REQID:d10bd3df-4d1d-44ef-ba9b-24a588ccb545,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:120426c,CLOUDID:c6fd64b5-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230405174336OI0HK0CC,BulkQuantity:70,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 726c3002d45d11edb6b9f13eb10bd0fe-20230406
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 420666443; Thu, 06 Apr 2023 17:28:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 6 Apr 2023 17:28:52 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 6 Apr 2023 17:28:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaN+VCQX4zjJHOZDanl9uH9DKWaLpSRANrURM0KfzoShQrPYFjfnxpNCNc9NA1bXLEwdyye7JBU5EqPJoGgSoAUxHAPPW9mVZCrhlgMjealWDaGqBbCzH9B1H/JpUdJ7+dmVWwC8vZDj66IWIKAMgPKDrE/vPFQj4ZAUfEuh3hyyI0oE1U/R7t8Dziq4nvqG3LnPqxX08N/3N8vzupGFula5OoVFz9M4hH7Wk2m+3SUZqTv5wc42Xm4bs/eSllFX7XfvtCdJiY60BvZFWRWn18R7BeTQq7Bfvjof0w3uLDJ20368wAH4kOrFfeckK0S/cfbVANbUh1JSlajMDfg6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGZXtfF4aNQkgTqUuzmjUIktp0KmyzK3qlYfiP4alUU=;
 b=AYontRuTUAJnxqZ39W3GSsOVf0bqQD28PWP+isss9jx/5hQSVZltZd0NBcnRu0IEOWQigAZE+KBGs6ho8KFF/qzpAhKW2TuASK8qao33gGZq6QXOlbe6BjKVgt6MFV+e1jDZXp9TMNv2wdL5LLJ6+03suJ3qx6HYC1vYzaea7BgEkhsXgZfNKSMWd7CNy0n5/XbrioZXAAx2x1MaRu1SfFN5jrJ74HoR0w5ZS9a94QdGFvMGuZNbXW/akTL8Vq8hroBNIPAqlV4ZmT87T0vpmGH43oWjsWw1qFuvWABI1M9vmYctSD81EzuQCcffOxeRFeqgqUWUEIbdrkxviAfvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGZXtfF4aNQkgTqUuzmjUIktp0KmyzK3qlYfiP4alUU=;
 b=kdIHCBVlw7X2htC1+/uWrb5seJfVZeZzGTLlDdmf+M0Nr4zX3pS1VeTykzb4v57pwjNZKSLREQesopTHc8zRqMY46DjM/3suyX2otl4Agc96o/j51jQFADnEdZv8+FIbsFPNqYt02AubuIIp00QEMIhX0I8tTypRhozka5jKreA=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SI2PR03MB5971.apcprd03.prod.outlook.com (2603:1096:4:148::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.34; Thu, 6 Apr 2023 09:28:50 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::f187:376c:9c1c:2757]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::f187:376c:9c1c:2757%4]) with mapi id 15.20.6277.030; Thu, 6 Apr 2023
 09:28:50 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] memory: mtk-smi: mt8365: Add SMI Support
Thread-Topic: [PATCH v2 10/10] memory: mtk-smi: mt8365: Add SMI Support
Thread-Index: AQHZZ5XGssw7QXTh6EGMV7jHGHOLSq8eBTeA
Date:   Thu, 6 Apr 2023 09:28:50 +0000
Message-ID: <9ad8c606026586b682df5e0ce0c699e21a1e6fb7.camel@mediatek.com>
References: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
         <20230207-iommu-support-v2-10-60d5fa00e4e5@baylibre.com>
In-Reply-To: <20230207-iommu-support-v2-10-60d5fa00e4e5@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SI2PR03MB5971:EE_
x-ms-office365-filtering-correlation-id: b5f4b6d7-4840-42c2-19b3-08db368154b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lnjqusqGFkoGB44l4cVes0K3H3mNyYNeCF3WCCf7L0E3fQxaQcZ8a0nLHwIB8oR2jutU58u5kEFjkQ3y5DpX6xX0ItCqeXLpUgzWC0GnjwVhoi9o48lxHzgJFnzRG2RKGGrzjMGzV8r6DSeItmyL0i2CbmEtctIEwqBtmvdku3kgKd2PyinT9ag1dZsTkQ6YTFW/fPjKsChp8xT9NuwLQTMQ15wcKaYQ1PdOVrkkn6LPk2Y6BbsH0iYvgyF/FElIepsFbdd4J086mvlE+h696h81y2+WG0M5dIzYP7nYzonBtR9yq/0ogpF18B6QZc0mA0OyxJ1nlV+LTuNzjt2EIKXSWGEqJ01BZGPLLYN9R1g4Z5sCTPXj/wdRRCdUJbQuW4DqmIwHdklCOWK5KjZbQevviticdaDgskaw2E6Ve7f+KrI7xa1hU25YrZey4WTGaMLT6BFQyfCkyHi/rFd2d/mz+mx+zb5FYnuEMs/F0czV3oW+80fw1hf0UDaIDBmiwfG+LlDji94tGegKrRBnpYocUiXeqEh7MtyEwsIkrKDQSDWBgLv5U1sW083M/3rMwx9Ra/LHYASJQNcQDL3nmigLQp7WlkDWWV33QRcuBtKLRwKhbcgjXbCh8QsB8sh14hWzXyeO+1lH+eaM7YAKpPgtqeVrYB625m5eKemQrPL/8kvzYMgouQkwEEp4m2Wr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(110136005)(4326008)(122000001)(41300700001)(66476007)(64756008)(76116006)(316002)(66946007)(54906003)(66556008)(186003)(2616005)(6486002)(71200400001)(66446008)(86362001)(26005)(6506007)(6512007)(8676002)(478600001)(85182001)(36756003)(38100700002)(2906002)(5660300002)(7416002)(38070700005)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU5HMUlwTzNtNXh2d3l3eHhtLzhkSWpSQ29QM25VNUdjUnhOb05vZk03MDNp?=
 =?utf-8?B?cVBxdU5tV3FpWTJhejNiTkVUaUhXYVd5RWVnNW50NmRCdzZrN0djUFN6U3VJ?=
 =?utf-8?B?NVJxRkdrVER1QnRobkNSTmlDa05qZDRadkxNb2tUb0VjcXhpeGxUOUF3dFBV?=
 =?utf-8?B?Vlc0bEpDUXBBdW42Uy9rYW1nYnh0SUIxa1ZtQTkrOUJXYmU1U2ZSRlBlbEYv?=
 =?utf-8?B?SXVUcWo5V0VrQzhieEZ2TC9hbjg0UEVHWEg5T1I0V2RJUVUzMXpyOWNZR3l2?=
 =?utf-8?B?b1NwT0dDQ0tmUU1US1R0T01YdVhld2RhTmJnNFlTcnZZWVphYWUxSHA0eHMz?=
 =?utf-8?B?UWxTTmVjaUxJQS84MEQ3dWxUdzRVZ2M3Q0pSN3AvRG1STExXTW9DWmlGT2tq?=
 =?utf-8?B?cG1odlUxYjIxM2E4RTJQWkFjdUhJay9lbkhBeWhDcGp6R1RxdGZiK24vaEpr?=
 =?utf-8?B?bVhKZ3J6QjlUdE9FZGg4c016WUVLWmQwK3FNN2RMZ0RYT3FSZzdJLzhWaEto?=
 =?utf-8?B?VHh2YlowYmlpM3ZsVGh2dm5RalFxUS9VUFYrM3RENzlTOVZ0ZGtxNUJONnYv?=
 =?utf-8?B?WkF1aWpvc290Q2hZUDFETXpQeU8yY0FUUjlXZnFoZ2IxTm1aaWM0dkk4Qjha?=
 =?utf-8?B?Qy96bXZRRWt6MEJYU1hzUzB0MHNhRlF1WStRaW9tNDhnRjhwdWFkNFFVNVd4?=
 =?utf-8?B?R0FkUk9RZ3k1b0xYK0xVYXhWZDJDV0VNWTdSU2lZTFpFWHRZdnFsc0lNUHVB?=
 =?utf-8?B?SFhIVmtqeXgxVnhMN3VYd3ZUWEd5bzF1MS9MVUtUSVQvakNuckJra2F0ZCta?=
 =?utf-8?B?Mk9oVjVQNlVpbUxFdEMyZW9EQjBWc2l4Vjg5VW9TOExOTjRtY21yQTVsZUU1?=
 =?utf-8?B?Z3lRRE1rd1VTYTE1Qkh4YmRuR3ViR0Uwc2plc0pFMjFBQmxzaHByZk53ajdR?=
 =?utf-8?B?d2JmcThRUTF1UEtVZzRrRnFPR280ZEMzdUsrQnVLMEp3a2ZwdU9qcTFXbU9Z?=
 =?utf-8?B?dlFEWnlTQ2hIRmE5K3pGeGN0REE3MktVUGJWVmcvdm9uRnh2WlFoK2M5Vmhj?=
 =?utf-8?B?ODJJTjY1V0dQRXgyRjlFTFhjQWRhSVBKOUJUWjArUHZ5b2ZjYXk0d3RMQWth?=
 =?utf-8?B?TkNKcG1reHZJVWEyV2xqNHRkV0UrcEthRU1mamlzYVZjc0hMemxjdVVDWHNN?=
 =?utf-8?B?a3dITHFCNXY5QVlpcjB5WHBxTyt1dEdLcHhyNGt1K3BVSTU3QURJbnN0eVlj?=
 =?utf-8?B?c25oZUhROXYzWm9jSmYrdTZVUW1FL0oydEhTbEcxdU9PWERpT1FFd1RIYzZZ?=
 =?utf-8?B?NWZucUk0QWRkZVN1WXZuendpMCtCYktvK2dCYnFTd1MzRTJtUFFYWW9FZCs0?=
 =?utf-8?B?MHlIYTZ2enhkWXpFUk5zc3JJaWk5bmREMHIxakxBVU94aW5PTTlmczVJaWRo?=
 =?utf-8?B?QSs0NVJrMitwOVdqS1llRE5IUGp4WFNOang0cWg2TFhzRGxrZzBONW9HcHly?=
 =?utf-8?B?Z240TVJoK1RaWG5ITU4wS2ZSOUlLN2d0Y1BIQ2tpYTB0a3MyeTVHWHRIcVhj?=
 =?utf-8?B?SURqWVh3R2xDK1dhUWp1dTVwemlhTnJlNTExb3RJdlBubjB3N3dPWjE5ZUtC?=
 =?utf-8?B?dm4yK00raHUrVm1CSkhwU0NjZDFaSUdzblVIMkQvbEZ3MWRWYzMyVGlxVS9U?=
 =?utf-8?B?MzJPRXFrOXdxdDhmVURvRVFUU3VJODJwVlhqYlF2Z0xBTTRPT25HbGRsYUlU?=
 =?utf-8?B?Y1RKWENUV2MvZnZ2ZkVVZzJwZDFMeENPQS83REYzMHFIUldCVUUvK3ZweUpX?=
 =?utf-8?B?dSt4VjJqMnptR3VqdXdaY0VwZm80SnR3Tmh3TElua1k0UFJkdmRqVW15MzhI?=
 =?utf-8?B?OUlmUGlIKzNyZHBaOTMzc1crd2lsODNZd3RTemJHandGY0ZpeThIcG9uczUw?=
 =?utf-8?B?WVpZUkVjTStwaWpyc3FVSCtOc2crNW9lYVBKellsbTZiWkQvcUM5cnp2QTd0?=
 =?utf-8?B?U2huRWNIdHo3NHZDbUJiQmcrSncrcE5xNVN3a1VQOW1ncFAzRG95TTNNVHNJ?=
 =?utf-8?B?KzBncGpOYnQramVFRmE5OEVwU2xjRW13N0lJRFlwWlBCNGRQNzJoOXdkK1Rs?=
 =?utf-8?B?TWxTMWZqdEZBaklhaXpqd3U5VXBoNktqNnZ1emN6YjN3aVkwUmhQazVXWGdh?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06A8D06415AA7E4FA7BD71B6A2304DCE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f4b6d7-4840-42c2-19b3-08db368154b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 09:28:50.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4ELU5CBYWmRtaCoqCnXTx7OroazA1MnXZXWQ+i5Z9IBmhwUcgGqd5Hf8xU1SlsxSNfGwxXbKtNqZ+lYRJynLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5971
X-MTK:  N
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA0LTA1IGF0IDEwOjA2ICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gDQo+IEFkZCBNVDgzNjUgU01JIGNvbW1vbiBzdXBwb3J0Lg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0QGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL21lbW9yeS9tdGstc21pLmMgfCA3ICsrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS9tdGst
c21pLmMgYi9kcml2ZXJzL21lbW9yeS9tdGstc21pLmMNCj4gaW5kZXggNWE5NzU0NDQyYmM3Li40
NzdiNWQxZmZkNDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KPiAr
KysgYi9kcml2ZXJzL21lbW9yeS9tdGstc21pLmMNCj4gQEAgLTcxMyw2ICs3MTMsMTIgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfc21pX2NvbW1vbl9wbGF0DQo+IG10a19zbWlfc3ViX2NvbW1v
bl9tdDgxOTUgPSB7DQo+ICAgICAgICAgLmhhc19nYWxzID0gdHJ1ZSwNCj4gIH07DQo+IA0KPiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfc21pX2NvbW1vbl9wbGF0IG10a19zbWlfY29tbW9uX210
ODM2NSA9IHsNCj4gKyAgICAgICAudHlwZSAgICAgPSBNVEtfU01JX0dFTjIsDQo+ICsgICAgICAg
Lmhhc19nYWxzID0gdHJ1ZSwNCg0KbXQ4MzY1IGRvZXNuJ3QgaGF2ZSAiZ2FscyIuIFBsZWFzZSBy
ZW1vdmUgdGhpcyBsaW5lLCB0aGVuIHRoZSBjb2RlIGlzDQpvayBmb3IgbWUuDQoNClJldmlld2Vk
LWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzLg0KDQo+ICsgICAg
ICAgLmJ1c19zZWwgID0gRl9NTVUxX0xBUkIoMikgfCBGX01NVTFfTEFSQig0KSwNCj4gK307DQo+
ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19zbWlfY29tbW9uX29m
X2lkc1tdID0gew0KPiAgICAgICAgIHsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtc21p
LWNvbW1vbiIsIC5kYXRhID0NCj4gJm10a19zbWlfY29tbW9uX2dlbjF9LA0KPiAgICAgICAgIHsu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItc21pLWNvbW1vbiIsIC5kYXRhID0NCj4gJm10
a19zbWlfY29tbW9uX2dlbjJ9LA0KPiBAQCAtNzI4LDYgKzczNCw3IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+IG10a19zbWlfY29tbW9uX29mX2lkc1tdID0gew0KPiAgICAg
ICAgIHsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtc21pLWNvbW1vbi12ZG8iLCAuZGF0
YSA9DQo+ICZtdGtfc21pX2NvbW1vbl9tdDgxOTVfdmRvfSwNCj4gICAgICAgICB7LmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ4MTk1LXNtaS1jb21tb24tdnBwIiwgLmRhdGEgPQ0KPiAmbXRrX3Nt
aV9jb21tb25fbXQ4MTk1X3ZwcH0sDQo+ICAgICAgICAgey5jb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE5NS1zbWktc3ViLWNvbW1vbiIsIC5kYXRhID0NCj4gJm10a19zbWlfc3ViX2NvbW1vbl9t
dDgxOTV9LA0KPiArICAgICAgIHsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgzNjUtc21pLWNv
bW1vbiIsIC5kYXRhID0NCj4gJm10a19zbWlfY29tbW9uX210ODM2NX0sDQo+ICAgICAgICAge30N
Cj4gIH07DQo+IA0KPiANCj4gLS0NCj4gMi4yNS4xDQo+IA0K
