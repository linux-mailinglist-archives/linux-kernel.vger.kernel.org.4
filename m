Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC02691860
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjBJGNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBJGNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:13:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A353526CDD;
        Thu,  9 Feb 2023 22:13:32 -0800 (PST)
X-UUID: 09553d4ea90a11ed945fc101203acc17-20230210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Dsdx/rBfrktV3ClM0i2dlD0lP4Xzhx4v4W5XyVRISEU=;
        b=eQRhx71wteEjPveq2/co5oeILpGwH/t6GDa46lw+FotsHqBxn8OPdMY57dCurftdIhY6aZ0RcE/cv5geWf3Auq03/UF5vkdbI49qog6FnmEw3PxsdLrUkMz8FeqTjkcH08ny20i/LcGZvW1/7pqWuFrWGuy+Spr3AYwv9Vawvss=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:e2d1ac2e-a2c3-480c-a019-c9992ac52ea6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:d8d17a8e-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 09553d4ea90a11ed945fc101203acc17-20230210
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2065509431; Fri, 10 Feb 2023 14:13:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 10 Feb 2023 14:13:27 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 10 Feb 2023 14:13:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgBQtvw9TRLdHlWaO8LOqZf0e1FgFph2oFwZaiJb0U6eUk2yyUYyyXu9SB8N3aU+PdD+5b4lcxXChQXNFeE3nMfrs6Kduo4E48Qm3kx2/voQCWT8XKdLjiHINLJWhORXUU+bR21j83hPKChhV8eeCMpiOBRzd0+1F4WmqwIl8zZBqKefGZX/tZ5n1sDR76iL+LeKeGyGUoxcExi8/G/tTlLV+L/YIOvfdKCRACNK7Ll31M2WmVgpL1JOjVySq46mIe6NL76OipkFVRGzS/Vc9XKYaQ91nE+m16V8pC9CNmtGsImOWcnPVBgOYRSUcOFmUX5qXVNEtuUplNGfMMy0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dsdx/rBfrktV3ClM0i2dlD0lP4Xzhx4v4W5XyVRISEU=;
 b=RU4rruxiJJWthFKcIZIeUqqfpX7x5btKsF2JUEoItdqPWh89rUaK3MyJ8y3PAIm42ABIITe1Atf3HpHGjvsDRvu8y98Kb3pozDYOLro0vNNSuvIb7mBaxY9Qgg8AvV9UcQPdxqizrEEfh21nD6uAS6SRpuiqBHO0P6EoVj9SOsQsxISvSirGSwRHHr6nTlvKk5/7PTUXt89r2oLYgMuDqk4MmkjUZ+qJSIUUCqSLZLiulJaHYPAiGF9WlaO+KnqWGEqGxUdYcl4moljJNA1TIuDZ2AVluqetBkWAwj1YwFp652PRPceA26OMx0wi3e+TmnDHvUIHAiS6mRrCeZl9Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dsdx/rBfrktV3ClM0i2dlD0lP4Xzhx4v4W5XyVRISEU=;
 b=gLIPzQvuW0rqPEsGD8Svl6K9nm6idy1yYFjVU3IotCfqVQec5jYcMRNB2VmGHfRqkp3huSASwT6OUzxK/9B8rgxSPONCcu8oDrrbsp/TljCtROQnkZHUjoLKVEBixnKWlwQLhpvUjNJ7IYmFsLGvKXL17t+BLWjBEMxXa4iIbO0=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 PSAPR03MB5416.apcprd03.prod.outlook.com (2603:1096:301:16::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.32; Fri, 10 Feb 2023 06:13:18 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4e0a:24eb:3ed8:b49c]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4e0a:24eb:3ed8:b49c%6]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 06:13:18 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        =?utf-8?B?TGlibyBLYW5nICjlurfliKnms6Ip?= <Libo.Kang@mediatek.com>,
        "kyrie.wu@mediatek.corp-partner.google.com" 
        <kyrie.wu@mediatek.corp-partner.google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>, "will@kernel.org" <will@kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v2 03/10] iommu/mediatek: Get regionid from larb/port id
Thread-Topic: [PATCH v2 03/10] iommu/mediatek: Get regionid from larb/port id
Thread-Index: AQHZO3+eXjV/2Jfp/EWeVjLQRwb17K7GoMmAgAEVvgA=
Date:   Fri, 10 Feb 2023 06:13:17 +0000
Message-ID: <538959e38bbb694d4e0bae7078fa34cd3d23c65b.camel@mediatek.com>
References: <20230208053643.28249-1-yong.wu@mediatek.com>
         <20230208053643.28249-4-yong.wu@mediatek.com>
         <cab40506-8b3a-0b53-b45d-a8000e953289@collabora.com>
In-Reply-To: <cab40506-8b3a-0b53-b45d-a8000e953289@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|PSAPR03MB5416:EE_
x-ms-office365-filtering-correlation-id: 99eff6f6-2302-4d19-07ad-08db0b2de702
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZE30u0Lh6anmyrGuTNGL4eNVt6dYVzfJuNQPnE1GO7EPnHMT1705F/jyRy0R02AaAn0oc+us3FM5EaRO/fJOJbpXH7gbhfQVg8woTSY5wCGIzuSvvzvLMZNqyRdcgv6GP1xHdOrQgdmFxt1hNQRDPVNZREhPtMUuYXNjHoVCp2EeK2iZVOFn7dcRyt7vT1N6aQVS5xXnZGzgJgi/86PtRqesJT5GImsTrJMTEuGq3T9UaIWqAMqSffy/tVKT7c3yC04ElGk095TPsrBACrrp/O+2B46TdXc9pT07DZCrHs8uiUrXH3cVKb8Qy299M2GOLt0YDYKC26td71uQ8ZPlTH7PA7konlG9gzZ9J0i8H12V9+wJKyUkyggzbTKoqhiquUsUQ4w+IbJaB0DWRt96EPegEZzsld8jiDopq9PvZCbPBinLo5LAplbSyLyHEOWXVhAMBZlM/JsOExFh7V4gto1Ma0Jm1IMlLuUjCrYWH+xbtfmuaGgxgboMgqpZFW3FZmJwRKT5BjigqdiPLMcHaKZ2dyLbMdXzSBdZ758+uqYYKFDfGeWA0OfwOu49UYaLGJq/x3j9xTC8H1hpTSw41Q2wuQClzBNnz2i+kiyArGsNV71Ycm2ezJrTocl6ux3pzgnFt6Fb6FN57tXDeuwmCO/RUCEPCB1/kBraw9EvwkydEQHdIruKL8ME7bGvc3VwHPPE7Ox/5Cb5olbN4zYIBj4lK7HYV1katx0bXgUAbqKVjEFirTbNSYuoVTdiaCNU4TynOxoCzIrwUYpivq3KSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199018)(85182001)(316002)(83380400001)(36756003)(54906003)(86362001)(41300700001)(2906002)(122000001)(110136005)(6506007)(71200400001)(38070700005)(26005)(6512007)(186003)(7416002)(5660300002)(8936002)(8676002)(478600001)(4326008)(91956017)(38100700002)(2616005)(66476007)(76116006)(66556008)(6486002)(66446008)(66946007)(64756008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWFxMnZoWHpobk9nN0h0SjNoUzQ2SG1XSldxRU5sSkNSMzhzY2VrOUVkSkk4?=
 =?utf-8?B?Q2E3RzJsVFNDckMwdis4YzVIc3d2WFFOY0FjK0pSQUw2LzZFMmkxZE40RUE1?=
 =?utf-8?B?dVNLSHNrNEJHZWd3b2NlamozNzl4SHF5dmNzZEJKeWs2eTNmTGl2Y08rQ21z?=
 =?utf-8?B?blM3d2h6ZS9RbEpuL2tOYkJPdXlOZVdxc29KdzJmZ3EzNkl1TzVZNW4zL0tu?=
 =?utf-8?B?ekE5MzUyZWZlMjVrUUZzV0Q3bXpIRGZ2TVFCSFdUdDN5SEk2b3VPNHhwUzJ4?=
 =?utf-8?B?UkNUaFltbDJ3TkU5ZGdtL09UZjFBTlQ0VDRxdXNITC9PQ1V5MURFV24wejJL?=
 =?utf-8?B?NjN0aUxEdUVmRXRVOWFrSmpPVDZ6MHJWM2hIUEhXM3FtTkJSQjNYOFRGaC80?=
 =?utf-8?B?UEM1UWIyZFl6NlU3eFp4TWdPN3lzaVJxSFBKeDIvMzk3MEUzalFhckNzdDRH?=
 =?utf-8?B?YzFCK1pTSWpXdUpENWtQT2FwYUtqUHdzaDczYVpmcG9uZzN6Y1ovRkxmYzZv?=
 =?utf-8?B?cnJneWYwSTNUY0hmZTZjM0EwTm95bWZ5TGFqMU5IR09vTnRNQkx2TnNERyt2?=
 =?utf-8?B?dW9qV2FqRDFhbkRJMXJ2Z2d6b3oraFNSdVJyZW8zQmtUL2dTcGViSXoxOVFa?=
 =?utf-8?B?cDNWa243eGV6ZnZaMzYzQWZHRnFyRE1oL2RzVitodk8wRVJvYkZPWjhEOWtk?=
 =?utf-8?B?elltdWlYeGtnemxnZ3ZKYnh3WWNreHZ4YWNjUUtEYkphbmZjcC9KWjB4SnBk?=
 =?utf-8?B?Ynd6Tjk0NlZ5ZkNhSkQyS0JtZk5rMk43NjVNMDdkYmgyZmRBUVR3MWNoK0pP?=
 =?utf-8?B?MlI5bWlFWkR4M3h1enNuSFQra3NTNjMxb1pWL1FCbExlaVRwYytoQ205SkJR?=
 =?utf-8?B?SDA0TWtCTHhUb0J0Vkt1Ync3R3pNUUxVNEFEK1V3UGdEcC84cFc0a2p1d1hw?=
 =?utf-8?B?Tmt5cmZRM2VHMnloaWtBckdXR05OeEFhUGcweXBONXVleVNueUM0dGR4OFcr?=
 =?utf-8?B?QVBTLytJZUZvZEJyZUtMd29CVHcvdTZsM0pLeExzRStGZFNRUjhqWFJlWFVG?=
 =?utf-8?B?aEN1UnhUY0VBR2syMFM3YVlVeHdhd1FSSU1tdDBkYlVwTnpVTVVYRXYrSEk5?=
 =?utf-8?B?WDg0dmZLVk9TOUJYSWxpb0w4OWdOT3VVTkhYUUlqeVQ0QXBxb2dtaG42S0lX?=
 =?utf-8?B?RWtBd0JTZmFNZ0FJSVBacjNaRXluckpZUkNaZDcrQ3FQdStaWEhoWFVicUZV?=
 =?utf-8?B?TkdaS1FlMVhtbVNEN01aenFOODRzTE1MT2I2WEo5Q0RSMnExMHVjUkN5bUpC?=
 =?utf-8?B?TmVWSXB1OC9MWmphSnZNY2lHR2lQSHJQVkxiU1dKa3F0VVFDYmVZTlExQit3?=
 =?utf-8?B?MitteWpsaTF1SE9WTXJNd0JoZ2lEZFpJOUFRVkpNTVpoR3pCeXJnTDhnRExQ?=
 =?utf-8?B?MzJSNUZrejJaemVzMTU0M1NuVVVGbTh6K0YyVXUraFRkSUlrY1ZSNlkzZjJa?=
 =?utf-8?B?dGlLNUJ5NjNGb0NkTkJ4UC9MTk1CQXYrTnBMVDNGTWRqUThRWllxa2VLcGw4?=
 =?utf-8?B?L2JHMzVKa2U5S0hhbXV2dUNoRGJtQWlYMGppQjJCSHZjZG1ZV3ZuMTExNTRR?=
 =?utf-8?B?ZXBJSWJKZ0FlNWVxdXBqSVdNNVFGRUc0bXc0bjBtbi9ab2dEOG5pTTZxb0Na?=
 =?utf-8?B?WDZmMDZ1NEtXSnlYL253RkJrTnZsRDJxbW5KYjZSNDVlOVVPSHVEOWt3UTN6?=
 =?utf-8?B?RjBBVC91N2REYkFqQW1UQjJ0bkR0RXNzSEFXa0lBYWFSb3lxTTk1cTlZMUtm?=
 =?utf-8?B?RVFLSDZmZWRWNHk4ek5KVHgzMklnMnFsNC9wNTc3SU5NSWNoMW9WaXVwM1FK?=
 =?utf-8?B?VjgvMWl5akxIMU1SampyWTlKU0VqQ3huRlVack5vakpjSkxhdjIybVhzL0Ez?=
 =?utf-8?B?MnltSkRwSndTUDVINVJiUWR2RWs4S01zRW9VeHJFeFhaTWVjY0NOV1B2ZTkv?=
 =?utf-8?B?c21aVWZ2VUd3bHhURVRNa29Ha3d5TVhDR2tQL2I1Ui9zNVEwbHBaMUc2aWJz?=
 =?utf-8?B?OEJBT0tTdm5OMXhpRjFGZHBpbUplbE1nL01JYWhQOUFXUS9PRzJNeVV2SExB?=
 =?utf-8?B?ZWg3UEV5aTRQSUFkWWh1TWNNTDVLQUxtdUJmdkJIN1dIRjhvTkVaSE1NUmVC?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2332F9BBF918BE4CAE50D891390CEF3D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99eff6f6-2302-4d19-07ad-08db0b2de702
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 06:13:18.0004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cx+HWsWxvHyMpb0jVWRkGXwtFJB72yXDMILWg/xl1gEuE/KTDsyintSXQXN4y3nX8S8xVrmgbypPA59zNm4PCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5416
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTA5IGF0IDE0OjM5ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDgvMDIvMjMgMDY6MzYsIFlvbmcgV3UgaGEgc2NyaXR0bzoNCj4g
PiBBZnRlciBjb21taXQgZjFhZDUzMzhhNGQ1ICgib2Y6IEZpeCAiZG1hLXJhbmdlcyIgaGFuZGxp
bmcgZm9yIGJ1cw0KPiA+IGNvbnRyb2xsZXJzIiksIHRoZSBkbWEtcmFuZ2VzIGlzIG5vdCBhbGxv
d2VkIGZvciBkdHMgbGVhZiBub2RlLg0KPiA+IGJ1dCB3ZSBzdGlsbCB3b3VsZCBsaWtlIHRvIHNl
cGFyYXRlIHRvIGRpZmZlcmVudCBtYXN0ZXJzDQo+ID4gaW50byBkaWZmZXJlbnQgaW92YSByZWdp
b25zLg0KPiA+IA0KPiA+IFRodXMgd2UgaGF2ZSB0byBzZXBhcmF0ZSBpdCBieSB0aGUgSFcgbGFy
YmlkIGFuZCBwb3J0aWQuIEZvcg0KPiA+IGV4YW1wbGUsDQo+ID4gbGFyYjEvMiBhcmUgaW4gcmVn
aW9uMiBhbmQgbGFyYjMgaXMgaW4gcmVnaW9uMy4gVGhlIHByb2JsZW0gaXMgdGhhdA0KPiA+IHNv
bWUgcG9ydHMgaW5zaWRlIGEgbGFyYiBhcmUgaW4gcmVnaW9uNCB3aGlsZSBzb21lIHBvcnRzIGlu
c2lkZQ0KPiA+IHRoaXMNCj4gPiBsYXJiIGFyZSBpbiByZWdpb241LiBUaGVyZWZvcmUgSSBkZWZp
bmUgYSAibGFyYl9yZWdpb25fbXNrIiB0byBoZWxwDQo+ID4gcmVjb3JkIHRoZSBpbmZvcm1hdGlv
biBmb3IgZWFjaCBhIHBvcnQuIFRha2UgYSBleGFtcGxlIGZvciBhIGxhcmI6DQo+ID4gICBbMV0g
PSB+MDogbWVhbnMgYWxsIHBvcnRzIGluIHRoaXMgbGFyYiBhcmUgaW4gcmVnaW9uMTsNCj4gPiAg
IFsyXSA9IEJJVCgzKSB8IEJJVCg0KTogbWVhbnMgcG9ydDMvNCBpbiB0aGlzIGxhcmIgYXJlIHJl
Z2lvbjI7DQo+ID4gICBbM10gPSB+KEJJVCgzKSB8IEJJVCg0KSk6IG1lYW5zIGFsbCB0aGUgb3Ro
ZXIgcG9ydHMgZXhjZXB0DQo+ID4gcG9ydDMvNA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbiB0aGlzIGxhcmIgYXJlIHJlZ2lvbjMuDQo+ID4gDQo+ID4gVGhpcyBtZXRob2QgYWxz
byBhdm9pZHMgdGhlIHVzZXJzIGZvcmdldC9hYnVzZSB0aGUgaW92YSByZWdpb25zLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDQzICsrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0NCj4gPiAtLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIzIGlu
c2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IGlu
ZGV4IGQ1YTQ5NTU5MTBmZi4uZmMzZDliZTEyMGEwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+
ID4gQEAgLTgsNyArOCw2IEBADQo+ID4gICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ID4gICAj
aW5jbHVkZSA8bGludXgvY29tcG9uZW50Lmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvZGV2aWNl
Lmg+DQo+ID4gLSNpbmNsdWRlIDxsaW51eC9kbWEtZGlyZWN0Lmg+DQo+ID4gICAjaW5jbHVkZSA8
bGludXgvZXJyLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+ID4gICAj
aW5jbHVkZSA8bGludXgvaW8uaD4NCj4gPiBAQCAtMTk0LDYgKzE5Myw3IEBAIHN0cnVjdCBtdGtf
aW9tbXVfcGxhdF9kYXRhIHsNCj4gPiAgIAllbnVtIG10a19pb21tdV9wbGF0CW00dV9wbGF0Ow0K
PiA+ICAgCXUzMgkJCWZsYWdzOw0KPiA+ICAgCXUzMgkJCWludl9zZWxfcmVnOw0KPiA+ICsJY29u
c3QgdTMyCQkoKmxhcmJfcmVnaW9uX21zaylbMzJdOw0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgZG9j
dW1lbnQgdGhpcyBsYXJiIHJlZ2lvbiBtYXNrIGluIGNvZGUsIG90aGVyIHRoYW4gdGhlDQo+IGNv
bW1pdA0KPiBkZXNjcmlwdGlvbj8NCj4gDQo+IEkgY2FuIHNlZSB0aGlzIGJlaW5nIGVzc2VudGlh
bCBmb3IgdGhlIG5leHQgcGVyc29uIHJlYWRpbmcgdGhpcw0KPiBkcml2ZXIncyBjb2RlDQo+IHdp
dGhvdXQgZGlnZ2luZyB0aHJvdWdoIHRoZSBjb21taXQgaGlzdG9yeS4gQXQgbGVhc3Qgc29tZSBj
b21tZW50IG9uDQo+IHRvcCBvZg0KPiB0aGUgcG9pbnRlciwgb3Igb24gdG9wIG9mIHRoZSBzdHJ1
Y3QgZGVjbGFyYXRpb24uLi4gYW5kIHBlcmhhcHMgYWxzbw0KPiBkZXNjcmliZQ0KPiBicmllZmx5
IHRoYXQgdGhlIGFycmF5IGlzICJpbmRleGVkIGJ5IHJlZ2lvbiIgKHNvIDEgPSByZWdpb24gMTsg
MiA9DQo+IHJlZ2lvbiAyKQ0KPiBhbmQgdGhhdCB0aGUgcmVnaW9uIGluZGV4IGNvcnJlc3BvbmRz
IHRvIHRoZSBzYW1lIGluZGV4IGFzDQo+IGBtdGtfaW9tbXVfaW92YV9yZWdpb25gLg0KDQpUaGFu
a3MgZm9yIHRoaXMgc3VnZ2VzdGlvbi4gSSB3aWxsIGNvbW1lbnQgdGhlc2UgaW4gdGhlIGNvZGUg
aW4gbmV4dA0KdmVyc2lvbi4NCg0KPiANCj4gQmVmb3JlIGRvaW5nIHRoYXQsIEknZCBsaWtlIHRv
IGNoZWNrIGlmIGFueW9uZSBlbHNlIGhhcyBhIGJldHRlcg0KPiBzb2x1dGlvbiBmb3INCj4gdGhh
dC4uLiBiZWNhdXNlIHdoZW4gbG9va2luZyBhdCBkYXRhIGZvciBvbmUgb2YgdGhlIFNvQ3MgaW4g
aGVyZSwgaXQNCj4gbG9va3MgYSBiaXQgaW50aW1pZGF0aW5nIQ0KPiANCj4gQ29weS1wYXN0ZSBm
cm9tIHBhdGNoIFswNC8xMF0gb2YgdGhpcyBzZXJpZXMgZm9yIHRoZSByZWFkZXIncw0KPiBjb21t
b2RpdHk6DQo+IA0KPiBzdGF0aWMgY29uc3QgdW5zaWduZWQgaW50IG10ODE5NV9sYXJiX3JlZ2lv
bl9tc2tbXVszMl0gPSB7DQo+IAlbMF0gPSB7fjAsIH4wLCB+MCwgfjB9LCAgICAgICAgICAgICAg
IC8qIFJlZ2lvbjA6IGFsbCBwb3J0cyBmb3INCj4gbGFyYjAvMS8yLzMgKi8NCj4gCVsxXSA9IHsw
LCAwLCAwLCAwLCAwLCAwLCAwLCAwLA0KPiAJICAgICAgIDAsIDAsIDAsIDAsIDAsIDAsIDAsIDAs
DQo+IAkgICAgICAgMCwgMCwgMCwgfjAsIH4wLCB+MCwgfjAsIH4wLCAgIC8qIFJlZ2lvbjE6DQo+
IGxhcmIxOS8yMC8yMS8yMi8yMy8yNCAqLw0KPiAJICAgICAgIH4wfSwNCj4gCVsyXSA9IHswLCAw
LCAwLCAwLCB+MCwgfjAsIH4wLCB+MCwgICAgLyogUmVnaW9uMjogdGhlIG90aGVyDQo+IGxhcmJz
LiAqLw0KPiAJICAgICAgIH4wLCB+MCwgfjAsIH4wLCB+MCwgfjAsIH4wLCB+MCwNCj4gCSAgICAg
ICB+MCwgfjAsIDAsIDAsIDAsIDAsIDAsIDAsDQo+IAkgICAgICAgMCwgfjAsIH4wLCB+MCwgfjB9
LA0KPiAJWzNdID0gezB9LA0KPiAJWzRdID0ge1sxOF0gPSBCSVQoMCkgfCBCSVQoMSl9LCAgICAg
ICAvKiBPbmx5IGxhcmIxOCBwb3J0MC8xICovDQo+IAlbNV0gPSB7WzE4XSA9IEJJVCgyKSB8IEJJ
VCgzKX0sICAgICAgIC8qIE9ubHkgbGFyYjE4IHBvcnQyLzMgKi8NCj4gfTsNCj4gDQo+IF5eXl4g
VGhhdCdzIHdoYXQgSSBhY3R1YWxseSBtZWFuIGJ5ICJpbnRpbWlkYXRpbmciLi4uIDotUA0KPiAN
Cj4gSXQncyBqdXN0IGxvb2tzIHRob3VnaCwgdGhlcmUncyBub3RoaW5nIG11Y2ggY29tcGxpY2F0
ZWQgaGVyZS4NCg0KVGhhbmtzLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+IA0K
