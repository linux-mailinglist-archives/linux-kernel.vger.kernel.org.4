Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8038272D72D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbjFMBxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbjFMBw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:52:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA835E78;
        Mon, 12 Jun 2023 18:52:54 -0700 (PDT)
X-UUID: 00e7db38098d11eeb20a276fd37b9834-20230613
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TXKnsgdvgeV6HrfYgo0pcskUC+nJ1KpXCotYPCmZ9io=;
        b=tAGLCXm9bnXlKSQYScCRysaBC+P0DDTxabqe/d5Hqy+LZduB7ARGYEBRytGXELZrdZVpzvmnSdXd0zmgEaB17n4cloSZYdengKqgI7lpuWoQcO5UuWzm+hF9N7nn8gdOoGnEC34TwmaC9xVtsJUobwviafZOZ+hMkr3SyQGK+j4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:b696c88c-6f8f-4520-8bc9-9b2c09257546,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.26,REQID:b696c88c-6f8f-4520-8bc9-9b2c09257546,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:cb9a4e1,CLOUDID:98bc683e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230613095251RY68AK8N,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 00e7db38098d11eeb20a276fd37b9834-20230613
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1245548661; Tue, 13 Jun 2023 09:52:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 13 Jun 2023 09:52:49 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 13 Jun 2023 09:52:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDaI20ak/tF0bFsJxgaoAZdVX7Hqf9St5xXcMw2MhBCNjXXQ5i6tZ/GRPVxqhJeYeM2s5OnKAnMSxDBNFxN6i+ClEDIgsSqLW0E3hIZkq5mtSUn1cD1SNyLBhOrhs8qYvMbqO5RyQ/PB0lNh70ygE3j51JqzhS2Ja+tzIExNCILI2yTeZ5YvSVT6dJqndNfepYVEA3Y7TSJmynpN/i9cJUg2vEuuOEZorQQFjSrGUA+zu2S+t6Y6KMcArAyWQ8aJh2b5gKoW3WXzmXbyoESy9vgglGVUZQmhdyBY7+nQj2PG9xzp8ZhTeC2P6gxtKyBuqoQLOIAfd51TwMWr8FjpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXKnsgdvgeV6HrfYgo0pcskUC+nJ1KpXCotYPCmZ9io=;
 b=I4xconeTP8Ec1BOUO4+595fc/8eUA4fdxnBCOjKPPXOujtZlJKpKRkITuyWAAC+g0HqpiqHquGvgTV7KPy8VMgK69HXWUu6ENjI46p9cr0NhpdfiojjxaCOiTTFYEvUbv0aKfmqERvemloD+BW4+q3ngDWLOawERpF3+OJ4Tr9T5+HB6yvN27ktUW2GTiBBaDi+ctVDN4pKQct1skT4GK9EWeGeALo5wWSjtYZB1iIX1ryVFAd9OrHqWjtNXbLJTKnm/Q7PY4gto4szAtRlpIdKd+QfTD2o72Z67azq2r1rCYqDKwl+QRwsGI3FBNDnhRXEF7NIJYzJBzNnNUTK3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXKnsgdvgeV6HrfYgo0pcskUC+nJ1KpXCotYPCmZ9io=;
 b=Gfo6PtCGFYSVmaDIvu3AvCIRHY+hjLc4l/ylDj7wljUwTSOTH2XaEwL5Few3jp6hi5Nq0b0Svx5ZZaC7y7LcgNoNK05PnnxoWUJO5ERD8TnRoiYIsa0rg98Ah5GxHxtzDVLiH9aN8oP2o8im5ZxN5ikuVbCRAosFSfJJYwPicGg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6877.apcprd03.prod.outlook.com (2603:1096:101:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 01:52:47 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%6]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 01:52:47 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "granquet@baylibre.com" <granquet@baylibre.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?U3R1YXJ0IExlZSAo5p2O57+wKQ==?= <Stuart.Lee@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 5/8] drm/mediatek: hdmi: add v2 support
Thread-Topic: [PATCH v4 5/8] drm/mediatek: hdmi: add v2 support
Thread-Index: AQHZkjsmmHc/VTGOHU6M5MEfnDzs/6+IDwkA
Date:   Tue, 13 Jun 2023 01:52:47 +0000
Message-ID: <c5a5a32bd13d709bbea310d218c1f68cb2707a02.camel@mediatek.com>
References: <20220919-v4-0-687f09a06dd9@baylibre.com>
         <20220919-v4-5-687f09a06dd9@baylibre.com>
In-Reply-To: <20220919-v4-5-687f09a06dd9@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6877:EE_
x-ms-office365-filtering-correlation-id: 01a6b91c-ae32-4c25-2b82-08db6bb0e334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ChwdxQpD33nbI+XPfh/KEHQWHOFtp6MHVJK+Qo8D9ayjfXiqm6P+hyQdZ9fCLMrcsjo2ZZSwMDbVpb5wZQ7SiK/HPgACdy5ppX34YsisUlkps1yfO7GIh4EJeXSW+HIzqX9vAmvNxaquK/2Nc1HsyegMTLmQvHlT7ROtx0GMGa9ACgRxPrxmOg7znpgjSpJr01Cp562OilR4b1R6JrOBTVm+fVdFS+lz1TCi+y5IcWSKYG37tp7sB3BFp5TDAYLa66Xlv9aD6zVYXcsNl1e4ZNXZdjlfb6vaEtUV3WRhlVP8yIztXQMD8bT9EoCMxK1yxKY454icTpP+v7CO4dAukEFKTBdAO/bA5FlHv6QRNN2CoC3peC79NoWdbkdUY65lHFjbfleiLk0p1ky3pl1zmcHPeEZ+mLSY6DueCiBkzglYro2zGv902RjmyBqcR2pVEF8G0mgNPmD+gfpDHPUB5cMU4imUwS0L0WMP7AOJ3PSq8pAjHTrustJBgbCgT9KwSiw188hctP/Vr5druLy68GL3XmwO8N15iWj50N7Pc1MkWBL1YYmc7luuZ5/GFtqs+/x8lzk7EZwX6ePTmY9TomnzxStwpeXplT/3bmOmwWfypwZzdZR9nZOet6MuiAK/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(66946007)(76116006)(66476007)(66446008)(64756008)(8936002)(8676002)(66556008)(4326008)(316002)(110136005)(54906003)(2906002)(41300700001)(478600001)(5660300002)(7416002)(6486002)(71200400001)(6512007)(26005)(6506007)(83380400001)(186003)(86362001)(36756003)(2616005)(38070700005)(85182001)(38100700002)(921005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2N5MlNpVXY3TlpuSUJiNkVDaEFSQ0Frek9LdVdhcDRJYjB6dk01a0dEU2x2?=
 =?utf-8?B?d3BHT1plQWpSQlVhTWp5d3lVcnFpdEZLRkRJS09qSUl5Z1prZGI5b3NsSlJz?=
 =?utf-8?B?NHRtRmFtcDk4SzFObnlXazFJdVNuWk5vdG5ZU29RY0lBaDdKd3ZsQW93UjFq?=
 =?utf-8?B?eTgvc1d2cHNzeGpEaElacm1rcjU1WEZiN1lTU2psalc1aDNLZFQvQXA5ajZY?=
 =?utf-8?B?QlVsRWwySllzc2ZkRG4rSW1jclU3SkpyOVBwL21yMElJYWxKWEpubExoRnJJ?=
 =?utf-8?B?eGFMcU5UREYxRU9WUFNZeGpnVUFoRzlsQU9kd0NTNUwxU2ZIZGdhNTlHNFhL?=
 =?utf-8?B?dDJLV1N5TWxDVWloT1l6VzhhY1FMSllzSTl1RzQ1R1B2cHE5SlVZY2tGNzVu?=
 =?utf-8?B?OHpJSlk2a2VxZ0FqMXlRVHFlMXEyYW5kcUJ3L1RvaitOYXhvUGp5RjlOK1RX?=
 =?utf-8?B?eFJsOStyR3FraUx3ZnkwVTQ4RUVJaEtQMGh1aUtGT3VPRVJqM2QrQ25qV1Vt?=
 =?utf-8?B?aHJPWlYzOHNWdFNsTHlrU0xJWFpoK0JyeTdhRW9wUFd1cWRKeXFrd0JWdG5a?=
 =?utf-8?B?Zk51NzlkWnZYTlZzNTZYU2pzNVFjOEVoamRyU2crUVB5YTdLSEJmLzZNNEJC?=
 =?utf-8?B?d1ZvMTYyRXlMTFowZUtINVRCTTMrVldlVlBWOG05WXNFWGxHTVBFSnNBdEtx?=
 =?utf-8?B?aGdsMGNvd3JqaFAxWEpXaVNSMG9FemY0aGJiellWL2o1ZWRJMXplVDNxR1BB?=
 =?utf-8?B?Ry9TV0o3L3IrU2ZSNlZ6K2Y1ZTN4eldxZGhha2gyZ1JuMzJ1QXRLalpWTXpX?=
 =?utf-8?B?UEVPaTJ4cCt3OFk1M1VhcmFSY1ZIVlZLZFgvalh5S1RGbi9ERTBXNlIybHht?=
 =?utf-8?B?WkI2NHkzSFdtVHkvMkdBRGFrWndpa3EwRHNIQ0lhalRaQS9ESFgyQ2E0Y1la?=
 =?utf-8?B?MWp2L1ozZ0p2NkRDR0llMzhCWVFEc0kxZnJyZ3FlS1oyQ2FEOG5BZGlBVytO?=
 =?utf-8?B?OWI4VThsdGtldFJHeW1vVjI3SXVZdjZqR0FFZkdrTkJYUmp3U2xjQnYxRUpT?=
 =?utf-8?B?bUlzM1RXeWtncTZOOTVvR3l6S1ViUjIwOFdleW5DSXRicDExWVdVRDlWbW85?=
 =?utf-8?B?enR4S3VZUXR4UnIwL2V5UjBmU2lrNnJaODA2WmtrZDRFZ01BUXBOMnhGUkpv?=
 =?utf-8?B?ZHNFdUtOUjI5N05pMXQ3MjZqRmpqUTVjVEdjZk13cVVmVUZlTXdCUUNES2Uy?=
 =?utf-8?B?RzNSa2d6RWh1L01zQ2dlazlYTVNMRyt0b1ZQMElDUENVNG1PWDlCaWFqZ3Fp?=
 =?utf-8?B?VTFUTCtneTBYZkRHYzB4T1JEV1BtV2dvN0hVMzJ5QThKbjl4TThnbFJtRGlW?=
 =?utf-8?B?bVZaU3phOVFIUXR2NHVTK0pzT2QwVEJQZVY0Mmc2enFHSi9odC9GOERleEZB?=
 =?utf-8?B?aXhORks4bzc0L2I2TnEyNzJsMVZjQUg5cng2THIybHBod3RxZlJmbnBpQlpm?=
 =?utf-8?B?NUNFRmVCQ3k2MDlYYURtNlNJTlFTSVlEYWE5OEg1SDZDdjRLT1c0RWJmREN5?=
 =?utf-8?B?U1dhWWRzVHc4N05MV2htWWdFeDN4WDQzS1k5OWsrZUp6Zm1OUWpDVCtSZWEz?=
 =?utf-8?B?cVhYUlhNakI0bHVnMVhBTncvdW5WcFgva1NwakJHaUZsc3N4eUErVHl6N1ZR?=
 =?utf-8?B?dThjQTVTK3JJRE5QNnVqVklOdG40bDdaaWtaR21mTXlycE0yQlFTVGJXV3ZI?=
 =?utf-8?B?VXNuTzMweDVreGlUNmdOdGlNUjlWNk5TNHZQVDlaeEp6OHBHVy91dVpkZVd4?=
 =?utf-8?B?dHdNQU9HUFhkMi82azNWdlRSNXBBNkRZeGtZREJGQ1hxa3FSeStQSFllMWN0?=
 =?utf-8?B?QWdQc05lV3JoQXRXczdnU0FKTXFOaFRrRlBNMExraGhEdzdjVDRLa2gvMDZL?=
 =?utf-8?B?V3B4N0NMS2x3akJ6UUF4dmJ3TE0veWMyWXdHTlNhbExzUVNmcWN4TWFIK0gz?=
 =?utf-8?B?UVR5MmMxbUhuYkdPUDYzZkk1KzhLdXJDS1BobjJ2MjVUVmJiYVhzZ1VBSDh6?=
 =?utf-8?B?S1hyWTh0aGdlNFY2cDR0MVY1b2NiT09NK0F4QTR5UVZHSFJlUEhtTTN1VThy?=
 =?utf-8?Q?i+wYHQpHQ1EED16KAr1UVUG+M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDB59C07985E6145A3E2DCA970D37D94@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a6b91c-ae32-4c25-2b82-08db6bb0e334
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 01:52:47.2880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kcx4yWrrb2qNEwLj6qvkAkvH48/VtfpuDU9gJ9D4t/OO3IEzjW/47qLCGCn6Os714mchxZwJZ+XERzpKiAVlXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEd1aWxsYXVtZToNCg0KT24gTW9uLCAyMDIzLTA1LTI5IGF0IDE2OjMxICswMjAwLCBHdWls
bGF1bWUgUmFucXVldCB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZl
cmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBBZGRzIGhkbWkgYW5kIGhkbWkt
ZGRjIHN1cHBvcnQgZm9yIHYyIElQLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VpbGxhdW1lIFJh
bnF1ZXQgPGdyYW5xdWV0QGJheWxpYnJlLmNvbT4NCj4gDQoNCltzbmlwXQ0KDQo+ICsNCj4gK3N0
YXRpYyB1bnNpZ25lZCBjaGFyIHZkZGNfcmVhZChzdHJ1Y3QgbXRrX2hkbWlfZGRjICpkZGMsIHVu
c2lnbmVkDQo+IGludCB1NF9jbGtfZGl2LA0KPiArICAgICAgIHVuc2lnbmVkIGNoYXIgdWNfZGV2
LCB1bnNpZ25lZCBpbnQgdTRfYWRkciwNCj4gKyAgICAgICBlbnVtIHNpZl9iaXRfdF9oZG1pIHVj
X2FkZHJfdHlwZSwNCj4gKyAgICAgICB1bnNpZ25lZCBjaGFyICpwdWNfdmFsdWUsIHVuc2lnbmVk
IGludCB1NF9jb3VudCkNCj4gK3sNCj4gK3Vuc2lnbmVkIGludCB1NF9yZWFkX2NvdW50ID0gMDsN
Cj4gK3Vuc2lnbmVkIGNoYXIgdWNfcmV0dXJuX3ZhbHVlID0gMDsNCj4gKw0KPiAraWYgKCFwdWNf
dmFsdWUgfHwgIXU0X2NvdW50IHx8ICF1NF9jbGtfZGl2IHx8DQo+ICsgICAgdWNfYWRkcl90eXBl
ID4gU0lGXzE2X0JJVF9IRE1JIHx8DQo+ICsgICAgKHVjX2FkZHJfdHlwZSA9PSBTSUZfOF9CSVRf
SERNSSAmJiB1NF9hZGRyID4gMjU1KSB8fA0KPiArICAgICh1Y19hZGRyX3R5cGUgPT0gU0lGXzE2
X0JJVF9IRE1JICYmIHU0X2FkZHIgPiA2NTUzNSkpIHsNCg0KdWNfYWRkcl90eXBlIHdvdWxkIG5l
dmVyIGJlIFNJRl8xNl9CSVRfSERNSSwgc28gcmVtb3ZlIFNJRl8xNl9CSVRfSERNSS4NCg0KUmVn
YXJkcywNCkNLDQoNCj4gK3JldHVybiAwOw0KPiArfQ0KPiArDQo+ICtpZiAodWNfYWRkcl90eXBl
ID09IFNJRl84X0JJVF9IRE1JKQ0KPiArdTRfcmVhZF9jb3VudCA9IDI1NSAtIHU0X2FkZHIgKyAx
Ow0KPiArZWxzZSBpZiAodWNfYWRkcl90eXBlID09IFNJRl8xNl9CSVRfSERNSSkNCj4gK3U0X3Jl
YWRfY291bnQgPSA2NTUzNSAtIHU0X2FkZHIgKyAxOw0KPiArDQo+ICt1NF9yZWFkX2NvdW50ID0g
KHU0X3JlYWRfY291bnQgPiB1NF9jb3VudCkgPyB1NF9jb3VudCA6DQo+IHU0X3JlYWRfY291bnQ7
DQo+ICt1Y19yZXR1cm5fdmFsdWUgPSBkZGNtX3JlYWRfaGRtaShkZGMsIHU0X2Nsa19kaXYsIHVj
X2RldiwgdTRfYWRkciwNCj4gKyB1Y19hZGRyX3R5cGUsIHB1Y192YWx1ZSwgdTRfcmVhZF9jb3Vu
dCk7DQo+ICtyZXR1cm4gdWNfcmV0dXJuX3ZhbHVlOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgYm9v
bCBmZ19kZGNfZGF0YV9yZWFkKHN0cnVjdCBtdGtfaGRtaV9kZGMgKmRkYywNCj4gKyAgICAgIHVu
c2lnbmVkIGNoYXIgYl9kZXYsDQo+ICsgICAgICB1bnNpZ25lZCBjaGFyIGJfZGF0YV9hZGRyLA0K
PiArICAgICAgdW5zaWduZWQgY2hhciBiX2RhdGFfY291bnQsDQo+ICsgICAgICB1bnNpZ25lZCBj
aGFyICpwcl9kYXRhKQ0KPiArew0KPiAraW50IHJldDsNCj4gKw0KPiArbXV0ZXhfbG9jaygmZGRj
LT5tdHgpOw0KPiArDQo+ICtoZG1pX2RkY19yZXF1ZXN0KGRkYyk7DQo+ICtyZXQgPSB2ZGRjX3Jl
YWQoZGRjLCBEREMyX0NMT0ssIGJfZGV2LCBiX2RhdGFfYWRkciwgU0lGXzhfQklUX0hETUksDQo+
ICsgICAgICBwcl9kYXRhLCBiX2RhdGFfY291bnQpOw0KPiArbXV0ZXhfdW5sb2NrKCZkZGMtPm10
eCk7DQo+ICsNCj4gK3JldHVybiByZXQgPT0gYl9kYXRhX2NvdW50Ow0KPiArfQ0KPiArDQoNCj4g
DQo=
