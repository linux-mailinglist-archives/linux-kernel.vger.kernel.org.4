Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE9863855D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKYIlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKYIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:41:34 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AE823EB6;
        Fri, 25 Nov 2022 00:41:28 -0800 (PST)
X-UUID: b685788d8807465da0d458cc5e7f69ed-20221125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ly0KuGoQse8PXUydq7n/TZeXInx5WeE6vGgcG/nGYa8=;
        b=X0u6ORxsTvHaK3AcXFRdbXDhIaefesIx27p1a+v3VIF7ZUoPpBcFAnCOzkvk63ECuNISBDR46hkhSFcWc1aQrrzCrtkOlduGNDjBiMEf52d6ZJImKW2TR2Gsri3uQ26qgsnTxJ1Mj8EhIt7x4I9990D21VXa1RhuA35C3sXohNc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:cbbf7f5c-2264-4852-b287-5aeed2f862f7,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.14,REQID:cbbf7f5c-2264-4852-b287-5aeed2f862f7,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:dcaaed0,CLOUDID:1ed0d02f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221125160056GMJ1SRR5,BulkQuantity:10,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: b685788d8807465da0d458cc5e7f69ed-20221125
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1795199586; Fri, 25 Nov 2022 16:41:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 25 Nov 2022 16:41:18 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 25 Nov 2022 16:41:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9at7lZFHkTTIpzGIuL2M6IpRchQRPB5yAxy112b90+fCQ7UeHTpX9RtqzcvBeYUaD+00/Ev7e8UcDyAHiMTYlieBvUUIFNrtgf7mrXUMkhCIa+0/4iGOOhc2IjVZGde/QOLpZAc8l2elACs2Lny7U77rvfiYk/dvN+bjeLDBkrucBhgwiL5p6Hvwqa5Pje6a6CYpNhKvIJl4lqY1TX7zFRk2hjbpcezKSd0sXD2DPZ+bc3dGVDoUbko984BT1bbJ2H5mfwsU1AKGwig+4ltkiEWsQPnEaiqx5HNdmdYAcC9qdKv2q+XFX+3pTj2X5DweNMkyKVtWl/OT9/PvwlKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly0KuGoQse8PXUydq7n/TZeXInx5WeE6vGgcG/nGYa8=;
 b=Dpc7TcAVWqoAt3dW/ujGZ6BSRKH07tNPodbl9gqPIx/sDCvsUuItHhXUT4yFFGiSGhyNZhUBVvgXXIO6FKpDpcXk8/G/jH6pFVkmnj5cLgv7sLDMjufrQ6A1fcw1pBbugO7z/IjKxE6FNj2btDk/5ZrtsddZPicryDqIAzWzysUzxe4TA3+X55C/VeXLuigGFlFiL4fi0HHPqku87QbckQ9XAG0k9/aQb33/hbz9Ura+jevuZZcPlolskbPhK3yknOadKS+UA2RKEcGZG9AoS1MGBYPziH7PTtMbLn/kW70W9O2eBkX72BnifAUONPW7sZnGSMJPQZBsLzvzr4q53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly0KuGoQse8PXUydq7n/TZeXInx5WeE6vGgcG/nGYa8=;
 b=BiZDjy/wGqipdX1hUjYCjZB0UoZ3euHKP+0df/H2uMOPJAO2IpuqVl2EoY2CSKS43jo9jKuABWTw7sKoV+kmbrzCIaTpUKFDlXNinR7UpJmB7g/ErRCRgMZWMHSrZ3tdCUaR4ASF5u3FgxRBpR5sV0ekFMKk0uSS0OZZDGLSo70=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by KL1PR03MB5729.apcprd03.prod.outlook.com (2603:1096:820:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 08:41:16 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::af56:be8f:f:85b2]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::af56:be8f:f:85b2%7]) with mapi id 15.20.5857.017; Fri, 25 Nov 2022
 08:41:16 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: usb: mtu3: add compatible for mt8186
Thread-Topic: [PATCH v2 1/5] dt-bindings: usb: mtu3: add compatible for mt8186
Thread-Index: AQHY/0NeTfiJAOQ/8UiMJl2IOF+xd65PSYcAgAALTYA=
Date:   Fri, 25 Nov 2022 08:41:16 +0000
Message-ID: <fc0cb10747056f8f38a077b39df3a83e6b340c64.camel@mediatek.com>
References: <20221123135531.23221-1-allen-kh.cheng@mediatek.com>
         <20221123135531.23221-2-allen-kh.cheng@mediatek.com>
         <4ffbba83-d23c-59ef-0b01-eeb80ea70219@linaro.org>
In-Reply-To: <4ffbba83-d23c-59ef-0b01-eeb80ea70219@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|KL1PR03MB5729:EE_
x-ms-office365-filtering-correlation-id: ec235246-3557-4fba-5939-08dacec0d0eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zQIDFjFxgJWG8VTsXZTlW93YZH/xC9u2Nb2ngZhFFrxejBtGbprRQ8OLq4GH9mxqBnDFxTKWZy38/8sRqNv3xsgRCOtYmYv+G1tfX59t7uzEJDetE5LbdU4dZ7s9aCr9vemee1s8Viq6Da2WAZ5brrgcM1fE4BUg3Wg0RGfUj+k7SSIY6Zi4R9aDnmafbWC8lsRsbtgfbPFbpd81pxFwhUZTNBhxhNAFYowf34p5iQOK0aKVoj0qXW9Rlfcmw6KF9gUJDeVR98gT6QHCjB+CXzuiwZwXVv3goYlt4ZTi9c1jgKKpGPYqRHa6w6SQCk4pD08bFbv9IEs/YEmUcxy9duLLsaFFuaxzgyjaS+tv1h55y83E/7kHHnZn1g+5UAbY2XcLSeKhcu53wYU7Zh48Ybv1GG2PsYVPFsP2QuSfotRxBMj35ZAqCygx9HE9AD/lkPl6N6N1ttDI/3x9e06cWc/BueIWSfIZL+1GsDNe+Yoz0/WQ1YGCxTAYE+k34gupgdDurTf4qfjWwgiouLSWJF2rJRGDJn6dFYN8qvFNEKA8aRxhQEU8xwD2bL63EkSxGeDsAFpbU9lErC7c/WOGSG9PwrCQ9cQHqk6Y5G+r675vvi7apj+2+BDtte3kJZ/hwG3juzNFdnyYHHwNwz+Tp37tEhwx2YZWFb9UR+K6Zgp5ca5SUKUhdt2hbn8kQV7r7YJaLINVw7UXy2uF45gl9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(26005)(186003)(2616005)(4001150100001)(6512007)(38100700002)(122000001)(38070700005)(7416002)(2906002)(4744005)(8936002)(5660300002)(6486002)(478600001)(53546011)(41300700001)(4326008)(316002)(76116006)(66556008)(66476007)(8676002)(54906003)(64756008)(66446008)(66946007)(110136005)(71200400001)(6506007)(86362001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkVEV2NROCtENVI5Y0ExSWhwdnVmZTNjM0U2R04yZ2RqQ0lWM2o3eDJEeDlD?=
 =?utf-8?B?NjNzcG1oR2d3a0JQYmRBT0dURHo4ZjVTUldJMEtZdHJIUWp4b2lqTmR0MDlW?=
 =?utf-8?B?Q3FVVkZDeitRckpuZUp1cmFHNkVZSGJKdUFBazcvbUtpOU5nRmdvUW5adzhK?=
 =?utf-8?B?MG5JRUtLS2tNOWp5NlVkZlAzKy96RmVoQTIwT04rL05HQ3A0NWpmeCs3c2ZW?=
 =?utf-8?B?MzQrZnFtRWw5MVd0dGZnTjhZUDA0dEIrNUJOaG5HL0E2TjVrd3JTUVZsMlhV?=
 =?utf-8?B?bG0rbTgwYktLTWxCaUw3c0FsaWcySDltRkFFa0FoZnlGbE0rbmg5MEt5cUdM?=
 =?utf-8?B?cy9CK1labzlFU3d4MS9tb2VudFM5OCtwZDRFWVBNNDAvbkRGa1JyL0wvVDM5?=
 =?utf-8?B?d2ZaM3hNREFkOTJIOUt4NEUySWl6Rkd5ZXhYRmtKTG1lT093VnZLeFNwczB6?=
 =?utf-8?B?N1pwRGNGZ2k4N28yemNEUGN6VlFEK3ExaUpUT1RSRjVtdWxkVXgyUkNzU3ZG?=
 =?utf-8?B?WFQxbXhXaGV5Q2t5K3ltMDZOZmljOUZwMGlDanF0V2pjTWUwVkxKMmM2M0p1?=
 =?utf-8?B?bVJhTkNyNU9KL2tPaEVMbHY1c05jOWk1R05pR09uWlY1SXhEUjhPRmx3UUc3?=
 =?utf-8?B?dDk3cnRBSzVVR2NiVkNoclk4bGVsY1dhOUtuaG56MHN2dEVXMEowV29HOWho?=
 =?utf-8?B?NUFMdjc3eG4yNFlqRUR1Q1pZSm1jQlo2dGxpRk91MkFRVnF0Y3FIU3o3K3hN?=
 =?utf-8?B?VzV2cWxjQ1hIZE52bTRwbTMxaFZqU09ZbFB5N2thVS8vcU1QS1Z0UmlWWVJE?=
 =?utf-8?B?Z24yOCtXMlFvN2hCa20zaGNjTitITGEyWXNTZ3BpYVJrdGhLd2tyejdYcjZK?=
 =?utf-8?B?ZjlOQzdFbm9iZmVwWnZrQ1RJbDc4L3BUVnpPck1qWDRkWlVMUnB3ZTNjNHM0?=
 =?utf-8?B?VWVFY2RtZGE0L0tXWDdNQ2h6eHo2eHFSMWQ4S3BYaURLeXhad0RGODdHem9v?=
 =?utf-8?B?eWp0UkFoRjBWWGxPR3JmWDUvSzRMWHMrNFR2UHFqbHFqQ0tlL2xBbTAwOGFx?=
 =?utf-8?B?MWtKbTNHZTRQSUs4bklDVFA2M0RwSEh2SExtVFJpNHZzVEZKck9uRkZhL29q?=
 =?utf-8?B?dWROeVRyazcxR1BWMXc2M2NJbndkODB0WTViN0xBV2FzZ2dkRzVhUmxRN0ww?=
 =?utf-8?B?VURvMjNlWGY1ZVJienh5MkVYWEdiT3hKYm1IRFBLT0VKemY3N1RZKy96MkZN?=
 =?utf-8?B?ejB4dk82aG5KV2RyeTNoc3dFYkhDbW9EUVM2MjRVbEwxYnZsY3dEb1VGNFdK?=
 =?utf-8?B?b2x6NUUwSktEeEs5R2ViZUw0cnJwc2ZTOEZRazRBVVBWV3lTdHdVT0psTU52?=
 =?utf-8?B?bU1Db1E2ckJ6aE11TFJGb0doV2FhNDhCSlhIdytqejYzczYwOVVGaDhJOGNy?=
 =?utf-8?B?VE5Fakt4enlMRU5KNnhCbGZjd3JhbVlBeUJ1SXZlWmUxR0VRY1ZrYmNXWlZC?=
 =?utf-8?B?bmlaVmY2K1hCbnUwc0xSbkoxM1R0WWg5OUgwYVNOMk1wVmhBQWZ5VmdzWGRS?=
 =?utf-8?B?RERtN21PV3NtaWFBR1p0NmRJNi83Vnlwb25GZGZZWnJKYytSUXVPOVFIUjQw?=
 =?utf-8?B?dTE4UEUyZGdYdm9BaTlneDdnSlQ0UzBNYkdkRVRicHU1c2tOYW5TNGdTWDJZ?=
 =?utf-8?B?b3BYSUwrZmJSWFV6cmc3WWFKbTNlT3lMb1AxS1pvWDRydHcvZ1RMcWJPMUM0?=
 =?utf-8?B?R0pYRWhScE1SYkRtQXRLZkxnNWljSGtmS2FzNGxKakNYNGNMWWVCM2pEMitv?=
 =?utf-8?B?TGJ6NGFCS3Vyc1JHL1c5Qm41MGNQbCtsbFlYQ1JDOGozYjg2eXhlR1FwU3hq?=
 =?utf-8?B?Z3l0dGpha0lZUTlzQTFSWWJBWGlGUUVnZ2x4S3BISktOZUFYQkpMeDlxUXJB?=
 =?utf-8?B?cWliSUlsT0lTK3ZtdTd0OXBvdDlmSHBNOVQwQTc3VUxSdVRaaTdmczFTZ09i?=
 =?utf-8?B?QS9sSDJDNnBCUUhuZUxWNlpHbE4xcDdvSk51aG5iS0M5VXM5Um9Nd3o2RS9Q?=
 =?utf-8?B?MjRGM25sQTlPNW9BeTBqemt1M054U2tPamw1MWtXeGQ2M0tpT0NGb2hmeVRR?=
 =?utf-8?B?anZoUHpsbVk1TkhBN0NPOHhWWHhoaDlYSU5aMUdOMk1OTTJ6dmRIN29qckZv?=
 =?utf-8?Q?lsxPKAqI3HUG2XIr3KyhQec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AFE650C7017A74ABA2C51AE047350D0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec235246-3557-4fba-5939-08dacec0d0eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 08:41:16.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NR0+zoHwmCmBEMy9a26pv6JOP3hUQU3MUPbUJNrDyfX8FcPUFbo7INfkKyc+vNW0xGMiC7LchEojsDmDaABaXKxD256NftFStLpbNjKN7n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5729
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpJIGhhdmUgdXNlZCBnZXRfbWFpbnRhaW5lcnMucGwgdG8gZ2V0IHRo
ZSBlbWFpbCBhZGRyZXNzIGFuZCBhcG9sb2dpemUNCmZvciBub3Qgc2VlaW5nIHRoZSBkaWZmZXJl
bmNlLg0KDQpEbyB5b3UgbWVhbiAiK2R0IiBpbiBlbWFpbCBhZGRyZXNzPw0KDQpCZXN0IHJlZ2Fy
ZHMsDQpBbGxlbg0KDQpPbiBGcmksIDIwMjItMTEtMjUgYXQgMDk6MDAgKzAxMDAsIEtyenlzenRv
ZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDIzLzExLzIwMjIgMTQ6NTUsIEFsbGVuLUtIIENoZW5n
IHdyb3RlOg0KPiA+IEFkZCBhIG5ldyBjb21wYXRpYmxlIGZvciBtdDgxODYgU29DLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFsbGVuLUtIIENoZW5nIDxhbGxlbi1raC5jaGVuZ0BtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvbWVkaWF0ZWssbXR1My55YW1sIHwgMSArDQo+IA0KPiBBbnkgcmVhc29uIGZvciB1c2luZyBk
aWZmZXJlbnQgZW1haWwgYWRkcmVzcyB0aGFuIHdoYXQNCj4gZ2V0X21haW50YWluZXJzLnBsIHBy
aW50cz8NCj4gDQo+IEFja2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296
bG93c2tpQGxpbmFyby5vcmc+DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiAN
Cg==
