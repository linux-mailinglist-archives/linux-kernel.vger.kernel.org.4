Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEF26C5C71
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCWCCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCWCCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:02:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15A12313A;
        Wed, 22 Mar 2023 19:02:19 -0700 (PDT)
X-UUID: ba043846c91e11eda9a90f0bb45854f4-20230323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qYNhBhK+nPpvFEjwjmbpT9WFH8REVRsVgQ0bIrpqk/E=;
        b=oq1Yxfvt74t0p/6sG/yni8FpLfB3ylgBU6HnAXz5D7V29Hk1J384C4HhBt3PqZ2pc6sxU7+RMOHT/WDTW/znTkbvsfv4/kcOUTe3OJuc1XKCj3qTkDtxSsRD/kZbTL1zosM5YG8f/n6izHRLtmPot1U0K65rD0nYwHKXgWA9nDM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:36cd5f18-46a7-453e-baad-05dff9fd456d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:7cd514b4-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: ba043846c91e11eda9a90f0bb45854f4-20230323
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 437885974; Thu, 23 Mar 2023 10:02:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 23 Mar 2023 10:02:11 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 23 Mar 2023 10:02:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR9XrN4ShMxGmkfHxrMSG77lvnD+1B5OSJvurm3mfvD9e8vjRIwmjMT2RVV2Otv/JArPrSXYRwnnAId7g4eAQ0B/LeXYjxPjByj/RYM9xZZhjIwfnIT+51MUS/bspf/gxgmef3+pXkuCz02II51Xi1e9Wl+s/HmZgVGQ2raJrEW32C9ZfK44Wc0ZTq0c1jW7iuTY81RnSDrRYxyoQ6/2w+8FwNYUhv9g5LgQMHt5W8NcIn2YxmaDDVzTOCROmmzqM4OpyKTjkV73EnBxxQIupR56dfZ7AthYqfIn+SctwJJuIYcLB/NeG5WSuLCSWxIMgAs3AGj9/9aiVI5lLmx4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYNhBhK+nPpvFEjwjmbpT9WFH8REVRsVgQ0bIrpqk/E=;
 b=SwYSxwUk9Pwtocg0LiFO/ZtTCG7HeIQksPsdJ0tGXCh+9Rtm1Ik1yQGAPHCUhEQozmrPx6TM84B7FqbXklqkO3BD6IcnWdPS674lT/rX5M0cxTtFIdZvoXDKAZRAtViKxDo6hUsncLtTKTCjPMxjKqBA2hn1c5/paGY0nOPzvVqfSMf5jHmkKIlXmTiiTx6WsmctNIljR9ByyRqUs1W33pQrtjwAYWp/Y12VDL6Wh54ZWMtJtCNeGvgtEjcHFeKHZWqZJxfiBXDf+d+zzPFSK2GDgUdwMyksycI0VTXpJEP2ZYLl+AFCELyD/YCWLTyc1VuwDI5ieDrB9B2+qQB/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYNhBhK+nPpvFEjwjmbpT9WFH8REVRsVgQ0bIrpqk/E=;
 b=ABCheXRZJHdDBIeqlNaxfwjhoe4P6tHoLP0yLQ1Z6hWxk3uNlE9hp2qOw+ULEpj07HW210nfW+6ZqnbsScFmjazO7hko3h8KE7zsk4Ch3iaipK/l+jKoqAraEty7oQRbJMgWYKxqxkEIeTMLkLcZYTodKI3YDJCRpNX9JvV3JdI=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by PSAPR03MB5511.apcprd03.prod.outlook.com (2603:1096:301:60::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 02:02:09 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dc74:62fb:a3ab:b10]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::dc74:62fb:a3ab:b10%5]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 02:02:09 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 06/11] remoteproc: mediatek: Probe multi-core SCP
Thread-Topic: [PATCH v8 06/11] remoteproc: mediatek: Probe multi-core SCP
Thread-Index: AQHZTar4LbEFjsrTg0u8QqsK1YFUd679+1WAgAnARYA=
Date:   Thu, 23 Mar 2023 02:02:08 +0000
Message-ID: <7b612644950eda8dc4d2e03e6c6eef0df17569b0.camel@mediatek.com>
References: <20230303083355.3378-1-tinghan.shen@mediatek.com>
         <20230303083355.3378-7-tinghan.shen@mediatek.com>
         <20230316210737.GA2428370@p14s>
In-Reply-To: <20230316210737.GA2428370@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|PSAPR03MB5511:EE_
x-ms-office365-filtering-correlation-id: 75fee1f9-0cae-49ac-e4ce-08db2b429bbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L3tUDJfVfZT6U4qhHDbh8c00Ts2qElPVLwuQibrv2/HMGNNeMqk1zygrhIhbUlnQGD3OhSlimpnidsJ7aNpewKEiQ2zCVPNA7s/Y8ZsEuOd07xl3WJjUA3St+VWYFX3Lc70bOt7ndwTq6j00ow4vBqj0md93Zj5PLWATuuivyZjB5JrYgrB0YxlnNZ5Mz4ZpXGu0Y8VD5UNY9yuzELTa180v72lRluh2kVV3vMBTktntTzwIb1morHNR6NzZ21v0BqtYwRUfJKIeEmK74IZUuHcmzp5Iok5gB74UFRPmuoONYd04OpXrNzKIxOvbNBu9ngSTnP8MQqyACfkJ1sob+LVCvZsps4w9OqIbHEfIqPNQntLrnJioxv4gwNp4HSUs98zDqncbg703qD6bg3yge1L/ipZoyYTxn12bcTWyA6c/0rEpHMv02/CUfqCP9IMReEi6g9XY562R2kTcDGtw9EXoRFUNwFadEgLbrSWcjG4RUmA09k+VAv4j2038Rna2byKE2RR+qL10cRfCmaR2eywCU9JtIo28hW7+qEl+uxWiqhBQqM9V6wtofONxoktjIzJnE17/HKk1jjXJLc09teXNBYYYXD8GhmV253mCOaRZK3pxe17bhD62irmW4fUN49eQgV1zFXHBHTLglo9FsOSbQ4RjPUafNoEJQZHJlr7xsuzkdeMV4JVaj9ikqHE90TZUlTSXWrEeMyFyvJDJHLQheLzsuqMoHdFcddxs9d+ghh3KUqU+ox+IdkswnSvX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199018)(6512007)(2616005)(54906003)(316002)(478600001)(6486002)(6506007)(5660300002)(7416002)(83380400001)(186003)(122000001)(38100700002)(71200400001)(26005)(91956017)(86362001)(38070700005)(6916009)(66946007)(85182001)(41300700001)(76116006)(8676002)(2906002)(64756008)(66476007)(8936002)(66556008)(36756003)(4326008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3J6dmgrUU9jYkp1cyttdHJ5SnlzMFFNWlE3cEIzZmtmdE5vUWdYTzFVei9D?=
 =?utf-8?B?NG1kZmxNckk4ekZQUmFMcUZMWnJULzBVUzVvUkVoOTZOWkYwbnNkbWxhY200?=
 =?utf-8?B?SFpRMjVFQUZad3EzOTRqcWtnMUpBdGNNNUlRSVYzdk04b0FqS3NCMmNCMG1S?=
 =?utf-8?B?cTZYRHcrcnpYWTJlNllVb0p5bVlJUGpYUktZNk90Vm5zdVVmendkVGRNcFZz?=
 =?utf-8?B?VFlIaHhkQU02TlNtNjVUcS9IQ251UWxRWmVpM2R2MFp4L2FtTnRTc1V5NHI2?=
 =?utf-8?B?aHQreCt5T2pIS2pYcHlLeEFPeVQxQzRMVmtkWWFtQTUxdWpMaklVRkx2TVg4?=
 =?utf-8?B?dVpqLzgzU0wxaGNGdDhZSys0YlkrcDNCeHhqSVZ0YlBuRzVMbEF6Z0hQWW1F?=
 =?utf-8?B?c2R1NDYzbjM3UGxJd3M4LzkxZFpDcHZ5c015azBxRjRTMHIrUU9iYXB1bStp?=
 =?utf-8?B?S1MxSVJuQ3pVaDkvUUl1dmxFU0s5clJFMzVJbmZzOC9wNzF5RjcvVWZSbGNu?=
 =?utf-8?B?TUJkbWxMNU5lNHFSWGJpOUR6RmJ0UXJxVVRwc3JSS3pzcGtKR2lBRDZuYlBl?=
 =?utf-8?B?dXlzSzMzTmhFd1dObXVsMEE1Q1JuTnI3TTRoTlpMMkRDNXZkOVQza0FrMVo3?=
 =?utf-8?B?ZHRNNE5SMzN2d2dxWmxSUW10R05XbGVkMVhxZk0xMmtCOHVmN3lQSmlZRmdo?=
 =?utf-8?B?b3hnVzgxZnZkV1ZSd0hObmhUWDBiZ2FJYjg5akgyS2dwbjNuQ0VPNGVJTk9a?=
 =?utf-8?B?clVRZThUZU5kZDBBU3NVc2hRL01XTDVsSm1oWWNGK2d3U2w4NlRDWHo5SU9D?=
 =?utf-8?B?QVFaOHY4T3JieWorTWoyMXovTjkzQ2lTTDJBL2xRN3Y2UWRZYTI4MHdLMmpB?=
 =?utf-8?B?Yi90NXB1aUZmTDVzVUZXMGVRNzk2RlJ0WkFRRHEzS1plb2VkZXZSaE9BQzhq?=
 =?utf-8?B?blhrR2tUbkRVUTJIcUJ6aTlNRFFDQ1Y1RFRobmMwQlVPNGoramVOa2trTktS?=
 =?utf-8?B?VVFYaXFEb3BKM0NDSFdadGFzbDkrZzlMNU9CWVdONC9tWjl5djQ4eEpVYktz?=
 =?utf-8?B?dkoveFhaaGhNSzhWRllzNEhEeDczbzMrVXpNaUpDU2lZK3BLNHkvbEZpeGFv?=
 =?utf-8?B?aUt4c2g4RVl2cjVzSlh4NFhSbUtHQS9lTm1vblhQcHpHSHc2ckRZbnNsYlBC?=
 =?utf-8?B?VGdNR2R1Ty9GOU9CV3BJNUlKVFVac3NSOXJUaEZSd0lGdWM1ZzcxN2R3Ti9M?=
 =?utf-8?B?REoxMW05UkUwUmhhRzRxYi9BelVWUmdQcEw4WEpnTXp1ZzgrLzRObkMyTVBY?=
 =?utf-8?B?eW80bWNob1JVTW5KMWlSRlVkc0xidFpLS2FwNnlFWmg4NXlEUEtkZ0lPSDFv?=
 =?utf-8?B?cHUvelluaU9NcXZWNGFERXY4RkN5Ylhjckg3Q2paS0srUlRYRVBuM2lIMzRW?=
 =?utf-8?B?bVcxUXBuTldzWWwxamI5TUx1cUhpOWt6d1EvRGJXcUJVMWZCTHVUM2Y2UHVw?=
 =?utf-8?B?UDZMYW5UM0NNRkVNTXhnRHVhTks5d2orNmsxS1NTcm1KN3RJS1JpTk9CN1Rm?=
 =?utf-8?B?eW5xenNobFl3a2hZOVdrbG12RnNqZlR2aUM1N3g5a2lmbmNYVVd3TW10QXl0?=
 =?utf-8?B?Z3IrblJQd1dtcWZrQm56SU5telFJdG5xRUN2MERZZUlyM0ZaNDhJY2xoREh5?=
 =?utf-8?B?d1htM1B2dzVqZHlkWFBtaWtuSjhydUlESnJkN1ZYTmdmazRmaTMwZFMyNHRp?=
 =?utf-8?B?d0tCZlNFeHBlNURKYkNtZTVUN09sQUw2VFplTHFxSnJQSjU1QVJKaEd2M3ZR?=
 =?utf-8?B?NDNaeXFocmxOMXpWY0s0ZEVqMFB4QjcyZ1crcTMzbmppZ2JRU0trMEYzNlhU?=
 =?utf-8?B?L1A1OEdWWVptY1JoMThublVHWW0rTitqb1FKK0hXNTZlSEMwRVBISVl3Q3oz?=
 =?utf-8?B?dDRRT1hZdC8vZEc0WEQ5NzhKSm1GdEtWVEZTc0c1MGZxWHZsRTQzbk9ROWti?=
 =?utf-8?B?Z2ZHb3Z3QkdIZENZWk00WE91QTh0eFEzYkVhS1BNWndaQzlELzJuelA5VWR2?=
 =?utf-8?B?VjI0UU9Qck5IRXJxY1YwR3g5OVIxbGo1MzVpY25PVXFMNTl6OStFQk5YdmFY?=
 =?utf-8?B?eFZselU2dlVqS08zSVZBdzVLQjBFbnRTSEZCVnBnMk5EaDNsclJFcjNlZWZk?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F51214F91795041A774DD9A35504863@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fee1f9-0cae-49ac-e4ce-08db2b429bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 02:02:08.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9VyrVMKHnfx8b5Ed7XVtUquF1zXqKzaTx28GiRsYArHTT4OSUxN+5en0cBgR6JJs94ekGrhG6DXWMfUzCHoBGFBxcmUR9uBz98PinSUHdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5511
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlldSwNCg0KT24gVGh1LCAyMDIzLTAzLTE2IGF0IDE1OjA3IC0wNjAwLCBNYXRoaWV1
IFBvaXJpZXIgd3JvdGU6DQo+IE9uIEZyaSwgTWFyIDAzLCAyMDIzIGF0IDA0OjMzOjUwUE0gKzA4
MDAsIFRpbmdoYW4gU2hlbiB3cm90ZToNCj4gPiBUaGUgZGlmZmVyZW5jZSBvZiBzaW5nbGUtY29y
ZSBTQ1AgYW5kIG11bHRpLWNvcmUgU0NQIGRldmljZSB0cmVlIGlzDQo+ID4gdGhlIHByZXNlbmNl
IG9mIGNoaWxkIGRldmljZSBub2RlcyBkZXNjcmliZWQgU0NQIGNvcmVzLiBUaGUgU0NQDQo+ID4g
ZHJpdmVyIHBvcHVsYXRlcyB0aGUgcGxhdGZvcm0gZGV2aWNlIGFuZCBjaGVja3MgdGhlIGNoaWxk
IG5vZGVzDQo+ID4gdG8gaWRlbnRpZnkgd2hldGhlciBpdCdzIGEgc2luZ2xlLWNvcmUgU0NQIG9y
IGEgbXVsdGktY29yZSBTQ1AuDQo+ID4gDQo+ID4gVGhlIHJlc291cmNlIHN0cnVjdHVyZSBvZiB0
aGUgbXVsdGktY29yZSBTQ1AgaXMgYSBsaXN0IG9mIHJlbW90ZXByb2MNCj4gPiBpbnN0YW5jZXMg
d2hpY2ggaXMgZGlmZmVyZW50IHRvIHRoZSBzaW5nbGUtY29yZSBTQ1AuIFRoZSBjb3JyZXNwb25k
aW5nDQo+ID4gcmVzb3VyY2UgcmVsZWFzaW5nIGFjdGlvbiBpcyBiYXNlZCBvbiB0aGUgdHlwZSBv
ZiBTQ1AuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVGluZ2hhbiBTaGVuIDx0aW5naGFuLnNo
ZW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3JlbW90ZXByb2MvbXRrX2Nv
bW1vbi5oIHwgICA0ICsNCj4gPiAgZHJpdmVycy9yZW1vdGVwcm9jL210a19zY3AuYyAgICB8IDE3
NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQs
IDE2NiBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gPiANCg0KKHNuaXApDQoNCj4g
PiBUaGlzIGNvZGUgaXMgY29tcGxleCBhbmQgaGFyZCB0byByZWFkIGJlY2F1c2UgcnByb2NfYWRk
KCkgaXMgY2FsbGVkIGluIHR3bw0KPiBkaWZmZXJlbnQgY29udGV4dC4gIEZyb20gYSBjb2RlIHBl
cnNwZWN0aXZlIHNpbmdsZSBjb3JlIHJlbW90ZSBwcm9jZXNzb3JzIHNob3VsZA0KPiBiZSB0cmVh
dGVkIGFzIGEgb25lIGNvcmUgY2x1c3Rlci4NCj4gDQo+IEkgYW0gZG9uZSByZXZpZXdpbmcgdGhp
cyBwYXRjaHNldC4NCj4gDQo+IFRoYW5rcywNCj4gTWF0aGlldQ0KPiANCg0KSSdsbCBpbXByb3Zl
IG15IHBhdGNoc2V0IGluIHRoZSBuZXh0IHZlcnNpb24uDQpUaGFuayB5b3UgZm9yIHRoZSByZXZp
ZXcgY29tbWVudHMhDQoNCg0KDQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJZ290byBhZGRfZmFp
bDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArDQo+ID4gK2FkZF9mYWls
Og0KPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9jb250aW51ZShzY3AsIGNsdXN0ZXIsIGVsZW0p
IHsNCj4gPiArCQlycHJvY19kZWwoc2NwLT5ycHJvYyk7DQo+ID4gKwl9DQo+ID4gK2luaXRfZmFp
bDoNCj4gPiArCWlmIChjbHVzdGVyKSB7DQo+ID4gKwkJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZl
X3JldmVyc2Uoc2NwLCB0ZW1wLCBjbHVzdGVyLCBlbGVtKSB7DQo+ID4gKwkJCWxpc3RfZGVsKCZz
Y3AtPmVsZW0pOw0KPiA+ICsJCQlzY3BfcnByb2NfZnJlZShzY3ApOw0KPiA+ICsJCX0NCj4gPiAr
CX0NCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHNj
cF9jbHVzdGVyX2V4aXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiArew0KPiA+
ICsJc3RydWN0IGxpc3RfaGVhZCAqY2x1c3RlciA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYp
Ow0KPiA+ICsJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqY3BkZXY7DQo+ID4gKwlzdHJ1Y3QgbXRr
X3NjcCAqc2NwLCAqdGVtcDsNCj4gPiArDQo+ID4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmVf
cmV2ZXJzZShzY3AsIHRlbXAsIGNsdXN0ZXIsIGVsZW0pIHsNCj4gPiArCQlsaXN0X2RlbCgmc2Nw
LT5lbGVtKTsNCj4gPiArCQljcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShzY3AtPmRldik7DQo+
ID4gKwkJc2NwX3Jwcm9jX2V4aXQoY3BkZXYpOw0KPiA+ICsJfQ0KPiA+ICt9DQo+ID4gKw0KPiA+
ICBzdGF0aWMgaW50IHNjcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+
ICB7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsJc3RydWN0
IGRldmljZV9ub2RlICpucCA9IGRldi0+b2Zfbm9kZTsNCj4gPiArCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqY29yZV9ub2RlOw0KPiA+ICAJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4gIAlzdHJ1Y3Qg
bXRrX3NjcF9vZl9yZWdzIHNjcF9yZWdzOw0KPiA+ICAJaW50IHJldDsNCj4gPiBAQCAtOTc2LDIx
ICsxMDk0LDQzIEBAIHN0YXRpYyBpbnQgc2NwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4gIAkJc2NwX3JlZ3MubDF0Y21fcGh5cyA9IHJlcy0+c3RhcnQ7DQo+ID4gIAl9
DQo+ID4gIA0KPiA+IC0JcmV0dXJuIHNjcF9ycHJvY19pbml0KHBkZXYsICZzY3BfcmVncyk7DQo+
ID4gKwlyZXQgPSBkZXZtX29mX3BsYXRmb3JtX3BvcHVsYXRlKGRldik7DQo+ID4gKwlpZiAocmV0
KQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiRmFpbGVkIHRvIHBvcHVs
YXRlIHBsYXRmb3JtIGRldmljZXNcbiIpOw0KPiA+ICsNCj4gPiArCWNvcmVfbm9kZSA9IG9mX2dl
dF9jaGlsZF9ieV9uYW1lKG5wLCAic2NwIik7DQo+ID4gKwlvZl9ub2RlX3B1dChjb3JlX25vZGUp
Ow0KPiANCj4gUGxlYXNlIHVzZSBvZl9nZXRfYXZhaWxhYmxlX2NoaWxkX2NvdW50KCkNCj4gDQo+
ID4gKw0KPiA+ICsJaWYgKCFjb3JlX25vZGUpIHsNCj4gPiArCQlkZXZfaW5mbyhkZXYsICJzaW5n
bGUtY29yZSBzY3BcbiIpOw0KPiA+ICsNCj4gPiArCQlyZXQgPSBzY3BfcnByb2NfaW5pdChwZGV2
LCAmc2NwX3JlZ3MsIG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpLCBmYWxzZSk7DQo+ID4g
KwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWls
ZWQgdG8gaW5pdGlhbGl6ZSBzaW5nbGUtY29yZSBzY3BcbiIpOw0KPiA+ICsJfSBlbHNlIHsNCj4g
PiArCQlkZXZfaW5mbyhkZXYsICJtdWx0aS1jb3JlIHNjcFxuIik7DQo+ID4gKw0KPiA+ICsJCXJl
dCA9IHNjcF9jbHVzdGVyX2luaXQocGRldiwgJnNjcF9yZWdzKTsNCj4gPiArCQlpZiAocmV0KQ0K
PiA+ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBpbml0aWFs
aXplIHNjcCBjbHVzdGVyXG4iKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4g
PiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIGludCBzY3BfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBtdGtfc2NwICpzY3AgPSBwbGF0Zm9y
bV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPiAtCWludCBpOw0KPiA+ICsJc3RydWN0IGRldmljZSAq
ZGV2ID0gJnBkZXYtPmRldjsNCj4gPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9m
X25vZGU7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKmNvcmVfbm9kZTsNCj4gPiAgDQo+ID4g
LQlycHJvY19kZWwoc2NwLT5ycHJvYyk7DQo+ID4gLQlzY3BfcmVtb3ZlX3JwbXNnX3N1YmRldihz
Y3ApOw0KPiA+IC0Jc2NwX2lwaV91bnJlZ2lzdGVyKHNjcCwgU0NQX0lQSV9JTklUKTsNCj4gPiAt
CXNjcF91bm1hcF9tZW1vcnlfcmVnaW9uKHNjcCk7DQo+ID4gLQlmb3IgKGkgPSAwOyBpIDwgU0NQ
X0lQSV9NQVg7IGkrKykNCj4gPiAtCQltdXRleF9kZXN0cm95KCZzY3AtPmlwaV9kZXNjW2ldLmxv
Y2spOw0KPiA+IC0JbXV0ZXhfZGVzdHJveSgmc2NwLT5zZW5kX2xvY2spOw0KPiA+ICsJY29yZV9u
b2RlID0gb2ZfZ2V0X2NoaWxkX2J5X25hbWUobnAsICJzY3AiKTsNCj4gPiArCW9mX25vZGVfcHV0
KGNvcmVfbm9kZSk7DQo+ID4gKw0KPiA+ICsJaWYgKCFjb3JlX25vZGUpDQo+ID4gKwkJc2NwX3Jw
cm9jX2V4aXQocGRldik7DQo+ID4gKwllbHNlDQo+ID4gKwkJc2NwX2NsdXN0ZXJfZXhpdChwZGV2
KTsNCj4gPiAgDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+IEBAIC0xMDY5LDEyICsxMjA5
LDE5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3NjcF9vZl9kYXRhIG10ODE5NV9vZl9kYXRh
X2MxID0gew0KPiA+ICAJLmhvc3RfdG9fc2NwX2ludF9iaXQgPSBNVDgxOTVfQ09SRTFfSE9TVF9J
UENfSU5UX0JJVCwNCj4gPiAgfTsNCj4gPiAgDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRr
X3NjcF9vZl9kYXRhICptdDgxOTVfb2ZfZGF0YV9jb3Jlc1tdID0gew0KPiA+ICsJJm10ODE5NV9v
Zl9kYXRhLA0KPiA+ICsJJm10ODE5NV9vZl9kYXRhX2MxLA0KPiA+ICsJTlVMTA0KPiA+ICt9Ow0K
PiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX3NjcF9vZl9t
YXRjaFtdID0gew0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtc2NwIiwg
LmRhdGEgPSAmbXQ4MTgzX29mX2RhdGEgfSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTg2LXNjcCIsIC5kYXRhID0gJm10ODE4Nl9vZl9kYXRhIH0sDQo+ID4gIAl7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC1zY3AiLCAuZGF0YSA9ICZtdDgxODhfb2ZfZGF0YSB9
LA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItc2NwIiwgLmRhdGEgPSAm
bXQ4MTkyX29mX2RhdGEgfSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1
LXNjcCIsIC5kYXRhID0gJm10ODE5NV9vZl9kYXRhIH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE5NS1zY3AtZHVhbCIsIC5kYXRhID0gJm10ODE5NV9vZl9kYXRhX2NvcmVz
IH0sDQo+ID4gIAl7fSwNCj4gPiAgfTsNCj4gPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXRr
X3NjcF9vZl9tYXRjaCk7DQo+ID4gLS0gDQo+ID4gMi4xOC4wDQo+ID4gDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVGluZ0hhbg0K
