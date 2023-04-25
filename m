Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7916EE110
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjDYL3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjDYL3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:29:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D473C23;
        Tue, 25 Apr 2023 04:29:31 -0700 (PDT)
X-UUID: 6e7d913ae35c11edb6b9f13eb10bd0fe-20230425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=I7wAaaI+Fc8/GQj7LcXYw3pPE8sxv5eTOBayvVWBzbo=;
        b=Es1F136TREc4WXSXegKQdTnx7I5fNjjl7VqM6lWkiOgiaq9seW2AS+PtGX/4UluPpMK1H6Bku/oqQUJJEs69KdQO7a2gIqYpbpuWmyFwq/huIUmCQYL9mXFFlNBlaJDlz4FWa1HEn978eHsU3ctgoZMEH/nRhyr1mKV1GkD4V6s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:27f8ea5e-8652-455c-8eaa-7a89dd6156fc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:27f8ea5e-8652-455c-8eaa-7a89dd6156fc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:08453185-cd9c-45f5-8134-710979e3df0e,B
        ulkID:230425143835BKAWWNJO,BulkQuantity:11,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 6e7d913ae35c11edb6b9f13eb10bd0fe-20230425
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1795911590; Tue, 25 Apr 2023 19:29:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 25 Apr 2023 19:29:23 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 25 Apr 2023 19:29:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+sh1AvEQvH6TBYs+7ICkrE7SiWqEBM17P9k46gYGbUDFwNJdyhvztIlnCsSBVsGeCIsviA274CsD21+6Pe+HDshrrEp3JX1+wcpU7aMem8G101jRqZcpEP7r+75C1PTxXFs3X+foj02kz3ZCYEhQhMvAy0zHXylKkQtyS/5FHViG3J+7nlZUIa1GcraNsQFicHKn7jrMf9OZfbAKxWygM8oJCQs7uz6PcftgIjbAgYkKtgQ40F7GgAeb7+5J/tdMxTgxynDJs1gIHYO2TfbZnOvaQPAi3CgnseLlWu9892pufJ7Im52VM/Wgv7Ck0cMIORQs7HqMF7p8b1HOL1JRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7wAaaI+Fc8/GQj7LcXYw3pPE8sxv5eTOBayvVWBzbo=;
 b=N+XcOjk4cVcn+6FHFGmUq8QlmONPfjuzWE7RWPkB9EZMr01f1DdE3ZgPPPbYf0DLqZUOZmpNoFfPO/3nyjIymEMo/XvYg6zWSyDrY11rtuzh7VVyDRbD1/KhM/Y1t3N9jjFQXQ1LEJfRRQbLA4R4ixCKTqfgbzbSzwjPq00OG/ioS3XNMI8m6s3DAtvaKcKJJN3lYcBQLzrlWj7LceA3n0kUbBptpaTGnBuOaCTtI+khys7sPuao2M+H59KSit+kPYUfh/6h8BsTnSWgWzpFSK4qBMu7UZ18q5KwXVay25zpDo47w2h97cWCjkzpdORRb84OU/1xHKNf1EKLD2+AMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7wAaaI+Fc8/GQj7LcXYw3pPE8sxv5eTOBayvVWBzbo=;
 b=ME13fJTUqGP1e23kgeRUEFdksEy8IPKnZnwPV6de+PTpoOW6UPlVxJ4CYBoJnQCiuAFsf7AejpEMFikviQm9ra96wPStT/dJXfWwLZFJsM6NnH+E6v2EmZD37qkXvqJs6BOgXp57JTSbv6bIL2RHEpolOSBTXx7xsH8WVnCpTNQ=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by KL1PR03MB6336.apcprd03.prod.outlook.com (2603:1096:820:ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 11:29:21 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::30b:621:6d75:8337]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::30b:621:6d75:8337%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 11:29:21 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "treapking@chromium.org" <treapking@chromium.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Only apply 4K frame sizes on
 decoder formats
Thread-Topic: [PATCH] media: mediatek: vcodec: Only apply 4K frame sizes on
 decoder formats
Thread-Index: AQHZdQa63kalgy+KSUaXbgzqw3YCJq876E0A
Date:   Tue, 25 Apr 2023 11:29:20 +0000
Message-ID: <36c3a479e0464b9f772ca1dd9ec1f6b626520342.camel@mediatek.com>
References: <20230422103905.1995271-1-treapking@chromium.org>
In-Reply-To: <20230422103905.1995271-1-treapking@chromium.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|KL1PR03MB6336:EE_
x-ms-office365-filtering-correlation-id: 9b32a7f3-58f6-495e-7029-08db4580505b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u4wjv/Uum9NtmNN4KjKKCV6s36iGCmacy4Bwv5y2WBce/ZJvR6RhAbumXagI+AimxQn+MJS65AhN9+BtdxHTgN1T3SAvpjlQWnb8Z2xhjAg/TyuMjbYbVEWNs5EheSxo2QcMW3+j6EPAMT3GkNoTKyMTrWgaTY4XqMne+gaAYJ33FGk4Dp3ac74YaZbUcGAZKFKYaC9038vx/9jt0FRwQIeRRIwG1eMLmXT5DDM4puaAgtZTNCyWeYCqtmcKx9qmjtXZa5vL0R4mm188KaBd3fwPeLWjfCj70kHaLCu0DtitdsPiJlxpQKtqh7COiAZAKFRI1d2xzdOuj7nuBjHOg0Mok9lkLP6I8i6RFtSNLP0k5DvJoCSqxl6LK8Gsa4WMaJ4ZaMc8/sw+8qZlqSN4xcIQvTfrXfi3/iAMLYxhen7oyYYXrt/AQFqrY9WWaEWn+rbGvBiXmkAMcuEyRGknIJEgDnOmHqsxjFK2Wjaff2ZlSViGNj0Us3gFN9/aI+Ccgy5GEsJDXGQzfMjwUeXvA+r8jweHf4AP88C4wZcQjTvo+LSxUSPS1Jew4f70pBfQMD2TuGqeyroRsPY7Os5m1DsiwQzMPlJ4Wi3rDjfBMQSRkgZH3PPCQ23qGrEz8W2F/w9wG5VMYANQrhSxnXPOTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(66946007)(83380400001)(91956017)(4326008)(76116006)(6486002)(478600001)(71200400001)(2616005)(6506007)(186003)(26005)(6512007)(54906003)(2906002)(7416002)(5660300002)(36756003)(85182001)(122000001)(38100700002)(66446008)(64756008)(66556008)(66476007)(6916009)(8936002)(8676002)(41300700001)(86362001)(316002)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkRvbXNSYWg4R2hnb21ZTjZYc0xDYjZLUVVERDBJWjJUMWdLM0cvN000aWVI?=
 =?utf-8?B?MzdrWnd2V25WRURtVU11R0hUa1d5cWltVzRNOGU2M0t4alBPV3hMZFlHdkpy?=
 =?utf-8?B?cVpaSjhUOXJCRUJzeHM4ZjJJNnBrR1NiSEthZUhNSnBON1IrYzM2UURGbWJt?=
 =?utf-8?B?ZERDWDJYeXJaaXVuMHpWQVN1bHZhMzBGZklRZ2pFMzJyVzJYTkMrWEpuakNT?=
 =?utf-8?B?QVdNL2Z0eGdsNExUcFVKcnA4VDArQXovS28vLzh1SFlzTWMrWlJIWVBqdkZx?=
 =?utf-8?B?cUFnbVFxWk1WbFZIVHVWWmZHa2UrZ2dQZGpPWW5QNk9NR3VUanM5UkcvZU8w?=
 =?utf-8?B?VkY3RXJTQ0JQS3krZ3ZseStmUDc4akx6c29OV0JiOGZHWmRZYis3T1NWMHY5?=
 =?utf-8?B?TFpRbGVObDV5RUlHTmwzUFRtVWtMem1OV1Q2QXdTYktqNmJuZ0s1NVBWOVgr?=
 =?utf-8?B?aHUrdFR0ZElZOUdCSUg3dXh5WmZENWE0WVJkMC9kdjgyTzZ6K1B0OGUvU040?=
 =?utf-8?B?WC9PQ20xbHkwREVGNTQ2L0psaElYZ28wdzVCY3FHa05BMytjaitvYlRiZUdj?=
 =?utf-8?B?bG1SNXAxMDJ6Mk1EMS9xcjdsUXRUVjEybWRteFhwNEgwMVFkaG9iRUFaT2du?=
 =?utf-8?B?WkJ4enRybjhTVGVzaEZtSlZJMWp4a0FPTGpNYTltMTBCZHBKV1k0NnRSSmtH?=
 =?utf-8?B?dGhDRmh4ZzFTZkt1Q2ZtYWZwR250WDZxajAxeExyNmlKYzRGZ1lqNVpQRTJv?=
 =?utf-8?B?Nzl2ZXJyYmxROUVNczNYWEozT2dDRU9yVzQzZVVoT1RXYmFta3ViYzg4eTF2?=
 =?utf-8?B?L2hRR0p1bW5URzNvemtlazFWaGF3QklRR1lXbDRka1YxU1V4T1RYVjBFK0VJ?=
 =?utf-8?B?cGVIK1R2Z3VTZHJ1bzZESWIwMmk5UlRheHljT0NtTWNoV1htVmQxK004QTlo?=
 =?utf-8?B?elBkMitCSjg3aXhkcmdBakxRNERsK1RsS3pISVkyUldyMDBXWWMwcm5YQ2Nl?=
 =?utf-8?B?YXREaDJTTkpuZDYrRy9qbnk0VHRQckdnNGRuc2ZOU2pxY0wveUs3b3hxb2JT?=
 =?utf-8?B?OWFMQTgybWN6amNKazMyblhwemoxYVIxVzZ1SC9jTXduQ2lGSko4VzFXb05v?=
 =?utf-8?B?Q0hJZlprc24yd0RSVDRESHZTYTUxOXpkSHdLVkttcDZaQ3JpOXJQOWNqV0Rx?=
 =?utf-8?B?ZmxZeVhmQ09XTWlMMUJZWjVGaE5rOWhoc2VIL2txTDRxbDlhaURnZ0JyZXl3?=
 =?utf-8?B?TUpWYTcrbzZkRzQwTjNIYk56bFZqZlJEVUIwRkRGSDFKRkUvT2RNVFRleVQz?=
 =?utf-8?B?b0dvZWsrSkpBdDNvUGVqbDl0aW53cmFKdHl0dURqaVFtOUNaaXBOcmwvMkpt?=
 =?utf-8?B?NEU4MnhPYWdBcDJZZzZWQnA2b1V1OEJGRmhCRXBOVTZwUGxyMkNOWks0QXYz?=
 =?utf-8?B?VkExNXA5U1lYZ0J4c3EzU0swZldHRWVHTXZSSlVpY3IxZjRuRmlwbjVTZHND?=
 =?utf-8?B?bTVlUGZ2WkcreFNmQ2QzdWloL3g1TE42QUFNY1ZIRGZlbWVIY210RUZkUU5J?=
 =?utf-8?B?U0RCQS95OW4vbkJzRWpmaG5EbHJ2UGRHWGEyN0RpYzQ2VGE4UkMvUmFxOXdO?=
 =?utf-8?B?ekNUNWVmZEJ2cHlib0grcWdpYWpXYnJMaWtZQkhiekNlVGhXVzgvWEtwN3ZS?=
 =?utf-8?B?TUliL3hKaU14TFIwMUdiZkRQVS9aUWdOalh1TFh0eUNiN3NtNnByWVBZdWV5?=
 =?utf-8?B?dzlEUkVZVEt4TVNRSjhrR2RZSlV3YjJ4clorZVgxZ1hIU0x0c3NZOXVrY1Yx?=
 =?utf-8?B?eDBSWDVnZytFL0JCWWJtbFkyajBJY3BoM0ZzV0FkdDRtekNDeFFCZUxjVlIv?=
 =?utf-8?B?dlNUaTIzZkxmNXYzaWpuTVUxYzhCem9YVnBDKzFIdWZFclN2QnJlbGdzYzE5?=
 =?utf-8?B?QWxNTjN3UFpwZHBnSk5aZ1BvSUYwWG82eTZsQmJxSFFJa0NrS215VUhUREl1?=
 =?utf-8?B?ZjdJa2Nxbll6VXppQnBOZ1k4RkdRRTNLQ21tL2dkR01rWktXeTBSdEFRV09I?=
 =?utf-8?B?ZksyMWp2UXBwTXRTU3NtVWxLd1ZKOFR3M1pQcElseWJ6WUZMREsvdjdyNEZv?=
 =?utf-8?B?UEdWZHpTRTF4b3VWcEVLeUdXRUIwWVYyQUVMOXpsQWQ1cFpHeWZtRk9oTXZ4?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBF3EF1CBAEA7544B5EFE9429A4A2090@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b32a7f3-58f6-495e-7029-08db4580505b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 11:29:20.9226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgGLjTyN4xtab8IN6O/RZdP/34ubJZPxU6WKmVN8Kw4LbcF1hktlPsAQzMuQha6QcW7zhSODYR80s4m6IM9FhDkDObJmiynno/Ks9oYZvtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6336
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA0LTIyIGF0IDE4OjM5ICswODAwLCBQaW4teWVuIExpbiB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBXaGVuIFZDT0RFQ19DQVBBQklMSVRZXzRLX0RJU0FCTEVEIGlzIG5vdCBz
ZXQgaW4gZGVjX2NhcGFiaWxpdHksIHNraXANCj4gZm9ybWF0cyB0aGF0IGFyZSBub3QgTVRLX0ZN
VF9ERUMgc28gb25seSBkZWNvZGVyIGZvcm1hdHMgaXMgdXBkYXRlZA0KPiBpbg0KPiBtdGtfaW5p
dF92ZGVjX3BhcmFtcy4NCj4gDQo+IEZpeGVzOiBlMjU1MjhlMWRiZTUgKCJtZWRpYTogbWVkaWF0
ZWs6IHZjb2RlYzogVXNlIDRLIGZyYW1lIHNpemUgd2hlbg0KPiBzdXBwb3J0ZWQgYnkgc3RhdGVm
dWwgZGVjb2RlciIpDQo+IFNpZ25lZC1vZmYtYnk6IFBpbi15ZW4gTGluIDx0cmVhcGtpbmdAY2hy
b21pdW0ub3JnPg0KPiAtLS0NCj4gDQpSZXZpZXdlZC1ieTogWXVuZmVpIERvbmcgPHl1bmZlaS5k
b25nQG1lZGlhdGVrLmNvbT4NCj4gIC4uLi9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMv
bXRrX3Zjb2RlY19kZWNfc3RhdGVmdWwuYyAgIHwgMw0KPiArKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RlY19zdGF0ZWZ1bC5jDQo+IGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWNfc3RhdGVm
dWwuYw0KPiBpbmRleCAyOTk5MTU1MWNmNjEuLjBmYmQwMzAwMjZjNyAxMDA2NDQNCj4gLS0tDQo+
IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWNf
c3RhdGVmdWwuYw0KPiArKysNCj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zj
b2RlYy9tdGtfdmNvZGVjX2RlY19zdGF0ZWZ1bC5jDQo+IEBAIC01ODQsNiArNTg0LDkgQEAgc3Rh
dGljIHZvaWQgbXRrX2luaXRfdmRlY19wYXJhbXMoc3RydWN0DQo+IG10a192Y29kZWNfY3R4ICpj
dHgpDQo+IA0KPiAgICAgICAgIGlmICghKGN0eC0+ZGV2LT5kZWNfY2FwYWJpbGl0eSAmDQo+IFZD
T0RFQ19DQVBBQklMSVRZXzRLX0RJU0FCTEVEKSkgew0KPiAgICAgICAgICAgICAgICAgZm9yIChp
ID0gMDsgaSA8IG51bV9zdXBwb3J0ZWRfZm9ybWF0czsgaSsrKSB7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGlmIChtdGtfdmlkZW9fZm9ybWF0c1tpXS50eXBlICE9IE1US19GTVRfREVDKQ0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiArDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIG10a192aWRlb19mb3JtYXRzW2ldLmZybXNpemUubWF4X3dpZHRo
ID0NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWQ09ERUNfREVDXzRLX0NPREVE
X1dJRFRIOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBtdGtfdmlkZW9fZm9ybWF0c1tpXS5m
cm1zaXplLm1heF9oZWlnaHQgPQ0KPiAtLQ0KPiAyLjQwLjAuNjM0Lmc0Y2EzZWYzMjExLWdvb2cN
Cj4gDQo=
