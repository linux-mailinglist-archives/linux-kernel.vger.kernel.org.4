Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BC86193A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKDJho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKDJhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:37:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E419C2BDC;
        Fri,  4 Nov 2022 02:37:39 -0700 (PDT)
X-UUID: 09a13a9b8fa14beda9783817ea1e4cbe-20221104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EvEdrJjSyIi9FmqtnTFdOEweRyNMcuNEXxqemkImADw=;
        b=eJKArHsFxxuUuyvsiiqZeTZoNDLynuHjPH6PXltPk/CDpaaG56r+C6skTG3aVqtj1zEDyax9GO56dVwVyF6PsGbq8UPpxFrCB0cxTpoUa9R7+szQhaje/Oh6jctWnvNm+mzzihv+VsXQo5O755heaBs4k2MdH5uH2tHdLIH+Lck=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:8cd96f04-45d5-46a5-b0a8-812805ef9d03,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.12,REQID:8cd96f04-45d5-46a5-b0a8-812805ef9d03,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:62cd327,CLOUDID:b56572eb-84ac-4628-a416-bc50d5503da6,B
        ulkID:2211040503281UYX1RAC,BulkQuantity:8,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: 09a13a9b8fa14beda9783817ea1e4cbe-20221104
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1926772144; Fri, 04 Nov 2022 17:37:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 4 Nov 2022 17:37:32 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 4 Nov 2022 17:37:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbWsKdIL8vXdYOm2j1sWvNpTDLSLpVfjfMaozSHTwrAqRe3wjhZCcT/xkYToLfTj18qMjW0Zx5G7bPhM9CgEhhxazRJ0ion2OOmbSES6mKP2dnlv4qZxy+aab36ZUT/nOZ/kbejZ43J7qI3EXkIvcZjGN0rPXkWZZAILZX8QR8SLpELKPyS2fQAgAiXIQNss7J8Rg/VWZIQZnIDgSmYfyoucaJfR2nzF6ziOGPlwDsoBiMICI4WxVCxtXUlgVMRW+aSUgWA94bZw3WvHRIrsvL0MGio52bdR80wURsiwvD6fUmPr/3deRtW7imzlyeu2AQKrme2+Q7POqvAyEufbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvEdrJjSyIi9FmqtnTFdOEweRyNMcuNEXxqemkImADw=;
 b=O25DoypCM7cbPiI8GAzG+bOohsqOVKC29a9Pqh6QsQYEP23ejTu/hsEfJU6xnwZIBrBYC2IzlDXlnjZhqR+gCkStAPBI5L7Jwha7bLHkkLlAyXSG5oACbNx3o7Y346MrVksGMzOzir2hprOzpwpyVM1YQ9LNI4fwpIVD3WTEQVvY9dxL5qkycaWoH2b4nOVNS5Y+gotvEqK0r4TKVleiGx3Xk9O4LjIE5kdsVU+Tx36+pC6QLEqnbr/xGtD5VF8lS7XJYt2ZqOHk8Jk52R574z7AtETR/mzcJX4agPjPAbjv65OKntMwc4Dv2dXpiKsO6dJ0fmjiTlSJhrAInUPIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvEdrJjSyIi9FmqtnTFdOEweRyNMcuNEXxqemkImADw=;
 b=fY1+MKxJH3n8+t+CfFM83HHXfkg4d/1kVt9K468Q/ra8RQ6tYCmAePiF1rDriU6lW9rwjyFqQGbnT8IbrNKBB2FgmZaWDH63u4u1+7NGZxwpyOnUcZbJsg8Ftf2vHzV9+nLgwWM+PFgUgTEVZexYKsz4ix/omCpGW22RByNoWLY=
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com (2603:1096:820:8::11)
 by PSAPR03MB6234.apcprd03.prod.outlook.com (2603:1096:301:9b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 09:37:29 +0000
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::8cda:5c09:3c2e:19]) by KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::8cda:5c09:3c2e:19%7]) with mapi id 15.20.5791.020; Fri, 4 Nov 2022
 09:37:29 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v27 2/7] drm/mediatek: add ETHDR support for MT8195
Thread-Topic: [PATCH v27 2/7] drm/mediatek: add ETHDR support for MT8195
Thread-Index: AQHY7zQjpIVEF/5XUkm/CB1yRDcjA64tsPmAgADSuQA=
Date:   Fri, 4 Nov 2022 09:37:29 +0000
Message-ID: <aef16e8fb787491e4cdba4b472f73aec38efe21c.camel@mediatek.com>
References: <20221103032610.9217-1-nancy.lin@mediatek.com>
         <20221103032610.9217-3-nancy.lin@mediatek.com>
         <20221103210315.lm2d3n4uolra44no@notapiano>
In-Reply-To: <20221103210315.lm2d3n4uolra44no@notapiano>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5175:EE_|PSAPR03MB6234:EE_
x-ms-office365-filtering-correlation-id: 1a63af73-2cb5-4b5e-a4e6-08dabe4830ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P7qEI5sDZNWP/rKeZtlrXBYfX4Z4IdGUqsWrUur24MssKQtHUtzRM+uxG55ZBMoitGavvgJQzd94Jwc01XacNUDQ7ZH5DJPAJ8OB8b/1Sk8tKIt6ENfiMjYwWJ4iC+qeV8y2yMB1/EwOejwwt8U1H/REkuyIDdJG8cuaYTwRsCp6mYcM8MD14M0y+HbT0VEQ4ZMvdvI20rWzntZ31Av5yCc5oB9HZoQGzLcGp0X/R9UitjpKw7iih2nmq31gIli6AowWD9iQH4IOfDHFbBiuWg042ibAfKBF7ocXDEp0epoDj+aybC7AahNXR0e8KlXV1DtawZ7HAvdU71ErkL3TF6IQrvup+k2Ljj7v+Cj4I6vVwQADM51352wOaQbSm7YfviKTr7rVvjDkZEMrwUqtn/AhclwEMd3GcAvuu6wz7HZqR/vL62lBVBWpPdArZiASNZVy17MuGNyyYnLc/MSJjWFoX8oBOlPUKyGokid01q5EPFPbQegIFq73Us31xPpxzSYOpgIpYA+dHS/Jc12G7L2fn+WwVCJ6of72WUf+sRTgjjXXt9g1LN4qP87LtrxC/L2TyYE0F3G3TIzqtB4ImZNIguTNGvAFxbQk56kn9RXaNdbJZp73CsMfDY7Wgf8IJUCWUw1OttDkfNgwGdYo015cS+/x725B5z1xa0JUOyvwnJnvzAZrn0viCZRIAQ7PrlQF1mUVQQ4TkJZqvBut+TenJ87dSbPB8O0Ep0patXcMg1SFxie45dQK6SM1rJqIe9tn3kReYuoyV4ZLxF2TsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5175.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(38070700005)(86362001)(8936002)(4326008)(41300700001)(85182001)(36756003)(8676002)(66556008)(64756008)(76116006)(6512007)(66476007)(66446008)(66946007)(4744005)(186003)(5660300002)(2616005)(7416002)(6486002)(478600001)(71200400001)(6506007)(122000001)(91956017)(54906003)(6916009)(316002)(26005)(38100700002)(66574015)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGo3RVl2MHBES2V6SDR2cUdWdGxxZ2VITnVCa2FFckZXRGRBU0NnRE5YRDd2?=
 =?utf-8?B?TEt1aldQcnI1MldiMm93Y2s5YUt2RUlocTFnQVhMNUwvSWFVbTNJYThTZmVv?=
 =?utf-8?B?ejM3MjJrb0Y0SGYxVTZzV1g5dGZvQUgzS3hFZjRQWDdRcWdTaEhvUG8rNTRR?=
 =?utf-8?B?M0ZKbWowV3pPMXErMHpUYnI5TTRERUJ3aXZsRVl0Vk5sY3NhTHZ3eXFlOXpP?=
 =?utf-8?B?SDV2cmdoa3NLUWJWYkFXSzIrcXZiSWFZaFhyd1dBNmpZKzNOZHNWVitIMXQ3?=
 =?utf-8?B?SWwyZHJWb0FKLzRuMUY4ZWRUcitxdVlpYWZ4U3oyYzlIclB0TG1DV3B6NVJV?=
 =?utf-8?B?ZExnaFBteU5adTBNWnpXT3lPd2JzYWJNYzVlVGVLUzVEUHBMd0tuZnhSNU9H?=
 =?utf-8?B?UzN4LzRRRlV6SkdMS1JKY2VzakZvTW5JV0dlSHFNTEtyNzltZEMwT21IdndB?=
 =?utf-8?B?clNld1QwTnVNUERWdm00VnpwSFVLaUwwOFkvKzltbFVSTjRETU9lOFhhdUNI?=
 =?utf-8?B?blNybkN3S2ZYcm9FSDNBV1ZSR04xY1d6a2djQTFrVW01SkNKMWsrV2hEQmJh?=
 =?utf-8?B?a2JuNHA0cjgvQ21veGRGcy85RXh2NEszL1paMFBqc2t3dWJ3U1NrOThnUVpM?=
 =?utf-8?B?Rk9jL1V5ckc0WWRuR01CQU9BNmRuaDQ5c0xPMXBJMjMyaVU3a0pJTFFVdlBP?=
 =?utf-8?B?eTRCQTZLY0w1eWRuR1RxUTBKRDZUY2RRMWxmTWpXVk9oeTN5VUtSajBLeGFa?=
 =?utf-8?B?RHpDQUtQZWpDTDVoNnF1UEZydlJldE1aYUEwcCtaa3F0VEFJREhSblNubzVn?=
 =?utf-8?B?VzlSd2RJVjJJeVFIMWpIL1VmQVI0RDFzcVU3MTRFL1BrQkNueWJsWDdBQkxo?=
 =?utf-8?B?R0Exd2pGVW43d05iU0gzVDUrcVFXdGp4bDI3QjV4TldXVUVGOEZHTkt1aFg0?=
 =?utf-8?B?cmRMN2E2clhTUGJ2dnRlY0xKdnRRVm0vSkdOYXhpUlR5bitiNGVYelFWOGtV?=
 =?utf-8?B?N3RJSnlmTC9IalBrWGdwQU93VTZranlDRE8zOTZ4TFZhYVBwaHN5aWZielBk?=
 =?utf-8?B?dWhqL1lvNGdNNUFyak1LZk1MNEhiR1l6d1FsempRQWE5VGJIdGNUakR1aWtC?=
 =?utf-8?B?WFdINDdsV2hoVlB2ZFoxeUd4Zk1aRG44L2E4bHBlUU04WUZFVUIyQlFHWE5M?=
 =?utf-8?B?VlB3cjRhaGZ6dWgxbGYxM0VhZGNyUzFnN3MreVRhYnZieWY4SUtieXhNWGFp?=
 =?utf-8?B?RDBWVDYwYzdNem03dGdhRngxOUEyL3ZBT05kbG50dTQveExUcUREVnBYVmsx?=
 =?utf-8?B?ZkdMRE01WE5BZ1dyQTIzMmNzUUNhVUZjQzhuR3V3aHdrWVFjdkorYXJFRU9K?=
 =?utf-8?B?a3RSQTdiTWhjeEZoZjhJTU1IcHZ6UzdoOEowMEtHdWRhdHV3c3UrQ2hCall2?=
 =?utf-8?B?R00xY3lyYTFGRitFaU5sWkdzMlFXdXRSM3VQemVhNXVQa0wzU1dGYnZvYVYv?=
 =?utf-8?B?RDR6S2FpcGRyaXhUYi9mRW5ZY0h1SHV3N3VXZ2UrdkxIcDRFY1F6ak1IZW9K?=
 =?utf-8?B?MWZHOERrSVk0R0ZsSTRoNHBtdS92VFk5eldQVW1BMVMrcXhnY1RrWERwVWVy?=
 =?utf-8?B?NnJkTzJJWm9HZmxqK0MzaWkzNXBGL1pZTmZvWjdiSjNocDAxcm9yOUFHcTRK?=
 =?utf-8?B?VXA5Sk5RKzV5RWhsc1psK2RmSjhORTJOTXZFeXViTkRMUG1mRkh3ZGV0aU1o?=
 =?utf-8?B?OHlKelVjVSs2YmcyQjMzdUw0cC9wQlZxcG9hc2xMYU4rb0laV0RqNFh0NW82?=
 =?utf-8?B?MzlaOS9RdFlNRHlPR3hmdTJFYmNwQ3RyUjhZRG91UisxZTdWeWVBcE9XTml4?=
 =?utf-8?B?Y0tnUk9ubCsvaTVQNWNIYzkwOVRYWVhtNUhWWlhxV0hib0N3QWlTMm1JNDdL?=
 =?utf-8?B?NHlkU1Z1WWkyYVY0Z1JMeWtrTmlySWpXUngwR0JKYVgrVkpONHBWcTNqZjEv?=
 =?utf-8?B?RXMzdyt5QzdXcVlRM1dKT2Q4bW9DNFlHekFCdTFJandtSkY3Ujh4a2luZXZm?=
 =?utf-8?B?TzdSb0tQbzVYeEN1cDZMVHQxS21SVGpGbGlLTHZiMDhUV05YQ1dsUjhJdVlU?=
 =?utf-8?B?aWFRN1IyZDYrUURRRnM0KzNxOVZHQzhPTFozQ1JwR3l6Zkx3T0ZjeSs0ODBl?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A89DB71564C5348B6DF978C5F613121@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5175.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a63af73-2cb5-4b5e-a4e6-08dabe4830ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 09:37:29.3484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fam0k0yYLZHPmuCN945u/HdnUlp/7BvhpLiT4UCszAlSYYoXepuHhUpThCC4auh5WkHRmHWSR88hUrI86uv9WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBOaWNvbGFzLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCk9uIFRodSwgMjAyMi0x
MS0wMyBhdCAxNzowMyAtMDQwMCwgTsOtY29sYXMgRi4gUi4gQS4gUHJhZG8gd3JvdGU6DQo+IE9u
IFRodSwgTm92IDAzLCAyMDIyIGF0IDExOjI2OjA1QU0gKzA4MDAsIE5hbmN5LkxpbiB3cm90ZToN
Cj4gWy4uXQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2V0aGRyLmgNCj4gDQo+IFsuLl0NCj4gPiArdm9pZCBtdGtfZXRoZHJfdW5yZWdp
c3Rlcl92YmxhbmtfY2Ioc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiArdm9pZCBtdGtfZXRoZHJf
ZW5hYmxlX3ZibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICt2b2lkIG10a19ldGhkcl9k
aXNhYmxlX3ZibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICsjZW5kaWYNCj4gPiArDQo+
IA0KPiBBcyB3YXJuZWQgYnkgZ2l0IHdoZW4gYXBwbHlpbmcgdGhlIHBhdGNoLCB5b3UgaGF2ZSBh
biBleHRyYSBuZXcgbGluZQ0KPiBhdCB0aGUgZW5kDQo+IGhlcmUuDQo+IA0KPiBBcHBseWluZzog
ZHJtL21lZGlhdGVrOiBhZGQgRVRIRFIgc3VwcG9ydCBmb3IgTVQ4MTk1DQo+IC5naXQvcmViYXNl
LWFwcGx5L3BhdGNoOjQ1NDogbmV3IGJsYW5rIGxpbmUgYXQgRU9GLg0KPiArDQo+IHdhcm5pbmc6
IDEgbGluZSBhZGRzIHdoaXRlc3BhY2UgZXJyb3JzLg0KDQpJIHdpbGwgZml4IGl0Lg0KDQpUaGFu
a3MNCk5hbmN5DQo=
