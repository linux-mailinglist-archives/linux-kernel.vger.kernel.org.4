Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CA6BE083
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 06:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCQFSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 01:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQFSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 01:18:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C746169CC6;
        Thu, 16 Mar 2023 22:17:56 -0700 (PDT)
X-UUID: 0f7afe04c48311edbd2e61cc88cc8f98-20230317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XefG5x5NraI++10mBdls2eIoV8At7e138ViGn/HIDsg=;
        b=pOPwy5HfbfMUWuCzz9fzsp9iqaBFKlV7uoj1JbeHopow6JZzae7MS/L8JNZzHKIf69oMu0a1Sf9pzpkB2yQeD4TltunLUzhNHVbtUuijBrkqbkdteDurRePYykjpm1DdFi9dGrY+Ss1lvdGXWxhXvogWJHazRggNDmk1Q5Pytcw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:8d83e7d9-7a44-4f22-bc75-7ba9474572e8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:83295aa,CLOUDID:88d314f6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 0f7afe04c48311edbd2e61cc88cc8f98-20230317
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 723378890; Fri, 17 Mar 2023 13:17:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 17 Mar 2023 13:17:48 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 17 Mar 2023 13:17:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXzvh4HzOt64RaKLlUp3B9daitRf9erEBrmEXXtj0Jw7lOpig36s6eytDJ4ea5hPzauRriq7zRvgxjjX2eJ5HsSFYk7yD1kbN2USWGlREv6SAppRDhPGkGsAUVdWHSsStjsTk4QW/CLHLq5MFBswXUWVNDzjowVS1E3AQIococlRvI1CNakz4aNURUzp4bZl0Su1SN+v6Tjc60cT2XwikVTo8d8yEwViMA/7zbR5bUi3X+9Q6NgOswutB5j1tKzKp/SvjNU8WSLDFj/RBIU9ckg+JUQZSKeuQiq0jxrwn3vIOl+eakXwBx5huVvQc7NZ9vlEEngYMUiJzMYJIMbSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XefG5x5NraI++10mBdls2eIoV8At7e138ViGn/HIDsg=;
 b=izzBkxp/msPHkiwuNfq+yzYICtkExy2n5yw3jyO7Ggm6NjKc5HHxXnTI0SPHA2GJ6I2hFtgdXlN512SvTAcuv02q3jifh5o2TKhaQQEgssbow7H2ZjL6fVEsAeJXbEDyy4Rpb6Ah+kD3lvSMYeNjIDXmCgOp02aJXp3PXUzPDlqhdZPpoBULNVKWRb9hkGoJdi5uR9nNXlwv+NYiT0T9veEjqnZwWX3PsYwyr5K/TecK1Q00KxiCZyriMfggYAgGaRWdtZGRDm7yn8W4k+D0trzxWJ68S85XvJ9aYnACjCNVz3NCOeE8/erT7eRgbUX8IdfesBRDxrztyG7YLLAwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XefG5x5NraI++10mBdls2eIoV8At7e138ViGn/HIDsg=;
 b=mIGZVdZFRIWqIW+sCSqn4fm5WzBnlOhvOisDwAgjpB+1Kncl76JYbze+BtiuUaefYWsEgwSUXAi20o1yd2SQJQgvzrhtwQhJ/judnIkZWxtkrntVRINRzRaYl/7rA18vR/TmpNCK4Pni8/vrBFlpM2yIIywZAU0CZ9o88Df2Qv8=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by PUZPR03MB6160.apcprd03.prod.outlook.com (2603:1096:301:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 05:17:46 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::c821:f285:9b2f:35e8]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::c821:f285:9b2f:35e8%3]) with mapi id 15.20.6178.031; Fri, 17 Mar 2023
 05:17:46 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] arm64: dts: mediatek: mt8186: Add ADSP node
Thread-Topic: [PATCH v3 4/7] arm64: dts: mediatek: mt8186: Add ADSP node
Thread-Index: AQHZTX7VEpXesenZl0yAKwdbGKgJ+a7o7IIAgBWYGwA=
Date:   Fri, 17 Mar 2023 05:17:45 +0000
Message-ID: <0141c1504e96d9267e2ed9d7a4c925b56976c870.camel@mediatek.com>
References: <20230303031728.24251-1-allen-kh.cheng@mediatek.com>
         <20230303031728.24251-5-allen-kh.cheng@mediatek.com>
         <b121408c-bed3-7b58-affc-c7fde5d0ac40@collabora.com>
In-Reply-To: <b121408c-bed3-7b58-affc-c7fde5d0ac40@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|PUZPR03MB6160:EE_
x-ms-office365-filtering-correlation-id: 741625d0-cc4e-490a-7192-08db26a6f132
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f2eudDje4A5jSmVYapXl+SatCkJIpgeEKIao4IoGPgweW80IsJGEMB9W3ns5u6j0c+Oh+oVT9GgHRz9/EHmX7tgjqnkfJbCrV+TalRdzu7ZhV0UDoAgjf1eaBc3mFhLnxU6jxqxC3X7tgn3004DPJwnF3vvi83THgaNGY9dgqv0rznpHbXQ7S7w9347CzNND/vRPO2LqkpE3UEp9hsSSuPYxk/+N00gXs5t3/Yprg5ddc2ckaKns2/xzxLI9rBZlXFyd18E2+HwVjxIrRLlpFDRSTrbDFfVcM1UATqpubObwDK8z4aBNn/hUeYOADa77UFHMAHFLkz8QUPWjU/trlAE2NAEPnmKVY1icr1f0f9zo/8rmkEEWdRFwUrJGH85eco8vQDIrOeHOTsxdHn460+9qwQJ1eUa3U3/1h/QcwowyD6FVuondCJL0v21BE4gK94PX7jWMxVxsl/TEjRSV+vmLsfLbXSP0/fMQWWcqYRvG3JEDi93TynCiXq59fm0JPqTOk3YcK190oRz0UWY2RfALmlhIl3VQDa0Qh9PaGCTZpnGNJp+CmbhQuiUMPsb/VTsUEeZpkc2nl0hv6dTYbKYM92P2prd46ACs1uYiBZwpMFkiRMQ5mMJ/nlUOK4lxpOoFEtr3PSzPCoLLR/ygGzNeNHiUB7YMAlDnYU4doQ+PPECtkUt0owGzXgtDin4lbW1fWI12gqZjxdNuOcQlXfWikgFuvQvqNdggTEDTpEvcppk0CDJtbIZceYWkYiZi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199018)(122000001)(38100700002)(66946007)(66476007)(8676002)(64756008)(66556008)(66446008)(4326008)(41300700001)(54906003)(110136005)(316002)(76116006)(83380400001)(8936002)(38070700005)(2616005)(71200400001)(5660300002)(7416002)(478600001)(26005)(6506007)(36756003)(6512007)(86362001)(186003)(2906002)(6486002)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UndOQ0k3NUZjbmViQlE3UzBlY2NlUnU4alZSbVcvNHZxcUNzNkdxOWdvc1gw?=
 =?utf-8?B?Y0pNV3ZvT3BwSGN2WnlSUzF0Y3MzVDQ4S1ZwdU04Y1krd2VqNDV0NXN3KzEz?=
 =?utf-8?B?MmVwTmd2YUZrRkp5bFJmaFVRcVFmdklBSFdXSGtCMnNUeVpaUklwLzNmd2F2?=
 =?utf-8?B?R003aWtkdFNIZVBCU2ZIb3plOFRSVU9MU1BsZE1kN3RmOEhhNmxYQnZDaEtZ?=
 =?utf-8?B?RFNHZkxmaXUvcUgwWW9EbkhVbnBkejU4TTZpRlZUYlJEL21xc1ROeVNMSE5l?=
 =?utf-8?B?TVZ5Mm5KV1loQ2lKS0ZFWW84Tzc1RDVsbDMrRm0wMEZkWUlQeElIQk5SYXVO?=
 =?utf-8?B?T3NsR29DSzl3em1FNHZkdC9IcFhWRjE5bU5OazJpN3laZllja2VkaytocGtq?=
 =?utf-8?B?R3VTOHA4RUZLV0NUeHVHMnhlZmZERFpIeHl3MlgyMFI3TzlFQnk3c3pIaXRL?=
 =?utf-8?B?OVU0NUQwQ3lNSEhaN2lXRFk0ZDhUNjFreFZoL3BEVHhjaFBFL1V5N1dSc2Zp?=
 =?utf-8?B?VWorVUV4azR5RyttWTFIZUZKd3pYc2E1am84Mkp1a1dmR3NOWnV6NFYyLzZ4?=
 =?utf-8?B?QUYyOG1hS1ZVbW95amVOWE5VMDMvQVlaT1ZaQnBxWUZ5M0tQS3FqdGkwUW5C?=
 =?utf-8?B?c0pjYlJwUy9HY29vTytsQlVabjJOaFM3RnQxT0FySDhIN25VQTI0SURNUGVS?=
 =?utf-8?B?dW93RWhQYi9xMFdvZWRlWkJIODNrU0RzVXBWTDNHMjRyQTI5ZENBQ3FEckNI?=
 =?utf-8?B?elVOQzQ5R3FwKzNiUG9mZHRxcURFS2kwRmc1R0ZuYnFmYTdkUTdWSnBUbm1K?=
 =?utf-8?B?alhGZENiREtMRkphTG8rWFE1Nk93OGpQQjdaeXVFWWZoeTlMenJreHoyVEda?=
 =?utf-8?B?OTlEcGdkTEc5MzgxVDJrSWwvTElvalRoeERPMG5QR0dsOEVUaE0yRngrUnFY?=
 =?utf-8?B?OHB1SjNNNXNmd0RUSmg3VzZUNEFqWFdJREVxSlB2TWlReWlNZEM1bFVZNFVF?=
 =?utf-8?B?NStSMHJURkxpTUFKTXZiWlI3K1VRckZJZ1lXeHpVUUpKa3RURU0zVjc0ZWRN?=
 =?utf-8?B?SWxUVjlKRTJSeGY0TzFlUU9KV05Kd0tkL05jWFQyZ0IvQ091MTdRZyt0Y28y?=
 =?utf-8?B?YWRITGIreVVObXBkTjR4UjJaQ2RDK2I3ZkhNRHdIZWx2ckR1TkZOTUVIczNZ?=
 =?utf-8?B?ckJ1WXdxNEMzUGJXTmpQTWUrTmhNVnFMdFJZeWJTTzU1cjRZMDRBQUJPaDRi?=
 =?utf-8?B?cTIxNlZzcTRQQmxBL0xVVms3QWN6dmV5ZWNMMUR4QkRrM3NOVDFtNG9WMzhJ?=
 =?utf-8?B?QjE5L1lwRHBQcXVBTTM1cVZLc0JUTWVJNVBJTXlhR1Y5MEd4KzdKdk5hcHhl?=
 =?utf-8?B?S2dSQUhmZ08raXQ1UjQzeE8vODRCdmZuVzBhWWZwQlI2dXlKd3BFM29QdkFa?=
 =?utf-8?B?T1l1VVo2YjBPR0ZNaFBFVkN0dkMzdUVyY09HSW5JMVFzbUlmd09QY1ljZTAy?=
 =?utf-8?B?RFZmeDNNVXV2VHBZelN3UGNOSTVyVXo0ZW4vYTJScGRoL0ZRdGhBTlVzZW5P?=
 =?utf-8?B?bUYxMmsrUHlBbkp4cm0raldqTjdiSEpXeHRHa1QvWVVnVlBaYjVUb1F6UXpj?=
 =?utf-8?B?aTk0eW53N1ZZQ2YzeExoOGNteDVlcExqWXNqV2JFQlg3YnJNQU04SFRFWEU3?=
 =?utf-8?B?WUVoZWtwa1BNRysvQ1NFSTNkb1JRelBPRXpLZS9ScHFwUE9pVTBhenFKWHVm?=
 =?utf-8?B?SzdoY3p6eUcxSUhTM0RWbktOQ2habDlCdHpsS1VTcUtBdGJmdVNmMlU2dWtU?=
 =?utf-8?B?WG5kcnlMNjJLcHNHcmNJd2hMVDJUVXZ4WUF4VW16WHB4dUxVUDlkYkFFTm9P?=
 =?utf-8?B?M1pWbklGTzV4UDNqYnZzR0J5VUE0aytOdSs0Rjl2dys3anJycmdheC92Rmcy?=
 =?utf-8?B?WFgzVEdta1ZHWnFhcUFrdStmM0JUZllyaStuQ1gvR1R0Q2FQdU9sMnVyYTVG?=
 =?utf-8?B?SFB1b3F1MmFCdjlXa3ZUTi9wbXJLcnRHa1lYODRSMWc2Z3VORnErOHFKN3Rv?=
 =?utf-8?B?Sm05R1pqVWpDcnIxYlBRZ3lIcDRCTnEyaTRIYUFuOVA1R1d6cFFkdHVZOGJw?=
 =?utf-8?B?ZDZySW90RlErUVBhRWtTblN5Ym1mMFdmUlFRWHNpWVRiWCs3cktkclo0VGMw?=
 =?utf-8?Q?4wvwh/PFzXuEiB920GQW2VE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01D896CA251CEA408A83852B5EDF4F54@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741625d0-cc4e-490a-7192-08db26a6f132
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 05:17:45.5942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1uz/uJSn8PgXqHAhGeMMVIe31pGX7nqbF2HwPBVc83KTzesfX454rbMCZb8Xc5TDC5IhwBYC7hLqTCP322eUImwNaXo0Hwx1rFZwPxk6Ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBGcmksIDIwMjMtMDMtMDMgYXQgMTI6MzEgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAwMy8wMy8yMyAwNDoxNywgQWxsZW4tS0gg
Q2hlbmcgaGEgc2NyaXR0bzoNCj4gPiBBZGQgQURTUCBub2RlIGZvciBNVDgxODYgU29DLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsbGVuLUtIIENoZW5nIDxhbGxlbi1raC5jaGVuZ0BtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE4Ni5kdHNpIHwgMTYgKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxODYuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxODYuZHRzaQ0KPiA+IGluZGV4IDBlNDJiZGJkMmNiNi4uMzM3YmNmM2MxNTcxIDEwMDY0
NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTg2LmR0c2kNCj4g
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4Ni5kdHNpDQo+ID4gQEAg
LTYzMyw2ICs2MzMsMjIgQEANCj4gPiAgIAkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyMDUgSVJR
X1RZUEVfTEVWRUxfSElHSA0KPiA+IDA+Ow0KPiA+ICAgCQl9Ow0KPiA+ICAgDQo+ID4gKwkJYWRz
cDogYWRzcEAxMDY4MDAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg2
LWRzcCI7DQo+ID4gKwkJCXJlZyA9IDwwIDB4MTA2ODAwMDAgMCAweDIwMDA+LCA8MCAweDEwODAw
MDAwIDANCj4gPiAweDEwMDAwMD4sDQo+ID4gKwkJCSAgICAgIDwwIDB4MTA2OGIwMDAgMCAweDEw
MD4sIDwwIDB4MTA2OGYwMDAgMA0KPiA+IDB4MTAwMD47DQo+ID4gKwkJCXJlZy1uYW1lcyA9ICJj
ZmciLCAic3JhbSIsICJzZWMiLCAiYnVzIjsNCj4gPiArCQkJY2xvY2tzID0gPCZ0b3Bja2dlbiBD
TEtfVE9QX0FVRElPRFNQPiwNCj4gPiA8JnRvcGNrZ2VuIENMS19UT1BfQURTUF9CVVM+Ow0KPiAN
Cj4gV2FzIG1pc3NpbmcgPCZ0b3Bja2dlbiBDTEtfVE9QX0FVRElPX0g+IGludGVudGlvbmFsIGhl
cmU/DQo+IA0KPiBBRkFJSywgdGhhdCdzIHJlcXVpcmVkIGZvciB0aGUgQURTUC4NCj4gDQo+IFJl
Z2FyZHMsDQo+IEFuZ2Vsbw0KDQoNClRoaXMgbWF5IGJlIGRlcGVuZGVudCBvbiB0aGUgZGVzaWdu
IG9mIHRoZSBjaGlwc2V0Lg0KDQpDTEtfVE9QX0FVRElPX0ggd2lsbCBiZSB1c2VkIGJ5IHRoZSBh
ZmUgKGF1ZGlvLWNvbnRyb2xsZXIpIG5vZGUuIFRoaXMNCmlzIG5vdCB1c2VkIGZvciBEU1AgaW4g
dGhlIE1UODE4NiBhcmNoaXRlY3R1cmUuDQoNClRoYW5rcywNCkFsbGVuDQoNCg==
