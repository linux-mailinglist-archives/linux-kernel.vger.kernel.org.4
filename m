Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69901711F37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 07:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjEZFcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 01:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEZFcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 01:32:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA8FE2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:32:18 -0700 (PDT)
X-UUID: ab365d90fb8611edb20a276fd37b9834-20230526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mbS8n/pb2aZzZc9Evi7fur/+OtCv9c2UkHlvhH0gP+o=;
        b=DLf4AEtvMeT6qZoYAaPuA0i2Fi0hIWtU+XpJmYecY2x6RQcMPvGdz8+FK3pS2JET/LVqv+qDSZOdAsomkiRHDEoAQP4O9lz5o71/teCwXwNu+RuzydN0zS/qLtfBr2YPuQP6Q4qxeSQWwf5BTelL7ZhW5GvJAp1fe8HMZG1FiJY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:633aca2a-0023-4261-8bee-3ce61f01e539,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:a0076d3c-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: ab365d90fb8611edb20a276fd37b9834-20230526
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1709963449; Fri, 26 May 2023 13:32:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 May 2023 13:32:12 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 May 2023 13:32:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ON1u5Vt2v+5r5pLg3BZsuOUaE3XxPiYuDuUm5PjBP0YVHrhyleYI4j/X45MwKYQXgJcWvoIV/tfpL5ExvU8gWFMC30loh82bVvycNoSA6ZyMrrLy8dBXLpEAN5TMczvJtsyDJIm342R2Uy1IQBNhfIFiPOExzU/OQO1F1frqBU1Re3r50NkufHOYeDaRxyYyItm8sihJmy/hZFnDYMEclDs2TC3XKtx6hwNgstxksZEPQN5gV0BUhykRAQ2z62/BgON5THvv3P0CNpImnpZoBnj7uX6MLXFgdfd7mqvC6pf5J1/uBoiA4V3WcHcNR+FiHd4bytGpnTQlc2+Bpjyp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbS8n/pb2aZzZc9Evi7fur/+OtCv9c2UkHlvhH0gP+o=;
 b=n3g06aMtBmshTW9e5UsQeZVGmN71UxvqQNlgtVShc4WtFZYiWmdG5vtFa+XCW/d9nhHVOOpslxhPUR4marBnmvjCZVEHEzN56OsZgU6NP0rMmr9ERRdFLaZybUb/S8tAuPCmLRX62B4PfeT3Gmrs7CjVZcXLc0tbZ6lT6lNyy5/QFDIvsZNLY4umj3A5AHFbqv2x2u78DZpT4EBXdbuVgwubEuAyxrYM7X+xmPuVOj2wVFKi3c5JJ718ZOv+ilhlQKS1KEhCmV/xhpaV5XlHPkNFcJ8WW8w5ACTTe3RIDNculGjATNgCgKnSfS61xXDo8VHzVIe/c5LXkK8GVu1RQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbS8n/pb2aZzZc9Evi7fur/+OtCv9c2UkHlvhH0gP+o=;
 b=hOz7cyYW2k7Hz0CzIY/5R3KA3si4Ok5IMlNCS0AcyPfCEfXl1RJXECA8dkB3jeSAkR/bssOZITSDQYBGdhsVJzhUu+KRjiZC1j7Qsz6K/304pyE8iguar/kWQNt+yE6doGZlyyJfrpjIwg7BMqYtblfRB8eJA53zsLU1m+ZN4P0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB6265.apcprd03.prod.outlook.com (2603:1096:301:9e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 05:32:09 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6c78:65bd:917f:8c58]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6c78:65bd:917f:8c58%7]) with mapi id 15.20.6411.030; Fri, 26 May 2023
 05:32:09 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 06/11] drm/mediatek: gamma: Use bitfield macros
Thread-Topic: [PATCH v4 06/11] drm/mediatek: gamma: Use bitfield macros
Thread-Index: AQHZiXZ1E64ZFRVoXkOSI/v6Q0KMca9sE+eA
Date:   Fri, 26 May 2023 05:32:09 +0000
Message-ID: <069cbd4c325949e4662cec2d8547b6fcd111faf6.camel@mediatek.com>
References: <20230518104857.124265-1-angelogioacchino.delregno@collabora.com>
         <20230518104857.124265-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230518104857.124265-7-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB6265:EE_
x-ms-office365-filtering-correlation-id: 91c605bf-0fdf-4efa-2d4f-08db5daa8cfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zYU2ITzK/Btbo30x0XHciW/nlQHIwhXxUzRSvfnMAZv6XHgoJ93im4mHhGUks9sei7EH3iaeRcgdPP2FyUmhfZqfJBz0tZoRuxEkjr80e+LD8XtyqUhElPjpI56It8T05oOfESY1lXWQeZHjTUeAkPyJhrL0nnbQmckI8T+H+MZouq7X/6B28WKcGVi0qtK1FlIz07Em8nh0Srv1mBS/Fcflt3BYJbnnQTD3LAj14HKHj24tV0YOexfXArm68UIsW12A9taAz9324T5Mtp1ilXT3Te1J7TwtjMf2FTVNLsqMe8nzSlI5VjAh2ou4uiWlTENLZdjxur5k42cbQR8YBoRtQGQRn+pTiUMWgb5NuNtvMWqItf2820AX3dk1b1oFAauA+65Qma3kIF4F0Zsx9fYv7p26F5BP49qScWSurE2nBJg3DuHcidS3UU5WahoZxd/Az6FFfJGlbU01Id+zu5W8qvSsCT/z2drLUDUyYJ4O37bEnfCB1H9OETOq5ANE8W5hAyMgv23eNV5ImyXiL5P9ZW59obFpk4FYMFt2I+GksVR5xDIDWfDLQkmQmbD0mI4d88NkTLWWxsTP79BXw/GnTfedIcBRNSOwISwADWOhHCkigFe83SzhkbNa31fR7kVFoVYZJfVzfDa00r5N9ymog9TtguxfUrxfUAmejQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(76116006)(66556008)(66476007)(66446008)(66946007)(4326008)(64756008)(5660300002)(8936002)(8676002)(316002)(41300700001)(54906003)(110136005)(2906002)(478600001)(6486002)(71200400001)(6512007)(85182001)(26005)(186003)(36756003)(83380400001)(122000001)(6506007)(38100700002)(2616005)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c085dGUwakxIT3JSa2FGUy9oWXdpYVJaeldlaEpyMVZVWXQveHNhYXZRNFh3?=
 =?utf-8?B?cjVQQXJmM3hHNHlsVEQ3dkt2SlQzekJBWitvYTQ0QmZORkJVdWpJV01XbFFF?=
 =?utf-8?B?cCtWME52Y2owK085RFgweitXNnMzbFg4eE5TT2szTXdFQzkraFpLMGxTQWdY?=
 =?utf-8?B?dmJ3eUtpc25EZ3hkM2dXYTVUTVgvUlpCaEdUb0ZVNGpXUVQ1WllXYkFzN25x?=
 =?utf-8?B?ODlUS3ZlK1FQaWxtTWZublN5K21KTW1hby84OUtJN0lBazJsdCtNOTlNU1pM?=
 =?utf-8?B?blRXRzN5c2MxU3NpeGZFbVR5NGM3RnJYYWFsbzRRNnNTeUF2UjAyMVVQdzdu?=
 =?utf-8?B?NkcwN1ltNUpuMU1kOHhvVjNObkJyUFNadlp3T2Roem5MZlZmRStmZjdZbGVI?=
 =?utf-8?B?cktxTjY1Kzltb0NVZkNIRFhqS3dZbDU3SE9qMThORjQzSDN0QWZ1NUVQRnJr?=
 =?utf-8?B?TG5qeU9jczBuOHRERVExeHNOSVpETURpZkNnbm43N3ovMXNtQXo1dExFdUpU?=
 =?utf-8?B?YlVPc0l3Sk9SR0UzcTRtQkc5c25PSExyNzFVMHI0T1pMeHFHekVMOGNBSFlq?=
 =?utf-8?B?ZytUM3kyN2orRjN4YWRlZVhpM051c2MvSXBpbEMrNDhtdjFWek9VZ3V6TXJy?=
 =?utf-8?B?ZXlCb214V05DcVc1ZlZBaDBhSVJJNktBODlvOTZ2ajlmeDFQaG04Sy9pbm9M?=
 =?utf-8?B?dkNEVVF3YmdKeVByVGtjWTM2c1lWVk1WWkNHY3Ewc21JcDYrQyszZHNMZEdI?=
 =?utf-8?B?bStwdGxEcUZrQzVrQUhDRVRyamtHT3NMZnY1dWF0cklkSFhPcFBJUWRaaXc0?=
 =?utf-8?B?SnV3SG1KSjh6UkR5WWJiTUVIbEUrMUx5QWFJY1p5dytOWmd6aWZFK3JyL0tB?=
 =?utf-8?B?bG5lKzRkRDg1bVVEbzFRTE93SkdjcjZCWG05NUZUcitqQmpUQ0pVdmk5aU56?=
 =?utf-8?B?cXliTWlnUmdUWTBLeGMvbVRZRTZEOG56aVBrRnlaWVVlQkNYb3R5SVhtK05X?=
 =?utf-8?B?WXN2ZzdwWFRLTXV1SnZQMVBJWm5nWlhtWTkwRlBzcGliMkVXUTZiMW1XaFRj?=
 =?utf-8?B?enFSR1dFdkMraGw5MUo1VVVaWlhTWUlzUlZ6WW5LR2k1aUZqNEFpWStmU3dQ?=
 =?utf-8?B?SW1BRm92L0w0czg3cnlPQVZ0WlVvRnZGMGs1NG8yemxCbkJabTdGZ0MrMjdJ?=
 =?utf-8?B?ZUhLQWlNY1EvWlNJV0gvZmdseGtjUE96SHQzaFlUVklSakk3SzBibE9wdjRn?=
 =?utf-8?B?TnVaNjZpZFhMLzB6Y2dpa1dKUWpmZE1oai80b3llRW8rc2lmdjJXc3hzaWth?=
 =?utf-8?B?S0NrZUdCZnV5aWIvTzZZVEtBNkhxWnBTY0lWeEpES1Y2YkFCU0JHeUU4dzV2?=
 =?utf-8?B?aUoxREo5S0pmNUsvNTloaW9PSmJHNnZxaDMySkhBZmg1bjlZV3Nzd0Q1YUQ3?=
 =?utf-8?B?Wmd6OE53bGx2VU5yNGpWbS9aNUwzc05qUXVIdnMxbSs4NXZFS25oWHYyVWZZ?=
 =?utf-8?B?RVRBVlJEZ0pVdW00SmszWjJEVUkrSllaY0E4TUE2aWh5eFJIZUpncjRUUnJV?=
 =?utf-8?B?NENJTEFWdCs2eVh1R3FjTWE3ckFRMGJNVjhYMGhXRmJEQ1VrRW1tNC9vbERm?=
 =?utf-8?B?d2oxZlgvRnpVREhJOU1kVWdqWWhwNk9kbEZLMERLUmxpR0FMbWVXdUtjWjll?=
 =?utf-8?B?c2Y2NjBidTFOcjlFS202NDhqcHZONW9nMm82anhKREZBQ0V0bHdQZ2dzN2kz?=
 =?utf-8?B?YjJhaGNVRVNPYWFmcWJ3Z09LbDFndDBXcnZqZ1VLMngxWkMrWDhZaEFwcTZ6?=
 =?utf-8?B?T0pyTGFYSU82c2V1SHFVMHNldXFNaEkvaXBIU0hObVhHbFkwRFlPRHJ1SWJ2?=
 =?utf-8?B?T3d1UGlDYlliQTFuWWZoYlRncHV4Y2VKTEhwM2U1ckV6ZGNkTDhyUG5HSTg5?=
 =?utf-8?B?VEY2cFl6anZMNzJBVVhqQmhWV0xQeXU5RGJuZUZ6UHdKajhiZ0RNQ3QyeGNi?=
 =?utf-8?B?bWZ2OFpOc2ROVEZtK3RXMGtzRTJKRFIrMGNadktraHI2MGRLYUFJQzBUZmx1?=
 =?utf-8?B?VnMwRm1CVHg5V2s3OC9TSXdhcFpNTW1Mb3ZHTnk4TUtFeGF5ZEVRR25CV2ZB?=
 =?utf-8?Q?rRc8ma9SCxhLmv2dexkJ3RgHh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54D8ED5E2992A144AC37AB8BEA856FDD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c605bf-0fdf-4efa-2d4f-08db5daa8cfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 05:32:09.4164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4YlYfzHGyz6r3U0lkRrk3Bjornq4oIRl3RBe3lyz82BddGd/pbiToqu5X4Aw5bv3MJyjUVSbeODJGaosqCqkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6265
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDIzLTA1LTE4IGF0IDEyOjQ4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVy
aWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBNYWtlIHRoZSBjb2Rl
IG1vcmUgcm9idXN0IGFuZCBpbXByb3ZlIHJlYWRhYmlsaXR5IGJ5IHVzaW5nIGJpdGZpZWxkDQo+
IG1hY3JvcyBpbnN0ZWFkIG9mIG9wZW4gY29kaW5nIGJpdCBvcGVyYXRpb25zLg0KPiBXaGlsZSBh
dCBpdCwgYWxzbyBhZGQgYSBkZWZpbml0aW9uIGZvciBMVVRfQklUU19ERUZBVUxULg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9h
Y2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IFJldmlld2VkLWJ5OiBKYXNvbi1KSC5M
aW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMgfCA0MSArKysrKysrKysrKysrKy0tLS0tLS0NCj4g
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2Ft
bWEuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IGlu
ZGV4IDE1OTI2MTRiNmRlNy4uZWQyYWExZmIwMTcxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYw0KPiBAQCAtMyw2ICszLDcgQEANCj4gICAqIENvcHly
aWdodCAoYykgMjAyMSBNZWRpYVRlayBJbmMuDQo+ICAgKi8NCj4gDQo+ICsjaW5jbHVkZSA8bGlu
dXgvYml0ZmllbGQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gICNpbmNsdWRlIDxs
aW51eC9jb21wb25lbnQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gQEAgLTIy
LDkgKzIzLDE2IEBADQo+ICAjZGVmaW5lIEdBTU1BX0xVVF9FTiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQklUKDEpDQo+ICAjZGVmaW5lDQo+IEdBTU1BX0RJVEhFUklORyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVQoMikNCj4gICNkZWZpbmUgRElT
UF9HQU1NQV9TSVpFICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAwMzANCj4gKyNk
ZWZpbmUgRElTUF9HQU1NQV9TSVpFX0hTSVpFICAgICAgICAgICAgICAgICAgICAgICAgICBHRU5N
QVNLKDI4LA0KPiAxNikNCj4gKyNkZWZpbmUgRElTUF9HQU1NQV9TSVpFX1ZTSVpFICAgICAgICAg
ICAgICAgICAgICAgICAgICBHRU5NQVNLKDEyLA0KPiAwKQ0KPiAgI2RlZmluZSBESVNQX0dBTU1B
X0xVVCAgICAgICAgICAgICAgICAgICAgICAgICAweDA3MDANCj4gDQo+ICsjZGVmaW5lIERJU1Bf
R0FNTUFfTFVUXzEwQklUX1IgICAgICAgICAgICAgICAgIEdFTk1BU0soMjksIDIwKQ0KPiArI2Rl
ZmluZSBESVNQX0dBTU1BX0xVVF8xMEJJVF9HICAgICAgICAgICAgICAgICBHRU5NQVNLKDE5LCAx
MCkNCj4gKyNkZWZpbmUgRElTUF9HQU1NQV9MVVRfMTBCSVRfQiAgICAgICAgICAgICAgICAgR0VO
TUFTSyg5LCAwKQ0KPiArDQo+ICAjZGVmaW5lIExVVF8xMEJJVF9NQVNLICAgICAgICAgICAgICAg
ICAgICAgICAgIDB4MDNmZg0KPiArI2RlZmluZSBMVVRfQklUU19ERUZBVUxUICAgICAgICAgICAg
ICAgICAgICAgICAxMA0KDQpUaGlzIGlzIHVzZWQgb25seSBmb3IgQUFMIGFmdGVyIHBhdGNoICJk
cm0vbWVkaWF0ZWs6IGdhbW1hOiBTdXBwb3J0DQpzcGVjaWZ5aW5nIG51bWJlciBvZiBiaXRzIHBl
ciBMVVQgY29tcG9uZW50Iiwgc28gSSB3b3VsZCBsaWtlIG1vdmUgQUFMDQpkZWZpbml0aW9uIHRv
IEFBTCBkcml2ZXIgYW5kIHBhc3MgaXQgdG8gZ2FtbWEgZHJpdmVyLg0KDQpSZWdhcmRzLA0KQ0sN
Cg0KPiAgI2RlZmluZSBMVVRfU0laRV9ERUZBVUxUICAgICAgICAgICAgICAgICAgICAgICA1MTIg
LyogZm9yIHNldHRpbmcNCj4gZ2FtbWEgbHV0IGZyb20gQUFMICovDQo+IA0KPiAgc3RydWN0IG10
a19kaXNwX2dhbW1hX2RhdGEgew0KPiBAQCAtOTYsMzMgKzEwNCwzMyBAQCB2b2lkIG10a19nYW1t
YV9zZXRfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gdm9pZCBfX2lvbWVtICpyZWdzLCBz
dHJ1Y3QgZHJtX2NydA0KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBsdXRfc2l6ZTsgaSsrKSB7
DQo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZHJtX2NvbG9yX2x1dCBkaWZmLCBod2x1dDsNCj4g
DQo+IC0gICAgICAgICAgICAgICBod2x1dC5yZWQgPSBkcm1fY29sb3JfbHV0X2V4dHJhY3QobHV0
W2ldLnJlZCwgMTApOw0KPiAtICAgICAgICAgICAgICAgaHdsdXQuZ3JlZW4gPSBkcm1fY29sb3Jf
bHV0X2V4dHJhY3QobHV0W2ldLmdyZWVuLA0KPiAxMCk7DQo+IC0gICAgICAgICAgICAgICBod2x1
dC5ibHVlID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGx1dFtpXS5ibHVlLCAxMCk7DQo+ICsgICAg
ICAgICAgICAgICBod2x1dC5yZWQgPSBkcm1fY29sb3JfbHV0X2V4dHJhY3QobHV0W2ldLnJlZCwN
Cj4gTFVUX0JJVFNfREVGQVVMVCk7DQo+ICsgICAgICAgICAgICAgICBod2x1dC5ncmVlbiA9IGRy
bV9jb2xvcl9sdXRfZXh0cmFjdChsdXRbaV0uZ3JlZW4sDQo+IExVVF9CSVRTX0RFRkFVTFQpOw0K
PiArICAgICAgICAgICAgICAgaHdsdXQuYmx1ZSA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChsdXRb
aV0uYmx1ZSwNCj4gTFVUX0JJVFNfREVGQVVMVCk7DQo+IA0KPiAgICAgICAgICAgICAgICAgaWYg
KCFsdXRfZGlmZiB8fCAoaSAlIDIgPT0gMCkpIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
d29yZCA9IGh3bHV0LnJlZCA8PCAyMCArDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBod2x1dC5ncmVlbiA8PCAxMCArDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBo
d2x1dC5yZWQ7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHdvcmQgPSBGSUVMRF9QUkVQKERJ
U1BfR0FNTUFfTFVUXzEwQklUX1IsDQo+IGh3bHV0LnJlZCk7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHdvcmQgfD0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9HLA0KPiBod2x1
dC5ncmVlbik7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHdvcmQgfD0gRklFTERfUFJFUChE
SVNQX0dBTU1BX0xVVF8xMEJJVF9CLA0KPiBod2x1dC5ibHVlKTsNCj4gICAgICAgICAgICAgICAg
IH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRpZmYucmVkID0gbHV0W2ldLnJl
ZCAtIGx1dFtpIC0gMV0ucmVkOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBkaWZmLnJlZCA9
IGRybV9jb2xvcl9sdXRfZXh0cmFjdChkaWZmLnJlZCwNCj4gMTApOw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICBkaWZmLnJlZCA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChkaWZmLnJlZCwNCj4g
TFVUX0JJVFNfREVGQVVMVCk7DQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBkaWZmLmdy
ZWVuID0gbHV0W2ldLmdyZWVuIC0gbHV0W2kgLSAxXS5ncmVlbjsNCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgZGlmZi5ncmVlbiA9DQo+IGRybV9jb2xvcl9sdXRfZXh0cmFjdChkaWZmLmdyZWVu
LCAxMCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRpZmYuZ3JlZW4gPQ0KPiBkcm1fY29s
b3JfbHV0X2V4dHJhY3QoZGlmZi5ncmVlbiwgTFVUX0JJVFNfREVGQVVMVCk7DQo+IA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBkaWZmLmJsdWUgPSBsdXRbaV0uYmx1ZSAtIGx1dFtpIC0gMV0u
Ymx1ZTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZGlmZi5ibHVlID0gZHJtX2NvbG9yX2x1
dF9leHRyYWN0KGRpZmYuYmx1ZSwNCj4gMTApOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBk
aWZmLmJsdWUgPSBkcm1fY29sb3JfbHV0X2V4dHJhY3QoZGlmZi5ibHVlLA0KPiBMVVRfQklUU19E
RUZBVUxUKTsNCj4gDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHdvcmQgPSBkaWZmLmJsdWUg
PDwgMjAgKw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGlmZi5ncmVlbiA8PCAx
MCArDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkaWZmLnJlZDsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgd29yZCA9IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9MVVRfMTBCSVRf
UiwNCj4gZGlmZi5yZWQpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICB3b3JkIHw9IEZJRUxE
X1BSRVAoRElTUF9HQU1NQV9MVVRfMTBCSVRfRywNCj4gZGlmZi5ncmVlbik7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHdvcmQgfD0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9C
LA0KPiBkaWZmLmJsdWUpOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAg
d3JpdGVsKHdvcmQsIChsdXRfYmFzZSArIGkgKiA0KSk7DQo+ICAgICAgICAgfQ0KPiANCj4gICAg
ICAgICAvKiBFbmFibGUgdGhlIGdhbW1hIHRhYmxlICovDQo+IC0gICAgICAgY2ZnX3ZhbCA9IGNm
Z192YWwgfCBHQU1NQV9MVVRfRU47DQo+ICsgICAgICAgY2ZnX3ZhbCB8PSBGSUVMRF9QUkVQKEdB
TU1BX0xVVF9FTiwgMSk7DQo+IA0KPiAgICAgICAgIHdyaXRlbChjZmdfdmFsLCByZWdzICsgRElT
UF9HQU1NQV9DRkcpOw0KPiAgfQ0KPiBAQCAtMTM5LDkgKzE0NywxMiBAQCB2b2lkIG10a19nYW1t
YV9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgdywNCj4gICAgICAg
ICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9w
a3QpDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IG10a19kaXNwX2dhbW1hICpnYW1tYSA9IGRldl9n
ZXRfZHJ2ZGF0YShkZXYpOw0KPiArICAgICAgIHUzMiBzejsNCj4gKw0KPiArICAgICAgIHN6ID0g
RklFTERfUFJFUChESVNQX0dBTU1BX1NJWkVfSFNJWkUsIHcpOw0KPiArICAgICAgIHN6IHw9IEZJ
RUxEX1BSRVAoRElTUF9HQU1NQV9TSVpFX1ZTSVpFLCBoKTsNCj4gDQo+IC0gICAgICAgbXRrX2Rk
cF93cml0ZShjbWRxX3BrdCwgaCA8PCAxNiB8IHcsICZnYW1tYS0+Y21kcV9yZWcsIGdhbW1hLQ0K
PiA+cmVncywNCj4gLSAgICAgICAgICAgICAgICAgICAgIERJU1BfR0FNTUFfU0laRSk7DQo+ICsg
ICAgICAgbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgc3osICZnYW1tYS0+Y21kcV9yZWcsIGdhbW1h
LT5yZWdzLA0KPiBESVNQX0dBTU1BX1NJWkUpOw0KPiAgICAgICAgIGlmIChnYW1tYS0+ZGF0YSAm
JiBnYW1tYS0+ZGF0YS0+aGFzX2RpdGhlcikNCj4gICAgICAgICAgICAgICAgIG10a19kaXRoZXJf
c2V0X2NvbW1vbihnYW1tYS0+cmVncywgJmdhbW1hLT5jbWRxX3JlZywNCj4gYnBjLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERJU1BfR0FNTUFfQ0ZHLA0KPiBHQU1N
QV9ESVRIRVJJTkcsIGNtZHFfcGt0KTsNCj4gLS0NCj4gMi40MC4xDQo+IA0K
