Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52809654CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiLWHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLWHgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:36:42 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024B3C31;
        Thu, 22 Dec 2022 23:36:40 -0800 (PST)
X-UUID: bdff983869e34a099af03ee73dca7afc-20221223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WTY/Hr4y8kPPCNs3pmSBSpkwC7qVwby2vSke73+sOcY=;
        b=S/9kEsFDzeYE1Vsj14gz0rvVTj5/rDBhBqDZKQKUd2TmTXzHKXIIx0ow8+l299CINvLYtfXdIer/W1kBzpYD1WBgfP0zNMsz4j/+mk3y8XVEI581bGwyPlA/D+XluWeNONBj5CFJkAXu0nIwfCzNU8rhO7n9LbIFmwY3WJw/rPQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:67d99861-8f8c-42f8-a565-5a7ca176c812,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:67d99861-8f8c-42f8-a565-5a7ca176c812,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:cd18c2f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:221223153544OTSTCQ1W,BulkQuantity:2,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0
X-UUID: bdff983869e34a099af03ee73dca7afc-20221223
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <garmin.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1022923664; Fri, 23 Dec 2022 15:36:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Dec 2022 15:36:35 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 23 Dec 2022 15:36:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfLfXjw1L2imOLkp1P4IKGZHIQ1bJMfdCOwMPsMsYj+2mwXPaHqpuoUsruV0guAKJ1m+M1o/WAy0c7YbOiIET6Ww5ICipWfadH5/sBu14QPLrgdgpPD3yJ7ueRuT1Dp7AyGIq6/RXxs1drA7GCmT5dpPlXY2vI9gUE92/dUrghwlmiXgpqD/pCXbZ73WjQ3GDngb4EgSyCXb+CA/72bfH4P6hx0G9NXjOw5uUsiXRXsbPr8GUrwMKJl8cLpmG0fMvXVnjfSMpYnP1NYDplGDUxNsdMIPqpskRJ48SaROrO1iOvHfcDtuPps/fc9JHu+1LSev1QBrm6LZhu+VYvry0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTY/Hr4y8kPPCNs3pmSBSpkwC7qVwby2vSke73+sOcY=;
 b=lH9lRDtkhL7tjC6uivH+gUpq/wSWhPb9kAO3Qnv7NfD18+G4YbIXoyKsLEtOs9ytVBfuybqQhl8OlzgIEeddlWvh+t1MXyAinhKWEwkzwp6WAqbJjjbFQ3Mb8f9y+E0CySQh5zEx3AEH9KBheLy7QDsUAVW4L9wpuxAZ5Xq5G99f9CPmFpCzU0rYupypp6ieA37HocbWngYfT8bw8IlzC8vtCca7ivtzwPunnyvSiZyANWlfWl8BMVX/nxkHt0dbSoKPgDYfK07CYh2JS+/tF0fPMGO973HemprgSt92j9YJycxFe5uWzFDuPPjpaH/gJ7SPtrjxbPBUwrPRKmbd2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTY/Hr4y8kPPCNs3pmSBSpkwC7qVwby2vSke73+sOcY=;
 b=j/rrZwt/n2ssMyM83mFSLSMSl/TvxGYWKko69oL5ARsKKCJReFFhIpKJzS+WMqNtviExK3DPmkC1049t33S6iC8p2HT8iysJZTeRyzsT4JL2H3y8tS4yQ2vExodzGUr9spvtzntokHih3dWITTT++yTM7J34Q65flwxPLd5/CdU=
Received: from SI2PR03MB5888.apcprd03.prod.outlook.com (2603:1096:4:145::6) by
 PSAPR03MB6233.apcprd03.prod.outlook.com (2603:1096:301:9a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Fri, 23 Dec 2022 07:36:33 +0000
Received: from SI2PR03MB5888.apcprd03.prod.outlook.com
 ([fe80::914:6297:ee3:511e]) by SI2PR03MB5888.apcprd03.prod.outlook.com
 ([fe80::914:6297:ee3:511e%9]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 07:36:33 +0000
From:   =?utf-8?B?R2FybWluIENoYW5nICjlvLXlrrbpipgp?= 
        <Garmin.Chang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 03/19] clk: mediatek: Add MT8188 topckgen clock support
Thread-Topic: [PATCH v2 03/19] clk: mediatek: Add MT8188 topckgen clock
 support
Thread-Index: AQHY540TZk2B4FEXgkWA/rcrAxO7tq4h6wEAgFmIcgA=
Date:   Fri, 23 Dec 2022 07:36:33 +0000
Message-ID: <7879a712e8009659e4e911d165482389da149912.camel@mediatek.com>
References: <20221024094254.29218-1-Garmin.Chang@mediatek.com>
         <20221024094254.29218-4-Garmin.Chang@mediatek.com>
         <875b601c-bc41-2d6b-2e93-4c98e3b6c371@collabora.com>
In-Reply-To: <875b601c-bc41-2d6b-2e93-4c98e3b6c371@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5888:EE_|PSAPR03MB6233:EE_
x-ms-office365-filtering-correlation-id: ad3587b7-8341-4fb3-7506-08dae4b86a14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HgabY6u6jLMXiiuV0hn7wl5QN0jGiSoX3pr3uNLFkHZkoVDCsGNBpJAjkc3LUHiHet959nqezuoBJa9KuAiW4iy7Eu99NCUT43Sdfkt+/KAA6BZFlHgQx2GhoxqfcxtC34wWJMLOFHgciZ2cPPOy9OFjFj8z08jC4G7aLMVccKUc+9LYArFMT4nwZUilGgYrLfxVVNOj7si62BJqtaPrn7z/KyPCmiNWzFlKvet1czxHKn6w0mjG3DZCook7GMn66GsG5A+fiIQxAtPfX2zA+nLj6cPSoMMsJ/+G81qOTdtpSlzsaQLbj3ud3zRuUxMEA/gEKw7Tp7UQc+4zQ7kp8tQYTet/K8Fu5/sGQjNhaOEnvLJiWSuYJnWcfkzRaf/69lwy/b59pzXfkak6c0R046ESJeHYF6UWfcuXCX9s1e4DShnLbiOdt67BTy5/Gh5zQDkxKXHnIErUZl7fwMU+31KSYBK7wl6WfPjNpYReVxb5ugGVNS5Z0WIy2SG+co63yCcPMxHQCPjWVnzDJPSXK76Y0dm71OwmPm213IFk2xUWGzsAjhzQkv8G/nJx7JL6t9UKkJKjfeLuZPxeJzAH+fZuvRsziOmiVXJR1KXU4PpVP78pmlZte93rC9ZIQkFIN9uuIehNohQ7TrD4DgRJ6kaEJfR5oJSgc0q8UgTyBZq6pKaJ09OIJuywedbEPhJqIc6o0O6QRCMhxixX1Qv6YtHNnbn9Rfa6GLoyMEDZUC6Eh9e8b5s8rCepmENLRMKwhymp+e/UCnZwExGQrOYidw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199015)(86362001)(91956017)(66946007)(64756008)(66476007)(76116006)(8676002)(4326008)(316002)(66556008)(66446008)(85182001)(38070700005)(8936002)(2616005)(5660300002)(36756003)(41300700001)(6506007)(6512007)(83380400001)(26005)(186003)(71200400001)(110136005)(2906002)(6486002)(122000001)(54906003)(38100700002)(478600001)(966005)(4001150100001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3hUYW5OaWJCdGZyam8vNENXdVlzUHg5Y0JCcnFCRGx4c3BzWXo2TUN3MDd0?=
 =?utf-8?B?ckdkdGRGU1puQXp0anF6L1ZYQWxwYmxPYVpUWG01NjRTbnVZaTVBT2J2a1Zx?=
 =?utf-8?B?NUtYSVhCb1YrbFN2QmlTbEV3dFRrM1ZHUzd6Ui9HUmJhT2ZGUlRYMnBVbU9h?=
 =?utf-8?B?Mlp0TmFlaGFYWXlaR1RLYlVzclJSSVlFeWMzdGVHZERzRWJWYWhvaVJIT3cw?=
 =?utf-8?B?cFdob2M3SXVXbnlmKzJQZlR1U1dhUzlGVHhJT3I2c1o2b1JRRDA0TjRhd3E3?=
 =?utf-8?B?dWFFQlFvNnlTRnZMN1piR2Rsdm9zK3gveXNmV0hrQWtNV3dWbVNtRWZOdEVF?=
 =?utf-8?B?Uk8wNkZDSUJSVFNaZ2svajArZXRQTHBGUzFaSWJpWnJwSjJVS3RWTGhRNzJ3?=
 =?utf-8?B?UzB5bHZSVTFpL0Q0aWhkS2VJeVdyZkFLYTVadmNRZWFDK0JDeEF0ZmdDSkMw?=
 =?utf-8?B?aUZ4NUxaQXR5MlJnYnVMTFU1RGdXS01NUGVJclJwMk9qVEhHQTByYW5vektr?=
 =?utf-8?B?MUZhaTA2b0FRaDBDWHpiVHVWdDRLME5VMGVnVnJBdmQ5c0dxc0xaeXRDa05W?=
 =?utf-8?B?c2gyaG8vQ0Y0djdpTTJPcW9acWw2MWNsaitIMFFTQTM0cTU0ZmNhMHE5RmdB?=
 =?utf-8?B?RlFXWW9PYUhpblhPam5oanVJeTJ6V3BOTDNjdktScWtCUmJodkFoYW5wQm1J?=
 =?utf-8?B?UFRQZUVaUTUxbUNPNzdFUkdmNlQ5WlJWTkUwck9TbHduRDdhSXhxcVh6SnZ6?=
 =?utf-8?B?T0R6amdDV1NCVUR4b1ZqZ2xBcG9VcEVYNGVodTJFK1EyV2hwUmdlZitRQUU4?=
 =?utf-8?B?NEt3U3QzN1h6Szc3MC9SWHBRck4vSkFlc1p5eFhTNWk0RGFSOVNRb3hsMEp6?=
 =?utf-8?B?TjA2MWpFcFVrTXRXT1Z4N3ZkbUlTQmlHK0dVU25jTlhsNkpPR0dhanFQd2pL?=
 =?utf-8?B?S3hZWXBkdklwY1k0b2tFSmorM0VaaG4xc1RtbXJoTmZjeTFMQ0w0RDZKTjVF?=
 =?utf-8?B?Q1hXL1o0dzBhdHhSLzdzc2o0Vmh3OHNhMnBVVWRnSStLcjZXMGVGK1RuRC9S?=
 =?utf-8?B?SmRRQ1RUcXVLbHpRajYwdm1DdVFRbHZMeTE1dEpZUDREbFZEazZKMFVwL3hM?=
 =?utf-8?B?ajg3cGQzcTZ6UE5UaXl3d2ZmYTh0UmdMU3RJMDJHU003WWxpZHdKWCtHZ0NK?=
 =?utf-8?B?SGFUS3BuY1lSNW1PT0hNZjZ6RTg4OXJrTjJmQmNTKzFvVlRDblkyQm1yUFIv?=
 =?utf-8?B?SmMyZXVtQ2FqMHByT09EeU9Wd1g3SksxNTJxRit1a090Ti9jaE5RWkovNm43?=
 =?utf-8?B?STNMeHZWdFpPUmI3alM3M2gxYU1sNjlTV1JFYmM4djZnOVEwemlJUGZiMW0v?=
 =?utf-8?B?M0tpWURjSkRCbElxTDlGMmY5b2tGRFpJeGhLUU5TMGpPV1RtUktPcnJ0MFQ4?=
 =?utf-8?B?SHpXQldGYjl3NEVRRDF3aWRtTk1NeDFSQSs1SjF2cFkvTHRGVDdodzY1QzFo?=
 =?utf-8?B?a0xyS0x2NHNXR2ErblJWcXUzbk5tWW9CcFpWYVpsWDAzaXhKU1VtRzN6R0pC?=
 =?utf-8?B?SU95Y0RLeCt0bit4ZGZOTittT1M5YlkyaVA5cnZEVHBMRkt0R2VoTzl5QURQ?=
 =?utf-8?B?ZFkxNzJZQS9PYUJzU3c0dGJwYXEvWFI5bUYzRm1JVngyWHovRm94NWFDb2Nm?=
 =?utf-8?B?bkdqZm1PUmVFMXlrNUJPaVc4NzRvSUNQWkREK3k5TFVQNXJrU0lsZFplY2VL?=
 =?utf-8?B?WkZUUlUyZGhRRnErdHRsbGtmZ0l6T2hWeGZvUWs2cFdOZlZxSDk1VVREY3dm?=
 =?utf-8?B?OFVIK2V1WEVDMVhVUzBBNGdtUnBYV2VDSXdOZmh0eFpVY0c2VzBJRm1Ha3lR?=
 =?utf-8?B?ckVCTk1tcHFCbzlZRG5UNy9XelQyNHRGMzVXckpCc3ZDTDFCWFJ0VjAyTmJ1?=
 =?utf-8?B?dWRpODVsNmZIMDltZTZJeUw0UllYcTNNS0lqQlJmNDY0OS84aXIybUVZWnc5?=
 =?utf-8?B?VEdGRGtRUHFPTHdod1NZWGMwNEFCeHlXU3NLbTk0QlJnbVJvaklvWWgybk5Z?=
 =?utf-8?B?M2FqWExWSDJMK20xNTRKbFQxclBMcEtKUnNkQWREdU9adUx1TS9GUjFyaUdq?=
 =?utf-8?B?WXNrU0JBWU9Bb3l3YkQ4N0NDZ1l3SDY1VU1JRVIzN1FBNEhKTjk0aVhXMXpl?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CED418966335D4DAEDB13771D1344BB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3587b7-8341-4fb3-7506-08dae4b86a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 07:36:33.0875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 78wAGzNLgRbzPalWUN29MjIUhTFYVGLbybMlPB/uytq4VwJFkhTj9HybL4nsY+CG9CzLcQYRoZlC9CCOKor//xNHv8WMxRNWrpBlMVvy4SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTI3IGF0IDEwOjIxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjQvMTAvMjIgMTE6NDIsIEdhcm1pbi5DaGFuZyBoYSBzY3JpdHRv
Og0KPiA+IEFkZCBNVDgxODggdG9wY2tnZW4gY2xvY2sgY29udHJvbGxlciB3aGljaCBwcm92aWRl
cyBtdXhlcywgZGl2aWRlcnMNCj4gPiB0byBoYW5kbGUgdmFyaWV0eSBjbG9jayBzZWxlY3Rpb24g
aW4gb3RoZXIgSVAgYmxvY2tzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEdhcm1pbi5DaGFu
ZyA8R2FybWluLkNoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvY2xr
L21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICB8ICAgIDIgKy0NCj4gPiAgIGRyaXZlcnMv
Y2xrL21lZGlhdGVrL2Nsay1tdDgxODgtdG9wY2tnZW4uYyB8IDEzMzcNCj4gPiArKysrKysrKysr
KysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMzM4IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9tZWRpYXRl
ay9jbGstbXQ4MTg4LXRvcGNrZ2VuLmMNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxl
DQo+ID4gaW5kZXggOTU3NTMwYjQzMDNmLi40ZmM3ZGUyNWYwMzYgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9tZWRp
YXRlay9NYWtlZmlsZQ0KPiA+IEBAIC04Miw3ICs4Miw3IEBAIG9iai0kKENPTkZJR19DT01NT05f
Q0xLX01UODE4NikgKz0gY2xrLW10ODE4Ni0NCj4gPiBtY3UubyBjbGstbXQ4MTg2LXRvcGNrZ2Vu
Lm8gY2xrLW10DQo+ID4gICAJCQkJICAgY2xrLW10ODE4Ni1tZmcubyBjbGstbXQ4MTg2LW1tLm8N
Cj4gPiBjbGstbXQ4MTg2LXdwZS5vIFwNCj4gPiAgIAkJCQkgICBjbGstbXQ4MTg2LWltZy5vIGNs
ay1tdDgxODYtdmRlYy5vDQo+ID4gY2xrLW10ODE4Ni12ZW5jLm8gXA0KPiA+ICAgCQkJCSAgIGNs
ay1tdDgxODYtY2FtLm8gY2xrLW10ODE4Ni1tZHAubw0KPiA+IGNsay1tdDgxODYtaXBlLm8NCj4g
PiAtb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTg4KSArPSBjbGstbXQ4MTg4LWFwbWl4ZWRz
eXMubw0KPiA+ICtvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxODgpICs9IGNsay1tdDgxODgt
YXBtaXhlZHN5cy5vIGNsay0NCj4gPiBtdDgxODgtdG9wY2tnZW4ubw0KPiA+ICAgb2JqLSQoQ09O
RklHX0NPTU1PTl9DTEtfTVQ4MTkyKSArPSBjbGstbXQ4MTkyLm8NCj4gPiAgIG9iai0kKENPTkZJ
R19DT01NT05fQ0xLX01UODE5Ml9BVURTWVMpICs9IGNsay1tdDgxOTItYXVkLm8NCj4gPiAgIG9i
ai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9DQU1TWVMpICs9IGNsay1tdDgxOTItY2FtLm8N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OC10b3Bja2dl
bi5jDQo+ID4gYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LXRvcGNrZ2VuLmMNCj4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uYzZhYzZjMjU1
OGFlDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Ns
ay1tdDgxODgtdG9wY2tnZW4uYw0KPiA+IEBAIC0wLDAgKzEsMTMzNyBAQA0KPiA+ICsvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ID4gKy8vDQo+ID4gKy8vIENvcHly
aWdodCAoYykgMjAyMiBNZWRpYVRlayBJbmMuDQo+ID4gKy8vIEF1dGhvcjogR2FybWluIENoYW5n
IDxnYXJtaW4uY2hhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4
L29mX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+
ID4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tZWRpYXRlayxtdDgxODgtY2xrLmg+DQo+
ID4gKw0KPiA+ICsjaW5jbHVkZSAiY2xrLWdhdGUuaCINCj4gPiArI2luY2x1ZGUgImNsay1tdGsu
aCINCj4gPiArI2luY2x1ZGUgImNsay1tdXguaCINCj4gPiArDQo+ID4gK3N0YXRpYyBERUZJTkVf
U1BJTkxPQ0sobXQ4MTg4X2Nsa19sb2NrKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgbXRrX2ZpeGVkX2NsayB0b3BfZml4ZWRfY2xrc1tdID0gew0KPiA+ICsJRklYRURfQ0xLKENM
S19UT1BfVUxQT1NDMSwgInVscG9zY19jazEiLCBOVUxMLCAyNjAwMDAwMDApLA0KPiA+ICsJRklY
RURfQ0xLKENMS19UT1BfTVBIT05FX1NMQVZFX0JDSywgIm1waG9uZV9zbGF2ZV9iY2siLCBOVUxM
LA0KPiA+IDQ5MTUyMDAwKSwNCj4gPiArCUZJWEVEX0NMSyhDTEtfVE9QX1BBRF9GUEMsICJwYWRf
ZnBjX2NrIiwgTlVMTCwgNTAwMDAwMDApLA0KPiA+ICsJRklYRURfQ0xLKENMS19UT1BfNDY2TV9G
TUVNLCAiaGRfNDY2bV9mbWVtX2NrIiwgTlVMTCwNCj4gPiA1MzMwMDAwMDApLA0KPiA+ICsJRklY
RURfQ0xLKENMS19UT1BfUEVYVFBfUElQRSwgInBleHRwX3BpcGUiLCBOVUxMLCAyNTAwMDAwMDAp
LA0KPiA+ICsJRklYRURfQ0xLKENMS19UT1BfRFNJX1BIWSwgImRzaV9waHkiLCBOVUxMLCA1MDAw
MDAwMDApLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZml4
ZWRfZmFjdG9yIHRvcF9kaXZzW10gPSB7DQo+ID4gKwlGQUNUT1IoQ0xLX1RPUF9NRkdQTEwsICJt
ZmdwbGxfY2siLCAibWZncGxsIiwgMSwgMSksDQo+ID4gKwlGQUNUT1IoQ0xLX1RPUF9NQUlOUExM
LCAibWFpbnBsbF9jayIsICJtYWlucGxsIiwgMSwgMSksDQo+IA0KPiBBcmUgeW91IHN1cmUgdGhh
dCBtYWlucGxsIGFuZCB1bml2cGxsIHNob3VsZCBoYXZlDQo+IENMS19TRVRfUkFURV9QQVJFTlQ/
DQo+IFRoaXMgd2lsbCBnaXZlIGlzc3VlcyBpbiBHUFUgRFZGUywgYXMgdGhpcyBpcyB0aGUgY2Fz
ZSB3aXRoIGFsbA0KPiBNZWRpYVRlayBTb0NzLg0KPiANCj4gUGxlYXNlIGNoZWNrIHRoaXMgc2Vy
aWVzIGFuZCBhZGQgaXQgYXMgYSBkZXBlbmRlbmN5IG9mIHlvdXJzOg0KPiANCmh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGlu
dXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTY4ODEzNV9fOyEhQ1RSTktBOXdNZzBBUmJ3ITBrbzhO
cEtBOEtXMXZwNGx3LVdSUmUycHdfTjBaLTJnYmVBa3poZm13Zjl5SzI1LUJ3N1RaRmZxVFRXTV9G
UUZGNkEkDQo+ICANCj4gDQo+ID4gKwlGQUNUT1IoQ0xLX1RPUF9NQUlOUExMX0QzLCAibWFpbnBs
bF9kMyIsICJtYWlucGxsX2NrIiwgMSwgMyksDQo+ID4gKwlGQUNUT1IoQ0xLX1RPUF9NQUlOUExM
X0Q0LCAibWFpbnBsbF9kNCIsICJtYWlucGxsX2NrIiwgMSwgNCksDQo+IA0KPiAuLnNuaXAuLg0K
PiANCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgbXRrX2NvbXBvc2l0ZSB0b3BfbXV4ZXNbXSA9
IHsNCj4gPiArCS8qIENMS19NSVNDX0NGR18zICovDQo+ID4gKwlNVVgoQ0xLX1RPUF9NRkdfQ0tf
RkFTVF9SRUYsICJtZmdfY2tfZmFzdF9yZWYiLA0KPiA+IG1mZ19mYXN0X3JlZl9wYXJlbnRzLCAw
eDAyNTAsIDgsIDEpLA0KPiA+ICt9Ow0KPiANCj4gQ0xLX1RPUF9NRkdfQ0tfRkFTVF9SRUYgaXMg
bm90IGEgY29tcG9zaXRlIGNsb2NrOiB5b3UgY2FuIHJlZ2lzdGVyIGl0DQo+IHdpdGggYSBjYWxs
DQo+IHRvIGRldm1fY2xrX2h3X3JlZ2lzdGVyX211eCgpIGluIHRoZSBwcm9iZSBmdW5jdGlvbi4N
Cj4gDQo+IENoZWNrIGNsay1tdDgxOTUtdG9wY2tnZW4uYyB1cHN0cmVhbSBmb3IgYW4gZXhhbXBs
ZS4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCg0KICBPaywgSSB3aWxsIHVzZSBkZXZt
X2Nsa19od19yZWdpc3Rlcl9tdXgoKSBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+IFRoYW5rcywN
Cj4gQmVzdCBSZWdhcmRzLA0KPiBHYXJtaW4NCg==
