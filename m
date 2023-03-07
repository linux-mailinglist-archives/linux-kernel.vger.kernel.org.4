Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD026ADB84
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCGKNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjCGKNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:13:02 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6940D2;
        Tue,  7 Mar 2023 02:12:57 -0800 (PST)
X-UUID: 9f314f72bcd011eda06fc9ecc4dadd91-20230307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PNVC9/yhyMwmZAPN3CEboA041anT12LzymkdVyWcFVA=;
        b=ts/35ZB1TqiA6ikohttNfCyPMXLKtCNF2JVYk3Uli/xsjRmERvyvNDH9ZHbb8HJ6A1dqrZsMA0bIrpelKxTGKalRNRGLESfUNSSxu/P6laZt5JQ/DvGNUrxkkUePzk3mnJmpAwb3XXe85HKKFeAp/CNGs7i1MjuBtuWdL0xbtXQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:abdad1f2-0ed7-4e8a-af6e-1c4829836215,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTI
        ON:release,TS:18
X-CID-INFO: VERSION:1.1.20,REQID:abdad1f2-0ed7-4e8a-af6e-1c4829836215,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION
        :release,TS:18
X-CID-META: VersionHash:25b5999,CLOUDID:559306f5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230307172758IQBBNO8X,BulkQuantity:13,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 9f314f72bcd011eda06fc9ecc4dadd91-20230307
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1190293138; Tue, 07 Mar 2023 18:12:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 7 Mar 2023 18:12:51 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 7 Mar 2023 18:12:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6Dce5FuA7tcaEOhVPt+oI8oNcLQtxAJHHSXkI8urcTE10T4fPN+SEW6827fvYIXo4ZvMZhhI/yCt4r/n5Ph2/uUzOFCEpugQwsuYihiptun+swF2F1423OHKoHJc6Lqolnfr5JzUVt98eHkpWQAZvgf4zVORa4va+YNbvLRHVWoZXOmHfRFyTyKKPUpdwyiPI23BNEFGm2vOdjR3+96/BX66a9nzlSw9Xnqruowp32Xm8lEc459NrTA3SQYKDV4GwPq091D9dC6Kv5jcpvFti3Jq/XwkAKln81hs4pEQ6q0ZIFgT2YkBR8EFPDCWAZMyx6zGpJJRwF9XsczI5wIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNVC9/yhyMwmZAPN3CEboA041anT12LzymkdVyWcFVA=;
 b=Bk2xq177me4JO0qMaFV2HtZ0ZbN0p3sm5MAGGfUuqEsfTRWuOpvM/dVIMgmOD3rSqFrejEUoll+1UCaLxlBW8bXaeYo3VREW/qW8/Mo6lxNaXI5+emz9wlzFeYaEp9+iFOA3WFrBRpdj3VPF/P3HQVMKzv4bM3/HAV/roEpKfs9rK1drqafPuk/Z0/HbNDdFT3sFXlqvpyI1I2fqDnyZCdG50ldhRfFPzdj4Q/JK4tOFi+JWJJARGY4r81mmTBqTB3Vxpl3ia99gljF5DadW1rgBdZzAt7X7NGIzxGm8BaUWvbot4ojPt10gGPeR5ryUd3MKZWkhuzSPp2DLqUOUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNVC9/yhyMwmZAPN3CEboA041anT12LzymkdVyWcFVA=;
 b=InjdVOAJdnq5iMScDiWISY8LsYMf52CGXNiWq6x9V5eofvEeYci3YDo0eApcC5k7LqOlNuGkGeYdqiK++6iQJc83vC6v4RoMgjE7jgBVfBerh+hvQaUnXN7flqVPh2MULw1cK35c1niBiFy7CaBAKcm4qf48l6icHnFdKAloCkI=
Received: from SG2PR03MB3035.apcprd03.prod.outlook.com (2603:1096:4:11::15) by
 PSAPR03MB5672.apcprd03.prod.outlook.com (2603:1096:301:8c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Tue, 7 Mar 2023 10:12:50 +0000
Received: from SG2PR03MB3035.apcprd03.prod.outlook.com
 ([fe80::3803:bee9:26d6:1ce9]) by SG2PR03MB3035.apcprd03.prod.outlook.com
 ([fe80::3803:bee9:26d6:1ce9%7]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 10:12:49 +0000
From:   =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>
To:     "zyytlz.wz@163.com" <zyytlz.wz@163.com>,
        =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        =?utf-8?B?QmluIExpdSAo5YiY5b2sKQ==?= <bin.liu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>
Subject: Re: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Thread-Topic: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Thread-Index: AQHZUNol+KoTCb2NbEShoW8BcHTMZK7vGQcA
Date:   Tue, 7 Mar 2023 10:12:49 +0000
Message-ID: <11c2bce1e5286ad3a9a5be2ee59c2beac168f135.camel@mediatek.com>
References: <20230306062633.200427-1-zyytlz.wz@163.com>
         <CAJedcCzeVwwi9SkkwouFXUAVhF-tKF4dkqsFqVQwszSwY1SJ0A@mail.gmail.com>
         <57c17bfd-83f3-fcce-0eab-e28469fb0ced@collabora.com>
In-Reply-To: <57c17bfd-83f3-fcce-0eab-e28469fb0ced@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3035:EE_|PSAPR03MB5672:EE_
x-ms-office365-filtering-correlation-id: a362527e-9ef8-4a19-e0c7-08db1ef4816c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9kBDE2sLQ9Yxg7StDEgifAK/cBEok9CosNgUvTzUG+0sTHbM5RdmlNx8NobtWIz111dOICwXj3w4ie9AosDbndWeXxb4t/y85C/d36gasUAK0JQGlp/gin1yV62alqzwUd9Lq5nDpHAtW5OHZjin4gbT+AHfX3iaxmLvEOkgZHn44TwiWUvqBgmSNlgpb19IQdaP2xINURSTnlHrpW6ZYS9sVPRS++1y1lik5tzqYYVn4evz216mJPApcD4U6PC5XojmqT8qfq30wEEqup3aeRI7PEEzZgiWwOTdi+rewSlvPmB74qkl0vPf8aXxvJsE1bntNB74atzi1o15aUa7ZsUy6vVaNk1+heFvg3mcie7Bg4wmLypLL/+//5qNS/KrvNjbf8fOdyIE+FFH9OWJ0fW/WicN4qvwGEbhy0x/K113UUBx3acd5fRzvQiXlh1T1929WMHUgNdGiYJTnRGhTh3Ef6BPtpYAcYmwYVR5o+14VQ9/K6igKMHoKlW5jGmRH23afgz02OgxxA0l3pBfkbM1etwfisadanceOENIGu9STWq/SDQSONuAUIfuOObcDPgsY7FkKIhOJF82pdRmKwx0RCkbiSw6Yo3qEbbfKFvn1d5fdoGnZR1ThalkNu6vv8Yd/oiFj13HQ1dEBmMEgGADjXC0YQOVPWUhE28TNFPwfOfOz4IxLbVu3BfO/IUucpAxEsVowaMgWwxN64Y6Ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3035.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199018)(86362001)(122000001)(38100700002)(85182001)(36756003)(38070700005)(4326008)(7416002)(2906002)(5660300002)(66556008)(8936002)(76116006)(64756008)(66946007)(66476007)(66446008)(8676002)(41300700001)(2616005)(186003)(6512007)(83380400001)(316002)(478600001)(54906003)(91956017)(6506007)(26005)(6486002)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWR5UWRha0hFSytjd0VKOWtSNXMwUGc5Y1d5TXRnbmo4czFkZU1ibFNKdWJ1?=
 =?utf-8?B?L2JGWmVReFNFekhxclI4Y1BMYlhnR0lCN2JISDhINEZmYkU2cEpzY2I2L21o?=
 =?utf-8?B?Wmk4TXVHZ2IxOFlBb0lsS09taEp6MnB3anRxdzUwbWhPNEdGSmZrc2lpaHFH?=
 =?utf-8?B?UEgvcFNmWDJvb0FEWXR3TExZdVZMajRWU3BHZGpsc08ydlF0dmRUaEIrQW1F?=
 =?utf-8?B?VHYyVWNGdzlJb0hEc2NMV2s2NnBCRC9ueDg0bWFtSnpQN2VCMkRtQWxLTHBQ?=
 =?utf-8?B?WnZpSXV2WW5Cc3Z0aDdvRjRySzJpRDdmV2xzL0hXNnJNckZXcEJYaVBJb1J0?=
 =?utf-8?B?eDFaay9RTDdob0JwMUxRK1NLR003Qm9mOUtGdmpiemFsejVFSFdpNU4rMUlq?=
 =?utf-8?B?L2JPUTNuNjBDK1NodTVLdlVOL0NOZ2xyOThnNjhyS2t1UnUrYTl5NXNOOGFJ?=
 =?utf-8?B?UlpFOEhQZkttR3RKeEdNcHJBamxoaUdoY3ltaUN3K0R1MXVoeFVLZThRK0NZ?=
 =?utf-8?B?dkhSZi83bTU2d3NGWExiYTFTN2N0djlNTVNHdnBZUXdKU0p4Y0lHKy9MZkhu?=
 =?utf-8?B?aEx3YXZuaEU4Z0JXdFpLRjZGN2d2SGpIMWd5Q1FtNW1MRTNaOEgxUndTaVlq?=
 =?utf-8?B?QTVMd3Z2NktQY1M1K3NWWE5UUlpuRk9IT1l6S1VoYm1lek5Gb002NVZpc1FZ?=
 =?utf-8?B?RjFqRlpIS1lMTlptNGd0MVhxcnRQSVpHQnFiLzB2Mi9LcXRLOTIzWHlDOTFY?=
 =?utf-8?B?clAxY2FuTnE1YlFHZUR0M0l6Vm1WOXR3T1djTlVGTFp3UVdjeENiNHJBekQ2?=
 =?utf-8?B?TUE3ZnlRZHh4RVJlYmZ6VytGcU1xT0x3TlkzTzVnSGhkQ3lEUGJCZkM4cWlO?=
 =?utf-8?B?VVoyRHd3dFE1SXNkTGYxVmlETUFwWGNYN3ZzQ1VpTDhMNFFXRDhveHBpV3RX?=
 =?utf-8?B?d2tncmlSSGhXRG8yNUdYeEtaMWtDMXNDYlk0K0VOeVV6SFpMT3MvQWU3YnZI?=
 =?utf-8?B?VW1GQnNlK21Od0txblA2UXZBNGh5cUNRNmFNSVdmdWRBRE1ONmFwSVJMeXhO?=
 =?utf-8?B?anlQOWN1RWx3aGpwRHoyY2puRm5Ja0lhWndvVm0wWVVmems5TGVhc1FxcG85?=
 =?utf-8?B?WXN6bG9kRDdjZ04rbXVlQkxRMG5KZWd2aXBuR1lCMU5VR21BVnIrbFRHK29h?=
 =?utf-8?B?NjlVQ2FScmhxM09jaTFHaHQ1M20xbXdBMTd5NmVpeFc5Zm5JeURIaWsvTFQz?=
 =?utf-8?B?SlVaQ3lOQW9hN1VRVlIzdzFhb0U3Vll1ZU8xRUtsc3lYVlFtWm05emlVazZt?=
 =?utf-8?B?aGhNUDJzZVg2UkNwUmd5RTNZM09XMndHQVFab0kwbS9DQW1abFNWZ2NNaHhF?=
 =?utf-8?B?RmtFRDZidFc5WEFKNnp4L0xqb3lpS2RVWXZoemFHRFo5bVNTeTdYenNxZmRq?=
 =?utf-8?B?WVhhbHBiQzEwaWREN0xuc01ZR2hvbFV4cEduUnlrY3QzbXpOemZhL2FzTm9E?=
 =?utf-8?B?aVFPNmpsUDkxemNpM080M3cxZDdiaEJCcVkzdXNmZm5MaFl6dE54WG14NERX?=
 =?utf-8?B?SXBIdVJ2NkZlN2tPcVIwakFWN3pENHUrbXlhcEtROWYrbmFldnZBbWp3TVhP?=
 =?utf-8?B?MVpKMEFXT0tvYTVnMGVDeGowbU1XdHAwQkhqOXdmZ1lJZ3JiV09oV09qV3o1?=
 =?utf-8?B?TXBRdUxKMmtHbEtzTGordnczTWV4S0ttYnRjdnM0QjFxK3U5M0NnU0xrcTl0?=
 =?utf-8?B?YmZJVThvZWd5RVlJVXYvQWFrVUJsSWRBRExFbERHcXNlQVhNZU5JSWdRcU9u?=
 =?utf-8?B?Nm10RWYrdnBQUm9JSHluMzFHVXNIb0VSNy9zTC8wcElqMzVKTXVwb0NVOVVC?=
 =?utf-8?B?dVNza1lhS2FiL2ZEazJkMitLWHczcVJYY3R6NG9PL0tVRFhtcjN2aXZKcVBv?=
 =?utf-8?B?Ni9rMlhiRCtzWHMzcCsxY0prSzlhc2hFdnhCYnpGSDVtaytvSjRQL3lrRGtO?=
 =?utf-8?B?dzhWNEZEVU5zVGI1WTc4K09YTmxEV2JVK0w0MFNScWlGWk9LR1B6MnlOZWNk?=
 =?utf-8?B?Z1I0b3g4QWpVdnQwd1ZxUllPejgzWnBvRmF2dksxZGU2eC8weDAyZ29KcWV6?=
 =?utf-8?B?WTMwSk8rcU5DbHA2Z2Z6Y2RWWExVLzh2Mk02SUg0ZW5KZjA4YVFBWmdxV0ky?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB29C0B224C3BE4FBBBBD39929724B9F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3035.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a362527e-9ef8-4a19-e0c7-08db1ef4816c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 10:12:49.4994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LdDKZKR/NlRUvoA1NDBe6XJaFgBgKr94vgitomWo+baI7NLRDYL+Z2TbY/LTqwwOl4d0p7/5PdIghHrwmJRmNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBbmdlbG8gYW5kIFpoZW5nLA0KDQpUaGFua3MgZm9yIHlvdXIgcGF0Y2ggYW5kIGNvbW1l
bnRzLg0KDQpEZWFyIEt5cmllLA0KDQpQbGVhc2UgaGVscCB0byBjaGVjayB0aGlzLCB0aGFua3Mu
DQoNCkJlc3QgUmVnYXJkcw0KDQpPbiBUdWUsIDIwMjMtMDMtMDcgYXQgMTA6NDkgKzAxMDAsIEFu
Z2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAwNy8wMy8yMyAxMDoyNywgWmhl
bmcgSGFja2VyIGhhIHNjcml0dG86DQo+ID4gSGksDQo+ID4gDQo+ID4gSXMgdGhlcmUgYW55b25l
IHdobyBjYW4gaGVscCB3aXRoIHRoaXM/IEkgY2FuIHByb3ZpZGUgbW9yZSBkZXRhaWxzDQo+ID4g
bGlrZSBpbnZva2luZyBjaGFpbiBpZiBuZWVkZWQuDQo+ID4gDQo+IA0KPiBQcm92aWRpbmcgbW9y
ZSBkZXRhaWxzIGlzIGFsd2F5cyBnb29kLiBQbGVhc2UgZG8uDQo+IA0KPiBNZWFud2hpbGUsIGFk
ZGluZyBJcnVpIFdhbmcgdG8gdGhlIGxvb3A6IGhlJ3MgZG9pbmcgbXRrLWpwZWcuDQo+IA0KPiBS
ZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+ID4gVGhhbmtzLA0KPiA+IFpoZW5nDQo+ID4gDQo+ID4g
WmhlbmcgV2FuZyA8enl5dGx6Lnd6QDE2My5jb20+IOS6jjIwMjPlubQz5pyINuaXpeWRqOS4gCAx
NDoyOOWGmemBk++8mg0KPiA+ID4gDQo+ID4gPiBJbiBtdGtfanBlZ19wcm9iZSwgJmpwZWctPmpv
Yl90aW1lb3V0X3dvcmsgaXMgYm91bmQgd2l0aA0KPiA+ID4gbXRrX2pwZWdfam9iX3RpbWVvdXRf
d29yay4gVGhlbiBtdGtfanBlZ19kZWNfZGV2aWNlX3J1bg0KPiA+ID4gYW5kIG10a19qcGVnX2Vu
Y19kZXZpY2VfcnVuIG1heSBiZSBjYWxsZWQgdG8gc3RhcnQgdGhlDQo+ID4gPiB3b3JrLg0KPiA+
ID4gSWYgd2UgcmVtb3ZlIHRoZSBtb2R1bGUgd2hpY2ggd2lsbCBjYWxsIG10a19qcGVnX3JlbW92
ZQ0KPiA+ID4gdG8gbWFrZSBjbGVhbnVwLCB0aGVyZSBtYXkgYmUgYSB1bmZpbmlzaGVkIHdvcmsu
IFRoZQ0KPiA+ID4gcG9zc2libGUgc2VxdWVuY2UgaXMgYXMgZm9sbG93cywgd2hpY2ggd2lsbCBj
YXVzZSBhDQo+ID4gPiB0eXBpY2FsIFVBRiBidWcuDQo+ID4gPiANCj4gPiA+IEZpeCBpdCBieSBj
YW5jZWxpbmcgdGhlIHdvcmsgYmVmb3JlIGNsZWFudXAgaW4gdGhlDQo+ID4gPiBtdGtfanBlZ19y
ZW1vdmUNCj4gPiA+IA0KPiA+ID4gQ1BVMCAgICAgICAgICAgICAgICAgIENQVTENCj4gPiA+IA0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgfG10a19qcGVnX2pvYl90aW1lb3V0X3dvcmsNCj4g
PiA+IG10a19qcGVnX3JlbW92ZSAgICAgfA0KPiA+ID4gICAgdjRsMl9tMm1fcmVsZWFzZSAgfA0K
PiA+ID4gICAgICBrZnJlZShtMm1fZGV2KTsgfA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
fA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgfCB2NGwyX20ybV9nZXRfY3Vycl9wcml2DQo+
ID4gPiAgICAgICAgICAgICAgICAgICAgICB8ICAgbTJtX2Rldi0+Y3Vycl9jdHggLy91c2UNCj4g
PiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWmhlbmcgV2FuZyA8enl5dGx6Lnd6QDE2My5jb20+
DQo+ID4gPiAtLS0NCj4gPiA+ICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9qcGVn
L210a19qcGVnX2NvcmUuYyB8IDIgKy0NCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL2pwZWcvbXRrX2pwZWdfY29yZS5jDQo+ID4gPiBiL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvanBlZy9tdGtfanBlZ19jb3JlLmMNCj4gPiA+
IGluZGV4IDk2OTUxNmE5NDBiYS4uMzY0NTEzZTc4OTdlIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9qcGVnL210a19qcGVnX2NvcmUuYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9qcGVnL210a19qcGVnX2NvcmUu
Yw0KPiA+ID4gQEAgLTE3OTMsNyArMTc5Myw3IEBAIHN0YXRpYyBpbnQgbXRrX2pwZWdfcHJvYmUo
c3RydWN0DQo+ID4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiAgIHN0YXRpYyBpbnQg
bXRrX2pwZWdfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiAgIHsN
Cj4gPiA+ICAgICAgICAgIHN0cnVjdCBtdGtfanBlZ19kZXYgKmpwZWcgPSBwbGF0Zm9ybV9nZXRf
ZHJ2ZGF0YShwZGV2KTsNCj4gPiA+IC0NCj4gPiA+ICsgICAgICAgY2FuY2VsX2RlbGF5ZWRfd29y
aygmanBlZy0+am9iX3RpbWVvdXRfd29yayk7DQo+ID4gPiAgICAgICAgICBwbV9ydW50aW1lX2Rp
c2FibGUoJnBkZXYtPmRldik7DQo+ID4gPiAgICAgICAgICB2aWRlb191bnJlZ2lzdGVyX2Rldmlj
ZShqcGVnLT52ZGV2KTsNCj4gPiA+ICAgICAgICAgIHY0bDJfbTJtX3JlbGVhc2UoanBlZy0+bTJt
X2Rldik7DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4gPiANCj4gDQo+IA0KPiANCg==
