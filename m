Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C07691836
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 06:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjBJF5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 00:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjBJF5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 00:57:00 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AB2173E;
        Thu,  9 Feb 2023 21:56:47 -0800 (PST)
X-UUID: b05bbaf8a90711eda06fc9ecc4dadd91-20230210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=J7AX6Wmz/yUeEUFfWCPEz5V6H+n8klXy/6eAVhSQRuI=;
        b=eEI4IZqw9xIwt4PcKyeqoBtusNf1xVX+d12RARKB6fDb/pPSIvoI90TNZj6F+EdcgQKPUmA7oblCkDd9v50OhmTg0pXeraJkNLAqncAB6O+ChLngf42ywrnxnbJkkxsCVQo9yuVZJRw/XNZ0BjKik5JIy4YXoiiEl9iPThnVUQY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:9720933b-9618-4c4b-8886-e0c3ae25790e,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTI
        ON:release,TS:18
X-CID-INFO: VERSION:1.1.19,REQID:9720933b-9618-4c4b-8886-e0c3ae25790e,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION
        :release,TS:18
X-CID-META: VersionHash:885ddb2,CLOUDID:925809f8-ff42-4fb0-b929-626456a83c14,B
        ulkID:230209165727ICC6O9NC,BulkQuantity:18,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: b05bbaf8a90711eda06fc9ecc4dadd91-20230210
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1643348244; Fri, 10 Feb 2023 13:56:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 10 Feb 2023 13:56:39 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 10 Feb 2023 13:56:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHrnpDy9yEKtYyc9KCjB3yzRkodRUccGay3TseFiJOV0XBEwSG+KHypTp+mTP+Oa5+iMYpIx+BQ636jy68AbayQ2V/3qwiOKF8v+SO+LgHs0Q6pvoI+/c2A3Mr8QeRmxn965JuwIYvftZ/Oax7K0b/719pHQ9Mv71+2UE1b7mI1riAFUuk9/wieGswZI7zpUXNk1ZcMeoh+X3xPkpQSbQqGUmFAJHYUK0qkMkX41QZYykti7yTp8G7MtHHzvrz6Y6B2vKv+oe7r5u8Z4yzRynGK6EagYp0mcXA4ZTx7mCaJwehWg/u6pen/lMRYokQWSzIiYp1e9oGmupAkkMsnVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7AX6Wmz/yUeEUFfWCPEz5V6H+n8klXy/6eAVhSQRuI=;
 b=ixuLx0qoGnj4Mh48Uh0Kfk/eLW/GnoKrndPNrfORZZItx+PYq084zmoBqVxE98LVgoCcM9n0zx31NBwiKPILDn5UOsNXltoBFJfZhxzGDiZ7+pNoiT6XPX/jEaCJYUGlxf6gJAm31ymuIAVbc9kr6eu/VCKkiD07qAw78duiLm7FKBbKKTP8kOtC8h3Ygp4fA4UVGpM7gH4Nsg7sVVwzr9xfILRHSNVT5ll1BbTIFtpFYIIe8t4SUElDVSCPWAPcXA3+hdTIJRE+yE9fTn1S8if1YnNcO2TZ8OHpYCafZu+yGFhJwmi4WsSnLbZTZBe8evykknGgKnyxa3GZAgkYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7AX6Wmz/yUeEUFfWCPEz5V6H+n8klXy/6eAVhSQRuI=;
 b=T6dZbmuTYtQaJe8Vj9eir/8rkDBB62GOFIlhGcm94hULvnftrPAVIooj+mtVn7jh0kSlKEQ8fffmGOmU0DtUTVHLP01Vmf+NSaS5Q2TfbIhDlpBfYTIiwkDLHHFvJ9ucjnAr/k6fEuAOEc2tr8Krx38UIJvgjkxhQ+k2KBNwfUw=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by PSAPR03MB5702.apcprd03.prod.outlook.com (2603:1096:301:86::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.20; Fri, 10 Feb
 2023 05:56:37 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::5a1c:8321:d329:db44]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::5a1c:8321:d329:db44%7]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 05:56:37 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "tomm.merciai@gmail.com" <tomm.merciai@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Force capture queue format to
 MM21
Thread-Topic: [PATCH] media: mediatek: vcodec: Force capture queue format to
 MM21
Thread-Index: AQHZPFnjY8ca8o7sRUKNh+xpVKMSkq7GUFUAgABC5ICAARzxAA==
Date:   Fri, 10 Feb 2023 05:56:37 +0000
Message-ID: <d3754485de6cc5a4b4b1246fb0bf86f13711cf4f.camel@mediatek.com>
References: <20230209074025.1816-1-yunfei.dong@mediatek.com>
         <Y+S1cA4PXT1MVJm8@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
         <28f167b7-c468-8752-29d1-2a122e8142dd@collabora.com>
In-Reply-To: <28f167b7-c468-8752-29d1-2a122e8142dd@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|PSAPR03MB5702:EE_
x-ms-office365-filtering-correlation-id: 96777ebb-3118-4773-084c-08db0b2b928d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GtkkMbCF6K8uvpvUHmJOK0KxyA3qlKf3JyAzj4JHnwKJk961ypgJGfJQ3gjUV3QRU+0tL19D8byy6fQruyofx5aidu8AVE1Zv6BP9vmKp6sVMa2qLiUnRkRi9+WquPUp/sXw6HkrV+G3S6mRMT65DJbfzioOV2FquHIo/9pgUh8oCBe2WMLZw6fwF/PssmlMTnn7KBoiw/3WUZt612JDdfmqHBa5o8h1Y6sCnxmPBpr7hsiUbt+ccUf0TN2srz9aB6JfB31Nnkmqhlw/oBhiMO2vm9v1Vk5T1p8qdCdAr5JpRIDbrIJ0q2a/jpFwDLys6cM4eAurGMiYiS42aHXMfnLq9OYAbX4wWz8kloUbiaLxdrrseAdisFgeBCc5K9IQaA4d7ZvGjiPfnnQk/OPnaTmN5OqAgcXFLlOPuVIDJ8lSVQ0lMF9RdwUJSN2cfEjgNOgKDDJFAcAfIYRakBSnWefboR5Lfq8Mt9osGAiMzYV2VknAf6YfONxwkGWUkNd4mmp+/jEbtEnaIJxJlaycDrLkkRBqiqyonF6u07p/fVaBT7SkxPjpZcp31Ylx8elt+g6sWg/Q9lUKA1XQukNVSZIQpb+8lU9uodp5TXH4SPxcUo9sjsTs8aqzawfxXnGXnfHq8jRI3bR7Xzl++CwZFVkuOlW6Vg3SNWQz2sYg8atI6NBP0iEBRnTqu1NgtOso9j0RWAXOUJQPRZNhhwBa15t0wu/7AVpwM5tAMJf8Dc7/9n1ntffo2Ddq+RVvU8YRyDengUxkQs0UJS+4ijkZbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199018)(85182001)(86362001)(36756003)(38070700005)(122000001)(38100700002)(83380400001)(2616005)(26005)(186003)(6506007)(6512007)(478600001)(71200400001)(6486002)(91956017)(316002)(8936002)(41300700001)(5660300002)(110136005)(54906003)(2906002)(7416002)(64756008)(66446008)(4326008)(8676002)(76116006)(66946007)(66556008)(66476007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk1idzJUK1owOU1wR1FjU3R6TTkzbDRORnVMUjZWNUYwZzJ2Q1NxWnRjcDF1?=
 =?utf-8?B?R2N2eUxVMFFPcU9Wa1V0WVFoWURxbTZPczFoUGFLUEtsSWlxNlNmOW12NXZ2?=
 =?utf-8?B?N0FYZGYvZGxuQ3AzUDZuQkNUaFp0N2JoRnF5Qm1tUUJDZThkcnA5SUdyZk1E?=
 =?utf-8?B?c0Y4TktoYTJCKzcwTzgxM2hZUE5aY0JPMnUyVGxDZWRpQXljd3h3cDVKem9T?=
 =?utf-8?B?RWx1ZkRQVWowNE1PK2FKMjNPemJaV1VNQzI5bWZqVWl0VHlodDdOM2twV1U1?=
 =?utf-8?B?TFVqRzF2eGs2S3RDcGppUXNZcUYxeVFEUUw0KzY4ck05dUNWSElDcmJWcHdZ?=
 =?utf-8?B?RFU3enRnenduMDFQa0ZGRHAyMURyZXBGOUppNngxd2N5RXlwSTFXM2xhMGxV?=
 =?utf-8?B?N3creUJBTTEyZ1pDWUwwVHprN3ZEOHhzVVRrb2YzOXp5a1UyVmJPVXZpc21F?=
 =?utf-8?B?NjFOQTM4eFJ3TDY4a3lkR3hpVTVUdENIQyszM3dBNEdRZ0RMWks4cWFiYzJE?=
 =?utf-8?B?NTNVaSt6dW5lNDFlbWhWUkVBVzhock9Sa1VmV2hhdWZYSytuK0ZHY2ZhL3Av?=
 =?utf-8?B?UHZ0alozOVo4d202ODR4RlQxb1dQelRUL0dtdk5EcVIrdXBTMVNxcnhucmNO?=
 =?utf-8?B?ZDBZdkVVZGpnc2pIb2FkN3dTcEVoRGhsaGlwNmhGOTJ5eGVwRDBmVGp2Wk5H?=
 =?utf-8?B?T1lVUHhQTzhIK2ZkbHdTVHJ6bW1OTUJwS0N2V3J6aTA1VGN2MlRXTjdpeTNt?=
 =?utf-8?B?blBxRlJCbnpNM2k4OVgyTm9DS0NFVXhaWUMyOGxmV3hETXE4TVp6SkFZWFYz?=
 =?utf-8?B?RzNRaGUwSlVRN2NEK3VrTE9hKzl5TXdEd0sxOTdJV3N5N0o1eXAzL2ljWjJH?=
 =?utf-8?B?dm1uaXBYd1g4bjU0T1JZR05LeDd1RGRyQjgvU2N3T2s2dDhQY3lPL0VGWXVK?=
 =?utf-8?B?WWFISDNNZjVhUldxY2lnMVFZUjM4RXI0TFU1MnVERFlJRGxXdlZ4Yk9mZUJQ?=
 =?utf-8?B?QnQ1VG1VZHNDQWdBNWwvcEloOFFFRURjc0pNTy93NW11dXVKbHprK3lHSllS?=
 =?utf-8?B?U0ZuLzJrTzFaN2F4TVlaMTE1ZEszKzdYTkhYcUtRSzIrbThqazlkbzQxa1Js?=
 =?utf-8?B?ZGtGOFlHWER6ZXZSSXNJU1Y5VDVxbjdhdVF0OG8xS08valE2U05XWCtiem92?=
 =?utf-8?B?eUNpR3c0TThLckpUSHdGZXdOR3NqYXE1eFhrMEFEOGVtQnJ5LzRuc3hvTDRt?=
 =?utf-8?B?NWh4TlZKWEJZbmdINU1JWHdldzZ6b2FvUGJiNnFQUkJLR0dpREFHZjViUFEv?=
 =?utf-8?B?RWpWR1VaTi9JVHk4bEd6cHdON3VaWFRGWENEaFdqaDdoQ2RMck5NSDZvYkg3?=
 =?utf-8?B?SUN5Z25NZlBkeW1tbFNmbU1mWkVjcFZzYTltYm1LcFg0MS9Ddm5HYW5sTnBL?=
 =?utf-8?B?M3k0aThVVCsrcTNEVC9CdU9ZTHRvQlQ3azlRMXlsS2dCdGtVNVpXWkdlZzlP?=
 =?utf-8?B?b0I2Q2NWczY4ZiswdkNxWHFmK1FVeXcrblEvaVpmT0lnRTBrYklEVUNyczcz?=
 =?utf-8?B?VlREU0UxamM5Q3F3R2VzcFd1VWZOamU5UkF1Y2ZxZWRGZERsUS9hYVN6SDh4?=
 =?utf-8?B?R3Q2bmgyd1BGalFJZXZGN0wyK2hhR1VvMEtMYzJZMVJlZ3lTZncrbkV4MU5X?=
 =?utf-8?B?RGVpc0xwdlh4Ym0yUmpMVFBBSGFmM0hOdFhNUVBsc29nalNuRTZsdTEzWVJC?=
 =?utf-8?B?aTE5bTEyc01qL1VCc2NJQ0ZpTmR4N1FmZmhwR3EwWFZWdFRtSFhUM2pYd3Fs?=
 =?utf-8?B?NHV0cUVwK0k2alhDVFBwTWdmSjd0WjFwUHFxQVg4QUlJNVcrVkkrOEVhYWZ6?=
 =?utf-8?B?L2lwdzJyZ1BLY0lzLytUSm16dGJmYnpHT3QzYUZaL210YnZZZkRrK0JuTzRI?=
 =?utf-8?B?Z2x3QUNZVnowMElWM09wM3IzYWFscE1uaUxrd3pNWmdSeERrQit6bWpBUnkr?=
 =?utf-8?B?a0dWVlE0ODJQQ1hPT21rWVNJQW1qc3lmUXc0eE9ocy9abTVkVTUzVVo2Yk1K?=
 =?utf-8?B?TzVCdWtHLzBMU1ZkSDREbnd6UWtDR1FmWE1KeExHc3lnOXU2ei9lNmtwc0Y4?=
 =?utf-8?B?NHFFRzFseHBzemR6NEp1NEtMRTZlT1g2TEo3Q0ZKb28xR3BYMGZKemphUGdE?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7714622D08C5BA4880B74E2AF6E165BA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96777ebb-3118-4773-084c-08db0b2b928d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 05:56:37.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHAO2ZVnx9UNBB0+/pUGv6ZRiDrIj3M/f5JAviabax2moqPlYaBVTce/zEh0Joe+AtiKOn99gmfOCSNQdC0kS0FMNTAjU4SuO0w0fZl8XCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5702
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

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpBZGQg
Rml4ZXMgdGFnIGluIHBhdGNoIHYyLg0KDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0KDQpP
biBUaHUsIDIwMjMtMDItMDkgYXQgMTM6NTYgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vIHdyb3RlOg0KPiBJbCAwOS8wMi8yMyAwOTo1NywgVG9tbWFzbyBNZXJjaWFpIGhhIHNjcml0
dG86DQo+ID4gSGkgWXVuZmVpIERvbmcsDQo+ID4gDQo+ID4gT24gVGh1LCBGZWIgMDksIDIwMjMg
YXQgMDM6NDA6MjVQTSArMDgwMCwgWXVuZmVpIERvbmcgd3JvdGU6DQo+ID4gPiBJbiBvcmRlciB0
byBjb252ZXIgdGhlIGZvcm1hdCBvZiBjYXB0dXJlIHF1ZXVlIGZyb20gbWVkaWF0ZWsgTU0yMQ0K
PiA+ID4gdG8NCj4gPiA+IHN0YW5kYXJkIHl1djQyMCB3aXRoIExpYnl1diwgbmVlZCB0byBmb3Jj
ZSBjYXB0dXJlIHF1ZXVlIGZvcm1hdA0KPiA+ID4gdG8NCj4gPiA+IE1NMjEgZm9yIExpYnl1diBj
YW4ndCBjb3ZlcnQgbWVkaWF0ZWsgTVQyMSBmb3JtYXQuDQo+ID4gDQo+ID4gU29ycnksIGp1c3Qg
c29tZSBjbGFyaWZpY2F0aW9ucyBvbiBteSBzaWRlLCBqdXN0IHRvIHVuZGVyc3RhbmQgOikNCj4g
PiBUaGUgcHJvYmxlbSBpcyB0aGF0IGxpYnl1diBjYW4ndCBjb252ZXJ0IG1tMjEgZm9ybWF0IGlu
dG8geXV2NDIwDQo+ID4gdGhhbiB5b3UgbmVlZCB0byB1c2UgbW0yMSAoZm9yY2luZyB0aGlzKS4N
Cj4gPiBEaWQgSSB1bmRlcnN0YW5kIGNvcnJlY3RseT8NCj4gPiANCj4gDQo+IHZjb2RlYyBjYW4g
b3V0cHV0IGVpdGhlciBNTTIxIG9yIE1UMjFDOyBsaWJ5dXYgY2FuJ3QgaGFuZGxlIHRoZSBNVDIx
Qw0KPiBmb3JtYXQsDQo+IGF0IGxlYXN0IGZvciBub3csIGhlbmNlIGhlIGlzIGZvcmNpbmcgdmNv
ZGVjIHRvIGFsd2F5cyBnaXZlIE1NMjEgZm9yDQo+IHRoaW5ncw0KPiB0byBhY3R1YWxseSB3b3Jr
Li4uIGF0IGEgbGF0ZXIgdGltZSwgSSBob3BlIGFuZCBzdXBwb3NlIHRoYXQgdGhpcw0KPiBkcml2
ZXIgd2lsbA0KPiBjaGFuZ2UgdG8gbm90IGZvcmNlIGFueXRoaW5nIGFueW1vcmUuDQo+IA0KPiA+
IFRoYW5rcyBpbiBhZHZhbmNlLA0KPiA+IFRvbW1hc28NCj4gPiANCj4gDQo+IFl1bmZlaSwgc2lu
Y2UgdGhpcyBpcyByZXF1aXJlZCB0byBnZXQgImJhc2ljIiBmdW5jdGlvbmFsaXR5LCB0aGlzDQo+
IGNvbW1pdCBuZWVkcw0KPiBhIEZpeGVzIHRhZzogY2FuIHlvdSBwbGVhc2UgYWRkIHRoZSByaWdo
dCBvbmU/DQo+IA0KPiBUaGFua3MhDQo+IEFuZ2Vsbw0KPiANCj4gDQo=
