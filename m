Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4165F5EC2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 04:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJFCik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 22:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFCih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:38:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E906876AE;
        Wed,  5 Oct 2022 19:38:35 -0700 (PDT)
X-UUID: c5bde76a0c50423a9eb7871c8596edb2-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qldCTRNf3IAETGBa2mlJz6pT2FiY+OMCCKZoNsyhx9M=;
        b=awbRdvEu5F/FzrcOUnO/hmw8JWQ3mNcR22gl6+eFCIA68CSskEBvP9hx30Qix1Na3hXnIUemR9zXgwl2CM+XiJY2j7Gc0RxKif8EhKfJE+hexyVD8VLgq3bOVdP7ugsF8IfSMbLVg6+SOeon82WhmuDCPkpNhx/ft/bpJdJAzNs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:936eea39-603b-4b39-a241-8a912145d0c4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:7ed2a785-5312-4339-9a65-dc27c4b243b8,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c5bde76a0c50423a9eb7871c8596edb2-20221006
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1121531982; Thu, 06 Oct 2022 10:38:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 6 Oct 2022 10:38:28 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 6 Oct 2022 10:38:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0sdOKWWmUnwboOLiTGn/oZyFKi1P50Loyk2gVI8wpdDynv7XxIeLchkB65+e+wfbQuawLBt1+p3ZVKs7o8Yl6iZrVq+3z8zyyuCzGW+8tc3nqqMgr/NhGmRVrUB2541HSCUR4a+0AOOJHEPGhVmj1AiWuFNHQgVbIXF7CYmb6SWWDW3UtZHMaXGJAB9rVlbdDBYu7t2PZZ6hWQH7T4HIHamRPN4BkGTnEJ6jxERWnmRwG5ZRU4ijYfd6vVskv5sjvDrJLygOnVbGBDsDkRpQO32MBG/YHTVseodKsuWyCBuvEDLwd023S515wb/cvWwSssgXZdeZDma70zMwfFY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qldCTRNf3IAETGBa2mlJz6pT2FiY+OMCCKZoNsyhx9M=;
 b=RO9om4zSL6lpBpoVxjHeqb9FsxU6PMZVyCjEhJMKPpZjb/ouC5Ru6Hddz07pMM/MJDJdddbCGPhBUoxziNYfQzf8DtTBN3GZSQ5SlDPAZ5UezxmoQT+y7zIZNsH4L7eiU6U8nH1hZNAanz5qGxutd6z6QaxgfK3Cli/ygtxgfIBO5FbRRBBAB9CEO3am4e0CSzTRsFKKPP+dAL8+CBzNvDQgqYcskyWDQPTb1jYlF2BPtJF+TxHJnNVJFahQTwT8xNRVzjrAa/1YjtmBV2H9ex5bEb6f/UmxS9u0zINSpU/ykaHyZpWKOBty/V7dmfPbp8ghHseihU7+7sdRDCU4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qldCTRNf3IAETGBa2mlJz6pT2FiY+OMCCKZoNsyhx9M=;
 b=mBBcwJoXIqkfqLjC9VUyVruVySFwA0Zdb+Th3hS3JD+CtbUOL1ycLNt5Mif/HYfLl+1dGJZrg5m6dhNqC8UInRtdiBbwvk92Sj2+mGLynFI7JcXVCoHKmISOS1S+XJesKvPy7QB/7EPE4FyTcCsB85AspTaK6rCaf93eDWoO8rM=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by PUZPR03MB6048.apcprd03.prod.outlook.com (2603:1096:301:b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.4; Thu, 6 Oct
 2022 02:38:27 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3035:799a:e0e2:26ff]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3035:799a:e0e2:26ff%3]) with mapi id 15.20.5676.014; Thu, 6 Oct 2022
 02:38:26 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 12/12] dt-bindings: mediatek: mt8188: add mt8188-mt6359
 document
Thread-Topic: [PATCH 12/12] dt-bindings: mediatek: mt8188: add mt8188-mt6359
 document
Thread-Index: AQHY1Nz5OA9S/sIRuESL8yXlzp3JUa3844KAgAPMLoA=
Date:   Thu, 6 Oct 2022 02:38:26 +0000
Message-ID: <e96ef77f007f66f883f8dca86d1206cd1b5a767a.camel@mediatek.com>
References: <20220930145701.18790-1-trevor.wu@mediatek.com>
         <20220930145701.18790-13-trevor.wu@mediatek.com>
         <20221003163851.GA2414624-robh@kernel.org>
In-Reply-To: <20221003163851.GA2414624-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|PUZPR03MB6048:EE_
x-ms-office365-filtering-correlation-id: e40f6af7-24f4-4a91-52f9-08daa743d8a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i1Wd2YTnUOStqf4fF8WC8TuKx2tIF+jwBAJba5zrZSPz/WIl+FF2lQvqS2lvlGjgMf520+n/q/CGZxY2Yd4C3MzYurss/yuD0TtA7zkdDLQbaVme68aBW2umhI44TbUugYiBaJ3LEsDC8dHjlbbczFWzHxvv5cKo9DSbX/gHYxkWC/eMg3sSRr+ob+EJY21CHRn2OolWg5b9sMa6h+2re6+IImwxAcz7GOFGUVeSCV1EssMKneOTi4+/n1UvGsiBa9Fv3kB11bcnj0oCf5qVBKjzPfmFFg/J1JDMJ8dywWBChb51W7L7rSUvrO/1ilVTKZGoUzXQ1JAzmYzz2smIPvkSflT6X6aI8bA+JO1JdYEOqou5poTCjQcM1gAZkfvtwr060WkF14h3PNro0gcwaG8tYYBMOHMqEYFxXWJu30pYkp+WPqDXCBwvkH10T9WVDUrjTDKKwkTNkUU93tTIX1MN7ydomwrhNctjItJKvUEdmAP0sewmIMvKjL8b6rexyji8IqhWy9wd3/WoaePpPtpt/6g5rP42BzYbLb0BqP0H/ZYYmp7SgMPiBSL4bvQYLs6hxSbDEgXV/Ijwhr2yFTX9C7v3LN5LTuW7yYk4HGP01p9JuFkk8MzK9ZfJPDcGpZkKyRFQZG8dRvYdnVsJlkPmBma/xNFMkk02TjcjT6cye1OczvFcmY5+dI8q9YluaZ3eX8BmRyl4ih1+NkCi/ne0rT5mF7IlUI0TlmKqMi1o3ylmmR6tAl/8Ebho7eKmr18aEYY0myhuoX5mbCY5RsCsPsvJoRtW3vWFxeiJTr25bt9Dc1WfDE6d/VUnVF2sY4xZg4XQ8KT7+hlR1k1vlRM0MmR72z/v3Gcy8uv7Uqs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(66946007)(38070700005)(64756008)(91956017)(76116006)(38100700002)(66446008)(66476007)(122000001)(26005)(66556008)(6916009)(4326008)(8676002)(316002)(6512007)(6506007)(2616005)(54906003)(186003)(36756003)(85182001)(8936002)(6486002)(966005)(478600001)(71200400001)(86362001)(7416002)(5660300002)(2906002)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVFhTDNxdldWVWRJSy9QOUxrVGJ4T2Y2a1ZKaUFBNytXcmFaK2pycTRDckRK?=
 =?utf-8?B?a0M0aFVKQmZ2U05wTkMyTXBIbzdQSjgwQTFsNTZ3bGF6ZXRFV2lEREJzeTJ4?=
 =?utf-8?B?azQrY3diSDlRMVV0ZzFaNksyaHpRNkh6UFBIOG1hYUZMS2IzVHRuZkhtYjlC?=
 =?utf-8?B?Mi9YMktmSnRoUm0yQjZ1OHM0eC8vdTFId0s0MGowcDdhM214ZjRKVkRORUI5?=
 =?utf-8?B?VzVaRGlub2dibFl6a1p6SUR1cVI5S2tka2xBemYzSTZXUWNOaHQ5QVViaEl0?=
 =?utf-8?B?ZE9kbXNqQ3FNQkFTeEhBT1ZnNWJhTkVyMGZiNjcxcFFjUFdlRkNxNk55UzFw?=
 =?utf-8?B?UEFBZWpnNmJmNW5PNVEzdWVZVm9QL1VLbGd6YUNraXdJMU81ekFFbFNRTlJk?=
 =?utf-8?B?TmM4clZhTHJhQVJ2TUJCNCtwT1MvNVlqRGFkTjRvbHlhNWwya2Q2cGNyRkk5?=
 =?utf-8?B?QUtndkpobjE2eWprWlJkRnAzTDZ1d0h1b0lXK3pHNHpoVGdiZ0tnZ3puYThn?=
 =?utf-8?B?azRDZTM0MkF2QTdQVUo5OE9jaXYrREQrMTVqaUlzTUdaeWZwOHZCNSs0YmhC?=
 =?utf-8?B?TVcraXhrN0ZvcTFOY3FRdkQwdTJuYmRJZXJLaHNpVExZTkc5RzE3V3JsRGIw?=
 =?utf-8?B?ZjVuNHVNNWJua3YzT1ZFNzQxbldmZ3JLQzYva3VkS1dHUTFXUWp1WU13OW9q?=
 =?utf-8?B?TFJkRldpbjhCcXhOU0twWkxMNHFmVVBqVjVxcVllUk82YVJaVnVMdW5FOHlH?=
 =?utf-8?B?Nlo1QkxkaHdmSDkzcE1ac1V5WVRlY3VPUnUwSmFMRXM3VkxVNHh2OGNzV01l?=
 =?utf-8?B?Qnhwb1Q1a1BJd01EOU1sL3R0OUlyYmVKK0tmaTRub2RBZHg4MEpkMmdZWVVp?=
 =?utf-8?B?MU1HZkZNVnp4cEZLNmczVG0wUzhFTmE1ZnIrbDlIeitlSHJ0UzJBL0NZcW9F?=
 =?utf-8?B?SGhjdmZaVC9pWXJKZjkvN1NEaUwxNnhEWjFhQUc3cWtSY0cvVmNNZnlDaldV?=
 =?utf-8?B?UzNNN2lCdHQxcEMwMHhDMzhEdXdtaEszQlJZY1E5Vkx6bkNoaVFnWVVNMHVN?=
 =?utf-8?B?RWV2L2o4UjkxYkQ0dG53ZkMzSS9iZzQ2M1NPdURMRkJ5WFRhcUxnSEg5d1FS?=
 =?utf-8?B?bVJPcTZ1RUdrNTFWbElZOFgvZGVIOUluek9UeGVramVFVjhqVE1zSmNSRDA3?=
 =?utf-8?B?dml1dnpOdjZ4dDZoT2hlclMvaHpvV2FOOXhnM1BHY3RKemNZR1ZSYTd0OEND?=
 =?utf-8?B?RGhudmFleGlKMzFVcnpQUlU3R1RZVXV2Y1pKZmhrNHphSUZxajcvVGJkcFZP?=
 =?utf-8?B?YSs3UmlUZytjMnhmcFZRam80NC9jVllWRmNIUmg4bnNCY2FsekxtOE9rcXdD?=
 =?utf-8?B?TCtxVjZ5QksyVlRXdlJKWjM3SVRJa25DdEFBUERDclk3YmF3bW1MNUxRZVZh?=
 =?utf-8?B?dC9KZkxqeXJrbDdoa2xuQ2RVQ2o1dHd6ckZieWZ5Tk9GQ1NPMXVPY1diRHRG?=
 =?utf-8?B?dDVpQms5cEdSMEIvRDgrR281T0NicjV0Y3h6SC9Kb1c4ekszZGtvc1BDU21U?=
 =?utf-8?B?dFUrNTB4V3haMSs1QjRFSXcwcWNNYVhvOTdWYmU2dlVqTHQwdDMrckExWDdS?=
 =?utf-8?B?RHVwdk15aVpmNWlUdi83dnk3UVFaQzBYcWVibUxZOWpab0l0VXd6NHlCUG45?=
 =?utf-8?B?TWtCTlFGU1B2aHM1SW5ibmFoTnJqNEFoUzlFeXA1R0NFOG5DSE1JVkRjYXNF?=
 =?utf-8?B?cE5wdmVZU1NUa3FQeXR6Y2l4MEJ1NlBJVXpHWUc4U091OVJPM3NpNUV6aStD?=
 =?utf-8?B?ZHl3Y044RzYxTWwyUXdObU1NQ1l1RnRaSlAvbnVQNUJib2kyN1JadTY4SGhk?=
 =?utf-8?B?NE9TNEZhbHV2b2taWmZGUFA4ZGZjOGs1dXh5UzBqSUpqWE1YRGZ3K2hzTW9x?=
 =?utf-8?B?OU11Q1FUeDdaYkxIUUZCZUxCVDZudVpFSGdISmFTT2pLR1NaRkVyd2l2cW5O?=
 =?utf-8?B?WkpScmNVNXIrWmZrT09Zb1owcnlDSFU0bTd2dkVyZldUSHV2L0JWckVPNHh6?=
 =?utf-8?B?cUpqQU4vOGlSazdETDJMQTRmQWNyR1Z1UXVsZk55RXN5cGFCb0cycHVRM2Mw?=
 =?utf-8?B?U05ZL011NXdwNndFRXhhemdYN1ZsV0t0K2VCZkRPaXI5eHJRVU0wQ0NKVlF6?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5839672DB8045D418B5595C79D8300D2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40f6af7-24f4-4a91-52f9-08daa743d8a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 02:38:26.5682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpkR7uaAROi4zd3DAjkRaWjkhVpb2tLdDPWH5Rwi7dhaC8RaC2HeDOYfviiFWK8Z+K4rWd7i+rAM1G/yiI1vng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6048
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDExOjM4IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gRnJpLCBTZXAgMzAsIDIwMjIgYXQgMTA6NTc6MDFQTSArMDgwMCwgVHJldm9yIFd1IHdyb3Rl
Og0KPiA+IEFkZCBkb2N1bWVudCBmb3IgbXQ4MTg4IGJvYXJkIHdpdGggbXQ2MzU5Lg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFRyZXZvciBXdSA8dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3NvdW5kL210ODE4OC1tdDYzNTkueWFtbCAgICAgICAg
IHwgNzANCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3MCBp
bnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ4MTg4LQ0KPiA+IG10NjM1OS55YW1sDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgx
ODgtDQo+ID4gbXQ2MzU5LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c291bmQvbXQ4MTg4LQ0KPiA+IG10NjM1OS55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjU3YzdjNWNlZWY4YQ0KPiA+IC0tLSAvZGV2L251bGwN
Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ4MTg4
LW10NjM1OS55YW1sDQo+ID4gQEAgLTAsMCArMSw3MCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4y
DQo+ID4gKy0tLQ0KPiA+ICskaWQ6IA0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb3VuZC9tdDgxODgtbXQ2MzU5LnlhbWwqX187
SXchIUNUUk5LQTl3TWcwQVJidyF3TWM2STJhWFJ6STQ1VVBRVEVBelU0WnVqVjZWYWlGR2tpS0J5
MThBXzVEbFFlaFR4VTAwdTFRU3BpT3pnQWdLdEEkDQo+ID4gIA0KPiA+ICskc2NoZW1hOiANCj4g
PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL21ldGEt
c2NoZW1hcy9jb3JlLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyF3TWM2STJhWFJ6STQ1VVBR
VEVBelU0WnVqVjZWYWlGR2tpS0J5MThBXzVEbFFlaFR4VTAwdTFRU3BpTVNLUFdidFEkDQo+ID4g
IA0KPiA+ICsNCj4gPiArdGl0bGU6IE1lZGlhVGVrIE1UODE4OCBBU29DIHNvdW5kIGNhcmQgZHJp
dmVyDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIFRyZXZvciBXdSA8dHJldm9y
Lnd1QG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFRoaXMg
YmluZGluZyBkZXNjcmliZXMgdGhlIE1UODE4OCBzb3VuZCBjYXJkLg0KPiA+ICsNCj4gPiArcHJv
cGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgZW51bToNCj4gPiArICAgICAg
LSBtZWRpYXRlayxtdDgxODgtc291bmQNCj4gPiArDQo+ID4gKyAgbW9kZWw6DQo+ID4gKyAgICAk
cmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9zdHJpbmcNCj4gPiArICAgIGRl
c2NyaXB0aW9uOiBVc2VyIHNwZWNpZmllZCBhdWRpbyBzb3VuZCBjYXJkIG5hbWUNCj4gPiArDQo+
ID4gKyAgYXVkaW8tcm91dGluZzoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwj
L2RlZmluaXRpb25zL25vbi11bmlxdWUtc3RyaW5nLWFycmF5DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjoNCj4gPiArICAgICAgQSBsaXN0IG9mIHRoZSBjb25uZWN0aW9ucyBiZXR3ZWVuIGF1ZGlvIGNv
bXBvbmVudHMuIEVhY2gNCj4gPiBlbnRyeSBpcyBhDQo+ID4gKyAgICAgIHNpbmsvc291cmNlIHBh
aXIgb2Ygc3RyaW5ncy4gVmFsaWQgbmFtZXMgY291bGQgYmUgdGhlIGlucHV0DQo+ID4gb3Igb3V0
cHV0DQo+ID4gKyAgICAgIHdpZGdldHMgb2YgYXVkaW8gY29tcG9uZW50cywgcG93ZXIgc3VwcGxp
ZXMsIE1pY0JpYXMgb2YNCj4gPiBjb2RlYyBhbmQgdGhlDQo+ID4gKyAgICAgIHNvZnR3YXJlIHN3
aXRjaC4NCj4gPiArDQo+ID4gKyAgbWVkaWF0ZWsscGxhdGZvcm06DQo+ID4gKyAgICAkcmVmOiAi
L3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZSINCj4gDQo+IERvbid0IG5l
ZWQgcXVvdGVzLg0KDQpIaSBSb2IsDQoNCldoaWNoIG9uZSBhcmUgeW91IGV4cGVjdGVkPw0KMS4g
cmVtb3ZlIHRoZSBsaW5lDQoyLiAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy9waGFuZGxlDQoNCj4gDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgb2YgTVQ4
MTg4IEFTb0MgcGxhdGZvcm0uDQo+ID4gKw0KPiA+ICsgIG1lZGlhdGVrLGRwdHgtY29kZWM6DQo+
ID4gKyAgICAkcmVmOiAiL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZSIN
Cj4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBvZiBNVDgxODggRGlzcGxheSBQb3J0
IFR4IGNvZGVjIG5vZGUuDQo+ID4gKw0KPiA+ICsgIG1lZGlhdGVrLGhkbWktY29kZWM6DQo+ID4g
KyAgICAkcmVmOiAiL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZSINCj4g
PiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBvZiBNVDgxODggSERNSSBjb2RlYyBub2Rl
Lg0KPiA+ICsNCj4gPiArICBtZWRpYXRlayxkYWktbGluazoNCj4gPiArICAgICRyZWY6IC9zY2hl
bWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0cmluZy1hcnJheQ0KPiA+ICsgICAgZGVzY3Jp
cHRpb246DQo+ID4gKyAgICAgIEEgbGlzdCBvZiB0aGUgZGVzaXJlZCBkYWktbGlua3MgaW4gdGhl
IHNvdW5kIGNhcmQuIEVhY2gNCj4gPiBlbnRyeSBpcyBhDQo+ID4gKyAgICAgIG5hbWUgZGVmaW5l
ZCBpbiB0aGUgbWFjaGluZSBkcml2ZXIuDQo+IA0KPiBOYW1lcyBoYXZlIHRvIGJlIGRlZmluZWQg
aGVyZS4NCj4gDQpPSywgSSB3aWxsIGFkZCBlbnVtIGhlcmUgZm9yIGxpc3RpbmcgYWxsIGF2YWls
YWJsZSBkYWktbGlua3MuDQoNClRoYW5rcywNClRyZXZvcg0KDQo+ID4gKw0KPiA+ICthZGRpdGlv
bmFsUHJvcGVydGllczogZmFsc2UNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29t
cGF0aWJsZQ0KPiA+ICsgIC0gbWVkaWF0ZWsscGxhdGZvcm0NCj4gPiArDQo+ID4gK2V4YW1wbGVz
Og0KPiA+ICsgIC0gfA0KPiA+ICsNCj4gPiArICAgIHNvdW5kOiBtdDgxODgtc291bmQgew0KPiA+
ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXNvdW5kIjsNCj4gPiArICAg
ICAgICBtZWRpYXRlayxwbGF0Zm9ybSA9IDwmYWZlPjoNCj4gPiArICAgICAgICBwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiOw0KPiA+ICsgICAgICAgIHBpbmN0cmwtMCA9IDwmYXVkX3BpbnNfZGVm
YXVsdD47DQo+ID4gKyAgICAgICAgYXVkaW8tcm91dGluZyA9DQo+ID4gKyAgICAgICAgICAgICJI
ZWFkcGhvbmUiLCAiSGVhZHBob25lIEwiLA0KPiA+ICsgICAgICAgICAgICAiSGVhZHBob25lIiwg
IkhlYWRwaG9uZSBSIiwNCj4gPiArICAgICAgICAgICAgIkFJTjEiLCAiSGVhZHNldCBNaWMiOw0K
PiA+ICsgICAgfTsNCj4gPiArDQo+ID4gKy4uLg0KPiA+IC0tIA0KPiA+IDIuMTguMA0KPiA+IA0K
PiA+IA0K
