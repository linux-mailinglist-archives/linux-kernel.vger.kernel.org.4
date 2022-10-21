Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AE160748C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJUJ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJUJ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:58:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D7224AAD8;
        Fri, 21 Oct 2022 02:58:21 -0700 (PDT)
X-UUID: 731937eaf742432094ec9e990ecad103-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/ieO7S1AF0pmG/bVSW4I7ES3AOtmawcU7EMFEdP3q8M=;
        b=D8SPfcUbw1W2RzZYodunHCLm7H+VuINGBJbJTiT2q1WwsylXjWv0lpCfxwUs5aRveX3GFa8MSduzYTGkpw/Gv8hPy7XcQeEu6lu80QfGPzzhPhGzKl4L4/P+dZBZ7mdfKaqF0gKbk2Sm5fhXtOHsO9AOjhMZplbQMc5DwR5qHsQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:b0656cfb-30cf-4be3-bffb-8d1e29ca9d0a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:144346c8-03ab-4171-989e-341ab5339257,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 731937eaf742432094ec9e990ecad103-20221021
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1322647872; Fri, 21 Oct 2022 17:58:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 21 Oct 2022 17:58:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 21 Oct 2022 17:58:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0vr8lBq8Gx4on/9kFzb0/4hAUkFILp8mYqBct55Q7z/L6yZL4Wd53qc9jH+yAbVOhE3z6EAsBdGAcqsp2KYjB4++NBE4Tl0X8OTnmcacMijZWnJHEwtaa2PzJzlNSFlYD0v7C4ENaccpGzDn5/ygk3rmmd4mTWARmhW8j0TxmujiO0DLqakshLqDTRkf8/izHKaryY7M6kboGD/uk8vtkXDPP/ii+mpUu0+8VMd+ryn/ByQkpgjkIkvjkxMeiC34CL33gL8Vob3kx+lO24HweL6bms6KG4fG6utpaIsZDrT5UinD4c6oj9p/vLxYZqt00DhvlwEbKvwdASAR/S5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ieO7S1AF0pmG/bVSW4I7ES3AOtmawcU7EMFEdP3q8M=;
 b=A6EKH1q3eCSPLKD+YpQO6LZYA8CYvzUoBX9sQKKFYapqFBTQ62gMtWKszohgiMOgRfwtCf0K7awi+9wyMhoA40OmdltRFOYpeVABIYA4cAX8oNxoskFxNSxlqqdaV0XgsZR4HRW2u2sovtegiVM80a2TW3QZ0lPay9p2o1M5vqM6VKEUsTUIICNB5Lv4gJvepp1VxIErCAl2RBnbsx1R7/6GuO1HcY2fFdYgQHPRtWoiLJHM1YDWzn/8l/moU3ZO/KwRSUQqYYLeBWC2S97byPXIrkhVRcwMhbyzzpjRyaIsFxJJG6YQwo8bI0m0qN0aZ3Gu501WkK8uwMpaqXGQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ieO7S1AF0pmG/bVSW4I7ES3AOtmawcU7EMFEdP3q8M=;
 b=WajBHOA+OJb2vaZWWOeg596SQ6LRqnxiT28wxzwNHqaAzSRrDDLO0I0Bk/Sqt+RC335KU/s0nFXyPOPkdE9b6KB7R+sY50PwCebAHqLgcya21TMRywIA/4lNs2lnKsq8gl0SEjtJMlS8FhXbqnkJbUV6hMKYcp7U0CtCozUExS4=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TY0PR03MB6450.apcprd03.prod.outlook.com (2603:1096:400:1ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.17; Fri, 21 Oct
 2022 09:58:10 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::6c50:1e0c:f9dd:d45]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::6c50:1e0c:f9dd:d45%5]) with mapi id 15.20.5746.017; Fri, 21 Oct 2022
 09:58:09 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 03/12] ASoC: mediatek: mt8188: support audsys clock
Thread-Topic: [PATCH v2 03/12] ASoC: mediatek: mt8188: support audsys clock
Thread-Index: AQHY5Scb0+y44k7XlUu5apSFkxk6/64Yh3oAgAAVdQA=
Date:   Fri, 21 Oct 2022 09:58:09 +0000
Message-ID: <776557c0fda5a538549ee0d4f4b7f482b0d69934.camel@mediatek.com>
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
         <20221021082719.18325-4-trevor.wu@mediatek.com>
         <de66f0e3-7694-7315-c896-9211259a1a17@collabora.com>
In-Reply-To: <de66f0e3-7694-7315-c896-9211259a1a17@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TY0PR03MB6450:EE_
x-ms-office365-filtering-correlation-id: 800238fc-3ff1-4606-d1f3-08dab34ac282
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3d5Y+EVSYfY/KqZDqIfzlPL6GOwU6rgA8HmwExxOX40FcXgegTyTN7ozNRxdqpUX7IWhlRg4GLHSpt8K10BX0ePsvGTku30O2qYSGkJaFf+HZBi737yQfOSXHZfKrKRxkdmpJmJJs/PBYUNw+OFWq0VPO73Z6eStq/HhQEam1f3JSGnldJ1jZBDRqtfxGays02m5gwudh6jjwXLu3eD5/g9rojkTpI3fD4DxwoWALsUyMd1upXswfJnAf6bOMWLbJHflDKpCNlrJ8mY70JyZ+Zc3eZNMThLFphcpdpci+JiECAdnztEAD7c/7IF3bb2uIfRJVGyZxCL2cLQC3YsMs9d2lZ8U7EBzNw3rhTRMQFtjg9IrFRNYP14fjcgAgrWkoIVyNLi1J47a3XINPYVgnNqisOk7ewZai3RsCDg5IOYrgaRUrCHH405YK12y+YwcUHCt9NfPp6EHfcv6ijjCFZbl4BEcepS7XxGDcOO8mB68GgKtTi6Si8oN9+ftdU5wKI2ZACm4pNampJcfXV5Rl+x4w91W/dwCIob+mdn1V6MkHchKgneqlU+zZy/GxuX24f67+ftvadOfegeTWePEvPnU+NJDV3+B401PaPKNfyE7QEonHm849/9pk6l4UVBNlR3zhmzB+mFKdvFLRU212rKvKzVYRsXu/0xRDjsn0nwVje3BKviDOQp1FjSY3Opg+ks7GuswURe3fz+c8uAhS1c+VUX1taek0t6it/EB2uhW/UBoYDOIFbXPTBl8Sf+sfGuWnnfyh71qLuy3jOYIClFFsQzW4fzhA3qAbGbr/zo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199015)(478600001)(71200400001)(36756003)(83380400001)(86362001)(6486002)(110136005)(6512007)(66946007)(6506007)(8936002)(54906003)(38100700002)(2616005)(7416002)(76116006)(26005)(85182001)(186003)(8676002)(2906002)(4001150100001)(122000001)(5660300002)(64756008)(66446008)(4326008)(41300700001)(66476007)(38070700005)(66556008)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MERENUQ2UzNkNWhIS3c4Zk9GUW9vZG9lb2ttRDhxS1hJd2FVREdUVTZROERt?=
 =?utf-8?B?TXcrT2xaUUZxaUN1M3hKYmc1QjhLY0h0ZkRqRlB3Q3VpTno5eWhxV0ZxNzk5?=
 =?utf-8?B?UlJhK2MxUDg0RmhYYS9ZSHFEM0lvV0d6WFYxMWNGK3YzalpJbnJQV0pabEg0?=
 =?utf-8?B?ZHhJWFRzalllVE91ZVdoZU1veWt6UlhXa2ZEeFdhbkdxK0FTNEt3WWFkZEsx?=
 =?utf-8?B?QS96VEVVU0diYTBnMjcrRXRmTzBtczcwYlRFc1BlQU84ejV1dUErOTlOK24r?=
 =?utf-8?B?SERGejJyS3VtUVBFNjcrb0VDdDJ1ZkduL1FtVGZZMzBQZDYwYzdITE1zREJo?=
 =?utf-8?B?a0RQUEgxWjA4bmtkeitDN3VkQzdSWko5eGhraFlzWlpGbFp0Q0lyQTl5K3FS?=
 =?utf-8?B?b21OZXJ5MWNIQVFDeVdZMFdYS0h5dldSUm9Gd1R1OGZTc1hmbnlBV3IvNXl2?=
 =?utf-8?B?OCtaMFhRbU9QT3RzWVBsR0R3b1E2cnFnaHBobloyWGRZTVBJR0cxZ1Z1TlFN?=
 =?utf-8?B?a2xWQ2l2WnZ1SHRSTzZ3NjYzR0lhVlZnTXppa0lrRG43elZpK0Y1Q1ZEMVpa?=
 =?utf-8?B?L2xiNG9RVGVDb0thY0phUUlIVm9JUStzSVM0clFwQ1hkMlJnR1Z3S2xlUGpl?=
 =?utf-8?B?Rmx3VitMN0g5Uk8yTUcrd242bnZXSGJ4Snk1QjdPc3FGaWQrNXgybCtXZXV2?=
 =?utf-8?B?TWNuZUFUb1JpbldFTm9OVUJNVmQzdVNOaWdPUjdkaUtuclBlckJnOUQ4WWpx?=
 =?utf-8?B?TXZFVmlRMVV1YVlCcVdMVGprY1E3QVI4ekNPK1JVUFBTNUhBY2g4d1duNUI4?=
 =?utf-8?B?UU16VXpYVDZKa1h4aWNBZDIzVVdJSENhRVNaZEJOaGxGNFBhb2tRcmxGWEhi?=
 =?utf-8?B?R1kzTW5GcC9hVjl1UHE3SkZZT05ZZG1XRjY3UTFyVmdLak90Qm92OXd4Ulls?=
 =?utf-8?B?Sit6UDBTclBhcWpycHBjc1ZzeC9SaStLRXRiUDZWR0NVNXlQYUFvWU5mV2xE?=
 =?utf-8?B?VkY0VkE0SGRLZEs3aGlkaHI0cGpRQTJzMFFhd09ZTkpsL2JFOWdnM2o2Zy9R?=
 =?utf-8?B?SUtzRFNKL1NmbnE5MEtNU1F5QlRvc0l2L1BJcG9JVlJTbmhpRnpVSGxjdCtU?=
 =?utf-8?B?aCttSlQrSUZFMlZvK3AzejZjV1lxZ2x4UnJXM3F0cUcvNVAxKzM1a01jdGUy?=
 =?utf-8?B?VXgzcDdCbEFTeG9ZNmxRaXU5Z1hGOUdSTE9HU2VTOFB0VVFEN0RWVGttaG5M?=
 =?utf-8?B?UmpFdURxTTY2NVBWZDBVYlZncGJoT1ZodGRrZjFTbFB2UHVZQ050WkhLZXZD?=
 =?utf-8?B?OWwxSU5GeDlLY1JCNnhtc01IUHFyZjZNbS92V3BOZGs1Z0dqalpZL0NuZTNK?=
 =?utf-8?B?UXpCQk81SVdscGhuRnplQm5xbGx5Z2J2bGxkaXg2TzZ1YUlwd1FwUU1JcjBa?=
 =?utf-8?B?Tlk3TXh6U1A2cm1ha0lQRU9hUWY5MzdlUU15OXFJOWhpVmhUazZ2YnZDVDJE?=
 =?utf-8?B?SC9TdlVPZUU3MTBhY2ZYTE5wNXVGOVZyVDFYYVA3and4RE0rQWNVNXRUYWhh?=
 =?utf-8?B?L2I2Qmt6L2NrZ21CUkNvMVBZV2JNR1cwMnRoV2txQXFXVFlKODVDcHFQRjZy?=
 =?utf-8?B?R1FmM1lIL2J5NjZaWXdlSjJGbElOVDJCejlyQmRzMFRTU3VmOWJoMExnS2FT?=
 =?utf-8?B?VmxNeERIcUZ4NjBFSlFiL3RISGNXdURiZ1U3ek5NWDRMMWxWQXdoYU5KR3JW?=
 =?utf-8?B?WlppcU9vZGxxcXZWbDRwSi9FQm9hUmM0ZFAwNzB3TklQbllCdUFxcVljcU5Q?=
 =?utf-8?B?RHZsdGE4OXZBaXh0MnIydnVxaVZ3N2tvajcvL1lCeWp5bzZiM0ZmVzRoUkxB?=
 =?utf-8?B?cC9ZNjlvdjFldDJBbU1XZnlhcFFKd3FFcU5JdUlDb3NhQi9Ed2lxZmRPQmFC?=
 =?utf-8?B?NXBsNnpkdzF5R0h1bjBRUXZndG5EeCtpVUpLTUJWeERTT2Z5L3pFRG9pOVBq?=
 =?utf-8?B?ZS9kYkQ0S3VqQkpFVnJQSks2YXFZbXl6OGEybWc5NHB6cjVzYmZvamJtaDJB?=
 =?utf-8?B?LzhaNnZRT2gvcWFkZnU4U0hCWVNjelRsZUVKNUVkM0dubTQvZ3lldUdIV3lq?=
 =?utf-8?B?TzFDRExab0NIK3MxYTNOeTl2NnVKVVhmSDJ2ajhPMzdWRWg2cnpKcDBjS1lD?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7AD40C0D84EFB4FB6CEB91196C3A3F3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800238fc-3ff1-4606-d1f3-08dab34ac282
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 09:58:09.8026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoAAVmrrGUEIBTlsyxVhLFAH1W/Dk2n+vUdDoAhBNNwLHMEEQxhnEkAXuRmcTlR1kGMuI4WxBSBWrpIFsgtB1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6450
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTIxIGF0IDEwOjQxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjEvMTAvMjIgMTA6MjcsIFRyZXZvciBXdSBoYSBzY3JpdHRvOg0K
PiA+IEFkZCBtdDgxODggYXVkaW8gY2cgY2xvY2sgY29udHJvbC4gQXVkaW8gY2xvY2sgZ2F0ZXMg
YXJlIHJlZ2lzdGVyZWQNCj4gPiB0byBDQ0YNCj4gPiBmb3IgcmVmZXJlbmNlIGNvdW50IGFuZCBj
bG9jayBwYXJlbnQgbWFuYWdlbWVudC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcmV2b3Ig
V3UgPHRyZXZvci53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBzb3VuZC9zb2MvbWVk
aWF0ZWsvbXQ4MTg4L210ODE4OC1hdWRzeXMtY2xrLmMgfCAyMDYNCj4gPiArKysrKysrKysrKysr
KysrKysNCj4gPiAgIHNvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LWF1ZHN5cy1jbGsu
aCB8ICAxNSArKw0KPiA+ICAgLi4uL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LWF1ZHN5cy1j
bGtpZC5oIHwgIDgzICsrKysrKysNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMzA0IGluc2VydGlv
bnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4
L210ODE4OC1hdWRzeXMtY2xrLmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2Mv
bWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1hdWRzeXMtY2xrLmgNCj4gPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1hdWRzeXMtDQo+ID4gY2xraWQu
aA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4
OC1hdWRzeXMtY2xrLmMNCj4gPiBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LWF1
ZHN5cy1jbGsuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAw
MDAwLi4xZjI5NDIzMWQ0YzINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvc291bmQvc29j
L21lZGlhdGVrL210ODE4OC9tdDgxODgtYXVkc3lzLWNsay5jDQo+ID4gQEAgLTAsMCArMSwyMDYg
QEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4g
PiArICogbXQ4MTg4LWF1ZHN5cy1jbGsuYyAgLS0gIE1lZGlhVGVrIDgxODggYXVkc3lzIGNsb2Nr
IGNvbnRyb2wNCj4gPiArICoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDIyIE1lZGlhVGVrIElu
Yy4NCj4gPiArICogQXV0aG9yOiBDaHVuLUNoaWEgQ2hpdSA8Y2h1bi1jaGlhLmNoaXVAbWVkaWF0
ZWsuY29tPg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
Y2xrZGV2Lmg+DQo+ID4gKyNpbmNsdWRlICJtdDgxODgtYWZlLWNvbW1vbi5oIg0KPiA+ICsjaW5j
bHVkZSAibXQ4MTg4LWF1ZHN5cy1jbGsuaCINCj4gPiArI2luY2x1ZGUgIm10ODE4OC1hdWRzeXMt
Y2xraWQuaCINCj4gPiArI2luY2x1ZGUgIm10ODE4OC1yZWcuaCINCj4gPiArDQo+ID4gK3N0cnVj
dCBhZmVfZ2F0ZSB7DQo+ID4gKwlpbnQgaWQ7DQo+ID4gKwljb25zdCBjaGFyICpuYW1lOw0KPiA+
ICsJY29uc3QgY2hhciAqcGFyZW50X25hbWU7DQo+ID4gKwlpbnQgcmVnOw0KPiA+ICsJdTggYml0
Ow0KPiA+ICsJY29uc3Qgc3RydWN0IGNsa19vcHMgKm9wczsNCj4gPiArCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQo+ID4gKwl1OCBjZ19mbGFnczsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyNkZWZpbmUg
R0FURV9BRkVfRkxBR1MoX2lkLCBfbmFtZSwgX3BhcmVudCwgX3JlZywgX2JpdCwgX2ZsYWdzLA0K
PiA+IF9jZ2ZsYWdzKSB7XA0KPiA+ICsJCS5pZCA9IF9pZCwJCQkJCVwNCj4gPiArCQkubmFtZSA9
IF9uYW1lLAkJCQkJXA0KPiA+ICsJCS5wYXJlbnRfbmFtZSA9IF9wYXJlbnQsCQkJCVwNCj4gPiAr
CQkucmVnID0gX3JlZywJCQkJCVwNCj4gPiArCQkuYml0ID0gX2JpdCwJCQkJCVwNCj4gPiArCQku
ZmxhZ3MgPSBfZmxhZ3MsCQkJCVwNCj4gPiArCQkuY2dfZmxhZ3MgPSBfY2dmbGFncywJCQkJXA0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArI2RlZmluZSBHQVRFX0FGRShfaWQsIF9uYW1lLCBfcGFyZW50
LCBfcmVnLCBfYml0KQkJXA0KPiA+ICsJR0FURV9BRkVfRkxBR1MoX2lkLCBfbmFtZSwgX3BhcmVu
dCwgX3JlZywgX2JpdCwJCVwNCj4gPiArCQkgICAgICAgQ0xLX1NFVF9SQVRFX1BBUkVOVCB8IENM
S19JR05PUkVfVU5VU0VELA0KPiA+IENMS19HQVRFX1NFVF9UT19ESVNBQkxFKQ0KPiANCj4gQ2Fu
IHlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0J3MgdGhlIHJlYXNvbiBmb3IgQ0xLX0lHTk9SRV9VTlVT
RUQgaGVyZT8NCj4gTWF5YmUgd2UgY2FuIHNvbHZlIHNvbWUgaXNzdWUgdGhhdCB5b3UncmUgZmFj
aW5nIGluIGEgY2xlYW5lciB3YXkuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCg0KSGkgQW5n
ZWxvLA0KDQpCZWNhdXNlIGNsa19kaXNhYmxlX3VudXNlZCgpIGNhbGxzIGNsa19jb3JlX2lzX2Vu
YWJsZWQoKSwgcmVnaXN0ZXINCmFjY2VzcyBoYXBwZW5zIGluIGlzX2VuYWJsZWQoKSBvcHMuDQpB
dCB0aGUgbW9tZW50LCB0aGUgcG93ZXIgZm9yIHJlZ2lzdGVyIGFjY2VzcyBpcyBub3QgZW5hYmxl
ZCwgc28gdGhlDQpyZWdpc3RlciByZWFkIHJlc3VsdHMgaW4gQ1BVIGhhbmcuDQoNClRoYXQncyB3
aHkgSSBhZGRlZCBDTEtfSUdOT1JFX1VOVVNFRCBoZXJlLCBidXQgaXQgY2FuJ3QgcmVzb2x2ZSBh
bGwNCmlzc3Vlcy4gQWN0dWFsbHksIHdlIG1ldCBzYW1lIHByb2JsZW0gd2hlbiAiY2F0DQovc3lz
L2tlcm5lbC9kZWJ1Zy9jbGsvY2xrX3N1bW1hcnkiIGlzIHVzZWQuIFdlIGFyZSBzdGlsbCBzdWZm
ZXJpbmcgdGhlDQpwcm9ibGVtLg0KDQpJJ20gbm90IHN1cmUgaWYgSSBjYW4gaW1wbGVtZW50IGNs
ayBvcHMgYnkgbXlzZWxmLCBhbmQgZXhjbHVkZSB0aGUNCnJlZ2lzdHJhdGlvbiBvZiBpc19lbmFi
bGVkKCkgb3BzLg0KDQpUaGFua3MsDQpUcmV2b3INCj4gDQo=
