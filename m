Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4980D7001EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbjELHzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbjELHzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:55:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0F611626;
        Fri, 12 May 2023 00:55:21 -0700 (PDT)
X-UUID: 49630bb4f09a11ed9cb5633481061a41-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+ynCyK96NhMnl5mDw4q45C3ls+eqVi/Z9dbp15Py6AU=;
        b=dLinx++25OQ393gE7Vtnya+euA25VpiWX+U89S7D8Bd8K0ZSWRq/r3oemJTrBG6o+tXbWu0SmAZB02v7Y5DDEkkc9WQ2trjKSgVCxYmLQZSO/grsji6qLDq5LQhUZcVbH4WprmRBT5HZNEQleMpz104wMmxTNA0x/97U8cYIWLs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:1eefe84b-0bbf-4204-9bbb-62007b32a12a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.24,REQID:1eefe84b-0bbf-4204-9bbb-62007b32a12a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:178d4d4,CLOUDID:72059a6b-2f20-4998-991c-3b78627e4938,B
        ulkID:230512155218VOIG682W,BulkQuantity:7,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 49630bb4f09a11ed9cb5633481061a41-20230512
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 297036117; Fri, 12 May 2023 15:54:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 15:54:55 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 15:54:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivhD6EOOiqPCg054FIYMTlua9aotgJfhBNQKLdqHePb1sEh0gCjvr20/3on5jmUzxcMeDXBgCHD0WSpSRJ5SnQd/yxgmYqOLlBRM2aHyp7t0aKEhvjbuLJqH/uXxje/SbjV8lPcm7OZTS4dpmEZpBpAgZY2pEbV3nEX80UzDwyZWCvh6Jf48d9pjmFeUZcFdzaN5XHS9UaQtxNcKIVY4wT7S+ZvXd94mFJDL3EpdyXcIojYo1nmylDK9NmkZQ8iaAWA0wfeDGp6mazP61qcaYSRhmJzNz2ozgE3CxhzfSybcJpWm68r9BndsosnONNfcg7FesebWLqVdK295tZBGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ynCyK96NhMnl5mDw4q45C3ls+eqVi/Z9dbp15Py6AU=;
 b=Xj7w2+/RXenoRQf0/ApCdpsNpq2NhTCgA8ox0sggc7Fn89mWBmSNVBQaVhBudoryBy0rodKvwjG7UgTOvIvVxNJjfkZdaKZ7//7bsb95+/lIl2ktWroA9t2m3WM3D/gB8/TWCE/ZS4IKy93kjCmnIxUxTc99rcaVMT98bSsoLk6hgo/NLPLG1fth5aPh7WMcZojysf9Pxij7FW6N50hzMV2Xg3TU9fztyt/a4jFiyeonxQ+uBUzzyevcegn4avKPgkNa7i3uL8g+rI+OgxFB7NR5uXKW8+8yR0yf1US7rf8q/lHhwVeQB9NLJ5zI9bkaQ0XSacDRrp8W+H+L5CAM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ynCyK96NhMnl5mDw4q45C3ls+eqVi/Z9dbp15Py6AU=;
 b=M9hc0ZuyqnHbDFWGGqvaDzZUysOp1H1U6VrL4/ru1Z0EUueyfFTgcBHll+hgOSHFztHq/O24cTYs1Xh6LDbc+Q6siURCrZaZmCi6dKVnoV3xaXT6AavpZoXx1KcMQX1tJrltpzUtw/r9eLoC+ZP2l51mHDLgry3j6+ZBIT84hUc=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 KL1PR03MB7765.apcprd03.prod.outlook.com (2603:1096:820:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.23; Fri, 12 May 2023 07:52:51 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 07:52:51 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        =?utf-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>
Subject: Re: [PATCH v1 2/6] dt-bindings: hypervisor: Add binding for MediaTek
 GenieZone hypervisor
Thread-Topic: [PATCH v1 2/6] dt-bindings: hypervisor: Add binding for MediaTek
 GenieZone hypervisor
Thread-Index: AQHZbeeIpBD7nBGd2ESOfkL+LicR1a8pNVKAgAFHHoCAAHOKgIArgbYA
Date:   Fri, 12 May 2023 07:52:51 +0000
Message-ID: <73c9eceaa13a18eb8ee9ce77a7210036c109a131.camel@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
         <20230413090735.4182-3-yi-de.wu@mediatek.com>
         <8ace9b0f-742a-7ebc-555f-1f8be04a5955@linaro.org>
         <7b4492efa4a1becbdfb79d23a0a0c0fe11dba5f4.camel@mediatek.com>
         <a2dcebee-7a2a-08b1-a35a-45a4a08c9d26@gmail.com>
In-Reply-To: <a2dcebee-7a2a-08b1-a35a-45a4a08c9d26@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|KL1PR03MB7765:EE_
x-ms-office365-filtering-correlation-id: 26f44e11-9dbe-4c90-67a7-08db52bde2fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t4g1x0Pc3sjKwEOm86PxL4DyEjG5WJGo/zbjTA4La1NsC7Ik/liv5C3uSl35bIikVystvbSb84ZzLmYnYBLgazThas+eK28ithouIRXxqyDClXvmXN59pfdAp+tx7VTkws4oFiAfVaDo+77CzJDz/WYF4NhK9FUCY1dpHhB5okrv188bmdRYvebOA9jj5k+E9vEtdi9VGJtp5XxnkNME/Ntk43z4VO708xdpkU2Bw80hDdCra4dINfIfjS9quu6XIMRHhR5pLpGuiWEgvsst7SW3lwXhnMxAORCFLPogkQ3f9UaOyzZ68ZZpAk7/44PovNxLTTF7VthbTGbyXA9VjHDrw64XCojE32b7YD3fTne5Oac02hTGH5SihT4WE8h3wJrAU1qRXmHWNbUWdKqY+yg921GCxZ07z/hn/DjIlGCgkxiFZOif8cvmkQEOi+88hqRNSg/st93hv1RP2D8EmRCPKd6cylXYT0+yEWh5RlmmBFG28DRQnmYuCTlmnc2QCdo1yr0nPolXnH95KCQChMcYlLFS7ylFDYtFWVlOCsCrQMVatQAK83NC8ZmETZq2NbZ44L6GigNi2diez73wnPAao6V07rxjiM7W+7KX+4la40Ta5VI5xOgGg7/NNPhcytzbaFABhtxvT78SykXD3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(7416002)(85182001)(36756003)(8676002)(8936002)(38070700005)(5660300002)(2906002)(91956017)(2616005)(64756008)(66476007)(66446008)(66556008)(76116006)(66946007)(41300700001)(83380400001)(86362001)(316002)(4326008)(26005)(107886003)(53546011)(6512007)(110136005)(6506007)(186003)(478600001)(54906003)(122000001)(71200400001)(38100700002)(966005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzNpTHlXanpvSCtTcXZuL1ZZem9jWHJpa1F5S2F2N1o4alFsS2kwUUNFamw0?=
 =?utf-8?B?OHZ1T1lFR0pCMDJPM2pSYzJoVEF4WXFJdkZmRjIvUHJYb21uVVBrbnNzUEJY?=
 =?utf-8?B?c2MyMEZjR0g3eFlNSXB6ajNacTlnNDJ6TGFTM01XYjlueVI2dTdIYjVTMVJQ?=
 =?utf-8?B?OHk4M0pJNXgyZ0NyeTZ1VTZyclNBenZSbjNRVlpmTTdvTHdnK0VvYmpOTUg1?=
 =?utf-8?B?bEs4MEVPN1NYaDVpcFJQbk9JSXZ2V2RGNC9KaWh4ZUREdkdCRTRoOXA0ODd6?=
 =?utf-8?B?ZmsyS2d5dU5nR05JZDkwTDNFU0pBQ2l5WVVyblNpT0xieThmZitrVmZkS0ZN?=
 =?utf-8?B?SzVXVXVSbkVmN25qWmYzVHR2azV4eTNaR0pMMjArWHFuQUtoa0tlMUZYRURu?=
 =?utf-8?B?bjFZTlhLb0V6aDNOOG9ReEJ0alhqQktzbmVDU0lkWmp3Q0RNQ1AyUEdwRktZ?=
 =?utf-8?B?T2pZcDl2eUtSQnFYeGM3NTRIdVFWYXlZSlMyU0ZNdld3c0dORjFRVmwzUi9Z?=
 =?utf-8?B?dmVNUFBFUG9XS2hsOUtCYVhBQzZrWlpBTkxnbDc4R2FZbko2eXRRV08yRDZz?=
 =?utf-8?B?cUwzT3JDSnI5aTNoUUVpeVFtTjdCOTJjYUZuOUR0c3lFdEFoNU9oNjVPeElW?=
 =?utf-8?B?WXVJNUVLMHBTeGxEYUNmMjM4Y2U4bzBaT1NiNTFXVFNkemE0U3Q5dHpraGZJ?=
 =?utf-8?B?eUczRVN3UStMR09mUzRaRTlQRjZ0U00rejhPSWVxZWdCVFBFeGFpMDVBaW5h?=
 =?utf-8?B?akJVaFY2Rk8yOEpSMzZSaEtZdHJKZDU4aFNMUkw1TUhaaEMrd2phRW9MYStD?=
 =?utf-8?B?NlQ3Sm51NmU2RHp3bTFteWNwTkdkMy9lL3RDVUt2VTJKcmtoZit5WTFwNFhq?=
 =?utf-8?B?VkFzaHMwQXlRUlovN1VWUEg1TEh0MGpGWC9pZFkvOVdYbU5NNnJGZjg3b2h4?=
 =?utf-8?B?SThrbzR4SFZJdDRtU2phZHd5MVZXQlBBVFd6TkkvOStXSGJvOWZkN1lBc0lM?=
 =?utf-8?B?S3F6NDNZVzRNTm9nOEJDYzRsY21YY1lVazVvYWoyc2F0SnR5RHhFVGROVWxi?=
 =?utf-8?B?T1VPSStvY01yRTArN1hSYTRUSmV1Mzh5VytUVHBXV1dnZ2NDaTVEbEFHTHNK?=
 =?utf-8?B?bHRMVE1JUmxBRjdWT1NDOFpxNjNUbTdnR09XZmtLbG5XV3M1b1F5cG5mMnFn?=
 =?utf-8?B?QUxCYVYzdlIyY1gxbGt3bDBDdktHUWpoZEJUVjVmNStmWU1UY2pIUkFrQ1J5?=
 =?utf-8?B?U0w1cnNxRkJ3bUlQR0wyTjFlWUR0Y21hN3lNK0gvZm5Dc2RyaUd1cVIzZjcx?=
 =?utf-8?B?TGsrQWdEOUJrb1dVTFFaQWhobzFCRXA5ZXZDWnI3MFlRR1A5VjFlNCs3Z1Zj?=
 =?utf-8?B?NGJDYmdnc1lzcGdRL21BMkhEcklxeWFTUFRXaUhlS1grTXg3c0JTUUJzcTZn?=
 =?utf-8?B?cHNDT3JlU0pEUDZjdmFud0F2eUFLYnNvY3lLbnFYTlpHVzhXcEYybmkvRy9L?=
 =?utf-8?B?QnV5dGJvZVhOalNYT0tpc21CWXVVeVVrTUx1RkNvQytxK1pUa0QvcmRtL1NJ?=
 =?utf-8?B?dkw4YnBsTzNOQ0ZUVFIycWhyNXlaZUlvM1Jhc0JXdzhabEVWMmwwaTE0NDEr?=
 =?utf-8?B?ZUtNMnZuTjNyKzJzclp6dk82cGtScDVUeS9tY2M5a2VLdFMrQmo5Q0RUSGtB?=
 =?utf-8?B?SkR3YUE5RXJsZU9saytTUm1LWHlhT2ZUZERlL1A1MVRLdG5KRWJHbjVCNEhO?=
 =?utf-8?B?WFZzK3VPV0VCd290RG8vdU1rTTFYb2xucWFsbDZCdXN4c290MlhLOUVscC8z?=
 =?utf-8?B?bEgrb2pMVitZQmFyL0g1VEFXRDNLeUg5UGxKUlNqREhEQnorTGtYVHVUWFNr?=
 =?utf-8?B?ODhjQVdUajdXdUsxY3VUZk9XK0kxN2tudGtXaFdGVFVIT1hwUXd5TnNCdU1n?=
 =?utf-8?B?UkFFcGNobUVSeE9UeFJoNHIyWEIxQXQzWUlIMHV2c0VEeXdUd3BncjdQcGxH?=
 =?utf-8?B?UGpidXpjZGJnY053OVdnSVh6Q1V5Rnp5azVIVkRqRGY1VFNIb0lUbERrQXIr?=
 =?utf-8?B?Mm5Xc3pYc2xXc1FwL0RlZGNHQnRodTRpNENOaWFuS1hzT0RhVS9nb01oeERa?=
 =?utf-8?B?RXdER1BGdzlPYVhiYzJ5N0Q4U0NYbm1VWmp6dWx0SFVvTS9XdDR1dlFpV1J6?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEA001E7CD977D4E8BDD3525C3CF1AC8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f44e11-9dbe-4c90-67a7-08db52bde2fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 07:52:51.2795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdNddgh010BVr51O/U0G9221VGbsflbfRTAy9xpM1vXXJHQ/SS0ncJh0VDrJEmdZvC8n3vdjWzZokgAaBGk7KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7765
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDE3OjI5ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IE9uIDE0LzA0LzIwMjMgMTA6MzUsIFlpLURlIFd1ICjlkLPkuIDl
vrcpIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMy0wNC0xMyBhdCAxNTowNSArMDIwMCwgS3J6eXN6
dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4geW91
IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBPbiAxMy8wNC8yMDIzIDExOjA3LCBZaS1EZSBXdSB3cm90ZToNCj4gPiA+ID4gRnJv
bTogIllpbmdzaGl1YW4gUGFuIiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4g
PiANCj4gPiA+ID4gQWRkIGRvY3VtZW50YXRpb24gZm9yIEdlbmllWm9uZShnenZtKSBub2RlLiBU
aGlzIG5vZGUgaW5mb3Jtcw0KPiA+ID4gPiBnenZtDQo+ID4gPiA+IGRyaXZlciB0byBzdGFydCBw
cm9iaW5nIGlmIGdlbmllem9uZSBoeXBlcnZpc29yIGlzIGF2YWlsYWJsZQ0KPiA+ID4gPiBhbmQN
Cj4gPiA+IA0KPiA+ID4gU3ViamVjdDogZHJvcCBzZWNvbmQvbGFzdCwgcmVkdW5kYW50ICJiaW5k
aW5nIGZvciIuIFRoZSAiZHQtDQo+ID4gPiBiaW5kaW5ncyINCj4gPiA+IHByZWZpeCBpcyBhbHJl
YWR5IHN0YXRpbmcgdGhhdCB0aGVzZSBhcmUgYmluZGluZ3MuDQo+ID4gPiANCj4gPiANCj4gPiBU
aGFuayB5b3UgZm9yIHRoZSByZXZpZXcgY29tbWVudHMuIFdlIHdvdWxkIHJlbW92ZSB0aGUgImJp
bmRpbmcNCj4gPiBmb3IiDQo+ID4gd29yZGluZyBpbiB0aGUgc3ViamVjdCBvbiB0aGUgbmV4dCB2
ZXJzaW9uLg0KPiA+IA0KPiA+ID4gPiBhYmxlIHRvIGRvIHZpcnR1YWwgbWFjaGluZSBvcGVyYXRp
b25zLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWWluZ3NoaXVhbiBQYW4gPHlp
bmdzaGl1YW4ucGFuQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWWktRGUg
V3UgPHlpLWRlLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAgLi4uL2Jp
bmRpbmdzL2h5cGVydmlzb3IvbWVkaWF0ZWssZ3p2bS55YW1sICAgIHwgMzANCj4gPiA+ID4gKysr
KysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25z
KCspDQo+ID4gPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9oeXBlcnZpc29yL21lZGlhdGVrLGd6dm0ueWFtbA0KPiA+ID4g
PiANCj4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9oeXBlcnZpc29yL21lZGlhdGVrLGd6dm0ueWENCj4gPiA+ID4gbWwNCj4gPiA+
ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHlwZXJ2aXNvci9tZWRpYXRl
ayxnenZtLnlhDQo+ID4gPiA+IG1sDQo+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4g
PiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMzVlMWU1YjE4ZTQ3DQo+ID4gPiA+IC0tLSAvZGV2L251
bGwNCj4gPiA+ID4gKysrDQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2h5cGVydmlzb3IvbWVkaWF0ZWssZ3p2bS55YQ0KPiA+ID4gPiBtbA0KPiA+ID4gPiBAQCAt
MCwwICsxLDMwIEBADQo+ID4gPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIu
MC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiA+ID4gKyVZQU1MIDEuMg0KPiA+ID4gPiArLS0t
DQo+ID4gPiA+ICskaWQ6DQo+ID4gPiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2h5cGVydmlzb3IvbWVkaWF0ZWssZ3p2bS55YW1s
Kl9fO0l3ISFDVFJOS0E5d01nMEFSYnchbHA0ZDRXQnAyNmNwT2VFR2NLbl9hSGNOR2Z5bDFZLS1C
WXpmUjhvUl8wWHpyOVRMdlVFTGZPUUFBZHFIbExJT3JhMVdfUWRqVlNKdjAtSE1wTGVzSm1BM1RQ
SlNhZyQNCj4gPiA+ID4gKyRzY2hlbWE6DQo+ID4gPiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3
ISFDVFJOS0E5d01nMEFSYnchbHA0ZDRXQnAyNmNwT2VFR2NLbl9hSGNOR2Z5bDFZLS1CWXpmUjhv
Ul8wWHpyOVRMdlVFTGZPUUFBZHFIbExJT3JhMVdfUWRqVlNKdjAtSE1wTGVzSm1EU1hpbF9RdyQN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArdGl0bGU6IE1lZGlhVGVrIEdlbmllWm9uZSBoeXBlcnZpc29y
DQo+ID4gPiA+ICsNCj4gPiA+ID4gK21haW50YWluZXJzOg0KPiA+ID4gPiArICAtIFlpbmdzaGl1
YW4gUGFuIDx5aW5nc2hpdWFuLnBhbkBtZWRpYXRlay5jb20+DQo+ID4gPiA+ICsNCj4gPiA+ID4g
K2Rlc2NyaXB0aW9uOg0KPiA+ID4gPiArICBHZW5pZVpvbmUgaXMgTWVkaWFUZWsgcHJvcHJpZXRh
cnkgaHlwZXJ2aXNvci4gVGhpcyBkZXZpY2UNCj4gPiA+ID4gbm9kZQ0KPiA+ID4gPiBpbmZvcm1z
IGl0cw0KPiA+ID4gPiArICBkcml2ZXIsIGd6dm0sIHRvIHByb2JlIGlmIHBsYXRmb3JtIHN1cHBv
cnRzIHJ1bm5pbmcgdmlydHVhbA0KPiA+ID4gPiBtYWNoaW5lcy4NCj4gPiA+IA0KPiA+ID4gRG8g
bm90IGRlc2NyaWJlIExpbnV4LCB3ZSBhbGwga25vdyBob3cgZHJpdmVyIGJpbmRpbmcgd29ya3Ms
IGJ1dA0KPiA+ID4gaGFyZHdhcmUvZmlybXdhcmUvaHlwZXJ2aXNvci4NCj4gPiA+IA0KPiA+IA0K
PiA+IE5vdGVkLiBXZSB3b3VsZCBlbmhhbmNlIHRoZSBkZXNjcmlwdGlvbiBvbiBuZXh0IHZlcnNp
b24uDQo+ID4gDQo+ID4gPiBJIGRvbid0IGtub3cgaWYgd2UgYWN0dWFsbHkgd2FudCB0byBzdXBw
b3J0IHByb3ByaWV0YXJ5DQo+ID4gPiBoeXBlcnZpc29ycy4NCj4gPiA+IFRoZXJlIGNhbiBiZSBo
dW5kcmVkcyBvZiB0aGVtLCBvbmUgcGVyIGVhY2ggU29DIG1hbnVmYWN0dXJlciwgYW5kDQo+ID4g
PiB0aGV5DQo+ID4gPiBjYW4gY29tZSB3aXRoIG1hbnkgcmlkaWN1bG91cyBpZGVhcy4NCj4gPiA+
IA0KPiA+IA0KPiA+IE1lZGlhVGVrLCBhcyBhIHBhcnRuZXIgb2YgQW5kcm9pZCwgb3VyIEdlbmll
Wm9uZSBoeXBlcnZpc29yIGhhcw0KPiA+IGJlZW4NCj4gPiBvbmUgb2YgdGhlIGJhY2tlbmQgb3B0
aW9ucyB1bmRlciBBbmRyb2lkIFZpcnR1YWxpemF0aW9uDQo+ID4gRnJhbWV3b3JrKEFWRikNCj4g
PiBub3cuDQo+ID4gVGh1cywgd2UnZCBsaWtlIHRvIGRvbmF0ZSB0aGVzZSBwYXRjaGVzIGZvciBi
ZXR0ZXIgc3VwcG9ydGluZyB0aGUNCj4gPiBMaW51eC9BbmRyb2lkIGVjb3N5c3RlbS4NCj4gPiAN
Cj4gPiBSZWZlcmVuY2UgbGluazogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vY3Jvc3ZtLmRldi9ib29rL2h5cGVydmlzb3JzLmh0bWwqZ2VuaWV6b25lX187SXchIUNU
Uk5LQTl3TWcwQVJidyFuMXNOMTVlS25HMU02bWxjQWI3VUJpNGhvSVltS3N3MnpsZmR3TzIxdGh1
SFp1SFlISGtIblpGOVdXZnAzeFNjWFZoYTNtbGJMVkNVTUdJbzNPTTZEOGVJJA0KPiA+IA0KPiAN
Cj4gV2hhdCBpcyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIGdlbmllem9uZSBhbmQgZ3VueWFoPyBX
aHkgd2lsbCB3ZSBuZWVkDQo+IGJvdGggb2YNCj4gdGhlbT8gQ291bGRuJ3Qgd2UganVzdCBnZXQg
b25lIGh5cGVydmlzb3IgaW1wbGVtZW50YXRpb24gbWVyZ2VkIHRoYXQNCj4gaW5jbHVkZXMNCj4g
YWxsIHRoZSBuZWVkZWQgZmVhdHVyZXMuIEluIHRoZSBlbmQgaXQgd2lsbCBiZSB1c2VkIHdpdGgg
dGhlIHNhbWUNCj4gVk1NLg0KPiANCj4gUmVnYXJkcywNCj4gTWF0dGhpYXMNCj4gDQoNCldlIG1p
Z2h0IG5vdCBiZSBhYmxlIHRvIHNwZWFrIGZvciBHdW55YWgsIGJ1dCBHdW55YWggYW5kIEdlbmll
Wm9uZSBhcmUNCnF1aXRlIGRpZmZlcmVudCBoeXBlcnZpc29yIGltcGxlbWVudGF0aW9ucyBpbiB2
YXJpb3VzIGFzcGVjdHMgc3VjaCBsaWtlDQpWTSBleGVjdXRpb24gZmxvdywgc2VtYW50aWNzLCBV
QVBJLi4uZXRjLg0KDQpTdGlsbCwgd2UncmUgb3BlbiB0byBkaWN1c3Npb24gaWYgdGhlcmUncyBh
bnkgcHJvcG9zYWwgdGhhdCBwcm92aWRlIGENCnVuaWZpZWQgaW50ZXJmYWNlIGFtb25nIGFsbCB0
aGUgaHlwZXJ2aXNvcnMuDQoNCj4gPiA+ID4gKw0KPiA+ID4gPiArcHJvcGVydGllczoNCj4gPiA+
ID4gKyAgY29tcGF0aWJsZToNCj4gPiA+ID4gKyAgICBjb25zdDogbWVkaWF0ZWssZ3p2bQ0KPiA+
ID4gPiArDQo+ID4gPiA+ICtyZXF1aXJlZDoNCj4gPiA+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4g
PiA+ICsNCj4gPiA+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ID4gPiArDQo+
ID4gPiA+ICtleGFtcGxlczoNCj4gPiA+ID4gKyAgLSB8DQo+ID4gPiA+ICsgICAgaHlwZXJ2aXNv
ciB7DQo+ID4gPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssZ3p2bSI7DQo+ID4g
PiA+ICsgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiA+IA0KPiA+ID4gRHJvcCBzdGF0dXMu
DQo+ID4gPiANCj4gPiA+IEJlc3QgcmVnYXJkcywNCj4gPiA+IEtyenlzenRvZg0KPiA+ID4gDQo=
