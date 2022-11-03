Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA11617439
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKCCcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiKCCcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:32:18 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0609.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B1FCCA;
        Wed,  2 Nov 2022 19:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyYLvQ2I43Kdc73YHuUUOXZ/VgtPFNtR3QhkwnTmRGUjI+i2g1vPNyHfZnd2W3POgSe9XwTpRQEnXINKfwR1014icqwkk3bvf1bl3gyruJp6iNMB4qWHGIeh3dJ9VSqzwqGt2W9hm9jgKqFTjZG3v7DLYCuavrXNDl1k0mEIVCfvyVTqcjTIAx4VXG/2CBMAhyMfvOgtSNE3E2eG8wijxAcEBauWQQRqs9OVxBXLatvZFWaNj6qczoXTvmjy6QeE80KuSEdiSeQ8JnKpIQnWabmcBQphNa9X5yobslS1rR084sAHxHDXbrGs08TFO6DD+qV2XRPPPXdQ2ud1CZZB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q35vcmdiewU4Uu8msBRwzxfpRU0pggDCY5y3AifmX0w=;
 b=KbWUxL4h9FDI+ZkUfeI4shXx/NX8RThYDsjCApHERepwRqA3fNLV8eOpUiiy8pFQcNoHHgg05yYAt1LJwkl0snv0IBjm3n+0NoyH9HPO5jGXu0MWQ0/Eni+Av8QKSmYx6BUP4sx1eao+RUC+ovxvNlx0yOcr4Th6lgOWlJC6axrLV826E7iRcIhBtHFHp4tB8MaooAYU3gjgjoTsn09fi2CRxE7WI7kDosCPAQPXrwQTcou1bxLvr+k/QmlvwcGpy5QrsCX/sR9RxKLENdIOrRc5UNOkn4Wp/qlFFLzm3N3RB0N3sVsN6dFpzoFGkFssYXSqWaDFHLsJ7EZAkjYiCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q35vcmdiewU4Uu8msBRwzxfpRU0pggDCY5y3AifmX0w=;
 b=RXNjvsj1SSiWONJMz9r1kHVgbXMx//WSUegiSdp1JJXHJz4nliS13jR/gSyP3WeOgH5NVBH5sKidVZMY8fuWgH7c3irEHMHzoYQbt5zeECLz2jwJTlOW1TKbXS070vFCyBnKynqNvrF4hK0DY8BMbWZhnihRxiG7fobj7zq7DQ0=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM9PR04MB8537.eurprd04.prod.outlook.com (2603:10a6:20b:434::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 3 Nov
 2022 02:32:12 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::3cee:dfa4:ad62:235a]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::3cee:dfa4:ad62:235a%7]) with mapi id 15.20.5769.021; Thu, 3 Nov 2022
 02:32:12 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: RE: mmc: host: sdhci-esdhc-imx: async sdio interrupt and hardware
 auto-tuning
Thread-Topic: mmc: host: sdhci-esdhc-imx: async sdio interrupt and hardware
 auto-tuning
Thread-Index: AQHY7vvBPuBMSDYwj02mBK2khue+664seXyQ
Date:   Thu, 3 Nov 2022 02:32:12 +0000
Message-ID: <DB7PR04MB4010097DE59A7BA1340A408290389@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <a0bc23f0d7c4996b208c46508f9981a5804ab94d.camel@toradex.com>
In-Reply-To: <a0bc23f0d7c4996b208c46508f9981a5804ab94d.camel@toradex.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AM9PR04MB8537:EE_
x-ms-office365-filtering-correlation-id: 8615a506-2531-471b-b682-08dabd439d51
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 84IdiDXoiIwv4BR8OcAkbWt05truiyfnr8Ymu8uzXczIZpO87xTCTvj3YNd2Wogkbg684Nlgc9b1gaRmXZFOiPKBm0nDuBzCGg4aWZtjz2kCovT8XjpLRWSBJUZ0j4rNInZ9bVQusWvueEJDE/2TUMB1acJ0HfkUrhpllvq5BvgUF22F7pSUpr1PM3epZ3h1qVnrd3t8YQnws9KnrMx8gxHSwaElz7lNbQzuEg89r/v+DFJymglaMsX6O+1lHTPD44HkDJ4dyOeE9/YjbJVJCssYl6GHDnAmAk66HmyRWP94yikpReLOX4VIGzf+AzJKpifnZd136Lk34NjyU1DcXBAC2JAIcxVJ+dNwzm000pJJZW6OpDUnffT7KgaIZl8Rdg0BHuSGOCzRNaQDQQ2eckgK255smxlN9wzzxzKgyUz28K5AKzoMHnQxdBomhWbHZ4NwlHjTbK6PGwI67AuBAr1n+o2BJORXgg98E8TD6jVw+mvvGx/IjDsgM64RszTjWba47fCeia94DF5yTmBjpZko3Rqt6D0oCnhhJky3xm4qbMdsIBs5jr2x+j99ahsDVoTkcW/3HtVL8cJAp6dS3lm6yZMklj/o6J7WVc0G0Ex69Q7FgI4uTNug+IUeNwrNqxqUl8nBEWOaoECs/HkycZnxJP2/maUwxkgNZZalbX1sm83YsqRVNfq9TeLXg0R3nHTdDtd41XETaySOxOnNusHnl34rALhwDqHoNrTdgpQqbQpWj0Y6AUeLNC/CAwgbrPXzeZjzdtv4e737AnWC9Z104K2XP5dkBj+4Veib9T4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199015)(52536014)(5660300002)(54906003)(7416002)(66946007)(38100700002)(45080400002)(8936002)(71200400001)(55016003)(76116006)(41300700001)(110136005)(66476007)(966005)(66446008)(316002)(8676002)(64756008)(33656002)(478600001)(66556008)(2906002)(4326008)(83380400001)(9686003)(122000001)(86362001)(26005)(6506007)(38070700005)(53546011)(186003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?d09XVGtoS1cyZjNBQ3phaE1XQnhYUjlhRmYyRHZqd1ZRLzI3Smx0L29RMVc0?=
 =?gb2312?B?SHc0QmVUZU5tOUJlR3hCRHEzay9FWitVdENPSXRpU2ZwZ3pnaGNPVjZVaEJ5?=
 =?gb2312?B?TlUvNHRtb0c1NUx6TVFibVpkR3pDWmpldkJ5VEdyYXZMbFJDcDNFa3JraHI3?=
 =?gb2312?B?U2NzSGRPdEJyZ21CRzg2bjF4emRmUVpYbTdNSkZNWUF4SjR2MTgzTXRtcHNr?=
 =?gb2312?B?Z0owZUpVU0doQW1lNFhNc0hWeWMwWlZGdEtZSGdNUnJDdGordGY3M2piWnVz?=
 =?gb2312?B?bGQwZ3dvTkNwdTFoaGRoZVBUMS9vNkJLSzRBWUdPNjBoSGMrREJCWGNlWXhx?=
 =?gb2312?B?dW1DY0VaUyt0Z015Tk41dFA0em5hOTFsRENkMlh3VjFTTkNOalQvZ1VTUHBw?=
 =?gb2312?B?RkFzNlpVZGZVT2dpVlJiRDV3bEgwdHUwQjhCWWJDVjluQzRjdks1UllzcHpa?=
 =?gb2312?B?WHVXZmZURTBnWHEvbzdPVzZwMEtVL3ZHcVVNdDVieHpmSTlVOE5McEw5RCtz?=
 =?gb2312?B?ZSsrUlRFa2hqZEV3Tk50d3IzSmd4cXlKdXhlYkVxRDNtL2l3d3pnbVl5Zm9X?=
 =?gb2312?B?RUp4TjluRkdVa2VJeXBkRVJoQmhuMkh3L3NUTVA5bHVsUnl1eFpGWHYyVmxW?=
 =?gb2312?B?VjJwZXZKVkNKWkJYcldrZEw4NGdoSlR3NjR4TW84ZTl2ZXhYYkJiZ2I0TzAz?=
 =?gb2312?B?MXBhRTR1RllIcm94VlFLc1NJQTRWU1daMnl5cG4zZVdBcUNmRzhSVHJwWEk3?=
 =?gb2312?B?TytycW1oRVFZK0M0R2czWXlKcHpldmJjbTFzcUdpTEVvWU81bWYzM0g0Q1NL?=
 =?gb2312?B?MmFIN3ZVOWRVcWg0azhLQ0hObEovcm1aWlZ5WWxCaWxCUzllUTk1cDVaT0cw?=
 =?gb2312?B?UHNVLzdjNE1oUm54VitkakxYaFF2VUxXbHUwVElGeUNZZStHSFdJUkF0V0Zv?=
 =?gb2312?B?MFErZ0hzZ2MzLzZudHpIUi9aSWdnS2h1SGNmSGdkVlYwenVHaWRuaE9tZzRQ?=
 =?gb2312?B?VmhXRjhFcTRqK1ozb095c0lSWjEvWko4dnBSM2JXbm1DNG9jOEpBYkYwakxp?=
 =?gb2312?B?Q3FkWW5DRC96RFJtTmRWbThUamxsY0VDcnNjMTl4MWpTV2Y0bnJtR1h3QXJ2?=
 =?gb2312?B?UnV5V2V2b3BGMTQ3a2d5bGo5S3R5ZXQ5bEtKU2xuWlRESzRKQ1piMUlTSlkv?=
 =?gb2312?B?aEFmQktHVkNDLzIxZGxNU3U1MWFhd0I5akh0VllZK1M0cHBKS2FsMVM0TkZN?=
 =?gb2312?B?QnNzMCtvcFNuV2VhU2lQcStodU9NS2xJbURDdDlUc292VnZqa08ralJFWFlJ?=
 =?gb2312?B?OWlaRHZJYWtPeGgrdUZVMk1Gc1h6M0loY2xEdjJuTFRnUEtiNk5GUnB6WHBL?=
 =?gb2312?B?bDYrTG9CZW1iV3RKa0xtMnZORGZGVzVwN3VJSFB2M1c0K1VGTkkwbWpZVFJZ?=
 =?gb2312?B?NWppNkZ1U3F6Wm05MHdKUWRjek9DdzB1VmZ0SnMrNGgvTGtMRytJdDUwOWxZ?=
 =?gb2312?B?WjJyeGY3N25KT1MxS1ZRd2d6YzVUMWY4bXhWRVU1WTlJOWpyVjhWMnREclFT?=
 =?gb2312?B?TzJiTnh1NW9pWVBvVGdtNmdhZmRjNldSVjNYdUJpWnRaS1BsOExxU2Q3L2VW?=
 =?gb2312?B?NTlwQTluQ094dS82a0dGNXYzUmJ3aHphMmdqRG43SW81YmdwNHdQWUVCTzlM?=
 =?gb2312?B?Z2JmZE9NdGMzL3EzZTNCeHM5eVQzbkNpY2xoWTZwVElMTVc4ZFgxRlFnOVZq?=
 =?gb2312?B?Wm1wSm9Nck1ydk53RHRKbWdkKzNuanVZdndwb1JKNU9vakZjQUxiY1M0dUxh?=
 =?gb2312?B?NjliY1NydE5zSlNNUStLeGh1UGhDTUN1TFJBQ0ZWVEE0Mis5ZzJWc2RSNUxn?=
 =?gb2312?B?dWI4MkJBMkREWmp1NXEvTjRkSGVvNDQvb1BrTGFJTEhHN1l4cnlKZlBFSUNX?=
 =?gb2312?B?S0ZFb0MyVWovWHNIOXVlbWN1TG14ZkRHSDlLalFpMDlSeFhhWmZ1Nm5ieUEx?=
 =?gb2312?B?b1JYVTJXZFNoeFZKY1hOTEJ3Z3EyZ3BmWStnbnR5Q0YzcE0vQzlYaUZhbmNI?=
 =?gb2312?B?MlY2eXc0bnJlSDZDcng3Sy9kZzdXak41ZTMxbm55cS9GUGNZVmlHUXJxWnJt?=
 =?gb2312?Q?MrJOJpB8MpyTPrbgr/Nxa+pJp?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8615a506-2531-471b-b682-08dabd439d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 02:32:12.6026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1QXWy83zSizcwlayu65Vhd8gFkDrNRKldhWp8lmkVEdHYm37XN0kKwhF4XXCXnfmPZjebMjhlBfDXd+z/WYPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8537
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1h
cmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gU2VudDogMjAyMsTqMTHUwjPI1SA0OjQzDQo+
IFRvOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LW1tY0B2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU7IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47DQo+
IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGFkcmlhbi5odW50
ZXJAaW50ZWwuY29tOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb20NCj4gU3ViamVjdDogbW1jOiBob3N0
OiBzZGhjaS1lc2RoYy1pbXg6IGFzeW5jIHNkaW8gaW50ZXJydXB0IGFuZCBoYXJkd2FyZQ0KPiBh
dXRvLXR1bmluZw0KPiANCj4gSGkgdGhlcmUNCj4gDQo+IFdoZW4gd2UgaW52ZXN0aWdhdGVkIGFu
IFNESU8gV2ktRmkgc3RhYmlsaXR5IGlzc3VlIEkgZGlzY292ZXJlZCB0aGUgZm9sbG93aW5nDQo+
IGRvd25zdHJlYW0tb25seSBjb21taXQgaW4gTlhQJ3MgbGF0ZXN0IGRvd25zdHJlYW0gQlNQDQo+
IDUuMTUuNTJfMi4xLjAgWzFdLiBUaGUgYXN5bmNocm9ub3VzIFNESU8gaW50ZXJydXB0IHNlZW1z
IHRvIGFkdmVyc2x5IGFmZmVjdCB0aGUNCj4gaGFyZHdhcmUgYXV0by10dW5pbmcuIEFzIGEgd29y
a2Fyb3VuZCB3aGF0IGdvdCBpbXBsZW1lbnRlZCBpcyBhbiBmc2wtY3VzdG9tDQo+IGRldmljZSB0
cmVlIHByb3BlcnR5IHRoYXQgbGltaXRzIHRoZSBhdXRvLXR1bmluZyB0bw0KPiAxIGJpdCBvbmx5
IChlLmcuIG9uIERBVFswXSkgd2hpbGUgdGhlIFNESU8gaW50ZXJydXB0IHN0YXlzIG9uIERBVFsx
XS4NCj4gDQo+IERvZXMgYW55Ym9keSBrbm93IGFueSBmdXJ0aGVyIGRldGFpbHMgYWJvdXQgdGhp
cz8NCj4gDQo+IFdvdWxkIHRoaXMgYmUgYSByZWFzb25hYmxlIHRoaW5nIHRvIGFsc28gaW1wbGVt
ZW50IHVwc3RyZWFtPw0KDQpIaSBNYXJjZWwsDQoNCkkgc2VuZCB0aGVzZSBwYXRjaGVzIHRvIGNv
bW11bml0eSBmZXcgbW9udGggYWdvLCBnZXQgc29tZSBjb21tZW50cyByZWxhdGVkIHRvIGR0cyBw
YXJ0LiANCkkgd2lsbCBjb250aW51ZSB0byBkbyB0aGUgdXBzdHJlYW0gd29yayBmb3IgdGhlc2Ug
cGF0Y2hlcy4NCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5
LCBzbyBmYXIgd2UgaGF2ZSBub3QgcmVhbGx5IGRvbmUgYW55IGV4dGVuc2l2ZSBTRElPIHZhbGlk
YXRpb24NCj4gdXNpbmcgdXBzdHJlYW0gYnV0IEkgcGxhbiB0byBzZXQgc29tZXRoaW5nIGxpa2Ug
dGhhdCB1cCBzbyB3ZSBtYXkgc2VlIHdoZXRoZXINCj4gb3Igbm90IHdlIGFyZSBhbHNvIGhpdHRp
bmcgc3VjaCBpc3N1ZS4NCj4gDQo+IFRoYW5rcyENCj4gDQo+IFsxXQ0KPiBodHRwczovL2V1cjAx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXRo
dWIuY28NCj4gbSUyRm54cC1pbXglMkZsaW51eC1pbXglMkZjb21taXQlMkY4NGM1MjlhMTQ3NGE5
ZjY2MTRlNDc1ZTE3OGNhNWZlDQo+IDIzYjYxNzdkZSZhbXA7ZGF0YT0wNSU3QzAxJTdDaGFpYm8u
Y2hlbiU0MG54cC5jb20lN0M1Yjc1MTIxYzA1YQ0KPiBkNDhjMzYyZDcwOGRhYmQxMmU1MDclN0M2
ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwDQo+ICU3QzYzODAzMDE4NjA5
MzY4NDU0NSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3DQo+IE1EQWlM
Q0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3
QyU3DQo+IEMmYW1wO3NkYXRhPVBYMTdVaUdrUUhmTXhIZDlTZjJqRWJJc1pnV081TUNwNXBGJTJC
SURYUUluNCUzRCZhDQo+IG1wO3Jlc2VydmVkPTANCj4gDQo+IENoZWVycw0KPiANCj4gTWFyY2Vs
DQo=
