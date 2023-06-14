Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD972F795
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242656AbjFNIQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243256AbjFNIQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:16:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23BB1980;
        Wed, 14 Jun 2023 01:16:18 -0700 (PDT)
X-UUID: ce3711680a8611eeb20a276fd37b9834-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=BqIl/T4DRnaoYG1zEAUnAQihPNxsQHb1LhxXYtWYA58=;
        b=ivB0FuJlKwTYPcn7hxGp5ohdPI+kwN96FR58T9LvUOuY5coLWNnrSyC5jaB3JVuD54cXYEdYigYWQBb06hn/UDXjhb4JTUtAZYpo8F8jMn2k9P38Pchm2WOT/vqlq1PUYfidTv5suxGFVC4a3ZsBsRUXSmaZmtqnKTL59+5iKNQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:eee66e24-0c7e-4284-8589-f88b58495b0d,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:0955076f-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ce3711680a8611eeb20a276fd37b9834-20230614
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 163276783; Wed, 14 Jun 2023 15:40:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 15:40:58 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 15:40:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez395p4soO62C3jSrNFMZppDtWnZ5JJ2MWcAKe0uToM/39w6gTXD9ylXMAEZb7soZ1VtZrRCKl4/rpKV69oNmfkY0AdbQxraxOCI+UM0Ds1ANm6jNZZrhjNxSs/RPcAdzik7H/yq71/y9kea/C/xK01Gl8aTRrekr/Aq5vWcM09dc3OVjsK0RFO/DkNPy1iqsdmPg5vVPY/yn/odR3cw2tCZfs3kLAF1VuIL/TzyVbNaRoqlU3Z7ZYyDK3Qh5dFnT4STvietTuVoi5NETyoouzTkDMgQfx78iNENyelR4YYWSWafGYduMdhePSXD5kjUg65xYnjKp54pC/PX5l1J7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqIl/T4DRnaoYG1zEAUnAQihPNxsQHb1LhxXYtWYA58=;
 b=HbXjiiZwASNl2AUjcxcdn+O9D14wPgsSNFFXOiCBfn6BnNTCByLSNVOSuJAj+30s4qndAqyC4yMpRY2Lag0WCkhd9UGPb9ywmHi/1M0p3QXBq1Mpi3mVaOI2q5qruOuDwZLXpWNPiaNS6ZkFcl6M6jERfVKUN6OjEKc5m6VFYZAPe/LHMlqTtg/kYdKFCQ21DVRSlbPAmikNhSWCtcDQ9JFTVb647xCy63EZen8rJ1Fx5xqjkSlKNDy8Fp1J5qiIu4TMa4UQhLgUPlGJywUlkSEWaAJAZR9lvsJ23u0eQrmv0oZP5Awqf7h+j0LLG3022PC4YXI0wUY235aLTRX89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqIl/T4DRnaoYG1zEAUnAQihPNxsQHb1LhxXYtWYA58=;
 b=JR2uKS1RiMyCNJ94qNld4/QfWZRDB0BC5SOXA8LxJ6YDvLmVUbde1nF7q4BHkGCCK4MBCLLLmAKZuUaT3oUyRak0jvUTCP8eKhu7NRSzCHF80BhIGCez5e1fMxmiWKuVdFR7HVcb38+Nnc09a+zmZTA3tTsceXbDIsFr6+iNOns=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TYZPR03MB7082.apcprd03.prod.outlook.com (2603:1096:400:33c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Wed, 14 Jun
 2023 07:40:56 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d%3]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 07:40:56 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
Subject: Re: [PATCH 6/7] ASoC: dt-bindings: mediatek,mt79xx-wm8960: add
 mt79xx-wm8960 document
Thread-Topic: [PATCH 6/7] ASoC: dt-bindings: mediatek,mt79xx-wm8960: add
 mt79xx-wm8960 document
Thread-Index: AQHZnRxrxfjJMnUoLE+/r69NNJMkHK+IbaGAgAF/QQA=
Date:   Wed, 14 Jun 2023 07:40:56 +0000
Message-ID: <c87eadd9fc8d0ef9dc4582493e540f0b311e06eb.camel@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
         <20230612105250.15441-7-maso.huang@mediatek.com>
         <7bf1395a-eba8-fe27-a359-9c50af7add2a@kernel.org>
In-Reply-To: <7bf1395a-eba8-fe27-a359-9c50af7add2a@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TYZPR03MB7082:EE_
x-ms-office365-filtering-correlation-id: bfb11460-9ff7-4c74-27f0-08db6caab091
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FrsqENEsf6F3o2JXhn6Z4DGMoYMdlqawRDlcKdJy9lKQs9IePCtMVzGEH16G2Mliiudd3PlcgWw+8BnblN2lv2+AZWwm080/Yhph3zVzml/gDnh62XoCE7n5QEB5/MsSh0hNeGyT8TE6eo9mOscsPg1w+rlD2GZ6XF9SIwuVCwIwyUCbgij7vBy8dlUzIz7lStJFACY/m1r5cM9V8m/RP/QNOz/wl8bCAa53f0bhQYyydulqvUxeE0hlj3lx838gwvXZtMCfKeaut1ESGYl7RtmaVlZimR5ac7XXGK1y+RnQl64WsidWuCNAQcPsPp7pkJgbp9heGNppeKBfqc1UsWicgqAs2PlBFuNQ0qU85G4+VbvtfDwintBkPAR356+vdKtr3q4oYfMuYAjktY8FOQuu2ula0Fp7dHD19dlTOWQLpq/A73jiH8y6U0EThTujUB7tDovlNWHKUqYFcUedoF76rX0bBBIKA0cuzefU3Wlpf6go+Cwy90hrUTLby9rJ0xwSubVZyp1bQs1nHjj1F7u049fKaHmfSAx4nkQ86+rphNTaLdXsO1M7ZQvI8+g6duxfgMqMFx+XdCqBdstsnBjFpKFzB++O9yObAMLgK1a+ryq+U6elanBXlnETcf9At6+f5dqCRN5UxRqwmsD6/iJO8wUWkl5qFpNH/7DdcS5OPud3tWX5/PhkTEiIXhwDj8ZjtYJ10k7qkZPI35Rhkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(921005)(122000001)(38100700002)(86362001)(38070700005)(8676002)(5660300002)(8936002)(7416002)(316002)(41300700001)(66946007)(64756008)(66446008)(6636002)(66556008)(66476007)(76116006)(91956017)(83380400001)(110136005)(2616005)(85182001)(186003)(6506007)(6512007)(53546011)(478600001)(36756003)(26005)(2906002)(6486002)(966005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tnk3eTl3Ukw5ZDN4b3ZINE56SVdjM2Rnc0IyUGYwSDREZDFEVFA1TEVNMXRj?=
 =?utf-8?B?U0luK2lYZUxrUGQrUWh0WTZySnNOa2RPejdEc0Q0UzNTY1F3Ui9HVkhIOFAx?=
 =?utf-8?B?dHdnOFRjakpQVFVoSmNCVWdyL29OZ2FFUmZ4dHpvZmhvUGtaUFQ0RHZwV2t3?=
 =?utf-8?B?WU9uVHArQTlQT2sxbkR1SXdSZks0RUcyN0V5cVBRTEQvemFOLzJPQXQ4KzA5?=
 =?utf-8?B?NUI0aDhHc1YxZDVRY0JqbkRuWVY0dDhrOWs2U1lrQUdvSnB6RlBPaHhoVSt2?=
 =?utf-8?B?NTlVRmdaeGxSbTdHdERGSWZoTUxicWZzSDZuc0RJcTJrL0J3WUN4MFNtUE52?=
 =?utf-8?B?L2VuallqNzVnSEV3RisvQVNjbDUweVJFSzZZOXY2Q3pseTR6MDNzRGZLWER0?=
 =?utf-8?B?d1ZzQitwSHV0K2pDYnlDbEFyRHRrZlpwMEErRHB3MWEzU3NHZDNtSTJvZEV0?=
 =?utf-8?B?dVdhVUhjM1MyNnBwZmFmd0JvUGMySW5OUFA2U2c0ZStxNVZIdHh2T1dKckxy?=
 =?utf-8?B?cEsxVWgxcGxJbEJLcDBBMVQrQVUwWW16Uys4b2ZyTHVGTTlLenErSnJvTjhv?=
 =?utf-8?B?aW1oVFdMUzJBY1kwb3NWYW55S1BGSTF5dkkzcW5ORUtpejhqdEJ5d0p5ZDR0?=
 =?utf-8?B?N3lpSTI2MDl6S2FYRGhVemRReE90eUFEcEZGTFM4Q1JWNTF1dXlMZm9uMHUx?=
 =?utf-8?B?R0xNS1h0UmJtY2MveDNWOXRUdlBSaVRhZHg2ZGJ0cEMyNERITXJ1YlF2dHEx?=
 =?utf-8?B?R3FmdHRJL1lnSC91K0kxMS9aMmpweTJ1a0VCWmthVmZlTDNBOGJQa3dveE54?=
 =?utf-8?B?MEV3bnV5TWUyVWozaGZkWTd4eFhYOUZsRjFIeHVUK1FDMG9OZkpkK1YwL0JP?=
 =?utf-8?B?NEtMTTMyNVA2RmNEdEEvYStJVVlrSnZRVXBaZFhGdlZuNkRhdllNNks5Z3Zz?=
 =?utf-8?B?MEpqbllzNUJ6V2FuZ0prc2VwT0h2ME1LVlViUTdXTUR0bGNQS2c1UVVFemha?=
 =?utf-8?B?d1dzeGhUMUNoYXk2enFVaytYZEtOUDFkY3FaajJqRTFLdXlBU1g1ejRYcE0w?=
 =?utf-8?B?Zi9IYkc4Qnd2VnBGL1FWbnRxdHNLZENyenNjMnR4UkNkQ2ZUM2JsdkJVWFdQ?=
 =?utf-8?B?TW5vditZVlI4NEptbXNVSE5jWGgrTVVKSlZCMkpLei9VcmZYRnRWUE5zK2ZH?=
 =?utf-8?B?YW05ZzNuQ3BzbVRVY1dMT1M0SnJpbkxDSjBvU2tSQjdpTkorcVVVczRReWpH?=
 =?utf-8?B?RlJBZll1cFgvWUJncCs4a1VuNmpLenh0cithdTlVM01qVk9BUFV3eXhoN3Jq?=
 =?utf-8?B?TFdqOTJOMHJqamd5QUlseHZCUXg1TzZocFRQRFZxTUlURE84d1ZjUk1kMTZK?=
 =?utf-8?B?M2xlZ0JoazFHR3VvTm1BYlllWis3QjA1bElnRE9sVlpwdGd1cjRmcjFpczZ5?=
 =?utf-8?B?bXRFdGhoVTJ0QTVSQlI2cjdHNWQzTXI3NDhZQWowekZmRW9ZazQ2M0R0ZStK?=
 =?utf-8?B?YTgrMUw5eU56U0d2TGpIMWJPNmFranBoNjhLS25hZVQraUIvaDRpVWVQcTQ2?=
 =?utf-8?B?UWRtbGZBb3Jib1BPVEtSTE5OU3dMa21CWG1KWFlWUEFyQmxUUEZ4SW5tbEJn?=
 =?utf-8?B?L21yNFE1WmxKS1k4WGdiWnNRdjZGZkptc0czZE5TMmxxbzdlL3dIVVA3YXZI?=
 =?utf-8?B?bjF4UENxRHRZMEdjemh3eXFKWHJkOWtrekpJSUVjNkdWaGtqWE9ramUrb1pp?=
 =?utf-8?B?SURVUVJHTWxiY09LdkpaaDc2ZTdVV3Rra2hBZFFNaVRMYVpoQXIxcitFRm0z?=
 =?utf-8?B?MHZ4alRvL3kvVllyNUp2eWJQT0oySE1yOFJscFhWVUV4OVdlcksvcXpwMzcw?=
 =?utf-8?B?SndSbTZDNENVMGMxeFNCajVDck80bFAySDRiUEsya3loVERQQkJoN0s5cEQz?=
 =?utf-8?B?MUlIajRtMDJZeXdKbXZIMmtSUE1HZ253Uk9lK25HbFg1Rmt1NTYzbTJraWRK?=
 =?utf-8?B?dWFRcXRNd1E3T1ZZOGRxeWtwRk5Fd3VYd1FLMTg0SXhWZW5KeWlJZWduTUxD?=
 =?utf-8?B?djBZaFRybEswZmFlKzd4NjhRSmlUWXkyWVZpcm9EcnRBaEUrR2lnVm5EVGZo?=
 =?utf-8?B?cmtwNHJIclhoQ2tnMkhrQ252Vkt5Y3o5N2FlazVlN2lNUGJTcC80ZklvWHpO?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62ADA8C40A22B945A0E68D3C81F2D2F5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb11460-9ff7-4c74-27f0-08db6caab091
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 07:40:56.5347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7v5yylERvBm0pkTBfRYA6c/anMeFBxKIKnxlU6PN2UuQHYjJPIzXfo9RWzUiduUQ5oN/zH299KNjDPPpCE0bMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDEwOjQ5ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDEyLzA2LzIwMjMgMTI6NTIsIE1hc28gSHVuYWcgd3Jv
dGU6DQo+ID4gRnJvbTogTWFzbyBIdWFuZyA8bWFzby5odWFuZ0BtZWRpYXRlay5jb20+DQo+ID4g
DQo+ID4gQWRkIGRvY3VtZW50IGZvciBtdDc5eHggYm9hcmQgd2l0aCB3bTg5NjAuDQo+IA0KPiBQ
bGVhc2UgdXNlIHNjcmlwdHMvZ2V0X21haW50YWluZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2YgbmVj
ZXNzYXJ5DQo+IHBlb3BsZQ0KPiBhbmQgbGlzdHMgdG8gQ0MuICBJdCBtaWdodCBoYXBwZW4sIHRo
YXQgY29tbWFuZCB3aGVuIHJ1biBvbiBhbiBvbGRlcg0KPiBrZXJuZWwsIGdpdmVzIHlvdSBvdXRk
YXRlZCBlbnRyaWVzLiAgVGhlcmVmb3JlIHBsZWFzZSBiZSBzdXJlIHlvdQ0KPiBiYXNlDQo+IHlv
dXIgcGF0Y2hlcyBvbiByZWNlbnQgTGludXgga2VybmVsLg0KPiANCg0KSGkgS3J6eXN6dG9mLA0K
SSdsbCBhZGQgbmVjZXNzYXJ5IG1haW50YWluZXJzIGJhY2sgaW4gdjIgcGF0Y2guDQoNCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXNvIEh1YW5nIDxtYXNvLmh1YW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgLi4uL3NvdW5kL21lZGlhdGVrLG10Nzl4eC13bTg5NjAueWFtbCAgICAg
ICAgIHwgNTMNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTMg
aW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10Nzl4eC13bTg5NjAueWFtbA0KPiA+
IA0KPiA+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c291bmQvbWVkaWF0ZWssbXQ3OXh4LXdtODk2MC55YW1sIA0KPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDc5eHgtd204OTYwLnlhbWwNCj4gPiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMjZiMzhiYjYyOWRh
DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDc5eHgtDQo+IHdtODk2MC55YW1sDQo+ID4gQEAgLTAs
MCArMSw1MyBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5
IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IA0K
PiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb3VuZC9tZWRpYXRlayxtdDc5eHgtd204
OTYwLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVt
YXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IE1lZGlhVGVrIE1UNzl4eCBBU09DIHNv
dW5kIGNhcmQgd2l0aCBXTTg5NjAgY29kZWMNCj4gDQo+IFdoYXQgaXMgYSBNVDc5eHggQVNPQz8g
SXMgaXQgc29tZSBzcGVjaWZpYyBTb0MgbmFtZT8gV2hhdCBkb2VzICJBIg0KPiBzdGFuZHMgZm9y
IGluIFNvQz8gWFggYWxzbyBsb29rcyBvZGQsIEkgdGhvdWdodCBNZWRpYXRlayB1c2VzIG9ubHkN
Cj4gbnVtYmVycy4NCj4gDQoNCkknbGwgdXNlIG10Nzk4NiBpbnN0ZWFkIG9mIG10Nzl4eCBpbiB2
MiBwYXRjaC4NCkFuZCBBU29DIG1lYW5zIEFMU0EgU29DLg0KDQo+ID4gKw0KPiA+ICttYWludGFp
bmVyczoNCj4gPiArICAtIE1hc28gSHVhbmcgPG1hc28uaHVhbmdAbWVkaWF0ZWsuY29tPg0KPiA+
ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6
IG1lZGlhdGVrLG10Nzl4eC13bTg5NjAtbWFjaGluZQ0KPiA+ICsNCj4gPiArICBtZWRpYXRlayxw
bGF0Zm9ybToNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25z
L3BoYW5kbGUNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBvZiBNVDc5eHggQVNv
QyBwbGF0Zm9ybS4NCj4gDQo+IFdoYXQgaXMgTVQ3OXh4IEFTb0MgcGxhdGZvcm0/DQo+IA0KDQpJ
J2xsIHVzZSBtdDc5ODYgaW5zdGVhZCBvZiBtdDc5eHggaW4gdjIgcGF0Y2guDQo+IA0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCkJlc3QgcmVnYXJkcywNCk1hc28NCg==
