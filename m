Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF5B6CD209
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjC2GXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2GXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:23:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0312819C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:23:09 -0700 (PDT)
X-UUID: 283f8a56cdfa11edb6b9f13eb10bd0fe-20230329
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9rYQuFl+YOkJ0v7of9ZGPSy4a3kqQnE2SQ4t/9+aikY=;
        b=BS8K3sZefOvOOXd8WGmjqUpD6h+XmnPl7zt4U7I8ZIOPtxxqMwBQ7+w8+8TMu2qkAQdA2EbFYaJKIcMsHSfMw3mqr3Vp8B3RJ9xK2+z7mxKZZwfSfC1QF7HYEslMTdZTzGehc2ZKIUZibtDbT9lMHXWCO5zpybCjONae+VOtXzk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:6ca98ec4-041b-4a4e-925b-0af3edc2b8b2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-3
X-CID-INFO: VERSION:1.1.22,REQID:6ca98ec4-041b-4a4e-925b-0af3edc2b8b2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-3
X-CID-META: VersionHash:120426c,CLOUDID:bed9d129-564d-42d9-9875-7c868ee415ec,B
        ulkID:230329142305YLMQDPIB,BulkQuantity:0,Recheck:0,SF:38|100|17|19|101|10
        2,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 283f8a56cdfa11edb6b9f13eb10bd0fe-20230329
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <walter.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 284721603; Wed, 29 Mar 2023 14:23:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 29 Mar 2023 14:23:01 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 29 Mar 2023 14:23:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2PJNZ8N/vQ9RwLYWvcAH1LvHno1PIjzjyZVj4DAvXdWt8b4jR3ItXjbWZdRGjLVGj8RWvbJSOoXavfOdgqocYPHAS4gXxeq2zhsOlA4toq9WmeI7AhXv4aIDkFxJLWznPwgb/Qki20tQYFOU3UACWs3vc9vJWCbdF/aY2T3eWfqlTXWaNiKcSPXWk9CDhSRQeGJBqL+rWcRbazjWauSify4QewzNdhDz4Y9Zf1pNe749hyjmZUO68S2VN43Sf55pQgSBTdM6eag1e07Sd7JlYS/lLmEC8Os3O1IjQhpA0eebcv3SWcokElG6yWjBAJyq9ghtup6Pf4MPUBLhI3Wtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rYQuFl+YOkJ0v7of9ZGPSy4a3kqQnE2SQ4t/9+aikY=;
 b=YC+CKkZV4cq+AH2LqFcNf8FabEYDVrg3H+Ct+GMO/GSYHlIEAqtyyvEgYKB4Tk7P79X7U3L+jUAV4qxYGZv4OtqhI3P1pVw/8uHp2mrMTThmE1laS/pL23Re7QQsS9IjeNrMnmAPtJrI+2wWHs2tBsFfzSGezeZt3IHZre7KCd1xN9/c/hRZGTkxkN9XrDAvXdmiVY7GwdSgPOzNJ3En5LTsH74nDPYlAMPjvdmX+5aiYchFTwQrEmu79HTGcTIF3nmUROJBuBk0f/jtyLECr87xOyg6jK3FiVkYxz3TxiyI2WZpAwaFC2KMK7Gmo6upX7zbhpzXhUAKiagt+6g0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rYQuFl+YOkJ0v7of9ZGPSy4a3kqQnE2SQ4t/9+aikY=;
 b=IXleGYUSUskgX1qy/uLVZ1kmdp9OBaM6QtDYMPKWNPkBaVMX9hr7EwoX4Zf2h/Gz8I6KPYXMCAFeIKqC8VVVH18p7tGABmTWjHJ/ZZa9pr8EGJeNe8q0splH3hKtV0Mtr8oUjYChI8E+nkDCWf0Swp82OZ5WohowqEdt0h1v0bI=
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com (2603:1096:820:64::14)
 by PUZPR03MB5991.apcprd03.prod.outlook.com (2603:1096:301:b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 06:22:57 +0000
Received: from KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::3ce5:3d95:f74a:7147]) by KL1PR03MB5777.apcprd03.prod.outlook.com
 ([fe80::3ce5:3d95:f74a:7147%9]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 06:22:57 +0000
From:   =?utf-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= 
        <Walter.Chang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jstultz@google.com" <jstultz@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "macro@orcam.me.uk" <macro@orcam.me.uk>,
        =?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>
Subject: Re: [PATCH v2 4/4] clocksource/drivers/timer-mediatek: Make
 timer-mediatek become loadable module
Thread-Topic: [PATCH v2 4/4] clocksource/drivers/timer-mediatek: Make
 timer-mediatek become loadable module
Thread-Index: AQHZQMKjTTrX4iRFGEiishyu2dRyl67P9KSAgAAJ64CAAANcgIAAFSCAgAFIjgCAABD2AIAAA7SAgEAYA4A=
Date:   Wed, 29 Mar 2023 06:22:57 +0000
Message-ID: <32777456f8e0f98e4cd5b950f421d21f71b149cf.camel@mediatek.com>
References: <20230214105412.5856-1-walter.chang@mediatek.com>
         <20230214105412.5856-5-walter.chang@mediatek.com>
         <20230214222021.k3tsfwezhnh7tdlx@bogus>
         <996b4e61-8486-d939-7367-1240b3c5c5fa@collabora.com>
         <20230215131849.mcgz53jf24atialp@bogus>
         <53f0e612-b5cc-262e-df98-add1e8a06573@collabora.com>
         <20230215144627.ddjc7x365qdnhymi@bogus>
         <7ac030be-8b5e-d190-6676-8cea9cdc1915@collabora.com>
         <96d6f405-22bc-f112-2c88-76da280eed46@gmail.com>
         <26c100f2-bf31-7212-5d13-25b6b14b8f61@collabora.com>
In-Reply-To: <26c100f2-bf31-7212-5d13-25b6b14b8f61@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5777:EE_|PUZPR03MB5991:EE_
x-ms-office365-filtering-correlation-id: 90365dea-850b-4676-bf88-08db301e09be
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /yiv2YXEpj7r38ag0FRfl9VlEcyMSu/iTYS6FxlQB2P2l8Q9nC3wNDZ6ANc28ALo7S8Tbu+ZrOy4obdG4c8wuSHcApe5GIQtta4jqnVhVMCrIjVO51qS7uCcXWtPa8pippY7Qv294g0/cMp7isQGw2BqP6+uXwd+PHIC4mzgWGDmOphx2MuG5/SPlaRHaLg4G1xYihl9fY6EeddCtFlHnO0wnF8D16+xKRz+OYJBoSVXAKIk34eW0d3TjRm43Oc3afDi8NaRgQVfOeD+vHhQG3iWzh2yfEg9ZNhI3tKespA/3oFDLwJ55z3SWH4MXOIby5HBkBwNKolx/Nt78r1UFycLoDwQF+pLW/JvK9NWGSL3RA52HVdd8eca0XsqTUmVNRlr/gBZhCbfOU1uxUM/JVNduPV+4Ke9d3P6Z2s65F1hDSa3pTaIPwSxGVKGDkiRvX/i0mbjQhy89jYXrtDM2E3h53V7BNhw4sMAdp377tvtHRgBPmxZDcNVLo/QyhDvOnjAY+jJmKIrnFMH/3V72BdYfN9WiAkgT6dgRoVVLb66XGcBFGva7K09ktwxJLSBFhcRU/3BKp7lCVhpNK2ig/0ScDccdUKjObtBzjGLeVy84S6yvHQr8+nEVtmtaiSkwuxGnIfbvWnCnxGwJjErrrNwiOKh0I/igttN2BNJJv5qhHqsDCPZQfXNpiceFATH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5777.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(86362001)(110136005)(6506007)(6512007)(38070700005)(41300700001)(7416002)(26005)(316002)(8936002)(478600001)(64756008)(66946007)(54906003)(186003)(107886003)(5660300002)(83380400001)(6486002)(36756003)(71200400001)(66446008)(53546011)(76116006)(38100700002)(8676002)(66476007)(4326008)(2616005)(66556008)(91956017)(122000001)(2906002)(85182001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEVsOXNlNHNDSGdrZlE4YjlhVEhkUnd0SWcyOWtuZjVqSzREblJyckc5NWpF?=
 =?utf-8?B?RVBPTlpzMEdIaUxTcHpuZ2Zja0JEdDNSUGlhQXhoZ0IxL1dXU1Z3MktUTFhZ?=
 =?utf-8?B?bHhWRUdzNFRialc2ajh4dnU2ZmJSZ2ZuNmFPdUhqVjdRYnZJeVpkYnFyTFRo?=
 =?utf-8?B?cTN6aE5hcS9rK0x5Q0RXY20zRGhYUjFBY0NSTGxJS2FTUkNzWkVqTHR4ZkVI?=
 =?utf-8?B?aWMxaU1SZTMrUEw1bGU4N1dIMFA0RDhWSDlEQzM4aUNHQVYrRWtHZ3dxS29E?=
 =?utf-8?B?SnpqR0l5ZXk4ZS9KRFJpajlCdWVuU3cyaXZPdmJiTithWitqaWpoWnAvaGpr?=
 =?utf-8?B?MTVmOEZyUSs3MFEwTkJ2VjJjU0h4MlRMZGhQcjhPanZISTFvMjhzTUd6bzZ6?=
 =?utf-8?B?RWpJQUxMNTdGU1NtY1RNVWNoYU1jOHJjQlRvNndBc1hSVnFMaU5rSTU1bEV5?=
 =?utf-8?B?dU5nOWdRcmxVcXN0Y0lTQkl0TEtyQkR0VG1yYzY5Vkt3YVpFQW1mZFE1Mlp3?=
 =?utf-8?B?MHFFZU03R2M1NXpKbGxlUUtTUnFUV0c0TTI2aXFWQkZvQk1jK2ZwVU5mQVF4?=
 =?utf-8?B?aFd3RlhGcW16VVdqTWJFUVJPTGpyU2tpOXN0dzV6RzQ1dWsxUU5wV2xudXJN?=
 =?utf-8?B?OG85cUlFek90Tjk5Q1FpQmNxd1lodUhhdnA1ZWlvd1U2akFPcTVERHdoVHlj?=
 =?utf-8?B?RHYzeGd5N1M5QmhTV3J4MjlIbWFhNys0MHZKYnJUQ0tZVVZKNzJmM2xDbUQz?=
 =?utf-8?B?QWRSeUdQRGFEamhuOGNVMHhDU2N6ZGxXejNTbE41UGNSVCs0ekJiRkY4SmJJ?=
 =?utf-8?B?TlF5QzZsTVdJTnF5OWN0OHphVTAxMURxZjhZeC9WMjUxSENyY0FjT1dseEQy?=
 =?utf-8?B?cWE5UXgvMmVrSGpuYktPRnNsWjNYRk5uOEVNVjdvSlhYS1cwcEttWHpueEE3?=
 =?utf-8?B?QUJNRy9laXRmY3pWWlZyb0cycWpDc1BraXo5ZWVOM2JscEdwdVVwcE9QS0Iy?=
 =?utf-8?B?UkNiYVZUcGttM0JmcGlwMGwzcVBUQ0VZMEdwblllaWVDR2FENWROUVJESkRF?=
 =?utf-8?B?VzRONm1GdzluelJydTNldWhPMWJrNDEwN1BBOWx4dm8xL01aNzBqM2Zwb25E?=
 =?utf-8?B?UzMrNno3T0hqYVNqVE5oR1ZUa25TK2JYc1IvaUNhSTJZRlRaV0x0QlVmelNT?=
 =?utf-8?B?cXJFaDlBSk9BdGlVcjluZ0gwVkNaaEUxaDV0NGwxUjhzbk5iV25HMHFSWnU1?=
 =?utf-8?B?U2M2SWNiVXFUT2RMa0Izd1JtbWdSdUl5TzkzYjhUZzB3VG04dWpVcitXWHJs?=
 =?utf-8?B?R2h1cDN6NFFMYUYwWkYxNFNEYVFYd2lNdHZWVnpJTHdNWFV1RlhhN2Y4anFS?=
 =?utf-8?B?eVRWc2RsbTZLSmxTeTlCRStNQ0luaWxOOEEwNUttTnRmSVBESjhrbUJWZjlM?=
 =?utf-8?B?eWllbnNPZmxmZmdpeHFOcVNTREJ6a2gxNVF5WHVqMUduaXlDZUNIRTF6WXZY?=
 =?utf-8?B?TWlOdlk4ODc1TlJ5bEdDNWVVaWl2bmRaK3EwVisxUm1ZSnFWS3FqczdxZk1B?=
 =?utf-8?B?UGgwN09TS2lDbDI5di81Y1QxL3dvZzlvUnlFc3Ivd1JhdU50RlB1WWtsNFRQ?=
 =?utf-8?B?cHpDbGVHWmdLQ05pV1dzd3hESndYZThZV2JEajUvbHJMYmhCNCsyME9PckpN?=
 =?utf-8?B?S1FXV1JqalJPckpSdktEVHFZamdCTVJpZ1g1eDF1NkZrQnV0elhjYkNSKy9y?=
 =?utf-8?B?WGtucmowdDBnYzFORDdqc3U1UmlkdFBMdUVQRkV0TVF6NUlQV0NpTlJNd3ph?=
 =?utf-8?B?M0NGZHFmUXJwRmJoclBEUDlyNXlOUVQvTWFDZW5zMmNqeTlkaFJ1NHgvVklv?=
 =?utf-8?B?VEFaRm95OUpaNW8zQk16V2EzazVkUm1HZ2F4aUtCR09OMnZ3QS96a0JxRDVx?=
 =?utf-8?B?MUdEQlZLMDhDcktKV01NbWtzMjI0MHorSUg3dm1xV3hBWUVlaDdqZUZObWhZ?=
 =?utf-8?B?dXI0ZlJGYWlpSWtIRHJEdWxrS0R5S0tGM1JOWklBV2x3K1k3azlKR2t0RGpu?=
 =?utf-8?B?RXpqT01qN3kwd3Z1QkJ3eThCY3ZQOHZ4ZHV6akZnM2xZSTB0QnZpWnN2NWZB?=
 =?utf-8?B?TUt5eXNvUWhhdnVNam9FTm95SzcxWjVuVDI2ZEl2U21NMEFoZHlFVUVDdE83?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0E7EED79B936E4CAD304C5410BC4196@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5777.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90365dea-850b-4676-bf88-08db301e09be
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 06:22:57.3255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqpM9GlH65tbL5Lw3GSLBzv3/RhkcXXx7sVKW5UAjureSRC9YUAqlxFr1sZj9y4+bLkq2tKtz025sPs/dezMb7tCdHLbWHssVJ8t+7x68tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5991
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTE2IGF0IDEyOjM2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTYvMDIvMjMgMTI6MjMsIE1hdHRoaWFzIEJydWdnZXIgaGEgc2Ny
aXR0bzoNCj4gPiANCj4gPiANCj4gPiBPbiAxNi8wMi8yMDIzIDExOjIyLCBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubyB3cm90ZToNCj4gPiA+IElsIDE1LzAyLzIzIDE1OjQ2LCBTdWRlZXAgSG9s
bGEgaGEgc2NyaXR0bzoNCj4gPiA+ID4gT24gV2VkLCBGZWIgMTUsIDIwMjMgYXQgMDI6MzA6NTFQ
TSArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwNCj4gPiA+ID4gUmVnbm8gd3JvdGU6DQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gQm90aC4gSSBtZWFuIHRoYXQgdGhlc2UgcGxhdGZvcm1zIGRvIGhh
dmUgYXJjaGl0ZWN0ZWQgdGltZXJzLA0KPiA+ID4gPiA+IGJ1dCB0aGV5IGFyZSBzdG9wcGVkDQo+
ID4gPiA+ID4gYmVmb3JlIHRoZSBib290bG9hZGVyIGp1bXBzIHRvIHRoZSBrZXJuZWwsIG9yIHRo
ZXkgYXJlIG5ldmVyDQo+ID4gPiA+ID4gc3RhcnRlZCBhdCBhbGwuDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gUGxlYXNlIHJlZmVyIHRvOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0L2RyaXZlcnMvY2xvY2tzb3VyY2Uv
dGltZXItbWVkaWF0ZWsuYz9oPW5leHQtMjAyMzAyMTUmaWQ9MzI3ZTkzY2Y5YTU5YjBkMDRlYjNh
MzFhN2ZkYmYwZjExY2YxM2VjYl9fOyEhQ1RSTktBOXdNZzBBUmJ3IWpPWDA0VFFuMUhYY0tPZHpB
aUszWmxxc1NFM2ozcDZaby1DYWpyMGtoWEM5QU5sYmtsOGtRclVneDZ3YWRSOGJfNDZvOUowU2JK
Z2pob1MwM3JRN3NvbUpmQTVaOUw2R19nJMKgDQo+ID4gPiA+ID4gIA0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IEZvciBhIG5pY2UgZXhwbGFuYXRpb24uDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+
ID4gPiBUaGFua3MgZm9yIHRoYXQuIFdlbGwgdGhlbiBJIHNlZSBubyBwb2ludCBpbiBtYWtpbmcg
dGhlc2UNCj4gPiA+ID4gbW9kdWxlcyBpZiB5b3UNCj4gPiA+ID4gY2FuJ3QgaGF2ZSBnZW5lcmlj
IEltYWdlIHRoYXQgYm9vdHMgb24gYWxsIHRoZSBwbGF0Zm9ybS4gSSBub3cNCj4gPiA+ID4gdGVu
ZCB0byB0aGluaw0KPiA+ID4gPiB0aGF0IHRoZXNlIGFyZSBtYWRlIG1vZHVsZXMganVzdCBiZWNh
dXNlIEdLSSBkZW1hbmRzIGFuZCBpdA0KPiA+ID4gPiAqbWlnaHQqIHdvcmsNCj4gPiA+ID4gb24g
b25lIG9yIDIgcGxhdGZvcm1zLiBPbmUgd2UgbW92ZSB0aGlzIGFzIG1vZHVsZXMsIGhvdyB3aWxs
IGJlDQo+ID4gPiA+IGtub3cgdGhlDQo+ID4gPiA+IEltYWdlIHdpdGhvdXQgdGhlc2UgdGltZXJz
IG9yIHdpdGggdGhlbSBidWlsdCBhcyBtb2R1bGVzIHdpbGwNCj4gPiA+ID4gYm9vdCBvciBub3QN
Cj4gPiA+ID4gb24gYSBnaXZlbiBtZWRpYXRlayBwbGF0Zm9ybS4gU29ycnksIEkgaW5pdGlhbGx5
IHNhdyBzb21lIHBvaW50DQo+ID4gPiA+IGluIG1ha2luZw0KPiA+ID4gPiB0aGVzZSB0aW1lcnMg
YXMgbW9kdWxlcyBidXQgaWYgdGhleSBhcmUgcmVxdWlyZWQgZm9yIGJvb3Qgb24NCj4gPiA+ID4g
c29tZSBzeXN0ZW1zDQo+ID4gPiA+IHRoZW4gSSBzZWUgbm8gcG9pbnQuIFNvIGlmIHRoYXQgaXMg
dGhlIGNhc2UsIE5BQ0sgZm9yIHRoZXNlIGFzDQo+ID4gPiA+IGl0IGp1c3QNCj4gPiA+ID4gY3Jl
YXRlcyBtb3JlIGNvbmZ1c2lvbiBhZnRlciB0aGVzZSBhcmUgbWVyZ2VkIGFzIHdoeSBzb21lDQo+
ID4gPiA+IEltYWdlcyBvcg0KPiA+ID4gPiBldmVuIHdoeSBkZWZjb25maWcgaW1hZ2UoaWYgd2Ug
cHVzaCB0aGUgY29uZmlnIGNoYW5nZSBhcyB3ZWxsKQ0KPiA+ID4gPiBpcyBub3QNCj4gPiA+ID4g
Ym9vdGluZyBvbiB0aGVzZSBwbGF0Zm9ybXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBJdCBpcyBubyBs
b25nZXIganVzdCBmb3Igc3lzdGVtIHRpbWVyIHVzZWZ1bCBpbiBsb3cgcG93ZXIgQ1BVDQo+ID4g
PiA+IGlkbGUgc3RhdGVzDQo+ID4gPiA+IGFzIEkgaW5pdGlhbCB0aG91Z2h0Lg0KPiA+ID4gPiAN
Cj4gPiA+IA0KPiA+ID4gSSB0aGluayB0aGF0IHRoZXJlIGlzIHN0aWxsIGEgcG9pbnQgaW4gbW9k
dWxhcml6YXRpb24gZm9yIHRoaXMNCj4gPiA+IGRyaXZlciBhbmQgSQ0KPiA+ID4gY2FuIHByb3Bv
c2UgYSByYXRoZXIgc2ltcGxlIHNvbHV0aW9uLCBldmVuIHRob3VnaCB0aGlzIG1heSBhZGQNCj4g
PiA+IHNvbWUsIHJhdGhlcg0KPiA+ID4gbGl0dGxlLCBjb2RlIGR1cGxpY2F0aW9uIHRvIHRoZSBt
aXguDQo+ID4gPiANCj4gPiA+IFRoZSBwbGF0Zm9ybXMgdGhhdCBJJ3ZlIGRlc2NyaWJlZCAobGlr
ZSBtdDY3OTUpIG5lZWQgdGhlIHN5c3RlbQ0KPiA+ID4gdGltZXIgdG8gYmUNCj4gPiA+IGluaXRp
YWxpemVkIGFzIGVhcmx5IGFzIHBvc3NpYmxlIC0gdGhhdCdzIHRydWUgLSBidXQgdGhhdCB0aW1l
cg0KPiA+ID4gaXMgYWx3YXlzDQo+ID4gPiAiQ1BVWEdQVCIuDQo+ID4gPiANCj4gPiA+IE9uIHRo
b3NlIHBsYXRmb3JtcywgeW91ICpzdGlsbCogaGF2ZSBtdWx0aXBsZSB0aW1lcnM6DQo+ID4gPiAg
IC0gQ1BVWCAoc2hvcnQgZm9yIGNwdXhncHQpLCB1c2VkIG9ubHkgYXMgc3lzdGVtIHRpbWVyOw0K
PiA+ID4gICAtIFNZU1QsIGFzIGFub3RoZXIgc3lzdGVtIHRpbWVyIGltcGxlbWVudGF0aW9uIChh
ZGRpdGlvbmFsDQo+ID4gPiB0aW1lcnMpIGJ1dA0KPiA+ID4gICAgIHRob3NlIGFyZSBhbHdheXMg
aW5pdGlhbGl6ZWQgKEFGQUlLKSBmcm9tIHRoZSBib290bG9hZGVyDQo+ID4gPiBiZWZvcmUgYm9v
dGluZzsNCj4gPiA+ICAgLSBHUFQgKEdlbmVyYWwgUHVycG9zZSBUaW1lcikuDQo+ID4gPiANCj4g
PiA+IE9uIG9uZSBTb0MsIHlvdSBtYXkgaGF2ZToNCj4gPiA+ICAgLSBDUFVYICphbmQqIFNZU1QN
Cj4gPiA+ICAgLSBDUFVYICphbmQqIEdQVA0KPiA+ID4gICAtIENQVVggKmFuZCogU1lTVCAqYW5k
KiBHUFQNCj4gPiA+IA0KPiA+ID4gLi4uIHdoZXJlIHRoZSBvbmx5IG9uZSB0aGF0IGlzIGJvb3Qg
Y3JpdGljYWwgYW5kIG5lZWRzIHRvIGJlDQo+ID4gPiBpbml0aWFsaXplZCBlYXJseQ0KPiA+ID4g
aXMgYWx3YXlzIG9ubHkgQ1BVWC4NCj4gPiA+IA0KPiA+ID4gSGVuY2UgdGhpcyBwcm9wb3NhbDog
dG8gc3RpbGwgYWxsb3cgbW9kdWxhcml6YXRpb24gb2YgdGltZXJzIG9uDQo+ID4gPiBNZWRpYVRl
ayBwbGF0Zm9ybXMsDQo+ID4gPiB3ZSBjb3VsZCBldmVudHVhbGx5IHNwbGl0IHRoZSBDUFVYIGFz
IGEgc2VwYXJhdGVkIGRyaXZlciB0aGF0DQo+ID4gPiAqY2Fubm90IGJlKiwgZHVlIHRvDQo+ID4g
PiB0aGUgcHJldmlvdXNseSBleHBsYWluZWQgY29uc3RyYWludHMsIGNvbXBpbGVkIGFzIG1vZHVs
ZSwgaGVuY2UNCj4gPiA+IGFsd2F5cyBidWlsdC1pbiwNCj4gPiA+IGZyb20gYSB0aW1lci1tZWRp
YXRlayBkcml2ZXIgdGhhdCBjb3VsZCBiZSBhIG1vZHVsZSBhbmQgY2FwYWJsZQ0KPiA+ID4gb2Yg
aGFuZGxpbmcgb25seQ0KPiA+ID4gU1lTVCBhbmQgR1BUIHRpbWVycy4NCj4gPiA+IA0KPiA+ID4g
SW4gdGhhdCBjYXNlLCB3ZSdkIGhlbmNlIGhhdmUuLi4NCj4gPiA+ICAgLSB0aW1lci1tZWRpYXRl
ay1jcHV4Lm8gKGJvb2wpDQo+ID4gPiAgIC0gdGltZXItbWVkaWF0ZWsuYyAodHJpc3RhdGUpDQo+
ID4gPiANCj4gPiA+IENvdW50aW5nIHRoYXQgdGhlIENQVVggdGltZXJzIGFyZSBhY3R1YWxseSBl
dmVuIHVzaW5nIGRpZmZlcmVudA0KPiA+ID4gYHRpY2tfcmVzdW1lYA0KPiA+ID4gYW5kIGBzZXRf
c3RhdGVfc2h1dGRvd25gIGNhbGxiYWNrcyAoZG9pbmcgb25seSBhIElSUQ0KPiA+ID4gY2xlYXIv
cmVzdG9yZSBhbmQgbm90aGluZw0KPiA+ID4gZWxzZSksIHRoZSBhbW91bnQgb2YgZHVwbGljYXRp
b24gd291bGQgYmUgLi4gd2VsbCwgYWdhaW4sDQo+ID4gPiBtaW5pbWFsLCBidXQgdGhlbg0KPiA+
ID4gdGhpcyBtZWFucyB0aGF0IHRpbWVyLW1lZGlhdGVrLWNwdXggd291bGQgYmUgYGRlZmF1bHQg
eSBpZg0KPiA+ID4gQVJDSF9NRURJQVRFS2AsIG9yDQo+ID4gPiBldmVuIHNlbGVjdGVkIGJ5IEFS
Q0hfTUVESUFURUsgaXRzZWxmLg0KPiA+ID4gDQo+ID4gPiBJZiB5b3UgdGhpbmsgdGhhdCB0aGlz
IGNvdWxkIGJlIGEgZ29vZCBzb2x1dGlvbiwgSSBjYW4gc2VuZCBhDQo+ID4gPiAiZmFzdCIgcGF0
Y2ggdG8NCj4gPiA+IHNwbGl0IGl0IG91dCwgcHJlcGFyaW5nIHRoZSBncm91bmQgZm9yIHRoZSBw
ZW9wbGUgZG9pbmcgdGhpcw0KPiA+ID4gbW9kdWxlIHdvcmsuDQo+ID4gPiANCj4gPiA+IEFueSBj
b25zaWRlcmF0aW9ucz8NCj4gPiA+IA0KPiA+IA0KPiA+IEkgdGhpbmsgeW91ciBwcm9wb3NhbCBz
b3VuZHMgYWNjZXB0YWJsZSwgYnV0IHdlIHdvdWxkIG5lZWQgdG8gbWFrZQ0KPiA+IHN1cmUgdGhh
dCBhbGwgDQo+ID4gU29DcyBjYW4gYm9vdCB3aXRoIHRoZSBDUFVYIGRyaXZlci4gSSdtIGF3YXJl
IG9mIHNvbWUgYXJtdjcgU29Dcw0KPiA+IHRoYXQgdXNlIGEga2luZCBvZiANCj4gPiBoYWNrIHRv
IGVuYWJsZSB0aGUgYXJjaGl0ZWN0dXJlIHRpbWVyIFsxXS4gVGhpcywgZm9yIG9uZSBwYXJ0LA0K
PiA+IHNob3VsZCBiZSBtb3ZlZCB0byANCj4gPiBDUFVYLCBpZiBwb3NzaWJsZS4gRm9yIHRoZSBv
dGhlciBwYXJ0IGl0IG1ha2VzIG1lIHdvbmRlciBpZiByZWFsbHkNCj4gPiBhbGwgc3VwcG9ydGVk
IA0KPiA+IE1lZGlhVGVrIHBsYXRmb3JtcyB3aWxsIGJvb3Qgd2l0aCBTWVNUL0dQVCBiZWluZyBh
IG1vZHVsZS4gSSB0aGluaw0KPiA+IHdlIHdpbGwgbmVlZCANCj4gPiBzb21lIGVmZm9ydCBmcm9t
IHRoZSBjb21tdW5pdHkgdG8gdGVzdCB0aGF0Lg0KPiA+IA0KPiA+IFNvIGFzIGEgcmVzdW1lLCB5
ZXMgSSB0aGluayB5b3VyIGFwcHJvYWNoIGlzIGZlYXNpYmxlIGJ1dCB3ZSBzaG91bGQNCj4gPiBj
b2xsZWN0IA0KPiA+IHRlc3RlZC1ieSB0YWdzIGJlZm9yZSBtZXJnaW5nIGl0Lg0KPiA+IA0KPiA+
IFJlZ2FyZHMsDQo+ID4gTWF0dGhpYXMNCj4gPiANCj4gPiANCj4gPiBbMV0gDQo+ID4gDQpodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvYXJjaC9hcm0vbWFjaC1tZWRp
YXRlay9tZWRpYXRlay5jP2g9djYuMi1yYzgqbjE2X187SXchIUNUUk5LQTl3TWcwQVJidyFqT1gw
NFRRbjFIWGNLT2R6QWlLM1pscXNTRTNqM3A2Wm8tQ2FqcjBraFhDOUFObGJrbDhrUXJVZ3g2d2Fk
UjhiXzQ2bzlKMFNiSmdqaG9TMDNyUTdzb21KZkE1bW5DUTZGdyTCoA0KPiA+ICANCj4gDQo+IFJp
Z2h0LiBJIGNvbXBsZXRlbHkgZm9yZ290IGFib3V0IHRob3NlIHBsYXRmb3JtcywgZXZlbiB0aG91
Z2ggbXkNCj4gaW50ZW50aW9uIHdhcw0KPiB0byBhY3R1YWxseSB0cnkgYW5kIG1pZ3JhdGUgdGhl
bSBvbmNlIHRoZSBDUFVYIHdhcyBwaWNrZWQuIE15IGJhZC4NCj4gDQo+IFdlbGwsIEkgdGhpbmsg
dGhhdCB0aGlzIG1vZHVsZSBjb252ZXJzaW9uIHdpbGwgdGFrZSBxdWl0ZSBhIHdoaWxlLCBzbw0K
PiB0aGVyZQ0KPiBzaG91bGQgYmUgbm8gbmVlZCB0byBydXNoLi4uIEknbGwgc2VuZCBhIHNlcmll
cyBsYXRlciB3aXRoIHRoZSBzcGxpdA0KPiAqYW5kKiBhDQo+IGNvbnZlcnNpb24gb2YgdGhvc2Ug
cGxhdGZvcm1zLCBzbyB0aGF0IHdlIHdpbGwgc2VlIGEgcmVtb3ZhbCBvZiB0aGF0DQo+IG1lZGlh
dGVrX3RpbWVyX2luaXQoKSBmdW5jdGlvbi4NCj4gDQo+IFNvbWUgZW5jb3VyYWdpbmcgd29yZHMg
YWhlYWQ6IEknbSB0b3RhbGx5IGNvbmZpZGVudCB0aGF0IHRoZQ0KPiBjb252ZXJzaW9uIHdpbGwN
Cj4gSnVzdCBXb3JrLCBiZWNhdXNlIHRoZSBNVDY3OTUgU29DIGhhZCB0aGUgc2FtZSBoYW5kbGlu
ZyBmb3IgQ1BVWEdQVA0KPiBhcyB0aGUNCj4gb2xkZXIgTVQ2NTg5Lzc2MjMvODEyNy84MTM1Li4u
IGFzIHRoYXQgU29DIGhhZCB0d28gaW1wbGVtZW50YXRpb25zDQo+IGluaXRpYWxseSwNCj4gb25l
IGFzIEFSTSwgb25lIGFzIEFSTTY0Lg0KPiANCj4gV2hhdGV2ZXIgLSBsZXQncyBzZWUgd2hhdCBJ
IGNhbiBjb21lIHVwIHdpdGgsIHRoZW4uDQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KDQpGaXJz
dCwgSSdkIGxpa2UgdG8gdGhhbmsgQW5nZWxvIGZvciBhc3Npc3RpbmcgdXMgaW4gc3BsaXRpbmcg
b3V0IHRoZQ0KQ1BVWCBkcml2ZXIgWzFdLCBhbGxvd2luZyB0aGlzIGRyaXZlciB0byBiZWNvbWUg
YSBtb2R1bGUgdGhhdCBjYW4gYmUNCmxvYWRlZCB3aGVuIG5lZWRlZC4NCg0KSW4gcmVzcG9uc2Ug
dG8gTWF0dGhpYXMncyBjb25jZXJuIGFib3V0IHdoZXRoZXIgU1lTVC9HUFQgb24gdGhlIG9sZA0K
TWVkaWFUZWsgcGxhdGZvcm1zIGNhbiBib290IHByb3Blcmx5IHdpdGggdGhlIGxvYWRhYmxlIG1v
ZHVsZSwgSQ0KcmVjZW50bHkgY29uZHVjdGVkIGEgZmV3IHRlc3RzIGFuZCBmb3VuZCB0aGF0IGJv
dGggaGFyZHdhcmVzIGFyZQ0KY2FwYWJsZSBvZiBib290aW5nIG5vcm1hbGx5IHdpdGggdGhpcyBs
b2FkYWJsZSBtb2R1bGUuDQoNCkZvciBteSBleHBlcmltZW50cywgSSB1c2VkIE1UNjc2OCB3aXRo
IHRoaXMgcGF0Y2g6DQoNCjEuIFdoZW4gdGhlIG1vZHVsZSB3YXMgbm90IGxvYWRlZCBvciBsb2Fk
IHRoZSBtb2R1bGUgYnV0IHRoZQ0KY29ycmVzcG9uZGluZyBjb21wYXRpYmxlIHByb3BlcnR5IHdh
cyBub3Qgc3BlY2lmaWVkIGluIHRoZSBkdHMsIHRoZQ0KZm9sbG93aW5nIHJlc3VsdHMgd2VyZSBv
YnRhaW5lZDoNCg0KIyBjYXQgL3Byb2MvdGltZXJfbGlzdCB8IGdyZXAgIkJyb2FkY2FzdCBkZXZp
Y2UiIC1BIDE1DQpCcm9hZGNhc3QgZGV2aWNlDQpDbG9jayBFdmVudCBEZXZpY2U6IGJjX2hydGlt
ZXINCiBtYXhfZGVsdGFfbnM6ICAgOTIyMzM3MjAzNjg1NDc3NTgwNw0KIG1pbl9kZWx0YV9uczog
ICAxDQogbXVsdDogICAgICAgICAgIDENCiBzaGlmdDogICAgICAgICAgMA0KIG1vZGU6ICAgICAg
ICAgICAzDQogbmV4dF9ldmVudDogICAgIDQ5MDIwNDAwMDAwMCBuc2Vjcw0KIHNldF9uZXh0X2V2
ZW50OiA8MDAwMDAwMDAwMDAwMDAwMD4NCiBzaHV0ZG93bjogYmNfc2h1dGRvd24uY2ZpX2p0DQog
ZXZlbnRfaGFuZGxlcjogIHRpY2tfaGFuZGxlX29uZXNob3RfYnJvYWRjYXN0LmNmaV9qdA0KIHJl
dHJpZXM6ICAgICAgICAwDQoNCnRpY2tfYnJvYWRjYXN0X21hc2s6IGZmDQp0aWNrX2Jyb2FkY2Fz
dF9vbmVzaG90X21hc2s6IDdlDQoNClRoZSBidWlsdC1pbiBgYmNfaHJ0aW1lcmAgd2FzIHVzZWQg
YXMgdGhlIGJyb2FkY2FzdCBkZXZpY2UsIHdoZXJlYnkgb25lDQpDUFUgd2FzIGtlcHQgYXdha2Ug
dG8gd2FrZSB1cCB0aGUgb3RoZXIgQ1BVcy4gQXMgYSByZXN1bHQsIG9uZSBDUFUNCmNvdWxkIG5v
dCBlbnRlciB0aGUgaWRsZSBzdGF0ZS4NCg0KMi4gV2hlbiB0aGUgbW9kdWxlIHdhcyBsb2FkZWQg
YW5kIHRoZSBHUFQgY29tcGF0aWJsZSBwcm9wZXJ0eSB3YXMNCnNwZWNpZmllZCBpbiB0aGUgZHRz
Og0KDQojIGNhdCAvcHJvYy90aW1lcl9saXN0IHwgZ3JlcCAiQnJvYWRjYXN0IGRldmljZSIgLUEg
MTcNCkJyb2FkY2FzdCBkZXZpY2UNCkNsb2NrIEV2ZW50IERldmljZTogbXRrLWNsa2V2dA0KIG1h
eF9kZWx0YV9uczogICAzMzAzODIxMDQ2MzQNCiBtaW5fZGVsdGFfbnM6ICAgMTAwMA0KIG11bHQ6
ICAgICAgICAgICAyNzkxNzI4Nw0KIHNoaWZ0OiAgICAgICAgICAzMQ0KIG1vZGU6ICAgICAgICAg
ICAzDQogbmV4dF9ldmVudDogICAgIDE0ODMyMjEwMTY0NjIgbnNlY3MNCiBzZXRfbmV4dF9ldmVu
dDogbXRrX2dwdF9jbGtldnRfbmV4dF9ldmVudC5jZmlfanQNCiBzaHV0ZG93bjogbXRrX2dwdF9j
bGtldnRfc2h1dGRvd24uY2ZpX2p0DQogcGVyaW9kaWM6IG10a19ncHRfY2xrZXZ0X3NldF9wZXJp
b2RpYy5jZmlfanQNCiBvbmVzaG90OiAgbXRrX2dwdF9jbGtldnRfc2h1dGRvd24uY2ZpX2p0DQog
cmVzdW1lOiAgIG10a19ncHRfY2xrZXZ0X3NodXRkb3duLmNmaV9qdA0KIGV2ZW50X2hhbmRsZXI6
ICB0aWNrX2hhbmRsZV9vbmVzaG90X2Jyb2FkY2FzdC5jZmlfanQNCiByZXRyaWVzOiAgICAgICAg
MTcNCg0KdGlja19icm9hZGNhc3RfbWFzazogZmYNCnRpY2tfYnJvYWRjYXN0X29uZXNob3RfbWFz
azogYmYNCg0KMy4gV2hlbiB0aGUgbW9kdWxlIHdhcyBsb2FkZWQgYW5kIHRoZSBTWVNUIGNvbXBh
dGlibGUgcHJvcGVydHkgd2FzDQpzcGVjaWZpZWQgaW4gdGhlIGR0czoNCg0KIyBjYXQgL3Byb2Mv
dGltZXJfbGlzdCB8IGdyZXAgIkJyb2FkY2FzdCBkZXZpY2UiIC1BIDE3DQpCcm9hZGNhc3QgZGV2
aWNlDQpDbG9jayBFdmVudCBEZXZpY2U6IG10ay1jbGtldnQNCiBtYXhfZGVsdGFfbnM6ICAgMzMw
MzgyMTA0NjM0DQogbWluX2RlbHRhX25zOiAgIDEwMDANCiBtdWx0OiAgICAgICAgICAgMjc5MTcy
ODcNCiBzaGlmdDogICAgICAgICAgMzENCiBtb2RlOiAgICAgICAgICAgMw0KIG5leHRfZXZlbnQ6
ICAgICAxMzIyNTIwMDAwMDAgbnNlY3MNCiBzZXRfbmV4dF9ldmVudDogbXRrX3N5c3RfY2xrZXZ0
X25leHRfZXZlbnQuY2ZpX2p0DQogc2h1dGRvd246IG10a19zeXN0X2Nsa2V2dF9zaHV0ZG93bi5j
ZmlfanQNCiBvbmVzaG90OiAgbXRrX3N5c3RfY2xrZXZ0X29uZXNob3QuY2ZpX2p0DQogcmVzdW1l
OiAgIG10a19zeXN0X2Nsa2V2dF9yZXN1bWUuY2ZpX2p0DQogZXZlbnRfaGFuZGxlcjogIHRpY2tf
aGFuZGxlX29uZXNob3RfYnJvYWRjYXN0LmNmaV9qdA0KIHJldHJpZXM6ICAgICAgICA4DQoNCnRp
Y2tfYnJvYWRjYXN0X21hc2s6IGZmDQp0aWNrX2Jyb2FkY2FzdF9vbmVzaG90X21hc2s6IDNmDQoN
ClRoZXNlIHR3byBleHBlcmltZW50cyBzaG93IHRoYXQgU1lTVC9HUFQgb24gdGhlIG9sZCBNZWRp
YVRlayBwbGF0Zm9ybXMNCmNhbiBhbHNvIHdvcmsgcHJvcGVybHkgd2l0aCB0aGUgbG9hZGFibGUg
bW9kdWxlLCBhbmQgd2lsbCBub3QgY2F1c2UgYW55DQpib290aW5nIGlzc3Vlcy4gVGhlcmVmb3Jl
LCBtYWtpbmcgdGltZXItbWVkaWF0ZWsuYyBkcml2ZXIgaW50byBhDQpsb2FkYWJsZSBtb2R1bGUg
aXMgZmVhc2libGUuDQoNClRoYW5rcywNCldhbHRlciBDaGFuZw0KDQpbMV0gDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzIwMjMwMzA5MTAzOTEzLjExNjc3NS0xLWFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbS8NCg==
