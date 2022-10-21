Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198676075ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJULSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJULRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:17:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0A925FD39;
        Fri, 21 Oct 2022 04:17:53 -0700 (PDT)
X-UUID: 3742794a26e04d49bca54dea7535f9f1-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CwLGiW2Nss5MX5fwpk4zGv9lbgDcCeYyk4Sry4o6hkU=;
        b=EiEao3OgAX+8kwe7ThRhw2fKFPQes5EPuhpi1Z4kER8HEo9/0K0nfjI/p+mDB5+fnhhPCe5MAdQwwOnCEBR6BRMEI4AwIV+SP0SeFScKikKjzqI4iUhJdNBBabzHACRMNvu+Ip51RmWoBwbSw0aE0uo91+dlk9355mzzYbhWL0s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:78bc83a5-fabc-45a0-9e5c-66a9237b1955,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:e36b48c8-03ab-4171-989e-341ab5339257,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3742794a26e04d49bca54dea7535f9f1-20221021
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1085255240; Fri, 21 Oct 2022 19:17:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 21 Oct 2022 19:17:47 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 21 Oct 2022 19:17:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaK4fdXRnoXSCg7F3isFKUNgDj81w4oarzloj8X3KSwqAqNrqhNlooKN7QC8KniVgdJfPsXv1GZrub6bCljAFZdA9CAW0SB3PBh9S25PaJ3OHjh268Q9BCC+X0e00WyPHECYWDWH1MiOT6RQcYJMAIJJmT4a3E9/T+3tii2Trh/mJx6pLvbkvsCffh9RHMulSR14hAE8wWw2nicHHgyANcYYUp+EQjjlzoCmbllnUu5srgu475PJx1dyS9u941hC/K+TYU4hNDHqABO84vrJkAD1guJ9mrgQZLdSn+8zOoQrHMGARMrR3qPTmhc3QuojedwxNZaSHrrqX9p0x436YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwLGiW2Nss5MX5fwpk4zGv9lbgDcCeYyk4Sry4o6hkU=;
 b=mQtQP6QBJVIywsgN6G5obcphQ6EV7UHjQzhWxN09nBlOP3JYysrNNBHEt+AM+KmQEoVkH6CauhfWSZgMME06foEjqzxJA3OT8ouXlKrDME493ZWJkbi1sv1D0/wuMb4wd/ijefJsMLyBk8M+N8vShPEBdqhTdklFCZ/pirnGiZuDQwtzcusnb/hsrmOlO/oQCi9jWgSZI7o8YWtkPHUvEih28yrQgSXO1sYpE4hYFuB3+EhVkH4cAQfOovrMg+48P+8lW4Dc7/1rBgBtBJqrH77gAnMcb9qW9c3NgTnmOUysFz0aD5m+Ak1dfbbH1b9d+BNrYGcKNcvBftUX8E6gfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwLGiW2Nss5MX5fwpk4zGv9lbgDcCeYyk4Sry4o6hkU=;
 b=SCougwHf/pL/Q23V59ov18+VRYg7KjJCxizbmgSnuIrapU0sENEBsbkINWVEd0ZaH7qhbmPqubo+sGGHiC5NzTA2y7TAo2e8S0A24pZuYdtg9hvgZjZuhUKXBjyg/YfruTi/XZ72Z/MgLc4v+cnOPxT5ynhgjxPzinFdHQPq5go=
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com (2603:1096:400:142::9)
 by KL1PR03MB5489.apcprd03.prod.outlook.com (2603:1096:820:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.18; Fri, 21 Oct
 2022 11:17:45 +0000
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::691d:c9be:8a6f:5e85]) by TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::691d:c9be:8a6f:5e85%8]) with mapi id 15.20.5746.018; Fri, 21 Oct 2022
 11:17:44 +0000
From:   =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?S3Vhbi1Ic2luIExlZSAo5p2O5Yag5pawKQ==?= 
        <Kuan-Hsin.Lee@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?WXUtQ2hhbmcgV2FuZyAo546L54Wc5qifKQ==?= 
        <Yu-Chang.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?RWR3YXJkLUpXIFlhbmcgKOaliuWTsue2rSk=?= 
        <Edward-JW.Yang@mediatek.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Thread-Topic: [PATCH v4 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Thread-Index: AQHY3vZX+12K5aZzWEmPg4uSwosspa4OXRQAgAQ0XICAAGdXgIAFxsaA
Date:   Fri, 21 Oct 2022 11:17:44 +0000
Message-ID: <b5e4a2332942722f4138e5bf758f61e15dbad92e.camel@mediatek.com>
References: <20221013112336.15438-1-johnson.wang@mediatek.com>
         <20221013112336.15438-3-johnson.wang@mediatek.com>
         <20221014204242.C7CAFC433B5@smtp.kernel.org>
         <6a866b8f4e997a33adeaaf4498c47de76e07fa35.camel@mediatek.com>
         <20221017190501.0B85AC433C1@smtp.kernel.org>
In-Reply-To: <20221017190501.0B85AC433C1@smtp.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6274:EE_|KL1PR03MB5489:EE_
x-ms-office365-filtering-correlation-id: 30bc96b0-15bc-4e41-79ae-08dab355e06f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mc+7HVvaz9AtfbwaKvbMbicb/K4gmXSMJFGzFoOx4cmSSwVhecbbXZP392OClDffMC/A+CfQQorXXXxzyjyfhCSE52O7HTopcKNXbc3AcPtdHUhOb4WQOmlN+HRxFJz7H8n33+VwEHrwpzfySqWNV57MgxKjKDwQu8up2v4yEN0ld/0c+zJyulX02eNWwUbGcxKPWC43qpWkcCmUwpzRdwmC+6xAK+P+ZwmN4PG6s2cKnH+MzYd03E+wAoflAX7itJQoj1ZPVr542VgMoEuwqlhxrCS81KIpXB8K64hF2pxqyFxjQxc0aJwtmRMBzdIzvG74M31n7noV8AGb1LDGD1VK+Wg+/sma51hIW+oj1R47eO5t3umwkUWDcFKc/gBUbdGweZOuF5qaXLk71NS+LV/vJKgR8QmOx6TOs2Wokgeju6VORZnxioZO8spPlZ/FiFc0+svVdisS6LitCZi6I3or8pJUsMI1Pye9VrCEqudAd28nMhji9fCn/KJx84cSro2oyPtsIXXYs3KmERMIlMY819i6kp+iVasBYdJXJqj1oRdKPrVxQtMFJRVoaJEwv24etF1SwddejBq8Y+XFcTgshDw+Jhs3mZ6UOTXi0eK7g1hUxMIqqmgLGArQbchVDqR9xEwYwxpo4q2SfDu+oOrKdPM5wcg582LoTIJcxrfBrShvc3ywuoKnt2i0FosfWLnKNyWxvM78l3fi014tfdF2Kj1yCmfQWMPh+NpHCxg5td/77jYsWlLw1AB9pfLaL084hTQkwuNCbPGyh8UsDvSRk+cdRTmRcvea3S4++4BQoo2TZpFPHiWRj+Mnc4LA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6274.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(478600001)(71200400001)(2616005)(6486002)(316002)(54906003)(64756008)(38100700002)(110136005)(85182001)(122000001)(107886003)(8676002)(2906002)(4001150100001)(66476007)(4326008)(66946007)(66556008)(6506007)(66446008)(76116006)(38070700005)(5660300002)(91956017)(26005)(8936002)(36756003)(6512007)(41300700001)(186003)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjRpWS9tSjQ1aENwZWVLNUpYdnpCYmd3K0MyVjFxVHFsVTh6WmpVbGUwUC9i?=
 =?utf-8?B?cHR0cTQ3K3BNcnNmTXlmZjRvWjJCVFJkRHVXYXBpNGUrS0NpOGdYcndyZU1p?=
 =?utf-8?B?dld0ZWZwZ2ZBOXBadFkxc0ExTy9DYmgrWnhJOFpULzFncm5uYnQwTkNoM2U2?=
 =?utf-8?B?NTJOUThYSzJleWIrRmt0b1hWZmhFT0tWWmliMk5uWDZndmVLWTlMYUNFRDlM?=
 =?utf-8?B?cFFNYm5JcWZ2bld2Vks0Z3Fsb25uaWMxck9ycnoxdVVGaUoxaGNDK1RzSFdZ?=
 =?utf-8?B?V04ybUYyYWhxQldYbjA4N1YvcE90OG5uT1VZdjdCMWJSd1BIZVdQSGNBeitM?=
 =?utf-8?B?V09LKy9ySDJnU1dyZDR5dlFGV0xlTEpMV1kvaUpIaHNaWWRQTkluU3NuU1c0?=
 =?utf-8?B?VjJKZzJlaHdnOE1HZCsyK3dFYUIrSGxmeUF3MFlxWktUblozL3JLOENEbHI3?=
 =?utf-8?B?ZDJFT3pyQitUaEdvWTFDUGNsYUhiUHB2MHFUM1BCZjh6SnNjdTJNdVJPL3Zx?=
 =?utf-8?B?V2lnZmEvanB4Z0NVNUlXQ2xNZ1U3UmZVekZTaWJ2clJIbk5RYTRjcVFLZyti?=
 =?utf-8?B?NTVIaVViTDhmOE1oS1VsT2lTako2NldTam9OU292OGU3NEQ4anlzYVM1WVVE?=
 =?utf-8?B?UWlyRGxNZkdwN3BVWVFRMVhKRHZJckQ0RXdBbjFucTRnNWNOR3VRMHhjWVRv?=
 =?utf-8?B?R3NldHJHcUVrbEo0bGFmWndML3lCYWpJMW94azFmMXVJd3pFT01SS3U4cytE?=
 =?utf-8?B?VVdLQ0NPMlF1VlkrYVI5bk1EK0l2VGJLRlcwWWZVVzU0VTN1YThubEthZk03?=
 =?utf-8?B?K1pzUXFoT1VvYWhMZUx3bjNJZDFuT2lJcmhTbE5tektLdXFNZE9sVlFpdDBY?=
 =?utf-8?B?WWN0bkdPWjdIdE95cjNiOWNjRnFaYmNRTHVCSUtDdVRxSVR1eE0vOGkxVnkv?=
 =?utf-8?B?aVZVYjJ2dUd3SDdYOWpnREExREppUDN4VEZjQzk4dWlwRmpWZFBKK01oWWV5?=
 =?utf-8?B?STEwUTlXT1UwN2RTbHVTcWxQOFNkVnF1a09lWnlUMGFOeWtiaHJZNk8zMDFh?=
 =?utf-8?B?bjFxTmJPTzdRUHljRFpZdUFzN0puNzdzNEZaTEtIR3N5bXZ4d0k2L3dCU0Jy?=
 =?utf-8?B?S1MyQTk1eGUxTHdpcUczbEtWVXFDTG9FeXVQTFYyVlltN044L2NhOGZhSmZm?=
 =?utf-8?B?ZWRtb1d4bnp5MXlnVHZUdWxTWFRYNWc5OTdJcEY3UHlwQy9Ca21SdjZ0dGlW?=
 =?utf-8?B?bWp2cjRZQ09SbnZlWHdVYXhYYTZSQTBqK0FNa25BbFh5eU9qL21SL3d5TWJ1?=
 =?utf-8?B?bUlMeUpKUWJ3UVMzZWwyckJEd3k2S2pXQ3o1bXlQWXlOSTBMTGFndFR3OW51?=
 =?utf-8?B?YVFqU2tiWVQxejcxNlhoZFA3VW8wVGtVc2FLMFg0VisyWE9uTnhGTVltTW1K?=
 =?utf-8?B?SVE4anNwUGJhSk1GTUJnMTRtQU84WEJZSVJXejFxamxJbldPZUwvdW03MklV?=
 =?utf-8?B?TlJlWHhLS3BDTkd4TVBVNTJRYzg0TytDRkxkRXgzWHA3eEx1czhLcDZTb2RB?=
 =?utf-8?B?NkI2R0JWcmdmMzdtZ2ZJelZEeGJkSnFKWGdHbDZxS29oZUM5WGFpanc4czhU?=
 =?utf-8?B?VEhYaDNsdXNpRUdCMllmb3NESjNZTkkyMnZQT0ZLT3NqRWNhK1FLMmI3aE1u?=
 =?utf-8?B?dXlQNUFrVlpkbjFHQ1crSDRsZXBRUVF6VFJlVkRZd3I2cWRMWG00MXU2VUtm?=
 =?utf-8?B?enUwRkVnWlZMelQ3YUgxTm44UndnVHR2clluUVdlVm0xenR3UUlLdW1DcHlK?=
 =?utf-8?B?WTdVZDJxOWNmcE93MlN6U3h5QkY0cytCbDlQdTc2OVA4QzNPdGR0cll3b0dp?=
 =?utf-8?B?NnJ0bFUxOEwxb00vQ0JkQkJJQnJ0MnFqRklobGRDUUMyK2lVa2RwUFV4TE5E?=
 =?utf-8?B?dFZkN0w0Q2N4cmN6dCtWUnVBanVyS3lkTnN3cU5vUlZScWNHY3BlaXVidnlL?=
 =?utf-8?B?ZURnbG8zdW9hZEJoUktUM1NSbVVyRkVoMCtJb0hhMGswSnlGNFd0NEw1Ykt3?=
 =?utf-8?B?aWVydms4VWZaR0hVeS9MVVB3RFFiQUFCMndWYlZHajI5L0l1OHBhclNkdjFE?=
 =?utf-8?B?MmxuUXdqQjMxbUFsS0V3aWRoTURteEVkOTNXQURsb0JxRFZCWDFUV3pRYVNX?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FFBD8D268EA6343B277B883B8E79067@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6274.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bc96b0-15bc-4e41-79ae-08dab355e06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 11:17:44.4703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hlo4cEBlkiXlxbt/RtPlznBNIjVY4V3ES6omRTvjSUIXOEM8YpEZNY1J8g9qp6K8CzNpk2zQRpImyHVpF6pQnQu3hLRBRIUY7e1an8b6io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5489
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTE3IGF0IDEyOjA0IC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgSm9obnNvbiBXYW5nICjnjovogZbpkaspICgyMDIyLTEwLTE3IDA1OjU1OjA5KQ0K
PiA+IE9uIEZyaSwgMjAyMi0xMC0xNCBhdCAxMzo0MiAtMDcwMCwgU3RlcGhlbiBCb3lkIHdyb3Rl
Og0KPiA+ID4gUXVvdGluZyBKb2huc29uIFdhbmcgKDIwMjItMTAtMTMgMDQ6MjM6MzQpDQo+ID4g
PiA+ICsgIC0gfA0KPiA+ID4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgx
ODYtY2xrLmg+DQo+ID4gPiA+ICsgICAgZmhjdGw6IGZoY3RsQDEwMDBjZTAwIHsNCj4gPiA+IA0K
PiA+ID4gSXMgaXQgYSBjbG9jay1jb250cm9sbGVyPyAnZmhjdGwnIGlzbid0IGEgZ2VuZXJpYyBu
b2RlIG5hbWUuDQo+ID4gPiANCj4gPiANCj4gPiBUaGlzIG5vZGUgaXMgdXNlZCBmb3IgZGV0ZXJt
aW5pbmcgaWYgUExMcyBhZG9wdCAiaG9wcGluZyIgbWV0aG9kIHRvDQo+ID4gYWRqdXN0IHRoZWly
IGZyZXF1ZW5jeS4NCj4gPiBJdCBkb2Vzbid0IHByb3ZpZGUgYW55IGNsb2NrIGJ1dCBhY3R1YWxs
eSBjaGFuZ2UgdGhlIGJlaGF2aW9yIG9mDQo+ID4gc29tZQ0KPiA+IFBMTHMgd2l0aCBuZXcgLnNl
dF9yYXRlIGNhbGxiYWNrLg0KPiA+IERvIHlvdSB0aGluayB0aGlzIG5vZGUgYWN0cyBsaWtlIG9u
ZSBraW5kIG9mIGNsb2NrLWNvbnRyb2xsZXI/DQo+IA0KPiBXaHkgY2FuJ3Qgd2UgYWRkIHRoZSBy
ZWcgYW5kIHByb3BlcnRpZXMgdG8gdGhlIG5vZGUgdGhhdCBpbXBsZW1lbnRzDQo+IHRoZQ0KPiBQ
TEw/DQoNCkhpIFN0ZXBoZW4sDQoNCk5vdyB3ZSB1c2Ugc3RhbmRhcmQgY2xvY2tzIHByb3BlcnR5
IHRvIGdldCBjbG9jayBpbmRpY2VzIGZyb20NCmFwbWl4ZWRzeXMgbm9kZS4NCg0KSWYgd2UgaW50
ZWdyYXRlIHRoZSByZWcgYW5kIHByb3BlcnRpZXMgaW50byBhcG1peGVkc3lzIG5vZGUsIHdlIGhh
dmUgdG8NCmZpZ3VyZSBvdXQgYW5vdGhlciB3YXkgdG8gZ2V0IGluZGljZXMuLi4gKEkgdGhpbmsg
b25lIG5vZGUgc2hvdWxkbid0DQp0YWtlIGl0c2VsZiBhcyBpbnB1dD8pDQoNClRoZXJlIGlzIGFu
IGlkZWEgaW4gbXkgbWluZC4gQWRkIHRoZXNlIHBycGVydGllcyBpbnRvIGFwbWl4ZWRzeXMgbm9k
ZS4NCg0KCW1lZGlhdGVrLGhvcHBpbmctY2xvY2tzID0gPENMS19BUE1JWEVEX01BSU5QTEw+LA0K
CQkJICAgICAgICAgIDxDTEtfQVBNSVhFRF9NU0RDUExMPjsNCgltZWRpYXRlayxzc2MtcGVyY2Vu
dCA9IDwyIDM+Ow0KDQoNCkJ1dCBJIGRvbid0IHJlYWxseSBrbm93IGlmIHRoaXMgdmlvbGF0ZXMg
c29tZSBydWxlcy4NCkNvdWxkIHlvdSBwbGVhc2UgZ2l2ZSB1cyBzb21lIHN1Z2dlc3Rpb24/DQpU
aGFua3MhDQoNCkJScywNCkpvaG5zb24gV2FuZw0K
