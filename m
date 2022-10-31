Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28662613009
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJaF6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJaF6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:58:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7360EB7E2;
        Sun, 30 Oct 2022 22:58:02 -0700 (PDT)
X-UUID: 6368ce3d5dd6457882673d8166331921-20221031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uUXBGanDaxexnhsii8Sp9KhljrAmqVGsOXx45NKzA6A=;
        b=f2YM/JcbCT36DcFzKRsW4GISFkbJE0YTvA0u84RrKgH8iosjnzwRBcDvbQuo/JPXqRZKGWWzZUu045znqjJ13J5zUfKjvqVUIfLJ6oYYqD8ObcEbHE+9VFdJDYLox70IZIp5HDhoeafIT4aFUlZkzCUnY6ftBcmLTzjY0aQ5Oh0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:f7d84be2-7600-4ee4-bff6-08bcef76a220,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.12,REQID:f7d84be2-7600-4ee4-bff6-08bcef76a220,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:d22f1e81-3116-4fbc-b86b-83475c3df513,B
        ulkID:2210311357596EYDV3AN,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6368ce3d5dd6457882673d8166331921-20221031
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 897885843; Mon, 31 Oct 2022 13:57:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 31 Oct 2022 13:57:56 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 31 Oct 2022 13:57:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy2fwkKKL3O7Rcm1F99Eiy1jvIsH1nRvslIqNDbfUZNz1phQzCOP1GHzxOn60UBRUaFtX1RH+OIPGPTec8PloT/glERBsAGqGVLwFwFmJXloW7U+DAeRXDDZTsX9bAkgPCtVdywAkz/6qSG/0T7JetBPp0C5/h0CUPmVXVddS/4VGrY8kusr26YImcYDTgJInnji9kl5wOKrfJwMeIgTInsfrChJi79dHzt1eRGU4j6ycBK6RglrS4ijfbIpdHYRXGrssWSvxcdToOdsk+36IbthFFqKNMg5bQ0OCiHXlGQ2QrYm4zI8vwH59gANp5LrQlAbq9xVv8xXZyS7eWxrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUXBGanDaxexnhsii8Sp9KhljrAmqVGsOXx45NKzA6A=;
 b=heA8VGMdJw8o+cVQzTpNo9LSWn786u2jQ4iIxpDiB6n6dT1rVq+vjGov92NNkhCL2XnpbpcDQRrOOwWD0fCtCady0QdZB7DouZJIr2K7RFx9uEll13Ve4QtTdGGYYjlBaFGJ23mNXwgARMfqaW3WCJLj6FFjRty/uG72HfBfCxfQQ9u+AUVNz9BFZK8l2ikw94S9JAHhUNhs1j1iP9vlr3ZBVjl+WKTNm/LoevCHEvaAWlId7GZQ1kukR+HhE1HVygQwxsnt22XgKMh1+tXR21Q5yVyunpkQZn3YM0ZhPz28fVBvNV7JZ8ZwHZ0zHprZeHPhU9pgDx97LS7hoARV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUXBGanDaxexnhsii8Sp9KhljrAmqVGsOXx45NKzA6A=;
 b=VUKkitji2+nfQeUTH27awkltEtRqGJ86Q0LvnHjPOTRGJjlYWNrDGEwsSepemh3r4Em1rU4A8ta9Nx7Y10Fg1BupOxd99vAiQSjpqbJX+jP5aPn0N52ukbIXeJ5E9xVElhRWREcuBaDf5qhaoIU4ujkwc2PB2clyovpO1imsMNE=
Received: from SEYPR03MB6531.apcprd03.prod.outlook.com (2603:1096:101:8a::9)
 by SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.16; Mon, 31 Oct
 2022 05:57:48 +0000
Received: from SEYPR03MB6531.apcprd03.prod.outlook.com
 ([fe80::d882:f0e9:8578:7b2]) by SEYPR03MB6531.apcprd03.prod.outlook.com
 ([fe80::d882:f0e9:8578:7b2%6]) with mapi id 15.20.5791.010; Mon, 31 Oct 2022
 05:57:48 +0000
From:   =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?UnVueWFuZyBDaGVuICjpmYjmtqbmtIsp?= 
        <Runyang.Chen@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v6 2/3] clk: mediatek: Add auxiliary bus support for
 sysclk reset
Thread-Topic: [PATCH v6 2/3] clk: mediatek: Add auxiliary bus support for
 sysclk reset
Thread-Index: AQHY5Tqriq7eWQLyfEmxQJoHvtmkBq4i8imAgAUeyIA=
Date:   Mon, 31 Oct 2022 05:57:48 +0000
Message-ID: <d590b0914f9931363dc8d04b461233f228f210bd.camel@mediatek.com>
References: <20221021104804.21391-1-rex-bc.chen@mediatek.com>
         <20221021104804.21391-3-rex-bc.chen@mediatek.com>
         <20221027234622.14589C433D6@smtp.kernel.org>
In-Reply-To: <20221027234622.14589C433D6@smtp.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6531:EE_|SEZPR03MB6466:EE_
x-ms-office365-filtering-correlation-id: 20271bf3-4555-4b9d-3664-08dabb04d6ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FTHSihrFDkYQTEYpL2V1N8jET6yo+6X+1PCEjtDwXRjU7+dohYlnBt9I80EB8OI5xDJIB1edzIFrys11b7DdGuTVoET8cGhiEtne9CinXUc0S9p2h8l+MU88fmLRu960A3gq1F1WUCD5O+/2p9z6IPbaAU/klxveOhsINEgbTfDFQq6ZSzJmGWrogtyVWKwb54mEa2EPlH4+Xsy38/WSyOlU/lD+3VdVVFX5jg9Qj5Xj0thFho/tCXavfyJUjd6Oq18W3wONdFgg00VZiuDTcn3KPj+7I7W4/yhge2urZqkofSL+0sSsUV19bawzkGByN5GH/NjKyE6rczgK3G0HIntuycQmKSKTHsCHjLJieHqyCJrtf1PXE+oAIZhpLKtXResOeTdA0Yt4ju6nY+bZ2oqp1JtQjTSUs5hQ2Z0HeHi/3kvDT1SzKhAoCUC2y/IMMBGureMQ6UD07uAQqOVuc3SQZ8eQldhJkhHGr+aSA0Qj3wZACYT9StY3C4YCYg6lOp/lSdcLJ3JiU2fMksi0nGnsBkLEH4C9tN9R/VVuoX5ZCIJba4HHQk4TgkPnSHvMaI260Wh6F3ux7BtX1RVchSvxIlYm0TVvaI9qNgNlw6r12zQBtZ7AaTIFrZ3yQMd+4Rg+ImNAfQfdJpcI0YPH/0im7dXpqqswqCUR76LhLwPPJq3c4Vsppx9vSepJO/mz0gXKsrbbNkHAR4sPZH7XaU1JI7jo1XmukJ9GvrVS5Di/Rg2GTUkFAHPN7wuM4B4SMHBz7lzy6sb6otIMStHzaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6531.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(86362001)(6486002)(2906002)(71200400001)(4001150100001)(38100700002)(122000001)(36756003)(85182001)(38070700005)(6512007)(26005)(6506007)(2616005)(186003)(91956017)(316002)(64756008)(66446008)(66476007)(66946007)(4326008)(478600001)(8676002)(76116006)(41300700001)(7416002)(8936002)(66556008)(54906003)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG84NTNWcXRvK1hVbE0xWHZUSWJieEpWVm9YZ25XWTNoSWgvV0Vob0cvUTN5?=
 =?utf-8?B?L1hNTFZWNHZCWEZLcE1WYzgrdmpuNUJheG5qTnRuRmlXTTIrWmJra2NDQmdu?=
 =?utf-8?B?d1hza2xzWGJRK2VtSEFPNjJ0b1FRQThpQ2Frb1E5alZyRDNNOENmV1VrY1F6?=
 =?utf-8?B?cTl0UDN0M2ZpYUlXaFFNTktrempJY01RRTN5R0ZzRDFhT1FDbHRjUWpXVGlP?=
 =?utf-8?B?eGRTRGxuMm01NGI2NmJtRld6MEJjSHd2VGdxb0p3SkREdVdrR0w4V2M0a25T?=
 =?utf-8?B?d3RFa3NUSmVMcG4zL0d4MjhlZnNOeVg2NVJSZkw5YlBOQkR0eGw1Njh3Wk5K?=
 =?utf-8?B?Nlo3aEpONmhXRk5DL1VydVloc2FiaThwZ2gwVDFyVlZpczgzZnNyOXRzS1BW?=
 =?utf-8?B?QWhGbzhuNEVMNVRZV1pFSHZCZm5ocEw3SkdGQXVqNmJib0prU2ZuWlJkSmNE?=
 =?utf-8?B?YlBhbDhLNW9vbDJ6UG44VVA2YVFPRXF3OXVSN0lZNktXbzlxajVTR2E4V2N5?=
 =?utf-8?B?clk1TVhjd0F4OXBJNS9LTExFcWZpNDMyUHpZaHVGdkNXay9vRnJ2cTNXdmt6?=
 =?utf-8?B?RXBQdC9aRitucmwrQUJ2ZWM0TWlFcG4zZWtlTWRvYk0vL1lJemVRSnhnRnBO?=
 =?utf-8?B?OWttSy9XdXdVYnZUZ0lVdGd5cmpsNFVPSkV3emlHR0tRb3hpWjJkdVZpZXNz?=
 =?utf-8?B?NTI5ejJKeXBYN3hYVmFqZkRLVXUvTENKZXkzM0NMK29Ta2dJa2pySm5yNisz?=
 =?utf-8?B?LzNzd0pJbis2aWtWalZrTS94RzJHZEJNZ3NadCtjajVUQUU5eGtKRzVZQkor?=
 =?utf-8?B?MjlmOHZ2ekNsVitDOVdhZ0FRV2QvL0J6dEFiVmJ2ZjhNTStlM3h1bWx3YjF1?=
 =?utf-8?B?RHRaakdOMmt1NzB4WXNaWFdlbThpVENpK3V2SnI1M0hqYnBzejQyaGhBck1C?=
 =?utf-8?B?bXd4NVRYeThLK2JqeHFMalQvVldxWlNoVXJIamdMOFIzOWp0OGhLWm1OZGVy?=
 =?utf-8?B?WVhDL2J5N2xDOEhKVWpoZktJQnRpWGdpRXpWSDFlYnNPOTltRWN6SUp2Wmgv?=
 =?utf-8?B?blVKKzg5SFQ4TGxJc0RxeTJaRytVRGFFckdXQmhVMHk2WGdCUnA4cmNWWEUz?=
 =?utf-8?B?bUdGclhyWHEwZnlQclZCaWtOdnd1OVdtb2Y1cklGOEwrTTBBV0lJUG9LU1JH?=
 =?utf-8?B?NHN6TkxNN09ZdEhQTTFwVGk4VEs3NjdBdTVodGhQRW0ydUgyWlVpNXRCaGZw?=
 =?utf-8?B?emlJRS9WVkcvNVlkeXlBaUpNdk5nUmFRZE03Q3dGaGNNcURmSC9SM1lHU2oy?=
 =?utf-8?B?UXIwRVI0ZG9PNlNhYlNWTUtYTG8xZGRSc0tlNGkrVGhaRm0rMW5TbGVCUDZN?=
 =?utf-8?B?dWxGb0dpZGZNRVM3amdZYkw0Rm9RVXpNNDR6QUxTbk9MNnQvSHlpcXVZTFRN?=
 =?utf-8?B?TWR0NkZkY1U1QkJtQXZ6WXFnZXJUOVdOY2ZKU2craENvMjBteEJHZXdvd1dP?=
 =?utf-8?B?LzBqaG01bVExL2NZK05KUFpkaWRaN2czUjlMWTA1c3RBbnUyV0tvazlHMzBs?=
 =?utf-8?B?c0hicWJQdHNLejZTWENXdk5TbDEyVjBhOGZuYkFIQ0lMK0pLcSt6OXE2L0Mx?=
 =?utf-8?B?QXVxNlQyYzJtWlBiczJJVEkwUXEyTjVlNDY2QWZ5MDIybVhPTjlFVnVhS1hO?=
 =?utf-8?B?a2RZcWowZTl4ZXAzZXNDa0tmT3BuZUdqYnRGdGRGSVFvdEpncGlxU0k3T2Ry?=
 =?utf-8?B?VjNiQmg1Sit6TElqZFpNNzlpR0VFNkFweEdsQnNxejhVNDlpNXdDYkFURERp?=
 =?utf-8?B?WEdXM0xjMlcvdWM5czExVGJZQWtkZUhGSndzY25TSzZMRityS1NLV0RJL284?=
 =?utf-8?B?d1FBQ3JqcEFIUHd5L3BhdWJYeVpXbVhsc25pZ05ncUlIUmtUSCtyM3hSRy9V?=
 =?utf-8?B?OWtmNkZkU0QvRnZJbXBWZG11Ymo1bVkvTitnWXZGVW1xV0dBQURZWVUzR3Iv?=
 =?utf-8?B?QlVrVHBJaUMrZXlYTDVYNmhEU3BtMEhiUlJZNGNnYk5XTjdBS0pQYW1mNGhr?=
 =?utf-8?B?MlFpb2Q1SkhOQXNoNytXTEo0T0JzcmJaQkYyRElSOHZBVWdPdXp4alZWc09w?=
 =?utf-8?B?RHFPWUVjeUswTjNabUI5aFE4UEhMdkp2RUFlRVE3TWRraTJJcnR6QzEwZWdS?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8EAA9BD14E1524D8F80AA7BB25B2220@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6531.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20271bf3-4555-4b9d-3664-08dabb04d6ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 05:57:48.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnGxThVZhxucpAvlUnsw9tp4axgekUDLRSZ8Ue15W9D/MZuywqkLI33/TkJIogGzOBMQt19NgHwe+9WfIEb/NhZlPXSMc1qvHebzwlOUiqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6466
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTI3IGF0IDE2OjQ2IC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgQm8tQ2hlbiBDaGVuICgyMDIyLTEwLTIxIDAzOjQ4OjAzKQ0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmMNCj4gPiBiL2RyaXZlcnMvY2xrL21l
ZGlhdGVrL2Nsay1tdGsuYw0KPiA+IGluZGV4IDc0NDA4ODQ5ZWQ4Ni4uNjFiN2VlMjM3MzhhIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuYw0KPiA+IEBAIC00NDQsNiArNDQ0LDYzIEBA
IHZvaWQgbXRrX2Nsa191bnJlZ2lzdGVyX2RpdmlkZXJzKGNvbnN0IHN0cnVjdA0KPiA+IG10a19j
bGtfZGl2aWRlciAqbWNkcywgaW50IG51bSwNCj4gDQo+IFsuLl0NCj4gPiAraW50IG10a19yZXNl
dF9jb250cm9sbGVyX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hhcg0KPiA+
ICpuYW1lKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRl
djsNCj4gPiArICAgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgYWRldiA9IG10a19y
ZXNldF9hZGV2X2FsbG9jKGRldiwgbmFtZSk7DQo+ID4gKyAgICAgICBpZiAoSVNfRVJSKGFkZXYp
KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihhZGV2KTsNCj4gPiArDQo+ID4g
KyAgICAgICByZXQgPSBhdXhpbGlhcnlfZGV2aWNlX2FkZChhZGV2KTsNCj4gPiArICAgICAgIGlm
IChyZXQpIHsNCj4gPiArICAgICAgICAgICAgICAgYXV4aWxpYXJ5X2RldmljZV91bmluaXQoYWRl
dik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgICAgcmV0dXJuIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkZXYsDQo+ID4g
bXRrX3Jlc2V0X3VucmVnaXN0ZXJfYWRldiwgYWRldik7DQo+IA0KPiBDYW4gd2UgaGF2ZSBkZXZt
X2F1eGlsaWFyeV9kZXZpY2VfYWRkKCkgdGhhdCBzZXRzIHRoZSBwYXJlbnQgYW5kDQo+IHJlZ2lz
dGVycyB0aGUgZGV2aWNlPw0KDQpIZWxsbyBTdGVwaGVuLA0KDQpJIGNhbid0IGZpbmQgdGhlIGRl
ZmluaXRpb24gb2YgZGV2bV9hdXhpbGlhcnlfZGV2aWNlX2FkZCgpLiBJcyB0aGVyZQ0KYW55IGlu
Zm9ybWF0aW9uIGZvciB0aGlzIGZ1bmN0aW9uPw0KDQpCUnMsDQpCby1DaGVuDQo=
