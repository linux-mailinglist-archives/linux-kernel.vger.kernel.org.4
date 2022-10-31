Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660DC6130BD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 07:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJaGuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 02:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaGue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:50:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008099FD1;
        Sun, 30 Oct 2022 23:50:28 -0700 (PDT)
X-UUID: 0d4d35320d504660b4e2d91c714b3867-20221031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AOFroBfhTbtG2ArC0Xg4eUrULQdnyedBj303pg/05qk=;
        b=Pc+jGHO4OtEQgd85KfU6ZgOtgPV0QNnm6edn4lczz3v72Fyi6Gj89TS4vzU+4wZbbxVdCk6EmxtUohWqM7rj/1y/FNm7s51y58ZJ3lNXZ1xx9c96Sx8n4XcTdZ7jxnSiRPOS6N5NglcnjMwmQ7XvUziugHFWs/cfj0Q0U44VWXw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:dd2f4619-bb2a-45e0-9e2b-19f75b9c37b3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:5e61efea-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0d4d35320d504660b4e2d91c714b3867-20221031
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 346907239; Mon, 31 Oct 2022 14:50:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 31 Oct 2022 14:50:21 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 31 Oct 2022 14:50:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv6vslCcAtX90wInyrN36b/1GOOgcmrQgHGWwsYjVa5cVgU28eqtxGCIsaQmuBRoT/OsQGf/cGIBJtTkZxRR4Z/wHYd2HDZf6FJVC5KtcXqqNITjssyxtrE7a/UxqEe0JFxh0Eb96vSKnKkZOIgFeLbjvIGSnMPL+5TUJbdj8YMt9hrKhDUi5xh3JzaqaJ7l/uXux4rwlfVawpE2WT5qQ4di8bJjjCATqEBuZg25doDkWn/bp32AsQ7/subju40YMvb4/qChT3uM8SkPDkvb6Bc6XPMEc5ljJ5UTrSfL8h29BI6N7LutnpRleqEnIAu0fWEiki2RdKiLkRZvwRLLkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOFroBfhTbtG2ArC0Xg4eUrULQdnyedBj303pg/05qk=;
 b=Iw6ngddr/JQX8N57QkaE2Dtni0un2+3/QJ4csRq9CWYpFjE0kQciO8nQSLU1N6bS8krXw6N46/M57+673ExnyPGv65rGhghtB1dtEYR4omWapGSA6YnL+2pPOzM0LLvR7VJfZ/C0EjY1qDSxd+CpnWW5dr7mhSYH7Ant3kDQ9lND98RtS56B3HbLssefe20VNB55zwZKqGy5ZKkJUZIvLaZmMxrsNuGYdrfANnFHYO94VgoHb2JtMLJa3PZ6r2FHUDKAtsSptTLKOF3KBe7K9hsvEleX+zn6jSvW50fHKWAz0rKt3cxi2SKhwqWM91Shx8JKpXo2x64Qfn9E/GxJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOFroBfhTbtG2ArC0Xg4eUrULQdnyedBj303pg/05qk=;
 b=RkMzjVcYVjHIQ+q6sm0Yg5EDVwE8dknNhIr9rl3KpwjHWLX0dw/hWn7xfCySbZh3y0nfBfub0mCEfUWxLS1HUFZQcqqWzDoJiE9VYuf6fjjY1iIW2UFow1otD+UPJO2BNuGZQ/1X3T5zzxza5WI3j0pJKEyIqEb9uEdIfXK6OIU=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by PSAPR03MB6330.apcprd03.prod.outlook.com (2603:1096:301:5b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.17; Mon, 31 Oct
 2022 06:50:19 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3438:1068:ae0:32cd]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3438:1068:ae0:32cd%2]) with mapi id 15.20.5791.017; Mon, 31 Oct 2022
 06:50:19 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Topic: [PATCH v2 10/12] dt-bindings: mediatek: mt8188: add audio afe
 document
Thread-Index: AQHY5ScFWHLYnLzLOUayQJYsxOuXFK4kikGAgAOVg4A=
Date:   Mon, 31 Oct 2022 06:50:18 +0000
Message-ID: <e91478462f360ab50092f64a895f5204a4f5ba96.camel@mediatek.com>
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
         <20221021082719.18325-11-trevor.wu@mediatek.com>
         <1cd3a240-886e-82cb-e821-74f82f1afec1@kernel.org>
In-Reply-To: <1cd3a240-886e-82cb-e821-74f82f1afec1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|PSAPR03MB6330:EE_
x-ms-office365-filtering-correlation-id: 63c63d85-446c-4687-ee4d-08dabb0c2ca8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IvpussJgle+hKQDW1nnk0KWrBxGytGZe6iKU/Q/gVfb2Dduq7XD93Stdlm+VqYanlqk0Ed+nOH6D/clN36KPNNW9sQF6XNFN0Wbd6mhK3uLDDDNIqu05kLbUXycGSI8284z6t5qrJWbmGOm5FQuDPlnfDrgx9eTvHQ+PwK2lzY0xye3gnqf2kqDQMg7kVHXHylY6XtP3dKosXAOBb7/ONOpfTMANLNasZSc152qAvVtKfPvqFyCOvx7UeQIqkXLGEadmyX5xkBTBvKkbyZ5LZtHZWbyIrHnQCQri6+4sGm+ZqC9o8yDrUhCVEcjW2RgMrepkiqB2hE0vxhPXe+0krD4AsV49i+M2Zi/Lebn7G3f9uJg+5v97xwdgmPhGm6rZv+qPqKFgkRLb7ViXh3Jgz5cp+GaZ9waCxx4q0oD0lFEJ7hNwjRuHF0r9dfTI5WegEx4/dmYS6zirLW3kl0nEgI6wuyvoZtlJe65gmbts+xVsTEDWYEu/UN+The2n/S7O5edKG5LxIBUi166l0OSOcDZSCalsiAaItcC7gRNUtQy235eyUI08EtPYgjMZqLgF1zxqk/smJk9NbpYs1/A2vPhlEje2vfbrKyhPoU0xO1buzC/jxdC6QymlP4P2lRQaQ1wq7LwvrsNAROM82qXAsUSH3NHt8FpIw5jsGTPGquhLZqXqdjhT2/B5VGaoXtnFjHhyxnCpIZXEk+w62q+PJ42JvzJoui0vySprPGo6t9kZ/lci5zTS9svj7qldYR/7XDoMyebc9csGpyKUVrOlp0PciZ7j7UJ6XXciSOqVc1Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(83380400001)(6486002)(2906002)(71200400001)(4001150100001)(122000001)(86362001)(38070700005)(36756003)(85182001)(38100700002)(53546011)(6512007)(26005)(2616005)(186003)(91956017)(66556008)(66946007)(66476007)(66446008)(64756008)(4326008)(316002)(478600001)(8676002)(6506007)(76116006)(41300700001)(7416002)(8936002)(54906003)(110136005)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTBiT2JVVnJ1NEc0QjdMNkxwdStRS25PTU8zQmRaNTc1SkZJSGxLWUMwYzFY?=
 =?utf-8?B?aGRiT2p2dEtqbE52NW1YN0NadkgvSGx6OVY0V0dxUTQyMWtlbk9FdGlPWU9S?=
 =?utf-8?B?cHBrU0F2cGVBSmxUTkV3SzVabm52d3BQaHVLWFd3ckZKMVREUUxuTjA3NSs4?=
 =?utf-8?B?ZmVrUFk4TU1LRjZSM1FaOEtncHFFeCtLUkZucm5MSEtYcXdJRTZnU0VHejVS?=
 =?utf-8?B?a0pFVllRUGpMWWJTWTdYZXFyZXo1TnROZ0FEMityMTN0RHMvcmJJTEtaQ0hN?=
 =?utf-8?B?Z2F3T01seU9jaFBXRWN1MFcyaGxVSFB0NHYwSDdkZVplaHZuMHcrU3UvK3Ja?=
 =?utf-8?B?M3R1R0lQNGNMNWtuQWUrenl0TFB6amNRNzIvbjFNbklhUkJPbnlCd3Vxa3oy?=
 =?utf-8?B?RENqNmNKNXlMUnZCQ0JyRy9vWERKblQ1c0tHbFhoYjFLd1FPTlU4WHhESUFt?=
 =?utf-8?B?emR4MXVpWS9RVGhKNHgwSXpMUWJjd1hqTXplaGJZcXQ5NlZSSXF6WWl0MVN1?=
 =?utf-8?B?U2JTQnFTZFo2NWpmeGlFcFJvc3pMNXZPLzQ5S0hhTnNBcks1RDh4Wi9aZmtB?=
 =?utf-8?B?anhXUWlYZlc3WWgyQmd2ZGwvdUJZRHB4YVUwVytaVy9RRGpIQXBnM203U2NX?=
 =?utf-8?B?NTQyQnNMcUtJV0hLbm00Z3h5RWg5YTQxaDBjeG51SUFpdkt0Wm1tbDVLcldS?=
 =?utf-8?B?NmNCSVlra3ZTYzdqWXF3aUs3Z0p2QTlJbHFYbTNJZmNua0RxR2swbGh5MlQr?=
 =?utf-8?B?TWwxMTlwQnFKemdWVGFUaFZMc01yVFFHMTR2Z1dvZjNlYVpXUnF4K3p1bjFG?=
 =?utf-8?B?VXh1TGh5MWtaUmxUS1dwY09pcC85bUpxYW9RVlNWcXlwZFpCeE11TUNvVk5Y?=
 =?utf-8?B?TElPZ012aENyZmMyVW9Yb3FTM3hDWjAzOFRRYXJSWFJJWjQwOWw5MCtCRm42?=
 =?utf-8?B?K0J6NURCTkJWT0I1cmx4SHJoRVVXc2lIaDNxYjdqc2pmSmhPL2VraDR1NkVu?=
 =?utf-8?B?UkNnNDlpa1ZDUyszSVBVZ3NWNWVPNTAxcjUyOVd0U0ZFSWwrcEJ2N1BCdmFP?=
 =?utf-8?B?QTk1S2Rsd05Odi9xS0YxVHNWVFUrQ1VVVlpBQjBnQnhsanNzMElVQjBQdTlm?=
 =?utf-8?B?UXdSY2ZLRWZqZnA1Wi85WXNiT1Jtd3YwMFVPcmxnUTEzUThEVGFVY0JSaEFN?=
 =?utf-8?B?dVB5R2UvS0JwTzdlYURRbVc0VWJvbTVuUW84cE5LalNiQlNXQXNtYXd2MmFQ?=
 =?utf-8?B?QytnbU9ycldBOEtKcUJuQm4wZ0h5WjdJTGN5dVd2SlJWZzl3QTRuZjZXSlZz?=
 =?utf-8?B?NkEydzNaWVJycnN4Z0FwOHZHa3JMZDlSNVp5eVNIYVAzSDNoU0l6SG1lWlE5?=
 =?utf-8?B?Nmh3YXBseklERG8waU9RU1JTTXVRRG5za1RpdlJyenR0Y3pmVVlveFFkRTFB?=
 =?utf-8?B?Ui9SK1pKZVBvQStLbDVzQzkxZFBIZTMrbitQSXI0WEJGNUhDV2RObVV0NXds?=
 =?utf-8?B?ZWpqYXlzcEhGa3A3MXV6cVRTVk83UEtaQ0plb0ZsQ3pLYVhKWTMrZFVrNXlD?=
 =?utf-8?B?N3FEWXpjck83Tlp5MitqVVNpVm5sdW52UHNGZFhCNkhIeWlwYnlNRzNIT092?=
 =?utf-8?B?N0RwNXQybDcxY3JmelQ3YVBvc20wZGt0MGJ0WFBGd3g2NlM0Uk50YmhmdTQ0?=
 =?utf-8?B?cHVHcHFaVVg4aHpERUhwWE5CWDJETENydk54YXJJbmVlVkRHTXBJaXVzbitG?=
 =?utf-8?B?L25jVUdkN0V5WG50dSt5WWNqWCs2aDZnRVRFUndjZFcvYnoxdVhxRjNmVFg3?=
 =?utf-8?B?UmpGMjQ2UU9kMDQvRjlVUmp0blhmdlZxUkNBdHR0SjVMSlJON2RuVGFER0dY?=
 =?utf-8?B?Zk1pYVAxdFhGU1Nham9jVVNMTEg0NEpUcVc3UlpGV0Zrc011NGpPbXZiUkwv?=
 =?utf-8?B?ZzZNWG1VcGNydnF5WW9QcWRLMzlOaGF2NGs3TzAxREgzdGpEaHF0dzFoaTRU?=
 =?utf-8?B?TEc1a1d5d00yWXI2TG55d00zQWhGemFTb0sxdFU2RG9kcHEwQytHSkxKcW9J?=
 =?utf-8?B?OCtvRmlpQmlPejNoZjBFN2ExVDJQS0lvMHBvQlNtWm8veFVtUU81U2ZMSTRt?=
 =?utf-8?B?Rm9lYzNJOFFYTUNoZkd5YlVyRzc4UjZKK0VseG9WUlN3ajdKa3NiT1FIMzcz?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3E2CD6AEC41584A91AFBFA405B90C9B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c63d85-446c-4687-ee4d-08dabb0c2ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 06:50:18.9304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4g0IAUiKsFnuG21pUYlKc/q8fgzlAsv+La4SC2m2lFTaHLfjI34Vl59A9Wj5LWcefcBluHJNuWszUewo9pKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6330
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

T24gRnJpLCAyMDIyLTEwLTI4IGF0IDIwOjA2IC0wNDAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAyMS8xMC8yMDIyIDA0OjI3LCBUcmV2b3IgV3Ugd3JvdGU6DQo+ID4gQWRkIG10
ODE4OCBhdWRpbyBhZmUgZG9jdW1lbnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJldm9y
IFd1IDx0cmV2b3Iud3VAbWVkaWF0ZWsuY29tPg0KPiANCj4gUGxlYXNlIHVzZSBzY3JpcHRzL2dl
dF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0IG9mIG5lY2Vzc2FyeQ0KPiBwZW9wbGUNCj4g
YW5kIGxpc3RzIHRvIENDLiAgSXQgbWlnaHQgaGFwcGVuLCB0aGF0IGNvbW1hbmQgd2hlbiBydW4g
b24gYW4gb2xkZXINCj4ga2VybmVsLCBnaXZlcyB5b3Ugb3V0ZGF0ZWQgZW50cmllcy4gIFRoZXJl
Zm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UNCj4gYmFzZQ0KPiB5b3VyIHBhdGNoZXMgb24gcmVjZW50
IExpbnV4IGtlcm5lbC4NCj4gDQoNCkhpIEtyenlzenRvZiwNCg0KVGhhbmtzIGZvciB5b3VyIHJl
dmlldyBmaXJzdC4NCkkgZGlkIHNjcmlwdHMvZ2V0X21haW50YWluZXJzLnBsIGJhc2VkIG9uIGxh
dGVzdCBicm9vbmllIGZvci1uZXh0IHRyZWUsDQpidXQgSSBtaXN1bmRlcnN0b29kIHRoZSBydWxl
IGFib3V0IENDIGxpc3QuIFRoYXQncyB3aHkgSSBvbmx5IHBpY2tlZA0Kb25lIG1haW50YWluZXIg
Zm9yIGV2ZXJ5IGRvbWFpbi4gSSB3aWxsIHVwZGF0ZSB0aGUgQ0MgbGlzdCBpbiBWMy4NCg0KPiA+
IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3Mvc291bmQvbXQ4MTg4LWFmZS1wY20ueWFtbCAgICAgICAg
fCAxODcNCj4gPiArKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE4NyBp
bnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ4MTg4LQ0KPiA+IGFmZS1wY20ueWFtbA0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ4
MTg4LWFmZS0NCj4gPiBwY20ueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zb3VuZC9tdDgxODgtYWZlLQ0KPiA+IHBjbS55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmIyYzU0OGMzMWU0ZA0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ4
MTg4LWFmZS1wY20ueWFtbA0KPiANCj4gTmFtZSBtYXRjaGluZyBjb21wYXRpYmxlLg0KPiANCk9L
LCBJIHdpbGwgdXBkYXRlIHRoZSBmaWxlIG5hbWUgaW4gVjMuDQoNClRoYW5rcywNClRyZXZvcg0K
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K
