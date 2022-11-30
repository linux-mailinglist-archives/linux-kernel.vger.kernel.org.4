Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ECF63CFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiK3HoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiK3HoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:44:10 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC425E9EA;
        Tue, 29 Nov 2022 23:44:06 -0800 (PST)
X-UUID: b4d986c3c29046979c0d85c8c73e3058-20221130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ik8gzUapHS+NqVxgAj1KtN9ww3d8pFG/C0wchbnAVLA=;
        b=Gbej4VYswEzN56sSp9S2lVDNeFcTyj33zTxzYPttt+3TuwhgfKa+SjW4X5QLq875IJ9qhj88f1/VcOs+vEfVJvo86BsTsYGi29m9V/xl2yM8EPR5f3PMkgbMDynuvQOdkD74GmA5kQt9wgC7c4EavQTWwRdsvHQp4vbBVt4D9og=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:b9857e47-b174-49b7-9865-1662741b364f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.14,REQID:b9857e47-b174-49b7-9865-1662741b364f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:dcaaed0,CLOUDID:1c51b81e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:221129195407XYXWCG6N,BulkQuantity:16,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: b4d986c3c29046979c0d85c8c73e3058-20221130
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <henry.yen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 33041185; Wed, 30 Nov 2022 15:43:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 30 Nov 2022 15:43:57 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 30 Nov 2022 15:43:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvSaQC/ZzzFyaMiuj45Da7+tB85D2cS8a71LopdLjt05Lhrm/J1Co7LgJjtBEWvvIHLvkUOkf3unzE1LTzW2xO3bzK/7F1S4bMo4JjvbbLJFt39YuyUKS0LqLtleTIL0n243yuNLDSKzRLBVTOfVRSwHAa/r6B44j21oshi/e2+cl0WSIXgU4KM4ppw5NN9NUgX63fooEQZfNLkwSFXR/OO9cANRo0+dw5rYgoJQbWWZj5h6eXwtHWg2EtqROKXc1JrilDIAhtOgSnPf3WooUNQkBLZh8yF+jb12U3ZW/ivgquVqRRCjBPYs9QYTFU30sXgX6S20Z3cB2JcUb3wDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik8gzUapHS+NqVxgAj1KtN9ww3d8pFG/C0wchbnAVLA=;
 b=LWp9jo1oySXnsokJs79QJ3+ZQKBnmZRAkHNIXbdjLwvpntGX9VQmdYvDduYqTlwVKTpWZ3M5IJmWCPKw110ek+yiwjfiOZ5W2OjU7qleIU/28EMzMT67RFjxl57n87SbocWAq+ewnIl0yY04fFmnCZYiuliDoac/+WopIPreqj2MR3nNDVsr9OBYGogXLFOi6ns/oqudFciMruuni2kPT3R8G8832Z132ygaAUf5WqI1ouesFhh1Fna9VzLTiUGBefegtcMEzA2dOLXSKMOR9frC7+Xn/f3/sJ/5tspRJTpHWwD6F2e0fL604AYdKGnRd450WVMQvm/ocBWDou1cbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik8gzUapHS+NqVxgAj1KtN9ww3d8pFG/C0wchbnAVLA=;
 b=PR4XiVq7ETRVZDrz5hR9kO45W3WrDH6L24kVNQAdZl9LEBnlyLGicidiLWdj5f5qC1+C1LoifmJo08++VH47SZsYrLeUs9p/R+liMPRQ36RYfaSm4425Ub5vQYJyXs78poAPEkDfxpfffsm6IO5g01DaDO2J7+U5mqX9DrTQsZ0=
Received: from SI2PR03MB5723.apcprd03.prod.outlook.com (2603:1096:4:151::10)
 by SEYPR03MB6676.apcprd03.prod.outlook.com (2603:1096:101:69::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 07:43:54 +0000
Received: from SI2PR03MB5723.apcprd03.prod.outlook.com
 ([fe80::51a8:a88:b4f7:c4c7]) by SI2PR03MB5723.apcprd03.prod.outlook.com
 ([fe80::51a8:a88:b4f7:c4c7%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 07:43:53 +0000
From:   =?utf-8?B?SGVucnkgWWVuICjpoY/kv67muqsp?= <Henry.Yen@mediatek.com>
To:     "daniel@makrotopia.org" <daniel@makrotopia.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        =?utf-8?B?WGluZyBGYW5nICjmlrnlhbQp?= <Xing.Fang@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        =?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= 
        <steven.liu@mediatek.com>, "rafael@kernel.org" <rafael@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] thermal: mediatek: add support for MT7986 and MT7981
Thread-Topic: [PATCH 1/2] thermal: mediatek: add support for MT7986 and MT7981
Thread-Index: AQHZA9k1v3hWgNbfhUSQrgvRAUAo2K5VytGAgAAEzwCAAUelgA==
Date:   Wed, 30 Nov 2022 07:43:53 +0000
Message-ID: <a2438a018be83e74d316ba26ddd96256e0b8d79a.camel@mediatek.com>
References: <20221031230748.xRL1SJX5PchbqyD2hxlXVi5XiA2L39VKuLCwNxdN6uc@z>
         <997af7f23e4cf174b6fed34abfed9c972c50ff77.camel@mediatek.com>
         <Y4X23BWjsxzzXH/H@makrotopia.org>
In-Reply-To: <Y4X23BWjsxzzXH/H@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5723:EE_|SEYPR03MB6676:EE_
x-ms-office365-filtering-correlation-id: d81bc800-8deb-4f86-ae9e-08dad2a6a0d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LC73BL7H/fF/M23sbJ35fNd+442JfS4RnDv4zsIyDucs2wNO28hqOZznQCd+UnLZdN19No/co0uQUhPEdkHezYRCrvphheu4qJMfNaHqRflymUEEVqEAlr558LQiwLzo5IxqpuJ/l3Mx0GhDog74acQQ2JJV2UHYIRbAnvs217eUVKzMrIfL8cAmhmM5+AEBLSpKfF7+/PjM0YA0v5xlrKmeL94opW5mAxl+yNeZGVA3+9m0pbuvJCLGcjN2SuPTPNlfKBkYMFX/iYc4fPSj/0J4qU2yxd33ZRn3K44QJS0Vpymghh6hH3P4LwdVRJS9zh0HvykKpH/wANip9f/biCMjHSBt2dbVMsvmYGNGmLACjaq6KeDGAu7nvJc2fuhiVzlHCRoHEOXsBng8PO6ZuII+3rYqwGZJdMXQV9ruc7UkUXSpbZ+2mrq7iVBXJi4PnAdh97bcmCKMN6HnHMRLytx0v/GmpIdNdlgkVUz2EthDIwt8hGsAQgxOe16voxo0UnL4UdProFryrkNrZh8XYfOytqfm9l6ui+PCyYduMaYzGL7sQGag9dfO6VVo3V+nMXqw8PbyHhYUWUUIWv2uENsFEpfzu7u8m6+akzXI4v9DZYfc6eYv1JnILRkt8fYo7b49zQh03WYzYXQ3zOltTY6+FbMhbSnFT5TxeGJI9NWmqsGaTY+47NP5rP9hTwgns9UuOe+0VSigpT4AW8iJglcuQx1BsXRhGy2kwXqsIoSBpcsO5LyycXKXZ4Kwr1cQBXqgr4pkDbPtwdNZxbiDqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5723.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(71200400001)(5660300002)(6512007)(6506007)(26005)(478600001)(38070700005)(54906003)(6916009)(2616005)(186003)(85182001)(316002)(36756003)(966005)(6486002)(83380400001)(7416002)(66446008)(8676002)(76116006)(86362001)(64756008)(66476007)(66556008)(66946007)(41300700001)(4326008)(4001150100001)(38100700002)(8936002)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkpNeEo0aGJuNThNdWR1RUEvbjRjRjkxVmRKMWpGVWxQa1F5R1diSHVsVncv?=
 =?utf-8?B?T0tSeTlFdi9BYW9lMC9pQ0RiZzdDMWxGU1YyZFpHdFRGWDRKK2tsVWl2cWVF?=
 =?utf-8?B?MWYybksySG83MWJwQ3BPYjBweEk2Z0hrUCttN3AvM3dnSmlEYkJMbzIzNDcr?=
 =?utf-8?B?RDIreGszYmJobWJvSlBVNVl6clF2UDhvbkN1Qmo5WXBZOVF5YzFXa0hBR1JG?=
 =?utf-8?B?NUQzTXNrSkFpanFRWmcyczA0bjN3cHFkeG5KZ0hBWTJiSlV5Ty9QRURYdzhx?=
 =?utf-8?B?SFB5Z2RXNldkTzVtSUU2Q0RhUWRrcGg0R2tNeGs2Q2ZXb0ZUZXhicktWUFc0?=
 =?utf-8?B?Wkk4eWJoeUJMbzlzU1VHN0VHOGtFb1h3ZXZJbGhJOXFrc1NXMGxjaEU5Mkh0?=
 =?utf-8?B?NXNZU2hlcWFXZ1ltRTBTL0srOGRSWktac1VwVWRPRXYyOXlwcG9rdTJRQUZp?=
 =?utf-8?B?RE14Mm1LSmVOWUFiZFZheWNlZW9rS3NycGJTTzVmS29wdDY5cmdVc0FwYkVy?=
 =?utf-8?B?R2l4cU1LT2txS3JnKzY2bnphVFJjSTQvS0R6Z2Y4VjhhQkRMQzVuMUFvY1dE?=
 =?utf-8?B?d010Ylk2NTlhWUJqa3BLNytYVlNvbmtobnlRdWcxajNNSUVjSDJhNis2YmlI?=
 =?utf-8?B?bG1Wb2V4cndNbk1wMlVXQWlzNmppbUhscjhxWTNXQ0Fpdm9KVHV0ZGEzU1VC?=
 =?utf-8?B?NlpOTElhN0VmSUJzNUJ4Wm9kTnNINWhLdFRQWXNlejJlNnk0Rk14VUVndC9L?=
 =?utf-8?B?eERxNkQvbnByRWQ4SktJM1oyMVdmNjBwZCtMVSt4NkVueFhqcE9Vd0tCNTJr?=
 =?utf-8?B?YTQ3VW5LUGpRWmNmQXAyUFFuUCthaUIwaGg4QmV5bzJOTmdXUllZOXZIQWw4?=
 =?utf-8?B?Y0ZzRGdJaGIrZ0c5NDJTb1B1SDI0Qm00bWxTeVB0NDZnMTREYXoxeHRHaUVD?=
 =?utf-8?B?OElRUWZteC8yQTlmcXltclNJNFRvL3pzQkQvLzFwZy9aL0pKOUxIMUM0OVc5?=
 =?utf-8?B?Uk82L0VWY0pISWZYNnc1S0lHWWFpRHpMajYxVGgzaHZjK2VUMkc4R1hpSlhm?=
 =?utf-8?B?MVB3cUNhbENJZ01oMzFjbXpQL2xZYWo5TDlmcmttc3FHRzhjaWVGcHMvVUFx?=
 =?utf-8?B?eHFkY0tNYnJJSEpNMmZqTzJjaThDWk4wOWljckl6TXlDOGhURVVEb1lNcUk4?=
 =?utf-8?B?MllYRkVPTWNSUTRPUGsrWkVuUnlWc25xbXRCaWNRM0VBZHNxSzhsbUxlTHVY?=
 =?utf-8?B?VVJxL3pYbjJrTk1BWGg2MHl5K1VMdEFxY3JVU2Z1RjRleEtkSFllNmU1VVVa?=
 =?utf-8?B?MmNzT0tGaU1zbTFPTjFwT1VHQU5EQk9yMThrY2xKQWVMY3JpaGRKbXg1RG1Q?=
 =?utf-8?B?WTlqemM3ZjB6YUtySkJ4M095eU1uaGV5TTVPZFZ4WjlkSnlJczVPTXZ1bDMz?=
 =?utf-8?B?N2dHbGhWRTVIeExVa0NvL3JmallSdDVkVFdUeG1idFFyMCswQkhFaUhYMXpa?=
 =?utf-8?B?czVISWVlNVgweUpCVjRPaHV0d3VaNGdJRWR6SVFRdHUxYXN0dTZRdUNMVWZB?=
 =?utf-8?B?YjNSV05uWDBLRXpiSTdQY1JZWlgyaE16TUc0MURZamNaTU00VUgxc3g5d2Rm?=
 =?utf-8?B?MlpMaXVKSHd3YngvekpTb0s4OHJBTVRsa2lpdE1iR3RCQnZXd0x2R3lkaWRJ?=
 =?utf-8?B?N1ZVNTVjajd5S1d3K09SSFhRRVQreEVpYmd3NUxVQWV3WjJ4Zy90L0Y5MzFp?=
 =?utf-8?B?RGJ1ODVHSkJ4dTRWM0pUS1Z1RWNHWVJDeURQUERISk5ZVW55eFZia0doTENP?=
 =?utf-8?B?Y09ZUDVNU3E4d1VjN3Q3TGx4SU8xbmh1a0xsTllxZnBPU3lZSDUyV0I4cFdq?=
 =?utf-8?B?K1lTcWsxWTVKNlpoUE5rOERlbVFHNjlONGNlYW1MMlFtbi80YWNmY2RxUXRS?=
 =?utf-8?B?c2puVHFvYmFPOE4wNVF3OGE0MjMzd1NqRTkwK2g3Z0dYbFJacW9MdlBYbm9o?=
 =?utf-8?B?S1hMekVhd1NqMHh1ZjFhQ0FwOXBxZEFhRXNQVXJBVGpMbGtVOWdSUi9CenV2?=
 =?utf-8?B?N1ZuNFRvU2w0bUxvVU40Skh5d29TcklFYUdSY0NPUEt1V0kwTHpxd0ZqSlJJ?=
 =?utf-8?B?Y2NPZGlORnd4SlFOZkFEbjdEQ2d4Vm1xMmtlSVRhRlc2UUNrTVdkSWFpTFJU?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E066C62ECE68049BED24F68C870C94F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5723.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81bc800-8deb-4f86-ae9e-08dad2a6a0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 07:43:53.0796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbuBB2lrQaYCEOBtXMT5q4/FZQgR8TToZ7yIAa38YoSswRD0mlgCKcDNTWYbSM5AhRFk3D4PgyThkL6/1y5mdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTI5IGF0IDEyOjExICswMDAwLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
IE9uIFR1ZSwgTm92IDI5LCAyMDIyIGF0IDExOjUzOjU4QU0gKzAwMDAsIEhlbnJ5IFllbiAo6aGP
5L+u5rqrKSB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjItMTAtMzEgYXQgMjM6MDcgKzAwMDAsIERh
bmllbCBHb2xsZSB3cm90ZToNCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvbXRr
X3RoZXJtYWwuYw0KPiA+ID4gYi9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYw0KPiA+ID4g
DQo+ID4gPiArc3RhdGljIGludCByYXdfdG9fbWNlbHNpdXNfdjMoc3RydWN0IG10a190aGVybWFs
ICptdCwgaW50DQo+ID4gPiBzZW5zbm8sDQo+ID4gPiBzMzIgcmF3KQ0KPiA+ID4gK3sNCj4gPiA+
ICsJczMyIHRtcDsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKHJhdyA9PSAwKQ0KPiA+ID4gKwkJcmV0
dXJuIDA7DQo+ID4gPiArDQo+ID4gPiArCXJhdyAmPSAweGZmZjsNCj4gPiA+ICsJdG1wID0gMTAw
MDAwICogMTUgLyAxNiAqIDEwMDAwOw0KPiA+ID4gKwl0bXAgLz0gNDA5NiAtIDUxMiArIG10LT5h
ZGNfZ2U7DQo+ID4gPiArCXRtcCAvPSAxNDkwOw0KPiA+ID4gKwl0bXAgKj0gcmF3IC0gbXQtPnZ0
c1tzZW5zbm9dIC0gMjkwMCAtIG10LT5hZGNfb2UgKyA1MTI7DQo+ID4gDQo+ID4gSGkgRGFuaWVs
LA0KPiA+IA0KPiA+IFJlZ2FyZGluZyB0aGUgY29udmVyc2lvbiBmb3JtdWxhLCBJIHdvdWxkIHN1
Z2dlc3QgZm9sbG93aW5nIHRoZQ0KPiA+IG9yaWdpbmFsIG9uZSwgaS5lLiwgZGlzY2FyZGluZyAi
YWRjX29lIiBwYXJhbWV0ZXIgYXMgc2hvd24gaW4gWzFdLg0KPiANCj4gT2ssIEkgc2VlLiBBY2Nv
cmRpbmcgdG8gdGhlIGNvbW1pdCBkZXNjcmlwdGlvbiBpdCBsb29rZWQgdG8gbWUgbW9yZQ0KPiBs
aWtlIGFkY19vZSBoYXMgYmVlbiBkcm9wcGVkIGJ5IGFjY2lkZW50LCBpdCBkb2Vzbid0IHNvdW5k
IGxpa2UgaXQNCj4gaGFwcGVuZWQgb24gcHVycG9zZToNCj4gIlJlZmFjdG9yIE1UNzk4NiB0aGVy
bWFsIHRlbXBlcmF0dXJlIGNhbGN1bGF0aW9uIGZvcm11bGEgdG8NCj4gcHJldmVudCBsb3NzIG9m
IGZsb2F0aW5nLXBvaW50IGFjY3VyYWN5LiINCj4gDQo+IEhlbmNlIGl0IG1hZGUgc2Vuc2UgdG8g
YmUgdG8ga2VlcCB0aGUgcGFyYW1ldGVyIGFuZCByZWFsbHkgb25seQ0KPiB1c2UgdGhlIHVwZGF0
ZWQgZm9ybXVsYSB0byBub3QgbG9vc2UgcHJlY2lzaW9uLiBNYXliZSB5b3UgY2FuIGlucXVpcmUN
Cj4gd2l0aCB0aGUgb3JpZ2luYWwgYXV0aG9yIGlmIGRyb3BwaW5nIGFkY19vZSB3YXMgaW50ZW50
aW9uYWwsIGRlc3BpdGUNCj4gYmVpbmcgdW5tZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
Lg0KDQpBY3R1YWxseSBJJ20ganVzdCB0aGUgb3JpZ2luYWwgYXV0aG9yIHdobyBkZXZlbG9wZXMg
TVQ3OTg2L01UNzk4MQ0KdGhlcm1hbCBkcml2ZXIgYW5kIHJlZmFjdG9ycyB0aGlzIGNvbnZlcnNp
b24gZm9ybXVsYS4gR2V0dGluZyByaWQgb2YNCiJhZGNfb2UiIGlzIGluZGVlZCBhbiBpbnRlbnRp
b25hbCBjaGFuZ2UsIGJlY2F1c2UgYmFjayB0aGVuIG91cg0KaGFyZHdhcmUgbWVtYmVycyBpbmRp
Y2F0ZWQgdGhhdCB0aGlzIHBhcmFtZXRlciBzaG91bGRuJ3QgaGF2ZSBiZWVuDQp1c2VkLg0KDQpU
aGFuayB5b3UgZm9yIHlvdXIgY2FyZWZ1bG5lc3MgOikNCg0KPiANCj4gPiBUaGlzIGVxdWF0aW9u
IGlzIGRlcml2ZWQgYmFzZWQgb24gaGFyZHdhcmUtc3BlY2lmaWMgdGhlb3J5LCBzbyBhbnkNCj4g
PiBhcmJpdHJhcnkgY2hhbmdlIGNvdWxkIHBvc3NpYmx5IGxlYWQgdG8gaW5jb3JyZWN0IHRlbXBl
cmF0dXJlDQo+ID4gb3V0cHV0Lg0KPiA+IFRoYW5rcy4NCj4gDQo+IE9uIG15IEJQaS1SMyBib2Fy
ZCBJIGZvdW5kIHRoZSB2YWx1ZSA1MTIgYnVybmVkIGludG8gdGhlIGVmdXNlLCBzbyBpbg0KPiBw
cmFjdGlzZSB0aGUgcmVzdWx0aW5nIGNhbGN1bGF0ZWQgdGVtcGVyYXR1cmUgaXMgZXhhY3RseSB0
aGUgc2FtZSBvbg0KPiB0aGlzIGJvYXJkLg0KPiANCj4gSWYgb3RoZXIgTVQ3OTg2IG9yIE1UNzk4
MSBib2FyZHMgd2lsbCBoYXZlIGFyYml0cmFyeSB2YWx1ZXMgc3RvcmVkIGluDQo+IGFkY19vZSBm
aWVsZCBpbiB0aGUgZWZ1c2UgYmVjYXVzZSB0aGlzIHZhbHVlIGlzbid0IGV2ZW4gdXNlZCBkdXJp
bmcNCj4gdGhlIG1hbnVmYWN0dXJlcidzIGNhbGlicmF0aW9uIHByb2Nlc3MsIHRoZW4gb2YgY291
cnNlLCB0aGVyZSBpcyBubw0KPiBjaG9pY2Ugb3RoZXIgdGhhbiBkcm9wcGluZyBpdCBoZXJlIGFz
IHdlbGwuDQo+IA0KDQpUaGUgdmFsdWUgb2YgImFkY19vZSIgaXMgbm90IG5lY2Vzc2FyaWx5IDUx
Mi4gSXQgY291bGQgcG9zc2libHkgdmFyeQ0KZnJvbSBib2FyZCB0byBib2FyZC4NCg0KLSBIZW5y
eQ0KDQo+ID4gDQo+ID4gWzFdDQo+ID4gDQo+ID4gDQpodHRwczovL2dpdDAxLm1lZGlhdGVrLmNv
bS9wbHVnaW5zL2dpdGlsZXMvb3BlbndydC9mZWVkcy9tdGstb3BlbndydC1mZWVkcy8rL2JhZjM2
YzdlZWY0NzdhYWUxZjhmMjY1M2I2YzI5ZTJjYWY0ODQ3NWIlNUUlMjEvI0YwDQo+ID4gDQo+ID4g
DQo+ID4gSGVucnkNCj4gPiANCj4gPiA+ICsNCj4gPiA+ICsJcmV0dXJuIG10LT5kZWdjX2NhbGkg
KiA1MDAgLSB0bXA7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gIC8qKg0KPiA+ID4gICAqIG10
a190aGVybWFsX2dldF9iYW5rIC0gZ2V0IGJhbmsNCj4gPiA+ICAgKiBAYmFuazoJVGhlIGJhbmsN
Cg==
