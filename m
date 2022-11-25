Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB5B638642
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKYJ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiKYJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:28:51 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321A932B83;
        Fri, 25 Nov 2022 01:28:40 -0800 (PST)
X-UUID: bd4d69f8b2b74a08813a47737512fdd2-20221125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=t93CaUVkhcPPloS2lLx9UvuNtPfWboPQUefVgukA81s=;
        b=oqD4+kWZ/nwFiPa32U59qvJ/hF/aGaDLSSzwjWgxKaa0kMmFC/UGq1YejcmX4OVRuiD28VMTjK1TSa72EYWS/pv20Ax1hbaOnpnuY2BPIjZCE/6m8YtTrMOW8wRg1wJKbPHVA5qCI6drJMoJHSxOtHhH1FMEs2C/eFqffF+3OjA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:15f7afbb-efc3-4629-beb0-940d3ab9d43b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:57864ef9-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: bd4d69f8b2b74a08813a47737512fdd2-20221125
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 680098161; Fri, 25 Nov 2022 17:28:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 25 Nov 2022 17:28:34 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 25 Nov 2022 17:28:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxbL2/v/Ac+PWtvC3GM61d3MIyOgZBN65uTg7WcaOKzAOEHOBUJpJdAs9h6CmHSoLQoAkL0Vh84IkRE2jzBfvQuYAlF51dRSHBeyJAeS274S6rALq5uLQnlrdPmca9yplL6xwj0LB5K8uWkqXRCG9toph02/X4IAUiWT6L1/STtsiSaD59Sipo04KPo1PlPB4h3/guqaS+DtVv73vh4PyTngm5w6mqLYbLeLEw2uInQiVsRyNzF+HkEb6n9EmF3uha0pa44gkTvCIv/RgUqwHgF6AJNcmrSIfldHquUfRM6+Yxrnig0RjLytYwvSVIxSsBycxu9e60gZLrGSXu+FTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t93CaUVkhcPPloS2lLx9UvuNtPfWboPQUefVgukA81s=;
 b=bU1kdEnIiMEn/UFpY4WUDkgoRBele6FLwMSMd6nBFMwGEtKZin/mf6bFt0ThCOIykLtyTEHD8v2RJaSUp5xgWCkaE1q5EcFBE9qjoHxvGl7SENGeVwmVV630IpXbpinC1n3+w/ILsRx2cRGsvhS/Rjqv19Ui9V3DuUknyAt7lu8rCH+cVRRO5WTu9sEbknCkphaA8w4UVOZjjpaVoWz+bYdjbE6wDIkWXhGXYWsmE0Vy9KhgZ/pE+P8T0iHvWX894y2C/FEvV9NyPubSsmDM19v5bjmW/SBu8Z37kLDOOtJ1/nGGOvCPD3TrwirGTPaJQTRDX1uLRfvlMH0ZOrK53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t93CaUVkhcPPloS2lLx9UvuNtPfWboPQUefVgukA81s=;
 b=ucTxdK7qQSy2o/aJ1Vl2xiWjxP84V3ruSb0KCRrEMLayXIMQY2aotPtVFkTURXyfdB2VIeRw3MuAXSIA50v7q3VhZIK7lmp8Tfhl4wDXznN1qTG56tBlDsNs8K9qhCAhbAIBS3Tu58/mXyx+oMJdykutwwadZVWYzHPaDeQelgs=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SG2PR03MB6681.apcprd03.prod.outlook.com (2603:1096:4:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 09:28:30 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::af56:be8f:f:85b2]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::af56:be8f:f:85b2%7]) with mapi id 15.20.5857.017; Fri, 25 Nov 2022
 09:28:30 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 1/2] media: dt-bindings: mediatek: Rename child node
 names for decoder
Thread-Topic: [PATCH v4 1/2] media: dt-bindings: mediatek: Rename child node
 names for decoder
Thread-Index: AQHY1L8dCAPwNN1uhkOBnORLrQwrlq34hoeAgAbmGICAAAK1AIAASq8AgE6F7ICAAADoAIABdjoA
Date:   Fri, 25 Nov 2022 09:28:30 +0000
Message-ID: <d22eae011186b9834b134c998b5d0d86168075fb.camel@mediatek.com>
References: <20220930112237.14411-1-allen-kh.cheng@mediatek.com>
         <20220930112237.14411-2-allen-kh.cheng@mediatek.com>
         <20220930220011.GA1107972-robh@kernel.org>
         <ffc56eb60a3ef74c815c8d3c170a0df51958e20d.camel@mediatek.com>
         <24361bea-ecfe-b6e1-e755-5151220767f2@linaro.org>
         <722194a3d413ca15069554ebab1f34dec25057eb.camel@mediatek.com>
         <de2198dd-16a7-f412-932d-a75cccf801e0@xs4all.nl>
         <3012ca1a-c583-4148-8a96-f9ecf61a07dd@linaro.org>
In-Reply-To: <3012ca1a-c583-4148-8a96-f9ecf61a07dd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SG2PR03MB6681:EE_
x-ms-office365-filtering-correlation-id: e6109f44-631b-4b1a-6194-08dacec76a63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MzUIkSa2mPyCz+VKEbKV0PvvHTzltljzlsqW/7B3a9OMpc+9F4hE6cIcBBmnJXVWhXGE0f2dC6PF2shhqFxulEIhYhrmrlKR+/IljqCmihlwfWbRr3Wew7PbJjIuOWpeewjRJRoKsLvR5YFvphCIL9VUxScUtiG3xsCOKejzG6Byj/wFY/acm8WcpUmLoh0njtrC8KqPSnBo4fxcamGYPldZdcJbyuEPbdGkViOfD0MtgDJ2ixllkUJMweMJacesqMzpv2R0N6oEjo0NBv2i6Vj5kR1va3X5wHB2wqmR1LtNltWOWwXzEGDXF+zGWCX2AdQeCWOoMGNak3kBJWjK+CoPnRogR2jjSrSp7QIpx17yS7fITNZbjAN7rH8SN+rTgvkzC2UclsFFrAn9k6vLn3hP0zm5Q2c3HAcIJbRcRw9SZeI35cE0EjyhubMTYYSvWbXUAqbD/0fZkkfgmvqvQ6YbPc0HQd+TkrmzlLh5Uwvbo8qJHVIY9bAfOkiORhIvI1BtSFkawX5pEVRlCZ3/4AEHcTUWni8FMh9HX101+yyfDq5bHm+oiI/ycKwdz6mjazdrmsVhGRatHTGcB31RJC8fNnbLt2l9yPjN6j5TbkMvIM7ewRqSij7bP5xYEJwRrBwDUJKE6iJeS1hV4yMib3QuJNJJXmC3M8rYPjSKevlKWmZu07nSoKQUDTI8UDWdai3VL1GAPpuAv649H7ofb1Pkt4KkUiZtmesJY3gO7tFixB8wprlY4wIg+n6Q9vcE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(186003)(36756003)(85182001)(86362001)(76116006)(2616005)(83380400001)(122000001)(6512007)(6506007)(53546011)(38100700002)(26005)(38070700005)(6486002)(71200400001)(41300700001)(4326008)(478600001)(66946007)(110136005)(66556008)(64756008)(54906003)(66446008)(66476007)(316002)(8676002)(5660300002)(8936002)(4001150100001)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckhJS0xlQ1FtOXZhUjZsT2g5Nm1tekszT1pyVW9MRGRmMnIyMmRmUHFZOW1h?=
 =?utf-8?B?NVM3YmVBTWQwU2hhMlRINVM4R3NKL2pmNjR2elJYY3RFRFoyd0FxVFVyZmhp?=
 =?utf-8?B?TUp1QXhiN2FJRktwOGRjeVJ1SWJOSmhnQUhvci8zVkRsekR2SWh5T2pGbHJ0?=
 =?utf-8?B?ckNTbDhOR2diZmJYZE5CZDJGc1RxSUpsbk1OVHJ4YW1aNW9jaHo4bHZueEZ2?=
 =?utf-8?B?VkN1MThhU2daSHBJSnpwOUpkQ01zcE1ON2pFb2RNc3IwVzR0Y0xJWmVURlZ1?=
 =?utf-8?B?cHNtazB0ajJBOEw1aU9wa1RYZWg5V3JrajFoVU1JOXpZOXJjYng5TGw3ZjA4?=
 =?utf-8?B?WnJKeTJGWlU4Z0hZUHErMEx4eUZMRFRuUG1zeklUUEJXS0lLWEVvYUgrY0I4?=
 =?utf-8?B?WE14ZW55ZFJLR1NuMGxrckdvaWlqVG8yak9Odk00SlA5WkNEb0ZNMnFhcCtK?=
 =?utf-8?B?QTBlYWdTMDJHYW5YOFlVY1RYdnhXb0F2WHdjVlV5aU5VSURteDM4ekJ4cjR4?=
 =?utf-8?B?Y3lsMUJMYS8vejZydytMRlE2bWNjdzVTa2R4Uk1RWTY1OWlobWs5Q2tzR2RQ?=
 =?utf-8?B?Qm44d0pPYXJvTGc5QmRaOXhabzJoamRMc0VsdUY5V1BkL2YrLzB4MGM3aEV6?=
 =?utf-8?B?QXgrMk5MS25HcklnU0tTWlBPWStLaXJiTHRVNGdyUUxJYkpnNVRkRmdlWnNN?=
 =?utf-8?B?ZGxHUUpyUXlsaWdjM2dFdHBYeXAzVE9kcmNtKzRnQTYzVlU4T2hrV0VnUk1o?=
 =?utf-8?B?c2preDdVbDdrM251SWxBQzVPNnVYUS8rVGs1TnBhTDh0ODRramFJWXFKYjUr?=
 =?utf-8?B?b1F2TmNUU0JTRXluV3Fvb1BlcVdMc1V4SVd5M2h4Y2xWbzNMMXUxNHc0SXJp?=
 =?utf-8?B?SVdLcXBCY3JWaFpCNktQS2Z6Vi93ZGlnUm1PRkpQTUNSRFMzZDhBampXZE9Q?=
 =?utf-8?B?OE5EUHR0OWRsQU9OcjRhOHNBa2k5OUE5UGthMlVlUnB1UWlBVjhDMUlUWjBi?=
 =?utf-8?B?cGNpeU04M3pvZ1BHR2NWODZyRWIrdDNXTk1mM2Yra3U5VWg4cGs0VmdxTmZ0?=
 =?utf-8?B?QkZacTk1a09kdXQ3NkZsZGRpQ20zbnZycDlLNG5DTWU2MmpmWlF2bXU5OVln?=
 =?utf-8?B?N1FkVmJscHFhY2tHOTNMUmdMaWdEZmpWOVJ1MUtIUDlVdTZSUDJRaThtQldm?=
 =?utf-8?B?TitPMjV5eVQzZEtzSEJZVDR4WWJZci9hdTdXb1p4cGVmYWlUQmhpUFpXQmI0?=
 =?utf-8?B?bVBFYWwrbUVheGtnMnI5MXFyejlTVHh0aXdsYTdlODV0ZktyU1MxNWhFK0pW?=
 =?utf-8?B?WHZEY0c2cjQxcjNTRG4xMkxpWmM2eVlSeURtTm9Sc0pvZVBKK1FDbTh6ZkJF?=
 =?utf-8?B?Uk55RElydjN4M2taYXEzREVGMEJuTmpId1RuZTl4ays3UlhJMjFtQmtaUzc1?=
 =?utf-8?B?dXpDVEdQdUJDQzZSakN0L3NsOHNpdVZvNlZvOCtINDdiY1NQQW1rTHlmaHFC?=
 =?utf-8?B?OVE2T2xJKys1U1lMYlBEdmlsOFpYaDJPQVlYMmV1MjZ0MTBvaEhGczQ3TDVV?=
 =?utf-8?B?TEZzT00waGI5N0JiWUgrcWxMYThibE5oQ3pDZklOVGdrTXRGclo5RjZvTnl4?=
 =?utf-8?B?UmxZeWFuWi9oR0ZCeEZxNzI4aUZlMENvenEwWXphRlhYNE8rU2xicmc3N1pl?=
 =?utf-8?B?bG10QUp6ZWRldkRmMEJ3WkdBclBzditTSUFFS3ZnMisraElkYmRBZ2taN1Nr?=
 =?utf-8?B?T3VNSC9qRHhwSnFYMlZ1SWpiaWp5NS9CSFRzdGgyODVrdVZlL3EyaCtHbkhp?=
 =?utf-8?B?TEU0K0VlZTg2cDhnbW4wbUNmTGs2c3pXYkpuVWoyczNSd1NIOFlnWGVKZTVU?=
 =?utf-8?B?cTUyZUZ3cWM3eXF2eVl4TWVwY1ZkdjdueDJUR2ZLQkVBajFDUU5ZZ2Vkc0Uw?=
 =?utf-8?B?N2ZScVBUU3piMjk0SWh5NmRFUE1lU1hILzNFSE05VExESWo1TlJiZ2tQWFdt?=
 =?utf-8?B?MVl2OVZzS0thWTlpanVxaFdxTloxQnd0Smc2SlFoZ2hNcndVL0lLMldWNTd6?=
 =?utf-8?B?eis0bno4aGlEZm8zekFGVVRUWFFiRDZQMXl2Wk5jZlc5K3pHYm5VbVM4MFdN?=
 =?utf-8?B?by9UVkRmcFpHU0gxTmQ2UVI4RGhyMUx4b1JmQStzYVR1UGtNdnpTL3lHbTZ1?=
 =?utf-8?Q?k2hhTdDzegC7hxHYjr4ONW4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <994CD4E00DF5214281F40E5D59131C3A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6109f44-631b-4b1a-6194-08dacec76a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 09:28:30.4901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHaWaosy5PBR98Xy3vbxUhjmm+nROcYGbnM5Tnc5nN1NS30bn81O5z09xyDhpfx9jOvjaN+GbeV5jxgffUBnLE/35T1ArgN1dVgLUgMmyRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6681
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTI0IGF0IDEyOjA5ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAyNC8xMS8yMDIyIDEyOjA1LCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+ID4gSGkg
S3J6eXN6dG9mLA0KPiA+IA0KPiA+IE9uIDA1LzEwLzIwMjIgMTM6NTgsIEFsbGVuLUtIIENoZW5n
ICjnqIvlhqDli7MpIHdyb3RlOg0KPiA+ID4gSGkgS3J6eXN6dG9mLA0KPiA+ID4gDQo+ID4gPiBP
biBXZWQsIDIwMjItMTAtMDUgYXQgMDk6MzAgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3Jv
dGU6DQo+ID4gPiA+IE9uIDA1LzEwLzIwMjIgMDk6MjEsIEFsbGVuLUtIIENoZW5nICjnqIvlhqDl
i7MpIHdyb3RlOg0KPiA+ID4gPiA+IEhpIFJvYiwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBG
cmksIDIwMjItMDktMzAgYXQgMTc6MDAgLTA1MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiA+ID4g
PiA+ID4gT24gRnJpLCBTZXAgMzAsIDIwMjIgYXQgMDc6MjI6MzZQTSArMDgwMCwgQWxsZW4tS0gg
Q2hlbmcNCj4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBJbiBvcmRlciB0byBtYWtl
IHRoZSBuYW1lcyBvZiB0aGUgY2hpbGQgbm9kZXMgbW9yZQ0KPiA+ID4gPiA+ID4gPiBnZW5lcmlj
LCB3ZQ0KPiA+ID4gPiA+ID4gPiByZW5hbWUNCj4gPiA+ID4gPiA+ID4gInZjb2RlYyIgdG8gInZp
ZGVvLWNvZGVjIiBmb3IgZGVjb2RlciBpbg0KPiA+ID4gPiA+ID4gPiBwYXR0ZXJuUHJvcGVydGll
cyBhbmQNCj4gPiA+ID4gPiA+ID4gZXhhbXBsZS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
VGhleSBhcmUgZWl0aGVyIGdlbmVyaWMgb3IgdGhleSBhcmVuJ3QuIFVudGlsIHNvbWV0aGluZw0K
PiA+ID4gPiA+ID4gZ2VuZXJpYw0KPiA+ID4gPiA+ID4gaXMgDQo+ID4gPiA+ID4gPiBkZWZpbmVk
LCBJIGRvbid0IHRoaW5rIGl0J3Mgd29ydGggdGhlIGNodXJuIHRvIGNoYW5nZS4NCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFsbGVuLUtI
IENoZW5nIDwNCj4gPiA+ID4gPiA+ID4gYWxsZW4ta2guY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+
ID4gPiA+ID4gPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+
ID4gPiA+ID4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4g
PiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiAgLi4uL2JpbmRpbmdzL21lZGlhL21lZGlhdGVr
LHZjb2RlYy1zdWJkZXYtDQo+ID4gPiA+ID4gPiA+IGRlY29kZXIueWFtbCAgICB8IDgNCj4gPiA+
ID4gPiA+ID4gKysrKy0tLS0NCj4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBk
aWZmIC0tZ2l0DQo+ID4gPiA+ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21lZGlhL21lZGlhdGVrLHZjb2RlYw0KPiA+ID4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gPiA+
IHN1YmRldi0NCj4gPiA+ID4gPiA+ID4gZGVjb2Rlci55YW1sDQo+ID4gPiA+ID4gPiA+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLHZjb2RlYw0KPiA+
ID4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gPiA+IHN1YmRldi0NCj4gPiA+ID4gPiA+ID4gZGVjb2Rl
ci55YW1sDQo+ID4gPiA+ID4gPiA+IGluZGV4IGM0ZjIwYWNkYzFmOC4uNjdmZGU0OGY5OTFjIDEw
MDY0NA0KPiA+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVjDQo+ID4gPiA+ID4gPiA+IC0N
Cj4gPiA+ID4gPiA+ID4gc3ViZGV2LWRlY29kZXIueWFtbA0KPiA+ID4gPiA+ID4gPiArKysNCj4g
PiA+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVk
aWF0ZWssdmNvZGVjDQo+ID4gPiA+ID4gPiA+IC0NCj4gPiA+ID4gPiA+ID4gc3ViZGV2LWRlY29k
ZXIueWFtbA0KPiA+ID4gPiA+ID4gPiBAQCAtOTEsNyArOTEsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+
ID4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gPiA+ICAjIFJlcXVpcmVkIGNoaWxkIG5vZGU6DQo+ID4g
PiA+ID4gPiA+ICBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiA+ID4gPiA+ID4gLSAgJ152Y29kZWMt
bGF0QFswLTlhLWZdKyQnOg0KPiA+ID4gPiA+ID4gPiArICAnXnZpZGVvLWNvZGVjLWxhdEBbMC05
YS1mXSskJzoNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSnVzdCAndmlkZW8tY29kZWMnIGRv
ZXNuJ3Qgd29yaz8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoYW5rcyBm
b3IgeW91ciByZXBseS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBobW0sIEkgdGhpbmsgJ3ZpZG9l
LWNvZGVjJyBkb2VzIHdyb2suDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhlcmUgYXJlIHR3byBz
ZXBlcmF0ZSBoYXJkd2FyZXMgZm9yIHRoZSBNVEsgdmlkZW8gY29kZWMuDQo+ID4gPiA+ID4gY29k
ZWMtbGF0IGFuZCBjb2RlYy1jb3JlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IElzIGl0IG9rIHRv
IGtlZXAgdHdvIGNoaWxkIG5vZGUgbmFtZXMgZm9yIHZhcmlvdXMgaGFyZHdhcmVzPw0KPiA+ID4g
PiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gQXJlbid0IHRoZXkgc3RpbGwgY29kZWNzPw0KPiA+ID4g
PiANCj4gPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+ID4gPiBLcnp5c3p0b2YNCj4gPiA+IA0KPiA+
ID4gWWVzLCBUaGV5IGFyZSBib3RoIGhhcmR3YXJlIGRlb2NkZXJzLiBMYXQgaXMgcmVzcG9uc2li
bGUgZm9yIHRoZQ0KPiA+ID4gYml0c3RyZWFtIGFuZCB3cml0ZSB0aGUgb3V0Y29tZSB0byB0aGUg
bGF0IGJ1ZmZlci4gQ29yZSB3aWxsDQo+ID4gPiBkZWNvZGUgdGhlDQo+ID4gPiBsYXQgYnVmZmVy
IGFuZCB3cml0ZSB0aGUgb3V0Y29tZSB0byB0aGUgb3V0cHV0IGJ1ZmZlci4gRWFjaCBmcmFtZQ0K
PiA+ID4gd2lsbA0KPiA+ID4gYmUgZGVjb2RlZCBjeWNsaWNhbGx5IGJ5IHRoZXNlIHR3byBoYXJk
d2FyZSBkZW9jZGVycy4NCj4gPiANCj4gPiBTbyBpcyB0aGlzIHBhdGNoIE9LIHRvIGJlIG1lcmdl
ZD8gT3IgZG8geW91IHN0aWxsIHdhbnQgY2hhbmdlcz8NCj4gDQo+IFRoZSBwYXRjaCBzaG91bGQg
YmUgY2hhbmdlZCBhcyBSb2IgcG9pbnRlZCBvdXQgLSB1c2UgInZpZGVvLWNvZGVjIg0KPiBuYW1l
Lg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCk9rLCBJIHdpbGwgdXBk
YXRlIHRoaXMuDQoNClRoYW5rcywNCkFsbGVuDQoNCg==
