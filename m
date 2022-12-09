Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5104B64812E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLIK4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLIK4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:56:20 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E62C1FCE7;
        Fri,  9 Dec 2022 02:56:12 -0800 (PST)
X-UUID: 32f30606fa994d38afafc973d1ae6d13-20221209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=r42BbLsfg3tGLWgbb+1W+sM1oyb73c0zns/9g1t1Vh0=;
        b=QNEo18Wwh72PClOa+qT5tPWRx9qhSsGZyAwHf/t0ULfomcwGJOop6zMUc8A8i4NHepzjyZthIkMeknlgftiSOm9BWROEHOpCijCgz3FZKnS1AM+eTZW7GozbwwDAonj/0syE0nSDasY++rVvza/AgzFqjqxsvNSb/erSZ4efwDg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:444938f8-b599-4c0e-8a0b-4f013f5b7163,IP:0,U
        RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:2
X-CID-META: VersionHash:dcaaed0,CLOUDID:e25cce24-4387-4253-a41d-4f6f2296b154,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 32f30606fa994d38afafc973d1ae6d13-20221209
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1736634440; Fri, 09 Dec 2022 18:56:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 9 Dec 2022 18:56:03 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 9 Dec 2022 18:56:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcSGqYq8KEafE4TiuneyEDzzddWD1Uy1/ccZ+8IE6o+xSyZyilO1bSOocCmz+YJs/cfc8hFy4KTvhE/Bn7brp3aRn4W60aNtZhnsd1+5qBpJlcnsuO3ISaIzuKjlbD4k5mwecPW9dddVsE8+eo610DLqNyjG4lu0EcgVreeIa5DbfFLT/QC+ao+y8VEsPGWXVVVvOAffEvwlWKu142sUaLcH1vxloN4hLSQR0WXpHyOSolUsIF1ZpJnzz9ODOf9NM4ZuTcm7zNFEmVaqGn464vNFazLCBzi0ul7W7iw9fkwBcZl2gU8e+5j9E5oFwrEFElgeJ8AI3/xQsOjW1gpsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r42BbLsfg3tGLWgbb+1W+sM1oyb73c0zns/9g1t1Vh0=;
 b=Y1nfGOexBD/JbUDI1VMBdMnr6D1WfTzKG2nu1zskyv7jYVB60IEYfwOaZw07W/rOQYo2UF02tluplEPw+80GW9IDjrhw6BErNSdHuB33XWBqidVJc8r+t6qv+iuD7/9FtzgQuQXGVzgrTVWYtXYuWqU5Er6gA82szoeKNvMe4DQJLFFxvHtY9NfsZ0ky2eY8422EYRIgRDyspXAYAvEQISZmPrBo0G4eyeIAHtm03UyDGsKStTk6iSwB+t8wRp0XP1wllj8e7Zf85a/dDA5fUv6/TnIAQ8SbiU4WSkoqBJExlBaeiEnNOOORqYKxXgCrJww4iTic0Co9JhNOqeDplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r42BbLsfg3tGLWgbb+1W+sM1oyb73c0zns/9g1t1Vh0=;
 b=E5Vhy/YRk50zeGUMjBaFf3vaUATeBPFqeIuOMdDcY5DCb1bYqm2zEx6uFDXhBFEWRYSa348ifQ5K+QCxzIy+pqQ7RcqPQuwPXNHpCzjxJW2umoQC/oUwo2v+/vBzdboo8R3DZeJzE41ac/NyX21x70KkOLFUruuu+4a+FFOId18=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SI2PR03MB5913.apcprd03.prod.outlook.com (2603:1096:4:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 10:56:02 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc%7]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 10:56:02 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Topic: [PATCH v3 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Index: AQHZCrW9BCZh9S7ETU2R3v1AiYWaeq5lWPGAgAALRgA=
Date:   Fri, 9 Dec 2022 10:56:02 +0000
Message-ID: <45b4b287dfd57b99e0ba5675bf99194f6d84d9da.camel@mediatek.com>
References: <20221208033148.21866-1-trevor.wu@mediatek.com>
         <20221208033148.21866-11-trevor.wu@mediatek.com>
         <d7d9f3c7-b3e3-1e13-a80f-c7bf7b38a5b1@linaro.org>
In-Reply-To: <d7d9f3c7-b3e3-1e13-a80f-c7bf7b38a5b1@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SI2PR03MB5913:EE_
x-ms-office365-filtering-correlation-id: 8d2cf9d8-d67c-428c-4509-08dad9d3f66a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 429hSpT4pbI2dEjAlSaY0LhY9BRzHiMuL3y1+EqM4xasn1w2sPVxLECAB5oSF+Sgch7xbiBJxsvYpe43M1l+18jTS0Rz/WgKU83hxrRQnQhbHcymjdEWZdvk6KEdlSc7l6YzEEJSqn96tNwZP9/v58ocdb1mNkpF1IdC3OMSe8MIkbqAE0LUI94s6nnLlHNCV/yH4Ks0vDFJ2TTupZcmbBoSuo5Imv7dduo/qcE+edHWb7C2rY3c6Qbv354mGkTYeCgST2tNFH9v9W+pPMEVuG8hHxhgZjLgYUtckqaQ9w8cTSy0NISFl6d/nSRamsvuLGHAkP6OYl2ClZRfsttNckq/H5VjlaOw9xyGVe1IN/JAZBkEYwK0loc8h19Zx3/lg5BxAz+WHKaOJLRH7fmTddFuRgk0iReAAU77ELTjZF8gHYI6M/2XsN8Fc4yEFudftDJDH9gtrsdepuO3mgXr72FSUQ0tDjK6vOoxfGtl8poMdr28OfMsMdEUlF6NRh/TFsuyx3VZp8jRprtP8kVuMln3uqd+CmAtt4QMzBkaUBzVnD5iHKFzNNxEqabQ7n8Ac15NCWZhKg9NGY9FY7bI9h45zWqusnBARuCrRPzkIzmNWYzmBC4DjzaeAQThpbJuaPZfzBHjaK+xuIyAyXjaYrMlIVmwEE3GLiirBIX0jSdU6NT2PDch+tIppmgMuJHUvOKvDgN4ZC2SkW36/UBp4ZAs3QJ5e9rod0ILyw8R3+G5xJq/XUjyEzteM26oq8dMngA+DH98HJVMYYBaRNlsu9hylaaczNmj6CWfe0gADaJvlb1e40K7A1gQ1AxJbRoQjUFfrir41HRFxmZMOWHxh3RRNkNpRc/P0G1PJqIoOscrS8xw2CaPfZqubPT/I9a1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(38070700005)(122000001)(2906002)(53546011)(6506007)(966005)(6486002)(478600001)(86362001)(64756008)(66556008)(66946007)(76116006)(8936002)(66446008)(83380400001)(66476007)(36756003)(85182001)(41300700001)(7416002)(110136005)(5660300002)(4326008)(8676002)(6512007)(38100700002)(54906003)(186003)(71200400001)(316002)(26005)(2616005)(99106002)(414714003)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UENjMXN5SjNQUDZWdlo0V3MwNmg1NWJ3aTJGWElLajQ3UWNONjhQSDFVWjVm?=
 =?utf-8?B?cTVvc3pZUjBNQmZFRElFN1lRRU1LanRQa0Zpc0RZVWRyazZtUVFyWk1hdWU4?=
 =?utf-8?B?WEFxNmtyUUdtZndLMEpIaGRQRnFTNVZyZ21uMnhtUmM0UGRSUDV4UXlHMVdV?=
 =?utf-8?B?NU85L3R6YmpyeU1yM1VuUmRJcWluTkxxUWFPRUwydSsrWE1xUGVibWY4UjNq?=
 =?utf-8?B?REw0WnF5TjhaWDRNNGpWSzJOQlZxRnE1TGQrbHZEU1VteVlhZ0U1cFNnTGVq?=
 =?utf-8?B?QkJaTDc1TWtYekc1SzNFNU5qNEdHbHFZMHk1eDdNWkN5S2FHdG1DZVdKS3pw?=
 =?utf-8?B?dmJMTlM1MlhPNVY5Zk1RVWdyZFdiZ2hDaGVJcDBRWmFmUHhKaldPa3JkcWNS?=
 =?utf-8?B?OEZjeG9zZXRIYVRFbXNxUW5wWExIbDJiUzFBaXFaRkozVEJ5K1B0ZllhSWlP?=
 =?utf-8?B?TDBuRnNTd2N1MnNiV3M5VzdBc0llWHBldTY0dU9Cb3J5VWJOdUFKTWI0Y3Ns?=
 =?utf-8?B?YXhaL2FCTFZqQXdUZThzOWNzbkwrdUdmbDNxZ1JSYzZDSjgvMnVwS0FhSHBG?=
 =?utf-8?B?MW04VVlNeU1YR1hvdHlISDVkeUVOWjd3Ti9HTW9YblBsYnhtZ2h5OHMweHZP?=
 =?utf-8?B?TkJtck9LTm80STgzQlRXRUF0ZUlGcjg3bXIxbmxxcWcvWklacUNvTzJ6TkNS?=
 =?utf-8?B?ZnNIT0FZOEtlZ0NMY05mdnFrOTQxR0xma3NYd3I5SG5PM1ZPYVI3Z0dqR2Iz?=
 =?utf-8?B?N0pMWks4bmdDb05IdXVOR0ZLZ2NwTGI3ODM1TjA5VlljWGxNdExNU1h5WDR5?=
 =?utf-8?B?TnAvMmtKRkdzNUdaTGRSUG45cVd2OU1Xc3hWcTNxdDZjdXJRWENaZEJUMDhI?=
 =?utf-8?B?Rk5rbXRSVVpKeVQ2Q1RDMlJYNVdEbURaVGcramNRYXJWZXN5NE0xakltbnk4?=
 =?utf-8?B?dkEvMFRqaWRhelZKL0VwSWFCZkM5Ui9Iak5yZzF0ZjJpN0lXdUFnUjllclB1?=
 =?utf-8?B?L1JxMWlqWmRZai82VTJBSUxSbUUyeG5sQ1VTOWR2RVYxNGNZR2NROWtrSTNB?=
 =?utf-8?B?YnZQRW8xMU5oQ1RrVTErRWh5OEVLZW00Umx5eHk5dHpVbjNRcTFnNWdJRFVl?=
 =?utf-8?B?Y0ljZDh6V0kwL2lLRDRneFFES2NEcFZRVUhQUGZYcVA1Y3NyT3NTM2wvb3da?=
 =?utf-8?B?VVNhNk9KRURuVk9WeCs5b0lBcVJIaUY5Q0dLc2lRUUpJRGpCM3JGcDNsbGYr?=
 =?utf-8?B?ZW4vNEdUbTVHNnNpREQ0SElYVGo4YmQ1NloxVG5Nb25KN20zRlIvWmhMV0o4?=
 =?utf-8?B?V3paNml1S3B6V0dkRGVyN0ZpNVQ0WUIzUTdJNStuam5lMEcvU3RaVVk2amJG?=
 =?utf-8?B?c0czdysrZ2ZycFhVVWVtbXZvNU91VFV3TE1WR2NmeVVaYlJqQlFTb2lLbjBo?=
 =?utf-8?B?YWZzU052OHU0STZ0aEJXdWs5aHF4RTFKd2hMMlVrRDNtUGRIUVRsUDBTVm1i?=
 =?utf-8?B?UnRBNGlDVHp3U1lsbHVScmV2dGZKMGZRLzA2ZUFBRjdidytTdjc2UTRxU0Q0?=
 =?utf-8?B?a3FTZTJHdlFFNFVIL0pXekRSbXhIRDFGcVdreEtwZXFFaXRRRGYzNk9YTU85?=
 =?utf-8?B?YTdGeDZ5Q3ZEazQyV2c5bVcyV2tzcmI1MjhnSE5zREZNT2MzcWkySThSSHJa?=
 =?utf-8?B?YldMaXRROTNqVVA4aW5sS0E3MzRyOG16VTh6STNGZUFQM2JUdllzZ2RqWTVO?=
 =?utf-8?B?VWFkMm8xRmFUZGtKT2FzVE9GYm1ud1pKdXRtN2NDYnErZ0xEN2VzTGRFRUpW?=
 =?utf-8?B?cnplMlkyRzVxRk54bGdvcHFFb2lOTU1TU0NhN0U0RlE1MVM5ald0SmN1eEFI?=
 =?utf-8?B?R1RZUHNENnd3WlhRQXdNR1M5a0lkNEVPL2VqQ3VzbEFzR25KR2s0UFIzUk5j?=
 =?utf-8?B?UWJyNUdjZmJDcVc1VWl3TUFCTTlFZWRySGliVHd0TDd6V2Y0dDJIRXJkT3VM?=
 =?utf-8?B?SERBVTl5aEZXNHhjLzRUTVhLYW5xRnRDdllVSmFJQnBwOENpYmdrVGd0em5w?=
 =?utf-8?B?QStVUDY4V0dsZjBtRS9Dc3Q2eFhndDIwWmM3eEtaSjRDdFBnb1RXaFVCYXhk?=
 =?utf-8?B?REtQVEdOZjRNN3N5d1ZPUW5ueTJ4V2lrQWJRMU5iTUxGYnVQcERMUTFEU2Jj?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE7E9144C72F1B44A66A0BDB752513DE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2cf9d8-d67c-428c-4509-08dad9d3f66a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 10:56:02.1364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1THp6KfkX7GxmMQUM7PE8And3NNbWjZmHKuFTSTk1QR0szcgR9fnn2lBPejfUUV+ckD+VBeypSIFrlpuHjKaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5913
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTA5IGF0IDExOjE1ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAwOC8xMi8yMDIyIDA0OjMxLCBUcmV2b3IgV3Ugd3JvdGU6DQo+ID4gQWRkIG10
ODE4OCBhdWRpbyBhZmUgZG9jdW1lbnQuDQo+IA0KPiBVc2Ugc3ViamVjdCBwcmVmaXhlcyBtYXRj
aGluZyB0aGUgc3Vic3lzdGVtIChnaXQgbG9nIC0tb25lbGluZSAtLQ0KPiAuLi4pLg0KPiANCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210ODE4OC1hZmUu
eWFtbCB8IDE5Ng0KPiA+ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MTk2IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgxODgtDQo+ID4gYWZlLnlhbWwNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210
ODE4OC0NCj4gPiBhZmUueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC9tdDgxODgtYWZlLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4
IDAwMDAwMDAwMDAwMC4uNmFiMjY0OTRkOTI0DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgxODgtYWZlLnlhbWwN
Cj4gDQo+IA0KPiBUaGlzIGlzIGEgZnJpZW5kbHkgcmVtaW5kZXIgZHVyaW5nIHRoZSByZXZpZXcg
cHJvY2Vzcy4NCj4gDQo+IEl0IHNlZW1zIG15IHByZXZpb3VzIGNvbW1lbnRzIHdlcmUgbm90IGZ1
bGx5IGFkZHJlc3NlZC4gTWF5YmUgbXkNCj4gZmVlZGJhY2sgZ290IGxvc3QgYmV0d2VlbiB0aGUg
cXVvdGVzLCBtYXliZSB5b3UganVzdCBmb3Jnb3QgdG8gYXBwbHkNCj4gaXQuDQo+IFBsZWFzZSBn
byBiYWNrIHRvIHRoZSBwcmV2aW91cyBkaXNjdXNzaW9uIGFuZCBlaXRoZXIgaW1wbGVtZW50IGFs
bA0KPiByZXF1ZXN0ZWQgY2hhbmdlcyBvciBrZWVwIGRpc2N1c3NpbmcgdGhlbS4NCj4gDQo+IFRo
YW5rIHlvdS4NCj4gDQo+IENvbW1lbnQgd2FzIGFib3V0IGZpbGVuYW1lIG1hdGNoaW5nIGNvbXBh
dGlibGUsIHNvIHdpdGggdmVuZG9yDQo+IHByZWZpeC4NCg0KSGkgS3J6eXN6dG9mLA0KDQpUaGFu
a3MgZm9yIHlvdXIgcmV2aWV3IGZpcnN0Lg0KSSBhcGxvZ3lpemUgZm9yIG15IG1pc3VuZGVyc3Rh
bmRpbmcgdG8geW91ciBjb21tZW50Lg0KSSBqdXN0IHJlbmFtZWQgdGhlIGZpbGUgbmFtZShtdDgx
ODgtYWZlLXBjbS55YW1sIC0+IG10ODE4OC1hZmUueWFtbCksDQphbmQgSSBkaWRuJ3Qgbm90aWNl
IHZlbmRvciBwcmVmaXggc2hvdWxkIGJlIGluY2x1ZGVkLg0KSSB3aWxsIGNvcnJlY3QgdGhlIG5h
bWUgaW4gdjQuDQoNCj4gDQo+ID4gQEAgLTAsMCArMSwxOTYgQEANCj4gPiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1M
IDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc291bmQvbXQ4MTg4LWFmZS55YW1sKl9f
O0l3ISFDVFJOS0E5d01nMEFSYncha2lZc2FJWVItS1o5S1RRcTNyT0JScjNHZUlDMlV0bmpGTVdN
S0V4bWRfVjdwVzc1QWFFejMwRHVLdjBuaWZXdE1sa25XOG9zN01pSjJwQ0NWVDdpeFJNc2c3VHBY
dyTCoA0KPiA+ICANCj4gPiArJHNjaGVtYTogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFD
VFJOS0E5d01nMEFSYncha2lZc2FJWVItS1o5S1RRcTNyT0JScjNHZUlDMlV0bmpGTVdNS0V4bWRf
VjdwVzc1QWFFejMwRHVLdjBuaWZXdE1sa25XOG9zN01pSjJwQ0NWVDdpeFJPLTJZcWhGdyTCoA0K
PiA+ICANCj4gPiArDQo+ID4gK3RpdGxlOiBNZWRpYVRlayBBRkUgUENNIGNvbnRyb2xsZXIgZm9y
IG10ODE4OA0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBUcmV2b3IgV3UgPHRy
ZXZvci53dUBtZWRpYXRlay5jb20+DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNv
bXBhdGlibGU6DQo+ID4gKyAgICBjb25zdDogbWVkaWF0ZWssbXQ4MTg4LWFmZQ0KPiA+ICsNCj4g
PiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHRz
Og0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgcmVzZXRzOg0KPiA+ICsgICAg
bWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgcmVzZXQtbmFtZXM6DQo+ID4gKyAgICBjb25zdDog
YXVkaW9zeXMNCj4gPiArDQo+ID4gKyAgbWVkaWF0ZWssdG9wY2tnZW46DQo+ID4gKyAgICAkcmVm
OiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+ID4gKyAgICBkZXNj
cmlwdGlvbjogVGhlIHBoYW5kbGUgb2YgdGhlIG1lZGlhdGVrIHRvcGNrZ2VuIGNvbnRyb2xsZXIN
Cj4gPiArDQo+ID4gKyAgcG93ZXItZG9tYWluczoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4g
Kw0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0
aW9uOiAyNk0gY2xvY2sNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogYXVkaW8gcGxsMSBjbG9j
aw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBhdWRpbyBwbGwyIGNsb2NrDQo+ID4gKyAgICAg
IC0gZGVzY3JpcHRpb246IGNsb2NrIGRpdmlkZXIgZm9yIGkyc2kxX21jaw0KPiA+ICsgICAgICAt
IGRlc2NyaXB0aW9uOiBjbG9jayBkaXZpZGVyIGZvciBpMnNpMl9tY2sNCj4gPiArICAgICAgLSBk
ZXNjcmlwdGlvbjogY2xvY2sgZGl2aWRlciBmb3IgaTJzbzFfbWNrDQo+ID4gKyAgICAgIC0gZGVz
Y3JpcHRpb246IGNsb2NrIGRpdmlkZXIgZm9yIGkyc28yX21jaw0KPiA+ICsgICAgICAtIGRlc2Ny
aXB0aW9uOiBjbG9jayBkaXZpZGVyIGZvciBkcHR4X21jaw0KPiA+ICsgICAgICAtIGRlc2NyaXB0
aW9uOiBhMXN5cyBob3BpbmcgY2xvY2sNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogYXVkaW8g
aW50YnVzIGNsb2NrDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IGF1ZGlvIGhpcmVzIGNsb2Nr
DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IGF1ZGlvIGxvY2FsIGJ1cyBjbG9jaw0KPiA+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBtdXggZm9yIGRwdHhfbWNrDQo+ID4gKyAgICAgIC0gZGVzY3Jp
cHRpb246IG11eCBmb3IgaTJzbzFfbWNrDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IG11eCBm
b3IgaTJzbzJfbWNrDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IG11eCBmb3IgaTJzaTFfbWNr
DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IG11eCBmb3IgaTJzaTJfbWNrDQo+ID4gKyAgICAg
IC0gZGVzY3JpcHRpb246IGF1ZGlvIDI2bSBjbG9jaw0KPiA+ICsNCj4gPiArICBjbG9jay1uYW1l
czoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBjbGsyNm0NCj4gPiArICAg
ICAgLSBjb25zdDogYXBsbDFfY2sNCj4gPiArICAgICAgLSBjb25zdDogYXBsbDJfY2sNCj4gPiAr
ICAgICAgLSBjb25zdDogYXBsbDEyX2RpdjANCj4gPiArICAgICAgLSBjb25zdDogYXBsbDEyX2Rp
djENCj4gPiArICAgICAgLSBjb25zdDogYXBsbDEyX2RpdjINCj4gPiArICAgICAgLSBjb25zdDog
YXBsbDEyX2RpdjMNCj4gPiArICAgICAgLSBjb25zdDogYXBsbDEyX2RpdjkNCj4gPiArICAgICAg
LSBjb25zdDogYTFzeXNfaHBfc2VsDQo+ID4gKyAgICAgIC0gY29uc3Q6IGF1ZF9pbnRidXNfc2Vs
DQo+ID4gKyAgICAgIC0gY29uc3Q6IGF1ZGlvX2hfc2VsDQo+ID4gKyAgICAgIC0gY29uc3Q6IGF1
ZGlvX2xvY2FsX2J1c19zZWwNCj4gPiArICAgICAgLSBjb25zdDogZHB0eF9tX3NlbA0KPiA+ICsg
ICAgICAtIGNvbnN0OiBpMnNvMV9tX3NlbA0KPiA+ICsgICAgICAtIGNvbnN0OiBpMnNvMl9tX3Nl
bA0KPiA+ICsgICAgICAtIGNvbnN0OiBpMnNpMV9tX3NlbA0KPiA+ICsgICAgICAtIGNvbnN0OiBp
MnNpMl9tX3NlbA0KPiA+ICsgICAgICAtIGNvbnN0OiBhZHNwX2F1ZGlvXzI2bQ0KPiA+ICsNCj4g
PiArcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gKyAgIl5tZWRpYXRlayxldGRtLWluWzEtMl0tY2hu
LWRpc2FibGVkJCI6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50OC1hcnJheQ0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArICAgIG1heEl0ZW1z
OiAxNg0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIEJ5IGRlZmF1bHQsIGFsbCBk
YXRhIHJlY2VpdmVkIGZyb20gRVRETSBwaW5zIHdpbGwgYmUNCj4gPiBvdXRwdXRlZCB0bw0KPiA+
ICsgICAgICBtZW1vcnkuIGV0ZG0gaW4gc3VwcG9ydHMgZGlzYWJsZV9vdXQgaW4gZGlyZWN0IG1v
ZGUody9vDQo+ID4gaW50ZXJjb25uKS4NCj4gPiArICAgICAgVXNlciBjYW4gc3BlY2lmeSB0aGUg
Y2hhbm5lbCBJRCB3aGljaCB0aGV5IGhvcGUgZHJvcHBpbmcgYW5kDQo+ID4gdGhlbg0KPiA+ICsg
ICAgICB0aGUgc3BlY2lmaWVkIGNoYW5uZWwgd29uJ3QgYmUgc2VlbiBvbiBtZW1vcnkuDQo+IA0K
PiBTbyB3ZSBrbm93IHdoYXQgYXJlIHRoZSBJRHMgYnV0IGl0J3MgYSBteXN0ZXJ5IHdoYXQgYXJl
IHRoZSB2YWx1ZXMuDQo+IEVzcGVjaWFsbHkgd2l0aCB1bmlxdWUgdmFsdWVzIC0gaG93IGFueSBv
ZiB0aGVzZSBzaG91bGQgY2FzZSB0aGF0DQo+IGNoYW5uZWwgIndvbid0IGJlIHNlZW4gaW4gbWVt
b3J5Ij8NCj4gDQpGb3IgZXhhbXBsZSwNCkZFIGNhbiBzdXBwb3J0IDE0Y2gsIGJ1dCBCRShldGRt
KSBjYW4ndCBzdXBwb3J0IDE0Y2goaXQgY2FuIHN1cHBvcnQNCjE2Y2gpLg0KSW4gdGhlIGNhc2Us
IHdlIGNhbiBjb25maWd1cmUgMTZjaCB0byBldGRtIGFuZCBtYWtlIHVzZSBvZiB0aGUgcHJvcGVy
dHkNCnRvIGRpc2FibGUgdGhlIGxhc3QgdHdvIGNoYW5uZWxzLg0KDQptZWRpYXRlayxldGRtLWlu
MS1jaG4tZGlzYWJsZWQgPSAvYml0cy8gOCA8MHhFIDB4Rj47DQoNCg0KPiA+ICsgICAgdW5pcXVl
SXRlbXM6IHRydWUNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICBtaW5pbXVtOiAwDQo+ID4g
KyAgICAgIG1heGltdW06IDE1DQo+ID4gKw0KPiA+ICsgICJebWVkaWF0ZWssZXRkbS1pblsxLTJd
LW1jbGstYWx3YXlzLW9uLXJhdGUtaHokIjoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBTcGVjaWZ5
IGV0ZG0gaW4gbWNsayBvdXRwdXQgcmF0ZSBmb3IgYWx3YXlzIG9uDQo+ID4gY2FzZS4NCj4gDQo+
IEhvdyBpcyBpdCBkaWZmZXJlbnQgdGhhbiBhc3NpZ25lZC1jbG9jay1yYXRlcz8NCj4gDQpUaGlz
IGluY2x1ZGVzIGNsb2NrIGVuYWJsaW5nIGF0IGluaXQgc3RhZ2UuDQoNCj4gPiArDQo+ID4gKyAg
Il5tZWRpYXRlayxldGRtLW91dFsxLTNdLW1jbGstYWx3YXlzLW9uLXJhdGUtaHokIjoNCj4gPiAr
ICAgIGRlc2NyaXB0aW9uOiBTcGVjaWZ5IGV0ZG0gb3V0IG1jbGsgb3V0cHV0IHJhdGUgZm9yIGFs
d2F5cyBvbg0KPiA+IGNhc2UuDQo+ID4gKw0KPiA+ICsgICJebWVkaWF0ZWssZXRkbS1pblsxLTJd
LW11bHRpLXBpbi1tb2RlJCI6DQo+ID4gKyAgICB0eXBlOiBib29sZWFuDQo+ID4gKyAgICBkZXNj
cmlwdGlvbjogaWYgcHJlc2VudCwgdGhlIGV0ZG0gZGF0YSBtb2RlIGlzIEkyUy4NCj4gPiArDQo+
ID4gKyAgIl5tZWRpYXRlayxldGRtLW91dFsxLTNdLW11bHRpLXBpbi1tb2RlJCI6DQo+ID4gKyAg
ICB0eXBlOiBib29sZWFuDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogaWYgcHJlc2VudCwgdGhlIGV0
ZG0gZGF0YSBtb2RlIGlzIEkyUy4NCj4gPiArDQo+ID4gKyAgIl5tZWRpYXRlayxldGRtLWluWzEt
Ml0tY293b3JrLXNvdXJjZSQiOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMv
ZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgZXRk
bSBtb2R1bGVzIGNhbiBzaGFyZSB0aGUgc2FtZSBleHRlcm5hbCBjbG9jayBwaW4uIFNwZWNpZnkN
Cj4gPiArICAgICAgd2hpY2ggZXRkbSBjbG9jayBzb3VyY2UgaXMgcmVxdWlyZWQgYnkgdGhpcyBl
dGRtIGluIG1vdWR1bGUuDQo+IA0KPiB0eXBvOiBtb2R1bGUNCj4gDQpUaGFua3MsIEkgd2lsbCBj
b3JyZWN0IGl0IGluIHY0Lg0KDQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIDAgIyBldGRt
MV9pbg0KPiA+ICsgICAgICAtIDEgIyBldGRtMl9pbg0KPiA+ICsgICAgICAtIDIgIyBldGRtMV9v
dXQNCj4gDQo+IEkgZG9uJ3QgZ2V0LiBUaGlzIHN1Z2dlc3RzIHRoYXQgZXRkbTFfb3V0IGNhbiBi
ZSBjbG9jayBzb3VyY2Ugb2YNCj4gZXRkbS1pbjEuIE9yIGV0ZG0xX2luIGNhbiBiZSBjbG9jayBz
b3VyY2Ugb2YgZXRkbS1pbjEuLi4gSXQgZG9lcyBub3QNCj4gbWFrZSBzZW5zZS4uLg0KPiANCllv
dSBhcmUgY29ycmVjdC4NCmV0ZG0xX2luIHNob3VsZCBvbmx5IGNob29zZSBvdGhlciBldGRtIGFz
IGl0cyBjbG9jayBzb3VyY2Ugd2hlbiB1c2VyDQpuZWVkcyB0aGlzIHByb3BlcnR5LCBzbyBldGRt
MV9pbiBzaG91bGQgbm90IGJlIGluY2x1ZGVkIGluIHRoZSBlbnVtDQppdGVtcyBmb3IgZXRkbS1p
bjEtY293b3JrLXNvdXJjZS4NCkkgd2lsbCBzZXBhcmF0ZSB0aGVzZSBwcm9wZXJ0aWVzIGluIHY0
Lg0KDQpUaGFua3MsDQpUcmV2b3INCg0KPiA+ICsgICAgICAtIDMgIyBldGRtMl9vdXQNCj4gPiAr
DQo+ID4gKyAgIl5tZWRpYXRlayxldGRtLW91dFsxLTJdLWNvd29yay1zb3VyY2UkIjoNCj4gPiAr
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsg
ICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgZXRkbSBtb2R1bGVzIGNhbiBzaGFyZSB0aGUg
c2FtZSBleHRlcm5hbCBjbG9jayBwaW4uIFNwZWNpZnkNCj4gPiArICAgICAgd2hpY2ggZXRkbSBj
bG9jayBzb3VyY2UgaXMgcmVxdWlyZWQgYnkgdGhpcyBldGRtIG91dA0KPiA+IG1vdWR1bGUuDQo+
ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIDAgIyBldGRtMV9pbg0KPiA+ICsgICAgICAtIDEg
IyBldGRtMl9pbg0KPiA+ICsgICAgICAtIDIgIyBldGRtMV9vdXQNCj4gPiArICAgICAgLSAzICMg
ZXRkbTJfb3V0DQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4g
PiArICAtIHJlZw0KPiA+ICsgIC0gaW50ZXJydXB0cw0KPiA+ICsgIC0gcmVzZXRzDQo+ID4gKyAg
LSByZXNldC1uYW1lcw0KPiA+ICsgIC0gbWVkaWF0ZWssdG9wY2tnZW4NCj4gPiArICAtIHBvd2Vy
LWRvbWFpbnMNCj4gPiArICAtIGNsb2Nrcw0KPiA+ICsgIC0gY2xvY2stbmFtZXMNCj4gPiArDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg==
