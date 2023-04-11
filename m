Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341376DD459
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjDKHii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjDKHig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:38:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF621733;
        Tue, 11 Apr 2023 00:38:26 -0700 (PDT)
X-UUID: d5db6e32d83b11eda9a90f0bb45854f4-20230411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OCAycLb7nTnt+IIB0aulvpn+HVtNYGu8Jh/8F3DWTwE=;
        b=sgfM8NK0k7JGfgLnLjoAiUG4d/TU/tAvRbEJHWfr9UtgkdXve+lK0OeGJBaEAbNcSh49dwIW4d28flPOE+5BSzh7RQbDeUcUdWTBl3cT5nxFn17gRnf+MAOpul8n8UqqUrgxyTn2uSP8MnPYkCqgeMBlD6/P6SSGl6AVs6UVNRs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:40932908-d865-49ea-a449-57970d9bcb13,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:40932908-d865-49ea-a449-57970d9bcb13,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:ae21aa83-cd9c-45f5-8134-710979e3df0e,B
        ulkID:2304111522373LBBOIAG,BulkQuantity:9,Recheck:0,SF:19|38|17|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: d5db6e32d83b11eda9a90f0bb45854f4-20230411
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 554682018; Tue, 11 Apr 2023 15:38:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Apr 2023 15:38:20 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 11 Apr 2023 15:38:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwP+44SmcGDh70oNpQt7NWGhzztyAuHEnbIggS2wY9GCSKXhVcPLg8krXFn6wM/FDMNZ2TfQVYtRUbdXVKDP3tz+IB0tEZffmvQMRZ4jnSVRCKif1ld2/t+ZUbtnkgAFYaahLEC7ysoNwJAQbiH0s3wvnZnkvN/tFqZ1OUumpMbqAwLgsKts/ZgHVJp6pZMGhL9addViLIBY6SdnaXAHp+/QCkBtB0siVDRrlRerwK9vPDu2/6WwgrN482T/1trbU97mxJLSoNbD9528uLSmAA2kDCAyxEUoqmz2lkNAZQV9QFPccUhIFvK8jIpxxQbhlIMZJu4E3HlyAxkNBlbKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCAycLb7nTnt+IIB0aulvpn+HVtNYGu8Jh/8F3DWTwE=;
 b=kK8MAHmJjO71BIBQCJ0ZGTadK3D0LgOuqp5trF/nwedo5zB9qCUS3LSfHV7O1PQcYKPEFEl3y9vkamAXwH2vUCG6bvCaRRSF1u3cGrkG5XJVfy6wFKHGuVCOk3OKUabyOSGBUH8Ii5cAYs5HkWpY3f8opC3O2tToM6wdRWMUzJm2S9oAmA4PVU/YalhJ3gELhHvlUXY8JvNAc1leqmA+vQJCzP0TPdkS3xvYaSMvl4o7OQdKk9saWEbQnL3bmdx+5T+UUUp6qNS0EYdKdVAA3xW1hSXkNCXyD8BppvIXaKBn0W8fLyeLE1atDRpQvuUXQMXjoiYBbgC6zly+cbz+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCAycLb7nTnt+IIB0aulvpn+HVtNYGu8Jh/8F3DWTwE=;
 b=txFN4GD0EWThfweJkN9sJZNbo+AQcAY90qZwlkw6USJOmmphqPgnmn7VO2JHwP2iwaZF/7+mgLau/bvp6rG23D16YZ6+Xp7EomEQiw4PhJxFdYhllk4Bb++UtBd5GbwlnmAgou4/uwpaS/vWcFCkNXhnSUm1SAwIRl78awfDt0M=
Received: from SG2PR03MB3035.apcprd03.prod.outlook.com (2603:1096:4:11::15) by
 PSAPR03MB5576.apcprd03.prod.outlook.com (2603:1096:301:65::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.38; Tue, 11 Apr 2023 07:38:18 +0000
Received: from SG2PR03MB3035.apcprd03.prod.outlook.com
 ([fe80::c678:f819:f66c:39b7]) by SG2PR03MB3035.apcprd03.prod.outlook.com
 ([fe80::c678:f819:f66c:39b7%7]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 07:38:18 +0000
From:   =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2, 2/2] media: mediatek: vcodec: make sure pointer isn't
 NULL before used
Thread-Topic: [PATCH v2, 2/2] media: mediatek: vcodec: make sure pointer isn't
 NULL before used
Thread-Index: AQHZbDooMxUw8GQXBUiSz5he2d0QN68ltE2AgAAEZ4A=
Date:   Tue, 11 Apr 2023 07:38:17 +0000
Message-ID: <4a250bc10c32a78705044338b41f6fc739cb51af.camel@mediatek.com>
References: <20230411055413.539-1-irui.wang@mediatek.com>
         <20230411055413.539-3-irui.wang@mediatek.com>
         <55bc07edcca27b5be96642aede3d71fe076af668.camel@mediatek.com>
In-Reply-To: <55bc07edcca27b5be96642aede3d71fe076af668.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3035:EE_|PSAPR03MB5576:EE_
x-ms-office365-filtering-correlation-id: 198d4345-cff0-4103-1096-08db3a5fb7a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZLb7fQQ/hekcb7cmMg1UH8qFzR6GEHTkk213M1XTP81KDmKIn5qNtshaZvRTUskGTX7cP0rIT/FDAttARMdUVrbbZpu1K6zdEZy63iRrpX0xZ5JCJBNN4SwIenUlrCI8Hwofj5Bhh7wIOa1148LbYDUm+bOkqcivvVLy5YKqIgdwdkp7QL4BJM0EXKrh1oZi40liaKlTYfyCXuz/Y1iNAb0OFBW2ddgzhgPxBXHZNRB9qPChLABwgKpDw3e7uoCjVTFFrubSm2FFeGjdFWhtiupF0F66De5bRYP+FhDQ4RFcv1S45/lZv32Ba+TN53afTMaDuIxizXnvWXNUciIcyU7eMlbylDur7SGFcduXx/Ag9n3e/5lGmDd23gX38tI2CIkWfkbz77J/d9s0JWZoSfis0U1L+UkTmYG532u9y+yP/FeXkGE15pZXyQgbUEJe/d6l4OgiVxmN1tyEhgya8eLwjop7gmgspVEEgjp8sSYzdhcaV58k9ndWknEaT4HoG5hF8ven3i3XTSCUEl0ojEFsnt54R0Kl9806Y2vGS1yjYSCbMJNsGPd/wCRVufRJckPh3cOg+chlcGEEFHw7T9Mrh6je8pt49gYdFNSeokqWtSN0lonQrivpfE4+TTU0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3035.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199021)(2906002)(122000001)(71200400001)(86362001)(83380400001)(6512007)(6506007)(26005)(38100700002)(186003)(2616005)(316002)(110136005)(38070700005)(5660300002)(107886003)(54906003)(8936002)(41300700001)(6486002)(91956017)(36756003)(478600001)(66946007)(4326008)(64756008)(66446008)(66476007)(8676002)(66556008)(76116006)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWhSb1hmN3BJcG5KeXlCZDZ6Y1B0MXZXQkR1ZWR6Sk1nVjR5eFNBbEI3THZy?=
 =?utf-8?B?aG9LVmNPbXlQTmRpVzRpcm81R3ZmVVNDSHdiSkxUdCt5aE1jWGw4V05rSFor?=
 =?utf-8?B?bzRzdEc3cWxqcXBtZUdhQ2wzTWl3SWJGZ1FFZm1EdzhqL04yS1RYK2sveXB2?=
 =?utf-8?B?Y2lZMUhWYWdwMkVlREpIWmgrMGoweHQ0L09oaUlOeWx6VVUvdVJPYUkyQ1V0?=
 =?utf-8?B?REh2WFEreVRlSldpd1AyNGZ2TlF2UmpieHY4bitIK0d4b1pkNzNuajNCMFBF?=
 =?utf-8?B?QnpZZUlZZlN0c3RXNU8yejFTVGhKTWVTMmFzQkxjYWJhVDNRdG0yRXNpeTZO?=
 =?utf-8?B?Y2tmTFYrYStQTE0wR2NIaS9LQXdPQUFlMHlnNGh0V1pVanlvb2VHQSs2RU4x?=
 =?utf-8?B?dGYyVlFXUFo3RW15QnJESEUxYVBYQUVITjVPUUJpZEtOc203WTdsK3JIWWJI?=
 =?utf-8?B?a0ZzZnpIWjZjV1RJYUFHaWpTTWc3a3duZUYvb1ZXYlY2OUI5ZlJiMzVZZHFq?=
 =?utf-8?B?T0xZNEY3aTBCbGFNNmNUY0p6UjBlL1NEc29HN2pvaHB1c29DUVA0Z3lUYVkx?=
 =?utf-8?B?TGVKdVZQa3NHV2hCdWx5RWxjeVRJM0VpRUMwVG4yNGNWSk9KQ1lvZnBCbUlD?=
 =?utf-8?B?UnV4a0lseVYvWVViRzhuRE1VRG1lNHQzZm9GM3N6cWdUZkdpVVZ3MXJqNWdM?=
 =?utf-8?B?aVU1V1dZQXE1MnV0MUNtd1JYaW1NVzN1M0gveFNMVzNoVTZvb29wVFRwUS9H?=
 =?utf-8?B?MEFrNDJsVG0rejRwYkxjWkpDazJMcmxtUitxb1VxU1VSaGsvdkEyMnNlQ2w3?=
 =?utf-8?B?YkxFOUFqb2I4emhBcEprVDBTbVNjZGxLeC84R0JxMDVRMUJRVDdYSTZlMnBL?=
 =?utf-8?B?UGpWR3hpeE0yMUNua28xN0tKaGJYSEkyUDZnS1RHdm9mU3lIbjgzdjdqdlRD?=
 =?utf-8?B?UGNkSHZtczZhM1k0Y0FwNG9pMzNqdFJmUkZ5Nk1BRzRtUGVaaXdlM29OVC9X?=
 =?utf-8?B?ejl2aUtCQmtDeGFGWjl6YUdoTTFFYnJ1QkF3bDdlNzJDYVQxTzM5aVpERjBt?=
 =?utf-8?B?S0MxazRDOUgwSHU5UlkzTVdyU2hiV3JoZFFOU2VJcnJ1UFQ0TlY3MEhzbkU2?=
 =?utf-8?B?cjVKV1RBQS91VE1FQjdrbHU5Y1QwTVNFd2k5RVp2YWNQVlpWeWlFNDhzUkJC?=
 =?utf-8?B?cWJnUFBnaVJPZDdSd0V2dU5VUVBEOEtrS3dkT3p6S2FkQ0Y0Nzd3SmZNRXNL?=
 =?utf-8?B?TXdNL0ZOWmFkTmxLU25PeEx6ZGl2S2Y4Um8vajBTRS9zR0pxaEdKT0kzVTh6?=
 =?utf-8?B?ZkZoT3V5d0lnVzdoYmQ1ZDRSV1RUT1g2QWxVRkxVSGdLZ2VEUHVldFRRYm9P?=
 =?utf-8?B?QllRMnBBLzlkUmxVdVdlSjhvR2VUc1FVaURqN2YxN3RDcmI0WCtxWDR2V0dm?=
 =?utf-8?B?STZQT2lkd2ZSaklBZi94Qm5wNnprcjRiVFhiSExJSGxnQmRYWVJma2hBQ3lW?=
 =?utf-8?B?VXpjVEZJdlJHTEwxOHFHNmlrRFl0bWZvVGNmSEZWT0dLcWtUTS9vakJXU0kz?=
 =?utf-8?B?M0luRlZIQmJvSGtHR1NqaVRMdHV1YmxqZFhMRTFhVGdLRmcrdjdMVWxRaWpp?=
 =?utf-8?B?c2cvcUt0a0kvdFdTaStXdS9nNVlLbXZzOHpPWnJYblllZ1hUR0dZamFyMWxR?=
 =?utf-8?B?SWlsQzdwbzZDOHFIMkZsOVdkNlhVVWFLWnlhTW1veVNqeGFDSnV0Q0tXOTlq?=
 =?utf-8?B?R3FTN0prb2dTWkQzSlIyUXE0bitxa0NmSHE3ZjBwQlN4VU1ybG5FeHdUY0di?=
 =?utf-8?B?NmVlTXkyT2c5cFA0a04zNEovQ1NjdWp3cGF1YnZRN0p0ai9wbmNLMi9tMXBQ?=
 =?utf-8?B?QUtJL0Y2Z2UzMGozNmRUUS9zSXg5UEt4RGd1V2ZtaWFEZmF1YWJNTGlpdXlC?=
 =?utf-8?B?a0NQN3pUaVJwbThlbGJiTm1FOUhmODFGUUpSZ1p6a2FsTFdvSzZmOFFoWUU1?=
 =?utf-8?B?UW81ZzVpRHYxNy9yM1l5Z0ZaSlFOVy9KSmkvRFZXSG05ODdDRzlQZjl2VHJ5?=
 =?utf-8?B?bHk3WmZkSHQ5RjJFSnY5cXpLRURaMnAxcnA4KzJDL3RuNEJPem5vVCtIcWFn?=
 =?utf-8?B?bGs2M2loQW1TNERmU1NhWmowdXhFODB1bUFtOTZ1MjJFeWpCdmlFS2pXMDAx?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <692251540D33F24C82FFF43392848646@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3035.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198d4345-cff0-4103-1096-08db3a5fb7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 07:38:17.9599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sot6vAAz0p2NT+Uji+09SNKh75pHD3USYHJHrl0b9kNufwzR0DeJGsWnt6Jbqhn4ShzedpKKhnwzR4szug3B5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5576
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBZdW5mZWksDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXdpbmcuDQoNCk9uIFR1ZSwgMjAy
My0wNC0xMSBhdCAwNzoyMiArMDAwMCwgWXVuZmVpIERvbmcgKOiRo+S6kemjnikgd3JvdGU6DQo+
IEhpIElydWksDQo+IA0KPiBPbiBUdWUsIDIwMjMtMDQtMTEgYXQgMTM6NTQgKzA4MDAsIElydWkg
V2FuZyB3cm90ZToNCj4gPiBDRVJULUMgRXhwcmVzc2lvbiBjaGVjazoNCj4gPiBEZXJlZmVyZW5j
aW5nIGJ1Ziwgd2hpY2ggaXMga25vd24gdG8gYmUgTlVMTCwgY2hlY2sgYnVmIGlzIG5vdCBOVUxM
DQo+ID4gYmVmb3JlIHVzZWQuDQo+ID4gDQo+IA0KPiBXaGV0aGVyICdkZXJlZmVyZW5jaW5nIGJ1
ZicgaXMgb25lIGtpbmQgb2YgQ0VSVC1DIEV4cHJlc3Npb24gY2hlY2s/DQo+IFlvdSBjYW4gcmUt
d3JpdGUgY29tbWl0IG1lc3NhZ2UgYW5kIHN1YmplY3QuDQo+IA0KPiBDRVJULUMgRXhwcmVzc2lv
biBjaGVjayAoRGVyZWZlcmVuY2luZyBidWYpOg0Kbm8sICdidWYnIGlzIHRoZSB1c2VkIHZhcmlh
YmxlIG5hbWUsIHRoaXMgY292ZXJpdHkgaXMgJ0RlcmVmZXJlbmNlIG51bGwNCnJldHVybiB2YWx1
ZShOVUxMIFJFVFVSTlMpJyAuDQo+IE1ha2luZyBzdXJlIHRoZSBwb2ludGVyIGlzIG5vdCBOVUxM
IGJlZm9yZSB0byBiZSB1c2VkLg0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiBZdW5mZWkgRG9uZw0K
DQpUaGFua3MNCkJlc3QgUmVnYXJkcw0KPiA+IFNpZ25lZC1vZmYtYnk6IElydWkgV2FuZyA8aXJ1
aS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19lbmMuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2Rl
Y19lbmMuYw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRr
X3Zjb2RlY19lbmMuYw0KPiA+IGluZGV4IGQ2NTgwMGEzYjg5ZC4uZGI2NWU3N2JkMzczIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192
Y29kZWNfZW5jLmMNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zj
b2RlYy9tdGtfdmNvZGVjX2VuYy5jDQo+ID4gQEAgLTk0Myw3ICs5NDMsNyBAQCBzdGF0aWMgaW50
IHZiMm9wc192ZW5jX3N0YXJ0X3N0cmVhbWluZyhzdHJ1Y3QNCj4gPiB2YjJfcXVldWUgKnEsIHVu
c2lnbmVkIGludCBjb3VudCkNCj4gPiAgCQkgKiBGSVhNRTogVGhpcyBjaGVjayBpcyBub3QgbmVl
ZGVkIGFzIG9ubHkgYWN0aXZlDQo+ID4gYnVmZmVycw0KPiA+ICAJCSAqIGNhbiBiZSBtYXJrZWQg
YXMgZG9uZS4NCj4gPiAgCQkgKi8NCj4gPiAtCQlpZiAoYnVmLT5zdGF0ZSA9PSBWQjJfQlVGX1NU
QVRFX0FDVElWRSkgew0KPiA+ICsJCWlmIChidWYgJiYgYnVmLT5zdGF0ZSA9PSBWQjJfQlVGX1NU
QVRFX0FDVElWRSkgew0KPiA+ICAJCQltdGtfdjRsMl9kZWJ1ZygwLCAiWyVkXSBpZD0lZCwgdHlw
ZT0lZCwgJWQgLT4NCj4gPiBWQjJfQlVGX1NUQVRFX1FVRVVFRCIsDQo+ID4gIAkJCQkJY3R4LT5p
ZCwgaSwgcS0+dHlwZSwNCj4gPiAgCQkJCQkoaW50KWJ1Zi0+c3RhdGUpOw0K
