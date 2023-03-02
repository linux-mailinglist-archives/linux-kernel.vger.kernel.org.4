Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5BE6A7D50
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCBJI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCBJI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:08:26 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C99913D4F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:08:21 -0800 (PST)
X-UUID: bf014d66b8d911ed945fc101203acc17-20230302
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RZgy1mbJSIbvVNuU09kWcqNj+YTNAy01AloLiqU4wO0=;
        b=hb+Pn+FYKVXQv8l6qBaQg5npNkUKaUHbJ+sXidz6H1F93VyNeCxQgSW2LP0+CMNLo4rhaKjHUyW6wrazDlYGcrsqG7x7PY/52fj/TcqgvTh+24T8bDaWhuMv0EG/KOa4BoUlvA3FJSAYaqFDRTroi02IiRGd0igqlUN4Uxan4Jg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:a86c7d86-b328-4f6b-b8b6-da5f70d151d5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.20,REQID:a86c7d86-b328-4f6b-b8b6-da5f70d151d5,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:9fd0fcb1-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230302170808L39IN0JX,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: bf014d66b8d911ed945fc101203acc17-20230302
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yanchao.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 65667662; Thu, 02 Mar 2023 17:08:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 2 Mar 2023 17:08:05 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 2 Mar 2023 17:08:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0G4a5kipgnO5MJcFccm/IyI2KAXJRa34nxDHqWvFU0Oa/n/RTdnmGOn7IbaTo/1R4i3Bqf8L0TRffsKGrFmYefDxCmRIKlmQMzB/ZSjL1w9pmwWA/AGgOfmG5ALsmdJOBsV+t1qr7rB4CKhWThqIig4BEqYn2+LUYG2XZHoqJNey0NqBAYTriLVJGls+wtlRzDYvsWUYPpEMUlik+10Nlan2rxanM3yOJe3cRdGpjyjYMfrXCtYwClSxYihRZg3ULvjVV4oB8fUGk8gUeWRXSnHE8iD4klVb0lKfmBXXsSpl4MPShwlpsv2uNRdN+RTHPMSroH7la7+apMnfRkjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZgy1mbJSIbvVNuU09kWcqNj+YTNAy01AloLiqU4wO0=;
 b=UGvGRpxqZ1Ff1YBYskc4di+K+qoW92lXdH06sFRHwiL9nLDoDStbCUrkLjL6KgOrJ9NAyDYVNzJwdz8ZLwBW9URQXgAUyUYQCEDu/nout/WVZsMd9jLHJFYWCa9iY5nUTFVBp5yxbVkAySUHG7OcLZr5AjNwH7TJ78j10cA5XS9MlrEm+Zgw06bg301ydTzfrc/gjfvFkR4RAk53+LxGqrZ0AJbFB9BkmYJpeGkGdqXhDd3vGtxcUDqvUkSEWZnXIAoc9HO4ID9mnWp3SIHG5AHG6jyhBjm4HJO8lttDOaYN2QAZUPQj4/8KmjIvzSED7eiAs4NniXPopebvUDj10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZgy1mbJSIbvVNuU09kWcqNj+YTNAy01AloLiqU4wO0=;
 b=u3j4ajc+hI9ulMKa6kxyOHJbsCp2T90IEtSWz1fd2yFZZ6dOU77GLnYnrkeJQ1yxFSJoBgxVvQzS/tLgPt+Xwp5w1ouBBcJTnCke1O1YZID92EtcZfTYF0WmXWkNwOoVmK5tll4LnwCif7WPN7qZQsyLElT8pX0/GX7Ah/UKkoc=
Received: from TYZPR03MB6161.apcprd03.prod.outlook.com (2603:1096:400:12c::13)
 by SI2PR03MB5467.apcprd03.prod.outlook.com (2603:1096:4:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 09:08:03 +0000
Received: from TYZPR03MB6161.apcprd03.prod.outlook.com
 ([fe80::7b38:f629:1b13:6dc7]) by TYZPR03MB6161.apcprd03.prod.outlook.com
 ([fe80::7b38:f629:1b13:6dc7%8]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 09:08:03 +0000
From:   =?utf-8?B?WWFuY2hhbyBZYW5nICjmnajlvabotoUp?= 
        <Yanchao.Yang@mediatek.com>
To:     "kuba@kernel.org" <kuba@kernel.org>
CC:     =?utf-8?B?Q2hyaXMgRmVuZyAo5Yav5L+d5p6XKQ==?= 
        <Chris.Feng@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWluZ2xpYW5nIFh1ICjlvpDmmI7kuq4p?= 
        <mingliang.xu@mediatek.com>,
        =?utf-8?B?TWluIERvbmcgKOiRo+aVjyk=?= <min.dong@mediatek.com>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "m.chetan.kumar@intel.com" <m.chetan.kumar@intel.com>,
        =?utf-8?B?TGlhbmcgTHUgKOWQleS6rik=?= <liang.lu@mediatek.com>,
        =?utf-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= 
        <haijun.liu@mediatek.com>,
        =?utf-8?B?SGFvemhlIENoYW5nICjluLjmtanlk7Ip?= 
        <Haozhe.Chang@mediatek.com>,
        =?utf-8?B?SHVhIFlhbmcgKOadqOWNjik=?= <Hua.Yang@mediatek.com>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>,
        =?utf-8?B?WGlheXUgWmhhbmcgKOW8oOWkj+Wuhyk=?= 
        <Xiayu.Zhang@mediatek.com>,
        "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 01/10] net: wwan: tmi: Add PCIe core
Thread-Topic: [PATCH net-next v3 01/10] net: wwan: tmi: Add PCIe core
Thread-Index: AQHZPfRhXG0uLuMh9ki8uUJNPx0e967PblKAgAIgUwCADDu2AIAAzFUAgAQ2vACAAHJFgIAA1h0AgAC0CwCAAJfcgIAACKKAgAHmuwA=
Date:   Thu, 2 Mar 2023 09:08:03 +0000
Message-ID: <2f056115b252c8b1dfe66357a1ca8bacc3d71c4a.camel@mediatek.com>
References: <20230211083732.193650-1-yanchao.yang@mediatek.com>
         <20230211083732.193650-2-yanchao.yang@mediatek.com>
         <20230214202229.50d07b89@kernel.org>
         <2e518c17bf54298a2108de75fcd35aaf2b3397d3.camel@mediatek.com>
         <d6f13d66a5ab0224f2ae424a0645d4cf29c2752b.camel@mediatek.com>
         <20230224115052.5bdcc54d@kernel.org>
         <e7628b89847adda7d8302db91d48b3ff62245f43.camel@mediatek.com>
         <20230227110047.224909ee@kernel.org>
         <ebe8c4057b16c6565223af53bfb229dd1846d26b.camel@mediatek.com>
         <20230228103132.325def4c@kernel.org>
         <3e38940908752018bda7912f294d7a7c390657b7.camel@mediatek.com>
         <20230228200557.1a563b0a@kernel.org>
In-Reply-To: <20230228200557.1a563b0a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6161:EE_|SI2PR03MB5467:EE_
x-ms-office365-filtering-correlation-id: 107d42a2-1eb8-4d8f-7cbb-08db1afda0fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mnVTjDptjyL7jSMoEDg3OMOB6bTcwJd4LZnU2kEBCgQkENpozZopPR8eMxMIbtyDXLCemDCAYSVOdeBRABAh4+Vy9YlLYvdtwRSs9WK5GHEHGMJJAAnULlPtLRszl0SybCZtZY/jgfcCHEYf7ci7ySCdHllPFcYO2xiEuRq0mQycXmYULcqkzAFqT7CWFAZEgD9idu3ubkIZ+uozg9rZKKnG1FPxYjfJh3097oyy3/ScBhB7GeYN4Y+jM1+a22ACZZxYIMp21UHVxaEPkXemyrMGZUR/0wGAaeEdH0shQyhIJ8uzAwhYNIqcKcTYV1fKGX76Gfp7ccxVdcQtQPv27dAxHpOAmjRDClwlbjk7swyfgmQJHpqMKyM1fy+1fPRv/S16LWcMZlJk8+l3esBtUveragn4kgP5TpPfsVxGqnTYOXyGg6J4VVDSseIB+EM8Y380NyOZe62qw/7a6ULni6sp5cbMPd1GuMABiMLMolKmruExomGPc796gOESbtCNu26vn0j6QcuvULnXwWNIRoLkOJdvHf19xrOr8FD/jtWWAuwazLZ7ndPa+JIRN04wyM8HJ+DVEVRRBSyuEUHnQG1lgCuWTomqj3v3NaK0lS4VkDQ9j3abmHnSgS+OM5ZRILFXNng0v+Nr2aYSvEE24U2fm82HV/hf2xxDmeF9oTAdAEPn8aEifz0G/8XL1ykCqHwEV5KRHxxqI7DT/QvwgoSkUo02P7GOflHY7KeehDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6161.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199018)(86362001)(36756003)(85182001)(186003)(26005)(6512007)(6506007)(41300700001)(38070700005)(2906002)(66556008)(66476007)(66446008)(8676002)(66946007)(4326008)(76116006)(64756008)(6916009)(7416002)(4744005)(8936002)(5660300002)(38100700002)(122000001)(2616005)(478600001)(91956017)(54906003)(83380400001)(316002)(6486002)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1ZzaUpIS1I3M1lsYUhyRWpOU283MTVJbnc0K1dGeFc3K3Jqb1QrVU5BZ0lD?=
 =?utf-8?B?VUZvVGpsK0ZvMlpUSmM2VDRuRXlpczVLQU1HN3RaQUJySjVWY1VUd0NRaUxR?=
 =?utf-8?B?ZytpMjc4T3l0QWRPTlJ5YTdZaDA1TkszdEJlZWhINEhVcFpaVVJ6a1EwL1o5?=
 =?utf-8?B?ZzhDaWh6bVlLRVdDdUVva2ZTSXBicHhJRUVncFVIYzNqcVl3Qk5aTmVaeXNU?=
 =?utf-8?B?QkFpWUxGSXVnVk11ajA3cW4wUkIzUVBJVDBNcnBBMklMSUIwK2JtdkprZk1C?=
 =?utf-8?B?dGJjU2NrOHpkcTZFTzJOWkE1N1lCZkNWVHdhUmJ0QkQyRzBmVFVZQkJkcS84?=
 =?utf-8?B?NUdaZnRMUVRRc2VrSWZXakVpb1ZjSU9JWnVxYmtZUDU3WmMzdzFlYng5NS9T?=
 =?utf-8?B?Yk9CN0xyS1psQ3ZiU3hvMmowQWVmVEY0VWQrMW5oRGxxdDkvSU1UVCsvZDgw?=
 =?utf-8?B?MUJKdmxVNzllTWJKc3V6RGdtTjMrNWtUR1h0eVVUUkY0VUJxdVc0THNGbGJk?=
 =?utf-8?B?STYwc1NySUxrdkU4OUhQSXE0a2lKUGJBRDBtbHJndEQ4bHBkL1dZTDdNZzlu?=
 =?utf-8?B?bHoxMzVWTzJEUXNXWVoxSUdBc3QrSlEvL2hIaWRKTC9UQ1RDUE9FZVNNMFNv?=
 =?utf-8?B?U0VpMzhKbCt6b3hMS0pHeHQySHFmU2ttTmdueC9XalprWkpnRmN0VGNLbElJ?=
 =?utf-8?B?alU1ek1FcjZBVURBbW1QcjZMMnk1ampuRElBM1JOeTlYeEplaW5ZUmR0dHFV?=
 =?utf-8?B?R2duUXgvMnEvY1pwdEV6L3hZOTVERGxlRkhzSEREbTAwQktxVmNWMklzeTVs?=
 =?utf-8?B?QjRrVDd4TmNwakswREdiZEtwYzZCSk1JcG1Rd0RGRGViODVuMDRIUzh0WEFG?=
 =?utf-8?B?RGVENkxBa0ZKaFRuVkhVZHV3S2tTYlNYOVpjSHl6OGxSNlhlZTVWR3JBMmdH?=
 =?utf-8?B?ODZtOHNEcDdhOXoyQTU5WHJQeTNqRGsyWFd0ZFNsTkxYMDVWUFZXdC9uNGxs?=
 =?utf-8?B?NTJQZUIvK01oQWU3cFV0V29PTjBPS3Jodi84SDVRTGxnQzh1dnJkbjlyS3dQ?=
 =?utf-8?B?bmlVRWVDem5NOGF4SFBRNXRwMG1QS3gxLytaVDYvNmJsWi90TkwycVBxdkZR?=
 =?utf-8?B?NURScm0xdmNhWnFOTkplM01OeldKRFQ4NXlmZWljOG9Oa3ZQU3dKdWNpOXFY?=
 =?utf-8?B?UDVBcGFmckZDbGIrRmlOWlFMclV0MHVOVGhyQldSRWRhY2NEUjRkeXY2aS83?=
 =?utf-8?B?bTZyMTc0eFBVdjRrM2RaV2c5c0xzZGVETjdPeTN6RU9YWjkwbzUxeGJoODRt?=
 =?utf-8?B?TnZqQnNEM0pFUUhBS3poYkF4SzJsa0NianFudHBRSmJPMzJEeCtQVTAxZDA0?=
 =?utf-8?B?YXdOaFJTVjl1RXJjS2hkODJ4RjdWN1hhOWp4ekVKVnN4MThRdVhXbDloS0cz?=
 =?utf-8?B?dldnZGI1K3Y4UkVDMU9pM3NaaG5LQWM0Vzh4QVF0Q1lycHpnNzJjbG1vSzV6?=
 =?utf-8?B?MTF1K1FaeHFXbVlBT24vZTV6alN3TW43ZFV6enNVeTZEbEtlOEY3WWVIWXBs?=
 =?utf-8?B?VmhoNzhoenFsUFUrMTROemtIZ2RSUUdUdVZ2bHVEQWNlczR1UmxRU2xlL3lB?=
 =?utf-8?B?ZkpBaGtrdWV1RmswUFUzazZJc3k5VUVOd2dYQm0wWndsK3NyMDFNZWdIdmNB?=
 =?utf-8?B?aTFuVjZ0amNWY1A4SWhGeCs2WTZ2ZStZTlFhaVdXUUYvM1daTTd4d3UvTnAz?=
 =?utf-8?B?L1hMNytVN2JHSmsvblhkM1NMNjlUWFhQQitlZHhiMlNVK21TT1ozMjNFdFE5?=
 =?utf-8?B?cGtQZ3pvZUROL2pXL3U1aGIwOVFHZ1lnV0haSkVrdkh4ZmxFMERaWkFhMFlS?=
 =?utf-8?B?UDVCMEU5UFlqY1ZRcGxtY3JHbll3eEEzVlpYd0hiZm56NGl1dndXb0crU3Iy?=
 =?utf-8?B?NS8wMlZpQ01FdmhEVDBNelJRVDhXRlUxa0JSQlNnZXh3ZTdHeUVxMWJZZEQ4?=
 =?utf-8?B?UEZWbVlEdUNBQTVHdHpIekNMTnBlS2ZmYlRlR0lWZlRIck1UaksxYVgxcjZD?=
 =?utf-8?B?cmpWbDdnZVl2NFVvYWxEZlk2RzUvVVEzNVBrdzJhYTBLYUZYRHpZOTdvRGoy?=
 =?utf-8?B?TE0zdmRueU5mbjNSSi81SUpLcEllNVRRMnZvNFZuRXErVHFRNEJhOWQ4Y1I0?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9785AF21F5260E47A396C4BAFA4719E8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6161.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107d42a2-1eb8-4d8f-7cbb-08db1afda0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 09:08:03.2825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1Zc2vzjRD1d2vWo87SiWzyec/mSZyVlhaCSnoY8/EK1JlDt33tyKnxJbkmyb6lymbQYPfQ/Tgw9nwytQX7zR0HC3rhP7FPV40gbcJ85pOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5467
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTI4IGF0IDIwOjA1IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCAxIE1hciAyMDIzIDAzOjM1OjA1ICswMDAwIFlhbmNoYW8gWWFuZyAo5p2o5b2m
6LaFKSB3cm90ZToNCj4gPiBCVFcsIHRoZSBwYXRjaGVzIGFyZSByZXZpZXdlZCBvbmUgYnkgb25l
IChwYXRjaDEsIHBhdGNoMiwg4oCmLiksIG9yDQo+ID4gYXJlDQo+ID4gY29udHJvbGxlZCBieSBy
ZXZpZXdlcnMgKHRoZXJlIGlzIG5vIG9idmlvdXMgb3JkZXIgZm9yIHJldmlld2luZw0KPiA+IHRo
ZQ0KPiA+IHBhdGNoKT8NCj4gDQo+IFRoZXkgYXJlIHJldmlld2VkIG9uZSBieSBvbmUuDQoNCkdv
dCBpdC4gIFNvLCB3aGVuIHJldmlld2VycyBzdGFydCByZXZpZXdpbmcgcGF0Y2ggMiwgcGF0Y2gg
MywgYW5kIG90aGVyDQpwYXRjaGVzLCBvciBpdCB3aWxsIHN0YXJ0IGFmdGVyIHBhdGNoIDEgcmV2
aWV3IGlzIGZpbmlzaGVkPw0KDQptYW55IHRoYW5rcy4NCg==
