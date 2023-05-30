Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8633A715876
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjE3I1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjE3I11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:27:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1906A8;
        Tue, 30 May 2023 01:27:19 -0700 (PDT)
X-UUID: c8a4d9cafec311edb20a276fd37b9834-20230530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZO4xO7HVjiL/Wv8vGh5zHUpd50lA+4KhM9sRZVXu5MY=;
        b=PHKgzdSpOrZMUK2IK40w9o+TGNwNwLTeCuVK7hPVGUypZQuswYY/3L+vMY7dF4NFTrAwldKH3KtMpMSSpeIUgVBuVfmWJwbafkKPkDgjLIe0mb8J76j+ZL/j3ThF8nQIpD3LEdcAvCsXrNQUg06PJRtFOosRAaTBmf4S7mDrEcQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:7377cd00-c745-48fb-bb5d-3a3317b2f63e,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.25,REQID:7377cd00-c745-48fb-bb5d-3a3317b2f63e,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:d5b0ae3,CLOUDID:de4f706d-2f20-4998-991c-3b78627e4938,B
        ulkID:230530162716YS1AMWLZ,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
        SA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: c8a4d9cafec311edb20a276fd37b9834-20230530
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1429937000; Tue, 30 May 2023 16:27:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 16:27:14 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 May 2023 16:27:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeUpQ6hsKBlBnmynPI6SohjbUWDl5hEHcDEKafps5FKmXopMGYhxErNAQp5SkKmDawC07NO6va0Czo0BrjQ7xSumh6TXM5L6MiV6YSv7ND8pn5R5jyYnEFyyiBziJ4uxsiGt3fnlaRU69yDq5Gf9QmuJyDWeCXCYIvDEIVyApSTq6UVr6KoVBNFblPOeBfl9bEy6YYaLmUrKMD2Q0dytSooelTpJt9oQTAykg88Qzyukv5ig9yT7M1bD03Ig6qG4enWEOkVAGONm2JFc8dF8mBm9c2kpq3VyHSSQs9izdPT8KD+LzaZTz2Sw8oxevIzg9x9C3d6jV2xNh2Q/YaKtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO4xO7HVjiL/Wv8vGh5zHUpd50lA+4KhM9sRZVXu5MY=;
 b=Dk3ZNq2khnRzsLeN1fBnGU8wll3CLKoLJ5m7k9dPnmtRYCN0j51curvPzx7eAt4tonEC590WF+kDcXRPNUc/y/hoS08kfStMVv1+pWkCbmb4+emKRiHiC1WTuDesMP15PKef/Hbx64xykUzgaG77Hztc3imPmC6aL8bNN+fg/FRVCMEo9TcV4blmLx1xORcN5P0Z/XLCffztSFX2FbvRZ4Muq8COZ5WfyzQKFxr1moa3RVV3k9/oYRAg1MvuUs0fpWDMr2em0lFcdNAUV0QS35yytq3J/OXPFgHHdypyxwO1deHIq97Xc3rTtwGmBydxmQlzAWEDBG39njBMCbOA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO4xO7HVjiL/Wv8vGh5zHUpd50lA+4KhM9sRZVXu5MY=;
 b=pSUOJ8nJAy7moBo1JVQypMvby3Er6BZUwQ+oQ+zfapSLuoDjFTBmDFnmILq6yNK5B2NJ7MS7WeT9/Sw0KIK2PBkZU4LIFrTSpJv/XYYqGVfHaLdwmt90kb0776/rWzGhBF+gXrzcQmOahfEPjj2kypDcGYLCzxUY9cN+M0eL0mk=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB5616.apcprd03.prod.outlook.com (2603:1096:400:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 08:27:12 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::506f:2b56:e564:ba5a]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::506f:2b56:e564:ba5a%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 08:27:11 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v5,0/8] media: mediatek: vcodec: Add debugfs file for
 decode and encode
Thread-Topic: [PATCH v5,0/8] media: mediatek: vcodec: Add debugfs file for
 decode and encode
Thread-Index: AQHZks9EZPVNcdUHHEmgZ5cVA+owya9ye28A
Date:   Tue, 30 May 2023 08:27:11 +0000
Message-ID: <ec8c0113aff833aa7de746843e8e4b4294b7ea8e.camel@mediatek.com>
References: <20230525021219.23638-1-yunfei.dong@mediatek.com>
In-Reply-To: <20230525021219.23638-1-yunfei.dong@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB5616:EE_
x-ms-office365-filtering-correlation-id: 59ef85ab-da3f-4232-4047-08db60e7aa60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pv7aqsMFp2PxWwUrj6khXDgNs2eUnO+gXxYCqDosSSffSsGUQlizpWkUIuxO9puDgrjthjx1k5gaCCqW/HkOdsB20aGuCNfwUF3CqatJRcvzJsMZWYUsVAUzWUG6juuLyF74x2nkFoiJUGpaNtf9cM93oRrRy2RIvKuhmwH1yg+fI/4VUTTaJiYO2aE30olEiyDEFP2g9f8nmNg1VNxnuPBU3YmuoRENFnIPJE8WyObFHE2gW2h+x7voe7BghZPZ8coCWDeyyyS30CXM6jEz06sDTEtA5fAQOlkudVUzSaLsn4D6/WrtXwfZ4Ln+fFoQZ9M8I6d+2lpipZYK5fkFTcXihh5aBljGSziJoaMPCGUcmTeX39HaTCd5Daq57H4At4QuGas0ZxdTk9UdQ77kpDsknRwQLEZk8tF39bDViSBjqjKIerr4ts+HXkEKBJO5CJ6wi08qBPso6Yb6yrAIQMD5sZf61YvEnj/aX2e5p77Y1IgG7MCtQLp8hAUvtSkIqp8OkUV9Ri7Pc0twa62eQxC0nSdumHgFpEsX4pclSY+kcF/7U+gvsrLZUt6PR68un35eCwfWYskYXmSCc82E7EONtNwlE4Wh7PGFIO3qH+aG6qm+0d4mxfrC0vf9umDMfA/v4AMc4ywo8DBTQhfwYtEeKGTVXw7hsm1erUKI+JH0HsMgczQim5H90glIqdNZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(186003)(2616005)(38100700002)(41300700001)(83380400001)(6512007)(6506007)(26005)(6486002)(478600001)(54906003)(71200400001)(4326008)(6916009)(66476007)(76116006)(66946007)(122000001)(66446008)(64756008)(66556008)(91956017)(316002)(5660300002)(8936002)(8676002)(7416002)(2906002)(86362001)(38070700005)(85182001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG1sSFUyUXdjRGRwaU5pRlp2a25HZWtPb1JJTHgvYzV1UDBzTGdhYnplTlgz?=
 =?utf-8?B?ejVWNkRYTXRDYUhnZ2hyQVFFYnVBOUZRUVdYOUZ5cElqZ2FPODFGeE9ZcVUv?=
 =?utf-8?B?TEt3bWFDZHVXREN2OEUwZ2MzRitqRzBiakt2d2VYQUJibXBCMXhKbE53T0I1?=
 =?utf-8?B?YjVIeFgraWh2V1hVVXVrcDVza3Z4U3ZWSUJZWUYyZDBpWWVob0RFNjBkc1Rh?=
 =?utf-8?B?b1V5YmNUTnk0Umlld2Nac0hza0pYTHFucVpFVDIrUE1ZV0VXY2h5VUxONlp6?=
 =?utf-8?B?elMwVjhvdGNmT3JoRkRaYmJRa20wYW9KNTh1dVh3cGlyY2l2bVpMUGwrTHFR?=
 =?utf-8?B?ZkhpWGtzZmdGN0JFR2xOanlSNGg5Q0JBamhHcnBqOTIvOXVYVENkcG5paXVM?=
 =?utf-8?B?Y00vNHd3SmM5cnIwVnVOZ2hMRG9WZWR5S29pNlJ5ZDJ6UVg3RjQ4N0tISDZU?=
 =?utf-8?B?a0hJRG13UUNqdk9hT3liMDRZZlhISzRBYkZrTjFKajdFVlJxN0Frc0R5YjV2?=
 =?utf-8?B?c1EyUExwTmppZTZENWw2d3pDdWFFS1YrdGVQaFlraTI0emxkM2RtekpzL3R5?=
 =?utf-8?B?bXBUaVU2SkF2clhYMC9mMkZNTk4zbEZoOENwVVMxSW9mbUZuWHZUc29paUNX?=
 =?utf-8?B?NmhqcCtTcVN0THNpQW9HN3UzNjdaQnpEZ2ZMVDhrTzFNV3ErZmRMTDk2YVlT?=
 =?utf-8?B?R1g2aTRncTkxRjZTVW5rZDBKdmVQQVNVTjMrMjNjakNWc3dObzRIdEtxTHhT?=
 =?utf-8?B?cy85M3UyQUs5OWpWYTlkQ1BQckZaVTVuYWZYLzFpQmpFV2hYbHJyWm9kZDN2?=
 =?utf-8?B?T2NORmxhSDQrVmlWTzBLUXpUZERaakdmRHpwQUZhUlR3aDhSV3RVclIvZzlB?=
 =?utf-8?B?eXp0OHpLTDJCUlhEc2xNYUx5bzc2TDZRcURxSmxMUDlJM25qbWZmeFNmRDBB?=
 =?utf-8?B?eDNvck5aUGpwaVUzMG45eGJTN3ZaV2JMUG9iWk1NOGJhZENNNzQyU3FzR1Fp?=
 =?utf-8?B?NWFSc3dncU8xZVpPZlBEUi9vaDcyZ1NyVktwZFlDK2ovb3p0NEoxNVQzenVU?=
 =?utf-8?B?VFA1RGJ5VUltNXZhOWljcUdvZDJmMFF1N3EydGJEZldzZGNzQUg4NUMxVkFp?=
 =?utf-8?B?RTV0M21Fd1JSU1JFSFhnNWpuNW5vRjhJNGFDN0EwMkkzWTFmVmpmZTVna2hv?=
 =?utf-8?B?bm4rbEhaeUlGbXVuV0lobUU5NjY1aTYwVFRQMzdkeW5mY2daTnhqY2ROSnVy?=
 =?utf-8?B?WnBwRDI0YjN0b3lleGNjZnQyRTBaNDBzSTV1eXA5c0wyVkFrQS9oTGI4Q1ZP?=
 =?utf-8?B?WmZTbEo3NW8ybWVmcVBLMGhuVEt1U2JFNmxIcjlkS0xIbGp0L0Z6ODl2RjMv?=
 =?utf-8?B?cGxpbFpKbWt1RTVTU0NRYkZPelpEcVJQVUxreEJCSGZBVXhpNy9HbGlOL1Nu?=
 =?utf-8?B?RXByQ29GVXRQekpGaTVDTnFrM0VBeFFFNEJuTGQ1RVRlVExzc3N5ZEtrYUhu?=
 =?utf-8?B?TmxXZGtVU0Zhb0hrODJJK3hsdmgzNmhsU2F6OVl1enNvcml0d1N3bW1oWm9Y?=
 =?utf-8?B?WjY0ZWxoNk5odW81enlEcld6STQvTHJnN1lEM1VseUpUamtZM1BBWGJWV1M1?=
 =?utf-8?B?T0pBUlJOaUQ0WDdpeUpVbmFrSk92SUtiSDY1dEFWSjFNWnZjQlRBT3FSSFRE?=
 =?utf-8?B?aDZqeVdwSlpadldYTTUvOExVci9Xa0xDNGFFTzZzaGM1eVJYbHpYNUJwbzI5?=
 =?utf-8?B?NU9Wcm9uZjhLdnluTkp0OEhySFhxY1JYNnd2bHhHb0JsV3hIb2F3WGY5QlFn?=
 =?utf-8?B?aWhtQ0ZlTXIveGY1T1dHeUkxKzVod2lRSFA3L0JoMzRCZHlHTzM4cURTdXgz?=
 =?utf-8?B?L0ZsVnlWRmY4aUxPcGtnSEI5UnB0dGtLTXRjL3ZJQnlEaXowTmZ1Zk9RWS9v?=
 =?utf-8?B?UVo2bG0rQTFpbEExc2l5cGoxTi9DWUNXN0k3UCs3WlRnMWYxUXM2YU1iVG5Z?=
 =?utf-8?B?dXdiOU9HczB6cElFNlk3OEowYThYV25UdVlHeTNLRlBkVEtCczZ2eUVwK3B2?=
 =?utf-8?B?eFhyWjBnZWtQaCtKUzBBOHR4OUxXNWEyMFR2ZVhhU3J2d2xNSGxHVTVMd1Zi?=
 =?utf-8?B?S2liMWhEZmVLek1DeHpWcnZCZG1IZC95b2ptb3M2dG9aTWpVRkFiaFFTT2pv?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F39DC5D1AE09D48980E0C5AC0550B1A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ef85ab-da3f-4232-4047-08db60e7aa60
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 08:27:11.4672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TD/jJ7AQVYebTDmGNqoKu9IJosYek8tsXspOHhNzteOGaChFV/LkSlCQUCs0RBt7Wi8B+/td1naMid13U2n2K5DYIy/Pb2RyV/8v/dFlMNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5616
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KU29ycnkgdG8gZGlzdHVyYiB5b3UuDQoNCkNvdWxkIHlvdSBwbGVhc2UgaGVs
cCB0byByZXZpZXcgYW5kIGFwcGx5IHRoaXMgcGF0Y2ggc2VyaWVzIGlmIGl0IGlzIG9rDQpmb3Ig
eW91PyBPciB3aG9zZSByZXZpZXcgaXMgZXhwZWN0ZWQgYmVmb3JlIHlvdSBjYW4gYXBwbHk/DQoN
CkJlc3QgUmVnYXJkcywNCll1bmZlaSBEb25nDQoNCk9uIFRodSwgMjAyMy0wNS0yNSBhdCAxMDox
MiArMDgwMCwgWXVuZmVpIERvbmcgd3JvdGU6DQo+IE5lZWQgdG8gY2hhbmdlIGtlcm5lbCBkcml2
ZXIgdG8gb3BlbiBkZWNvZGUgYW5kIGVuY29kZSBkZWJ1ZyBsb2cgYXQNCj4gY3VycmVudCBwZXJp
b2QsDQo+IGl0J3MgdmVyeSB1bnJlYXNvbmFibGUuIEFkZGluZyBkZWJ1Z2ZzIGNvbW1vbiBpbnRl
cmZhY2UgdG8gc3VwcG9ydA0KPiBkZWNvZGUgYW5kIGVuY29kZSwNCj4gdXNpbmcgZWNobyBjb21t
YW5kIHRvIGNvbnRyb2wgZGVidWcgbG9nIGxldmVsIGFuZCBnZXR0aW5nIHVzZWZ1bA0KPiBpbmZv
cm1hdGlvbiBmb3IgZWFjaA0KPiBpbnN0YW5jZS4NCj4gDQo+IHBhdGNoIDEgYWRkIGRiZ2ZzIGNv
bW1vbiBpbnRlcmZhY2UuDQo+IHBhdGNoIDJ+NSBzdXBwb3J0IGRlY29kZS4NCj4gcGF0Y2ggNn43
IHN1cHBvcnQgZW5jb2RlDQo+IHBhdGNoIDggYWRkIGhlbHAgZnVuY3Rpb24NCj4gLS0tDQo+IGNo
YW5nZWQgd2l0aCB2NDoNCj4gLSByZWJhc2UgdG8gdGhlIHRvcCBvZiBtZWRpYSBzdGFnZSBoZWFk
ZXIuDQo+IA0KPiBjaGFuZ2VkIHdpdGggdjM6DQo+IC0gYWRkIGhlbHAgZnVuY3Rpb24gZm9yIHBh
dGNoIDgNCj4gLSByZW1vdmUgYXBwZW5kICdcMCcgYW5kIGVubGFyZ2UgYnVmZmVyIHNpemUgZm9y
IHBhdGNoIDQNCj4gDQo+IGNoYW5nZWQgd2l0aCB2MjoNCj4gLSB1c2luZyBwcl9kZWJ1ZyBhbmQg
ZGV2X2RiZyBpbnN0ZWFkIG9mIHByX2luZm8gZm9yIHBhdGNoIDIuDQo+IC0gZml4IHdvcmQgZmFp
bDogaW5mb3JtYXRpYW9pbiAtPiBpbmZvcm1hdGlvbiBmb3IgcGF0Y2ggMy4NCj4gLSB1c2VkIHRv
IHByaW50IGVhY2ggaW5zdGFuY2UgZm9ybWF0IGluZm9ybWF0aW9uIGZvciBwYXRjaCA1Lg0KPiAN
Cj4gY2hhbmdlZCB3aXRoIHYxOg0KPiAtIGFkZCBuZXcgcGF0Y2ggNCBhbmQgNS4NCj4gLSB1c2lu
ZyBjbWQgJ2NhdCB2ZGVjJyB0byBzaG93IGRlYnVnIGluZm9ybWF0aW9uIGluc3RlYWQgb2YgcHJf
aW5mbw0KPiBkaXJlY3RseS4NCj4gLS0tDQo+IFl1bmZlaSBEb25nICg4KToNCj4gICBtZWRpYTog
bWVkaWF0ZWs6IHZjb2RlYzogQWRkIGRlYnVnZnMgaW50ZXJmYWNlIHRvIGdldCBkZWJ1Zw0KPiAg
ICAgaW5mb3JtYXRpb24NCj4gICBtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogQWRkIGRlYnVnIHBh
cmFtcyB0byBjb250cm9sIGRpZmZlcmVudCBsb2cNCj4gICAgIGxldmVsDQo+ICAgbWVkaWE6IG1l
ZGlhdGVrOiB2Y29kZWM6IEFkZCBhIGRlYnVnZnMgZmlsZSB0byBnZXQgZGlmZmVyZW50IHVzZWZ1
bA0KPiAgICAgaW5mb3JtYXRpb24NCj4gICBtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogR2V0IGVh
Y2ggY29udGV4dCByZXNvbHV0aW9uIGluZm9ybWF0aW9uDQo+ICAgbWVkaWE6IG1lZGlhdGVrOiB2
Y29kZWM6IEdldCBlYWNoIGluc3RhbmNlIGZvcm1hdCB0eXBlDQo+ICAgbWVkaWE6IG1lZGlhdGVr
OiB2Y29kZWM6IENoYW5nZSBkYmdmcyBpbnRlcmZhY2UgdG8gc3VwcG9ydCBlbmNvZGUNCj4gICBt
ZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogQWRkIGVuY29kZSB0byBzdXBwb3J0IGRiZ2ZzDQo+ICAg
bWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IEFkZCBkYmdmcyBoZWxwIGZ1bmN0aW9uDQo+IA0KPiAg
Li4uL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9NYWtlZmlsZSAgIHwgICA2ICsNCj4g
IC4uLi9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kYmdmcy5jICAgICAgICB8IDIxNg0KPiAr
KysrKysrKysrKysrKysrKysNCj4gIC4uLi9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kYmdm
cy5oICAgICAgICB8ICA3MiArKysrKysNCj4gIC4uLi9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2Rl
Y19kZWNfZHJ2LmMgICAgICB8ICAgNCArDQo+ICAuLi4vcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVj
L210a192Y29kZWNfZHJ2LmggfCAgIDQgKw0KPiAgLi4uL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNv
ZGVjX2VuY19kcnYuYyAgICAgIHwgICAyICsNCj4gIC4uLi9tZWRpYXRlay92Y29kZWMvbXRrX3Zj
b2RlY191dGlsLmMgICAgICAgICB8ICAgOCArDQo+ICAuLi4vbWVkaWF0ZWsvdmNvZGVjL210a192
Y29kZWNfdXRpbC5oICAgICAgICAgfCAgMjYgKystDQo+ICA4IGZpbGVzIGNoYW5nZWQsIDMzNSBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IGRy
aXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGJnZnMuYw0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsv
dmNvZGVjL210a192Y29kZWNfZGJnZnMuaA0KPiANCg==
