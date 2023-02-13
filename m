Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFEC693F83
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjBMIW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjBMIWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:22:53 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F54CC10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:22:43 -0800 (PST)
X-UUID: 93638e86ab7711eda06fc9ecc4dadd91-20230213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Fthn0oY6RlYgOPoH4l20KNhtVB8zwYrPpBUWs3kB8SA=;
        b=WL+9uFDozA/nkKPliOrQyb1KE4c5LVJ8Q55JuuYagXwOv38BFHN6KOOwUetsbRjMctx5YgEJ8haIkKoijqfIHtarjBXIS5ZhltWpViY0bisD9KRL/ecKs3FhsYUrpf/9Cm9YZIl5t79ULDSOIFrAODdfTAENrc7ik9yxhyhkP8g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:9f8c601f-38a2-4a42-a913-3824f171dcec,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:5ce346f8-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 93638e86ab7711eda06fc9ecc4dadd91-20230213
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1510980588; Mon, 13 Feb 2023 16:22:38 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 13 Feb 2023 16:22:36 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 13 Feb 2023 16:22:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbIsSrQurQfp9Vaq9mTXM+X7EbfLFAWZFEaG0+8mgn1VWqmKR0nN8rwUilcxNznmF50kYx0M5rLKwAMeXp36NxVJyTO/1qpPsdWUSPa4ihYWa7inzi3t/t5SOLr4XnoXcEO6zzhISSvjJLDoO+TUSwZZ4rI3KvK2KZNKNuoPzw/+YFvoOiL+rXmtFIL1xBg4O9mtyIAayzVRPPwkC5ZFv9omSosFHksO40yjj5ZkY8U1ik/z/chSVYPjkZ9u+ieQdZegwbtwEzyZU3msTp+O3Uf9hIbddkIWKjG1qRAWlhUtpNYkIpqkgKn13+qoPpXxlvwOK8m4hp4V2M55AZqOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fthn0oY6RlYgOPoH4l20KNhtVB8zwYrPpBUWs3kB8SA=;
 b=IfjuJBKtryMbK69tPgr4u1glYmTczfPqQAu7maRBCBNB+9cHey9fIDZCV3AYNhO3RSP3gueQfoX24Bs4WA5AUourRQGGJxsbah1JyKE1gomqMVc83xch275G7UAzBMKevM1wScx14EhVC0LO7+WoBqmIxT0zdHPG81ekGi34uqmAVjX2oV77/x+iSJU/NdY48LFeTSOyEtmgv3HmLMsJu3aMeedLVwXqhnNw0viOCGSfsO3Uzx53lC73RIY0azV1aQG3dQ8up+crF3xc4/296hUaZJ3no0FJ5K2AmCjAP9yRcnverfTj0+NceP3kUk+Q6sF2to3nJos32t1HXiPO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fthn0oY6RlYgOPoH4l20KNhtVB8zwYrPpBUWs3kB8SA=;
 b=n5jHFbya95GiLehLzOONzA2V59HSw/Akr0W3mUIqBCLIbL0yX1TyR+Hmu+ikjDRSw9kQMn+EddMF2xAIc7AHLD7Za5hzwwEExEvE0cEGmBfJyCwqWQy98hIIpqwA2OhwhN6JN/McyN8Bled42pUM9BjmD6q8qqzQv2k+nMC63lA=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by TYZPR03MB7204.apcprd03.prod.outlook.com (2603:1096:400:33a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 08:22:34 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1%7]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 08:22:33 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>
Subject: Re: [PATCH v8] phy: mediatek: tphy: add debugfs files
Thread-Topic: [PATCH v8] phy: mediatek: tphy: add debugfs files
Thread-Index: AQHZPS3cBmb6PozoBUixhjUvGQR2AA==
Date:   Mon, 13 Feb 2023 08:22:33 +0000
Message-ID: <eec940a49f4f9ec9e5bd7ad763e436d34b42be22.camel@mediatek.com>
References: <20230210085827.7970-1-chunfeng.yun@mediatek.com>
         <Y+ZjPYDEbC9iblsj@matsya>
         <4e5d86502cc6b2278d7079dfca688af63bbcb523.camel@mediatek.com>
In-Reply-To: <4e5d86502cc6b2278d7079dfca688af63bbcb523.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|TYZPR03MB7204:EE_
x-ms-office365-filtering-correlation-id: f6f7b513-6573-4b4c-fc55-08db0d9b74d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dGyfAy0Ft9nXuIquwyOPTzqVv7B2RosM9E543VYaB+8MHlV9QKqvCJ1MCSDfX2aNcUGXXlqPoYooglFLWWdqps5wmuZfJFYEIydVNrSsOaem3NSitLydA44Lpim7D34OGJHmeAJt2n7/d89U35Bnjk3c6VRbbD6KCfh49TsE3Bu34Qr6pklZ65TaU2soEY1xT9/aMFY19CXj9/p+AGogmwIrhEmENsnZN8KoJTQN/F8bSwBrS2N+P4v1FITsenbqnwrjgJCiPs3h7gk0fcaANXOXSSvBT3zMtpA76S+ls7hFLxKsjA8p3E9bB6uFOl6RapNof5V3ZUai/nhqw/Te+DdUDLmblCUYBS2cYUEbA7Lr7hQI+QI5V5BCrKvpb5knkBStvJOKoMgYb4N1gCmS2j1B6T/Ql/Sh/EHztiZWh0O8JBxVSZqSHmrOMOqWOSrhVjezrjB54Yh6ty94r6HyjwPUNX6aV2xnS4qN1vQ0G8j4z+5v9dXKF9tYcr4UG+AaAchmnnEwFiDySolkMercIJTm9GFktIXI1tW7fgsNtpeelGB/4JPFTNfUdW9nKj3UBV7YRPCl0m1N403Scxko9iwSZ+HpabsE6qUcwVsOnY3HHc2sW7F18RUMi+Wcji3IUkRv7YSmB/ce0Y3hGr9jH46z88PIVZHRPTsDuFbLqFZEjNAwym/TWxESdGCfXXy3zd/oh6gq2fdc7znfrj6Oe3Si3PMv0bLVxqB4EXdysqRfwSb6d547cFBYkSrEluhNA3UMDXprnop3s1xghPxDZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199018)(38100700002)(86362001)(38070700005)(122000001)(85182001)(36756003)(41300700001)(4326008)(76116006)(64756008)(66556008)(66446008)(66476007)(8676002)(66946007)(54906003)(316002)(91956017)(6916009)(8936002)(5660300002)(2906002)(2616005)(83380400001)(6486002)(478600001)(71200400001)(53546011)(6506007)(6512007)(26005)(186003)(107886003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFFUcTNwNXpnNGo1eHJBREZ5VW5SUnBtZHN1eWN6M3FaMmFDd1dFRENtZVBU?=
 =?utf-8?B?a0FyeTZWSDdkdGthV2RLMkZhM1ZoazV1NE9zcTQ4ektJaW1MVGlPNFRDa0tI?=
 =?utf-8?B?dzBEZk5Lc1lGQzltU281WEFkOU9zVENoQnBPejBGdEpYK00zQzc3YlJIZE91?=
 =?utf-8?B?eldJMFZlMS81bHpTQWJkTWxtUTc3MjBUR29ndTZNV2tnRzhVQVUwUXpEVWxW?=
 =?utf-8?B?QTRuSXhxNTFHQmdnUUZFNzZhUVV0TTF6dHhMVzNPR2h5YnZYenhOYm5kK2lN?=
 =?utf-8?B?SWNSMGs3UzZKYmZheVdVVk5PZVcrWjN2WmdQa3pBd2JEallwY3ZSYkJvaFhX?=
 =?utf-8?B?ZUw2dzNBNnVXMkx5ZEZHSVFCQXp1YUJjV1IySTJBWFNLSDZlVTNmcHJIRlJw?=
 =?utf-8?B?eisydzJLWWEzY1ZwQVdKQ1IvMTBSbjBkTzlpMXczM3dwSk52RUoyT3FpTmNa?=
 =?utf-8?B?VHl5cFZhOGpBTHB5aTJWZElxQ25oQWRFeTZPbFBkVktJbGs3MmVvTkE5WFFH?=
 =?utf-8?B?blgvcytmbzNvaW9EeUIxZjBVWUV5VDR4eHRxUlhRUS9IRzMraG0yUkNkRUF1?=
 =?utf-8?B?K1JlZENxcFJhQUdndnJpcU5VMkFDUm1FT25IREQ1bm5JMHgyQjc1V2tRNnJZ?=
 =?utf-8?B?SnQ2VlNkVWs5bStmc0EzRVlHVnliT0IzdytDSDMwWWsyemhZYlpVQS9tOE5u?=
 =?utf-8?B?dXBmdTEycm5PQW16Q0NmVDJRR1BzT0Z1Ui8wREhPMmtaU3JVaUVhTUdPZTJu?=
 =?utf-8?B?cWdLaUd0VCtqeVN4Q2t1dEs5dlBmRFFsMzFVaEd0dGg1RnphRlRmV08yeEtw?=
 =?utf-8?B?VUdOMXNCUEFGVUUvQWZhZUxEVk9MUWd2TlhLbHFzakJZWEZPVjdLeXd6aGE3?=
 =?utf-8?B?YlpPZzA3cTQ2YmZ1cmVBVFQ4ZHhSVDRuQXBCSEppUW1oYm9QeVJ2MVJZNG9H?=
 =?utf-8?B?ZXVKaGdsRVJ6TUNVWkwxQThSandwcDF4ZkNTbVg1MXYxSzR3cHNrc0lVUXZQ?=
 =?utf-8?B?WS9SNk1nRXg4dHBPQVpTWWh4WkRiUGZSOWl1RUo5ZVFtTkJmVllvVVJ6cEsr?=
 =?utf-8?B?eGFLQmU2eENiemRlTzZBUzRudmZHbWFKYjdKZUhDMmQ2RTIvQXIrd2FTR05P?=
 =?utf-8?B?NTJPbDJURW9Hc056cTJtb1o3RktuZjU1TXVFTnZoMjVmZ1JpMExhUHpPRGVQ?=
 =?utf-8?B?UUhkVTRIQzl2WjNxRk5KYXNoMWZwbU5JVi9XMVRJSnIvNEhKVUE5ZCt2NDlE?=
 =?utf-8?B?TnBxVzViaE1kbGhWOGxCaHpWdGx4cFBXYXp5SVJQbFRNajdZZ0U3anNjMlp3?=
 =?utf-8?B?Z1pPRVRGc05acXpSU2xwbmVGajJnbzRsdzFqN1Vna05uRWl1dENUUjVCREMr?=
 =?utf-8?B?MjExQ0hRd2h2dUsydzUvWCtWRWRPQVhHZ0hvcVZidEhOWUMzb2FUSFovVmpV?=
 =?utf-8?B?bHpPUUREY1NySlpndEtVL0MySGlQNExPcllWTjVUUmNoTUpPNCszZHJPVU45?=
 =?utf-8?B?ZjR2dmF0WWcrbG1wbmlQMWcvanRQcW00WjFKekRzL1diR1dtTXhSb3JZNVll?=
 =?utf-8?B?ekp2WGQwWm1LSWxsVFRVY3VrdVRkc0hqNlJoZkhIdy9rc3BjWDRtNGM2NnVP?=
 =?utf-8?B?cDJnVVZoeXN2dXhJQ0JnR1FZaThUOE9PSkpxVUxDUHU3MGN4NnBFVmt1WlNn?=
 =?utf-8?B?U2tFTGVOTmthWGx6NmttRWxlZmUrei9QdWJKQkh0bDhORXp4c1pUVzVoamZa?=
 =?utf-8?B?WHVIczdCNDVQSk5kcUVEU254QzlZeGZkK012YzlFSFdsMVRVTlVpcDlIdnhh?=
 =?utf-8?B?bUpsT2RaUjNybzA3R3ZVdm00NE1tUHBFRHNzT0g2Wncwem1JM0Q0MnUxRVBq?=
 =?utf-8?B?UGc4aGgxdmZtNUQ0OVpaQVpIY1dhbkJrL2ZUL2VYZVBhM3hVd3BmSjZ5QTZS?=
 =?utf-8?B?UUdpbm5LMDJ4TlBCbEZDd1pieDQ3cDQ4NVRIUXowNWFDV0ROUnlaaXZxRWVY?=
 =?utf-8?B?VXZSS2J0ZnFoalpaUDhKMk5qajd0M1NBK0I1QS9VT3AzZEdLZTB4aVVwSHFG?=
 =?utf-8?B?Ti8xcmNhRFAxU2lLQ3lIWFFSRkNEREh4eE9MZjhOMkN6N0FGZUJiaHNaU1c4?=
 =?utf-8?B?R3pGQ051aUZ1aUE5U0phanVJYk80YkRHSDJrZGkza1VnRkZoNmhTM0RVeUJy?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <612E66DC820A5D47BED7B1E02D31923B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f7b513-6573-4b4c-fc55-08db0d9b74d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 08:22:33.4042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/KFpUYrL1KXI2LNkXbo2Gu5rR6lWBw9ZkL4c5to9k3Y6p5Z0BwPXk9iOcZO0I7ZS9E+l1s7TA7+ahCLNn9O0AdEdpKpan4dU1BTv4bnVPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7204
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

T24gTW9uLCAyMDIzLTAyLTEzIGF0IDE2OjIxICswODAwLCBjaHVuZmVuZyB5dW4gd3JvdGU6DQo+
IE9uIEZyaSwgMjAyMy0wMi0xMCBhdCAyMTowMSArMDUzMCwgVmlub2QgS291bCB3cm90ZToNCj4g
PiBPbiAxMC0wMi0yMywgMTY6NTgsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiA+IFRoZXNlIGRl
YnVnZnMgZmlsZXMgYXJlIG1haW5seSB1c2VkIHRvIG1ha2UgZXllIGRpYWdyYW0gdGVzdA0KPiA+
ID4gZWFzaWVyLA0KPiA+ID4gZXNwZWNpYWxseSBoZWxwZnVsIHRvIGRvIEhRQSB0ZXN0IGZvciBh
IG5ldyBJQyB3aXRob3V0IGVmdXNlDQo+ID4gPiBlbmFibGVkLg0KPiA+ID4gDQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4g
PiAtLS0NCj4gPiA+IHY4OiBhYmFuZG9uIHBhdGNoIHRvIGNyZWF0ZSBwaHkgZGVidWcgcm9vdCBm
aWxlDQo+ID4gPiAgICAgL3N5cy9rZXJuZWwvZGVidWcvcGh5LyBzdWdnZXN0ZWQgYnkgVmlub2QN
Cj4gPiANCj4gPiBTb3JyeSB0aGF0IHdhcyBub3QgbXkgc3VnZ2VzdGlvbg0KPiANCj4gU29ycnks
IEkgbWlzdW5kZXJzdG9vZCB5b3UgbWVhbnMNCj4gPiANCj4gPiA+IA0KPiA+ID4gdjZ+djc6IG5v
IGNoYW5nZXMNCj4gPiA+IA0KPiA+ID4gdjU6IHVzaW5nIGNvbW1vbiBkZWJ1Z2ZzIGNvbmZpZyBD
T05GSUdfREVCVUdfRlMNCj4gPiA+IA0KPiA+ID4gdjQ6IGZpeCBidWlsZCB3YXJuaW5nIG9mIHNv
bWV0aW1lcyB1bmluaXRpYWxpemVkIHZhcmlhYmxlDQo+ID4gPiANCj4gPiA+IHYzOiBmaXggdHlw
byBvZiAiZGVidWdmcyIgc3VnZ2VzdGVkIGJ5IEFuZ2Vsb0dpb2FjY2hpbm8NCj4gPiA+IA0KPiA+
ID4gdjI6IGFkZCBDT05GSUdfUEhZX01US19UUEhZX0RFQlVHRlMgc3VnZ2VzdGVkIGJ5IEFuZ2Vs
b0dpb2FjY2hpbm8NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1t
dGstdHBoeS5jIHwgNDA1DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDQwNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4g
PiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHku
Yw0KPiA+ID4gYi9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYw0KPiA+ID4gaW5k
ZXggZTkwNmE4Mjc5MWJkLi42NWE5NWMzNzI2YmYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJz
L3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9waHkvbWVk
aWF0ZWsvcGh5LW10ay10cGh5LmMNCj4gPiA+IEBAIC03LDYgKzcsNyBAQA0KPiA+ID4gIA0KPiA+
ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9waHkvcGh5Lmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxp
bnV4L2Nsay5oPg0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+DQo+ID4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0K
PiA+ID4gICNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4gPiBAQCAtMjY0LDYgKzI2
NSw4IEBADQo+ID4gPiAgDQo+ID4gPiAgI2RlZmluZSBUUEhZX0NMS1NfQ05UCTINCj4gPiA+ICAN
Cj4gPiA+ICsjZGVmaW5lIFVTRVJfQlVGX0xFTihjb3VudCkgbWluX3Qoc2l6ZV90LCA4LCAoY291
bnQpKQ0KPiA+ID4gKw0KPiA+ID4gIGVudW0gbXRrX3BoeV92ZXJzaW9uIHsNCj4gPiA+ICAJTVRL
X1BIWV9WMSA9IDEsDQo+ID4gPiAgCU1US19QSFlfVjIsDQo+ID4gPiBAQCAtMzEwLDYgKzMxMyw3
IEBAIHN0cnVjdCBtdGtfcGh5X2luc3RhbmNlIHsNCj4gPiA+ICAJc3RydWN0IGNsa19idWxrX2Rh
dGEgY2xrc1tUUEhZX0NMS1NfQ05UXTsNCj4gPiA+ICAJdTMyIGluZGV4Ow0KPiA+ID4gIAl1MzIg
dHlwZTsNCj4gPiA+ICsJc3RydWN0IGRlbnRyeSAqZGJnZnM7DQo+ID4gPiAgCXN0cnVjdCByZWdt
YXAgKnR5cGVfc3c7DQo+ID4gPiAgCXUzMiB0eXBlX3N3X3JlZzsNCj4gPiA+ICAJdTMyIHR5cGVf
c3dfaW5kZXg7DQo+ID4gPiBAQCAtMzMyLDEwICszMzYsMzkxIEBAIHN0cnVjdCBtdGtfdHBoeSB7
DQo+ID4gPiAgCWNvbnN0IHN0cnVjdCBtdGtfcGh5X3BkYXRhICpwZGF0YTsNCj4gPiA+ICAJc3Ry
dWN0IG10a19waHlfaW5zdGFuY2UgKipwaHlzOw0KPiA+ID4gIAlpbnQgbnBoeXM7DQo+ID4gPiAr
CXN0cnVjdCBkZW50cnkgKmRiZ2ZzX3Jvb3Q7DQo+ID4gPiAgCWludCBzcmNfcmVmX2NsazsgLyog
TUhaLCByZWZlcmVuY2UgY2xvY2sgZm9yIHNsZXcgcmF0ZQ0KPiA+ID4gY2FsaWJyYXRlICovDQo+
ID4gPiAgCWludCBzcmNfY29lZjsgLyogY29lZmZpY2llbnQgZm9yIHNsZXcgcmF0ZSBjYWxpYnJh
dGUgKi8NCj4gPiA+ICB9Ow0KPiA+IA0KPiA+IEkgYXNrZWQgdGhlIHN0cnVjdCBkZW50cnkgKmRl
YnVnZnMgYmUgcGFydCBvZiBzdHJ1Y3QgcGh5LiBEZWJ1Z2ZzDQo+ID4gd291bGQNCj4gPiBiZSBj
cmVhdGVkIGJ5IGNvcmUgYnV0IHJhdGhlciB0aGFuIGV4cG9ydGVkLCBpdCBzaG91bGQgYmUgcG9w
dWxhdGVkDQo+ID4gaW4NCj4gPiBwaHkgYW5kIHlvdSBjYW4gdXNlIGl0IGhlcmUgaW4gdGhlIGRy
aXZlcg0KPiA+IA0KPiA+ID4gIA0KPiANCj4gT2ssIEknbGwgZG8gdGhlIGZvbGxvd2luZyBzdGVw
czoNCj4gDQo+IDAuIHB1dCBhIHN0cnVjdCBkZW50cnkgKmRlYnVnZnMgaW4gc3RydWN0IHBoeTsN
Cj4gMS4gZGVmaW5lIGEgc3RhdGljIHN0cnVjdCBkZW50cnkgKnBoeV9kZWJ1Z2ZzX3Jvb3QgaW4g
cGh5LWNvcmUuYywNCj4gdGhlbg0KPiAgICBjcmVhdGUgYSByb290IGRpcmVjdG9yeSAoL3N5cy9r
ZXJuZWwvZGVidWcvcGh5LykgZm9yIHBoeQ0KPiBzdWJzeXN0ZW0gDQo+IGluIHBoeV9jb3JlX2lu
aXQoKTsNCj4gMi4gY3JlYXRlIGRpcmVjdG9yeSBmb3IgZWFjaCBwaHkgdW5kZXIgdGhlIHJvb3Qg
ZGlyZWN0b3J5DQo+ICgvc3lzL2tlcm5lbC9kZWJ1Zy9waHkvKTsNCj4gICAgdGhpcyBzdGVwIGhh
cyB0d28gd2F5czoNCj4gICAgQTogY3JlYXRlIHRoZSBkaXJlY3RvcnkgQGRlYnVnZnMgb2Ygc3Ry
dWN0IHBoeSBpbiBwaHlfY3JlYXRlKCkgYnkNCj4gZGVmYXVsdDsNCj4gICAgQjogcHJvdmlkZSBz
b21lIGFwaSBmb3IgdXNlciB0byBjcmVhdGUvZGVzdG9yeSB0aGUgZGlyZWN0b3J5DQo+IEBkZWJ1
Z2ZzIG9yIG90aGVycyB3aGVuIG5lZWQ7DQo+IDMuIGFkZCBwcml2YXRlIGRlYnVnZnMgZmlsZXMg
aW4gQGRlYnVnZnMgb2Ygc3RydWN0IHBoeTsNCj4gDQo+IEZvciB0aGUgY2FzZSBpbiB0cGh5IGRy
aXZlciwgaXQgcHJvdmlkZXMgc29tZSBzdHJ1Y3QgcGh5LCB0aGUgZHJpdmVyDQo+IG1heSB3YW50
IHRvIGNyZWF0ZSBkZWJ1Z2ZzIGZpbGVzIHdoaWNoIG5vdCBiZWxvbmdzIHRvIGFueSBzdHJ1Y3Qg
cGh5DQo+IGluDQo+IHRoZSByb290IGRpcmVjdG9yeSAoL3N5cy9rZXJuZWwvZGVidWcvcGh5Lyks
IHRoZW4gbmVlZCBwcm92aWRlIGEgYXBpLg0KPiANCj4gICAgRG8geW91IGhhdmUgYW55IHN1Z2dl
c3Rpb25zPw0KPiAgICBXaGljaCB3YXkgZG8geW91IHByZWZlciB0byB1c2UgaW4gc3RlcCAyPw0K
PiANCj4gICAgVGhhbmtzIGEgbG90Ow0KPiANCj4gPiA8c2tpcD4NCj4gPiA+ICsNCj4gPiA+ICBz
dGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfdHBoeV9kcml2ZXIgPSB7DQo+ID4gPiAg
CS5wcm9iZQkJPSBtdGtfdHBoeV9wcm9iZSwNCj4gPiA+ICsJLnJlbW92ZQkJPSBtdGtfdHBoeV9y
ZW1vdmUsDQo+ID4gPiAgCS5kcml2ZXIJCT0gew0KPiA+ID4gIAkJLm5hbWUJPSAibXRrLXRwaHki
LA0KPiA+ID4gIAkJLm9mX21hdGNoX3RhYmxlID0gbXRrX3RwaHlfaWRfdGFibGUsDQo+ID4gPiAt
LSANCj4gPiA+IDIuMTguMA0KPiA+IA0KPiA+IA0K
