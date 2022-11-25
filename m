Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3A96385CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKYJDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiKYJDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:03:01 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F21A1CFC2;
        Fri, 25 Nov 2022 01:02:56 -0800 (PST)
X-UUID: b417381cfac948e1ad72bcc8c0ad0a2c-20221125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7ZNgwffmmypTniganZsMZ3wx4EIf8U0tgSmELl2kPQA=;
        b=lJUDFAlKmYJv4Fi5YweCijBXMkxAB4WwF+WsvxP3ep4kGu/J8AO7GJt0YFEUTCJu6+OIDWmzrbrFzGtheob7eztZ0ghpA42909x9po0UDto6z0XMWHc6eoPJKU20DwGtsFfFwnXObCihHyTvGUryQ0hVVfOIoTlur8sxoBVUOWc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:00ab0ef9-a5a1-4fc9-814d-4fda3d9480f0,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.14,REQID:00ab0ef9-a5a1-4fc9-814d-4fda3d9480f0,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:dcaaed0,CLOUDID:ec1a3cdc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:221125160056GMJ1SRR5,BulkQuantity:25,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: b417381cfac948e1ad72bcc8c0ad0a2c-20221125
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1140775929; Fri, 25 Nov 2022 17:02:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 25 Nov 2022 17:02:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 25 Nov 2022 17:02:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRwv3UnOy2TDFUh/MI0ueepoIwAeszBcajHPcv2rRT3ly+Vkj2fX6v9amA/RRbTfbfaRGv1Eykt8aFNe0qcB23GLPsOFvcb9jaUz+Z7/7ZriVYsfzzViTw1CdRiSCpSHDUiAQO5p+6xSHjZzF405O0iOrl54xqVEsR8EXm8qd3Tce9JFVIzdpD0WYomxUeJlwAM96x4ltInEcsF5rDJ11r/JS9fFvVbPqqC7bdwbmOeP1rwZXMVEyzijmTd82/2j7BjCHvW8+OOK1fJ8twHQVy0prxlI6f3862UTe1HCpoDOxftaVKDBPhCJ1KWQ20QrQo+YTsUOuxIyLGyFzYOQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZNgwffmmypTniganZsMZ3wx4EIf8U0tgSmELl2kPQA=;
 b=PdG4gsveImWJDYsV01S8zZVbwUTNoUXmdALQPR6ohh4JXhR4G8NAKUnAa2DeK0824sAIgWakN+c8X4o6cjU2F7ovgmreOmPA7YOCuAlB4wZ4BEfWqAQ6eaVhn7TzMEEYVrLMpw7dSeb222TGch+O6wiW8Da9gYOk/2Gv+a67crls3Th/iTs/bYDRydzcfAiU6oFSu+iNO18tmbPL5TiFisrEJTFHU42ri7zNO9QdJxgbIWMSo9CvAGN6dVThUBuK+QS8MlCTw8ocoF/MwicnKHNkDvHKT2Buf/fkDN0p2OF19OpWlIpmFCOk42KRQWT5RCV6NZifV5I7VvH1B2hmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZNgwffmmypTniganZsMZ3wx4EIf8U0tgSmELl2kPQA=;
 b=XpII0RA4UtKeMmYUkBHf208AsLYhwfJAd7yPDfqSdIoQmcmYQnaIRrQOqqnjpQ1ypt2j/UkF8Y1f+IJSeIYEoCA1gvXhST32wX9AoE/lG7f17GfaCY/CovvQ41ouI75v+6BKUDR+WiLkoMg2LTmywlFsewEMLhANz8QS6FgfZ7k=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SI2PR03MB5801.apcprd03.prod.outlook.com (2603:1096:4:141::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 09:02:48 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::af56:be8f:f:85b2]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::af56:be8f:f:85b2%7]) with mapi id 15.20.5857.017; Fri, 25 Nov 2022
 09:02:48 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: usb: mtu3: add compatible for mt8186
Thread-Topic: [PATCH v2 1/5] dt-bindings: usb: mtu3: add compatible for mt8186
Thread-Index: AQHY/0NeTfiJAOQ/8UiMJl2IOF+xd65PSYcAgAALTYCAAAT7AIAAAQqA
Date:   Fri, 25 Nov 2022 09:02:48 +0000
Message-ID: <d8f834a67bcb76642051ebaea66ae3b32e931543.camel@mediatek.com>
References: <20221123135531.23221-1-allen-kh.cheng@mediatek.com>
         <20221123135531.23221-2-allen-kh.cheng@mediatek.com>
         <4ffbba83-d23c-59ef-0b01-eeb80ea70219@linaro.org>
         <fc0cb10747056f8f38a077b39df3a83e6b340c64.camel@mediatek.com>
         <735232e0-9e07-dc4e-4e6b-b7d198a2f27b@linaro.org>
In-Reply-To: <735232e0-9e07-dc4e-4e6b-b7d198a2f27b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SI2PR03MB5801:EE_
x-ms-office365-filtering-correlation-id: eb1e2c1b-a741-4044-f6c8-08dacec3d34a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSil/bq25OwEgdSIVGeYGdro1dszykDHfSK7njqtteC+cnd8BmnkneHcd/F7UswZnaeWKNWiLRvTesQD87s6GznoYfyTgGxFNhglPVJr2VsPGuxf98ROwn7VI6C0X+2kVhxmGDgsDAej5j6GEML5PPlvBm7J/rlsm76F4F1JCMPk0XQ0SG9b2ZO7+FB2D4ZITlVjunvGYci8RXN/nzm/XD8iuOLXgDOq5RDcDQAFcMOX5wW6Hy5SYhHbGqPnlze7EcesY6Y0iNSc3kNWhFwNaojlkOhU4AzJqI9a7TsUveZ5E9CKb6qLe07AM7kuilzQfu7BILFHPBNQh2bk/0W8dl3iR/gwNEmQW+A04mU5ak6uhSiZr1aca1aVx2C/RJSmAHuRSuI837xe6tzGfkj3pLWS7iIqHT1bMpZgEQozaLM11k+dBFE7UUHtrUQhS1JFzt69E3hViMEVqEihTfzRpwWg+eRzjE4qbcrdjRvNhV8DLQ9pBNV91dGSKDd+sFccp2tYETUiCOtcSSyko4JJk4SGNkE0AAr3OJHcDiqOGc53ljggdx+Z5rblISwlsxREyjjBFEOobwX4uif6l5lZ5K10Hj5SXTaAhpcDab/O5vl8cxxLOp2l69zYjUThRXVL1zNCBzcPRMBlRmLQXVmcbT3Sqpofzsi0u3O/LKc/nI/dEErlFFzVZ8/op8uobd5i2xJtvpH84MONhsftGP/OXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(7416002)(2906002)(122000001)(83380400001)(85182001)(26005)(4744005)(6512007)(6506007)(8936002)(54906003)(110136005)(86362001)(316002)(2616005)(186003)(36756003)(41300700001)(53546011)(4001150100001)(5660300002)(38070700005)(66476007)(76116006)(91956017)(478600001)(38100700002)(8676002)(6486002)(71200400001)(64756008)(66556008)(66446008)(66946007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWZ5SUZFUmdCRlV4UGx2eCtTZEMrVW04aEMwL012Mkd0V0s0MC9PMHR6aWxJ?=
 =?utf-8?B?dFhyWUVLNjVuU2pFOVJYS203eXMwV2NsZ285cVJWSkMxZXF3YUZSSGV3b0pC?=
 =?utf-8?B?MmY0SWx1SVZ1U3dWS3JoRFhQTGF1Si9jTDNPYWNnb1M4aFFWbERqTm9pYWg1?=
 =?utf-8?B?a1hONFZ2SW8vZ2xSd2tNQWtDV1dIWERGRldIdWE1RzAxRnBIQnF6a2dDazhl?=
 =?utf-8?B?d0VMdXlzekJZZXgvRUdGTmZOR0JxMFdQUnZwdHBuZWxOMllid1F3VHUreXEy?=
 =?utf-8?B?Z0YraHJDMFFaN2djWXdMWnBLRVpWdFlEKzNFa1ZIclZGSGZiN3V6cjZYL2xV?=
 =?utf-8?B?bWM3WnM1SkEwK0FBUjRrWVgzVjRrTUJEY0ZaOEdmMENWMjdGYVlic2cxUTBE?=
 =?utf-8?B?QnZNUUF4NzY5VXpwWGtyV3c1L3dwN1JMb1dzMjFxdkJlcDh4RU5YUzBncVpv?=
 =?utf-8?B?ZStvSEtOQnVEMGJZSEhpVUQ0aFFjcXVCZ29LZVcxR0s5NUZFWnl1VWJPZ1Ri?=
 =?utf-8?B?a3dqbzU1ekpmVWJobnJScE1GakFQcFZmcXNrN2FoY1dvdUNMQmZRSFFRZUMx?=
 =?utf-8?B?cEpPajZidjhMWG5HeWppUTRJT3c0Z1R1UXNvVHhHNkRoYm1HbDZjSGljMmxo?=
 =?utf-8?B?MUZjR2xmN0VzYTdBR2FYNlZacG5BTmVKUlFTM2RUNm9sZ1JPSEtQWWpuemdl?=
 =?utf-8?B?VGljaEEraEFlbVJmTHZKTStwT3N6RVdqYWVjZmM0cnJhR25ySXlDNHRrdm1w?=
 =?utf-8?B?NE9sbDAxNUhSYTBWemt5L3VIOHJHbkVETjlSWFFtWkppdFBIMWo1TFV3Wm0w?=
 =?utf-8?B?TzZ3L3hCSXRtZVJ3MGFhYjJwWHp3bkRab3RFd2d3bjA0aGg0dWptUXpBNndS?=
 =?utf-8?B?SlN3RnF2OElQWnhyU1pRUnMyUHFEOGRpSldCTGVBWnZHcUJKbm1hVnF3MVhQ?=
 =?utf-8?B?ZTluWktvL3Q5ZjlMd0pPNjB0ZFkyZ0ZsMXgvM2FsSjdDYkgrWnh4NzZlSnNY?=
 =?utf-8?B?VDM0TUZ5QUNyZlFYY200LzVRMjU5SHkydmpRNVhmdGRzc0oxWHYyNThRY3JR?=
 =?utf-8?B?L2wrV3JYVnFjRkJMT09Db21PYWlQVVcwMWJvMi8vaDQyODIwZnNpaEZFejhP?=
 =?utf-8?B?V25DNjFUU3MzaWpzSGRzOG9COFdtVVpaejE0ME5sK1MvVTZjeUtsdXZIOEtm?=
 =?utf-8?B?VWZzZ2diTjVGS0I0UXQwNVBhZWNqdGN5amhHNUNtNjlPcDhFWTU4YmhnNmtz?=
 =?utf-8?B?blVEelI3ZSt0TjVyaWtmSFdPN2JHUXl1K3hUOUJCUE1URTZ2Q1FCQXM3cHZL?=
 =?utf-8?B?dDdxMDd0VzNTUGwwdVVYMlRDejJ0UHlkTVZYQ3JuZXlVZHVPdFFaYWxlWVBZ?=
 =?utf-8?B?MERydFFkNEYzTHE1U053UHNPNFlVU3hzZmx3ZjZrdHVjVHhGaTZ4d0h2U0wv?=
 =?utf-8?B?U2NjalNDaWlFcmJiVGVKK3JMblZrblpVeGJFaGU5ZWdlUUpqQlRYeXVPdnht?=
 =?utf-8?B?UDZHSU9nbmhsREdTUmlpaE9PTjNZbmZDM1FWenE4Rzd5ZFJRd1Z6aU16TjYz?=
 =?utf-8?B?WmFGenljbEd5NFIvVUpKd2hOUHlGMDdZS21CTDEyNW5jZUtFZmdGWkZZWHV6?=
 =?utf-8?B?TjdoYkNtZmhndXRVSzI4am5lUFl1RlR3NU1FY3JVS2NYdDBrZFd2V0x1cEdO?=
 =?utf-8?B?RmVHcmlQRUlHWUloNkdBcUVzMGRZYk1CbXFqOGVMNzVld1REU2VTTmVFMkRV?=
 =?utf-8?B?ZnBrZWpDckZTdHNta1ZLTjVzQ1JPM0xGdWU1cXhtZllrMGtiS1BBMnJvR1ZD?=
 =?utf-8?B?MlowbytSeVV1SnFMR29MbFYzRnBXcmxDMWE2STFLQURSSXhQQnpjTWtqMkt6?=
 =?utf-8?B?bUlYekg2S2k2SlNFNVkrZTFDb3M2Z0Y3c1BxSmNaM2h5NmNyRVo5STV3Y1p2?=
 =?utf-8?B?NHArb0djeXJaZjg4bk4vejFWdlNMbUw0cnJWRDl0eFUxRS9KdCtqQjV1QjMy?=
 =?utf-8?B?N3VIb0QxWW9FQU9mSHZEK2VXN0NSK2tTQzdUZzAvc3FEVEt3b0cvL3VhRUU3?=
 =?utf-8?B?R0Y1Z1huVWdMcUYxYzUxeVR5MW9ML0ZoNEVTWWtIa0dtUXhYdXZGT2xlUHVM?=
 =?utf-8?B?QjYrVHpZclVmMURubGpmdENnMlVTcGlOUGsxU0VlWmRYYU5wbUppYkl3NWly?=
 =?utf-8?Q?ilPrih3ZdJnrLww6KC76Vv4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACBDD5C05C8F9B4180B68F632CE865F6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1e2c1b-a741-4044-f6c8-08dacec3d34a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 09:02:48.4727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gESZ4B4HUbpLU0Pao2zADjlpK+gQ332tiXQWl5Dr3VCzMFNSTaN2dmyYeTM+bmnl+zLTwImdZlGOgI0PgfcltFsupiuNzFr25NRxyV83xFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5801
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm90ZWQsIFRoYW5rcyBmb3IgdGhlIHJlbWluZGVyLg0KDQpCZXN0IFJlZ2FyZHMsDQpBbGxlbg0K
DQpPbiBGcmksIDIwMjItMTEtMjUgYXQgMDk6NTkgKzAxMDAsIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+IE9uIDI1LzExLzIwMjIgMDk6NDEsIEFsbGVuLUtIIENoZW5nICjnqIvlhqDli7Mp
IHdyb3RlOg0KPiA+IEhpIEtyenlzenRvZiwNCj4gPiANCj4gPiBJIGhhdmUgdXNlZCBnZXRfbWFp
bnRhaW5lcnMucGwgdG8gZ2V0IHRoZSBlbWFpbCBhZGRyZXNzIGFuZA0KPiA+IGFwb2xvZ2l6ZQ0K
PiA+IGZvciBub3Qgc2VlaW5nIHRoZSBkaWZmZXJlbmNlLg0KPiA+IA0KPiA+IERvIHlvdSBtZWFu
ICIrZHQiIGluIGVtYWlsIGFkZHJlc3M/DQo+IA0KPiBZZXMuIERvbid0IHdyaXRlIGVtYWlsIGFk
ZHJlc3NlcyBtYW51YWxseSBidXQgdXNlIHNjcmlwdHMvYmFzaA0KPiBhbGlhc2VzDQo+IHRvIGdl
dCB0aGUgb3V0cHV0Li4uIG9yIENUUkwrQyBhbmQgQ1RSTCtWLg0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCj4gDQo=
