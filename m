Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1DD6B7008
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCMHTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjCMHTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:19:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9EF28848;
        Mon, 13 Mar 2023 00:19:22 -0700 (PDT)
X-UUID: 5ccf64f4c16f11eda06fc9ecc4dadd91-20230313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AfIHNGxBodaddaUXql0YHdgTVjKSxz1WXWGeUwU9mfM=;
        b=L7FBKkzZW0WtPWOrKLrXyatlrMlTGp7ZduFeGZZHv2PgfowebIZFdQrSshme3Rrkxwstye80N4RindmVQCf/rp5/Sxv/7EcWwnKSC2e49ZhKANGxdHPa39YAYc8lIbJEVXYJqv5vwAMkijQ5UtnOfEABMY4gmhCX1TP2jR0ZuQc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:797c4865-ca5e-4088-8572-a1b5218e6e13,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.20,REQID:797c4865-ca5e-4088-8572-a1b5218e6e13,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:dbea2d28-564d-42d9-9875-7c868ee415ec,B
        ulkID:23031315191793JUKCE5,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 5ccf64f4c16f11eda06fc9ecc4dadd91-20230313
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 646104390; Mon, 13 Mar 2023 15:19:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 13 Mar 2023 15:19:15 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 13 Mar 2023 15:19:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KL9qq9FHm+Vi6xJZ7qLQYK6xHSSjHOLyHNQJrDoVmuYFF3TNX7s+iNXtcyWVIGuowp+S+DnzI01B1A8VltXwqSxyRkBMmMnLkHNs9F/1hXd2p4iJKYg2MIK4bx3EaXNxY0daRm0XDzWOtC8G+no+urfpfr8g+WWQVz3eM6IqdA/WVMLwPI5i4xHVew/f2GBOElwYINmNDmmBb05wAm01GwMzMIQIc22H3QX7d1V/DRG0gaFGp62XaKdwXaRRnrY/SRiRPE16iGNx+47q5hiAAwlbmiE8UaGJVn0hZnpQccjrzV1KBl01wumsB7cyOTgnkT96JZIjvvWsn/6zRUZquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfIHNGxBodaddaUXql0YHdgTVjKSxz1WXWGeUwU9mfM=;
 b=YEN7Sae2hN9qvOd47Z4Opl14nT1Ec8hdjb2t1yG0VxE6ijESFNaSOhOPCVKl45mWXpYes/W1PO3ByGDdZK+3o+C2JvppwVKlNFjzkWJjtlytVBKMrYmjfSTQT3DKlmeB4ieUvPnEp3pp4IkewC6J7FNxwLAib9yChsQ2CsGPpgg73w6soDthDH0ipKKjxp7n91qghhwEjDpPeZGnN7Lnuv9j6ki7Y8VJZtUQYaWO1+UJTO4ZGiDnnISBzEMQSdIUzKIZyunvWF/U18n3S7/tGhJo3USZY1vJbCgt82+hSnackx7H8KFF4WbB0gpSTWcHioxqO97LdJM4nSB0WM6f3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfIHNGxBodaddaUXql0YHdgTVjKSxz1WXWGeUwU9mfM=;
 b=ffNwmQP0Sv9UX3F8naLil7z5VI0ZXHF9za+xEFqMl3LktvHOfiAsGk3QgkLCmRUGfxu0YtU5KFGYqAAEiaP0nkydVzXQ/+T1L2UDrlGyiBDjTB9y9lMAJ10hkyQkxn57CpuRxK02XDPfz2lrrVoICzAbLjdEdPbn1wQczDiqY5o=
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com (2603:1096:820:8::11)
 by KL1PR03MB5492.apcprd03.prod.outlook.com (2603:1096:820:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 07:19:12 +0000
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::dd54:60c1:df32:bc65]) by KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::dd54:60c1:df32:bc65%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 07:19:12 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>, "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [RESEND v5 3/3] dt-bindings: mediatek: add ethdr definition for
 mt8195
Thread-Topic: [RESEND v5 3/3] dt-bindings: mediatek: add ethdr definition for
 mt8195
Thread-Index: AQHYevHJrq9yB8ENHke0ffw2zZ6atq1FhgmAgAAgGQCBtFwwAA==
Date:   Mon, 13 Mar 2023 07:19:11 +0000
Message-ID: <915c9eebf8412fc092686626ce02e45a5d0f7841.camel@mediatek.com>
References: <20220608043852.4980-1-rex-bc.chen@mediatek.com>
         <20220608043852.4980-4-rex-bc.chen@mediatek.com>
         <1654695907.376302.1272085.nullmailer@robh.at.kernel.org>
         <b9f62fe5e39d23d8ce64773814fbb9f5ba1a0a21.camel@mediatek.com>
In-Reply-To: <b9f62fe5e39d23d8ce64773814fbb9f5ba1a0a21.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5175:EE_|KL1PR03MB5492:EE_
x-ms-office365-filtering-correlation-id: d7a14694-dfe0-40d7-b516-08db23933e80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ehrb8ORr5TLxbxM52bMQmgAE6h16M4Vn2Z8BuwwtvTqD3FyS3h3A2NiHknA6cQQDJofaa0h9VVk363R17ACzb8TTPyjKzM99LTQ114innTaO9g9AoQibGikXNKw5ByKSHm79ZaJx+UHaTuSOWhuAcxpamBHnl4y0wquHj6G14KoBbMoeUxGxOv9+vl/9KnYBuSWEHcQMdT3D/3M4s+5AqpRjuUOWSQp79dZ+sRX3cLfRielfVgJx20ZzvSqjlABN40ub11gWCYcW5LO0PhbLamvpMXrxY8kY6GfljSoz1EwqiVPQTfvVqiqQDYWd68Wt9xavZRlh/RirAjbBt/iJVtk19+BOqz5tZ9ibjrkUCWlwnUuGz1CCLCzUow66VMAA9x7RZ37mh1pnfj3QZZ2mkM/WHppuUPwWsZsabmWy74rsh1ayZUG06GsKnPqqgZCSaMGE7KDICUF9bF+lX6DTn8RRtLsWoYO+2vU8w5nTkeBmG/cYIgGOhRzwuPJ5obPOB0+cLf+5qXfglUHPFkgg42A1K8JP4c/Fl8lU70q05RL8EfVJ1y5LOGUqrs7lV5KseUUb5giZ2oy2bHf4/tOIYb/3hv47dyEAehbDVzb14GL8QFXRksOIa8Zfy5feBpjlOyVwzmgkx7wee8D3OePqQp9MClqrQCKgSI8V6zK9yyDObOTIQYELwj3k7W3IPBAT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5175.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199018)(2616005)(186003)(7416002)(6512007)(6506007)(26005)(83380400001)(8936002)(38070700005)(38100700002)(5660300002)(966005)(6486002)(66556008)(8676002)(64756008)(66476007)(91956017)(4326008)(66446008)(2906002)(71200400001)(76116006)(41300700001)(66946007)(478600001)(122000001)(316002)(86362001)(54906003)(36756003)(85182001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU5wSndYVTNwdXU4NmR2WVV3Mmp3dWFXck1SQXhOS3FycEYzdzd3bkJPamx0?=
 =?utf-8?B?UEtRTkdUSUx1UUVhN1FNNnVqWDRMeDhyS2sxMXNBdUFyUHJxNUE4VEpHa3JI?=
 =?utf-8?B?dmtqNklvQ3hsZ3BYd0p1MXlyKy9QQW9qeHlGRHVNZVFqdHY0cGpaV0lYYmln?=
 =?utf-8?B?UWhNZllzVUVOYkpPUTczb2hLeTdGeUkyN2RpM25tM1BTanJqR3kxdWZQN3dO?=
 =?utf-8?B?cnU5OGdLbjc2TC9Wa1ZqUHZJcGhGRVdxSkZwY3ZxT2g4YXdtWE83NGpVNUFR?=
 =?utf-8?B?am9ZMjJJUHprUDI2NHhab0NWWjdSR3lYWVdQcUhONkJ4aWZHNUMrdThSYTFW?=
 =?utf-8?B?WkdHajJQeG9Telc1S1pxcGlxUGJWclVucEcwN2lxWnJjeC9RVmFVZ09EM24y?=
 =?utf-8?B?ay9WR2NqWHltL1Mya09hMXN2Y085bHc4K0V2cHZnUmE5R1RJelpEYm01SHBK?=
 =?utf-8?B?RElrZU9pdWl3bUNvbWU1bkEvSlJTTW1oOEJaaHFpbGZldHpFbEFlQ3RxWExT?=
 =?utf-8?B?NTkwbGppQm9NaytFb2d6TDhSeksvTDI0Y3FGaDdqT0dYUDJ4WUp0S0VTSmgz?=
 =?utf-8?B?Z29tWmRYbmx4QlRXUmxXTzRnZ1UyRUhmNmFBbWlHc1AxTUpsUjVUcnBPRjU3?=
 =?utf-8?B?MUd0OXN3L3lvRXBXdm1OZDV6cTliZUF0dG02VzhsMjJ1NVg3Q0ZQUkphWTNR?=
 =?utf-8?B?STk2MnVPMnNVZ2V5VlBQa3Z6Vjl4WDlPcDFtYkdpRUJRZjRvUG90QWtQTjVW?=
 =?utf-8?B?RnJHSHA1VDh3b1NwVXd3elZWcGpXemg2Q3VzQ0ZpTDB6dlpWRy90TTN2dENM?=
 =?utf-8?B?ZmplQkdJZVRsNjgybzNYa3c2K3lkZy96RG95SGxyTGk4K1dIV3E3T3pzMFZs?=
 =?utf-8?B?dDRBLzhaRkxFUVppT09SMCtVWkV5WjMybzQ4MHFuR21HZ0ZUbVBGK09ndUhK?=
 =?utf-8?B?Vy9kQXdZdW9TN1Yrc3IyTmJCem5lb2hFM1JRVjc5T1Q0c1QyV3dJWkxFUzdq?=
 =?utf-8?B?Q2VFeVczVWxvSnR6VzR2eXdCVitodTZKWm5Ob3ByblRWVUd4eVlsbnVGS3BB?=
 =?utf-8?B?dFNpN0RlRDBPV3lJSjdyOHltbWhENTFLUEpBSVhYMnA5Tlpwc21IcHEwTDNN?=
 =?utf-8?B?cWlQNnhqVVMrTWVKSlJyZVl1eGw5aUJKVzZQenA4V0NVeGQ4VXUvMS9qd3Bp?=
 =?utf-8?B?SysremU2MFBmZ01ieDBiRHB4eXVMSzNENHZSajZISm5oNnJFN09PSitKOHZY?=
 =?utf-8?B?RDVWdzI4ZFJhMTF3bW9yWVpLd05sYUdld3pFN0M0dDJqQVZzN3lhUVByZEMy?=
 =?utf-8?B?MFlTL1JOdVJNTWVzcFY4Vi80T3duZlprNXNzUDBvZU9NRTEyODNGdkxmRGNa?=
 =?utf-8?B?dHpqVjh5T2tlTVZUOEFkak1QWG81V3Zham4vMjFtSERoTjZmZWIvWkFSeXRC?=
 =?utf-8?B?M1dCeG5pY3hSWGhEYUFOVUpEK3VzNWRGeENaRUNEeFdFcGRKZUxubDdFblZD?=
 =?utf-8?B?emNtUUV2anlzbzZEenJ4VlVjMGQ3QThGS1o3WHF6MVpnTVVoMXFMY3hiZG1t?=
 =?utf-8?B?bjhQWEpwbHYrSjlEaWFhM1NvOFY0L2plaHdzY2dRTUxHaXpWT0E0N0FkVGNR?=
 =?utf-8?B?eWRObVpzcW0wUU9VM2FPNlF3OXI1YmpyOEZBM0Rpb1plbDJRKzNndmhJQmhw?=
 =?utf-8?B?RzNqV3dhWVFNeUNuVmFWZ1dNRVdzYTNVRUVDSmZyY3RseVdrUXRoNkVqNEV4?=
 =?utf-8?B?WFAvN0lXSTNPckZYRVRRZ3hVVUQ2UUIwVmwrd2tqWEZURldYM1loRHU4cUJt?=
 =?utf-8?B?M3o3YkVuaFZ2YW9OejZmRkVObU5CMnVWMk55NUJjNjNua2t4M1VCbUJtNER0?=
 =?utf-8?B?b2NNUHFyUHBTZnZhcXpTOWp0RHNzazV6WE8wdHRVQXpZQkRnYkZlOUFmNWd0?=
 =?utf-8?B?dnBQcmljM0ROZStteWxxMkhLT2N3M3pBUnRPUXhjVjBEamJhcFF0ZXVFT012?=
 =?utf-8?B?NmlKOEJHRXF2ZU15ZEJHb09DRmtQQy9yWjFPSERFNUk4L1FCYVhqbTU0Qk1G?=
 =?utf-8?B?Vi9QMjFUNHh0dnFkTEVKcmZpaFVONzZtOUFSVDBEQzUyRnhzY2JTQkdlVlBt?=
 =?utf-8?B?Ny9RY3NCczJsa0dEN1QxWlFpQ2dZZmJFYk1sL0JRTkFOQ0VjMFNEVCt2a0Yv?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <481EBB19C636654DB36343D9A40EA272@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5175.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a14694-dfe0-40d7-b516-08db23933e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 07:19:11.8219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+qNSusymvkN5B87QaQfz9/1OSmo7XF67Zy0vv15yspC+AwIXMOkurXNYWbEChQie2bKPZsFxU/iONG3E7QKIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5492
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMjItMDYtMDggYXQgMjM6NDAgKzA4MDAsIFJleC1CQyBDaGVuIHdyb3RlOg0K
PiBPbiBXZWQsIDIwMjItMDYtMDggYXQgMjE6NDUgKzA4MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0K
PiA+IE9uIFdlZCwgMDggSnVuIDIwMjIgMTI6Mzg6NTIgKzA4MDAsIEJvLUNoZW4gQ2hlbiB3cm90
ZToNCj4gPiA+IEZyb206ICJOYW5jeS5MaW4iIDxuYW5jeS5saW5AbWVkaWF0ZWsuY29tPg0KPiA+
ID4gDQo+ID4gPiBBZGQgdmRvc3lzMSBFVEhEUiBkZWZpbml0aW9uLg0KPiA+ID4gDQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBOYW5jeS5MaW4gPG5hbmN5LmxpbkBtZWRpYXRlay5jb20+DQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBCby1DaGVuIENoZW4gPHJleC1iYy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4g
PiA+IFJldmlld2VkLWJ5OiBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9yZz4N
Cj4gPiA+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+ID4gPiBh
bmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gPiBSZXZpZXdlZC1i
eTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0K
PiA+ID4gVGVzdGVkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+ID4gPiBhbmdl
bG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAu
Li4vZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxldGhkci55YW1sICAgICAgfCAxODgNCj4gPiA+
ICsrKysrKysrKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxODggaW5zZXJ0aW9u
cygrKQ0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZXRoZHINCj4gPiA+IC55
DQo+ID4gPiBhbWwNCj4gPiA+IA0KPiA+IA0KPiA+IE15IGJvdCBmb3VuZCBlcnJvcnMgcnVubmlu
ZyAnbWFrZSBEVF9DSEVDS0VSX0ZMQUdTPS1tDQo+ID4gZHRfYmluZGluZ19jaGVjaycNCj4gPiBv
biB5b3VyIHBhdGNoIChEVF9DSEVDS0VSX0ZMQUdTIGlzIG5ldyBpbiB2NS4xMyk6DQo+ID4gDQo+
ID4geWFtbGxpbnQgd2FybmluZ3MvZXJyb3JzOg0KPiA+IA0KPiA+IGR0c2NoZW1hL2R0YyB3YXJu
aW5ncy9lcnJvcnM6DQo+ID4gRXJyb3I6DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZXRoZHIuZQ0KPiA+IHhhDQo+ID4gbXBs
ZS5kdHM6NzEuNDAtNDEgc3ludGF4IGVycm9yDQo+ID4gRkFUQUwgRVJST1I6IFVuYWJsZSB0byBw
YXJzZSBpbnB1dCB0cmVlDQo+ID4gbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmxpYjoz
ODM6DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssZXRoZHIuZQ0KPiA+IHhhDQo+ID4gbXBsZS5kdGJdIEVycm9yIDENCj4gPiBt
YWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLg0KPiA+IG1ha2U6ICoq
KiBbTWFrZWZpbGU6MTQwNDogZHRfYmluZGluZ19jaGVja10gRXJyb3IgMg0KPiA+IA0KPiA+IGRv
YyByZWZlcmVuY2UgZXJyb3JzIChtYWtlIHJlZmNoZWNrZG9jcyk6DQo+ID4gDQo+ID4gU2VlIGh0
dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvDQo+ID4gDQo+ID4gVGhpcyBjaGVjayBj
YW4gZmFpbCBpZiB0aGVyZSBhcmUgYW55IGRlcGVuZGVuY2llcy4gVGhlIGJhc2UgZm9yIGENCj4g
PiBwYXRjaA0KPiA+IHNlcmllcyBpcyBnZW5lcmFsbHkgdGhlIG1vc3QgcmVjZW50IHJjMS4NCj4g
PiANCj4gPiBJZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycgYW5kIGRp
ZG4ndCBzZWUgdGhlIGFib3ZlDQo+ID4gZXJyb3IocyksIHRoZW4gbWFrZSBzdXJlICd5YW1sbGlu
dCcgaXMgaW5zdGFsbGVkIGFuZCBkdC1zY2hlbWEgaXMNCj4gPiB1cA0KPiA+IHRvDQo+ID4gZGF0
ZToNCj4gPiANCj4gPiBwaXAzIGluc3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+ID4gDQo+ID4g
UGxlYXNlIGNoZWNrIGFuZCByZS1zdWJtaXQuDQo+ID4gDQo+IA0KPiBIZWxsbyBSb2IsDQo+IA0K
PiBJIGFtIG5vdCBzdXJlIHdoeSB0aGVyZSBpcyB0aGlzIGVycm9yLg0KPiBCdXQgZnJvbSBteSBy
dW5uaW5nIHJlc3VsdDogbGluZSA3MSBpbiBtZWRpYXRlayxldGhkci5leGFtcGxlLmR0cyBpcw0K
PiAicmVzZXRzID0gPCZ2ZG9zeXMxIE1UODE5NV9WRE9TWVMxX1NXMV9SU1RfQl9IRFJfVkRPX0ZF
MF9ETF9BU1lOQz4sIg0KPiANCj4gVGhpcyByZXNldCBkZWZpbmUgaXMgaW4gcHJldmlvdXMgcGF0
Y2ggb2YgdGhpcyBzZXJpZXMuDQo+IEkgZG9uJ3Qga25vdyBob3cgdG8gYXZvaWQgdGhpcy4NCj4g
DQo+IEFuZCBJIGFsc28ganVzdCBnb3QgdGhpczoNCj4gLi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxldGhkci5lDQo+IHhhDQo+IG1w
bGUuZHRiOiBoZHItZW5naW5lQDFjMTE0MDAwOiBtZWRpYXRlayxnY2UtY2xpZW50LXJlZzowOg0K
PiBbNDI5NDk2NzI5NSwNCj4gNywgMTYzODQsIDQwOTYsIDQyOTQ5NjcyOTUsIDcsIDIwNDgwLCA0
MDk2LCA0Mjk0OTY3Mjk1LCA3LCAyODY3MiwNCj4gNDA5NiwNCj4gNDI5NDk2NzI5NSwgNywgMzY4
NjQsIDQwOTYsIDQyOTQ5NjcyOTUsIDcsIDQwOTYwLCA0MDk2LCA0Mjk0OTY3Mjk1LA0KPiA3LA0K
PiA0NTA1NiwgNDA5NiwgNDI5NDk2NzI5NSwgNywgNDkxNTIsIDQwOTZdIGlzIHRvbyBsb25nDQo+
ICAgICAgICAgRnJvbSBzY2hlbWE6DQo+IC4vRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZXRoZHIueQ0KPiBhbQ0KPiBsDQo+IC4vRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWss
ZXRoZHIuZQ0KPiB4YQ0KPiBtcGxlLmR0YjogaGRyLWVuZ2luZUAxYzExNDAwMDogbWVkaWF0ZWss
Z2NlLWNsaWVudC1yZWc6IFtbNDI5NDk2NzI5NSwNCj4gNywgMTYzODQsIDQwOTYsIDQyOTQ5Njcy
OTUsIDcsDQo+IDIwNDgwLCA0MDk2LCA0Mjk0OTY3Mjk1LCA3LCAyODY3MiwgNDA5NiwgNDI5NDk2
NzI5NSwgNywgMzY4NjQsIDQwOTYsDQo+IDQyOTQ5NjcyOTUsIDcsIDQwOTYwLCA0MDk2LCA0Mjk0
OTY3Mjk1LCA3LCA0NTA1NiwgNDA5NiwgNDI5NDk2NzI5NSwNCj4gNywNCj4gNDkxNTIsIDQwOTZd
XSBpcyB0b28gc2hvcnQNCj4gICAgICAgICBGcm9tIHNjaGVtYToNCj4gLi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxldGhkci55DQo+
IGFtDQo+IGwNCj4gDQo+IElzIHRoZXJlIGFueSBzdWdnZXN0aW9uPw0KPiANCj4gQlJzLA0KPiBC
by1DaGVuDQoNCg0KSGkgUm9iLA0KDQpJIGFsc28gZ290IHRoZSBzYW1lIHR3byBtZXNzYWdlcyBh
cyBCTy1DaGVuIHdoZW4gcnVubmluZw0KZHRfYmluZGluZ19jaGVjayBbMV0uIA0KDQpJZiBJIHJl
bW92ZSB0aGUgZm9sbG93aW5nIGl0ZW1zL21pbkl0ZW1zL21heEl0ZW1zIGluIHRoZSBtZWRpYXRl
ayxnY2UtDQpjbGllbnQgcHJvcGVydHksIHRoZSB0d28gbWVzc2FnZSBkaXNhcHBlYXIuIEkgZG9u
J3Qga25vdyB3aGF0J3Mgd3JvbmcNCndpdGggdGhlIG9yaWdpbmFsIHN5bnRheC4gRG8geW91IGhh
dmUgYW55IHN1Z2dlc3Rpb25zIGZvciB0aGlzPw0KDQotICAgIGl0ZW1zOg0KLSAgICAgIGl0ZW1z
Og0KLSAgICAgICAgLSBkZXNjcmlwdGlvbjogcGhhbmRsZSBvZiBHQ0UNCi0gICAgICAgIC0gZGVz
Y3JpcHRpb246IEdDRSBzdWJzeXMgaWQNCi0gICAgICAgIC0gZGVzY3JpcHRpb246IHJlZ2lzdGVy
IG9mZnNldA0KLSAgICAgICAgLSBkZXNjcmlwdGlvbjogcmVnaXN0ZXIgc2l6ZQ0KLSAgICBtaW5J
dGVtczogNw0KLSAgICBtYXhJdGVtczogNw0KDQoNClsxXS4NCkRvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGV0aGRyLmV4YW1wDQpsZS5k
dGINCi9wcm9qL210azE5MzQ3L2Nyb3Mvc3JjL3RoaXJkX3BhcnR5L2tlcm5lbC92NS4xMC9Eb2N1
bWVudGF0aW9uL2RldmljZXRyDQplZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVr
LGV0aGRyLmV4YW1wbGUuZHRiOiANCmhkci1lbmdpbmVAMWMxMTQwMDA6IG1lZGlhdGVrLGdjZS1j
bGllbnQtcmVnOjA6IFs0Mjk0OTY3Mjk1LCA3LCAxNjM4NCwNCjQwOTYsIDQyOTQ5NjcyOTUsIDcs
IDIwNDgwLCA0MDk2LCA0Mjk0OTY3Mjk1LCA3LCAyODY3MiwgNDA5NiwNCjQyOTQ5NjcyOTUsIDcs
IDM2ODY0LCA0MDk2LCA0Mjk0OTY3Mjk1LCA3LCA0MDk2MCwgNDA5NiwgNDI5NDk2NzI5NSwgNywN
CjQ1MDU2LCA0MDk2LCA0Mjk0OTY3Mjk1LCA3LCA0OTE1MiwgNDA5Nl0gaXMgdG9vIGxvbmcNCiAg
ICAgICAgRnJvbSBzY2hlbWE6DQovcHJvai9tdGsxOTM0Ny9jcm9zL3NyYy90aGlyZF9wYXJ0eS9r
ZXJuZWwvdjUuMTAvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cg0KZWUvYmluZGluZ3MvZGlzcGxheS9t
ZWRpYXRlay9tZWRpYXRlayxldGhkci55YW1sDQovcHJvai9tdGsxOTM0Ny9jcm9zL3NyYy90aGly
ZF9wYXJ0eS9rZXJuZWwvdjUuMTAvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cg0KZWUvYmluZGluZ3Mv
ZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxldGhkci5leGFtcGxlLmR0YjogDQpoZHItZW5naW5l
QDFjMTE0MDAwOiBtZWRpYXRlayxnY2UtY2xpZW50LXJlZzogW1s0Mjk0OTY3Mjk1LCA3LCAxNjM4
NCwNCjQwOTYsIDQyOTQ5NjcyOTUsIDcsIDIwNDgwLCA0MDk2LCA0Mjk0OTY3Mjk1LCA3LCAyODY3
MiwgNDA5NiwNCjQyOTQ5NjcyOTUsIDcsIDM2ODY0LCA0MDk2LCA0Mjk0OTY3Mjk1LCA3LCA0MDk2
MCwgNDA5NiwgNDI5NDk2NzI5NSwgNywNCjQ1MDU2LCA0MDk2LCA0Mjk0OTY3Mjk1LCA3LCA0OTE1
MiwgNDA5Nl1dIGlzIHRvbyBzaG9ydA0KICAgICAgICBGcm9tIHNjaGVtYToNCi9wcm9qL210azE5
MzQ3L2Nyb3Mvc3JjL3RoaXJkX3BhcnR5L2tlcm5lbC92NS4xMC9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyDQplZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGV0aGRyLnlhbWwNCg0K
DQpSZWdhcmRzLA0KTmFuY3kNCj4gDQo=
