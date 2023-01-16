Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF6666BAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjAPJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjAPJkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:40:49 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E761E9C4;
        Mon, 16 Jan 2023 01:39:39 -0800 (PST)
X-UUID: ae948b8a958111eda06fc9ecc4dadd91-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nLSW4qQJZoDYetEn2KhwSYhHbRnF26RxR/Cm+sZ+zOc=;
        b=LFyyL77Sfs1kwvCzUtYEo8jKRYxm5XeRaCokX72nxlMDB3H0tPzpKNTNAhUXglRR51sVAT1kWl9iPv0UJ0pPRikvrEpQTBUqOs57J6amjac4cXB7XkFV7pbQYh7zs4FK3Eurkz9iA75TlBi25cD8I5qdv4i8ryYvDpzBwPLqvoY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:822307a4-9b99-4569-b7e6-7ee0006bd858,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:543e81c,CLOUDID:389df0f5-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: ae948b8a958111eda06fc9ecc4dadd91-20230116
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 891915012; Mon, 16 Jan 2023 17:39:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 16 Jan 2023 17:39:31 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 16 Jan 2023 17:39:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYgGXp6ojMTeraE7M5/WVECJSxpALNCk0G1DFw7U8SCUZ6G6Qcz2yp+fYioTFioSUr6psI4DQ5EKA4+Ni5swJdeJvWtJaH4a2NfpW7TGhR6tNtF0315bfG153KJdW95a8XOX4GIvJj6H09tCYCT+n8mrsSSHKZa2AbXOF9mT249eS8T8BYiDmzyxjnU1WCLhT1nZbJiHCJO826MkndI4L104Xu0xk2CHiJ7uwMn73lYjndDVJWUFua136IwnI6W00cBX70DzV8tsEsTnkpKSxgYcaIiOOh/reNLZ5JeW58zAbd+F69IMhZdUkZErXdZi0BZHfbsvhuJE9SLnBTfeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLSW4qQJZoDYetEn2KhwSYhHbRnF26RxR/Cm+sZ+zOc=;
 b=mmGUMYuMnHk+R57ftaxmj4jfn8A4tGB5DHLagt7eWmCWEv07D1CsgYzaPq92UrSQUxN+X47Kz4fhF2jNu3LhS8hKMgj/sTXCVNAvbcWOMDczUzlH4FUb1ht8akXYmVnsEe4O7O5Dh0BHSdXTwy5Bwuj/eszSBNHma3an6Y3nlaKGRxAcZx/4FAYZROnDPaHuZ39n84Jvm/K1SbhISLQekF+OK2bQb4f5UvtbktmsFMrVOxEyyuDnJj8yrgIxp/Jpk3LSm2Y+zMXmEJvDTFhyOcBYj+t4RqfBqE/hSDhkjXgyTpGawcG81mVQs9lgAiI9NZHYDo7iAQmxBdAUI+LaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLSW4qQJZoDYetEn2KhwSYhHbRnF26RxR/Cm+sZ+zOc=;
 b=nSKNz8lLdobGy7IvSSn353xd8bF2yBdXaE3o+B1ILlSAvECpm7s09o6AfDytB4j3JQbUqFdVYzicEFiyrs7uOplZZ6tRMSl1vXgqiTRKYd53teUFOZtw81kit+mKhF6sPFQ72w1nsL1izcHxdAY+nrWW+GzTjo1hVm/StE6ESJk=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by SG2PR03MB6229.apcprd03.prod.outlook.com (2603:1096:4:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 09:39:28 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::eb3c:770d:783d:352d%4]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 09:39:28 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [RESEND v3 01/13] dt-binding: mediatek: add bindings for MediaTek
 mt8195 MDP3 components
Thread-Topic: [RESEND v3 01/13] dt-binding: mediatek: add bindings for
 MediaTek mt8195 MDP3 components
Thread-Index: AQHZKVms05m6LhvokEeyIkOE8xk7Za6gsTCAgAAY9oA=
Date:   Mon, 16 Jan 2023 09:39:28 +0000
Message-ID: <a5ef36df5bf8c483d327247199f5494be13b1efa.camel@mediatek.com>
References: <20230116032147.23607-1-moudy.ho@mediatek.com>
         <20230116032147.23607-2-moudy.ho@mediatek.com>
         <f24a54f1-2720-3345-9596-bb8d388ba16f@linaro.org>
In-Reply-To: <f24a54f1-2720-3345-9596-bb8d388ba16f@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|SG2PR03MB6229:EE_
x-ms-office365-filtering-correlation-id: 3d60d89d-889a-4260-7c1c-08daf7a59033
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oi39swmU9Bmv498hX8WhGDRR3OMp3c1CyThY8dc5enFWQQB/nzkte1+mE1eQeWGPCGwyo7nfbcu3jqkBGxxgIEKQ1VgxeDIm9ioCU5/8pnJ6bLjKk49dQwedYAecVOMiKNc2cwh2CqnTHV16QYXtd8p7F742lbv90kMWBJ9c1n+hWFVp1U+gERADcMouBsvkWm8xI3DByd+A7sHHDTh5XQPl8OvdDLLQ2T/wYXjqxg43aohZwXH4pK0Mp48kjjAxWKnQTixGkPljWaPImwC+ChH0Sgu0Xhyn5rrnhjVkmwwnFwP9MrkaKh9k1eIyQWgi1Ld9VcR887R107+lZj6daJJk2Yqu2ite+/1a+zgcZqNSX9iTDw19rN1JUjP2dsNh3FOInyVWMTwXBdyX4AkpOiXjFdWoomxp4eHaqOXkA0j7czcbpWUHqqplQo51Qccvwv87ypal5T9l0Qqkpa/j9YUJWUZIMTQLyu/3VLD4lGoWVGDpWzkNMBtvANLsi+i+Of3YIsOGGwVOlxzkDdGnpWNOHdqZTID/BBCEru55fTDEjWiT76UXvwq8ykJ6C3BcgqHA2jUFTiWy+5hSBy11/8/c6l3rd3LqLK4Za1+ER4F7n+WWUsbHOU85PUAPZvZ4JBsxdWSA/3aYszLP1tnuPxOwfYNJITjHfBO7vNlUHTDZIuYgc9wPYZ3RtP4kFk1Ohkpr9Ll/IxB0VgU7BcVHj0Cw3e1LauPlXJHizb0YYKZsV7fdGhm9zTPFzhj8XTiEim2rxIVbme9pjb0APotFc6cvjZTd7zxUVtCz22R+Mq8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(36756003)(85182001)(38100700002)(86362001)(38070700005)(8676002)(8936002)(66556008)(64756008)(66476007)(4326008)(66446008)(76116006)(66946007)(2906002)(5660300002)(7416002)(83380400001)(122000001)(478600001)(6486002)(71200400001)(966005)(54906003)(316002)(110136005)(41300700001)(2616005)(53546011)(107886003)(6512007)(26005)(186003)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWFhalozUDlFZVVsVXl2NWJUVGNtVE5xRHVwM1U4Z0ZuclZSVjB3dklpazcx?=
 =?utf-8?B?UVNhaEN5aXpKVmVMcDBBVXRXeEh5bTFyUWJuMTdZeGZGU3VXNkFVTUxEKzZo?=
 =?utf-8?B?dzJIMm1vVy9PZDk1OE1peXhPdjdjVkMyNXJ2SUEzUUp2ZGx2YURHVDNobXdz?=
 =?utf-8?B?dHM0U0hnc2Vtc3RMOUpNMGVsMlhBdEljVitBek1DZUJJSVZ5L1pDdTdYak00?=
 =?utf-8?B?SnlDZDA5cmdOb3dQMllkdUlQaEVlYnI1dEl6V3ljTlBNZ3doSy9XWXpUcUNQ?=
 =?utf-8?B?TmZIR20rdDBqdFVLVG1EeTluZTkyaFRPdGZDK1ZGRG9VUkNpTld4NFZJTWlm?=
 =?utf-8?B?YWpvSGp6cUJ1eDZLWTlnTkw0MVhidVA5d3pMemFQLzJCNU92WitSam1LOWlo?=
 =?utf-8?B?SENIbnZON0xOeDBERW5TZWQrY1ZaVDQxeEpJanRKdlN2S0VEYXdHTlBEMDlh?=
 =?utf-8?B?WWZrbmMrQllnTDQ2UEhNYXBUak02aTlrdTJlR2tqZnBzSlc5ZjNtTTN0MHdn?=
 =?utf-8?B?c0tYeFBaRmQybE5YKzRPbEpKUGdGN1Q0SkdMQ1RCczZxck9KU0U1NFpuSTlN?=
 =?utf-8?B?RXFGLzNYQnNjRTJMa2ZxS0NzOXVyS2swTStDMzJZWWNFejdVVi9GczV0K21Z?=
 =?utf-8?B?VldrMnJINHpoZGdKd2ZBNlRrbUZhUWQwdWY3K2drN3JFOUNKY2dhcldpSHRi?=
 =?utf-8?B?Z0JFeTVjdVM3NXhzd1lHenU5MWFrK2dOUXkrZkk1bkNzUjk3MTBaRlBnSzBH?=
 =?utf-8?B?VDVlc0U0dHoyNXREbjBrRXVLRXpXVlJxbGducWNqREh2eitOZ1dGQW9iZHJJ?=
 =?utf-8?B?L3dRalZ6cXNmcUs4c1laUkErWFZyVTlnTmlLSVhxbWhrZEZvRXFqVm1uUHkw?=
 =?utf-8?B?TXMrcWhzdjRQd0k1WVVNdXdxenFqRVdFQ1REL2tMWW9SalpXYnorRGo0VmVu?=
 =?utf-8?B?Lzh0bGdQeHMxWDFmNTdlQyt0UlhtN0JVV0lPYzQrekJ6NGpjczhDelNYSjVS?=
 =?utf-8?B?VnJ5Zk1MWG5PNVhLTisyZjlNWHhyMTc0N0h5NVdZM1FPTURsOFhhVmloeGFQ?=
 =?utf-8?B?RkZVTDlaV0p0Vysxb2dJaXp2TnUxYkkzdk4rWHpHNkN1M3JMK1BmV2U4V1Zo?=
 =?utf-8?B?MDRWdjBJSFNlNVk0aDhiQ0c0dGs5cVpOdjZKN1ZaS2VjcXYxSWdHVWg1Sldh?=
 =?utf-8?B?NzM5M1pWcFVwS3RHR1JkS1cvZDJ6Zm9OY0VqNk44aENrQXRUeWpaRHVuNmNP?=
 =?utf-8?B?YTRic2YwVFlTU1ZaZW1HTDAvRGQvMU5XMmx1VlV2eHdRMmV6YWozRjBEWnR5?=
 =?utf-8?B?YnRxejNTM3RaOEJ0SmozVTk4RlJ4OUwwYkhRcDNOWXd3dXBleStYQWZqVVhh?=
 =?utf-8?B?eHQrNmxXdllOaWM5VjAyL3FiTTR3TXJHaVhYbkpaZmhoWVlZUFlUbm12d1hX?=
 =?utf-8?B?Y1pyU3J4SzZHc0xTa1lQSWErbGdpbXozQ2taZERZRmdNK2NhU0tUTXd0bDc5?=
 =?utf-8?B?bXlMTnNnTVYxZ1hpSENCYi9yc09pS2Rkc1BSbUtoUnpHVmVybUx3RThsZldK?=
 =?utf-8?B?YjY0RENiK3RsaEgwNzRuUnNHMkVVWnh3cUhuaDFMbjBSUnBhalpKRDl1ZkNi?=
 =?utf-8?B?bmZMSDVPNzRoZDZoQXFQKzd5Z2x6R2RHR0JzWlpkcWM0VWkyU21NWXU2NDJq?=
 =?utf-8?B?Qk5KOFdYdkg4ZUlhQUdXM1lkVW42U1pMb09GTjhqaGZGSnRrQlNMem5rOW5D?=
 =?utf-8?B?M0l3dXRWQXZtMktiWnFGQ0wyTGc3akRwRWNzNWpqdnQ4cnB0ZFBIVTUzUGx5?=
 =?utf-8?B?TmR4S3FDbmxIQ0x3QnMreTlDM1hPWnFxQ1R1bS9kMGhNZXIyTlpzS0pBbzlE?=
 =?utf-8?B?eGNoQURlUUJRZWhUcFFxMGRPNHFYeVl4U0Z5b1JVL0FUb2R2M0N6UjRsY3FM?=
 =?utf-8?B?SmlhemFsZkhYYkFWZEwwZXJrdDQ1Nkp0QWFUbHFrSEt3WGpUL3pKODgzcGJQ?=
 =?utf-8?B?M2R0NUxqZzViZEJOVVdsODR5Q2hRalNSbnpWdVVjZzNsM2lSNDYreG42dWVE?=
 =?utf-8?B?Z0psc1JmTm1oZUxscmc0cnI1dFp1QlFuQTFCZk5nTnRaSW9BOGlJbC9GYVBF?=
 =?utf-8?B?dDI4b0c1Zlp6ZXdITStGNVpGbXMwTkRNRGF1Q3Q4WGk3MXN5NDZoNURqNFNM?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B25B3C0176A96D4FA7D63A2641226606@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d60d89d-889a-4260-7c1c-08daf7a59033
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 09:39:28.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bN471l3E0i9fLCTYVi30uymRAhtZkMGdJk6+1v2Cf0m77sfFvgpIbPfoUYCmj+21bf5G36eYDv5jUJELGA9xJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6229
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRha2luZyB0aGUgdGltZSB0byBoZWxwIHJl
dmlldywgSSB3b3VsZCBsaWtlIHRvIGFzayBhDQptb2RpZmljYXRpb24gYXMgZm9sbG93cy4NCg0K
T24gTW9uLCAyMDIzLTAxLTE2IGF0IDA5OjEwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiA+IA0KDQooc25pcCkNCg0KPiBPbiAxNi8wMS8yMDIzIDA0OjIxLCBNb3VkeSBIbyB3
cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21lZGlhL21lZGlhdGVrLG1kcDMtDQo+ID4gYWFsLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssbWRwMy0NCj4gPiBhYWwueWFtbA0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5kMmUxYjUyNDU3NzgN
Cj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21lZGlhL21lZGlhdGVrLG1kcDMtDQo+ID4gYWFsLnlhbWwNCj4gDQo+IEZpbGVuYW1l
IHNob3VsZCBtYXRjaCBjb21wYXRpYmxlLCB1bmxlc3MgeW91IGFscmVhZHkgZXhwZWN0IHRoaXMN
Cj4gYmluZGluZw0KPiB3aWxsIGNvdmVyIG90aGVyIGRldmljZXMuIElmIHNvLCB3aHkgbm90IGFk
ZGluZyB0aGVtIG5vdz8NCj4gDQoNCk1heSBJIHJlbmFtZSB0aGlzIGZpbGUgdG8gIm1lZGlhdGVr
LG10ODE5NS1tZHAzLnlhbWwiDQoNCj4gPiANCg0KKHNuaXApDQoNCj4gPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLG1kcDMtDQo+
ID4gY29sb3IueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9t
ZWRpYXRlayxtZHAzLQ0KPiA+IGNvbG9yLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMWQ4YWE1ZGM3NmI5DQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRl
ayxtZHAzLQ0KPiA+IGNvbG9yLnlhbWwNCj4gPiBAQCAtMCwwICsxLDYzIEBADQo+ID4gKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+
ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21lZGlhL21lZGlhdGVrLG1k
cDMtY29sb3IueWFtbCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IWxjZmVyckZGUC1tc2hESE5MLXJ3
SkxnTktEclhGOWZYb2xqcHFMMzBrNVlLVE52Q3d1QzN3ZWJ6UjMyVm5RUW9QZUZ2U3ZBZXdOa2V1
cGNUNG1qZEV3TkVLUDRWJMKgDQo+ID4gIA0KPiA+ICskc2NoZW1hOiANCj4gPiBodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3Jl
LnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFsY2ZlcnJGRlAtbXNoREhOTC1yd0pMZ05LRHJY
RjlmWG9sanBxTDMwazVZS1ROdkN3dUMzd2VielIzMlZuUVFvUGVGdlN2QWV3TmtldXBjVDRtamRF
ejYxOEpIcSTCoA0KPiA+ICANCj4gPiArDQo+ID4gK3RpdGxlOiBNZWRpYVRlayBNZWRpYSBEYXRh
IFBhdGggMyBDT0xPUg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBNYXR0aGlh
cyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KPiA+ICsgIC0gTW91ZHkgSG8gPG1v
dWR5LmhvQG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIE9u
ZSBvZiBNZWRpYSBEYXRhIFBhdGggMyAoTURQMykgY29tcG9uZW50cyB1c2VkIHRvIGFkanVzdCBo
dWUsDQo+ID4gbHVtYSBhbmQNCj4gPiArICBzYXR1cmF0aW9uIHRvIGdldCBiZXR0ZXIgcGljdHVy
ZSBxdWFsaXR5Lg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0K
PiA+ICsgICAgZW51bToNCj4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxOTUtbWRwMy1jb2xvcg0K
PiANCj4gVGhpcyBpcyBleGFjdGx5IHRoZSBzYW1lIGFzIHByZXZpb3VzIGZpbGUuIFdoeSBkbyB5
b3Ugc3BsaXQgdGhlDQo+IGJpbmRpbmc/DQo+IEl0IHJlYWxseSBsb29rcyB1bm5lY2Vzc2FyeS4N
Cj4gDQo+IFByb2JhYmx5IGFsbCBvdGhlciBmaWxlcyBzaG91bGQgYmUgYWxzbyBzcXVhc2hlZC4N
Cj4gDQoNCmFuZCBjb252ZXJ0IGFsbCBvdGhlciBiaW5kaW5ncyBpbnRvIGluZGl2aWR1YWwgY29t
cGF0aWJsZSBlbnVtcyB0bw0Kc3F1YXNoIGFsbCBmaWxlcz8NCg0KICBjb21wYXRpYmxlOg0KICAg
IGVudW06DQogICAgICAtIG1lZGlhdGVrLG10ODE5NS1tZHAzLWNvbG9yDQogICAgICAtIG1lZGlh
dGVrLG10ODE5NS1tZHAzLWFhbA0KICAgICAgLi4uDQoNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+
ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgbWVkaWF0ZWssZ2NlLWNsaWVudC1yZWc6
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgVGhlIHJlZ2lzdGVyIG9mIGNsaWVu
dCBkcml2ZXIgY2FuIGJlIGNvbmZpZ3VyZWQgYnkgZ2NlIHdpdGgNCj4gPiA0IGFyZ3VtZW50cw0K
PiA+ICsgICAgICBkZWZpbmVkIGluIHRoaXMgcHJvcGVydHksIHN1Y2ggYXMgcGhhbmRsZSBvZiBn
Y2UsIHN1YnN5cyBpZCwNCj4gPiArICAgICAgcmVnaXN0ZXIgb2Zmc2V0IGFuZCBzaXplLg0KPiA+
ICsgICAgICBFYWNoIHN1YnN5cyBpZCBpcyBtYXBwaW5nIHRvIGEgYmFzZSBhZGRyZXNzIG9mIGRp
c3BsYXkNCj4gPiBmdW5jdGlvbiBibG9ja3MNCj4gPiArICAgICAgcmVnaXN0ZXIgd2hpY2ggaXMg
ZGVmaW5lZCBpbiB0aGUgZ2NlIGhlYWRlcg0KPiA+ICsgICAgICBpbmNsdWRlL2R0LWJpbmRpbmdz
L2djZS88Y2hpcD4tZ2NlLmguDQo+IA0KPiBGdWxsLCByZWFsIHBhdGggcGxlYXNlLCBzbyBpdCBj
b3VsZCBiZSB2YWxpZGF0ZWQgd2l0aCB0b29scy4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KPiANCg0KU2luY2VyZWx5LA0KTW91ZHkNCg==
