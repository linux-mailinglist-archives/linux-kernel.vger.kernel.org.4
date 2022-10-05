Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6535F4EF7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJED5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJED5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:57:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA7570E4E;
        Tue,  4 Oct 2022 20:57:16 -0700 (PDT)
X-UUID: fbdf604b823c448fb117105d1e0ba72b-20221005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nIHHfUlJDXVpgtqg13/eurjZmb5GMAdaejR9zDOKaH4=;
        b=tMwcR6hV4eDMfDK+4WHMtLQvbOu71IK4YQgClJrW862e/qz1cuTQiezpd5YaQBpcGfB1UQIxDL82SXZPaMoQlRq/8iEG7Ga2i5nrst71arIrBWEwFSSs9N8JIGvaq3M37nfoJAYhE85++FKQ/CMuG3r3YMkTi9ksNiDyZ96JZkM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:bcb0b55b-0395-4dca-8099-7941c21d530b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.11,REQID:bcb0b55b-0395-4dca-8099-7941c21d530b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:f14a44fe-ee8c-4ff7-afe9-644435e96625,B
        ulkID:221005115712MUNIIPD2,BulkQuantity:0,Recheck:0,SF:17|19|823|824|102,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: fbdf604b823c448fb117105d1e0ba72b-20221005
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 218065282; Wed, 05 Oct 2022 11:57:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 5 Oct 2022 11:57:08 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 5 Oct 2022 11:57:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPkMtkzNFqQIBUOK6DTDkz25SvBcDlLycmHygWY9PooQsJxW9+6SryLT80ngW+TBFm/9bWu1kd8FG4F9DGueH9Vh7s+nVWcSmSU1ZlJsv9O/W2t4n2+QbODM+4LRI2PKyqvC2I7ZFnSxNMD5wwpTsCKX++v8mtA3siAaJu4z/y5tH/KZgvHODYdBP9sXOhiOULBDUXkrhKQKHoEpW9axiuIrG698OvkV2DI6qPIMzhz5gx7f9OU0k0Vbay5TcwwB5OJd4q7QKTeq+knNfjqvCoheXhIWcoXSPmfH2pjU/kv3lQWxqxO//cpbBwNgE1epX1EywwCt4rj3kJDruP31KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIHHfUlJDXVpgtqg13/eurjZmb5GMAdaejR9zDOKaH4=;
 b=NV0FKNHRFsqFpa239rcVI970EZ5BO4UWOxpNkZfHa0qmuCb4R3ZXA6i2Aoa8EG2EBuYV6SWblR7hclimwV+pHCvP0L33LYpewnLZm7j+5nO9VawZfqH6Aa8E7HkKOECFYryc9b09Z+cWNIo/VC1kDNoEWT+Bn5IKT8fXU84knuLQdxjg9XAVz0ax/6t5sk5UUCdl75q40JJMkd2XkaBu6bnjOyDvf1fxMqOAGY1Zct2l9mAurSWNSPZBYRFrVUiLhjxFu2lM/7uYA4A+nk1lryHb7Ik1qRmthreGvZyXj99HzpYM4P0cP1XEAt5gQ3D6h754ivuhgMQ/0tHyufEmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIHHfUlJDXVpgtqg13/eurjZmb5GMAdaejR9zDOKaH4=;
 b=GnKDkPVePWJrNECBVE+JpJwayMpHC6buwBvdsoi/hkESAxP+iwxU4TLoYLH2e82/3U7H7r9R+X2va5+d+tGRV3hbLpKC0Qb1mL/OAWYDSxbuqJrk3GBHaULNppKOS/y25ZaYXE2JeMT1wMIlzHwZd/T+RU1piD5rsFfZHPANu5s=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by KL1PR0302MB5265.apcprd03.prod.outlook.com (2603:1096:820:4d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.9; Wed, 5 Oct
 2022 03:57:06 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3035:799a:e0e2:26ff]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3035:799a:e0e2:26ff%3]) with mapi id 15.20.5676.014; Wed, 5 Oct 2022
 03:57:06 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Topic: [PATCH 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Index: AQHY1N0GYtqVfkKJC0GvFF093atjZq34h9eAgAarf4A=
Date:   Wed, 5 Oct 2022 03:57:06 +0000
Message-ID: <ac5d872ac8dfa40bd5238589f85d78ad6ba6d706.camel@mediatek.com>
References: <20220930145701.18790-1-trevor.wu@mediatek.com>
         <20220930145701.18790-11-trevor.wu@mediatek.com>
         <166457526101.1112313.13428811477972046652.robh@kernel.org>
In-Reply-To: <166457526101.1112313.13428811477972046652.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|KL1PR0302MB5265:EE_
x-ms-office365-filtering-correlation-id: f092e3d3-9803-47f1-2536-08daa685ab58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1z1sIur+CBFI4XqyXJO8vGxSNNNMl+MLvxV4oF4C6hgzZ7/xGA45I2teGMcb1bB7SZF3B62hFXi67pmBdgby96K5DqpyjpfpM748YOcfTpqvDyWGgtgFzO4Q8Q8CNbSa0ZNzYEDd4f82qWz3o94m79U40bXaHWiTi2zFcWEV6UshhwXSFMacjtIFRxPxbAQqWrNr9/2PeadAWAESrL8L6hlBZ2I+TFwRFk0HsYiAWEKTY62gqjuRAMfldCDafW+canFQDcSGMR5YEzkNf/3tS3b1dW1ZOMboHnXiSgp+I1qElg3b7JAXJi4lU8Mmt2CtI4/Bhm8xRuC5Mxec84dQCLAsdrySnMraRk348QENHzcq5vfl5jH02rB7gVtSQHxNM9JmSMhDS+J6ms0fHiIwNF1UOSGm7nKWd9cDs/37KtB7PgcLrxnA+jT/u78TyrD4jWd3TQUuUKKlK+QHZ5UJjc5YfAJn0RHl+8IG+l5JFc92j60KdyozPNmVDstwX1mMqTAc2l9kDytqVHAGAVPLV2oUnW2fSUo8Rrx108IKYbizAS6reqvWUWq7tvb5G1eDj/USp13IeBjBqV4adEr03yZskd1iH/c9ehdmPFQZ4Au1KGDlSlbxhdCabuJB8oHOv0gruIxrIfG8fc67G3ybXeAo9T1EKKNAQ6zAcUPOZ3803iz/F/P6iPbjDYcJHbOv5bgSzMLggZQLbnInM63qOvWLG8q6TM2xrFgriYo89rFo1k4sQuSqLYwph8sBgeABFP+ceL8kaeIoo3nTbggcoqXXelUd1c+qXGXux/Xyw3a2yOjTPr6+Gj6odTQS3CYCmD2UlPfwNE/JgHJVLWU7aMAC6y/UdXawE4WGjCmUPo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(66946007)(66446008)(8676002)(66476007)(66556008)(64756008)(4326008)(85182001)(86362001)(41300700001)(36756003)(2906002)(76116006)(316002)(54906003)(91956017)(26005)(6512007)(6916009)(2616005)(71200400001)(186003)(966005)(6486002)(38070700005)(83380400001)(478600001)(38100700002)(6506007)(122000001)(8936002)(7416002)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aC9SSVdvQkdqVkVnb1NRY1k1Z3VodlUxaXlyYzlBWkV3cUEzcElORzl3YURt?=
 =?utf-8?B?Yks3MnYvQUxLcFI3RmxjeTZwOGl2dXBwdms5YmZ2eFNscjgyQ0RqYWwxNlF1?=
 =?utf-8?B?Z0VDd0YzOFNyd25HUnRpZG1uUEZFQWFkRWlITjFsUkZQNmh2OTJhRnplMW9o?=
 =?utf-8?B?TVNodUhnbjl2MEJIaTZaanV6TWZvYTMvTHdYaG9nNEM5cDU5ejNvQmV4b3pS?=
 =?utf-8?B?Y3BpbFlES3RBZXR2Z0JlNlVhRVpkVUI4RWtjeDZTdEVQdmc4c1plRDBDRUxy?=
 =?utf-8?B?SFpNUXcvL2lPeDYyV2NxRHpxcXphUjJTdjYzU2RkZ2k2QmxyYTZmM3lWZnBQ?=
 =?utf-8?B?dXZPUmxDdkNkVkFDMmNyYzd5cXRIUlpqOGd4bGU3d2ltNHUrOUlXa1BzcHEr?=
 =?utf-8?B?V2FHMXJzblNyYXhDZGd5dXk0Ull0NUYyQ3FkejJ4V3dwcjJXb0JsYndDTlhp?=
 =?utf-8?B?OTVNNSt1YnUwVFFFajA3Rjk4L1V6d2lMVHF6dEo2UTJaRjFaM245MnBZblpP?=
 =?utf-8?B?L1J2My96Y2VWcDNoek9YbWNISHltTkttZkh6RWcrL1BxMm5hVjJyRFJ0RStK?=
 =?utf-8?B?ZFV4U29ERFBtY0RmSTlZeGNYNk5qNndTMS9uUGdNMFRxOGxLbkhrUXVxMDRY?=
 =?utf-8?B?WHBDZVRmeE1BU0w1MVAzL0RkNE55b2U4L1MxMFdteXJ3NW4rcm5KMHhhQjRN?=
 =?utf-8?B?ZGs1cDlaem82VXdKK2FKM01zRDhPaEN5UGxQNmNQS0d4dzR6c1g2RkJHcjY1?=
 =?utf-8?B?aGhLVDZEVS9kR0lXeGw0MUdGSlZadWR6SDJSODFESFJuN2lCZHRja3JuWFdO?=
 =?utf-8?B?T2xIWC9BRkprY0xwTDRjNlVsbmhuY0o5TGs4RTJVNjlYNjB5TnI3MENRUW5G?=
 =?utf-8?B?S3kxR21MNXZ3eW9OVUgxbEVIR0JJUVFPMTgvdFdQNXRHOEFoYVJwcG5sQkN4?=
 =?utf-8?B?c2J1YjR5ajVQc2dTVVZlOWdNaHNhcnkvclRmWHRReURMM2cxRlZYNTBlRGE3?=
 =?utf-8?B?Wjc3bEV4UFZuUU9pNkpNaEN4b1J3cGV2UldaSFRNK3VzeGdtVHpGbFg3K0Vv?=
 =?utf-8?B?aVMwWEpJSk1EZUZnVVdxbDIwNDh1Z2VoTU44SE9NbE1aKy9XR1dhRVo1Tmdm?=
 =?utf-8?B?OFZsNEFaSC93aCs3bnJaUzQyVE1aNml3RFNSYkNjdC8zMmF0dDRSYitMOGZj?=
 =?utf-8?B?VDJ6ZU9TN2NpSytJbk1sVFdpM2F4SzY2SnZWNE1TZUFPcFpmRVVySmhxempu?=
 =?utf-8?B?ZUpsc29KWW1SUHcvRDk2WnFvQ0RVU0Nrek4vckFHQzZmNTN3Yk5LREMxNldE?=
 =?utf-8?B?MXRDMTNhRk1oQjMxTHp0aHVVMTZRTEFUUnZNMW0zMlJ4RFRzaGJKTjI2VERq?=
 =?utf-8?B?YkUvMW82ekVWdkR0ZWM5YkVFYjRjSGtPR2h0V3FRdU8zMkRFcFN1UXNJS0I0?=
 =?utf-8?B?ZUY0RGdQL1hMU2NFTDdQd25uaEtIVDlRT0ljem1PQ0U3Uy9jTnRDd2Z2QkV5?=
 =?utf-8?B?aWc5djZxUS9WOWRlYk16SzF5eVNXZk1UOXArNlQ5S2tvRHR0S1NFVjV5RHBH?=
 =?utf-8?B?RE9EbU9oaDJBaWRYUUpqME4xdjQ4cmZmaUtVL3p3cmNvN1pmZkZnZEQwK2J6?=
 =?utf-8?B?di9CanlEaEMzbHZRVmpGRXYyRkpCMUM1WjlWR1dFQ0k1Q3ZndkdpUUEvOElo?=
 =?utf-8?B?cU1hRUY1NzM2SzNVSllGa0ZyRHJCOW5kNmQrSHcweVM2SzltN1JiZ2JQSE5t?=
 =?utf-8?B?Z2ovUnZiMXdaMmY5cTBTeUhFQTV4VlFXQUdRZmIvcVh1ck1lMHJtZXJtdSt3?=
 =?utf-8?B?RkY0b3FGaDlYTnJINDgwNFR0OUtFUmt0OWFyekJycnErOEIyREJycVh3alBo?=
 =?utf-8?B?ZmhWbUdaZExVTnVpYjl4RzlPdFNHN2gwcHRxQnRHWk13a1FxNTNNdUkzNzdO?=
 =?utf-8?B?MEd3QlJ4dXRyWlpGem96a3F5WFIxa0RvaVpsWUMyOEZycG9ldEtyTlQrLytD?=
 =?utf-8?B?aTNOcjh3bXpmQlNxU2oxUnEyYlBGWkZvVDRtTkVPdzFRZHQ0bVpyejI5ajNP?=
 =?utf-8?B?dU1KMzA4ZS9WU2cyOXBDRnV0aVppRWQ4OEJjUmM3UjU0UG9xNk1iVGxJVWxi?=
 =?utf-8?B?MXE0V1NzdmZBYS9HWUt6SG0vaTcxRHZHKzZMYmV2NDArOFFJNnhocFZpdkVZ?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E26E632BFDFA74A8C668E600F8F9AF6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f092e3d3-9803-47f1-2536-08daa685ab58
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 03:57:06.1732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbnI2qJqRHHNGl+5lxuijSg0Ek/DzEFC1uV54n54ce/12jVLYnJyBO83Lh6Ery98JCACcgiRconLYqXUilJjUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5265
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTMwIGF0IDE3OjA1IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gRnJpLCAzMCBTZXAgMjAyMiAyMjo1Njo1OSArMDgwMCwgVHJldm9yIFd1IHdyb3RlOg0KPiA+
IEFkZCBtdDgxODggYXVkaW8gYWZlIGRvY3VtZW50Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFRyZXZvciBXdSA8dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2Jp
bmRpbmdzL3NvdW5kL210ODE4OC1hZmUtcGNtLnlhbWwgICAgICAgIHwgMjAyDQo+ID4gKysrKysr
KysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMDIgaW5zZXJ0aW9ucygrKQ0KPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
dW5kL210ODE4OC0NCj4gPiBhZmUtcGNtLnlhbWwNCj4gPiANCj4gDQo+IE15IGJvdCBmb3VuZCBl
cnJvcnMgcnVubmluZyAnbWFrZSBEVF9DSEVDS0VSX0ZMQUdTPS1tDQo+IGR0X2JpbmRpbmdfY2hl
Y2snDQo+IG9uIHlvdXIgcGF0Y2ggKERUX0NIRUNLRVJfRkxBR1MgaXMgbmV3IGluIHY1LjEzKToN
Cj4gDQo+IHlhbWxsaW50IHdhcm5pbmdzL2Vycm9yczoNCj4gDQo+IGR0c2NoZW1hL2R0YyB3YXJu
aW5ncy9lcnJvcnM6DQo+IC9idWlsZHMvcm9iaGVycmluZy9kdC1yZXZpZXctDQo+IGNpL2xpbnV4
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgxODgtYWZlLQ0KPiBw
Y20uZXhhbXBsZS5kdGI6IGFmZUAxMGIxMDAwMDogY2xvY2stbmFtZXM6MTc6ICdhZHNwX2F1ZGlv
MjZtJyB3YXMNCj4gZXhwZWN0ZWQNCj4gCUZyb20gc2NoZW1hOiAvYnVpbGRzL3JvYmhlcnJpbmcv
ZHQtcmV2aWV3LQ0KPiBjaS9saW51eC9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c291bmQvbXQ4MTg4LWFmZS1wY20ueWFtbA0KPiANCj4gZG9jIHJlZmVyZW5jZSBlcnJvcnMgKG1h
a2UgcmVmY2hlY2tkb2NzKToNCj4gDQo+IFNlZSBodHRwczovL3BhdGNod29yay5vemxhYnMub3Jn
L3BhdGNoLw0KPiANCj4gVGhpcyBjaGVjayBjYW4gZmFpbCBpZiB0aGVyZSBhcmUgYW55IGRlcGVu
ZGVuY2llcy4gVGhlIGJhc2UgZm9yIGENCj4gcGF0Y2gNCj4gc2VyaWVzIGlzIGdlbmVyYWxseSB0
aGUgbW9zdCByZWNlbnQgcmMxLg0KPiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2Jp
bmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZQ0KPiBlcnJvcihzKSwgdGhlbiBt
YWtlIHN1cmUgJ3lhbWxsaW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0LXNjaGVtYSBpcyB1cA0KPiB0
bw0KPiBkYXRlOg0KPiANCj4gcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0KPiANCj4g
UGxlYXNlIGNoZWNrIGFuZCByZS1zdWJtaXQuDQo+IA0KDQpBZnRlciB1cGdyYWRpbmcgZHRzY2hl
bWEsIEkgY2FuIHNlZSB0aGUgcHJvYmxlbS4NCkkgd2lsbCBjb3JyZWN0IGl0IGluIFYyLg0KDQpU
aGFua3MsDQpUcmV2b3INCg==
