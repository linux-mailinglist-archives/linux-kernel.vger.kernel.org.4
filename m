Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C207398EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjFVIC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFVIC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:02:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E1E1FDD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:02:19 -0700 (PDT)
X-UUID: 174dfd1010d311ee9cb5633481061a41-20230622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=n7NuJYrx1WNCUni4Au1VEhaBDIWl8wVWyxc0uDZuLv4=;
        b=dQTiE/l076viMWn+TMw2pEkrC/bmXlAneban7xwDR7jzhDz1J4bn0hmAi8vYjXxH0uA7ZY0W96c+dskTpwFYjySD+TUnhoonHFIpGhdjWzKEOrHhNrcYoRnehU+5uAoCFG83TboyU4b+aTLgqjm5Xa+ZXGb4c8yacJ9L6RZVYYc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:0ca0ab63-62b7-4b41-be41-10507d06bbf8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.27,REQID:0ca0ab63-62b7-4b41-be41-10507d06bbf8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:01c9525,CLOUDID:5df3353f-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230622160214L74RIH52,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 174dfd1010d311ee9cb5633481061a41-20230622
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 230029817; Thu, 22 Jun 2023 16:02:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 22 Jun 2023 16:02:09 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 22 Jun 2023 16:02:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joCIzzMMro8jomPsL8dpmya/CLRJ5+t+SjvwvwuJFvF8XuRBM2B6lR9RnuDKGWbRLfWnrWDYaO/5/7qVwcSkeWQizMGqgYeYNVjBdLBN5gUe41YvI2pWEyYpWiEU/yGDAsipRfAD1djghoKrtvwIW63lZQ2e9ZMDrWTeltmoXV3qh29HoLx8qMsiJXmCDP86+V1HhV455o6qdbRshECANfEkL4V38w9gq/ABRloRwnNb0nFYvXwu7IYc7q2+A5dEL0kYxDlbk0GYu4qm05+bsPMQGL1jN+LrlTNLQWN6t+Dq/fHzNnm3StFomNp/TNc57AV0vK5p6Xs+hC3w6aDIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7NuJYrx1WNCUni4Au1VEhaBDIWl8wVWyxc0uDZuLv4=;
 b=VHLrslJt1TGScG8hgzg30nV08QVfKNklg3arcj8zzvDYB4qqqy7gPTOMomLgGy0wWCrVkrfASMJomXCnhTFixhROYXBFvnoeiQGoLsJJIWbRL1n8Dq7Q0qjFG4gINSXgZ+ZYlpmj9asIgCe/GspNjF/OjLSb1UK0nSRTs/0K5FQgfwCkHcGuDA1AA53XCENnazbSRDIhKu0K5AdCzzE3crRKZYadLZlDj8pwQZlKJ5AkEqL3FcepnYEIe0+3E+UBE8wYy7F0u4WJS6XLw9MNxj5uxtzRM8HbpQChuubasuRuVijRHRJ/ERPk+hfu9f/B5CPAkr9C3E3hM5a5jRnoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7NuJYrx1WNCUni4Au1VEhaBDIWl8wVWyxc0uDZuLv4=;
 b=DerGvR+Doq9mNPoLH8yDnwkNYF9IS4IlRkOAe8uOtKhEvvDO2/n1oECmh0hoVcvSCrmlhanoeZppQn3hzN+Aq+1foKPapKMfzPli3cFVI2VHMV4H0IBW5rxOv60HpVv6U9OoMye6eX+iNLHCqQR/n+p0wfUZPp9Bz4F6Wy1z87g=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI2PR03MB5942.apcprd03.prod.outlook.com (2603:1096:4:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 08:02:07 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::7633:2649:3344:be19]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::7633:2649:3344:be19%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 08:02:07 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 3/4] drm/mediatek: Add casting before assign
Thread-Topic: [PATCH v3 3/4] drm/mediatek: Add casting before assign
Thread-Index: AQHZpCpze4o/ajTsOEOlfRNPyXn/w6+VMQEAgAFGVgA=
Date:   Thu, 22 Jun 2023 08:02:07 +0000
Message-ID: <4d7f86a662429256e5a0a5a52b9e8c375b22c382.camel@mediatek.com>
References: <20230621102247.10116-1-jason-jh.lin@mediatek.com>
         <20230621102247.10116-4-jason-jh.lin@mediatek.com>
         <797c0144-4072-8728-304e-e64213185687@baylibre.com>
In-Reply-To: <797c0144-4072-8728-304e-e64213185687@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI2PR03MB5942:EE_
x-ms-office365-filtering-correlation-id: 22319bca-a9c9-4510-d323-08db72f6f953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3HlCIPOsFMsEK/uNnTlb4k0bR9/VVcSiQGW5YCN/Zh8TeKBg393c15pUfJnaAznvtDRqEsaRwVdPR3Y+FQMRb5YxOptlOQpgUUeR9DOMfY3z6A+FtsVykaA2hNxrLPH6jG8rF7WUpVkSH3CKjgum30Z8tmOeicwqmpkjSNjr7U9b9xE6V92OwK1FRlQN5TO6Pva9fpAyxiVnycy3JN0qppaUbaxoWo8LZPFeMlLoep/8npFFbC7+8YZJ9/Jw/aW8APGcZKBs3OAOAB7DM9qWU9eXFGNzAL3qLrq6R5CQ4JOBaafiE1SwyJqMcdLMWVYJx+aA/R5QqK9akvTl9P3MkZmclovb61QqnH7AR/OFv9HL7mMqniJvToBHDHKdwV8u5/1dIEcaLsTifwa9C3Ddem+YzWlyudzbw5xhyiZ7Y5RnOUB75og59d7YskA7h9uoq1399xOLxxa1a47ew2FXBC+hjmSuFD/nG6ZOfq0nKcwp3AwqWTit8MIi7F8jNoGynWmAjMEucXtUYL67jCy6CNMvsH5xxrsq+KQT/gOESZW2NcdQgsN99n0WQ2N6spj9wNg9LxsIhuQNux470CouRWtRw+Jfr5AEdzradpLsfaWRKdWiqCj+vpRySLqg4I7xqUmsGxnRg9sx0xV3xGRiWi9NxcTloyk0Ux8Ibfjj+ROeXSsZNSDPjIDwIYcSr9/B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(41300700001)(5660300002)(91956017)(8936002)(8676002)(316002)(4326008)(64756008)(66476007)(66446008)(66946007)(66556008)(76116006)(2906002)(2616005)(6506007)(186003)(53546011)(83380400001)(6512007)(26005)(71200400001)(85182001)(36756003)(38070700005)(86362001)(38100700002)(122000001)(6486002)(54906003)(110136005)(478600001)(266184004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzZaaGdpRTBqYmJxUHRJaUZNWHBWSC9ZSllJWVp0My8wZHB5WkxVZEpCQ25x?=
 =?utf-8?B?aVV6Qjg1M2lON0Vla0x2RncwcGxvUUd1RWY2OWVYTmdwelRjU08zTXlXcDJp?=
 =?utf-8?B?UzJPN3NKWHR1SzNsS25XeGtwcmQ4NUh5Y3dsMHNid0IrSlZycVpOeUhySFpD?=
 =?utf-8?B?TDk2YVJJeDVsaCt1L0xaT0x1Zm9oNmZIZmcxQVhFSE9BN0VyUVhtUFZsUCt1?=
 =?utf-8?B?N25kZVVIWXFkZ3pZdm5MVVpNTVpTQ1ZRQW40Wm0zMUFzQVpzMEJwRE9JYWpa?=
 =?utf-8?B?ODZwYUJuN2dHUlRFUndsUEpkL1UreW04Y1V6NXdXUTgyVTkxU0ppVHRjMnA5?=
 =?utf-8?B?eWpnQmtXOFhDbHFWRnhRbWpzaDZXaG1QMXRWcENZZGhIUVZpN0dzd043SXdx?=
 =?utf-8?B?ckNneUZqbWZDOXVFYTVGM1hYQmdSYTZXcTY0MEhlSjk5ZjJLaCtSQ1NBaTVK?=
 =?utf-8?B?SWhoSUQ4YUNaWHBhUkNJOGJ5ZU5VV1RDaFpYbHZ1MUdLTUpJVHRpY0ltdUgv?=
 =?utf-8?B?SWdLMVVuU29UZm04a1ZWczNMOWNCd1RvcGJRRjNCWUtSanVqSXlUb28vUHBx?=
 =?utf-8?B?ZUxqVEdwcnl0ZC9IbTArZzZscE9ickRGYXVHQ0k3VEVFcTlDTDByVGw2djFD?=
 =?utf-8?B?YmZxSzUwU1d2cmxOYjhXZDVDL0JCTlVPS0x2WlFra29kQWdQYzNvU1paRXV5?=
 =?utf-8?B?SVRmOUY4QnA5d1hLbzJHYm4wdmxzWi8zcDMzaFJKV1ovN3hqNkg2K2k5cm1i?=
 =?utf-8?B?MTErNjkrVEh6V0U2OWpQcE1uWHNKZkhDa1dvZ2ZuWHMxbW5WYm1kMVJQMlRw?=
 =?utf-8?B?WDJCNWg0aGIweVVCeGRKUmFmV1ZmcmdMMDFjREpMeFVwRGI1SDBBckQ0T2NM?=
 =?utf-8?B?ZFRoNXFiNTVIdmR2Y0JUbGtJcmtxbFBnRjNCRTlKWDBjY015M2wrcFFmR0l2?=
 =?utf-8?B?REV0VUIyMTlIYnZTVnQxMTZZekZIT3RMRVB1YVFiVDRvbk1hTjJBcW8wNE05?=
 =?utf-8?B?SWhoUzFrNVpTcEl1dEtoclBOSkY1UEx1VjlOSXFxUzdwbjJjUi9EMlBoTmxr?=
 =?utf-8?B?WXV5UkhVR2UyTjlmTC95Y21pdUl2aEZueUZ3NFptYUNxVXl3Z3RmaFZiaUJm?=
 =?utf-8?B?Tkc0RXhhU1czVnYyYnhqTHpEQWZPVkxaUGFLa3R5dHhlejlWVTdNUVp5WVBM?=
 =?utf-8?B?QnBHbSt3UmFNaVlVVGk1cXNvUE9rWFpHcXdlNEw1V3NoNm1VMGd4ZlpnZTlu?=
 =?utf-8?B?ZVF4OTArZXRhSy9jdG9ydDhTaWZrbUdnVTZlanlQWkIyU3BicFFYbHVaQTFH?=
 =?utf-8?B?alNDN1ZjV1UrNjNUeElXemtob0VlS2FEenRzOVJxOWE5SUl1NEl6ckg5RjNP?=
 =?utf-8?B?cHFDNzFNVFhRTnRLWHBHeEprQVZBL0N3NzExWkZOb1crQmcvRlNZOUMxYjZ5?=
 =?utf-8?B?bzliVHpMNXVYMkxyNkZkUFpubWpBSHR0UTNOYnNOcjloNC9MRmxrcU4yYVJ1?=
 =?utf-8?B?M0kwNHNBMnJ2QnFxZEtXZUNWblNkMzBMV3BVemkwb0xlRVFjVFFVM2M5dE1N?=
 =?utf-8?B?Vm9jcU9XSFkyM1A2aDlqSlY0MHZBN3Z6OUZZRGNLQmVwZ1cxT0pHemVmcE1s?=
 =?utf-8?B?MzkybDVvaUJyMGtYdHAva3RPc2ZDRG9La0dUdDN2UjhBTFN0enpNdUNSelJQ?=
 =?utf-8?B?ZkQ4NWhpeTVwK2xpODg4dnp5dXFSbThVOUhKZ2ZRRkthSndjLzh1RE0rekI0?=
 =?utf-8?B?VHFGVmNtMWtLT01tQ2lYbGlFa1dscWIxb3lYMm9rTHZlOG1IWFZuaWdKT0xo?=
 =?utf-8?B?RlFsenBKMWREV1JPQURjOXVMb0pHb00xRWVsdWN5WTQ0MGs4RGdBenAwKzZp?=
 =?utf-8?B?S0taazNVZGdka2g1UmwzZyt1bkxYVWtJY25XeVhUMGFnc1NNKytXeWFSbzFN?=
 =?utf-8?B?NEdSYnJITFo0TWJJL1BNQlhENy9kMUZmUHNPaHRJMVlNTTh6TURtRC9hczB0?=
 =?utf-8?B?dzRYdmhpYkNQdGpWVk5VT2FEZGVRNXg4YkcxS0lFSjNuTVYrd3cyYTE2a2Vt?=
 =?utf-8?B?c29WaEtQbDlyQ1JqM3hTa3UreDRLU3hhSm5BK3VxM3k0cnJRNHNwbDc5ajNN?=
 =?utf-8?B?NkFHc3VhbzA3R0d0S0VudkJwWWtNYy9tYlFHNldUSWVreXJpVWc3VldhWS9q?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56468AF0D400D04E87A053473EB8B39E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22319bca-a9c9-4510-d323-08db72f6f953
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 08:02:07.3566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ngf3reRYwpQItB7O+EIeJCnMVZlSB0p0Dfsn2kYCtiEm4T5o1VCQTl3H1HvGPisQRcMynlbVmo7Zarr+//VTNn8rAY+6tRgUIxRlmcLq0G0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5942
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZHJlLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBXZWQsIDIwMjMt
MDYtMjEgYXQgMTQ6MzQgKzAyMDAsIEFsZXhhbmRyZSBNZXJnbmF0IHdyb3RlOg0KPiAgCSANCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gIA0KPiANCj4gT24gMjEvMDYvMjAyMyAxMjoyMiwgSmFzb24tSkguTGluIHdyb3RlOg0K
PiA+IDEuIEFkZCBjYXN0aW5nIGJlZm9yZSBhc3NpZ24gdG8gYXZvaWQgdGhlIHVuaW50ZW50aW9u
YWwgaW50ZWdlcg0KPiA+ICAgICBvdmVyZmxvdyBvciB1bmludGVuZGVkIHNpZ24gZXh0ZW5zaW9u
Lg0KPiA+IDIuIEFkZCBhIGludCB2YXJyaWFibGUgZm9yIG11bHRpcGxpZXIgY2FsY3VsYXRpb24g
aW5zdGVhZCBvZg0KPiBjYWxjdWxhdGluZw0KPiA+ICAgICBkaWZmZXJlbnQgdHlwZXMgbXVsdGlw
bGllciB3aXRoIGRtYV9hZGRyX3QgdmFycmlhYmxlIGRpcmVjdGx5Lg0KPiA+IA0KPiA+IEZpeGVz
OiAxYTY0YTdhZmY4ZGEgKCJkcm0vbWVkaWF0ZWs6IEZpeCBjdXJzb3IgcGxhbmUgbm8gdXBkYXRl
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9n
ZW0uYyAgIHwgIDMgKystDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9w
bGFuZS5jIHwgMjIgKysrKysrKysrKysrKy0tLS0NCj4gLS0tLS0NCj4gPiAgIDIgZmlsZXMgY2hh
bmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dlbS5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gPiBpbmRleCBhMjViMjhkM2VlOTAu
LmRhMDg3ZDc0NjEyZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9nZW0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2dlbS5jDQo+ID4gQEAgLTEyMSw3ICsxMjEsOCBAQCBpbnQgbXRrX2RybV9nZW1fZHVtYl9jcmVh
dGUoc3RydWN0IGRybV9maWxlDQo+ICpmaWxlX3ByaXYsIHN0cnVjdCBkcm1fZGV2aWNlICpkZXYs
DQo+ID4gICBpbnQgcmV0Ow0KPiA+ICAgDQo+ID4gICBhcmdzLT5waXRjaCA9IERJVl9ST1VORF9V
UChhcmdzLT53aWR0aCAqIGFyZ3MtPmJwcCwgOCk7DQo+ID4gLWFyZ3MtPnNpemUgPSBhcmdzLT5w
aXRjaCAqIGFyZ3MtPmhlaWdodDsNCj4gPiArYXJncy0+c2l6ZSA9IGFyZ3MtPnBpdGNoOw0KPiA+
ICthcmdzLT5zaXplICo9IGFyZ3MtPmhlaWdodDsNCj4gPiAgIA0KPiA+ICAgbXRrX2dlbSA9IG10
a19kcm1fZ2VtX2NyZWF0ZShkZXYsIGFyZ3MtPnNpemUsIGZhbHNlKTsNCj4gPiAgIGlmIChJU19F
UlIobXRrX2dlbSkpDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX3BsYW5lLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFu
ZS5jDQo+ID4gaW5kZXggMzFmOTQyMGFmZjZmLi4xY2Q0MTQ1NGQ1NDUgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gPiBAQCAtMTQ1LDYgKzE0
NSw3IEBAIHN0YXRpYyB2b2lkIG10a19wbGFuZV91cGRhdGVfbmV3X3N0YXRlKHN0cnVjdA0KPiBk
cm1fcGxhbmVfc3RhdGUgKm5ld19zdGF0ZSwNCj4gPiAgIGRtYV9hZGRyX3QgYWRkcjsNCj4gPiAg
IGRtYV9hZGRyX3QgaGRyX2FkZHIgPSAwOw0KPiA+ICAgdW5zaWduZWQgaW50IGhkcl9waXRjaCA9
IDA7DQo+ID4gK2ludCBvZmZzZXQ7DQo+IA0KPiBJIGFncmVlIHdpdGggQW5nZWxvLCBwbGVhc2Ug
c2V0IG9mZnNldCBhcyB1bnNpZ25lZC4NCj4gDQpJIHRoaW5rIG9mZnNldCBzaG91bGQgYmUgdW5z
aWduZWQsIGJ1dCBzaW5jZSBzcmMueDEgYW5kIHNyYy55MSBhcmUNCidpbnQnLiBUaGF0IG1lYW5z
ICd1bnNpZ25lZCBpbnQnIG9mZnNldCB3aWxsIGJlIHZlcnkgYmlnIHdoZW4gc3JjLngxIG9yDQpz
cmMueTEgaXMgbmVnYXRpdmUuDQpTbyBJIGp1c3QgdXNlICdpbnQnIGZvciBvZmZzZXQgaGVyZS4N
Cg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+ID4gICANCj4gPiAgIGdlbSA9IGZiLT5vYmpb
MF07DQo+ID4gICBtdGtfZ2VtID0gdG9fbXRrX2dlbV9vYmooZ2VtKTsNCj4gPiBAQCAtMTU0LDgg
KzE1NSwxMCBAQCBzdGF0aWMgdm9pZCBtdGtfcGxhbmVfdXBkYXRlX25ld19zdGF0ZShzdHJ1Y3QN
Cj4gZHJtX3BsYW5lX3N0YXRlICpuZXdfc3RhdGUsDQo+ID4gICBtb2RpZmllciA9IGZiLT5tb2Rp
ZmllcjsNCj4gPiAgIA0KPiA+ICAgaWYgKG1vZGlmaWVyID09IERSTV9GT1JNQVRfTU9EX0xJTkVB
Uikgew0KPiA+IC1hZGRyICs9IChuZXdfc3RhdGUtPnNyYy54MSA+PiAxNikgKiBmYi0+Zm9ybWF0
LT5jcHBbMF07DQo+ID4gLWFkZHIgKz0gKG5ld19zdGF0ZS0+c3JjLnkxID4+IDE2KSAqIHBpdGNo
Ow0KPiA+ICtvZmZzZXQgPSAobmV3X3N0YXRlLT5zcmMueDEgPj4gMTYpICogZmItPmZvcm1hdC0+
Y3BwWzBdOw0KPiA+ICthZGRyICs9IG9mZnNldDsNCj4gPiArb2Zmc2V0ID0gKG5ld19zdGF0ZS0+
c3JjLnkxID4+IDE2KSAqIHBpdGNoOw0KPiA+ICthZGRyICs9IG9mZnNldDsNCj4gDQo=
