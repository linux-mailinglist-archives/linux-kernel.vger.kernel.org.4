Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA96674385F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjF3J3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjF3J32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:29:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AAD19C;
        Fri, 30 Jun 2023 02:29:25 -0700 (PDT)
X-UUID: 97330cc2172811ee9cb5633481061a41-20230630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ex9UcDRoy4BtGM72u2BlCe8Yty2VE7PfxkMNbEx41+k=;
        b=F4f314Wkbn1WcfXGfD53cx9EdPK0joefpOd2RsJSC64rUHFwbWvuZl22QzPquKkV0IuU1wvedeWy8+Hx1gw6awJJnUgz+f9VlUoiVEG04ocAr5QyRgx88Oo5qk83F+7M+puD4/xwK803i6ChPCib97+TUH3eBReNarA+f/fjGNk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:38a4bff5-b90a-4830-b6c7-756d80729922,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:01c9525,CLOUDID:8a736a0d-26a8-467f-b838-f99719a9c083,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 97330cc2172811ee9cb5633481061a41-20230630
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 479517045; Fri, 30 Jun 2023 17:29:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 30 Jun 2023 17:29:18 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 30 Jun 2023 17:29:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jj8nCLczTmSt4Kb01GPAzsRg7MmOHLdIxNL6gawnWlLYl/fgfGPP5pigGAjlq6gtio/sVj88FHo8GTtadqvTaQMa+BftLE3Frk8cX0ifUWn50CZi2CQknNF232ynKPVjqk7mDIekMduCh0L/Y7qjJGVqc/LS7GFoZxKFm2wmoV25UklP5peFFrBA1PIyyzcAOEnxHfDtjC1TO+N5yZQ+q3NhuWfdnhgNJFLBqAZDQkN5VSaXp+CcQdCn9LoBA7hK3m+Mx5o97YBYj/ssBOwlLefLWwt5BJ6/iNP+gCgFXv6E4ToCFwfS44rgAyEMVDkMssS2/JF89VaPbk3TPXGJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex9UcDRoy4BtGM72u2BlCe8Yty2VE7PfxkMNbEx41+k=;
 b=eAJ37KYQgDxKaLr+9Fuw6HBKEYmlwu1p5hMKpfASI0P/sYqFER7MEil4pa+iBpAE6RuE8HxNf+6nWJ7T7B6RdxjzSZpk4iVclwUlXG+S7Le7TJZsiKb3qBbw350Lm47TzKF4mLUnb3YUbjZe3RPRE8DBpmtzL1vYQv2C+LJqwBZafQqYdONqGihHY6Q708bRrsGFoUhhHhADFFCRRSmJL72WWIiF6rqtCioHNNDK4l3kQY9zS30bvx+Ub4OVqzhqIdzPnztnJSjh/3SKqAVWg2nbieCcmw+DVmR5mo8Gs/hHB2tXGN11039jh4z6yN7+VAqul3oN7TteYj74k5Dv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex9UcDRoy4BtGM72u2BlCe8Yty2VE7PfxkMNbEx41+k=;
 b=CGrIpkPUCIPXqN4Et8l2YO5FXZvmYDh0nwLwWs0fmqMp+Md6tnZTTOYbYleBZOivTjZIcCODXFB1etdJ4tcEFrQWTxng4gVdyDFg0FwD4obMTWjjkquQxC3iATQWUqjQ0E547AN/zTuFtjgIskuTciB2jPz8TGBwXRDLnVz7ZDQ=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by JH0PR03MB8076.apcprd03.prod.outlook.com (2603:1096:990:37::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.44; Fri, 30 Jun
 2023 09:29:16 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::5e36:7af8:5488:3244]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::5e36:7af8:5488:3244%6]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 09:29:16 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 6/7] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Thread-Topic: [PATCH v2 6/7] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Thread-Index: AQHZp9cGs13LeRvAc0aaCDvybYrG6q+h5K2AgAE2UYA=
Date:   Fri, 30 Jun 2023 09:29:16 +0000
Message-ID: <8c6316e79e40406e4d46709f602dcb14a4c00562.camel@mediatek.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
         <20230626023501.11120-7-maso.huang@mediatek.com>
         <20230629145835.GA2954895-robh@kernel.org>
In-Reply-To: <20230629145835.GA2954895-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|JH0PR03MB8076:EE_
x-ms-office365-filtering-correlation-id: d4332175-8ee7-49b6-d3f5-08db794c794b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2nt/bjCtLj1+ywWZplOPGh2TjBmdXlgPpnTWyuxwax/DJiXkusDPSjXJEeLGH1+K0uoHRwA6UpQqknGQsBaKSAevCf2cryKdUAF7P+DhZjT5yKXQz6QErBteuqWk/ESNg9cJ1pCtp6E/X2ldNLf8RUDN9beEFLlSJsFK+PErdNLDTvRnfBV1uX4NKohH4EFZUP+2MrKGP24QBbTxaOA2Fp3Wsy7opo5aoxehT8CXZMyIdU1dC0yY1CGvp2dsrskJsOB9b05/AC/NcHd8YyK3pD2Upmal15zaD1xo/bSkwLzm5B7nGzk5WwKS8W/0JNHL4pcHXAxsRnQ/poV2oVibnLOWljxCo81tjqsAUzpcpjo7Kf9ObLnaS4aWqp1S9dxxw5fwTPwwOkLEwOgAMxT34xIx8iWa/MFSrM+oZjsK661XQ/1M/W3T5lFbTm14ZTbPV3b6idjvPcfPJAIj3NcAlxcE+Wfb9I4HQYcEji+yJzTVj1+zYsw/rY+rT6f4DXqTVGw+7COkFV4jSP2uiXVKH9FMptS/trC/RAta8ulOpIR/TAo8hd5yC5wxlk8Azd86nFbG7V0R/VuT550wLy8WMrRiBGDXak+eaKz2xBZC/QJVNHqm+iB+9nnzWhnT6HwwxgFASEAgf1DpMDV4kRvtxof2ROL6yCiN/fWaA1r85m1KEqvh94ysbkwaxIHnmv7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(71200400001)(91956017)(7416002)(8676002)(54906003)(41300700001)(8936002)(5660300002)(122000001)(966005)(316002)(4326008)(478600001)(2616005)(6486002)(36756003)(76116006)(2906002)(66556008)(85182001)(83380400001)(66446008)(66476007)(64756008)(86362001)(66946007)(38070700005)(6916009)(186003)(26005)(6506007)(6512007)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGFueFhuQmNuRG5KMVd2eTFrK3o3YWpPd1MyMzRnM1h2M0dBQXVia0hjcW1D?=
 =?utf-8?B?TDZFamw3R2xnci9COGI3OGx5eExMU1VlaHBUVm1RNHZpVVBKVHhWM21EUkxr?=
 =?utf-8?B?R2JZT3dwaGdTaW1uNnRlU3FhVi94OFZrMWphQmZrYzZBZHZqclNTQW5jS0VS?=
 =?utf-8?B?Zmk0VGtmcUxka2ZrOGdSdS9SeStsVUllbW1xODJCS3BkZWIzRjlQOXpJU2k0?=
 =?utf-8?B?OUtqeXhvYnNxbHJCNjM0ZlVrTTQrckQ3UkQ0b25MdWhjVkFFTlhuNWZnWFA2?=
 =?utf-8?B?b3JvSE5CaVlaYTY0VUNZeThlckx5Z0w2VmFyc3VmNUFiY2lDYm5qZlRNME53?=
 =?utf-8?B?OWFBNHJvd3p5MVpYVVk2YlduZmgyRzZJOHB2T3VTc3Z0dVdPbjZRTTdSQjNq?=
 =?utf-8?B?WEwvUkp1L1YzRDh1U1lZdWllZXFOVVRlVEZ5dm92Ti9RZnRrNStjUWEwTWZw?=
 =?utf-8?B?THJFZU8wNHdpWng0SHBQSUFXMllJNFpHOFRBWGxKM3NzTFFIOHBJajNsU3Nu?=
 =?utf-8?B?eGg5KzBxOHUydm1aR0RVY05KRVg3ajk4NWx0UnZRd2QzQithV1Jad3BOa2Vl?=
 =?utf-8?B?UVVmWHE1Qjhjc2UwUW12VTNhWEtvQStqanMxTXJSdWpvRmg2REFVYVBBbzRi?=
 =?utf-8?B?Q3RHd2NOdURuWkpWQTRSWHpiZlUvaStOb1BCZGRjTUtwYjFNZERpYjNiU0p3?=
 =?utf-8?B?K2ZOWis4eFgvYU1MRUZvdVZrVStZbldqZzl3Q1dvMVBja0c1SUhpN3k5QU9P?=
 =?utf-8?B?d1l2WExoYmtQc0ZBWmVwNmJQRUNseG0xWGtWbmtQT094YUV2ZHFvTFVKZDRk?=
 =?utf-8?B?WmhqQ0R1UTYwRWVMRnZDcllTSEhhbmg3Yyt6eTR5aVpTL25ybm9vUUVxT2tV?=
 =?utf-8?B?MllhQUFTUFZtalgrc25pUFg3UmNBUERNdUNjaXJvaHEvbERwbnY0S0VkVzJL?=
 =?utf-8?B?Tk1JU3NJenF6MFZlWWhrWGRoZGJYVG15STBxMWsvZDF5WXV4ZFRML2IxWmht?=
 =?utf-8?B?ZE8vUWV6dndQWDlhbm5IQS8remZRdnZlcHRLUDZkdGZtQUl4UlVkOHpBOFpo?=
 =?utf-8?B?K1VZV1VDc2RpOFBWS3NiaUdVSGtFWTdRR2JEbDkvcDlhRHlINk5nUkN5TFFT?=
 =?utf-8?B?RUlpTGtLb3NMRVo5TUNmTythY05rd3BtZ0x4WHhiRmduNk5Ubmp2bDFoSyto?=
 =?utf-8?B?ZlR5VlAxWWVpbG0wcFg4NjRDOWhJVjBuY2lTczU2ZlpScXF4UlVhUzVzMktS?=
 =?utf-8?B?OGpUejFvRVMzYnovcWkzSTZiZzRoaE1WSndyTFNCcjI3eGt3OXRKa0JVVWJr?=
 =?utf-8?B?Mk1QUFV5cE1yR2trTUZ6dEFhWjE0cUtNVkdTUXVDWVVWakVuK1VqZWptQUxN?=
 =?utf-8?B?Rm5PRXlrM052QVJmRm85SDVvbFVESlRTbHNlV1BkS3RyclFYdXRhTVJJTFVJ?=
 =?utf-8?B?QUN1NHFYalJNT043aHR6UXRNVGtjRURCL3dzckttL2ZvQzRrR2hjRS83TFdS?=
 =?utf-8?B?eSt0ZjBYME9GeTQwei91dVh1QXZrNWFvYzZGUmp6UTBCdjZHOWpPOXN5cmZp?=
 =?utf-8?B?VzJGYTVQWXpWVFR4ZjlGZkJERjVPUGVjb0UwQklEbmJLdlZFdE1LV2RqdzFz?=
 =?utf-8?B?YlJVQzJzTkFXTlpCUSsyN1Z2MjU1Y2ZMSW5yMjlpQ2RlYk9PTElmSkhVbkh0?=
 =?utf-8?B?SUJJZ3djUGEyY28vNmwrYzgxUDlrLzJyM0QyWlVIaDBFdWFZaTkrMDRXdlNo?=
 =?utf-8?B?N05tbGNvWWZWNkdwUzdKSTQyQzUxd1Y5Q2d6UXZHeHkzcjlPUHEvNnZid0hZ?=
 =?utf-8?B?ZHNLNkpiZjVla0xaN2F1MjlPWW5Wd2ZyRDd3TjNqTXZMbWt0TTE2V0JkYVpU?=
 =?utf-8?B?NytYckVTcEN4TERQa2Vsb1dLSG52K3VPekgybTlPYlFsNHQ2VXZhWFA5cDZr?=
 =?utf-8?B?WGc2eHJoaWpBN2tmQzIxQ0I1VFgvM3dlRW1lRnpoWWVlTTI1bnZSWTQ2aXpI?=
 =?utf-8?B?WFp0NkFUelhRZkRyN200MHdBOXp0MzJ2U1lidGYrWEM1MVEzZW5SQnVpQjJW?=
 =?utf-8?B?SG9obDNGNE0wV08vUWJqMzRNZE9OMUpIeVVmSGpuQVBZeCs2b1l1LzFnNnpZ?=
 =?utf-8?B?U1JPQ1U3NTlKOG50eklCcHVDdkc1VzFmdGpkVnFJYWY1NzRIOTd2UUFKZVV4?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2305CBFB86CD6B42BEB9D169F5768697@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4332175-8ee7-49b6-d3f5-08db794c794b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 09:29:16.2368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NFPkuNDxYFtS70XAbPaihMt1QS6W81qlgH271O/OxwThsOk4jCF4GJaUlNrd2utrCPlcOOsWFwAeX6bFZJf/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTI5IGF0IDA4OjU4IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBNb24sIEp1biAyNiwgMjAyMyBhdCAxMDozNTowMEFNICswODAwLCBN
YXNvIEh1YW5nIHdyb3RlOg0KPiA+IEFkZCBkb2N1bWVudCBmb3IgbXQ3OTg2IGJvYXJkIHdpdGgg
d204OTYwLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hc28gSHVhbmcgPG1hc28uaHVhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vc291bmQvbWVkaWF0ZWssbXQ3OTg2LXdt
ODk2MC55YW1sICAgICAgICAgfCA1Mw0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OTg2LXdt
ODk2MC55YW1sDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDc5ODYtd204OTYwLnlhbWwgDQo+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10Nzk4Ni13bTg5
NjAueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAw
Li43NjM5NGY3ZTU1MDINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10Nzk4Ni0NCj4gd204OTYwLnlh
bWwNCj4gPiBAQCAtMCwwICsxLDUzIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICslWUFNTCAxLjINCj4gPiArLS0t
DQo+ID4gKyRpZDogDQo+IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3NvdW5kL21lZGlh
dGVrLG10Nzk4Ni13bTg5NjAueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogTWVkaWFUZWsg
TVQ3OTg2IHNvdW5kIGNhcmQgd2l0aCBXTTg5NjAgY29kZWMNCj4gPiArDQo+ID4gK21haW50YWlu
ZXJzOg0KPiA+ICsgIC0gTWFzbyBIdWFuZyA8bWFzby5odWFuZ0BtZWRpYXRlay5jb20+DQo+ID4g
Kw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBjb25zdDog
bWVkaWF0ZWssbXQ3OTg2LXdtODk2MC1tYWNoaW5lDQo+ID4gKw0KPiA+ICsgIG1lZGlhdGVrLHBs
YXRmb3JtOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
cGhhbmRsZQ0KPiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBwaGFuZGxlIG9mIE1UNzk4NiBwbGF0
Zm9ybS4NCj4gPiArDQo+ID4gKyAgYXVkaW8tcm91dGluZzoNCj4gPiArICAgICRyZWY6IC9zY2hl
bWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL25vbi11bmlxdWUtc3RyaW5nLWFycmF5DQo+ID4g
KyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgQSBsaXN0IG9mIHRoZSBjb25uZWN0aW9ucyBi
ZXR3ZWVuIGF1ZGlvIGNvbXBvbmVudHMuIEVhY2gNCj4gZW50cnkgaXMgYQ0KPiA+ICsgICAgICBz
aW5rL3NvdXJjZSBwYWlyIG9mIHN0cmluZ3MuIFZhbGlkIG5hbWVzIGNvdWxkIGJlIHRoZSBpbnB1
dA0KPiBvciBvdXRwdXQNCj4gPiArICAgICAgd2lkZ2V0cyBvZiBhdWRpbyBjb21wb25lbnRzLCBw
b3dlciBzdXBwbGllcywgTWljQmlhcyBvZg0KPiBjb2RlYyBhbmQgdGhlDQo+ID4gKyAgICAgIHNv
ZnR3YXJlIHN3aXRjaC4NCj4gPiArDQo+ID4gKyAgbWVkaWF0ZWssYXVkaW8tY29kZWM6DQo+ID4g
KyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+ID4g
KyAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgb2Ygd204OTYwIGNvZGVjLg0KPiANCj4gUGxl
YXNlIGRlZmluZSB0aGVzZSBwcm9wZXJ0aWVzIGluIGEgY29tbW9uIHNjaGVtYSBhbmQgcmVmZXJl
bmNlIHRoZW0gDQo+IHdoZXJlIGFscmVhZHkgdXNlZCBhbmQgaGVyZS4gQSBnaXZlbiBwcm9wZXJ0
eSBzaG91bGRuJ3QgaGF2ZQ0KPiBtdWx0aXBsZSANCj4gdHlwZSBkZWZpbml0aW9ucy4NCj4gDQo+
IFJvYg0KDQpIaSBSb2IsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCkRpZCB5b3UgbWVh
biBJIG5lZWQgdG8gY3JlYXRlIG1lZGlhdGVrIGNvbW1vbiBwYXJ0IHlhbWwgYW5kIHJlZmVyZW5j
ZQ0KdG8gaXQgZm9yIHRoZXNlIHRocmVlIHByb3BlcnRpZXM/DQpPciBpcyB0aGVyZSBhbnkgZXhh
bXBsZSBmb3IgcmVmZXJlbmNlIGZvciB0aGlzIGNhc2U/DQoNCkJlc3QgcmVnYXJkcywNCk1hc28N
Cg0K
