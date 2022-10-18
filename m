Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858186023D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiJRFfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJRFfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:35:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B70B9E0C9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:35:44 -0700 (PDT)
X-UUID: 1b77ff2ccdec4bb398d5ed57b08ded2f-20221018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RsoTrzg0QJaQA7LB/2Ah/UUphK8hQ+y+i5bpMf6gbdc=;
        b=CPIDmltl9iyWfHv0TU2GKK9XlKE8IjathEnJE69BTZe2yY8BLtve1+aKC5jbFGbqRTrXHw/DE0hlhgkEt3WJ+gDINNMrp5DIy8ggeG14YqAeCiloKsnt4BbSZzLUnZyydQQUxugXqE2l/vuTgP1WNLKxJn/ku6QsnxqT2uFFtuw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:6aa748a4-867a-4394-8899-8c5fe6a94b26,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.11,REQID:6aa748a4-867a-4394-8899-8c5fe6a94b26,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:7ae01ea4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:22101813354132SV1OZ4,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1b77ff2ccdec4bb398d5ed57b08ded2f-20221018
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1690254368; Tue, 18 Oct 2022 13:35:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 18 Oct 2022 13:35:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 18 Oct 2022 13:35:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWfBScTScsjwfXTChX0ZW3Uq1GFpRx+ZYoV1ccgxNnlosn3FGw3iuEkiQyAQKLloyS9zKlD/FTYIPapjrDX+1/BGvydXETx1/2CrJ/h/b/SUQtyqWmE/ljnmc6HYfHGFmgju5eb2ZGQBFzMKi1xefj739EGfgd+jFkYpdLHF04vkeGIZmOAD/eiAPmH9ArRkOvjXIz7R5anz8LAsMImAG/HphZG6UZXbjudDqRjIVlxosGVfMPMwMZHSS9Y9S3A27E3T1tggE0z2rxlDvU5LkwrFrPxEs3xFAq6WuHqWbrX2Q5o9298CnYnGf4CXQg6G6AW31pdoHu62fMGGnnhUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsoTrzg0QJaQA7LB/2Ah/UUphK8hQ+y+i5bpMf6gbdc=;
 b=b9r05kvkeQA1Kl2AgJXqqnpbiDiGp64l/oRsxmAs7GKPvPC7uxx9t+XirlRx1dni+/s1ahaXhmwP0C/hLSynTH9P+VGqizvR+sOgsYEXloz+AHxniTvxj58g5+hdODZsqqPzvv2abXcHNki9ut3/EJOT6yWvO01EdEDuU4gywBnk/bEbsk5AUxNRZryC+nTMXTKq/TKXPOCuQye78sZcOLBBjormFBcMUlO6e+qApFdug99ewFrdEA6w6lLW2p/vv8fG41VRCP3VVickmwZa/md07nUo+X95VcVr183dcs6B3Wo9wq1jevDbEqG4As/Fl0ipD6HxSoBDr2lRyQT4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsoTrzg0QJaQA7LB/2Ah/UUphK8hQ+y+i5bpMf6gbdc=;
 b=EbFoeR4ESiJq9QnhUaLZOwmh/kVUEp2dQzvMfWR9FbXH7jiPDjEO18PpburExmgzysP14oHTXOU32eA4lo0sLdTlclsB8EQ5CVVX0ig0X0Gvwt9bQvB0RUN7hvvKKlTwcSqtFblcIDrcNAIggjtCb5l51eCjCCz1MJ8CTmBL9os=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYUPR03MB7138.apcprd03.prod.outlook.com (2603:1096:400:353::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.15; Tue, 18 Oct
 2022 05:35:37 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::7559:b2bb:eee0:fac]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::7559:b2bb:eee0:fac%5]) with mapi id 15.20.5746.015; Tue, 18 Oct 2022
 05:35:34 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>
Subject: Re: [PATCH v10, 2/4] mailbox: mtk-cmdq: add gce software ddr enable
 private data
Thread-Topic: [PATCH v10, 2/4] mailbox: mtk-cmdq: add gce software ddr enable
 private data
Thread-Index: AQHY3JvsaBbwoCRFt0CLrFFdb9EuJq4TraqA
Date:   Tue, 18 Oct 2022 05:35:34 +0000
Message-ID: <5c18571076332dadc345d059366eca14d77e72a4.camel@mediatek.com>
References: <20221010085023.7621-1-yongqiang.niu@mediatek.com>
         <20221010085023.7621-3-yongqiang.niu@mediatek.com>
In-Reply-To: <20221010085023.7621-3-yongqiang.niu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYUPR03MB7138:EE_
x-ms-office365-filtering-correlation-id: e96a09bc-ecf0-41ce-fb80-08dab0ca947b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jp5E7o1UFgzTuHm2Of6IPaI51gj/KEbQM/ziTZFq9sRcBUhkNSXXoiZn7koAieuIW9/iX1Z3b6FWHNo4N6TtI72f2lFbyoX6lNaUQWq4hXHLDz+BZkjYB9WCrhxHxkDH0wva/b69e0D3cr+FWKQR5AUR8eql1vsOMEQH1A+dZKeKms4uolFK9qLICpWKdRLiZI0gvfYhcu42SeBWniyw9PhJ0iRGsx8vRP9fKTKQzaOcHF4+yW9Mk4QAAOYsE35JfhKkR+s01EFeH5GwnRSUn+LzrgszD0TKfauA6Br+HgdxHVpAc2GPp5FK9KDkWdqLCyhSkk7NRykBY7cOUV55kMgga+OevzS2B84UmB4CNAmC3ZN1wtZEjQAZJ66cC+hbT6RKKT9NqsYgN+uRx+yBsQmpuWecERYZyTU7BmGhHS6baYErWgiqIL8Lmm6m0wOoT/bJ3iD71ZCOreJ/PydXQjp2pnZASpJQlXZbSCfHLLbu2GpLs9kbGbjFFcCJQpTBwYr3SefWKWFnOYHQtyHFfmd0SEWZ2p1fD4F+Pam4QoUJ+TBVk7QXRhbcLWC8u/Ec7cxws4UH+3nWg5ZsShR/xr25mk3MgQrSZHVOsszNcXKlbEeKXexCXR5FGPxwb/sL4QIkvP36O5yMOqsDCC/0f3InqRFvnNODyZDAVRiG9ZQiQMA74076pf/5rg6Fn/whgHAFRa9GEEYbwYhsMq4A51pFOiHagtJwTCtmPl8HFSGorgnjAyWYsJ/GUv4FSt5OH4fDRe54ZelnuHl7kj9nUj5woZVKPyOmRrvhdzR6V/lbKPRamL0jg36ZKNC8YL67
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199015)(76116006)(71200400001)(6486002)(110136005)(4326008)(66476007)(66556008)(8676002)(64756008)(66446008)(86362001)(66946007)(54906003)(478600001)(316002)(6512007)(26005)(38100700002)(15650500001)(6506007)(5660300002)(41300700001)(8936002)(2616005)(85182001)(38070700005)(83380400001)(122000001)(36756003)(186003)(2906002)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTFuYW5pQjhZay9nT3p3QW54WFVCR0I3RDdGeU8zeTJ1dktFYVFUM0pHeWtD?=
 =?utf-8?B?MGdrdUZHelZONXhjMmErdmQrSzJlbnIzU01odXpHR2FubWUxRjVOTHByTFpV?=
 =?utf-8?B?UjVCbkNWR2E2VmRWSGYvSjV0UE9XZnloTk5wVWwzODY3MU8ydFZjRVMvZlUr?=
 =?utf-8?B?aVNYZUJVSjE5dFlVcUxFcDVNMEFMUkxBQ0VKNlZDVWZOU0NFcElMRTV6R2dl?=
 =?utf-8?B?cTFtbkxEWS9wOXQ5L1lZUmZNS01uUjZQTytVM3huYklGcXZtWVBBMHR2SkdQ?=
 =?utf-8?B?UGczeTVGVUJmTDEwYU1CZHp0TXIzRFZObGtHdWFiZGtjMWJncXMybzFEQ2Fm?=
 =?utf-8?B?RURjeVZZcXVFa1RzdnJlcjlDbzdad2ErWDViWkErSDdrV3hDWkkvc0VuNjJO?=
 =?utf-8?B?dGZ0WEtRK3RCNXJPY2N3eS9GTlNTa2E1OUxQcGpjcGdSM0FGeHRwZ0tFTnV5?=
 =?utf-8?B?R0c1T3crbFFHSUdLTTE1MTRvQ2hPcnpIdHpwUXBORlBjT2FEMmJibS9XTmRC?=
 =?utf-8?B?RjFYeWR1WXlMQnVhL0pScnpJYS93RnJtN0JjNlprMnhwZjlDSDg0aENFWGlm?=
 =?utf-8?B?dm02Z0RTS2NuQ3dUbTMzV0FTdHcvYjJ6aEM2dUNKLy92Zi82eTUxMTU5QnBa?=
 =?utf-8?B?U05La1E2eTdGdUREd0N2ZmJwd05iN0xFdmRvbXd2U3FRbk1MMjNHZkNmb2lP?=
 =?utf-8?B?OS9sVUNIZTUyUW5CWTZXVVhUMmN1WHp0Vm5HR3VpUHNJZTZmclJFNGp0bHBX?=
 =?utf-8?B?OWtDZWlTUWNON1N5WXdGVFNRQWFveE9SK2V4MWlQaW5mUEhyeHR1NEVOSXlH?=
 =?utf-8?B?SnJWUDBwVWVlSXJiUVBXbk0rRjkxenB0ajdGSFRFMGh2VHY0Y1NBeTNZTmNL?=
 =?utf-8?B?K2VGbS9oUmtmMGc1ZVhSeTF2L3dNWlUwcG9KZ1NuS1ZISld6UUJHSWlkSWw1?=
 =?utf-8?B?dmJkSjhVejJKZVJ0RWQrZGgvdkEwU1AybEdSbEY0SUQzcXRweWNQOUROVXpj?=
 =?utf-8?B?VkRQNEh1WU95YVFTazFYVVZ6OGkzWUdDTmpnclBJbmFPVmJUR3dnZW1JT051?=
 =?utf-8?B?aWtETjNYUktORTFTbm01WkNDdk9TZXBXQXduNythWnc4eUM5NUYza2NLWXFt?=
 =?utf-8?B?VWUzWUUzTlBvZkpOajZ4czNiT3BkaEpGUERVWGhVUk5hYmFTYUdORVJQZ3JW?=
 =?utf-8?B?OGgyVERxNmtScnd2NVN5Q3cyK0REa1pNNEVlcndnQ2dnYkQzQ3FPTzUvNmJt?=
 =?utf-8?B?MXNEY2trcGZNeHNNVE1wYjJhZE94bU9DRWdCYVB3djVQZncwdnBVYzJ5OHUy?=
 =?utf-8?B?ZmxHRVpSSU9na1BzalpBWWgxVG9ld25KbWgrVzZBdEt0b3RDb0g1ZHNXb2JM?=
 =?utf-8?B?ZzM5Z0dwakFzc3A3NHRKSHRCL2hQeGhnN2xLMTZEZ1p6Q0kzQnNKREZNNlVL?=
 =?utf-8?B?MFRkODJJTGwwbkpubHNnSTI1d1NMMWRvN2hBeStHMGVlSkJvTkdmclBlMWxt?=
 =?utf-8?B?aE14T3FBTDYrRXJySVNsV1dWd2VUSE51aEcyYUxCRDR4V29SWHRXSFVyVGxZ?=
 =?utf-8?B?UXpoTFVrU25RMlNhSVl0eHdWcFE1NWZKdGlzVyt6bE50TGtqWGlKM3lCZ01k?=
 =?utf-8?B?N2dhRUJSV21WWWdtaS95V3JURVNZNURvcHNFYkdmM3k3TkNlMW5vb3kyUmMw?=
 =?utf-8?B?bFlSeWdxK1FWSjFRMFY3L1BEU1o2NFcxZVF5c1Vpc0pTbEdocnFPS1RmcnFS?=
 =?utf-8?B?NzJKaVV3NHlvYnBqV3Y2RSt3TGQybDN1Q3RhV2VOSGJYdnJQMmlSUUNyT2hL?=
 =?utf-8?B?bVZmZG0zeFViMUV3SmMrKzlzWCtySlFwSlU3ZDl4OGJZQUNMWVVhVlJkS01O?=
 =?utf-8?B?K3ZMWlFvSzhndU1ZNjIyRW9hMW9aWFhQRm53bytMNDV6NWZ4NnJvaHo5MUQx?=
 =?utf-8?B?MGJJdWZIdnhDY2ZHemhZcXA4TWRTVFhJTDNDdk5GMVQyUkxySCtaL1VLYlpY?=
 =?utf-8?B?akZqdVp5eHE4dkw4NVBLRDZMaE01Q2dEY3BMUFF0YnYxZTl5SkhlcDJGcXpU?=
 =?utf-8?B?VElQUDIyU1BjUXY0WFpicDR2eVRMMTlOVCtmK1BSVTNoeUlvMmg3S0I3d08v?=
 =?utf-8?Q?E2vH5PRFuY8sVQhRjZVILtKAU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0F76E25EB0E0E4181E6A13A95B14C96@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96a09bc-ecf0-41ce-fb80-08dab0ca947b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 05:35:34.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/+SLepmSxftep21NC3c5lMqsoIN7RuCM8Q81J4rTPL1m8ElQGgMuq9odZfyOBujf8CJsa8eRrg1RnW4eD99EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gTW9uLCAyMDIyLTEwLTEwIGF0IDE2OjUwICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBpZiBnY2Ugd29yayBjb250cm9sIGJ5IHNvZnR3YXJlLCB3ZSBu
ZWVkIHNldCBzb2Z0d2FyZSBlbmFibGUNCj4gZm9yIE1UODE4NiBTb2MNCj4gDQo+IHRoZXJlIGlz
IGEgaGFuZHNoYWtlIGZsb3cgYmV0d2VlbiBnY2UgYW5kIGRkciBoYXJkd2FyZSwNCj4gaWYgbm90
IHNldCBkZHIgZW5hYmxlIGZsYWcgb2YgZ2NlLCBkZHIgd2lsbCBmYWxsIGludG8gaWRsZQ0KPiBt
b2RlLCB0aGVuIGdjZSBpbnN0cnVjdGlvbnMgd2lsbCBub3QgcHJvY2VzcyBkb25lLg0KPiB3ZSBu
ZWVkIHNldCB0aGlzIGZsYWcgb2YgZ2NlIHRvIHRlbGwgZGRyIHdoZW4gZ2NlIGlzIGlkbGUgb3Ig
YnVzeQ0KPiBjb250cm9sbGVkIGJ5IHNvZnR3YXJlIGZsb3cuDQo+IA0KPiAweDQ4WzI6MF0gbWVh
bnMgY29udHJvbCBieSBzb2Z0d2FyZQ0KPiAweDQ4WzE4OjE2XSBtZWFucyBkZHIgZW5hYmxlDQo+
IDB4NDhbMjowXSBpcyBwcmUtY29uZGl0aW9uIG9mIDB4NDhbMTg6MTZdLg0KPiBpZiB3ZSB3YW50
IHNldCAweDQ4WzE4OjE2XSBkZHIgZW5hYmxlLCAweDQ4WzI6MF0gbXVzdCBiZSBzZXQgYXQgc2Ft
ZQ0KPiB0aW1lLg0KPiBhbmQgb25seSB0aGVzZSBiaXRzIGlzIHVzZWZ1bCwgb3RoZXIgYml0cyBp
cyB1c2VsZXNzIGJpdHMNCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+
DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVk
aWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMg
fCAxMiArKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRx
LW1haWxib3guYw0KPiBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gaW5k
ZXggYzNjYjI0ZjUxNjk5Li5kMjM2M2M2YjhiN2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRx
LW1haWxib3guYw0KPiBAQCAtMzksNiArMzksNyBAQA0KPiAgDQo+ICAjZGVmaW5lIEdDRV9HQ1RM
X1ZBTFVFCQkJMHg0OA0KPiAgI2RlZmluZSBHQ0VfQ1RSTF9CWV9TVwkJCQlHRU5NQVNLKDIsIDAp
DQo+ICsjZGVmaW5lIEdDRV9ERFJfRU4JCQkJR0VOTUFTSygxOCwgMTYpDQo+ICANCj4gICNkZWZp
bmUgQ01EUV9USFJfQUNUSVZFX1NMT1RfQ1lDTEVTCTB4MzIwMA0KPiAgI2RlZmluZSBDTURRX1RI
Ul9FTkFCTEVECQkweDENCj4gQEAgLTgxLDYgKzgyLDcgQEAgc3RydWN0IGNtZHEgew0KPiAgCWJv
b2wJCQlzdXNwZW5kZWQ7DQo+ICAJdTgJCQlzaGlmdF9wYTsNCj4gIAlib29sCQkJY29udHJvbF9i
eV9zdzsNCj4gKwlib29sCQkJc3dfZGRyX2VuOw0KPiAgCXUzMgkJCWdjZV9udW07DQo+ICB9Ow0K
PiAgDQo+IEBAIC04OCw2ICs5MCw3IEBAIHN0cnVjdCBnY2VfcGxhdCB7DQo+ICAJdTMyIHRocmVh
ZF9ucjsNCj4gIAl1OCBzaGlmdDsNCj4gIAlib29sIGNvbnRyb2xfYnlfc3c7DQo+ICsJYm9vbCBz
d19kZHJfZW47DQo+ICAJdTMyIGdjZV9udW07DQo+ICB9Ow0KPiAgDQo+IEBAIC0xMjcsMTAgKzEz
MCwxNiBAQCBzdGF0aWMgdm9pZCBjbWRxX3RocmVhZF9yZXN1bWUoc3RydWN0DQo+IGNtZHFfdGhy
ZWFkICp0aHJlYWQpDQo+ICBzdGF0aWMgdm9pZCBjbWRxX2luaXQoc3RydWN0IGNtZHEgKmNtZHEp
DQo+ICB7DQo+ICAJaW50IGk7DQo+ICsJdTMyIGdjdGxfcmVndmFsID0gMDsNCj4gIA0KPiAgCVdB
Uk5fT04oY2xrX2J1bGtfZW5hYmxlKGNtZHEtPmdjZV9udW0sIGNtZHEtPmNsb2NrcykpOw0KPiAg
CWlmIChjbWRxLT5jb250cm9sX2J5X3N3KQ0KPiAtCQl3cml0ZWwoR0NFX0NUUkxfQllfU1csIGNt
ZHEtPmJhc2UgKyBHQ0VfR0NUTF9WQUxVRSk7DQo+ICsJCWdjdGxfcmVndmFsID0gR0NFX0NUUkxf
QllfU1c7DQo+ICsJaWYgKGNtZHEtPnN3X2Rkcl9lbikNCj4gKwkJZ2N0bF9yZWd2YWwgfD0gR0NF
X0REUl9FTjsNCj4gKw0KPiArCWlmIChnY3RsX3JlZ3ZhbCkNCj4gKwkJd3JpdGVsKGdjdGxfcmVn
dmFsLCBjbWRxLT5iYXNlICsgR0NFX0dDVExfVkFMVUUpOw0KPiAgDQo+ICAJd3JpdGVsKENNRFFf
VEhSX0FDVElWRV9TTE9UX0NZQ0xFUywgY21kcS0+YmFzZSArDQo+IENNRFFfVEhSX1NMT1RfQ1lD
TEVTKTsNCj4gIAlmb3IgKGkgPSAwOyBpIDw9IENNRFFfTUFYX0VWRU5UOyBpKyspDQo+IEBAIC01
NDUsNiArNTU0LDcgQEAgc3RhdGljIGludCBjbWRxX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UNCj4gKnBkZXYpDQo+ICAJY21kcS0+dGhyZWFkX25yID0gcGxhdF9kYXRhLT50aHJlYWRfbnI7
DQo+ICAJY21kcS0+c2hpZnRfcGEgPSBwbGF0X2RhdGEtPnNoaWZ0Ow0KPiAgCWNtZHEtPmNvbnRy
b2xfYnlfc3cgPSBwbGF0X2RhdGEtPmNvbnRyb2xfYnlfc3c7DQo+ICsJY21kcS0+c3dfZGRyX2Vu
ID0gcGxhdF9kYXRhLT5zd19kZHJfZW47DQo+ICAJY21kcS0+Z2NlX251bSA9IHBsYXRfZGF0YS0+
Z2NlX251bTsNCj4gIAljbWRxLT5pcnFfbWFzayA9IEdFTk1BU0soY21kcS0+dGhyZWFkX25yIC0g
MSwgMCk7DQo+ICAJZXJyID0gZGV2bV9yZXF1ZXN0X2lycShkZXYsIGNtZHEtPmlycSwgY21kcV9p
cnFfaGFuZGxlciwNCj4gSVJRRl9TSEFSRUQsDQo=
