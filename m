Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC216B1A6D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 05:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCIE31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 23:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCIE3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 23:29:17 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39FD9311E;
        Wed,  8 Mar 2023 20:29:13 -0800 (PST)
X-UUID: eee1958cbe3211eda06fc9ecc4dadd91-20230309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZwyJcPVp8oyARUwMGgsUK9X6PKR8Rj123uCHR27klak=;
        b=HwI6DSPdg2Z+dFz7gG85kPUWWS7Gh0RqdDFsN/9JVBTl80UjzWzrqm4tlU+0WnuCyRHiD0ErBZBeZo6hC4FInJjMktgTs/XCg+79kPdp9srT9BDyDzKg1802A7+z8vNy4LEuuPPb5OG5XHBpiv1SrK6O0tM3vnYFHWIZQvjnNxg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:14507c27-beaf-4206-881a-a8ba1df48dd8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.20,REQID:14507c27-beaf-4206-881a-a8ba1df48dd8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:0480cd27-564d-42d9-9875-7c868ee415ec,B
        ulkID:230309122911G3OKMGRX,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: eee1958cbe3211eda06fc9ecc4dadd91-20230309
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 392479038; Thu, 09 Mar 2023 12:29:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 9 Mar 2023 12:29:07 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 9 Mar 2023 12:29:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWEO1QrD53zthJtlAfo1IYRDQh7VgmLM6DwTgXEsJ1xxOrfKCjfJkgaMBpjBRqwgOaOm2dyrzlr7l7VYU2OWKjKb/CV8E/ordmpYr5SwpEkEQk3L7UtOfEsGtX6TWMk7phO6cPh103LbaFKimWoQJ9vbPo+wqJ3+6r3fos6DabPR4ka4vK+jKhZFTKF7lJqUcxvKo2MJoqvx6ozwem4U8fRE9GR0dPekWiYPHm/QLO87y/Hs1pyNq81OfcTw4lmSB+UnpLf4Dl8Obwlnlzxhn4tWq9eJuZVTuHlj6sRF0torS1SDhVT201rIKD7+Ak+eTOMS/HgtCeL1wTl3lTBCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwyJcPVp8oyARUwMGgsUK9X6PKR8Rj123uCHR27klak=;
 b=jpShbomwGNdjm7W3clLdaWZVk0vb3aRQe6yRO93ow5UmOLk2RCzzJPzaZgNwYP//x0KMbOfQgnjkEo14uSMBoobDwISs6oPV7i/zyBvoyGvHfPbJpu1CYwh8fToOKzUNAs8qlUw2V+2NUykIQiOZaePSc/mOQ1Ue8/e1K9UExfVTwDsNOGNPdvbo/kRxIso9S6iaw/R7dx4TcEv0EVtNVc5Yy1zBA943NLrVvOT6EX/mVaHkCEg1NNA0lssl/tTVEnp27t3itjgeIsp9kQK1fMPtJuh1lyV30b+L5+8pFD3l0Hb97gi/0uXo97WZALimD7yY0IF7h2yzbk7gd7dwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwyJcPVp8oyARUwMGgsUK9X6PKR8Rj123uCHR27klak=;
 b=V8ExhYIkVUqqnRxn/v1nlTp6xZPFmOPMXUuO8ag1ns70Fpd1KiA7lPVr18OdLgj19oG+uX9pvSnYhPxBLMvEZVpKdkQqdi+FEA0lYT/SKVqb8v3IBRcQepQApAseADIZPKwS2Aeq+Q5gsIieUSMjcACTSCZ0w+42iIBU7p8jyD8=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SEYPR03MB6962.apcprd03.prod.outlook.com (2603:1096:101:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 04:29:04 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::c821:f285:9b2f:35e8]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::c821:f285:9b2f:35e8%3]) with mapi id 15.20.6178.018; Thu, 9 Mar 2023
 04:29:04 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
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
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] arm64: dts: mediatek: mt8186: Add display nodes
Thread-Topic: [PATCH v3 7/7] arm64: dts: mediatek: mt8186: Add display nodes
Thread-Index: AQHZTX7cFvV31zkpT0WwasY/mrhjtq7o7XuAgAj24oA=
Date:   Thu, 9 Mar 2023 04:29:04 +0000
Message-ID: <c96a228230a32fcefc4250d7cbbf9c702b024706.camel@mediatek.com>
References: <20230303031728.24251-1-allen-kh.cheng@mediatek.com>
         <20230303031728.24251-8-allen-kh.cheng@mediatek.com>
         <8fb0176f-5587-e446-a084-05bd0572f2de@collabora.com>
In-Reply-To: <8fb0176f-5587-e446-a084-05bd0572f2de@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SEYPR03MB6962:EE_
x-ms-office365-filtering-correlation-id: 41f2f6a3-e203-4a2b-b6d5-08db2056d0ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QVV6qCGKSJlNIzRYxcf1JcimIvDuD8K1mFiWViJTtR8vUbSYbGJ6rBYdcQu9d1yAqGPTn4ZIu87ZrtXAOwzUc/K2sKEAdwe8rZYvc9DycKr2xqAPHuSWWseqnIFvAXIAPGtRiU+PE1Lfz3FSa9Av/cnrKLHdugyTYQWQwISdSetLiCJiYl5cAE/kCX5WVkQ5GGkB8NuqZeodJ4SqB+f4QGIGUG1MBjjTmu9P9nCLWWNzg0uMq2iebZfj8xJrb9pqdRUovbpK17AUTBQIJ7Tk6JW3ldGwh0OajmEbZ5n7YWUP14jvsbTLVTP6LwCZnNIVTIZl49yApGHdti0smu/yIHzvP7N+MaU58ogCMpJr0wY+nTJykqJH5g91yuTgBHHp2d6/meIszIfcwYG4OBJB3n9gPEjGaTAmgPh/YJwYtABjI6L0UCEwdmjymfXFPZ8KO3Lzg0v9dMDSLMoAxWqERbVU6Tnjw1cFWORI4AV5ov8vhqMARBhiLo0uGUkwwj3cfDaHexpaM2Dd2ZHgkDPLdbmRloT9rDIpfeXrlZK/Z9k5UAmHSkPo0FTuZIWsFj7a3GxhOrYOrkB4cJvDlZc16QW2oHJnlPee9qwRbvo8qzwOuhn+6ASC3/K1ujLmmqtVzV/krcYwVLk4M1ircLx/XoBYzhAFg5QyOptgZ6ojwDvLf97icBNV5hE0R4pHRM3dNkz6do0prreLkDkrsxuUCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199018)(8936002)(36756003)(85182001)(7416002)(5660300002)(26005)(6512007)(6506007)(38100700002)(122000001)(83380400001)(186003)(2616005)(54906003)(86362001)(316002)(110136005)(41300700001)(66556008)(66946007)(76116006)(64756008)(4326008)(66446008)(66476007)(6486002)(71200400001)(478600001)(8676002)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVNuMnAxZTFFVHRqTEJDamZIUFY4dTk1bjFBaTAwZGFldUQ1TG83QTJBN3FT?=
 =?utf-8?B?QVQ4QkpLaDBTajVzY2hvQXpMcTRIT2dkMkIzV0p6S3U1R2N4Wm1MakMzejFN?=
 =?utf-8?B?WmdZMkV4aEwxSDVUYzRYZUE4RTFtTnM1T3pKK25MREZIWE5SMG1jQUEyR3NS?=
 =?utf-8?B?MlZqQlFUdW9pRzdQVFo5MXhpUlp6VitaU21VU01NVU8wYWx4eHJWU2pSTlIw?=
 =?utf-8?B?T2lWYk5JY3ZXWDMrWTZwaXdIOVZBNzlqSzdYUmZPU2haaTVoUHd4TTM4UVFw?=
 =?utf-8?B?bUJqWElEWDBuZ0lpZGVpbXZxUUlKZ3NiS2EwVHZwMDM3M3FQeTFBTFg1d0pr?=
 =?utf-8?B?a1NzYlNjRTJ1cVVBYjlocy9ua294b0xxOS94QU1rZnpza2VWcTEvZWM2enpj?=
 =?utf-8?B?VUE1WG5uaWx3WVVVRWZZWWpzUGtselIzbDI1QUYwZTdCOXEzVnVlSU1lOVhq?=
 =?utf-8?B?VUxMVHE3eGpoMEhENk5nVm1NK29aU09aTEQrN0luYUd4NXU1RlVwN215cnhk?=
 =?utf-8?B?MW9rT2hxTVdNaTdCQnhlQ09VZG1IUkc1WTZDU1B4MGxzYWVMd2FHSVh5dEYx?=
 =?utf-8?B?OG5hZzNRb2xpT1NmZnJBTFF6WHhhQkZUVjVmdVFQZEZiVzhkdHc4NGVQQVAv?=
 =?utf-8?B?NVRub0lEeTdkTnZvMDVFT3ZhNFZkM0hESFpZOHMvK0hHRDR6TStnWERLNU9S?=
 =?utf-8?B?ZlBrTmRpeVlSUEoxM1hkamp3TjFoc0hYSVBxTVV1dGpQL3cvV1NraGVUb3R6?=
 =?utf-8?B?eU5sb2FnZ2lXcnIzNGJ4SmJsb3RERFI3ZnJjUmRueUR0aFJZQkxVdWkwd0Y0?=
 =?utf-8?B?TFBCci8ydUlNdjhCcEtmS3NVdlBsK0NySG9SVXZoYnR2bGFhKzBWUkNzZHVz?=
 =?utf-8?B?ZjMzVUs4ejF0a2g5YWZHL2dLMVZJUVB6ZW1uWXJjZzVYR2dOaVdTREFsR3Ew?=
 =?utf-8?B?ZzBNcFBjNEJIUTVmdnd1STFzUjNsU3RUQVJjdkhHOWpFQjVPNGNYNGp3VnJz?=
 =?utf-8?B?S0JNZUxScjNsc01GQzdCUUFBMkEyb1RSUGQzMlM4QTRTNGZtdzdWbE1SODVB?=
 =?utf-8?B?RWE1R3YvaEs3ajZqSlMvSmY2aGJvVFVJSk9EQlpkR3hjeVhtYWI2RHNEak1r?=
 =?utf-8?B?OU85dlNzZXpVUlBmM1QvTU1rRGkvRk1rOUZVWi9GVDdQck5XbXVROGtZZWxX?=
 =?utf-8?B?T0hEVURmK0wwYkQ5Rk5yaEVIUFBYNmxid0ZyWDlMQU1MU1NXT0owZFBscmtJ?=
 =?utf-8?B?dkl4NC9keE5KS3YrM3grcmQ0RlpWYWh6MHorVjhjbnNHYm0wSHRtSUNvdVM1?=
 =?utf-8?B?b3Z0UE9xWVZSVjk1T1R1bUF0dWVSNUlsMnE3OUhWYjBLUFpOQUdOdUF2N2dj?=
 =?utf-8?B?N3IzZ01HSjlzV00rUTFDMExsbklHOG02WDY1V3pRZzRzeDVQdVR5TTZNTE5K?=
 =?utf-8?B?RTg5MWZyKzRiVmtYZWFDeFBkUjZiS0RRNXpDRkx4MmhDaVQvZXloSmxPdDJR?=
 =?utf-8?B?R2svZ0RsUFBML0RsS0JMRk9wdXB1dG5qL3BRdUliVG1veXIyUHhoLzFmZDJa?=
 =?utf-8?B?MGQ2YWFBcnEzWkJEUHExY1N2QTFJNS9URHRkemhMQzhSTkZuSVpXdm4yVHFT?=
 =?utf-8?B?bVJvU05mNXRua203b0tRWEUrd05GOFU3VW1qb3p1c2ViaUVyOHlvaVBIWEU3?=
 =?utf-8?B?a1NUMFpjVjZmZmZaOUFuOEVEQlpvNkhlK2NDdjJlVmg2OUhjNjFiSFRaZ2o5?=
 =?utf-8?B?bEVZZ1FsRFdCaGgvckZyd2VTMnd2VkF1RFlVY2NWMDJ6VjNBSi9sdVkzb0Q0?=
 =?utf-8?B?Z1pRNjVLdEZIdFQrM0FudEsrWWs4SXpXT0FpYW1lRnloRTlTVFlOM3V2Vllk?=
 =?utf-8?B?SHVRMmJjeWFBMVRZaGxMSVg5dU5UVXJTc3lFdGt0NWtPcTRrclZpWWxjaWJR?=
 =?utf-8?B?dVpjOVJFVFhaUVpMNVhlYjA4Nzk1eW41dXpXSzN5eHBickdDUFcvVW5wZnRF?=
 =?utf-8?B?anhyRmJudWw1T1Nza3phclhkcDV1QmxtZ0xEZmZvcnVBanU2SmtLWnpFam93?=
 =?utf-8?B?L1VVTHAyemZOK3pac3RoUUIrVEViWittRWFVeVpxcFlHK3ozSTFPUzE0Z2x1?=
 =?utf-8?B?eUpUczdxME5SRFVxYnhHL1JRS3hKM3NyNEs4RklpU2plYTNWVEFsZFhydWxa?=
 =?utf-8?Q?L3Z439n8giqcwA96hsHsSwA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A91AE27CC61A343AB3A723953C18503@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f2f6a3-e203-4a2b-b6d5-08db2056d0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 04:29:04.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O523D+IDoegY2MaeeiLKiWBFRqTai1eYD99BI8Ap4P9XYvynjBfa6KpKEIPeb6lQd1isqFeZssRJdm14TcsDs1vPBSz7IVdFbJhatobgnaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBGcmksIDIwMjMtMDMtMDMgYXQgMTI6MzUgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAwMy8wMy8yMyAwNDoxNywgQWxsZW4tS0gg
Q2hlbmcgaGEgc2NyaXR0bzoNCj4gPiBBZGQgZGlzcGxheSBub2RlcyBhbmQgdGhlIEdDRSAoR2xv
YmFsIENvbW1hbmQgRW5naW5lKSBwcm9wZXJ0aWVzDQo+ID4gdG8gdGhlIGRpc3BsYXkgbm9kZXMg
aW4gb3JkZXIgdG8gZW5hYmxlIHRoZSB1c2FnZSBvZiB0aGUgQ01EUQ0KPiA+IChDb21tYW5kIFF1
ZXVlKSwgd2hpY2ggaXMgcmVxdWlyZWQgZm9yIG9wZXJhdGluZyB0aGUgZGlzcGxheS4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGxlbi1LSCBDaGVuZyA8YWxsZW4ta2guY2hlbmdAbWVkaWF0
ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgx
ODYuZHRzaSB8IDEyNQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMTI1IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODYuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9tdDgxODYuZHRzaQ0KPiA+IGluZGV4IGI5ZDVhZjI2NzcxZS4uOTA5ZjFh
NmFlMTA4IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4
MTg2LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4Ni5k
dHNpDQo+ID4gQEAgLTIwLDYgKzIwLDEzIEBADQo+ID4gICAJI2FkZHJlc3MtY2VsbHMgPSA8Mj47
DQo+ID4gICAJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gICANCj4gPiArCWFsaWFzZXMgew0KPiA+
ICsJCW92bCA9ICZvdmw7DQo+IA0KPiBBcmUgeW91IHN1cmUgdGhhdCB0aGlzIGFsaWFzIHNob3Vs
ZG4ndCBiZSBgb3ZsMCA9ICZvdmxgIGluc3RlYWQ/DQo+IA0KPiA+ICsJCW92bF8ybD0gJm92bF8y
bDsNCj4gDQo+IEFuZCB0aGlzIGBvdmxfMmwwID0gJm92bF8ybGAgPw0KPiANCj4gRXZlcnl0aGlu
ZyBlbHNlIGxvb2tzIGdvb2QuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQoNCkhtbSwg
SSB0aGluayB0aGVyZSBpcyBhIHNtYWxsIGVycm9yIGhlcmUuDQpJIGVpdGhlciBwdXQgaW5kZXgg
aW4gYWxpYXNlcyBvciBkb24ndCB3cml0ZSBhbGlhc2VzIHNpbmNlIHRoZQ0KbnVtYmVyIG9mIG92
bCBhbmQgb3ZsXzJsIGlzIG9uZS4NCg0KSSB3aWxsIGFkZCAwIGFuZCB1cHN0YWUgaW4gbmV4dCB2
ZXJzaW9uLg0KDQpUaGFua3MsDQpBbGxlbg0KDQoNCk5vdGU6IA0KaW4gbXRrX2RkcF9jb21wX2dl
dF9pZDoNCmludCBpZCA9IG9mX2FsaWFzX2dldF9pZChub2RlLCBtdGtfZGRwX2NvbXBfc3RlbVtj
b21wX3R5cGVdKTsNCg0KKGlkIDwgMCB8fCBpZCA9PSBtdGtfZGRwX21hdGNoZXNbaV0uYWxpYXNf
aWQpKSByZXR1cm4gaTsNCg==
