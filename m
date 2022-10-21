Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8972E607319
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiJUI6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiJUI6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:58:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B20C2514CD;
        Fri, 21 Oct 2022 01:58:28 -0700 (PDT)
X-UUID: 974f8a5ff7b841969fa66e49a629dc4f-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BnZMhXehLVKnkF4Paf/KIXdm7YgTA0VztoLYgr4xJtI=;
        b=Uj2lwalWnz6IvX0TJ42ue9b3ewJysKLh2OL/bi+c6ekjepYSCLXhFdv/lCXJRvuGS8VPDooummQVbtP8KKf8/GYNu9nN5Y1V3rv26AwqAZdjAgsj47uS7UQYPErb8TTuPp8gFLyFXxAVL3TXMSaHn6lXvaFoDh0bOxQ09v2KveI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:3a16cd35-4a31-4ab2-91ec-d23b9288d03b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:db0e40e4-e572-4957-be22-d8f73f3158f9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 974f8a5ff7b841969fa66e49a629dc4f-20221021
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1028758035; Fri, 21 Oct 2022 16:58:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 21 Oct 2022 16:58:22 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 21 Oct 2022 16:58:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+CUJZSm9hNW49x/8TC3XtJVT6JPAAdBv9Tu3S+itt+6K2wdH4z5kroog6H6L37Ds18lXNWb3P8L/zVrGUZhrHsj71bBm5iCDpT5G+Vi+0w0mezjBMP9aHkbDeWOi9okth9epHm3hdY8K2y+mcYEj/XGoJVEDOMTHz0el4XJqVfXhfkeKIC+Dh9x3htFIabIVpiNn7RZ0IP4yClS6BH7UOdj4wsTPsf82dqcj5l/Yiwu513MteQ3+XlLoC6xFLcc8a0aJJtxIMvj82d+RfZm8oTGbnfre6l1V9+xlm/MDr0BhPgYw+gHVFKq+8LJqXPziz/1TwDkB4a23hxk1MKdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnZMhXehLVKnkF4Paf/KIXdm7YgTA0VztoLYgr4xJtI=;
 b=W0nRqbykmqPnLnvn6FChJ+tfsHJ26t3UfJOBBQeY7nhGESUh3lxY0HGd9U8AfNq0TqrIicX8QnAT+R/02WxKIXP+oUhH6ZY/AbsLi8N4J7roPUEJyaeYlquH0FkK+86AdAYL9CVW9dXjw9V/iYRfUKZONBiLxiph2rT9g/DBs9KM0iW+OIDjNv6nY5c5hqtG/f1+q4kXWYEHjhRKG1I2X/0bM30EjkPjpl4YonQwZr2xWCHj9VdcPtQc4M7UnLrxqxj0DV6RUusKxjkc3WMMuKK7orxMHlCQnRMaRXw+HOTuo2kYIns0C+KlmtacKQ8XaKEmdMvpXTLetvaC6ilafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnZMhXehLVKnkF4Paf/KIXdm7YgTA0VztoLYgr4xJtI=;
 b=no5kjYZcE3R+TllmcfsX0k/UKMmc36N6Z2LjkoWc5HqNsn6IXJyX6nLiOIrFnrSubPJZEPIq5pYP8UrcaBn9Tq/cjohDSPpRz5oGINwNW2b8TcdJu4GWwJnjDaacFngsy2HoewdfnLG1zR7x3BZZCIXngaSKlEmTSkKDBq3zzhs=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB6646.apcprd03.prod.outlook.com (2603:1096:400:1f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.18; Fri, 21 Oct
 2022 08:58:20 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::6c50:1e0c:f9dd:d45]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::6c50:1e0c:f9dd:d45%5]) with mapi id 15.20.5746.017; Fri, 21 Oct 2022
 08:58:20 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 12/12] dt-bindings: mediatek: mt8188: add mt8188-mt6359
 document
Thread-Topic: [PATCH 12/12] dt-bindings: mediatek: mt8188: add mt8188-mt6359
 document
Thread-Index: AQHY1Nz5OA9S/sIRuESL8yXlzp3JUa3844KAgAPMLoCAF/0eAA==
Date:   Fri, 21 Oct 2022 08:58:20 +0000
Message-ID: <ed703b2b32e81edb36dfe07f6d5703918ef4bbb2.camel@mediatek.com>
References: <20220930145701.18790-1-trevor.wu@mediatek.com>
         <20220930145701.18790-13-trevor.wu@mediatek.com>
         <20221003163851.GA2414624-robh@kernel.org>
         <e96ef77f007f66f883f8dca86d1206cd1b5a767a.camel@mediatek.com>
In-Reply-To: <e96ef77f007f66f883f8dca86d1206cd1b5a767a.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB6646:EE_
x-ms-office365-filtering-correlation-id: 257bacb4-0ca0-466a-3c39-08dab3426742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SA6LdDvXChnVhuyTVsN3DjL7K/g1f7ozJGnFxGx3+w98SEinxOSLnJoHm4UJmB+EZCGR1wQ37UAKdqfwmV0vOprxklmVHsAurcdvP5zGC5zaOOG/evZfMkJ2Cm9i98cojt18Hsfk2uVQJuqSFWccp+rRq3uy4dWxOQ90Zh4LT2Zh0asVDOfqPNIL5MrQRjS5+GtYH/3KvLzISPWVqx+wCEiPMBQ9oR/S+qfoSmEWVjRzwYon5FbfV0cpd3/MIBTpoCEBtVrNXSfjHMcWE9q1M+Iy+5/YMUCwQyeJvQBztg1FEFgmwV+VJjD1CozHwhDM1OQxUnrTY6szkJ6g9lm+f+OCx11z+gU98hUKTMPTdsC1yq5OmlQdLh3ItuDdtsRuc+HH8+iIyjyJMRf3CyielOtU6FG/vTRaOd8wC0fNOpeef0myGVETfnrQxMOr5xpTD7ROIIQ2aDLjqQRBRQfuncWf20tcVRxi5dxzjFbc8/JnjfLXxO2L8hhK5aCybwgpdrdMnY/TYga5z80F2+yB5WMAAixGGkJ/3jWrYcf7/o4qzK8I4D4SfAyOXGKQnKrhOBIcBncjz2j4JJ8ZVI84WjbK4rousuvdKOOasuiCiHbFf31JfGrFAVcr7hzuIY1LGyqEo6iK8JEZflymkpLt6lPhFD1Zft3wmQ0ow7cTLvKUE4WYOElWPB5wX5cW5xXNgwWhpabkNmHTvaEU0CMzyuq7zWzE0JljuZ50QHSglP+cacvGZd0DzVUvplWhIXHWbOSnR+/y+c+4FaSJ5o1UUhGMU9U7xNLJsH6rcm1bSYE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(6486002)(8936002)(71200400001)(5660300002)(7416002)(478600001)(36756003)(316002)(85182001)(122000001)(6916009)(54906003)(66556008)(76116006)(66946007)(8676002)(186003)(2616005)(4326008)(64756008)(91956017)(66476007)(66446008)(6512007)(6506007)(26005)(86362001)(38070700005)(41300700001)(38100700002)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZytzeitmMlpxUnpjRVJodGxYU0FNZ3VkN0J3dTBoU3BWUXFlNkcyQjNoQ3o4?=
 =?utf-8?B?OW9PV3RSUnZHOHhlQVB6ZnU5c2d2S0w1cDVXeGlHQ04rV0hEZ05VQXVoNXFh?=
 =?utf-8?B?aFIxSlIzYkZUTHRqMW5oVnp2clp0enVVSzFyR1J3QlFtMmJQSDlZLytaeGQ3?=
 =?utf-8?B?ZklzQVk2WFN2Y2R2K0UxdkhoYWRIVS9TVXFmbkhPWVFEVzEzVnZVOGpMWTUz?=
 =?utf-8?B?Q1dYMzJtSHFwaGZ0NlhVN3RWekxQZWlINjRLdWZmM0x0anZXYW5nUzlWNEY0?=
 =?utf-8?B?M0hyUjA1SDdHTUNNK0s3SWVFaXRtTjFtWWRnY090VlhsTS9DTWtUVlc5RjhD?=
 =?utf-8?B?dlh0cStnR0V2c2pFSXJqa21meHhZR0VDZk9xZWh4cGxidDZ1aWRYNUJvSG10?=
 =?utf-8?B?Y3RkanFBNUhaMEExdnRRVTljZ1ovMmt5Tk01di93SHhjYnoreENrUjNOSVFQ?=
 =?utf-8?B?eVNCbjdiN3R3ZVdYN1JlTGFvRTUvS3JiOHozYWRHVjN6NHVSN1hDV2NjSTlL?=
 =?utf-8?B?azU0K21hWnFxU0p6MzNPTktZN2pNMWdXY2w1S0ZWa2IwWDRxYmc3WlYwZit0?=
 =?utf-8?B?YXVpM0JQQXNXMFJwRjh3MFlaVy9aOG9STERibk5rakVxcEJTbjc4NEh0SWdU?=
 =?utf-8?B?RHQzdUxHUkVuWkIrNzRhT1FSM0JxR0NCUWFlSUo4VGovOEtDd3dreGpNR25p?=
 =?utf-8?B?djFKTGJ5RzV5SzRaY2xKdTlKZytaK3FwSEJMZUtCY1FoVjZJYVY1dklmdVYy?=
 =?utf-8?B?RlBOQnlmQXB6T0E2ak9TTVUwVGVMczJMOEhjM0h2YjhLZkJEWmhsV0YzcVZ4?=
 =?utf-8?B?VW5VZmxKbHZNcDJXWklOT1FUM2VtUUIwbng4YUJ6REF0aXNTOHQwbVdQSHVX?=
 =?utf-8?B?cEhNSTNEa1daSFRzOHQyenRhdS9ndzMvMFBjK2dEdTd1U3BncGIvUjd2Z2tV?=
 =?utf-8?B?ak9QWitxU0U0UGNXallpZ1lYZ3ZTY1dwTk9qc2MvbjFUY2ZRSkF2VzdwU0ps?=
 =?utf-8?B?dXJETE1OcHJOWm02TVdnOXpYZXNSQTd3VnpBYnFFWUd3OUpTOFNITitrK2tj?=
 =?utf-8?B?cENtMW1wVzVPMHZObWEzVExsS2ZmQitCRGRsOFhEWndsbnRXdDBoQlEyMlVz?=
 =?utf-8?B?UGtoZnd4em9uT1JsdHJ0SnRid2ZNazM0Mk94NXV5MnM3eGs3TFlYY0hIZmFL?=
 =?utf-8?B?Z1ZiN3FWUS90d2JNb1A0Z0VrckZibURlYWl0aldwSzBTd0FWWWp6bHJyYXNr?=
 =?utf-8?B?c29QbTViL25YdGpvdDdSeTMzdGF5TzM2eTVSTjN6UWFlU3djeHJBQWRvTndC?=
 =?utf-8?B?RlRDVER1WEhlNkxaUVRUOENmQWlrVEJMVTVRMmdoWWJZajVaMFZqZ01vNzFM?=
 =?utf-8?B?NlVwUnAzMm1mMFNKcDVKcXVGQWJmeXlhZGxZY0JOUGVPdUVTdkszazVaWTFk?=
 =?utf-8?B?SlhtaitHNlM4Q055aUNWWCtyRWwrcC9iWlYzSVNHdTAzTU1OOUZYMGpTMUpB?=
 =?utf-8?B?ZUpIMlBxeGhoS2RhWXZWeVZoVHJkbkVsU1lKeVhGdjdTWFJTL0wrN0NsK1BY?=
 =?utf-8?B?Y2twQVg4TzhvbHVlenBMNUlYRmdaR21oMjZLYmN4R0NnRStsaXQxTUY1NlMr?=
 =?utf-8?B?UWFBd0hXTmVzZ1BxNWNhaWE1QUM3SmRXQWYwVFFUK0l0ODlEaVJjQ1ZyanF2?=
 =?utf-8?B?bW9JQ25NaWJwcytaOFV2dkd6cmk0eU5yRUo4M1I2eEhqWDNHaSt4cjk3TDJD?=
 =?utf-8?B?ditRWW93Rkk2NU5CWGdxMi9ndjhoYXlCeHFRdXhFU1ZUbmVTbTArenJEZnZn?=
 =?utf-8?B?Kyt1cGh0Q1FlU05WQ094UjVmeW1QTnJ6NHBJanlrL2FJRW1hZ1lzOFBXb2ZY?=
 =?utf-8?B?VlIwc2NHSWVINE5Va3U4VU8wcnF4QS9WNlVpdThVbFpOQzIrYldEZWs5b2Ni?=
 =?utf-8?B?NGNyMk5zbVR5R1lXTW9wZjBjNnAxS2hEZjRHck9HaExpSlBHWE1nRm9CRzdk?=
 =?utf-8?B?bHFCTm1JVVErOC9FNjF3ajgzekpLd2FOc0JWekJrZlQ4aVVVYTZJd2g0YW1x?=
 =?utf-8?B?TS9jU1RyUTFPM0RobHIrQzUzQy9sb3FudVNCQnlBZHJkR3hXbW91amRHdGxH?=
 =?utf-8?B?Y2cweE1sTkU5NUNYbUZPT3RIeG01ZWx1dUtGaW9xZ1VrNGtkSEozY3RLdHRO?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DA7E7C356D17740BEB5D522D1D7560C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257bacb4-0ca0-466a-3c39-08dab3426742
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:58:20.7485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diVD7MZJS5sR3dN15kMWg95FbsrYsTk3oguTvRomnqXGIaMEZhw0qxmbn9/KL+tJ+J0Kdk6ZlzCf1w/l13YyWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6646
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IA0KDQouLnNuaXANCg0KPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgb2Yg
TVQ4MTg4IEFTb0MgcGxhdGZvcm0uDQo+ID4gPiArDQo+ID4gPiArICBtZWRpYXRlayxkcHR4LWNv
ZGVjOg0KPiA+ID4gKyAgICAkcmVmOiAiL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
cGhhbmRsZSINCj4gPiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBwaGFuZGxlIG9mIE1UODE4OCBE
aXNwbGF5IFBvcnQgVHggY29kZWMNCj4gPiA+IG5vZGUuDQo+ID4gPiArDQo+ID4gPiArICBtZWRp
YXRlayxoZG1pLWNvZGVjOg0KPiA+ID4gKyAgICAkcmVmOiAiL3NjaGVtYXMvdHlwZXMueWFtbCMv
ZGVmaW5pdGlvbnMvcGhhbmRsZSINCj4gPiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBwaGFuZGxl
IG9mIE1UODE4OCBIRE1JIGNvZGVjIG5vZGUuDQo+ID4gPiArDQo+ID4gPiArICBtZWRpYXRlayxk
YWktbGluazoNCj4gPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlv
bnMvc3RyaW5nLWFycmF5DQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gKyAgICAgIEEg
bGlzdCBvZiB0aGUgZGVzaXJlZCBkYWktbGlua3MgaW4gdGhlIHNvdW5kIGNhcmQuIEVhY2gNCj4g
PiA+IGVudHJ5IGlzIGENCj4gPiA+ICsgICAgICBuYW1lIGRlZmluZWQgaW4gdGhlIG1hY2hpbmUg
ZHJpdmVyLg0KPiA+IA0KPiA+IE5hbWVzIGhhdmUgdG8gYmUgZGVmaW5lZCBoZXJlLg0KPiA+IA0K
PiANCj4gT0ssIEkgd2lsbCBhZGQgZW51bSBoZXJlIGZvciBsaXN0aW5nIGFsbCBhdmFpbGFibGUg
ZGFpLWxpbmtzLg0KPiANCj4gVGhhbmtzLA0KPiBUcmV2b3INCj4gDQpIaSBSb2IsDQoNCkkgZm91
bmQgdGhlIGltcGxlbWVudGF0aW9uIG9mICJtZWRpYXRlayxkYWktbGluayIgaXMgbm90IGluY2x1
ZGVkIGluDQp0aGUgc2VyaWVzLCBzbyBJIHJlbW92ZSB0aGUgaXRlbSBpbiBWMi4NCkkgd2lsbCBh
ZGQgZW51bSB3aGVuIEkgYWRkIHRoZSBpdGVtIGluIHRoZSBmdXR1cmUuDQoNClRoYW5zaywNClRy
ZXZvcg0KDQo+ID4gPiArDQo+ID4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4g
PiArDQo+ID4gPiArcmVxdWlyZWQ6DQo+ID4gPiArICAtIGNvbXBhdGlibGUNCj4gPiA+ICsgIC0g
bWVkaWF0ZWsscGxhdGZvcm0NCj4gPiA+ICsNCj4gPiA+ICtleGFtcGxlczoNCj4gPiA+ICsgIC0g
fA0KPiA+ID4gKw0KPiA+ID4gKyAgICBzb3VuZDogbXQ4MTg4LXNvdW5kIHsNCj4gPiA+ICsgICAg
ICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXNvdW5kIjsNCj4gPiA+ICsgICAgICAg
IG1lZGlhdGVrLHBsYXRmb3JtID0gPCZhZmU+Og0KPiA+ID4gKyAgICAgICAgcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsNCj4gPiA+ICsgICAgICAgIHBpbmN0cmwtMCA9IDwmYXVkX3BpbnNfZGVm
YXVsdD47DQo+ID4gPiArICAgICAgICBhdWRpby1yb3V0aW5nID0NCj4gPiA+ICsgICAgICAgICAg
ICAiSGVhZHBob25lIiwgIkhlYWRwaG9uZSBMIiwNCj4gPiA+ICsgICAgICAgICAgICAiSGVhZHBo
b25lIiwgIkhlYWRwaG9uZSBSIiwNCj4gPiA+ICsgICAgICAgICAgICAiQUlOMSIsICJIZWFkc2V0
IE1pYyI7DQo+ID4gPiArICAgIH07DQo+ID4gPiArDQo+ID4gPiArLi4uDQo+ID4gPiAtLSANCj4g
PiA+IDIuMTguMA0KPiA+ID4gDQo+ID4gPiANCg==
