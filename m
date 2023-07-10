Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB5574CAAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjGJDkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjGJDkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:40:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2A3AF;
        Sun,  9 Jul 2023 20:40:03 -0700 (PDT)
X-UUID: 725cdb821ed311ee9cb5633481061a41-20230710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JyWfrhEZjo1luEMOULfxzx5uSOMMZ4xEyq4nxhKPFj8=;
        b=GsBZ+4tVBVK3piZjUwwHDetFaS5cvArPO/vzLRhM84qKXBNEAYZneqeVecIjK7EmUJ8Di8GO5fNxAitJiGgeOUR5foKA5oq+Lcd6BARlgUkTQoSB6aQkqsW9NdHza2B/pEmaufEBM4i/KSWuGPmIjJtfUjpJmHtUPnanY1PoUbo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:f8d988c4-9740-4dfb-bbff-29ab02023a70,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:a1df0a68-314d-4083-81b6-6a74159151eb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 725cdb821ed311ee9cb5633481061a41-20230710
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <chris.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1630765959; Mon, 10 Jul 2023 11:40:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 10 Jul 2023 11:39:58 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 10 Jul 2023 11:39:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky+EgAwkezfP6DroCJBQPStvS4ToaWD5yx+Vb2HfZwJ1QzrTyeJQ0EKKhJTTf6yGAKf8UjpwfkyjwFgYeuWCXFR3KCRNHmTn08erSZ1+DX0qCxTFAREyGrimKOVFRmRRR/mLULdRQaV39tsWZh8hxXiPtxd6ltArJApDK1A8Z/mZrbZ+43Ekmgc51c/cYZj0TU9W3TpNBimwHfz7ECg72HQQvRDlDh7I4fGh18IpqF8HSuOvvac05qXghi5Y5by7Ng9D5PFI/lEtc9debUeL3yRPB2yB5cuPBkfB8loWx/+tVdiXis6Xs+XLI37LnA1DFLdcmofbzeuYNNeg60PAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyWfrhEZjo1luEMOULfxzx5uSOMMZ4xEyq4nxhKPFj8=;
 b=NcJfP0M0sl6F6Dh2RzzblJHpii517Ze1GMcaNOEj5QOffvGKKbGbThoUIUNs7NABrSFto7JMFmEnlkXYke9D1syjfFxlRQEcCKXz+xaK7CPFnCFIyjNyPoaiwwziN7t4FRMszHcAg1/Qa0ddoPI+xMaav2UXj2prVNms7nGc5Q71TFkEnMhnEbdkffVknM9aZkUZ74FbdKF8dcJGsK+PDbHAgxij4od4tPklh2LexHuA9a4FqFDG8JRKWBfWo7FZ5Zcs8Y++jBfho1x5v35eMtKtzzQktURohDHY82G8zm0jNawFqo+6qqNOieLkOlWjAvaKjz+H2L9Ndelv0cdSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyWfrhEZjo1luEMOULfxzx5uSOMMZ4xEyq4nxhKPFj8=;
 b=QF6NoqcrxfUsjFfCLrmzXHBA7rYUHeR6VS+weYohqRUYAx9SCaTqLhB1fP5uyxf0A054j96R0q92Ic2s6Nch/2VImPG3c1vbO0yhua9qWVaBUMtcT4ENFyhw0rGeBzKfCSLRRLlNJEsNht+0EK8zZ95BExehfqkmsBVZOpJCOI0=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by TY0PR03MB6473.apcprd03.prod.outlook.com (2603:1096:400:1bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 03:39:56 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::8dfd:d707:163c:f0e7]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::8dfd:d707:163c:f0e7%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 03:39:56 +0000
From:   =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To:     "rgammans@gammascience.co.uk" <rgammans@gammascience.co.uk>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        =?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: btusb: Add new VID/PID 0489/e102 for
 MT7922
Thread-Topic: [PATCH v3 1/2] Bluetooth: btusb: Add new VID/PID 0489/e102 for
 MT7922
Thread-Index: AQHZsJx4u0gLE0A97EmMEvPBnneGAa+uNTeAgAQp8oA=
Date:   Mon, 10 Jul 2023 03:39:56 +0000
Message-ID: <72f8b7c4e01333452f65786f7fab49c11c9f2d52.camel@mediatek.com>
References: <20230707062959.30371-1-chris.lu@mediatek.com>
         <20230707120444.GA32181@computer-surgery.co.uk>
In-Reply-To: <20230707120444.GA32181@computer-surgery.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|TY0PR03MB6473:EE_
x-ms-office365-filtering-correlation-id: 17049410-1852-46f9-230b-08db80f75485
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: syRP58A+o6ZYe1hEUmB+tDMNbsOo/zhm7GUG8ukLDNiY6zj0bnYsh6rc2Aicuoo6uFmXQZBDPahgpp4seOQAZpTA+ikASKagSF4ewDBXxWX2HD2l+hpBtCpCvw256OaPBFvBuQ5PsvDyHAT/2yZ3vm+zTtpt3ck2hOfPt272uNDIztCB46HoMBKDH2GSHcW19He7TSlTWXMleFjsUcwU6xhkh2zWq+73GPh9RbZA4ie5/khj/7QTMrCcnjFi7Silf7z21Gmm6jw4VPN9sQAODrBBW16RZIMnMghZ4kCMB8K/Tmpmi7XDLCzQ7bpny/+cvYNOn7fOHjC/Hqs/7p/0QpcoBzN3tzzCZYD6DGIAwkRzUoqOWdHjYzrExqGxRWhAIwukBRHq7jxtEM0prYDZNju2FAMHlEkyueQka8AWE3edxb4XL9wRZzw+Cfu4wl6KwJJmFWjdgDjwpSok/9SVoBq7EYwavv+KpeTK34878sJx7W/N62mezsT5DqHkIrbzIPbrXLOTYoYNXp4neFyG9aBOriMC+8K1Ap0OWhJgeHwlXXtLBd4g2oVMxgPu0aAuiv+brXJLK/T1f10YIqKf5pqMcqAdEvvw9x7mVPM1P17/HWO5jeRhktYWHrC6ROMkAt8r1/au8L1t9FVybTYZC8kQ469LjSIR0bFpLouVMrg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(6486002)(478600001)(76116006)(71200400001)(54906003)(6506007)(26005)(6512007)(186003)(66946007)(2906002)(66556008)(41300700001)(66476007)(6916009)(4326008)(66446008)(316002)(5660300002)(8936002)(8676002)(64756008)(38100700002)(122000001)(2616005)(38070700005)(86362001)(36756003)(85182001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk94S24zZU5YRVFVSERUL0ZISU1YMHhYTXBzLzJwL0NSQko3NWdjdHVMaGdi?=
 =?utf-8?B?dDQ2S295VHVweEhXdTR1YnRYb0ZTUXlocXl1ajYvM3ROVVpPUUVsQ0ZNNklC?=
 =?utf-8?B?Smc5endHWWR0NDg3RnphdXNrLzRBY3pnY0VFeStUeHNQTWNyK3RqY1ZJNXFm?=
 =?utf-8?B?aWs5cHFGeG5rRDRkaFYxc2lBblc1YWxxNVNNbFZXaTVlWENnVk1rUUd0OWMz?=
 =?utf-8?B?RzcrT3hFOTA3NTVjRFJHWU5idGp1YjV3Z2dUcklZT2ZObS9MWEQyNVZERkhq?=
 =?utf-8?B?NTNCWEw1MVNIU2RlKzhxTWE5S1JBVmdNUlFyRGZ3cEdLQkNJaCtkeHN6Y2Z4?=
 =?utf-8?B?citYTEpCaktCSy9wME1hNllobTZsWUpPbmV1akhOWWlWYW1tZVI3dGNTZ1du?=
 =?utf-8?B?cSsrbWlsSzVNU3lrMk8yYjUvR1ZXcG85WVZkOUxLVG9aTFZ2Z3pUa0FmQWI5?=
 =?utf-8?B?YU1iZEdFUHpLMm0xMGowV2s4QU1mN05xZi9QamtXMFJyWlBEa2FtVVo1aGVD?=
 =?utf-8?B?UGFHTjNVYm1QdjMreG11QlU0eW9rSHltSks2am9sOHh4NVRjYmt0UnFnSzU3?=
 =?utf-8?B?L3pGZzFSMytMQXdmWko0T0FzMnVORUpUTE5qY0FjemN5dnYvQ1U0Wm9pcXBH?=
 =?utf-8?B?M1N2a3JYMk5SeTF5WktJblErMittWWdpYTZSZHJHSWs0OG5wbGw5VmtjTVBI?=
 =?utf-8?B?UXF6SHg4R1RBUlNoUGM2a1hCclhGa2J2NnpiUzJnT3pCSlVnaXhVVnRrbmFx?=
 =?utf-8?B?dVRQSFlvVWJJaDdhODZWYWdpbXlTU1hrQWRSaHlqS0hIU2ZxTVJ5VjR4Wms3?=
 =?utf-8?B?T3FRSWpZcE5QOElrckc4OE1lcmlJZ0pqakR4VHhOWTI5QjM4WUVaclNaT1E1?=
 =?utf-8?B?TUgyc2E1c0x0S09DQjdOM1RjcFdxWmJoTUwzK1kxaU1rWTRtWWRsWTBhUlc2?=
 =?utf-8?B?VVhWNDJ2VzJaK1ZMR2d5VkxVNXczSXpDZjhhbkgyUG95WFZYL0VROWpkamlY?=
 =?utf-8?B?bDZKcE80UHFqSWE4TVJPQjdHMkZ6c1hVVnJHZTBXY1VHREJOTWFGUXdVTXRD?=
 =?utf-8?B?elA5SDJFeG4rOXFHSGNmVEc4OSsrYU9OYkh0d3lxMWRZUnUrTXdWQlkzV1gw?=
 =?utf-8?B?Y2dCYnoybUQ1ZERmRDNDdDZPOGxvWFVxM084SitHcU5UNUpXWXZ1anNra0pL?=
 =?utf-8?B?Z0JFK2xUaWJUQVM4S2pqOWRTRGVXUEZHVTE4UEhsRWZ5OTNsUkdQbkgzWi80?=
 =?utf-8?B?R0xDK3RKeUFJa0xEQ3d3SVBaQVJYL2pIRzZuRG9kcUtjU1E5amI1R2k1eWZ1?=
 =?utf-8?B?alh4QlN1V2M0ZjJQK2JvY1JuNjBSemZGZi9xbE5qZW1DUzBRNmVnaHc1VFBL?=
 =?utf-8?B?UzJEdjNXYnJ6RTV4SnovZCs5VTM5VU93MVNJbmJxamo1aEx4dVhCS3ZybCtJ?=
 =?utf-8?B?V0IrOFlmVUxPdWtRUUVHMElQcVc1MWpRd2pWM1E4d3RyWjhyRVhITXNmb1JN?=
 =?utf-8?B?cXh5Zll5TE1wcnVsTDJGUCtWTzdueWUwN01GQUlKSWwzdkQrcUNXelVSV1Rt?=
 =?utf-8?B?MkFsS0ZqL3owLy9CMTlPVVd5WGI3OFFSYXcycEltYXFLQnRweFdHUEV5QW5J?=
 =?utf-8?B?NTdUZjFJd3FiL1RuUnF2bEZvQnFCMHhBZzFlRER3NC9LUzkvZG1SVmM3RU5Q?=
 =?utf-8?B?T1VTWHRsWThBWDZtd0tCSlZYMUxWa3J3VG4xeXBsakRLc0xucy9GaXZ3a1RL?=
 =?utf-8?B?aERmRHdaakp4eEtEeWZqUUFuN3EvZ1lXZjQwVnhWNmRBaTR3eG5QQWRXRzlG?=
 =?utf-8?B?UFpJSFJVWVZBdXJGU1BNcEdad3Y1L2x1ZXFtN1dobGE2MXJya2JqYUhwUEl2?=
 =?utf-8?B?L1IwWlN0ZU8wdlFHWVdLTXUxVUFuYjVUVXdUYjYybXh5aUZXdHczZDdxcVR5?=
 =?utf-8?B?S0QyL3czZDRSajBDYTdCczBiT3VXV0ROR0hGK045NUNOV3RYUi9nTm5ES1p4?=
 =?utf-8?B?VXJGUVd5QS9ZaDRiOTl3RjFrbTVUeWxBQ1VOamZ6V0xYZER6UEUyTkNVL3lC?=
 =?utf-8?B?eW14bUxlWm9qdjlNSk14cGFFdGovNnhTaGpIdHZTbTRQUjBOWXNNZThIc3Jo?=
 =?utf-8?B?QVNlQkpyY1hPcXJaRHlyNWxtcjQvUWpyQ2NDb2g4ZmJTbm1jbzBubyt4QXc3?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2E697FEC39CF24AB61C9998130AF7F3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17049410-1852-46f9-230b-08db80f75485
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 03:39:56.5869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwGqffRiaqVvCbuM04fgFZVKPZSTNdafOFyEg/mskRBe/fFmSoQP+Dn0Kr8NI/UGWokFTXWOxmIJpGBpBH29LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6473
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTA3IGF0IDEzOjA0ICswMTAwLCBSb2dlciBHYW1tYW5zIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIE9uIEZyaSwgSnVsIDA3LCAyMDIzIGF0IDAyOjI5OjU4UE0gKzA4MDAs
IENocmlzIEx1IHdyb3RlOg0KPiA+IEFkZCBWSUQgMDQ4OSAmIFBJRCBlMTAyIGZvciBNZWRpYVRl
ayBNVDc5MjIgVVNCIEJsdWV0b290aCBjaGlwLg0KPiA+DQo+IA0KPiBJJ3ZlIGJlZW4gdGVzdGlu
ZyBhIHNpbWlsYXIgcGF0Y2ggaGVyZSBmb3IgMDQ4OS9lMGYxLCB3aGljaCBpcyB0aGUNCj4gdmlk
L3BpZCBJIHNlZSBvbiBtIG15IERlbGwgSW5zcGlyb24gbGFwdG9wLg0KPiANCj4gDQo+IERldiBp
bmZvIGlzOg0KPiBUOiAgQnVzPTAzIExldj0wMSBQcm50PTAxIFBvcnQ9MDIgQ250PTAyIERldiM9
ICAzIFNwZD00ODAgIE14Q2g9IDANCj4gRDogIFZlcj0gMi4xMCBDbHM9ZWYobWlzYyApIFN1Yj0w
MiBQcm90PTAxIE14UFM9NjQgI0NmZ3M9ICAxDQo+IFA6ICBWZW5kb3I9MDQ4OSBQcm9kSUQ9ZTBm
MSBSZXY9IDEuMDANCj4gUzogIE1hbnVmYWN0dXJlcj1NZWRpYVRlayBJbmMuDQo+IFM6ICBQcm9k
dWN0PVdpcmVsZXNzX0RldmljZQ0KPiBTOiAgU2VyaWFsTnVtYmVyPTAwMDAwMDAwMA0KPiBDOiog
I0lmcz0gMyBDZmcjPSAxIEF0cj1lMCBNeFB3cj0xMDBtQQ0KPiBBOiAgRmlyc3RJZiM9IDAgSWZD
b3VudD0gMyBDbHM9ZTAod2xjb24pIFN1Yj0wMSBQcm90PTAxDQo+IEk6KiBJZiM9IDAgQWx0PSAw
ICNFUHM9IDMgQ2xzPWUwKHdsY29uKSBTdWI9MDEgUHJvdD0wMSBEcml2ZXI9YnR1c2INCj4gRTog
IEFkPTgxKEkpIEF0cj0wMyhJbnQuKSBNeFBTPSAgMTYgSXZsPTEyNXVzDQo+IEU6ICBBZD04MihJ
KSBBdHI9MDIoQnVsaykgTXhQUz0gNTEyIEl2bD0wbXMNCj4gRTogIEFkPTAyKE8pIEF0cj0wMihC
dWxrKSBNeFBTPSA1MTIgSXZsPTBtcw0KPiBJOiogSWYjPSAxIEFsdD0gMCAjRVBzPSAyIENscz1l
MCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6ICBBZD04MyhJKSBBdHI9
MDEoSXNvYykgTXhQUz0gICAwIEl2bD0xbXMNCj4gRTogIEFkPTAzKE8pIEF0cj0wMShJc29jKSBN
eFBTPSAgIDAgSXZsPTFtcw0KPiBJOiAgSWYjPSAxIEFsdD0gMSAjRVBzPSAyIENscz1lMCh3bGNv
bikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6ICBBZD04MyhJKSBBdHI9MDEoSXNv
YykgTXhQUz0gICA5IEl2bD0xbXMNCj4gRTogIEFkPTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPSAg
IDkgSXZsPTFtcw0KPiBJOiAgSWYjPSAxIEFsdD0gMiAjRVBzPSAyIENscz1lMCh3bGNvbikgU3Vi
PTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6ICBBZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQ
Uz0gIDE3IEl2bD0xbXMNCj4gRTogIEFkPTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPSAgMTcgSXZs
PTFtcw0KPiBJOiAgSWYjPSAxIEFsdD0gMyAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFBy
b3Q9MDEgRHJpdmVyPWJ0dXNiDQo+IEU6ICBBZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQUz0gIDI1
IEl2bD0xbXMNCj4gRTogIEFkPTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPSAgMjUgSXZsPTFtcw0K
PiBJOiAgSWYjPSAxIEFsdD0gNCAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEg
RHJpdmVyPWJ0dXNiDQo+IEU6ICBBZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQUz0gIDMzIEl2bD0x
bXMNCj4gRTogIEFkPTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPSAgMzMgSXZsPTFtcw0KPiBJOiAg
SWYjPSAxIEFsdD0gNSAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVy
PWJ0dXNiDQo+IEU6ICBBZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQUz0gIDQ5IEl2bD0xbXMNCj4g
RTogIEFkPTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPSAgNDkgSXZsPTFtcw0KPiBJOiAgSWYjPSAx
IEFsdD0gNiAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPWJ0dXNi
DQo+IEU6ICBBZD04MyhJKSBBdHI9MDEoSXNvYykgTXhQUz0gIDYzIEl2bD0xbXMNCj4gRTogIEFk
PTAzKE8pIEF0cj0wMShJc29jKSBNeFBTPSAgNjMgSXZsPTFtcw0KPiBJOiogSWYjPSAyIEFsdD0g
MCAjRVBzPSAyIENscz1lMCh3bGNvbikgU3ViPTAxIFByb3Q9MDEgRHJpdmVyPShub25lKQ0KPiBF
OiAgQWQ9OGEoSSkgQXRyPTAzKEludC4pIE14UFM9ICA2NCBJdmw9MTI1dXMNCj4gRTogIEFkPTBh
KE8pIEF0cj0wMyhJbnQuKSBNeFBTPSAgNjQgSXZsPTEyNXVzDQo+IEk6ICBJZiM9IDIgQWx0PSAx
ICNFUHM9IDIgQ2xzPWUwKHdsY29uKSBTdWI9MDEgUHJvdD0wMSBEcml2ZXI9KG5vbmUpDQo+IEU6
ICBBZD04YShJKSBBdHI9MDMoSW50LikgTXhQUz0gNTEyIEl2bD0xMjV1cw0KPiBFOiAgQWQ9MGEo
TykgQXRyPTAzKEludC4pIE14UFM9IDUxMiBJdmw9MTI1dXMNCj4gDQo+IEkndmUgb25seSB0ZXN0
ZWQgd2l0aCBrZXlib2FyZC9taWNlIEhJRCBkZXZpY2VzIHNvIGZhciwgaXMgdGhhdCANCj4gZ29v
ZCBlbm91Z2g/DQo+IA0KPiBBbHNvLCBkbyB5b3Ugd2FudCBtZSB0byBzZW5kIGEgcGF0Y2ggb3Ig
aXMgdGhpcyBlbm91Z2ggaW5mbyA/DQo+IA0KPiAtLSANCj4gUm9nZXIgR2FtbWFucw0KDQpIaSBS
b2dlciwNCg0KVGhhbmtzIGZvciB5b3VyIHJlcG9ydGVkIGFuZCBpbmZvcm1hdGlvbiwNCkhvd2V2
ZXIsIGR1ZSB0byBvdXIgY29tcGFueSdzIHBvbGljeSBhbmQgbGltaXRhdGlvbiwgSSBvbmx5IG1h
aW50YWluDQpCbHVldG9vdGggZHJpdmVyIHRvIHN1cHBvcnQgc3BlY2lmaWMgcHJvamVjdCB1c2lu
ZyB1cHN0cmVhbSBkcml2ZXINCmFuZCB3aGljaCBiZWxvbmdzIHRvIE1lZGlhdGVrJ3MgY3VzdG9t
ZXIgY3VycmVudGx5LiBWaWQvUGlkIDA0ODkvZTBmMQ0KaXMgYSBNVDc5MjIgbW9kdWxlIGZvciBX
aW5kb3dzIFBDLg0KDQpXZSdsbCByZWNvbW1lbmQgdGhhdCB5b3UgY2FuIHNlbmQgYSBwYXRjaCB0
byBzdXBwb3J0IE1UNzkyMiBCbHVldG9vdGgNCm1vZHVsZSB3aXRoIDA0ODkvZTBmMSBieSB5b3Vy
c2VsZiBpZiB5b3UgbmVlZGVkLiBPdGhlcndpc2UsIHlvdSBoYXZlIHRvDQp3YWl0IHVudGlsIHRo
ZXJlIGlzIGEgbGludXggcHJvamVjdCBhZG9wdGVkIHdpdGggdGhlIHNhbWUgbW9kdWxlIGluIHRo
ZQ0KZnV0dXJlLg0KDQpJJ2xsIGFsc28gbGV0IG15IG1hbmFnZXIgYXdhcmUgb2Ygc3VjaCBzdXBw
b3J0IHByb2JsZW0gdGhhdCB1c2VyDQpjaGFuZ2luZyBPUyBmcm9tIHdpbmRvd3MgdG8gTGludXgu
DQpTb3JyeSBmb3IgdGhlIGluY29udmVuaWVuY2UuDQoNCkJScywNCkNocmlzDQo+IA0K
