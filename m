Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D0968674B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjBANn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjBANnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:43:24 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA724942A;
        Wed,  1 Feb 2023 05:43:19 -0800 (PST)
X-UUID: 5fe16a6ea23611eda06fc9ecc4dadd91-20230201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9T3gVj5MCmgZfpATml4OPnQVR2ANxNl82opbFLmByKs=;
        b=OT7t1Epy3AVtC0UPYpfr+SLGy4ITn0H0jBuXnRJTADcHTEEt0WqNJwSMqv0Udcje0xkv9yI57P7Rz0CmmBneQ3KLsQAx+Qxj+tuiMPRiiHBp35lxPsxhk3XgpFH4aNyExxDfDzczAp5wNoK3yFi8D7uZ4QdnxkB2j+0HGZRWdzE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:63041308-4cba-452a-8f63-2851bf18c6cc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:2513998d-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 5fe16a6ea23611eda06fc9ecc4dadd91-20230201
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1104140171; Wed, 01 Feb 2023 21:43:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Feb 2023 21:43:12 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 1 Feb 2023 21:43:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBIVcTecB+8+X/MQAZBhHAr5lfAU5egLmrljCEg84S4na4fKw4202obAuaqYc42Qu5QF/WA4OR1mNO1Xw1yNqiFrZqa+Z3nMVtO4f0xpMLPz/rfuwWNj+WEnMrn6KIT7jZts94LvcgP08Rn1qWx3yghdy3KwDwrbxJ8D2k923XM2d7sO0etdi7ZfmqJpkigBEKL/nOlZ066c85x2yyWGeF2u9SJ1aFdUJZLUqxitEJEQMK2KLGN2rRyJMjnL3zaJwyT/L9eI1kt7wKc4fs3UtuNf+2uy+uhMDyWkAFUbwvadpG6KZgqZXcgTd15dqdkVrNdCHHM6iPHe9QJhWlSyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T3gVj5MCmgZfpATml4OPnQVR2ANxNl82opbFLmByKs=;
 b=VDhrTQTuJU78H19PhlpIzZ5Ix9UubfXW9a5aYBuhYWMpvPTUVrw1G8FiU4vQOqMa/fmNJIoFK5PYXtbYGOju+eY2oym1Z+VtEpOWXet4FuB2B+ntzAMgzcC3DEPW2SbuOHnrCjd9EovGsXcgsKwAMPHg0ugjIZ3nsmnoF10IvgXnQ4Hz5ROgw9IBZXSIu/tcURKg972XlcxSDhj8GhwocBDkG5ksDDldwJIKAxdsp6Mtji/U3csvScNKTFh5IqiyDDAvxhXUCkFIEjpLkDsUCqbCw/BWoMFqHSKzdoaP4Qu6xqZXBw5gucYOnBbV7DwCUhF/px5yOr/iPFvuHcl+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T3gVj5MCmgZfpATml4OPnQVR2ANxNl82opbFLmByKs=;
 b=ZegjiXagigKagr00qmgDFSw9IAAJJJVHhIvPxy5ZLbYWLz23Voi+ip8YSdhpn/Aq2d7dnE7zqOyV5p5y4xEHb6KUWDhq7pmOC2DyM7DxXhr/c79gqzLDzw1hyMMt994PhCo4c5MX0cHodSnHiKDpVsdTRJjs8Q/pV6qOLu6XnW4=
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com (2603:1096:4:26::14) by
 TYZPR03MB5357.apcprd03.prod.outlook.com (2603:1096:400:32::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Wed, 1 Feb 2023 13:43:10 +0000
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::42eb:28a2:4d2e:d051]) by SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::42eb:28a2:4d2e:d051%5]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 13:43:10 +0000
From:   =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>
To:     "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "drinkcat@google.com" <drinkcat@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "ribalda@chromium.org" <ribalda@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>,
        =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>
Subject: Re: [PATCH v4 03/14] soc: mediatek: mtk-svs: enable the IRQ later
Thread-Topic: [PATCH v4 03/14] soc: mediatek: mtk-svs: enable the IRQ later
Thread-Index: AQHZJZDI4tt6EG80NEWLuUinejN5Fa64nJqAgAGegAA=
Date:   Wed, 1 Feb 2023 13:43:09 +0000
Message-ID: <715873f9acb975aa8a6a21fda372b00dcc5c137a.camel@mediatek.com>
References: <20230111074528.29354-1-roger.lu@mediatek.com>
         <20230111074528.29354-4-roger.lu@mediatek.com>
         <561d9a97-64c7-6633-ff10-d85ae2c7f314@gmail.com>
In-Reply-To: <561d9a97-64c7-6633-ff10-d85ae2c7f314@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3434:EE_|TYZPR03MB5357:EE_
x-ms-office365-filtering-correlation-id: ac8131e9-d411-4a3c-b9de-08db045a41cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xAI5fUH3PNMFmgIBTJfbLHOiUIxmG4D4pN6e0pZLHTM2O0ZJGztH2q/n5JB/CsIyjJcxXDGpuG5pFNYQApPtEoBW9SsGp5ObEnLjZGE4zekppnDph68+SGnTBdtSoouEpDTOjdJkyCmh8qyDsSUeM5uMk98NdiqYSxTMUTLAP6q30vQNveT++eYtRkn+vPtmLrWSi7h3AGOtkAMaRcc33H1QfAuza8qLNuAf+cW657C3nZtZwo0AKnHC2ogg4E05D22f0nCS3SGJ5UcPMxl/3thA9APF8A3CHEXwD6zO2ZjFyZsyA9HBuZRHefycLNb5fYNd2GhJ+8Cjaa5gPq/b5pPJNzYZnPyXcHCuQ8MFfafqIdZ1ZyjZdHm6Wuk3hIGxp4YwHNM1PyVrhFFLUGqLvmqNdTEyp/g6dV2ksXt8OvuqiAsgXqojhI/xYGp4P0SQY0u/rsJqsxUYWgv8RvWSCPEcnkL7G+axFy8eOL4kuIKKQ2KDT3F+gyE8QHJ0L1UGaJL0LTaOO5TUafs8N2mbwGZp8fO/feLQC5NLlf2BTTo8PzKzAj9Od6pamBhdMD5lRuS1dRwSoIux8Nrek1npxOFNqoUZfeAGiS/5bu/RFl3iVvSkODfF39VBFdz8LyizxPKkWW9e/oozwSgnF6R8+1UgyA+nMViVraJYiafjDwQ/ZAvaFw7SzqaBS1ZNQQuBuJ/DiKNukUVxwf+uqZB4zAl3a3odl06frtxws2UlkqKUcNeRFRlr4rmxgJ/ApDlEGxeHzCxnli6DkJ+sNsDHFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3434.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199018)(83380400001)(66446008)(76116006)(66476007)(64756008)(66556008)(8936002)(41300700001)(38100700002)(122000001)(66946007)(4326008)(2616005)(8676002)(38070700005)(26005)(6512007)(110136005)(86362001)(54906003)(966005)(7416002)(53546011)(6506007)(186003)(478600001)(316002)(107886003)(5660300002)(2906002)(71200400001)(36756003)(85182001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1pQUFhEdlhIZ1N5TXlmWTBiSW9DL0NDYXN0VGhkZlg4bjdyYnI0aityQXBx?=
 =?utf-8?B?SmY0MkVweHA5Rlg3VGxoc1l5WkZrTG13MVpXa1VYZWVrdi9FNGZlWFFYYmJn?=
 =?utf-8?B?RFk4MGtPMitZM2VrTGVJd0JtczYvVzZmQXdRVDBOMWgwdVhkaEJOZnA1Vlpr?=
 =?utf-8?B?QVlDSVFlcUZ0cHlhb2dndTBBdWlVd3E2ZGVMZjVnR3U5am9TcTZFc3ExdUVx?=
 =?utf-8?B?MUVCd0NScVN4RXdKckZ2cVlGWFFFMXI1N2F3N3IvRGlZVjJvVTFRajNSZTN1?=
 =?utf-8?B?VG9tZXNUWGlyeUtBeEI5T3VVQmlWbVlsUk5GQm9TNVhxR1p0UzFnNnZhVWd2?=
 =?utf-8?B?UHZJTDJGbkREWnJqakg2SGRSaUNhK1BsOHNsbjdXMmpkUEFnR0ZNZEVIaDZz?=
 =?utf-8?B?RHFVOEJDb2x0bmsra29wOURqY01MVTNQdlZkR3hZMHN4WGRXek00WXlHRllD?=
 =?utf-8?B?SzgrRzUrbUY2Rmk4dnVlR3Y2bndLYVJnMnFLWW9ObTVQZFVxUG4zcUFwRjJl?=
 =?utf-8?B?Q3d3cXNSNWYxL2RwYVpZNEo3enlFSmFob3FkR2dqempPN0sxWG9VaDhpcHpT?=
 =?utf-8?B?bE45Y0JFU000YnUyMlJGOW8rS0FENzhSenUxd1RWNnkzN2RpWHNqcmZSYjlM?=
 =?utf-8?B?a3JGMm1jQ084cHNQcmg3TkRzMHptVkhOR0lyR1hIYTdwL3JLdVpoZHU5dU1r?=
 =?utf-8?B?Q2hHb0Z6bTlmVFl0eVo5ZEJNa3hYUVgyQTFzUURSVG1KOUtnMFZsdnZoU3I5?=
 =?utf-8?B?eW1DMDRTMW5vNHY2UHFMbnRqajlSUWdhd2VUZDBZOFd2Vm8xbUtHQmJyMzR6?=
 =?utf-8?B?MU0vR2l4SjVRUC9YUkFBOGpMRk9FbVNGNy93UHVSamUwMmlMOVRHUy9mVjA1?=
 =?utf-8?B?NURiYlo2OHR4dHBOMmo1MG0vbVFKTHh2c1dNeVRRK01tZk1uZjYycENCcFE0?=
 =?utf-8?B?RWdsU3pjaEt4Nlh6OFNpdnRTRHo1RkdWU051V0xZZFBYZHRpWk5kdlNzUXBu?=
 =?utf-8?B?by82VEFtUkpnRUhQZzAwV3Bwb09HYmVjOXlTWHpkVXBuaFR4VnRGUFFhMHhZ?=
 =?utf-8?B?MnFaL2ZIMk1YeFUzRXlXWXh2RTRnTlluV0Q3ejdOK0Z1em1oTkV5am1KaGxu?=
 =?utf-8?B?RTZ2N0U1S0dFbU9CVXc0ZE5GbVR0eWRZOTNoSUh1NDZIaThqeFhlandaTTgy?=
 =?utf-8?B?UDZhdFBoN3BHazE0cEwvUitjTVBSMU1rYUpkOGc5MnJwSzJoU3kyUllSNEZC?=
 =?utf-8?B?OVBGcUtKa2o0UnBXNDRwbERYbDV3am5CU3ZzR0x3eFpXMFU4REU3bm40RmxL?=
 =?utf-8?B?TUxrN044K0NOejlkN1VmbnZPajZsRUlKTnIrYVF1ODEzcTRNY01GTHdnOVl4?=
 =?utf-8?B?TXBQMzQ1Vm92dUlWZ2ZxamVrR05BY01rbS9BZTR0aGJoWXBXUnFtcHBEcXJi?=
 =?utf-8?B?bm8vNGlUZzhnd3FBdldKOUhTeFlKdDhtWFM1Sm1jczVOZnVIRlNSWGxDWXo0?=
 =?utf-8?B?R1VpUzJEbStPTi9CQ0tkZXFMZ21QaGNBZkF1UFVGMEhPaHltcGIzL3dpQWdN?=
 =?utf-8?B?c2srOWh6TmJOYjhveGVyYVRRZ1lwMFhKb1ZjMnlFR25zZ1Jvc0h6TGEvdUpV?=
 =?utf-8?B?VFBib1dINW9EUk9aOEhQZGtIUTFQaHJnTXVSWUtOZTlGMjJaQTRuNUI1Zmk4?=
 =?utf-8?B?c2wrN1JxdXRmTFAzR0JBU2dQZjZmcEx3UUtjNjNJT1h2VDgreFREQ0VaeUxF?=
 =?utf-8?B?OXA1dTZGYllocEc3eVFBY2dtUWFEMmxhWFV3Nnp6Y2Y3QnkvQmk4eUtrK1JL?=
 =?utf-8?B?NkNCY0pmMHRtMk5TSW1FaWM2cm4xbUdGM0VGcUxxVHhFbGxpbEhVcnQwSnpo?=
 =?utf-8?B?TUwwSVZzNzVyTndRL0JiWFNlMGRlMk85aW5WVE43NE1kSzhMSkRsVzdKd0ZC?=
 =?utf-8?B?bkxGTitvRXNsdFdnWjVvdXQzSFBwd1ljN2xoVVBPT2kyYnltRGpIL3QrUjBX?=
 =?utf-8?B?SDkvYWFPTzZzMlFaUVQwV2ZBR3hsRG9OTzJKL2RFNHZLVGNaUjlSdVhhMW9v?=
 =?utf-8?B?aTNabzRRUmJRZ3lsb3BCS0NxVVllODF4cFVkbG41ZUZadHBYYWY3dzBpZHlr?=
 =?utf-8?B?YjUxeFZFNFExZmVTNUJheFcrZ3hxbGFZV1dvZDgvTUpVeVp0WlJGOUUvdjhW?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9F77D045C38DF4C84D69197C90812BF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3434.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8131e9-d411-4a3c-b9de-08db045a41cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 13:43:10.0132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9T88qQaj/9VKSsmZRl5gXFJGMM4zxQ+lEG/P/tVeTDE9ZGfMqvPDL4vVVSH+URsOq2zv+1y3glK70ohuJEqACA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMgU2lyLA0KDQpPbiBUdWUsIDIwMjMtMDEtMzEgYXQgMTM6NTkgKzAxMDAsIE1h
dHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAxMS8wMS8yMDIzIDA4OjQ1LCBSb2dlciBM
dSB3cm90ZToNCj4gPiBGcm9tOiBSaWNhcmRvIFJpYmFsZGEgPHJpYmFsZGFAY2hyb21pdW0ub3Jn
Pg0KPiA+IA0KPiA+IElmIHRoZSBzeXN0ZW0gZG9lcyBub3QgY29tZSBmcm9tIHJlc2V0IChsaWtl
IHdoZW4gaXMgYm9vdGVkIHZpYQ0KPiA+IGtleGVjKCksIHRoZSBwZXJpcGhlcmFsIG1pZ2h0IHRy
aWdnZXIgYW4gSVJRIGJlZm9yZSB0aGUgZGF0YSBzdHJ1Y3R1cmVzDQo+ID4gYXJlIGluaXRpYWxp
emVkLg0KPiA+IA0KPiA+IEZpeGVzOg0KPiA+IA0KPiA+IFsgICAgMC4yMjc3MTBdIFVuYWJsZSB0
byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsDQo+ID4g
YWRkcmVzcyAwMDAwMDAwMDAwMDAwZjA4DQo+ID4gWyAgICAwLjIyNzkxM10gQ2FsbCB0cmFjZToN
Cj4gPiBbICAgIDAuMjI3OTE4XSAgc3ZzX2lzcisweDhjLzB4NTM4DQo+ID4gDQo+IA0KPiBUaGlz
IHBhdGNoIGlzIGRpZmZlcmVudCBmcm9tDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAy
MjExMjctbXRrLXN2cy12Mi0wLTE0NWIwNzY2M2VhOEBjaHJvbWl1bS5vcmcNCj4gDQo+IElmIHlv
dSB0aGluayB0aGUgcGF0Y2ggZnJvbSBSaWNhcmRvIGlzIHdyb25nLCB0aGVuIHlvdSBzaG91bGQg
aGF2ZSBtZW50aW9uZWQgDQo+IHRoYXQgaW4gdGhlIHJldmlldy4NCg0KTXkgYmFkLiBSaWNhcmRv
J3MgcGF0Y2ggaXMgY29ycmVjdC4gTW92aW5nIHBsYXRmb3JtX2dldF9pcnEoKSBicmluZ3Mgbm8N
CmZ1bmN0aW9uYWwgY2hhbmdlIGFuZCBpcyBmb3IgaGVscGluZyB0aGUgc3ZzIHByb2JlIHJlYWRh
YmlsaXR5IGFzIG15IHByZWZlcmVuY2UuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQo+
IA0KPiA+IEZpeGVzOiA2ODFhMDJlOTUwMDAgKCJzb2M6IG1lZGlhdGVrOiBTVlM6IGludHJvZHVj
ZSBNVEsgU1ZTIGVuZ2luZSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBSaWJhbGRhIDxy
aWJhbGRhQGNocm9taXVtLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBMdSA8cm9nZXIu
bHVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LXN2cy5jIHwgMjggKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc3ZzLmMgYi9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstc3ZzLmMNCj4gPiBpbmRleCBhODAzYjkyYWZjM2QuLjY0ZDRkMDNhYjcxYyAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc3ZzLmMNCj4gPiArKysgYi9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc3ZzLmMNCj4gPiBAQCAtMjQwMywyMCArMjQwMyw2IEBA
IHN0YXRpYyBpbnQgc3ZzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
ICAJCWdvdG8gc3ZzX3Byb2JlX2ZyZWVfcmVzb3VyY2U7DQo+ID4gICAJfQ0KPiA+ICAgDQo+ID4g
LQlzdnNwX2lycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+ID4gLQlpZiAoc3ZzcF9p
cnEgPCAwKSB7DQo+ID4gLQkJcmV0ID0gc3ZzcF9pcnE7DQo+ID4gLQkJZ290byBzdnNfcHJvYmVf
ZnJlZV9yZXNvdXJjZTsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gLQlyZXQgPSBkZXZtX3JlcXVlc3Rf
dGhyZWFkZWRfaXJxKHN2c3AtPmRldiwgc3ZzcF9pcnEsIE5VTEwsIHN2c19pc3IsDQo+ID4gLQkJ
CQkJSVJRRl9PTkVTSE9ULCBzdnNwLT5uYW1lLCBzdnNwKTsNCj4gPiAtCWlmIChyZXQpIHsNCj4g
PiAtCQlkZXZfZXJyKHN2c3AtPmRldiwgInJlZ2lzdGVyIGlycSglZCkgZmFpbGVkOiAlZFxuIiwN
Cj4gPiAtCQkJc3ZzcF9pcnEsIHJldCk7DQo+ID4gLQkJZ290byBzdnNfcHJvYmVfZnJlZV9yZXNv
dXJjZTsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gICAJc3ZzcC0+bWFpbl9jbGsgPSBkZXZtX2Nsa19n
ZXQoc3ZzcC0+ZGV2LCAibWFpbiIpOw0KPiA+ICAgCWlmIChJU19FUlIoc3ZzcC0+bWFpbl9jbGsp
KSB7DQo+ID4gICAJCWRldl9lcnIoc3ZzcC0+ZGV2LCAiZmFpbGVkIHRvIGdldCBjbG9jazogJWxk
XG4iLA0KPiA+IEBAIC0yNDM4LDYgKzI0MjQsMjAgQEAgc3RhdGljIGludCBzdnNfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgIAkJZ290byBzdnNfcHJvYmVfY2xrX2Rp
c2FibGU7DQo+ID4gICAJfQ0KPiA+ICAgDQo+ID4gKwlzdnNwX2lycSA9IHBsYXRmb3JtX2dldF9p
cnEocGRldiwgMCk7DQo+ID4gKwlpZiAoc3ZzcF9pcnEgPCAwKSB7DQo+ID4gKwkJcmV0ID0gc3Zz
cF9pcnE7DQo+ID4gKwkJZ290byBzdnNfcHJvYmVfaW91bm1hcDsNCj4gPiArCX0NCj4gPiArDQo+
ID4gKwlyZXQgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKHN2c3AtPmRldiwgc3ZzcF9pcnEs
IE5VTEwsIHN2c19pc3IsDQo+ID4gKwkJCQkJSVJRRl9PTkVTSE9ULCBzdnNwLT5uYW1lLCBzdnNw
KTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKHN2c3AtPmRldiwgInJlZ2lzdGVy
IGlycSglZCkgZmFpbGVkOiAlZFxuIiwNCj4gPiArCQkJc3ZzcF9pcnEsIHJldCk7DQo+ID4gKwkJ
Z290byBzdnNfcHJvYmVfaW91bm1hcDsNCj4gPiArCX0NCj4gPiArDQo+ID4gICAJcmV0ID0gc3Zz
X3N0YXJ0KHN2c3ApOw0KPiA+ICAgCWlmIChyZXQpIHsNCj4gPiAgIAkJZGV2X2VycihzdnNwLT5k
ZXYsICJzdnMgc3RhcnQgZmFpbDogJWRcbiIsIHJldCk7DQo=
