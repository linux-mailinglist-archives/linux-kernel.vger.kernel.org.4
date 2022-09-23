Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B74E5E7399
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIWGAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIWF76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:59:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF148E92
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:59:56 -0700 (PDT)
X-UUID: d4a48b00ac01403097c1bbd837fc79f5-20220923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/4P1HWtu5vRama8/OaTN8dJOzZLDz3akerMRjRFAQTc=;
        b=TJcCfvFUiXo1GtjuNfye16diJX0Fe/VoCS8YgR0AREPMKNr5cCSwAB8xaNnp5hYxlREaWOCq0yagBZ3NXolmAvSW/YB2SLdQ4QjmrNcfOx+fjjvxFvyo/b01IJcMWQuc4Nhf6m/0od2yEIXi/2esCNgQ2+mxFvJp7jreC19dhCE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:f708b9d0-b25d-41b7-ae42-0e908c0a8b2a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.11,REQID:f708b9d0-b25d-41b7-ae42-0e908c0a8b2a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:2c7cd2a2-dc04-435c-b19b-71e131a5fc35,B
        ulkID:2209231359512KR2Z993,BulkQuantity:0,Recheck:0,SF:17|19|823|824,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d4a48b00ac01403097c1bbd837fc79f5-20220923
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 544618674; Fri, 23 Sep 2022 13:59:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 23 Sep 2022 13:59:49 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 23 Sep 2022 13:59:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROVqmqls2NTgliEm12IeAUcJoGAIOWwoyKHN1ypx9MEzYVON0SI5xFeq1+lhbI1MIHQ/B0K+2rkiW5yUbvakDmU+NOteCWfNxVKnj4bnsK7HTQuSebUQ1zn+nC+0LPKJJucKu8vBsfxDh/0dzNKk+o1I+U9BB6MQRH+KNk4GJXI/yv9jYZHEP8SPCbtRMCXs8FxnhR0TnWyJyfvOIZMBDbJCyEb2X4BBfGXY2dfbf4e/I/Rw9MVXHT5iJAftskMDzthbXRy8jNezPU5q9l0jSWWji+9Qloa3QT5jdVx18xn3iRnq93Aa6qGGsAfU/rM1BwQU16oWwbGA2jCC2uGPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4P1HWtu5vRama8/OaTN8dJOzZLDz3akerMRjRFAQTc=;
 b=UKNq35saIXSzeHiAtlHS4ZodhD/b/kOu3i1HGaZDrlndiYsGoCAIFeGeUr5xv42kZUj1l5/xJzo3WqFA5OopLSC7oQF+q2Ph0JrQ7WAmy9Xa00eDm/ppvdI3+q6L6m3HxOLwiMMdK9O1wEbN+uI3ewO2hr9FZArc2t4xR2pqqlaZxSRI7S/3mVsuZvUiCib8pd0VDz02qKrEPPddufYpRyrNQ3zVhXAt3bmPqkQz3p6NY6+/0Pl3c4HUOMYoj5U0NVZj1U0cvIl8traGGIt/XNgIL6nrZPHzcnCjXLSCyefItTdn2HKDcY+banIWI13pF3hQfzGa9nIpAvbK7Xp9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4P1HWtu5vRama8/OaTN8dJOzZLDz3akerMRjRFAQTc=;
 b=fQrEkJb7a2FaPKHxVPyayH1/q5vBiVyLGtguaFbt/2mcitF5Z/I8GwRZtc/sY+WEpHUkAe9MeaKUxONexmhT2WAyH/6nK8FVJq1lVFWmAB1RifLQVrWSopJplYnQFum6ETUJ6Kew/q+gbEHD7s91wdaS4NIITj3Jn7gIoXokhQQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB4407.apcprd03.prod.outlook.com (2603:1096:4:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.7; Fri, 23 Sep
 2022 05:59:45 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed%7]) with mapi id 15.20.5676.007; Fri, 23 Sep 2022
 05:59:45 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>
Subject: Re: [PATCH v8,2/3]drm: mediatek: Adjust the dpi output format to
 MT8186
Thread-Topic: [PATCH v8,2/3]drm: mediatek: Adjust the dpi output format to
 MT8186
Thread-Index: AQHYzoFd0ogmTpHynEauAWww1DInV63shlgA
Date:   Fri, 23 Sep 2022 05:59:45 +0000
Message-ID: <a137c801f5263abaef8a13a14a1f4b24a5bcdf1b.camel@mediatek.com>
References: <1663850702-26529-1-git-send-email-xinlei.lee@mediatek.com>
         <1663850702-26529-3-git-send-email-xinlei.lee@mediatek.com>
In-Reply-To: <1663850702-26529-3-git-send-email-xinlei.lee@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB4407:EE_
x-ms-office365-filtering-correlation-id: 5d01430c-cc3e-4648-f128-08da9d28d0d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a55jgx/zMGtVlhH43zwwSLEfhQPoN/HaSLjuiu9D1DMOT4ydluAa0s1fJIogux8gTV/0VFhVHlQvGH9UJYWvFlEL7DE53Iem4Gl+IgxO6HbCj3UTbLQmKi7kbRhUHV98IQnfG7USo4blt/u4KTmDuhY9FenjvwgfxFSaq9r8EUBtdgXz0W1u4HkroJvNJkwblk9OGYJnRsqjlV4ydhBZ2fDT+7JgM8BvvDbBaIw167t1FVM2vykcl7+Nzd389ZPZ5rqVVdvSDnPmosPhevJA6MyBA8walsq9RjOttMO3VcuhBDIzj1LgwNMoaBYHwZrMmvwc5Xs4+wjvSSXnWZ2zqHjOPSsRsgog3L1Io/x768KVgd285M3uXPVjpe7bdkjdb2z+mqGi+jdhWVQIKspwM7aB+Wzy4gU9U9c1S0gkHV/xPsdwUJOKEUaJbFfzel91kkMWP33nPDwTd2ucPrHhlutcv9aqjrXaOM2hoNKU5X9G5ao0C58OoTWZkGqSpHqiU/UL8EZLm0GU+DGkLjcc++c4OpWeTe+Gjz9SqL5GNkcZt+ql3RsLd64kqFGDwL/RjgaGXyAG7OPa9lKoNghxsmlOzgu/DiUiCVBVJqNVqyOdtiGNg8JxGdn/tnpqtB2ozR1Xbj3jkfoaHOj9M8juyY74NhEm+ZZaa5nkO3MOT6IziiEkctz2+v88RkQCoZDN+IgRaf5CYO3bxBd+02Y6hyKBOoVO4U4q7nlKD6M5I0dWOa2HN9dyE8YCYEwplUkr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199015)(71200400001)(6486002)(36756003)(107886003)(66556008)(76116006)(8936002)(66476007)(110136005)(26005)(66946007)(38070700005)(8676002)(122000001)(2906002)(4326008)(38100700002)(41300700001)(54906003)(91956017)(86362001)(316002)(85182001)(5660300002)(6506007)(478600001)(83380400001)(66446008)(6512007)(2616005)(64756008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU92MkJCY3ZQMWRnOWRrQ2JhSjRrQTBCOStUeUNLakpRZnhJdGNoVHhzeTRm?=
 =?utf-8?B?WEZLVnhnU1BraXNzZVk4bFZuZGFFSGF1aU10NDlGYnBsWjJHcTVhY0VjejZH?=
 =?utf-8?B?RGJGVWFSTmxDRityRGFJRTlBVXhYUXhGdjFuSnl1cHZkYzhZZTd1Y292VW0r?=
 =?utf-8?B?R3V3MnBERjU5a2lMQUhGMDhicUZUaW13cW9OVlgwWlZKM0lPT2hvc1VjbzdZ?=
 =?utf-8?B?c1RmbDF5UmE4NTZVWlFNWkpXRFJpem5WYXB3aTVLMlNGUmNMNlAvNWF5ekEw?=
 =?utf-8?B?amwxR1Y3bjg4QTVycTRsaEJtd3UzNko4M3lSNzQ3NWRBZmhqYmcyZHB0YkFX?=
 =?utf-8?B?VUJXUE55dFU5YmhzVTl1RThoZ3ljOSt0NDdaN2Ftd3FZT29ROFdTNHc0SUF5?=
 =?utf-8?B?UG9EY1gyMmtZaVlGc0QvV3ovaFB4RmtJK2FiSFBZemsyaVlJVlErenBhSHYy?=
 =?utf-8?B?WGExTlNQN2I3bkVhbHdkNXlDWUZlcTVkbUtONHJINCt0QWVlcWs5dTdDR0JN?=
 =?utf-8?B?NG5wZ3ltS1pDMWxSL25DY2JzcmR4Q0FXZmR3NXNYd3FSWnE4UTdxNnpxVFZU?=
 =?utf-8?B?UDdTR3NuOUROdldJVFhMb3hyOU5vYVhJc1JUMkVWWVdsNzJCN0VleGNkZXow?=
 =?utf-8?B?SHlMamtCeVpiakJXWTRVVVNqWENlTlVsOXZHUFhFOUMzM1NjZi8vWkpzZGZD?=
 =?utf-8?B?UmZSVmIyajloa1RlUlNGWGhGWnlZanFDT0x0cnprdEswT1ZNamt4VGVJM2d3?=
 =?utf-8?B?djZPaTIxSG1kdlhHaE9PMWNqOEF2b3RIRHBvYW1CdHF3dTQzRjg4NGRkVFdm?=
 =?utf-8?B?RTlsdzdrWG0rcm03ZXJCaXVuQksrZGJCTm51dzQzcStaSTE4RTZmcHNOblgx?=
 =?utf-8?B?VnNVNDZBNXFiSzVFVGhIOUJmcmhvcXh3WWZjRkpleHJWRVRXK0VsU1hLeXlh?=
 =?utf-8?B?L0lFcWRNbmhsMmRYeGxhUkxSU3BtWmF5dlpmWE44RnF1d0UxMng5d1gxL2hV?=
 =?utf-8?B?a0NrM21aVnFwQUhVdHpBVjVTanBRdmNUTFVueVA2Sy9EeDF5TnhSbkQ5aDlw?=
 =?utf-8?B?UE1BVzBzUVBZc2tHWXJodEswcnQ2ZFpNNm9vZjNWakVIcm9Lai8rREdSNjY4?=
 =?utf-8?B?Y2I4TnJsQW4vSGZ4NE44QldNdTBHSjhzamFxQlh1UzkrcURpa20rNHFBa2RM?=
 =?utf-8?B?S1drZ3k2VndlemZBWUo1SlZJS2ZZd1BDblYxdlBYUVRqUW1zUnlDSC84eThw?=
 =?utf-8?B?NTE4SmpYeWYyYVBDUmJ0UGExYkhXN0NxTmc3ckpTcUttVFRBdENzck9NSW5W?=
 =?utf-8?B?cDI3TnBUTEZtR1paVFZJbkJpam5kbjc1SHRDRHBJcjQrVmt0MFFWYzZEWGNB?=
 =?utf-8?B?U2ZoOVMzbEg1b054RVdDdXBieDU1c2RXU2RUWFRVNmY1L0xsclJOWW4yQWZP?=
 =?utf-8?B?UmJRd0xHbURKOVQ4LzIwcFZRclUvOEM0Yy9FeFVIcjFIMjNESlNPVjVrZWFQ?=
 =?utf-8?B?RUY3NEs3dFRWV0RWMkFONmJHODk3NjQzelBmcVpwb0ZtRUgxRGl3ZVZOZHlE?=
 =?utf-8?B?UkhhaTljVjlMd0w0aFQvWjRmN0R4UnJHOGZiWTRMeURHUUc2LytjRUtQMkxI?=
 =?utf-8?B?U1JWeG5SUWg4V0hGalFQUUduN1hvWDRxSEM0NlcwOGtOWmFBekJLTzdWcUtm?=
 =?utf-8?B?SVB0K2hSdEVYU2NIMTZUK0ZlNFBSYlBpNmR6VlNCOFJycDQ0SVMvQjJyMnZi?=
 =?utf-8?B?ckpEYkZyRE43WU8xVzlaWmZVSGtSOTg1ck5NVDVHT0g1TkVYZU5RSE5QSnh5?=
 =?utf-8?B?aFZwc01JeTJqVW5VKzY5MTZLN1pNZVBKRThBbUxRcms4UkZlRURTaFdLWC9s?=
 =?utf-8?B?NTZET2E4OWFjUi9IK3FLQnZ3TnIreUxUckF1ZmR2VGJhL2pJZjVXSXJLckRk?=
 =?utf-8?B?elRoSWRmRXR6SnVVM242ZVcwVzNQRUVZWklhWlpTSlp4d01qYlVoVWlEM1Av?=
 =?utf-8?B?YXlJcTVqR0FpY29rUHhIbllvYXpYQ0NzQnhYelo0QTFyRzFjd1lqUUVUTVNH?=
 =?utf-8?B?THp4YWZlMGovRFpzL1plVFQxT3VKZmViZU84WTNaMmlLUnNBb25vaU53RU4w?=
 =?utf-8?Q?hMV+tCGHQ9DW0goO1RHYg7ou3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91B357C97617D5408296A80E2B68ECA7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d01430c-cc3e-4648-f128-08da9d28d0d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 05:59:45.3328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hx7bu3YzFhf4uqiUhhPzUjl0SRkMCw99TX2+yyCBBVVROSTEGrBbHKNE3G2N7redQRsxx90eIctr+saEGutQ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB4407
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFhpbmxlaToNCg0KRnJvbSB0aGUgY29kZSB5b3UgbW9kaWZ5LCBJIGRvIG5vdCB1bmRlcnN0
YW5kIHdoeSB0aGUgdGl0bGUgaXMgIkFkanVzdA0KdGhlIGRwaSBvdXRwdXQgZm9ybWF0IHRvIE1U
ODE4NiIuIFlvdSBqdXN0IGNhbGwgbW1zeXMgZHJpdmVyIGZ1bmN0aW9uDQp0byBzZXQgc2luZ2xl
IGVkZ2Ugb3IgZHVhbCBlZGdlLCBidXQgc2luZ2xlIGVkZ2Ugb3IgZHVhbCBlZGdlIGFscmVhZHkN
CmV4aXN0IGluIG90aGVyIFNvQyBhbmQgaXMgbm90IHNwZWNpYWwgaW4gTVQ4MTg2LiBTbyBJIHRo
aW5rIHlvdSBzaG91bGQNCmNoYW5nZSB0aGUgdGl0bGUgdG8gJ1NldCBkcGkgZm9ybWF0IGluIG1t
c3lzJw0KDQoNCk9uIFRodSwgMjAyMi0wOS0yMiBhdCAyMDo0NSArMDgwMCwgeGlubGVpLmxlZUBt
ZWRpYXRlay5jb20gd3JvdGU6DQo+IEZyb206IFhpbmxlaSBMZWUgPHhpbmxlaS5sZWVAbWVkaWF0
ZWsuY29tPg0KPiANCj4gRHVlIHRvIHRoZSBtdDgxODYgIGhhcmR3YXJlIGNoYW5nZXMsIHdlIG5l
ZWQgdG8gbW9kaWZ5IHRoZSBkcGkNCj4gb3V0cHV0IA0KPiBmb3JtYXQgY29ycmVzcG9uZGluZyB0
byB0aGUgbW1zeXMgcmVnaXN0ZXIobW1zeXNfYmFzZSsweDQwMCkuDQo+IA0KDQpUaGUgYmVsb3cg
ZGVzY3JpcHRpb24gaXMgbm90IHJlbGF0ZWQgdG8gdGhpcyBwYXRjaCBhbmQgaXQncyBjb21tb24g
d2l0aA0KbXQ4MTgzLCBzbyBJIHRoaW5rIHdlIGRvbid0IG5lZWQgYmVsb3cgZGVzY3JpcHRpb24u
DQoNCj4gQmVjYXVzZSBkaWZmZXJlbnQgc2luayBJQ3MgbWF5IHN1cHBvcnQgb3RoZXIgb3V0cHV0
IGZvcm1hdHMuDQo+IFRoZSBjdXJyZW50IERSTSBhcmNoaXRlY3R1cmUgc3VwcG9ydHMgcmV0cmll
dmluZyB0aGUgb3V0cHV0IGZvcm1hdCBvZg0KPiBhbGwgYnJpZGdlcyAoZWcgZHBpIGlzIGltcGxl
bWVudGVkIHZpYSBEUk0ncyAuYXRvbWljX2NoZWNrIGFuZA0KPiAuYXRvbWljX2dldF9vdXRwdXRf
YnVzX2ZtdHMgYW5kIC5hdG9taWNfZ2V0X2lucHV0X2J1c19mbXRzKS4NCj4gSWYgbm8gdW5pZmll
ZCBvdXRwdXQgZm9ybWF0IGlzIGZvdW5kLCB0aGUgZGVmYXVsdCBzb2MgZm9ybWF0DQo+IChNRURJ
QV9CVVNfRk1UX1JHQjg4OF8yWDEyX0xFIGluIG10ODE4NikgaXMgdXNlZC4NCj4gDQo+IFRoZXJl
Zm9yZSwgaWYgdGhlcmUgYXJlIG90aGVyIGZvcm1hdCBzaW5rIElDcyAoUkdCODg4X0REUi9SR0I4
ODhfU0RSKQ0KPiBpbg0KPiB0aGUgZnV0dXJlLCB0aGUgc2luayBJQyBuZWVkcyB0byBhZGQgdGhl
IGZ1bmMgaW1wbGVtZW50YXRpb24NCj4gbWVudGlvbmVkDQo+IGFib3ZlIG5lZWRzIHRvIGJlIGFk
ZGVkLiANCj4gQW5kIHRoZSBkcm0gYXJjaGl0ZWN0dXJlIHdpbGwgc2VsZWN0IHRoZSBhcHByb3By
aWF0ZSBmb3JtYXQgdG8gY2hhbmdlDQo+IHRoZSBkcGkgb3V0cHV0Lg0KPiANCj4gQ28tZGV2ZWxv
cGVkLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
WGlubGVpIExlZSA8eGlubGVpLmxlZUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcGkuYyB8IDExICsrKysrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rw
aS5jDQo+IGluZGV4IDYzMGE0ZTMwMWVmNi4uYmQxODcwYTg1MDRhIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gQEAgLTE1LDYgKzE1LDcgQEANCj4gICNpbmNsdWRlIDxs
aW51eC9vZl9ncmFwaC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BpbmN0cmwvY29uc3VtZXIuaD4N
Cj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51
eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4N
Cj4gIA0KPiAgI2luY2x1ZGUgPHZpZGVvL3ZpZGVvbW9kZS5oPg0KPiBAQCAtMzAsNiArMzEsNyBA
QA0KPiAgI2luY2x1ZGUgIm10a19kaXNwX2Rydi5oIg0KPiAgI2luY2x1ZGUgIm10a19kcGlfcmVn
cy5oIg0KPiAgI2luY2x1ZGUgIm10a19kcm1fZGRwX2NvbXAuaCINCj4gKyNpbmNsdWRlICJtdGtf
ZHJtX2Rydi5oIg0KPiAgDQo+ICBlbnVtIG10a19kcGlfb3V0X2JpdF9udW0gew0KPiAgCU1US19E
UElfT1VUX0JJVF9OVU1fOEJJVFMsDQo+IEBAIC04Miw2ICs4NCw3IEBAIHN0cnVjdCBtdGtfZHBp
IHsNCj4gIAlzdHJ1Y3QgcGluY3RybF9zdGF0ZSAqcGluc19kcGk7DQo+ICAJdTMyIG91dHB1dF9m
bXQ7DQo+ICAJaW50IHJlZmNvdW50Ow0KPiArCXN0cnVjdCBkZXZpY2UgKm1tc3lzX2RldjsNCj4g
IH07DQo+ICANCj4gIHN0YXRpYyBpbmxpbmUgc3RydWN0IG10a19kcGkgKmJyaWRnZV90b19kcGko
c3RydWN0IGRybV9icmlkZ2UgKmIpDQo+IEBAIC0xMzUsNiArMTM4LDcgQEAgc3RydWN0IG10a19k
cGlfeWNfbGltaXQgew0KPiAgICogQHl1djQyMl9lbl9iaXQ6IEVuYWJsZSBiaXQgb2YgeXV2NDIy
Lg0KPiAgICogQGNzY19lbmFibGVfYml0OiBFbmFibGUgYml0IG9mIENTQy4NCj4gICAqIEBwaXhl
bHNfcGVyX2l0ZXI6IFF1YW50aXR5IG9mIHRyYW5zZmVycmVkIHBpeGVscyBwZXIgaXRlcmF0aW9u
Lg0KPiArICogQGVkZ2VfY2ZnX2luX21tc3lzOiBJZiB0aGUgZWRnZSBjb25maWd1cmF0aW9uIGZv
ciBEUEkncyBvdXRwdXQNCj4gbmVlZHMgdG8gYmUgc2V0IGluIE1NU1lTLg0KPiAgICovDQo+ICBz
dHJ1Y3QgbXRrX2RwaV9jb25mIHsNCj4gIAl1bnNpZ25lZCBpbnQgKCpjYWxfZmFjdG9yKShpbnQg
Y2xvY2spOw0KPiBAQCAtMTUzLDYgKzE1Nyw3IEBAIHN0cnVjdCBtdGtfZHBpX2NvbmYgew0KPiAg
CXUzMiB5dXY0MjJfZW5fYml0Ow0KPiAgCXUzMiBjc2NfZW5hYmxlX2JpdDsNCj4gIAl1MzIgcGl4
ZWxzX3Blcl9pdGVyOw0KPiArCWJvb2wgZWRnZV9jZmdfaW5fbW1zeXM7DQo+ICB9Ow0KPiAgDQo+
ICBzdGF0aWMgdm9pZCBtdGtfZHBpX21hc2soc3RydWN0IG10a19kcGkgKmRwaSwgdTMyIG9mZnNl
dCwgdTMyIHZhbCwNCj4gdTMyIG1hc2spDQo+IEBAIC00NDksOCArNDU0LDEyIEBAIHN0YXRpYyB2
b2lkIG10a19kcGlfZHVhbF9lZGdlKHN0cnVjdCBtdGtfZHBpDQo+ICpkcGkpDQo+ICAJCW10a19k
cGlfbWFzayhkcGksIERQSV9PVVRQVVRfU0VUVElORywNCj4gIAkJCSAgICAgZHBpLT5vdXRwdXRf
Zm10ID09DQo+IE1FRElBX0JVU19GTVRfUkdCODg4XzJYMTJfTEUgPw0KPiAgCQkJICAgICBFREdF
X1NFTCA6IDAsIEVER0VfU0VMKTsNCj4gKwkJaWYgKGRwaS0+Y29uZi0+ZWRnZV9jZmdfaW5fbW1z
eXMpDQo+ICsJCQltdGtfbW1zeXNfZGRwX2RwaV9mbXRfY29uZmlnKGRwaS0+bW1zeXNfZGV2LA0K
PiBNVEtfRFBJX1JHQjg4OF9ERFJfQ09OKTsNCj4gIAl9IGVsc2Ugew0KPiAgCQltdGtfZHBpX21h
c2soZHBpLCBEUElfRERSX1NFVFRJTkcsIEREUl9FTiB8IEREUl80UEhBU0UsDQo+IDApOw0KPiAr
CQlpZiAoZHBpLT5jb25mLT5lZGdlX2NmZ19pbl9tbXN5cykNCj4gKwkJCW10a19tbXN5c19kZHBf
ZHBpX2ZtdF9jb25maWcoZHBpLT5tbXN5c19kZXYsDQo+IE1US19EUElfUkdCODg4X1NEUl9DT04p
Ow0KPiAgCX0NCj4gIH0NCj4gIA0KPiBAQCAtNzc4LDggKzc4NywxMCBAQCBzdGF0aWMgaW50IG10
a19kcGlfYmluZChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IHN0cnVjdCBkZXZpY2UgKm1hc3Rlciwg
dm9pZCAqZGF0YSkNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2RwaSAqZHBpID0gZGV2X2dldF9kcnZk
YXRhKGRldik7DQo+ICAJc3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXYgPSBkYXRhOw0KPiArCXN0
cnVjdCBtdGtfZHJtX3ByaXZhdGUgKnByaXYgPSBkcm1fZGV2LT5kZXZfcHJpdmF0ZTsNCj4gIAlp
bnQgcmV0Ow0KPiAgDQo+ICsJZHBpLT5tbXN5c19kZXYgPSBwcml2LT5tbXN5c19kZXY7DQo+ICAJ
cmV0ID0gZHJtX3NpbXBsZV9lbmNvZGVyX2luaXQoZHJtX2RldiwgJmRwaS0+ZW5jb2RlciwNCj4g
IAkJCQkgICAgICBEUk1fTU9ERV9FTkNPREVSX1RNRFMpOw0KPiAgCWlmIChyZXQpIHsNCg==
