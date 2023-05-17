Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C09706867
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjEQMmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjEQMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:42:12 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D715F10C6;
        Wed, 17 May 2023 05:42:07 -0700 (PDT)
X-UUID: 392af2e2f4b011ed9cb5633481061a41-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=d31Oh9Pu2cQh5tsEeN65ofIUruTSXl96fVRjtF+KXgw=;
        b=SGRobRippXBWAPBCJVyevjag5Yszn8h8ou7mbVG875hDfd/nDxleap5ZsHm/LowN0SAj8gzNa9BDTbcMmCH4MDsXv3hJJfGlwwIZh7f05m2Q5micvPEiM4sbq0U+QaTNvocPMZ85PUgMtUj/AscK3OMYv5CmNOgC9PGPmo7f0BE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:28853509-9b98-4d26-b8ba-0d3c1c98e1d0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:10ad1f6c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 392af2e2f4b011ed9cb5633481061a41-20230517
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1218584027; Wed, 17 May 2023 20:42:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 20:42:01 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 20:42:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4vryU8COl7LaNgY23bHv+VzGG9FlHAmTVbOKbU6SkFJUkHGFeGzxJZQ0XD1mGNb+poWU+GqrX85cNx6lHdxAdGrC9nSRShQWKDOdgp01aTBtx+uCc2hYESVwOp8q5Uw/VdrlfKj4FiMZnY5cUDqkIFkgL4egNZsNikJ+pCrLH3K8pnIcsryWkUJI1/PHe6eFLtXlAItjm8x2rfv0uQyf6Xp21fSIOKoDRvPfQ+05aGEi3ElRKW/YvabmewxPpHwzR4XxKAA43y2RkPOapvtHVtF2nbLyEocIf7gph7xRCNcWPGJjP242qAh8sIdxxpvc6mV/tX7fPeC3MNO9pJJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d31Oh9Pu2cQh5tsEeN65ofIUruTSXl96fVRjtF+KXgw=;
 b=MarsOdW2XM9w05KmUrKO2HRa48Gv9i/ej166V/QG9F2cPW5ZX1C3j7C2GEoS8KjJWbtF1m4dwzGmZ3HlcRr4xcPAZPiwzDDoy7cTAdFUnN2jZXqAAbOsuh7xJDKXEhCb/2mlqPFy1Sqc2vRrsnbX/o1WuhDc4QZNxO0YkNHHbBvxjCn6c57kFIDf4VpXIfZs5N+itzveAnCF0XGeP/je3afTO/4vvSZlxFIFoOYCM9s4HtAV/BJDmijmTI9D3tvW1zJG1esnf97qaZjD5nlYoA0wWH8q3xfp25M1jqeisFB6gumlAuNWZ/X89fD/n3gMauDKRHwYKcPgIwbpIyrOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d31Oh9Pu2cQh5tsEeN65ofIUruTSXl96fVRjtF+KXgw=;
 b=XLGZPSePkfm2dJ37iv2gyLYJmXKW86pqqirUb2WzPd9lv5gQOfdvK4wq0tYHSOIGF7sDzPDetmK1+OcpQgdZGjNQ3pBGXkSoCUaBrf80ZG/jMv0jbjNwP+sbnL5VTITZ9/DeN2WEuh1sVsJ7sDk7T4Llowk6eN7SIgGatpQTTnQ=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SG2PR03MB6587.apcprd03.prod.outlook.com (2603:1096:4:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 12:41:59 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 12:41:59 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/5] ASoC: mediatek: mt8188-mt6359: support new board with
 nau88255
Thread-Topic: [PATCH 4/5] ASoC: mediatek: mt8188-mt6359: support new board
 with nau88255
Thread-Index: AQHZiLER8lE90S3mb0S+zbaIQd5M169eWzUAgAANV4A=
Date:   Wed, 17 May 2023 12:41:59 +0000
Message-ID: <c24d9d21aae0977c98f4901692ec2dc12122c2d8.camel@mediatek.com>
References: <20230517111534.32630-1-trevor.wu@mediatek.com>
         <20230517111534.32630-5-trevor.wu@mediatek.com>
         <8b76c893-e7bc-7a99-b86d-74e3378f9b4e@collabora.com>
In-Reply-To: <8b76c893-e7bc-7a99-b86d-74e3378f9b4e@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SG2PR03MB6587:EE_
x-ms-office365-filtering-correlation-id: d54c9113-09a0-496f-740f-08db56d41b5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UYaqVkER19ZUYIsiWELKWT3a8Wp3TLwKVLlwRyTst7PocZZMYYSG4L0QBkywARaSjcRFf6uEvZirwZUDINTYlIMyEOIQJwD1daVy6tAhPlcZhjEW/M1S6lv0+P+pMJ6mlax5buWLCCmAP8Nk94x7UhDQ4Ay92rVmpNO26A0w1kNfrvnz6n8cxF1PbnRPCiFs+RjSjidnErr4XClTOo5g31bm9wuyx9fCskjB90Gca0e7sXOEpaal4tWjORgmTDM02u751k1A0ey/wD1GQB1KtAsdk1f5y/RVW2qVCe3WixeCoQ/xT+sKNB4Ocn82G/xQMHNHTUWTjDXu9xeWLvxPJwFJ+wor0EpAmCflDQRlx87HWK6xash5Jc5dxrUoCxCNSLdldK0yiSYYhuUj27rURAPsEw90zZnnwzTkaV08dRheTtKNyllew/LgUrfcApcDplOwJLkzHc81WECF0wwfUCXYn5XuqE9a7c1ea2zpOBbvjYj4JF2Fzr21lMzE9IhP7AvgMSIhfoB1VmS7cdtciUOk0REXFAM8VJO6vSVMxarYYCxdJouicaTPbMwDHm3MwVLXSgmyTGI/rNS2wZZPGM7lHFGcgjPLsn4TycW7oAx0Io1eJvWrpBjH4jJuUvT5Y2qN75T8q+N1pXNowxkIwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(91956017)(2906002)(7416002)(8676002)(8936002)(5660300002)(64756008)(66476007)(66946007)(76116006)(36756003)(110136005)(4326008)(85182001)(316002)(54906003)(66446008)(71200400001)(41300700001)(478600001)(66556008)(6486002)(2616005)(86362001)(83380400001)(26005)(186003)(6506007)(6512007)(122000001)(38070700005)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEUvcVFFaGpqVkVVTXZBZkxGWUNHNXhkMVg1aXFOWksyanRDK0dWQjV3Rmdh?=
 =?utf-8?B?SmQvd0M5WXlMeUpkVzR4UWFGMWs3NUE2VDJUejk0MjZLMWIvMjJtMG1IWlpZ?=
 =?utf-8?B?NjFmZk1rV1dZUUtuK2oxVmZKbG42ek1mN0xsdERndndEWm9uUGUrMVo0Tisv?=
 =?utf-8?B?emZjNHMxbVFMRTVKc0hySWR5bzhhcjVjYStnNzF6SE5GTXA3Qy91aEYvTlVu?=
 =?utf-8?B?cHNRU3NqdUtmUTFIYjN3eXRZS0h2YWZFK3YxTFZJRG41YUZMWDhZMnMyc1ZQ?=
 =?utf-8?B?ajBCRWZqS3hmOXVSRSt6RnVIY3dXcWlBditla1NCL3loT1hyNER3WDBXVk8w?=
 =?utf-8?B?R1B0VmZGSloyOEx0V29UNzFpemVveFJLai9wWVpMdmR4Wm4zVmV3VXQ2bHV5?=
 =?utf-8?B?WEdrUUJNYkMrSVhhMWNjVmZOVzVDaWN3SHJSMkgrK2Rqb1A4Mll6Vi9DUElp?=
 =?utf-8?B?OTl4VmNMOTA5QWZvM1E4MTB5MW5hUDZOaUxReWV2UTU2Z2NsbTYrQlRPKzFX?=
 =?utf-8?B?emRTbXNrZ0poeHpyMFhkbzZjakRPN1U3UUJYWmRGOHd1NmwvdU9ZVEhBekhH?=
 =?utf-8?B?eFFCbmpmbDhrV3Y4am5La042eC9pZUE2ZURtQU92a1VqY0kzR0xEaFpHTlBE?=
 =?utf-8?B?YXRUcmkyektLaHcvakFyclJtUElRMnZuSWNuZDNMQTBSMlp1MWY2ODNTeDNN?=
 =?utf-8?B?djJtMmVzVDN5dVpIWkgwYmZaWml5Yi9qK0loeHY4eFl3dnhwSjM4aVgwK1ZX?=
 =?utf-8?B?Y2hvOTY0a2c5ZjRVeU9kMFVDTDgrU0VFbWdYRGxWcmVXa2xhTkg0b1MxK2la?=
 =?utf-8?B?OERvM3p4N25OTDdmNVlVNUFVSTliZzJGVUtCUDVQQStSMVZxMHF1a3g3cFVF?=
 =?utf-8?B?WERablAzR3N1V09FbnFlQU5sekV6SFdHVE50WUdFQVhibi9CNDFQL0xNcUtF?=
 =?utf-8?B?TERDblovZnlFc1I5cXFRTE5ra3NjUEtBaCtVeEhqd1A5WWFJYTBQelNDa1NS?=
 =?utf-8?B?cnIxRWg2cXJ3Q3prQXZQQ0F0WDNXMXJ3L3U1NHBLVk1NeUZnN05kZUtwcUlw?=
 =?utf-8?B?QTZiZkxqRzd2cUR5eDlrTkIraGJCcVF2MjdValI2a2dweHNwcXFyWSs5WXlz?=
 =?utf-8?B?WWFJcjBWamlvcDIrV0lxMWtOQ1JVTWNwVFE2RE53d01MdDJRZWM1TUY1UFMz?=
 =?utf-8?B?Z2pFTUJLdXU2MzYzQUtEMlE5R3JQd1ltMGNEUEtlVnlyL0F0QWRCd1NQTkRX?=
 =?utf-8?B?bFB5UEZMU3ZIL3JFY1BONTdkakNMSk5aRnF6TWFOdS85bVRpMHpGMDFrUW1D?=
 =?utf-8?B?bHd5dWUrdGxEMTdDbjVWWVR5YkVsQ09SWmJlZDY3aHZEbGJGTTBwY0tTdXlj?=
 =?utf-8?B?M2F0VlJVbldkeVdETC94akxXSjMvOW8vUDh1SlhkZjg0dU1OYmV1c0FxTGhv?=
 =?utf-8?B?bXVzRUJWSG9aQmxXSnN2NWxzZG9kRXBLblNKRDVlU0lWTjhJTHMvZkdmeDVq?=
 =?utf-8?B?RElIMWRNSU1ZQWs3ejRaY0tDWU5HMENRbVcrZFpNT05weStVWFBORjIzOXpx?=
 =?utf-8?B?WjFmRWkra2VSbktzOWdUTUNaN0dwekQza3JHNUdHZGJ6ekM5REE3NGJBY0hw?=
 =?utf-8?B?Wmc1MjZLZmFaSGdZbWhIMnJxZ0hzNDlmMURRc1piSG40YU1XeGVBMnRpK2ZQ?=
 =?utf-8?B?ZDlkNDl1cERQa2NjM1B1dzJKSFBXR1FrSWI4ZEpuemRqRjNUdVA3OHlwWHdy?=
 =?utf-8?B?QldNaTUrMTBnclVNeDRkVDc4dHVDVThKdjVMWUtxNk0wN1cxaFFqcWVQMlVO?=
 =?utf-8?B?dVpHYlNFakluZ1ZIY3J2Uis1bXJaQWt2MEZiY09qdTl0b01oZHdlODllMkJJ?=
 =?utf-8?B?Mm96NjZjK2ZOSnVvdE9NYmxzUGRROWpxR2NpVTRiUXFMZkR2RWVOYlRDdVlP?=
 =?utf-8?B?bGtOTW1KM2JQOUkvVHVaRS9LY09IK3FXT1VoNjdDWXpUMXJsWUxHcmFCeGN3?=
 =?utf-8?B?TkVDVUFaeDNvZ0FxQWFNNlpybUl6SnVYTytuYnU2RnB3WVZpSlhGMU1BSGxv?=
 =?utf-8?B?RTZOZTY1NElOWVo2NU5WNUJxWlgzbVNJN0ZXVEhQajVhUDNLZ0NnVVpiN1B0?=
 =?utf-8?B?WVgzZHB5NldUa25rWHE4TURZK0FlMFlOR2Z6dGphUEhiSzR3ejRaY0JOK3V4?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA0A65D31B0BA1418D23D36421814E34@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54c9113-09a0-496f-740f-08db56d41b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 12:41:59.5047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUsJfMaMAXomT0RPPBZJlPoe1Cch3E1cgou7pheqjkH/4AMOv+Ye+18+2cARwZWVJvwDbV9hnUR9mUVwK9ZHIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6587
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTE3IGF0IDEzOjU0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxNy8wNS8yMyAxMzoxNSwgVHJldm9yIFd1
IGhhIHNjcml0dG86DQo+ID4gVGhpcyBwYXRjaCBhZGRzIG11bHRpcGxlIGkycyBjb2RlY3Mgc3Vw
cG9ydCBpbmNsdWRpbmcgTkFVODhMMjUsDQo+ID4gTUFYOTgzOTAsIGFuZCB0aGUgZHVtYiBhbXAg
bGlrZSBOQVU4MzE4IHVzYWdlLiBJbiBhZGRpdGlvbiwgZG1pYy0NCj4gPiBjb2RlYw0KPiA+IGlz
IGFsc28gYWRkZWQgdG8gc2tpcCB0aGUgYmVnaW5uaW5nIHBvcCBub2lzZS4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gICBzb3VuZC9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAgNCAr
DQo+ID4gICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1tdDYzNTkuYyB8IDI2Nw0K
PiA+ICsrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjcwIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvc291bmQv
c29jL21lZGlhdGVrL0tjb25maWcNCj4gPiBiL3NvdW5kL3NvYy9tZWRpYXRlay9LY29uZmlnDQo+
ID4gaW5kZXggNGJhYWM3MjY3N2Q5Li40ZWEwMTIzNDJiNTIgMTAwNjQ0DQo+ID4gLS0tIGEvc291
bmQvc29jL21lZGlhdGVrL0tjb25maWcNCj4gPiArKysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvS2Nv
bmZpZw0KPiA+IEBAIC0yMjUsNiArMjI1LDEwIEBAIGNvbmZpZyBTTkRfU09DX01UODE4OF9NVDYz
NTkNCj4gPiAgICAgICBkZXBlbmRzIG9uIFNORF9TT0NfTVQ4MTg4ICYmIE1US19QTUlDX1dSQVAN
Cj4gPiAgICAgICBzZWxlY3QgU05EX1NPQ19NVDYzNTkNCj4gPiAgICAgICBzZWxlY3QgU05EX1NP
Q19IRE1JX0NPREVDDQo+ID4gKyAgICAgc2VsZWN0IFNORF9TT0NfRE1JQw0KPiA+ICsgICAgIHNl
bGVjdCBTTkRfU09DX01BWDk4MzkwDQo+ID4gKyAgICAgc2VsZWN0IFNORF9TT0NfTkFVODMxNQ0K
PiA+ICsgICAgIHNlbGVjdCBTTkRfU09DX05BVTg4MjUNCj4gPiAgICAgICBoZWxwDQo+ID4gICAg
ICAgICBUaGlzIGFkZHMgc3VwcG9ydCBmb3IgQVNvQyBtYWNoaW5lIGRyaXZlciBmb3IgTWVkaWFU
ZWsNCj4gPiBNVDgxODgNCj4gPiAgICAgICAgIGJvYXJkcyB3aXRoIHRoZSBNVDYzNTkgYW5kIG90
aGVyIEkyUyBhdWRpbyBjb2RlY3MuDQo+ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9tZWRpYXRl
ay9tdDgxODgvbXQ4MTg4LW10NjM1OS5jDQo+ID4gYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4
L210ODE4OC1tdDYzNTkuYw0KPiA+IGluZGV4IDZjM2YzNmUyZmZmZC4uMTVmY2UyNzQxZjAxIDEw
MDY0NA0KPiA+IC0tLSBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LW10NjM1OS5j
DQo+ID4gKysrIGIvc291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtbXQ2MzU5LmMNCj4g
PiBAQCAtNiw2ICs2LDcgQEANCj4gPiAgICAqIEF1dGhvcjogVHJldm9yIFd1IDx0cmV2b3Iud3VA
bWVkaWF0ZWsuY29tPg0KPiA+ICAgICovDQo+ID4gDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pbnB1
dC5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxp
bnV4L29mX2RldmljZS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4g
PiBAQCAtMTMsMTAgKzE0LDI1IEBADQo+ID4gICAjaW5jbHVkZSA8c291bmQvcGNtX3BhcmFtcy5o
Pg0KPiA+ICAgI2luY2x1ZGUgPHNvdW5kL3NvYy5oPg0KPiA+ICAgI2luY2x1ZGUgIm10ODE4OC1h
ZmUtY29tbW9uLmgiDQo+ID4gKyNpbmNsdWRlICIuLi8uLi9jb2RlY3MvbmF1ODgyNS5oIg0KPiA+
ICAgI2luY2x1ZGUgIi4uLy4uL2NvZGVjcy9tdDYzNTkuaCINCj4gPiAgICNpbmNsdWRlICIuLi9j
b21tb24vbXRrLWFmZS1wbGF0Zm9ybS1kcml2ZXIuaCINCj4gPiAgICNpbmNsdWRlICIuLi9jb21t
b24vbXRrLXNvdW5kY2FyZC1kcml2ZXIuaCINCj4gPiANCj4gPiArLyoNCj4gPiArICogTWF4aW0g
TUFYOTgzOTANCj4gPiArICovDQo+ID4gKyNkZWZpbmUgTUFYOTgzOTBfQ09ERUNfREFJICAgICAi
bWF4OTgzOTAtYWlmMSINCj4gPiArI2RlZmluZSBNQVg5ODM5MF9ERVYwX05BTUUgICAgICJtYXg5
ODM5MC4wLTAwMzgiIC8qIHJlYXIgcmlnaHQgKi8NCj4gPiArI2RlZmluZSBNQVg5ODM5MF9ERVYx
X05BTUUgICAgICJtYXg5ODM5MC4wLTAwMzkiIC8qIHJlYXIgbGVmdCAqLw0KPiA+ICsjZGVmaW5l
IE1BWDk4MzkwX0RFVjJfTkFNRSAgICAgIm1heDk4MzkwLjAtMDAzYSIgLyogZnJvbnQgcmlnaHQg
Ki8NCj4gPiArI2RlZmluZSBNQVg5ODM5MF9ERVYzX05BTUUgICAgICJtYXg5ODM5MC4wLTAwM2Ii
IC8qIGZyb250IGxlZnQgKi8NCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIE5hdTg4bDI1DQo+ID4g
KyAqLw0KPiA+ICsjZGVmaW5lIE5BVTg4MjVfQ09ERUNfREFJICAibmF1ODgyNS1oaWZpIg0KPiA+
ICsNCj4gPiAgIC8qIEZFICovDQo+ID4gICBTTkRfU09DX0RBSUxJTktfREVGUyhwbGF5YmFjazIs
DQo+ID4gICAgICAgICAgICAgICAgICAgIERBSUxJTktfQ09NUF9BUlJBWShDT01QX0NQVSgiREwy
IikpLA0KPiA+IEBAIC0xNDMsMTIgKzE1OSwxNSBAQCBTTkRfU09DX0RBSUxJTktfREVGUyhwY20x
LA0KPiA+ICAgU05EX1NPQ19EQUlMSU5LX0RFRlModWxfc3JjLA0KPiA+ICAgICAgICAgICAgICAg
ICAgICBEQUlMSU5LX0NPTVBfQVJSQVkoQ09NUF9DUFUoIlVMX1NSQyIpKSwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgREFJTElOS19DT01QX0FSUkFZKENPTVBfQ09ERUMoIm10NjM1OS1zb3VuZCIs
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJt
dDYzNTktc25kLWNvZGVjLQ0KPiA+IGFpZjEiKSksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJtdDYzNTktc25kLWNvZGVjLQ0KPiA+IGFpZjEi
KSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENPTVBfQ09ERUMo
ImRtaWMtY29kZWMiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAiZG1pYy1oaWZpIikpLA0KPiA+ICAgICAgICAgICAgICAgICAgICBEQUlMSU5L
X0NPTVBfQVJSQVkoQ09NUF9FTVBUWSgpKSk7DQo+ID4gDQo+ID4gICBzdHJ1Y3QgbXQ4MTg4X210
NjM1OV9wcml2IHsNCj4gPiAgICAgICBzdHJ1Y3Qgc25kX3NvY19qYWNrIGRwX2phY2s7DQo+ID4g
ICAgICAgc3RydWN0IHNuZF9zb2NfamFjayBoZG1pX2phY2s7DQo+ID4gKyAgICAgc3RydWN0IHNu
ZF9zb2NfamFjayBoZWFkc2V0X2phY2s7DQo+ID4gICB9Ow0KPiA+IA0KPiA+ICAgc3RhdGljIHN0
cnVjdCBzbmRfc29jX2phY2tfcGluIG10ODE4OF9oZG1pX2phY2tfcGluc1tdID0gew0KPiA+IEBA
IC0xNjUsMTEgKzE4NCw1MCBAQCBzdGF0aWMgc3RydWN0IHNuZF9zb2NfamFja19waW4NCj4gPiBt
dDgxODhfZHBfamFja19waW5zW10gPSB7DQo+ID4gICAgICAgfSwNCj4gPiAgIH07DQo+ID4gDQo+
ID4gK3N0YXRpYyBzdHJ1Y3Qgc25kX3NvY19qYWNrX3BpbiBuYXU4ODI1X2phY2tfcGluc1tdID0g
ew0KPiA+ICsgICAgIHsNCj4gPiArICAgICAgICAgICAgIC5waW4gICAgPSAiSGVhZHBob25lIiwN
Cj4gDQo+IE9uZSBJbnRlbCBkcml2ZXIgdXNpbmcgTkFVODgyNSBkZWNsYXJlcyB0aGlzIGFzDQo+
IA0KPiAgICAgICAgICAgICAgICAgLnBpbiAgICA9ICJIZWFkcGhvbmUgSmFjayIsDQo+IA0KPiBj
YW4gd2UgcGxlYXNlIHVzZSB0aGUgc2FtZSBuYW1lLCBzbyB0aGF0IHdlJ3JlIGFibGUgdG8gZXZl
bnR1YWxseQ0KPiBzaGFyZSB0aGUNCj4gc2FtZSBjb25maWd1cmF0aW9uIGluIHRoZSB1c2Vyc3Bh
Y2U/DQo+IA0KPiBGb3IgcmVmZXJlbmNlLCBwbGVhc2UgY2hlY2sgaW50ZWwvYXZzL2JvYXJkcy9u
YXU4ODI1LmMNCj4gDQo+IFRoYW5rcywNCj4gQW5nZWxvDQoNCk9LLiBJIHdpbGwgcmVwbGFjZSAi
SGVhZHBob25lIiB3aXRoICJIZWFkcGhvbmUgSmFjayIgaW4gVjIuDQoNClRoYW5rcywNClRyZXZv
cg0KDQo=
