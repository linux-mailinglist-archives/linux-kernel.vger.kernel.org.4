Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D76E1EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDNIoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjDNIoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:44:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6805293D1;
        Fri, 14 Apr 2023 01:44:06 -0700 (PDT)
X-UUID: 7395d066daa011eda9a90f0bb45854f4-20230414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RY/YziVKOrW364M200jK4FHwB6TcRDDpWCMRXEQDir8=;
        b=lg7+dfGpAS1WMS1+dDTbK6FRR4dVHcclo8QwBWPI/saptUyur8RkOCZByuVoUVEFaw0FZncprjA5WCWpsEF4mb6z4BFVSEcLoVmdPclXSWEfSBPf+0+NfDpIfTzHlxxNZJkhIqO1o5bfspX8H0vCX1LE82ErO8OYk7CrXijsrhY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:993cba5a-911e-469c-990d-ae577b0c0e86,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:049af5ea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 7395d066daa011eda9a90f0bb45854f4-20230414
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 229041311; Fri, 14 Apr 2023 16:43:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 14 Apr 2023 16:43:37 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 14 Apr 2023 16:43:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrQ/cHHb67sPqPCa2v7sueFira1XgbLYO5jPMpHIbB8pcmH57ddbdC3d2BNVCUt45eciymNTEyXkBGJWlEAddcRfeRFuinUQG95vqzUSOohdi3fkE7KMu4z1YGBB2WayL5RmBLTPp72MpARVjDOF9DqQtZCDAmfMmWrc01v1f5EUMNSLyJRfblzqlpek3qjzFtxFQ51lNJTFeONY84M2gspBpxl7vxnkGs9+6Rb2Lqz+zTjliAo+93NMOeBH6tGRmGB3uqoC/TyY+SmXf9nRrVqtoGfuEPllbPw8mDRf0mFANm6OqAUi6UWEnJV42vto7sZ6CFT8cLE1FeFihlckHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RY/YziVKOrW364M200jK4FHwB6TcRDDpWCMRXEQDir8=;
 b=mocSn4srDzBe3x8vlvqerY2DTUrfY3SYrvLU2LiNkFj6UlYCLojSykueGlq1N8ThPKrDAXzEHuDbKUEKJSwGOiq9T6uu4wzg9MfcsswGLuWn1utM7agAIYzExl2WpW1exV4gSKbJZleoWo1VQEi9xrwZCtd907oeK7qWSBfLxrgxOdX/68uBCmoID2uZtuRlSk4QmF+rTjvmC0mcMzwIp0JTmdwaGictX0q+cI6XUrXRjdVTL9A7dPodZDW6+xbasC9NQqXaIwDQDFlaqNFC6QE2YUdyf1hlGUJ/yBmBqXZct2ACAjg4Q8pvEdGuKFU5+54rkUgpcZbYK3De8Ox7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY/YziVKOrW364M200jK4FHwB6TcRDDpWCMRXEQDir8=;
 b=aEwlNpB5LTknfJERt9mCwHS5LskGjxuUDV3Z1KvdZYADDS3Ln1W5g3/U8PQAddbbIgJ19m8CRfkb2+cBeZeVgr8CFEsd5UIptRKVA0BBJluIi8fPzh4YnL7pIkzudZhoZjEvkF6IbceZ0hwgdP8WAwjbjRqWHqas/ENN9cJEzys=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 TYZPR03MB7004.apcprd03.prod.outlook.com (2603:1096:400:268::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 08:43:35 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::47e2:93ab:c1d3:670b%9]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 08:43:33 +0000
From:   =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
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
Subject: Re: [PATCH v1 3/6] soc: mediatek: virt: geniezone: Introduce
 GenieZone hypervisor support
Thread-Topic: [PATCH v1 3/6] soc: mediatek: virt: geniezone: Introduce
 GenieZone hypervisor support
Thread-Index: AQHZbeeL18MyQqxT3UGeJoMyfQvhiK8pMrMAgABGroCAAQUyAA==
Date:   Fri, 14 Apr 2023 08:43:33 +0000
Message-ID: <533a1a9b653cf63f1e5df7f95d1b23902809561d.camel@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
         <20230413090735.4182-4-yi-de.wu@mediatek.com>
         <1aa701cc-92ca-71be-0663-df4bfae66c2f@linaro.org>
         <5c1d69c8-d973-fa7b-1f14-c72729ff5594@gmail.com>
In-Reply-To: <5c1d69c8-d973-fa7b-1f14-c72729ff5594@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|TYZPR03MB7004:EE_
x-ms-office365-filtering-correlation-id: 96af51f8-f967-490d-8caa-08db3cc454ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LZFoFfjWNWTDyJBGRJOgJNF7EceJg+6GUuuOF9BO4Y7URIvkKA6AK+ipoP8n9eDbLDhDiC4gbCEDDnswyCV+X6hB1NeQDPXMPFx30vZv6CBkMEQJBcWWqf95ojTkw2vMjaNCd9aNtnSwrCRc6efMhL6HICaHdY7CN+4ew6JdvnKb9PxbnLpMECbyg83Rq4h8w5qawZqzxLl8hGMbyMRXCkNTR9LzD1/NuHEgfDXYq8qChc2hlJsJP1PRU7JJStS+gaP0Cd18bxzwD6Zh8T2+JPMNY2XZXuzi/9NK2AHx5YcmkcfnGT6D2vqTCMHEYKjlZCrUIkeDS0Z6vKLnE7a34VeDH9kA55h2cIM9HdmD1ck5HDtGgWNjHHknWTGjLi+2tYUEjM1il/jUiuhG7twb6rIHHbhWOidjGyLrEqgEIu7TH11cWj5w6s4YBoYK1iN5BvY+tBSPWVCnoLSWYu3XY5oaHk7+hebleJlP41k6qR43TQknE9OovVUD9z611Wd+VlinFFZ/uttG0ANpGXDFw90e+xJMNkg9SD2gbtQk6xRlneNBTvLvPqfxpBFb84i8fkcVuST79ToUd6U02M/4CVew8HX2M+XGF9U0RrA9Jleg7nTkg/S11EOZ2soWydTEFW9Qq2vpq3dMsTb5Neq13A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(4326008)(64756008)(478600001)(110136005)(76116006)(66946007)(66446008)(66556008)(66476007)(91956017)(54906003)(38070700005)(316002)(2616005)(83380400001)(122000001)(85182001)(38100700002)(53546011)(107886003)(26005)(186003)(6512007)(6506007)(7416002)(8676002)(8936002)(6486002)(966005)(5660300002)(36756003)(71200400001)(86362001)(2906002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnVSckh0SUdLNFhudDlmd0ErYXQ1RHdCVTV6bnV4WUdKN3pobzlqNHd5WHNu?=
 =?utf-8?B?c0p3QWVSUlR3K25NT09jbWg2SXZhUXlScFpDbmcwZzZpdCtva1Q0bjdjUEtZ?=
 =?utf-8?B?Ym5nZXNJTGd1b1A3ODRhYWgycFY1ajhVd0o3MnNaS0xXa1l3Qzc1ZXZDWHFC?=
 =?utf-8?B?ZDc1TVFKbGxacHVlNVpTNlA0R2dHTEl6RHdYeSsyTUxpMEdVSSsvSktlcmNS?=
 =?utf-8?B?U3lsVlBiWEVFWFEwcDFTR0R3bVd2Z2FrWmdUbE90MHk3RWtmN0VwMU0zcytE?=
 =?utf-8?B?dFhEYXpGUytoWmN1a0ErblY5cGkyc1BVVkhHOWlTTnVTLy85SENkbnIzNUc3?=
 =?utf-8?B?UmJBOElkSEFQbVMvU1pkNDNlUnp1LzZaNVJFV01sbU5hRWZoRGFwZ1JWdkEx?=
 =?utf-8?B?M0JRc0hBVVJ0cDUxTU9XZFV5MFEvbitjbWRvTlE2ZHJta0FpUW9VWjQ5MC95?=
 =?utf-8?B?bk45UGhYUndOUUZHcUcrU1RoUUVidGNzZ2ltQXNHaDNRenFubUVvZVJGOHhk?=
 =?utf-8?B?aXFvUFpNcVRSRVl6RzdVbTJoTk1jcEl0aGE4VHY3TUErQnVZNGlpZ3pLTE8r?=
 =?utf-8?B?OUM1akVxNXlkRDhXYTBlOTR2T0NSd3VIdThxdmFIcFNiVWlDQlVZSlV1Rzlo?=
 =?utf-8?B?UEprTHdSUTdoM2JzNDVUSXZnN215MkJwRVY5UGFkS2dvVDROTEF3RUE4TjFD?=
 =?utf-8?B?MWNYeWowTC9lQURwckN2TSs3SkZXMGwxTUp2bzVOTFcxdERBaTVXY0hsTytU?=
 =?utf-8?B?M0pxMmVpelA2SS84VFMxWnJpR0V0WHJ2Tk44d1FBT3JaU1lYUEVkd2dGMnZD?=
 =?utf-8?B?aVNWU0J2NXdCMEUrODlwOExzYWp2TW9xUmZhZkhyN3QwUW94bHVNenU0NWk0?=
 =?utf-8?B?MldCUUhLKzV6NEowSW1ORk85N0VWdTZaa2pTS3A1SFBvRC8wNXZKVnhNMEk3?=
 =?utf-8?B?KzdMVHJ1MkdLQ2o1TmZ3SWRHdG15TmlHQ2R0UXlKZC84Q1VKRkZaa1BHYWk0?=
 =?utf-8?B?ekFUc0FCOVV5d09ObUUyZlkzYnd2dDhGc2VjdWlVM1JSYlMxb1gvU1dsdnJh?=
 =?utf-8?B?amJCSE9nNURlQS9XamQ0bzFmNVNNQUo1RTNWcjlhR044OFc3NEc4REpWQWpD?=
 =?utf-8?B?SlFzeHFlWnVnaTdSODQ2T3FNRDVObW8vaGxWa3pzZWxPV0MxZ0xtVGhNeWVZ?=
 =?utf-8?B?WXU1a2hvZTdWWDJHU2Y4YTFLZ2FhMnJESmV1WlVIVjVjSzU3RUZPd09rSm5m?=
 =?utf-8?B?d0pzSGtoaW1IOWRnTG05eWxTaVQyT1hkaVZBK1lCNlhTRmx3MVVJY2t6cVlh?=
 =?utf-8?B?dnRaS2N4K0M0TkhxQVIwRXR4R21yOWxOeFpWYjkxWWdZL3NQd1ZjZk9zNFYw?=
 =?utf-8?B?Z3lSSUNJb0g3STVqa2ZWV3pQUWNJUHpySEdQWXc5bm9pcFZLeVJQa3dFdEpJ?=
 =?utf-8?B?aXBlckNzbWwvbnF3UWUvV1V2VXhsZ3M4Mk9hemM4Mno1NHNTcWIxZjhYSEMr?=
 =?utf-8?B?TWYwOTZFUWZrTWJpbVlxdW1tZzRVSE16OEdnNmNTOXhaNjVTSDJhdmY2cDlU?=
 =?utf-8?B?akhuaGpxNVBpL1hjcE5iZGNrdlBoK1Q1SXo2NGMvazBvaUQ2dXVadzhTTXUy?=
 =?utf-8?B?VVZSenM5RFhzSmhYZkVTcTRsK0VjMlpkTDZzMmxuNVdrbk5LUmdyRHlGYUNT?=
 =?utf-8?B?L0pWYmRQeEZQSjVJMmltNmY4TjNDOC9GZTBmSkFlK2MwRklYb2hHTlNvbWIx?=
 =?utf-8?B?dXduNmY2eEMrUjF5RUkzUXA0L1lnUEhES3lVcFhndmxMdWIwZkwyUGx4eWxq?=
 =?utf-8?B?bDRWV1NCVXlPVEJIUFZxNnJIcm51VFo3RFNjK3dpSGlnUVhpQlBPVm15Zm5Z?=
 =?utf-8?B?Sm80V2xnaVd3bFp1bTlNS2FNaDlpeVovSGxGbmk5VU8zM0FQZ3VZR2hmejR3?=
 =?utf-8?B?Ujg0YUt5SVIwc25nN2RSNVlQM1prT01wQXIvZjdNc1VUU1hhSzRzNWxIRzdT?=
 =?utf-8?B?T0NrQ1ZkZUtjOVQxWmU5R1Qrb2d0dnJsV3lMK1BIK0MvSUhZS0YzYnB5QW8v?=
 =?utf-8?B?MTJBY2YzUWpFb0xNaEJYdEN1UWp5SlR0dW5LTDNaOGphY3NqT01nMFFPS0pu?=
 =?utf-8?B?Z1RJc3lyNXV4MmgvdUl1ZXplTWhJU2VzbnV4alRaQmVqMGpNdW83dlhsZjNK?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39FA565B7A227C46B4D8E192EE021EF6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96af51f8-f967-490d-8caa-08db3cc454ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 08:43:33.5230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HkAsUHiUapioQNo1DuG0QC5aHE/SeKrbIfuDO+x2vpQ/vDm6jtvW1Dvs0tQsreIj46ZeIuh3lU8tTNo2B91q4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA0LTEzIGF0IDE5OjA4ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IE9uIDEzLzA0LzIwMjMgMTQ6NTUsIEtyenlzenRvZiBLb3psb3dz
a2kgd3JvdGU6DQo+ID4gT24gMTMvMDQvMjAyMyAxMTowNywgWWktRGUgV3Ugd3JvdGU6DQo+ID4g
PiBGcm9tOiAiWWluZ3NoaXVhbiBQYW4iIDx5aW5nc2hpdWFuLnBhbkBtZWRpYXRlay5jb20+DQo+
ID4gPiANCj4gPiA+IEdlbmllWm9uZSBpcyBNZWRpYVRlayBwcm9wcmlldGFyeSBoeXBlcnZpc29y
IHNvbHV0aW9uLCBhbmQgaXQgaXMNCj4gPiA+IHJ1bm5pbmcNCj4gPiA+IGluIEVMMiBzdGFuZCBh
bG9uZSBhcyBhIHR5cGUtSSBoeXBlcnZpc29yLiBUaGlzIHBhdGNoIGV4cG9ydHMgYQ0KPiA+ID4g
c2V0IG9mDQo+ID4gPiBpb2N0bCBpbnRlcmZhY2VzIGZvciB1c2Vyc3BhY2UgVk1NIChlLmcuLCBj
cm9zdm0pIHRvIG9wZXJhdGUNCj4gPiA+IGd1ZXN0IFZNcw0KPiA+ID4gbGlmZWN5Y2xlIChjcmVh
dGlvbiwgcnVubmluZywgYW5kIGRlc3Ryb3kpIG9uIEdlbmllWm9uZS4NCj4gPiA+IA0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogWWluZ3NoaXVhbiBQYW4gPHlpbmdzaGl1YW4ucGFuQG1lZGlhdGVrLmNv
bT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFlpLURlIFd1IDx5aS1kZS53dUBtZWRpYXRlay5jb20+
DQo+ID4gPiAtLS0NCj4gPiA+ICAgYXJjaC9hcm02NC9pbmNsdWRlL3VhcGkvYXNtL2d6dm1fYXJj
aC5oICAgICAgIHwgIDc5ICsrKysNCj4gPiA+ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZp
ZyAgICAgICAgICAgICAgICAgIHwgICAyICsNCj4gPiA+ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsv
TWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiA+ICAgZHJpdmVycy9zb2MvbWVk
aWF0ZWsvdmlydC9nZW5pZXpvbmUvS2NvbmZpZyAgIHwgIDE3ICsNCj4gPiANCj4gPiBIeXBlcnZp
c29yIGRyaXZlcnMgZG8gbm90IGdvIHRvIHNvYy4gU3RvcCBzaG92aW5nIHRoZXJlIGV2ZXJ5dGhp
bmcNCj4gPiBmcm9tDQo+ID4geW91ciBkb3duc3RyZWFtLiBGaW5kIGFwcHJvcHJpYXRlIGRpcmVj
dG9yeSwgZS5nLiBtYXliZQ0KPiA+IGRyaXZlcnMvdmlydC4NCj4gDQo+IEFja2VkLCB3aGF0IGlz
IHRoZSByZWFzb24geW91IHdhbnQgdG8gYWRkIHRoaXMgdG8gZHJpdmVycy9zb2MgaW5zdGVhZA0K
PiBvZg0KPiBkcml2ZXJzL3ZpcnQ/DQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiANCk5v
dGVkLiBXZSB3b3VsZCB0YWtlIHlvdXIgYWR2aWNlIGFuZCBtb3ZlIGl0IGZyb20NCmRyaXZlcnMv
c29jL21lZGlhdGVrL3ZpcnQgdG8gL2RyaXZlcnMvdmlydCBvbiBuZXh0IHZlcnNpb24uDQoNClRo
ZSByZWFzb24gd2UgcHV0IGl0IHVuZGVyIG91ciBzb2MvIGlzIHRoYXQgdGhlIGRydmVyIGlzIGhp
Z2hseQ0KcHJvcGlldGFyeSBmb3IgbWVkaWF0ZWsncyBwcm9kdWN0IGFuZCBmb3IgYWFyY2g2NCBv
bmx5LiBNYXliZSBpdCdzIG5vdA0KZ2VuZXJhbCBlbm91Z2ggdG8gcHV0IGluIHVuZGVyIC9kcml2
ZXJzL3ZpcnQuDQoNClJlbGF0ZWQgZGlzY3Vzc2lvbnMgaGFwcGVuZWQgaGVyZSBmb3IgeW91ciBp
bmZvcm1hdGlvbi4gDQoNCmh0dHBzOi8vYW5kcm9pZC1yZXZpZXcuZ29vZ2xlc291cmNlLmNvbS9j
L2tlcm5lbC9jb21tb24vKy8yNDQ3NTQ3LzEuLjIvZHJpdmVycy92aXJ0L2dlbmllem9uZS9nenZt
LmgjYjkxDQoNCj4gPiBTZWU6DQo+ID4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MzAzMDQwMTA2MzIuMjEyNzQ3MC0xLXF1aWNfZWJlcm1hbkBxdWljaW5jLmNvbS8NCj4gPiANCj4g
PiBZb3Ugc2hvdWxkIGZvbGxvdyB0aGF0IGRpc2N1c3Npb24gYXMgd2VsbCBhbmQgYmUgc3VyZSB0
aGF0IGFsbA0KPiA+IGNvbmNlcm5zDQo+ID4gcmFpc2VkIGZvciBHdW55YWggYXJlIHNvbHZlZCBh
bHNvIGhlcmUuDQo+ID4gDQpTdXJlLCB3ZSB3b3VsZCBsb29rIGl0IHVwIGZvciB0aGUgYWJvdmUt
bWVudGlvbmVkIGluZm9ybWF0aW9uLg0KDQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IEtyenlzenRv
Zg0KPiA+IA0K
