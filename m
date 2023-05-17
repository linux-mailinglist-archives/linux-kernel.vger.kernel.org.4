Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A30F706382
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjEQJDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjEQJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:03:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FFE5BA0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:02:53 -0700 (PDT)
X-UUID: 973023eaf49111ed9cb5633481061a41-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jIc1neszIeaPa1MPjK3RM22lq6IwuJ3a2kEfNRgPUpU=;
        b=T/0gIfs4vIAbGeH9UeiN8m/UYxjBvBiQ4yEjtBPYTPYPxVFtjfzvWdJpYTxxZlq8DYb+q9xnaBl5jWjKkmH/++jI66vWd+B+yEf4cXZ51j5TB8A0Va7X7jjzJoD/kARwmkelmtpHoUfNuMCLJxLjvzV5g1hJT01rhuJv3rRBlxw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:364ceb7f-bf71-41ea-99ef-16730970369e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:28,RULE:Release_Ham,ACTION
        :release,TS:29
X-CID-INFO: VERSION:1.1.25,REQID:364ceb7f-bf71-41ea-99ef-16730970369e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:28,RULE:Release_Ham,ACTION:r
        elease,TS:29
X-CID-META: VersionHash:d5b0ae3,CLOUDID:f81d753b-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:2305171535032EXZ4TPH,BulkQuantity:18,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 973023eaf49111ed9cb5633481061a41-20230517
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <xiaoming.ding@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 908328781; Wed, 17 May 2023 17:02:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 17:02:45 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 17:02:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+zyWLLyxVb5Yk9I8XFVxv4+bxTvTLKia/vQR2NmnSKHmr3bPWoJaJYaVJusIXLZV4Z808Y25hAOjKxFsTbe7vs3g8Zuj07N0aKU5g5jhiUvAUXJ979ftkjDmb3sorYvsMcNKGeSb+5cMK85/av8fUQFUjuS6rkEl2r7yroOz4vDhJB6wJkl+FGH1Ico9tyEKl7SCKyoNYp+ubiSeWt+m+X+RF0203J9FQI+ZfKSaSCeZS48f4XHcFgGjXnWvhdZ1IkxbSP5eGTFixx3dji8g4WLrDLj2/bXrlldZUd1lrchOgtyvdJ6WrPFDwo1R0cr+tjgkjtZOok+n1WqtQlPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIc1neszIeaPa1MPjK3RM22lq6IwuJ3a2kEfNRgPUpU=;
 b=FwUASZ5hj/YzpxtUOoAnmOly1p8ZeUuImApXfL65lPFYFVDTIVFMLsDUMVn7++vHbP7H+ngc/7LwO2P21iPcrVXckhOsWkJm7Wvg0C4nD6vvEBDn4DI1mqAonj3S7MQYKM0xx/OmwGNiFf1cJrTiAtS4eNxPoLMcFovZr7Pp25sbUnZG9O6UYkOZv87gInRx6BZhV3dxk/CLLxGFSgJZs7hzRutd8y9VOE5IZ20luJltnFisph5Y9Asg8YFnF9lMpT63e0u0YV/eEzh8jwmp0K9orm2WkVYkRYh4bC0Sh4llUjtarDOgmTuOyzpSdA2CspCSwFJNwRIIbrX8JJ5HFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIc1neszIeaPa1MPjK3RM22lq6IwuJ3a2kEfNRgPUpU=;
 b=KPK9H2I3+SOkyVDVya0VUHHsd40jEO8rcR4ov+x3Q7Mw7lGT6TCajaplxuHTtxifzTTUWBTyLlMR2rZU4Afg/RPPFb/xy0qyf39Ea/iDwfKmHkhtUFdytwWASFm+Gam7CRiVDWBZh2UTqyD+7/EjrGLIQnVqiKmGK4XmUTWlePI=
Received: from SI2PR03MB5369.apcprd03.prod.outlook.com (2603:1096:4:10a::14)
 by SEZPR03MB7442.apcprd03.prod.outlook.com (2603:1096:101:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 09:02:42 +0000
Received: from SI2PR03MB5369.apcprd03.prod.outlook.com
 ([fe80::b0c2:cc68:d340:fab]) by SI2PR03MB5369.apcprd03.prod.outlook.com
 ([fe80::b0c2:cc68:d340:fab%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 09:02:42 +0000
From:   =?utf-8?B?WGlhb21pbmcgRGluZyAo5LiB5pmT5piOKQ==?= 
        <Xiaoming.Ding@mediatek.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>
CC:     =?utf-8?B?RmVpIFh1ICjlvpDpo54p?= <Fei.Xu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Thread-Topic: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Thread-Index: AQHZiG5Ti2msX8Qf8EyhdjKxcboKPK9eE0uAgAAFAYCAAARtAIAADxWA
Date:   Wed, 17 May 2023 09:02:42 +0000
Message-ID: <5f15cbe42ecb0188f674084e3c5c2280886c3c3f.camel@mediatek.com>
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
         <ZGSDoVKKVqCkbaCB@infradead.org>
         <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
         <ZGSLiiK/JzD5KMd7@infradead.org>
In-Reply-To: <ZGSLiiK/JzD5KMd7@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5369:EE_|SEZPR03MB7442:EE_
x-ms-office365-filtering-correlation-id: 50e3fce3-1c69-4e8c-4ef2-08db56b57925
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5tqtOxIWeq5o+j+42CD9iVCo48BDNc6JDAr3moV3d8bGq2Iu9HCWvtrhm1cDPMzavPBsB1/nV6YUdEuPyeMS2PV2t1rx+T338TTWnC1E0inQJardaK0XP+D5TC0CgvUDOEBMDr2mvP6YhoA2DALJakHhodoBw6OZXZZPh0bD01mFbjh3DX+s3tSk9ntYdi7V3bOLFPwckxWrZo+Iq/vMsktNHcWBPARLbDs1xg7h8JRgXA4s58335q1CFO7sW5szu2WyeIp7eiEao7rSz/xgm/Z7mDlT7RdacA6Pwyvgffewf+ROel1tbRNrRcPz2+semEptguVlJH4Q/GGOPtQ/9FaWdgA6wRImoNYOT2qXuUK7Cso3SFDFsg1xubHRbSm6T1QvV3ty65WcImrF4Et0pfSYq1NfHnltdy8mqRvuftf2Vc8SaYofDChiHs2Kk/2N9S5z8e0aqfMYSvg+SHGjvW+CUV0Vg899qx43GrY/Uvdjql59k/RIBzdhnM3gVI0Lo2v0rl0a3NXFdZ2sIpH6f2KUi1+6orqEHqaOVhovFaTYaMCEHtx+f8rmooPVCxNztiJ7Y8bZPU4Bk7Kx0DKFHkgpSYE8bLkfHSQGdjSXzJeyWgZN0qjK+c3GGNuh+AY+IOL3oT6HVh4wcISGQweg5dv38wPA8vaAPRodXGuCHfs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5369.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(41300700001)(66946007)(76116006)(66446008)(66476007)(64756008)(66556008)(6512007)(110136005)(478600001)(6506007)(26005)(71200400001)(54906003)(6486002)(4326008)(316002)(8676002)(5660300002)(7416002)(38100700002)(86362001)(36756003)(85182001)(8936002)(83380400001)(38070700005)(122000001)(4744005)(2906002)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE1US3hmV3NGZTlFKy82K1AxZzBNWHduWjBqVmJ4Z0I3WTVJSjJiaHFBUmFh?=
 =?utf-8?B?QVlYVDF0UzFMQmhENStVNGRMSGhCY1Mra3ZCVWMrUmdHMWxEQTh2R1JCSXl5?=
 =?utf-8?B?THM2eGx1eVV5ZGpWc25NS3Z5cTlUT3NHa01kaTR3MGovU3J3YVdTNnlTMUVj?=
 =?utf-8?B?MVo3YndLTUIrV3VyK284aWJMZGNGbnVuL0FiWDhwZ0h5cFB5cWZlWDNvK04w?=
 =?utf-8?B?RktNbktoM2pvT25UNlRSTVpWTEpTWUppWU5Sa0FlOFI4QWdzTVE5cVV2NVJL?=
 =?utf-8?B?RDBjQnZqOXVwNCtWWGZYUmc1Y2RrU2x0aGt0UkFMdzhHMmNXVmw4aWljdHBG?=
 =?utf-8?B?UzBsM0dSVlQ3K1FRVTJzNmtLWktZVSszN0lvSEMxN0k3a2F5eDE5eGl0VnI2?=
 =?utf-8?B?VHVkM1M5TWFJUnJoZlFuRUx3NWt1aEFPNnNHTTBqdlQ1eGdia3QzWnBDSERC?=
 =?utf-8?B?ZHpMYXZPZU5zUnBzQ3NsQ3dnNWhXOXFVa1hzTXRUUE9VY0dQSVhxWERmT0Fx?=
 =?utf-8?B?dzFHdWNGb2t4dWdmZ1Zja0FxcFZTY1FENDlpQnBPdHdlUXc0Q3R5bnV4SmtD?=
 =?utf-8?B?RzR3OWpPOUV2a1pRVVN3eFpkd2cvaWg2RWUrZ3Z4eUpOaWd6eGlGSTlydWM5?=
 =?utf-8?B?WHpNbStKL1FaRzBHM2tHRzRpOE5GQytQVFVwd2lFZjlsZ0VodDErSHVlMlhQ?=
 =?utf-8?B?djZCSVliUXJzNXdwUk5BUkRnSzlQR0RiOTBMMi9oSnhmTUdJZFluVENuZExD?=
 =?utf-8?B?aVQ0KzI3QkVLNDlXY3U5NVlrdVluNlc4MFpJZXJJbnY1WW1MaG05TFdUcnQ0?=
 =?utf-8?B?YUdIbE45VmZFL2VFbUJlcFIzcGU2RWExZXBkVkc0YkxURGMrYVBOd0liRjRT?=
 =?utf-8?B?dWRUc1J1aDFxdmtWY2ZTelhEVEJXbWtUL0N4bUlwQkFQV0g0V3gyUElvSjdk?=
 =?utf-8?B?MkhtdzBWSkErU0JZSXdaVjZwaFdqajZLSVJWWEVnZ1dQcVB0dnFxYTF2Sjhu?=
 =?utf-8?B?RHJKUVBqMUlkL2lBVktHNStPbXlPY2ZVUm1yWnZSZHBhSG11eHFLSVJqZ1Fl?=
 =?utf-8?B?aUI1VzI0VlF4SnFEa2pUb2VKUXJYZ053L2phV3V6eG5oQWVmQVRvMmpLR2Fx?=
 =?utf-8?B?U0t3Ym90dnM5cTNkSHljdDUvZmlPNXBtOXB3VXNvS2JnLzZLdjloV3R5WjZ6?=
 =?utf-8?B?Mml0Q1hwZWQ4ZXZHZ1N0WGE3YWdSU0oxOEdMV3M2cUxiaVR1Y2lFbWtpTGNP?=
 =?utf-8?B?c0NpdnNHZzNCS291Nko0dkdDeGdsd2VCWW1CbkVvc01UeG5MaWlROWVWUGlS?=
 =?utf-8?B?L2IwQVBvUkpEZ1M1OEhZUExCdmVxMEtDYlRZZlN0WUJSaUJhZnNZd3VKODFx?=
 =?utf-8?B?cGoxTktsYmk5dHBCTG9UdEc5a3dPUlNVclo2UjhEUGtjTDBVdUlPNzIwMVFt?=
 =?utf-8?B?WVZuTEp5Z3JKUkc1T2hEZUdTZHFoa0VhQ2Z3S0VodTFORXVpVmlmS0Z5Wi9G?=
 =?utf-8?B?RDM4dktZUTVnVWVwNnYxQzJqaC9NMWRHckFHb0lvd0VNdWNWQmVTQXR5NVdo?=
 =?utf-8?B?YXVwZHFpYjVWbmFFU2FMVWFvdDUzZWZmdUVLbEMyMnJyVEpOdUc1d1ZvbjY2?=
 =?utf-8?B?U2krMUorbHVCaSt2NE4rVXVobS9vYkxaNlpYV0lwYWx0ZFQydXZNR200RlBC?=
 =?utf-8?B?M2dGS2dQV1pTUFFNNTErR283MW5qTlJsTDVBVnpaRGJBUmxNTytCTi9JYkRL?=
 =?utf-8?B?Sk5TVnBZNjlSTWh2YUFub3ZTM2dNcndjOWhvT0lUM2wrY0F5YWkvak9GSzlH?=
 =?utf-8?B?SHp0UWc1N0VxS1ljaG9rY3lwd2pwSDYwOHFCREpIZlIwS0Z2UUtLTm9TQnJr?=
 =?utf-8?B?b2krdy9LbG5oUnhlZzVPQyt0WUptUEMyOFJZdVh4RVBqWUVCbGt4T0dWYWxq?=
 =?utf-8?B?UmsrTVk4dE1BM0wrRm5VM0x3TmQ1RmNnMnRaSCtRenJ6QzFuaGRwZ0J5aDhv?=
 =?utf-8?B?TG4rTXpqYXRMRTZTbjkzUGhwZ2RnZnVvYlhWN2FnRVpqWmlUMUN6dDBaKy82?=
 =?utf-8?B?aUh6NnBDK0w0Ly9PdDlZalRBcS8ra1VFNnBFT1JRaGtNbHhqTFUycGgwVG4r?=
 =?utf-8?B?WjlGUXJnWGNMU3lDZ0ZQOXMrT3ZRWnZ1cUFIWm9pelo2c21YMlRkTnJ6Nldy?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34C2744510B4CB4D81423F4C368A3B5E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5369.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e3fce3-1c69-4e8c-4ef2-08db56b57925
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 09:02:42.4446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfmeI8C04qAQ26k6yDRHOnNk9ut1bdmsrV7gV8oJIY4iW3a37jgJpKD/f2ljs5tL1idaiQ8QF0I/SNh9G14EvNApdEXPXZn54/Q8WhDtBEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7442
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTE3IGF0IDAxOjA4IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiBXZWQsIE1heSAxNywgMjAyMyBhdCAwMToyMjo1MVBNICsw
NTMwLCBTdW1pdCBHYXJnIHdyb3RlOg0KPiA+ID4gPiArI2lmIElTX0VOQUJMRUQoQ09ORklHX0NN
QSkNCj4gPiA+ID4gKyAgICAgcGFnZV9mbGFnIHw9IEZPTExfTE9OR1RFUk07DQo+ID4gPiA+ICsj
ZW5kaWYNCj4gPiA+ID4gICAgICAgaWYgKGZsYWdzICYgVEVFX1NITV9VU0VSX01BUFBFRCkNCj4g
PiA+IA0KPiA+ID4gSWYgdGhpcyBtYXBwaW5nIGlzIGxvbmcgbGl2ZSBpdCBzaG91bGQgYWx3YXlz
IHVzZSBGT0xMX0xPTkdURVJNLg0KPiA+IA0KPiA+IEl0IGRlcGVuZHMgb24gdGhlIHVzZXJzcGFj
ZSBhcHBsaWNhdGlvbiBuZWVkcy4gSG93ZXZlciwgSSB0aGluayBpdA0KPiA+IHNob3VsZCBiZSBz
YWZlIHRvIHVzZSBGT0xMX0xPTkdURVJNIGJ5IGRlZmF1bHQgdG8gc2VydmUgY2FzZXMgbGlrZQ0K
PiA+IHNlY3VyZSBtZWRpYSBwbGF5YmFjay4NCj4gDQo+IGxvbmcgdGVybSBpcyBkZWZpbmVkIGFz
IHdvbid0IGF1dG9tYXRpY2FsbHkgZ28gYXdheSBkdXJpbmcgdGhlIHNhbWUNCj4gc3lzY2FsbC4N
Cg0KdGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCkkgd2lsbCB1cGRhdGUgdGhlIHBhdGNoIHdp
dGggdXNpbmcgRk9MTF9MT05HVEVSTSBieSBkZWZhdWx0Lg0KDQoNCg==
