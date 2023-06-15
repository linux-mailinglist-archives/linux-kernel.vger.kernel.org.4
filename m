Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9297E730EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbjFOGBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbjFOGBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:01:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4829B270C;
        Wed, 14 Jun 2023 23:01:12 -0700 (PDT)
X-UUID: 0481cebe0b4211ee9cb5633481061a41-20230615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/ySML2+jZGuyUSsmVHiXEsiJzTq1XxKiJxdHh56c9iU=;
        b=slM/0qeVbB0xVubtPUY7ggYrXYDgx/lyF2on8riWB2gTXISKJ1jbK7bzTQ2mmoVgLvz7xmkmZtCBBqUzTf9kHdvwJ5qwU9yzjvdDoGv4js3eV6ol0HUWDOG/RoiPj/dQVC1gC6XYMcIIbY1fKVPzqgu7t/U46sRUdhVLBqv4h7U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:e50bfd0d-adbc-4a3f-ab2b-449c45b11110,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:cb9a4e1,CLOUDID:43a3236f-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0481cebe0b4211ee9cb5633481061a41-20230615
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1010303097; Thu, 15 Jun 2023 14:01:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Jun 2023 14:01:05 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Jun 2023 14:01:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFGQhsJ5UM/JrZG+DzEVUtVXdvFdDhD88Ny8XUmRi1Ut4KtkgjAimRV76vEyrByaMBwwBOFFkIADE9yKSGr3Ki+69I167vwpxL3JPmoVJd0rHrXyRnVoFZ9CBo5a1VNvn2UP8RUNTrbVNoZwIWqqZR73Kqn1f6NAkZcDVBfIB0n17fhKZOF8LhF5PJVQjuFEbqdKoBp/vCsyV7fe3X3WYkbdB/z4qk1lF4SjDelKdWtob2CTlSKU6gqgzrGUbovsL8lt+6/TbYKgUsc1xREiuDxQEqoWefYTSFjLPSM7p6WY8dDsNXFxSGBI/nqG/cEfp1+MyqoIC9H3n2SXYcfdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ySML2+jZGuyUSsmVHiXEsiJzTq1XxKiJxdHh56c9iU=;
 b=MLCxYy5/pesJuanHuGhX8QV69qqiLIAGDRjRtcf7bb99jNKCFYilVfuZKLayQksgcI2e+tqieqH+6Q4lDiGbTKjgTybpa7v55Rhu0ZyfMAPZ1nCG+EAb4EZqCbyCMaRxzOt8pKswK4saBUrGueA0YPWsphMWDh4HNplgU6BcEZva6944roeksh53Jlr5oebN8AlXsTHPX/sAnP3r4VHig/xSu3YTk7h31sCpiF1MPAHX8f6KqT3zvg/QIV0Nwp//tC4zw0QNV5ffVoK8iugcDNQC0z60W35ZqkuXdcmNs7VRjPcZhpOjficRxd3PsGGLS+GajzC6eKxvrHIHOG62kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ySML2+jZGuyUSsmVHiXEsiJzTq1XxKiJxdHh56c9iU=;
 b=AUPev0gF6Nv5PgFqtT6VMI1JgYv9PcRR7LYV7hjZv8KUWSzkUnOW+bsis+UjIIf404Iy82KYar4pzU0uYpm/OeZudKpNM2QSqukKDd8cEK3kHE3lIFiNUsI/iiNpTUYQJKfad5DlElKgu/mb5UG9iMCX0Eplb0tOuX9M8LPLOes=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by JH0PR03MB8074.apcprd03.prod.outlook.com (2603:1096:990:35::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 15 Jun
 2023 06:01:02 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66%5]) with mapi id 15.20.6455.039; Thu, 15 Jun 2023
 06:01:02 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 12/15] soc: mediatek: Add MT8188 VDO1 reset bit map
Thread-Topic: [PATCH v2 12/15] soc: mediatek: Add MT8188 VDO1 reset bit map
Thread-Index: AQHZnpJ3psJK5v4HUEGibmYMrpTSh6+KK3eAgAE06YA=
Date:   Thu, 15 Jun 2023 06:01:02 +0000
Message-ID: <4dca96de37b4e6e3321bc304df8bad678edfebc3.camel@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
         <20230614073125.17958-13-shawn.sung@mediatek.com>
         <e4f98dc5-0fa6-14aa-f8d0-e4bf30ecca5c@collabora.com>
In-Reply-To: <e4f98dc5-0fa6-14aa-f8d0-e4bf30ecca5c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|JH0PR03MB8074:EE_
x-ms-office365-filtering-correlation-id: dec51d2b-6f28-44e6-acc0-08db6d65e64c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5TxnZXM5IPfccwnGJVkk32bAZNYecB1H/wQtJ28ytGd3XUaFLApqIpavp78PuA7JzSRYQ1JXzVbkT+bEHDt1rIxRmNwEJ9WjhsREpy98WiHv5rJPQ5fpMO1ZGZNL80sS5pM9Q7H5UBdH8VJGyJPC/W0QDo21fTEjY/FRt0qJPrz52CZPwVqMParVRzbOZIa1zFrzzsRhJMpCmY5RhuPDRoM3Di2yG4GjCfkQbqCfm9GsuRCEA77ck8/5Z+UXwIkHPm3RTWLaATaEHzHZ6PROAL6EUQ3c26zN0r4wdWGB870/Nrodvyf85VLi+yK6c7B7vPSYBTsBXsh/wBWxzEghKnvfteF3EbfKHn4+XWH7T7v/yHoFv2skWgCGan6oEMDF6ajYEfXpfDOCNUfV71gS7BqeJQSy45VBIjl8wpTv2z3Hrt9gO4MFGmFtBzdYQnA8zsLPY842Et2APiBZEvKlrGgnANa7D3tL9Y6P4+a562qTG/GsovA1s6aVEXC4Jrr4mJvFlzvxJ/E6LOZY0epcAnDZ95jNoMZV2Dp4iv4qf3oMjTkK79TYficfBhQait6WR0EY+SPn0Q5Ue7kG7ZAQydRRU6rM287EN0zQ1gEsm9e9RiZcakYPpWyupBDBHsqc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199021)(85182001)(36756003)(86362001)(2906002)(38070700005)(7416002)(38100700002)(64756008)(66476007)(6486002)(83380400001)(6512007)(5660300002)(26005)(6506007)(122000001)(478600001)(186003)(71200400001)(110136005)(54906003)(316002)(66446008)(76116006)(4326008)(41300700001)(2616005)(8936002)(66556008)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFdWcUhyWFlEK2dRUkJVWWJtS1ZjSkFQRmhEYnZ5REprL2FZbUZYYWxOY0dZ?=
 =?utf-8?B?NlBYY2d6K1FkdkVaMXl5TkNBT1JKYm5QUS9ub09nMUZLRjR5d1FXTVNESUhF?=
 =?utf-8?B?YXFPSko2bFUvTkFHY2JIUGJnUlhwQTVzcXlwdFg1WTN0ei9nYXFQSVE5U1ow?=
 =?utf-8?B?TFZTa1BmSjdUQzZLTUljZnBQYkpWa0lrZlVxZkFOUkFvM0dNbzBjRnJmNUFX?=
 =?utf-8?B?SEhVWVRKLzhUcWpiN0REczVHSTBjYndWN0RRbmdHb2ZtY3dBeEUvU3J3R3lm?=
 =?utf-8?B?b0V3YzEySU9SZDUrS1dMU0dRVi90VTVuZTN5WThNSlhST053REpwYWQrMGlU?=
 =?utf-8?B?dHFFZWc5QUYvcGlQSVN1MFdTQ0Fqc2NYU3lVSlpkTXdtemxsazh1VmxvUklo?=
 =?utf-8?B?a3hzNW1JbVdHQ3hLTVhWcDdZVEVzSDdLSEluM3JJWTZ5TUhMTmNaUzJnYkdJ?=
 =?utf-8?B?MXI4TitSMkpvTlJTbDhnMFRwYmVuc3h4MHdibjQ3UC9JZlFuSnF2YmF5ZE52?=
 =?utf-8?B?U0JRRGdnOTlTYndFQmxKZ3BsWEFQbjRNMDdFSkV3emYySVZ5MndiZEZVbElB?=
 =?utf-8?B?SEZhaTdnUElsVW5XSUhFR1ZHZlFsSERCQTZid3E2bjExWkxQRW5WZHY0NGpK?=
 =?utf-8?B?YU80V0w0cUtIMUk2RHhYN1dUeWx5aGxROUZFUlc2ZmlZZUVCaEFTQ1ZmNDlI?=
 =?utf-8?B?UGpTaHRESXNjcXNTajlNUzB4YlluRkJXQkg5MG1yVGpNR2dUZE9NUWdadXk1?=
 =?utf-8?B?bE0yV0hHdXJoa0dKYWVZYUJ6d0lUU1VTUVFZaEtyYWc1Snp4UllYRDA1cjUy?=
 =?utf-8?B?UkxmcVd3a2d0Y01yT25SSStlVXRmdEE5SzZjcE9HWUI0R2JSRW5EQWhhazF4?=
 =?utf-8?B?cStEa2l3Y3BLSUpDMTRtMjhERlRrSTlxdVVrQXFpWERMazZsa0h6OUxsbVpo?=
 =?utf-8?B?Q0VtWlFtaDNoVzBiYTd3bmRsK3VrNzlBa0QxMng2VjhNYldSU3JDK3RTelhR?=
 =?utf-8?B?RUNJQzFCVk80czdZMWJYVWo4c0tCUHJYOWJyUWJ2S1RBdlhtejBEdzMxUXI0?=
 =?utf-8?B?U1BkR2lhRThJTlR4dEZSNlRidGpRYktscWVzZU5VbWhNaHRJRFhONnpEelNv?=
 =?utf-8?B?YUdCNU9VWTkvUG9OOWV3ZFJCdUNWc2F6TDVXV1hXQk9QVzJkVnJIRnkzaU83?=
 =?utf-8?B?MUdrM2FnV2R0Y0tDbGdTdmVINnNHN3JqakJMTVkxWUZVVHdualBTbHBDMVZP?=
 =?utf-8?B?a2Y1Zi91eUdMS1VHd1pWMjg1c3FZQ2lFQkkzNElaQjdtVkpIK0NxbG5ha3Ar?=
 =?utf-8?B?dGZ6K0VuMkVOeU1YVEFYdDhkQm5rM0VrVGdQZmNTVjA4bTNoVGhjN0RZVERu?=
 =?utf-8?B?eDVhUm0rbEh4ZkFrZ1l2Zzd2ZjJSNCtHTm4xeGRGd0FUNVFvWms2b1VJaEZs?=
 =?utf-8?B?cmRvbm42bjZkOWNmMm9wTUF5azNtb1UyaXFWUnVDVnN1cXFSaGRIdEpYRnp5?=
 =?utf-8?B?dFdnQzBidHFaRmh6SkRveDQ3UW1SSE4xakwrMS9nZ0p5anRwV0N2MGt1Vkt0?=
 =?utf-8?B?MjZ3RDU5K1Y1VHBkNTNlY0R3bUptaWV3V0xkeU1LTFdVaUh0VlROaDNnenA0?=
 =?utf-8?B?VDlOVnVjTGFTb05QMWZacG1LQ0w3MmVhR09JQzBNYzRZY00vVFpGYTFnSmlW?=
 =?utf-8?B?S0E1b2t0Ny91UnBpWGxmQ1RWWkZFRE1FUXhLZEkzNE83dDYrSXdEWnVtMWpi?=
 =?utf-8?B?UmExV0Q4RzRJa0svZXRDU2pMVFdQREZYSDF4V1VDbDZUZml0dlJ6TlFJZW1o?=
 =?utf-8?B?cE45RjRpRTdKL1F5RHJDZGlJRVNXakMzSkdUZDRtbzNmYks3YVh4MmRXZXBr?=
 =?utf-8?B?MDFFb3dlaWxhK2J3RDdWczdRVHRqYTlndzRURVNkaGxhbUd6VE1uejJLQUJZ?=
 =?utf-8?B?emZWWFpJVWppZGJYZzE2emcxbzRLWms1bnAwTWc3RUNNaFFxUXBoKzFRQjNk?=
 =?utf-8?B?ZVkxSGVLc2M1Mnp6ZE5lTXBEVkFBWjJ2ZnV1TUR2eDk1eEpmRmlXLzcwdThT?=
 =?utf-8?B?WFVMSXFrZnE2Y1FMcW40ZE1SVThEbGJ5TmF4WUMyb2R6WVFMdXdCNXo3QkxW?=
 =?utf-8?B?SnNiSUxrbUNHb010ellrRWFOcHQ5OWtCRHlyVkdMQUlFb2VRVWFpWU9VdHIr?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <401B5BE5DBF56E41834A876A12910102@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec51d2b-6f28-44e6-acc0-08db6d65e64c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 06:01:02.5932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvbDrK/FRLl/BcL6XKlcJxzz3hExSkHbYEJKIUFC2/k/I8U3UHwAwZtR5RTXIWncvK947t5+gByin+qEV2UzBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpHb3QgaXQuIFdpbGwgZml4IHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbi4N
Cg0KQWRkZWQgYSBuZXcgZGVmaW5lIGluIG10ay1tbXN5cy5oOg0KI2RlZmluZSBNTVNZU19SU1Rf
TlIoYmFuaywgYml0KSAoKGJhbmsgKiAzMikgKyBiaXQpDQoNCkFuZCBkZWZpbmUgdGhlIHJlc2V0
IHRhYmxlIGFzOg0Kc3RhdGljIGNvbnN0IHU4IG1tc3lzX210ODE4OF92ZG8xX3JzdF90YltdID0g
ew0KICAgICAgICBbTVQ4MTg4X1ZETzFfUlNUX1NNSV9MQVJCMl0gICAgICAgICAgID0gTU1TWVNf
UlNUX05SKDAsIDApLA0KICAgICAgICAuLi4NCiAgICAgICAgW01UODE4OF9WRE8xX1JTVF9WUFBf
TUVSR0UyXSAgICAgICAgICA9IE1NU1lTX1JTVF9OUigwLCAxMSksDQogICAgICAgIFtNVDgxODhf
VkRPMV9SU1RfVlBQX01FUkdFM10gICAgICAgICAgPSBNTVNZU19SU1RfTlIoMSwgMCksDQogICAg
ICAgIC4uLg0KICAgICAgICBbTVQ4MTg4X1ZETzFfUlNUX0RJU1BfUlNaM10gICAgICAgICAgID0g
TU1TWVNfUlNUX05SKDEsIDMxKSwNCiAgICAgICAgW01UODE4OF9WRE8xX1JTVF9IRFJfVkRPX0ZF
MF0gICAgICAgICA9IE1NU1lTX1JTVF9OUigyLCAwKSwNCiAgICANCi4uLg0KICAgICAgICBbTVQ4
MTg4X1ZETzFfUlNUX0hEUl9WRE9fQkVfRExfQVNZTkNdID0gTU1TWVNfUlNUX05SKDIsIDIzKSwN
Cn07DQoNClRoYW5rcywNCkhzaWFvIENoaWVuIFN1bmcNCg0KT24gV2VkLCAyMDIzLTA2LTE0IGF0
IDEzOjM1ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gIAkgDQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+ICBJbCAxNC8wNi8yMyAwOTozMSwgSHNpYW8gQ2hpZW4gU3VuZyBoYSBzY3JpdHRvOg0K
PiA+IEFkZCBNVDgxODggVkRPMSByZXNldCBiaXQgbWFwLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXQ4MTg4LW1tc3lzLmggfCA1Nw0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1t
c3lzLmMgICAgfCAgMyArLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ODE4OC1tbXN5cy5oDQo+IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXQ4MTg4LW1tc3lz
LmgNCj4gPiBpbmRleCBjM2UzYzVjZmU5MzEuLjIwOGQ0ZGZlZGMxYSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdDgxODgtbW1zeXMuaA0KPiA+ICsrKyBiL2RyaXZlcnMv
c29jL21lZGlhdGVrL210ODE4OC1tbXN5cy5oDQo+ID4gQEAgLTE0NCw2ICsxNDQsNjMgQEAgc3Rh
dGljIGNvbnN0IHU4IG1tc3lzX210ODE4OF92ZG8wX3JzdF90YltdID0gew0KPiA+ICAgW01UODE4
OF9WRE8wX1JTVF9ESVNQX1JTWjBdPSAzMSwNCj4gPiAgIH07DQo+ID4gDQo+ID4gK3N0YXRpYyBj
b25zdCB1OCBtbXN5c19tdDgxODhfdmRvMV9yc3RfdGJbXSA9IHsNCj4gPiArW01UODE4OF9WRE8x
X1JTVF9TTUlfTEFSQjJdPSAwLA0KPiA+ICtbTVQ4MTg4X1ZETzFfUlNUX1NNSV9MQVJCM109IDEs
DQo+ID4gK1tNVDgxODhfVkRPMV9SU1RfR0FMU109IDIsDQo+ID4gK1tNVDgxODhfVkRPMV9SU1Rf
RkFLRV9FTkcwXT0gMywNCj4gPiArW01UODE4OF9WRE8xX1JTVF9GQUtFX0VORzFdPSA0LA0KPiA+
ICtbTVQ4MTg4X1ZETzFfUlNUX01EUF9SRE1BMF09IDUsDQo+ID4gK1tNVDgxODhfVkRPMV9SU1Rf
TURQX1JETUExXT0gNiwNCj4gPiArW01UODE4OF9WRE8xX1JTVF9NRFBfUkRNQTJdPSA3LA0KPiA+
ICtbTVQ4MTg4X1ZETzFfUlNUX01EUF9SRE1BM109IDgsDQo+ID4gK1tNVDgxODhfVkRPMV9SU1Rf
VlBQX01FUkdFMF09IDksDQo+ID4gK1tNVDgxODhfVkRPMV9SU1RfVlBQX01FUkdFMV09IDEwLA0K
PiA+ICtbTVQ4MTg4X1ZETzFfUlNUX1ZQUF9NRVJHRTJdPSAxMSwNCj4gPiArW01UODE4OF9WRE8x
X1JTVF9WUFBfTUVSR0UzXT0gMzIgKyAwLA0KPiANCj4gV29ya3MsIGJ1dCB0aGVyZSdzIGEgYmV0
dGVyIHdheS4NCj4gDQo+IDMyICsgMCBtZWFucyB0aGF0IHlvdSdyZSB1c2luZyByZXNldCBTVzEg
cmVnaXN0ZXIsIHNvIHlvdSBjYW4gZG8NCj4gDQo+ICNkZWZpbmUgTVQ4MTg4X01NU1lTX1JTVF9O
Ul9QRVJfQkFOSzMyDQo+ICNkZWZpbmUgTVQ4MTg4X1JTVF9TVzFfT0ZGU0VUTVQ4MTg4X01NU1lT
X1JTVF9OUl9QRVJfQkFOSw0KPiAjZGVmaW5lIE1UODE4OF9SU1RfU1cyX09GRlNFVE1UODE4OF9N
TVNZU19SU1RfTlJfUEVSX0JBTksgKiAyDQo+IA0KPiBbTVQ4MTg4X1ZETzFfUlNUX1ZQUF9NRVJH
RTNdID0gTVQ4MTg4X1JTVF9TVzFfT0ZGU0VUICsgMA0KPiBbTVQ4MTg4X1ZETzFfUlNUX1ZQUF9N
RVJHRTRdID0gTVQ4MTg4X1JTVF9TVzFfT0ZGU0VUICsgMA0KPiAuLi4uLi4uDQo+IFtNVDgxODhf
VkRPMV9SU1RfSERSX1ZET19GRTBdID0gTVQ4MTg4X1JTVF9TVzJfT0ZGU0VUICsgMA0KPiAuLi5l
dGMNCj4gDQo+IFJlYWRpbmcgdGhpcyB3aWxsIG1ha2UgaXQgY2xlYXIgdGhhdCBhIGNlcnRhaW4g
cmVzZXQgYml0IGlzIGluIGENCj4gZGlmZmVyZW50DQo+IChzZXF1ZW50aWFsIG9yIG5vdCkgcmVn
aXN0ZXIuDQo+IA0KPiBQLlMuOiBJZiB0aGUgUlNUX05SX1BFUl9CQU5LIGlzICpub3QqIE1UODE4
OCBzcGVjaWZpYyAoYXMgaW4sIGFsbA0KPiByZXNldCByZWdpc3RlcnMNCj4gZm9yIGFsbCBTb0Nz
IGFyZSBhbHdheXMgMzIgYml0cywgd2hpY2ggSSBiZWxpZXZlIGlzIHRydWUpLCB5b3UgY291bGQN
Cj4gbW92ZSB0aGF0DQo+IGRlZmluaXRpb24gdG8gbXRrLW1tc3lzLmggYXMNCj4gICAgICAgICNk
ZWZpbmUgTU1TWVNfUlNUX05SX1BFUl9CQU5LMzINCj4gYW5kIHRoZW4gZGVmaW5lIHRoZSBvZmZz
ZXRzIGluIG10ODE4OC1tbXN5cy5oIGFzDQo+ICAgICAgICAjZGVmaW5lIE1UODE4OF9SU1RfU1cx
X09GRlNFVCBNTVNZU19SU1RfTlJfUEVSX0JBTksNCj4gICAgICAgIC4uLi4gZXRjDQo+IA0KPiBU
aGFua3MsDQo+IEFuZ2Vsbw0KPiANCj4gDQo=
