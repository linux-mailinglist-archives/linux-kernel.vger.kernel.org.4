Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79659600F99
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiJQMzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiJQMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:55:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132E233430;
        Mon, 17 Oct 2022 05:55:18 -0700 (PDT)
X-UUID: 51397e09d7474f62aa1a7d20d988df49-20221017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mYgN8J+DsEzfbrmDoD4xnH2k1yeiWsNUVwIs09nIjlg=;
        b=h+CQgnAGQKMoSDqMpTTvtW/TIZ1E8CkUB+cNT7DUOhP7jRnnJdkT8Rx5W18l1ReEM2oziolaRmdg9Zc8wyaM1lXdOxBuikKNa77N8IFM/3ae/XfrRP8FKvVg2hkTw6+Z5nCX4syPGdfDMig5Fj7tbHQkh3Y7mu/ujYke3dZA4bI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:d6a0c72d-a885-458f-9a3a-a20c95fed1fa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:437709a4-ebb2-41a8-a87c-97702aaf2e20,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 51397e09d7474f62aa1a7d20d988df49-20221017
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1506409613; Mon, 17 Oct 2022 20:55:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 17 Oct 2022 20:55:11 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 17 Oct 2022 20:55:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lh82qu/9V8NjnSCnTCH14xpJvLyQXFyOawIcIP5rj69i2hMl+QaLNnLXtOYDhMTxaBdAvmR6xtftBAR59LBpoTZOWDS+95josevaPAXq7lWwwToNBWVX8qoRONEB9Ewg3Onm4vU0D7jkYtoeLg8DJ9zaAel1XtMr2kjVT9w+UOzUPMnygKMPemoG4YkK/duGsIm6cDW3Rd4lB+wO+aWh1SppBTBDkJhDOJqTE5k7tpxF3UHYzMuDSs/1gugv9/MU9KS5FaSn2ZJZKLsYnOOCvIdZOMezz1SIlfcex452eQ+FFb0oTtHetEoo6czENlDhyobkjAMoihd9Lqhot9gLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYgN8J+DsEzfbrmDoD4xnH2k1yeiWsNUVwIs09nIjlg=;
 b=I5y0dw9pViOwkOVkTaM5s50F/NMBl2FwMxKX3WQKtl4VlD70ffodpTXSjkUn0IK0gEjIxsEo5himg66KJS2D70qIfrtUQ9HNNOI7DuwttGqk+zSfZgLF0fQlJ4umbf3dThJ51dQvq1rX/lz6ZhrzkSOTkn8i8qITbPvcw4aRAWHch1VDH9S82eFy0YEIAZ2pKrZR3T6hrSZFUbropdixmNr/GNjL6UgTQnPlMMWTFKjqj7OCajIUBpAwF2JYLkKytmjGro9JR8FDljKpLtoQo2/U+7epriMpU9DK/ALU5BB6cNFxCH9S5+iszaAkDYGp59O7Tso5PtxdMmsOG0ihsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYgN8J+DsEzfbrmDoD4xnH2k1yeiWsNUVwIs09nIjlg=;
 b=FdDKrRcHkMYLM0xB3BUuV5BjDH8nDa778aVsS3gzxKvCvevaMOLVwt3JgKD67JrMEtEbTeUq6Y4lwBGcTsACsEiDik+6erjom6M3MvEBlJSES76UL6OyswfEl4XGYply3s0rW+bNZgFKF4f8xESAuAd2jO+C6tCBYD0Re62Au5I=
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com (2603:1096:400:142::9)
 by TYZPR03MB6190.apcprd03.prod.outlook.com (2603:1096:400:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 12:55:09 +0000
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::691d:c9be:8a6f:5e85]) by TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::691d:c9be:8a6f:5e85%8]) with mapi id 15.20.5746.015; Mon, 17 Oct 2022
 12:55:09 +0000
From:   =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?S3Vhbi1Ic2luIExlZSAo5p2O5Yag5pawKQ==?= 
        <Kuan-Hsin.Lee@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?WXUtQ2hhbmcgV2FuZyAo546L54Wc5qifKQ==?= 
        <Yu-Chang.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?RWR3YXJkLUpXIFlhbmcgKOaliuWTsue2rSk=?= 
        <Edward-JW.Yang@mediatek.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Thread-Topic: [PATCH v4 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Thread-Index: AQHY3vZX+12K5aZzWEmPg4uSwosspa4OXRQAgAQ0XIA=
Date:   Mon, 17 Oct 2022 12:55:09 +0000
Message-ID: <6a866b8f4e997a33adeaaf4498c47de76e07fa35.camel@mediatek.com>
References: <20221013112336.15438-1-johnson.wang@mediatek.com>
         <20221013112336.15438-3-johnson.wang@mediatek.com>
         <20221014204242.C7CAFC433B5@smtp.kernel.org>
In-Reply-To: <20221014204242.C7CAFC433B5@smtp.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6274:EE_|TYZPR03MB6190:EE_
x-ms-office365-filtering-correlation-id: b3f03547-6e59-460a-ab71-08dab03ed290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oW58GtXlH2kjsC12LBVOpc+MJsSsTAc75kJjHw4Ufg5AxTHKytFHG9Q98bCPS9LSuAkkadyWwHMNJwTaUuxugc4CdVCnCcbxY6RxPcx215J13Jiq1d4F6uJEmEfBBu/yPHnkcRIjFzdgnH5+LBAE1saWHRSvncRouC3BEPglUtojdFYbdpuYWDT3bgNIgMdUg9pNEBurLxGZuUSU0SuYmazRb7+0aPmJSWMfzaVQOLdEiCIa3WQxV7QElEUNYp1ZnWpx/KqAvfrN7xHmhy+Q01bI0l4Dkrjsoi8FFNVyrxRNOkmq49BEBA2E0CuUDaGcEiBVVMgF5bQ5t3+RjZQxFdvL7reXXmRPWIicox78ZCBDqma9yjpos1m51MuZ6MG7TZtnr61HwSK02Ho/ZS1XDsfdq2rn7voqhl56s8Z5KZ90VP8geAByvZtFpobakyIvMbYgk5n16GtuPFR3ccpbdkVY0DN/rZB7hLmBn/gyZKmhPRT9JCge8xhcRv7aRX6KLJqrQdHRx83UzUigL5LKH25sUoL/FApZLJqeHHcz2VclCaXVufXmC7KffZNArugy7pLAl+uf7XWH7wBK3yfs07PAwcJye7wzZudWhirCl3G1YyT4bOElELMQJPG6ba73nXI2ifuNLgSIy5dr5EK/Li5pucr26Ff4fSbVA3ygwkntGDAWibqNPo5YwGuM3KaMxKZUOCgUF3q3E8olJKr0Z2ekMpQO7TFByNOquAGVwYcb81YIhe4P3FeUWRx9FrCFiLsq7XeLXylx3oSHMIhllF5Io++aEOjcub8Qc5/ctzSPt0ws0d6/c3dnckpRjKd6qcx3GobUBWwv+HTSuHasRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6274.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(71200400001)(966005)(6486002)(478600001)(54906003)(316002)(110136005)(86362001)(2906002)(107886003)(91956017)(76116006)(66556008)(66476007)(66946007)(66446008)(8676002)(4326008)(6506007)(38070700005)(83380400001)(26005)(6512007)(186003)(2616005)(122000001)(41300700001)(64756008)(38100700002)(5660300002)(85182001)(36756003)(4001150100001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czgxUzI1cENIeEtwakRkTGlBZFBZa2E0ZWJSOHQ2N1kycDdjN3Rmck1CZnRJ?=
 =?utf-8?B?T01Hc09LcVNEb0M0MGQrbWZPaFI3U3JMMVZNMU9TanlLQ0szVmpkMmxzSnZz?=
 =?utf-8?B?ajBFMjJITEV5ZDBmTGVtNmxJVFh5dUlPRXpvZzNsKzBPUkJWWVdISWwrblFE?=
 =?utf-8?B?dlZTRDVEYjluTjVlTjNvcEFqZHFkZmJqZlFveHROa2JacTlBQWdVcFRRZUpq?=
 =?utf-8?B?UFY2S09MT1JMRjB1MzZaY0dSb2FqUnhQaStCQS9INXpGbzNERHpPMVNOeVFw?=
 =?utf-8?B?QWNVRkpQejNsOWoxelBCbU9FcHM5NXNlais4OXBlTUtTeVh6OEtYVmc2OXpV?=
 =?utf-8?B?TEdzV2k5VmVoZkpLeVRpSHBsVDhZRnAxTHhTTVdCUTNEU1lhYkY3d2JKdUZE?=
 =?utf-8?B?SGM0ZVZ2N1B6SHI3Z2JidXhmekxMcDVkc1JYTG53OHNTeHRYU2t0TGtwcUo3?=
 =?utf-8?B?OXZlZjRHUTRIRDR1cmJoc1VoUVpqVlFPd1FET1EzK3NGdmYwTnBOUjBENkdZ?=
 =?utf-8?B?ckVmZUNKOVhhVGo0bGg3eG9RYTRMTitUWlI2c0lMbmdEWGpISEdqN2FGYXBQ?=
 =?utf-8?B?L0VVdUJtYXJGOVJsZ2o5bXdzRkxZM0tGM1pIelh0TEdNQkZ0bzB1b2V0cWYr?=
 =?utf-8?B?OVFHRFk5dERkV2hKZ3Mza2llUk9QY3JhNkRiRW45azVIUDNMWG9MYzlmUElV?=
 =?utf-8?B?WEFnSStDTFJUeStoc3V3TUducUhTRXpFK21FanFFdm1aTFA4NWlOV1V2Nmgv?=
 =?utf-8?B?Wi9OdkQ1YlAzU2ZXT2Nrek9aMTRXSUx6Y1B0MVdQVytXRVp4UlhPREErZHl6?=
 =?utf-8?B?WGdiWHB2emE1SmQ0L0VpMm56VjZTamRRUTEzamdoSWJsdXVqc0dPNWgzbmlK?=
 =?utf-8?B?YVVSRXBKUkNrWjk2ZTdxWUw1YnBwZUJ3M056NUdPYlcwaUtMVjFqS0NGYXZu?=
 =?utf-8?B?dFU2TE1JWXJJLzRWNDQxdFlRSlZqSFJnQnpJOElvSWF5eGtsclZ0Z24vQVd4?=
 =?utf-8?B?dG1CbXdLcHhQSVYveTYxcWhVKzJlc0NqTVdmWUwxL2doRm1weTQ0WFBWOUJv?=
 =?utf-8?B?dVFXRE9ieEVEMFc3MWVOaXNzczhvVGxNN3JQbkY2dE8vdDFpZ3I4WG1mSFJS?=
 =?utf-8?B?U1ZiUXFlN3NaWWhHZGE2VFRTY1hOeEJoeW1WY1VURVd3YjNHMHlna2dHWnp3?=
 =?utf-8?B?TzYyNy94blN2alpncEJyYlJzOTdCU29KREVHS3hoYjlWdFREMWk0ZHVCdXVS?=
 =?utf-8?B?THpLRmtQcERSY2dicGNxbnV2aVE4d0tJTnkwN3FQb3pielBRNkg5aUU5VVVz?=
 =?utf-8?B?ODZqTDcrV1dKdTl4d1h1dFFSWnpaY2d5TWd6ZXFYY2lRTW1lejBMYytnV3Vx?=
 =?utf-8?B?TGdOeis4SWtuemtIUGNIQ1pDOW9lazdQTjRrNncwQ1ZEZWZEN1RmNVhXbS94?=
 =?utf-8?B?MWlZcWIwakYxeXBDNUxPWmt2SUdmbkZvU0lYNnFPNC8veGFYY3Q4Ylp4K2Q4?=
 =?utf-8?B?bE9za3VlTi9BQnYyODQvdzhvaE9sUGxCeU5YMWQxejk4UWZuN2Q4dzN3MmVp?=
 =?utf-8?B?Y1ZHN0RvM2IveHJKOWd3SGVoSzllZlduTysvMVFpZFdsRGJ6eEREaW9uemNu?=
 =?utf-8?B?dEt1TVhUTW9QeUxGckFXRU05TXBPSWp5ZXdjTW14NmlkR0lsbERyY0NBdTNt?=
 =?utf-8?B?UVRHdVl2UlZDRVVjUXpURUdNM2FIU0xIU0RVWnhacW0zODdRV1lHOXR3VEpZ?=
 =?utf-8?B?K3haQVArN25ZVUxkbnZpWjU3UDFUTnJwdWt1OUV0WnNMZEVXaHViWktxYVdq?=
 =?utf-8?B?ZUorTTFsZ2tmaHVYbVBOcjhKL1hoK0NYUTZJNVF6QytDd2Z5MDFhbUhSSUsy?=
 =?utf-8?B?T3FEbUxSZnY4QlpkdWU1RnJRMEMxekZtQU5STnBQSCs5Qm56N255eGxEU3A1?=
 =?utf-8?B?S1lnNlVmc3hwYnNVeEZ3T2piMnAzVktjQ1pjTHlwb2g2N05mWERIcjhnc2NF?=
 =?utf-8?B?WmpoU3k2Qy9SZTliV1N1M0Z0QmlxeklLdHQ3eENPcnNQODlDT0k5c0Foc1k4?=
 =?utf-8?B?R1BpdUpQVEkzSks0NnBvT0p0bEhZMmRGU1FkbkRkcFBBV1FVWW1HdDd1YkU4?=
 =?utf-8?B?TjdDNVc4dE51a3IxWnlNZ0QwMjJvell2MnU4QzBrS3l1MWJGV1EyN2NhNGNN?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F2AC5BEE8D59A44B83DF159022F2613@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6274.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f03547-6e59-460a-ab71-08dab03ed290
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 12:55:09.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9VeQG+i2vicl642C78Zh0Tb5iAtSvWK62Y3XUd1yWXvUAY8FDhc2QD10QhKwpX/lFkXa3liDzcTlzeRR4GV1rooKiQjjvZvJB5K6d7PFVpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTE0IGF0IDEzOjQyIC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgSm9obnNvbiBXYW5nICgyMDIyLTEwLTEzIDA0OjIzOjM0KQ0KPiA+IEFkZCB0aGUg
bmV3IGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3IgTWVkaWFUZWsgZnJlcXVlbmN5IGhvcHBpbmcN
Cj4gPiBhbmQgc3ByZWFkIHNwZWN0cnVtIGNsb2NraW5nIGNvbnRyb2wuDQo+ID4gDQo+ID4gQ28t
ZGV2ZWxvcGVkLWJ5OiBFZHdhcmQtSlcgWWFuZyA8ZWR3YXJkLWp3LnlhbmdAbWVkaWF0ZWsuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEVkd2FyZC1KVyBZYW5nIDxlZHdhcmQtancueWFuZ0BtZWRp
YXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9obnNvbiBXYW5nIDxqb2huc29uLndhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdu
byA8DQo+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+IFJl
dmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vYXJtL21lZGlhdGVrL21lZGlhdGVrLG10ODE4Ni1maGN0bC55YW1sICAgfCA1Mw0KPiA+ICsr
KysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKykN
Cj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtdDgxODYtDQo+ID4gZmhjdGwueWFtbA0KPiA+
IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTg2LQ0KPiA+IGZoY3RsLnlhbWwNCj4gPiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4
MTg2LQ0KPiA+IGZoY3RsLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4
IDAwMDAwMDAwMDAwMC4uNTkxMTE5NDY5NjZjDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKw0K
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRp
YXRlayxtdDgxODYtDQo+ID4gZmhjdGwueWFtbA0KPiA+IEBAIC0wLDAgKzEsNTMgQEANCj4gPiAr
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KPiA+
ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2FybS9tZWRpYXRlay9tZWRp
YXRlayxtdDgxODYtZmhjdGwueWFtbCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IXlmREg0VzE0UGVr
N3czWUJyZGNCQUdqM09TU1dHbFdrOGF2NERtSFQ2OUVqNGF4NzV6S3FweTg5WnZYMVpfYUtEUHp1
JA0KPiA+ICANCj4gPiArJHNjaGVtYTogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFDVFJO
S0E5d01nMEFSYncheWZESDRXMTRQZWs3dzNZQnJkY0JBR2ozT1NTV0dsV2s4YXY0RG1IVDY5RWo0
YXg3NXpLcXB5ODladlgxWjlnUmN6UGkkDQo+ID4gIA0KPiA+ICsNCj4gPiArdGl0bGU6IE1lZGlh
VGVrIGZyZXF1ZW5jeSBob3BwaW5nIGFuZCBzcHJlYWQgc3BlY3RydW0gY2xvY2tpbmcNCj4gPiBj
b250cm9sDQo+IA0KPiBUaGUgZHJpdmVyIHBhdGNoIGlzIGluIGRyaXZlcnMvY2xrIHNvIHdoeSBu
b3QgcHV0IHRoZSBiaW5kaW5nIGluDQo+IGJpbmRpbmdzL2Nsb2NrIGFzIHdlbGw/DQo+IA0KSGkg
U3RlcGhlbiwNCg0KU3VyZSwgSSB3aWxsIG1vdmUgdGhpcyBiaW5kaW5nIGluIHRoZSBuZXh0IHZl
cnNpb24uDQoNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gRWR3YXJkLUpXIFlh
bmcgPGVkd2FyZC1qdy55YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+IA0KPiBbLi4uXQ0KPiA+
ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4g
PiArICAtIGNsb2Nrcw0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+
ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9jbG9jay9tdDgxODYtY2xrLmg+DQo+ID4gKyAgICBmaGN0bDogZmhjdGxAMTAwMGNl
MDAgew0KPiANCj4gSXMgaXQgYSBjbG9jay1jb250cm9sbGVyPyAnZmhjdGwnIGlzbid0IGEgZ2Vu
ZXJpYyBub2RlIG5hbWUuDQo+IA0KDQpUaGlzIG5vZGUgaXMgdXNlZCBmb3IgZGV0ZXJtaW5pbmcg
aWYgUExMcyBhZG9wdCAiaG9wcGluZyIgbWV0aG9kIHRvDQphZGp1c3QgdGhlaXIgZnJlcXVlbmN5
Lg0KSXQgZG9lc24ndCBwcm92aWRlIGFueSBjbG9jayBidXQgYWN0dWFsbHkgY2hhbmdlIHRoZSBi
ZWhhdmlvciBvZiBzb21lDQpQTExzIHdpdGggbmV3IC5zZXRfcmF0ZSBjYWxsYmFjay4NCkRvIHlv
dSB0aGluayB0aGlzIG5vZGUgYWN0cyBsaWtlIG9uZSBraW5kIG9mIGNsb2NrLWNvbnRyb2xsZXI/
DQoNCg0KQlJzLA0KSm9obnNvbiBXYW5nDQo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxODYtZmhjdGwiOw0KPiA+ICsgICAgICAgIHJlZyA9IDwweDEwMDBjZTAwIDB4MjAw
PjsNCj4gPiArICAgICAgICBjbG9ja3MgPSA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfTVNEQ1BM
TD47DQo+ID4gKyAgICAgICAgbWVkaWF0ZWssaG9wcGluZy1zc2MtcGVyY2VudCA9IDwzPjsNCg==
