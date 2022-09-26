Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861845E9C11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiIZIaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiIZIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:30:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B108113EB3;
        Mon, 26 Sep 2022 01:29:59 -0700 (PDT)
X-UUID: 3c0a03a98ba34688906519b66a0129b5-20220926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HVddzVbZcupz0zV30Dx9GYuyCUXHqD95H0lNlrRe7UA=;
        b=uWcW4dpwGDvx2nCtMAGeKalq3cNQR+68h46tR2kxgED6v8qrLpufjeur61k5CH+rgmgZuSnzxoxHEHjbXRkfx6EXhAzfXL1KEK4UVumg1ueauETTbcAlkcEp6EmnbAh+19M//4xqIKFtGQ6OyE9KrVw7LSIYWwKqqDnVdzMp8qs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:7b589590-69eb-4039-8e27-d5ee8a1243c2,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:64383ae4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3c0a03a98ba34688906519b66a0129b5-20220926
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 441588450; Mon, 26 Sep 2022 16:29:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 26 Sep 2022 16:29:53 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 26 Sep 2022 16:29:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkQlw3UW6Bs9PAsZou4zg0RE+gwVh2rU+E5NDj7NL5Nwxwzb0Cwq6TbIv9v/r91jID2U+e7s/aoWdVmxL9Cb4in7OPiywoipKGHfBXd6zmLcIJaVSI0bobJmjr/5c8zDZnRCuhfZeU2d+F60EIt3nP+ECA24Om1G9X8irHyj/2olz8SR2Rwqw+TrEyV188v92Hnjn7flfzEPAsgES3HlOYIvAl0vKXpw7GthA0BJvppztdzdCkaWwQN1IWd8oDZk2Dsave8g5LDZa7tQlaK3yWcRuU7bCd0k0fSVgt6mq5iHO7/+uJ6pmdJBPVoFqv5xDa+tMQPwKaUjuTpUFs5yVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVddzVbZcupz0zV30Dx9GYuyCUXHqD95H0lNlrRe7UA=;
 b=dKUJkx4zZU8Up8mVq8WNPEywWoxrz3kbyXvWFNaqgXOj1lmaIN+c37uK6aLLS78zm2wqzKCVq/Ma5F08VXl8BfJuKY+ssypn7Fo9hTWUBCKuY0GgHXZ8ZN5xnCuEJ8QDuiKyMp2r/rFQuDMVplba31zFkUFHc1VCS9S80hM9SOPiFgLmzQxNRTeukt3WR3gDmmSDB/G9ymRFGwLsH5e6ETM2QxFYnwA92+4s1n1HjN+S+408jzwm+7d9SUqbBGMHGDptn+4rGtgsJoaDI9/Tq5t26Nevw9A4ZGszZxZ8MgOUoOaWniL9CjWVHxMS3VwfZviO4x7F8QGP4oSeeXmGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVddzVbZcupz0zV30Dx9GYuyCUXHqD95H0lNlrRe7UA=;
 b=dAtIUyLrF3eug1hN7a1pxs+IhaWHDGxeCgPb4WG5GUJmijGntqV19BXBhRUJWQ/RwJEWgCzL6Swojg6tvlmXP6eHVWRFl1MepbXsupTLG5RzJTy+mvE/AZ6QFrBxOZTcOHiQoBcI29notU+JePnsZiWkE1mb1JfKHiqcRXznESo=
Received: from KL1PR03MB7128.apcprd03.prod.outlook.com (2603:1096:820:db::10)
 by SL2PR03MB4476.apcprd03.prod.outlook.com (2603:1096:100:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.14; Mon, 26 Sep
 2022 08:29:50 +0000
Received: from KL1PR03MB7128.apcprd03.prod.outlook.com
 ([fe80::3d7:f878:45dc:a6c0]) by KL1PR03MB7128.apcprd03.prod.outlook.com
 ([fe80::3d7:f878:45dc:a6c0%5]) with mapi id 15.20.5676.013; Mon, 26 Sep 2022
 08:29:50 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8192: Add vcodec lat and core nodes
Thread-Topic: [PATCH] arm64: dts: mt8192: Add vcodec lat and core nodes
Thread-Index: AQHYz0I2VaMFAKj7TU208wLPwr+olK3xSSKAgAAcn4A=
Date:   Mon, 26 Sep 2022 08:29:49 +0000
Message-ID: <621542e1d23a477aec9e7796da2673717db56027.camel@mediatek.com>
References: <20220923114658.8286-1-allen-kh.cheng@mediatek.com>
         <CAGXv+5Hx31PWVU-uz0araW+jYX-s+_HXph-ZAPa6eMPn0LQ+Bg@mail.gmail.com>
In-Reply-To: <CAGXv+5Hx31PWVU-uz0araW+jYX-s+_HXph-ZAPa6eMPn0LQ+Bg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7128:EE_|SL2PR03MB4476:EE_
x-ms-office365-filtering-correlation-id: fc93e044-e403-479e-4c00-08da9f9946f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Roto7dD/16q1CGfsi8HzfshLv3OPhoGQ+xFpjezYLCQ33dBiUnCT4ZTG8VU1aLNoH0MV+8VMKtuFQrm79JCuyHSXXf3xpJWtEFt2FnlXXxekPqICJkQunZq2vQ7ZJb/M6l8LH5i7H8NaL4GbWgyJv4eICB2UG3Gz0qDPMLe0d/3Gv2rg03mpTswds77BP38WzQp5sQnC5yUQmgfbaZyScus+0z++CcrS0Sa3BvILXAEdWrzVlpDfk81RI2NUlrFmXaCrdu9fleP13TLJO8icyQdrtSlCiJPhkHZ1zvNIWzz5lddranMiDBy6PQHoWCp5mocgBJOLn5mCQWb8ZcoFK6XI4uxpBCj3i6ltv8uulwCwb1RVCf078mizMSZScM4H5NQ0Osx0i9OuyoeaOQMNLoijr3lmuZyjedRYuk5/1p0FjtHLL8CsGbbTWZINKhO13kTKaKKUxT7Log4oZnOeyObwx944T5qvbSEDCvm0P19/TNgMkYtI9OppJv1MAjNfNhphkgjqAq1pg6GZj/JPRvVtvK9IcEq/Dl3GhcWO4sALhO6ffIgGXEFHf3FqHs1koNQTzp347jgcZTR6XmTNAU7HUIAC9kNc7EU94LM7XkZizap42UEc1gjRO2Ir+jZWGG5kSgjH6pYsXWF7b/SAAaaBTmAVa60Vadd6iojKf0NygLwoY8s2fk4xxNEY2+xY1pUyWv7C5PjVrVlg0KdA949EyK4YXblRvu/2jGOvBw2+eepK4zrmM0CjNppGH2jZ8wxLMRgF1Pq48V6678+pRqCU1spGUmEPIpgfx6oaGZA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7128.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(66946007)(66446008)(66556008)(66476007)(8936002)(5660300002)(36756003)(84970400001)(85182001)(122000001)(2906002)(38100700002)(86362001)(38070700005)(186003)(6506007)(53546011)(478600001)(26005)(2616005)(71200400001)(6486002)(41300700001)(64756008)(83380400001)(6512007)(8676002)(91956017)(4326008)(76116006)(54906003)(316002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU13U2hIa1E1bnB0eTZnb0NyeDFMUkVTdHA3ZS9ka1lvLzZ3ZkdGMWV3S0Ey?=
 =?utf-8?B?V3RqMWVRZzJJU0I0L1EvaGU5NnJ4bUlwcWk3L2J5SDZWd2ZnWURDeWZMQTJm?=
 =?utf-8?B?UCsxcUtoNVRsbll2Snd4ZXVRVGxHcmNiMlNKdmEwRUFlTTBoM0dobDIwMkth?=
 =?utf-8?B?czdkdXZyaUw4STFVVm42alVuRFc5NWt3dFJJTzlLcjJUNDU3VFRhVk0xbndW?=
 =?utf-8?B?NGtYSzNlT1Z2QU9NS2dLMEd4VTlQWUpUd3ZuaFQ5SEhMMVQzZGdIZXBVd2xP?=
 =?utf-8?B?enkzYkRHcG9NMkFvNXp3Tyt1VllpdGEvVUVHRzFhVUFBSHhFNWIyR1VzaGtt?=
 =?utf-8?B?ZjE3ckNRN2xNeUZKL2h5c3pzNVpVMUJFYlVPNWNxWEx5N1ZsR3VVbDd1bXhL?=
 =?utf-8?B?QUpMbXY5dDhONzhlNEJ4MGU2TGE2eENOc0ozM25TQWh0bFpicWtLZkg0bjdm?=
 =?utf-8?B?cVQ3T0hxRWt5ZG96SEJwa3BnZUxMVHp4TGRLUUQybHJIRjAveFNETmQxemUw?=
 =?utf-8?B?WG5vNnlUcm51SkFwcXZwM1JLaThvU3Y3bTVsUGxNOTg3WVRRVEYzVUlJQ0pB?=
 =?utf-8?B?K2RnZDRxNWdIU3dEMDYxM2FOa0QxZWE4ajFZcFZIOTBpYVFzWCtrcndBWGlM?=
 =?utf-8?B?cXo4VkkvVk9EK1owRTdkTkkwbjh4WFpzVmppOEdtajJRb1B0TmRjdllpS3Qr?=
 =?utf-8?B?OGVTbW03Ti9VSUxZVmhOWWs1N2tHUmY2Z2YxdGlBeEVkNndmbnpnZHRPMXJt?=
 =?utf-8?B?dzdRNTdQU29CUmVtdWZwclVQWktuUDF3QTRET0lNSnNRUUxVMDVBQlhSOEdp?=
 =?utf-8?B?Uk92R0dSbDZtZHZkRGROTGRxVGU0K0hheE9HK29ab1EzY1phTUIzYkFZMjh0?=
 =?utf-8?B?b1JsRHFLN1YxLzRuSmFjOGZSYVZ2SkZBSlBTTDBEQVNPYmN4Rk1pVlFPb0dD?=
 =?utf-8?B?bkliQ2VRRklUTTdDR0hoRDBFOFREbkExczVGUy9nbGc3MVdaV1pzdTBVdnlP?=
 =?utf-8?B?b3lhVjNlLzBIaUpxV05TWVdsVytKdVJRNGI2Z3pzRkdZTlJlZE5Rd3E5L3oz?=
 =?utf-8?B?QkY3bHBYN0h1TGRDY0lITDlyOUthdDgxaUx4RDl2SURPeXpQMVpTdjQrU3dl?=
 =?utf-8?B?Nk9xeFMxS0VQeVJkcHF2ck9Ec291WFFHR0hRVHcvM0dsWjFTM21PUlZxTm5q?=
 =?utf-8?B?RTZmVE9ISEgwZEJTKzIyeWdoYUtrSG45WTFBTjZ4eFQyNlorRFcza1lLTm9m?=
 =?utf-8?B?L2V4RVBHQjFNNWFaTDQ1U1h0eHZ5VVhCUWxxeVQwOVdGVG1OdkwwdU5GT2tD?=
 =?utf-8?B?K1ZTVk40RmpuSUpodHZuUFhqM2MwaGoxRkxJTjhqeEdwd2dkNGZyWjJKOTNK?=
 =?utf-8?B?TEhLVThJSXFCYnJuTThBcjE5c2dCblZpeUtPNG05TXBmSmFOQ01tQXdLSXFM?=
 =?utf-8?B?SlZxUThDZFlBRlVZTUF0TXh0OHZmN0thdnlMZnA0TmttU1Rxc2pHMUxZMkhX?=
 =?utf-8?B?MndqWWRIbVJhbDBIRDhiSmgwU1FIbmppTXFSSm5zMFhLOEpNVjZJV0pVNmV6?=
 =?utf-8?B?U1d1cE1YMG01c0RseldtdDdDS241YTkzL1dCU09UWldRdCtJdytKTnNVbFE4?=
 =?utf-8?B?THp2NmJ5LzdtYTUxNjV5WlplNURxQlZCd3BIWXQvdVZvOFhNYkNNMFBmUDRI?=
 =?utf-8?B?bk9lVjU3YXVmVVB4bkJBNmZoTkI1Z1NGNzNkME5SL24wYk8zWDY0QWt0Y0ZI?=
 =?utf-8?B?UFFVeWFaUlBzRUltNWI5LzlkamxPWnF3ZEluQ20vYjJJZERwZ3pyb3NibVNQ?=
 =?utf-8?B?RldoMVJvZ0l6a0cxc2JqRWFwdTE2eVdnK0tVRzFNZlJZRWxzZzNpU3Exams4?=
 =?utf-8?B?Vk1KcHNVVmpEMUZnaWY4ck1qZVE2YnpvUG5hb0RqNkp6Y3U0bmtXYkQ5MjVZ?=
 =?utf-8?B?WWZ3VTV3TDcwMHR3eFkrT0NId3QyN3RaUVdOaXdCaCtZaG1YY1ZXVHYzUlln?=
 =?utf-8?B?UCtHUUlmSFNBU1JURnd3QXhScnZPdUt1bytIK21zay9yQU9abXU1TjIxNWw3?=
 =?utf-8?B?OUFzK1pUeVZvM29md2ZIRFJ4aTJOMUhxSW9TYUd4Q1NIdWdhZFg3NmJKYW1L?=
 =?utf-8?B?YytuYllhQ3VoTmFyN21tYkpSelhJK2NWNEJwTFVETVJKdGZsR2RWRUdKNzF6?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <333D84E5150EE94C8531DB2302ACCDA0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7128.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc93e044-e403-479e-4c00-08da9f9946f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 08:29:49.5105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U7OeGoY4ga3cNijabMcBqpGj4u7MiUxlgA1iXpzr4HImRRqjypRpLaVmJ0/c2QmeFfoihh2Ian2h3ZcBT4Beq1d8d3kYQtFA6/v4InYG7J0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR03MB4476
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hlbi1ZdSwNCg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbiBhbmQgdGVzdC4NCg0KVGhl
IGZvbGxvd2luZyB2ZXJzaW9uIHdpbGwgZml4IHRoZSBub2RlJ3MgbmFtZS4NCg0KQlJzLA0KQWxs
ZW4NCg0KT24gTW9uLCAyMDIyLTA5LTI2IGF0IDE0OjQ3ICswODAwLCBDaGVuLVl1IFRzYWkgd3Jv
dGU6DQo+IE9uIEZyaSwgU2VwIDIzLCAyMDIyIGF0IDc6NDcgUE0gQWxsZW4tS0ggQ2hlbmcNCj4g
PGFsbGVuLWtoLmNoZW5nQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gQWRkIHZjb2Rl
YyBsYXQgYW5kIGNvcmUgbm9kZXMgZm9yIG10ODE5MiBTb0MuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogQWxsZW4tS0ggQ2hlbmcgPGFsbGVuLWtoLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+
IFRlc3RlZC1ieTogQ2hlbi1ZdSBUc2FpIDx3ZW5zdEBjaHJvbWl1bS5vcmc+DQo+IA0KPiA+IC0t
LQ0KPiA+IFRoaXMgcGF0Y2ggaXMgYmFzZWQgb24gbWF0dGhpYXMuYmdnL2xpbnV4LmdpdCwgdjYu
MC1uZXh0L2R0czY0DQo+ID4gW0FsbGVuLUtIIENoZW5nIDxhbGxlbi1raC5jaGVuZ0BtZWRpYXRl
ay5jb20+XQ0KPiA+IC0tLQ0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210ODE5Mi5kdHNpIHwgNjANCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaQ0KPiA+IGIvYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaQ0KPiA+IGluZGV4IDZiMjAzNzYxOTFhNy4u
YWE2NTI0OTQ4ZTdjIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4MTkyLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE5Mi5kdHNpDQo+ID4gQEAgLTE0NDksNiArMTQ0OSw2NiBAQA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHBvd2VyLWRvbWFpbnMgPSA8JnNwbQ0KPiA+IE1UODE5Ml9QT1dFUl9ET01BSU5f
SVNQMj47DQo+ID4gICAgICAgICAgICAgICAgIH07DQo+ID4gDQo+ID4gKyAgICAgICAgICAgICAg
IHZjb2RlY19kZWM6IHZjb2RlYy1kZWNAMTYwMDAwMDAgew0KPiANCj4gVGhlIGRldmljZSBub2Rl
IG5hbWUgc2hvdWxkIGJlIGdlbmVyaWMsIHNvIG1heWJlICJ2aWRlby1jb2RlY0AiPw0KPiANCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi12
Y29kZWMtZGVjIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MCAweDE2MDAw
MDAwIDAgMHgxMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBtZWRpYXRlayxzY3Ag
PSA8JnNjcD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaW9tbXVzID0gPCZpb21tdTAg
TTRVX1BPUlRfTDRfVkRFQ19NQ19FWFQ+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRt
YS1yYW5nZXMgPSA8MHgxIDB4MCAweDAgMHg0MDAwMDAwMCAweDANCj4gPiAweGZmZjAwMDAwPjsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICByYW5nZXMgPSA8MCAwIDAgMHgxNjAwMDAwMCAwIDB4MjYwMDA+Ow0KPiA+
ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB2Y29kZWNfbGF0OiB2Y29kZWMtbGF0QDEw
MDAwIHsNCj4gDQo+IFNhbWUgaGVyZS4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ay12Y29kZWMtDQo+ID4gbGF0IjsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHgxMDAwMCAwIDB4
ODAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8
R0lDX1NQSSA0MjYNCj4gPiBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW9tbXVzID0gPCZpb21tdTANCj4gPiBNNFVfUE9SVF9MNV9W
REVDX0xBVDBfVkxEX0VYVD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA8JmlvbW11MA0KPiA+IE00VV9QT1JUX0w1X1ZERUNfTEFUMF9WTEQyX0VYVD4sDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmlvbW11MA0KPiA+
IE00VV9QT1JUX0w1X1ZERUNfTEFUMF9BVkNfTVZfRVhUPiwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDwmaW9tbXUwDQo+ID4gTTRVX1BPUlRfTDVfVkRFQ19M
QVQwX1BSRURfUkRfRVhUPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDwmaW9tbXUwDQo+ID4gTTRVX1BPUlRfTDVfVkRFQ19MQVQwX1RJTEVfRVhUPiwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmaW9tbXUwDQo+ID4g
TTRVX1BPUlRfTDVfVkRFQ19MQVQwX1dETUFfRVhUPiwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDwmaW9tbXUwDQo+ID4gTTRVX1BPUlRfTDVfVkRFQ19MQVQw
X1JHX0NUUkxfRE1BX0VYVD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA8JmlvbW11MA0KPiA+IE00VV9QT1JUX0w1X1ZERUNfVUZPX0VOQ19FWFQ+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZ0b3Bja2dlbg0KPiA+
IENMS19UT1BfVkRFQ19TRUw+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgPCZ2ZGVjc3lzX3NvYw0KPiA+IENMS19WREVDX1NPQ19WREVDPiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmdmRlY3N5c19zb2MNCj4gPiBD
TEtfVkRFQ19TT0NfTEFUPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDwmdmRlY3N5c19zb2MNCj4gPiBDTEtfVkRFQ19TT0NfTEFSQjE+LA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbg0KPiA+IENMS19U
T1BfTUFJTlBMTF9END47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9j
ay1uYW1lcyA9ICJzZWwiLCAic29jLXZkZWMiLA0KPiA+ICJzb2MtbGF0IiwgInZkZWMiLCAidG9w
IjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFzc2lnbmVkLWNsb2NrcyA9
IDwmdG9wY2tnZW4NCj4gPiBDTEtfVE9QX1ZERUNfU0VMPjsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnRvcGNrZ2VuDQo+ID4g
Q0xLX1RPUF9NQUlOUExMX0Q0PjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHBvd2VyLWRvbWFpbnMgPSA8JnNwbQ0KPiA+IE1UODE5Ml9QT1dFUl9ET01BSU5fVkRFQz47DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgdmNvZGVjX2NvcmU6IHZjb2RlYy1jb3JlQDI1MDAwIHsNCj4gDQo+IFNhbWUgaGVy
ZS4NCj4gDQo+IENoZW5ZdQ0K
