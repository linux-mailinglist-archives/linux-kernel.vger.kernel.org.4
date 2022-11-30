Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384A363D045
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiK3ITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiK3ISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:18:47 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C4C54B10;
        Wed, 30 Nov 2022 00:18:40 -0800 (PST)
X-UUID: 3d439a9516b14f4a99eea5ba3d2148f0-20221130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=G+Mzj1gghrnQSQ2ypoE97n6YvWS9GrxUV/WLch6YotA=;
        b=T3NPcsTEQW6ioIuN8KSobCBbYQ2ez2fMbumOzQhxBdz0xqCD6BSdGgeIezeRzR99WA6GMeBuyguMSA6S0Ewp/VN0LdrLR2EmFJe6Vl4KIsWsRQamx9FPD0MUWisE3+p/K9N73H1kVknmV3ZCnCnwj1WiAniP+R9wPq3caWkkFL0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:1466fc1d-85d1-43bc-8a23-f7360484d4a2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:74a9b91e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3d439a9516b14f4a99eea5ba3d2148f0-20221130
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1316519832; Wed, 30 Nov 2022 16:18:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 30 Nov 2022 16:18:31 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 30 Nov 2022 16:18:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKwhIHtNmHkHbR6V6VcrghV+2wwJSaenPBMc88WtoHmMq4R9+RGv8Ozy0VCB7LgbfgBw0CeD3UqQQvdtINL6d3MRwz+zMWi6TArelfg+9fp5Tth4rIZpH6pZv9OkUTU1IqRodMa6nq0tpWhly8iwRrVst7lmdXrU62aRtP73TfHElf8wfvEwbLcteg8tz0AYYglkvxp5KS9810elOOhmVic6sIgfG0hw2jaZ+3lFBAR4NTU869uA+VdIC2KR8DvREW3rbikdXEILkNlVhoYkOlj0FWe/Q9aUk0VZScLQ9usd0m9USeW0S8V++FpjPOlJFsX697og6WspYdSs34QpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+Mzj1gghrnQSQ2ypoE97n6YvWS9GrxUV/WLch6YotA=;
 b=EZGqgIyzRPpl65428/Pq0bRWQBl07BGkN5zFPKC48GGILexKTwUamDuxn/TFf+VFB+1lk1ztI4JDYboEZW+nahfb3WHhX/ETGXE5QvOx4oEqjZpUJP7CX9ptvJMwI4mZDU0vpsTVRA91VWfrm6vW1D4FBrtvC05ZR3Fh8mmpfYsoCEXq7/16wrjMTRBT1XfX3InpSUL/aXuUYMfQvlj8V02fC9o00Boy4Hds34U+G5y+N6WgGSbM3XbGgcLNvBTzuZVkbGygi6+vYmhXnok7Cp3EdW9/qxQUw20p84LY9aGGuCqF2tjFV5lG+plmiScxEwtyAmhaKQKHgJKas6/39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+Mzj1gghrnQSQ2ypoE97n6YvWS9GrxUV/WLch6YotA=;
 b=HbJ8N/dcNMiZVci3Tay9iPyAsxasJ0/lW32QcLiwafUn1nB1GD6M9lQbkvpZvqW2js4ydZ1o22ZhNOyXwp8axEtEvNZGzhz/O5pIkztfolK+FsalnmVkCtv2CtUP9IppzJAnIw30N2V0AC8z9ubz6GbpboML/zNh4vohgU+RnZI=
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com (2603:1096:4:84::10) by
 KL1PR0302MB5202.apcprd03.prod.outlook.com (2603:1096:820:4d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 08:18:30 +0000
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::6f36:b7bc:7906:b179]) by SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::6f36:b7bc:7906:b179%6]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 08:18:29 +0000
From:   =?utf-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
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
Subject: Re: [PATCH 7/9] dt-bindings: spi: mtk-snfi: add two timing delay
 property
Thread-Topic: [PATCH 7/9] dt-bindings: spi: mtk-snfi: add two timing delay
 property
Thread-Index: AQHZAs5U3hXZdqvH5kqzlnM2fDcg7K5UC1yAgAEpsICAAFLkgIABmxkA
Date:   Wed, 30 Nov 2022 08:18:29 +0000
Message-ID: <741d7ce16df25450b08c92e508190bc7c91fc8d9.camel@mediatek.com>
References: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
         <20221128020613.14821-8-xiangsheng.hou@mediatek.com>
         <9985d44e-977e-d7ea-0932-4879a3ccd14d@linaro.org>
         <f83184ae803dbe0afd37a31a8a83a369a9772880.camel@mediatek.com>
         <08ebc76a-0220-f984-b546-23dba8677be9@linaro.org>
In-Reply-To: <08ebc76a-0220-f984-b546-23dba8677be9@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4565:EE_|KL1PR0302MB5202:EE_
x-ms-office365-filtering-correlation-id: 40150738-ee66-4510-c72b-08dad2ab76ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gIzRTKTdYHtFsq+WfONOWPxOxW9l9eX1tMqMtzcHX1aGdgh+dKxVU5foXi0QE8nksip3xaWJtC+70YcQPB9ma1o0sZJ2B16kFKNfSTPlqmbHlPqXxbjn397d2PgItzAh2xvekPp/9CBw9pCk/vJKNIQ40nQaHSA1DlX3zA08a4Nt6UuNabKcVhIMdmctbwxsSGJsESj86Ps4292vr0tFDT1ffObLcRdhrLonaqAosX+1xg34M4G/Q5Vk8aDP5lkIrEU3tmQyiDTXGR7WISetj8ua+AFl3N2cZ+2lmk2MMAGk2vjdOVZtfutxLCQjgds0zFWOoZ/TypKV3vA/DAENemb+AtDgBvtjoqhb6rcBUeIUtug6LzEJlLvK2547srM6LsbTOiP6A6aURrCsVjsmasKlv8jX416zWYrzYC+bRmCw69yRJ5Dh1ppEXw+uGLZuw3/ZkfNI44euG46qhCFkkX90oYVCgaowMEwfzWUoxbrNbwqJjTdc/w/diFhC0hzEcmf4gUoyqu/fP5xZEuFjHh1GKxbYM1/V8mjS61Wb+edIAijyMK6G0zh8fmhUKs46ab51G1XCx3dj4G5t0CLNe6s7AV+2ksM9PSiunCZEValOKCq+L02PspoDw9WUTQAk0QyOxNj1LSFieKlPJ4CSzWbe+HHaMeTHvDBxdJOKp2LvtL3MKw66UpSgCKt4I9x6h6RTbeqZPw4YyYRJ1dV2lATP4+vf97KLbo9p9ox1IrIUqbZiO0wh30NNaxBzDL38
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4565.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(38070700005)(85182001)(36756003)(54906003)(6512007)(478600001)(110136005)(316002)(6486002)(8676002)(5660300002)(66476007)(91956017)(66556008)(66446008)(64756008)(7416002)(76116006)(8936002)(41300700001)(4001150100001)(66946007)(26005)(38100700002)(71200400001)(122000001)(86362001)(4326008)(53546011)(2906002)(6506007)(107886003)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDl0ZXV1SURqV3NqMTFKSnhsZlhQY3V5TWs3Yzl2Zmx1bjhBUWpybllxTHVx?=
 =?utf-8?B?MldQckVxa3BJWmU0QU5ONGdqSXJMUDRNN2JNYzF2RnEvZHFucE5SNUo4cElE?=
 =?utf-8?B?MmtKSVl2WXBmMDdIVWt4eEpYZjBBemZmQ2pkOUFmaXpwb2ZNOUtsbHpaRXla?=
 =?utf-8?B?ekU4QXRuaUZ6Z2YxRjRyZ04rSDkrV2lpOFdaYWxZM2psZi91M1dkMnNWOEZD?=
 =?utf-8?B?NktHcEpYaTZlQ0dWdjRZWThXaFcyNDgwbyt0eStySEdMN2lrSEFzRlBOQUtr?=
 =?utf-8?B?bGY1M253dldISllhQWwxWW41R3RPQzhqd2NiYklrVDdRY2lxbmJ2ZkFwZmEr?=
 =?utf-8?B?ZXNJMm9mTnc4anFEaitWeTVYcDJCcDRVV2J0UFNMNldMT3NDamVRejZwWEhB?=
 =?utf-8?B?LzcxVUFidnIyam5XbVdteHUwdFhPNVZWMWNWUjJsczArdEJPTExsMVJnK1N3?=
 =?utf-8?B?Ukp3ZE1YVGRnN1FPV0VJVU1DbFFvSFNiS2tkWFFaL2pqVmNaQWhiZ0lhN2l4?=
 =?utf-8?B?UnNleUpjOHBaM2h6N3c0MGE5djNxN2RqY3ZBZGk2RmNBT2gvbGkyM3N5NmNV?=
 =?utf-8?B?Ukl1SS9tamplWHYrSSt5RVJhK0dQd2M2N1VCeFVqNXBiNGJHN0JyT2RkWC9E?=
 =?utf-8?B?TnBidUx6UWZZd0hCQWx1akFrd3IyN092VTd4RXVHUm9BRkN0TDNjSm1uUVJF?=
 =?utf-8?B?SGVzYjV3Ung4c2FYRDhYRHQrVTV0MlltMlNTVGhCaVBOQ2FXQ0xWL3NqK3Jr?=
 =?utf-8?B?TWtrZlZJeFQzK3g1dVRDcXUyQk9vdHdxMGxPS0RXMVZyTzJlUkJ3VUozekNS?=
 =?utf-8?B?NlFPeWRoUzI3c0JOMnQ5SVFhR05hd0ZobW1mU09nMS9DRUxiSUl3MUNwOWE1?=
 =?utf-8?B?dzBtdTVkOU9UekhRMDhWQmFvNWhqaVM0SnBnenZBa1VDZVY0V08zeitVNy80?=
 =?utf-8?B?K0ZmSnF2NE5FRGdseWsrK3h6UytIcWhFZURTZ3JlbDVzK1dGL0NId2FjUUx2?=
 =?utf-8?B?R01qOFFCY2FZVmFEcXRwVE83ZDRYYkMvblo1RVg2RGtOeDdpcStja0Y2eGNF?=
 =?utf-8?B?dGMrS3RaK1BUcnAxSjJrTnUvQW9JQ0pndUhNRE5ld1o2bU95OC9GRFVTQ0kx?=
 =?utf-8?B?TGNGNWpPcDc0TFZxSStCV2IyRjR0blczTTVLOHpzSVJLSk00cmhhSjU0R3dm?=
 =?utf-8?B?QzVVVDhWbC9lcHFsNVFaZ2JhQWYwMHBoQTYwMnBjRGFTZ0hjajJyZDFTZGtI?=
 =?utf-8?B?Z2lqNGhqUkVRSEdBRE1LU0tkbFE0Y2g5NjZYZjB6aEkwSHZEU0JxSlhXTkYv?=
 =?utf-8?B?Z1E2cXNnSi9UNTBGVGszOE8yMXBaV2dCKys4blNYSW1qRlVqeFJFaTJDOVlY?=
 =?utf-8?B?Rk5IeUNPa2l2a3JGUm50ZzVvK01sT3VNTkVScHlxSG1JTkNtTVBleU5PWWNG?=
 =?utf-8?B?OVlYeXF2M0FsMnZFOGUyUXE1T0dadlRXVHloaXI2aU11OEN6djkwNFZXeTVl?=
 =?utf-8?B?bVM2M1hKMGlkcXVjczk2ZkI1ckFtb1lodzdDL1A3bCtLUTgxRFp0cUFTL3N0?=
 =?utf-8?B?UFBLSVRFVWFxOTVudVlnUG5kMFpwZXVaUlJTdzNLTzRiVmRuZzZzM1crd2Vq?=
 =?utf-8?B?bG5iUlZwRkdDendWbzNJUjhYYjRYeDJwbTRxaWpSTXZjUVFpeThTMElQQnc4?=
 =?utf-8?B?MkVOVFF3ZGVVbVh0bXc0TzI0eldtQXZWZ3lCaFBFdVBkaDBlRFd3VVlacDJx?=
 =?utf-8?B?QU55SVhYTkJ5a1d2REsxM1BVSzc4VWRVNk54dEFtSEM0NXNMT1JFQmxYbFNP?=
 =?utf-8?B?WDZuZGVMVDJnV0dTM1hITHM2cnBxNjduNmF0WTFOZSs0cURzWjBid3BtTHRD?=
 =?utf-8?B?dER3cUpTSW5mYWo0bnc1NVdkYVZhQjJzZXFVODBFbC9PTDJMTWp4c2FLb0VB?=
 =?utf-8?B?SzgvS1dKZGc2SXFVdEcyUUttQk05NkpvMFVmQWpzUDJBaE94TnMrUnVlSE5Z?=
 =?utf-8?B?SVdVMGo0anYxWXJBbGtaOVcyM2RCZVFIYm8zWnVZYjdLS2NVWjhUcjNGTkh0?=
 =?utf-8?B?OFl5eHdWWUxUbysxc3NSeUxxVjdUQytoalNldVdYM1diOEtpVVpVMWFBbCt0?=
 =?utf-8?B?cW1wNXduOUZMWHV3cFVTendRU1lkVHo2OU1mbFBCR2lVanhSQjhYNUhnbUwz?=
 =?utf-8?Q?FByTj40SCqhs/fuVxzjuiPE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29678A15B0A0E14DB6BD91EC60A88591@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4565.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40150738-ee66-4510-c72b-08dad2ab76ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 08:18:29.8374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1SuBiQAH5BjMTvvT0wYz5qcdumk9PPFJXpsVcPXb5Lr8uO04/RoWcivBjHX32X9XxY4pLSMYljnpJH25vaWn7kB9dptGVxclJXZpjJoW48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBUdWUsIDIwMjItMTEtMjkgYXQgMDg6NDcgKzAxMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDI5LzExLzIwMjIgMDM6NTAsIFhpYW5nc2hlbmcg
SG91ICjkvq/npaXog5wpIHdyb3RlOg0KPiANCj4gPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9tZWRpYXRlayxzcGktbXRrLQ0KPiA+ID4gPiBzbmZpLnlh
bWwNCj4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9t
ZWRpYXRlayxzcGktbXRrLQ0KPiA+ID4gPiBzbmZpLnlhbWwNCj4gPiA+ID4gQEAgLTU1LDYgKzU1
LDIyIEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ICAgICAgZGVzY3JpcHRpb246IGRldmljZS10cmVl
IG5vZGUgb2YgdGhlIGFjY29tcGFueWluZyBFQ0MNCj4gPiA+ID4gZW5naW5lLg0KPiA+ID4gPiAg
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4gPiA+
ID4gIA0KPiA+ID4gPiArICByeC1zYW1wbGUtZGVsYXk6DQo+ID4gPiANCj4gPiA+IE5vLCB1c2Ug
ZXhpc3RpbmcgcHJvcGVydHksIGRvbid0IGludmVudCB5b3VyIG93biBzdHVmZiAtIG1pc3NpbmcN
Cj4gPiA+IHVuaXQNCj4gPiA+IHN1ZmZpeC4gU2VlIHNwaS1wZXJpcGhlcmFsLXByb3BzLnlhbWwu
DQo+ID4gDQo+ID4gV2lsbCBjaGFuZ2UgdG8gb3RoZXIgcHJpdmF0ZSBwcm9wZXJ0eS4gVGhlIHJl
YWQgc2FtcGxlIGRlbGF5IHdpdGgNCj4gPiBNZWRpYVRlayBTUEkgTkFORCBjb250cm9sbGVyIGNh
biBiZSBzZXQgd2l0aCB2YWx1ZXMgZnJvbSAwIHRvIDQ3Lg0KPiA+IEhvd2V2ZXIsIGl0YHMgZGlm
ZmljdWx0IHRvIHNheSB0aGUgdW5pdCBvZiBlYWNoIHZhdWxlLCBiZWNhdXNlIHRoZQ0KPiA+IHVu
aXQNCj4gPiB2YWx1ZSB3aWxsIGJlIGRpZmZlcmVuY2Ugd2l0aCBkaWZmZXJlbnQgY2hpcCBwcm9j
ZXNzIG9yIGRpZmZlcmVudA0KPiA+IGNvcm5lciBJQy4NCj4gDQo+IFdoeSB5b3UgY2Fubm90IHVz
ZSBzYW1lIGZvcm11bGEgYXMgb3RoZXIgU1BJIGRyaXZlcnMgZm9yIHNhbXBsZS0NCj4gZGVsYXk/
DQo+IEFuZCBkaXZpZGUvbXVsdGlwbGUgYnkgc29tZSBmYWN0b3Igc3BlY2lmaWMgdG8gU29DLCB3
aGljaCBpcyB0YWtlbg0KPiBmcm9tDQo+IGRyaXZlcl9kYXRhPw0KDQpFdmVuIGZvciBzcGVjaWZp
YyBTb0MsIHRoZSB1bml0IG9mIHNhbXBsZSBkZWxheSBtYXkgYmUgdmFyaW91cyB3aXRoDQpkaWZm
ZXJlbnQgY29ybmVyIElDLg0KQmVzaWRlcywgd2hldGhlciBpdGBzIGFjY2VwdGFibGUgYnkgY2hh
bmdlIHRoZSBwcm9wZXJ0eSByeC1zYW1wbGUtZGVsYXkgDQphbmQgcngtbGF0Y2gtbGF0ZW5jeSB0
byBtZWRpYXRlayxyeC1zYW1wbGUtZGVsYXkgYW5kIG1lZGlhdGVrLHJ4LWxhdGNoLQ0KbGF0ZW5j
eT8NCg0KVGhhbmtzDQpYaWFuZ3NoZW5nIEhvdQ0K
