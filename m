Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F676A6684
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjCADfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCADf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:35:28 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155D438B7A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:35:17 -0800 (PST)
X-UUID: 10c50d20b7e211ed945fc101203acc17-20230301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nXYuXAVlLLbNif+L3uKFOJDoFXYXkGsxt2IVICIkiEo=;
        b=M5SU+cvwNAb054Np3E9OejiEpzKO89D6pG040DCRDcqzp9Z7ktmpXeXFo+tH4e481WVlB2yy5X/uupDboRdmxqKRC/ADCA93QuPNEjUsZOEv1qea0/7O/308KMI0btrjsPToMK1HeQX9UpbK1ejCsuOcDgnvKs05EVITihXfMgg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:c551edac-3d8b-477f-a8ff-fe640f4a698a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:62c95cf4-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 10c50d20b7e211ed945fc101203acc17-20230301
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yanchao.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 27549486; Wed, 01 Mar 2023 11:35:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 1 Mar 2023 11:35:07 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 1 Mar 2023 11:35:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIeEcuKxKHgwWKZBn9+MX71bbdvtaO4ssjyeQkgUbJfKTkiy3bf2mxpaTjAkNb/cEoP6O70F+C7HOlk6EuSi6oe7za3gYVss1RIJofaRUnPDMOmJ2c1wnaFNUj373FDBIyz4xVm3nS/0NI+UR1R7BPC39vmCNjqfmvw+hlmH0qzyFhR5gOkR3JgrOJyN+y7dKlVEFT2XMcafvLxQ/Fl1Y0SYO0bUNYThpRGhe4nXbpGPodEVkNObEo3AaSEb8/f+fYjGJ6MqdAcDdyPqrAwuxs7ULf/LSO8oFZjikwbj5XdD875qOYklYNfdi6rcOCVXAjaGcmeQjAx9nx55+TOr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXYuXAVlLLbNif+L3uKFOJDoFXYXkGsxt2IVICIkiEo=;
 b=jbKnLlAvc4cXkIGPJzFH4jDfJoIigGav5KvW4tGjoHwVA3TbYblXkwLugyQJISd+MzzULZHXmtlEQ4dSl2Wjf9QAWhuadT5qWqR0QsxsDGlqt55cuhSg1Z/ltRxNk45VcA7CleTSDma2otMI3MtiPAmkjG8+3zg20n0IGVbE87AKglE5Qs8rMSIMVd6IBS96jrgDl06nR6i5rFI/qJsDmPRGdOjecz3FJsc2sVGkbyfUwWERonvFbaFAng1KFoZX34alSeYctqxEOV6l+bW1BkZH6lXOzUroeaQQvr28ETMcBQrLkR+hzCBpRjOi7s/MsyM9cFiNo+yP2ObahPaAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXYuXAVlLLbNif+L3uKFOJDoFXYXkGsxt2IVICIkiEo=;
 b=MKWSrfOaLKYnR4jKXogfBTGYNdU41kidBRixCfmruuuQK24sC+9dga5OrEYZ0qOpgFC0DGmyhHBaljmAuWAfX4B1ZSpJvwVVYrimHg9O6Yx7MheK7bwwq//JEDkHZUuNs3FdweJOsLpSNlQo+69jbfHi0SSeiN2XiLlLL3/gBq4=
Received: from TYZPR03MB6161.apcprd03.prod.outlook.com (2603:1096:400:12c::13)
 by KL1PR03MB5862.apcprd03.prod.outlook.com (2603:1096:820:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 03:35:05 +0000
Received: from TYZPR03MB6161.apcprd03.prod.outlook.com
 ([fe80::7b38:f629:1b13:6dc7]) by TYZPR03MB6161.apcprd03.prod.outlook.com
 ([fe80::7b38:f629:1b13:6dc7%8]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 03:35:05 +0000
From:   =?utf-8?B?WWFuY2hhbyBZYW5nICjmnajlvabotoUp?= 
        <Yanchao.Yang@mediatek.com>
To:     "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "edumazet@google.com" <edumazet@google.com>
CC:     =?utf-8?B?Q2hyaXMgRmVuZyAo5Yav5L+d5p6XKQ==?= 
        <Chris.Feng@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWluZ2xpYW5nIFh1ICjlvpDmmI7kuq4p?= 
        <mingliang.xu@mediatek.com>,
        =?utf-8?B?TWluIERvbmcgKOiRo+aVjyk=?= <min.dong@mediatek.com>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "m.chetan.kumar@intel.com" <m.chetan.kumar@intel.com>,
        =?utf-8?B?TGlhbmcgTHUgKOWQleS6rik=?= <liang.lu@mediatek.com>,
        =?utf-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= 
        <haijun.liu@mediatek.com>,
        =?utf-8?B?SGFvemhlIENoYW5nICjluLjmtanlk7Ip?= 
        <Haozhe.Chang@mediatek.com>,
        =?utf-8?B?SHVhIFlhbmcgKOadqOWNjik=?= <Hua.Yang@mediatek.com>,
        "Xiayu.Zhang@medi" <Xiayu.Zhang@medi>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>
Subject: Re: [PATCH net-next v3 01/10] net: wwan: tmi: Add PCIe core
Thread-Topic: [PATCH net-next v3 01/10] net: wwan: tmi: Add PCIe core
Thread-Index: AQHZPfRhXG0uLuMh9ki8uUJNPx0e967PblKAgAIgUwCADDu2AIAAzFUAgAQ2vACAAHJFgIAA1h0AgAC0CwCAAJfcgA==
Date:   Wed, 1 Mar 2023 03:35:05 +0000
Message-ID: <3e38940908752018bda7912f294d7a7c390657b7.camel@mediatek.com>
References: <20230211083732.193650-1-yanchao.yang@mediatek.com>
         <20230211083732.193650-2-yanchao.yang@mediatek.com>
         <20230214202229.50d07b89@kernel.org>
         <2e518c17bf54298a2108de75fcd35aaf2b3397d3.camel@mediatek.com>
         <d6f13d66a5ab0224f2ae424a0645d4cf29c2752b.camel@mediatek.com>
         <20230224115052.5bdcc54d@kernel.org>
         <e7628b89847adda7d8302db91d48b3ff62245f43.camel@mediatek.com>
         <20230227110047.224909ee@kernel.org>
         <ebe8c4057b16c6565223af53bfb229dd1846d26b.camel@mediatek.com>
         <20230228103132.325def4c@kernel.org>
In-Reply-To: <20230228103132.325def4c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6161:EE_|KL1PR03MB5862:EE_
x-ms-office365-filtering-correlation-id: 7fa7a41b-1de4-4404-5918-08db1a05f2c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t+iRjZa29a9+iM4/Kvya7j0AJcKcKGJIkBtywfRT9t6MOhDNaza4tIqY/9RNLLNX3zaSYmJUhP7tA4PX5UF7ZI86j0ojKBQKdw6nC8Qc+ETPOOXYW1XDfC/O+WzVFFX/IFIGmnagf4FIQSpRU8zsU98PbeYWnaA7I2zq8CLHtz5XFD9551yHhBWBCZrkFRmLdaqzJ8dN0f6vlibjgNt9SNqHemRuONbVlXJq6ModBJhFbnzPrBf/RQ588czQPA6Et2FJ1LXOGUdpE2xFr3aokGRPKtq2WhB2zeije9kDevni1WnAE5jxcmfsrpPLTf5Q/gcxyrRQFMKHVNiENeCFIP/YEJaG6w6AFj1Nlstre27sYpJR8kCYf7bsPc8xPra8jfbWJp5Y6jcNOhVPHSwtoRypA7z+P77ShRdbzHEra2ljCxj95ArUbo3zyWPQu4DFHagl9m2BJUSryLwnI6Yr4204KJiIReujBYeO1l3Jz9ksIshIL6236S/q3xCD46TPZ2hO5jFqOoq6tsWtdzYchhOfGp1y3/gHhgKAYdxgoFkcTATmP0mIhO9661NuBmwCwpvveWt2DdkBgNTSXjVYg2BR9j5+3mg8wx/SwYkQWm22B0//UoeJVB88++HctPBTPKPT/tAuRgOFU03pHQ7Lw9TYRMfF3kIHhQj3rwmF76pbOecE5cu/sikAnKmsJw0RQFEWprNq7DmxIXb/V4n20HjDwdbCr8OTzvLhNxy/ZEJtJ/Pdaa8FQq4mQEFqj8lTnuftk01dWmygsas9hAHMtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6161.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199018)(76116006)(8676002)(66476007)(66556008)(64756008)(66446008)(66946007)(2616005)(4326008)(83380400001)(85182001)(38070700005)(38100700002)(122000001)(54906003)(478600001)(36756003)(86362001)(316002)(110136005)(71200400001)(186003)(91956017)(26005)(6506007)(6512007)(6486002)(7416002)(8936002)(41300700001)(5660300002)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUlKQ3RIMTVZRFZIMzBFaHorWExnYWk1WW4rSVlITEtqTFQ3a0hOSHVvcDFt?=
 =?utf-8?B?b0xLeW95czJXTVFYRkloNnVSTXVLdEZISGpHZ1E3ak5KVG5BdlhIUVlvbkpR?=
 =?utf-8?B?cXRLZVNQUXNiVGtYc0dnZk1FUHhOZlhQN3RyNnVsamxtQ21SY0ZLR1dsZUxx?=
 =?utf-8?B?Q2ExMTAxVmN5ZkhjRUYvWVgzcWNBcGNZRkNUaFhOaGZrYXhkWXN0MUxuZmNh?=
 =?utf-8?B?dVdIMTZlTHcxL2NNclZNUXl3eEwya0lsTVBmaHBsaU90eU84YlJjTDg2RkN1?=
 =?utf-8?B?ZnNURzNnNHdwMzU2VkpOUUYwYjdFVG5kaFpYTUtoRXJ4aHhIS0luMFdUbnZZ?=
 =?utf-8?B?a1ZZVFA1MnVNN241cGdwblFPcEZPWkJYWnBBUXh0NERKbzZYR2hJNE1zUjJI?=
 =?utf-8?B?OHBDWWhLY2dVODZPS0ZKSzY4TmwrVGU0RFJTOFY3T3lLeWFPM3VJczlraVZN?=
 =?utf-8?B?WnorMUFpVkp2RVVKOXdhYkF0ZlBrZnN5QS9JeG1rYUduV2xGUHJ0bDIzMzBq?=
 =?utf-8?B?eDRsMXdzRWRDVFVyMXE2Qk5UbTFzMXB0QVVIRkg1K1dDMFF3RnZEQTExYkc0?=
 =?utf-8?B?L3ZLSDVtQ1BtVFdNd1QyRE1yQjl1eWJmN0JORGQwQ3ZBVFdVQWQ4ZUZjdUZi?=
 =?utf-8?B?clA0NTh0K0V6YkVRK0d5bmpJRk1jRDkrb2pDc3JWV0JBNkFTL3A1RGM1elZk?=
 =?utf-8?B?QzA4czJGK0lGa0JUSmYyM1hoaXFEc05obHFzRFp1eWg3ZVlYdnhzcEJIRU4y?=
 =?utf-8?B?Yk1uT1BWamJvSFNwazRRU2toZ0dXNzBuOXAzekt1MUM5YUhzdTMwK1NyV3Zu?=
 =?utf-8?B?Sk5zMUN3cnB5NFhwaHVUNE4zdFcxYjBMUUNnWXJsUjR5NloyMWxjUytHNWox?=
 =?utf-8?B?ejV6S2xFNmw5Q3I0dlFxamRSclcvU3NwcWdiekxwYlp4WDhiUTIxYzFhdExx?=
 =?utf-8?B?ZkFUZUlrUENJTlMzYXhFcE90NmRFK1F6OExsVGlCUmNTaGQ3QVBXdW1lVEJO?=
 =?utf-8?B?TEZBSnBpZ3VLYWVDYStjMnZpQmtxVXBzcGJaSjhBUDdTTEFmeTdRaEVEQkYx?=
 =?utf-8?B?Z0psU3VmQXFPMHZYdEdKVDFGeG4ya3BpcnhlMjZXK0pTVmJTaTZ6SmEzODcz?=
 =?utf-8?B?aHhWa1ovcGNsZXZwQnBYcWJFN3pXWGkrZklVcnVhdUIwU1hpUFJpK0FaUjJT?=
 =?utf-8?B?MzcxWllhOVlGN0pmbVFRdlRHdlBXSzVpWTZQUGxlaE94ZVBSdmJNbWRFbU9Q?=
 =?utf-8?B?cEFacitqOE5jWXUzYyt3YStEaFFaMzZIakFjWjk2ZCtCK01HMmhZL3hTWXRx?=
 =?utf-8?B?eEJUTFVJaGw4a1ViWi9qaFpyWHBnRkZ3ZHYxSVZjeHlrUjhOVVRaVXN2eEY1?=
 =?utf-8?B?NUh6K242UUl2UnhKbERXWjdHOGRJYjlacmpockhtcFRJM05KRGRMNXlIaTFv?=
 =?utf-8?B?YTFLS096QWlyb1lOY0pWTjd6TXhQY3QzNFQvb3YrYWR0T2poREtjSHltL1JX?=
 =?utf-8?B?UGxKVjNWdVg5bDhuN3VWWHZRcmZOdGZlUkhCRmhuZWxZdXIrOTRqNCtMUjZG?=
 =?utf-8?B?OEJkWk1UWXNLWVJic29CMG5iS3ZadW9CRGdDNkd3SmVLQ0ljdTVLY2s2WHFG?=
 =?utf-8?B?VDV1KzB5cHJ2UlFYWTdwOU5ZQXFZVnBEYWMwOGthaks4YXNPdnpIN3BIN1c5?=
 =?utf-8?B?eWZ4dVlsK08vMGUvekFvNG5CdmVYdGdacEpNTG4xN2NVTzl3N3lxeVp0akJl?=
 =?utf-8?B?bGdNazduMmFYK0RlMGQ5U01IQ05GRzlvT1pFVWZGeXVPdGpxOVB0aTVTb3ZH?=
 =?utf-8?B?NDl5cnJ3NXhQQU00L0xpZmVDS2JLQUxHbloxeTJzcU5yd3d1WWp3ei9YbFhB?=
 =?utf-8?B?ZVorSjFwb21XKzQxdW9CcFFacmtzYm1TeTNOc3YrMjEyVTd6N1F6VGhGb0pu?=
 =?utf-8?B?R1lFL3VWdU03c010aHNHS2QvUFRLWmR5RnBhY1VTb0FHY1NOS1hSeHY4T1Bl?=
 =?utf-8?B?aUhPTXlhOTA5clEwM01aWEQxTDViMVlUS2p5ZVRQS0MvdzRFSmVBcm16N2c1?=
 =?utf-8?B?TFJEL1VXcC9haEdyVDRYeG9GOEg2T1psenZmalFjK081VTQyUER2ZUZENFQv?=
 =?utf-8?B?WU1tcUw1ZEF0Z2QyNVd2SmN5Q1VxN0d2Q0tqOXc2QW10Wllmdm9IZFVhVmNz?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <115E640D9897A44BB0C6A4FFDAA18A8E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6161.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa7a41b-1de4-4404-5918-08db1a05f2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 03:35:05.2647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nREa5CCtNXj8xjL3VMqbw1/jNFQhnyuC2gEm3ksKxOoRmEo8W15/zlGbxeaQso2y8z2zG0C53q+ZztGuvyOldwcJH/Ynn90v9bRaCGxLA98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5862
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTI4IGF0IDEwOjMxIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAyOCBGZWIgMjAyMyAwNzo0NzowOSArMDAwMCBZYW5jaGFvIFlhbmcgKOadqOW9
pui2hSkgd3JvdGU6DQo+ID4gMS4gV2UgcmVjZWl2ZSBtYW55IGNvbW1lbnRzIGF0IHRoZSBiZWdp
bm5pbmcgb2Ygc2V2ZXJhbCBwYXRjaGVzLg0KPiA+IFRoZXJlDQo+ID4gYXJlIGxpdHRsZSBjb21t
ZW50cyBhYm91dCBvdGhlciBwYXRjaGVzLiBIb3cgYWJvdXQgb3RoZXIgcGF0Y2hlcw0KPiA+IChw
YXRjaA0KPiA+IDJ+cGF0Y2ggMTApPyANCj4gDQo+IEl0J3MgYmVjYXVzZSBwYXRjaGVzIGFyZSB0
b28gbG9uZywgc28gcmV2aWV3ZXJzIGFyZSB1bmxpa2VseSB0bw0KPiBhbGxvY2F0ZSBzdWZmaWNp
ZW50bHkgbG9uZyBibG9jayBvZiB0aW1lIHRvIGxvb2sgdGhydSBhbGwgb2YgDQo+IHRoZSBjb2Rl
IGluIG9uZSBzaXR0aW5nLg0KPiANCkdldCBpdC4gSXTigJlzIGhhcmQgdG8gcmV2aWV3IHRoZSB3
aG9sZSBwYXRjaGVzIGluIG9uZSBzaXR0aW5nLiBTbyBWMyBoYXMNCmJlZW4gcmVkdWNlZCA0aysg
bGluZXMgY29tcGFyZWQgd2l0aCBWMiBhY2NvcmRpbmcgdG8geW91ciBzdWdnZXN0aW9uLg0KRG8g
eW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIG9uIHRoYXQgc2hvdWxkIHdlIHdhaXQgZm9yIGZlZWRi
YWNrIG9uDQpvdGhlciBwYXRjaGVzIG9yIHdoYXQgd2UgY2FuIGRvIHRvIGhlbHAgcmV2aWV3ZXJz
IHRvIHJldmlldyBwYXRjaGVzDQptb3JlIHNtb290aGx5Pw0KQlRXLCB0aGUgcGF0Y2hlcyBhcmUg
cmV2aWV3ZWQgb25lIGJ5IG9uZSAocGF0Y2gxLCBwYXRjaDIsIOKApi4pLCBvciBhcmUNCmNvbnRy
b2xsZWQgYnkgcmV2aWV3ZXJzICh0aGVyZSBpcyBubyBvYnZpb3VzIG9yZGVyIGZvciByZXZpZXdp
bmcgdGhlDQpwYXRjaCk/DQoNCj4gPiAyLiBOZWVkIHdlIGFkZCB5b3VyIG5hbWUgaW4gdGhlIHRh
ZyDigJxSZXZpZXdlZC1ieTog4oCcIG5leHQgdmVyc2lvbj8NCj4gDQo+IE5vLCBubywgZG9uJ3Qg
cHV0IHJldmlldyB0YWdzIG9uIHBhdGNoZXMgdW5sZXNzIGV4cGxpY2l0bHkgYXNrZWQgdG8uDQpH
ZXQgaXQuDQoNCk1hbnkgdGhhbmtzLg0K
