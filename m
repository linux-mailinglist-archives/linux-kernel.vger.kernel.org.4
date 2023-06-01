Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E4C719278
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjFAFng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjFAFn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:43:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E4A10C2;
        Wed, 31 May 2023 22:42:52 -0700 (PDT)
X-UUID: 1ecaa038003f11eeb20a276fd37b9834-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xVziLR+4R/CLiFdMVnroIdKpE/c8NBlwZzWnUiLDJms=;
        b=KKvUda/zAK5CcqC1HplRDEMsCn2268dGzA/CgzV5caeZuAnShYIBLJvjH3A1FttE67Qu1EQpxxqyDyinWsFMiYFgVQYKXQJf+79Yghw3wlKoYP89iV4PAyyP9imu2QutDHfPWTRWL2e1TBL+bzSt4mQe7L7V0Hd9QIE8CJApl9g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:6742110b-2722-4099-8755-d0a73a842369,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:c958383d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 1ecaa038003f11eeb20a276fd37b9834-20230601
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 987404673; Thu, 01 Jun 2023 13:42:39 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 13:42:38 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 13:42:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4cMBd9p3ieDMvNEFMNINmVly8sTcei2V0YQSffmdkJmIt1B27UoS67Sui/chWNyf3momXuks1MeduVHWCVZYxoJdX4QLLkIKIDkNlVpjGtj11ffqGAQMGh05jM+q6sSpWVsqjJmtIq1imRx+PEUaNwQQpQ+RwtFdv+1NEL0KVwKEkaBZQi9B3OSwCESj2gHrPco2kn1ZDdugKnPMQH4PmJS+S02/rqikLr7e2pmjzAAYpyf3RCH+k2wgTnPvgrCj0bZ3F7rl8TtdPNY7AOTsCm+oVvpmubl+GqympLg3jNksQ3hz4Kf287+NFHyJ3DOLtpRD3xMkpTw5Rsq35X25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVziLR+4R/CLiFdMVnroIdKpE/c8NBlwZzWnUiLDJms=;
 b=TweVkComqi1k2ojReTH6WxtlNrD/plbuwn322ntvwXyFHACOUPcTbG9Q1QIr6JiHhP5W2h/NKD4aG8H9Iur50+ohuv/fO4jmgQvEGK2SnZTNMektFslksCtCFVU8XYK/g3zHgYmTMNhbO58rQP30P+yizU86u3RVBHZwdewe+n23y3UwQ7tvjk1DUmpXwq39C8CfTjZDASTeZmwdE5GRXNs6xgoTRDHoj4duDVRVSZRXTc6vqSAJkWw/09gbfKqIzacOrFeoGgOL+DL9PVwftw0CjJCz2P+qmiWDdbRNLtFBIGH/plyUwDx+/9D2iR+r9Sg4ua6jIaWzCgjOj07OMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVziLR+4R/CLiFdMVnroIdKpE/c8NBlwZzWnUiLDJms=;
 b=iOdMkwV8d4sSMxZOwYUvf0CkXJnECkAs4R2O/9Lputz3HJyLyqRIliHfNc5B+rP8AL3L2fo5EArmmcq+auZTmztguLvXF9PWQ31f3IY6U/LfI/oZh7IXsjs+SlVYMPtRuHPfJoE4dBoGiJJBKSef6uMPtU76lEUkwuVexCKgScI=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by SI2PR03MB5339.apcprd03.prod.outlook.com (2603:1096:4:105::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 05:42:36 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%9]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 05:42:36 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH v2] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZguL8DXJ4wwqPNE+3vDjAEU6xMa9fzDYAgBRRdwCAAA2JgIABY5CA
Date:   Thu, 1 Jun 2023 05:42:36 +0000
Message-ID: <017777e83cd83404513afa2bc21912332aecda98.camel@mediatek.com>
References: <20230510015851.11830-1-wenbin.mei@mediatek.com>
         <0df3968e-da34-b36c-4cb4-92d66508a46a@collabora.com>
         <e682b8b66261a71601707a4e74af2829f86800dc.camel@mediatek.com>
         <7f5e14e5-a814-efd7-6082-c4eff697c536@collabora.com>
In-Reply-To: <7f5e14e5-a814-efd7-6082-c4eff697c536@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|SI2PR03MB5339:EE_
x-ms-office365-filtering-correlation-id: be4d5131-8bdc-499a-e2b3-08db62630120
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7u5pWICAv0t/zqegCUsnJ44/3T2LPxEE0N0ZVSjsYjaqNuYU9fNlpZdwTp0g80s0gwou+m6qztYRHE/7wUWmCr2cAeeGnVPxDoZe2izgtnctZiekktXBOSCYoxSWmer41tv8Es1u0k9vCvAZixE1mO29y9Gd35sJtofBCvy8hfPjn2W9KsGYbfWpHfZk2FUwSJomD7I6CRoBbnX1fv3EVrUtHy4CtNqkoqNk5DnyiHhkSKhHOGrp5i5hIyV9cFazsUzKRUzxm2EBUF1a7WBElpz1BIB/S/R0B7o6UOhff9f8B7UKooK9MnHXjn43FjI9zvM15oZzy8AITrggbHoCFvwqsDyzr2KbA+ejf9J0MZg7hgLYI+Pz2yF8wf7H+VgrpprQ0fRS/nF9IiZwtrCNkI1oZ2wDQFD8mG+aSbsjMRso75IoI+gV7NUZ/waekhZNpIhQhq+QTkV+vwHKmidInDCUvs3XcTMqYDkhoFy2APN6lfhL9lPFUXmZmErSoR6LWFDj0p2XB6ylOSIYXR8eocBzECklV/+SsKiCjt8QH87d92P6WUvLkOolfLdXsRydEFo7j8QqdOE4rMaI6nvfEUiOvqrJg3CR1lQyIpyotB+mm1lphgnecSWVdgZCkH3oEKoxNJ0Kp01yZi5D1fHEPG38nhoImnxiyTmVJd86fn0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(41300700001)(478600001)(110136005)(54906003)(38100700002)(122000001)(66446008)(38070700005)(64756008)(66946007)(66476007)(76116006)(4326008)(36756003)(66556008)(85182001)(71200400001)(86362001)(316002)(6486002)(2616005)(107886003)(6512007)(6506007)(26005)(83380400001)(8676002)(2906002)(186003)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2tmcEloUkZEbk8zb1FlL2lVWGV6OGV3L1hWaUVlbElaYkYwZVNzVHRTT2Fw?=
 =?utf-8?B?WHFiTGpxbDE5R1doeEQ4N0RqeFZ5TDVLOXdZcUkzL2RNUnlCd1NGR244eE1S?=
 =?utf-8?B?MkxnV3pzUUtoRndleGhZa05pWGlRTlN5RTBHZ2pON0YyeVFxQXhWOWRXdGha?=
 =?utf-8?B?Qjgwc2RRbys0LzhIdVFNUWN6RUdSSHRQSDBhWDhSZEl4TmVmQzg5cTNTK3Vy?=
 =?utf-8?B?bndaUVA3Wk0vQlFrcEE0ZUN6ZisyeFRYdldmREhNMjlBdldPWGNselNBbkdO?=
 =?utf-8?B?T2VBeW1RMzIzMmJCWnJZQUFxQ1U2YjAxdXJhTVdPaXZQWHNsYWJteEVHNlZJ?=
 =?utf-8?B?N2FOdGpuQ0hPakVhSnltSzRxUE5jRkdIRjB0SXA5Nkxtcis0Z2tJVlZDQzcw?=
 =?utf-8?B?SjR3c1dSQm83Zm83dmlmU3BPRnpXQWgvblBPZ29NSkNyZDB1RkRjbkFwOEty?=
 =?utf-8?B?QXk5SHFwd1BGWlcrcWFwMHVCK0NNR3dFbkpUVUY3My91RzRUZ0Z6SFVBZEYr?=
 =?utf-8?B?enZHbis5V1ZzTzd4ZnpGbWdKbjZDeHRYTThBdjhtSEtCNGRobTFUTW5aNEVF?=
 =?utf-8?B?TlhCOXp4bjhzc2I1VG5EbEtVeFdSYzJYekJ6V0NBQjRuUE1UdjFNc0ZhMVVw?=
 =?utf-8?B?Mmo1ZTJ4UGhBaWJYZ053K2Jpc0Q3d2hzMG1XVzR5VEpOL0E3aE50QlI4UVFM?=
 =?utf-8?B?Y2dwTnBtOU5mZStPc3B2ZUlEVkt6ZDlvMWZIK0czUTZsM0JjTnc3TGI2ek1P?=
 =?utf-8?B?MkFLVXNXNDVCR0IwQlVaUmRDTXFaVkM1ZEVldVAvT1NLSXVBUTlYUkN0S0pO?=
 =?utf-8?B?b3VVRUY4NEh5cDlnQmNoTUszbWFSSkx5RjdPM1R0eUZlalhLdXFBeC9zekNa?=
 =?utf-8?B?N1Nnc0F6YjdnZEhBdkpzOThmeHJMR3VDRVR2ajJJQ1JTQUVVVC9XWDJEemUz?=
 =?utf-8?B?ZnV0QUFyUEV6VFY3QlpyVGZWRXplNmpRNWFBWHpyTzVtMlEyYUNIRVgrK2NN?=
 =?utf-8?B?QlVQOExCNExwZ01kVXIvdmdVSlI5Q0J5T01BMDIzcWVqbDgwNER0U1I1RWNR?=
 =?utf-8?B?UEsrTmROQUNIMWdWcjlCVVJ3K1hNd3dTUjVQWVNwdnBuVk5hMndmT3pYemdB?=
 =?utf-8?B?QXJxcXU1M0Vab1V5TWs3NUkweWt3ODNkL3hDTFg4c3pHNkMzcmpDQ3YvQnRD?=
 =?utf-8?B?TTBweldXL25XbDhCK29IUGp6UDc0MUJrcXNwY2NXeFczWFg2ZXJ1eGtIWkc5?=
 =?utf-8?B?dVlXUXpYT3NlbFFKTllaMmFtSHdWNEZKZHZCUXJnWXRVRHZaSHlsNWJsdk9F?=
 =?utf-8?B?bUVoY3BORXJ4ODRQY2hlbTVlL0ZSZXY4VnRndkR3THVIZGlyV05lMEY0ckd1?=
 =?utf-8?B?VG0yQmkrZDJkUEk4bGIrZDZPR3N2Zm9idW1HVGgzR2dWZFlZTUJBSVl6NW5J?=
 =?utf-8?B?OStpOUNrcU1LWGdDTWpxRzZZRDQ3akpTcjByTXhXdlVEd1FaZFp5V2JXNndB?=
 =?utf-8?B?d3I4VWJ4SzZaWStNWkxJZXZWMU9VYVR1QzlldVI1Z0dXUjhnd21qWTU2aEZz?=
 =?utf-8?B?Q0gwVml3TUtBZ3IwcnZhbVlCb0FYWjllTHhSTWYrbzQrK3Q5cGtERDJsTUtS?=
 =?utf-8?B?QnFVVmRrbUdTQUI2MjI2UUw1SWk5N1NkUWp2eklaWGRkV2hMTGpFYjlvdDFr?=
 =?utf-8?B?Tk4rYzRBeHlLWDhBeitTUWFVSXBGUkdwUzFFVDJXSENrUHRTYm5oZHlHZlpm?=
 =?utf-8?B?WkM4VUR6MFY5T243U1dLODJQeGtsc3ZjUWZuZ2UydVlpSnVlR1pMdVhhS2Zu?=
 =?utf-8?B?KzljZWQ2bnBYNXFDMzdnMEFpeXkxMmdNTE1zODA0bE5hMzkrc3dvamVFSVhE?=
 =?utf-8?B?c0s1NUxDVkgwbUZFM0E2aFZSNTFuTHMycEtWdGlSWkROY2xVQkV4dFJITUo0?=
 =?utf-8?B?S1orQ1lscklvMUQ2YlhSR1FwMlROSkJEZkhDZXZPczBwNktCeURvd2FsamJW?=
 =?utf-8?B?WG5HbXhLamo1Z2lWZHptbEdNQ0Q5bkFVd2tWUDd5RjRSSEFadkI2QjRoalEz?=
 =?utf-8?B?ZjU3Rm1vand0a2lZcG5mVVZNcEp0eTFuQ2g4RWx0ZGNPSEhiN3FHTW9MR1Zi?=
 =?utf-8?B?YjZoMmxhdnVrR3JaNldXZVAra3lrTHhMb0xtQlVnZkJLdDBDRE9pSkxyREYv?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEA40E9A8ED9494E906F9849E0EF7B07@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4d5131-8bdc-499a-e2b3-08db62630120
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 05:42:36.3207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uaKSnD31/Gr/L3BAPGow/l1CVqU3KKR77l6Ya5VGxitgBDJPhhTOfKckjG+6cYTOzFysJLa8WimU+XN/VbVL4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTMxIGF0IDEwOjE4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAzMS8wNS8yMyAwOTozMiwgV2VuYmluIE1l
aSAo5qKF5paH5b2sKSBoYSBzY3JpdHRvOg0KPiA+IE9uIFRodSwgMjAyMy0wNS0xOCBhdCAxMTox
MyArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gd3JvdGU6DQo+ID4+IEV4dGVy
bmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
DQo+IHVudGlsDQo+ID4+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+ID4+DQo+ID4+DQo+ID4+IElsIDEwLzA1LzIzIDAzOjU4LCBXZW5iaW4gTWVpIGhhIHNj
cml0dG86DQo+ID4+PiBDUUhDSV9TU0MxIGluZGljYXRlcyB0byBDUUUgdGhlIHBvbGxpbmcgcGVy
aW9kIHRvIHVzZSB3aGVuIHVzaW5nDQo+ID4+PiBwZXJpb2RpYw0KPiA+Pj4gU0VORF9RVUVVRV9T
VEFUVVMoQ01EMTMpIHBvbGxpbmcuDQo+ID4+PiBUaGUgZGVmYXVsdCB2YWx1ZSAweDEwMDAgdGhh
dCBjb3JyZXNwb25kcyB0byAxNTB1cywgbGV0J3MNCj4gZGVjcmVhc2UNCj4gPj4+IGl0IHRvDQo+
ID4+DQo+ID4+IFRoZSBkZWZhdWx0IHZhbHVlIDB4MTAwMCAoNDA5NikgY29ycmVzcG9uZHMgdG8g
NDA5NiAqIDUyLjA4dVMgPQ0KPiA+PiAyMzEuMzN1Uw0KPiA+PiAuLi5zbyB0aGUgZGVmYXVsdCBp
cyBub3QgMTUwdVMuDQo+ID4+DQo+ID4+IElmIEknbSB3cm9uZywgdGhpcyBtZWFucyB0aGF0IHRo
ZSBDUUNBUCBmaWVsZCBpcyBub3QgMCwgd2hpY2gNCj4gd291bGQNCj4gPj4gbWVhbg0KPiA+PiB0
aGF0IHRoZSBleHBlY3RlZCAzdVMgd291bGQgYmUgd3JvbmcuDQo+ID4+DQo+ID4+IEFsc28sIHNp
bmNlIHRoZSBjYWxjdWxhdGlvbiBjYW4gYmUgZG9uZSBkeW5hbWljYWxseSwgdGhpcyBpcyB3aGF0
DQo+IHdlDQo+ID4+IHNob3VsZA0KPiA+PiBhY3R1YWxseSBkbyBpbiB0aGUgZHJpdmVyLCBhcyB0
aGlzIGdpdmVzIGluZm9ybWF0aW9uIHRvIHRoZSBuZXh0DQo+ID4+IGVuZ2luZWVyDQo+ID4+IGNo
ZWNraW5nIHRoaXMgcGllY2Ugb2YgY29kZS4NCj4gPj4NCj4gPj4gQXBhcnQgZnJvbSB0aGlzLCBi
eSBqdXN0IHdyaXRpbmcgMHg0MCB0byB0aGUgQ1FIQ0lfU1NDMSByZWdpc3RlciwNCj4geW91DQo+
ID4+IGFyZQ0KPiA+PiBhc3N1bWluZyB0aGF0IHRoZSBDUUNBUCB2YWx1ZSByZXF1aXJlbWVudCBp
cyBmdWxsZmlsbGVkLCBidXQgeW91DQo+ID4+IGNhbm5vdA0KPiA+PiBhc3N1bWUgdGhhdCB0aGUg
Ym9vdGxvYWRlciBoYXMgc2V0IHRoZSBDUUNBUCdzIElUQ0ZWQUwgYW5kIElUQ0ZNVUwNCj4gPj4g
ZmllbGRzDQo+ID4+IGFzIHlvdSBleHBlY3Qgb24gYWxsIHBsYXRmb3JtczogdGhpcyBtZWFucyB0
aGF0IGltcGxlbWVudGluZyB0aGlzDQo+ID4+IHRha2VzDQo+ID4+IGEgbGl0dGxlIG1vcmUgZWZm
b3J0Lg0KPiA+Pg0KPiA+PiBZb3UgaGF2ZSB0d28gd2F5cyB0byBpbXBsZW1lbnQgdGhpczoNCj4g
Pj4gICAgKioqIEZpcnN0ICoqKg0KPiA+PiAgICAxLiBSZWFkIElUQ0ZNVUwgYW5kIElUQ0ZWQUws
IHRoZW46DQo+ID4+ICAgICAgIHRjbGtfbXVsID0gaXRjZm11bF90b19taHooSVRDRk1VTCk7IC8q
IHBzZXVkbyBmdW5jdGlvbg0KPiA+PiBpbnRlcnByZXRzIHJlZyB2YWx1ZSovDQo+ID4+ICAgICAg
IHRjbGsgPSBJVENGVkFMICogdGNsa19tdWw7DQo+ID4+DQo+ID4+ICAgIDIuIFNldCBTU0MxIHNv
IHRoYXQgd2UgZ2V0IDNuUzoNCj4gPj4gICAgICAgI2RlZmluZSBDUUhDSV9TU0MxX0NJVCBHRU5N
QVNLKDE1LCAwKQ0KPiA+PiAgICAgICBwb2xsX3RpbWUgPSBjaXRfdGltZV9uc190b19yZWd2YWwo
Myk7DQo+ID4+ICAgICAgIHNzY2l0ID0gRklFTERfUFJFUChDUUhDSV9TU0MxX0NJVCwgcG9sbF90
aW1lKQ0KPiA+PiAgICAgICBjcWhjaV93cml0ZWwoIC4uLiApDQo+ID4+DQo+ID4+ICAgICoqKiBT
ZWNvbmQgKioNCj4gPj4NCj4gPj4gICAgMS4gUHJlLXNldCBJVENGTVVMIGFuZCBJVENGVkFMIHRv
DQo+ID4+ICAgICAgIElUQ0ZWQUwgPSAxOTIgKGRlY2ltYWwpDQo+ID4+ICAgICAgIElUQ0ZNVUwg
PSAyICh3aGVyZSAyID09IDAuMU1IeikNCj4gPj4NCj4gPj4gICAgMi4gU2V0IFNTQzEgc28gdGhh
dCB3ZSBnZXQgM25TOg0KPiA+PiAgICAgICAjZGVmaW5lIENRSENJX1NTQzFfQ0lUIEdFTk1BU0so
MTUsIDApDQo+ID4+ICAgICAgIHBvbGxfdGltZSA9IGNpdF90aW1lX25zX3RvX3JlZ3ZhbCgzKTsN
Cj4gPj4gICAgICAgc3NjaXQgPSBGSUVMRF9QUkVQKENRSENJX1NTQzFfQ0lULCBwb2xsX3RpbWUp
DQo+ID4+ICAgICAgIGNxaGNpX3dyaXRlbCggLi4uICkNCj4gPj4NCj4gPj4gSSB3b3VsZCBpbXBs
ZW1lbnQgdGhlIGZpcnN0IHdheSwgYXMgaXQgcGF2ZXMgdGhlIHdheSB0byBleHRlbmQNCj4gdGhp
cw0KPiA+PiB0byBkaWZmZXJlbnQNCj4gPj4gdGNsayB2YWx1ZXMgaWYgbmVlZGVkIGluIHRoZSBm
dXR1cmUuDQo+ID4+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+IEFuZ2Vsbw0KPiA+IEhpIEFuZ2VsbywN
Cj4gPiANCj4gPiBTb3JyeSBmb3IgbGF0ZWx5IHJlcGx5Lg0KPiA+IA0KPiA+IEZvciBNZWRpYXRl
ayBtbWMgaG9zdCBJUCwgSVRDRk1VTCBpcyAweDIoMHgxTUh6KSwgSVRWRlZBTCByZXBvcnRzDQo+
IDE4MiwNCj4gPiBhbmQgdGhlc2UgZmllbGRzIGFyZSB0aGUgc2FtZSBhbmQgYXJlIHJlYWRvbmx5
IGZvciBhbGwgSUMsIGJ1dA0KPiBzaW5jZQ0KPiA+IE1lZGlhdGVrIENRRSB1c2VzIG1zZGNfaGNs
aygyNzNNSHopLCBDTUQxMydpbnRlcnZhbCBjYWxjdWxhdGlvbg0KPiBkcml2ZXINCj4gPiBzaG91
bGQgdXNlIDI3M01IeiB0byBnZXQgdGhlIGFjdHVhbCB0aW1lLCBzbyB0aGUgYWN0dWFsIGNsb2Nr
IGlzDQo+ID4gMjcuM01Iei4NCj4gPiANCj4gDQo+IFlvdSdyZSByaWdodCwgSSd2ZSBtaXNyZWFk
IHRoZSBkYXRhc2hlZXQsIGp1c3QgcmVjaGVja2VkIGFuZCBpdA0KPiByZXBvcnRzIFJPLg0KPiAN
Cj4gPiBJZiBDSVQgaXMgMHgxMDAwIGJ5IGRlZmF1bHQsIENNRCBpZGxlIHRpbWU6IDB4MTAwMCAq
IDEgLyAyNy4zTUh6ID0NCj4gPiBhcm91bmQgMTUwdXMuDQo+ID4gDQo+ID4gSW4gYWRkaXRpb24g
dGhlIGJvb3Rsb2FkZXIgd2lsbCBub3Qgc2V0IHRoZSBDUUNBUCdzIElUQ0ZWQUwgYW5kDQo+IElU
Q0ZNVUwNCj4gPiBmaWVsZHMsIGJlY2F1c2UgdGhlc2UgZmllbGRzIG9mIENRQ0FQIHJlZ2lzdGVy
IGlzIFJPKHJlYWRvbmx5KSwgc28NCj4gd2UNCj4gPiBjYW4gaWdub3JlIHRoZSBjaGFuZ2UgZm9y
IHRoZSBDUUNBUCdzIElUQ0ZWQUwgYW5kIElUQ0ZNVUwgZmllbGRzLg0KPiA+IA0KPiANCj4gWWVz
LCB0aGF0J3MgcmlnaHQsIGFnYWluIC0gdGhpcyBtZWFucyB0aGF0IHlvdSBzaG91bGQgZ28gZm9y
IHRoZQ0KPiBmaXJzdA0KPiBwcm9wb3NlZCBpbXBsZW1lbnRhdGlvbiwgYXMgZnV0dXJlIE1lZGlh
VGVrIFNvQ3MgbWF5IChvciBtYXkgbm90KQ0KPiBjaGFuZ2UNCj4gdGhhdDogaWYgeW91IGltcGxl
bWVudCBhcyBwcm9wb3NlZCwgdGhpcyBpcyBnb2luZyB0byBiZSBhIG9uZS10aW1lDQo+IHRoaW5n
DQo+IGFuZCBmdXR1cmUgU29DcyB3b24ndCBuZWVkIHNwZWNpZmljIGNoYW5nZXMuDQo+IA0KPiBU
aGF0IGltcGxlbWVudGF0aW9uIGFsc28gZG9jdW1lbnRzIHRoZSBmbG93IGFib3V0IGhvdyB3ZSdy
ZSBnZXR0aW5nDQo+IHRvDQo+IHRoZSBhY3R1YWwgdmFsdWUsIHdoaWNoIGlzIGltcG9ydGFudCBm
b3IgY29tbXVuaXR5IHBlb3BsZSByZWFkaW5nDQo+IHRoaXMNCj4gZHJpdmVyIGluIHRoZSBmdXR1
cmUgZm9yIGRlYnVnZ2luZyBwdXJwb3Nlcy4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiAN
ClRoYW5rcyBmb3IgeW91ciBwcm9wb3NhbC4NCkkgaGF2ZSBkaXNjdXNzZWQgd2l0aCBvdXIgZGVz
aWduZXIsIGFuZCB0aGUgZmllbGRzIG9mIENRQ0FQJ3MgSVRDRlZBTA0KYW5kIElUQ0ZNVUwgd2ls
bCBub3QgY2hhbmdlLg0KSWYgd2UgYWRkIG1vcmUgY29kZSBmb3IgaXQsIHRoZXNlIGNvZGVzIHdp
bGwgYWxzbyBhZmZlY3QgdGhlIGV4ZWN1dGlvbg0KZWZmaWNpZW5jeSwgZXZlbiBpZiBpdCBoYXMg
YSB2ZXJ5IHNtYWxsIGVmZmVjdC4NCkkgdGhpbmsgaWYgaXQncyBqdXN0IGZvciByZWFkaW5nIGNv
bnZlbmllbmNlLCB3ZSBjYW4gYWRkIG1vcmUgY29tbWVudHMNCnRvIG1ha2UgaXQgZWFzaWVyIHRv
IHJlYWQgdGhlIGNvZGUuDQpEbyB5b3UgdGhpbmsgaXQncyBva2F5IHRvIGFkZCBtb3JlIGNvbW1l
bnRzPw0KDQpCZWdhcmRzLA0KV2VuYmluDQo+ID4gVGhhbmtzDQo+ID4gV2VuYmluDQo+ID4+DQo+
ID4+PiAweDQwIHRoYXQgY29ycmVzcG9uZHMgdG8gM3VzLCB3aGljaCBjYW4gaW1wcm92ZSB0aGUg
cGVyZm9ybWFuY2UNCj4gb2YNCj4gPj4+IHNvbWUNCj4gPj4+IGVNTUMgZGV2aWNlcy4NCj4gPj4+
DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBXZW5iaW4gTWVpIDx3ZW5iaW4ubWVpQG1lZGlhdGVrLmNv
bT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYyB8IDQgKysr
Kw0KPiA+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJpdmVycy9tbWMvaG9z
dC9tdGstDQo+IHNkLmMNCj4gPj4+IGluZGV4IGVkYWRlMGU1NGEwYy4uZmZlY2NkZGNkMDI4IDEw
MDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+Pj4gKysrIGIv
ZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+Pj4gQEAgLTI0NTMsNiArMjQ1Myw3IEBAIHN0
YXRpYyB2b2lkDQo+IG1zZGNfaHM0MDBfZW5oYW5jZWRfc3Ryb2JlKHN0cnVjdA0KPiA+Pj4gbW1j
X2hvc3QgKm1tYywNCj4gPj4+ICAgIHN0YXRpYyB2b2lkIG1zZGNfY3FlX2VuYWJsZShzdHJ1Y3Qg
bW1jX2hvc3QgKm1tYykNCj4gPj4+ICAgIHsNCj4gPj4+ICAgICAgICBzdHJ1Y3QgbXNkY19ob3N0
ICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCj4gPj4+ICsgICAgIHN0cnVjdCBjcWhjaV9ob3N0ICpj
cV9ob3N0ID0gbW1jLT5jcWVfcHJpdmF0ZTsNCj4gPj4+DQo+ID4+PiAgICAgICAgLyogZW5hYmxl
IGNtZHEgaXJxICovDQo+ID4+PiAgICAgICAgd3JpdGVsKE1TRENfSU5UX0NNRFEsIGhvc3QtPmJh
c2UgKyBNU0RDX0lOVEVOKTsNCj4gPj4+IEBAIC0yNDYyLDYgKzI0NjMsOSBAQCBzdGF0aWMgdm9p
ZCBtc2RjX2NxZV9lbmFibGUoc3RydWN0IG1tY19ob3N0DQo+ID4+PiAqbW1jKQ0KPiA+Pj4gICAg
ICAgIG1zZGNfc2V0X2J1c3lfdGltZW91dChob3N0LCAyMCAqIDEwMDAwMDAwMDBVTEwsIDApOw0K
PiA+Pj4gICAgICAgIC8qIGRlZmF1bHQgcmVhZCBkYXRhIHRpbWVvdXQgMXMgKi8NCj4gPj4+ICAg
ICAgICBtc2RjX3NldF90aW1lb3V0KGhvc3QsIDEwMDAwMDAwMDBVTEwsIDApOw0KPiA+Pj4gKw0K
PiA+Pj4gKyAgICAgLyogZGVjcmVhc2UgdGhlIHNlbmQgc3RhdHVzIGNvbW1hbmQgaWRsZSB0aW1l
ciB0byAzdXMgKi8NCj4gPj4+ICsgICAgIGNxaGNpX3dyaXRlbChjcV9ob3N0LCAweDQwLCBDUUhD
SV9TU0MxKTsNCj4gPj4+ICAgIH0NCj4gPj4+DQo+ID4+PiAgICBzdGF0aWMgdm9pZCBtc2RjX2Nx
ZV9kaXNhYmxlKHN0cnVjdCBtbWNfaG9zdCAqbW1jLCBib29sDQo+IHJlY292ZXJ5KQ0KPiA+Pg0K
PiA+Pg0KPiANCj4gDQo=
