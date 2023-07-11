Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD4474E3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGKCEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGKCEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:04:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFFEBF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 19:04:32 -0700 (PDT)
X-UUID: 3d703bc81f8f11ee9cb5633481061a41-20230711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nt1u1FZrdSqOR09hH/J4baAM3uSO9TsOtgsipVFZFBM=;
        b=URzs7ZycGxKbS11fnxSuCpvfx0yrvri1ziUI1nqA8Joq6EqP1nKAbStOrieDWna43wu27efMhNXoPdaFVChttKsOYWSL5zUrzoln6GOBGiWVzX/Nf0FArHdfH3T6bVn7hNk56qL9oPSyFtmv6j0bh7KZj9dTBBDcU2LSotonjcA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:f3b1cb91-2cda-4944-9950-521a8cc866a8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:-32768,SF:-32768,FILE:0,BULK:-32768,RULE:Rele
        ase_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:c5c9150e-c22b-45ab-8a43-3004e9216b56,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 3d703bc81f8f11ee9cb5633481061a41-20230711
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <chunhui.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1725490425; Tue, 11 Jul 2023 10:04:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 11 Jul 2023 10:04:15 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 11 Jul 2023 10:04:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0QxTbkN8PYzF1zczy0V7S/Ro/cXQWHRUg/bpA0f6NcPfdLmE9yGxEw9MhEK8GajDbEMEZSjv2nA3Jlhh87KmiKY77ng1FuDA6xvKDb+Sy6t0h+sI4qv6C4aFF4155IAo2OD23qaPCuhk2XQiNOf1TOoqU21FzJQN2LBfWXdEu2fVOlch6RZax/X7sdmPdgj/LyntZjXhmphNkERMBlDK8SZ2vA11fYrKPPriO6Uo9NORy2gVenEqR+dQSKin9v85HSq2NWpBQbGfz3d4bvIZoPRdumNwttH6DPqSgvVDBui5/WZQ1FOlgXSmGtgLmgMQnkemO4aJg8E5lYtdMPo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nt1u1FZrdSqOR09hH/J4baAM3uSO9TsOtgsipVFZFBM=;
 b=ckLQ/o3zvzPviibd0JM5Z72Lri2ySfH5OsgLOF4qNCRFI+8zZPko1RbyfIgWsGF1XqoeEFwzREB5wDL66rc+PBiggTz+lnzmiz4fgSPaYLUpSEVfZhfYGknAKhBWCQneb5IYlw3V/j+RjBTrPlmDDtgS9//gXwcyYA40KfdE4r3G125DZOgHIjHZnFcKvbQPGVo8yh9L7MmATwsV0NfyjhoWySTAgpKQZfIVgv9ORiCgdXO4R8OkiSR3OVdu4qDspl1IO5P3v6skC2n247LvqtEqKUsNyMMvgjgpHggFQ7t2Trf8YpYZMiF6+DcBpe6nRuzJgk84+NooKwaymQ/glQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt1u1FZrdSqOR09hH/J4baAM3uSO9TsOtgsipVFZFBM=;
 b=sKfSQpcTQqy6wu44BZI8bU0AT0d2SzxxpeoXd/9rh9nnTOu55lzWjLTqo/7W1ipakLlBFXJsecyD/A+1TFNv2wrpQtj4V3KER6JI10o8uPksJnFoF8YX3PvA0/aNN62lve6NcK7DBqMVJvf7TCnu0BTo+2vNfLXsjl0+Ui2N7i8=
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com (2603:1096:301:4f::5)
 by KL1PR03MB7019.apcprd03.prod.outlook.com (2603:1096:820:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 02:03:09 +0000
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::1d10:57b1:1800:cd84]) by PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::1d10:57b1:1800:cd84%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 02:03:09 +0000
From:   =?utf-8?B?Q2h1bmh1aSBMaSAo5p2O5pil6L6JKQ==?= 
        <chunhui.li@mediatek.com>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?SGFua3MgQ2hlbiAo6Zmz5b2l5bu3KQ==?= 
        <Hanks.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        =?utf-8?B?Q2hlbmctWXVoIFd1ICjlkLPmlL/oq60p?= 
        <Cheng-Yuh.Wu@mediatek.com>
Subject: Re: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Thread-Topic: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Thread-Index: AQHZsMyUsn+UkcBx202tmPRCTRWnV6+xGuqAgAFmi4CAAVARgA==
Date:   Tue, 11 Jul 2023 02:03:09 +0000
Message-ID: <4d5cc9067f4235e8bfc9a0b371b9bab6532de062.camel@mediatek.com>
References: <ed3c5fe3f7ed42d58d98e77b3513d6eabf2ad6cd.camel@mediatek.com>
         <877cr98pia.wl-maz@kernel.org>
         <79a9ad046061512073525ef23e19c961ea5b33ef.camel@mediatek.com>
In-Reply-To: <79a9ad046061512073525ef23e19c961ea5b33ef.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5528:EE_|KL1PR03MB7019:EE_
x-ms-office365-filtering-correlation-id: 90320581-e88e-47cb-13b3-08db81b2f979
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Fmgivqc30W3U5TFSIDkM6JGw2nKltVokiz0lXA/6fDCSgbQ3MUkdZ+qb97NWNk4uwuxfjleeNKZNgHMWuydUuFzjqATxmkUB9J/j0wYt5kDIOySw6GurhxLXvkBIV7YGpkc52fKy37w0BXa2Y0ksHy4WHlEjFxOHfvyWWuJyh80vEmFzCAF6dDsJ1CSakbQRcJ618rbARp2lSW04akp6t3Bx1l+bS5EPhyJpkPu2XO/umfubgOjg3nXKPh9jDkq6byBo5QY4HrBjhKRCPjgFAZNUdhgxzAij72YHJorhsyF40rbG+GKknrd7Mid0GvO3otA+RK6vmAK75z4dQbow2s0bdcNZysAlgIS67r9xrQq/Y7PK2Az4q8RquSNPz7VyNKTu50RJ5sTQPwAppLpVX4sESgiwxeqpcDaVeye4aiw9b9YjucKxR8QJDrQBS6ZKrl5VWJcnyW/4Tr1t0Bbh2ItOqsgpOfKwuZC0OLoS1/aY82Mp60X0xzQSQw19w9/lItqMf6Q3M18Jjsd/oSg/6wJ9BStCk71pTaoiwYC/HY/UKzVk59HTmo26q2DRC8i1XK1YRnoBdXoJCMWO/uVajdpy0+Ir6zgE4b09OTMrhV/gV/hZplzbEpRyFI3kJyzI/FsnOOyynTb1R8KAVbzfSg7sjahDtYfX6QNt1fABG0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5528.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199021)(478600001)(4326008)(64756008)(66446008)(6916009)(6486002)(66476007)(71200400001)(36756003)(85182001)(66556008)(41300700001)(316002)(54906003)(66946007)(76116006)(86362001)(6506007)(91956017)(38070700005)(83380400001)(26005)(2616005)(186003)(6512007)(122000001)(38100700002)(2906002)(4744005)(8676002)(5660300002)(8936002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkIrdTFNc0hCcEE5QVFCR2FUazNuTFVTS1hLVmtqc0FJLzlrUXhSeTFkS0Rx?=
 =?utf-8?B?M09EYU1OYVVZRlFhUk9sc2o1dVFtdUNRTnZKNGpOQmJLYmdBcGpYUkdkQWJM?=
 =?utf-8?B?ZnB5dlN5dENWUi83eGRqN2hOK3V4b2lwOWFkRW4wZDFQcHVrQlFMa2l1emVx?=
 =?utf-8?B?dURMSHZxREpqclVrd1AyTUNMcW10VzVraWFkNDRFRithRlZBeUdjejEwOU1q?=
 =?utf-8?B?STBCNTY1L3dEVjFXOU9EL3ZiOG9OekJpVnlpNFZTOGhjbER3aGRtMVo1KzFv?=
 =?utf-8?B?S0t4NkVtTVZHTVRqMzlrR25tcW45bXN1dkgwWWJXQ3k3dFFud205R1RwWUdo?=
 =?utf-8?B?SnpDUEhqTTdwODZJUDBueUwyRnZGdWF3aEdMejhSNEZTVmkrcGYxajdIZzlY?=
 =?utf-8?B?Q1M3RDZMZDA5dXk4VHdEK1pGUUdyMlU0STRwd1ZTNFo3TlU2SHlKQ0puU0l3?=
 =?utf-8?B?MTRmbnZhek5YNGNDNlhLN214bGs3eUhTZTNvUFF5eko5dmExQmk2dHZMSmdD?=
 =?utf-8?B?VHRVWUJjSWl2Q3BvY0xTTWZjWjJMVWswVmVBNTdJNFB5d211dkxHV0V5aHZN?=
 =?utf-8?B?TU84YXV0VGg0Z1JFSE9wR1g3L0pOektIaElhOEZIc0hCaktqSGRGeE1PekQr?=
 =?utf-8?B?TmpzU2g4bFNpZXJyNGFHUTZ2U3VNLzJ1OHphNUpKYXlNeUhndWpDQUpqN0tq?=
 =?utf-8?B?anBaZlQxYVZVUVhLK3ozLzlhTzh6cWJnWWpYb1dxM2hDcTg5RGdCa3hZUk4r?=
 =?utf-8?B?MVliWUdwTTY1RVkyS2FQZHRjWTQvbGJ2d1hqVjZzYTZBRFlYeVFOdTMrNXpI?=
 =?utf-8?B?WU10dFNPYTliYmdLbmlKV3doaVpUWHBkYkwxS205d1pLSHI3Yk9URldUY3h0?=
 =?utf-8?B?em9aeWcrOHBpVVBMbFNLZkxTdDd1N3RzeXAwQVhvdWFNOEc4ejBHNDFmcytv?=
 =?utf-8?B?RlQzVkI0MTU2ajllSWcvZzM1N0RqRHd6dTFoT2Vhdm14KzBWQmhIWVJwdlV5?=
 =?utf-8?B?UlNNbFpKUFBoODdnaVhBUkJNNUVrcExZdGhVSnFudFMxZEM3ZjUzdEhKMTA2?=
 =?utf-8?B?K1pibnFvTnhrUTVTUkJ6VEg3MmsyNExJOTl2QzBFb05zcWdiNmlheHNBSGFI?=
 =?utf-8?B?ck9HNlo2U25iN2IxQUg2Qno3NnRWOFJuVm1OazY5M0Q5VU1PQWxaQldRNm91?=
 =?utf-8?B?WW5wVmNlbmRmbDJpeFhuT3R6d3p0aVU4NXFxVnNEQytwL3Vodk5qdEV5WHU1?=
 =?utf-8?B?U0ttM29jODVCYjR5dTRsUWpuQVo4WUpxdFE5TXZ2ZC9BZVFIK25uRUVnc094?=
 =?utf-8?B?MEVRRzA3ejdUb2Jzb2NBUU9CUXFMNGZ0MUVRZldPWldtNHNVTndqSTI5d09o?=
 =?utf-8?B?bU56Z2UrTGwxTjhraVBCQlR3RmM0TXNKa0RtTDdVait1Y0RBcHA2NDVaS0hv?=
 =?utf-8?B?Y0NJL3poMWF6MXppUktpYmh5UTJybFZCVlhlMUhtRW8wYTJ5VUl2RkpVcURo?=
 =?utf-8?B?b3FvKzJIRmZDczBrWWovTDlOd0tlM3hFYVBnWGRoek11THo3SmxFbVJ2ejB6?=
 =?utf-8?B?MWMrb2tYcU1SYzV2VUZ4b2IyZjM3WklnY2FvYXd5NFZjRnJMVE95RDJsMkVK?=
 =?utf-8?B?cXRDTFlmVmVhMFhlVGFmQXFaZVMzMGpIY09zeEVoMzFIM0MvWmoxKzFDZEV1?=
 =?utf-8?B?akZaQnVWSWxGZDNxa043dzhVL2tWOXdvYmpQL2N2WGVMQS9qOG9qRklTNTVz?=
 =?utf-8?B?T1ErY1B4d0lmaXloTm9lNUt3K1RRcHZpOTNBS21pcDhWVEpLZlhyOFZ4akpT?=
 =?utf-8?B?S0ZrYzR1S0x5SUdGWnIrRmhOZUlkbElBMWU4dHVHUVlFSlZxcjA1Y0M5KzZF?=
 =?utf-8?B?cHNKbUxuS0hZTkZReUM2cEszemtrSlh0V1Boc1VXcmJFaVlxKy8wZlR4QVI2?=
 =?utf-8?B?WVVlcGFBRU0yR1NQZDRLak05eXh3YmRYV1hMM0VoRTEwVStQcm5XbG9kTFFF?=
 =?utf-8?B?ZE9ZRlB3OTRxNmNtRW16alFUV2RLT2s5bldIYStZbitKUWdUN3l6UTlodGhY?=
 =?utf-8?B?TUdzYnhFU1liSG8wS2JENFhFaVFZRmNXNzAzelFvbEJENytXRjJFUHJpaS85?=
 =?utf-8?B?T1RHTE1TS3l1WDNZUjlpZkVGSHpkNkd2UU5wSTY2ZU9MKzB4YmRxYmVkMEhz?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5487C5D3E454B84A8DCAD50145B878D5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5528.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90320581-e88e-47cb-13b3-08db81b2f979
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 02:03:09.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpnnEVr/sp+hPQJj4Kl0mcKDZ5EQalbZzE5atEN1BgSHJ+LYVWYtFRtAdLjXLc9tFWH9+MusUxw4as/W0gp8IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTEwIGF0IDEzOjQ0ICswODAwLCBDaHVuaHVpIExpIHdyb3RlOg0KPiBP
biBTdW4sIDIwMjMtMDctMDkgYXQgMDk6MjAgKzAxMDAsIE1hcmMgWnluZ2llciB3cm90ZToNCj4g
PiAgCSANCj4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cw0KPiA+IHVudGlsDQo+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNl
bmRlciBvciB0aGUgY29udGVudC4NCj4gPiAgT24gRnJpLCAwNyBKdWwgMjAyMyAxMzoxNDozMCAr
MDEwMCwNCj4gPiAiQ2h1bmh1aSBMaSAo5p2O5pil6L6JKSIgPGNodW5odWkubGlAbWVkaWF0ZWsu
Y29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gVGVzdGVkLWJ5OiBDaHVuaHVpIExpIDxjaHVuaHVp
LmxpQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBZb3Ugc2VlbSB0byBoYXZlIHRlc3RlZCB0aGUg
aW5pdGlhbCB2ZXJzaW9uLiBidXQgdGhlcmUncyBhIHYyDQo+ID4gYWxyZWFkeQ0KPiA+IHBvc3Rl
ZCBhcyBhIHJlcGx5IHRvIHRoZSBpbml0aWFsIG9uZS4gQ2FuIHlvdSBwbGVhc2UgZ2l2ZSB0aGF0
IG9uZQ0KPiA+IGENCj4gPiBnbyBpbnN0ZWFkPw0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiANCj4g
PiBNLg0KPiA+IA0KPiA+IC0tIA0KPiA+IFdpdGhvdXQgZGV2aWF0aW9uIGZyb20gdGhlIG5vcm0s
IHByb2dyZXNzIGlzIG5vdCBwb3NzaWJsZS4NCj4gDQo+IFdlIGhhdmUgdGVzdGVkIHRoZSBQQVRD
SCB2MiB3aXRoIE1USyBwbGF0Zm9ybSBiYXNlIG9uIGtlcm5lbC02LjEgYW5kDQo+IGNhbiBjb25m
aXJtIHRoYXQgaXQgd29ya3MgYXMgZXhwZWN0ZWQuDQo+IA0KPiBUaGFua3MNCg0KSGkgTWFyYywN
Cg0KPiBXZSBoYXZlIHRlc3RlZCB0aGUgUEFUQ0ggdjIuIENvdWxkIHlvdSBzdWJtaXQgdGhlIFBB
VENIIHYyIHRvIGtlcm5lbA0KPiBtYWlubGluZT8gaWYgc3RpbGwgbmVlZCBjaGFuZ2UsIHBsZWFz
ZSBub3RpZnkgTVRLIHRvIGRvIHN0cmVzcyB0ZXN0DQo+IGFnYWluLg0KDQpUSGFua3MNCg0KDQoN
Cg0KDQoNCg0KDQo+IENodW5odWkNCg==
