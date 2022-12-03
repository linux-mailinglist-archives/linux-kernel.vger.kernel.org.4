Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3514D641762
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 15:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLCOxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 09:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLCOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 09:53:41 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B876F1E3CD
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 06:53:36 -0800 (PST)
X-UUID: 6ae399876a8f4a6b81a9a91ebc005a22-20221203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=79hzqR8BLDgmWu/344NxF9+RrdPHizNNeN4ujM2NbFk=;
        b=ghFX21ZgP90Vvkjr89SEW3OMo+n0v0AuotAeJCzqAy8h6PYaxRxWxOWg8iWn/eKHo6B5i0l7tg7+rgIolmA2c4U0oqB7kCCa9XsvMqCxZpMuPSYmEC/B3tIDaCZweij46SRjRANMfzziD6CMNbyHZ518xUYeHHtdUDqHUWUrW+s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:30b3ccba-f613-41fb-af22-295983eafe47,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.14,REQID:30b3ccba-f613-41fb-af22-295983eafe47,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:dcaaed0,CLOUDID:7808746c-41fe-47b6-8eb4-ec192dedaf7d,B
        ulkID:221203225328EOWH78IA,BulkQuantity:0,Recheck:0,SF:28|17|19|48|102,TC:
        nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6ae399876a8f4a6b81a9a91ebc005a22-20221203
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 294739534; Sat, 03 Dec 2022 22:53:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 3 Dec 2022 22:53:24 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sat, 3 Dec 2022 22:53:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h62hmchYOFwbDmnoeSPZSjfGN5FCwVk2/OMq/xNcssNKijc3QEiJMT2S4mIEdBZxOxAnIu8Cgdon1i3n4PZAxuSQYWG9rAuLSITqHFfZPbSMA7kE2jNpzBCodTUGJ1PETm4fxqepMWLpeziduLfTeKXiStNj4rJ1uj+BXTdwvfL75B/aoh7NuLi9jpIxJpgIxsQ+eGzkVj5pQPlsq8SK9FKWNjvshC4V49nc3Gc/e+PMgQ1rJATcY9A++1qb7+35umFDT5D7ntgESQDq0jFcd7IeHztgOpXfLs9/aIP+rbq7WQ6gPv8b4fNkHFzrdan5qSz13/0aPlzenMYQhtscuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79hzqR8BLDgmWu/344NxF9+RrdPHizNNeN4ujM2NbFk=;
 b=Krj48mSkUTfFuhUpU2PxfPax8MkMOp7kF2WsGlZkmy8sQdTxPH4l/+TaR0GIRw+e7+Kd5yAzeatuiEQWDXzwkmzbVctpvOl9B3nD6itJZYjT2HKhcDRwE9ti5JksI6XBfNukD8BMsFeopy3eKE7Gf215TLhJwcXYKybfvBHAFN4xV/EqW6jnhZWB+DmDf3QGGIXZxzOjCkNnurVPUjbJ8uGjZV5oxlYoICR9jP5oSCM9a1kmGKzVN0tB3eK2C0oXaNorX9o/aedtxWAqfd5HlK8nlBPmZy9oPM1lQ6EMGiWe2qba/+QlbEBgosGH6Z3taZLPoqI8tmJfKJMjk2x+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79hzqR8BLDgmWu/344NxF9+RrdPHizNNeN4ujM2NbFk=;
 b=liom+GvfdFw3+OFGNRan58+++oTSpyTmMVPs8ABGROkN13xtQAUs4EFOB9v5XkayTw+ftdfMFEmz49REV8TX5zTRDjqYGZ69WDVJNWOkTYLB3zv1Kiqc4ophPgI3YMv1pAOdfjsIMZJyLkhDWcavKksiYdd0y6BzsOoQLk79LFc=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR03MB5636.apcprd03.prod.outlook.com (2603:1096:820:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sat, 3 Dec
 2022 14:53:20 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696%5]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 14:53:19 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        =?utf-8?B?VGlhbnBpbmcgRmFuZyAo5pa55aSp5bmzKQ==?= 
        <Tianping.Fang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "trix@redhat.com" <trix@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v4 3/3] phy: mediatek: tphy: add debugfs files
Thread-Topic: [PATCH v4 3/3] phy: mediatek: tphy: add debugfs files
Thread-Index: AQHY9QhG35CIOR1jTk2qYSnofBdXwa5Ob3gAgAWbzQCAAG5YAIAH6kGA
Date:   Sat, 3 Dec 2022 14:53:19 +0000
Message-ID: <5c0cc00a37c4cfa03d91e834fb649d52d4ddb041.camel@mediatek.com>
References: <20221110132716.12294-1-chunfeng.yun@mediatek.com>
         <20221110132716.12294-3-chunfeng.yun@mediatek.com>
         <Y3+uGjpMQcEWQrew@matsya>
         <70407a789b48a4fbd498e392450eb9db76e025bf.camel@mediatek.com>
         <Y4S/GhUcrxJ9W/gE@lunn.ch>
In-Reply-To: <Y4S/GhUcrxJ9W/gE@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|KL1PR03MB5636:EE_
x-ms-office365-filtering-correlation-id: b78872e1-5fdf-4e17-4195-08dad53e1e00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aVaYACBRMvXKhVnCB93cvALeBNZ/0uBOC5EUhzHOIqcHyt9oDSK6X3ihPpVRiTCmn21SHbYxHhGQDtsSlKgBV+s7j/aZ/9C/IVcQHaqgRUGuLVYZWnx1cgn6TL2HsQwglaB3WwcU0f4vOqFiZir8uMK1D0ETjFttaNk+Djn0tFY+rc9oZTtt+kDxJ54Lpe8pG1k8UdBDxn6b5N5EmYW63dZ1tHZuoC1/rH63kBwz6tEhjCn9Qw0r5zarJpgJxu/HVgF6thJa2B/0XV7TiXbAQOQagzYHtu756IpwpnhnMY53Udzt4NrDkrxToReYu0VsGxYV7YEMRsI3ieRX6i/SoULPh31M8goYYKT++vL4Y46A7qCHoQeU7uJcum2InUv4fRjRdHYVeXpEoLBrhPVIqBi+4VF41IZJpoKjldhAx+1RGGm1DemZ6DIgyYO6udK/c9xYz8Knhr/SBMpfXicUzjBPWGUK161GCQValDcqwoi7gjv6UF7z8ujATdn8+S79eDLyc2Zkuzh8vMznuXR5DWpUE39Bs+ee2y5o/lFSutN7z3Of1426rBCmNJat1+dcGi+jA9iWkaOy/J0EddHcnK/DWfAfrHwTmr+g8v9f6aCb3m1f5ixL0RVefslMXdJ4hPq1waONmNIhjpVtck3bKCHJBoyEGiJF08Q8938SuTRakcvCLyLFWdeJLiqwtewG2O81RyJf7vG7n7bVcYD1SUu2gsHZO2d9tDWTTQczYvOSx435YlFzlwNbzt/QbcfZDsr8tlu+8bMmVJ+aytEDfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(186003)(71200400001)(4326008)(66446008)(66476007)(54906003)(64756008)(66556008)(66946007)(76116006)(85182001)(316002)(36756003)(91956017)(6916009)(53546011)(38100700002)(6506007)(38070700005)(122000001)(478600001)(6486002)(26005)(86362001)(6512007)(2616005)(8676002)(4744005)(5660300002)(2906002)(4001150100001)(7416002)(8936002)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXBzWDJaU2VvMFFIcmJRbklrNjBSbkZKOW5qckxpelVCL1FoUkRpUG0zWlNK?=
 =?utf-8?B?NkdxUzZ0N3EwejA2ZkN3bXR4S1U4Tzk3bmRBVE5kaWJvQXhhZExBUzFKbE9u?=
 =?utf-8?B?NENTYWM3b3pOSk1qUDdobmVsK1lSbG9MWDFmZlpocHVEblpPcSt4NmJsN0JJ?=
 =?utf-8?B?NCsyOWJKWU1LYjgyb21JcWVneHFUZzY5Umt1bVVVdUhmUm9yczFWcGlac0pt?=
 =?utf-8?B?M2czSFAwUXZnMjUrTmlrRnUyUnRsR1lZaTN1d1V3NmxZS1hwSEZhVDN0bHhN?=
 =?utf-8?B?RDVYZGtDWGxRWE5aZUlvVnFKSHc1Z09qdE5oSnUvSmwrTUpvcnE2bi8yOEZ1?=
 =?utf-8?B?WmtnWjNBQUtsb0pUSVlUWWk5M1d2eHNIUVZZUStoTDV3eGQ3emVOZGN5V2Ft?=
 =?utf-8?B?M0gyNHFYM3RTSklzZ2dScERVL09lbFYwaytQU1J6TnNLQzNFbmd6RWlaNUZK?=
 =?utf-8?B?VkltSHo3dnJLNmI2QVBhRk53bi9MbmtSTTRta0NyaE55Z254SHdQUENCeVBl?=
 =?utf-8?B?YThWUXBjeThkdDdkdG9tdWVTdGJpcTZIdGQwUGNaekVuMFd5SkFIdzcxQnhF?=
 =?utf-8?B?RUppTU9MWkJGczlIV1VkTkM3ZitFNWJJaHJGOWR2REdRbmlOQmg3ZzBCZ2VM?=
 =?utf-8?B?dDY5WXR0MVhKS3pxeTBmSVNQOUxTbGFmakFMaWU2bjZGMEZyNnlDRVYyNHF0?=
 =?utf-8?B?RXZ6amt6OG1mOEpZZVdzdmZXNGdGWm1RekxPWTJOclN4dThCWmg1SmVUWWti?=
 =?utf-8?B?ZHROWlkyRU85TVlSeFFkSU9vVVdPYkFBVGpJSVI5aWZMOTlkdXhYWTRZTUpp?=
 =?utf-8?B?S2Q4OXV0RDA4anZHbU5qc0pHQnl4WEFyYU9BQ3ZpcjU1U0MzMGp2T2R3Z093?=
 =?utf-8?B?b2lmU0p4ZDMrMWhOaExTejRUZVdObHFWSUNtSUJyWjJwWU9kbEpiZFMzRlVx?=
 =?utf-8?B?UjVMMFptZGp5KzJYZVZ6TlBpNGN2THFhV2poZTU1ZzIrNmFJd1N4SzNFSjk3?=
 =?utf-8?B?dHRGTnJVUjFHTHJlVzZSTXlrZEg2Z2dIMllFQ3o2R1prMjk0UjNYWHR1VEcv?=
 =?utf-8?B?b3d4Nm00SlJENDZ5dWRqbmdwM0xuVStHdGU2Sm9NNERnNEFURXhSOWdqSkhH?=
 =?utf-8?B?dUc1SytoK0xHYW1PQzJ1anZ5b1pmb1RyNi85bzlBNnovZmcwOUxDTXIwRGsr?=
 =?utf-8?B?WmorY3JRa3BlRlVZODBFNmtkN1h5aDEvczZ3UDZOWlJKM0tpSEhwR0hEdStY?=
 =?utf-8?B?SjFQR0RDc0Rqc3pJWlJyQkpnS3M4V29ISWQ2WXUrcDZ3R1RSMFdTeTc0VFVy?=
 =?utf-8?B?QnZGNHlYcHd1MjNaUklOSVBiSXYrZUoxYStlZktCanJyQVZCcDRrREw3QXFa?=
 =?utf-8?B?UHVoajQ3dDExU0hXT25iZFlvL3JaaC80ZmpKeFJLWVYweGJkNzhTRnFzNEFY?=
 =?utf-8?B?VXhyaE5IUk5OWkkxNG1XS3JTNm44OW5HMDFjNDZlVWpoNlpKUHc0K3NGNUxT?=
 =?utf-8?B?WHlyVVdnQW5nRTJYdCtJaWg3aStZdTJRZzQyNHI3R2xtTkFuR2tsREU1cWw3?=
 =?utf-8?B?UjQ5YmIwZnlMOHRrSVZVSXBrVWxOaTBDNEpSaWM2Qnh2ZXJyVmZhaXVBcU0z?=
 =?utf-8?B?MnpZbEV5bDRBVVJJRXJSQkxHRTMvNko4Rm51Q2FNQXhJbHA3NkJESllCakZy?=
 =?utf-8?B?clJQUnNTOHhocUd1M3VNUWxQM21wTkJWQ0EvdFd6SmNZQUZVYkFQVWFQQnpH?=
 =?utf-8?B?cHJMUm4wWGFLMGpBN3U0U3dxUnRCNmNiSEVYMWdXNjBiZVNMVXo3dGlQckhN?=
 =?utf-8?B?ckFBcW9LZ3h0YW5DSDdsSWp0VmxCMVc4T1ptcjVPREY5MHJWV2RsU0RLWlhT?=
 =?utf-8?B?YlNEOFhKTEcvTHYxa0tPTFlpcjRQYUNhUHZoTndLSFJrblpKVEFMMENQQzE2?=
 =?utf-8?B?VUxFQndtbEViWEpwU1NaQ1YzK1JFM2FWWFlXK3p1UFI3R1NWUjdCME9RTW9X?=
 =?utf-8?B?WVBTYUUrRVIvdGkvUlpKTVdvakhkTW5JREE1eWJJTHpyRTJtWVdhQ3ZpcU51?=
 =?utf-8?B?R1dVbnpNcUptOEZTL1ZxbU1Ob3p1N01xNXNvTm5SaEhUMmlyaFloYlMxa0t5?=
 =?utf-8?B?a2x1OXlhS0M3cFo3YlRKU1F3MnpiTDFHR3ZKNGt6eVhKbEladHJPdjhMYVJL?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FDFDC388DB55649A6425114C58E0ACB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78872e1-5fdf-4e17-4195-08dad53e1e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2022 14:53:19.3743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNak1XlGZKuXDB1Fo+aUZvYJqLnoi9hbU7zwEvEf9VFipqkTUBqOY1mf+x+bdFzmuq5HxE9E0QJ8SUFjk2Zaj3e01s0p3mAXvUy1U0h2uyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5636
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTI4IGF0IDE1OjAwICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
T24gTW9uLCBOb3YgMjgsIDIwMjIgYXQgMDc6MjY6MDJBTSArMDAwMCwgQ2h1bmZlbmcgWXVuICjk
upHmmKXls7ApIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMi0xMS0yNCBhdCAyMzoxNyArMDUzMCwg
Vmlub2QgS291bCB3cm90ZToNCj4gPiA+IE9uIDEwLTExLTIyLCAyMToyNywgQ2h1bmZlbmcgWXVu
IHdyb3RlOg0KPiA+ID4gPiBUaGVzZSBkZWJ1Z2ZzIGZpbGVzIGFyZSBtYWlubHkgdXNlZCB0byBt
YWtlIGV5ZSBkaWFncmFtIHRlc3QNCj4gPiA+ID4gZWFzaWVyLA0KPiA+ID4gPiBlc3BlY2lhbGx5
IGhlbHBmdWwgdG8gZG8gSFFBIHRlc3QgZm9yIGEgbmV3IElDIHdpdGhvdXQgZWZ1c2UNCj4gPiA+
ID4gZW5hYmxlZC4NCj4gDQo+IEV4cG9ydGluZyBkYXRhIGZvciBleWUgZGlhZ3JhbXMgc2VlbXMg
bGlrZSBzb21ldGhpbmcgbWFueSBQSFlzIGNvdWxkDQo+IHVzZS4gUGxlYXNlIGNvbnNpZGVyIGFk
ZGluZyBhbiBvZmZpY2lhbCB1bmlmb3JtIEFQSSB3aGljaCBhbnkgUEhZDQo+IGNvdWxkIHVzZSwg
c28gd2UgZG9uJ3QgZW5kIHVwIHdpdGggbG90cyBvZiBpbmNvbXBhdGlibGUgZm9ybWF0cyBpbg0K
PiBkZWJ1Z2ZzLg0KR29vZCBpZGVhLCBidXQgaXQgc2VlbXMgZGlmZmljdWx0IHRvIGRvIGl0IGR1
ZSB0byB0aGUgc2V0dGluZ3Mgb2YgcGh5DQpjb250cm9sbGVycyBhcmUgbm90IGNvbW1vbi4NCg0K
PiANCj4gCUFuZHJldw0K
