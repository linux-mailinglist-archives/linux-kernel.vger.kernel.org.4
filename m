Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519925F2815
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 07:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJCFFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 01:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJCFFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 01:05:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5E12A9C
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 22:04:54 -0700 (PDT)
X-UUID: 6e7388b72ccc4fae93a663e6f6b81653-20221003
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QK8ZFwpYAYALXAj8YzmNk/jrJLrPpTtPfYBgKmfB0pM=;
        b=oRwP18PL5DPR29n6XMlKe+XzQ9zLm1eSoM3EBHrQCWjSIYRMo3xxtjFBbmaBFFVoxvkPFqL1MRo6Q7h5kIUIhJ9TVGJJna/UgVvgR2V/S3lRagJw1sHOj4Cb2NihVAX53CasHJyjmHM0AraKV5Mdua7yL8nUYUD59NOxNu7H8Ag=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:8fc65edb-47ac-4a9f-9cda-c52c1d869c80,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.11,REQID:8fc65edb-47ac-4a9f-9cda-c52c1d869c80,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:b650d2a3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:221003120041V1HGKMWL,BulkQuantity:68,Recheck:0,SF:38|17|19|823|824|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,CO
        L:0
X-UUID: 6e7388b72ccc4fae93a663e6f6b81653-20221003
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1627161937; Mon, 03 Oct 2022 13:04:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 3 Oct 2022 13:04:49 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 3 Oct 2022 13:04:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P33sZjLuJlz+F51vHZfiqeTl6YLQNU7ivZjqGO854ak+mxfnoD0NGj6cvf5QSnYVslBaA4g5dhODr2ms8V3p3xwAFliz8cD1Cn1sGt57Q+uiqS6JWAYQa9zKP8OOmY/aBJIhm0jXF5H+yT9R1FMRZCyvwsU+I1h9wEfUbYVbOekNb5US78pJDb15VQd0MyAi9bvf+JjBfc8Gi/sn+Pm+29uK1eM/TWo5wkHNOimyfzuXkCN7ZGVwH2QldFNVD0u1cFzJgXWW4h/miQ8QTPHUqNHHaLyHmlUDLkK+qxWJ3KLDGUYCrSD54K7y4j3WMRi2bav08L7YyLq73FcuGkl15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK8ZFwpYAYALXAj8YzmNk/jrJLrPpTtPfYBgKmfB0pM=;
 b=e3NFyI4HWPo9qioMM6JsxlRFZsGkfvffvT5jLuZ6OHsjIdSWevdM04cVfmeuh7OBdcmhSRnbkjRfA1aiCXZAv+GtlbpcAvd0tleCZwZXab2vJiVBYtR5igHGNoFiiBsYOz3d41Ak8O1nSnW8k07WSjY4OY1i1UpCACI9P+9m4selHNETYjt7WuHTtuXqve+g6PmicSpNLxBgakdAqWK/Hl6ncWBV9Q4Z3FADtpcZyN0EqjMfimTE7vYqBJCCeziSNEhoS76ridZFQIj6z6Vsc860xzVi81DhbCO6aiXwmmRJI+9jTwDuH3blBbYKgacQnFdq6tKCqGLZTHIV71NBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK8ZFwpYAYALXAj8YzmNk/jrJLrPpTtPfYBgKmfB0pM=;
 b=jdy8+WUDkvTSoAXRKKD9ulRcFMNKJh0X6m1Hh3vQEpw8VZLP2cZBsG6rgypohXQynfJiD5o2YLe5RNXZS+k6ZNO+nxgBHbAa24oXqcjgT+L2jDjqtRzf8NJUOx1DN2m1Q3pC5Hwn86u/TzKnr+n8Gqmt37keDuhnfWHLiMwPbo4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB5643.apcprd03.prod.outlook.com (2603:1096:4:12f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.8; Mon, 3 Oct
 2022 05:04:39 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b958:c9e0:9f6d:9ed%8]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 05:04:39 +0000
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
Subject: Re: [PATCH v8, 3/4] mailbox: mtk-cmdq: add gce ddr enable support
 flow
Thread-Topic: [PATCH v8, 3/4] mailbox: mtk-cmdq: add gce ddr enable support
 flow
Thread-Index: AQHY1ObAMBSi0RZtGEKRxwiQ9QMPRa38IXgA
Date:   Mon, 3 Oct 2022 05:04:39 +0000
Message-ID: <31b60ef83260b7f3d0761462c127d3fb34d4f8ac.camel@mediatek.com>
References: <20220930160638.7588-1-yongqiang.niu@mediatek.com>
         <20220930160638.7588-4-yongqiang.niu@mediatek.com>
In-Reply-To: <20220930160638.7588-4-yongqiang.niu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB5643:EE_
x-ms-office365-filtering-correlation-id: 6962d1f7-7d31-41d3-6e7f-08daa4fcc6a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bYro/BWl6i5kfq9/h4H1yZBywx64NHHpuI1Ko9BR2jx85OHlGd23I5WNwdsATrZo30tU3HRxm+1puUHrWOy3otlPlYLKh0blmHCcPjAjMBVSrqrAPk8gt2vT4vFnFXF1AGceyJITVayFW+NkJehcuoQRYsxwvgb+EwEX5sMklQ5O88aMosSazTghrzVtlvHb35LapGB1DgITeQ99rMTDGPCdD17G+2Hcf4sspn+B//sp95Jlt1CeQc4KX8tDTxlsKy1BAzM9Lis6Tf2G20scEXpIFuPbVtsCtuiqVGVOA2LTTzOROrUxI7nyDyMY0HGHWH5kkKc4qWC4sM1DcBfhMYYmlHGmo8C2kXUZvxvnExchbu2oOHnKf1OBgjfJrU30QBQD773mV4ZsEk+Sz98ZVgOqPP6eFj/CrseIElmlT9zhUfEQqzgPrOV15KlWCwaupdzs0lKJ2o1a3qMuw6/etHhToG7cFd8SisDf9xpIa+tT7KyAxAeNrX8GujnxIXZmoJD54CeAyoVjr6YVj1Oj1/es77Flq58Vo8HdKgzo7twYoaMH4Qmz0ZMh/opq/3PMDb+NR682NuTYRZkxCtPJxR+Wd7aT8uxLhtKUiAjboZJ+yZ+ypOEV8Ml8il8yN9xNl/hQbRp9lgwF5CbCIfRLTAQWymn+ea3oLjwG68dZAsG5sQCzWvuTjbXIoS3KtDBUbjAROoGR9ge49exv+yJqZfYXmCAXjEOdevZ9MTlCHhqdTJHih2OhzPJOd6aOGk4h3xSXqzZDF41fr9xYrCsqAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199015)(54906003)(110136005)(478600001)(6486002)(71200400001)(8936002)(41300700001)(85182001)(36756003)(66446008)(64756008)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(76116006)(91956017)(5660300002)(38070700005)(122000001)(38100700002)(2616005)(86362001)(6506007)(26005)(6512007)(83380400001)(186003)(2906002)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1MrcUk3K0UvbjRFaG5lNllyOXRvcUMwdHp4VGl4Umg0TEx0Uk1KNEEwNDhy?=
 =?utf-8?B?aVRETER0Y3lPVDB5ZStTSllscmRTWEtlMnJXaWVTcGRpWXN1aW1zUGtJZys3?=
 =?utf-8?B?T2xVWW45ajdLZ3dFNkh3S0lBWHAwZ1loVWdab3FPQTRBcXYrUjBjS2MvV2cw?=
 =?utf-8?B?VEJTZVR6M3d2dXJyYkdqK2RRRFc1cTh3S0xoeFVvZ3dDOExBMk11K3Z1ZTM5?=
 =?utf-8?B?QU5UNWx2MlMrMWNOTXF3aXdSa05IRm9PTEhlQi9Td0VPRU05Q3c2NUx2N1pj?=
 =?utf-8?B?eXlVS210ZmxtU3M2Yy9jVVR6SXkyM0M2ZXV0TkgzWGwzSVpHZ1lHbHhvc1cy?=
 =?utf-8?B?dFJsNjczd2NnM09Ea0V5REFPN2FvS3lRK29SeTFDeXUyaTJGOUdqRFBhd053?=
 =?utf-8?B?eEJrc2R6YTZIdkE3aDRITzRma1p4a2ZHbkRoUnhTaThLbEZaS2VxcWducUsx?=
 =?utf-8?B?d242SjQ3UDJrSmptQVNoU09Ob0xMUlFyN1RvYzduQVZwZU5qbjlRbGFDcnRi?=
 =?utf-8?B?cTJZOWRpQ2pzK3YyemVUdCt6NGlmT29TYzhUY1IyRFU1RndIQVNrbnZBdDgw?=
 =?utf-8?B?YUc1S1dYYU1KaFh0b1B5ZjVhY1ErSTZmVWsrMU9NWXhrV1k3YXhibktHeUo5?=
 =?utf-8?B?aDlaR0pNbmtBSU12b0c3b1M4VVdzQ3lIZWZzQ0svVlVlM2hxcndNTFQ0azRU?=
 =?utf-8?B?UEJqd0pFUGRsdk5pbDlPVWZTemdNYnFXTGFkb3FtWWFqU0xUaGdHTjZaOWZC?=
 =?utf-8?B?a2NjdnVwWGxIVVVMVlA5cGNFNHE4ZTlhWjFaMlg2L0ZnT1p6Y0xjdVdDRUNp?=
 =?utf-8?B?cnNVcHVYbUpFL1FOUWpyVXcvSXQzZ3pMcWFmdy9RVlFTZ2ZHbGI0Q0tJcmFB?=
 =?utf-8?B?NS9QeWNsQ2htZkt0dkhRZXVtdURQOWgxVEJTWjF3elhHY0IxNW1HVjVhZHNw?=
 =?utf-8?B?V1VwRkVLRnNtRUlRaXJhUVlSSWZ4bjE5TmdheDlJR3Q1ZTRJN1NyT2E0WDJE?=
 =?utf-8?B?djFoUzk0dyt3R0RMeitHcHlvVVhkQStzd1YwelNiNytFTDZMT25zZXpNVjYr?=
 =?utf-8?B?ck1mMmRTeHdGWTdpME5mQjBybFlNT0NLTlBKR2VtWVlNcEhuNTF3SllPak96?=
 =?utf-8?B?cGhveGdFSUp3L3pKK3NYOHljYTNMZmQxYm11VkdwMjQva05kWG9HR09XNU5L?=
 =?utf-8?B?ZFRxcThrQmxWeWxGTm1BazZvNnRUMFk5dlpZdEw0WGtCYlg5bEZVZjZXRHFi?=
 =?utf-8?B?V3pKRlI4d1dPbmoxM2wwaVZuTkVya2IwM1BEY0c1cE04cW1zemEyTXQvRitI?=
 =?utf-8?B?T20xazJiZVlCWkx0c3JZSm9KUUhHbXVzVzkrZG4wTDBoNDluK0doa3V5RlpR?=
 =?utf-8?B?bkt4WEVrV3NoK2NMUDBkUmdnTHVJb2lCSkZ3a1c2YVYyVGhndk9HUnhKWjNk?=
 =?utf-8?B?R0RNTHFEa2NLL2I0SGdXVTF0VVlkY1NPTHlRMWcwR2p0V2dYUnh3RU14TXQ2?=
 =?utf-8?B?eVkvdzNOcndlQTZOQXVDMWVxMnROZGtlcDBxVnFWOEFWQmQ2bnh2ZjFibG1j?=
 =?utf-8?B?SHlwcm5PSWtGSGdZZEp3cVRqemdwcUtIUk51ay9aeGo5TW9xSFJuQjlTUGV4?=
 =?utf-8?B?OE1sdTBsUWVwcTBEWmNkMUxMTFlDdjNvNlo1RXV4eHUwYXlkRmQ0M0FGNTNN?=
 =?utf-8?B?cHVUS1VIWkY1SDJLTVFrVXV3bXpVM21yMDhCQ2FTTmhjbG10OFY5ODlXVWF1?=
 =?utf-8?B?Wm5XTllrRUdQU3RPVldaZEdCL3c4V3NyZWw3d3ZrOEJ5ODd5RkFDKzFWRSt3?=
 =?utf-8?B?Q0p5SXhsSjBaUEFybFNoeStmNTdXRU9ycGZzeG1YOTBkMHlKQ2tqQmRKcUx3?=
 =?utf-8?B?VVUxQlplY1c4dWMyTjJxQzhBVEZMOVVxWUpFWUN6T1l0NS90d0s1RDZSVXBO?=
 =?utf-8?B?eTVwZ2hNU1NOeU52dUd5aVRaOFdVQkRGV0d6QVpCWUlkMXVscXZhWEx3S3Rq?=
 =?utf-8?B?cElrN1pxajZpcXlqVDJDVUZGODdEbzREclZKZzc4Z2M0VnVNMXhFalJqR1Fa?=
 =?utf-8?B?cnhscktXL1JPekk0OVlpR0p5Ky9MdDNPb2lUK1hBRDlsdkpzWkdVQ255VVFj?=
 =?utf-8?Q?axwoX22juZgvtmK6+ee55tdhg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E1C72CBC5525D41814337DC5D14E474@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6962d1f7-7d31-41d3-6e7f-08daa4fcc6a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 05:04:39.7518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7czetzVOwXHFksi/Im7JMznzi6m6U+bwBIxWaIyFXiODxwXStleW48BgWnI1vRvJceHslQGHEMyVedbLfNNPlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5643
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gU2F0LCAyMDIyLTEwLTAxIGF0IDAwOjA2ICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBhZGQgZ2NlIGRkciBlbmFibGUgY29udHJvbCBmbG93IHdoZW4g
Z2NlIHN1c3BlbmQvcmVzdW1lDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5
b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5jIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guYw0KPiBpbmRleCAwNGViNDRkODkxMTkuLjJkYjgyZmY4MzhlZCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiArKysgYi9kcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IEBAIC05NCw2ICs5NCwxOCBAQCBzdHJ1Y3QgZ2NlX3Bs
YXQgew0KPiAgCXUzMiBnY2VfbnVtOw0KPiAgfTsNCj4gIA0KPiArc3RhdGljIHZvaWQgY21kcV9z
d19kZHJfZW5hYmxlKHN0cnVjdCBjbWRxICpjbWRxLCBib29sIGVuYWJsZSkNCj4gK3sNCj4gKwlX
QVJOX09OKGNsa19idWxrX2VuYWJsZShjbWRxLT5nY2VfbnVtLCBjbWRxLT5jbG9ja3MpKTsNCj4g
Kw0KPiArCWlmIChlbmFibGUpDQo+ICsJCXdyaXRlbChHQ0VfRERSX0VOIHwgR0NFX0NUUkxfQllf
U1csIGNtZHEtPmJhc2UgKw0KPiBHQ0VfR0NUTF9WQUxVRSk7DQo+ICsJZWxzZQ0KPiArCQl3cml0
ZWwoR0NFX0NUUkxfQllfU1csIGNtZHEtPmJhc2UgKyBHQ0VfR0NUTF9WQUxVRSk7DQo+ICsNCj4g
KwljbGtfYnVsa19kaXNhYmxlKGNtZHEtPmdjZV9udW0sIGNtZHEtPmNsb2Nrcyk7DQo+ICt9DQo+
ICsNCj4gIHU4IGNtZHFfZ2V0X3NoaWZ0X3BhKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pDQo+ICB7
DQo+ICAJc3RydWN0IGNtZHEgKmNtZHEgPSBjb250YWluZXJfb2YoY2hhbi0+bWJveCwgc3RydWN0
IGNtZHEsDQo+IG1ib3gpOw0KPiBAQCAtMzE5LDYgKzMzMSw5IEBAIHN0YXRpYyBpbnQgY21kcV9z
dXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlpZiAodGFza19ydW5uaW5nKQ0KPiAgCQlk
ZXZfd2FybihkZXYsICJleGlzdCBydW5uaW5nIHRhc2socykgaW4gc3VzcGVuZFxuIik7DQo+ICAN
Cj4gKwlpZiAoY21kcS0+c3dfZGRyX2VuKQ0KPiArCQljbWRxX3N3X2Rkcl9lbmFibGUoY21kcSwg
ZmFsc2UpOw0KDQpXaHkgZG8geW91IGRpc2FibGUgc3cgZGRyIGZ1bmN0aW9uIHdoZW4gc3VzcGVu
ZD8gV291bGQgdGhlIHByb2JsZW0NCmhhcHBlbiB3aGVuIHlvdSBkaXNhYmxlIHN3IGRkciBmdW5j
dGlvbi4gDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsNCj4gIAljbGtfYnVsa191bnByZXBhcmUoY21k
cS0+Z2NlX251bSwgY21kcS0+Y2xvY2tzKTsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiBAQCAtMzMw
LDYgKzM0NSwxMCBAQCBzdGF0aWMgaW50IGNtZHFfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gIA0KPiAgCVdBUk5fT04oY2xrX2J1bGtfcHJlcGFyZShjbWRxLT5nY2VfbnVtLCBjbWRxLT5j
bG9ja3MpKTsNCj4gIAljbWRxLT5zdXNwZW5kZWQgPSBmYWxzZTsNCj4gKw0KPiArCWlmIChjbWRx
LT5zd19kZHJfZW4pDQo+ICsJCWNtZHFfc3dfZGRyX2VuYWJsZShjbWRxLCB0cnVlKTsNCj4gKw0K
PiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IEBAIC0zMzcsNiArMzU2LDkgQEAgc3RhdGljIGlu
dCBjbWRxX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgew0KPiAg
CXN0cnVjdCBjbWRxICpjbWRxID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICANCj4g
KwlpZiAoY21kcS0+c3dfZGRyX2VuKQ0KPiArCQljbWRxX3N3X2Rkcl9lbmFibGUoY21kcSwgZmFs
c2UpOw0KPiArDQo+ICAJY2xrX2J1bGtfdW5wcmVwYXJlKGNtZHEtPmdjZV9udW0sIGNtZHEtPmNs
b2Nrcyk7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo=
